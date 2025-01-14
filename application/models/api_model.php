<?php

define('NSCODE', _get_namespace_id());

class api_model extends CI_Model {

    const REDIS_DURATION = 28800; // 8 hours
    const REDIS_CUSTOMER = NSCODE . '_cargo_customer';
    const REDIS_DRIVER = NSCODE . '_cargo_driver_act';
    const REDIS_GROUP = NSCODE . '_cargo_user_group';
    const REDIS_ITEM = NSCODE . '_cargo_items';
    const REDIS_REMARKS = NSCODE . '_cargo_remarks';
    const REDIS_CBREMARKS = NSCODE . '_cargo_booking_remarks';
    const REDIS_CDREMARKS = NSCODE . '_cargo_delivery_remarks';
    const REDIS_STATIONS = NSCODE . '_cargo_stations';
    const REDIS_VEHICLE = NSCODE . '_cargo_vehicle';
    const REDIS_VENDOR = NSCODE . '_cargo_vendor';
    const REDIS_BRANCHES = NSCODE . '_cargo_branch';
    const REDIS_CARGOSETTINGS = NSCODE . '_cargo_settings';
    const REDIS_STATIONCUSTOMER = NSCODE . '_station_customers_v6';
    const REDIS_SUBS_INVOICE = NSCODE . '_subscription_invoice';

    function __construct() {
        $this->_namespace_id = _get_namespace_id();
        $this->_user_hash = _get_user_hash();
    }

    /* Verify login & get user auth token */

    function getAuthToken($param = array()) {
        return $this->_getJson('post', config_item('api_get_auth_token'), $param);
    }

    function verifyAuthToken($param = array()) {
        $url = 'auth/' . $this->_user_hash . config_item('api_auth_token_verify');
        return $this->_getJson('post', $url, $param);
    }
    
    function verifyAuthPassword($param = array()) {
        $url = 'auth/'.$param ['authtoken'].'/verify/password?password='.urlencode($param ['password']);
        return $this->_getJson('post', $url, '');
    }
    
    function updateLoginLocation($param = array()) {
        $url = 'auth/'.$param ['authtoken'].'/session/audit/update';
        unset($param['authtoken']);
        $param = json_encode($param);
        
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getUserProfile($param = array()) {
        $url = '/' . $param ['authtoken'] . config_item('api_get_user_profile');
        return $this->_getJson('get', $url, $param);
    }

    function getCargoRecentTransaction($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/payment/receipt/' . $param['userCode'] . '/recent/transaction';
        return $this->_getJson('get', $url, $param);
    }
    /* Get user information from auth token */

    function getUserInfo($param = array()) {
        return $this->_getJson('get', config_item('api_get_auth_token'), $param);
    }

    function getStationsByState($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_station') . '/' . $param ['statecode'] . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function updateStation($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_station');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getAllStates($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_all_states');
        return $this->_getJson('get', $url, $param);
    }

    function getStationPointsByStation($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_station_points') . '/' . $param ['stationcode'];
        return $this->_getJson('get', $url, $param);
    }

    function updateStationPoint($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_station_point');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    

    function getRoutes($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_routes') . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function updateRoutesDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_routes');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getAmenities($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_amenities') . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function updateAmenitiesDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_amenties');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateNamespaceDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_namespace');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getGroup($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_Group') . '?activeFlag=' . $param['activeFlag'];
        if ($param['activeFlag'] == -1) {
            return $this->_getJson('get', $url, $param);
        }
        if( !$json = $this->rediscache->get(self::REDIS_GROUP)) {
            $json = $this->_getJson('get', $url, $param);
            $this->rediscache->set(self::REDIS_GROUP, $json, self::REDIS_DURATION);
        }
        return $json;
    }

    function updateGroupDetails($param = array()) {
        $this->rediscache->delete(self::REDIS_GROUP);

        $url = '/' . $this->_user_hash . config_item('api_update_Group');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getNamespaceStation($param = array()) {
        if( !$json = $this->rediscache->get(self::REDIS_STATIONS)) {
            $url = '/' . $this->_user_hash . config_item('api_get_station_namespace');
            $param = json_encode($param);
            $json = $this->_getJson('post', $url, $param, array(
                        'Content-Type' => 'application/json'
                    ));
            $this->rediscache->set(self::REDIS_STATIONS, $json, self::REDIS_DURATION);
        }
        return $json;
    }

    function getAllStation($param = array()) {
        $url = '/' . $this->_user_hash . '/stations';
        return $this->_getJson('get', $url, $param);
    }

    function getNamespaceStationPoint($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_stationpoints_namespace');
        return $this->_getJson('get', $url, $param);
    }

    function getAllNamespaceStation($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_station_namespace');
        // $param = json_encode($param);
        return $this->_getJson('post', $url, $param);
    }

    function updateNamespaceStation($param = array()) {
        $this->rediscache->delete(self::REDIS_STATIONS);

        $url = '/' . $this->_user_hash . config_item('api_update_station_namespace');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateNamespaceStationPoint($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_stationpoints_namespace');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    // bus activities
    function getBusCategory($param = array()) {        
        $p_key = 'allns_bus_category';
        if( !$json = $this->rediscache->get($p_key)) {
            $url = '/' . $this->_user_hash . config_item('api_get_bus_category');
            $json = $this->_getJson('get', $url, $param);
            $this->rediscache->set($p_key, $json, 43200);    //  12hours
        }        
        return $json;
    }
    
    function getBusSeatType($param = array()) {
        $p_key = 'allns_bus_seattype';
        if( !$json = $this->rediscache->get($p_key)) {
            $url = '/' . $this->_user_hash . config_item('api_get_bus_seattype');
            $json = $this->_getJson('get', $url, $param);
            $this->rediscache->set($p_key, $json, 43200);    //  12hours
        }        
        return $json;
    }

    function getBuses($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_buses') . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function getBusbyCode($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_buses') . '/' . $param ['buscode'];
        return $this->_getJson('get', $url);
    }

    function getOrganization($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_organization') . '?activeFlag=' . $param['activeFlagFilter'];
        if ($param['activeFlagFilter'] == -1) {
            return $this->_getJson('get', $url);
        }
        if( !$json = $this->rediscache->get(self::REDIS_BRANCHES)) {
            $json = $this->_getJson('get', $url);
            $result = json_decode($json);
            if ($result->status != 1) {
                return $json;
            }
            $this->rediscache->set(self::REDIS_BRANCHES, $json, self::REDIS_DURATION);
        }
        return $json;
    }

    function updateOrganizationDetails($param = array()) {
        $this->rediscache->delete(self::REDIS_BRANCHES);
        $c_key = _get_namespace_id().'/cargo/organization/booking';
        $isDelited = $this->rediscache->delete($c_key);

        $p_key = _get_namespace_id() . '_cargo_organization';
        $this->rediscache->delete($p_key);

        $url = '/' . $this->_user_hash . config_item('api_update_organization');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getCredentials($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_credential') . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function updateCredentialDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_credential');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getSchedules($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_payment_schedule') . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function updatePaymentScheduleDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_payment_schedule');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateRecharge($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_recharge');
        $param = json_encode($param);

        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getTemplate($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_template');
        return $this->_getJson('get', $url, $param);
    }

    function getAllVehicle($param=array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_vehicle');
        return $this->_getJson('get', $url, $param);
    }

    function getVehicle($param=array()) {
        if( !$json = $this->rediscache->get(self::REDIS_VEHICLE)) {
            $url = '/' . $this->_user_hash . config_item('api_get_vehicle');
            $json = $this->_getJson('get', $url, $param);
            $this->rediscache->set(self::REDIS_VEHICLE, $json, self::REDIS_DURATION);
        }
        return $json;
    }

    function getBankDetail($param=array()) {
        $url = '/' . $this->_user_hash . '/contact/bank/details/reference/'. $param ['entityType'] .'/' . $param ['code'];
        $json = $this->_getJson('get', $url, $param);
        return $json;
    }

    function getGPSVendors($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_gps_vendor');
        return $this->_getJson('get', $url);
    }
    
    function getVehicleInfo($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_vehicle_info') . '/' . $param ['tripCode'];
        return $this->_getJson('post', $url);
    }

    function updateVehicle($param = array()) {
        $this->rediscache->delete(self::REDIS_VEHICLE);
        
        $url = '/' . $this->_user_hash . config_item('api_update_vehicle');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getContact($param = array()) {
        $url = '/' . $this->_user_hash . '/contact?entityTypeCode=' . $param ['entityTypeCode'] . '&tag=' . $param ['tag'];
        return $this->_getJson('get', $url);
    }

    function getAllBankDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/contact/bank/details/reference/' . $param ['entityTypeCode'] . '/' . $param ['referenceCode'];
        return $this->_getJson('get', $url);
    }

    function updateContact($param = array()) {
        $url = '/' . $this->_user_hash . '/contact/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateBankDetail($param = array()) {
        $url = '/' . $this->_user_hash . '/contact/bank/details/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getNotifications($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_notification_admin') . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function updateAdminNotify($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_notification_admin');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateUserNotify($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_notification');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateTemplate($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_template');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getUser($param = array()) {
        $p_key = _get_namespace_id().'_users?activeFlag=' . $param['activeFlagFilter'];
        if( !$json = $this->rediscache->get($p_key)) {
            $url = '/' . $this->_user_hash . config_item('api_get_user') . '?activeFlag=' . $param['activeFlagFilter'];
            $json = $this->_getJson('get', $url);
            $this->rediscache->set($p_key, $json, 28800);    //  8hours
        }        
        return $json;
    }

    function resetUserCache() {
        $p_key = _get_namespace_id().'_users?activeFlag=-1';
        $this->rediscache->delete($p_key);

        $p_key = _get_namespace_id().'_users?activeFlag=';
        $this->rediscache->delete($p_key);
    }

    function getSchedulesBycode($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule') . '/' . $param ['code'];
        return $this->_getJson('get', $url, $param);
    }

    function getSchedulesStationPointsBycode($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_station_point') . '/' . $param ['stationcode'];
        return $this->_getJson('get', $url, $param);
    }

    function getSchedulesStationBycode($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_station') . '/' . $param ['code'];
        return $this->_getJson('get', $url, $param);
    }

    function getBusSchedules($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_station') . '/' . $param ['code'];
        return $this->_getJson('get', $url, $param);
    }

    function updateBus($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_buses');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateBusLayer($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_buses') . "/" . $param ['buscode'] . "/layout/update";
        $param = json_encode($param ['buslayer']);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getBusLayerbyCode($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_buses') . '/' . $param ['buscode'] . "/layout";
        return $this->_getJson('get', $url);
    }

    function getswitchNamespace($param = array()) {
        $url = config_item('api_auth_token') . '/' . $this->_user_hash . '/switch/' . $param ['code'];
        return $this->_getJson('post', $url);
    }

    function getMenu($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_menu');
        return $this->_getJson('get', $url);
    }
    
    function getProducts($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_menu').'/product';
        return $this->_getJson('get', $url);
    }
    function getMenuPrivileges($param = array()) {
        $url = config_item('api_auth_token') . '/' . $this->_user_hash . config_item('api_get_menu_privileges');
        $product = $this->session->userdata('product');
        if(!empty($product)) {
            $url .= '/'.$product;
        } else {
            $url .= '/bits';
        }
        return $this->_getJson('post', $url);
    }

    function getGrpMenu($param = array()) {
        $param ['rolename'] = 'NS';
        $url = '/' . $this->_user_hash . config_item('api_get_menu') . '/role/' . $param ['rolename'];
        return $this->_getJson('post', $url);
    }

    function getGroupPrevilege($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_menu');
        return $this->_getJson('get', $url);
    }

    function updateMenu($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_menu') . "/update";
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updatePrivilege($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_menu') . '/role/' . $param ['rolename'] . "/update";
        $param = json_encode($param ['privilege']);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getRole($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_menu') . '/role/' . $param ['rolename'];
        return $this->_getJson('post', $url);
    }
    
    function restoreUserPrivilege($param = array()) {
        $url = '/' . $this->_user_hash . '/menu/user/'.$param['userCode'].'/restore/default';
        unset($param['userCode']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    

    function getRolePermission($param, $val) {
        $url = '/' . $this->_user_hash . config_item('api_get_menu') . '/role/' . $param ['roleCode'];
        $param = json_encode($val);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function validateCanEditBusInSchedule($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/bus/'.$param['scheduleCode'].'/validate';
        return $this->_getJson('post', $url);
    }

    function updateSchedule($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_schedule');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateStationSchedule($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_schedule_station');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateStationPointSchedule($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_schedule_station_point');
        $param = json_encode($param);

        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getBustypeScheduleBycode($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_bustype') . '/' . $param ['code'];
        return $this->_getJson('get', $url);
    }

    function updateBustypeSchedule($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_schedule_bustype');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateRoutesFareSchedule($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_schedule_routes');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getRoutesFareScheduleByCode($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_routes') . '/' . $param ['code'];
        return $this->_getJson('get', $url);
    }

    function getScheduleStationByCode($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_station_code') . '/' . $param ['code'];
        return $this->_getJson('get', $url);
    }

    function updateCancelSchedule($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_cancellationterm');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getCancelScheduleByCode($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_cancellationterm') . '/' . $param ['code'];
        return $this->_getJson('get', $url);
    }

    function updateBookingSchedule($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_schedule_booking');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getBookingScheduleBycode($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_booking') . '/' . $param ['code'];
        return $this->_getJson('get', $url);
    }

    function updateSeatVisibilitySchedule($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_schedule_seat');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getSeatVisibilitySchedule($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_seat') . '/' . $param ['code'];
        return $this->_getJson('get', $url);
    }

    function updateSchedulesRefresh($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule') . '/' . $param ['scheduleCode'] . '/refresh';
        return $this->_getJson('post', $url);
    }

    function getScheduleTrip($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_trip') . '/' . $param ['tripDate'];
        return $this->_getJson('get', $url);
    }
    
    function getScheduleTripFromHistory($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_trip') . '/' . $param ['tripDate'].'/history';
        return $this->_getJson('get', $url);
    }
    
    function getSearchBus($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_commerce_search') . '/' . $param ['fromCode'] . '/' . $param ['toCode'] . '/' . $param ['tripDate'];
        return $this->_getJson('get', $url);
    }

    function getTripBusmap($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_commerce_search') . '/' . $param ['fromCode'] . '/' . $param ['toCode'] . '/' . $param ['tripDate'];
        return $this->_getJson('get', $url);
    }

    function getScheduleByType($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_list') . '/' . $param ['type'];
        return $this->_getJson('get', $url);
    }

    function updatePassengerDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_commerce_passenger');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function updatePassengerDetails_v3($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_commerce_passenger_v3');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getScheduleBusMap($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_commerce_bus') . '/' . $param ['stageCode'];
        return $this->_getJson('get', $url);
    }
    
    function getScheduleBusMap_v3($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_commerce_bus') . '/' . $param ['tripCode'].'/'.$param ['fromCode'].'/'.$param ['toCode'].'/'.$param ['travelDate'];
        return $this->_getJson('get', $url);
    }
    
    function ticketDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_ticket_details') . '/' . $param ['ticketCode'];
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function templateDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_template_details') . '/' . $param ['templateCode'];
        return $this->_getJson('get', $url);
    }

    function ticketCancelDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_ticket_cancel_details') . '/' . $param ['ticketCode'];
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function cancelTicket($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_ticket_cancel_details') . '/' . $param ['ticketCode'] . '/confirm?myAccountFlag=' . $param ['myAccountFlag'] . '&cancellationOverRideFlag=' . $param ['cancellationOverRideFlag'] . '&cancellationOverRideRefundAmount=' . $param ['cancellationOverRideRefundAmount'] . '&seatCodeList=' . $param ['seatCodeList'];
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function approveVoucher($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_voucher_transactions');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateTicketConfim($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_ticket_confirm') . '/' . $param ['ticketCode'].'?transactionMode='.$param['offlinePayType'];
        return $this->_getJson('post', $url, $param);
    }

    function updateTicketConfimByPhone($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_ticket_confirm_phone').'?transactionMode='.$param['offlinepaytype'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateTicketCancelByPhone($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_ticket_cancel_phone');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateTicketpayment($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_payment_request');
        return $this->_getJson('post', $url, $param);
    }

    function checkCancelBooking($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_ticket_confirm_phone') . '?' . $param ['ticketCode'];
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getTripsHead($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_trips_head') . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function getTripsTerms($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_ticket_cancel_terms') . '/' . $param ['stageCode'];
        return $this->_getJson('get', $url);
    }

    function getRules($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_ticket_cancel_terms');
        return $this->_getJson('get', $url);
    }

    function scheduleStagesDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_stages') . '/' . $param ['tripCode'] . '/stage';
        return $this->_getJson('get', $url);
    }

    function getTripsExpensive($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_trips_expensive') . '/' . $param ['tripCode'];
        return $this->_getJson('get', $url);
    }

    function updateTripsHead($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_trips_head');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateSchedulesExpensive($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_trips_expensive');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getCommerceStation($param = array()) {        
        $p_key = _get_namespace_id().'_commerce_stations';
        if( !$json = $this->rediscache->get($p_key)) {
            $url = '/' . $this->_user_hash . config_item('api_get_commerce_station');
            $json = $this->_getJson('get', $url);
            if(_get_namespace_id() == _get_native_namespace_id()) { //  to avoid miscache while switching namespaces.
                $this->rediscache->set($p_key, $json, 28800);    //  8hours
            }
        }    
        return $json;
    }

    function getCommerceRoute($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_commerce_route');
        return $this->_getJson('get', $url);
    }
    
    
    function getWhitelistedNamespace($param = array()) {
        $login_user_code = $this->session->userdata('user_id');        
        $c_key = $this->_user_hash.'_allowed_namespace';
        if( !$json = $this->rediscache->get($c_key)) {
            $url = '/' . $this->_user_hash . '/namespace/mapping/user/'.$login_user_code;         
            $json = $this->_getJson('post', $url, $param);
            $this->rediscache->set($c_key, $json, 86400);    //  24 hours
        }         
        return $json;
    }
    function getAppMenu() {
        if ($this->session->userdata('user_id') != '') {
            $param = array('authtoken' => $this->_user_hash);

            $ns_code = $this->session->userdata('namespace_id');
            $product = $this->session->userdata('product');
            
            $p_key = $this->_user_hash.'_privillages_'.$product;
            if(!$menu = $this->rediscache->get($p_key)) {
                $menu = $this->getMenuPrivileges(array('authtoken' => $this->_user_hash));
                $this->rediscache->set($p_key, $menu, 10800);
            }            
            
            $menu = json_decode($menu);

            if (is_array($menu->data) && $menu->status == 1) {
                foreach ($menu->data as $mn) {
                    $mn->name = str_replace("LR",lang('lr'),$mn->name);
                    $mn->name = str_replace("GC",lang('lr'),$mn->name);
                    // print_r($mn->name." => ".iflang($mn->name)); echo "</br>";
                    if ($mn->lookup->code != '') {
                        $sub_temp [$mn->lookup->code] [] = array(
                            'code' => $mn->code,
                            'name' => iflang($mn->name),
                            'link' => $mn->link,
                            'activeFlag' => $mn->activeFlag,
                            'defaultFlag' => $mn->defaultFlag,
                            'lookup' => $mn->lookup
                        );
                    } else {
                        $mn_temp [$mn->code] = array(
                            'code' => $mn->code,
                            'name' => iflang($mn->name),
                            'link' => $mn->link,
                            'activeFlag' => $mn->activeFlag,
                            'defaultFlag' => $mn->defaultFlag,
                            'lookup' => $mn->lookup
                        );
                    }

                    if (is_array($mn->eventList) && $mn->eventList != '') { // Get events of menu
                        foreach ($mn->eventList as $event) {
                            if (empty($event->operationCode))
                                continue;
                            if ($event->permissionType == 'IDL')
                                $events [strtoupper($event->operationCode)] = 2;
                            else
                                $events [strtoupper($event->operationCode)] = 1;
                        }
                    }
                }
            }
            if (is_array($mn_temp)) {
                usort($mn_temp, sorting('name')); // Master Menu Sorting
            }
            $sorted_submenu = array(); // Child Menu Sorting
            if (is_array($sub_temp)) {
                foreach ($sub_temp as $key => $sub_asc_menu) {
                  usort($sub_asc_menu, sorting('name'));
                    $sorted_submenu [$key] = $sub_asc_menu;
                }
            }
            
            //  merge static events
            
            /*$json = @file_get_contents(config_item('ns_properties_url').'/'.$ns_code.'.json');
            $c_events = json_decode($json, TRUE);
            $t_events = array();
            foreach($c_events['data'] as $k => $v) {
                foreach($v as $k1 => $v1) {
                    $t_events[$k.'.'.$k1] = $v1;
                }  
            } */

            // $events = array_merge($events, $t_events);
            
            if( _recursive_array_search('MNF4AJG93', $sorted_submenu) != '') {
                $events['boardingPointTripchart'] = 1;
            }
            
            if( _recursive_array_search('MNE6H565', $sorted_submenu) != '') {
                $events['findEditTickets'] = 1;
            }
            
            if( _recursive_array_search('MNE6H562', $sorted_submenu) != '') {
                $events['bookBusTickets'] = 1;
            }
            
            if( _recursive_array_search('MNE6H564', $sorted_submenu) != '') {
                $events['cancelBusTickets'] = 1;
            }
            
            if( _recursive_array_search('MNE6H566', $sorted_submenu) != '') {
                $events['confirmPhoneBook'] = 1;
            }
            
            if( _recursive_array_search('MNE64C57', $sorted_submenu) != '') {
                $events['activeTrips'] = 1;
            }
            if( _recursive_array_search('MNJA4DO92', $sorted_submenu) != '') {
                $events['viewSector'] = 1;
            }
            if( _recursive_array_search('MNJA4DN91', $sorted_submenu) != '') {
                $events['viewFareRule'] = 1;
            }
            
                        
            $data ['parent'] = $mn_temp;
            $data ['submenu'] = $sorted_submenu;
            $data ['action_rights'] = $events;
            return $data;
        }
    }

    // cancellation
    function getAllCancellation($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_cancellations') . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function updateCancellation($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_cancellations');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateUser($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_user');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function editUserGroup($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_Group') . '/' . $param ['groupcode'] . '/' . $param ['usercode'] . '/update';
        return $this->_getJson('post', $url);
    }

    // organizationCode
    function editUserOrganizatio($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_organization') . '/' . $param ['organizationCode'] . '/' . $param ['usercode'] . '/update';
        return $this->_getJson('post', $url);
    }

    function resetPassword($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_user') . '/' . $param ['usercode'] . '/resetpassword';
        return $this->_getJson('post', $url, $param);
    }

    function getUserByOrganization($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_user') . '/organization/' . $param ['organizationcode'];
        return $this->_getJson('post', $url, $param);
    }

    function updateTrip($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_trip') . '/' . $param ['code'].'/status/'.$param ['state'].'/update';
        $param = array(
            'tripStatusCode' => $param ['state']
        );
        return $this->_getJson('post', $url, $param);
    }

    function setScheduleState($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_set_schedule_state');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getUserByGroup($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_user') . '/group/' . $param ['groupcode'];
        return $this->_getJson('get', $url, $param);
    }

    function getVoucherUsers() {
        $url = '/' . $this->_user_hash . config_item('api_get_voucher_user');
        return $this->_getJson('get', $url);
    }

    function getRechargeUsers() {
        $url = '/' . $this->_user_hash . config_item('api_get_recharge_user');
        return $this->_getJson('get', $url);
    }

    function getTransType($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_transaction_type');
        return $this->_getJson('get', $url, $param);
    }

    function getTransMode($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_transaction_mode');
        return $this->_getJson('get', $url, $param);
    }

    function getAck($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_acknowledge');
        return $this->_getJson('post', $url, $param);
    }

    function updateAck($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_acknowledge') . '?paymentTransactionCode=' . $param ['code'] . '&paymentAcknowledgeCode=' . $param ['state'].'&remarks=' . $param ['remarks'];
        return $this->_getJson('post', $url);
    }

    function getUserReport($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_all_user_report') . '?fromDate=' . $param ['from'] . '&toDate=' . $param ['to'] . '&userCode=' . $param ['user'];
        return $this->_getJson('get', $url);
    }

    function getUserRecharge($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_all_user_recharge') . '?fromDate=' . $param ['from'] . '&toDate=' . $param ['to'] . '&userCode=' . $param ['user'];
        return $this->_getJson('get', $url);
    }

    function getVoucherList($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_voucher') . '?fromDate=' . $param ['from'] . '&toDate=' . $param ['to'] . '&userCode=' . $param ['user'] . '&useTravelDate=' . $param ['useTravelDate'];
        return $this->_getJson('get', $url);
    }

    function getAdvBookingList($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_advanced_booking') . '/' . $param ['from'] . '/' . $param ['to'];
        return $this->_getJson('get', $url);
    }

    function getUserCommission($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_user_commission') . '/' . $param ['userCode'];
        return $this->_getJson('get', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function getUserTds($param = array()) {
        $url = '/' . $this->_user_hash . '/user/tax/details/' . $param ['userCode'];
        return $this->_getJson('get', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function updateUserTds($param = array()) {
        $url = '/' . $this->_user_hash . '/user/tax/details/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateCommission($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_user_commission') . '/' . $param ['userCode'] . '/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getTripList($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_trip_list') . '/' . $param ['tripDate'];
        return $this->_getJson('post', $url, $param);
    }

    function getTripChart($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_trip_chart') . '/' . $param ['tripCode'];
        return $this->_getJson('post', $url, $param);
    }

    function getTripDriverList($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_trip_drivers_list');
        return $this->_getJson('post', $url, $param);
    }

    function updateTripDriveInfo($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_trip_driver') . '/' . $param ['tripCode'];
        return $this->_getJson('post', $url, $param);
    }

    function sendTripSMSNotification($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_send_trip_sms') . '/' . $param ['tripCode'];
        return $this->_getJson('post', $url, $param);
    }

    function addRoutes($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_routes');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function addGatewayProvider($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_gateway_providers');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getGatewayProvider($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_gateway_providers') . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function updateProviderDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_gateway_providers');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function addPaymentModes($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_gateway_modes');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getPaymentModes($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_gateway_modes') . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function updateModeDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_gateway_modes');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function addProfile($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_profile');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getProfile($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_profile');
        return $this->_getJson('post', $url, $param);
    }

    function getNamespaceProfile($param = array()) {
        $user_hash = ($this->_user_hash) ?: $this->session->userdata('temp_token');
        $url = '/' . $user_hash . config_item('api_get_namespace_profile');
        return $this->_getJson('post', $url, $param);
    }
    function postAppearance($param = array()){
        $url = '/' . $this->_user_hash . '/namespace/appearance/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getNamespace($param = array()) {
        if (empty($this->_user_hash))
            return '';
        $url = '/' . $this->_user_hash . config_item('api_get_namespace') . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function getCollaborationList($param = array()) {
        if (empty($this->_user_hash))
            return '';
        $url = config_item('api_auth_token') . '/' . $this->_user_hash . config_item('api_get_chatlist');
        return $this->_getJson('get', $url, $param);
    }

    function logout($param = array()) {
        if (empty($this->_user_hash))
            return '';
        $url = '/' . $this->_user_hash . config_item('api_logout');
        return $this->_getJson('get', $url, $param);
    }

    function updatePassword($param = array()) {
        $user_hash = ($this->_user_hash) ?: $this->session->userdata('temp_token');
        $url = '/' . $user_hash . config_item('api_update_user_password');
        return $this->_getJson('post', $url, $param);
    }

    function updateApiToken($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_user_token');
        return $this->_getJson('post', $url, $param);
    }

    function getNotificationsUser($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_notification');
        return $this->_getJson('get', $url, $param);
    }

    function _getJson($method, $url, $param = array(), $options = array()) {
        $this->pest->setupBaseUrl(config_item('api_domain'));
        try {
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
        } catch (Exception $e) {
            // auto logout if service inactive
            if ($e instanceof Pest_Curl_Exec && !empty(_get_user_hash())) {
                if ($this->input->is_ajax_request()) {
                    $this->session->sess_destroy();
                    header('HTTP/1.1 440 Session Timeout', true, 440);
                    exit;
                } else { 
                    redirect('user/logout');
                }
            }

            $msg = json_decode($e->getMessage());
            $r = json_encode(array('status' => 0, 'errorDesc' => $msg->error ?: ltrim(get_class($e), 'Pest_')));
        }
        if (config_item('allow_data_log')) {
            logger('data-log.txt', array(
                'URL-('.$method.')' => $url,
                'Data' => $param,
                'Response' => $r
            ));
        }
        return $r;
    }

    function addGatewayPartner($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_gateway_partners');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getGatewayPartner($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_gateway_partners') . '?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function getCancellationRpt($param = array()) {
        // $url = '/' . $this->_user_hash . config_item('api_get_cancellation_report'). '/' . $param['tripCode'] . '/' . $param['role']. '/' . $param['userCode'] . '/' . $param['searchBy']. '/' . $param['from'] . '/' . $param['to'];
        $url = '/' . $this->_user_hash . config_item('api_get_cancellation_report');
        return $this->_getJson('get', $url);
    }

    function getAllReportList($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_all_report_list');
        return $this->_getJson('get', $url);
    }

    function updateReportAdminDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_report');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getAllWidgetsList($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_all_widgets_list');
        return $this->_getJson('get', $url);
    }

    function updateWidgetsDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_widget');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getReportData($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_report_data') . '/' . $param ['queryCode'];
        unset($param ['queryCode']);
        $data = array();
        foreach ($param as $key => $value) {
            $data [] = array(
                'value' => $value,
                'paramName' => $key
            );
        }
        $param = json_encode($data);
        // print_r($param); die;
        // echo $url;
        // print $url;

        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getDynamicReportDataWithMap($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_dynamic_report_map') . '/' . $param ['queryCode'];
        unset($param ['queryCode']);
        $data = array();
        foreach ($param as $key => $value) {
            $data [] = array(
                'paramName' => $key,
                'value' => $value                
            );
        }
        $param = json_encode($data);
        //echo $param;
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getNamespaceInfo($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_namespace_info') . '?namespaceDomainURL=' . $param ['domainName'] . '&devicemedium=' . $param ['deviceMedium'];
        return $this->_getJson('post', $url, $param);
    }

    function getAgentRpt($param = array()) {
        // $url = '/' . $this->_user_hash . config_item('api_get_agent_report'). '/' . $param['tripCode'] . '/' . $param['role']. '/' . $param['userCode'] . '/' . $param['searchBy']. '/' . $param['from'] . '/' . $param['to'];
        $url = '/' . $this->_user_hash . config_item('api_get_agent_report');
        return $this->_getJson('get', $url);
    }

    function getPendingOrder($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_pending_orders');
        return $this->_getJson('get', $url);
    }

    function cancelPendingOrder($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_cancel_pending_order');
        return $this->_getJson('post', $url, $param);
    }

    function confirmPendingOrder($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_confirm_pending_order') . '/' . $param ['ticketcode'] . '/' . $param ['seatcode'];
        return $this->_getJson('post', $url, $param);
    }

    function getPhoneBooking($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_phone_bookings') . '/' . $param ['date'];
        return $this->_getJson('get', $url);
    }

    function getterms($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_terms').'/'.$param['type'];
        return $this->_getJson('get', $url, $param);
    }

    function updateterms($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_terms');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getdiscount($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_discount');
        return $this->_getJson('get', $url, $param);
    }

    function updatediscount($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_discount');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getrefund($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_ticket_refund') . '/' . $param ['statusCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updaterefund($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_ticket_refund_status') . '/' . $param ['statusCode'] . '/' . $param ['transactionCode'];

        return $this->_getJson('post', $url, $param);
    }

    function getFeedbackReport($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_user_feedback') . '?fromDate=' . $param ['fromDate'] . '&toDate=' . $param ['toDate'];
        return $this->_getJson('get', $url, $param);
    }

    function getPaymentReport($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_gateway_report') . '/' . $param ['fromDate'] . '/' . $param ['toDate'];
        return $this->_getJson('get', $url, $param);
    }

    function getRechargeList($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_recharge_report') . '/' . $param ['transactionTypeCode'];
        return $this->_getJson('get', $url, $param);
    }

    function findTickets($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_find_tickets');
        return $this->_getJson('get', $url, $param);
    }

    function updateMobileNumber($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_mobile_number') . '/' . $param ['ticketCode'] . '/mobile/update';
        return $this->_getJson('post', $url, $param);
    }

    function updatePassengerDetail($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_mobile_number') . '/' . $param ['ticketCode'] . '/seat/passengerdetails/update';
        return $this->_getJson('post', $url, $param);
    }

    function updateBoardingPoint($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_mobile_number') . '/' . $param ['ticketCode'] . '/boardingPoint/update';
        return $this->_getJson('post', $url, $param);
    }
    
    function updateDroppingPoint($param = array()) {
        $url = '/' . $this->_user_hash . '/ticket/edit/' . $param ['ticketCode'] . '/dropingPoint/update';
        return $this->_getJson('post', $url, $param);
    }

    function updateSeatName($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_mobile_number') . '/' . $param ['ticketCode'] . '/seat/change/update';
        return $this->_getJson('post', $url, $param);
    }

    function updateSeatNamev2($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_mobile_number') . '/' . $param ['ticketCode'] . '/v2/seat/change/update?seatCodes=' . urlencode($param ['seatCodes']) . '&notificationFlag=' . $param ['notificationFlag'];
        return $this->_getJson('post', $url, $param);
    }

    function getScheduleVisilityRights($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_visibility_rights') . '/' . $param ['scheduleCode'];
        return $this->_getJson('post', $url, $param);
    }

    function saveVisibilityRights($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_save_visibility_rights') . '/' . $param ['scheduleCode'] . '/update';
        $param = json_encode($param ['userList']);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateSchedulesDiscount($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_schedule_discount');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getScheduleDiscount($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_discount') . '/' . $param ['scheduleCode'];
        return $this->_getJson('get', $url, $param);
    }

    function getExtraCommission($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_extra_commission');
        return $this->_getJson('get', $url, $param);
    }

    function updateExtraCommission($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_extra_commission');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getDiscountCategory($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_discount_category') . '?authToken=' . $param ['authtoken'];
        return $this->_getJson('get', $url);
    }

    function updateDiscountCategory($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_discount_category');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getDiscountCoupon($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_discount_coupon') . '?authToken=' . $param ['authtoken'];
        return $this->_getJson('get', $url);
    }

    function updateDiscountCoupon($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_discount_coupon');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateDiscountCriteria($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_discount_criteria');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array('Content-Type' => 'application/json'));
    }

    function getDiscountCouponFilter($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_discount_coupon_filter') . '?authToken=' . $param ['authtoken'] . '&couponCode=' . $param['couponCode'];
        //print $url;
        return $this->_getJson('get', $url);
    }

    function updateSeatAutoRelease($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_seat_auto_release');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getSeatAutoRelease($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_seat_auto_release') . '/' . $param ['schedule'];
        return $this->_getJson('get', $url);
    }

    function getSeatPreference($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_seat_preference') . '/' . $param ['schedule'];
        return $this->_getJson('get', $url);
    }

    function updateSeatPreference($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_seat_preference');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getPendingRefund($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_pending_refund') . '/' . $param ['statusCode'];
        return $this->_getJson('get', $url);
    }

    function updatePendingRefund($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_pending_refund') . '/REQ?transactionCode=' . $param ['transactionCode'];
        return $this->_getJson('post', $url);
    }

    function updateTripExpenses($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_trips_expenses');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getUnpaidTransactions($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_all_user_unpaid_transactions') . '?userCode=' . $param ['user'] . '&fromDate=' . $param ['from'] . '&toDate=' . $param ['to'] . '&useTravelDate=' . $param ['useTravelDate'];
        // print $url;
        return $this->_getJson('get', $url);
    }

    function generateVoucher($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_generate_voucher');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getVoucherDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_voucher_details') . '/' . $param ['paymentCode'];
        return $this->_getJson('get', $url);
    }

    function getVoucherSummary($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_payment_details') . '/' . $param ['paymentCode'];
        return $this->_getJson('get', $url);
    }

    function getSceduleSeatFare($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_stage_fare') . '/' . $param ['code'];
        return $this->_getJson('get', $url);
    }

    function updateScheduleSeatFare($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_schedule_seat_fare');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateScheduleFareAutoOverride($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_schedule_fare_auto_override');
        $param = json_encode($param);
        //echo $param;
        return $this->_getJson('post', $url, $param, array('Content-Type' => 'application/json'));
    }
    
    function getScheduleFareAutoOverride($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_fare_auto_override') . '/' . $param ['code'];
        return $this->_getJson('get', $url);
    }
    
    function updateScheduleTimeAutoOverride($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_schedule_time_auto_override');
        $param = json_encode($param);
        //echo $param;
        return $this->_getJson('post', $url, $param, array('Content-Type' => 'application/json'));
    }

    function getScheduleTimeAutoOverride($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_time_auto_override') . '/' . $param ['code'];
        return $this->_getJson('get', $url);
    }
    
    function getScheduleGallery($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_schedule_gallery') . '/' . $param ['scheduleCode'];
        return $this->_getJson('get', $url);
    }
    
    function saveScheduleGallery($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_save_schedule_gallery').'/'.$param['scheduleCode'].'/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array('Content-Type' => 'application/json'));
    }    

    function updateSeatOrder($buscode, $param) {
        $url = '/' . $this->_user_hash . '/bus/' . $buscode . config_item('api_update_seat_order');
        $data = json_encode($param['layoutList']);
        return $this->_getJson('post', $url, $data, array('Content-Type' => 'application/json'));
    }

    function loadPassengerDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_passenger_details') . '?mobileNumber=' . $param ['mobile'] . '&seatCount=' . $param ['count'];
        return $this->_getJson('get', $url);
    }

    function sendPnrSms($param = array()) {
    $url = '/' . $this->_user_hash . config_item('api_get_ticket_details') . '/' . $param['TICKETS'] . '/notify?mobilenumber='.$param['MOBILE'];
        return $this->_getJson('post', $url);
    }

    function getPaymentGatewayOptions($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_pay_gatway_options');
        return $this->_getJson('get', $url, $param);
    }
    function getUserTxnPaymentGatewayOptions($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_user_txn_pg_options');
        return $this->_getJson('get', $url, $param);
    }
    function getPaymentGatewayMeta($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_pay_gateway_meta') . '?responseUrl=' . $param ['responseUrl'] . '&transactionAmount=' . $param ['transactionAmount'] . '&gatewayCode=' . $param ['gatewayCode'];
        return $this->_getJson('post', $url);
    }

    function confirmAgentOnlineRecharge($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_recharge_confirm') . '/' . $param['transCode'];
        return $this->_getJson('post', $url, $param);
    }

    function sendTripCancelSMS($param = array()) {
        $url = '/' . $this->_user_hash . '/notification/' . $param['tripCode'] . '/cancelled/' . $param['ticketCode'] . '?reason=' . urlencode($param ['reason']) . '&supportNumber=' . urlencode($param ['supportNumber']);
        return $this->_getJson('post', $url, array());
    }

    function sendTripDelaySMS($param = array()) {
        $url = '/' . $this->_user_hash . '/notification/' . $param['tripCode'] . '/delay/' . $param['ticketCode'] . '?reason=' . urlencode($param ['reason']) . '&delayTime=' . urlencode($param ['delayTime']) . '&supportNumber=' . urlencode($param ['supportNumber']);
        return $this->_getJson('post', $url, array());
    }
    
    function sendTripEarlySMS($param = array()) {
        $url = '/' . $this->_user_hash . '/notification/' . $param['tripCode'] . '/early/' . $param['ticketCode'] . '?reason=' . urlencode($param ['reason']) . '&earlyTime=' . urlencode($param ['earlyTime']) . '&supportNumber=' . urlencode($param ['supportNumber']);
        return $this->_getJson('post', $url, array());
    }

    function sendTripBoardingChageSMS($param = array()) {
        $url = '/' . $this->_user_hash . '/notification/' . $param['tripCode'] . '/stationPointChanged/' . $param['ticketCode'] . '?reason=' . urlencode($param ['reason']) . '&stationPointName=' . urlencode($param ['stationPointName']) . '&stationPointTime=' . urlencode($param ['stationPointTime']) . '&supportNumber=' . urlencode($param ['supportNumber']);
        return $this->_getJson('post', $url, array());
    }

    function sendTripNotificationSMS($param = array()) {
        $url = '/' . $this->_user_hash . '/notification/trip/send';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array('Content-Type' => 'application/json'));
    }
    
    function sendTrackingLinkSMS($param = array()) {
        $url = '/' . $this->_user_hash . '/notification/gps/track/' . $param['ticketCode'];
        return $this->_getJson('post', $url, array());
    }

    function transferTicket($param = array()) {
        $url = '/' . $this->_user_hash . '/commerce/ticket/' . $param['ticketCode'] . '/transfer';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array('Content-Type' => 'application/json'));
    }

    function getCargoItems($param = array()) {
        if( !$json = $this->rediscache->get(self::REDIS_ITEM)) {
            $url = '/' . $this->_user_hash . config_item('api_get_cargo_items');
            $json = $this->_getJson('get', $url, $param);
            $this->rediscache->set(self::REDIS_ITEM, $json, self::REDIS_DURATION);
        }
        return $json;
    }

    function updateCargoItems($param = array()) {
        $this->rediscache->delete(self::REDIS_ITEM);
        
        $url = '/' . $this->_user_hash . config_item('api_update_cargo_items');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateCargoCustomerGroup($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_cargo_customer_groups');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getCargoCustomerGroups($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_cargo_customer_groups');
        return $this->_getJson('get', $url, $param);
    }

    function getCargoCustomers($param = array()) {
        if( !$json = $this->rediscache->get(self::REDIS_CUSTOMER)) {
            $url = '/' . $this->_user_hash . config_item('api_get_cargo_customers');
            $json = $this->_getJson('get', $url, $param);
            $this->rediscache->set(self::REDIS_CUSTOMER, $json, self::REDIS_DURATION);
        }
        return $json;
    }

    function updateCargoCustomer($param = array()) {
        $this->rediscache->delete(self::REDIS_CUSTOMER);

        // delete customer autocomplete cache
        foreach ($param['station'] as $station) {
            $this->rediscache->delete(self::REDIS_STATIONCUSTOMER . ':' . $station['code']);
        }

        $url = '/' . $this->_user_hash . config_item('api_update_cargo_customers'). '?customerMasterFlag=' . $param['customerMasterFlag'];
        unset($param['customerMasterFlag']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateCargoCustomerAddress($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_cargo_customers_address') . '/' . $param['user'] . '/address/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getCargoCustomerAddress($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_cargo_customers_address') . '/' . $param['user'] . '/address';
        return $this->_getJson('post', $url, array());
    }
    
    function getCargoCustomerAddressv2($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/customer/address';
        return $this->_getJson('get', $url, $param);
    }

    function getUserDetailByCode($param = array()) {
        $token = $this->_user_hash;
        if(empty($this->_user_hash)) {
            $token = $param['userHash'];
        }
        
        $url = '/' . $token . config_item('api_user_details_by_code').'/'.$param['userCode'];
        return $this->_getJson('get', $url);
    }
    
    function saveCargoBooking($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_cargo_booking');
        $param = json_encode($param);
        $result =  $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
        $r = json_decode($result);
        if($r->status != 1){
            logger('booking-log.txt', array(
                'Namespace' => $this->session->userdata('namespace_name')." (".$this->session->userdata('namespace_id').")",
                'User' => $this->session->userdata('user_name')." (".$this->session->userdata('user_id').")",
                'DateTime' => date('Y-m-d h:i A'),
                'URL' => $url,
                'Data' => $param,
                'Response' => "{$result}"
            ));
        }        
        return $result;        
    }

    function saveCargoPreBooking($param = array()) {
        $url = '/' . $this->_user_hash. '/cargo/pre/book/save';
        $param = json_encode($param);
        $result =  $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
        $r = json_decode($result);
        if($r->status != 1){
            logger('booking-log.txt', array(
                'Namespace' => $this->session->userdata('namespace_name')." (".$this->session->userdata('namespace_id').")",
                'User' => $this->session->userdata('user_name')." (".$this->session->userdata('user_id').")",
                'DateTime' => date('Y-m-d h:i A'),
                'URL' => $url,
                'Data' => $param,
                'Response' => "{$result}"
            ));
        }        
        return $result;        
    }
    
    function updateCargoBooking($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/edit';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updatePrivatemark($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/edit/additional/details';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updatePreBooking($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/pre/book/edit';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updatePreBookingStatus($param = array()) {
        $url = $this->_user_hash . '/cargo/pre/book/' . $param['preBookCode'] . '/status/update/' . $param['statusCode'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    } 
    
    function getCargoSummary($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_cargo_summary') . '/' . urlencode($param['cargoCode']).'/details';
        return $this->_getJson('get', $url);
    }

    function getCargoPreBookingSummary($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/pre/book/'.$param['preBookCode'].'/details';
        return $this->_getJson('get', $url);
    }

    function getVendorPreBooking($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/pre/book/details?mobileNumber='.$param['mobileNumber'].'&vendorCode='.$param['vendorCode'];
        return $this->_getJson('get', $url);
    }
    
    function saveCargoScheduleBasicInfo($param = array()){
        $url = '/' . $this->_user_hash . config_item('api_update_cargo_schedule_basic_info');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function getCargoScheduleBasicInfo($param = array()){
        $url = '/' . $this->_user_hash . config_item('api_get_cargo_schedule_basic_info').'/'.$param['scheduleCode'];
        return $this->_getJson('get', $url);
    }
    
    function saveCargoScheduleStation($param = array()){
        $url = '/' . $this->_user_hash . config_item('api_update_cargo_schedule_station');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function getCargoScheduleStations($param = array()){
        $url = '/' . $this->_user_hash . config_item('api_get_cargo_schedule_station').'/'.$param['scheduleCode'];
        return $this->_getJson('get', $url);
    }
    
    function saveCargoScheduleRoute($param = array()){
        $url = '/' . $this->_user_hash . config_item('api_update_cargo_schedule_route');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function getCargoScheduleRoutes($param = array()){
        $url = '/' . $this->_user_hash . config_item('api_get_cargo_schedule_route').'/'.$param['scheduleCode'];
        return $this->_getJson('get', $url);
    }
    
    function getCargoSchedulesList($param = array()){
        $url = '/' . $this->_user_hash . config_item('api_get_cargo_schedules_list').'/'.$param['scheduleType'];
        return $this->_getJson('get', $url);
    }
    
    function getCargoTripsList($param = array()){
        $url = '/' . $this->_user_hash .config_item('api_get_cargo_trip_list').'/'.$param['date'];
        return $this->_getJson('get', $url);
    }
    
    function loadCargoToTrip($param = array()){
        $url = '/' . $this->_user_hash . config_item('api_load_cargo_to_trip');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function assignVehicleToTrip($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/trip/'.$param['tripCode'].'/info/update?driverName='.$param['driver'].'&driverMobile=123&vehicleCode='.$param['vehicle'];
        return $this->_getJson('post', $url, array(), array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function getLoadedCargoFromTrip($param = array()){
        $url = '/' . $this->_user_hash .config_item('api_get_loaded_cargo_from_trip').'/'.$param['tripCode'];
        return $this->_getJson('get', $url);
    }
    
    function getGalleries($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_gallery');
        return $this->_getJson('get', $url);
    }
    
    function getGallery($code) {
        $url = '/' . $this->_user_hash . config_item('api_get_gallery').'/'.$code;
        return $this->_getJson('get', $url);
    }
    
    function updateGalleryDetails($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_gallery');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function changeCargoStatus($param = array()){
        $url = '/' . $this->_user_hash . config_item('api_change_cargo_status');
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function addCargoPayment($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/'.$param['cargoCode'].'/payment/update/v2?bookByMyAccountCode=&offlineUserCode=' . $param['offlineUserCode'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function addCargoUnloadingCharges($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/edit/unloading/charge';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function addCargoDeliveryCharges($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/update/delivery/charge';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function revertCargoPayment($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/'.$param['cargoCode'].'/payment/update/v2/?remarks=' . urlencode($param['remarks']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function getCargoItemBalance($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/'.$param['cargoCode'].'/transaction';
        $trans = $this->_getJson('get', $url);
        $trans = json_decode($trans);
        $cr = 0;
        $revert = 0;
        foreach($trans->data as $k => $t) {
            $t->transactionAmount;
            if($t->transactionType->code == "CGBO") {
                $cr += $t->transactionAmount;
            } else {
               $revert += $t->transactionAmount; 
            }
                
        }
        return ($cr-$revert);
    }
    
    function changeCargoItemStatus($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/'.$param['cargoCode'].'/status/update/'.$param['statusCode'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function deliveryCargoItemStatus($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/'.$param['cargoCode'].'/status/update/'.$param['statusCode'] . '?otpNumber=' . $param['otpNumber'] . '&offlineUserCode=' . $param['offlineUserCode'];
        $remarks = json_encode($param['data'] ?: []);
        return $this->_getJson('post', $url, $remarks, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function changeCargoPaymentStatus($param = array()){
        $url = '/' . $this->_user_hash .'/cargo/'.$param['cargoCode'].'/payment/update/'.$param['paymentCode'];
        return $this->_getJson('post', $url, $param);
    }
    
        
    function updateGalleryImage($param = array()) {
       $url = '/' . $this->_user_hash . config_item('api_get_gallery').'/'.$param['gallery'].'/image/update';
       unset($param['gallery']);
       $param = json_encode($param);
       return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
       ));
    }
    
    function getGalleryImages($code){
        $url = '/' . $this->_user_hash . config_item('api_get_gallery').'/'.$code.'/image';
        return $this->_getJson('post', $url, $param=array());
    }
    
    function getCurrentlyBookingList() {
        $url = '/' . $this->_user_hash . '/cargo/progress';
        return $this->_getJson('get', $url);
    }
       
    
    function getPhoneBookTimeControl($param = array()) {
        $url = '/' . $this->_user_hash . '/terms/ticket/phone/book/time/control';
        return $this->_getJson('get', $url);
    }
    
    function updatePhoneBookTimeControl($param = array()) {
        $url = '/' . $this->_user_hash . '/terms/ticket/phone/book/time/control/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function getPhoneBookLimitControl($param = array()) {
        $url = '/' . $this->_user_hash . '/terms/ticket/phone/book/limit/control';
        return $this->_getJson('get', $url);
    }
    
    function updatePhoneBookLimitControl($param = array()) {
        $url = '/' . $this->_user_hash . '/terms/ticket/phone/book/limit/control/update';
        $param = json_encode($param);
        //print_r($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }    
    
    function allocateTripQuota($param = array()) {
        $url = '/' . $this->_user_hash . '/trip/quota/'.$param['tripCode'].'/update';
        unset($param['tripCode']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function loadTripQuotaDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/trip/'.$param['tripCode'].'/seat/quota';
        return $this->_getJson('get', $url);
    }
    
    function loadTripFareDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/trip/fare/'.$param['tripCode'];
        return $this->_getJson('get', $url);
    }
    
    function saveTripFare($param = array()) {
        $url = '/' . $this->_user_hash . '/trip/fare/'.$param[0]['tripCode'].'/update';
        unset($param['tripCode']);
        $param = json_encode($param);
        $r = $this->_getJson('post', $url, $param, array( 'Content-Type' => 'application/json'));        
        return $r;
    }
    
    function getDeviceList($param = array()) {
        $url = '/' . $this->_user_hash . '/namespace/device?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url); 
    }
    
    function addDevice($param = array()) {
        $url = '/' . $this->_user_hash . '/namespace/device/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function getDeviceAuthList($param = array()) {
        $url = '/' . $this->_user_hash . '/namespace/device/auth/'.$param['deviceCode'];
        return $this->_getJson('get', $url); 
    }
    
    function addDeviceAuth($param = array()) {
        $url = '/' . $this->_user_hash . '/namespace/device/auth/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    } 

    function generateDeviceOtp($param = array()) {
        $url = '/auth/' . $this->_user_hash . '/generate/namespace/device/' . $param['deviceCode'] . '/otp';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    } 

    function getCargoSettings_2($param = array()) {
        $url = '/' . $param ['authtoken'] . '/cargo/settings';
        $json = $this->_getJson('get', $url);
        $result = json_decode($json);
        $this->rediscache->set(self::REDIS_CARGOSETTINGS, $json, self::REDIS_DURATION);
    return $json;
    }

    function getRecentBranchCloseDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/organization/user/day/close/recent/receipt/details?organizationCode=' . $param['organizationCode'];
        return $this->_getJson('get', $url, $param);
     }
    
    function cloneSchedule($param = array()){
        $url = '/' . $this->_user_hash . '/schedule/clone/'.$param['code'].'/'.$param['clonetype'].'?entity='.$param['options'];
        return $this->_getJson('post', $url);
    }
    
    function createScheduleTag($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/category/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    } 
    
    function getScheduleTag($param = array()){
        $url = '/' . $this->_user_hash . '/schedule/category';
        return $this->_getJson('get', $url);
    }
    
    function getAllTravelStops($param = array()){
        $url = '/' . $this->_user_hash . '/travel/stops?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    } 
    
    function getTravelStop($param = array()){
        $url = '/' . $this->_user_hash . '/travel/stops/'.$param['code'];
        return $this->_getJson('get', $url);
    } 
    
    function updateTravelStops($param = array()) {
        $url = '/' . $this->_user_hash . '/travel/stops/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    } 
    
    function getExtraCommissionSlab($param = array()) {
        $url = '/' . $this->_user_hash . '/commission/extra/slab';
        return $this->_getJson('get', $url);
    }
    
    function updateExtraCommissionSlab($param = array()) {
        $url = '/' . $this->_user_hash . '/commission/extra/slab/update';
        $param = json_encode($param);        
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getScheduleTaxMaster($param = array()) {
        $url = '/' . $this->_user_hash . '/tax?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }    
    
    function getGstDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/tax?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }
    
    function updateGstDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/tax/update';
        $param = json_encode($param);        
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    
    
    function updateUserStationPoint($param = array()) {
        $url = '/' . $this->_user_hash . '/user/'.$param['userCode'].'/specific/stationpoint/update';
        unset($param['userCode']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
        
    function getUserStationPoints($param = array()) {
        $url = '/' . $this->_user_hash . '/user/'.$param['usercode'].'/specific/stationpoint';
        return $this->_getJson('get', $url);
    }
    
    function checkUsernameAvailablity($param = array()) {
        $url = '/' . $this->_user_hash . '/user/'.$param['username'].'/check';
        return $this->_getJson('get', $url);
    }
    
    function getScheduleTravelStops($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/travel/stops/'.$param['schedule_code'];
        return $this->_getJson('post', $url, $param=array());
    }
    function updateScheduleStops($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/travel/stops/'.$param['schedule_code'].'/update';
        unset($param['schedule_code']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    } 
    
    function resetTripCache($param = array()) {
        $url = '/' . $this->_user_hash . '/trip/'.$param['tripCode'].'/tripstageseatdetails/cache/clear';
        unset($param['tripCode']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    } 
    
    function getAfterDepatureBookingList($param = array()) {
        $url = '/'.$this->_user_hash.'/ticket/progress/aftertripdepaturetime';        
        return $this->_getJson('get', $url);
    } 
    
    function acknowledgeAfterDepatureBooking($param = array()) {
        $url = '/' . $this->_user_hash . '/ticket/progress/aftertriptime/'.$param['ticketCode'].'/acknowledge';
        unset($param['ticketCode']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    } 
    
    function getActivePobDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/tablet?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }
    
    function getPendingPobDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/tablet/register/pending';
        return $this->_getJson('get', $url);
    }
    
    function updatePobDevice($param = array()) {
        $url = '/' . $this->_user_hash . '/tablet/register/add';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function editPobDevice($param = array()) {
        $url = '/' . $this->_user_hash . '/tablet/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function deletePobDevice($param = array()) {
        $url = '/' . $this->_user_hash . '/tablet/delete';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    function generatePobMobileVerifyOTP($param = array()) {
        $url = '/' . $this->_user_hash . '/tablet/'.$param['code'].'/generate/otp';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function generateDevicePin($param = array()) {
        $url = '/' . $this->_user_hash . '/tablet/register/authorize/generate/'.$param['device'];
        unset($param['device']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    } 
    
    function updateDeviceVehicle($param = array()) {
        $url = '/' . $this->_user_hash . '/tablet/vehicle/mapping';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    } 
    
    function getOfflineDiscountRules($param = array()) {
        $url = '/' . $this->_user_hash . '/addons/discount/offline';
        return $this->_getJson('get', $url);
    }
    
    function updateOfflineDiscountRules($param = array()) {
        $url = '/' . $this->_user_hash . '/addons/discount/offline/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function validateOfflineDiscount($param = array()) {
        $url = '/' . $this->_user_hash . '/commerce/addonsV3/discount/offline';
        $param = json_encode($param);        
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getAllStationPointExceptions($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/station/point/exception';
        return $this->_getJson('get', $url);
    }
    
    function getCumulativeAdvaceBooking($param = array()) {
        $p_key = _get_namespace_id().'_cumulative_advance_bookings';
        if( !$json = $this->rediscache->get($p_key)) {
            $url = '/' . $this->_user_hash . '/trip/schedule/occupancy';
            $json = $this->_getJson('get', $url);
            $this->rediscache->set($p_key, $json, 7200);    //  2hours
        }        
        return $json;
    }
    
    function updateAllStationPointExceptions($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/station/point/exception/update';
        $param = json_encode($param);  
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    
    function getTripInfo($param = array()) {        
        $url = '/' . $this->_user_hash . '/trip/info/'.$param['tripCode'];          
        $json = $this->_getJson('post', $url, $param);
        return $json;
    }
    
    function getAllTripInfo($param = array()) {        
        $c_key = _get_namespace_id().'_search_tripinfo_'.$param['tripDate'];
        if( !$json = $this->rediscache->get($c_key)) {
            $url = '/' . $this->_user_hash . '/trip/all/info/'.$param['tripDate'];          
            $json = $this->_getJson('post', $url, $param);
            $this->rediscache->set($c_key, $json, 86400);    //  24 hours
        }  
        return $json;
    }
    
    function getTripStagesBoardingPoints($param = array()) {
        $url = '/' . $this->_user_hash . '/commerce/schedule/'.$param['tripCode'].'/stage';
        return $this->_getJson('get', $url);
    }
    
    function getFleetGPSFeed($param = array()) {
        $url = 'commerce/gps/vehicle/'.$param['operatorCode'].'/EZEEGPS/location/'.$param['deviceCode'];
        return $this->_getJson('get', $url);
    }
    
    function getScheduleDynamicPrice($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/dynamic/stagefare/'.$param['scheduleCode'];
        return $this->_getJson('get', $url);
    }    
    
    function updateScheduleDynamicPrice($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/dynamic/stagefare/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function tripCancelInitiate($param = array()){
        $url = '/' . $this->_user_hash . '/ticket/trip/'.$param['tripCode'].'/cancel/initiate/'.$param['ticketCode'].'/seats?seats='.$param['seatCode'];
        return $this->_getJson('post', $url);
    }
    
    function tripCancelAcknowledge($param = array()){
        $url = '/' . $this->_user_hash . '/ticket/trip/'.$param['tripCode'].'/cancel/acknowledge/update/'.$param['ticketCode'].'/seats?seats='.$param['seatCode'].'&tripStatusCode='.$param['tripStatusCode'];
        return $this->_getJson('post', $url);
    }
    
    function cargoSequence($param = array()){
        $url = '/' . $this->_user_hash .'/cargo/sequence/organization/'.$param['organizationCode'].'/update?prefixCode='.$param['prefixCode'].'&sequence='.$param['sequence']; 
        return $this->_getJson('post', $url);
    }
    
    function getOrganizationPrefixCode(){
        $url = '/' . $this->_user_hash .'/cargo/sequence/organization';
        return $this->_getJson('get', $url);
    }
    
    //all organization details
    function organizationLists(){
        $c_key = _get_namespace_id().'/cargo/organization/booking';
        if( !$json = $this->rediscache->get($c_key)) {
            $url = '/' . $this->_user_hash .'/cargo/organization/booking';      
            $json = $this->_getJson('get', $url);
            $this->rediscache->set($c_key, $json, 86400);    //  24 hours
        }  
        return $json;

    }
    
    function virtualSeat(){
        $url = '/' . $this->_user_hash .'/schedule/virtual/seat';
        return $this->_getJson('get', $url);
    }
    
    function virtualSeatUpdate($param = array()){
        $url = '/' . $this->_user_hash .'/schedule/virtual/seat/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getUserNamespacePrivilege($param = array()){
        $url = '/' . $this->_user_hash .'/namespace/mapping/user/'.$param['userCode'];
        echo $this->_getJson('post', $url);
    }
    
    function saveUserNamespacePrivilege($param = array()){
        $url = '/' . $this->_user_hash .'/namespace/mapping/'.$param['namespaceCode'].'/user/'.$param['userCode'].'/'.$param['action'];
        echo $this->_getJson('post', $url);
    }
    
    function getVanRoutes($param = array()){
        $url = '/' . $this->_user_hash .'/bus/vehicle/pickup/van?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }
    
    function updateVanRoute($param = array()){
        $url = '/' . $this->_user_hash .'/bus/vehicle/pickup/van/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getVanRouteByStation($param = array()){
        $url = '/' . $this->_user_hash .'/bus/vehicle/pickup/van/station/'.$param['stationCode'];
        echo $this->_getJson('get', $url);
    }
    
    function cargoUserCommissions($param = array()){
        $url = '/' . $this->_user_hash .'/cargo/commission/'.$param['userCode'];
        return $this->_getJson('get', $url);
    }
    
    function addCargoUserCommissions($param = array()){
        $url = '/' . $this->_user_hash .'/cargo/commission/'.$param['userCode'].'/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function cargoNotify($param = array()){
        $url = '/' . $this->_user_hash .'/cargo/'.$param['cargoCode'].'/notify';
        echo $this->_getJson('post', $url);
    }
    
    function cargoCustomerVendor(){
        if( !$json = $this->rediscache->get(self::REDIS_VENDOR)) {
            $url = '/' . $this->_user_hash .'/cargo/customer/vendor';
            $json = $this->_getJson('get', $url);
            $this->rediscache->set(self::REDIS_VENDOR, $json, self::REDIS_DURATION);
        }
        return $json;
    }

    function cargoCustomerVendorByBranch($param = array()){
        $p_key = self::REDIS_VENDOR . ':' . $param['organizationCode'];
        if( !$json = $this->rediscache->get($p_key)) {
            $url = '/' . $this->_user_hash .'/cargo/organization/'.$param['organizationCode'].'/customer/vendor';
            $json = $this->_getJson('get', $url);
            $this->rediscache->set($p_key, $json, self::REDIS_DURATION);
        }
        return $json;
    }
    
    function updateCargoVendor($param = array()){
        $this->rediscache->delete($this->rediscache->keys(self::REDIS_VENDOR . '*'));

        // delete customer autocomplete cache
        $this->rediscache->delete(self::REDIS_STATIONCUSTOMER . ':' . $param['station']['code']);

        $url = '/' . $this->_user_hash .'/cargo/customer/vendor/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function updateVendorAddress($param = array()){
        $url = '/' . $this->_user_hash .'/cargo/customer/vendor/' . $param['vendorCode'] . '/address/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateCargoOrganization($param = array()){
        $p_key = _get_namespace_id() . '_cargo_organization';
        $this->rediscache->delete($p_key);
        $c_key = _get_namespace_id().'/cargo/organization/booking';
        $this->rediscache->delete($c_key);

        $url = '/' . $this->_user_hash .'/cargo/organization/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getCargoOrganization(){
        $p_key = _get_namespace_id() . '_cargo_organization';
        if (!$json = $this->rediscache->get($p_key)) {
            $url = '/' . $this->_user_hash .'/cargo/organization';
            $json = $this->_getJson('get', $url);
            $result = json_decode($json);
            if ($result->status != 1) {
                return $json;
            }

            usort($result->data, function($a, $b) {
                return strnatcasecmp($a->organization->name, $b->organization->name);
            });

            foreach ($result->data as $i => $branch) {
                usort($result->data[$i]->deliveryBranchList, function($a, $b) {
                    return strnatcasecmp($a->name, $b->name);
                });
            }
            $this->rediscache->set($p_key, json_encode($result), 28800);    //  8hours
        }
        return $json;
    }
    
    function ticketResheduleTerms($param = array()){
        $url = '/' . $this->_user_hash .'/schedule/ticket/transfer/terms?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }
    
    function ticketResheduleTermsUpdate($param = array()){
        $url = '/' . $this->_user_hash .'/schedule/ticket/transfer/terms/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function replyCustomerFeedback($param = array()){
        $url = '/' . $this->_user_hash .'/user/feedback/'.$param['refferencecode'].'/reply?notificationmode='.$param['notificationmode'].'&participantaddress='.$param['participantaddress'];
        $param = json_encode($param['content']);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function changeTravelStatus($param = array()){
        $url = '/' . $this->_user_hash .'/ticket/'.$param['ticketCode'].'/travel/status/'.$param['travelStatus'].'/update?seatCodeList='.$param['seatCodes'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function deRegisterPobDevice($param = array()){
        $url = '/' . $this->_user_hash .'/tablet/deregister/'.$param['tabletCode'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function releaseTentativeBooking($param = array()) {
        $url = '/' . $this->_user_hash . '/ticket/'.$param['ticketCode'].'/'.$param['ticketCode'].'/tentative/release?reason=fromsearch';
        return $this->_getJson('post', $url, $param);
    }
    
    function addDetailedQuota($param = array()){
        $url = '/' . $this->_user_hash .'/trip/seat/quota/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getScheduleBusOverride($param = array()){
        $url = '/' . $this->_user_hash .'/schedule/'.$param['scheduleCode'].'/bus/override';
        return $this->_getJson('get', $url);
    }
    
    function updateScheduleBusOverride($param = array()){
        $url = '/' . $this->_user_hash .'/schedule/bus/override/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function switchToUser($param = array()){
        $url = '/auth/' . $this->_user_hash .'/switch/user/'.$param['userCode'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function sendValidationOTP($param = array()){
        $url = '/' . $this->_user_hash .'/notification/ticket/'.$param['pnr'].'/otp/generate';
        return $this->_getJson('post', $url);
    }
    
    function validateValidationOTP($param = array()){
        $url = '/' . $this->_user_hash .'/notification/ticket/'.$param['pnr'].'/otp/'.$param['otp'].'/validate/';
        return $this->_getJson('post', $url);
    }

    function saveSeatMigrate($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_update_mobile_number') . '/' . $param ['ticketCode'] . '/v2/seat/change/update';
        return $this->_getJson('post', $url, $param);
    }

    function getEnRouteBooking($param = array()){
        $url = '/' . $this->_user_hash .'/schedule/'.$param['scheduleCode'].'/book/control/';
        return $this->_getJson('get', $url);
    }

    function updateEnRouteBooking($param = array()) {
        $url = '/' . $this->_user_hash .'/schedule/book/control/update/';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function resendGPSandHJSMS($param = array()) {
        $url = '/' . $this->_user_hash . '/notification/resend/happy/journey/gps/track/' . $param ['tripCode'] .'?ticketCodes='.$param ['ticketCode'];
        return $this->_getJson('post', $url, $param);
    }

    function getLiveNotBoardedList($param = array()){
        $url = '/' . $this->_user_hash .'/ticket/progress/notboard/';
        return $this->_getJson('get', $url);
    }

    function getOrderStatus($param = array()) {
        $url = '/' . $this->_user_hash .'/payment/order/status/' . $param['orderCode'].'/' . $param['namespaceCode'];
        return $this->_getJson('get', $url);
    }

    function generatePayment($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/payment/voucher/generate';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function cargoVoucherAcknowledge() {
        $url = '/' . $this->_user_hash .'/cargo/user/transaction/acknowledge';
        return $this->_getJson('post', $url);
    }

    function cargoUpdateAck($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/payment/voucher/acknowledge/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getCargoIEHead($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/organizationcash/head';
        return $this->_getJson('get', $url);
    }

    function updateCargoIEHead($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/organizationcash/head/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function voucherPartialTransactions($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/payment/details?paymentTransactionCode=' . urlencode($param['paymentTransactionCode']);
        return $this->_getJson('post', $url);
    }

    function getUnpaidVouchers($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/payment/acknowledge?organizationCode=' . $param['organizationCode'];
        return $this->_getJson('post', $url);
    }
    
    function getIncomeExpenseTransactions($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/organizationcash/transaction/details?fromDate=' . $param['fromDate'] . '&toDate='. $param['toDate']. '&organizationCode='. $param['organizationCode'];
        return $this->_getJson('get', $url);
    }
    
    function valiateIncomeExpense($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/organizationcash/' . $param['organizationCode'] . '/transaction/' . $param['cargoCode'] . '/head/' . $param['headCode'] . '/check';
        return $this->_getJson('get', $url);
    }
    
    function getIncomeExpensePaidTransactions($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/organizationcash/transaction/details?fromDate=' . $param['fromDate'] . '&toDate='. $param['toDate']. '&organizationCode='. $param['organizationCode']. '&paymentAcknowledgeStatusCode='. $param['paymentAcknowledgeStatusCode'];
        return $this->_getJson('get', $url);
    }
    
    function makeApprovalIncomeExpense($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/organizationcash/transaction/status/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    

    function generateInvoicePayment($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/payment/invoice/generate';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function cargoUpdateInvoice($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/payment/vendor/invoice/acknowledge/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateCargoIncExp($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/organizationcash/transaction/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function sendUserOTP( $param = array() ) {
        $url = '/' . $this->_user_hash .'/commerce/otp/generate/user';
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getVehicleDriver($param = array()) {
        $p_key = self::REDIS_DRIVER . $param ['activeFlagFilter'];
        if( !$json = $this->rediscache->get($p_key)) {
            $url = '/' . $this->_user_hash .'/bus/vehicle/driver?activeFlag=' . $param ['activeFlagFilter'];
            $json = $this->_getJson('get', $url);
            $this->rediscache->set($p_key, $json, self::REDIS_DURATION);
        }
        return $json;
    }

    function updateVehicleDriver($param = array()) {
        $this->rediscache->delete(self::REDIS_DRIVER);
        $this->rediscache->delete(self::REDIS_DRIVER . '-1');

        $url = '/' . $this->_user_hash .'/bus/vehicle/driver/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function customerGstDetails($param = array()) {
        $url = '/' . $this->_user_hash .'/ticket/tax/' . $param['ticketCode'] . '/tax/details';
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateCustomerGstDetails($param = array()) {
        $url = '/' . $this->_user_hash .'/ticket/tax/' . $param['ticketCode'] . '/tax/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function scheduleExtrasDiscount($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/discount';
        return $this->_getJson('get', $url);
    }

    function updateScheduleExtrasDiscount($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/discount/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function walletAccessToken() {
        $url = '/' . $this->_user_hash . '/wallet/token';
        return $this->_getJson('get', $url);
    }

    function sendPushNotification($param = array()) {
        $url = '/' . $this->_user_hash . '/notification/user/' . $param['mobileNumber'] . '/push/fcm';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function scheduleExtrasGenderRules($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/book/gender/restriction';
        return $this->_getJson('get', $url);
    }
    
    function updateScheduleExtrasGenderRules($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/book/gender/restriction/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateAckv2($param = array()) {
        $url = '/' . $this->_user_hash . '/user/transaction/acknowledge/update/v2';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function executeDynamicQuery($param = array()) {
        $url = '/' . $this->_user_hash .'/report/dynamic/execute/query?query=' . urlencode($param['query']);
        return $this->_getJson('post', $url);
    }

    function scheduleStageFare($param = array()) {
        $url = '/' . $this->_user_hash . '/trip/fare/stage/schedule?scheduleCode=' . $param['scheduleCode'];
        return $this->_getJson('get', $url);
    }
    
    function cargoOGPLupdate($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transit/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function vendorAliasUpdate($param = array()) {
        $this->rediscache->delete($this->rediscache->keys(self::REDIS_VENDOR . '*'));
        $url = '/' . $this->_user_hash . '/cargo/customer/vendor/alias/code/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function cargoOGPLload($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transit/details/update/' . $param['actionCode'] .'?activityType=' . $param['activityType'];
        unset($param['activityType']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function cargoOGPLDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transit/' . $param['transitCode'] . '/v2';
        return $this->_getJson('get', $url);
    }

    function cargoOGPLStatusUpdate($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transit/' . $param['transitCode'] . '/status/update/v2?type=' . $param['type'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function tripBookedTickets($param = array()) {
        $url = '/' . $this->_user_hash . '/commerce/trip/' . $param['tripCode'] . '/booked/ticket';
        return $this->_getJson('get', $url);
    }
    
    function loadTripGenderPreference($param = array()) {
        $url = '/' . $this->_user_hash . '/trip/seat/preference/' . $param['tripCode'];
        return $this->_getJson('get', $url);
    }

    function setTripGenderPreference($param = array()) {        
        $url = '/' . $this->_user_hash . '/trip/' . $param['tripCode'] . '/seat/preference/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function deleteTripGenderPreference($param = array()) {
        $url = '/' . $this->_user_hash . '/trip/' . $param['tripCode'] . '/seat/preference/remove';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getAllIntegrationType($param = array()) {
        $url = "/{$this->_user_hash}/namespace/integration/type";
        return $this->_getJson('get', $url);
    }

    function getIntegrationsByType($param = array()) {
        $url = "/{$this->_user_hash}/namespace/integration/type/{$param['integrationTypeCode']}";
        return $this->_getJson('get', $url);
    }

    function getAllIntegrations($param = array()) {
        $url = "/{$this->_user_hash}/namespace/integration";
        return $this->_getJson('get', $url);
    }

    function updateIntegrations($param = array()) {
        $url = "/{$this->_user_hash}/namespace/integration/update";
        return $this->_getJson('post', $url, json_encode($param), array('Content-Type' => 'application/json'));
    }

    function getVehicleAttendant($param = array()) {
        $url = '/' . $this->_user_hash .'/bus/vehicle/attendant';
        return $this->_getJson('get', $url);
    }

    function updateVehicleAttendant($param = array()) {
        $url = '/' . $this->_user_hash .'/bus/vehicle/attendant/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getPobOtp($param = array()) {
        $url = '/' . $this->_user_hash .'/tablet/generate/otp?mobileNumber=' . $param['mobileNumber'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getOGPLTemplate($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/transit/template';
        return $this->_getJson('get', $url);
    }

    function updateOGPLTemplate($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/transit/template/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function cargoGetOGPLListv2($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/transit/active/V2';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function cargoOGPLTransitDetail($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transit/details/' . $param['transitDetailCode'];
        return $this->_getJson('get', $url);
    }

    function sendEmailTicket($param = array()) {
        $url = '/' . $this->_user_hash . '/commerce/ticket/' . $param['pnr'] . '/notify/' . $param['type'] . '/v2?emailId=' . urlencode($param['emailId']);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function vanTripInfo($param = array()) {
        $url = '/' . $this->_user_hash . '/trip/van/info/' . $param['vehicleVanCode'] . '/' . $param['tripDate'];
        return $this->_getJson('get', $url);
    }
    
    function updateVanTripInfo($param = array()) {
        $url = '/' . $this->_user_hash . '/trip/van/info/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function notifyVanTripInfo($param = array()) {
        $url = '/' . $this->_user_hash . '/notification/van/pickup/notify/' . $param['tripinfocode'] . '/v2/';
        $param = json_encode($param['ticketCodes']);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getFareRuleList() {
        $url = '/' . $this->_user_hash . '/fare/rules';
        $param = array();
        return $this->_getJson('get', $url);
    }

    function updateFareRuleList($param = array()) {
        $url = '/' . $this->_user_hash . '/fare/rules/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getFareRuleFareList($param = array()) {
        $url = '/' . $this->_user_hash . '/fare/rules/details/'.$param['ruleCode'] . '?fromStationCode='.$param['fromStationCode'] . '&toStationCode='.$param['toStationCode'];
        $param = array();
        return $this->_getJson('get', $url);
    }

    function updateFareRuleFareList($param = array()) {
        $url = '/' . $this->_user_hash . '/fare/rules/'.$param['ruleCode'].'/details/update';
        $param = json_encode($param['fares']);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function OGPLLoadedByvehicle($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transit/vehicle/'.$param['vehicleCode'].'/unload';
        return $this->_getJson('get', $url);
    }

    function getAllSector($param = array()) {
        $url = '/' . $this->_user_hash . '/sector/?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function getUserSector($param = array()) {
        $url = '/' . $this->_user_hash . '/schedule/sector';
        return $this->_getJson('get', $url);
    }

    function getSectorByCode($param = array()) {
        $url = '/' . $this->_user_hash . '/sector/'.$param['sectorCode'];
        return $this->_getJson('get', $url);
    }
    
    function updateSector($param = array()) {
        $url = '/' . $this->_user_hash . '/sector/update/';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateSectorSchedule($param = array()) {
        $url = '/' . $this->_user_hash . '/sector/'.$param['sectorCode'].'/schedule/'.$param['scheduleCode'].'/'.$param['actionCode'].'/';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateSectorVehicle($param = array()) {
        $url = '/' . $this->_user_hash . '/sector/'.$param['sectorCode'].'/vehicle/'.$param['vehicleCode'].'/'.$param['actionCode'].'/';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateSectorStation($param = array()) {
        $url = '/' . $this->_user_hash . '/sector/'.$param['sectorCode'].'/station/'.$param['stationCode'].'/'.$param['actionCode'].'/';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateSectorOrganization($param = array()) {
        $url = '/' . $this->_user_hash . '/sector/'.$param['sectorCode'].'/organization/'.$param['organizationCode'].'/'.$param['actionCode'].'/';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function mapSectorUser($param = array()) {
        $url = '/' . $this->_user_hash . '/sector/'.$param['sectorCode'].'/user/'.$param['userCode'].'/'.$param['actionCode'];
        return $this->_getJson('post', $url);
    }

    function getMapSectorUser($param = array()) {
        $url = '/' . $this->_user_hash . '/sector/'.$param['sectorCode'].'/user/';
        return $this->_getJson('get', $url);
    }
    
    function getAllBanner($param = array()) {
        $url = '/' . $this->_user_hash . '/namespace/banner/?activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }
    
    function updateBanner($param = array()) {
        $url = '/' . $this->_user_hash . '/namespace/banner/update/';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function updateBannerDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/namespace/banner/details/update';
        $param = json_encode($param, JSON_UNESCAPED_SLASHES);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getCommerceBanners($param = array()) {
        $url = '/' . $this->_user_hash . '/commerce/banner';
        return $this->_getJson('get', $url);
    }
    
    function cancelRechargePendingOrder($param = array()) {
         $url = '/' . $this->_user_hash .'/ticket/transaction/pending/cancel';
        return $this->_getJson('post', $url, $param);
    }
    
    function confirmRechargePendingOrder($param = array()) {
        $url = '/' . $this->_user_hash .'/user/transaction/recharge/pending/order/'.$param['ordercode'].'/confirm';
        return $this->_getJson('post', $url, $param);
    }
    
    function moveFailureToPending($param = array()) {
        $url = '/' . $this->_user_hash .'/ticket/transaction/failure/pending/update?ticketCode='.$param['ticketCode'];                
        return $this->_getJson('post', $url);
    }

    function getScheduleSeatVisibilityAuditReport($param = array()) {
        $url = '/' . $this->_user_hash .'/schedule/seatvisibility/'.$param['travelDate'].'/v2';
        return $this->_getJson('get', $url, $param);
        //echo $url;
    }
    
    function menuAssignedUsers($param = array()) {
        $url = '/' . $this->_user_hash .'/menu/'.$param['menuCode'].'/assign';
        return $this->_getJson('post', $url);
    }
    
    function getCargoRateTerms($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/rate/terms';
        return $this->_getJson('get', $url);
    }

    function updateCargoRateTerms($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/rate/terms/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function getScheduleTags($param = array()) {
        $url = '/' . $this->_user_hash .'/schedule/tag';
        return $this->_getJson('get', $url);
    }

    function updateScheduleTags($param = array()) {
        $url = '/' . $this->_user_hash .'/schedule/tag/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function cargoRateTermsRoute($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/rate/terms/'.$param['fromOrganizationCode'].'/'.$param['toOrganizationCode'];
        return $this->_getJson('get', $url);
    }

    function getTripVehicleDriver($param = array()) {
        $url = '/' . $this->_user_hash .'/trip/driver';
        return $this->_getJson('get', $url);
    }

    function getTripVehicleAttendant($param = array()) {
        $url = '/' . $this->_user_hash .'/trip/attendant';
        return $this->_getJson('get', $url);
    }

    function refundTicketFromPending($param = array()) {
        $url = '/' . $this->_user_hash .'/payment/transaction/refund';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getMobileBlock($param = array()) {
        $url = '/' . $this->_user_hash .'/ticket/phone/number/block';
        return $this->_getJson('get', $url);
    }

    function updateMobileBlock($param = array()) {
        $url = '/' . $this->_user_hash .'/ticket/phone/number/block/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }
    
    function validatePhoneBooking($param = array()) {
        $url = '/' . $this->_user_hash .'/ticket/phone/number/block/'.$param['phone'].'/validate';
        return $this->_getJson('get', $url);
    }
    
    function scheduleBusUtilization($param = array()) {
        $url = '/' . $this->_user_hash .'/schedule/bus/'.$param['busCode'].'/utilize';
        return $this->_getJson('get', $url);
    }

    function getBreakevenSettings($param = array()) {
        $url = '/' . $this->_user_hash . '/bus/breakeven/settings';
        return $this->_getJson('get', $url);
    }

    function updateBreakevenSettings($param = array()) {
        $url = '/' . $this->_user_hash . '/bus/breakeven/settings/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function integrationAuthVerify($param = array()) {
        $url = '/auth/' . $param['authtoken'] . '/account/' . $param['accountCode'] . '/integrationtype/' . $param['typeCode'] . '/verify';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function integrationUsers($param = array()) {
        $url = '/' . $this->_user_hash . '/user/integration/type/' . $param['typeCode'];
        return $this->_getJson('get', $url);
    }
    
    function getCargoSettings($param = array()) {
        if( !$json = $this->rediscache->get(self::REDIS_CARGOSETTINGS)) {
            $url = '/' . $param ['authtoken'] . '/cargo/settings';
            $json = $this->_getJson('get', $url);
            $result = json_decode($json);
            if ($result->status != 1) {
                return $json;
            }
            $this->rediscache->set(self::REDIS_CARGOSETTINGS, $json, self::REDIS_DURATION);
        }
        return $json;
    }
    
    function updateCargoSettings($param = array()) {
        $this->rediscache->delete(self::REDIS_CARGOSETTINGS);

        $url = '/' . $this->_user_hash . '/cargo/settings/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function cargoUpdateRecharge($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/payment/recharge/initiate';
        $param = json_encode($param);

        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
        ));
    }

    function integrationVehicles($param = array()) {
        $url = '/' . $this->_user_hash . '/bus/vehicle/integration/type/' . $param['typeCode'];
        return $this->_getJson('get', $url);
    }

    function integrationDrivers($param = array()) {
        $url = '/' . $this->_user_hash . '/bus/vehicle/driver/integration/type/' . $param['typeCode'];
        return $this->_getJson('get', $url);
    }

    function integrationAttendants($param = array()) {
        $url = '/' . $this->_user_hash . '/bus/vehicle/attendant/integration/type/' . $param['typeCode'];
        return $this->_getJson('get', $url);
    }

    function getPaymentReceipt($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/payment/receipts?fromDate=' . $param['fromDate'] . '&toDate=' . $param['toDate'] . '&userCode=' . $param['userCode'] . '&paymentAcknowledgeStatus=' . $param['paymentAcknowledgeStatus'] . '&userRoleCode=' . $param['userRoleCode'];
        return $this->_getJson('get', $url);
    }

    function updatePaymentReceipt($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/payment/receipt/add';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updatePaymentReceiptStatus($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/payment/receipt/status/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getSMSProvider($param = array()) {
        $url = '/' . $this->_user_hash . '/namespace/sms/provider';
        return $this->_getJson('get', $url, $param);
    }

    function getCargoRemarks($param = array()) {
        if (!$json = $this->rediscache->get(self::REDIS_REMARKS)) {
            $url = '/' . $this->_user_hash . '/cargo/remarks';
            $json = $this->_getJson('get', $url, $param);
            $this->rediscache->set(self::REDIS_REMARKS, $json, self::REDIS_DURATION);
        }
        return $json;
    }

    function getCargoRemarksByStatus($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/remarks/status/' . $param['cargoStatusCode'];
        return $this->_getJson('get', $url, $param);
    }

    function getCargoRemarksBooking($param = array()) {
        if(!$json = $this->rediscache->get(self::REDIS_CBREMARKS)) {
            $url = '/' . $this->_user_hash . '/cargo/remarks/status/CB';
            $json = $this->_getJson('get', $url, $param);
            $this->rediscache->set(self::REDIS_CBREMARKS, $json, self::REDIS_DURATION);
        }
        return $json;
    }

    function getCargoRemarksDelivery($param = array()) {
        if(!$json = $this->rediscache->get(self::REDIS_CDREMARKS)) {
            $url = '/' . $this->_user_hash . '/cargo/remarks/status/CD';
            $json = $this->_getJson('get', $url, $param);
            $this->rediscache->set(self::REDIS_CDREMARKS, $json, self::REDIS_DURATION);
        }
        return $json;
    }

    function updateCargoRemarks($param = array()) {
        $this->rediscache->delete(self::REDIS_REMARKS);
        $this->rediscache->delete(self::REDIS_CBREMARKS);
        $this->rediscache->delete(self::REDIS_CDREMARKS);

        $url = '/' . $this->_user_hash . '/cargo/remarks/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function sendDeliveryOtp($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/' . $param['cargoCode'] . '/otp/generate?otpCustomerType=' . $param['otpCustomerType'];        
        return $this->_getJson('post', $url);
    }

    function getImageDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/image/details/' . $param['referenceCode'] . '/' . $param['imageCategoryCode'];
        return $this->_getJson('get', $url, $param);
    }

    function saveImageDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/image/details/' . $param['referenceCode'] . '/' . $param['imageCategoryCode'] . '/update?action=' . $param['action'];
        $param = json_encode($param['imageDetails']);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
	
	function sendMobileVerifyOTP($param = array()) {
        $url = '/' . $this->_user_hash .'/user/profile/generate/otp?mobileNumber='.$param['mobile'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function verifyMobileOTP($param = array()) {
        $url = '/' . $this->_user_hash .'/user/profile/validate/otp/'.$param['otp'].'?mobileNumber='.$param['mobile'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getUserAlertSubscriptions($param = array()) {
        $url = '/' . $this->_user_hash .'/notification/subscription';
        return $this->_getJson('get', $url);
    }

    function updateAlertSubscriptions($param = array()) {
        $url = '/' . $this->_user_hash .'/notification/subscription/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getAlertEventsTypes($param = array()) {
        $url = '/' . $this->_user_hash .'/notification/subscription/type';
        return $this->_getJson('get', $url);
    }

    function getNotificationSubscription($param = array()) {
        $url = '/' . $this->_user_hash .'/notification/subscription/authorize/'.$param['deviceMedium'];
        return $this->_getJson('get', $url);
    }

    function authNotificationSubscription($param = array()) {
        $url = '/' . $this->_user_hash .'/notification/subscription/authenticate/'.$param['deviceMedium'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function revokeNotificationSubscription($param = array()) {
        $url = '/' . $this->_user_hash .'/notification/subscription/authorize/revoke/'.$param['authenticateCode'] . '/' .$param['deviceMedium'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getNsAlertSubscriptions($param = array()) {
        $url = '/' . $this->_user_hash .'/namespace/notification/subscription';
        return $this->_getJson('get', $url);
    }

    function updateNsAlertSubscriptions($param = array()) {
        $url = '/' . $this->_user_hash .'/namespace/notification/subscription/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getEventNotifications($param = array()) {
        $url = '/' . $this->_user_hash .'/notification/subscription/user';
        return $this->_getJson('get', $url);
    }

    function updateEventNotifications($param = array()) {
        $url = '/' . $this->_user_hash .'/notification/subscription/user/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
                    'Content-Type' => 'application/json'
                ));
    }

    function getLrRelatedOGPL($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/transit/relate/' . $param['cargoCode'] . '/' . $param['tripDate'];
        return $this->_getJson('get', $url);
    }

    function getStationCustomers($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/customer/' . $param['stationCode'] . '/v2';
        return $this->_getJson('get', $url);
    }

    function getStationCustomersV3($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/customer/' . $param['stationCode'] . '/v3?limit=15000&filterType=3_MONTH_BO_COUNT';
        return $this->_getJson('get', $url);
    }

    function getCustomersByReference($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/customer/by/reference?' . http_build_query($param);
        return $this->_getJson('get', $url);
    }

    function getAlertSubscriptionsReport($param = array()) {
        $url = '/' . $this->_user_hash . '/notification/subscription/report?subscriptionTypeCode=' . $param['subscriptionTypeCode'];
        return $this->_getJson('get', $url);
    }

    function notificationSmsTypes($param = array()) {
        $url = '/' . $this->_user_hash . '/' . $param['namespaceCode'] . '/notification/sms/types';
        return $this->_getJson('get', $url, $param);
    }

    function notificationSmsConfig($param = array()) {
        $url = '/' . $this->_user_hash . '/' . $param['namespaceCode'] . '/notification/sms/config';
        return $this->_getJson('get', $url, $param);
    }

    function updateNotificationSmsConfig($param = array()) {
        $url = '/' . $this->_user_hash .  '/' . $param['namespaceCode'] . '/notification/sms/config/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function smsTemplateConfig($param = array()) {
        $url = '/' . $this->_user_hash . '/' . $param['namespaceCode'] . '/notification/sms/template/config/' . $param['smsConfigCode'];
        return $this->_getJson('get', $url, $param);
    }
       
    function updateSmsTemplateConfig($param = array()) {
        $url = '/' . $this->_user_hash .  '/' . $param['namespaceCode'] . '/notification/sms/template/config/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function resendCargoSMS($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/' . $param['cargoCode'] . '/notify?mobileNumber=' . $param['mobileNumber'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function verifyVendorEmail($param = array()) {
        $this->rediscache->delete($this->rediscache->keys(self::REDIS_VENDOR . '*'));
        $url = '/api/vendor/HXXJFEHP79Q69NZP/' . $param['ns'] .'/email/update';
        unset($param['url']);
        unset($param['ns']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function sendVendorEmail($param = array()) {
        $this->rediscache->delete($this->rediscache->keys(self::REDIS_VENDOR . '*'));
        $url = '/' . $this->_user_hash . '/cargo/customer/vendor/email/verify?url=' . urlencode($param['url']);
        unset($param['url']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getPrebookingByCode($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/pre/book/' . $param['preBookCode'] . '/details';
        return $this->_getJson('get', $url, $param);
    }

    function getPrebookingByMobile($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/pre/book/details/' . $param['customerMobile'];
        return $this->_getJson('get', $url, $param);
    }

    function getUnbookedPrebooking($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/pre/book/unconfirmed/' . $param['referenceNumber'] . '?stationCode=' . $param['stationCode'];
        return $this->_getJson('get', $url, $param);
    }

    function deletePrebookingRequest($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/pre/book/delete/' . $param['code'];
        return $this->_getJson('post', $url);
    }

    function getRateCardTemplate() {
        $url = '/' . $this->_user_hash . '/billing/subscription/ratecard/template';
        return $this->_getJson('get', $url);
    }

    function updateRateCardTemplate($param = array()) {
        $url = '/' . $this->_user_hash . '/billing/subscription/ratecard/template/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getRateCardTerms() {
        $url = '/' . $this->_user_hash . '/billing/subscription/ratecard/terms';
        return $this->_getJson('get', $url);
    }

    function updateRateCardTerms($param) {
        $url = '/' . $this->_user_hash . '/billing/subscription/ratecard/terms/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateRateCardEvents($param) {
        $url = '/' . $this->_user_hash . '/billing/subscription/event/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getBillingOverview() {
        $url = '/' . $this->_user_hash . '/billing/subscription/overview';
        return $this->_getJson('get', $url);
    }

    function getBillingInvoice() {
        if( !$json = $this->rediscache->get(self::REDIS_SUBS_INVOICE)) {
            $url = '/' . $this->_user_hash . '/billing/subscription/invoice/details';
            $json = $this->_getJson('get', $url, $param);
            $this->rediscache->set(self::REDIS_SUBS_INVOICE, $json, self::REDIS_DURATION);
        }
        return $json;
    }

    function getBillingStatus() {
        $url = '/' . $this->_user_hash . '/namespace/subscription/invoice/status';
        return $this->_getJson('get', $url);
    }

    function refreshBillingStatus() {
        $this->rediscache->delete(self::REDIS_SUBS_INVOICE);
        $url = '/' . $this->_user_hash . '/billing/subscription/check/status';
        return $this->_getJson('get', $url);
    }

    function editCargoServiceTax($param) {
        $url = '/' . $this->_user_hash . '/cargo/edit/service/tax?serviceTaxEditFlag='.$param['serviceTaxEditFlag'];
        unset($param['serviceTaxEditFlag']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateReturnBooking($param) {
        $url = '/' . $this->_user_hash . '/cargo/' . $param['cargoCode'] . '/return/booking';
        unset($param['cargoCode']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function ogplRemoveLR($param) {
        $url = '/' . $this->_user_hash . '/cargo/' . $param['cargoCode'] . '/transit/details/' . $param['transitDetailsCode'] . '/remove';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function cargoTags($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/tag?categoryCode=' . $param['categoryCode'] . '&activeFlag=' . $param ['activeFlagFilter'];
        return $this->_getJson('get', $url);
    }

    function updateCargoTags($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/tag/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getLRRemarks($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/' . $param['cargoCode'] . '/booking/remarks';
        return $this->_getJson('get', $url);
    }

    function updateRemarks($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/' . $param['cargoCode'] . '/booking/remarks/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getUserMenuReport($param = array()) {
        $url = '/' . $this->_user_hash .'/menu/user/permission?userCodes=' . $param['userCodes'];
        return $this->_getJson('get', $url);
    }

    function getCashbookHead() {
        $url = '/' . $this->_user_hash .'/cashbook/type';
        return $this->_getJson('get', $url);
    }

    function updateCashbookHead($param) {
        $url = '/' . $this->_user_hash . '/cashbook/type/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getCashbookVendor() {
        $url = '/' . $this->_user_hash .'/cashbook/vendor';
        return $this->_getJson('get', $url);
    }

    function updateCashbookVendor($param) {
        $url = '/' . $this->_user_hash . '//cashbook/vendor/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getCashbookTransaction() {
        $url = '/' . $this->_user_hash .'/cashbook/vendor';
        return $this->_getJson('get', $url);
    }

    function updateCashbookTransaction($param) {
        $url = '/' . $this->_user_hash . '/cashbook/transaction/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateCashbookStatus($param) {
        $url = '/' . $this->_user_hash . '/cashbook/transaction/update/status';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function cargoPaymentTypeUpdate($param) {
        $url = '/' . $this->_user_hash . '/cargo/payment/type/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function searchOGPLV2($param) {
        $url = '/' . $this->_user_hash .'/cargo/transit/v2/details?vehicleCode=' . $param['vehicleCode'] . '&tripDate=' . $param['tripDate'] . '&transitType=' . $param['transitType'];
        return $this->_getJson('get', $url);
    }

    function OGPLV2EmptyLoad($param) {
        $url = '/' . $this->_user_hash . '/cargo/transit/v2/details/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function OGPLV2EmptyUnload($param) {
        $url = '/' . $this->_user_hash . '/cargo/transit/v2/status/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function undoUnloadLR($param) {
        $url = '/' . $this->_user_hash . '/cargo/transit/' . $param['cargoCode'] . '/undo/unload';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getSlugDetails($param) {
        $url = '/api/' . $param['accessToken'] . '/cargo/slug/details?slug=' . urlencode($param['slug']);
        return $this->_getJson('get', $url);
    }

    function checkDemurrageCharge($param) {
        $url = '/' . $this->_user_hash . '/cargo/' . $param['cargoCode'] . '/check/demurrage/charge';
        return $this->_getJson('get', $url);
    }

    function updateDeliveryPayment($param) {
        $url = '/' . $this->_user_hash . '/cargo/' . $param['cargoCode'] . '/pending/payment/update?bookByMyAccountCode=&offlineUserCode=' . $param['offlineUserCode'] . '&transactionMode=' . $param['transactionMode'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updatePaymentAndDelivery($param) {
        $url = '/' . $this->_user_hash . '/cargo/delivery/' . $param['cargoCode'] . '/status/update?transactionMode=' . $param['transactionMode'] . '&otpNumber=' . $param['otpNumber'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function organizationUserTransaction($param) {
        $url = '/' . $this->_user_hash . '/cargo/organization/user/transaction?userCode=' . $param['userCode'] . '&toDate=' . $param['toDate'];
        return $this->_getJson('get', $url, $param);
    }

    function saveOrganizationUserTransactions($param) {
        $url = '/' . $this->_user_hash . '/cargo/organization/user/transaction/save';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getBranchReceipt($param) {
        $url = '/' . $this->_user_hash . '/cargo/organization/user/transaction/history';
        return $this->_getJson('get', $url, $param);
    }

    function updateBranchReceiptStatus($param) {
        $url = '/' . $this->_user_hash . '/cargo/organization/user/transaction/update/status';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function organizationUserBalance($param) {
        $url = '/' . $this->_user_hash . '/cargo/organization/user/balance?' . http_build_query($param);
        return $this->_getJson('get', $url);
    }

    function getSalesSummary($param) {
        $url = '/' . $this->_user_hash . '/dashboard/sales/summary?' . http_build_query($param);
        return $this->_getJson('get', $url);
    }
    
    function refreshTransitData($param = []) {
        $url = '/' . $this->_user_hash . '/cargo/transit/' . $param['transitCode'] . '/status/refresh';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getTransferOgplList($param) {
        $url = '/' . $this->_user_hash . '/cargo/transit/active/V3';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function validateTransferOgpl($param) {
        $url = '/' . $this->_user_hash . '/cargo/transit/v2/transfer';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function confirmTransferOgpl($param) {
        $url = '/' . $this->_user_hash . '/cargo/transit/v2/confirm/transfer';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function updateVendorPassword($param) {
        $url = '/' . $this->_user_hash . '/cargo/customer/vendor/' . $param['vendorCode'] . '/resetpassword?newPassword=' . urlencode($param['newPassword']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function resetVehicleTransitStation($param) {
        $this->rediscache->delete(self::REDIS_VEHICLE);

        $url = '/' . $this->_user_hash . '/bus/vehicle/' . $param['vehicleCode'] . '/transit/station/reset?stationCode=' . $param['stationCode'] . '&organizationCode=' . $param['organizationCode'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function checkCargoCodeExists($param) {

        $url = '/' . $this->_user_hash . '/cargo/manual/code/check';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function generateBookingSequence($param) {
        $url = '/' . $this->_user_hash . '/cargo/booking/prefix/code/generate';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function generateNextLrSequence($param) {
        $url = '/' . $this->_user_hash . '/cargo/booking/generate/next/sequence';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function generateNextOGPLSequence($param) {
        $url = '/' . $this->_user_hash . '/cargo/transit/generate/next/sequence';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function saveCargoDocument($param) {
        $url = '/' . $this->_user_hash . '/cargo/document/' . $param['cargoCode'] . '/save';
        $param = json_encode($param['imageDetails']);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getCargoDocument($param) {
        $url = '/' . $this->_user_hash . '/cargo/document/' . $param['cargoCode'] . '?documentCategoryCode=';
        return $this->_getJson('get', $url);
    }

    function revertUnableDeliver($param) {
        $url = '/' . $this->_user_hash . '/cargo/' . $param['cargoCode'] . '/status/' . $param['cargoStatusCode'] . '/revert';
        $param = json_encode($param['data']);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function branchIEDetails($param) {
        $url = '/' . $this->_user_hash . '/cashbook/transaction';
        return $this->_getJson('get', $url, $param);
    }

    function getTransitEwayBillLR($param) {
        $url = '/' . $this->_user_hash . '/eway/bill/transit/' . $param['transitCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updateEwaybillVehicle($param) {
        $url = '/' . $this->_user_hash . '/eway/bill/vehicle/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getEwayBillDetails($param) {
        $url = '/' . $this->_user_hash . '/eway/bill/' . $param['ewayBillNo'] . '/details';
        return $this->_getJson('get', $url, $param);
    }

    function userAssignedBranches($param = array()) {
        $url = '/' . $this->_user_hash . '/organization/primary/user/assigned';
        return $this->_getJson('get', $url, $param);
    }

    function cargoUserBranches($param = array()) {
        $url = '/' . $this->_user_hash . '/user/' . $param['userCode'] . '/specific/organization';
        return $this->_getJson('get', $url, $param);
    }

    function saveUserBranches($param = array()) {
        $this->rediscache->delete('user_assigned_branches:' . $param['userCode']);
        $url = '/' . $this->_user_hash . '/user/' . $param['userCode'] . '/specific/organization/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getswitchBranch($param = array()) {
        $url = '/auth/' . $this->_user_hash . '/switch/organization/primary/user?organizationCode=' . $param['organizationCode'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updatePickupDelivery($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/edit/pickup/delivery/type';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getTariffRateCard($param = array()) {
        $url = '/' . $this->_user_hash . '/tariff/rate/card/applicable/items';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getAllTariff($param = array()) {
        $url = '/' . $this->_user_hash . '/tariff/rate/card?rateCardTypeCode=' . $param['rateCardTypeCode'];
        return $this->_getJson('get', $url, $param);
    }

    function getVendorAddress($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/customer/vendor/address?vendorCode=' . $param['vendorCode'] . '&addressCode=' . $param['addressCode'];
        return $this->_getJson('get', $url, $param);
    }

    function getTariff($param = array()) {
        $url = '/' . $this->_user_hash . '/tariff/rate/card/' . $param['tariffRateCardCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updateTariff($param = array()) {
        $url = '/' . $this->_user_hash . '/tariff/rate/card/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getCargoRoute($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/route';
        return $this->_getJson('get', $url, $param);
    }

    function updateCargoRoute($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/route/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getUnbilledLRList($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/unbilled?' . http_build_query($param);
        return $this->_getJson('get', $url, $param);
    }

    function generateInvoicePaymentv2($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/payment/invoice/generate/v2';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getInvoiceExtraIncomeExpense($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/payment/transaction/details?paymentTransactionCode=' . $param['paymentTransactionCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updateInvoiceExtraIncomeExpense($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/payment/transaction/details/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateUnpaidLR($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/booking/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getCustomer($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/customer/' . $param['customerCode'];
        return $this->_getJson('get', $url, $param);
    }

    function getTransitOdometer($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transit/' . $param['transitCode'] . '/odometer/details';
        return $this->_getJson('get', $url, $param);
    }

    function updateTransitOdometer($param = array()) {
        $this->rediscache->delete(self::REDIS_VEHICLE);

        $url = '/' . $this->_user_hash .'/cargo/transit/' . $param['transitCode'] . '/details/odometer/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    function editTransitOdometer($transit_code,$param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/transit/' . $transit_code . '/details/edit/odometer';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getTransitFuelDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/fuel/details/transit/' . $param['transitCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updateTransitFuelDetails($param = array()) {
        $url = '/' . $this->_user_hash .'/fuel/details/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function generateOtp() {
        $user_hash = ($this->_user_hash) ?: $this->session->userdata('temp_token');
        $url = 'auth/' . $user_hash .'/profile/generate/otp';
        return $this->_getJson('post', $url);
    }

    function verifyOTPNumber($param = array()) {
        $user_hash = ($this->_user_hash) ?: $this->session->userdata('temp_token');
        $url = 'auth/' . $user_hash .'/profile/validate/otp/' . $param['otpNumber'];;
        return $this->_getJson('post', $url);
    }

    function getTransitIncomeExpense($param = array()) {
        $url = '/' . $this->_user_hash . '/transit/transaction/transit/' . $param['transitCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updateTransitIncomeExpense($param = array()) {
        $url = '/' . $this->_user_hash .'/transit/transaction/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getTransitOdometerDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transit/' . $param['transitCode'] . '/odometer/details/V2';
        return $this->_getJson('get', $url, $param);
    }

    function getPaymentPreference($param = array()) {
        $url = '/' . $this->_user_hash . '/branch/payment/preference?organizationCode=' . $param['organizationCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updatePaymentPreference($param = array()) {
        $url = '/' . $this->_user_hash .'/branch/payment/preference/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getLedgerTransactionReport($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/organization/user/ledger/transactions?userCode=' . $param['userCode'] . '&fromDate=' . $param['fromDate'] . '&toDate' . $param['toDate'];
        return $this->_getJson('get', $url, $param);
    }

    function getLedgerReceipt($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/organization/user/transaction/details/' . $param['receiptDetailsCode'];
        return $this->_getJson('get', $url, $param);
    }

    function getPaymentReceiptRevert($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/payment/receipt/' . $param['receiptCode'];
        return $this->_getJson('get', $url, $param);
    }

    function revertPaymentReceipt($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/payment/receipt/revert';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateOrganizationOtherDetails($param = array()) {
        $p_key = _get_namespace_id() . '_cargo_organization';
        $this->rediscache->delete($p_key);
        
        $url = '/' . $this->_user_hash .'/organization/details/' . $param['code'] . '/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getOrganizationOtherDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/organization/details/' . $param['organizationcode'];
        return $this->_getJson('get', $url, $param);
    }

    function getNSNameFromCode($param = array()) {
        $url = "/auth/HXXJFEHP79Q69NZP/namespace/{$param['namespaceCode']}";
        return $this->_getJson('GET', $url);
    }

    function updateZone($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/zone/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getAllZone($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/zone';
        return $this->_getJson('get', $url, $param);
    }

    function cargoPaymentModeUpdate($param = array(), $cargoCode ) {
        $url = '/' . $this->_user_hash .'/cargo/'. $cargoCode . '/transaction/mode/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param ,array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getChequeDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/cheque/details?statusCode=' . $param['statusCode'] . '&organizationCode=' . $param['organizationCode'] . '&fromDate=' . $param['fromDate'] . '&toDate='  . $param['toDate'];
        return $this->_getJson('get', $url, $param);
    }

    function updateChequeStatus($param = array()) {
        $url = '/' . $this->_user_hash .'/cheque/details/status/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getChequeHistory($param = array()) {
        $url = '/' . $this->_user_hash . '/cheque/details/' . $param['chequeDetailsCode'] . '/history';
        return $this->_getJson('get', $url, $param);
    }

    function getGSTDetailsApi($param = array()) {
        $url = '/' . $this->_user_hash .'/eway/bill/check/gstin/' . $param['gstin'];
        return $this->_getJson('post', $url);
    }

    function getAllTransactionReceipt($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transaction/receipt/history?' . http_build_query($param);
        return $this->_getJson('get', $url, $param);
    }
    
    function getAllAdvancePaymentList($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transaction/receipt/history?'. '&fromDate=' . $param['fromDate'] . '&toDate' . $param['toDate'];
        return $this->_getJson('get', $url, $param);
    }

    function getTransactionReceipt($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transaction/receipt/' . $param['receiptCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updateTransactionReceipt($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/transaction/receipt/add';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateTransactionReceiptStatus($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/transaction/receipt/status/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateTransactionReceiptCheque($param = array()) {
        $url = '/' . $this->_user_hash .'/cheque/details/'.$param['checkCode'].'/transaction/receipt/update';
        unset($param['checkCode']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }
    
    function getAllBranchContact($param = array()) {
        $url = '/' . $this->_user_hash . '/organization/contact?organizationCode=' . $param['organizationCode'] . '&categoryCode=' . $param['categoryCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updateBranchContact($param = array()) {
        $url = '/' . $this->_user_hash .'/organization/contact/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getAllDeliveryAcknowledgement($param = array()) {
        $url = '/' . $this->_user_hash . '/delivery/acknowledgement?fromDate=' . $param['fromDate'] . '&toDate=' . $param['toDate'] . '&fromOrganizationCode=' . $param['fromOrganizationCode'] . '&toOrganizationCode=' . $param['toOrganizationCode'] . '&statusCode=' . $param['statusCode'];
        return $this->_getJson('get', $url, $param);
    }

    function getAllDeliveryAcknowledgementLr($param = array()) {
        $url = '/' . $this->_user_hash . '/delivery/acknowledgement/applicable/cargo?fromDate=' . $param['fromDate'] . '&toDate=' . $param['toDate'] . '&organizationCode=' . $param['organizationCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updateDeliveryAcknowledgement($param = array()) {
        $url = '/' . $this->_user_hash .'/delivery/acknowledgement/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateDeliveryAcknowledgementStatus($param = array()) {
        $url = '/' . $this->_user_hash .'/delivery/acknowledgement/status/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function validateTransitLinking($param = array()) {
        $url = '/' . $this->_user_hash .'/cargo/transit/' . $param['transitCode'] . '/link/applicable';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getAllInvoiceAcknowledgement($param = array()) {
        $url = '/' . $this->_user_hash . '/invoice/acknowledgement?fromDate=' . $param['fromDate'] . '&toDate=' . $param['toDate'] . '&organizationCode=' . $param['organizationCode'] . '&vendorCode=' . $param['vendorCode'] . '&statusCode=' . $param['statusCode'];
        return $this->_getJson('get', $url, $param);
    }

    function getAllInvoiceAcknowledgementUnpaidInvoice($param = array()) {
        $url = '/' . $this->_user_hash . '/invoice/acknowledgement/applicable/payment/transactions?organizationCode=' . $param['organizationCode'] . '&vendorCode=' . $param['vendorCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updateInvoiceAcknowledgement($param = array()) {
        $url = '/' . $this->_user_hash .'/invoice/acknowledgement/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateInvoiceAcknowledgementStatus($param = array()) {
        $url = '/' . $this->_user_hash .'/invoice/acknowledgement/status/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getContactCategory($param = array()) {
        $url = '/' . $this->_user_hash .'/contact/category/details';
        return $this->_getJson('get', $url);
    }

    function getContactv2($param = array()) {
        $url = '/' . $this->_user_hash . '/contact/active/v2?entityTypeCode=' . $param ['entityTypeCode'] . '&tag=' . $param ['tag'];
        return $this->_getJson('get', $url);
    }

    function getLedgerTransactionReportv2($param = array()) {
        $url = '/' . $this->_user_hash .'/ledger/transaction?' . http_build_query($param);
        return $this->_getJson('get', $url);
    }

    function updateLedgerAdjustment($param = array()) {
        $url = '/' . $this->_user_hash .'/ledger/transaction/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getContraTransferList($param = array()) {
        $url = '/' . $this->_user_hash . '/organization/contra?fromDate=' . $param['fromDate'] . '&toDate=' . $param['toDate'] . '&paymentStatusCode=' . $param['paymentStatusCode'] . '&organizationCode=' . $param['organizationCode'] ;
        return $this->_getJson('get', $url, $param);
    }

    function updateContraTransfer($param = array()) {
        $url = '/' . $this->_user_hash .'/organization/contra/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateContraTransferStatus($param = array()) {
        $url = '/' . $this->_user_hash .'/organization/contra/update/status';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getConsolidateEWayBillDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/eway/bill/consolidate/' . $param['consEwayBillNo'] . '/details';
        return $this->_getJson('get', $url, $param);
    }

    function generateConsolidateEwaybill($param = array()) {
        $url = '/' . $this->_user_hash .'/eway/bill/consolidate/generate';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function refreshOGPLData($param = []) {
        $url = '/' . $this->_user_hash . '/cargo/transit/' . $param['transitCode'] . '/status/refresh';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function refreshOGPLV2Data($param = []) {
        $url = '/' . $this->_user_hash . '/cargo/transit/' . $param['transitCode'] . '/status/refresh/V2';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getSubscriptionReportList($param = array()) {
        $url = '/' . $this->_user_hash . '/billing/subscription/privilege/disable/report?days=' . $param['days'];
        return $this->_getJson('get', $url, $param);
    }

    function updateCargoBookingDate($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/edit/booking/date';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getVehicleTariff($param = array()) {
        $url = '/' . $this->_user_hash . '/vehicle/tariff/details?vehicleCode=' . $param['vehicleCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updateVehicleTariff($param = array()) {
        $url = '/' . $this->_user_hash . '/vehicle/tariff/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function dashboardExpenseSummary($param = array()) {
        $url = '/' . $this->_user_hash . '/dashboard/manage/expense?organizationCode=' . $param['organizationCode'];
        return $this->_getJson('get', $url, $param);
    }

    function dashboardDayCloseSummary($param = array()) {
        $url = '/' . $this->_user_hash . '/dashboard/branch/day/close?organizationCode=' . $param['organizationCode'] . '&userCode=' . $param['userCode'];
        return $this->_getJson('get', $url, $param);
    }

    function cargoVendorContactBalance($param = array()){
        $url = '/' . $this->_user_hash .'/contact/' . $param['contactCode'] . '/balance?mobileNumber=' . $param['mobileNumber'];
        return $this->_getJson('get', $url);
    }

    function getTransitTransaction($param = array()){
        $url = '/' . $this->_user_hash .'/transit/transaction/unpaid?vehicleCode=' . $param['vehicleCode'] . '&contactCode=' . $param['contactCode'] . '&cashbookTypeCode=' . $param['cashbookTypeCode'] . '&fromDate=' . $param['fromDate'] . '&toDate=' . $param['toDate'];
        return $this->_getJson('get', $url);
    }

    function updateManageExpensePayment($param = array()) {
        $url = '/' . $this->_user_hash .'/transit/transaction/payment/settlement?vehicleCode=' . $param['vehicleCode'] . '&cashbookTypeCode=' . $param['cashbookTypeCode'];
        $param = json_encode($param['data']);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function loadablePrebookList($param = array()){
        $url = '/' . $this->_user_hash .'/cargo/pre/book/transit/applicable?' . http_build_query($param);
        return $this->_getJson('get', $url);
    }

    function loadPrebookList($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transit/details/pre/book/' . $param['actionCode'];
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updatePrebookCargoStatus($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transit/' . $param['transitCode'] . '/pre/book/unload';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getRevertLrDetailsTransactions($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/organization/user/' . $param['userCode'] . '/transaction/details/' . $param['filterType'] . '?fromDateTime=' . urlencode($param['fromDate']) . '&toDateTime=' . urlencode($param['toDate']);
        return $this->_getJson('get', $url);
    }

    function getVehicleTariffList($param = array()){
        $url = '/' . $this->_user_hash . '/vehicle/tariff/details/' . $param['vehicleCode'] . '/report?fromDate=' . $param['fromDate'] . '&toDate=' . $param['toDate'];
        return $this->_getJson('get', $url);
    }

    function getDayClosingReportList($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/organization/user/day/closing/transaction/' . $param['reportType'] . '/report?fromDate=' . $param['fromDate'] . '&toDate=' . $param['toDate'] . '&organizationCode=' . $param['organizationCode'] . '&userCode=' . $param['userCode'] . '&stationCodes=' . $param['stationCodes'];
        return $this->_getJson('get', $url);
    }

    function getJournalTransactionList($param = array()){
        $url = '/' . $this->_user_hash . '/journal/transaction?' . http_build_query($param);
        return $this->_getJson('get', $url);
    }

    function updateJournalTransaction($param = array()) {
        $url = '/' . $this->_user_hash . '/journal/transaction/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateJournalStatus($param = array()) {
        $url = '/' . $this->_user_hash . '/journal/transaction/acknowledge/status/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getDayCloseSetting($param = array()){
        $url = '/' . $this->_user_hash . '/organization/day/close/settings';
        return $this->_getJson('get', $url);
    }

    function updateDayCloseSetting($param = array()) {
        $url = '/' . $this->_user_hash . '/organization/day/close/settings/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getBranchBookingControl($param = array()){
        $url = '/' . $this->_user_hash . '/organization/booking/control';
        return $this->_getJson('get', $url);
    }

    function updateBranchBookingControl($param = array()) {
        $p_key = _get_namespace_id() . '_cargo_organization';
        $this->rediscache->delete($p_key);
        $url = '/' . $this->_user_hash . '/organization/booking/control/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateUserPaymentType($param = array()) {
        $url = '/' . $this->_user_hash . '/user/update/booking/payment/type';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getVendorAdvanvcePayment($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/payment/vendor/' . $param['vendorCode'] . '/' . $param['fromDate'] . '/' . $param['toDate'];
        return $this->_getJson('get', $url);
    }

    function getDeliveryReceipt($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transaction/receipt/' . $param['receiptType'] . '/' . $param['referenceCode'];
        return $this->_getJson('get', $url, $param);
    }

    function updateLedgerBrsStatus($param = array()) {
        $url = '/' . $this->_user_hash . '/ledger/transaction/update/ledger/status';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateContactCategory($param = array()) {
        $url = '/' . $this->_user_hash . '/contact/category/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getExpenseLedger($param = array()) {
        $url = '/' . $this->_user_hash . '/cashbook/transaction?fromDate=' . $param['fromDate'] . '&toDate=' . $param['toDate'] . '&organizationCode=' . $param['organizationCode'] . '&organizationReceiptCode=' . $param['organizationReceiptCode'] . '&entryTypeCode=' . $param['entryTypeCode'];
        return $this->_getJson('get', $url);
    }

    function updateExpenseLedgerStatus($param = array()) {
        $url = '/' . $this->_user_hash . '/cashbook/transaction/update/status';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getTransactionReceiptByReceiptType($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/transaction/receipt/' . $param['receiptType'] . '/' . $param['referenceCode'] . '?action=' . $param['action'];
        return $this->_getJson('get', $url);
    }

    function getReceiptEntry($param = array()) {
        $url = '/' . $this->_user_hash . '/transit/transaction/receipt/entries?fromDate=' . $param['fromDate'] . '&toDate=' . $param['toDate'] . '&organizationCode=' . $param['organizationCode'];
        return $this->_getJson('get', $url);
    }

    function updateReceiptEntry($param = array()) {
        $url = '/' . $this->_user_hash . '/transit/transaction/receipt/entry/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateReceiptEntryStatus($param = array()) {
        $url = '/' . $this->_user_hash . '/transit/transaction/receipt/entry/status/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function lrCodeValidation($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/booking/validate';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getBranchBankContactDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/contact/contra/transfer';
        return $this->_getJson('get', $url);
    }

    function mergeCustomerVendor($param = array()) {
        $this->rediscache->delete($this->rediscache->keys(self::REDIS_VENDOR . '*'));
        $url = '/' . $this->_user_hash . '/cargo/customer/vendor/merge?action=' . $param['action'];
        unset($param['action']);
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function lrQuickFind($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/quick/find/' . $param['code'];
        return $this->_getJson('get', $url);
    }

    function updateManageExpenseComments($param = array()) {
        $url = '/' . $this->_user_hash . '/cashbook/transaction/comments/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getAllPendingPayments($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/organization/user/day/close/pending/payment/details?organizationCode=' . $param['organizationCode'] . '&userCode=' . $param['userCode'];
        return $this->_getJson('get', $url);
    }

    function getPendingPayment($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/organization/user/day/close/pending/payment/details?organizationCode=' . $param['organizationCode'] . '&userCode=' . $param['userCode'] . '&receiptDetailsCode=' . $param['receiptDetailsCode'];
        return $this->_getJson('get', $url);
    }

    function updateNspRPtDays($param = array()){
        $url = '/' . $this->_user_hash . '/group/update/reporting/days';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getGroupWisePaymentModel($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/payment/model';
        return $this->_getJson('get', $url);
    }

    function updateAccountModel($param = array()){
        $url = '/' . $this->_user_hash . '/cargo/payment/model/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function updateTransitPayment($param = array()){
        $url = '/' . $this->_user_hash . '/transit/payment/details/update';
        $param = json_encode($param);
        return $this->_getJson('post', $url, $param, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getAllTransaction($param = array()){
        $url = '/' . $this->_user_hash . '/transit/payment/details/' . $param['transitCode'].'/'. $param['relatedStationCode'];
        return $this->_getJson('get', $url);
    }
    
    function getUserOrganization ($param = array()) {
        $url = '/' . $this->_user_hash . config_item('api_get_organization') . '/' . $param['organizationCode'];
        return $this->_getJson('get', $url);
    }

    function getBalanceSheet(){
        $url='/' . $this->_user_hash . '/cargo/payment/transaction/summary?organizationCode=&vendorCode=';
        return $this->_getJson('get', $url);  //staging
    }

    function balance_report() {
        $respose = json_decode($this->getBalanceSheet());
        $parent_data=array();
        $parent=array();
        $child=array();
        $child2=array();
        $child_data=array();
        $child2_data=array();
        $datas=$respose->data;
        foreach ($datas as $key => $value) {
            $parent['ven_unq']=$value->code;
            $parent['ven_name']=$value->companyName;
            $parent['paid_wait_ack_amt']=$value->paidWaitForAckAmount;
            $parent['unpaid_invoice_amt']=$unpaid_amt=$value->unPaidInvoiceAmount;
            $parent['booking_pending_amt']=$book_amount=$value->bookingAmount;
            $parent['total_amt']=$unpaid_amt+$book_amount+$value->paidWaitForAckAmount;
            $parent['branch']=$value->organization->name;
            foreach ($value->paymentTransactions as $index => $ch_val) {
                $child['parent_id']=$value->code;
                $child['invoice_id']=$ch_val->code;
                $child['cargo_code']=$ch_val->code;
                $child['booking_date']=$ch_val->transactionDate;
                $child['user']=$ch_val->transactionAmount;
                $child['payment_status']=$ch_val->transactionMode->code;
                $child['type']=$ch_val->acknowledgeStatus->code;  //condition for different types(unpaid,paid)
                $child['cargo_status']=$ch_val->code;
                $child['handleBy']=$ch_val->paymentHandledBy->name;
                $child_data[]=$child;
            }
          
            foreach ($value->bookingDetails as $index => $gr_ch_val) {
                $child2['parent_id']=$value->code;
                $child2['invoice_id']=$gr_ch_val->code;
                $child2['itemName']=$gr_ch_val->itemName;
                $child2['booking_date']=$gr_ch_val->bookedAt;
                $child2['from_station']=$gr_ch_val->fromStationName;
                $child2['fromOrganizationName']=$gr_ch_val->fromOrganizationName;
                $child2['toStationName']=$gr_ch_val->toStationName;
                $child2['toOrganizationName']=$gr_ch_val->toOrganizationName;
                $booking_amount=$gr_ch_val->totalAmount+$gr_ch_val->totalHandlingAmount+$gr_ch_val->totalUnloadHandlingAmount+$gr_ch_val->pickupHandlingAmount+$gr_ch_val->deliveryHandlingAmount+$gr_ch_val->otherChargesAmount+$gr_ch_val->serviceTax+$gr_ch_val->tdsTax;
                $child2['booking_amt']=$booking_amount;
                $child2['cargo_status']=$gr_ch_val->cargoStatusCode;
                $child2_data[]=$child2;
            }

            $parent['payment_details']=$child_data;
            $parent['booking_details']=$child2_data;
            $parent_data[]=$parent;
        }
       
        usort($parent_data, function($a, $b) {
            // return strcmp($a['ven_name'], $b['ven_name']);  //cap small differences
            return strcasecmp($a['ven_name'], $b['ven_name']); //whole row assending ordering
        });
        
        return $parent_data;
    }

    function special_booking_update($data){
        $url='/'.$this->_user_hash.'/cargo/edit/additional/details';
        return $this->_getJson('post', $url, $data, array(
            'Content-Type' => 'application/json'
        ));
    }

    function partition($data){
        $url='/'.$this->_user_hash.'/cargo/partition/booking';
        return $this->_getJson('post', $url, $data, array(
            'Content-Type' => 'application/json'
        ));
    }

    function get_lr_nodes($param){
        $url='/'.$this->_user_hash.'/cargo/'.$param.'/partition/details';
        return $this->_getJson('get', $url);
    }
    function get_partials($data){
        $url='/'.$this->_user_hash.'/cargo/partition/booking/v2';
        return $this->_getJson('post', $url, $data, array(
            'Content-Type' => 'application/json'
        ));
    }

    function getTransactionDetails($param){
        $url = '/' . $this->_user_hash . '/cargo/booking/'.$param.'/extras';
        return $this->_getJson('get', $url);
    }
    function endTrip($param = array()) {
        // $url = '/' . $this->_user_hash . '/cargo/transit/' . $param['transitCode'] . '/v2';
        $url = '/' . $this->_user_hash . '/cargo/transit/' . $param['transitCode'] . '/update/trip/close?organizationCode='.$param['organizationCode'];
        return $this->_getJson('post', $url);
    }
    function  get_vehicle_details($param){
        $url = '/' . $this->_user_hash . '/bus/vehicle/'.$param.'';
        return $this->_getJson('get', $url);
    }
    
    function getOrganizationDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/organization/' . $param ['organizationcode'];
        return $this->_getJson('get', $url, $param);
    }

    function getAcknowledgementDetails($param){
        $url = '/' . $this->_user_hash . '/delivery/acknowledgement/'.$param['code'];
        return $this->_getJson('get', $url);
    }

    function getUserBrancheDetails($param = array()) {
        $url = '/' . $this->_user_hash . '/user/' . $param['userCode'];
        return $this->_getJson('get', $url, $param);
    }
    function getDeliveryBranches($param = array()) {
        $url = '/' . $this->_user_hash . '/cargo/organization/delivery/branch';
        return $this->_getJson('get', $url, $param);
    }

    function resetVehicle($param = array()) {
        $url = '/' . $this->_user_hash . '/bus/vehicle/' . $param.'/odometer/reset';
        return $this->_getJson('post', $url);
    }

}

?>
