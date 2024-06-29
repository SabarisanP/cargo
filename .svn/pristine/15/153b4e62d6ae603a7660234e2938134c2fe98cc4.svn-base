<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class widget_cargo extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
        $this->_user_hash = _get_user_hash();
    }
    
    function snapshot(){        
        $this->is_logged_in();
                       
        $param = array(
            'queryCode' => 'RQJ8ODL51',
            'organizationCode' => 'NA',
            'stationCode' => 'NA',
        );

        if (has_action_rights('CGO-VIEW-SAME-BRNCH-LR')) {
            $param['organizationCode'] = $this->session->userdata('org_code');
        } 
        
        if (has_action_rights('CGO-VIEW-SAME-STION-LR')) {
            $param['stationCode'] = $this->session->userdata('org_station_code');
        } 
        
        if (has_action_rights('CGO-VIEW-ALL-LR')) {
            $param['organizationCode'] = 'NA';
        }

        $p_key = _get_namespace_id().'_snapshot_'.md5(http_build_query($param));
        if (!($result = $this->rediscache->get($p_key))) {
            $result = $this->api_model->getDynamicReportDataWithMap($param);
            $this->rediscache->set($p_key, $result, 600); // 5 mins
        } 
        $result = json_decode($result);
        usort($result->data, function($a, $b) {
            return ($b->attribute_value < $a->attribute_value) ? -1 : 1;
        });
        $cnf_pay_type = config_item('cargo_payment_status');        
        
        $feeds = array();
        if($result->status==1) {
            foreach ($result->data as $entity) {
                $t = explode(':', $entity->attribute_type);
                
                if( count($t) == 3 ) {
                    if( strtoupper($t[1]) == "PAYMENT_TYPE" ) {
                        if($entity->attribute_value <= 0) continue; 
                        $feeds[$t[0]][$t[1]][$cnf_pay_type[trim($t[2])]] = $entity->attribute_value; 
                    } elseif(in_array(strtoupper($t[0]), ["TO_LOAD_COUNT", "TO_UNLOAD_COUNT", "INWARDS_COUNT", "TO_DELIVERY_COUNT", "DEMURRAGE_COUNT", "MISSING_COUNT"])) {
                        $feeds[$t[0]][$t[2]]['code'] = trim($t[2]);
                        $feeds[$t[0]][$t[2]]['name'] = trim($t[1]);
                        $feeds[$t[0]][$t[2]]['value'] = $entity->attribute_value;
                        $feeds[$t[0]][$t[2]]['qty'] = $entity->additional_attribute_value;
                    } else {
                        $feeds[$t[0]][$t[1]][trim($t[2])] = $entity->attribute_value; 
                    }
                } else if( count($t) == 2 ) {
                    $feeds[$t[0]][trim($t[1])] = $entity->attribute_value;
                }
            }
            unset($feeds['YESTERDAY']['USER']);
            unset($feeds['YESTERDAY']['STATION']);
            unset($feeds['TODAY']['USER']);
            unset($feeds['TODAY']['STATION']);
        }
        $feeds['responsetime'] = $result->datetime;       
        echo json_encode($feeds);
    }

    function get_active_banners() {
        $this->is_logged_in();
        _include_js('assets/lib/magnific-popup/jquery.magnific-popup.min.js');

        $result = $this->api_model->getCommerceBanners(); 
        $result = json_decode($result);
        $data['banners'] = $result->data;
        
        $this->load->view('site/widgets/announcements', $data);
    }

    function vendor_booking_summary() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQLB1J5748'
        );

        $p_key = _get_namespace_id().'_dashboard_vendor_summary';
        if (!($result = $this->rediscache->get($p_key))) {
            $response = $this->api_model->getDynamicReportDataWithMap($data);
            $result = json_decode($response);
            if ($result->status == 1) {
                $this->rediscache->set($p_key, $response, 7200); // 2 hours
            }
        } else {
            $result = json_decode($result);            
        }

        usort($result->data, function($a, $b) {
            return ($b->total_amount < $a->total_amount) ? -1 : 1;
        });
        $data['result'] = $result->data;
        
        $this->load->view('site/widgets/vendor-booking-summary', $data);
    }

    function branch_booking_summary() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQLB1J5949',
            'date' => $this->input->post('date') ?: date('Y-m-d'),
            'paymentType' => $this->input->post('paymentType') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'filterType' => $this->input->post('filterType') ?: 'SUMMARY',
            'events' => 'BRANCH',
        );

        $p_key = _get_namespace_id().'_dashboard_branch_summary_'.md5(http_build_query($data));
        if (!($result = $this->rediscache->get($p_key))) {
            $response = $this->api_model->getDynamicReportDataWithMap($data);
            $result = json_decode($response);
            if ($result->status == 1) {
                $this->rediscache->set($p_key, $response, 900); // 15 minute
            }
        } else {
            $result = json_decode($result);            
        }

        $summary = [];
        foreach ($result->data as $value) {
            list($filterType, $paymentType, $organizationName, $organizationCode) = explode(':', $value->attribute_type);
            $obj = new stdClass();
            $obj->filterType = $filterType;
            $obj->paymentType = $paymentType;
            $obj->totalAmount = $value->attribute_value;
            $obj->cargoCount = $value->attribute_count;
            $summary[$organizationCode][$filterType][$paymentType] = $obj;
            $summary[$organizationCode]['organizationName'] = $organizationName;
            $summary[$organizationCode]['organizationCode'] = $organizationCode;
        }
        $data['result'] = $summary;
        
        $this->load->view('site/widgets/branch-booking-summary', $data);
    }

    function godown_booking_summary() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQLB1J5949',
            'date' => $this->input->post('date') ?: date('Y-m-d'),
            'paymentType' => $this->input->post('paymentType') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'filterType' => $this->input->post('filterType') ?: 'SUMMARY',
            'events' => 'GODOWN',
        );

        $p_key = _get_namespace_id().'_dashboard_godown_summary_'.md5(http_build_query($data));
        if (!($result = $this->rediscache->get($p_key))) {
            $response = $this->api_model->getDynamicReportDataWithMap($data);
            $result = json_decode($response);
            if ($result->status == 1) {
                $this->rediscache->set($p_key, $response, 7200); // 2 hours
            }
        } else {
            $result = json_decode($result);            
        }
        $data['result'] = $result->data;
        
        $this->load->view('site/widgets/godown-booking-summary', $data);
    }

    function vendor_booking_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQI3UF231',
            'fromDate' => $this->input->post('fromDate') ?: 'NA',
            'toDate' => $this->input->post('toDate') ?: 'NA',
            'vendorCode' => $this->input->post('vendorCode'),
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['username'] = $this->session->userdata('user_name');

        $this->load->view('site/widgets/vendor-booking-list', $data);
    }

    function branch_booking_list() {
        $this->is_logged_in();

        $param = array(
            'queryCode' => 'RQLB1J5949',
            'date' => $this->input->post('date') ?: date('Y-m-d'),
            'paymentType' => $this->input->post('paymentType') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'filterType' => $this->input->post('filterType') ?: 'BOOKING',
            'events' => 'BRANCH',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($param);
        $result = json_decode($result);
        $data['booking'] = $result->data;

        $param = array(
            'queryCode' => 'RQLB1J5949',
            'date' => $this->input->post('date') ?: date('Y-m-d'),
            'paymentType' => $this->input->post('paymentType') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'filterType' => $this->input->post('filterType') ?: 'DELIVERY',
            'events' => 'BRANCH',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($param);
        $result = json_decode($result);
        $data['delivery'] = $result->data;

        $this->load->view('site/widgets/branch-booking-list', $data);
    }

    function get_user_balance() {
        $this->is_logged_in();

        $param = array(
            'queryCode' => 'RQI9L7N4',
            'userCode' => $this->input->post('userCode') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
        );

        $type = $this->input->post('type');

        if (!has_action_rights('CGO-VIEW-ALL-LR')) {
            $param['userCode'] = _get_user_id();
        }

        $p_key = _get_namespace_id().'_dashboard_user_balance_'.md5(http_build_query($param));
        if (!($result = $this->rediscache->get($p_key))) {
            $response = $this->api_model->getDynamicReportDataWithMap($param);
            $result = json_decode($response);
            if ($result->status == 1) {
                usort($result->data, function($a, $b) {
                    return ($b->current_balance < $a->current_balance) ? -1 : 1;
                });
                $this->rediscache->set($p_key, json_encode($result), 600); // 10 mins
            }
        } else {
            $result = json_decode($result);
        }

        $data['as_on_time'] = $result->datetime;

        $usr = array();
        $ven = array();
        foreach ($result->data as $key=>$val){
            if($val->user_role_code == 'USER'){
                array_push($usr, $val);
            }elseif($val->user_role_code == 'CGCUST'){
                array_push($ven, $val);
            }
        }

        if($type == 'USER'){
            $data['result'] = $usr;
            $this->load->view('site/widgets/user-balance-list', $data);
        }else{
            $data['result'] = $ven;
            $this->load->view('site/widgets/user-balance-vendor-list', $data);
        }
    }

    function get_branch_balance() {
        $this->is_logged_in();

        $param = array(
            'userCode' => $this->input->post('userCode') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'filterType' => $this->input->post('filterType') ?: 'BRANCH',
        );

        if (!has_action_rights('CGO-VIEW-ALL-LR')) {
            $param['organizationCode'] = $this->session->userdata('org_code');
        }

        $p_key = _get_namespace_id().'_dashboard_branch_balance_'.md5(http_build_query($param));
        if (!($result = $this->rediscache->get($p_key))) {
            $response = $this->api_model->organizationUserBalance($param);
            $result = json_decode($response);
            if ($result->status == 1) {
                usort($result->data, function($a, $b) {
                    return ($b->currentBalance < $a->currentBalance) ? -1 : 1;
                });
                $this->rediscache->set($p_key, json_encode($result), 600); // 2 hours
            }
        } else {
            $result = json_decode($result);
        }
        $data['result'] = $result;

        $this->load->view('site/widgets/branch-balance-list', $data);
    }

    function get_sales_summary() {
        $this->is_logged_in();

        $param = array(
            'date' => $this->input->post('date') ?: 'NA',
            'organizationCode' => 'NA'
        );

        if (!has_action_rights('CGO-VIEW-ALL-LR')) {
            $param['organizationCode'] = $this->session->userdata('org_code');
        }

        $cnf_pay_type = config_item('cargo_payment_status');        

        $p_key = _get_namespace_id().'_dashboard_sales_summary_'.md5(http_build_query($param));
        if (!($result = $this->rediscache->get($p_key))) {
            $response = $this->api_model->getSalesSummary($param);
            $result = json_decode($response);
            if ($result->status == 1) {
                usort($result->data, function($a, $b) {
                    return ($b->currentBalance < $a->currentBalance) ? -1 : 1;
                });
                $this->rediscache->set($p_key, json_encode($result), 600); // 2 hours
            }
        } else {
            $result = json_decode($result);
        }

        $sales_data = array();
        $org = array();
        $pay = array();
        foreach($result->data->organization as $key=>$val){
            $org[$val->name]['y'] += $val->value;
            $org[$val->name]['name'] = $val->name;
        }

        if($this->input->post('exptyperadio') == 'Fmt'){
            foreach ($result->data->paymentTypeFreight as $key => $val) {
                $pay[$val->code]['y'] = $val->value;
                $pay[$val->code]['name'] = $cnf_pay_type[$val->code];
                $pay[$val->code]['code'] = $val->code;
            }
        }else{
            foreach ($result->data->paymentType as $key => $val) {
                $pay[$val->code]['y'] += $val->value;
                $pay[$val->code]['name'] = $cnf_pay_type[$val->code];
                $pay[$val->code]['code'] = $val->code;
            }
        } 

        $sales_data['organization'] = $org;
        $sales_data['paymentType'] = $pay;
        
        echo json_encode($sales_data);
    }

    function get_branch_performance(){
        $this->is_logged_in();
        $organization = $this->session->userdata('org_code');
        $userCode = $this->session->userdata('user_id');

        $param = array(
            'queryCode' => 'RQJ1E4J189',
            'organizationCode' => $organization ?: 'NA',
            'userCode' => 'NA'
        );

        $p_key = _get_namespace_id().'_agent_view_'.md5(http_build_query($param));
        if (!($result = $this->rediscache->get($p_key))) {
            $result = $this->api_model->getDynamicReportDataWithMap($param);
            $this->rediscache->set($p_key, $result, 600); // 10 mins
        }           

        $result = json_decode($result);
        usort($result->data, function($a, $b) {
            return ($b->attribute_value < $a->attribute_value) ? -1 : 1;
        });      
        
        $feeds = array();
        if($result->status==1) {
            foreach ($result->data as $entity) {
                $t = explode(':', $entity->attribute_type);
                $feeds[$t[0]][$t[1]] += $entity->attribute_value;
            }
        }
        
        $data['as_on_time'] = $result->datetime;
        $data['agent_data'] = $feeds;

        $this->load->view('site/widgets/branch-performance-view', $data);
    }

    function get_branch_tiles() {
        $this->is_logged_in();

        if (has_action_rights('DASH-PEND-DAYCLOSE')) {
            $param = array('organizationCode' => $this->session->userdata('org_code'));
            if (has_action_rights('DAY-CLO-ALL-BRCH')) {
                $param['organizationCode'] = 'NA';
            }

            $p_key = _get_namespace_id().'_dashboard_dayclosing_summary_'.md5(http_build_query($param));
            if (!($result = $this->rediscache->get($p_key))) {
                $response = $this->api_model->dashboardDayCloseSummary($param);
                $result = json_decode($response);
                if ($result->status == 1) {
                    usort($result->data, function ($a, $b) {
                        return ($b->pendingCount < $a->pendingCount) ? -1 : 1;
                    });
                    $this->rediscache->set($p_key, json_encode($result), 600); // 2 hours
                }
            } else {
                $result = json_decode($result);
            }
            $data['dayclosing_summary'] = $result;
        }

        if (has_action_rights('DASH-PEND-EXPENSE')) {
            $param = array('organizationCode' => $this->session->userdata('org_code'));
            if (has_action_rights('IE-BEHALF-ALL')) {
                $param['organizationCode'] = 'NA';
            }

            $p_key = _get_namespace_id().'_dashboard_expense_summary_'.md5(http_build_query($param));
            if (!($result = $this->rediscache->get($p_key))) {
                $response = $this->api_model->dashboardExpenseSummary($param);
                $result = json_decode($response);
                if ($result->status == 1) {
                    usort($result->data, function($a, $b) {
                        return ($b->pendingCount < $a->pendingCount) ? -1 : 1;
                    });
                    $this->rediscache->set($p_key, json_encode($result), 600); // 2 hours
                }
            } else {
                $result = json_decode($result);
            }
            $data['expense_summary'] = $result;
        }

        $this->load->view('site/widgets/dashboard-branch-tiles', $data);
    }

    function vendor_details() {
        $this->is_logged_in();

        $vendorCode = $this->input->post('vendorCode');

        $vendors = $this->api_model->cargoCustomerVendor();
        $vendors = json_decode($vendors);

        $vendor = new stdClass;
        foreach ($vendors->data as $row) {
            if ($row->code == $vendorCode) {
                $vendor = $row;
                break;
            }
        }
        $data['vendor'] = $vendor;

        $balance = $this->api_model->cargoVendorContactBalance(array(
            'contactCode' => $vendorCode,
            'mobileNumber' => $vendor->mobileNumber,
        ));
        $balance = json_decode($balance);
        $data['vendor_balance'] = $balance->data;
        
        $this->load->view('site/widgets/vendor-details', $data);
    }
}
