<?php

if (!defined('BASEPATH')) exit('No direct script access allowed');

class MY_Controller extends CI_Controller {

    function __construct() {
        parent::__construct();
        $this->load->driver('cache');

        $this->loadLanguageFiles();
    }

    /**
     * 	Verify website user logged in
     */
    function is_logged_in() {
        if ($this->session->userdata('user_id') == '') { // session expired in UI server
            if ($this->input->is_ajax_request()) {
                header('HTTP/1.1 440 Session Timeout', true, 440);
                exit;
            } else { 
                redirect('/');
                exit;
            }
        } else {    //  session expired bits server
            $token = $this->api_model->verifyAuthToken();
            $token = json_decode($token); 
            if($token->status==0 && $token->errorCode==100){
                if ($this->input->is_ajax_request()) {
                    header('HTTP/1.1 440 Session Timeout', true, 440);
                    exit;
                } else { 
                    redirect('user/logout');
                    exit;
                }        
            } else {    // permission denied for current product
                $url =  $this->uri->segment(1).'/'.$this->uri->segment(2);
                if($url !== "product/change") {
                    $menu_items = $this->load->get_var('parent');
                    if(count($menu_items)<2) {
                        redirect('product/denied');            
                    }                
                }
            }            
        }
    }
	
	/**
     * 	Verify website user logged in
     */
    function verify_admin() {
        if ($this->session->userdata('admin') == 1)	return true;
        else { 
            $this->load->exclude_template();
            $this->load->view('site/permission_denied');			
            return false;
        }
    }

    function loadLanguageFiles()
    {
        $idiom = 'english';
        $namespace = _get_namespace_id();

        // load default language
        $this->lang->load('default', $idiom);

        if ($namespace == 'rajeshexpress') {
            $namespace = 'rajeshcargo';
        }
        if (file_exists(APPPATH . "language/{$idiom}/{$namespace}_lang.php")) {
            // override default language with namespace language
            $this->lang->load($namespace, $idiom);
        }
    }

}