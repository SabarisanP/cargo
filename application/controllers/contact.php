<?php
    if (!defined('BASEPATH')) exit('No direct script access allowed');

    class Contact extends MY_Controller {

        function __construct() {
            parent::__construct();
            $this->is_logged_in();
        }

        function contact_users() {
            $this->is_logged_in();
            _include_js('assets/js/pages/contact.js', 'init_contact');

            $result = $this->api_model->cargoTags(array('categoryCode' => 'TRANS'));
            $result = json_decode($result);
            $data['cargotags'] = $result->data;

            $result = $this->api_model->getContactCategory();
            $result = json_decode($result);
            $data['contactCategory'] = $result->data;

            $this->load->view('site/contact/contact-and-users', $data);
        }

        public function update_contact_users() {
            $this->is_logged_in();

            $data = array(
                'code' => $this->input->post('code'),
                'activeFlag' => $this->input->post('activeFlag'),
                'name' => $this->input->post('name'),
                'tradeName' => $this->input->post('tradeName'),
                'gstin' => $this->input->post('gstin'),
                'referenceCode' => $this->input->post('referenceCode'),
                'tag' => $this->input->post('tag') ?: [],
                'tagList' => $this->input->post('tagList') ?: [],
                'contactName' => $this->input->post('contactName'),
                'contactCategory' => $this->input->post('entityType'),
                'mobile' => $this->input->post('mobile'),
                'email' => $this->input->post('email'),
                'contactAddress' => $this->input->post('contactAddress')
            );
            $result = $this->api_model->updateContact($data);

            $results = json_decode($result);

            if($results->status == 1 && $this->input->post('activeFlag') != 2){
                $data = array(
                    'code' =>  $this->input->post('bank_code'),
                    'activeFlag' => $this->input->post('bank_activeFlag'),
                    'name' => $this->input->post('bank_name'),
                    'referenceCode' => $results->data->code,
                    'accountNumber' => $this->input->post('accountNumber'),
                    'accountType' => $this->input->post('accountType') ?: '',
                    'entityType' => $this->input->post('bank_entityType') ?: '',
                    'bankName' => $this->input->post('bankName'),
                    'branchLocation' => $this->input->post('branchLocation'),
                    'ifscCode' => $this->input->post('ifscCode'),
                    'upiId' => $this->input->post('upiId')
                );
                echo $this->api_model->updateBankDetail($data);
            }else{
                echo json_encode($results);
            }
        }

        public function get_all_contacts(){
            $this->is_logged_in();

            $contact = $this->api_model->getContact(array('entityTypeCode' => $this->input->post('entityTypeCode')));
            $contact = json_decode($contact);
            $data['contact'] = $contact->data;

            $data['entity_type'] = $this->input->post('entityTypeCode');
            $data['type'] = $this->input->post('type');
            
            $this->load->view('site/contact/contact-list', $data);
        }
        
        public function get_bank_details(){
            $this->is_logged_in();

            $data = array(
                'entityType' => $this->input->post('entityType'),
                'code' => $this->input->post('referenceCode')
            );

            echo $this->api_model->getBankDetail($data);
        }

        public function get_all_bank_details(){
            $this->is_logged_in();

            $data = array(
                'entityTypeCode' => $this->input->post('entityTypeCode'),
                'referenceCode' => _get_namespace_id()
            );

            $bank_detail = $this->api_model->getAllBankDetails($data);
            $bank_detail = json_decode($bank_detail);
            $data['bank_detail'] = $bank_detail->data;

            $contact = $this->api_model->getContact(array('entityTypeCode' => $this->input->post('entityTypeCode')));
            $contact = json_decode($contact);
            $data['contact'] = $contact->data;

            $data['entity_type'] = $this->input->post('entityTypeCode');
            
            $this->load->view('site/contact/bank-detail-list', $data);
        }

        public function update_bank_details() {
            $this->is_logged_in();
            
            $data = array(
                'code' =>  $this->input->post('code'),
                'activeFlag' => $this->input->post('activeFlag'),
                'name' => $this->input->post('name'),
                'referenceCode' => _get_namespace_id(),
                'accountNumber' => $this->input->post('accountNumber'),
                'accountType' => $this->input->post('accountType') ?: '',
                'entityType' => $this->input->post('entityType') ?: '',
                'bankName' => $this->input->post('bankName'),
                'branchLocation' => $this->input->post('branchLocation'),
                'ifscCode' => $this->input->post('ifscCode'),
                'upiId' => $this->input->post('upiId')
            );
            echo $this->api_model->updateBankDetail($data);
        }

        public function update_contact_expense() {
            $this->is_logged_in();
            
            $data = array(
                'code' => $this->input->post('code'),
                'activeFlag' => $this->input->post('activeFlag'),
                'name' => $this->input->post('name'),
                'tradeName' => $this->input->post('tradeName') ?: '',
                'gstin' => $this->input->post('gstin') ?: '',
                'referenceCode' => _get_namespace_id(),
                'tag' => $this->input->post('tag') ?: [],
                'tagList' => $this->input->post('tagList') ?: [],
                'contactName' => $this->input->post('contactName'),
                'contactCategory' => $this->input->post('contactCategory'),
                'mobile' => $this->input->post('mobile') ?: '',
                'email' => $this->input->post('email') ?: '',
                'contactAddress' => $this->input->post('contactAddress') ?: (object) []
            );
            echo $this->api_model->updateContact($data);
        }

        function contact_category() {
            $this->is_logged_in();

            $result = $this->api_model->getContactCategory();
            $result = json_decode($result);
            $data['contactCategory'] = $result->data;
            $data['contact_category_action_codes'] = $this->config->item('contact_category_action_codes');
            $data['contact_category_tags'] = $this->config->item('contact_category_tags');

            $this->load->view('site/contact/contact-category', $data);
        }

        public function update_contact_category() {
            $this->is_logged_in();
            
            $data = array(
                'code' => $this->input->post('code') ?: '',
                'activeFlag' => $this->input->post('activeFlag'),
                'name' => $this->input->post('name'),
                'actionCode' => $this->input->post('action_code') ?: 'NA',
                'description' => $this->input->post('description') ?: '',
                'tag' => $this->input->post('tag') ?: []
            );
            echo $this->api_model->updateContactCategory($data);
        }
    }
?>