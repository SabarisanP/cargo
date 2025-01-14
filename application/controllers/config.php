<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Config extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
        $this->_user_hash = _get_user_hash();
    }

    public function index() {
        $this->is_logged_in();

        redirect('user/dashboard');
    }

    public function station() {
        $this->is_logged_in();
        _include_js('assets/js/pages/stations.js', 'sm_loadstates');
        $this->load->view('site/admin/allstations');
    }

    public function stations_mapping() {
        $this->is_logged_in();
        _include_js('assets/js/pages/stations.js');
        _include_js('assets/js/pages/station-points.js');
        _include_js('assets/js/pages/stations-mapping.js', 'loadstations_mapping');
        $this->load->view('site/admin/allstations-mapping');
    }

//    public function station_points_mapping() {
//         $this->is_logged_in();
//        _include_js('assets/js/pages/stations-points-mapping.js');
//        $atoz = range('A','Z');
//        $stationNames = $this->api_model->getAllNamespaceStation();
//        $stationNames = json_decode($stationNames);
//        $snames = array();
//        $stations = array();
//        foreach ($stationNames->data as $station) {
//            array_push($snames, $station->name);
//            $stations[] = array(
//                'name'=>$station->name,
//                'code'=>$station->code,
//                'activeFlag'=>$station->activeFlag,
//                'stateCode'=> $state_code
//            );
//        }
//        if(count($stations) >0) {
//            @array_multisort($snames, SORT_ASC, $stations);        
//            foreach($atoz as $aplha) {
//                $statios_list[$aplha] = _array_multi_search($stations, 'name', '/^'.$aplha.'/i');
//            }
//        }
//        $data = array(
//            'stations' => $statios_list,
//            'atoz' => $atoz
//        );
//        
//        $this->load->view('site/admin/stationpoints-mapping', $data);
//    }
//
    public function update_station() {
        $this->is_logged_in();
        $stco = $this->input->post('stateCode');
        $data = array(
            "code" => $this->input->post('code'),
            "name" => $this->input->post('name'),
            "apiFlag" => $this->input->post('apiflag'),
            "activeFlag" => $this->input->post('activeFlag'),
            'latitude' => $this->input->post('latitude'),
            'longitude' => $this->input->post('longitude'),
            'radius' => $this->input->post('radius') ?: 0,
            "state" => array('code' => $stco)
        );
        echo $this->api_model->updateStation($data);
    }

    function delete_station() {
        $this->is_logged_in();

        $data = array(
            "code" => $this->input->post('code'),
            "name" => $this->input->post('name'),
            "apiFlag" => $this->input->post('apiflag'),
            "activeFlag" => 2,
            "state" => array('code' => $this->input->post('stateCode'))
        );
        echo $this->api_model->updateStation($data);
    }

    function edit_station_status() {
        $this->is_logged_in();

        $data = array(
            "code" => $this->input->post('code'),
            "name" => $this->input->post('name'),
            "apiFlag" => $this->input->post('apiflag'),
            "activeFlag" => $this->input->post('activeFlag'),
            "state" => array('code' => $this->input->post('stateCode'))
        );
        echo $this->api_model->updateStation($data);
    }

//    public function station_points() {
//        $this->is_logged_in();
//        _include_js('assets/js/pages/station-points.js');
//        $this->load->view('site/admin/station-points');
//    }

    public function zone(){
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['result'] = $zone->data;

       $this->load->view('site/admin/zone', $data);
    }

    public function save_zone(){
        $this->is_logged_in();

        $data = array(
            "code" => $this->input->post('code'),
            "name" => $this->input->post('name'),
            "description" => $this->input->post('description'),
            "activeFlag" => $this->input->post('activeFlag'),
            "stations" => $this->input->post('stations')
        );
        echo $this->api_model->updateZone($data);
    }

    public function get_stations($type) {
        $this->is_logged_in();
        $state_code = $this->input->post('state_code');
        $stationNames = $this->api_model->getStationsByState(array(
            'authtoken' => _get_user_hash(),
            'statecode' => $state_code,
            'activeFlagFilter' => -1
        ));
        $stationNames = json_decode($stationNames);
        $snames = array();
        $stations = array();
        foreach ($stationNames->data as $station) {
            array_push($snames, $station->name);
            $stations[] = array(
                'name' => $station->name,
                'code' => $station->code,
                'apiFlag' => $station->apiFlag,
                'activeFlag' => $station->activeFlag,
                'latitude' => $station->latitude,
                'longitude' => $station->longitude,
                'radius' => $station->radius,
                'stateCode' => $state_code
            );
        }
        @array_multisort($snames, SORT_ASC, $stations);
        $atoz = range('A', 'Z');
        foreach ($atoz as $aplha) {
            $statios_list[$aplha] = _array_multi_search($stations, 'name', '/^' . $aplha . '/i');
        }
        $data = array(
            'stations' => $stations,
            'atoz' => $atoz
        );

        if ($type == 'stations') {
            $this->load->view('site/admin/stations-list', $data);
        } else if ($type == 'stationmap') {
            $this->load->view('site/admin/stations-mapping-list', $data);
        } else if ($type == 'stationspoint') {
            echo json_encode(array('data' => $stations));
        }
    }

    public function cargo_route(){
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $cargo_route = $this->api_model->getCargoRoute();
        $route = json_decode($cargo_route);
        $data['result'] = $route->data;


        $this->load->view('site/admin/cargo-routes', $data);
    }

    public function update_cargo_route(){
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'fromStation' => array('code' => $this->input->post('fromStation')),
            'toStation' => array('code' => $this->input->post('toStation')),
            'distance' => $this->input->post('distance')
        );

        echo $this->api_model->updateCargoRoute($data);
    }

//     public function get_stations_point_mapping_namespace() {
//        $this->is_logged_in();
//        $station_code = $this->input->post('station_code');
//        $stationPointsName = $this->api_model->getStationPointsByStation(array('authtoken' => $this->_user_hash, 'stationcode' => $station_code));
//        $stationPointsName = json_decode($stationPointsName);
//        $snames = array();
//        $stations = array();
//        $atoz = range('A','Z');
//        foreach ($stationPointsName->data as $stationpoint) {
//            array_push($snames, $stationpoint->name);
//            $stationspoint[] = array(
//                'name'=>$stationpoint->name,
//                'code'=>$stationpoint->code,
//                'activeFlag'=>$stationpoint->activeFlag,
//                 'latitude'=> $stationpoint->latitude,
//                'longitude'=> $stationpoint->longitude,
//                'stationCode'=> $station_code
//            );
//        }
//        if(count($stationspoint) >0) {
//            @array_multisort($snames, SORT_ASC, $stationspoint);
//            foreach($atoz as $aplha) {
//                $statiosppoint_list[$aplha] = _array_multi_search($stationspoint, 'name', '/^'.$aplha.'/i');
//            }
//        }
//        $data = array(
//            'stationspoint' => $statiosppoint_list,
//            'atoz' => $atoz
//        );
//        
//          $this->load->view('site/admin/stationspoints-mapping-list', $data);   
//        
//    }
    public function get_namespace_station() {
        $this->is_logged_in();
        // $state_code = $this->input->post('state_code');
        $namespaceNames = $this->api_model->getNamespaceStation(array('authtoken' => _get_user_hash()));
        $namespaceNames = json_decode($namespaceNames);
        $snames = array();
        $stations = array();

        if (count($namespaceNames->data) > 0) {
            foreach ($namespaceNames->data as $station) {
                array_push($snames, $station->name);
                $stations[] = array(
                    'name' => $station->name,
                    'code' => $station->code,
                    'activeFlag' => $station->activeFlag,
                    'shortCode' => $station->shortCode,
                    'stateCode' => $station->state->code,
                    'stateName' => $station->state->name,
                    
                );
            }
            
            if (count($stations) > 0) {
                @array_multisort($snames, SORT_ASC, $stations);
            }
            
            $stationgrp = array();
            foreach($stations as $station){
               $stationgrp[$station['stateName']][] = $station;
            }
            ksort($stationgrp);
            
        }
        $data = array(
            'stations' => $stationgrp,
            //'atoz' => $atoz
        );

        $this->load->view('site/admin/stations-namespace-list', $data);
    }

//     public function get_namespace_stationpoint() {
//        $this->is_logged_in();
//       // $state_code = $this->input->post('state_code');
//        $namespaceSpNames = $this->api_model->getNamespaceStationPoint(array('authtoken' => _get_user_hash()));
//        $namespaceSpNames = json_decode($namespaceSpNames);
//        $snames = array();
//        $stations = array();
//        $atoz = range('A','Z');
//      
//        foreach ($namespaceSpNames->data as $station) {
//            array_push($snames, $station->name);
//            $stations[] = array(
//                'name'=>$station->name,
//                'code'=>$station->code,
//                'activeFlag'=>$station->activeFlag,
//                'latitude'=> $station->latitude,
//                'longitude'=> $station->longitude
//                );
//        }
//       if(count($stations) >0) {
//            @array_multisort($snames, SORT_ASC, $stations);            
//            foreach($atoz as $aplha) {
//                $stationspoint_list[$aplha] = _array_multi_search($stations, 'name', '/^'.$aplha.'/i');+
//            }
//       }
//        $data = array(
//            'stationspoints' => $stationspoint_list,
//            'atoz' => $atoz
//        );
//       
//          $this->load->view('site/admin/stationspoint-namespace-list', $data);   
//        
//    }
    function add_namespace_station() {
        $this->is_logged_in();
        $data = array(
            'stateCode' => $this->input->post('stateCode'),
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'shortCode' => $this->input->post('shortCode')? : ''
        );
        
        $p_key = _get_namespace_id().'_commerce_stations';
        $this->rediscache->delete($p_key);
        
        echo $this->api_model->updateNamespaceStation($data);
    }

    function delete_namespace_station() {
        $this->is_logged_in();
        $data = array(
            'stateCode' => $this->input->post('stateCode'),
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag')
        );
        $p_key = _get_namespace_id().'_commerce_stations';
        $this->rediscache->delete($p_key);
        echo $this->api_model->updateNamespaceStation($data);
    }

//    function add_namespace_station_point(){
//        $this->is_logged_in();
//        $data = array(
//            'stationCode' => $this->input->post('stationCode'),
//            'name' => $this->input->post('name'),
//            'code' => $this->input->post('code'),
//            'activeFlag' => $this->input->post('activeFlag'),
//            'latitude'=> $this->input->post('latitude'),
//            'longitude'=> $this->input->post('longitude')
//        );
//        
//        echo $this->api_model->updateNamespaceStationPoint($data);
//    }
//    function delete_namespace_station_point(){
//        $this->is_logged_in();
//        $data = array(
//            'name' => $this->input->post('name'),
//            'code' => $this->input->post('code'),
//            'activeFlag' => $this->input->post('activeFlag'),
//            'latitude'=> $this->input->post('latitude'),
//            'longitude'=> $this->input->post('longitude')
//        );
//       
//        echo $this->api_model->updateNamespaceStationPoint($data);
//    }
    function get_stationpoint_by_station() {
        $this->is_logged_in();
        $station_code = $this->input->post('station_code');
        // $stationPointsName = $this->api_model->getStationPointsByStation(array('authtoken' => $this->_user_hash, 'stationcode' => $station_code));
        // $stationPointsName = json_decode($stationPointsName);
        // $data['entity'] = $stationPointsName->data;

        
        $this->load->view('site/admin/station-points-grid', $data);
    }
    
    function get_stationpoint_by_station_user() {
        $this->is_logged_in();
        $station_code = $this->input->post('station_code');
        echo $this->api_model->getStationPointsByStation(array('authtoken' => $this->_user_hash, 'stationcode' => $station_code));        
    }
    
    function save_user_stationpoints() {
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('stationpoint'),
            'station' => array( 'code' => $this->input->post('station') ),
            'activeFlag' => 1,
            'userCode' => $this->input->post('userCode'),
            'boardingCommission' => $this->input->post('boardingCommission'),
            'userGroupList' => array()
        );
        $ugroups = $this->input->post('userGroupList');
        foreach ($ugroups as $value) {
            $data['userGroupList'][] = array('code' => $value);
        }
//        $data = array(
//            'station' => array( 'code' => $this->input->post('station'),
//                            'stationPoints' => array('code'=>$this->input->post('stationpoint'))
//                        ),
//            'code' => $this->input->post('userCode'),
//            'activeFlag' => 1
//        );
        echo $this->api_model->updateUserStationPoint($data);
    }
    
    function delete_user_stationpoints() {
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('stationpoint'),
            'station' => array( 'code' => $this->input->post('station') ),
            'activeFlag' => 2,
            'userCode' => $this->input->post('userCode'),
            'boardingCommission' => $this->input->post('boardingCommission'),
            'userGroupList' => $this->input->post('userGroupList')
        
        );
        
        echo $this->api_model->updateUserStationPoint($data);
    }
  
    function update_station_point() {
        $this->is_logged_in();
        $data = array(
            'station' => array('code' => $this->input->post('stationCode')),
            'name' => $this->input->post('name'),
            'address' => $this->input->post('address'),
            'landmark' => $this->input->post('landmark'),
            'longitude' => $this->input->post('longitude'),
            'latitude' => $this->input->post('latitude'),
            'code' => $this->input->post('code'),
            'number' => $this->input->post('phone'),
            'activeFlag' => $this->input->post('activeFlag'),
            'mapUrl' => ''
        );
        
        if( $this->input->post('share_dir')==1 ) {
            $link = 'http://www.google.com/maps?q='.$this->input->post('latitude').','.$this->input->post('longitude');

            $this->load->model('shorturl_model');
            $short_url = $this->shorturl_model->shorten(array(
                'url' => $link,
                'type' => 'PER'        // permanent
             ));
            $short_url = json_decode($short_url);
            
            if($short_url->status == 1) {
                $short_url = $short_url->data->url;
                $data['mapUrl'] = preg_replace('/https/i', 'http', $short_url);
            }
        }        
        $station_point = $this->api_model->updateStationPoint($data);
        $station_point = json_decode($station_point);
        if($station_point->status == 1) {
            echo json_encode(array(
                'status' => 1,
                'data' => $data
            ));
        } else {
            echo json_encode($station_point);
        }
    }

    function delete_stationpoint() {
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('sp_code'),
            'activeFlag' => 2);
        echo $this->api_model->updateStationPoint($data);
    }

    function edit_stationpoint() {
        $this->is_logged_in();
        $data = array(
            'latitude' => $this->input->post('latitude'),
            'longitude' => $this->input->post('longitude'),
            'station' => array('code' => $this->input->post('stationCode')),
            'code' => $this->input->post('sp_code'),
            'activeFlag' => $this->input->post('activeFlag'));
        echo $this->api_model->updateStationPoint($data);
    }

    function edit_status_stationpoint() {
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('sp_code'),
            'activeFlag' => $this->input->post('activeFlag'));
        echo $this->api_model->updateStationPoint($data);
    }

    public function amenities() {
        $this->is_logged_in();
        _include_js('assets/js/pages/amenities.js');
        $amenitiesDetails = $this->api_model->getAmenities(array(
            'authtoken' => $this->_user_hash,
            'activeFlagFilter' => -1
        ));
        $amenitiesDetail = json_decode($amenitiesDetails);
        $data['entity'] = $amenitiesDetail->data;
        $this->load->view('site/admin/amenities', $data);
        // $this->load->view('site/admin/amenities');
    }

    function update_amenities() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag')
        );
        echo $this->api_model->updateAmenitiesDetails($data);
    }

    function delete_amenities() {
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('am_code'),
            'activeFlag' => 2);
        echo $this->api_model->updateAmenitiesDetails($data);
    }

    function status_amenities() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('am_name'),
            'code' => $this->input->post('am_code'),
            'activeFlag' => $this->input->post('activeFlag')
        );
        echo $this->api_model->updateAmenitiesDetails($data);
    }

    public function group() {
        $p_key = _get_namespace_id() . '_cargo_organization';
        $this->rediscache->delete($p_key);
        
        $this->is_logged_in();
        _include_js('assets/lib/bootstrap-star-rating/js/star-rating.min.js');
        _include_js('assets/js/pages/group.js');

        $GroupDetail = $this->api_model->getGroup(array(
            'authtoken' => $this->_user_hash,
            'activeFlag' => -1
        ));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $tmp = array();
        foreach ($GroupDetail->data AS $grp) {
            if ($grp->role->code != "USER")
                continue;
            $Groupuser = $this->api_model->getUserByGroup(array('groupcode' => $grp->code));
            $Groupuser = json_decode($Groupuser);
            $tmp[] = array(
                'code' => $grp->code,
                'name' => $grp->name,
                'level' => $grp->level,
                'activeFlag' => $grp->activeFlag,
                'userCount' => $grp->userCount,
                'userlist' => $Groupuser->data
            );
        }
        $data['entity'] = $tmp;
        $userDetails = $this->api_model->getUser();
        $userDetail = json_decode($userDetails);
        $data['users'] = $userDetail->data;
        $this->load->view('site/config/group', $data);
    }

    public function update_group() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'level' => $this->input->post('level'),
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'decription' => $this->input->post('description'),
        );


        echo $this->api_model->updateGroupDetails($data);
    }

    public function delete_group() {
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => 2);
        echo $this->api_model->updateGroupDetails($data);
    }

    public function edit_status_group() {
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'));
        echo $this->api_model->updateGroupDetails($data);
    }

    public function bus_type() {
        $this->is_logged_in();
        _include_js('assets/js/pages/bus-type.js');
        $buses = $this->api_model->getBuses(array(
            'activeFlagFilter' => -1
        ));
        $buses = json_decode($buses);
        $tmp = array();

        foreach ($buses->data AS $bus) {
            $buslayer = $this->api_model->getBusLayerbyCode(array('buscode' => $bus->code));
            $buslayer = json_decode($buslayer);

            if ($buslayer->status != 1)
                continue;
            // X- Axis 

            $var1 = '';
            $var2 = '';
            foreach ($buslayer->data AS $bus_x) {
                if ($bus_x->layer == 1) {
                    $var1 .= $bus_x->rowPos . " ";
                } else {
                    $var2 .= $bus_x->rowPos . " ";
                }
            }



            $x = explode(" ", $var1);
            $x_ax = array_filter($x);
            if (count($x_ax)) {
                $x_max1 = max($x_ax);
                $x_min1 = min($x_ax);
            }

            $x = explode(" ", $var2);
            $x_ax = array_filter($x);
            if (count($x_ax)) {
                $x_max2 = max($x_ax);
                $x_min2 = min($x_ax);
            }

            // Y- Axis  

            $var_y1 = '';
            $var_y2 = '';
            foreach ($buslayer->data AS $bus_y) {
                if ($bus_y->layer == 1) {
                    $var_y1 .= $bus_y->colPos . " ";
                } else {
                    $var_y2 .= $bus_y->colPos . " ";
                }
            }
            if ($var_y1 > 0) {
                $y = explode(" ", $var_y1);
                $y_ax = array_filter($y);
                if (count($y_ax)) {
                    $y_max1 = max($y_ax);
                    $y_min1 = min($y_ax);
                }
                $y = explode(" ", $var_y2);
                $y_ax = array_filter($y);
                if (count($y_ax)) {
                    $y_max2 = max($y_ax);
                    $y_min2 = min($y_ax);
                }
            }
            // Bus layer

            $lay = '';
            foreach ($buslayer->data AS $bus_x) {


                $lay .= $bus_x->layer . " ";
            }

            $layer = explode(" ", $lay);
            $lay = array_filter($layer);
            $lay = array_unique($lay);

            // Complete Bus Array

            $tmp[] = array(
                'code' => $bus->code,
                'name' => $bus->name,
                'activeFlag' => $bus->activeFlag,
                'seatCount' => $bus->seatCount,
                'categoryCode' => $bus->categoryCode,
                'buslayers' => $buslayer->data,
                'x-axis-max1' => $x_max1,
                'x-axis-min1' => $x_min1,
                'y-axis-max1' => $y_max1,
                'y-axis-min1' => $y_min1,
                'x-axis-max2' => $x_max2,
                'x-axis-min2' => $x_min2,
                'y-axis-max2' => $y_max2,
                'y-axis-min2' => $y_min2,
                'layer_all' => $lay
            );
        }
        $data = array(
            'buses' => $tmp
        );


        $bus_category = $this->api_model->getBusCategory();
        $bus_category = json_decode($bus_category);

        $seattype = $this->api_model->getBusSeatType();
        $busseat = json_decode($seattype);
        //print_r($seattype);
        $data['seattype'] = $busseat->data;

        $temp = array();

        foreach ($bus_category->data AS $buscat) {
            $tmp = array();
            foreach ($buscat->categoryList AS $sub) {

                $tmp[$sub->code] = $sub->name;
            }
            $temp[preg_replace('/\s+/', '', $buscat->code)] = $tmp;
        }
        $data['categoryList'] = $temp;
        $this->load->view('site/config/bus-type', $data);
    }
    
    public function seat_sorter(){
    	$this->is_logged_in();
    	_include_js('assets/js/pages/bus-type.js');
    	$busCode = $this->input->get('bc');
        
        $buses = $this->api_model->getBuses();
        $buses = json_decode($buses);
        foreach ($buses->data AS $bus) {
           if($busCode == $bus->code) {
              $data['bus'] = $bus;
           }
        }
        
        $seattype = $this->api_model->getBusSeatType();
        $busseat = json_decode($seattype);
        //print_r($seattype);
        $data['seattype'] = $busseat->data;
        
    	$buslayer = $this->api_model->getBusLayerbyCode(array('buscode' =>$busCode));
    	$buslayer = json_decode($buslayer);
        $seats = array();
        $sort = array();
        foreach ($buslayer->data AS $seat) {
            $seats[] = array(
                'code' => $seat->code,
                'name' => $seat->seatName,
                'sequence' => $seat->sequence,
                'type' => $seat->busSeatType->name
            );            
            $sort[] = $seat->sequence;
            
        }
        array_multisort($sort, SORT_ASC, $seats);
    	$data['buslayer'] = $seats;
        
        // X- Axis 

            $var1 = '';
            $var2 = '';
            foreach ($buslayer->data AS $bus_x) {
                if ($bus_x->layer == 1) {
                    $var1 .= $bus_x->rowPos . " ";
                } else {
                    $var2 .= $bus_x->rowPos . " ";
                }
            }

            $x = explode(" ", $var1);
            $x_ax = array_filter($x);
            if (count($x_ax)) {
                $x_max1 = max($x_ax);
                $x_min1 = min($x_ax);
            }

            $x = explode(" ", $var2);
            $x_ax = array_filter($x);
            if (count($x_ax)) {
                $x_max2 = max($x_ax);
                $x_min2 = min($x_ax);
            }

            // Y- Axis  

            $var_y1 = '';
            $var_y2 = '';
            foreach ($buslayer->data AS $bus_y) {
                if ($bus_y->layer == 1) {
                    $var_y1 .= $bus_y->colPos . " ";
                } else {
                    $var_y2 .= $bus_y->colPos . " ";
                }
            }
            if ($var_y1 > 0) {
                $y = explode(" ", $var_y1);
                $y_ax = array_filter($y);
                if (count($y_ax)) {
                    $y_max1 = max($y_ax);
                    $y_min1 = min($y_ax);
                }
                $y = explode(" ", $var_y2);
                $y_ax = array_filter($y);
                if (count($y_ax)) {
                    $y_max2 = max($y_ax);
                    $y_min2 = min($y_ax);
                }
            }
            // Bus layer

            $lay = '';
            foreach ($buslayer->data AS $bus_x) {


                $lay .= $bus_x->layer . " ";
            }

            $layer = explode(" ", $lay);
            $lay = array_filter($layer);
            $lay = array_unique($lay);

            // Complete Bus Array

            $tmp = array(
                'code' => $data['bus']->code,
                'buslayers' => $buslayer->data,
                'x-axis-max1' => $x_max1,
                'x-axis-min1' => $x_min1,
                'y-axis-max1' => $y_max1,
                'y-axis-min1' => $y_min1,
                'x-axis-max2' => $x_max2,
                'x-axis-min2' => $x_min2,
                'y-axis-max2' => $y_max2,
                'y-axis-min2' => $y_min2,
                'layer_all' => $lay
            );
            
            $data['busmap'] = $tmp;
    	
    	$this->load->view('site/config/bus-seat-arrange',$data);
    	
    }
    
    public function save_seat_order() {
        $bus_code = $this->input->post('buscode');
        $seats_i = $this->input->post('seats');
        foreach ($seats_i AS $seat) {
            $seats[] = array(
                'sequence' => $seat['sequence'],
                'code' => $seat['code']
            );
        }            
        $data['layoutList'] = $seats;        
        echo $this->api_model->updateSeatOrder($bus_code, $data);
    }

    public function get_bustype_category() {
        _include_js('assets/js/pages/bus-type.js', '_init_busmap_edit');
        $bus_category = $this->api_model->getBusCategory();
        $bus_category = json_decode($bus_category);
        $data = array(
            'master_categories' => array(
                'chasis' => $bus_category->data[0]->categoryList,
                'climate' => $bus_category->data[1]->categoryList,
                'layout' => $bus_category->data[2]->categoryList,
                'make' => $bus_category->data[3]->categoryList,
                'seattype' => $bus_category->data[4]->categoryList
            ),
        );
        $code = $this->input->get('code');

        if (isset($code) && $code != '') {
            $bus = $this->api_model->getBusbyCode(array('buscode' => $code));
            $bus = json_decode($bus);
            $data['buses'] = $bus->data[0];
            $buslayer = $this->api_model->getBusLayerbyCode(array('buscode' => $code));
            $buslayer = json_decode($buslayer);
            $data['buslayer'] = $buslayer->data;
        }

        $seattype = $this->api_model->getBusSeatType();
        $busseat = json_decode($seattype);
        $data['seattype'] = $busseat->data;


        $this->load->view('site/config/bus-type-layout', $data);
    }

    public function save_bustype() {

        $seats = $this->input->post('sid');
        $seatname = $this->input->post('seatname');
        $rcs = $this->input->post('rcs');
        $layout = $this->input->post('layout');
        $climate = $this->input->post('climate');
        $chase = $this->input->post('chase');
        $make = $this->input->post('make');
        $layer = $this->input->post('layer');
        $code = $this->input->post('code');
        $activeFlag = $this->input->post('activeFlag');
        $seats1 = $this->input->post('sid2');
        $seatname2 = $this->input->post('seatname2');
        $rcs2 = $this->input->post('rcs2');
        $bustypecode = $this->input->post('code_id');
        $seatype = $this->input->post('seatype');

        $categorycode = $layout . "|" . $climate . "|" . $chase . "|" . $make . '|' . $seatype;

        $buslayer = array();
        if (isset($code) && $code != '') {
            $buslayerold = $this->api_model->getBusLayerbyCode(array('buscode' => $code));
            $buslayerold = json_decode($buslayerold);
            $buslayerold = $buslayerold->data;
            foreach ($buslayerold AS $busold) {
                if (!in_array($busold->code, $bustypecode)) {
                    $buslayeroldstatus[] = array(
                        'activeFlag' => 2,
                        'code' => $busold->code
                    );
                }
            }

            $data['buslayer'] = $buslayeroldstatus;
            $data['buscode'] = $code;
            if (count($buslayeroldstatus) > 0) {
                $busold_layer = $this->api_model->updateBusLayer($data);
            }
        }

        if (count($seats1) > 0) {
            $count = count($seats) + count($seats1);
        } else {
            $count = count($seats);
        }

        $data = array(
            'name' => $this->input->post('busname'),
            'displayName' => $this->input->post('busname'),
            'activeFlag' => 1,
            'seatCount' => $count,
            'code' => $code,
            'categoryCode' => $categorycode
        );

        $bus = $this->api_model->updateBus($data);
        $bus = json_decode($bus);
        $code = $bus->data->code;

        $buslayer = array();
        foreach ($seats As $key => $seat) {

            $rc = explode(',', $rcs[$key]['value']);
            $id = "l1-" . str_replace(",", "-", $rcs[$key]['value']);
            $code_layer = '';
            if (isset($bustypecode[$id]) && $bustypecode[$id] != '') {
                $code_layer = $bustypecode[$id];
            } else {
                $code_layer = '';
            }
            $buslayer1[] = array(
                'layer' => 1,
                'rowPos' => $rc[0],
                'colPos' => $rc[1],
                'seatName' => trim($seat),
                'code' => $code_layer,
                'busSeatType' => array('code' => $seatname[$key]['value']),
                'activeFlag' => 1
            );
        }
        if (isset($rcs2) && $rcs2 != '') {

            $buslayer = array();
            foreach ($seats1 As $key => $seat1) {
                $rc2 = explode(',', $rcs2[$key]['value']);
                $code_layer = '';
                $id = "l2-" . str_replace(",", "-", $rcs[$key]['value']);
                if (isset($bustypecode[$id]) && $bustypecode[$id] != '') {
                    $code_layer = $bustypecode[$id];
                } else {
                    $code_layer = '';
                }
                $buslayer2[] = array(
                    'layer' => 2,
                    'rowPos' => $rc2[0],
                    'colPos' => $rc2[1],
                    'seatName' => trim($seat1),
                    'busSeatType' => array('code' => $seatname2[$key]['value']),
                    'code' => $code_layer,
                    'activeFlag' => 1
                );
            }
        }
        $data['buscode'] = $code;
        if (isset($rcs2) && $rcs2 != '') {
            $data['buslayer'] = array_merge($buslayer1, $buslayer2);
            $bus_layer = $this->api_model->updateBusLayer($data);
        } else {
            $data['buslayer'] = $buslayer1;
            $bus_layer = $this->api_model->updateBusLayer($data);
        }

        echo $bus_layer;
    }

    function delete_bustype() {
        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => 2,
        );
        echo $this->api_model->updateBus($data);
    }

    function status_bustype() {
        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('name')
        );
        //print_r($data);
        echo $this->api_model->updateBus($data);
    }

    public function organization() {
        $this->is_logged_in();
        _include_js('assets/js/pages/organization.js');

        $data = array(
            'entityTypeCode' => 'NMSP',
            'referenceCode' => _get_namespace_id()
        );

        $bank_detail = $this->api_model->getAllBankDetails($data);
        $bank_detail = json_decode($bank_detail);
        $data['bank_detail'] = $bank_detail->data;
        
        $organizationDetails = $this->api_model->getOrganization(array(
            'authtoken' => $this->_user_hash,
            'activeFlagFilter' => -1
        ));
        $organizationDetail = json_decode($organizationDetails);

        //Station
        $namespaceNames = $this->api_model->getNamespaceStation(array('authtoken' => _get_user_hash()));
        $namespaceNames = json_decode($namespaceNames);
        $data['organization'] = $organizationDetail->data;
        
        $branch = array(); 
        $branchrg = array();
        
        foreach ($organizationDetail->data as $org) {
            $branch[] = array(
                'code' => $org->code,
                'name' => $org->name,
                'address1' => $org->address1,
                'address2' => $org->address2,
                'contact' => $org->contact,
                'activeFlag' => $org->activeFlag,
                'station' => array(
                    'code' => $org->station->code,
                    'name' => $org->station->name
                ),
                'pincode' => $org->pincode,
                'latitude' => $org->latitude,
                'longitude' => $org->longitude,
                'userCount' => $org->userCount,
                'shortCode' => $org->shortCode,
                'user' => $org->user,
                'hubFlag' =>  $org->hubFlag,
                'deviationPercentage' =>  $org->deviationPercentage,
                'tag' =>  $org->tag,
                // 'transactionMode' => $org->transactionMode ?: [],
                'transactionMode' => $org->transactionMode,
                'bookingPaymentTypeList' =>  $org->bookingPaymentTypeList ?: [],
                'deliveryPaymentTypeList' =>  $org->deliveryPaymentTypeList ?: [],
                'transitCloseMinutes' => $org->transitCloseMinutes,
                'organizationType' => array(
                    'code'=> $org->organizationType->code
                ),
                
                'lookupCode'=> $org->lookupCode,
            );
        }
        
        $branchs = array();
        foreach($branch as $brn) {
            $branchs[$brn['station']['name']][] = $brn;
        }
        
        if (count($branchs) > 0) {
            uksort($branchs, function($a, $b) {
                return $a < $b ? -1 : 1;
            });
        }
        
        $data['branch'] = $branchs;
        $branchrgs = array();
        foreach($branch as $brn) {
            if ($brn['organizationType']['code'] === 'REG') {
            $branchrgs[$brn['station']['name']][] = $brn;
            }
        }
        
        if (count($branchrgs) > 0) {
            uksort($branchrgs, function($a, $b) {
                return $a < $b ? -1 : 1;
            });
        }
        
        $data['branchrg'] = $branchrgs;
        $data['stations'] = $namespaceNames->data;

        $userDetails = $this->api_model->getUser();
        $userDetail = json_decode($userDetails);

        $data['users'] = $userDetail->data;

        $groupusers = array();
        foreach($userDetail->data as $row) {
            $groupusers[$row->group->name][] = $row;
        }
        $data['groupusers'] = $groupusers;
        
        $result = $this->api_model->cargoTags(array('categoryCode' => 'BRCH'));
        $result = json_decode($result);
        $data['cargotags'] = $result->data;

        $states = $this->api_model->getAllStates( array('authToken'=>_get_user_hash()) );
        $states = json_decode($states);

        usort($states->data, function($a, $b) {
            return $a->name < $b->name ? -1 : 1;
        });
        $data['states'] = $states->data;
        $data['payment_status'] = config_item('cargo_payment_status');
        $data['transactionMode'] = config_item('transaction_Mode');
        
        $this->load->view('site/config/organization', $data);
    }

    public function update_payment_preference(){
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'fromOrganization' => $this->input->post('fromOrganization'),
            'toOrganizationList' => $this->input->post('toOrganizationList') ?: []
        );
        echo $this->api_model->updatePaymentPreference($data);
    }

    public function update_org_dimension(){
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'dimensions' => $this->input->post('dimensions'),
            'activeFlag' => $this->input->post('activeFlag'),
            'bankDetails' => $this->input->post('bankDetails'),
        );
        $res = $this->api_model->updateOrganizationOtherDetails($data);
        $res = json_decode($res);
        if ($res->status != 1) {
            echo json_encode($res);
            return;
        }

        $imageUrlSlug = $this->input->post('imageUrlSlug');
        if ($imageUrlSlug) {
            echo $this->api_model->saveImageDetails( array(
                'referenceCode' => $this->input->post('code'),
                'imageCategoryCode' => 'ORGN',
                'imageDetails' => [
                    array(
                        'imageUrlSlug' => $imageUrlSlug,
                        'tag' => 'QR',
                    )
                ],
                'action' => 'UPDATE'
            ));
            return;
        }

        echo json_encode($res);
    }

    public function get_org_usr(){
        $this->is_logged_in();
        
        $organizationuser = $this->api_model->getUserByOrganization(array('organizationcode' => $this->input->post('organizationcode')));
        $organizationuser = json_decode($organizationuser);
        $data['user'] = $organizationuser->data;
        
        $payment_pref = $this->api_model->getPaymentPreference(array('organizationCode' => $this->input->post('organizationcode')));
        $payment_pref = json_decode($payment_pref);
        $data['pay_pref'] = $payment_pref->data[0];

        $org_dimension = $this->api_model->getOrganizationOtherDetails(array('organizationcode' => $this->input->post('organizationcode')));
        $org_dimension = json_decode($org_dimension);
        $data['org_dimension'] = $org_dimension->data;

        $brn_con = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->input->post('organizationcode'),
            'categoryCode' => $this->input->post('categoryCode') ?: ''
        ));

        $brn_con = json_decode($brn_con);
        $data['brn_con'] = $brn_con->data;

        $states = $this->api_model->getAllStates( array('authToken'=>_get_user_hash()) );
        $states = json_decode($states);
        $data['states'] = $states->data;
        $paymentData = $this->api_model->getOrganizationDetails(array('organizationcode'=>$this->input->post('organizationcode'))); //org details
        $paymentData = json_decode($paymentData);
        $paymentData = $paymentData->data;
        $org = json_encode($this->input->post('org'));
        $org =  json_decode($org);
        $org->bookingPaymentTypeList =  $paymentData[0]->bookingPaymentTypes;
        $org->deliveryPaymentTypeList =  $paymentData[0]->deliveryPaymentTypes;
        $data['org'] = $org;
        $data['bookingPaymentTypeList'] = $paymentData[0]->bookingPaymentTypes;
        $data['deliveryPaymentTypeList'] = $paymentData[0]->deliveryPaymentTypes;

        $data['dms_domain'] = config_item('dms_domain');

        $this->load->view('site/config/organization-detail', $data);
    }

    public function update_organization() {
        $this->is_logged_in();
        $transitCloseTime = $this->input->post('transitCloseMinutes');

        $data = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'address1' => $this->input->post('address1'),
            'address2' => $this->input->post('address2'),
            'contact' => $this->input->post('contact'),
            'station' => array("code" => $this->input->post('stationCode')),
            'organizationType' => array("code" => $this->input->post('organizationType')),
            'lookupCode' => $this->input->post('lookupCode'),
            'pincode' => $this->input->post('pincode'),
            'latitude' => $this->input->post('latitude'),
            'longitude' => $this->input->post('longitude'),
            'shortCode' => $this->input->post('shortCode'),
            'ownershipType' =>array("code" => $this->input->post('branchType')),
            'user' => $this->input->post('user'),
            'hubFlag' => $this->input->post('hubFlag'),
            'deviationPercentage' => $this->input->post('deviationPercentage')?: '0',
            'tag' => $this->input->post('tag') ?: [],
            'transactionMode' => $this->input->post('transactionMode') ?: [],
            'bookingPaymentTypes' => $this->input->post('bookingPaymentTypeList') ?: [],
            'deliveryPaymentTypes' => $this->input->post('deliveryPaymentTypeList') ?: [],
            'transitCloseMinutes' => timeToMinutes($transitCloseTime) ?: '0'
        );
        echo $this->api_model->updateOrganizationDetails($data);
    }

    public function update_branch_contact() {
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'name' => $this->input->post('name'),
            'activeFlag' => $this->input->post('activeFlag'),
            'aliasCode' => $this->input->post('aliasCode'),
            'organization' => $this->input->post('organization'),
            'category' => $this->input->post('category'),
            'age' => $this->input->post('age'),
            'mobile' => $this->input->post('mobile'),
            'alternateMobile' => $this->input->post('alternateMobile'),
            'qualification' => $this->input->post('qualification'),
            'languages' => $this->input->post('languages'),
            'placeOfBirth' => $this->input->post('placeOfBirth'),
            'address' => $this->input->post('address'),
            'remarks' => $this->input->post('remarks') ?: ''
        );
        echo $this->api_model->updateBranchContact($data);
    }

    public function edit_status_organization() {
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag')
        );
        echo $this->api_model->updateOrganizationDetails($data);
    }

    public function delete_organization() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => 2,
        );
        echo $this->api_model->updateOrganizationDetails($data);
    }

    public function cancellation() {
        $this->is_logged_in();
        _include_js('assets/js/pages/cancellation.js');
        $cancellationDetails = $this->api_model->getAllCancellation(array(
            'authtoken' => $this->_user_hash,
            'activeFlagFilter' => -1
        ));
        $cancellist = json_decode($cancellationDetails);
        $data['cancel'] = $cancellist->data;
        $data['policy'] = array('day', 'hour', 'min', 'AM', 'PM');

        $this->load->view('site/admin/cancellation', $data);
    }

    public function update_cancellation() {
        $this->is_logged_in();

        $fromValue = $this->input->post('fromValue');
        $tovalue = $this->input->post('toValue');
        $deductionAmount = $this->input->post('deductionAmount');
        $policyPattern = $this->input->post('policyPattern');
        $percentageFlag = $this->input->post('percentageFlag');

        $pre_val = '';
        $t = '';
        foreach ($fromValue AS $key => $vl) {
            $t = $policyPattern[$key]['value'];
            if ($policyPattern[$key]['value'] == 'day') {
                $tovalue[$key]['value'] = $tovalue[$key]['value'] * (24 * 60);
                if ($pre_val != '' && $pre_val != $policyPattern[$key]['value']) {
                    $fromValue[$key]['value'] = $fromValue[$key]['value'] * 60;
                    if ($pre_val == 'PM') {
                        $fromValue[$key]['value'] += 720; // 12 hrs
                    }
                } else {
                    $fromValue[$key]['value'] = $fromValue[$key]['value'] * (24 * 60);
                }
                $policyPattern[$key]['value'] = 'min';
            } else if ($policyPattern[$key]['value'] == 'hour') {
                $tovalue[$key]['value'] = $tovalue[$key]['value'] * 60;
                $fromValue[$key]['value'] = $fromValue[$key]['value'] * 60;
                $policyPattern[$key]['value'] = 'min';
            }

            $tmp[] = array(
                'toValue' => $tovalue[$key]['value'],
                'policyPattern' => $policyPattern[$key]['value'],
                'deductionAmount' => $deductionAmount[$key]['value'],
                'percentageFlag' => $percentageFlag[$key],
                'fromValue' => $fromValue[$key]['value']
            );
            $pre_val = $t;
        }
        $fro = $this->input->post('at_fromValue');
        $to = $this->input->post('at_toValue');
        $pp = $this->input->post('at_pp');

        if ($pp == 'days' || $pp == 'day') {
            $to = $to * (24 * 60);
            $fro = $fro * (24 * 60);
            $pp = 'min';
        } else if ($pp == 'hour') {
            $to = $to * 60;
            $fro = $fro * 60;
            $pp = 'min';
        }

        $tmp[] = array(
            'toValue' => $to,
            'policyPattern' => $pp,
            'deductionAmount' => $this->input->post('at_amt'),
            'percentageFlag' => $this->input->post('at_amt_tp'),
            'fromValue' => $fro
        );
        $data = array(
            'policyList' => $tmp,
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code'),
            'name' => $this->input->post('name')
        );

        //echo print_r($data);
        echo $this->api_model->updateCancellation($data);
    }

    public function delete_cancellations() {
        $data = array(
            'activeFlag' => 2,
            'name' => $this->input->post('cn_name'),
            'code' => $this->input->post('cn_code')
        );
        echo $this->api_model->updateCancellation($data);
    }

    public function update_status_cancellations() {
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('cn_name'),
            'code' => $this->input->post('cn_code')
        );
        echo $this->api_model->updateCancellation($data);
    }

    public function user() {
        $this->is_logged_in();
        _include_js('assets/js/pages/user.js');

        $organizationDetails = $this->api_model->getOrganization(array('authtoken' => $this->_user_hash));
        $organizationDetail = json_decode($organizationDetails);

        $data['organization'] = $organizationDetail->data;


        $GroupDetails = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetails);
        $data['groups'] = $GroupDetail->data;
        
        $userDetails = $this->api_model->getUser(array(
            'activeFlagFilter' => -1
        ));
        $userDetail = json_decode($userDetails);
        $users = array();
        foreach ($userDetail->data as $user) {
            $t = (!empty($user->group->name)) ? $user->group->name : 'Others'; 
            $users[$t][] = $user; 
        }        
        ksort($users);
        
        $stations = $this->api_model->getNamespaceStation(array('authtoken' => _get_user_hash()));
        $stations = json_decode($stations);
        
        $data['groupusers'] = get_active_group_and_users();
        $data['stations'] = $stations->data; 
        $data['users_raw'] = $userDetail->data; 
        $data['users'] = $users;
        $data['users_pay_type'] = config_item('user_payment_type');
        $data['user_tags'] = config_item('user_tags');
        
        $this->load->view('site/config/user', $data);
    }
    public function user_availablity() {
        $this->is_logged_in();
        $username = $this->input->post('username');
        $data = array(
            'username' => $this->input->post('username'),
        );
        $json = $this->api_model->checkUsernameAvailablity($data);
        $json = json_decode($json);
        $flag = 0;
        if($json->status==0) {            
            $flag = 1;                
        }
        
        echo json_encode(array(
            'status' => $flag
        ));
        
    }
    public function add_user() {
        $data = array(
            'lastname' => $this->input->post('lastname'),
            'activeFlag' => $this->input->post('activeFlag'),
            'aliasCode' => $this->input->post('aliasCode'),
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'email' => $this->input->post('email'),
            'mobile' => $this->input->post('mobile'),
            'paymentType' => array("code" => $this->input->post('pay_mode')),
            'username' => $this->input->post('username'),
            'userTags' => $this->input->post('userTags')?:[],
            'bookingPaymentType' => $this->input->post('bookingPaymentType')?:[],
        );
        if ($this->input->post('code') == '') {
            $data['group'] = array('code' => $this->input->post('group'));
            $data['organization'] = array('code' => $this->input->post('organization'));
            $data['username'] = $this->input->post('username');
        }
        
        //  reset user cache.
        $this->api_model->resetUserCache();
        
        echo $this->api_model->updateUser($data);
    }

    public function edit_status_user() {
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code'),
            'username' => $this->input->post('username')
        );
        
        //  reset user cache.
        $this->api_model->resetUserCache();
        
        echo $this->api_model->updateUser($data);
    }

    public function delete_user() {
        $data = array(
            'activeFlag' => 2,
            'code' => $this->input->post('code'),
            'username' => $this->input->post('username')
        );
        
        //  reset user cache.
        $this->api_model->resetUserCache();
        
        echo $this->api_model->updateUser($data);
    }

    public function edit_user_group() {
        $data = array(
            'usercode' => $this->input->post('code'),
            'groupcode' => $this->input->post('group')
        );
        
        //  reset user cache.
        $this->api_model->resetUserCache();
        
        echo $this->api_model->editUserGroup($data);
    }

    //Organization
    public function edit_user_organization() {
        $data = array(
            'usercode' => $this->input->post('code'),
            'organizationCode' => $this->input->post('organization')
        );
        
        //  reset user cache.
        $this->api_model->resetUserCache();
        
        echo $this->api_model->editUserOrganizatio($data);
    }

//edit-user-password

    public function edit_user_password() {
        $data = array(
            'usercode' => $this->input->post('code'),
            'newpassword' => $this->input->post('password')
        );
        echo $this->api_model->resetPassword($data);
    }

    public function all_user_organization() {
        $usrcodes = $this->input->post('usrCode');

        foreach ($usrcodes AS $key => $vl) {
            $data = array(
                'usercode' => $usrcodes[$key]['value'],
                'organizationCode' => $this->input->post('code')
            );

            $res = $this->api_model->editUserOrganizatio($data);
            $res = json_decode($res);
            if ($res->status != 1) {
                echo json_encode($res);
                return;
            }
        }
        
        //  reset user cache.
        $this->api_model->resetUserCache();
        
        echo json_encode(array('status' => 1));
    }

    public function all_user_group() {
        $usrcodes = $this->input->post('usrCode');

        foreach ($usrcodes AS $key => $vl) {
            $data = array(
                'usercode' => $usrcodes[$key]['value'],
                'groupcode' => $this->input->post('code')
            );

            $this->api_model->editUserGroup($data);
        }
        
        //  reset user cache.
        $this->api_model->resetUserCache();
        
        echo json_encode(array('status' => 1));
    }
    
    public function user_stationpoints() {
        $data = array(
            'usercode' => $this->input->post('userCode')
        );
        $stationpoints = $this->api_model->getUserStationPoints($data);
        $stationpoints = json_decode($stationpoints);
        echo json_encode($stationpoints);
    }
    
    

    public function user_commission() {
        $usrcodes = $this->input->post('usrCode');
        $data = array(
            'userCode' => $usrcodes
        );
        $commission = $this->api_model->getUserCommission($data);
        $commission = json_decode($commission);
        echo json_encode($commission);
    }
    
    public function user_tds() {
        $usrcodes = $this->input->post('userCode');
        $data = array(
            'userCode' => $usrcodes
        );
        $tds = $this->api_model->getUserTds($data);
        $tds = json_decode($tds);
        $data['tds'] = $tds->data;

        $this->load->view('site/cargo/user-tds-list', $data);
    }
    
    function save_user_tds() {
        $this->is_logged_in();
        $data = array(
            'fromDate' => $this->input->post('effectivedate'),
            'tdsTaxValue' => $this->input->post('tdsvalue'),
            'activeFlag' => 1,
            'panCardCode' => $this->input->post('pan'),
            'user' => array( 'code' => $this->input->post('userCode') )           
        );
        
        if( $this->input->post('code') !="" ) {
           $data['code'] =  $this->input->post('code');
        }
        echo $this->api_model->updateUserTds($data);
    }
    
    function delete_user_tds() {
        $this->is_logged_in();
        $data = $this->input->post('options');
        $data['activeFlag'] = 2;        
        echo $this->api_model->updateUserTds($data);
    }

    public function commission_user() {
        $usrcodes = $this->input->post('userCode');
        $code = $this->input->post('code');
        $gst = ($this->input->post('gst')) ? $this->input->post('gst') : 0;

        $type = 'BO';
        if($this->input->post('act') == 'CT'){
            $type = 'CA';
        } else if($this->input->post('act') == 'CG'){
            $type = 'CG';
        } else if($this->input->post('act') == 'CD'){
            $type = 'CD';
        } else if($this->input->post('act') == 'CCA'){
            $type = 'CCA';
        }
        
        $data = array(
            //'activeTo' => $this->input->post('activeTo'),
            //'activeFrom' => $this->input->post('activeFrom'),
            'creditLimit' => $this->input->post('creditlimit'),
            'value' => $this->input->post('value'),
            'userCode' => $this->input->post('userCode'),
            'valueType' => array('code' => $this->input->post('percentageFlag')),
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code'),
            'serviceTax' => $gst,
            'commissionType' => $type
        );     
        
        echo $this->api_model->updateCommission($data);
    }

    public function routes() {
        $this->is_logged_in();
        _include_js('assets/js/pages/routes.js');
        $routeDetails = $this->api_model->getRoutes(array(
            'authtoken' => $this->_user_hash,
            'activeFlagFilter' => -1
        ));
        $routeDetail = json_decode($routeDetails);
        $data['route'] = $routeDetail->data;

        $namespaceNames = $this->api_model->getNamespaceStation(array('authtoken' => _get_user_hash()));
        $namespaceNames = json_decode($namespaceNames);
        $data['routes'] = $namespaceNames->data;

        $this->load->view('site/admin/routes', $data);
    }
    
    public function export_routes() {
        $this->is_logged_in();
        $routes = $this->api_model->getRoutes(array('authtoken' => $this->_user_hash));
        $routes = json_decode($routes);

        $stations = $this->api_model->getNamespaceStation(array('authtoken' => _get_user_hash()));
        $stations = json_decode($stations);
        
        $tmp = array();
        foreach ($stations->data AS $station) {            
            $tmp[$station->code] = $station->state->name;
        }

        //  excel generation
        $this->load->library('excel');
        $this->excel->getProperties()->setCreator("EzeeInfo")
                                    ->setLastModifiedBy("EzeeInfo")
                                    ->setTitle("BO Route List")
                                    ->setSubject("BO Route List")
                                    ->setDescription("BO Route List.")
                                    ->setKeywords("BO Route List")
                                    ->setCategory("Route");
        $this->excel->setActiveSheetIndex(0);
        $this->excel->getActiveSheet()->setTitle('Routes List');

        $this->excel->getActiveSheet()->getStyle('A1:Z1')->getFont()->setBold(true);

        $this->excel->getActiveSheet()->setCellValue('A1', 'Operator Name');
        $this->excel->getActiveSheet()->setCellValue('B1', 'Operator Id');
        
        $this->excel->getActiveSheet()->setCellValue('C1', 'Source City Name');
        $this->excel->getActiveSheet()->setCellValue('D1', 'Source City State');
        $this->excel->getActiveSheet()->setCellValue('E1', 'Source City Id');
        
        $this->excel->getActiveSheet()->setCellValue('F1', 'Destination City Name');
        $this->excel->getActiveSheet()->setCellValue('G1', 'Destination City State');
        $this->excel->getActiveSheet()->setCellValue('H1', 'Destination City Id');

        $row = 2;
        
        if ($routes->status == 1) {
            if (is_array($routes->data)) {
                $routes_count = count($routes->data);
                for ($i = 0; $i < $routes_count; $i++) {
                    $col = 0;
                    $t = $routes->data[$i];

                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $this->session->userdata('namespace_name'));
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $this->session->userdata('namespace_id'));
                    
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->fromStation->name);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $tmp[$t->fromStation->code]);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->fromStation->code);
                    
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->toStation->name);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $tmp[$t->toStation->code]);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->toStation->code);
                    
                    $row++;
                }
            }
        }
        
        $filename = $this->session->userdata('namespace_id').'-routes.xls';
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="'.$filename.'"');
        header('Cache-Control: max-age=0');
        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
        $objWriter->save('php://output');        
    }

    function add_routes() {
        $this->is_logged_in();

        $data = array(
            "activeFlag" => 1,
            "toStation" => array('code' => $this->input->post('toStation')),
            "fromStation" => array('code' => $this->input->post('fromStation')),
            "code" => $this->input->post('code'),
            "minFare" => $this->input->post('minFare'),
            "maxFare" => $this->input->post('maxFare'),
        );

        echo $this->api_model->addRoutes($data);
    }

    function status_routes() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            "toStation" => array('code' => $this->input->post('toStation')),
            "fromStation" => array('code' => $this->input->post('fromStation')),
            'activeFlag' => $this->input->post('activeFlag')
        );
        echo $this->api_model->updateRoutesDetails($data);
    }

    function delete_routes() {
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => 2);
        echo $this->api_model->updateRoutesDetails($data);
    }

    public function edit_cms_user() {
        $usrcodes = $this->input->post('userCode');
        $code = $this->input->post('code');
        /* $data = array(
          'userCode' => $usrcodes
          );
          if ($this->input->post('activeFlag') == 1) {
          $commission = $this->api_model->getUserCommission($data);
          $commission = json_decode($commission);
          $selectedFrom = date('Y-m-d', strtotime($this->input->post('activeFrom')));
          $selectedTo = date('Y-m-d', strtotime($this->input->post('activeTo')));

          foreach ($commission->data AS $com) {
          $oldDateBegin = date('Y-m-d', strtotime($com->activeFrom));
          $oldDateEnd = date('Y-m-d', strtotime($com->activeTo));
          if (((isset($code) && $code != $com->code) || (!isset($code) || $code == '')) && $com->activeFlag == 1) {
          if (($selectedFrom >= $oldDateBegin) && ($selectedFrom <= $oldDateEnd)) {
          echo json_encode(array('status' => 3));
          exit;
          } else if (($selectedTo > $oldDateBegin) && ($selectedTo < $oldDateEnd)) {
          echo json_encode(array('status' => 4));
          exit;
          }
          }
          }
          } */

        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            //'activeTo' => $this->input->post('activeTo'),
            //'activeFrom' => $this->input->post('activeFrom'),
            'userCode' => $this->input->post('userCode'),
            'code' => $this->input->post('code'),
            'valueType' => array('code' => 'PER'),
            'commissionType' => 'BO'
        );
        echo $this->api_model->updateCommission($data);
    }
    
    public function edit_ctr_user() {
        $usrcodes = $this->input->post('userCode');
        $code = $this->input->post('code');
    
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'userCode' => $this->input->post('userCode'),
            'code' => $this->input->post('code'),
            'valueType' => array('code' => 'PER'),
            'commissionType' => 'CA'
        );
        echo $this->api_model->updateCommission($data);
    }
    
     public function edit_cancom_user() {
        $usrcodes = $this->input->post('userCode');
        $code = $this->input->post('code');
    
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'userCode' => $this->input->post('userCode'),
            'code' => $this->input->post('code'),
            'valueType' => array('code' => 'PER'),
            'commissionType' => 'CCA'
        );
        echo $this->api_model->updateCommission($data);
    }
    
    public function edit_cargo_user() {
        $usrcodes = $this->input->post('userCode');
        $code = $this->input->post('code');
    
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'userCode' => $this->input->post('userCode'),
            'code' => $this->input->post('code'),
            'valueType' => array('code' => 'PER'),
            'commissionType' => $this->input->post('act')
        );
        echo $this->api_model->updateCommission($data);
    }

    public function providers() {

        $this->is_logged_in();
        _include_js('assets/js/pages/gateway.js');

        $pro = $this->api_model->getGatewayProvider(array(
            'authtoken' => $this->_user_hash,
            'activeFlagFilter' => -1
        ));
        // print_r($pro);
        $proDetail = json_decode($pro);
        $data['provider'] = $proDetail->data;

        $mod = $this->api_model->getPaymentModes(array('authtoken' => $this->_user_hash));
        // print_r($pro);
        $modDetail = json_decode($mod);
        $data['modes'] = $modDetail->data;

        //$this->load->view('site/admin/payment-modes', $data);


        $this->load->view('site/admin/gateway-provider', $data);
    }

    function add_gateway_provider() {
        $this->is_logged_in();
        $data = array(
            "activeFlag" => 1,
            "name" => $this->input->post('name'),
            "code" => $this->input->post('code'),
            "serviceName" => $this->input->post('serviceName')
        );

        echo $this->api_model->addGatewayProvider($data);
    }

    function status_provider() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'serviceName' => $this->input->post('serviceName')
        );
        echo $this->api_model->updateProviderDetails($data);
    }

    function delete_provider() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => 2,
            'serviceName' => $this->input->post('serviceName')
        );
        echo $this->api_model->updateProviderDetails($data);
    }

    // Payment Modes

    public function payment_modes() {

        $this->is_logged_in();
        _include_js('assets/js/pages/payment_modes.js');

        $mod = $this->api_model->getPaymentModes(array(
            'authtoken' => $this->_user_hash,
            'activeFlagFilter' => -1
        ));
        // print_r($pro);
        $modDetail = json_decode($mod);
        $data['modes'] = $modDetail->data;

        $this->load->view('site/admin/payment-modes', $data);
    }

    function add_payment_modes() {
        $this->is_logged_in();
        $data = array(
            "activeFlag" => 1,
            "name" => $this->input->post('name'),
            "code" => $this->input->post('code'),
        );

        echo $this->api_model->addPaymentmodes($data);
    }

    function status_modes() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
        );
        echo $this->api_model->updateModeDetails($data);
    }

    function delete_modes() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => 2,
        );
        echo $this->api_model->updateModeDetails($data);
    }

    public function namespace_list() {
        $this->is_logged_in();

        _include_js('assets/js/pages/namespace.js');
        $namespace = $this->api_model->getNamespace(array(
            'authtoken' => $this->_user_hash,
            'activeFlagFilter' => -1
        ));
        $space = json_decode($namespace);
        $data['namespace_list'] = $space->data;

        $this->load->view('site/config/namespace-list', $data);
    }

    function update_namespace() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'pin' => $this->input->post('pin'),
            'mode' => "OWN"
        );
        echo $this->api_model->updateNamespaceDetails($data);
    }

    function add_gateway_partner() {
        $this->is_logged_in();

        $data = array(
            "activeFlag" => 1,
            "paymentMode" => array('code' => $this->input->post('part_mode')),
            "gatewayProvider" => array('code' => $this->input->post('pro_code')),
            "code" => $this->input->post('code'),
            "name" => $this->input->post('part_name'),
            "offerNotes" => $this->input->post('offerNotes'),
            "offerTerms" => $this->input->post('terms')?:[],
            "apiProviderCode" => $this->input->post('api_pro_code')
        );

        echo $this->api_model->addGatewayPartner($data);
//        echo json_encode($data);
    }

    public function get_gateway_partners() {
        $usrcodes = $this->input->post('usrCode');

        $partner = $this->api_model->getGatewayPartner(array(
            'activeFlagFilter' => -1
        ));
        $part = json_decode($partner);
        echo json_encode($part);
    }

    public function edit_gateway_partner() {

        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            "paymentMode" => array('code' => $this->input->post('part_mode')),
            "gatewayProvider" => array('code' => $this->input->post('pro_code')),
            "code" => $this->input->post('code'),
            "name" => $this->input->post('part_name'),
            "offerNotes" => $this->input->post('offerNotes'),
            "offerTerms" => $this->input->post('offerTerms')?:[],
            "apiProviderCode" => $this->input->post('api_pro_code')
        );


        echo $this->api_model->addGatewayPartner($data);
    }

    function switch_namespace() {

        $data = array(
            'code' => $this->input->post('code'),
        );
        
        $space = $this->api_model->getswitchNamespace($data);
        $namespace = json_decode($space);

        // switch to native branch
        $this->api_model->getswitchBranch(array('organizationCode' => ''));
        $this->rediscache->delete('user_assigned_branches:' . _get_user_id());
        
        if ($namespace->status == 1) {
            // Profile
            $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->_user_hash));
            $profile = json_decode($usr_pro);
            
            $this->session->set_userdata('namespace_id', $profile->data->namespace->code);
            $this->session->set_userdata('namespace_name', $profile->data->namespace->name);
            $this->session->set_userdata('namespace_mode', $profile->data->namespace->mode);
            $this->session->set_userdata('org_station_code', $profile->data->organization->station->code);
            $this->session->set_userdata('org_station_name', $profile->data->organization->station->name);
            $this->session->set_userdata('org_code', $profile->data->organization->code);
            $this->session->set_userdata('org_name', $profile->data->organization->name);
            $this->session->set_userdata('time_format', $profile->data->namespace->namespaceProfile->timeFormat);
            $this->session->set_userdata('date_format', $profile->data->namespace->namespaceProfile->dateFormate);
            $this->session->set_userdata('ns_domain_url', $profile->data->namespace->namespaceProfile->domainURL);
            $this->session->set_userdata('instant_cancellation_minutes', $profile->data->namespace->namespaceProfile->instantCancellationMinitues);
            $this->session->set_userdata('sms_notification_flag_code', $profile->data->namespace->namespaceProfile->smsNotificationFlagCode);
            //$this->session->set_userdata('balance', number_format($profile->data->currnetBalance, 2));
        }
        
        echo $space; 
    }

    public function credentials() {
        $this->is_logged_in();
        _include_js('assets/js/pages/credentials.js');

        $namespace = $this->api_model->getNamespace(array('authtoken' => $this->_user_hash));
        $space = json_decode($namespace);
        $data['namespace'] = $space->data;

        $pro = $this->api_model->getGatewayProvider(array('authtoken' => $this->_user_hash));
        $proDetail = json_decode($pro);
        $data['provider'] = $proDetail->data;

        $credentials = $this->api_model->getCredentials(array(
            'authtoken' => $this->_user_hash,
            'activeFlagFilter' => -1
        ));
        $cre = json_decode($credentials);
        $data['credential'] = $cre->data;

        $this->load->view('site/admin/credentials', $data);
    }

    public function update_credentials() {
        $this->is_logged_in();
        $data = array(
            'returnUrl' => $this->input->post('returnUrl'),
            'accessKey' => $this->input->post('accesskey'),
            'activeFlag' => $this->input->post('activeFlag'),
            'gatewayProvider' => array("code" => $this->input->post('gatewayProvider')),
            'serviceChargeValue' => $this->input->post('serviceChargeValue'),
            'propertiesFileName' => $this->input->post('propertiesFileName'),
            'attr1' => $this->input->post('attr1'),
            'percentageFlag' => $this->input->post('percentageFlag'),
            'accessCode' => $this->input->post('accessCode'),
            'customerBare' => $this->input->post('customerBare'),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateCredentialDetails($data);
    }

    public function payment_schedules() {
        $this->is_logged_in();
        _include_js('assets/js/pages/payment_schedules.js');

        $partner = $this->api_model->getGatewayPartner($data);
        $part = json_decode($partner);
        $data['partner'] = $part->data;

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $schedules = $this->api_model->getSchedules(array(
            'authtoken' => $this->_user_hash,
            'activeFlagFilter' => -1
        ));
        $sch = json_decode($schedules);

        usort($sch->data, function($a, $b) {
            return $a->precedence < $b->precedence ? -1 : 1;
        });
        $data['schedule'] = $sch->data;

        $this->load->view('site/admin/schedules', $data);
    }

    public function update_payment_schedules() {
        $this->is_logged_in();
        $data = array(
            'fromDate' => $this->input->post('fromDate'),
            'activeFlag' => $this->input->post('activeFlag'),
            'deviceMedium' => $this->input->post('deviceMedium')?:[],
            'name' => $this->input->post('name'),
            'gatewayPartner' => array("code" => $this->input->post('gatewayPartner')),
            'toDate' => $this->input->post('toDate'),
            'group' => array("code" => $this->input->post('group')),
            'code' => $this->input->post('code'),
            
            'serviceCharge' => $this->input->post('serviceCharge'),
            'precedence' => (int) $this->input->post('precedence'),
            'transactionType' => array("code" => $this->input->post('txnType'))
        );
        echo $this->api_model->updatePaymentScheduleDetails($data);
    }

    public function inventory() {
        $this->is_logged_in();
        _include_js('assets/js/pages/inventory.js');



        $namespace = $this->api_model->getNamespace(array('authtoken' => $this->_user_hash));
        $space = json_decode($namespace);
        $data['namespaces'] = $space->data;




        $this->load->view('site/config/inventory', $data);
    }

    function inventory_group() {

        $this->load->view('site/config/inventory-group', $data);
    }

    function update_token() {
        $data = array(
            'tokenPassword' => $this->input->post('token'),
        );
        echo $this->api_model->updateApiToken($data);
    }

    public function update_inventory() {
        $this->is_logged_in();
    }

    public function updategroup_inventory() {
        $this->is_logged_in();

        echo $this->api_model->updategroupInventory($data);
    }

    public function status_inventory() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateInventory($data);
    }

    public function status_inventorygroup() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updategroupInventory($data);
    }

    public function commission_inventory() {

//        $commission = $this->api_model->getUserCommission($data);
//        $commission = json_decode($commission);
//        $selectedFrom = date('Y-m-d', strtotime($this->input->post('activeFrom')));
//        $selectedTo = date('Y-m-d', strtotime($this->input->post('activeTo')));
//
//        foreach ($commission->data AS $com) {
//            $oldDateBegin = date('Y-m-d', strtotime($com->activeFrom));
//            $oldDateEnd = date('Y-m-d', strtotime($com->activeTo));
//            if (((isset($code) && $code != $com->code) || (!isset($code) || $code == '')) && $com->activeFlag == 1) {
//                if (($selectedFrom >= $oldDateBegin) && ($selectedFrom <= $oldDateEnd)) {
//                    echo json_encode(array('status' => 3));
//                    exit;
//                } else if (($selectedTo > $oldDateBegin) && ($selectedTo < $oldDateEnd)) {
//                    echo json_encode(array('status' => 4));
//                    exit;
//                }
//            }
//        }

        $commission = array(
            'activeTo' => $this->input->post('activeTo'),
            'activeFrom' => $this->input->post('activeFrom'),
            'creditLimit' => $this->input->post('creditlimit'),
            'value' => $this->input->post('value'),
            //  'userCode' => $this->input->post('userCode'),
            'percentageFlag' => $this->input->post('percentageFlag'),
            'activeFlag' => $this->input->post('activeFlag'),
                //'code' => $this->input->post('code')
        );
        $data = array('code' => $this->input->post('inventorycode'), 'commissionList' => $commission);
        echo $this->api_model->updateInventory($data);
    }

    public function template() {
        $this->is_logged_in();

        $template = $this->api_model->getTemplate(array('authtoken' => $this->_user_hash));
        $temp = json_decode($template);
        $data['template'] = $temp->data;



        $this->load->view('site/admin/template', $data);
    }

    public function add_template() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'template' => $this->input->post('template'),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateTemplate($data);
    }

    function delete_template() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => 2,
            'name' => $this->input->post('name'),
            'template' => $this->input->post('template'),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateTemplate($data);
    }

    public function notifications() {
        $this->is_logged_in();
        _include_js('assets/js/pages/admin_notify.js');

        $notify = $this->api_model->getNotifications(array(
            'authtoken' => $this->_user_hash,
            'activeFlagFilter' => -1
        ));
        $temp = json_decode($notify);

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);

        $userDetails = $this->api_model->getUser();
        $userDetail = json_decode($userDetails);

        $data['users'] = $userDetail->data;
        $data['groups'] = $GroupDetail->data;
        $data['notify'] = $temp->data;

        $this->load->view('site/admin/notifications', $data);
    }

    public function update_admin_notify() {
        $this->is_logged_in();

        $date = explode('|', $this->input->post('fdate'));
        $fromdate = $date[0];
        $todate = $date[1];
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'activeFrom' => $fromdate,
            'activeTo' => $todate,
            'name' => $this->input->post('name'),
            'commentFlag' => $this->input->post('cmt_flg'),
            'group' => array('code' => $this->input->post('group')),
            'user' => array('code' => $this->input->post('user')),
            'message' => $this->input->post('message'),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateAdminNotify($data);
    }

    public function delete_admin_notify() {
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateAdminNotify($data);
    }

    public function vehicle() {
        $this->is_logged_in();
        _include_js('assets/js/pages/vehicle.js');
        _include_js('assets/js/pages/vehicle.js', 'sm_loadstates');
        //get vehicle
        $get_vehicle = $this->api_model->getAllVehicle();
        $vehicle = json_decode($get_vehicle);
        
        //get vehicle
        $gpsVendors = $this->api_model->getGPSVendors();
        $gpsVendors = json_decode($gpsVendors);

        $data['vehicle'] = $vehicle->data;
        $data['gpsVendors'] = $gpsVendors->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        $contact = $this->api_model->getContact(array('entityTypeCode' => 'TRANS', 'tag' => 'OWN'));
        $contact = json_decode($contact);
        $data['contact'] = $contact->data;
        
        $result = $this->api_model->cargoTags(array('categoryCode' => 'VHCL'));
        $result = json_decode($result);
        $data['cargotags'] = $result->data;
        $data['vehicle_brand'] = $this->config->item('vehicle_brand');
        $data['cargo_setting'] = _get_cargo_settings();

        $this->load->view('site/admin/vehicle', $data);
    }

    public function get_bank_detail() {
        $this->is_logged_in();

        $get_bank_details = $this->api_model->getBankDetail(array('authtoken' => $this->_user_hash, 'entityType' => 'DRVR', 'code' => $this->input->post('code')));
        $bank_details = json_decode($get_bank_details);
        $data['bank_detail'] = $bank_details->data;
        $this->load->view('site/config/bank-detail', $data);
    }

    public function add_vehicle() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'registationNumber' => $this->input->post('registationNumber'),
            'registrationDate' => $this->input->post('registrationDate'),
            'gpsDeviceCode' => $this->input->post('gpsDeviceCode'),
            'gpsDeviceVendor' => $this->input->post('gpsDeviceVendor'),
            'licNumber' => $this->input->post('licNumber'),
            'vehicleType' => $this->input->post('vehicleType'),
            'tag' => $this->input->post('tag') ?: [],
            'transporterContact' => $this->input->post('transporterContact'),
            // 'vehicleStatus' => $this->input->post('vehicleStatus'),
            // 'aadharNo' => $this->input->post('aadharNo'),
            'ownershipType' => $this->input->post('ownershipType') ?: null,
            'state' => $this->input->post('state') ?: null,
            'purchaseDate' => $this->input->post('purchaseDate') ?: '',
            'lastFcDate' => $this->input->post('lastFcDate') ?: '',
            'makeType' => $this->input->post('makeType') ?: '',
            'modelType' => $this->input->post('modelType') ?: '',
            'fuelType' => $this->input->post('fuelType') ?: null,
            'averageMileage' => (float)$this->input->post('averageMileage'),
            'dimensions' => $this->input->post('dimensions') ?: '',
            'fuelTankCapacity' => (float)$this->input->post('fuelTankCapacity'),
            'oilCapacity' => (float)$this->input->post('oilCapacity'),
            'adblueCapacity' => (float)$this->input->post('adblueCapacity'),
            'loadCapacity' => (float)$this->input->post('loadCapacity'),
            'loadMeasurement' => $this->input->post('loadMeasurement') ?: ''

        );
        if($this->input->post('code') != ''){
            $data['code'] = $this->input->post('code');
        }
        
        echo $this->api_model->updateVehicle($data);
    }

    public function add_bank_details() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'referenceCode' => $this->input->post('referenceCode'),
            'accountNumber' => $this->input->post('accountNumber'),
            'accountType' => $this->input->post('accountType') ?: '',
            'entityType' => $this->input->post('entityType') ?: '',
            'bankName' => $this->input->post('bankName'),
            'branchLocation' => $this->input->post('branchLocation'),
            'ifscCode' => $this->input->post('ifscCode'),
            'upiId' => $this->input->post('upiId')

        );
        if($this->input->post('code') != ''){
            $data['code'] = $this->input->post('code');
        }
        
        echo $this->api_model->updateBankDetail($data);
    }

    public function report_admin() {
        $this->is_logged_in();
        _include_js('assets/js/pages/report_admin.js');

        $reports = $this->api_model->getAllReportList(array('authtoken' => $this->_user_hash));
        $sch = json_decode($reports);
        $data['schedule'] = array();
        foreach ($sch->data as $row) {
            $row->query = htmlspecialchars($row->query);
            $data['schedule'][] = $row;
        }
        //$data['schedule'] = $sch->data;

        $this->load->view('site/admin/report-admin', $data);
    }

    public function update_report_admin() {
        $this->is_logged_in();
        $data = array(
            'daysLimit' => $this->input->post('daysLimit'),
            'description' => $this->input->post('description'),
            'activeFlag' => $this->input->post('activeFlag'),
            'query' => $this->input->post('query'),
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateReportAdminDetails($data);
    }

    public function widgets_admin() {
        $this->is_logged_in();
        _include_js('assets/js/pages/widgets_admin.js');

        $reports = $this->api_model->getAllWidgetsList(array('authtoken' => $this->_user_hash));
        $sch = json_decode($reports);
        $data['entity'] = $sch->data;

        $this->load->view('site/admin/widgets-admin', $data);
    }

    public function update_widgets_admin() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'callbackFunction' => $this->input->post('callback'),
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateWidgetsDetails($data);
    }

    public function getAgents() {
        $this->is_logged_in();

        $organizationDetails = $this->api_model->getOrganization(array('authtoken' => $this->_user_hash));
        $organizationDetail = json_decode($organizationDetails);


        $data['organization'] = $organizationDetail->data;


        $GroupDetails = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetails);
        $data['groups'] = $GroupDetail->data;

        $userDetails = $this->api_model->getUser();
        echo $userDetails;
    }

    public function terms() {
        $this->is_logged_in();
        _include_js('assets/js/pages/terms.js', 'init_terms');

        $termsDetails = $this->api_model->getterms(array('type' => 'TICKBO'));
        $termslist = json_decode($termsDetails);

        $data['terms_list'] = $termslist->data;
        $this->load->view('site/admin/terms', $data);
    }

    public function update_terms() {
        $terms = $this->input->post('terms');     
        $seq = 0;
        foreach ($terms as $term) {
            $seq++;
            $data = array(
                'transactionType' => array("code" => "TICKBO"),
                'name' => $term['name'],
                'sequence' => $seq   
            );
            if($term['code']!="") {
               $data['activeFlag'] = $term['activeflag'];
               $data['code'] = $term['code'];
            }
            $this->api_model->updateterms($data);
        }
        echo json_encode(array('status' => 1));
    }
    
    public function cargo_terms() {
        $this->is_logged_in();
        _include_js('assets/js/pages/cargo-terms.js', 'init_terms');

        $termsDetails = $this->api_model->getterms(array('type' => 'CGBO'));
        $termslist = json_decode($termsDetails);

        $data['terms_list'] = $termslist->data;
        $this->load->view('site/cargo/terms', $data);
    }

    public function update_cargo_terms() {
        $terms = $this->input->post('terms');     
        $seq = 0;
        foreach ($terms as $term) {
            $seq++;
            $data = array(
                'transactionType' => array("code" => "CGBO"),
                'name' => $term['name'],
                'sequence' => $seq   
            );
            if($term['code']!="") {
               $data['activeFlag'] = $term['activeflag'];
               $data['code'] = $term['code'];
            }
            $this->api_model->updateterms($data);
        }
        echo json_encode(array('status' => 1));
    }

    public function discount() {
        $this->is_logged_in();
        _include_js('assets/js/pages/terms.js', 'init_terms');

        $discountDetails = $this->api_model->getdiscount(array('authtoken' => $this->_user_hash));
        $discountlist = json_decode($discountDetails);

        $data['discount_list'] = $discountlist->data;
        $this->load->view('site/admin/admin', $data);
    }

    public function update_discount() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'decription' => $this->input->post('description'),
        );

        echo $this->api_model->updatediscount($data);
    }

    public function extra_commission() {
        _include_js('assets/js/pages/extra-commission.js');
        $this->is_logged_in();
        // Get Active Schedules
        $schedulesactive = $this->api_model->getScheduleByType(array('type' => 'none'));
        $schedulesactive = json_decode($schedulesactive);
        $schedulesactive = $schedulesactive->data;
        $data['schedules'] = $schedulesactive;

        // Get Active Users 
        $userDetails = $this->api_model->getUser();
        $userDetail = json_decode($userDetails);
        $data['users'] = $userDetail->data;
        
        //  get all groups
        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;
        
        //  get extra comission slab
        $json = $this->api_model->getExtraCommissionSlab();
        $data['slabs'] = json_decode($json);
        $data['slabs'] = $data['slabs']->data;
        
        // Get Routes
        $routeDetails = $this->api_model->getRoutes(array('authtoken' => $this->_user_hash));
        $routeDetail = json_decode($routeDetails);
        $data['routes'] = $routeDetail->data;
        
        // Get extra commission
        $extra = $this->api_model->getExtraCommission();
        $extra = json_decode($extra);
        $extra = $extra->data;
        $data['extra'] = $extra;

        $this->load->view('site/config/extra-commission', $data);
    }

    public function get_commission_group() {
        $this->is_logged_in();
        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $select = '<select id="group" class="form-control col-md-6"><option value="all">All Group</option>';
        foreach ($GroupDetail->data as $group) {
            $select .= '<option value="' . $group->code . '">' . $group->name . '</option>';
        }
        $select .= '</select>';
        echo $select;
    }

    public function update_extra_commission() {
        $this->is_logged_in();
        $week = $this->input->post('dayOfWeek');
        $days = '';
        foreach ($week as $wk) {
            $days .= $wk;
        }

        $sch = $this->input->post('schedule');
        foreach ($sch as $sc) {
            $sche[] = array(
                'code' => $sc
            );
        }
        
        $rout = $this->input->post('route');
        foreach ($rout as $r) {
            $routes[] = array(
                'code' => $r
            );
        }
        
        $commi_flag = 'FLT';
        if($this->input->post('percentageFlag')==1) {
            $commi_flag = 'PER';
        }
        
        $data = array(
            'name' => $this->input->post('name'),
            'commissionValueType' => array('code'=>$commi_flag),
            'activeFlag' => 1,
            'dateType' => $this->input->post('comm_date'),
            'commissionValue' => $this->input->post('comm_value'),
            'schedule' => $sche,
            'route' => $routes,
            'activeFrom' => $this->input->post('activeFrom'),
            'activeTo' => $this->input->post('activeTo'),
            'group' => array('code' => $this->input->post('group')),
            'user' => array('code' => $this->input->post('user')),
            'roleType' => $this->input->post('role'),
            'dayOfWeek' => $days,
            'code' => $this->input->post('code'),
            
            'commissionSlab' => array('code'=>$this->input->post('slab_id')),
            'maxCommissionLimit' => $this->input->post('max_commission_limit'),
            'minTicketFare' => $this->input->post('min_ticket_fare'),
            'maxExtraCommissionAmount' => $this->input->post('max_xtr_com_amt'),
            'minSeatCount' => $this->input->post('min_seat_count'),
            'overrideCommissionFlag' => (int)$this->input->post('overrideCommissionFlag')
        );

        if ($this->input->post('group') != '') {
            $data['group'] = array('code' => $this->input->post('group'));
        }

        echo $this->api_model->updateExtraCommission($data);
    }

    function delete_extra_commission() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => 2,
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateExtraCommission($data);
    }

    function update_extra_commission_exception() {
        $this->is_logged_in();
        $week = $this->input->post('dayOfWeek');
        $days = '';
        foreach ($week as $wk) {
            $days .= $wk;
        }
        $data = array(
            'name' => $this->input->post('name'),
            'activeFlag' => 1,
            'activeFrom' => $this->input->post('activeFrom'),
            'activeTo' => $this->input->post('activeTo'),
            'dayOfWeek' => $days,
            'lookupCode' => $this->input->post('commissionCode'),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateExtraCommission($data);
    }

    function delete_extra_commission_exception() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => 2,
            'code' => $this->input->post('code'),
            'lookupCode' => $this->input->post('commission_code')
        );
        echo $this->api_model->updateExtraCommission($data);
    }

    public function discount_category() {
        _include_js('assets/js/pages/discount.js');
        $this->is_logged_in();
        $category = $this->api_model->getDiscountCategory(array('authtoken' => $this->_user_hash));
        $category = json_decode($category);
        $data['category'] = $category->data;
        $this->load->view('site/config/discount-category', $data);
    }

    public function update_discount_category() {
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'activeFlag' => 1,
            'description' => $this->input->post('description'),
        );
        if ($this->input->post('code') != '') {
            $data['code'] = $this->input->post('code');
        }
        echo $this->api_model->updateDiscountCategory($data);
    }

    public function delete_discount_category() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => 2,
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateDiscountCategory($data);
    }

    public function coupon() {
        _include_js('assets/js/pages/discount.js');
        $this->is_logged_in();

        $category = $this->api_model->getDiscountCategory(array('authtoken' => $this->_user_hash));
        $category = json_decode($category);
        $data['category'] = $category->data;

        $coupon = $this->api_model->getDiscountCoupon(array('authtoken' => $this->_user_hash));
        $coupon = json_decode($coupon);
        $data['coupon'] = $coupon->data;
        $this->load->view('site/config/discount-coupon', $data);
    }

    public function update_discount_coupon() {
        $this->is_logged_in();
        $data = array(
            'coupon' => $this->input->post('name'),
            'activeFlag' => 1,
            'description' => $this->input->post('description'),
            'discountCategory' => array("code" => $this->input->post('category'))
        );
        if ($this->input->post('code') != '') {
            $data['code'] = $this->input->post('code');
        }
        echo $this->api_model->updateDiscountCoupon($data);
    }

    public function delete_discount_coupon() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => 2,
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateDiscountCoupon($data);
    }

    public function discount_coupon() {
        _include_js('assets/js/pages/discount.js');
        $this->is_logged_in();

        $category = $this->api_model->getDiscountCategory(array('authtoken' => $this->_user_hash));
        $category = json_decode($category);
        $data['category'] = $category->data;

        $coupon = $this->api_model->getDiscountCoupon(array('authtoken' => $this->_user_hash));
        $coupon = json_decode($coupon);
        $data['coupon'] = $coupon->data;

        // Get Active Schedules
        $schedulesactive = $this->api_model->getScheduleByType(array('type' => 'none'));
        $schedulesactive = json_decode($schedulesactive);
        $schedulesactive = $schedulesactive->data;
        $data['schedules'] = $schedulesactive;

        // Get Routes
        $routeDetails = $this->api_model->getRoutes(array('authtoken' => $this->_user_hash));
        $routeDetail = json_decode($routeDetails);
        $data['route'] = $routeDetail->data;

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $GroupDetail = $GroupDetail->data;
        $data['group'] = $GroupDetail;

        $this->load->view('site/config/discount-coupon-list', $data);
    }

    public function update_discount_criteria() {
        $this->is_logged_in();
        $week = $this->input->post('dayOfWeek');
        $days = '';
        foreach ($week as $wk) {
            $days .= $wk;
        }
        
        $critriaId = $this->input->post('critriaId');
        
        $data = array(
            'activeFlag' => 1,
            'percentageFlag' => $this->input->post('percentageFlag')==1 ? true: false,
            'maxDiscountAmount' => $this->input->post('maxDiscountAmount') ?: 0,
            'minFreightAmount' => $this->input->post('minFreightAmount') ?: 0,
            'value' => $this->input->post('comm_value') ?: 0,
            'activeFrom' => $this->input->post('activeFrom'),
            'activeTo' => $this->input->post('activeTo'),
            'dayOfWeek' => $days,
            'paymentTypes' => $this->input->post('paymentTypes') ?: [],
            'organizations' => $this->input->post('organizations') ?: [],
            'discountCoupon' => array("code" => $this->input->post('coupon_code')),      		
        );
        
        if( !empty($critriaId) ) {
            $data['code'] = $critriaId;
        }
            
        echo $this->api_model->updateDiscountCriteria($data);
    }
  
    public function get_discount_coupon_filter(){
    	$couponCode= $this->input->post('coupon_code');
    	$coupon = $this->api_model->getDiscountCouponFilter(array('authtoken' => $this->_user_hash, 'couponCode' => $couponCode));
    	$coupon = json_decode($coupon);
    	$data['coupon'] = $coupon->data;
    	
    	$this->load->view('site/config/discount-coupon-filter-list', $data);
    }
    public function discounts(){
    	$this->is_logged_in();
    	_include_js('assets/js/pages/discount.js');

    	$category = $this->api_model->getDiscountCategory(array('authtoken' => $this->_user_hash));
    	$category = json_decode($category);
    	$data['category'] = $category->data;
    	 
    	$coupon = $this->api_model->getDiscountCoupon(array('authtoken' => $this->_user_hash));
    	$coupon = json_decode($coupon);
    	$data['coupon'] = $coupon->data;
        
        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;
    	
        $data['payment_type'] = config_item('user_payment_type');

        $this->load->view('site/config/discounts',$data);
    }
    
    public function gallery() { //manage gallery
        $this->is_logged_in();
         _include_js('assets/js/imagesloaded.pkgd.min.js');
        _include_js('assets/lib/freewall/freewall.js');
        _include_js('assets/lib/magnific-popup/jquery.magnific-popup.min.js');
        _include_js('assets/js/pages/gallery.js');
        
        $galleryDetails = $this->api_model->getGalleries(array('authtoken' => $this->_user_hash));
        $galleryDetail = json_decode($galleryDetails);
        $data['gallery'] = $galleryDetail->data;
        $this->load->view('site/config/gallery', $data);
    }
    
    public function update_gallery() { // update gallery
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag')
        );
        echo $this->api_model->updateGalleryDetails($data);
    }
    
    public function get_gallery_details() { // get gallery details
        $this->is_logged_in();
        $galleryDetails = $this->api_model->getGallery($this->input->post('code'));
        $galleryDetail = json_decode($galleryDetails);
        $data['gallery'] = $galleryDetail->data;
        
        $galleryImages = $this->api_model->getGalleryImages($this->input->post('code'));
        $galleryImage = json_decode($galleryImages);
        $data['image'] = $galleryImage->data;
        
        $this->load->view('site/config/gallery-images',$data);
    }
    
    public function upload_gallery() { // upload images to gallery
        $this->is_logged_in();
        //$image = $this->api_model->uploadImages();
        $this->load->library('thumbnail');
        
        $img_name = $_FILES['file']['name'];
        if(!$img_name) {
            echo json_encode(array('status' => 0));
        }
        list($usec, $sec) = explode(" ", microtime());
        $output = $usec;
        $int = number_format($output, 4, "", ".");
        $to_folder = 'uploads/bus-images/' . $this->session->userdata('namespace_id') . '/'.date('Y/m/d').'/';
        if (!is_dir($to_folder)) {
            @mkdir($to_folder, 0777, true);
            @chmod($to_folder, 0777);
        }
        $extn = pathinfo($img_name, PATHINFO_EXTENSION);
        $file_name = 'image-bus' . $int . '.' . $extn;
        $uploaddir = $to_folder;
        $to_name = $to_folder . $file_name;
        $db_name = $to_folder.'[##]-bus' . $int . '.' . $extn;
        $uploadfile = $uploaddir . $file_name;
        if (move_uploaded_file($_FILES['file']['tmp_name'], $to_name)) {

            $filenames = $to_name;
            $newfilename = 'uploads/bus-images/' . $this->session->userdata('namespace_id') . '/'.date('Y/m/d').'/thumb-bus' . $int . '.' . $extn;
            
            $this->thumbnail->init($filenames, 200, 200, 0, 100);
            $this->thumbnail->save($newfilename);

            $this->thumbnail->init($filenames, 800, 800, 0, 100);
            $this->thumbnail->save($to_name);
            
            @chmod($to_folder, 0777);
            @chmod($to_name, 0777);
            //return $db_name;
        }
        
        $data = array(
            'name' => '',
            'activeFlag' => 1,
            'code' => '',
            'imageURL' => base_url().$db_name,
            'gallery' => $_GET['id']
        );
        echo $this->api_model->updateGalleryImage($data);
    }
    
    public function delete_gallery_image() {
        $this->is_logged_in();
        $data = array(
            'name' => '',
            'activeFlag' => 2,
            'code' => $this->input->post('img_code'),
            'imageURL' => $this->input->post('img_url'),
            'gallery' => $this->input->post('gall_code')
        );
        echo $this->api_model->updateGalleryImage($data); 
    }
    
    public function phonebook_control() { // phonebook policy
        $this->is_logged_in();        
        
        $groups = $this->api_model->getGroup();
        $groups = json_decode($groups);
        foreach ($groups->data AS $rts) {
            if (!empty($rts->code) && $rts->activeFlag == 1) {
                $grp[] = array(
                    'code' => $rts->code,
                    'name' => $rts->name
                );
            }
        }
        $data['groups'] = $grp;
        
        foreach ($groups->data AS $rts) {
            $Groupuser = $this->api_model->getUserByGroup(array('groupcode' => $rts->code));
            $Groupuser = json_decode($Groupuser);            
            $tmp[] = array(
                'code' => $rts->code,
                'groupname' => $rts->name,
                'level' => $grp->level,
                'activeFlag' => $grp->activeFlag,
                'userCount' => $grp->userCount,
                'users' => $Groupuser->data
            );
        }
        
        $data['entity'] = $tmp;

        $schedulesactive = $this->api_model->getScheduleByType(array('type' => 'none'));
        $schedulesactive = json_decode($schedulesactive);
        $data['schedules'] = $schedulesactive->data;

        $routes = $this->api_model->getRoutes();
        $routes = json_decode($routes);
        $data['routes'] = $routes->data;
        
        $pbc = $this->api_model->getPhoneBookTimeControl(); 
        $data['pbc'] = json_decode($pbc);
        
        $pbcl = $this->api_model->getPhoneBookLimitControl(); 
        $data['pbc_limit'] = json_decode($pbcl);
        
                
        $this->load->view('site/config/phonebook-control', $data);
    }
    
    public function save_phonebook_policy() {
        $this->is_logged_in();
        $date = explode('|', $this->input->post('daterange'));
        $fromdate = $date[0];
        $todate = $date[1];
        
        $dayofweek = $this->input->post('dayofweek');
        $dayofweek = implode('', $dayofweek);
        
        $pbc_code = $this->input->post('pbc_code');
        
        $data = array(
            "activeFlag" => 1,
            "activeFrom" => trim($fromdate),
            "activeTo" => trim($todate),
            "blockMinutesType" => "MIN",
            "blockMinutes" => $this->input->post('close_hours'),
            "allowMinutes" => $this->input->post('open_days'),
            "group" => array( "code" => $this->input->post('group')  ),            
            "dayOfWeek" => $dayofweek
        );
        
        if(!empty($pbc_code)) $data['code'] = $pbc_code;
        
        echo $this->api_model->updatePhoneBookTimeControl($data); 
    }
    
    public function delete_phonebook_policy() {
        $this->is_logged_in();
               
        $data = array(
            "activeFlag" => 2,
            "code" => $this->input->post('code'),
            "blockMinutesType" => "MIN"
        );
        echo $this->api_model->updatePhoneBookControl($data); 
    }
    
    public function delete_phonebook_limit_policy() {
        $this->is_logged_in();
               
        $data = array(
            "activeFlag" => 2,
            "code" => $this->input->post('code'),
            "slabMode" => "STCNT"
        );
        echo $this->api_model->updatePhoneBookLimitControl($data); 
    }
    
    public function save_phonebook_limit_policy() {
        $this->is_logged_in();
        
        $date = explode('|', $this->input->post('daterange'));
        $fromdate = $date[0];
        $todate = $date[1];
        
        $dayofweek = $this->input->post('dayofweek');
        $dayofweek = implode('', $dayofweek);
        
        $pbc_limit_code = $this->input->post('pbc_limit_code');
        
        $data = array(
            'name' => 'Name Here',
            "activeFlag" => 1,
            "activeFrom" => trim($fromdate),
            "activeTo" => trim($todate),
            "dayOfWeek" => $dayofweek,
            
            "dateType" => $this->input->post('date_type'),
            "refferenceType" => $this->input->post('role'),
            "maxSlabValueLimit" => $this->input->post('seat_count'),
            "slabCalenderMode" => $this->input->post('cal_type'),
            "slabCalenderType" => $this->input->post('cal_interval'),
            "scheduleList" => $this->input->post('scheduleList') ?: [],
            "routeList" => $this->input->post('routeList') ?: [],
            "ticketStatus" => $this->input->post('ticketStatus'),
            "slabMode" => "STCNT",
            "respectiveFlag" => $this->input->post('respectiveFlag')
        );
        
        if($data['refferenceType']=="UR") {
            $data['user'] = array( "code" => $this->input->post('user')  );
        } else {
            $data['group'] = array( "code" => $this->input->post('group')  );
        }

        if(!empty($pbc_limit_code)) {
            $data['code'] = $pbc_limit_code;
        }
        
        echo $this->api_model->updatePhoneBookLimitControl($data); 
    }
    
    
    public function travel_stops() {
        $this->is_logged_in();
        _include_js('assets/js/pages/travel_stops.js');
        
        
        $json = $this->api_model->getAllTravelStops(array(
            'activeFlagFilter' => -1
        ));
        $json = json_decode($json);
        $data['entity'] = $json->data;
        
        $this->load->view('site/config/travel-stops', $data);
    }
    
    public function edit_travel_stops() {
        $this->is_logged_in();
        _include_js('assets/js/pages/travel_stops.js');

        $data['stop_amenities'] = config_item('travel_stop_amenities');
        $data['travel_stop_restroom'] = config_item('travel_stop_restroom');
        if ($code = $this->input->get('code')) {
            $json = $this->api_model->getTravelStop(array('code' => $code));
            $json = json_decode($json);
            $data['stop'] = $json->data[0];
        }

        $this->load->view('site/config/travel-stops-edit', $data);
    }

    public function save_travel_stops() {
        $this->is_logged_in();
               
        $data = array(
            "activeFlag" => 1,
            "name" => $this->input->post('name'),
            "latitude" => $this->input->post('latitude'),
            "longitude" => $this->input->post('longitude'),
            "landmark" => $this->input->post('landmark'),
            "minutes" => $this->input->post('waitingtime'),
            "amenities" => $this->input->post('amenities'),
            "itemType" => $this->input->post('food_type'),
            "restRoom" => $this->input->post('restRoom')
        );
        
        if($this->input->post('code')!=='') {
            $data['code'] = $this->input->post('code');
        }
        
        echo $this->api_model->updateTravelStops($data); 
    }
    
    public function update_travel_stop() {
        $this->is_logged_in();               
        $data = $this->input->post('stop');       
        echo $this->api_model->updateTravelStops($data); 
    }
    
    
    public function extra_commission_slab() {
        $this->is_logged_in();
        $data = array();
        
        $json = $this->api_model->getExtraCommissionSlab();
        $data['slabs'] = json_decode($json);
        $this->load->view('site/config/extra-commission-slab', $data);
    }
    
    public function save_extra_commission_slab() {
        $this->is_logged_in();
               
        $data = array(
            "activeFlag" => 1,
            "name" => $this->input->post('name'),
            "slabMode" => array('code' => $this->input->post('slabmode')),
            "slabFromValue" => $this->input->post('fromvalue'),
            "slabCalenderMode" => array('code' => $this->input->post('intervalmode')),
            "slabToValue" => $this->input->post('tovalue'),
            "slabCalenderType" => array('code' => $this->input->post('interval'))
        );
        
        if($this->input->post('code')!=='') {
            $data['code'] = $this->input->post('code');
        }   
        echo $this->api_model->updateExtraCommissionSlab($data); 
    }
    
    public function delete_extra_commission_slab() {
        $this->is_logged_in();
               
        $data = array(
            "activeFlag" => 2,
            "code" => $this->input->post('code')
        );

        echo $this->api_model->updateExtraCommissionSlab($data); 
    }
    
    public function gst() {
        $this->is_logged_in();
        
        $data = array();
        $json = $this->api_model->getAllStates( array() );
        $data['states'] = json_decode($json);
        
        $json = $this->api_model->getGstDetails(array(
            'activeFlagFilter' => -1
        ));
        $data['gsts'] = json_decode($json);
        $this->load->view('site/config/gst', $data);
    }
    
    public function delete_gst() {
        $this->is_logged_in();        
        echo $this->api_model->updateGstDetails($this->input->post('item')); 
    }
    
    public function save_gst() {
        $this->is_logged_in();               
        $data = array(
            "activeFlag" => 1,
            "productType" => array('code' => $this->input->post('product')),
            "name" => $this->input->post('name'), 
            "tradeName" => $this->input->post('tradename'),
            "gstin" => $this->input->post('gstn'),
            "state" => array('code' => $this->input->post('state')),
            "cgstValue" => $this->input->post('cgst'),            
            "sgstValue" => $this->input->post('sgst'),
            "igstValue" => $this->input->post('igst'),
            "ugstValue" => $this->input->post('ugst'),
            "sacNumber" => $this->input->post('sac'),
        );
        echo $this->api_model->updateGstDetails($data); 
    }

    public function pob_devices() {
        $this->is_logged_in();
        
        $data = array();
        
        $json = $this->api_model->getActivePobDetails(array(
            'activeFlagFilter' => -1
        ));
        $json = json_decode($json);
        $data['active_tabs'] = $json;
        
        $registed = array();
        foreach ($json->data as $pob) {
            $registed[$pob->busVehicle->registationNumber] = $registed[$pob->busVehicle->registationNumber] . $pob->name . ', ';
        }
        $data['registered_pob'] = $registed;
        
        $json = $this->api_model->getPendingPobDetails();
        $data['pending'] = json_decode($json);
        
        $this->load->view('site/config/pob-devices', $data);
    }
    
    public function update_pob_device() {
        $this->is_logged_in();               
        
        $code = $this->input->post('code');
        if($code == ""){
            $data = array(
            "activeFlag" => 1,
            "name" => $this->input->post('name'),
            "mobileNumber" => $this->input->post('mobileNumber')
        );
            echo $this->api_model->updatePobDevice($data);
        }
        else{
            $data = array(
            "activeFlag" => 1,
            "name" => $this->input->post('name'),
            "mobileNumber" => $this->input->post('mobileNumber'),
            "code"  => $this->input->post('code')  
        );
            echo $this->api_model->editPobDevice($data);
        }
         
        //echo json_encode($data);
    }
    
    public function delete_pob_device() {
        $this->is_logged_in();               
        $data = $this->input->post('device');
        echo $this->api_model->deletePobDevice($data); 
    }
    
    public function generate_otp() {
        $this->is_logged_in();               
        $data = array(
            "code" => $this->input->post('code'),            
        );
        echo $this->api_model->generatePobMobileVerifyOTP($data);
    }
    
    public function generate_pin() {
        $this->is_logged_in();               
        $data = array(
            "device" => $this->input->post('device'),            
        );
        echo $this->api_model->generateDevicePin($data);
    }
    
    public function get_vehicle_list() {
        $this->is_logged_in();               
        echo $this->api_model->getVehicle(array('authtoken' => $this->_user_hash));        
    }
    
    public function update_device_vehicle() {
        $this->is_logged_in();               
        $data = array(
            "busVehicle" => array('code' => $this->input->post('vehicle_id')),
            "code" => $this->input->post('device_id'),            
        );
        echo $this->api_model->updateDeviceVehicle($data); 
    }
    
    public function offline_discount() {
        $this->is_logged_in();     
        _include_js('assets/js/pages/offline-discount.js', 'init_od_page');  
        
        // Get Active Schedules
        $schedulesactive = $this->api_model->getScheduleByType(array('type' => 'none'));
        $schedulesactive = json_decode($schedulesactive);
        $schedulesactive = $schedulesactive->data;
        $data['schedules'] = $schedulesactive;
        
        //  get all groups
        $GroupDetail = $this->api_model->getGroup();
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        
        // Get Routes
        $routeDetails = $this->api_model->getRoutes();
        $routeDetail = json_decode($routeDetails);
        $data['routes'] = $routeDetail->data;
        
        $json = $this->api_model->getOfflineDiscountRules();
        $json = json_decode($json);
        $data['discounts'] = $json->data;
                
        $this->load->view('site/config/offline-discount', $data);
    }
    
    function update_offline_discount() {
        $this->is_logged_in();   
        $week = $this->input->post('dayOfWeek');
        $days = '';
        foreach ($week as $wk) {
            $days .= $wk;
        }
        
        $data = array(
            "activeFlag" => 1,
            
            "name" => $this->input->post('name'),  
            "dayOfWeek" => $days,
            "activeFrom" => $this->input->post('activeFrom'),
            "activeTo" => $this->input->post('activeTo'),
            
            "value" => $this->input->post('discountValue'),
            "travelDateFlag" => $this->input->post('dateFlag'),
            "percentageFlag" => $this->input->post('percentageFlag'),
            
            "groupCode" => array(),
            "scheduleCode" => array(),
            "routeCode" => array(), 
            
            "minSeatCount" => $this->input->post('minSeat'),
            "minTicketFare" => (int) $this->input->post('minFare'),    
            "maxDiscountAmount" => (int) $this->input->post('maxDiscountAmount')
        );
        
        if( $this->input->post('group') !='' ) {
           $data['groupCode'] = $this->input->post('group');
        }
        
        if( $this->input->post('scheduleCode') !='' ) {
           $data['scheduleCode'] = $this->input->post('scheduleCode');
        }
        
        if( $this->input->post('routeCode') != '' ) {
           $data['routeCode'] = $this->input->post('routeCode');
        }       
        
        if( $this->input->post('code') !='' ) {
           $data['code'] = $this->input->post('code');
        } 
        
        echo $this->api_model->updateOfflineDiscountRules($data); 
    }
    
    function delete_offline_discount() {
        $this->is_logged_in();   
        $data = $this->input->post('rule'); 
        
        if(!isset($data['groupCode'])) {
           $data['groupCode'] = array();
        }
        
        if(!isset($data['scheduleCode'])) {
           $data['scheduleCode'] = array();
        }
        
        if(!isset($data['routeCode'])) {
           $data['routeCode'] = array();
        }
        
        echo $this->api_model->updateOfflineDiscountRules($data); 
    }
    
    function namespace_privilege(){
        $this->is_logged_in();

        if( $_SERVER['HTTP_HOST'] != 'localhost' && $is_super_ns==1 &&
                ( $this->session->userdata('user_id') != "URF2EJ179" && $this->session->userdata('user_id') != "URF156142"
                && $this->session->userdata('user_id')!="URHCP0493" && $this->session->userdata('user_id')!="URF156253"
                && $this->session->userdata('user_id')!="URF2EJ179" && $this->session->userdata('user_id')!="URF156142"
                && $this->session->userdata('user_id')!="URIBDMK1" && $this->session->userdata('user_id')!="URURHBA01") ) {
            $this->load->view('site/denied', $data);
            return;
        }
        
        
        $namespace = $this->api_model->getNamespace(array('authtoken' => $this->_user_hash));
        $space = json_decode($namespace);
        $data['namespaces'] = $space->data;
        
        $userDetails = $this->api_model->getUser();
        $userDetail = json_decode($userDetails);
        $users = array();
        foreach ($userDetail->data as $user) {
            if($user->activeFlag!=1) continue;
            $t = (!empty($user->group->name)) ? $user->group->name : 'Others'; 
            $users[$t][] = $user; 
        }        
        ksort($users);
                
        $data['users_raw'] = $userDetail->data; 
        $data['users'] = $users;
        
        $this->load->view('site/config/namespace-privilege', $data);
    }
    
    function get_user_namespace_privilege(){
        $this->is_logged_in();
        
        $data = array(
            "userCode" => $this->input->post('code'),
        );

        echo $this->api_model->getUserNamespacePrivilege($data); 
    }
    
    function save_user_namespace_privilege(){
        $this->is_logged_in();
        
        $data = array(
            "userCode" => $this->input->post('code'),
            "namespaceCode" => $this->input->post('namespaceCode'),
            "action" => $this->input->post('action')
        );
        
        echo $this->api_model->saveUserNamespacePrivilege($data); 
    }
    
    function export_user_excel(){
        $this->is_logged_in();
        $userDetails = $this->api_model->getUser();
        $userDetails = json_decode($userDetails);
        
        $this->load->library('excel');
        $this->excel->getProperties()->setCreator("Ezee")
                                    ->setLastModifiedBy("Ezee")
                                    ->setTitle("User List")
                                    ->setSubject("user List")
                                    ->setDescription("user List.")
                                    ->setKeywords("user List")
                                    ->setCategory("BITSUSERS");
        
        $this->excel->setActiveSheetIndex(0);        
        $this->excel->getActiveSheet()->setTitle('UsersDetails');
        
        $this->excel->getActiveSheet()->setCellValue('A1', 'Name');
        $this->excel->getActiveSheet()->setCellValue('B1', 'User Code');
        $this->excel->getActiveSheet()->setCellValue('C1', 'User Name');
        $this->excel->getActiveSheet()->setCellValue('D1', 'Email');
        $this->excel->getActiveSheet()->setCellValue('E1', 'Organization');
        $this->excel->getActiveSheet()->setCellValue('F1', 'Group');
        $this->excel->getActiveSheet()->setCellValue('G1', 'Payment Type');
        $this->excel->getActiveSheet()->setCellValue('H1', 'Mobile Number');
        $this->excel->getActiveSheet()->setCellValue('I1', 'Active');
        $this->excel->getActiveSheet()->getStyle('A1:Z1')->getFont()->setBold(true);
        
        $row=2;
        $col = 0;
        foreach ($userDetails->data as $data) {
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col, $row,  $data->name);
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row,  $data->code);
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row,  $data->username);
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row,  $data->email);
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row,  $data->organization->name);
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row,  $data->group->name);
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row,  $data->paymentType->name);
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row,  $data->mobile);
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row,  $data->activeFlag);
            $row++;
            $col = 0;
        }
        
        $filename = 'Users_List.xls';
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="'.$filename.'"');
        header('Cache-Control: max-age=0');
        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');  
        $objWriter->save('php://output');
    }
    
    function van_routes(){
        $this->is_logged_in();
        
        $namespaceNames = $this->api_model->getNamespaceStation(array('authtoken' => _get_user_hash()));
        $namespaceNames = json_decode($namespaceNames);
        $data['stations'] = $namespaceNames->data;
        
        $routeDetails = $this->api_model->getVanRoutes(array(
            'activeFlagFilter' => -1
        ));
        $routeDetails = json_decode($routeDetails);
        $data['route'] = $routeDetails->data;
        
        $this->load->view('site/config/van-routes', $data);
    }
    
    function update_van_route(){
        $this->is_logged_in();
        
        $data = array(
            'code' => $this->input->post('code'),
            'name' => $this->input->post('name'),
            'activeFlag' => $this->input->post('activeFlag'),
            'station' => array('code' => $this->input->post('stationCode') , 'activeFlag' => 1)
        );
        
        echo $this->api_model->updateVanRoute($data); 
    }
    
    function get_van_route_by_station(){
        $this->is_logged_in();
        
        $data = array(
            'stationCode' => $this->input->post('stationCode')
        );
        
        echo $this->api_model->getVanRouteByStation($data); 
    }
    
    function deregister_pob_device(){
        $this->is_logged_in();
        
        $data = array(
            'tabletCode' => $this->input->post('tabletCode')
        );
        
        echo $this->api_model->deRegisterPobDevice($data); 
    }
    
    function switch_to_user(){
        $this->is_logged_in(); 
        
        $userCode = $this->input->post('userCode');
        if($userCode == '') {
            $userCode = $this->session->userdata('native_user_id');
        }
        $res = $this->api_model->switchToUser(array(
            'userCode' => $userCode
        )); 
        $res = json_decode($res);
        
        if($res->status == 1){
            $product = $this->session->userdata('product');
            $userhash = _get_user_hash();
            $p_key = $userhash.'_privillages_'.$product;
            $this->rediscache->delete($p_key);
            $result =$this->api_model->getAppMenu();
            
            $profile = $this->api_model->getUserProfile(array('authtoken' => $userhash));
            $profile = json_decode($profile);
            
            if($profile->status == 1) {
                $data = array(                
                    'user_hash' => $userhash,
                    'user_id' => $profile->data->code,
                    'user_email' => $profile->data->email,
                    'user_name' => $profile->data->name,
                    'role_name' => $profile->data->role->name,
                    'role_id' => $profile->data->role->code,
                    'namespace_id' => $profile->data->namespace->code,
                    'namespace_name' => $profile->data->namespace->name,
                    'namespace_mode' => $profile->data->namespace->mode,
                    'native_namespace_code' => $profile->data->nativeNamespaceCode,
                    'date_format' => $profile->data->namespace->namespaceProfile->dateFormat,
                    'time_format' => $profile->data->namespace->namespaceProfile->timeFormat,
                    'balance'=> number_format($profile->data->currnetBalance,2),
                    'referrer' => '',   
                    'org_code' => $profile->data->organization->code,
                    'org_name' => $profile->data->organization->name,            
                    'org_station_code' => $profile->data->organization->station->code,
                    'org_station_name' => $profile->data->organization->station->name,
                    'product' => 'bits'
                );
                
                $this->session->set_userdata($data);
                echo json_encode($res);
            } else {
                echo json_encode($profile);
            }            
        } else {
            echo json_encode($res);            
        }       
    }

    public function vehicle_driver() {
        $this->is_logged_in();
        _include_js('assets/js/imagesloaded.pkgd.min.js');
        _include_js('assets/lib/freewall/freewall.js');
        _include_js('assets/lib/magnific-popup/jquery.magnific-popup.min.js');
        _include_js('assets/js/pages/gallery.js');
        _include_js('assets/js/pages/vehicle.js', 'sm_loadstates');

        $driver = $this->api_model->getVehicleDriver(array(
            'activeFlagFilter' => -1
        ));
        $driver = json_decode($driver);
        $data['driver'] = $driver->data;
        
        $contact = $this->api_model->getContact(array('entityTypeCode' => 'TRANS', 'tag' => 'OWN'));
        $contact = json_decode($contact);
        $data['contact'] = $contact->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $result = $this->api_model->cargoTags(array('categoryCode' => 'DRVR'));
        $result = json_decode($result);
        $data['cargotags'] = $result->data;

        $this->load->view('site/config/vehicle-driver', $data);
    }

    public function get_contact(){
        $this->is_logged_in();

        echo $this->api_model->getContact(array(
            'entityTypeCode' => $this->input->post('entityTypeCode')
        ));
    }

    public function get_contact_v2(){
        $this->is_logged_in();

        echo $this->api_model->getContactv2(array(
            'entityTypeCode' => $this->input->post('entityTypeCode'),
            'tag' => $this->input->post('tag')
        ));
    }

    public function update_vehicle_driver() {
        $this->is_logged_in();
        
        echo $this->api_model->updateVehicleDriver(array(
            'code' => $this->input->post('code'),
            'name' => $this->input->post('name'),
            'activeFlag' => $this->input->post('activeFlag'),
            'lastName' => $this->input->post('lastName'),
            'dateOfBirth' => $this->input->post('dateOfBirth'),
            'bloodGroup' => $this->input->post('bloodGroup'),
            'licenseNumber' => $this->input->post('licenseNumber'),
            'licenseExpiryDate' => $this->input->post('licenseExpiryDate'),
            'badgeNumber' => $this->input->post('badgeNumber'),
            'qualification' => $this->input->post('qualification'),
            'mobileNumber' => $this->input->post('mobileNumber')?:'NA',
            'emergencyContactNumber' => $this->input->post('emergencyContactNumber'),
            'employeeCode' => $this->input->post('employeeCode'),
            'joiningDate' => $this->input->post('joiningDate'),
            'remarks' => $this->input->post('remarks'),
            'tag' => $this->input->post('tag') ?: [],
            'ownershipType' => $this->input->post('ownershipType'),
            'transporterContact' => $this->input->post('transporterContact'),
            'aadharNo' => $this->input->post('aadharNo'),
            'email' => $this->input->post('email'),
            'station' => $this->input->post('station'),
            'state' => $this->input->post('state'),
            'pincode' => $this->input->post('pincode'),
            'bankDetails' => $this->input->post('bankDetails') ?: [],
            'address' => $this->input->post('address')
            
        ));
    }

    public function query_window() {
        $this->is_logged_in();
        
        $this->load->view('site/config/query-window');
    }

    public function execute_query() {
        $this->is_logged_in();

        $data = array('query' => $this->input->post('query'));

        $p_key = _get_namespace_id() . '_query_window_' . md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if (!$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->executeDynamicQuery($data);
                $this->rediscache->set($p_key, $result, 900);    //  15 mins
            }
        } else {
            $result = $this->api_model->executeDynamicQuery($data);
            $this->rediscache->set($p_key, $result, 900);    //  15 mins
        }
        $data['result'] = json_decode($result);

        if ($this->input->post('export') == 1) {
            $filename = 'Query-Window';
            $this->load->excel('site/config/query-window-list', $data, $filename);
        } else {
            $this->load->view('site/config/query-window-list', $data);
        }
    }

    public function vehicle_attendant() {
        $this->is_logged_in();
        _include_js('assets/js/imagesloaded.pkgd.min.js');
        _include_js('assets/lib/freewall/freewall.js');
        _include_js('assets/lib/magnific-popup/jquery.magnific-popup.min.js');
        _include_js('assets/js/pages/gallery.js');

        $attendant = $this->api_model->getVehicleAttendant();
        $attendant = json_decode($attendant);
        $data['attendant'] = $attendant->data;

        $this->load->view('site/config/vehicle-attendant', $data);
    }

    public function update_vehicle_attendant() {
        $this->is_logged_in();

        echo $this->api_model->updateVehicleAttendant(array(
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'alternateMobile' => $this->input->post('alternateMobile'),
            'joiningDate' => $this->input->post('joiningDate'),
            'remarks' => $this->input->post('remarks'),
            'address' => $this->input->post('address'),
            'mobile' => $this->input->post('mobile'),
            'name' => $this->input->post('name'),
            'code' => $this->input->post('code') ?: '',
            'age' => $this->input->post('age')
        ));
    }

    public function get_pob_otp() {
        $this->is_logged_in();

        echo $this->api_model->getPobOtp(array(
            'mobileNumber' => $this->input->post('mobileNumber'),
        ));
    }

    public function get_driver_gallery() { 
        $this->is_logged_in();

        $data['driver_code'] = $this->input->post('code');
        $data['driver_name'] = $this->input->post('name');
        $data['image'] = _get_gallery_images('driver', $data['driver_code']);
        
        $this->load->view('site/config/driver-gallery-images', $data);
    }

    public function delete_driver_image() {
        $this->is_logged_in();

        $img_path = $this->input->post('img_path');
        $img_name = $this->input->post('img_name');

        echo _delete_gallery_images($img_path, $img_name);
    }
    
    public function upload_driver_image() {
        $this->is_logged_in();

        echo _upload_gallery_images(array(
            'folder' => 'driver',
            'code' => $this->input->get('code'),
            'name' => $this->input->get('name'),
            'files' => $_FILES
        ));
    }

    function update_van_trip_info(){
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code') ?: '',
            'activeFlag' => $this->input->post('activeFlag'),
            'driver' => $this->input->post('driver'),
            'tripDate' => $this->input->post('tripDate'),
            'mobileNumber' => $this->input->post('mobileNumber'),
            'vanPickup' => $this->input->post('vanPickup'),
            'vehicle' => $this->input->post('vehicle')
        );

        echo $this->api_model->updateVanTripInfo($data);
    }

    function send_vanpickup_sms(){
        $this->is_logged_in();

        $data = array(
            'tripinfocode' => $this->input->post('tripinfocode'),
            'ticketCodes' => $this->input->post('ticketCodes')
        );

        echo $this->api_model->notifyVanTripInfo($data);
    }

    public function get_attender_gallery() {
        $this->is_logged_in();

        $data['attender_code'] = $this->input->post('code');
        $data['attender_name'] = $this->input->post('name');
        $data['image'] = _get_gallery_images('attender', $data['attender_code']);

        $this->load->view('site/config/attender-gallery-images', $data);
    }

    public function delete_attender_image() {
        $this->is_logged_in();

        $img_path = $this->input->post('img_path');
        $img_name = $this->input->post('img_name');

        echo _delete_gallery_images($img_path, $img_name);
    }

    public function upload_attender_image() {
        $this->is_logged_in();

        echo _upload_gallery_images(array(
            'folder' => 'attender',
            'code' => $this->input->get('code'),
            'name' => $this->input->get('name'),
            'files' => $_FILES
        ));
    }
    
    public function fare_rule() {
        $this->is_logged_in();

        if(!has_action_rights('viewFareRule')) {
            $this->load->view('site/denied');
            return;
        }

        $states = $this->api_model->getAllStates();
        $states = json_decode($states);
        $data['states'] = $states->data;

        $p_key = 'all_namespace_all_stations';
        if (!$result = $this->rediscache->get($p_key)) {
            $result = $this->api_model->getAllStation();
            $this->rediscache->set($p_key, $result, 900);    //  15 mins
        }
        $result = json_decode($result);
        $data['stations'] = $result->data;

        $this->load->view('site/config/fare-rule', $data);
    }

    public function update_fare_rule() {
        $this->is_logged_in();

        $data = array(
            'activeFlag' => (int)$this->input->post('activeFlag'),
            'code' => $this->input->post('code') ?: '',
            'name' => $this->input->post('name'),
            'state' => $this->input->post('state')
        );

        echo $this->api_model->updateFareRuleList($data);
    }
    
    function fare_rule_list(){
        $this->is_logged_in();        
        $super_ns = _is_super_namespace( $this->session->userdata('native_namespace_code'));        
        $rulelist = $this->api_model->getFareRuleList(); 
        
        $rulelist = json_decode($rulelist);
        $lists = array();        
        foreach ($rulelist->data as $list) {
            if($list->activeFlag!=1) continue;            
            $lists[] = array(
                'code' => $list->code,
                'name' =>  $list->name
            );            
        }        
        echo json_encode($lists);
    }
    
    function fare_rule_farelist(){
        $this->is_logged_in();
        $data = array(
            'ruleCode' => $this->input->post('rulecode'),
            'fromStationCode' => $this->input->post('fromStationCode') ?: 'NA',
            'toStationCode' => $this->input->post('toStationCode') ?: 'NA',
        );        
        $fares = $this->api_model->getFareRuleFareList($data);
        $fares = json_decode($fares);
        $data['fares'] = $fares->data;

        $stations = $this->api_model->getNamespaceStation();
        $stations = json_decode($stations);
        $data['stations'] = $stations->data;

        $this->load->view('site/config/fare-rule-farelist', $data);
    }

    function update_fare_rule_farelist() {
        $this->is_logged_in();

        echo $this->api_model->updateFareRuleFareList(array(
            'ruleCode' => $this->input->post('fareRuleCode'),
            'fares' => $this->input->post('fares')
        ));
    }

    public function sector() {
        $this->is_logged_in();

        if(!has_action_rights('viewSector')) {
            $this->load->view('site/denied');
            return;
        }
        
        $data = array();

        $result = $this->api_model->getAllSector(array(
            'activeFlagFilter' => -1
        ));
        $result = json_decode($result);
        $data['sector'] = $result->data;

        $schedulesactive = $this->api_model->getScheduleByType(array('type' => 'none'));
        $schedulesactive = json_decode($schedulesactive);
        $data['schedules'] = $schedulesactive->data;

        $vehicle = $this->api_model->getVehicle();
        $vehicle = json_decode($vehicle);
        $data['vehicles'] = $vehicle->data;

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        $station = $this->api_model->getAllNamespaceStation();
        $station = json_decode($station);
        $data['stations'] = $station->data;

        $data['groupusers'] = get_active_group_and_users();
        
        $this->load->view('site/config/sector', $data);
    }

    public function update_sector() {
        $this->is_logged_in();

        echo $this->api_model->updateSector(array(
            'code' => $this->input->post('code') ?: '',
            'name' => $this->input->post('name'),
            'actveFlag' => (int) $this->input->post('actveFlag'),
            'schedule' => $this->input->post('schedule') ?: [],
            'vehicle' => $this->input->post('vehicle') ?: [],
            'station' => $this->input->post('station') ?: [],
            'organization' => $this->input->post('organization') ?: []
        ));
    }

    public function update_sector_schedule() {
        $this->is_logged_in();

        $sectorCode = $this->input->post('sectorCode');
        $actionCode = $this->input->post('actionCode');
        $schedule = $this->input->post('schedule');

        foreach ($schedule as $sc) {
            $sch = $this->api_model->updateSectorSchedule(array(
                'sectorCode' => $sectorCode,
                'scheduleCode' => $sc,
                'actionCode' => $actionCode
            ));
            $sch = json_decode($sch);

            if($sch->status == 0){
                echo json_encode($sch);
                break;
            }
        }
        echo $this->api_model->getSectorByCode(array(
            'sectorCode' => $sectorCode,
        ));
    }

    public function update_sector_vehicle() {
        $this->is_logged_in();

        $sectorCode = $this->input->post('sectorCode');
        $actionCode = $this->input->post('actionCode');
        $vehicle = $this->input->post('vehicle');

        foreach ($vehicle as $vc) {
            $veh = $this->api_model->updateSectorVehicle(array(
                'sectorCode' => $sectorCode,
                'vehicleCode' => $vc,
                'actionCode' => $actionCode
            ));
            $veh = json_decode($veh);

            if($veh->status == 0){
                echo json_encode($veh);
                break;
            }
        }
        echo $this->api_model->getSectorByCode(array(
            'sectorCode' => $sectorCode,
        ));
    }

    public function update_sector_organization() {
        $this->is_logged_in();

        $sectorCode = $this->input->post('sectorCode');
        $actionCode = $this->input->post('actionCode');
        $organization = $this->input->post('organization');

        foreach ($organization as $oc) {
            $org = $this->api_model->updateSectorOrganization(array(
                'sectorCode' => $sectorCode,
                'organizationCode' => $oc,
                'actionCode' => $actionCode
            ));
            $org = json_decode($org);

            if($org->status == 0){
                echo json_encode($org);
                break;
            }
        }
        echo $this->api_model->getSectorByCode(array(
            'sectorCode' => $sectorCode,
        ));
    }

    public function update_sector_station() {
        $this->is_logged_in();

        $sectorCode = $this->input->post('sectorCode');
        $actionCode = $this->input->post('actionCode');
        $station = $this->input->post('station');

        foreach ($station as $sc) {
            $stn = $this->api_model->updateSectorstation(array(
                'sectorCode' => $sectorCode,
                'stationCode' => $sc,
                'actionCode' => $actionCode
            ));
            $stn = json_decode($stn);

            if($stn >status == 0){
                echo json_encode($stn);
                break;
            }
        }
        echo $this->api_model->getSectorByCode(array(
            'sectorCode' => $sectorCode,
        ));
    }

    function get_map_sector_user() {
        $this->is_logged_in();

        echo $this->api_model->getMapSectorUser(array(
            'sectorCode' => $this->input->post('sectorCode')
        ));
    }

    function map_sector_user() {
        $this->is_logged_in();

        echo $this->api_model->mapSectorUser(array(
            'userCode' => $this->input->post('userCode'),
            'sectorCode' => $this->input->post('sectorCode'),
            'actionCode' => $this->input->post('actionCode'),
        ));
    }
    
    function get_banners() {
        $this->is_logged_in();

        _include_js('assets/js/imagesloaded.pkgd.min.js');
        _include_js('assets/lib/freewall/freewall.js');
        _include_js('assets/lib/magnific-popup/jquery.magnific-popup.min.js');
        _include_js('assets/js/pages/gallery.js');

        $banner = $this->api_model->getAllBanner(array(
            'activeFlagFilter' => -1
        ));
        $banner = json_decode($banner);

        usort($banner->data, function($a, $b) {
            return strtotime($b->updatedAt) < strtotime($a->updatedAt) ? -1 : 1;
        });
        $data['banner'] = $banner->data;
        
        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $GroupDetail = $GroupDetail->data;
        $data['user_group'] = $GroupDetail;
        
        $this->load->view('site/admin/allbanner', $data);
    }

    function update_banner() {
        $this->is_logged_in();

        $data = array(
            "activeFlag" => (int)$this->input->post('activeFlag'),
            "code" => $this->input->post('code')?: '',
            "name" => $this->input->post('name'),
            "fromDate" => $this->input->post('fromDate'),
            "toDate" => $this->input->post('toDate'),
            "group" => $this->input->post('group')?:[],
            "deviceMedium" => $this->input->post('deviceMedium')?:[],
            'displayModel' => $this->input->post('displayModel'),
            'dayOfWeek' => $this->input->post('dayOfWeek'),
            'color' => $this->input->post('color'),
        );
        
         $banner =  $this->api_model->updateBanner($data);
         $banner = json_decode($banner);

         if ($banner->status != 1) {
             echo json_encode($banner);
             return;
         }

         $bannerDetails = $this->input->post('bannerDetails');

         if (!$bannerDetails) {
            echo json_encode($banner);
            return;

         }

         $data = array(
            'code' => $banner->data->code,
            'bannerDetails' => array((object) $bannerDetails)
        );
        $bannerDetail =  $this->api_model->updateBannerDetails($data);
        $bannerDetail = json_decode($bannerDetail);

        $bannerDetail->data = $banner->data;

        echo json_encode($bannerDetail);
    }

    function generate_pob_exchange_token() {
        $this->is_logged_in();
        $conf_product_urls = config_item('product_domain');
        $data = array(
            'authToken' => _get_user_hash(),
            //'deviceCode' => $this->input->post('deviceCode'),
            //'mobileNumber' => $this->input->post('mobileNumber'),
            'nsCode' => _get_namespace_id(),
            'zoneCode' => config_item('zone'),
            'busbuddyApiUrl' => $conf_product_urls['busbuddy'],
        );

        $this->load->model('shorturl_model');
        echo $this->shorturl_model->shorten(array(
            'data' => json_encode($data),
            'type' => 'MXD'        // otp
        ));
    }

    public function update_banner_details() { 
        $this->is_logged_in();
        
        $this->load->library('thumbnail');
        $messageType = $this->input->get('messageType');
        
        if ($messageType['code'] != 'TEXT') {
            $img_name = $_FILES['file']['name'];
            if(!$img_name) {
                echo json_encode(array('status' => 0));
            }
            list($usec, $sec) = explode(" ", microtime());
            $output = $usec;
            $int = number_format($output, 4, "", ".");
            $to_folder = 'uploads/banner-images/' . $this->session->userdata('namespace_id') . '/'.date('Y/m/d').'/';
            if (!is_dir($to_folder)) {
                @mkdir($to_folder, 0777, true);
                @chmod($to_folder, 0777);
            }
            $extn = pathinfo($img_name, PATHINFO_EXTENSION);
    
            if ($messageType['code'] == 'IMAGE' && $extn != 'svg') {
                $file_name = 'image-banner' . $int . '.' . $extn;
                $to_name = $to_folder . $file_name;
                $db_name = $to_folder.'[##]-banner' . $int . '.' . $extn;
    
                if (move_uploaded_file($_FILES['file']['tmp_name'], $to_name)) {
        
                    $filenames = $to_name;
                    $newfilename = 'uploads/banner-images/' . $this->session->userdata('namespace_id') . '/'.date('Y/m/d').'/thumb-banner' . $int . '.' . $extn;
                    
                    $this->thumbnail->init($filenames, 200, 200, 0, 100);
                    $this->thumbnail->save($newfilename);
        
                    $this->thumbnail->init($filenames, 800, 800, 0, 100);
                    $this->thumbnail->save($to_name);
                    
                    @chmod($to_folder, 0777);
                    @chmod($to_name, 0777);
                }
            } else {
                $file_name = 'audio-banner' . $int . '.' . $extn;
                $db_name = $to_folder . $file_name;
                move_uploaded_file($_FILES['file']['tmp_name'], $db_name);
            }
            $banner_img_domain = config_item('banner_img_domain')!="" ? config_item('banner_img_domain') : base_url();
        }

        $data = array(
            'code' => $this->input->get('code'),
            'bannerDetails' => array((object)array(
                'code' => $this->input->get('bannerDetailscode'),
                'activeFlag' => 1,
                'url' => $banner_img_domain.$db_name,
                'redirectUrl' => $this->input->get('redirectUrl'),
                'alternateText' => $this->input->get('alternateText'),
                'sequence' => $this->input->get('sequence'),
                'messageType' => $messageType,
            ))
        );
        echo $this->api_model->updateBannerDetails($data);
    }

    public function delete_banner_details() {
        $this->is_logged_in();

        $banners = $this->input->post('bannerDetails');

        $data = $this->api_model->updateBannerDetails(array(
            'code' => $this->input->post('code'),
            'bannerDetails' => $banners ?: [],
            'messageType' => (object)[]
        ));
        $data = json_decode($data);

        if($data->status == 1) {
            foreach($banners as $banner) {
                $url = str_replace(base_url(), '', $banner['url']);
                unlink($url);
                unlink(str_replace('[##]', 'thumb', $url));
                unlink(str_replace('[##]', 'image', $url));
            }
        }
        echo json_encode($data);
    }
    
    function schedule_tags() {
        $this->is_logged_in();

        $tags = $this->api_model->getScheduleTags();
        $tags = json_decode($tags);
        $data['tags'] = $tags->data;
        
        
        $this->load->view('site/config/schedule-tags', $data);
    }
    
    function update_schedule_tags(){
        $this->is_logged_in();
        
        $data = array(
                'code' => $this->input->post('code')?: '',
                'name' => $this->input->post('name'),
                'activeFlag' => $this->input->post('activeFlag'),
            );
        echo $this->api_model->updateScheduleTags($data);
    }
    
    function mobile_block() {
        $this->is_logged_in();

        $blocks = $this->api_model->getMobileBlock();
        $blocks = json_decode($blocks);
        $data['blocks'] = $blocks->data;
        
        $this->load->view('site/config/mobile-block', $data);
    }
    
    function update_mobile_block(){
        $this->is_logged_in();
        
        echo $this->api_model->updateMobileBlock(array(
            'mobile' => $this->input->post('mobile'),
            'remarks' => $this->input->post('remarks')?: '',
            'activeFlag' => $this->input->post('activeFlag'),
        ));
    }
    
    function import_bits_vehicles() {
        $this->is_logged_in();

        echo $this->api_model->integrationVehicles(array(
            'typeCode' => 'BITS'
        ));
    }

    function save_bits_vehicles() {
        $this->is_logged_in();

        $vehicles = $this->input->post('vehicleList');
        
        foreach ($vehicles as $vehicle) {
            $res = $this->api_model->updateVehicle(array(
                'code' => '',
                'name' => $vehicle['name'],
                'activeFlag' => $vehicle['activeFlag'],
                'registrationDate' => $vehicle['registrationDate'],
                'registationNumber' => $vehicle['registationNumber'],
                'licNumber' => $vehicle['licNumber'],
                'gpsDeviceCode' => $vehicle['gpsDeviceCode'],
                'mobileNumber' => $vehicle['mobileNumber'],
                "gpsDeviceVendor" => array('code' => $vehicle['gpsDeviceVendor']['code']),
                "vehicleType" => array('code' => $vehicle['vehicleType']['code']),
            ));
            $res = json_decode($res);
            if($res->status == 0) {
                $res->requestData = $vehicle;
                exit(json_encode($res));
            }
        }

        echo json_encode(array('status' => 1));
    }

    function import_bits_drivers() {
        $this->is_logged_in();
        
        echo $this->api_model->integrationDrivers(array(
            'typeCode' => 'BITS'
        ));
    }

    function save_bits_drivers() {
        $this->is_logged_in();

        $drivers = $this->input->post('driverList');

        foreach ($drivers as $driver) {
            $res = $this->api_model->updateVehicleDriver(array(
                'code' => '',
                'name' => $driver['name'],
                'activeFlag' => $driver['activeFlag'],
                'lastName' => $driver['lastName'],
                'dateOfBirth' => $driver['dateOfBirth'],
                'bloodGroup' => $driver['bloodGroup'],
                'licenseNumber' => $driver['licenseNumber'],
                'badgeNumber' => $driver['badgeNumber'],
                'licenseExpiryDate' => $driver['licenseExpiryDate'],
                'qualification' => $driver['qualification'],
                'employeeCode' => $driver['employeeCode'],
                'mobileNumber' => $driver['mobileNumber'],
                'emergencyContactNumber' => $driver['emergencyContactNumber'],
                'joiningDate' => $driver['joiningDate'],
                'remarks' => $driver['remarks'],
            ));
            $res = json_decode($res);

            if($res->status == 0) {
                $res->requestData = $driver;
                exit(json_encode($res));
            }
        }

        echo json_encode(array('status' => 1));
    }

    function import_bits_attendants() {
        $this->is_logged_in();
        
        echo $this->api_model->integrationAttendants(array(
            'typeCode' => 'BITS'
        ));
    }

    function save_bits_attendants() {
        $this->is_logged_in();

        $attendants = $this->input->post('attendantList');

        foreach ($attendants as $attendant) {
            $res = $this->api_model->updateVehicleAttendant(array(
                'code' => '',
                'name' => $attendant['name'],
                'activeFlag' => $attendant['activeFlag'],
                'age' => $attendant['age'],
                'mobile' => $attendant['mobile'],
                'alternateMobile' => $attendant['alternateMobile'],
                'joiningDate' => $attendant['joiningDate'],
                'address' => $attendant['address'],
                'remarks' => $attendant['remarks'],
            ));
            $res = json_decode($res);

            if($res->status == 0) {
                $res->requestData = $attendant;
                exit(json_encode($res));
            }
        }

        echo json_encode(array('status' => 1));
    }

    function cargo_tags() {
        $this->is_logged_in();
        $data = array();

        $result = $this->api_model->cargoTags(array(
            'activeFlagFilter' => -1
        ));
        $result = json_decode($result);
        $data['cargotags'] = $result->data;

        $this->load->view('site/cargo/cargo-tags', $data);

    }

    function update_cargo_tags() {
        $this->is_logged_in();

        echo $this->api_model->updateCargoTags(array(
            'code' => $this->input->post('code'),
            'name' => $this->input->post('name'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'category' => $this->input->post('category')
        ));
    }
    
    function vendor() {
        $this->is_logged_in();
        $vendors = $this->api_model->getCashbookVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $this->load->view('site/config/vendor', $data);
    }

    function update_vendor() {
        $this->is_logged_in();

        $code = $this->input->post('code');

        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'mobileNumber' => $this->input->post('mobileNumber'),
            'email' => $this->input->post('email'),
            'address' => $this->input->post('address'),
        );
        if (!empty($code)) {
            $data['code'] = $code;
        }
        echo $this->api_model->updateCashbookVendor($data);
    }

    function get_transit_list() {
        $this->is_logged_in();

        $param = array(
            'fromDate' => $this->input->post('travel_date'),
            'toDate' => $this->input->post('travel_date'),
            'vehicleCode' => 'NA',
            'transitCode' => 'NA',
            'aliasCode' => 'NA',
            'organizationCode' => 'NA',
            'activityType' => 'LOAD',
            'transitType' => 'TRNT'
        );
        if (!has_action_rights('OGPL-ALL-BRCH')) {
            $param['organizationCode'] = $this->session->userdata('org_code');
        }
        echo $this->api_model->cargoGetOGPLListv2($param);

    }

    public function reset_vehicle_transit_station() {
        $this->is_logged_in();
        $data = array(
            'vehicleCode' => $this->input->post('vehicleCode'),
            'stationCode' => $this->input->post('stationCode'),
            'organizationCode' => $this->input->post('organizationCode')
        );
        echo $this->api_model->resetVehicleTransitStation($data);
    }

    public function store_upload_files() {
        $this->is_logged_in();

        $imageCategoryCode = $this->input->post('imageCategoryCode');

        if ($imageCategoryCode == 'LRPROOF' || $imageCategoryCode == 'PODDELIVERY') {
            $folder = 'proof';
            $lrcode = $this->input->post('cargoCode');
            $documentCategory = $this->input->post('documentCategory');
            $location = date('Y/m/d');

            $to_folder = "{$folder}/{$location}/{$lrcode}/{$documentCategory['code']}";
            $file_name = uniqid();
        }

        $img_name = $_FILES['file']['name'];
        if (!$img_name) {
            echo json_encode(array('status' => 0));
            return;
        }

        $basepath = FCPATH . '/uploads/';
        $to_folder_path = $basepath . strtolower($to_folder);
        if (!is_dir($to_folder_path)) {
            @mkdir($to_folder_path, 0777, true);
            @chmod($to_folder_path, 0777);
        }

        $extn = pathinfo($img_name, PATHINFO_EXTENSION);
        $to_path = strtolower("{$to_folder}/{$file_name}.{$extn}");
        $full_path = "{$basepath}/{$to_path}";

        if (move_uploaded_file($_FILES['file']['tmp_name'], $full_path)) {
            @chmod($to_folder_path, 0777);
            @chmod($full_path, 0777);

            echo json_encode(array(
                'status' => 1,
                'data' => array(
                    'slug' => $to_path
                )
            ));
        } else {
            echo json_encode(array('status' => 0));
        }
    }

    public function store_webcam_files() {
        $this->is_logged_in();

        $data = json_decode($this->input->post('data'));
        if ($data->imageCategoryCode == 'LRPROOF' || $data->imageCategoryCode == 'PODDELIVERY') {
            $folder = 'proof';
            $lrcode = $data->cargoCode;
            $documentCategory = $data->documentCategory;
            $location = date('Y/m/d');

            $to_folder = "{$folder}/{$location}/{$lrcode}/{$documentCategory->code}/webcam";
            $file_name = uniqid();
        }

        $img_name = $_FILES['file']['name'];
        if (!$img_name) {
            echo json_encode(array('status' => 0));
            return;
        }

        $basepath = FCPATH . '/uploads/';
        $to_folder_path = $basepath . strtolower($to_folder);
        if (!is_dir($to_folder_path)) {
            @mkdir($to_folder_path, 0777, true);
            @chmod($to_folder_path, 0777);
        }

        $extn = pathinfo($img_name, PATHINFO_EXTENSION);
        $to_path = strtolower("{$to_folder}/{$file_name}.{$extn}");
        $full_path = "{$basepath}/{$to_path}";

        if (move_uploaded_file($_FILES['file']['tmp_name'], $full_path)) {
            @chmod($to_folder_path, 0777);
            @chmod($full_path, 0777);

            // echo json_encode(array(
            //     'status' => 1,
            //     'data' => array(
            //         'slug' => $to_path,
            //         'cargoCode' => $data->cargoCode,
            //         'imageCategoryCode' => $data->imageCategoryCode,
            //         'documentCategory' => $data->documentCategory,
            //         'documentType' => $data->documentType,
            //         'documentNumber' => $data->documentNumber,
            //     )
            // ));
            $this->save_webcam_image_details($data->imageCategoryCode, $data->cargoCode, $data->documentCategory, $data->documentType, $data->documentNumber);
        } else {
            echo json_encode(array('status' => 0));
        }
    }
    
    public function save_image_details() {
        $this->is_logged_in();

        $imageCategoryCode = $this->input->post('imageCategoryCode');

        if ($imageCategoryCode == 'LRPROOF') {
            echo $this->api_model->saveCargoDocument(array(
                'cargoCode' => $this->input->post('cargoCode'),
                'imageDetails' => [
                    array(
                        'documentCategory' => $this->input->post('documentCategory'),
                        'documentType' => $this->input->post('documentType'),
                        'documentNumber' => $this->input->post('documentNumber'),
                        'mobileNumber' => $this->input->post('mobileNumber')?:'NA'
                    )
                ]
            ));
            return;
        }

        echo json_encode(array('status' => 0));
    }

    public function save_webcam_image_details($imageCategoryCode, $cargoCode, $documentCategory, $documentType, $documentNumber) {
        $this->is_logged_in();

        $imageCategoryCode = $imageCategoryCode;
        if ($imageCategoryCode == 'LRPROOF' || $imageCategoryCode == 'PODDELIVERY') {
            echo $this->api_model->saveCargoDocument(array(
                'cargoCode' => $cargoCode,
                'imageDetails' => [
                    array(
                        'documentCategory' => $documentCategory,
                        'documentType' => $documentType,
                        'documentNumber' => $documentNumber,
                        'mobileNumber' => $mobileNumber
                    )
                ]
            ));
            return;
        }

        echo json_encode(array('status' => 0));
    }
    
    public function get_image_details() {
        $this->is_logged_in();

        $imageCategoryCode = $this->input->post('imageCategoryCode');

        if ($imageCategoryCode == 'LRPROOF') {

            $details = $this->api_model->getCargoDocument(array(
                'cargoCode' => $this->input->post('cargoCode')
            ));
            $details = json_decode($details);

            if ($details->status != 1) {
                echo json_encode($details);
                return;
            }
            
            $basepath = FCPATH;
            $folder = '/uploads/proof';
            $lrcode = $this->input->post('cargoCode');

            foreach ($details->data as $detail) {
                $documentCategory = $detail->documentCategory->code;
                $location = date('Y/m/d', strtotime($detail->createdAt));

                $to_path = strtolower("/{$folder}/{$location}/{$lrcode}/{$documentCategory}/");
                $full_path = $basepath . $to_path;

                $files = [];
                if (is_dir($full_path)){
                    if ($dh = opendir($full_path)){
                      while (($file = readdir($dh)) !== false){
                        if (is_file($full_path . $file)) {
                            $files[] = array(
                                'filename' => $file,
                                'filetype' => mime_content_type($full_path . $file),
                                'imageUrlSlug' => trim($to_path . $file, ' /'),
                            );
                        }
                      }
                      closedir($dh);
                    }
                }
                $detail->files = $files;
            }

            echo json_encode(array(
                'status' => 1,
                'data' => $details->data
            ));
            return;
        }

        echo json_encode(array('status' => 0));
    }

    public function get_webcam_uploaded_files() {
        $this->is_logged_in();

        $imageCategoryCode = $this->input->post('imageCategoryCode');

        if ($imageCategoryCode == 'LRPROOF' || $imageCategoryCode == 'PODDELIVERY') {

            $details = $this->api_model->getCargoDocument(array(
                'cargoCode' => $this->input->post('cargoCode')
            ));
            $details = json_decode($details);

            if ($details->status != 1) {
                echo json_encode($details);
                return;
            }
            
            $basepath = FCPATH;
            $folder = '/uploads/proof';
            $lrcode = $this->input->post('cargoCode');

            foreach ($details->data as $detail) {
                $documentCategory = $detail->documentCategory->code;
                $location = date('Y/m/d', strtotime($detail->createdAt));

                $to_path = strtolower("/{$folder}/{$location}/{$lrcode}/{$documentCategory}/webcam/");
                $full_path = $basepath . $to_path;

                $files = [];
                if (is_dir($full_path)){
                    if ($dh = opendir($full_path)){
                      while (($file = readdir($dh)) !== false){
                        if (is_file($full_path . $file)) {
                            $files[] = array(
                                'filename' => $file,
                                'filetype' => mime_content_type($full_path . $file),
                                'imageUrlSlug' => trim($to_path . $file, ' /'),
                            );
                        }
                      }
                      closedir($dh);
                    }
                }
                $detail->files = $files;
            }

            echo json_encode(array(
                'status' => 1,
                'data' => $details->data
            ));
            return;
        }

        echo json_encode(array('status' => 0));
    }

    public function vehicle_tariff() {
        $this->is_logged_in();
        
        $vehicletariff = $this->api_model->getVehicleTariff();
        $vehicletariff = json_decode($vehicletariff);
        $data['vehicletariff'] = $vehicletariff->data;

        $vehicle = $this->api_model->getAllVehicle();
        $vehicle = json_decode($vehicle);
        $data['vehicle'] = $vehicle->data;

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        $data['cargo_setting'] = _get_cargo_settings();

        $this->load->view('site/config/vehicle-tariff', $data);
    }

    public function get_vehicle_tariff() {
        $this->is_logged_in();
        $data['tariffType'] = $this->input->post('tariffType');

        $vehicletariff = $this->api_model->getVehicleTariff();
        $vehicletariff = json_decode($vehicletariff);
        $data['vehicletariff'] = $vehicletariff->data;
        $data['cargo_setting'] = _get_cargo_settings();

        $this->load->view('site/config/vehicle-tariff-list', $data);
    }

    function update_vehicle_tariff() {
        $this->is_logged_in();

        echo $this->api_model->updateVehicleTariff(array(
            'code' => $this->input->post('code'),
            'name' => $this->input->post('name'),
            'activeFlag' => $this->input->post('activeFlag'),
            'tariffType' => $this->input->post('tariffType'),
            'ownershipType' => $this->input->post('ownershipType'),
            'vehicles' => $this->input->post('vehicles') ?: [],
            'tariffDetails' => $this->input->post('tariffDetails') ?: []
        ));
    }

    public function quick_add_vehicle() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('name') ?: '',
            'registationNumber' => $this->input->post('registationNumber'),
            'registrationDate' => $this->input->post('registrationDate') ?: date('Y-m-d'),
            'gpsDeviceCode' => $this->input->post('gpsDeviceCode') ?: 'NO',
            'gpsDeviceVendor' => $this->input->post('gpsDeviceVendor') ?: new stdClass,
            'licNumber' => $this->input->post('licNumber'),
            'vehicleType' => $this->input->post('vehicleType') ?: new stdClass,
            'tag' => $this->input->post('tag') ?: [],
            'transporterContact' => $this->input->post('transporterContact') ?: new stdClass,
            // 'vehicleStatus' => $this->input->post('vehicleStatus'),
            // 'aadharNo' => $this->input->post('aadharNo'),
            'ownershipType' => $this->input->post('ownershipType') ?: new stdClass,
            'state' => $this->input->post('state') ?: new stdClass,
            'purchaseDate' => $this->input->post('purchaseDate') ?: '',
            'lastFcDate' => $this->input->post('lastFcDate') ?: '',
            'makeType' => $this->input->post('makeType') ?: '',
            'modelType' => $this->input->post('modelType') ?: '',
            'fuelType' => $this->input->post('fuelType') ?: null,
            'averageMileage' => (float)$this->input->post('averageMileage'),
            'dimensions' => $this->input->post('dimensions') ?: '',
            'fuelTankCapacity' => (float)$this->input->post('fuelTankCapacity'),
            'oilCapacity' => (float)$this->input->post('oilCapacity'),
            'adblueCapacity' => (float)$this->input->post('adblueCapacity'),
            'loadCapacity' => (float)$this->input->post('loadCapacity'),
            'loadMeasurement' => $this->input->post('loadMeasurement') ?: null
        );
        
        echo $this->api_model->updateVehicle($data);
    }

    public function branch_booking_control() {
        $this->is_logged_in();
        
        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branchRoutes'] = $branches->data;

        $result = $this->api_model->getBranchBookingControl();
        $result = json_decode($result);
        $data['result'] = $result->data;

        $this->load->view('site/config/branch-booking-control', $data);
    }

    function update_branch_booking_control() {
        $this->is_logged_in();
        
        echo $this->api_model->updateBranchBookingControl(array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'startDate' => date('Y-m-d', strtotime($this->input->post('startDate'))),
            'dayOfWeek' => $this->input->post('dayOfWeek'),
            'fromOrganization' => $this->input->post('fromOrganization'),
            'toOrganizations' => $this->input->post('toOrganizations') ?: []
        ));
    }

    public function save_user_payment_type() {
        $data = array(
            'code' => $this->input->post('userCode'),
            'bookingPaymentType' => $this->input->post('bookingPaymentType') ?: []
        );
        
        //  reset user cache.
        $this->api_model->resetUserCache();
        
        echo $this->api_model->updateUserPaymentType($data);
    }

    public function vehicle_reset(){
        $this->is_logged_in();
        $data['vehicleCode'] =$this->input->post('vehicleCode');
        $result =$this->api_model->resetVehicle($data['vehicleCode']);
        $results =json_encode($result);
        echo json_decode($results);
    }
}

?>
