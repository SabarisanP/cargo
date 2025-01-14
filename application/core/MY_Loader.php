<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

require 'vendor/autoload.php';

class MY_Loader extends CI_Loader {

    var $template = '';
    var $data = array();
    var $return = FALSE;
    var $template_loaded;
    var $css_files = array();
    var $js_files = array();
    var $admin_site = false;

    function set_admin_site($val) {
        $this->admin_site = (bool) $val;
        return true;
    }
    
    function exclude_template() {
        $this->template_loaded = true;
    }

    /**
     * Checks if a template has already been loaded and then either loads the view directly or puts it inside 
     * the template and loads it with the view.
     * 
     * @see /system/libraries/CI_Loader#view($view, $vars, $return)
     */
    function view($view, $vars = array(), $return = FALSE) {
        $ci = & get_instance();
        $is_ajax = $ci->input->is_ajax_request();	
		
        $data = $this->_ci_object_to_array($vars);
        // adds the template $data 
        /*if (count($this->data) > 0) {
                foreach ($this->data as $key => $value) {
                        $data[$key] = $value;
                }
        }*/
        //	merge global view variables
        $data = array_merge($data, $this->_ci_cached_vars);

        if( !empty($view) ) {
            // Add extension to the filename if it's not there.
            $ext = '.' . ltrim(config_item('smarty_template_ext'), '.');
            if (substr($view, -strlen($ext)) !== $ext) 	{
                            $view .= $ext;
            }
			
            // Make sure the file exists first.
            if ( !$ci->smarty->templateExists($view)) {
                    show_error('Unable to load the view file: ' . $view);
            }
        }

        $ci->smarty->assign($data);
        //	assign page view	
        $ci->smarty->assign('page_body', $view);
        $ci->smarty->assign('base_url', base_url() );
        $ci->smarty->assign('is_logged_in', $ci->session->userdata('user_id') != '' ? 1 : 0 );
        $ci->smarty->assign('namespace', $ci->session->userdata('namespace_id'));
        $ci->smarty->assign('native_namespace', $ci->session->userdata('native_namespace_code'));
        $ci->smarty->assign('namespace_name', ucfirst($ci->session->userdata('namespace_name')));
        $ci->smarty->assign('current_product_name', $ci->session->userdata('product'));
        $ci->smarty->assign('usr_login_name', $ci->session->userdata('user_name'));
        $ci->smarty->assign('usr_login_id', $ci->session->userdata('user_id'));
        $ci->smarty->assign('usr_group_id', $ci->session->userdata('group_id'));
        $ci->smarty->assign('native_usr_login_id', $ci->session->userdata('native_user_id'));
        $ci->smarty->assign('native_usr_login_name', $ci->session->userdata('native_user_name'));
        $ci->smarty->assign('time_format', $ci->session->userdata('time_format'));
        $ci->smarty->assign('date_format', $ci->session->userdata('date_format'));
        $ci->smarty->assign('login_station', $ci->session->userdata('org_station_code'));
        $ci->smarty->assign('login_branch', $ci->session->userdata('org_code'));
        $ci->smarty->assign('login_branch_name', $ci->session->userdata('org_name'));
        
        if(!preg_match("/agentlogin/i", $ci->session->userdata('referrer')))    //  hide booking portal icon if logged in from Desktop
            $ci->smarty->assign('referrer', $ci->session->userdata('referrer'));
        
        $ci->smarty->assign('ns_date_format', _ns_date_format($ci->session->userdata('date_format')) );
        $ci->smarty->assign('ns_time_format', _ns_time_format($ci->session->userdata('time_format')) );
        $ci->smarty->assign('ns_datetime_format', _ns_date_format($ci->session->userdata('date_format')) .' '. _ns_time_format($ci->session->userdata('time_format')) );
        $ci->smarty->assign('balance', $ci->session->userdata('balance'));
        $ci->smarty->assign('is_admin', _is_admin() );
        $ci->smarty->assign('is_namespace', _is_namespace() );
        $ci->smarty->assign('is_super_namespace', _is_super_namespace( $ci->session->userdata('native_namespace_code')) );
        $ci->smarty->assign('asset_ver', config_item('asset_version') );
        $ci->smarty->assign('environment', config_item('environment') );
        $ci->smarty->assign('pdf_generator_url', config_item('pdf_generator_url'));
        $ci->smarty->assign('web_cdn_url', config_item('web_cdn_url'));
        $ci->smarty->assign('user_assigned_branches', _user_assigned_branches());
        $ci->smarty->assign('proof_document_type', config_item('proof_document_type'));
        $ci->smarty->assign('xlformat', [
            'currency' => '#,##0.00'
        ]);
        
        //$ci->smarty->registerPlugin('modifier','array_min','_array_min');
        //$ci->smarty->registerPlugin('modifier','array_max','_array_max');
        $ci->smarty->registerPlugin('function','formatBusCategory','_bus_category_string');
        //$ci->smarty->assign('page_js', _get_js() );
        
        $page_js = _get_js();
        $js_count = count($page_js);
        $js_html = '';
        if($js_count>0) {
            $js_html = '<script>';
            for($i=0;$i<$js_count;$i++){
                if(!empty($page_js[$i]['callback'])) {
                    $js_html .= 'loadScript("'.$page_js[$i]['file'].'?'.config_item('asset_version').'", '.$page_js[$i]['callback'].');';
                } else {
                   $js_html .= 'loadScript("'.$page_js[$i]['file'].'?'.config_item('asset_version').'");'; 
                }
            }
            $js_html .= '</script>';
        }
        //	for ajax request & not include template
        if ($is_ajax == 1 || $this->template_loaded == TRUE) {			
            if( !empty($view) ) {							
                $output = $ci->smarty->fetch($view);
            }			
        } else {
            //$ci->load->library('assetcache'); 
            //$js_script = $ci->assetcache->js(config_item('js_files'));            
            //$ci->smarty->assign('js_script', $js_script );
            $ci->smarty->assign('js_script', _get_common_js() );
            // this part loads the template
            $template = 'site/template.'.config_item('smarty_template_ext');
            if ($this->admin_site == true)
                $template = 'admin/template.'.config_item('smarty_template_ext');
				
            $output = $ci->smarty->fetch($template);			
        }
        $output.= $js_html;
        // Return the output if the return value is TRUE.
        if ($return === TRUE)	{
            return $output;
        }

        // Otherwise append to output just like a view.
        $ci->output->append_output($output);
    }

    public function excel($view, $vars = array(), $filename = '') {
        try {
            $ci = & get_instance();
            $ci->load->library('PHPExcel_Reader_HTML');
            
            $ci->load->exclude_template();
            $content = $ci->load->view($view, $vars, true);
        
            $htmlreader = new PHPExcel_Reader_HTML();

            $spreadsheet = $htmlreader->loadFromString($content);
            $spreadsheet->getProperties()
                ->setCreator('EzeeInfo')
                ->setLastModifiedBy('EzeeInfo')
                ->setTitle($filename)
                ->setSubject($filename)
                ->setDescription("$filename generated from EzeeCargo. www.ezeecargo.com")
                ->setKeywords('EzeeCargo')
                ->setCategory('EzeeCargo Report')
                ->setCompany('EzeeInfo Cloud Solutions Pvt Ltd');

            $activeSheet = $spreadsheet->getActiveSheet();
            $activeSheet->setTitle('Report');

            $colHigh = $activeSheet->getHighestDataColumn();
            foreach (range('A', $colHigh) as $columnID) {
                $activeSheet->getColumnDimension($columnID)->setAutoSize(true);
            }

            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            header("Content-Disposition: attachment;filename=$filename.xlsx");
            header('Cache-Control: max-age=0');

            $writer = new \PhpOffice\PhpSpreadsheet\Writer\Xlsx($spreadsheet);
            $writer->save('php://output');
        } catch (\Throwable $e) {
            logger('excel-log.txt', array(
                'NsCode' => $ci->session->userdata('namespace_id'),
                'NativeNs' => $ci->session->userdata('native_namespace_code'),
                'UserName' => $ci->session->userdata('user_name'),
                'UserCode' => $ci->session->userdata('user_id'),
                'Error' => $e->getTraceAsString()
            ), true);
        }
    }
    public function excelByArrays($tables = array(), $filename = '') {
        try{
            $ci = &get_instance();
            // Create Excel object
            $objPHPExcel = new PHPExcel();
            $objPHPExcel->setActiveSheetIndex(0);
            $objPHPExcel->getActiveSheet()->setTitle($filename);

            // Initialize row counter
            $row = 1;

            // Loop through tables
            foreach ($tables as $table) {
                // // Set table title
                // $objPHPExcel->getActiveSheet()->setCellValue('A' . $row, $table['title']);
                // $row++;

                // Add data for current table
                foreach ($table as $rowData) {
                    $col = 0;
                    foreach ($rowData as $cellData) {
                        $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow($col, $row, $cellData);
                        $col++;
                    }
                    $row++;
                }

                // Add empty row between tables
                $row++;
            }
            $objPHPExcel->getProperties()
            ->setCreator('EzeeInfo')
            ->setLastModifiedBy('EzeeInfo')
            ->setTitle($filename)
            ->setSubject($filename)
            ->setDescription("$filename generated from EzeeBits. www.ezeebits.com")
            ->setKeywords('EzeeBits')
            ->setCategory('EzeeBits Report')
            ->setCompany('EzeeInfo Cloud Solutions Pvt Ltd');

            // Set headers for download
            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            header("Content-Disposition: attachment;filename=$filename.xlsx");
            header('Cache-Control: max-age=0');

            // Save Excel file to output
            $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
            $objWriter->save('php://output');
        }catch(\Throwable $e){
            logger('excel-log.txt', array(
                'NsCode' => $ci->session->userdata('namespace_id'),
                'NativeNs' => $ci->session->userdata('native_namespace_code'),
                'UserName' => $ci->session->userdata('user_name'),
                'UserCode' => $ci->session->userdata('user_id'),
                'Error' => $e->getTraceAsString()
            ), true);
        }
    }
}
