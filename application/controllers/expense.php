<?php

if (!defined('BASEPATH'))    exit('No direct script access allowed');

class Expense extends MY_Controller {
    function __construct() {
        parent::__construct();
    }
	
    public function index() {
            $this->is_logged_in();
            redirect('user/dashboard');
    }

//	public function book_tickets() {
//		$this->is_logged_in();
//		$this->load->view('site/trips/book_tickets');
//	}
    public function head_type(){
            $this->is_logged_in();
            _include_js('assets/js/pages/trips.js','_init_Trip_Page');
            $triphead = $this->api_model->getCashbookHead(array(
                'activeFlagFilter' => -1
            ));
            
            $triphead = json_decode($triphead);
            $data = array(
                    'data'=> $triphead->data
            );
            $data['transactionMode'] = config_item('transaction_mode');
            $data['manage_expense_type'] = config_item('manage_expense_type');
            $data['mandate_manage_expense_fields'] = config_item('mandate_manage_expense_fields');
            $this->load->view('site/trips/trip-head',$data);
    }
    public function update_trips_head(){
            $this->is_logged_in();
            $description = $this->input->post('description');
            $code = $this->input->post('code');
            $name = $this->input->post('name'); //
            $creditDebitFlag = $this->input->post('creditDebitFlag');
            $additionalAttributes = $this->input->post('additionalAttributes');
            $data = array(
                        'activeFlag'=>'1',
                        'transactionMode' => $this->input->post('transactionMode'),
                        'transactionType'=>$creditDebitFlag,
                        'code'=>$code,
                        'name'=>$name ?: '',
                        'tag' => $this->input->post('tag') ?: [],
                        'additionalAttributes'=>implode(",", $additionalAttributes) ?: ''
            );
            echo $this->api_model->updateCashbookHead($data);
    }
    public function update_staus_trip_head(){
            $this->is_logged_in();
            $code = $this->input->post('code');
            $activeFlag = $this->input->post('activeFlag');
            $additionalAttributes = $this->input->post('additionalAttributes');
            $data = array(
                'transactionMode' => $this->input->post('transactionMode'),
                        'activeFlag'=>$activeFlag,
                        'transactionType'=>'Cr',            
                        'code'=>$code,   
                        'name'=> '',
                        'tag' => $this->input->post('tag') ?: [],
                        'additionalAttributes'=>implode(",", $additionalAttributes) ?: ''      
            );
            
            echo $this->api_model->updateCashbookHead($data);
    }
    
    public function get_trip_list(){
        $this->is_logged_in();
        $date = $this->input->post('travel_date');
        $date = date('Y-m-d', strtotime($date));        
        $trips = _get_trips_by_date($date);
        $ftrips = array();
        foreach($trips as $cname => $trip) {
            foreach($trip as $t) {            
                $ftrips[$cname][] = array(
                    'code' => $t->tripCode,
                    'scheduleCode' => $t->schedule->code,
                    'name' => $t->schedule->name,
                    'serviceNumber' => $t->schedule->serviceNumber,
                    'tripTime' => date('h:i A', $t->fromStationTimestamp)
                );
            }
        }
        if(count($ftrips) > 0 ) {
            $data['status'] = 1;
            $data['data'] = $ftrips;
        } else {
            $data['status'] = 0;
        }
        echo json_encode($data);
    }
    

    
    function vendor() {
        $this->is_logged_in();
        $vendors = $this->api_model->getCashbookVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $this->load->view('site/config/vendor', $data);
    }

    function update_vendor() {
        $this->is_logged_in();

        $code = $this->input->post('code');

        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'mobileNumber' => $this->input->post('mobileNumber'),
            'email' => $this->input->post('email'),
            'address' => $this->input->post('address'),
        );
        if (!empty($code)) {
            $data['code'] = $code;
        }
        echo $this->api_model->updateCashbookVendor($data);
    }
}

?>