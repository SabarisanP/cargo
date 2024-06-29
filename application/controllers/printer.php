<?php

class Printer extends MY_Controller {

    function __construct() {
        parent::__construct();        
    }
    function test() {      
        $this->load->view('site/printer/test', array());
    }
    
}
