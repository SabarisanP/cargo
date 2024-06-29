<?php
if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Ewaybill extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    public function ewaybill_tracker() {
        $this->is_logged_in();

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

        $loadremarks = $this->api_model->getCargoRemarksByStatus(array('cargoStatusCode' => 'CL'));
        $loadremarks = json_decode($loadremarks);
        $data['loadremarks'] = $loadremarks->data;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');

        $this->load->view('site/ewaybill/ewaybill-tracker', $data);
    }

    function ewaybill_tracker_list() {
        $this->is_logged_in();

        $fromDate = $this->input->post('fromDate');
        $toDate = $this->input->post('toDate');
        $lrCode = trim($this->input->post('lrCode'));
        $ewayBillNo = trim($this->input->post('ewayBillNo'));

        $referenceType = 'NA';
        $referenceCode = 'NA';
        if ($lrCode != '') {
            $referenceType = 'LR';
            $referenceCode = $lrCode;
            $fromDate = 'NA';
            $toDate = 'NA';
        }
        if ($ewayBillNo != '') {
            $referenceType = 'EWB';
            $referenceCode = $ewayBillNo;
            $fromDate = 'NA';
            $toDate = 'NA';
        }
        
        $data = array(
            'queryCode' => 'RQL8PHV44',
            'toDate' => $toDate,
            'fromDate' => $fromDate,
            'fromStationCode' => $this->input->post('fromStation'),
            'toStationCode' => $this->input->post('toStation'),
            'fromOrganizationCode' => $this->input->post('fromOrganizationCode'),
            'toOrganizationCode' => $this->input->post('toOrganizationCode'),
            'paymentStatusCode' => $this->input->post('payStatus'),
            'referenceType' => $referenceType,
            'referenceCode' => $referenceCode,
        );
        
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $summary = [];
        foreach ($result->data as $row) {
            $summary[$row->registration_number][$row->transit_code]['alias_code'] = $row->transit_alias_code;
            $summary[$row->registration_number][$row->transit_code]['transit_name'] = $row->transit_name;
            $summary[$row->registration_number][$row->transit_code]['data'][] = $row;
        }
        krsort($summary);
        $data['summary'] = $summary;
        $data['result'] = $result->data;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['cargo_payment_status_badge'] = config_item('cargo_payment_status_badge');
        
        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/ewaybill/ewaybill-tracker-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=ewaybill-tracker-list.xls');
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
            $this->load->view('site/ewaybill/ewaybill-tracker-list', $data);
        }
    }

    function generate_consolidate_ewaybill() {
        $this->is_logged_in();

        echo $this->api_model->generateConsolidateEwaybill(array(
            'transitCode' => $this->input->post('transitCode'),
            'cargoList' => $this->input->post('cargoList')
        ));
    }
}