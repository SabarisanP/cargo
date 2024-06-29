<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Analytics extends MY_Controller {

    function __construct() {
        parent::__construct();
        set_time_limit(0);
    }

    public function index() {
        $this->is_logged_in();
        
//        _include_js('assets/lib/highcharts/highcharts.js');
//        _include_js('assets/lib/highcharts/exporting.js');
//        _include_js('assets/lib/highcharts/highcharts-more.js');
//        _include_js('assets/lib/highcharts/drilldown.js');
        
        _include_js('assets/js/pages/analytics.js', '_init_analytics');
        
//        if(!has_action_rights('ANALYTICS-DASHBOARD')) {
//            redirect('/');
//        }
        $data = array();        
        $data['active_schedules'] = get_active_schedules();    
        
        $param = array(
            'queryCode' => 'RQG27E484',
            'fromDate' => date('Y-m-d'),
            'toDate' => date('Y-m-d')                
        );
        $result = $this->api_model->getDynamicReportDataWithMap($param);              
        $result = json_decode($result);
                
        $feeds = array();
        foreach ($result->data as $entity) {
          $feeds[$entity->schedule_code][$entity->trip_code][$entity->attribute_type] =   $entity->attribute_value; 
        }
        
        $info = array(
            't_trips'=>0, 
            't_seats'=>0,
            't_booked_seats' => 0,
            't_pbooked_seats' => 0,
            't_vacant_seats' => 0,
            't_booked_amount' => 0,
            't_cancel_revnue' => 0, 
            'occupancy' => 0, 
            't_commission' => 0
        );
        
        foreach ($feeds as $sch) {
            foreach ($sch as $trip) {
              $info['t_trips']++;
              $info['t_seats'] += $trip['TRIP_ST_CNT'];
              $grps = explode(',', $trip['GR_LIST']);
              foreach($grps as $k=>$grp){
                  $grp = _strip_space($grp);
                  $info['t_booked_seats'] += $trip['BO_COUNT_'.$grp];
                  $info['t_pbooked_seats'] += $trip['PH_COUNT_'.$grp];
                  
                  $info['t_booked_amount'] += $trip['BO_AMT_'.$grp];
              }
            }
        }
        $info['t_vacant_seats'] = $info['t_seats'] - ( $info['t_booked_seats'] + $info['t_pbooked_seats'] );
        $info['occupancy'] = ceil( ( ( $info['t_booked_seats'] + $info['t_pbooked_seats'] ) / $info['t_seats']) * 100 );
        
        $data['today_occupancy'] = $info;
        
        $this->load->view('site/analytics/index', $data);        
        
    }
    
    function trip_analytics() {
        $this->is_logged_in();  
//        if(!has_action_rights('ANALYTICS-DASHBOARD')) {
//            redirect('/');
//        }
        $data = array();
        
        $ns_id = $this->session->userdata('namespace_id');
                
        $from_date = $this->input->post('m_from');
        $to_date = $this->input->post('m_to');
        
        $schedule = $this->input->post('sch_code');
        //$group_by = $this->input->post('group_by');
        
//        $from_date = '2016-01-01';
//        $to_date = '2016-01-03';
                
        $key = 'analytics_'.$ns_id.'_RQG27E484_'.$from_date.'_'.$to_date;
        
        $param = array(
            'queryCode' => 'RQG27E484',
            'fromDate' => $from_date,
            'toDate' => $to_date                
        );
                
        if( !$result = $this->cache->file->get($key) ) {            
            $result = $this->api_model->getDynamicReportDataWithMap($param);            
            $this->cache->file->save($key, $result, 10800); //  3 hours
        }              
        $result = json_decode($result);        
        
        $feeds = array();
        foreach ($result->data as $entity) {
            if($schedule !="" && $entity->schedule_code != $schedule) { //  schedule filter
                continue;
            }            
            $feeds[$entity->schedule_code][$entity->trip_code][$entity->attribute_type] = $entity->attribute_value;            
        }
        
        $info = array();
        foreach ($feeds as $sch_code => $sch) {
            foreach ($sch as $trip_code => $trip) {
              
              $info[$sch_code]['t_seats'] += $trip['TRIP_ST_CNT'];
              $info[$sch_code]['route'] = $trip['TRIP_ROUTE'];
              $info[$sch_code]['bus_type'] = $trip['TRIP_BUS_TYPE'];
              
              $grps = explode(',', $trip['GR_LIST']);
              $t = array();
              $b_seats = 0;
              foreach($grps as $k=>$grp){
                  
                $grpt = _strip_space($grp); 
                $b_seats += ($trip['BO_COUNT_'.$grpt] + $trip['PH_COUNT_'.$grpt]);
                  
                $info[$sch_code]['booking'][$grp]['seats'] += ($trip['BO_COUNT_'.$grpt] + $trip['PH_COUNT_'.$grpt]);
                $info[$sch_code]['booking'][$grp]['amount'] += $trip['BO_AMT_'.$grpt];
                         
                 
              }              
              $info[$sch_code]['t_booked_seats'] += $b_seats;
              $info[$sch_code]['occupancy'] = ceil( ( $info[$sch_code]['t_booked_seats'] / $info[$sch_code]['t_seats'] ) * 100 ); 
                            
            }
            $a_temp[] = $info[$sch_code]['occupancy'];
        }
        array_multisort($a_temp, SORT_DESC, $info);
        
        $cumulative = array();
        foreach($info as $sch_code => $sch) {
            $cumulative['seats'] += $info[$sch_code]['t_seats'];
            foreach ($sch['booking'] as $grp => $grpdet) {
                $cumulative['booking'][$grp]['seats'] += $grpdet['seats'];
                $cumulative['booking'][$grp]['amount'] += $grpdet['amount'];
            }
        }
        
        $data['status'] = ( count($info) > 0 ) ? 1 : 0;
        $data['info'] = $info;
        $data['cumulative'] = $cumulative;
        echo json_encode($data);
    }

    public function collections_by_branch() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code] = $branch->name;
        }
        //asort($organization);
        $data['branches'] = $organization;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/analytics/collections-by-branch', $data);
    }

    public function collections_by_branch_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQK8AJG62',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate'),
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'organizationCode' => $this->input->post('organizationCode')
        );

        $p_key = _get_namespace_id().'_collections_by_branch_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);

        $summary = [];
        foreach ($result->data as $row) {
            if (!isset($summary[$row->organization_code])) {
                $summary[$row->organization_code] = (object)[];
            }
            $summ = $summary[$row->organization_code];
            $summ->organization_name = $row->organization_name;
            $summ->pickup_handling_amount += $row->pickup_handling_amount;
            $summ->cargo_count += $row->cargo_count;
            $summ->total_paid_amount += $row->total_paid_amount;
            $summ->pod_charge += $row->pod_charge;
            $summ->other_charges_amount += $row->other_charges_amount;
            $summ->delivery_handling_amount += $row->delivery_handling_amount;
            $summ->pass_charge += $row->pass_charge;
            $summ->total_item_count += $row->total_item_count;
            $summ->total_handling_amount += $row->total_handling_amount;
            $summ->service_charge += $row->service_charge;
            $summ->total_unload_handling_amount += $row->total_unload_handling_amount;
            $summ->delivery_commission_amount += $row->delivery_commission_amount;
            $summ->service_tax += $row->service_tax;
            $summ->hamali_charge += $row->hamali_charge;
            $summ->docket_charge += $row->docket_charge;
            $summ->booked_date += $row->booked_date;
            $summ->total_on_account_amount += $row->total_on_account_amount;
            $summ->booking_commission_amount += $row->booking_commission_amount;
            $summ->total_topay_amount += $row->total_topay_amount;
            $summ->total_other_charges += $row->service_charge + $row->service_tax + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->other_charges_amount;
        }

        usort($summary, function($a, $b) {
            return strnatcasecmp(trim($a->organization_name), trim($b->organization_name));
        });

        $data['summary'] = $summary;

        if ($this->input->post('export') != 1) {
            $branchwise = [];
            $branchdatewise = [];
            foreach ($result->data as $row) {
                $branch = $row->organization_code;                
                $total_other_charges = $row->service_charge + $row->service_tax + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->other_charges_amount;
                if (!isset($branchwise[$branch])) {
                    $branchwise[$branch] = (object)[];
                }
                $summ = $branchwise[$branch];
                $summ->name = $row->organization_name;
                $summ->drilldown = $row->organization_code;
                $summ->total_paid_amount += $row->total_paid_amount;
                $summ->total_topay_amount += $row->total_topay_amount;
                $summ->total_on_account_amount += $row->total_on_account_amount;
                $summ->total_other_charges += $total_other_charges;
                $summ->y += $total_other_charges + $row->total_paid_amount + $row->total_topay_amount + $row->total_on_account_amount;

                $branchdatewise[$branch] = $branchdatewise[$branch] ?: (object)[];
                $summ = $branchdatewise[$branch];
                $summ->id = $row->organization_code;
                $summ->name = $row->organization_name;
                $summ->type = 'column';
                $summ->data = $summ->data ?: [];

                if (!isset($summ->data[$row->booked_date])) {
                    $summ->data[$row->booked_date] = (object)[];
                }
                $summ = $summ->data[$row->booked_date];
                $summ->name = date('d-m-Y', strtotime($row->booked_date));
                $summ->total_paid_amount += $row->total_paid_amount;
                $summ->total_topay_amount += $row->total_topay_amount;
                $summ->total_on_account_amount += $row->total_on_account_amount;
                $summ->total_other_charges += $total_other_charges;
                $summ->y += $total_other_charges + $row->total_paid_amount + $row->total_topay_amount + $row->total_on_account_amount;
            }

            foreach ($branchdatewise as $k => $row) {
                $branchdatewise[$k]->data = array_values($branchdatewise[$k]->data);
            }
            $data['branchwise'] = array_values($branchwise);
            $data['branchdatewise'] = array_values($branchdatewise);
        }

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/analytics/collections-by-branch-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Collections By Branch.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        }
        else {
            $this->load->view('site/analytics/collections-by-branch-list', $data);
        }
    }

    public function sales_by_branch() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code] = $branch->name;
        }
        asort($organization);
        $data['branches'] = $organization;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/analytics/sales-by-branch', $data);
    }

    public function sales_by_branch_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQK8AJF61',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate'),
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'organizationCode' => $this->input->post('organizationCode')
        );

        $p_key = _get_namespace_id().'_sales_by_branch_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);

        $summary = [];
        foreach ($result->data as $row) {
            if (!isset($summary[$row->organization_code])) {
                $summary[$row->organization_code] = (object)[];
            }
            $summ = $summary[$row->organization_code];
            $summ->organization_name = $row->organization_name;
            $summ->pickup_handling_amount += $row->pickup_handling_amount;
            $summ->cargo_count += $row->cargo_count;
            $summ->total_paid_amount += $row->total_paid_amount;
            $summ->pod_charge += $row->pod_charge;
            $summ->other_charges_amount += $row->other_charges_amount;
            $summ->delivery_handling_amount += $row->delivery_handling_amount;
            $summ->pass_charge += $row->pass_charge;
            $summ->total_item_count += $row->total_item_count;
            $summ->total_handling_amount += $row->total_handling_amount;
            $summ->service_charge += $row->service_charge;
            $summ->total_unload_handling_amount += $row->total_unload_handling_amount;
            $summ->delivery_commission_amount += $row->delivery_commission_amount;
            $summ->service_tax += $row->service_tax;
            $summ->hamali_charge += $row->hamali_charge;
            $summ->docket_charge += $row->docket_charge;
            $summ->booked_date += $row->booked_date;
            $summ->total_on_account_amount += $row->total_on_account_amount;
            $summ->booking_commission_amount += $row->booking_commission_amount;
            $summ->total_topay_amount += $row->total_topay_amount;
            $summ->total_other_charges += $row->service_charge + $row->service_tax + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->other_charges_amount;
        }

        usort($summary, function($a, $b) {
            return strnatcasecmp(trim($a->organization_name), trim($b->organization_name));
        });

        $data['summary'] = $summary;

        if ($this->input->post('export') != 1) {
            $branchwise = [];
            $branchdatewise = [];
            foreach ($result->data as $row) {
                $branch = $row->organization_code;                
                $total_other_charges = $row->service_charge + $row->service_tax + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->other_charges_amount;
                if (!isset($branchwise[$branch])) {
                    $branchwise[$branch] = (object)[];
                }
                $summ = $branchwise[$branch];
                $summ->name = $row->organization_name;
                $summ->drilldown = $row->organization_code;
                $summ->total_paid_amount += $row->total_paid_amount;
                $summ->total_topay_amount += $row->total_topay_amount;
                $summ->total_on_account_amount += $row->total_on_account_amount;
                $summ->total_other_charges += $total_other_charges;
                $summ->y += $total_other_charges + $row->total_paid_amount + $row->total_topay_amount + $row->total_on_account_amount;

                $branchdatewise[$branch] = $branchdatewise[$branch] ?: (object)[];
                $summ = $branchdatewise[$branch];
                $summ->id = $row->organization_code;
                $summ->name = $row->organization_name;
                $summ->type = 'column';
                $summ->data = $summ->data ?: [];

                if (!isset($summ->data[$row->booked_date])) {
                    $summ->data[$row->booked_date] = (object)[];
                }
                $summ = $summ->data[$row->booked_date];
                $summ->name = date('d-m-Y', strtotime($row->booked_date));
                $summ->total_paid_amount += $row->total_paid_amount;
                $summ->total_topay_amount += $row->total_topay_amount;
                $summ->total_on_account_amount += $row->total_on_account_amount;
                $summ->total_other_charges += $total_other_charges;
                $summ->y += $total_other_charges + $row->total_paid_amount + $row->total_topay_amount + $row->total_on_account_amount;
            }

            foreach ($branchdatewise as $k => $row) {
                $branchdatewise[$k]->data = array_values($branchdatewise[$k]->data);
            }
            $data['branchwise'] = array_values($branchwise);
            $data['branchdatewise'] = array_values($branchdatewise);
        }

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/analytics/sales-by-branch-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Sales By Branch.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        }
        else {
            $this->load->view('site/analytics/sales-by-branch-list', $data);
        }
    }
}

?>
