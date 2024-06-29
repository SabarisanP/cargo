<?php

if (!defined('BASEPATH'))
	exit('No direct script access allowed');

class Index extends MY_Controller {
	function __construct() {
		parent::__construct();
	}

	public function index() {
		$this->is_logged_in();
		redirect('user/dashboard');
	}

	public function ezeeprint() {

		$this->load->exclude_template();
		$this->load->view('site/user/ezeeprint');
	}

	public function qrcode() {

		$this->load->exclude_template();
		$this->load->view('site/user/qrcode');
	}

	public function reports() {

		$this->load->exclude_template();
		$this->load->view('site/user/reports');
	}

	public function login() {

		$this->load->exclude_template();
		$ns = $this->input->get('ns');
		$data['ns'] = $this->input->cookie('l_domain');
		$data['ns'] = $ns ?: $this->input->cookie('l_domain');
		$data['email'] = $this->input->cookie('l_email');
		$data['remember'] = $this->input->cookie('l_remember');
		$this->load->view('site/user/login', $data);
	}
}

?>