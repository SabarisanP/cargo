<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class transit extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
        $this->_user_hash = _get_user_hash();
    }

    public function index() {
        $this->is_logged_in();
        redirect('user/dashboard');
    }

    public function ogpl_odometer_comman(){
        $this->is_logged_in();
        _include_js('assets/js/common.js');
        $data = array();
        $data['login_user'] = $this->session->userdata('user_id');
        $data['login_branch'] = $this->session->userdata('org_code');
        $data['loadedVehicle'] =$this->input->post('loadedVehicle');
        $data['transitCode'] =$this->input->post('transitCode');
        $transitCode = $this->input->get('transitCode');
    
        $odoDetails = $this->api_model->getTransitOdometer(array(
            'transitCode' => $transitCode
        ));
        $odoDetails = json_decode($odoDetails);
        foreach ($odoDetails->data as $row) {
            if ($row->organization->code == $data['login_branch']) {
                $data['odoDetails'] = $row;
                break;
            }
        }

        $vehicle = $this->api_model->get_vehicle_details($this->input->post('loadedVehicle'));
        $vehicle = json_decode($vehicle);
        $data['vehicle']=$vehicle->data;
        $this->load->view('site/odometer-comman', $data);
    }
    
}
