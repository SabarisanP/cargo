<?php

if (!defined('BASEPATH'))    exit('No direct script access allowed');

class Import extends MY_Controller {
    function __construct() {
        parent::__construct();
    }
	
    public function index() {
        $this->is_logged_in();
        
        $this->load->view('site/import/index', []);
    }

    public function process_excel_data() {
        $this->is_logged_in();
        $rows = $this->input->post('rows');
        $rows = json_decode($rows, true);

        $import_fields_map = $this->config->item('import_fields_map_citytravels');
        $column_names = array_keys($rows[0]);
        $data['userHeader'] =$column_names;
        $import_fields_map['v_lrno'] = $column_names[1];
        $import_fields_map['v_booked_date'] = $column_names[2];
        $import_fields_map['v_unloaded_date'] = $column_names[3];
        $import_fields_map['v_from_station'] = $column_names[4];
        $import_fields_map['v_to_station'] = $column_names[5];
        $import_fields_map['v_sender_name'] = $column_names[6];
        $import_fields_map['v_receiver_name'] = $column_names[7];
        $import_fields_map['v_article_count'] = $column_names[8];
        $import_fields_map['v_actual_weight'] = $column_names[9];
        $import_fields_map['v_total_freight'] = $column_names[10];
        $import_fields_map['v_payment_type'] = $column_names[11];
        $import_fields_map['v_invoice_value'] = $column_names[12];
        if($column_names[14] =="Remarks"){
            $import_fields_map['v_articles'] = $column_names[13];
            $import_fields_map['v_remarks'] = $column_names[14];
        }else{
            $import_fields_map['v_door_pickup'] = $column_names[13];
            $import_fields_map['v_door_pickup_charges'] = $column_names[14];
            $import_fields_map['v_door_delivery'] = $column_names[15];
            $import_fields_map['v_door_delivery_charges'] = $column_names[16];
            $import_fields_map['v_loading_charges'] = $column_names[17];
            $import_fields_map['v_articles'] = $column_names[18];
            $import_fields_map['v_remarks'] = $column_names[19];
        }

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }    
        $data['organization'] = $branches->data;    

        $formatted = [];    
        foreach($rows as $row) {
            $tmp = [];
            foreach($import_fields_map as $key => $val) {
                if($key == 'v_payment_type'){
                    $tmp[$key] = trim($row[$val]) == "Credit" ? "onaccount":$row[$val];
                }else{
                $tmp[$key] = $row[$val];
                }
            }
            array_push($formatted, $tmp);
        }

        $formattedLr = [];
        foreach ($formatted as $lrdata) {
            if (empty($lrdata['v_lrno'])) {
                continue;
            }
            foreach($branches->data as $org) {
                $branch = strtolower($org->name);
                $from_branch = trim(strtolower($lrdata['v_from_station']));
                $to_branch = trim(strtolower($lrdata['v_to_station']));
                
                if ($from_branch == $branch) {
                    $lrdata['ed_from_branch'][$org->code]['name'] = $org->name;
                    $lrdata['ed_from_branch'][$org->code]['code'] = $org->code;
                    $lrdata['ed_from_branch'][$org->code]['station_name'] = $org->station->name;
                    $lrdata['ed_from_branch'][$org->code]['station_code'] = $org->station->code;
                }
                if ($to_branch == $branch) {
                    $lrdata['ed_to_branch'][$org->code]['name'] = $org->name;
                    $lrdata['ed_to_branch'][$org->code]['code'] = $org->code;
                    $lrdata['ed_to_branch'][$org->code]['station_name'] = $org->station->name;
                    $lrdata['ed_to_branch'][$org->code]['station_code'] = $org->station->code;
                }
            }
            $formattedLr[] = $lrdata;
        }
        $data['lrs'] = $formattedLr;
        $this->load->view('site/import/excel-data-list', $data);

    }
    
    public function import_excel_lr() {
        $this->is_logged_in();

        $excel_import_payment_status = $this->config->item('excel_import_payment_status');
        $excel_lrs = $this->input->post('importedlrs');
        $all_lrs = $this->input->post('allLrs');
        $response = array();

        $lrvalidation = $this->api_model->lrCodeValidation($all_lrs);
        $lrvalidation = json_decode($lrvalidation);
        $lrvalidation = $lrvalidation->data;

        $validLrs = array();
        foreach ($lrvalidation as $k => $lrcode) {
            if ($lrcode->activeFlag == 1) {
                array_push($validLrs, $lrcode->code);
            } else {
                array_push($response, array('status' => 0, 'lr' => $lrcode->code, 'message' => 'LR Already Booked'));
            }
        }

        foreach ($excel_lrs as $key => $lr) {     
            if (!in_array($lr['v_lrno'] , $validLrs)) {
                continue;
            }  
            $paymentType = str_replace(' ', '', strtolower($lr['v_payment_type']));
            // save from customer
            if (isNotNull($lr['v_sender_name'])) {
                $data = array(
                    'activeFlag' => 1,
                    'code' => '',
                    'name' => strtoupper($lr['v_sender_name']),
                    'companyName' => 'Common',
                    'mobileNumber' => '0000000000',
                    'email' => '',
                    'preferedPaymentType' => $excel_import_payment_status[$paymentType],
                    'gstin' => '',
                    'role' => array('code' => 'RC'),
                    'station' => array(
                        array('code' => $lr['v_from_station'])
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
    
            // save to customer
            if (isNotNull($lr['v_receiver_name'])) {
                $data = array(
                    'activeFlag' => 1,
                    'code' => '',
                    'name' => strtoupper($lr['v_receiver_name']),
                    'companyName' => 'Common',
                    'mobileNumber' => '0000000000',
                    'email' => '',
                    'preferedPaymentType' => $excel_import_payment_status[$paymentType],
                    'gstin' => '',
                    'role' => array('code' => 'RC'),
                    'station' => array(
                        array('code' => $lr['v_to_station'])
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

            // map articles
            $articles = [];
            if (isNotNull($lr['v_article_count'])) {
                $article = array(
                    'activeFlag' => 1,
                    'cargoItem' => array('code' => '', 'name' => $lr['v_articles']),
                    'fare' => $lr['v_total_freight'],
                    'itemCount' => $lr['v_article_count'],
                    'handlingChargeAmount' => $lr['v_loading_charges']?$lr['v_loading_charges']:0,
                    'unloadingChargeAmount' => "0",
                    'unit' => array('code' => 'NPPKG'),
                    'unitValue' => "0",
                    'actualUnitValue' => $lr['v_actual_weight'],
                    'serviceTax' => 0
                );
                array_push($articles, $article);
            }

            // map invoice
            $cargoAddonsDetails = [];
            if (isNotNull($lr['v_invoice_value']) && $lr['v_invoice_value'] > 0) {
                $invoice_value = $lr['v_invoice_value'] . "|NA" . "|" . date('Y-m-d');
                $invoice = array(
                    'addonsType' => array('code' => 'EWBL'),
                    'value' => $invoice_value,
                    'referenceCode' => "NA"
                );
                array_push($cargoAddonsDetails, $invoice);
            }

            $remarks = array(
                'code' => '',
                'name'=> '',
                'cargoStatusCode' => 'CB'
            );

            // Lr Code
            $additionalAttribute = [];
            if (isNotNull($lr['v_lrno'])) {
                $additionalAttribute['CARGO_POSTFIX_CODE'] = $lr['v_lrno'];
                $additionalAttribute['EXCEL_UPLOAD'] = 'EXCEL_UPLOAD';
            }

            $vendors = $this->api_model->cargoCustomerVendor();
            $vendors = json_decode($vendors);
            $data['vendors'] = $vendors->data;
            $vendorUser  = new stdClass();

            foreach($vendors->data as $row){
                if($from_customer == $row->user->code){
                    $vendorUser->code = $from_customer;
                    break;
                }
            }
       
    
            // Cargo Transaction List
            $cargoTransactionList = [];
            $paymentAmount = 0;
            if ($excel_import_payment_status[$paymentType] == 'PAD') {
                $t_paid_amount =($lr['v_total_freight']*$lr['v_article_count'])+$lr['v_door_pickup_charges']+$lr['v_door_delivery_charges']+$lr['v_loading_charges'];
                $transactionList = array(
                    'transactionAmount' => $t_paid_amount,
                    'transactionMode' => array('code' => 'CASH')
                );
                array_push($cargoTransactionList, $transactionList);
                $paymentAmount = $t_paid_amount;
            }
       

            $data = array(
                'code' => '',
                'fromStation' => array('code' => $lr['v_from_station']),
                'toStation' => array('code' => $lr['v_to_station']),
                'fromOrganization' => array('code' => $lr['v_from_branch']),
                'toOrganization' => array('code' => $lr['v_to_branch']),
                'fromCustomer' => array(
                    'code' => $from_customer ?? '',
                    'name' => strtoupper($lr['v_sender_name']),
                    'mobileNumber' => $from_customer_phone ?: '0000000000',
                ),
                'toCustomer' => array(
                    'code' => $to_customer ?? '',
                    'name' => strtoupper($lr['v_receiver_name']),
                    'mobileNumber' => $to_customer_phone ?: '0000000000',
                ),
                'fromCustomerAddress' => array('code' => ''),
                'toCustomerAddress' => array('code' => ''),
                'remarks' => "",
                'paymentAmount' => $paymentAmount,
                'itemDetails' => $articles ?: [],
                'paymentType' => array('code' => $excel_import_payment_status[$paymentType]),
                'pickupHandlingAmount' => (double)$lr['v_door_pickup_charges'],
                'deliveryHandlingAmount' => (double)$lr['v_door_delivery_charges'],
                'fromCustomerGST' => '',
                'toCustomerGST' => '',
                'serviceCharge' => 0,
                'serviceTax' => 0,
                'hamaliCharge' => 0,
                'passCharge' => 0,
                'docketCharge' => 0,
                'cargoAddonsDetails' => $cargoAddonsDetails ?: [],
                'cargoTransactionList' => $cargoTransactionList,
                'remarks' => [$remarks],
                'additionalAttribute' => $additionalAttribute ?: (object)[],
            );

            if($excel_import_payment_status[$paymentType] == "INP"){
                $data['vendorUser']  = $vendorUser;
             }

             if($lr['v_door_pickup'] == "YES"){
                $data['pickupType']  = array('code' =>'PUDO');
             }

             if($lr['v_door_delivery'] == "YES"){
                $data['deliveryType']  = array('code' =>'DYDO');
             }

            $lrBooked = $this->api_model->saveCargoBooking($data);
            $lrBooked = json_decode($lrBooked);
            if ($lrBooked->status == 1) {
                array_push($response, array('status' => 1, 'generate_lr' => $lrBooked->data->code, 'lr' => $lr['v_lrno']));
            } else {
                array_push($response, array('status' => 0, 'lr' => $lr['v_lrno'], 'message' => $lrBooked->errorDesc));
            }
        }
        echo json_encode($response);
        return;
    }

}

?>