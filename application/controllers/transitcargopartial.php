<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');


class Transitcargopartial extends MY_Controller
{ // Partial controller

    function __construct()
    {
        parent::__construct();
    }

    private function processLRData($lr_data)
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

    public function throw_partial($direct_lr, $link_lr, $local_lr)
    {
        $direct_response = $this->processLRData($direct_lr);
        $link_response = $this->processLRData($link_lr);
        $local_response = $this->processLRData($local_lr);
        $data = [
            "success" => [
                "direct" => $direct_response["success"]??[],
                "link" => $link_response["success"]??[],
                "local" => $local_response["success"]??[]
            ],
            "failed" => [
                "direct" => $direct_response["failed"]??[],
                "link" => $link_response["failed"]??[],
                "local" => $local_response["failed"]??[]
            ]
        ];
        return $data;
    }

    // index
    public function save_partial_request()
    {
        $error = array();
        $request = json_decode(file_get_contents('php://input'));
        $partial = $request->partial;
        // $slice = clone $request->partial;
        $slice = unserialize(serialize($partial));
       
        //existing save datas
        $loadedData = $request->loadedData;

        $ogpl_data_code='';

        if($loadedData->saveAsTemplate == 1){
            $template=$this->saveTemplate($loadedData);
            $deTemplate=json_decode($template);
            if($deTemplate->status!=1){
                $finalBody=array('save'=>$deTemplate,
                'partial'=>array());
                $data=array('status'=>$deTemplate->status,'msg'=>$deTemplate->errorDesc,'data'=>$finalBody);
                echo json_encode($data);
                exit;
            }
        }
      
        $updateTransit=$this->updateTransit($loadedData);
        $deUpdateTransit=json_decode($updateTransit);
        if($deUpdateTransit->status!=1){
            $finalBody=array('save'=>$deUpdateTransit,
            'partial'=>array());
             $data=array('status'=>$deUpdateTransit->status,'msg'=>$deUpdateTransit->errorDesc,'data'=>$finalBody);
             echo json_encode($data);
             exit;
        }else{
            $ogpl_data_code=$deUpdateTransit->data->code;
        }

        $direct_lrs = [];
        $link_lrs = [];
        $local_lrs = [];

        foreach ($slice->direct as $direct) {
            unset($direct->extraData);
            $direct_lrs[] = $direct;
        }
        foreach ($slice->link as $link) {
            unset($link->extraData);
            $link_lrs[] = $link;
        }
        foreach ($slice->local as $local) {
            unset($local->extraData);
            $local_lrs[] = $local;
        }

        // request Parent Lr datas and get partial splited Lr details
        $partial_resp = $this->throw_partial($direct_lrs, $link_lrs, $local_lrs);

        //bind Parent Lr details to Partialy successed Lrs
        $get_modified=$this->bind_partial($partial,$partial_resp);
      
        // $get_modified=array();
       
        $saveReq=$this->merge_save_call_to_partial($get_modified, $loadedData,$ogpl_data_code);
        $saveReq=json_decode($saveReq);
        $saveReq->OGPLCode=$ogpl_data_code;  //get ogpl code form ogpl update
        $msg='';

        $finalBody=array('save'=>$saveReq,
                          'partial'=>$partial_resp);

        $data=array('status'=>$saveReq->status,'msg'=>$saveReq->errorDesc,'data'=>$finalBody);
        echo json_encode($data);

    }

    public function bind_partial($partial,$partial_resp)
    {
        $success_partial_lrs=$partial_resp['success'];
        $failed_partial_lrs=$partial_resp['failed'];

        if(count($success_partial_lrs['direct'])>0){
            $type="direct";
            ${$type . '_src'}=$partial->$type;
            ${$type . '_partial_group'}=array();
            foreach($success_partial_lrs[$type] as $resp){
                    $cargo_parent=$resp->code;
                    foreach(${$type . '_src'} as $src){ 
                        $extraData=$src->extraData;
                        if($src->code===$cargo_parent){
                            foreach($success_partial_lrs[$type] as $sub_list){
                                if($sub_list->code==$cargo_parent){
                                  $child_cargo=$sub_list->subCargoList[0];
                                  ${$type . '_partial_group'}[]=[
                                        "cargoList"=> array($child_cargo->code),
                                        "from"=> $extraData->from,
                                        "to"=> $extraData->to,
                                        "oldTransitOrg"=> $extraData->oldTransitOrg,
                                        "transitOrganization"=>$extraData->transitOrganization,
                                    ];
                                }
                              }
                        }
                    }
            }
        }
        if(count($success_partial_lrs['link'])>0){
            $type="link";
            ${$type . '_src'}=$partial->$type;
            ${$type . '_partial_group'}=array();
            foreach($success_partial_lrs[$type] as $resp){
                    $cargo_parent=$resp->code;
                    foreach(${$type . '_src'} as $src){ 
                        $extraData=$src->extraData;
                        if($src->code===$cargo_parent){
                            foreach($success_partial_lrs[$type] as $sub_list){
                                if($sub_list->code==$cargo_parent){
                                  $child_cargo=$sub_list->subCargoList[0];
                                  ${$type . '_partial_group'}[]=[
                                        "cargoList"=> array($child_cargo->code),
                                        "from"=> $extraData->from,
                                        "to"=> $extraData->to,
                                        "oldTransitOrg"=> $extraData->oldTransitOrg,
                                        "transitOrganization"=>$extraData->transitOrganization,
                                    ];
                                }
                              }
                        }
                    }
            }
        }
        if(count($success_partial_lrs['local'])>0){
            $type="local";
            ${$type . '_src'}=$partial->$type;
            ${$type . '_partial_group'}=array();
            foreach($success_partial_lrs[$type] as $resp){
                    $cargo_parent=$resp->code;
                    foreach(${$type . '_src'} as $src){ 
                        $extraData=$src->extraData;
                        if($src->code===$cargo_parent){
                            foreach($success_partial_lrs[$type] as $sub_list){
                                if($sub_list->code==$cargo_parent){
                                  $child_cargo=$sub_list->subCargoList[0];
                                  ${$type . '_partial_group'}[]=[
                                        "cargoList"=> array($child_cargo->code),
                                        "from"=> $extraData->from,
                                        "to"=> $extraData->to,
                                        "oldTransitOrg"=> $extraData->oldTransitOrg,
                                        "transitOrganization"=>$extraData->transitOrganization,
                                    ];
                                }
                              }
                        }
                    }
            }
        }
        $data = [
            "success" => [
                "direct" => $direct_partial_group??[],
                "link" =>  $link_partial_group??[],
                "local" => $local_partial_group??[]
            ],
            "failed" => $failed_partial_lrs
        ];
        return $data;

    }

    // public function merge_save_call_to_partial($partialedLrs, $loadedData,$ogpl_data_code) {
    //     $directTransit = $partialedLrs['success']['direct'];
    //     $linkTransit = $partialedLrs['success']['link'];
    //     $localTransit = $partialedLrs['success']['local'];
    
    //     // Partial Lr Mergin Start
    //     $loadedData->directLoadList = !empty($loadedData->directLoadList) ? $loadedData->directLoadList : [];
    //     $loadedData->linkLoadList = !empty($loadedData->linkLoadList) ? $loadedData->linkLoadList : [];
    //     $loadedData->localTransitList = !empty($loadedData->localTransitList) ? $loadedData->localTransitList : [];
    
    //     // Direct transit
      
    //     $foundMatchDirect = false;
    //     foreach ($loadedData->directLoadList as $i => $directTransitItem) {
    //         foreach ($directTransit as $directTransitData) {
    //             if ($directTransitItem->to === $directTransitData['to']) {
    //                 // Ensure $directTransitItem->cargoList is an array
    //                 if (!is_array($directTransitItem->cargoList)) {
    //                     $directTransitItem->cargoList = array($directTransitItem->cargoList);
    //                 }
    //                 // Ensure $directTransitData->cargoList is an array
    //                 if (!is_array($directTransitData['cargoList'])) {
    //                     $directTransitData['cargoList'] = array($directTransitData['cargoList']);
    //                 }
    //                 // Merge cargo lists
    //                 $directTransitItem->cargoList = array_merge($directTransitItem->cargoList, $directTransitData['cargoList']);
    //                 $foundMatchDirect = true;
    //             }
    //         }
    //     }
    //     if (!$foundMatchDirect) {
    //         foreach ($directTransit as $directTransitData) {
    //             $loadedData->directLoadList[] = (object) $directTransitData;
    //         }
    //     }

    //     // Link transit
    //     $foundMatchLink = false;
    //     foreach ($loadedData->linkLoadList as $i => $linkTransitItem) {
    //         foreach ($linkTransit as $linkTransitData) {
    //             if ($linkTransitItem->to === $linkTransitData['to']) {
    //                 // Ensure $linkTransitItem->cargoList is an array
    //                 if (!is_array($linkTransitItem->cargoList)) {
    //                     $linkTransitItem->cargoList = array($linkTransitItem->cargoList);
    //                 }
    //                 // Ensure $linkTransitData->cargoList is an array
    //                 if (!is_array($linkTransitData['cargoList'])) {
    //                     $linkTransitData['cargoList'] = array($linkTransitData['cargoList']);
    //                 }
    //                 // Merge cargo lists
    //                 $linkTransitItem->cargoList = array_merge($linkTransitItem->cargoList, $linkTransitData['cargoList']);
    //                 $foundMatchLink = true;
    //             }
    //         }
    //     }

    //     if (!$foundMatchLink) {
    //         // $loadedData->linkLoadList=array_merge($loadedData->linkLoadList, $linkTransit);
    //         foreach ($linkTransit as $linkTransitData) {
    //             $loadedData->linkLoadList[] = (object) $linkTransitData;
    //         }
    //     }
    //     // Local transit
    //     $foundMatchLocal = false;
    //     foreach ($loadedData->localTransitList as $i => $localTransitItem) {
    //         foreach ($localTransit as $localTransitData) {
    //             if ($localTransitItem->to === $localTransitData['to']) {
    //                 // Ensure $localTransitItem->cargoList is an array
    //                 if (!is_array($localTransitItem->cargoList)) {
    //                     $localTransitItem->cargoList = array($localTransitItem->cargoList);
    //                 }
    //                 // Ensure $localTransitData->cargoList is an array
    //                 if (!is_array($localTransitData['cargoList'])) {
    //                     $localTransitData['cargoList'] = array($localTransitData['cargoList']);
    //                 }
    //                 // Merge cargo lists
    //                 $localTransitItem->cargoList = array_merge($localTransitItem->cargoList, $localTransitData['cargoList']);
    //                 $foundMatchLocal = true;
    //             }else{
    //                 // $loadedData->localTransitList[] = (object) $localTransitData;
    //             }
    //         }
    //     }
        
    //     if (!$foundMatchLocal) {
    //         foreach ($localTransit as $localTransitData) {
    //             $loadedData->localTransitList=array_merge($loadedData->localTransitList, $localTransit);
    //         }
    //     }
    
        
    //     $response=$this->save_transitv3($loadedData,$ogpl_data_code);
    //     return $response;
    // }

    private function merge_save_call_to_partial($partialedLrs, $loadedData,$ogpl_data_code) {
        $directTransit = $partialedLrs['success']['direct'];
        $linkTransit = $partialedLrs['success']['link'];
        $localTransit = $partialedLrs['success']['local'];
    
        // Partial Lr Merging Start
        $loadedData->directLoadList = !empty($loadedData->directLoadList) ? $loadedData->directLoadList : [];
        $loadedData->linkLoadList = !empty($loadedData->linkLoadList) ? $loadedData->linkLoadList : [];
        $loadedData->localTransitList = !empty($loadedData->localTransitList) ? $loadedData->localTransitList : [];
    
        // Define a reusable function to merge transit data
        $mergeTransitData = function ($transitData, &$loadedDataList) {
            foreach ($transitData as $transitItem) {
                $matched = false;
                foreach ($loadedDataList as $loadedItem) {
                    if ($loadedItem->to === $transitItem['to']) {
                        $loadedItem->cargoList = array_merge(
                            (array)$loadedItem->cargoList,
                            (array)$transitItem['cargoList']
                        );
                        $matched = true;
                        break;
                    }
                }
                if (!$matched) {
                    $loadedDataList[] = (object)$transitItem;
                }
            }
        };
    
        // Merge direct transit
        $mergeTransitData($directTransit, $loadedData->directLoadList);
    
        // Merge link transit
        $mergeTransitData($linkTransit, $loadedData->linkLoadList);
    
        // Merge local transit
        $mergeTransitData($localTransit, $loadedData->localTransitList);
    
        
        return $this->save_transitv3($loadedData,$ogpl_data_code); 
    }

    public function save_transitv3($loadedData,$ogpl_data_code) {

        $directLoadList = $loadedData->directLoadList ?: [];
        $linkLoadList = $loadedData->linkLoadList ?: [];
        $localTransitList = $loadedData->localTransitList ?: [];
        $outForDeliveryList = $loadedData->outForDeliveryList ?: [];
        $cargoResponseState = [];

        // Direct Load
        $directLoadList = json_decode(json_encode($directLoadList), true);  
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
                'transitCargo' => array('code' =>$ogpl_data_code),
                'transitOrganization' => array('code' => $row['transitOrganization']),
                'cargoList' => $codes
            ));
            $load = json_decode($load);

            if ($load->status == 1) {
                $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
            } else {
                return json_encode($load);
            }
        }

        // Link Load
        $linkLoadList = json_decode(json_encode($linkLoadList), true);
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
                'transitCargo' => array('code' => $ogpl_data_code),
                'transitOrganization' => array('code' => $row['transitOrganization']),
                'cargoList' => $codes
            ));
            $load = json_decode($load);

            // if ($load->status == 1) {
            //     $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
            // } else {
            //     echo json_encode($load);
            //     return;
            // }
        }

        // Local Transit

            $localTransitList = json_decode(json_encode($localTransitList), true);
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
                'transitCargo' => array('code' => $ogpl_data_code),
                'transitOrganization' => array('code' => $row['transitOrganization']),
                'cargoList' => $codes
            ));
            $load = json_decode($load);

            if ($load->status == 1) {
                $cargoResponseState = array_merge($cargoResponseState, $load->data->cargoList);
            } else {
                return json_encode($load);
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
                return json_encode($load);
            }
        }


        return json_encode(array(
            'status' => 1,
            'OGPLCode' => $ogpl->data->code,
            'OGPLDate' => $loadedData->tripDate,
            'cargoResponseState' => $cargoResponseState
        ));
    }
 
    public function saveTemplate($loadedData){
        $saveAsTemplate = $loadedData->saveAsTemplate;
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
                return json_encode($tpl);
        }
    }
    public function updateTransit($loadedData){
        $ogpl = $this->api_model->cargoOGPLupdate(array(
            'activeFlag' => $loadedData->activeFlag,
            'code' => $loadedData->code ?: '',
            'name' => $loadedData->name,
            'fromStation' => $loadedData->fromStation,
            'toStation' => $loadedData->toStation,
            'fromOrganization' => array('code' => $this->session->userdata('org_code')),
            'toOrganization' => array('code' => $this->session->userdata('org_code')),
            'viaStations' => $loadedData->viaStations ?: [],
            'viaZones' => $loadedData->viaZones ?: [],
            'hubViaStations' => $loadedData->linkLoadStations ?: [],
            'hubViaZones' => $loadedData->hubViaZones ?: [],
            'localViaOrganizations' => $loadedData->localViaOrganizations ?: [],
            'tripDate' => $loadedData->tripDate,
            'busVehicle' => $loadedData->busVehicle,
            'supervisor' => $loadedData->supervisor,
            'vehicleDriver' => $loadedData->vehicleDriver,
            'secondaryDriver' => $loadedData->secondaryDriver ?: ['code' => ''],
            // 'cargoActivityType' => array('code' => 'TRNT'),
            'activityType' => $loadedData->activityType,
            'remarks' => $loadedData->remarks ?: '',
            'arrivalMinutes' => (int) hoursTominutes(date('H:i')),
            'departureMinutes' => (int) hoursTominutes(date('H:i')),
            'odometer' => $loadedData->odometer ?: '',
            'transitReference' => $loadedData->transitReference ?: [],
        ));

            $ogpl = json_decode($ogpl);
            return json_encode($ogpl);
       
    }
   
}
