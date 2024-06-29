<?php

class push_model extends CI_Model {

    function __construct() {
        
    }

    function pushScheduleToVendor($param) {
        $url = '/rb_ias_ezee_callback_api?action_type=SEARCH';
        $param = json_encode($param);
        return $this->_getPushVendorJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
        ));
    }

    function _getPushVendorJson($method, $url, $param = array(), $options = array()) {
        $this->pest->setupBaseUrl('http://gds2.redbus.com/post');
        switch (strtoupper($method)) {
            case "POST" :
                $r = $this->pest->post($url, $param, $options);
                break;
            case "PUT" :
                if (is_array($param))
                    $url = sprintf("%s?%s", $url, http_build_query($param));
                $r = $this->pest->put($url, $param, $options);
                break;
            case "GET" :
                $r = $this->pest->get($url, $param, $options);
                break;
            case "DELETE" :
                $r = $this->pest->delete($url, $param, $options);
                break;
            case "PATCH" :
                $r = $this->pest->patch($url, $param, $options);
                break;
        }
        if (config_item('allow_data_log')) {
            @$data = chr(10) . '--------------------------------------------------------------------------------' . chr(10) . 'URL : ' . $url . chr(10) . 'Data : ' . (is_array($param) ? json_encode($param) : $param) . chr(10) . 'Response : ' . $r;
            @file_put_contents('pushvendor-log.txt', $data, FILE_APPEND);
        }
        return $r;
    }

}

?>
