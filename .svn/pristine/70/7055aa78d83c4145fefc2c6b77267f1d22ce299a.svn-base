<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Driver extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
        $this->_user_hash = _get_user_hash();
    }

    public function index() {
        $this->is_logged_in();
        _include_js('assets/js/pages/driver.js');
        $this->load->view('site/driver/driver.tpl');
    }
    
}
?>