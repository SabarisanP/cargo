<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tripchart extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->is_logged_in();
        redirect('user/dashboard');
    }

    public function trip_chart() {
        $this->is_logged_in();
        $tripCode = $this->input->post('tripCode');
        _include_js('assets/js/pages/trip_chart.js', '_init_trip_chart_page');
        $this->load->view('site/tripchart/trip-chart');
    }

    public function trip_list() {
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
        _include_js('assets/js/pages/trip_chart.js');
        $this->load->view('site/tripchart/trip-list', $data);
    }

    public function trip_driver_list() {
        $this->is_logged_in();
        $list = $this->api_model->getVehicleDriver();
        $list = json_decode($list);
        $formated_list = array();
        foreach ($list->data as $driver) {
            array_push($formated_list, array(
                'driverName' => $driver->name,
                'driverMobile' => $driver->mobileNumber,
                'code' => $driver->code,
                'tokens' => explode(' ', $driver->name)
            ));
        }
        echo json_encode($formated_list);
    }

    public function trip_attender_list() {
        $this->is_logged_in();
        $list = $this->api_model->getVehicleAttendant();
        $list = json_decode($list);
        $formated_list = array();
        foreach ($list->data as $driver) {
            array_push($formated_list, array(
                'driverName' => $driver->name,
                'driverMobile' => $driver->mobile,
                'code' => $driver->code,
                'tokens' => explode(' ', $driver->name)
            ));
        }
        echo json_encode($formated_list);
    }

    public function trip_chart_list() {
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
            foreach ($tripChartList->trip->stageList as $stages) {
                foreach ($stages->fromStation->stationPoint as $points) {
                    $bp[strtotime($points->dateTime)] = array(
                        'code' => $points->code,
                        'name' => $points->name,
                        'stageName' => $stages->fromStation->name,
                        'timestamp' => strtotime($points->dateTime),
                        'time' => date('g:i A', strtotime($points->dateTime))
                    );
                }
            }
            ksort($bp); //  sort points by time.
            
            
            $dp = array();
            foreach ($tripChartList->trip->stageList as $stages) {
                foreach ($stages->toStation->stationPoint as $points) {
                    $dp[strtotime($points->dateTime)] = array(
                        'code' => $points->code,
                        'name' => $points->name,
                        'stageName' => $stages->toStation->name,
                        'time' => date('g:i A', strtotime($points->dateTime))
                    );
                }
            }
            ksort($dp); //  sort points by time.
            

            $bus = array();
            $ticket = array();
            $tick = array();
            $booked_seat_name = array();
            $un_booked_Seats = array();
            foreach ($tripChartList->ticketDetailsList as $tpch) {
                $booked_seat_name[$tpch->seatName][] = $tpch;
                $ticket[$tpch->fromStation->name][$tpch->boardingPoint->name][] = $tpch->seatName;
                $ticket_dp[$tpch->toStation->name][$tpch->droppingPoint->name][] = $tpch->seatName;
                $userBookings[$tpch->bookedBy->name][] = array('seatName' => $tpch->seatName, 'seatFare' => $tpch->seatFare+$tpch->acBusTax);
                $bp_booking[$tpch->boardingPoint->code][] = $tpch;
                $dp_booking[$tpch->droppingPoint->code][] = $tpch;
                $bookedSeat[] = $tpch->seatName;
                $bookedGender[$tpch->seatName] = $tpch->gender;
            }
            
            $quotaSeats = $this->api_model->loadTripQuotaDetails(array(
                'tripCode' => $tripCode,
            ));        
            $quotaSeats = json_decode($quotaSeats); 
            $quotaSeats = $quotaSeats->data;
                    
            $quota_seat_name = array();
            foreach ($quotaSeats as $quota) {
                $quota_seat_name[] = $quota->quotaSeat->seatName;
            }
            
            foreach ($tripChartList->trip->bus->seatLayoutList as $seat) {
                if(!in_array($seat->seatName, $booked_seat_name) && !in_array($seat->seatName, $quota_seat_name)) {
                    $un_booked_Seats[] = $seat->seatName;
                }
            }
            asort($un_booked_Seats);

            $data = array(
                'points' => $bp,
                'points_dp' => $dp,
                'Booking' => $booked_seat_name,
                'bp_books' => $bp_booking,
                'dp_books' => $dp_booking,
                'trips' => $tripChartList->trip,
                'tripCode' => $tripCode,
                'ticketList' => $ticket,
                'ticketListDp' => $ticket_dp,
                'bookinglist' => $userBookings,
                'unbookedlist' => $un_booked_Seats,
                'unbooked_seat_names' => implode(', ', $un_booked_Seats),
                'bookedSeat' => $bookedSeat,
                'bookedGender' => $bookedGender,
                'minutesForFirstBoarding' => round(($bp[0]['timestamp'] - time()) /60),
                'vehicle_nunmber' => $tripChartList->busVehicle->registationNumber,
                'quotaSeats' => $quotaSeats,
                'quotaSeatsList' => $quota_seat_name
            );


            $id = count($tripChartList->trip->stageList);
            $data['from'] = $tripChartList->trip->stageList[0]->fromStation->name;
            $data['to'] = $tripChartList->trip->stageList[$id - 1]->toStation->name;
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
                        
                        if ($result->data[$i]->transaction_type == 'BO') {
                            $tickets[$result->data[$i]->user_first_name]['bo_seats'] += $result->data[$i]->seat_count;
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
        
        if ($this->input->get('mini') == 1) {
            $this->load->exclude_template();
            $this->load->view('site/tripchart/mini-trip-chart-print', $data);
        } else if ($this->input->get('print') == 1 && $this->input->get('medium') == 1) {  //  print medium trip chart without vacant seat, bus map and agent info
            $this->load->exclude_template();
            $data['medium'] = 1;
            $data['namespace_name'] = $this->session->userdata('namespace_name');
            $this->load->view('site/tripchart/singlepage-trip-chart-print', $data);
        } else if ($this->input->get('print') == 1) {
            $this->load->exclude_template();
            $this->load->view('site/tripchart/trip-chart-print', $data);
        }  else if ($this->input->get('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/tripchart/trip-chart-list-excel', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Trip-Chart-'.$tripCode.'.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else {
            // Get vehicle assigned to this trip
            $result = $this->api_model->getVehicleInfo(array('tripCode' => $tripCode));
            $result = json_decode($result);
            $data['vehicle_info'] = $result->data;
            
            //Get Driver Details
            $result = $this->api_model->getVehicleDriver();
            $result = json_decode($result);
            $data['current_date'] = $result->datetime;
            $data['drivers'] = $result->data;
            
            //Get Attenders Detais
            $result = $this->api_model->getVehicleAttendant();
            $result = json_decode($result);
            $data['attenders'] = $result->data;
            

            // Get namespace vehicle info
            $get_vehicle = $this->api_model->getVehicle(array('authtoken' => $this->_user_hash));
            $vehicle = json_decode($get_vehicle);
            $data['ns_vehicle'] = $vehicle->data;
            
            _include_js('assets/js/pages/trip_chart.js', '_init_chart_page');
            $this->load->view('site/tripchart/trip-chart-list', $data); // totalSeatCount
        }
    }

//
//    public function agent_report() {
//        $this->is_logged_in();
//        $this->load->view('site/report/agent_report');
//    }
    public function send_trip_sms() {
        $this->is_logged_in();
        $data = array(
            'tripCode' => $this->input->post('trip_code'),
            'message' => $this->input->post('sms_content')
        );
        echo $this->api_model->sendTripSMSNotification($data);
    }

    public function save_chart_info() {
        $this->is_logged_in();
        $data = array(
            'tripCode' => $this->input->post('trip_code'),
            'driverName' => $this->input->post('driver_name'),
            'driverMobile' => $this->input->post('driver_phone'),
            'driverName2' => $this->input->post('driver_name2') ?: '',
            'driverMobile2' => $this->input->post('driver_phone2') ?: '',
            'attenderName' => $this->input->post('attender_name') ?: '',
            'attenderMobile' => $this->input->post('attender_phone') ?: '',
            'primaryDriverCode' => $this->input->post('primaryDriverCode') ?: '',
            'secondaryDriverCode' => $this->input->post('secondaryDriverCode') ?: '',
            'attendantCode' => $this->input->post('attendantCode') ?: '',
            'remarks' => $this->input->post('remarks'),
        );
        if ($this->input->post('vehicle') != '') {
            $data['vehicleCode'] = $this->input->post('vehicle');
            
            // Get namespace vehicle info
            $get_vehicle = $this->api_model->getVehicle(array());
            $vehicle = json_decode($get_vehicle);
            $vehicles = $vehicle->data;
            
            foreach($vehicles as  $vehicle) {   //  for logging purpose
                if($vehicle->code == $data['vehicleCode']) {
                    $data['registrationNumber'] = $vehicle->registationNumber;
                }
            }
        }
        $json =  $this->api_model->updateTripDriveInfo($data);
                
        if($this->input->post('tripdate')!="") {    // clear trip info cache
            $sdate = $this->input->post('tripdate');
            $p_key = _get_namespace_id().'_search_tripinfo_'.$sdate;
            if($this->rediscache->exists($p_key)) {
                $tinfo = $this->rediscache->delete($p_key);
            }
        }
        
        echo $json;
    }

//    public function trip_chart_print() {
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
//        $this->load->view('site/tripchart/trip-chart-print', $data); // totalSeatCount
//    }
//    public function mini_trip_chart_list() {
//    	$this->is_logged_in();
//    	$tripCode = $this->input->get('tc'); //tripCode
//    	$tripChartList = $this->api_model->getTripChart(array('tripCode' => $tripCode));
//    	$tripChartList = json_decode($tripChartList);
//    
//    	if ($tripChartList->status == 1) {
//    		$tripChartList = $tripChartList->data;
//    
//    		$bp = array();
//    		foreach ($tripChartList->trip->stageList as $stages) {
//    			foreach ($stages->fromStation->stationPoint as $points) {
//    				$bp[strtotime($points->dateTime)] = array(
//    						'code' => $points->code,
//    						'name' => $points->name,
//    						'stageName' => $stages->fromStation->name,
//    						'time' => date('g:i A', strtotime($points->dateTime))
//    				);
//    			}
//    		}
//    		ksort($bp); //  sort points by time.
//    
//    		$bus = array();
//    		$ticket = array();
//    		$tick = array();
//    		$booked_seat_name = array();
//    		$un_booked_Seats = array();
//    		foreach ($tripChartList->ticketDetailsList as $tpch) {
//    			$booked_seat_name[$tpch->seatName][] = $tpch;
//    			$ticket[$tpch->fromStation->name][$tpch->boardingPoint->name][] = $tpch->seatName;
//    			$userBookings[$tpch->bookedBy->name][] = array('seatName' => $tpch->seatName, 'seatFare' => $tpch->seatFare);
//    			$bp_booking[$tpch->boardingPoint->code][] = $tpch;
//    			$bookedSeat[] = $tpch->seatName;
//    			$bookedGender[$tpch->seatName] = $tpch->gender;
//    		}
//    
//    		foreach ($tripChartList->trip->bus->seatLayoutList as $seat) {
//    			if (!in_array($seat->seatName, $booked_seat_name)) {
//    				$un_booked_Seats[] = $seat->seatName;
//    			}
//    		}
//    		asort($un_booked_Seats);
//    
//    		$data = array(
//    				'points' => $bp,
//    				'Booking' => $booked_seat_name,
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
//    	if ($this->input->get('print') == 1) {
//    		$this->load->exclude_template();
//    		$this->load->view('site/tripchart/mini-trip-chart-print', $data);
//    	}  else if ($this->input->get('export') == 1) {
//    		$this->load->exclude_template();
//    		$content = $this->load->view('site/tripchart/mini-trip-chart-print', $data, true);
//    		header('Content-Description: File Transfer');
//    		header('Content-Type: application/octet-stream');
//    		header('Content-Disposition: attachment; filename=Trip-Chart-'.$tripCode.'.xls');
//    		header('Content-Transfer-Encoding: binary');
//    		header('Expires: 0');
//    		header('Cache-Control: must-revalidate');
//    		header('Pragma: public');
//    		header('Content-Length: ' . strlen($content));
//    		ob_clean();
//    		flush();
//    		echo $content;
//    		die;
//    	} else {
//    		_include_js('assets/js/pages/trip_chart.js', '_init_chart_page');
//    		$this->load->view('site/tripchart/trip-chart-list', $data); // totalSeatCount
//    	}
//    }
}

?>