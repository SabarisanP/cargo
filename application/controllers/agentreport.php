<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Agentreport extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->is_logged_in();
        redirect('user/dashboard');
    }

    public function home(){
    	$this->is_logged_in();

    	$this->load->view('site/report/agentreport/agent_report');

    }
    public function get_agent_report_list(){
    	$this->is_logged_in();
    	$data = array(
            'queryCode' => 'RQF4Q14613',
            'fromDate' => $this->input->post('date_from'),
            'toDate' => $this->input->post('date_to')
    	);
    	$result = $this->api_model->getDynamicReportDataWithMap($data);
    	$result = json_decode($result);

    	$tickets = array();

    	$t_book_summary = array();
    	$t_cancel_summary = array();
    	if ($result->status == 1) {
            if (is_array($result->data)) {
                $ticket_count = count($result->data);
                for ($i = 0; $i < $ticket_count; $i++) {
                    if ($result->data[$i]->user_first_name == "")
                            continue;
                    $t_book_summary[$result->data[$i]->user_first_name] += $result->data[$i]->booked_seat_count;
                    $t_book_summary[$result->data[$i]->user_first_name] += $result->data[$i]->phone_booked_seat_count;
                    //$t_book_summary[$result->data[$i]->user_first_name] += $result->data[$i]->phone_blocked_count;

                    $t_cancel_summary[$result->data[$i]->user_first_name] += $result->data[$i]->cancelled_seat_count;
                    $t_cancel_summary[$result->data[$i]->user_first_name] += $result->data[$i]->phone_cancelled_seat_count;
                }
            }
    	}
    	if (count($t_book_summary) > 0) {
            foreach ($t_book_summary as $k => $v) {
                $book_summary[] = array('label' => $k, 'data' => $v);
            }
    	}
    	if (count($t_cancel_summary) > 0) {
            foreach ($t_cancel_summary as $k => $v) {
                $cancel_summary[] = array('label' => $k, 'data' => $v);
            }
    	}

    	$data = array(
            'tickets' => $result->data,
            'transactions' => $result->data,
            'book_summary' => $book_summary,
            'cancel_summary' => $cancel_summary
    	);


    	if ($this->input->post('export') == 1) {
    		$this->load->exclude_template();
    		$content = $this->load->view('site/report/agentreport/agent-report-list-xls', $data, true);
    		header('Content-Description: File Transfer');
    		header('Content-Type: application/octet-stream');
    		header('Content-Disposition: attachment; filename=agent-report.xls');
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
            $this->load->view('site/report/agentreport/agent_report_list', $data);
    	}
    }
}
?>