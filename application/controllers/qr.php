<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Qr extends MY_Controller {

    function __construct() {
        parent::__construct();
    }
    
    public function index() {  
        //$this->is_logged_in();   
        $this->load->library('ciqrcode');   

        $qrparams['data'] = $this->input->get('data') ?:'NO DATA';
        $qrparams['size'] = $this->input->get('size') ?: 10;      
        $qrparams['level'] = 'H';
        
        header("Content-Type: image/png");
        $this->ciqrcode->generate($qrparams);
    }
}

?>
