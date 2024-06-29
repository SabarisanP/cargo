<?php

class Content extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
    }
    function terms() {      
        $this->load->view('site/content/terms', $data);
    }
    function faq() {      
        $this->load->view('site/content/faq', $data);
    }
    function privacypolicy() {      
        $this->load->view('site/content/privacypolicy', $data);
    }
    function about() {      
        $this->load->view('site/content/about', $data);
    }
    function contactus() {      
        $this->load->view('site/content/contactus', $data);
    }
}
