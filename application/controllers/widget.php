<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Widget extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
        $this->_user_hash = _get_user_hash();
    }
    
    function today_snapshot(){        
        $this->is_logged_in();
        
        if( !has_action_rights('SCH-EDIT') && 
            !has_action_rights('USR-FILTER-TRANS') &&
            !has_action_rights('UBR-USER-FILTER') &&
            !has_action_rights('SCH-VIEW-TRIPS')
          ) {
            echo json_encode(array());
            return;
        }
        
        $param = array(
            'queryCode' => 'RQG3P2404',
            'fromDate' => date('Y-m-d'),
            'toDate' => date('Y-m-d')                
        );

        $p_key = _get_namespace_id().'_today_snapshot_'.md5(http_build_query($param));
        if (!($result = $this->rediscache->get($p_key))) {
            $result = $this->api_model->getDynamicReportDataWithMap($param);
            $this->rediscache->set($p_key, $result, 1800); //30 mins
        }
        $result = json_decode($result);
                
        $feeds = array();
        foreach ($result->data as $entity) {
          $feeds[$entity->trip_code][$entity->attribute_type] =   $entity->attribute_value; 
        }
        $info = array(
            't_trips'=>0, 
            't_seats'=>0,
            't_booked_seats' => 0,
            't_pbooked_seats' => 0,
            't_cancel_seats' => 0,
            't_vacant_seats' => 0,
            't_booked_amount' => 0,
            'occupancy' => 0
        );
        $trip_summary = array();
        $grp_sales = array();
        $grp_revenue = array();
        
        foreach ($feeds as $tripid => $trip) {
            $trip_info = array(
                'trip_id' => $tripid,
                'seats'=>$trip['TRIP_ST_CNT'],
                'bus_type'=>$trip['TRIP_BUS_TYPE'],
                'travel_date'=>$trip['TRIP_DATE'],
                'groups'=>$trip['GR_LIST'],
                'route'=>$trip['TRIP_ROUTE'],
                
                'confirm_booked_seats' => 0,
                'pbooked_seats' => 0,
                'total_booked_seats' => 0,
                'vacant_seats' => 0,
                'cancel_seats' => 0,
                'occupancy' => 0
            );
            
            $info['t_trips']++;
            $info['t_seats'] += $trip['TRIP_ST_CNT'];            
            $grps = explode(',', $trip['GR_LIST']);
            foreach($grps as $k=>$grp){
                $tgrp = _strip_space($grp);
                //  consolidated occupancy
                $info['t_booked_seats'] += $trip['BO_COUNT_'.$tgrp];
                $info['t_pbooked_seats'] += $trip['PH_COUNT_'.$tgrp];
                $info['t_cancel_seats'] += $trip['CA_COUNT_'.$tgrp];
                
                //  group wise summary
                $grp_sales[$grp] += $trip['BO_COUNT_'.$tgrp];
                $grp_sales[$grp] += $trip['PH_COUNT_'.$tgrp];
                
                //  group wise revenue
                $grp_revenue[$grp] += $trip['BO_AMT_'.$tgrp];
                $grp_revenue[$grp] += $trip['PH_BO_AMT_'.$tgrp];
                
                //  trip wise summary
                $trip_info['confirm_booked_seats'] +=  $trip['BO_COUNT_'.$tgrp];
                $trip_info['pbooked_seats'] +=  $trip['PH_COUNT_'.$tgrp];
                $trip_info['cancel_seats'] +=  $trip['CA_COUNT_'.$tgrp];
                
                //$info['t_booked_amount'] += $trip['BO_AMT_'.$grp];
            }
            //  trip wise summary
            //$trip_info['confirm_booked_seats'] = $trip_info['confirm_booked_seats'] - $trip_info['cancel_seats'];
            $trip_info['total_booked_seats'] =  $trip_info['confirm_booked_seats']+$trip_info['pbooked_seats'];
            $trip_info['vacant_seats'] = $trip_info['seats'] - $trip_info['total_booked_seats'];
            $trip_info['occupancy'] = ceil( ($trip_info['total_booked_seats'] / $trip_info['seats']) * 100);            
            $trip_summary[] = $trip_info;
        }
        
        //  consolidated occupancy
        //$info['t_booked_seats'] = $info['t_booked_seats'] - $info['t_cancel_seats'];
        $info['t_vacant_seats'] = $info['t_seats'] - ( $info['t_booked_seats'] + $info['t_pbooked_seats'] );
        $info['occupancy'] = ceil( ( ( $info['t_booked_seats'] + $info['t_pbooked_seats'] ) / $info['t_seats']) * 100 );
        
        //  output data
        $data['today_occupancy'] = $info;
        $data['groups'] = $grp_sales;
        $data['groups_revenue'] = $grp_revenue;
        $data['trip_summary'] = $trip_summary;
        $data['response_datetime'] = $result->datetime;
        
        echo json_encode($data);
    }

    function get_notification() {
        $this->is_logged_in();
        $notify = $this->api_model->getNotificationsUser(array('authtoken' => $this->_user_hash));
        $user_notify = json_decode($notify);
        $data['notify'] = array();
       
        if (is_array($user_notify->data)) {

            foreach ($user_notify->data as $notify) {
                $notify->newImageFlag = 0;
                $now = time();
                $activedate = strtotime($notify->activeFrom);
                $datediff = $now - $activedate;
                $activeFrom = floor($datediff / (60 * 60 * 24));
                if ($activeFrom < 3) {
                   $notify->newImageFlag = 1;
                }
                $data['notify'][] = $notify;
            }
       
            $this->load->view('site/widgets/notification', $data);
        }
    }
    function in_array_multiple($needle, $haystack, $strict = false) {
        foreach ($haystack as $item) {
            if (($strict ? $item === $needle : $item == $needle) || (is_array($item) && $this->in_array_multiple($needle, $item, $strict))) {
                return true;
            }
        }
        return false;
    }
    
    public function get_today_trips(){ 
	$this->is_logged_in();
        
        $token = $this->session->userdata('namespace_id');
        $today_trips_key = $token.'_TODAY_TRIPS';       
        if( !$result = $this->rediscache->get($today_trips_key) ) {            
            $result = $this->api_model->getScheduleTrip(
                   array('tripDate'=> date("Y-m-d"))
                );
            //  3 hours
            $this->rediscache->set($today_trips_key, $result, 10800);
        } 
//        
//        if( !$result = $this->cache->file->get($today_trips_key) ) {            
//           $result = $this->api_model->getScheduleTrip(
//                   array('tripDate'=> date("Y-m-d"))
//                );
//            //  3 hours
//            $this->cache->file->save($today_trips_key, $result, 10800);
//        }      
        
        $result = json_decode($result);
        $this->load->view('site/widgets/today_trips', array(
                'trips' => $result->data)
            );
    }
    
     public function get_active_schedule(){ 
        $this->is_logged_in();
        $data = array();
        $schedulesactive = $this->api_model->getScheduleByType(array('type' => 'none'));
        $schedulesactive = json_decode($schedulesactive);
        $schedulesactive = $schedulesactive->data;

        foreach ($schedulesactive AS $key => $list) {
            $busCategory = $list->bus->categoryCode;
            $busType = bus_category_string($busCategory);

            $endTime = '';
            $endStation = '';
            $startStation = '';
            $startTime = '';
            $h = '';
            $station = array();
            $fare = array();
            if (is_array($list->stageList)) {
                $no_stages = count($list->stageList);
                if (count($list->stageList) > 0) {
                    $startStation = $list->stageList[0]->fromStation->name;
                    $startTime = gmdate("h:i A", ($list->stageList[0]->fromStation->dateTime * 60));

                    if (!empty($list->stageList[$no_stages - 1])) {
                        $endStation = $list->stageList[$no_stages - 1]->fromStation->name;
                        $hm = $list->stageList[$no_stages - 1]->fromStation->dateTime;
                        if ($hm > 1439 && $hm < 2879) {
                            $h = 'Next Day';
                        } else if ($dateFlag == 2) {
                            $h = 'Third Day';
                        }
                        $endTime = gmdate("h:i A", ($hm * 60)) . " " . $h;
                    }
                }

                foreach ($list->stageList AS $k => $stl) {
                    foreach ($stl->stageFare AS $f) {
                        $fare[] = $f->fare;
                    }

                    $fromStationPoint = array();
                    $fromStationPointTime = array();
                    $tostationPoint = array();
                    $toStationPointTime = array();

                    foreach ($stl->fromStation->stationPoint AS $p) {
                        $fromStationPoint[] = array('name' => $p->name, 'stationPointTime' => gmdate("h:i A", (($p->dateTime) * 60)));
                    }

                    if (!$this->in_array_multiple($stl->fromStation->name, $station)) {
                        $station[] = array(
                            'station' => $stl->fromStation->name,
                            'stationTime' => gmdate("h:i A", ($stl->fromStation->dateTime * 60)),
                            'stationPoint' => $fromStationPoint
                        );
                    }
                }
            }
            $max = '';
            $min = '';
            $fare = array_unique($fare);
            if (count($fare) > 1) {
                $max = max($fare);
                $min = min($fare);
            } else {
                $min = $fare[0];
            }
//            $date_format = $this->session->userdata('date_format');

            $temp[] = array(
                'name' => $list->name,
                'code' => $list->code,
                'activeFrom' => $list->activeFrom,
                'activeTo' => $list->activeTo,
                'BusName' => $list->bus->name,
                'BusCode' => $list->bus->code,
                'BusType' => $busType,
                'station' => $station,
                'faremax' => $max,
                'faremin' => $min,
                'fromStationTime' => $startTime,
                'toStationTime' => $endTime,
                'startStation' => $startStation,
                'endStation' => $endStation
            );
        }
        $data['schedulesactive'] = $temp;
        $this->load->view('site/widgets/active-schedules', $data);
    }
    
    function get_recent_bookings() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RPTTRUR01'            
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data); 
        $result = json_decode($result);
        
        $this->load->view('site/widgets/recent_bookings', array('tickets' => $result->data));
    }
    
    function get_payment_vouchers() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQFATL54',
            'transactionType' => 'PAVR',
            'acknowledmentStatus' => 'NA',            
            'transactionMode' => 'NA',
            'userCode' => _get_user_id(),
            'toDate' => date('Y-m-d', mktime(0, 0, 0, date("m")  , date("d"), date("Y")) ),
            'fromDate' => date('Y-m-d', mktime(0, 0, 0, date("m")  , date("d")-30, date("Y")) ),          
        );
        
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['voucher'] = $result->data;        
        $data['f_t_type'] = config_item('transaction_type');
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['f_a_status'] = config_item('acknowledge_status');
        
        $this->load->view('site/widgets/payment_vouchers', $data);
    }
}
