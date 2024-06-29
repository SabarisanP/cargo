<?php

class orbit_model extends CI_Model {

    function __construct() {
        $this->_namespace_id = _get_namespace_id();
        $this->_user_hash = _get_user_hash();
    }

    function pushScheduleToVendor($param) {
        $ns_code = $this->session->userdata('namespace_id');
        $url = '/inventory/push/YEFHZF6DYGM8MNP3/' . config_item('zone') . '/namespace/' . $ns_code . '/api/trip/' . $param['tripCode'] . '/' . $param['tripDate'] . '/vendor/redbus?serviceType=' . $param['scheduleType'] . '&pushAPIType=' . $param['methodName'];
        return $this->_getOrbitJson('post', $url, $param);
    }

    function _getOrbitJson($method, $url, $param = array(), $options = array()) {
        $this->pest->setupBaseUrl(config_item('api_orbit_domain'));
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
            @file_put_contents('data-log.txt', $data, FILE_APPEND);
        }
        return $r;
    }

}

?>
