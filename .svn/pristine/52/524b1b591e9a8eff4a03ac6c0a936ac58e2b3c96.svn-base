<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Schedules extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->is_logged_in();
        $this->_user_hash = _get_user_hash();
    }

    public function index() {
        $this->is_logged_in();
        $this->schedules();
    }

    public function schedules() {
        //_include_js('assets/js/apps/tisa_mail.js');
        _include_js('assets/js/pages/schedules-list.js', 'init_schedules_page');
        _include_js('assets/js/pages/schedule-trips.js');
        _include_js('assets/js/pages/schedule-extras.js');
        _include_js('assets/js/pages/livetrack.js');
        //_include_js('assets/js/fixed-table-rc.js');

        $this->load->view('site/schedules/schedules');
    }

    public function schedules_refresh() {
        $this->is_logged_in();
        $code = $this->input->post('code');
        echo $this->api_model->updateSchedulesRefresh(array('scheduleCode' => $code));
    }

    public function export_schedule() {
        $this->is_logged_in();
        $code = $this->input->get('code');
        if ($code != '') {
            //echo $schedules = $this->api_model->getSchedulesBycode(array('code' => $code));
            $busSchedule = $this->api_model->getBustypeScheduleBycode(array('code' => $code));
            $bus = json_decode($busSchedule);
            $busType = bus_category_string($bus->data[0]->bus->categoryCode);

            $station = $this->api_model->getSchedulesStationBycode(array('code' => $code));
            $station = json_decode($station);
            $station = $station->data;

            $content = '<div class="text-muted align-right">press "esc" to close</div><br><br><b>Route : </b>'.$station[0]->station->name.' To '.$station[count($station)-1]->station->name;
            $content .= '<br><b>DOJ :</b>  ';
            $content .= '<br><b>Timing : </b>'.gmdate("h:i A", ($station[0]->minitues * 60)).' - '.gmdate("h:i A", ($station[count($station)-1]->minitues * 60));
            $content .= '<br><b>Bus Type : </b>'.$busType;
            $content .= '<br><b>Via Routes : </b><br>';

            $routes = $this->api_model->getRoutesFareScheduleByCode(array('code' => $code));
            $routes = json_decode($routes);
            $routes = $routes->data;
            $t_array = array();
            foreach ($routes AS $key => $r) {
                $t = $r->fromStation->name.' To '.$r->toStation->name;
                if(!in_array($t, $t_array)) {
                    $t_array[] = $t;
                }
            }
            $content .= implode('<br> ', $t_array);
            echo $content;
        }
    }

    public function edit_schedules() {
        $this->is_logged_in();

        _include_js('assets/js/pages/schedules-bus.js', '_init_schedule_wizard');
        $data = array();
        $code = $this->input->get('i');
        $tab = $this->input->get('t');
        // $code = 'SHE69C105';
        //schedule data

        if ($code != '') {
            $schedules = $this->api_model->getSchedulesBycode(array('code' => $code));
            $schedules = json_decode($schedules);
            foreach ($schedules->data[0]->scheduleTagList as $row) {
                $basictags[$row->code] = $row;
            }
            $data['busbasictags'] = $basictags;
                
            $data['schedules'] = $schedules->data;
            $busSchedule = $this->api_model->getBustypeScheduleBycode(array('code' => $code));
            $busSchedule = json_decode($busSchedule);
            $busSchedule = $busSchedule->data;
            $data['busschedule'] = $busSchedule;

            if (count($busSchedule) > 0) {
                foreach ($busSchedule AS $bs) {
                    foreach ($bs->amenities AS $amt) {
                        $atmp[] = $amt->code;
                    }
                }
                $data['busamenities'] = $atmp;
            }
            if (isset($tab) && $tab != '')
                $data['tab'] = $tab;
        }


        $profile = $this->api_model->getProfile(array('authtoken' => $this->_user_hash));
        $pro = json_decode($profile);
        $data['profile'] = $pro->data;


        $amenitiesDetails = $this->api_model->getAmenities(array('authtoken' => $this->_user_hash));
        $amenitiesDetail = json_decode($amenitiesDetails);
        $data['amenities'] = $amenitiesDetail->data;

        $buses = $this->api_model->getBuses();
        $buses = json_decode($buses);
        $tmp = array();

        $bcode = $busSchedule[0]->bus->code;

        foreach($buses->data as $b) {
            if($b->activeFlag != 1) {
                continue;
            }
            $tmp[] = array(
                'code' => $b->code,
                'name' => $b->name,
                'seatCount' => $b->seatCount
            );
        }

        $data['buses'] = $tmp;

        $bus_category = $this->api_model->getBusCategory();
        $bus_category = json_decode($bus_category);

        $gstlist = $this->api_model->getScheduleTaxMaster();
        $gstlist = json_decode($gstlist);
        $data['taxlist'] = $gstlist->data;

        $taglist = $this->api_model->getScheduleTags();
        $taglist = json_decode($taglist);
        $data['taglist'] = $taglist->data;

        $seattype = $this->api_model->getBusSeatType();
        $busseat = json_decode($seattype);
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

        $this->load->view('site/schedules/edit-schedules', $data);
    }

    public function update_schedules() {
        $this->is_logged_in();
        $dayofweek = $this->input->post('dayOfWeek');
        $dayofweek = implode("", $dayofweek);
        $lactiveFrom = $this->input->post('lactiveFrom'); //lactiveFrom

        $tax = ($this->input->post('serviceTax')!="") ? $this->input->post('serviceTax') : 0;
        $gst_tax = ($this->input->post('tax')!="") ? $this->input->post('tax') : 0;

        $activeFlag = $this->input->post('activeFlag');
        if ($activeFlag == '')
            $activeFlag = 1;

        if (isset($lactiveFrom) && $lactiveFrom != '') {
            $data = array(
                'activeTo' => trim($this->input->post('lactiveTo')),
                'activeFrom' => trim($this->input->post('lactiveFrom')),
                'name' => $this->input->post('ldescription'),
                'dayOfWeek' => $dayofweek,
                'code' => $this->input->post('ecode'),
                // "lookup" => array("code" => $this->input->post('code')),
                'lookupCode' => $this->input->post('code'),
                'activeFlag' => $activeFlag,
                'serviceTax' => $tax,
                'scheduleTagList' => $this->input->post('scheduleTagList') ?: [],
                'sectorList' => $this->input->post('sectorList') ?: [],
                'tax' => array('code'=>$gst_tax),
            );
        } else {

            $tag = $this->input->post('tag');
            $tag_code = '';

            $list = $this->api_model->getScheduleTag();
            $tags_m = json_decode($list);

            foreach($tags_m as $t) {
                if( strtolower($t->name) == strtolower($tag) ){
                    $tag_code = $t->code;
                }
            }

            if(!empty($tag) && empty($tag_code)) { //   create new tag code
                $result = $this->api_model->createScheduleTag(array('name'=>$tag));
                $result = json_decode($result);
                if($result->status==1) {
                   $tag_code =  $result->data->code;
                }
            }

            $data = array(
                'name' => $this->input->post('name'),
                'serviceNumber' => $this->input->post('serviceNumber'),
                'activeFlag' => $activeFlag,
                'mobileTicketFlag' => $this->input->post('mobileTicketFlag'),
                'boardingReportingMinitues' => $this->input->post('boardingReportingMinitues'),
                'displayName' => $this->input->post('displayName'),
                'pnrStartCode' => $this->input->post('pnrStartCode'),
            	'apiDisplayName' => $this->input->post('apiDisplayname'),
                'activeTo' => trim($this->input->post('activeTo')),
                'activeFrom' => trim($this->input->post('activeFrom')),
                'code' => $this->input->post('code'),
                'serviceTax' => $tax,
                'tax' => array('code'=>$gst_tax),
                'dayOfWeek' => $dayofweek,
                'scheduleTagList' => $this->input->post('scheduleTagList')?: [],
                'sectorList' => $this->input->post('sectorList') ?: [],
                'category' => array('code'=>$tag_code),
            );


        }

        if($this->input->post('ecode')) {
            echo $this->api_model->updateSchedule($data);
            return;
        }

        //  validating advance booking
        $activeFrom = strtotime(trim($this->input->post('activeFrom')));
        $activeTo = strtotime(trim($this->input->post('activeTo')));
        $enddate = strtotime("+4 months", $activeTo);

        $fromdate = date("Y-m-d");
        $enddate = date("Y-m-d", $enddate);

        $data1 = array(
            'queryCode' => 'RQF3K85511',
            'fromDate' => $fromdate,
            'toDate' => $enddate,
            'scheduleCode' => $this->input->post('code'),
            'travelDateFlag' => 1,
            'fromStationCode' => 'NA',
            'toStationCode' => 'NA',
            'groupCode' => 'NA',
            'userCode' => 'NA',
            'tagCode' => 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data1);
        $result = json_decode($result);
        $t_book_summary = array();
        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    $traveldate = strtotime($result->data[$i]->travel_date);
                    if ($result->data[$i]->ticket_status_code == "BO" && !($traveldate >= $activeFrom && $traveldate <= $activeTo)) {
                        $t_book_summary[$result->data[$i]->travel_date] += $result->data[$i]->booked_count;
                        $t_book_summary[$result->data[$i]->travel_date] += $result->data[$i]->phone_booked_count;
                        $t_book_summary[$result->data[$i]->travel_date] += $result->data[$i]->phone_blocked_count;
                    }

                }
            }
        }
        if(count($t_book_summary)>0) {
            $error = array('status'=>110,'errorDesc'=>'Advance booking available after the end date choosed.');
            echo json_encode($error);
        } else {
            echo $this->api_model->updateSchedule($data);
        }
    }

    public function can_edit_bus_layout(){
        //  validating advance booking

        $data = array('scheduleCode' => $this->input->post('code'));

        $result = $this->api_model->validateCanEditBusInSchedule($data);
        $result = json_decode($result);

        if($result->status==0) {
            $error = array('status'=>110,'errorDesc'=>'Sorry, Advance booking found, not allowing to change bus layout.');
        } else {
            $error = array('status'=>1);
        }
        echo json_encode($error);
    }

    public function delete_schedules_exception() {
        $this->is_logged_in();
        $data = array(
            'activeTo' => trim($this->input->post('activeTo')),
            'activeFrom' => trim($this->input->post('activeFrom')),
            'name' => $this->input->post('name'),
            'dayOfWeek' => $this->input->post('days'),
            'code' => $this->input->post('ecode'),
            'lookupCode' => $this->input->post('code'),
            'activeFlag' => 2
        );
        echo $this->api_model->updateSchedule($data);
    }

    public function delete_schedule() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => 2,
            'code' => $this->input->post('code'),
        );
        echo $this->api_model->updateSchedule($data);
    }

    public function get_schedules_station() {
        $this->is_logged_in();
        $code = $this->input->post('code');
        //$code = 'SHE69C105';
        //schedule data

        $stations = $this->api_model->getCommerceStation(array('authtoken' => $this->_user_hash));
        $stations = json_decode($stations);
        $data['stations'] = $stations->data;

        $station = $this->api_model->getSchedulesStationBycode(array('code' => $code));
        $station = json_decode($station);
        $station = $station->data;


        foreach ($station AS $key => $st) {
            $station[$key]->hoursminitues = gmdate("h:i A", ($st->minitues * 60));
            foreach ($st->overrideList AS $ekey => $est) {
                //$station[$key]->overrideList[$ekey]->hoursminitues = gmdate("h:i A", (($st->minitues + $est->minitues) * 60));
                $station[$key]->overrideList[$ekey]->hoursminitues = gmdate("h:i A", ($est->minitues * 60));
            }
            $stationMinitues[$st->station->code] = $st->minitues;
        }
        $stationpoint = $this->api_model->getSchedulesStationPointsBycode(array('stationcode' => $code));
        $stationpoint = json_decode($stationpoint);
        $stationpoint = $stationpoint->data;
        $tmp = array();
        foreach ($stationpoint AS $stp) {
            $stp->hoursminitues = gmdate("h:i A", (($stationMinitues[$stp->station->code] + $stp->minitues) * 60));
            foreach ((array) $stp->overrideList AS $ekey => $est) {
                $stp->overrideList[$ekey]->hoursminitues = gmdate("h:i A", (($stationMinitues[$stp->station->code] + $stp->minitues + $est->minitues) * 60));
            }
            $tmp[$stp->station->code][] = $stp;
        }
        $data['station'] = $station;
        $data['stationpoint'] = $tmp;
        $this->load->view('site/schedules/get-schedules-station', $data);
    }

    public function get_stationpoint_by_station_schedules() {
        $this->is_logged_in();
        $station_code = $this->input->post('stationCode');
        echo $this->api_model->getStationPointsByStation(array('authtoken' => $this->_user_hash, 'stationcode' => $station_code));
    }

    public function update_schedules_station() {
        $this->is_logged_in();
        $schedulescodes = $this->input->post('code');
        $dayofweek = $this->input->post('dayOfWeek');
        $eactiveFrom = $this->input->post('eactiveFrom');


        //Check dayofweek is not empty
        if (isset($dayofweek) && $dayofweek != '') {
            $dayofweek = implode("", $dayofweek);
        }


        if (isset($eactiveFrom) && $eactiveFrom != '') {
            $stationdata[] = array(
                'schedule' => array('code' => $this->input->post('code')),
                'station' => array('code' => $this->input->post('stationcode')),
                'activeTo' => $this->input->post('eactiveTo'),
                'activeFrom' => $eactiveFrom,
                'dayOfWeek' => $dayofweek,
                'activeFlag' => '1',
                'description' => $this->input->post('description'),
                'minitues' => $this->input->post('stationtime'),
                'lookupCode' => $this->input->post('stationschedules'),
                'code' => $this->input->post('secode')
            );
        } else {
            $hm = $this->input->post('stationtime');
            //$minutes = $this->hoursTominutes($hm);
            $dateFlag = $this->input->post('dateFlag');
            if ($dateFlag == 2) {
                $hm = $hm + 1440;
            } else if ($dateFlag == 3) {
                $hm = $hm + 2880;
            }
            $stationdata[] = array(
                'schedule' => array('code' => $schedulescodes),
                'activeFlag' => $this->input->post('activeFlag'),
                'station' => array('code' => $this->input->post('stationcode')),
                'code' => $this->input->post('stationschedules'),
                'stationSequence' => $this->input->post('stationSequence'),
                'mobileNumber' => $this->input->post('mobileNumber') ?: 'NA',
                'minitues' => $hm,
            );
            $activeFrom = $this->input->post('stationActiveFrom');
            if (!empty($activeFrom)) {
                $stationdata[0]['activeTo'] = $this->input->post('stationActiveTo');
                $stationdata[0]['activeFrom'] = $this->input->post('stationActiveFrom');
            }
            if (isset($dayofweek) && !empty($dayofweek)) {
                $stationdata[0]['dayOfWeek'] = $dayofweek;
            }
        }
        echo $this->api_model->updateStationSchedule($stationdata);
    }

    public function update_schedules_station_sequence() {
        $this->is_logged_in();

        $stationdata[] = array(
            'code' => $this->input->post('newCode'),
            'activeFlag' => $this->input->post('active_flag'),
            'stationSequence' => $this->input->post('newsequence')
        );

        $stationdata[] = array(
            'code' => $this->input->post('oldcode'),
            'activeFlag' => $this->input->post('active_flag'),
            'stationSequence' => $this->input->post('oldsequence')
        );
        echo $this->api_model->updateStationSchedule($stationdata);
    }

    public function delete_schedules_station_exception() {
        $this->is_logged_in();
        $ecode = $this->input->post('ecode');

        $stationdata[] = array(
            'schedule' => array('code' => $this->input->post('code')),
            'station' => array('code' => $this->input->post('stationcode')),
            'activeFlag' => '2',
            'lookupCode' => $this->input->post('sscode'),
            'code' => $ecode
        );
        echo $this->api_model->updateStationSchedule($stationdata);
    }

    function delete_schedules_station() {
        $this->is_logged_in();
        $schedulescodes = $this->input->post('code');
        $dayofweek = $this->input->post('dayOfWeek');
        $dayofweek = implode("", $dayofweek);
        $hm = $this->input->post('stationtime');
        $minutes = $this->hoursTominutes($hm);

        $stationdata[] = array(
            'schedule' => array('code' => $schedulescodes),
            'code' => $this->input->post('stationschedules'),
            'station' => array('code' => $this->input->post('stationcode')),
            'activeTo' => trim($this->input->post('activeTo')),
            'activeFrom' => trim($this->input->post('activeFrom')),
            'mobileNumber' => $this->input->post('mobileNumber') ?: 'NA',
            'minitues' => $minutes,
            'dayOfWeek' => $dayofweek,
            'activeFlag' => 2
        );
        echo $this->api_model->updateStationSchedule($stationdata);
    }

    function update_schedules_bustype() {
        $amenities = $this->input->post('amenities');
        $busCode = $this->input->post('busCode');
        foreach ($amenities AS $amt) {
            $amtcode[] = array(
                "code" => $amt
            );
        }
        $data = array(
            'schedule' => array('code' => $this->input->post('code')),
            'bus' => array('code' => $this->input->post('bustype')),
            'code' => $busCode,
            'activeFlag' => 1,
            'amenities' => $amtcode
        );
        echo $this->api_model->updateBustypeSchedule($data);
    }

    function update_schedules_station_point() {
        $this->is_logged_in();
        $schedulescodes = $this->input->post('code');
        $dayofweek = $this->input->post('dayOfWeek');
        if (isset($dayofweek) && $dayofweek != '')
            $dayofweek = implode("", $dayofweek);
        $hm = $this->input->post('stationtime');
        $minutes = $this->hoursTominutes($hm);
        $minutes = $this->input->post('minitues');
        $stationpoint[] = array(
            'schedule' => array('code' => $schedulescodes),
            'activeFlag' => $this->input->post('activeFlag'),
            'station' => array('code' => $this->input->post('station')),
            'code' => $this->input->post('stationPointCode'),
            'creditDebitFlag' => 1,
            'stationPoint' => array('code' => $this->input->post('stationPoint')),
            'minitues' => $minutes,
            "boardingFlag" => $this->input->post('boardingFlag'),
            "droppingFlag" => $this->input->post('droppingFlag'),
            "fare" => $this->input->post('fare') ?: 0,
            'vanRoute' => array('code' => $this->input->post('vanRoute'))
        ); //

        if (isset($dayofweek) && $dayofweek != '') {
            $stationpoint[0]['dayOfWeek'] = $dayofweek;
        }
        if ($this->input->post('activeFrom') != '' && $this->input->post('activeTo') != '') {
            $stationpoint[0]['activeTo'] = trim($this->input->post('activeTo'));
            $stationpoint[0]['activeFrom'] = trim($this->input->post('activeFrom'));
        }


        echo $this->api_model->updateStationPointSchedule($stationpoint);
    }

    function delete_station_point_schedules() {
        $this->is_logged_in();
        $schedulescodes = $this->input->post('code');
        $dayofweek = $this->input->post('dayOfWeek');
        $dayofweek = implode("", $dayofweek);


        $stationpoint[] = array(
            'schedule' => array('code' => $schedulescodes),
            'activeFlag' => 2,
            'station' => array('code' => $this->input->post('station')),
            'activeTo' => $this->input->post('activeTo'),
            'activeFrom' => $this->input->post('activeFrom'),
            'code' => $this->input->post('stationPointCode'),
            'stationPoint' => array('code' => $this->input->post('stationPoint')),
        ); //
        echo $this->api_model->updateStationPointSchedule($stationpoint);
    }

    public function delete_schedules_station_point_exception() {
        $this->is_logged_in();


        $stationdata[] = array(
            'schedule' => array('code' => $this->input->post('code')),
            'station' => array('code' => $this->input->post('stationcode')),
            'stationPoint' => array('code' => $this->input->post('stationpoint')),
            'activeFlag' => '2',
            'lookupCode' => $this->input->post('stationschpoint'),
            'code' => $this->input->post('ecode')
        );
        echo $this->api_model->updateStationPointSchedule($stationdata);
    }

    function get_schedules_routes() {
        $this->is_logged_in();

        // $buscode = "BSE67D54";
        //  $code = "SHE66K85";

        $buscode = $this->input->post('bustype');
        $code = $this->input->post('code');
        $data = array();

        //Station details
        $stations = $this->api_model->getScheduleStationByCode(array('code' => $code));
        $stations = json_decode($stations);
        $stations = $stations->data;
        $data['station'] = $stations;

        $namespaceNames = $this->api_model->getNamespaceStation(array('authtoken' => _get_user_hash()));
        $namespaceNames = json_decode($namespaceNames);
        $namespaceNames = $namespaceNames->data;
        foreach ($namespaceNames AS $ns) {
            $stationName[$ns->code] = $ns->name;
        }
        $data['stationName'] = $stationName;

        //Bus type details

        $bustype = $this->api_model->getBusLayerbyCode(array('buscode' => $buscode));
        $bustype = json_decode($bustype);

        $bustype = $bustype->data;
        $seattype = array();
        foreach ($bustype AS $lay) {
            if (!$this->in_array_multiple($lay->busSeatType->code, $seattype)) {
                $seattype[] = array(
                    'code' => $lay->busSeatType->code,
                    'Type' => $lay->busSeatType->name
                );
            }
        }
        //$seattype = array_unique($seattype);
        $data['seattype'] = $seattype;

        //Groups Details
//        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
//        $GroupDetail = json_decode($GroupDetail);
//        $data['groups'] = $GroupDetail->data;

        //Routes
        $routes = $this->api_model->getRoutesFareScheduleByCode(array('code' => $code));
        $routes = json_decode($routes);
        $routes = $routes->data;
        //if(count($routes)<=0) $routes = array();
        $i = 0;

        foreach ($routes AS $rot) {
            if ($rot->activeFlag == 1 && $rot->schedule->code == $code) {
                $rout[$rot->fromStation->code . $rot->toStation->code]["name"] = $rot->fromStation->name . ' to ' . $rot->toStation->name;
                $rout[$rot->fromStation->code . $rot->toStation->code]["from"] = $rot->fromStation->code;
                $rout[$rot->fromStation->code . $rot->toStation->code]["to"] = $rot->toStation->code;
                $rout[$rot->fromStation->code . $rot->toStation->code]["fare"][$rot->busSeatType->code] = array(
                    'code' => $rot->code,
                    'fromStation' => $rot->fromStation->code,
                    'toStation' => $rot->toStation->code,
                    'busSeatType' => $rot->busSeatType,
                    'group' => $rot->group,
                    'fare' => $rot->fare,
                    'activeFlag' => $rot->activeFlag,
                    'activeTo' => $rot->activeTo,
                    'activeFrom' => $rot->activeFrom,
                    'lookup' => $rot->lookup,
                    'dayOfWeek' => $rot->dayOfWeek,
                    'overrideList' => $rot->overrideList
                );
                $i++;
            }
        }
        $data['routes'] = $rout;

        //$routes = $this->api_model->getRoutesFareScheduleByCode(array('code'=>$code));
        //$routes = json_decode($routes);
        //$routes = $routes->data;
        // if(count($routes)<=0) $routes = array();
        $grp = array();
        foreach ($routes AS $rts) {
            if (!$this->in_array_multiple($rts->group->code, $grp)) {
                $grp[] = array(
                    'code' => $rts->group->code,
                    'name' => $rts->group->name
                );
            }
        }

        $data['routesGroups'] = $grp;

        if ($this->input->post('act') == 1) {
            $this->load->view('site/schedules/get-schedules-act-routes', $data);
        } else {
            $this->load->view('site/schedules/get-schedules-routes', $data);
        }
    }

    function update_routes_fare_schedules() {

        //$code = "SHE66K85";
        $code = $this->input->post('code');
        $group = $this->input->post('group');
        $dayofweek = $this->input->post('dayOfWeek');
        if (isset($dayofweek) && $dayofweek != '')
            $dayofweek = implode("", $dayofweek);

        $fare[] = array(
            'fare' => $this->input->post('fare'),
            'fromStation' => array('code' => $this->input->post('from')),
            'busSeatType' => array('code' => $this->input->post('seatType')),
            'schedule' => array('code' => $code),
            'code' => $this->input->post('Farecode'),
            'toStation' => array('code' => $this->input->post('to')),
            'activeFlag' => $this->input->post('fareStatus')
        );
        if ($group != '') {
            $fare[0]['group'] = array('code' => $group);
        }
        if (isset($dayofweek) && $dayofweek != '') {
            $fare[0]['dayOfWeek'] = $dayofweek;
        }
        if ($this->input->post('routesActiveFrom') != '' && $this->input->post('routesActiveTo') != '') {
            $fare[0]['activeTo'] = trim($this->input->post('routesActiveTo'));
            $fare[0]['activeFrom'] = trim($this->input->post('routesActiveFrom'));
        }
        echo $this->api_model->updateRoutesFareSchedule($fare);
    }

    function update_routes_fare_schedules_v2() {
        $this->is_logged_in();

        $fares = $this->input->post('fares') ?: [];
        $schcode = $this->input->post('schcode');

        $fareList = array();
        foreach ($fares as $row) {
            $fareList[] = array(
                'code' => $row['code'],
                'activeFlag' => $row['activeFlag'],
                'fromStation' => array('code' => $row['fromStation']),
                'toStation' => array('code' => $row['toStation']),
                'schedule' => array('code' => $schcode),
                'busSeatType' => $row['busSeatType'],
                'fare' => $row['fare'],
            );
        }
        echo $this->api_model->updateRoutesFareSchedule(($fareList));
    }

    public function delete_schedules_routes_exception() {
        $this->is_logged_in();

        $fare[] = array(
            'activeFlag' => '2',
            'busSeatType' => array('code' => $this->input->post('seatType')),
            'schedule' => array('code' => $this->input->post('code')),
            'fromStation' => array('code' => $this->input->post('from')),
            'toStation' => array('code' => $this->input->post('to')),
            'lookupCode' => $this->input->post('routeCode'),
            'code' => $this->input->post('ecode')
        );
        echo $this->api_model->updateRoutesFareSchedule($fare);
    }

    function delete_routes_fare_schedules() {
        $code = $this->input->post('Farecode');
        $from = $this->input->post('from');
        $to = $this->input->post('to');
        $seatType = $this->input->post('seatType');
        $schedule = $this->input->post('code');
        $rfare = $this->input->post('fare');

        foreach ($code AS $key => $rot) {
            $fare = array();
            $fare[] = array(
                'fare' => $rfare[$key],
                'fromStation' => array('code' => $from[$key]),
                'busSeatType' => array('code' => $seatType[$key]),
                'schedule' => array('code' => $schedule[$key]),
                'code' => $rot,
                'toStation' => array('code' => $to[$key]),
                'activeFlag' => 2
            );

            $this->api_model->updateRoutesFareSchedule($fare);
        }
        echo json_encode(array('status' => 1));
    }

    function get_schedules_cancel() {
        $this->is_logged_in();
        $code = $this->input->post('code');
        //$code = 'SHE69C105';

        $cancellationDetails = $this->api_model->getAllCancellation(array('authtoken' => $this->_user_hash));
        $cancellist = json_decode($cancellationDetails);
        $data['cancel'] = $cancellist->data;
        $data['policy'] = array('day', 'hour', 'min', 'AM', 'PM');

        foreach ($data['cancel'] AS $csl) {
            $tmp[$csl->code] = $csl->policyList;
        }
        $data['policyList'] = $tmp;
        $cancellist = $this->api_model->getCancelScheduleByCode(array('code' => $code));
        $cancellist = json_decode($cancellist);
        $data['cancellationTerm'] = $cancellist->data;

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);


        foreach ($GroupDetail->data AS $rts) {
            if (!empty($rts->code) && $rts->activeFlag == 1) {
                $grp[] = array(
                    'code' => $rts->code,
                    'name' => $rts->name
                );
            }
        }

        $data['groups'] = $grp;

        /* $routes = $this->api_model->getRoutesFareScheduleByCode(array('code'=>$code));
          $routes = json_decode($routes);
          $routes = $routes->data;
          $grp = array();
          foreach ($routes AS $rts){
          if(!$this->in_array_multiple($rts->group->code, $grp)){
          $grp[] = array(
          'code'=> $rts->group->code,
          'name'=> $rts->group->name
          );
          }
          }

          $data['groups'] = $grp; */

        $this->load->view('site/schedules/get-schedules-cancel', $data);
    }

    function update_schedules_cancel() {
        $this->is_logged_in();
        $cactivefrom = $this->input->post('oactiveFrom');

        if (!empty($cactivefrom) && isset($cactivefrom)) {
            $dayofweek = $this->input->post('dayOfWeek');
            $dayofweek = implode("", $dayofweek);
            $cancel[] = array(
                'schedule' => array('code' => $this->input->post('code')),
                'activeFrom' => $cactivefrom,
                'activeTo' => $this->input->post('oactiveTo'),
                'dayOfWeek' => $dayofweek,
                'cancellationTerm' => array('code' => $this->input->post('cancelpolicy')),
                'lookupCode' => $this->input->post('ccode'),
                'group' => array('code' => $this->input->post('group')),
                'activeFlag' => 1
            );
        } else {
            $cancel[] = array(
                'schedule' => array('code' => $this->input->post('code')),
                'code' => $this->input->post('cancelCode'),
                'cancellationTerm' => array('code' => $this->input->post('policy')),
                'activeFlag' => $this->input->post('activeFlag')
            );
            $group = $this->input->post('group');
            if ($group != '') {
                $cancel[0]['group'] = array('code' => $group);
            }
        }

        echo $this->api_model->updateCancelSchedule($cancel);
    }

    function delete_schedules_cancel_override() {
        $this->is_logged_in();
        $cancel[] = array(
            'schedule' => array('code' => $this->input->post('code')),
            'lookupCode' => $this->input->post('ccode'),
            'code' => $this->input->post('ecode'),
            'activeFlag' => 2
        );
        echo $this->api_model->updateCancelSchedule($cancel);
    }

    function get_booking_schedules() {
        $this->is_logged_in();

        $code = $this->input->post('code');
        //$code = 'SHE69C105';

        /* $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
          $GroupDetail = json_decode($GroupDetail);
          $data['groups'] = $GroupDetail->data; */

        $station = $this->api_model->getSchedulesStationBycode(array('code' => $code));
        $station = json_decode($station);
        $station = $station->data;
        $stationendtime = array();
        foreach ($station AS $key => $st) {
            $stationendtime[$st->station->code] = $st->minitues;
        }

        $routes = $this->api_model->getRoutesFareScheduleByCode(array('code' => $code));
        $routes = json_decode($routes);
        $routes = $routes->data;
        //if(count($routes)<=0) $routes = array();
        $i = 0;

        foreach ($routes AS $rot) {
            if ($rot->activeFlag == 1 && $rot->schedule->code == $code) {
                $rout[$rot->fromStation->code . $rot->toStation->code]["name"] = $rot->fromStation->name . ' to ' . $rot->toStation->name;
                $rout[$rot->fromStation->code . $rot->toStation->code]["from"] = $rot->fromStation->code;
                $rout[$rot->fromStation->code . $rot->toStation->code]["to"] = $rot->toStation->code;
                $rout[$rot->fromStation->code . $rot->toStation->code]["fare"][] = array(
                    'code' => $rot->code,
                    'fromStation' => $rot->fromStation->code,
                    'toStation' => $rot->toStation->code,
                    'busSeatType' => $rot->busSeatType,
                    'group' => $rot->group,
                    'fare' => $rot->fare,
                    'activeFlag' => $rot->activeFlag,
                    'activeTo' => $rot->activeTo,
                    'activeFrom' => $rot->activeFrom,
                    'lookup' => $rot->lookup,
                    'dayOfWeek' => $rot->dayOfWeek,
                    'overrideList' => $rot->overrideList
                );
                $i++;
            }
        }
        $data['routes'] = $rout;


        /* $routes = $this->api_model->getRoutesFareScheduleByCode(array('code'=>$code));
          $routes = json_decode($routes);
          $routes = $routes->data;
          $grp = array();
          foreach ($routes AS $rts){
          if(!$this->in_array_multiple($rts->group->code, $grp)){
          $grp[] = array(
          'code'=> $rts->group->code,
          'name'=> $rts->group->name
          );
          }
          }

          $data['groups'] = $grp; */

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);


        foreach ($GroupDetail->data AS $rts) {
            if (!empty($rts->code) && $rts->activeFlag == 1) {
                $grp[] = array(
                    'code' => $rts->code,
                    'name' => $rts->name
                );
            }
        }

        $data['groups'] = $grp;


        $booking = $this->api_model->getBookingScheduleByCode(array('code' => $code));
        $booking = json_decode($booking);

        $booking = $booking->data;

        foreach ($booking AS $key => $bk) {
            $openTime = $this->minutesTodayshours($bk->openMinitues);
            if ($bk->closeMinitues != -1) {
                if($bk->fromStation->code!='') {
                    $time_date = $stationendtime[$bk->fromStation->code] - $bk->closeMinitues;
                    $CloseTime = $this->minutesTohoursminutes($time_date);
                    $booking[$key]->CloseTime = "Closed  at " . date('h:i A', strtotime($CloseTime));
                } else {
                    $CloseTime = $this->formatMinutesToHours($bk->closeMinitues);
                    $booking[$key]->CloseTime = "Closed " . $CloseTime.' before each stage';
                }
            } else {
                $booking[$key]->CloseTime = "Till last boarding point";
            }
            foreach ($bk->overrideList AS $ekey => $ebk) {
                if ($ebk->openMinitues != -1) {
                    $booking[$key]->overrideList[$ekey]->openTime = $this->minutesTodayshours($ebk->openMinitues);
                }

                if ($ebk->closeMinitues != -1) {
                    $time_date = (strtotime($this->minutesTohoursminutes($ebk->closeMinitues)) - strtotime($stationendtime)) / 60;
                    $CloseTime = $this->minutesTohoursminutes($time_date);
                    $booking[$key]->overrideList[$ekey]->CloseTime = "Closed  at " . date('h:i A', strtotime($CloseTime));
                } else {
                    $booking[$key]->overrideList[$ekey]->CloseTime = " - ";
                }
            }
            $booking[$key]->openTime = $openTime;
        }

        $data['booking'] = $booking;
        if ($this->input->post('act') == 1) {
            $this->load->view('site/schedules/get-booking-act-schedules', $data);
        } else {
            $this->load->view('site/schedules/get-booking-schedules', $data);
        }
    }

    function update_schedules_booking() {
        $this->is_logged_in();
        $odays = $this->input->post('odays');
        $ohours = $this->input->post('ohours');
        $omin = $this->input->post('omin');
        $clmin = $this->input->post('chours');
        $cmin = $this->input->post('cmin');
        $group = $this->input->post('group');
        $bcode = $this->input->post('bookingcode');
        $code = $this->input->post('code');
        $schcode = $this->input->post('schcode');

        $from = '';
        $to = '';
        $stage = $this->input->post('stg');
        if($stage != ''){
           $stg_exp = explode('-',$stage);
           $from = $stg_exp[0];
           $to = $stg_exp[1];
        }

        $opmin = $this->dayshoursTominutes($odays, $ohours, $omin);
        /* $clmin = $this->hoursTominutes($chours . "." . $cmin); */
        /* $from = $this->input->post('activeFrom');
          $to = $this->input->post('activeTo'); */
        $dayofweek = $this->input->post('dayOfWeek');
        $dayofweek = implode("", $dayofweek);
        $rfrom = $this->input->post('ractiveFrom');
        $status = $this->input->post('status');

        $adv_dayofweek = $this->input->post('adv_dayOfWeek');
        $adv_from = $this->input->post('adv_from');
        $adv_to = $this->input->post('adv_to');

        if($status=='') $status = 1;

        if (isset($rfrom) && $rfrom != '') {
            if ($omin == "") {
                $opmin = $this->input->post('opentime');
            }
            $booking[] = array(
                "code" => $code,
                'activeTo' => $this->input->post('ractiveTo'),
                "activeFrom" => $rfrom,
                "dayOfWeek" => $dayofweek,
                "schedule" => array(
                    "code" => $schcode
                ),
                "allowBookingFlag" => $status,
                "activeFlag" => $this->input->post('activeFlag'),
                "lookupCode" => $this->input->post('rcode'),
                "openMinitues" => $opmin, //$opmin
                "closeMinitues" => $this->input->post('closetime') //
            );
        } else {
            $booking[] = array(
                "code" => $code,
                "activeFlag" => "1",
                "dayOfWeek" => $adv_dayofweek,
                "schedule" => array(
                    "code" => $schcode
                ),
                "allowBookingFlag" => $status,
                "openMinitues" => $opmin,
                "closeMinitues" => $clmin,
            );
            if($adv_from != '') {
                $booking[0]['activeFrom'] = $adv_from;
            }
            if($adv_to != '') {
                $booking[0]['activeTo'] = $adv_to;
            }
        }

        if (!empty($group)) {
                $booking[0]['group'] = array('code' => $group);
        }

        if (!empty($from)) {
            $booking[0]['fromStation'] = array('code' => $from);
            $booking[0]['toStation'] = array('code' => $to);
        }

        echo $this->api_model->updateBookingSchedule($booking);
    }

    function delete_booking_schedules() {
        $this->is_logged_in();
        $code = $this->input->post('code');
        $bcode = $this->input->post('bCode');
        $ecode = $this->input->post('ecode');
        if (isset($ecode) && $ecode != '') {
            $booking[] = array(
                "schedule" => array(
                    "code" => $code
                ),
                "allowBookingFlag" => "1",
                "activeFlag" => 2,
                "lookupCode" => $this->input->post('rcode'),
                "code" => $ecode
            );
        } else {
            $booking[] = array(
                "activeFlag" => "2",
                "schedule" => array(
                    "code" => $code
                ),
                "code" => $bcode
            );
        }
        echo $this->api_model->updateBookingSchedule($booking);
    }

    function get_bus_seatmap() {
        $this->is_logged_in();
        $data = array();

        $code = $this->input->post('code');
        //$code = 'SHE69C105';
        //Bus Layout
        $bcode = $this->input->post('busType');

        // $bcode ='BSE6BA89';
        $buslayer = $this->api_model->getBusLayerbyCode(array('buscode' => $bcode));
        $buslayer = json_decode($buslayer);
        $data['busseatlayer'] = $buslayer->data;

        $l1x = array();
        $l1x = array();
        $l2x = array();
        $l2y = array();
        foreach ($buslayer->data AS $buslay) {
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

        $this->load->view('site/schedules/get-bus-seatmap', $data);
    }

    function get_seat_visiblity_schedules() {
        $this->is_logged_in();
        $data = array();

        $code = $this->input->post('code');
        //$code = 'SHE69C105';
        //User list
        $userDetails = $this->api_model->getUser();
        $userDetail = json_decode($userDetails);
        $data['users'] = $userDetail->data;

        //Group list
        /*  $routes = $this->api_model->getRoutesFareScheduleByCode(array('code'=>$code));
          $routes = json_decode($routes);
          $routes = $routes->data;
          $grp = array();
          foreach ($routes AS $rts){
          if(!$this->in_array_multiple($rts->group->code, $grp)){
          $grp[] = array(
          'code'=> $rts->group->code,
          'name'=> $rts->group->name
          );
          }
          } */

        //$data['groups'] = $grp;


        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);


        foreach ($GroupDetail->data AS $rts) {
            if (!empty($rts->code) && $rts->activeFlag == 1) {
                $grp[] = array(
                    'code' => $rts->code,
                    'name' => $rts->name
                );
            }
        }

        $data['groups'] = $grp;

        //Bus Layout
        $bcode = $this->input->post('busType');

        // $bcode ='BSE6BA89';
        $buslayer = $this->api_model->getBusLayerbyCode(array('buscode' => $bcode));
        $buslayer = json_decode($buslayer);
        $data['busseatlayer'] = $buslayer->data;
        $bus_category = $this->api_model->getBusCategory();
        $bus_category = json_decode($bus_category);

        $temp = array();

        foreach ($bus_category->data AS $buscat) {
            $tmp = array();
            foreach ($buscat->categoryList AS $sub) {
                $tmp[$sub->code] = $sub->name;
            }
            $temp[preg_replace('/\s+/', '', $buscat->code)] = $tmp;
        }
        $data['categoryList'] = $temp;

        $l1x = array();
        $l1x = array();
        $l2x = array();
        $l2y = array();
        foreach ($buslayer->data AS $buslay) {
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

        //Routes
        $routes = $this->api_model->getRoutesFareScheduleByCode(array('code' => $code));
        $routes = json_decode($routes);
        $routes = $routes->data;
        //if(count($routes)<=0) $routes = array();
        $i = 0;

        foreach ($routes AS $rot) {
            if ($rot->activeFlag == 1 && $rot->schedule->code == $code) {
                $rout[$rot->fromStation->code . $rot->toStation->code]["name"] = $rot->fromStation->name . ' - ' . $rot->toStation->name;
                $rout[$rot->fromStation->code . $rot->toStation->code]["from"] = $rot->fromStation->code;
                $rout[$rot->fromStation->code . $rot->toStation->code]["to"] = $rot->toStation->code;
                $i++;
            }
        }
        $data['routes'] = $rout;

        //Schedules layout
        $seatvisible = $this->api_model->getSeatVisibilitySchedule(array('code' => $code));
        $seatvisible = json_decode($seatvisible);
        $data['seatvisiblelist'] = $seatvisible->data;

        $this->load->view('site/schedules/get-seat-visiblity-schedules', $data);
    }

    function get_schedule_visibility_rights() {
        $this->is_logged_in();
        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $tmp = array();
        foreach ($GroupDetail->data AS $grp) {
            $Groupuser = $this->api_model->getUserByGroup(array('groupcode' => $grp->code));
            $Groupuser = json_decode($Groupuser);
            $tmp[] = array(
                'code' => $grp->code,
                'name' => $grp->name,
                'activeFlag' => $grp->activeFlag,
                'userCount' => $grp->userCount,
                'userlist' => $Groupuser->data
            );
        }
        $data['users'] = $tmp;

        $param = array('scheduleCode' => $this->input->post('sch_code'));
        $rights = $this->api_model->getScheduleVisilityRights($param);
        $rights = json_decode($rights);
        $data['assigned_users'] = $rights->data;

        $this->load->view('site/schedules/get-seat-visibility-rights', $data);
    }

    function save_schedule_visibility_rights() {
        $this->is_logged_in();

        $user = rtrim($this->input->post('users'), ',');
        $user = explode(',', $user);
        foreach ($user as $usr) {
            $code[] = array('code' => $usr);
        }
        $data = array(
            "scheduleCode" => $this->input->post('scheduleCode'),
            "userList" => $code
        );
        echo $this->api_model->saveVisibilityRights($data);
    }

    function get_schedule_discounts() {
        $this->is_logged_in();
        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $Discount = $this->api_model->getScheduleDiscount(array('authtoken' => $this->_user_hash, 'scheduleCode' => $this->input->post('scheduleCode')));
        $Discount = json_decode($Discount);
        $data['groups'] = $GroupDetail->data;
        $data['discount'] = $Discount->data;
        $this->load->view('site/schedules/get-schedule-discounts', $data);
    }

    function update_seat_visiblity_schedules() {
        $this->is_logged_in();
        $code = $this->input->post('code');
        $act = $this->input->post('act');
        $dayofweek = $this->input->post('dayOfWeek');
        $dayofweek = implode("", $dayofweek);
        $bscode = $this->input->post('busCode');
        $seatCode = $this->input->post('seatCode');
        $releaseBefore = $this->input->post('releaseBefore');

        $bcodeary = array();
        if (isset($seatCode) && $seatCode != '') {
            foreach ($seatCode AS $bcode) {
                $bcodeary[] = array(
                    'code' => $bcode
                );
            }
        }
        if ($this->input->post('viewStatus') == 1) {
            $viewstatus = "ACAT";
        } else {
            $viewstatus = "HIDE";
        }
        $data[] = array(
            "bus" => array('code' => $bscode),
            "schedule" => array("code" => $code),
            "visibilityType" => $viewstatus,
            "roleType" => $this->input->post('roleType'),
            "activeFlag" => $this->input->post('activeFlag'),
            "code" => $this->input->post('seatViscode'),
            "activeTo" => trim($this->input->post('activeTo')),
            "activeFrom" => trim($this->input->post('activeFrom')),
            "lookupCode" => $this->input->post('vcode'),
            "busSeatLayout" => $bcodeary,
            "dayOfWeek" => $dayofweek,
            "releaseMinutes" => $releaseBefore,
            "remarks" => trim($this->input->post('remarks'))
        );
        if ($this->input->post('description') != '') {
            $data[0]['description'] = $this->input->post('description');
        }

        $groupList = $this->input->post('groupList');
        if (isset($groupList) && $groupList != '') {
            $data[0]['groupList'] = $groupList;
        }

        $userList = $this->input->post('userList');
        if (isset($userList) && $userList != '') {
            $data[0]['userList'] = $userList;
        }

        $routeList = $this->input->post('routeList');
        if (isset($routeList) && $routeList != '') {
            $data[0]['routeList'] = $routeList;
        }

        echo $this->api_model->updateSeatVisibilitySchedule($data);
    }

    function delete_seat_visibility_schedules() {
        $this->is_logged_in();

        $bscode = $this->input->post('busCode');
        $code = $this->input->post('code');
        //$code = 'SHE69C105';
        $dayofweek = $this->input->post('dayOfWeek');
        $dayofweek = implode("", $dayofweek);
        $bcodeary[] = array('code' => '');
        $viewstatus = $this->input->post('viewStatus');

        $data[] = array(
            "bus" => array('code' => $bscode),
            "schedule" => array("code" => $code),
            "visibilityType" => "HIDE",
            "roleType" => "GR",
            "activeFlag" => 2,
            "code" => $this->input->post('seatViscode'),
            "activeTo" => trim($this->input->post('activeTo')),
            "activeFrom" => trim($this->input->post('activeFrom')),
            "busSeatLayout" => $bcodeary,
            "dayOfWeek" => $dayofweek
        );
        echo $this->api_model->updateSeatVisibilitySchedule($data);
    }

    function delete_seat_visibility_exception() {
        $this->is_logged_in();

        $bscode = $this->input->post('busCode');
        $code = $this->input->post('code');

        $data[] = array(
            "bus" => array('code' => $bscode),
            "schedule" => array("code" => $code),
            "visibilityType" => "HIDE",
            "roleType" => "GR",
            "activeFlag" => 2,
            "code" => $this->input->post('seatViscode'),
            "lookupCode" => $this->input->post('vcode'),
        );
        echo $this->api_model->updateSeatVisibilitySchedule($data);
    }

    function get_schedules_trips() {
        $this->is_logged_in();

        //assets/js/apps/tisa_mail.js
        $date = $this->input->post('date');

        $searchType = $this->input->post('searchType');
        $fromStation = $this->input->post('fromStation');
        $toStation = $this->input->post('toStation');
        $param = array(
            'tripDate' => $date
        );
        if (isset($fromStation) && $fromStation != '') {
            $param['fromCode'] = $fromStation;
        }
        if (isset($toStation) && $toStation != '') {
            $param['toCode'] = $toStation;
        }

        $schedules = $this->api_model->getScheduleTrip($param);

        $schedules = json_decode($schedules); //getScheduleByType
        $data = array();
        $data['tripDate'] = $date;
        $data['totalTripCount'] = count($schedules->data);

        $d_start = new DateTime(date('Y-m-d'));
        $d_end   = new DateTime($date);
        $diff = $d_start->diff($d_end);
        $days = $diff->format('%d');
        $data['tripindays'] = $days;

        //  grouping based on category
        $tmp = array();
        foreach($schedules->data as $trip) {
            $trip->fromStationTimestamp = strtotime($trip->stageList[0]->fromStation->dateTime);
            $trip->busTypeName = bus_category_string($trip->bus->categoryCode);
            $viaList = array();
            foreach($trip->stageList as $via) {
                $viaList[$via->fromStation->code] = (object)array(
                    'name' => $via->fromStation->name,
                    'dateTime' => $via->fromStation->dateTime,
                );
                $viaList[$via->toStation->code] = (object)array(
                    'name' => $via->toStation->name,
                    'dateTime' => $via->toStation->dateTime,
                );
            }
            usort($viaList, function($a, $b) {
                return $a->dateTime < $b->dateTime ? -1 : 1;
            });
            $trip->viaRoutes = array_values($viaList);
            $tmp[$trip->schedule->category->name][] = $trip;
        }
        ksort($tmp);

        //  sort by departure time within a tag
        $sorted = array();
        foreach($tmp as $key=>$trip){
           usort($trip, '_orderby_time');
           $sorted[$key] = $trip;
        }

        // remove unused data to UI
        for($d=0; $d<count($schedules->data); $d++) {
            for($t=0; $t<count($schedules->data[$d]->stageList); $t++) {
                unset($schedules->data[$d]->stageList[$t]->fromStation->stationPoint);
                unset($schedules->data[$d]->stageList[$t]->toStation->stationPoint);
            }

            unset($schedules->data[$d]->bus->name);
            unset($schedules->data[$d]->bus->activeFlag);
            unset($schedules->data[$d]->bus->categoryCode);
            unset($schedules->data[$d]->bus->displayName);
            unset($schedules->data[$d]->bus->seatCount);

            unset($schedules->data[$d]->schedule->activeFlag);
            unset($schedules->data[$d]->schedule->activeFrom);
            unset($schedules->data[$d]->schedule->activeTo);
            unset($schedules->data[$d]->schedule->dayOfWeek);
            unset($schedules->data[$d]->schedule->mobileTicketFlag);
            unset($schedules->data[$d]->schedule->ticketRACLimit);
            unset($schedules->data[$d]->schedule->pnrStartCode);
            unset($schedules->data[$d]->schedule->serviceTax);
            unset($schedules->data[$d]->schedule->boardingReportingMinitues);

            unset($schedules->data[$d]->eventList);

        }

        $data['schedules'] = $sorted;
        $data['schedules_raw'] = $schedules->data;
        $data['trCode'] = $schedules->data->code;
        $data['searchType'] = $searchType;

        /*$stations = $this->api_model->getNamespaceStation(array('authtoken' => $this->_user_hash));
        $stations = json_decode($stations);
        $data['stations'] = $stations->data;*/

        $this->load->view('site/schedules/get-schedules-trips', $data);
    }

    function get_closed_schedules() {
        $this->is_logged_in();

        $data = array();
        $schedulesClose = $this->api_model->getScheduleByType(array('type' => 'closed'));
        $schedulesClose = json_decode($schedulesClose);
        $schedulesClose = $schedulesClose->data;

        foreach ($schedulesClose AS $key => $list) {
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

            $temp[$list->category->name][] = array(
                'name' => $list->name,
                'code' => $list->code,
                'BusName' => $list->bus->name,
                'activeFrom' => $list->activeFrom,
                'activeTo' => $list->activeTo,
                'BusType' => $busType,
                'station' => $station,
                'faremax' => $max,
                'faremin' => $min,
                'fromStationTime' => $startTime,
                'toStationTime' => $endTime,
                'startStation' => $startStation,
                'endStation' => $endStation,
                'scheduleTagList' => $list->scheduleTagList,
                'sectorList' => $list->sectorList
            );
        }
        ksort($temp);
        $data['schedulesclose'] = $temp;
        $this->load->view('site/schedules/get-closed-schedules', $data);
    }

    function get_active_schedules() {
        $this->is_logged_in();
        $data = array();
        _include_js('assets/js/pages/schedules-list.js');
        _include_js('assets/js/pages/schedules-bus.js');
        _include_js('assets/js/monthly.js');

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
                    $startTimestamp = $list->stageList[0]->fromStation->dateTime;

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

            $temp[] = array(
                'name' => $list->name,
                'code' => $list->code,
                'serviceNumber' => $list->serviceNumber,
                'activeFrom' => $list->activeFrom,
                'activeTo' => $list->activeTo,
                'BusName' => $list->bus->name,
                'BusCode' => $list->bus->code,
                'BusType' => $busType,
                'station' => $station,
                'faremax' => $max,
                'faremin' => $min,
                'fromStationTime' => $startTime,
                'fromStationTimestamp' => $startTimestamp,
                'toStationTime' => $endTime,
                'startStation' => $startStation,
                'endStation' => $endStation,
                'dayOfWeek' => $list->dayOfWeek,
                'daysDiff' => date_diff(date_create($list->activeFrom), date_create($list->activeTo))->format('%a'),
                'daysDiff1' => date_diff(date_create($list->activeTo), $dt = new DateTime())->format('%a'),
                'tag' => $list->category->name,
                'scheduleTagList' => $list->scheduleTagList,
                'sectorList' => $list->sectorList,
            );
        }
        $data['schedulesactive'] = $temp;

        $from = '';
        foreach($data['schedulesactive'] as $sel){
            $from .= $sel['startStation'].',';
        }
        $from = rtrim($from , ',');
        $from = array_unique(explode(',', $from));

        $to = '';
        foreach($data['schedulesactive'] as $sel){
            $to .= $sel['endStation'].',';
        }
        $to = rtrim($to , ',');
        $to = array_unique(explode(',', $to));

        $data['totalSchedules'] = count($data['schedulesactive']);
        $data['from'] = $from;
        $data['to'] = $to;

        // grouping by tag.
        $tmp = array();
        foreach($data['schedulesactive'] as $sch){
           $tmp[$sch['tag']][] = $sch;
        }
        ksort($tmp);

        //  sort by departure time within a tag
        $sorted = array();
        foreach($tmp as $key=>$sch){
           $t = _array_orderby($sch, 'fromStationTimestamp', SORT_ASC);
           $sorted[$key] = $t;
        }
        $data['schedulesactive'] = $sorted;
        $data['schedulesactive_raw'] = $temp;

        $this->load->view('site/schedules/get-active-schedules', $data);
    }

    function get_expire_schedules() {
        $this->is_logged_in();
        $data = array();
        $schedulesexpire = $this->api_model->getScheduleByType(array('type' => 'expire'));
        $schedulesexpire = json_decode($schedulesexpire);
        $schedulesexpire = $schedulesexpire->data;

        foreach ((array) $schedulesexpire AS $key => $list) {
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

            $temp[$list->category->name][] = array(
                'name' => $list->name,
                'code' => $list->code,
                'activeFrom' => $list->activeFrom,
                'activeTo' => $list->activeTo,
                'BusName' => $list->bus->name,
                'BusType' => $busType,
                'station' => $station,
                'faremax' => $max,
                'faremin' => $min,
                'fromStationTime' => $startTime,
                'toStationTime' => $endTime,
                'startStation' => $startStation,
                'endStation' => $endStation,
                'scheduleTagList' => $list->scheduleTagList,
                'sectorList' => $list->sectorList
            );
        }
        ksort($temp);
        $data['schedulesexpire'] = $temp;

        $this->load->view('site/schedules/get-expire-schedules', $data);
    }

    function get_partial_schedules() {
        $this->is_logged_in();
        $data = array();
        $schedulespartial = $this->api_model->getScheduleByType(array('type' => 'partial'));
        $schedulespartial = json_decode($schedulespartial);
        $schedulespartial = (array) $schedulespartial->data;
        foreach ($schedulespartial AS $key => $list) {
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

                foreach ((array) $list->stageList AS $k => $stl) {
                    foreach ($stl->stageFare AS $f) {
                        $fare[] = $f->fare;
                    }

                    $fromStationPoint = array();
                    $fromStationPointTime = array();
                    $tostationPoint = array();
                    $toStationPointTime = array();

                    foreach ((array) $stl->fromStation->stationPoint AS $p) {
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

            $temp[] = array(
                'name' => $list->name,
                'code' => $list->code,
                'activeFrom' => $list->activeFrom,
                'activeTo' => $list->activeTo,
                'BusName' => $list->bus->name,
                'BusType' => $busType,
                'station' => $station,
                'faremax' => $max,
                'faremin' => $min,
                'fromStationTime' => $startTime,
                'toStationTime' => $endTime,
                'startStation' => $startStation,
                'endStation' => $endStation,
                'scheduleTagList' => $list->scheduleTagList,
                'sectorList' => $list->sectorList
            );
        }
        $data['schedulespartial'] = $temp;


        $this->load->view('site/schedules/get-partial-schedules', $data);
    }

    function get_schedule_extras() {
        $this->load->view('site/schedules/get-schedule-extras', array());
    }

    /* function update_basic_exception_schedules() {
      $this->is_logged_in();
      $data = array(
      'code' => $this->input->post('code'),
      'lookup' => array(
      'activeTo' => $this->input->post('code'),
      'activeFrom' => $this->input->post('activeFrom')
      )
      );
      echo $this->api_model->updateSchedule($data);
      }

      function update_station_exception_schedules() {
      $this->is_logged_in();
      $stationdata[] = array(
      'activeTo' => $this->input->post('activeTo'),
      'activeFrom' => $this->input->post('activeFrom'),
      'lookup' => array(
      'code' => $this->input->post('code')
      ),
      'code' => $this->input->post('stationschedules')
      );
      echo $this->api_model->updateStationSchedule($stationdata);
      } */

    function update_station_point_exception_schedules() {
        $this->is_logged_in();
        $dayofweek = $this->input->post('dayOfWeek');
        $dayofweek = implode("", $dayofweek);

        $stationpoint[] = array(
            'schedule' => array('code' => $this->input->post('code')),
            'station' => array('code' => $this->input->post('station')),
            'stationPoint' => array('code' => $this->input->post('stationPoint')),
            'activeFlag' => '1',
            'creditDebitFlag' => '1',
            'activeTo' => $this->input->post('activeTo'),
            'activeFrom' => $this->input->post('activeFrom'),
            'dayOfWeek' => $dayofweek,
            'minitues' => $this->input->post('minitues'),
            'lookupCode' => $this->input->post('stationPointCode'),
            'fare' => $this->input->post('fare') ?: 0,
            'code' => $this->input->post('ecode')
        );

        echo $this->api_model->updateStationPointSchedule($stationpoint);
    }

    function update_bustype_exceptio_schedules() {
        $this->is_logged_in();
        $data = array(
            'schedule' => array('code' => $this->input->post('code')),
            'code' => $this->input->post('busCode'),
            'lookup' => array(
                'activeTo' => $this->input->post('activeTo'),
                'activeFrom' => $this->input->post('activeFrom'),
                'code' => $this->input->post('bustype')
            )
        );
        echo $this->api_model->updateBustypeSchedule($data);
    }

    function update_routes_exception_schedules() {
        $this->is_logged_in();

        $dayofweek = $this->input->post('dayOfWeek');
        if (isset($dayofweek) && $dayofweek != '')
            $dayofweek = implode("", $dayofweek);

        $fare[] = array(
            'fare' => $this->input->post('fare'),
            'activeTo' => trim($this->input->post('activeTo')),
            'activeFrom' => trim($this->input->post('activeFrom')),
            'dayOfWeek' => $dayofweek,
            'activeFlag' => '1',
            'busSeatType' => array('code' => $this->input->post('seatType')),
            'schedule' => array('code' => $this->input->post('code')),
            'fromStation' => array('code' => $this->input->post('from')),
            'toStation' => array('code' => $this->input->post('to')),
            'lookupCode' => $this->input->post('routeCode'),
            'code' => $this->input->post('ecode')
        );
        $group = $this->input->post('group');
        if ($group != '') {
            $fare[0]['group'] = array('code' => $group);
        }

        echo $this->api_model->updateRoutesFareSchedule($fare);
    }

    function get_schedules_tabs() {
        $this->is_logged_in();

        $tripCode = $this->input->post('tripCode');
        $tripCode = "14N11S140806";

        //Trip expensive
        $transExp = $this->api_model->getTripsExpensive(array('tripCode' => $tripCode));
        $transExp = json_decode($transExp);
        $data['transexpn'] = $transExp->data;
        $transExp = $transExp->data;
        $Cramount = 0;
        $Dramount = 0;
        for ($i = 0; $i < count($transExp); $i++) {
            $flg = 'Cr';
            if ($flg == "Cr") { //if($transExp[$i]->tripCashHeadIO->creditDebitFlag="Cr")
                $Cramount += $transExp[$i]->amount;
            }
            if ($flg == "Dr") { //if($transExp[$i]->tripCashHeadIO->creditDebitFlag="Dr")
                $Dramount += $transExp[$i]->amount;
            }
        }
        $data['creditAmount'] = $Cramount;
        $data['debitAmount'] = $Dramount;
        $data['totalAmount'] = $Cramount - $Dramount;
        //Transaction Mode
        $transMode = $this->api_model->getTransMode(array('authtoken' => $this->_user_hash));
        $transMode = json_decode($transMode);
        $data['transmode'] = $transMode->data;

        //Trip head
        $triphead = $this->api_model->getTripsHead($data);
        $triphead = json_decode($triphead);
        $data['triphead'] = $triphead->data;

        $this->load->view('site/schedules/get-schedules-tabs', $data);
    }

    function update_schedules_expensive() {
        $tripCode = $this->input->post('tripCode');
        $tripCode = "14N11S140806";
        $data = array(
            'amount' => $this->input->post('amount'),
            'activeFlag' => "1",
            'tripCode' => $tripCode,
            'transactionModeIO' => array('code' => $this->input->post('tmode')),
            'name' => $this->input->post('name'),
            'tripCashHeadIO' => array('code' => $this->input->post('thead')),
            'remarks' => $this->input->post('remark')
        );

        echo $this->api_model->updateSchedulesExpensive($data);
    }

    function delete_schedules_expensive() {

    }

    function bus_category($string) {
        $bus_category = $this->api_model->getBusCategory();
        $bus_category = json_decode($bus_category);

        $temp = array();

        foreach ($bus_category->data AS $buscat) {
            $tmp = array();
            foreach ($buscat->categoryList AS $sub) {

                $tmp[$sub->code] = $sub->name;
            }
            $temp[preg_replace('/\s+/', '', $buscat->code)] = $tmp;
        }
        // {assign var=ct value="|"|explode:$bs->bus->categoryCode}
        $cat = explode('|', $string);

        if ($cat[0] != '' && $cat[1] != '' && $cat[2] != '' && $cat[3] != '' && $cat[4] != '') {
            $val = '';
            if ($temp['Layout'][$cat[0]] != '' && strtoupper($temp['Layout'][$cat[0]]) != 'OTHERS') {
                $val .= $temp['Layout'][$cat[0]] . " ";
            }
            if ($temp['Seattype'][$cat[4]] != '' && strtoupper($temp['Seattype'][$cat[4]]) != 'OTHERS') {
                $val .= $temp['Seattype'][$cat[4]] . " ";
            }
            if ($temp['ClimateControl'][$cat[1]] != '' && strtoupper($temp['ClimateControl'][$cat[1]]) != 'OTHERS') {
                $val .= $temp['ClimateControl'][$cat[1]] . " ";
            }
            if ($temp['Make'][$cat[3]] != '' && strtoupper($temp['Make'][$cat[3]]) != 'OTHERS') {
                $val .= $temp['Make'][$cat[3]] . " ";
            }
            if ($temp['Chasis'][$cat[2]] != '' && strtoupper($temp['Chasis'][$cat[2]]) != 'OTHERS') {
                $val .= $temp['Chasis'][$cat[2]] . " ";
            }
            return $val;
        }
        return 0;
    }

    function hoursTominutes($hours) {
        $t = explode(".", $hours);
        $h = $t[0];
        if (isset($t[1])) {
            $m = $t[1];
        } else {
            $m = "00";
        }
        $mm = ($h * 60) + $m;
        return $mm;
    }

    function dayshoursTominutes($d, $h, $m) {
        if ($d != '')
            $m = ($d * 1440) + $m;
        if ($h != '')
            $m = ($h * 60) + $m;
        return $m;
    }

    function minutesTodayshours($minutes) {

        $d = floor($minutes / 1440);
        $h = floor(($minutes - $d * 1440) / 60);
        $m = $minutes - ($d * 1440) - ($h * 60);

        return "Open at " . $d . " day " . $h . " hours " . $m . " minutes  before";
    }

    function minutesTohoursminutes($minutes) {
        $hours = floor($minutes / 60);
        $minutes = ($minutes % 60);
        if ($minutes == 0) {
            $minutes = 00;
        }
        $minutes = ($minutes % 60);
        return $hours . ":" . $minutes . ":00";
    }

    function formatMinutesToHours($minutes) {
        $hours = floor($minutes / 60);
        $minutes = ($minutes % 60);
        if ($minutes == 0) {
            $minutes = 00;
        }
        $minutes = ($minutes % 60);
        return $hours . " hours :" . $minutes.' minutes';
    }

    function in_array_multiple($needle, $haystack, $strict = false) {
        foreach ($haystack as $item) {
            if (($strict ? $item === $needle : $item == $needle) || (is_array($item) && $this->in_array_multiple($needle, $item, $strict))) {
                return true;
            }
        }
        return false;
    }

    function update_trip() {
        $this->is_logged_in();
        echo $this->api_model->updateTrip(array('code' => $this->input->post('trip_code'), 'state' => $this->input->post('trip_state')));
    }

    function set_schedule_state() {
        $this->is_logged_in();
        echo $this->api_model->setScheduleState(array('code' => $this->input->post('sch_code'), 'activeFlag' => $this->input->post('sch_state')));
    }

    function update_schedules_discount() {
        $this->is_logged_in();
        $week = $this->input->post('dayOfWeek');
        $days = '';
        foreach ($week as $wk) {
            $days .= $wk;
        }
        $data = array(
            'name' => $this->input->post('name'),
            'percentageFlag' => $this->input->post('percentageFlag'),
            'activeFlag' => 1,
            'dateType' => $this->input->post('disc_data'),
            'discountValue' => $this->input->post('disc_value'),
            'schedule' => array('code' => $this->input->post('scheduleCode')),
            'activeFrom' => $this->input->post('activeFrom'),
            'activeTo' => $this->input->post('activeTo'),
            'group' => array('code' => $this->input->post('group')),
            'dayOfWeek' => $days,
            'code' => $this->input->post('discountCode'),
            'deviceMedium' => array('code' =>$this->input->post('deviceMedium')),
            'authenticationType' => array('code' =>$this->input->post('userType'))
        );
        echo $this->api_model->updateSchedulesDiscount($data);
    }

    function update_schedules_discount_exception() {
        $this->is_logged_in();
        $week = $this->input->post('dayOfWeek');
        $days = '';
        foreach ($week as $wk) {
            $days .= $wk;
        }
        $data = array(
            'name' => $this->input->post('name'),
            'activeFlag' => 1,
            'schedule' => array('code' => $this->input->post('scheduleCode')),
            'activeFrom' => $this->input->post('activeFrom'),
            'activeTo' => $this->input->post('activeTo'),
            'dayOfWeek' => $days,
            'lookupCode' => $this->input->post('discountCode'),
            'code' => $this->input->post('expCode')
        );
        echo $this->api_model->updateSchedulesDiscount($data);
    }

    function delete_schedules_discount() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => 2,
            'schedule' => array('code' => $this->input->post('scheduleCode')),
            'lookupCode' => $this->input->post('code'),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateSchedulesDiscount($data);
    }

    function delete_schedules_discount_exception() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => 2,
            'schedule' => array('code' => $this->input->post('scheduleCode')),
            'lookupCode' => $this->input->post('disc_code'),
            'code' => $this->input->post('exp_code')
        );
        echo $this->api_model->updateSchedulesDiscount($data);
    }

    function get_seat_auto_release() {
        $this->is_logged_in();

        $data = array();
        $code = $this->input->post('code');
        $userDetails = $this->api_model->getUser();
        $userDetail = json_decode($userDetails);
        $data['users'] = $userDetail->data;


        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);


        foreach ($GroupDetail->data AS $rts) {
            if (!empty($rts->code) && $rts->activeFlag == 1) {
                $grp[] = array(
                    'code' => $rts->code,
                    'name' => $rts->name
                );
            }
        }

        $data['groups'] = $grp;

        //Bus Layout
        $bcode = $this->input->post('busType');
        $buslayer = $this->api_model->getBusLayerbyCode(array('buscode' => $bcode));
        $buslayer = json_decode($buslayer);
        $data['busseatlayers'] = $buslayer->data;
        $bus_category = $this->api_model->getBusCategory();
        $bus_category = json_decode($bus_category);

        $temp = array();

        foreach ($bus_category->data AS $buscat) {
            $tmp = array();
            foreach ($buscat->categoryList AS $sub) {
                $tmp[$sub->code] = $sub->name;
            }
            $temp[preg_replace('/\s+/', '', $buscat->code)] = $tmp;
        }
        $data['categoryList'] = $temp;

        $l1x = array();
        $l1x = array();
        $l2x = array();
        $l2y = array();
        foreach ($buslayer->data AS $buslay) {
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

        //Schedules layout
        $seatvisible = $this->api_model->getSeatAutoRelease(array('schedule' => $code));
        $seatvisible = json_decode($seatvisible);
        $data['seatvisiblelists'] = $seatvisible->data;
        $this->load->view('site/schedules/get-seat-auto-release', $data);
    }

    function update_seat_auto_release() {

        $this->is_logged_in();
        $code = $this->input->post('code');
        $schedule = $this->input->post('schedule');
        $dayofweek = $this->input->post('dayOfWeek');
        $dayofweek = implode("", $dayofweek);
        $bscode = $this->input->post('busCode');
        $seatCode = $this->input->post('seatCode');
        $bcodeary = array();
        if (isset($seatCode) && $seatCode != '') {
            foreach ($seatCode AS $bcode) {
                $bcodeary[] = array(
                    'code' => $bcode
                );
            }
        }


        $data = array(
            'code' => $this->input->post('code'),
            "busSeatLayout" => $bcodeary,
            "bus" => array('code' => $bscode),
            "activeTo" => trim($this->input->post('activeTo')),
            "schedule" => array("code" => $schedule),
            "activeFlag" => $this->input->post('activeFlag'),
            'releaseMinutes' => $this->input->post('releaseMinutes'),
            'minutesType' => $this->input->post('minutesType'),
            'releaseType' => $this->input->post('releaseType'),
            'releaseMode' => $this->input->post('releaseMode'),
            "dayOfWeek" => $dayofweek,
            "activeFrom" => trim($this->input->post('activeFrom')),
            'group' => array('code' => $this->input->post('group'))
        );

        echo $this->api_model->updateSeatAutoRelease($data);
    }

    function delete_seat_auto_release() {

        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('code'),
            "activeFlag" => 2
        );
        echo $this->api_model->updateSeatAutoRelease($data);
    }

    function get_seat_preference() {
        $this->is_logged_in();
        $data = array();
        $code = $this->input->post('code');
        $userDetails = $this->api_model->getUser();
        $userDetail = json_decode($userDetails);
        $data['users'] = $userDetail->data;


        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);


        foreach ($GroupDetail->data AS $rts) {
            if (!empty($rts->code) && $rts->activeFlag == 1) {
                $grp[] = array(
                    'code' => $rts->code,
                    'name' => $rts->name
                );
            }
        }

        $data['groups'] = $grp;

        //Bus Layout
        $bcode = $this->input->post('busType');
        $buslayer = $this->api_model->getBusLayerbyCode(array('buscode' => $bcode));
        $buslayer = json_decode($buslayer);
        $data['busseatlayers'] = $buslayer->data;
        $bus_category = $this->api_model->getBusCategory();
        $bus_category = json_decode($bus_category);

        $temp = array();

        foreach ($bus_category->data AS $buscat) {
            $tmp = array();
            foreach ($buscat->categoryList AS $sub) {
                $tmp[$sub->code] = $sub->name;
            }
            $temp[preg_replace('/\s+/', '', $buscat->code)] = $tmp;
        }
        $data['categoryList'] = $temp;

        $l1x = array();
        $l1x = array();
        $l2x = array();
        $l2y = array();
        foreach ($buslayer->data AS $buslay) {
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

        //Schedules layout
        $seatvisible = $this->api_model->getSeatPreference(array('schedule' => $code));
        $seatvisible = json_decode($seatvisible);
        $data['seatvisiblelists'] = $seatvisible->data;
        $this->load->view('site/schedules/get-seat-preference', $data);
    }

    function update_seat_preference() {

        $this->is_logged_in();
        $code = $this->input->post('code');
        $schedule = $this->input->post('schedule');
        $dayofweek = $this->input->post('dayOfWeek');
        $dayofweek = implode("", $dayofweek);
        $bscode = $this->input->post('busCode');
        $seatCode = $this->input->post('seatCode');
        $bcodeary = array();
        if (isset($seatCode) && $seatCode != '') {
            foreach ($seatCode AS $bcode) {
                $bcodeary[] = array(
                    'code' => $bcode
                );
            }
        }


        $data = array(
            'code' => $this->input->post('code'),
            "busSeatLayout" => $bcodeary,
            "bus" => array('code' => $bscode),
            "activeTo" => trim($this->input->post('activeTo')),
            "schedule" => array("code" => $schedule),
            "activeFlag" => $this->input->post('activeFlag'),
            "dayOfWeek" => $dayofweek,
            "activeFrom" => trim($this->input->post('activeFrom')),
            'preferenceGendar' => $this->input->post('gender'),
            'groupList' => $this->input->post('groupList')
        );

        echo $this->api_model->updateSeatPreference($data);
    }

    function delete_seat_preference() {

        $this->is_logged_in();
        $data = array(
        	"schedule" => array("code" => $schedule),
            'code' => $this->input->post('code'),
        	"bus" => array('code' => $bscode),
            "activeFlag" => 2
        );
        echo $this->api_model->updateSeatPreference($data);
    }

    function update_release_exception() {
        $this->is_logged_in();
        $week = $this->input->post('dayOfWeek');
        $days = '';
        foreach ($week as $wk) {
            $days .= $wk;
        }
        $data = array(
            'activeFlag' => 1,
            'activeFrom' => $this->input->post('activeFrom'),
            'activeTo' => $this->input->post('activeTo'),
            'dayOfWeek' => $days,
            'lookupCode' => $this->input->post('lookup'),
            "bus" => array('code' => $this->input->post('busCode')),
            "schedule" => array("code" => $this->input->post('schedule')),
        );
        echo $this->api_model->updateSeatAutoRelease($data);
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

    function update_schedule_booking() {
        $this->is_logged_in();
        $bookings = $this->api_model->getBookingScheduleByCode(array('code' => $this->input->post('schedule')));
        $bookings = json_decode($bookings);
        $bookings = $bookings->data;
        $from = '';
        $to = '';
        $stage = $this->input->post('stg');
        if($stage != ''){
           $stg_exp = explode('-',$stage);
           $from = $stg_exp[0];
           $to = $stg_exp[1];
        }

        foreach ($bookings as $book) {
            if ($this->input->post('code') == $book->code) {
                $booking[] = array(
                    "code" => $book->code,
                    "activeFlag" => "1",
                    "dayOfWeek" => $book->dayOfWeek,
                    "schedule" => array(
                        "code" => $book->schedule->code
                    ),
                    "allowBookingFlag" => $this->input->post('state'),
                    "openMinitues" => $book->openMinitues,
                    "closeMinitues" => $book->closeMinitues,
                );
                if (!empty($book->group->code)) {
                    $booking[0]['group'] = array('code' => $book->group->code);
                }
                if (!empty($from)) {
                $booking[0]['fromStation'] = array('code' => $from);
                $booking[0]['toStation'] = array('code' => $to);
            }
            }
        }
        echo $this->api_model->updateBookingSchedule($booking);
    }

    function get_schedule_exceptions() {
        $this->is_logged_in();
        $code = $this->input->post('code');

        $schedules = $this->api_model->getSchedulesBycode(array('code' => $code));
        $schedules = json_decode($schedules);
        $data['schedules'] = $schedules->data;

        $this->load->view('site/schedules/schedule-exceptions', $data);
    }

    function get_driver_details() {
        $this->is_logged_in();
        _include_js('assets/js/pages/schedule-trips.js');
        $data = array(
            'tripCode' => $this->input->post('tripCode')
        );
        
        //Get Driver Details
        $result = $this->api_model->getTripVehicleDriver();
        $result = json_decode($result);
        $data['current_date'] = $result->datetime;
        $data['drivers'] = $result->data;
        
        //Get Attenders Detais
        $result = $this->api_model->getTripVehicleAttendant();
        $result = json_decode($result);
        $data['attenders'] = $result->data;
        
        // Get vehicle
        $result = $this->api_model->getVehicleInfo($data);
        $result = json_decode($result);
        $data['vehicles'] = $result->data;
        
        // Get vehicle info
        $get_vehicle = $this->api_model->getVehicle(array('authtoken' => $this->_user_hash));
        $vehicle = json_decode($get_vehicle);

        $data['vehicle'] = $vehicle->data;

        $this->load->view('site/trips/vehicle', $data);
    }

    function get_trip_busmap(){
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

        //  format booked seats and PNR
        $brd = array();
        $pnr = array();
        $usrBook = array();
        if(is_array($buslayers->seatLayoutList) && !empty($buslayers->seatLayoutList)){
            foreach($buslayers->seatLayoutList as $br){
                if($br->boardingPointName != ''){
                    $brd[$br->boardingPointName]['name'] = $br->boardingPointName;
                }

                if (strtolower($br->group->name) == 'customer') {
                    $br->user->name = 'Guest';
                }

                if ($br->seatStatus->code == 'BO' || $br->seatStatus->code == 'PBL') {
                    $usrBook[$br->user->name]['bo_seats'] += 1;
                }

                if($br->ticketCode != '' && $br->seatStatus->code != 'TBL'){
                    $pnr[$br->ticketCode]['pnr'] = $br->ticketCode;
                    $pnr[$br->ticketCode]['boardingPointName'] = $br->boardingPointName;
                    $pnr[$br->ticketCode]['contactNumber'] = $br->contactNumber;

                    $pnr[$br->ticketCode]['passengerName'][] = $br->passengerName;
                    $pnr[$br->ticketCode]['passengerAge'][] = $br->passengerAge;
                    $pnr[$br->ticketCode]['seatName'][] = $br->seatName;
                    $pnr[$br->ticketCode]['seatGendarStatus'][] = $br->seatGendarStatus->code;

                    $pnr[$br->ticketCode]['bookedby'] = $br->user->name;
                    $pnr[$br->ticketCode]['bookedat'] = $br->updatedAt;
                    $pnr[$br->ticketCode]['route'] = $br->route;
                }

             }
        }

        $tickets = array();
        if(count($pnr) > 0) {
           foreach($pnr as $t) {
               $tickets[] = array(
                   'pnr' => $t['pnr'],
                   'boardingPointName' => $t['boardingPointName'],
                   'contactNumber' => $t['contactNumber'],
                   'passengerName' => implode(', ', $t['passengerName']),
                   'passengerAge' => implode(', ', $t['passengerAge']),
                   'seatName' => implode(', ', $t['seatName']),
                   'seatGendarStatus' => implode(', ', $t['seatGendarStatus']),

                   'bookedby' => $t['bookedby'],
                   'bookedat' => strtotime($t['bookedat']),
                   'route' => $t['route']
               );

               $a_tmp[] = strtotime($t['bookedat']);
           }
           array_multisort($a_tmp, SORT_DESC, $tickets);
        }

        //  format boarding points
        $boarding = array();
        if(is_array($tripChartList->fromStation->stationPoint) && !empty($tripChartList->fromStation->stationPoint)){
            foreach($tripChartList->fromStation->stationPoint as $sp){
                $boarding[] = array(
                    'name' => $sp->name,
                    'landmark' => $sp->landmark,
                    'time' => date('h:i A', strtotime($sp->dateTime) )
                );
                if(isset($brd[$sp->name])) {
                    $brd[$sp->name]['dateTime'] = $sp->dateTime;
                }
             }
        }

        usort($brd, function($a, $b) {
            return $a['dateTime'] < $b['dateTime'] ? -1 : 1;
        });
        $data['board'] = $brd;
        $data['user_booking'] = $usrBook;
        $busseat = json_decode ( $seattype );
        $data ['seattype'] = $busseat->data;

        $data['boardingpoints'] = $boarding;
        $data['sms_type'] = config_item('sms_type');
        $data['sms_type_reasons'] = config_item('sms_type_reasons');

        $data ['tickets'] = $tickets;
        $this->load->view('site/schedules/trip-bus-map', $data); // totalSeatCount
    }

    function send_trip_sms() {
        $this->is_logged_in();

        $c_sms_reason = config_item('sms_type_reasons');

        $pnr = $this->input->post('pnr');
        $trip_id = $this->input->post('trip_id');
        $trip_code = $this->input->post('trip_code');

        $sms_type = $this->input->post('sms_type');
        $sms_delay_time = $this->input->post('sms_delay_time');
        $sms_reason = $this->input->post('sms_reason');
        $reason_text = $c_sms_reason[$sms_type][$sms_reason];

        $sms_support_no = $this->input->post('sms_support_no');
        $boarding = $this->input->post('boarding');
        $boardinglandmark = $this->input->post('boardinglandmark');
        $boardingtime = $this->input->post('boardingtime');

        if($sms_type=="TCAN") {
            $data = array(
                'tripCode' => $trip_id,
                'ticketCode' => $pnr,
                'reason' => $reason_text,
                'supportNumber' => $sms_support_no
            );
            echo $this->api_model->sendTripCancelSMS($data);
        } else if($sms_type=="TDELAY") {
            $data = array(
                'tripCode' => $trip_id,
                'ticketCode' => $pnr,
                'reason' => $reason_text,
                'delayTime' => $sms_delay_time,
                'supportNumber' => $sms_support_no
            );
            echo $this->api_model->sendTripDelaySMS($data);
        } else if($sms_type=="TEARLY") {
            $data = array(
                'tripCode' => $trip_id,
                'ticketCode' => $pnr,
                'reason' => $reason_text,
                'earlyTime' => $sms_delay_time,
                'supportNumber' => $sms_support_no
            );
            echo $this->api_model->sendTripEarlySMS($data);
        } else if($sms_type=="TBPC") {
            $data = array(
                'tripCode' => $trip_id,
                'ticketCode' => $pnr,
                'reason' => $reason_text,
                'stationPointName' => $boarding,
                'stationPointTime' => $boardingtime,
                'supportNumber' => $sms_support_no
            );
            echo $this->api_model->sendTripBoardingChageSMS($data);
        } else if($sms_type=="SNDGPS") {
            $data = array(
                'ticketCode' => $pnr,
            );
            echo $this->api_model->sendTrackingLinkSMS($data);
        } else if($sms_type=="RSNDGPSHJ") {
            $data = array(
                'tripCode' => $trip_code,
                'ticketCode' => implode(',', $pnr),
            );
            echo $this->api_model->resendGPSandHJSMS($data);
        }

    }

    function send_trip_sms_v2() {
        $this->is_logged_in();

        $c_sms_reason = config_item('sms_type_reasons');
        $api_sms_type = config_item('api_sms_type');

        $sms_type = $this->input->post('sms_type');
        $sms_reason = $this->input->post('sms_reason');

        echo $this->api_model->sendTripNotificationSMS(array(
            'TICKETS' => $this->input->post('pnr'),
            'TRIP_CODE' => $this->input->post('trip_code'),

            'SMS_TYPE' => $api_sms_type[$sms_type],
            'DELAY_TIME' => $this->input->post('sms_delay_time') ?: '',
            'REASON' => $c_sms_reason[$sms_type][$sms_reason],

            'SUPPORT_NUMBER' => $this->input->post('sms_support_no') ?: '',
            'STATION_POINT_NAME' => $this->input->post('boarding') ?: '',
            'STATION_POINT_TIME' => $this->input->post('boardingtime') ?: '',
        ));
    }

 function get_schedule_seat_fare() {
        	$this->is_logged_in();
        	$data = array();

        	$code = $this->input->post('code');
        	//$code = 'SHE69C105';
        	//User list
        	$userDetails = $this->api_model->getUser();
        	$userDetail = json_decode($userDetails);
        	$data['users'] = $userDetail->data;

        	//Group list
        	/*  $routes = $this->api_model->getRoutesFareScheduleByCode(array('code'=>$code));
        	 $routes = json_decode($routes);
        	 $routes = $routes->data;
        	 $grp = array();
        	 foreach ($routes AS $rts){
        	 if(!$this->in_array_multiple($rts->group->code, $grp)){
        	 $grp[] = array(
        	 'code'=> $rts->group->code,
        	 'name'=> $rts->group->name
        	 );
        	 }
        	 } */

        	//$data['groups'] = $grp;


        	$GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        	$GroupDetail = json_decode($GroupDetail);


        	foreach ($GroupDetail->data AS $rts) {
        		if (!empty($rts->code) && $rts->activeFlag == 1) {
        			$grp[] = array(
        					'code' => $rts->code,
        					'name' => $rts->name
        			);
        		}
        	}

        	$data['groups'] = $grp;
        	//schedule stages
        	//Routes
        $routes = $this->api_model->getRoutesFareScheduleByCode(array('code' => $code));
        $routes = json_decode($routes);
        $routes = $routes->data;
        //if(count($routes)<=0) $routes = array();
        $i = 0;

        foreach ($routes AS $rot) {
            if ($rot->activeFlag == 1 && $rot->schedule->code == $code) {
                $rout[$rot->fromStation->code . $rot->toStation->code]["name"] = $rot->fromStation->name . ' to ' . $rot->toStation->name;
                $rout[$rot->fromStation->code . $rot->toStation->code]["from"] = $rot->fromStation->code;
                $rout[$rot->fromStation->code . $rot->toStation->code]["to"] = $rot->toStation->code;
                $rout[$rot->fromStation->code . $rot->toStation->code]["fare"][] = array(
                    'code' => $rot->code,
                    'fromStation' => $rot->fromStation->code,
                    'toStation' => $rot->toStation->code,
                    'busSeatType' => $rot->busSeatType,
                    'group' => $rot->group,
                    'fare' => $rot->fare,
                    'activeFlag' => $rot->activeFlag,
                    'activeTo' => $rot->activeTo,
                    'activeFrom' => $rot->activeFrom,
                    'lookup' => $rot->lookup,
                    'dayOfWeek' => $rot->dayOfWeek,
                    'overrideList' => $rot->overrideList
                );
                $i++;
            }
        }
        $data['routes'] = $rout;

        	//Bus Layout
        	$bcode = $this->input->post('busType');

        	// $bcode ='BSE6BA89';
        	$buslayer = $this->api_model->getBusLayerbyCode(array('buscode' => $bcode));
        	$buslayer = json_decode($buslayer);
        	$data['busseatlayer'] = $buslayer->data;
        	$bus_category = $this->api_model->getBusCategory();
        	$bus_category = json_decode($bus_category);

        	$temp = array();

        	foreach ($bus_category->data AS $buscat) {
        		$tmp = array();
        		foreach ($buscat->categoryList AS $sub) {
        			$tmp[$sub->code] = $sub->name;
        		}
        		$temp[preg_replace('/\s+/', '', $buscat->code)] = $tmp;
        	}
        	$data['categoryList'] = $temp;

        	$l1x = array();
        	$l1x = array();
        	$l2x = array();
        	$l2y = array();
        	foreach ($buslayer->data AS $buslay) {
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

        	//Schedules layout
        	$seatvisible = $this->api_model->getSceduleSeatFare(array('code' => $code));
        	$seatvisible = json_decode($seatvisible);
        	$data['seatvisiblelist'] = $seatvisible->data;
        	/*$seatvisible = $this->api_model->getSceduleSeatFare(array('schedulecode' => $code));
        	$seatvisible = json_decode($seatvisible);
        	$data['seatvisiblelist'] = $seatvisible->data;*/

        	$this->load->view('site/schedules/get-schedule-seat-fare', $data);
        }

function update_schedule_seat_fare() {
        	$this->is_logged_in();

		$schedule = $this->input->post ( 'schedule' );
		$dayofweek = $this->input->post ( 'dayOfWeek' );
		$dayofweek = implode ( "", $dayofweek );
		$bscode = $this->input->post ( 'busCode' );
		$seatCode = $this->input->post ( 'seatCode' );
		$bcodeary = array ();
		if (isset ( $seatCode ) && $seatCode != '') {
                    foreach ( $seatCode as $bcode ) {
                        $bcodeary [] = array (
                            'code' => $bcode
                        );
                    }
		}


		$data = array (
                    'code' => $this->input->post('code'),
                    "busSeatLayout" => $bcodeary,
                    "bus" => array (
                    'code' => $bscode
                    ),
                    "activeTo" => trim ( $this->input->post ( 'activeTo' ) ),
                    "schedule" => array (
                        "code" => $schedule
                    ),
                    "activeFlag" => $this->input->post ( 'activeFlag' ),
                    "dayOfWeek" => $dayofweek,
                    "activeFrom" => trim ( $this->input->post ( 'activeFrom' ) ),
                    'group' => array (
                        'code' => $this->input->post ( 'group' )
                    ) ,
                    "fromStation" => array (
                        'code' => $this->input->post ( 'fromcode' )
                    ),
                    "toStation" =>  array (
                        'code' => $this->input->post ( 'tocode' )
                    ),
                    "seatFare" => $this->input->post ( 'fare' ),

                    "fareType" => 'FLT',
                    "fareOverrideType" => $this->input->post('fareOverrideType')
		);

		echo $this->api_model->updateScheduleSeatFare ( $data );
        }
 function update_schedule_seat_fare_exception_override(){
 	$this->is_logged_in();
 	$schedule = $this->input->post ( 'schedule' );
 	$dayofweek = $this->input->post ( 'dayOfWeek' );
 	$dayofweek = implode ( "", $dayofweek );
 	$bscode = $this->input->post ( 'busCode' );
 	$data = array (
 			'code' => $this->input->post('code'),
 			"activeTo" => trim ( $this->input->post ( 'activeTo' ) ),
 			"schedule" => array (
 					"code" => $schedule
 			),
 			"activeFrom" => trim ( $this->input->post ( 'activeFrom' ) ),
 			"activeFlag" => $this->input->post ( 'activeFlag' ),
 			"dayOfWeek" => $dayofweek,
 			"seatFare" => $this->input->post ( 'fare' ),
 			'lookupCode' => $this->input->post('sfcode'),
 			"bus" => array (
 					'code' => $bscode
 			)
 	);
 	echo $this->api_model->updateScheduleSeatFare ( $data );

 }

 function delete_seat_fare() {
        	$this->is_logged_in ();
        	$schedule = $this->input->post ( 'schedule' );
        	$bscode = $this->input->post ( 'busCode' );
        	$data = array (
        			"schedule" => array (
        					"code" => $schedule
        			),
        			'code' => $this->input->post ( 'code' ),
        			"bus" => array (
        					'code' => $bscode
        			),
        			"activeFlag" => 2
        	);
        	echo $this->api_model->updateScheduleSeatFare ( $data );
        }
        function delete_seat_fare_exception() {
        	$this->is_logged_in ();
        	$schedule = $this->input->post ( 'code' );
        	$bscode = $this->input->post ( 'busCode' );
        	$data = array (
        			"schedule" => array (
        					"code" => $schedule
        			),
        			'lookup' => $this->input->post ( 'vcode' ),
        			"bus" => array (
        					'code' => $bscode
        			),
        			"activeFlag" => 2
        	);
        	echo $this->api_model->updateScheduleSeatFare ( $data );
        }

        function get_schedule_auto_override() {
           $this->is_logged_in();
           $data = array();

           $code = $this->input->post('code');

           $tripDate = $this->input->post('tripDate');
           $refer = $this->input->get('from');
           $json_response = $this->input->post('jsonResponse');

           $userDetails = $this->api_model->getUser();
           $userDetail = json_decode($userDetails);
           $data['users'] = $userDetail->data;

           $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
           $GroupDetail = json_decode($GroupDetail);


           foreach ($GroupDetail->data AS $rts) {
               if (!empty($rts->code) && $rts->activeFlag == 1) {
                   $grp[] = array(
                       'code' => $rts->code,
                       'name' => $rts->name
                   );
               }
           }

           $data['groups'] = $grp;
           //schedule stages
           //Routes
           $routes = $this->api_model->getRoutesFareScheduleByCode(array('code' => $code));
           $routes = json_decode($routes);
           $routes = $routes->data;
           //if(count($routes)<=0) $routes = array();
           $i = 0;

           foreach ($routes AS $rot) {
               if ($rot->activeFlag == 1 && $rot->schedule->code == $code) {
                   $rout[$rot->fromStation->code . $rot->toStation->code]["name"] = $rot->fromStation->name . ' - ' . $rot->toStation->name;
                   $rout[$rot->fromStation->code . $rot->toStation->code]["from"] = $rot->fromStation->code;
                   $rout[$rot->fromStation->code . $rot->toStation->code]["to"] = $rot->toStation->code;
                   $rout[$rot->fromStation->code . $rot->toStation->code]["fare"][] = array(
                       'code' => $rot->code,
                       'fromStation' => $rot->fromStation->code,
                       'toStation' => $rot->toStation->code,
                       'busSeatType' => $rot->busSeatType,
                       'group' => $rot->group,
                       'fare' => $rot->fare,
                       'activeFlag' => $rot->activeFlag,
                       'activeTo' => $rot->activeTo,
                       'activeFrom' => $rot->activeFrom,
                       'lookup' => $rot->lookup,
                       'dayOfWeek' => $rot->dayOfWeek,
                       'overrideList' => $rot->overrideList
                   );
                   $i++;
               }
           }
           $data['routes'] = $rout;

           //Schedules layout
           $schfare = $this->api_model->getScheduleFareAutoOverride(array('code' => $code));
           $schfare = json_decode($schfare);

           $tmp = array();
           $tmp_multiday = array();
           $tmp_expired = array();
           foreach ($schfare->data AS $row) {
                $row->daysDiff = date_diff(date_create($row->activeFrom), date_create($row->activeTo))->format('%a');
                $row->daysDiff1 = date_diff(new DateTime(),date_create($row->activeTo))->format('%r%a');

                $start_date = new DateTime();
                $since_start = $start_date->diff(date_create($row->updateAt));
                $minutes = $since_start->days * 24 * 60;
                $minutes += $since_start->h * 60;
                $minutes += $since_start->i;
                $row->recordage = $minutes;

                if($row->daysDiff1 < 0) {
                    $tmp_expired[] = $row;
                } else {
                    if($row->activeFrom != $row->activeTo){   // multiple date fare
                        $tmp_multiday[] = $row;
                    } else {    //  single day fare
                        $tmp[] = $row;
                    }
                }
           }
           if($refer=='search') {   // show only the settings available for a specific date
                $temp = array();
                foreach ($schfare->data AS $row) {
                    if(strtotime($row->activeFrom)<= strtotime($tripDate) && strtotime($row->activeTo) >=strtotime($tripDate)) {
                        $temp[] = $row;
                    }
                }
                $data['schedulefare'] = $temp;
           } else {
               $data['schedulefare'] = array_merge($tmp, $tmp_multiday, $tmp_expired) ;    //  show all list
           }
           //   collect all seat type available this schedule
            $busSchedule = $this->api_model->getBustypeScheduleBycode(array('code' => $code));
            $busSchedule = json_decode($busSchedule);
            $busSchedule = $busSchedule->data;

            $seattype = array();
            foreach ($busSchedule[0]->busSeatLayout AS $lay) {
                $seattype[$lay->busSeatType->code] = $lay->busSeatType->name;
            }

            $data['seattype'] = $seattype;
            $data['tripDateStamp'] = strtotime($tripDate);
            $data['conf_seattype'] = config_item('seat_types');

            if($json_response == 1) {
                echo json_encode($data['schedulefare']);
            } elseif($refer=='search') {
                $this->load->view('site/schedules/fare-override-search', $data);
            } else {
                $this->load->view('site/schedules/get-schedule-auto-override', $data);
            }
        }

       function update_schedule_fare() {
        $this->is_logged_in();
        $schedule = $this->input->post('schedule');
        $type = $this->input->post('type');
        $dayofweek = $this->input->post('dayOfWeek');
        $dayofweek = implode("", $dayofweek);
        $routes = $this->input->post('routes');

        $data = array(
            "activeTo" => trim($this->input->post('activeTo')),
            "schedule" => array(
                "code" => $schedule
            ),
            "activeFlag" => $this->input->post('activeFlag'),
            "dayOfWeek" => $dayofweek,
            "activeFrom" => trim($this->input->post('activeFrom')),
            "fare" => $this->input->post('fare'),
            "fareType" => $this->input->post('fareType'),
            "fareOverrideType" => $this->input->post('fareOverrideType'),
            "overrideMinutes" => $this->input->post('fareOverridemins'),
            "busSeatTypeCodes" => $this->input->post('busSeatTypeCode'),
        );

        if ($type == 1) {
            $bscode = $this->input->post('busCode');
            $data['lookupCode'] = $this->input->post('lookup');
            $data['bus'] = array(
                'code' => $bscode
            );
            $data['code'] = $this->input->post('code');
            if (in_array("NA", $routes)){
                $data['routeList'][] = array(
                    'toStation' => array('code' => 'NA'),
                    'fromStation' => array('code' => 'NA')
                );
            } else {
                foreach($routes as $value) {
                    $tt = explode(' - ', $value);
                    $data['routeList'][] = array(
                        'toStation' => array('code' => $tt[1]),
                        'fromStation' => array('code' => $tt[0])
                    );
                }
            }
            $data['groupList'] = $this->input->post('group');
        } else {
            $data['code'] = $this->input->post('code');
            $data['routeList'] = array();
            if (in_array("NA", $routes)) {
                $data['routeList'][] = array(
                    'toStation' => array('code' => 'NA'),
                    'fromStation' => array('code' => 'NA')
                );
            } else {
                foreach($routes as $value) {
                    $tt = explode(' - ', $value);
                    $data['routeList'][] = array(
                        'toStation' => array('code' => $tt[1]),
                        'fromStation' => array('code' => $tt[0])
                    );
                }
            }
            $data['groupList'] = $this->input->post('group');
        }
        echo $this->api_model->updateScheduleFareAutoOverride($data);
    }

    function delete_schedules_override_fare() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => 2,
            'schedule' => array('code' => $this->input->post('scheduleCode')),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateScheduleFareAutoOverride($data);
    }

    function get_schedule_gallery() {
        $this->is_logged_in();
        _include_js('assets/js/imagesloaded.pkgd.min.js');
        _include_js('assets/lib/freewall/freewall.js');
        _include_js('assets/lib/magnific-popup/jquery.magnific-popup.min.js');

        $data = array();

        $code = $this->input->post('code');

        $schgal = $this->api_model->getScheduleGallery(array('scheduleCode' => $code));
        $schgal = json_decode($schgal);
        $data['schgal'] = $schgal->data;

        $galleryDetails = $this->api_model->getGalleries();
        $galleryDetail = json_decode($galleryDetails);
        $data['gallery'] = $galleryDetail->data;

        $this->load->view('site/schedules/get-schedule-gallery', $data);
    }

    function get_schedule_gallery_photos() {
        $this->is_logged_in();
        $data = array();

        $code = $this->input->post('code');

        $galleryImages = $this->api_model->getGalleryImages($this->input->post('code'));
        $galleryImage = json_decode($galleryImages);
        $data['images'] = $galleryImage->data;

        $this->load->view('site/schedules/get-schedule-gallery-photos', $data);
    }

    function save_schedule_gallery() {
        $this->is_logged_in();
        $data = array(
            'scheduleCode' => $this->input->post('schedule_id'),
            'code' => $this->input->post('gallery_id')
        );
        echo $this->api_model->saveScheduleGallery($data);
    }

    function get_schedule_time_auto_override() {
        $this->is_logged_in();
        $data = array();

        $code = $this->input->post('code');

        //alreaded added time overide list
        $schfare = $this->api_model->getScheduleTimeAutoOverride(array('code' => $code));
        $schfare = json_decode($schfare);
        foreach ($schfare->data AS $key => $st) {
            $hours = floor($st->overrideMinutes/60);
            $minutes = $st->overrideMinutes%60;
            $schfare->data[$key]->hours = sprintf('%02d hours %02d minutes', $hours, $minutes);
        }

        $data['schedulefare'] = $schfare->data;

        $station = $this->api_model->getSchedulesStationBycode(array('code' => $code));
        $station = json_decode($station);
        $station = $station->data;

        foreach ($station AS $key => $st) {
            $station[$key]->hoursminitues = gmdate("h:i A", ($st->minitues * 60));
        }
        $data['stations'] = $station;

        $this->load->view('site/schedules/get-schedule-time-auto-override', $data);
    }

    function save_schedule_auto_time_override() {
        $this->is_logged_in();
        $schedule = $this->input->post('schedule');
        $code = $this->input->post('code');
        $stationcode = trim($this->input->post('station'));
        $reaction = trim($this->input->post('reaction'));
        $time = $this->input->post('time');
        $type = $this->input->post('timetype');
        $dayofweek = $this->input->post('weekdays');
        $dayofweek = implode("", $dayofweek);

        $dateRange = $this->input->post('daterange');
        $dateRange = explode(" | ", $dateRange);

        $data = array(
            "activeTo" => trim($dateRange[1]),
            "schedule" => array(
                "code" => $schedule
            ),
            "dayOfWeek" => $dayofweek,
            "activeFrom" => trim($dateRange[0]),
            "reactionFlag" => (bool) $reaction,
            "station" =>  array(
                "code" => $stationcode
            ),
            "overrideMinutes" => $time,
            "overrideType" => $type,
        );
        if($code!=''){
            $data['code'] = $code;
        }
        echo $this->api_model->updateScheduleTimeAutoOverride($data);
    }

    function delete_schedules_time_override() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => 2,
            'schedule' => array('code' => $this->input->post('scheduleCode')),
            'code' => $this->input->post('code')
        );
        echo $this->api_model->updateScheduleTimeAutoOverride($data);
    }

    function delete_schedule_override_exception() {
        $this->is_logged_in();
        $schedule = $this->input->post('scheduleCode');
        $data = array(
            "schedule" => array(
                "code" => $schedule
            ),
            'lookup' => $this->input->post('lookcode'),
            'code' => $this->input->post('code'),
            "activeFlag" => 2
        );
        echo $this->api_model->updateScheduleFareAutoOverride($data);
    }

    function get_trip_transactions() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQFAPJZ6',
            'tripCode' => $this->input->post('trip_code'),
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $data['transactions'] = json_decode($result);
        $data['meta'] = config_item('ticket_status');

        $this->load->view('site/schedules/trip-transactions', $data);
    }

    function get_trip_history() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQGCHA4114',
            'filterCode' => $this->input->post('trip_code'),
            'repositoryCode' => 'trip',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data = array();
        $data['transactions'] = $result->data;
        $this->load->view('site/schedules/trip-history', $data);
    }


    function update_fare_override_exception() {
        $this->is_logged_in();
        $schedule = $this->input->post('schedule');
        $dayofweek = $this->input->post('dayOfWeek');
        $dayofweek = implode("", $dayofweek);
        $bscode = $this->input->post('busCode');
        $routes = $this->input->post('routes');
        $data = array(
            'code' => $this->input->post('code'),
            "activeTo" => trim($this->input->post('activeTo')),
            "schedule" => array(
                "code" => $schedule
            ),
            "activeFrom" => trim($this->input->post('activeFrom')),
            "activeFlag" => 1,
            "dayOfWeek" => $dayofweek,
            'lookupCode' => $this->input->post('lookup'),
            "bus" => array(
                'code' => $bscode
            ),
            "fare" => '-1',
            "fareType" => 'FLT',
            "fareOverrideType" => 'CRFA',
            "groupList" => $this->input->post('group'),
            "routeList" => array()
        );
        if (in_array("NA", $routes)) {
            $data['routeList'][] = array(
                'toStation' => array('code' => 'NA'),
                'fromStation' => array('code' => 'NA')
            );
        } else {
            foreach($routes as $value) {
                $tt = explode(' - ', $value);
                $data['routeList'][] = array(
                    'toStation' => array('code' => $tt[1]),
                    'fromStation' => array('code' => $tt[0])
                );
            }
        }
        echo $this->api_model->updateScheduleFareAutoOverride($data);
    }

    function trip_seat_visiblity() {
        $this->is_logged_in();
        $data = array();

        $code = $this->input->post('code');
        $tripDate = $this->input->post('tripDate');
        //$code = 'SHE69C105';
        //User list
        $userDetails = $this->api_model->getUser();
        $userDetail = json_decode($userDetails);
        $data['users'] = $userDetail->data;

        //Group list
        /*  $routes = $this->api_model->getRoutesFareScheduleByCode(array('code'=>$code));
          $routes = json_decode($routes);
          $routes = $routes->data;
          $grp = array();
          foreach ($routes AS $rts){
          if(!$this->in_array_multiple($rts->group->code, $grp)){
          $grp[] = array(
          'code'=> $rts->group->code,
          'name'=> $rts->group->name
          );
          }
          } */

        //$data['groups'] = $grp;


        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);


        foreach ($GroupDetail->data AS $rts) {
            if (!empty($rts->code) && $rts->activeFlag == 1) {
                $grp[] = array(
                    'code' => $rts->code,
                    'name' => $rts->name
                );
            }
        }

        $data['groups'] = $grp;

        //Bus Layout
        $busSchedule = $this->api_model->getBustypeScheduleBycode(array('code' => $code));
        $busSchedule = json_decode($busSchedule);
        $data['sch_bus_code'] = $busSchedule->data[0]->bus->code;

        // $bcode ='BSE6BA89';
        $buslayer = $this->api_model->getBusLayerbyCode(array('buscode' => $busSchedule->data[0]->bus->code));
        $buslayer = json_decode($buslayer);
        $data['busseatlayer'] = $buslayer->data;
        $bus_category = $this->api_model->getBusCategory();
        $bus_category = json_decode($bus_category);

        $temp = array();

        foreach ($bus_category->data AS $buscat) {
            $tmp = array();
            foreach ($buscat->categoryList AS $sub) {
                $tmp[$sub->code] = $sub->name;
            }
            $temp[preg_replace('/\s+/', '', $buscat->code)] = $tmp;
        }
        $data['categoryList'] = $temp;

        $l1x = array();
        $l1x = array();
        $l2x = array();
        $l2y = array();
        foreach ($buslayer->data AS $buslay) {
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

        //Routes
        $routes = $this->api_model->getRoutesFareScheduleByCode(array('code' => $code));
        $routes = json_decode($routes);
        $routes = $routes->data;
        //if(count($routes)<=0) $routes = array();
        $i = 0;

        foreach ($routes AS $rot) {
            if ($rot->activeFlag == 1 && $rot->schedule->code == $code) {
                $rout[$rot->fromStation->code . $rot->toStation->code]["name"] = $rot->fromStation->name . ' - ' . $rot->toStation->name;
                $rout[$rot->fromStation->code . $rot->toStation->code]["from"] = $rot->fromStation->code;
                $rout[$rot->fromStation->code . $rot->toStation->code]["to"] = $rot->toStation->code;
                $i++;
            }
        }
        $data['routes'] = $rout;

        //Schedules layout
        $seatvisible = $this->api_model->getSeatVisibilitySchedule(array('code' => $code));
        $seatvisible = json_decode($seatvisible);
        $seatvisiblelist = array();
        foreach ($seatvisible->data AS $row) {
            if( strtotime($row->activeFrom)<= strtotime($tripDate) && strtotime($row->activeTo) >=strtotime($tripDate)) {
                $seatvisiblelist[] = $row;
            }
        }
        $data['seatvisiblelist'] = $seatvisiblelist;

        $this->load->view('site/schedules/seat-visiblity-search', $data);
    }

    function do_clone() {
        $this->is_logged_in();

        $code = $this->input->post('code');
        $options = $this->input->post('options');
        $clonetype = $this->input->post('clonetype');

        //$newSchedule = json_encode( array('status'=>1, 'errorDesc'=>'Error message'));
        $newSchedule = $this->api_model->cloneSchedule(array('code' => $code, 'options' => $options, 'clonetype' => $clonetype));
        echo $newSchedule;
    }

    function tags() {
        $this->is_logged_in();
        $list = $this->api_model->getScheduleTag();
        $list = json_decode($list);
        $formated_list = array();
        foreach ($list->data as $tag) {
            array_push($formated_list, array(
                'tagName' => $tag->name,
                'tagCode' => $tag->code,
                'tokens' => explode(' ', $tag->name)
            ));
        }
        echo json_encode($formated_list);

    }

    function get_schedule_dynamic_price() {
        $this->is_logged_in();
        $data = array();

        // Schedule Routes
        $routes = $this->api_model->getRoutesFareScheduleByCode(array('code' => $this->input->post('code')));
        $routes = json_decode($routes);
        $routes = $routes->data;
        $troutes = array();
        foreach ($routes AS $key => $r) {
            $troutes[$r->fromStation->code.$r->toStation->code] = array(
                'fromName' => $r->fromStation->name,
                'toName' => $r->toStation->name,
                'fromCode' => $r->fromStation->code,
                'toCode' => $r->toStation->code,
            );
        }
        $data['routes'] = $troutes;

        $param = array(
            'scheduleCode' => $this->input->post('code'),
        );
        $list = $this->api_model->getScheduleDynamicPrice($param);
        $list = json_decode($list);
        foreach($list->data as $entry) {

        }
        $data['dps'] = $list->data;

        $this->load->view('site/schedules/dynamic-pricing', $data);
    }

    function update_dynamic_price() {
        $this->is_logged_in();

        $dayofweek = $this->input->post('dayOfWeek');
        $dayofweek = implode("", $dayofweek);
        $fares = $this->input->post('fares');

        $afares = array();
        foreach($fares as $fare) {
            $afares[] = array(
                'code' => '',
                'activeFlag' => 1,
                'toStation' =>array( 'code' => $fare['tocode'] ),
                'fromStation' =>array( 'code' => $fare['fromcode'] ),
                'minFare' => $fare['minfare'],
                'maxFare' => $fare['maxfare'],
            );
        }

        $data = array(
            "schedule" =>array( 'code' => $this->input->post('schedule') ),
            'activeFrom' => $this->input->post('activeFrom'),
            'activeTo' => $this->input->post('activeTo'),
            'dayOfWeek' => $dayofweek,
            'stageFare' => $afares,
            'activeFlag' => 1
        );
        echo $this->api_model->updateScheduleDynamicPrice($data);
    }

    function get_schedule_travel_stops() {
        $this->is_logged_in();
        $data = array();

        $json = $this->api_model->getAllTravelStops();
        $json = json_decode($json);
        $m_stops = array();
        foreach($json->data as $k => $stop) {
            if($stop->activeFlag==1)
                $m_stops[] = $stop;
        }
        $data['m_stops'] = $m_stops;

        $station = $this->api_model->getSchedulesStationBycode(array('code' => $this->input->post('code')));
        $station = json_decode($station);
        $station = $station->data;
        $m_station = array();
        foreach($station as $k => $v) {
            $m_station[$v->station->code] = $v->station->name;
        }
        $data['stations'] = $m_station;

        $param = array(
            'schedule_code' => $this->input->post('code'),
        );
        $list = $this->api_model->getScheduleTravelStops($param);
        $list = json_decode($list);
        $data['stops'] = $list->data;

        $this->load->view('site/schedules/travel-stops', $data);
    }

    function update_schedule_stops() {
        $this->is_logged_in();
        $schedule = $this->input->post('schedule_code');
        $data = array(
            "schedule_code" =>$schedule,
            'code' => $this->input->post('stop'),
            'stations' => array( 'code' => $this->input->post('station') ),
            "travelMinutes" => $this->input->post('minutes'),
            'activeFlag' => 1
        );
        echo $this->api_model->updateScheduleStops($data);
    }

    function delete_schedule_stops() {
        $this->is_logged_in();
        $data = $this->input->post('stop');
        $data['schedule_code'] = $this->input->post('schedule_code');
        echo $this->api_model->updateScheduleStops($data);
    }

    function reset_trip_cache() {
        $this->is_logged_in();

        $tripCode = $this->input->post('trip_code');

        // busmapv3 booked seats deatails - refer search/get_busmap_v3
        $p_key = _get_namespace_id() . '_sync_time_' . $tripCode;
        $this->rediscache->delete($p_key);

        $data = array(
            'tripCode' => $tripCode
        );
        echo $this->api_model->resetTripCache($data);
    }

    function trip_cancel() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQI275W27',
            'fromDate' => 'NA',
            'toDate' => 'NA',
            'travelDateFlag' => 1,
            'tripCode' => $this->input->post('trip_code'),
            'tagCode' => $this->input->post('tagCode')?: 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $data['tripcancel'] = json_decode($result);
        $data['trip_code'] = $this->input->post('trip_code');
        $data['meta'] = config_item('ticket_status');

        $this->load->view('site/schedules/trip-cancel', $data);
    }

    function trip_cancel_initiate(){
        $this->is_logged_in();

        $tripCode = $this->input->post('trip_code');
        $tickets = $this->input->post('pnr');

        foreach($tickets as $ticket) {
            $s = explode(',', $ticket['seat_code']);
            $seatsCodes = array_map('trim', $s);
            $seatsCodes = implode(',', $seatsCodes);
            $data = array(
                'tripCode' => $tripCode,
                'ticketCode' => $ticket['ticket_code'],
                'seatCode' => $seatsCodes
            );
            $result = $this->api_model->tripCancelInitiate($data);
            //$ack = $this->api_model->tripCancelAcknowledge($data);
        }
        echo $result;
    }

    function get_schedule_calendar(){
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQGCFE5613',
            'scheduleCode' => $this->input->post('scheduleCode'),
            'fromDate' => date('Y-m-d', strtotime("-3 months", strtotime("today"))),
            'toDate' => date('Y-m-d', strtotime("+3 months", strtotime("today")))
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $json = array();
        foreach($result->data as $row) {
            $json['monthly'][] = array(
                "id" =>  $row->trip_code,
                "name" => $row->seat_count,
                "startdate" => $row->trip_date,
                "enddate" => "",
                "status" => $row->trip_status
            );
        }
        echo json_encode($json);
    }

    function get_schedule_bus_override(){
        $this->is_logged_in();
        $data = array(
            'scheduleCode' => $this->input->post('code'),
        );
        $res = $this->api_model->getScheduleBusOverride($data);
        $res = json_decode($res);
        $data['result'] = $res->data;

        $buses = $this->api_model->getBuses();
        $buses = json_decode($buses);
        $data['buses'] = $buses->data;

        echo $this->load->view('site/schedules/get-schedule-bus-override', $data);
    }

    function update_schedule_bus_override(){
        $this->is_logged_in();
        $activeFlag = $this->input->post('activeFlag');
        $lookup = $this->input->post('lookupCode');
        $code = $this->input->post('code');
        $bus = $this->input->post('bus');

        $data = array(
            'activeFlag' => ($activeFlag)?$activeFlag:1,
            'code' => ($code)?$code:'',
            'schedule' => array( 'code' => $this->input->post('scheduleCode')),
            'bus' => array( 'code' => ($bus)?$bus:''),
            'activeFrom' => $this->input->post('activeFrom'),
            'activeTo' => $this->input->post('activeTo'),
            'dayOfWeek' => $this->input->post('dayOfWeek'),
            'lookupCode' => ($lookup)?$lookup:'',
        );
        echo $this->api_model->updateScheduleBusOverride($data);
    }

    function migrate_seats() {
        $this->is_logged_in();
        $tripCode = $this->input->post('tripCode');

        $tripChartList = $this->api_model->getTripChart(array('tripCode' => $tripCode));
        $tripChartList = json_decode($tripChartList);

        if ($tripChartList->status == 1) {
            $tripChartList = $tripChartList->data;

            foreach ($tripChartList->trip->bus->seatLayoutList as $key => $layout) {
                $tripChartList->trip->bus->seatLayout[$layout->code] = $layout;
            }
            unset($tripChartList->trip->bus->seatLayoutList);

            foreach ($tripChartList->ticketDetailsList as $key => $ticket) {
                if (isset($tripChartList->trip->bus->seatLayout[$ticket->seatCode])) {
                    $data['booked'][] = $ticket->seatCode;
                } else {
                    $data['mismatch'][$ticket->ticketCode][] = $ticket;
                }
            }

            usort($tripChartList->trip->bus->seatLayout, function($a, $b) {
                return strnatcasecmp($a->seatName, $b->seatName);
            });
            $data['trip'] = $tripChartList->trip;
            $data['ticketDetailsList'] = $tripChartList->ticketDetailsList;
        }

        echo $this->load->view('site/schedules/migrate-seats', $data);
    }

    function migrate_busmap() {
        $tripCode = $this->input->post('tripCode');
        $travelDate = $this->input->post('travelDate');
        $fromCode = $this->input->post('fromCode');
        $toCode = $this->input->post('toCode');

        $busMap = $this->api_model->getScheduleBusMap_v3(array(
            'tripCode' => $tripCode,
            'travelDate' => $travelDate,
            'fromCode' => $fromCode,
            'toCode' => $toCode,
        ));

        $busMap = json_decode($busMap);
        if ($busMap->status == 1) {
            $timeCrossed = 0;
            //echo $busMap->fromStation->dateTime;
            if (strtotime($busMap->fromStation->dateTime) < strtotime('now')) {
                $timeCrossed = 1;
            }

            $busMap = $busMap->data;
            $lseatrow = array();
            $lseatcol = array();
            $useatrow = array();
            $useatcol = array();
            $seatStatus = array();
            $seatDetails = array();

            $summary = array();

            $t = 0;

            foreach ($busMap->bus->seatLayoutList as $bs) {
                if ($bs->seatStatus->code == 'BO' || $bs->seatStatus->code == 'PBL') {
                    $summary['boarding'][$bs->boardingPointName][] = $bs->seatName;
                    $summary['route'][$bs->route][] = $bs->seatName;
                    $summary['user'][$bs->user->name][] = $bs->seatName;
                    $summary['gender'][$bs->seatGendarStatus->code][] = $bs->seatName;
                }
                if ($bs->layer == 1) {
                    $lseatrow [] = $bs->rowPos;
                    $lseatcol [] = $bs->colPos;

                    $zaxis = 0;
                    if ($bs->orientation == 1)
                        $zaxis = 1;

                    $currentlybooking = 0;
                    if ($bs->seatStatus->code == "TBL" && $bs->updatedAt != '') {
                        $currentlybooking = 1;
                    }

                    $seatStatus ["1" . $bs->rowPos . $bs->colPos] = array(
                        'status' => $bs->seatStatus,
                        'code' => $bs->code,
                        'fare' => $bs->seatFare,
                        'discount' => $bs->discountFare,
                        'seatName' => $bs->seatName,
                        'seatType' => $bs->busSeatType->name,
                        'userName' => $bs->user->name,
                        'groupName' => $bs->group->name,
                        'groupCode' => strtolower($bs->group->code),
                        'zaxis' => $zaxis,
                        'bookingLive' => $currentlybooking,
                        'remarks' => $bs->remarks ? $bs->remarks : '',
                        'quotaRoute' => $bs->routes->fromStation->name . ' - ' . $bs->routes->toStation->name,
                        'quotaGender' => $bs->seatGendarStatus->name,
                        'updatedBy' => trim($bs->passengerName) ? $bs->passengerName : '',
                        'updatedAt' => trim($bs->updatedAt) ? $bs->updatedAt : ''
                    );
                }
                if ($bs->layer == 2) {
                    $useatrow [] = $bs->rowPos;
                    $useatcol [] = $bs->colPos;

                    $zaxis = 0;
                    if ($bs->orientation == 1)
                        $zaxis = 1;

                    $currentlybooking = 0;
                    if ($bs->seatStatus->code == "TBL" && $bs->updatedAt != '') {
                        $currentlybooking = 1;
                    }

                    $seatStatus ["2" . $bs->rowPos . $bs->colPos] = array(
                        'status' => $bs->seatStatus,
                        'code' => $bs->code,
                        'fare' => $bs->seatFare,
                        'discount' => $bs->discountFare,
                        'seatName' => $bs->seatName,
                        'seatType' => $bs->busSeatType->name,
                        'userName' => $bs->user->name,
                        'groupName' => $bs->group->name,
                        'groupCode' => strtolower($bs->group->code),
                        'zaxis' => $zaxis,
                        'bookingLive' => $currentlybooking,
                        'remarks' => $bs->remarks ? $bs->remarks : '',
                        'quotaRoute' => $bs->routes->fromStation->name . ' - ' . $bs->routes->toStation->name,
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
                'summaryStatus' => count($summary['boarding'])
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
        }

        echo $this->load->view('site/schedules/migrate-busmap', $data);
    }

    function save_migrate_seats() {
        $this->is_logged_in();
        $data = array(
            "ticketCode" => $this->input->post('ticketCode'),
            "seatCodes" => $this->input->post('seatCodes'),
            "notificationFlag" => 0
        );
        echo $this->api_model->saveSeatMigrate($data);
    }

    function get_en_route_booking() {
        $this->is_logged_in();

        $res = $this->api_model->getEnRouteBooking(array(
            'scheduleCode' => $this->input->post('code')
        ));
        $res = json_decode($res);
        $data['result'] = $res->data;

        $routes = $this->api_model->getRoutesFareScheduleByCode(array(
            'code' => $this->input->post('code')
        ));
        $routes = json_decode($routes);
        foreach ($routes->data as $key => $routes) {
            $data['routes'][$routes->fromStation->code.'-'.$routes->toStation->code] = $routes->fromStation->name.' - '.$routes->toStation->name;
        }

        $data['en_route_type'] = config_item('en_route_type');

        echo $this->load->view('site/schedules/en-route-booking', $data);
    }

    function update_en_route_booking() {
        $this->is_logged_in();

        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code'),
            'dayOfWeek' => $this->input->post('dayOfWeek'),
            'schedule' => array('code' => $this->input->post('schedule')),
            'stageList' => $this->input->post('stageList'),
            'dayOfWeek' => $this->input->post('dayOfWeek'),
            'releaseMinutes' => $this->input->post('releaseMinutes'),
            'enRouteType' => array('code' => $this->input->post('enRouteType'))

        );
        echo $this->api_model->updateEnRouteBooking($data);
    }

    function push_to_vendor() {
        $this->is_logged_in();

        $tripCode = $this->input->post('tripCode');
        $tripDate = $this->input->post('tripDate');
        $tillDay = $this->input->post('tillDay');
        $pushStations = $this->input->post('pushstations');
        $routeList = $this->input->post('routeList');
        $operatorCode = _get_namespace_id();
        
        if($pushStations==1) { // refresh station
            $json = array(
                'action_type' => 'STATION',
                'operatorcode' => $operatorCode
            );
            _send_mail('pushstationstoaggregator', $json);
            sleep(5);
        }
        
        $fromDate = date('Y-m-d', strtotime($tripDate));
        $routes = array();
        foreach ($routeList as $row) {
            $rte = explode('|', $row);
            $routes[] = array(
                'fromStationCode' => $rte[0],
                'toStationCode' => $rte[1]
            );
        }

        $data = array();
        for($i = 0; $i < (int)$tillDay; $i++) {
            foreach ($routes as $route) {
                $data[] = array(
                    'doj' => date('Y-m-d', strtotime("$fromDate + $i days")),
                    'source' => $route['fromStationCode'],
                    'destination' => $route['toStationCode'],
                    'operatorcode' => $operatorCode
                );
            }
        }

        set_time_limit(300);
        $chunked = array_chunk($data, 10);

        foreach($chunked as $row) {
            $json = array(
                'action_type' => 'SEARCH',
                'data' => $row
            );
            _send_mail('pushtoaggregator', $json);
            sleep(3);
        }
        $error = array('status'=>'ok');
        echo json_encode($error);
    }

    function get_schedule_routes_fare() {
        $this->is_logged_in();
        $schcode = $this->input->post('code');

        $routes = $this->api_model->getRoutesFareScheduleByCode(array(
            'code' => $schcode
        ));
        $routes = json_decode($routes);
        $routes = $routes->data;

        $data = array();
        foreach ($routes as $route) {
            if ($route->activeFlag == 1 && $route->schedule->code == $schcode) {
                $data[$route->fromStation->code . '|' . $route->toStation->code]['fromStation'] = $route->fromStation;
                $data[$route->fromStation->code . '|' . $route->toStation->code]['toStation'] = $route->toStation;
            }
        }
        echo json_encode($data);
    }

    function get_user_sectors() {
        $this->is_logged_in();

        echo $this->api_model->getUserSector();
    }

}

?>
