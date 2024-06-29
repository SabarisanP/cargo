<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Home extends MY_Controller {

    function __construct() {
        parent::__construct();
    }
	public function index() {
            $this->is_logged_in();
           $this->load->view('site/home/portal');
    }

	public function get_namespace( ) {
        $this->is_logged_in();
        $authToken = $this->input->Get('domainName');
		$deviceMedium = $this->input->Get('deviceMedium');

        $nameSpace = $this->api_model->getNamespaceInfo(array('domainName' => $domainName,'deviceMedium'=>$deviceMedium));

        return json_decode($nameSpace);


    }
	  // public function get_fromstation( ) {
        // $this->is_logged_in();
        // $authToken = $this->input->Get('authToken');

        // $fromstation = $this->api_model->get_fromstation(array('authToken' => $authToken);

        // return json_decode($fromstation);


    // }

}

?>
