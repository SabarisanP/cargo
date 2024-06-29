<?php
class Device extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
    }

    function index() {
        $this->is_logged_in();
        _include_js('assets/js/pages/device.js');

        $devices = $this->api_model->getDeviceList(array(
            'activeFlagFilter' => -1
        ));
        $devices = json_decode($devices);
        $data['devices'] = $devices->data;
        
        $data['groupusers'] = get_active_group_and_users();
        
        $this->load->view('site/device/device', $data);
    }
    
    function update(){
        $this->is_logged_in();
        $data = array(
            "activeFlag" => 1,
            "name" => $this->input->post('name'),
            "remarks" => $this->input->post('remarks'),
            "token" => $this->input->post('token'),
            'code' => $this->input->post('code'),
        );
        echo $this->api_model->addDevice($data);
    }

    function generate_device_otp(){
        $this->is_logged_in();
        $data = array(
            "deviceCode" => $this->input->post('deviceCode')
        );
        echo $this->api_model->generateDeviceOtp($data);
    }

    function delete(){
        $this->is_logged_in();
        $data = array(
            "activeFlag" => 2,
            'code' => $this->input->post('code'),
            "name" => $this->input->post('name'),
            "remaks" => $this->input->post('remarks'),
        );
        echo $this->api_model->addDevice($data);
    }
    function disable(){
        $this->is_logged_in();
        $data = array(
            "activeFlag" => $this->input->post('activeFlag'),
            'code' => $this->input->post('code'),
            "name" => $this->input->post('name'),
            "remaks" => $this->input->post('remarks'),
        );
        echo $this->api_model->addDevice($data);
    }
    
    function get_auth() {
        $this->is_logged_in();
        
        $data = array(
            'deviceCode' => $this->input->post('code')
        );
        $devices = $this->api_model->getDeviceAuthList($data);        
        $devices = json_decode($devices);
        $data['devices'] = $devices->data;

        $this->load->view('site/device/auth-list', $data);
    }
    
    function save_auth(){
        $this->is_logged_in();
        $data = array(
            "activeFlag" => 1,
            'refferenceType' => $this->input->post('part_mode'),
            'namespaceDevice' => array("code" => $this->input->post('device_code')),
        );
        if($this->input->post('part_mode')=="UR") {
            $data['user'] = array("code" => $this->input->post('part_user'));
        } else {
            $data['group'] = array("code" => $this->input->post('part_group'));
        }
        echo $this->api_model->addDeviceAuth($data);
    }
    function delete_auth(){
        $this->is_logged_in();
        $data = array(
            "activeFlag" => 2,
            'code' => $this->input->post('code')
        );
        echo $this->api_model->addDevice($data);
    }
}
