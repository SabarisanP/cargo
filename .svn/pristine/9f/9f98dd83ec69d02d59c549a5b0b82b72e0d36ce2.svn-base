<?php

if (!defined('BASEPATH'))    exit('No direct script access allowed');

class Product extends MY_Controller {
    function __construct() {
        parent::__construct();
    }
    public function change() {
        $this->is_logged_in();
        $token = _get_user_hash();
        $product = $this->input->get('product');
        
        $conf_product_urls = config_item('product_domain');        
        $url =  $conf_product_urls[strtolower($product)];
        
        redirect($url.'/user/auto-login?ns='.$this->session->userdata('namespace_id').'&token='.$token.'&product='.$product.'&a=1');
    }

    public function wallet() {
        $this->is_logged_in();

        $product_urls = config_item('product_domain');
        $url = $product_urls[strtolower('wallet')];

        $walletToken = $this->api_model->walletAccessToken();
        $walletToken = json_decode($walletToken);
        
        if($walletToken->status == 0) {
            $this->load->view('site/denied');
            return;
        }
        
        $walletToken = $walletToken->data->token;
        
        $data = array(
            'token' => $walletToken,
            'user_id' => $this->session->userdata('user_id'),
            'user_name' => $this->session->userdata('user_name'),
            'namespace_id' => $this->session->userdata('namespace_id'),
            'namespace_name' => $this->session->userdata('namespace_name'),
            'is_super_native_ns' => _is_super_namespace($this->session->userdata('native_namespace_code')),
            'date_time' => strtotime('now')
        );

        $this->load->library('encrypt');
        $data = $this->encrypt->encode(json_encode($data));

        redirect($url . '/user/auto-login?token=' . urlencode($data));
    }

    public function denied() {
        $data = array();
        $this->load->view('site/denied', $data);
    }

    public function desktop_login() {
        $namespace = $this->input->get('ns');
        $product = $this->input->get('product') ?: 'bits';
        $token = $this->input->get('token');

        $json = file_get_contents(config_item('ns_properties_url') . "/{$namespace}.json");
        $json = json_decode($json);
        $zone = $json->data->zone;
        $zone = $zone ?: 'cargo';
        
        $domain = $this->config->item('operator_dashboard_domain');

        redirect("http://{$namespace}-dashboard.{$domain[$zone][$product]}/user/auto-login?ns={$namespace}&token={$token}");
    }
}

?>