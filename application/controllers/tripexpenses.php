<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tripexpenses extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->is_logged_in();
        redirect('user/dashboard');
    }

    public function trip_expenses() {
        $this->is_logged_in();
        $data = array();
        $tripCode = $this->input->post('tripcode');
        _include_js('assets/js/pages/tripexpenses.js');
        //Trip Expensive
        $tripexpn = $this->api_model->getTripsExpensive(array('tripCode' => $tripCode));
        $tripexpn = json_decode($tripexpn);
        $data = array('data' => $tripexpn->data);
        //Trip Cash head
        $triphead = $this->api_model->getTripsHead($data);
        $triphead = json_decode($triphead);
        $data['triphead'] = $triphead->data;
        //Transaction Mode
        $trans_mode = $this->api_model->getTransMode(array('authtoken' => $this->_user_hash));
        $transaction_mode = json_decode($trans_mode);
        $data['t_mode'] = $transaction_mode->data;
        $this->load->view('site/trips/trip-expenses', $data);
    }

    public function update_tripexpense() {

        $data = array(
            'amount' => $this->input->post('amount'),
            'activeFlag' => "1",
            'tripCode' => $this->input->post('tripCode'),
            'transactionModeIO' => array('code' => $this->input->post('transactionModeIO')),
            'tripCashHeadIO' => array('code' => $this->input->post('tripCashHeadIO')),
            'remarks' => $this->input->post('remarks')
        );

        echo $this->api_model->updateTripExpenses($data);
    }

    public function update_status_tripexpenses() {
        $this->is_logged_in();
        $code = $this->input->post('code');
        $activeFlag = $this->input->post('activeFlag');
        $data = array(
            'activeFlag' => $activeFlag,
            'code' => $code,
        );
        echo $this->api_model->updateTripExpenses($data);
    }
    
    public function get_trip_busmap() {
        $this->is_logged_in();
        $stageCode = $this->input->post('stageCode'); //tripCode
        $tripChartList = $this->api_model->getScheduleBusMap ( array (
				'stageCode' => $stageCode
		) );
        $tripChartList = json_decode($tripChartList);

        if ($tripChartList->status == 1) {
            $tripChartList = $tripChartList->data;
            $bus = array();
            $buslayers = $tripChartList->bus;
            $data['busseatlayer'] = $buslayers->seatLayoutList;
            $data['seatvisiblelists'] = $tripChartList->ticketDetailsList;
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
            } else {
            $data = array('api_error' => 1);
        }
        $seattype = $this->api_model->getBusSeatType ();
        $brd = array();
        if(is_array($buslayers->seatLayoutList) && !empty($buslayers->seatLayoutList)){
        foreach($buslayers->seatLayoutList as $br){
            if($br->boardingPointName != ''){
                $brd[] = $br->boardingPointName;
            }
         }
        }
        $data['board'] = array_unique($brd);
        $busseat = json_decode ( $seattype );
        $data ['seattype'] = $busseat->data;
            
        // search //
            
        
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
        $data ['route'] = $a_routes;
        $this->load->view('site/trips/transfer-ticket', $data); // totalSeatCount
    }
    
    public function get_trip_busmaps_search() {
        $this->is_logged_in();
        $stageCode = $this->input->post('stageCode'); //tripCode
        $tripChartList = $this->api_model->getScheduleBusMap ( array (
				'stageCode' => $stageCode
		) );
        $tripChartList = json_decode($tripChartList);

        if ($tripChartList->status == 1) {
            $tripChartList = $tripChartList->data;
            $bus = array();
            $buslayers = $tripChartList->bus;
            $data['busseatlayer'] = $buslayers->seatLayoutList;
            $data['boarding'] = $tripChartList->fromStation->stationPoint;
            $data['dropping'] = $tripChartList->toStation->stationPoint;
            $data['seatvisiblelists'] = $tripChartList->ticketDetailsList;
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
            } else {
            $data = array('api_error' => 1);
        }
        $seattype = $this->api_model->getBusSeatType ();
        $brd = array();
        if(is_array($buslayers->seatLayoutList) && !empty($buslayers->seatLayoutList)){
        foreach($buslayers->seatLayoutList as $br){
            if($br->boardingPointName != ''){
                $brd[] = $br->boardingPointName;
            }
         }
        }
        $data['board'] = array_unique($brd);
        $busseat = json_decode ( $seattype );
        $data ['seattype'] = $busseat->data;

        
        $this->load->view('site/trips/transfer-ticket-search', $data); // totalSeatCount
    }
    
    function get_trip_busmap_transfer(){
        $this->is_logged_in();
        $stageCode = $this->input->post('stageCode'); //tripCode
        $tripChartList = $this->api_model->getScheduleBusMap ( array (
				'stageCode' => $stageCode
		) );
        $tripChartList = json_decode($tripChartList);

        if ($tripChartList->status == 1) {
            $tripChartList = $tripChartList->data;
            $bus = array();
            $buslayers = $tripChartList->bus;
            $data['sourceBusType'] = $tripChartList->bus->busType;
            $data['busseatlayer'] = $buslayers->seatLayoutList;
            $data['seatvisiblelists'] = $tripChartList->ticketDetailsList;
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
            } else {
            $data = array('api_error' => 1);
        }
            $seattype = $this->api_model->getBusSeatType ();
            $brd = array();
            if(is_array($buslayers->seatLayoutList) && !empty($buslayers->seatLayoutList)){
            foreach($buslayers->seatLayoutList as $br){
                if($br->boardingPointName != ''){
                    $brd[] = $br->boardingPointName;
                }
             }
            }
            $data['board'] = array_unique($brd);
            $busseat = json_decode ( $seattype );
            $data ['seattype'] = $busseat->data;
            $this->load->view('site/trips/trip-busmap-transfer', $data); // totalSeatCount
        }
    

}
