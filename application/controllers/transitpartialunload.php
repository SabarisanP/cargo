<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');


class Transitpartialunload extends MY_Controller
{ // Partial controller

    function __construct()
    {
        parent::__construct();
    }

  
    public function partial_unload() {
       // $this->is_logged_in(); // Make sure the user is logged in
    
        $response = [];
        $trip_resp = [];
    
        // Fetching necessary data from POST request
        $partial = $this->input->post('partial');
        $data = $this->input->post('data');
        $trip = $this->input->post('tripData');

        // If trip data is provided, update end odometer and handle response
       
        if (!empty($trip)) {
            $trip_data = $this->update_end_odometer($trip[0]);
            $trip_data = json_decode($trip_data);
            if ($trip_data->status == 0) {
                $trip_resp = [
                    'status' => $trip_data->status,
                    'msg' => $trip_data->errorDesc,
                    'data' => []
                ];
                echo json_encode($trip_resp);
                exit;
            }
        }
        // Extracting relevant data from partials
        $partial_data = [];
        $partisan_lrs = [];
        foreach ($partial as $lrs) {
            unset($lrs['extraData']);
            $partial_data[] = $lrs['unloadObj'];
            unset($lrs['unloadObj']);
            $partisan_lrs[] = $lrs;
        }
    
        // Make partial and bind it to data
       
            $parialed_lrs = $this->makePartial($partisan_lrs);
            $paritial_binned_lrs = $this->bind_partial($partial_data, $parialed_lrs);
            
            if(!empty($data['codes'])){
                $data['codes'] = array_merge($data['codes'], $paritial_binned_lrs);
            }else{
                $data['codes']=$paritial_binned_lrs;
            }

            // Prepare data for saving
            $saveReqData = [
                'transitCode' => $data['transitCode'],
                'transitOrganization' => $data['transitOrganization'],
                'codes' => $data['codes']
            ];
      
        // Save unload data and handle response
        $save = $this->saveUnload($saveReqData);
        $savedData = json_decode($save);
    
        // Prepare the final response
        $collection = ['trip' => $trip_resp, 'unloadData' => $savedData, 'partial' => $parialed_lrs];
        $response = [
            'status' => $savedData->status,
            'msg' => $savedData->errorDesc,
            'data' => $collection
        ];
    
        // Send the final response
        echo json_encode($response);
    }

    //tools
    private function makePartial($lr_data)
    {
        $response = [
            "success" => [],
            "failed" => []
        ];

        if (count($lr_data) > 0) {
            $result = $this->api_model->get_partials(json_encode($lr_data));
            if (json_decode($result)->status == 1) {
                $result = json_decode($result)->data;
                foreach ($result as $item) {
                    if ($item->activeFlag == 1) {
                        $response["success"][] = $item;
                    } else {
                        $response["failed"][] = $item;
                    }
                }
                $status=json_decode($result)->status;
            }
            else{
                $msg=$result->errorDesc;
            }
        } else {
            return "no data found";
        }

        // return $data = array('status' => $status,'msg'=>$msg, 'data' => $response);
        return $response;
    }
    private function bind_partial($partial_data,$parialed_lrs){
        $data=array();

        $success_partial_lr=$parialed_lrs['success'];

        if (count($success_partial_lr) > 0) {
            foreach ($success_partial_lr as $resp) {
                // Extracting the parent cargo code
                $cargo_parent = $resp->code;
                
                foreach ($partial_data as $val) {
                    if ($val['code'] == $cargo_parent) {
                        $cargo_child_code = $resp->subCargoList[0]->code;
                        $data[] = array(
                            'code' => $cargo_child_code,
                            'cargoStatus' => $val['cargoStatus'],
                            'remarks' => $val['remarks']
                        );
                    }
                }
            }
        }
       return $data;
    }

    private function saveUnload($saveReqData){
        //mirror: cargo/ogpl_update_unload();
        
        $transitOrganization = $saveReqData['transitOrganization'] ?: ['code' => ''];
        if ($transitOrganization['code']) {
            $type = 'HUB_UNLOAD';
        }

        return $this->api_model->cargoOGPLStatusUpdate(array(
            'transitStatus' => array('code' => 'UNLOAD'),
            'transitCode' => $saveReqData['transitCode'],
            'transitOrganization' => $transitOrganization,
            'cargoList' => $saveReqData['codes'] ?: [],
            'type' => $type
        ));
    }
    public function update_end_odometer($trip) {
        

         $response = $this->api_model->updateTransitOdometer(array(
            'action' => $trip['action'],
            'transitCode' => $trip['transitCode'],
            'transitCargo' => $trip['transitCargo'],
            'toOrganization' => $trip['toOrganization'] ?: null,
            'toOrganizationContact' => $trip['toOrganizationContact'],
            'endOdometer' => (int) $trip['endOdometer'],
            'arrivalAt' => $trip['arrivalAt'],
        ));
        return $response;
    }
}
