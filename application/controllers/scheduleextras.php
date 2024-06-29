<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Scheduleextras extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->redirest('/');
    }

    function get_station_point_exceptions() {
        $this->is_logged_in();
        $data = array();

        $stations = $this->api_model->getCommerceStation();
        $stations = json_decode($stations);
        $data['stations'] = $stations->data;

        $schedulesactive = $this->api_model->getScheduleByType(array('type' => 'none'));
        $schedulesactive = json_decode($schedulesactive);
        $schedulesactive = $schedulesactive->data;
        $data['schedules'] = $schedulesactive;

        $exceptions = $this->api_model->getAllStationPointExceptions();
        $exceptions = json_decode($exceptions);
        $data['exceptions'] = $exceptions->data;

        $this->load->view('site/scheduleextras/all-station-point-exceptions', $data);
    }

    function get_stationpoints() {
        $station_code = $this->input->post('stationCode');
        echo $this->api_model->getStationPointsByStation(array('stationcode' => $station_code));
    }

    function update_station_point_exceptions() {
        $this->is_logged_in();

        $week = $this->input->post('dayOfWeek');
        $days = '';
        foreach ($week as $wk) {
            $days .= $wk;
        }

        $stationpoints = explode(',', $this->input->post('stationPoints'));
        $spcodelist = array();
        foreach ($stationpoints as $point) {
            $spcodelist[] = array('code' => $point);
        }

        $schedules = explode(',', $this->input->post('schedules'));
        $schcodelist = array();
        foreach ($schedules as $sch) {
            $schcodelist[] = array('code' => $sch);
        }

        $data = array(
            'station' => array('code' => $this->input->post('station')),
            'stationPointList' => $spcodelist,
            'scheduleList' => $schcodelist,
            'activeFrom' => $this->input->post('activeFrom'),
            'activeTo' => $this->input->post('activeTo'),
            'dayOfWeek' => $days,
            'releaseMinutes' => $this->input->post('releaseBefore'),
            'boardingFlag' => $this->input->post('boardingFlag'),
            'droppingFlag' => $this->input->post('droppingFlag'),
            'activeFlag' => 1
        );

        if( $this->input->post('code') != '' ) {
           $data['code'] = $this->input->post('code');
        }

        echo $this->api_model->updateAllStationPointExceptions($data);
    }

    function delete_station_point_exceptions() {
        $this->is_logged_in();
        $data = $this->input->post('rule');
        echo $this->api_model->updateAllStationPointExceptions($data);
    }


    function schedule_occupancy_summary_meta(){
        $this->is_logged_in();

        $result = $this->api_model->getCumulativeAdvaceBooking();
        $result = json_decode($result);

        $meta = array();
        if($result->status == 1) {
            $todayTime = strtotime(date('Y').'-'.date('m').'-'.date('d'));            
            foreach($result->data as $schedule) {
                $meta[$schedule->code]['nm'] = $schedule->name;
                $meta[$schedule->code]['sn'] = $schedule->serviceNumber;
                $meta[$schedule->code]['ts'] = $schedule->bus->seatCount;
                foreach($schedule->tripList as $trip) {                                       
                    $days_diff = round(abs(strtotime($trip->travelDate) - $todayTime) / 86400);
                    $meta[$schedule->code]['trips'][$trip->travelDate]['ddif'] = $days_diff;    // today?

                    $hg = 0;
                    if( in_array(date("D",strtotime($trip->travelDate)), ['Sun','Sat','Fri']))
                        $hg = 1;
                    $meta[$schedule->code]['trips'][$trip->travelDate]['hg'] = $hg; // highlight weekend days

                    $meta[$schedule->code]['trips'][$trip->travelDate]['cnt'] = ($trip->bookedSeatCount == -1) ? '-' : $trip->bookedSeatCount;
                    $meta[$schedule->code]['trips'][$trip->travelDate]['ro'] = 0;
                    if($trip->bookedSeatCount>0)
                        $meta[$schedule->code]['trips'][$trip->travelDate]['ro'] = ceil( ($trip->bookedSeatCount/$schedule->bus->seatCount)*100 ); // ratio

                    $meta[$schedule->code]['trips'][$trip->travelDate]['tc'] = $trip->tripCode;
                }
            }
        }

        $data = array();
        $data['meta'] = $meta;
        $data['schedulecode'] =  $result->data[0]->code;        
        $data['response_datetime'] = date('H:i A', strtotime($result->datetime));

        $this->load->view('site/scheduleextras/occupancy-summary', $data);
    }

    function get_occupancy_trip_fare(){
        $this->is_logged_in();

        $tripCode = $this->input->post('tc');
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

        $data = array(
            'seatTypes' => $stypes,
            'fares' => $formatted
        );
        $this->load->view('site/scheduleextras/fare-list', $data);
    }

    function virtual_seats(){
        $this->is_logged_in();

        $schedulesactive = $this->api_model->getScheduleByType(array('type' => 'none'));
        $schedulesactive = json_decode($schedulesactive);
        $schedulesactive = $schedulesactive->data;
        $data['schedules'] = $schedulesactive;

        $exceptions = $this->api_model->virtualSeat();
        $exceptions = json_decode($exceptions);
        $data['exceptions'] = $exceptions->data;
        $data['groupusers'] = get_active_group_and_users();

        $this->load->view('site/scheduleextras/virtual-seat', $data);
    }

    function save_virtual_seats_block(){
        $this->is_logged_in();

        $data = array(
            'activeFlag' => 1,
            'code' => $this->input->post('code'),
            'activeTo' => $this->input->post('activeTo'),
            'activeFrom' => $this->input->post('activeFrom'),
            'dayOfWeek' => implode("",$this->input->post('dayOfWeek')),
            'refreshMinutes' => $this->input->post('refreshMinutes'),
        );

        $tschedules = explode(',',$this->input->post('schedules'));
        foreach ($tschedules as $value) {
            $data['scheduleList'][] = array('code' => $value);
        }

        $tgroups = explode(',',$this->input->post('groupList'));
        foreach ($tgroups as $value) {
            $data['groupList'][] = array('code' => $value);
        }

        $tblockedseats = $this->input->post('blockSeat');

        $tbookedseats = $this->input->post('bookSeat');
        $tcritriacount = count($tbookedseats);
        for ($i = 0;$i<$tcritriacount; $i++) {
            if(isset($tbookedseats[$i])) {
                $data['occuapancyblockPercentage'][] = $tbookedseats[$i].'_'.$tblockedseats[$i];
            }
        }
        echo $this->api_model->virtualSeatUpdate($data);
    }

    function delete_virtual_seats_block() {
        $this->is_logged_in();

        $data = $this->input->post('code');
        echo $this->api_model->virtualSeatUpdate($data);
    }

    function virtual_seats_block_exception(){
        $this->is_logged_in();

        $data = array(
            'activeFlag' => 1,
            'activeTo' => $this->input->post('activeTo'),
            'activeFrom' => $this->input->post('activeFrom'),
            'dayOfWeek' => implode("",$this->input->post('dayOfWeek')),
            'refreshMinutes' => $this->input->post('refreshMinutes'),
            'lookupCode' => $this->input->post('lookupCode'),
        );
        if($this->input->post('code')){
            $data['code'] = $this->input->post('code');
        }
        if($this->input->post('groupList')){
            $data['groupList'] = $this->input->post('groupList');
        }
        if($this->input->post('occuapancyblockPercentage')){
            $data['occuapancyblockPercentage'] = $this->input->post('occuapancyblockPercentage');
        }
        foreach ($this->input->post('scheduleList') as $value) {
            $data['scheduleList'][] = array('code' => $value);
        }

        //print_r($data);
        echo $this->api_model->virtualSeatUpdate($data);
    }

    function ticket_reshedule_terms() {
        $this->is_logged_in();

        $terms = $this->api_model->ticketResheduleTerms(array(
            'activeFlagFilter' => -1
        ));
        $terms = json_decode($terms);
        $data['terms'] = $terms->data;

        $data['groupusers'] = get_active_group_and_users();
        $data['Allgroups'] = array();
        foreach($data['groupusers']['groups'] as $row) {
            $data['Allgroups'][$row->code] = $row->name;
        }

        $schedulesactive = $this->api_model->getScheduleByType(array('type' => 'none'));
        $schedulesactive = json_decode($schedulesactive);
        $data['schedules'] = $schedulesactive->data;

        $routes = $this->api_model->getRoutes();
        $routes = json_decode($routes);
        $data['routes'] = $routes->data;

        $this->load->view('site/scheduleextras/ticket-reshedule-terms', $data);
    }

    function ticket_reshedule_terms_update(){
        $this->is_logged_in();
        $lookup =  $this->input->post('lookupCode');

        if(empty($lookup)){
            $lookup = '';
        }

        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'activeFrom' => $this->input->post('activeFrom'),
            'activeTo' => $this->input->post('activeTo'),
            'dayOfWeek' => $this->input->post('dayOfWeek'),
            'minutes' => $this->input->post('minutes'),
            'chargeAmount' => $this->input->post('chargeAmount'),
            'chargeType' => $this->input->post('chargeType'),
            'minutesType' => $this->input->post('minutesType'),
            'scheduleList' => $this->input->post('scheduleList')?:array(),
            'routeList' => $this->input->post('routeList')?:array(),
            'groupList' => $this->input->post('groupList')?:array(),
            'lookupCode' => $lookup,
        );
        echo $this->api_model->ticketResheduleTermsUpdate($data);
    }

    function schedule_discount() {
        $this->is_logged_in();

        $discount = $this->api_model->scheduleExtrasDiscount();
        $discount = json_decode($discount);
        $data['discount'] = $discount->data;

        $schedulesactive = $this->api_model->getScheduleByType(array('type' => 'none'));
        $schedulesactive = json_decode($schedulesactive);
        $data['schedules'] = $schedulesactive->data;

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $this->load->view('site/scheduleextras/schedule-discount', $data);
    }

    function update_schedule_discount() {
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'name' => $this->input->post('name'),
            'activeFlag' => (int)$this->input->post('activeFlag'),
            'discountValue' => $this->input->post('discountValue'),
            'percentageFlag' => $this->input->post('percentageFlag'),
            'authenticationType' => $this->input->post('authenticationType'),
            'deviceMedium' => $this->input->post('deviceMedium'),
            'scheduleList' => $this->input->post('scheduleList')?:[],
            'groupList' => $this->input->post('groupList')?:[],
            'dateType' => $this->input->post('dateType'),
            'activeFrom' => $this->input->post('activeFrom'),
            'activeTo' => $this->input->post('activeTo'),
            'dayOfWeek' => $this->input->post('dayOfWeek'),
            'activeFromMinutes' => $this->input->post('activeFromMinutes')?:0,
            'activeToMinutes' => $this->input->post('activeToMinutes')?:0,
            'overrideList' => $this->input->post('overrideList')?:[],
            'afterBookingMinutes' => $this->input->post('afterBookingMinutes')?:0,
            'femaleDiscountFlag' => (int)$this->input->post('femaleDiscountFlag'),
        );

        echo $this->api_model->updateScheduleExtrasDiscount($data);
    }

    function update_schedule_discount_exception() {
        $this->is_logged_in();

        $data = array(
            'discountValue' => -1,
            'code' => $this->input->post('code'),
            'name' => $this->input->post('name'),
            'activeFlag' => (int)$this->input->post('activeFlag'),
            'percentageFlag' => $this->input->post('percentageFlag')?:0,
            'scheduleList' => $this->input->post('scheduleList')?:[],
            'activeFrom' => $this->input->post('activeFrom'),
            'activeTo' => $this->input->post('activeTo'),
            'dayOfWeek' => $this->input->post('dayOfWeek'),
            'activeFromMinutes' => $this->input->post('activeFromMinutes')?:0,
            'activeToMinutes' => $this->input->post('activeToMinutes')?:0,
            'overrideList' => $this->input->post('overrideList')?:[],
            'afterBookingMinutes' => $this->input->post('afterBookingMinutes')?:0,
            'lookupCode' => $this->input->post('lookupCode')
        );

        echo $this->api_model->updateScheduleExtrasDiscount($data);
    }

    function schedule_gender_rules() {
        $this->is_logged_in();

        $rules = $this->api_model->scheduleExtrasGenderRules();
        $rules = json_decode($rules);
        $data['rules'] = $rules->data;

        $schedulesactive = $this->api_model->getScheduleByType(array('type' => 'none'));
        $schedulesactive = json_decode($schedulesactive);
        $data['schedules'] = $schedulesactive->data;

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $this->load->view('site/scheduleextras/schedule-gender-rules', $data);
    }

    function update_schedule_gender_rules() {
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => (int)$this->input->post('activeFlag'),
            'scheduleList' => $this->input->post('scheduleList')?:[],
            'groupList' => $this->input->post('groupList')?:[],
            'dayOfWeek' => $this->input->post('dayOfWeek'),
            'releaseMinutes' => $this->input->post('releaseMinutes'),
            'femaleSeatCount' => $this->input->post('femaleSeatCount')
        );

        echo $this->api_model->updateScheduleExtrasGenderRules($data);
    }
    
    function bus_utilize(){
        $this->is_logged_in();
         
        $result = $this->api_model->scheduleBusUtilization(array(
            'busCode' => $this->input->post('busCode'),
        ));        
        $result = json_decode($result);
        $data['schedules'] = $result->data;
        
        $this->load->view('site/scheduleextras/schedule-bus-utilize', $data);
    }

    function breakeven_settings() {
        $this->is_logged_in();

        $result = $this->api_model->getBreakevenSettings();
        $result = json_decode($result);
        $data['breakeven_settings'] = $result->data;

        $buses = $this->api_model->getBuses();
        $buses = json_decode($buses);
        $data['buses'] = $buses->data;
        $data['breakeven_setting_type'] = config_item('breakeven_setting_type');

        $this->load->view('site/scheduleextras/breakeven-settings', $data);
    }

    function update_breakeven_settings() {
        $this->is_logged_in();

        echo $this->api_model->updateBreakevenSettings(array(
            'code' => $this->input->post('code'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'bus' => $this->input->post('bus') ?: ['code' => ''],
            'breakevenDetails' => $this->input->post('breakevenDetails') ?: [
                'mileage' => 0,
                'tax' => [],
                'expense' => [],
            ],
        ));
    }
}

?>