<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * Commonly used Helpers
 *
 * @package		CodeIgniter
 * @subpackage	Helpers
 * @category	Helpers
 * @author		xxxxxxx
 * @link		http://codeigniter.com/user_guide/helpers/array_helper.html
 */
// ------------------------------------------------------------------------

/**
 * Element
 *
 * Lets you determine whether an array index is set and whether it has a value.
 * If the element is empty it returns FALSE (or whatever you specify as the default value.)
 *
 * @access	public
 * @param	string
 * @param	array
 * @param	mixed
 * @return	mixed	depends on what the array contains
 */
if (!function_exists('element')) {

    function element($item, $array, $default = FALSE) {
        if (!isset($array[$item]) OR $array[$item] == "") {
            return $default;
        }

        return $array[$item];
    }

}

/* if ( ! function_exists('has_admin_permissions')) {
  global $assigned_permissions;
  function has_admin_permissions($permisson=0) {
  global $assigned_permissions;
  if(!$assigned_permissions) {
  $ci=& get_instance();
  $ci->load->database();
  $sql = "select role_permission from administrator_roles where role_id = ". (int) $ci->session->userdata('admin_role_id');
  $query = $ci->db->query($sql);
  $rows = $query->result();
  $rows = explode(',', $rows[0]->role_permission);
  foreach($rows as $row) {
  $assigned_permissions[$row] = true;
  }
  }
  return (int) $assigned_permissions[$permisson];
  }
  } */

if (!function_exists('_get_user_ip')) {
    function _get_user_ip() {
        if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
            $ip = $_SERVER['HTTP_CLIENT_IP'];
        } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
            $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
        } else {
            $ip = $_SERVER['REMOTE_ADDR'];
        }
        return $ip;
    }
}

if (!function_exists('_get_user_hostname')) {
    function _get_user_hostname() {       
        return gethostname();
    }
}

if (!function_exists('_is_admin')) {

    function _is_admin() {
        $CI = & get_instance();
        return ( $CI->session->userdata('admin') == 1) ? true : false;
    }

}

if (!function_exists('_is_smart_authorized')) {

    function _is_smart_authorized() {
        $CI = & get_instance();
        return (int) $CI->session->userdata('smart_authorized');
    }

}

if (!function_exists('_is_namespace')) {

    function _is_namespace() {
        $CI = & get_instance();
        return ( $CI->session->userdata('namespace_id') != '') ? true : false;
    }

}

if (!function_exists('_get_native_namespace_id')) {

    function _get_native_namespace_id() {
        $CI = & get_instance();
        return $CI->session->userdata('native_namespace_code');
    }

}

if (!function_exists('_get_namespace_id')) {

    function _get_namespace_id() {
        $CI = & get_instance();
        return $CI->session->userdata('namespace_id');
    }

}

if (!function_exists('_get_namespace_name')) {

    function _get_namespace_name() {
        $CI = & get_instance();
        return $CI->session->userdata('namespace_name');
    }

}

if (!function_exists('_get_user_name')) {

    function _get_user_name() {
        $CI = & get_instance();
        return $CI->session->userdata('user_name');
    }

}

if (!function_exists('_get_user_id')) {

    function _get_user_id() {
        $CI = & get_instance();
        return $CI->session->userdata('user_id');
    }

}

if (!function_exists('_get_user_email')) {

    function _get_user_email() {
        $CI = & get_instance();
        return $CI->session->userdata('user_email');
    }

}

if (!function_exists('_get_user_hash')) {

    function _get_user_hash() {
        $CI = & get_instance();
        return $CI->session->userdata('user_hash');
    }

}

if (!function_exists('_strip_space')) {

    function _strip_space($str) {
        if($str=="") return;
        return preg_replace('/\s+/','',$str);
    }

}

if (!function_exists('_to_dashboard')) {

    function _to_dashboard() {
        //if( _is_namespace() ) {
        redirect('user/empty-d');
        //} else {
        //redirect('admin/dashboard');
        //}
    }

}

/* if( !function_exists('_has_rights') ) {
  function _has_rights($keyword) {
  if (trim($keyword) == '') {
  return false;
  } else {
  $settings = config('rights');
  return ($settings[strtoupper($keyword)] == 1) ? true : false;
  }

  }
  } */


if (!function_exists('is_mobile')) {

    function is_mobile() {
        $is_mobile = '0';

        if (preg_match('/(googlebot-mobile|android|up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone)/i', strtolower($_SERVER['HTTP_USER_AGENT']))) {
            $is_mobile = 1;
        }

        if ((strpos(strtolower($_SERVER['HTTP_ACCEPT']), 'application/vnd.wap.xhtml+xml') > 0) or ((isset($_SERVER['HTTP_X_WAP_PROFILE']) or isset($_SERVER['HTTP_PROFILE'])))) {
            $is_mobile = 1;
        }

        $mobile_ua = strtolower(substr($_SERVER['HTTP_USER_AGENT'], 0, 4));
        $mobile_agents = array('w3c ', 'acs-', 'alav', 'alca', 'amoi', 'andr', 'audi', 'avan', 'benq', 'bird', 'blac', 'blaz', 'brew', 'cell', 'cldc', 'cmd-', 'dang', 'doco', 'eric', 'hipt', 'inno', 'ipaq', 'java', 'jigs', 'kddi', 'keji', 'leno', 'lg-c', 'lg-d', 'lg-g', 'lge-', 'maui', 'maxo', 'midp', 'mits', 'mmef', 'mobi', 'mot-', 'moto', 'mwbp', 'nec-', 'newt', 'noki', 'oper', 'palm', 'pana', 'pant', 'phil', 'play', 'port', 'prox', 'qwap', 'sage', 'sams', 'sany', 'sch-', 'sec-', 'send', 'seri', 'sgh-', 'shar', 'sie-', 'siem', 'smal', 'smar', 'sony', 'sph-', 'symb', 't-mo', 'teli', 'tim-', 'tosh', 'tsm-', 'upg1', 'upsi', 'vk-v', 'voda', 'wap-', 'wapa', 'wapi', 'wapp', 'wapr', 'webc', 'winw', 'winw', 'xda', 'xda-');

        if (in_array($mobile_ua, $mobile_agents)) {
            $is_mobile = 1;
        }

        if (isset($_SERVER['ALL_HTTP'])) {
            if (strpos(strtolower($_SERVER['ALL_HTTP']), 'OperaMini') > 0) {
                $is_mobile = 1;
            }
        }

        if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']), 'windows') > 0) {
            $is_mobile = 0;
        }

        if (preg_match('/iphone/', strtolower($_SERVER['HTTP_USER_AGENT']))) {
            $iphone = 1;
        }

        if (preg_match('/ipad/', strtolower($_SERVER['HTTP_USER_AGENT']))) {
            $ipad = 1;
        }

        return $is_mobile;
    }

}

if (!function_exists('_recursive_array_search')) {
    function _recursive_array_search($needle,$haystack) {
        foreach($haystack as $key=>$value) {
            $current_key=$key;
            if($needle===$value OR (is_array($value) && _recursive_array_search($needle,$value) !== false)) {
                return $current_key;
            }
        }
        return false;
    }
}

if (!function_exists('_array_multi_search')) {

    function _array_multi_search($array, $index, $pattern, $invert = FALSE) {
        $output = array();
        //if(!is_array($array)) return;
        foreach ($array as $i => $arr) {
            // The index must exist and match the pattern
            if (isset($arr[$index]) && (bool) $invert !== (bool) preg_match($pattern, $arr[$index])) {
                $output[$i] = $arr;
            }
        }
        return $output;
    }

}

function sorting() {

    $criteria = func_get_args();
    foreach ($criteria as $index => $criterion) {
        $criteria[$index] = is_array($criterion) ? array_pad($criterion, 3, null) : array($criterion, SORT_ASC, null);
    }

    return function($first, $second) use ($criteria) {
        foreach ($criteria as $criterion) {

            list($column, $sortOrder, $projection) = $criterion;
            $sortOrder = $sortOrder === SORT_DESC ? -1 : 1;


            if ($projection) {
                $lhs = call_user_func($projection, $first[$column]);
                $rhs = call_user_func($projection, $second[$column]);
            } else {
                $lhs = $first[$column];
                $rhs = $second[$column];
            }


            if ($lhs < $rhs) {
                return -1 * $sortOrder;
            } else if ($lhs > $rhs) {
                return 1 * $sortOrder;
            }
        }

        return 0; 
    };
}

function bus_category_string($string){
    global $gbus_Category;
    $CI = & get_instance();
    if($gbus_Category==''){
        $CI->load->model('api_model');
        $gbus_Category = $CI->api_model->getBusCategory();
        $gbus_Category = json_decode($gbus_Category);
    }
    
    
    $temp = array();

        foreach ($gbus_Category->data AS $buscat) {
            $tmp = array();
            foreach ($buscat->categoryList AS $sub) {

                $tmp[$sub->code] = $sub->name;
            }
            $temp[preg_replace('/\s+/', '', $buscat->code)] = $tmp;
        }
        // {assign var=ct value="|"|explode:$bs->bus->categoryCode}
        $cat = explode('|',$string);
        
        if($cat[0]!='' && $cat[1]!='' && $cat[2]!='' && $cat[3]!='' && $cat[4]!=''){
            $val = '';            
            if($temp['Make'][$cat[3]]!='' && strtoupper($temp['Make'][$cat[3]])!='OTHERS' 
                    && strtoupper($temp['Make'][$cat[3]])!='AIRBUS' 
                    && strtoupper($temp['Make'][$cat[3]])!='KING LONG'){
                $make .= $temp['Make'][$cat[3]]." ";
            }
            if($temp['Chasis'][$cat[2]]!='' 
                    && strtoupper($temp['Chasis'][$cat[2]])!='OTHERS'
                    && strtoupper(trim($temp['Chasis'][$cat[2]]))!='LEYLAND'){
                $chasis .= $temp['Chasis'][$cat[2]]." ";
            }
                 
            if($temp['Seattype'][$cat[4]]!='' && strtoupper($temp['Seattype'][$cat[4]])!='OTHERS'){
                $seattype .= $temp['Seattype'][$cat[4]]." ";
            } 
            if($temp['ClimateControl'][$cat[1]]!='' && strtoupper($temp['ClimateControl'][$cat[1]])!='OTHERS'){
                $climate .= $temp['ClimateControl'][$cat[1]]." ";
            }
            
            if($temp['Layout'][$cat[0]]!='' && strtoupper($temp['Layout'][$cat[0]])!='OTHERS'){
                $layout .= "(".$temp['Layout'][$cat[0]].") ";
            }
            
            //$val = $make.$chasis.$climate.$seattype.$layout;
            //if($make!='')
                $val = $make.$chasis.$seattype.$climate.$layout;
            
            return $val;
        }
        return "-";
}

function _get_user_tag_by_code($usercode){
    global $g_active_users;
    $CI = & get_instance();
    if($g_active_users==''){
        $CI->load->model('api_model');
        $g_active_users = $CI->api_model->getUser(array('activeFlagFilter'=>1));
        $g_active_users = json_decode($g_active_users);
    }    
    
    $tags = array();
    foreach ($g_active_users->data AS $user) {
        if($user->code == $usercode) {        
            foreach ($user->userTags AS $tag) {
                array_push($tags, $tag->code);
            }        
        }
    }
    return $tags;
}

function _get_vehicle_location($vehiclecode = ""){
    global $g_active_vehicles;
    $CI = & get_instance();
    if($g_active_vehicles==''){
        $CI->load->model('api_model');
        $get_vehicle = $CI->api_model->getAllVehicle(array());
        $g_active_vehicles = json_decode($get_vehicle);

        $cargo_setting = _get_cargo_settings();
    }    
    
    $locations = array();
    foreach ($g_active_vehicles->data AS $vehicle) {
        
        if ($cargo_setting->transitLocationModelCode == 'STN') { 
            if($vehiclecode == "") {
                $locations[$vehicle->code] = $vehicle->transitStation;
            } else if($vehiclecode!="" && $vehicle->code == $vehiclecode) {        
                $locations[$vehicle->code] = $vehicle->transitStation;   
            } 
        } else if ($cargo_setting->transitLocationModelCode == 'BRCH'){
            if($vehiclecode == "") {
                $locations[$vehicle->code] = $vehicle->transitOrganization;
            } else if($vehiclecode!="" && $vehicle->code == $vehiclecode) {        
                $locations[$vehicle->code] = $vehicle->transitOrganization;   
            } 
        }
    }
    return $locations;
}


if (!function_exists('_array_min')) {
    function _array_min($array) {
        return min($array);
    }
}


if (!function_exists('_bus_category_string')) {
    function _bus_category_string($params, $smarty) {
        return bus_category_string($params['cate_code']);
    }
}

if (!function_exists('_ns_date_format')) {
    function _ns_date_format($date_format) {
        if($date_format == 'Y-m-d')
            $date = '%Y-%m-%d'; 
        else if ($date_format == 'd-m-Y')
            $date = '%d-%m-%Y';
        else if ($date_format == 'e/b/Y')
            $date = '%e/%b/%Y';
        else if ($date_format == 'D')
            $date = '%D';
        else if ($date_format == 'd-b-y')    
            $date = '%d-%b-%y';  
        else 
            $date = '%d-%m-%Y';
        return $date;
    }
}

if (!function_exists('_ns_time_format')) {
    function _ns_time_format($time_format) {
        if($time_format == 12)
            $time = '%l:%M %p'; 
        else 
            $time = '%H:%M';        
        return $time;
    }
}

if (!function_exists('has_action_rights')) {
    global $g_rights;
    function has_action_rights($action) {
        if($g_rights=="") 
            $g_rights = config_item('rights');                
        return (int) $g_rights[$action];
    }
}

if (!function_exists('get_routes_and_stations')) {
    function get_routes_and_stations() {
        $CI = & get_instance(); 
        $CI->load->model('api_model');
        
        $routeDetails = $CI->api_model->getCommerceRoute();
        $routeDetail = json_decode ( $routeDetails );
        $routeDetail->data;

        $stationDetails = $CI->api_model->getCommerceStation();
        $stationDetails = json_decode( $stationDetails );
        $stationDetails = $stationDetails->data;
        $snames = array ();
        $stations = array ();
        foreach ( $stationDetails as $station ) {
            array_push ( $snames, trim( $station->name ) );
            $stations[] = array (
                'name' => $station->name,
                'code' => $station->code 
            );
        }

        @array_multisort ( $snames, SORT_ASC, $stations );
       

        $a_stations = array ();
        foreach ( $stationDetails as $station ) {
            $a_stations[$station->code] = $station->name;
        }

        $a_routes = array ();
        // if(is_array($routes->data)) {
        foreach ( (array)$routeDetail->data as $fromcode => $tocodes ) {
            foreach ( $tocodes as $tocode ) {
                $a_routes[$fromcode] [] = array (
                    'code' => $tocode,
                    'name' => $a_stations [$tocode] 
                );
            }
        }
        return array( $stations, $a_routes);
    }
}

if (!function_exists('get_active_schedules')) {
    function get_active_schedules() {
        $CI = & get_instance(); 
        $CI->load->model('api_model');
        
        $p_key = _get_namespace_id().'_active_schedule';
        if(!$schedules = $CI->rediscache->get($p_key)) {
            $schedules = $CI->api_model->getScheduleByType(array('type' => 'none'));
            $CI->rediscache->set($p_key, $schedules, 3600); //  1 hr
        }        
        $schedules = json_decode($schedules);
        $schedules = $schedules->data;
        $schedules_list = array();
        foreach ((array)$schedules AS $key => $list) {
            $no_stages = count($list->stageList);
            $startStation = $list->stageList[0]->fromStation->name;
            $startTime = gmdate("h:i A", ($list->stageList[0]->fromStation->dateTime * 60));
            
            $endStation = $list->stageList[$no_stages - 1]->fromStation->name;
            $hm = $list->stageList[$no_stages - 1]->fromStation->dateTime;
            $endTime = gmdate("h:i A", ($hm * 60));
                    
            $name = $list->name.' ('.$list->serviceNumber.') '.' | '.$startStation.' '.$startTime.' | '.$endStation.' '.$endTime.' | '.$list->bus->busType.' ( '.$list->bus->seatCount.' )';
            $tmp = array(
                'name' => $name,
                'code' => $list->code,
            );
           $schedules_list[] = $tmp; 
        }
        
        $p_key = _get_namespace_id().'_expired_schedule';
        if(!$schedules = $CI->rediscache->get($p_key)) {
            $schedules = $CI->api_model->getScheduleByType(array('type' => 'expire'));
            $CI->rediscache->set($p_key, $schedules, 28800);    //  8hours
        }        
        
        $schedules = json_decode($schedules);
        $schedules = $schedules->data;       
        foreach ((array)$schedules AS $key => $list) {
            $no_stages = count($list->stageList);
            $startStation = $list->stageList[0]->fromStation->name;
            $startTime = gmdate("h:i A", ($list->stageList[0]->fromStation->dateTime * 60));
            
            $endStation = $list->stageList[$no_stages - 1]->fromStation->name;
            $hm = $list->stageList[$no_stages - 1]->fromStation->dateTime;
            $endTime = gmdate("h:i A", ($hm * 60));
                    
            $name = $list->name.' | '.$startStation.' '.$startTime.' | '.$endStation.' '.$endTime.' | '.$list->bus->busType.' ( '.$list->bus->seatCount.' ) ( Expired )';
            $tmp = array(
                'name' => $name,
                'code' => $list->code,
            );
           $schedules_list[] = $tmp; 
        }
        
        return $schedules_list;
    }
}

if (!function_exists('_get_trips_by_date')) {
    function _get_trips_by_date($tripDate) {
        $CI = & get_instance(); 
        $CI->load->model('api_model');
        
        $tripList = $CI->api_model->getScheduleTrip(array('tripDate' => $tripDate));
        $tripList = json_decode($tripList);
        $tripList = $tripList->data;        
        
        //  collect missed spl trips
        $datediff = time() - strtotime($tripDate);        
        $datediff = floor($datediff / (60 * 60 * 24));
        if( $datediff > 0 ) {   
            $tmp = $CI->api_model->getScheduleTripFromHistory(array('tripDate' => $tripDate));
            $tmptriphisList = json_decode($tmp);           
            $triphisList = json_decode($tmptriphisList->data); 
            
            $acttrip = array();
            foreach($tripList as $trip) {
                $acttrip[$trip->tripCode] = 1;
            }        
            
            $histrip = array();
            foreach($triphisList as $trip) {
                if( !isset($acttrip[$trip->tripCode]) ) {
                    $histrip[] = $trip;
                }
            }
        }
        
        //  grouping based on category
        $tmp = array();
        foreach($tripList as $trip) {
            $trip->fromStationTimestamp = strtotime($trip->stageList[0]->fromStation->dateTime);
            if($trip->schedule->category->name=="") $trip->schedule->category->name = 'Others';
            $tmp[$trip->schedule->category->name][] = $trip;
        }
        ksort($tmp);
        
        //  sort by departure time within a tag
        $sorted = array();
        foreach($tmp as $key=>$trip){
           usort($trip, '_orderby_time');
           $sorted[$key] = $trip;
        } 
        
        //  uppend missed spl trips
        if(count($histrip) > 0) {
            usort($histrip, '_orderby_time');
            $sorted['[ Others ]'] = $histrip;
        }
        return $sorted;
    }
}

if (!function_exists('_log_login_track')) {
    function _log_login_track($token, $lat='', $long='') {   
        
        $CI = &get_instance(); 
        $CI->load->model('api_model');
        
        $ip_host = _get_user_ip();        
        
        if($lat=="" && $long=="") {
            $lat = 0;
            $long = 0;
//            $j = @file_get_contents( 'http://freegeoip.net/json/'._get_user_ip() );
//            $ipapi = json_decode($j);
//            if($ipapi->latitude!="" && $ipapi->longitude!="") {
//               $lat = $ipapi->latitude;
//               $long = $ipapi->longitude;
//            }    
        }
        
        $param = array(
            'authtoken' => $token,
            'longitude' => $long,
            'latitude'  => $lat,
            'ipAddress' => $ip_host
        ); 
        
        $CI->api_model->updateLoginLocation($param);      
    }
}

if (!function_exists('get_active_group_and_users')) {
    function get_active_group_and_users() {
        $CI = & get_instance(); 
        $CI->load->model('api_model');
        
        $loginUserCode = _get_user_id();
        
        $groups = $CI->api_model->getGroup(array());
        $groups = json_decode($groups);
        
        $usr = $CI->api_model->getUser();                
        $usr = json_decode($usr);
        
        $list = array();  
        $list['groups'] = $groups->data;
        foreach ($usr->data AS $users) {
            if ($users->code == $loginUserCode) {
                $list['loginUser'] = $users;
            }

            if($users->activeFlag == 1){  
                $list['users'][] = array(
                    'code' => $users->code,
                    'name' => $users->name,
                    'groupcode' => $users->group->code,
                    'organization' => $users->organization,
                    'activeFlag' => $users->activeFlag,                   
                    'aliasCode' => $users->aliasCode                    
                );
            }
            
            $list['groupusers'][$users->group->name][] = array(
                'code' => $users->code,
                'name' => $users->name,
                'activeFlag' => $users->activeFlag,
                'aliasCode' => $users->aliasCode
            );
        }
        /*$usr = $CI->api_model->getRechargeUsers();
        $usr = json_decode($usr);
        $list = array();  
        $list['groups'] = $groups->data;
        foreach ($usr->data AS $users) {
            $list['users'][] = array(
                'code' => $users->code,
                'name' => $users->name,
                'groupcode' => $users->group->code
            );
        }*/
       return $list; 
    }
}

if (!function_exists('get_offline_users')) {
    function _get_offline_users() {
        $CI = & get_instance();
        $CI->load->model('api_model');
        
        $usr = $CI->api_model->getUser();           
        $usr = json_decode($usr);       
        
        $t = array();
        foreach($usr->data as $item) {
            foreach($item->userTags as $tags) {
                if($tags->code == "OFFUSR")
                   $t[] =  $item;               
            };
        }       
        return $t;
    }
}

if (!function_exists('_get_cargo_settings')) {
    function _get_cargo_settings() {
        $CI = & get_instance();
        $CI->load->model('api_model');
        
        $settings = $CI->api_model->getCargoSettings(array('authtoken' => _get_user_hash()));
        $settings = json_decode($settings);
        $settings = $settings->data ?: new stdClass;

        $settings->custom = new stdClass;
        if ($settings->userAccountModel->code == 'DINV') {
            $settings->custom->skipCustomerMobile = true;
        }
        return $settings;
    }
}

if (!function_exists('_uc_name')) {
    function _uc_name($name) {
        $name =ucwords(strtolower($name));
        foreach (array('-', '\'') as $delimiter) {
          if (strpos($name, $delimiter)!==false) {
            $name =implode($delimiter, array_map('ucfirst', explode($delimiter, $name)));
          }
        }
        return $name;
    }
}

if (!function_exists('_array_orderby')) {
    function _array_orderby() {
        $args = func_get_args();
        $data = array_shift($args);
        foreach ($args as $n => $field) {
            if (is_string($field)) {
                $tmp = array();
                foreach ($data as $key => $row)
                    $tmp[$key] = $row[$field];
                $args[$n] = $tmp;
                }
        }
        $args[] = &$data;
        call_user_func_array('array_multisort', $args);
        return array_pop($args);
    }
}

if (!function_exists('_orderby_time')) {
    function _orderby_time($a, $b) {
        return strcmp($a->fromStationTimestamp, $b->fromStationTimestamp);
    }
}

if (!function_exists('_google_shorten_url')) {
    function _google_shorten_url($longUrl) {
        // Get API key from : http://code.google.com/apis/console/
        $apiKey = 'AIzaSyBka1c5xHw4fhXWhdCYoswmocCSJ1wXqLk';

        $postData = array('longUrl' => $longUrl);
        $jsonData = json_encode($postData);

        $curlObj = curl_init();

        curl_setopt($curlObj, CURLOPT_URL, 'https://www.googleapis.com/urlshortener/v1/url?key='.$apiKey);
        curl_setopt($curlObj, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curlObj, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($curlObj, CURLOPT_HEADER, 0);
        curl_setopt($curlObj, CURLOPT_HTTPHEADER, array('Content-type:application/json'));
        curl_setopt($curlObj, CURLOPT_POST, 1);
        curl_setopt($curlObj, CURLOPT_POSTFIELDS, $jsonData);

        $response = curl_exec($curlObj);

        // Change the response json string to object
        $json = json_decode($response);

        curl_close($curlObj);
        return $json->id;
    }
}

if (!function_exists('_send_mail')) {
    function _send_mail($method, $postData) {
        $jsonData = json_encode($postData);
        
        $curlObj = curl_init();

        curl_setopt($curlObj, CURLOPT_URL, config_item('mailer_url').'?method='.$method);
        curl_setopt($curlObj, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curlObj, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($curlObj, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(                                                                          
            'Content-Type: application/json',                                                                                
            'Content-Length: ' . strlen($data_string))                                                                       
        );  
        curl_setopt($curlObj, CURLOPT_POST, 1);
        curl_setopt($curlObj, CURLOPT_POSTFIELDS, $jsonData);

        $response = curl_exec($curlObj);

        // Change the response json string to object
        $json = json_decode($response);

        curl_close($curlObj);
        return $json;
    }
}

if (!function_exists('inr_format')) {

    function inr_format($amount = 0) {
        $formatter = new NumberFormatter($locale = 'en_IN', NumberFormatter::DECIMAL);
        $formatter->setAttribute(\NumberFormatter::MIN_FRACTION_DIGITS, 2);
        return $formatter->format($amount);
    }

}

if (!function_exists('_is_super_namespace')) {
    function _is_super_namespace($ns='') {
        if(trim($ns)=="") {
            return 0;
        }
        $super_ns = config_item('super_namespace');
        if (in_array($ns, $super_ns)) {
            return 1;
        } else {
            return 0;
        }
    }
}

if (!function_exists('_get_gallery_images')) {

    function _get_gallery_images($folder, $code = '') {
        $basepath = FCPATH;
        $location = config_item('gallery_loc');
        $namespace = _get_namespace_id();

        $path = "{$basepath}/{$location}/{$namespace}/{$folder}/";

        $allfiles = scandir($path);
        $code = strtolower($code) . '_';
        
        rsort($allfiles);

        $files = array();
        foreach ($allfiles as $val) {
            if(strpos($val, $code) === 0) {
                $version = filemtime("{$basepath}/{$location}/{$namespace}/{$folder}/{$val}");
                $filetype = substr($val, strlen($code), strpos($val, '.') - strlen($code));
                
                $obj = (object) array();
                $obj->file_name = $val;
                $obj->file_type = $filetype;
                $obj->folder_path = "{$location}/{$namespace}/{$folder}/";
                $obj->image_url = "{$location}/{$namespace}/{$folder}/{$val}?{$version}";
                $files[$filetype] = $obj;
            }
        }

        return $files;
    }

}

if (!function_exists('_delete_gallery_images')) {

    function _delete_gallery_images($path, $name) {
        $basepath = FCPATH;

        $status = unlink("{$basepath}/{$path}/{$name}") ? 1 : 0;

        return json_encode(array('status' => $status));
    }

}

if (!function_exists('_upload_gallery_images')) {

    function _upload_gallery_images($param) {
        $CI = & get_instance();
        $CI->load->library('thumbnail');
        
        $basepath = FCPATH;
        $location = config_item('gallery_loc');
        $namespace = _get_namespace_id();

        $img_name = $param['files']['file']['name'];
        if (!$img_name) {
            return json_encode(array('status' => 0));
        }

        $to_folder = "{$basepath}/{$location}/{$namespace}/{$param['folder']}/";
        if (!is_dir($to_folder)) {
            @mkdir($to_folder, 0777, true);
            @chmod($to_folder, 0777);
        }
        
        $extn = pathinfo($img_name, PATHINFO_EXTENSION);
        $code = strtolower($param['code']);
        $name = strtolower($param['name']);
        $file_name = "{$code}_{$name}.{$extn}";
        $to_name = $to_folder . $file_name;

        if (move_uploaded_file($param['files']['file']['tmp_name'], $to_name)) {

            $CI->thumbnail->init($to_name, 800, 800, 0, 100);
            $CI->thumbnail->save($to_name);

            @chmod($to_folder, 0777);
            @chmod($to_name, 0777);
        } else {
            return json_encode(array('status' => 0));
        }
        
        return json_encode(array('status' => 1));
    }

}

if (!function_exists('_cargo_payment_status_badge')) {

    function _cargo_payment_status_badge($payment_status_code) {
        $status = config_item('cargo_payment_status');
        $badges = config_item('cargo_payment_status_badge');
        // return lang('OATP');
        $payment_name = $status[$payment_status_code];
        if($payment_status_code == 'OATP'){
            $payment_name = lang('OATP');
        }
        if($payment_status_code == 'INP'){
            $payment_name = lang('INP');
        }
        return "<label class='badge {$badges[$payment_status_code]}'>{$payment_name}</label>";
    }

}

if (!function_exists('amount_in_words')) {

    function amount_in_words($number) {
        $decimal = round($number - ($no = floor($number)), 2) * 100;
        $decimal_part = $decimal;
        $hundred = null;
        $hundreds = null;
        $digits_length = strlen($no);
        $decimal_length = strlen($decimal);
        $i = 0;
        $str = array();
        $str2 = array();
        $words = array(0 => '', 1 => 'one', 2 => 'two',
            3 => 'three', 4 => 'four', 5 => 'five', 6 => 'six',
            7 => 'seven', 8 => 'eight', 9 => 'nine',
            10 => 'ten', 11 => 'eleven', 12 => 'twelve',
            13 => 'thirteen', 14 => 'fourteen', 15 => 'fifteen',
            16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen',
            19 => 'nineteen', 20 => 'twenty', 30 => 'thirty',
            40 => 'forty', 50 => 'fifty', 60 => 'sixty',
            70 => 'seventy', 80 => 'eighty', 90 => 'ninety');
        $digits = array('', 'hundred', 'thousand', 'lakh', 'crore');

        while ($i < $digits_length) {
            $divider = ($i == 2) ? 10 : 100;
            $number = floor($no % $divider);
            $no = floor($no / $divider);
            $i += $divider == 10 ? 1 : 2;
            if ($number) {
                $plural = (($counter = count($str)) && $number > 9) ? 's' : null;
                $hundred = ($counter == 1 && $str[0]) ? ' and ' : null;
                $str [] = ($number < 21) ? $words[$number] . ' ' . $digits[$counter] . $plural . ' ' . $hundred : $words[floor($number / 10) * 10] . ' ' . $words[$number % 10] . ' ' . $digits[$counter] . $plural . ' ' . $hundred;
            } else
                $str[] = null;
        }

        $d = 0;
        while ($d < $decimal_length) {
            $divider = ($d == 2) ? 10 : 100;
            $decimal_number = floor($decimal % $divider);
            $decimal = floor($decimal / $divider);
            $d += $divider == 10 ? 1 : 2;
            if ($decimal_number) {
                $plurals = (($counter = count($str2)) && $decimal_number > 9) ? 's' : null;
                $hundreds = ($counter == 1 && $str2[0]) ? ' and ' : null;
                @$str2 [] = ($decimal_number < 21) ? $words[$decimal_number] . ' ' . $digits[$decimal_number] . $plural . ' ' . $hundred : $words[floor($decimal_number / 10) * 10] . ' ' . $words[$decimal_number % 10] . ' ' . $digits[$counter] . $plural . ' ' . $hundred;
            } else
                $str2[] = null;
        }

        $Rupees = implode('', array_reverse($str));
        $paise = implode('', array_reverse($str2));
        $paise = ($decimal_part > 0) ? $paise . ' Paise' : '';
        return ($Rupees ? $Rupees . 'Rupees ' : '') . $paise;
    }

}

if (!function_exists('num_to_words')) {

    function num_to_words($num) {
        $str = amount_in_words($num);
        $final_str =  str_replace('Rupees','',$str);
        return str_replace('Paise','',$final_str);
    }

}

if (!function_exists('_gcno_format')) {

    function _gcno_format($param) {
        $status = config_item('cargo_short_payment_status');
        $year = date('y');

        $from = $param['fromOrgShortCode'] ?: 'NA';
        $to = $param['toOrgShortCode'] ?: 'NA';
        $type = $status[$param['payType']];
        $lrno = $param['lrCode'];

        return "{$from}-{$to}-{$type}-{$year}-{$lrno}";
    }

}

if (!function_exists('_parse_other_charges')) {

    function _parse_other_charges($charges_string = '') {
        $charges_list = explode(',', $charges_string);

        return array_reduce($charges_list, function ($acc, $charge) {
            list($key, $val) = explode(':', $charge);
            $acc[$key] = $val;
            return $acc;
        }, []);
    }
}

if (!function_exists('_camelcase_to_titlecase')) {

    function _camelcase_to_titlecase($snake_string = '') {
        return ucfirst(preg_replace('/(?<!\ )[A-Z]/', ' $0', $snake_string));
    }
}

if (!function_exists('_snakecase_to_titlecase')) {

    function _snakecase_to_titlecase($snake_string = '') {
        return ucwords(str_replace('_', ' ', $snake_string));
    }
}

if (!function_exists('min_to_time')) {
    function min_to_time($seconds, $returnFormat = 'h:i A') {
        $date = new DateTime(gmdate('H:i', $seconds));

        return $date->format($returnFormat);
    }
}

if (!function_exists('hours_range')) {
    function hours_range($fromSeconds = 0, $toSeconds = 86400, $intervalSeconds = 3600, $returnFormat = 'h:i A') {
        $times = array();
    
        foreach (range($fromSeconds, $toSeconds, $intervalSeconds) as $increment) {    
            $date = new DateTime(gmdate('H:i', $increment));

            $times[(string) $increment] = $date->format($returnFormat);
        }
    
        return $times;
    }
}

if (!function_exists('isNotNull')) {

    function isNotNull($value) {
        switch ($value) {
            case null:
            case false:
            case 'false':
            case '':
            case 'NA':
            case 'NULL':
                return false;
            default:
                return true;
        }
    }

}

if (!function_exists('iflang')) {

    function iflang($line, $id = '') {
        $key = strtolower(trim($line));

        return lang($key, $id) ?: $line;
    }

}

/**
 * Number of days between two dates.
 *
 * @param date $dt1    First date
 * @param date $dt2    Second date
 * @return int
 */
if (!function_exists('daysBetween')) {
    function daysBetween($dt1, $dt2)
    {
        return date_diff(
            date_create($dt2),
            date_create($dt1)
        )->format('%a');
    }
}

if (!function_exists('hoursBetween')) {
    function hoursBetween($dt1, $dt2)
    {
        return date_diff(
            date_create($dt2),
            date_create($dt1)
        )->format('%H:%I');
    }
}


if (!function_exists('percentageOf')) {
    function percentageOf($percent, $value)
    {
        return $percent / 100 * $value;
    }
}

if (!function_exists('newline')) {
    function newline()  {
        return "\n";
    }
}

if (!function_exists('space')) {
    function space($n)  {
        $t = '';
        for($i=0; $i<$n; $i++){
            $t .= " ";
        }
        return $t;
    }
}


if (!function_exists('clean_string')) {

    function clean_string($string)
    {
        return preg_replace('/[^a-zA-Z0-9-]/', '', strtolower($string));
    }

}

if (!function_exists('mask_mobileno')) {

    function mask_mobileno($mobileno = '') 
    {
        if (has_action_rights('EBL-MOB-MASK')) {
            return preg_replace('/\d{5}(?=\d{4}\s*$)/', 'xxxxx', clean_string($mobileno));
        }
        return $mobileno;
    }

}

if (!function_exists('sigma')) {

    function sigma($value = 0, &$variable = 0) {
        $variable += $value;
        return $value;
    }

}

if (!function_exists('partition_submenus')) {

    function partition_submenus($menus = [], $submenus = [], $column = 2) {
        $chunk = [];
        $index = 0;

        $count = 0;
        foreach ($submenus as $menu) {
            $count += is_array($menus[$menu['code']]) ? count($menus[$menu['code']]) + 1 : 1;
        }

        $range = max(12, min(16, ceil($count / $column)));

        $partition = function ($param) use ($menus, &$chunk, $range, &$index, &$partition) {
            foreach ($param as $menu) {
                $menucode = $menu['code'];
                $chunk[$index][] = $menu;

                if (is_array($menus[$menucode]) && count($menus[$menucode]) > 0) {
                    $partition($menus[$menucode]);
                }

                if (count($chunk[$index]) > $range) {
                    $index++;
                }
            } 
        };

        $partition($submenus);

        return $chunk;
    }

}

if (!function_exists('logger')) {

    function logger($file, $param = array(), $withTime = false) {
        try {

            $txt = sprintf("%s%'-80s", chr(10), '');
            if($withTime) {
                $param = array('DateTime' => date('d-m-Y H:m:s')) + $param;
            }
            foreach($param as $key => $val) {
                $txt .= sprintf("%s%-8s : %s", chr(10), $key, (is_string($val) ? $val : json_encode($val)));
            }
            file_put_contents(FCPATH. $file, $txt, FILE_APPEND);
        } catch (Exception $e) { }
    }

}

if (!function_exists('comma_split')) {

	function comma_split($subject)
	{
		return preg_split("/(\s*,\s*)+/", trim($subject, " \t\n\r\0\x0B,"));
	}

}

if (!function_exists('_user_assigned_branches')) {
    function _user_assigned_branches() {
        if (!_get_user_hash()) {
            return [];
        }

        $CI = &get_instance(); 
        $CI->load->model('api_model');

        $p_key = 'user_assigned_branches:' . _get_user_id();
        if(!$branches = $CI->rediscache->get($p_key)) {
            $branches = $CI->api_model->cargoUserBranches(array(
                'userCode' => _get_user_id()
            ));
            $branches = json_decode($branches);
            $branches->data = $branches->data ?? [];
            if ($branches->status == 1) {
                usort($branches->data, function($a, $b) {
                    return strcmp($a->name, $b->name);
                });
                $CI->rediscache->set($p_key, json_encode($branches), 3600); //  1 hr
            }
        } else {
            $branches = json_decode($branches);
            $branches->data = $branches->data ?? [];
        }

        return $branches->data;
    }
}

if (!function_exists('set_user_session_data')) {

	function set_user_session_data($profile)
	{
        $CI = & get_instance();
        
        if (empty($profile)) {
            $CI->load->model('api_model');
            
            $usr_pro = $CI->api_model->getUserProfile(array('authtoken' => $CI->session->userdata('temp_token')));
            $profile = json_decode($usr_pro);
        }

        $namespaceProfile = array(
            'paymentReceiptAcknowledgeProcess' => $profile->data->namespace->namespaceProfile->paymentReceiptAcknowledgeProcess
        );

        // Session variables 
        $data = array(
            'user_id' => $profile->data->code,
            'native_user_id' => $profile->data->code,
            'native_user_name' => $profile->data->name,
            'user_email' => $profile->data->email,
            'user_name' => $profile->data->name,
            'mobile_verified' => $profile->data->mobileVerifiedFlag,
            'role_name' => $profile->data->role->name,
            'role_id' => $profile->data->role->code,
            'group_id' => $profile->data->group->code,
            'namespace_id' => $profile->data->namespace->code,
            'namespace_name' => $profile->data->namespace->name,
            'namespace_mode' => $profile->data->namespace->mode,
            'native_namespace_code' => $profile->data->nativeNamespaceCode,
            'user_hash' => $CI->session->userdata('temp_token'),
            'date_format' => $profile->data->namespace->namespaceProfile->dateFormat,
            'time_format' => $profile->data->namespace->namespaceProfile->timeFormat,
            'balance'=> number_format($profile->data->currnetBalance,2),
            'org_code' => $profile->data->organization->code,
            'org_name' => $profile->data->organization->name,            
            'org_station_code' => $profile->data->organization->station->code,
            'org_station_name' => $profile->data->organization->station->name,
            'ns_domain_url' => $profile->data->namespace->namespaceProfile->domainURL,
            'instant_cancellation_minutes' => $profile->data->namespace->namespaceProfile->instantCancellationMinitues,
            'ewaybill_vendor_code' => $profile->data->namespace->namespaceProfile->ewayBillVendorCode,
            'sms_notification_flag_code' => $profile->data->namespace->namespaceProfile->smsNotificationFlagCode,
            'namespace_profile' => $namespaceProfile,
            'product' => 'cargo',
        );

        $CI->session->unset_userdata('temp_token');
        $CI->session->unset_userdata('passwordExpired');

        return $data;
		
	}

}

if (!function_exists('is_password_expired')) {

	function is_password_expired($passwordUpdateAt)
	{
		if (!isNotNull($passwordUpdateAt)) return false;
        $data = FALSE;

		$datetimenow = new DateTime();
		$passwordUpdateAt = new DateTime($passwordUpdateAt);

        $interval = $passwordUpdateAt->diff($datetimenow);

        if ($interval->format('%R%a days') > 30) {
            $data = TRUE;
        }
        
        return $data;
	}

}

if (!function_exists('time_elapsed_string')) {

	function time_elapsed_string($ptime){
        if($ptime){
            $etime = time() - strtotime($ptime);
            if ($etime < 1)
            {
                return '0 seconds';
            }

            $a = array( 365 * 24 * 60 * 60  =>  'year',
                        30 * 24 * 60 * 60  =>  'month',
                            24 * 60 * 60  =>  'day',
                                60 * 60  =>  'hour',
                                        60  =>  'minute',
                                        1  =>  'second'
                        );
            $a_plural = array( 'year'   => 'years',
                            'month'  => 'months',
                            'day'    => 'days',
                            'hour'   => 'hours',
                            'minute' => 'minutes',
                            'second' => 'seconds'
                        );

            foreach ($a as $secs => $str)
            {
                $d = $etime / $secs;
                if ($d >= 1)
                {
                    $r = round($d);
                    return $r . ' ' . ($r > 1 ? $a_plural[$str] : $str) . ' ago';
                }
            }
        }else{
            return '-';
        }
    }
}

if (!function_exists('calcUserCommission')) {
    function calcUserCommission($typeCode, $value, $amount, $count)
    {
        if ($typeCode == 'PER') {
            return percentageOf($value, $amount);
        }
        if ($typeCode == 'FLT') {
            return $value * $count;
        }
    }
}

if (!function_exists('timeToMinutes')) {
    function timeToMinutes($time)
    {
        if ($time) {
            $timesplit=explode(':',$time);
            if ($timesplit[2] > 0) {
                $min=($timesplit[0]*60) + ($timesplit[1]) + (int)($timesplit[2]/60);
            } else {
                $min=($timesplit[0]*60) + ($timesplit[1]);
            }
            return $min;
        }
    }
}

if (!function_exists('addMinutesToDateTime')) {
    function addMinutesToDateTime($minutes, $dateTime, $format)
    {
        if ($minutes && $dateTime) {
            $date = strtotime("+{$minutes} minute", strtotime($dateTime));
            echo date($format, $date);
        }
    }
}

if (!function_exists('amountToRupeesPaise')) {

    function amountToRupeesPaise($amt, $format) {
        $rupees = (explode(".",$amt));
        if ($format == 'RUPEES') {
            return $rupees[0];
        } else if ($format == 'PAISE') {
            return $rupees[1] ?: '00';
        }
    }

}

if (!function_exists('hoursTominutes')) {

    function hoursTominutes($hours) {
        $t = explode(":", $hours);
        $h = $t[0];
        if (isset($t[1])) {
            $m = $t[1];
        } else {
            $m = "00";
        }
        $mm = ($h * 60) + $m;
        return $mm;
    }

}

//for Nested Grouping
if (!function_exists('array_group_by')) {
	function array_group_by(array $array, $key)
	{
		if (!is_string($key) && !is_int($key) && !is_float($key) && !is_callable($key) ) {
			trigger_error('array_group_by(): The key should be a string, an integer, or a callback', E_USER_ERROR);
			return null;
		}

		$func = (!is_string($key) && is_callable($key) ? $key : null);
		$_key = $key;

		$grouped = [];
		foreach ($array as $value) {
			$key = null;

			if (is_callable($func)) {
				$key = call_user_func($func, $value);
			} elseif (is_object($value) && property_exists($value, $_key)) {
				$key = $value->{$_key};
			} elseif (isset($value[$_key])) {
				$key = $value[$_key];
			}

			if ($key === null) {
				continue;
			}

			$grouped[$key][] = $value;
		}

		if (func_num_args() > 2) {
			$args = func_get_args();

			foreach ($grouped as $key => $value) {
				$params = array_merge([ $value ], array_slice($args, 2, func_num_args()));
				$grouped[$key] = call_user_func_array('array_group_by', $params);
			}
		}

		return $grouped;
	}

}

//for print formatted array
if(!function_exists('dd')){
    function dd($params){
        echo '<pre>';print_r($params); echo '</pre>';exit;
    }
}
if(!function_exists('dd_json')){
    function dd_json($params){
        $pretty_data = json_encode($params, JSON_PRETTY_PRINT); 
        echo "<pre>" . $pretty_data . "<pre/>"; 
    }
}

if (!function_exists('_get_namespace_settings')) {
    function _get_namespace_settings() {
        $CI = &get_instance();
        $CI->load->model('api_model');

        $settings = $CI->api_model->getNamespaceProfile(array('authtoken' => _get_user_hash()));
        $settings = json_decode($settings);
        $settings = $settings->data ?: new stdClass;
        return $settings;
    }
}

if(!function_exists('remove_duplicateKeys')){
    function remove_duplicateKeys($key,$data){

        $_data = array();
        foreach ($data as $v) {
          if (isset($_data[$v[$key]])) {
            continue;
          }
          $_data[$v[$key]] = $v;
        }
        $data = array_values($_data);
        return $data;
        }
}
if (!function_exists('_namespace_nav_logo_change_')) {
    function _namespace_nav_logo_change_()
    {
        $namespace_setting = _get_namespace_settings();
        $nameSpace = $namespace_setting->name;
        $primaryColor = $namespace_setting->namespaceProfile->primaryColor;
        $secondaryColor = $namespace_setting->namespaceProfile->secondaryColor;
        $fontSize = $namespace_setting->namespaceProfile->fontSize;
        $domainURL = $namespace_setting->namespaceProfile->domainURL;
        return json_encode(array('nameSpace' => $nameSpace, 'primaryColor' => $primaryColor, 'secondaryColor' => $secondaryColor, 'fontSize' => $fontSize, 'domainURL' => $domainURL));
    }
}

/* End of file common_helper.php */
/* Location: ./system/helpers/common_helper.php */