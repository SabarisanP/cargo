
<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class search extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
        $this->_user_hash = _get_user_hash();
    }

    public function index() {
        $this->is_logged_in();
        $this->search();
    }

    function search() {
        $this->is_logged_in();
        _include_js('assets/js/pages/router.js');
        _include_js('assets/js/pages/schedules-bus.js');
        _include_js('assets/js/pages/search.js', 'init_search_page');

        $data = array();

        /*
         * $stations = $this->api_model->getNamespaceStation(array('authtoken' => $this->_user_hash));
         * $stations = json_decode($stations);
         * $data['stations'] = $stations->data;
         */

        $routeDetails = $this->api_model->getCommerceRoute(array(
            'authtoken' => $this->_user_hash
        ));
        $routeDetail = json_decode($routeDetails);
        $data ['route'] = $routeDetail->data;

        $stationDetails = $this->api_model->getCommerceStation(array(
            'authtoken' => $this->_user_hash
        ));
        $stationDetails = json_decode($stationDetails);
        $stationDetails = $stationDetails->data;
        $snames = array();
        $stations = array();
        foreach ($stationDetails as $station) {
            array_push($snames, trim($station->name));
            $stations [] = array(
                'name' => $station->name,
                'code' => $station->code
            );
        }

        @array_multisort($snames, SORT_ASC, $stations);
        $data ['stations'] = $stations;

        $a_stations = array();
        foreach ($stationDetails as $station) {
            $a_stations [$station->code] = $station->name;
        }

        $a_routes = array();
        // if(is_array($routes->data)) {
        foreach ($routeDetail->data as $fromcode => $tocodes) {
            foreach ($tocodes as $tocode) {
                $a_routes [$fromcode] [] = array(
                    'code' => $tocode,
                    'name' => $a_stations [$tocode]
                );
            }
        }
        // }
        
        $data['groupusers'] = get_active_group_and_users();
        
        $data ['route'] = $a_routes;
        $this->load->view('site/search/search', $data);
    }
    
    function minimized() {
        $this->is_logged_in();
        _include_js('assets/js/pages/router.js');
        _include_js('assets/js/pages/livetrack.js');
        _include_js('assets/js/pages/schedules-bus.js');
        _include_js('assets/js/pages/search_v2.js', 'init_search_page');

        $data = array();

        /*
         * $stations = $this->api_model->getNamespaceStation(array('authtoken' => $this->_user_hash));
         * $stations = json_decode($stations);
         * $data['stations'] = $stations->data;
         */
        
        $routeDetails = $this->api_model->getCommerceRoute(array(
            'authtoken' => $this->_user_hash
        ));
        $routeDetail = json_decode($routeDetails);
        $data ['route'] = $routeDetail->data;

        $stationDetails = $this->api_model->getCommerceStation(array(
            'authtoken' => $this->_user_hash
        ));
        $stationDetails = json_decode($stationDetails);
        $stationDetails = $stationDetails->data;
        $snames = array();
        $stations = array();
        foreach ($stationDetails as $station) {
            array_push($snames, trim($station->name));
            $stations [] = array(
                'name' => $station->name,
                'code' => $station->code
            );
        }

        @array_multisort($snames, SORT_ASC, $stations);
        $data ['stations'] = $stations;

        $a_stations = array();
        foreach ($stationDetails as $station) {
            $a_stations [$station->code] = $station->name;
        }

        $a_routes = array();
        // if(is_array($routes->data)) {
        foreach ($routeDetail->data as $fromcode => $tocodes) {
            foreach ($tocodes as $tocode) {
                $a_routes [$fromcode] [] = array(
                    'code' => $tocode,
                    'name' => $a_stations [$tocode]
                );
            }
        }
        // }
        $phonebook_label = 'Phone booking';
        if($this->session->userdata('namespace_id') == "thangamtravels") {
            $phonebook_label = 'Not Paid Ticket';
        }
        $data['groupusers'] = get_active_group_and_users();
        $data['offlineusers'] = _get_offline_users();
        $data['phonebook_label'] = $phonebook_label;
        
        
        $data['pb_release'] = $this->config->item('pb_release');
        
        $data ['route'] = $a_routes;
        $this->load->view('site/search/search_v2', $data);
    }

    function get_bus_details() {
        $this->is_logged_in();
        $fromStation = $this->input->post('fromStation');
        $toStation = $this->input->post('toStation');
        $sdate = $this->input->post('sdate');
        $tdate = $this->input->post('tdate');
        $param = array(
            'fromCode' => $fromStation,
            'toCode' => $toStation,
            'tripDate' => $sdate
        );

//        $bus_category = $this->api_model->getBusCategory();
//        $bus_category = json_decode($bus_category);
//
//        $temp = array();
//        $data = array();
//        foreach ($bus_category->data as $buscat) {
//            $tmp = array();
//            foreach ($buscat->categoryList as $sub) {
//
//                $tmp [$sub->code] = $sub->name;
//            }
//            $temp [preg_replace('/\s+/', '', $buscat->code)] = $tmp;
//        }

        // trip (driver, vehicle, gps) info          
        $d_start = new DateTime(date('Y-m-d')); 
        $d_end   = new DateTime($sdate); 
        $diff = $d_start->diff($d_end); 
        $days = $diff->format('%d'); 
        
        $tripinfo = array();        
        if($days<=1) {  // current day or 1 day difference.
            
            $tinfo = $this->api_model->getAllTripInfo($param);
            
            $tinfo = json_decode($tinfo);
            $tripinfo = array();
            foreach($tinfo->data as $trip) {
                $deviceCode = '';
                if($trip->busVehicle->gpsDeviceVendor->code=='EZEEGPS') {
                    $deviceCode = $trip->busVehicle->gpsDeviceCode;
                }
                $tripinfo[$trip->trip->tripCode] = array(
                    'driverName' => $trip->driverName,
                    'driverMobile' => $trip->driverMobile,
                    'registrationNumber' => $trip->busVehicle->registationNumber,
                    'gpsDeviceCode' => $deviceCode
                );
            }
        }
        
        $busDetails = $this->api_model->getSearchBus($param);
        $busDetails = json_decode($busDetails);        
        $busDetails = $busDetails->data;
        $btemp = "";
        foreach ($busDetails as $key => $bsl) {
            /*
             * $fare = '';
             * foreach($bsl->stageFare AS $fre){
             * if($fare!='') $fare .=',';
             * $fare .= $fre->fare;
             * }
             */
            $timeCrossed = 0;
            if( strtotime($bsl->fromStation->dateTime) < strtotime('now') ) {
                $timeCrossed = 1;
            }
            
            $name = '';
            if ($bsl->bus->displayName != '') {
                $name = $bsl->bus->displayName;
            } else if ($bsl->bus->name != '') {
                $name = $bsl->bus->name;
            }
            
            $ti = $tripinfo[$bsl->tripCode];
            if($tripinfo[$bsl->tripCode]=="") {
                $ti = array(
                    'driverName' => '',
                    'driverMobile' => '',
                    'registrationNumber' => '',
                    'gpsDeviceCode' => ''
                );
            }
            
            $cat = explode('|',$bsl->bus->categoryCode);
            
            $btemp[] = array(
                'scheduleCode' => $bsl->schedule->code,
                'tripStageCode' => $bsl->tripStageCode,
                'serviceNumber' => $bsl->schedule->serviceNumber,
                'tripCode' => $bsl->tripCode,
                'travelDate' => $sdate,
                'tripStatus' => $bsl->tripStatus->name,
                'travelTime' => $bsl->travelTime,
                'viaStations' => $bsl->viaStations,
                'tripTimeCrossed' => $timeCrossed,
                'tripStatusCode' => $bsl->tripStatus->code, // TPO, TPC, TPY
                'busName' => $name,
                'busCategory' => bus_category_string($bsl->bus->categoryCode),
                'busClimate' => $cat[1],
                'fromStation' => $bsl->fromStation,
                'toStation' => $bsl->toStation,
                'availableSeatCount' => $bsl->stageFare [0]->availableSeatCount,
                'fare' => $bsl->stageFare,
                'amenities' => $bsl->amenities,
                'discount' => $bsl->stageFare [0]->discountFare,
                'tripInfo' => $ti
            );
        }
        $data ['data'] = $btemp;
//        $profile = $this->api_model->getProfile(array(
//            'authtoken' => $this->_user_hash
//        ));
//        $pro = json_decode($profile);
        $data ['dropFlag'] = 1;
        $data ['session_email'] = $this->session->userdata('user_email');

        echo json_encode($data);
    }

    function get_busmap() {
        $this->is_logged_in();
        $stageCode = $this->input->post('stageCode');

        $busMap = $this->api_model->getScheduleBusMap(array(
            'stageCode' => $stageCode
        ));
        $busMap = json_decode($busMap);
        if ($busMap->status == 0) {
            $data = array(
                'status' => 0
            );
            echo json_encode($data);
            return;
        }
        
        $timeCrossed = 0;
        //echo $busMap->fromStation->dateTime;
        if( strtotime($busMap->fromStation->dateTime) < strtotime('now') ) {
            $timeCrossed = 1;
        }

        $busMap = $busMap->data;
        $lseatrow = array();
        $lseatcol = array();
        $useatrow = array();
        $useatcol = array();
        $seatStatus = array();
        $seatDetails = array();

        $t = 0;
        foreach ($busMap->bus->seatLayoutList as $bs) {
            if ($bs->layer == 1) {
                $lseatrow [] = $bs->rowPos;
                $lseatcol [] = $bs->colPos;
                $seatStatus ["1" . $bs->rowPos . $bs->colPos] = array(
                    'status' => $bs->seatStatus,
                    'code' => $bs->code,
                    'fare' => $bs->seatFare,
                    'discount' => $bs->discountFare,
                    'seatName' => $bs->seatName,
                    'seatType' => $bs->busSeatType->name,
                    'userName' => $bs->user->name,
                    'groupName' => $bs->group->name
                );
            }
            if ($bs->layer == 2) {
                $useatrow [] = $bs->rowPos;
                $useatcol [] = $bs->colPos;
                $seatStatus ["2" . $bs->rowPos . $bs->colPos] = array(
                    'status' => $bs->seatStatus,
                    'code' => $bs->code,
                    'fare' => $bs->seatFare,
                    'discount' => $bs->discountFare,
                    'seatName' => $bs->seatName,
                    'seatType' => $bs->busSeatType->name,
                    'userName' => $bs->user->name,
                    'groupName' => $bs->group->name
                );
            }
            $seatDetails [$bs->code] = array(
                'fare' => $bs->seatFare,
                'seatName' => $bs->seatName,
                'discount' => $bs->discountFare,
                'serviceTax' => $bs->serviceTax,
                'genderstatus' => $bs->seatStatus->code
            );

            if (has_action_rights('PHB-SHOW-TKT-INFO') !== 1 && $bs->user->code != _get_user_id()) {
                unset($busMap->bus->seatLayoutList [$t]->passengerName);
                unset($busMap->bus->seatLayoutList [$t]->boardingPointName);
                unset($busMap->bus->seatLayoutList [$t]->passengerAge);
                unset($busMap->bus->seatLayoutList [$t]->contactNumber);
                unset($busMap->bus->seatLayoutList [$t]->ticketCode);
                unset($busMap->bus->seatLayoutList [$t]->route);
            }
            $t ++;
        }

        $data = array(
            'busmap' => $busMap,
            'busseatlayer' => $busMap->bus->seatLayoutList,
            'lrowmax' => max($lseatrow),
            'lrowmin' => min($lseatrow),
            'lcolmax' => max($lseatcol),
            'lcolmin' => min($lseatcol),
            'seatStatus' => $seatStatus,
            'seatDetails' => $seatDetails
        );

        $seattype = $this->api_model->getBusSeatType();
        $busseat = json_decode($seattype);
        $data ['seattype'] = $busseat->data;

        if (count($useatrow) > 0 && count($useatcol) > 0) {
            $data ['urowmax'] = max($useatrow);
            $data ['urowmin'] = min($useatrow);
            $data ['ucolmax'] = max($useatcol);
            $data ['ucolmin'] = min($useatcol);
        }
        echo json_encode($data);
        // $this->load->view('site/search/get-busmap',$data);
    }
    
    function get_busmap_v3() {
        $this->is_logged_in();
        $stageCode = $this->input->post('stageCode');
        $tripCode = $this->input->post('tripCode');
        $travelDate = $this->input->post('travelDate');
        $fromCode = $this->input->post('fromCode');
        $toCode = $this->input->post('toCode');

        $busMap = $this->api_model->getScheduleBusMap_v3(array(
            'stageCode' => $stageCode,
            'tripCode' => $tripCode,
            'travelDate' => $travelDate,
            'fromCode' => $fromCode,
            'toCode' => $toCode,
        ));
        
        $busMap = json_decode($busMap);
        if ($busMap->status == 0) {
            $data = array(
                'status' => 0
            );
            echo json_encode($data);
            return;
        }
        
        $timeCrossed = 0;
        //echo $busMap->fromStation->dateTime;
        if( strtotime($busMap->fromStation->dateTime) < strtotime('now') ) {
            $timeCrossed = 1;
        }
        
        // get and process booked seats details
        $busMap = $busMap->data;
        $mapSyncTime = $busMap->syncTime;

        $p_key = _get_namespace_id() . '_sync_time_' . $tripCode;
        $tripTickets = $this->rediscache->get($p_key);
        $tripTickets = json_decode($tripTickets);

        if ($tripTickets->status != 1 || $tripTickets->data->syncTime != $mapSyncTime) {
            $tripTickets = $this->api_model->tripBookedTickets(array('tripCode' => $tripCode));

            // will be removed on trip reset cache - refer schedules/reset_trip_cache
            $this->rediscache->set($p_key, $tripTickets, 43200); // 12hours
            $tripTickets = json_decode($tripTickets);
        }
        if ($tripTickets->status == 0) {
            echo json_encode($tripTickets);
            return;
        }
        foreach ($tripTickets->data->tickets as $t => $pnr) { // removed booked seats details based on permission.
            if (has_action_rights('PHB-SHOW-TKT-INFO') !== 1 && $pnr->ur->c != _get_user_id()) {
                unset($tripTickets->data->tickets[$t]);
            }
        }
        $tripTickets = $tripTickets->data;
        
        $lseatrow = array();
        $lseatcol = array();
        $useatrow = array();
        $useatcol = array();
        $seatStatus = array();
        $seatDetails = array();
        
        $summary = array();

        $t = 0;
        
        if(count($tripTickets->tickets)>0) {
            foreach ($tripTickets->tickets as $bs) {                
                foreach($bs->tck as $st) {
                    $summary['route'][$bs->fs->n.' to '.$bs->ts->n][] =  $st->sn;
                    $summary['user'][$bs->ur->n][] =  $st->sn;
                    $summary['boarding'][$bs->fs->sp->n][] =  $st->sn;
                    $summary['gender'][$st->sg][] =  $st->sn;
                }                  
            }            
        } 
        
        foreach ($busMap->bus->seatLayoutList as $bs) {
            
                       
            
            if ($bs->layer == 1) {
                $lseatrow [] = $bs->rowPos;
                $lseatcol [] = $bs->colPos;
                
                $zaxis = 0; 
                if($bs->orientation ==1) $zaxis = 1;
                
                $currentlybooking = 0;
                if($bs->seatStatus->code=="TBL" && $bs->updatedAt != '') {
                    $currentlybooking = 1;
                }
                
                $seatStatus ["1" . $bs->rowPos . $bs->colPos] = array(
                    'status' => $bs->seatStatus,
                    'code' => $bs->code,
                    'fare' => $bs->seatFare,
                    'discount' => $bs->discountFare,
                    'seatName' => $bs->seatName,
                    'seatType' => $bs->busSeatType->name,
                    'seatTypeCode' => $bs->busSeatType->code,
                    'userName' => $bs->user->name,
                    'groupName' => $bs->group->name,
                    'groupCode' => strtolower($bs->group->code),
                    'zaxis' => $zaxis,
                    'bookingLive' => $currentlybooking,
                    'remarks' => $bs->remarks ? $bs->remarks : '',
                    'quotaRoute' => $bs->routes->fromStation->name.' - '.$bs->routes->toStation->name,
                    'quotaGender' => $bs->seatGendarStatus->name,
                    'updatedBy' => trim($bs->passengerName) ? $bs->passengerName : '',
                    'updatedAt' => trim($bs->updatedAt) ? $bs->updatedAt : ''                    
                );
            }
            if ($bs->layer == 2) {
                $useatrow [] = $bs->rowPos;
                $useatcol [] = $bs->colPos;
                
                $zaxis = 0; 
                if($bs->orientation ==1) $zaxis = 1;
                
                $currentlybooking = 0;
                if($bs->seatStatus->code=="TBL" && $bs->updatedAt != '') {
                    $currentlybooking = 1;
                }
                
                $seatStatus ["2" . $bs->rowPos . $bs->colPos] = array(
                    'status' => $bs->seatStatus,
                    'code' => $bs->code,
                    'fare' => $bs->seatFare,
                    'discount' => $bs->discountFare,
                    'seatName' => $bs->seatName,
                    'seatType' => $bs->busSeatType->name,
                    'seatTypeCode' => $bs->busSeatType->code,
                    'userName' => $bs->user->name,
                    'groupName' => $bs->group->name,
                    'groupCode' => strtolower($bs->group->code),
                    'zaxis' => $zaxis,
                    'bookingLive' => $currentlybooking,
                    'remarks' => $bs->remarks ? $bs->remarks : '',
                    'quotaRoute' => $bs->routes->fromStation->name.' - '.$bs->routes->toStation->name,
                    'quotaGender' => $bs->seatGendarStatus->name,
                    'updatedBy' => trim($bs->passengerName) ? $bs->passengerName : '',
                    'updatedAt' => trim($bs->updatedAt) ? $bs->updatedAt : ''
                );
            }
            $seatDetails [$bs->code] = array(
                'fare' => $bs->seatFare,
                'seatName' => $bs->seatName,
                'discount' => $bs->discountFare,
                'serviceTax' => $busMap->schedule->serviceTax,
                'genderstatus' => $bs->seatStatus->code
            );

            if (has_action_rights('PHB-SHOW-TKT-INFO') !== 1 && $bs->user->code != _get_user_id()) {
                unset($busMap->bus->seatLayoutList [$t]->passengerName);
                unset($busMap->bus->seatLayoutList [$t]->boardingPointName);
                unset($busMap->bus->seatLayoutList [$t]->passengerAge);
                unset($busMap->bus->seatLayoutList [$t]->contactNumber);
                unset($busMap->bus->seatLayoutList [$t]->ticketCode);
                unset($busMap->bus->seatLayoutList [$t]->route);
            }
            $t ++;
        }

        $data = array(
            'busmap' => $busMap,
            'busseatlayer' => $busMap->bus->seatLayoutList,
            'lrowmax' => max($lseatrow),
            'lrowmin' => min($lseatrow),
            'lcolmax' => max($lseatcol),
            'lcolmin' => min($lseatcol),
            'seatStatus' => $seatStatus,
            'seatDetails' => $seatDetails,
            'summary' => $summary,
            'summaryStatus' => count($summary['boarding']),
            'tripSync' => $tripTickets
        );
        
        //print_r( $data['seatStatus']); 

        $seattype = $this->api_model->getBusSeatType();
        $busseat = json_decode($seattype);
        $data ['seattype'] = $busseat->data;

        if (count($useatrow) > 0 && count($useatcol) > 0) {
            $data ['urowmax'] = max($useatrow);
            $data ['urowmin'] = min($useatrow);
            $data ['ucolmax'] = max($useatcol);
            $data ['ucolmin'] = min($useatcol);
        }
        echo json_encode($data);
        // $this->load->view('site/search/get-busmap',$data);
    }

    function update_seat_booking() {
        $this->is_logged_in();

        $seats = $this->input->post('seats');
        $seatCode = $this->input->post('seatCode');
        $seatName = $this->input->post('seatName');
        $seatFare = $this->input->post('seatFare');

        $emailaddress = $this->input->post('emailaddress');
        $phone = $this->input->post('phone');

        $gender = $this->input->post('gender');
        $name = $this->input->post('name');
        $age = $this->input->post('age');

        $gender = array_values($gender);
        $toStation = $this->input->post('toStation');
        $phoneBooking = $this->input->post('phonebooking');
        $paymentgate = $this->input->post('paymentgate');
        $ticketcode = $this->input->post('ticketpnr');
        $remarks = $this->input->post('remarks');
        
        $spldiscount = $this->input->post('spldiscount');
        $offlineuser = $this->input->post('offlineuser');
        $agentservicecharges = $this->input->post('agentservicecharges');
        
        
        if (isset($paymentgate) && $paymentgate != '' && isset($ticketcode) && $ticketcode != '') {
            $data = array(
                'ticketCode' => $ticketcode,
                'paymentGatewayCode' => $paymentgate,
                'responseUrl' => config_item('ticket_payment_gateway_respone_url')
            );
            echo $this->api_model->updateTicketpayment($data);
            die();
        }
        /*
         * foreach ($seatCode AS $key => $scode) {
         * $p_name = '';
         * $p_age = '';
         * if (isset($name[$key]['value']) && $name[$key]['value'] != '') {
         * $p_name = $name[$key]['value'];
         * } else {
         * $p_name = $name[0]['value'];
         * }
         *
         * if (isset($age[$key]['value']) && $age[$key]['value'] != '') {
         * $p_age = $age[$key]['value'];
         * } else {
         * $p_age = $age[0]['value'];
         * }
         *
         * $passenger[] = array(
         * 'seatCode' => $scode,
         * 'passengerGendar' => $gender[$key],
         * 'passengerName' => $p_name,
         * 'passengerAge' => $p_age,
         * 'seatFare' => $seatFare[$key],
         * 'seatName' => $seatName[$key],
         * );
         * }
         */

        foreach ($seats as $seat) {
            $passenger [] = array(
                'seatCode' => $seat ['code'],
                'passengerGendar' => $seat ['gender'],
                'passengerName' => _uc_name( $seat ['name'] ),
                'passengerAge' => $seat ['age'],
                'seatFare' => $seat ['fare'],
                'seatName' => $seat ['seatname']
            );
        }

        $booking = array(
            'boardingPoint' => array(
                'code' => $this->input->post('bordingstation')
            ),
            'ticketDetails' => $passenger,
            'journeyType' => 'OW',
            'tripStageCode' => $this->input->post('stageCode')
        );

        if (isset($toStation) && $toStation != '') {
            $booking ['droppingPoint'] = array(
                'code' => $this->input->post(droppingstation)
            );
        }
        if (isset($phoneBooking) && $phoneBooking != '' && $phoneBooking == 1) {
            $phoneBooking = "true";
        } else {
            $phoneBooking = "false";
        }

        $bookingTicket = array(
            'emailId' => strtolower($emailaddress),
            'phoneBookingFlag' => $phoneBooking,
            'mobileNumber' => $phone,
            'orderDetails' => array(
                $booking
            )
        );
        if (isset($remarks) && $remarks != '') {
            $bookingTicket ['remarks'] = $remarks;
        }
        
        if (isset($spldiscount) && $spldiscount > 0) {
            $bookingTicket['discountAmount'] = $spldiscount;
        }
        
        if (isset($agentservicecharges) && $agentservicecharges > 0) {
            $bookingTicket['agentServiceCharge'] = $agentservicecharges;
        }
        
        if (isset($offlineuser) && $offlineuser != '') {
            $bookingTicket['offlineUserCode'] = $offlineuser;
        }
        $result = $this->api_model->updatePassengerDetails($bookingTicket);
        $resultjson = json_decode($result);

        if (!$resultjson->data->paymentGatewayProcessFlag && $resultjson->status == 1 && $phoneBooking == "false") {
            $confirm = $this->ticket_confirmation($resultjson->data->code);
            $confirm = json_decode($confirm);
            $confirm->data->currentBalance = $resultjson->data->currentBalance;
            echo json_encode($confirm);
        } else {
            echo $result;
        }
    }
    
    function update_seat_booking_v3() {
        $this->is_logged_in();

        $seats = $this->input->post('seats');
        $seatCode = $this->input->post('seatCode');
        $seatName = $this->input->post('seatName');
        $seatFare = $this->input->post('seatFare');

        $emailaddress = $this->input->post('emailaddress');
        $phone = $this->input->post('phone');

        $gender = $this->input->post('gender');
        $name = $this->input->post('name');
        $age = $this->input->post('age');

        $gender = array_values($gender);
        
        $toStation = $this->input->post('toStation');
        $fromStation = $this->input->post('fromStation');
        $tripCode = $this->input->post('tripCode');
        $tripDate = $this->input->post('tripDate');
        
        $phoneBooking = $this->input->post('phonebooking');
        $freeService = $this->input->post('freeservice');        
        $paymentgate = $this->input->post('paymentgate');
        $ticketcode = $this->input->post('ticketpnr');
        $remarks = $this->input->post('remarks');
        
        $spldiscount = $this->input->post('spldiscount');
        $offlineuser = $this->input->post('offlineuser');
        $agentservicecharges = $this->input->post('agentservicecharges');
        $offlineDiscountCode = $this->input->post('offlineDiscountCode');
        $offlinePayType = $this->input->post('offlinepaytype');

        $additionalAttributes = $this->input->post('additionalAttributes');

        $userOTP = $this->input->post('userOTP');
        
        $gogreen = $this->input->post('gogreendonation'); 
        
        if (isset($paymentgate) && $paymentgate != '' && isset($ticketcode) && $ticketcode != '') {
            $data = array(
                'ticketCode' => $ticketcode,
                'paymentGatewayCode' => $paymentgate,
                'responseUrl' => config_item('ticket_payment_gateway_respone_url')
            );
            echo $this->api_model->updateTicketpayment($data);
            die();
        }

        foreach ($seats as $seat) {
            $passenger [] = array(
                'seatCode' => $seat ['code'],
                'passengerGendar' => $seat ['gender'],
                'passengerName' => _uc_name( $seat ['name'] ),
                'passengerAge' => $seat ['age'],
                'seatFare' => $seat ['fare'],
                'seatName' => $seat ['seatname']
            );
        }

        $booking = array(
            'boardingPoint' => array(
                'code' => $this->input->post('bordingstation')
            ),
            'ticketDetails' => $passenger,
            'journeyType' => 'OW',
            
            'tripCode' => $this->input->post('tripCode'),
            'fromStation' => array( 'code' => $this->input->post('fromStation') ),
            'toStation' => array( 'code' => $this->input->post('toStation') ),
            'travelDate' => date('Y-m-d', strtotime($this->input->post('tripDate'))),

            //'tripStageCode' => $this->input->post('stageCode')
        );

        if (isset($toStation) && $toStation != '') {
            $booking ['droppingPoint'] = array(
                'code' => $this->input->post('droppingstation')
            );
        }
        if (isset($phoneBooking) && $phoneBooking != '' && $phoneBooking == 1) {
            $phoneBooking = "true";
        } else {
            $phoneBooking = "false";
        }
        
        if (isset($freeService) && $freeService != '' && $freeService == 1) {
            $freeService = "true";
        } else {
            $freeService = "false";
        }
        
        $aggregate = array();
        if($userOTP!='') $aggregate['BOOK-ON-OTP'] = $userOTP;
        
        $bookingTicket = array(
            'emailId' => strtolower($emailaddress),
            'phoneBookingFlag' => $phoneBooking,
            'freeServiceFlag' => $freeService,
            'mobileNumber' => $phone,
            'orderDetails' => array(
                $booking
            )
        );
        
        if (count($aggregate)>0) {
            $bookingTicket['aggregate'] = $aggregate;
        }
        
        if (isset($remarks) && $remarks != '') {
            $bookingTicket ['remarks'] = $remarks;
        }
        
        if (isset($spldiscount) && $spldiscount > 0) {
            $bookingTicket['discountAmount'] = $spldiscount;
        }
        
        if (isset($offlineuser) && $offlineuser != '') {
            $bookingTicket['offlineUserCode'] = $offlineuser;
        }
        
        if (isset($agentservicecharges) && $agentservicecharges > 0) {
            $bookingTicket['agentServiceCharge'] = $agentservicecharges;
        }
        
        if (isset($offlineDiscountCode) && $offlineDiscountCode != '') {
            $bookingTicket['offlineDiscountCode'] = $offlineDiscountCode;
        }

        if (isset($additionalAttributes) && $additionalAttributes != '') {
            $bookingTicket['additionalAttributes'] = $additionalAttributes;
        }
        
        if ($gogreen==1) {
            $bookingTicket['additionalAttributes']['GO_GREEN'] = 10;
        }
        
        //print_r($bookingTicket); die;
        
        $result = $this->api_model->updatePassengerDetails_v3($bookingTicket);
        $resultjson = json_decode($result);     
                
        $balance = $resultjson->data->currentBalance;
        $bal = number_format($balance,2);
        $this->session->set_userdata('balance', $bal);
        $resultjson->data->currentBalance = $bal;

        if (!$resultjson->data->paymentGatewayProcessFlag && $resultjson->status == 1 && $phoneBooking == "false") {
            $confirm = $this->ticket_confirmation($resultjson->data->code, $offlinePayType);
            $confirm = json_decode($confirm);
            $confirm->data->currentBalance = $resultjson->data->currentBalance;
            echo json_encode($confirm);
        } else {
            echo $result;
        }
    }

    function gateway_details() {
        $this->is_logged_in();
        $data = array(
            'orderCode' => $this->input->post('pnrcode'),
            'paymentGatewayCode' => $this->input->post('gatewaycode'),
            'orderType' => config_item('payment_type_ticket_booking'),
            'responseURL' => config_item('ticket_payment_gateway_respone_url')
        );
        echo $this->api_model->updateTicketpayment($data);
    }

    /*
     * function cancel_terms() {
     * $this->is_logged_in();
     * $stageCode = $this->input->post('stageCode');
     * $policy = $this->api_model->getTripsTerms(array('stageCode' => $stageCode));
     * $policy = json_decode($policy);
     * $data['cancel'] = $policy->data;
     * $this->load->view('site/search/cancel-terms', $data);
     * }
     */

    function stage_details() {
        $tripcode = $this->input->post('tripCode');
        echo $this->api_model->scheduleStagesDetails(array(
            'tripCode' => $tripcode
        ));
    }

    function cancel_terms() {
        $stagecode = $this->input->post('stageCode');
        $data = json_decode($this->api_model->getTripsTerms(array(
                    'stageCode' => $stagecode
        )));
        echo json_encode($data);
    }

    function ticket_confirmation($pnrCode, $offlinePayType='') {
        return $this->api_model->updateTicketConfim(array(
            'ticketCode' => $pnrCode,
            'offlinePayType' => $offlinePayType
        ));
    }

    function ticket_confirmation_by_phone() {
        $pnrCode = $this->input->post('pnrcode');
        $passenger = $this->input->post('seatcode');
        $flag = $this->input->post('bookByMyAccountFlag');
        $remarks = $this->input->post('pblRemarks');
        
        $offlinepaytype = $this->input->post('offlinepaytype');
        
        foreach ($passenger as $ps) {
            $tmp [] = array(
                'seatCode' => $ps
            );
        }
        $passenger = $tmp;
        $data = array(
            'ticketCode' => $pnrCode,
            'ticketDetails' => $passenger,
            'overrideFlag' => 'false',
            'bookByMyAccountFlag' => $flag,
            'offlinepaytype' => $offlinepaytype
        );
        
        if( !empty($remarks) ) {
            $data['remarks'] = $remarks;
        }        
        echo $this->api_model->updateTicketConfimByPhone($data);
    }

    function ticket_cancel_by_phone() {
        $pnrCode = $this->input->post('pnrcode');
        $passenger = $this->input->post('seatcode');
        foreach ($passenger as $ps) {
            $tmp [] = array(
                'seatCode' => $ps
            );
        }
        $passenger = $tmp;
        $data = array(
            'ticketCode' => $pnrCode,
            'ticketDetails' => $passenger,
            'overrideFlag' => 'false'
        );
        echo $this->api_model->updateTicketCancelByPhone($data);
    }

    function check_cancel_booking() {
        $this->is_logged_in();
        $seatCode = $this->input->post('seatCode');
        $ticketCode = $this->input->post('ticketCode');
        echo $this->api_model->checkCancelBooking(array(
            'ticketCode' => $ticketCode
        ));
    }

    // Commom template for ticket list
    function confimation_payment_list() {
        $this->is_logged_in();
        $report = $this->api_model->ticketDetails(array(
            'ticketCode' => $this->input->post('ticketpnrcode')
        ));
        $rpt = json_decode($report);
        if ($rpt->status == 1) {
            $rules = $this->api_model->getRules();
            $ruleslist = json_decode($rules);
            $data ['reports'] = $rpt->data;
            
            $data['ns_domain_url'] = $this->session->userdata('ns_domain_url');
            $tcode = $rpt->data->tripCode;
            $sdate = $rpt->data->travelDate;
            $param = array(
                'fromCode' => $rpt->data->fromStation->code,
                'toCode' => $rpt->data->toStation->code,
                'tripDate' => date("Y-m-d", strtotime($sdate))
            );
            $d_start = new DateTime(date('Y-m-d')); 
            $d_end   = new DateTime($sdate); 
            $diff = $d_start->diff($d_end); 
            $days = $diff->format('%d');
            $tripinfo = array();        
            if($days<=1) {  // current day or 1 day difference.
                
                $tinfo = $this->api_model->getAllTripInfo($param);
                $tinfo = json_decode($tinfo);
                foreach($tinfo->data as $row){
                    if($row->trip->tripCode == $tcode){
                        $tripinfo = $row;
                        break;
                    }
                }
            }
            
            $data ['trips'] = $tripinfo;
            $data ['terms'] = $ruleslist->data;
            $time = new DateTime($rpt->data->travelDate);
            $data ['times'] = $time->format('H:i A');
            $data ['print_url'] = config_item('api_domain') . '/' . _get_user_hash() . '/print/pdf/A4/' . $this->input->post('ticketpnrcode');
        } else {
            $data ['status'] = 1;
        }
        if ($this->input->post('ticketPage') == 1) {
            _include_js('assets/js/pages/booking.js');
            $this->load->view('site/search/ticket-booking-list', $data);
        } else {

            if ($this->input->post('print') != '') {
                $data ['print'] = $this->input->post('print');
            }
            $data['ticket_status'] = config_item('ticket_status');
            $this->load->view('site/search/book-details', $data);
        }
    }

    //
    function confimation_payment() {
        $this->is_logged_in();
        $pnrcode = $this->input->get('orderCode');
        $data ['pnrcode'] = $pnrcode;
        if ($this->input->post('ticketpnrcode')) {
            $confirm = $this->ticket_confirmation($this->input->post('ticketpnrcode'));
            $confirm = json_decode($confirm);
            if ($confirm->status == 1) {
                $this->confimation_payment_list($this->input->post('type'));
            } else {
                echo '<div class="well well-lg" style="height:200px; text-align:center;vertical-align: middle;" > ' . '<br> <br> <br> <div class="alert alert-danger">' . $confirm->errorDesc . '</div> <br>' . ' PNR Code :  ' . $this->input->post('ticketpnrcode') . ' ' . '</div>';
            }
        } elseif ($this->input->get('export') == 1) {
            $tck_code = $this->input->get('pnr');
            $this->pdf($tck_code);
        } else {
            $this->load->view('site/search/confirmation-payment', $data);
        }
    }

    function print_ticket() {
        $this->is_logged_in();

        if ($this->input->post('ticketpnrcode')) {
            // $confirm = $this->ticket_confirmation($this->input->post('ticketpnrcode'));
            // $confirm = json_decode($confirm);
            // if ($confirm->status == 1) {

            $this->confimation_payment_list();

            // }
        } elseif ($this->input->get('export') == 1) {
            $tck_code = $this->input->get('pnr');
            $this->pdf($tck_code);
        } else {
            $this->load->view('site/search/print-ticket');
        }
    }

    function cancel_ticket() {
        $this->is_logged_in();

        if ($this->input->post('type') == 'CAN') {
            $data ['cancel'] = 1;
            $can = $this->api_model->ticketCancelDetails(array(
                'ticketCode' => $this->input->post('ticketpnrcode'),
                'cancellationOverRideFlag' => has_action_rights('OVER-REF-AMT')
            ));
            $can_tck = json_decode($can);

            if ($can_tck->status == 1) {
                $data ['reports'] = $can_tck->data;
                $time = new DateTime($can_tck->data->travelDate);
                $data ['times'] = $time->format('H:i A');
                $data ['code'] = $this->input->post('ticketpnrcode');
                // $data ['print_url'] = config_item('api_domain') . '/' . _get_user_hash() . '/print/pdf/A4/' . $this->input->post('ticketpnrcode');
            } else {
                $data ['error'] = $can_tck;
                $data ['status'] = 1;
            }
            if ($this->input->post('return') == 'BK') {
                $this->load->view('site/search/ticket-booking-list', $data);
            } else {
                $this->load->view('site/search/book-details', $data);
            }
        } else if ($this->input->post('type') == 'PHO') {
            $ticketlist = $this->api_model->ticketDetails(array(
                'ticketCode' => $this->input->post('ticketpnrcode')
            ));
            $ticketlist = json_decode($ticketlist);
            if ($ticketlist->status == 1) {
                $data ['reports'] = $ticketlist->data;
                $time = new DateTime($ticketlist->data->travelDate);
                $data ['times'] = $time->format('H:i A');
                $data ['code'] = $this->input->post('ticketpnrcode');
            } else {
                $data ['status'] = 1;
            }

            if ($this->input->post('return') == 'PK') {
                $data ['phone'] = 1;
                $this->load->view('site/search/ticket-booking-list', $data);
            }
        } else {
            $this->load->view('site/search/cancel-ticket');
        }
    }

    function cancel_ticket_confirmation() {
        $this->is_logged_in();
        $type = $this->input->post('tickettype');
        if ($type == "BO") {
            $code = $this->input->post('seatcode');
            $myAccountFlag = 'false';
            if($this->input->post('myAccountFlag')==1) {
                $myAccountFlag = 'true';
            }
            $seatcode = implode(',', $code);

            $data = array(
                'cancellationOverRideRefundAmount' => $this->input->post('amount'),
                'seatCodeList' => $seatcode,
                //'cancellationOverRideFlag' => 'true',
                'myAccountFlag' => $myAccountFlag,
                'ticketCode' => $this->input->post('pnrcode')
            );           
            echo $this->api_model->cancelTicket($data);
        } else {
            echo $this->ticket_cancel_by_phone();
        }
    }

    static function replaceMailKey($template, $vars) {
        foreach ($vars as $searchkey => $searchval)
            $template = str_replace($searchkey, $searchval, $template);
        return $template;
    }

    public function print_sheet() {
        $this->load->exclude_template();
        $tck_code = $this->input->get('pnrCode');

        // Get ticket Details
        $ticket = $this->api_model->ticketDetails(array(
            'ticketCode' => $tck_code
        ));
        $tck = json_decode($ticket);
        $data ['tck'] = $tck->data;

        $rules = $this->api_model->getRules();
        $ruleslist = json_decode($rules);
        $data ['terms'] = $ruleslist->data;

        $this->load->view('site/search/print-sheet', $data);
    }

    function ticket_pdf() {//ticket pdf
        $tck_code = $this->input->get('pnr');
        $ticket = $this->api_model->ticketDetails(array('ticketCode' => $tck_code));
        $ticket = json_decode($ticket);
        $tck = $ticket->data;

        $this->load->library('fpdf/fpdf');
        $pdf = new FPDF();
        $pdf->AddPage();
        $pdf->SetFont('Arial', 'B', 1);

        $y = 10;
        $x = 10;
        $line_height = 5;

        $img = base_url().'public/'.$this->session->userdata('namespace_id') . '/trip_chart_logo.jpg';
        $pdf->Image($img,30, 3, 150, 10,'jpg'); // logo 
        
        $pdf->Cell(190, $line_height, '', "B", 1, 'L');
        $pdf->Ln(1);

        $pdf->SetXY(10, $y + $line_height * 2);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(30, $line_height, "PNR Number", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(50, $line_height, ': ' . $tck_code);
        $pdf->Ln(2);

        $pdf->Ln($line_height * .1);
        $pdf->SetX(10);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(30, $line_height, "Passenger Mobile", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(30, $line_height, ': ' . $tck->passegerMobleNo);
        $pdf->Ln(2);

        $route = $tck->fromStation->name . '-' . $tck->toStation->name;
        $pdf->Ln($line_height * .1);
        $pdf->SetX(10);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(30, $line_height, "Route", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(50, $line_height, ': ' . $route);
        $pdf->Ln(2);

        $boarding = $tck->fromStation->stationPoint[0]->name . ',' . $tck->fromStation->name . ',' . $tck->fromStation->stationPoint[0]->address;
        $pdf->Ln($line_height * .1);
        $pdf->SetX(10);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(30, $line_height, "Boarding Info", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(70, $line_height, ': ' . $boarding);
        $pdf->Ln(2);

        //SECOND COLUMN

        $datetime = date('d / m / Y', strtotime($tck->travelDate)) . ', ' . date('g:i A', strtotime($tck->fromStation->stationPoint[0]->dateTime));

        $pdf->SetXY(109, $y + $line_height * 2);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(28, $line_height, "Travel Date/Time", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(50, $line_height, ': ' . $datetime);
        $pdf->Ln(2);

        $pdf->Ln($line_height * .1);
        $pdf->SetX(109);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(28, $line_height, "Booked At", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(50, $line_height, ': ' . date('d / m / Y g:i A', strtotime($tck->transactionDate)));
        $pdf->Ln(2);

        $pdf->Ln($line_height * .1);
        $pdf->SetX(109);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(28, $line_height, "Bus Type", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(60, $line_height, ': ' . $tck->bus->busType);
        $pdf->Ln(2);

        $alighting = $tck->toStation->stationPoint[0]->address . ',' . $tck->toStation->stationPoint[0]->name . ',' . $tck->toStation->name;
        $pdf->Ln($line_height * .1);
        $pdf->SetX(109);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(28, $line_height, "Alighting Info", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(63, $line_height, ': ' . $alighting);
        $pdf->Ln(1);

        // Passenger Details

        $header = array('0' => 'Passenger Name', '1' => 'Seat No', '2' => 'Gender', '3' => 'Age', '4' => 'Status', '5' => 'Fare');
        $pdf->SetFont('Arial', 'b', 9);
        foreach ($header as $head) {
            $pdf->Cell(31.5, 7, $head, 1);
        }
        $pdf->Ln();
        $pdf->SetFont('Arial', '', 9);

        foreach ($tck->ticketDetails as $row) {
            if ($row->seatStatus->code == "CA") {

                //strike
            }
            $pdf->Cell(31.5, 6, $row->passengerName, 1);
            $pdf->Cell(31.5, 6, $row->seatName, 1);
            $pdf->Cell(31.5, 6, $row->passengerGendar, 1);
            $pdf->Cell(31.5, 6, $row->passengerAge, 1);
            $pdf->Cell(31.5, 6, $row->seatStatus->name, 1);
            $pdf->Cell(31.5, 6, 'Rs. ' . $row->seatFare, 1);
            $pdf->Ln();
        }

        $tot_trans = 0;
        $tax = 0;
        $can_charge = 0;
        $refund = 0;

        foreach ($tck->ticketTransaction as $trans) {
            if ($trans->transactionType->code == "TICKBO") {
                $tot_trans = $tot_trans + $trans->transactionAmount;
                $tax = $tax + $trans->serviceTax;
            } else {
                $can_charge = $can_charge + $trans->cancellationChargeAmount;
                $refund = $refund + $trans->refundAmount;
            }
        }


        if ($tax > 0) {
            $pdf->Ln();
            $pdf->SetFont('Arial', 'b', 9);
            $pdf->Cell(157.5, 6, 'GST', 1, '0', 'R');
            $pdf->SetFont('Arial', '', 9);
            $pdf->Cell(31.5, 6, 'Rs. ' . $tax, 1);
        }
        $pdf->SetFont('Arial', 'b', 10);
        $pdf->Cell(157.5, 6, 'Total', 1, '0', 'R');
        $pdf->SetFont('Arial', '', 10);
        $pdf->Cell(31.5, 6, 'Rs. ' . $tck->totalFare, 1);

        if ($can_charge > 0) {
            $pdf->Ln();
            $pdf->SetFont('Arial', 'b', 10);
            $pdf->Cell(157.5, 6, 'Cancellation Charge', 1, '0', 'R');
            $pdf->SetFont('Arial', '', 10);
            $pdf->Cell(31.5, 6, 'Rs. ' . $can_charge, 1);
        }

        if ($refund > 0) {
            $pdf->Ln();
            $pdf->SetFont('Arial', 'b', 10);
            $pdf->Cell(157.5, 6, 'Refund', 1, '0', 'R');
            $pdf->SetFont('Arial', '', 10);
            $pdf->Cell(31.5, 6, 'Rs. ' . $refund, 1);
        }

        // Cancellation Policy

        $pdf->Ln(8);
        $pdf->SetX(10);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(40, $line_height, "Cancellation Policy", 0, 0, 'L');
        $pdf->Ln(6);


        $header1 = array('0' => 'Timing', '1' => 'Deduction', '2' => 'Refund', '3' => 'Charges');

        $pdf->Cell(100.5, 7, 'Timing', 0);
        $pdf->Cell(40.5, 7, 'Deduction', 0);
        $pdf->Cell(30.5, 7, 'Refund', 0);
        $pdf->Cell(30.5, 7, 'Charges', 0);
        $pdf->Ln(6);
        foreach ($tck->cancellationTerms->policyList as $row) {
            $pdf->SetFont('Arial', '', 9);
            $pdf->Cell(100.5, 6, $row->term, 0);
            $pdf->Cell(40.5, 6, $row->deductionAmountTxt, 0);
            $pdf->Cell(30.5, 6, $row->refundAmountTxt, 0);
            $pdf->Cell(30.5, 6, $row->chargesTxt, 0);
            $pdf->Ln();
        }

        // Terms

        if (count($terms) > 0) {
            $pdf->Ln(8);
            $pdf->SetX(10);
            $pdf->SetFont('Arial', 'b', 9);
            $pdf->Cell(40, $line_height, "Terms", 0, 0, 'L');
            $pdf->Ln(6);
            $i = 1;
            foreach ($terms as $tr) {
                if ($tr->name != "" && $tr->activeFlag == 1) {
                    $pdf->SetFont('Arial', '', 9);
                    $pdf->Cell(10, 6, $i, 0);
                    $pdf->Cell(180, 6, $tr->name, 0);
                    $pdf->Ln();
                    $i++;
                }
            }
        }
        ob_start();
        $pdf->Output(); // output as pdf   
        $content = ob_get_contents();
        ob_end_clean();
        
        header('Content-Description: File Transfer');
        header('Content-Type: application/pdf');
        header('Content-Disposition: attachment; filename=Ticket.pdf');
        header('Content-Transfer-Encoding: binary');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: ' . strlen($content));
        ob_clean();
        flush();
        echo $content; 
        die;
        
    }

    public function termsCondition() {
        $this->is_logged_in();
        $rules = $this->api_model->getRules(array(
            'authtoken' => $this->_user_hash
        ));
        $ruleslist = json_decode($rules);
        $data ['rules_list'] = $ruleslist->data;
        $this->load->view('site/search/print-sheet', $data);
    }

    public function pdf() {
        $this->load->exclude_template();
        $tck_code = $this->input->get('pnr');
        $ticket = $this->api_model->ticketDetails(array(
            'ticketCode' => $tck_code
        ));
        $data ['tck'] = json_decode($ticket);

        $html = $this->load->view('site/search/print-sheet', $data, true);
        $this->load->library('dompdf_gen');
        $this->dompdf->load_html($html);
        $this->dompdf->render();
        $this->dompdf->stream("ticket.pdf");

        return;

        $OperContact = 'NA';
        $BusName = $tck->data->bus->name;
        $fromstation = $tck->data->fromStation->name;
        $tostation = $tck->data->toStation->name;
        $travelDate = $tck->data->travelDate | date_format | $ns_datetime_format;
        $tckDate = 'NA';
        $tckPnr = $tck_code;
        $busType = $tck->data->bus->busType;
        $boardingTime = 'NA';
        $boardingName = $tck->data->fromStation->stationPoint [0]->name;
        $baddress = $tck->data->fromStation->stationPoint [0]->address;
        $blandmark = $tck->data->fromStation->stationPoint [0]->landmark;
        $pass_mobile = $tck->data->passegerMobleNo;
        $tcontact = $tck->data->fromStation->stationPoint [0]->number;
        $drop_point = $tck->data->toStation->stationPoint [0]->name;
        $drop_address = $tck->data->toStation->stationPoint [0]->address;
        $drop_landmark = $tck->data->toStation->stationPoint [0]->landmark;
        $refund = $tck->data->ticketDetails->refundAmount;
        $do_contact = 'NA';
        $ticketlist = '';
        $totalFare = '0';
        $discount = '0';
        $netBalance = '0';
        $cancelterm = '';
        // $term = $tck->data->cancellationTerms->policyList[0]->term;
        // $img = $base_url . 'assets/img/bus-icon.png';

        foreach ($tck->data->ticketDetails as $ticket) {
            if ($ticket->seatStatus->code == 'BO') {
                $totalFare = $tck->data->totalFare;
                $discount = 'NA';
                $netBalance = $tck->data->totalFare;
                $ticketlist .= '<tr>
                <td width="40%" height="27" style="border-bottom: 1px solid #E5E5E5; padding: 3px; text-transform: capitalize;">' . $ticket->passengerName . '</td>
                <td align="center" width="10%" style="border-bottom: 1px solid #E5E5E5; padding: 3px">' . $ticket->seatName . '</td>
                <td align="center" width="10%" style="border-bottom: 1px solid #E5E5E5; padding: 3px">' . $ticket->passengerGendar . '</td>
                <td align="center" width="10%" style="border-bottom: 1px solid #E5E5E5; padding: 3px">' . $ticket->passengerAge . '</td>
                <td align="right"  width="15%" style="border-bottom: 1px solid #E5E5E5; padding: 3px"><span>Rs. </span>' . $ticket->seatFare . '</td>

</tr>';
            }
        }

        foreach ($tck->data->cancellationTerms->policyList as $policy) {
            $cancelterm .= '<li style="list-style: decimal inside;padding: 3px;">
			' . $policy->term . ' ' . $policy->deductionAmountTxt . ' Deduction ' . $policy->refundAmountTxt . 'Refund' . $policy->chargesTxt . 'Service Charges
		</li>';
        }

        // Get Template Details

        $temp_code = 'TICKET-PDF';

        $temp = $this->api_model->templateDetails(array(
            'templateCode' => $temp_code
        ));
        $template = json_decode($temp);

        // Get template
        $html = $template->data ['0']->template;

        $vars = array(
            '{Operatorcontact}' => $OperContact,
            '{Busname}' => $BusName,
            '{fromStationName}' => $fromstation,
            '{toStationName}' => $tostation,
            '{ticketDate}' => $tckDate,
            '{ticketPNR}' => $tckPnr,
            '{busType}' => $busType,
            '{travelDateTime}' => $travelDate,
            '{boardingPointTime}' => $boardingTime,
            '{boardingPointName}' => $boardingName,
            '{baddress}' => $baddress,
            '{blandmark}' => $blandmark,
            '{passengerMobileNumber}' => $pass_mobile,
            '{travelsContactNumber}' => $tcontact,
            '{droppingPointName}' => $drop_point,
            '{daddress}' => $drop_address,
            '{dlandmark}' => $drop_landmark,
            '{doperatorcontactnumber}' => $do_contact,
            '{travelDate}' => $travelDate,
            '{ticketList}' => $ticketlist,
            '{totalfare}' => $totalFare,
            '{refundAmount}' => $refund,
            '{discount}' => $discount,
            '{netBalance}' => $netBalance,
            '{cancelterm}' => $cancelterm
                )
        // '{img}' => $img,
        ;

        $mail_subject = self::replaceMailKey($html, $vars);

        $this->load->library('dompdf_gen');
        $this->dompdf->load_html($mail_subject);
        $this->dompdf->render();
        $this->dompdf->stream("ticket.pdf");
    }
    
    public function get_passenger_details() { // get passenger details
        $this->is_logged_in();
        $mobile = $this->input->post('mobile');
        $count = $this->input->post('seatCount');
        $users = $this->api_model->loadPassengerDetails(array(
            'mobile' => $mobile,
            'count' => $count
        ));
        echo json_encode($users);
    }
    
    function ticket_mini_pdf() { //mini ticket pdf
        $tck_code = $this->input->get('pnr');
        $ticket = $this->api_model->ticketDetails(array('ticketCode' => $tck_code));
        $ticket = json_decode($ticket);
        $tck = $ticket->data;
        $seat = '';
        $name = '';
        $fare = '';
        foreach($tck->ticketDetails as $tckdet){
            $seat .= $tckdet->seatName.', ';
            $name .= $tckdet->passengerName.', ';
            $fare += $tckdet->seatFare;
        }
        $seat = rtrim($seat,',');
        $name = rtrim($name,',');
        
        $this->load->library('fpdf/fpdf');
        $pdf = new FPDF();
        $pdf->AddPage();
        $pdf->SetFont('Arial', 'B', 1);
        $y = 60;
        $x = 50;
        $line_height = 3;
        
        $pdf->SetXY(20, $y + $line_height * 2);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(25, $line_height, "PNR Number", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(50, $line_height, ': ' . $tck_code);
        $pdf->Ln(2);
        
        $date = date('d / m / Y', strtotime($tck->travelDate));

        $pdf->Ln($line_height * .1);
        $pdf->SetX(20);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(25, $line_height, "Travel Date", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(50, $line_height, ': ' . $date);
        $pdf->Ln(2);
        
        $time = date('g:i A', strtotime($tck->fromStation->stationPoint[0]->dateTime));
        
        $pdf->Ln($line_height * .1);
        $pdf->SetX(20);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(25, $line_height, "Travel Time", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(76, $line_height, ': ' . $time);
        $pdf->Ln(2);
        
        $pdf->Ln($line_height * .1);
        $pdf->SetX(20);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(25, $line_height, "From", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(76, $line_height, ': ' . $tck->fromStation->name);
        $pdf->Ln(2);
        
        $boarding = $tck->fromStation->stationPoint[0]->name . ' ,' . $tck->fromStation->stationPoint[0]->address;
        $pdf->Ln($line_height * .1);
        $pdf->SetX(20);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(25, $line_height, "Boarding", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(130, $line_height, ': ' . $boarding, 0, 'L');
        $pdf->Ln(2);
        
        $pdf->Ln($line_height * .1);
        $pdf->SetX(20);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(25, $line_height, "Seat No", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(76, $line_height, ': ' . $seat);
        $pdf->Ln(2); 
        
        $pdf->Ln($line_height * .1);
        $pdf->SetX(20);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(25, $line_height, "Name", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(75, $line_height, ': ' . $name);
        $pdf->Ln(2);
        
        

        //SECOND COLUMN
        
        
        $pdf->Ln($line_height * .1);
        $pdf->SetXY(90,65);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(28, $line_height, "Bus Type", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(60, $line_height, ': ' . $tck->bus->busType);
        $pdf->Ln(2);

        $pdf->Ln($line_height * .1);
        $pdf->SetX(90);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(28, $line_height, "Booked Date", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(50, $line_height, ': ' . date('d / m / Y ', strtotime($tck->transactionDate)));
        $pdf->Ln(2);

        $pdf->Ln($line_height * .1);
        $pdf->SetX(90);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(28, $line_height, "Report Time", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(60, $line_height, ': ' . $tck->reportingTime);
        $pdf->Ln(2);

        $pdf->Ln($line_height * .1);
        $pdf->SetX(90);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(28, $line_height, "To", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(30, $line_height, ': ' . $tck->toStation->name);
        $pdf->Ln(9);
        
        $pdf->Ln($line_height * .1);
        $pdf->SetX(90);
        $pdf->SetFont('Arial', 'b', 9);
        $pdf->Cell(28, $line_height, "Fare", 0, 0, 'L');
        $pdf->SetFont('Arial', '', 9);
        $pdf->MultiCell(30, $line_height, ': Rs ' . $fare);
        $pdf->Ln(2);

        $user = $tck->user->name;
        
        $pdf->Ln($line_height * .1);
        $pdf->SetXY(90,110);
        $pdf->SetFont('Arial', '', 8);
        $pdf->SetFont('Arial', '', 8);
        $pdf->MultiCell(100, $line_height, 'Booked By : ' . $user.' '. date('d/m/Y  g:i  A', strtotime($tck->transactionDate)));
        $pdf->Ln(2);

        
        
        ob_clean();
        $pdf->Output('Mini-Ticket-'.$tck_code.'.pdf', 'i'); // output as pdf   
//        $content = ob_get_contents();
//        ob_end_clean();
//        
//        header('Content-Description: File Transfer');
//        header('Content-Type: application/pdf');
//        header('Content-Disposition: attachment; filename=Ticket.pdf');
//        header('Content-Transfer-Encoding: binary');
//        header('Expires: 0');
//        header('Cache-Control: must-revalidate');
//        header('Pragma: public');
//        header('Content-Length: ' . strlen($content));
//        ob_clean();
//        flush();
//        echo $content; 
//        die;
        
    }
    
    function sms_ticket() { // send sms for pnr
        $this->is_logged_in();
        $pnr = $this->input->post('ticketpnrcode');
        $type = $this->input->post('type');
        
        if($type == 'RSNDGPSHJ') {
            $api_sms_type = config_item('api_sms_type');
            $sms_type = $this->input->post('type');

            $param = array(
                'TICKETS'  => $this->input->post('ticketpnrcode'),
                'MOBILE' => $this->input->post('mobile') ?: '',
                'SMS_TYPE' => $api_sms_type[$sms_type],
                'TRIP_CODE' => $this->input->post('tripCode'),
            );
            $sms = $this->api_model->sendTripNotificationSMS($param);
        } else {
            $sms = $this->api_model->sendPnrSms(array(
                'TICKETS'  => $this->input->post('ticketpnrcode')
            ));
        }
        
        echo $sms;
    }
    
    function trackbus_url() { // send sms for pnr
        $this->is_logged_in();
        
        $zone =  config_item('zone');
        $track_link = config_item('product_domain');
        $link = $track_link['trackingui'].'/?p='.$this->input->post('pnr').'&zone='.$zone;
        
        $this->load->model('shorturl_model');
        $short_url = $this->shorturl_model->shorten(array(
            'url' => $link,
            'type' => 'TMP'        // Temporary
         ));
        $short_url = json_decode($short_url);

        if($short_url->status == 1) {
            $url = $short_url->data->url;
            $short_url->data->url = preg_replace('/https/i', 'http', $url);
        }
        
        echo json_encode($short_url);
    }
    
    function transfer_tickets() { // transfer tickets 
        $this->is_logged_in();
        $scode = rtrim($this->input->post('seatCode'), ',');
        $scode = explode(',', $scode);
        $tscode = rtrim($this->input->post('transferSeatCode'), ',');
        $tscode = explode(',', $tscode);
        
        $data = array(
            'seatCode' => $scode,
            'transferBoardingPoint' => array('code' => $this->input->post('transferBoardingPoint')),
            'transferDroppingPoint' => array('code' => $this->input->post('transferDroppingPoint')),
            'transferSeatCode' => $tscode,
            'captureFareDifferece' => $this->input->post('captureFareDifference'),
            'captureTransferCharge' => $this->input->post('captureTransferCharge'),
            'notificationFlag' => $this->input->post('notificationFlag'),
            'transferTripStageCode' => $this->input->post('tripStageCode'),
            'transferTripCode' => $this->input->post('tripCode'),
            'ticketCode' => $this->input->post('ticketCode'),
            'myAccountFlag' => $this->input->post('myAccountFlag'),
                        
            'transferFromStation' => array('code' => $this->input->post('fromStation')),
            'transferToStation' => array('code' => $this->input->post('toStation')),
            'transferTravelDate' => $this->input->post('sdate')            
        );
        
        $response = $this->api_model->transferTicket($data);
        echo $response;
        
        /*$newTicket = json_decode($response);        
        if($newTicket->status==1) {
            $ticket = $this->api_model->ticketDetails(array('ticketCode' => $newTicket->data->code)); 
            $ticket = json_decode($ticket);
            if($ticket->status==1) {
                $newticketDetails = array();
                $newticketDetails['pnr'] = $ticket->data->code;
                $newticketDetails['travelDate'] = $ticket->data->travelDate;
                $newticketDetails['busType'] = $ticket->data->bus->busType;
                $newticketDetails['contact'] = $ticket->data->passegerMobleNo;
                $newticketDetails['paxName'] = $ticket->data->ticketDetails[0]->passengerName;
                $newticketDetails['route'] = $ticket->data->fromStation->name.' - '.$ticket->data->toStation->name;
                $newticketDetails['seats'] = '';
                foreach($ticket->data->ticketDetails as $seat) {
                    $newticketDetails['seats'] = $newticketDetails['seats'].$seat->seatName.',';
                }
                $newticketDetails['bookedby'] = $ticket->data->user->name;
                
                
                $oldTicketDetails = $this->input->post('oldTicket');
                        
                $maildata = array(
                    "operatorCode" => $this->session->userdata('namespace_id'),
                    "params" => array(
                        'newticket'=>$newticketDetails,
                        'oldticket'=> $oldTicketDetails
                    )
                ); 
                _send_mail('tickettransfer', $maildata);                
            }
        } */
        
    }
    
    function save_trip_fare() {
        $this->is_logged_in();
        $fares = $this->input->post('fares');
        foreach($fares as $fare) {
            $data[] = array(
                "tripCode" => $this->input->post('tripCode'),
                "fare" => $fare['newfare'],
                "fromStation" => array('code' => $fare['fromcode']),
                "toStation" => array('code' => $fare['tocode']),
                "activeFlag" => 1,            
                "fareType" => 'FLT',
                "fareOverrideType" => 'FLFA',
                "overrideMinutes" => 0,
                "busSeatTypeCode" => $fare['busSeatTypeCode']
            );
        }
        echo $this->api_model->saveTripFare($data);
    }
    
    function get_trip_fare(){
        $this->is_logged_in();
        
        $tripCode = $this->input->get('tripCode');
        $list = $this->api_model->loadTripFareDetails(array(
            'tripCode' => $tripCode,
        ));        
        $list = json_decode($list);
        
        $stypes = array();
        foreach($list->data[0]->stageFare as $stype ) {
          $stypes[] = array ( 
                'type' => $stype->seatType,
                'name' => $stype->seatName
            );      
        }

        $formatted = array();
        foreach($list->data as $stage) {
            $t = array(
               'fromCode'=>  $stage->fromStation->code,
               'fromName'=>  $stage->fromStation->name,
               'toCode'=>  $stage->toStation->code,
               'toName'=>  $stage->toStation->name,                
            );
            
            foreach($stage->stageFare as $stype ) {
                $t['stageFare'][$stype->seatType] = $stype;
            }            
            $formatted[] = $t;
        }
        
        //print_r($formatted);die;
        
        $data = array(
            'seatTypes' => $stypes,
            'fares' => $formatted
        );
        $this->load->view('site/search/fare-list', $data);
    }
    
    
    
    
    function save_trip_quota() {
        $seatCode = $this->input->post('seats');        
        $bcodeary = array();
        foreach ($seatCode AS $bcode) {
            $bcodeary[] = array(
                'code' => $bcode
            );
        }
        $data = array(
            "tripCode" => $this->input->post('tripCode'),
            //"bus" => array('code' => 'BSG5CF566'),
            "busSeatLayout" => $bcodeary,   
            "roleType" => 'UR',
            "visibilityType" => 'ACAT',            
            "activeFlag" => 1,
            "releaseMinutes" => $this->input->post('releaseminute'),
            "user" => array('code' => $this->input->post('user')),
            "remarks" => $this->input->post('remarks')
        );

        if(has_action_rights('ROUTE-QUOTA')) {
            $data['roleType'] = $this->input->post('scope');

            $route = $this->input->post('route');
            if($data['roleType'] == 'SG' && $route != '') {
                $route =  explode('-', $route);
                $from = $route[0];
                $to = $route[1];
                $data['fromStation'] = array('code' => $from);
                $data['toStation'] = array('code' => $to);
                unset($data['user']);
            }
        }
        
        echo $this->api_model->allocateTripQuota($data);
    }
    
    function block_trip_quota() {
        $seatCode = $this->input->post('seats');        
        $bcodeary = array();
        foreach ($seatCode AS $bcode) {
            $bcodeary[] = array(
                'code' => $bcode
            );
        }   
        
        if($this->input->post('user') != "") {  
            $data = array(
                "tripCode" => $this->input->post('tripCode'),
                "busSeatLayout" => $bcodeary,   
                "roleType" => 'UR',
                "visibilityType" => 'HIDE',            
                "activeFlag" => 1,
                "releaseMinutes" => $this->input->post('releaseminute'),
                "user" => array('code' => $this->input->post('user')),
                "remarks" => $this->input->post('remarks')
            );
        } else {
            $data = array(
                "tripCode" => $this->input->post('tripCode'),
                "busSeatLayout" => $bcodeary,   
                "roleType" => 'GR',
                "visibilityType" => 'HIDE',            
                "activeFlag" => 1,
                "releaseMinutes" => $this->input->post('releaseminute'),
                "remarks" => $this->input->post('remarks')
            );
        }

        if(has_action_rights('ROUTE-QUOTA')) {
            $data['roleType'] = $this->input->post('scope');

            $route = $this->input->post('route');
            if($data['roleType'] == 'SG' && $route != '') {
                $route =  explode('-', $route);
                $from = $route[0];
                $to = $route[1];
                $data['fromStation'] = array('code' => $from);
                $data['toStation'] = array('code' => $to);
                unset($data['user']);
            }
        }
        
        echo $this->api_model->allocateTripQuota($data);
    }
    
    function delete_trip_quota() {        
        $this->is_logged_in();
        
        $seatCode = $this->input->post('seats');
        
        $bcodeary = array();
        foreach ($seatCode AS $bcode) {
            $bcodeary[] = array(
                'code' => $bcode
            );
        }   
        
        $data = array(
            "tripCode" => $this->input->post('tripCode'),
            //"bus" => array('code' => 'BSG5CF566'),            
            "busSeatLayout" => $bcodeary,
            "roleType" => 'UR',
            "visibilityType" => "REL",            
            "activeFlag" => 1,
        );
        //print_r($data);
        echo $this->api_model->allocateTripQuota($data);  
    }
    
    function validate_offline_discount() {
        $this->is_logged_in();

        $seats = $this->input->post('seats');
        $seatCode = $this->input->post('seatCode');
        $seatFare = $this->input->post('seatFare');

        $emailaddress = $this->input->post('emailaddress');
        $phone = $this->input->post('phone');
        
        $toStation = $this->input->post('toStation');
        $fromStation = $this->input->post('fromStation');
        $tripCode = $this->input->post('tripCode');
        $tripDate = $this->input->post('tripDate');
        
        $phoneBooking = $this->input->post('phonebooking');
        $ticketcode = $this->input->post('ticketpnr');
        
        
        foreach ($seats as $seat) {
            $passenger [] = array(
                'seatCode' => $seat ['code'],
                'seatFare' => $seat ['fare'],
                'seatName' => $seat ['seatname']
            );
        }

        $booking = array(
            'ticketDetails' => $passenger,
            'journeyType' => 'OW',
            
            'tripCode' => $this->input->post('tripCode'),
            'fromStation' => array( 'code' => $this->input->post('fromStation') ),
            'toStation' => array( 'code' => $this->input->post('toStation') ),
            'travelDate' => date('Y-m-d', strtotime($this->input->post('tripDate'))),

            //'tripStageCode' => $this->input->post('stageCode')
        );

       
        if (isset($phoneBooking) && $phoneBooking != '' && $phoneBooking == 1) {
            $phoneBooking = "true";
        } else {
            $phoneBooking = "false";
        }

        $bookingTicket = array(
            'emailId' => strtolower($emailaddress),
            'mobileNumber' => $phone,
            'orderDetails' => array(
                $booking
            )
        );        
        echo $result = $this->api_model->validateOfflineDiscount($bookingTicket);
    }
    
    function get_trip_stage_boardingpoints() {
        $this->is_logged_in();
        $param = array(
            'tripCode' => $this->input->post('tripCode'),
        );
        $json = $this->api_model->getTripStagesBoardingPoints($param);
        $json = json_decode($json);
        foreach ($json->data as $stations) {
            usort($stations->fromStation->stationPoint, function($a, $b) { 
                return strtotime($a->dateTime) < strtotime($b->dateTime) ? -1 : 1; 
            }); 
        }
        echo json_encode($json);
    }
    
    function get_fleet_live_feed() {
        $this->is_logged_in();
        $param = array(
            'tripCode' => $this->input->post('tripCode'),
            'deviceCode' => $this->input->post('deviceCode'),
            'operatorCode' => _get_namespace_id()
        );
        
        $json = $this->api_model->getFleetGPSFeed($param);        
        $json = json_decode($json);
        
        $data = array();
        $data['status'] = $json->status;
        if($json->status==1) {
            $data['status'] = $json->status;
            $data['latitude'] = $json->data->latitude;
            $data['longitude'] = $json->data->longitude;
            $data['updatedTime'] = $json->data->updatedTime;
            $data['registationNumber'] = $json->data->registationNumber;
            $data['speed'] = $json->data->speed;
            $data['address'] = $json->data->address;
            $data['ignition'] = $json->data->ignition;
        }
        echo json_encode($data);
    }
    
    function change_travel_status(){
        $this->is_logged_in();
        echo $this->api_model->changeTravelStatus(array(
            'ticketCode' => $this->input->post('ticketCode'),
            'travelStatus' => $this->input->post('travelStatus'),
            'seatCodes' => $this->input->post('seatCodes')
        ));
    }
    
    function get_detailed_quota(){
        $this->is_logged_in();
        $tripCode = $this->input->get('tripCode');
        $list = $this->api_model->loadTripQuotaDetails(array(
            'tripCode' => $tripCode,
        ));        
        $list = json_decode($list);        
        $data = array(
            'quota' => $list->data
        );
        $this->load->view('site/search/quota-list', $data);
    }
    
    public function print_mini_sheet() {
        $this->load->exclude_template();
        $tck_code = $this->input->get('pnrCode');

        $ticket = $this->api_model->ticketDetails(array(
            'ticketCode' => $tck_code
        ));
        $tck = json_decode($ticket);
        $data ['tck'] = $tck->data;

        $this->load->view('site/search/print-mini-sheet', $data);
    }
    function delete_detailed_quota() {
        $this->is_logged_in();        
        $param = $this->input->post('quota');
     
        $data = array(
            'activeFlag' => 2,
            'remarks' => $param['remarks'],
            'fromStation' => array(
                'code' => $param['fromStation']['code']
            ),
            'toStation' => array(
                'code' => $param['toStation']['code']
            ),
            'trip' => array(
                'tripCode' => $this->input->post('tripCode')
            ),
            'user' => array(
                'code' => $param['user']['code']
            ),
            'relaseMinutes' => $param['relaseMinutes'],
            'quotaDetails' => array($param['quotaSeat'])
        );   
        echo $this->api_model->addDetailedQuota($data);
    }    
    function add_detailed_quota(){
        $this->is_logged_in();        
        $param = array(
            'activeFlag' => 1,
            'remarks' => $this->input->post('remarks'),
            'fromStation' => array(
                'code' => $this->input->post('fromStation')
            ),
            'toStation' => array(
                'code' => $this->input->post('toStation')
            ),
            'trip' => array(
                'tripCode' => $this->input->post('tripCode')
            ),
            'user' => array(
                'code' => $this->input->post('user')
            ),
            'relaseMinutes' => $this->input->post('releaseminute'),
            'quotaDetails' => $this->input->post('seats')
        );        
        echo $this->api_model->addDetailedQuota($param);
    }

    public function customer_gst_invoice_pdf() {
        //$this->is_logged_in();
        require_once APPPATH.'third_party/tcpdf/tcpdf.php';
        
        $tck_code = $this->input->get('pnrCode');

        // Get ticket Details
        $ticket = $this->api_model->ticketDetails(array(
            'ticketCode' => $tck_code
        ));
        $tck = json_decode($ticket);
        $data ['tck'] = $tck->data;

        $gst = $this->api_model->customerGstDetails(array(
            'ticketCode' => $tck_code
        ));
        $gst = json_decode($gst);
        $data ['gst'] = $gst->data;

        $pdf = new TCPDF();
        $pdf->SetTitle('GST Invoice');
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->SetFont('helvetica', '', 9);
        $pdf->SetMargins(10, 15, 10, true);
        $pdf->AddPage();

        ob_clean();
        $this->load->exclude_template();
        $content = $this->load->view('site/search/customer-gst-invoice-pdf', $data, true);

        $pdf->writeHTML($content);

        $pdf->Output('Tax-Invoice-'.$tck_code.'.pdf', 'd');
    }

    function transfer_ticket_search() {
        $this->load->exclude_template();
        $this->load->view('site/search/transfer-ticket');
    }

    function get_detailed_gender_preference(){
        $this->is_logged_in();
        $tripCode = $this->input->get('tripCode');
        $list = $this->api_model->loadTripGenderPreference(array(
            'tripCode' => $tripCode,
        ));
        $list = json_decode($list);
        $data = array(
            'preference' => $list->data
        );
        $this->load->view('site/search/gender-preference-list', $data);
    }

    function set_detailed_gender_preference(){
        $this->is_logged_in();
        $data = array(
            "activeFlag" => 1,
            'code' => $this->input->post('code') ?: '',
            'tripCode' => $this->input->post('tripCode'),
            "busSeatLayout" =>$this->input->post('busSeatLayout') ?: [],
            'preferenceGendar' => $this->input->post('preferenceGendar') ?: '',
            'groupList' => $this->input->post('groupList') ?: []
        );
        
        echo $this->api_model->setTripGenderPreference($data);
    }

    function delete_detailed_gender_preference() {
        $this->is_logged_in();
        $data = array(
            "activeFlag" => 2,
            'code' => $this->input->post('code') ?: '',
            'tripCode' => $this->input->post('tripCode'),
            "busSeatLayout" =>$this->input->post('busSeatLayout') ?: [],
            'preferenceGendar' => $this->input->post('preferenceGendar') ?: '',
            'groupList' => $this->input->post('groupList') ?: []
        );

        echo $this->api_model->deleteTripGenderPreference($data);
    }

    function email_ticket() {
        $this->is_logged_in();
        echo $this->api_model->sendEmailTicket(array(
            'pnr' => $this->input->post('pnr'),
            'emailId' => $this->input->post('email'),
            'type' => $this->input->post('type'),
        ));
    }

    function validate_phone_boooking() {
        $this->is_logged_in();
        
        echo $this->api_model->validatePhoneBooking(array(
            'phone' => $this->input->post('phone')
        ));
    }
}
