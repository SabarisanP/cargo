<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class phonebooking extends MY_Controller {
    function __construct() {
        parent::__construct();
	$this->is_logged_in();
        $this->_user_hash = _get_user_hash();
    }
	
    public function index() { 
        $this->is_logged_in();		
        redirect("phonebooking/confirm");
    }

    public function confirm(){
        $this->is_logged_in();        
        _include_js('assets/js/pages/phonebooking.js', 'init_confirm_phonebooking');
        $this->load->view('site/phonebooking/confirm');		
    }
    public function get_phone_booking_list(){		
        $this->is_logged_in();
        $data = array(
            'date' => $this->input->post('date')
        );
        $tickets = array();
        $pb_list = $this->api_model->getPhoneBooking($data);
        $result = json_decode($pb_list);       
        if($result->status==1) {            
            $ticket_count = count($result->data);
            for($i=0; $i<$ticket_count; $i++) {
                $fare = 0;
                $seats = array();
                foreach($result->data[$i]->ticketDetails as $ticket_details) {
                    $seats[] =  $ticket_details->seatName;
                    $fare +=  $ticket_details->seatFare;
                }                
                $result->data[$i]->passengerName = $result->data[$i]->ticketDetails[0]->passengerName;
                $result->data[$i]->seatNames = implode(',',$seats);
                $result->data[$i]->seatFares = number_format($fare);
                
                $tickets['trip'][$result->data[$i]->tripCode][] = $result->data[$i];    // grouping by tripcode
            }
        }
        $data['pb_list'] = $tickets;        
        $this->load->view('site/phonebooking/phone-booking-list', $data);
    }
    
    function get_ticket_details(){
        $this->is_logged_in();   
        
        $ticketlist = $this->api_model->ticketDetails(array('ticketCode' => $this->input->post('ticketpnrcode')));
        $ticketlist = json_decode($ticketlist);
        if ($ticketlist->status == 1) {
            $data['reports'] = $ticketlist->data;
            $time = new DateTime($ticketlist->data->travelDate);
            $data['times'] = $time->format('H:i A');
            $data['code'] = $this->input->post('ticketpnrcode');       
            $data['phone'] = 1;            
        }        
        $this->load->view('site/phonebooking/phone-book-ticket-details', $data);
    }
}
?>