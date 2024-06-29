<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class profile extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
        $this->_user_hash = _get_user_hash();
    }

    public function index() {
        $this->is_logged_in();
        redirect('user/dashboard');
    }

    public function edit() {
        $this->is_logged_in();
        _include_js('assets/js/pages/profile.js');

        $states = $this->api_model->getAllStates();
        $states = json_decode($states);
        $data['states'] = $states->data;

        $tmp = get_active_group_and_users();
        $data['groupusers'] = $tmp['groupusers'];

        $smsProvider = $this->api_model->getSMSProvider();
        $smsProvider = json_decode($smsProvider);
        $data['smsprovider'] = $smsProvider->data;

        $nsprofile = $this->api_model->getNamespaceProfile(array('authtoken' => $this->_user_hash));
        $nspro = json_decode($nsprofile);
        $data['nsprofile'] = $nspro->data;

        $eventTypes = $this->api_model->getAlertEventsTypes();
        $eventTypes = json_decode($eventTypes);
        $data['eventTypes'] = $eventTypes->data;

        $nsAlerts = $this->api_model->getNsAlertSubscriptions();
        $nsAlerts = json_decode($nsAlerts);
        $data['nsAlerts'] = $nsAlerts->data;

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;
    
        $this->load->view('site/profile/edit', $data);
    }

    function update_nsp_rpt_days(){
        $this->is_logged_in();
        
        $data = $this->input->post('allowMaxDaysByGroup') ?: [];
        echo $this->api_model->updateNspRPtDays($data);
    }

    function add_profile() {
        $this->is_logged_in();

        $data_namespace = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'pin' => $this->input->post('pin'),
            'emailCopyAddress' => $this->input->post('emailCopyAddress'),
            'mode' => "OWN"
        );
        $name = $this->api_model->updateNamespaceDetails($data_namespace);

        $rpt = json_decode($name);

        if ($rpt->status == 1) {

            $data = array(
                "domainURL" => $this->input->post('domainURL'),
                "smsNotificationFlagCode" => implode("", $this->input->post('smsNotificationFlag')),
                "whatsappNotificationFlagCode"=>implode("", $this->input->post('whatsappNotificationFlagCode')),
                "timeFormat" => $this->input->post('timeFormat'),
                "sendarMailName" => $this->input->post('sendarMailName'),
                "sendarSMSName" => $this->input->post('sendarSMSName'),
                "smsSenderCode" => $this->input->post('smsSenderCode'),
                "smsProviderCode" => $this->input->post('smsProviderCode'),
                "whatsappProviderCode"=>$this->input->post('whatsappProviderCode'),
                "whatsappUrl" => $this->input->post('whatsappUrl') ?: 'NA',
                "dateFormate" => $this->input->post('dateFormate'),
                "droppingPointRequriedFlag" => $this->input->post('droppingPointRequriedFlag'),
                "shortCode" => $this->input->post('shortCode'),
                "instantCancellationMinitues" => $this->input->post('instantCancellationMinitues'),
                "autoGenerateVoucherFlag" => $this->input->post('autoGenerateVoucherFlag'),
                "whatsappNumber"=>$this->input->post("whatsappNumber") ?: 'NA',
                "state" => array('code'=>$this->input->post('state')),
                "city" => $this->input->post('city'),
                "pincode" => $this->input->post('pincode'),
                "supportNumber" => $this->input->post('supportNumber'),
                "address" => $this->input->post('address'),
                "emailNotificationFlagCode" => implode("", $this->input->post('emailNotificationFlagCode')),
                "allowDirectLogin" => $this->input->post('allowDirectLogin'),
                "ewayBillVendorCode" => $this->input->post('ewayBillVendorCode'),
                "balanceOnManageExpense" => $this->input->post('balanceOnManageExpense') ?: [],
                "otpVerifyGroup" => $this->input->post('otpVerifyGroup')?:[],
                "notificationPreferences" =>array('code'=>$this->input->post('notificationPreferences')),
                "expirePasswordGroup" => $this->input->post('expirePasswordGroup')?:[],
            );
            echo $this->api_model->addProfile($data);
        }
    }

    function change_password() {
        $this->is_logged_in();
        $data = array(
            'oldpassword' => $this->input->post('oldpassword'),
            'newpassword' => $this->input->post('newpassword'),
        );
        echo $this->api_model->updatePassword($data);
    }

    function update_namespace() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'pin' => $this->input->post('pin'),
            'emailCopyAddress' => $this->input->post('emailCopyAddress'),
            'mode' => "OWN"
        );
        echo $this->api_model->updateNamespaceDetails($data);
    }

    public function edit_profile() {
        $this->is_logged_in();
        _include_js('assets/js/pages/profile.js');

        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->_user_hash));
        $profile = json_decode($usr_pro);
        $data['pro_usr'] = $profile->data;
        $data['token'] = $this->session->userdata('user_hash');
        $data['balance'] = $this->session->userdata('balance');

        $pg_list = $this->api_model->getUserTxnPaymentGatewayOptions();
        $pg_list = json_decode($pg_list);
        $data['providers'] = array();
        if( $pg_list->status==1 )
            $data['providers'] = $pg_list->data[0]->paymentGatewayPartner;

        $subscription = $this->api_model->getNotificationSubscription(array('deviceMedium' => 'EZBOT'));
        $subscription = json_decode($subscription);

        $subscByDevice = array();
        foreach ($subscription->data as $row) {
            $subscByDevice[$row->deviceMedium->code][] = $row;
        }
        $data['subscription'] = $subscByDevice;

        $notification = $this->api_model->getEventNotifications(array('deviceMedium' => 'EZBOT'));
        $notification = json_decode($notification);
        $data['notification'] = $notification->data;

        $this->load->view('site/profile/edit-profile', $data);
    }

    public function send_mobile_verify_otp() {
        $this->is_logged_in();
        $data = array(
            'mobile' => $this->input->post('mobile')
        );
        echo $this->api_model->sendMobileVerifyOTP($data);
    }

    public function verify_mobile_otp() {
        $this->is_logged_in();
        $data = array(
            'mobile' => $this->input->post('mobile'),
            'otp' => $this->input->post('otp')
        );
        echo $res = $this->api_model->verifyMobileOTP($data);
        $res_j = json_decode($res);
        if($res_j->status==1) {
            $this->session->set_userdata('mobile_verified', 1);  // update session variable.
            $this->api_model->resetUserCache(); //  reset user cache.
        }
    }

    public function get_recharge_payment_meta() {
        $this->is_logged_in();
        $data = array(
            'gatewayCode' => $this->input->post('gateway'),
            'transactionAmount' => $this->input->post('amount'),
            'responseUrl' => base_url().'profile/recharge-payment-response'
        );
        $res = $this->api_model->getPaymentGatewayMeta($data);

        $pg_urls = config_item('pg_forward_url');
        $ns_code = $this->session->userdata('namespace_id');
        $pg_url = ( !empty($pg_urls[$ns_code]) ) ? trim($pg_urls[$ns_code]) : $pg_urls['default'];

        $res_j = json_decode($res);
        if($res_j->status==1) {
            $res_j->data->gatewayInputDetails->paymentRedirectUrl = $res_j->data->paymentRequestUrl;
            $res_j->data->paymentRequestUrl = $pg_url;
            $res = json_encode($res_j);
        }
        echo $res;
    }

    public function recharge_payment_response() {
        $this->is_logged_in();
        $transcode = $this->input->get('orderCode');
        if($transcode!='') {
            $confirm = $this->api_model->confirmAgentOnlineRecharge(array('transCode' => $transcode));
            $confirm = json_decode($confirm);
            if($confirm->status==1) {
                $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->_user_hash));
                $profile = json_decode($usr_pro);
                $balance = number_format($profile->data->currnetBalance, 2);
                $this->session->set_userdata('balance', $balance);

                redirect(base_url().'#profile/edit-profile?status=confirm&code='.$transcode);
            } else {
                redirect(base_url().'#profile/edit-profile?status=fail&code='.$transcode.'&error='.$confirm->errorDesc);
            }
        } else {
            redirect(base_url().'#profile/edit-profile?status=invalid&code='.$transcode);
        }
    }

    public function edit_user_profile() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'email' => $this->input->post('email'),
            'code' => $this->input->post('code'),
        	'paymentType' => array("code" => $this->input->post('pay_mode'))

        );
        echo $this->api_model->updateUser($data);
    }

    function update_token() {
        $this->is_logged_in();
        $data = array(
            'tokenPassword' => $this->input->post('token'),
        );
        echo $this->api_model->updateApiToken($data);
    }

    function alert_subscription() {
        $this->is_logged_in();

        $res = array();
        $userAlerts = $this->api_model->getUserAlertSubscriptions();
        $userAlerts = json_decode($userAlerts);

        $alertTypes = $this->api_model->getNsAlertSubscriptions();
        $alertTypes = json_decode($alertTypes);

        $groupUsers = get_active_group_and_users();

        /*foreach($alertTypes->data as $subscription) {
            $eventCode = $subscription->eventType->code;
            $userAlerts[$eventCode][] = array($subscription);
        }*/
        $data['groups'] = $groupUsers['groups'];
        $data['usersbygroup'] = $groupUsers['groupusers'];
        $data['nitifychannel'] = $this->config->item('alert_nitify_channel');
        $data['useralerts'] = $userAlerts->data;
        $data['eventtypes'] = $alertTypes->data;

        $this->load->view('site/profile/alert-subscription', $data);
    }

    function update_alert_subscription() {
        $this->is_logged_in();

        echo $this->api_model->updateAlertSubscriptions(array(
            'code' => $this->input->post('code'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'subscriptionType' => $this->input->post('subscriptionType') ?: [],
            'mediumList' => $this->input->post('mediumList') ?: [],
            'userList' => $this->input->post('userList') ?: [],
            'groupList' => $this->input->post('groupList') ?: []
        ));
    }

    function auth_notification_subscription() {
        $this->is_logged_in();

        echo $this->api_model->authNotificationSubscription(array(
            'deviceMedium' => $this->input->post('deviceMedium')
        ));
    }

    function revoke_notification_subscription() {
        $this->is_logged_in();

        echo $this->api_model->revokeNotificationSubscription(array(
            'authenticateCode' => $this->input->post('code'),
            'deviceMedium' => $this->input->post('deviceMedium')
        ));
    }

    function update_notification_subscription() {
        $this->is_logged_in();

        $param = $this->input->post('typeList') ?: [];
        echo $this->api_model->updateNsAlertSubscriptions($param);
    }

    function update_event_notification() {
        $this->is_logged_in();

        $param = $this->input->post('notification') ?: [];
        echo $this->api_model->updateEventNotifications($param);
    }

    function alert_subscription_report_list() {

        $data = array(
            'subscriptionTypeCode' => $this->input->post('subscriptionTypeCode') ?: ''
        );

        $result = $this->api_model->getAlertSubscriptionsReport($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $this->load->view('site/profile/alert-subscription-report-list', $data);
    }

    function generate_cargoapp_otp() {
        $this->is_logged_in();

        $this->load->model('shorturl_model');

        $data = array(
                'authToken' => _get_user_hash(),
                'nsCode' => _get_namespace_id(),
                'zone' => config_item('zone'),
                'apiUrl' => config_item('api_domain'),
            );

        echo $this->shorturl_model->shorten(array(
            'type' => 'MXD',
            'data' => json_encode($data)
        ));
    }
}

?>
