<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class User extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index() {
        _to_dashboard();
    }

    public function login() {
        if ($this->session->userdata('user_id') != '') {
            $this->is_logged_in();
            $this->load->view('site/user/empty-d', array('test' => 1));
            return;
        }
        $data['ns'] = $this->input->get('ns');
        if($data['ns'] == '') {
            $data['ns'] = $this->input->cookie('l_domain');
            $data['email'] = $this->input->cookie('l_email');
            $data['remember'] = $this->input->cookie('l_remember');
        }
        
        $this->load->view('site/user/index', $data);
    }
    
    public function auto_login() {
        //        if($this->session->userdata('namespace_id')!="") { //  already session exist
        //           redirect('/'); 
        //        }
        
        $this->load->library('user_agent');
        $token = ($this->input->get('token')) ? $this->input->get('token') : $this->session->userdata('raw_token');
        $nscode = $this->input->get('ns');
        $fromadmin = $this->input->get('a');

        if( trim($token)=="") {
            echo 'Invalid attempt..!';
            return;
        }

        if ($this->input->get('product') == 'cargo') {

            $auth_verify = $this->api_model->integrationAuthVerify(array(
                'authtoken' => $token,
                'accountCode' => $this->input->get('ns'),
                'typeCode' => 'BITS'
            ));

            $auth_verify = json_decode($auth_verify);
            if ($auth_verify->status != 1) { // invalid attempt
                echo 'Invalid attempt..!';
                return;
            }
        }

        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $token));
        $profile = json_decode($usr_pro);
        if($profile->status!=1) { // invalid attempt
            echo 'Invalid attempt..!';
            return;
        }
            
        if($profile->status==1) {   //  valid token               
            $this->load->library('user_agent');
            $referrer = $this->agent->referrer();

            // reset password and otp login flow start

            $this->session->set_userdata('temp_token', $token);
            $this->session->set_userdata('referrer', $referrer);

            $otpVerifyFlag = $profile->data->namespace->namespaceProfile->otpVerifyGroupEnabled;
            $passwordExpireFlag = $profile->data->namespace->namespaceProfile->expirePasswordGroupEnabled;
            
            $passwordExpired = FALSE;

            if ($passwordExpireFlag) {
                $passwordExpired = is_password_expired($profile->data->passwordUpdateAt);
            }

            $this->session->set_userdata('passwordExpired', $passwordExpired);

            if ($otpVerifyFlag) {
                $url = 'auth/otp-verification';
                redirect($url);
            }

            if ($passwordExpired) {
                $this->load->view('site/auth/reset-password');
                return;
            }

            // reset password and otp login flow end

            $data = set_user_session_data($profile);
            $this->session->set_userdata($data);
            
            if(!empty($product)) {
                $data['product'] = $product;
                
                if($fromadmin==1)   //  clear referer if auto login from admin.
                    $data['referrer'] = '';
            } else {
                $data['product'] = 'cargo';
            }
                                                        
            $this->session->set_userdata($data);
            redirect('/');
        } else { // invalid attempt
            echo 'Invalid attempt..!';
        }
    }

    public function verify_login() {
        $email = $this->input->post('l_email');
        $pwd = $this->input->post('l_password');
        $domain = $this->input->post('l_domain');
        $remember = $this->input->post('l_remember');
        $status = 0;

        $json = $this->api_model->getAuthToken(array('username' => $email, 'password' => $pwd, 'namespaceCode' => $domain, 'devicemedium' => 'WEB'));
        $json = json_decode($json);

        if ($json->status == 1) {
           //user profile
            $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $json->data->authToken));
            $profile = json_decode($usr_pro);

            // Direct EzeeCargo login disabled for this user.
            if(!$profile->data->namespace->namespaceProfile->allowDirectLogin) {
                echo json_encode(array('status' => 1001, 'redirectUrl' => ""));
                return;
            }

            // reset password and otp login flow start

            $this->session->set_userdata('temp_token', $json->data->authToken);

            $otpVerifyFlag = $profile->data->namespace->namespaceProfile->otpVerifyGroupEnabled;
            $passwordExpireFlag = $profile->data->namespace->namespaceProfile->expirePasswordGroupEnabled;
            
            $passwordExpired = FALSE;

            if ($passwordExpireFlag) {
                $passwordExpired = is_password_expired($profile->data->passwordUpdateAt);
            }

            $this->session->set_userdata('passwordExpired', $passwordExpired);

            if ($otpVerifyFlag) {
                echo json_encode(array('status' => 2));
                return;
            }

            if ($passwordExpired) {
                echo json_encode(array('status' => 9));
                return;
            }

            //reset password and otp login flow end
            
            if($remember == 1) {
                $this->input->set_cookie('l_domain', $domain, 86400); //1day
                $this->input->set_cookie('l_email', $email, 86400);
                $this->input->set_cookie('l_remember', $remember, 86400);
            } else {
                $this->input->set_cookie('l_domain', $domain, 1); //delete cookie
                $this->input->set_cookie('l_email', $email, 1);
                $this->input->set_cookie('l_remember', $remember, 1);
            }

            // Session variables 
            $data = set_user_session_data($profile);
            $this->session->set_userdata($data);
            $redirect = 'user/empty-d';
            
            _log_login_track($json->data->authToken); 
        }
        echo json_encode(array('status' => $json->status, 'redirectUrl' => $redirect));
    }

    public function verify_operator_code()   {
        echo $this->api_model->getNSNameFromCode(array(
            'namespaceCode' => $this->input->post('op_code')
        ));
    } 

    public function dashboard() {
        $this->is_logged_in();        
        $product = $this->session->userdata('product');

        _include_js('assets/js/pages/widget_cargo.js');
        $menus = $this->api_model->getAppMenu();
        foreach($menus['parent'] as $singleMenu){
             if($singleMenu['code'] == "USER-BAL-EXCD-CRDT-LIMT"){
                $data['credit_limit_higher'] = 1;
                $cargo_Setting = $this->api_model->getCargoSettings_2(array('authtoken' => $this->session->userdata('user_hash')));
                $cargo_Setting = json_decode($cargo_Setting);
                $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
                $usr_pro = json_decode($usr_pro);

                if($cargo_Setting->data->userAccountModel->code == "BRN" ){
                    $getBranchCloseDetails = $this->api_model->getRecentBranchCloseDetails(array('authtoken' => $this->session->userdata('user_hash'),'organizationCode' => $usr_pro->data->organization->code));
                       if($getBranchCloseDetails){
                        $getBranchCloseDetails = json_decode($getBranchCloseDetails);
                        $data['BranchCloseDetails'] = $getBranchCloseDetails->data;
                       }
               }

                $data['user_profile'] = $usr_pro->data;
                $userBalance = $usr_pro->data->currnetBalance;
                $data['userBalance'] = $userBalance;
                $getUserRecentTransaction =   $this->api_model->getCargoRecentTransaction(array(
                    'userCode' =>  $usr_pro->data->code
                ));
                $userCreditLimt =  $this->api_model->cargoUserCommissions(array(
                    'userCode' =>  $usr_pro->data->code
                ));
                $userCreditLimt = json_decode($userCreditLimt);
              foreach($userCreditLimt->data as $singleBalance){
                $userCreditLimitValue = $singleBalance->creditLimit;
                $data["dueAmount"] = $userBalance;
              }
        
              $data["creditLimit"] =    $userCreditLimitValue ;
              $getUserRecentTransaction =  json_decode($getUserRecentTransaction);
             if($getUserRecentTransaction->status == 1){
                $totalPendingValue = 0.00;
                $data['getLastPaymentDate'] = $getUserRecentTransaction->data->lastAcknowledgedReceipt->transactionDate;
                $getpendingValue = $getUserRecentTransaction->data->pendingAcknowledgedReceipts;
                foreach($getpendingValue as  $SinglePendingValue ){
                    $totalPendingValue += $SinglePendingValue->transactionAmount;
                }
                $data['totalPendng'] =  $totalPendingValue;
             }

             $alluser = $this->api_model->getUser(); // getRechargeUsers()
             $alluser = json_decode($alluser);
             $user = array();
     
             $allowed_paytypes = ['POT', 'ULTED'];
             foreach ($alluser->data AS $users) {
                 if (!in_array($users->paymentType->code, $allowed_paytypes)) {
                     continue;
                 }
                 $user[$users->paymentType->code][$users->group->code]['groupname'] = $users->group->name;
                 $user[$users->paymentType->code][$users->group->code]['users'][] = array(
                     'code' => $users->code,
                     'name' => $users->name,
                 );
             }
             $data['users'] = $user;
     
             // Transaction type
             $trans = $this->api_model->getTransType(array('authtoken' => $this->_user_hash));
             $transaction_type = json_decode($trans);
     
             // Transaction Mode
             $trans_mode = $this->api_model->getTransMode(array('authtoken' => $this->_user_hash));
             $transaction_mode = json_decode($trans_mode);
     
             $data['f_t_type'] = config_item('transaction_type');
             $data['f_t_mode'] = config_item('transaction_mode');
             $data['f_a_status'] = config_item('acknowledge_status');
             $data['payment_receipt_type'] = config_item('payment_receipt_type');
     
             $data['t_type'] = $transaction_type->data;
             $data['t_mode'] = $transaction_mode->data;
     
             $vendors = $this->api_model->cargoCustomerVendor();
             $vendors = json_decode($vendors);
             $data['vendors'] = $vendors->data;
             
             }else {
                $data['credit_limit_higher'] = 0;
             }
        }

        $links = array();
        foreach ($menus['parent'] as $row) {
            $url = preg_replace('/^#/', '', $row['link']);
            $links[$url] = $row['code'];
        }
        foreach ($menus['submenu'] as $submenu) {
            foreach ($submenu as $row) {
                $url = preg_replace('/^#/', '', $row['link']);
                $links[$url] = $row['code'];
            }
        }
        $data['menu_links'] = $links;
        $data['is_mobile_verified'] = $this->session->userdata('mobile_verified');

        $due = 0;
        $dueDays = [];
        $isOverDue = -1;

        if( has_action_rights('ENABLE-SUBSCRIPTION') == 1 ) {
            $invoice = $this->api_model->getBillingInvoice();
            $invoice = json_decode($invoice);
            $data['invoice'] = $invoice->data;
            
            foreach($invoice->data as $inv) {
                if( in_array($inv->status->code, [3,4] ) ) {
                    $due += $inv->balanceDue;
                    $datetime1 = new DateTime($inv->dueDate);
                    $datetime2 = new DateTime("now");
                    $interval = $datetime1->diff($datetime2);
                    $dueDays[] = $interval->format('%R%a');
                }
            }
        }

        $dueDay = max($dueDays);
        if( $dueDay > 0 ) {
            $isOverDue = 1;
        } else if( $dueDay == 0 ) {
            $isOverDue = 0;
        } else {
            $isOverDue = -1;
        }

        //$isOverDue = 0;

        $data['dues'] = array(
            'due_amount' => round($due,2),
            'is_over_due' => $isOverDue,
            'due_days' => substr($dueDay, 1)
        );
        
        $data['cargo_setting'] = _get_cargo_settings();
   

        $this->load->view('site/user/cargo-dashboard', $data); 
        
    }

    public function empty_d() {
        $this->is_logged_in();
        $this->load->view('site/user/empty-d', array('test' => 1));
    }
        
    public function actions() {
        $this->is_logged_in();
        header('Content-Type: text/javascript');
        echo "var menu_permission=" . json_encode(config_item('rights'));
    }
    
    public function verifier() {  
        $server_error = 0;
        
        $session = $this->session->userdata('user_hash') != '' ? 1 : 0;
        $session_name = $this->session->userdata('user_name');
        
        if($session==1) {
            $token = $this->api_model->verifyAuthToken();
            $token = json_decode($token);

            if($token->status==0 && $token->errorCode==100){
                $server_error = 1;        
            }
        }
        
        $states = array(
            'status' => $session,
            'server_error' => $server_error,
            'session_name' => $session_name
        );
        echo json_encode($states);
    }

    public function switch_namsespace() {

    }
    

    public function logout() {
        // destroy session
        $referrer = $this->session->userdata('referrer');
        $result = @$this->api_model->logout($data);
        $this->session->sess_destroy();
        if(empty($referrer))  $referrer = '/';
        else if(!preg_match("/agentlogin/i", $referrer)) $referrer .= 'account/logout'; // kill customer portal session        
        redirect($referrer);
    }
    
    public function reset_credit(){
        $this->is_logged_in();
        $balance = $this->input->post('balance');
        $bal = number_format($balance,2);
        $this->session->set_userdata('balance', $bal);
        echo json_encode(array('status' => 1,'balance' => $bal));
    }
   public function update_user_notify() {
        $this->is_logged_in();

        $data = array(
            'comments' => $this->input->post('comments'),
            'code' =>   $this->input->post('code')   
        );
        echo $this->api_model->updateUserNotify($data);
    }
    
    public function send_user_otp() {
        echo $this->api_model->sendUserOTP(array());
    }

    function cargo_user_branches() {
        $this->is_logged_in();
        
        echo $this->api_model->cargoUserBranches(array(
            'userCode' => $this->input->post('userCode')
        ));
    }

    function cargo_user_branches_list() {
        $this->is_logged_in();
        
        $branches = $this->api_model->cargoUserBranches(array(
            'userCode' => $this->input->post('userCode')
        ));
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;

        $this->load->view('site/cargo/user-branches-list', $data);
    }

    function save_user_branches() {
        $this->is_logged_in();

        $userCode = $this->input->post('userCode');
        $branchesList = $this->input->post('branchesList');

        foreach ($branchesList as $branchCode) {
            $branch = $this->api_model->saveUserBranches(array(
                'userCode' => $userCode,
                'code' => $branchCode,
                'activeFlag' => 1,
            ));
            $branch = json_decode($branch);

            if ($branch->status != 1) {
                echo json_encode($branch);
                return;
            }
        }
        
        echo json_encode(array('status' => 1));
    }

    function remove_user_branches() {
        $this->is_logged_in();
        
        echo $this->api_model->saveUserBranches(array(
            'userCode' => $this->input->post('userCode'),
            'code' => $this->input->post('branch'),
            'activeFlag' => 0,
        ));
    }

    function switch_branch() {
        $this->is_logged_in();
        
        $branch = $this->api_model->getswitchBranch(array(
            'organizationCode' => $this->input->post('code') ?: '',
        ));
        $branchobj = json_decode($branch);
        
        if ($branchobj->status == 1) {
            // Profile
            $usr_pro = $this->api_model->getUserProfile(array('authtoken' => _get_user_hash()));
            $profile = json_decode($usr_pro);
            
            $this->session->set_userdata('org_station_code', $profile->data->organization->station->code);
            $this->session->set_userdata('org_station_name', $profile->data->organization->station->name);
            $this->session->set_userdata('org_code', $profile->data->organization->code);
            $this->session->set_userdata('org_name', $profile->data->organization->name);
        }
        
        echo $branch; 
    }
}

?>
