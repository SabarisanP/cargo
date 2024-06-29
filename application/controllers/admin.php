<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class Admin extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
    }

    public function index() {
        _to_dashboard();
    }

    public function dashboard() {
        if (!$this->verify_admin()) {
            return;
        }

        $this->load->view('site/admin/dashboard');
    }

    function integrations() {
        $this->is_logged_in();

        $result = $this->api_model->getAllIntegrationType();
        $result = json_decode($result);
        $data['integrations_type'] = $result->data;

        $types = [];
        foreach ($result->data as $type) {
            $types[$type->code] = $type;
        }
        $data['integrations_type'] = $result->data;

        $result = $this->api_model->getAllIntegrations();
        $result = json_decode($result);
        $data['integrations'] = $result->data;

        $states = $this->api_model->getAllStates();
        $states = json_decode($states);
        $data['states'] = $states->data;

        $this->load->view('site/admin/integrations', $data);
    }

    function get_integrations() {
        $this->is_logged_in();

        $result = $this->api_model->getIntegrationsByType(array(
            'integrationTypeCode' => $this->input->post('integrationTypeCode'),
        ));
        $result = json_decode($result);
        $data['integrations'] = $result->data;
        $data['integrationTypeCode'] = $this->input->post('integrationTypeCode');
        $data['integrationTypeName'] = $this->input->post('integrationTypeName');

        $this->load->view('site/admin/integrations-list', $data);
    }

    function update_integrations() {
        $this->is_logged_in();

        echo $this->api_model->updateIntegrations(array(
            'code' => $this->input->post('code') ?: '',
            'integrationType' => $this->input->post('integrationType'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'accessToken' => $this->input->post('accessToken'),
            'accessUrl' => $this->input->post('accessUrl'),
            'account' => $this->input->post('account'),
            'state' => $this->input->post('state') ?: new stdClass,
            'additionalAttribute' => $this->input->post('additionalAttribute') ?: new stdClass,
        ));
    }

    function sms_config() {
        $this->is_logged_in();

        $data = array();
        $namespace = $this->api_model->getNamespace(array('authtoken' => $this->_user_hash));
        $namespace = json_decode($namespace);
        $data['namespaces'] = $namespace->data;
        $data['notification_mode'] = config_item('notification_mode');
        $this->load->view('site/admin/sms-config', $data);
    }

    function get_sms_config() {
        $this->is_logged_in();

        $data = array();
        $smsconfig = $this->api_model->notificationSmsConfig(array(
            'namespaceCode' => $this->input->post('namespaceCode'),
        ));
        $smsconfig = json_decode($smsconfig);
        $data['smsconfig'] = $smsconfig->data;
        $data['nscode'] = $this->input->post('namespaceCode');
        $data['notification_mode'] = config_item('notification_mode');

        $this->load->view('site/admin/ns-sms-config', $data);
    }
    
    function update_sms_sender() {
        $this->is_logged_in();

        echo $this->api_model->updateNotificationSmsConfig(array(
            'namespaceCode' => $this->input->post('namespaceCode'),
            'code' => $this->input->post('code'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'entityCode' => $this->input->post('entityCode'),
            'notificationMode'=>$this->input->post('notificationMode'),
            'headerDltCode' => $this->input->post('headerDltCode'),
            'header' => $this->input->post('header')
        ));
    }
    
    function get_sms_template() {
        $this->is_logged_in();

        $data = array();
        $smstpl = $this->api_model->smsTemplateConfig(array(
            'namespaceCode' => $this->input->post('namespaceCode'),
            'smsConfigCode' => $this->input->post('smsConfigCode'),
        ));
        $smstpl = json_decode($smstpl);
        $data['smstpl'] = $smstpl->data;

        $smstype = $this->api_model->notificationSmsTypes(array(
            'namespaceCode' => $this->input->post('namespaceCode')
        ));
        $smstype = json_decode($smstype);
        $data['sms_notification_type'] = $smstype->data;
    
        $this->load->view('site/admin/ns-sms-template', $data);
    }
    
    function update_sms_template() {
        $this->is_logged_in();

        echo $this->api_model->updateSmsTemplateConfig(array(
            'namespaceCode' => $this->input->post('namespaceCode'),
            'code' => $this->input->post('code'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'notificationSMSConfig' => $this->input->post('notificationSMSConfig'),
            'templateDltCode' => $this->input->post('templateDltCode'),
            'notificationType' => $this->input->post('notificationType'),
            'content' => $this->input->post('content')
        ));
    }

    function rate_card_template() {
        $this->is_logged_in();
        $data = array();
        
        $result = $this->api_model->getRateCardTemplate();
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['billing_conf_pricing_model'] = config_item('billing_conf_pricing_model');
    
        $this->load->view('site/admin/rate-card-template', $data);
    }

    function update_rate_card_template() {
        $this->is_logged_in();

        echo $this->api_model->updateRateCardTemplate(array(
            'code' => $this->input->post('code')?: '',
            'name' => $this->input->post('name'),
            'activeFlag' => $this->input->post('activeFlag'),
            'rateCardList' => $this->input->post('rateCardList'),
        ));
    }

    function billing_configuration() {
        $this->is_logged_in();

        $data = array();
        $is_super_ns = _is_super_namespace( $this->session->userdata('native_namespace_code'));
        
        if($is_super_ns != 1 || !has_action_rights('NSCE-EDIT')) {
            $this->load->view('site/denied', $data);
            return;
        }
        
        $rateCardTemplate = $this->api_model->getRateCardTemplate();
        $rateCardTemplate = json_decode($rateCardTemplate);
        $data['rateCardTemplate'] = $rateCardTemplate->data;

        $result = $this->api_model->getRateCardTerms();
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['billing_events'] = config_item('billing_events');
        $data['billing_conf_pricing_model'] = config_item('billing_conf_pricing_model');
    
        $this->load->view('site/admin/billing-configuration', $data);
    }
    
    function update_billing_configuration() {
        $this->is_logged_in();

        $data = array(
            'name' => $this->input->post('name')?: '',
            'email' => $this->input->post('email')?: '',
            'startDate' => $this->input->post('startDate')?: '',
            'billingPeriod' => $this->input->post('billingPeriod'),
            'minBillingAmount' => $this->input->post('minBillingAmount'),
            'pricingModel' => $this->input->post('pricingModel'),
            'billingRateCard' => $this->input->post('billingRateCard')?: [],
            'billingNotification' => $this->input->post('billingNotification')?: [],
            'addonDetails' => $this->input->post('addonDetails')?: [],
            'activeFlag' => $this->input->post('activeFlag'),
        );

        $rateCardEvents = $this->input->post('gracePeriod')?: [];

        $result = $this->api_model->updateRateCardTerms($data);
        $result = json_decode($result);
        if ($result->status != 1) {
            echo json_encode($result);
            return;
        }

        echo $this->api_model->updateRateCardEvents($rateCardEvents);
    }

    function subscription() {
        $this->is_logged_in();
        $data = array();
        
        $billing = $this->api_model->getBillingOverview();
        $billing = json_decode($billing);
        $data['billing'] = $billing->data;

        $invoice = $this->api_model->getBillingInvoice();
        $invoice = json_decode($invoice);
        $data['invoice'] = $invoice->data;

        $token = $this->api_model->getAllIntegrations();
        $token = json_decode($token);

        $accessToken = '';
        foreach($token->data as $row){
            if($row->integrationType->code == "VERTEX"){
                $accessToken = $row->accessToken;
                $accountCode = $row->account;
            }
        }

        $data['accessToken'] = $accessToken;
        $data['accountCode'] = $accountCode;

        $data['invoice_status'] = config_item('vertex_invoice_status');
        $data['vertex_domain'] = config_item('vertex_domain');

        $this->load->view('site/admin/subscription', $data);
    }

    function refresh_billing_status() {
        $this->is_logged_in();

        echo $this->api_model->refreshBillingStatus();
    }

    function subscription_payment_email() {
        $this->is_logged_in();

        $config = config_item('smtp_details');

        $this->load->library('email');
        $this->email->initialize($config);
        $this->email->set_newline("\r\n");

        $this->email->from('mail@ezeeinfosolutions.in', 'Cargo Payments');

        $this->email->to( array('admin@ezeeinfosolutions.com', 'ezeesowmiya@gmail.com') );        
        $this->email->cc( array('kathir@ezeeinfosolutions.com') );
        
        //$this->email->bcc('kathir@ezeeinfosolutions.com');
        $this->email->reply_to('kathir@ezeeinfosolutions.com', 'Kathir-EzeeInfo');

        $emailSubject = 'Cargo invoice payment updated by client';

        $mailContent = '<br> Client Name : '.$this->session->userdata('namespace_name');
        $mailContent .= '<br> Updated By : '.$this->session->userdata('user_name');
        $mailContent .= '<br> Invoice Id : '.$this->input->post('invcode');
        $mailContent .= '<br> Paid Amount: '.$this->input->post('amount');
        $mailContent .= '<br> Ref No : '.$this->input->post('refno');

        $this->email->subject($emailSubject);
        $this->email->message($mailContent);

        $result = $this->email->send();

        if($result == 1) {           
            echo json_encode( array('status' => 1) );
        } else {
            echo json_encode( array('status' => 0) );
        }

    }

}

?>