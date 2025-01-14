<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');


class Cargo extends MY_Controller { // cargo controller

    function __construct() {
        parent::__construct();
        $this->load->helper('common_helper');   
        $this->load->model('helper_model');   
    }

    public function index() {
        $this->is_logged_in();
        redirect('user/dashboard');
    }

    public function items() { // list items
        $this->is_logged_in();
        _include_js('assets/js/pages/cargo.js');
        $itemDetails = $this->api_model->getCargoItems(array('authtoken' => $this->_user_hash));
        $itemDetail = json_decode($itemDetails);
        $data['items'] = $itemDetail->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/items-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Cargo-items-list.xls');
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
            $this->load->view('site/cargo/items', $data);
        }
    }

    public function update_items() { // update items
        $this->is_logged_in();
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'docRequriedFlag' => $this->input->post('docRequriedFlag'),
            'defaultRate' => $this->input->post('defaultRate'),
            'name' => $this->input->post('name'),
            'description' => $this->input->post('description')?: array(),
            'defaultHandlingRate' => $this->input->post('defaultHandlingRate'),
            'minFreightAmount' => $this->input->post('minFreightAmount')?: '0',
            'gstExemptedFlag' => $this->input->post('gstExemptedFlag'),
        );
        if ($this->input->post('code') != '') {
            $data['code'] = $this->input->post('code');
        }
        echo $this->api_model->updateCargoItems($data);
    }
    public function customer_groups() { // list customer groups
        $this->is_logged_in();
        _include_js('assets/js/pages/cargo.js');
        $grpDetails = $this->api_model->getCargoCustomerGroups(array('authtoken' => $this->_user_hash));
        $grpDetail = json_decode($grpDetails);
        $data['entity'] = $grpDetail->data;
        $this->load->view('site/cargo/customer-groups', $data);
    }

    public function add_groups() { // add/edit customer groups
        $this->is_logged_in();
        $data = array(
            'name' => $this->input->post('name'),
            'activeFlag' => $this->input->post('activeFlag'),
            'defaultFlag' => 1,
        );
        if ($this->input->post('code') != '') {
            $data['code'] = $this->input->post('code');
        }
        echo $this->api_model->updateCargoCustomerGroup($data);
    }

    public function customers() { // list cargo customers
        $this->is_logged_in();
        _include_js('assets/js/pages/cargo.js', '_init_customers');

        $data['userDetail'] = array(
            // 'org_code' => $this->session->userdata('org_code'),
            // 'org_name' => $this->session->userdata('org_name'),
            'org_station_code' => $this->session->userdata('org_station_code'),
            // 'org_station_name' => $this->session->userdata('org_station_name'),
            // 'login_branch' => $this->session->userdata('org_station_code') . '|' . $this->session->userdata('org_code')
        );
        // customers
        // $custDetails = $this->api_model->getCargoCustomers(array('authtoken' => $this->_user_hash));
        // $custDetail = json_decode($custDetails);
        // $data['customers'] = $custDetail->data;
        // groups
        $grpDetails = $this->api_model->getCargoCustomerGroups(array('authtoken' => $this->_user_hash));
        $grpDetail = json_decode($grpDetails);
        $data['groups'] = $grpDetail->data;
        // stations
        $namespaceNames = $this->api_model->getNamespaceStation(array('authtoken' => _get_user_hash()));
        $namespaceNames = json_decode($namespaceNames);
        $data['stations'] = $namespaceNames->data;

        $this->load->view('site/cargo/customers', $data);
    }

    public function get_customer(){
        $data = array(
            'customerCode' => $this->input->post('customerCode'),
        );
        echo $this->api_model->getCustomer($data);
    }

    public function add_customers() { // add customers
        $this->is_logged_in();
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'customerGroup' => array('code' => $this->input->post('group')),
            'companyName' => $this->input->post('company'),
            'mobileNumber' => $this->input->post('mobile'),
            'preferedPaymentType' => $this->input->post('mode'),
            'gstin' => $this->input->post('gstin'),
            'station' => $this->input->post('stations'),
            'email' => $this->input->post('email') ?: '',
            'role' => $this->input->post('role') ?: (object)[],
            'referenceCode' => $this->input->post('referenceCode') ?: '',
            'customerMasterFlag' => 1,
        );
        if ($this->input->post('code') != '') {
            $data['code'] = $this->input->post('code');
        }
        echo $this->api_model->updateCargoCustomer($data);
    }

    public function edit_status_customer() {
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code'),
            'customerMasterFlag' => 1,
        );
        echo $this->api_model->updateCargoCustomer($data);
    }

    public function delete_customer() {
        $data = array(
            'activeFlag' => 2,
            'code' => $this->input->post('code'),
            'customerMasterFlag' => 1,
        );
        echo $this->api_model->updateCargoCustomer($data);
    }

    public function customer_tariff(){
        $this->is_logged_in();
        
        $tariff = $this->api_model->getAllTariff(array('rateCardTypeCode' => 'RC'));
        $tariffDetail = json_decode($tariff);
        $data['tariff'] = $tariffDetail->data;

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;
        
        $itemDetails = $this->api_model->getCargoItems();
        $itemDetail = json_decode($itemDetails);
        $data['items'] = $itemDetail->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $data['namespace'] = $this->session->userdata('namespace_id');

        $data['article_unit'] = $this->config->item('article_unit');
        $data['cargo_setting'] = _get_cargo_settings();

        $this->load->view('site/cargo/customer-tariff', $data);
    }

    function update_customer_tariff(){
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'customerRole' => $this->input->post('customerRole'),
            'fromStationList' => $this->input->post('fromStationList') ?: [],
            'toStationList' => $this->input->post('toStationList') ?: [],
            'fromOrganizationList' => $this->input->post('fromOrganizationList') ?: [],
            'toOrganizationList' => $this->input->post('toOrganizationList') ?: [],
            'routeType' => $this->input->post('routeType'),
            'hamaliCharge' => $this->input->post('hamaliCharge'),
            'docketCharge' => $this->input->post('docketCharge'),
            'doorPickupCharge' => $this->input->post('doorPickupCharge'),
            'doorDeliveryCharge' => $this->input->post('doorDeliveryCharge'),
            'itemDetailList' => $this->input->post('itemDetailList') ?: []
        );

        echo $this->api_model->updateTariff($data);
    }

    public function add_address() { // add address
        $this->is_logged_in();
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'station' => array('code' => $this->input->post('station')),
            'address1' => $this->input->post('addr1'),
            'address2' => $this->input->post('addr2'),
            'user' => $this->input->post('user_id'),
            'pincode' => $this->input->post('pincode'),
            'landmark' => $this->input->post('landmark'),
            'defaultFlag' => 1
        );
        if ($this->input->post('code') != '') {
            $data['code'] = $this->input->post('code');
        }
        echo $this->api_model->updateCargoCustomerAddress($data);
    }

    public function get_customer_address() {
        $this->is_logged_in();
        $usrcodes = $this->input->post('usrCode');
        $data = array(
            'user' => $usrcodes
        );
        $address = $this->api_model->getCargoCustomerAddress($data);
        $address = json_decode($address);
        $data['address'] = $address->data;
        $this->load->view('site/cargo/customers-address', $data);
    }

    public function get_customer_address_for_booking() {
        $this->is_logged_in();

        echo $this->api_model->getCargoCustomerAddressv2(array(
            'customerMobile' => $this->input->post('customerMobile')
        ));
    }

    public function get_vendor_address_for_booking() {
        $this->is_logged_in();

        echo $this->api_model->getVendorAddress(array(
            'vendorCode' => $this->input->post('vendorCode')
        ));
    }

    public function booking() { // add cargo booking
        $this->is_logged_in();
        _include_js('assets/js/pages/cargo.js', '_init_cargo_booking_page');

        $data['userDetail'] = array(
            'org_code' => $this->session->userdata('org_code'),
            'org_name' => $this->session->userdata('org_name'),
            'org_station_code' => $this->session->userdata('org_station_code'),
            'org_station_name' => $this->session->userdata('org_station_name'),
            'login_branch' => $this->session->userdata('org_station_code') . '|' . $this->session->userdata('org_code')
        );

        $data['cargo_setting'] = _get_cargo_settings();

        // $branches = $this->api_model->getCargoOrganization();
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
        //     $vendors = $this->api_model->cargoCustomerVendor();
        // }
        // $vendors = json_decode($vendors);
        // $data['vendors'] = $vendors->data;
        // $data['vendors'] = [];

        // if (has_action_rights('CARGO-TRANSIT-DET')) {
            // $vehicles = $this->api_model->getVehicle();
            // $vehicles = json_decode($vehicles);
            // $data['vehicles'] = $vehicles->data;

            // $drivers = $this->api_model->getVehicleDriver();
            // $drivers = json_decode($drivers);
            // $data['drivers'] = $drivers->data;
        // }
        
        if ($data['cargo_setting']->showCustomerAddressFlag || $data['cargo_setting']->mandateAddressOnBookingFlag) {
            $namespaceNames = $this->api_model->getNamespaceStation(array('authtoken' => _get_user_hash()));
            $namespaceNames = json_decode($namespaceNames);
            $data['stations'] = $namespaceNames->data;
        }

        $cargoremarks = $this->api_model->getCargoRemarksBooking();
        $cargoremarks = json_decode($cargoremarks);
        $data['cargoremarks'] = $cargoremarks->data;

        $referenceLR = $this->input->get('referenceLR');
        if ($referenceLR) {
            $summary = $this->api_model->getCargoSummary(array('cargoCode' => $referenceLR));
            $summary = json_decode($summary);
            $data['referenceLRDetails'] = $summary->data;
        }

        $branches = $this->api_model->getDeliveryBranches();
        $data['delivery_branches'] = getData($branches);

        $data['article_unit'] = $this->config->item('article_unit');
        $data['pay_type'] = $this->config->item('pay_type');
        $data['transaction_mode'] = $this->config->item('transaction_mode');
        $data['bank_names_list'] = $this->config->item('bank_names_list');
        $data['machine_handling_tariff'] = $this->config->item('machine_handling_tariff');
        $data['ewaybill_vendor_code'] = $this->session->userdata('ewaybill_vendor_code');
        $data['sms_notification_flag_code'] = $this->session->userdata('sms_notification_flag_code');
        $org_code = $this->session->userdata('org_code');

        $this->load->view('site/cargo/booking', $data);
    }

    function save_booking() {
        $this->is_logged_in();

        $door_pick =  $this->input->post('door_pickup');
        $door_delivery_type =  $this->input->post('door_delivery_type');

        $pay_mode = $this->input->post('pay_mode');

        $now_pay = $this->input->post('now_pay');
        $net_pay = $this->input->post('net_pay');
        if ($net_pay > 0 && $now_pay == $net_pay) {
            $pay_mode = 'PAD';
        }

        $update_from_customer = trim($this->input->post('update_from_customer'));
        $update_to_customer = trim($this->input->post('update_to_customer'));
        
        $from_customer = trim($this->input->post('from_customer'));
        $from_customer_phone = trim($this->input->post('from_phone'));
        $to_customer = trim($this->input->post('to_customer'));
        $to_customer_phone = trim($this->input->post('to_phone'));
        
        $fromCustomerAddress = $this->input->post('dp_address_code') ?: '';
        $toCustomerAddress = $this->input->post('dd_address_code') ?: '';

        $from_cus_gst = strtoupper(trim($this->input->post('sender_gst')));
        $to_cus_gst = strtoupper(trim($this->input->post('receiver_gst')));

        $on_behalf_of_user = trim($this->input->post('on_behalf_user'));

        $vendor_user = trim($this->input->post('vendor_user'));
        $additionalAttribute = (object) ($this->input->post('additionalAttribute') ?: []);
        
        // save from customer
        if (empty($from_customer) || $update_from_customer) {
            $fromCustomerRole = 'RC';
            if ($additionalAttribute->fromCustomerGstType == 'CMPY') {
                $fromCustomerRole = 'CMPY';
            }

            $data = array(
                'activeFlag' => 1,
                'code' => $from_customer,
                'name' => strtoupper($this->input->post('from_name')),
                'companyName' => $this->input->post('sender_company') ?: 'Common',
                'mobileNumber' => $from_customer_phone,
                'email' => $this->input->post('from_email') ?: '',
                'preferedPaymentType' => $pay_mode,
                'gstin' => $from_cus_gst,
                'role' => array('code' => $fromCustomerRole),
                'station' => array(
                    array('code' => $this->input->post('from_station'))
                )
            );
            $fr = $this->api_model->updateCargoCustomer($data);
            $fr = json_decode($fr);

            if ($fr->status == 0 && $fr->errorCode == '207') {
                $fr->errorDesc = 'Invalid From Customer GST Identification Number';
                echo json_encode($fr);
                return;
            }
            $from_customer = $fr->data->code;
            $from_customer_phone = $fr->data->mobileNumber;
        }

        if (isNotNull($from_customer) && $this->input->post('dp_address_selected') != 1 && $this->input->post('dp_address')) {
            if ($this->input->post('dp_address_available') || $door_pick == 1) { // if door pick up checked
                $update_cus_address = array(
                    'name' =>  $this->input->post('from_name'),
                    'address1' => $this->input->post('dp_address'),
                    'landmark' => $this->input->post('dp_landmark'),
                    'pincode' => $this->input->post('dp_pincode'),
                    'station' => array('code' => $this->input->post('dp_station')),
                    'user' => $from_customer,
                    'code'  => $fromCustomerAddress,
                    'defaultFlag' => 1,
                    'activeFlag'  => 1
                );

                $result = $this->api_model->updateCargoCustomerAddress($update_cus_address);
                $result = json_decode($result);

                if ($result->status == 0 && $result->errorCode == '322') {
                    $result->errorDesc = 'Similar From Customer Address Found!';
                    echo json_encode($result);
                    return;
                }
                $fromCustomerAddress = $result->data->code;
            }
        }

        // save to customer
        if (empty($to_customer) || $update_to_customer) {
            if ($from_customer_phone == $to_customer_phone) {
                $to_customer = $from_customer;
            } else {
                $toCustomerRole = 'RC';
                if ($additionalAttribute->toCustomerGstType == 'CMPY') {
                    $toCustomerRole = 'CMPY';
                }

                $data = array(
                    'activeFlag' => 1,
                    'code' => $to_customer,
                    'name' => strtoupper($this->input->post('to_name')),
                    //'customerGroup' => array('code'=>'CGFCPCG94967'),
                    'companyName' => $this->input->post('receiver_company') ?: 'Common',
                    'mobileNumber' => $to_customer_phone,
                    'email' => $this->input->post('to_email') ?: '',
                    'preferedPaymentType' => $pay_mode,
                    'gstin' => $to_cus_gst,
                    'role' => array('code' => $toCustomerRole),
                    'station' => array(
                        array('code' => $this->input->post('to_station'))
                    )
                );
                $to = $this->api_model->updateCargoCustomer($data);
                $to = json_decode($to);

                if ($to->status == 0 && $to->errorCode == '207') {
                    $to->errorDesc = 'Invalid To Customer GST Identification Number';
                    echo json_encode($to);
                    return;
                }
                $to_customer = $to->data->code;
                $to_customer_phone = $to->data->mobileNumber;
            }
        }

        if (isNotNull($to_customer) && $this->input->post('dd_address_selected') != 1 && $this->input->post('dd_address')) {
            if ($this->input->post('dd_address_available') || in_array($door_delivery_type, ['DYDO', 'WAYDY'])) { // if door delivery checked
                $update_cus_address = array(
                    'name' =>  $this->input->post('to_name'),
                    'address1' => $this->input->post('dd_address'),
                    'landmark' => $this->input->post('dd_landmark'),
                    'pincode' => $this->input->post('dd_pincode'),
                    'station' => array('code' => $this->input->post('dd_station')),
                    'user' => $to_customer,
                    'code'  => $toCustomerAddress,
                    'defaultFlag' => 1,
                    'activeFlag'  => 1
                );

                $result = $this->api_model->updateCargoCustomerAddress($update_cus_address);
                $result = json_decode($result);

                if ($result->status == 0 && $result->errorCode == '322') {
                    $result->fromCustomerAddressCode = $fromCustomerAddress;
                    $result->errorDesc = 'Similar To Customer Address Found!';
                    echo json_encode($result);
                    return;
                }
                $toCustomerAddress = $result->data->code;
            }
        }

        $data = array(
            'code' => '',
            'fromStation' => array('code' => $this->input->post('from_station')),
            'toStation' => array('code' => $this->input->post('to_station')),
            'fromOrganization' => array('code' => $this->input->post('from_branch')),
            'toOrganization' => array('code' => $this->input->post('to_branch')),
            'fromCustomer' => array(
                'code' => $from_customer ?? '',
                'name' => strtoupper($this->input->post('from_name')),
                'mobileNumber' => $from_customer_phone,
            ),
            'toCustomer' => array(
                'code' => $to_customer ?? '',
                'name' => strtoupper($this->input->post('to_name')),
                'mobileNumber' => $to_customer_phone,
            ),
            'fromCustomerAddress' => array('code' => $fromCustomerAddress),
            'toCustomerAddress' => array('code' => $toCustomerAddress),
            'remarks' => "",
            'paymentAmount' => $this->input->post('now_pay')?: 0,
            'itemDetails' => $this->input->post('cargo_items'),
            'paymentType' => array('code' => $pay_mode),
            'pickupHandlingAmount' => (int) $this->input->post('dp_charges'),
            'deliveryHandlingAmount' => (int) $this->input->post('dd_charges'),
            'fromCustomerGST' => $from_cus_gst,
            'toCustomerGST' => $to_cus_gst,
            'serviceCharge' => intval(trim($this->input->post('service_charges'))),
            'serviceTax' => trim($this->input->post('service_tax')),
            'hamaliCharge' => (float) trim($this->input->post('hamaliCharge')),
            'passCharge' => (float) trim($this->input->post('passCharge')),
            'docketCharge' => (float) trim($this->input->post('docketCharge')),
            'cargoAddonsDetails' => $this->input->post('cargoAddonsDetails') ?: [],
            // 'invoiceDetails' => $this->input->post('invoiceDetails') ?: [],
            'cargoTransactionList' => $this->input->post('cargoTransactionList') ?: [],
            'remarks' => $this->input->post('remarks') ?: [],
            'additionalAttribute' => $additionalAttribute ?: (object)[]
        );

        if (!empty($on_behalf_of_user)) {
            $data['offlineUserCode'] = $on_behalf_of_user;
        }

        if (!empty($vendor_user)) {
            $data['vendorUser'] = array('code' => $vendor_user);
        }

        if ($this->input->post('door_pickup') == 1) {
            $data['pickupType'] = array('code' => 'PUDO');
        }

        if (isNotNull($door_delivery_type)) {
            $data['deliveryType'] = array('code' => $door_delivery_type);
        }

        $additionalAttribute = $this->input->post('additionalAttribute');
        if ($additionalAttribute['CARGO_POSTFIX_CODE']) {
            $validate = $this->api_model->checkCargoCodeExists(array(
                'fromStation' => array('code' => $this->input->post('from_station')),
                'toStation' => array('code' => $this->input->post('to_station')),
                'fromOrganization' => array('code' => $this->input->post('from_branch')),
                'toOrganization' => array('code' => $this->input->post('to_branch')),
                'paymentType' => array('code' => $pay_mode),
                'additionalAttribute' => array(
                    'CARGO_POSTFIX_CODE' => $additionalAttribute['CARGO_POSTFIX_CODE']
                ),
            ));
            $validate = json_decode($validate);

            if ($validate->status != 1 && $validate->errorCode == 'CG004') {
                $validate->errorDesc = 'Manual LR number already exists';
                echo json_encode($validate);
                return;
            }
            if ($validate->status != 1) {
                echo json_encode($validate);
                return;
            }
        }

        //print_r($data);
        echo $this->api_model->saveCargoBooking($data);
    }

    function cargo_booking_preview()
    {
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
            if ($branch->station->code == $fromstation && $branch->code == $frombranch) {
                $data->fromOrganization = $branch;
                $data->fromStation = $branch->station;
            }
            if ($branch->station->code == $tostation && $branch->code == $tobranch) {
                $data->toOrganization = $branch;
                $data->toStation = $branch->station;
            }
        }

        $data->fromCustomer = (object) [];
        $data->fromCustomer->name = strtoupper($this->input->post('from_name'));
        $data->fromCustomer->mobileNumber = $this->input->post('from_phone');
        $data->fromCustomer->companyName = $this->input->post('sender_company');

        $data->toCustomer = (object) [];
        $data->toCustomer->name = strtoupper($this->input->post('to_name'));
        $data->toCustomer->mobileNumber = $this->input->post('to_phone');
        $data->toCustomer->companyName = $this->input->post('receiver_company');

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

            $data->totalHandlingAmount += $item->handlingChargeAmount;
            $data->totalUnloadHandlingAmount += $item->unloadingChargeAmount;
        }

        $data->paymentAmount = $this->input->post('now_pay');
        $data->pickupHandlingAmount = (int) $this->input->post('dp_charges');
        $data->deliveryHandlingAmount = (int) $this->input->post('dd_charges');
        $data->invoiceAmount = trim($this->input->post('inv_amount'));
        $data->invoiceDate = trim($this->input->post('inv_date'));
        $data->invoiceNumber = trim($this->input->post('inv_number'));
        $data->fromCustomerGST = trim($this->input->post('sender_gst'));
        $data->toCustomerGST = trim($this->input->post('receiver_gst'));
        $data->serviceCharge = intval(trim($this->input->post('service_charges')));
        $data->serviceTax = $this->input->post('service_tax');
        $data->hamaliCharge = (float) trim($this->input->post('hamaliCharge'));
        $data->passCharge = (float) trim($this->input->post('passCharge'));
        $data->docketCharge = (float) trim($this->input->post('docketCharge'));
        $data->cargoAddonsDetails = json_decode(json_encode($this->input->post('cargoAddonsDetails') ?: []));
        $data->remarks = json_decode(json_encode($this->input->post('remarks') ?: []));
        $data->cargoTransactionList = json_decode(json_encode($this->input->post('cargoTransactionList') ?: []));
        $data->additionalAttribute = $this->input->post('additionalAttribute') ?: (object)[];

        $data->offlineUserCode = trim($this->input->post('on_behalf_user'));

        $vendor_user = trim($this->input->post('vendor_user'));
        if ($vendor_user) {
            $data->vendorUser = (object) [];
            $data->vendorUser->code = $vendor_user;
            $data->vendorUser->name = trim($this->input->post('vendor_user_name'));
        }
        if ($this->input->post('door_pickup') == 1) {
            $data->pickupType = (object) ['code' => 'PUDO'];
        }
        if ($this->input->post('door_delivery') == 1) {
            $data->deliveryType = (object) ['code' => 'DYDO'];
        }

        $addons_mapped = array();
        foreach ($data->cargoAddonsDetails as $row) {
            if ($row->addonsType->code == 'FRECR') {
                $row->valueList = explode(',', $row->value);
            }
            $addons_mapped[$row->addonsType->code] = $row;
        }
        
        $vars = [];
        $vars['summary'] = $data;
        $vars['addons_mapped'] = $addons_mapped;
        $vars['article_unit'] = $this->config->item('article_unit');
        $vars['cargo_setting'] = _get_cargo_settings();

        $this->load->view('site/cargo/booking-preview', $vars);
    }

    function edit_save_cargo() {
        $this->is_logged_in();
        $param = $this->input->post('lr');
        echo $this->api_model->updateCargoBooking($param);
    }
    
    function cargo_details() {
        $this->is_logged_in();
        $summary = $this->api_model->getCargoSummary(array('cargoCode' => $this->input->post('cargoCode')));
        $summary = json_decode($summary);
        $data['summary'] = $summary->data;
        $data['cargoData'] = [];

        $computed = new stdClass;
        $computed->customerTdsTaxAmount = 0;
        foreach ($summary->data->cargoTransactionList as $cargoTransaction) {
            if ($cargoTransaction->transactionType->code == 'CGBO') {
                $computed->customerTdsTaxAmount += $cargoTransaction->customerTdsTaxAmount;
            } else if ($cargoTransaction->transactionType->code == 'CGCA') {
                $computed->customerTdsTaxAmount -= $cargoTransaction->customerTdsTaxAmount;
            }
        }
        $summary->data->computed = $computed;

        $cargo_payment_status = $this->config->item('cargo_payment_status');
        $data['payment_type_code'] = $summary->data->paymentType->code;
        $data['payment_type_name'] = $cargo_payment_status[$summary->data->paymentType->code];
        // change invoice pay to paid if settlement completed
        // if ($summary->data->paymentType->code == 'INP' && $summary->data->paymentSettlementFlag == 1) {
        //     $data['payment_type_code'] = 'PAD';
        //     $data['payment_type_name'] = $cargo_payment_status['PAD'];
        // }

        // map addons
        $data['addons_mapped'] = array();
        foreach ($summary->data->cargoAddonsDetails as $row) {
            if ($row->addonsType->code == 'FRECR') {
                $row->valueList = explode(',', $row->value);
            }

            if ($row->addonsType->code == 'EWBL') {
                $data['addons_mapped'][$row->addonsType->code][] = $row;
            } else {
                $data['addons_mapped'][$row->addonsType->code] = $row;
            }
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

        $data['additional_status_list'] = [];
        foreach ($summary->data->additionalStatus as $status) {
            $data['additional_status_list'][$status->code] = $status->name;
        }

        //$data['amount_paid'] = $this->api_model->getCargoItemBalance( array('cargoCode' => $this->input->post('cargoCode')) );

        $data['cargoCode'] = $this->input->post('cargoCode');

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;
        $branchesGrouped = array();
        $organization = array();
        $hamaliCharge =0;
        foreach ($branches as $branch) {
            $organization[$branch->code . '|' . $branch->station->code] = $branch->name . ' - ' . $branch->station->name;
            $branchesGrouped[$branch->station->name][$branch->code] = $branch;
            if ($summary->data->toOrganization->code == $branch->code) {
                $hamaliCharge +=$row->hamaliCharge;
            }
        }
        $vendors = $this->api_model->cargoCustomerVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;
        $data['toBranches'] = $organization;
        ksort($branchesGrouped);
        $data['branchesGrouped'] = $branchesGrouped;

        if (in_array($summary->data->cargoStatus->code, ['CB', 'CL', 'CUL']) || has_action_rights('CGO-ADJSMT-AMT')) {
            $cargoremarks = $this->api_model->getCargoRemarks();
            $cargoremarks = json_decode($cargoremarks);
            $data['cargoremarks'] = $cargoremarks->data;
        }

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['toBranchPaymentTypeList'] = [];
        $data['reporting_branch'] = null;
        foreach ($branches->data as $row) {
            if ($row->code == $summary->data->toOrganization->code) {
                $data['toBranchPaymentTypeList'] = $row->paymentTypeList;
                continue;
            }
            if($this->session->userdata('org_code') == $row->code){
                if(count($row->subOrganizations)){
                 $data['reporting_branch'] = $row->subOrganizations;
                }
            }
        }
        $itemDetails = $this->api_model->getCargoItems();
        $itemDetail = json_decode($itemDetails);
        $data['items'] = $itemDetail->data;

        $deliveryAmt = 0;
        foreach ($summary->data->cargoTransactionList as $cargoTransactionList) {
            $deliveryAmt +=$cargoTransactionList->transactionAmount;
            break;
        }
        
        $data['deliveryAmt'] =$deliveryAmt;
        $data['hamaliCharge'] =$hamaliCharge;
        $data['article_unit'] = $this->config->item('article_unit');
        $data['cargo_remarks_status'] = $this->config->item('cargo_remarks_status');
        $data['cargo_payment_status'] = $cargo_payment_status;
        $data['pay_type'] = $this->config->item('pay_type');
        $data['groupusers'] = get_active_group_and_users();
        $data['user_login_code'] = $this->session->userdata('user_id');
        $data['login_branch'] = $this->session->userdata('org_code');
        $data['cargo_setting'] = _get_cargo_settings();
        $unloadingChargeConfig = json_decode($data['cargo_setting']->unloadingChargeConfig, true);
        $unloadingChargeConfig= array_keys($unloadingChargeConfig);
        $data['loading_chagers_setting'] = $unloadingChargeConfig[0];
        $data['instant_cancellation_minutes'] = $this->session->userdata('instant_cancellation_minutes');
        $data['transaction_mode'] = $this->config->item('transaction_mode');
        $data['proof_document_type'] = $this->config->item('proof_document_type');
        $data['bank_names_list'] = $this->config->item('bank_names_list');
        $data['machine_handling_tariff'] = $this->config->item('machine_handling_tariff');
        $data['onBooked'] = $this->input->post('onBooked');
        $temp_array=[];
        if(isset($summary->data->additionalAttribute->REFERENCE_CARGO_CODE)){
            $orginLr=$summary->data->additionalAttribute->REFERENCE_CARGO_CODE;
            $orginLrReq =$this->api_model->get_lr_nodes($orginLr);
            $orginLrReq=json_decode($orginLrReq,true);
            
            // $set_data = array();
            foreach($orginLrReq['data'] as $child){
                $data['orgin_cargo']=$orginLr;
                $data['cargoData'][] = $child;
                continue;
            }
        
            $cargoDetails=$this->api_model->getCargoSummary(array('cargoCode'=>$orginLr));
            $cargoDetails=json_decode($cargoDetails);
            $data['parent_cargoStatus']=$cargoDetails->data->cargoStatus;
            $data['parent_paymentType']=$cargoDetails->data->paymentType;
            $data['cargo_status'] = config_item('cargo_status');
            $data['cargo_payment_status'] = config_item('cargo_payment_status');
        }else{
            $orginLr=$summary->data->code;
            $orginLrReq =$this->api_model->get_lr_nodes($orginLr);
            $orginLrReq=json_decode($orginLrReq,true);
            
            // $set_data = array();
            foreach($orginLrReq['data'] as $child){
                $data['orgin_cargo']=$orginLr;
                $data['cargoData'][] = $child;
                continue;
            }
        
            $cargoDetails=$this->api_model->getCargoSummary(array('cargoCode'=>$orginLr));
            $cargoDetails=json_decode($cargoDetails);
            $data['parent_cargoStatus']=$cargoDetails->data->cargoStatus;
            $data['parent_paymentType']=$cargoDetails->data->paymentType;
            $data['cargo_status'] = config_item('cargo_status');
            $data['cargo_payment_status'] = config_item('cargo_payment_status');
        }
        
        $org_code = $this->session->userdata('org_code');
        $organizationList = $this->api_model->organizationLists();
        $organizationList = json_decode($organizationList);

       
        foreach ($organizationList->data as $val) {
            if ($val->code == $org_code) {
                $data['transactions_details'] = $val->transactionMode;
            }
        }
        $this->load->view('site/cargo/booking-details', $data);
    }

    public function payment_type(){
        $data = [];
        $fromOrg = $this->input->post('fromOrganization');
        $fromOrgData = $this->api_model->getOrganizationDetails(['organizationcode'=>$fromOrg]);
        $fromOrgData = getData($fromOrgData); 
        // $toOrg = $summary->data->toOrganization->code;
        $toOrg = $this->input->post('toOrganization');
        $toOrgData = $this->api_model->getOrganizationDetails(['organizationcode'=>$toOrg]);
        $toOrgData = getData($toOrgData); 
        $data['fromOrganization'] = $fromOrgData;
        $data['toOrganization'] = $toOrgData;
        response('true',$data);
    }

    function cargo_history() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQG1614311',
            'cargoCode' => $this->input->post('cargoCode')
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['transactions'] = $result->data;

        $data['cargoCode'] = $this->input->post('cargoCode');
        $this->load->view('site/cargo/history', $data);
    }
    
    function add_payment() {
        $this->is_logged_in();
        $data = array(
            'cargoCode' => $this->input->post('code'),
            'transactionType' => array('code' => 'CGBO'),
            'transactionAmount' => $this->input->post('amount'),
            'offlineUserCode' => $this->input->post('offlineUserCode') ?: '',
            'transactionMode' => $this->input->post('transactionMode') ?: (object)[]
        );
        echo $this->api_model->addCargoPayment($data);
    }

    function update_unloading_charges() {
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('code'),
            'itemDetails' => $this->input->post('itemDetails')
        );
        echo $this->api_model->addCargoUnloadingCharges($data);
    }

    function revert_payment() {
        $this->is_logged_in();
        $data = array(
            'cargoCode' => $this->input->post('code'),
            'transactionType' => array('code' => 'CGCA'),
            'transactionAmount' => $this->input->post('amount'),
            'remarks' => $this->input->post('remarks'),
            // 'customerTdsTaxAmount' => $this->input->post('customerTdsTaxAmount'),
        );
        echo $this->api_model->revertCargoPayment($data);
    }

    function print_cargo_summary() {
        $this->is_logged_in();
        $summary = $this->api_model->getCargoSummary(array('cargoCode' => $this->input->get('code')));        
        $summary = json_decode($summary);
        $data['namespace_name'] = $this->session->userdata('namespace_name');
        $data['cargoCode'] = $this->input->get('code');

        //  Mask customer mobile numbers in printouts.
        if (has_action_rights('PRNT-MOB-MASK')) {
            $summary->data->fromCustomer->mobileNumber = substr_replace($summary->data->fromCustomer->mobileNumber, 'XXX', 4, 3);
            $summary->data->toCustomer->mobileNumber = substr_replace($summary->data->toCustomer->mobileNumber, 'XXX', 4, 3);
        }
        
        $data['summary'] = $summary->data;
        
        $cargo_payment_status = $this->config->item('cargo_payment_status');
        $data['payment_type_code'] = $summary->data->paymentType->code;
        $data['payment_type_name'] = $cargo_payment_status[$summary->data->paymentType->code];
        // change invoice pay to paid if settlement completed
        // if ($summary->data->paymentType->code == 'INP' && $summary->data->paymentSettlementFlag == 1) {
        //     $data['payment_type_code'] = 'PAD';
        //     $data['payment_type_name'] = $cargo_payment_status['PAD'];
        // }

        // map addons
        $data['addons_mapped'] = array();
        foreach ($summary->data->cargoAddonsDetails as $row) {
            if ($row->addonsType->code == 'FRECR') {
                $row->value = explode(',', $row->value);
            }
            if ($row->addonsType->code == 'EWBL') {
                $data['addons_mapped'][$row->addonsType->code][] = $row;
            } else {
                $data['addons_mapped'][$row->addonsType->code] = $row;
            }
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

        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
        $usr_pro = json_decode($usr_pro);
        $data['user_profile'] = $usr_pro->data;

        $nsprofile = $this->api_model->getNamespaceProfile(array('authtoken' => $this->_user_hash));
        $nspro = json_decode($nsprofile);
        $data['nsprofile'] = $nspro->data;

        $termsDetails = $this->api_model->getterms(array('type' => 'CGBO'));
        $termslist = json_decode($termsDetails);
        $data['terms_list'] = $termslist->data;

        $data['article_unit'] = $this->config->item('article_unit');
        $data['cargo_payment_status'] = $this->config->item('cargo_payment_status');

        define(K_TCPDF_CALLS_IN_HTML , true);

        //  3" print
        if ($this->input->get('type') == 3) {   // 3inch print.
            $this->load->exclude_template();
            $nscode = _get_namespace_id();
            
            $tplfile = '3-print';
            if(is_file(config_item('smarty_template_dir').'site/cargo/3-print-'.$nscode.'.tpl') ) {
                $tplfile = '3-print-'.$nscode;
            }              
            //if($nscode == "sssparcel") 
                //$tplfile = '3-print-sss';
            $data['logo_avail'] = is_file('assets/img/clientlogo/'.$nscode.'_3inch.png');
            $this->load->view('site/cargo/'.$tplfile, $data);
              
            
        } else if ($this->input->get('type') == 'dotmatrix') { // dot matrix
            if($this->session->userdata('namespace_id') == "sssparcel"){    // SSS Parcel Service, Epson LQ-310, Pre-Printed sheet
                require_once APPPATH . 'third_party/tcpdf/tcpdf.php';

                $pageLayout = array(283, 566); //  or array($height, $width) 20inch width, 10inch height
                $pdf = new TCPDF('L', 'pt', $pageLayout, true, 'UTF-8', false);

                $pdf->setPrintHeader(false);
                $pdf->setPrintFooter(false);
                $pdf->SetMargins(0, 35, 35, true);
                $pdf->SetFont('times', '', 11);

                $pdf->AddPage();

                ob_clean();
                $this->load->exclude_template();
                $content = $this->load->view('site/cargo/dotmatrix-sssparcel', $data, true);
                $pdf->writeHTML($content);

                $pdf->IncludeJS("print();");
                $pdf->Output('cargo-summary.pdf', 'i');
            } else if(in_array($this->session->userdata('namespace_id'), ["kntlogistics","knttransports"])){
                
                require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
        
                $pdf = new TCPDF();
                $pdf->setPrintHeader(false);
                $pdf->setPrintFooter(false);
                $pdf->SetFont('times', '', 8);
                $pdf->AddPage();

                ob_clean();
                $this->load->exclude_template();
                $freight = 0;
                $quantity = 0;

                $ton_freight = 0;
                $ton_actual_wt = 0;
                $ton_charged_wt = 0;
                $ton_quantity = 0;
                
                $loading_charge = 0;
                $unloading_charge = 0;
                $door_del = 0;
                $gst = 0;
                $cgst = 0;
                $sgst = 0;
                $others = 0;

                $lr_charge = 0;
                $door_col = 0;
                $tot = 0;
                $total_articles = 0;
                $unit_arr = ['TON', 'QNTL', 'KG'];
                foreach ($data['summary']->itemDetails as $article) {
                    if(!in_array($article->unit->code, $unit_arr)){
                        $freight += ($article->fare * $article->itemCount);
                        $quantity += $article->itemCount;
                    }else{
                        $ton_freight += ($article->fare * $article->unitValue);
                        $ton_wt += $article->actualUnitValue;
                        $ton_char_wt += $article->unitValue;
                        $ton_quan += $article->itemCount;
                    }

                    $loading_charge += $article->handlingChargeAmount;
                    $unloading_charge += $article->unloadingChargeAmount;
                    $gst += $article->serviceTax;
                    $cgst += $article->tax->cgstValue;
                    $sgst += $article->tax->sgstValue;

                    $total_articles += $article->itemCount;

                }
                
                $lr_charge += $data['summary']->docketCharge;
                $door_col += $data['summary']->pickupHandlingAmount;
                $door_del += $data['summary']->deliveryHandlingAmount;
                $others += $data['summary']->serviceCharge + $data['summary']->docketCharge + $data['summary']->passCharge;
                $tot += $freight+$ton_freight+$data['summary']->totalHandlingAmount+$data['summary']->totalUnloadHandlingAmount+$data['summary']->pickupHandlingAmount+$data['summary']->deliveryHandlingAmount+$data['summary']->serviceCharge+$data['summary']->serviceTax+$data['summary']->hamaliCharge+$data['summary']->passCharge+$data['summary']->docketCharge + $data['addons_mapped']['PODCH']->value+ $data['addons_mapped']['DMRCH']->value + $data['addons_mapped']['RNDF']->value;

                $fre = number_format(($freight), 2);
                $freight_amt = explode('.', $fre);

                if(strlen($freight_amt[0]) < 8) {
                    $frght = space(8-strlen($freight_amt[0])).$freight_amt[0];
                }
                
                $door = number_format(($door_col), 2);
                $door_col_amt = explode('.', $door);

                if(strlen($door_col_amt[0]) < 8) {
                    $door_collec = space(8-strlen($door_col_amt[0])).$door_col_amt[0];
                }

                $deli = number_format(($door_del), 2);
                $door_del_amt = explode('.', $deli);

                if(strlen($door_del_amt[0]) < 8) {
                    $door_deli = space(8-strlen($door_del_amt[0])).$door_del_amt[0];
                }

                $hamali = number_format(($summary->hamaliCharge + $loading_charge + $unloading_charge), 2);
                $hamali_amt = explode('.', $hamali);

                if(strlen($hamali_amt[0]) < 8) {
                    $hmli = space(8-strlen($hamali_amt[0])).$hamali_amt[0];
                }

                $c_gst = number_format(($cgst), 2);
                $cgst_amt = explode('.', $c_gst);

                if(strlen($cgst_amt[0]) < 8) {
                    $c_gst_amt = space(8-strlen($cgst_amt[0])).$cgst_amt[0];
                }

                $s_gst = number_format(($sgst), 2);
                $sgst_amt = explode('.', $s_gst);

                if(strlen($sgst_amt[0]) < 8) {
                    $s_gst_amt = space(8-strlen($sgst_amt[0])).$sgst_amt[0];
                }

                $other = number_format(($others), 2);
                $others_amt = explode('.', $other);

                if(strlen($others_amt[0]) < 8) {
                    $other_amt = space(8-strlen($others_amt[0])).$others_amt[0];
                }

                $tot_amt = number_format(($tot), 2);
                $total = explode('.', $tot_amt);

                if(strlen($total[0]) < 8) {
                    $total_amt = space(8-strlen($total[0])).$total[0];
                }

                $tot_ton = number_format(($ton_freight), 2);
                $ton_frght = explode('.', $tot_ton);

                // if(strlen($ton_frght[0]) < 8) {
                //     $total_ton = space(8-strlen($ton_frght[0])).$ton_frght[0];
                // }

                // customer
                if(strlen($data['summary']->fromCustomer->name) < 20) {
                    $from_customer = $data['summary']->fromCustomer->name.space(21-strlen($data['summary']->fromCustomer->name));
                }else{
                    $from_customer = substr($data['summary']->fromCustomer->name,0,20).".";
                }

                if(strlen($data['summary']->toCustomer->name) < 20) {
                    $to_customer = $data['summary']->toCustomer->name.space(21-strlen($data['summary']->toCustomer->name));
                }else{
                    $to_customer = substr($data['summary']->toCustomer->name,0,20).".";
                }

                // organization
                if(strlen($data['summary']->fromOrganization->name) < 25) {
                    $from_org = $data['summary']->fromOrganization->name.space(28-strlen($data['summary']->fromOrganization->name));
                }else{
                    $from_org = substr($data['summary']->fromOrganization->name,0,25)."...";
                }

                if(strlen($data['summary']->toOrganization->name) < 25) {
                    $to_org = $data['summary']->toOrganization->name.space(28-strlen($data['summary']->toOrganization->name));
                }else{
                    $to_org = substr($data['summary']->toOrganization->name,0,25)."...";
                }

                // mobile num
                if(strlen($data['summary']->fromOrganization->contact) < 12) {
                    $customer_mob = "Mobile : " . $data['summary']->fromOrganization->contact.space(15-strlen($data['summary']->fromOrganization->contact));
                }else{
                    $customer_mob = "Mobile : " . substr($data['summary']->fromOrganization->contact,0,12)."...";
                }

                if(strlen($data['summary']->toOrganization->contact) < 12) {
                    $org_mob = "Mobile : " . $data['summary']->toOrganization->contact.space(15-strlen($data['summary']->toOrganization->contact));
                }else{
                    $org_mob = "Mobile : " . substr($data['summary']->toOrganization->contact,0,12)."...";
                }

                // gst
                if(strlen($data['summary']->fromCustomerGST->name) < 12) {
                    $from_gst = "GSTIN : " . $data['summary']->fromCustomerGST->name.space(15-strlen($data['summary']->fromCustomerGST->name));
                }else{
                    $from_gst = "GSTIN : " . substr($data['summary']->fromCustomerGST->name,0,12)."...";
                }

                if(strlen($data['summary']->toCustomerGST->name) < 12) {
                    $to_gst = "GSTIN : " . $data['summary']->toCustomerGST->name.space(15-strlen($data['summary']->toCustomerGST->name));
                }else{
                    $to_gst = "GSTIN : " . substr($data['summary']->toCustomerGST->name,0,12)."...";
                }

                // ton and quintal
                if($ton_wt){
                    if(strlen($ton_wt) < 8) {
                        $ton_actual_wt = $ton_wt.space(10-strlen($ton_wt));
                    }else{
                        $ton_actual_wt = substr($ton_wt,0,8)."..";
                    }
                }else{
                    $ton_actual_wt = '0'.space(9);
                }

                if($ton_char_wt){
                    if(strlen($ton_char_wt) < 8) {
                        $ton_charged_wt = $ton_char_wt.space(10-strlen($ton_char_wt));
                    }else{
                        $ton_charged_wt = substr($ton_char_wt,0,8)."..";
                    }
                }else{
                    $ton_charged_wt = '0'.space(9);
                }

                if($ton_quan){
                    if(strlen($ton_quan) < 8) {
                        $ton_quantity = $ton_quan.space(10-strlen($ton_quan));
                    }else{
                        $ton_quantity = substr($ton_quan,0,8)."..";
                    }
                }else{
                    $ton_quantity = '0'.space(9);
                }

                if(isset($data['summary']->tripInfo->busVehicle->registationNumber) && $data['summary']->tripInfo->busVehicle->registationNumber != 'false'){
                    $vehi_reg_no = $data['summary']->tripInfo->busVehicle->registationNumber;
                }elseif($data['summary']->transitVehicle->registationNumber != '' && $data['summary']->transitVehicle->registationNumber != 'false'){
                    $vehi_reg_no = $data['summary']->transitVehicle->registationNumber;
                }elseif($data['summary']->additionalAttribute->registerNumber != '' && $data['summary']->additionalAttribute->registerNumber != 'false'){
                    $vehi_reg_no = $data['summary']->additionalAttribute->registerNumber;
                }else{
                    $vehi_reg_no = "-";
                }

                // amount in words
                if(strlen(ucwords(amount_in_words($total_articles))) < 24) {
                    $atcle = ucwords(amount_in_words($total_articles)). " Only".space(34-strlen(ucwords(amount_in_words($total_articles))));
                    $atcle_in_words = str_replace("Rupees  ", "",$atcle);
                }else{
                    $atcle = substr(ucwords(amount_in_words($total_articles)),0,24)."..."."Only";
                    $atcle_in_words = str_replace("Rupees  ", "",$atcle);
                }

                if(strlen($total_articles) < 6) {
                    $atcle = $total_articles.space(7-strlen($total_articles));
                }else{
                    $atcle = $total_articles;
                }

                if($data['summary']->deliveryHandlingAmount != 0){
                    $del_at = 'DOOR DLY';
                }else{
                    $del_at = 'GODOWN';
                }

                if(strlen($data['summary']->toStation->name) < 30) {
                    $hire_up_to = $data['summary']->toStation->name.space(32-strlen($data['summary']->toStation->name));
                }else{
                    $hire_up_to = substr($data['summary']->toStation->name,0,30)."..";
                }

                $cmds = newline().newline(). space(66). $data['summary']->fromStation->shortCode;
                $cmds .= newline().newline().space(66). $data['cargoCode'];
                $cmds .= newline().newline().space(8). $from_customer.space(8).$to_customer.space(8). date('d/m/Y', strtotime($data['summary']->bookedAt));
                $cmds .= newline().space(3). $from_org.$to_org;
                $cmds .= newline().space(3). $customer_mob.space(4).$org_mob.space(11).$vehi_reg_no;
                $cmds .= newline().space(3). $from_gst.space(5).$to_gst.space(12). substr($data['summary']->fromOrganization->name, 0, 13);
                $cmds .= newline().newline().space(66). substr($data['summary']->toOrganization->name,0,15);
                $cmds .= newline().space(14).'HIRE UPTO - '.strtoupper($hire_up_to). space(8). $del_at;
                $cmds .= newline().newline().newline().newline();

                $ic = 0;
                foreach($data['summary']->itemDetails as $article){

                    if($ic > 5){ 
                        if($ic == 6){
                            $atcle_cnt = 0;
                        }
                        if(strlen($article->itemCount) < 6) {
                            $atcle_cnt += $article->itemCount.space(6-strlen($article->itemCount));
                        }else{
                            $atcle_cnt += $article->itemCount;
                        }
                    }else{
                        if(strlen($article->itemCount) < 6) {
                            $atcle_cnt = $article->itemCount.space(6-strlen($article->itemCount));
                        }else{
                            $atcle_cnt = $article->itemCount;
                        }
                    }

                    if(strlen($article->cargoItem->name) < 5) {
                        $atcle_name = $article->cargoItem->name.space(5-strlen($article->cargoItem->name));
                    }else{
                        $atcle_name = substr($article->cargoItem->name,0,5);
                    }

                    $cmds .= newline().space(1).$atcle_cnt.space(0);    
                    if(strlen($article->cargoItem->description[0]) < 23) {
                        if($ic == 0){
                            ${'cmds'.$ic} = $atcle_name.space(2).$article->cargoItem->description[0].space(25-strlen($article->cargoItem->description[0])). space(28).$frght.space(1).'.' .space(1).$freight_amt[1];
                        }elseif($ic == 1){
                            ${'cmds'.$ic} = $atcle_name.space(2).$article->cargoItem->description[0].space(25-strlen($article->cargoItem->description[0])). space(8).$ton_actual_wt.space(0).$ton_quantity.space(0).$door_collec.space(1).'.' .space(1).$door_col_amt[1];
                        }elseif($ic == 2){
                            ${'cmds'.$ic} = $atcle_name.space(2).$article->cargoItem->description[0].space(25-strlen($article->cargoItem->description[0])). space(28).$door_deli.space(1).'.' .space(1).$door_del_amt[1];
                        }elseif($ic == 3){
                            ${'cmds'.$ic} = $atcle_name.space(2).$article->cargoItem->description[0].space(25-strlen($article->cargoItem->description[0])). space(28).$hmli.space(1).'.' .space(1).$hamali_amt[1];
                        }elseif($ic == 4){
                            ${'cmds'.$ic} = $atcle_name.space(2).$article->cargoItem->description[0].space(25-strlen($article->cargoItem->description[0])). space(28).$c_gst_amt.space(1).'.' .space(1).$cgst_amt[1];
                        }elseif($ic == 5){
                            ${'cmds'.$ic} = $atcle_name.space(2).$article->cargoItem->description[0].space(25-strlen($article->cargoItem->description[0])). space(8).$ton_charged_wt.space(0).$ton_quantity.space(0).$s_gst_amt.space(1).'.' .space(1).$sgst_amt[1];
                        }
                        // elseif($ic == 6){
                        //     ${'cmds'.$ic} = $article->cargoItem->description[0].space(25-strlen($article->cargoItem->description[0])). space(28).$other_amt.space(1).'.' .space(1).$others_amt[1];
                        // }
                        else{
                            // ${'cmds'.$ic} = $article->cargoItem->description[0].space(25-strlen($article->cargoItem->description[0]));
                            ${'cmds'.$ic} = 'Others';
                        }
                    }else{
                        ${'cmds'.$ic} = $atcle_name.space(2).substr($article->cargoItem->description[0],0,23)."..";
                    } 

                    $cmds .= ${'cmds'.$ic};
                    if(count($data['summary']->itemDetails) == 1){
                        if($ic == count($data['summary']->itemDetails)-1){
                            $cmds .= newline().space(47).$ton_actual_wt.space(0).$ton_quantity.space(0).$door_collec.space(1).'.' .space(1).$door_col_amt[1];
                            $cmds .= newline().space(67).$door_deli.space(1).'.' .space(1).$door_del_amt[1];
                            $cmds .= newline().space(67).$hmli.space(1).'.' .space(1).$hamali_amt[1];
                            $cmds .= newline().space(67).$c_gst_amt.space(1).'.' .space(1).$cgst_amt[1];
                            $cmds .= newline().space(47).$ton_charged_wt.space(0).$ton_quantity.space(0).$s_gst_amt.space(1).'.' .space(1).$sgst_amt[1];

                            $cmds .=  newline().space(3) .$atcle.space(0) . "No. Of Items" . space(1) .$atcle_in_words. space(13) .$other_amt.space(1).'.' .space(1).$others_amt[1];
                            if(($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST == '')){    
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST == '') && ($data['summary']->toCustomerGST != '')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'PAD')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'TOP')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }else{
                                $cmds .= newline();
                            }
                        }
                    }

                    if(count($data['summary']->itemDetails) == 2){
                        if($ic == count($data['summary']->itemDetails)-1){
                            // $cmds .= newline().space(40).$ton_actual_wt.space(5).$ton_quantity.space(12).$door_collec.space(1).'.' .space(1).$door_col_amt[1];
                            $cmds .= newline().space(67).$door_deli.space(1).'.' .space(1).$door_del_amt[1];
                            $cmds .= newline().space(67).$hmli.space(1).'.' .space(1).$hamali_amt[1];
                            $cmds .= newline().space(67).$c_gst_amt.space(1).'.' .space(1).$cgst_amt[1];
                            $cmds .= newline().space(47).$ton_charged_wt.space(0).$ton_quantity.space(0).$s_gst_amt.space(1).'.' .space(1).$sgst_amt[1];

                            $cmds .=  newline().space(3) .$atcle.space(0) . "No. Of Items" . space(1) .$atcle_in_words . space(13) .$other_amt.space(1).'.' .space(1).$others_amt[1];
                            if(($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST == '')){    
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST == '') && ($data['summary']->toCustomerGST != '')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'PAD')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'TOP')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }else{
                                $cmds .= newline();
                            }
                        }
                    }

                    if(count($data['summary']->itemDetails) == 3){
                        if($ic == count($data['summary']->itemDetails)-1){
                            // $cmds .= newline().space(40).$ton_actual_wt.space(5).$ton_quantity.space(9).$door_collec.space(1).'.' .space(1).$door_col_amt[1];
                            // $cmds .= newline().space(56).$door_deli.space(1).'.' .space(1).$door_del_amt[1];
                            $cmds .= newline().space(67).$hmli.space(1).'.' .space(1).$hamali_amt[1];
                            $cmds .= newline().space(67).$c_gst_amt.space(1).'.' .space(1).$cgst_amt[1];
                            $cmds .= newline().space(47).$ton_charged_wt.space(0).$ton_quantity.space(0).$s_gst_amt.space(1).'.' .space(1).$sgst_amt[1];

                            $cmds .=  newline().space(3) .$atcle.space(0) . "No. Of Items" . space(1) .$atcle_in_words . space(13) .$other_amt.space(1).'.' .space(1).$others_amt[1];
                            if(($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST == '')){    
                                $cmds .= newline().space(2). "**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST == '') && ($data['summary']->toCustomerGST != '')){
                                $cmds .= newline().space(2). "**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'PAD')){
                                $cmds .= newline().space(2). "**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'TOP')){
                                $cmds .= newline().space(2). "**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }else{
                                $cmds .= newline();
                            }
                        }
                    }

                    if(count($data['summary']->itemDetails) == 4){
                        if($ic == count($data['summary']->itemDetails)-1){
                            // $cmds .= newline().space(40).$ton_actual_wt.space(5).$ton_quantity.space(9).$door_collec.space(1).'.' .space(1).$door_col_amt[1];
                            // $cmds .= newline().space(56).$door_deli.space(1).'.' .space(1).$door_del_amt[1];
                            // $cmds .= newline().space(56).$hmli.space(1).'.' .space(1).$hamali_amt[1];
                            $cmds .= newline().space(67).$c_gst_amt.space(1).'.' .space(1).$cgst_amt[1];
                            $cmds .= newline().space(47).$ton_charged_wt.space(0).$ton_quantity.space(0).$s_gst_amt.space(1).'.' .space(1).$sgst_amt[1];

                            $cmds .=  newline().space(3) .$atcle.space(0) . "No. Of Items" . space(1) .$atcle_in_words . space(13) .$other_amt.space(1).'.' .space(1).$others_amt[1];
                            if(($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST == '')){    
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST == '') && ($data['summary']->toCustomerGST != '')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'PAD')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'TOP')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }else{
                                $cmds .= newline();
                            }
                        }
                    }

                    if(count($data['summary']->itemDetails) == 5){
                        if($ic == count($data['summary']->itemDetails)-1){
                            // $cmds .= newline().space(40).$ton_actual_wt.space(5).$ton_quantity.space(9).$door_collec.space(1).'.' .space(1).$door_col_amt[1];
                            // $cmds .= newline().space(56).$door_deli.space(1).'.' .space(1).$door_del_amt[1];
                            // $cmds .= newline().space(56).$hmli.space(1).'.' .space(1).$hamali_amt[1];
                            // $cmds .= newline().space(40).$ton_charged_wt.space(5).$ton_quantity.space(9).$c_gst_amt.space(1).'.' .space(1).$cgst_amt[1];
                            $cmds .= newline().space(47).$ton_charged_wt.space(0).$ton_quantity.space(0).$s_gst_amt.space(1).'.' .space(1).$sgst_amt[1];

                            $cmds .=  newline().space(3) .$atcle.space(0) . "No. Of Items" . space(1) .$atcle_in_words . space(13) .$other_amt.space(1).'.' .space(1).$others_amt[1];
                            if(($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST == '')){    
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST == '') && ($data['summary']->toCustomerGST != '')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'PAD')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'TOP')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }else{
                                $cmds .= newline();
                            }
                        }
                    }

                    if(count($data['summary']->itemDetails) == 6){
                        if($ic == count($data['summary']->itemDetails)-1){
                            // $cmds .= newline().space(40).$ton_actual_wt.space(5).$ton_quantity.space(9).$door_collec.space(1).'.' .space(1).$door_col_amt[1];
                            // $cmds .= newline().space(56).$door_deli.space(1).'.' .space(1).$door_del_amt[1];
                            // $cmds .= newline().space(56).$hmli.space(1).'.' .space(1).$hamali_amt[1];
                            // $cmds .= newline().space(40).$ton_charged_wt.space(5).$ton_quantity.space(9).$c_gst_amt.space(1).'.' .space(1).$cgst_amt[1];
                            // $cmds .= newline().space(44).$ton_charged_wt.space(5).$ton_quantity.space(13).$s_gst_amt.space(1).'.' .space(1).$sgst_amt[1];

                            $cmds .=  newline().space(3) .$atcle.space(0) . "No. Of Items" . space(1) .$atcle_in_words . space(13) .$other_amt.space(1).'.' .space(1).$others_amt[1];
                            if(($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST == '')){    
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST == '') && ($data['summary']->toCustomerGST != '')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'PAD')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'TOP')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }else{
                                $cmds .= newline();
                            }
                        }
                    }

                    if(count($data['summary']->itemDetails) > 6){
                        if($ic == count($data['summary']->itemDetails)-1){
                            // $cmds .= newline().space(40).$ton_actual_wt.space(5).$ton_quantity.space(9).$door_collec.space(1).'.' .space(1).$door_col_amt[1];
                            // $cmds .= newline().space(56).$door_deli.space(1).'.' .space(1).$door_del_amt[1];
                            // $cmds .= newline().space(56).$hmli.space(1).'.' .space(1).$hamali_amt[1];
                            // $cmds .= newline().space(40).$ton_charged_wt.space(5).$ton_quantity.space(9).$c_gst_amt.space(1).'.' .space(1).$cgst_amt[1];

                            $cmds .=  newline().space(3) .$atcle.space(0) . "No. Of Items" . space(1) .$atcle_in_words . space(13) .$other_amt.space(1).'.' .space(1).$others_amt[1];
                            if(($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST == '')){    
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST == '') && ($data['summary']->toCustomerGST != '')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'PAD')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNOR **";
                            }elseif (($data['summary']->fromCustomerGST != '') && ($data['summary']->toCustomerGST != '') && ($data['summary']->paymentType->code == 'TOP')){
                                $cmds .= newline(). space(2) ."**  GST / RCM PAYABLE BY CONSIGNEE **";
                            }else{
                                $cmds .= newline();
                            }
                        }
                    }
                    $ic ++;
                }

                if($data['summary']->invoiceDate){
                    $inv_date = date('d/m/Y', strtotime($data['summary']->invoiceDate));
                }else{
                    $inv_date = '-'.space(8);
                }
                

                if($data['summary']->invoiceNumber){
                    if(strlen($data['summary']->invoiceNumber) < 16) {
                        $inv_num = $data['summary']->invoiceNumber.space(16-strlen($data['summary']->invoiceNumber));
                    }else{
                        // $inv_num = '123456789012345';
                        $inv_num = $data['summary']->invoiceNumber;
                    }
                }else{
                    $inv_num = '-'.space(15);
                    // $inv_num = '123456789012345';
                }
                
                if(strlen(inr_format($data['summary']->invoiceAmount)) < 8) {
                    $inv_amt = inr_format($data['summary']->invoiceAmount).space(9-strlen(inr_format($data['summary']->invoiceAmount)));
                }else{
                    $inv_amt = inr_format($data['summary']->invoiceAmount);
                }

                if(strlen($data['summary']->paymentType->name) < 7) {
                    $pay_type = $data['summary']->paymentType->name.space(7-strlen($data['summary']->paymentType->name));
                }else{
                    $pay_type = substr($data['summary']->paymentType->name,0,7);
                }

                $cmds .= newline().newline().space(19).$inv_num.space(0).$inv_date.space(4).$ton_frght[0].space(1).'.' .space(1).$ton_frght[1];
                $cmds .= newline().newline().space(20).$inv_amt.space(16).$pay_type.space(12).$total_amt.space(1).'.' .space(1).$total[1];

                $grand_total = ucwords(amount_in_words($tot));
                $cmds .= newline().newline().space(5).$grand_total." Only";
                $cmds .= " \f"; 

                
                ob_clean();
                echo $cmds;

                //$pdf->Write(0, $cmds);

                //$pdf->Output('cargo-summary.pdf', 'i'); 
                
            } else if( in_array($this->session->userdata('namespace_id'), ["cargodemo","rathimeenaparcel"]) ){ 
                // NEW FORMAT   
                // Rathimeena format for testing, Pre-Printed sheet, 8 X 4 Inch, inner body with open area.
                // TVS MSP 250 STAR, Font Size : 10 CPI.
                
                $fright = 0;
                $itemnames = '';
                foreach ($data['summary']->itemDetails as $article) {
                    $fright += (($article->itemCount * $article->fare) + $article->handlingChargeAmount);
                    $itemnames .= $article->cargoItem->name . '(' . $article->itemCount . '),';
                }

                $itemnames = strtoupper($itemnames);

                $lr   = "LR No : ".$data['cargoCode'];
                $date = "Date : ".date('d-m-Y h:i A', strtotime($data['summary']->bookedAt));
                $fb   = "From : ".strtoupper($data['summary']->fromOrganization->name).' - '.$data['summary']->fromOrganization->shortCode;
                $tb   = "To   : ".strtoupper($data['summary']->toOrganization->name).' - '.$data['summary']->toOrganization->shortCode;

                $fc = strtoupper($data['summary']->fromCustomer->name).', '.$data['summary']->fromCustomer->mobileNumber;
                $tc = strtoupper($data['summary']->toCustomer->name).' , '.$data['summary']->toCustomer->mobileNumber;

                $fr = $data['summary']->totalAmount;
                $lding = $data['summary']->totalHandlingAmount;
                
                $diff = $data['summary']->serviceTax - $data['tax_computed']->cgstValue - $data['tax_computed']->sgstValue - $data['tax_computed']->igstValue;
                $roundoff = $data['addons_mapped']['RNDF']->value + $diff;
                $ptype = strtoupper($data['payment_type_name']);

                $total = $data['summary']->totalAmount+$data['summary']->totalHandlingAmount+$data['summary']->totalUnloadHandlingAmount+$data['summary']->pickupHandlingAmount+$data['summary']->deliveryHandlingAmount+$data['summary']->serviceCharge+$data['summary']->serviceTax+$data['summary']->hamaliCharge+$data['summary']->passCharge+$data['summary']->docketCharge + $data['addons_mapped']['RNDF']->value + $data['addons_mapped']['PODCH']->value + $data['addons_mapped']['DMRCH']->value + $data['addons_mapped']['INSUR']->value + $data['addons_mapped']['ADJSMT']->value;
                
                $cmds = "\033C\000\004".newline().newline().space(0). $lr .space( 25-0-strlen($lr) ). $date . space(5) ."\016". $ptype;
                $cmds .= newline().space(0). $fb .space(35-0-strlen($fb)). $tb;
                $cmds .= newline().newline().space(0). "CONSIGNER :" .space(30-0-11). "CONSIGNEE : ";
                $cmds .= newline().space(0). $fc .space(30-0-strlen($fc)). $tc;
                $cmds .= newline().newline().space(0). " ITMES : " .$itemnames;
                $cmds .= newline().space(35)."Freight         : ".$fr;
                $cmds .= newline().space(35)."Loading Charges : ".$lding;

                if ($data['tax_computed']->igstValue == 0) {
                    $cmds .= newline().space(35)."CGST : ".$data['tax_computed']->cgstValue.", SGST : ".$data['tax_computed']->sgstValue;
                } else {
                    $cmds .= newline().space(35)."IGST             : ".$data['tax_computed']->igstValue;
                }

                $cmds .= newline().space(35)."Round off       : ".$roundoff;
                $cmds .= newline().space(35)."\016"."Total : ". $total;
                $cmds .= " \f"; 
                
                ob_clean();
                echo $cmds;

            } else if( in_array($this->session->userdata('namespace_id'), ["kmstravels"])){
                $freight = 0;
                $quantity = 0;
                $loading_charge = 0;
                $unloading_charge = 0;
                $gst = 0;
                $cgst = 0;
                $sgst = 0;
                $others = 0;

                $lr_charge = 0;
                $door_col = 0;
                $tot = 0;
                $pickup_ch = 0;
                $del_ch = 0;
                
                foreach ($data['summary']->itemDetails as $article) {
                    $freight += ($article->fare * $article->itemCount);
                    $quantity += $article->itemCount;

                    $loading_charge += $article->handlingChargeAmount;
                    $unloading_charge += $article->unloadingChargeAmount;
                    $gst += $article->serviceTax;
                    $cgst += $article->tax->cgstValue;
                    $sgst += $article->tax->sgstValue;

                    $total_articles += $article->itemCount;
                }
                
                $lr_charge += $data['summary']->docketCharge;
                $pickup_ch += $data['summary']->pickupHandlingAmount;
                $del_ch += $data['summary']->deliveryHandlingAmount;
                $others += $data['summary']->serviceCharge + $data['summary']->docketCharge + $data['summary']->passCharge;
                $tot += $freight+$data['summary']->totalHandlingAmount+$data['summary']->totalUnloadHandlingAmount+$data['summary']->pickupHandlingAmount+$data['summary']->deliveryHandlingAmount+$data['summary']->serviceCharge+$data['summary']->serviceTax+$data['summary']->hamaliCharge+$data['summary']->passCharge+$data['summary']->docketCharge + $data['addons_mapped']['PODCH']->value+ $data['addons_mapped']['DMRCH']->value + $data['addons_mapped']['RNDF']->value;
                // if($data['summary']->deliveryHandlingAmount != 0){
                //     $del_at = 'DOOR DLY';
                // }else{
                //     $del_at = 'GODOWN';
                // }

                $lr = substr($data['cargoCode'], 0, 10);
                $bookedAt = substr(date('d/m/Y', strtotime($data['summary']->bookedAt)), 0, 10);

                $from_org = substr($data['summary']->fromOrganization->name, 0, 30);
                $to_org = substr($data['summary']->toOrganization->name, 0, 30);

                $from_customer = substr($data['summary']->fromCustomer->name, 0, 30);
                $from_customer_mob = substr($data['summary']->fromCustomer->mobileNumber, 0, 10);
                $from_customer_gst = substr($data['summary']->fromCustomerGST, 0, 16);

                $to_customer = substr($data['summary']->toCustomer->name, 0, 30);
                $to_customer_mob = substr($data['summary']->toCustomer->mobileNumber, 0, 10);
                $to_customer_gst = substr($data['summary']->toCustomerGST, 0, 16);
                
                $from_cus_add = substr($data['summary']->fromCustomerAddress->address1, 0, 33);
                $from_cus_land = substr($data['summary']->fromCustomerAddress->landmark, 0, 20);
                $from_cus_pin = substr($data['summary']->fromCustomerAddress->pincode, 0, 7);

                $to_cus_add = substr($data['summary']->toCustomerAddress->address1, 0, 32);
                $to_cus_land = substr($data['summary']->toCustomerAddress->landmark, 0, 20);
                $to_cus_pin = substr($data['summary']->toCustomerAddress->pincode, 0, 7);
                $inv_num = substr($data['summary']->invoiceNumber, 0, 15);

                $frght = substr($freight, 0, 10);
                $pickup_charge = substr($pickup_ch, 0, 10);
                $del_charge = substr($del_ch, 0, 10);
                $load = substr($loading_charge, 0, 10);
                $unload = substr($unloading_charge, 0, 10);
                $lr_ch = substr($lr_charge, 0, 10);
                $c_gst = substr($cgst, 0, 10);
                $s_gst = substr($sgst, 0, 10);
                $total = substr($tot, 0, 10);

                $cmds = newline().space(62). $lr . space(13-0-strlen($lr));
                $cmds .= newline().newline().space(62). $bookedAt .space(13-0-strlen($bookedAt));
                $cmds .= newline().newline().newline().newline().space(12). $from_org .space(27-0-strlen($from_org)).space(8). $to_org.space(28-0-strlen($to_org));
                $cmds .= newline().space(12). $from_customer .space(27-0-strlen($from_customer)).space(8). $to_customer.space(28-0-strlen($to_customer));
                if($from_cus_add || $to_cus_add){
                    $cmds .= newline().space(5). $from_cus_add .space(30-0-strlen($from_cus_add)).space(7). $to_cus_add .space(30-0-strlen($to_cus_add)).space(3);
                }
                if($from_cus_land || $from_cus_pin || $to_cus_land || $to_cus_pin){
                    $cmds .= newline().space(5). $from_cus_land .space(20-0-strlen($from_cus_land)).', '.$from_cus_pin .space(7-0-strlen($from_cus_pin)).space(8).$to_cus_land.space(20-0-strlen($to_cus_land)).', '.$to_cus_pin .space(7-0-strlen($to_cus_pin)).space(4);
                }

                $cmds .= newline().space(5).$from_customer_mob .space(10-0-strlen($from_customer_mob)).', GST:'.$from_customer_gst .space(16-0-strlen($from_customer_gst)).space(6).$to_customer_mob .space(10-0-strlen($to_customer_mob)).', GST:'.$to_customer_gst .space(16-0-strlen($to_customer_gst)).space(0);
                // $cmds .= newline().space(5).'Mobile No : '. $from_customer_mob .space(12-0-strlen($from_customer_mob)).space(13).'Mobile No : '. $to_customer_mob .space(12-0-strlen($to_customer_mob)).space(9);
                // $cmds .= newline().space(5).'GST No : '. $from_customer_gst .space(20-0-strlen($from_customer_gst)).space(8).'GST No : '. $to_customer_gst .space(20-0-strlen($to_customer_gst)).space(4);
                
                if(!$from_cus_add && !$to_cus_add){
                    $cmds .= newline();
                }

                if(!$from_cus_land && !$from_cus_pin && !$to_cus_land && !$to_cus_pin){
                    $cmds .= newline();
                }

                $cmds .= newline().newline().newline().space(18). $inv_num . space(20-0-strlen($inv_num)).space(27).$frght.space(10-0-strlen($frght));
                
                $ic = 0;
                $abv_attc_cnt = 0;
                $abv_act_wt = 0;
                foreach($data['summary']->itemDetails as $article){

                    if($ic >= 3){ 
                            $abv_attc_cnt += $article->itemCount;
                            $abv_act_wt += $article->unitValue;
                    }else{
                            $atcle_cnt = $article->itemCount;
                        $cmds .= newline().space(3).$atcle_cnt.space(7-0-strlen($atcle_cnt));   
                    }

                    $desc = substr($article->cargoItem->description[0], 0, 25);
                    $name = substr($article->cargoItem->name, 0, 10);
                    $actual_weight = substr($article->unitValue, 0, 7);
                    
                        if($ic == 0){
                            ${'cmds'.$ic} = $desc.space(25-strlen($desc)).$name.space(10-0-strlen($name)).space(2).$actual_weight.space(7-0-strlen($actual_weight)). space(5);
                            // ${'cmds'.$ic} .= newline().space(65).$pickup_charge;
                        }elseif($ic == 1){
                            ${'cmds'.$ic} = $desc.space(25-strlen($desc)).$name.space(10-0-strlen($name)).space(2).$actual_weight.space(7-0-strlen($actual_weight)). space(11).$pickup_charge;
                            // ${'cmds'.$ic} .= newline().space(65).$del_charge;
                        }elseif($ic == 2){
                            ${'cmds'.$ic} = $desc.space(25-strlen($desc)).$name.space(10-0-strlen($name)).space(2).$actual_weight.space(7-0-strlen($actual_weight)). space(11);
                            // ${'cmds'.$ic} .= newline().space(65).$load;
                        }

                    if($ic < 3){
                        $cmds .= ${'cmds'.$ic};
                    }
                    $ic ++;
                }

                $pay_type = substr($data['summary']->paymentType->name,0,13);
                
                if(count($data['summary']->itemDetails) == 1){
                    $cmds .= newline().space(60). space(5).$pickup_charge;
                    $cmds .= newline().newline().space(60). space(5).$del_charge;
                    $cmds .= newline().newline().space(60). space(5).$load;
                    $cmds .= newline().space(60). space(5).$unload;
                    $cmds .= newline().space(60). space(5).$lr_ch;
                    $cmds .= newline().newline().space(60). space(5).$c_gst;
                    $cmds .= newline().newline().space(60). space(5).$s_gst;
                    $cmds .= newline().newline().space(60). space(5).$total;
                    $cmds .= newline().newline().newline().newline().space(64). strtoupper($pay_type);
                }elseif(count($data['summary']->itemDetails) == 2){
                    $cmds .= newline().newline().space(60). space(5).$del_charge;
                    $cmds .= newline().newline().space(60). space(5).$load;
                    $cmds .= newline().space(60). space(5).$unload;
                    $cmds .= newline().space(60). space(5).$lr_ch;
                    $cmds .= newline().newline().space(60). space(5).$c_gst;
                    $cmds .= newline().newline().space(60). space(5).$s_gst;
                    $cmds .= newline().newline().space(60). space(5).$total;
                    $cmds .= newline().newline().newline().newline().space(64). strtoupper($pay_type);
                }elseif(count($data['summary']->itemDetails) == 3){
                    $cmds .= newline().space(60). space(5).$del_charge;
                    $cmds .= newline().newline().space(60). space(5).$load;
                    $cmds .= newline().space(60). space(5).$unload;
                    $cmds .= newline().space(60). space(5).$lr_ch;
                    $cmds .= newline().newline().space(60). space(5).$c_gst;
                    $cmds .= newline().newline().space(60). space(5).$s_gst;
                    $cmds .= newline().newline().space(60). space(5).$total;
                    $cmds .= newline().newline().newline().newline().space(64). strtoupper($pay_type);
                }elseif(count($data['summary']->itemDetails) > 3){
                    $cmds .= newline().space(3).$abv_attc_cnt.space(7-0-strlen($abv_attc_cnt)).'others'.space(31).$abv_act_wt.space(5-0-strlen($abv_act_wt)).space(13).$del_charge;
                    $cmds .= newline().newline().space(60). space(5).$load;
                    $cmds .= newline().space(60). space(5).$unload;
                    $cmds .= newline().space(60). space(5).$lr_ch;
                    $cmds .= newline().newline().space(60). space(5).$c_gst;
                    $cmds .= newline().newline().space(60). space(5).$s_gst;
                    $cmds .= newline().newline().space(60). space(5).$total;
                    $cmds .= newline().newline().newline().newline().space(64). strtoupper($pay_type);
                }
                
                $cmds .= " \f"; 
                
                ob_clean();
                echo $cmds;

            } else if (in_array($this->session->userdata('namespace_id'), ["citycargo","cityparcel"])) {
                // NEW FORMAT   
                // City Travels format for testing, Pre-Printed sheet, 10 X 6 Inch, inner body with pre printed area.
                // TVS MSP 250 STAR, Font Size : 10 CPI, Font : Draft

                $cargo_payment_status = $this->config->item('cargo_payment_status');
                $print_type = $this->input->get('printType');

                $lr = $data['cargoCode'];
                $bookedAt = date('d/m/Y', strtotime($data['summary']->bookedAt));
                $payment_type = substr($cargo_payment_status[$data['summary']->paymentType->code], 0, 5);

                $from_org = substr($data['summary']->fromOrganization->name, 0, 30);
                $to_org = substr($data['summary']->toOrganization->name, 0, 26);

                $from_customer = substr($data['summary']->fromCustomer->name, 0, 30);
                $to_customer = substr($data['summary']->toCustomer->name, 0, 26);

                $no_of_articles = 0;
                $weight = 0;
                $arts ='';
                foreach ($data['summary']->itemDetails as $article) {
                    $no_of_articles += $article->itemCount;
                    $arts = $article->cargoItem->name;
                    $weight += $article->unitValue;
                }
                $remarks = substr($data['summary']->remarks[0]->name, 0, 27);
                $current_time = date("H:i:s", time());
                $net_amount = $data['summary']->totalAmount+$data['summary']->totalHandlingAmount+$data['summary']->totalUnloadHandlingAmount+$data['summary']->pickupHandlingAmount+$data['summary']->deliveryHandlingAmount+$data['summary']->serviceCharge+$data['summary']->serviceTax+$data['summary']->hamaliCharge+$data['summary']->passCharge+$data['summary']->docketCharge + $data['addons_mapped']['PODCH']->value + $data['addons_mapped']['DMRCH']->value + $data['addons_mapped']['RNDF']->value + $data['addons_mapped']['INSUR']->value + $data['addons_mapped']['ADJSMT']->value + $data['addons_mapped']['MCNHCH']->value + $data['addons_mapped']['FOVCH']->value+$data['addons_mapped']['CNCTCH']->value;
                
                $gst_amount = $data['summary']->serviceTax;
                $docket_amount = $data['summary']->docketCharge;
                $roundoff_amount = $data['addons_mapped']['RNDF']->value;
                $connectingCharges = $data['addons_mapped']['CNCTCH']->value;

                $payment_mode = substr($data['summary']->cargoTransactionList[0]->transactionMode->name, 0, 5);

                if(!empty($payment_mode)) {
                    $payment_mode = " - ".$payment_mode;
                }

                $printtype = 'DUPLICATE';
                if ($print_type == 1) {
                    $printtype = 'ORIGINAL';
                }

                if ($data['summary']->paymentAmount > 0 && strlen(ucwords(amount_in_words($data['summary']->paymentAmount))) < 50) {
                    $amount_paid = ucwords(amount_in_words($data['summary']->paymentAmount)). " Only".space(50-strlen(ucwords(amount_in_words($data['summary']->paymentAmount))));
                    $amount_paid_in_words = str_replace("Rupees  ", "",$amount_paid);
                } elseif ($data['summary']->paymentAmount > 0) {
                    $amount_paid = substr(ucwords(amount_in_words($data['summary']->paymentAmount)),0,50)."..."."Only";
                    $amount_paid_in_words = str_replace("Rupees  ", "",$amount_paid);
                } else {
                    $amount_paid_in_words = 'Zero Only';
                }

                if (isNotNull($data['summary']->toCustomerAddress->code) && ($data['summary']->deliveryType->code == 'DYDO' || $data['summary']->deliveryType->code == 'PDDO')) {
                    $to_name = ucwords(strtolower($data['summary']->toCustomer->name));
                    $delivery_office_address = substr($to_name, 0, 15) . space(20-0-strlen($to_name)) .$printtype. newline();
                    if (isNotNull($data['summary']->toCustomerAddress->address1) || isNotNull($data['summary']->toCustomerAddress->address2)) {
                        $delivery_office_address .= substr($data['summary']->toCustomerAddress->address1, 0, 20) . ',' . substr($data['summary']->toCustomerAddress->address2, 0, 20) . ',' . substr($data['summary']->toCustomerAddress->landmark, 0, 10) . ',' . substr($data['summary']->toCustomerAddress->station->name, 0, 10) . ',' . $data['summary']->toCustomerAddress->pincode . newline();
                    }
                    $delivery_office_address .= $data['summary']->toCustomer->mobileNumber;
                } else {
                    $to_name = ucwords(strtolower($data['summary']->toOrganization->name));
                    $delivery_office_address = substr($to_name, 0, 15) . space(20-0-strlen($to_name)) .$printtype . newline();
                    if (isNotNull($data['summary']->toOrganization->address1) || isNotNull($data['summary']->toCustomerAddress->address2)) {
                        $delivery_office_address .= $data['summary']->toOrganization->address1 . ',';
                    }
                    if (isNotNull($data['summary']->toOrganization->address2) || isNotNull($data['summary']->toCustomerAddress->address2)) {
                        $delivery_office_address .= $data['summary']->toOrganization->address2;
                    }
                    $delivery_office_address .= newline() . $data['summary']->toOrganization->contact;
                }

                // 033C - buffer clear, 006 - 0 th position and 6inch (paper size)
                $cmds = "\033C\000\006".newline().newline().newline().newline().newline();
                $cmds .= space(3).$from_org.space(25-0-strlen($from_org)).substr($to_org,0,15);
                $cmds .= newline().newline().space(3).$from_customer.space(25-0-strlen($from_customer)).$to_customer;
                $cmds .= newline().newline().space(3).$lr.space(25-0-strlen($lr)).$bookedAt;
                $cmds .= newline().newline().space(3).$arts.space(20-0-strlen($arts)). "Freight : ".$data['summary']->totalAmount.space(3-0-strlen($data['summary']->totalAmount)). $payment_type;
                $cmds .= newline().space(3).space(1).space(20-0-strlen($weight))."GST     : ".$gst_amount;
                $cmds .= newline().space(3).$no_of_articles.space(20-0-strlen($no_of_articles))."Docket  : ".$docket_amount;
                // $cmds .= newline().space(23)."R. Off  : ".$roundoff_amount;
                $cmds .= newline().space(23)."Con.. Ch: ".$connectingCharges;
                $cmds .= newline().newline().space(6).space(30).$data['summary']->totalHandlingAmount;
                $cmds .= newline().newline().space(3).$remarks.space(30-0-strlen($remarks)). $net_amount . $payment_mode;
                $cmds .= newline().newline().space(3).$current_time.space(30-0-strlen($current_time))."\016".$data['summary']->paymentAmount;
                $cmds .= newline().newline().space(2).wordwrap($amount_paid_in_words,40,"\n");
                $cmds .= newline().newline().space(15).trim(wordwrap($delivery_office_address,30,"\n"));
                $cmds .= "\f"; 
                ob_end_clean();
                echo trim($cmds);
            }  /* else if( in_array($this->session->userdata('namespace_id'), ["rmtcargo","rathimeenaparcel"]) ){    
                // Rathimeena format for testing, Pre-Printed sheet, 8 X 4 Inch, inner body with detailed sepration.
                // TVS MSP 250 START, Font Size : 10 CPI.                
                $fright = 0;
                $itemnames = '';
                foreach ($data['summary']->itemDetails as $article) {
                    $fright += (($article->itemCount * $article->fare) + $article->handlingChargeAmount);
                    $itemnames .= $article->cargoItem->name . '(' . $article->itemCount . '),';
                }

                $itemnames = strtoupper($itemnames);

                $lr = $data['cargoCode'];
                $date = date('d-m-Y h:i A', strtotime($data['summary']->bookedAt));
                $fb = strtoupper($data['summary']->fromOrganization->name).' - '.$data['summary']->fromOrganization->shortCode;
                $tb = strtoupper($data['summary']->toOrganization->name).' - '.$data['summary']->toOrganization->shortCode;

                $fc = strtoupper($data['summary']->fromCustomer->name).', '.$data['summary']->fromCustomer->mobileNumber;
                $tc = strtoupper($data['summary']->toCustomer->name).' - '.$data['summary']->toCustomer->mobileNumber;

                $fr = $data['summary']->totalAmount;
                $lding = $data['summary']->totalHandlingAmount;
                $ptype = strtoupper($data['payment_type_name']);

                $total = $data['summary']->totalAmount+$data['summary']->totalHandlingAmount+$data['summary']->totalUnloadHandlingAmount+$data['summary']->pickupHandlingAmount+$data['summary']->deliveryHandlingAmount+$data['summary']->serviceCharge+$data['summary']->serviceTax+$data['summary']->hamaliCharge+$data['summary']->passCharge+$data['summary']->docketCharge + $data['addons_mapped']['PODCH']->value;
                
                $cmds = "\033C\000\004".newline().newline().space(15). $lr .space( 40-15-strlen($lr) ). $date;
                $cmds .= newline().space(5). $fb .space(40-5-strlen($fb)). $tb;
                $cmds .= newline().newline().newline().space(10). $fc .space(40-10-strlen($fc)). $tc;
                $cmds .= newline().newline().space(20). $itemnames;
                $cmds .= newline().space(40). "Freight         : ".$fr;
                $cmds .= newline().space(40)."Loading Charges : ".$lding;
                $cmds .= newline().space(20). $ptype . space(48-20-strlen($ptype)). "Total   : ". $total;
                $cmds .= "\f"; 
                
                ob_clean();
                echo $cmds;
                
            }*/  
        } else if ($this->input->get('type') == 'grid') { // Muthumari using this
            require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
            $pdf = new TCPDF();
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('times', '', 8);
            $pdf->AddPage();

            ob_clean();
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/summary-grid-pdf', $data, true);

            $pdf->writeHTML($content);

            // set style for barcode
            $style = array(
                'border' => 2,
                'vpadding' => 'auto',
                'hpadding' => 'auto',
                'fgcolor' => array(0, 0, 0),
                'bgcolor' => false, //array(255,255,255)
                'module_width' => 1, // width of a single module in points
                'module_height' => 1 // height of a single module in points
            );
            $pdf->SetFont('times', '', 30);
            // $pdf->Text(120, 95, strtoupper($data['payment_type_name']), false, false, true, 0, 0, '', false, '', 0, false, 'T', 'M', false);
            // $pdf->Text(20, 95, strtoupper($data['payment_type_name']), false, false, true, 0, 0, '', false, '', 0, false, 'T', 'M', false);

            $pdf->Output('cargo-summary.pdf', "i");
        } else if($this->input->get('type') == '') { // Laser

            if ($this->input->get('count') == 3) {
                require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
                $pdf = new TCPDF();
                $pdf->setPrintHeader(false);
                $pdf->setPrintFooter(false);
                $pdf->SetFont('times', '', 8);
                $pdf->AddFont('helvetica');

                if($this->session->userdata('namespace_id') == "rajeshcargo" || $this->session->userdata('namespace_id') == "rajeshexpress") {
                    $pdf->SetFont('helvetica', '', 6);
                    // $fontname = TCPDF_FONTS::addTTFfont(FCPATH . '/assets/css/fonts/fontawesome-webfont.ttf', 'TrueTypeUnicode', '', 96);
                    // $pdf->AddFont($fontname, 'TrueTypeUnicode', 6);

                    $pdf->SetMargins(10, 0, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();

                    ob_clean();
                    $this->load->exclude_template();
                    $cargo_setting = _get_cargo_settings();
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-rajeshv2', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->setPage(1);
                    $pdf->SetAlpha(0.15);
                    $pdf->Rotate(20, 100, 100);
                    $pdf->SetFontSize(40);
                    $pdf->Text(50, 65, "Transporter's Copy");
                    if (count($data['terms_list'])) {
                        $pdf->Text(15, 200, "Customer's Copy");
                    } else {
                        $pdf->Text(20, 160, "Customer's Copy");
                    }
                    $pdf->Rotate(0);
                    $pdf->SetAlpha(1);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "skscargo") {
                    $pdf->SetFont('times', '', 10);
                    $pdf->SetMargins(8, 0, 8, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage('P', 'LEGAL');

                    ob_clean();
                    $this->load->exclude_template();
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-skscargo', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "vijayalakshmi") {
                    $pdf->SetFont('times', '', 8);
                    $pdf->SetMargins(8, 0, 8, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage('P', 'LEGAL');

                    ob_clean();
                    $this->load->exclude_template();
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-vijayalakshmi', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == 'sbrscargo') {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();
                    ob_clean();

                    $this->load->exclude_template();
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-sbrscargo', $data, true);
                    $pdf->writeHTML($content);
                    
                    $cargo_payment_status = $this->config->item('cargo_payment_status');
                    $paymentType = strtoupper($data['payment_type_name']);

                    $pdf->SetXY(10, 0);
                    $pdf->SetAlpha(0.15);
                    $pdf->SetFontSize(45);
                    $pdf->Cell(0, 95, $paymentType, 0, 1, 'C', 0, '', 1);
                    $pdf->Cell(0, 106, $paymentType, 0, 1, 'C', 0, '', 1);
                    $pdf->Cell(0, 95, $paymentType, 0, 1, 'C', 0, '', 1);
                    $pdf->SetFontSize(6);
                    $pdf->SetAlpha(1);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }
                
                if($this->session->userdata('namespace_id') == 'pkrsps') {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();
                    ob_clean();

                    $this->load->exclude_template();
                    $data['no_of_copy'] = 3;
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-pkrsps', $data, true);
                    $pdf->writeHTML($content);
                    
                    $cargo_payment_status = $this->config->item('cargo_payment_status');
                    $paymentType = strtoupper($data['payment_type_name']);

                    $pdf->SetXY(10, 0);
                    $pdf->SetAlpha(0.15);
                    $pdf->SetFontSize(45);
                    $pdf->Cell(0, 95, $paymentType, 0, 1, 'C', 0, '', 1);
                    $pdf->Cell(0, 106, $paymentType, 0, 1, 'C', 0, '', 1);
                    $pdf->Cell(0, 95, $paymentType, 0, 1, 'C', 0, '', 1);
                    $pdf->SetFontSize(6);
                    $pdf->SetAlpha(1);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }
                if($this->session->userdata('namespace_id') == 'chakratravels') {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();
                    ob_clean();

                    $this->load->exclude_template();
                    $data['no_of_copy'] = 3;
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-chakratravels', $data, true);
                    $pdf->writeHTML($content);
                    
                    $cargo_payment_status = $this->config->item('cargo_payment_status');
                    $paymentType = strtoupper($data['payment_type_name']);

                    $pdf->SetXY(10, 0);
                    $pdf->SetAlpha(0.15);
                    $pdf->SetFontSize(45);
                    $pdf->Cell(0, 95, $paymentType, 0, 1, 'C', 0, '', 1);
                    $pdf->Cell(0, 106, $paymentType, 0, 1, 'C', 0, '', 1);
                    $pdf->Cell(0, 95, $paymentType, 0, 1, 'C', 0, '', 1);
                    $pdf->SetFontSize(6);
                    $pdf->SetAlpha(1);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                // madhuraja
                if ($this->session->userdata('namespace_id') == 'madhuraja') {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();
                    ob_clean();

                    $this->load->exclude_template();
                    $data['no_of_copy'] = 3;
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-madhuraja', $data, true);
                    $pdf->writeHTML($content);

                    $cargo_payment_status = $this->config->item('cargo_payment_status');
                    $paymentType = strtoupper($data['payment_type_name']);

                    $pdf->SetXY(10, 0);
                    $pdf->SetAlpha(0.15);
                    $pdf->SetFontSize(45);
                    $pdf->Cell(0, 95, $paymentType, 0, 1, 'C', 0, '', 1);
                    $pdf->Cell(0, 106, $paymentType, 0, 1, 'C', 0, '', 1);
                    $pdf->Cell(0, 95, $paymentType, 0, 1, 'C', 0, '', 1);
                    $pdf->SetFontSize(6);
                    $pdf->SetAlpha(1);

                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == 'sriannamalaiyar') {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();
                    ob_clean();

                    $this->load->exclude_template();
                    $data['no_of_copy'] = 2;
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-annamalaiyar', $data, true);
                    $pdf->writeHTML($content);
                                        
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == 'jasminparcel') {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();
                    ob_clean();

                    $this->load->exclude_template();
                    $data['no_of_copy'] = 2;
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-jasminparcel', $data, true);
                    $pdf->writeHTML($content);
                                        
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == 'kkexpress') {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();
                    ob_clean();

                    $this->load->exclude_template();
                    $data['no_of_copy'] = 3;
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-kkexpress', $data, true);
                    $pdf->writeHTML($content);
                                        
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "varahi") {
                        
                    $organization = $this->api_model->getOrganization();
                    $organization = json_decode($organization);
                    $organizations = $organization->data;

                    $stateCode = '';
                    foreach ($organizations as $row) {
                        if ($data['summary']->fromOrganization->code == $row->code) {
                            $state[$row->station->state->code] = true;
                            $stateCode = $row->station->state->code;
                        }
                    }
                    
                    //gstno used get state 
                    $gstinCode='';
                    if($summary->data->paymentType->code =="PAD" || $summary->data->paymentType->code=="INP"){
                        $gstinCode =$summary->data->fromCustomerGST;
                    }else if($summary->data->paymentType->code =="TOP" || $summary->data->paymentType->code =="OATP" || $summary->data->paymentType->code =="TPPAD"){
                        $gstinCode = $summary->data->toCustomerGST;
                    }

                    $gstin = [
                        'gstin'=> $gstinCode?$gstinCode:$summary->data->fromCustomerGST,
                    ]; 

                    $getGst = $this->api_model->getGSTDetailsApi($gstin);
                    $getGst = json_decode($getGst);
                    $getGst = $getGst->data;
                    $Gststate = $getGst->state->code;

                    $data['gstState'] = $Gststate;
                    $data['stateCode'] = $stateCode;

                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 1, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage('P', 'A4');

                    ob_clean();
                    $this->load->exclude_template();
                    $data['status'] = config_item('cargo_payment_status');
                    $data['cargo_setting'] = _get_cargo_settings();
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-varahi', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "ternex") {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 1, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage('P', 'A4');

                    ob_clean();
                    $this->load->exclude_template();
                    $data['status'] = config_item('cargo_payment_status');
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-ternex', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "ktwoklogistics") {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 1, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage('P', 'A4');

                    ob_clean();
                    $this->load->exclude_template();
                    $data['status'] = config_item('cargo_payment_status');
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-ktwoklogistics', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "saitransports") {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 1, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage('P', 'A4');

                    ob_clean();
                    $this->load->exclude_template();
                    $data['status'] = config_item('cargo_payment_status');
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-saitransports', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "abexpress") {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 1, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage('P', 'A4');

                    ob_clean();
                    $this->load->exclude_template();
                    $data['status'] = config_item('cargo_payment_status');
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-abexpress', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }
                
                if(in_array($this->session->userdata('namespace_id'), ["kntlogistics","knttransports"])) {
                    $pdf->SetFont('helvetica', '', 7);
                    $pdf->SetMargins(4, 1, 5, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();

                    ob_clean();
                    $this->load->exclude_template();
                    $data['article_unit'] = $this->config->item('article_unit');
                    $data['ns'] = $this->session->userdata('namespace_id');
                    
                    if ($this->session->userdata('namespace_id') == 'kntlogistics') {
                        $upi = 'KNTLogisticsandTravels@tmb';
                    } else if ($this->session->userdata('namespace_id') == 'knttransports') {
                        $upi = 'kovainellaitranports@tmb';
                    }

                    $summary = $data['summary'];
                    $netamount = $summary->totalAmount + $summary->totalHandlingAmount + $summary->totalUnloadHandlingAmount + $summary->pickupHandlingAmount + $summary->deliveryHandlingAmount + $summary->serviceCharge + $summary->serviceTax + $summary->hamaliCharge + $summary->passCharge + $summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value + $addons_mapped['ADJSMT']->value + $addons_mapped['MCNHCH']->value + $addons_mapped['FOVCH']->value;
                    $upiparams = [
                        'pa' => $upi,
                        'pn' => $data['namespace_name'] . ' - ' . $data['summary']->code,
                        'am' => $netamount,
                        'tn' => $data['summary']->code,
                    ];

                    $ActualWeight=[];

                    foreach ($summary->itemDetails as $val) {
                        $values = explode('.', $val->actualUnitValue);
                        $values2 = explode('.', $val->unitValue);

                        $unitCode = $val->unit->code; // Get the unit code

                        if ($unitCode === 'QNTL') {
                            //check index wise count after mutiple * 10 added in 0 values
                            $kg_val = floatval($values2[1]);
                            if ( $kg_val < 10) {
                                $ActualWeight['kg_val'] += (floatval($values2[1]) * 10);
                            } else {
                                $ActualWeight['kg_val'] += floatval($values2[1]);
                            }
                            
                            //check index wise count after mutiple * 10 added in 0 values 
                            $act_kg = floatval($values[1]);
                            
                            if ($act_kg  < 10) {
                                $ActualWeight['change_kg'] += (floatval($values[1]) * 10);
                            } else {
                                $ActualWeight['change_kg'] += floatval($values[1]);
                            }

                            $ActualWeight['code'] = $unitCode;
                            $ActualWeight['qt_val'] += $values2[0];
                            $ActualWeight['change_qt'] += $values[0];
                        }
                    }

                    $data['ActualWeight'] = $ActualWeight;

                    $data['upiUrl'] = 'upi://pay?' . http_build_query($upiparams);

                    $content = $this->load->view('site/cargo/summary-pdf-3copy-knt', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == 'saiparcelkovai') {
                    $pdf->SetFont('helvetica', '', 7);
                    $pdf->SetMargins(4, 1, 5, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();

                    ob_clean();
                    $this->load->exclude_template();
                    $data['getTransaction']=$getTransaction->data;
                    $data['gst']=$gst->data;
                    $data['article_unit'] = $this->config->item('article_unit');
                    $data['ns'] = $this->session->userdata('namespace_id');
                    // $data['state'] = $state;

                    $content = $this->load->view('site/cargo/summary-pdf-3copy-saiparcelkovai', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if ($this->session->userdata('namespace_id') == 'nstransports') {
                    $pdf->setPrintHeader(false);
                    $pdf->setPrintFooter(false);
                    $pdf->SetFont('helvetica', '', 6);

                    $pdf->SetMargins(10, 5, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();

                    ob_clean();

                    $this->load->exclude_template();
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-skmtrans', $data, true);
                    $pdf->writeHTML($content);
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "newlinetrans") {
                    $pdf->SetFont('helvetica', '', 7);
                    $pdf->SetMargins(15, 3, 15, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage('P', "LEGAL");

                    ob_clean();
                    $this->load->exclude_template();
                    $data['article_unit'] = $this->config->item('article_unit');
                    $data['ns'] = $this->session->userdata('namespace_id');
                    $data['username'] = $this->session->userdata('user_name');
                    
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-newlinetrans', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "jayalakshmicargo") {
                    // $pdf->SetFont('helvetica', '', 7);
                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0); 
                    $pdf->AddPage();

                    ob_clean();
                    $this->load->exclude_template();
                    $data['article_unit'] = $this->config->item('article_unit');
                    $data['ns'] = $this->session->userdata('namespace_id');
                    $data['username'] = $this->session->userdata('user_name');
                    $data['no_of_copy'] = 3;

                    $content = $this->load->view('site/cargo/summary-pdf-3copy-jayalakshmicargo.tpl', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "kaveritravels") {
                    // $pdf->SetFont('helvetica', '', 7);
                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0); 
                    $pdf->AddPage();

                    ob_clean();
                    $this->load->exclude_template();
                    $data['article_unit'] = $this->config->item('article_unit');
                    $data['ns'] = $this->session->userdata('namespace_id');
                    $data['username'] = $this->session->userdata('user_name');
                    $data['no_of_copy'] = 3;
                    $content = $this->load->view('site/cargo/summary-pdf-kaveritravels', $data, true);
                    $pdf->writeHTML($content);
                    // echo "<pre>";
                    // print_r($data);
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "shaiktransport") {
                    // $pdf->SetFont('helvetica', '', 7);
                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0); 
                    $pdf->AddPage();

                    ob_clean();
                    $this->load->exclude_template();
                    $data['article_unit'] = $this->config->item('article_unit');
                    $data['ns'] = $this->session->userdata('namespace_id');
                    $data['username'] = $this->session->userdata('user_name');
                    $data['no_of_copy'] = 3;
                    $content = $this->load->view('site/cargo/summary-pdf-shaiktransport', $data, true);
                    $pdf->writeHTML($content);
                    // echo "<pre>";
                    // print_r($data);
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }
                
                // Client specific format available.
                $nscode = _get_namespace_id();
                $printfiles['nationalchn'] = 'summary-pdf-3copy-nationalchn.tpl';
                $printfiles['populartransport'] = 'summary-pdf-3copy-populartransport.tpl';
                
                $pdf->AddPage();

                ob_clean();
                $this->load->exclude_template();
                $data['no_of_copy'] = ( $this->input->get('count') > 0 ) ? $this->input->get('count') : 3;
                if( $printfiles[$nscode] != "" && is_file(config_item('smarty_template_dir').'site/cargo/'.$printfiles[$nscode]) ) { 
                    $pdf->SetFont('helvetica', '', 8);
                    $content = $this->load->view('site/cargo/'.$printfiles[$nscode], $data, true);
                } else {
                    $content = $this->load->view('site/cargo/summary-pdf-3copy', $data, true);
                }
                $pdf->writeHTML($content);

                $pdf->Output('cargo-summary.pdf', 'i');
            } else { // 1,2 copy
                
                require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
                $pdf = new TCPDF();
                $pdf->setPrintHeader(false);
                $pdf->setPrintFooter(false);
                $pdf->SetFont('times', '', 8);               
                $pdf->SetMargins(10, 5, 10, true); 
                $pdf->SetAutoPageBreak(TRUE, 0);

                if($this->session->userdata('namespace_id') == "rajeshcargo" || $this->session->userdata('namespace_id') == "rajeshexpress") {
                    $pdf->SetFont('helvetica', '', 6);
                    // $fontname = TCPDF_FONTS::addTTFfont(FCPATH . '/assets/css/fonts/fontawesome-webfont.ttf', 'TrueTypeUnicode', '', 96);
                    // $pdf->AddFont($fontname, 'TrueTypeUnicode', 6);

                    $pdf->SetMargins(10, 0, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();

                    ob_clean();
                    $this->load->exclude_template();
                    $cargo_setting = _get_cargo_settings();
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-rajeshv2', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->setPage(1);
                    $pdf->SetAlpha(0.15);
                    $pdf->Rotate(20, 100, 100);
                    $pdf->SetFontSize(40);
                    $pdf->Text(50, 65, "Transporter's Copy");
                    if (count($data['terms_list'])) {
                        $pdf->Text(15, 200, "Customer's Copy");
                    } else {
                        $pdf->Text(20, 160, "Customer's Copy");
                    }
                    $pdf->Rotate(0);
                    $pdf->SetAlpha(1);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if ($this->session->userdata('namespace_id') == 'skmtrans') {
                    $pdf->SetFont('helvetica', '', 6);

                    $pdf->SetMargins(10, 0, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();

                    ob_clean();

                    // get the current page break margin
                    $bMargin = $pdf->getBreakMargin();
                    // get current auto-page-break mode
                    $auto_page_break = $pdf->getAutoPageBreak();
                    // disable auto-page-break
                    $pdf->SetAutoPageBreak(false, 0);
                    // set bacground image
                    $img_file = 'assets/img/clientlogo/SKM_page_01.jpg';
                    $pdf->Image($img_file, 0, 0, 210, 297, '', '', '', false, 300, '', false, false, 0);
                    // restore auto-page-break status
                    $pdf->SetAutoPageBreak($auto_page_break, $bMargin);
                    // set the starting point for the page content
                    $pdf->setPageMark();

                    $this->load->exclude_template();
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-skmtrans', $data, true);
                    $pdf->writeHTML($content);
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "saiparcel") {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 0, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();

                    ob_clean();
                    $this->load->exclude_template();
                    $content = $this->load->view('site/cargo/summary-pdf-2copy-saiparcel', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->setPage(1);
                    $pdf->Rotate(20, 100, 100);
                    $pdf->SetFontSize(40);
                    $pdf->Rotate(0);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }
               
                
                if($this->session->userdata('namespace_id') == "kaveritravels" && $this->input->get('count') > 1) {
                    $data['no_of_copy'] = $this->input->get('count');
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 0, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();

                    ob_clean();
                    $this->load->exclude_template();
                    $content = $this->load->view('site/cargo/summary-pdf-kaveritravels', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->setPage(1);
                    $pdf->Rotate(20, 100, 100);
                    $pdf->SetFontSize(40);
                    $pdf->Rotate(0);
              
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }
            
                if($this->session->userdata('namespace_id') == "shaiktransport" && $this->input->get('count') > 0) {
                    $data['no_of_copy'] = $this->input->get('count');
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 0, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();
                    ob_clean();
                    $this->load->exclude_template();
                    $content = $this->load->view('site/cargo/summary-pdf-shaiktransport', $data, true);
                    $pdf->writeHTML($content);
                    $pdf->setPage(1);
                    $pdf->Rotate(20, 100, 100);
                    $pdf->SetFontSize(40);
                    $pdf->Rotate(0);
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if ($this->session->userdata('namespace_id') == 'kmpparcel') {
                    $pdf->SetMargins(10, 0, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();

                    require_once APPPATH . 'third_party/tcpdf/tcpdf_barcodes_1d.php';
                    $barcodestyle = array('text' => true, 'label' => $summary->data->code, 'stretchtext' => 0);
                    $data['barcode'] = $pdf->serializeTCPDFtagParameters(array($summary->data->code, 'C39', '', '', '', 15, 0.4, $barcodestyle, 'N'));

                    ob_clean();
                    $this->load->exclude_template();
                    $data['no_of_copy'] = ( $this->input->get('count') > 0 ) ? $this->input->get('count') : 2;
                    $content = $this->load->view('site/cargo/summary-pdf-3copy-kmpparcel', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "suryadev") {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();

                    ob_clean();
                    $this->load->exclude_template();
                    $content = $this->load->view('site/cargo/summary-pdf-2copy-suryadev', $data, true);
                    $pdf->writeHTML($content);
                    
                    $pdf->setPage(1);
                    $pdf->Rotate(20, 100, 100);
                    $pdf->SetFontSize(40);
                    $pdf->Rotate(0);
                    
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "seenutransports") {
                    $organization = $this->api_model->getOrganization();
                    $organization = json_decode($organization);
                    $organizations = $organization->data;

                    $state = [];
                    $stateCode =''; 
                    foreach ($organizations as $row) {
                        if ($data['summary']->fromOrganization->code == $row->code) {
                            $state[$row->station->state->code] = true;
                            $stateCode =$row->station->state->code;
                        }
                    }

                    $gst = $this->api_model->getGstDetails();
                    $gst = json_decode($gst);

                    $gst_no = "";
                    foreach ($gst->data as $row) {
                        if (in_array($row->state->code, array_keys($state))) {
                            $gst_no = $row->gstin;
                        }
                    }

                    $data['gst_no'] = $gst_no;
                    $getTransaction = $this->api_model->getTransactionDetails($data['cargoCode']);
                    $getTransaction = json_decode($getTransaction);
                    $trans_no = "";
                    foreach ($getTransaction->data as $row) {
                        if ($row->transactionMode->code == 'NBK' || $row->transactionMode->code == 'UPI') {
                            $trans_no = $row->addAttr2;
                        }
                        if ($row->transactionMode->code == 'CHEQUE') {
                            $trans_no = $row->addAttr1;
                        }
                    }

                    //gstno used get state 
                    $gstinCode='';
                    if($summary->data->paymentType->code =="PAD" || $summary->data->paymentType->code=="INP"){
                        $gstinCode =$summary->data->fromCustomerGST;
                    }else if($summary->data->paymentType->code =="TOP" || $summary->data->paymentType->code =="OATP" || $summary->data->paymentType->code =="TPPAD"){
                        $gstinCode = $summary->data->toCustomerGST;
                    }

                    $gstin = [
                        'gstin'=> $gstinCode ?$gstinCode :$summary->data->fromCustomerGST,
                    ]; 

                    $getGst = $this->api_model->getGSTDetailsApi($gstin);
                    $getGst = json_decode($getGst);
                    $getGst =$getGst->data;
                    $Gststate = $getGst->state->code;

                    $data['Gststate'] =$Gststate;
                    $data['stateCode'] = $stateCode;
                    $data['trans_no'] = $trans_no;

                    $pdf->SetFont('helvetica', '', 9);
                    $pdf->SetMargins(4, 1, 5, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();

                    ob_clean();
                    $this->load->exclude_template();
                    $data['getTransaction']=$getTransaction->data;
                    $data['gst']=$gst->data;
                    $data['article_unit'] = $this->config->item('article_unit');
                    $data['ns'] = $this->session->userdata('namespace_id');
                    // $data['state'] = $state;

                    $content = $this->load->view('site/cargo/summary-pdf-3copy-seenutransport', $data, true);
                    $pdf->writeHTML($content);

                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if($this->session->userdata('namespace_id') == "thamizhiparcel") {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();

                    ob_clean();
                    $this->load->exclude_template();
                    $content = $this->load->view('site/cargo/summary-pdf-2copy-thamizhiparcel', $data, true);
                    $pdf->writeHTML($content);
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                if(in_array($this->session->userdata('namespace_id'), ["citycargo","cityparcel"]) && $this->input->get('count') == 1) {
                    $pdf->SetFont('helvetica', '', 8);
                    $pdf->SetMargins(10, 4, 50, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);
                    $pdf->AddPage();
                    
                    $print_type = $this->input->get('printType');
                    if ($print_type == 1) {
                        $pdf->Image('assets/img/original-watermark.png', 40, 20, 100, 100);
                    } else {
                        $pdf->Image('assets/img/duplicate-watermark.png', 40, 20, 100, 100);
                    }

                    ob_clean();
                    $this->load->exclude_template();
                    $content = $this->load->view('site/cargo/summary-pdf-cityparcel', $data, true);
                    $pdf->writeHTML($content);
                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }

                // Client specific format available.
                $nscode = _get_namespace_id();
                $printfiles['pkrsps'] = 'summary-pdf-3copy-pkrsps.tpl';
                $printfiles['chakratravels'] = 'summary-pdf-3copy-chakratravels.tpl';
                $printfiles['jayalakshmicargo'] = 'summary-pdf-3copy-jayalakshmicargo.tpl';
                $printfiles['sriannamalaiyar'] = 'summary-pdf-3copy-annamalaiyar.tpl';
                $printfiles['jasminparcel'] = 'summary-pdf-3copy-jasminparcel.tpl';
                $printfiles['tvlscargo'] = 'summary-pdf-tvlscargo.tpl';
                $printfiles['vikramcargo'] = 'summary-pdf-vikramcargo.tpl';
                $printfiles['arthitravels'] = 'summary-pdf-arthitravels.tpl';
                $printfiles['vikascargo'] = 'summary-pdf-vikas.tpl';
                $printfiles['vikasecotrans'] = 'summary-pdf-vikas.tpl';
                $printfiles['kkexpress'] = 'summary-pdf-3copy-kkexpress.tpl';
                $printfiles['populartransport'] = 'summary-pdf-3copy-populartransport.tpl';
                $printfiles['royalcargo'] = 'summary-pdf-3copy-royalcargo.tpl';
                $printfiles['challengexpress'] = 'summary-pdf-3copy-challengexpress.tpl';
                $printfiles['fivestar'] = 'summary-pdf-3copy-fivestar.tpl';
                $printfiles['kknexpress'] = 'summary-pdf-kknexpress.tpl';
                
                if( $printfiles[$nscode] != "" && 
                      is_file(config_item('smarty_template_dir').'site/cargo/'.$printfiles[$nscode]) ) { 
                    
                    if($nscode == 'tvlscargo') 
                        $pdf->AddPage('L', 'A5'); 
                    //else if($nscode == 'arthitravels') 
                        //$pdf->AddPage('L', array(100, 260));
                    else                               
                        $pdf->AddPage();

                    if ($nscode == 'vikascargo' || $nscode == 'vikasecotrans') {
                        $pdf->SetFont('helvetica', '', 8);
                    }

                    $pdf->SetMargins(10, 4, 10, true);
                    $pdf->SetAutoPageBreak(TRUE, 0);                    
                    ob_clean();

                    if($nscode == 'fivestar') {
                        $qrcodedata = $data['summary']->additionalAttribute->SLUG ?: $data['summary']->code;
                        $styleQR = array('border' => false, 'padding' => 0, 'fgcolor' => array(0, 0, 0), 'bgcolor' => false);
                        $data['barcode'] = $pdf->serializeTCPDFtagParameters(array($qrcodedata, 'QRCODE,H', '', '', 20, 20, $styleQR, 'N'));
                    }

                    $this->load->exclude_template();
                    $data['no_of_copy'] = ( $this->input->get('count') > 0 ) ? $this->input->get('count') : 1;
                    $content = $this->load->view('site/cargo/'.$printfiles[$nscode], $data, true);
                    $pdf->writeHTML($content);
                    
                    if($nscode == 'arthitravels') {
                        $qrcodedata = $data['summary']->additionalAttribute->SLUG ?: $data['summary']->code;
                        $styleQR = array('border' => false, 'padding' => 0, 'fgcolor' => array(0, 0, 0), 'bgcolor' => false);
                        $pdf->write2DBarcode($qrcodedata, 'QRCODE,H', 65, 50, 25, 25, $styleQR, 'N');
                        $pdf->write2DBarcode($qrcodedata, 'QRCODE,H', 165, 50, 25, 25, $styleQR, 'N');
                    }

                    if($nscode == 'royalcargo') {
                        $qrcodedata = $data['summary']->additionalAttribute->SLUG ?: $data['summary']->code;
                        $styleQR = array('border' => false, 'padding' => 0, 'fgcolor' => array(0, 0, 0), 'bgcolor' => false);
                        $pdf->write2DBarcode($qrcodedata, 'QRCODE,H', 165, 7, 20, 20, $styleQR, 'N');

                        if($data['no_of_copy'] > 1){
                            $pdf->write2DBarcode($qrcodedata, 'QRCODE,H', 165, 145, 20, 20, $styleQR, 'N');
                        }
                    }
                    
                    if($nscode == 'challengexpress') {
                        $qrcodedata = $data['summary']->additionalAttribute->SLUG ?: $data['summary']->code;
                        $styleQR = array('border' => false, 'padding' => 0, 'fgcolor' => array(0, 0, 0), 'bgcolor' => false);
                        $pdf->write2DBarcode($qrcodedata, 'QRCODE,H', 165, 7, 40, 20, $styleQR, 'N');

                        if($data['no_of_copy'] > 1){
                            if($terms_list ==''){
                            $pdf->write2DBarcode($qrcodedata, 'QRCODE,H', 165, 128, 40, 20, $styleQR, 'N');
                            }else{
                            $pdf->write2DBarcode($qrcodedata, 'QRCODE,H', 165, 145, 40, 20, $styleQR, 'N');   
                            }
                           
                        }
                    }

                    $pdf->Output('cargo-summary.pdf', 'i');
                    return;
                }  

                $pdf->AddPage();     
                ob_clean();
                $this->load->exclude_template();

                if($this->session->userdata('namespace_id') == "nationalchn") {
                    $content = $this->load->view('site/cargo/summary-pdf-nationalchn', $data, true);
                } elseif ( in_array($this->session->userdata('namespace_id') , ["atobparcel", "dewanparcel","gmslogistics", "smroadlines", "sachinexpress", "ashokalogistics", "devasenna", "sktxlogistics"]) ) {
                    $content = $this->load->view('site/cargo/summary-pdf-m2', $data, true);    
                } elseif ($this->session->userdata('namespace_id') == "srtparcel") {
                    $content = $this->load->view('site/cargo/summary-pdf-srtparcel', $data, true);
                } elseif ($this->session->userdata('namespace_id') == "vijayalakshmi") {
                    $content = $this->load->view('site/cargo/summary-pdf-vijayalakshmi', $data, true);
                } elseif ($this->session->userdata('namespace_id') == "madhuraja") {
                    $content = $this->load->view('site/cargo/summary-pdf-madhuraja', $data, true);
                } elseif ($this->session->userdata('namespace_id') == "swaminathan") {
                    $content = $this->load->view('site/cargo/summary-pdf-swaminathan', $data, true);
                } else {
                    $content = $this->load->view('site/cargo/summary-pdf', $data, true);
                }

                $pdf->writeHTML($content);

                // set style for barcode
                $style = array(
                    'border' => 2,
                    'vpadding' => 'auto',
                    'hpadding' => 'auto',
                    'fgcolor' => array(0, 0, 0),
                    'bgcolor' => false, //array(255,255,255)
                    'module_width' => 1, // width of a single module in points
                    'module_height' => 1 // height of a single module in points
                );
                $pdf->SetFont('times', '', 20);

                $pdf->setPage(1);
                $pdf->SetAlpha(0.2);
                if ($data['payment_type_code'] == 'PAD') {
                    $img_file = 'assets/img/paid-watermark.png';
                } else if ($data['payment_type_code'] == 'TOP') {
                    $img_file = 'assets/img/topay-watermark.png';
                } else if ($data['payment_type_code'] == 'FS') {
                    $img_file = 'assets/img/fs-watermark.png';
                } else if ($data['payment_type_code'] == 'INP' || $data['payment_type_code'] == 'OATP') {
                    $img_file = 'assets/img/inp-watermark.png';
                } else if ($data['payment_type_code'] == 'TPPAD') {
                    $img_file = 'assets/img/tppad-watermark.png';
                }
                $pdf->Image($img_file, 20, -10, 200, 200);
                if ($this->input->get('count') == 2) {
                    $pdf->Image($img_file, 20, 76, 200, 200);
                }
                $pdf->SetAlpha(1);

                $pdf->Output('cargo-summary.pdf', "i");
            }
        }
    }
    // For Lucky Express Cargo NS
    private function print_summary_luckycargoes($data) {
        require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
        $pdf = new TCPDF();
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->SetFont('helvetica', '', 6);

        $pdf->SetMargins(0, 0, 0, true);
        $pdf->SetAutoPageBreak(TRUE, 0);
        $pdf->AddPage('P', "LEGAL");

        if ($this->input->get('bg') == 1) {
            // get the current page break margin
            $bMargin = $pdf->getBreakMargin();
            // get current auto-page-break mode
            $auto_page_break = $pdf->getAutoPageBreak();
            // disable auto-page-break
            $pdf->SetAutoPageBreak(false, 0);
            // set bacground image
            $img_file = FCPATH .'/assets/img/lec.jpg';
            $pdf->Image($img_file, 0, 0, 210, 297, '', '', '', false, 300, '', false, false, 0);
            // restore auto-page-break status
            $pdf->SetAutoPageBreak($auto_page_break, $bMargin);
            // set the starting point for the page content
            $pdf->setPageMark();
        }

        $summary = $data['summary'];
        
        $addons_mapped = $data['addons_mapped'];
        $cargo_payment_status = $this->config->item('cargo_payment_status');

        $topoffset = 2;
        for ($i = 0; $i < 3; $i++) {

            if ($i == 1) {
                $topoffset += 118;
            } else if ($i == 2) {
                $topoffset += 117.5;
            }
            $pdf->SetFont('helvetica', '', 8);
            $pdf->Text(170, 5.5 + $topoffset, date('d-m-Y h:i A', strtotime($summary->bookedAt)));

            $pdf->SetFont('helvetica', '', 9);
            $pdf->Text(79, 11.55 + $topoffset, implode('    ', (array) str_split($summary->fromOrganization->shortCode)));
            $pdf->Text(106.5, 11.55 + $topoffset, implode('    ', (array) str_split($summary->toOrganization->shortCode)));
            $total_item_count = 0;
            foreach ($summary->itemDetails as $itemindex => $article) {
                $total_item_count += $article->itemCount;
            }

            $pdf->SetFont('helvetica', 'B', 11);
            $pdf->Text(165, 11.3 + $topoffset, $summary->code." x ".$total_item_count);

            $pdf->SetFont('helvetica', 'B', 10);
            $pdf->Text(160, 18 + $topoffset, strtoupper($data['payment_type_name']));

            
            // organization
            $fromOrg = $summary->fromOrganization->name;
            if (trim($summary->fromOrganization->contact)) {
                $fromOrg .= " ({$summary->fromOrganization->contact})";
            }
            $y = 27.5;
            $pdf->SetFont('helvetica', '', 9);
            $pdf->Text(40, $y + $topoffset, $fromOrg);
            $toOrg = $summary->toOrganization->name;
            if (trim($summary->toOrganization->contact)) {
                $toOrg .= " ({$summary->toOrganization->contact})";
            }
            $pdf->Text(121, $y + $topoffset, $toOrg);
            
            $pdf->SetFont('helvetica', '', 8); // reset previous font settings

            // customer
            $y = 35.75;
            $yincrement = 4;

            $pdf->Text(11, $y + $topoffset, $summary->fromCustomer->name);
            $pdf->Text(92, $y + $topoffset, $summary->toCustomer->name);

            $y += $yincrement;
            if (trim($summary->fromCustomer->mobileNumber)) {
                $pdf->Text(11, $y + $topoffset, $summary->fromCustomer->mobileNumber);
            }
            if (trim($summary->toCustomer->mobileNumber)) {
                $pdf->Text(92, $y + $topoffset, $summary->toCustomer->mobileNumber);
            }
            $y += $yincrement;
            if (trim($summary->fromCustomerGST)) {
                $pdf->Text(11, $y + $topoffset, strtoupper($summary->fromCustomerGST));
            }
            if (trim($summary->toCustomerGST)) {
                $pdf->Text(92, $y + $topoffset, strtoupper($summary->toCustomerGST));
            }

            $actualUnitSum = 0;
            $unitValueSum = 0;
            foreach ($summary->itemDetails as $itemindex => $article) {
                $y = 60 + ($itemindex * 4);
                $pdf->Text(12, $y + $topoffset, $article->itemCount);
                $pdf->Text(21, $y + $topoffset, $article->cargoItem->name);
                $pdf->Text(92, $y + $topoffset, $article->actualUnitValue ?: '-');
                $pdf->Text(113, $y + $topoffset, $article->unitValue <= 1 ? '-' : $article->unitValue);
                $actualUnitSum += $article->actualUnitValue ?: 0;
                $unitValueSum += $article->unitValue <= 1 ? 0 : $article->unitValue;
            }
            if ($summary->invoiceAmount) {
                $pdf->Text(46, 88 + $topoffset, inr_format($summary->invoiceAmount));
            }
            if ($addons_mapped['EWBL']->value) {
                $pdf->SetFont('helvetica', 'B', 8); // reset previous font settings
                $pdf->Text(46, 91 + $topoffset, $addons_mapped['EWBL']->value);
                $pdf->SetFont('helvetica', '', 8); // reset previous font settings
            }
            $pdf->Text(92, 80.15 + $topoffset, $actualUnitSum ?: '-');
            $pdf->Text(113, 80.15 + $topoffset, $unitValueSum ?: '-');

            $freightamount = $summary->totalAmount;
            $pdf->Text(180, 59 + $topoffset, inr_format($freightamount));

            $y = 66;
            $labelx = 130;
            $valuex = 180;
            $yincrement = 4;
            if ($summary->hamaliCharge) {
                $pdf->Text($labelx, $y + $topoffset, 'Hamali Charges');
                $pdf->Text($valuex, $y + $topoffset, inr_format($summary->hamaliCharge));
                $y += $yincrement;
            }
            if ($summary->docketCharge) {
                $pdf->Text($labelx, $y + $topoffset, 'Docket Charges');
                $pdf->Text($valuex, $y + $topoffset, inr_format($summary->docketCharge));
                $y += $yincrement;
            }
            if ($summary->serviceCharge) {
                $pdf->Text($labelx, $y + $topoffset, 'Service Charges');
                $pdf->Text($valuex, $y + $topoffset, inr_format($summary->serviceCharge));
                $y += $yincrement;
            }
            if ($summary->totalHandlingAmount) {
                $pdf->Text($labelx, $y + $topoffset, 'Loading Charges');
                $pdf->Text($valuex, $y + $topoffset, inr_format($summary->totalHandlingAmount));
                $y += $yincrement;
            }
            if ($summary->pickupHandlingAmount) {
                $pdf->Text($labelx, $y + $topoffset, 'Pickup Charges');
                $pdf->Text($valuex, $y + $topoffset, inr_format($summary->pickupHandlingAmount));
                $y += $yincrement;
            }
            if ($summary->deliveryHandlingAmount) {
                $pdf->Text($labelx, $y + $topoffset, 'Door Delivery Charges');
                $pdf->Text($valuex, $y + $topoffset, inr_format($summary->deliveryHandlingAmount));
                $y += $yincrement;
            }

            $otheramount = $summary->hamaliCharge + $summary->docketCharge + $summary->serviceCharge + $summary->totalHandlingAmount + $summary->pickupHandlingAmount + $summary->deliveryHandlingAmount;
            $pdf->Text(178, 92 + $topoffset, inr_format($freightamount + $otheramount)); // subtotal
            $pdf->Text(178, 97 + $topoffset, inr_format($summary->serviceTax), false, false, true, 0, 0, '', false, '', 0, false, 'T', 'M', true);

            $netamount = $summary->totalAmount + $summary->totalHandlingAmount + $summary->totalUnloadHandlingAmount + $summary->pickupHandlingAmount + $summary->deliveryHandlingAmount + $summary->serviceCharge + $summary->serviceTax + $summary->hamaliCharge + $summary->passCharge + $summary->docketCharge + $addons_mapped['PODCH']->value;
            $pdf->SetFont('helvetica', 'B', 9);
            $pdf->Text(178, 103 + $topoffset, inr_format($netamount));
            $pdf->SetFont('helvetica', '', 8);
            
            if($summary->remarks){                
                $pdf->Text(10, 103 + $topoffset, "Remakrs:");
                $y = 107;
                $yincrement = 2;
                foreach ($summary->remarks as $row) {
                    $pdf->Text(10, $y + $topoffset, $row->name);
                    $y += $yincrement;
                }                
            }
            
            $pdf->SetFont('helvetica', '', 8); // reset previous font settings
        }

        ob_clean();
        $pdf->Output('cargo-summary.pdf', 'i');
    }

    public function print_cargo_invoice() {
        $this->is_logged_in();

        $summary = $this->api_model->getCargoSummary(array('cargoCode' => $this->input->get('code')));
        $summary = json_decode($summary);
        $data['namespace_name'] = $this->session->userdata('namespace_name');
        $data['cargoCode'] = $this->input->get('code');
        $data['summary'] = $summary->data;

        $cargo_payment_status = $this->config->item('cargo_payment_status');
        $data['payment_type_code'] = $summary->data->paymentType->code;
        $data['payment_type_name'] = $cargo_payment_status[$summary->data->paymentType->code];
        // change invoice pay to paid if settlement completed
        // if ($summary->data->paymentType->code == 'INP' && $summary->data->paymentSettlementFlag == 1) {
        //     $data['payment_type_code'] = 'PAD';
        //     $data['payment_type_name'] = $cargo_payment_status['PAD'];
        // }

        // map addons
        $data['addons_mapped'] = array();
        foreach ($summary->data->cargoAddonsDetails as $row) {
            $data['addons_mapped'][$row->addonsType->code] = $row;
        }

        $nsprofile = $this->api_model->getNamespaceProfile(array('authtoken' => $this->_user_hash));
        $nspro = json_decode($nsprofile);
        $data['nsprofile'] = $nspro->data;

        $data['article_unit'] = $this->config->item('article_unit');
        $data['cargo_payment_status'] = $this->config->item('cargo_payment_status');

        $this->load->exclude_template();
        $this->load->view('site/cargo/print-cargo-invoice', $data);
    }

    public function transaction_report() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        //$data['route'] = $routes;
        //$data['active_schedules'] = get_active_schedules();
        $data['groupusers'] = get_active_group_and_users();
        $data['cargo_status'] = config_item('cargo_status');
        $data['transaction_mode'] = config_item('transaction_mode');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $data['user_station_code'] = $this->session->userdata('org_station_code');
        $data['user_login_code'] = $this->session->userdata('user_id');

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $this->load->view('site/cargo/transaction-report', $data);
    }

    public function transaction_report_list() {
        $this->is_logged_in();

        $user_code = $this->input->post('userCode');
        if (empty($user_code)) {
            $user_code = $this->session->userdata('user_id');
        }
        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
        $fromDate = date('Y-m-d', strtotime($fromDate));
        $toDate = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQFCRM569',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'userCode' => $user_code,
            'cargoStatusCode' => $this->input->post('cargoStatus'),
            'paymentStatusCode' => $this->input->post('payStatus'),
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'filterCode' => $this->input->post('filterCode'),
            'transactionModeCode' => $this->input->post('transactionModeCode'),
            'groupCode' => $this->input->post('groupCode') ?: 'NA',
            'cargoCode' => 'NA'
        );

        if (!has_action_rights('CGO-TRAS-USR-FILTER')) {
            $data['userCode'] = $this->session->userdata('user_id');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $summary = array();
        $transaction_modes = array();

        foreach ($result->data as $row) {
            $net_payable = $row->total_amount + $row->connecting_charge + $row->total_handling_amount + $row->total_unload_handling_amount + $row->service_tax + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->hamali_charge + $row->pass_charge + $row->docket_charge + $row->pod_charge - $row->commission_amount;
            if (isNotnull($row->transaction_mode)) {
                $transaction_modes[$row->transaction_mode]['count'] += 1;
                $transaction_modes[$row->transaction_mode]['freight'] += $row->total_amount;
                $transaction_modes[$row->transaction_mode]['netpayable'] += $net_payable;
            }

            if ($row->cargo_status_code == 'CA' || $row->cargo_status_code == 'CR') {
                continue;
            }
            $summary[$row->payment_status_code]['paycode'] = $row->payment_status_code;
            $summary[$row->payment_status_code]['netpayable'] += $net_payable;
            $summary[$row->payment_status_code]['handling'] +=    $row->total_handling_amount;
            $summary[$row->payment_status_code]['freight'] += $row->total_amount;
            $summary[$row->payment_status_code]['unloading'] += $row->total_unload_handling_amount;
            $summary[$row->payment_status_code]['gst'] += $row->service_tax;
            $summary[$row->payment_status_code]['pickup'] += $row->pickup_handling_amount;
            $summary[$row->payment_status_code]['delivery'] += $row->delivery_handling_amount;
            $summary[$row->payment_status_code]['paid'] +=  $row->transaction_amount;
            $summary[$row->payment_status_code]['service_charge'] +=  $row->service_charge;
            $summary[$row->payment_status_code]['commission'] += $row->commission_amount;
            $summary[$row->payment_status_code]['connecting'] += $row->connecting_charge;
        }

        $data['summary'] = $summary;
        $data['transaction_modes'] = $transaction_modes;
        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['transaction_mode'] = config_item('transaction_mode');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['namespaceCode'] = $this->session->userdata('namespace_id');

        if ($this->input->post('export') == 1) {
            $filename = 'Transaction Report';
            $this->load->excel('site/cargo/transaction-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/transaction-report-list', $data);
        }
    }

    public function transaction_report_list_tally() {
        $this->is_logged_in();

        $this->load->library('excel');
        $this->excel->getProperties()->setCreator("Ezee")
                                    ->setLastModifiedBy("Ezee")
                                    ->setTitle("Transactions List")
                                    ->setSubject("Transactions List")
                                    ->setDescription("Transactions List.")
                                    ->setKeywords("Transactions List")
                                    ->setCategory("Tally");

        $this->excel->setActiveSheetIndex(0);
        $this->excel->getActiveSheet()->setTitle('Transactions');

        $this->excel->getActiveSheet()->getStyle('A1:Z1')->getFont()->setBold(true);
        $this->excel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('B')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('C')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('D')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('E')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('F')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('G')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('H')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('I')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('J')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('K')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('L')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('M')->setAutoSize(true);

        $user_code = $this->input->post('userCode');
        if (empty($user_code)) {
            $user_code = $this->session->userdata('user_id');
        }
        
        $fdate = $this->input->post('fromDate');
        $tdate = $this->input->post('toDate');
        if ($this->input->post('export') == 1) {
            $fdate = date('Y-m-d', strtotime($fdate));
            $tdate = date('Y-m-d', strtotime($tdate));
        }

        $data = array(
            'queryCode' => 'RQFCRM569',
            'toDate' => $tdate,
            'fromDate' => $fdate,
            'userCode' => $user_code,
            'cargoStatusCode' => $this->input->post('cargoStatus'),
            'paymentStatusCode' => $this->input->post('payStatus'),
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'filterCode' => $this->input->post('filterCode'),
            'transactionModeCode' => $this->input->post('transactionModeCode'),
            'groupCode' => $this->input->post('groupCode') ?: 'NA',
            'cargoCode' => 'NA'
        );

        if (!has_action_rights('CGO-TRAS-USR-FILTER')) {
            $data['userCode'] = $this->session->userdata('user_id');
        }
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
    
        $this->excel->getActiveSheet()->setCellValue('A1', 'Type');
        $this->excel->getActiveSheet()->setCellValue('B1', 'User');
        $this->excel->getActiveSheet()->setCellValue('C1', 'Transaction Date');
        $this->excel->getActiveSheet()->setCellValue('D1', 'Lr No');
        $this->excel->getActiveSheet()->setCellValue('E1', 'From & To');
        $this->excel->getActiveSheet()->setCellValue('F1', 'Payment Status');
        $this->excel->getActiveSheet()->setCellValue('G1', 'No Of Lr');
        $this->excel->getActiveSheet()->setCellValue('H1', 'Lr Amount');
        $this->excel->getActiveSheet()->setCellValue('I1', 'Total Amount');
        $this->excel->getActiveSheet()->setCellValue('J1', 'Commission');
        $this->excel->getActiveSheet()->setCellValue('K1', 'Other Charges');
        $this->excel->getActiveSheet()->setCellValue('L1', 'Agent Share');
        $this->excel->getActiveSheet()->setCellValue('M1', 'Amount');

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                $row = 2;
                $col = 0;
                $cargo_payment_status = config_item('cargo_payment_status');
                for ($i = 0; $i < $ticket_count; $i++) {
                    $t = $result->data[$i];
                    if( $t->cargo_status_code != "CA" ) {
                        $type = 'BO / Sales';
                    } else {
                        $type = 'CA / Purchase';
                    }
                    $other_charges = $t->hamali_charge + $t->pass_charge + $t->docket_charge + $t->pod_charge + $t->demurrage_charge + $t->round_off_value + $t->tds_tax + $t->insurance_amount + $t->service_tax + $t->service_charge;
                    $agent_share = $t->total_handling_amount + $t->total_unload_handling_amount + $t->pickup_handling_amount + $t->delivery_handling_amount;
                    $net_amount = $t->total_amount+$t->total_handling_amount+$t->total_unload_handling_amount+$t->pickup_handling_amount+$t->delivery_handling_amount+$t->service_charge+$t->service_tax+$t->hamali_charge+$t->pass_charge+$t->docket_charge + $t->pod_charge + $t->demurrage_charge + $t->round_off_value + $t->insurance_amount;
                    // + $addons_mapped['ADJSMT']->value + $addons_mapped['MCNHCH']->value + $addons_mapped['FOVCH']->value

                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col, $row, $type);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->user_first_name);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, date('d-m-Y', strtotime($t->booked_at)));
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->cargo_code);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->from_station_name.' - '.$t->to_station_name);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $cargo_payment_status[$t->payment_status_code]);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->total_item_count);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->total_amount);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $net_amount);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->commission_amount + $t->handling_commission_amount);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $other_charges);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $agent_share);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $net_amount - ($agent_share + $t->commission_amount + $t->handling_commission_amount));
                    
                    $col = 0;
                    $row++;
                }
            }
        }

        $filename = 'Transactions-'.$this->input->post('fromDate').' TO '.$this->input->post('toDate').'.xls';
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="'.$filename.'"');
        header('Cache-Control: max-age=0');
        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
        $objWriter->save('php://output');
    }

    public function find_bookings() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code] = $branch->name;
        }
        asort($organization);
        $data['branches'] = $organization;

        $vendors = $this->api_model->cargoCustomerVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/find-bookings', $data);
    }

    public function find_bookings_list() {
        $this->is_logged_in();

        // $fromDate = $this->input->post('fromDate');
        // $toDate = $this->input->post('toDate');
        $fromMobile = trim($this->input->post('fromMobileNumber'));
        $toMobile = trim($this->input->post('toMobileNumber'));
        $cargoCode = trim($this->input->post('cargoCode'));

        $customerName = trim($this->input->post('customerName'));

        // if ($fromDate == "") {
        //     $fromDate = date('Y-m-d', strtotime('-6month'));
        // }
        // if ($toDate == "") {
        //     $toDate = date('Y-m-d');
        // }
        if ($fromMobile == "") {
            $fromMobile = "NA";
        }
        if ($toMobile == "") {
            $toMobile = "NA";
        }
        if ($cargoCode == "") {
            $cargoCode = "NA";
        }

        if ($customerName == "") {
            $customerName = "NA";
        } else {
            $customerName = strtolower($customerName);
            $customerName = preg_replace('/\s+/', '', $customerName);
            $customerName = $customerName . '%';
        }

        $data = array(
            'queryCode' => 'RQFCUI5710',
            'fromDate' => $this->input->post('fromDate')?:'NA',
            'toDate' => $this->input->post('toDate')?:'NA',
            'cargoStatusCode' => $this->input->post('cargoStatus'),
            'paymentStatusCode' => $this->input->post('payStatus'),
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'fromOrganizationCode' => $this->input->post('fromOrganizationCode'),
            'toOrganizationCode' => $this->input->post('toOrganizationCode'),
            'fromMobileNumber' => $fromMobile,
            'toMobileNumber' => $toMobile,
            'customerName' => $customerName,
            'cargoCode' => $cargoCode,
            'vendorUserCode' => $this->input->post('vendorUserCode')?:'NA',
        );

        $p_key = _get_namespace_id().'_find_bookings_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');


        //$this->load->view('site/cargo/find-bookings-list', $data);
        if ($this->input->post('export') == 1) {
            $filename = 'Find-Bookings-Report';
            $this->load->excel('site/cargo/find-bookings-list-xls', $data, $filename);
        }
        else {
            $this->load->view('site/cargo/find-bookings-list', $data);
        }
    }

    function cancel_cargo() {
        $this->is_logged_in();

        $bookedAt = $this->input->post('bookedAt');
        $fromStationCode = $this->input->post('fromStationCode');
        $login_station = $this->session->userdata('org_station_code');
        $instant_cancellation_minutes = $this->session->userdata('instant_cancellation_minutes');
        $has_instant_cancellation = ($login_station == $fromStationCode && ((strtotime('now') - strtotime($bookedAt)) / 60) < $instant_cancellation_minutes);

        if (has_action_rights('CARGO-CANCEL') || $has_instant_cancellation) {

            $revertAmount = (float) $this->input->post('revertAmount');
            if ($revertAmount > 0) {
                $revert = $this->api_model->revertCargoPayment(array(
                    'cargoCode' => $this->input->post('code'),
                    'transactionType' => array('code' => 'CGCA'),
                    'transactionAmount' => $revertAmount
                ));
                $revert = json_decode($revert);
                if ($revert->status != 1) {
                    echo json_encode($revert);
                    return;
                }
            }
            
            $data = array(
                'statusCode' => 'CA',
                'cargoCode' => $this->input->post('code'),
                'remarks' => $this->input->post('remarks') ?: []
            );
            echo $this->api_model->changeCargoItemStatus($data);
        } else {
            echo json_encode(array('status' => 0, 'errorDesc' => 'Cancellation not allowed'));
        }
    }

    function missing_cargo() {
        $this->is_logged_in();
        $data = array(
            'statusCode' => 'CMS',
            'cargoCode' => $this->input->post('code'),
            'remarks' => $this->input->post('remarks') ?: []
        );
        echo $this->api_model->changeCargoItemStatus($data);
    }
    function edit_gst_cargo() {
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('code'),
            'itemDetails' => $this->input->post('itemDetails') ?: [],
            'serviceTax' => (float) $this->input->post('serviceTax'),

            'fromCustomerGST' => $this->input->post('fromCustomerGST'),
            'toCustomerGST' => $this->input->post('toCustomerGST'),
            'additionalAttribute' => $this->input->post('additionalAttribute') ?: new stdClass,

            'invoiceDetails' => $this->input->post('invoiceDetails') ?: [],
            'cargoAddonsDetails' => $this->input->post('cargoAddonsDetails') ?: []
        );

        echo $this->api_model->editCargoServiceTax($data);
    }

    //  change status from find page
    function update_booking_status() {
        $this->is_logged_in();

        $cargoCodes = (array) $this->input->post('codes');
        if ($this->input->post('state') == 'CUL') { //  unload
            $codes = array();
            foreach ($cargoCodes as $k => $v) {
                $codes[] = array('code' => $v);
            }
            $data = array(
                'cargoStatus' => array('code' => $this->input->post('state')),
                'cargoList' => $codes
            );
            //  only unload
            echo $this->api_model->changeCargoStatus($data);
        } elseif ($this->input->post('state') == 'CD') { //  delivered
            $codes = array();
            foreach ($cargoCodes as $k => $v) {
                if ($this->input->post('additionalAttribute')) {
                    $cgs = $this->api_model->addCargoDeliveryCharges(array(
                        'code' => $v,
                        'additionalAttribute' => $this->input->post('additionalAttribute') ?: [],
                    ));
                    $cgs = json_decode($cgs);

                    if ($cgs->status != 1) {
                        $t = json_encode($cgs);
                        break;
                    }
                }

                $data = array(
                    'statusCode' => $this->input->post('state'),
                    'cargoCode' => $v,
                    'otpNumber' => $this->input->post('otpNumber'),
                    'offlineUserCode' => $this->input->post('offlineUserCode') ?: '',
                    'data' => array(
                        'remarks' => $this->input->post('remarks') ?: []
                    )
                );
                //  delivered
                $t = $this->api_model->deliveryCargoItemStatus($data);
            }
            echo $t;
        } else {
            $codes = array();
            foreach ($cargoCodes as $k => $v) {
                //$codes[] = array('code'=>$v);
                $data = array(
                    'statusCode' => $this->input->post('state'),
                    'cargoCode' => $v
                );
                //  delivered, unable to deliver, return.
                $t = $this->api_model->changeCargoItemStatus($data);
            }
            echo $t;
        }
    }

    //  change payment status
    function update_payment_status() {
        $this->is_logged_in();
        $data = array(
            'cargoCode' => $this->input->post('codes'),
            'paymentCode' => 'TPPAD'
        );

        echo $this->api_model->changeCargoPaymentStatus($data);
    }

    public function my_transaction_report() {
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
                'userlist' => $Groupuser->data
            );
        }
        $data['entity'] = $tmp;

        $vendors = $this->api_model->cargoCustomerVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;

        $this->load->view('site/cargo/my-transaction-report', $data);
    }

    function my_transaction_report_list() {
        $this->is_logged_in();
        
        $transactionType = $this->input->post('transactionType');
        $fromDate = $this->input->post('from');
        $toDate = $this->input->post('to');

        if ($transactionType == 'USER') {
            $user = $this->input->post('user');
        } elseif ($transactionType == 'VENDOR'){
            $user = $this->input->post('vendor');
        } else {
            $user = $this->input->post('user');
        }

        $report = $this->api_model->getUserReport(array(
            'user' => $user, 
            'from' => date('Y-m-d', strtotime($fromDate)), 
            'to' => date('Y-m-d', strtotime($toDate))
        ));
        $rpt = json_decode($report);

        if (is_array($rpt->data) && count($rpt->data) > 0) {
            $data['first_trans'] = $rpt->data[0];
            $data['last_trans'] = $rpt->data[count($rpt->data) - 1];

            $data['credit_amount'] = 0;
            $data['debit_amount'] = 0;
            foreach ($rpt->data as $row) {
                $data['credit_amount'] += $row->creditAmount;
                $data['debit_amount'] += $row->debitAmount;
        }
        }
        
        $data['reports'] = $rpt->data;
        $data['username'] = $this->input->post('username');

        if ($this->input->post('export') == 1) {
            $filename = 'My-Transaction-Report';
            $this->load->excel('site/cargo/my-transaction-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/my-transaction-report-list', $data);
        }
    }

    public function booking_report() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $data['groupusers'] = get_active_group_and_users();
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $data['user_station_code'] = $this->session->userdata('org_station_code');
        $data['user_login_code'] = $this->session->userdata('user_id');

        $states=json_decode($this->api_model->getAllStates());
        $data['states'] = $states->data;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $this->load->view('site/cargo/booking-report', $data);
    }

    // booking report v1
    public function booking_report_v2() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $data['groupusers'] = get_active_group_and_users();
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $data['user_station_code'] = $this->session->userdata('org_station_code');
        $data['user_login_code'] = $this->session->userdata('user_id');

        $states=json_decode($this->api_model->getAllStates());
        $data['states'] = $states->data;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $this->load->view('site/cargo/booking-report-v2', $data);
    }
    //delivery report v2
    public function delivery_report_v2() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $data['groupusers'] = get_active_group_and_users();
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $data['user_station_code'] = $this->session->userdata('org_station_code');
        $data['user_login_code'] = $this->session->userdata('user_id');

        $states=json_decode($this->api_model->getAllStates());
        $data['states'] = $states->data;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $GroupDetail = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $this->load->view('site/cargo/delivery-report-v2', $data);
    }

    public function booking_report_list() {
        $this->is_logged_in();

        $user_code = $this->input->get('userCode');
        if (empty($user_code)) {
            $user_code = $this->session->userdata('user_id');
        }

        list($fromDate, $toDate) = explode(' | ', $this->input->get('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
      
        $customerName = trim($this->input->get('customerName'));
        if ($customerName == "") {
            $customerName = "NA";
        } else {
            $customerName = strtolower($customerName);
            $customerName = preg_replace('/\s+/', '', $customerName);
            $customerName = $customerName . '%';
        }

        $data = array(
            'queryCode' => 'RQG6PLX8',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'userCode' => $user_code,
            'paymentStatusCode' => $this->input->get('payStatus'),
            'cargoStatusCode' => $this->input->get('cargoStatus') ?: 'NA',
            'fromStationCode' => $this->input->get('fromStation'),
            'toStationCode' => $this->input->get('toStation'),
            'organizationCode' => $this->input->get('organizationCode')?: 'NA',
            'customerName' => $customerName,
            'groupCode' => $this->input->get('groupCode') ?: 'NA',
            'stateCode' => $this->input->get('stateCode') ?: 'NA',
            'filterType' => 'DETAILS',
        );

        if (!has_action_rights('CGO-DBR-USER-FLTR')) {
            $data['userCode'] = $this->session->userdata('user_id');
        }

        $data['stationCode'] = 'NA';

        //  access same branch LR only
        if (has_action_rights('CGO-VIEW-SAME-BRNCH-LR')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }
        //  access same station LR only
        if (has_action_rights('CGO-VIEW-SAME-STION-LR')) {
            $data['stationCode'] = $this->session->userdata('org_station_code');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $groupBy = $this->input->get('groupBy');
        if ($groupBy == "SUMMARY") {
            $this->booking_report_summary($result->data);
            return;
        }

        $amounts = array();
        $summary = array();
        foreach ($result->data as $row) {
            if ($row->cargo_status_code == 'CA' || $row->cargo_status_code == 'CR') {
                continue;
            }
            $amounts['netpayable'] = $amounts['netpayable'] + $row->connecting_charge + $row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount;
            $amounts['handling'] = $amounts['handling'] + $row->total_handling_amount;
            $amounts['freight'] = $amounts['freight'] + $row->total_amount;
            $amounts['unloading'] = $amounts['unloading'] + $row->total_unload_handling_amount;
            $amounts['gst'] = $amounts['gst'] + $row->service_tax;
            $amounts['pickup'] = $amounts['pickup'] + $row->pickup_handling_amount;
            $amounts['delivery'] = $amounts['delivery'] + $row->delivery_handling_amount;
            $amounts['service_charge'] = $amounts['service_charge'] + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge+$row->service_tax + $row->other_charges_amount;
            $amounts['connecting'] = $amounts['connecting'] + $row->connecting_charge;

            $amounts['commission'] = $amounts['commission'] + $row->commission_amount;
            $amounts['handling_commission'] = $amounts['handling_commission'] + $row->handling_commission_amount;

            if ($row->payment_status_code == 'INP' || $row->payment_status_code == 'OATP') {
                $amounts['invoicepay'] = $amounts['invoicepay'] + (($row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount) - $row->transaction_amount);
            } elseif ($row->payment_status_code == 'TOP') {
                $amounts['topay'] = $amounts['topay'] + (($row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount));
            } else {
                $amounts['paid'] = $amounts['paid'] + $row->transaction_amount;
            }
            $amounts['lr_qtycount'] += $row->total_item_count;
            $amounts['lr_count']++;

            $summary[$row->payment_status_code]['freight'] += $row->total_amount;
            $summary[$row->payment_status_code]['qtycount'] += $row->total_item_count;
            $summary[$row->payment_status_code]['count'] += 1;
        }
        $cfgPayStatus = config_item('cargo_payment_status');
        if ($groupBy == "PAYTYPE") {
            $arr = array();
            $print = $this->input->get('print');
            $printPaid = $this->input->get('printPaid');
            $printToPay = $this->input->get('printToPay');

            if ($print == 1 && $printPaid == 1) {
                foreach ($result->data as $row) {
                    if ($row->payment_status_code == 'PAD' || $row->payment_status_code == 'FS' || $row->payment_status_code == 'TPPAD') {
                        $arr[$cfgPayStatus[$row->payment_status_code]][] = $row;
                    }
                }
            } else if ($print == 1 && $printToPay == 1) {
                foreach ($result->data as $key => $row) {
                    if ($row->payment_status_code == 'TOP' || $row->payment_status_code == 'INP' || $row->payment_status_code == 'OATP') {
                        $arr[$cfgPayStatus[$row->payment_status_code]][] = $row;
                    }
                }
            } else {
                foreach ($result->data as $row) {
                    $arr[$cfgPayStatus[$row->payment_status_code]][] = $row;
                }
            }
            $data['result'] = $arr;
        }
        ksort($summary);
        $data['amounts'] = $amounts;
        $data['summary'] = $summary;
        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');
        $data['namespaceCode'] = $this->session->userdata('namespace_id');
        $data['from_date'] = $from_date;
        $data['to_date'] = $to_date;
        $Report_filter =$this->input->get('Report_filter')?$this->input->get('Report_filter'):"BOOKING";
        
        if($Report_filter =="BOOKING"){
            if ($this->input->get('export') == 1 && $this->session->userdata('namespace_id') == "panindia") {
                $filename = lang('lr') . '-booking-report';
                $this->load->excel('site/cargo/booking-report-list-pan-xls', $data, $filename);
            } else if ($this->input->get('export') == 1 )  {
                $filename = lang('lr') . '-booking-report';
                $this->load->excel('site/cargo/booking-report-list-xls', $data, $filename);
            } else if ($this->input->get('print') == 1) {
                $this->load->exclude_template();
                $this->load->view('site/cargo/booking-report-list-print', $data);
            } else {
                $this->load->view('site/cargo/booking-report-list', $data);
            }
        }else{
            if ($this->input->get('export') == 1 )  {
                $filename = lang('lr') . '-organizationwise-report';
                $this->load->excel('site/cargo/organizationwise-report-list-xls', $data, $filename);
            }else{
                $this->load->view('site/cargo/organizationwise-report-list', $data);
            }
            
        }
       
    }

    public function booking_report_list_v2() {
        $this->is_logged_in();

        $user_code = $this->input->get('userCode');
        if (empty($user_code)) {
            $user_code = $this->session->userdata('user_id');
        }

        list($fromDate, $toDate) = explode(' | ', $this->input->get('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
    
        $customerName = trim($this->input->get('customerName'));
        if ($customerName == "") {
            $customerName = "NA";
        } else {
            $customerName = strtolower($customerName);
            $customerName = preg_replace('/\s+/', '', $customerName);
            $customerName = $customerName . '%';
        }

        $data = array(
            'queryCode' => 'RQO2AKO64',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'userCode' => $user_code,
            'paymentStatusCode' => $this->input->get('payStatus'),
            'cargoStatusCode' => $this->input->get('cargoStatus') ?: 'NA',
            'fromStationCode' => $this->input->get('fromStation'),
            'toStationCode' => $this->input->get('toStation'),
            'organizationCode' => $this->input->get('organizationCode')?: 'NA',
            'customerName' => $customerName,
            'groupCode' => $this->input->get('groupCode') ?: 'NA',
            'stateCode' => $this->input->get('stateCode') ?: 'NA',
            'filterType' => 'DETAILS',
        );

        if (!has_action_rights('CGO-DBR-USER-FLTR')) {
            $data['userCode'] = $this->session->userdata('user_id');
        }

        $data['stationCode'] = 'NA';

        //  access same branch LR only
        if (has_action_rights('CGO-VIEW-SAME-BRNCH-LR')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }
        //  access same station LR only
        if (has_action_rights('CGO-VIEW-SAME-STION-LR')) {
            $data['stationCode'] = $this->session->userdata('org_station_code');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $groupBy = $this->input->get('groupBy');
        if ($groupBy == "SUMMARY") {
            $this->booking_report_summary($result->data);
            return;
        }

        $summary = array();
        foreach ($result->data as $row) {
            if ($row->cargo_status_code == 'CA' || $row->cargo_status_code == 'CR') {
                continue;
            }

            $summary[$row->payment_status_code]['code'] = $row->payment_status_code;
            $summary[$row->payment_status_code]['freight'] += $row->total_amount;
            $summary[$row->payment_status_code]['handling'] += $row->total_handling_amount;
            $summary[$row->payment_status_code]['unloading'] +=$row->total_unload_handling_amount;
            $summary[$row->payment_status_code]['gst'] +=$row->service_tax;
            $summary[$row->payment_status_code]['pickup'] +=$row->pickup_handling_amount;
            $summary[$row->payment_status_code]['delivery'] += $row->delivery_handling_amount;
            $summary[$row->payment_status_code]['connecting'] += $row->connecting_charge;
            $summary[$row->payment_status_code]['service_charge'] += $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge+$row->service_tax + $row->other_charges_amount;
            $summary[$row->payment_status_code]['payable'] +=$row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount+$row->total_amount+$row->connecting_charge;
            $summary[$row->payment_status_code]['commission'] +=  $row->commission_amount;
            $summary[$row->payment_status_code]['handling_commission'] +=$row->handling_commission_amount;
            $summary[$row->payment_status_code]['t_freight'] += $row->total_amount;
            $summary[$row->payment_status_code]['t_qtycount'] += $row->total_item_count;
            $summary[$row->payment_status_code]['t_count'] += 1;
            $summary[$row->payment_status_code]['t_Share'] +=$row->handling_commission_amount;
            $summary[$row->payment_status_code]['t_commision'] +=$row->commission_amount-$row->handling_commission_amount;
        }

        $cfgPayStatus = config_item('cargo_payment_status');

        if ($groupBy == "PAYTYPE") {
            $arr = array();
            $print = $this->input->get('print');
            $printPaid = $this->input->get('printPaid');
            $printToPay = $this->input->get('printToPay');

            if ($print == 1 && $printPaid == 1) {
                foreach ($result->data as $row) {
                    if ($row->payment_status_code == 'PAD' || $row->payment_status_code == 'FS' || $row->payment_status_code == 'TPPAD') {
                        $arr[$cfgPayStatus[$row->payment_status_code]][] = $row;
                    }
                }
            } else if ($print == 1 && $printToPay == 1) {
                foreach ($result->data as $key => $row) {
                    if ($row->payment_status_code == 'TOP' || $row->payment_status_code == 'INP' || $row->payment_status_code == 'OATP') {
                        $arr[$cfgPayStatus[$row->payment_status_code]][] = $row;
                    }
                }
            } else {
                foreach ($result->data as $row) {
                    $arr[$cfgPayStatus[$row->payment_status_code]][] = $row;
                }
            }
            $data['result'] = $arr;
        }
        $data['amounts'] = $amounts;
        $data['summary'] = $summary;
        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');
        $data['namespaceCode'] = $this->session->userdata('namespace_id');
        $data['from_date'] = $from_date;
        $data['to_date'] = $to_date;

        if ($this->input->get('export') == 1 )  {
            $filename = lang('lr') . '-booking-report-v2';
            $this->load->excel('site/cargo/booking-report-list-v2-xls', $data, $filename);
        }  else {
            $this->load->view('site/cargo/booking-report-list-v2', $data);
        }
    }
    public function delivery_report_list_v2() {

        $this->is_logged_in();

        $user_code = $this->input->get('userCode');
        if (empty($user_code)) {
            $user_code = $this->session->userdata('user_id');
        }

        list($fromDate, $toDate) = explode(' | ', $this->input->get('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
    
        $customerName = trim($this->input->get('customerName'));
        if ($customerName == "") {
            $customerName = "NA";
        } else {
            $customerName = strtolower($customerName);
            $customerName = preg_replace('/\s+/', '', $customerName);
            $customerName = $customerName . '%';
        }

        $data = array(
            'queryCode' => 'RQO2AKO65',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'userCode' => $user_code,
            'paymentStatusCode' => $this->input->get('payStatus'),
            'fromStationCode' => $this->input->get('fromStation'),
            'toStationCode' => $this->input->get('toStation'),
            'deliveredUser' => 'NA',
            'deliveryType' => 'NA',
            'deliveryStatusTypeCode' => 'NA',
            'filterType' => 'DETAILS',
        );

        if (!has_action_rights('CGO-DBR-USER-FLTR')) {
            $data['userCode'] = $this->session->userdata('user_id');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $groupBy = $this->input->get('groupBy');
        if ($groupBy == "SUMMARY") {
            $this->booking_report_summary($result->data);
            return;
        }

        $summary = array();
        foreach ($result->data as $row) {
            if ($row->cargo_status_code == 'CA' || $row->cargo_status_code == 'CR') {
                continue;
            }

            $summary[$row->payment_status_code]['code'] = $row->payment_status_code;
            $summary[$row->payment_status_code]['freight'] += $row->total_amount;
            $summary[$row->payment_status_code]['handling'] += $row->total_handling_amount;
            $summary[$row->payment_status_code]['unloading'] +=$row->total_unload_handling_amount;
            $summary[$row->payment_status_code]['gst'] +=$row->service_tax;
            $summary[$row->payment_status_code]['pickup'] +=$row->pickup_handling_amount;
            $summary[$row->payment_status_code]['delivery'] += $row->delivery_handling_amount;
            $summary[$row->payment_status_code]['connecting'] += $row->connecting_charge;
            $summary[$row->payment_status_code]['service_charge'] += $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge+$row->service_tax + $row->other_charges_amount;
            $summary[$row->payment_status_code]['payable'] +=$row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount+$row->total_amount+$row->connecting_charge;
            $summary[$row->payment_status_code]['commission'] +=  $row->commission_amount;
            $summary[$row->payment_status_code]['handling_commission'] +=$row->handling_commission_amount;
            $summary[$row->payment_status_code]['t_freight'] += $row->total_amount;
            $summary[$row->payment_status_code]['t_qtycount'] += $row->total_item_count;
            $summary[$row->payment_status_code]['t_count'] += 1;
            $summary[$row->payment_status_code]['t_Share'] +=$row->handling_commission_amount;
            $summary[$row->payment_status_code]['t_commision'] +=$row->commission_amount-$row->handling_commission_amount;
        }

        $cfgPayStatus = config_item('cargo_payment_status');

        if ($groupBy == "PAYTYPE") {
            $arr = array();
            $print = $this->input->get('print');
            $printPaid = $this->input->get('printPaid');
            $printToPay = $this->input->get('printToPay');

            if ($print == 1 && $printPaid == 1) {
                foreach ($result->data as $row) {
                    if ($row->payment_status_code == 'PAD' || $row->payment_status_code == 'FS' || $row->payment_status_code == 'TPPAD') {
                        $arr[$cfgPayStatus[$row->payment_status_code]][] = $row;
                    }
                }
            } else if ($print == 1 && $printToPay == 1) {
                foreach ($result->data as $key => $row) {
                    if ($row->payment_status_code == 'TOP' || $row->payment_status_code == 'INP' || $row->payment_status_code == 'OATP') {
                        $arr[$cfgPayStatus[$row->payment_status_code]][] = $row;
                    }
                }
            } else {
                foreach ($result->data as $row) {
                    $arr[$cfgPayStatus[$row->payment_status_code]][] = $row;
                }
            }
            $data['result'] = $arr;
        }
        $data['amounts'] = $amounts;
        $data['summary'] = $summary;
        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');
        $data['namespaceCode'] = $this->session->userdata('namespace_id');
        $data['from_date'] = $from_date;
        $data['to_date'] = $to_date;

        if ($this->input->get('export') == 1 )  {
            $filename = lang('lr') . '-delivery-report-v2';
            $this->load->excel('site/cargo/delivery-report-list-v2-xls', $data, $filename);
        }  else {
            $this->load->view('site/cargo/delivery-report-list-v2', $data);
        }
    }

    public function booking_report_list_tally() {
        $this->is_logged_in();
        $this->load->library('excel');
        $this->excel->getProperties()->setCreator("Ezee")
                                    ->setLastModifiedBy("Ezee")
                                    ->setTitle("Booking List")
                                    ->setSubject("Booking List")
                                    ->setDescription("Booking List.")
                                    ->setKeywords("Booking List")
                                    ->setCategory("Tally");
                                    $this->excel->setActiveSheetIndex(0);
                                    $this->excel->getActiveSheet()->setTitle('Booking');
                                    $this->excel->getActiveSheet()->getStyle('A1:AD1')->getFont()->setBold(true);
        $this->excel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('B')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('C')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('D')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('E')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('F')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('G')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('H')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('I')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('J')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('K')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('L')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('M')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('N')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('O')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('P')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('Q')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('R')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('S')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('T')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('U')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('V')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('W')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('X')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('Y')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('Z')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('AA')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('AB')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('AC')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('AD')->setAutoSize(true);

        $user_code = $this->input->get('userCode');
        if (empty($user_code)) {
            $user_code = $this->session->userdata('user_id');
        }

 
        list($fromDate, $toDate) = explode(' | ', $this->input->get('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
   

        $customerName = trim($this->input->get('customerName'));
        if ($customerName == "") {
            $customerName = "NA";
        } else {
            $customerName = strtolower($customerName);
            $customerName = preg_replace('/\s+/', '', $customerName);
            $customerName = $customerName . '%';
        }
        
        $data = array(
            'queryCode' => 'RQG6PLX8',
            'fromDate' => $from_date,
            'toDate' => $to_date,
            'userCode' => $user_code,
            'paymentStatusCode' => $this->input->get('payStatus'),
            'cargoStatusCode' => $this->input->get('cargoStatus') ?: 'NA',
            'fromStationCode' => $this->input->get('fromStation'),
            'toStationCode' => $this->input->get('toStation'),
            'organizationCode' => $this->input->get('organizationCode')?: 'NA',
            'customerName' => $customerName,
            'groupCode' => $this->input->get('groupCode') ?: 'NA',
            'stateCode' => $this->input->get('stateCode') ?: 'NA',
            'filterType' => 'TALLY_REPORT',
        );

        if (!has_action_rights('CGO-DBR-USER-FLTR')) {
            $data['userCode'] = $this->session->userdata('user_id');
        }

        $data['stationCode'] = 'NA';

        if (has_action_rights('CGO-VIEW-SAME-BRNCH-LR')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }
        if (has_action_rights('CGO-VIEW-SAME-STION-LR')) {
            $data['stationCode'] = $this->session->userdata('org_station_code');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        $dataum = array();
        if ($result->status == 1) {
            if (is_array($result->data)) {
                $i = 0;
                while ($i < count($result->data)) {
                    $items = 0;
                    $case_received = 0;
                    $freight_paid = 0;
                    $load_paid = 0;
                    $pickup_paid = 0;
                    $docket_paid = 0;
                    $Roundoff_paid = 0;
                    $connect_paid = 0;
                    $total_paid = 0;

                    $paid_round_off_val =0;
                    $topay_round_off_val =0;

                    $freight_topay = 0;
                    $load_topay = 0;
                    $pickup_topay = 0;
                    $docket_topay = 0;
                    $Roundoff_topay = 0;
                    $connect_topay = 0;
                    $total_topay = 0;
        
                    $freight_Onaccount = 0;
                    $load_Onaccount = 0;
                    $pickup_Onaccount = 0;
                    $docket_Onaccount = 0;
                    $Roundoff_Onaccount = 0;
                    $connect_Onaccount = 0;
                    $total_Onaccount = 0;
        
                    $freight_Onaccount_toPay = 0;
                    $load_Onaccount_toPay = 0;
                    $pickup_Onaccount_toPay = 0;
                    $docket_Onaccount_toPay = 0;
                    $Roundoff_Onaccount_toPay = 0; 
                    $connect_Onaccount_toPay = 0;
                    $total_Onaccount_toPay = 0;
        
                    $payment_mode = "";
                    $cargo_codes = "";
                    $from = $result->data[$i]->from_organization_name;
                    $to = $result->data[$i]->to_organization_name;
                    $from_short_code = $result->data[$i]->from_organization_short_code;
                    $to_short_code = $result->data[$i]->to_organization_short_code;
                    $username = $result->data[$i]->user_first_name;
                    $booked_at = $result->data[$i]->booked_at;
                    $cgst_paid = 0;
                    $sgst_paid = 0;
                    $igst_paid = 0;
                    
                    $cgst_topay = 0;
                    $sgst_topay = 0;
                    $igst_topay = 0;
        
                    do {
                        $items += $result->data[$i]->total_item_count;
                     
                        if ($result->data[$i]->payment_status_code == "PAD") {
                            if ($result->data[$i]->transaction_mode != null) {
                                $payment_mode = $payment_mode . $result->data[$i]->transaction_mode .",";
                            }
                            if($result->data[$i]->from_customer_gst =='' && $result->data[$i]->to_customer_gst !==''){
                                $cgst_paid += $result->data[$i]->cgst_amount;
                                $sgst_paid += $result->data[$i]->sgst_amount;  
                                $igst_paid += $result->data[$i]->igst_amount;
                            }
                            
                           
                            $cargo_codes = $cargo_codes . $result->data[$i]->cargo_code .",";
                            $case_received += $result->data[$i]->total_amount_paid;
                            $freight_paid += $result->data[$i]->total_amount;
                            $load_paid += $result->data[$i]->total_handling_amount;
                            $pickup_paid += $result->data[$i]->pickup_handling_amount;
                            $docket_paid +=($result->data[$i]->docket_charge +$result->data[$i]->round_off_value);
                            $Roundoff_paid += $result->data[$i]->round_off_value;
                            $connect_paid += $result->data[$i]->connecting_charge;
                            $total_paid += ($result->data[$i]->connecting_charge + $result->data[$i]->docket_charge +$result->data[$i]->pickup_handling_amount +$result->data[$i]->total_handling_amount+$result->data[$i]->total_amount+$result->data[$i]->round_off_value);
                            $paid_round_off_val +=($result->data[$i]->round_off_value);

                        } elseif ($result->data[$i]->payment_status_code == "TOP") {
                            if ($result->data[$i]->transaction_mode != null) {
                                $payment_mode = $payment_mode  . $result->data[$i]->transaction_mode .",";
                            }

                            if($result->data[$i]->from_customer_gst !=='' && $result->data[$i]->to_customer_gst ==''){
                                $cgst_topay += $result->data[$i]->cgst_amount;
                                $sgst_topay += $result->data[$i]->sgst_amount;
                                $igst_topay += $result->data[$i]->igst_amount;
                            }

                            $cargo_codes = $cargo_codes . $result->data[$i]->cargo_code .",";
                            $case_received += $result->data[$i]->total_amount_paid;
                            $freight_topay += $result->data[$i]->total_amount;
                            $load_topay += $result->data[$i]->total_handling_amount;
                            $pickup_topay += $result->data[$i]->pickup_handling_amount;
                            $docket_topay +=($result->data[$i]->docket_charge+$result->data[$i]->round_off_value);
                            $Roundoff_topay += $result->data[$i]->round_off_value;
                            $connect_topay += $result->data[$i]->connecting_charge;
                            $total_topay += ($result->data[$i]->connecting_charge + $result->data[$i]->docket_charge +$result->data[$i]->pickup_handling_amount +$result->data[$i]->total_handling_amount+$result->data[$i]->total_amount+$result->data[$i]->round_off_value);
                            $topay_round_off_val +=($result->data[$i]->round_off_value);
                            
                        } elseif ($result->data[$i]->payment_status_code == "INP") {
                            if ($result->data[$i]->transaction_mode != null) {
                                $payment_mode = $payment_mode . $result->data[$i]->transaction_mode."," ;
                            }
                            $cargo_codes = $cargo_codes . $result->data[$i]->cargo_code .",";
                            // $case_received += $result->data[$i]->total_amount_paid;
                            $freight_Onaccount += $result->data[$i]->total_amount;
                            $load_Onaccount += $result->data[$i]->total_handling_amount;
                            $pickup_Onaccount += $result->data[$i]->pickup_handling_amount;
                            $docket_Onaccount += $result->data[$i]->docket_charge;
                            $Roundoff_Onaccount += $result->data[$i]->round_off_value;
                            $connect_Onaccount += $result->data[$i]->connecting_charge;
                            $total_Onaccount += ($result->data[$i]->connecting_charge + $result->data[$i]->docket_charge +$result->data[$i]->hamali_charge +$result->data[$i]->total_handling_amount+$result->data[$i]->total_amount);
        
                        } else {
                            if ($result->data[$i]->transaction_mode != null) {
                                $payment_mode = $payment_mode . $result->data[$i]->transaction_mode .",";
                            }
                            $cargo_codes = $cargo_codes . $result->data[$i]->cargo_code .",";
                            // $case_received += $result->data[$i]->total_amount_paid;
                            $freight_Onaccount_toPay += $result->data[$i]->total_amount;
                            $load_Onaccount_toPay += $result->data[$i]->total_handling_amount;
                            $pickup_Onaccount_toPay += $result->data[$i]->pickup_handling_amount;
                            $docket_Onaccount_toPay += $result->data[$i]->docket_charge;
                            $Roundoff_Onaccount_toPay += $result->data[$i]->round_off_value;
                            $connect_Onaccount_toPay += $result->data[$i]->connecting_charge;
                            $total_Onaccount_toPay += ($result->data[$i]->connecting_charge + $result->data[$i]->docket_charge +$result->data[$i]->hamali_charge +$result->data[$i]->total_handling_amount+$result->data[$i]->total_amount);
                        }
        
                        $i += 1;
                    } while (
                        (substr($result->data[$i]->bookedAt, 0, 10) == substr($result->data[$i - 1]->bookedAt, 0, 10)) &&
                        ($result->data[$i]->user_code == $result->data[$i - 1]->user_code) &&
                        ($result->data[$i]->from_organization_short_code == $result->data[$i - 1]->from_organization_short_code) &&
                        ($result->data[$i]->to_organization_short_code == $result->data[$i - 1]->to_organization_short_code)
                    );
        
                    $tempObj = new stdClass();
                    $tempObj->booked_at = $booked_at;
                    $tempObj->from = $from;
                    $tempObj->fromCode = $from_short_code;
                    $tempObj->to = $to;
                    $tempObj->toCode = $to_short_code;
                    $tempObj->username = $username;
                    $tempObj->no_of_items = $items;
                    $tempObj->cgst = $cgst;
                    $tempObj->igst = $igst;
                    $tempObj->sgst = $sgst;
                    $tempObj->freight_paid = $freight_paid;
                    $tempObj->load_paid = $load_paid;
                    $tempObj->pickup_paid = $pickup_paid;
                    $tempObj->docket_paid = $docket_paid;
                    $tempObj->Roundoff_paid = $Roundoff_paid;
                    $tempObj->connect_paid = $connect_paid;
                    $tempObj->total_paid = $total_paid;
                    $tempObj->freight_topay = $freight_topay;
                    $tempObj->load_topay = $load_topay;
                    $tempObj->pickup_topay = $pickup_topay;
                    $tempObj->docket_topay = $docket_topay;
                    $tempObj->Roundoff_topay = $Roundoff_topay;
                    $tempObj->connect_topay = $connect_topay;
                    $tempObj->total_topay = $total_topay;
                    $tempObj->payment_mode = $payment_mode;
                    $tempObj->case_received = $case_received;
                    $tempObj->cargo_codes = $cargo_codes;
                    $tempObj->topay_round_off_val = $topay_round_off_val;
                    $tempObj->paid_round_off_val = $paid_round_off_val;

                    $tempObj->cgst_paid = $cgst_paid;
                    $tempObj->sgst_paid = $sgst_paid;
                    $tempObj->igst_paid = $igst_paid;
                    $tempObj->cgst_topay = $cgst_topay;     
                    $tempObj->sgst_topay = $sgst_topay;
                    $tempObj->igst_topay = $igst_topay;

                    array_push($dataum, $tempObj);
                }
            }
        }
        $data['dataum'] = $dataum;
        $groupBy = $this->input->get('groupBy');
        if ($groupBy == "SUMMARY") {
            $this->booking_report_summary($result->data);
            return;
        }
        
        $this->excel->getActiveSheet()->setCellValue('A1', 'FROMSECT');
        $this->excel->getActiveSheet()->setCellValue('B1', 'FSECTID');
        $this->excel->getActiveSheet()->setCellValue('C1', 'BOOKEDBY');
        $this->excel->getActiveSheet()->setCellValue('D1', 'TOSECT');
        $this->excel->getActiveSheet()->setCellValue('E1', 'TSECTID');
        $this->excel->getActiveSheet()->setCellValue('F1', 'BOOKDATE');
        $this->excel->getActiveSheet()->setCellValue('G1', 'GTOTQTY');
        $this->excel->getActiveSheet()->setCellValue('H1', 'GTOTFREPA');
        $this->excel->getActiveSheet()->setCellValue('I1', 'GTOTFRETP');
        $this->excel->getActiveSheet()->setCellValue('J1', 'GTOTLOAPA');
        $this->excel->getActiveSheet()->setCellValue('K1', 'GTOTLOATP');
        $this->excel->getActiveSheet()->setCellValue('L1', 'GTOTPICPA');  
        $this->excel->getActiveSheet()->setCellValue('M1', 'GTOTPICTP');
        $this->excel->getActiveSheet()->setCellValue('N1', 'GTOTOBPA');
        $this->excel->getActiveSheet()->setCellValue('O1', 'GTOTOBTP');
        $this->excel->getActiveSheet()->setCellValue('P1', 'GTOTCONPA');
        $this->excel->getActiveSheet()->setCellValue('Q1', 'GTOTCONTP');
        $this->excel->getActiveSheet()->setCellValue('R1', 'GTOTPA');
        $this->excel->getActiveSheet()->setCellValue('S1', 'GTOTTP');  
        $this->excel->getActiveSheet()->setCellValue('T1', 'GTOTAMT');
        $this->excel->getActiveSheet()->setCellValue('U1', 'PACGST');
        $this->excel->getActiveSheet()->setCellValue('V1', 'TPCGST');
        $this->excel->getActiveSheet()->setCellValue('W1', 'PASGST');
        $this->excel->getActiveSheet()->setCellValue('X1', 'TPSGST');
        $this->excel->getActiveSheet()->setCellValue('Y1', 'PAIGST');
        $this->excel->getActiveSheet()->setCellValue('Z1', 'TPIGST');
        $this->excel->getActiveSheet()->setCellValue('AA1', 'GTORDOPA');
        $this->excel->getActiveSheet()->setCellValue('AB1', 'GTORDOTP');
        $this->excel->getActiveSheet()->setCellValue('AC1', 'PAYMENT MODE');
        $this->excel->getActiveSheet()->setCellValue('AD1', 'LR NO');

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($dataum);
                $row = 2;
                $col = 0;
                for ($i = 0; $i < $ticket_count; $i++) {
                    $t = $dataum[$i];


                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col, $row, $t->from);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->fromCode);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->username);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->to);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->toCode);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, date('d-m-Y', strtotime($t->booked_at)));
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row,  $t->no_of_items);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->freight_paid);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->freight_topay);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->load_paid);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->load_topay);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->pickup_paid);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->pickup_topay);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->docket_paid);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->docket_topay);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->connect_paid);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->connect_topay);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->total_paid);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->total_topay);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->case_received);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->cgst_paid);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->cgst_topay);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->sgst_paid);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->sgst_topay);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->igst_paid);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->igst_topay);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->paid_round_off_val);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->topay_round_off_val);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->payment_mode); 
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->cargo_codes);                         
                    $col = 0;
                    $row++;
                }
            }
        }

        $filename = 'Booking-'.$from_date.' TO '.$to_date.'.xls';
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="'.$filename.'"');
        header('Cache-Control: max-age=0');
        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
        $objWriter->save('php://output');
    }

    private function booking_report_summary($result = []) {
        $summary = [];

        foreach ($result as $row) {
            $branch = $row->from_organization_name;
            $station = $row->to_station_name;

            $othercharges = $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount;
            $totalamount = $row->total_amount + $othercharges;
            $amt = $totalamount - $row->transaction_amount;

            $row->net_amount_computed = $totalamount;
            $row->other_charges_computed = $othercharges;

            // Branch wise
            if (!isset($summary[$branch])) {
                $summary[$branch] = (object)[];
            }

            $summ = $summary[$branch];
            $summ->stations = $summ->stations ?: [];
            $summ->name = $branch;
            $summ->total_lr_count += 1;
            $summ->total_item_count += $row->total_item_count;
            $summ->total_amount += $row->total_amount;
            $summ->other_charges_amount += $othercharges;

            if ($row->payment_status_code == 'INP' || $row->payment_status_code == 'OATP') {
                $summ->onaccount_amount += $amt;
            } elseif ($row->payment_status_code == 'TOP') {
                $summ->topay_amount += $totalamount;
            } else {
                $summ->paid_amount += $totalamount;
            }

            // Station wise
            if (!isset($summ->stations[$station])) {
                $summ->stations[$station] = (object)[];
            }
            $summ = $summ->stations[$station];
            $summ->name = $station;
            $summ->total_lr_count += 1;
            $summ->total_item_count += $row->total_item_count;
            $summ->total_amount += $row->total_amount;
            $summ->other_charges_amount += $othercharges;

            if ($row->payment_status_code == 'INP' || $row->payment_status_code == 'OATP') {
                $summ->onaccount_amount += $amt;
            } elseif ($row->payment_status_code == 'TOP') {
                $summ->topay_amount += $totalamount;
            } else {
                $summ->paid_amount += $totalamount;
            }

            $summ->bookings = $summ->bookings ?: [];
            $summ->bookings[] = $row;
        }

        $data = [];
        $data['summary'] = $summary;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->get('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/booking-report-summary-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=' . lang('lr') . '-booking-report-summary.xls');
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
            $this->load->view('site/cargo/booking-report-summary', $data);
        }
    }

    public function delivery_report() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $data['groupusers'] = get_active_group_and_users();
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_report_type'] = config_item('delivery_report_type');
        $data['delivery_filter_type_seenu'] = config_item('delivery_filter_type_seenu');
        
        $data['user_station_code'] = $this->session->userdata('org_station_code');
        $data['user_login_code'] = $this->session->userdata('user_id');

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
                'userlist' => $Groupuser->data
            );
        }
        $data['entity'] = $tmp;

        $cargoremarks = $this->api_model->getCargoRemarks();
        $cargoremarks = json_decode($cargoremarks);
        $data['cargoremarks'] = $cargoremarks->data;
        
        $this->load->view('site/cargo/delivery-report', $data);
    }

    public function delivery_report_list() {
        $this->is_logged_in();

        $user_code = $this->input->post('userCode');
        if (empty($user_code)) {
            $user_code = 'NA';
        }

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
            $from_date = date('Y-m-d', strtotime($fromDate));
            $to_date = date('Y-m-d', strtotime($toDate));

        $deliveryType = $this->input->post('deliveryType');
        $deliveryStatusTypeCode = '';
        if ($deliveryType == 'DR_DLRY_STS') {
            $deliveryStatusTypeCode = $this->input->post('deliveryStatusTypeCode');
        }
        $data = array(
            'queryCode' => 'RQG6PLY9',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'userCode' => $user_code,
            'paymentStatusCode' => $this->input->post('payStatus'),
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'deliveredUser' => $this->input->post('deliveredUser')?: $this->session->userdata('user_id'),
            'deliveryType' => $deliveryType,
            'deliveryStatusTypeCode' => $deliveryStatusTypeCode ?: 'NA',
            'filterType' => 'DETAILS',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        
        $userBranch = $this->api_model->getUserBrancheDetails(array('userCode' =>$this->input->post('deliveredUser')));
        $userBranch = json_decode($userBranch);
        $data['userBranch'] =$userBranch->data->organization->name;

        if($this->input->post('deliveredUser')=="NA" ||$this->input->post('deliveredUser')==null){
            $OrgBranchCode =$this->session->userdata('org_code');
        }else{
            $OrgBranchCode =$userBranch->data->organization->code;
        }

        $organizationDetails = $this->api_model->getOrganizationDetails(array('organizationcode' =>$OrgBranchCode));
        $organizationDetails = json_decode($organizationDetails);
        $data['userBranchAddress'] = $organizationDetails->data[0];
        
        $amounts = array();
        $payment_details = array();
        $delivery_details = array();
        foreach ($result->data as $row) {
            if ($row->cargo_status_code == 'CA' || $row->cargo_status_code == 'CR') {
                continue;
            }
            $amounts['netpayable'] = $amounts['netpayable'] + $row->connecting_charge + $row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->service_tax + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->other_charges_amount;
            $amounts['handling'] = $amounts['handling'] + $row->total_handling_amount;
            $amounts['freight'] = $amounts['freight'] + $row->total_amount;
            $amounts['unloading'] = $amounts['unloading'] + $row->total_unload_handling_amount;
            $amounts['gst'] = $amounts['gst'] + $row->service_tax;
            $amounts['pickup'] = $amounts['pickup'] + $row->pickup_handling_amount;
            $amounts['delivery'] = $amounts['delivery'] + $row->delivery_handling_amount;
            $amounts['paid'] = $amounts['paid'] + $row->transaction_amount;;
            $amounts['service_charge'] = $amounts['service_charge'] + $row->service_charge + $row->other_charges_amount;
            $amounts['topay'] = $amounts['topay'] + ($row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount) - $row->transaction_amount;
            $amounts['connecting']  = $amounts['connecting'] + $row->connecting_charge;

            $payment_details[$row->payment_status_code]['count'] += 1;
            $payment_details[$row->payment_status_code]['amount'] += $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount;

            if ($row->payment_settlement_flag == 1) {
                $payment_details[$row->payment_status_code]['paid_count'] += 1;
                $payment_details[$row->payment_status_code]['paid_amt'] += $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount;
            } else {
                $payment_details[$row->payment_status_code]['pend_count'] += 1;
                $payment_details[$row->payment_status_code]['pending_amt'] += $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount;
            }

            $delivery_details[$row->delivery_type_code]['count'] += 1;
            $delivery_details[$row->delivery_type_code]['amount'] += $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount;
        }

        $data['amounts'] = $amounts;
        $data['payment_details'] = $payment_details;
        $data['delivery_details'] = $delivery_details;
        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');
        $data['fromDate'] =$from_date;
        $data['toDate']=$to_date;
        $data['filterType'] =$this->input->post('deliveryType');
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/delivery-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename= ' . lang('lr') . '-delivery-report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else if ($this->input->post('print') == 1) {
            $this->load->exclude_template();
                $this->load->view('site/cargo/POD-report-print-seenutransport', $data);
        } else {
            $this->load->view('site/cargo/delivery-report-list', $data);
        }
    }

    public function delivery_ledger_report(){
        $this->is_logged_in();
        $data = array();
        list($stations, $routes) = get_routes_and_stations();
    $data['stations'] = $stations;

    $branches = $this->api_model->getOrganization();
    $branches = json_decode($branches);
    $branches = $branches->data;

    $organization = array();
    foreach ($branches as $branch) {
        $organization[$branch->code] = $branch->name;
    }
    asort($organization);
    $data['branches'] = $organization;

    $data['cargo_status'] = config_item('cargo_status');
    $data['cargo_payment_status'] = config_item('cargo_payment_status');

        
        $this->load->view('site/cargo/delivery-ledger-report', $data);
}


public function delivery_ledger_report_list()
    {
        $this->is_logged_in();
        $user_code = $this->input->post('userCode');
        if (empty($user_code)) {
            $user_code = 'NA';
        }
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));



        $findOgplCode = $this->input->post('code');
        $ogplcargo = "";
        $odometer = "";

        if ($findOgplCode) {
            $dataum = array(
                'queryCode' => 'RQO36H763',
                'fromDate' => date('Y-m-d', strtotime($fromDate)),
                'toDate' => date('Y-m-d', strtotime($toDate)),
                'fromOrganizationCode' => $this->input->post('fromOrganizationCode'),
                'toOrganizationCode' => $this->input->post('toOrganizationCode'),
                'transitCode' => $findOgplCode,
                'filterType' => 'DETAILS'
            );

            $results = $this->api_model->getDynamicReportDataWithMap($dataum);
            $results = json_decode($results);
            // print_r($results);
            $singleOgpl = $results->data;

            
        $ogplcargo = $this->api_model->cargoOGPLDetails(array(
            'transitCode' =>  $findOgplCode
        ));
        $ogplcargo = json_decode($ogplcargo);
        $odometer = $this->api_model->getTransitOdometerDetails(array(
            'transitCode' =>  $findOgplCode
        ));
        $odometer = json_decode($odometer);

        }

        $data = array(
            'queryCode' => 'RQO36H763',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'fromOrganizationCode' => $this->input->post('fromOrganizationCode'),
            'toOrganizationCode' => $this->input->post('toOrganizationCode'),
            'transitCode' => 'NA',
            'filterType' => 'SUMMARY'
        );



        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $grouping = $result->data;
        $data['result'] = $result->data;
        $groupedOgpl = [];
        
        if($ogplcargo || $odometer){
            $data['ogplcargo'] = $ogplcargo->data->transitCargoDetails;
            $data['odometer'] = $odometer->data;
        }

        foreach ($grouping as $singleLr) {
            $ogpl = $singleLr->transit_code;
            $groupedOgpl[$ogpl][$singleLr->from_organization_code. '-' .$singleLr->to_organization_code] = $singleLr;
        }
        
        foreach ($grouping as $singleLr) {
            if ($singleLr->transit_code == $findOgplCode) {
                $data['ogplDetails'] =   $singleLr;
                $organizationCode = $singleLr->transit_to_organization_code;
                if($organizationCode){
                $organizationDetails = $this->api_model->getOrganizationDetails(array('organizationcode' =>$organizationCode));
                $organizationDetails = json_decode($organizationDetails);
                $data['organizationDetails']  = $organizationDetails->data;
                }
                break;
            }
        }
        $data['groupedOgpl'] = $groupedOgpl;


        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
        $usr_pro = json_decode($usr_pro);


        $organizationCode = $usr_pro->data->organization->code;
        $organizationDetails = $this->api_model->getOrganizationDetails(array('organizationcode' => $organizationCode));
        $organizationDetails = json_decode($organizationDetails);

        $amounts = array();
        $payment_details = array();
        $delivery_details = array();

        $data['fromDate'] = date('d-m-Y', strtotime($fromDate));
        $data['toDate'] = date('d-m-Y', strtotime($toDate));
        $data['user_profile'] = $usr_pro->data;
        $data['organizationDetails']  = $organizationDetails->data;


        foreach ($singleOgpl as $row) {
            if ($row->cargo_status_code == 'CA' || $row->cargo_status_code == 'CR') {
                continue;
            }

            $payment_details[$row->payment_type_code]['count'] += 1;
            $payment_details[$row->payment_type_code]['amount'] += $row->total_transaction_amount;

            if ($row->payment_settlement_flag == 1) {
                $payment_details[$row->payment_type_code]['paid_count'] += 1;
                $payment_details[$row->payment_type_code]['paid_amt'] += $row->total_transaction_amount;
            } else {
                $payment_details[$row->payment_type_code]['pend_count'] += 1;
                $payment_details[$row->payment_type_code]['pending_amt'] +=  $row->total_transaction_amount;
            }
            $delivery_details[$row->delivery_type_code]['count'] += 1;
            $delivery_details[$row->delivery_type_code]['amount'] += $row->total_transaction_amount;
        
    }
    
        $data['singleOgpl'] = $singleOgpl;
        $data['payment_details'] = $payment_details;
        $data['delivery_details'] = $delivery_details;
        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/delivery-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename= ' . lang('lr') . '-delivery-report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;
        } else if ($this->input->post('print') == 1) {

            $this->load->exclude_template();
            if ($this->session->userdata('namespace_id') == "seenutrans" || $this->session->userdata('namespace_id') == "seenutransports") {
                $this->load->view('site/cargo/delivery-report-print-seenutransport', $data);
            } else {
                $this->load->view('site/cargo/delivery-report-print-seenutransport', $data);
            }
        } else {
            $this->load->view('site/cargo/delivery-ledger-report-list', $data);
        }
    }




    public function delivery_report_list_tally() {
        $this->is_logged_in();
        $this->load->library('excel');
        $this->excel->getProperties()->setCreator("Ezee")
                                    ->setLastModifiedBy("Ezee")
                                    ->setTitle("Delivery List")
                                    ->setSubject("Delivery List")
                                    ->setDescription("Delivery List.")
                                    ->setKeywords("Delivery List")
                                    ->setCategory("Tally");
                                    $this->excel->setActiveSheetIndex(0);
                                    $this->excel->getActiveSheet()->setTitle('Booking');
                                    $this->excel->getActiveSheet()->getStyle('A1:Z1')->getFont()->setBold(true);
        $this->excel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('B')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('C')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('D')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('E')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('F')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('G')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('H')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('I')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('J')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('K')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('L')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('M')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('N')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('O')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('P')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('Q')->setAutoSize(true);
       
        
        $user_code = $this->input->post('userCode');
        if (empty($user_code)) {
            $user_code = 'NA';
        }

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
            $from_date = date('Y-m-d', strtotime($fromDate));
            $to_date = date('Y-m-d', strtotime($toDate));

        $deliveryType = $this->input->post('deliveryType');
        $deliveryStatusTypeCode = '';
        if ($deliveryType == 'DR_DLRY_STS') {
            $deliveryStatusTypeCode = $this->input->post('deliveryStatusTypeCode');
        }
        $data = array(
            'queryCode' => 'RQG6PLY9',
            'fromDate' => $from_date,
            'toDate' => $to_date,
            'userCode' => $user_code,
            'paymentStatusCode' => $this->input->post('payStatus'),
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'deliveredUser' => $this->input->post('deliveredUser')?: $this->session->userdata('user_id'),
            'deliveryType' => $deliveryType,
            'deliveryStatusTypeCode' => $deliveryStatusTypeCode ?: 'NA',
            'filterType' => 'DETAILS',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        if (is_array($result->data)) {
            usort($result->data, function($a, $b) {
                return $a->loaded_at < $b->loaded_at ? -1 : 1;
            });
        }
        
        $data['result'] = $result->data;
        $dataum = array();
        if ($result->status == 1) {
            if (is_array($result->data)) {
                $i = 0;
                while ($i < count($result->data)) {
                    $freight_topay = 0;
                    $load_topay = 0;
                    $pickup_topay = 0;
                    $docket_topay = 0;
                    $hamali_topay = 0;
                    $total_unload_handling_amount = 0;
                    $total_topay = 0; 
                    $demurrage_charge = 0; 
                    $case_received=0;
                    // $case_receiveds=0;
                    $service_tax_charge=0;
                    $items =0;
                    $other_charge =0;
                    $unload_handling_amount=0;
                    $pickup_handling_amount=0;
                    // $pickup_handlings=0;
                    $round_off=0;
                    $door_delivery=0;
                    $connect_topay=0;
                    $payment_mode = "";
                        //  if ($result->data[$i]->loaded_at != null && $result->data[$i]->delivered_at != null &&  $result->data[$i]->transit_alias_code !=null) {
                    do {          
                        $from = $result->data[$i]->from_organization_name;
                        $to = $result->data[$i]->to_organization_name;
                        $from_short_code = $result->data[$i]->from_organization_short_code;
                        $to_short_code = $result->data[$i]->to_organization_short_code;
                        $username = $result->data[$i]->user_first_name;
                        $booked_at = $result->data[$i]->booked_at;
                                        $loaded_at = $result->data[$i]->loaded_at? $result->data[$i]->loaded_at :"NA";
                        $delivered_at = $result->data[$i]->delivered_at;
                        $ogpl_num = $result->data[$i]->transit_alias_code; 
                        
                        $other_charges_inner = new stdClass();
                        $charges = explode(",", $result->data[$i]->other_charges);
                        
                        foreach ($charges as $charge) {
                            $charges_inner = explode(":", $charge);
                            $other_charges_inner->{$charges_inner[0]} = $charges_inner[1];
                        }
                        if ($result->data[$i]->transaction_mode != null) {
                            $payment_mode = $payment_mode . $result->data[$i]->transaction_mode .",";
                        }
                        
                        $items += $result->data[$i]->total_item_count;
                        $case_received += $result->data[$i]->total_amount_paid;
                        $tt_othersChargers =$result->data[$i]->other_charges_amount;
                        $freight_topay += $result->data[$i]->total_amount;
                        $load_topay += $result->data[$i]->total_handling_amount;
                        $demurrage_charge += $other_charges_inner->demurrage_charge;
                        $hamali_topay += $other_charges_inner->hamali_charge;
                        $docket_topay += $other_charges_inner->docket_charge;
                        $connect_topay += $result->data[$i]->connecting_charge;
                        $other_charge += $result->data[$i]->service_charge+$result->data[$i]->round_off_value;
                        $service_tax_charge += $result->data[$i]->service_tax;
                        $door_delivery += $result->data[$i]->delivery_handling_amount;
                        $pickup_handling_amount += $result->data[$i]->pickup_handling_amount;
                        $round_off += $result->data[$i]->round_off_value;
                        $unload_handling_amount += $result->data[$i]->total_unload_handling_amount;
                        $total_Topay_amount +=($result->data[$i]->connecting_charge + $result->data[$i]->docket_charge +$result->data[$i]->total_handling_amount+$result->data[$i]->total_amount);
                        $i += 1;
                        } 
                        while (
                        (substr($result->data[$i]->loaded_at, 0, 10) == substr($result->data[$i - 1]->loaded_at, 0, 10)) &&
                        (substr($result->data[$i]->delivered_at, 0, 10) == substr($result->data[$i - 1]->delivered_at, 0, 10))&&
                        ($result->data[$i]->user_code == $result->data[$i - 1]->user_code) &&
                        ($result->data[$i]->from_organization_short_code == $result->data[$i - 1]->from_organization_short_code) &&
                        ($result->data[$i]->to_organization_short_code == $result->data[$i - 1]->to_organization_short_code)  &&
                        ($result->data[$i]->transit_alias_code == $result->data[$i - 1]->transit_alias_code) &&  ($result->data[$i]->payment_status_code == "TPPAD" && $result->data[$i]->loaded_at != null && $result->data[$i]->delivered_at != null  && $result->data[$i]->transit_alias_code != null)
                        );
                            $tempObj = new stdClass();
                            $tempObj->loaded_at = $loaded_at;
                            $tempObj->delivered_at= $delivered_at; 
                            $tempObj->from = $from;
                            $tempObj->fromCode = $from_short_code;
                            $tempObj->to = $to;
                            $tempObj->total_unloads = $unload_handling_amount;
                            $tempObj->door_delivery = $door_delivery;
                            $tempObj->toCode = $to_short_code;
                            $tempObj->ogpl_num = $ogpl_num;
                            $tempObj->username = $username;
                            $tempObj->no_of_items = $items;
                            $tempObj->topay = $freight_topay;
                            $tempObj->load_topay = $load_topay;
                            $tempObj->demurrage = $demurrage_charge;
                            $tempObj->hamali = $hamali_topay;
                            $tempObj->total_topay = $total_topay;
                            $tempObj->payment_mode = $payment_mode;
                            $tempObj->other_charge = $other_charge;
                            $tempObj->pickup_handling_amount = $pickup_handling_amount;
                            $tempObj->docket_topay = $docket_topay;
                            $tempObj->service_tax_charge = $service_tax_charge;
                            $tempObj->case_received = $case_received;
                            $tempObj->round_offs = $round_off;
                            $tempObj->tt_othersChargers=$tt_othersChargers;
                            $tempObj->total_Topay_amount=$total_Topay_amount;
                            array_push($dataum, $tempObj);
                        
                    }
                }
            }
        $data['dataum'] = $dataum;

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;
        
        $this->excel->getActiveSheet()->setCellValue('A1', 'FROMSECT');
        $this->excel->getActiveSheet()->setCellValue('B1', 'FSECTID');
        $this->excel->getActiveSheet()->setCellValue('C1', 'TOSECT');
        $this->excel->getActiveSheet()->setCellValue('D1', 'TSECTID');
        $this->excel->getActiveSheet()->setCellValue('E1', 'BOOKEDBY');
        $this->excel->getActiveSheet()->setCellValue('F1', 'DELIDATE');
        $this->excel->getActiveSheet()->setCellValue('G1', 'OGPLDATE');
        $this->excel->getActiveSheet()->setCellValue('H1', 'OGPLNUM');
        $this->excel->getActiveSheet()->setCellValue('I1', 'TOTQTY');
        $this->excel->getActiveSheet()->setCellValue('J1', 'TOTTP');
        $this->excel->getActiveSheet()->setCellValue('K1', 'TOTHAM');
        $this->excel->getActiveSheet()->setCellValue('L1', 'TOTUNL');
        $this->excel->getActiveSheet()->setCellValue('M1', 'TOTDEL');
        $this->excel->getActiveSheet()->setCellValue('N1', 'TOTDEM');  
        $this->excel->getActiveSheet()->setCellValue('O1', 'TOTOD');
        $this->excel->getActiveSheet()->setCellValue('P1', 'TOTAMT');
        $this->excel->getActiveSheet()->setCellValue('Q1', 'PAYMENT MODE');

        if ($result->status == 1) {
            if (is_array($dataum)) {
                $ticket_count = count($dataum);
                $row = 2;
                $col = 0;
                for ($i = 0; $i < $ticket_count; $i++) {
                    $t = $dataum[$i];
                 
                    $other_charges_inner = new stdClass();
                    $charges = explode(",", $t->other_charges);
                    
                    foreach ($charges as $charge) {
                        $charges_inner = explode(":", $charge);
                        $other_charges_inner->{$charges_inner[0]} = $charges_inner[1];
                    }
                    $load_date ='';
                    if($t->loaded_at =="NA"){
                        $load_date ="-";
                    }else{
                        $load_date = date('d-m-Y', strtotime($t->loaded_at));
                    }

                    $totatalTopAmount =0;
                    if ($result->data[$i]->payment_status_code !== "PAD") { 
                       $totatalTopAmount+=($t->total_Topay_amount);
                    }

                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col,   $row, $t->from);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->fromCode);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->to);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->toCode);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->username);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, date('d-m-Y', strtotime($t->delivered_at)));
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $load_date);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->ogpl_num ? $t->ogpl_num : "-");
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->no_of_items);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row,  $totatalTopAmount);

                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->hamali);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->total_unloads);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->door_delivery);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->demurrage);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->other_charge);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row,round($t->case_received));
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->payment_mode);
                    
                    $col = 0;
                    $row++;
                }
            }
        }
        $filename = 'Delivery-'.date('Y-m-d', strtotime($fromDate)) .' TO '.date('Y-m-d', strtotime($toDate)).'.xls';
        header('Content-Disposition: attachment;filename="'.$filename.'"');
        header('Cache-Control: max-age=0');
        header('Cache-Control: max-age=1');
        header('Cache-Control: private',false);

        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
        $objWriter->save('php://output');
    }


    function sequence() {
        $this->is_logged_in();
        $data = array(
            'organization' => json_decode($this->api_model->organizationLists()),
            'list' => json_decode($this->api_model->getOrganizationPrefixCode())
        );
        $this->load->view('site/cargo/sequence', $data);
    }

    function organizationSequence() {
        $this->is_logged_in();
        $data = array(
            'organizationCode' => $this->input->post('organizationCode'),
            'prefixCode' => $this->input->post('prefixCode'),
            'sequence' => $this->input->post('sequence'),
        );
        echo $this->api_model->cargoSequence($data);
    }

    function getOrganizationPrefixCode() {
        $this->is_logged_in();
        $data = array(
            'organizationCode' => $this->input->post('organizationCode')
        );
        echo $this->api_model->getOrganizationPrefixCode($data);
    }

    function find() {
        $this->is_logged_in();
        $this->load->view('site/cargo/find');
    }

    function unload_cargo() {
        $this->is_logged_in();
        $this->load->view('site/cargo/unload-cargo');
    }

    function get_vehicle_no() {
        $this->is_logged_in();
        $result = $this->api_model->getCargoTripsList(array('date' => $this->input->post('date')));
        $result = json_decode($result);
        $data = array();
        foreach ($result->data as $row) {
            $toStationFlag = false;
            foreach ($row->stageList as $to) {
                if ($to->toStation->code == $this->session->userdata('org_station_code')) {
                    $toStationFlag = true;
                }
            }
            if ($toStationFlag) {
                $data[] = $row;
            }
        }
        echo json_encode($data);
    }

    function get_unload_cargo() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQI3A4P29',
            'CargoStatusCode' => 'CL',
            'tripCode' => $this->input->post('tripCode'),
            'toOrganizationCode' => $this->session->userdata('org_code'),
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data = array();
        $data['result'] = $result->data;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        echo $this->load->view('site/cargo/unload-cargo-list', $data);
    }

    function users() {
        $this->is_logged_in();

        $organizationDetails = $this->api_model->getOrganization(array('authtoken' => $this->_user_hash));
        $organizationDetail = json_decode($organizationDetails);
        $data['organization'] = $organizationDetail->data;

        $GroupDetails = $this->api_model->getGroup(array('authtoken' => $this->_user_hash));
        $GroupDetail = json_decode($GroupDetails);
        $data['groups'] = $GroupDetail->data;

        $data['users_pay_type'] = config_item('user_payment_type');

        $userDetails = $this->api_model->getUser(array(
            'activeFlagFilter' => -1
        ));
        $userDetail = json_decode($userDetails);
        $data['users_raw'] = $userDetail->data;
        $users = array();
        foreach ($userDetail->data as $user) {
            $t = (!empty($user->group->name)) ? $user->group->name : 'Others';
            $users[$t][] = $user;
        }
        ksort($users);
        $data['users'] = $users;

        $userAssignedBranches = $this->api_model->userAssignedBranches();
        $userAssignedBranches = json_decode($userAssignedBranches);
        $data['userAssignedBranches'] = $userAssignedBranches->data;

        $states = $this->api_model->getAllStates();
        $states = json_decode($states);
        $data['states'] = $states->data;

        $data['cargo_setting'] = _get_cargo_settings();
        $data['cargo_payment_status'] = config_item('pay_type');

        echo $this->load->view('site/cargo/users', $data);
    }

    function cargo_user_commissions() {
        $this->is_logged_in();

        $data = array(
            'userCode' => $this->input->post('userCode')
        );
        $result = $this->api_model->cargoUserCommissions($data);
        $result = json_decode($result);
        
        usort($result->data, function($a, $b) {
            return $a->state->name < $b->state->name ? -1 : 1;
        });
        $data['result'] = $result->data;

        $data['cargo_setting'] = _get_cargo_settings();

        echo $this->load->view('site/cargo/users-commissions', $data);
    }

    function update_cargo_user_commissions() {
        $this->is_logged_in();
        $code = $this->input->post('code');
        $activeflag = $this->input->post('activeFlag');
        $data = array(
            'userCode' => $this->input->post('userCode'),
            'paidCommissionValue' => $this->input->post('paidCommissionValue'),
            'toPayCommissionValue' => $this->input->post('toPayCommissionValue'),
            'accPayCommissionValue' => $this->input->post('accPayCommissionValue'),
            'loadingCommissionValue' => $this->input->post('loadingCommissionValue'),
            'unloadingCommissionValue' => $this->input->post('unloadingCommissionValue'),
            'delivaryCommissionValue' => $this->input->post('delivaryCommissionValue'),
            'delivaryTopayCommissionValue' => $this->input->post('delivaryTopayCommissionValue'),
            'delivaryPaidCommissionValue' => $this->input->post('delivaryPaidCommissionValue'),
            'delivaryAccpayCommissionValue' => $this->input->post('delivaryAccpayCommissionValue'),
            'doorPickupCommissionValue' => $this->input->post('doorPickupCommissionValue')?: '0',
            'doorDeliveryCommissionValue' => $this->input->post('doorDeliveryCommissionValue')?: '0',
            'paidCommissionTypeCode' => $this->input->post('paidCommissionTypeCode'),
            'toPayCommissionTypeCode' => $this->input->post('toPayCommissionTypeCode'),
            'accPayCommissionTypeCode' => $this->input->post('accPayCommissionTypeCode'),
            'loadingCommissionTypeCode' => $this->input->post('loadingCommissionTypeCode'),
            'unloadingCommissionTypeCode' => $this->input->post('unloadingCommissionTypeCode'),
            'deliveryTopayCommissionTypeCode' => $this->input->post('deliveryTopayCommissionTypeCode'),
            'deliveryPaidCommissionTypeCode' => $this->input->post('deliveryPaidCommissionTypeCode'),
            'deliveryAccpayCommissionTypeCode' => $this->input->post('deliveryAccpayCommissionTypeCode'),
            'doorPickupCommissionTypeCode' => $this->input->post('doorPickupCommissionTypeCode'),
            'doorDeliveryCommissionTypeCode' => $this->input->post('doorDeliveryCommissionTypeCode'),
            'creditLimit' => $this->input->post('creditLimit')?: '0',
            'captureCommissionFlag' => $this->input->post('captureCommissionFlag')?: '0',
            'state' => $this->input->post('state') ?: array('code' => ''),
            'commissionValueType' => array('code' => 'PER')
        );

        if (!empty($code)) {
            $data['code'] = $code;
        }

        if (!empty($activeflag)) {
            $data['activeFlag'] = $activeflag;
        }
        echo $this->api_model->addCargoUserCommissions($data);
    }

    function sms_lr_details() {
        $this->is_logged_in();
        $data = array(
            'cargoCode' => $this->input->post('cargoCode')
        );
        echo $this->api_model->cargoNotify($data);
    }

    function vendor() {
        $this->is_logged_in();
        
        $vendors = $this->api_model->cargoCustomerVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;
        
        $itemDetails = $this->api_model->getCargoItems();
        $itemDetail = json_decode($itemDetails);
        $data['items'] = $itemDetail->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $data['article_unit'] = $this->config->item('article_unit');
        $data['vendor_category'] = $this->config->item('vendor_category');
        $data['namespace'] = $this->session->userdata('namespace_id');
        $data['cargo_setting'] = _get_cargo_settings();
        
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/vendor-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=vendore-list.xls');
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
            $this->load->view('site/cargo/vendor', $data);
        }
    }

    function update_vendor_aliascode(){
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'vendorCategory' => $this->input->post('vendorCategory'),
        );

        echo $this->api_model->vendorAliasUpdate($data);
    }

    function update_cargo_vendor() {
        $this->is_logged_in();

        $code = $this->input->post('code');

        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'mobileNumber' => $this->input->post('mobileNumber')?:'NA',
            'email' => trim($this->input->post('email')),
            'companyName' => $this->input->post('companyName'),
            'shortCode' => $this->input->post('shortCode'),
            // 'preferedPaymentType' => $this->input->post('preferedPaymentType'),
            'address1' => '',
            'address2' => '',
            'pincode' => '',
            'landmark' => '',
            'station' => $this->input->post('station'),
            'vendorAddress' => $this->input->post('vendorAddress'),
            'gst' => $this->input->post('gst'),
            'loadingCharge' => $this->input->post('loadingCharge') ?: 0,
            'unloadingCharge' => $this->input->post('unloadingCharge') ?: 0,
            'responsibleOrganization' => $this->input->post('responsibleOrganization'),
            'organization' => $this->input->post('organization')?: [],
            'creditLimit' => $this->input->post('creditLimit') ?: 0,
            'invoiceDueDays' => $this->input->post('invoiceDueDays') ?: 0,
            'settlementDueDays' => $this->input->post('settlementDueDays') ?: 0,
            'vendorReference' => $this->input->post('vendorReference')?: [],
            'hideCargoFreight' => (int)$this->input->post('hideCargoFreight'),
            'remarks' => $this->input->post('remarks') ?: 'NA',
        );
        if (!empty($code)) {
            $data['code'] = $code;
        }
        $vendor = $this->api_model->updateCargoVendor($data);
        $vendor = json_decode($vendor);

        if ($vendor->status != 1) {
            echo json_encode($vendor);
            return;
        }

        $oldemail = trim($this->input->post('oldemail'));

        if ($oldemail != '' && $oldemail != $data['email']) {
            $verify = $this->_send_vendor_email_verify(array(
                'vendorCode' => $vendor->data->code, 
                'email' => $data['email']
            ));
            $verify = json_decode($verify);
            
            if ($verify->status != 1) {
                echo json_encode($verify);
                return;
            }

            $verify->emailVerificationSent = 1;
            echo json_encode($verify);
            return;
        }

        echo json_encode($vendor);
    }

    function add_vendor_address(){
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'address1' => $this->input->post('address1'),
            'address2' => $this->input->post('address2'),
            'pincode' => $this->input->post('pincode'),
            'landmark' => $this->input->post('landmark'),
            'station' => $this->input->post('station'),
            'vendorCode' => $this->input->post('vendorCode')
        );

        echo $this->api_model->updateVendorAddress($data);
    }

    function vendor_tariff(){
        $this->is_logged_in();

        $code = $this->input->post('code');

        $tariff = $this->api_model->getAllTariff(array('rateCardTypeCode' => 'RAC'));
        $tariffDetail = json_decode($tariff);
        $data['tariff'] = $tariffDetail->data;

        $matched_tariff = [];
        foreach($tariffDetail->data as $key=>$val){
            if($val->fromVendor->code == $code){
                array_push($matched_tariff, $val);
            }
        }
        
        $data['mtch_tariff'] = $matched_tariff;
        $data['cargo_setting'] = _get_cargo_settings();
        $data['free_service_vendor_tariff'] = $this->config->item('free_service_vendor_tariff');

        if ($this->input->post('export') == 1) {
            $filename = 'Vendor-Tariff';
            $this->load->excel('site/cargo/vendor-tariff-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/vendor-tariff', $data);
        }
    }

    function get_vendor_address(){
        $this->is_logged_in();

        $data = array(
            'vendorCode' => $this->input->post('vendorCode') ?: '',
            'addressCode' => $this->input->post('addressCode') ?: ''
        );

        echo $this->api_model->getVendorAddress($data);
    }

    function vendor_address(){
        $this->is_logged_in();

        $data = array(
            'vendorCode' => $this->input->post('vendorCode') ?: '',
            'addressCode' => $this->input->post('addressCode') ?: ''
        );

        $address = $this->api_model->getVendorAddress($data);
        $address = json_decode($address);
        $data['address'] = $address->data;

        $this->load->view('site/cargo/vendor-address', $data);
    }

    function update_tariff(){
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'fromVendor' => $this->input->post('fromVendor'),
            'toVendorList' => $this->input->post('toVendorList') ?: [],
            'customerRole' => $this->input->post('customerRole'),
            'fromStationList' => $this->input->post('fromStationList') ?: [],
            'toStationList' => $this->input->post('toStationList') ?: [],
            'fromOrganizationList' => $this->input->post('fromOrganizationList') ?: [],
            'toOrganizationList' => $this->input->post('toOrganizationList') ?: [],
            'routeType' => $this->input->post('routeType'),
            'hamaliCharge' => $this->input->post('hamaliCharge'),
            'docketCharge' => $this->input->post('docketCharge'),
            'doorPickupCharge' => $this->input->post('doorPickupCharge'),
            'doorDeliveryCharge' => $this->input->post('doorDeliveryCharge'),
            'itemDetailList' => $this->input->post('itemDetailList')
        );

        echo $this->api_model->updateTariff($data);
    }

    function send_vendor_email_verify() {
        $this->is_logged_in();

        echo $this->_send_vendor_email_verify(array(
            'vendorCode' => $this->input->post('vendorCode'),
            'email' => $this->input->post('email')
        ));
    }

    private function _send_vendor_email_verify($param) {
        $params = json_encode(array(
            'em' => $param['email'],
            'vc' => $param['vendorCode'],
            'ns' => _get_namespace_id()
        ));

        $url = base_url('cargo/verify-vendor-email/' . urlencode(base64_encode($params)));

        return $this->api_model->sendVendorEmail(array(
            'emailVerifiedFlag' => 0,
            'code' => $param['vendorCode'],
            'email' => $param['email'],
            'ns' =>  _get_namespace_id(),
            'url' => $url
        ));
    }

    function verify_vendor_email($encoded) {
        $this->load->exclude_template();

        if (!$encoded) {
            return;
        }
        $params = json_decode(base64_decode(urldecode($encoded)));

        $verify = $this->api_model->verifyVendorEmail(array(
            'emailVerifiedFlag' => 1,
            'code' => $params->vc,
            'email' => $params->em,
            'ns' => $params->ns,
        ));
        $verify = json_decode($verify);

        $data['error_message'] = $verify->errorDesc ?: "Unknown Exception";
        $data['success_message'] = "Your email id verified successfully";
        $data['title'] = 'Email Verification';

        $data['verify'] = $verify;

        $this->load->view('site/cargo/email-verification-status', $data);
    }

    function vendor_booking_report() {
        $this->is_logged_in();
        $vendors = $this->api_model->cargoCustomerVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;

        $this->load->view('site/cargo/vendor-booking-report', $data);
    }

    function vendor_booking_report_list() {
        $this->is_logged_in();

        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
        $fromDate = date('Y-m-d', strtotime($fromDate));
        $toDate = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQI3UF231',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'vendorCode' => $this->input->post('vendorCode') ?: 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');

        if ($this->input->post('export') == 1) {
            $filename = 'vendor-booking-report';
            $this->load->excel('site/cargo/vendor-booking-report-list-xls', $data, $filename);
        } else if ($this->input->post('pdf') == 1) {
            $vendors = $this->api_model->cargoCustomerVendor();
            $vendors = json_decode($vendors);
            $vendors = $vendors->data;
            $vendor_details = array();
            foreach($vendors as $row){
                if ($row->code == $this->input->post('vendorCode')){
                    $vendor_details = $row;
                }
            }
            $data['vendor_details'] = $vendor_details;

            $nsprofile = $this->api_model->getNamespaceProfile(array('authtoken' => $this->_user_hash));
            $nspro = json_decode($nsprofile);
            $data['nsprofile'] = $nspro->data;

            $gst = $this->api_model->getGstDetails();
            $gst = json_decode($gst);

            $stategst = array();
            foreach ($gst->data as $row) {
                $stategst[$row->state->code] = $row;
            }
            $data['stategst'] = $stategst;

            require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
            $pdf = new TCPDF();
            $pdf->SetTitle('Vendor Booking');
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('times', '', 9);
            $pdf->SetMargins(5, 10, 12, true);
            $pdf->AddPage('L');

            ob_clean();
            $this->load->exclude_template();

            $content = $this->load->view('site/cargo/vendor-booking-report-list-pdf', $data, true);

            $pdf->writeHTML($content);

            $pdf->Output('Vendor-Booking.pdf', 'd');
        }
         else {
            echo $this->load->view('site/cargo/vendor-booking-report-list', $data);
        }
    }

    function topay_payment() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        $data['groupusers'] = get_active_group_and_users();
        $data['cargo_status'] = config_item('cargo_status');

        $data['user_station_code'] = $this->session->userdata('org_station_code');
        $data['user_login_code'] = $this->session->userdata('user_id');

        $this->load->view('site/cargo/topay-payment', $data);
    }

    function topay_payment_list() {
        $this->is_logged_in();

        $user_code = $this->input->post('userCode');
        if (empty($user_code)) {
            $user_code = $this->session->userdata('user_id');
        }
        $cargo_code = $this->input->post('cargoCode');
        if (empty($cargo_code)) {
            $cargo_code = 'NA';
        }

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQFCRM569',
            'toDate' => $to_date,
            'fromDate' => $from_date,
            'userCode' => $user_code,
            'cargoStatusCode' => $this->input->post('cargoStatus'),
            'paymentStatusCode' => 'TOP',
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'cargoCode' => $cargo_code,
            'filterCode' => 'BOOK',
            'groupCode' => $this->input->post('groupCode') ?: 'NA',
            'transactionModeCode' => 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['cargo_status'] = config_item('cargo_status');

        $data['groupusers'] = get_active_group_and_users();
        $data['user_login_code'] = $this->session->userdata('user_id');

        $this->load->view('site/cargo/topay-payment-list', $data);
    }

    function organization() {
        $this->is_logged_in();

        $no_flag = $this->api_model->organizationLists();
        $no_flag = json_decode($no_flag);
        $no_flag = $no_flag->data;
   
        $data['branches'] = $no_flag;

        $branches = $this->api_model->getDeliveryBranches();
        $data['delivery_branches'] =(array) getData($branches);
       
        $payment_type = $this->config->item('pay_type');
        if (!has_action_rights('CARGO-INVOICE-PAY')) {
            unset($payment_type['INP']);
            unset($payment_type['OATP']);
        }
        if (!has_action_rights('CARGO-FREE-SERVICE')) {
            unset($payment_type['FS']);
        }
        $data['pay_type'] = $payment_type;

        $this->load->view('site/cargo/cargo-organization', $data);
    }

    function update_organization() {
        $this->is_logged_in();

        $dlrybrnch = $this->input->post('deliveryBranchList');
        $hubBranches = $this->input->post('hubBranches');
        $tmp = array();
        foreach($dlrybrnch as $b) {
           $tmp[]['code'] =  $b;
        }

        $data = array(
            'organization' => array('code' => $this->input->post('code')),
            'activeFlag' => 1,
            'bookingDeliveryFlag' => $this->input->post('bookingDeliveryFlag'),
            'deliveryBranchList' => $tmp,
            //'paymentTypeList' => $this->input->post('payType'),
            'hubBranches' => $hubBranches,
        );

        echo $this->api_model->updateCargoOrganization($data);
    }

    function update_topay_payment() {
        $this->is_logged_in();
        $data = array(
            'cargoCode' => $this->input->post('code'),
            'transactionType' => array('code' => 'CGBO'),
            'transactionAmount' => $this->input->post('amount'),
            'offlineUserCode' => $this->input->post('offlineUserCode') ?: ''
        );
        $response = $this->api_model->addCargoPayment($data);
        $response = json_decode($response);

        if ($this->input->post('delivery') == '1' && $response->status == 1) {
            $param = array(
                'statusCode' => 'CD',
                'cargoCode' => $this->input->post('code')
            );
            echo $this->api_model->changeCargoItemStatus($param);
        } else {
            echo json_encode($response);
        }
    }

    function load_trip_list() {
        $date = $this->input->post('date');
        $tresult = $this->api_model->getCargoTripsList(array(
            'date' => date("Y-m-d", strtotime($date))
        ));
        $tresult = json_decode($tresult);
        $tresult = $tresult->data;

        $trips = array();
        foreach ($tresult as $trip) {
            $t = array();
            $t['code'] = $trip->tripCode;
            $t['driver'] = $trip->tripInfo->driverName;
            $t['vehicle'] = $trip->tripInfo->busVehicle->code;
            $fr = array();
            $to = array();
            $ttime = array();
            foreach ($trip->stageList as $stage) {
                $fr[] = $stage->fromStation->code;
                $to[] = $stage->toStation->code;

                $ttime[] = strtotime($stage->fromStation->dateTime);
            }
            $t['triptime'] = min($ttime);
            $t['name'] = $trip->schedule->name . ' (' . date('h:i A', min($ttime)) . ')';
            $t['fromstations'] = $fr;
            $t['tostations'] = $to;
            $trips[] = $t;

            $a_tmp[] = strtotime($trip->stageList[0]->fromStation->dateTime);
        }
        array_multisort($a_tmp, SORT_ASC, $trips);
        $data['trips'] = $trips;

        echo json_encode($data);
    }

    function generate_voucher() {
        $this->is_logged_in();

        if (has_action_rights('CGO-VOU-ALL-BRANCH')) {
            $branches = $this->api_model->getOrganization();
            $branches = json_decode($branches);
            $branches = $branches->data;

            $organization = array();
            foreach ($branches as $branch) {
                $organization[$branch->code] = $branch->name;
            }
            asort($organization);
            $data['branches'] = $organization;
        }

        if (has_action_rights('CGO-VOU-ALL-USER')) {
            $users = $this->api_model->getUser();
            $users = json_decode($users);
            $users = $users->data;

            $usrbranch = array();
            foreach ($users as $row) {
                $usrbranch[$row->organization->code][$row->code] = $row->name;
            }
            $data['branchusers'] = $usrbranch;
        }
        $data['transactionMode'] = config_item('transaction_mode');
        $data['username'] = $this->session->userdata('user_name');

        $this->load->view('site/cargo/generate-voucher', $data);
    }

    function get_voucher_list() {
        $this->is_logged_in();

        $fromDate = $this->input->post('fromDate');
        $toDate = $this->input->post('toDate');

        if($fromDate != '' && $fromDate != 'NA') {
            $fromDate = date('Y-m-d', strtotime($fromDate));
        }
        if($toDate != '' && $toDate != 'NA') {
            $toDate = date('Y-m-d', strtotime($toDate));
        }

        $data = array(
            'queryCode' => 'RQI9KAY1',
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'userCode' => $this->input->post('userCode') ?: 'NA',
            'vendorCode' => 'NA',
            'transactionType' => 'VOUCHER'
        );

        if (!has_action_rights('CGO-VOU-ALL-BRANCH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }
        if (!has_action_rights('CGO-VOU-ALL-USER')) {
            $data['userCode'] = $this->session->userdata('user_id');
        }
        if ($data['userCode'] != 'NA') {
            $data['organizationCode'] = 'NA';
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $list = array();
        foreach ($result->data as $row) {
            $row->total_amount = $row->transaction_amount - $row->commission_amount;
            $list[$row->from_organization_name]['total'] += $row->total_amount;
            $list[$row->from_organization_name]['items'] += $row->total_item_count;
            $list[$row->from_organization_name]['count'] += 1;
            $list[$row->from_organization_name]['from_organization_code'] = $row->from_organization_code;
            $list[$row->from_organization_name]['data'][$row->user_first_name]['data'][] = $row;
            $list[$row->from_organization_name]['data'][$row->user_first_name]['total'] += $row->total_amount;
            $list[$row->from_organization_name]['data'][$row->user_first_name]['user_code'] = $row->user_code;
            $list[$row->from_organization_name]['data'][$row->user_first_name]['items'] += $row->total_item_count;
            $list[$row->from_organization_name]['data'][$row->user_first_name]['count'] += 1;
        }
        $data['result'] = $list;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/generate-voucher-list', $data);
    }

    function pay_generated_voucher() {
        $this->is_logged_in();

        $data = array(
            'activeFlag' => 1,
            'amountReceivedDate' => date('Y-m-d'),
            'remarks' => $this->input->post('remarks'),
            'transactionType' => array('code' => 'CGPAVR'),
            'transactionMode' => array('code' => $this->input->post('transactionMode')),
            'paymentHandledBy' => array('code' => $this->session->userdata('user_id')),
            'transactionCodes' => $this->input->post('transactionCodes'),
        );
        if ($this->input->post('userCode') != 'NA') {
            $data['user'] = array('code' => $this->input->post('userCode'));
        }
        echo $this->api_model->generatePayment($data);
    }

    function generate_invoice() {
        $this->is_logged_in();

        if (has_action_rights('CGO-INV-SAME-BRANCH')) {
            $vendors = $this->api_model->cargoCustomerVendorByBranch(array('organizationCode' => $this->session->userdata('org_code')));
            $vendors = json_decode($vendors);
            $data['vendors'] = $vendors->data;
        } else {
            $vendors = $this->api_model->cargoCustomerVendor();
            $vendors = json_decode($vendors);
            $data['vendors'] = $vendors->data;
        }

        $data['transactionMode'] = config_item('transaction_mode');
        $data['username'] = $this->session->userdata('user_name');

        $this->load->view('site/cargo/generate-invoice', $data);
    }

    function get_invoice_list() {
        $this->is_logged_in();

        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
        $fromDate = date('Y-m-d', strtotime($fromDate));
        $toDate = date('Y-m-d', strtotime($toDate));
        
        $data = array(
            'queryCode' => 'RQI9KAY1',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'organizationCode' => 'NA',
            'userCode' => 'NA',
            'vendorCode' => $this->input->post('vendorCode') ?: 'NA',
            'transactionType' => 'INVOICE'
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $list = array();
        foreach ($result->data as $row) {
            $row->total_amount = $row->transaction_amount - $row->commission_amount;
            $list[$row->vendor_name]['data'][] = $row;
            $list[$row->vendor_name]['vendor_code'] = $row->vendor_code;
            $list[$row->vendor_name]['total'] += $row->total_amount;
        }
        $data['result'] = $list;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/generate-invoice-list', $data);
    }

    function pay_generated_invoice() {
        $this->is_logged_in();

        $data = array(
            'activeFlag' => 1,
            'amountReceivedDate' => date('Y-m-d'),
            'remarks' => $this->input->post('remarks'),
            'transactionType' => array('code' => 'CGINVPA'),
            'transactionMode' => array('code' => $this->input->post('transactionMode')),
            'paymentHandledBy' => array('code' => $this->session->userdata('user_id')),
            'transactionCodes' => trim($this->input->post('transactionCodes')),
            'vendorBillingAddress' => $this->input->post('vendorBillingAddress')
        );
        // echo $this->api_model->generateInvoicePayment($data);

        $inv = $this->api_model->generateInvoicePayment($data);
        $invoice = json_decode($inv);

        $item_data = array();
        $itemDetail = $this->input->post('itemDetailList');
        foreach($itemDetail as $key=>$val){
            $val['paymentTransaction']->code = $invoice->data->code;
            array_push($item_data, $val);
        }

        if ($invoice->status != 1 || count($item_data) == 0) {
            echo json_encode($invoice);
            return;
        }

        echo $this->api_model->updateInvoiceExtraIncomeExpense($item_data);
    }

    function voucher() {
        $this->is_logged_in();

        if (has_action_rights('CGO-VOU-ALL-BRANCH')) {
            $branches = $this->api_model->getOrganization();
            $branches = json_decode($branches);
            $branches = $branches->data;

            $organization = array();
            foreach ($branches as $branch) {
                $organization[$branch->code] = $branch->name;
            }
            asort($organization);
            $data['branches'] = $organization;
        }

        if (has_action_rights('CGO-VOU-ALL-USER')) {
            $users = $this->api_model->getUser();
            $users = json_decode($users);
            $users = $users->data;

            $usrbranch = array();
            foreach ($users as $row) {
                $usrbranch[$row->organization->code][$row->code] = $row->name;
            }
            $data['branchusers'] = $usrbranch;
        }
        $data['transactionMode'] = config_item('transaction_mode');

        $this->load->view('site/cargo/voucher', $data);
    }

    function paid_vouchers() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQI9KAZ2',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'vendorCode' => 'NA',
            'acknowledgementStatus' => 'ACKED',
            'userCode' => $this->input->post('userCode') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'transactionType' => 'VOUCHER'
        );

        if (!has_action_rights('CGO-VOU-ALL-BRANCH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }
        if (!has_action_rights('CGO-VOU-ALL-USER')) {
            $data['userCode'] = $this->session->userdata('user_id');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['transactionMode'] = config_item('transaction_mode');

        $this->load->view('site/cargo/paid-vouchers', $data);
    }

    function unpaid_vouchers() {
        $this->is_logged_in();

        $data = array();
        if (!has_action_rights('CGO-VOU-ALL-BRANCH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getUnpaidVouchers($data);
        $result = json_decode($result);

        $group = array();
        $summary = array();
        foreach ($result->data as $row) {
            if ($row->transactionType->code == 'CGPAVR') {
                if($row->acknowledgeStatus->code != 'INITD') {
                    continue;
                }
                $partialTransactionAmount = 0;
                foreach ($row->partialPaymentList as $partial) {
                    $partialTransactionAmount += $partial->transactionAmount;
                }
                $row->partialTransactionAmount = $partialTransactionAmount;
                $group[$row->user->organization->name][] = $row;
                $summary[$row->user->organization->name]['transactionAmount'] += $row->transactionAmount;
                $summary[$row->user->organization->name]['partialPaymentAmount'] += $partialTransactionAmount;
            }
        }

        $data['result'] = $group;
        $data['summary'] = $summary;
        $data['transactionMode'] = config_item('transaction_mode');

        $this->load->view('site/cargo/unpaid-vouchers', $data);
    }

    function acknowledge_vouchers() {
        $this->is_logged_in();

        $data = array();
        if (!has_action_rights('CGO-VOU-ALL-BRANCH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getUnpaidVouchers($data);
        $result = json_decode($result);

        $group = array();
        $summary = array();
        foreach ($result->data as $row) {
            if ($row->transactionType->code == 'CGPAVR') {
                if($row->acknowledgeStatus->code != 'PAID' && $row->acknowledgeStatus->code != 'PAPAID') {
                    continue;
                }
                $partialTransactionAmount = 0;
                foreach ($row->partialPaymentList as $partial) {
                    $partialTransactionAmount += $partial->transactionAmount;
                }
                $row->partialTransactionAmount = $partialTransactionAmount;
                $group[$row->user->organization->name][] = $row;
                $summary[$row->user->organization->name]['transactionAmount'] += $row->transactionAmount;
                $summary[$row->user->organization->name]['partialPaymentAmount'] += $partialTransactionAmount;
            }
        }

        $data['result'] = $group;
        $data['summary'] = $summary;
        $data['transactionMode'] = config_item('transaction_mode');

        $this->load->view('site/cargo/acknowledge-vouchers', $data);
    }

    function voucher_partial_details() {
        $this->is_logged_in();

        echo $this->api_model->voucherPartialTransactions(array(
            'paymentTransactionCode' => $this->input->post('paymentTransactionCode')
        ));
    }

    function voucher_partial_transactions() {
        $this->is_logged_in();
        require_once APPPATH . 'third_party/tcpdf/tcpdf.php';

        $details = $this->api_model->voucherPartialTransactions(array(
            'paymentTransactionCode' => $this->input->get('paymentCode')
        ));
        $details = json_decode($details);
        $data['details'] = $details->data;

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQF488B108M',
            'paymentCode' => $this->input->get('paymentCode')
        ));
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $pdf = new TCPDF();
        $pdf->SetTitle('Voucher Transactions');
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->SetFont('helvetica', '', 8);
        $pdf->SetMargins(5, 10, 12, true);
        $pdf->AddPage();

        ob_clean();
        $this->load->exclude_template();
        $content = $this->load->view('site/cargo/vouchers-partial-transactions', $data, true);

        $pdf->writeHTML($content);

        $pdf->Output('Voucher Transactions.pdf', 'i');
    }

    function make_voucher_payment() {
        $this->is_logged_in();

        echo $this->api_model->cargoUpdateAck(array(
            'code' => $this->input->post('code'),
            'amountReceivedDate' => date('Y-m-d'),
            'remarks' => $this->input->post('remarks'),
            'transactionAmount' => $this->input->post('transactionAmount'),
            'paymentHandledBy' => array('code' => $this->session->userdata('user_id')),
            'transactionMode' => array('code' => $this->input->post('transactionMode')),
            'acknowledgeStatus' => array('code' => 'PAPAID'),
            'transactionType' => array('code' => 'CGPAVR'),
        ));
    }

    function make_all_voucher_payment() {
        $this->is_logged_in();

        $data = $this->input->post('data') ?: [];
        foreach ($data as $row) {
            $this->api_model->cargoUpdateAck(array(
                'code' => $row['code'],
                'amountReceivedDate' => date('Y-m-d'),
                'remarks' => '',
                'transactionAmount' => $row['amount'],
                'paymentHandledBy' => array('code' => $this->session->userdata('user_id')),
                'transactionMode' => array('code' => 'CASH'),
                'acknowledgeStatus' => array('code' => 'PAPAID'),
                'transactionType' => array('code' => 'CGPAVR'),
            ));
        }

        echo json_encode(array(
            'status' => 1
        ));
    }

    function reject_voucher() {
        $this->is_logged_in();

        echo $this->api_model->cargoUpdateAck(array(
            'code' => $this->input->post('code'),
            'acknowledgeStatus' => array('code' => 'RJECT'),
            'transactionType' => array('code' => 'CGPAVR'),
        ));
    }

    function reject_all_voucher() {
        $this->is_logged_in();

        $codes = $this->input->post('codes') ?: [];
        foreach ($codes as $code) {
            $this->api_model->cargoUpdateAck(array(
                'code' => $code,
                'acknowledgeStatus' => array('code' => 'RJECT'),
                'transactionType' => array('code' => 'CGPAVR'),
            ));
        }

        echo json_encode(array(
            'status' => 1
        ));
    }

    function approve_voucher() {
        $this->is_logged_in();

        echo $this->api_model->cargoUpdateAck(array(
            'code' => $this->input->post('code'),
            'acknowledgeStatus' => array('code' => 'PAID'),
            'transactionType' => array('code' => 'CGPAVR'),
            'remarks' => '',
        ));
    }

    function approve_all_voucher() {
        $this->is_logged_in();

        $codes = $this->input->post('codes') ?: [];
        foreach ($codes as $code) {
            $this->api_model->cargoUpdateAck(array(
                'code' => $code,
                'acknowledgeStatus' => array('code' => 'PAID'),
                'transactionType' => array('code' => 'CGPAVR'),
                'remarks' => '',
            ));
        }

        echo json_encode(array(
            'status' => 1
        ));
    }

    function invoice() {
        $this->is_logged_in();

        if (has_action_rights('CGO-INV-SAME-BRANCH')) {
            $vendors = $this->api_model->cargoCustomerVendorByBranch(array('organizationCode' => $this->session->userdata('org_code')));
            $vendors = json_decode($vendors);
            $data['vendors'] = $vendors->data;
        } else {
            $vendors = $this->api_model->cargoCustomerVendor();
            $vendors = json_decode($vendors);
            $data['vendors'] = $vendors->data;
        }
        //user account-model
        $cargo_setting = _get_cargo_settings();
        $data['cargo_setting'] = $cargo_setting;
        
        //contact
        $contact = $this->api_model->getContactv2();
        $contact = json_decode($contact);

        $category_contacts = array();
        foreach ($contact->data as $row) {
                if (!isset($category_contacts[$row->contactCategory->code])) {
                    $contactCategory = clone $row->contactCategory;
                    $contactCategory->contacts = [];
                    $category_contacts[$row->contactCategory->code] = $contactCategory;
                }
                $category_contacts[$row->contactCategory->code]->contacts[] = $row;
        }
        $data['category_contacts'] = $category_contacts;

        // bank detail
        $bankdetail = $this->api_model->getOrganizationOtherDetails(array(
            'organizationcode' => $this->session->userdata('org_code')
        ));
        $bankdetail = json_decode($bankdetail);
        $data['bankdetail'] = $bankdetail->data->bankDetails;

        $data['transactionMode'] = config_item('transaction_mode');
        $data['cargo_setting'] = _get_cargo_settings();
        $data['bank_names_list'] = $this->config->item('bank_names_list');

        $this->load->view('site/cargo/invoice', $data);
    }

    function paid_invoices() {
        $this->is_logged_in();

        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
        $fromDate = date('Y-m-d', strtotime($fromDate));
        $toDate = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQI9KAZ2',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'vendorCode' => $this->input->post('vendorCode'),
            'acknowledgementStatus' => 'ACKED',
            'userCode' => 'NA',
            'organizationCode' => 'NA',
            'transactionType' => 'INVOICE'
        );
        if (has_action_rights('CGO-INV-SAME-BRANCH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['transactionMode'] = config_item('transaction_mode');

        $this->load->view('site/cargo/paid-invoices', $data);
    }

    function unpaid_invoices() {
        $this->is_logged_in();

        $param = array();
        if (has_action_rights('CGO-INV-SAME-BRANCH')) {
            $param['organizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getUnpaidVouchers($param);
        $result = json_decode($result);

        $group = array();
        $summary = array();
        foreach ($result->data as $row) {
            if ($row->transactionType->code == 'CGINVPA') {
                if($row->acknowledgeStatus->code != 'INITD') {
                    continue;
                }
                $partialTransactionAmount = 0;
                foreach ($row->partialPaymentList as $partial) {
                    $partialTransactionAmount += $partial->transactionAmount;
                }
                $row->partialTransactionAmount = $partialTransactionAmount;
                $group[$row->user->name][] = $row;
                $summary[$row->user->name]['branch'] = $row->user->organization->name;
                $summary[$row->user->name]['transactionAmount'] += $row->transactionAmount;
                $summary[$row->user->name]['partialPaymentAmount'] += $partialTransactionAmount;
            }
        }
        ksort($summary);

        $data['result'] = $group;
        $data['summary'] = $summary;
        $data['transactionMode'] = config_item('transaction_mode');
        $data['cargo_setting'] = _get_cargo_settings();

        $this->load->view('site/cargo/unpaid-invoices', $data);
    }

    function acknowledge_invoices() {
        $this->is_logged_in();

        $param = array();
        if (has_action_rights('CGO-INV-SAME-BRANCH')) {
            $param['organizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getUnpaidVouchers($param);
        $result = json_decode($result);

        $group = array();
        $summary = array();
        foreach ($result->data as $row) {
            if ($row->transactionType->code == 'CGINVPA') {
                if($row->acknowledgeStatus->code != 'PAID' && $row->acknowledgeStatus->code != 'PAPAID') {
                    continue;
                }
                $partialTransactionAmount = 0;
                $partialTransactionTDSAmount = 0;
                $partialTransactionAdjustmentAmount = 0;
                $partialTransactionTotalAmount = 0;
                $tdsTaxAmount = 0;
                foreach ($row->partialPaymentList as $partial) {
                    $partialTransactionAmount += $partial->transactionAmount;
                    $partialTransactionTDSAmount += $partial->tdsTax;
                    $partialTransactionAdjustmentAmount += $partial->adjustmentAmount;
                    $partialTransactionTotalAmount += $partial->transactionAmount+$partial->tdsTax+$partial->adjustmentAmount;
                }
                $row->partialTransactionAmount = $partialTransactionAmount;
                $row->partialTransactionTDSAmount = $partialTransactionTDSAmount;
                $row->partialTransactionAdjustmentAmount = $partialTransactionAdjustmentAmount;
                $row->partialTransactionTotalAmount = $partialTransactionTotalAmount;
                $group[$row->user->name][] = $row;
                $summary[$row->user->name]['transactionAmount'] += $row->transactionAmount;
                $summary[$row->user->name]['partialPaymentAmount'] += $partialTransactionAmount;
                $summary[$row->user->name]['partialTransactionTDSAmount'] += $partialTransactionTDSAmount;
                $summary[$row->user->name]['partialTransactionAdjustmentAmount'] += $partialTransactionAdjustmentAmount;
                $summary[$row->user->name]['partialTransactionTotalAmount'] += $partialTransactionTotalAmount;
            }
        }

        $data['result'] = $group;
        $data['summary'] = $summary;
        $data['transactionMode'] = config_item('transaction_mode');

        $this->load->view('site/cargo/acknowledge-invoices', $data);
    }

    function make_invoice_payment() {
        $this->is_logged_in();

        echo $this->api_model->cargoUpdateInvoice(array(
            'code' => $this->input->post('code'),
            'amountReceivedDate' => date('Y-m-d'),
            'remarks' => $this->input->post('remarks'),
            'transactionAmount' => $this->input->post('transactionAmount'),
            'adjustmentAmount' => $this->input->post('adjustmentAmount'),
            'tdsTax' => $this->input->post('tdsTax'),
            'paymentHandledBy' => array('code' => $this->session->userdata('user_id')),
            'transactionMode' => array('code' => $this->input->post('transactionMode')),
            'bankDetails' => $this->input->post('bankDetails') ?: null,
            'chequeDetails' => $this->input->post('chequeDetails') ?: null,
            'additionalAttributes' => $this->input->post('additionalAttribute') ?: null,
            'acknowledgeStatus' => array('code' => 'PAPAID'),
            'transactionType' => array('code' => 'CGINVPA'),
        ));
    }

    function reject_invoice() {
        $this->is_logged_in();

        echo $this->api_model->cargoUpdateInvoice(array(
            'code' => $this->input->post('code'),
            'acknowledgeStatus' => array('code' => 'RJECT'),
            'transactionType' => array('code' => 'CGINVPA'),
            'remarks' => '',
        ));
    }

    function approve_invoice() {
        $this->is_logged_in();

        echo $this->api_model->cargoUpdateInvoice(array(
            'code' => $this->input->post('code'),
            'acknowledgeStatus' => array('code' => 'PAID'),
            'transactionType' => array('code' => 'CGINVPA'),
            'remarks' => '',
        ));
    }

    function invoice_partial_details() {
        $this->is_logged_in();

        echo $this->api_model->voucherPartialTransactions(array(
            'paymentTransactionCode' => $this->input->post('paymentTransactionCode')
        ));
    }

    function invoice_partial_transactions() {
        $this->is_logged_in();

        $details = $this->api_model->voucherPartialTransactions(array(
            'paymentTransactionCode' => $this->input->get('paymentCode')
        ));
        $details = json_decode($details);
        $data['details'] = $details->data;

        $inc_exp = $this->api_model->getInvoiceExtraIncomeExpense(array(
            'paymentTransactionCode' => $this->input->get('paymentCode')
        ));
        $income_expense = json_decode($inc_exp);
        $data['income_expense'] = $income_expense->data;

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQF488B108M',
            'paymentCode' => $this->input->get('paymentCode')
        ));
        $result = json_decode($result);
        $data['result'] = $result->data;
        $number = 0;
        foreach($result->data as $row){
            $number += $row->transaction_amount - $row->commission_amount;
            $fromBranchCode = $row->from_organization_code;
            $toBranchCode = $row->to_organization_code;
        }

        // from detail
        $fromBranchDetails = $this->api_model->getOrganizationDetails(array(
            'organizationcode' => $fromBranchCode
        ));
        $fromBranchDetails = json_decode($fromBranchDetails);
        $data['from_details'] = $fromBranchDetails->data;

        foreach($fromBranchDetails->data as $val) {
            $data['from_address1'] = $val->address1;
            $data['from_address2'] = $val->address2;
        }
       
        // to detail
        $toBranchDetails = $this->api_model->getOrganizationDetails(array(
            'organizationcode' => $toBranchCode
        ));
        $toBranchDetails = json_decode($toBranchDetails);
        $data['to_details'] = $toBranchDetails->data;

        foreach($toBranchDetails->data as $val) {
            $data['to_address1'] = $val->address1;
            $data['to_address2'] = $val->address2;
            $data['contact'] = $val->contact;
        }

        $data['cgstAmount'] = ($number * 2.5) / 100;
        $data['sgstAmount'] = ($number * 2.5) / 100;
        $data['igstAmount'] = ($number * 5) / 100;
        $data['total'] = $number;

        // $currency = numberToWords($number);
         

        $nsprofile = $this->api_model->getNamespaceProfile(array('authtoken' => $this->_user_hash));
        $nspro = json_decode($nsprofile);
        $data['ns_profile'] = $nspro->data;
        $data['nsprofile'] = $nspro->data->namespaceProfile;

        $vendors = $this->api_model->cargoCustomerVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;
        
        $gst = $this->api_model->getGstDetails();
        $gst = json_decode($gst);

        $stategst = array();
        foreach ($gst->data as $row) {
            $stategst[$row->state->code] = $row;
        }
        $data['stategst'] = $stategst;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['username'] = $this->session->userdata('user_name');

        if($this->session->userdata('namespace_id') == "kmpparcel") {
            $nsprofile = $nspro->data->namespaceProfile;
            $ftext = "{$nsprofile->address}, {$nsprofile->city}, {$nsprofile->state->name}-{$nsprofile->pincode}.";
            $ftext .= "<br/>E-mail: kmpparcelservice.cbe@gmail.com | Mobile : {$nsprofile->supportNumber}";

            require_once APPPATH . 'libraries/knt-invoice-tcpdf.php';
            $pdf = new InvoicePdf();

            $pdf->SetTitle('Invoice');
            $pdf->SetFont('helvetica', '', 8);
            $pdf->setHeaderMargin(5);
            $pdf->SetMargins(10, 30, 10, true);
            $pdf->setCustomFooterText($ftext);
            $pdf->AddPage();

            ob_clean();
            $this->load->exclude_template();

            $content = $this->load->view('site/cargo/invoice-partial-transactions-kmp', $data, true);
        } elseif ($this->session->userdata('namespace_id') == "rathimeenaparcel") {
            $nsprofile = $nspro->data->namespaceProfile;
            $ftext = "{$nsprofile->address}, {$nsprofile->city}, {$nsprofile->state->name}-{$nsprofile->pincode}.";
            $ftext .= "<br/>E-mail: rathimeenaparcel@gmail.com | Mobile : {$nsprofile->supportNumber}";

            require_once APPPATH . 'libraries/rathimeenaparcel-invoice-tcpdf.php';
            $pdf = new InvoicePdf();

            $pdf->SetTitle('Invoice');
            $pdf->SetFont('helvetica', '', 8);
            $pdf->setHeaderMargin(5);
            $pdf->SetMargins(10, 30, 10, true);
            $pdf->setCustomFooterText($ftext);
            $pdf->AddPage();

            ob_clean();
            $this->load->exclude_template();

            $content = $this->load->view('site/cargo/invoice-partial-transactions-rathimeenaparcel', $data, true);
        } elseif ($this->session->userdata('namespace_id') == "vijayalakshmi") {
            require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
            $pdf = new TCPDF();
            $pdf->SetTitle('Invoice');
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('helvetica', '', 8);
            $pdf->SetMargins(12, 10, 12, true);
            $pdf->AddPage();

            ob_clean();
            $this->load->exclude_template();

            $content = $this->load->view('site/cargo/invoice-partial-transactions-vijayalakshmi', $data, true);
        } elseif (in_array($this->session->userdata('namespace_id') , ["seenutransports", "seenucargo"])) {
            $data['printStatus'] =$this->input->get('printStatus');

            $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
            $usr_pro = json_decode($usr_pro);
            $organizationCode= $usr_pro->data->organization->code;
            $organizationDetails = $this->api_model->getOrganizationDetails(array('organizationcode' =>$organizationCode));
            $organizationDetails = json_decode($organizationDetails);
            $data['organizationDetails']  = $organizationDetails->data;

            $data['get_gst_state'] = config_item('get_gst_state');
            $bank_detail = $this->api_model->getAllBankDetails(array(
                'entityTypeCode' => 'NMSP',
                'referenceCode' => _get_namespace_id()
            ));
            $bank_detail = json_decode($bank_detail);
            $data['bank_detail'] = $bank_detail->data;
            
            foreach ($result->data as $key=>$val) {
                if (($val->payment_status_code == 'INP' && $val->from_customer_address_code != '') ||
                    ($val->payment_status_code == 'OATP' && $val->to_customer_address_code != '')) {
                    $summary = $this->api_model->getCargoSummary(array('cargoCode' => $val->cargo_code));
                    $summary = json_decode($summary);
                    $data['summary'] = $summary->data;
                    break;
                }
            }
           
            $gst = $this->api_model->getGstDetails();
            $gst = json_decode($gst);

            $fromBranchDetails = $this->api_model->getOrganizationDetails(array(
                'organizationcode' => $data['summary']->fromOrganization->code,
            ));

            $fromBranchDetails =json_decode($fromBranchDetails);
         
            
            $deliveryBranchGstCode ='';
            foreach ($gst->data as $val){
                if($fromBranchDetails->data[0]->station->state->code===$val->state->code){
                    $deliveryBranchGstCode =$val;
                }
            }
           
            $data['deliveryBranchGstCode']=$deliveryBranchGstCode;

            $gstin = ['gstin' =>$data['summary']->fromCustomerGST,];
            $GstDetails =$this->api_model->getGSTDetailsApi($gstin);
            $GstDetails = json_decode($GstDetails);
            $data['GstDetails']=$GstDetails->data;
           
            $data['Gststate'] =$GstDetails->data->state->code; 

            $nsprofile = $this->api_model->getNamespaceProfile(array('authtoken' => $this->_user_hash));
            $nspro = json_decode($nsprofile);
            $data['nsprofile'] = $nspro->data;    
            $deliveryBranchGstCodes ='';
            foreach ($gst->data as $val){
                if($nspro->data->namespaceProfile->state->code==$val->state->code){
                    $deliveryBranchGstCodes =$val;
                }
            }
            $data['deliveryBranchGstCodes']=$deliveryBranchGstCodes;
            require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
            $pdf = new TCPDF();
            $pdf->SetTitle('Invoice');
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('helvetica', '', 8);
            $pdf->SetMargins(12, 10, 12, true);
            $pdf->AddPage();

            ob_clean();
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/invoice-partial-transactions-seenutransport', $data, true);
        } elseif($this->session->userdata('namespace_id') == "panindia") {
            require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
            $pdf = new TCPDF();
            $pdf->SetTitle('Invoice');
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('helvetica', '', 7);
            $pdf->SetMargins(5, 5, 5, true);
            $pdf->AddPage();

            ob_clean();
            $this->load->exclude_template();

            $content = $this->load->view('site/cargo/invoice-partial-transactions-panindia', $data, true);
        } elseif($this->session->userdata('namespace_id') == "rajeshcargo") {
            require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
            $pdf = new TCPDF();
            $pdf->SetTitle('Invoice');
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('helvetica', '', 7);
            $pdf->SetMargins(5, 5, 5, true);
            $pdf->AddPage();

            ob_clean();
            $this->load->exclude_template();

            $content = $this->load->view('site/cargo/invoice-partial-transactions-rexlogistics', $data, true);
        } elseif($this->session->userdata('namespace_id') == "rktparcel") {
            require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
            $pdf = new TCPDF();
            $pdf->SetTitle('Invoice');
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('helvetica', '', 8);
            $pdf->SetMargins(12, 10, 12, true);
            $pdf->AddPage();

            ob_clean();
            $this->load->exclude_template();
            
            $data['article_unit'] = $this->config->item('article_unit');
            $data['ns'] = $this->session->userdata('namespace_id');
            
            if ($this->session->userdata('namespace_id') == 'rktparcel') {
                $upi = 'EzE0040220@CUB';
            } 
            $summary = $data['summary'];
            $enteredAmount = $this->input->post('entered_amount');
            $upiparams = [
                'pa' => $upi,
                'pn' => 'RKT SPEED PARCEL SERVICE',
                'am' => $enteredAmount,
                'tn' => $data['summary']->code,
            ];

            $data['upiUrl'] = 'upi://pay?' . http_build_query($upiparams);
            $content = $this->load->view('site/cargo/invoice-partial-transactions', $data, true);
        }else {
            require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
            $pdf = new TCPDF();
            $pdf->SetTitle('Invoice');
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('helvetica', '', 8);
            $pdf->SetMargins(12, 10, 12, true);
            $pdf->AddPage();

            ob_clean();
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/invoice-partial-transactions', $data, true);
        }

        $pdf->writeHTML($content);

        $pdf->Output('Invoice.pdf', 'i');
    }

    function collection_report() {
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $this->load->view('site/cargo/collection-report', $data);
    }

    function collection_report_list() {
        $this->is_logged_in();

        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
        $fromDate = date('Y-m-d', strtotime($fromDate));
        $toDate = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQI8VD5536',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'fromStationCode' => $this->input->post('fromStationCode')?: 'NA',
            'toStationCode' => $this->input->post('toStationCode')?: 'NA',
            'fromOrganizationCode' => $this->input->post('fromOrganizationCode')?: 'NA',
            'toOrganizationCode' =>  'NA',
            'deliveryType' => $this->input->post('deliveryType')?: 'NA',
            'filterType'=>  $this->input->post('filterType')
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $summary = array();
        $total = array();
        $summary = array();
        $collection = array();
        foreach ($result->data as $row) {
            $row->net_payable = $row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount;
            $row->topay = ($row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount) - $row->transaction_amount;
            $collection[$row->from_organization_name][] = $row;

            if($row->payment_status_code=="TPPAD") {
                $summary[$row->payment_organization_name]['topaypaid'] += $row->transaction_amount; 
                $total['topaypaid'] += $row->transaction_amount; 
            } else {
                $summary[$row->payment_organization_name]['paid'] += $row->transaction_amount;
                $total['paid'] += $row->transaction_amount; 
            }

            $summary[$row->payment_organization_name]['netPayable'] += $row->net_payable;
            $summary[$row->payment_organization_name]['toPay'] += $row->topay;
            $summary[$row->payment_organization_name]['handlingCharges'] += $row->total_handling_amount;
        }
        ksort($summary);

        //topay
        $topay_cash_lr =0;
        $topay_cash_amount =0;
        $topay_check_lr =0;
        $topay_check_amount =0;
        $topay_bank_lr =0;
        $topay_bank_amount =0;

        //paid 
        $paid_cash_lr =0;
        $paid_cash_amount =0;
        $paid_check_lr =0;
        $paid_check_amount =0;
        $paid_bank_lr =0;
        $paid_bank_amount =0;

        //Account 
        $Account_cash_lr =0;
        $Account_cash_amount =0;
        $Account_check_lr =0;
        $Account_check_amount =0;
        $Account_bank_lr =0;
        $Account_bank_amount =0;
    
        foreach($result->data as $row){
            //topay
            if(($row->payment_status_code=="TPPAD" ||$row->payment_status_code=="TOP") && $row->transaction_mode_type == "CASH"){
                $topay_cash_lr +=count($row->cargo_code);
                $topay_cash_amount +=$row->transaction_amount;
            }

            if(($row->payment_status_code=="TPPAD" ||$row->payment_status_code=="TOP") && $row->transaction_mode_type =="NBK"){
                $topay_bank_lr +=count($row->cargo_code);
                $topay_bank_amount +=$row->transaction_amount;
            }

            if(($row->payment_status_code=="TPPAD" ||$row->payment_status_code=="TOP") && $row->transaction_mode_type =="CHEQUE"){
                $topay_check_lr +=count($row->cargo_code);
                $topay_check_amount +=$row->transaction_amount;
            }

            //paid -
            if($row->payment_status_code=="PAD"&& $row->transaction_mode_type =="CHEQUE"){
                $paid_check_lr +=count($row->cargo_code);
                $paid_check_amount +=$row->transaction_amount;
            }
            if($row->payment_status_code=="PAD"&& $row->transaction_mode_type =="CASH"){
                $paid_cash_lr +=count($row->cargo_code);
                $paid_cash_amount +=$row->transaction_amount;
            }
            if($row->payment_status_code=="PAD"&& $row->transaction_mode_type =="NBK"){
                $paid_bank_lr +=count($row->cargo_code);
                $paid_bank_amount +=$row->transaction_amount;
            }

            //On Account

            if($row->payment_status_code=="INP"&& $row->transaction_mode_type =="CHEQUE"){
                $Account_check_lr +=count($row->cargo_code);
                $Account_check_amount +=$row->transaction_amount;
            }
            if($row->payment_status_code=="INP"&& $row->transaction_mode_type =="CASH"){
                $Account_cash_lr +=count($row->cargo_code);
                $Account_cash_amount +=$row->transaction_amount;
            }
            if($row->payment_status_code=="INP"&& $row->transaction_mode_type =="NBK"){
                $Account_bank_lr +=count($row->cargo_code);
                $Account_bank_amount +=$row->transaction_amount;
            }
        }
        
        //topay
        $data['topay_cash_lr'] =$topay_cash_lr;
        $data['topay_cash_amount'] =$topay_cash_amount;
        $data['topay_check_lr'] =$topay_check_lr;
        $data['topay_check_amount']=$topay_check_amount;
        $data['topay_bank_lr'] =$topay_bank_lr;
        $data['topay_bank_amount'] =$topay_bank_amount;
        //paid
        $data['paid_cash_lr'] =$paid_cash_lr;
        $data['paid_cash_amount'] =$paid_cash_amount;
        $data['paid_check_lr'] =$paid_check_lr;
        $data['paid_check_amount']=$paid_check_amount;
        $data['paid_bank_lr'] =$paid_bank_lr;
        $data['paid_bank_amount'] =$paid_bank_amount;
        //on account
        $data['Account_cash_lr'] =$Account_cash_lr;
        $data['Account_cash_amount'] =$Account_cash_amount;
        $data['Account_check_lr'] =$Account_check_lr;
        $data['Account_check_amount']=$Account_check_amount;
        $data['Account_bank_lr'] =$Account_bank_lr;
        $data['Account_bank_amount'] =$Account_bank_amount;

      
        $data['result'] = $collection;
        $data['summary'] = $summary;
        $data['total'] = $total;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/collection-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Collection-Report.xls');
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
            $this->load->view('site/cargo/collection-report-list', $data);
        }
    }

    function income_expense_head() {
        $this->is_logged_in();

        $heads = $this->api_model->getCargoIEHead();
        $heads = json_decode($heads);
        $data['result'] = $heads->data;

        $data['credit_debit'] = $this->config->item('credit_debit');

        $this->load->view('site/cargo/income-expense-head', $data);
    }

    function update_income_expense_head() {
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('code'),
            'name' => $this->input->post('name'),
            'activeFlag' => $this->input->post('activeFlag'),
            'description' => $this->input->post('description'),
            'organizationCode' => $this->session->userdata('org_code'),
            'creditDebitFlag' => $this->input->post('creditDebitFlag')
        );
        echo $this->api_model->updateCargoIEHead($data);
    }

    function income_expense() {
        $this->is_logged_in();

        $heads = $this->api_model->getCargoIEHead();
        $heads = json_decode($heads);
        $data['heads'] = $heads->data;
        
        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;
        $data['transactionMode'] = config_item('transaction_mode');
        $data['credit_debit'] = $this->config->item('credit_debit');

        $this->load->view('site/cargo/income-expense', $data);
    }

    function update_income_expense() {
        $this->is_logged_in();

        $data = array(
            'activeFlag' => (int)$this->input->post('activeFlag'),
            'transactionDate' => $this->input->post('transactionDate') ?: date('Y-m-d'),
            'code' => $this->input->post('code'),
            'amount' => $this->input->post('amount'),
            'organizationCode' => $this->input->post('organizationCode'),
            'transactionMode' => $this->input->post('transactionMode'),
            'organizationCash' => $this->input->post('organizationCash'),
            'remarks' => $this->input->post('remarks'),
            'referenceCode' => $this->input->post('referenceCode')?: 'NA',
            'referenceTypeCode' => $this->input->post('referenceTypeCode')?: 'NA',
        );

        if (!has_action_rights('CGO-INEX-ALL-BRANCH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }
        
        echo $this->api_model->updateCargoIncExp($data);
    }

    function get_income_expense() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQF488B10',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'organizationCode' => $this->input->post('organizationCode')?:'NA',
            'cargoCode' => $this->input->post('cargoCode')?:'NA',
            'creditDebitFlag' => $this->input->post('creditDebitFlag')?:'NA',
            'vehicleCode' => $this->input->post('vehicleCode')?:'NA',
        );

        if (!has_action_rights('CGO-INEX-ALL-BRANCH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }
        
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $credit = array();
        $debit = array();
        foreach ($result->data as $row) {
            if ($row->transaction_type == 'Expanse') {
                if ($row->credit_debit_code == 'Cr') {
                    $credit[$row->organization_name][] = $row;
                } else if ($row->credit_debit_code == 'Dr') {
                    $debit[$row->organization_name][] = $row;
                }else if ($row->credit_debit_code == 'DDr') {
                    $debit[$row->organization_name][] = $row;
                }else if ($row->credit_debit_code == 'DCr') {
                    $credit[$row->organization_name][] = $row;
                }
            }
        }
        $data['credit'] = $credit;
        $data['debit'] = $debit;

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);

        $vehicle_mapped = array();
        foreach ($vehicles->data as $row) {
            $vehicle_mapped[$row->code] = $row;
        }
        $data['vehicle_mapped'] = $vehicle_mapped;
        
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/income-expense-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Income-Expense.xls');
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
            $this->load->view('site/cargo/income-expense-list', $data);
        }
    }
    
    function income_expense_transactions() {
        $this->is_logged_in();

        $heads = $this->api_model->getCargoIEHead();
        $heads = json_decode($heads);
        $data['heads'] = $heads->data;
        
        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;
        $data['transactionMode'] = config_item('transaction_mode');
        $data['credit_debit'] = $this->config->item('credit_debit');

        $this->load->view('site/cargo/income-expense-transactions', $data);
    }
    
    function get_income_expense_transactions_list() {
        $this->is_logged_in();
        
        $data = array(
            'queryCode' => 'RQF488B10',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'organizationCode' => $this->input->post('organizationCode')?:'',
            'paymentAcknowledgeStatusCode' => "PAID",
        );

        if (!has_action_rights('CGO-INEX-ALL-BRANCH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }
        
        $result = $this->api_model->getIncomeExpensePaidTransactions($data);
        $result = json_decode($result);
        $approved = array();
        foreach ($result->data as $row){
            $approved[$row->organizationCode][] = $row;
        }
        
        $data['approved'] = $approved;
        $org = array();
        
        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        
        foreach($branches->data as $row){
            $org[$row->code] = $row->name;
        }
        $data['org'] = $org;
        
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/income-expense-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Income-Expense.xls');
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
            $this->load->view('site/cargo/income-expense-transactions-list', $data);
        }
    }
    
    function get_income_expense_pending_transactions_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQF488B10',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'organizationCode' => $this->input->post('organizationCode')?:'',
        );

        if (!has_action_rights('CGO-INEX-ALL-BRANCH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }
        
        $result = $this->api_model->getIncomeExpenseTransactions($data);
        $result = json_decode($result);
        $pending = array();
        foreach ($result->data as $row){
            $pending[$row->organizationCode][] = $row;
        }
        
        $data['pending'] = $pending;
        $org = array();
        
        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        
        foreach($branches->data as $row){
            $org[$row->code] = $row->name;
        }
        $data['org'] = $org;

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);

        $vehicle_mapped = array();
        foreach ($vehicles->data as $row) {
            $vehicle_mapped[$row->code] = $row;
        }
        $data['vehicle_mapped'] = $vehicle_mapped;
               
               
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/income-expense-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Income-Expense.xls');
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
            $this->load->view('site/cargo/income-expense-paid-transactions-list', $data);
        }
    }

    function validate_income_expense() {
        $this->is_logged_in();

        $data = array(
            'organizationCode' => $this->input->post('organizationCode'),
            'cargoCode' => $this->input->post('cargoCode'),
            'headCode' => $this->input->post('headCode'),
        );

        if (!has_action_rights('CGO-INEX-ALL-BRANCH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }
        echo $this->api_model->valiateIncomeExpense($data);
    }
    
    function make_approval_income_expense(){
        $this->is_logged_in();

        $multipleCode = $this->input->post('multipleCode');
        if(count($multipleCode)){
            foreach($multipleCode as $row){
                $data = array(
                    'code' => $row,
                    'remarks' => $this->input->post('remarks')?: '',
                    'paymentAcknowledgeStatus' => array('code' => $this->input->post('paymentAcknowledgeStatus')),
                );

                $res = $this->api_model->makeApprovalIncomeExpense($data);

                $res = json_decode($res);

                if($res->status == 0) {
                    exit(json_encode($res));
                }
            }
            echo json_encode(array('status' => 1));
        }

    }

    function user_balance_report() {
        $this->is_logged_in();

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $users = $users->data;

        $usrbranch = array();
        foreach ($users as $row) {
            $usrbranch[$row->organization->name][] = $row;
        }
        ksort($usrbranch);
        $data['branchusers'] = $usrbranch;

        $this->load->view('site/cargo/user-balance-report', $data);
    }

    function user_balance_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQI9L7N4',
            'userCode' => $this->input->post('userCode') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $filterby = $this->input->post('filterby');
        if ($filterby == 'BRANCH') {
            $branchwise = [];
            foreach ($result->data as $row) {
                $branchwise[$row->organization_name]['total'] += $row->current_balance;
                $branchwise[$row->organization_name]['data'][] = $row;
            }
            $data['branchwise'] = $branchwise;
        } else {
        $data['result'] = $result->data;
        }
        $data['filterby'] = $filterby;

        if ($this->input->post('export') == 1) {
            if($filterby == 'BRANCH'){
                $filename = 'User-Balance-Report (Branch)';
            }else{
                $filename = 'User-Balance-Report (User)';
            }

            $this->load->excel('site/cargo/user-balance-report-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/user-balance-report-list', $data);
        }
    }

    function vendor_due_report() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQI9L7N4',
            'userCode' => 'NA',
            'organizationCode' => 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        if (is_array($result->data)) {
            usort($result->data, function($a, $b) {
                return $a->first_name < $b->first_name ? -1 : 1;
            });
        }

        $data['result'] = $result->data;

        if ($this->input->post('export') == 1) {
            $filename = 'Vendor-Due-Report';
            $this->load->excel('site/cargo/vendor-due-report-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/vendor-due-report', $data);
        }
    }

    function profit_and_loss() {
        $this->is_logged_in();

        $this->load->view('site/cargo/profit-and-loss');
    }

    function profit_and_loss_list() {
        $this->is_logged_in();

        $fromDate = $this->input->post('fromDate');
        $toDate = $this->input->post('toDate');

        $data = array(
            'queryCode' => 'RQI9RCG38',
            'fromDate' => $fromDate,
            'toDate' => $toDate
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $list = array();
        foreach ($result->data as $row) {
            $list['data'][$row->entity_type][] = $row;
            $list[$row->entity_type] += $row->entity_value;
        }
        $data['result'] = $list;

        if ($this->input->post('export') == 1) {
            $this->load->library('excel');
            $this->excel->getProperties()->setCreator('EzeeInfo')
                    ->setLastModifiedBy('EzeeInfo')
                    ->setTitle('Profit and Loss')
                    ->setSubject('Profit and Loss')
                    ->setDescription('Profit and Loss')
                    ->setKeywords('Profit and Loss')
                    ->setCategory('Account');
            $this->excel->setActiveSheetIndex(0);
            $this->excel->getActiveSheet()->setTitle('Profit and Loss');

            $row = 1;
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':Z' . $row)->getFont()->setBold(true);
            $this->excel->getActiveSheet()->mergeCells('A' . $row . ':D' . $row);
            $this->excel->getActiveSheet()->setCellValue('A' . $row, _get_namespace_name());
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':D' . $row)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':D' . $row++)->applyFromArray(
                    array(
                        'fill' => array(
                            'type' => PHPExcel_Style_Fill::FILL_SOLID,
                            'color' => array('rgb' => 'dff0d8')
                        )
                    )
            );

            $this->excel->getActiveSheet()->getStyle('A' . $row . ':Z' . $row)->getFont()->setBold(true);
            $this->excel->getActiveSheet()->mergeCells('A' . $row . ':D' . $row);
            $this->excel->getActiveSheet()->setCellValue('A' . $row, 'Profit and Loss');
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':D' . $row++)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $this->excel->getActiveSheet()->getStyle('A' . $row . ':Z' . $row)->getFont()->setBold(true);
            $this->excel->getActiveSheet()->mergeCells('A' . $row . ':D' . $row);
            $this->excel->getActiveSheet()->setCellValue('A' . $row, 'From ' . date('d-m-Y', strtotime($fromDate)) . ' To ' . date('d-m-Y', strtotime($toDate)));
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':D' . $row++)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $row++;
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':Z' . $row)->getFont()->setBold(true);
            $this->excel->getActiveSheet()->setCellValue('A' . $row, 'Income');
            $this->excel->getActiveSheet()->setCellValue('B' . $row, 'Paid');
            $this->excel->getActiveSheet()->setCellValue('C' . $row, 'Unpaid');
            $this->excel->getActiveSheet()->setCellValue('D' . $row, 'Total');
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':D' . $row++)->applyFromArray(
                    array(
                        'fill' => array(
                            'type' => PHPExcel_Style_Fill::FILL_SOLID,
                            'color' => array('rgb' => 'f5f5f5')
                        )
                    )
            );

            $row_index = $row;
            $this->excel->getActiveSheet()->setCellValue('A' . $row, 'Voucher');
            $this->excel->getActiveSheet()->setCellValue('B' . $row, $list['VOU_PAID']);
            $this->excel->getActiveSheet()->setCellValue('C' . $row, $list['VOU_INT']);
            $this->excel->getActiveSheet()->setCellValue('D' . $row++, $list['VOU_PAID'] + $list['VOU_INT']);

            $this->excel->getActiveSheet()->setCellValue('A' . $row, 'Invoice');
            $this->excel->getActiveSheet()->setCellValue('B' . $row, $list['INV_PAID']);
            $this->excel->getActiveSheet()->setCellValue('C' . $row, $list['INV_INT']);
            $this->excel->getActiveSheet()->setCellValue('D' . $row++, $list['INV_PAID'] + $list['INV_INT']);
            $this->excel->getActiveSheet()->setCellValue('A' . $row, 'Other Income');
            $this->excel->getActiveSheet()->setCellValue('D' . $row++, $list['INCOME']);
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':Z' . $row)->getFont()->setBold(true);
            $this->excel->getActiveSheet()->setCellValue('A' . $row, 'Total');
            $this->excel->getActiveSheet()->setCellValue('B' . $row, '=SUM(B' . $row_index . ':B' . ($row - 1) . ')');
            $this->excel->getActiveSheet()->setCellValue('C' . $row, '=SUM(C' . $row_index . ':C' . ($row - 1) . ')');
            $this->excel->getActiveSheet()->setCellValue('D' . $row, '=SUM(D' . $row_index . ':D' . ($row - 1) . ')');
            $this->excel->getActiveSheet()->getStyle('B' . $row_index . ':' . 'D' . $row)->getNumberFormat()->setFormatCode('0.00');
            $income = 'D' . $row;

            $row++;
            $row++;
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':Z' . $row)->getFont()->setBold(true);
            $this->excel->getActiveSheet()->setCellValue('A' . $row, 'Expense');
            $this->excel->getActiveSheet()->setCellValue('D' . $row, 'Total');
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':D' . $row++)->applyFromArray(
                    array(
                        'fill' => array(
                            'type' => PHPExcel_Style_Fill::FILL_SOLID,
                            'color' => array('rgb' => 'f5f5f5')
                        )
                    )
            );
            $row_index = $row;
            foreach ($list['data']['EXPANSE'] as $r) {
                $this->excel->getActiveSheet()->setCellValue('A' . $row, $r->entity_attribute);
                $this->excel->getActiveSheet()->setCellValue('D' . $row++, $r->entity_value);
            }
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':Z' . $row)->getFont()->setBold(true);
            $this->excel->getActiveSheet()->setCellValue('A' . $row, 'Total');
            $this->excel->getActiveSheet()->setCellValue('D' . $row, '=SUM(D' . $row_index . ':D' . ($row - 1) . ")");
            $expense = 'D' . $row;

            $row++;
            $row++;
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':Z' . $row)->getFont()->setBold(true);
            $this->excel->getActiveSheet()->setCellValue('A' . $row, 'Net Profit / Loss');
            $this->excel->getActiveSheet()->setCellValue('D' . $row, '=' . $income . '-' . $expense);
            $this->excel->getActiveSheet()->getStyle('D' . $row_index . ':' . 'D' . $row)->getNumberFormat()->setFormatCode('0.00');
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':D' . $row++)->applyFromArray(
                    array(
                        'fill' => array(
                            'type' => PHPExcel_Style_Fill::FILL_SOLID,
                            'color' => array('rgb' => 'f5f5f5')
                        )
                    )
            );

            $this->excel->getActiveSheet()->getColumnDimensionByColumn('A')->setAutoSize(false);
            $this->excel->getActiveSheet()->getColumnDimensionByColumn('A')->setWidth('40');
            $this->excel->getActiveSheet()->setSelectedCells('A1');

            $filename = 'Profit and Loss.xls';
            header('Content-Type: application/vnd.ms-excel');
            header('Content-Disposition: attachment;filename="' . $filename . '"');
            header('Cache-Control: max-age=0');
            $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
            $objWriter->setPreCalculateFormulas(true);
            $objWriter->save('php://output');
        } else {
            echo $this->load->view('site/cargo/profit-and-loss-list', $data);
        }
    }

    function set_schedule_state() {
        $this->is_logged_in();
        echo $this->api_model->saveCargoScheduleBasicInfo(array(
            'code' => $this->input->post('sch_code'),
            'activeFlag' => $this->input->post('sch_state')
        ));
    }

    function pickup_delivery_report() {
        $this->is_logged_in();

        if (has_action_rights('CGO-PKDYRPT-ALL-BRAH')) {
            list($stations, $routes) = get_routes_and_stations();
            $data['stations'] = $stations;

            $branches = $this->api_model->getOrganization();
            $branches = json_decode($branches);
            if (is_array($branches->data)) {
                usort($branches->data, function($a, $b) {
                    return $a->name < $b->name ? -1 : 1;
                });
            }
            $data['branches'] = $branches->data;
        }

        $this->load->view('site/cargo/pickup-delivery-report', $data);
    }

    function pickup_delivery_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQJ1VCV38',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'organizationCode' => $this->input->post('organizationCode'),
            'filterCode' => $this->input->post('filterCode')
        );

        if (!has_action_rights('CGO-PKDYRPT-ALL-BRAH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['result'] = $result->data;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $filename = 'Pickup-Delivery-Report';
            $this->load->excel('site/cargo/pickup-delivery-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/pickup-delivery-report-list', $data);
        }
    }

    function sales_summary_report() {
        $this->is_logged_in();

        $data['groupusers'] = get_active_group_and_users();
        $this->load->view('site/cargo/sales-summary-report', $data);
    }

    function sales_summary_report_list() {
        $this->is_logged_in();

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $data = array(
            'queryCode' => 'RQJ1VCW40',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'userCode' => $this->input->post('userCode'),
            'dateType' => $this->input->post('dateType'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['result'] = $result->data;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/sales-summary-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Sales-Summary-Report.xls');
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
            $this->load->view('site/cargo/sales-summary-report-list', $data);
        }
    }

    function cancellation_report() {
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;
        $data['groupusers'] = get_active_group_and_users();

        $this->load->view('site/cargo/cancellation-report', $data);
    }

    function cancellation_report_list() {
        $this->is_logged_in();
        
        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
        $fromDate = $fromDate ? date('Y-m-d', strtotime($fromDate)) : 'NA';
        $toDate = $toDate ? date('Y-m-d', strtotime($toDate)) : 'NA';

        $data = array(
            'queryCode' => 'RQJ1VCW39',
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'userCode' => $this->input->post('userCode'),
            'groupCode' => $this->input->post('groupCode'),
            'fromStationCode' => $this->input->post('fromStationCode'),
            'toStationCode' => $this->input->post('toStationCode')
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['result'] = $result->data;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/cancellation-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Cancellation-Report.xls');
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
            $this->load->view('site/cargo/cancellation-report-list', $data);
        }
    }

    public function user_collection_report() {
        $this->is_logged_in();
        $data = array();

        $data['groupusers'] = get_active_group_and_users();

        $this->load->view('site/cargo/user-collection-report', $data);
    }

    public function user_collection_report_list() {
        $this->is_logged_in();
        
        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
        $fromDate = date('Y-m-d', strtotime($fromDate));
        $toDate = date('Y-m-d', strtotime($toDate));
        $data = array(
            'queryCode' => 'RQJ4BF4746',
             'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'userCode' => $this->input->post('userCode'),
            'filterCode' => 'TRANSACTION'
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $summary = array();
        foreach ($result->data as $row) {
            if ($row->transaction_type_code == 'CGDL') {
                $user = $row->delivered_user_first_name;
                $summary[$user]['user_code'] = $row->delivered_user_code;
                $summary[$user][$row->transaction_type_code]['count']++;
                $summary[$user][$row->transaction_type_code]['user_code'] = $row->user_code;
                $summary[$user][$row->transaction_type_code]['commission'] += $row->commission_amount;

            } else if ($row->transaction_type_code == 'CGBO' || $row->transaction_type_code == 'CGTBO') {
                $user = $row->user_first_name;
                $summary[$user][$row->transaction_type_code]['count']++;
                $summary[$user]['user_code'] = $row->user_code;
                $summary[$user][$row->transaction_type_code]['net_amount'] += $row->transaction_amount;
                $summary[$user][$row->transaction_type_code]['commission'] += $row->commission_amount;
                $summary[$user][$row->transaction_type_code]['payable'] += ($row->transaction_amount - $row->commission_amount);
            }
        }
        $data['summary'] = $summary;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $filename = 'User-collection-Report';
            $this->load->excel('site/cargo/user-collection-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/user-collection-report-list', $data);
        }
    }

    public function user_collection_report_details() {
        $this->is_logged_in();

        $userCode = $this->input->post('userCode');
        $data = array(
            'queryCode' => 'RQJ4BF4746',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'userCode' => $userCode,
            'filterCode' => 'TRANSACTION'
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $summary = array();
        foreach ($result->data as $row) {
            if ($row->user_code == $userCode || $row->delivered_user_code == $userCode) {
                $summary[$row->transaction_type_code][$row->payment_status_code][] = $row;
            }
        }

        $data['summary'] = $summary;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/user-collection-report-details', $data);
    }

    public function ogpl() {
        $this->is_logged_in();

        if ($this->input->get('fill') == 1) {
            $data['ffromDate'] = $this->session->userdata('ogpl_search_from');
            $data['ftoDate'] = $this->session->userdata('ogpl_search_to');
            $data['fvehicle'] = $this->session->userdata('ogpl_vehicle');
            $data['faliasode'] = $this->session->userdata('ogpl_aliascode');
            $data['flastactive'] = $this->session->userdata('ogpl_last_active');
        }

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $this->load->view('site/cargo/ogpl', $data);
    }

    public function ogpl_list() {
        $this->is_logged_in();

        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));

        $fromDate = $fromDate ? date('Y-m-d', strtotime($fromDate)) : 'NA';
        $toDate = $toDate ? date('Y-m-d', strtotime($toDate)) : 'NA';

        $this->session->set_userdata('ogpl_search_from', $fromDate);
        $this->session->set_userdata('ogpl_search_to', $toDate);
        $this->session->set_userdata('ogpl_vehicle', $this->input->post('vehicleCode'));
        $this->session->set_userdata('ogpl_aliascode', $this->input->post('aliasCode'));

        $param = array(
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'vehicleCode' => trim($this->input->post('vehicleCode')),
            'transitCode' => 'NA',
            'aliasCode' => trim($this->input->post('aliasCode')),
            'organizationCode' => 'NA',
            'activityType' => 'NA',
            'transitType' => 'TRNT'
        );
        if (!has_action_rights('OGPL-ALL-BRCH')) {
            $param['organizationCode'] = $this->session->userdata('org_code');
        }
        $result = $this->api_model->cargoGetOGPLListv2($param);
        $result = json_decode($result);
        $result->data = array_reverse($result->data);
        $data['result'] = $result->data;
        $groupedOdameter = array();

       foreach($result->data as $row){
        foreach($row->transitCargoDetails as $transitCargoDetails){
            if($row->fromStation->code == $transitCargoDetails->fromStation->code){
                if($transitCargoDetails->startOdometer){
                $groupedOdameter[$row->aliasCode][$transitCargoDetails->fromStation->code]['start'] = 1;
                $groupedOdameter[$row->aliasCode][$transitCargoDetails->fromStation->code]['end'] += 0;
            }
            else {
                $groupedOdameter[$row->aliasCode][$transitCargoDetails->fromStation->code]['start'] += 0;
                $groupedOdameter[$row->aliasCode][$transitCargoDetails->fromStation->code]['end'] += 0;

            }

            if($transitCargoDetails->endOdometer){
                $groupedOdameter[$row->aliasCode][$transitCargoDetails->toStation->code]['end'] += 1;
               $groupedOdameter[$row->aliasCode][$transitCargoDetails->toStation->code]['start'] += 0;
        }else {
            $groupedOdameter[$row->aliasCode][$transitCargoDetails->toStation->code]['end'] += 0;
            $groupedOdameter[$row->aliasCode][$transitCargoDetails->toStation->code]['start'] += 0;
        }
        
       }
       else {
        if($transitCargoDetails->startOdometer){
            $groupedOdameter[$row->aliasCode][$transitCargoDetails->fromStation->code]['start'] += 1;
            $groupedOdameter[$row->aliasCode][$transitCargoDetails->fromStation->code]['end'] += 0;
        }
        else {
            $groupedOdameter[$row->aliasCode][$transitCargoDetails->fromStation->code]['start'] += 0;
            $groupedOdameter[$row->aliasCode][$transitCargoDetails->fromStation->code]['end'] += 0;
        }

        if($transitCargoDetails->endOdometer){
            $groupedOdameter[$row->aliasCode][$transitCargoDetails->toStation->code]['end'] += 1;
           $groupedOdameter[$row->aliasCode][$transitCargoDetails->toStation->code]['start'] += 0;
    }else {
        $groupedOdameter[$row->aliasCode][$transitCargoDetails->toStation->code]['end'] += 0;
        $groupedOdameter[$row->aliasCode][$transitCargoDetails->toStation->code]['start'] += 0;
    }
       }
    }
}

          list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
       
       $data['groupedOdameter'] = $groupedOdameter;

       
        // $newStatus = array();
        // $intransitStatus = array();
        // $completedStatus = array();
        // foreach ($result->data as $key=>$val) {
        //     if ($val->transitStatus->code == 'EMPLD' || in_array('EMP-LOAD', $val->activity) || $val->transitStatus->code == 'NEW') {
        //         $val->ogplStatus = 'NEW';
        //         $newStatus[] = $val;
        //     } elseif ($val->transitStatus->code == 'INTRN') {
        //         $val->ogplStatus = 'INTRN';
        //         $intransitStatus[] = $val;
        //     } elseif ($val->transitStatus->code == 'TRNSFR' || $val->transitStatus->code == 'CMPLT') {
        //         $val->ogplStatus = 'CMPLT';
        //         $completedStatus[] = $val;
        //     }
        // }

        $tabs = array();
        foreach ($result->data as $row) {
            if (in_array('PNDG-ARRVL', $row->activity)) {
                $tabs['ARRIVAL'][] = $row;
            } else if (in_array('YET-DEPTR', $row->activity)) {
                $tabs['DEPARTURE'][] = $row;
            } else if (in_array('DISPATCH', $row->activity)) {
                $tabs['DISPATCH'][] = $row;
            } else if (in_array('TRIP-CLOSE', $row->activity)) {
                $tabs['COMPLETE'][] = $row;
            } else {
                $tabs['DISPATCH'][] = $row;
            }
        }

        $vehicleTransit = [];
        foreach (array_reverse($result->data) as $row) {
            if ($row->busVehicle->code) {
                $vehicleTransit[$row->busVehicle->code] = $row->code;
            }
        }
        $data['vehicleTransit'] = $vehicleTransit;

        $data['cargo_setting'] = _get_cargo_settings();
        // $data['newStatus'] = $newStatus;
        // $data['intransitStatus'] = $intransitStatus;
        // $data['completedStatus'] = $completedStatus;
        $data['tabs'] = $tabs;
        $data['aliasCodeFilter'] = trim($this->input->post('aliasCode'));
        $data['fogplLastActive'] = $this->input->post('lastActiveCode');
        $data['login_station'] = $this->session->userdata('org_station_code');
        $data['org_station_code'] = $this->session->userdata('org_station_code');
        $data['login_station_name'] = $this->session->userdata('org_station_name');
        $data['login_branch'] = $this->session->userdata('org_code');
        $data['transittype'] = $this->input->post('transittypes');
        $data['transittypeout'] = $this->input->post('transittypeout');
        $data['activityType'] = config_item('activityType');
        $this->load->view('site/cargo/ogpl-list', $data);
    }

    public function add_ogpl() {
        $this->is_logged_in();

        $data = array();
        $data['login_user'] = $this->session->userdata('user_id');
        $data['login_branch'] = $this->session->userdata('org_code');
        $data['login_station'] = $this->session->userdata('org_station_code');
        $data['login_station_name'] = $this->session->userdata('org_station_name');
        $data['namespaceCode'] = $this->session->userdata('namespace_id');

        $transitCode = $this->input->get('transitCode');
        if ($transitCode) {
            $ogpl = $this->api_model->cargoOGPLDetails(array(
                'transitCode' => $transitCode
            ));
            $ogpl = json_decode($ogpl);
            $data['ogpl'] = $ogpl->data;

            $odoDetails = $this->api_model->getTransitOdometer(array(
                'transitCode' => $transitCode
            ));
            $odoDetails = json_decode($odoDetails);
            foreach ($odoDetails->data as $row) {
                if ($row->organization->code == $ogpl->data->fromOrganization->code) {
                    $data['odoDetails'] = $row;
                }
            }

            $contact = $this->api_model->getContact();
            $contact = json_decode($contact);
            $data['vendors'] = $contact->data;

            $con = array();
            foreach($contact->data as $key=>$val){
                $con[$val->contactCategory->name][$key] = $val;
                $con[$val->contactCategory->name][$key] = $val;
            }
            
            $data['contact'] = $con;
        }
        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $vehicles = $this->api_model->getAllVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;

        $ownershipTypes = array();
        foreach ($vehicles->data as $vehicle) {
            $ownershipTypes[$vehicle->ownershipType->code] = $vehicle->ownershipType->name;
        }
        $data['ownershipTypes'] = $ownershipTypes;

        $drivers = $this->api_model->getVehicleDriver(array(
            'activeFlagFilter' => 1
        ));
        $drivers = json_decode($drivers);
        $data['drivers'] = $drivers->data;

        $tpl = $this->api_model->getOGPLTemplate();
        $tpl = json_decode($tpl);
        usort($tpl->data, function($a, $b) {
            return (trim($a->name) < trim($b->name)) ? -1 : 1;
        });
        $data['ogpltpl'] = $tpl->data;

        $branchContact = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $branchContact = json_decode($branchContact);
        $data['branchContact'] = $branchContact->data;

        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['zone'] = $zone->data;

        $data['linkVehicleCode'] = $this->input->get('linkVehicleCode');
        $data['linkTransitType'] = $this->input->get('linkTransitType');
        $data['localTransitSearchData'] = $this->input->get('linkTransitCode');
        $data['cargo_setting'] = _get_cargo_settings();
        $data['f_t_mode'] = config_item('transaction_mode');

        $fromOrg  = $data['ogpl']->fromOrganization->code;
        $isBranchcode = $data['login_branch'];
        if ($data['cargo_setting']->ogplModelCode == "VER3") {
            $show_end_odo = 0;
            if ($transitCode) {
                $odoDetails = $this->api_model->getTransitOdometer(array(
                    'transitCode' => $transitCode
                ));
                $odoDetails = json_decode($odoDetails);
                foreach ($odoDetails->data as $row) {
                    //login user odometer updation details
                    if ($row->organization->code == $isBranchcode) {
                        $data['odoDetails'] = $row;
                    }
                    //ogpl creater odometer updated details
                    if($row->organization->code == $fromOrg) {
                        $data['OrginOdoDetails'] = $row;
                    }
                }
                $odoBranches = array();
                foreach ($odoDetails->data as $row) {
                    array_push($odoBranches, $row->organization->code);
                }

                $station_in_via = '';

                if ($ogpl->data->fromStation->code == $this->session->userdata('org_station_code')) {
                    $station_in_via = $ogpl->data->fromStation->code;
                }
                
                foreach ($ogpl->data->viaStations as $row) {
                    if ($row->code == $this->session->userdata('org_station_code')) {
                        $station_in_via = $row->code;
                    }
                }

                foreach ($ogpl->data->hubViaStations as $row) {
                    if ($row->code == $this->session->userdata('org_station_code')) {
                        $station_in_via = $row->code;
                    }
                }

                foreach ($ogpl->data->localViaStations as $row) {
                    if ($row->code == $this->session->userdata('org_station_code')) {
                        $station_in_via = $row->code;
                    }
                }

                if (isNotNull($station_in_via) && !in_array($data['userorgcode'], $odoBranches)) {
                    $show_end_odo = 1;
                }
            }

            $bankdetail = $this->api_model->getOrganizationOtherDetails(array(
                'organizationcode' => $this->session->userdata('org_code')
            ));
            $bankdetail = json_decode($bankdetail);
            $data['bankdetail'] = $bankdetail->data->bankDetails;

            $data['show_end_odo'] = $show_end_odo;
            $data['bank_names_list'] = $this->config->item('bank_names_list');
            $data['cargo_additional'] = config_item('cargo_additional');

            $this->load->view('site/cargo/add-ogplv3', $data);
        } else {
            $this->load->view('site/cargo/add-ogplv2', $data);
        }
    }
    function transitv3_get_lrs(){
       $this->is_logged_in();
            $data=array(
                'queryCode' => 'RQJ4KJU47',
                'fromDate' => $this->input->post('fromDate') ?: 'NA',
                'toDate' =>$this->input->post('toDate') ?: 'NA',
                'fromStationCode' => 'NA',
                'toStationCode' => $this->input->post('toStationCode') ?: 'NA',
                'viaStationCodes' => $this->input->post('viaStationCodes') ?: 'NA',
                'transitOrganizationCode' => $this->input->post('transitOrganizationCode') ?: $this->session->userdata('org_code'),
                'transitTypeCode' => 'TRNT',
                'cargoCode' => $this->input->post('cargoCode') ?: 'NA',
            );
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $result = json_decode($result);

            $toloaded = array();

            foreach ($result->data as $row) {
                $toloaded[$row->to_organization_code]['data'][] =$row;
                $toloaded[$row->to_organization_code]['name'] = $row->to_organization_name;
                $toloaded[$row->to_organization_code]['article'] += $row->total_item_count;
                $toloaded[$row->to_organization_code]['lr'] += 1;   
            }

            // uasort($toloaded, function($a, $b) {
            //     return $a['name'] < $b['name'] ? -1 : 1;
            // });

            foreach ($toloaded as $dataList) {
                usort($dataList, function($a, $b) {
                    $aExpdl = strpos($a->additional_status_code, 'EXPDL') !== false;
                    $bExpdl = strpos($b->additional_status_code, 'EXPDL') !== false;

                    $aHdlwc = strpos($a->additional_status_code, 'HDLWC') !== false;
                    $bHdlwc = strpos($b->additional_status_code, 'HDLWC') !== false;

                    if ($aExpdl && !$bExpdl) {
                        return -1;
                    }
                    if (!$aExpdl && $bExpdl) {
                        return 1;
                    }
                    return 0;
                });
            }
            $data['direct_load_lr'] = $toloaded;
            
            $alphabet= array();
            foreach ($result->data as $row) {
                $alphabetFirst = strtoupper(substr($row->to_organization_name, 0, 1));
                $alphabet[$row->to_organization_code]['alphabet'] = $alphabetFirst;
            }

            uasort($alphabet, function($a, $b) {
                return $a['alphabet'] < $b['alphabet'] ? -1 : 1;
            });
            $alphabetFirst = array_column($alphabet, 'alphabet');
            $data['alphabet_letters'] = array_values(array_unique($alphabetFirst));
            
            $branches = $this->api_model->getCargoOrganization();
            $branches = json_decode($branches);
            $data['branches'] = $branches->data;
            
            $data['ogpl_via'] = $this->input->post('ogplVia');
            $data['usr_org_code'] = $this->session->userdata('org_code');
            $data['usr_station_code'] = $this->session->userdata('org_station_code');
            $data['cargo_status'] = config_item('cargo_status');
            $data['cargo_additional'] = config_item('cargo_additional');
            $data['cargo_setting'] = _get_cargo_settings();
            echo json_encode($data);
    }

    function transitv3_get_direct_load_lrs() {
        $this->is_logged_in();

        // DIRECT LOAD
        $fromDate = $this->input->post('fromDate') ?: date('Y-m-d', strtotime('-3 months'));
        $toDate = $this->input->post('toDate') ?: date('Y-m-d');
        $data = $requestData = array(
            'queryCode' => 'RQJ4KJU47',
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'fromStationCode' => 'NA',
            'toStationCode' => $this->input->post('toStationCode') ?: 'NA',
            'viaStationCodes' => $this->input->post('viaStationCodes') ?: 'NA',
            'transitOrganizationCode' => $this->input->post('transitOrganizationCode') ?: $this->session->userdata('org_code'),
            'transitTypeCode' => 'TRNT',
            'cargoCode' => $this->input->post('cargoCode') ?: 'NA',
        );
       
        if (!has_action_rights('OGPL-HUB-LOAD')) {
            $data['transitOrganizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $toloaded = array();

        

        foreach ($result->data as $row) {
            $toloaded[$row->to_organization_code]['data'][] =$row;
            $toloaded[$row->to_organization_code]['name'] = $row->to_organization_name;
            $toloaded[$row->to_organization_code]['article'] += $row->total_item_count;
            $toloaded[$row->to_organization_code]['lr'] += 1;   
        }

        // uasort($toloaded, function($a, $b) {
        //     return $a['name'] < $b['name'] ? -1 : 1;
        // });

        foreach ($toloaded as $dataList) {
            usort($dataList, function($a, $b) {
                $aExpdl = strpos($a->additional_status_code, 'EXPDL') !== false;
                $bExpdl = strpos($b->additional_status_code, 'EXPDL') !== false;
    
                $aHdlwc = strpos($a->additional_status_code, 'HDLWC') !== false;
                $bHdlwc = strpos($b->additional_status_code, 'HDLWC') !== false;
    
                if ($aExpdl && !$bExpdl) {
                    return -1;
                }
                if (!$aExpdl && $bExpdl) {
                    return 1;
                }
                return 0;
        });
        }
        $data['direct_load_lr'] = $toloaded;
        
        $alphabet= array();
        foreach ($result->data as $row) {
            $alphabetFirst = strtoupper(substr($row->to_organization_name, 0, 1));
            $alphabet[$row->to_organization_code]['alphabet'] = $alphabetFirst;
        }

        uasort($alphabet, function($a, $b) {
            return $a['alphabet'] < $b['alphabet'] ? -1 : 1;
        });
        $alphabetFirst = array_column($alphabet, 'alphabet');
        $data['alphabet_letters'] = array_values(array_unique($alphabetFirst));
        
        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;
        $data['reporting_branch'] = null;
        foreach($branches->data as $val){
           if($this->session->userdata('org_code') == $val->code){
               if(count($val->subOrganizations)){
                $data['reporting_branch'] = $val->subOrganizations;
                break;
               }
             break;
           }
        }
        $data['ogpl_via'] = $this->input->post('ogplVia');
        $data['usr_org_code'] = $this->session->userdata('org_code');
        $data['usr_station_code'] = $this->session->userdata('org_station_code');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_setting'] = _get_cargo_settings();
        // $requestData['ogpl_via'] = $data['ogpl_via'];
        $data['body']=$requestData;
        
        $this->load->view('site/cargo/transitv3-get-direct-load-lrs', $data);
    }

    function transitv3_get_link_load_lrs() {
        $this->is_logged_in();

        // Link LOAD
        $fromDate = $this->input->post('fromDate') ?: date('Y-m-d', strtotime('-3 months'));
        $toDate = $this->input->post('toDate') ?: date('Y-m-d');
        $data = $requestData = array(
            'queryCode' => 'RQJ4KJU47',
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'fromStationCode' => 'NA',
            'toStationCode' => $this->input->post('toStationCode') ?: 'NA',
            'viaStationCodes' => $this->input->post('viaStationCodes') ?: 'NA',
            'transitOrganizationCode' => $this->input->post('transitOrganizationCode') ?: $this->session->userdata('org_code'),
            'transitTypeCode' => 'TRNT',
            'cargoCode' => $this->input->post('cargoCode') ?: 'NA',
        );
        if (!has_action_rights('OGPL-HUB-LOAD')) {
            $data['transitOrganizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $toloaded = array();

        foreach ($result->data as $row) {
            $toloaded[$row->to_organization_code]['data'][] = $row;
            $toloaded[$row->to_organization_code]['name'] = $row->to_organization_name;
            $toloaded[$row->to_organization_code]['article'] += $row->total_item_count;
            $toloaded[$row->to_organization_code]['lr'] += 1;
        }

        // uasort($toloaded, function($a, $b) {
        //     return $a['name'] < $b['name'] ? -1 : 1;
        // });
        foreach ($toloaded as $dataList) {
            usort($dataList, function($a, $b) {
                $aExpdl = strpos($a->additional_status_code, 'EXPDL') !== false;
                $bExpdl = strpos($b->additional_status_code, 'EXPDL') !== false;
    
                $aHdlwc = strpos($a->additional_status_code, 'HDLWC') !== false;
                $bHdlwc = strpos($b->additional_status_code, 'HDLWC') !== false;
    
                if ($aExpdl && !$bExpdl) {
                    return -1;
                }
                if (!$aExpdl && $bExpdl) {
                    return 1;
                }
                return 0;
            });
        }
        $data['link_load_lr'] = $toloaded;

        $alphabet= array();
        foreach ($result->data as $row) {
            $alphabetFirst = strtoupper(substr($row->to_organization_name, 0, 1));
            $alphabet[$row->to_organization_code]['alphabet'] = $alphabetFirst;
        }

        uasort($alphabet, function($a, $b) {
            return $a['alphabet'] < $b['alphabet'] ? -1 : 1;
        });
        $alphabetFirst = array_column($alphabet, 'alphabet');
        $data['alphabet_letters'] = array_values(array_unique($alphabetFirst));

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;
        $data['reporting_branch'] = null;
        foreach($branches->data as $val){
           if($this->session->userdata('org_code') == $val->code){
               if(count($val->subOrganizations)){
                $data['reporting_branch'] = $val->subOrganizations;
                break;
               }
             break;
           }
        }
        
        $data['ogpl_via'] = $this->input->post('ogplVia');
        $data['usr_org_code'] = $this->session->userdata('org_code');
        $data['usr_station_code'] = $this->session->userdata('org_station_code');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_setting'] = _get_cargo_settings();
        // $requestData['ogpl_via'] = json_encode($data['ogpl_via']);
        $data['body']=$requestData;
        
        $this->load->view('site/cargo/transitv3-get-link-load-lrs', $data);
    }

    function transitv3_get_local_transit_lrs() {
        $this->is_logged_in();

        // Local Transit LOAD
        $fromDate = $this->input->post('fromDate') ?: date('Y-m-d', strtotime('-3 months'));
        $toDate = $this->input->post('toDate') ?: date('Y-m-d');
        $data = $requestData = array(
            'queryCode' => 'RQJ4KJU47',
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'fromStationCode' => 'NA',
            'toStationCode' => $this->input->post('toStationCode') ?: 'NA',
            'viaStationCodes' => 'NA',
            'transitOrganizationCode' => $this->input->post('transitOrganizationCode') ?: $this->session->userdata('org_code'),
            'transitTypeCode' => 'INTRNT',
            'cargoCode' => $this->input->post('cargoCode') ?: 'NA',
        );
        if (!has_action_rights('OGPL-HUB-LOAD')) {
            $data['transitOrganizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $toloaded = array();

        
        foreach ($result->data as $row) {
            $toloaded[$row->to_organization_code]['data'][] = $row;
            $toloaded[$row->to_organization_code]['name'] = $row->to_organization_name;
            $toloaded[$row->to_organization_code]['article'] += $row->total_item_count;
            $toloaded[$row->to_organization_code]['lr'] += 1;
        }

        // uasort($toloaded, function($a, $b) {
        //     return $a['name'] < $b['name'] ? -1 : 1;
        // });
        foreach ($toloaded as $dataList) {
            usort($dataList, function($a, $b) {
                $aExpdl = strpos($a->additional_status_code, 'EXPDL') !== false;
                $bExpdl = strpos($b->additional_status_code, 'EXPDL') !== false;
    
                $aHdlwc = strpos($a->additional_status_code, 'HDLWC') !== false;
                $bHdlwc = strpos($b->additional_status_code, 'HDLWC') !== false;
    
                if ($aExpdl && !$bExpdl) {
                    return -1;
                }
                if (!$aExpdl && $bExpdl) {
                    return 1;
                }
                return 0;
            });
        }
        $data['local_transit_load_lr'] = $toloaded;

        $alphabet= array();
        foreach ($result->data as $row) {
            $alphabetFirst = strtoupper(substr($row->to_organization_name, 0, 1));
            $alphabet[$row->to_organization_code]['alphabet'] = $alphabetFirst;
        }

        uasort($alphabet, function($a, $b) {
            return $a['alphabet'] < $b['alphabet'] ? -1 : 1;
        });
        $alphabetFirst = array_column($alphabet, 'alphabet');
        $data['alphabet_letters'] = array_values(array_unique($alphabetFirst));

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;
        $data['reporting_branch'] = null;
        foreach($branches->data as $val){
           if($this->session->userdata('org_code') == $val->code){
               if(count($val->subOrganizations)){
                $data['reporting_branch'] = $val->subOrganizations;
                break;
               }
             break;
           }
        }
        
        $data['ogpl_via'] = $this->input->post('ogplVia');
        $data['usr_org_code'] = $this->session->userdata('org_code');
        $data['usr_station_code'] = $this->session->userdata('org_station_code');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_setting'] = _get_cargo_settings();
        
        // $requestData['ogpl_via'] = json_encode($data['ogpl_via']);
        $data['body']=$requestData;
        $this->load->view('site/cargo/transitv3-get-local-transit-lrs', $data);
    }

    function transitv3_get_out_for_delivery_transit_lrs() {
        $this->is_logged_in();

        $fromDate = $this->input->post('fromDate') ?: date('Y-m-d', strtotime('-3 months'));
        $toDate = $this->input->post('toDate') ?: date('Y-m-d');
        $data = array(
            'queryCode' => 'RQJ4KJU47',
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'fromStationCode' => 'NA',
            'toStationCode' => $this->input->post('toStationCode') ?: 'NA',
            'viaStationCodes' => 'NA',
            'transitOrganizationCode' => $this->input->post('transitOrganizationCode') ?: $this->session->userdata('org_code'),
            'transitTypeCode' => 'OTFD',
            'cargoCode' => $this->input->post('cargoCode') ?: 'NA',
        );
        if (!has_action_rights('OGPL-HUB-LOAD')) {
            $data['transitOrganizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $toloaded = array();
        foreach ($result->data as $row) {
            $toloaded[$row->to_organization_code]['data'][] = $row;
            $toloaded[$row->to_organization_code]['name'] = $row->to_organization_name;
            $toloaded[$row->to_organization_code]['article'] += $row->total_item_count;
            $toloaded[$row->to_organization_code]['lr'] += 1;
        }

        // uasort($toloaded, function($a, $b) {
        //     return $a['name'] < $b['name'] ? -1 : 1;
        // });
        foreach ($toloaded as $dataList) {
            usort($dataList, function($a, $b) {
                $aExpdl = strpos($a->additional_status_code, 'EXPDL') !== false;
                $bExpdl = strpos($b->additional_status_code, 'EXPDL') !== false;
    
                $aHdlwc = strpos($a->additional_status_code, 'HDLWC') !== false;
                $bHdlwc = strpos($b->additional_status_code, 'HDLWC') !== false;
    
                if ($aExpdl && !$bExpdl) {
                    return -1;
                }
                if (!$aExpdl && $bExpdl) {
                    return 1;
                }
                return 0;
            });
        }
        $data['ofd_transit_load_lr'] = $toloaded;

        $alphabet= array();
        foreach ($result->data as $row) {
            $alphabetFirst = strtoupper(substr($row->to_organization_name, 0, 1));
            $alphabet[$row->to_organization_code]['alphabet'] = $alphabetFirst;
        }

        uasort($alphabet, function($a, $b) {
            return $a['alphabet'] < $b['alphabet'] ? -1 : 1;
        });
        $alphabetFirst = array_column($alphabet, 'alphabet');
        $data['alphabet_letters'] = array_values(array_unique($alphabetFirst));

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;
        
        $data['ogpl_via'] = $this->input->post('ogplVia');
        $data['usr_org_code'] = $this->session->userdata('org_code');
        $data['usr_station_code'] = $this->session->userdata('org_station_code');
        $data['cargo_status'] = config_item('cargo_status');
        
        $this->load->view('site/cargo/transitv3-get-out-for-delivery-transit-lrs', $data);
    }

    public function save_transitv3() {
        $this->is_logged_in();

        $saveAsTemplate = $this->input->post('saveAsTemplate');

        if ($saveAsTemplate == 1) {
            $tpl = $this->api_model->updateOGPLTemplate(array(
                'activeFlag' => $this->input->post('activeFlag'),
                'viaStations' => $this->input->post('viaStations') ?: [],
                'fromStation' => $this->input->post('fromStation'),
                'toStation' => $this->input->post('toStation'),
                'name' => $this->input->post('name'),
                'arrivalMinutes' => (int) $this->input->post('arrivalMinutes'),
                'departureMinutes' => (int) $this->input->post('departureMinutes'),
            ));
            $tpl = json_decode($tpl);

            if ($tpl->status != 1) {
                echo json_encode($tpl);
                return;
            }
        }

        $fromOrganization = $this->input->post('fromOrganization');
        $toOrganization = $this->input->post('toOrganization');
        $fromOrganizationCode = isset($fromOrganization['code']) ? $fromOrganization['code'] : 'NA';
        $toOrganizationCode = isset($toOrganization['code']) ? $toOrganization['code'] : 'NA';

        $ogpl = $this->api_model->cargoOGPLupdate(array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code') ?: '',
            'name' => $this->input->post('name'),
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation'),
            'fromOrganization' => array('code' =>$fromOrganizationCode?$fromOrganizationCode:"NA" ),
            'toOrganization' => array('code' => $toOrganizationCode?$toOrganizationCode:"NA"),
            'viaStations' => $this->input->post('viaStations') ?: [],
            'viaZones' => $this->input->post('viaZones') ?: [],
            'hubViaStations' => $this->input->post('linkLoadStations') ?: [],
            'hubViaZones' => $this->input->post('hubViaZones') ?: [],
            'localViaOrganizations' => $this->input->post('localViaOrganizations') ?: [],
            'tripDate' => $this->input->post('tripDate'),
            'busVehicle' => $this->input->post('busVehicle'),
            'supervisor' => $this->input->post('supervisor'),
            'vehicleDriver' => $this->input->post('vehicleDriver'),
            'secondaryDriver' => $this->input->post('secondaryDriver') ?: ['code' => ''],
            // 'cargoActivityType' => array('code' => 'TRNT'),
            'activityType' => $this->input->post('activityType'),
            'remarks' => $this->input->post('remarks') ?: '',
            'arrivalMinutes' => (int) hoursTominutes(date('H:i')),
            'departureMinutes' => (int) hoursTominutes(date('H:i')),
            'odometer' => $this->input->post('odometer') ?: '',
            'transitReference' => $this->input->post('transitReference') ?: [],
        ));

        $ogpl = json_decode($ogpl);

        if ($ogpl->status != 1) {
            echo json_encode($ogpl);
            return;
        }

        $directLoadList = $this->input->post('directLoadList') ?: [];
        $linkLoadList = $this->input->post('linkLoadList') ?: [];
        $localTransitList = $this->input->post('localTransitList') ?: [];
        $outForDeliveryList = $this->input->post('outForDeliveryList') ?: [];
        $cargoResponseState = [];

        // Direct Load
        foreach ($directLoadList as $row) {
            $codes = array_map(function($v) {
                return array('code' => $v);
            }, $row['cargoList']);

            $load = $this->api_model->cargoOGPLload(array(
                'code' => '',
                'name' => '',
                'activeFlag' => 1,
                'actionCode' => 'ADD',
                'transitStatus' => array('code' => 'INIT'),
                'transitDetailsType' => array('code' => 'DFLT'),
                'toStation' => array('code' => $row['to']),
                'fromStation' => array('code' => $row['from']),
                'fromOrganization' => array('code' => $row['oldTransitOrg']),
                'toOrganization' => array('code' => $row['transitOrganization']),
                'transitCargo' => array('code' => $ogpl->data->code),
                'transitOrganization' => array('code' => $row['transitOrganization']),
                'cargoList' => $codes
            ));
            $load = json_decode($load);

            if ($load->status == 1) {
                $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
            } else {
                echo json_encode($load);
                return;
            }
        }

        // Link Load
        foreach ($linkLoadList as $row) {
            $codes = array_map(function($v) {
                return array('code' => $v);
            }, $row['cargoList']);

            $load = $this->api_model->cargoOGPLload(array(
                'code' => '',
                'name' => '',
                'activeFlag' => 1,
                'actionCode' => 'ADD',
                'transitStatus' => array('code' => 'INIT'),
                'transitDetailsType' => array('code' => 'HULD'),
                'toStation' => array('code' => $row['to']),
                'fromStation' => array('code' => $row['from']),
                'fromOrganization' => array('code' => $row['oldTransitOrg']),
                'toOrganization' => array('code' => $row['transitOrganization']),
                'transitCargo' => array('code' => $ogpl->data->code),
                'transitOrganization' => array('code' => $row['transitOrganization']),
                'cargoList' => $codes
            ));
            $load = json_decode($load);

            if ($load->status == 1) {
                $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
            } else {
                echo json_encode($load);
                return;
            }
        }

        // Local Transit
        foreach ($localTransitList as $row) {
            $codes = array_map(function($v) {
                return array('code' => $v);
            }, $row['cargoList']);

            $load = $this->api_model->cargoOGPLload(array(
                'code' => '',
                'name' => '',
                'activeFlag' => 1,
                'actionCode' => 'ADD',
                'transitStatus' => array('code' => 'INIT'),
                'transitDetailsType' => array('code' => 'LCLD'),
                'toStation' => array('code' => $row['to']),
                'fromStation' => array('code' => $row['from']),
                'fromOrganization' => array('code' => $row['oldTransitOrg']),
                'toOrganization' => array('code' => $row['transitOrganization']),
                'transitCargo' => array('code' => $ogpl->data->code),
                'transitOrganization' => array('code' => $row['transitOrganization']),
                'cargoList' => $codes
            ));
            $load = json_decode($load);

            if ($load->status == 1) {
                $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
            } else {
                echo json_encode($load);
                return;
            }
        }
        
        // Out for delivery
        foreach ($outForDeliveryList as $row) {
            $codes = array_map(function($v) {
                return array('code' => $v);
            }, $row['cargoList']);

            $load = $this->api_model->cargoOGPLload(array(
                'code' => '',
                'name' => '',
                'activeFlag' => 1,
                'actionCode' => 'ADD',
                'transitStatus' => array('code' => 'INIT'),
                'transitDetailsType' => array('code' => 'OFDLD'),
                'toStation' => array('code' => $row['to']),
                'fromStation' => array('code' => $row['from']),
                'fromOrganization' => array('code' => $row['oldTransitOrg']),
                'toOrganization' => array('code' => $row['transitOrganization']),
                'transitCargo' => array('code' => $ogpl->data->code),
                'transitOrganization' => array('code' => $row['transitOrganization']),
                'cargoList' => $codes
            ));
            $load = json_decode($load);

            if ($load->status == 1) {
                $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
            } else {
                echo json_encode($load);
                return;
            }
        }

        echo json_encode(array(
            'status' => 1,
            'OGPLCode' => $ogpl->data->code,
            'OGPLDate' => $this->input->post('tripDate'),
            'cargoResponseState' => $cargoResponseState
        ));
    }

    function ogplv3_empty_load() {
        $this->is_logged_in();

        //local with empty load loc
        $transitDetailsType = $this->input->post('transitDetailsType');
        $cargoActivityType = $this->input->post('cargoActivityType');
        $toOrganization = $this->input->post('toOrganization');

        if(isset($toOrganization)){
            $toOrganization= $toOrganization['code'];
        }else{
            $toOrganization=array('code' => $this->session->userdata('org_code'));
        }

        $ogpl = $this->api_model->cargoOGPLupdate(array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code') ?: '',
            'name' => $this->input->post('name'),
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation'),
            'fromOrganization' => array('code' => $this->session->userdata('org_code')),
            'toOrganization' => array('code' => $toOrganization),
            'viaStations' => $this->input->post('viaStations') ?: [],
            'viaZones' => $this->input->post('viaZones') ?: [],
            'hubViaStations' => $this->input->post('linkLoadStations') ?: [],
            'hubViaZones' => $this->input->post('hubViaZones') ?: [],
            'localViaOrganizations' => $this->input->post('localViaOrganizations') ?: [],
            'tripDate' => $this->input->post('tripDate'),
            'busVehicle' => $this->input->post('busVehicle'),
            'supervisor' => $this->input->post('supervisor'),
            'vehicleDriver' => $this->input->post('vehicleDriver'),
            'secondaryDriver' => $this->input->post('secondaryDriver') ?: ['code' => ''],
            'cargoActivityType' => array('code' => $cargoActivityType[0]),//INTRNT  input call
            'remarks' => $this->input->post('remarks'),
            'arrivalMinutes' => (int) hoursTominutes(date('H:i')),
            'departureMinutes' => (int) hoursTominutes(date('H:i')),
            'odometer' => $this->input->post('odometer') ?: '',
            'additionalAttribute' => $this->input->post('additionalAttribute') ?: new stdClass,
            'transitReference' => $this->input->post('transitReference') ?: [],
        ));

        $ogpl = json_decode($ogpl);

        if ($ogpl->status != 1) {
            echo json_encode($ogpl);
            return;
        }

        $cargoResponseState = [];

        $load = $this->api_model->cargoOGPLload(array(
            'code' => '',
            'name' => '',
            'activeFlag' => 1,
            'actionCode' => 'ADD',
            'transitDetailsType'=> $transitDetailsType,
            'transitStatus' => array('code' => 'INIT'),
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation'),
            'fromOrganization' => array('code' => $this->session->userdata('org_code')),
            'toOrganization' => array('code' => $toOrganization),
            'transitCargo' => array('code' => $ogpl->data->code),
            'transitOrganization' => array('code' => $this->session->userdata('org_code')),
            'cargoList' =>$this->input->post('cargoList') ?: [],
            'activityType' => $this->input->post('activityType') ?: 'EMPTY_LOAD',
        ));
        $load = json_decode($load);

        if ($load->status == 1) {
            $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
        } else {
            echo json_encode($load);
            return;
        }

        echo json_encode(array(
            'status' => 1,
            'OGPLCode' => $ogpl->data->code,
            'OGPLDate' => $this->input->post('tripDate'),
            'cargoResponseState' => $cargoResponseState
        ));
    }

    public function transitv3_loaded_ogpl_list() {
        $this->is_logged_in();

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ45G4144',
            'cargoTransitCode' => $this->input->post('transitCode'),
            'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
            'stationCode' => 'NA',
            'allowSameStation' =>  '0',
            'allowSameBranch' =>  '0',
            'filterType' => 'NA'
        ));
        $result = json_decode($result);
        $list = array();

        $user_org_code = $this->session->userdata('org_code');
        foreach ($result->data as $row) {
            if ($row->cargo_status_code == 'CL' && ($row->from_organization_code === $user_org_code || $row->transit_from_organization_code === $user_org_code)) {
                $list[$row->from_station_name . ' to ' . $row->to_station_name][] = $row;
            }
        }

        // odometer details
        // $transitCode = $this->input->post('transitCode');
        // if ($transitCode) {
        //     $ogpl = $this->api_model->cargoOGPLDetails(array(
        //         'transitCode' => $transitCode
        //     ));
        //     $ogpl = json_decode($ogpl);
        //     $data['ogpl'] = $ogpl->data;

        //     $odoDetails = $this->api_model->getTransitOdometer(array(
        //         'transitCode' => $transitCode
        //     ));
        //     $odoDetails = json_decode($odoDetails);
        //     foreach ($odoDetails->data as $row) {
        //         if ($row->organization->code == $ogpl->data->fromOrganization->code) {
        //             $data['odoDetails'] = $row;
        //         }
        //     }
        // }

        $data['result'] = $list;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $this->load->view('site/cargo/transitv3-loaded-ogpl-list', $data);
    }

    function refresh_ogplv2_data() {
        $this->is_logged_in();

        $ogplV2 = $this->api_model->refreshOGPLV2Data(array(
            'transitCode' => $this->input->post('transitCode')
        ));
        $ogplV2 = json_decode($ogplV2);   
        if($ogplV2->status!=1) {
            echo json_encode($ogplV2);
            return;
        }

        echo $this->api_model->refreshOGPLData(array(
            'transitCode' => $this->input->post('transitCode')
        ));
    }

    function ogpl_consolidated_eway_bill_pdf() {
        $this->is_logged_in();

        $consEwayBill = $this->api_model->getConsolidateEWayBillDetails(array(
            'consEwayBillNo' => $this->input->get('consEwayBillNo')
        ));
        $consEwayBill = json_decode($consEwayBill);
        $data['consEwayBill'] = $consEwayBill->data;

        $data['ewaybill_transportation_mode'] = config_item('ewaybill_transportation_mode');
        
        require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
        $pdf = new TCPDF();
        $pdf->SetTitle('Consolidated E-Way Bill');
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->SetFont('helvetica', '', 8);
        $pdf->SetMargins(12, 10, 12, true);
        $pdf->AddPage();

        ob_clean();
        $this->load->exclude_template();
        $content = $this->load->view('site/cargo/ogpl-consolidated-eway-bill-pdf', $data, true);

        $pdf->writeHTML($content);
        $pdf->Output('Consolidated E-Way Bill.pdf', 'i');
    }

    public function booked_ogpl_list() {
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        if (has_action_rights('OGPL-HUB-LOAD')) {
            $branches = $this->api_model->getCargoOrganization();
            $branches = json_decode($branches);

            $stationbranch = [];
            foreach ($branches->data as $row) {
                $stationbranch[$row->station->code][] = $row;
            }
            $data['stationbranch'] = $stationbranch;
            $data['userorgcode'] = $this->session->userdata('org_code');
            $data['userorgname'] = $this->session->userdata('org_name');
        }

        $branchContact = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $branchContact = json_decode($branchContact);
        $data['branchContact'] = $branchContact->data;

        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['zone'] = $zone->data;

        $contact = $this->api_model->getContact();
        $contact = json_decode($contact);
        $data['vendors'] = $contact->data;

        $con = array();
        foreach($contact->data as $key=>$val){
            $con[$val->contactCategory->name][$key] = $val;
            $con[$val->contactCategory->name][$key] = $val;
        }
        
        $data['contact'] = $con;

        $bankdetail = $this->api_model->getOrganizationOtherDetails(array(
            'organizationcode' => $this->session->userdata('org_code')
        ));
        $bankdetail = json_decode($bankdetail);
        $data['bankdetail'] = $bankdetail->data->bankDetails;
        
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['org_station_code'] = $this->session->userdata('org_station_code');
        $data['logged_in_org'] = $this->session->userdata('org_code');
        $data['cargoActivityType'] = $this->input->post('cargoActivityType');
        $data['bank_names_list'] = $this->config->item('bank_names_list');
        $data['cargo_setting'] = _get_cargo_settings();
        
        $this->load->view('site/cargo/booked-ogpl-list', $data);
    }

    public function booked_ogpl_search_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQJ4KJU47',
            'fromDate' => date('Y-m-d', strtotime($this->input->get_post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->get_post('toDate'))),
            'fromStationCode' => 'NA',
            'toStationCode' => $this->input->get_post('toStationCode') ?: 'NA',
            'viaStationCodes' => $this->input->get_post('viaStationCodes') ?: 'NA',
            'transitOrganizationCode' => $this->input->get_post('transitOrganizationCode') ?: $this->session->userdata('org_code'),
            'transitTypeCode' => 'TRNT',
            'cargoCode' => $this->input->get_post('cargoCode') ?: 'NA',
        );
        if (!has_action_rights('OGPL-HUB-LOAD')) {
            $data['transitOrganizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $toloaded = array();
        $summary = array();
        $toBranchSummary = array();
        foreach ($result->data as $row) {
            $toloaded[$row->to_organization_name][] = $row;
            $summary[$row->payment_status_code]['lr'] += 1;
            //$summary[$row->payment_status_code]['paycode'] += $row->payment_status_code;
            $summary[$row->payment_status_code]['packages'] += $row->total_item_count;
            $summary[$row->payment_status_code]['freight'] += $row->total_booking_amount;
            $summary[$row->payment_status_code]['loading'] += $row->total_handling_amount;
            $summary[$row->payment_status_code]['unloading'] += $row->total_unload_handling_amount;
            $summary[$row->payment_status_code]['service_tax'] += $row->service_tax;

            $toBranchSummary[$row->to_organization_name]['total_count']++;
        }

        foreach ($toloaded as &$dataList) {
            ksort($dataList, function($a, $b) {
                $aExpdl = strpos($a->additional_status_code, 'EXPDL') !== false;
                $bExpdl = strpos($b->additional_status_code, 'EXPDL') !== false;

                $aHdlwc = strpos($a->additional_status_code, 'HDLWC') !== false;
                $bHdlwc = strpos($b->additional_status_code, 'HDLWC') !== false;

                if ($aExpdl && !$bExpdl) {
                    return -1;
                }
                if (!$aExpdl && $bExpdl) {
                    return 1;
                }
                return 0;
            });
        }

        $data['result'] = $toloaded;

        $data['vehicle_no'] = $this->input->get_post('vehicleNo');
        $data['usr_org_code'] = $this->session->userdata('org_code');
        $data['usr_station_code'] = $this->session->userdata('org_station_code');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['summary'] = $summary;

        arsort($toBranchSummary);
        $data['toBranchSummary'] = $toBranchSummary;

        $data['transitCode'] = $this->input->post('code');
        $data['tripDate'] = $this->input->post('tripDate');

        $show_end_odo = 0;
        if ($data['transitCode']) {
            $data['userorgcode'] = $this->session->userdata('org_code');

            $ogpl = $this->api_model->cargoOGPLDetails(array(
                'transitCode' => $data['transitCode']
            ));
            $ogpl = json_decode($ogpl);
            $data['ogpl'] = $ogpl->data;
            $isFTLOGPL = in_array('FULL-TRK-LOAD', $ogpl->data->activity);

            $odoDetails = $this->api_model->getTransitOdometer(array(
                'transitCode' => $data['transitCode']
            ));
            $odoDetails = json_decode($odoDetails);
            $data['AllodoDetails'] = $odoDetails->data;
            foreach ($odoDetails->data as $row) {
                if (($isFTLOGPL && $row->startOdometer > 0) || ($row->organization->code == $data['userorgcode'])) {
                    $data['odoDetails'] = $row;
                    break;
                }
            }

            $odoBranches = array();
            foreach ($odoDetails->data as $row) {
                array_push($odoBranches, $row->station->code);
            }

            $station_in_via = '';
            foreach ($ogpl->data->viaStations as $row) {
                if ($row->code == $this->session->userdata('org_station_code')) {
                    $station_in_via = $row->code;
                }
            }

            if (isNotNull($station_in_via) && !in_array($data['userorgcode'], $odoBranches)) {
                $show_end_odo = 1;
            }
        }

        if ($this->input->get('print') == 1) {
            $this->load->exclude_template();

            if (_get_namespace_id() == 'skscargo') {
                $nsprofile = $this->api_model->getNamespaceProfile(array('authtoken' => $this->_user_hash));
                $nspro = json_decode($nsprofile);
                $data['nsprofile'] = $nspro->data;
            }
            
            echo $this->load->view('site/cargo/booked-ogpl-search-list-print', $data, true);
            return;
        }

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;

        $data['ogpl_via'] = $this->input->post('ogplVia');
        $data['cargo_setting'] = _get_cargo_settings();
        $data['show_end_odo'] = $show_end_odo;

        $endstation = $this->input->post('endStation');
        if($endstation['code'] !='' )
            $data['ogpl_via'][] = $endstation;
        $this->load->view('site/cargo/booked-ogpl-search-list', $data);
    }

    public function get_transit_odometer_details() {
        $this->is_logged_in();

        echo $this->api_model->getTransitOdometer(array(
            'transitCode' => $this->input->post('transitCode')
        ));
    }

    public function booked_ogpl_search_listv2() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQJ4KJU47',
            'fromDate' => date('Y-m-d', strtotime($this->input->get_post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->get_post('toDate'))),
            'fromStationCode' => 'NA',
            'toStationCode' => $this->input->get_post('toStationCode') ?: 'NA',
            'viaStationCodes' => $this->input->get_post('viaStationCodes') ?: 'NA',
            'transitOrganizationCode' => $this->input->get_post('transitOrganizationCode') ?: $this->session->userdata('org_code'),
            'transitTypeCode' => 'TRNT',
            'cargoCode' => $this->input->get_post('cargoCode') ?: 'NA',
        );
        if (!has_action_rights('OGPL-HUB-LOAD')) {
            $data['transitOrganizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        usort($result->data, function($a, $b) {
            return (strtotime(trim($a->booked_at)) < strtotime(trim($b->booked_at))) ? -1 : 1;
        });

        $toloaded = array();
        $summary = array();
        foreach ($result->data as $row) {
            $key = $row->to_organization_name;
            $key .= ($row->to_organization_short_code!="") ?  ' ( '.$row->to_organization_short_code.' ) ' : '';

            $toloaded[$key][] = $row;
            $summary[$row->payment_status_code]['lr'] += 1;
            //$summary[$row->payment_status_code]['paycode'] += $row->payment_status_code;
            $summary[$row->payment_status_code]['packages'] += $row->total_item_count;
            $summary[$row->payment_status_code]['freight'] += $row->total_booking_amount;
            $summary[$row->payment_status_code]['loading'] += $row->total_handling_amount;
            $summary[$row->payment_status_code]['unloading'] += $row->total_unload_handling_amount;
            $summary[$row->payment_status_code]['service_tax'] += $row->service_tax;
        }
        $data['result'] = $toloaded;

        $data['vehicle_no'] = $this->input->get_post('vehicleNo');
        $data['usr_org_code'] = $this->session->userdata('org_code');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['summary'] = $summary;
        $data['hidesummary'] = true;
        $data['namespaceCode'] = $this->session->userdata('namespace_id');
        $data['username'] = $this->session->userdata('user_name');

        if ($this->input->get('print') == 1) {
            $this->load->exclude_template();

            if (_get_namespace_id() == 'skscargo') {
                $nsprofile = $this->api_model->getNamespaceProfile(array('authtoken' => $this->_user_hash));
                $nspro = json_decode($nsprofile);
                $data['nsprofile'] = $nspro->data;
            }   

            echo $this->load->view('site/cargo/booked-ogpl-search-list-print', $data, true);
            return;
        }elseif(in_array($this->session->userdata('namespace_id'), ["citycargo","cityparcel"]) && $this->input->get('printType') == 'DOTMATRIX') {
            // $cmds = "\033C\000\009".newline().newline();
            $cmds = space(39)."Loading Sheet".newline().newline();
            $cmds .= "Report Date:".space(1).date('d-m-Y', strtotime($data['fromDate'])).space(10-0-strlen($data['fromDate'])).space(1)."to".space(1).date('d-m-Y', strtotime($data['toDate'])).space(10-0-strlen($data['toDate'])).space(13)."Report At:".space(1).date('d-m-Y h:i A').newline().newline();
            $cmds .= space(50)."Reported By:".space(1).$data['username'].substr(17-0-strlen($data['username'])).newline().newline();
            $cmds .= str_repeat('-', 80) . newline();
            $cmds .= "DOB".space(10)."LR".space(10)."From".space(3)."To".space(5)."Article".space(3)."#Art".space(2)."Goods Desc".space(1)."Wt".space(1)."Remarks".newline();
            $cmds .= str_repeat('-', 80) . newline();
            $grandtotal =0;
            foreach ($data['result'] as $key=>$row) {
                $subtotal = 0;
                $cmds .= space(30).$key.substr(30-0-strlen($key)).newline();
                $cmds .= str_repeat('-', 80).newline();
                foreach ($row as $k => $val) {
                    $subtotal +=$val->total_item_count;
                    $grandtotal += $val->total_item_count;
                    
                    $dob = substr(date('d-m-Y', strtotime($val->booked_at)), 0, 10);
                    $lrcode = substr($val->cargo_code, 0, 12);
                    $itemCount = substr($val->total_item_count, 0, 4);
                    $fromOrganization = substr($val->from_organization_short_code, 0, 4);
                    $toOrganization = substr($val->to_organization_short_code, 0, 4);
                    $itemName = substr($val->cargo_item_name, 0, 10);
                    $itemCount = substr($val->total_item_count, 0, 5);

                    if($val->description){
                        $description = substr($val->description, 0, 10);
                    }else{
                        $description = '-'.space(9);
                    }

                    $unitValue = substr($val->total_actual_unit_value, 0, 3);
                    
                    if($val->remarks){
                        $remarks = substr($val->remarks, 0, 15);
                    }else{
                        $remarks = '-'.space(14);
                    }
                    
                    $cmds .= $dob.space(13-0-strlen($dob)).$lrcode.space(12-0-strlen($lrcode)).$fromOrganization.space(7-0-strlen($fromOrganization)).$toOrganization.space(7-0-strlen($toOrganization)).$itemName.space(11-0-strlen($itemName)).$itemCount.space(5-0-strlen($itemCount)).$description.space(11-0-strlen($description)).$unitValue.space(3-0-strlen($unitValue)).$remarks.newline();
                    $cmds .= str_repeat('-', 80).newline();
                }
                $cmds .= space(38) . "Subtotal :" . space(2) . $subtotal.newline().newline();

            }
            $cmds .= space(36) . "Grandtotal :" . space(2) . $grandtotal;
            $cmds .= "\f"; 
            ob_end_clean();
            echo ($cmds);
        } else {
            echo $this->load->view('site/cargo/booked-ogpl-search-listv2', $data, true);
        }
    }

    public function load_ogpl_list() {
        $this->is_logged_in();

        $saveAsTemplate = $this->input->post('saveAsTemplate');

        if ($saveAsTemplate == 1) {
            $tpl = $this->api_model->updateOGPLTemplate(array(
                'activeFlag' => $this->input->post('activeFlag'),
                'viaStations' => $this->input->post('viaStations') ?: [],
                'fromStation' => $this->input->post('fromStation'),
                'toStation' => $this->input->post('toStation'),
                'name' => $this->input->post('name'),
                'arrivalMinutes' => (int) $this->input->post('arrivalMinutes'),
                'departureMinutes' => (int) $this->input->post('departureMinutes'),
            ));
            $tpl = json_decode($tpl);

            if ($tpl->status != 1) {
                echo json_encode($tpl);
                return;
            }
        }

        $ogpl = $this->api_model->cargoOGPLupdate(array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code') ?: '',
            'name' => $this->input->post('name'),
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation'),
            'fromOrganization' => $this->input->post('fromOrganization'),
            'toOrganization' => $this->input->post('toOrganization'),
            'viaStations' => $this->input->post('viaStations') ?: [],
            'localViaOrganizations' => $this->input->post('localViaOrganizations') ?: [],
            'hubViaStations' => $this->input->post('hubViaStations') ?: [],
            'tripDate' => $this->input->post('tripDate'),
            'busVehicle' => $this->input->post('busVehicle'),
            'supervisor' => $this->input->post('supervisor') ?: null,
            'vehicleDriver' => $this->input->post('vehicleDriver'),
            'secondaryDriver' => $this->input->post('secondaryDriver') ?: ['code' => ''],
            'cargoActivityType' => $this->input->post('cargoActivityType'),
            'activityType' => $this->input->post('activityType') ?:[],
            'remarks' => $this->input->post('remarks'),
            'arrivalMinutes' => (int) $this->input->post('arrivalMinutes'),
            'departureMinutes' => (int) $this->input->post('departureMinutes'),
            'odometer' => $this->input->post('odometer') ?: '',
            'transitReference' => $this->input->post('transitReference') ?: [],
        ));

        $ogpl = json_decode($ogpl);

        if ($ogpl->status != 1) {
            echo json_encode($ogpl);
            return;
        }

        $loadList = $this->input->post('loadList') ?: [];

        $cargoResponseState = [];

        foreach ($loadList as $row) {
            $codes = array_map(function($v) {
                return array('code' => $v);
            }, $row['cargoList']);

            $load = $this->api_model->cargoOGPLload(array(
                'code' => '',
                'name' => '',
                'activeFlag' => 1,
                'actionCode' => 'ADD',
                'transitStatus' => array('code' => 'INIT'),
                'toStation' => array('code' => $row['to']),
                'fromStation' => array('code' => $row['from']),
                'fromOrganization' => array('code' => $row['oldTransitOrg']),
                'toOrganization' => array('code' => $row['transitOrganization']),
                'transitCargo' => array('code' => $ogpl->data->code),
                'transitOrganization' => array('code' => $row['transitOrganization']),
                'cargoList' => $codes
            ));
            $load = json_decode($load);

            if ($load->status == 1) {
                $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
            } else {
                echo json_encode($load);
                return;
            }
        }

        echo json_encode(array(
            'status' => 1,
            'OGPLCode' => $ogpl->data->code,
            'OGPLDate' => $this->input->post('tripDate'),
            'cargoResponseState' => $cargoResponseState
        ));
    }

    public function load_ogpl_lr() {
        $this->is_logged_in();

        echo $this->api_model->cargoOGPLload(array(
            'code' => '',
            'name' => '',
            'activeFlag' => 1,
            'actionCode' => 'ADD',
            'transitStatus' => array('code' => 'INIT'),
            'toStation' => array('code' => $this->input->post('toStation')),
            'fromStation' => array('code' => $this->input->post('fromStation')),
            'fromOrganization' => array('code' => $this->input->post('fromOrganization')),
            'toOrganization' => array('code' => $this->input->post('toOrganization')),
            'transitCargo' => array('code' => $this->input->post('transitCargo')),
            'transitOrganization' => array('code' => $this->input->post('transitOrganization')),
            'cargoList' => $this->input->post('cargoList') ?: []
        ));
    }

    public function unload_ogpl_list() {
        $unloadList = $this->input->post('unloadList') ?: [];
        $ogplLRCount = $this->input->post('ogplLRCount');

        foreach ($unloadList as $index => $row) {
            $codes = array_map(function($v) {
                return array('code' => $v);
            }, $row['cargoList']);

            
            $transitStatus = ($index >= $ogplLRCount) ? 'UNLOAD' : 'INIT';

            $load = $this->api_model->cargoOGPLload(array(
                'code' => '',
                'name' => '',
                'activeFlag' => 1,
                'actionCode' => 'REMOVE',
                'transitStatus' => array('code' => $transitStatus),
                'toStation' => array('code' => $row['to']),
                'fromStation' => array('code' => $row['from']),
                'fromOrganization' => array('code' => $row['fromOrg']),
                'toOrganization' => array('code' => $row['toOrg']),
                'transitDetailsType' => array('code' => $row['transitType']),
                'transitCargo' => array('code' => $this->input->post('transitCargo')),
                'transitOrganization' => array('code' => $this->input->post('transitOrganization')),
                'cargoList' => $codes
            ));
        }

        echo $load;
    }

    public function ogpl_chart_details() {
        $this->is_logged_in();

        $transitCode = $this->input->get('transitCode');
        $transitType = $this->input->get('transitType');
        $this->session->set_userdata('ogpl_last_active', $transitCode);

        $ogpl = $this->api_model->cargoOGPLDetails(array(
            'transitCode' => $transitCode
        ));
        $ogpl = json_decode($ogpl);
        $data['ogpl'] = $ogpl = $ogpl->data;
        $organizationCode = $this->session->userdata('org_code'); 

        $response = $this->helper_model->view_chart($transitType,array(
            'queryCode' => 'RQJ45G4144',
            'cargoTransitCode' => $transitCode,
            'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $organizationCode,
            'stationCode' =>'NA',
            'allowSameStation' =>'0',
            'allowSameBranch' =>'0',
            'filterType' => 'LOAD'
        ));
      
        $data['transitDetails'] = array_unique($response['transitDetails']);
        $data['result'] = $response['list'];
        $data['routes'] = $response['routes'];
        $data['summary'] = $response['summary'];
        $data['rowCount'] = $response['rowCount'];
        
        if (_get_namespace_id() == 'newlinetrans') {
            $result = $this->api_model->getTransitIncomeExpense(array(
                'transitCode' => $transitCode
            ));
            $result = json_decode($result);
            $data['expensesData'] = $result->data;
        }

        //ogpl-details-for-start-trip
        $data['login_user'] = $this->session->userdata('user_id');
        $data['login_branch'] = $this->session->userdata('org_code');
        //odometer details
        $odoDetails = $this->api_model->getTransitOdometer(array(
            'transitCode' => $transitCode
        ));
        $data['odoDetails'] = [];
        foreach (getData($odoDetails) as $row) {
            if ($row->organization->code == $ogpl->fromOrganization->code) {
                $data['odoDetails'] = $row;
            }
        }
        //odometer details end
        //ogpl-details-for-start-trip

        $data['cargo_setting'] = _get_cargo_settings();
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['showTransitTypes'] = array_unique($showTransitTypes);
        if (in_array($this->session->userdata('namespace_id'), ["citycargo","cityparcel"])) {
            $data['namespaceCode'] = $this->session->userdata('namespace_id');
            $this->load->view('site/cargo/ogpl-chart-cityparcel', $data);
        } else {
        $this->load->view('site/cargo/ogpl-chart', $data);
        }
    }
    public function make_start_trip(){
        $transitCode = $this->input->post('transitCode');
        $data['login_branch'] = $this->session->userdata('org_code');
        $data['login_user'] = $this->session->userdata('user_id');
        //ogpl data
        $ogpl = $this->api_model->cargoOGPLDetails(array(
            'transitCode' => $transitCode
        ));
        $data['ogpl'] = $ogpl = getData($ogpl);
        ////ogpl data end

        $vehicleCode = $ogpl->busVehicle->code;
        

        $branchContact = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $data['branchContact'] = getData($branchContact);
        // vehicle data
        $get_vehicle = $this->api_model->get_vehicle_details($vehicleCode);
        $data['vehicle'] = getData($get_vehicle);
        // vehicle data end

        $contact = $this->api_model->getContact();
        // $contact = json_decode($contact);
        $data['vendors'] = getData($contact);
        $con = array();
        foreach(getData($contact) as $key=>$val){
            $con[$val->contactCategory->name][$key] = $val;
            $con[$val->contactCategory->name][$key] = $val;
        }
            
        $bankdetail = $this->api_model->getOrganizationOtherDetails(array(
            'organizationcode' => $this->session->userdata('org_code')
        ));
        $bankdetail = json_decode($bankdetail);

        $data['bankdetail'] = $bankdetail->data->bankDetails;
        $data['contact'] = $con;
        // $data['ownershipTypes'] = $ownershipTypes;
        $data['f_t_mode'] = config_item('transaction_mode');
        $this->load->view('site/cargo/start-trip-dialogue',$data);
    }
    public function ogpl_chart_details_print()
    {
        $this->is_logged_in();
        $this->load->exclude_template();
        $is_namespace = $this->session->userdata('namespace_id');

        $transitCode = $this->input->get('transitCode');
        $transitDetailCode = $this->input->get('transitDetailCode');
        $organizationCode = $this->session->userdata('org_code');
        if (in_array($this->session->userdata('namespace_id'), ["citycargo", "cityparcel"])) {
            $branchData = $this->api_model->getUserOrganization(array(
                'organizationCode' => $organizationCode
            ));
            $branchData = json_decode($branchData);

            $userBranchData = array();
            foreach ($branchData->data as $val) {
                $userBranchData['address1'] = $val->address1;
                $userBranchData['address2'] = $val->address2;
                $userBranchData['contact'] = $val->contact;
            }
            $data['userBranchData'] = $userBranchData;
        }

        if ($transitDetailCode != '' && $transitCode == '') {
            $transitdet = $this->api_model->cargoOGPLTransitDetail(array(
                'transitDetailCode' => $transitDetailCode
            ));
            $transitdet = json_decode($transitdet);
            $transitCode = $transitdet->data->transitCargo->code;
        }

        $ogpl = $this->api_model->cargoOGPLDetails(array(
            'transitCode' => $transitCode
        ));
        $ogpl = json_decode($ogpl);
        $data['ogpl'] = $ogpl->data;
        $odometer = $this->api_model->getTransitOdometerDetails(array(
            'transitCode' => $transitCode
        ));

        $odometer = json_decode($odometer);
        $data['odometer'] = $odometer->data;
        $odometerDetails = [];
        // $namespaces = ['rathimeenaparcel'];  //only expose odometer details for this namespace only
        // if(in_array($is_namespace,$namespaces)){
            $odoDetails = $this->api_model->getTransitOdometer(array(
                'transitCode' => $transitCode
            ));
            $odoDetails = json_decode($odoDetails);
            $odometerDetails = [];
            foreach ($odoDetails->data as $row) {
                if ($row->organization->code == $ogpl->data->fromOrganization->code) {
                    $odometerDetails['fromOdoDetail'] = $row;
                }
                if($row->organization->code == $this->session->userdata('org_code')){
                    $odometerDetails['myOdoDetail'] = $row;
                }
                if($row->organization->code == $ogpl->data->toOrganization->code){
                    $odometerDetails['toOdoDetail'] = $row;
                }
            }
            $data['odoDetails'] = $odometerDetails; 
        // }
       
        $data['transitcargoDetails']  = $ogpl->data->transitCargoDetails;
        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ45G4144',
            'cargoTransitCode' => $transitCode,
            'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
            'stationCode' =>'NA',
            'allowSameStation' =>'0',
            'allowSameBranch' =>'0',
            'filterType' => 'LOAD'
        ));
        $newBranchSummary = array();
        $newBranchSummary1 = array();
       

        $result = json_decode($result);
        usort($result->data, function($a, $b) {
            return (strtotime(trim($a->booked_at)) < strtotime(trim($b->booked_at))) ? -1 : 1;
        });
        
        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
        $usr_pro = json_decode($usr_pro);
        $groupingBranchSummary = $result->data;
    

        $filter = $this->input->get('route') ?: '';

        $newfilter = explode('-', $filter);

        for ($i = 0; $i < count($groupingBranchSummary); $i++) {
            if ($groupingBranchSummary[$i]->to_organization_code == $newfilter[1]) {
                $data["tostation"] = $groupingBranchSummary[$i]->to_organization_name;
                break;
            }
        }
        for ($i = 0; $i < count($groupingBranchSummary); $i++) {
            do {
                $addonDetails2 = explode(",",$groupingBranchSummary[$i]->fs_addon_value);
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['from'] = $groupingBranchSummary[$i]->from_organization_name;
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['to'] = $groupingBranchSummary[$i]->to_organization_name;
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['lr'] += 1;
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['article'] += $groupingBranchSummary[$i]->total_item_count;
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['articleWeight'] += $groupingBranchSummary[$i]->total_unit_value;
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['ff'] += in_array("FR", $addonDetails2) ? 0 : round($groupingBranchSummary[$i]->total_amount, 2);
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['hm'] += in_array("LC", $addonDetails2) ? 0 : round($groupingBranchSummary[$i]->total_handling_amount,2);
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['dc'] += in_array("DP", $addonDetails2) ? 0 : round($groupingBranchSummary[$i]->pickup_handling_amount,2);
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['dd'] += in_array("DD", $addonDetails2) ? 0 : round($groupingBranchSummary[$i]->delivery_handling_amount,2);
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['otherCharges'] += round(($groupingBranchSummary[$i]->other_charges_amount) - ($groupingBranchSummary[$i]->pickup_handling_amount + $groupingBranchSummary[$i]->delivery_handling_amount + $groupingBranchSummary[$i]->hamali_charge + $groupingBranchSummary[$i]->docket_charge + $groupingBranchSummary[$i]->total_handling_amount),2);
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['stc'] += in_array("DC", $addonDetails2) ? 0 : round($groupingBranchSummary[$i]->docket_charge, 2);
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['amount'] += round(($groupingBranchSummary[$i]->total_amount + $groupingBranchSummary[$i]->other_charges_amount),2);
                $newBranchSummary[$groupingBranchSummary[$i]->from_organization_code . '-' . $groupingBranchSummary[$i]->to_organization_code]['addonDetails'][]= explode(",",$groupingBranchSummary[$i]->fs_addon_value);
                $i++;
            } while (($groupingBranchSummary[$i]->from_organization_code == $groupingBranchSummary[$i - 1]->from_organization_code) && ($groupingBranchSummary[$i]->to_organization_code == $groupingBranchSummary[$i - 1]->to_organization_code));
            $i -= 1;
        }
      
        usort($result->data, function ($a, $b) {
            return (strtotime(trim($a->booked_at)) < strtotime(trim($b->booked_at))) ? -1 : 1;
        });

        $list = array();

        if ($filter) {
            $filter = explode(',', $filter);
        }

        $groupby = $this->input->get('groupby');


        if ($groupby == 'PAID') {
            $bgimg = 'assets/img/paid-watermark.png';
        } else if ($groupby == 'TOPAY') {
            $bgimg = 'assets/img/topay-watermark.png';
        }
        $data['bgimg'] = $bgimg;

        $groupbytypes = array(
            'PAID' => array('PAD', 'FS', 'TPPAD'),
            'TOPAY' => array('TOP', 'INP', 'OATP')
        );

        $routes = array();
        $summary = array();
        $paymentSummary = array();
        $deliverySummary = array();
        $branchSummary = array();

        foreach ($result->data as $row) {
            if (has_action_rights('HIDE-OTHER-BRANCH-LR')) {
                if ($row->from_organization_code != $organizationCode && $row->to_organization_code != $organizationCode ) {
                    continue;
                }
            }
            $key = $row->transit_from_station_code . '-' . $row->transit_to_organization_code;
            $val = $row->transit_from_station_name;
            $val .= ($row->transit_from_station_short_code != "") ? ' ( ' . $row->transit_from_station_short_code . ' )' : '';
            $val .= ' to ' . $row->transit_to_organization_name;
            $val .= ($row->transit_to_organization_short_code != "") ? ' ( ' . $row->transit_to_organization_short_code . ' )' : '';

            $routes[$key] = $val;

            if ($groupby != '' && !in_array($row->payment_status_code, $groupbytypes[$groupby])) {
                continue;
            }

            if ($filter == '' || in_array($key, $filter)) {
                $paymentSummary[$row->payment_status_code]['lr'] += 1;
                $paymentSummary[$row->payment_status_code]['amount'] += $row->total_amount + $row->other_charges_amount;

                $deliverySummary[$row->delivery_type_code]['code'] = $row->delivery_type_code;
                $deliverySummary[$row->delivery_type_code]['lr'] += 1;
                $deliverySummary[$row->delivery_type_code]['amount'] += $row->total_amount + $row->other_charges_amount;

                $branchSummary[$row->from_organization_code . '-' . $row->to_organization_code]['from'] = $row->from_organization_name;
                $branchSummary[$row->from_organization_code . '-' . $row->to_organization_code]['to'] = $row->to_organization_name;
                $branchSummary[$row->from_organization_code . '-' . $row->to_organization_code]['lr'] += 1;
                $branchSummary[$row->from_organization_code . '-' . $row->to_organization_code]['article'] += $row->total_item_count;
                $branchSummary[$row->from_organization_code . '-' . $row->to_organization_code]['articleWeight'] += $row->total_unit_value;
                $branchSummary[$row->from_organization_code . '-' . $row->to_organization_code]['amount'] += $row->total_amount + $row->other_charges_amount;

                $list[$key][] = $row;

                $summary[$key][$row->payment_status_code]['lr'] += 1;
                //$summary[$row->payment_status_code]['paycode'] += $row->payment_status_code;
                $summary[$key][$row->payment_status_code]['packages'] += $row->total_item_count;
                $summary[$key][$row->payment_status_code]['freight'] += $row->total_amount;
                $summary[$key][$row->payment_status_code]['ac_kg'] += $row->total_actual_unit_value;
                $summary[$key][$row->payment_status_code]['kg_amt'] += $row->total_unit_value;
                $summary[$key][$row->payment_status_code]['loading'] += $row->total_handling_amount;
                $summary[$key][$row->payment_status_code]['unloading'] += $row->total_unload_handling_amount;
                $summary[$key][$row->payment_status_code]['service_tax'] += $row->service_tax;
                $summary[$key][$row->payment_status_code]['docket'] += $row->docket_charge;
                $summary[$key][$row->payment_status_code]['connecting'] += $row->connecting_charge;
                $summary[$key][$row->payment_status_code]['delivery'] += ($row->pickup_handling_amount + $row->delivery_handling_amount);
            }
        }
            foreach($list as $key=>$singleList){
               foreach($singleList as $innerSingleList){
                   $from_organization_code  = $innerSingleList->from_organization_code;
                   $from_organization_name = $innerSingleList->from_organization_name;
                   break;
               }
            }

            $organizationDetails = $this->api_model->getOrganizationDetails(array('organizationcode' => $from_organization_code));
            $organizationDetails = json_decode($organizationDetails);
            $data['organizationDetails']  = $organizationDetails->data;
            $newBranchSummary1 = array();

            foreach($newBranchSummary as $key=>$value){
                if($key == ($from_organization_code. '-' .$newfilter[1])){
                    $newBranchSummary1[$key] = $value;
                    $newBranchSummary =  array_merge($newBranchSummary1,$newBranchSummary);
                    }
                }
                
        $data['newBranchSummary'] = $newBranchSummary;
        $data['from_code'] = $from_organization_code;
        $data['from_name'] = $from_organization_name;
        $data['result'] = $list;
        $data['results'] = $result->data;
        $data['routes'] = $routes;
        $data['summary'] = $summary;
        $nsprofile = $this->api_model->getNamespaceProfile(array('authtoken' => $this->_user_hash));
        $nspro = json_decode($nsprofile);
        $data['nsprofile_address'] = $nspro->data->namespaceProfile->address;

        if (_get_namespace_id() == 'newlinetrans') {
            $result = $this->api_model->getTransitIncomeExpense(array(
                'transitCode' => $transitCode
            ));
            $result = json_decode($result);
            $data['expensesData'] = $result->data;
        }

        $data['paymentSummary'] = $paymentSummary;
        $data['deliverySummary'] = $deliverySummary;
        $data['branchSummary'] = $branchSummary;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['transaction_mode'] = config_item('transaction_mode');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');

        if (in_array($this->session->userdata('namespace_id'), ["sktxlogistics", "sprtravels"])) {
            $data['is_header_available'] = 1;
        }

        if ($this->session->userdata('namespace_id') == "rajeshcargo" || $this->session->userdata('namespace_id') == "rajeshexpress") {
            $this->load->view('site/cargo/ogpl-chart-print-rajesh', $data);
        } else if ($this->session->userdata('namespace_id') == "skscargo") {
            $this->load->view('site/cargo/ogpl-chart-print-sks', $data);
        } else if ($this->session->userdata('namespace_id') == "rathimeenaparcel") {
            $this->load->view('site/cargo/ogpl-chart-print-rathimeenaparcel', $data);
        } else if ($this->session->userdata('namespace_id') == "jabbar") {
            $this->load->view('site/cargo/ogpl-chart-print-jabbar', $data);
        } else if ($this->session->userdata('namespace_id') == "smroadlines") {
            $this->load->view('site/cargo/ogpl-chart-print-smroadlines', $data);
        } else if ($this->session->userdata('namespace_id') == "praveencarriers") {
            $this->load->view('site/cargo/ogpl-chart-print-praveencarriers', $data);
        } else if ($this->session->userdata('namespace_id') == "suryadev") {
            $this->load->view('site/cargo/ogpl-chart-print-suryadev', $data);
        } else if ($this->session->userdata('namespace_id') == "seenutransports" || $this->session->userdata('namespace_id') == "seenucargo") {
            if (count($filter) == 1 && $filter != null) {
                $this->load->view('site/cargo/ogpl-chart-print-seenutransport', $data);
            } else {
                $this->load->view('site/cargo/ogpl-report-print-seenutransports-v2', $data);
            }
        } else if (in_array($this->session->userdata('namespace_id'), ["citycargo", "cityparcel"]) && $this->input->get('type') == 'DVR' && $this->input->get('printType') == 'LASERPRINT') {
            $this->load->view('site/cargo/ogpl-chart-driver-print-cityparcel', $data);
        } else if (in_array($this->session->userdata('namespace_id'), ["citycargo", "cityparcel"]) && $this->input->get('type') == 'DVR' && $this->input->get('printType') == 'DOTMATRIX') {
            // $cmds = "\033C\000\009".newline().newline();
            $cmds .= "-" . space(31 - 0 - strlen($data['ogpl']->aliasCode)) . space(10) . "Driver Trip Chart" . newline() . newline();
            $cmds .= space(34) . $this->session->userdata('namespace_name')  . newline() . newline();
            $cmds .= space(35) . $userBranchData['address1'] . newline();
            $cmds .= space(35) . $userBranchData['address2'] . newline();
            $cmds .= space(35) . "Ph :" . $userBranchData['contact'] . newline() . newline();
            $cmds .= "OGPL No:" . space(1) . $data['ogpl']->aliasCode . space(17 - 0 - strlen($data['ogpl']->aliasCode)) . newline() . newline();
            $cmds .= "Routes:" . space(1) . $data['ogpl']->fromOrganization->name . space(10 - 0 - strlen($data['ogpl']->fromOrganization->name)) . space(1) . "to" . space(1) . $data['ogpl']->toOrganization->name . space(10 - 0 - strlen($data['ogpl']->toOrganization->name)) . space(15) . "Vehicle :" . space(1) . $data['ogpl']->busVehicle->registationNumber . space(10 - 0 - strlen($data['ogpl']->vehicleDriver->name)) . newline() . newline();
            $cmds .= "Trip Date :" . space(1) . $data['ogpl']->tripDate . space(16 - 0 - strlen($data['ogpl']->tripDate)) . space(20) . "Driver :" . space(1) . $data['ogpl']->vehicleDriver->name . space(10 - 0 - strlen($data['ogpl']->vehicleDriver->name)) . newline() . newline();
            $cmds .= str_repeat('-', 115) . newline();
            $cmds .= "S.No" . space(1) . "LR" . space(15) . "Nos" . space(3) . "Pkgs" . space(8) . "Consignee" . space(11) . "To" . space(13) . "Remark" . space(12) . "Paid" . space(9) . "Topay" . newline() . str_repeat('-', 115) . newline();
            $sno = 1;
            $grandpaid = 0;
            $grandqty = 0;
            $grandtopaid = 0;
            foreach ($data['result'] as $key => $val) {
                $subpaid = 0;
                $subtopaid = 0;
                $subqty = 0;

                $cmds .= space(30) . $routes[$key] . substr(30 - 0 - strlen($routes[$key])) . newline();
                $cmds .= str_repeat('-', 115) . newline();
                foreach ($val as $innerKey => $innerValue) {
                    $lrcode = substr($innerValue->cargo_code, 0, 15);
                    $itemCount = substr($innerValue->total_item_count, 0, 4);
                    $subqty += $innerValue->total_item_count;
                    $grandqty += $innerValue->total_item_count;
                    $itemName = substr($innerValue->cargo_item_name, 0, 10);
                    $fromOrganization = substr($innerValue->to_customer_name, 0, 15);
                    $toOrganization = substr($innerValue->to_organization_name, 0, 15);
                    $remarks = substr($innerValue->booking_remarks, 0, 10);
                    if ($innerValue->payment_status_code == 'PAD') {
                        $payment = $innerValue->total_amount + $innerValue->other_charges_amount;
                        $paid = substr($payment, 0, 10);
                        $subpaid = $subpaid + $paid;
                        $grandpaid = $grandpaid + $paid;
                    } else {
                        $paid = 0.00;
                    }

                    if ($innerValue->payment_status_code == 'TOP' || $innerValue->payment_status_code == 'TPPAD') {
                        $topayment = ($innerValue->total_amount + $innerValue->other_charges_amount) - ($innerValue->total_unload_handling_amount + $innerValue->demurrage_charge + $innerValue->hamali_charge);
                        $topaid = substr($topayment, 0, 10);
                        $subtopaid = $subtopaid + $topaid;
                        $grandtopaid = $grandtopaid + $topaid;
                    } else {
                        $topaid = 0.00;
                    }

                    $cmds .= newline() . $sno . space(5 - 0 - strlen($sno)) . $lrcode . space(17 - 0 - strlen($lrcode)) . $itemCount . space(6 - 0 - strlen($itemCount)) . $itemName . space(12 - 0 - strlen($itemName)) . $fromOrganization . space(15 - 0 - strlen($fromOrganization)) . $toOrganization . space(15 - 0 - strlen($toOrganization)) . $remarks . space(23 - 0 - strlen($remarks)) . $paid . space(13 - 0 - strlen($paid)) . $topaid . space(10 - 0 - strlen($topaid)) . newline();
                    $sno = $sno + 1;
                    $cmds .= str_repeat('-', 115) . newline();
                }
                $cmds .= space(8) . "Subtotal" . space(6) . $subqty . space(70) . $subpaid . space(13 - 0 - strlen($subpaid)) . $subtopaid . space(10 - 0 - strlen($subtopaid)) . newline();
                $cmds .= str_repeat('-', 115) . newline();
            }
            $cmds .= space(7) . "Grandtotal" . space(5) . $grandqty . space(70) . $grandpaid . space(13 - 0 - strlen($grandpaid)) . $grandtopaid . space(10 - 0 - strlen($grandtopaid)) . newline();
            $cmds .= str_repeat('-', 115) . newline();
            $cmds .= "\f";
            ob_end_clean();
            echo trim($cmds);
        } elseif (in_array($this->session->userdata('namespace_id'), ["citycargo", "cityparcel"])) {
            $this->load->view('site/cargo/ogpl-chart-print-cityparcel', $data);
        } else {
            $this->load->view('site/cargo/ogpl-chart-print', $data);
        }
    }

    public function ogpl_chart_hire_challan_print() {
        $this->is_logged_in();
        $this->load->exclude_template();

        $transitCode = $this->input->get('transitCode');
        $ogplType = $this->input->get('ogplType');
        $ogpl = $this->api_model->cargoOGPLDetails(array(
            'transitCode' => $transitCode
        ));

        $ogpl = json_decode($ogpl);
        $data['ogpl'] = $ogpl->data;

        $odometer = $this->api_model->getTransitOdometerDetails(array(
            'transitCode' => $transitCode
        ));

        $odometer = json_decode($odometer);
        $data['odometer'] = $odometer->data;

        $groupedData = [];
        foreach ($ogpl->data->toViaOrganization as $item) {
            $groupedData[$item->shortCode] = $item;
        }
        $groupedData = array_values($groupedData);
        $data['ogpl']->toViaOrganization = $groupedData;

        $groupedDatas = [];
        foreach ($ogpl->data->fromViaOrganization as $item) {
            $groupedDatas[$item->shortCode] = $item;
        }
        $groupedDatas = array_values($groupedDatas);
        $data['ogpl']->fromViaOrganization = $groupedDatas;

        $incomeexpense = $this->api_model->getTransitIncomeExpense(array(
            'transitCode' => $transitCode
        ));
        $incomeexpense = json_decode($incomeexpense);

        $bookedBy = array();
        foreach($incomeexpense->data as $item) {
            if (isset($item->user->name)) {
                $bookedBy[] = $item->user->name;
                break;
            }
        }
        $data['bookedBy'] = $bookedBy;
        
        $expenses = array();
        foreach ($incomeexpense->data as $val) {
            $expenses[str_replace(' ', '', $val->cashbookType->name)]['amount'] += $val->amount;
            $bookedDate= $val->transactionAt; 
        }
        $data['incomeexpense'] = $expenses;
        $data['bookedDate'] = $bookedDate;

        // fuel expense
        $fuelexpense = $this->api_model->getTransitFuelDetails(array(
            'transitCode' => $transitCode
        ));
        $fuelexpense = json_decode($fuelexpense);
        $fuel = array();
        foreach ($fuelexpense->data as $val) {
            $fuel[] = array(
                'totalAmount'=>$val->totalAmount,
                'litres' => $val->litres,
                'pricePerLitre' => $val->pricePerLitre,
                'vendor' => $val->vendorContact->name,
                'coupon' => $val->billNumber
            );
        }
        
        $data['fuelexpense'] = $fuel;
        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        foreach ($vehicles->data as $row) {
            if ($row->code == $data['ogpl']->busVehicle->code) {
                $data['vehicle'] = $row;
            }
        }

        if ($ogplType == 'OGPL' || $ogplType == 'LOC') {
            $this->load->view('site/cargo/ogpl-chart-hire-challan-print-seenutransport', $data);
        } else {
              
                $organizationDetails = $this->api_model->getOrganizationDetails(array('organizationcode' =>$organizationCode));
                $organizationDetails = json_decode($organizationDetails);
                $data['organizationDetails']  = $organizationDetails->data;
                    
            if ($transitCode) {
                $result = $this->api_model->getDynamicReportDataWithMap(array(
                    'queryCode' => 'RQJ45G4144',
                    'cargoTransitCode' => $transitCode,
                    'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
                    'stationCode' =>'NA',
                    'allowSameStation' =>'0',
                    'allowSameBranch' =>'0',
                    'filterType' => 'NA'
                ));
                $result = json_decode($result);
                $data['result'] = $result;
            }
            
            // odometer details
            $result = $this->api_model->getTransitOdometerDetails(array(
                'transitCode' => $transitCode
            ));
            $result = json_decode($result);

            $odometer = array();
            foreach ($result->data as $row) {
                $odometer[$row->transitCargo->cargoActivityType->code][$row->fromStation->name] = $row;
            }
            $data['odoDetails'] = $odometer;
            
            $this->load->view('site/cargo/out-for-delivery-hire-challan-print-seenutransport', $data);
        }
    }

    public function ogpl_route_print() {
        $this->is_logged_in();
        $this->load->exclude_template();

        $transitCode = $this->input->get('transitCode');
        $transitCode = $this->input->get('transitCode');

        // Transit
        $ogpl = $this->api_model->cargoOGPLDetails(array(
            'transitCode' => $transitCode
        ));
        $ogpl = json_decode($ogpl);
        $data['ogpl'] = $ogpl->data;
        $organizationDetails = $this->api_model->getOrganizationDetails(array('organizationcode' =>$ogpl->data->fromOrganization->code));
        $organizationDetails = json_decode($organizationDetails);  
        $data['loadBranchDetails'] =$organizationDetails->data;
        // Local Transit
        if ($transitCode) {
            $result = $this->api_model->getDynamicReportDataWithMap(array(
                'queryCode' => 'RQJ45G4144',
                'cargoTransitCode' => $transitCode,
                'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
                'stationCode' => 'NA',
                'allowSameStation' => '0',
                'allowSameBranch' =>'0',
                'filterType' => 'NA'
            ));
            $result = json_decode($result);
            $data['result'] = $result;
        }

        // odometer details
        $result = $this->api_model->getTransitOdometerDetails(array(
            'transitCode' => $transitCode
        ));
        $result = json_decode($result);

        
        // $incomeexpense = $this->api_model->getTransitIncomeExpense(array(
        //     'transitCode' => $transitCode
        // ));
        // $incomeexpense = json_decode($incomeexpense);

        // $bookedBy = array();
        // foreach($incomeexpense->data as $item) {
        //     if (isset($item->user->name)) {
        //         $bookedBy[] = $item->user->name;
        //         break;
        //     }
        // }
        // $data['bookedBy'] = $bookedBy;

        $odometer = array();
        foreach ($result->data as $row) {
            $odometer[$row->fromStation->name][$row->transitCargo->cargoActivityType->code][] = $row;
        }
        $data['odoDetails'] = $odometer;

        // vehicle
        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        foreach ($vehicles->data as $row) {
            if ($row->code == $data['ogpl']->busVehicle->code) {
                $data['vehicle'] = $row;
            }
        }

        $this->load->view('site/cargo/ogpl-chart-route-print-seenutransport', $data);
    }

    public function loaded_ogpl_list() {
        $this->is_logged_in();

        $result = $this->api_model->getDynamicReportDataWithMap(array( 
        'queryCode' => 'RQJ45G4144',
        'cargoTransitCode' => $this->input->post('transitCode'),
        'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
        'stationCode' =>'NA',
        'allowSameStation' =>'0',
        'allowSameBranch' =>'0',
        'filterType' => 'NA'
        ));
        $result = json_decode($result);

        $list = array();
        foreach ($result->data as $row) {
            if ($row->cargo_status_code == 'CL') {
                $list[$row->from_station_name . ' to ' . $row->to_station_name][] = $row;
            }
        }

        // odometer details
        $transitCode = $this->input->post('transitCode');
        if ($transitCode) {
            $ogpl = $this->api_model->cargoOGPLDetails(array(
                'transitCode' => $transitCode
            ));
            $ogpl = json_decode($ogpl);
            $data['ogpl'] = $ogpl->data;

            $odoDetails = $this->api_model->getTransitOdometer(array(
                'transitCode' => $transitCode
            ));
            $odoDetails = json_decode($odoDetails);
            foreach ($odoDetails->data as $row) {
                if ($row->organization->code == $ogpl->data->fromOrganization->code) {
                    $data['odoDetails'] = $row;
                }
            }
        }

        $data['result'] = $list;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/loaded-ogpl-list', $data);
    }

    public function ogpl_unload_lr() {
        $this->is_logged_in();
        
    
        $result = $this->api_model->getDynamicReportDataWithMap(array(
        'queryCode' => 'RQJ45G4144',
        'cargoTransitCode' =>$this->input->get('transitCode'),
        'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
        'stationCode' => has_action_rights('CGO-VIEW-SAME-STION-LR') ? $this->session->userdata('org_station_code') : 'NA',
        'allowSameStation' => !has_action_rights('CGO-VIEW-ALL-LR') && has_action_rights('CGO-VIEW-SAME-STION-LR') ? '1' : '0',
        'allowSameBranch' => !has_action_rights('CGO-VIEW-ALL-LR') && has_action_rights('CGO-VIEW-SAME-BRNCH-LR') ? '1' : '0',
        'filterType' => 'UN_WI_PE'
        ));
        $result = json_decode($result);

        $transit = $this->input->get('transitType');
        $list = array();

        foreach ($result->data as $row) {
            if ($row->cargo_status_code == 'CL') {
                if (isNotNull($transit)) {
                    if ($row->transit_details_type != 'DFLT' && $row->transit_details_type != 'HULD') {
                        continue;
                    }
                }
                $key = $row->from_station_name;
                $key .= ($row->from_station_short_code!="") ? ' ( '.$row->from_station_short_code.' )' : '';
                $key .= ' to '.$row->transit_organization_name;
                $key .= ($row->transit_organization_short_code!="") ? ' ( '.$row->transit_organization_short_code.' )' : '';
            
                $list[$key][] = $row;
            }
        }

        $data['result'] = $list;
        $data['transit_code'] = $this->input->get('transitCode');
        $data['vehicle_code'] = $this->input->get('vehicleCode');
        $data['unload_type'] = $this->input->get('unloadType');

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $unloadremarks = $this->api_model->getCargoRemarksByStatus(array('cargoStatusCode' => 'CUL'));
        $unloadremarks = json_decode($unloadremarks);
        $data['unloadremarks'] = $unloadremarks->data;

        $ogpl = $this->api_model->cargoOGPLDetails(array(
            'transitCode' => $this->input->get('transitCode')
        ));
        $ogpl = json_decode($ogpl);
        $data['ogpl'] = $ogpl->data;
       
        $isFTLOGPL = in_array('FULL-TRK-LOAD', $ogpl->data->activity);

        $data['userorgcode'] = $this->session->userdata('org_code');
        $odoDetails = $this->api_model->getTransitOdometer(array(
            'transitCode' => $this->input->get('transitCode')
        ));
        $odoDetails = json_decode($odoDetails);
        foreach ($odoDetails->data as $row) {
            if (($isFTLOGPL && $row->endOdometer > 0) || ($row->organization->code == $data['userorgcode'])) {
                $data['odoDetails'] = $row;
                break;
            }
        }
        // $vehicles = $this->api_model->getVehicle();
        // $vehicles = json_decode($vehicles);
        // foreach ($vehicles->data as $row) {
        //     if ($row->code == $data['vehicle_code']) {
        //         $data['vehicle'] = $row;
        //     }
        // }
        // dd_json($data['vehicle']);
        //out staion odo
            $new_vehicle = $this->api_model->get_vehicle_details($data['vehicle_code']);
            $new_vehicle = json_decode($new_vehicle);
            $new_vehicle = $new_vehicle->data;
            $data['vehicle'] = $new_vehicle;
            // dd_json($data['vehicle']);
            // exit;
        $branchContact = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $branchContact = json_decode($branchContact);
        $data['branchContact'] = $branchContact->data;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $data['cargo_setting'] = _get_cargo_settings();
        $data['org_station_code']=$this->session->userdata('org_station_code');

        $this->load->view('site/cargo/ogpl-unload-lr', $data);
    }
    public function ogpl_endtrip(){
        $this->is_logged_in();
        $req_data = array(
            'organizationCode' =>$this->session->userdata('org_code'),
            'transitCode' => $this->input->post('transitCode')
        );
        echo $this->api_model->endTrip($req_data);
    }

    public function ogpl_update_unload() {
        //cloned: TransitPartialUnload/saveUnload();
        $this->is_logged_in();

        $transitOrganization = $this->input->post('transitOrganization') ?: ['code' => ''];
        if ($transitOrganization['code']) {
            $type = 'HUB_UNLOAD';
        }

        echo $this->api_model->cargoOGPLStatusUpdate(array(
            'transitStatus' => array('code' => 'UNLOAD'),
            'transitCode' => $this->input->post('transitCode'),
            'transitOrganization' => $transitOrganization,
            'cargoList' => $this->input->post('codes') ?: [],
            'type' => $type
        ));
    }

    public function gst_collection_report() {
        $this->is_logged_in();
        $this->load->view('site/cargo/gst-collection-report');
    }

    public function gst_collection_report_list() {
        $this->is_logged_in();
        $ns_id = $this->session->userdata('namespace_id');

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQJCHGE35',
            'fromDate' => $from_date,
            'toDate' => $to_date,
            'filterType' => $this->input->post('filterType'),
            'freightAmount' => $this->input->post('freightAmount') ?: 0
        );

        $key = $ns_id.'gst-collection-report-'.md5(http_build_query($data));

        if(!$result = $this->cache->file->get($key)) {            
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->cache->file->save($key, $result, 600); //  10 mins
        }

        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['cargo_setting'] = $setting = _get_cargo_settings();
        
        $summarizeGSTreport = function (&$summ, $row, $cargo_setting) {
            if($this->input->post('filterType') == 'GST'){    
                $summ['gst'] = $summ['gst'] + $row->service_tax;
                if($cargo_setting->lrGstTaxComputeType == 'NET') {
                    $freightwithL = $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->other_charges_amount;
                }else {
                    $freightwithL = $row->total_amount;
                }
                if($row->sgst > 0){
                    $sgst =  ($freightwithL * $row->sgst) / 100 ;
                    $summ['sgst'] = $summ['sgst']+$sgst;
                }
                if($row->cgst > 0){
                    $cgst =  ($freightwithL * $row->cgst) / 100 ;
                    $summ['cgst'] = $summ['cgst']+$cgst;
                }
                if($row->ugst > 0){
                    $ugst =  ($freightwithL * $row->ugst) / 100 ;
                    $summ['ugst'] = $summ['ugst']+$ugst;
                }
                if($row->igst > 0){
                    $igst =  ($freightwithL * $row->igst) / 100 ;
                    $summ['igst'] = $summ['igst']+$igst;
                }
            }

        };

        $amounts = array();
        $booking = array('booking' => []);
        $cancel = array('cancel' => []);
        $nongst_booking = array('nongst_booking' => []);
        $nongst_cancel = array('nongst_cancel' => []);
                
        $summary = array();
        foreach ($result->data as $row) {
            $amounts['netpayable'] = $amounts['netpayable'] + $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->service_charge+$row->other_charges_amount;
            $amounts['freight'] = $amounts['freight'] + $row->total_amount;
            $amounts['handling'] = $amounts['handling'] + $row->total_handling_amount;

            $amounts['freightwithlcharges'] = $amounts['freightwithlcharges'] + $row->total_amount+ $row->total_unload_handling_amount;
            
            if($row->transaction_type == 'CA' && $row->gstin){//cancel
                $cancel['cancel'][] = $row;
                $cancel['netpayable'] += $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->service_charge+$row->other_charges_amount;
                $cancel['freight'] += $row->total_amount;
                $summarizeGSTreport($cancel, $row, $data['cargo_setting']);
                $summarizeGSTreport($summary['Cancel (B)'][$row->gstin], $row, $data['cargo_setting']);
                $summary['Cancel (B)'][$row->gstin]['netpayable'] += $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->service_charge+$row->other_charges_amount;
                $summary['Cancel (B)'][$row->gstin]['freight'] += $row->total_amount; //
                $summary['Cancel (B)'][$row->gstin]['gst_state'] =$row->state_name;
            }else if($row->transaction_type == 'BO' && $row->gstin){
                $booking['booking'][] = $row;
                $booking['netpayable'] += $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->service_charge+$row->other_charges_amount;
                $booking['freight'] += $row->total_amount;
                $summarizeGSTreport($booking, $row, $data['cargo_setting']);
                $summarizeGSTreport($summary['Booking (A)'][$row->gstin], $row, $data['cargo_setting']);
                $summary['Booking (A)'][$row->gstin]['netpayable'] += $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->service_charge+$row->other_charges_amount;
                $summary['Booking (A)'][$row->gstin]['freight'] += $row->total_amount;
                $summary['Booking (A)'][$row->gstin]['gst_state'] = $row->state_name;
            }else if($row->transaction_type == 'CA' && !$row->gstin){//non gst cancel
                $nongst_cancel['nongst_cancel'][] = $row;
                $nongst_cancel['netpayable'] += $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->service_charge+$row->other_charges_amount;
                $nongst_cancel['freight'] += $row->total_amount;
                $summarizeGSTreport($nongst_cancel, $row, $data['cargo_setting']);
                $summarizeGSTreport($summary['Non GST Cancel (D)']['No GSTIN'], $row, $data['cargo_setting']);
                $summary['Non GST Cancel (D)']['No GSTIN']['netpayable'] += $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->service_charge+$row->other_charges_amount;
                $summary['Non GST Cancel (D)']['No GSTIN']['freight'] += $row->total_amount;
                $summary['Non GST Cancel (D)']['No GSTIN']['gst_state'] = $row->state_name;
            }else if($row->transaction_type == 'BO' && !$row->gstin){
                $nongst_booking['nongst_booking'][] = $row;
                $nongst_booking['netpayable'] += $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->service_charge+$row->other_charges_amount;
                $nongst_booking['freight'] += $row->total_amount;
                $summarizeGSTreport($nongst_booking, $row, $data['cargo_setting']);
                $summarizeGSTreport($summary['Non GST Booking (C)']['No GSTIN'], $row, $data['cargo_setting']);
                $summary['Non GST Booking (C)']['No GSTIN']['netpayable'] += $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->service_charge+$row->other_charges_amount;
                $summary['Non GST Booking (C)']['No GSTIN']['freight'] += $row->total_amount;
                $summary['Non GST Booking (C)']['No GSTIN']['gst_state'] = $row->gst_state;
            }
        }
        $data['booking'] = $booking;
        $data['cancel'] = $cancel;
        $data['nongst_booking'] = $nongst_booking;
        $data['nongst_cancel'] = $nongst_cancel;
        $data['summary'] = $summary;
        $data['cargo_status'] = $cargo_status = config_item('cargo_status');
        $data['cargo_payment_status'] = $cargo_payment_status = config_item('cargo_payment_status');
        $data['amounts'] = $amounts;
    
        if ($this->input->post('export') == 1) {
            $this->load->model('gst_report');
            $headerData = [
                [$this->session->userdata('namespace_name') . " - GST Report", '', '', '', '', ''],
                ['Report Date: ' . $from_date . " to " . $to_date, '', '', "Report At : " . date("d-m-Y h:i A"), '', ''],
            ];
        
            $gsting_columns = $this->gst_report->getGstingColumns($cargo_setting->lrGstTaxComputeType);
            $summaryData = $this->gst_report->getSummaryData($summary, $cargo_setting->lrGstTaxComputeType);
            $summary_accumulation = $this->gst_report->getSummaryAccumulation($booking, $cancel, $nongst_booking, $nongst_cancel, $cargo_setting);
        
            $GST_type = $setting->lrGstTaxComputeType == "FRT" ? "Freight" : "Net Amount";
            $columns = $this->gst_report->getColumns($GST_type);
            $bookingData = $this->gst_report->getBookingData($booking['booking'], $setting, $columns, $cargo_payment_status, $cargo_status);
            $cancelData = $this->gst_report->getCancelData($cancel['cancel'], $setting, $columns, $cargo_payment_status, $cargo_status);
            $nongst_booking = $this->gst_report->getNonBookingData($nongst_booking['nongst_booking'], $setting, $columns, $cargo_payment_status, $cargo_status);
            $nongst_cancel = $this->gst_report->getNonCancelData($nongst_cancel['nongst_cancel'], $setting, $columns, $cargo_payment_status, $cargo_status);
        
            $excel_data = [$headerData, $summaryData, $summary_columns, $summary_accumulation, $bookingData, $cancelData,$nongst_booking,$nongst_cancel];
            $this->load->excelByArrays($excel_data, 'GST_collection_report');
        } 
        else {
            $this->load->view('site/cargo/gst-collection-report-list',$data);
        }
    }

    public function branch_due_report() {
        $this->is_logged_in();

//        list($stations, $routes) = get_routes_and_stations();
//        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;
        $data['paystatus'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/branch-due-report', $data);
    }

    public function branch_due_report_list(){
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQJ5BA4349',
            'fromDate' => $this->input->post('from') ?: 'NA',
            'toDate' => $this->input->post('to') ?: 'NA',
            'paymentStatusCode' => $this->input->post('paystatus'),
            'organizationCode' => $this->input->post('organizationCode')
        );
        if (!has_action_rights('CGO-BR-DUE-ALL-BRAH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $list = array();
        $summary = array();
        foreach ($result->data as $row) {
            $list[$row->organization_name][] = $row;

            $row->net_payable = $row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax;
            $row->topay = ($row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax) - $row->total_amount_paid;

            $summary[$row->organization_name]['items'] += $row->total_item_count;
            $summary[$row->organization_name]['netPayable'] += $row->net_payable;
            $summary[$row->organization_name]['toPay'] += $row->topay;
            $summary[$row->organization_name]['paid'] += $row->total_amount_paid;
        }

        $data['result'] = $list;
        $data['summary'] = $summary;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/branch-due-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Branch-Due-Report.xls');
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
            $this->load->view('site/cargo/branch-due-report-list',$data);
        }
    }

    public function local_transit() {
        $this->is_logged_in();

        if ($this->input->get('fill') == 1) {
            $data['ffromDate'] = $this->session->userdata('itcl_search_from');
            $data['ftoDate'] = $this->session->userdata('itcl_search_to');
            $data['fvehicle'] = $this->session->userdata('itcl_vehicle');
            $data['faliasode'] = $this->session->userdata('itcl_aliascode');
        }

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $this->load->view('site/cargo/local-transit', $data);
    }

    public function local_transit_list() {
        $this->is_logged_in();

        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));

        $fromDate = $fromDate ? date('Y-m-d', strtotime($fromDate)) : 'NA';
        $toDate = $toDate ? date('Y-m-d', strtotime($toDate)) : 'NA';

        $this->session->set_userdata('itcl_search_from', $fromDate);
        $this->session->set_userdata('itcl_search_to', $toDate);
        $this->session->set_userdata('itcl_vehicle', $this->input->post('vehicleCode'));
        $this->session->set_userdata('itcl_aliascode', $this->input->post('aliasCode'));

        $param = array(
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            // 'transitStatus' => 'INIT',
            'vehicleCode' => trim($this->input->post('vehicleCode')),
            'transitCode' => 'NA',
            'aliasCode' => trim($this->input->post('aliasCode')),
            'organizationCode' => 'NA',
            'activityType' => 'NA',
            'transitType' => 'INTRNT'
        );
        if (!has_action_rights('LOCTRNT-ALL-BRCH')) {
            $param['organizationCode'] = $this->session->userdata('org_code');
        }
        $result = $this->api_model->cargoGetOGPLListv2($param);
        $result = json_decode($result);
        $result->data = array_reverse($result->data);
        $data['result'] = $result->data;

        $tabs = array();
        foreach ($result->data as $row) {
            if (in_array('PNDG-ARRVL', $row->activity)) {
                $tabs['ARRIVAL'][] = $row;
            } else if (in_array('YET-DEPTR', $row->activity)) {
                $tabs['DEPARTURE'][] = $row;
            } else if (in_array('DISPATCH', $row->activity)) {
                $tabs['DISPATCH'][] = $row;
            } else if (in_array('TRIP-CLOSE', $row->activity)) {
                $tabs['COMPLETE'][] = $row;
            } else {
                $tabs['DISPATCH'][] = $row;
            }
        }
       //local odo
        $vehicleTransit = [];
        foreach ($result->data as $row) {
            if ($row->busVehicle->code) {
                $vehicleTransit[$row->busVehicle->code] = $row->code;
            }
        }
        $data['vehicleTransit'] = $vehicleTransit;

        $data['cargo_setting'] = _get_cargo_settings();
        $data['tabs'] = $tabs;
        $data['aliasCodeFilter'] = trim($this->input->post('aliasCode'));
        $data['fogplLastActive'] = $this->input->post('lastActiveCode');
        $data['transittype'] = $this->input->post('transittypes');
        $data['transittypeout'] = $this->input->post('transittypeout');
        $data['activityType'] = config_item('activityType');
        $this->load->view('site/cargo/local-transit-list', $data);
    }

    function local_transit_fuel_expense() {
        $this->is_logged_in();

        $data = array(
            'transitCode' => $this->input->post('transitCode')
        );

        $result = $this->api_model->getTransitFuelDetails($data);
        $result = json_decode($result);
        $data['fuelExpensesData'] = $result->data;

        $totalFuelAmount = 0;
        foreach ($result->data as $row) {
            $totalFuelAmount = $row->totalAmount;
        }
        $data['totalFuelAmount'] = $totalFuelAmount;

        $vendors = $this->api_model->getContact(array(
            'entityTypeCode' => 'RAC'
        ));
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;
        
        $this->load->view('site/cargo/local-transit-fuel-expenses', $data);
    }

    public function update_local_transit_fuel_expense() {
        $this->is_logged_in();

        echo $this->api_model->updateTransitFuelDetails(array(
            'code' => $this->input->post('code'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'fuelDate' => $this->input->post('fuelDate'),
            'vehicle' => $this->input->post('vehicle'),
            'location' => $this->input->post('location'),
            'transitCargo' => $this->input->post('transitCargo'),
            'vendorContact' => $this->input->post('vendorContact'),
            'paymentBranch' => $this->input->post('paymentBranch')?:null,
            'litres' => $this->input->post('litres'),
            'pricePerLitre' => $this->input->post('pricePerLitre'),
            'totalAmount' => $this->input->post('totalAmount'),
            'evidenceNumber' => $this->input->post('evidenceNumber'),
            'billNumber' => $this->input->post('billNumber'),
            'transactionMode' => $this->input->post('transactionMode') ?: array('code' => 'CASH')
        ));
    }

    function local_transit_income_expense() {
        $this->is_logged_in();

        $data = array(
            'transitCode' => $this->input->post('transitCode')
        );

        $result = $this->api_model->getTransitIncomeExpense($data);
        $result = json_decode($result);
        $data['expensesData'] = $result->data;

        $triphead = $this->api_model->getCashbookHead();        
        $triphead = json_decode($triphead);
        $data['triphead'] = $triphead->data;

        $contact = $this->api_model->getContact();
        $contact = json_decode($contact);

        $con = array();
        foreach($contact->data as $key=>$val){
            $con[$val->contactCategory->name][$key] = $val;
            $con[$val->contactCategory->name][$key] = $val;
        }
        
        $data['contact'] = $con;

        $vehicleCode = $this->input->post('vehicleCode');
        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);

        $vehicle = array();
        foreach($vehicles->data as $key=>$val){
            if ($vehicleCode == $val->code) {
                $vehicle = $val;
            }
        }
        $data['vehicles'] = $vehicle;

        $bankdetail = $this->api_model->getOrganizationOtherDetails(array(
            'organizationcode' => $this->session->userdata('org_code')
        ));
        $bankdetail = json_decode($bankdetail);
        $data['bankdetail'] = $bankdetail->data->bankDetails;

        $cash_book_type = array();
        foreach ($data['expensesData'] as $key=>$val){
            // if($val->cashbookType->code == 'HIRING'){
                $cash_book_type[$val->cashbookType->code] = $val;
            // }
        }

        krsort($cash_book_type);

        $data['cashbookType'] = $cash_book_type;
        $data['ogplType'] = $this->input->post('ogplType');
        $data['cargoActivityType'] = $this->input->post('cargoActivityType');
        $data['bank_names_list'] = $this->config->item('bank_names_list');
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['cargo_setting'] = _get_cargo_settings();

        $this->load->view('site/cargo/local-transit-income-expenses', $data);
    }

    public function update_local_transit_income_expense() {
        $this->is_logged_in();
        
        $ogpl = $this->input->post('ogpl')?: [];

        echo $this->api_model->updateTransitIncomeExpense($ogpl);
    }

    public function add_local_transit() {
        $this->is_logged_in();

        $data = array();

        $data['login_branch'] = $this->session->userdata('org_code');
        $transitCode = $this->input->get('transitCode');
        if ($transitCode) {
            $ogpl = $this->api_model->cargoOGPLDetails(array(
                'transitCode' => $transitCode
            ));
            $ogpl = json_decode($ogpl);
            $data['ogpl'] = $ogpl->data;

            $odoDetails = $this->api_model->getTransitOdometer(array(
                'transitCode' => $transitCode
            ));
            $odoDetails = json_decode($odoDetails);
            foreach ($odoDetails->data as $row) {
                if ($row->organization->code == $ogpl->data->fromOrganization->code) {
                    $data['odoDetails'] = $row;
                }
            }
        }

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $vehicles = $this->api_model->getAllVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;

        $drivers = $this->api_model->getVehicleDriver();
        $drivers = json_decode($drivers);
        $data['drivers'] = $drivers->data;

        $data['linkVehicleCode'] = $this->input->get('linkVehicleCode');

        $data['login_station'] = $this->session->userdata('org_station_code');

        $this->load->view('site/cargo/add-local-transit', $data);
    }

    public function booked_local_transit_list() {
        $this->is_logged_in();
        $data = array();

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;

        $branchContact = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $branchContact = json_decode($branchContact);
        $data['branchContact'] = $branchContact->data;

        $contact = $this->api_model->getContact();
        $contact = json_decode($contact);
        $data['vendors'] = $contact->data;

        $con = array();
        foreach($contact->data as $key=>$val){
            $con[$val->contactCategory->name][$key] = $val;
            $con[$val->contactCategory->name][$key] = $val;
        }
        
        $data['contact'] = $con;
        $data['f_t_mode'] = config_item('transaction_mode');

        $this->load->view('site/cargo/booked-local-transit-list', $data);
    }

    public function booked_local_transit_search_list() {
        $this->is_logged_in();

        $fromOrg = $this->input->post('fromOrg');
        $toOrg   = $this->input->post('toOrg');

        $data = array(
            'queryCode' => 'RQJ4KJU47',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'fromStationCode' => 'NA',
            'toStationCode' => 'NA',
            'viaStationCodes' => $this->input->get_post('viaStationCodes') ?: 'NA',
            'transitOrganizationCode' => $this->session->userdata('org_code'),
            'transitTypeCode' => 'INTRNT',
            'cargoCode' => $this->input->get_post('cargoCode') ?: 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        
        $filtered = array();
        foreach ($result->data as $row) { // internal filter to use local transit for bi-directional. 
            if ( $fromOrg != "" && $fromOrg != $row->from_organization_code) {
                continue;
            }
            if ( $toOrg != "" && $toOrg != $row->to_organization_code) {
                continue;
            }
            $filtered[] = $row;
        }

        $list = array();
        foreach ($filtered as $row) {
            $key = $row->from_station_name;
            $key .= ($row->from_station_short_code!="") ? ' ( '.$row->from_station_short_code.' )' : '';
            $key .= ' to '.$row->to_station_name;
            $key .= ($row->to_station_short_code!="") ? ' ( '.$row->to_station_short_code.' )' : '';
            
            $list[$key][] = $row;
        }
        $data['result'] = $list;

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;

        $data['transitCode'] = $this->input->post('code');
        $data['tripDate'] = $this->input->post('tripDate');

        if ($data['transitCode']) {
            $data['userorgcode'] = $this->session->userdata('org_code');
            $odoDetails = $this->api_model->getTransitOdometer(array(
                'transitCode' => $data['transitCode']
            ));
            $odoDetails = json_decode($odoDetails);
            foreach ($odoDetails->data as $row) {
                if ($row->organization->code == $data['userorgcode']) {
                    $data['odoDetails'] = $row;
                }
            }
        }

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/booked-local-transit-search-list', $data);
    }

    public function load_local_transit_list() {
        $this->is_logged_in();

        $ogpl = $this->api_model->cargoOGPLupdate(array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code') ?: '',
            'name' => $this->input->post('name'),
            'fromStation' => array('code' => $this->session->userdata('org_station_code')),
            'toStation' => array('code' => $this->session->userdata('org_station_code')),
            'fromOrganization' => array('code' => $this->session->userdata('org_code')),
            'toOrganization' => $this->input->post('toOrganization'),
            'viaStations' => $this->input->post('viaStations') ?: [],
            'viaOrganizations' => $this->input->post('viaOrganizations') ?: [],
            'tripDate' => $this->input->post('tripDate'),
            'busVehicle' => $this->input->post('busVehicle'),
            'vehicleDriver' => $this->input->post('vehicleDriver'),
            'secondaryDriver' => $this->input->post('secondaryDriver') ?: ['code' => ''],
            'cargoActivityType' => $this->input->post('cargoActivityType'),
            'remarks' => $this->input->post('remarks'),
            'arrivalMinutes' => (int) $this->input->post('arrivalMinutes'),
            'departureMinutes' => (int) $this->input->post('departureMinutes'),
            'odometer' => $this->input->post('odometer') ?: '',
            'transitReference' => $this->input->post('transitReference') ?: [],
        ));

        $ogpl = json_decode($ogpl);

        if ($ogpl->status != 1) {
            echo json_encode($ogpl);
            return;
        }

        $loadList = $this->input->post('loadList') ?: [];

        $cargoResponseState = [];

        foreach ($loadList as $row) {
            $codes = array_map(function($v) {
                return array('code' => $v);
            }, $row['cargoList']);

            $load = $this->api_model->cargoOGPLload(array(
                'code' => '',
                'name' => '',
                'activeFlag' => 1,
                'actionCode' => 'ADD',
                'transitStatus' => array('code' => 'INIT'),
                'toStation' => array('code' => $row['to']),
                'fromStation' => array('code' => $row['from']),
                'fromOrganization' => array('code' => $this->session->userdata('org_code')),
                'toOrganization' => $this->input->post('toOrganization'),
                'transitCargo' => array('code' => $ogpl->data->code),
                'transitDetailsType' => array('code' => 'LCLD'),
                'transitOrganization' => array('code' => $row['transitOrganization']),
                'cargoList' => $codes
            ));

            $load = json_decode($load);

            if ($load->status == 1) {
                $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
            } else {
                echo json_encode($load);
                return;
            }
        }

        echo json_encode(array(
            'status' => 1,
            'OGPLCode' => $ogpl->data->code,
            'OGPLDate' => $this->input->post('tripDate'),
            'cargoResponseState' => $cargoResponseState
        ));
    }

    public function unload_local_transit_list() {
        $unloadList = $this->input->post('unloadList') ?: [];

        foreach ($unloadList as $row) {
            $codes = array_map(function($v) {
                return array('code' => $v);
            }, $row['cargoList']);

            $load = $this->api_model->cargoOGPLload(array(
                'code' => '',
                'name' => '',
                'activeFlag' => 1,
                'actionCode' => 'REMOVE',
                'transitStatus' => array('code' => 'UNLOAD'),
                'toStation' => array('code' => $row['to']),
                'fromStation' => array('code' => $row['from']),
                'fromOrganization' => array('code' => $row['fromOrg']),
                'toOrganization' => array('code' => $row['toOrg']),
                'transitDetailsType' => array('code' => $row['transitType']),
                'transitCargo' => array('code' => $this->input->post('transitCargo')),
                'cargoList' => $codes
            ));
        }

        echo $load;
    }

    public function local_transit_chart_details() {
        $this->is_logged_in();
        $transitCode = $this->input->get('transitCode');
        $transitType = $this->input->get('transitType');
        $ogpl = $this->api_model->cargoOGPLDetails(array(
            'transitCode' => $this->input->get('transitCode')
        ));
        $ogpl = json_decode($ogpl);
        $data['ogpl'] = $ogpl->data;

        $result = $this->api_model->getDynamicReportDataWithMap(array( 
        'queryCode' => 'RQJ45G4144',
        'cargoTransitCode' => $this->input->get('transitCode'),
        'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
        'stationCode' =>'NA',
        'allowSameStation' =>'0',
        'allowSameBranch' =>'0',
        'filterType' => 'LOAD'
        ));
        $result = json_decode($result);

        $rowCount = 0;
        $transitDetails = array();
        $list = array();
        $summary = array();
        $showTransitTypes = array();
        foreach ($result->data as $row) {

            $showTransitTypes[] = $row->transit_details_type;
            if ($transitType == 'DFLT'){
                if ($row->transit_details_type != 'DFLT') {
                    continue;
                }
            }
            
            if ($transitType == 'HULD'){
                if ($row->transit_details_type != 'HULD') {
                    continue;
                }
            }

            if ($transitType == 'LCLD'){
                if ($row->transit_details_type != 'LCLD') {
                    continue;
                }
            }

            if ($transitType == 'OFDLD'){
                if ($row->transit_details_type != 'OFDLD') {
                    continue;
                }
            }
            $rowCount += 1;
            $transitDetails[] = $row->transit_details_type;

            $key = $row->from_station_name;
            $key .= ($row->from_station_short_code!="") ? ' ( '.$row->from_station_short_code.' )' : '';
            $key .= ' to '.$row->transit_organization_name;
            $key .= ($row->transit_organization_short_code!="") ? ' ( '.$row->transit_organization_short_code.' )' : '';
            
            $list[$key][] = $row;

            $summary[$row->payment_status_code]['lr'] += 1;
            //$summary[$row->payment_status_code]['paycode'] += $row->payment_status_code;
            $summary[$row->payment_status_code]['packages'] += $row->total_item_count;
            $summary[$row->payment_status_code]['freight'] += $row->total_amount;
            $summary[$row->payment_status_code]['loading'] += $row->total_handling_amount;
            $summary[$row->payment_status_code]['unloading'] += $row->total_unload_handling_amount;
            $summary[$row->payment_status_code]['service_tax'] += $row->service_tax;
            $summary[$row->payment_status_code]['pickup'] += $row->pickup_handling_amount;
            $summary[$row->payment_status_code]['delivery'] += $row->delivery_handling_amount;
            $summary[$row->payment_status_code]['other'] += $row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge+$row->service_charge+$row->demurrage_charge;
        }
        //ogpl-details-for-start-trip
        $data['login_user'] = $this->session->userdata('user_id');
        $data['login_branch'] = $this->session->userdata('org_code');
        //odometer details
        $odoDetails = $this->api_model->getTransitOdometer(array(
            'transitCode' => $transitCode
        ));
        foreach (getData($odoDetails) as $row) {
            if ($row->organization->code == $ogpl->data->fromOrganization->code) {
                $data['odoDetails'] = $row;
            }
        }
        //odometer details end
        //ogpl-details-for-start-trip

        $data['rowCount'] = $rowCount;
        $data['summary'] = $summary;

        $data['transitDetails'] = array_unique($transitDetails);
        $data['result'] = $list;
        $data['cargo_setting'] = _get_cargo_settings();
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['showTransitTypes'] = array_unique($showTransitTypes);

        $this->load->view('site/cargo/local-transit-chart', $data);
    }

    public function local_transit_chart_details_print() {
        $this->is_logged_in();
        $this->load->exclude_template();
        $transitCode = $this->input->get('transitCode');
        $ogpl = $this->api_model->cargoOGPLDetails(array(
            'transitCode' => $this->input->get('transitCode')
        ));
        $ogpl = json_decode($ogpl);
        $data['ogpl'] = $ogpl->data;

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ45G4144',
            'cargoTransitCode' => $this->input->get('transitCode'),
            'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
            'stationCode' =>'NA',
            'allowSameStation' =>'0',
            'allowSameBranch' =>'0',
            'filterType' => 'LOAD'
        ));
        $result = json_decode($result);

        $list = array();
        $summary = array();
        $route = $this->input->get('route');
        foreach ($result->data as $row) {
            $key = $row->from_station_name;
            $key .= ($row->from_station_short_code!="") ? ' ( '.$row->from_station_short_code.' )' : '';
            $key .= ' to '.$row->transit_organization_name;
            $key .= ($row->transit_organization_short_code!="") ? ' ( '.$row->transit_organization_short_code.' )' : '';
            
            if ($route == '' || $route == $key) {
                $list[$key][] = $row;
            }

            $summary[$key][$row->payment_status_code]['lr'] += 1;
            //$summary[$row->payment_status_code]['paycode'] += $row->payment_status_code;
            $summary[$key][$row->payment_status_code]['packages'] += $row->total_item_count;
            $summary[$key][$row->payment_status_code]['freight'] += $row->total_amount;
            $summary[$key][$row->payment_status_code]['loading'] += $row->total_handling_amount;
            $summary[$key][$row->payment_status_code]['unloading'] += $row->total_unload_handling_amount;
            $summary[$key][$row->payment_status_code]['service_tax'] += $row->service_tax;
            $summary[$key][$row->payment_status_code]['pickup'] += $row->pickup_handling_amount;
            $summary[$key][$row->payment_status_code]['delivery'] += $row->delivery_handling_amount;
            $summary[$key][$row->payment_status_code]['other'] += $row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge+$row->service_charge+$row->demurrage_charge;
        
        }

        $data['summary'] = $summary;

        $data['result'] = $list;
        
         //ogpl-details-for-start-trip
        $data['login_user'] = $this->session->userdata('user_id');
        $data['login_branch'] = $this->session->userdata('org_code');
        $odoDetails = $this->api_model->getTransitOdometer(array(
            'transitCode' => $transitCode
        ));
        $odoDetails = json_decode($odoDetails);
        $odometerDetails = [];
        foreach ($odoDetails->data as $row) {
            if ($row->organization->code == $ogpl->data->fromOrganization->code) {
                $odometerDetails['fromOdoDetail'] = $row;
            }
            if($row->organization->code == $this->session->userdata('org_code')){
                $odometerDetails['myOdoDetail'] = $row;
            }
            if($row->organization->code == $ogpl->data->toOrganization->code){
                $odometerDetails['toOdoDetail'] = $row;
            }
        }
        $data['odoDetails'] = $odometerDetails; 
        //odometer details end
        //ogpl-details-for-start-trip
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        if($this->session->userdata('namespace_id') == "rathimeenaparcel") {
            $this->load->view('site/cargo/local-transit-chart-print-rathimeenaparcel', $data);
        } else {
            $this->load->view('site/cargo/local-transit-chart-print', $data);
        }
    }

    public function loaded_local_transit_list() {
        $this->is_logged_in();

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ45G4144',
            'cargoTransitCode' => $this->input->post('transitCode'),
            'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
            'stationCode' => 'NA',
            'allowSameStation' =>'0',
            'allowSameBranch' =>'0',
            'filterType' => 'NA'
        ));
        $result = json_decode($result);

        $list = array();
        foreach ($result->data as $row) {
            if ($row->cargo_status_code == 'CL') {
                $list[$row->from_station_name . ' to ' . $row->to_station_name][] = $row;
            }
        }

        $data['result'] = $list;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/loaded-local-transit-list', $data);
    }

    public function local_transit_unload_lr() {
        $this->is_logged_in();

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ45G4144',
            'cargoTransitCode' => $this->input->get('transitCode'),
            'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
            'stationCode' => has_action_rights('CGO-VIEW-SAME-STION-LR') ? $this->session->userdata('org_station_code') : 'NA',
            'allowSameStation' => !has_action_rights('CGO-VIEW-ALL-LR') && has_action_rights('CGO-VIEW-SAME-STION-LR') ? '1' : '0',
            'allowSameBranch' => !has_action_rights('CGO-VIEW-ALL-LR') && has_action_rights('CGO-VIEW-SAME-BRNCH-LR') ? '1' : '0',
            'filterType' => 'UN_WI_PE'
        ));
        $result = json_decode($result);
        $transit = $this->input->get('transitType');

        $list = array();
        foreach ($result->data as $row) {
            if ($row->cargo_status_code == 'CL') {
                if (isNotNull($transit)) {
                    if ($row->transit_details_type != 'LCLD') {
                        continue;
                    }
                }
                $list[$row->from_station_name . ' to ' . $row->to_station_name][] = $row;
            }
        }
        $data['result'] = $list;
        $data['transit_code'] = $this->input->get('transitCode');
        $data['vehicle_code'] = $this->input->get('vehicleCode');
        $data['unload_type'] = $this->input->get('unloadType');
    
        $data['userorgcode'] = $this->session->userdata('org_code');
        $odoDetails = $this->api_model->getTransitOdometer(array(
            'transitCode' => $this->input->get('transitCode')
        ));
        $odoDetails = json_decode($odoDetails);
        foreach ($odoDetails->data as $row) {
            if ($row->organization->code == $data['userorgcode']) {
                $data['odoDetails'] = $row;
            }
        }

        
        $new_vehicle = $this->api_model->get_vehicle_details($data['vehicle_code']);
        $new_vehicle = json_decode($new_vehicle);
        $new_vehicle = $new_vehicle->data;
        $data['vehicle'] = $new_vehicle;
        
        //local odo 
        $branchContact = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $branchContact = json_decode($branchContact);
        $data['branchContact'] = $branchContact->data;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');        
        $data['transit_code'] = $this->input->get('transitCode');
        $data['cargo_setting'] = _get_cargo_settings();

        $this->load->view('site/cargo/local-transit-unload-lr', $data);
    }

    public function local_transit_update_unload() {
        $this->is_logged_in();

        $cargoCodes = (array) $this->input->post('codes');
        $codes = array_map(function($v) {
            return array(
                'code' => $v,
                'cargoStatus' => array('code' => 'CUL')
            );
        }, $cargoCodes);

        echo $this->api_model->cargoOGPLStatusUpdate(array(
            'transitStatus' => array('code' => 'UNLOAD'),
            'transitCode' => $this->input->post('transitCode'),
            'transitOrganization' => $this->input->post('transitOrganization') ?: ['code' => ''],
            'cargoList' => $codes
        ));
    }

    public function out_for_delivery() {
        $this->is_logged_in();

        if ($this->input->get('fill') == 1) {
            $data['ffromDate'] = $this->session->userdata('ofd_search_from');
            $data['ftoDate'] = $this->session->userdata('ofd_search_to');
            $data['fvehicle'] = $this->session->userdata('ofd_vehicle');
            $data['faliasode'] = $this->session->userdata('ofd_aliascode');
        }

        $vehicles = $this->api_model->getAllVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;
        
        $this->load->view('site/cargo/out-for-delivery', $data);
    }

    public function out_for_delivery_list() {
        $this->is_logged_in();

        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));

        $fromDate = $fromDate ? date('Y-m-d', strtotime($fromDate)) : 'NA';
        $toDate = $toDate ? date('Y-m-d', strtotime($toDate)) : 'NA';

        $this->session->set_userdata('ofd_search_to', $toDate);
        $this->session->set_userdata('ofd_search_from', $fromDate);
        $this->session->set_userdata('ofd_vehicle', $this->input->post('vehicleCode'));
        $this->session->set_userdata('ofd_aliascode', $this->input->post('aliasCode'));

        $param = array(
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'vehicleCode' => trim($this->input->post('vehicleCode')),
            'transitCode' => 'NA',
            'aliasCode' => trim($this->input->post('aliasCode')),
            'organizationCode' => 'NA',
            'activityType' => 'LOAD',
            'transitType' => 'OTFD'
        );
        if (!has_action_rights('OTFD-ALL-BRCH')) {
            $param['organizationCode'] = $this->session->userdata('org_code');
        }
        $result = $this->api_model->cargoGetOGPLListv2($param);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $this->load->view('site/cargo/out-for-delivery-list', $data);
    }

    public function add_out_for_delivery() {
        $this->is_logged_in();

        $data = array();

        $transitCode = $this->input->get('transitCode');
        if ($transitCode) {
            $ogpl = $this->api_model->cargoOGPLDetails(array(
                'transitCode' => $transitCode
            ));
            $ogpl = json_decode($ogpl);
            $data['ogpl'] = $ogpl->data;
        }

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $vehicles = $this->api_model->getAllVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;
        
        $ownershipTypes = array();
        foreach ($vehicles->data as $vehicle) {
            $ownershipTypes[$vehicle->ownershipType->code] = $vehicle->ownershipType->name;
        }
        $data['ownershipTypes'] = $ownershipTypes;
        
        $drivers = $this->api_model->getVehicleDriver();
        $drivers = json_decode($drivers);
        $data['drivers'] = $drivers->data;

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;
        $data['login_station'] = $this->session->userdata('org_station_code');
        $data['login_branch'] = $this->session->userdata('org_code');
        $data['cargo_setting'] = _get_cargo_settings();
        $data['linkVehicleCode'] = $this->input->get('linkVehicleCode');
        
        $this->load->view('site/cargo/add-out-for-delivery', $data);
    }

    public function booked_out_for_delivery_list() {
        $this->is_logged_in();

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;

        $branchContact = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $branchContact = json_decode($branchContact);
        $data['branchContact'] = $branchContact->data;

        $this->load->view('site/cargo/booked-out-for-delivery-list');
    }

    public function booked_out_for_delivery_search_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQJ4KJU47',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'fromStationCode' => 'NA',
            'toStationCode' => 'NA',
            'viaStationCodes' => $this->input->get_post('viaStationCodes') ?: 'NA',
            'transitOrganizationCode' => $this->session->userdata('org_code'),
            'transitTypeCode' => 'OTFD',
            'cargoCode' => $this->input->get_post('cargoCode') ?: 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $param = array(
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'stationCode' => $this->session->userdata('org_station_code'),
        );
        $prebook = $this->api_model->loadablePrebookList($param);
        $prebook = json_decode($prebook);
        $data['prebook'] = $prebook->data;

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $data['branches'] = $branches->data;

        $data['transitCode'] = $this->input->post('code');
        $data['tripDate'] = $this->input->post('tripDate');

        if ($data['transitCode']) {
            $outForDel = $this->api_model->cargoOGPLDetails(array(
                'transitCode' => $data['transitCode']
            ));
            $outForDel = json_decode($outForDel);
            $outForDel = $outForDel->data;
            $isFTLOFD = in_array('FULL-TRK-LOAD', $outForDel->activity);

            $data['userorgcode'] = $this->session->userdata('org_code');
            $odoDetails = $this->api_model->getTransitOdometer(array(
                'transitCode' => $data['transitCode']
            ));

            $odoDetails = json_decode($odoDetails);
            foreach ($odoDetails->data as $row) {
                if (($row->organization->code == $data['userorgcode']) || ($isFTLOFD && $row->organization->code == $outForDel->fromOrganization->code)) {
                    $data['odoDetails'] = $row;
                }
            }
        }

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/booked-out-for-delivery-search-list', $data);
    }

    public function load_out_for_delivery_list() {
        $this->is_logged_in();

        $ogpl = $this->api_model->cargoOGPLupdate(array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code') ?: '',
            'name' => $this->input->post('name'),
            'fromStation' => $this->input->post('fromStation') ?: array('code' => $this->session->userdata('org_station_code')),
            'toStation' => $this->input->post('toStation') ?: array('code' => $this->session->userdata('org_station_code')),
            'fromOrganization' => $this->input->post('fromOrganization') ?: array('code' => $this->session->userdata('org_code')),
            'toOrganization' => $this->input->post('toOrganization') ?: array('code' => $this->session->userdata('org_code')),
            'viaStations' => [],
            'tripDate' => $this->input->post('tripDate'),
            'busVehicle' => $this->input->post('busVehicle'),
            'vehicleDriver' => $this->input->post('vehicleDriver'),
            'cargoActivityType' => $this->input->post('cargoActivityType'),
            'remarks' => $this->input->post('remarks'),
            'odometer' => $this->input->post('odometer') ?: '',
            'transitReference' => $this->input->post('transitReference') ?: [],
            'additionalAttribute' => $this->input->post('additionalAttribute') ?: null,
        ));

        $ogpl = json_decode($ogpl);

        if ($ogpl->status != 1) {
            echo json_encode($ogpl);
            return;
        }

        $loadList = $this->input->post('loadList') ?: [];

        $cargoResponseState = [];

        foreach ($loadList as $row) {
            $codes = array_map(function($v) {
                return array('code' => $v);
            }, $row['cargoList']);

            $load = $this->api_model->cargoOGPLload(array(
                'code' => '',
                'name' => '',
                'activeFlag' => 1,
                'actionCode' => 'ADD',
                'transitStatus' => array('code' => 'INIT'),
                'toStation' => array('code' => $row['to']),
                'fromStation' => array('code' => $row['from']),
                'fromOrganization' => $this->input->post('toOrganization') ?: array('code' => $this->session->userdata('org_code')),
                'toOrganization' => $this->input->post('toOrganization') ?: array('code' => $this->session->userdata('org_code')),
                'transitCargo' => array('code' => $ogpl->data->code),
                'transitDetailsType' => array('code' => 'OFDLD'),
                'transitOrganization' => $this->input->post('toOrganization') ?: array('code' => $this->session->userdata('org_code')),
                'cargoList' => $codes
            ));
            $load = json_decode($load);

            if ($load->status == 1) {
                $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
            } else {
                echo json_encode($load);
                return;
            }
        }
        
        $prebookLoadList = $this->input->post('prebookLoadList') ?: [];

        $cargoResponseState = [];

        foreach ($prebookLoadList as $row) {
            $codes = array_map(function($v) {
                return array('code' => $v);
            }, $row['cargoList']);

            $load = $this->api_model->loadPrebookList(array(
                'code' => '',
                'name' => '',
                'activeFlag' => 1,
                'actionCode' => 'ADD',
                'transitStatus' => array('code' => 'INIT'),
                'toStation' => array('code' => $row['to']),
                'fromStation' => array('code' => $row['from']),
                'fromOrganization' => array('code' => $this->session->userdata('org_code')),
                'toOrganization' => array('code' => $this->session->userdata('org_code')),
                'transitCargo' => array('code' => $ogpl->data->code),
                'transitOrganization' => array('code' => $this->session->userdata('org_code')),
                'cargoList' => $codes
            ));
            $load = json_decode($load);

            if ($load->status == 1) {
                $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
            } else {
                echo json_encode($load);
                return;
            }
        }

        echo json_encode(array(
            'status' => 1,
            'OGPLCode' => $ogpl->data->code,
            'OGPLDate' => $this->input->post('tripDate'),
            'cargoResponseState' => $cargoResponseState
        ));
    }

    public function unload_out_for_delivery_list() {
        $unloadList = $this->input->post('unloadList') ?: [];

        foreach ($unloadList as $row) {
            $codes = array_map(function($v) {
                return array('code' => $v);
            }, $row['cargoList']);

            $load = $this->api_model->cargoOGPLload(array(
                'code' => '',
                'name' => '',
                'activeFlag' => 1,
                'actionCode' => 'REMOVE',
                'transitStatus' => array('code' => 'UNLOAD'),
                'toStation' => array('code' => $row['to']),
                'fromStation' => array('code' => $row['from']),
                'fromOrganization' => array('code' => $row['fromOrg']),
                'toOrganization' => array('code' => $row['toOrg']),
                'transitDetailsType' => array('code' => $row['transitType']),
                'transitCargo' => array('code' => $this->input->post('transitCargo')),
                'cargoList' => $codes
            ));
        }

        echo $load;
    }

    public function out_for_delivery_chart_details() {
        $this->is_logged_in();

        $ogpl = $this->api_model->cargoOGPLDetails(array(
            'transitCode' => $this->input->get('transitCode')
        ));
        $ogpl = json_decode($ogpl);
        $data['ogpl'] = $ogpl->data;

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ45G4144',
            'cargoTransitCode' => $this->input->get('transitCode'),
            'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
            'stationCode' =>'NA',
            'allowSameStation' => '0',
            'allowSameBranch' => '0',
            'filterType' => 'LOAD'
        ));
        $result = json_decode($result);

        $list = array();
        foreach ($result->data as $row) {
            $list[$row->from_station_name . ' to ' . $row->to_station_name][] = $row;
        }

        $data['result'] = $list;

        $prebook = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ13T8637',
            'transitCode' => $this->input->get('transitCode'),
            'filterType' => 'LOAD'
        ));
        $prebook = json_decode($prebook);

        $list = array();
        foreach ($prebook->data as $row) {
            $list[$row->from_station_name . ' to ' . $row->to_station_name][] = $row;
        }
        $data['prebook'] = $list;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/out-for-delivery-chart', $data);
    }

    public function out_for_delivery_chart_details_print() {
        $this->is_logged_in();
        $this->load->exclude_template();
        $this->load->helper('slug');
        $ogpl = $this->api_model->cargoOGPLDetails(array(
            'transitCode' => $this->input->get('transitCode')
        ));
        $ogpl = json_decode($ogpl);
        $data['ogpl'] = $ogpl->data;

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ45G4144',
            'cargoTransitCode' => $this->input->get('transitCode'),
            'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
            'stationCode' => 'NA',
            'allowSameStation' => '0',
            'allowSameBranch' => '0',
            'filterType' => 'LOAD'
        ));
        $result = json_decode($result);
        
        $door_delivery_status = [];
        foreach ($result->data as $row) {
            if($row->door_delivery_remarks !==null){
                $door_delivery_status[$row->door_delivery_remarks]['status_name']  = $row->door_delivery_remarks;
                $door_delivery_status[$row->door_delivery_remarks]['lr_count']  += count($row->cargo_code);//
                $door_delivery_status[$row->door_delivery_remarks]['lr_amount']  +=($row->total_amount + $row->other_charges_amount);
                $data['bookedAt'] = $row->booked_at;
            }

          
        }

        $list = array();
        $payment_details = array();
        $return_to_branch = array();
        $noreturn_branch = array();
        $route = $this->input->get('route');
        foreach ($result->data as $row) {
            $list[$row->from_station_name .' to '.$row->to_station_name][] = $row;
            if ($row->nearby_branch_details != null) {
                $branchData = explode(':', $row->nearby_branch_details);
                $branchData = $branchData[1];
                $row->nearby_branch_details =$branchData;
                $noreturn_branch[$row->nearby_branch_details]['count'] += 1;
                $noreturn_branch[$row->nearby_branch_details]['amount'] += $row->total_amount+$row->other_charges_amount;
            } else {
                $row->nearby_branch_details = ' ';
                $noreturn_branch[$row->nearby_branch_details]['count'] += 1;
                $noreturn_branch[$row->nearby_branch_details]['amount'] += $row->total_amount+$row->other_charges_amount;
            }

            $payment_details[$row->payment_status_code]['count'] += 1;
            $payment_details[$row->payment_status_code]['amount'] += $row->total_amount+$row->other_charges_amount;

            if ($row->payment_settlement_flag == 1) {
                $payment_details[$row->payment_status_code]['paid_count'] += 1;
                $payment_details[$row->payment_status_code]['paid_amt'] += $row->total_amount+$row->other_charges_amount;
            } else {
                $payment_details[$row->payment_status_code]['pend_count'] += 1;
                $payment_details[$row->payment_status_code]['pending_amt'] += $row->total_amount+$row->other_charges_amount;
            }

            if ($row->to_organization_code == $row->transit_to_organization_code) {
                $return_to_branch['count'] += 1;
                $return_to_branch['amount'] += $row->total_amount+$row->other_charges_amount;
            }
        }

        $org = array();
        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        
        foreach($branches->data as $br){
            $org[$br->code] = $br->name;
        }
        
        $data['result'] = $list;

        $prebook = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ13T8637',
            'transitCode' => $this->input->get('transitCode'),
            'filterType' => 'LOAD'
        ));
        $prebook = json_decode($prebook);

        $list = array();
        foreach ($prebook->data as $row) {
            if ($route == '' || $route == "$row->from_station_name to $row->to_station_name") {
                $list[$row->from_station_name . ' to ' . $row->to_station_name][] = $row;
            }
        }
        $data['prebook'] = $list;
        $paymentWise =[];
        foreach ($payment_details as $key=>$val){
            if($key =='TOP' || $key =='TPPAD'){
                $paymentWise['keys'] =$key;
                $paymentWise['count'] += $val['count'];
                $paymentWise['amount'] +=$val['amount'];
                $paymentWise['paid_count'] += $val['paid_count'];
                $paymentWise['paid_amt'] +=$val['paid_amt'];
                $paymentWise['pend_count'] += $val['pend_count'];
                $paymentWise['pending_amt'] +=$val['pending_amt'];
                
            }
        }
        $data['paymentWise']=$paymentWise;
       

        // odometer details
        $result = $this->api_model->getTransitOdometerDetails(array(
            'transitCode' => $this->input->get('transitCode')
        ));
        $result = json_decode($result);

        $odometer = array();
        foreach ($result->data as $row) {
            $odometer[$row->transitCargo->cargoActivityType->code][$row->fromStation->name] = $row;
            $data['depAt'] = $row->departureAt;
        }
        $data['odoDetails'] = $odometer;
        
        $data['payment_details'] = $payment_details;
        $data['noreturn_branch'] =$noreturn_branch;
        $data['return_to_branch_lr'] = $return_to_branch;
        $data['cargo_status'] = config_item('cargo_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['username'] = $this->session->userdata('user_name');
        $data['branch'] = $org[$this->session->userdata('org_code')];
        $data['door_delivery_status'] =$door_delivery_status;

        if($this->session->userdata('namespace_id') == "seenutransports"){
            $this->load->view('site/cargo/out-for-delivery-chart-print-seenutransport', $data);
        } else {
            $this->load->view('site/cargo/out-for-delivery-chart-print-qr', $data);
        }
    }

    public function loaded_out_for_delivery_list() {
        $this->is_logged_in();

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ45G4144',
            'cargoTransitCode' => $this->input->post('transitCode'),
            'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
            'stationCode' => 'NA',
            'allowSameStation' => '0',
            'allowSameBranch' => '0',
            'filterType' => 'NA'
        ));
        $result = json_decode($result);

        $list = array();
        foreach ($result->data as $row) {
            if ($row->cargo_status_code == 'CL') {
                $list[$row->from_station_name . ' to ' . $row->to_station_name][] = $row;
            }
        }

        $data['result'] = $list;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/loaded-out-for-delivery-list', $data);
    }

    public function out_for_delivery_unload_lr() {
        $this->is_logged_in();

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ45G4144',
            'cargoTransitCode' => $this->input->get('transitCode'),
            'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
            'stationCode' => has_action_rights('CGO-VIEW-SAME-STION-LR') ? $this->session->userdata('org_station_code') : 'NA',
            'allowSameStation' => !has_action_rights('CGO-VIEW-ALL-LR') && has_action_rights('CGO-VIEW-SAME-STION-LR') ? '1' : '0',
            'allowSameBranch' => !has_action_rights('CGO-VIEW-ALL-LR') && has_action_rights('CGO-VIEW-SAME-BRNCH-LR') ? '1' : '0',
            'filterType' => 'UN_WI_PE'
        ));
        $result = json_decode($result);
        $transit = $this->input->get('transitType');

        $list = array();
        foreach ($result->data as $row) {
            if ($row->cargo_status_code == 'CL') {
                if (isNotNull($transit)) {
                    if ($row->transit_details_type != 'OFDLD') {
                        continue;
                    }
                }
                $list[$row->from_station_name . ' to ' . $row->to_station_name][] = $row;
            }
        }

        $data['result'] = $list;

        $prebook = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ13T8637',
            'transitCode' => $this->input->get('transitCode'),
            'filterType' => 'UNLOAD'
        ));
        $prebook = json_decode($prebook);

        $list = array();
        foreach ($prebook->data as $row) {
            if ($row->cargo_status_code == 'LOAD') {
                $list[$row->from_station_name . ' to ' . $row->to_station_name][] = $row;
            }
        }
        $data['prebook'] = $list;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;
        $data['transit_code'] = $this->input->get('transitCode');
        $data['vehicle_code'] = $this->input->get('vehicleCode');

        $data['userorgcode'] = $this->session->userdata('org_code');
        $outForDel = $this->api_model->cargoOGPLDetails(array(
            'transitCode' => $this->input->get('transitCode')
        ));
        $outForDel = json_decode($outForDel);
        $outForDel = $outForDel->data;
        $isFTLOFD = in_array('FULL-TRK-LOAD', $outForDel->activity);
        
        $odoDetails = $this->api_model->getTransitOdometer(array(
            'transitCode' => $this->input->get('transitCode')
        ));
        $odoDetails = json_decode($odoDetails);
        foreach ($odoDetails->data as $row) {
            if (($row->organization->code == $data['userorgcode']) || ($isFTLOFD && $row->organization->code == $outForDel->fromOrganization->code)) {
                $data['odoDetails'] = $row;
            }
        }

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        foreach ($vehicles->data as $row) {
            if ($row->code == $data['vehicle_code']) {
                $data['vehicle'] = $row;
            }
        }

        $branchContact = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $branchContact = json_decode($branchContact);
        $data['branchContact'] = $branchContact->data;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_prebook_status'] = config_item('cargo_prebook_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['cargo_setting'] = _get_cargo_settings();

        $this->load->view('site/cargo/out-for-delivery-unload-lr', $data);
    }

    public function out_for_delivery_update_unload() {
        $this->is_logged_in();

        $transitOrganization = $this->input->post('transitOrganization') ?: ['code' => ''];
        if ($transitOrganization['code']) {
            $type = 'HUB_UNLOAD';
        }

        echo $this->api_model->cargoOGPLStatusUpdate(array(
            'transitStatus' => array('code' => 'UNLOAD'),
            'transitCode' => $this->input->post('transitCode'),
            'transitOrganization' => $transitOrganization,
            'cargoList' => $this->input->post('codes') ?: [],
            'type' => $type
        ));
    }

    function ogpl_template() {
        $this->is_logged_in();

        $tpl = $this->api_model->getOGPLTemplate();
        $tpl = json_decode($tpl);
        $data['tpl'] = $tpl->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $this->load->view('site/cargo/ogpl-template', $data);
    }

    function update_ogpl_template() {
        $this->is_logged_in();

        echo $this->api_model->updateOGPLTemplate(array(
            'activeFlag' => $this->input->post('activeFlag'),
            'viaStations' => $this->input->post('viaStations') ?: [],
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation'),
            'code' => $this->input->post('code') ?: '',
            'name' => $this->input->post('name'),
            'arrivalMinutes' => (int) $this->input->post('arrivalMinutes'),
            'departureMinutes' => (int) $this->input->post('departureMinutes'),
        ));
    }

    function vehicle_revenue_report() {
        $this->is_logged_in();

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $drivers = $this->api_model->getVehicleDriver();
        $drivers = json_decode($drivers);
        $data['drivers'] = $drivers->data;

        $result = $this->api_model->cargoTags();
        $result = json_decode($result);
        $data['cargotags'] = $result->data;

        $this->load->view('site/cargo/vehicle-revenue-report', $data);
    }

    function vehicle_revenue_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQJ8MAC50',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'vehicleList' => $this->input->post('vehicleList') ?: 'NA',
            'driverList' => $this->input->post('driverList') ?: 'NA',
            'vehicleTags' => $this->input->post('vehicleTags') ?: 'NA',
            'driverTags' => $this->input->post('driverTags') ?: 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['result'] = $result->data;

        if ($this->input->post('export') == 1) {
            $filename = 'Vehicle-Revenue-Report';
            $this->load->excel('site/cargo/vehicle-revenue-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/vehicle-revenue-report-list', $data);
        }
    }

    function branch_stock_report() {
        $this->is_logged_in();

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $data['cargo_status'] = config_item('cargo_status');
        $data['branch_stock_status'] = config_item('branch_stock_status');

        $this->load->view('site/cargo/branch-stock-report', $data);
    }

    function branch_stock_report_list() {
        $this->is_logged_in();

        $organization = $this->input->post('transitOrganizationCode');
        if(in_array('NA', $organization)) {
            $organization = 'NA';
        } else {
            $organization = implode(',', $organization);
        }

        $stationCode = $this->input->post('stationCode');
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        if($fromDate=="NA"){
            $from_date = "NA";
            $to_date = "NA";
        }else{
            $from_date = date('Y-m-d', strtotime($fromDate));
            $to_date = date('Y-m-d', strtotime($toDate));
        } 
               
        $cargoStatusCode = $this->input->post('cargoStatusCode');

        if (!has_action_rights('BSR-ALL-BRNC')) {
            $organization = $this->session->userdata('org_code');
        }
        if (!has_action_rights('BSR-ALL-STION')) {
            $stationCode = $this->session->userdata('org_station_code');
        }

        

        $data = array(
            'queryCode' => 'RQJ8ODQ52',
            'fromDate' => $from_date,
            'toDate' => $to_date,
            'organizationCode' => $organization,
            'transitOrganizationCode' => 'NA',
            'cargoStatusCode' => $cargoStatusCode,
            'stationCode' => $stationCode,
            'filterType' => 'DETAILS',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $summary = array();
        if ($cargoStatusCode == 'CB' || $cargoStatusCode == 'CL' || $cargoStatusCode == 'CUL') {
            $groupby = 'transit_organization_name';
        } else {
            $groupby = 'from_organization_name';
        }  

        // Change GroupBy for "Cargo Missing" filter
        if($cargoStatusCode == "CMS" && $organization == 'NA') {
            $groupby = 'transit_organization_name';
        }

        $all_payment_status = [];
        $paytype_summary = [];
        foreach ($result->data as $row) {
            $all_payment_status[$row->payment_type_code]++;
            $summary[$row->{$groupby}][$row->payment_type_code]++;
            $summary[$row->{$groupby}]['total']++;

            $summary[$row->{$groupby}]['toOrganizationName'][$row->to_organization_name][$row->payment_type_code]++;
            $summary[$row->{$groupby}]['toOrganizationName'][$row->to_organization_name]['total']++;
            $paytype_summary[$row->payment_type_code] += $row->total_amount;
        }
        ksort($all_payment_status);
        ksort($paytype_summary);
        uasort($summary, function($a, $b) {
            return $a['total'] > $b['total'] ? -1 : 1;
        });

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['fromdate'] = $from_date;
        $data['to_date'] = $to_date;
        $data['result'] = $result->data;
        $data['summary'] = $summary;
        $data['all_payment_status'] = $all_payment_status;
        $data['paytype_summary'] = $paytype_summary;
        $data['operatorName'] = $this->session->userdata('namespace_name');
        $data['cargo_status_code'] = $cargoStatusCode;
        $data['summary_group_by'] = $groupby;
        $data['cargo_setting'] = _get_cargo_settings();

        if ($this->input->post('export') == 1) {
            $filename = 'branch-stock-report-list';
            $this->load->excel('site/cargo/branch-stock-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/branch-stock-report-list', $data);
        }
    }

    public function  branch_stock_report_godown_seenutransport(){

        $this->is_logged_in();
        $organization = $this->input->post('transitOrganizationCode');
        if(in_array('NA', $organization)) {
            $organization = 'NA';
        } else {
            $organization = implode(',', $organization);
        }

        $stationCode = $this->input->post('stationCode');
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        $cargoStatusCode = $this->input->post('cargoStatusCode');

        if (!has_action_rights('BSR-ALL-BRNC')) {
            $organization = $this->session->userdata('org_code');
        }
        
        if (!has_action_rights('BSR-ALL-STION')) {
            $stationCode = $this->session->userdata('org_station_code');
        }

        $data = array(
            'queryCode' => 'RQJ8ODQ52',
            'fromDate' => $from_date,
            'toDate' => $to_date,
            'organizationCode' => $organization,
            'transitOrganizationCode' => 'NA',
            'cargoStatusCode' => $cargoStatusCode,
            'stationCode' => $stationCode,
            'filterType' => 'DETAILS',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] =$result->data;
        $data['fromDate'] =$from_date;
        $data['toDate'] =$to_date;
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        if($this->input->post('print') == 1){
            $this->load->exclude_template();
            $this->load->view('site/report/branch-stock-report-godown-seenutransport', $data);
        }else if($this->input->post('export') == 1){
            $this->load->exclude_template();
            $filename = 'Godown Report';
            $this->load->excel('site/report/branch-stock-report-godown-seenutransport-xls', $data, $filename);
        }
        
    }
        
    function validate_ogpl_vehicle() {
        $this->is_logged_in();

        echo $this->api_model->OGPLLoadedByvehicle(array(
            'vehicleCode' => $this->input->post('vehicleCode'),
        ));
    }

    function find_lr() {
        $this->is_logged_in();

        echo $this->api_model->getCargoSummary(array('cargoCode' => $this->input->post('cargoCode')));

        }

     function rate_terms() {
        $this->is_logged_in();

        $branches = $this->api_model->getCargoOrganization();
        $branches = json_decode($branches);
        $branchesList = $branches = $branches->data;

        $fromBranches = array();
        $toBranches = array();
        foreach ($branches as $branch) {
            $fromBranches[$branch->code] = $branch->name;
            $toBranches[$branch->code] = $branch->name;
        }
        $branches = $this->api_model->getDeliveryBranches();
        $data['delivery_branches'] = getData($branches);
        asort($fromBranches);
        asort($toBranches);
        $data['branchRoutes'] = $branchesList;
        $data['fromBranches'] = $fromBranches;
        $data['toBranches'] = $toBranches;

        $rates = $this->api_model->getCargoRateTerms();
        $rates = json_decode($rates);
        $data['result'] = $rates->data;

        $this->load->view('site/cargo/rate-terms', $data);
    }

    public function update_rate_terms() {
        $this->is_logged_in();
        $data = array(
            'activeFlag' => $this->input->post('activeFlag'),
            'fromOrganization' => array('code' => $this->input->post('fromcode')),
            'toOrganization' => array('code' => $this->input->post('tocode')),
            'minimumWeight' => $this->input->post('minimumWeight'),
            'distance' => $this->input->post('distance'),
            'ratePerKg' => $this->input->post('ratePerKg'),
        );

        echo $this->api_model->updateCargoRateTerms($data);
    }


    public function cargo_rate_terms_route() {
        $this->is_logged_in();

        echo $this->api_model->cargoRateTermsRoute(array(
            'fromOrganizationCode' => $this->input->post('fromOrganizationCode'),
            'toOrganizationCode' => $this->input->post('toOrganizationCode'),
        ));
    }

    public function business_detailed_report() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code] = $branch->name;
        }
        asort($organization);
        $data['branches'] = $organization;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/business-detailed-report', $data);
    }

    public function business_detailed_report_list() {
        $this->is_logged_in();

        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
        $fromDate = date('Y-m-d', strtotime($fromDate));
        $toDate = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQK1DHD37',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'fromOrganizationCode' => $this->input->post('fromOrganizationCode'),
            'toOrganizationCode' => $this->input->post('toOrganizationCode'),
            'paymentStatusCode' => $this->input->post('payStatus'),
        );

        $p_key = _get_namespace_id().'_cargo_revenue_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['cargo_payment_status_badge'] = config_item('cargo_payment_status_badge');

        if ($this->input->post('export') == 1) {
            $model = $this->input->post('modelopt');
            $filename = 'Business-Detailed-Report-' . $data['fromDate'] . '-To-' . $data['toDate'];

            if ($model == 1) {
                $this->load->excel('site/cargo/business-detailed-report-list-xls', $data, $filename);
            } else if ($model == 2) {
                $this->load->excel('site/cargo/business-detailed-report-list-xls-2', $data, $filename);
            }
        }
        else {
            $this->load->view('site/cargo/business-detailed-report-list', $data);
        }
    }

    function import_bits_users() {
        $this->is_logged_in();

        $this->api_model->resetUserCache();

        echo $this->api_model->integrationUsers(array(
            'typeCode' => 'BITS'
        ));
    }

    private function process_user_commissions($allUserCommissions = []) {
        $userCommissions = [];

        $cargo_setting = _get_cargo_settings();

        foreach ($allUserCommissions as $row) {
            if (!$cargo_setting->captureStateWiseCommissionFlag && isNotNull($row->state_code)) {
                continue;
            }
            $userCommissions[$row->user_code]['BOOK']['PAD']['commission'] = $row->paid_commission;
            $userCommissions[$row->user_code]['BOOK']['TOP']['commission'] = $row->topay_commission;
            $userCommissions[$row->user_code]['BOOK']['INP']['commission'] = $row->accpay_commission;
            $userCommissions[$row->user_code]['TRANSIT']['PAD']['commission'] = $row->delivery_paid_commission;
            $userCommissions[$row->user_code]['TRANSIT']['TOP']['commission'] = $row->delivery_topay_commission;
            $userCommissions[$row->user_code]['TRANSIT']['INP']['commission'] = $row->delivery_accpay_commission;

            $userCommissions[$row->user_code]['BOOK']['PAD']['commission_type'] = $row->paid_commission_type;
            $userCommissions[$row->user_code]['BOOK']['TOP']['commission_type'] = $row->topay_commission_type;
            $userCommissions[$row->user_code]['BOOK']['INP']['commission_type'] = $row->accpay_commission_type;
            $userCommissions[$row->user_code]['TRANSIT']['PAD']['commission_type'] = $row->delivery_paid_commission_type;
            $userCommissions[$row->user_code]['TRANSIT']['TOP']['commission_type'] = $row->delivery_topay_commission_type;
            $userCommissions[$row->user_code]['TRANSIT']['INP']['commission_type'] = $row->delivery_accpay_commission_type;

            $userCommissions[$row->user_code]['loading_commission'] = $row->loading_commission;
            $userCommissions[$row->user_code]['unloading_commission'] = $row->unloading_commission;
            $userCommissions[$row->user_code]['doorpickup_commission'] = $row->door_pickup_commission;
            $userCommissions[$row->user_code]['doordelivery_commission'] = $row->door_delivery_commission;

            $userCommissions[$row->user_code]['loading_commission_type'] = $row->loading_commission_type;
            $userCommissions[$row->user_code]['unloading_commission_type'] = $row->unloading_commission_type;
            $userCommissions[$row->user_code]['doorpickup_commission_type'] = $row->door_pickup_commission_type;
            $userCommissions[$row->user_code]['doordelivery_commission_type'] = $row->door_delivery_commission_type;
        }

        return $userCommissions;
    }

    private function process_agent_collection($result, $collection_type, $userCommissions) {
        $data = array();
        $items = array();
        $summary = array();
        $userwise_summary = array();

        $cargo_payment_status = config_item('cargo_payment_status');
        foreach ($cargo_payment_status as $code => $name) {
            $summary[$collection_type][$code] = array(
                'lrcount' => 0,
                'itemcount' => 0,
                'fright' => 0,
                'loading' => 0,
                'doorpickup' => 0,
                'unloading' => 0,
                'user_unloading' => 0,
                'doordelivery' => 0,
                'user_doordelivery' => 0,
                'commission' => 0,
                'others' => 0,
                'gst' => 0,
                'fright_count' => 0,
                'loading_count' => 0,
                'doorpickup_count' => 0,
                'unloading_count' => 0,
                'doordelivery_count' => 0,
                'fright_commission' => 0,
                'loading_commission' => 0,
                'unloading_commission' => 0,
                'doorpickup_commission' => 0,
                'doordelivery_commission' => 0,
            );
        }
        $userCodeFilter = $this->input->post('userCode') ?: 'NA';
        if (!has_action_rights('AGTB-COLL-ALL-BRANCH')) {
            $userCodeFilter = _get_user_id();
        }

        foreach ($result->data as $row) {
            if ($userCodeFilter != 'NA') {
                if ($collection_type == 'BOOK' && isNotNull($row->user_code) && $row->user_code != $userCodeFilter) {
                    continue;
                } elseif ($collection_type == 'TRANSIT' && isNotNull($row->delivered_user_code) && $row->delivered_user_code != $userCodeFilter) {
                    continue;
                }
            }

            $row->net_payable = $row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->other_charges + $row->service_tax;
            $row->topay = ($row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->other_charges + $row->service_tax) - $row->transaction_amount;

            $paystatus_group = ($row->payment_status_code == 'TPPAD') ? 'TOP' : $row->payment_status_code;
            $userwise_group = ($collection_type == 'BOOK') ? $row->user_first_name : ($row->delivered_user_first_name ?: 'Others');

            $items[$collection_type][$paystatus_group][$userwise_group][] = $row;

            $usercode_group = ($collection_type == 'BOOK') ? $row->user_code : $row->delivered_user_code;
            $userwise_summary[$usercode_group][$paystatus_group]['lrcount'] += 1;
            $userwise_summary[$usercode_group][$paystatus_group]['itemcount'] += $row->total_item_count;
            $userwise_summary[$usercode_group][$paystatus_group]['fright'] += $row->total_amount;
            $userwise_summary[$usercode_group][$paystatus_group]['loading'] += $row->total_handling_amount;
            $userwise_summary[$usercode_group][$paystatus_group]['doorpickup'] += $row->pickup_handling_amount;

            $userwise_summary[$usercode_group][$paystatus_group]['unloading'] += $row->total_unload_handling_amount;
            $userwise_summary[$usercode_group][$paystatus_group]['user_unloading'] += $row->user_unload_handling_amount;
            $userwise_summary[$usercode_group][$paystatus_group]['doordelivery'] += $row->delivery_handling_amount;
            $userwise_summary[$usercode_group][$paystatus_group]['user_doordelivery'] += $row->user_delivery_handling_amount;
            $userwise_summary[$usercode_group][$paystatus_group]['commission'] += $row->commission_amount;
            $userwise_summary[$usercode_group][$paystatus_group]['others'] += $row->other_charges;
            $userwise_summary[$usercode_group][$paystatus_group]['gst'] += $row->service_tax;

            $userwise_summary[$usercode_group][$paystatus_group]['fright_count'] += ($row->total_amount > 0) ? 1 : 0;
            $userwise_summary[$usercode_group][$paystatus_group]['loading_count'] += ($row->total_handling_amount > 0) ? 1 : 0;
            $userwise_summary[$usercode_group][$paystatus_group]['doorpickup_count'] += ($row->pickup_handling_amount > 0) ? 1 : 0;
            $userwise_summary[$usercode_group][$paystatus_group]['unloading_count'] += ($row->total_unload_handling_amount > 0) ? 1 : 0;
            $userwise_summary[$usercode_group][$paystatus_group]['doordelivery_count'] += ($row->delivery_handling_amount > 0) ? 1 : 0;
        }

        foreach($userwise_summary as $userCode => $paystatus_summary) {
            foreach($paystatus_summary as $paystatus_group => $row) {
                $summary[$collection_type][$paystatus_group]['lrcount'] += $row['lrcount'];
                $summary[$collection_type][$paystatus_group]['itemcount'] += $row['itemcount'];
                $summary[$collection_type][$paystatus_group]['fright'] += $row['fright'];
                $summary[$collection_type][$paystatus_group]['loading'] += $row['loading'];
                $summary[$collection_type][$paystatus_group]['doorpickup'] += $row['doorpickup'];

                $summary[$collection_type][$paystatus_group]['unloading'] += $row['unloading'];
                $summary[$collection_type][$paystatus_group]['user_unloading'] += $row['user_unloading'];
                $summary[$collection_type][$paystatus_group]['doordelivery'] += $row['doordelivery'];
                $summary[$collection_type][$paystatus_group]['user_doordelivery'] += $row['user_doordelivery'];
                $summary[$collection_type][$paystatus_group]['commission'] += $row['commission'];
                $summary[$collection_type][$paystatus_group]['others'] += $row['others'];
                $summary[$collection_type][$paystatus_group]['gst'] += $row['gst'];

                $summary[$collection_type][$paystatus_group]['fright_count'] += $row['fright_count'];
                $summary[$collection_type][$paystatus_group]['loading_count'] += $row['loading_count'];
                $summary[$collection_type][$paystatus_group]['unloading_count'] += $row['unloading_count'];
                $summary[$collection_type][$paystatus_group]['doorpickup_count'] += $row['doorpickup_count'];
                $summary[$collection_type][$paystatus_group]['doordelivery_count'] += $row['doordelivery_count'];

                $summary[$collection_type][$paystatus_group]['fright_commission'] += calcUserCommission($userCommissions[$userCode][$collection_type][$paystatus_group]['commission_type'], $userCommissions[$userCode][$collection_type][$paystatus_group]['commission'], $row['fright'], $row['fright_count']);
                $summary[$collection_type][$paystatus_group]['loading_commission'] += calcUserCommission($userCommissions[$userCode]['loading_commission_type'], $userCommissions[$userCode]['loading_commission'], $row['loading'], $row['loading_count']);
                $summary[$collection_type][$paystatus_group]['unloading_commission'] += calcUserCommission($userCommissions[$userCode]['unloading_commission_type'], $userCommissions[$userCode]['unloading_commission'], $row['unloading'], $row['unloading_count']);
                $summary[$collection_type][$paystatus_group]['doorpickup_commission'] += calcUserCommission($userCommissions[$userCode]['doorpickup_commission_type'], $userCommissions[$userCode]['doorpickup_commission'], $row['doorpickup'], $row['doorpickup_count']);
                $summary[$collection_type][$paystatus_group]['doordelivery_commission'] += calcUserCommission($userCommissions[$userCode]['doordelivery_commission_type'], $userCommissions[$userCode]['doordelivery_commission'], $row['doordelivery'], $row['doordelivery_count']);
            }
        }

        $data['summary'] = $summary;

        if ($collection_type == 'BOOK') {
            $data['items']['BOOK']['PAD'] = $items['BOOK']['PAD'];
            $data['items']['BOOK']['TOP'] = $items['BOOK']['TOP'];
            $data['items']['BOOK']['INP'] = $items['BOOK']['INP'];
        } else if ($collection_type == 'TRANSIT') {
            $data['items']['TRANSIT']['PAD'] = $items['TRANSIT']['PAD'];
            $data['items']['TRANSIT']['TOP'] = $items['TRANSIT']['TOP'];
            $data['items']['TRANSIT']['INP'] = $items['TRANSIT']['INP'];
        }

        return $data;
    }

    function save_bits_user() {
        $this->is_logged_in();

        $group = $this->input->post('groupCode');
        $users = $this->input->post('usersList');

        foreach ($users as $user) {
            $res = $this->api_model->updateUser(array(
                'code' => '',
                'lastname' => $user['lastname'],
                'activeFlag' => $user['activeFlag'],
                'name' => $user['name'],
                'email' => $user['email'],
                'mobile' => $user['mobile'],
                'paymentType' => $user['paymentType'],
                'username' => $user['username'],
                'userTags' => $user['userTags'],
                'group' => array('code' => $group),
                'integrationType' => array('code' => 'BITS')
            ));
            $res = json_decode($res);

            if($res->status == 0) {
                $res->requestData = $user;
                exit(json_encode($res));
            }
        }

        echo json_encode(array('status' => 1));
    }

    function dashboard_branch_stock_list() {
        $this->is_logged_in();

        $organization = $this->input->post('transitOrganizationCode');
        $stationCode = $this->input->post('stationCode');
        $toDate = $this->input->post('toDate') ?: date('Y-m-d');
        $cargoStatusCode = $this->input->post('cargoStatusCode');

        $data = array(
            'queryCode' => 'RQJ8ODQ52',
            'fromDate' => 'NA',
            'toDate' => 'NA',
            'organizationCode' => 'NA',
            'transitOrganizationCode' => $organization,
            'cargoStatusCode' => $cargoStatusCode,
            'stationCode' => $stationCode,
            'filterType' => 'DETAILS',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $qty = 0;
        foreach ($result->data AS $row) {
            $qty += $row->item_count;
        }

        $data['organization_name'] = $this->input->post('transitOrganizationName');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['branch_stock_status'] = config_item('branch_stock_status');
        $data['result'] = $result->data;
        $data['cargo_status_code'] = $cargoStatusCode;
        $data['article_count'] = $qty;

        $this->load->view('site/cargo/dashboard-branch-stock-list', $data);
    }

    function dashboard_lr_list() {
        $this->is_logged_in();
        
        $result = $this->api_model->lrQuickFind(array(
            'code' => $this->input->post('code')
        ));
        $result = json_decode($result);

        if (count($result->data) == 1) {
            echo json_encode($result);
            return;
        }
        
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['branch_stock_status'] = config_item('branch_stock_status');
        $data['result'] = $result->data;

        $this->load->view('site/cargo/dashboard-lr-list', $data);
    }

        function cargo_settings() {
        $this->is_logged_in();

        $result = $this->api_model->getCargoSettings(array('authtoken' => _get_user_hash()));
        $result = json_decode($result);
        $data['result'] = $result->data ?: new stdClass;

        $paymentModel = $this->api_model->getGroupWisePaymentModel();
        $paymentModel = json_decode($paymentModel);

        $paymentModelGroups = array();
        foreach($paymentModel->data as $key=>$val) {
            array_push($paymentModelGroups, $val->group->code);
        }
        $data['paymentModelGroups'] = $paymentModelGroups;
        $data['paymentModel'] = $paymentModel->data;

        $GroupDetail = $this->api_model->getGroup(array(
            'authtoken' => $this->_user_hash,
            'activeFlag' => -1
        ));
        $GroupDetail = json_decode($GroupDetail);
        $data['groups'] = $GroupDetail->data;

        $data['user_accountable_type'] = config_item('user_accountable_type');
        $data['article_unit'] = config_item('article_unit');

        $this->load->view('site/cargo/cargo-settings', $data);

    }

    function update_cargo_settings() {
        $this->is_logged_in();

        $data = array(
            'serviceTaxPercentage' => $this->input->post('serviceTaxPercentage')?: 0,
            'billableKg' => $this->input->post('billableKg')?: 0,
            'loadingChargePerQuantity' => $this->input->post('loadingChargePerQuantity'),
            'minServiceTax' => $this->input->post('minServiceTax')?: 0,
            'defaultLoadigCharge' => $this->input->post('defaultLoadigCharge') ?: 0,
            'loadingChargePercentageFlag' => (bool) $this->input->post('loadingChargePercentageFlag'),
            'loadingChargeEditFlag' => (bool) $this->input->post('loadingChargeEditFlag'),
            'defaultDocketCharge' => $this->input->post('defaultDocketCharge') ?: 0,
            'docketChargePercentageFlag' => (bool) $this->input->post('docketChargePercentageFlag'),
            'docketChargeEditFlag' => (bool) $this->input->post('docketChargeEditFlag'),
            'userAccountableType' => array('code' => $this->input->post('userAccountableType')),
            'paymentReceiptAcknowledgeProcess' => $this->input->post('paymentReceiptAcknowledgeProcess') ?: 0,
            'showCustomerAddressFlag' => $this->input->post('showCustomerAddressFlag'),
            'mandateAddressOnBookingFlag' => $this->input->post('mandateAddressOnBookingFlag'),
            'defaultDeliveryCharge' => $this->input->post('defaultDeliveryCharge')?: 0,
            'mandateInvoiceAmountFlag' => $this->input->post('mandateInvoiceAmountFlag'),
            'otpValidateDeliveryFlag' => $this->input->post('otpValidateDeliveryFlag'),
            'otpOverrideDeliveryFlag' => $this->input->post('otpOverrideDeliveryFlag'),
            'podValidateDeliveryFlag' => $this->input->post('podValidateDeliveryFlag'),
            'bookingPreviewFlag' => $this->input->post('bookingPreviewFlag'),
            'cargoCodeTemplate' => trim($this->input->post('cargoCodeTemplate')),
            'vendorCargoCodeTemplate' => trim($this->input->post('vendorCargoCodeTemplate')),
            'vendorAliasCodeTemplate' => trim($this->input->post('vendorAliasCodeTemplate')),
            'invoiceCodeTemplate' => trim($this->input->post('invoiceCodeTemplate')),
            'manualCargoCodeTemplate' => trim($this->input->post('manualCargoCodeTemplate')),
            'ogclCodeTemplate' => trim($this->input->post('ogclCodeTemplate')),
            'itclCodeTemplate' => trim($this->input->post('itclCodeTemplate')),
            'ofdyCodeTemplate' => trim($this->input->post('ofdyCodeTemplate')),
            'transactionReceiptTemplate' => trim($this->input->post('transactionReceiptTemplate')),
            'chequeCodeTemplate' => trim($this->input->post('chequeCodeTemplate')),
            'deliveryAckCodeTemplate' => trim($this->input->post('deliveryAckCodeTemplate')),
            'ftlCodeTemplate' => trim($this->input->post('ftlCodeTemplate')),
            'ptlCodeTemplate' => trim($this->input->post('ptlCodeTemplate')),
            'podCharge' => $this->input->post('podCharge'),
            'deliveryModel' => $this->input->post('deliveryModel'),
            'userAccountModel' => $this->input->post('userAccountModel'),
            'racAccountModel' => $this->input->post('racAccountModel'),
            'paidPaymentModel' => $this->input->post('paidPaymentModel'),
            'topayPaymentModel' => $this->input->post('topayPaymentModel'),
            'onAccountPaymentModel' => $this->input->post('onAccountPaymentModel'),
            'creditLimitValidateFlag' => $this->input->post('creditLimitValidateFlag'),
            'captureStateWiseCommissionFlag' => $this->input->post('captureStateWiseCommissionFlag'),
            'transactionUserType' => $this->input->post('transactionUserType'),
            'demurrageTerms' => $this->input->post('demurrageTerms') ?: [],
            'unloadingChargeConfig' => $this->input->post('unloadingChargeConfig') ?: '',
            'loadingChargeRoundOffValue' => $this->input->post('loadingChargeRoundOffValue'),
            'totalFreightRoundOffValue' => $this->input->post('totalFreightRoundOffValue'),
            'deliveryRoundOffValue' => $this->input->post('deliveryRoundOffValue'),
            'lrGstTaxModel' => $this->input->post('lrGstTaxModel'),
            'lrGstTaxComputeType' => $this->input->post('lrGstTaxComputeType'),
            'ogplModelCode' => $this->input->post('ogplModelCode'),
            'transitLocationModelCode' => $this->input->post('transitLocationModelCode'),
            // 'mandateRouteWiseUnloadFlag' => $this->input->post('mandateRouteWiseUnloadFlag'),
            'allowNewArticle' => $this->input->post('allowNewArticle'),
            'transitOdometerModelCode' => $this->input->post('transitOdometerModelCode'),
            'stateWiseEwayBillIntegrationFlag' => $this->input->post('stateWiseEwayBillIntegrationFlag'),
            'organizationBookingControlFlag' => $this->input->post('organizationBookingControlFlag'),
            'minFreightAmount' => $this->input->post('minFreightAmount') ?: 0,
            'bookingModelTag' => $this->input->post('bookingModelTag') ?: [],
            'cargoUnitModel' => $this->input->post('cargoUnitModel') ?: [],
            'mobileNumberValidationRegex' => $this->input->post('mobileNumberValidationRegex') ?: 'NA',
            'bookingDateEditDaysLimit' => $this->input->post('bookingDateEditDaysLimit') ?: 0,
            'paidBookingUserModel' => $this->input->post('paidBookingUserModel'),
            'connectingChargeType' => $this->input->post('connectingChargeType'),
            'connectingChargeValue' => $this->input->post('connectingChargeValue') ?: 0,
            "transitMode" => implode("", $this->input->post('transitMode')),
            'cargoPartitionFlag' => $this->input->post('cargoPartitionFlag'),
            'gstTaxComputeModel' => $this->input->post('gstTaxComputeModel'),
            'activeFlag' => 1,
        );

       echo $this->api_model->updateCargoSettings($data);
    }

    function update_account_model() {
        $this->is_logged_in();

        $data = $this->input->post('accountModel') ?: [];
        echo $this->api_model->updateAccountModel($data);
    }

    public function recharge() {
        $this->is_logged_in();

        $voucher_usr = $this->api_model->getRechargeUsers();
        $voucher_usr = json_decode($voucher_usr);
        $usr = array();
        foreach ($voucher_usr->data AS $users) {
            $usr[$users->group->code]['groupname'] = $users->group->name;
            $usr[$users->group->code]['users'][] = array(
                'code' => $users->code,
                'name' => $users->name,
            );
        }

        // Transaction type
        $trans = $this->api_model->getTransType(array('authtoken' => $this->_user_hash));
        $transaction_type = json_decode($trans);

        // Transaction Mode
        $trans_mode = $this->api_model->getTransMode(array('authtoken' => $this->_user_hash));
        $transaction_mode = json_decode($trans_mode);

        /*
          $recharge_usr = $this->api_model->getRechargeUsers(array('authtoken' => $this->_user_hash));
         */

        $data['f_t_type'] = config_item('transaction_type');
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['f_a_status'] = config_item('acknowledge_status');

        $data['t_type'] = $transaction_type->data;
        $data['t_mode'] = $transaction_mode->data;
        $data['entity'] = $usr;
        $data['login_user_code'] = $this->session->userdata('user_id');

        $this->load->view('site/cargo/recharge', $data);
    }

    function get_recharge_list() {
        $this->is_logged_in();
//        $recharge = $this->api_model->getRechargeList(array(
//            'transactionTypeCode' => 'RECHG',
//            'userCode' => $this->input->post('user'),
//            'fromDate' => $this->input->post('from'),
//            'toDate' => $this->input->post('to')));
//        $rpt = json_decode($recharge);
//        $data['recharge'] = $rpt->data;
        $users = $this->input->post('gru_users');
        if(empty($users)) {
            $users = $this->session->userdata('user_id');
        }

        $data = array(
            'queryCode' => 'RQI9KAZ2',
            'transactionType' => 'RECHARGE',
            'acknowledgementStatus' => $this->input->post('acknowledgementStatus'),
            'userCode' => $users,
            'toDate' => $this->input->post('date_to'),
            'fromDate' => $this->input->post('date_from'),
            'vendorCode' => 'NA',
            'organizationCode' => 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['recharge'] = $result->data;
        $data['f_t_type'] = config_item('transaction_type');
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['f_a_status'] = config_item('acknowledge_status');

        $this->load->view('site/cargo/all-user-recharge-list', $data);
    }

    public function update_recharge() {
        $this->is_logged_in();
        $user_id = $this->session->userdata('user_id');
        $data = array(
            'transactionType' => array("code" => 'CGRECHG'),
            'activeFlag' => $this->input->post('activeFlag'),
            'amountReceivedDate' => $this->input->post('Rdate'),
            'paymentHandledBy' => array("code" => $user_id),
            'transactionAmount' => $this->input->post('amt'),
            'transactionMode' => array("code" => $this->input->post('t_mode')),
            'remarks' => $this->input->post('remark'),
            'user' => array("code" => $this->input->post('user')),
        );

        echo $this->api_model->cargoUpdateRecharge($data);
    }

    function export_ogpl_lr_list() {
        $this->is_logged_in();
        $dates = explode('|', $this->input->post('fromDate'));

        $data = array(
            'queryCode' => 'RQK68B759',
            'fromDate' => date('Y-m-d', strtotime($dates[0])),
            'toDate' => date('Y-m-d', strtotime($dates[1])),
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'stationCode ' => $this->input->post('stationCode') ?: 'NA',
        );
        // $this->session->userdata('org_code')
        // if (has_action_rights('OGPL-ALL-BRCH')) {
        //     $data['transitOrganizationCode'] = 'NA';
        // }

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['result'] = $result->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/export-ogpl-lr-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=OGPL LRs List.xls');
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
    }

    public function payment_receipt() {
        $this->is_logged_in();

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $alluser = $this->api_model->getUser(); // getRechargeUsers()
        $alluser = json_decode($alluser);
        $user = array();

        $allowed_paytypes = ['POT', 'ULTED'];
        foreach ($alluser->data AS $users) {
            if (!in_array($users->paymentType->code, $allowed_paytypes)) {
                continue;
            }
            $user[$users->paymentType->code][$users->group->code]['groupname'] = $users->group->name;
            $user[$users->paymentType->code][$users->group->code]['users'][] = array(
                'code' => $users->code,
                'name' => $users->name,
            );
        }
        $data['users'] = $user;

        // Transaction type
        $trans = $this->api_model->getTransType(array('authtoken' => $this->_user_hash));
        $transaction_type = json_decode($trans);

        // Transaction Mode
        $trans_mode = $this->api_model->getTransMode(array('authtoken' => $this->_user_hash));
        $transaction_mode = json_decode($trans_mode);

        $data['f_t_type'] = config_item('transaction_type');
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['f_a_status'] = config_item('acknowledge_status');
        $data['payment_receipt_type'] = config_item('payment_receipt_type');

        $data['t_type'] = $transaction_type->data;
        $data['t_mode'] = $transaction_mode->data;

        $vendors = $this->api_model->cargoCustomerVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;

        $this->load->view('site/cargo/payment-receipt', $data);
    }

    public function get_payment_receipt_revert(){
        $this->is_logged_in();

        echo $this->api_model->getPaymentReceiptRevert(array('receiptCode' => $this->input->post('receiptCode')));
    }

    public function revert_payment_receipt(){
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'remarks' => $this->input->post('remarks') ?: ''
        );

        echo $this->api_model->revertPaymentReceipt($data);
    }

    public function payment_receipt_report_list(){
        $this->is_logged_in();

        $data = array(
            'fromDate' => $this->input->post('from') ?: 'NA',
            'toDate' => $this->input->post('to') ?: 'NA',
            'userCode' => $this->input->post('userCode') ?: $this->session->userdata('user_id'),
            'paymentAcknowledgeStatus' => $this->input->post('paymentAcknowledgeStatus') ?: 'ACKED',
            'userRoleCode' => $this->input->post('userRoleCode'),
        );
        
        $result = $this->api_model->getPaymentReceipt($data);
        $result = json_decode($result);

        $data['result'] = $result->data;
        
        if($this->input->post('paymentAcknowledgeStatus') == 'INITD'){
            $data['paymentAcknowledgeStatus'] = 'RJECT';
            
            $reject = $this->api_model->getPaymentReceipt($data);
            $reject = json_decode($reject);
            $data['reject'] = $reject->data;
            
            $data['paymentAcknowledgeStatus'] = 'INITD';
        }
        
        
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['transactionMode'] = config_item('transaction_mode');
        $data['payment_receipt_type'] = config_item('payment_receipt_type');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/payment-receipt-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Branch-Due-Report.xls');
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
            $this->load->view('site/cargo/payment-receipt-list',$data);
        }
    }

    public function update_payment_receipt() {
        $this->is_logged_in();

        $data = array(
            'remarks' => $this->input->post('remarks'),
            'transactionDate' => date('Y-m-d'),
            'amountReceivedDate' => $this->input->post('amountReceivedDate'),
            'transactionAmount' => (float) $this->input->post('transactionAmount'),
            'transactionMode' => $this->input->post('transactionMode'),
            'user' => $this->input->post('user'),
            'paymentReceiptType' => $this->input->post('paymentReceiptType') ?: [],
            'paymentTransactions' => $this->input->post('paymentTransactions') ?: [],
            'paymentAcknowledgeStatus' => ['code' => 'ACKED']
        );

        $cargo_setting = _get_cargo_settings();
        if ($cargo_setting->paymentReceiptAcknowledgeProcess == 1) {
            $data['paymentAcknowledgeStatus'] = ['code' => 'INITD'];
        }

        $res = $this->api_model->updatePaymentReceipt($data);
        $res = json_decode($res);

        if ($res->status == 1) {
            $res->data->paymentAcknowledgeStatus = $data['paymentAcknowledgeStatus'];
        }

        echo json_encode($res);
    }

    public function update_payment_receipt_status() {
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'remarks' => $this->input->post('remarks'),
            'paymentAcknowledgeStatus' => $this->input->post('paymentAcknowledgeStatus')
        );

        echo $this->api_model->updatePaymentReceiptStatus($data);
    }

    public function business_revenue_detailed_report() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/business-revenue-detailed-report', $data);
    }

    public function business_revenue_detailed_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQK7H8461',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate'),
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'transitType' => $this->input->post('transitType')
        );

        $p_key = _get_namespace_id().'_business_revenue_detailed_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/business-revenue-detailed-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Business Revenue Detailed Report.xls');
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
        else {
            $this->load->view('site/cargo/business-revenue-detailed-report-list', $data);
        }
    }

    public function dispatch_efficiency_report() {
        $this->is_logged_in();
        $data = array();

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $this->load->view('site/cargo/dispatch-efficiency-report', $data);
    }

    public function dispatch_efficiency_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQK7LJ5662',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate'),
            'vehicleCode' => $this->input->post('vehicleCode')
        );

        $p_key = _get_namespace_id().'_dispatch_efficiency_report_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/dispatch-efficiency-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Dispatch Efficiency Report.xls');
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
        else {
            $this->load->view('site/cargo/dispatch-efficiency-report-list', $data);
        }
    }

    public function load_factor_report() {
        $this->is_logged_in();
        $data = array();

        $this->load->view('site/cargo/load-factor-report', $data);
    }

    public function load_factor_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQK7MJE63',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate')
        );

        $p_key = _get_namespace_id().'_load_factor_report_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/load-factor-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Load Factor Report.xls');
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
        else {
            $this->load->view('site/cargo/load-factor-report-list', $data);
        }
    }

    function cargo_remarks() {
        $this->is_logged_in();
        $data = array();

        $result = $this->api_model->getCargoRemarks();
        $result = json_decode($result);
        $data['remarks'] = $result->data;
        $data['cargo_remarks_status'] = config_item('cargo_remarks_status');

        $this->load->view('site/cargo/cargo-remarks', $data);

    }

    function update_cargo_remarks() {
        $this->is_logged_in();

        echo $this->api_model->updateCargoRemarks(array(
            'code' => $this->input->post('code'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'cargoStatus' => $this->input->post('cargoStatus'),
            'statusFlag' => (int) $this->input->post('statusFlag'),
        ));
    }

    function batch_update_cargo_remarks() {
        $this->is_logged_in();

        $remarksList = $this->input->post('remarks');

        foreach ($remarksList as $remarks) {
            $result = $this->api_model->updateCargoRemarks(array(
                'code' => $remarks['code'],
                'activeFlag' => (int) $remarks['activeFlag'],
                'name' => $remarks['name'],
                'cargoStatus' => $remarks['cargoStatus'] ?: [],
                'statusFlag' => (int) $remarks['statusFlag'],
            ));
            $result = json_decode($result);

            if ($result->status != 1) {
                echo json_encode($result);
                return;
            }
        }
    
        echo json_encode(array('status' => 1));
    }

    function send_delivery_otp() {
        $this->is_logged_in();

        echo $this->api_model->sendDeliveryOtp(array(
            'cargoCode' => $this->input->post('code'),
            'otpCustomerType' => $this->input->post('otpCustomerType'),
        ));
    }

    public function ogpl_unload() {
        $this->is_logged_in();

        if ($this->input->get('fill') == 1) {
            $data['ffromDate'] = $this->session->userdata('ogplul_search_from');
            $data['ftoDate'] = $this->session->userdata('ogplul_search_to');
            $data['fvehicle'] = $this->session->userdata('ogplul_vehicle');
            $data['faliasode'] = $this->session->userdata('ogplul_aliascode');
        }

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code] = $branch->name;
        }
        asort($organization);
        $data['branches'] = $organization;

        $this->load->view('site/cargo/ogpl-unload', $data);
    }

    public function ogpl_unload_list() {
        $this->is_logged_in();

        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));

        $fromDate = $fromDate ? date('Y-m-d', strtotime($fromDate)) : 'NA';
        $toDate = $toDate ? date('Y-m-d', strtotime($toDate)) : 'NA';

        $this->session->set_userdata('ogplul_search_from', $fromDate);
        $this->session->set_userdata('ogplul_search_to', $toDate);
        $this->session->set_userdata('ogplul_vehicle', $this->input->post('vehicleCode'));
        $this->session->set_userdata('ogplul_aliascode', $this->input->post('aliasCode'));


        $result = $this->api_model->cargoGetOGPLListv2(array(
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            //'transitStatus' => 'INIT',
            'vehicleCode' => trim($this->input->post('vehicleCode')),
            'transitCode' => 'NA',
            'aliasCode' => trim($this->input->post('aliasCode')),
            'organizationCode' => $this->input->post('organizationCode') ?: $this->session->userdata('org_code'),
            'activityType' => 'UNLOAD',
            'transitType' => 'TRNT'
        ));
        $result = json_decode($result);

        usort($result->data, function($a, $b) {
            return (strtotime(trim($a->audit->updatedAt)) < strtotime(trim($b->audit->updatedAt))) ? -1 : 1;
        });

        $data['result'] = $result->data;
        $data['org_station_code'] = $this->session->userdata('org_station_code');

        $data['cargo_setting'] = _get_cargo_settings();

        $this->load->view('site/cargo/ogpl-unload-list', $data);
    }

    public function local_transit_unload() {
        $this->is_logged_in();

        if ($this->input->get('fill') == 1) {
            $data['ffromDate'] = $this->session->userdata('itclul_search_from');
            $data['ftoDate'] = $this->session->userdata('itclul_search_to');
            $data['fvehicle'] = $this->session->userdata('itclul_vehicle');
            $data['faliasode'] = $this->session->userdata('itclul_aliascode');
        }

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code] = $branch->name;
        }
        asort($organization);
        $data['branches'] = $organization;

        $this->load->view('site/cargo/local-transit-unload', $data);
    }

    public function local_transit_unload_list() {
        $this->is_logged_in();

        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));

        $fromDate = $fromDate ? date('Y-m-d', strtotime($fromDate)) : 'NA';
        $toDate = $toDate ? date('Y-m-d', strtotime($toDate)) : 'NA';

        $this->session->set_userdata('itclul_search_from', $fromDate);
        $this->session->set_userdata('itclul_search_to', $toDate);
        $this->session->set_userdata('itclul_vehicle', $this->input->post('vehicleCode'));
        $this->session->set_userdata('itclul_aliascode', $this->input->post('aliasCode'));


        $result = $this->api_model->cargoGetOGPLListv2(array(
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            //'transitStatus' => 'INIT',
            'vehicleCode' => trim($this->input->post('vehicleCode')),
            'transitCode' => 'NA',
            'aliasCode' => trim($this->input->post('aliasCode')),
            'organizationCode' => $this->input->post('organizationCode') ?: $this->session->userdata('org_code'),
            'activityType' => 'UNLOAD',
            'transitType' => 'INTRNT'
        ));
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['cargo_setting'] = _get_cargo_settings();

        $this->load->view('site/cargo/local-transit-unload-list', $data);
    }

    function whatsapp_share() {
        $this->is_logged_in();

        $data = array();
        $data['lr'] = $this->input->get('lr');
        $data['type'] = $this->input->get('type');

        $summary = $this->api_model->getCargoSummary(array('cargoCode' => $data['lr']));
        $summary = json_decode($summary);
        $data['summary'] = $summary->data;

        $addons_mapped = array();
        foreach ($summary->data->cargoAddonsDetails as $row) {
            $addons_mapped[$row->addonsType->code] = $row;
        }
        $data['addons_mapped'] = $addons_mapped;

        $cargoItem = array();
        foreach ($summary->data->itemDetails as $article) {
            $cargoItem[] = "{$article->cargoItem->name} ({$article->itemCount})";
        }
        $data['cargoItem'] = $cargoItem;
        $data['pay_type'] = $this->config->item('cargo_payment_status');;
        $data['ns_domain_url'] = $this->session->userdata('ns_domain_url');

        $this->load->exclude_template();
        if ($data['type'] == 'BOOK') {
            $text = $this->load->view('site/cargo/whatsapp-sms-tpl', $data, true);
        }

        $param = array(
            'phone' => '+91' . ($summary->data->toCustomer->mobileNumber),
            'text' => $text
        );
        $whatsapp_url = config_item('whatsapp_send_url') . '?' . http_build_query($param);

        redirect($whatsapp_url);
    }

    function deliver_cargo() {
        $this->is_logged_in();

        $this->load->view('site/cargo/deliver-cargo');
    }

    function ogpl_deliver_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQJ8ODQ52',
            'toDate' => 'NA',
            'fromDate' => 'NA',
            'transitOrganizationCode' => $this->session->userdata('org_code'),
            'organizationCode' => 'NA',
            'cargoStatusCode' => 'CUL',
            'stationCode' => 'NA',
            'filterType' => 'DETAILS',
        );

        $p_key = _get_namespace_id().'_deliver_cargo_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/deliver-cargo-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Deliver Cargo Report.xls');
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
        else {
            $this->load->view('site/cargo/deliver-cargo-report-list', $data);
        }
    }

    public function pending_gc_dispatch_report() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code] = $branch->name;
        }
        asort($organization);
        $data['branches'] = $organization;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/pending-gc-dispatch-report', $data);
    }

    public function pending_gc_dispatch_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQK84C440',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate'),
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'organizationCode' => $this->input->post('organizationCode'),
            'cargoStatusCode' => 'CB'
        );

        if (!has_action_rights('PND-DISP-ALL-BRANCH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }
        
        $p_key = _get_namespace_id().'_pending_gc_dispatch_report_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);
        $data['result'] = $result->data;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);

        $branchesMapped = array();
        foreach ($branches->data as $row) {
            $branchesMapped[$row->code] = $row;
        }

        $summary = array();
        $summarizeGCDispach = function (&$summ, $row) {
            $summ['booked_count'] += 1;
            $summ['article_count'] += $row->item_count;
            $summ['freight'] +=  $row->total_amount;
            $summ['other_charges'] +=  $row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount;

            $summ['paid'] +=  $row->transaction_amount;
            if ($row->payment_status_code == 'INP' || $row->payment_status_code == 'OATP') {
                $summ['invoicepay'] +=  (($row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount) - $row->transaction_amount);                
            } else {
                $summ['topay'] += (($row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount) - $row->transaction_amount);
            }
        };

        foreach ($result->data as $row) {
            $branch = $row->transit_organization_name;
            $station = $branchesMapped[$row->transit_organization_code]->station->name;

            $summary[$station] = $summary[$station] ?: [];
            $summary[$station]['stationcode'] = $branchesMapped[$row->transit_organization_code]->station->code;
            $summarizeGCDispach($summary[$station], $row);

            $summary[$station]['branches'][$branch] = $summary[$station]['branches'][$branch] ?: [];
            $summarizeGCDispach($summary[$station]['branches'][$branch], $row);
        }
        $data['summary'] = $summary;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/pending-gc-dispatch-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Pending ' . lang('lr') . ' Dispatch Report.xls');
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
        else {
            $this->load->view('site/cargo/pending-gc-dispatch-report-list', $data);
        }
    }

    public function pending_gc_delivery_report() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code] = $branch->name;
        }
        asort($organization);
        $data['branches'] = $organization;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/pending-gc-delivery-report', $data);
    }

    public function pending_gc_delivery_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQK84C440',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate'),
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'organizationCode' => $this->input->post('organizationCode'),
            'cargoStatusCode' => 'CUL'
        );

        if (!has_action_rights('PND-DLVRY-ALL-BRANCH')) {
            $data['organizationCode'] = $this->session->userdata('org_code');
        }

        $p_key = _get_namespace_id().'_pending_gc_delivery_report_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);
        $data['result'] = $result->data;

        $summary = array();
        foreach ($result->data as $row) {
            $summary['booked_count'][$row->transit_organization_name] += 1;
        }
        $data['summary'] = $summary;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/pending-gc-delivery-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Pending ' . lang('lr') . ' Delivery Report.xls');
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
        else {
            $this->load->view('site/cargo/pending-gc-delivery-report-list', $data);
        }
    }

    public function transit_report() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code] = $branch->name;
        }
        asort($organization);
        $data['branches'] = $organization;

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['namespaceCode'] = $this->session->userdata('namespace_id');

        $this->load->view('site/cargo/ogpl-report', $data);
    }

    public function ogpl_report_list()
    {
        $this->is_logged_in();

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQO269561',
            'toDate' =>  $to_date,
            'fromDate' =>  $from_date,
            'fromStationCode' => $this->input->post('fromStation') ?: 'NA',
            'toStationCode' => $this->input->post('toStation') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'filterType' => $this->input->post('filterType') ?: 'ALL',
            'vehicleCode' => $this->input->post('vehicleCode') ?: 'NA',
            'transitType' => 'TRNT',
            'transitCode' => 'NA',
        );

        $p_key = _get_namespace_id() . '_ogpl_report' . md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if (!$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
      
        
        $routewise =array();
        $routewiseSummary = array();
    
        $result = json_decode($result);
        usort($result->data, function ($a, $b) {
            return $a->audit_updated_at < $b->audit_updated_at ? -1 : 1;
        });

   
        $data['result'] = $result->data;
        $routeWiseResult = $result->data;
        

        foreach($routeWiseResult as $dataum){
            $transitDetils = new stdClass();
            $transitDetils->transit_code = $dataum->transit_code;
            $transitDetils->alias_code  = $dataum->alias_code;
            $transitDetils->trip_date  = $dataum->trip_date;
            $transitDetils->route =($dataum->from_station_name. '-' .$dataum->to_station_name);
            $transitDetils->lr_count +=$dataum->cargo_count;
            if($dataum->start_odometer && $dataum->end_odometer){
                $transitDetils->km = abs($dataum->end_odometer- $dataum->start_odometer);  
                $transitDetils->odm = 0;
                $routewise[$dataum->registration_numer]['totalKm'] += $transitDetils->km;
            }else{
                $transitDetils->odm = abs($dataum->end_odometer- $dataum->start_odometer);
                $transitDetils->km = 0;
                $routewise[$dataum->registration_numer]['totalOdm'] += $transitDetils->odm;
            }
            $routewise[$dataum->registration_numer]['transitCode'][] = $transitDetils;
        }

        foreach($routewise as $key=>$value){
            foreach($routewise[$key]['transitCode'] as $keyTwo =>$route){
                $routewise[$key]['transitCode'][$keyTwo]->totalKm  = $routewise[$key]['totalKm'];
                $routewise[$key]['transitCode'][$keyTwo]->totalOdm = $routewise[$key]['totalOdm'];
            }
        }
       
        $data['routewise'] = $routewise;
        $organizationCode = $this->input->post('organizationCode');
        if($organizationCode){
        $organizationDetails = $this->api_model->getOrganizationDetails(array('organizationcode' =>$organizationCode));
        $organizationDetails = json_decode($organizationDetails);
        $data['organizationDetails']  = $organizationDetails->data;
        }

        if (($this->input->post('filterType') == "UNLOAD" || $this->input->post('filterType') == "LOAD") && ($this->input->post('print') == 1 || $this->input->post('export') == 1)) {
            $unloadComplaintLr = array();
            foreach ($result->data as $val) {
                $complaintLr = $this->api_model->getDynamicReportDataWithMap(array(
                    'queryCode' => 'RQJ45G4144',
                    'cargoTransitCode' => $val->transit_code,
                    'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
                    'stationCode' => 'NA',
                    'allowSameStation' => '0',
                    'allowSameBranch' =>'0',
                    'filterType' => $this->input->post('filterType') ?: 'ALL'
                ));
                $complaintLr = json_decode($complaintLr);
                
                foreach ($complaintLr->data as $lr) {
                    if ($lr->unloading_remarks != "NA" && $lr->unloading_remarks != "") {
                        $lr->vechileNumber = $val->registration_numer;
                        $lr->arrival_at = $val->arrival_at;
                        $values = explode(',',$lr->item_details);
                        $lr->cargo_item_name =$values[1];
                        $unloadComplaintLr[] = $lr;
                    }
                }
            }

            usort($unloadComplaintLr, function ($a, $b) {
                return (strtotime(trim($a->booked_at)) < strtotime(trim($b->booked_at))) ? -1 : 1;
            });
            $data['unload_complaint_lr'] = $unloadComplaintLr;
        }

        $data['toDate'] = $to_date;
        $data['fromDate'] = $fromDate;
        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');

        if ($this->input->post('export') == 1) {
            $filename = lang('ogpl') . 'Report';
            $this->load->excel('site/cargo/ogpl-report-list-xls', $data, $filename);
        } elseif ($this->input->post('print') == 1) {
            $this->load->exclude_template();
            $data['organizationName'] = $this->input->post('organizationName');
            $this->load->view('site/cargo/ogpl-report-print-seenutransports', $data);
        } else {
            $this->load->view('site/cargo/ogpl-report-list', $data);
        }
    }

    public function ogpl_report_list_tally(){
        $this->is_logged_in();

        $this->load->library('excel');
        $this->excel->getProperties()->setCreator("Ezee")
                                    ->setLastModifiedBy("Ezee")
                                    ->setTitle("Ogpl List")
                                    ->setSubject("Ogpl List")
                                    ->setDescription("Ogpl List.")
                                    ->setKeywords("Ogpl List")
                                    ->setCategory("Tally");

        $this->excel->setActiveSheetIndex(0);
        $this->excel->getActiveSheet()->setTitle('Ogpl');

        $this->excel->getActiveSheet()->getStyle('A1:Z1')->getFont()->setBold(true);
        $this->excel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('B')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('C')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('D')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('E')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('F')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('G')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('H')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('I')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('J')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('K')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('L')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('M')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('N')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('O')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('P')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('Q')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('R')->setAutoSize(true);
        $this->excel->getActiveSheet()->getColumnDimension('S')->setAutoSize(true);

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
        if ($this->input->post('export') == 1) {
            $from_date = date('Y-m-d', strtotime($fromDate));
            $to_date = date('Y-m-d', strtotime($toDate));
        }

        $data = array(
            'queryCode' => 'RQK37I5338',
            'toDate' => $to_date,
            'fromDate' => $from_date,
            'fromStationCode' => $this->input->post('fromStation') ?: 'NA',
            'toStationCode' => $this->input->post('toStation') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'filterType' =>'TALLY_REPORT',
            'vehicleCode' => $this->input->post('vehicleCode') ?: 'NA',
            'transitType' => 'TRNT'
        );
     
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
    
        $this->excel->getActiveSheet()->setCellValue('A1', 'YYYYMMDD');
        $this->excel->getActiveSheet()->setCellValue('B1', 'DATE');
        $this->excel->getActiveSheet()->setCellValue('C1', 'FROMSECT');
        $this->excel->getActiveSheet()->setCellValue('D1', 'FSECTID');
        $this->excel->getActiveSheet()->setCellValue('E1', 'TOSECT');
        $this->excel->getActiveSheet()->setCellValue('F1', 'TESCTID');
        $this->excel->getActiveSheet()->setCellValue('G1', 'OGPLNUM');
        $this->excel->getActiveSheet()->setCellValue('H1', 'TAG');
        $this->excel->getActiveSheet()->setCellValue('I1', 'TOBRANCH');
        $this->excel->getActiveSheet()->setCellValue('J1', 'BOOKEDBY');
        $this->excel->getActiveSheet()->setCellValue('K1', 'QUANTITY');
        $this->excel->getActiveSheet()->setCellValue('L1', 'FREIGHT');
        $this->excel->getActiveSheet()->setCellValue('M1', 'PAID');
        $this->excel->getActiveSheet()->setCellValue('N1', 'TOPAY');
        $this->excel->getActiveSheet()->setCellValue('O1', 'LOAD');
        $this->excel->getActiveSheet()->setCellValue('P1', 'CONAMT');
        $this->excel->getActiveSheet()->setCellValue('Q1', 'CONBRID');
        $this->excel->getActiveSheet()->setCellValue('R1', 'SERTAX');
        $this->excel->getActiveSheet()->setCellValue('S1', 'OTCHR');

        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);

                $row = 2;
                $col = 0;
                $cargo_payment_status = config_item('cargo_payment_status');

                for ($i = 0; $i < $ticket_count; $i++) {

                    $t = $result->data[$i];
                    $con_id="0";

                    if($t->connecting_charge > 0){
                        $con_id = "1";
                    } else {
                        $con_id = "0";
                    }

                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col, $row, date('Ymd', strtotime($t->trip_date)));
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, date('d-m-Y', strtotime($t->trip_date)));
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->from_organization_name);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->from_organization_short_code);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->transit_to_organization_name);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->transit_to_organization_short_code);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->alias_code);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->registration_numer);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->to_organization_name);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->booked_user_first_name);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->total_item_count);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->total_amount);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->paid_amount);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->topay_amount);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->total_handling_amount);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->connecting_charge);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $con_id);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->service_tax);
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow(++$col, $row, $t->other_charges);
                    
                    $col = 0;
                    $row++;
                }
            }
        }

        $filename = 'Ogpl Report-'.$from_date.' TO '.$to_date.'.xls';
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="'.$filename.'"');
        header('Cache-Control: max-age=0');
        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
        $objWriter->save('php://output');
    }

    public function ogpl_report_lr_list() {
        $this->is_logged_in();

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ45G4144',
            'cargoTransitCode' => $this->input->post('transitCode'),
            'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
            'stationCode' => 'NA',
            'allowSameStation' =>'0',
            'allowSameBranch' =>'0',
            'filterType' =>$this->input->post('filterType')
        ));
        
        $result = json_decode($result);

        usort($result->data, function($a, $b) {
            return (strtotime(trim($a->booked_at)) < strtotime(trim($b->booked_at))) ? -1 : 1;
        });

        $data['result'] = $result->data;

        $this->load->view('site/cargo/ogpl-report-lr-list', $data);
    }
    
    public function itcl_report() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code] = $branch->name;
        }
        asort($organization);
        $data['branches'] = $organization;

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/itcl-report', $data);
    }

    public function itcl_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQK37I5338',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate'),
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'organizationCode' => $this->input->post('organizationCode'),
            'filterType' => $this->input->post('filterType') ?: 'ALL',
            'vehicleCode' => $this->input->post('vehicleCode') ?: 'NA',
            'transitType' => 'INTRNT'
        );

        $p_key = _get_namespace_id().'_ogpl_report_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/itcl-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=' . lang('ogpl_local_transit') . ' Report.xls');
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
        else {
            $this->load->view('site/cargo/itcl-report-list', $data);
        }
    }
    
    function transit_history() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQK8C9C63',
            'transitCode' => $this->input->post('transitCode')
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['transactions'] = $result->data;
        
        $data['filterType'] = $this->input->post('filterType');
        
        $data['transitCode'] = $this->input->post('aliasCode');
        $this->load->view('site/cargo/transit-history', $data);
    }

    function scan_qr_code() {
        $this->is_logged_in();
        
        $this->load->view('site/cargo/scan-qr-code');
    }

    function save_image_details() {
        $this->is_logged_in();
        
        echo $this->api_model->saveImageDetails(array(
            'referenceCode' => $this->input->post('referenceCode'),
            'imageCategoryCode' => $this->input->post('imageCategoryCode'),
            'imageDetails' => $this->input->post('imageDetails') ?: []
        ));
    }

    function get_image_details() {
        $this->is_logged_in();
        
        echo $this->api_model->getImageDetails(array(
            'referenceCode' => $this->input->post('referenceCode'),
            'imageCategoryCode' => $this->input->post('imageCategoryCode')
        ));
    }

    function get_lr_related_ogpl() {
        $this->is_logged_in();

        $result = $this->api_model->getLrRelatedOGPL(array(
            'cargoCode' => $this->input->post('cargoCode'),
            'tripDate' => date('Y-m-d')
        ));
        $result = json_decode($result);
        $data['result'] = $result->data;
        
        $tpl = $this->api_model->getOGPLTemplate();
        $tpl = json_decode($tpl);
        $data['ogpltpl'] = $tpl->data;

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $drivers = $this->api_model->getVehicleDriver();
        $drivers = json_decode($drivers);
        $data['drivers'] = $drivers->data;
        
        $this->load->view('site/cargo/get-lr-related-ogpl', $data);
    }
    
    function branch_revenue_report() {
        $this->is_logged_in();

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;       

        $this->load->view('site/cargo/branch-revenue-report', $data);
    }

    function branch_revenue_report_list() {
        $this->is_logged_in();
        
        $fdate = $this->input->post('fromDate');
        $tdate = $this->input->post('toDate');
        if ($this->input->post('export') == 1) {
            $fdate = date('Y-m-d', strtotime($fdate));
            $tdate = date('Y-m-d', strtotime($tdate));
        }
        
        $data = array(
            'queryCode' => 'RQK9JG441',
            'fromDate' => $fdate,
            'toDate' => $tdate,
            'organizationCode' => $this->input->post('organizationCode')?: 'NA',
            'pcrFilterType' => $this->input->post('pcrFilterType'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['cargo_status'] = config_item('cargo_status');  
        $data['cargo_payment_status'] = config_item('cargo_payment_status'); 
        
        if($this->input->post('view') == 'details'){
            $this->load->view('site/cargo/branch-revenue-report-details-list', $data);
        }else if ($this->input->post('export') == 1){
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/branch-revenue-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Branch Revenue Report.xls');
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($content));
            ob_clean();
            flush();
            echo $content;
            die;            
        }else{
            $this->load->view('site/cargo/branch-revenue-report-list', $data);
        }
        
        
    }
	
    public function cargo_life_cycle_report() {
        $this->is_logged_in();
        $data = array();

        $this->load->view('site/cargo/cargo-life-cycle-report', $data);
    }

    public function cargo_life_cycle_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQK9SJ5642',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate')
        );

        $p_key = _get_namespace_id().'_cargo_life_cycle_report_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/cargo-life-cycle-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Cargo Life Cycle Report.xls');
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
        else {
            $this->load->view('site/cargo/cargo-life-cycle-report-list', $data);
        }
    }

    function get_station_customers() {
        $this->is_logged_in();

        echo $this->api_model->getStationCustomers(array(
            'stationCode' => $this->input->post('stationCode')
        ));
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
                    $redis->hMset($key, ['' => '']);
                    $redis->expire($key, 60); // 1 minute

                    $customers = $this->api_model->getStationCustomersV3(['stationCode' => $station]);
                    $customers = json_decode($customers);
                    if ($customers->status != 1) {
                        continue;
                    }

                    $hashKeys = [];
                    foreach ($customers->data as $customer) {
                        $k = strtoupper("{$customer->m}:{$customer->n}:{$customer->g}");
                        $hashKeys[$k] = json_encode($customer);
                    }
                    $redis->del($key);
                    $redis->hMset($key, $hashKeys);
                    $redis->expire($key, 259200); // 3 days
                }

                $it = NULL;
                do {
                    $hashes = $redis->hscan($key, $it, "*{$mobQuery}*", 250);

                    if (count($response) > 2500) {
                        break;
                    }

                    if ($hashes !== FALSE) {
                        foreach ($hashes as $json) {
                            $customer = json_decode($json);
                            $response[$customer->m] = array(
                                'code' => $customer->c,
                                'name' => $customer->n,
                                'mobileNumber' => $customer->m,
                                'gstin' => $customer->g,
                                'role' => $customer->rc,
                                'companyName' => $customer->cn,
                                'email' => $customer->em
                            );
                        }
                    }
                } while ($it > 0);
            }

            echo json_encode(['status' => 1, 'data' => array_values($response)]);
        } catch (\Throwable $th) {
            echo json_encode(['status' => 0, 'errorDesc' => $th->getMessage()]);
        }
    }

    function resend_cargo_sms() {
        $this->is_logged_in();

        echo $this->api_model->resendCargoSMS(array(
            'cargoCode' => $this->input->post('cargoCode')
        ));
    }

    function get_prebooking_by_code() {
        $this->is_logged_in();

        $stationCode = 'NA';
        if (!has_action_rights('CARGO-ONBEHALF-BOOKING')) {
            $stationCode = $this->session->userdata('org_station_code');
        }

        echo $this->api_model->getUnbookedPrebooking(array(
            'referenceNumber' => $this->input->post('preBookCode'),
            'stationCode' => $stationCode
        ));
    }

    function get_prebooking_by_mobile() {
        $this->is_logged_in();

        $stationCode = 'NA';
        if (!has_action_rights('CARGO-ONBEHALF-BOOKING')) {
            $stationCode = $this->session->userdata('org_station_code');
        }

        $prebookings = $this->api_model->getUnbookedPrebooking(array(
            'referenceNumber' => $this->input->post('customerMobile'),
            'stationCode' => $stationCode
        ));
        $prebookings = json_decode($prebookings);
        $data['prebookings'] = $prebookings->data;

        $this->load->view('site/cargo/prebookings-list', $data);
    }

    function prebooking_request() {
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $data['prebook_status'] = config_item('prebook_status');

        $this->load->view('site/cargo/prebooking-request', $data);
    }
    
    function prebooking_request_list() {
        $this->is_logged_in();
        
        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
        $fromDate = $fromDate ? date('Y-m-d', strtotime($fromDate)) : 'NA';
        $toDate = $toDate ? date('Y-m-d', strtotime($toDate)) : 'NA';

        $param = array(
            'queryCode' => 'RQK46G74I7',
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'fromStationCode' => $this->input->post('fromStationCode') ?: 'NA',
            'toStationCode' => $this->input->post('toStationCode') ?: 'NA',
            'preBookStatus' => $this->input->post('preBookStatus') ?: 'NA',
            'customerMobile' => 'NA'
        );

        $result = $this->api_model->getDynamicReportDataWithMap($param);
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['prebook_status'] = config_item('prebook_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/prebooking-request-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=prebooking-request-list.xls');
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
            $this->load->view('site/cargo/prebooking-request-list', $data);
        }
    }
    
    function update_prebooking_status() {
        $this->is_logged_in();
        
        $data = array(
            'preBookCode' => $this->input->post('preBookCode'),
            'statusCode' => $this->input->post('statusCode')
        );

        echo $this->api_model->updatePreBookingStatus($data);
    }

    function delete_prebooking_Request() {
        $this->is_logged_in();

        echo $this->api_model->deletePrebookingRequest(array(
            'code' => $this->input->post('code')
        ));
    }

    function update_return_booking() {
        $this->is_logged_in();

        echo $this->api_model->updateReturnBooking(array(
            'cargoCode' => $this->input->post('cargoCode'),
            'toOrganization' => $this->input->post('toOrganization'),
            'remarks' => $this->input->post('remarks') ?: [],
            'additionalAttribute' => $this->input->post('additionalAttribute') ?: new stdClass,
        ));
    }
    
    public function ogpl_loading_sheet() {
        $this->is_logged_in();

        $data = array();

        $transitCode = $this->input->get('transitCode');
        if ($transitCode) {
            $ogpl = $this->api_model->cargoOGPLDetails(array(
                'transitCode' => $transitCode
            ));
            $ogpl = json_decode($ogpl);
            $data['ogpl'] = $ogpl->data;
        }

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $drivers = $this->api_model->getVehicleDriver();
        $drivers = json_decode($drivers);
        $data['drivers'] = $drivers->data;

        $tpl = $this->api_model->getOGPLTemplate();
        $tpl = json_decode($tpl);
        $data['ogpltpl'] = $tpl->data;

        $data['namespaceCode'] = $this->session->userdata('namespace_id');

        $this->load->view('site/cargo/loading-sheet', $data);
    }

    public function ogpl_remove_lr() {
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'name' => $this->input->post('name'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'cargoStatusCode' => $this->input->post('cargoStatusCode'),
            'cargoCode' => $this->input->post('cargoCode'),
            'transitDetailsCode' => $this->input->post('transitDetailsCode'),
        );

        echo $this->api_model->ogplRemoveLR($data);
    }

    public function update_remarks() {
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'name' => $this->input->post('name'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'cargoStatusCode' => $this->input->post('cargoStatusCode'),
            'cargoCode' => $this->input->post('cargoCode')
        );

        echo $this->api_model->updateRemarks($data);
    }
    
    public function permission_report() {
        $this->is_logged_in();

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code] = $branch->name;
        }
        asort($organization);
        $data['branches'] = $organization;

        $this->load->view('site/cargo/permission-report', $data);
    }

    function permission_report_list() {
        $this->is_logged_in();

        $orgCode = $this->input->post('organizationCode');

        // all users
        $allusers = $this->api_model->getUser();
        $allusers = json_decode($allusers);

        $usercodes = [];
        foreach ($allusers->data as $row) {
            if ($orgCode == 'NA' || $orgCode == $row->organization->code) {
                $usercodes[$row->code] = $row;
            }
        }

        // permission report
        $usrmenus = $this->api_model->getUserMenuReport(array(
            'userCodes' => implode(',', array_keys($usercodes))
        ));
        $usrmenus = json_decode($usrmenus);
        $usrmenus = $usrmenus->data;

        // all ns permission
        $nsmenu = $this->api_model->getRolePermission(
            array('roleCode' => 'NS'),
            array('user' => ['code' => ''])
        );
        $nsmenu = json_decode($nsmenu);

        usort($nsmenu->data, function($a, $b) {
            return $a->name < $b->name ? -1 : 1;
        });

        $menumapped = [];
        foreach ($nsmenu->data as $mn) {
            $mn->userCodes = [];
            $menumapped[$mn->code] = $mn;

            $eventmapped = [];
            foreach ($mn->eventList as $ev) {
                $ev->userCodes = [];
                $eventmapped[$ev->code] = $ev;
            }
            $mn->eventList = $eventmapped;
        }

        $usersList = [];
        foreach ($usrmenus as $mn) {
            $menu = $menumapped[$mn->menu_code];
            $menu->userCodes[$mn->user_code] = 1;
            $usersList[$mn->user_code] = $usercodes[$mn->user_code];

            $events = explode(',', $mn->menu_events);
            foreach ($events as $event) {
                $menu->eventList[$event]->userCodes[$mn->user_code] = 1;
            }
        }
        
        usort($usersList, function($a, $b) {
            return $a->name < $b->name ? -1 : 1;
        });

        $parentmenu = array();
        $childmenu = array();
        foreach ($menumapped as $mn) {
            if (!isset($mn->lookup->code)) {
                $parentmenu[$mn->code] = $mn;
            } else {
                $childmenu[$mn->lookup->code][] = $mn;
            }
        }

        $data['parentmenu'] = $parentmenu;
        $data['childmenu'] = $childmenu;
        $data['orgusers'] = $usersList;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/permission-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Permission-Report.xls');
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
            $this->load->view('site/cargo/permission-report-list', $data);
        }
    }
    
    function cargo_edit_report() {
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;
        $data['cargo_edit_events'] = config_item('cargo_edit_events');

        $this->load->view('site/cargo/cargo-edit-report', $data);
    }

    function cargo_edit_report_list() {
        $this->is_logged_in();

        $param = array(
            'queryCode' => 'RQL93LS46',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'eventCode' => $this->input->post('eventCode') ?: 'NA'
        );

        $result = $this->api_model->getDynamicReportDataWithMap($param);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['cargo_status'] = config_item('cargo_status');

        if ($this->input->post('export') == 1) {
            $filename = 'Cargo Edit Report';
            $this->load->excel('site/cargo/cargo-edit-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/cargo-edit-report-list', $data);
        }
    }

    function edit_paytype_lr() {
        $this->is_logged_in();

        echo $this->api_model->cargoPaymentTypeUpdate(array(
            'code' => $this->input->post('code'),
            'paymentType' => $this->input->post('paymentType') ?: ['code' => ''],
            'vendorUser' => $this->input->post('vendorUser') ?: ['code' => ''],
        ));
    }

    function edit_paymode_lr() {
        $this->is_logged_in();
        $cargoCode =$this->input->post('cargoCode');
        $transactionMode = $this->input->post('transactionMode');
        $param = array(
            'code' => $this->input->post('code'),
            'user' => $this->input->post('user') ?: ['code' => ''],
            'transactionMode' => $this->input->post('transactionMode') ?: ['code' => ''],
        );
        if($transactionMode["code"] == "NBK" || $transactionMode["code"] == "UPI") {
            $param['bankDetails'] = $this->input->post('bankDetails');
            $param['additionalAttribute'] =$this->input->post('additionalAttribute');
        }
        echo $this->api_model->cargoPaymentModeUpdate($param,$cargoCode);
    }
    
    public function godown_report() {
        $this->is_logged_in();
        $data = array();

        $this->load->view('site/cargo/godown-report', $data);
    }

    public function godown_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQL9OK5147',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate'),
        );

        $p_key = _get_namespace_id().'_godown_report_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/godown-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Godown Report.xls');
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
        else {
            $this->load->view('site/cargo/godown-report-list', $data);
        }
    }
    
    public function onbehalf_report() {
        $this->is_logged_in();
        $data = array();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $organization = array();
        foreach ($branches as $branch) {
            $organization[$branch->code] = $branch->name;
        }
        asort($organization);
        $data['branches'] = $organization;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/onbehalf-report', $data);
    }

    public function onbehalf_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQL9OM90267',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate'),
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'fromOrganizationCode' => $this->input->post('fromOrganizationCode'),
            'toOrganizationCode' => $this->input->post('toOrganizationCode'),
            'filterType' => $this->input->post('filterType')
        );

        $p_key = _get_namespace_id().'_onbehalf_report_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/onbehalf-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Onbehalf Report.xls');
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
        else {
            $this->load->view('site/cargo/onbehalf-report-list', $data);
        }
    }
    
    function collection_reportv2() {
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $data['users'] = $users->data;

        $this->load->view('site/cargo/collection-reportv2', $data);
    }

    function collection_report_listv2() {
        $this->is_logged_in();

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
            $from_date = date('Y-m-d', strtotime($fromDate));
            $to_date = date('Y-m-d', strtotime($toDate));

        $data = array(
            'queryCode' => 'RQL2UFK837',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'organizationCode' => $this->input->post('organizationCode'),
            'userCode' => $this->input->post('userCode'),
            'filterType' => $this->input->post('filterType'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        if ($this->input->post('filterType') == 'SUMMARY') {
            $branch = [];
            $paytypesummary = [];
            foreach ($result->data as $row) {
                $org = $row->payment_organization_code;
                $branch[$org]['payment_organization_code'] = $row->payment_organization_code; 
                $branch[$org]['payment_organization_name'] = $row->payment_organization_name;

                $branch[$org]['paytypewise'][$row->payment_status_code]['transaction_amount'] += $row->transaction_amount;

                $branch[$org]['transaction_amount'] += $row->transaction_amount;
                $branch[$org]['commission_amount'] += $row->commission_amount;
                $branch[$org]['handling_commission_amount'] += $row->handling_commission_amount;
                $branch[$org]['connecting_charge'] += $row->connecting_charge;
                
                $usr = $row->payment_user_code;
                $branch[$org]['userwise'][$usr]['payment_user_code'] = $row->payment_user_code;
                $branch[$org]['userwise'][$usr]['payment_user_first_name'] = $row->payment_user_first_name;

                $branch[$org]['userwise'][$usr]['paytypewise'][$row->payment_status_code]['transaction_amount'] += $row->transaction_amount;

                $branch[$org]['userwise'][$usr]['transaction_amount'] += $row->transaction_amount;
                $branch[$org]['userwise'][$usr]['commission_amount'] += $row->commission_amount;
                $branch[$org]['userwise'][$usr]['handling_commission_amount'] += $row->handling_commission_amount;
                $branch[$org]['userwise'][$usr]['connecting_charge'] += $row->connecting_charge;
                $branch[$org]['userwise'][$usr]['userwise'][] = $row;

                $paytypesummary[$row->payment_status_code] += $row->transaction_amount;
            }
            ksort($paytypesummary);
            uasort($branch, function($a, $b) {
                return strnatcasecmp(trim($a['payment_organization_name']), trim($b['payment_organization_name']));
            });

            $data['branchwise'] = $branch;
            $data['paytypesummary'] = $paytypesummary;
        } else {
            $data['result'] = $result->data;
        }

        $data['cargo_status'] = config_item('cargo_status');  
        $data['cargo_payment_status'] = config_item('cargo_payment_status'); 
        
        if ($this->input->post('export') == 1){
            $filename = 'Branch Revenue Report';
            if($this->input->post('filterType') == 'DETAILS'){
                $this->load->excel('site/cargo/collection-report-details-xlsv2', $data, $filename);
            } else {
                $this->load->excel('site/cargo/collection-report-list-xlsv2', $data, $filename);
            }
        }else{
            if($this->input->post('filterType') == 'DETAILS'){
                $this->load->view('site/cargo/collection-report-details-listv2', $data);
            } else {
                $this->load->view('site/cargo/collection-report-listv2', $data);
            }
        }
    }

    public function average_revenue_report() {
        $this->is_logged_in();
        $data = array();

        $this->load->view('site/cargo/average-revenue-report', $data);
    }

    public function average_revenue_report_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQK461FL76',
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $this->input->post('fromDate'),
        );

        $p_key = _get_namespace_id().'_average_revenue_report_'.md5(http_build_query($data));
        if ($this->input->post('export') == 1) {   //  serve export data from cache
            if( !$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getDynamicReportDataWithMap($data);
                $this->rediscache->set($p_key, $result, 600);    //  10 mins
            }
        } else {
            $result = $this->api_model->getDynamicReportDataWithMap($data);
            $this->rediscache->set($p_key, $result, 600);    //  10 mins
        }
        $result = json_decode($result);
        usort($result->data, function($a, $b) {
            return $a->organization_name < $b->organization_name ? -1 : 1;
        });
        $data['result'] = $result->data;
        $data['no_of_days'] = max(1, daysBetween($data['fromDate'], $data['toDate']) + 1);

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/average-revenue-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Average Revenue Report.xls');
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
        else {
            $this->load->view('site/cargo/average-revenue-report-list', $data);
        }
    }
  
    function ogplv2_search_list() {
        $this->is_logged_in();

        $data = array();
        $transitCode = $this->input->post('transitCode');

        if ($transitCode) {
            $transit = $this->api_model->cargoOGPLDetails(array(
                'transitCode' => $transitCode
            ));
            $transit = json_decode($transit);
            $data['transitList'] = [ $transit->data ];
            $ogpl = $this->api_model->cargoOGPLDetails(array(
                'transitCode' => $transitCode
            ));
            $ogpl = json_decode($ogpl);
            $data['ogpl'] = $ogpl->data;

            $odoDetails = $this->api_model->getTransitOdometer(array(
                'transitCode' => $transitCode
            ));
            $odoDetails = json_decode($odoDetails);
            foreach ($odoDetails->data as $row) {
                if ($row->organization->code == $ogpl->data->fromOrganization->code) {
                    $data['odoDetails'] = $row;
                }
            }

            $contact = $this->api_model->getContact();
            $contact = json_decode($contact);
            $data['vendors'] = $contact->data;

            $con = array();
            foreach($contact->data as $key=>$val){
                $con[$val->contactCategory->name][$key] = $val;
                $con[$val->contactCategory->name][$key] = $val;
            }
            
            $data['contact'] = $con;
        } else {
            $vehicleCode = $this->input->post('vehicleCode');
            $transitList = $this->api_model->searchOGPLV2(array(
                'tripDate' => $this->input->post('tripDate'),
                'vehicleCode' => $vehicleCode,
                'transitType' => 'NA'
            ));
            $transitList = json_decode($transitList);
            $transitList = $transitList->data;

            $data['transitList'] = array();
            $data['lastTransit'] = array();

            $transitCode = '';
            $transitFromOrganization = ''; //from organization
            foreach ($transitList as $transit) {
                // if (!in_array($transit->cargoActivityType->code, ['TRNT', 'INTRNT'])) {
                //     continue;
                // }
                if(!in_array($transit->transitStatus->code, ['CMPLT', 'TRNSFR']) ) { 
                    // Dont show Completed, Transfered, Empty Load transit for further loading.
                    $data['transitList'][] = $transit;
                } else {
                    $data['lastTransit'][] = $transit;
                }

                if ($transit->cargoActivityType->code == 'INTRNT' && $transit->transitStatus->code == 'CMPLT') {
                    $data['localTransit'] = $transit;
                }
                $transitCode = $transit->code;
                $transitFromOrganization= $transit->fromOrganization->code;
            }

            $vehicles = $this->api_model->getAllVehicle();
            $vehicles = json_decode($vehicles);
            $data['vehicles'] = $vehicles->data;

            $data['vehicleInfo'] = null;
            foreach ($vehicles->data as $vehicle) {
                if ($vehicle->code == $vehicleCode) {
                    $data['vehicleInfo'] = $vehicle;
                    break;
                }
            }

            $odoDetails = $this->api_model->getTransitOdometer(array(
                'transitCode' => $transitCode
            ));
            $odoDetails = json_decode($odoDetails);
            foreach ($odoDetails->data as $row) {
                if ($row->organization->code == $transitFromOrganization) {
                    $data['odoDetails'] = $row;
                }else{
                }
            }

            $data['vehicleCode'] = $vehicleCode;
        }

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        $data['login_organization'] = $this->session->userdata('org_code');
        $data['login_station'] = $this->session->userdata('org_station_code');
        $data['login_branch'] = $this->session->userdata('org_code');
        $data['cargo_setting'] = _get_cargo_settings();
        $cargoSettings = _get_cargo_settings();

        // additinal details for edit trip
        $bankdetail = $this->api_model->getOrganizationOtherDetails(array(
            'organizationcode' => $this->session->userdata('org_code')
        ));
        $bankdetail = json_decode($bankdetail);
        $data['bankdetail'] = $bankdetail->data->bankDetails;

        $branchContact = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $branchContact = json_decode($branchContact);
        $data['branchContact'] = $branchContact->data;
        $data['f_t_mode'] = config_item('transaction_mode');

        $transitDetails = $this->api_model->cargoOGPLDetails(array(
            'transitCode' => $transitList[0]->code,
        ));
        $transitDetails = json_decode($transitDetails);
        $transitDetails = $transitDetails->data;

        $data['loadbranchs']=$transitDetails;
        
        $this->load->view('site/cargo/search-ogplv2', $data);
    }

    function ogplv2_empty_load() {
        $this->is_logged_in();

        $fromOrganization = $this->input->post('fromOrganization');
        $toOrganization = $this->input->post('toOrganization');

        $ogpl = $this->api_model->cargoOGPLupdate(array(
            'activeFlag' => $this->input->post('activeFlag'),
            'code' => $this->input->post('code') ?: '',
            'name' => $this->input->post('name'),
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation'),
            'fromOrganization' => array('code' => $fromOrganization ? $fromOrganization['code'] : $this->session->userdata('org_code')),
            'toOrganization' => array('code' => $toOrganization ? $toOrganization['code'] : $this->session->userdata('org_code')),
            'viaStations' => $this->input->post('viaStations') ?: [],
            'tripDate' => $this->input->post('tripDate'),
            'busVehicle' => $this->input->post('busVehicle'),
            'vehicleDriver' => $this->input->post('vehicleDriver'),
            'cargoActivityType' => $this->input->post('cargoActivityType'),
            'remarks' => $this->input->post('remarks'),
            'arrivalMinutes' => (int) $this->input->post('arrivalMinutes'),
            'departureMinutes' => (int) $this->input->post('departureMinutes'),
            'odometer' => $this->input->post('odometer') ?: '',
            'additionalAttribute' => $this->input->post('additionalAttribute') ?: new stdClass,
        ));

        $ogpl = json_decode($ogpl);

        if ($ogpl->status != 1) {
            echo json_encode($ogpl);
            return;
        }

        $cargoResponseState = [];

        $load = $this->api_model->cargoOGPLload(array(
            'code' => '',
            'name' => '',
            'activeFlag' => 1,
            'actionCode' => 'ADD',
            'transitStatus' => array('code' => 'INIT'),
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation'),
            'fromOrganization' => array('code' => $this->session->userdata('org_code')),
            'toOrganization' => array('code' => $toOrganization ? $toOrganization['code'] : $this->session->userdata('org_code')),
            'transitCargo' => array('code' => $ogpl->data->code),
            'transitOrganization' => array('code' => $this->session->userdata('org_code')),
            'cargoList' =>$this->input->post('cargoList') ?: [],
            'activityType' => $this->input->post('activityType') ?: 'EMPTY_LOAD',
        ));
        $load = json_decode($load);

        if ($load->status == 1) {
            $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
        } else {
            echo json_encode($load);
            return;
        }

        echo json_encode(array(
            'status' => 1,
            'OGPLCode' => $ogpl->data->code,
            'OGPLDate' => $this->input->post('tripDate'),
            'cargoResponseState' => $cargoResponseState
        ));
    }

    function generate_next_ogpl_sequence() {
        $fromOrganization = $this->input->post('fromOrganization');
        $toOrganization = $this->input->post('toOrganization');

        echo $this->api_model->generateNextOGPLSequence(array(
            'cargoActivityType' => $this->input->post('cargoActivityType'),
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation'),
            'fromOrganization' => array('code' => $fromOrganization ? $fromOrganization['code'] : $this->session->userdata('org_code')),
            'toOrganization' => array('code' => $toOrganization ? $toOrganization['code'] : $this->session->userdata('org_code')),
        ));
    }
    
    function ogplv2_empty_unload() {
        $this->is_logged_in();

        echo $this->api_model->OGPLV2EmptyUnload(array(
            'code' => $this->input->post('code')
        ));
    }
    
    function undo_unload_lr() {
        $this->is_logged_in();

        echo $this->api_model->undoUnloadLR(array(
            'cargoCode' => $this->input->post('code')
        ));
    }
    
    public function recent_bookings() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQG6PLX8',
            'toDate' => date('Y-m-d', strtotime('today')),
            'fromDate' => date('Y-m-d', strtotime('today')),
            'userCode' => $this->session->userdata('user_id'),
            'cargoStatusCode' => 'NA',
            'paymentStatusCode' => 'NA',
            'fromStationCode' => 'NA',
            'toStationCode' => 'NA',
            'organizationCode' => 'NA',
            'stationCode' => 'NA',
            'customerName' => 'NA',
            'groupCode' => $this->input->get('groupCode') ?: 'NA',
            'filterType' => 'DETAILS',
            'stateCode' => 'NA',
        );

        // $p_key = _get_user_id() . '_recent_bookings_' . strtotime('today');
        // if(!$result = $this->rediscache->get($p_key)) {
        //     $result = $this->api_model->getDynamicReportDataWithMap($data);
        //     $result = json_decode($result);
        //     if ($result->status == 1) {
        //         $result->data = array_slice($result->data, -20);
        //         $this->rediscache->set($p_key, json_encode($result), 600);
        //     }
        // } else {
        //     $result = json_decode($result);
        // }
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $result->data = array_slice($result->data, -20);
        $result->data = array_reverse($result->data);

        $data['result'] = $result->data;
        $data['cargo_status'] = config_item('cargo_status');

        $this->load->view('site/cargo/recent-bookings-list', $data);
    }
    
    function get_slug_details() {
        $this->is_logged_in();

        echo $this->api_model->getSlugDetails(array(
            'accessToken' => config_item('access_token'),
            'slug' => $this->input->post('slug')
        ));
    }
    
    function check_demurrage_charge() {
        $this->is_logged_in();
        echo $this->api_model->checkDemurrageCharge(array(
            'cargoCode' => $this->input->post('cargoCode')
        ));
    }
    
    function update_delivery_payment() {
        $this->is_logged_in();

        $imageDetails = $this->input->post('imageDetails') ?: [];
        if (count($imageDetails)) {
            $document = $this->api_model->saveCargoDocument(array(
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
            $document = json_decode($document);
            
            if ($document->status != 1) {
                echo json_encode($document);
                return;
            }
        }

        $serviceTaxEditFlag = $this->input->post('serviceTaxEditFlag') ?: '';
        if (isNotNull($serviceTaxEditFlag) && $serviceTaxEditFlag == 1) {
            $gstEdit = $this->input->post('lrGSTEdit') ?: '';
            $lrGSTEdit = $this->api_model->editCargoServiceTax(array(
                'serviceTaxEditFlag' =>  $serviceTaxEditFlag,
                'code' => $gstEdit['code'],
                'serviceTax' => $gstEdit['serviceTax'],
                'itemDetails' => $gstEdit['itemDetails']
            ));
            $lrGSTEdit = json_decode($lrGSTEdit);
            if ($lrGSTEdit->status != 1) {
                echo json_encode($lrGSTEdit);
                return;
            }
        }

        echo $this->api_model->updatePaymentAndDelivery(array(
            'cargoTransactionList' => $this->input->post('cargoTransactionList') ?: [],
            'itemDetails' => $this->input->post('itemDetails') ?: [],
            'cargoAddonsDetails' => $this->input->post('cargoAddonsDetails') ?: [],
            'deliveryHandlingAmount' => $this->input->post('deliveryHandlingAmount') ?: 0,
            'transactionMode' => $this->input->post('transactionMode') ?: ['code' => ''],
            'cargoCode' => $this->input->post('cargoCode'),
            'otpNumber' => $this->input->post('otpNumber') ?: '',
            'remarks' => $this->input->post('remarks') ?: [],
            'additionalAttribute' => $this->input->post('additionalAttribute') ?: (object) [],
            "hamaliCharge"=>$this->input->post('hamaliCharge') ?:0,
        ));
    }
    
    function addon_details_report() {
        $this->is_logged_in();

        $data['addon_charges_type'] = config_item('addon_charges_type');

        $this->load->view('site/cargo/addon-details-report', $data);
    }

    function addon_details_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQLB9M4850',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'addonTypeCode' => $this->input->post('addonTypeCode')
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['result'] = $result->data;

        $data['cargo_status'] = config_item('cargo_status');
        $data['addon_charges_type'] = config_item('addon_charges_type');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/addon-details-report-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=Addon Details Report.xls');
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
            $this->load->view('site/cargo/addon-details-report-list', $data);
        }
    }
    
    function refresh_transit_data() {
        $this->is_logged_in();

        echo $this->api_model->refreshTransitData(array(
            'transitCode' => $this->input->post('transitCode')
        ));
    }

    public function ogpl_update_missing() {
        $this->is_logged_in();

        $cargoList = $this->input->post('cargoList') ?: [];
        foreach ($cargoList as $cargo) {
            $data = array(
                'statusCode' => $cargo['statusCode'],
                'cargoCode' => $cargo['code'],
                'remarks' => $cargo['remarks'] ?: []
            );
            $res = $this->api_model->changeCargoItemStatus($data);
            $res = json_decode($res);

            if ($res->status != 1) {
                echo json_encode($res);
                return;
            }
        }

        echo json_encode(['status' => 1]);
    }

    public function revert_cargo_missing() {
        $this->is_logged_in();

        $data = array(
            'statusCode' => $this->input->post('statusCode') ?: 'CUL',
            'cargoCode' => $this->input->post('code'),
            'transitOrganization' => $this->input->post('transitOrganization'),
            'remarks' => $this->input->post('remarks') ?: []
        );
        echo $this->api_model->changeCargoItemStatus($data);
    }

    public function ogpl_transfer_list() {
        $this->is_logged_in();

        $result = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQJ45G4144',
            'cargoTransitCode' =>$this->input->post('transitCode'),
            'organizationCode' => has_action_rights('CGO-VIEW-ALL-LR') ? 'NA' : $this->session->userdata('org_code'),
            'stationCode' =>'NA',
            'allowSameStation' => '0',
            'allowSameBranch' =>'0',
            'filterType' => 'LOAD'
        ));
        $result = json_decode($result);

        usort($result->data, function($a, $b) {
            return (strtotime(trim($a->booked_at)) < strtotime(trim($b->booked_at))) ? -1 : 1;
        });

        $list = array();
        foreach ($result->data as $row) {
            if ($row->cargo_status_code != 'CL') {
                continue;
            }
            $key = $row->from_station_name;
            $key .= ($row->from_station_short_code!="") ? ' ( '.$row->from_station_short_code.' )' : '';
            $key .= ' to '.$row->transit_organization_name;
            $key .= ($row->transit_organization_short_code!="") ? ' ( '.$row->transit_organization_short_code.' )' : '';

            $list[$key][] = $row;
        }

        $data['result'] = $list;

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

		$branchContact = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $branchContact = json_decode($branchContact);
        $data['branchContact'] = $branchContact->data;

        $data['show_end_odo'] = $this->input->post('show_end_odo');
        $data['transfer_end_odo'] = $this->input->post('transferEndOdometer');
        $data['ogpl_code'] = $this->input->post('transitCode');
        $data['ogpl_vehicle'] = $this->input->post('vehicleCode');
        $data['logged_in_org'] = $this->session->userdata('org_code');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/ogpl-transfer-list', $data);
    }

    public function get_transfer_ogpl() {
        $this->is_logged_in();

        echo $this->api_model->getTransferOgplList(array(
            'cargoActivityType' => ['code' => 'TRNT'],
            'tripDate' => $this->input->post('tripDate'),
            'transitCargoDetails' => $this->input->post('transitCargoDetails') ?: [],
            'busVehicle' => $this->input->post('busVehicle')
        ));
    }

    public function validate_and_transfer_ogpl() {
        $this->is_logged_in();

        $routeList = $this->input->post('routeList');

        foreach ($routeList as $route) {
            $transfer = $this->api_model->validateTransferOgpl(array(
                'activeFlag' => (int) $route['activeFlag'],
                'toStation' => $route['toStation'],
                'fromStation' => $route['fromStation'],
                'fromOrganization' => $route['fromOrganization'],
                'toOrganization' => $route['toOrganization'],
                'transitCargo' => $route['transitCargo'],
                'transitOrganization' => $route['transitOrganization'],
                'cargoList' => $route['cargoList'] ?: []
            ));

            $transfer = json_decode($transfer);
            if ($transfer->status != 1) {
                echo json_encode($transfer);
                return;
            }

            $err = 0;
            foreach ($transfer->data->cargoList as $cargo) {
                if ($cargo->activeFlag == 0) {
                    $err++;
                }
            }
            if ($err > 0) {
                echo json_encode($transfer);
                return;
            }
        }

        foreach ($routeList as $route) {
            $transfer = $this->api_model->confirmTransferOgpl(array(
                'activeFlag' => (int) $route['activeFlag'],
                'toStation' => $route['toStation'],
                'fromStation' => $route['fromStation'],
                'fromOrganization' => $route['fromOrganization'],
                'toOrganization' => $route['toOrganization'],
                'transitCargo' => $route['transitCargo'],
                'transitOrganization' => $route['transitOrganization'],
                'cargoList' => $route['cargoList'] ?: []
            ));

            $transfer = json_decode($transfer);
            if ($transfer->status != 1) {
                echo json_encode($transfer);
                return;
            }
        }

        echo json_encode(['status' => 1]);
    }

    public function update_vendor_password() {
        $this->is_logged_in();

        echo $this->api_model->updateVendorPassword(array(
            'vendorCode' => $this->input->post('code'),
            'newPassword' => $this->input->post('password')
        ));
    }

    public function check_manual_lr_exists() {
        $this->is_logged_in();

        $validate = $this->api_model->checkCargoCodeExists(array(
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation'),
            'fromOrganization' => $this->input->post('fromOrganization'),
            'toOrganization' => $this->input->post('toOrganization'),
            'paymentType' => $this->input->post('paymentType'),
            'additionalAttribute' => $this->input->post('additionalAttribute'),
        ));
        $validate = json_decode($validate);

        if ($validate->status != 1 && $validate->errorCode == 'CG004') {
            $validate->errorDesc = 'LR number already exists';
            echo json_encode($validate);
            return;
        } 
        if ($validate->status != 1) {
            echo json_encode($validate);
            return;
        }

        echo json_encode($validate);
    }

    public function get_manual_lr() {
        $this->is_logged_in();

        echo $this->api_model->generateBookingSequence(array(
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation'),
            'fromOrganization' => $this->input->post('fromOrganization'),
            'toOrganization' => $this->input->post('toOrganization'),
            'paymentType' => $this->input->post('paymentType')
        ));
    }

    public function generate_next_lr_sequence() {
        $this->is_logged_in();

        echo $this->api_model->generateNextLrSequence(array(
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation'),
            'fromOrganization' => $this->input->post('fromOrganization'),
            'toOrganization' => $this->input->post('toOrganization'),
            'fromCustomer' => $this->input->post('fromCustomer'),
            'toCustomer' => $this->input->post('toCustomer'),
            'vendorUser' => $this->input->post('vendorUser'),
            'paymentType' => $this->input->post('paymentType'),
            'additionalAttribute' => (object) $this->input->post('additionalAttribute') ?: (object) []
        ));
    }

    public function revert_unable_deliver() {
        $this->is_logged_in();

        echo $this->api_model->revertUnableDeliver(array(
            'cargoCode' => $this->input->post('cargoCode'),
            'cargoStatusCode' => $this->input->post('cargoStatusCode'),
            'data' => array(
                'remarks' => $this->input->post('remarks') ?: []
            ),
        ));
    }
    
    public function ogpl_ewaylr_list() {
        $this->is_logged_in();

        $data = array('transitCode' => $this->input->post('transitCode'));
        $result = $this->api_model->getTransitEwayBillLR($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $data['vehicle_no'] = $this->input->post('vehicleNo');
        $data['ogpl_from'] = $this->input->post('ogplFrom');
        $data['cargo_code'] = $this->input->post('lrCode');

        $result = $this->api_model->getAllIntegrations();
        $result = json_decode($result);

        foreach ($result->data as $integration) {
            if ($integration->integrationType->code == 'EWAYBILL') {
                $data['ewaybill_integration'] = $integration;
            }
        }

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/ogpl-ewaylr-list', $data);
    }
    
    public function update_ewaybill_vehicle() {
        $this->is_logged_in();

        echo $this->api_model->updateEwaybillVehicle(array(
            'transitCode' => $this->input->post('transitCode'),
            'cargoList' => $this->input->post('cargoList')
        ));
    }
    
    public function ewaybill_summary() {
        $this->is_logged_in();
        require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
        require_once APPPATH . 'third_party/tcpdf/tcpdf_barcodes_2d.php';

        $ewayBillNo = $this->input->get('code');
        $details = $this->api_model->getEwayBillDetails(array('ewayBillNo' => $ewayBillNo));
        $details = json_decode($details);
        $data['details'] = $details->data;

        $data['ewaybill_supply_type'] = config_item('ewaybill_supply_type'); 
        $data['ewaybill_sub_supply_type'] = config_item('ewaybill_sub_supply_type'); 
        $data['ewaybill_document_type'] = config_item('ewaybill_document_type'); 
        $data['ewaybill_transportation_mode'] = config_item('ewaybill_transportation_mode'); 
        $data['ewaybill_transaction_type'] = config_item('ewaybill_transaction_type'); 

        $pdf = new TCPDF();
        $pdf->SetTitle('Eway Bill');
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->SetFont('helvetica', '', 8);
        $pdf->SetMargins(40, 10, 30, true);
        $pdf->AddPage();

        ob_clean();
        $this->load->exclude_template();
        $content = $this->load->view('site/ewaybill/ewaybill-summary', $data, true);

        $pdf->writeHTML($content);

        // QRCODE
        $qrcodedata = implode('/', [$details->data->ewayBillNo, $details->fromTaxPayerDetails->gstin, date('m/d/Y h:i:s', $details->data->createdAt)]);
        $styleQR = array('border' => false, 'padding' => 0, 'fgcolor' => array(0, 0, 0), 'bgcolor' => false);
        $pdf->write2DBarcode($qrcodedata, 'QRCODE,H', 90, 25, 28, 28, $styleQR, 'N');

        // BARCODE
        $style = array(
            'position' => '',
            'align' => 'C',
            'stretch' => false,
            'fitwidth' => true,
            'cellfitalign' => '',
            'border' => false,
            'hpadding' => 'auto',
            'vpadding' => 'auto',
            'fgcolor' => array(0,0,0),
            'bgcolor' => false, //array(255,255,255),
            'text' => true,
            'font' => 'helvetica',
            'fontsize' => 6,
            'stretchtext' => 1
        );
        $pdf->write1DBarcode($details->data->ewayBillNo, 'C128', 90, 205 + (5 * count($details->data->vehicleDetails)), 30, 15, 0.4, $style, 'N');

        $pdf->Output("Eway Bill - {$ewayBillNo}", 'i');
    }
    
    public function ewaybill_details() {
        $this->is_logged_in();

        $ewayBillNo = $this->input->post('ewayBillNo');
        $details = $this->api_model->getEwayBillDetails(array('ewayBillNo' => $ewayBillNo));
        $details = json_decode($details);
        $data['details'] = $details->data;

        $data['ewaybill_supply_type'] = config_item('ewaybill_supply_type'); 
        $data['ewaybill_sub_supply_type'] = config_item('ewaybill_sub_supply_type'); 
        $data['ewaybill_document_type'] = config_item('ewaybill_document_type'); 
        $data['ewaybill_transportation_mode'] = config_item('ewaybill_transportation_mode'); 
        $data['ewaybill_transaction_type'] = config_item('ewaybill_transaction_type'); 

        $this->load->view('site/ewaybill/ewaybill-details', $data);
    }

    function print_delivery_receipt() {
        $this->is_logged_in();
        $summary = $this->api_model->getCargoSummary(array('cargoCode' => $this->input->get('code')));        
        $summary = json_decode($summary);
        $data['namespace_name'] = $this->session->userdata('namespace_name');
        $data['cargoCode'] = $this->input->get('code');
        $data['summary'] = $summary->data;
        
        $cargo_payment_status = $this->config->item('cargo_payment_status');
        $data['payment_type_code'] = $summary->data->paymentType->code;
        $data['payment_type_name'] = $cargo_payment_status[$summary->data->paymentType->code];
        // change invoice pay to paid if settlement completed
        // if ($summary->data->paymentType->code == 'INP' && $summary->data->paymentSettlementFlag == 1) {
        //     $data['payment_type_code'] = 'PAD';
        //     $data['payment_type_name'] = $cargo_payment_status['PAD'];
        // }

        // map addons
        $data['addons_mapped'] = array();
        foreach ($summary->data->cargoAddonsDetails as $row) {
            $data['addons_mapped'][$row->addonsType->code] = $row;
        }

        // tax
        $data['tax_computed'] = new stdClass;
        foreach ($summary->data->itemDetails as $row) {
            $data['tax_computed']->cgstValue += $row->tax->cgstValue;
            $data['tax_computed']->sgstValue += $row->tax->sgstValue;
            $data['tax_computed']->ugstValue += $row->tax->ugstValue;
            $data['tax_computed']->igstValue += $row->tax->igstValue;
        }

        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
        $usr_pro = json_decode($usr_pro);
        $data['user_profile'] = $usr_pro->data;

        $nsprofile = $this->api_model->getNamespaceProfile(array('authtoken' => $this->_user_hash));
        $nspro = json_decode($nsprofile);
        $data['nsprofile'] = $nspro->data;

        $termsDetails = $this->api_model->getterms(array('type' => 'CGBO'));
        $termslist = json_decode($termsDetails);
        $data['terms_list'] = $termslist->data;

        $data['print_count'] = $this->input->get('count') ?: 1;
        $data['article_unit'] = $this->config->item('article_unit');
        $data['cargo_payment_status'] = $this->config->item('cargo_payment_status');
        $data['amountpaid'] = $this->input->get('amountpaid') ? $this->input->get('amountpaid') : 0;

        if ($this->input->get('type') == 'dotmatrix') { // dot matrix
            if( in_array($this->session->userdata('namespace_id'), ["rmtcargo","rathimeenaparcel"]) ){    
                // NEW FORMAT   
                // Rathimeena format for testing, Pre-Printed sheet, 8 X 4 Inch, inner body with open area.
                // TVS MSP 250 START, Font Size : 10 CPI.

                $fright = 0;
                $itemnames = '';
                foreach ($data['summary']->itemDetails as $article) {
                    $fright += (($article->itemCount * $article->fare) + $article->handlingChargeAmount);
                    $itemnames .= $article->cargoItem->name . '(' . $article->itemCount . '),';
                }

                $itemnames = strtoupper($itemnames);

                $lr   = "LR No : ".$data['cargoCode'];
                $date = "Date : ".date('d-m-Y h:i A', strtotime($data['summary']->bookedAt));
                $fb   = "From : ".strtoupper($data['summary']->fromOrganization->name).' - '.$data['summary']->fromOrganization->shortCode;
                $tb   = "To   : ".strtoupper($data['summary']->toOrganization->name).' - '.$data['summary']->toOrganization->shortCode;

                $fc = strtoupper($data['summary']->fromCustomer->name).', '.$data['summary']->fromCustomer->mobileNumber;
                $tc = strtoupper($data['summary']->toCustomer->name).' , '.$data['summary']->toCustomer->mobileNumber;

                $fr = $data['summary']->totalAmount;
                $lding = $data['summary']->totalHandlingAmount;
                
                $diff = $data['summary']->serviceTax - $data['tax_computed']->cgstValue - $data['tax_computed']->sgstValue - $data['tax_computed']->igstValue;
                $roundoff = $data['addons_mapped']['RNDF']->value + $diff;
                $ptype = strtoupper($data['payment_type_name']);
                $deliveryedat = date('d-m-Y h:i A', strtotime($data['summary']->deliveredAt));

                $total = $data['summary']->totalAmount+$data['summary']->totalHandlingAmount+$data['summary']->totalUnloadHandlingAmount+$data['summary']->pickupHandlingAmount+$data['summary']->deliveryHandlingAmount+$data['summary']->serviceCharge+$data['summary']->serviceTax+$data['summary']->hamaliCharge+$data['summary']->passCharge+$data['summary']->docketCharge + $data['addons_mapped']['RNDF']->value + $data['addons_mapped']['PODCH']->value + $data['addons_mapped']['DMRCH']->value + $data['addons_mapped']['INSUR']->value + $data['addons_mapped']['ADJSMT']->value;

                $cmds = "\033C\000\004".newline().newline().space(0). $lr .space( 25-0-strlen($lr) ). $date . space(5) ."\016". $ptype;
                $cmds .= newline().space(0). $fb .space(35-0-strlen($fb)). $tb;
                $cmds .= newline().newline().space(0). "CONSIGNER :" .space(30-0-11). "CONSIGNEE : ";
                $cmds .= newline().space(0). $fc .space(30-0-strlen($fc)). $tc;
                $cmds .= newline().newline().space(0). " ITMES : " .$itemnames;
                $cmds .= newline().space(5)."DELIVERED AT".space(18)."Freight         : ".$fr;
                $cmds .= newline().space(5).$deliveryedat.space(35-5-strlen($deliveryedat))."Loading Charges : ".$lding;

                if ($data['tax_computed']->igstValue == 0) {
                    $cmds .= newline().space(35)."CGST : ".$data['tax_computed']->cgstValue.", SGST : ".$data['tax_computed']->sgstValue;
                } else {
                    $cmds .= newline().space(35)."IGST             : ".$data['tax_computed']->igstValue;
                }

                $cmds .= newline().space(35)."Round off       : ".$roundoff;
                $cmds .= newline().space(35)."\016"."Total : ". $total;
                $cmds .= " \f"; 

                ob_clean();
                echo $cmds;
            } else if (in_array($this->session->userdata('namespace_id'), ["citycargo","cityparcel"])) {
                $amountpaid = substr(ceil(floatval($data['amountpaid'])), 0, 13);
                $lr = substr($data['cargoCode'], 0, 13);
                $bookedAt = substr(date('d/m/Y', strtotime($data['summary']->bookedAt)), 0, 10);
                
                $from_org = substr($data['summary']->fromOrganization->name, 0, 30);
                $to_org = substr($data['summary']->toOrganization->name, 0, 30);

                $from_customer = substr($data['summary']->fromCustomer->name, 0, 30);
                $to_customer = substr($data['summary']->toCustomer->name, 0, 30);

                $no_of_articles = 0;
                foreach ($data['summary']->itemDetails as $article) {
                    $no_of_articles += $article->itemCount;
                } 

                $data['addons_mapped'] = array();
                foreach ($summary->data->cargoAddonsDetails as $row) {
                    $data['addons_mapped'][$row->addonsType->code] = $row;
                }

                $topay_amount = 0;
                $unloading_chg = 0;
                $dd_chg = 0;
                $paid_unload_chg = 0;
                $demurage = 0;
                if ($data['summary']->paymentType->code == 'TOP') {
                    // $topay_amount = $data['summary']->totalAmount+$data['summary']->totalHandlingAmount+$data['summary']->pickupHandlingAmount+$data['summary']->deliveryHandlingAmount+$data['summary']->serviceCharge+$data['summary']->serviceTax+$data['summary']->hamaliCharge+$data['summary']->passCharge+$data['summary']->docketCharge + $data['addons_mapped']['PODCH']->value + $data['addons_mapped']['RNDF']->value + $data['addons_mapped']['INSUR']->value + $data['addons_mapped']['ADJSMT']->value + $data['addons_mapped']['MCNHCH']->value + $data['addons_mapped']['FOVCH']->value;
                    $unloading_chg = $data['summary']->totalUnloadHandlingAmount;
                    $demurage = $data['addons_mapped']['DMRCH']->value;
                } elseif ($data['summary']->paymentType->code == 'PAD') {
                    // $topay_amount = $data['summary']->totalAmount+$data['summary']->totalHandlingAmount+$data['summary']->pickupHandlingAmount+$data['summary']->serviceCharge+$data['summary']->serviceTax+$data['summary']->hamaliCharge+$data['summary']->passCharge+$data['summary']->docketCharge + $data['addons_mapped']['PODCH']->value + $data['addons_mapped']['RNDF']->value + $data['addons_mapped']['INSUR']->value + $data['addons_mapped']['ADJSMT']->value + $data['addons_mapped']['MCNHCH']->value + $data['addons_mapped']['FOVCH']->value;
                    $unloading_chg = $data['summary']->totalUnloadHandlingAmount;
                    $paid_unload_chg = $data['amountpaid'] - $data['summary']->deliveryHandlingAmount ;
                    $dd_chg = $data['amountpaid'] - $paid_unload_chg;
                    $demurage = $data['addons_mapped']['DMRCH']->value;
                } elseif ($data['summary']->paymentType->code == 'TPPAD') {
                    $topay_amount = $data['summary']->totalAmount+$data['summary']->totalHandlingAmount+$data['summary']->pickupHandlingAmount+$data['summary']->serviceCharge+$data['summary']->serviceTax+$data['summary']->hamaliCharge+$data['summary']->passCharge+$data['summary']->docketCharge + $data['addons_mapped']['PODCH']->value + $data['addons_mapped']['RNDF']->value + $data['addons_mapped']['INSUR']->value + $data['addons_mapped']['ADJSMT']->value + $data['addons_mapped']['MCNHCH']->value + $data['addons_mapped']['FOVCH']->value;
                    $unloading_chg = $data['summary']->totalUnloadHandlingAmount;
                    $paid_unload_chg = $data['amountpaid'] -  $data['summary']->deliveryHandlingAmount;
                    $dd_chg = $data['amountpaid'] - $paid_unload_chg ;
                    $demurage = $data['addons_mapped']['DMRCH']->value;
                }
                if ($data['summary']->paymentType->code == 'TOP') {
                    $total_amount = $data['amountpaid'];
                } elseif ($data['summary']->paymentType->code == 'PAD'){
                    $total_amount = $data['amountpaid'];
                } elseif ($data['summary']->paymentType->code == 'PAD' && $data['summary']->deliveryHandlingAmount == 0) {
                    $total_amount = $data['amountpaid'];
                } elseif ($data['summary']->paymentType->code == 'TPPAD') {
                    $total_amount = $data['amountpaid'];
                }

                $remarks = substr($data['summary']->remarks[0]->name, 0, 40);
                $current_time = date("H:i:s", time());

                if ($total_amount > 0 && strlen(ucwords(amount_in_words($total_amount))) < 50) {
                    $total_topay_amount = ucwords(amount_in_words($total_amount)). " Only".space(50-strlen(ucwords(amount_in_words($total_amount))));
                    $total_topay_amount_in_words = str_replace("Rupees  ", "",$total_topay_amount);
                } elseif ($total_amount > 0) {
                    $total_topay_amount = substr(ucwords(amount_in_words($total_amount)),0,50)."..."."Only";
                    $total_topay_amount_in_words = str_replace("Rupees  ", "",$total_topay_amount);
                }
                $cmds = "\033C\000\004".newline().newline().newline().newline().space(12).$from_org.space(40-0-strlen($from_org)).$to_org;
                $cmds .= newline().space(12).$from_customer.space(40-0-strlen($from_customer));
                $cmds .= newline().space(12).$lr.space(40-0-strlen($lr)).$bookedAt;
                
                if ($data['summary']->paymentType->code == 'TOP' || $data['summary']->paymentType->code == 'TPPAD')  {
                    $cmds .= newline().newline().space(12).$no_of_articles.space(45-0-strlen($no_of_articles)).$data['amountpaid'];
                }else{
                    $cmds .= newline() . newline() . space(12) . $no_of_articles . space(45 - 0 - strlen($no_of_articles));
                }

                if ($data['summary']->paymentType->code == 'PAD') {
                    $cmds .= newline() . newline() . space(35) . "PAID : " . space(15) . $data['amountpaid'];
                }else{
                    $cmds .= newline() . newline() . space(35);
                } 

                $cmds .= newline().newline().space(12).$current_time.space(45-0-strlen($current_time)).($total_amount);
                $cmds .= newline().space(12).$total_topay_amount_in_words;
                $cmds .= " \f"; 
                
                ob_clean();
                echo $cmds;
            } 
            return;
        } else if ($this->input->get('type') == 3) { // 3inch print.
            $this->load->exclude_template();
            
            if ($summary->data->cargoStatus->code == 'CD') {
                $data['amountpaid'] = $this->input->get('amountpaid') ? $this->input->get('amountpaid') : 0;
                $this->load->view('site/cargo/delivery-receipt-3inch', $data);
            } else {
                echo 'LR not yet delivered';
            }
            return;
            }

            require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
        $pdf = new TCPDF();
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->SetFont('times', '', 8);

        $pdf->AddPage();

        ob_clean();
        if ($summary->data->cargoStatus->code == 'CD' && $this->session->userdata('namespace_id') == "seenutransports") {
            $data = array(
                'receiptType' => 'LR',
                'referenceCode' => $this->input->get('code'),
            );
            $result = $this->api_model->getDeliveryReceipt($data);
            $result = json_decode($result);
            $data['result'] = end($result->data);

            $this->load->exclude_template();
            $content = $this->load->view('site/payment/transaction-receipt-print-seenutransport', $data, true);
        } elseif ($summary->data->cargoStatus->code == 'CD' && in_array($this->session->userdata('namespace_id'), ["citycargo","cityparcel"])) {
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/delivery-receipt-pdf-cityparcel', $data, true);
        }else if($this->session->userdata('namespace_id') == "ktwoklogistics"){
            $this->load->exclude_template();
            $content = $this->load->view('site/cargo/delivery-receipt-ktwoklogistics-pdf', $data, true);
        }elseif ($summary->data->cargoStatus->code == 'CD') {
            $this->load->exclude_template();
            $data['amountpaid'] = $this->input->get('amountpaid') ? $this->input->get('amountpaid') : 0;

            $content = $this->load->view('site/cargo/delivery-receipt-pdf', $data, true);
        } else {
            $content = 'LR not yet delivered';
        }
        $pdf->writeHTML($content);

        $pdf->Output("Delivery Receipt {$summary->data->code}.pdf", 'i');
    }

    function edit_door_delivery() {
        $this->is_logged_in();

        $data = array('user' => $this->input->post('customerCode'));

        $cargo_setting = _get_cargo_settings();
        if ($cargo_setting->userAccountModel->code == 'TXRT' && $this->input->post('paymentTypeCode') == 'OATP') {
            $address = $this->api_model->getVendorAddress(array('vendorCode' => $this->input->post('vendorUserCode')));
        } else {
            $address = $this->api_model->getCargoCustomerAddress($data);
        }
        $address = json_decode($address);
        $data['address'] = $address->data;
        $data['mandateAddressOnBookingFlag'] =$cargo_setting->mandateAddressOnBookingFlag?true:false;
        $data['toStationCode'] =$this->input->post('toStationCode');
        $namespaceNames = $this->api_model->getNamespaceStation(array('authtoken' => _get_user_hash()));
        $namespaceNames = json_decode($namespaceNames);
        $data['stations'] = $namespaceNames->data;

        $this->load->view('site/cargo/edit-door-delivery', $data);
    }
    
    function update_door_delivery() {
        $this->is_logged_in();

        $toCustomerAddressCode = $this->input->post('toCustomerAddressCode');
        $updateDelAddress = $this->input->post('updateDelAddress');
        $serviceTaxEditFlag = $this->input->post('serviceTaxEditFlag') ?: '';

        if (isNotNull($serviceTaxEditFlag) && $serviceTaxEditFlag == 1) {
            $gstEdit = $this->input->post('lrGSTEdit') ?: '';
            $lrGSTEdit = $this->api_model->editCargoServiceTax(array(
                'serviceTaxEditFlag' =>  $serviceTaxEditFlag,
                'code' => $gstEdit['code'],
                'serviceTax' => $gstEdit['serviceTax'],
                'itemDetails' => $gstEdit['itemDetails']
            ));
            $lrGSTEdit = json_decode($lrGSTEdit);
            if ($lrGSTEdit->status != 1) {
                echo json_encode($lrGSTEdit);
                return;
            }
        }

        if (!$toCustomerAddressCode) {
            $address = $this->api_model->updateCargoCustomerAddress(array(
                'name' =>  $this->input->post('name'),
                'address1' => $this->input->post('address1'),
                'address2' => $this->input->post('address2'),
                'landmark' => $this->input->post('landmark'),
                'pincode' => $this->input->post('pincode'),
                'station' => array('code' => $this->input->post('station')),
                'user' => $this->input->post('userCode'),
                'code'  => '',
                'defaultFlag' => 1,
                'activeFlag'  => 1
            ));
            $address = json_decode($address);
            if ($address->status != 1) {
                echo json_encode($address);
                return;
            }
            $toCustomerAddressCode = $address->data->code;
        }

        if($updateDelAddress == 1 && $toCustomerAddressCode){
            $del_address = $this->api_model->updateCargoCustomerAddress(array(
                'name' =>  $this->input->post('name'),
                'address1' => $this->input->post('address1'),
                'address2' => $this->input->post('address2'),
                'landmark' => $this->input->post('landmark'),
                'pincode' => $this->input->post('pincode'),
                'station' => array('code' => $this->input->post('station')),
                'user' => $this->input->post('userCode'),
                'code'  => $toCustomerAddressCode,
                'defaultFlag' => 1,
                'activeFlag'  => 1
            ));
            $del_address = json_decode($del_address);
            if ($del_address->status != 1) {
                echo json_encode($del_address);
                return;
            }
        }

        $deliveryType = $this->input->post('deliveryType');
        if ($deliveryType == 'DYSE') {
            $deliveryType = 'DYDO';
        }

        echo $this->api_model->updatePickupDelivery(array(
            'code' => $this->input->post('code'),
            'fromCustomerAddress' => $this->input->post('fromCustomerAddress'),
            'toCustomerAddress' => ['code' => $toCustomerAddressCode],
            'deliveryType' => ['code' => $deliveryType],
            'pickupType' => ['code' => $this->input->post('pickupType')],
            'pickupHandlingAmount' => $this->input->post('pickupHandlingAmount'),
            'deliveryHandlingAmount' => $this->input->post('deliveryHandlingAmount'),
        ));
    }

    function edit_door_pickup() {
        $this->is_logged_in();

        $data = array('user' => $this->input->post('customerCode'));

        $cargo_setting = _get_cargo_settings();
        if ($cargo_setting->userAccountModel->code == 'TXRT' && $this->input->post('paymentTypeCode') == 'INP') {
            $address = $this->api_model->getVendorAddress(array('vendorCode' => $this->input->post('vendorUserCode')));
        } else {
            $address = $this->api_model->getCargoCustomerAddress($data);
        }
        $address = json_decode($address);
        $data['address'] = $address->data;

        $namespaceNames = $this->api_model->getNamespaceStation(array('authtoken' => _get_user_hash()));
        $namespaceNames = json_decode($namespaceNames);
        $data['stations'] = $namespaceNames->data;
        $data['fromStationCode'] =$this->input->post('fromStation');
        $data['mandateAddressOnBookingFlag'] =$cargo_setting->mandateAddressOnBookingFlag?true:false;
        
        $this->load->view('site/cargo/edit-door-pickup', $data);
    }
    
    function update_door_pickup() {
        $this->is_logged_in();

        $fromCustomerAddressCode = $this->input->post('fromCustomerAddressCode');
        $updatePickupAddress = $this->input->post('updatePickupAddress');
        $serviceTaxEditFlag = $this->input->post('serviceTaxEditFlag') ?: '';

        if (isNotNull($serviceTaxEditFlag) && $serviceTaxEditFlag == 1) {
            $gstEdit = $this->input->post('lrGSTEdit') ?: '';
            $lrGSTEdit = $this->api_model->editCargoServiceTax(array(
                'serviceTaxEditFlag' =>  $serviceTaxEditFlag,
                'code' => $gstEdit['code'],
                'serviceTax' => $gstEdit['serviceTax'],
                'itemDetails' => $gstEdit['itemDetails']
            ));
            $lrGSTEdit = json_decode($lrGSTEdit);
            if ($lrGSTEdit->status != 1) {
                echo json_encode($lrGSTEdit);
                return;
            }
        }
        
        if (!$fromCustomerAddressCode) {
            $address = $this->api_model->updateCargoCustomerAddress(array(
                'name' =>  $this->input->post('name'),
                'address1' => $this->input->post('address1'),
                'address2' => $this->input->post('address2'),
                'landmark' => $this->input->post('landmark'),
                'pincode' => $this->input->post('pincode'),
                'station' => array('code' => $this->input->post('station')),
                'user' => $this->input->post('userCode'),
                'code'  => '',
                'defaultFlag' => 1,
                'activeFlag'  => 1
            ));
            $address = json_decode($address);
            if ($address->status != 1) {
                echo json_encode($address);
                return;
            }
            $fromCustomerAddressCode = $address->data->code;
        }

        if($updatePickupAddress == 1 && $fromCustomerAddressCode){
            $del_address = $this->api_model->updateCargoCustomerAddress(array(
                'name' =>  $this->input->post('name'),
                'address1' => $this->input->post('address1'),
                'address2' => $this->input->post('address2'),
                'landmark' => $this->input->post('landmark'),
                'pincode' => $this->input->post('pincode'),
                'station' => array('code' => $this->input->post('station')),
                'user' => $this->input->post('userCode'),
                'code'  => $fromCustomerAddressCode,
                'defaultFlag' => 1,
                'activeFlag'  => 1
            ));
            $del_address = json_decode($del_address);
            if ($del_address->status != 1) {
                echo json_encode($del_address);
                return;
            }
        }

        $pickupType = $this->input->post('pickupType');
        if ($pickupType == 'DYSE') {
            $pickupType = 'PUDO';
        }

        echo $this->api_model->updatePickupDelivery(array(
            'code' => $this->input->post('code'),
            'fromCustomerAddress' => ['code' => $fromCustomerAddressCode],
            'toCustomerAddress' => $this->input->post('toCustomerAddress'),
            'deliveryType' => ['code' => $this->input->post('deliveryType')],
            'pickupType' => ['code' => $pickupType],
            'pickupHandlingAmount' => $this->input->post('pickupHandlingAmount'),
            'deliveryHandlingAmount' => $this->input->post('deliveryHandlingAmount'),
        ));
    }
    
    public function get_tariff_rate_card() {
        $this->is_logged_in();

        echo $this->api_model->getTariffRateCard(array(
            'fromCustomer' => $this->input->post('fromCustomer'),
            'toCustomer' => $this->input->post('toCustomer'),
            'vendorUser' => $this->input->post('vendorUser'),
            'fromStation' => $this->input->post('fromStation'),
            'toStation' => $this->input->post('toStation'),
            'fromOrganization' => $this->input->post('fromOrganization') ?: (object)[],
            'toOrganization' => $this->input->post('toOrganization') ?: (object)[],
            'paymentType' => $this->input->post('paymentType') ?: (object)[],
            'additionalAttribute' => $this->input->post('additionalAttribute') ?: (object)[],
        ));
    }
    
    function generate_invoice_v2() {
        $this->is_logged_in();

        if (has_action_rights('CGO-INV-SAME-BRANCH')) {
            $vendors = $this->api_model->cargoCustomerVendorByBranch(array('organizationCode' => $this->session->userdata('org_code')));
            $vendors = json_decode($vendors);
            $data['vendors'] = $vendors->data;
        } else {
            $vendors = $this->api_model->cargoCustomerVendor();
            $vendors = json_decode($vendors);
            $data['vendors'] = $vendors->data;
        }

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $branches = $branches->data;

        $data['userOrganizationCode'] = $this->session->userdata('org_code');
        foreach ($branches as $branch) {
            if ($branch->code == $data['userOrganizationCode']) {
                $data['userOrganization'] = $branch;
                break;
            }
        }

        $gst = $this->api_model->getGstDetails();
        $gst = json_decode($gst);

        $data['gst'] = [];
        foreach ($gst->data as $row) {
            if ($row->state->code == $data['userOrganization']->state->code) {
                $data['gst'][] = $row;
            }
        }

        // all gst if state not available
        if (count($data['gst']) == 0) {
            $data['gst'] = $gst->data;
        }
        
        $nsprofile = $this->api_model->getNamespaceProfile(array('authtoken' => $this->_user_hash));
        $nspro = json_decode($nsprofile);
        $data['ns_profile'] = $nspro->data;
        $data['nsprofile'] = $nspro->data->namespaceProfile;

        $data['transactionMode'] = config_item('transaction_mode');
        $data['username'] = $this->session->userdata('user_name');

        $this->load->view('site/cargo/generate-invoice-v2', $data);
    }

    function get_invoice_list_v2() {
        $this->is_logged_in();

        $data = array(
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'vendorCode' => $this->input->post('vendorCode') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: $this->session->userdata('org_code')
        );

        $result = $this->api_model->getUnbilledLRList($data);
        $result = json_decode($result);
        $data['lrresult'] = $result->data;

        $list = array();
        foreach ($result->data as $row) {
            // $row->total_amount = $row->transaction_amount - $row->commission_amount;
            $row->totalItemCount = 0;
            $row->totalActualUnitValue = 0;
            foreach ($row->itemDetails as $item) {
                $row->totalItemCount += $item->itemCount;
                $row->totalActualUnitValue += $item->actualUnitValue;
            }
            $list[$row->vendorUser->name]['data'][] = $row;
            $list[$row->vendorUser->name]['vendor_code'] = $row->vendorUser->code ?: 'NA';
            $list[$row->vendorUser->name]['total'] += $row->totalAmount + $row->totalHandlingAmount;
        }
        $data['result'] = $list;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['article_unit'] = config_item('article_unit');

        $this->load->view('site/cargo/generate-invoice-list-v2', $data);
    }

    function pay_generated_invoice_v2() {
        $this->is_logged_in();

        $lrDetails = $this->input->post('lrDetails');
        $amount = $this->api_model->updateUnpaidLR($lrDetails);
        $amount = json_decode($amount);
        if ($amount->status != 1) {
            echo json_encode($amount);
            return;
        }

        $data = array(
            'activeFlag' => 1,
            'amountReceivedDate' => date('Y-m-d'),
            'remarks' => $this->input->post('remarks') ?: '',
            'transactionMode' => array('code' => $this->input->post('transactionMode')),
            'paymentHandledBy' => array('code' => $this->session->userdata('user_id')),
            'user' => $this->input->post('user'),
            'transactionCodes' => $this->input->post('transactionCodes'),
            'namespaceTax' => array('code' => $this->input->post('namespaceTax')),
            'vendorBillingAddress' => $this->input->post('vendorBillingAddress')
        );
        echo $this->api_model->generateInvoicePaymentv2($data);
        // $inv = $this->api_model->generateInvoicePaymentv2($data);
        // $invoice = json_decode($inv);

        // if ($invoice->status != 1) {
        //     echo json_encode($invoice);
        //     return;
        // }

        // $item_data = array();
        // $itemDetail = $this->input->post('itemDetailList');
        // foreach($itemDetail as $key=>$val){
        //     $val['paymentTransaction']->code = $invoice->data->code;
        //     array_push($item_data, $val);
        // }

        // echo $this->api_model->updateInvoiceExtraIncomeExpense($item_data);
    }

    public function update_start_odometer() {
        $this->is_logged_in();

        $odometer = $this->api_model->updateTransitOdometer(array(
            'action' => $this->input->post('action'),
            'transitCode' => $this->input->post('transitCode'),
            'transitCargo' => $this->input->post('transitCargo'),
            'fromOrganization' => $this->input->post('fromOrganization') ?: null,
            'fromOrganizationContact' => $this->input->post('fromOrganizationContact'),
            'startOdometer' => (int) $this->input->post('startOdometer'),
            'departureAt' => $this->input->post('departureAt'),
        ));

        $odometer = json_decode($odometer);
        if ($odometer->status == 0) {
            echo json_encode($odometer);
            return;
        }
        
        $ogpl = $this->input->post('ogpl')?: [];
        if ($ogpl) {
            $incomeexpense =  $this->api_model->updateTransitIncomeExpense($ogpl);
            $incomeexpense = json_decode($incomeexpense);
            if ($incomeexpense->status == 0) {
                echo json_encode($incomeexpense);
                return;
            }
        }
        
        $totalAmount = (float) $this->input->post('totalAmount');
        $litres = (float) $this->input->post('litres');
        if ($totalAmount > 0 && $litres > 0) {
            $fuelexpense =  $this->api_model->updateTransitFuelDetails(array(
                'code' => $this->input->post('fuelExpenseCode'),
                'activeFlag' => (int) $this->input->post('activeFlag'),
                'fuelDate' => $this->input->post('fuelDate'),
                'vehicle' => $this->input->post('vehicle'),
                'location' => '',
                'transitCargo' => $this->input->post('transitCargo'),
                'vendorContact' => $this->input->post('vendorContact'),
                'paymentBranch' => $this->input->post('fromOrganization')?: null,
                'litres' => $this->input->post('litres'),
                'pricePerLitre' => $this->input->post('pricePerLitre'),
                'totalAmount' => $this->input->post('totalAmount'),
                'evidenceNumber' => '',
                'billNumber' => $this->input->post('billNumber'),
                'transactionMode' => $this->input->post('transactionMode') ?: array('code' => 'CASH')
            ));
            $fuelexpense = json_decode($fuelexpense);
            if ($fuelexpense->status == 0) {
                echo json_encode($fuelexpense);
                return;
            }
        }

        echo json_encode($odometer);
    }

    public function update_end_odometer() {
        $this->is_logged_in();

        echo $this->api_model->updateTransitOdometer(array(
            'action' => $this->input->post('action'),
            'transitCode' => $this->input->post('transitCode'),
            'transitCargo' => $this->input->post('transitCargo'),
            'toOrganization' => $this->input->post('toOrganization') ?: null,
            'toOrganizationContact' => $this->input->post('toOrganizationContact'),
            'endOdometer' => (int) $this->input->post('endOdometer'),
            'arrivalAt' => $this->input->post('arrivalAt'),
        ));
    }
    public function empty_load_accept() {
        $this->is_logged_in();

        $load =  $this->api_model->OGPLV2EmptyUnload(array(
            'code' => $this->input->post('transitCode')
        ));
        $loaded = json_decode($load);

        if($loaded->status == 1){
            echo $this->api_model->updateTransitOdometer(array(
                'action' => $this->input->post('action'),
                'transitCode' => $this->input->post('transitCode'),
                'transitCargo' => $this->input->post('transitCargo'),
                'toOrganization' => $this->input->post('toOrganization') ?: null,
                'toOrganizationContact' => $this->input->post('toOrganizationContact'),
                'endOdometer' => (int) $this->input->post('endOdometer'),
                'arrivalAt' => $this->input->post('arrivalAt'),
            ));
        }else{
            echo $load;
        }
        // echo $this->api_model->updateTransitOdometer(array(
        //     'action' => $this->input->post('action'),
        //     'transitCode' => $this->input->post('transitCode'),
        //     'transitCargo' => $this->input->post('transitCargo'),
        //     'toOrganization' => $this->input->post('toOrganization') ?: null,
        //     'toOrganizationContact' => $this->input->post('toOrganizationContact'),
        //     'endOdometer' => (int) $this->input->post('endOdometer'),
        //     'arrivalAt' => $this->input->post('arrivalAt'),
        // ));
    }
    public function edit_odometer(){
            $access_call = false;
            $req_data=[];
            if($this->input->post('action') == "DEPARTURE"){
                $req_data=array('action' => $this->input->post('action'),
                'code' => $this->input->post('code'),
                'fromOrganizationContact' => $this->input->post('fromOrganizationContact'),
                'startOdometer' => $this->input->post('startOdometer'),
                'fromOrganization' => $this->input->post('fromOrganization'),
                'departureAt' => $this->input->post('departureAt'));
                $access_call =true;
            }else if($this->input->post('action') == "ARRIVAL"){
                $req_data=array('action' => $this->input->post('action'),
                'code' => $this->input->post('code'),
                'toOrganizationContact' => $this->input->post('fromOrganizationContact'),
                'endOdometer' => (int)$this->input->post('startOdometer'),
                'toOrganization' => $this->input->post('fromOrganization'),
                'departureAt' => $this->input->post('departureAt'));
             $access_call =true;
            }
            if($access_call){
                echo $response = $this->api_model->editTransitOdometer($this->input->post('transitCode'),$req_data);
            }else{
                echo json_encode(array('status' =>false,'errorDesc' =>'fill the all Valid fields'));
            }
    }
    function get_supervisor(){
        echo $to_supervisors = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->input->post('organizationCode'),
            'categoryCode' => $this->input->post('categoryCode')
        ));
    }
        
    function ogpl_fuel_expense() {
        $this->is_logged_in();

        $data = array(
            'transitCode' => $this->input->post('transitCode')
        );

        $result = $this->api_model->getTransitFuelDetails($data);
        $result = json_decode($result);
        $data['fuelExpensesData'] = $result->data;

        $totalFuelAmount = 0;
        foreach ($result->data as $row) {
            $totalFuelAmount += $row->totalAmount;
        }
        $data['totalFuelAmount'] = $totalFuelAmount;

        $vendors = $this->api_model->getContact(array(
            'entityTypeCode' => 'RAC'
        ));
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;
        
        $this->load->view('site/cargo/transit-fuel-expenses', $data);
    }

    public function update_ogpl_fuel_expense() {
        $this->is_logged_in();

        echo $this->api_model->updateTransitFuelDetails(array(
            'code' => $this->input->post('code'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'fuelDate' => $this->input->post('fuelDate'),
            'vehicle' => $this->input->post('vehicle'),
            'location' => $this->input->post('location'),
            'transitCargo' => $this->input->post('transitCargo'),
            'vendorContact' => $this->input->post('vendorContact'),
            'paymentBranch' => $this->input->post('paymentBranch')?:null,
            'litres' => $this->input->post('litres'),
            'pricePerLitre' => $this->input->post('pricePerLitre'),
            'totalAmount' => $this->input->post('totalAmount'),
            'evidenceNumber' => $this->input->post('evidenceNumber'),
            'billNumber' => $this->input->post('billNumber'),
            'transactionMode' => $this->input->post('transactionMode') ?: array('code' => 'CASH')
        ));
    }

    function ogpl_income_expense() {
        $this->is_logged_in();

        $data = array(
            'transitCode' => $this->input->post('transitCode')
        );

        $result = $this->api_model->getTransitIncomeExpense($data);
        $result = json_decode($result);
        $data['expensesData'] = $result->data;

        $triphead = $this->api_model->getCashbookHead();        
        $triphead = json_decode($triphead);
        $data['triphead'] = $triphead->data;

        $contact = $this->api_model->getContact();
        $contact = json_decode($contact);

        $con = array();
        foreach($contact->data as $key=>$val){
            $con[$val->contactCategory->name][$key] = $val;
            $con[$val->contactCategory->name][$key] = $val;
        }
        
        $data['contact'] = $con;

        $vehicleCode = $this->input->post('vehicleCode');
        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);

        $vehicle = array();
        foreach($vehicles->data as $key=>$val){
            if ($vehicleCode == $val->code) {
                $vehicle = $val;
            }
        }
        $data['vehicles'] = $vehicle;

        $bankdetail = $this->api_model->getOrganizationOtherDetails(array(
            'organizationcode' => $this->session->userdata('org_code')
        ));
        $bankdetail = json_decode($bankdetail);
        $data['bankdetail'] = $bankdetail->data->bankDetails;

        $cash_book_type = array();
        foreach ($data['expensesData'] as $key=>$val){
            // if($val->cashbookType->code == 'HIRING'){
                $cash_book_type[$val->cashbookType->code] = $val;
            // }
        }
        krsort($cash_book_type);

        $data['cashbookType'] = $cash_book_type;
        $data['ogplType'] = $this->input->post('ogplType');
        $data['cargoActivityType'] = $this->input->post('cargoActivityType');
        $data['bank_names_list'] = $this->config->item('bank_names_list');
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['cargo_setting'] = _get_cargo_settings();
        
        $this->load->view('site/cargo/transit-income-expenses', $data);
    }

    public function update_ogpl_income_expense() {
        $this->is_logged_in();
        
        $ogpl = $this->input->post('ogpl')?: [];

        echo $this->api_model->updateTransitIncomeExpense($ogpl);
    }

    function ogpl_odometer_report() {
        $this->is_logged_in();

        $transitCode = $this->input->post('transitCode');
        $type = '';
        if (!$transitCode) {
            $this->load->exclude_template();
            $transitCode = $this->input->get('transitCode');
            $type = $this->input->get('type');
        }

        $data = array(
            'transitCode' => $transitCode
        );

        $result = $this->api_model->getTransitOdometerDetails($data);
        $result = json_decode($result);
        $data['odoDetails'] = $result->data;

        $odometer = array();
        foreach($result->data as $row) {
            if (isNotNull($row->departureAt) && isNotNull($row->arrivalAt)) {
                $startDate = new DateTime($row->departureAt);
                $endDate = new DateTime($row->arrivalAt);
                $interval = $startDate->diff($endDate);
                $row->runningTime = $interval->format('%h:%i');
            }
            $odometer[$row->fromStation->name][$row->transitCargo->cargoActivityType->code][] = $row;
        }
        $data['odometer'] = $odometer;
        $data['type'] = $type;

        // $from_org_code=$data['odoDetails'][0]->fromOrganization->code;
        // $from_supervisors = $this->api_model->getAllBranchContact(array(
        //     'organizationCode' => $from_org_code,
        //     'categoryCode' => 'SPVSR'
        // ));
        // $from_supervisors = json_decode($from_supervisors);
        // $data['from_supervisors'] = $from_supervisors->data;

        // $to_org_code=$data['odoDetails'][0]->toOrganization->code;
        // $to_supervisors = $this->api_model->getAllBranchContact(array(
        //     'organizationCode' => $to_org_code,
        //     'categoryCode' => 'SPVSR'
        // ));
        // $to_supervisors = json_decode($to_supervisors);
        // $data['to_supervisors'] = $to_supervisors->data;
        $this->load->view('site/cargo/transit-odometer-details', $data);
    }
    
    function user_commission() {
        $this->is_logged_in();

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $users = $users->data;

        $usrbranch = array();
        foreach ($users as $row) {
            $usrbranch[$row->organization->name][] = $row;
        }
        ksort($usrbranch);
        $data['branchusers'] = $usrbranch;

        $this->load->view('site/cargo/user-commission', $data);
    }

    function user_commission_list() {
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQI9L7N4',
            'userCode' => $this->input->post('userCode') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        usort($result->data, function($a, $b) {
            if (trim($a->user_group_name) == trim($b->user_group_name)) {
                return strnatcasecmp(trim($a->first_name), trim($b->first_name));
            }
            return strnatcasecmp(trim($a->user_group_name), trim($b->user_group_name));
        });
        $data['result'] = $result->data;

        $data['cargo_setting'] = _get_cargo_settings();

        if ($this->input->post('export') == 1) {
            $filename = 'User-Commission-Report';
            $this->load->excel('site/cargo/user-commission-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/user-commission-list', $data);
        }
    }

    function agent_collection_booked_report() {
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $data['users'] = $users->data;

        $this->load->view('site/cargo/agent-collection-booked-report', $data);
    }

    function agent_collection_booked_report_list() {
        $this->is_logged_in();
        $collection_type = $this->input->post('filterType');
        $param = array(
            'queryCode' => 'RQJAJAS13',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'transitOrganizationCode' => $this->input->post('transitOrganizationCode') ?: 'NA',
            'dateType' => 'BOOKED_DATE'
        );

        if (!has_action_rights('AGTB-COLL-ALL-BRANCH')) {
            $param['transitOrganizationCode'] = $this->session->userdata('org_code');
        }

        $collection_type_list = ($collection_type == 'NA') ? ['BOOK', 'TRANSIT'] : array($collection_type);

        $allUserCommissions = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQI9L7N4',
            'userCode' => $this->input->post('userCode') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
        ));
        $allUserCommissions = json_decode($allUserCommissions);
        $userCommissions = $this->process_user_commissions($allUserCommissions->data);

        $data = array();
        foreach($collection_type_list as $filter) {
            $param['filterType'] = $filter;
            $result = $this->api_model->getDynamicReportDataWithMap($param);
            $result = json_decode($result);

            $processed = $this->process_agent_collection($result, $filter, $userCommissions);
            $data = array_merge_recursive($data, $processed);
        }

        $userCode = $this->input->post('userCode');
        if (!has_action_rights('AGTB-COLL-ALL-BRANCH')) {
            $userCode = $this->session->userdata('user_id');
        }
        if($userCode) {
            $userComm = $this->api_model->cargoUserCommissions(array(
                'userCode' => $userCode
            ));
            $userComm = json_decode($userComm);
            $data['userComm'] = $userComm->data;
        }

        $data['branchName'] = $this->input->post('orgname');
        $data['userName'] = $this->input->post('username');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['agent_collection_filtertype'] = $this->config->item('agent_collection_filtertype');

        if ($this->input->post('export') == 1) {
            $fl = ($this->input->post('filterType') == 'BOOK') ? 'BOOKING' : 'DELIVERY';
            $fdate = date('d F Y', strtotime($this->input->post('fromDate')));
            $tdate = date('d F Y', strtotime($this->input->post('toDate')));
            $filename = 'AGENT-COLLECTION-BOOKED-'.$fl.'-'.$this->input->post('orgname').'-'.$fdate.' - '.$tdate;
            $this->load->excel('site/cargo/agent-collection-booked-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/agent-collection-booked-report-list', $data);
        }
    }

    function agent_collection_loaded_report() {
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $data['users'] = $users->data;

        $this->load->view('site/cargo/agent-collection-loaded-report', $data);
    }

    function agent_collection_loaded_report_list() {
        $this->is_logged_in();
        $collection_type = $this->input->post('filterType');
        $param = array(
            'queryCode' => 'RQJAJAS13',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'transitOrganizationCode' => $this->input->post('transitOrganizationCode') ?: 'NA',
            'dateType' => 'LOADED_DATE'
        );

        if (!has_action_rights('AGTL-COLL-ALL-BRANCH')) {
            $param['transitOrganizationCode'] = $this->session->userdata('org_code');
        }

        $collection_type_list = ($collection_type == 'NA') ? ['BOOK', 'TRANSIT'] : array($collection_type);

        $allUserCommissions = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQI9L7N4',
            'userCode' => $this->input->post('userCode') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
        ));
        $allUserCommissions = json_decode($allUserCommissions);
        $userCommissions = $this->process_user_commissions($allUserCommissions->data);

        $data = array();
        foreach($collection_type_list as $filter) {
            $param['filterType'] = $filter;
            $result = $this->api_model->getDynamicReportDataWithMap($param);
            $result = json_decode($result);

            $processed = $this->process_agent_collection($result, $filter, $userCommissions);
            $data = array_merge_recursive($data, $processed);
        }

        $userCode = $this->input->post('userCode');
        if (!has_action_rights('AGTL-COLL-ALL-BRANCH')) {
            $userCode = $this->session->userdata('user_id');
        }
        if($userCode) {
            $userComm = $this->api_model->cargoUserCommissions(array(
                'userCode' => $userCode
            ));
            $userComm = json_decode($userComm);
            $data['userComm'] = $userComm->data;
        }

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['agent_collection_filtertype'] = $this->config->item('agent_collection_filtertype');

        if ($this->input->post('export') == 1) {
            $fl = ($this->input->post('filterType') == 'BOOK') ? 'BOOKING' : 'DELIVERY';
            $fdate = date('d F Y', strtotime($this->input->post('fromDate')));
            $tdate = date('d F Y', strtotime($this->input->post('toDate')));
            $filename = 'AGENT-COLLECTION-LOADED-'.$fl.'-'.$this->input->post('orgname').'-'.$fdate.' - '.$tdate;
            $this->load->excel('site/cargo/agent-collection-loaded-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/agent-collection-loaded-report-list', $data);
        }
    }

    function agent_collection_unloaded_report() {
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $data['users'] = $users->data;

        $this->load->view('site/cargo/agent-collection-unloaded-report', $data);
    }

    function agent_collection_unloaded_report_list() {
        $this->is_logged_in();
        $collection_type = $this->input->post('filterType');
        $param = array(
            'queryCode' => 'RQJAJAS13',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'transitOrganizationCode' => $this->input->post('transitOrganizationCode') ?: 'NA',
            'dateType' => 'UNLOADED_DATE'
        );

        if (!has_action_rights('AGTU-COLL-ALL-BRANCH')) {
            $param['transitOrganizationCode'] = $this->session->userdata('org_code');
        }

        $collection_type_list = ($collection_type == 'NA') ? ['BOOK', 'TRANSIT'] : array($collection_type);

        $allUserCommissions = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQI9L7N4',
            'userCode' => $this->input->post('userCode') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
        ));
        $allUserCommissions = json_decode($allUserCommissions);
        $userCommissions = $this->process_user_commissions($allUserCommissions->data);

        $data = array();
        foreach($collection_type_list as $filter) {
            $param['filterType'] = $filter;
            $result = $this->api_model->getDynamicReportDataWithMap($param);
            $result = json_decode($result);

            $processed = $this->process_agent_collection($result, $filter, $userCommissions);
            $data = array_merge_recursive($data, $processed);
        }

        $userCode = $this->input->post('userCode');
        if (!has_action_rights('AGTU-COLL-ALL-BRANCH')) {
            $userCode = $this->session->userdata('user_id');
        }
        if($userCode) {
            $userComm = $this->api_model->cargoUserCommissions(array(
                'userCode' => $userCode
            ));
            $userComm = json_decode($userComm);
            $data['userComm'] = $userComm->data;
        }

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['agent_collection_filtertype'] = $this->config->item('agent_collection_filtertype');

        if ($this->input->post('export') == 1) {
            $fl = ($this->input->post('filterType') == 'BOOK') ? 'BOOKING' : 'DELIVERY';
            $fdate = date('d F Y', strtotime($this->input->post('fromDate')));
            $tdate = date('d F Y', strtotime($this->input->post('toDate')));
            $filename = 'AGENT-COLLECTION-UNLOADED-'.$fl.'-'.$this->input->post('orgname').'-'.$fdate.' - '.$tdate;
            $this->load->excel('site/cargo/agent-collection-unloaded-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/agent-collection-unloaded-report-list', $data);
        }
    }

    function agent_collection_delivered_report() {
        $this->is_logged_in();

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $data['users'] = $users->data;

        $this->load->view('site/cargo/agent-collection-delivered-report', $data);
    }

    function agent_collection_delivered_report_list() {
        $this->is_logged_in();
        $collection_type = $this->input->post('filterType');
        $param = array(
            'queryCode' => 'RQJAJAS13',
            'fromDate' => date('Y-m-d', strtotime($this->input->post('fromDate'))),
            'toDate' => date('Y-m-d', strtotime($this->input->post('toDate'))),
            'transitOrganizationCode' => $this->input->post('transitOrganizationCode') ?: 'NA',
            'dateType' => 'DELIVERED_DATE'
        );

        if (!has_action_rights('AGTD-COLL-ALL-BRANCH')) {
            $param['transitOrganizationCode'] = $this->session->userdata('org_code');
        }

        $collection_type_list = ($collection_type == 'NA') ? ['BOOK', 'TRANSIT'] : array($collection_type);

        $allUserCommissions = $this->api_model->getDynamicReportDataWithMap(array(
            'queryCode' => 'RQI9L7N4',
            'userCode' => $this->input->post('userCode') ?: 'NA',
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
        ));
        $allUserCommissions = json_decode($allUserCommissions);
        $userCommissions = $this->process_user_commissions($allUserCommissions->data);

        $data = array();
        foreach($collection_type_list as $filter) {
            $param['filterType'] = $filter;
            $result = $this->api_model->getDynamicReportDataWithMap($param);
            $result = json_decode($result);

            $processed = $this->process_agent_collection($result, $filter, $userCommissions);
            $data = array_merge_recursive($data, $processed);
        }

        $userCode = $this->input->post('userCode');
        if (!has_action_rights('AGTD-COLL-ALL-BRANCH')) {
            $userCode = $this->session->userdata('user_id');
        }
        if($userCode) {
            $userComm = $this->api_model->cargoUserCommissions(array(
                'userCode' => $userCode
            ));
            $userComm = json_decode($userComm);
            $data['userComm'] = $userComm->data;
        }

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['agent_collection_filtertype'] = $this->config->item('agent_collection_filtertype');

        if ($this->input->post('export') == 1) {
            $fl = ($this->input->post('filterType') == 'BOOK') ? 'BOOKING' : 'DELIVERY';
            $fl = ['BOOK' => 'BOOKING', 'TRANSIT' => 'DELIVERY', 'NA' => 'ALL'][$this->input->post('filterType') == 'BOOK'];

            $fdate = date('d F Y', strtotime($this->input->post('fromDate')));
            $tdate = date('d F Y', strtotime($this->input->post('toDate')));
            $filename = 'AGENT-COLLECTION-DELIVERED-'.$fl.'-'.$this->input->post('orgname').'-'.$fdate.' - '.$tdate;
            $this->load->excel('site/cargo/agent-collection-delivered-report-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/agent-collection-delivered-report-list', $data);
        }
    }
    
    // Developed for Jabbar Logistics
    // https://github.com/JavakarBits/Cargo/issues/207
    public function branch_sales_summary() {
        $this->is_logged_in();
        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['zone'] = $zone->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $all_zone_stations = array();
        foreach($zone->data as $key=>$zones) {
            foreach($zones->stations as $k=>$station) {
                $all_zone_stations[] = $station->code;
            }
        }
        
        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);

        $organization = array();
        foreach ($branches->data as $key=>$branch) {
            if (in_array($branch->station->code, $all_zone_stations)) {
                $organization[] = $branch;
            }
        }

        usort($organization, function ($a, $b) {
            return strcasecmp($a->name,  $b->name);
        });
        $data['organization'] = $organization;
        
        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['branches'] = $branches->data;
        $data['paystatus'] = config_item('cargo_payment_status');

        $this->load->view('site/cargo/branch-sales-summary', $data);
    }

    public function branch_sales_summary_list(){
        $this->is_logged_in();
        
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        $data = array(
            'queryCode' => 'RQL3U0474',
            'fromDate' => $from_date ?: 'NA',
            'toDate' => $to_date ?: 'NA',  
            'zoneCode' => $this->input->post('zoneCode'),
            'stationCode' => $this->input->post('stationCode'),
            'organizationCode' => $this->input->post('organizationCode')
        );
        

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $list = array();
        foreach ($result->data as $row) {
            $list[$row->booked_at][$row->from_organization_code]['booked_at'] =$row->booked_at;
            $list[$row->booked_at][$row->from_organization_code]['pickup_handling_amount'] += $row->pickup_handling_amount;
            $list[$row->booked_at][$row->from_organization_code]['delivery_handling_amount'] += $row->delivery_handling_amount;
            $list[$row->booked_at][$row->from_organization_code]['total_amount'] += $row->total_amount;
           
            $list[$row->booked_at][$row->from_organization_code]['total_handling_amount'] += $row->total_handling_amount;
            $list[$row->booked_at][$row->from_organization_code]['total_unload_handling_amount'] += $row->total_unload_handling_amount;
            $list[$row->booked_at][$row->from_organization_code]['total_amount_paid'] += $row->total_amount_paid;
            $list[$row->booked_at][$row->from_organization_code]['other_charges_amount'] += $row->other_charges_amount;
            $list[$row->booked_at][$row->from_organization_code]['service_tax'] += $row->service_tax;
            $list[$row->booked_at][$row->from_organization_code]['service_charge'] += $row->service_charge;
            $list[$row->booked_at][$row->from_organization_code]['hamali_charge'] += $row->hamali_charge;
            $list[$row->booked_at][$row->from_organization_code]['pass_charge'] += $row->pass_charge;
            $list[$row->booked_at][$row->from_organization_code]['docket_charge'] += $row->docket_charge;
            $list[$row->booked_at][$row->from_organization_code]['cargo_count'] += $row->cargo_count;
            $list[$row->booked_at][$row->from_organization_code]['total_item_count'] += $row->total_item_count;
            $list[$row->booked_at][$row->from_organization_code]['from_organization_name'] = $row->from_organization_name;
            $list[$row->booked_at][$row->from_organization_code]['round_off_value'] +=$row->round_off_value;
            // $list[$row->booked_at][$row->booked_at]['from_organization_name_count'] += count($row->from_organization_name);
            $cgst = $row->cgst > 0 ? $row->service_tax / 2 : 0;
            $sgst = $row->sgst > 0 ? $row->service_tax / 2 : 0;
            $ugst = $row->ugst > 0 ? $row->service_tax / 2 : 0;
            $igst = $row->igst > 0 ? $row->service_tax : 0;

            $net_amount = $row->total_amount + $row->pass_charge + $row->total_handling_amount + $row->total_unload_handling_amount + $row->other_charges_amount;
            $net_total_amount = $net_amount + $cgst + $sgst + $ugst + $igst;
            $list[$row->booked_at][$row->from_organization_code]['cgst'] += $cgst;
            $list[$row->booked_at][$row->from_organization_code]['sgst'] += $sgst;
            $list[$row->booked_at][$row->from_organization_code]['ugst'] += $ugst;
            $list[$row->booked_at][$row->from_organization_code]['igst'] += $igst;
            $list[$row->booked_at][$row->from_organization_code]['net_amount'] += $net_amount;
            $list[$row->booked_at][$row->from_organization_code]['net_total_amount'] += $net_total_amount;
            $list[$row->booked_at][$row->from_organization_code][$row->payment_status] += $net_amount - $row->pass_charge;
        }

        ksort($list);
        
        $data['result'] = $list;
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['from'] =$from_date;
        $data['to']=$to_date;
        
        if ($this->input->post('export') == 1) {
            $filename = 'Branch-Sales-Summary';
            $this->load->excel('site/cargo/branch-sales-summary-list-xls', $data, $filename);
        } else {
            $this->load->view('site/cargo/branch-sales-summary-list',$data);
        }
    }

    public function get_gst_details_hint() {
        $this->is_logged_in();

        $res = $this->api_model->getGSTDetailsApi(array(
            'gstin' => $this->input->post('gstin')
        ));
        $res = json_decode($res);

        $data = array();
        $data['data'] = $res;

        $data['gstin_status'] = config_item('gstin_status');
        $data['gstin_block_status'] = config_item('gstin_block_status');
        $data['gstin_taxpayer_type'] = config_item('gstin_taxpayer_type');

        $this->load->view('site/cargo/gst-details-hint', $data);
    }

    public function get_ewaybill_details() {
        $this->is_logged_in();

        $ewayBillNo = $this->input->post('ewayBillNo');

        $res = $this->api_model->getEwayBillDetails(array('ewayBillNo' => $ewayBillNo));
        $res = json_decode($res);

        $data = array();
        $data['data'] = $res;

        $data['ewaybill_supply_type'] = config_item('ewaybill_supply_type');
        $data['ewaybill_sub_supply_type'] = config_item('ewaybill_sub_supply_type');
        $data['ewaybill_document_type'] = config_item('ewaybill_document_type');
        $data['ewaybill_transportation_mode'] = config_item('ewaybill_transportation_mode');
        $data['ewaybill_transaction_type'] = config_item('ewaybill_transaction_type');

        $this->load->view('site/cargo/ewaybill-details-hint', $data);
    }

    public function get_ewaybill_data() {
        $this->is_logged_in();

        echo $this->api_model->getEwayBillDetails(array(
            'ewayBillNo' => $this->input->post('ewayBillNo')
        ));
    }

    public function get_organization_other_details() {
        $this->is_logged_in();

        echo $this->api_model->getOrganizationOtherDetails(array(
            'organizationcode' => $this->input->post('organizationcode')
        ));
    }

    public function get_vehicle_transit_details() {
        $this->is_logged_in();

        $vehicleCode = $this->input->post('vehicleCode');
        $ogplList = $this->api_model->searchOGPLV2(array(
            'tripDate' => $this->input->post('tripDate'),
            'vehicleCode' => $vehicleCode,
            'transitType' => 'TRNT'
        ));
        $ogplList = json_decode($ogplList);

        if ($ogplList->status != 1) {
            echo json_encode($ogplList);
            return;
        }

        $data['ogplList'] = array();
        foreach ($ogplList->data as $transit) {
            if ($transit->cargoActivityType->code == 'TRNT' && $transit->transitStatus->code == 'CMPLT') { 
                $data['ogplList'][] = $transit;
            }
        }

        echo json_encode(array(
            'status' => 1,
            'data' => $data['ogplList']
        ));
    }

    public function delivery_acknowledgement() {
        $this->is_logged_in();

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        $vehicles = $this->api_model->getVehicle();
        $vehicles = json_decode($vehicles);
        $data['vehicles'] = $vehicles->data;

        $drivers = $this->api_model->getVehicleDriver();
        $drivers = json_decode($drivers);
        $data['drivers'] = $drivers->data;
        
        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $data['users'] = $users->data;
        
        $this->load->view('site/cargo/delivery-acknowledgement', $data);
    }

    public function delivery_acknowledgement_list() {
        $this->is_logged_in();

        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
        $fromDate = date('Y-m-d', strtotime($fromDate));
        $toDate = date('Y-m-d', strtotime($toDate));

        $data = array(
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'fromOrganizationCode' => $this->input->post('fromOrganizationCode'),
            'toOrganizationCode' => $this->input->post('toOrganizationCode'),
            'statusCode' => $this->input->post('statusCode')
        );
        
        $result = $this->api_model->getAllDeliveryAcknowledgement($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['delivery_acknowledgement_status'] = config_item('delivery_acknowledgement_status');

        $this->load->view('site/cargo/delivery-acknowledgement-list', $data);
    }

    public function get_delivery_acknowledgement_lr() {
        $this->is_logged_in();

        $data = array(
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'organizationCode' => $this->input->post('organizationCode')
        );
        
        $result = $this->api_model->getAllDeliveryAcknowledgementLr($data);
        $result = json_decode($result);
        $result = array_filter($result->data, function($a) { return $a->paymentType->code == 'INP' || $a->paymentType->code == 'OATP'; });
        $data['result'] = $result;

        $this->load->view('site/cargo/delivery-acknowledgement-Lr-list', $data);
    }

    function get_branch_supervisor() {
        $this->is_logged_in();
        
        echo $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->input->post('organizationCode'),
            'categoryCode' => 'SPVSR'
        ));
    }

    public function update_delivery_acknowledgement() {
        $this->is_logged_in();

        echo $this->api_model->updateDeliveryAcknowledgement(array(
            'code' => $this->input->post('code'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'vehicle' => $this->input->post('vehicle'),
            'fromOrganization' => $this->input->post('fromOrganization'),
            'toOrganization' => $this->input->post('toOrganization'),
            'supervisor' => $this->input->post('supervisor'),
            'transactionDate' => $this->input->post('transactionDate'),
            'driver' => $this->input->post('driver'),
            'cargoList' => $this->input->post('cargoList'),
            'remarks' => $this->input->post('remarks')
        ));
    }

    public function update_delivery_acknowledgement_status() {
        $this->is_logged_in();
        $receivedAt = $this->input->post('receivedAt') ? date('Y-m-d H:i', strtotime($this->input->post('receivedAt'))) : null;

        echo $this->api_model->updateDeliveryAcknowledgementStatus(array(
            'code' => $this->input->post('code'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'status' => $this->input->post('status'),
            'receivedAt' => $receivedAt,
        ));
    }

    public function validate_transit_linking() {
        $this->is_logged_in();

        echo $this->api_model->validateTransitLinking(array(
            'transitCode' => $this->input->post('linkTransitCode')
        ));
    }

    public function customer_invoice_acknowledgement() {
        $this->is_logged_in();

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        $vendors = $this->api_model->cargoCustomerVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;
        
        $supervisor =  $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $supervisor = json_decode($supervisor);
        $data['supervisor'] = $supervisor->data;

        $data['invoice_acknowledgement_status'] = config_item('invoice_acknowledgement_status');

        $this->load->view('site/cargo/customer-invoice-acknowledgement', $data);
    }

    public function customer_invoice_acknowledgement_list() {
        $this->is_logged_in();
        
        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
        $fromDate = date('Y-m-d', strtotime($fromDate));
        $toDate = date('Y-m-d', strtotime($toDate));

        $data = array(
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'vendorCode' => $this->input->post('vendorCode'),
            'organizationCode' => $this->input->post('organizationCode'),
            'statusCode' => $this->input->post('statusCode')
        );
        
        $result = $this->api_model->getAllInvoiceAcknowledgement($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        // $data['invoice_acknowledgement_status'] = config_item('invoice_acknowledgement_status');

        $this->load->view('site/cargo/customer-invoice-acknowledgement-list', $data);
    }

    public function get_customer_invoice_acknowledgement_unpaid_invoice() {
        $this->is_logged_in();

        $data = array(
            'vendorCode' => $this->input->post('vendorCode'),
            'organizationCode' => 'NA'
        );
        
        $result = $this->api_model->getAllInvoiceAcknowledgementUnpaidInvoice($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $this->load->view('site/cargo/customer-invoice-acknowledgement-unpaid-invoice-list', $data);
    }

    public function update_customer_invoice_acknowledgement() {
        $this->is_logged_in();

        echo $this->api_model->updateInvoiceAcknowledgement(array(
            'code' => $this->input->post('code'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'name' => $this->input->post('name'),
            'vendor' => $this->input->post('vendor'),
            'organization' => array('code' => $this->session->userdata('org_code')),
            'supervisor' => $this->input->post('supervisor'),
            'transactionDate' => $this->input->post('transactionDate'),
            'communicationMedium' => $this->input->post('communicationMedium'),
            'invoiceList' => $this->input->post('invoiceList'),
            'remarks' => $this->input->post('remarks')
        ));
    }

    public function update_customer_invoice_acknowledgement_status() {
        $this->is_logged_in();

        echo $this->api_model->updateInvoiceAcknowledgementStatus(array(
            'code' => $this->input->post('code'),
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'status' => $this->input->post('status'),
            'completedAt' => date('Y-m-d H:i', strtotime($this->input->post('completedAt'))),
            'submittedAt' => date('Y-m-d H:i', strtotime($this->input->post('submittedAt'))),
            'addAttr1' => $this->input->post('addAttr1'),
            'remarks' => $this->input->post('remarks')
        ));
    }

    function get_customers_by_reference() {
        $this->is_logged_in();

        $customers = $this->api_model->getCustomersByReference(array(
            'mobileNumber' => $this->input->post('mobileNumber') ?: 'NA',
            'customerName' => $this->input->post('customerName') ?: 'NA',
            'gstin' => $this->input->post('gstin') ?: 'NA',
        ));
        $customers = json_decode($customers);

        $data = [];
        foreach ($customers->data as $customer) {
            $data[] = array(
                'code' => $customer->c,
                'name' => $customer->n,
                'mobileNumber' => $customer->m,
                'gstin' => $customer->g,
                'role' => $customer->rc,
                'companyName' => $customer->cn,
                'email' => $customer->em
            );
        }

        $customers->data = $data;

        echo json_encode($customers);
    }

    public function edit_lr_booked_date() {
        $this->is_logged_in();

        echo $this->api_model->updateCargoBookingDate(array(
            'code' => $this->input->post('code'),
            'bookedAt' => $this->input->post('bookedAt'),
            'remarks' => $this->input->post('remarks') ?: []
        ));
    }

    public function update_cargo_charges() {
        $this->is_logged_in();

        echo $this->api_model->addCargoDeliveryCharges(array(
            'code' => $this->input->post('code'),
            'additionalAttribute' => $this->input->post('additionalAttribute') ?: (object) [],
            'remarks' => $this->input->post('remarks') ?: []
        ));
    }

    public function delivery_follow_up() {
        $this->is_logged_in();
        
        $result = $this->api_model->getLRRemarks(array(
            'cargoCode' => $this->input->post('cargoCode')
        ));
        $result = json_decode($result);
        $data['followup'] = array_reverse($result->data);

        $this->load->view('site/cargo/delivery-follow-up', $data);
    }
    
    public function start_transit_odometer() {
        $this->is_logged_in();
        $data = array();
        
        $transitCode = $this->input->post('transitCode');
        $fromOrganizationCode = $this->input->post('transitFromOrganizationCode');
        if ($transitCode) {
            $odoDetails = $this->api_model->getTransitOdometer(array(
                'transitCode' => $transitCode
            ));
            $odoDetails = json_decode($odoDetails);
            foreach ($odoDetails->data as $row) {
                if ($row->organization->code == $fromOrganizationCode) {
                    $data['odoDetails'] = $row;
                }
            }
        }
        //out station ogpl list odometer by vehicle

        
        $new_vehicle = $this->api_model->get_vehicle_details($this->input->post('vehicleCode'));
        $new_vehicle = json_decode($new_vehicle);
        $new_vehicle = $new_vehicle->data;
        $data['vehicle'] = $new_vehicle;
        
        $branchContact = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $branchContact = json_decode($branchContact);
        $data['branchContact'] = $branchContact->data;

        $contact = $this->api_model->getContact();
        $contact = json_decode($contact);
        $data['vendors'] = $contact->data;

        $contactGrouped = array();
        foreach($contact->data as $row){
            $contactGrouped[$val->contactCategory->name][] = $row;
            $contactGrouped[$val->contactCategory->name][] = $row;
        }
        $data['contact'] = $contactGrouped;

        $data['f_t_mode'] = config_item('transaction_mode');
        $data['login_branch'] = $this->session->userdata('org_code');
        $data['transit_code'] = $this->input->post('transitCode');
        $data['vehicle_code'] = $this->input->post('vehicleCode');
        $data['namespace'] = $this->session->userdata('namespace_id');

        $this->load->view('site/cargo/start-transit-odometer', $data);
    }

    public function end_transit_odometer() {
        $this->is_logged_in();

        $data = array();
        $data['login_branch'] = $this->session->userdata('org_code');
        
        $transitCode = $this->input->post('transitCode');
        if ($transitCode) {
            $odoDetails = $this->api_model->getTransitOdometer(array(
                'transitCode' => $transitCode
            ));
            $odoDetails = json_decode($odoDetails);
            foreach ($odoDetails->data as $row) {
                if ($row->organization->code == $data['login_branch']) {
                    $data['odoDetails'] = $row;
                }
            }
        }

       

        $new_vehicle = $this->api_model->get_vehicle_details($this->input->post('vehicleCode'));
        $new_vehicle = json_decode($new_vehicle);
        $new_vehicle = $new_vehicle->data;
        $data['vehicle'] = $new_vehicle;
        
        $branchContact = $this->api_model->getAllBranchContact(array(
            'organizationCode' => $this->session->userdata('org_code'),
            'categoryCode' => 'SPVSR'
        ));
        $branchContact = json_decode($branchContact);
        $data['branchContact'] = $branchContact->data;

        $data['transit_code'] = $this->input->post('transitCode');
        $data['vehicle_code'] = $this->input->post('vehicleCode');
        $data['transit_to_organization'] = $this->input->post('transitToOrganizationCode');
        $this->load->view('site/cargo/end-transit-odometer', $data);
    }

    public function edit_save_privatemark() {
        $this->is_logged_in();
    
        $param = array(
            'code' =>  $this->input->post('code'),
            'additionalAttribute' =>  array('PRIVATE_MARK_NUMBER' =>  $this->input->post('privatemark')),
        );
        echo $this->api_model->updatePrivatemark($param);
    }

    public function balance_sheet() {
        $data = $this->api_model->balance_report();
        $result['data'] = $data;
        $this->load->view('site/cargo/balance-sheet-list', $result);
    }
    
    public function balance_sheet_list() {
        $this->is_logged_in();
        $id = $this->input->post('ven_id');
        $data = $this->api_model->balance_report();
        
        $report['data'] = $this->generate_vendor_uniq_report($id);

        $this->load->exclude_template();
        $filename="RAC-$id-SUMMARY";
        $this->load->excel('site/cargo/balance-sheet-report-xls', $report, $filename);
    }

    public function generate_vendor_uniq_report($con) {
        $data = $this->api_model->balance_report();
        $report = array();
        $payment_details = array();
        $booking_details = array();
    
        foreach ($data as $item) {
            if ($con == $item['ven_unq']) {
                $report[] = $item;
    
                foreach ($item['payment_details'] as $paymentArray) {
                    if ($paymentArray['parent_id'] == $con) {
                        $payment_details[] = $paymentArray;
                    }
                }
                $report[count($report) - 1]['payment_details'] = $payment_details;
                // $report[count($report) - 1]['payment_details'] = $payment_details;

                foreach ($item['booking_details'] as $bookingArray) {
                    if ($bookingArray['parent_id'] == $con) {
                        $booking_details[] = $bookingArray;
                    }
                }
                $report[count($report) - 1]['booking_details'] = $booking_details;
            }
        }
        return $report;
    }

    public function update_specialbooking() {
        $data = file_get_contents('php://input');

        $result=$this->api_model->special_booking_update($data);
        $responseJson = json_decode($result);
        echo $responseJson->status;
    }
    public function get_vehicle_detail(){
        $vehicleCode=$this->input->post('vehicleCode');
        if(!$vehicleCode || $vehicleCode == "" || $vehicleCode == null){
            response(true,'invalid vehicle code',[]);
            exit;
        }
        echo $new_vehicle = $this->api_model->get_vehicle_details($vehicleCode);
        // echo getData($new_vehicle);
    }

    public function delivery_acknowledgement_print(){
        $this->is_logged_in();
        $result = $this->api_model->getAcknowledgementDetails(array('code' => $this->input->get('Code')));
        $result = json_decode($result);
        $data['result'] = $result->data;
        $ftext .= "<b>Printed By: " . $this->session->userdata('user_name') . "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Printed At: " . date("d-m-Y H:i:sa")."</b>";
        require_once APPPATH . 'libraries/seenutransport-lib-tcpdf.php';
        $pdf = new seenuPdf();
        $pdf->SetTitle('Delivery Acknowledgement');
        $pdf->SetFont('helvetica', '', 8);
        $pdf->setCustomFooterText($ftext); 
        $pdf->AddPage();
        ob_clean();
        $this->load->exclude_template();
        $content = $this->load->view('site/cargo/delivery-acknowledgement-print-seenutransport', $data, true);
        $pdf->writeHTML($content);
        $pdf->Output('delivery-acknowledgement.pdf', 'I');
    }

    public function  branch_stack_report_godown_seenutransport(){
        $this->is_logged_in();

        $organization = $this->input->post('transitOrganizationCode');
        if(in_array('NA', $organization)) {
            $organization = 'NA';
        } else {
            $organization = implode(',', $organization);
        }

        $stationCode = $this->input->post('stationCode');
        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        $from_date = date('Y-m-d', strtotime($fromDate));
        $to_date = date('Y-m-d', strtotime($toDate));
        $cargoStatusCode = $this->input->post('cargoStatusCode');

        if (!has_action_rights('BSR-ALL-BRNC')) {
            $organization = $this->session->userdata('org_code');
        }
        
        if (!has_action_rights('BSR-ALL-STION')) {
            $stationCode = $this->session->userdata('org_station_code');
        }

        $data = array(
            'queryCode' => 'RQJ8ODQ52',
            'fromDate' => $from_date,
            'toDate' => $to_date,
            'organizationCode' => $organization,
            'transitOrganizationCode' => 'NA',
            'cargoStatusCode' => $cargoStatusCode,
            'stationCode' => $stationCode,
            'filterType' => 'DETAILS',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] =$result->data;
        $data['fromDate'] =$from_date;
        $data['toDate'] =$to_date;
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $this->load->exclude_template();
        $this->load->view('site/report/branch-stack-report-godown-seenutransport', $data);
    }
    public function get_vendors_list(){
        if (has_action_rights('CARGO-ONBEHALF-BOOKING')) {
            $vendors = $this->api_model->cargoCustomerVendorByBranch(array('organizationCode' => $this->session->userdata('org_code')));
        } else {
            $vendors = $this->api_model->cargoCustomerVendor();
        }
        $vendors = json_decode($vendors);
        echo json_encode($vendors->data);
    }

    public function get_ogpl_code(){
        $this->is_logged_in();
        $transitDetailCode =$this->input->post('transitDetailsCodes');

        $transitcode = $this->api_model->cargoOGPLTransitDetail(array(
            'transitDetailCode' => $transitDetailCode
        ));
        $transitcode = json_decode($transitcode);
        echo json_encode($transitcode->data);
    }

}
