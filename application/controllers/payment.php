<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Payment extends MY_Controller {

    function __construct() {
        parent::__construct();
        $this->load->helper('common_helper');  
    }

    public function index() {
        $this->is_logged_in();
        redirect('user/dashboard');
    }


    public function userbalance() {
        $this->is_logged_in();
        $this->load->view('site/payment/userbalance');
    }
    
    function userbalance_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQF22D17',
            'transactionDate ' => $this->input->post('from') ?: 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['reports'] = $result->data;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/payment/userbalance-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=User-Balance.xls');
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
            $this->load->view('site/payment/userbalance-list', $data);
        }
    }
    
    //-------------------------------------
    function ids_userbalance() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQF22D17',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $this->load->view('site/payment/ids-userbalance', array('reports' => $result->data));
    }
    //-------------------------------------

    function user_balance_report_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQF22D17',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $this->load->view('site/payment/userbalance', array('reports' => $result->data));
    }
    
    

    function refund_pending() {
        $this->is_logged_in();
        $data = array(
            'statusCode' => 'INI',
        );
        $ref = $this->api_model->getPendingRefund($data);
        $refund = json_decode($ref);
        $data['ref'] = $refund->data;
        $this->load->view('site/payment/pending-refund', $data);
    }

     function update_cancel_refund() {
        $this->is_logged_in();
        $data = array(
            'statusCode' => 'REQ',
            'transactionCode' => $this->input->post('code')
        );
        echo $this->api_model->updatePendingRefund($data);
    }


     public function agent_payment() {
        $this->is_logged_in();
        $data = array();

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
        $this->load->view('site/payment/agent-payment', $data);
    }
    
    public function agent_payment_list() {
        $this->is_logged_in();
        $group_by_2 = $this->input->post('group_by');
        
        $user_code = $this->input->post('user_code');
        if($user_code=="NA" || $user_code=="")
            $user_code = $this->session->userdata('user_id');
        
        $username = $this->input->post('username');
        
        if($username=="NA" || $username == 'Select' || $username == '')
            $username = $this->session->userdata('user_name');
        
            
        $data = array(
            'queryCode' => 'RQH56FD18',
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),
            'travelDateFlag' => $this->input->post('date_option'),
            'userCode' => $user_code,
            'filterCode' => $this->input->post('txn_status'),
            'ticketCode' => 'NA'
        );
        
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        
        $tickets = array();
        $tickets['user'] = $this->session->userdata('user_name');
        $tickets['date'] = date('Y-m-d H:i:s');
        $data['option'] = $this->input->post('date_option');
               
        $tickets['username'] = $username;

        $this->load->view('site/payment/agent-payment-list', array('tickets' => $tickets));

    }

    function expenses() {
        $this->is_logged_in();
        _include_js('assets/js/pages/expenses.js', '_init_expenses_page');
        $data = array();
        //        
//        //Trip Expenses
//        $tripexpn = $this->api_model->getTripsExpensive(array('tripCode' => $tripCode));
//        $tripexpn = json_decode($tripexpn);
//        $data = array('data' => $tripexpn->data);

        //Trip Cash head
        $triphead = $this->api_model->getTripsHead();
        $triphead = json_decode($triphead);
        $data['triphead'] = $triphead->data;

        //Transaction Mode
        $trans_mode = $this->api_model->getTransMode(array());
        $transaction_mode = json_decode($trans_mode);
        $data['t_mode'] = $transaction_mode->data;

        $this->load->view('site/payment/expenses', $data);
    }

    function expenses_list() {
        $this->is_logged_in();
        $data = array();

        $tripCode = $this->input->post('trip_code');

        //Trip info - vehicle, driver etc
        $tripInfo = $this->api_model->getTripInfo(array('tripCode' => $tripCode));
        $tripInfo = json_decode($tripInfo);
        $data['tripinfo'] = $tripInfo->data;


        //Trip Expenses
        $tripexpn = $this->api_model->getTripsExpensive(array('tripCode' => $tripCode));
        $tripexpn = json_decode($tripexpn);
        $data['data'] = $tripexpn->data;
//        
//        //Trip Cash head
//        $triphead = $this->api_model->getTripsHead();
//        $triphead = json_decode($triphead);
//        $data['triphead'] = $triphead->data;
//        
//        //Transaction Mode
//        $trans_mode = $this->api_model->getTransMode(array());
//        $transaction_mode = json_decode($trans_mode);
//        $data['t_mode'] = $transaction_mode->data;

        if ($this->input->post('export') == 1) {
            //  excel generation
            $this->load->library('excel');
            $this->excel->getProperties()->setCreator("EzeeInfo")
                ->setLastModifiedBy("EzeeInfo")
                ->setTitle("Trip Expense")
                ->setSubject("Trip Revenue & Expense")
                ->setDescription("Trip wise revenue and expenses entries details.")
                ->setKeywords("trip expenses")
                ->setCategory("Accounts");
            $this->excel->setActiveSheetIndex(0);
            $this->excel->getActiveSheet()->setTitle('Trip Revenue and Expenses');

            $this->excel->getActiveSheet()->mergeCells("A1:E1")->setCellValueByColumnAndRow(0, 1, "Trip Wise Accounts Statement");
            $this->excel->getActiveSheet()->getStyle('A1')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
            $this->excel->getActiveSheet()->getStyle('A1')->getFont()->setBold(true);

            $this->excel->getActiveSheet()->mergeCells("A2:E2")->setCellValueByColumnAndRow(0, 2, 'Vehicle :' . $data['tripinfo']->busVehicle->registationNumber . ' | Travel Date :' . $this->input->post('travel_date'));
            $this->excel->getActiveSheet()->getStyle('A2')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
            $this->excel->getActiveSheet()->getStyle('A2')->getFont()->setBold(true);

            $this->excel->getActiveSheet()->getStyle('A3:Z3')->getFont()->setBold(true);
            $this->excel->getActiveSheet()->getStyle('A3:Z3')->applyFromArray(
                array(
                    'fill' => array(
                        'type' => PHPExcel_Style_Fill::FILL_SOLID,
                        'color' => array('rgb' => '64b92a')
                    )
                )
            );

            $this->excel->getActiveSheet()->setCellValue('A3', 'Head');
            $this->excel->getActiveSheet()->setCellValue('B3', 'Mode');
            $this->excel->getActiveSheet()->setCellValue('C3', 'Remarks');
            $this->excel->getActiveSheet()->setCellValue('D3', 'Revenue Amount');
            $this->excel->getActiveSheet()->setCellValue('E3', 'Expense Amount');

            $row = 4;
            foreach ($data['data'] as $t) {
                $col = 0;

                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->tripCashHead->name);
                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->transactionMode->name);
                $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->remarks);

                if ($t->tripCashHead->creditDebitFlag == "Cr")
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->amount);
                else
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, 0);

                if ($t->tripCashHead->creditDebitFlag == "Dr")
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $t->amount);
                else
                    $this->excel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, 0);

                $row++;
            }

            $this->excel->getActiveSheet()->getStyle('A' . $row . ':Z' . $row)->getFont()->setBold(true);
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(3, $row, "=SUM(D2:D" . ($row - 1) . ")");
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(4, $row, "=SUM(E2:E" . ($row - 1) . ")");

            $row++;
            $this->excel->getActiveSheet()->getStyle('A' . $row . ':Z' . $row)->getFont()->setBold(true);
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(3, $row, "Net Amount");
            $this->excel->getActiveSheet()->setCellValueByColumnAndRow(4, $row, "=(D" . ($row - 1) . "-E" . ($row - 1) . ")");

            $filename = 'Trip-Accounts-' . $this->input->post('travel_date') . '-' . $tripCode . '.xls';
            header('Content-Type: application/vnd.ms-excel');
            header('Content-Disposition: attachment;filename="' . $filename . '"');
            header('Cache-Control: max-age=0');
            $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
            $objWriter->save('php://output');

        } else {
            $this->load->view('site/payment/expenses-list', $data);
        }
    }

    public function update_expense() {
        $this->is_logged_in();
        $entrycode = $this->input->post('code');
        $data = array(
            'amount' => $this->input->post('amount'),
            'activeFlag' => 1,
            'tripCode' => $this->input->post('tripcode'),
            'transactionMode' => array('code' => $this->input->post('mode')),
            'tripCashHead' => array('code' => $this->input->post('head')),
            'remarks' => $this->input->post('remarks')
        );
        if ($entrycode != '') {
            $data['code'] = $entrycode;
        }
        echo $this->api_model->updateTripExpenses($data);
    }

    public function delete_expense() {
        $this->is_logged_in();
        $data = $this->input->post('dto');
        echo $this->api_model->updateTripExpenses($data);
    }

    public function tripcancel_acknowledgement() {
        $this->is_logged_in();
        $data = array();
        $this->load->view('site/payment/tripcancel-acknowledgement', $data);
    }

    function tripcancel_acknowledgement_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQI275W27',
            'fromDate' => $this->input->post('from_date'),
            'toDate' => $this->input->post('to_date'),
            'travelDateFlag' => 1,
            'tripCode' => 'NA',
            'tagCode' => 'NA',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data = array();
        $data['meta'] = config_item('ticket_status');
        $data['tickets'] = $result->data;

        $this->load->view('site/payment/tripcancel-acknowledgement-list', $data);
    }

    function tripcancel_confirm(){
        $this->is_logged_in();

        $ticket = $this->input->post('pnr');
        $ticket['user_tag'] = _get_user_tag_by_code($ticket['user_code']);

        $option = $this->input->post('option');
        $status = 'TPNA';
        if ($option == 1)
            $status = 'TCA';

        $s = explode(',', $ticket['seat_code']);
        $seatsCodes = array_map('trim', $s);
        $seatsCodes = implode(',', $seatsCodes);
        $data = array(
            'tripCode' => $ticket['trip_code'],
            'ticketCode' => $ticket['ticket_code'],
            'seatCode' => $seatsCodes,
            'tripStatusCode' => $status
        );
        $result = $this->api_model->tripCancelAcknowledge($data);
        $r = json_decode($result);

        if ($r->status == 1 && $status == 'TCA') {
            $maildata = array(
                "operatorCode" => $this->session->userdata('namespace_id'),
                "operatorName" => $this->session->userdata('namespace_name'),
                "params" => $ticket
            );
            _send_mail('tripcancelconfirm', $maildata);
        }

        echo $result;
    }

    function expense() {
        $this->is_logged_in();
        $logged_in_user_branch = $this->session->userdata('org_code');

        $vehicle = $this->api_model->getVehicle();
        $vehicle = json_decode($vehicle);
        $data['vehicles'] = $vehicle->data;

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        $tagNames = [];
        foreach ($organization->data as $branch) {
            if ($branch->code == $logged_in_user_branch) {
                foreach ($branch->tag as $row) {
                    $tagNames[] = clean_string($row->name);
                }
                break;
            }
        }

        $vendors = $this->api_model->getCashbookVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;

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

        $expense_ledger_contacts = array();
        foreach ($contact->data as $row) {
            if (!isset($expense_ledger_contacts[$row->contactCategory->code])) {
                $contactCategory = clone $row->contactCategory;
                $contactCategory->contacts = [];
                $expense_ledger_contacts[$row->contactCategory->code] = $contactCategory;
            }
            $expense_ledger_contacts[$row->contactCategory->code]->contacts[] = $row;
        }
        $data['expense_ledger_contacts'] = $expense_ledger_contacts;

        $bankdetail = $this->api_model->getOrganizationOtherDetails(array(
                'organizationcode' => $this->session->userdata('org_code')
        ));
        $bankdetail = json_decode($bankdetail);
        $data['bankdetail'] = $bankdetail->data->bankDetails;

        $triphead = $this->api_model->getCashbookHead();
        $triphead = json_decode($triphead);
        $data['triphead'] = $triphead->data;

        $result = $this->api_model->cargoTags();
        $result = json_decode($result);
        $data['cargotags'] = $result->data;

        $identicalTags = [];
        foreach ($result->data as $row) {
            if ($row->category->code == 'MGEXP' && in_array(clean_string($row->name), $tagNames)) {
                $identicalTags[] = $row->code;
            }
        }
        $data['identicaltags'] = $identicalTags;

        $branchStaff = $this->api_model->getAllBranchContact(array(
                'organizationCode' => $logged_in_user_branch,
                'categoryCode' => ''
        ));
        $branchStaff = json_decode($branchStaff);
        $data['branchStaff'] = $branchStaff->data;

        $users = $this->api_model->getUser();
        $users = json_decode($users);

        $usrbranch = array();
        foreach ($users->data as $row) {
            $usrbranch[$row->organization->code]['code'] = $row->organization->code;
            $usrbranch[$row->organization->code]['name'] = $row->organization->name;
            $usrbranch[$row->organization->code]['users'][] = $row;
        }
        usort($usrbranch, function ($a, $b) {
            return strcasecmp($a['name'], $b['name']);
        });
        $data['branchusers'] = $usrbranch;

        $drivers = $this->api_model->getVehicleDriver();
        $drivers = json_decode($drivers);
        $data['drivers'] = $drivers->data;

        $data['groupusers'] = get_active_group_and_users();
        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['logged_in_usr_org_code'] = $logged_in_user_branch;
        $data['user_code'] = $this->session->userdata('user_id');

        $data['transactionmode'] = config_item('transaction_mode');
        $data['bank_names_list'] = $this->config->item('bank_names_list');

        $this->load->view('site/payment/expense', $data);
    }

    function update_manage_expense_comments() {
        $this->is_logged_in();

        echo $this->api_model->updateManageExpenseComments(array(
                'code' => $this->input->post('code') ?: '',
                'comments' => $this->input->post('comments') ?: ''
        ));
    }

    function advance_payment_list() {
        $this->is_logged_in();

        $from = $this->input->post('fromDate');
        $to = $this->input->post('toDate');

        $data = array(
            'fromDate' => date('Y-m-d', strtotime($from)),
            'toDate' => date('Y-m-d', strtotime($to))
        );
        $result = $this->api_model->getAllAdvancePaymentList($data);
        $result = json_decode($result);

        $advance_payment = array();
        foreach ($result->data as $val) {
            if (in_array($val->receiptReferenceType->code, ['DVR', 'USR', 'BSTF'])) {
                array_push($advance_payment, $val);
            }
        }
        $data['result'] = array_reverse($advance_payment);

        $this->load->view('site/payment/advance-payment-list', $data);
    }

    function get_expense_ledger_list() {
        $this->is_logged_in();

        $fromDate = $this->input->post('fromDate');
        $toDate = $this->input->post('toDate');
        $print  = $this->input->post('print');
        $codeValue  = $this->input->post('transitCode');
        $summaryPrint = $this->input->post('summaryPrint');

        $data = array(
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'organizationReceiptCode' => $this->input->post('organizationReceiptCode'),
            'entryTypeCode' => $this->input->post('entryTypeCode'),
        );
        $result = $this->api_model->getExpenseLedger($data);
        $result = json_decode($result);

        usort($result->data, function ($a, $b) {
            return (strtotime(trim($a->transactionDate)) > strtotime(trim($b->transactionDate))) ? -1 : 1;
        });
        $data['fromDate'] = date('Y-m-d', strtotime($fromDate));
        $data['toDate'] = date('Y-m-d', strtotime($toDate));
        $data['organizationCode'] =  $this->input->post('organizationCode') ?: 'NA';
        $data['organizationReceiptCode'] = $this->input->post('organizationReceiptCode');
        $data['entryTypeCode'] = $this->input->post('entryTypeCode');
        $data['result'] = $result->data;
        $data['transactionmode'] = config_item('transaction_mode');


        $accountDetails = array();

        if ($print == '1') {
            foreach ($result->data as $row) {
                if ($row->code == $codeValue) {
                    $account[0] = $row->cashbookVendor->contactCategory->name;
                    $account[1] = $row->organization->name;
                    $data['account'] =  $account;
                    $data['chargedTo'] = $row->cashbookVendor->name;
                    $data['expense'] = $row->transactionDate;
                    $data['debitAmount'] = $row->amount;
                    $data['voucherNumber'] = $row->voucherNumber;
                    break;
                }
            }
            $content = $this->load->view('site/payment/expense-ledger-list-print-seenuTransport', $data);
            echo $content;
        } else if ($summaryPrint == 1) {
            foreach ($result->data as $row) {
                $accountDetails[$row->cashbookVendor->contactCategory->name]['count'] += 1;
                $accountDetails[$row->cashbookVendor->contactCategory->name]['amount'] += $row->amount;
            }
            $data["accountDetails"] = $accountDetails;
            $contents =   $this->load->view('site/payment/expense-ledger-list-seenutransport', $data);
            echo $contents;
        } else {
            $this->load->view('site/payment/expense-ledger-list', $data);
        }
    }

    function expense_v2() {
        $this->is_logged_in();
        $logged_in_user_branch = $this->session->userdata('org_code');

        $vehicle = $this->api_model->getVehicle();
        $vehicle = json_decode($vehicle);
        $data['vehicles'] = $vehicle->data;

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        $driver = $this->api_model->getVehicleDriver(array(
            'activeFlagFilter' => -1
        ));

        $driver = json_decode($driver);
        $drivers = array();

        foreach ($driver->data as $drivere) {
            if ($drivere->activeFlag == '1') {
                array_push($drivers, $drivere);
            }
        }

        $data['driver'] = $drivers;

        $tagNames = [];
        foreach ($organization->data as $branch) {
            if ($branch->code == $logged_in_user_branch) {
                foreach ($branch->tag as $row) {
                    $tagNames[] = clean_string($row->name);
                }
                break;
            }
        }
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $expenses = array();
        foreach ($result->data as $row) {
            $list['data'][$row->entity_type][] = $row;
            $list[$row->entity_type] += $row->entity_value;

            if ($row->entity_type == 'EXPANSE') {
                $expenses[$row->entity_attribute]['amount'] += $row->entity_value;
                $expenses[$row->entity_attribute]['count']++;
                $expenses[$row->entity_attribute]['name'][$row->entity_name] = $row->entity_name;
            }
        }
        ksort($expenses);
        $data['result'] = $list;
        $data['expenses'] = $expenses;

        $vendors = $this->api_model->getCashbookVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;

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

        $bankdetail = $this->api_model->getOrganizationOtherDetails(array(
                'organizationcode' => $this->session->userdata('org_code')
        ));
        $bankdetail = json_decode($bankdetail);
        $data['bankdetail'] = $bankdetail->data->bankDetails;

        $triphead = $this->api_model->getCashbookHead();
        $triphead = json_decode($triphead);
        $data['triphead'] = $triphead->data;

        $result = $this->api_model->cargoTags();
        $result = json_decode($result);
        $data['cargotags'] = $result->data;

        $identicalTags = [];
        foreach ($result->data as $row) {
            if ($row->category->code == 'MGEXP' && in_array(clean_string($row->name), $tagNames)) {
                $identicalTags[] = $row->code;
            }
        }
        $data['identicaltags'] = $identicalTags;

        $branchStaff = $this->api_model->getAllBranchContact(array(
                'organizationCode' => $logged_in_user_branch,
                'categoryCode' => ''
        ));
        $branchStaff = json_decode($branchStaff);
        $data['branchStaff'] = $branchStaff->data;

        $data['groupusers'] = get_active_group_and_users();
        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['logged_in_usr_org_code'] = $logged_in_user_branch;
        $data['transactionmode'] = config_item('transaction_mode');
        $data['bank_names_list'] = $this->config->item('bank_names_list');
        $data['namespace'] = $this->session->userdata('namespace_id');

        $this->load->view('site/payment/expense-v2', $data);
    }

    public function get_transit_transaction_list() {
        $this->is_logged_in();
        list($fromDate, $toDate) = explode(' | ', $this->input->post('daterange'));

        $result = $this->api_model->getTransitTransaction(array(
                'fromDate' => date('Y-m-d', strtotime($fromDate)),
                'toDate' => date('Y-m-d', strtotime($toDate)),
                'vehicleCode' => $this->input->post('vehicleCode'),
                'contactCode' => $this->input->post('contactCode') ?: '',
                'cashbookTypeCode' => $this->input->post('cashbookTypeCode') ?: 'HIRING'
        ));
        $result = json_decode($result);

        $transaction = array();
        $hire_amt = 0;
        $fuel_exp = 0;
        $advance_amt = 0;
        foreach ($result->data as $key => $val) {
            if ($val->cashbookType->code == 'HIRING') {
                $hire_amt += $val->amount;
            } elseif ($val->cashbookType->code == 'FUEL') {
                $fuel_exp += $val->amount;
            } elseif ($val->cashbookType->code == 'ADVANCE') {
                $advance_amt += $val->amount;
            }
        }
        $data['result'] = $result->data;
        $data['hire_amount'] = $hire_amt;
        $data['fuel_expense'] = $fuel_exp;
        $data['advance_amount'] = $advance_amt;
        $data['paymentType'] = $this->input->post('type');
        $data['transactionDate'] = $result->data[0]->transactionAt;

        $this->load->view('site/payment/transit-transaction-list', $data);
    }

    public function manage_expense_make_payment() {
        $this->is_logged_in();

        echo $this->api_model->updateManageExpensePayment(array(
                'vehicleCode' => $this->input->post('vehicleCode') ?: '',
                'cashbookTypeCode' => $this->input->post('cashbookTypeCode') ?: 'HIRING',
                'data' => array(
                    'activeFlag' => (int) $this->input->post('activeFlag'),
                    'amount' => (float) $this->input->post('amount'),
                    'transactionMode' => $this->input->post('transactionMode'),
                    'bankDetails' => $this->input->post('bankDetails') ?: null,
                    'transactions' => $this->input->post('transactions') ?: [],
                    'paymentToContact' => $this->input->post('paymentToContact'),
                    'chequeDetails' => $this->input->post('chequeDetails') ?: null,
                    'addAttr1' => $this->input->post('addAttr1') ?: '',
                    'addAttr2' => $this->input->post('addAttr2') ?: '',
                    'addAttr3' => $this->input->post('addAttr3') ?: ''
                )
            )
        );
    }

    public function get_branch_contact() {
        $this->is_logged_in();

        echo $this->api_model->getAllBranchContact(array(
                'organizationCode' => $this->input->post('organizationCode'),
                'categoryCode' => ''
        ));
    }

    public function update_cb_expense() {
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'cashbookCategory' => $this->input->post('cashbookCategory'),
            'referenceCode' => $this->input->post('referenceCode') ?: $this->session->userdata('org_code'),
            'cashbookType' => $this->input->post('cashbookType') ?: (object) ['code' => ''],
            'transactionType' => $this->input->post('transactionType'),
            'amount' => (int) $this->input->post('amount'),
            'cashbookTransactionDetails' => $this->input->post('cashbookTransactionDetails') ?: [],
            'user' => $this->input->post('user'),
            'cashbookVendor' => $this->input->post('cashbookVendor'),
            'cashbookEntryType' => $this->input->post('cashbookEntryType'),
            'transactionMode' => $this->input->post('transactionMode'),
            'acknowledgeStatus' => $this->input->post('acknowledgeStatus'),
            'receiptDate' => $this->input->post('receiptDate'),
            'tag' => $this->input->post('tag') ?: [],
            'remarks' => $this->input->post('remarks'),
            'chequeDetails' => $this->input->post('chequeDetails') ?: null,
            'bankDetails' => $this->input->post('bankDetails') ?: null,
            'addAttr1' => $this->input->post('addAttr1') ?: '',
            'addAttr2' => $this->input->post('addAttr2') ?: '',
            'addAttr3' => $this->input->post('addAttr3') ?: '',
            'additionalDetails' => $this->input->post('additionalDetails') ?: '',
        );

        if (empty($data['user']['code'])) {
            $data['user']['code'] = _get_user_id();
        }

        echo $this->api_model->updateCashbookTransaction($data);
    }

    public function update_expense_ledger_status() {
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'acknowledgeStatus' => $this->input->post('acknowledgeStatus'),
            'cashbookEntryType' => $this->input->post('cashbookEntryType')
        );

        echo $this->api_model->updateExpenseLedgerStatus($data);
    }

    function get_expenses_list() {
        $this->is_logged_in();
        $data = array(
            'queryCode' => 'RQK7TRB67UA',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'organizationCode' => $this->input->post('organizationCode') ?: 'NA',
            'userCode ' => $this->input->post('userCode'),
            'ackStatusCode ' => 'NA',
            'filterType ' => $this->input->post('filterType'),
            'tagCodes' => 'NA'
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        usort($result->data, function ($a, $b) {
            return (strtotime(trim($a->transaction_date)) > strtotime(trim($b->transaction_date))) ? -1 : 1;
        });
        $data['reports'] = $result->data;
        $data['expense_category_type'] = config_item('expense_category_type');
        $data['transaction_mode'] = config_item('transaction_mode');

        $result = $this->api_model->cargoTags();
        $result = json_decode($result);

        $tags = [];
        foreach ($result->data as $row) {
            $tags[$row->code] = $row;
        }
        $data['cargotags'] = $tags;

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/payment/userbalance-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=User-Balance.xls');
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
            $this->load->view('site/payment/init-expenses-list', $data);
        }
    }

    function ticket_details() {
        $this->is_logged_in();
        echo $this->api_model->ticketDetails(array(
                'ticketCode' => $this->input->post('pnr'),
        ));
    }

    function manage_expense() {
        $this->is_logged_in();

        $data['groupusers'] = get_active_group_and_users();

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        $result = $this->api_model->cargoTags();
        $result = json_decode($result);
        $data['cargotags'] = $result->data;
        $data['logged_in_usr_org_code'] = $this->session->userdata('org_code');

        $this->load->view('site/payment/manage-expense', $data);
    }

    public function manage_expense_report_list() {
        $this->is_logged_in();

        $fromDate = $this->input->post('from');
        $toDate = $this->input->post('to');
        $userCode = $this->input->post('user_code');
        $organizationCode = $this->input->post('organizationCode');
        $ackStatusCode = $this->input->post('ack_status');
        $tagCodes = $this->input->post('tag_codes');

        if ($this->input->get('print') == 1) {
            $fromDate = $this->input->get('from');
            $toDate = $this->input->get('to');
            $userCode = $this->input->get('user_code');
            $organizationCode = $this->input->get('organizationCode');
            $ackStatusCode = $this->input->get('ack_status');
            $tagCodes = $this->input->get('tag_codes');

            $branches = $this->api_model->getOrganization();
            $branches = json_decode($branches);
            $branches = $branches->data;
        }
        $data = array(
            'queryCode' => 'RQK7TRB67UA',
            'toDate' => $toDate,
            'fromDate' => $fromDate,
            'userCode' => $userCode ?: 'NA',
            'organizationCode' => $organizationCode ?: 'NA',
            'ackStatusCode' => $ackStatusCode ?: 'NA',
            'tagCodes' => implode(',', $tagCodes) ?: 'NA',
            'filterType' => 'DETAILS',
        );

        if (!has_action_rights('IE-BEHALF-BRACH') && !has_action_rights('IE-BEHALF-ALL')) {
            $data['userCode'] = _get_user_id();
        }
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $result = $result->data;

        $manageExpenseData = array();
        foreach ($result as $row) {
            if ($row->entry_type_code != 'EXLGR') {
                $manageExpenseData[] = $row;
            }
        }

        usort($manageExpenseData, function ($a, $b) {
            return $a->transaction_type < $b->transaction_type ? -1 : 1;
        });
        $data['result'] = $manageExpenseData;

        $summary = array();
        $series = array();
        foreach ($manageExpenseData as $row) {
            $date = date('Y-m-d', strtotime($row->settlement_date));
            $branch = str_replace(' ', '', strtolower($row->organization_name));
            $user = $row->user_code;
            $summary[$branch][$user]['settlement_date'] = $date;
            $summary[$branch][$user]['user_name'] = $row->user_name;
            $summary[$branch][$user]['alias_code'] = $row->alias_code;
            $summary[$branch][$user]['organization_name'] = $row->organization_name;
            if ($row->ack_status_code != 'REJT') {
                $summary[$branch][$user]['income'] += $row->credit_amount;
                $summary[$branch][$user]['expense'] += $row->debit_amount;

                $type = ($row->transaction_type == 'Cr') ? 'Income' : 'Expense';
                $series[$type]['name'] = $type;
                $series[$type]['drilldown'] = $type;
                $series[$type]['data'][$row->cashbook_type_name]['id'] = $type;
                $series[$type]['data'][$row->cashbook_type_name]['name'] = $row->cashbook_type_name;

                if ($row->transaction_type == 'Cr') {
                    $series[$type]['y'] += $row->credit_amount;
                    $series[$type]['data'][$row->cashbook_type_name]['y'] += $row->credit_amount;
                } else if ($row->transaction_type == 'Dr') {
                    $series[$type]['y'] += $row->debit_amount;
                    $series[$type]['data'][$row->cashbook_type_name]['y'] += $row->debit_amount;
                }
            }
            if ($row->ack_status_code == 'APRD') {
                $summary[$branch][$user]['settlement'] += ($row->credit_amount - $row->debit_amount);
            }
            $summary[$branch][$user]['list'][] = $row;
            if ($row->ack_status_code == 'INIT') {
                $summary[$branch][$user]['codes'][] = $row->transaction_code;
            }
            $statuscount = 'count_' . $row->ack_status_code;
            $summary[$branch][$user][$statuscount] += 1;
        }
        ksort($summary);
        $data['summary'] = $summary;
        $data['series'] = array_values($series);

        $result = $this->api_model->cargoTags();
        $result = json_decode($result);

        $tags = [];
        foreach ($result->data as $row) {
            $tags[$row->code] = $row;
        }
        $data['cargotags'] = $tags;

        $data['expense_category_type'] = config_item('expense_category_type');
        $data['transaction_mode'] = config_item('transaction_mode');

        if ($this->input->post('export') == 1) {
            $filename = 'Manage-expense-report';
            $this->load->excel('site/payment/manage-expense-list-xls', $data, $filename);
        } elseif ($this->input->get('print') == 1) {
            $organization = array();
            foreach ($branches as $brn) {
                $organization[$brn->code] = $brn;
            }
            $data['branches'] = $organization;

            require_once APPPATH . 'third_party/tcpdf/tcpdf.php';
            $pdf = new TCPDF();
            $pdf->SetTitle('Manage Expense Report');
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('helvetica', '', 7);
            $pdf->SetMargins(5, 10, 5, true);
            $pdf->AddPage();

            ob_clean();
            $this->load->exclude_template();

            $content = $this->load->view('site/payment/manage-expense-list-pdf', $data, true);
            $pdf->writeHTML($content);
            $pdf->Output('Manage Expense Report.pdf', 'i');
        } else {
            $this->load->view('site/payment/manage-expense-list', $data);
        }
    }

    public function update_payment_expense_status() {
        $this->is_logged_in();

        $codes = explode(',', $this->input->post('code'));


        foreach ($codes as $code) {
            $data = array(
                'code' => $code,
                'acknowledgeStatus' => $this->input->post('acknowledgeStatus'),
                'remarks' => $this->input->post('remarks')
            );

            $res = $this->api_model->updateCashbookStatus($data);
            $res = json_decode($res);

            if ($res->status != 1) {
                echo json_encode($res);
                return;
            }
        }

        echo json_encode(['status' => 1]);
    }

    function profit_and_loss() {
        $this->is_logged_in();

        $this->load->view('site/payment/profit-and-loss');
    }

    function profit_and_loss_list() {
        $this->is_logged_in();

        $daterange = $this->input->post('daterange') ?: ' | ';
        list($fromDate, $toDate) = explode(' | ', $daterange);

        $data = array(
            'queryCode' => 'RQL8RKX45',
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $list = array();
        $expenses = array();
        foreach ($result->data as $row) {
            $list['data'][$row->entity_type][] = $row;
            $list[$row->entity_type] += $row->entity_value;

            if ($row->entity_type == 'EXPANSE') {
                $expenses[$row->entity_attribute]['amount'] += $row->entity_value;
                $expenses[$row->entity_attribute]['count']++;
                $expenses[$row->entity_attribute]['name'][$row->entity_name] = $row->entity_name;
            }
        }
        ksort($expenses);
        $data['result'] = $list;
        $data['expenses'] = $expenses;

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
            foreach ($expenses as $expense => $r) {
                $this->excel->getActiveSheet()->setCellValue('A' . $row, $expense);
                $this->excel->getActiveSheet()->setCellValue('D' . $row++, $r['amount']);
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
        } else if ($this->input->post('pdf') == 1) {
            require_once APPPATH . 'third_party/tcpdf/tcpdf.php';

            $pdf = new TCPDF();
            $pdf->setPrintHeader(false);
            $pdf->setPrintFooter(false);
            $pdf->SetFont('helvetica', '', 10);
            $pdf->AddPage();

            ob_clean();
            $this->load->exclude_template();
            $content = $this->load->view('site/payment/profit-and-loss-pdf', $data, true);
            $pdf->writeHTML($content);

            $pdf->Output('Profit-and-Loss.pdf', 'd');
        } else {
            echo $this->load->view('site/payment/profit-and-loss-list', $data);
        }
    }

    function cheque() {
        $this->is_logged_in();

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        $bank = $this->api_model->getOrganizationOtherDetails(array(
                'organizationcode' => $this->session->userdata('org_code')
        ));
        $bank = json_decode($bank);
        $data['bank_detail'] = $bank->data;

        $data['logged_in_usr_org_code'] = $this->session->userdata('org_code');
        $data['cheque_status'] = config_item('cheque_status');
        $data['transactionmode'] = config_item('transaction_mode');
        $data['bank_names_list'] = $this->config->item('bank_names_list');

        $this->load->view('site/payment/cheque', $data);
    }

    function cheque_list() {
        $this->is_logged_in();

        $daterange = $this->input->post('daterange') ?: ' | ';
        list($fromDate, $toDate) = explode(' | ', $daterange);

        $data = array(
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'statusCode' => $this->input->post('statusCode'),
            'organizationCode' => $this->input->post('organizationCode')
        );
        $result = $this->api_model->getChequeDetails($data);
        $result = json_decode($result);

        $data['result'] = $result->data;
        $data['cheque_status'] = config_item('cheque_status');
        $this->load->view('site/payment/cheque-list', $data);
    }

    function update_cheque_status(){
        $this->is_logged_in();

        $checkStatus = $this->input->post('chequeStatus');
        if ($checkStatus['code'] != 'OTHERS') {
            $data = array(
                'code' => $this->input->post('code'),
                'activeFlag' => $this->input->post('activeFlag'),
                'chequeStatus' => $checkStatus,
                'chequeDepositDate' => $this->input->post('chequeDepositDate') ?: '',
                'chequeRealizeDate' => $this->input->post('chequeRealizeDate') ?: '',
                'chequeRealizeDetails' => $this->input->post('chequeRealizeDetails') ?: '',
                'namespaceBank' => $this->input->post('namespaceBank'),
                'remarks' => $this->input->post('remarks') ?: '',
            );
            echo $this->api_model->updateChequeStatus($data);
        } else {
            $data = array(
                'code' => '',
                'checkCode' => $this->input->post('code'),
                'activeFlag' => $this->input->post('activeFlag'),
                'transactionMode' => $this->input->post('transactionMode'),
                'bankDetails' => array('code' => $this->input->post('bankDetails')),
                'chequeDetails' => $this->input->post('chequeDetails') ?: null,
                'addAttr1' => $this->input->post('addAttr1') ?: '',
                'addAttr2' => $this->input->post('addAttr2') ?: '',
                'addAttr3' => $this->input->post('addAttr3') ?: '',
                'amountReceivedDate' => $this->input->post('amountReceivedDate'),
                'remarks' => $this->input->post('remarks') ?: '',
            );
            echo $this->api_model->updateTransactionReceiptCheque($data);
        }
    }

    function cheque_history() {
        $this->is_logged_in();
        $data = array(
            'chequeDetailsCode' => $this->input->post('chequeDetailsCode')
        );

        $result = $this->api_model->getChequeHistory($data);
        $result = json_decode($result);
        $data['cheque_history'] = $result->data;

        $this->load->view('site/payment/cheque-history', $data);
    }

    function transaction_receipt() {
        $this->is_logged_in();

        $userOrganization = $this->session->userdata('org_code');
        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
        $fromDate = $fromDate ? date('Y-m-d', strtotime($fromDate)) : 'NA';
        $toDate = $toDate ? date('Y-m-d', strtotime($toDate)) : 'NA';

        $data = array(
            'queryCode' => 'RQJ8ODQ52',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'organizationCode' => 'NA',
            'transitOrganizationCode' => $userOrganization,
            'cargoStatusCode' => 'CUL',
            'stationCode' => 'NA',
            'filterType' => 'DETAILS',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $pendingDeliveryList = array();
        $customers = array();
        foreach ($result->data as $row) {
            $row->balance_amount = $row->total_amount + $row->other_charges - $row->customer_tds_tax - $row->total_amount_paid;
            if ($row->balance_amount > 0 && $row->payment_type_code != 'INP' && $row->payment_type_code != 'OATP') {
                $pendingDeliveryList[] = $row;
                $customers[$row->to_customer_mobile]['name'] = $row->to_customer_name;
                $customers[$row->to_customer_mobile]['mobileNumber'] = $row->to_customer_mobile;
            }
        }

        $data['pendingDeliveryList'] = $pendingDeliveryList;
        $data['customers'] = array_values($customers);

        // bank detail
        $bankdetail = $this->api_model->getOrganizationOtherDetails(array(
                'organizationcode' => $this->session->userdata('org_code')
        ));
        $bankdetail = json_decode($bankdetail);
        $data['bankdetail'] = $bankdetail->data->bankDetails;

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $data['users'] = $users->data;

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        // unpaid invoice
        $result = $this->api_model->getUnpaidVouchers();
        $result = json_decode($result);

        $unpaidInvoices = array();
        $vendors = array();
        foreach ($result->data as $row) {
            $partialTransactionTotalAmount = 0;
            foreach ($row->partialPaymentList as $payment) {
                $partialTransactionTotalAmount += $payment->transactionAmount + $payment->tdsTax + $payment->adjustmentAmount;
            }
            $row->balanceAmount = $row->transactionAmount - $partialTransactionTotalAmount;

            if ($row->balanceAmount > 0 && $row->transactionType->code == 'CGINVPA' && ($row->acknowledgeStatus->code == 'PAID' || $row->acknowledgeStatus->code == 'PAPAID')) {
                $unpaidInvoices[] = $row;
                $row->cargoVendor->companyName = $row->user->name;
                $row->cargoVendor->user = new stdClass;
                $row->cargoVendor->user->code = $row->user->code;
                $row->cargoVendor->user->name = $row->user->name;
                $vendors[$row->cargoVendor->code] = $row->cargoVendor;
            }
        }

        $data['unpaidinvoice'] = $unpaidInvoices;
        $data['vendors'] = array_values($vendors);

        $vendors = $this->api_model->cargoCustomerVendor();
        $vendors = json_decode($vendors);
        $data['allvendors'] = $vendors->data;

        $data['bank_names_list'] = $this->config->item('bank_names_list');
        $data['transactionmode'] = config_item('transaction_mode');
        $data['cargostatus'] = config_item('cargo_status');
        $data['userOrganization'] = $userOrganization;

        $this->load->view('site/payment/transaction-receipt', $data);
    }
   
    function get_demurage_details(){
       $data = array();
       $cargo_codes = $this->input->post('cargoCodes');
       foreach($cargo_codes as $code){
         $raw_response = $this->api_model->checkDemurrageCharge(array('cargoCode' => $code));
         $response_data = getData($raw_response); 
         $data[] = array($code => $response_data);
       }
       response(true,$data,'working fine');
    }


    function transaction_receipt_list() {
        $this->is_logged_in();

        $from = $this->input->post('fromDate');
        $to = $this->input->post('toDate');

        $data = array(
            'fromDate' => date('Y-m-d', strtotime($from)),
            'toDate' => date('Y-m-d', strtotime($to)),
            'organizationCode' => $this->input->post('organizationCode'),
            'receiptType' => $this->input->post('receiptType'),
            'userCode' => $this->input->post('userCode'),
            'receiptStatus' => $this->input->post('receiptStatus') ?: '',
            'customerMobile' => ''
        );
        $result = $this->api_model->getAllTransactionReceipt($data);
        $result = json_decode($result);

        $data['result'] = array_reverse($result->data);

        $this->load->view('site/payment/transaction-receipt-list', $data);
    }

    function transaction_receipt_print() {
        $this->is_logged_in();

        $result = $this->api_model->getTransactionReceipt(array('receiptCode' => $this->input->get('receiptCode')));
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['summary'] = $result->data->cargoBookings;
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $usr_pro = $this->api_model->getUserProfile(array('authtoken' => $this->session->userdata('user_hash')));
        $usr_pro = json_decode($usr_pro);
    
        
        $organizationCode= $usr_pro->data->organization->code;
        $organizationDetails = $this->api_model->getOrganizationDetails(array('organizationcode' =>$organizationCode));
        $organizationDetails = json_decode($organizationDetails);
        $data['user_profile'] = $usr_pro->data;
        $data['organizationDetails']  = $organizationDetails->data;
        
        $bank_detail = $this->api_model->getAllBankDetails(array(
                'entityTypeCode' => 'NMSP',
                'referenceCode' => _get_namespace_id()
            ));
        $bank_detail = json_decode($bank_detail);
        $data['bank_detail'] = $bank_detail->data;

        $nsprofile = $this->api_model->getNamespaceProfile(array('authtoken' => $this->_user_hash));
        $nspro = json_decode($nsprofile);
        $data['nsprofile'] = $nspro->data;
        $gst = $this->api_model->getGstDetails();
        $gst = json_decode($gst);
        $ReceiptLr = [];
        foreach($result->data->cargoBookings  as $val){
            $summary = $this->api_model->getCargoSummary(array('cargoCode' => $val->code));
            $summary = json_decode($summary);
            $ReceiptLr[]=$summary->data;
        }

        $fromBranchDetails = $this->api_model->getOrganizationDetails(array(
            'organizationcode' => $ReceiptLr[0]->fromOrganization->code,
        ));
        $fromBranchDetails =json_decode($fromBranchDetails);
        
        $deliveryBranchGstCode ='';
        foreach ($gst->data as $val){
            if($fromBranchDetails->data[0]->station->state->code==$val->state->code){
                $deliveryBranchGstCode =$val;
            }
        }
        $data['no_of_copy'] = 1;
        $data['deliveryBranchGstCode']=$deliveryBranchGstCode;
        $data['ReceiptLr'] =$ReceiptLr;
        $gstin = ['gstin' =>$ReceiptLr[0]->toCustomerGST,];
        $GstDetails =$this->api_model->getGSTDetailsApi($gstin);
        $GstDetails = json_decode($GstDetails);
        $data['GstDetails']=$GstDetails->data;

        $data['Gststate'] =$GstDetails->data->state->code; 
        $data['gst_state'] =config_item('get_gst_state');

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
        $content = $this->load->view('site/payment/transaction-receipt-print-seenutransport', $data, true);

        $pdf->writeHTML($content);

        $pdf->Output('Transaction Receipt.pdf', 'i');
    }

    function update_transaction_receipt() {
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'cargoCustomer' => $this->input->post('cargoCustomer') ?: null,
            'cargoVendor' => $this->input->post('cargoVendor') ?: null,
            'receiptReferenceType' => $this->input->post('receiptReferenceType') ?: null,
            'user' => $this->input->post('user') ?: null,
            'driver' => $this->input->post('driver') ?: null,
            'organizationContact' => $this->input->post('organizationContact') ?: null,
            'transactionAmount' => $this->input->post('transactionAmount'),
            'partialAmount' => $this->input->post('partialAmount') ?: 0,
            'tdsAmount' => $this->input->post('tdsAmount') ?: 0,
            'machineHandlingCharge' => $this->input->post('machineHandlingCharge') ?: 0,
            'demurrageCharge' => $this->input->post('demurrageCharge') ?: 0,
            'podCharge' => $this->input->post('podCharge') ?: 0,
            'transactionMode' => $this->input->post('transactionMode'),
            'bankDetails' => array('code' => $this->input->post('bankDetails')),
            'chequeDetails' => $this->input->post('chequeDetails') ?: null,
            'transactionReceiptType' => $this->input->post('transactionReceiptType'),
            'cargoBookings' => $this->input->post('cargoBookings') ?: [],
            'paymentTransactions' => $this->input->post('paymentTransactions') ?: [],
            'addAttr1' => $this->input->post('addAttr1') ?: '',
            'addAttr2' => $this->input->post('addAttr2') ?: '',
            'addAttr3' => $this->input->post('addAttr3') ?: '',
            'amountReceivedDate' => $this->input->post('amountReceivedDate'),
            'remarks' => $this->input->post('remarks') ?: '',
        );
        echo $this->api_model->updateTransactionReceipt($data);
    }

    function update_transaction_receipt_status() {
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'receiptStatus' => $this->input->post('receiptStatus'),
            'remarks' => $this->input->post('remarks') ?: '',
        );
        echo $this->api_model->updateTransactionReceiptStatus($data);
    }

    function get_vendor_advance_payment() {
        $this->is_logged_in();

        $data = array(
            'fromDate' => date('Y-m-d', strtotime('-1 month')),
            'toDate' => date('Y-m-d'),
            'organizationCode' => 'NA',
            'receiptType' => 'ADV',
            'userCode' => $this->input->post('userCode'),
            'receiptStatus' => $this->input->post('receiptStatus') ?: '',
            'customerMobile' => $this->input->post('mobileNumber') ?: '',
            'filterType' => $this->input->post('filterType') ?: 'ADV',
            'receiptReferenceTypeCode' => 'VDR'
        );
        $result = $this->api_model->getAllTransactionReceipt($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['respcode']=$this->input->post('respcode');

        // $datas = array(
        //     'vendorCode' => $this->input->post('vendorCode'),
        //     'fromDate' => $this->input->post('fromDate') ?: date('Y-m-d', strtotime('-1 month')),
        //     'toDate' => $this->input->post('toDate') ?: date('Y-m-d')
        // );
        // echo $this->api_model->getVendorAdvanvcePayment($datas);
        $data['transactionmode'] = config_item('transaction_mode');
        $this->load->view('site/payment/transaction-receipt-vendor-advance-amount', $data);
    }

    public function ledger_report() {
        $this->is_logged_in();
        $data = array();

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
        $data['contact'] = $contact->data;

        $vehicle = $this->api_model->getVehicle();
        $vehicle = json_decode($vehicle);
        $data['vehicles'] = $vehicle->data;

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        $triphead = $this->api_model->getCashbookHead();
        $triphead = json_decode($triphead);
        $data['triphead'] = $triphead->data;

        $trans_mode = $this->api_model->getTransMode(array());
        $transaction_mode = json_decode($trans_mode);
        $data['t_mode'] = $transaction_mode->data;

        $this->load->view('site/cargo/ledger-report', $data);
    }

    public function ledger_report_list() {
        $this->is_logged_in();
        
        $fromDate = trim($this->input->post('fromDate'));
        $toDate = trim($this->input->post('toDate'));
       
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


        $ledgerReferenceType = $this->input->post('ledgerReferenceType');
        if ($ledgerReferenceType == 'VEH') {
            $referenceType = $this->input->post('vehicleReferenceCode');
        } else {
            $referenceType = $this->input->post('branchReferenceCode');
        }

        $showExpenseLedgerContact = $this->input->post('showExpenseLedgerContact');
        if ($showExpenseLedgerContact == 1) {
            $contactCategoryCode = $this->input->post('contactCategoryCode');
            $contactCode = $this->input->post('contactCode');
        } else {
            $contactCode = $this->input->post('contactFilterCode');
        }
        $data = array(
            
            'fromDate' => date('Y-m-d', strtotime($fromDate)),
            'toDate' => date('Y-m-d', strtotime($toDate)),
            'contactCategoryCode' => $contactCategoryCode ?: 'NA',
            'contactCode' => $contactCode ?: 'NA',
            'accountCode' => $this->input->post('accountCode') ?: 'NA',
            'referenceCode' => $referenceType ?: 'NA'
        );

        $p_key = _get_namespace_id() . '_ledger_report_' . md5(http_build_query($data));
        if ($this->input->post('export') == 1) { //  serve export data from cache
            if (!$result = $this->rediscache->get($p_key)) {
                $result = $this->api_model->getLedgerTransactionReportv2($data);
                $this->rediscache->set($p_key, $result, 600); //  10 mins
            }
        } else {
            $result = $this->api_model->getLedgerTransactionReportv2($data);
            $this->rediscache->set($p_key, $result, 600); //  10 mins
        }
        $result = json_decode($result);

        $openingBalanceAmount = 0;
        $totalCreditAmount = 0;
        $totalDebitAmount = 0;
        foreach ($result->data as $row) {
            if ($row->activeFlag == 5) {
                $openingBalanceAmount = $row->closingBalanceAmount;
            }
            $totalCreditAmount += $row->creditAmount;
            $totalDebitAmount += $row->debitAmount;
        }
        $data['accountName'] = $this->input->post('contactFilterCode');
        $data['fromDate'] = $this->input->post('fromDate');
        $date['toDate'] = $this->input->post('toDate');
        $data['openingBalanceAmount'] = $openingBalanceAmount;
        $data['closingBalanceAmount'] = $result->data[count($result->data) - 2]->closingBalanceAmount;
        $data['createdAt'] = $result->data[0]->createdAt;
        $data['totalCreditAmount'] = $totalCreditAmount;
        $data['totalDebitAmount'] = $totalDebitAmount;
        $data['contactType'] = $this->input->post('contactType');
        $data['result'] = $result->data;

        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');

        $data['remarks_required'] = $this->input->post('requiredRemark');

        if ($this->input->post('export') == 1) {
            $filename = 'Ledger Report';
            $this->load->excel('site/cargo/ledger-report-list', $data, $filename);
        } 
        else if($this->input->post('print') == '1'){
            $accountType = array();
            $totalDebit =0;
            $totalCredit =0;

           foreach($result->data as $singleRow){
            $accountType[trim($singleRow->toContact->name)]['count'] += 1;
            $accountType[trim($singleRow->toContact->name)]['debit']  += $singleRow->debitAmount;
            $totalDebit +=  $singleRow->debitAmount;
            $totalCredit += $singleRow->creditAmount;
            $accountType[trim($singleRow->toContact->name)]['credit']  += $singleRow->creditAmount;

           }
           $data['totalDebit'] = $totalDebit;
           $data['totalCredit'] = $totalCredit;
           $data['accountType'] = $accountType;
            $this->load->view('site/cargo/ledger-report-print-seenutransport', $data);
        }
       else if($this->input->post('Summaryprint') == '1'){
        $this->load->view('site/cargo/ledger-report-Summaryprint-seenutransport', $data);

       } else {
            $this->load->view('site/cargo/ledger-report-list', $data);
        }
    }

    function update_ledger_brs_status(){
        $this->is_logged_in();

        $code = implode(',', $this->input->post('code'));
        $data = array(
            'code' => $code ?: '',
            'brsStatus' => $this->input->post('brsStatus')
        );
        echo $this->api_model->updateLedgerBrsStatus($data);
    }

    function update_ledger_adjustment(){
        $this->is_logged_in();

        $data = array(
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'referenceCode' => $this->input->post('referenceCode'),
            'description' => $this->input->post('description'),
            'creditAmount' => (float) $this->input->post('creditAmount'),
            'debitAmount' => (float) $this->input->post('debitAmount'),
            'cashbookType' => $this->input->post('cashbookType'),
            'contact' => $this->input->post('contact'),
            'contactBankDetails' => $this->input->post('contactBankDetails'),
            'transactionMode' => $this->input->post('transactionMode')
        );
        echo $this->api_model->updateLedgerAdjustment($data);
    }

    public function contra_transfer() {
        $this->is_logged_in();

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organization'] = $organization->data;

        $logged_in_user = array();
        foreach ($organization->data as $org) {
            if ($org->code == $this->session->userdata('org_code')) {
                $logged_in_user = $org;
            }
        }
        $data['logged_in_user'] = $logged_in_user;

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $data['users'] = $users->data;
        $data['user_code'] = $this->session->userdata('user_id');
        $branchBankData = $this->api_model->getBranchBankContactDetails();
        $branchBankData = json_decode($branchBankData);

        usort($branchBankData->data, function ($a, $b) {
            return strtolower($a->name) < strtolower($b->name) ? -1 : 1;
        });

        $data['branchBankData'] = $branchBankData->data;
        $data['loggedin_user_org'] = $this->session->userdata('org_code');

        $this->load->view('site/payment/contra-transfer', $data);
    }

    public function contra_transfer_init_list() {
        $this->is_logged_in();

        $data = array(
            'fromDate' => '',
            'toDate' => '',
            'organizationCode' => $this->input->post('organizationCode'),
            'paymentStatusCode' => 'INIT'
        );

        $result = $this->api_model->getContraTransferList($data);
        $result = json_decode($result);
        $data['result'] = array_reverse($result->data);
        $data['loggedin_user_org'] = $this->session->userdata('org_code');

        $this->load->view('site/payment/contra-transfer-init-list', $data);
    }

    public function contra_transfer_ack_list() {
        $this->is_logged_in();

        $data = array(
            'fromDate' => '',
            'toDate' => '',
            'organizationCode' => $this->input->post('organizationCode'),
            'paymentStatusCode' => 'PAID'
        );

        $result = $this->api_model->getContraTransferList($data);
        $result = json_decode($result);
        $data['result'] = array_reverse($result->data);
        $data['loggedin_user_org'] = $this->session->userdata('org_code');

        $this->load->view('site/payment/contra-transfer-ack-list', $data);
    }

    public function contra_transfer_paid_list() {
        $this->is_logged_in();

        $organization = $this->session->userdata('org_code');
        if (has_action_rights('CONTRA-ALLOW-ALL-BRANCH')) {
            $organization = $this->input->post('organizationCode');
        }

        $data = array(
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'organizationCode' => $organization,
            'paymentStatusCode' => 'ACK'
        );

        $result = $this->api_model->getContraTransferList($data);
        $result = json_decode($result);
        $data['result'] = array_reverse($result->data);

        $this->load->view('site/payment/contra-transfer-paid-list', $data);
    }

    public function get_branch_details() {
        $this->is_logged_in();

        echo $this->api_model->getOrganizationOtherDetails(array(
                'organizationcode' => $this->input->post('organizationcode')
        ));
    }

    public function update_contra_transfer() {
        $this->is_logged_in();

        echo $this->api_model->updateContraTransfer(array(
                'code' => $this->input->post('code'),
                'activeFlag' => (int) $this->input->post('activeFlag'),
                'amount' => $this->input->post('amount'),
                'transactionDate' => $this->input->post('transactionDate'),
                'paymentContact' => $this->input->post('paymentContact'),
                'vendorContact' => $this->input->post('vendorContact'),
                'paymentStatus' => $this->input->post('paymentStatus'),
                'remarks' => $this->input->post('remarks')
        ));
    }

    public function update_contra_transfer_status() {
        $this->is_logged_in();

        echo $this->api_model->updateContraTransferStatus(array(
                'code' => $this->input->post('code'),
                'activeFlag' => (int) $this->input->post('activeFlag'),
                'paymentStatus' => $this->input->post('paymentStatus'),
                'remarks' => $this->input->post('remarks')
        ));
    }

    public function journal_transaction() {
        $this->is_logged_in();
        $data = array();

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

        $triphead = $this->api_model->getCashbookHead();
        $triphead = json_decode($triphead);
        $data['triphead'] = $triphead->data;

        $vehicle = $this->api_model->getVehicle();
        $vehicle = json_decode($vehicle);
        $data['vehicles'] = $vehicle->data;

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        $this->load->view('site/cargo/journal-transaction', $data);
    }

    public function journal_transaction_list() {
        $this->is_logged_in();

        $param = array(
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'paymentContactCode' => $this->input->post('paymentContactCode'),
            'contactCategoryCode' => $this->input->post('contactCategoryCode'),
            'ackStatusCode' => $this->input->post('acknowledgeStatus'),
            'categoryCode' => $this->input->post('categoryCode'),
            'referenceCode' => $this->input->post('referenceCode')
        );
        $result = $this->api_model->getJournalTransactionList($param);
        $result = json_decode($result);
        $data['result'] = $result->data;

        if ($this->input->post('acknowledgeStatus') == 'INIT') {
            $param['ackStatusCode'] = 'REJT';

            $reject = $this->api_model->getJournalTransactionList($param);
            $reject = json_decode($reject);
            $data['reject'] = $reject->data;
        }

        $data['acknowledgeStatus'] = $this->input->post('acknowledgeStatus');
        $data['username'] = $this->session->userdata('user_name');
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['delivery_type_codes'] = config_item('delivery_type_codes');

        if ($this->input->post('export') == 1) {
            $filename = 'Ledger Report';
            $this->load->excel('site/cargo/journal-transaction-list', $data, $filename);
        } else {
            $this->load->view('site/cargo/journal-transaction-list', $data);
        }
    }

    public function update_journal_transaction() {
        $this->is_logged_in();

        echo $this->api_model->updateJournalTransaction(array(
                'code' => $this->input->post('code'),
                'activeFlag' => (int) $this->input->post('activeFlag'),
                'paymentContact' => $this->input->post('paymentContact'),
                'vendorContact' => $this->input->post('vendorContact'),
                'cashbookCategory' => $this->input->post('cashbookCategory'),
                // 'cashbookType' => $this->input->post('cashbookType'),
                'referenceCode' => $this->input->post('referenceCode'),
                'transactionAmount' => (int) $this->input->post('transactionAmount'),
                'tdsAmount' => (int) $this->input->post('tdsAmount'),
                'acknowledgeStatus' => $this->input->post('acknowledgeStatus'),
                'paymentDate' => $this->input->post('paymentDate'),
                'referenceNumber' => $this->input->post('referenceNumber'),
                'remarks' => $this->input->post('remarks')
        ));
    }

    public function update_journal_status() {
        $this->is_logged_in();

        echo $this->api_model->updateJournalStatus(array(
                'code' => $this->input->post('code'),
                'acknowledgeStatus' => $this->input->post('acknowledgeStatus')
        ));
    }

    public function receipt_entry() {
        $this->is_logged_in();
        $data = array();

        $drivers = $this->api_model->getVehicleDriver();
        $drivers = json_decode($drivers);
        $data['drivers'] = $drivers->data;

        $vehicle = $this->api_model->getVehicle();
        $vehicle = json_decode($vehicle);
        $data['vehicles'] = $vehicle->data;

        $vendors = $this->api_model->cargoCustomerVendor();
        $vendors = json_decode($vendors);
        $data['vendors'] = $vendors->data;

        $contact = $this->api_model->getContactv2();
        $contact = json_decode($contact);

        $category_contacts = array();
        foreach ($contact->data as $row) {
            if (in_array($row->contactCategory->actionCode, ['VEH', 'BSTF'])) {
                continue;
            }
            if (!isset($category_contacts[$row->contactCategory->code])) {
                $contactCategory = clone $row->contactCategory;
                $contactCategory->contacts = [];
                $category_contacts[$row->contactCategory->code] = $contactCategory;
            }
            $category_contacts[$row->contactCategory->code]->contacts[] = $row;
        }
        $data['category_contacts'] = $category_contacts;

        $users = $this->api_model->getUser();
        $users = json_decode($users);

        $usrbranch = array();
        foreach ($users->data as $row) {
            $usrbranch[$row->organization->code]['code'] = $row->organization->code;
            $usrbranch[$row->organization->code]['name'] = $row->organization->name;
            $usrbranch[$row->organization->code]['users'][] = $row;
        }
        usort($usrbranch, function ($a, $b) {
            return strcasecmp($a['name'], $b['name']);
        });
        $data['branchusers'] = $usrbranch;

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        // $branch_contact = $this->api_model->getAllBranchContact(array(
        //     'organizationCode' => $this->input->post('organizationcode'),
        //     'categoryCode' => $this->input->post('categoryCode') ?: ''
        // ));

        // $branch_contact = json_decode($branch_contact);
        // $data['branch_contact'] = $branch_contact->data;

        $bankdetail = $this->api_model->getOrganizationOtherDetails(array(
                'organizationcode' => $this->session->userdata('org_code')
        ));
        $bankdetail = json_decode($bankdetail);
        $data['bankdetail'] = $bankdetail->data->bankDetails;

        $data['transactionmode'] = config_item('transaction_mode');
        $data['bank_names_list'] = $this->config->item('bank_names_list');
        $data['loggedin_org'] = $this->session->userdata('org_code');

        $this->load->view('site/payment/receipt-entry', $data);
    }

    public function receipt_entry_list() {
        $this->is_logged_in();

        $fromDate = $this->input->post('fromDate');
        $toDate = $this->input->post('toDate');

        $result = $this->api_model->getReceiptEntry(array(
                'fromDate' => date('Y-m-d', strtotime($fromDate)),
                'toDate' => date('Y-m-d', strtotime($toDate)),
                'organizationCode' => $this->input->post('organizationCode') ?: 'NA'
        ));
        $result = json_decode($result);
        $data['result'] = $result->data;

        $this->load->view('site/payment/receipt-entry-list', $data);
    }

    public function get_vehicle_transit_transaction_list() {
        $this->is_logged_in();

        $fromDate = date('Y-m-d', strtotime('-3 months'));
        $toDate = date('Y-m-d');
        $result = $this->api_model->getTransitTransaction(array(
                'fromDate' => $fromDate,
                'toDate' => $toDate,
                'vehicleCode' => $this->input->post('vehicleCode'),
                'contactCode' => $this->input->post('contactCode') ?: '',
                'cashbookTypeCode' => $this->input->post('cashbookTypeCode') ?: 'ADVANCE'
        ));
        $result = json_decode($result);

        $data['result'] = $result->data;

        $this->load->view('site/payment/vehicle-transit-transaction-list', $data);
    }

    public function get_transaction_receipt_transaction_list() {
        $this->is_logged_in();

        $data = array(
            'receiptType' => $this->input->post('receiptType'),
            'referenceCode' => $this->input->post('referenceCode'),
            'action' => 'RECEIPT_ENTRY'
        );
        $result = $this->api_model->getTransactionReceiptByReceiptType($data);
        $result = json_decode($result);

        $data['result'] = array_reverse($result->data);

        $this->load->view('site/payment/transaction-receipt-transaction-list', $data);
    }

    public function update_receipt_entry() {
        $this->is_logged_in();

        $receipt_date = $this->input->post('receiptDate');
        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'user' => array('code' => $this->session->userdata('user_id')),
            'receiptEntryType' => $this->input->post('receiptEntryType'),
            'paymentByContact' => $this->input->post('paymentByContact') ?: null,
            'cargoVendor' => $this->input->post('cargoVendor') ?: null,
            'busVehicle' => $this->input->post('busVehicle') ?: null,
            'transactions' => $this->input->post('transactions') ?: [],
            'acknowledgeStatus' => $this->input->post('acknowledgeStatus'),
            'receiptDate' => date('Y-m-d', strtotime($receipt_date)),
            'transactionMode' => $this->input->post('transactionMode'),
            'chequeDetails' => $this->input->post('chequeDetails') ?: null,
            'bankDetails' => $this->input->post('bankDetails') ?: array('code' => ''),
            'addAttr1' => $this->input->post('addAttr1') ?: '',
            'addAttr2' => $this->input->post('addAttr2') ?: '',
            'addAttr3' => $this->input->post('addAttr3') ?: '',
            'amount' => (int) $this->input->post('amount'),
            'remarks' => $this->input->post('remarks'),
        );

        echo $this->api_model->updateReceiptEntry($data);
    }

    public function update_receipt_entry_status() {
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'acknowledgeStatus' => $this->input->post('acknowledgeStatus')
        );

        echo $this->api_model->updateReceiptEntryStatus($data);
    }

    public function transit_record_topay_payment(){
        $this->is_logged_in();
        $data = array();

        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['zone'] = $zone->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $all_zone_stations = array();
        foreach($zone->data as $key => $zones) {
            foreach($zones->stations as $k => $station) {
                $all_zone_stations[] = $station->code;
            }
        }

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $organization = array();
        foreach ($branches->data as $key => $branch) {
            if (in_array($branch->station->code, $all_zone_stations)) {
                $organization[] = $branch;
            }
        }

        usort($organization, function ($a, $b) {
            return strcasecmp($a->name, $b->name);
        });
        $data['organization'] = $organization;

        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $this->load->view('site/payment/transit-record-topay-payment', $data);
    }
    
    public function transit_record_topay_payment_list(){
        $this->is_logged_in();

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));
       
        if($fromDate=="NA"){
            $from_date = "NA";
            $to_date = "NA";
        }else{
            $from_date = date('Y-m-d', strtotime($fromDate));
            $to_date = date('Y-m-d', strtotime($toDate));
        }
       
        $status =$this->input->post('status');
        $printStatus = $this->input->post('printStatus');

        $data = array(
            'queryCode' => 'RQNAAK4161',
            'fromDate' => $from_date,
            'toDate' => $to_date,
            'filterType' => 'STATION',
            'filterCode' => $this->input->post('filterCode'),
            'transitStatus' => 'DISPATCH',
            'paymentStatusCode' => 'TOP',
            'requestType' => 'SUMMARY',
            'transitCode' => 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        usort($result->data, function ($a, $b) {
            return (strtotime(trim($a->loaded_date)) < strtotime(trim($b->loaded_date))) ? -1 : 1;
        });
        $stationWise =array();

        foreach($result->data as $val){
            $stationWise[$val->transit_alias_code][$val->related_station_code]['data'][] = $val;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['code'] = $val->related_station_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['related_station_code'] = $val->related_station_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['station_code'] = $val->station_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['load_date'] = $val->loaded_date;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['ogpl_no'] = $val->transit_alias_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['vehicle'] = $val->registration_number;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['branch_code'] = $val->organization_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['transit_code'] = $val->transit_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['related_organization_code'] = $val->related_organization_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['from_station_name'] = $val->transit_from_station_name;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['to_station_name'] = $val->related_station_name;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['topay_amount'] += $val->topay_amount;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['payable_amt'] += (($val->topay_amount) - ($val->topay_hamali_charge + $val->topay_demurrage_charge + $val->topay_unload_handling_amount));
            $stationWise[$val->transit_alias_code][$val->related_station_code]['paid_amt'] += $val->transit_payment_amount;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['bal_amt'] += (($val->topay_amount) - ($val->topay_hamali_charge + $val->topay_demurrage_charge + $val->topay_unload_handling_amount)-($val->transit_payment_amount));
            $stationWise[$val->transit_alias_code][$val->related_station_code]['remark'] .=$val->transit_payment_remarks != null ? $val->transit_payment_remarks . ", " : "";

        }
        
        $summaryWise = array();
        foreach ($stationWise as $transitCode => $stations) {
            foreach ($stations as $relatedCode => $station) {
                if ($station['bal_amt'] > 0){
                    $summaryWise[$relatedCode]['name'] = 'UNPAID';
                    $summaryWise[$relatedCode]['to_station_name'] = $station['to_station_name'];
                    $summaryWise[$relatedCode]['payable_amt'] += $station['payable_amt'];
                    $summaryWise[$relatedCode]['paid_amt'] += $station['paid_amt'];
                    $summaryWise[$relatedCode]['bal_amt'] += $station['bal_amt'];
                }
            }
        }
    
        $summaryWisePaid = array();
        foreach ($stationWise as $transitCode => $stations) {
            foreach ($stations as $relatedCode => $station) {
                if ($station['paid_amt'] >= 0 && $station['bal_amt'] <= 0){
                    $summaryWisePaid[$relatedCode]['name'] = 'PAID';
                    $summaryWisePaid[$relatedCode]['to_station_name'] = $station['to_station_name'];
                    $summaryWisePaid[$relatedCode]['payable_amt'] += $station['payable_amt'];
                    $summaryWisePaid[$relatedCode]['paid_amt'] += $station['paid_amt'];
                    $summaryWisePaid[$relatedCode]['bal_amt'] += $station['bal_amt'];
                }
            }
        }


        $summaryWiseall = array();
        foreach ($stationWise as $transitCode => $stations) {
            foreach ($stations as $relatedCode => $station) {
                $summaryWiseall[$relatedCode]['name'] = 'ALL';
                $summaryWiseall[$relatedCode]['to_station_name'] = $station['to_station_name'];
                $summaryWiseall[$relatedCode]['payable_amt'] += $station['payable_amt'];
                $summaryWiseall[$relatedCode]['paid_amt'] += $station['paid_amt'];
                $summaryWiseall[$relatedCode]['bal_amt'] += $station['bal_amt'];
            }
        }

        // date wise ordering
        // usort($data['stationWise'], function ($a, $b) {
        //     return (strtotime(trim($a['load_date'])) < strtotime(trim($b['load_date']))) ? -1 : 1;
        // });
        
        $data['stationStatus'] =$result->data[0]->related_station_name;
        $data['status'] = $status ? $status : "ALL" ;
        $data['results'] = $result->data;
        $data['stationWise'] = $stationWise;
        $data['summaryWise'] = $summaryWise;
        $data['summaryWiseall'] = $summaryWiseall;
        $data['summaryWisePaid'] = $summaryWisePaid;

        $data['filter_type'] = 'SUMMARY';
        $data['filterCode']= $this->input->post('filterCode');
        $data['user_name'] = $this->session->userdata('user_name');
        $data['fromDate'] = $from_date;
        $data['toDate'] = $to_date;

        if($this->input->post('print') == 1) {
            $data['printStatus'] = $printStatus ? $printStatus : "ALL";
            $this->load->exclude_template();
            $this->load->view('site/payment/transit-record-topay-payment-list-print', $data);
        } else if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $filename = 'Transit-record-topay-payment-' . $status . '.xls';
            $content = $this->load->view('site/payment/transit-record-topay-payment-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename="' . $filename . '"');
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
            $this->load->view('site/payment/transit-record-topay-payment-list', $data);
        }
    }

    public function transit_record_topay_payment_details_list(){
        $this->is_logged_in();

        $data = array(
            'queryCode' => 'RQNAAK4161',
            'fromDate' => $this->input->post('fromDate'),
            'toDate' => $this->input->post('toDate'),
            'filterCode' => $this->input->post('filterCode'),
            'transitCode' => $this->input->post('transitCode'),
            'transitStatus' => 'DISPATCH',
            'paymentStatusCode' => 'TOP',
            'filterType' => 'BRANCH',
            'requestType' => 'DETAILS',
        );
        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);

        $data['results'] = $result->data;
        $data['cargo_status'] = config_item('cargo_status');
        $data['filter_type'] = 'DETAILS';
        $this->load->view('site/payment/transit-record-topay-payment-list', $data);
    }

    public function update_transit_topay_payment(){
        $this->is_logged_in();
        $data = array(
            'code' => $this->input->post('code'),
            'activeFlag' => 1,
            'fromOrganization' => array('code' => $this->input->post('fromOrganization')),
            'transactionAmount' => $this->input->post('transactionAmount'),
            'transactionType' => array('code' => $this->input->post('transactionType')),
            'remarks' => $this->input->post('remarks') ?: 'NA',
            'organization' => array('code' => $this->input->post('organization')),
            'transitCargo' => array('code' => $this->input->post('transitCargo')),
        );
        $response = $this->api_model->updateTransitPayment($data);
        $response = json_decode($response);
        echo json_encode($response);
    }
    public function bulk_update_transit_topay_payment(){
        $this->is_logged_in();
    
        $inputData = $this->input->post();
        $inputAmount = floatval($inputData['inputAmount']);
    
        $remainingAmount = $inputAmount;
        $request = [];
        foreach ($inputData['src'] as $object) {
            $body['remarks'] = $inputData['remarks']?: 'NA';
            $body['activeFlag'] = 1;

            $transactionAmount = min(floatval($object['transactionAmount']), $remainingAmount);
            if ($transactionAmount > 0) {
                $body['transactionAmount'] = $transactionAmount;
                $remainingAmount -= $transactionAmount;
                $body['code'] = $object['code'];
                $body['transactionType']['code'] = $object['transactionType'];
                $body['fromOrganization']['code'] = $object['fromOrganization'];
                $body['organization']['code'] = $object['organization'];
                $body['transitCargo']['code'] = $object['transitCargo'];
                $request[] = $body;
            } else {
                break;
            }
        }
        $responses = [];
        foreach ($request as $object) {
            $response = $this->api_model->updateTransitPayment($object);
            $response = json_decode($response);
            $responses[] = $response;
        }
        echo json_encode($responses);
    }
    
    
    
    public function get_transit_topay_transaction_details(){
        $this->is_logged_in();

        $data = array(
            'transitCode' => $this->input->post('transitCode'),
            'relatedStationCode' => $this->input->post('relatedStationCode'),
        );
        $result = $this->api_model->getAllTransaction($data);
        $result = json_decode($result);

        $data['result'] = $result->data;
        $data['filter_type'] = 'Trasaction_view';
        $data['user_name'] = $this->session->userdata('user_name');
        $this->load->view('site/payment/transit-record-topay-payment-list', $data);
    }

    public function transit_record_paid_summary(){
        $this->is_logged_in();
        $data = array();

        $all_zone = $this->api_model->getAllZone();
        $zone = json_decode($all_zone);
        $data['zone'] = $zone->data;

        list($stations, $routes) = get_routes_and_stations();
        $data['stations'] = $stations;

        $all_zone_stations = array();
        foreach($zone->data as $key => $zones) {
            foreach($zones->stations as $k => $station) {
                $all_zone_stations[] = $station->code;
            }
        }

        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        $organization = array();
        foreach ($branches->data as $key => $branch) {
            if (in_array($branch->station->code, $all_zone_stations)) {
                $organization[] = $branch;
            }
        }

        usort($organization, function ($a, $b) {
            return strcasecmp($a->name, $b->name);
        });
        $data['organization'] = $organization;

        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $this->load->view('site/payment/transit-record-paid-summary', $data);
    }
    
    public function transit_record_paid_summary_list(){
        $this->is_logged_in();

        list($fromDate, $toDate) = explode(' | ', $this->input->post('dateRange'));

        if($fromDate=="NA"){
            $from_date = "NA";
            $to_date = "NA";
        }else{
            $from_date = date('Y-m-d', strtotime($fromDate));
            $to_date = date('Y-m-d', strtotime($toDate));
        }
       
        $status =$this->input->post('status');
        $printStatus = $this->input->post('printStatus');

        $data = array(
            'queryCode' => 'RQNAAK4161',
            'fromDate' => $from_date,
            'toDate' => $to_date,
            'filterType' => 'STATION',
            'filterCode' => $this->input->post('filterCode'),
            'transitStatus' => 'DISPATCH',
            'paymentStatusCode' => 'TOP',
            'requestType' => 'SUMMARY',
            'transitCode' => 'NA',
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        usort($result->data, function ($a, $b) {
            return (strtotime(trim($a->loaded_date)) < strtotime(trim($b->loaded_date))) ? -1 : 1;
        });
        $stationWise =array();
        
        foreach($result->data as $val){
            $stationWise[$val->transit_alias_code][$val->related_station_code]['data'][] = $val;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['code'] = $val->related_station_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['related_station_code'] = $val->related_station_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['station_code'] = $val->station_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['load_date'] = $val->loaded_date;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['ogpl_no'] = $val->transit_alias_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['vehicle'] = $val->registration_number;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['branch_code'] = $val->organization_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['transit_code'] = $val->transit_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['related_organization_code'] = $val->related_organization_code;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['from_station_name'] = $val->transit_from_station_name;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['to_station_name'] = $val->related_station_name;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['topay_amount'] += $val->topay_amount;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['payable_amt'] += (($val->topay_amount) - ($val->topay_hamali_charge + $val->topay_demurrage_charge + $val->topay_unload_handling_amount));
            $stationWise[$val->transit_alias_code][$val->related_station_code]['paid_amt'] += $val->transit_payment_amount;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['transaction_at'] = $val->transaction_at;
            $stationWise[$val->transit_alias_code][$val->related_station_code]['bal_amt'] += (($val->topay_amount) - ($val->topay_hamali_charge + $val->topay_demurrage_charge + $val->topay_unload_handling_amount)-($val->transit_payment_amount));
            $stationWise[$val->transit_alias_code][$val->related_station_code]['remark'] .=$val->transit_payment_remarks != null ? $val->transit_payment_remarks . ", " : "";

        }
        
        $summaryWise = array();
        foreach ($stationWise as $transitCode => $stations) {
            foreach ($stations as $relatedCode => $station) {
                if ($station['bal_amt'] > 0){
                    $summaryWise[$relatedCode]['name'] = 'UNPAID';
                    $summaryWise[$relatedCode]['to_station_name'] = $station['to_station_name'];
                    if($station['transaction_at'] != null){
                    $summaryWise[$relatedCode]['transaction_at'] = $station['transaction_at'];
                    }
                    $summaryWise[$relatedCode]['payable_amt'] += $station['payable_amt'];
                    $summaryWise[$relatedCode]['paid_amt'] += $station['paid_amt'];
                    $summaryWise[$relatedCode]['bal_amt'] += $station['bal_amt'];
                }
            }
        }
        
        // Sort summaryWise by to_station_name
        usort($summaryWise, function ($a, $b) {
            return strcmp($a['to_station_name'], $b['to_station_name']);
        });

        $data['stationStatus'] =$result->data[0]->related_station_name;
        $data['status'] = $status ? $status : "ALL" ;
        $data['results'] = $result->data;
        $data['stationWise'] = $stationWise;
        $data['summaryWise'] = $summaryWise;

        $data['filter_type'] = 'SUMMARY';
        $data['filterCode']= $this->input->post('filterCode');
        $data['user_name'] = $this->session->userdata('user_name');
        $data['fromDate'] = $from_date;
        $data['toDate'] = $to_date;

        if($this->input->post('print') == 1) {
            $data['printStatus'] = $printStatus ? $printStatus : "ALL";
            $this->load->exclude_template();
            $this->load->view('site/payment/transit-record-paid-summary-print', $data);
        } else if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $filename = 'Transit-record-topay-payment-' . $status . '.xls';
            $content = $this->load->view('site/payment/transit-record-paid-summary-list-xls', $data, true);
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename="' . $filename . '"');
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
            $this->load->view('site/payment/transit-record-paid-summary-list', $data);
        }

    }
    

}

?>