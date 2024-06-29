<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class ticket extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
        $this->_user_hash = _get_user_hash();
    }

    public function index() {
        $this->is_logged_in();
        redirect('user/dashboard');
    }

    function find_edit_ticket() {
        $pnr = $this->input->post('pnr');
        $mobile = $this->input->post('mobile');
        $email = $this->input->post('email');
        if ($pnr != '' || $mobile != '' || $email != '') {
            $ticketDetail = array(
                'mobileNumber' => $mobile,
                'ticketCode' => $pnr,
                'emailId' => $email
            );
            $result = $this->api_model->findTickets($ticketDetail);
            $res = json_decode($result);
            
           
            
            $ticket = $res->data;
            $tck_detail = array();
            foreach ((array) $ticket As $tck) {
                //$seatName = '';
                //foreach ( (array) $tck->ticketDetails as $tck1) {
                //$seatName .= $tck1->seatName . ',';
                //$passenger = $tck1->passengerName;
                //}
                $tck_detail[] = array(
                    'fromStation' => $tck->fromStation->name,
                    'toStation' => $tck->toStation->name,
                    'travelDate' => $tck->travelDate,
                    'bookedDate' => $tck->transactionDate,
                    'mobile' => $tck->passegerMobleNo,
                    'email' => $tck->passegerEmailId,
                    //'seatName' => rtrim($seatName, ','),
                    //'passenger' => $passenger,
                    'statusCode' => $tck->ticketStatus->code,
                    'statusName' => $tck->ticketStatus->name,
                    'ticketCode' => $tck->ticketCode,
                    'tripCode' => $tck->tripCode,
                    'tripStageCode' => $tck->tripStageCode,
                    'bookingCode' => $tck->bookingCode,
                    'operatorCode' => $tck->operator->code
                );
            }
            $data['ticket'] = $tck_detail;
            $this->load->view('site/ticket/find-edit-ticket-list', $data);
        } else {
            $this->load->view('site/ticket/find-edit-ticket');
        }
    }

    function get_ticket_details() {
        $this->is_logged_in();
        $report = $this->api_model->ticketDetails(array('ticketCode' => $this->input->post('ticketpnrcode')));
        $rpt = json_decode($report);
        if ($rpt->status == 1) {
            $data['reports'] = $rpt->data;
            $time = new DateTime($rpt->data->travelDate);
            $data['times'] = $time->format('H:i A');
        } else {
            $data['error'] = 'No Details Found ';
        }
        $this->load->view('site/ticket/edit-ticket-details', $data);
    }

    function edit_passenger_mobile() {
        $this->is_logged_in();
        $data = array(
            "ticketCode" => $this->input->post('ticketCode'),
            "oldMobileNumber" => $this->input->post('oldMobileNumber'),
            "newMobileNumber" => $this->input->post('newMobileNumber'),
            "notificationFlag" => $this->input->post('notificationFlag')
        );
        echo $this->api_model->updateMobileNumber($data);
    }

    function edit_passenger_details() {
        $this->is_logged_in();
        $data = array(
            "ticketCode" => $this->input->post('ticketCode'),
            "seatCode" => $this->input->post('seatCode'),
            "notificationFlag" => $this->input->post('notificationFlag')
        );

        if ($this->input->post('newName') != '') {
            $data['passengerName'] = $this->input->post('newName');
        }
        if ($this->input->post('newGender') != '') {
            $data['genderCode'] = $this->input->post('newGender');
        }
        if ($this->input->post('newAge') != '') {
            $data['age'] = $this->input->post('newAge');
        }

        echo $this->api_model->updatePassengerDetail($data);
    }

    function get_boarding_info() {
        $tripCode = $this->input->post('tripCode');
        $stageCode = $this->input->post('stageCode');
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
        $busMap = $busMap->data;
        if ($busMap != '') {
            $address = '';
            $brdpoint = '<select id="board" class="form-control" onchange="getAddress()">';
            foreach ($busMap->fromStation->stationPoint as $bp) {
                         $date = new DateTime($bp->dateTime);
                         $date_new =  $date->format('g:i A');
                $brdpoint .= '<option value="' . $bp->code . '">' . $bp->name . ' - ' . $date_new . '</option>';
                $address .= '<div id="addr_' . $bp->code . '" style="display:none" class="add_shw">' . $bp->address . ', ' . $bp->landmark .', ' . $bp->name . '</div>';
            }
            $brdpoint .= '</select>';
        } else {
            $brdpoint = '<select id="brd_point" class="form-control"><option value="">Select</option></select>';
        }
        $points = array(
            'boardingPoint' => $brdpoint,
            'address' => $address
        );
        echo json_encode($points);
    }
    
    function get_dropping_info() {
        $tripCode = $this->input->post('tripCode');
        $stageCode = $this->input->post('stageCode');
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
        $busMap = $busMap->data;
        if ($busMap != '') {
            $address = '';
            $droppoint = '<select id="sdrop" class="form-control" onchange="getDropAddress()">';
            foreach ($busMap->toStation->stationPoint as $bp) {
                $date = new DateTime($bp->dateTime);
                $date_new =  $date->format('g:i A');
                $droppoint .= '<option value="' . $bp->code . '">' . $bp->name . ' - ' . $date_new . '</option>';
                $address .= '<div id="daddr_' . $bp->code . '" style="display:none" class="add_shw">' . $bp->address . ', ' . $bp->landmark .', ' . $bp->name . '</div>';
            }
            $droppoint .= '</select>';
        } else {
            $droppoint = '<select id="drop_point" class="form-control"><option value="">Select</option></select>';
        }
        $points = array(
            'droppingPoint' => $droppoint,
            'address' => $address
        );
        echo json_encode($points);
    }
    
    function edit_dropping_point() {
        $this->is_logged_in();
        $data = array(
            "ticketCode" => $this->input->post('ticketCode'),
            "oldDropingPointCode" => $this->input->post('oldDroppingPointCode'),
            "newDropingPointCode" => $this->input->post('newDroppingPointCode'),
            "notificationFlag" => $this->input->post('notificationFlag')
        );      
        echo $this->api_model->updateDroppingPoint($data);
    }
    
    function get_seat_info() {
        $tripCode = $this->input->post('tripCode');
        $stageCode = $this->input->post('stageCode');
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
            $data = array('status' => 0);
            echo json_encode($data);
            return;
        }
        $busMap = $busMap->data;
        $lseatrow = array();
        $lseatcol = array();
        $useatrow = array();
        $useatcol = array();
        $seatStatus = array();
        $seatDetails = array();

        foreach ($busMap->bus->seatLayoutList as $bs) {
            if ($bs->layer == 1) {
                $lseatrow[] = $bs->rowPos;
                $lseatcol[] = $bs->colPos;
                $seatStatus["1" . $bs->rowPos . $bs->colPos] = array('status' => $bs->seatStatus, 'code' => $bs->code, 'fare' => $bs->seatFare, 'seatName' => $bs->seatName, 'seatType' => $bs->busSeatType->name, 'userName' => $bs->user->name, 'groupName' => $bs->group->name);
            }
            if ($bs->layer == 2) {
                $useatrow[] = $bs->rowPos;
                $useatcol[] = $bs->colPos;
                $seatStatus["2" . $bs->rowPos . $bs->colPos] = array('status' => $bs->seatStatus, 'code' => $bs->code, 'fare' => $bs->seatFare, 'seatName' => $bs->seatName, 'seatType' => $bs->busSeatType->name, 'userName' => $bs->user->name, 'groupName' => $bs->group->name);
            }
            $seatDetails[$bs->code] = array('fare' => $bs->seatFare, 'seatName' => $bs->seatName, 'serviceTax' => $bs->serviceTax, 'genderstatus' => $bs->seatStatus->code);
        }
        
        $available = '<select id="bs_seat" class="form-control"><option value="">Select</option>';
        foreach($busMap->bus->seatLayoutList as $bs){
            $c = $bs->seatStatus->code;
            if($c == 'AL' || $c == 'AM' || $c == 'AF' || $c == 'AY'){
                $available .= '<option value="'.$bs->code.'">'.$bs->seatName.'</option>'; 
            }
        }
        $available .= '</select>';
        

        $data = array(
            'busmap' => $busMap,
            'busseatlayer' => $busMap->bus->seatLayoutList,
            'lrowmax' => max($lseatrow),
            'lrowmin' => min($lseatrow),
            'lcolmax' => max($lseatcol),
            'lcolmin' => min($lseatcol),
            'seatStatus' => $seatStatus,
            'seatDetails' => $seatDetails,
            'available' => $available
        );

        $seattype = $this->api_model->getBusSeatType();
        $busseat = json_decode($seattype);
        $data['seattype'] = $busseat->data;

        if (count($useatrow) > 0 && count($useatcol) > 0) {
            $data['urowmax'] = max($useatrow);
            $data['urowmin'] = min($useatrow);
            $data['ucolmax'] = max($useatcol);
            $data['ucolmin'] = min($useatcol);
        }
        echo json_encode($data);
    }

    function edit_boarding_point() {
        $this->is_logged_in();
        $data = array(
            "ticketCode" => $this->input->post('ticketCode'),
            "oldBoardingPointCode" => $this->input->post('oldBoardingPointCode'),
            "newBoardingPointCode" => $this->input->post('newBoardingPointCode'),
            "notificationFlag" => $this->input->post('notificationFlag')
        );
        echo $this->api_model->updateBoardingPoint($data);
    }
    
    function edit_seat_name() {
        $this->is_logged_in();
        $data = array(
            "ticketCode" => $this->input->post('ticketCode'),
            "seatCodes" => $this->input->post('seatCodes'),
            "notificationFlag" => $this->input->post('notificationFlag')
        );
        echo $this->api_model->updateSeatNamev2($data);
    }
    
    function get_ticket_history() {
        $this->is_logged_in();
            
        $data = array(
            'queryCode' => 'RQFA57404',
            'ticketCode' => $this->input->post('ticketCode')
        );
        
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        
        $meta = config_item('ticket_status');
        
        if($result->status==1)
            $data['transactions'] = $result->data;
        else
            $data['transactions'] = array();
        
        $data['meta'] = $meta;
        $data['ticketCode'] = $this->input->post('ticketCode');
        
        $this->load->view('site/ticket/ticket-history', $data);
    }
    
    function release_tentative() {
        $this->is_logged_in();
        $data = array(
            "ticketCode" => $this->input->post('ticketCode'),
        );
        echo $this->api_model->releaseTentativeBooking($data);
    }
    
    function progress() {
        $this->is_logged_in(); 
        
        _include_js('assets/lib/justgage/raphael-2.1.4.min.js');
        _include_js('assets/lib/justgage/justgage.js', 'init_progress');
        
        $data = array();
        
        $this->load->view('site/ticket/progress', $data);
    }
    
    function progress_list() {
        $this->is_logged_in();
        $data = array();
        $tickets = array();
        
        $paymentStatus = array('PAD' => 0, 'TOP' => 0, 'INP' => 0, 'OATP' => 0, 'WTOP' => 0);
        $cargoStatus = array('CB' => 0, 'FAIL' => 0, 'CA' => 0);
        
        $result = $this->api_model->getCurrentlyBookingList();
        $result = json_decode($result);

        foreach($result->data as $ticket) {

            $time_diff = ceil( (time() - strtotime($ticket->bookedAt)) / 60 );
            if($time_diff<=1) {
                $time_diff = '1 min ago';
            } else {
                $time_diff .= ' mins ago';
            }

            $tickets[] = array(
                'code' => $ticket->code,
                'fromBranch' => $ticket->fromOrganization->name,
                'toBranch' => $ticket->toOrganization->name,
                'pickupType' => $ticket->pickupType->name,
                'fromStation' => $ticket->fromStation->name,
                'toStation' => $ticket->toStation->name,
                'deliveryType' => $ticket->deliveryType->name,
                'bookedAt' => $time_diff,
                'itemsCount' => $ticket->additionalAttribute->itemCount,
                'bookedUser' => $ticket->bookedUser->name,
                'fromCustomer' => $ticket->fromCustomer->name,
                'fromCustomerMobile' => $ticket->fromCustomer->mobileNumber,
                'toCustomer' => $ticket->toCustomer->name,
                'toCustomerMobile' => $ticket->toCustomer->mobileNumber,
                'fromStation' => $ticket->fromStation->name,
                'toStation' => $ticket->toStation->name,
                'paymentStatus' => $ticket->paymentType->code,
                'cargoStatus' => $ticket->cargoStatus->code,
                'totalAmount' =>  $ticket->totalAmount,
                'unique' => strtotime($ticket->bookedAt),
            );

            if (!$ticket->code) {
                $cargoStatus["FAIL"]++;
            }

            $paymentStatus[$ticket->paymentType->code]++;
            $cargoStatus[$ticket->cargoStatus->code]++;
        }
        ksort($tickets);
        
        $data['status'] = $result->status;
        $data['tickets'] = $tickets;
        $data['user_count'] = count($result->data);
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['cargo_payment_status_badge'] = config_item('cargo_payment_status_badge');
        $data['paymentStatusCount'] = $paymentStatus;
        $data['cargoStatusCount'] = $cargoStatus;
        
        echo json_encode($data);
    }
    
    function after_departure_booking() {
        $this->is_logged_in();    
       
        _include_js('assets/js/howler.js');
        _include_js('assets/lib/justgage/raphael-2.1.4.min.js');
        _include_js('assets/js/jquery.polartimer.js', 'init_progress');
        _include_js('assets/js/snap.svg-min.js');        
        
        $data = array();
        
        $this->load->view('site/ticket/after-departure-booking', $data);
    }
    
    function after_departure_booking_list() {
        $this->is_logged_in();
        $data = array();
        $tickets = array();
        $devicemedium = array('WEB' => 0, 'API' => 0, 'MOB' => 0, 'APP' => 0);
        $ticketstatus = array('BO' => 0, 'PBL' => 0, 'BL' => 0, 'FAIL' => 0);
        
        
        $result = $this->api_model->getAfterDepatureBookingList();           
        $result = json_decode($result);
        
        $c_key = _get_namespace_id().'_search_tripinfo_'.date('Y-m-d');
        $tinfo = $this->rediscache->get($c_key); 
        $tinfo = json_decode($tinfo);
        $tripinfo = array();
        foreach($tinfo->data as $trip) {
            $tripinfo[$trip->trip->tripCode] = array(
                'driverName' => $trip->driverName,
                'driverMobile' => $trip->driverMobile,
                'registrationNumber' => $trip->busVehicle->registationNumber
            );
        }
               
        foreach($result->data as $ticket) {
            
            if($ticket->ticketStatus->code == 'BO' || $ticket->ticketStatus->code == 'PBL') {            
                $devicemedium[$ticket->deviceMedium]++;

                $seats = array();
                $state = '';
                foreach($ticket->ticketDetails as $seat) {
                    $seats[] = $seat->seatName;
                }

                $time_diff = ceil( (time() - strtotime($ticket->transactionDate)) / 60 );
                if($time_diff<=1) {
                    $time_diff = '1 min ago';
                } else {
                    $time_diff .= ' mins ago';
                }

                $isCustomer = 0;
                if($ticket->paymentGatewayPartner->code!='') {
                    $isCustomer = 1;
                }

                $tickets[] = array(
                    'pnr' => $ticket->code,
                    'from' => $ticket->fromStation->name,
                    'to' => $ticket->toStation->name,
                    'boardingPoint' => $ticket->fromStation->stationPoint[0]->name ? $ticket->fromStation->stationPoint[0]->name : '-',
                    'mobile' => $ticket->passegerMobleNo,
                    'serviceNumber' => $ticket->serviceNo,
                    'travelDate' => date("h:i A", strtotime($ticket->fromStation->stationPoint[0]->dateTime)),
                    'tripTime' => date("g:i A", strtotime($ticket->tripTime)),
                    'transactionDate' => date("h:i A", strtotime($ticket->transactionDate)),
                    'isCustomer' => $isCustomer,
                    'deviceMedium' => $ticket->deviceMedium,
                    'user' => $ticket->user->name ? $ticket->user->name : '-',
                    'operator' => $ticket->operator->name,
                    'state' => $ticket->ticketStatus->code,
                    'seats' => implode(', ', $seats),
                    
                    'driverName' => $tripinfo[$ticket->tripCode]['driverName'],
                    'driverMobile' => $tripinfo[$ticket->tripCode]['driverMobile'],
                    'registrationNumber' => $tripinfo[$ticket->tripCode]['registrationNumber']
                );
            }
            ksort($tickets);

            $data['status'] = $result->status;
            $data['tickets'] = $tickets;
            $data['device_medium'] = $devicemedium;
            //$data['ticket_status'] = $ticketstatus;
            $data['user_count'] = count($tickets);
        }
        
        echo json_encode($data);
    }
    
    function acknowledge_after_departure_booking() {
        $this->is_logged_in();
        $data = array(
            "ticketCode" => $this->input->post('pnr'),
        );
        echo $this->api_model->acknowledgeAfterDepatureBooking($data);
    }
    
    function validate_otp(){
        $this->is_logged_in();
        $this->load->view('site/ticket/validate-otp');
    }
    
    function validate_otp_list(){
        $this->is_logged_in();
        $ticketDetail = array(
            'mobileNumber' => $this->input->post('mobile'),
            'ticketCode' => '',
            'emailId' => ''
        );
        $result = $this->api_model->findTickets($ticketDetail);
        $result = json_decode($result);
        $result = $result->data;
        $data['result'] = $result;

        $this->load->view('site/ticket/validate-otp-list', $data);
    }
    
    function send_pnr_otp(){
        $this->is_logged_in();
        echo $this->api_model->sendValidationOTP(array(
            'pnr' => $this->input->post('pnr'),
        ));
    }
    
    function validate_pnr_otp(){
        $this->is_logged_in();
        echo $this->api_model->validateValidationOTP(array(
            'pnr' => $this->input->post('pnr'),
            'otp' => $this->input->post('otp')
        ));
    }

    function get_customer_gst_details() {
        $this->is_logged_in();
        echo $this->api_model->customerGstDetails(array(
            'ticketCode' => $this->input->post('ticketCode'),
        ));
    }

    function update_customer_gst_details() {
        $this->is_logged_in();
        echo $this->api_model->updateCustomerGstDetails(array(
            'activeFlag' => 1,
            'code' => '',
            'gstin' => $this->input->post('gstin'),
            'tradeName' => $this->input->post('tradeName'),
            'ticketCode' => $this->input->post('ticketCode')
        ));
    }

    function whatsapp_share() {
        $this->is_logged_in();

        $pnr = $this->input->get('pnr');
        $type = $this->input->get('type');
        $tomobile = $this->input->get('toMobile');

        $ticket = $this->api_model->ticketDetails(array(
            'ticketCode' => $pnr
        ));
        $ticket = json_decode($ticket);
        $ticket = $ticket->data;
        $data['reports'] = $ticket;

        foreach($ticket->ticketDetails as $row){
            $data['seat_fare'] += $row->seatFare;
            $data['pass_name'] = $row->passengerName;
            $data['seat_name'] .= $row->seatName . ', ';

            if ($row->seatStatus->code == 'CA') {
                $data['can_charge'] += $row->cancellationCharges;
                $data['refund'] += $row->refundAmount + $row->serviceTax;
                $data['ca_seat_fare'] += $row->seatFare;
                $data['ca_tax'] += $row->serviceTax;
            } elseif ($row->seatStatus->code != 'PBC') {
                $data['tot_trans'] += $row->seatFare + $row->serviceTax;
                $data['tax'] += $row->serviceTax;
                $data['seat_fare'] += $row->seatFare;
            }
        }

        foreach ($ticket->ticketDetails as $dis) {
            if ($dis->addonType->code == 'AGSC') {
                $data['service_charges'] += $dis->value;
                $data['tot_trans'] += $dis->value;
            } elseif (($dis->addonType->code == 'SHDS' || $dis->addonType->code == 'DSAMT' || $dis->addonType->code == 'COUP' || $dis->addonType->code == 'OFDS' || $dis->addonType->code == 'WARD' || $dis->addonType->code == 'WACP') && $dis->addonStatus->code != 'CA') {
                $data['discount'] += $dis->value;
                $data['tot_trans'] -= $dis->value;
            } elseif (($dis->addonType->code == 'SHDS' || $dis->addonType->code == 'DSAMT' || $dis->addonType->code == 'COUP' || $dis->addonType->code == 'OFDS' || $dis->addonType->code == 'WARD' || $dis->addonType->code == 'WACP') && $dis->addonStatus->code == 'CA') {
                $data['refund'] -= $dis->value;
                $data['ca_discount'] += $dis->value;
            } elseif ($dis->addonType->code == 'WARD' || $dis->addonType->code == 'WACP') {
                $data['discount'] += $dis->value;
                $data['tot_trans'] -= $dis->value;
            } elseif ($dis->addonType->code == 'GGN') {
                $data['gogreen'] += $dis->value;
                $data['tot_trans'] += $dis->value;
            }
        }

        if($type == 'RSNDGPSHJ') {
            $param = array(
                'fromCode' => $ticket->fromStation->code,
                'toCode' => $ticket->toStation->code,
                'tripDate' => date('Y-m-d', strtotime($ticket->travelDate))
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
                    if($row->trip->tripCode == $ticket->tripCode){
                        $tripinfo = $row;
                        break;
                    }
                }
            }
            
            $zone =  config_item('zone');
            $track_link = config_item('product_domain');
            $link = $track_link['trackingui'].'/?p='.$pnr.'&zone='.$zone;

            $this->load->model('shorturl_model');
            $short_url = $this->shorturl_model->shorten(array(
                'url' => $link,
                'type' => 'TMP'        // Temporary
             ));
            $short_url = json_decode($short_url);

            if($short_url->status == 1) {
                $url = $short_url->data->url;
                $data['tracking_link'] = preg_replace('/https/i', 'http', $url);
            }
        }

        $data['trips'] = $tripinfo;
        $data['type'] = $type;
        $data['ns_domain_url'] = $this->session->userdata('ns_domain_url');

        $this->load->exclude_template();
        $text = $this->load->view('site/ticket/ticket-sms-tpl', $data, true);

        $param = array(
            'phone' => '+91' . ($tomobile ?: $ticket->passegerMobleNo),
            'text' => $text
        );
        $whatsapp_url = config_item('whatsapp_send_url') . '?' . http_build_query($param);

        redirect($whatsapp_url);
    }
    
}
