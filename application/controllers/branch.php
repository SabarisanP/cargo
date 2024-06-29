<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Branch extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    public function branch_receipt() {
        $this->is_logged_in();

        // redirected data
        $data['dayCloseOrganizationCode'] = $this->input->get('organization');

        $tags = [];
        $branches = $this->api_model->getOrganization();
        $branches = json_decode($branches);
        if (is_array($branches->data)) {
            foreach ($branches->data as $branch) {
                foreach ($branch->tag as $row) {
                    if (!isset($tags[$row->code])) {
                        $row->branches = [];
                        $tags[$row->code] = $row;
                    }
                    $tags[$row->code]->branches[] = $branch->code;
                }
            }
            usort($branches->data, function($a, $b) {
                return $a->name < $b->name ? -1 : 1;
            });
        }
        $data['tags'] = $tags;
        $data['branches'] = $branches->data;

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $users = $users->data;

        $usrbranch = array();
        foreach ($users as $row) {
            $usrbranch[$row->organization->code]['code'] = $row->organization->code;
            $usrbranch[$row->organization->code]['name'] = $row->organization->name;
            $usrbranch[$row->organization->code]['users'][] = $row;
        }
        usort($usrbranch, function($a, $b) {
            return strcasecmp($a['name'], $b['name']);
        });
        $data['branchusers'] = $usrbranch;

        $this->load->view('site/branch/branch-receipt', $data);
    }

    public function branch_receipt_report_list(){
        $this->is_logged_in();

        $userCode = $this->input->post('userCode');
        if (!$userCode) {
            $userCode = $this->session->userdata('user_id');
        }

        if ($this->input->post('paymentAcknowledgeStatus') == 'ACKED' || $this->input->post('paymentAcknowledgeStatus') == 'RJECT') {
            list($fromDates, $toDates) = explode(' | ', $this->input->post('dateRange'));
            $fromDate = date('Y-m-d 00:00:00', strtotime($fromDates));
            $toDate = date('Y-m-d 23:59:59', strtotime($toDates));
        } else if ($this->input->post('paymentAcknowledgeStatus') == 'INITD') {
            $fromDate = 'null';
            $toDate = 'null';
        }

        $organizationCode = $this->input->post('organizationCode');
        $tagCode = $this->input->post('tagCode');
        if ($tagCode) {
            $userCode = 'NA';
            $organizationCode = $tagCode;
        }

        $param = array(
            'fromDate' => $fromDate,
            'toDate' => $toDate,
            'userCode' => $userCode,
            'organizationCode' => $organizationCode,
            'paymentStatusCode' => $this->input->post('paymentAcknowledgeStatus'),
        );
        
        $result = $this->api_model->getBranchReceipt($param);
        $result = json_decode($result);

        if ($param['paymentStatusCode'] != 'ACKED') {
            foreach ($result->data as $row) {
                if ($row->paymentAcknowledge->code != 'ACKED') {
                    $row->paidAmount = 0;
                    foreach ($row->organizationReceiptDetails as $receipt) {
                        $row->paidAmount += $receipt->paidAmount;
                    }
                }
            }
        }

        usort($result->data, function ($a, $b) {
            if ($a->organization->name === $b->organization->name) {
                return (strtotime(trim($a->createdAt)) < strtotime(trim($b->createdAt))) ? -1 : 1;
            }
            return strcasecmp($a->organization->name, $b->organization->name);
        });

        $branch_receipt = array();
        foreach ($result->data as $row) {
            $branch_receipt[$row->organization->code]['data'][] = $row;
            $branch_receipt[$row->organization->code]['code'] = $row->code;
            $branch_receipt[$row->organization->code]['createdAt'] = $row->createdAt;
            $branch_receipt[$row->organization->code]['username'] = $row->user->name;
            $branch_receipt[$row->organization->code]['branchname'] = $row->organization->name;
            $branch_receipt[$row->organization->code]['aliasCode'] = $row->user->aliasCode;
            $branch_receipt[$row->organization->code]['organizationReceiptDetails'] = $row->organizationReceiptDetails;
            $branch_receipt[$row->organization->code]['paymentMode'] = $row->organizationReceiptDetails[0]->paymentMode->name;
            $branch_receipt[$row->organization->code]['branch'] = $row->organization;
            $branch_receipt[$row->organization->code]['paymentAcknowledgeCode'] = $row->paymentAcknowledge->code;
            $branch_receipt[$row->organization->code]['bookedAmount'] = $row->bookedAmount;
            $branch_receipt[$row->organization->code]['deliveryAmount'] = $row->deliveryAmount;
            $branch_receipt[$row->organization->code]['totalIncomeAmount'] = $row->totalIncomeAmount;
            $branch_receipt[$row->organization->code]['totalExpenseAmount'] = $row->totalExpenseAmount;
            $branch_receipt[$row->organization->code]['commissionAmount'] = $row->commissionAmount;
            $branch_receipt[$row->organization->code]['revertAmount'] = $row->revertAmount;
            $branch_receipt[$row->organization->code]['settlementAmount'] = $row->settlementAmount;
            $branch_receipt[$row->organization->code]['paidAmount'] = $row->paidAmount;
            $branch_receipt[$row->organization->code]['remarks'] = $row->remarks;

            $branch_receipt[$row->organization->code]['totalBookedAmount'] += $row->bookedAmount;
            $branch_receipt[$row->organization->code]['totalDeliveryAmount'] += $row->deliveryAmount;
            $branch_receipt[$row->organization->code]['totalTotalOtherIncomeAmount'] += $row->totalIncomeAmount;
            $branch_receipt[$row->organization->code]['totalTotalExpenseAmount'] += $row->totalExpenseAmount;
            $branch_receipt[$row->organization->code]['totalCommissionAmount'] += $row->commissionAmount;
            $branch_receipt[$row->organization->code]['totalRevertAmount'] += $row->revertAmount;
            $branch_receipt[$row->organization->code]['totalSettlementAmount'] += $row->settlementAmount;

            if ($row->paymentAcknowledge->code == 'ACKED') {
                $branch_receipt[$row->organization->code]['totalPaidAmount'] += $row->paidAmount;
            } elseif ($row->paymentAcknowledge->code == 'INITD' || $row->paymentAcknowledge->code == 'RJECT') {
                $branch_receipt[$row->organization->code]['totalPayableAmount'] += $row->paidAmount;
            }

            foreach ($row->organizationReceiptDetails as $val) {
                $branch_receipt[$row->organization->code]['totalOpeningBalanceAmount'] += $val->openingBalanceAmount;
            }
        }
        uasort($branch_receipt, function ($a, $b) {
            return strcasecmp($a['branchname'], $b['branchname']);
        });
        
        $data['result'] = $result->data;
        $data['branch_receipt'] = $branch_receipt;
        $data['paymentAcknowledgeStatus'] = $this->input->post('paymentAcknowledgeStatus') ?: 'INITD';


        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['transactionMode'] = config_item('transaction_mode');

        if ($this->input->post('print') == 1) {
            $this->load->exclude_template();
            $this->load->view('site/branch/branch-receipt-list-print', $data);
        }else if ($this->input->post('export') == 1) {
            $filename = 'Branch Closing Report';
            $this->load->excel('site/branch/branch-receipt-list-xls', $data, $filename);
        }else {
            $this->load->view('site/branch/branch-receipt-list',$data);
        }
    }

    public function day_closing() {
        $this->is_logged_in();

        $users = $this->api_model->getUser();
        $users = json_decode($users);
        $users = $users->data;

        $usrbranch = array();
        foreach ($users as $row) {
            $usrbranch[$row->organization->code]['code'] = $row->organization->code;
            $usrbranch[$row->organization->code]['name'] = $row->organization->name;
            $usrbranch[$row->organization->code]['users'][] = $row;
        }
        usort($usrbranch, function($a, $b) {
            return strcasecmp($a['name'], $b['name']);
        });
        $data['branchusers'] = $usrbranch;

        $organizationDetails = $this->api_model->getOrganization();
        $organizationDetails = json_decode($organizationDetails);
        $data['organization'] = $organizationDetails->data;

        $userAssignedBranches = $this->api_model->userAssignedBranches();
        $userAssignedBranches = json_decode($userAssignedBranches);
        $data['userAssignedBranches'] = $userAssignedBranches->data;

        $primary_user = array();
        foreach($userAssignedBranches->data as $val){
            array_push($primary_user, $val->user->code);
        }

        $data['primary'] = $primary_user;

        $data['transactionMode'] = config_item('transaction_mode');
        $data['bank_names_list'] = $this->config->item('bank_names_list');

        $this->load->view('site/branch/day-closing', $data);
    }

    public function get_approval_pending_transaction() {
        $this->is_logged_in();

        $data = array(
            'organizationCode' => $this->input->post('organizationCode') ?: '',
            'userCode' => $this->input->post('userCode') ?: ''
        );
        
        $result = $this->api_model->dashboardDayCloseSummary($data);
        $result = json_decode($result);

        $approvalPendingList = [];
        foreach ($result->data as $row) {
            if ($row->pendingCount > 0) {
                $approvalPendingList[] = $row;
            }
        }
        $data['result'] = $approvalPendingList;

        $this->load->view('site/branch/approval-pending-transaction', $data);
    }

    public function get_organization_other_details() {
        $this->is_logged_in();

        echo $this->api_model->getOrganizationOtherDetails(array(
            'organizationcode' => $this->input->post('organizationcode')
        ));
    }

    public function get_payment_preference_org(){
        $this->is_logged_in();

        echo $this->api_model->getPaymentPreference(array('organizationCode' => $this->input->post('org_code')));
    }

    public function day_closing_list() {
        $this->is_logged_in();

        $data = array(
            'toDate' => $this->input->post('toDate') ?: date('Y-m-d H:i:s'),
            'userCode' => $this->input->post('userCode') ?: $this->session->userdata('user_id')
        );
        $result = $this->api_model->organizationUserTransaction($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $pendingPayments = $this->api_model->getAllPendingPayments(array(
            'organizationCode' => $this->input->post('orgCode') ?: $this->session->userdata('org_code'),
            'userCode' => $this->input->post('userCode') ?: $this->session->userdata('user_id')
        ));
        $pendingPayments = json_decode($pendingPayments);

        $totalPendingAmount = 0;
        foreach($pendingPayments->data as $val) {
            $totalPendingAmount = $totalPendingAmount + $val->totalPendingAmount;
        }
        $data['totalPendingAmount'] = $totalPendingAmount;
        $data['pendingPayments'] = $pendingPayments->data;

        $organizationDetails = $this->api_model->getOrganization();
        $organizationDetails = json_decode($organizationDetails);

        $organization = [];
        foreach ($organizationDetails->data as $row) {
            $organization[$row->code] = $row;
        }
        $data['organization'] = $organization;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['transactionMode'] = config_item('transaction_mode');
        $data['logged_in_org_code'] = $this->session->userdata('org_code');

        if ($this->input->post('export') == 1) {
            $this->load->exclude_template();
            $content = $this->load->view('site/branch/day-closing-list-xls', $data, true);
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
            $this->load->view('site/branch/day-closing-list',$data);
        }
    }

    public function get_pending_payments() {
        $this->is_logged_in();

        $data = array(
            'organizationCode' => $this->input->post('organizationCode') ?: '',
            'userCode' => $this->input->post('userCode') ?: ''
        );
        
        $result = $this->api_model->getAllPendingPayments($data);
        $result = json_decode($result);

        foreach ($result->data as $row) {
            if ($row->paymentAcknowledge->code != 'ACKED') {
                $row->paidAmount = 0;
                foreach ($row->organizationReceiptDetails as $receipt) {
                    $row->paidAmount += $receipt->paidAmount;
                }
            }
        }

        usort($result->data, function($a, $b) {
            if ($a->organization->name === $b->organization->name) {
                return (strtotime(trim($a->createdAt)) < strtotime(trim($b->createdAt))) ? -1 : 1;
            }
            return strcasecmp($a->organization->name, $b->organization->name);
        });

        $pending_payments = array();
        foreach ($result->data as $row) {
            if ($row->paymentAcknowledge->code == 'RJECT') {
                continue;
            }
            $pending_payments[$row->paymentAcknowledge->code][] = $row;
        }
        
        $data['result'] = $result->data;
        $data['pending_payments'] = $pending_payments;
        
        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['transactionMode'] = config_item('transaction_mode');

        $this->load->view('site/branch/get-pending-payment-list', $data);
    }

    public function get_branch_receipt_openingbalance_details() {
        $this->is_logged_in();

        $data = array(
            'organizationCode' => $this->input->post('organizationCode'),
            'userCode' => $this->input->post('userCode'),
            'receiptDetailsCode' => $this->input->post('receiptDetailsCode'),
        );

        $result = $this->api_model->getPendingPayment($data);
        $result = json_decode($result);
        
        foreach ($result->data as $row) {
            if ($row->paymentAcknowledge->code != 'ACKED') {
                $row->paidAmount = 0;
                foreach ($row->organizationReceiptDetails as $receipt) {
                    $row->paidAmount += $receipt->paidAmount;
                }
            }
        }

        usort($result->data, function($a, $b) {
            if ($a->organization->name === $b->organization->name) {
                return (strtotime(trim($a->createdAt)) < strtotime(trim($b->createdAt))) ? -1 : 1;
            }
            return strcasecmp($a->organization->name, $b->organization->name);
        });

        $pending_payments = array();
        foreach ($result->data as $row) {
            if ($row->paymentAcknowledge->code == 'RJECT') {
                continue;
            }
            $pending_payments[$row->paymentAcknowledge->code][] = $row;
        }
        
        $data['result'] = $result->data;
        $data['pending_payments'] = $pending_payments;

        $this->load->view('site/branch/branch-receipt-openingbalance-details', $data);
    }

    public function save_branch_user_transactions() {
        $this->is_logged_in();

        $data = array(
            'activeFlag' => (int) $this->input->post('activeFlag'),
            'totalExpenseAmount' => (float) $this->input->post('totalExpenseAmount'),
            'totalIncomeAmount' => (float) $this->input->post('totalIncomeAmount'),
            'bookedAmount' => (float) $this->input->post('bookedAmount'),
            'deliveryAmount' => (float) $this->input->post('deliveryAmount'),
            'commissionAmount' => (float) $this->input->post('commissionAmount'),
            'revertAmount' => (float) $this->input->post('revertAmount'),
            'settlementAmount' => (float) $this->input->post('settlementAmount'),
            'organization' => $this->input->post('organization'),
            'user' => $this->input->post('user'),
            'organizationReceiptDetails' => $this->input->post('organizationReceiptDetails') ?: [],
            'remarks' => $this->input->post('remarks')
        );

        echo $this->api_model->saveOrganizationUserTransactions($data);
    }

    public function update_branch_receipt_status() {
        $this->is_logged_in();

        $data = array(
            'code' => $this->input->post('code'),
            'paidAmount' => $this->input->post('paidAmount'),
            'remarks' => $this->input->post('remarks'),
            'organizationReceiptDetails' => $this->input->post('organizationReceiptDetails') ?: [],
        );

        echo $this->api_model->updateBranchReceiptStatus($data);
    }

    public function branch_balance() {
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
            $usrbranch[$row->organization->code]['code'] = $row->organization->code;
            $usrbranch[$row->organization->code]['name'] = $row->organization->name;
            $usrbranch[$row->organization->code]['users'][] = $row;
        }
        usort($usrbranch, function($a, $b) {
            return strcasecmp($a['name'], $b['name']);
        });
        $data['branchusers'] = $usrbranch;

        $this->load->view('site/branch/branch-balance', $data);
    }

    public function branch_balance_list() {
        $this->is_logged_in();

        $data = array(
            'userCode' => $this->input->post('userCode') ?: $this->session->userdata('user_id'),
            'organizationCode' => $this->input->post('organizationCode')
        );
        
        $result = $this->api_model->organizationUserBalance($data);
        $result = json_decode($result);

        $filterby = $this->input->post('filterby');
        if ($filterby == 'BRANCH') {
            usort($result->data, function($a, $b) {
                if (trim($a->user->organization->name) == trim($b->user->organization->name)) {
                    return strnatcasecmp(trim($a->user->name), trim($b->user->name));
                }
                return strnatcasecmp(trim($a->user->organization->name), trim($b->user->organization->name));
            });

            $branchwise = [];
            foreach ($result->data as $row) {
                if ($row->closingBalance == 0 && $row->currentBalance == 0) continue;
                $branchwise[$row->user->organization->name]['total_balance'] += $row->closingBalance;
                $branchwise[$row->user->organization->name]['total_running'] += $row->currentBalance;
                $branchwise[$row->user->organization->name]['data'][] = $row;
            }
            $data['branchwise'] = $branchwise;
        } else {
            usort($result->data, function($a, $b) {
                return strnatcasecmp(trim($a->user->name), trim($b->user->name));
            });

            $userwise = [];
            foreach ($result->data as $row) {
                if ($row->closingBalance == 0 && $row->currentBalance == 0) continue;
                $userwise[] = $row;
            }
            $data['result'] = $userwise;
        }
        $data['filterby'] = $filterby;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['transactionMode'] = config_item('transaction_mode');

        if ($this->input->post('export') == 1) {
            if($filterby == 'BRANCH'){
                $filename = 'Branch Due Report (Branch)';
            }else{
                $filename = 'Branch Due Report (User)';
            }

            $this->load->excel('site/branch/branch-balance-list-xls', $data, $filename);
        } else {
            $this->load->view('site/branch/branch-balance-list',$data);
        }
    }

    public function user_lrdetails_list() {
        $this->is_logged_in();

        $paymentStatusCode = $this->input->post('paymentStatusCode');
        $from = strtotime($this->input->post('fromDate'));
        $to = strtotime($this->input->post('toDate') ?: 'now');

        $data = array(
            'queryCode' => 'RQFCM101',
            'toDate' => date('Y-m-d H:i:s', $to),
            'fromDate' => date('Y-m-d H:i:s', $from),
            'userCode' => $this->input->post('userCode'),
            'filterType' => $this->input->post('filterType'),
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['paymentStatusCode'] = $paymentStatusCode;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['transactionMode'] = config_item('transaction_mode');

        $this->load->view('site/branch/user-lrdetails-list',$data);
    }

    public function user_revert_lrdetails_list() {
        $this->is_logged_in();

        $paymentStatusCode = $this->input->post('paymentStatusCode');
        $from = strtotime($this->input->post('fromDate'));
        $to = strtotime($this->input->post('toDate') ?: 'now');

        $data = array(
            'toDate' => date('Y-m-d H:i:s', $to),
            'fromDate' => date('Y-m-d H:i:s', $from),
            'userCode' => $this->input->post('userCode'),
            'filterType' => $this->input->post('filterType'),
        );

        $result = $this->api_model->getRevertLrDetailsTransactions($data);
        $result = json_decode($result);
        $data['result'] = $result->data;
        $data['paymentStatusCode'] = $paymentStatusCode;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['transactionMode'] = config_item('transaction_mode');

        $this->load->view('site/branch/user-lrdetails-list',$data);
    }

    public function branch_iedetails_list() {
        $this->is_logged_in();

        $paymentStatusCode = $this->input->post('paymentStatusCode');
        $from = strtotime($this->input->post('fromDate'));
        $to = strtotime($this->input->post('toDate') ?: 'now');

        $data = array(
            'toDate' => date('Y-m-d H:i:s', $to),
            'fromDate' => date('Y-m-d H:i:s', $from),
            'organizationCode' => $this->input->post('organizationCode'),
            'transactionType' => $this->input->post('transactionType'),
            'organizationReceiptCode' => $this->input->post('organizationReceiptCode') ?: 'NA',
        );

        $result = $this->api_model->branchIEDetails($data);
        $result = json_decode($result);
        $data['result'] = $result->data;

        $totalInitiated = 0;
        $totalApproved = 0;
        foreach($result->data as $key=>$val) {
            if ($val->acknowledgeStatus->code == "INIT") {
                $totalInitiated = $totalInitiated + 1;
            }

            if ($val->acknowledgeStatus->code == "APRD") {
                $totalApproved = $totalApproved + 1;
            }
        }

        $data['paymentStatusCode'] = $paymentStatusCode;
        $data['totalInitiated'] = $totalInitiated;
        $data['totalApproved'] = $totalApproved;

        $data['cargo_status'] = config_item('cargo_status');
        $data['cargo_payment_status'] = config_item('cargo_payment_status');
        $data['transactionMode'] = config_item('transaction_mode');

        $this->load->view('site/branch/branch-iedetails-list',$data);
    }

    public function branch_bank_details() {
        $this->is_logged_in();

        $result = $this->api_model->getImageDetails(array(
            'referenceCode' => $this->input->post('branchCode') ?: $this->session->userdata('org_code'),
            'imageCategoryCode' => 'ORGN'
        ));
        $result = json_decode($result);
        $data['org_images'] = $result->data;

        $result = $this->api_model->getOrganizationOtherDetails(array(
            'organizationcode' => $this->input->post('branchCode') ?: $this->session->userdata('org_code'),
        ));
        $result = json_decode($result);
        $data['org_details'] = $result->data;

        $data['dms_domain'] = config_item('dms_domain');
    
        $this->load->view('site/branch/branch-bank-details',$data);
    }

    public function day_close_setting() {
        $this->is_logged_in();
        $data = array();

        $organization = $this->api_model->getOrganization();
        $organization = json_decode($organization);
        $data['organizations'] = $organization->data;

        $dayCloseSetting = $this->api_model->getDayCloseSetting();
        $dayCloseSetting = json_decode($dayCloseSetting);
        $data['dayCloseSettings'] = $dayCloseSetting->data;

        $this->load->view('site/branch/day-close-setting', $data);
    }

    public function update_day_close_setting() {
        $this->is_logged_in();

        echo $this->api_model->updateDayCloseSetting(array(
            'code' => $this->input->post('code'),
            'activeFlag' => $this->input->post('activeFlag'),
            'organizations' => $this->input->post('organizations') ?: [],
            'dayCloseHour' => $this->input->post('dayCloseHour'),
            'dayCloseType' => $this->input->post('dayCloseType'),
            'maxUnclosedDays' => $this->input->post('maxUnclosedDays'),
            'maxPendingApprovalCount' => $this->input->post('maxPendingApprovalCount'),
            'creditLimit' => $this->input->post('creditLimit')
        ));
    }
}

?>
