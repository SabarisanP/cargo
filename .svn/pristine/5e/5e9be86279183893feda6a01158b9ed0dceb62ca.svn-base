<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Auth extends MY_Controller {

    function __construct() {
        parent::__construct();
    }
    
    public function reset_password() {

        $this->load->view('site/auth/reset-password');
    }

    public function update_user_password() {
        $data = array(
            'oldpassword' => $this->input->post('oldpassword'),
            'newpassword' => $this->input->post('newpassword')
        );

        $result = $this->api_model->updatePassword($data);
        $result = json_decode($result);
        
        if ($result->status == 1) {
            $data = set_user_session_data('');
            $this->session->set_userdata($data);
            echo json_encode(array('status' => 1));
        } else {
            echo json_encode($result);
        }
    }

    public function otp_verification() {
        
        $otp = $this->api_model->generateOtp();
        $data['otp'] = json_decode($otp);

        $this->load->view('site/auth/otp-verification', $data);
    }

    public function verify_otp_number() {

        $passwordExpired = $this->session->userdata('passwordExpired');

        $result = $this->api_model->verifyOTPNumber(array(
            'otpNumber' => $this->input->post('otpNumber')
        ));

        $verify = json_decode($result);
        
        if ($verify->status == 1) {

            if ($passwordExpired) {
                echo json_encode(array('status' => 9));
                return;
            }

            $data = set_user_session_data('');
            $this->session->set_userdata($data);
        }

        echo $result;
    }
}

?>
