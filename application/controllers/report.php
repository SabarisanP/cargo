<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Report extends MY_Controller {

    function __construct() {
        set_time_limit(0);
        parent::__construct();
    }

    public function index() {
        $this->is_logged_in();
        redirect('user/dashboard');
    }

//    public function advance_booking() {
//        $this->is_logged_in();
//        $this->load->view('site/report/advance_booking');
//    }
//

    public function all_user_report() {
        $this->is_logged_in();

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $tmp = array();
        foreach ($GroupDetail->data AS $grp) {
            $Groupuser = $this->api_model->getUserByGroup(array('groupcode' => $grp->code));
            $Groupuser = json_decode($Groupuser);
            $tmp[] = array(
                'code' => $grp->code,
                'name' => $grp->name,
                'userlist' => $Groupuser->data
            );
        }
        $data['entity'] = $tmp;

        $this->load->view('site/report/all_user_report', $data);
    }

    function get_all_user_report() {
        $this->is_logged_in();
        $report = $this->api_model->getUserReport(array(
            'user' => $this->input->post('user')?: 'NA', 
            'from' => $this->input->post('from')?: 'NA', 
            'to' => $this->input->post('to')?: 'NA')
                );
        $rpt = json_decode($report);
        $data['reports'] = $rpt->data;
        
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/all-user-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=My-Transactions.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
        $this->load->view('site/template/all-user-report-list', $data);
        }
    }

    function get_recharge_list() {
        $this->is_logged_in();
//        $recharge = $this->api_model->getRechargeList(array(
//            'transactionTypeCode' => 'RECHG',
//            'userCode' => $this->input->post('user'),
//            'fromDate' => $this->input->post('from'),
//            'toDate' => $this->input->post('to')));
//        $rpt = json_decode($recharge);
//        $data['recharge'] = $rpt->data;
        $users = $this->input->post('gru_users');
        if(empty($users)) {
            $users = $this->session->userdata('user_id');
        }

        $data = array(
            'queryCode' => 'RQFATL54',
            'transactionType' => 'NA',
            'acknowledmentStatus' => $this->input->post('acknowledment_status'),
            'transactionMode' => $this->input->post('trans_mode'),
            'userCode' => $users,
            'toDate' => $this->input->post('date_to'),
            'fromDate' => $this->input->post('date_from'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['recharge'] = $result->data;
        $data['f_t_type'] = config_item('transaction_type');
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['f_a_status'] = config_item('acknowledge_status');

        $this->load->view('site/template/all-user-recharge-list', $data);
    }

    public function recharge() {
        $this->is_logged_in();

        $voucher_usr = $this->api_model->getUser(); // getRechargeUsers()
        $voucher_usr = json_decode($voucher_usr);
        $usr = array();

        $allowed_paytypes = ['PRE', 'ULTED'];
        foreach ($voucher_usr->data AS $users) {
            if (!in_array($users->paymentType->code, $allowed_paytypes)) {
                continue;
            }
            $usr[$users->group->code]['groupname'] = $users->group->name;
            $usr[$users->group->code]['users'][] = array(
                'code' => $users->code,
                'name' => $users->name,
            );
        }

        // Transaction type
        $trans = $this->api_model->getTransType(array('authtoken' => $this->_user_hash));
        $transaction_type = json_decode($trans);

        // Transaction Mode
        $trans_mode = $this->api_model->getTransMode(array('authtoken' => $this->_user_hash));
        $transaction_mode = json_decode($trans_mode);

        /*
          $recharge_usr = $this->api_model->getRechargeUsers(array('authtoken' => $this->_user_hash));
         */

        $data['f_t_type'] = config_item('transaction_type');
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['f_a_status'] = config_item('acknowledge_status');

        $data['t_type'] = $transaction_type->data;
        $data['t_mode'] = $transaction_mode->data;
        $data['entity'] = $usr;
        $data['login_user_code'] = $this->session->userdata('user_id');

        $this->load->view('site/report/recharge', $data);
    }

    public function update_recharge() {
        $this->is_logged_in();
        $user_id = $this->session->userdata('user_id');
        $data = array(
            'transactionType' => array("code" => $this->input->post('t_type')),
            'activeFlag' => $this->input->post('activeFlag'),
            'amountReceivedDate' => $this->input->post('Rdate'),
            'name' => $this->input->post('name'),
            'paymentHandledBy' => array("code" => $user_id),
            'transactionAmount' => $this->input->post('amt'),
            'transactionMode' => array("code" => $this->input->post('t_mode')),
            'remarks' => $this->input->post('remark'),
            'user' => array("code" => $this->input->post('user')),
        );
        echo $this->api_model->updateRecharge($data);
    }

    public function acknowledgement() {

        $this->is_logged_in();

        // Get Acknowledgement
        $ack = $this->api_model->getAck(array('authtoken' => $this->_user_hash));
        $acknowledge = json_decode($ack);
        $data['ack'] = $acknowledge->data;
        $data['transactionMode'] = config_item('transaction_mode');
        $this->load->view('site/report/acknowledgement', $data);
    }

    public function updateAcknowledgement() {
        $this->is_logged_in();
        echo $this->api_model->updateAck(array('code' => $this->input->post('code'), 'state' => $this->input->post('state')));
    }

    function make_voucher_payment(){
        $this->is_logged_in();

        echo $this->api_model->updateAckv2(array(
            'code' => $this->input->post('code'),
            'amountReceivedDate' => date('Y-m-d'),
            'remarks' => $this->input->post('remarks'),
            'transactionAmount' => $this->input->post('transactionAmount'),
            'paymentHandledBy' => array('code' => $this->session->userdata('user_id')),
            'transactionMode' => array('code' => $this->input->post('transactionMode')),
            'acknowledgeStatus' => array('code' => 'PAPAID')

        ));
    }

    public function feedback_report() {
        $this->is_logged_in();
        $this->load->view('site/report/feedback-report');
    }

    function feedback_report_list() {
        $this->is_logged_in();
        $fb_report = $this->api_model->getFeedbackReport(array('fromDate' => $this->input->post('from'), 'toDate' => $this->input->post('to')));
        $reports = json_decode($fb_report);
        $data['reports'] = $reports->data;

        $this->load->view('site/report/feedback-report-list', $data);
    }

    public function agent_boarding() {
        $this->is_logged_in();

        $data = array(
            'usercode' => $this->session->userdata('user_id')
        );
        $bps = $this->api_model->getUserStationPoints($data);
        $bps = json_decode($bps);
        $bps_allowed = array();
        foreach($bps->data as $k => $v){
            $bps_allowed[$v->station->code] = $v->station->name;
        }
        $data['bps'] = $bps_allowed;
        
        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        $data['tags'] = $tags->data;
//        if(count>0) {
//            $stations = $this->api_model->getCommerceStation();
//            $stations = json_decode($stations);
//            $data['stations'] = $stations->data;
//        }

        $this->load->view('site/report/agent-boarding', $data);
    }

    function agent_boarding_list() {
        $this->is_logged_in();

        $data = array(
            'usercode' => $this->session->userdata('user_id')
        );
        $bps = $this->api_model->getUserStationPoints($data);
        $bps = json_decode($bps);
        $bps = $bps->data;

        $bps_allowed = array();
        foreach($bps as $k => $v){
            $bps_allowed[] = $v->code;
        }

        $data = array(
            'queryCode' => 'RPTBP01',
            'fromStationCode' => $this->input->post('staion'),
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('from_date'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $tickets = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    if(in_array($result->data[$i]->station_point_code, $bps_allowed) ) {
                        $result->data[$i]->boarding_time = date('h:i A', mktime(0, $result->data[$i]->boarding_point_minitues));
                        $tickets[ucfirst($result->data[$i]->boarding_point_name)][$result->data[$i]->trip_code][] = $result->data[$i];
                    }
                }
            }
        }
        $data['tickets'] = $tickets;
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/agent-boarding-point-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Agent-Boarding.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/agent-boarding-list', $data);
        }

    }

    public function boarding_point() {
        $this->is_logged_in();
        $stations = $this->api_model->getCommerceStation();
        $stations = json_decode($stations);
        
        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        
        $data['tags'] = $tags->data;
        $data['stations'] = $stations->data;
        
        $this->load->view('site/report/boarding-point', $data);
    }

    function boarding_point_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RPTBP01',
            'fromStationCode' => $this->input->post('staion'),
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );

        $p_key = _get_namespace_id().'_boarding_point_list_'.md5(http_build_query($data));
        if( !$result = $this->rediscache->get($p_key)) {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 900); //15 mins
        }

        $result = json_decode($result);
//        $result=  json_encode($result);
//        echo $result;
        $tickets = array();
        $seat_count = array();

        $stationPoint = $this->input->post('stationPoint');
        if ($result->status == 1) {
            if (is_array($result->data)) {

                usort($result->data, function($a, $b) {
                    return $a->boarding_point_minitues < $b->boarding_point_minitues ? -1 : 1;
                });

                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    if($stationPoint == 'NA' || $result->data[$i]->station_point_code == $stationPoint){
                        $result->data[$i]->boarding_time = date('h:i A', mktime(0, $result->data[$i]->boarding_point_minitues));
                        $tickets[ucfirst($result->data[$i]->boarding_point_name)][$result->data[$i]->trip_code][] = $result->data[$i];
                        $seat_count[ucfirst($result->data[$i]->boarding_point_name)] += substr_count($result->data[$i]->seat_name, ',') + 1;
                    }
                }
            }
        }
        $data['tickets'] = $tickets;
        $data['seat_count'] = $seat_count;
//     $tickets=  json_encode($tickets);
//        echo $tickets;
        
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/boarding-point-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Boarding_report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/boarding-point-list', $data);
        }
    }

    public function ac_bus_tax() {
        $this->is_logged_in();
        $this->load->view('site/report/ac-bus-tax', $data);
    }



    function ac_bus_tax_list_statewise() {
        $this->is_logged_in();

        $json = $this->api_model->getGstDetails();
        $json = json_decode($json);

        for ($i = 0; $i < count($json->data); $i++) {
            $gst[$json->data[$i]->code] = array(
                'state' => $json->data[$i]->state->name,
                'cgstSlab' => $json->data[$i]->cgstValue,
                'sgstSlab' => $json->data[$i]->sgstValue,
                'igstSlab' => $json->data[$i]->igstValue,
                'tradeName' => $json->data[$i]->tradeName,
                'gstin' => $json->data[$i]->gstin
            );
        }
        $gst['default'] = array(
                'state' => 'Default',
                'cgstSlab' => 2.5,
                'sgstSlab' => 2.5,
                'igstSlab' => 0,
                'tradeName' => '',
                'gstin' => ''
            );
        $gst['nogst'] = array(
                'state' => 'nogst',
                'cgstSlab' => 0,
                'sgstSlab' => 0,
                'igstSlab' => 0,
                'tradeName' => '',
                'gstin' => ''
            );

        $data = array(
            'queryCode' => 'RQG7TMP11',
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'travelDateflag' => $this->input->post('date_option'),
            'filterType' => $this->input->post('gst_filter'),
        );

        $p_key = _get_namespace_id().'_gst_report_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 900);    //  15 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 900);    //  15 mins
        }
        
        $result = json_decode($result);
        $tickets = array();
        
        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    $t = $result->data[$i];

                    if($t->booked_ac_bus_tax<=0 && $this->input->post('gst_filter') == "GST") continue;

                    $tax_code = ($t->tax_code) ? $t->tax_code : 'default';
                    $tax_code = $this->input->post('gst_filter') == "NON_GST" ? "nogst" : $tax_code;

                    $ts = $gst[$tax_code];

                    $t->tax_code = $tax_code;
                    if($ts['sgstSlab']>0) {
                       $t->sgst = $ts['sgstSlab'];
                       $tp = ($t->sgst / 5) * 100;
                       $t->sgst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    if($ts['cgstSlab']>0) {
                       $t->cgst = $ts['cgstSlab'];
                       $tp = ($t->cgst / 5) * 100;
                       $t->cgst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    if($ts['igstSlab']>0) {
                       $t->igst = $ts['igstSlab'];
                       $tp = ($t->igst / 5) * 100;
                       $t->igst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    $tickets[$result->data[$i]->transaction_type][] = $t;
                }
            }
        }

        $booking = array();
        foreach($tickets['BO'] as $bt) {
           $booking[$bt->tax_code]['turnover'] =  $bt->transaction_amount - $bt->addons_amount + $booking[$bt->tax_code]['turnover'];
           $booking[$bt->tax_code]['cgst'] =  $bt->cgst_amount+$booking[$bt->tax_code]['cgst'];
           $booking[$bt->tax_code]['sgst'] =  $bt->sgst_amount+$booking[$bt->tax_code]['sgst'];
           $booking[$bt->tax_code]['igst'] =  $bt->igst_amount+$booking[$bt->tax_code]['igst'];
        }

        $cancel = array();
        foreach($tickets['CA'] as $ca) {
            $cancel[$ca->tax_code]['turnover'] =  $ca->transaction_amount - $ca->addons_amount + $cancel[$ca->tax_code]['turnover'];
            $cancel[$ca->tax_code]['cgst'] =  $ca->cgst_amount+$cancel[$ca->tax_code]['cgst'];
            $cancel[$ca->tax_code]['sgst'] =  $ca->sgst_amount+$cancel[$ca->tax_code]['sgst'];
            $cancel[$ca->tax_code]['igst'] =  $ca->igst_amount+$cancel[$ca->tax_code]['igst'];
        }

        $data['booking'] = $booking;
        $data['cancel'] = $cancel;
        $data['gst'] = $gst;

        if ($this->input->post('export') == 1) {
            $data['tickets'] = $tickets;
            $this->load->exclude_template();
            $content = $this->load->view('site/report/ac-bus-tax-list-statewise-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=AC-Bus-Tax-Statewise.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/ac-bus-tax-list-statewise', $data);
        }
    }

    function ac_bus_tax_list_rolewise() {
        $this->is_logged_in();

        $json = $this->api_model->getGstDetails();
        $json = json_decode($json);

        for ($i = 0; $i < count($json->data); $i++) {
            $gst[$json->data[$i]->code] = array(
                'state' => $json->data[$i]->state->name,
                'cgstSlab' => $json->data[$i]->cgstValue,
                'sgstSlab' => $json->data[$i]->sgstValue,
                'igstSlab' => $json->data[$i]->igstValue,
                'tradeName' => $json->data[$i]->tradeName,
                'gstin' => $json->data[$i]->gstin
            );
        }
        $gst['default'] = array(
                'state' => 'Default',
                'cgstSlab' => 2.5,
                'sgstSlab' => 2.5,
                'igstSlab' => 0,
                'tradeName' => '',
                'gstin' => ''
            );

        $gst['nogst'] = array(
                'state' => 'nogst',
                'cgstSlab' => 0,
                'sgstSlab' => 0,
                'igstSlab' => 0,
                'tradeName' => '',
                'gstin' => ''
            );

        $data = array(
            'queryCode' => 'RQG7TMP11',
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'travelDateflag' => $this->input->post('date_option'),
            'filterType' => $this->input->post('gst_filter'),
        );

        $p_key = _get_namespace_id().'_gst_report_'.md5(http_build_query($data));
        if( !$result = $this->rediscache->get($p_key)) {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 900);    //  15 mins
        }

        $result = json_decode($result);
        $tickets = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    $t = $result->data[$i];

                    if($t->booked_ac_bus_tax<=0 && $this->input->post('gst_filter') == "GST") continue;

                    $tax_code = ($t->tax_code) ? $t->tax_code : 'default';
                    $tax_code = $this->input->post('gst_filter') == "NON_GST" ? "nogst" : $tax_code;

                    $tax_code = ($t->tax_code) ? $t->tax_code : 'default';
                    $ts = $gst[$tax_code];

                    $t->tax_code = $tax_code;
                    if($ts['sgstSlab']>0) {
                       $t->sgst = $ts['sgstSlab'];
                       $tp = ($t->sgst / 5) * 100;
                       $t->sgst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    if($ts['cgstSlab']>0) {
                       $t->cgst = $ts['cgstSlab'];
                       $tp = ($t->cgst / 5) * 100;
                       $t->cgst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    if($ts['igstSlab']>0) {
                       $t->igst = $ts['igstSlab'];
                       $tp = ($t->igst / 5) * 100;
                       $t->igst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    $tickets[$result->data[$i]->transaction_type][] = $t;
                }
            }
        }

        $booking = array();
        foreach($tickets['BO'] as $bt) {
           $booking[$bt->user_group_name]['turnover'] =  $bt->transaction_amount - $bt->addons_amount + $booking[$bt->user_group_name]['turnover'];
           $booking[$bt->user_group_name]['cgst'] =  $bt->cgst_amount+$booking[$bt->user_group_name]['cgst'];
           $booking[$bt->user_group_name]['sgst'] =  $bt->sgst_amount+$booking[$bt->user_group_name]['sgst'];
           $booking[$bt->user_group_name]['igst'] =  $bt->igst_amount+$booking[$bt->user_group_name]['igst'];
        }

        $cancel = array();
        foreach($tickets['CA'] as $ca) {
            $cancel[$ca->user_group_name]['turnover'] =  $ca->transaction_amount - $ca->addons_amount + $cancel[$ca->user_group_name]['turnover'];
            $cancel[$ca->user_group_name]['cgst'] =  $ca->cgst_amount+$cancel[$ca->user_group_name]['cgst'];
            $cancel[$ca->user_group_name]['sgst'] =  $ca->sgst_amount+$cancel[$ca->user_group_name]['sgst'];
            $cancel[$ca->user_group_name]['igst'] =  $ca->igst_amount+$cancel[$ca->user_group_name]['igst'];
        }
        ksort($booking);
        $data['groups'] = array_keys($booking);
        $data['booking'] = $booking;
        $data['cancel'] = $cancel;
        $data['gst'] = $gst;


        if ($this->input->post('export') == 1) {
            $data['tickets'] = $tickets;
            $this->load->exclude_template();
            $content = $this->load->view('site/report/ac-bus-tax-list-rolewise-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=AC-Bus-Tax-Rolewise.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/ac-bus-tax-list-rolewise', $data);
        }
    }

    function ac_bus_tax_list_userwise() {
        $this->is_logged_in();

        $json = $this->api_model->getGstDetails();
        $json = json_decode($json);

        for ($i = 0; $i < count($json->data); $i++) {
            $gst[$json->data[$i]->code] = array(
                'state' => $json->data[$i]->state->name,
                'cgstSlab' => $json->data[$i]->cgstValue,
                'sgstSlab' => $json->data[$i]->sgstValue,
                'igstSlab' => $json->data[$i]->igstValue,
                'tradeName' => $json->data[$i]->tradeName,
                'gstin' => $json->data[$i]->gstin
            );
        }
        $gst['default'] = array(
                'state' => 'Default',
                'cgstSlab' => 2.5,
                'sgstSlab' => 2.5,
                'igstSlab' => 0,
                'tradeName' => '',
                'gstin' => ''
            );

        $gst['nogst'] = array(
                'state' => 'nogst',
                'cgstSlab' => 0,
                'sgstSlab' => 0,
                'igstSlab' => 0,
                'tradeName' => '',
                'gstin' => ''
            );

        $data = array(
            'queryCode' => 'RQG7TMP11',
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'travelDateflag' => $this->input->post('date_option'),
            'filterType' => $this->input->post('gst_filter'),
        );

        $p_key = _get_namespace_id().'_gst_report_'.md5(http_build_query($data));
        if( !$result = $this->rediscache->get($p_key)) {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 900);    //  15 mins
        }

        $result = json_decode($result);
        $tickets = array();
        $users = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    $t = $result->data[$i];

                    if($t->booked_ac_bus_tax<=0 && $this->input->post('gst_filter') == "GST") continue;

                    if(strtolower($t->user_group_name)== 'customer') $t->user_name = 'Guest';

                    $tax_code = ($t->tax_code) ? $t->tax_code : 'default';
                    $tax_code = $this->input->post('gst_filter') == "NON_GST" ? "nogst" : $tax_code;

                    $ts = $gst[$tax_code];

                    $t->tax_code = $tax_code;
                    if($ts['sgstSlab']>0) {
                       $t->sgst = $ts['sgstSlab'];
                       $tp = ($t->sgst / 5) * 100;
                       $t->sgst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    if($ts['cgstSlab']>0) {
                       $t->cgst = $ts['cgstSlab'];
                       $tp = ($t->cgst / 5) * 100;
                       $t->cgst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    if($ts['igstSlab']>0) {
                       $t->igst = $ts['igstSlab'];
                       $tp = ($t->igst / 5) * 100;
                       $t->igst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    $tickets[$result->data[$i]->transaction_type][] = $t;
                    $users[$t->user_name] = $t->user_name;
                }
            }
        }

        $booking = array();
        foreach($tickets['BO'] as $bt) {
           $booking[$bt->user_name]['turnover'] =  $bt->transaction_amount - $bt->addons_amount + $booking[$bt->user_name]['turnover'];
           $booking[$bt->user_name]['cgst'] =  $bt->cgst_amount+$booking[$bt->user_name]['cgst'];
           $booking[$bt->user_name]['sgst'] =  $bt->sgst_amount+$booking[$bt->user_name]['sgst'];
           $booking[$bt->user_name]['igst'] =  $bt->igst_amount+$booking[$bt->user_name]['igst'];
        }

        $cancel = array();
        foreach($tickets['CA'] as $ca) {
            $cancel[$ca->user_name]['turnover'] =  $ca->transaction_amount - $ca->addons_amount + $cancel[$ca->user_name]['turnover'];
            $cancel[$ca->user_name]['cgst'] =  $ca->cgst_amount+$cancel[$ca->user_name]['cgst'];
            $cancel[$ca->user_name]['sgst'] =  $ca->sgst_amount+$cancel[$ca->user_name]['sgst'];
            $cancel[$ca->user_name]['igst'] =  $ca->igst_amount+$cancel[$ca->user_name]['igst'];
        }
        ksort($booking);
        ksort($users);
        $data['users'] = array_keys($users);
        $data['booking'] = $booking;
        $data['cancel'] = $cancel;
        $data['gst'] = $gst;


        if ($this->input->post('export') == 1) {
            $data['tickets'] = $tickets;
            $this->load->exclude_template();
            $content = $this->load->view('site/report/ac-bus-tax-list-userwise-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=AC-Bus-Tax-Userwise.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/ac-bus-tax-list-userwise', $data);
        }
    }

    function ac_bus_tax_list_schedulewise() {
        $this->is_logged_in();

        $json = $this->api_model->getGstDetails();
        $json = json_decode($json);

        for ($i = 0; $i < count($json->data); $i++) {
            $gst[$json->data[$i]->code] = array(
                'state' => $json->data[$i]->state->name,
                'cgstSlab' => $json->data[$i]->cgstValue,
                'sgstSlab' => $json->data[$i]->sgstValue,
                'igstSlab' => $json->data[$i]->igstValue,
                'tradeName' => $json->data[$i]->tradeName,
                'gstin' => $json->data[$i]->gstin
            );
        }
        $gst['default'] = array(
                'state' => 'Default',
                'cgstSlab' => 2.5,
                'sgstSlab' => 2.5,
                'igstSlab' => 0,
                'tradeName' => '',
                'gstin' => ''
            );

        $gst['nogst'] = array(
                'state' => 'nogst',
                'cgstSlab' => 0,
                'sgstSlab' => 0,
                'igstSlab' => 0,
                'tradeName' => '',
                'gstin' => ''
            );

        $data = array(
            'queryCode' => 'RQG7TMP11',
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'travelDateflag' => $this->input->post('date_option'),
            'filterType' => $this->input->post('gst_filter'),
        );

        $p_key = _get_namespace_id().'_gst_report_'.md5(http_build_query($data));
        if( !$result = $this->rediscache->get($p_key)) {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 900);    //  15 mins
        }
        $result = json_decode($result);
        $tickets = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    $t = $result->data[$i];

                    if($t->booked_ac_bus_tax<=0 && $this->input->post('gst_filter') == "GST") continue;

                    $tax_code = ($t->tax_code) ? $t->tax_code : 'default';
                    $tax_code = $this->input->post('gst_filter') == "NON_GST" ? "nogst" : $tax_code;
                    $ts = $gst[$tax_code];

                    $t->tax_code = $tax_code;
                    if($ts['sgstSlab']>0) {
                       $t->sgst = $ts['sgstSlab'];
                       $tp = ($t->sgst / 5) * 100;
                       $t->sgst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    if($ts['cgstSlab']>0) {
                       $t->cgst = $ts['cgstSlab'];
                       $tp = ($t->cgst / 5) * 100;
                       $t->cgst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    if($ts['igstSlab']>0) {
                       $t->igst = $ts['igstSlab'];
                       $tp = ($t->igst / 5) * 100;
                       $t->igst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    $tickets[$result->data[$i]->transaction_type][] = $t;
                }
            }
        }

        $booking = array();
        foreach($tickets['BO'] as $bt) {
           $booking[$bt->schedule_code]['turnover'] =  $bt->transaction_amount - $bt->addons_amount + $booking[$bt->schedule_code]['turnover'];
           $booking[$bt->schedule_code]['cgst'] =  $bt->cgst_amount+$booking[$bt->schedule_code]['cgst'];
           $booking[$bt->schedule_code]['sgst'] =  $bt->sgst_amount+$booking[$bt->schedule_code]['sgst'];
           $booking[$bt->schedule_code]['igst'] =  $bt->igst_amount+$booking[$bt->schedule_code]['igst'];

           $booking[$bt->schedule_code]['servicename'] =  $bt->schedule_name;
           $booking[$bt->schedule_code]['servicenumber'] =  $bt->service_number;
        }

        $cancel = array();
        foreach($tickets['CA'] as $ca) {
            $cancel[$ca->schedule_code]['turnover'] =  $ca->transaction_amount - $ca->addons_amount + $cancel[$ca->schedule_code]['turnover'];
            $cancel[$ca->schedule_code]['cgst'] =  $ca->cgst_amount+$cancel[$ca->schedule_code]['cgst'];
            $cancel[$ca->schedule_code]['sgst'] =  $ca->sgst_amount+$cancel[$ca->schedule_code]['sgst'];
            $cancel[$ca->schedule_code]['igst'] =  $ca->igst_amount+$cancel[$ca->schedule_code]['igst'];

            $cancel[$ca->schedule_code]['servicename'] =  $ca->schedule_name;
            $cancel[$ca->schedule_code]['servicenumber'] =  $ca->service_number;
        }
        ksort($booking);
        $data['schedules'] = array_keys($booking);
        $data['booking'] = $booking;
        $data['cancel'] = $cancel;
        $data['gst'] = $gst;


        if ($this->input->post('export') == 1) {
            $data['tickets'] = $tickets;
            $this->load->exclude_template();
            $content = $this->load->view('site/report/ac-bus-tax-list-schedulewise-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=AC-Bus-Tax-Schedulewise.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/ac-bus-tax-list-schedulewise', $data);
        }
    }

    function ac_bus_tax_list_tripwise() {
        $this->is_logged_in();

        $json = $this->api_model->getGstDetails();
        $json = json_decode($json);

        for ($i = 0; $i < count($json->data); $i++) {
            $gst[$json->data[$i]->code] = array(
                'state' => $json->data[$i]->state->name,
                'cgstSlab' => $json->data[$i]->cgstValue,
                'sgstSlab' => $json->data[$i]->sgstValue,
                'igstSlab' => $json->data[$i]->igstValue,
                'tradeName' => $json->data[$i]->tradeName,
                'gstin' => $json->data[$i]->gstin
            );
        }
        $gst['default'] = array(
                'state' => 'Default',
                'cgstSlab' => 2.5,
                'sgstSlab' => 2.5,
                'igstSlab' => 0,
                'tradeName' => '',
                'gstin' => ''
            );

        $gst['nogst'] = array(
                'state' => 'nogst',
                'cgstSlab' => 0,
                'sgstSlab' => 0,
                'igstSlab' => 0,
                'tradeName' => '',
                'gstin' => ''
            );

        $data = array(
            'queryCode' => 'RQG7TMP11',
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'travelDateflag' => $this->input->post('date_option'),
            'filterType' => $this->input->post('gst_filter'),
        );

        $p_key = _get_namespace_id().'_gst_report_'.md5(http_build_query($data));
        if( !$result = $this->rediscache->get($p_key)) {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 900);    //  15 mins
        }
        $result = json_decode($result);
        $tickets = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    $t = $result->data[$i];

                    if($t->booked_ac_bus_tax<=0 && $this->input->post('gst_filter') == "GST") continue;

                    $tax_code = ($t->tax_code) ? $t->tax_code : 'default';
                    $tax_code = $this->input->post('gst_filter') == "NON_GST" ? "nogst" : $tax_code;
                    $ts = $gst[$tax_code];

                    $t->tax_code = $tax_code;
                    if($ts['sgstSlab']>0) {
                       $t->sgst = $ts['sgstSlab'];
                       $tp = ($t->sgst / 5) * 100;
                       $t->sgst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    if($ts['cgstSlab']>0) {
                       $t->cgst = $ts['cgstSlab'];
                       $tp = ($t->cgst / 5) * 100;
                       $t->cgst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    if($ts['igstSlab']>0) {
                       $t->igst = $ts['igstSlab'];
                       $tp = ($t->igst / 5) * 100;
                       $t->igst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    $tickets[$result->data[$i]->transaction_type][] = $t;
                }
            }
        }

        $booking = array();
        foreach($tickets['BO'] as $bt) {
           $booking[$bt->schedule_code][$bt->travel_date]['turnover'] =  $bt->transaction_amount - $bt->addons_amount +$booking[$bt->schedule_code][$bt->travel_date]['turnover'];
           $booking[$bt->schedule_code][$bt->travel_date]['cgst'] =  $bt->cgst_amount+$booking[$bt->schedule_code][$bt->travel_date]['cgst'];
           $booking[$bt->schedule_code][$bt->travel_date]['sgst'] =  $bt->sgst_amount+$booking[$bt->schedule_code][$bt->travel_date]['sgst'];
           $booking[$bt->schedule_code][$bt->travel_date]['igst'] =  $bt->igst_amount+$booking[$bt->schedule_code][$bt->travel_date]['igst'];

           $booking[$bt->schedule_code][$bt->travel_date]['servicename'] =  $bt->schedule_name;
           $booking[$bt->schedule_code][$bt->travel_date]['servicenumber'] =  $bt->service_number;
        }

        $cancel = array();
        foreach($tickets['CA'] as $ca) {
            $cancel[$ca->schedule_code][$ca->travel_date]['turnover'] =  $ca->transaction_amount - $ca->addons_amount + $cancel[$ca->schedule_code][$ca->travel_date]['turnover'];
            $cancel[$ca->schedule_code][$ca->travel_date]['cgst'] =  $ca->cgst_amount+$cancel[$ca->schedule_code][$ca->travel_date]['cgst'];
            $cancel[$ca->schedule_code][$ca->travel_date]['sgst'] =  $ca->sgst_amount+$cancel[$ca->schedule_code][$ca->travel_date]['sgst'];
            $cancel[$ca->schedule_code][$ca->travel_date]['igst'] =  $ca->igst_amount+$cancel[$ca->schedule_code][$ca->travel_date]['igst'];

            $cancel[$ca->schedule_code][$ca->travel_date]['servicename'] =  $ca->schedule_name;
            $cancel[$ca->schedule_code][$ca->travel_date]['servicenumber'] =  $ca->service_number;
        }
        ksort($booking);
        $data['schedules'] = array_keys($booking);
        $data['booking'] = $booking;
        $data['cancel'] = $cancel;
        $data['gst'] = $gst;

        if ($this->input->post('export') == 1) {
            $data['tickets'] = $tickets;
            $this->load->exclude_template();
            $content = $this->load->view('site/report/ac-bus-tax-list-tripwise-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=AC-Bus-Tax-Tripwise.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/ac-bus-tax-list-tripwise', $data);
        }
    }

    function ac_bus_tax_list_gstwise() {
        $this->is_logged_in();

        $json = $this->api_model->getGstDetails();
        $json = json_decode($json);

        for ($i = 0; $i < count($json->data); $i++) {
            $gst[$json->data[$i]->code] = array(
                'state' => $json->data[$i]->state->name,
                'cgstSlab' => $json->data[$i]->cgstValue,
                'sgstSlab' => $json->data[$i]->sgstValue,
                'igstSlab' => $json->data[$i]->igstValue,
                'tradeName' => $json->data[$i]->tradeName,
                'gstin' => $json->data[$i]->gstin
            );
        }
        $gst['default'] = array(
                'state' => 'Default',
                'cgstSlab' => 2.5,
                'sgstSlab' => 2.5,
                'igstSlab' => 0,
                'tradeName' => '',
                'gstin' => ''
            );

        $gst['nogst'] = array(
                'state' => 'nogst',
                'cgstSlab' => 0,
                'sgstSlab' => 0,
                'igstSlab' => 0,
                'tradeName' => '',
                'gstin' => ''
            );

        $data = array(
            'queryCode' => 'RQG7TMP11',
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'travelDateflag' => $this->input->post('date_option'),
            'filterType' => $this->input->post('gst_filter'),
        );

        $p_key = _get_namespace_id().'_gst_report_'.md5(http_build_query($data));
        if( !$result = $this->rediscache->get($p_key)) {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 900);    //  15 mins
        }
        $result = json_decode($result);
        $tickets = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    $t = $result->data[$i];

                    if($t->booked_ac_bus_tax<=0 && $this->input->post('gst_filter') == "GST") continue;

                    $tax_code = ($t->tax_code) ? $t->tax_code : 'default';
                    $tax_code = $this->input->post('gst_filter') == "NON_GST" ? "nogst" : $tax_code;
                    $ts = $gst[$tax_code];

                    $t->tax_code = $tax_code;
                    if($ts['sgstSlab']>0) {
                       $t->sgst = $ts['sgstSlab'];
                       $tp = ($t->sgst / 5) * 100;
                       $t->sgst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    if($ts['cgstSlab']>0) {
                       $t->cgst = $ts['cgstSlab'];
                       $tp = ($t->cgst / 5) * 100;
                       $t->cgst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    if($ts['igstSlab']>0) {
                       $t->igst = $ts['igstSlab'];
                       $tp = ($t->igst / 5) * 100;
                       $t->igst_amount = ($t->booked_ac_bus_tax/100) * $tp;
                    }

                    $tickets[$result->data[$i]->transaction_type][] = $t;
                }
            }
        }
        
        $booking = array();
        foreach ($tickets['BO'] as $bt) {
            $category = ($bt->igst_amount > 0) ? 'Interstate' : 'Intrastate';
            $booking[$category]['turnover'] = $bt->transaction_amount - $bt->addons_amount + $booking[$category]['turnover'];
            $booking[$category]['cgst'] = $bt->cgst_amount + $booking[$category]['cgst'];
            $booking[$category]['sgst'] = $bt->sgst_amount + $booking[$category]['sgst'];
            $booking[$category]['igst'] = $bt->igst_amount + $booking[$category]['igst'];
        }

        $cancel = array();
        foreach ($tickets['CA'] as $ca) {
            $category = ($ca->igst_amount > 0) ? 'Interstate' : 'Intrastate';
            $cancel[$category]['turnover'] = $ca->transaction_amount - $ca->addons_amount + $cancel[$category]['turnover'];
            $cancel[$category]['cgst'] = $ca->cgst_amount + $cancel[$category]['cgst'];
            $cancel[$category]['sgst'] = $ca->sgst_amount + $cancel[$category]['sgst'];
            $cancel[$category]['igst'] = $ca->igst_amount + $cancel[$category]['igst'];
        }
        
        ksort($booking);
        $data['groups'] = array_keys($booking);
        $data['booking'] = $booking;
        $data['cancel'] = $cancel;
        $data['gst'] = $gst;

        if ($this->input->post('export') == 1) {
            $data['tickets'] = $tickets;
            $this->load->exclude_template();
            $content = $this->load->view('site/report/ac-bus-tax-list-gstwise-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=AC-Bus-Tax-GSTwise.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/ac-bus-tax-list-gstwise', $data);
        }
    }

    public function billing() {
        $this->is_logged_in();
//        $stations = $this->api_model->getCommerceStation();
//        $stations = json_decode($stations);
//        $data['stations'] = $stations->data;
        $data = array();

        $namespace = $this->api_model->getNamespace(array(
            'authtoken' => _get_user_hash(),
        ));
        $space = json_decode($namespace);
        $data['namespace_list'] = $space->data;

        $this->load->view('site/report/billing', $data);
    }

    function billing_list() {
        $this->is_logged_in();

        $month = $this->input->post('month');
        $months = explode('-', $month);
        $firstDate = date('Y-m-d', mktime(1, 1, 1, $months[0], 1, $months[1]));
        $endDate = date('Y-m-d', mktime(1, 1, 1,  ++$months[0], 0, $months[1]));

        $data = array(
            'queryCode' => 'RQF8V7Y1',
            'fromDate' => $firstDate,
            'toDate' => $endDate,
            'namespaceCode' => $this->input->post('namespaceCode') ?: 'NA'
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $entities = array();
        $entity_names = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {

                foreach ($result->data as $entity) {
                    $entity_names[] = $entity->entity_name;
                    $entities[$entity->operator_name][$entity->entity_name][] = array(
                        'value' => $entity->entity_value,
                        'attribute' => $entity->entity_attribute
                    );
                }
                $entity_names = array_unique($entity_names);
            }
        }
        $data['entities'] = $entities;
        $data['entity_head'] = $entity_names;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/billing-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=billing-report-' . $month . '.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/billing-list', $data);
        }
    }

    function schedule_audit_log() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQF1V916',
            'scheduleCode' => $this->input->post('scheduleCode')
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['log'] = $result->data;
        $this->load->view('site/report/audit-log-list', $data);
    }

    function sample_report() {
        $this->is_logged_in();
        $data = array();
        //_include_js('assets/js/pages/mscorlib.js');
        _include_js('assets/js/pages/Supply.debug.js', 'init_sample_report');
        $this->load->view('site/report/sample_report', $data);
    }

    /* public function transaction_report() {
      $this->is_logged_in();
      $this->load->view('site/report/transaction_report');
      }

      public function transaction_report_list() {
      $this->is_logged_in();
      $group_by_2 = $this->input->post('group_by_2');
      $group_by_3 = $this->input->post('group_by_3');
      $data = array(
      'queryCode' => 'RQF23M18',
      'travelDateFlag' => $this->input->post('date_option'),
      'toDate' => $this->input->post('to'),
      'fromDate' => $this->input->post('from'),
      );
      $result = $this->api_model->getDynamicReportDataWithMap($data);
      $result = json_decode($result);
      $tickets = array();

      if ($result->status == 1) {
      if (is_array($result->data)) {
      $ticket_count = count($result->data);

      if ($data['travelDateFlag'] == 1){
      for ($i = 0; $i < $ticket_count; $i++) {

      $one = date($this->session->userdata('date_format'), strtotime($result->data[$i]->transaction_date));
      if ($data['travelDateFlag'] == 1)
      $one = $result->data[$i]->travel_date;

      if ($group_by_2 == "")
      $tickets['one'][$one][] = $result->data[$i];    //  1st level group
      else if ($group_by_2 != "") {
      $second = "";
      if ($group_by_2 == 1)
      $second = $result->data[$i]->schedule_name;
      if ($group_by_2 == 2)
      $second = $result->data[$i]->user_group_name;

      if ($group_by_3 == "") {
      $tickets['one'][$one]['second'][$second][] = $result->data[$i];    //  2nd level group
      } else {
      $third = "";
      if ($group_by_3 == 1)
      $third = $result->data[$i]->user_group_name;
      $tickets['one'][$one]['second'][$second]['third'][$third][] = $result->data[$i];    //  2nd level group
      }
      }
      }
      }
      }
      }

      $this->load->view('site/report/transaction_report_list', array('tickets' => $tickets));
      } */

    public function transaction_report() {
        $this->is_logged_in();
        $data = array();
        
        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        
        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        $data['route'] = $routes;
        $data['active_schedules'] = get_active_schedules();
        $data['groupusers'] = get_active_group_and_users();
        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;
        $data['tags'] = $tags->data;
        
        $tmp = array();
        foreach ($GroupDetail->data AS $grp) {
            $Groupuser = $this->api_model->getUserByGroup(array('groupcode' => $grp->code));
            $Groupuser = json_decode($Groupuser);
            $tmp[] = array(
                'code' => $grp->code,
                'name' => $grp->name,
                'userlist' => $Groupuser->data
            );
        }
        $data['entity'] = $tmp;

        $this->load->view('site/report/transaction_report', $data);
    }

    public function transaction_report_list() {
        $this->is_logged_in();
        $group_by_2 = $this->input->post('group_by_2');
        $group_by_3 = $this->input->post('group_by_3');
        $data = array(
            'queryCode' => 'RQF3K85712',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'travelDateFlag' => $this->input->post('date_option'),
            'scheduleCode' => $this->input->post('schedule_code'),
            'fromStationCode' => $this->input->post('from_code'),
            'toStationCode' => $this->input->post('to_code'),
            'groupCode' => $this->input->post('group_code'),
            'userCode' => $this->input->post('user_code'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $tickets = array();

        $tickets['bo_fare'] = 0;
        $tickets['bo_comission'] = 0;
        $tickets['bo_ac_tax'] = 0;
        $tickets['bo_tds_tax'] = 0;
        $tickets['bo_discount'] = 0;
        $tickets['bo_payable'] = 0;

        $tickets['ca_fare'] = 0;
        $tickets['ca_ac_tax'] = 0;
        $tickets['ca_discount'] = 0;
        $tickets['ca_comission'] = 0;
        $tickets['ca_tds_tax'] = 0;
        $tickets['ca_charges'] = 0;
        $tickets['ca_share'] = 0;
        $tickets['ca_refund'] = 0;
        
        $tickets['ca_ca_commission'] = 0;
        $tickets['ca_ca_tds_tax'] = 0;

        $tickets['tca_refund'] = 0;
        $tickets['device'] = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {

                    if ($result->data[$i]->ticket_status_code == 'BO' || $result->data[$i]->ticket_status_code == 'PBL' ) {
                        $tickets['bo_fare'] += $result->data[$i]->ticket_amount;
                        $tickets['bo_comission'] += $result->data[$i]->commission_amount;
                        $tickets['bo_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        $tickets['bo_tds_tax'] += $result->data[$i]->tds_tax;
                        $tickets['bo_discount'] += $result->data[$i]->addons_amount;
                        $result->data[$i]->payable = ($result->data[$i]->ticket_amount+$result->data[$i]->ac_bus_tax-$result->data[$i]->addons_amount-$result->data[$i]->commission_amount+$result->data[$i]->tds_tax);
                        $tickets['bo_payable'] += $result->data[$i]->payable;
                    } else if ($result->data[$i]->ticket_status_code == 'CA'){
                        $tickets['ca_fare'] += $result->data[$i]->ticket_amount;
                        $tickets['ca_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        $tickets['ca_discount'] += $result->data[$i]->addons_amount;
                        $tickets['ca_comission'] += $result->data[$i]->commission_amount;
                        $tickets['ca_tds_tax'] += $result->data[$i]->tds_tax;
                        $tickets['ca_charges'] += $result->data[$i]->cancellation_charges;
                        $tickets['ca_share'] += $result->data[$i]->cancel_commission;
                        $tickets['ca_refund'] += $result->data[$i]->refund_amount + $result->data[$i]->revoke_commission_amount;
                        
                        $tickets['ca_ca_tds_tax'] += $result->data[$i]->cancel_tds_tax;
                        
                    } else if ($result->data[$i]->ticket_status_code == 'TCA'){
                        $tickets['tca_refund'] += $result->data[$i]->ticket_amount+$result->data[$i]->ac_bus_tax-$result->data[$i]->addons_amount-$result->data[$i]->commission_amount;
                    }


                    $tickets['total_fare'] += $result->data[$i]->ticket_amount;
                    $tickets['total_refund'] += $result->data[$i]->refund_amount + $result->data[$i]->revoke_commission_amount;
                    $tickets['total_cancellation'] += $result->data[$i]->cancellation_charges;


                    $one = date('Y-m-d', strtotime($result->data[$i]->transaction_date));
                    if ($data['travelDateFlag'] == 1)
                        $one = $result->data[$i]->travel_date;

                    //$tickets['one']['name'] = $one;
                    if ($group_by_2 == "")
                        $tickets['one'][$one][] = $result->data[$i];    //  1st level group
                    else if ($group_by_2 != "") {
                        $second = "";
                        if ($group_by_2 == 1)
                            $second = $result->data[$i]->trip_name;
                        if ($group_by_2 == 2)
                            $second = $result->data[$i]->user_group_name;

                        if ($group_by_3 == "") {
                            //$tickets['one'][$one]['heading'] = $second;
                            $tickets['one'][$one]['second'][$second][] = $result->data[$i];    //  2nd level group
                        } else {
                            $third = "";
                            if ($group_by_3 == 1)
                                $third = $result->data[$i]->user_group_name;
                            $tickets['one'][$one]['second'][$second]['third'][$third][] = $result->data[$i];    //  2nd level group
                        }
                    }
                    if(in_array($result->data[$i]->device_medium, $data['device'])) {
                        $tickets['device'][$result->data[$i]->device_medium] = 1;
                    } else {
                        $tickets['device'][$result->data[$i]->device_medium] += $result->data[$i]->seat_count;
                    }
                }

                if ($group_by_2 == "") {
                    ksort($tickets['one']);
                }

            }
        }
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/transaction_report_list_xls', array('tickets' => $tickets), true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Transaction-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/transaction_report_list', array('tickets' => $tickets));
        }
    }

    public function transaction_report_list_tally() {
        $this->is_logged_in();

        $this->load->library('excel');

        $this->excel->getProperties()->setCreator("Ezee")
                                    ->setLastModifiedBy("Ezee")
                                    ->setTitle("Transactions List")
                                    ->setSubject("Transactions List")
                                    ->setDescription("Transactions List.")
                                    ->setKeywords("Transactions List")
                                    ->setCategory("Tally");

        $this->excel->setActiveSheetIndex(0);
        $this->excel->getActiveSheet()->setTitle('Transactions');

        $this->excel->getActiveSheet()->getStyle('A1:Z1')->getFont()->setBold(true);



        $data = array(
            'queryCode' => 'RQF3K85712',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'travelDateFlag' => $this->input->post('date_option'),
            'scheduleCode' => $this->input->post('schedule_code'),
            'fromStationCode' => $this->input->post('from_code'),
            'toStationCode' => $this->input->post('to_code'),
            'groupCode' => $this->input->post('group_code'),
            'userCode' => $this->input->post('user_code'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);

        $result = json_decode($result);
        $tickets = array();

        if(_get_namespace_id()=="ashwintravels") {
            $this->excel->getActiveSheet()->setCellValue('A1', 'Type');
            $this->excel->getActiveSheet()->setCellValue('B1', 'User');
            $this->excel->getActiveSheet()->setCellValue('C1', 'Transaction Date');
            $this->excel->getActiveSheet()->setCellValue('D1', 'Travel Date');
            $this->excel->getActiveSheet()->setCellValue('E1', 'PNR');
            $this->excel->getActiveSheet()->setCellValue('F1', 'Seat No / Service No');
            $this->excel->getActiveSheet()->setCellValue('G1', 'Route');
            $this->excel->getActiveSheet()->setCellValue('H1', 'Fare');
            $this->excel->getActiveSheet()->setCellValue('I1', 'GST');
            $this->excel->getActiveSheet()->setCellValue('J1', 'Commission');
            $this->excel->getActiveSheet()->setCellValue('K1', 'User Discount');
            $this->excel->getActiveSheet()->setCellValue('L1', 'Cancel Charges');
            $this->excel->getActiveSheet()->setCellValue('M1', 'Agent Share');
            $this->excel->getActiveSheet()->setCellValue('N1', 'Amount');

            if ($result->status == 1) {
                if (is_array($result->data)) {
                    $ticket_count = count($result->data);
                    $row = 2;
                    $col = 0;
                    for ($i = 0; $i < $ticket_count; $i++) {
                        $t = $result->data[$i];

                        if( $t->ticket_status_code == "BO" ) {
                            $commision = $t->commission_amount;
                            $type = $t->ticket_status_code.' / Sales';
                        } else if( $t->ticket_status_code == "CA" ) {
                            $commision = $t->revoke_commission_amount;
                            $type = $t->ticket_status_code.' / Purchase';
                        }

                        $seats = explode(',', $t->seat_name);
                        foreach($seats as $seatname) {
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col, $row, $type);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->user_name);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, date('d-m-Y', strtotime($t->transaction_date)));
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, date('d-m-Y', strtotime($t->travel_date)));
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->ticket_code);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, trim($seatname).' / '.$t->service_number);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->from_station_name.'-'.$t->to_station_name);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, number_format(($t->ticket_amount / $t->seat_count), 2));
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, number_format(($t->ac_bus_tax / $t->seat_count), 2));
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, number_format(($commision / $t->seat_count), 2));
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, number_format(($t->addons_amount / $t->seat_count), 2));

                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, 0);    //  calcel charge
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, 0);    //  agent share

                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, number_format((($t->ticket_amount+$t->ac_bus_tax-$t->addons_amount-$t->commission_amount)/ $t->seat_count), 2));

                            $col = 0;
                            $row++;
                        }


                        if( $t->ticket_status_code == "CA" ){
                            $seats = explode(',', $t->seat_name);
                            foreach($seats as $seatname) {
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col, $row, 'CA / Sales');
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->user_name);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, date('d-m-Y', strtotime($t->transaction_date)));
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, date('d-m-Y', strtotime($t->travel_date)));
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->ticket_code);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, trim($seatname).' / '.$t->service_number);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->from_station_name.'-'.$t->to_station_name);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, 0);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, 0);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, 0);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, 0);

                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, number_format(($t->cancellation_charges / $t->seat_count), 2));    //  calcel charge
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, number_format(($t->cancel_commission  / $t->seat_count), 2));    //  agent share

                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, number_format((($t->cancellation_charges - $t->cancel_commission)  / $t->seat_count), 2) );

                                $col = 0;
                                $row++;
                            }
                        }


                    }
                }
            }
        } else {
            $this->excel->getActiveSheet()->setCellValue('A1', 'Type');
            $this->excel->getActiveSheet()->setCellValue('B1', 'User');
            $this->excel->getActiveSheet()->setCellValue('C1', 'Transaction Date');
            $this->excel->getActiveSheet()->setCellValue('D1', 'Travel Date');
            $this->excel->getActiveSheet()->setCellValue('E1', 'PNR');
            $this->excel->getActiveSheet()->setCellValue('F1', 'Route');
            $this->excel->getActiveSheet()->setCellValue('G1', 'No Of Seats');
            $this->excel->getActiveSheet()->setCellValue('H1', 'Per Seat');
            $this->excel->getActiveSheet()->setCellValue('I1', 'Total Amount');
            $this->excel->getActiveSheet()->setCellValue('J1', 'Commission');
            $this->excel->getActiveSheet()->setCellValue('K1', 'User Discount');
            $this->excel->getActiveSheet()->setCellValue('L1', 'Cancel Charges');
            $this->excel->getActiveSheet()->setCellValue('M1', 'Agent Share');
            $this->excel->getActiveSheet()->setCellValue('N1', 'Amount');

            if ($result->status == 1) {
                if (is_array($result->data)) {
                    $ticket_count = count($result->data);
                    $row = 2;
                    $col = 0;
                    for ($i = 0; $i < $ticket_count; $i++) {
                        $t = $result->data[$i];

                        if( $t->ticket_status_code == "BO" ) {
                            $commision = $t->commission_amount;
                            $type = $t->ticket_status_code.' / Sales';
                        } else if( $t->ticket_status_code == "CA" ) {
                            $commision = $t->revoke_commission_amount;
                            $type = $t->ticket_status_code.' / Purchase';
                        }

                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col, $row, $type);
                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->user_name);
                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, date('d-m-Y', strtotime($t->transaction_date)));
                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, date('d-m-Y', strtotime($t->travel_date)));
                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, str_replace('YBM', '', $t->ticket_code));
                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->from_station_name.'-'.$t->to_station_name);
                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->seat_count);
                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, ($t->ticket_amount / $t->seat_count));
                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->ticket_amount);
                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $commision);
                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->addons_amount);

                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, 0);    //  calcel charge
                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, 0);    //  agent share

                        $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, ($t->ticket_amount-$t->addons_amount-$t->commission_amount));

                        $col = 0;
                        $row++;

                        if( $t->ticket_status_code == "CA" ){
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col, $row, 'CA / Sales');
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->user_name);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, date('d-m-Y', strtotime($t->transaction_date)));
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, date('d-m-Y', strtotime($t->travel_date)));
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, str_replace('YBM', '', $t->ticket_code));
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->from_station_name.'-'.$t->to_station_name);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->seat_count);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, 0);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, 0);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, 0);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, 0);

                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->cancellation_charges);    //  calcel charge
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->cancel_commission);    //  agent share

                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, ($t->cancellation_charges - $t->cancel_commission));

                            $col = 0;
                            $row++;
                        }


                    }
                }
            }
        }

        $filename = 'Transactions-'.$this->input->post('from').' TO '.$this->input->post('to').'.xls';
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="'.$filename.'"');
        header('Cache-Control: max-age=0');
        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
        $objWriter->save('php://output');

    }

    //-----------------------------------

    public function ids_transaction_report() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        $data['route'] = $routes;

        $data['groupusers'] = get_active_group_and_users();
        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        
        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        $data['tags'] = $tags->data;

        $tmp = array();
        foreach ($GroupDetail->data AS $grp) {
            if($grp->code !== 'UGG7CFY71') {
                continue;
            }
            $Groupuser = $this->api_model->getUserByGroup(array('groupcode' => $grp->code));
            $Groupuser = json_decode($Groupuser);
            $tmp[] = array(
                'code' => $grp->code,
                'name' => $grp->name,
                'userlist' => $Groupuser->data
            );
        }
        $data['entity'] = $tmp;

        $this->load->view('site/report/ids_transaction_report', $data);
    }

    public function ids_transaction_report_list() {
        $this->is_logged_in();
        $group_by_2 = '';
        $group_by_3 = '';
        $data = array(
            'queryCode' => 'RQF3K85712',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'travelDateFlag' => $this->input->post('date_option'),
            'scheduleCode' => 'NA',
            'fromStationCode' => $this->input->post('from_code'),
            'toStationCode' => $this->input->post('to_code'),
            'groupCode' => 'UGG7CFY71',
            'userCode' => $this->input->post('user_code'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $tickets = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {

                    $one = date($this->session->userdata('date_format'), strtotime($result->data[$i]->transaction_date));
                    if ($data['travelDateFlag'] == 1)
                        $one = $result->data[$i]->travel_date;

                    //$tickets['one']['name'] = $one;
                    if ($group_by_2 == "")
                        $tickets['one'][$one][] = $result->data[$i];    //  1st level group
                    else if ($group_by_2 != "") {
                        $second = "";
                        if ($group_by_2 == 1)
                            $second = $result->data[$i]->trip_name;
                        if ($group_by_2 == 2)
                            $second = $result->data[$i]->user_group_name;

                        if ($group_by_3 == "") {
                            //$tickets['one'][$one]['heading'] = $second;
                            $tickets['one'][$one]['second'][$second][] = $result->data[$i];    //  2nd level group
                        } else {
                            $third = "";
                            if ($group_by_3 == 1)
                                $third = $result->data[$i]->user_group_name;
                            $tickets['one'][$one]['second'][$second]['third'][$third][] = $result->data[$i];    //  2nd level group
                        }
                    }
                }
            }
        }
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/ids_transaction_report_list_xls', array('tickets' => $tickets), true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Transaction-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/ids_transaction_report_list', array('tickets' => $tickets));
        }
    }
    //-----------------------------------

    public function revenue_report() {
        $this->is_logged_in();
        $data = array();

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        //$data['groups'] = $GroupDetail->data;
        $data['active_schedules'] = get_active_schedules();
        
        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        $data['tags'] = $tags->data;

        $this->load->view('site/report/revenue-report', $data);
    }

    public function revenue_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQF9H1363',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'travelDateFlag' => $this->input->post('date_option'),
            'userCode' => 'NA',
            'scheduleCode' => $this->input->post('schedule_code'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['user'] = $this->session->userdata('user_name');
        $bookings = array();
        $cancells = array();

        $tickets['bo_fare'] = 0;
        $tickets['bo_comission'] = 0;
        $tickets['bo_ac_tax'] = 0;
        $tickets['bo_discount'] = 0;
        $tickets['bo_payable'] = 0;

        $tickets['ca_fare'] = 0;
        $tickets['ca_ac_tax'] = 0;
        $tickets['ca_discount'] = 0;
        $tickets['ca_comission'] = 0;
        $tickets['ca_charges'] = 0;
        $tickets['ca_share'] = 0;
        $tickets['ca_refund'] = 0;

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {

                    if ($result->data[$i]->transaction_type == 'BO' || $result->data[$i]->transaction_type == 'PBL') {
                        $tickets['bo_fare'] += $result->data[$i]->ticket_amount;
                        $tickets['bo_comission'] += $result->data[$i]->commission_amount;
                        $tickets['bo_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        $tickets['bo_discount'] += $result->data[$i]->addons_amount;
                    } else {
                        $tickets['ca_fare'] += $result->data[$i]->ticket_amount;
                        $tickets['ca_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        $tickets['ca_discount'] += $result->data[$i]->addons_amount;
                        $tickets['ca_comission'] += $result->data[$i]->commission_amount;
                        $tickets['ca_charges'] += $result->data[$i]->cancellation_charges;
                        $tickets['ca_share'] += $result->data[$i]->cancel_commission;
                    }

                    if ($result->data[$i]->transaction_type == 'BO') {

//                        $datef = date($this->session->userdata('date_format'), strtotime($result->data[$i]->transaction_date));
//                        if ($data['travelDateFlag'] == 1) {
//                            $datef = date($this->session->userdata('date_format'), strtotime($result->data[$i]->travel_date));
//                        }

                        if( strtolower($result->data[$i]->user_group_name) == "customer") {
                            $result->data[$i]->user_first_name = 'Guest';
                        }

                        $bookings['date'][ucfirst($result->data[$i]->user_first_name) ][] = $result->data[$i];    //  2nd level group
                    } else {
//                        $datef = date($this->session->userdata('date_format'), strtotime($result->data[$i]->transaction_date));
//                        if ($data['travelDateFlag'] == 1) {
//                            $datef = date($this->session->userdata('date_format'), strtotime($result->data[$i]->travel_date));
//                        }

                        if( strtolower($result->data[$i]->user_group_name) == "customer") {
                            $result->data[$i]->user_first_name = 'Guest';
                        }

                        $cancells['date'][ucfirst($result->data[$i]->user_first_name)][] = $result->data[$i];    //  2nd level group
                    }

                }

                //  sort names inside date
                foreach($bookings as $k => $v){
                    ksort($bookings[$k]);
                }
                foreach($cancells as $k => $v){
                    ksort($cancells[$k]);
                }
            }
        }

        if ($this->input->post('pdf') == 1) {

            $this->load->exclude_template();
            $content = $this->load->view('site/report/reveune-report-list-pdf', array(
                    'username' => $data['user'],
                    'namespace_name' => $this->session->userdata('namespace_name'),
                    'bookings' => $bookings,
                    'tickets' => $tickets,
                    'cancels'=>$cancells), true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Reveune-report-list.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;

//            require_once APPPATH.'third_party/tcpdf/tcpdf.php';
//            $pdf = new TCPDF();
//            $pdf->setPrintHeader(false);
//            $pdf->setPrintFooter(false);
//            $pdf->SetFont('times', '', 8);
//            $pdf->AddPage();
//
//            $this->load->exclude_template();
//            $content = $this->load->view('site/report/reveune-report-list-pdf', array(
//                    'username' => $data['user'],
//                    'namespace_name' => $this->session->userdata('namespace_name'),
//                    'bookings' => $bookings,
//                    'cancels'=>$cancells), true);
//
//            $pdf->writeHTML($content);
//            $this->load->exclude_template();
//            $pdf->Output('revenue-report-summary.pdf', "i");


        } elseif ($this->input->post('pdf') == 2) { //  detailed summary
            require_once APPPATH.'third_party/tcpdf/tcpdf.php';
            $pdf = new TCPDF();
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('times', '', 8);
            $pdf->AddPage();

            $this->load->exclude_template();
            $content = $this->load->view('site/report/reveune-report-list-detailed-pdf', array(
                    'username' => $data['user'],
                    'namespace_name' => $this->session->userdata('namespace_name'),
                    'bookings' => $bookings,
                    'tickets' => $tickets,
                    'cancels'=>$cancells), true);

            $pdf->writeHTML($content);
            $this->load->exclude_template();
            $pdf->Output('revenue-report-detailed.pdf', "i");

        } else {
            $this->load->view('site/report/reveune-report-list', array(
                    'username' => $data['user'],
                    'bookings' => $bookings,
                    'tickets' => $tickets,
                    'cancels'=>$cancells)
                    );
        }
    }

    public function payment_report() {
        $this->is_logged_in();
        $data = array();

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $data['active_schedules'] = get_active_schedules();

        $tmp = array();
        foreach ($GroupDetail->data AS $grp) {
            $Groupuser = $this->api_model->getUserByGroup(array('groupcode' => $grp->code));
            $Groupuser = json_decode($Groupuser);
            $tmp[] = array(
                'code' => $grp->code,
                'name' => $grp->name,
                'userlist' => $Groupuser->data
            );
        }
        
        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        $data['tags'] = $tags->data;
        
        $data['entity'] = $tmp;
        $this->load->view('site/report/payment-report', $data);
    }

    public function payment_report_list() {
        $this->is_logged_in();
        $group_by_2 = $this->input->post('group_by');

        $user_code = $this->input->post('user_code');
        if($user_code=="NA" || $user_code=="")
            $user_code = $this->session->userdata('user_id');

        $username = $this->input->post('username');

        if($username=="NA" || $username == 'Select' || $username == '')
            $username = $this->session->userdata('user_name');


        $data = array(
            'queryCode' => 'RQF9H1363',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'travelDateFlag' => $this->input->post('date_option'),
            'userCode' => $user_code,
            'scheduleCode' => $this->input->post('schedule_code'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $tickets = array();
        $tickets['user'] = $this->session->userdata('user_name');
        $tickets['date'] = date('Y-m-d H:i:s');
        $data['option'] = $this->input->post('date_option');

        $tickets['total_fare'] = '';
        $tickets['total_refund'] = '';
        $tickets['total_cancellation'] = '';
        $tickets['username'] = $username;
        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    if ($result->data[$i]->transaction_type == 'BO') {
                        $one = date($this->session->userdata('date_format'), strtotime($result->data[$i]->transaction_date));
                        if ($data['travelDateFlag'] == 1)
                            $one = $result->data[$i]->travel_date;
                        if ($group_by_2 == "") {
                            $tickets['one'][$one][] = $result->data[$i];
                        } else if ($group_by_2 != "") {
                            $sec = $result->data[$i]->schedule_name;
                            $second = $sec;
                        }
                        $tickets['one'][$one]['second'][$second][] = $result->data[$i];    //  2nd level group
                    } else {
                        $one = date($this->session->userdata('date_format'), strtotime($result->data[$i]->transaction_date));
                        if ($data['travelDateFlag'] == 1)
                            $one = $result->data[$i]->travel_date;
                        if ($group_by_2 == "") {
                            $tickets['one1'][$one][] = $result->data[$i];
                        } else if ($group_by_2 != "") {
                            $sec = $result->data[$i]->schedule_name;
                            $second = $sec;
                        }
                        $tickets['one1'][$one]['second1'][$second][] = $result->data[$i];
                    }

                    $tickets['total_fare'] += $result->data[$i]->ticket_amount;
                    $tickets['total_refund'] += $result->data[$i]->refund_amount;
                    $tickets['total_cancellation'] += $result->data[$i]->cancellation_charges;
                    $tickets['group_by'] = $group_by_2;
                }
            }
        }

        if ($this->input->post('pdf') == 1) {

            require_once APPPATH.'third_party/tcpdf/tcpdf.php';
            $pdf = new TCPDF();
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('times', '', 8);
            $pdf->AddPage();

            $opt = 'DOJ';
            if ($data['option'] == 0) {
                $opt = 'DOB';
            }
            $usrname = $this->input->post('usrnm');
            if($this->input->post('usrnm') == 'Select' || $this->input->post('usrnm') == ''){
               $usrname = $this->session->userdata('user_name');
            }

            $bo_fr = '';
            $bo_co = '';
            $bo_re = '';
            $bo_fr1 = '';
            $bo_co1 = '';
            $bo_ca1 = '';
            $bo_com = '';
            $bo_re1 = '';
            $table1 .= ' <style>
                        .bordered td{ border:1px solid #080808; }
                        .bordered .noborder{ border:1px solid #fff; }
                        .bold{ font-weight:bold; }
                    </style>';
            $table1 .= '<table width="100%" cellpadding="5">
                        <tr>
                            <td width="100%" align="center" style="font-weight:bold">'. $this->session->userdata('namespace_name') .'</td>
                        </tr>
                        <tr>
                            <td width="100%" align="center">Payment Receipt</td>
                        </tr>
                        </table>';
            $table1 .= '
                        <table width="100%" cellpadding="3">
                        <tr>
                            <td width="10%"></td>
                            <td width="40%">Report Date :  ' . $this->input->post('from') . '-' . $this->input->post('to') . ', ' . $opt . '</td>
                            <td width="40%" >Report At :  ' . date('Y-m-d H:i:s') . '</td>
                        </tr>
                        <tr>
                            <td width="10%"></td>
                            <td width="40%">Booked By : ' . $usrname . '</td>
                            <td width="40%" >Created By : ' . $this->session->userdata('user_name') . '</td>
                        </tr>
                    </table>';
            $table1 .= '<table>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td size="12" style="font-weight:bold">Booking</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        </table>

                        <table class="bordered" width="100%" cellpadding="3">
                        <tr >
                            <td width="13%" align="center" class="bold">PNR</td>
                            <td width="17%" align="center" class="bold">Route</td>
                            <td width="10%" align="center" class="bold">DOT</td>
                            <td width="10%" align="center" class="bold">DOJ</td>
                            <td align="center" width="15%" class="bold">Seats</td>
                            <td align="center" width="8%" class="bold">No. of Tkt</td>
                            <td align="center" width="9%" class="bold">Txn Amount</td>
                            <td align="center" width="9%" class="bold">Agent Commission</td>
                            <td align="center" width="9%" class="bold">Balance</td>
                        </tr>';
            foreach ($tickets['one'] as $tone => $tne) {
                if ($tickets['group_by'] == "") {
                    if($tone != ''){
                    $table1 .= '<tr>
                                    <td  style="font-weight:bold" colspan="9" align="left">' . $tone . '</td>
                                </tr>';
                    }
                }
                foreach ($tne as $ticket) {
                    if ($tickets['group_by'] == '') {
                        if ($ticket->ticket_code != '') {
                            $table1 .= '<tr>
                                <td align="left">' . $ticket->ticket_code . '</td>
                                <td align="left">' . $ticket->from_station_name . '-' . $ticket->to_station_name . '</td>
                                <td align="center">' . date('d-m-Y', strtotime($ticket->transaction_date)) . '</td>
                                <td align="center">' . $ticket->travel_date . '</td>
                                <td align="left">' . $ticket->seat_name . '</td>
                                <td align="center">' . $ticket->seat_count . '</td>
                                <td align="right">' . $ticket->ticket_amount . '</td>
                                <td align="right">' . $ticket->commission_amount . '</td>
                                <td align="right">' . $ticket->net_amount . '</td>
                            </tr>';
                            $bo_tk += $ticket->seat_count;
                            $bo_fr += $ticket->ticket_amount;
                            $bo_co += $ticket->commission_amount;
                            $bo_re += $ticket->net_amount;
                        }
                    } else {
                        if($tone != ''){
                            $table1 .= '<tr>
                                               <td style="font-weight:bold" colspan="9" align="left">' . $tone . '</td>
                                        </tr>';
                            }

                        foreach ($ticket as $tk => $t2) {
                            $table1 .= '<tr>
                                            <td style="font-weight:bold" colspan="9"  align="left">' . $tk . '</td>
                                        </tr>';

                            foreach ($t2 as $ticket) {
                                if ($ticket->ticket_code != '') {
                                    $table1 .= '<tr>
                                                    <td align="left">' . $ticket->ticket_code . '</td>
                                                    <td align="left">' . $ticket->from_station_name . '-' . $ticket->to_station_name . '</td>
                                                    <td align="center">' . date('d-m-Y', strtotime($ticket->transaction_date)) . '</td>
                                                    <td align="center">' . $ticket->travel_date . '</td>
                                                    <td align="left">' . $ticket->seat_name . '</td>
                                                    <td align="center">' . $ticket->seat_count . '</td>
                                                    <td align="right">' . $ticket->ticket_amount . '</td>
                                                    <td align="right">' . $ticket->commission_amount . '</td>
                                                    <td align="right">' . $ticket->net_amount . '</td>
                                                </tr>';
                                    $bo_tk += $ticket->seat_count;
                                    $bo_fr += $ticket->ticket_amount;
                                    $bo_co += $ticket->commission_amount;
                                    $bo_re += $ticket->net_amount;
                                }
                            }
                        }
                    }
                }
            }
            $table1 .= '<tr>
                <td colspan="5" style="font-weight:bold" align="right">Sub Total</td>
                <td  align="center"  style="bold">' .$bo_tk . '</td>
                <td  align="right"  style="bold">' .number_format($bo_fr,2) . '</td>
                <td  align="right"  style="bold">' . number_format($bo_co,2) . '</td>
                <td align="right" style="bold">' . number_format($bo_re,2) . '</td>
            </tr></table>';



            //cancellation

            $table1 .= '<table>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td size="10" style="font-weight:bold">Cancellation</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        </table>';

            $table1 .= '<table class="bordered" cellpadding="3">
                            <tr >
                                <td  width="13%" align="center" class="bold">PNR</td>
                                <td  width="18%" align="center" class="bold">Route</td>
                                <td  width="9%" align="center" class="bold">DOT</td>
                                <td  width="9%" align="center" class="bold">DOJ</td>
                                <td  width="8%" align="center" class="bold">Seats</td>
                                <td  width="6%" align="center" class="bold">No. of Tkt</td>
                                <td  width="8%" align="center" class="bold">Txn Amount</td>
                                <td  width="7%" align="center" class="bold">Revoke Commission</td>
                                <td  width="7%" align="center" class="bold">Canl Charges</td>
                                <td  width="7%" align="center" class="bold">Canl Commission</td>
                                <td  width="8%" align="center" class="bold">Refund</td>
                            </tr>';


            foreach ($tickets['one1'] as $tone => $tne) {
                if ($tickets['group_by'] == "") {
                    if($tone != ''){
                        $table1 .= '<tr>
                                        <td align="left" style="font-weight:bold" colspan="11">' . $tone . '</td>
                                    </tr>';
                    }
                }
                foreach ($tne as $ticket) {
                    if ($tickets['group_by'] == '') {
                        if ($ticket->ticket_code != '') {
                            $table1 .= '<tr>
                                            <td align="left">' . $ticket->ticket_code . '</td>
                                            <td align="left">' . $ticket->from_station_name . '-' . $ticket->to_station_name . '</td>
                                            <td align="center">' . date('d-m-Y', strtotime($ticket->transaction_date)) . '</td>
                                            <td align="center">' . $ticket->travel_date . '</td>
                                            <td align="center">' . $ticket->seat_name . '</td>
                                            <td align="center">' . $ticket->seat_count . '</td>
                                            <td align="right">' . $ticket->ticket_amount . '</td>
                                            <td align="right">' . $ticket->revoke_commission_amount . '</td>
                                            <td align="right">' . $ticket->cancellation_charges . '</td>
                                            <td align="right">' . $ticket->cancel_commission . '</td>
                                            <td align="right">' . $ticket->refund_amount . '</td>
                                        </tr>';
                             $ca_tk += $ticket->seat_count;
                             $bo_fr1 += $ticket->ticket_amount;
                             $bo_co1 += $ticket->revoke_commission_amount;
                             $bo_ca1 += $ticket->cancellation_charges;
                             $bo_com += $ticket->cancel_commission;
                             $bo_re1 += $ticket->refund_amount;
                        }
                    } else {
                        if($tone != ''){
                            $table1 .= '<tr>
                                           <td align="left" style="font-weight:bold" colspan="11">' . $tone . '</td>
                                        </tr>';
                    }

                        foreach ($ticket as $tk => $t2) {
                            $table1 .= '<tr>
                                            <td align="left" style="font-weight:bold" colspan="11">' . $tk . '</td>
                                        </tr>';

                            foreach ($t2 as $ticket) {
                                if ($ticket->ticket_code != '') {
                                    $table1 .= '<tr>
                                                    <td align="left">' . $ticket->ticket_code . '</td>
                                                    <td align="left">' . $ticket->from_station_name . '-' . $ticket->to_station_name . '</td>
                                                    <td align="center">' . date('d-m-Y', strtotime($ticket->transaction_date)) . '</td>
                                                    <td align="center">' . $ticket->travel_date . '</td>
                                                    <td align="left">' . $ticket->seat_name . '</td>
                                                    <td align="center">' . $ticket->seat_count . '</td>
                                                    <td align="right">' . $ticket->ticket_amount . '</td>
                                                    <td align="right">' . $ticket->revoke_commission_amount . '</td>
                                                    <td align="right">' . $ticket->cancellation_charges . '</td>
                                                    <td align="right">' . $ticket->cancel_commission . '</td>
                                                    <td align="right">' . $ticket->refund_amount . '</td>
                                                </tr>';
                                     $ca_tk += $ticket->seat_count;
                                     $bo_fr1 += $ticket->ticket_amount;
                                     $bo_co1 += $ticket->revoke_commission_amount;
                                     $bo_ca1 += $ticket->cancellation_charges;
                                     $bo_com += $ticket->cancel_commission;
                                     $bo_re1 += $ticket->refund_amount;
                                 }
                            }
                        }
                    }
                }

            }
            $tot = $tickets['total_fare'] - ($tickets['total_refund'] + $tickets['total_cancellation']);

            $table1 .= '<tr>
                            <td colspan="5" style="font-weight:bold" align="right">Sub Total</td>
                            <td  align="center" style="bold">' . $ca_tk . '</td>
                            <td  align="right" style="bold">' . number_format($bo_fr1,2) . '</td>
                            <td  align="right" style="bold">' . number_format($bo_co1,2) . '</td>
                            <td align="right" style="bold">' . number_format($bo_ca1,2) . '</td>
                            <td  align="right" style="bold">' . number_format($bo_com,2) . '</td>
                            <td align="right" style="bold">' . number_format($bo_re1,2) . '</td>
                        </tr>

            </table>';

            $table1 .= '<table>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td size="10" style="font-weight:bold">Summary</td>
                        </tr>
                        </table>';


            $table1 .= '<table cellpadding="3" class="bordered">
                            <tr>
                                <td class="bold"  colspan="2" align="center" >Booking</td>
                                <td class="bold"  colspan="2" align="center" >Cancellation</td>
                                <td style="bold" class="noborder" width="30"  ></td>
                                <td style="bold" class="noborder" ></td>
                            </tr>
                            <tr>
                                <td class="bold"  >Fare</td>
                                <td  align="right">'.number_format($bo_fr,2).'</td>
                                <td class="bold" >Fare</td>
                                <td  align="right">'.number_format($bo_fr1,2).'</td>

                                <td style="bold" class="noborder" ></td>
                                <td style="bold" class="noborder" ></td>
                            </tr>
                            <tr>
                                <td class="bold"  >Commission </td>
                                <td  align="right">'.number_format($bo_co,2).'</td>
                                <td class="bold" >Charges</td>
                                <td  align="right">'.number_format($bo_ca1,2).'</td>

                                <td style="bold" class="noborder"  ></td>
                                <td class="noborder" >Agent Name</td>
                            </tr>
                            <tr>
                                <td style="bold"  ></td>
                                <td style="bold" ></td>
                                <td class="bold" >Revoke Commission</td>
                                <td  align="right">'.number_format($bo_co1,2).'</td>

                                <td style="bold" class="noborder" ></td>
                                <td style="bold" class="noborder" ></td>
                            </tr>
                            <tr>
                                <td style="bold"  ></td>
                                <td style="bold" ></td>
                                <td class="bold" >Agent Cancellation Charges</td>
                                <td  align="right">'.number_format($bo_com,2).'</td>

                                <td style="bold" class="noborder" ></td>
                                <td style="bold" class="noborder" ></td>
                            </tr>
                            <tr>
                                <td class="bold"  >Total (A)</td>
                                <td  align="right">'.number_format($bo_re,2).'</td>
                                <td  class="bold" >Total (B)</td>
                                <td  align="right">'.number_format($bo_re1-$bo_com,2).'</td>

                                <td style="bold" class="noborder"></td>
                                <td class="noborder" >Signature</td>
                            </tr>
                            <tr>
                                <td style="bold"  colspan="3" class="bold" >Net Payable (A-B)</td>
                                <td style="bold"  align="right" class="bold">'.number_format($bo_re-($bo_re1-$bo_com),2).'</td>

                                <td style="bold" class="noborder"></td>
                                <td class="noborder" ></td>
                            </tr>
                        </table>

                        ';

            $pdf->writeHTML($table1);
            $this->load->exclude_template();
            $pdf->Output('payment-receipt.pdf', "i");


        } else {
            $this->load->view('site/report/payment-report-list', array('tickets' => $tickets));
        }
    }

    public function settlement_report() {
        $this->is_logged_in();
        $data = array();

        $org_code = $this->session->userdata('org_code');
        $user_id = $this->session->userdata('user_id');

        if(has_action_rights('SETT-USER-FILTER')) {

            if(has_action_rights('SETT-ONLY-NATVE-USER')) {
                $users = $this->api_model->getUser();
                $users = json_decode($users);
                $tmp = array();
                foreach ($users->data AS $user) {
                    if($user->organization->code==$org_code) {
                        $tmp[] = array(
                           'code' => $user->code,
                           'name' => $user->name,
                        );
                    }
                }
            } else {
                $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
                $GroupDetail = json_decode($GroupDetail);
                $data['groups'] = $GroupDetail->data;

                $tmp = array();
                foreach ($GroupDetail->data AS $grp) {
                    $Groupuser = $this->api_model->getUserByGroup(array('groupcode' => $grp->code)); dir;
                    $Groupuser = json_decode($Groupuser);
                    $tmp[] = array(
                        'code' => $grp->code,
                        'name' => $grp->name,
                        'userlist' => $Groupuser->data
                    );
                }
            }
        }
        $data['entity'] = $tmp;
        $data['user_id'] = $user_id;
        $this->load->view('site/report/settlement-report', $data);
    }

    public function settlement_report_list() {
        $this->is_logged_in();

        $user_code = $this->input->post('user_code');
        if($user_code=="NA" || $user_code=="")
            $user_code = $this->session->userdata('user_id');

        $username = $this->input->post('username');

        if($username=="NA" || $username == 'Select' || $username == '')
            $username = $this->session->userdata('user_name');


        $data = array(
            'queryCode' => 'RQG6QM3610',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'userCode' => $user_code,
        );

        $p_key = _get_namespace_id().'_settlement_report_'.md5(http_build_query($data));
        if ($this->input->post('pdf') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }

        $result = json_decode($result);
        $tickets = array();
        $tickets['user'] = $this->session->userdata('user_name');
        $tickets['date'] = date('Y-m-d H:i:s');
        $data['option'] = 1;

        $tickets['bo_fare'] = '';
        $tickets['bo_discount'] = '';
        $tickets['bo_comission'] = '';
        $tickets['bo_ac_tax'] = '';
        $tickets['bo_payable'] = '';

        $tickets['ca_fare'] = '';
        $tickets['ca_discount'] = '';
        $tickets['ca_ac_tax'] = '';
        $tickets['ca_charges'] = '';
        $tickets['ca_share'] = '';
        $tickets['ca_refund'] = '';

        $tickets['username'] = $username;

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    if ($result->data[$i]->transaction_type == 'BO') {

                        $tickets['bo_fare'] += $result->data[$i]->ticket_amount;
                        $tickets['bo_discount'] += $result->data[$i]->addon_amount;
                        $tickets['bo_comission'] += $result->data[$i]->commission_amount;
                        $tickets['bo_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        $result->data[$i]->payable = ($result->data[$i]->ticket_amount-$result->data[$i]->addon_amount+$result->data[$i]->ac_bus_tax-$result->data[$i]->commission_amount);
                        $tickets['bo_payable'] += $result->data[$i]->payable;

                        $tickets['booking'][] = $result->data[$i];
                    } else {
                        $tickets['ca_fare'] += $result->data[$i]->ticket_amount;
                        $tickets['ca_discount'] += $result->data[$i]->addon_amount;
                        $tickets['ca_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        $tickets['ca_charges'] += $result->data[$i]->cancellation_charges;
                        $tickets['ca_share'] += $result->data[$i]->cancel_commission;
                        $result->data[$i]->refund = ($result->data[$i]->ticket_amount-$result->data[$i]->addon_amount+$result->data[$i]->ac_bus_tax-$result->data[$i]->cancellation_charges);
                        $tickets['ca_refund'] += $result->data[$i]->refund;

                        $tickets['cancel'][] = $result->data[$i];
                    }

                    $tickets['total_fare'] += $result->data[$i]->ticket_amount;
                    $tickets['total_refund'] += $result->data[$i]->refund_amount;
                    $tickets['total_cancellation'] += $result->data[$i]->cancellation_charges;
                }
            }
        }

        if ($this->input->post('pdf') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/settlement-report-list-xls', array(
                    'username' => $tickets['user'],
                    'namespace_name' => $this->session->userdata('namespace_name'),
                    'tickets' => $tickets), true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=settlement-report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;


        } else {
            $this->load->view('site/report/settlement-report-list', array('tickets' => $tickets));
        }
    }

    public function userbooking_report() {
        $this->is_logged_in();
        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $tmp = array();
        foreach ($GroupDetail->data AS $grp) {
            $Groupuser = $this->api_model->getUserByGroup(array('groupcode' => $grp->code));
            $Groupuser = json_decode($Groupuser);
            $tmp[] = array(
                'code' => $grp->code,
                'name' => $grp->name,
                'userlist' => $Groupuser->data
            );
        }
        $data['entity'] = $tmp;

        $this->load->view('site/report/userbooking_report', $data);
    }

    public function userbooking_report_list() {
        $this->is_logged_in();

        $user_id = $this->session->userdata('user_id');
        if ($this->input->post('user') != "")
            $user_id = $this->input->post('user');

        $pbflag = $this->input->post('pbl_flag');
        if($pbflag=='on') $pbflag = 1;
        if($pbflag=='') $pbflag = 0;

        $group_by_2 = $this->input->post('group_by_2');
        $group_by_3 = $this->input->post('group_by_3');
        $data = array(
            'queryCode' => 'RQF2AI22',
            'userCode' => $user_id,
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'phoneBookFlag' => $pbflag,
            'travelDateFlag' => $this->input->post('date_option'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);

        $result = json_decode($result);
        $tickets = array();

        $tickets['bo_fare'] = 0;
        $tickets['bo_comission'] = 0;
        $tickets['bo_ac_tax'] = 0;
        $tickets['bo_discount'] = 0;
        $tickets['bo_payable'] = 0;

        $tickets['ca_fare'] = 0;
        $tickets['ca_ac_tax'] = 0;
        $tickets['ca_discount'] = 0;
        $tickets['ca_comission'] = 0;
        $tickets['ca_charges'] = 0;
        $tickets['ca_share'] = 0;
        $tickets['ca_refund'] = 0;

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {

                    $one = date($this->session->userdata('date_format'), strtotime($result->data[$i]->transaction_date));
                    if ($data['travelDateFlag'] == 1)
                        $one = $result->data[$i]->travel_date;

                    $tickets['one'][$one][] = $result->data[$i];    //  1st level group

                    if ($result->data[$i]->ticket_status_code == 'BO' || $result->data[$i]->ticket_status_code == 'PBL' || $result->data[$i]->ticket_status_code == 'TCKTR') {
                        $tickets['bo_fare'] += $result->data[$i]->ticket_amount;
                        $tickets['bo_comission'] += $result->data[$i]->commission_amount;
                        $tickets['bo_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        $tickets['bo_discount'] += $result->data[$i]->addons_amount;
                        $result->data[$i]->payable = ($result->data[$i]->ticket_amount+$result->data[$i]->ac_bus_tax-$result->data[$i]->addons_amount-$result->data[$i]->commission_amount);
                        $tickets['bo_payable'] += $result->data[$i]->payable;
                    } else {
                        $tickets['ca_fare'] += $result->data[$i]->ticket_amount;
                        $tickets['ca_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        $tickets['ca_discount'] += $result->data[$i]->addons_amount;
                        $tickets['ca_comission'] += $result->data[$i]->commission_amount;
                        $tickets['ca_charges'] += $result->data[$i]->cancellation_charges;
                        $tickets['ca_share'] += $result->data[$i]->cancel_commission_amount;
                        $tickets['ca_refund'] += $result->data[$i]->refund_amount + $result->data[$i]->revoke_commission_amount;
                    }

                }
            }
        }
        $data['paymode'] = config_item('transaction_mode');
        $data['tickets'] = $tickets;
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/userbooking_report_list_xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=User-Booking-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/userbooking_report_list',$data);
        }
    }

    public function consolidated_booking_report() {
        $this->is_logged_in();
        
        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        $data['route'] = $routes;
        $data['active_schedules'] = get_active_schedules();
        $data['groupusers'] = get_active_group_and_users();
        $data['tags'] = $tags->data;

        $this->load->view('site/report/consolidated_booking_report', $data);
    }

    public function consolidated_booking_report_list() {
        $sch_code = trim($this->input->post('schedule_code'));
        if(empty($sch_code)) {
            $sch_code = 'NA';
        }

        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQF3K85511',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'travelDateFlag' => $this->input->post('date_option'),
            'scheduleCode' => $sch_code,
            'fromStationCode' => $this->input->post('from_code'),
            'toStationCode' => $this->input->post('to_code'),
            'groupCode' => $this->input->post('group_code'),
            'userCode' => $this->input->post('user_code'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $tickets = array();

        $t_book_summary = array();
        $t_cancel_summary = array();
        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    if ($result->data[$i]->user_group_name == "")
                        continue;
                    $t_book_summary[$result->data[$i]->user_group_name] += $result->data[$i]->booked_count;
                    $t_book_summary[$result->data[$i]->user_group_name] += $result->data[$i]->phone_booked_count;
                    $t_book_summary[$result->data[$i]->user_group_name] += $result->data[$i]->phone_blocked_count;

                    $t_cancel_summary[$result->data[$i]->user_group_name] += $result->data[$i]->cancelled_count;
                    $t_cancel_summary[$result->data[$i]->user_group_name] += $result->data[$i]->phone_booked_cancelled_count;
                }
            }
        }
        if (count($t_book_summary) > 0) {
            foreach ($t_book_summary as $k => $v) {
                $book_summary[] = array('label' => $k, 'data' => $v);
            }
        }
        if (count($t_cancel_summary) > 0) {
            foreach ($t_cancel_summary as $k => $v) {
                $cancel_summary[] = array('label' => $k, 'data' => $v);
            }
        }

        $data = array(
            'transactions' => $result->data,
            'book_summary' => $book_summary,
            'cancel_summary' => $cancel_summary,
        );

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/consolidated-booking-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Consolidated_report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/consolidated_booking_report_list', $data);
        }
    }

    public function cancellation_report() {
        $this->is_logged_in();
        
        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        $data['route'] = $routes;
        $data['active_schedules'] = get_active_schedules();
        $data['groupusers'] = get_active_group_and_users();
        $data['tags'] = $tags->data;

        $this->load->view('site/report/cancellation_report', $data);
    }

    public function cancellation_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQFA5NR5',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'travelDateFlag' => $this->input->post('date_option'),
            'scheduleCode' => $this->input->post('schedule_code'),
            'fromStationCode' => $this->input->post('from_code'),
            'toStationCode' => $this->input->post('to_code'),
            'groupCode' => $this->input->post('group_code'),
            'userCode' => $this->input->post('user_code'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $tickets = array();

        $t_cancel_summary = array();
        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    if ($result->data[$i]->user_group_name == "")
                        continue;
//                    $t_book_summary[$result->data[$i]->user_group_name] += $result->data[$i]->booked_count;
//                    $t_book_summary[$result->data[$i]->user_group_name] += $result->data[$i]->phone_booked_count;
//                    $t_book_summary[$result->data[$i]->user_group_name] += $result->data[$i]->phone_blocked_count;

                    $t_cancel_summary[$result->data[$i]->user_group_name] += $result->data[$i]->seat_count;
                    //$t_cancel_summary[$result->data[$i]->user_group_name] += $result->data[$i]->phone_booked_cancelled_count;
                }
            }
        }
//        if (count($t_book_summary) > 0) {
//            foreach ($t_book_summary as $k => $v) {
//                $book_summary[] = array('label' => $k, 'data' => $v);
//            }
//        }
        if (count($t_cancel_summary) > 0) {
            foreach ($t_cancel_summary as $k => $v) {
                $cancel_summary[] = array('label' => $k, 'data' => $v);
            }
        }

        $data = array(
            'refund_status' => config_item('refund_status'),
            'transactions' => $result->data,
            //'book_summary' => $book_summary,
            'cancel_summary' => $cancel_summary,
        );

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/cancellation_report_list_xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Cancellation_report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/cancellation_report_list', $data);
        }
    }

    public function phonebook_cancellation_report() {
        $this->is_logged_in();
        $data = array();

        $this->load->view('site/report/phonebook_cancellation_report', $data);
    }

    public function phonebook_cancellation_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQF26919',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'travelDateFlag' => $this->input->post('date_option'),
            'userCode' => 'NA',
            'filterTypeCode' => 'PBC'
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $tickets = array();


        $data = array(
            'refund_status' => config_item('refund_status'),
            'transactions' => $result->data,
        );

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/phonebook_cancellation_report_list_xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=PhoneBook_Cancellation_report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/phonebook_cancellation_report_list', $data);
        }
    }

    public function customers_report() {
        $this->is_logged_in();
        $this->load->view('site/report/customers-report');
    }

    public function customers_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQFCF8Z8',
            'roleCode' => $this->input->post('user_role'),
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['user_name'] = $this->session->userdata('user_name');
        $data['customers'] = $result->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/customers-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Customers-'.$data['roleCode'].'-'.date("d-m-Y").'.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/customers-report-list', $data);
        }
    }

    public function travel_report() {
        $this->is_logged_in();
        $this->load->view('site/report/travel_report');
    }

    public function travel_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQECHE10',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'travelDateFlag' => 1,
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $tickets = array();

        $t_book_summary = array();
        $t_cancel_summary = array();
        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    if ($result->data[$i]->user_group_name == "")
                        continue;
                    $t_book_summary[$result->data[$i]->user_group_name] += $result->data[$i]->booked_count;
                    $t_book_summary[$result->data[$i]->user_group_name] += $result->data[$i]->phone_booked_count;
                    $t_book_summary[$result->data[$i]->user_group_name] += $result->data[$i]->phone_blocked_count;

                    $t_cancel_summary[$result->data[$i]->user_group_name] += $result->data[$i]->cancelled_count;
                    $t_cancel_summary[$result->data[$i]->user_group_name] += $result->data[$i]->phone_booked_cancelled_count;
                }
            }
        }
        if (count($t_book_summary) > 0) {
            foreach ($t_book_summary as $k => $v) {
                $book_summary[] = array('label' => $k, 'data' => $v);
            }
        }
        if (count($t_cancel_summary) > 0) {
            foreach ($t_cancel_summary as $k => $v) {
                $cancel_summary[] = array('label' => $k, 'data' => $v);
            }
        }
        $this->load->view('site/report/travel_report_list', array(
            'transactions' => $result->data,
            'book_summary' => $book_summary,
            'cancel_summary' => $cancel_summary,
        ));
    }

    /* public function cancellation_report() {
      $this->is_logged_in();
      _include_js('assets/js/pages/jqGridCanRpt.js');
      _include_js('assets/js/pages/CancRpt.debug.js', 'init_cancellation_report');
      $this->load->view('site/report/cancellation_report');
      }

      public function cancellation_trip_list() {
      $this->is_logged_in();
      $tripDate = $this->input->get('tripDate');
      $tripList = $this->api_model->getTripList(array('tripDate' => $tripDate));
      print $tripList;
      //return json_decode($tripList);
      }

      public function get_report_data() {
      $this->is_logged_in();
      $data = array(
      'queryCode' => $this->input->get('reportCode'),
      'toDate' => $this->input->get('toDate'),
      'fromDate' => $this->input->get('fromDate'),
      'tripCode' => $this->input->get('tripCode'),
      'groupBy' => $this->input->get('groupBy'),
      );
      echo $reportData = $this->api_model->getReportData($data);
      }

      public function agent_report() {
      $this->is_logged_in();
      _include_js('assets/js/pages/jqGridAgentRpt.js');
      _include_js('assets/js/pages/AgentRpt.debug.js', 'init_Agent_report');
      $this->load->view('site/report/Agent_report1');
      } */

    public function pending_order() {
        $this->is_logged_in();
        _include_js('assets/js/pages/pending-order.js', '_init_pending_order_page');
        $this->load->view('site/report/pending-order');
    }

    public function get_pending_order_list() {
        $this->is_logged_in();
        if($this->input->post('order') == 'pending'){
            $type = 'PENDG';
        } else if($this->input->post('order') == 'denied'){
            $type = 'DENIL';
        } else if($this->input->post('order') == 'blocked'){
            $type = 'BLCA';
        } else{
            $type = 'FAILR';
        }

        $data = array(
            'queryCode' => 'RQF9GLR2',
            'filterCode' => $type
        );
        if ($this->input->post('from') != '') {
            $data['fromDate'] = $this->input->post('from');
        }
        if ($this->input->post('to') != '') {
            $data['toDate'] = $this->input->post('to');
        }
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['pending_orders'] = $result;
        if ($this->input->post('order') == 'pending') {
            $this->load->view('site/report/pending-order-list', $data);
        } else if ($this->input->post('order') == 'denied') {
            $this->load->view('site/report/denied-order-list', $data);
        } else if ($this->input->post('order') == 'blocked') {
            $this->load->view('site/report/block-cancelled-list', $data);
        } else {
            $this->load->view('site/report/failure-order-list', $data);
        }
    }

    public function get_confirm_busmap() {
        $nsswitched = false;
        $this->is_logged_in();
        
        $tripCode = $this->input->post('tripCode');
        $stageCode = $this->input->post('stageCode');
        $travelDate = $this->input->post('travelDate');
        $fromCode = $this->input->post('fromCode');
        $toCode = $this->input->post('toCode');

        $ticketNsCode = $this->input->post('nsCode');
        $loginNsCode = $this->session->userdata('namespace_id');

        if($ticketNsCode!=$loginNsCode) {   //  switch to ticket namespace
            $param = array(
                'code' => $ticketNsCode,
            );
            $space = $this->api_model->getswitchNamespace($param);
            $nsswitched = true;
        }

        $busMap = $this->api_model->getScheduleBusMap_v3(array(
            'stageCode' => $stageCode,
            'tripCode' => $tripCode,
            'travelDate' => date('Y-m-d', strtotime($travelDate)),
            'fromCode' => $fromCode,
            'toCode' => $toCode,
        ));
        
        $busMap = json_decode($busMap);
        $busMap = $busMap->data;
        $lseatrow = array();
        $lseatcol = array();
        $useatrow = array();
        $useatcol = array();
        $seatStatus = array();
        $seatDetails = array();

        foreach ($busMap->bus->seatLayoutList as $bs) {
            if ($bs->layer == 1) {
                $lseatrow[] = $bs->rowPos;
                $lseatcol[] = $bs->colPos;
                $seatStatus["1" . $bs->rowPos . $bs->colPos] = array('status' => $bs->seatStatus, 'code' => $bs->code, 'fare' => $bs->seatFare, 'seatName' => $bs->seatName, 'seatType' => $bs->busSeatType->name, 'userName' => $bs->user->name, 'groupName' => $bs->group->name);
            }
            if ($bs->layer == 2) {
                $useatrow[] = $bs->rowPos;
                $useatcol[] = $bs->colPos;
                $seatStatus["2" . $bs->rowPos . $bs->colPos] = array('status' => $bs->seatStatus, 'code' => $bs->code, 'fare' => $bs->seatFare, 'seatName' => $bs->seatName, 'seatType' => $bs->busSeatType->name, 'userName' => $bs->user->name, 'groupName' => $bs->group->name);
            }
            $seatDetails[$bs->code] = array('fare' => $bs->seatFare, 'seatName' => $bs->seatName, 'serviceTax' => $bs->serviceTax, 'genderstatus' => $bs->seatStatus->code);
        }

        $data = array(
            'busmap' => $busMap,
            'busseatlayer' => $busMap->bus->seatLayoutList,
            'lrowmax' => max($lseatrow),
            'lrowmin' => min($lseatrow),
            'lcolmax' => max($lseatcol),
            'lcolmin' => min($lseatcol),
            'seatStatus' => $seatStatus,
            'seatDetails' => $seatDetails
        );

        $seattype = $this->api_model->getBusSeatType();
        $busseat = json_decode($seattype);
        $data['seattype'] = $busseat->data;

        if (count($useatrow) > 0 && count($useatcol) > 0) {
            $data['urowmax'] = max($useatrow);
            $data['urowmin'] = min($useatrow);
            $data['ucolmax'] = max($useatcol);
            $data['ucolmin'] = min($useatcol);
        }

        if($nsswitched) {   //  is switch to ticket namespace
            $param = array(
                'code' => $loginNsCode
            );
            $space = $this->api_model->getswitchNamespace($param);
        }

        echo json_encode($data);
        //$this->load->view('site/search/get-busmap',$data);
    }

    function get_pending_ticket_details() {
        $nsswitched = false;
        $this->is_logged_in();

        $ticketNsCode = $this->input->post('nsCode');
        $loginNsCode = $this->session->userdata('namespace_id');

        if($ticketNsCode!=$loginNsCode) {   //  switch to ticket namespace
            $param = array(
                'code' => $ticketNsCode,
            );
            $space = $this->api_model->getswitchNamespace($param);
            $nsswitched = true;
        }

        $data = array();
        $ticketlist = $this->api_model->ticketDetails(array('ticketCode' => $this->input->post('ticketpnrcode')));
        $ticketlist = json_decode($ticketlist);
        if ($ticketlist->status == 1) {
            $data['reports'] = $ticketlist->data;
            $data['code'] = $this->input->post('ticketpnrcode');
        }

        if($nsswitched) {   //  is switch to ticket namespace
            $param = array(
                'code' => $loginNsCode
            );
            $space = $this->api_model->getswitchNamespace($param);
        }

        $this->load->view('site/report/pending-ticket-details', $data);
    }

    public function cancel_pending_order() {
        $this->is_logged_in();
        $nsswitched = false;

        $ticketNsCode = $this->input->post('nsCode');
        $loginNsCode = $this->session->userdata('namespace_id');

        if($ticketNsCode!=$loginNsCode) {   //  switch to ticket namespace
            $param = array(
                'code' => $ticketNsCode,
            );
            $space = $this->api_model->getswitchNamespace($param);
            $nsswitched = true;
        }

        $data = array('ticketCode' => $this->input->post('ticketcode'), 'transactionCode' => $this->input->post('bookingcode'));
        $status = $this->api_model->cancelPendingOrder($data);

        if($nsswitched) {   //  is switch to ticket namespace
            $param = array(
                'code' => $loginNsCode
            );
            $space = $this->api_model->getswitchNamespace($param);
        }

        echo $status;
    }

    public function confirm_pending_order() {
        $this->is_logged_in();

        $nsswitched = false;

        $ticketNsCode = $this->input->post('nsCode');
        $loginNsCode = $this->session->userdata('namespace_id');

        if($ticketNsCode!=$loginNsCode) {   //  switch to ticket namespace
            $param = array(
                'code' => $ticketNsCode,
            );
            $space = $this->api_model->getswitchNamespace($param);
            $nsswitched = true;
        }

        $data = array(
            'ticketcode' => $this->input->post('pnr_code'),
            'seatcode' => $this->input->post('seat_codes')
        );
        $status = $this->api_model->confirmPendingOrder($data);

        if($nsswitched) {   //  is switch to ticket namespace
            $param = array(
                'code' => $loginNsCode
            );
            $space = $this->api_model->getswitchNamespace($param);
        }

        echo $status;
    }
    
    public function move_failure_order_to_pending() {
        $this->is_logged_in();
        $data = array(
            'ticketCode' => $this->input->post('ticketcode')
        );
        $status = $this->api_model->moveFailureToPending($data);
        echo $status;
    }

    public function refund() {
        $this->is_logged_in();
        $data = array();
        $data['statusCode'] = 'INI';
        $refundDetails = $this->api_model->getrefund($data);
        $refundlist = json_decode($refundDetails);
        $data['refund_list'] = $refundlist->data;
        $this->load->view('site/report/refund', $data);
    }

    public function updateRefund() {
        $this->is_logged_in();
//        echo 'Amount refunded';
        $data = array(
            'statusCode' => $this->input->post('statusCode'),
            'transactionCode' => $this->input->post('transactionCode'),
            'activeFlag' => $this->input->post('activeFlag')
        );
        $status = $this->api_model->updaterefund($data);
        echo $status;
    }

    public function payment_gateway_transactions() {
        $this->is_logged_in();
        $this->load->view('site/report/payment-gateway-transactions');
    }

    function payment_gateway_transactions_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQG585537',
            'fromDate' => $this->input->post('from'),
            'toDate' => $this->input->post('to')
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $feeds = array();
        $pay = 0; $refund = 0; $service_charge = 0;

        foreach ((array) $result->data as $trans) {
            if($trans->transaction_type_code=='PAY') {
               $pay +=  $trans->transaction_amount;
            } else if($trans->transaction_type_code=='RFD') {
                $refund +=  $trans->transaction_amount;
            }
            $service_charge += $trans->service_charge;
            $feeds[] = $trans;
        }
        $data = array(
            'username' => $this->session->userdata('user_name'),
            'reports' => $feeds,
            'amounts' => array(
                        'booking' => $pay,
                        'refund' => $refund,
                        'service_charges' => $service_charge
                        )
            );

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/payment-gateway-transactions-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=payment-gateway-transaction-report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/payment-gateway-transactions-report-list', $data);
        }
    }

    public function reconciliation_report() {
        $this->is_logged_in();
        $this->load->view('site/report/reconciliation_report');
    }

    function reconciliation_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQG9QM912',
            'fromDate' => $this->input->post('from'),
            'toDate' => $this->input->post('to'),
            'filterCode' => $this->input->post('filterCode')
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $feeds = array();
        $user_amount = array();
        $user_trans = array();

        foreach ((array) $result->data as $trans) {
            $user_amount[$trans->user_first_name] += $trans->transaction_amount;
            $user_trans[$trans->user_first_name]++;
        }
        $data = array(
            'username' => $this->session->userdata('user_name'),
            'reports' => $result->data,
            'amounts' => $user_amount,
            'user_trans' => $user_trans,
            );

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/reconciliation-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=reconciliation-report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/reconciliation-report-list', $data);
        }
    }

    public function payment_gateway() {
        $this->is_logged_in();
        $this->load->view('site/report/payment-gateway');
    }

    function payment_gateway_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQF1TH15',
            'fromDate' => $this->input->post('from'),
            'toDate' => $this->input->post('to')
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $feeds = array();
        foreach ((array) $result->data as $trans) {
            $raw = explode('||', $trans->log_data);
            $trans->response = $raw[1];
            $trans->requestMap = $raw[2];
            $trans->requestDate = substr($raw[0], 0, 19);
            $trans->request = substr($raw[0], 20);
            $feeds[] = $trans;
        }
        $this->load->view('site/report/payment-gateway-report-list', array('reports' => $feeds));
    }

    function get_ticket_details() {
        $this->is_logged_in();
        $report = $this->api_model->ticketDetails(array('ticketCode' => $this->input->post('ticketpnrcode')));
        $rpt = json_decode($report);
        if ($rpt->status == 1) {
            $data['reports'] = $rpt->data;
            $time = new DateTime($rpt->data->travelDate);
            $data['times'] = $time->format('H:i A');
        } else {
            $data['error'] = 'No Details Found ';
        }
        $this->load->view('site/report/transaction-popover-list', $data);
    }

    function schedule_advance_booking_graph() {
        $this->is_logged_in();

        echo $this->api_model->scheduleStageFare(array(
            'scheduleCode' => $this->input->post('schedule_code')
        ));
    }

    function schedule_advance_booking() {
        $this->is_logged_in();

        $fromdate = $this->input->post('from_date');
        if (empty($fromdate)) {
            $fromdate = date('Y-m-d');
        }
        $enddate = strtotime("+4 months", strtotime($fromdate));
        $enddate = date("Y-m-d", $enddate);

        $data = array(
            'queryCode' => 'RQG44625',
            'fromDate' => $fromdate,
            'toDate' => 'NA',
            'scheduleCode' => $this->input->post('schedule_code'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $t_book_summary = array();
        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    $t = $result->data[$i]->booked_count + $result->data[$i]->phone_blocked_count;
                    if ($t > 0) {
                        $t_book_summary[$result->data[$i]->travel_date] += $t;
                    }
                }
            }
            $dates = array_keys($t_book_summary);
            $last_date = strtotime($dates[count($dates) - 1]);
        }

        $data = array();
        $dates = array();
        $counts = array();

        $c_day = $fromdate;
        while (strtotime($c_day) <= $last_date) {
            $day = date('D j M', strtotime($c_day));
            $dates[] = $day;
            $counts[] = (int) $t_book_summary[$c_day];

            $c_day = strtotime("+1 day", strtotime($c_day));
            $c_day = date("Y-m-d", $c_day);
        }

        $data['travel_date'] = $dates;
        $data['counts'] = $counts;

        echo json_encode($data);
    }

    function schedule_calendar() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQGCFE5613',
            'scheduleCode' => $this->input->post('scheduleCode'),
            'fromDate' => $this->input->post('start'),
            'toDate' => $this->input->post('end')
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $count = count($result->data);
        $trips = array();

        $cfg_trip_status = config_item('trip_status');
        $cfg_trip_color = array(
            'TPO' => 'color_d',
            'TPC' => 'color_g',
            'TPY' => 'color_f',
            'NA' => 'color_b'
        );

        for ($i = 0; $i < $count; $i++) {
            $t =  $result->data[$i];
            $trips[] = array(
                "id" => $t->trip_code,
                "title" => $cfg_trip_status[$t->trip_status].' ( '.$t->seat_count.' )',
                "className" => $cfg_trip_color[$t->trip_status],
                "start" => $t->trip_date
            );
        }
        echo json_encode($trips);
    }

    function trip_audit_history() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQGCHA4114',
            'filterCode' => $this->input->post('tripCode'),
            'repositoryCode' => 'trip',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data = array();
        $data['transactions'] = $result->data;
        $this->load->view('site/search/trip-history', $data);
    }

    public function report_usage_report() {
        $this->is_logged_in();
        $this->load->view('site/report/report-usage-report');
    }

    public function report_usage_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQH4M65616',
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['user_name'] = _get_user_name();
        $data['data'] = $result->data;

        $this->load->exclude_template();
        header('Content-Description: File Transfer');
        header('Content-type: application/csv');
        header('Content-Disposition: attachment; filename=report-usage-report-' . date("d-m-Y") . '.csv');
        header('Content-Transfer-Encoding: binary');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        ob_clean();
        
        $fp = fopen('php://output', 'w');
        fputcsv($fp, [
            '#',
            'Namespace',
            'User',
            'Report Name',
            'Run At',
            'Execution Time',
            'Report Code',
            'Status',
            'Result Count',
            'User Code',
            'Parameters'
        ]);
        foreach ($result->data as $i => $row) {
            fputcsv($fp, [
                $i + 1,
                $row->namespace_name,
                $row->username,
                $row->report_name,
                $row->updated_at,
                $row->execution_time,
                $row->report_code,
                $row->status_log,
                $row->result_row_count,
                $row->user_code,
                $row->parameter_log,
            ]);
        }
        fclose($fp);
        flush();
        die;
    }

    public function eticket_accounts_report() {
        $this->is_logged_in();
        $this->load->view('site/report/eticket-accounts-report');
    }

    public function eticket_accounts_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQH545S17',
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['user_name'] = _get_user_name();
        $data['data'] = $result->data;

        $filename = 'eticket-accounts-report.xls';

        $this->load->exclude_template();
        $content = $this->load->view('site/report/eticket-accounts-report-list-xls', $data, true);
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename='.$filename);
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

    public function orbit_accounts_report() {
        $this->is_logged_in();
        $this->load->view('site/report/orbit-accounts-report');
    }

    public function orbit_accounts_report_list() {
        set_time_limit(0);
        $this->is_logged_in();

        $property_url = config_item('ns_properties_url').'/namespace.json';
        $json = file_get_contents($property_url);
        $bos = json_decode($json);

        //  excel generation
        $this->load->library('excel');
        $this->excel->getProperties()->setCreator("EzeeInfo")
                                    ->setLastModifiedBy("EzeeInfo")
                                    ->setTitle("Orbit Transactions List")
                                    ->setSubject("Orbit Transactions List")
                                    ->setDescription("Orbit Transactions List.")
                                    ->setKeywords("Orbit Transactions List")
                                    ->setCategory("Account");
        $this->excel->setActiveSheetIndex(0);
        $this->excel->getActiveSheet()->setTitle('Orbit Transactions');

        $this->excel->getActiveSheet()->getStyle('A1:Z1')->getFont()->setBold(true);

        $this->excel->getActiveSheet()->setCellValue('A1', 'PNR');
        $this->excel->getActiveSheet()->setCellValue('B1', 'Namespace');
        $this->excel->getActiveSheet()->setCellValue('C1', 'Transaction Date');
        $this->excel->getActiveSheet()->setCellValue('D1', 'Travel Date');
        $this->excel->getActiveSheet()->setCellValue('E1', 'Route');
        $this->excel->getActiveSheet()->setCellValue('F1', 'Status');

        $this->excel->getActiveSheet()->setCellValue('G1', 'Fare');
        $this->excel->getActiveSheet()->setCellValue('H1', 'AC GST');
        $this->excel->getActiveSheet()->setCellValue('I1', 'Commission');
        $this->excel->getActiveSheet()->setCellValue('J1', 'Discount');
        $this->excel->getActiveSheet()->setCellValue('K1', 'Payable');

        $this->excel->getActiveSheet()->setCellValue('L1', 'Cancel Charges');
        $this->excel->getActiveSheet()->setCellValue('M1', 'Agent Share');
        $this->excel->getActiveSheet()->setCellValue('N1', 'Refund');

        $row = 2;

        foreach($bos->data as $bo) {
            $user_code = $bo->ezeeInfoUsercode;
            if(empty($user_code))  {
                continue;
            }

            $param = array( 'code' => $bo->code);
            $space = $this->api_model->getswitchNamespace($param);
            $space = json_decode($space);
            if($space->status==1) {
                $data = array(
                    'queryCode' => 'RQG6QM3610',
                    'toDate' => $this->input->post('to_date'),
                    'fromDate' => $this->input->post('from_date'),
                    'userCode' => $user_code,
                );

                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $result = json_decode($result);

                if ($result->status == 1) {
                    if (is_array($result->data)) {
                        $ticket_count = count($result->data);
                        for ($i = 0; $i < $ticket_count; $i++) {
                            $col = 0;
                            $t = $result->data[$i];

                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->ticket_code);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $bo->code);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->transaction_date);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->travel_date);
                            $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->from_station_name.' - '. $t->to_station_name);

                            if ($result->data[$i]->transaction_type == 'BO') {
                                $payable =  $t->ticket_amount + $t->ac_bus_tax - $t->commission_amount;

                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, 'BO');
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->ticket_amount);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->ac_bus_tax);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->commission_amount);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->discount_amount);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $payable);

                            } else {
                                $refund =  $t->ticket_amount - $t->cancellation_charges;

                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, 'CA');
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->ticket_amount);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->ac_bus_tax);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, 0);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->discount_amount);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, 0);

                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->cancellation_charges);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->cancel_commission);
                                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $refund);
                            }
                            $row++;
                        }
                    }
                }
            }
        }

        $param = array( 'code' => 'bits');
        $space = $this->api_model->getswitchNamespace($param);

        $filename = 'Orbit-Transactions-'.$this->input->post('from_date').' TO '.$this->input->post('to_date').'.xls';
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="'.$filename.'"');
        header('Cache-Control: max-age=0');
        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
        $objWriter->save('php://output');
    }

    public function travel_status_report() {
        $this->is_logged_in();
        $data['travel_status'] = config_item('travel_status');
        $this->load->view('site/report/travel-status-report', $data);
    }

    function travel_status_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQH9LEU20',
            'filterCode' => $this->input->post('status'),
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $tickets = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    $result->data[$i]->boarding_time = date('h:i A', mktime(0, $result->data[$i]->boarding_point_minutes));
                    $tickets[$result->data[$i]->travel_date][$result->data[$i]->trip_code][] = $result->data[$i];
                }
            }
        }

        $data['travel_status'] = config_item('travel_status');
        $data['tickets'] = $tickets;
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/boarding-point-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Boarding_report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/travel-status-report-list', $data);
        }
    }

    public function discount_utilization_report() {
        $this->is_logged_in();

        $data['discount_type'] = config_item('discount_type');
        $this->load->view('site/report/discount-utilization-report', $data);
    }

    function discount_utilization_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQHA475421',
            'travelDateFlag' => $this->input->post('date_option'),
            'ticketStatusCode' => $this->input->post('ticket_status'),
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'discountType' => $this->input->post('discount_type')
        );

        $p_key = _get_namespace_id().'_discount_utilization_report_'.md5(http_build_query($data));
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

        $meta = array();
        $discount_type = config_item('discount_type');
        $data['discount_type'] = $discount_type;
        $seat_count = 0;

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    //  discount type based meta
                    $meta['type'][$discount_type[$result->data[$i]->addons_type_code]]['fare'] += $result->data[$i]->ticket_amount;
                    $meta['type'][$discount_type[$result->data[$i]->addons_type_code]]['discount'] += $result->data[$i]->discount_amount;
                    //  usergroup based meta
                    $meta['group'][$result->data[$i]->user_group_name]['fare'] += $result->data[$i]->ticket_amount;
                    $meta['group'][$result->data[$i]->user_group_name]['discount'] += $result->data[$i]->discount_amount;
                    //  route based meta
                    $r = $result->data[$i]->from_station_name.' to '.$result->data[$i]->to_station_name;
                    $meta['route'][$r]['fare'] += $result->data[$i]->ticket_amount;
                    $meta['route'][$r]['discount'] += $result->data[$i]->discount_amount;

                    $meta['total_fare'] += $result->data[$i]->ticket_amount;
                    $meta['total_discount'] += $result->data[$i]->discount_amount;

                    $seat_count += $result->data[$i]->seat_count;
                }
            }
        }

        $data['tickets'] = $result->data;
        $data['meta'] = $meta;

        $data['total_tickets'] = $ticket_count;
        $data['total_seats'] = $seat_count;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/discount-utilization-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=discount_utilization_report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/discount-utilization-report-list', $data);
        }
    }

    public function login_history_report() {
        $this->is_logged_in();
        $data['groupusers'] = get_active_group_and_users();
        $this->load->view('site/report/login-history-report', $data);
    }

    function login_history_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQHA4F3622',
            'filterCode' => $this->input->post('status'),
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'userCode' => $this->input->post('user_code'),
            'groupCode' => $this->input->post('group_code'),
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        usort($result->data, function($a, $b) {
            return (strtotime(trim($a->session_started_at)) < strtotime(trim($b->session_started_at))) ? -1 : 1;
        });

        $data['reports'] = $result->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/boarding-point-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Boarding_report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/login-history-report-list-active-session', $data);
        }
    }

    public function sales_revenue_report() {
        $this->is_logged_in();
        $data = array();

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;
        
        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        $data['tags'] = $tags->data;
        
        $this->load->view('site/report/sales-revenue-report', $data);
    }

    function sales_revenue_report_list() {
        $this->is_logged_in();
        $groupby = $this->input->post('groupby');
        $vehicle = $this->input->post('vehicle');
        
        $apply_sector_rule = 0;
        if(has_action_rights('USR-APLY-SECTOR')) {
            $apply_sector_rule = 1;
        }
        
        $data = array(
            'queryCode' => 'RQHBBC224',
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
            'sectorEnableFlag' => $apply_sector_rule
        );        

        $p_key = _get_namespace_id().'_sales_revenue_'.md5(http_build_query($data));
        if( !$result = $this->rediscache->get($p_key)) {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 900);    //  15 mins
        }

        $result = json_decode($result);

        $tickets = array();
        $meta = array();
        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);

                if($groupby==1) {   //  date
                    for ($i = 0; $i < $ticket_count; $i++) {
                        $t = $result->data[$i];

                        if($vehicle=='ALL' || $t->registation_number==$vehicle) { //  vehicle filter
                            $tf = date("d-m-Y",strtotime($t->trip_date));
                            $tickets[$t->schedule_code][$tf]['booked_seats'] = $tickets[$t->schedule_code][$tf]['booked_seats'] + $t->booked_count;
                            $tickets[$t->schedule_code][$tf]['booked_amount'] = $tickets[$t->schedule_code][$tf]['booked_amount'] + ($t->booked_amount-$t->booked_gst + $t->addon_amount);
                            $tickets[$t->schedule_code][$tf]['cancel_seats'] = $tickets[$t->schedule_code][$tf]['cancel_seats'] + $t->cancelled_count;
                            $tickets[$t->schedule_code][$tf]['cancel_amount'] = $tickets[$t->schedule_code][$tf]['cancel_amount'] + ($t->cancelled_amount-$t->cancelled_gst + $t->cancel_commission + $t->revoke_commission_amount);
                            $tickets[$t->schedule_code][$tf]['cancel_charges'] = $tickets[$t->schedule_code][$tf]['cancel_charges'] + $t->cancellation_charges;
                            $tickets[$t->schedule_code][$tf]['agent_share'] = $tickets[$t->schedule_code][$tf]['agent_share'] + $t->cancel_commission;
                            $tickets[$t->schedule_code][$tf]['booked_gst'] = $tickets[$t->schedule_code][$tf]['booked_gst'] + $t->booked_gst;
                            $tickets[$t->schedule_code][$tf]['cancel_gst'] = $tickets[$t->schedule_code][$tf]['cancel_gst'] + $t->cancelled_gst;
                            $tickets[$t->schedule_code][$tf]['registration_number'] = $t->registation_number;

                            $meta[$t->schedule_code]['service_number'] = $t->service_number;
                            $meta[$t->schedule_code]['schedule_name'] = $t->schedule_name;
                            $meta[$t->schedule_code]['total_seats'] = $t->total_seat_count;
                        }
                    }
                } else {    //  schedule
                    for ($i = 0; $i < $ticket_count; $i++) {
                        $t = $result->data[$i];

                        if($vehicle=='ALL' || $t->registation_number==$vehicle) { //  vehicle filter
                            $tickets[$t->schedule_code]['booked_seats'] = $tickets[$t->schedule_code]['booked_seats'] + $t->booked_count;
                            $tickets[$t->schedule_code]['booked_amount'] = $tickets[$t->schedule_code]['booked_amount'] + ($t->booked_amount-$t->booked_gst + $t->addon_amount);
                             $tickets[$t->schedule_code]['cancel_seats'] = $tickets[$t->schedule_code]['cancel_seats'] + $t->cancelled_count;
                            $tickets[$t->schedule_code]['cancel_amount'] = $tickets[$t->schedule_code]['cancel_amount'] + ($t->cancelled_amount-$t->cancelled_gst + $t->cancel_commission + $t->revoke_commission_amount);
                            $tickets[$t->schedule_code]['cancel_charges'] = $tickets[$t->schedule_code]['cancel_charges'] + $t->cancellation_charges;
                            $tickets[$t->schedule_code]['agent_share'] = $tickets[$t->schedule_code]['agent_share'] + $t->cancel_commission;
                            $tickets[$t->schedule_code]['booked_gst'] = $tickets[$t->schedule_code]['booked_gst'] + $t->booked_gst;
                            $tickets[$t->schedule_code]['booked_comm'] = $tickets[$t->schedule_code]['booked_comm'] + $t->commission_amount;
                            $tickets[$t->schedule_code]['cancel_gst'] = $tickets[$t->schedule_code]['cancel_gst'] + $t->cancelled_gst;
                            $tickets[$t->schedule_code]['cancel_comm'] = $tickets[$t->schedule_code]['cancel_comm'] + $t->cancel_commission;
                            $tickets[$t->schedule_code]['revoke_comm'] = $tickets[$t->schedule_code]['revoke_comm'] + $t->revoke_commission_amount;
                            $tickets[$t->schedule_code]['trans_amount'] = $tickets[$t->schedule_code]['trans_amount'] + $t->booked_amount;
                            $tickets[$t->schedule_code]['trans_cancel_amt'] = $tickets[$t->schedule_code]['trans_cancel_amt'] + $t->cancelled_amount;

                            $tickets[$t->schedule_code]['service_number'] = $t->service_number;
                            $tickets[$t->schedule_code]['schedule_name'] = $t->schedule_name;
                            $tickets[$t->schedule_code]['total_seats'] = $t->total_seat_count;
                            $tickets[$t->schedule_code]['trip_count']++;
                        }
                    }
                }
            }
        }

        $data['rows'] = $tickets;
        $data['meta'] = $meta;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/sales-revenue-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Occupancy-And-Income-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/sales-revenue-report-list', $data);
        }
    }

    public function agent_trip_payment() {
        $this->is_logged_in();

        $groupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $groupDetail = json_decode($groupDetail);
        $data['groups'] = $groupDetail->data;

        $tmp = array();
        foreach ($groupDetail->data AS $grp) {
            $groupuser = $this->api_model->getUserByGroup(array('groupcode' => $grp->code)); dir;
            $groupuser = json_decode($groupuser);
            $tmp[] = array(
                'code' => $grp->code,
                'name' => $grp->name,
                'userlist' => $groupuser->data
            );
        }

        $data = array();
        $data['entity'] = $tmp;
        $data['userid'] = $this->session->userdata('user_id');
        $this->load->view('site/report/agent-trip-payment', $data);
    }

    public function agent_trip_payment_list() {
        $this->is_logged_in();

        $tripCode = $this->input->post('trip_code');
        $t = $this->input->post('user_code');
        $t = explode('|', $t);
        $userCode = $t[0];
        $userName = $t[1];

        if(trim($userName)=="")
            $userName = $this->session->userdata('user_name');

        if(trim($userCode)=="")
            $userCode = $this->session->userdata('user_id');

        $tripChartList = $this->api_model->getTripChart(array('tripCode' => $tripCode));
        $tripChartList = json_decode($tripChartList);

        if ($tripChartList->status == 1) {
            $tripChartList = $tripChartList->data;

            $bp = array();
            foreach ($tripChartList->trip->stageList as $stages) {
                foreach ($stages->fromStation->stationPoint as $points) {
                    $bp[strtotime($points->dateTime)] = array(
                        'code' => $points->code,
                        'name' => $points->name,
                        'stageName' => $stages->fromStation->name,
                        'timestamp' => strtotime($points->dateTime),
                        'time' => date('g:i A', strtotime($points->dateTime))
                    );
                }
            }
            ksort($bp); //  sort points by time.

            $dp = array();
            foreach ($tripChartList->trip->stageList as $stages) {
                foreach ($stages->toStation->stationPoint as $points) {
                    $dp[strtotime($points->dateTime)] = array(
                        'code' => $points->code,
                        'name' => $points->name,
                        'stageName' => $stages->toStation->name,
                        'time' => date('g:i A', strtotime($points->dateTime))
                    );
                }
            }
            ksort($dp); //  sort points by time.


            $bus = array();
            $ticket = array();
            $tick = array();
            $booked_seat_name = array();
            foreach ($tripChartList->ticketDetailsList as $tpch) {
                if($userName==$tpch->bookedBy->name) {
                    $booked_seat_name[$tpch->seatName][] = $tpch;
                    $ticket[$tpch->fromStation->name][$tpch->boardingPoint->name][] = $tpch->seatName;
                    $ticket_dp[$tpch->toStation->name][$tpch->droppingPoint->name][] = $tpch->seatName;
                    $userBookings[$tpch->bookedBy->name][] = array('seatName' => $tpch->seatName, 'seatFare' => $tpch->seatFare+$tpch->acBusTax);
                    $bp_booking[$tpch->boardingPoint->code][] = $tpch;
                    $dp_booking[$tpch->droppingPoint->code][] = $tpch;
                    $bookedSeat[] = $tpch->seatName;
                    $bookedGender[$tpch->seatName] = $tpch->gender;
                }
            }

            $data = array(
                'user' => $userName,
                'points' => $bp,
                'points_dp' => $dp,
                'Booking' => $booked_seat_name,
                'bp_books' => $bp_booking,
                'dp_books' => $dp_booking,
                'trips' => $tripChartList->trip,
                'tripCode' => $tripCode,
                'ticketList' => $ticket,
                'ticketListDp' => $ticket_dp,
                'bookinglist' => $userBookings,
                'bookedSeat' => $bookedSeat,
                'bookedGender' => $bookedGender,
                'minutesForFirstBoarding' => round(($bp[0]['timestamp'] - time()) /60),
                'vehicle_nunmber' => $tripChartList->busVehicle->registationNumber
            );

            $data['data'] = $tripChartList;
            $buslayers = $tripChartList->trip->bus;
            $data['layers'] = $buslayers->seatLayoutList;
            $data['seatvisiblelists'] = array();


            //  calculate settlement
            $param = array(
                'queryCode' => 'RQH46D5515',
                'tripCode' => $tripCode
            );
            $result = $this->api_model->getDynamicReportDataWithMap($param);
            $result = json_decode($result);

            if ($result->status == 1) {
                if (is_array($result->data)) {
                    $ticket_count = count($result->data);
                    for ($i = 0; $i < $ticket_count; $i++) {
                        if($userCode==$result->data[$i]->user_code) {
                            if ($result->data[$i]->transaction_type == 'BO') {
                                $tickets['bo_seats'] += $result->data[$i]->seat_count;
                                $tickets['bo_fare'] += $result->data[$i]->ticket_amount;
                                $tickets['bo_discount'] += $result->data[$i]->addon_amount;
                                $tickets['bo_comission'] += $result->data[$i]->commission_amount;
                                $tickets['bo_ac_tax'] += $result->data[$i]->ac_bus_tax;
                            } else {
                                $tickets['ca_fare'] += $result->data[$i]->ticket_amount+$result->data[$i]->ac_bus_tax;
                                $tickets['ca_seats'] += $result->data[$i]->seat_count;
                                $tickets['ca_discount'] += $result->data[$i]->addon_amount;
                                $tickets['ca_charges'] += $result->data[$i]->cancellation_charges;
                                $tickets['ca_share'] += $result->data[$i]->cancel_commission;
                            }
                        }
                    }

                    $tickets['bo_payable'] = $tickets['bo_fare'] + $tickets['bo_ac_tax'] - $tickets['bo_discount'] - $tickets['bo_comission'];
                    $tickets['ca_refund'] = $tickets['ca_fare'] - $tickets['ca_discount'] - $tickets['ca_charges'];

                    $t = ( $tickets['bo_fare'] + $tickets['bo_ac_tax'] + $tickets['ca_charges']) - ( $tickets['bo_discount'] + $tickets['bo_comission'] + $tickets['ca_share'] );
                    $tickets['payable'] = $t;
                }
            }
            $data['settlement'] = $tickets;
            //  calculate settlement - End

        } else {
            $data = array('api_error' => 1);
        }

        $info = $this->api_model->getVehicleInfo($param);
        $info = json_decode($info);
        $data['info'] = $info->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/trip-sales-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Transaction-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/agent-trip-payment-list', $data);
        }
    }

    public function trip_sales_report() {
        $this->is_logged_in();
        $data = array();
        $this->load->view('site/report/trip-sales-report', $data);
    }

    public function trip_sales_report_list() {
        $this->is_logged_in();
        $tripCode = $this->input->post('trip_code');

        $param = array(
            'queryCode' => 'RQH46D5515',
            'tripCode' => $tripCode
        );
        $result = $this->api_model->getDynamicReportDataWithMap($param);
        $result = json_decode($result);
        $tickets = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    if( strtolower($result->data[$i]->user_group_name) == 'customer' ) {
                        $result->data[$i]->user_first_name = "Customer";
                    }

                    if ($result->data[$i]->transaction_type == 'BO' || $result->data[$i]->transaction_type == 'PBL') {
                        $tickets[$result->data[$i]->user_first_name]['bo_seats'] += $result->data[$i]->seat_count;
                        $tickets[$result->data[$i]->user_first_name]['bo_fare'] += $result->data[$i]->ticket_amount;
                        $tickets[$result->data[$i]->user_first_name]['bo_discount'] += $result->data[$i]->addon_amount;
                        $tickets[$result->data[$i]->user_first_name]['bo_comission'] += $result->data[$i]->commission_amount;
                        $tickets[$result->data[$i]->user_first_name]['bo_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        $tickets[$result->data[$i]->user_first_name]['bo_seats_names'][] = trim($result->data[$i]->seat_name);
                        $tickets[$result->data[$i]->user_first_name]['bo_payable'] += $result->data[$i]->ticket_amount + $result->data[$i]->ac_bus_tax - $result->data[$i]->addon_amount - $result->data[$i]->commission_amount;
                    } else { 
                    //if ($result->data[$i]->transaction_type == 'CA') {
                        $tickets[$result->data[$i]->user_first_name]['ca_seats'] += $result->data[$i]->seat_count;
                        $tickets[$result->data[$i]->user_first_name]['ca_fare'] += $result->data[$i]->ticket_amount; 
                        $tickets[$result->data[$i]->user_first_name]['ca_discount'] += $result->data[$i]->addon_amount;
                        $tickets[$result->data[$i]->user_first_name]['ca_comission'] += $result->data[$i]->commission_amount;
                        $tickets[$result->data[$i]->user_first_name]['ca_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        $tickets[$result->data[$i]->user_first_name]['ca_seats_names'][] = trim($result->data[$i]->seat_name);
                        
                        $tickets[$result->data[$i]->user_first_name]['ca_charges'] += $result->data[$i]->cancellation_charges;
                        $tickets[$result->data[$i]->user_first_name]['ca_share'] += $result->data[$i]->cancel_commission;
                        $tickets[$result->data[$i]->user_first_name]['ca_refund'] += $result->data[$i]->ticket_amount + $result->data[$i]->ac_bus_tax - $result->data[$i]->cancellation_charges;
                    }
                }

                foreach($tickets as $k => $v) {
                    /*$tb = $v['bo_fare'] - $v['bo_discount'] + $v['bo_ac_tax'] - $v['bo_comission'];
                    $tc = $v['ca_fare'] - $v['ca_discount'] + $v['ca_ac_tax'] - $v['ca_comission'];
                    $tcc = $v['ca_charges'] - $v['ca_share'];                    
                    $t = $tb - $tc + $tcc;*/
                    
                    $tb = $v['bo_fare'] - $v['bo_discount'] + $v['bo_ac_tax'] - $v['bo_comission'];
                    //$tc = $v['ca_fare'] - $v['ca_discount'] + $v['ca_ac_tax'] - $v['ca_comission'];
                    $tcc = $v['ca_charges'] - $v['ca_share'];                    
                    $t = $tb - $tc + $tcc;
                    
                    $tickets[$k]['payable'] = $t;
                    $tickets[$k]['bo_seats_names'] = implode(' ,', $tickets[$k]['bo_seats_names']);
                }
                ksort($tickets);
            }
        }
        $data['settlement'] = $tickets;
        $data['tickets'] = $result->data;

        $info = $this->api_model->getVehicleInfo($param);
        $info = json_decode($info);
        $data['info'] = $info->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/trip-sales-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Transaction-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/trip-sales-report-list', $data);
        }
    }

    public function free_ticket_report() {
        $this->is_logged_in();
        $this->load->view('site/report/free-ticket-report', $data);
    }

    public function free_ticket_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQHCPJ4425',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'travelDateFlag' => $this->input->post('date_option'),
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
               $data['result'] = $result->data;
            }
        }

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/free-ticket-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Free_Ticket_Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/free-ticket-report-list', $data);
        }
    }

    public function notification_report() {
        $this->is_logged_in();
        $smstype = $this->api_model->notificationSmsTypes(array(
            'namespaceCode' => $this->session->userdata('namespace_id')
        ));
        $smstype = json_decode($smstype);
        $data['sms_notification_type'] = $smstype->data;
       
        $data['notification_mode'] = config_item('notification_mode');
        $this->load->view('site/report/notification-report', $data);
    }   

    public function notification_report_list() {
        $this->is_logged_in();

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        $mobile_pnr = trim($this->input->post('mobile_pnr'));
        $type = $this->input->post('notificationType');
        $notificationModeCode = $this->input->post('notificationModeCode');

        $phoneRegex = '/^\d{10}$/';
        $pnrRegex = '/^[A-Z0-9]{12}$/';

        if (preg_match($phoneRegex, trim($mobile_pnr))) {
           $mobile  = $mobile_pnr;
           $pnr    = 'NA';
        } elseif (preg_match($pnrRegex, trim($mobile_pnr))) {
            $pnr =$mobile_pnr;
            $mobile  = 'NA';
        } else {
            $mobile  = 'NA';
            $pnr    = 'NA';
        }

        if($notificationModeCode == ''){
           $notificationModeCode ='NA';
        }
    
        $data = array(
            'queryCode' => 'RQI1QIC26',
            'fromDate' => date('Y-m-d', strtotime($from_date)),
            'toDate' => date('Y-m-d', strtotime($to_date)),
            'notificationType' => $type,
            'participantAddress' => $mobile,
            'refferenceCode' => $pnr,
            'notificationModeCode' => $notificationModeCode,
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        if($result->status == 0){
            $data['error'] = $result->data;
        }

        if ($result->status == 1) {
            if (is_array($result->data)) {
                foreach ($result->data as $item) {
                    $participant_address = $item->participant_address;
                    
                    if (!isset($groupedArray[$participant_address])) {
                        $groupedArray[$participant_address] = [];
                    }
                
                    $groupedArray[$participant_address][] = $item;
                }


                $data['result'] = $result->data;
                $data['final'] = array_reverse($groupedArray,true);
                
                $smstype = $this->api_model->notificationSmsTypes(array(
                    'namespaceCode' => $this->session->userdata('namespace_id')
                ));
                $smstype = json_decode($smstype);

                $sms_notification_type = array();
                foreach($smstype->data as $val) {
                    $sms_notification_type[$val->code] = $val->name;
                }
                $data['notification_mode_code'] = $notificationModeCode;
                $data['sms_notification_type'] = $sms_notification_type;
                $data['notification_mode'] = config_item('notification_mode');
            }
        }

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/notification-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Notification_report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/notification-report-list', $data);
        }
    }

    public function notification_report_list_Download() {
        $this->is_logged_in();
        
        $data = array(
            'queryCode' => 'RQI1QIC26',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'notificationType' =>'NA',
            'participantAddress' => 'NA',
            'refferenceCode' => 'NA',
            'notificationModeCode' => 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $data['result'] = $result->data;
                $smstype = $this->api_model->notificationSmsTypes(array(
                    'namespaceCode' => $this->session->userdata('namespace_id')
                ));
                $smstype = json_decode($smstype);

                $sms_notification_type = array();
                foreach ($smstype->data as $val) {
                    $sms_notification_type[$val->code] = $val->name;
                }
                $data['sms_notification_type'] = $sms_notification_type;
            }
        }

         if ($this->input->post('downloadAll') == "NA") {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/notification-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Notification_report_download_All.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/notification-report-list', $data);
        }
    }
    
    function sales_summary_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQF28C20',
            'travelDateFlag' => $this->input->post('date_option'),
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'userCode' => $this->input->post('user_code'),
            'groupCode' => $this->input->post('group_code'),
        );

        $p_key = _get_namespace_id().'_sales_summary_report_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        //echo $result;
        $result = json_decode($result);

        $booking = array();
        $cancel = array();
        $meta = array();
        $seat_count = 0;

        $totals = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    $row = $result->data[$i];

                    if( strtolower($row->user_group_name)=="customer" )
                        $row->user_name = 'Guest';

                    if($row->ticket_status_code=='BO' || $row->ticket_status_code=='PBL') {
                        $booking[$row->user_name]['booking']['fare'] += $row->ticket_amount;
                        $booking[$row->user_name]['booking']['gst'] += $row->ac_bus_tax;
                        $booking[$row->user_name]['booking']['commission'] += $row->commission_amount;
                        $booking[$row->user_name]['booking']['commission_gst'] += $row->service_tax_amount;
                        $booking[$row->user_name]['booking']['tds'] += $row->tds_tax;
                        $booking[$row->user_name]['booking']['seats'] += $row->seat_count;
                        $booking[$row->user_name]['booking']['discount'] += $row->addon_amount;
                        $booking[$row->user_name]['booking']['crossamount'] += ($row->ticket_amount+$row->ac_bus_tax-$row->commission_amount-$row->service_tax_amount-$row->addon_amount+$row->tds_tax);

                        $booking[$row->user_name]['name'] = $row->user_name;
                        $booking[$row->user_name]['group'] = $row->user_group_name;
                        $booking[$row->user_name]['usercode'] = $row->user_code;
                        
                        $booking[$row->user_name]['date'][$row->settlement_date]['booking']['fare'] += $row->ticket_amount;
                        $booking[$row->user_name]['date'][$row->settlement_date]['booking']['gst'] += $row->ac_bus_tax;
                        $booking[$row->user_name]['date'][$row->settlement_date]['booking']['commission'] += $row->commission_amount;
                        $booking[$row->user_name]['date'][$row->settlement_date]['booking']['commission_gst'] += $row->service_tax_amount;
                        $booking[$row->user_name]['date'][$row->settlement_date]['booking']['tds'] += $row->tds_tax;
                        $booking[$row->user_name]['date'][$row->settlement_date]['booking']['seats'] += $row->seat_count;
                        $booking[$row->user_name]['date'][$row->settlement_date]['booking']['discount'] += $row->addon_amount;
                        $booking[$row->user_name]['date'][$row->settlement_date]['booking']['crossamount'] += ($row->ticket_amount+$row->ac_bus_tax-$row->commission_amount-$row->service_tax_amount-$row->addon_amount+$row->tds_tax);

                        $totals['booking']['fare'] += $row->ticket_amount;
                        $totals['booking']['gst'] += $row->ac_bus_tax;
                        $totals['booking']['commission'] += $row->commission_amount;
                        $totals['booking']['commission_gst'] += $row->service_tax_amount;
                        $totals['booking']['tds'] += $row->tds_tax;
                        $totals['booking']['seats'] += $row->seat_count;
                        $totals['booking']['discount'] += $row->addon_amount;

                    } else if($row->ticket_status_code=='CA' || $row->ticket_status_code=='TCA'){
                        $booking[$row->user_name]['cancel']['fare'] += $row->ticket_amount;
                        $booking[$row->user_name]['cancel']['gst'] += $row->ac_bus_tax;
                        $booking[$row->user_name]['cancel']['revoke'] += $row->revoke_commission_amount + $row->revoke_service_tax_amount - $row->revoke_commission_tds_tax;
                        $booking[$row->user_name]['cancel']['refund'] += ( $row->ticket_amount
                                                                            -$row->addon_amount
                                                                            +$row->ac_bus_tax
                                
                                                                            -$row->revoke_commission_amount
                                                                            -$row->revoke_service_tax_amount
                                                                            +$row->revoke_commission_tds_tax
                                
                                                                            -$row->cancellation_charges                                                                            
                                                                            
                                                                            +$row->cancel_commission
                                                                            +$row->cancel_service_tax_amount
                                                                            -$row->cancel_tds_tax ); 
                        $booking[$row->user_name]['cancel']['cancellation_charges'] += $row->cancellation_charges;
                        $booking[$row->user_name]['cancel']['agent_share'] += $row->cancel_commission;
                        $booking[$row->user_name]['cancel']['agent_share_gst'] += $row->cancel_service_tax_amount;
                        $booking[$row->user_name]['cancel']['tds'] += $row->cancel_tds_tax;
                        $booking[$row->user_name]['cancel']['seats'] += $row->seat_count;
                        $booking[$row->user_name]['cancel']['discount'] += $row->addon_amount;
                        
                        $booking[$row->user_name]['cancel']['revenue'] += $row->cancellation_charges
                                                                          -$row->cancel_commission
                                                                          -$row->cancel_service_tax_amount;

                        $booking[$row->user_name]['name'] = $row->user_name;
                        $booking[$row->user_name]['group'] = $row->user_group_name;
                        $booking[$row->user_name]['usercode'] = $row->user_code;

                        $booking[$row->user_name]['date'][$row->settlement_date]['cancel']['fare'] += $row->ticket_amount;
                        $booking[$row->user_name]['date'][$row->settlement_date]['cancel']['gst'] += $row->ac_bus_tax;
                        $booking[$row->user_name]['date'][$row->settlement_date]['cancel']['revoke'] += $row->revoke_commission_amount + $row->revoke_service_tax_amount - $row->revoke_commission_tds_tax;
                        $booking[$row->user_name]['date'][$row->settlement_date]['cancel']['refund'] += ( $row->ticket_amount
                                                                            -$row->addon_amount
                                                                            +$row->ac_bus_tax

                                                                            -$row->revoke_commission_amount
                                                                            -$row->revoke_service_tax_amount
                                                                            +$row->revoke_commission_tds_tax

                                                                            -$row->cancellation_charges

                                                                            +$row->cancel_commission
                                                                            +$row->cancel_service_tax_amount
                                                                            -$row->cancel_tds_tax );
                        $booking[$row->user_name]['date'][$row->settlement_date]['cancel']['cancellation_charges'] += $row->cancellation_charges;
                        $booking[$row->user_name]['date'][$row->settlement_date]['cancel']['agent_share'] += $row->cancel_commission;
                        $booking[$row->user_name]['date'][$row->settlement_date]['cancel']['agent_share_gst'] += $row->cancel_service_tax_amount;
                        $booking[$row->user_name]['date'][$row->settlement_date]['cancel']['tds'] += $row->cancel_tds_tax;
                        $booking[$row->user_name]['date'][$row->settlement_date]['cancel']['seats'] += $row->seat_count;
                        $booking[$row->user_name]['date'][$row->settlement_date]['cancel']['discount'] += $row->addon_amount;

                        $booking[$row->user_name]['date'][$row->settlement_date]['cancel']['revenue'] += $row->cancellation_charges
                                                                          -$row->cancel_commission
                                                                          -$row->cancel_service_tax_amount;

                        $totals['cancel']['fare'] += $row->ticket_amount;
                        $totals['cancel']['gst'] += $row->ac_bus_tax;
                        $totals['cancel']['commission'] += $row->commission_amount;
                        $totals['cancel']['commission_gst'] += $row->cancel_service_tax_amount;
                        $totals['cancel']['tds'] += $row->cancel_tds_tax;
                        $totals['cancel']['seats'] += $row->seat_count;
                        $totals['cancel']['discount'] += $row->addon_amount;
                    }


                }
            }
        }


        $data['meta'] = $meta;
        $data['totals'] = $totals;
        $data['bookings'] = $booking;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/sales-summary-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=sales_summary_report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/sales-summary-report-list', $data);
        }
    }

    function initiate_all_ack(){
        $this->is_logged_in();
        $codes = $this->input->post('code');
        foreach($codes as $cde) {
            $this->api_model->updateAck(array('code' => $cde, 'state' => $this->input->post('state')));
        }
        echo json_encode(array('status'=>1));
    }

    public function schedule_occupancy_summary() {
        $this->is_logged_in();
        $this->load->view('site/report/schedule-occupancy-summary');
    }

    function schedule_occupancy_summary_list() {
        $this->is_logged_in();
        $apply_sector_rule = 0;
        if(has_action_rights('USR-APLY-SECTOR')) {
            $apply_sector_rule = 1;
        }
        
        $data = array(
            'queryCode' => 'RQHABG923',
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'sectorEnableFlag' => $apply_sector_rule
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $schedules = array();

        $data['data'] = array();
        foreach ($result->data AS $row) {
            if (!isset($data['data'][$row->schedule_code])){
                $data['data'][$row->schedule_code] = clone $row;
                $data['data'][$row->schedule_code]->booked_count = $row->booked_count + $row->phone_blocked_count;
            } else {
                $data['data'][$row->schedule_code]->booked_count += ($row->booked_count + $row->phone_blocked_count);
            }
            $schedules[$row->schedule_code][$row->trip_code]['total_seat_count'] = $row->total_seat_count;

            $data['stage'][$row->schedule_code]["$row->from_station_name - $row->to_station_name"]->booked_count += ($row->booked_count + $row->phone_blocked_count);
            $data['stage'][$row->schedule_code]["$row->from_station_name - $row->to_station_name"]->total_seat_count += $row->total_seat_count;

            $data['users'][$row->schedule_code][$row->user_name]->booked_count += ($row->booked_count + $row->phone_blocked_count);
        }

        foreach($schedules as $schcode => $trips) {
            foreach($trips as $trip) {
                $data['data'][$schcode]->total_seats_count += $trip['total_seat_count'];
            }
        }

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/schedule-occupancy-summary-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Schedule-Occupancy-Summary.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/schedule-occupancy-summary-list',$data);
        }
    }

    function vanpickup_chart(){
        $this->is_logged_in();

        $vanDetails = $this->api_model->getVanRoutes();
        $vanDetails = json_decode($vanDetails);
        $data['vanDetails'] = $vanDetails->data;

        $this->load->view('site/report/vanpickup-chart',$data);
    }

    function vanpickup_list(){
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQI3U6J30',
            'tripDate' => $this->input->post('tripDate'),
            'vehicleVanCode' => $this->input->post('vehicleVanCode'),
            'boardingDroppingFlag' => $this->input->post('boardingDroppingFlag'),
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data = array();
        $a_tmp = array();
        foreach ($result->data AS $row) {
            $a_tmp[] = strtotime($row->station_point_minutes);
            $row->station_point_minutes = strtotime($row->station_point_minutes);
            $data[] = $row;
        }
        array_multisort($a_tmp, SORT_ASC, $data);

        $stations = array();
        foreach ($data AS $row) {
            $stations[$row->station_point_name]['time'] = $row->station_point_minutes;
            $stations[$row->station_point_name]['tickets'][$row->ticket_code][] = $row;
        }
        $data['result'] = $stations;

        $vaninfo = $this->api_model->vanTripInfo(array(
            'tripDate' => $this->input->post('tripDate'),
            'vehicleVanCode' => $this->input->post('vehicleVanCode')
        ));
        $vaninfo  = json_decode($vaninfo);
        $data['vaninfo'] = $vaninfo->data;

        $driver = $this->api_model->getVehicleDriver();
        $driver = json_decode($driver);
        $data['driver'] = $driver->data;

        $vehicle = $this->api_model->getVehicle();
        $vehicle = json_decode($vehicle);

        $vehiclegrouped = array();
        foreach ($vehicle->data as $row) {
            $vehiclegrouped[$row->vehicleType->name][] = $row;
        }
        $data['vehiclegrouped'] = $vehiclegrouped;
        
        $data['vanpickup_code'] = $this->input->post('vehicleVanCode');
        $data['vanpickup_tripdate'] = $this->input->post('tripDate');
        
        $this->load->view('site/report/vanpickup-chart-list',$data);
    }

    function ticket_transfer_report(){
        $this->is_logged_in();
        $this->load->view('site/report/ticket-transfer-report');
    }

    function ticket_transfer_report_list(){
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQI464J33',
            'fromDate' => $this->input->post('from'),
            'toDate' => $this->input->post('to'),
            'travelDateFlag' => $this->input->post('travelDateFlag'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;


        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/ticket-transfer-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Ticket-Transfer-Details.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/ticket-transfer-report-list',$data);
        }
    }

    public function tripwise_agent_payment() {
        $this->is_logged_in();

        $groupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $groupDetail = json_decode($groupDetail);
        $data['groups'] = $groupDetail->data;

        $this->load->view('site/report/tripwise-agent-payment', $data);
    }

    public function tripwise_agent_payment_list() {
        $this->is_logged_in();

        $tripCode = $this->input->post('trip_code');
        $groupCode = $this->input->post('group_code');

        $tripChartList = $this->api_model->getTripChart(array('tripCode' => $tripCode));
        $tripChartList = json_decode($tripChartList);

        if ($tripChartList->status == 1) {
            $tripChartList = $tripChartList->data;
            $ticket = array();
            foreach ($tripChartList->ticketDetailsList as $tpch) {
                if($groupCode==$tpch->bookedBy->group->code) {
                    $ticket[$tpch->bookedBy->code][] = $tpch;
                    $users[$tpch->bookedBy->code] = $tpch->bookedBy->name;
                }
            }
            $data = array(
                'ticketList' => $ticket,
                'users' => $users,
            );
        } else {
            $data = array('api_error' => 1);
        }

        //  calculate settlement
        $param = array(
            'queryCode' => 'RQH46D5515',
            'tripCode' => $tripCode
        );

        $result = $this->api_model->getDynamicReportDataWithMap($param);
        $result = json_decode($result);

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {

                    if($groupCode==$result->data[$i]->user_group_code) {
                        if ($result->data[$i]->transaction_type == 'BO') {
                            $tickets[$result->data[$i]->user_code]['bo_seats'] += $result->data[$i]->seat_count;
                            $tickets[$result->data[$i]->user_code]['bo_fare'] += $result->data[$i]->ticket_amount;
                            $tickets[$result->data[$i]->user_code]['bo_discount'] += $result->data[$i]->addon_amount;
                            $tickets[$result->data[$i]->user_code]['bo_comission'] += $result->data[$i]->commission_amount;
                            $tickets[$result->data[$i]->user_code]['bo_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        } else {
                            $tickets[$result->data[$i]->user_code]['ca_fare'] += $result->data[$i]->ticket_amount+$result->data[$i]->ac_bus_tax;
                            $tickets[$result->data[$i]->user_code]['ca_seats'] += $result->data[$i]->seat_count;
                            $tickets[$result->data[$i]->user_code]['ca_discount'] += $result->data[$i]->addon_amount;
                            $tickets[$result->data[$i]->user_code]['ca_charges'] += $result->data[$i]->cancellation_charges;
                            $tickets[$result->data[$i]->user_code]['ca_share'] += $result->data[$i]->cancel_commission;
                        }
                    }
                }

                $tickets['bo_payable'] = $tickets['bo_fare'] + $tickets['bo_ac_tax'] - $tickets['bo_discount'] - $tickets['bo_comission'];
                $tickets['ca_refund'] = $tickets['ca_fare'] - $tickets['ca_discount'] - $tickets['ca_charges'];

                $t = ( $tickets['bo_fare'] + $tickets['bo_ac_tax'] + $tickets['ca_charges']) - ( $tickets['bo_discount'] + $tickets['bo_comission'] + $tickets['ca_share'] );
                $tickets['payable'] = $t;
            }
        }

        $data['settlement'] = $tickets;
        //  calculate settlement - End


        $info = $this->api_model->getVehicleInfo($param);
        $info = json_decode($info);
        $data['info'] = $info->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/tripwise-agent-payment-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Transaction-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/tripwise-agent-payment-list', $data);
        }
    }

    function phone_ticket_details(){
        $this->is_logged_in();
        $data['groupusers'] = get_active_group_and_users();
        $this->load->view('site/report/phone-ticket-details',$data);
    }

    function phone_ticket_details_list(){
        $data = array(
            'queryCode' => 'RQF26919',
            'fromDate' => $this->input->post('from'),
            'toDate' => $this->input->post('to'),
            'userCode' => $this->input->post('userCode'),
            'filterTypeCode' => $this->input->post('filterTypeCode'),
            'travelDateFlag' => $this->input->post('travelDateFlag'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/phone-ticket-details-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Phone-Ticket-Details.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/phone-ticket-details-list',$data);
        }
    }

    function vehicle_driver_allocation(){
        $this->is_logged_in();
        
        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        $data['tags'] = $tags->data;
        
        $this->load->view('site/report/vehicle-driver-allocation', $data);
    }

    function vehicle_driver_allocation_list(){
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQI44G432', 
            'fromDate' => $this->input->post('from'),
            'toDate' => $this->input->post('to'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        if ($this->input->post('data_option') == 1) {
            usort($result->data, function($a, $b) {
                return strcasecmp(trim($a->schedule_name), trim($b->schedule_name));
            });
        } else {
            usort($result->data, function($a, $b) {
                return (strtotime(trim($a->trip_start_time)) < strtotime(trim($b->trip_start_time))) ? -1 : 1;
            });
        }

        $data['result'] = $result->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            if($this->input->post('data_option')==1) {
                $content = $this->load->view('site/report/vehicle-driver-occupancy-list-xls', $data, true);
                header('Content-Disposition: attachment; filename=Trip-Status-Report.xls');
            } else {
                $content = $this->load->view('site/report/vehicle-driver-allocation-list-xls', $data, true);
                header('Content-Disposition: attachment; filename=Vehicle-Driver-Allocation.xls');
            }
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');            
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            if($this->input->post('data_option')==1) {
                $this->load->view('site/report/vehicle-driver-occupancy-list',$data);
            } else {
                $this->load->view('site/report/vehicle-driver-allocation-list',$data);
            }
        }
    }

    function reply_customer_feedback(){
        $this->is_logged_in();
        $data = array(
            'refferencecode' => $this->input->post('refferencecode'),
            'notificationmode' => $this->input->post('notificationmode'),
            'participantaddress' => $this->input->post('participantaddress'),
            'content' => $this->input->post('content')
        );

        echo $this->api_model->replyCustomerFeedback($data);
    }

    function get_stationpoint_by_station() {
        $this->is_logged_in();
        $data = array(
            'authtoken' => $this->_user_hash,
            'stationcode' => $this->input->post('staionCode')
        );
        echo $this->api_model->getStationPointsByStation($data);
    }

    function trip_cancellation_report(){
        $this->is_logged_in();
        
        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        $data['tags'] = $tags->data;
        
        $this->load->view('site/report/trip-cancellation-report', $data);
    }

    function trip_cancellation_report_list(){
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQI275W27',
            'fromDate' => $this->input->post('from'),
            'toDate' => $this->input->post('to'),
            'travelDateFlag' => $this->input->post('date_option'),
            'tripCode' => 'NA',
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        if ($this->input->post('export') == 1) {

            $from = date("d-m-Y",strtotime($this->input->post('from')));
            $to = date("d-m-Y",strtotime($this->input->post('to')));

            $this->load->library('excel');
            $this->excel->getProperties()->setCreator("EzeeInfo")
                    ->setLastModifiedBy("EzeeInfo")
                    ->setTitle("Trip Cancellation Report")
                    ->setSubject("Trip Cancellation Report")
                    ->setDescription("Trip Cancellation Report.")
                    ->setKeywords("Trip Cancellation Report")
                    ->setCategory("Account");
            $this->excel->setActiveSheetIndex(0);
            $this->excel->getActiveSheet()->setTitle('Trip Cancellation Report');

            $row = 1;
            $this->excel->getActiveSheet()->mergeCells('A'.$row.':K'.$row);
            $this->excel->getActiveSheet()->setCellValue('A'.$row, 'Trip Cancellation Report');
            $this->excel->getActiveSheet()->getStyle('A'.$row.':K'.$row)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
            $this->excel->getActiveSheet()->getStyle('A'.$row.':K'.$row++)->applyFromArray(
                array(
                    'fill' => array(
                        'type' => PHPExcel_Style_Fill::FILL_SOLID,
                        'color' => array('rgb' => '64b92a')
                    ),
                    'font'  => array(
                        'bold'  => true,
                        'color' => array('rgb' => 'ffffff'),
                    )
                )
            );
            $this->excel->getActiveSheet()->mergeCells('A'.$row.':E'.$row);
            $this->excel->getActiveSheet()->setCellValue('A'.$row, 'From: '.$from.' To: '.$to);
            $this->excel->getActiveSheet()->mergeCells('F'.$row.':K'.$row);
            $this->excel->getActiveSheet()->setCellValue('F'.$row, 'Report Date/Time: '.date("d-m-Y h:i:s a", time()));
            $this->excel->getActiveSheet()->getStyle('F'.$row.':K'.$row)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
            $this->excel->getActiveSheet()->getStyle('A'.$row.':K'.$row++)->applyFromArray(
                array(
                    'fill' => array(
                        'type' => PHPExcel_Style_Fill::FILL_SOLID,
                        'color' => array('rgb' => 'f5f5f5')
                    )
                )
            );

            $row++;
            $this->excel->getActiveSheet()->getStyle('A'.$row.':Z'.$row)->getFont()->setBold(true);
            $this->excel->getActiveSheet()->setCellValue('A'.$row, 'PNR');
            $this->excel->getActiveSheet()->setCellValue('B'.$row, 'Service Number');
            $this->excel->getActiveSheet()->setCellValue('C'.$row, 'Trip Date');
            $this->excel->getActiveSheet()->setCellValue('D'.$row, 'Route');
            $this->excel->getActiveSheet()->setCellValue('E'.$row, 'Booked By');
            $this->excel->getActiveSheet()->setCellValue('F'.$row, 'Passenger Name');
            $this->excel->getActiveSheet()->setCellValue('G'.$row, 'Mobile No');
            $this->excel->getActiveSheet()->setCellValue('H'.$row, 'Seat Name');
            $this->excel->getActiveSheet()->setCellValue('I'.$row, 'Seat Count');
            $this->excel->getActiveSheet()->setCellValue('J'.$row, 'Ticket Amount');
            $this->excel->getActiveSheet()->setCellValue('K'.$row, 'Cancelled At');
            $this->excel->getActiveSheet()->getStyle('A'.$row.':K'.$row++)->applyFromArray(
                array(
                    'fill' => array(
                        'type' => PHPExcel_Style_Fill::FILL_SOLID,
                        'color' => array('rgb' => '64b92a')
                    ),
                    'font'  => array(
                        'bold'  => true,
                        'color' => array('rgb' => 'ffffff'),
                    )
                )
            );

            foreach ($data['result'] as $t) {
                if($t->ticket_status_code == 'TCA'){
                    $col = 0;
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->ticket_code);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->service_number);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, date('d-m-Y h:i:s a', strtotime($t->trip_date_time)));
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->from_station_name . ' - ' . $t->to_station_name);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->user_name);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->passenger_name);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->mobile_number);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->seat_name);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->seat_count);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->ticket_amount);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, date('d-m-Y h:i:s a', strtotime($t->trip_cancel_at)));
                    $row++;
                }
            }
            foreach (range('A', 'K') as $columnID) {
                $this->excel->getActiveSheet()->getColumnDimension($columnID)->setAutoSize(true);
            }

            $filename = 'Trip Cancellation - '.$from.' to '.$to.'.xls';
            header('Content-Type: application/vnd.ms-excel');
            header('Content-Disposition: attachment;filename="' . $filename . '"');
            header('Cache-Control: max-age=0');
            $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
            $objWriter->setPreCalculateFormulas(true);
            $objWriter->save('php://output');
        } else {
            $this->load->view('site/report/trip-cancellation-report-list',$data);
        }
    }

    function after_departure_booking_report(){
        $this->is_logged_in();
        
        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        
        $data['tags'] = $tags->data;
        $data['active_schedules'] = get_active_schedules();
        $data['groupusers'] = get_active_group_and_users();

        $this->load->view('site/report/after-departure-booking-report', $data);
    }

    function after_departure_booking_report_list(){
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQI6GG934',
            'fromDate' => $this->input->post('from'),
            'toDate' => $this->input->post('to'),
            'scheduleCode' => $this->input->post('schedule_code'),
            'groupCode' => $this->input->post('group_code'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['device'] = array();
        $data['route'] = array();
        $data['group'] = array();
        foreach($result->data as $row){
            if(in_array($row->device_medium, $data['device'])) {
                $data['device'][$row->device_medium] = 1;
            } else {
                $data['device'][$row->device_medium] += $row->seat_count;
            }
            $rte = $row->from_station_name.' - '.$row->to_station_name;
            if(in_array($rte, $data['route'])) {
                $data['route'][$rte] = 1;
            } else {
                $data['route'][$rte] += $row->seat_count;
            }
            if(in_array($row->device_medium, $data['group'])) {
                $data['group'][$row->user_group_name] = 1;
            } else {
                $data['group'][$row->user_group_name] += $row->seat_count;
            }
        }
        $data['result'] = $result->data;
        $this->load->view('site/report/after-departure-booking-report-list',$data);
    }

    function get_pending_ticket_status(){
        $this->is_logged_in();

        switch(strtolower($this->input->post('providerName'))){
            case 'payubiz':
                $gatewayName = 'PAYUBIZ'; break;
            case 'cc avenue':
                $gatewayName = 'CCAVENUE'; break;
        }

        $data = array(
            'orderCode' => $this->input->post('ticketpnrcode'),
            'gatewayName' => $gatewayName,
            'namespaceCode' => $this->input->post('nsCode')
        );
        echo $this->api_model->getOrderStatus($data);
    }

    public function addon_transaction_report() {
        $this->is_logged_in();
        $data['addons_type'] = config_item('addons_type');
        $this->load->view('site/report/addon-transaction-report', $data);
    }

    function addon_transaction_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQIA953936',
            'travelDateFlag' => $this->input->post('date_option'),
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'addonType' => $this->input->post('addon_type')
        );

        $p_key = _get_namespace_id().'_addon_transaction_report_'.md5(http_build_query($data));
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

        $meta = array();
        $data['addons_type'] = config_item('addons_type');
        $addons_type = config_item('addons_type');
        $seat_count = 0;

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    //  discount type based meta
                    $meta['type'][$addons_type[$result->data[$i]->addons_type_code]]['fare'] += $result->data[$i]->ticket_amount;
                    $meta['type'][$addons_type[$result->data[$i]->addons_type_code]]['discount'] += $result->data[$i]->discount_amount;
                    //  usergroup based meta
                    $meta['group'][$result->data[$i]->user_group_name]['fare'] += $result->data[$i]->ticket_amount;
                    $meta['group'][$result->data[$i]->user_group_name]['discount'] += $result->data[$i]->discount_amount;
                    //  route based meta
                    $r = $result->data[$i]->from_station_name.' to '.$result->data[$i]->to_station_name;
                    $meta['route'][$r]['fare'] += $result->data[$i]->ticket_amount;
                    $meta['route'][$r]['discount'] += $result->data[$i]->discount_amount;

                    $meta['total_fare'] += $result->data[$i]->ticket_amount;
                    $meta['total_discount'] += $result->data[$i]->discount_amount;

                    $seat_count += $result->data[$i]->seat_count;
                }
            }
        }

        $data['tickets'] = $result->data;
        $data['meta'] = $meta;

        $data['total_tickets'] = $ticket_count;
        $data['total_seats'] = $seat_count;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/addon-transaction-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=addon_transaction_report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/addon-transaction-report-list', $data);
        }
    }

    public function tcs_report() {
        $this->is_logged_in();

        $data = array();
        $data['groupusers'] = get_active_group_and_users();

        $this->load->view('site/report/tcs-report', $data);
    }

    public function tcs_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQJ19GP37',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate'),
            'travelDateFlag' => $this->input->post('travelDateFlag'),
            'groupCode' => $this->input->post('groupCode'),
            'userCode' => $this->input->post('userCode'),
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['bo_tot_trans_amt'] = 0;
        $data['bo_tot_ac_bus_tax'] = 0;
        $data['ca_tot_trans_amt'] = 0;
        $data['ca_tot_ac_bus_tax'] = 0;
        foreach($result->data as $row){
            if($row->transaction_type == 'BO') {
                $data['bo_tot_trans_amt'] += ($row->transaction_amount - $row->addons_amount);
                $data['bo_tot_ac_bus_tax'] += $row->booked_ac_bus_tax;
            } else if($row->transaction_type == 'CA') {
                $data['ca_tot_trans_amt'] += ($row->transaction_amount - $row->addons_amount);
                $data['ca_tot_ac_bus_tax'] += $row->booked_ac_bus_tax;
            }
        }

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/tcs-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=TCS Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/tcs-report-list', $data);
        }
    }

    public function branch_collections_report() {
        $this->is_logged_in();
        
        if (has_action_rights('BRN-COL-RPT-ALL-BRN')) {
            $branches = $this->api_model->getOrganization();
            $branches = json_decode($branches);
            usort($branches->data, function($a, $b) {
                return strcasecmp($a->name,  $b->name);
            });
            $data['branches'] = $branches->data;
        }
        
        $this->load->view('site/report/branch-collections-report', $data);
    }

    function branch_collections_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQJ34FE46',
            'travelDateFlag' => $this->input->post('date_option'),
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'phoneTicketFlag' => $this->input->post('pbl_flag') ?: 0,
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
        );

        if(!has_action_rights('BRN-COL-RPT-ALL-BRN')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }

        $p_key = _get_namespace_id().'_branch_collections_report_'.md5(http_build_query($data));
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

        $booking = array();
        $cancel = array();
        $meta = array();
        $seat_count = 0;

        $totals = array();

        if ($result->status == 1) {
            foreach($result->data as $row) {
                if (strtolower($row->user_group_name) == "customer") {
                    $row->user_name = 'Guest';
                }

                if($row->ticket_status_code=='BO' || $row->ticket_status_code=='PBL') {
                    $booking[$row->organization_name]['booking']['fare'] += $row->ticket_amount;
                    $booking[$row->organization_name]['booking']['gst'] += $row->ac_bus_tax;
                    $booking[$row->organization_name]['booking']['commission'] += $row->commission_amount;
                    $booking[$row->organization_name]['booking']['seats'] += $row->seat_count;
                    $booking[$row->organization_name]['booking']['discount'] += $row->addon_amount;
                    $booking[$row->organization_name]['booking']['crossamount'] += ($row->ticket_amount+$row->ac_bus_tax-$row->commission_amount-$row->addon_amount);

                    $booking[$row->organization_name]['name'] = $row->organization_name;
                    $booking[$row->organization_name]['orgcode'] = $row->organization_code;

                    $booking[$row->organization_name]['users'][$row->user_name]['booking']['fare'] += $row->ticket_amount;
                    $booking[$row->organization_name]['users'][$row->user_name]['booking']['gst'] += $row->ac_bus_tax;
                    $booking[$row->organization_name]['users'][$row->user_name]['booking']['commission'] += $row->commission_amount;
                    $booking[$row->organization_name]['users'][$row->user_name]['booking']['seats'] += $row->seat_count;
                    $booking[$row->organization_name]['users'][$row->user_name]['booking']['discount'] += $row->addon_amount;
                    $booking[$row->organization_name]['users'][$row->user_name]['booking']['crossamount'] += ($row->ticket_amount + $row->ac_bus_tax - $row->commission_amount - $row->addon_amount);

                    $booking[$row->organization_name]['users'][$row->user_name]['name'] = $row->user_name;
                    $booking[$row->organization_name]['users'][$row->user_name]['group'] = $row->user_group_name;
                    $booking[$row->organization_name]['users'][$row->user_name]['code'] = $row->user_code;
                    
                } else if($row->ticket_status_code=='CA' || $row->ticket_status_code=='TCA'){
                    $booking[$row->organization_name]['cancel']['fare'] += $row->ticket_amount;
                    $booking[$row->organization_name]['cancel']['gst'] += $row->ac_bus_tax;
                    $booking[$row->organization_name]['cancel']['revoke'] += $row->revoke_commission_amount;
                    $booking[$row->organization_name]['cancel']['refund'] += ($row->ticket_amount-$row->addon_amount+$row->ac_bus_tax-$row->cancellation_charges-$row->revoke_commission_amount+$row->cancel_commission);
                    $booking[$row->organization_name]['cancel']['cancellation_charges'] += $row->cancellation_charges;
                    $booking[$row->organization_name]['cancel']['agent_share'] += $row->cancel_commission;
                    $booking[$row->organization_name]['cancel']['seats'] += $row->seat_count;
                    $booking[$row->organization_name]['cancel']['discount'] += $row->addon_amount;
                    $booking[$row->organization_name]['cancel']['revenue'] += ($row->cancellation_charges-$row->cancel_commission);

                    $booking[$row->organization_name]['name'] = $row->organization_name;

                    $booking[$row->organization_name]['users'][$row->user_name]['cancel']['fare'] += $row->ticket_amount;
                    $booking[$row->organization_name]['users'][$row->user_name]['cancel']['gst'] += $row->ac_bus_tax;
                    $booking[$row->organization_name]['users'][$row->user_name]['cancel']['revoke'] += $row->revoke_commission_amount;
                    $booking[$row->organization_name]['users'][$row->user_name]['cancel']['refund'] += ($row->ticket_amount - $row->addon_amount + $row->ac_bus_tax - $row->cancellation_charges - $row->revoke_commission_amount + $row->cancel_commission);
                    $booking[$row->organization_name]['users'][$row->user_name]['cancel']['cancellation_charges'] += $row->cancellation_charges;
                    $booking[$row->organization_name]['users'][$row->user_name]['cancel']['agent_share'] += $row->cancel_commission;
                    $booking[$row->organization_name]['users'][$row->user_name]['cancel']['seats'] += $row->seat_count;
                    $booking[$row->organization_name]['users'][$row->user_name]['cancel']['discount'] += $row->addon_amount;
                    $booking[$row->organization_name]['users'][$row->user_name]['cancel']['revenue'] += ($row->cancellation_charges - $row->cancel_commission);

                    $booking[$row->organization_name]['users'][$row->user_name]['name'] = $row->user_name;
                    $booking[$row->organization_name]['users'][$row->user_name]['group'] = $row->user_group_name;
                    $booking[$row->organization_name]['users'][$row->user_name]['code'] = $row->user_code;
                }
            }
        }
        
        $data['meta'] = $meta;
        $data['bookings'] = $booking;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/branch-collections-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=branch-collections-report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/branch-collections-report-list', $data);
        }
    }

    public function mobile_app_customers_report() {
        $this->is_logged_in();

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQFCF8Z8'
        ));
        $result = json_decode($result);
        $data['result'] = $result->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/mobile-app-customers-report-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=mobile-app-customers-report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/mobile-app-customers-report', $data);
        }
    }

    function user_voucher_due_report(){
        $this->is_logged_in();

        $data = array();
        $data['groupusers'] = get_active_group_and_users();

        $this->load->view('site/report/user-voucher-due-report', $data);
    }

    function user_voucher_due_report_summary(){
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQJ4265643',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'travelDateFlag' => $this->input->post('travelDateFlag'),
            'userCode' => $this->input->post('userCode'),
            'filterTypeCode' => 'SUMMARY'
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $booking = array();

        foreach ($result->data as $row) {
            if (strtolower($row->user_group_name) == "customer") {
                $row->user_first_name = 'Guest';
            }

            if ($row->transaction_type_id == 1) {
                $booking[$row->user_first_name]['booking']['fare'] += $row->ticket_amount;
                $booking[$row->user_first_name]['booking']['gst'] += $row->ac_bus_tax;
                $booking[$row->user_first_name]['booking']['commission'] += $row->commission_amount;
                $booking[$row->user_first_name]['booking']['seats'] += $row->seat_count;
                $booking[$row->user_first_name]['booking']['discount'] += $row->addon_amount;
                $booking[$row->user_first_name]['booking']['crossamount'] += ($row->ticket_amount + $row->ac_bus_tax - $row->commission_amount - $row->addon_amount);
                $booking[$row->user_first_name]['name'] = $row->user_first_name;
                $booking[$row->user_first_name]['group'] = $row->user_group_name;
                $booking[$row->user_first_name]['usercode'] = $row->user_code;

            } else if ($row->transaction_type_id == 2) {
                $booking[$row->user_first_name]['cancel']['fare'] += $row->ticket_amount;
                $booking[$row->user_first_name]['cancel']['gst'] += $row->ac_bus_tax;
                $booking[$row->user_first_name]['cancel']['revoke'] += $row->revoke_commission_amount;
                $booking[$row->user_first_name]['cancel']['refund'] += ($row->ticket_amount - $row->addon_amount + $row->ac_bus_tax - $row->cancellation_charges - $row->revoke_commission_amount + $row->cancel_commission);
                $booking[$row->user_first_name]['cancel']['cancellation_charges'] += $row->cancellation_charges;
                $booking[$row->user_first_name]['cancel']['agent_share'] += $row->cancel_commission;
                $booking[$row->user_first_name]['cancel']['seats'] += $row->seat_count;
                $booking[$row->user_first_name]['cancel']['discount'] += $row->addon_amount;
                $booking[$row->user_first_name]['cancel']['revenue'] += ($row->cancellation_charges - $row->cancel_commission);
                $booking[$row->user_first_name]['name'] = $row->user_first_name;
                $booking[$row->user_first_name]['group'] = $row->user_group_name;
                $booking[$row->user_first_name]['usercode'] = $row->user_code;
            }
        }
        $data['bookings'] = $booking;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/user-voucher-due-report-summary-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=User-Voucher-Due-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/user-voucher-due-report-summary', $data);
        }
    }

    function user_voucher_due_report_list(){
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQJ4265643',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'travelDateFlag' => $this->input->post('travelDateFlag'),
            'userCode' => $this->input->post('userCode'),
            'filterTypeCode' => 'TRANSACTION'
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $booking = array();

        foreach ($result->data as $row) {
            if ($row->transaction_type_id == 1) {
                $row->crossamount = $row->ticket_amount + $row->ac_bus_tax - $row->commission_amount - $row->addon_amount;
                $booking['booking'][] = $row;
            } else if ($row->transaction_type_id == 2) {
                $row->cancels = $row->ticket_amount - $row->addon_amount + $row->ac_bus_tax - $row->revoke_commission_amount;
                $row->revenue = $row->cancellation_charges - $row->cancel_commission;
                $booking['cancellation'][] = $row;
            }
        }
        $data['result'] = $booking;
        
        $this->load->view('site/report/user-voucher-due-report-list', $data);
    }

    public function branch_collections_summary() {
        $this->is_logged_in();
        $group_by_2 = $this->input->post('group_by_2');
        $group_by_3 = $this->input->post('group_by_3');
        $data = array(
            'queryCode' => 'RQF3K85712',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'travelDateFlag' => $this->input->post('date_option'),
            'scheduleCode' => $this->input->post('schedule_code'),
            'fromStationCode' => $this->input->post('from_code'),
            'toStationCode' => $this->input->post('to_code'),
            'groupCode' => $this->input->post('group_code'),
            'userCode' => $this->input->post('user_code'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $tickets = array();

        $tickets['bo_fare'] = 0;
        $tickets['bo_comission'] = 0;
        $tickets['bo_ac_tax'] = 0;
        $tickets['bo_discount'] = 0;
        $tickets['bo_payable'] = 0;

        $tickets['ca_fare'] = 0;
        $tickets['ca_ac_tax'] = 0;
        $tickets['ca_discount'] = 0;
        $tickets['ca_comission'] = 0;
        $tickets['ca_charges'] = 0;
        $tickets['ca_share'] = 0;
        $tickets['ca_refund'] = 0;

        $tickets['tca_refund'] = 0;
        $tickets['device'] = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    $tickets['user_name'] = $result->data[$i]->user_name;
                    $tickets['user_group_name'] = $result->data[$i]->user_group_name;

                    if ($result->data[$i]->ticket_status_code == 'BO' || $result->data[$i]->ticket_status_code == 'PBL' ) {
                        $tickets['bo_fare'] += $result->data[$i]->ticket_amount;
                        $tickets['bo_comission'] += $result->data[$i]->commission_amount;
                        $tickets['bo_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        $tickets['bo_discount'] += $result->data[$i]->addons_amount;
                        $result->data[$i]->payable = ($result->data[$i]->ticket_amount+$result->data[$i]->ac_bus_tax-$result->data[$i]->addons_amount-$result->data[$i]->commission_amount);
                        $tickets['bo_payable'] += $result->data[$i]->payable;
                    } else if ($result->data[$i]->ticket_status_code == 'CA'){
                        $tickets['ca_fare'] += $result->data[$i]->ticket_amount;
                        $tickets['ca_ac_tax'] += $result->data[$i]->ac_bus_tax;
                        $tickets['ca_discount'] += $result->data[$i]->addons_amount;
                        $tickets['ca_comission'] += $result->data[$i]->commission_amount;
                        $tickets['ca_charges'] += $result->data[$i]->cancellation_charges;
                        $tickets['ca_share'] += $result->data[$i]->cancel_commission;
                        $tickets['ca_refund'] += $result->data[$i]->refund_amount + $result->data[$i]->revoke_commission_amount;
                    } else if ($result->data[$i]->ticket_status_code == 'TCA'){
                        $tickets['tca_refund'] += $result->data[$i]->ticket_amount+$result->data[$i]->ac_bus_tax-$result->data[$i]->addons_amount-$result->data[$i]->commission_amount;
                    }


                    $tickets['total_fare'] += $result->data[$i]->ticket_amount;
                    $tickets['total_refund'] += $result->data[$i]->refund_amount + $result->data[$i]->revoke_commission_amount;
                    $tickets['total_cancellation'] += $result->data[$i]->cancellation_charges;


                    $one = date('Y-m-d', strtotime($result->data[$i]->transaction_date));
                    if ($data['travelDateFlag'] == 1)
                        $one = $result->data[$i]->travel_date;

                    //$tickets['one']['name'] = $one;
                    if ($group_by_2 == "")
                        $tickets['one'][$one][] = $result->data[$i];    //  1st level group
                    else if ($group_by_2 != "") {
                        $second = "";
                        if ($group_by_2 == 1)
                            $second = $result->data[$i]->trip_name;
                        if ($group_by_2 == 2)
                            $second = $result->data[$i]->user_group_name;

                        if ($group_by_3 == "") {
                            //$tickets['one'][$one]['heading'] = $second;
                            $tickets['one'][$one]['second'][$second][] = $result->data[$i];    //  2nd level group
                        } else {
                            $third = "";
                            if ($group_by_3 == 1)
                                $third = $result->data[$i]->user_group_name;
                            $tickets['one'][$one]['second'][$second]['third'][$third][] = $result->data[$i];    //  2nd level group
                        }
                    }
                    if(in_array($result->data[$i]->device_medium, $data['device'])) {
                        $tickets['device'][$result->data[$i]->device_medium] = 1;
                    } else {
                        $tickets['device'][$result->data[$i]->device_medium] += $result->data[$i]->seat_count;
                    }
                }

                if ($group_by_2 == "") {
                    ksort($tickets['one']);
                }

            }
        }
        if ($this->input->post('export') == 1) {
            require_once APPPATH.'third_party/tcpdf/tcpdf.php';
            $pdf = new TCPDF();
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('times', '', 8);
            $pdf->AddPage();

            $this->load->exclude_template();
            $content = $this->load->view('site/report/branch-collections-summary-pdf', array('tickets' => $tickets), true);

            $pdf->writeHTML($content);
            $this->load->exclude_template();
            $pdf->Output('branch-collections-summary.pdf', "d");
        } else {
            $this->load->view('site/report/branch-collections-summary', array('tickets' => $tickets));
        }
    }
    
    function additional_revenue_report(){
        $this->is_logged_in();
        $this->load->view('site/report/additional-revenue-report');
    }

    function additional_revenue_report_list(){
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQJ8MA749',
            'fromDate' => $this->input->post('from'),
            'toDate' => $this->input->post('to'),
            'ticketFilter' => $this->input->post('ticket_filter'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/additional-revenue-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Additional Revenue Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/additional-revenue-report-list',$data);
        }
    }
    
    public function frequent_customer_report() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
                        
        $this->load->view('site/report/frequent-customer-report', $data);
    }

    public function frequent_customer_report_list() {
        $this->is_logged_in();
        
        if($this->input->post('customerType') == 'NEWCUST'){
            $count = 0;
        }
        else{
            $count = $this->input->post('count');
        }
        $data = array(
            'queryCode' => 'RQJ9JB3853',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),            
            'fromStationCode' => $this->input->post('from_code'),
            'toStationCode' => $this->input->post('to_code'),
            'customerType' => $this->input->post('customerType'),
            'count' => $count
        );
        
        $p_key = _get_namespace_id().'_frequent_customers_'.md5(http_build_query($data));
        if( !$result = $this->rediscache->get($p_key)) {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 900); //15 mins
        }
        $result = json_decode($result);
                
        $data = array(
            'customers' => $result->data
        );

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/frequent-customer-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Frequent-Customers-report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/frequent-customer-report-list', $data);
        }
    }
    
    public function direct_online_sales_report() {
        $this->is_logged_in();

        $data = array();
        $data['groupusers'] = get_active_group_and_users();

        $this->load->view('site/report/direct-online-sales-report', $data);
    }
    
    public function direct_online_sales_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQJAPGI55'
        );
        if ($this->input->post('fromDate') != '') {
            $data['fromDate'] = $this->input->post('fromDate');
        }
        if ($this->input->post('toDate') != '') {
            $data['toDate'] = $this->input->post('toDate');
        }
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $tickets = array();
        $summary = array();
        $pg = array();
        $chart = array();
        $allmedium = array();
        
        usort($result->data, function($a, $b) {
            return (strtotime(trim($a->transaction_date)) < strtotime(trim($b->transaction_date))) ? -1 : 1;
        });

        foreach ($result->data as $row) {
            if ($row->ticket_status_code == 'BO' || $row->ticket_status_code == 'PBL') {
                $tkt = 'BO';
            } else if ($row->ticket_status_code == 'CA' || $row->ticket_status_code == 'TCA') {
                $tkt = 'CA';
            }
            $tickets[$tkt][] = $row;

            $summary[$row->device_medium][$tkt]['fare'] += $row->ticket_amount;
            $summary[$row->device_medium][$tkt]['seats'] += $row->seat_count;
            $summary[$row->device_medium][$tkt]['gst'] += $row->ac_bus_tax;
            $summary[$row->device_medium][$tkt]['discount'] += $row->addons_amount;
            $summary[$row->device_medium][$tkt]['ccharges'] += $row->cancellation_charges;
            $summary[$row->device_medium][$tkt]['refund'] += $row->refund_amount;
            
            $pg[$row->gateway_partner_name][$tkt]['fare'] += $row->ticket_amount;
            $pg[$row->gateway_partner_name][$tkt]['seats'] += $row->seat_count;
            
            if($tkt=="BO") {
                $chart[date('d-m-Y', strtotime($row->transaction_date))][$row->device_medium]['fare'] += $row->ticket_amount;
                $chart[date('d-m-Y', strtotime($row->transaction_date))][$row->device_medium]['seats'] += $row->seat_count;
            } else {
                $chart[date('d-m-Y', strtotime($row->transaction_date))][$row->device_medium]['fare'] -= $row->ticket_amount;
                $chart[date('d-m-Y', strtotime($row->transaction_date))][$row->device_medium]['seats'] -= $row->seat_count;
            }    
            $allmedium[$row->device_medium] = $row->device_medium;
        }
        ksort($allmedium);
        //ksort($chart);
        $data['tickets'] = $tickets;
        $data['summary'] = $summary;
        $data['chart'] = $chart;
        $data['pg'] = $pg;
        $data['allmedium'] = $allmedium;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/direct-online-sales-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Direct-online-sales-report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/direct-online-sales-report-list', $data);
        }
    }
    
    public function recharge_pending_order() {
        $this->is_logged_in();
        _include_js('assets/js/pages/recharge-pending-order.js', '_init_recharge_pending_order_page');
        $this->load->view('site/report/recharge-pending-order');
    }
    
    public function get_recharge_pending_order_list() {
        $this->is_logged_in();
        
        $data = array(
            'queryCode' => 'RQJAJBE54'
        );
        if ($this->input->post('fromDate') != '') {
            $data['fromDate'] = $this->input->post('fromDate');
        }
        if ($this->input->post('toDate') != '') {
            $data['toDate'] = $this->input->post('toDate');
        }
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['pending_orders'] = $result;
        
        $this->load->view('site/report/recharge-pending-order-list', $data);
        
    }
    
    
    public function cancel_recharge_pending_order() {
        $this->is_logged_in();
        
        $data = array('ticketCode' => $this->input->post('ticketcode'), 'transactionCode' => $this->input->post('transactionCode'));
        $status = $this->api_model->cancelRechargePendingOrder($data);

        echo $status;
    }
    
    public function confirm_recharge_pending_order() {
        $this->is_logged_in();

        $data = array(
            'ordercode' => $this->input->post('order_code')
        );
        $status = $this->api_model->confirmRechargePendingOrder($data);

        echo $status;
    }

    public function schedule_seat_visibility_audit_report() { 
        $this->is_logged_in();

        $this->load->view('site/report/schedule-seat-visibility-audit-report');
    }

    function schedule_seat_visibility_audit_report_list() {
        $this->is_logged_in();
        
            $data = array(
            'travelDate' => $this->input->post('travelDate')
        );
            
        $result = $this->api_model->getScheduleSeatVisibilityAuditReport($data);
        
        $reports = json_decode($result);
        $data['reports'] = $reports->data;
        $data['visibility_type'] = $this->config->item('visibility_type');
        
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/schedule-seat-visibility-audit-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=schedule-seat-visibility-audit-report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
        $this->load->view('site/report/schedule-seat-visibility-audit-report-list', $data);
        }
        //echo json_encode($data);
    }
    
    public function customer_details() {
        $this->is_logged_in();
        $this->load->view('site/report/customer-details');
    }

    function customer_details_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQJBG85856',
            'fromDate' => $this->input->post('from'),
            'toDate' => $this->input->post('to')
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['reports'] = $result->data;
        
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/customer-details-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=customer-details-report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/customer-details-report-list', $data);
        }
    }
    
    public function driver_duty_allocation() {
        $this->is_logged_in();
        
        //Get Driver Details
        $result = $this->api_model->getVehicleDriver();
        $result = json_decode($result);
        $data['drivers'] = $result->data;
        
        $this->load->view('site/report/driver-duty-allocation', $data);
    }

    function driver_duty_allocation_report_list() {
        $this->is_logged_in();
        
        $data = array(
            'queryCode' => 'RQJCLA5036',
            'fromDate' => $this->input->post('from'), 
            'toDate' => $this->input->post('to'), 
            'driverCode' => $this->input->post('driverCode')?: 'NA'
        );
        
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        
        $data['reports'] = $result->data;
        
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/driver-duty-allocation-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=driver-duty-allocation-report-list.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/driver-duty-allocation-report-list', $data);
        }
    }

    public function refund_ticket_from_pending() {
        $this->is_logged_in();

        echo $this->api_model->refundTicketFromPending(array(
            'transactionCode' => $this->input->post('transactionCode'),
            'orderCode' => $this->input->post('orderCode'),
            'amount' => $this->input->post('amount') ?: 0,
            'orderType' => $this->input->post('orderType') ?: 'TICKBO',
        ));
    }

    public function ledger_transaction(){
        $this->is_logged_in();

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $data['users'] = $users->data;

        $this->load->view('site/report/ledger-transaction-report', $data);
    }

    public function ledger_transaction_report_list() {
        $this->is_logged_in();
        
        $data = array(
            'fromDate' => $this->input->post('fromDate'), 
            'toDate' => $this->input->post('toDate'),
            'userCode' => $this->input->post('userCode')
        );
               
        $result = $this->api_model->getLedgerTransactionReport($data);
        
        $results = json_decode($result);
        $data['result'] = $results->data;
        $data['delivery_type_codes'] = config_item('delivery_type_codes');
        $data['user'] = $this->input->post('user');

        $this->load->view('site/report/ledger-transaction-report-list', $data);
    }

    function get_ledger_receipt(){
        $this->is_logged_in();

        echo $this->api_model->getLedgerReceipt(array('receiptDetailsCode' => $this->input->post('receiptDetailsCode')));
    }

    public function branch_consolidation_report(){
        $this->is_logged_in();

        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
        $usr_pro = json_decode($usr_pro);
        $data['user_profile'] = $usr_pro->data;
        
        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $data['users'] = $users->data;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);

        usort($branches->data, function($a, $b) {
            return strcasecmp($a->station->name,  $b->station->name);
        });
        
        $station = array();
        foreach($branches->data as $key=>$val){
            $station[$val->station->code] = $val;
        }

        $data['station'] = array_values($station);

        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['zone'] = $zone->data;

        $this->load->view('site/report/branch-consolidation-report', $data);
    }

    public function branch_consolidation_report_list() {
        $this->is_logged_in();
        $ns_id = $this->session->userdata('namespace_id');
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQM038DH93',
            'fromDate' => date('Y-m-d H:i:s', strtotime($fromDate)),
            'toDate' => date('Y-m-d H:i:s', strtotime($toDate)),
            'stationCode' => $this->input->post('station') ?: 'NA',
            'zoneCode' => $this->input->post('zoneCode') ?: 'NA',
            'organizationCode' => 'NA',
        );
        
        $key = $ns_id.'branch-consolidation-report'.md5(http_build_query($data));

        if(!$result = $this->cache->file->get($key)) {            
            $result = $this->api_model->getDynamicReportDataWithMap($data);            
            $this->cache->file->save($key, $result, 900); //  15 mins
        }
        
        $results = json_decode($result);

        usort($results->data, function($a, $b) {
            return $a->organization_name < $b->organization_name ? -1 : 1;
        });

        $DC = array();
        if ($this->input->post('export') != 1) {
        foreach($results->data as $key=>$val){
            
            // booking
            $DC[$val->organization_code]['paid_book'] += $val->paid_booking_amount; 
            $DC[$val->organization_code]['paid_book_other'] += ($val->paid_other_charges_amount + $val->paid_pickup_handling_amount); 
            // $DC[$val->organization_code]['paid_book_gst'] += $val->paid_service_tax; 
            $DC[$val->organization_code]['paid_book_tds'] += $val->paid_booking_tds_commission_amount; 
            
            $DC[$val->organization_code]['topay_book'] += $val->topay_booking_amount;  
            $DC[$val->organization_code]['topay_book_other'] += ($val->topay_other_charges_amount + $val->topay_pickup_handling_amount); 
            // $DC[$val->organization_code]['topay_book_gst'] += $val->topay_service_tax; 
            $DC[$val->organization_code]['topay_book_tds'] += $val->topay_booking_tds_commission_amount; 

            $DC[$val->organization_code]['onacc_book'] += $val->onacc_booking_amount; 
            $DC[$val->organization_code]['onacc_book_other'] += ($val->onacc_other_charges_amount + $val->onacc_pickup_handling_amount); 
            // $DC[$val->organization_code]['onacc_book_gst'] += $val->onacc_service_tax; 
            $DC[$val->organization_code]['onacc_book_tds'] += $val->onacc_booking_tds_commission_amount; 

            // delivery
            $DC[$val->organization_code]['paid_del'] += $val->paid_delivery_amount; 
            $DC[$val->organization_code]['paid_del_other'] += ($val->paid_delivery_other_charges_amount + $val->paid_delivery_delivery_handling_amount); 
            // $DC[$val->organization_code]['paid_del_gst'] += $val->paid_delivery_service_tax; 
            $DC[$val->organization_code]['paid_del_tds'] += $val->paid_delivery_tds_commission_amount; 

            $DC[$val->organization_code]['topay_del'] += $val->topay_delivery_amount; 
            $DC[$val->organization_code]['topay_del_other'] += ($val->topay_delivery_other_charges_amount + $val->topay_delivery_handling_amount); 
            // $DC[$val->organization_code]['topay_del_gst'] += $val->topay_delivery_service_tax; 
            $DC[$val->organization_code]['topay_del_tds'] += $val->topay_delivery_tds_commission_amount; 

            $DC[$val->organization_code]['onacc_del'] += $val->onacc_delivery_amount; 
            $DC[$val->organization_code]['onacc_del_other'] += ($val->onacc_delivery_other_charges_amount + $val->onacc_delivery_handling_amount); 
            // $DC[$val->organization_code]['onacc_del_gst'] += $val->onacc_delivery_service_tax; 
            $DC[$val->organization_code]['onacc_del_tds'] += $val->onacc_delivery_tds_commission_amount; 

            $DC[$val->organization_code]['book_commission'] += ($val->paid_booking_commission_amount + $val->topay_booking_commission_amount + $val->onacc_booking_commission_amount); 
            $DC[$val->organization_code]['book_charges_share'] += ($val->paid_loading_commission_amount + $val->topay_loading_commission_amount + $val->onacc_loading_commission_amount); 

            $DC[$val->organization_code]['del_commission'] += ($val->paid_delivery_commission_amount+$val->topay_delivery_commission_amount+$val->onacc_delivery_commission_amount); 
            $DC[$val->organization_code]['del_charges_share'] += ($val->paid_unloading_commission_amount + $val->topay_unloading_commission_amount + $val->onacc_unloading_commission_amount); 

            $DC[$val->organization_code]['data'][] = $val; 
            $DC[$val->organization_code]['org_name'] = $val->organization_name; 
        }
        }
        // print_r($DC);die;
        $data['DC_data'] = $DC;
        $data['from_date'] = $from_date;
        $data['to_date'] = $to_date;
        $data['result'] = $results->data;
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        // $data['delivery_type_codes'] = config_item('delivery_type_codes');

        if ($this->input->post('export') == 1) {
            $filename = 'Branch-Consolidation-Report';
            $this->load->excel('site/report/branch-consolidation-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/report/branch-consolidation-report-list', $data);
        }
    }

    public function branch_date_wise_transaction_report(){
        $this->is_logged_in();

        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
        $usr_pro = json_decode($usr_pro);
        $data['user_profile'] = $usr_pro->data;
        
        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $data['users'] = $users->data;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);

        usort($branches->data, function($a, $b) {
            return strcasecmp($a->name,  $b->name);
        });
        $data['org'] = $branches->data;

        $this->load->view('site/report/branch-date-wise-transaction-report', $data);
    }

    public function branch_date_wise_transaction_report_list() {
        $this->is_logged_in();
        $ns_id = $this->session->userdata('namespace_id');
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQJ834HD32',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'organizationCode' => $this->input->post('branch')
        );
        
        $key = $ns_id.'branch-date-wise-transaction-report'.md5(http_build_query($data));

        if(!$result = $this->cache->file->get($key)) {            
            $result = $this->api_model->getDynamicReportDataWithMap($data);            
            $this->cache->file->save($key, $result, 900); //  15 mins
        }
        
        $results = json_decode($result);

        usort($results->data, function($a, $b) {
            return $a->organization_name < $b->organization_name ? -1 : 1;
        });

        $list = array();
        $date_array = array();
        foreach($results->data as $key=>$val){
            
            if($val->payment_status == 'PAD'){
                $list[$val->organization_code][$val->booked_at]['paid'] += $val->total_amount; 
                $list[$val->organization_code][$val->booked_at]['paid_other'] += ($val->pickup_handling_amount+$val->delivery_handling_amount+$val->total_handling_amount+$val->total_unload_handling_amount+$val->service_tax+$val->service_charge+$val->hamali_charge+$val->pass_charge+$val->docket_charge+$val->pod_charge+$val->demurrage_charge);
            }

            if($val->payment_status == 'TOP' || $val->payment_status == 'TPPAD'){
                $list[$val->organization_code][$val->booked_at]['topay'] += $val->total_amount;  
                $list[$val->organization_code][$val->booked_at]['topay_other'] += ($val->pickup_handling_amount+$val->delivery_handling_amount+$val->total_handling_amount+$val->total_unload_handling_amount+$val->service_tax+$val->service_charge+$val->hamali_charge+$val->pass_charge+$val->docket_charge+$val->pod_charge+$val->demurrage_charge);
            }

            if($val->payment_status == 'INP' || $val->payment_status == 'OATP'){
                $list[$val->organization_code][$val->booked_at]['onacc'] += $val->total_amount; 
                $list[$val->organization_code][$val->booked_at]['onacc_other'] += ($val->pickup_handling_amount+$val->delivery_handling_amount+$val->total_handling_amount+$val->total_unload_handling_amount+$val->service_tax+$val->service_charge+$val->hamali_charge+$val->pass_charge+$val->docket_charge+$val->pod_charge+$val->demurrage_charge);
            }
            
            
            $list[$val->organization_code]['org_name'] = $val->organization_name; 

            if(!in_array($val->booked_at, $date_array)){
                array_push($date_array, $val->booked_at);
            }
        }

        usort($date_array, function ($a, $b) {
            return strtotime($a) - strtotime($b);
        });

        // print_r($list);die;
        $data['list_data'] = $list;
        $data['from_date'] = $from_date;
        $data['to_date'] = $to_date;
        $data['date_range'] = $date_array;
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');

        if ($this->input->post('export') == 1) {
            $filename = 'Branch-date-wise-transaction-Report';
            $this->load->excel('site/report/branch-date-wise-transaction-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/report/branch-date-wise-transaction-report-list', $data);
        }
    }

    function zone_receivable_report(){
        $this->is_logged_in();

        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['zone'] = $zone->data;
        
        $this->load->view('site/report/zone-receivable-report', $data);
    }

    function zone_receivable_report_list(){
        $this->is_logged_in();
        $ns_id = $this->session->userdata('namespace_id');
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        $transactionType = $this->input->post('transactionType');

        $data = array(
            'queryCode' => 'RQL8TY483',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'zoneCode' => $this->input->post('zoneCode'),
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            // 'dateType' => $this->input->post('dateType'),
            'filterType' => $this->input->post('filterType')
        );

        // $key = $ns_id.'zone-receivable-report'.md5(http_build_query($data));

        // if(!$result = $this->cache->file->get($key)) {            
            $result = $this->api_model->getDynamicReportDataWithMap($data);            
        //     $this->cache->file->save($key, $result, 900); //  15 mins
        // }
        
        $results = json_decode($result);

        usort($results->data, function($a, $b) {
            return $a->organization_name < $b->organization_name ? -1 : 1;
        });

        $zone = array();
        foreach($results->data as $key=>$val){
            if ($transactionType == 'BOOKING' && $val->transaction_type == 'BOOKING') {
                $zone[$val->zone_code]['zone_name'] = $val->zone_name;
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['branch_name'] = $val->delivery_organization_name;
    
                // zone grouping
                $zone[$val->zone_code]['lr_count'] += $val->booking_lr_count; 
                $zone[$val->zone_code]['freight'] += $val->total_amount; 
                $zone[$val->zone_code]['delivery_charge'] += $val->delivery_handling_amount; 
                $zone[$val->zone_code]['loading_charge'] += $val->total_handling_amount; 
                $zone[$val->zone_code]['unloading_charge'] += $val->total_unload_handling_amount; 
                $zone[$val->zone_code]['pickup_charge'] += $val->pickup_handling_amount; 
                $zone[$val->zone_code]['service_charge'] += $val->service_charge; 
                $zone[$val->zone_code]['service_tax'] += $val->service_tax; 
                $zone[$val->zone_code]['amt_paid'] += $val->total_amount_paid; 
                $zone[$val->zone_code]['commission'] += ($val->commission_amount + $val->handling_commission_amount + $val->pickup_handling_commission_amount);
                $zone[$val->zone_code]['del_commission'] += ($val->delivery_commission_amount + $val->delivery_handling_commission_amount + $val->unload_handling_commission_amount);
    
                // $zone[$val->zone_code]['docket_charge'] += $val->docket_charge; 
                $zone[$val->zone_code]['other_charge'] += $val->other_charges-$val->service_charge; 
    
                // organization grouping 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['from_branch'][$val->booking_organization_code]['name'] = $val->booking_organization_name; 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['from_branch'][$val->booking_organization_code]['count'] = $val->booking_lr_count; 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['lr_count'] += $val->booking_lr_count; 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['freight'] += $val->total_amount; 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['delivery_charge'] += $val->delivery_handling_amount; 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['loading_charge'] += $val->total_handling_amount; 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['unloading_charge'] += $val->total_unload_handling_amount; 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['pickup_charge'] += $val->pickup_handling_amount; 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['service_charge'] += $val->service_charge; 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['service_tax'] += $val->service_tax; 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['amt_paid'] += $val->total_amount_paid; 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['commission'] += ($val->commission_amount + $val->handling_commission_amount + $val->pickup_handling_commission_amount);
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['del_commission'] += ($val->delivery_commission_amount + $val->delivery_handling_commission_amount + $val->unload_handling_commission_amount);
    
                // $zone[$val->zone_code]['org'][$val->delivery_organization_code]['docket_charge'] += $val->docket_charge; 
                $zone[$val->zone_code]['org'][$val->delivery_organization_code]['other_charge'] += $val->other_charges-$val->service_charge; 
            } else if ($transactionType == 'DELIVERY' && $val->transaction_type == 'DELIVERY') {
                $zone[$val->zone_code]['zone_name'] = $val->zone_name;
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['branch_name'] = $val->booking_organization_name;
    
                // zone grouping
                $zone[$val->zone_code]['lr_count'] += $val->delivery_lr_count; 
                $zone[$val->zone_code]['freight'] += $val->total_amount; 
                $zone[$val->zone_code]['delivery_charge'] += $val->delivery_handling_amount; 
                $zone[$val->zone_code]['loading_charge'] += $val->total_handling_amount; 
                $zone[$val->zone_code]['unloading_charge'] += $val->total_unload_handling_amount; 
                $zone[$val->zone_code]['pickup_charge'] += $val->pickup_handling_amount; 
                $zone[$val->zone_code]['service_charge'] += $val->service_charge; 
                $zone[$val->zone_code]['service_tax'] += $val->service_tax; 
                $zone[$val->zone_code]['amt_paid'] += $val->total_amount_paid; 
                $zone[$val->zone_code]['commission'] += ($val->commission_amount + $val->handling_commission_amount + $val->pickup_handling_commission_amount);
                $zone[$val->zone_code]['del_commission'] += ($val->delivery_commission_amount + $val->delivery_handling_commission_amount + $val->unload_handling_commission_amount);
    
                // $zone[$val->zone_code]['docket_charge'] += $val->docket_charge; 
                $zone[$val->zone_code]['other_charge'] += $val->other_charges-$val->service_charge; 
    
                // organization grouping 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['to_branch'][$val->delivery_organization_code]['name'] = $val->delivery_organization_name; 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['to_branch'][$val->delivery_organization_code]['count'] = $val->delivery_lr_count; 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['lr_count'] += $val->delivery_lr_count; 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['freight'] += $val->total_amount; 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['delivery_charge'] += $val->delivery_handling_amount; 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['loading_charge'] += $val->total_handling_amount; 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['unloading_charge'] += $val->total_unload_handling_amount; 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['pickup_charge'] += $val->pickup_handling_amount; 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['service_charge'] += $val->service_charge; 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['service_tax'] += $val->service_tax; 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['amt_paid'] += $val->total_amount_paid; 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['commission'] += ($val->commission_amount + $val->handling_commission_amount + $val->pickup_handling_commission_amount);
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['del_commission'] += ($val->delivery_commission_amount + $val->delivery_handling_commission_amount + $val->unload_handling_commission_amount);
    
                // $zone[$val->zone_code]['org'][$val->booking_organization_code]['docket_charge'] += $val->docket_charge; 
                $zone[$val->zone_code]['org'][$val->booking_organization_code]['other_charge'] += $val->other_charges-$val->service_charge; 
            }
        }

        $data['from_date'] = $from_date;
        $data['to_date'] = $to_date;
        $data['summary'] = $zone;
        $data['transactionType'] = $transactionType;
         // if ($this->input->post('export') == 1) {
        //     $filename = 'Zone-Receivable-Report';
        //     $this->load->excel('site/report/zone-receivable-report-list-xls', $data, $filename);
        // } else {
        $this->load->view('site/report/zone-receivable-report-list', $data);
        // }
    }

    function zone_receivable_report_details_list(){
        $this->is_logged_in();
        $ns_id = $this->session->userdata('namespace_id');
        $branch_code = $this->input->post('branch_code');
        $transactionType = $this->input->post('transactionType');

        $data = array(
            'queryCode' => 'RQL8TY483',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'zoneCode' => $this->input->post('zone_code'),
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            // 'dateType' => $this->input->post('dateType'),
            'filterType' => $this->input->post('filterType')
        );

        // $key = $ns_id.'zone-receivable-report-details'.md5(http_build_query($data));

        // if(!$result = $this->cache->file->get($key)) {            
            $result = $this->api_model->getDynamicReportDataWithMap($data);            
        //     $this->cache->file->save($key, $result, 900); //  15 mins
        // }

        $results = json_decode($result);

        $zone = array();
        foreach($results->data as $key=>$val){
            if ($transactionType == 'BOOKING' && $val->transaction_type == 'BOOKING') {
                if($val->to_organization_code == $branch_code){
                    array_push($zone, $val);
                }
            } else if ($transactionType == 'DELIVERY' && $val->transaction_type == 'DELIVERY') {
                if($val->from_organization_code == $branch_code){
                    array_push($zone, $val);
                }
            }
        }

        $data['detail'] = $zone;
        $data['cargo_status'] = config_item('cargo_status');

        // if ($this->input->post('export') == 1) {
        //     $filename = 'Zone-Receivable-Report';
        //     $this->load->excel('site/report/zone-receivable-report-details-list-xls', $data, $filename);
        // } else {
            $this->load->view('site/report/zone-receivable-report-details-list', $data);
        // }
    }

    function zone_report(){
        $this->is_logged_in();

        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['zone'] = $zone->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $all_zone_stations = array();
        foreach($zone->data as $key=>$zones) {
            foreach($zones->stations as $k=>$station) {
                $all_zone_stations[] = $station->code;
            }
        }
        
        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);

        $organization = array();
        foreach ($branches->data as $key=>$branch) {
            if (in_array($branch->station->code, $all_zone_stations)) {
                $organization[] = $branch;
            }
        }

        usort($organization, function ($a, $b) {
            return strcasecmp($a->name,  $b->name);
        });
        $data['organization'] = $organization;

        $this->load->view('site/report/zone-report', $data);
    }

    function zone_report_list(){
        $this->is_logged_in();
        $ns_id = $this->session->userdata('namespace_id');
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        $transactionType = $this->input->post('transactionType');

        $data = array(
            'queryCode' => 'RQNAPJS3', 
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'zoneCode' => $this->input->post('zoneCode'),
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'filterType' => $this->input->post('transactionType'),
            'connectingChargeFlag' => $this->input->post('chargeType'),
            'stationCode' => $this->input->post('stationCode') ?: 'NA'
        );         
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $results = json_decode($result);

        usort($results->data, function($a, $b) {
            return $a->organization_name < $b->organization_name ? -1 : 1;
        });
        $zone = array();
        foreach($results->data as $key=>$val){
            if ($transactionType == 'BOOKING' && $val->transaction_type == 'BOOKING') {
                if($val->connecting_charge > 0){
                  
                    $zone[$val->to_zone_code]['zone_name'] = $val->to_zone_name;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['station_name'] = strtoupper($val->to_station_name);
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['branch_name'] = strtoupper($val->delivery_organization_name);

                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['lr_count'] += $val->total_item_count;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['paid'] += $val->paid_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['topay'] += $val->topay_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['on_account'] += $val->onacc_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['freight'] += $val->total_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['loading_charge'] += $val->total_handling_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['commision'] += $val->total_commission_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['other_charge'] += ($val->service_tax + $val->other_charges + $val->total_unload_handling_amount + $val->delivery_handling_amount + $val->pickup_handling_amount);
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['total_amount'] += $val->total_transaction_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['connecting_charge'] += $val->connecting_charge;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['Conn_Charges_flg'] = 1;
                }else{
                    
                    $zone[$val->to_zone_code]['zone_name'] = $val->to_zone_name;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['station_name'] = strtoupper($val->to_station_name);
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['branch_name'] = strtoupper($val->delivery_organization_name);

                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['lr_count'] += $val->total_item_count;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['paid'] += $val->paid_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['topay'] += $val->topay_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['on_account'] += $val->onacc_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['freight'] += $val->total_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['loading_charge'] += $val->total_handling_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['commision'] += $val->total_commission_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['other_charge'] += ($val->service_tax + $val->other_charges + $val->total_unload_handling_amount + $val->delivery_handling_amount + $val->pickup_handling_amount);
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['total_amount'] += $val->total_transaction_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['connecting_charge'] += $val->connecting_charge;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['Conn_Charges_flg'] = 0;
                }
               
    
            } else if ($transactionType == 'DELIVERY' && $val->transaction_type == 'DELIVERY') {
                if($val->connecting_charge > 0){

                    $zone[$val->from_zone_code]['zone_name'] = $val->from_zone_name;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['station_name'] = strtoupper($val->from_station_name);
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['branch_name'] = strtoupper($val->booking_organization_name);

                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['lr_count'] += $val->total_item_count;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['paid'] += $val->paid_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['topay'] += $val->topay_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['on_account'] += $val->onacc_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['freight'] += $val->total_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['loading_charge'] += $val->total_handling_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['commision'] += $val->total_commission_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['other_charge'] += ($val->service_tax + $val->other_charges + $val->total_unload_handling_amount + $val->delivery_handling_amount + $val->pickup_handling_amount);
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['total_amount'] += $val->total_transaction_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['connecting_charge'] += $val->connecting_charge;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['Conn_Charges_flg'] = 1;
                }else{
                    $zone[$val->from_zone_code]['zone_name'] = $val->from_zone_name;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['station_name'] = strtoupper($val->from_station_name);
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['branch_name'] = strtoupper($val->booking_organization_name);

                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['lr_count'] += $val->total_item_count;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['paid'] += $val->paid_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['topay'] += $val->topay_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['on_account'] += $val->onacc_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['freight'] += $val->total_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['loading_charge'] += $val->total_handling_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['commision'] += $val->total_commission_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['other_charge'] += ($val->service_tax + $val->other_charges + $val->total_unload_handling_amount + $val->delivery_handling_amount + $val->pickup_handling_amount);
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['total_amount'] += $val->total_transaction_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['connecting_charge'] += $val->connecting_charge;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['Conn_Charges_flg'] = 0;
                }
                
            }
        }
        usort($zone, function ($a, $b) {
            return strcmp($a['zone_name'], $b['zone_name']);
        });
        
        $data['from_date'] = $from_date;
        $data['to_date'] = $to_date;
        $data['summary'] = $zone;
        $data['transactionType'] = $transactionType;
        $data['zoneName'] = $this->input->post('zoneName');
        $data['branch'] = $this->input->post('branchName');
        
         if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/zone-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Zone-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/zone-report-list', $data);
        }
    }

    function zone_report_v1(){
        $this->is_logged_in();

        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['zone'] = $zone->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        
        $all_zone_stations = array();
        foreach($zone->data as $key=>$zones) {
            foreach($zones->stations as $k=>$station) {
                $all_zone_stations[] = $station->code;
            }
        }
        
        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);

        $organization = array();
        foreach ($branches->data as $key=>$branch) {
            if (in_array($branch->station->code, $all_zone_stations)) {
                $organization[] = $branch;
            }
        }

        usort($organization, function ($a, $b) {
            return strcasecmp($a->name,  $b->name);
        });
        $data['organization'] = $organization;

        $this->load->view('site/report/zone-report-v1', $data);
    }

    function zone_report_list_v1(){
        $this->is_logged_in();
        $ns_id = $this->session->userdata('namespace_id');
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        $transactionType = $this->input->post('transactionType');

        $data = array(
            'queryCode' => 'RQNAPJS3', 
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'zoneCode' => $this->input->post('zoneCode'),
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'filterType' => $this->input->post('transactionType'),
            'connectingChargeFlag' => $this->input->post('chargeType'),
            'stationCode' => $this->input->post('stationCode') ?: 'NA'
        );         
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $results = json_decode($result);

        usort($results->data, function($a, $b) {
            return $a->organization_name < $b->organization_name ? -1 : 1;
        });

        $zone = array();
        foreach($results->data as $key=>$val){
            if ($transactionType == 'BOOKING' && $val->transaction_type == 'BOOKING') {

                if ($val->connecting_charge > 0) {
                    $zone[$val->to_zone_code]['zone_name'] = $val->to_zone_name;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['station_name'] = strtoupper($val->to_station_name);
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['branch_name'] = strtoupper($val->delivery_organization_name);

                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['lr_count'] += $val->total_item_count;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['paid'] += $val->paid_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['topay'] += $val->topay_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['on_account'] += $val->onacc_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['freight'] += $val->total_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['loading_charge'] += $val->total_handling_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['commision'] += $val->total_commission_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['connecting_charge'] += $val->connecting_charge;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['con_ch'][$val->delivery_organization_code]['total_amount'] += $val->total_transaction_amount;
                }else{
                    $zone[$val->to_zone_code]['zone_name'] = $val->to_zone_name;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['station_name'] = strtoupper($val->to_station_name);
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['branch_name'] = strtoupper($val->delivery_organization_name);

                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['lr_count'] += $val->total_item_count;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['paid'] += $val->paid_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['topay'] += $val->topay_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['on_account'] += $val->onacc_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['freight'] += $val->total_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['loading_charge'] += $val->total_handling_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['commision'] += $val->total_commission_amount;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['connecting_charge'] += $val->connecting_charge;
                    $zone[$val->to_zone_code]['station'][$val->to_station_code]['branch']['out_con_ch'][$val->delivery_organization_code]['total_amount'] += $val->total_transaction_amount;
                }
            } else if ($transactionType == 'DELIVERY' && $val->transaction_type == 'DELIVERY') {
                if ($val->connecting_charge > 0) {
                    $zone[$val->from_zone_code]['zone_name'] = $val->from_zone_name;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['station_name'] = strtoupper($val->from_station_name);
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['branch_name'] = strtoupper($val->booking_organization_name);

                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['lr_count'] += $val->total_item_count;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['paid'] += $val->paid_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['topay'] += $val->topay_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['on_account'] += $val->onacc_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['freight'] += $val->total_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['loading_charge'] += $val->total_handling_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['commision'] += $val->total_commission_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['connecting_charge'] += $val->connecting_charge;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['con_ch'][$val->booking_organization_code]['total_amount'] += $val->total_transaction_amount;
                }else{
                    $zone[$val->from_zone_code]['zone_name'] = $val->from_zone_name;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['station_name'] = strtoupper($val->from_station_name);
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['branch_name'] = strtoupper($val->booking_organization_name);

                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['lr_count'] += $val->total_item_count;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['paid'] += $val->paid_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['topay'] += $val->topay_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['on_account'] += $val->onacc_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['freight'] += $val->total_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['loading_charge'] += $val->total_handling_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['commision'] += $val->total_commission_amount;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['connecting_charge'] += $val->connecting_charge;
                    $zone[$val->from_zone_code]['station'][$val->from_station_code]['branch']['out_con_ch'][$val->booking_organization_code]['total_amount'] += $val->total_transaction_amount;
                }
            }
        }
        
        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        usort($branches->data, function($a, $b) {
            return strcasecmp($a->name,  $b->name);
        });

        usort($zone, function ($a, $b) {
            return strcmp($a['zone_name'], $b['zone_name']);
        });
        $data['branches'] = $branches->data;  
        $data['organization'] = $organization;
        $data['from_date'] = $from_date;
        $data['to_date'] = $to_date;
        $data['summary'] = $zone;
        $data['transactionType'] = $transactionType;
        $data['zoneName'] = $this->input->post('zoneName');
        $data['branch'] = $this->input->post('branchName');
        $data['branch_code']=$this->input->post('organizationCode');
        
         if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/zone-report-list-v1-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Zone-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/zone-report-list-v1', $data);
        }
    }

    function vehicle_hire_report() {
        $this->is_logged_in();

        $transporter = $this->api_model->getContact(array('entityTypeCode' => 'TRANS'));
        $transporter = json_decode($transporter);
        $data['transporter'] = $transporter->data;

        $vehicle = $this->api_model->getVehicle(array('authtoken' => $this->_user_hash));
        $vehicle = json_decode($vehicle);
        $data['vehicle'] = $vehicle->data;

        $cargotags = $this->api_model->cargoTags(array('categoryCode' => 'TRANS'));
        $cargotags = json_decode($cargotags);
        $data['cargotags'] = $cargotags->data;

        $this->load->view('site/report/vehicle-hire-report', $data);
    }

    function vehicle_hire_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQM0826H931',
            'fromDate' => $this->input->post('fromDate'), 
            'toDate' => $this->input->post('toDate'),
            'ownerShipType' => $this->input->post('ownerShipType'),
            'transitTypeCode' => $this->input->post('transitTypeCode'),
            'transporterCode' => $this->input->post('transporterCode') ?: 'NA',
            'vehicleCode' => $this->input->post('vehicleCode') ?: 'NA'
        );
               
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        
        $results = json_decode($result);
        $data['result'] = $results->data;

        $this->load->view('site/report/vehicle-hire-report-list', $data);
    }

    function branch_sales_summary_report() {
        $this->is_logged_in();
        
        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);

        usort($branches->data, function($a, $b) {
            return strcasecmp($a->name,  $b->name);
        });
        $data['organization'] = $branches->data;
       
        $data['logged_in_usr_org_code'] = $this->session->userdata('org_code');

        $this->load->view('site/report/branch-sales-summary-report', $data);
    }

    function branch_sales_summary_report_list() {
        $this->is_logged_in();
        
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
        $data = array(
            'queryCode' => 'RQL3UA5543',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'organizationCode' => $this->input->post('organizationCode'),
            'filterType' => $this->input->post('filterType')
        );
               
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        
        $results = json_decode($result);
        $data['result'] = $results->data;

        $this->load->view('site/report/branch-sales-summary-report-list', $data);
    }

    function branch_sales_summary_report_detail_list() {
        $this->is_logged_in();
        
        $data = array(
            'queryCode' => 'RQL3UA5543',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'organizationCode' => $this->input->post('organizationCode'),
            'filterType' => $this->input->post('filterType')
        );
               
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $results = json_decode($result);

        $details = array();
        foreach($results->data as $key=>$val){
            $details[$val->payment_status_code][] = $val;
        }
        $data['details'] = $details;

        $this->load->view('site/report/branch-sales-summary-report-detail-list', $data);
    }

    function subscription_report() {
        $this->is_logged_in();
        $is_super_ns = _is_super_namespace( $this->session->userdata('native_namespace_code'));
        
        if( $is_super_ns!=1) {
            $this->load->view('site/denied');
            return;
        }
        $this->load->view('site/report/subscription-report');
    }

    function subscription_report_list() {
        $this->is_logged_in();

        $result = $this->api_model->getSubscriptionReportList(array(
            'days' => $this->input->post('days')
        ));
        $results = json_decode($result);
        $data['results'] = $results->data;

        $data['user_name'] = _get_user_name();
        $data['namespace_status'] = config_item('namespace_status');

        $billing_events = config_item('billing_events');

        $events = array();
        foreach($billing_events as $key=>$val) {
            $events[$val['menu']] = $val['name'];
        }
        $data['billing_events'] = $events;
        
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/subscription-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Subscription-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/subscription-report-list', $data);
        }
    }

    function vehicle_tariff_report() {
        $this->is_logged_in();

        $vehicle = $this->api_model->getVehicle(array('authtoken' => $this->_user_hash));
        $vehicle = json_decode($vehicle);
        $data['vehicle'] = $vehicle->data;

        $this->load->view('site/report/vehicle-tariff-report', $data);
    }

    function vehicle_tariff_report_list() {
        $this->is_logged_in();

        $data = array(
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'vehicleCode' => $this->input->post('vehicleCode'),
        );

        $result = $this->api_model->getVehicleTariffList($data);
        $results = json_decode($result);

        $total_km_amt = 0;
        $total_extra_km_amt = 0;
        $total_paid_amt = 0;
        $total_balance_amt = 0;
        foreach ($results->data as $val) {
            $total_km_amt += $val->total_km_amount + $val->hiring_amount;
            $total_extra_km_amt += $val->extra_km_amount;
            $total_paid_amt += $val->advance_amount + $val->fuel_amount + $val->expense_amount;
            $total_balance_amt += $val->total_km_amount + $val->extra_km_amount + $val->hiring_amount - $val->advance_amount - $val->fuel_amount - $val->expense_amount;
        }
        
        $data['total_km_amt'] = $total_km_amt;
        $data['total_extra_km_amt'] = $total_extra_km_amt;
        $data['total_paid_amt'] = $total_paid_amt;
        $data['total_balance_amt'] = $total_balance_amt;
        $data['results'] = $results->data;
        
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/vehicle-tariff-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Vehicle-Tariff-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/vehicle-tariff-report-list', $data);
        }
    }

    function day_closing_report() {
        $this->is_logged_in();

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);

        usort($branches->data, function($a, $b) {
            return strcasecmp($a->name,  $b->name);
        });
        $data['organization'] = $branches->data;

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $data['users'] = $users->data;

        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);

        $allZone = array();
        foreach ($zone->data as $val) {
            $allZone[$val->code]['name'] = $val->name;
            $allZone[$val->code]['code']  = '';
            foreach ($val->stations as $stn) {
                $allZone[$val->code]['code'] .= $stn->code . ',';
            } 
        }
        $data['zone'] = $allZone;
        
        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        
        $this->load->view('site/report/day-closing-report', $data);
    }

    function day_closing_report_list() {
        $this->is_logged_in();
        
        $data = array(
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'organizationCode' => $this->input->post('organizationCode'),
            'userCode' => $this->input->post('userCode'),
            'stationCodes' => $this->input->post('stationCodes'),
            'reportType' => 'SUMMARY'
        );
        
        $p_key = 'day_closing_report_'.md5(http_build_query($data));
        if( !$result = $this->cache->file->get($p_key) ) {            
            $result = $this->api_model->getDayClosingReportList($data);
            $this->cache->file->save($p_key, $result, 900);
        } 
        $results = json_decode($result);
        
        $dayclosing = array();
        foreach ($results->data as $val) {
            $dayclosing[$val->organization->code]['name'] = $val->organization->name;
            $dayclosing[$val->organization->code]['openingBalance'] += $val->openingBalance;
            $dayclosing[$val->organization->code]['paid'] += $val->bookedAmount;
            $dayclosing[$val->organization->code]['delivery'] += $val->deliveryAmount;
            $dayclosing[$val->organization->code]['other_income'] += $val->totalIncomeAmount;
            $dayclosing[$val->organization->code]['expenseAmount'] += $val->totalExpenseAmount;
            $dayclosing[$val->organization->code]['commissionAmount'] += $val->commissionAmount;
            $dayclosing[$val->organization->code]['revertAmount'] += $val->revertAmount;
            $dayclosing[$val->organization->code]['settlementAmount'] += ($val->settlementAmount + $val->openingBalance);
            $dayclosing[$val->organization->code]['dayClosingAmount'] += $val->paidAmount;
            $dayclosing[$val->organization->code]['data'][] = $val;
        }

        $data['dayclosing'] = $dayclosing;

        usort($results->data, function($a, $b) {
            return strcasecmp(trim($a->organization->name), trim($b->organization->name));
        });
        $data['result'] = $results->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/day-closing-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Day-Closing-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/day-closing-report-list', $data);
        }
    }

    function day_closing_report_details_list() {
        $this->is_logged_in();
        
        $data = array(
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'organizationCode' => $this->input->post('organizationCode'),
            'userCode' => $this->input->post('userCode'),
            'stationCodes' => $this->input->post('stationCodes'),
            'reportType' => $this->input->post('reportType')
        );

        $p_key = 'day_closing_report_'.md5(http_build_query($data));
        if( !$result = $this->cache->file->get($p_key) ) {            
            $result = $this->api_model->getDayClosingReportList($data);
            $this->cache->file->save($p_key, $result, 900);
        } 
        $results = json_decode($result);
        
        $pending = array();
        $completed = array();
        foreach ($results->data as $val) {
            if ($val->code) {
                $completed[] = $val;
            } else {
                $pending[] = $val;
            }
        }

        usort($completed, function($a, $b) {
            return (strtotime(trim($a->createdAt)) < strtotime(trim($b->createdAt))) ? -1 : 1;
        });

        $data['pending'] = $pending;
        $data['completed'] = $completed;
        
        $this->load->view('site/report/day-closing-report-details-list', $data);
    }

    function transit_based_branch_collection_report(){
        $this->is_logged_in();
        $data = array();

        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['zone'] = $zone->data;

        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branch'] = $branches->data;

        $this->load->view('site/report/transit-based-branch-collection-report', $data);
    }

    function transit_based_branch_collection_report_list(){
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQNAAK4161',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'filterType' => $this->input->post('filterType'),
            'filterCode' => $this->input->post('filterCode'),
            'transitStatus' => $this->input->post('transitStatus'),
            'requestType' => 'SUMMARY',
            'paymentStatusCode' => $this->input->post('paymentStatusCode'),
            'transitCode' => 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] =$result->data;
        $data['filter_type'] = 'SUMMARY';
        $data['user_name'] = $this->session->userdata('user_name');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/transit-based-branch-collection-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Transit-Based-Collaction-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/transit-based-branch-collection-report-list', $data);
        }
    }
    
    function transit_based_branch_collection_report_details_list(){
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQNAAK4161',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'filterCode' => $this->input->post('filterCode'),
            'transitStatus' => $this->input->post('transitStatus'),
            'paymentStatusCode' => $this->input->post('paymentStatusCode'),
            'transitCode' => $this->input->post('transitCode'),
            'filterType' => 'BRANCH',
            'requestType' => 'DETAILS',

        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['results'] = $result->data;
        $data['cargo_status'] = config_item('cargo_status');
        $data['filter_type'] = 'DETAILS';
        $this->load->view('site/report/transit-based-branch-collection-report-list', $data);
    }

    function transit_analysis_report() {
        $this->is_logged_in();
        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['zone'] = $zone->data;

        $all_zone_stations = array();
        foreach($zone->data as $key=>$zones) {
            foreach($zones->stations as $k=>$station) {
                $all_zone_stations[] = $station->code;
            }
        }

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);

        $organization = array();
        foreach ($branches->data as $key=>$branch) {
            if (in_array($branch->station->code, $all_zone_stations)) {
                $organization[] = $branch;
            }
        }

        usort($organization, function ($a, $b) {
            return strcasecmp($a->name,  $b->name);
        });
        $data['organization'] = $organization;
        
        $this->load->view('site/report/transit-analysis-report', $data);

    }

    function transit_analysis_report_list() {
        $this->is_logged_in();
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
    
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        
        $data =array(
            'queryCode' => 'RQNA4HQ61',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'zoneCode' => $this->input->post('zoneCode') ?: 'NA',
            'cargoCode' => $this->input->post('cargoCode') ?:'NA',
            'transitTypeCode' => $this->input->post('transitTypeCode') ?: 'NA',
            'transitAge' => $this->input->post('transitAge'),
            'filterType' => $this->input->post('filterType') ?: 'NA',
            'organizationCode'=>$this->input->post('organizationCode')?:'NA',
            'statusCode'=>'NA',
           
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
    
        $data['results'] = $result->data;
        $fromDate = date('Y-m-d', strtotime($fromDate));
        $toDate = date('Y-m-d', strtotime($toDate));
        $filterType = $this->input->post('filterType');
        $data['fromDate'] = $fromDate;
        $data['toDate'] = $toDate;
        $data['filterType'] = $filterType;
    
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/transit-analysis-report-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Transit-Movement-Analysis-Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/transit-analysis-report-list-new', $data);
        }
    
    }

    function transit_analysis_report_list_details(){
        $this->is_logged_in();

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQNA4HQ61',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'zoneCode' => $this->input->post('zoneCode') ?: 'NA',
            'cargoCode' => $this->input->post('cargoCode') ?: 'NA',
            'transitTypeCode' => $this->input->post('transitTypeCode') ?: 'NA',
            'transitAge' => $this->input->post('transitAge'),
            'filterType' => 'SUMMARYDETAILS',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'statusCode' => $this->input->post('statusCode') ?: 'NA',

        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        
        $routeWise =[];
        foreach($result->data as $val){
            $routeWise["$val->from_station_name - $val->to_station_name"]['lr_count'] +=count($val->cargo_code);
            $routeWise["$val->from_station_name - $val->to_station_name"]['route'] ="$val->from_station_name - $val->to_station_name";
            $routeWise["$val->from_station_name - $val->to_station_name"]['article_count'] +=$val->article_count;
        }

        $data['routeWise'] =$routeWise;
        $data['results'] = $result->data;
        $fromDate = date('Y-m-d', strtotime($fromDate));
        $toDate = date('Y-m-d', strtotime($toDate));
        $data['fromDate'] = $fromDate;
        $data['toDate'] = $toDate;
        $data['filterType'] = 'DETAILS';

        $this->load->view('site/report/transit-analysis-report-list-details', $data);
       

    }


    //Current and pending door delivery 
    function pending_current_delivery_report(){

        $this->is_logged_in();
        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;
        $this->load->view('site/report/pending-current-door-delivery-report', $data);
    }

    function pending_current_delivery_report_list(){
        
        $this->is_logged_in();
        // DETAILS
        $param = array(
            'queryCode' => 'RQN94JQ61',
            'date' => date('Y-m-d', strtotime($this->input->post('date'))),
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'filterType' => 'DETAILS',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($param);
        $result = json_decode($result);
        $data['details'] = $result->data;

        $vehicleWise = [];

        foreach($result->data as $val){
            if (isset($val->unloaded_vehicle_number)){
                $vehicleWise[$val->unloaded_vehicle_number]['vehicle_no'] = $val->unloaded_vehicle_number;
                $vehicleWise[$val->unloaded_vehicle_number]['vehicle_name'] = $val->unloaded_driver_name;
                $vehicleWise[$val->unloaded_vehicle_number]['vehicle_count'] +=count($val->unloaded_vehicle_number);
                $vehicleWise[$val->unloaded_vehicle_number]['loaded_date'] =$val->loaded_date;
                $vehicleWise[$val->unloaded_vehicle_number]['booked_at'] =$val->booked_at;
                $vehicleWise[$val->unloaded_vehicle_number]['from_station_name']=$val->from_station_name;//
                $vehicleWise[$val->unloaded_vehicle_number]['to_station_name']=$val->to_station_name;
                $vehicleWise[$val->unloaded_vehicle_number]['unloaded_date']=$val->unloaded_date;
                $vehicleWise[$val->unloaded_vehicle_number]['unloaded_user_name']=$val->unloaded_user_name;
                $vehicleWise[$val->unloaded_vehicle_number]['code'][] =$val;
            }
     
        }

        //SUMMARY
        $param = array(
            'queryCode' => 'RQN94JQ61',
            'date' => date('Y-m-d', strtotime($this->input->post('date'))),
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'filterType' => 'SUMMARY',
        );

        $data['vehicleWise']=$vehicleWise;
        $result = $this->api_model->getDynamicReportDataWithMap($param);
        $result = json_decode($result);
        $data['user_date'] = date('Y-m-d', strtotime($this->input->post('date')));

        $data['summary'] = $result->data;
        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $data['branch_name'] =$this->input->post('branch_name')?$this->input->post('branch_name'):"ALL";

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $filename = 'pending-current-door-delivery-report-list';
            $this->load->excel('site/report/pending-current-door-delivery-report-list-xls', $data, $filename);
        } elseif ($this->input->post('print') == 1) {
            $this->load->exclude_template();
            $this->load->view('site/report/pending-current-door-delivery-report-list-print', $data);
        } else {
            $this->load->view('site/report/pending-current-door-delivery-report-list', $data);
        }
    }

    function pending_current_delivery_report_sumry_print(){
        $this->is_logged_in();
        
        // CURRENT_PENDING_SUMMARY
        $param = array(
            'queryCode' => 'RQO3K991',
            'date' => date('Y-m-d', strtotime($this->input->post('date'))),
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            // 'filterType' => 'CURRENT_PENDING_SUMMARY',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($param);
        $result = json_decode($result);//branch_name
        $data['summary'] = $result->data;

        //delivery lr pending and current values 
        $delivery_pending_lr=0;
        $delivery_current_lr=0;
        $delivery_topay_lr = 0;
        $delivery_paid_lr = 0;
        $delivery_payment_rec=0;
        $delivery_onaccount_lr = 0;
        $delivery_bill_rec =0;
        $delivery_withOut_bill_rec=0;
        foreach($result->data as $val){ 

            if($val->attribute_type =="PENDING_DELIVERED"){
                $delivery_pending_lr +=$val->lr_count;
            }

            if($val->attribute_type == "CURRENT_DELIVERED") {
                $delivery_current_lr += $val->lr_count;
            }
            
            if($val->attribute_type=="DELIVERED_PAYMENT_TYPE" && $val->attribute_code =="TOP"){
                $delivery_topay_lr += $val->lr_count;
            }

            if($val->attribute_type=="DELIVERED_PAYMENT_TYPE" && $val->attribute_code =="INP"){
                $delivery_onaccount_lr += $val->lr_count;
            }

            if($val->attribute_type=="DELIVERED_PAYMENT_TYPE" && $val->attribute_code =="PAD"){
                $delivery_paid_lr += $val->lr_count;
            }

            if($val->attribute_type=="DELIVERED_PAYMENT_RECEIVED" && $val->attribute_code =="TOP"){
                $delivery_payment_rec += $val->lr_count;
            }

            if($val->attribute_code == "DWB") {
                $delivery_bill_rec += $val->lr_count;
            }

            if($val->attribute_code == "DWOB") {
                $delivery_withOut_bill_rec += $val->lr_count;
            }
        }

        $data['delivery_pending_lr']=$delivery_pending_lr;
        $data['delivery_current_lr'] = $delivery_current_lr;
        $data['delivery_onaccount_lr'] = $delivery_onaccount_lr;
        $data['delivery_topay_lr'] = $delivery_topay_lr;
        $data['delivery_paid_lr'] = $delivery_paid_lr;
        $data['delivery_payment_rec']=$delivery_payment_rec;
        $data['delivery_bill_rec'] = $delivery_bill_rec;
        $data['delivery_withOut_bill_rec']=$delivery_withOut_bill_rec;

        $data['branch_name'] =$this->input->post('branch_name')?$this->input->post('branch_name'):"ALL";

        $data['user_date'] = date('Y-m-d', strtotime($this->input->post('date')));
        $data['username'] = $this->session->userdata('user_name');

        $this->load->exclude_template();
        $this->load->view('site/report/pending-current-door-delivery-report-summary-print', $data);
    }

    function cargo_partition_report() {
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
    
        $this->load->view('site/report/cargo-partition-detailed-report', $data);
    }

    function cargo_partition_report_list() {
        $this->is_logged_in();

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQNCEF361',
            'fromDate' => $from_date,
            'toDate' => $to_date,
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'fromOrganizationCode' => $this->input->post('fromOrganizationCode'),
            'toOrganizationCode' => $this->input->post('toOrganizationCode'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $final = array(); 
        for($i=0; $i < count($result->data); $i++){
            $j=0;

            do{
                $j++;
            }while($result->data[$i]->source_cargo_code == $result->data[++$i]->source_cargo_code);
           
            $i=$i-1;
            array_push($final, $j); 

        }

        $data['counts'] = $final;
        $data['result'] = $result->data;
        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['cargo_payment_status_badge'] = config_item('cargo_payment_status_badge');
        if ($this->input->post('export')==1) {
            $filename = 'Cargo-Partition-Detailed-Report-' . $from_date . '-To-' . $to_date;
            $this->load->excel('site/report/cargo-partition-detailed-report-list-xls', $data, $filename);
        }else {
            $this->load->view('site/report/cargo-partition-detailed-report-list', $data);
        }
    }

    function gst_collection_report_v1(){
        $this->is_logged_in();
        $namespace = $this->session->userdata('namespace_id');

        if($namespace != 'seenutransports' && $namespace != "seenucargo"){
            http_response_code(404);
            die();
        }

        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['zone'] = $zone->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $all_zone_stations = array();
        foreach($zone->data as $key=>$zones) {
            foreach($zones->stations as $k=>$station) {
                $all_zone_stations[] = $station->code;
            }
        }
        
        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);

        $organization = array();
        foreach ($branches->data as $key=>$branch) {
            if (in_array($branch->station->code, $all_zone_stations)) {
                $organization[] = $branch;
            }
        }

        usort($organization, function ($a, $b) {
            return strcasecmp($a->name,  $b->name);
        });
        $data['organization'] = $organization;
        $this->load->view('site/report/gst-collection-report-seenutransport', $data);
    }

    function gst_collection_report_list(){

        $this->is_logged_in();

        // $namespace = $this->api_model->getNamespace(array(
        //     'authtoken' => _get_user_hash(),
        // ));
        $namespace = $this->session->userdata('namespace_id');
    
        if($namespace != 'seenutransports' && $namespace != "seenucargo"){
            http_response_code(404);
            die();
        }


        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQNCUG4862',
            'fromDate' => $from_date,
            'toDate' => $to_date,
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $results = json_decode($result);


        usort($results->data, function($a, $b) {
            return $a->gstin < $b->gstin ? -1 : 1;
        });

        $innerArray = $results->data;
        $total_Invoice =0.00;
        $no_of_recepient =0;
        $no_of_invoices =0;

        for($i=0; $i<count($innerArray); $i++){
            do {
                $no_of_invoices++;
                $total_Invoice += $innerArray[$i]->transaction_amount; 
            }while($innerArray[++$i]->gstin == $innerArray[$i-1]->gstin);
                --$i;
                $no_of_recepient++;
        }

        usort($results->data, function($a, $b) {
            return $a->organization_name < $b->organization_name ? -1 : 1;
        });

        $data['noOfRecep'] = $no_of_recepient;
        $data['noOfInvoice'] = $no_of_invoices;
        $data['totalAmount'] = $total_Invoice;
        $data['from_date'] = $from_date;
        $data['to_date'] = $to_date;
        $data['result']  = $results->data;
        

        if ($this->input->post('export') == 1) {
            $filename = 'SeenuTransport_gst_Collection_Report';
            $this->load->excel('site/report/gst-collection-report-seenutransport-list-xls', $data, $filename);
        } elseif ($this->input->post('print') == 1) { 
            $this->load->exclude_template();
            $data['organizationName'] = $this->input->post('organizationName');
            $this->load->view('site/cargo/ogpl-report-print-seenutransports', $data);
        } else {
            $this->load->view('site/report/gst-collection-report-seenutransport-list', $data);  
        }

    }

    public function fuel_coupon_report(){

        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function ($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }

        $data['branches'] = $branches->data;

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $vendors = $this->api_model->getContact(array(
            'entityTypeCode' => 'RAC'
        ));
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;
        
        $this->load->view('site/report/diesel-coupon-report', $data);

    }

    public function diesel_coupon_report_list(){
        $this->is_logged_in();
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQO3RDV4',
            'fromDate' => $from_date,
            'toDate' => $to_date,
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'vehicleCode' => $this->input->post('vehicleCode') ?: 'NA',
            'vendorCode' => $this->input->post('vendorCode') ?: 'NA',
            'filterType' => $this->input->post('filterType'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $results = json_decode($result);
        $data['result'] =$results->data;

        $data['from_date'] =$from_date;
        $data['to_date'] = $to_date;
        $vendorWise =[];
        foreach ($results->data  as $val){
            $vendorWise[$val->fuel_vendor_code]['amount'] +=$val->total_amount;
            $vendorWise[$val->fuel_vendor_code]['bunk_name'] =$val->fuel_vendor_name;
            $vendorWise[$val->fuel_vendor_code]['bunk_count'] +=count($val->fuel_vendor_code);
        }
  
        $data['vendorWise'] = $vendorWise;

        if($this->input->post('print') ==1){
            $this->load->exclude_template();
            $this->load->view('site/report/diesel-coupon-report-list-print', $data);
        }elseif($this->input->post('export') ==1){
            $this->load->exclude_template();
            $filename = 'deisel-coupon-report-list';
            $this->load->excel('site/report/diesel-coupon-report-list-xls', $data, $filename);
        }else{
            $this->load->view('site/report/diesel-coupon-report-list', $data);
        }
        
    }
  
    public function hire_challan_summary(){
        $this->is_logged_in();
        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $this->load->view('site/report/hire-challan-summary', $data);
    }

    public function hire_challan_summary_report(){
        $this->is_logged_in();
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        $data = array(
            'queryCode' => 'RQM0826H931',
            'toDate' =>  $to_date,
            'fromDate' =>  $from_date,
            'vehicleCode' => $this->input->post('vehicleCode') ?: 'NA',
            'transitTypeCode' => $this->input->post('transitTypeCode') ?: 'TRNT',
            'ownerShipType' => $this->input->post('ownerShipType') ?: 'NA',
            'transporterCode' => $this->input->post('transporterCode') ?: 'NA'
        );
        $p_key = _get_namespace_id().'_report_revenue_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
    
        $result = json_decode($result);
        $data['result'] = $result->data;

        if ($this->input->post('export') == 1) {
            $filename ='hire_challan_summary_Report';
            $this->load->excel('site/report/hire-challan-summary-list-xls', $data, $filename);
        }else {
            $this->load->view('site/report/hire-challan-summary-list', $data);
        }
    }

    public function local_hire_challan_summary(){
        $this->is_logged_in();
        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $this->load->view('site/report/local-hire-challan-summary', $data);
    }

    public function local_hire_challan_summary_report(){
        $this->is_logged_in();
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        $data = array(
            'queryCode' => 'RQM0826H931',
            'toDate' =>  $to_date,
            'fromDate' =>  $from_date,
            'vehicleCode' => $this->input->post('vehicleCode') ?: 'NA',
            'transitTypeCode' => $this->input->post('transitTypeCode') ?: 'INTRNT',
            'ownerShipType' => $this->input->post('ownerShipType') ?: 'NA',
            'transporterCode' => $this->input->post('transporterCode') ?: 'NA'
        );
        $p_key = _get_namespace_id().'_report_revenue_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
    
        $result = json_decode($result);
        $data['result'] = $result->data;

        if ($this->input->post('export') == 1) {
            $filename ='local_hire_challan_summary_Report';
            $this->load->excel('site/report/local-hire-challan-summary-list-xls', $data, $filename);
        }else {
            $this->load->view('site/report/local-hire-challan-summary-list', $data);
        }
    }

    public function arrival_and_departure_report() {
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }

        $data['branches'] = $branches->data;

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $this->load->view('site/report/arrival-and-departure-report', $data);
    }
    
    public function arrival_and_departure_report_list() {
        $this->is_logged_in();

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQK37I5338',
            'fromDate' => $from_date,
            'toDate' => $to_date,
            'organizationCode' => $this->input->post('fromOrganizationCode') ?: 'NA',
            'vehicleCode' => $this->input->post('vehicleCode') ?: 'NA',
            'transitType' =>'TRNT',
            'fromStationCode' => $this->input->post('fromStationCode') ?: 'NA',
            'toStationCode' => $this->input->post('toStationCode') ?: 'NA',
            'filterType' => $this->input->post('filterType'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $results = json_decode($result);

        $vehicleWise = array();
        foreach($results->data as $val) {
            $vehicleWise[$val->registration_numer]['registration_numer'] = $val->registration_numer;
            $vehicleWise[$val->registration_numer]['luggage_count'] += count($val->alias_code);
            $vehicleWise[$val->registration_numer]['load_count'] +=$val->load_count;
            $vehicleWise[$val->registration_numer]['total_luggage_amt'] +=$val->transit_total_amount;
            $vehicleWise[$val->registration_numer]['vehicle_ownership_type'] =$val->vehicle_ownership_type;
            $vehicleWise[$val->registration_numer]['from_station_name'] =$val->from_station_name;
            $vehicleWise[$val->registration_numer]['from_station_code'] = $val->from_station_code;

            $vehicleWise[$val->registration_numer]['to_station_name'] = $val->to_station_name;
            $vehicleWise[$val->registration_numer]['from_via_organization_short_code'] .=$val->from_via_organization_short_code != null ? $val->from_via_organization_short_code . ", " : "";
            $vehicleWise[$val->registration_numer]['to_via_organization_short_code'] .=$val->to_via_organization_short_code != null ? $val->to_via_organization_short_code . ", " : "";
        }

        $stationWise = [];
        foreach ($results->data as $val) {
            $from_station_code = $val->from_station_code;

            // Initialize station if not exists
            if (!isset($stationWise[$from_station_code])) {
                $stationWise[$from_station_code] = [
                    'registration_numer' => [],
                    'vehicle_count' => 0,
                    'luggage_count' => 0,
                    'load_count' => 0,
                    'total_luggage_amt' => 0,
                    'vehicle_ownership_type' => $val->vehicle_ownership_type,
                    'from_station_name' => $val->from_station_name,
                    'to_station_name' => $val->to_station_name,
                    'from_via_organization_short_code' => $val->from_via_organization_short_code,
                    'to_via_organization_short_code' => $val->to_via_organization_short_code,
                ];
            }

            // Count unique registration numbers
            $stationWise[$from_station_code]['registration_numer'][] = $val->registration_numer;
            $stationWise[$from_station_code]['registration_numer'] = array_unique($stationWise[$from_station_code]['registration_numer']);
            $stationWise[$from_station_code]['vehicle_count'] = count($stationWise[$from_station_code]['registration_numer']);

            // Increment other counts
            $stationWise[$val->from_station_code]['vehicle_ownership_type'] = $val->vehicle_ownership_type;
            $stationWise[$val->from_station_code]['from_station_name'] = $val->from_station_name;
            $stationWise[$val->from_station_code]['from_station_code'] = $val->from_station_code;

            $stationWise[$val->from_station_code]['to_station_name'] = $val->to_station_name;
            $stationWise[$val->from_station_code]['from_via_organization_short_code'] .= $val->from_via_organization_short_code != null ? $val->from_via_organization_short_code . ", " : "";
            $stationWise[$val->from_station_code]['to_via_organization_short_code'] .= $val->to_via_organization_short_code != null ? $val->to_via_organization_short_code . ", " : "";

            $stationWise[$from_station_code]['luggage_count'] += count($val->alias_code);
            $stationWise[$from_station_code]['load_count'] += $val->load_count;
            $stationWise[$from_station_code]['total_luggage_amt'] += $val->transit_total_amount;
            $stationWise[$from_station_code]['code'][] =$val;
            $stationWise[$from_station_code]['from_station_code'] = $val->from_station_code;

        }

        $twenty_below_vehicle_count = 0;
        $twenty_above_vehicle_count=0;
        $twenty_five_above_vehicle_count = 0;
        $thirty_above_vehicle_count = 0;

        foreach ($vehicleWise as $row) {
            if ($row['total_luggage_amt'] < 20000) {
                $twenty_below_vehicle_count += count($row['registration_numer']);
            }

            if ($row['total_luggage_amt'] >= 20000 && $row['total_luggage_amt'] <= 25000) {
                $twenty_above_vehicle_count += count($row['registration_numer']);
            }

            if ($row['total_luggage_amt'] > 25000 && $row['total_luggage_amt'] <= 30000) {
                $twenty_five_above_vehicle_count += count($row['registration_numer']);
            }

            if ($row['total_luggage_amt'] > 30000) {
                $thirty_above_vehicle_count += count($row['registration_numer']);
            }
        }

        $data['twenty_below_vehicle_count'] = $twenty_below_vehicle_count;
        $data['twenty_above_vehicle_count'] = $twenty_above_vehicle_count;
        $data['twenty_five_above_vehicle_count'] = $twenty_five_above_vehicle_count;
        $data['thirty_above_vehicle_count'] = $thirty_above_vehicle_count;

        $data['vehicleWise'] = $vehicleWise;
        $data['stationWise'] =$stationWise;
        $data['from_date'] = $from_date;
        $data['to_date'] = $to_date;

        $data['result'] = $results->data;
        if ($this->input->post('print') ==1) {
            $this->load->exclude_template();
            $this->load->view('site/report/arrival-and-departure-report-list-print', $data);
        } elseif ($this->input->post('export') ==1){
            $filename = 'arrival-and-departure-report-' . $from_date . '-To-' . $to_date;
            $this->load->excel('site/report/arrival-and-departure-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/report/arrival-and-departure-report-list', $data);
        }
    }

    public function lr_transfer_report(){
        $this->is_logged_in();

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }

        $data['branches'] = $branches->data;

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;
        $this->load->view('site/report/lr-transfer-report', $data);
    }

    public function lr_transfer_report_list(){
        $this->is_logged_in();
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        $data = array(
            'queryCode' => 'RQO48AX1',
            'toDate' =>  $to_date,
            'fromDate' =>  $from_date,
            'vehicleCode' => $this->input->post('vehicleCode') ?: 'NA',
            'cargoCode' => $this->input->post('cargoCode') ?: 'NA',
            'transitCode' => $this->input->post('transitCode') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA', //
            'filterType' => $this->input->post('filterType') ?: 'NA',
            'requestType' => 'SUMMARY'
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $results = json_decode($result);
        $data['result'] = $results->data;

        $paymentWise = [];
        foreach($results->data as $val){
            $paymentWise[$val->payment_type_code]['code']=$val->payment_type_code;
            $paymentWise[$val->payment_type_code]['cargo_Count']+=count($val->cargo_code);
            $paymentWise[$val->payment_type_code]['amount']+=$val->total_amount;
        }
    
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['paymentWise']=$paymentWise;

        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
        $usr_pro = json_decode($usr_pro);


        $organizationCode= $usr_pro->data->organization->code;
        $organizationDetails = $this->api_model->getOrganizationDetails(array('organizationcode' =>$organizationCode));
        $organizationDetails = json_decode($organizationDetails);
        $data['user_profile'] = $usr_pro->data;
        $data['organizationDetails']  = $organizationDetails->data;

        if ($this->input->post('export') ==1){
            $filename = 'Lr-Transfer-Report-' . $from_date . '-To-' . $to_date;
            $this->load->excel('site/report/lr-transfer-report-list-xls', $data, $filename);
        }else{
            $this->load->view('site/report/lr-transfer-report-list', $data);
        }
    }

    public function lr_transfer_report_list_print(){
        $this->is_logged_in();
        list($fromDate, $toDate) = explode(' | ', $this->input->get('Date'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        $data = array(
            'queryCode' => 'RQO48AX1',
            'toDate' =>  $to_date,
            'fromDate' =>  $from_date,
            'vehicleCode' => $this->input->get('vehicle') ?: 'NA',
            'cargoCode' => $this->input->get('cargoCode') ?: 'NA',
            'transitCode' => $this->input->get('transitCode') ?: 'NA',
            'organizationCode' => $this->input->get('orgCode') ?: 'NA', //
            'filterType' => $this->input->get('filterType') ?: 'NA',
            'requestType' => 'DETAILS'
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $results = json_decode($result);
        $data['result'] = $results->data;

        $paymentWise = [];
        foreach($results->data as $val){
            $paymentWise[$val->payment_type_code]['code']=$val->payment_type_code;
            $paymentWise[$val->payment_type_code]['cargo_Count']+=count($val->cargo_code);
            $paymentWise[$val->payment_type_code]['amount']+=$val->total_amount;
        }
    
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['paymentWise']=$paymentWise;

        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
        $usr_pro = json_decode($usr_pro);


        $organizationCode= $usr_pro->data->organization->code;
        $organizationDetails = $this->api_model->getOrganizationDetails(array('organizationcode' =>$organizationCode));
        $organizationDetails = json_decode($organizationDetails);
        $data['user_profile'] = $usr_pro->data;
        $data['organizationDetails']  = $organizationDetails->data;

        $ftext .= "<b>Printed By: " . $this->session->userdata('user_name') . "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Printed At: " . date('d-m-Y')."</b>";
        require_once APPPATH . 'libraries/seenutransport-lib-tcpdf.php';
        $pdf = new seenuPdf();
        $pdf->SetTitle('LR Transfer Report');
        $pdf->SetFont('helvetica', '', 8);
        $pdf->setCustomFooterText($ftext); 
        $pdf->AddPage();
        ob_clean();
        $this->load->exclude_template();
        $content = $this->load->view('site/report/lr-transfer-report-list-print', $data, true);
        $pdf->writeHTML($content);
        $pdf->Output('LR Transfer Report.pdf', 'i');
    }
    public function sms_utilization_report() {
        $this->is_logged_in();
        $data['entity'] = config_item('sms_notification_type');
        $this->load->view('site/report/sms-utilization-report', $data);
    }
    public function sms_utilization_report_list() {
        $this->is_logged_in();
        $mobile = $this->input->post('mobile');
        $pnr = $this->input->post('pnr');
        $type = $this->input->post('notification_type');

        if($type == '') {
           $type = 'NA';
        }
        if($mobile == '') {
           $mobile = 'NA';
        }
        if($pnr == '') {
           $pnr = 'NA';
        }

        $data = array(
            'queryCode' => 'RQI1QIC26',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'notificationType' => $type,
            'participantAddress' => $mobile,
            'refferenceCode' => $pnr,
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data = array();

        if ($result->status == 1) {
            if (is_array($result->data)) {
               $data['result'] = $result->data;
               $data['notification_type'] = config_item('sms_notification_type');
            }
        }

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/sms-utilization-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=SMS_Utilization_report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            $this->load->view('site/report/sms-utilization-report-list', $data);
        }
    }


    function table_Chart()
    {
        $this->is_logged_in();
        $data = array();
        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        $data['namespaceCode'] = $this->session->userdata('namespace_id');
        if (has_action_rights('CGO-INV-SAME-BRANCH')) {
            $vendors = $this->api_model->cargoCustomerVendorByBranch(array('organizationCode' => $this->session->userdata('org_code')));
            $vendors = json_decode($vendors);
            $data['vendors'] = $vendors->data;
        } else {
            $vendors = $this->api_model->cargoCustomerVendor();
            $vendors = json_decode($vendors);
            $data['vendors'] = $vendors->data;
        }

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
        $this->load->view('site/report/table-chart', $data);
    }


    function table_chart_list()
    {
        $this->is_logged_in();

        $user_code = $this->input->post('userCode');
        if (empty($user_code)) {
            $user_code = 'NA';
        }
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        $dataum = array(
            'queryCode' => 'RQO3PJJ3',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'organizationCode' => $this->input->post('fromOrganizationCode'),
            'vendorCode' => $this->input->post('vendorCode')
        );
        // (($this->input->post('vendorUser') != 'NA') ? $this->input->post('vendorUser') : $this->input->post('vendorCode'))
        $results = $this->api_model->getDynamicReportDataWithMap($dataum);
        $results = json_decode($results);
        $data = array();
        $data['results'] = $results->data;
        $pendingList = array();

        $paymentType = array(
            'PAD' => 'Paid',
            'TOP' => 'ToPay',
            'INP' => 'On Account',
            'OATP' => 'On Account To Pay',
            'TPPAD' => 'ToPay then Paid',
            'WTOP' => 'Way To Pay',
            'FS' => 'Free Service'
        );

        foreach ($results->data as $row) {
            if (isset($paymentType[$row->payment_type_code])) {
                $row->payment_type_name = $paymentType[$row->payment_type_code];
            } else {
                $row->payment_type_name = 'Unknown'; // Handle unknown payment type codes
            }
            $pendingList[$row->organization_name][$row->vendor_code][substr($row->transaction_start_date,5,2)][] = $row;
        }
        $data['namespaceCode'] = $this->session->userdata('namespace_id');
        $data['organizationCode'] =  $this->input->post('fromOrganizationCode');
        $data['organizationName'] = $this->input->post('organizationName');
        $data['pendingList'] = $pendingList;
        $data['fromDate']  = $fromDate;
        $data['toDate'] = $toDate;
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/report/table-chart-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=STable-chart-List.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        }else if($this->input->post('print') == 1){
            $this->load->exclude_template();
            $this->load->view('site/report/table-chart-list-print', $data);
        }
         else {
            $this->load->view('site/report/table-chart-list', $data);
    	}
    }
}



?>
