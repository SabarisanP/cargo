<?php

define('NSCODE', _get_namespace_id());

class gst_report extends CI_Model {

    public $userOrg;
    public $userStaion;
    public $nameSpaceCode;
    function __construct() {
       $api = $this->load->model('api_model');
       $this->userOrg = $this->session->userdata('org_code');
    }
    function getGstingColumns($lrGstTaxComputeType) {
        return [
            $lrGstTaxComputeType == 'NET' ? 'Net Amount' : 'Freight',
            'SGST',
            'CGST',
            'IGST',
            'Total'
        ];
    }
    
    function getSummaryData($summary, $lrGstTaxComputeType) {
        $summaryData = [];
        foreach ($summary as $k => $item) {
            $summaryData[] = ["{$k}"];
            foreach ($item as $l => $row) {
                $gstinLabel = "GSTIN : {$row['gst_state']} - {$l}";
                $freightNet = $lrGstTaxComputeType == 'NET' ? $row['netpayable'] : $row['freight'];
                $sgst = ceil($row['sgst']);
                $cgst = ceil($row['cgst']);
                $igst = ceil($row['igst']);
                $total = ceil($sgst + $cgst + $igst + $freightNet);
    
                $rows = [
                    number_format($freightNet, 2),
                    number_format($sgst, 2),
                    number_format($cgst, 2),
                    number_format($igst, 2),
                    number_format($total, 2)
                ];
    
                $summaryData[] = [$gstinLabel];
                $summaryData[] = $this->getGstingColumns($lrGstTaxComputeType);
                $summaryData[] = $rows;
            }
        }
        return $summaryData;
    }
    
    function getSummaryAccumulation($booking, $cancel, $nongst_booking, $nongst_cancel, $cargo_setting) {
        $summary_columns = [
            'Transaction',
            $cargo_setting->lrGstTaxComputeType == 'NET' ? 'Net Amount (A)' : 'Freight (A)',
            'SGST (B)',
            'CGST (C)',
            'IGST (D)',
            'Total (A + B + C + D)'
        ];
    
        $frightnetA = $cargo_setting->lrGstTaxComputeType == 'NET' ? $booking['netpayable'] : $booking['freight'];
        $frightnetB = $cargo_setting->lrGstTaxComputeType == 'NET' ? $cancel['netpayable'] : $cancel['freight'];
        $frightnetC = $cargo_setting->lrGstTaxComputeType == 'NET' ? $nongst_booking['netpayable'] : $nongst_booking['freight'];
        $frightnetD = $cargo_setting->lrGstTaxComputeType == 'NET' ? $nongst_cancel['netpayable'] : $nongst_cancel['freight'];
    
        $summary_accumulation = [
            $summary_columns,
            $this->getSummaryRow('Booking (A)', $frightnetA, $booking),
            $this->getSummaryRow('Cancel (B)', $frightnetB, $cancel),
            $this->getSummaryRow('Non GST Booking (C)', $frightnetC, $nongst_booking),
            $this->getSummaryRow('Non GST Cancel (D)', $frightnetD, $nongst_cancel),
            $this->getNetTotalRow($booking, $cancel, $nongst_booking, $nongst_cancel, $frightnetA, $frightnetB, $frightnetC, $frightnetD)
        ];
    
        return $summary_accumulation;
    }
    
    function getSummaryRow($label, $freightNet, $data) {
        return [
            $label,
            number_format($freightNet, 2),
            number_format(ceil($data['sgst']), 2),
            number_format(ceil($data['cgst']), 2),
            number_format(ceil($data['igst']), 2),
            number_format(ceil($freightNet + $data['sgst'] + $data['cgst'] + $data['igst']), 2)
        ];
    }
    
    function getNetTotalRow($booking, $cancel, $nongst_booking, $nongst_cancel, $frightnetA, $frightnetB, $frightnetC, $frightnetD) {
        $book_total = $frightnetA + $booking['sgst'] + $booking['cgst'] + $booking['igst'];
        $cancel_total = $frightnetB + $cancel['sgst'] + $cancel['cgst'] + $cancel['igst'];
        $nongst_booking_total = $frightnetC + $nongst_booking['sgst'] + $nongst_booking['cgst'] + $nongst_booking['igst'];
        $nongst_cancel_total = $frightnetD + $nongst_cancel['sgst'] + $nongst_cancel['cgst'] + $nongst_cancel['igst'];
    
        $freight_total = $frightnetA - $frightnetB + $frightnetC - $frightnetD;
        $sgst_total = $booking['sgst'] - $cancel['sgst'] + $nongst_booking['sgst'] - $nongst_cancel['sgst'];
        $cgst_total = $booking['cgst'] - $cancel['cgst'] + $nongst_booking['cgst'] - $nongst_cancel['cgst'];
        $igst_total = $booking['igst'] - $cancel['igst'] + $nongst_booking['igst'] - $nongst_cancel['igst'];
    
        return [
            'Net Total (A - B + C - D)',
            number_format($freight_total, 2),
            number_format(ceil($sgst_total), 2),
            number_format(ceil($cgst_total), 2),
            number_format(ceil($igst_total), 2),
            number_format(ceil($book_total - $cancel_total + $nongst_booking_total - $nongst_cancel_total), 2)
        ];
    }
    
    function getColumns($GST_type) {
        return [
            lang('cargo_code_term'),
            "Booked Date",
            lang('booking_from_term'),
            lang('booking_to_label'),
            lang('booking_sender_term'),
            lang('booking_receiver_term'),
            lang('booking_sender_term') . ' GST',
            lang('booking_receiver_term') . ' GST',
            'Trade Name',
            'GSTIN',
            'State',
            $GST_type,
            "SGST",
            "CGST",
            "IGST",
            "Payment Status",
            "Cargo Status",
            "Handling Charge",
            "Unloading Charge"
        ];
    }
    
    function getBookingData($bookingData, $setting, $columns, $cargo_payment_status, $cargo_status) {
        $data = [array("Booking Transactions"), $columns];
        foreach ($bookingData as $row) {
            $data[] = $this->getRowData($row, $setting, $cargo_payment_status, $cargo_status);
        }
        return $data;
    }
    
    function getCancelData($cancelData, $setting, $columns, $cargo_payment_status, $cargo_status) {
        $data = [array("Cancel Transactions"), $columns];
        foreach ($cancelData as $row) {
            $data[] = $this->getRowData($row, $setting, $cargo_payment_status, $cargo_status);
        }
        return $data;
    }
    function getNonBookingData($cancelData, $setting, $columns, $cargo_payment_status, $cargo_status) {
        $data = [array("Non GST Booking Transactions"), $columns];
        foreach ($cancelData as $row) {
            $data[] = $this->getRowData($row, $setting, $cargo_payment_status, $cargo_status);
        }
        return $data;
    }
    function getNonCancelData($cancelData, $setting, $columns, $cargo_payment_status, $cargo_status) {
        $data = [array("Non GST Cancel Transactions"), $columns];
        foreach ($cancelData as $row) {
            $data[] = $this->getRowData($row, $setting, $cargo_payment_status, $cargo_status);
        }
        return $data;
    }
   
    
    function getRowData($row, $setting, $cargo_payment_status, $cargo_status) {
        $to_org_name = $row->to_organization_name ? $row->to_organization_name : "-";
        $booking_sender_term = "{$row->from_customer_name} - {$row->from_customer_mobile}";
        $booking_receiver_term = "{$row->to_customer_name} - {$row->to_customer_mobile}";
        $booking_sender_term_gst = $row->from_customer_gstin ? $row->from_customer_gstin : "-";
        $booking_receiver_term_gst = $row->to_customer_gstin ? $row->to_customer_gstin : "-";
        $trade_name = $row->trade_name ? $row->trade_name : "-";
        $gstin = $row->gstin ? $row->gstin : "-";
        $net_total = $setting->lrGstTaxComputeType == "FRT" ? $row->total_amount : $row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount;
        $tax_total = $setting->lrGstTaxComputeType == "FRT" ? $row->total_amount : $row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->other_charges_amount;
        $s_gst = !$row->service_tax ? "0.00" : $this->handleGST($tax_total, $row->sgst);
        $c_gst = !$row->service_tax ? "0.00" : $this->handleGST($tax_total, $row->cgst);
        $i_gst = !$row->service_tax ? "0.00" : $this->handleGST($tax_total, $row->igst);
        
        return [
            $row->cargo_code,
            $row->booked_at,
            $row->from_organization_name,
            $to_org_name,
            $booking_sender_term,
            $booking_receiver_term,
            $booking_sender_term_gst,
            $booking_receiver_term_gst,
            $trade_name,
            $gstin,
            $row->state_name,
            number_format($net_total,2),
            number_format($s_gst,2),
            number_format($c_gst,2),
            number_format($i_gst,2),
            $cargo_payment_status[$row->payment_status_code],
            $cargo_status[$row->cargo_status_code],
            number_format($row->total_handling_amount,2),
            number_format($row->total_unload_handling_amount,2)
        ];
    }
    
    function handleGST($tax_total, $gst) {
        return number_format(ceil($tax_total * ($gst / 100)), 2);
    }
}