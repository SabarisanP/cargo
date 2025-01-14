<?php

define('NSCODE', _get_namespace_id());

class helper_model extends CI_Model {

    public $userOrg;
    public $userStaion;
    public $nameSpaceCode;
    function __construct() {
       $api = $this->load->model('api_model');
       $this->userOrg = $this->session->userdata('org_code');
    }

    function view_chart($transitType,$requestData){
        $organizationCode = $this->userOrg; 
        $result = $this->api_model->getDynamicReportDataWithMap($requestData);
        $result = json_decode($result);

        usort($result->data, function($a, $b) {
            return (strtotime(trim($a->booked_at)) < strtotime(trim($b->booked_at))) ? -1 : 1;
        });

        $rowCount = 0;
        $transitDetails = array();
        $list = array();
        $routes = array();
        $summary = array();
        $showTransitTypes = array();
        foreach ($result->data as $row) {
            if($row->load_type !="PTL" && $row->load_type !="FTL" ){  //permission restric only for regular booking
                if (has_action_rights('HIDE-OTHER-BRANCH-LR')) { 
                    if ($row->from_organization_code != $organizationCode && $row->to_organization_code != $organizationCode && $row->transit_organization_code != $organizationCode  && $row->transit_from_organization_code != $organizationCode && $row->transit_to_organization_code != $organizationCode) {
                        continue;
                    }
                }
            }
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
            $key = $row->transit_from_station_code . '-' . $row->transit_to_organization_code;
            $val = $row->transit_from_station_name;
            $val .= ($row->transit_from_station_short_code != "") ? ' ( ' . $row->transit_from_station_short_code . ' )' : '';
            $val .= ' to ' . $row->transit_to_organization_name;
            $val .= ($row->transit_to_organization_short_code != "") ? ' ( ' . $row->transit_to_organization_short_code . ' )' : '';

            $routes[$key] = $val;
            $list[$key][] = $row;
            
            $summary[$row->payment_status_code]['lr'] += 1;
            //$summary[$row->payment_status_code]['paycode'] += $row->payment_status_code;
            $summary[$row->payment_status_code]['packages'] += $row->total_item_count;
            $summary[$row->payment_status_code]['freight'] += $row->total_amount;
            $summary[$row->payment_status_code]['loading'] += $row->total_handling_amount;
            $summary[$row->payment_status_code]['unloading'] += $row->total_unload_handling_amount;
            $summary[$row->payment_status_code]['service_tax'] += $row->service_tax;
            $summary[$row->payment_status_code]['connecting'] += $row->connecting_charge;
            $summary[$row->payment_status_code]['kg_val'] += $row->total_unit_value;
            $summary[$row->payment_status_code]['ac_kg_val'] += $row->total_actual_unit_value;
            $summary[$row->payment_status_code]['delivery'] += ($row->pickup_handling_amount + $row->delivery_handling_amount);

            $remaining_amounts =$row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->service_charge+$row->pod_charge+$row->demurrage_charge+$row->round_off_value;
            $summary[$row->payment_status_code]['remaining_amounts'] += $remaining_amounts;

            $html = "<table>
                        <tr>
                            <td align='right'>Hamili Charges : </td>
                            <td align='right' style='padding-left:15px;'>{$row->hamali_charge}</td>
                        </tr>
                        <tr>
                            <td align='right'>Pass Charge : </td>
                            <td align='right'>{$row->pass_charge}</td>
                        </tr>
                        <tr>
                            <td align='right'>Docker charges : </td>
                            <td align='right'>$row->docket_charge</td>
                        </tr>
                        <tr>
                            <td align='right'>Service Charges : </td>
                            <td align='right'>$row->service_charge</td>
                        </tr>
                        <tr>
                            <td align='right'>POD Charges : </td>
                            <td align='right'>$row->pod_charge</td>
                         </tr>
                        <tr>
                            <td align='right'>Demurrage Charges : </td>
                            <td align='right'>$row->demurrage_charge</td>
                         </tr>
                         <tr>
                            <td align='right'>RoundOff Amount : </td>
                            <td align='right'>$row->round_off_value</td>
                         </tr>
                     <table>";
            $summary[$row->payment_status_code]['remaining_amounts_tooltip'] = $html;
            $summary[$row->payment_status_code]['hamali_charge'] += $row->hamali_charge;
            $summary[$row->payment_status_code]['pass_charge'] += $row->pass_charge;
            $summary[$row->payment_status_code]['docket_charge'] += $row->docket_charge;
            $summary[$row->payment_status_code]['service_charge'] += $row->service_charge;
            $summary[$row->payment_status_code]['pod_charge'] += $row->pod_charge;
            $summary[$row->payment_status_code]['demurrage_charge'] += $row->demurrage_charge;
            $summary[$row->payment_status_code]['round_off_value'] += $row->round_off_value;
        }
       
        return array(
            'transitDetails' =>$transitDetails,
            'list' =>$list,
            'results' =>$result->data,
            'routes' =>$routes,
            'summary' =>$summary,
            'rowCount' =>$rowCount,
        );
    }
}