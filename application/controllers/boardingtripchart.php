<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class BoardingTripchart extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->is_logged_in();
        redirect('user/dashboard');
    }

 
    public function boarding_tripchart() {
        $this->is_logged_in();
        $tripCode = $this->input->post('tripCode');
        _include_js('assets/js/pages/bordingpoint_trip_chart.js', '_init_btrip_chart_page');
        $this->load->view('site/tripchart/boarding-trip-chart');
    }

    public function boarding_trip_list() {
        $this->is_logged_in();
        $tripDate = $this->input->post('tripDate');
                                
        //$tripList = $this->api_model->getTripList(array('tripDate' => $tripDate));
        if (strtotime($tripDate) < strtotime('today')) {
            $tripList = $this->api_model->getScheduleTripFromHistory(array('tripDate' => $tripDate));
            $tripList = json_decode($tripList);
            $tripList->data = json_decode($tripList->data);
        } else {
            $tripList = $this->api_model->getScheduleTrip(array('tripDate' => $tripDate));
            $tripList = json_decode($tripList);
        }
        $tripList = $tripList->data;        
        
        //  collect missed spl trips
//        $datediff = time() - strtotime($tripDate);        
//        $datediff = floor($datediff / (60 * 60 * 24));
//        if( $datediff > 0 ) {   
//            $tmp = $this->api_model->getScheduleTripFromHistory(array('tripDate' => $tripDate));
//            $tmptriphisList = json_decode($tmp);           
//            $triphisList = json_decode($tmptriphisList->data); 
//            
//            $acttrip = array();
//            foreach($tripList as $trip) {
//                $acttrip[$trip->tripCode] = 1;
//            }        
//            
//            $histrip = array();
//            foreach($triphisList as $trip) {
//                if( !isset($acttrip[$trip->tripCode]) ) {
//                    $histrip[] = $trip;
//                }
//            }
//        }
        
        //  grouping based on category
        $tmp = array();
        foreach($tripList as $trip) {
            $trip->fromStationTimestamp = strtotime($trip->stageList[0]->fromStation->dateTime);
            $trip->busTypeName = bus_category_string($trip->bus->categoryCode);
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
//        if(count($histrip) > 0) {
//            usort($histrip, '_orderby_time');
//            $sorted['[ Others ]'] = $histrip;
//        }
        
        $data['trips'] = $sorted;
        _include_js('assets/js/pages/bordingpoint_trip_chart.js');
        $this->load->view('site/tripchart/boarding-trip-list', $data);
    }

    public function boarding_trip_driver_list() {
        $this->is_logged_in();
        $list = $this->api_model->getVehicleDriver();
        $list = json_decode($list);
        $formated_list = array();
        foreach ($list->data as $driver) {
            array_push($formated_list, array(
                'driverName' => $driver->name,
                'driverMobile' => $driver->mobileNumber,
                'tokens' => explode(' ', $driver->name)
            ));
        }
        echo json_encode($formated_list);
    }

    public function boarding_trip_attender_list() {
        $this->is_logged_in();
        $list = $this->api_model->getVehicleAttendant();
        $list = json_decode($list);
        $formated_list = array();
        foreach ($list->data as $driver) {
            array_push($formated_list, array(
                'driverName' => $driver->name,
                'driverMobile' => $driver->mobile,
                'tokens' => explode(' ', $driver->name)
            ));
        }
        echo json_encode($formated_list);
    }

    public function boarding_trip_chart_list() {
        $this->is_logged_in();
        $tripCode = $this->input->get('tc'); //tripCode
                
        $p_key = _get_namespace_id().'_TRIPCHART_'.$tripCode;        
        if( $this->input->get('print') == 1 ) { // serve print page data from cache
            if( !$tripChartList = $this->rediscache->get($p_key)) {
                $tripChartList = $this->api_model->getTripChart(array('tripCode' => $tripCode));
                $this->rediscache->set($p_key, $tripChartList, 600);    //  10 mins
            }  
        } else {
            $tripChartList = $this->api_model->getTripChart(array('tripCode' => $tripCode));
            $this->rediscache->set($p_key, $tripChartList, 600);    //  10 mins
        }
        
        $tripChartList = json_decode($tripChartList);
        
        if ($tripChartList->status == 1) {
            $tripChartList = $tripChartList->data;
            
            $bp = array();
            $a_tmp = array();
            $a_code = array();
            foreach ($tripChartList->trip->stageList as $stages) {
                foreach ($stages->fromStation->stationPoint as $points) {
                    if( !in_array($points->code, $a_code)) {
                        $bp[] = array(
                                'code'=>$points->code,
                                'name'=>$points->name,
                                'landmark'=>$points->landmark,
                                'stageName' => $stages->fromStation->name,
                                'timestamp' => strtotime($points->dateTime),
                                'time'=> date('g:i A', strtotime($points->dateTime))
                            );
                        $a_tmp[] = strtotime($points->dateTime);
                        $a_code[] = $points->code;
                    }
                }
            }
            array_multisort($a_tmp, SORT_ASC, $bp);
            $bp[] = array(
                'code'=>'Others',
                'name'=>'Others',
                'stageName' => 'Others',
                'timestamp' => '',
                'time'=> ''
            );
            
            
            $dp = array();
            $da_tmp = array();
            $da_code = array();

            $last_station_time = 0;
            $last_station_data = array();
            foreach ($tripChartList->trip->stageList as $stages) {
                foreach ($stages->toStation->stationPoint as $points) {
                    if( !in_array($points->code, $da_code)) {
                        $dp[] = array(
                                'code'=>$points->code,
                                'name'=>$points->name,
                                'stageName' => $stages->toStation->name,
                                'timestamp' => strtotime($points->dateTime),
                                'time'=> date('g:i A', strtotime($points->dateTime))
                            );
                        $da_tmp[] = strtotime($points->dateTime);
                        $da_code[] = $points->code;
                    }
                }
                if(strtotime($stages->toStation->dateTime) >= $last_station_time) {
                    $last_station_time = strtotime($stages->toStation->dateTime);
                    $last_station_data = $stages->toStation;
                }
            }
            array_multisort($da_tmp, SORT_ASC, $dp);
            $dp[] = array(
                'code'=>'Others',
                'name'=>'Others',
                'stageName' => 'Others',
                'timestamp' => '',
                'time'=> ''
            );
             
            //ksort($bp); //  sort points by time.
            
            $seat_seq[] = array();
            foreach ($tripChartList->trip->bus->seatLayoutList as $seat) {                
                $seat_seq[$seat->seatName] = $seat->sequence;
             }
            
            $bus = array();
            $ticket = array();
            $tick = array();
            $booked_seat_name = array();
            $un_booked_Seats = array(); 
            $route_seat_count = array();
            foreach ($tripChartList->ticketDetailsList as $tpch) {
                $tpch->sequence = $seat_seq[$tpch->seatName];
                $booked_seat_name[] = $tpch->seatName;
                $ticket[$tpch->fromStation->name][$tpch->boardingPoint->name][] = $tpch->seatName;
                $userBookings[$tpch->bookedBy->name][] = array('seatName' => $tpch->seatName, 'seatFare' => $tpch->seatFare+$tpch->acBusTax);
                
                $bp_booking[$tpch->boardingPoint->code][] = $tpch;
                $bp_booking_seats[$tpch->seatName] = $tpch;
                $bp_booking_seat_seq[$tpch->boardingPoint->code][] = $tpch->sequence;
                
                $dp_booking[$tpch->droppingPoint->code][] = $tpch;
                $dp_booking_seat_seq[$tpch->droppingPoint->code][] = $tpch->sequence;
                
                $bookedSeat[] = $tpch->seatName;
                $bookedGender[$tpch->seatName] = $tpch->gender;
                
                $rte = $tpch->fromStation->name.' - '.$tpch->toStation->name;
                if(isset($route_seat_count[$rte])) {
                    $route_seat_count[$rte] +=1;
                } else {
                    $route_seat_count[$rte] = 1;
                }
            }
            
            //  sort seats based on seat squence with in a boarding point.
            if(count($bp_booking) > 0){
                foreach ($bp_booking as $bpcode => $bookings) {
                    array_multisort($bp_booking_seat_seq[$bpcode], SORT_ASC, $bp_booking[$bpcode]);
                    if(has_action_rights('SORT-PAX-BY-MOBILE')) {
                        usort($bp_booking[$bpcode], function($a, $b) { 
                            return $a->passengerMobile < $b->passengerMobile ? -1 : 1; 
                        });
                    }  
                }
            }
            
            
            if(count($dp_booking) > 0){
                foreach ($dp_booking as $dpcode => $droppings) {
                    array_multisort($dp_booking_seat_seq[$dpcode], SORT_ASC, $dp_booking[$dpcode]);
                }
            }
            
            $quotaSeats = $this->api_model->loadTripQuotaDetails(array(
                'tripCode' => $tripCode,
            ));        
            $quotaSeats = json_decode($quotaSeats); 
            $quotaSeats = $quotaSeats->data;
            
            usort($quotaSeats, function($a, $b) { 
                return $a->quotaSeat->seatName < $b->quotaSeat->seatName ? -1 : 1; 
            });
                    
            $quota_seat_name = array();
            foreach ($quotaSeats as $quota) {
                $quota_seat_name[] = $quota->quotaSeat->seatName;
            }
                        
            foreach ($tripChartList->trip->bus->seatLayoutList as $seat) {
                if(!in_array($seat->seatName, $booked_seat_name) && !in_array($seat->seatName, $quota_seat_name)) {
                    $un_booked_Seats_tmp[] = $seat->seatName;
                    $un_booked_Seats[] = array( 'seatName'=>$seat->seatName, 'sequence'=>$seat->sequence );
                    $un_booking_seat_seq[] = $seat->sequence;
                }
            }
            //  sort vacant seats with seat sequence
            array_multisort($un_booking_seat_seq, SORT_ASC, $un_booked_Seats);
            //asort($un_booked_Seats);

            $data = array(
                'points' => $bp,
                'points_dp' => $dp,
                'bp_books' => $bp_booking,
                'bp_books_seats' => $bp_booking_seats,
                'dp_books' => $dp_booking,
                'trips' => $tripChartList->trip,
                'tripCode' => $tripCode,
                'ticketList' => $ticket,
                'bookinglist' => $userBookings,
                'unbookedlist' => $un_booked_Seats,
                'unbooked_seat_names' => implode(', ', $un_booked_Seats_tmp),
                'bookedSeat' => $bookedSeat,
                'bookedGender' => $bookedGender,
                'minutesForFirstBoarding' => round(($bp[0]['timestamp'] - time()) /60),
                'vehicle_nunmber' => $tripChartList->busVehicle->registationNumber,
                'route_seat_count' => $route_seat_count,
                'quotaSeats' => $quotaSeats,
                'quotaSeatsList' => $quota_seat_name
            );


            $id = count($tripChartList->trip->stageList);
            $data['from'] = $tripChartList->trip->stageList[0]->fromStation->name;
            $data['to'] = $tripChartList->trip->stageList[$id - 1]->toStation->name;
            $data['last_station_data'] = $last_station_data;
            $data['from_time'] = $tripChartList->trip->stageList[0]->fromStation->dateTime;
            $data['category'] = bus_category_string($tripChartList->trip->bus->categoryCode);
            $data['totalSeatCount'] = count($tripChartList->trip->bus->seatLayoutList);
            $data['totalBookedCount'] = count($tripChartList->ticketDetailsList);
            $data['data'] = $tripChartList;
            $buslayers = $tripChartList->trip->bus;
            $data['layers'] = $buslayers->seatLayoutList;
            $data['seatvisiblelists'] = array();

            $l1x = array();
            $l1x = array();
            $l2x = array();
            $l2y = array();
            foreach ($buslayers->seatLayoutList AS $buslay) {
                if ($buslay->layer == 1) {
                    $l1x[] = $buslay->rowPos;
                    $l1y[] = $buslay->colPos;
                }
                if ($buslay->layer == 2) {
                    $l2x[] = $buslay->rowPos;
                    $l2y[] = $buslay->colPos;
                }
            }
            // X- Axis Y - Axis layer 1
            if (is_array($l1x) && is_array($l1y) && count($l1x) > 0 && count($l1y) > 0) {

                $data['xmaxl1'] = max($l1x);
                $data['xminl1'] = min($l1x);

                $data['ymaxl1'] = max($l1y);
                $data['yminl1'] = min($l1y);
            }
            // X- Axis Y - Axis layer 2
            if (is_array($l2x) && is_array($l2y) && count($l2x) > 0 && count($l2y) > 0) {
                $data['xmaxl2'] = max($l2x);
                $data['xminl2'] = min($l2x);

                $data['ymaxl2'] = max($l2y);
                $data['yminl2'] = min($l2y);
            }

            $name = array();
            $seatcode = array();
            foreach ($buslayers->seatLayoutList as $lay) {
                $name[$lay->layer][$lay->rowPos][$lay->colPos] = $lay->seatName;
                $seatcode[$lay->layer][$lay->rowPos][$lay->colPos] = $lay->busSeatType->code;
            }
            $data['name'] = $name;
            $data['seatcode'] = $seatcode;
            
            //  calculate settlement
            $param = array(
                'queryCode' => 'RQH46D5515',
                'tripCode' => $tripCode         
            );
            $result = $this->api_model->getDynamicReportDataWithMap($param);
            $result = json_decode($result);
            
            if ($result->status == 1) {
                if (is_array($result->data)) {
                    $ticket_count = count($result->data);
                    for ($i = 0; $i < $ticket_count; $i++) {
                        if( strtolower($result->data[$i]->user_group_name) == 'customer' ) {
                            $result->data[$i]->user_first_name = "Customer";
                        }
                        
                        if ($result->data[$i]->transaction_type == 'BO' || $result->data[$i]->transaction_type == 'PBL') {
                            if ($result->data[$i]->transaction_type == 'BO') {
                                $tickets[$result->data[$i]->user_first_name]['bo_seats'] += $result->data[$i]->seat_count;
                            }
                            
                            if ($result->data[$i]->transaction_type == 'PBL') {
                                $tickets[$result->data[$i]->user_first_name]['pbl_seats'] += $result->data[$i]->seat_count;
                            }
                            
                            $tickets[$result->data[$i]->user_first_name]['bo_fare'] += $result->data[$i]->ticket_amount;
                            $tickets[$result->data[$i]->user_first_name]['bo_discount'] += $result->data[$i]->addon_amount;
                            $tickets[$result->data[$i]->user_first_name]['bo_comission'] += $result->data[$i]->commission_amount;
                            $tickets[$result->data[$i]->user_first_name]['bo_ac_tax'] += $result->data[$i]->ac_bus_tax;
                            $tickets[$result->data[$i]->user_first_name]['bo_seats_names'][] = trim($result->data[$i]->seat_name);
                        } else {
                            $tickets[$result->data[$i]->user_first_name]['ca_seats'] += $result->data[$i]->seat_count;
                            $tickets[$result->data[$i]->user_first_name]['ca_charges'] += $result->data[$i]->cancellation_charges;
                            $tickets[$result->data[$i]->user_first_name]['ca_share'] += $result->data[$i]->cancel_commission;
                        }
                    }
                    
                    foreach($tickets as $k => $v) {
                        $t = ( $v['bo_fare'] + $v['bo_ac_tax'] + $v['ca_charges']) - ( $v['bo_discount'] + $v['bo_comission'] + $v['ca_share'] );
                        $tickets[$k]['payable'] = $t;
                        $tickets[$k]['bo_seats_names'] = implode(' ,', $tickets[$k]['bo_seats_names']);                        
                    }
                    ksort($tickets);
                }
            }            
            $data['settlement'] = $tickets;            
            //  calculate settlement - End
            
        } else {
            $data = array('api_error' => 1);
        }
            
        if ($this->input->get('print') == 1 && $this->input->get('mini') == 1) {  //  print mini trip chart without vacant seat, bus map and agent info
            $this->load->exclude_template();
            $this->load->view('site/tripchart/boarding-mini-trip-chart-print', $data);
        }else if ($this->input->get('print') == 1 && $this->input->get('medium') == 1) {  //  print medium trip chart without vacant seat, bus map and agent info
            $this->load->exclude_template();
            $data['medium'] = 1;
            $data['namespace_name'] = $this->session->userdata('namespace_name');
            $this->load->view('site/tripchart/boarding-singlepage-trip-chart-print', $data);
        }else if ($this->input->get('print') == 1 && $this->input->get('rto') == 1 && $this->input->get('novia') == 1) {  //  print rto trip chart without via route
            $this->load->exclude_template();
            $data['namespace_name'] = $this->session->userdata('namespace_name');
            $this->load->helper('cookie');
            $data['rto'] = json_decode(get_cookie('rtofields'));
            $this->load->view('site/tripchart/boarding-rto-trip-chart-print-withoutvia', $data);
        }else if ($this->input->get('print') == 1 && $this->input->get('rto') == 1) {  //  print rto trip chart
            $this->load->exclude_template();
            $data['medium'] = 1;
            $data['namespace_name'] = $this->session->userdata('namespace_name');
            
            $this->load->helper('cookie');
            $rto = json_decode(get_cookie('rtofields'));
            $col_count = 2;
            if($rto->booked_at==1) $col_count++;
            if($rto->booked_by==1) $col_count++;
            if($rto->pass_name==1) $col_count++;
            if($rto->pass_age==1) $col_count++;
            if($rto->pass_gender==1) $col_count++;
            if($rto->pass_contact==1) $col_count++;
            if($rto->from_station==1) $col_count++;
            if($rto->to_station==1) $col_count++;
            if($rto->boarding_pt==1) $col_count++;
            if($rto->booked_type==1) $col_count++;
            if($rto->fare==2) $col_count++;
            
            $data['col_count'] = $col_count;
            $data['rto'] = $rto;
            
            $this->load->view('site/tripchart/boarding-rto-trip-chart-print', $data);
        }else if ($this->input->get('print') == 1 && $this->input->get('layout') == 1) {  //  print bus layout grid
            $this->load->exclude_template();            
            $data['namespace_name'] = $this->session->userdata('namespace_name');
            $this->load->view('site/tripchart/boarding-layout-chart-print', $data);
        }else if ($this->input->get('print') == 1) {   //  print detailed trip chart.
            $this->load->exclude_template();
            $data['medium'] = 0;
            $this->load->view('site/tripchart/boarding-trip-chart-print', $data);
        } else if ($this->input->get('more') == 1) {
            $data['travel_status'] = $this->config->item('travel_status');
            echo $this->load->view('site/tripchart/boarding-trip-chart-more', $data);
        } else {    //  screen view
            // Get vehicle assigned to this trip
            $result = $this->api_model->getVehicleInfo(array('tripCode' => $tripCode));
            $result = json_decode($result);
            $data['vehicle_info'] = $result->data;

            // Get namespace vehicle info
            $get_vehicle = $this->api_model->getVehicle(array('authtoken' => $this->_user_hash));
            $vehicle = json_decode($get_vehicle);
            $data['ns_vehicle'] = $vehicle->data;
            
            //Get Driver Details
            $result = $this->api_model->getVehicleDriver();
            $result = json_decode($result);
            $data['current_date'] = $result->datetime;
            $data['drivers'] = $result->data;
            
            //Get Attenders Detais
            $result = $this->api_model->getVehicleAttendant();
            $result = json_decode($result);
            $data['attenders'] = $result->data;
            
            _include_js('assets/js/pages/bordingpoint_trip_chart.js', '_init_bchart_page');
            $this->load->view('site/tripchart/boarding-trip-chart-list', $data); // totalSeatCount
        }
    }

    //
    //    public function agent_report() {
    //        $this->is_logged_in();
    //        $this->load->view('site/report/agent_report');
    //    }
    public function boarding_send_trip_sms() {
        $this->is_logged_in();
        $data = array(
            'tripCode' => $this->input->post('trip_code'),
            'message' => $this->input->post('sms_content')
        );
        echo $this->api_model->sendTripSMSNotification($data);
    }

    public function boarding_save_chart_info() {
        $this->is_logged_in();
        $data = array(
            'tripCode' => $this->input->post('trip_code'),
            'driverName' => $this->input->post('driver_name'),
            'driverMobile' => $this->input->post('driver_phone'),
            'remarks' => $this->input->post('remarks'),
        );
        if ($this->input->post('vehicle') != '') {
            $data['vehicle'] = $this->input->post('vehicle');
        }
        echo $this->api_model->updateTripDriveInfo($data);
    }
    
    public function agent_organizations() {
        $this->is_logged_in();
        $org = $this->api_model->getOrganization();
        $orgs = json_decode($org);
        $groups = array();
        foreach($orgs->data as $org) {
            $groups[] = array(
                'code' => $org->code,
                'name' => $org->name,
                'userCount' => $org->userCount,
            );
        }
        echo json_encode($groups);
    }
    
    function agent_payment_sheet_print() {
        $this->is_logged_in();
        $organizationuser = $this->api_model->getUserByOrganization(array('organizationcode' => $this->input->get('ag')));
        $organizationuser = json_decode($organizationuser);
        
        $amounts = array();
        foreach($organizationuser->data as $user){
           $data = array(
                'queryCode' => 'RQG6QM3610',
                'toDate' => $this->input->get('date'),
                'fromDate' => $this->input->get('date'),
                'userCode' => $user->code,
            );
                 
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $result = json_decode($result);
            $tickets = array();
            
            
            $tickets['agent_name'] = $user->name;
            $tickets['user'] = $this->session->userdata('user_name');
            $tickets['date'] = date('Y-m-d H:i:s');
            
            $tickets['bo_fare'] = '';
            $tickets['bo_comission'] = '';
            $tickets['bo_ac_tax'] = '';
            $tickets['bo_payable'] = '';

            $tickets['ca_fare'] = '';
            $tickets['ca_charges'] = '';
            $tickets['ca_share'] = '';
            $tickets['ca_refund'] = '';
            

            if ($result->status == 1) {
                if (is_array($result->data)) {
                    $ticket_count = count($result->data);
                    for ($i = 0; $i < $ticket_count; $i++) {
                        if ($result->data[$i]->transaction_type == 'BO') {

                            $tickets['bo_fare'] += $result->data[$i]->ticket_amount;
                            $tickets['bo_comission'] += $result->data[$i]->commission_amount;
                            $tickets['bo_ac_tax'] += $result->data[$i]->ac_bus_tax;
                            $result->data[$i]->payable = ($result->data[$i]->ticket_amount+$result->data[$i]->ac_bus_tax-$result->data[$i]->commission_amount);
                            $tickets['bo_payable'] += $result->data[$i]->payable;

                            $tickets['booking'][] = $result->data[$i];
                        } else {
                            $tickets['ca_fare'] += $result->data[$i]->ticket_amount;
                            $tickets['ca_charges'] += $result->data[$i]->cancellation_charges;
                            $tickets['ca_share'] += $result->data[$i]->cancel_commission;
                            $result->data[$i]->refund = ($result->data[$i]->ticket_amount-$result->data[$i]->cancellation_charges);
                            $tickets['ca_refund'] += $result->data[$i]->refund;

                            $tickets['cancel'][] = $result->data[$i];
                        }

                        $tickets['total_fare'] += $result->data[$i]->ticket_amount;
                        $tickets['total_refund'] += $result->data[$i]->refund_amount;
                        $tickets['total_cancellation'] += $result->data[$i]->cancellation_charges;
                    }
                }
            } 
            
            $amounts[] = $tickets;
        }
        
        $this->load->exclude_template();
        $this->load->view('site/tripchart/agent-payment-sheet-print', array('tickets' => $amounts)); // totalSeatCount
    }
    

//    public function boarding_trip_chart_print() {
//
//        $this->load->exclude_template();
//
//        $tripCode = $this->input->get('tripCode'); //tripCode
//        $tripChartList = $this->api_model->getTripChart(array('tripCode' => $tripCode));
//        $tripChartList = json_decode($tripChartList);
//        $tripChartList = $tripChartList->data;
//        $bus = array();
//        $ticket = array();
//        foreach ($tripChartList->ticketDetailsList as $tpch) {
//            $bus[$tpch->seatName][] = $tpch;
//            $ticket[$tpch->boardingPoint->name][] = $tpch;
//        }
//        $data = array(
//            'trips' => $tripChartList->trip,
//            'Booking' => $bus,
//            'ticketList' => $ticket
//        );
//
//        $date_format = $this->session->userdata('date_format');
//        $time_format = $this->session->userdata('time_format');
//        if ($time_format == 12) {
//            $time_format = "h:i A";
//        } else {
//            $time_format = "G:i";
//        }
//        $id = count($tripChartList->trip->stageList);
//        $data['from'] = $tripChartList->trip->stageList[0]->fromStation->name;
//        $data['to'] = $tripChartList->trip->stageList[$id - 1]->toStation->name;
//        $data['time'] = gmdate("h:i A", ($tripChartList->trip->stageList[0]->fromStation->dateTime));
//        $data['date'] = date($date_format, ($tripChartList->trip->stageList[0]->fromStation->dateTime));
//        $data['category'] = bus_category_string($tripChartList->trip->bus->categoryCode);
//        $data['totalSeatCount'] = count($tripChartList->trip->bus->seatLayoutList);
//        $this->load->view('site/tripchart/boarding-trip-chart-print', $data); // totalSeatCount
//    }
//    public function boarding_mini_trip_chart_list() {
//    	$this->is_logged_in();
//    	$tripCode = $this->input->get('tc'); //tripCode
//    	$tripChartList = $this->api_model->getTripChart(array('tripCode' => $tripCode));
//    	$tripChartList = json_decode($tripChartList);
//    
//    	if ($tripChartList->status == 1) {
//    		$tripChartList = $tripChartList->data;
//    
//    		$bp = array();
//    		$a_tmp = array();
//    		$a_code = array();
//    		foreach ($tripChartList->trip->stageList as $stages) {
//    			foreach ($stages->fromStation->stationPoint as $points) {
//    				if( !in_array($points->code, $a_code)) {
//    					$bp[] = array(
//    							'code'=>$points->code,
//    							'name'=>$points->name,
//    							'stageName' => $stages->fromStation->name,
//    							'timestamp' => strtotime($points->dateTime),
//    							'time'=> date('g:i A', strtotime($points->dateTime))
//    					);
//    					$a_tmp[] = strtotime($points->dateTime);
//    					$a_code[] = $points->code;
//    				}
//    			}
//    		}
//    		array_multisort($a_tmp, SORT_ASC, $bp);
//    		$bp[] = array(
//    				'code'=>'Others',
//    				'name'=>'Others',
//    				'stageName' => 'Others',
//    				'timestamp' => '',
//    				'time'=> ''
//    		);
//    		//ksort($bp); //  sort points by time.
//    
//    		$bus = array();
//    		$ticket = array();
//    		$tick = array();
//    		$booked_seat_name = array();
//    		$un_booked_Seats = array();
//    		foreach ($tripChartList->ticketDetailsList as $tpch) {
//    			$booked_seat_name[] = $tpch->seatName;
//    			$ticket[$tpch->fromStation->name][$tpch->boardingPoint->name][] = $tpch->seatName;
//    			$userBookings[$tpch->bookedBy->name][] = array('seatName' => $tpch->seatName, 'seatFare' => $tpch->seatFare);
//    			$bp_booking[$tpch->boardingPoint->code][] = $tpch;
//    
//    			$bookedSeat[] = $tpch->seatName;
//    			$bookedGender[$tpch->seatName] = $tpch->gender;
//    		}
//    
//    		foreach ($tripChartList->trip->bus->seatLayoutList as $seat) {
//    			if(!in_array($seat->seatName, $booked_seat_name)) {
//    				$un_booked_Seats[] = $seat->seatName;
//    			}
//    		}
//    		//asort($un_booked_Seats);
//    
//    		$data = array(
//    				'points' => $bp,
//    				'bp_books' => $bp_booking,
//    				'trips' => $tripChartList->trip,
//    				'tripCode' => $tripCode,
//    				'ticketList' => $ticket,
//    				'bookinglist' => $userBookings,
//    				'unbookedlist' => $un_booked_Seats,
//    				'unbooked_seat_names' => implode(', ', $un_booked_Seats),
//    				'bookedSeat' => $bookedSeat,
//    				'bookedGender' => $bookedGender
//    		);
//    
//    
//    		$id = count($tripChartList->trip->stageList);
//    		$data['from'] = $tripChartList->trip->stageList[0]->fromStation->name;
//    		$data['to'] = $tripChartList->trip->stageList[$id - 1]->toStation->name;
//    		$data['from_time'] = $tripChartList->trip->stageList[0]->fromStation->dateTime;
//    		$data['category'] = bus_category_string($tripChartList->trip->bus->categoryCode);
//    		$data['totalSeatCount'] = count($tripChartList->trip->bus->seatLayoutList);
//    		$data['totalBookedCount'] = count($tripChartList->ticketDetailsList);
//    		$data['data'] = $tripChartList;
//    		$buslayers = $tripChartList->trip->bus;
//    		$data['layers'] = $buslayers->seatLayoutList;
//    		$data['seatvisiblelists'] = array();
//    
//    		$l1x = array();
//    		$l1x = array();
//    		$l2x = array();
//    		$l2y = array();
//    		foreach ($buslayers->seatLayoutList AS $buslay) {
//    			if ($buslay->layer == 1) {
//    				$l1x[] = $buslay->rowPos;
//    				$l1y[] = $buslay->colPos;
//    			}
//    			if ($buslay->layer == 2) {
//    				$l2x[] = $buslay->rowPos;
//    				$l2y[] = $buslay->colPos;
//    			}
//    		}
//    		// X- Axis Y - Axis layer 1
//    		if (is_array($l1x) && is_array($l1y) && count($l1x) > 0 && count($l1y) > 0) {
//    
//    			$data['xmaxl1'] = max($l1x);
//    			$data['xminl1'] = min($l1x);
//    
//    			$data['ymaxl1'] = max($l1y);
//    			$data['yminl1'] = min($l1y);
//    		}
//    		// X- Axis Y - Axis layer 2
//    		if (is_array($l2x) && is_array($l2y) && count($l2x) > 0 && count($l2y) > 0) {
//    			$data['xmaxl2'] = max($l2x);
//    			$data['xminl2'] = min($l2x);
//    
//    			$data['ymaxl2'] = max($l2y);
//    			$data['yminl2'] = min($l2y);
//    		}
//    
//    		$name = array();
//    		$seatcode = array();
//    		foreach ($buslayers->seatLayoutList as $lay) {
//    			$name[$lay->layer][$lay->rowPos][$lay->colPos] = $lay->seatName;
//    		}
//    		$data['name'] = $name;
//    	} else {
//    		$data = array('api_error' => 1);
//    	}
//    
//    
//    	if ($this->input->get('print') == 1) {
//    		$this->load->exclude_template();
//    		$this->load->view('site/tripchart/boarding-mini-trip-chart-print', $data);
//    	} else {
//    		_include_js('assets/js/pages/bordingpoint_trip_chart.js', '_init_chart_page');
//    		$this->load->view('site/tripchart/boarding-trip-chart-list', $data); // totalSeatCount
//    	}
//    }

    function live_boarding() {
        $this->is_logged_in();

        _include_js('assets/js/howler.js');
        _include_js('assets/lib/justgage/raphael-2.1.4.min.js');
        _include_js('assets/js/jquery.polartimer.js', 'init_progress');
        _include_js('assets/js/snap.svg-min.js');

        $this->load->view('site/tripchart/live-boarding');
    }

    function live_boarding_list() {
        $this->is_logged_in();

        $result = $this->api_model->getLiveNotBoardedList();
        $result = json_decode($result);
        
        $tinfo = $this->api_model->getAllTripInfo(array(
            'tripDate' => date('Y-m-d')
        ));
        $tinfo = json_decode($tinfo);

        foreach ($result->data as $key => $val) {
            foreach($tinfo->data as $trip) {
                if($trip->trip->tripCode == $val->tripCode) {
                    $result->data[$key]->tripDetails = array(
                        'driverName' => $trip->driverName,
                        'driverMobile' => $trip->driverMobile,
                        'registrationNumber' => $trip->busVehicle->registationNumber,
                    );
                    break;
                }
            }
        }

        echo json_encode($result);
    }

    function update_live_boarding() {
        $this->is_logged_in();

        $data = array(
            'ticketCode' => $this->input->post('ticketCode'),
            'seatCodes' => $this->input->post('seatCodeList'),
            'travelStatus' => $this->input->post('travelStatus')
        );
        echo $this->api_model->changeTravelStatus($data);
    }

    function update_ticket_travel_status() {
        $this->is_logged_in();

        $result = $this->api_model->ticketDetails(array(
            'ticketCode' => $this->input->post('ticketCode')
        ));
        $result = json_decode($result);

        if($result->status == 1){
            if(date('Y-m-d', strtotime($result->data->travelDate)) != date('Y-m-d')) {
                echo json_encode(array('status' => 0, 'errorDesc' => 'Travels date must match current date'));
                return;
            }
//            $seatCodeList = array();
//            foreach ($result->data->ticketDetails as $val) {
//                $seatCodeList[] = $val->seatCode;
//            }
//            $data = array(
//                'ticketCode' => $this->input->post('ticketCode'),
//                'seatCodes' => implode(',', $seatCodeList),
//                'travelStatus' => $this->input->post('travelStatus')
//            );
//            echo $this->api_model->changeTravelStatus($data);
            echo json_encode($result);
        } else {
            echo json_encode($result);
        }
        
    }
}

?>