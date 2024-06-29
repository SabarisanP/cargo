<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');


if ( ! function_exists('element')) {
    function element($item, $array, $default = FALSE) {
        if ( ! isset($array[$item]) OR $array[$item] == "") {
                return $default;
        }

        return $array[$item];
    }
}
if ( ! function_exists('getData')) {
    function getData($data){
        $result = json_decode($data);
        // if($result->status != 1){
        //     return $data;
        //     exit;
        // }
        $result = $result->data;
        return $result;
    }
}
if ( ! function_exists('response')) {
    function response($status,$data,$msg = ''){
        $response = array('status'=>$status, 'message'=>$msg,'data'=>$data);
        echo json_encode($response);
        exit();
    }
}




/* End of file common_helper.php */
/* Location: ./system/helpers/common_helper.php */