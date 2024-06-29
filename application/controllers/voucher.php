 <?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Voucher extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->is_logged_in();
        redirect('user/dashboard');
    }
    
    function  home(){
    	$this->is_logged_in();
        _include_js('assets/js/pages/voucher.js');
    	
        $voucher_usr = $this->api_model->getVoucherUsers();
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
        
        $data['logged_in_user'] = $this->session->userdata('user_id');
    	$data['t_type'] = $transaction_type->data;
    	$data['t_mode'] = $transaction_mode->data;
    	$data['entity'] = $usr;
    	$data['username'] = $this->session->userdata('user_name');
    	$data['active_schedules'] = get_active_schedules();   
        $data['f_a_status'] = config_item('acknowledge_status');
        
    	$this->load->view('site/voucher/voucher', $data);
    }
      
    function new_voucher_list() {
    	$this->is_logged_in();
    	if ($this->input->post('flag') == 'booked') {
    		$flag = 'true';
    	} else {
    		$flag = 'false';
    	}
    	$report = $this->api_model->getUnpaidTransactions(array(
            'user' => $this->input->post('user'), 
            'scheduleCode' => $this->input->post('schedule_code'), 
            'from' => $this->input->post('from'), 
            'to' => $this->input->post('to'), 
            'useTravelDate' => $this->input->post('flag')));
    	$rpt = json_decode($report);
    	$usr = array();
    	foreach ($rpt->data AS $seats) {
            $usr[$seats->transactionType->name][] = $seats->transactionType->name;    
    	}
    	$data['voucher'] = $rpt->data;
    	$data['transactionType'] = $usr;
    
    	$this->load->view('site/voucher/new-voucher-report-list', $data);
    }
    
    function unpaid_transactions() {
    	$this->is_logged_in();
    	if ($this->input->post('flag') == 'booked') {
    		$flag = 'true';
    	} else {
    		$flag = 'false';
    	}
    	$report = $this->api_model->getUnpaidTransactions(array(
            'user' => $this->input->post('user'), 
            'scheduleCode' => $this->input->post('schedule_code'), 
            'from' => $this->input->post('from'), 
            'to' => $this->input->post('to'), 
            'useTravelDate' => $this->input->post('flag')));
    	$rpt = json_decode($report);
    	$usr = array();
//    	foreach ($rpt->data AS $seats) {
//            $usr[$seats->transactionType->name][] = $seats->transactionType->name;    
//    	}
    	$data['voucher'] = $rpt->data;
    	$data['transactionType'] = $usr;
    
    	$this->load->view('site/voucher/unpaid-transactions', $data);
    }
    
  public function voucherlist() {
    	$this->is_logged_in();
    	$voucher_usr = $this->api_model->getVoucherUsers();
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
    
    	$data['t_type'] = $transaction_type->data;
    	$data['t_mode'] = $transaction_mode->data;
    	$data['entity'] = $usr;
    
    	$this->load->view('site/voucher/generated-voucherlist', $data);
    }
    
    function get_generated_voucherlist() {
    	$this->is_logged_in();
    	/*$voucher = $this->api_model->getRechargeList(array(
    			'transactionTypeCode' => 'PAVR',
    			'userCode' => $this->input->post('user'),
    			'fromDate' => $this->input->post('from'),
    			'toDate' => $this->input->post('to')));
    	$rpt = json_decode($voucher);
    	$data['voucher'] = $rpt->data;
    	*/
        
          $data = array(
            'queryCode' => 'RQFATL54',
            'transactionType' => 'PAVR',
            'acknowledmentStatus' => $this->input->post('acknowledmentStatus'),            
            'transactionMode' => 'NA',
            'userCode' => $this->input->post('user'),
            'toDate' => $this->input->post('to'),
            'fromDate' => $this->input->post('from'),            
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['voucher'] = $result->data;        
        $data['f_t_type'] = config_item('transaction_type');
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['f_a_status'] = config_item('acknowledge_status');
        
        $this->load->view('site/voucher/all-user-generated-voucher-list', $data);
    }
    
    function voucher_list_pdf() {
    	$this->is_logged_in();
        
        $data = array(
            'queryCode' => 'RQFATL54',
            'transactionType' => 'PAVR',
            'acknowledmentStatus' => $this->input->get('acknowledmentStatus'),            
            'transactionMode' => 'NA',
            'userCode' => $this->input->get('user'),
            'toDate' => $this->input->get('to'),
            'fromDate' => $this->input->get('from'),            
        );

        $result = $this->api_model->getDynamicReportDataWithMap($data);
        $result = json_decode($result);
        $data['voucher'] = $result->data; 
        $data['namespace_name'] = $this->session->userdata('namespace_name');
        $data['username'] = $this->session->userdata('user_name');
        $data['f_t_type'] = config_item('transaction_type');
        $data['f_t_mode'] = config_item('transaction_mode');
        $data['f_a_status'] = config_item('acknowledge_status');
        
        require_once APPPATH.'third_party/tcpdf/tcpdf.php';
        $pdf = new TCPDF();
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->SetFont('times', '', 8);
        $pdf->AddPage();

        $this->load->exclude_template();
        $content = $this->load->view('site/voucher/voucher-list-pdf', $data, true);
        ob_clean();
        $pdf->writeHTML($content);
        $pdf->Output('voucher-list.pdf', "i");        
    }
 
    function approve_voucher() {
        $this->is_logged_in();
		
        $code = $this->input->post('transactionCode');
        $user = $this->input->post('User');
        $AmountReceivedDate = $this->input->post('AmountReceivedDate');
        $Remarks = $this->input->post('Remarks');
        $TransactionMode = $this->input->post('TransactionMode');

        $seatcode = implode(',', $code);
        $data = array(
            'transactionCodes' => $seatcode,
            'user' => array("code" => $user),
            'amountReceivedDate' => $AmountReceivedDate,
            'remarks' => $Remarks,
            'transactionMode' => array("code" => $TransactionMode),
            'paymentHandledBy' => array("code" => $this->session->userdata('user_id'))            
        );

        echo $this->api_model->approveVoucher($data);
    }
    function get_voucher_details(){
    	$this->is_logged_in();
    	$report = $this->api_model->getVoucherDetails(array('paymentCode' => $this->input->post('paymentCode')));
    	$rpt = json_decode($report);
        $data['reports'] = $rpt->data;
    		
    	$this->load->view('site/voucher/transaction-popover-list',$data);
    		
    }
    
    function voucher_payment_summary() {
    	$this->is_logged_in();
    	$summary = $this->api_model->getVoucherSummary( array('paymentCode' => $this->input->get('code')) );
    	$summary = json_decode($summary);
        $data['namespace_name'] = $this->session->userdata('namespace_name');
        $data['summary'] = $summary->data;
    	        
        require_once APPPATH.'third_party/tcpdf/tcpdf.php';
        $pdf = new TCPDF();
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->SetFont('times', '', 8);
        $pdf->AddPage();
        
        ob_clean();
        $this->load->exclude_template();
        $content = $this->load->view('site/voucher/transaction-summary-pdf', $data, true);

        $pdf->writeHTML($content);  
        $pdf->Output('payment-voucher.pdf', "i");
    }
    
    function download() {
    	$this->is_logged_in();
        $data['namespace_name'] = $this->session->userdata('namespace_name');
        
    	$summary = $this->api_model->getVoucherSummary( array('paymentCode' => $this->input->get('code')) );
    	$summary = json_decode($summary);        
        $data['summary'] = $summary->data;
        
        $report = $this->api_model->getVoucherDetails(array('paymentCode' => $this->input->get('code')));
    	$result = json_decode($report);
        
        $bo_fare = 0;
        $bo_commi = 0;
        
        $ca_fare = 0;
        $ca_refund = 0;
        $ca_charge = 0;
        $ca_revoke = 0;
        $ca_ag_charge = 0;
        $ca_refund = 0;
        
        
                
        if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    if ($result->data[$i]->transactionType->code == 'TICKBO') {                        
                        $tickets['booking'][] = $result->data[$i];
                        
                        $bo_fare += $result->data[$i]->ticketAmount;
                        $bo_commi += $result->data[$i]->commissionAmount;
                    } else {                        
                        $tickets['cancell'][] = $result->data[$i];
                        
                        $ca_fare += $result->data[$i]->ticketAmount;
                        $ca_charge += $result->data[$i]->cancellationChargeAmount;
                        
                        $ca_revoke += $result->data[$i]->revokeCancelCommissionAmount;
                        $ca_ag_charge += $result->data[$i]->agentCancellationChargeAmount;
                        $ca_refund += $result->data[$i]->refundAmount;
                    }           
                }
                $data['tickets'] = $tickets;
                
                $data['bo_fare'] = $bo_fare;
                $data['bo_commi'] = $bo_commi;
                
                $data['ca_fare'] = $ca_fare;
                $data['ca_charge'] = $ca_charge; 
                $data['ca_revoke'] = $ca_revoke;
                $data['ca_refund'] = $ca_refund;
                $data['ca_ag_charge'] = $ca_ag_charge;
            }
        }
        
    	        
        require_once APPPATH.'third_party/tcpdf/tcpdf.php';
        $pdf = new TCPDF();
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->SetFont('times', '', 8);
        $pdf->AddPage();
        
        ob_clean();
        $this->load->exclude_template();
        $content = $this->load->view('site/voucher/download-pdf', $data, true);

        $pdf->writeHTML($content);  
        $pdf->Output('payment-voucher-trans.pdf', "i");
    }
    
    function update_payment_status() {
        $this->is_logged_in();
		
        $code = $this->input->post('code');
        $transactionMode = $this->input->post('transactionMode');        
        $t_mode = config_item('transaction_mode');        
        $remarks = ','.$t_mode[$transactionMode].','.$this->input->post('remarks');
        
        $data = array(
                'code' => $this->input->post('code'), 
                'state' => 'PAID',
                'remarks' => urlencode($remarks)
            );
        echo $this->api_model->updateAck($data);                
    }
 
}
?>
