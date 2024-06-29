<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class progress extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
        $this->_user_hash = _get_user_hash();
    }

    public function index() {
        $this->is_logged_in();
        redirect('user/dashboard');
    }
    
    function live_booking() {
        $this->is_logged_in(); 
        
        _include_js('assets/js/howler.js');
        _include_js('assets/js/snap.svg-min.js');
        _include_js('assets/lib/justgage/raphael-2.1.4.min.js');
        _include_js('assets/js/jquery.polartimer.js', 'init_progress');
        
        _include_js('assets/lib/justgage/justgage.js');
        $data = array();
        
        $this->load->view('site/ticket/progress', $data);
    }
    
    function progress_list() {
        $this->is_logged_in();
        $data = array();
        $tickets = array();
        
        $paymentStatus = array('PAD' => 0, 'TOP' => 0, 'INP' => 0, 'OATP' => 0, 'WTOP' => 0);
        $cargoStatus = array('CB' => 0, 'FAIL' => 0, 'CA' => 0);
        
        $result = $this->api_model->getCurrentlyBookingList();
        $result = json_decode($result);

        foreach($result->data as $ticket) {

            $time_diff = ceil( (time() - strtotime($ticket->bookedAt)) / 60 );
            $timeDiffMinute = $time_diff;
            if($time_diff<=1) {
                $time_diff = '1 min ago';
            } else {
                $time_diff .= ' mins ago';
            }

            $tickets[] = array(
                'code' => $ticket->code,
                'fromBranch' => $ticket->fromOrganization->name,
                'toBranch' => $ticket->toOrganization->name,
                'pickupType' => $ticket->pickupType->name,
                'fromStation' => $ticket->fromStation->name,
                'toStation' => $ticket->toStation->name,
                'deliveryType' => $ticket->deliveryType->name,
                'bookedAt' => $time_diff,
                'timeDiffMinute' => $timeDiffMinute,
                'itemsCount' => $ticket->additionalAttribute->itemCount,
                'bookedUser' => $ticket->bookedUser->name,
                'fromCustomer' => $ticket->fromCustomer->name,
                'fromCustomerMobile' => $ticket->fromCustomer->mobileNumber,
                'toCustomer' => $ticket->toCustomer->name,
                'toCustomerMobile' => $ticket->toCustomer->mobileNumber,
                'fromStation' => $ticket->fromStation->name,
                'toStation' => $ticket->toStation->name,
                'paymentStatus' => $ticket->paymentType->code,
                'cargoStatus' => $ticket->cargoStatus->code,
                'totalAmount' =>  $ticket->totalAmount,
                'unique' => strtotime($ticket->bookedAt),
            );

            if (!$ticket->code) {
                $cargoStatus["FAIL"]++;
            }

            $paymentStatus[$ticket->paymentType->code]++;
            $cargoStatus[$ticket->cargoStatus->code]++;
        }
        ksort($tickets);
        
        $data['status'] = $result->status;
        $data['tickets'] = $tickets;
        $data['user_count'] = count($result->data);
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['cargo_payment_status_badge'] = config_item('cargo_payment_status_badge');
        $data['paymentStatusCount'] = $paymentStatus;
        $data['cargoStatusCount'] = $cargoStatus;
        
        echo json_encode($data);
    }
    
}
