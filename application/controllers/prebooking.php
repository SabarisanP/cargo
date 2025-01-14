<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');


class Prebooking extends MY_Controller { // cargo controller

    function __construct() {
        parent::__construct();
        $this->load->helper('common_helper');   
    }

    function suggest_station_customers() {
        $this->is_logged_in();

        try {
            $stations = $this->input->post('stations') ?: [];
            $mobQuery = $this->input->post('query') ?: '';

            $redis = $this->rediscache->redis;
            $stationList = array_slice($stations, 0, 2);

            $response = [];
            foreach ($stationList as $station) {
                if (!isNotNull($station)) {
                    continue;
                }

                $key = api_model::REDIS_STATIONCUSTOMER . ':' . $station;
                if (!$redis->exists($key)) {
                    $customers = $this->api_model->getStationCustomers(['stationCode' => $station]);
                    $customers = json_decode($customers);
                    if ($customers->status != 1) {
                        continue;
                    }

                    $hashKeys = [];
                    foreach ($customers->data as $customer) {
                        $hashKeys["{$customer->mobileNumber}:{$customer->name}"] = json_encode([
                            'code' => $customer->code,
                            'name' => $customer->name,
                            'mobileNumber' => $customer->mobileNumber,
                            'gstin' => $customer->gstin,
                        ]);
                    }
                    $redis->hMset($key, $hashKeys);
                    $redis->expire($key, 259200); // 3 days
                }

                $it = NULL;
                do {
                    $hashes = $redis->hscan($key, $it, "*{$mobQuery}*", 250);

                    if ($hashes !== FALSE) {
                        foreach ($hashes as $json) {
                            $customer = json_decode($json);
                            $response[$customer->mobileNumber] = $customer;
                        }
                    }
                } while ($it > 0);
            }

            echo json_encode(['status' => 1, 'data' => array_values($response)]);
        } catch (\Throwable $th) {
            echo json_encode(['status' => 0, 'errorDesc' => $th->getMessage()]);
        }
    }

    function get_customer_info(){
        $this->is_logged_in();

        $mobile = $this->input->post('mobile');

        $customers = $this->api_model->getCargoCustomers();
        // $customers = $this->api_model->cargoCustomerVendor();
        $customer = json_decode($customers);

        $cust_data = array();

        foreach($customer->data as $key=>$val){
            if($val->mobileNumber == $mobile){
                array_push($cust_data, $val);
            }
        }

        echo json_encode($cust_data);
    }

    function get_customer_address(){
        $this->is_logged_in();

        $data = array('user' => $this->input->get('usrCode'));

        $address = $this->api_model->getCargoCustomerAddress($data);
        $address = json_decode($address);

        echo json_encode($address->data);
    }

    public function get_tariff_rate_card() {
        $this->is_logged_in();

        echo $this->api_model->getTariffRateCard(array(
            'fromCustomer' => $this->input->post('fromCustomer'),
            'toCustomer' => $this->input->post('toCustomer'),
            'vendorUser' => $this->input->post('vendorUser'),
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation')
        ));
    }

    function pre_booking_history() {
        $this->is_logged_in();
        
        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
        $usr_pro = json_decode($usr_pro);

        if($usr_pro->data->role->code != 'CGCUST'){
            $this->load->view('site/denied');
            return;            
        }

        $itemDetails = $this->api_model->getCargoItems();
        $itemDetail = json_decode($itemDetails);
        $data['items'] = $itemDetail->data;

        $data = array(
            'mobileNumber' => '',
            'vendorCode' => $usr_pro->data->username
        );

        $pre_book = $this->api_model->getVendorPreBooking($data);
        $preebooking = json_decode($pre_book);
        $data['prebooking'] = array_reverse($preebooking->data);

        $data['cargo_setting'] = _get_cargo_settings();
        
        $this->load->view('site/prebooking/pre-booking-history', $data);
    }

    public function pre_booking() { // add cargo booking
        $this->is_logged_in();

        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
        $usr_pro = json_decode($usr_pro);

        // if($usr_pro->data->role->code != 'CGCUST'){
        //     $this->load->view('site/denied');
        //     return;            
        // }

        _include_js('assets/js/pages/prebooking.js', '_init_cargo_pre_booking_page');

        $data['userDetail'] = array(
            'org_code' => $this->session->userdata('org_code'),
            'org_name' => $this->session->userdata('org_name'),
            'org_station_code' => $this->session->userdata('org_station_code'),
            'org_station_name' => $this->session->userdata('org_station_name'),
            'login_branch' => $this->session->userdata('org_station_code') . '|' . $this->session->userdata('org_code')
        );

        $data['cargo_setting'] = _get_cargo_settings();

        // if($usr_pro->data->role->code == 'CGCUST'){
            $data['vendor_user'] = $usr_pro->data;             
        // }

        $branches = $this->api_model->organizationLists();
        $branches = json_decode($branches);
        $data['branchRoutes'] = $branches->data;

        $itemDetails = $this->api_model->getCargoItems();
        $itemDetail = json_decode($itemDetails);
        foreach ($itemDetail->data as $item) {
            $item->label = $item->name;
        }
        $data['items'] = $itemDetail->data;

        $data['groupusers'] = get_active_group_and_users();

        // if (has_action_rights('CARGO-ONBEHALF-BOOKING')) {
        //     $vendors = $this->api_model->cargoCustomerVendorByBranch(array('organizationCode' => $this->session->userdata('org_code')));
        // } else {
            $vendors = $this->api_model->cargoCustomerVendor();
        // }
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;

        // if (has_action_rights('CARGO-TRANSIT-DET')) {
        //     $vehicles = $this->api_model->getVehicle();
        //     $vehicles = json_decode($vehicles);
        //     $data['vehicles'] = $vehicles->data;

        //     $drivers = $this->api_model->getVehicleDriver();
        //     $drivers = json_decode($drivers);
        //     $data['drivers'] = $drivers->data;
        // }
        
        if ($data['cargo_setting']->showCustomerAddressFlag) {
            $namespaceNames = $this->api_model->getNamespaceStation(array('authtoken' => _get_user_hash()));
            $namespaceNames = json_decode($namespaceNames);
            $data['stations'] = $namespaceNames->data;
        }

        $cargoremarks = $this->api_model->getCargoRemarksBooking();
        $cargoremarks = json_decode($cargoremarks);
        $data['cargoremarks'] = $cargoremarks->data;

        $branches = $this->api_model->getDeliveryBranches();
        $data['delivery_branches'] = getData($branches);


        $data['article_unit'] = $this->config->item('article_unit');
        $data['pay_type'] = $this->config->item('pay_type');
        $data['transaction_mode'] = $this->config->item('transaction_mode');
        
        $this->load->view('site/prebooking/pre-booking', $data);
    }

    function save_pre_booking() {
        $this->is_logged_in();

        $door_pick =  $this->input->post('door_pickup');
        $door_delivery =  $this->input->post('door_delivery');

        $pay_mode = $this->input->post('pay_mode');

        $update_from_customer = trim($this->input->post('update_from_customer'));
        $update_to_customer = trim($this->input->post('update_to_customer'));
        
        $from_customer = trim($this->input->post('from_customer'));
        $to_customer = trim($this->input->post('to_customer'));
        
        $fromCustomerAddress = $this->input->post('from_cus_addr_code') ?: '';
        $toCustomerAddress = $this->input->post('to_cus_addr_code') ?: '';

        $from_cus_gst = strtoupper(trim($this->input->post('sender_gst')));
        $to_cus_gst = strtoupper(trim($this->input->post('receiver_gst')));

        // $on_behalf_of_user = trim($this->input->post('on_behalf_user'));

        $vendor_usercode = trim($this->input->post('vendor_usercode'));
        // save from customer
        if (empty($from_customer) || $update_from_customer) {
            $data = array(
                'activeFlag' => 1,
                'code' => $from_customer,
                'name' => strtoupper($this->input->post('from_name')),
                //'customerGroup' => array('code'=>'CGFCPCG94967'),
                'companyName' => 'Common',
                'mobileNumber' => $this->input->post('from_phone'),
                'preferedPaymentType' => $pay_mode,
                'gstin' => $from_cus_gst,
                'station' => array(
                    array('code' => $this->input->post('from_station'))
                )
            );
            $fr = $this->api_model->updateCargoCustomer($data);
            $fr = json_decode($fr);
            $from_customer = $fr->data->code;
        }
        if($this->input->post('pick_addr_selected') != 1 && $this->input->post('fr_address')){
            if($this->input->post('pickup_cus_address') || $door_pick == 1){ // if door pick up checked
                $update_cus_address = array(
                    'name' =>  $this->input->post('from_name'),
                    'address1' => $this->input->post('fr_address'),
                    'landmark' => $this->input->post('fr_landmark'),
                    'pincode' => $this->input->post('fr_pincode'),
                    'station' => array('code' => $this->input->post('fr_station')),
                    'user' => $from_customer,
                    'code'  => $fromCustomerAddress,
                    'defaultFlag' => 1,
                    'activeFlag'  => 1
                );

                $result = $this->api_model->updateCargoCustomerAddress($update_cus_address);  
                $result = json_decode($result);

                if($result->data->code){
                    $from_CustomerAddress = array('code' => $result->data->code); 
                }else{
                    $from_CustomerAddress = array(
                        'name' =>  $this->input->post('from_name'),
                        'address1' => $this->input->post('fr_address'),
                        'landmark' => $this->input->post('fr_landmark'),
                        'pincode' => $this->input->post('fr_pincode'),
                        'station' => array('code' => $this->input->post('fr_station')),
                        'user' => $from_customer,
                        'code'  => $fromCustomerAddress,
                        'defaultFlag' => 1,
                        'activeFlag'  => 1
                    );
                }             
            }
        }

        // save to customer
        if (empty($to_customer) || $update_to_customer) {
            if ($this->input->post('from_phone') == $this->input->post('to_phone')) {
                $to_customer = $from_customer;
            } else {
                $data = array(
                    'activeFlag' => 1,
                    'code' => $to_customer,
                    'name' => strtoupper($this->input->post('to_name')),
                    //'customerGroup' => array('code'=>'CGFCPCG94967'),
                    'companyName' => 'Common',
                    'mobileNumber' => $this->input->post('to_phone'),
                    'preferedPaymentType' => $pay_mode,
                    'gstin' => $to_cus_gst,
                    'station' => array(
                        array('code' => $this->input->post('to_station'))
                    )
                );
                $to = $this->api_model->updateCargoCustomer($data);
                $to = json_decode($to);
                $to_customer = $to->data->code;
            }
        }
        
        if($this->input->post('dlvry_addr_selected') != 1 && $this->input->post('to_address')){
        
            if($this->input->post('dlvry_cus_address') || $door_delivery == 1){ // if door delivery checked
                $update_cus_address = array(
                    'name' =>  $this->input->post('to_name'),
                    'address1' => $this->input->post('to_address'),
                    'landmark' => $this->input->post('to_landmark'),
                    'pincode' => $this->input->post('to_pincode'),
                    'station' => array('code' => $this->input->post('to_station')),
                    'user' => $to_customer,
                    'code'  => $toCustomerAddress,
                    'defaultFlag' => 1,
                    'activeFlag'  => 1
                );

                $result = $this->api_model->updateCargoCustomerAddress($update_cus_address);  
                $result = json_decode($result);

                if($result->data->code){
                    $to_CustomerAddress = array('code' => $result->data->code);   
                }else{
                    $to_CustomerAddress = array(
                        'name' =>  $this->input->post('to_name'),
                        'address1' => $this->input->post('to_address'),
                        'landmark' => $this->input->post('to_landmark'),
                        'pincode' => $this->input->post('to_pincode'),
                        'station' => array('code' => $this->input->post('to_station')),
                        'user' => $to_customer,
                        'code'  => $toCustomerAddress,
                        'defaultFlag' => 1,
                        'activeFlag'  => 1
                    );
                }           
            }
        }

        if($from_CustomerAddress){
            $fromCustomerAddress = $from_CustomerAddress;
        }else{
            $fromCustomerAddress = array('code' => $fromCustomerAddress);
        }

        if($to_CustomerAddress){
            $toCustomerAddress = $to_CustomerAddress;
        }else{
            $toCustomerAddress = array('code' => $toCustomerAddress);
        }

        $data = array(
            'code' => '',
            'fromStation' => array('code' => $this->input->post('from_station')),
            'toStation' => array('code' => $this->input->post('to_station')),
            'fromOrganization' => array('code' => $this->input->post('from_branch')),
            'toOrganization' => array('code' => $this->input->post('to_branch')),
            'fromCustomer' => array('code' => $from_customer,
                'name' => strtoupper($this->input->post('from_name')),
                'mobileNumber' => $this->input->post('from_phone'),
            ),
            'toCustomer' => array('code' => $to_customer,
                'name' => strtoupper($this->input->post('to_name')),
                'mobileNumber' => $this->input->post('to_phone'),
            ),
            'fromCustomerAddress' => $fromCustomerAddress,
            'toCustomerAddress' => $toCustomerAddress,
            // 'remarks' => "",
            // 'paymentAmount' => $this->input->post('now_pay')?: 0,
            'vendorUser' => array('code' => $this->input->post('vendor_usercode')),
            'itemDetails' => $this->input->post('cargo_items'),
            'paymentType' => array('code' => $pay_mode),
            'totalHandlingAmount' => (int) $this->input->post('totalHandlingAmount'),
            'totalUnloadHandlingAmount' => (int) $this->input->post('totalUnloadHandlingAmount'),
            'totalAmount' => (int) $this->input->post('totalAmount'),
            'pickupHandlingAmount' => (int) $this->input->post('dp_charges'),
            'deliveryHandlingAmount' => (int) $this->input->post('dd_charges'),
            'handoverAt' => trim($this->input->post('handover_at')),
            'invoiceAmount' => trim($this->input->post('inv_amount')),
            'invoiceDate' => trim($this->input->post('inv_date')),
            'invoiceNumber' => trim($this->input->post('inv_number')),
            'fromCustomerGST' => $from_cus_gst,
            'toCustomerGST' => $to_cus_gst,
            // 'serviceCharge' => intval(trim($this->input->post('service_charges'))),
            // 'serviceTax' => intval(trim($this->input->post('service_tax'))),
            // 'hamaliCharge' => (float) trim($this->input->post('hamaliCharge')),
            // 'passCharge' => (float) trim($this->input->post('passCharge')),
            // 'docketCharge' => (float) trim($this->input->post('docketCharge')),
            'cargoAddonsDetails' => $this->input->post('cargoAddonsDetails') ?: [],
            'remarks' => $this->input->post('remarks') ?: '',
            'additionalAttribute' => $this->input->post('additionalAttribute') ?: (object)[],
        );

        // if (!empty($on_behalf_of_user)) {
        //     $data['offlineUserCode'] = $on_behalf_of_user;
        // }

        if (!empty($vendor_usercode)) {
            $data['vendorUser'] = array('code' => $vendor_usercode);
        }

        if ($this->input->post('door_pickup') == 1) {
            $data['pickupType'] = array('code' => 'PUDO');
        }

        if ($this->input->post('door_delivery') == 1) {
            $data['deliveryType'] = array('code' => 'DYDO');
        }

        echo $this->api_model->saveCargoPreBooking($data);
    }

    function cargo_pre_booking_preview() {
        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $frombranch = $this->input->post('from_branch');
        $fromstation = $this->input->post('from_station');
        $tobranch = $this->input->post('to_branch');
        $tostation = $this->input->post('to_station');

        $data = (object) [];
        $data->code = '';
        $data->activeFlag = 1;

        foreach ($branches as $branch) {
            if ($branch->organization->station->code == $fromstation && $branch->organization->code == $frombranch) {
                $data->fromOrganization = $branch->organization;
                $data->fromStation = $branch->organization->station;
            }
            if ($branch->organization->station->code == $tostation && $branch->organization->code == $tobranch) {
                $data->toOrganization = $branch->organization;
                $data->toStation = $branch->organization->station;
            }
        }

        $data->fromCustomer = (object) [];
        $data->fromCustomer->name = strtoupper($this->input->post('from_name'));
        $data->fromCustomer->mobileNumber = $this->input->post('from_phone');

        $data->toCustomer = (object) [];
        $data->toCustomer->name = strtoupper($this->input->post('to_name'));
        $data->toCustomer->mobileNumber = $this->input->post('to_phone');

        $payment_type = $this->config->item('pay_type');
        $data->paymentType = (object) [];
        $data->paymentType->code = $this->input->post('pay_mode');
        $data->paymentType->name = $payment_type[$data->paymentType->code];

        $data->itemDetails = json_decode(json_encode($this->input->post('cargo_items')));

        $data->totalHandlingAmount = 0;
        $data->totalUnloadHandlingAmount = 0;
        foreach ($data->itemDetails as $item) {
            $uomOrQty = $item->unitValue;
            if ($item->unit->code == '' || $item->unit->code == 'NPPKG') {
                $uomOrQty = $item->itemCount;
            }
            $item->computed = new stdClass;
            $item->computed->freight = $item->fare * $uomOrQty;

            $data->totalHandlingAmount += $item->loadingChargeAmount;
            $data->totalUnloadHandlingAmount += $item->unloadingChargeAmount;
        }

        // $data->paymentAmount = $this->input->post('now_pay');
        $data->pickupHandlingAmount = (int) $this->input->post('dp_charges');
        $data->deliveryHandlingAmount = (int) $this->input->post('dd_charges');
        $data->invoiceAmount = trim($this->input->post('inv_amount'));
        $data->invoiceDate = trim($this->input->post('inv_date'));
        $data->invoiceNumber = trim($this->input->post('inv_number'));
        $data->fromCustomerGST = trim($this->input->post('sender_gst'));
        $data->toCustomerGST = trim($this->input->post('receiver_gst'));
        // $data->serviceCharge = intval(trim($this->input->post('service_charges')));
        // $data->serviceTax = intval(trim($this->input->post('service_tax')));
        // $data->hamaliCharge = (float) trim($this->input->post('hamaliCharge'));
        // $data->passCharge = (float) trim($this->input->post('passCharge'));
        // $data->docketCharge = (float) trim($this->input->post('docketCharge'));
        // $data->cargoAddonsDetails = json_decode(json_encode($this->input->post('cargoAddonsDetails') ?: []));
        $data->remarks = $this->input->post('remarks') ?: '';
        $data->additionalAttribute = $this->input->post('additionalAttribute') ?: (object)[];
        $data->lrLoadType = $this->input->post('lrLoadType') ?: '';

        if ($data->lrLoadType == "PTL" || $data->lrLoadType == "FTL") {
            $data->fromStation->name = $this->input->post('from_station_name');
            $data->toStation->name = $this->input->post('to_station_name');
        }

        // $data->offlineUserCode = trim($this->input->post('on_behalf_user'));

        $data->vendorUser = trim($this->input->post('vendor_usercode'));
        $vendor_username = trim($this->input->post('vendor_username'));
        if ($data->vendorUser) {
            $data->vendorUser = (object) [];
            $data->vendorUser->code = $this->input->post('vendor_usercode');
            $data->vendorUser->name = trim($this->input->post('vendor_username'));
        }

        $data->pickup = $this->input->post('door_pickup');
        $data->del = $this->input->post('door_delivery');

        if ($this->input->post('door_pickup') == 1) {
            $data->pickupType = (object) ['code' => 'PUDO'];
        }
        if ($this->input->post('door_delivery') == 1) {
            $data->deliveryType = (object) ['code' => 'DYDO'];
        }

        $addons_mapped = array();
        foreach ($data->cargoAddonsDetails as $row) {
            $addons_mapped[$row->addonsType->code] = $row;
        }
        
        $vars = [];
        $vars['summary'] = $data;
        $vars['addons_mapped'] = $addons_mapped;
        $vars['article_unit'] = $this->config->item('article_unit');

        $this->load->view('site/prebooking/pre-booking-preview', $vars);
    }

    function cargo_pre_booking_details() {
        $this->is_logged_in();
        $summary = $this->api_model->getCargoPreBookingSummary(array('preBookCode' => $this->input->post('lrcode')));
        $summary = json_decode($summary);
        $data['summary'] = $summary->data;

        $cargo_payment_status = $this->config->item('cargo_payment_status');
        $data['payment_type_code'] = $summary->data->paymentType->code;
        $data['payment_type_name'] = $cargo_payment_status[$summary->data->paymentType->code];

        // map addons
        $data['addons_mapped'] = array();
        foreach ($summary->data->cargoAddonsDetails as $row) {
            $data['addons_mapped'][$row->addonsType->code] = $row;
        }

        // tax
        $data['tax_computed'] = new stdClass;
        foreach ($summary->data->itemDetails as $item) {
            $uomOrQty = $item->unitValue;
            if ($item->unit->code == '' || $item->unit->code == 'NPPKG') {
                $uomOrQty = $item->itemCount;
            }
            $item->computed = new stdClass;
            $item->computed->freight = $item->fare * $uomOrQty;

            $data['tax_computed']->cgstValue += $item->tax->cgstValue;
            $data['tax_computed']->sgstValue += $item->tax->sgstValue;
            $data['tax_computed']->ugstValue += $item->tax->ugstValue;
            $data['tax_computed']->igstValue += $item->tax->igstValue;
        }

        //$data['amount_paid'] = $this->api_model->getCargoItemBalance( array('cargoCode' => $this->input->post('cargoCode')) );

        $data['cargoCode'] = $this->input->post('lrcode');

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;
        $branchesGrouped = array();
        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code . '|' . $branch->station->code] = $branch->name . ' - ' . $branch->station->name;
            $branchesGrouped[$branch->station->name][$branch->code] = $branch;
        }
        $vendors = $this->api_model->cargoCustomerVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;
        $data['toBranches'] = $organization;
        ksort($branchesGrouped);
        $data['branchesGrouped'] = $branchesGrouped;

        if (in_array($summary->data->cargoStatus->code, ['CB', 'CL', 'CUL'])) {
            $deliveryremarks = $this->api_model->getCargoRemarksDelivery();
            $deliveryremarks = json_decode($deliveryremarks);
            $data['deliveryremarks'] = $deliveryremarks->data;
        }

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);

        $data['toBranchPaymentTypeList'] = [];
        foreach ($branches->data as $row) {
            if ($row->organization->code == $summary->data->toOrganization->code) {
                $data['toBranchPaymentTypeList'] = $row->paymentTypeList;
                break;
            }
        }

        $itemDetails = $this->api_model->getCargoItems();
        $itemDetail = json_decode($itemDetails);
        $data['items'] = $itemDetail->data;

        $data['article_unit'] = $this->config->item('article_unit');
        $data['cargo_payment_status'] = $cargo_payment_status;
        $data['pay_type'] = $this->config->item('pay_type');
        $data['groupusers'] = get_active_group_and_users();
        $data['user_login_code'] = $this->session->userdata('user_id');
        $data['cargo_setting'] = _get_cargo_settings();
        $data['instant_cancellation_minutes'] = $this->session->userdata('instant_cancellation_minutes');
        $data['transaction_mode'] = $this->config->item('transaction_mode');
        $data['proof_document_type'] = $this->config->item('proof_document_type');

        $this->load->view('site/prebooking/pre-booking-details', $data);
    }

    function edit_save_prebooking() {
        $this->is_logged_in();
        $param = $this->input->post('lr');
        echo $this->api_model->updatePreBooking($param);
    }

    public function update_booking_status() {
        $this->is_logged_in();

        echo $this->api_model->updatePrebookCargoStatus(array(
            'transitCode' => $this->input->post('transitCode'),
            'cargoList' => $this->input->post('cargoList'),
        ));
    }
}
?>