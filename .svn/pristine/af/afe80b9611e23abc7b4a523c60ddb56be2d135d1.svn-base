<?php
if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Push_notification extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    function index() {
        $this->is_logged_in();
        $this->load->view('site/push_notification/push_notification');
    }
    
    function send() {
        $this->is_logged_in();
        echo $this->api_model->sendPushNotification(array(
            'title' => $this->input->post('title'),
            'content' => $this->input->post('content'),
            'mobileNumber' => $this->input->post('mobileNumber'),
        ));
    }

}