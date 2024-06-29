{if $status !=1}

    <div class="clear_fix_both"></div>
    <div class="row">
        <div class="col-md-2">
            <div class="pb5" data-tripcode="{$reports->tripCode}" data-tripstagecode="{$reports->tripStageCode}">
                <div class="bold">PNR</div>
                {$reports->code} &nbsp;{if $reports->deviceMedium == 'WEB'}<i class="fa fa-desktop"></i>{else}<i class="fa fa-mobile"></i>{/if}
                <input type="hidden" id="sms-trip-code" value="{$reports->tripCode}">
            </div>
            <div class="pb5">
                <div class="bold">Travel Date</div>
                {date('d/m/Y g:i A',strtotime($reports->travelDate))}
            </div>
            {if $reports->toStation->stationPoint[0]->name !='' && $reports->fromStation->stationPoint[0]->name !=''}
            <div class="pb5">
                <div class="bold">Boarding Time</div> 
                {$reports->fromStation->stationPoint[0]->dateTime|date_format:$ns_datetime_format}
                {assign var="board_time" value=$reports->fromStation->stationPoint[0]->dateTime|date_format:$ns_time_format}
            </div>
            {/if}
            <div class="pb5">
                <div class="bold">Passenger Mobile</div>
                {$reports->passegerMobleNo}
            </div>
        </div>
            
        <div class="col-md-2">
            <div class="pb5">
                <div class="bold">Route</div>
                {$reports->fromStation->name} To {$reports->toStation->name}
            </div>
            {if  $reports->serviceNo!=''}
            <div class="pb5">
                <div class="bold">Service Number</div>
                <span class="warning-text bold">{$reports->serviceNo}</span>
            </div>
            {/if}
            <div class="pb5">
                <div class="bold">Booked By</div>
                {$reports->user->name} , {date('d/m/Y g:i A',strtotime($reports->transactionDate))}
            </div>
            <div class="pb5">
                <div class="bold">Bus Type</div>            
                {formatBusCategory cate_code=$reports->bus->categoryCode}
            </div>
        </div>
        {if $reports->toStation->stationPoint[0]->name !='' && $reports->fromStation->stationPoint[0]->name !='' || $reports->remarks != ""}    
        <div class="col-md-2">
            {if $reports->toStation->stationPoint[0]->name !='' && $reports->fromStation->stationPoint[0]->name !=''}
            <div class="pb5">
                <div class="bold">Boarding Address</div>
                {if $reports->fromStation->stationPoint[0]->name !=''}
                    {$reports->fromStation->stationPoint[0]->name}, 
                    {$reports->fromStation->stationPoint[0]->landmark}, 
                    {$reports->fromStation->stationPoint[0]->address}<br>
                    {$reports->fromStation->stationPoint[0]->number}
                {else}-{/if}
            </div>
            <div class="pb5">
                <div class="bold">Alighting Info</div>
                {if $reports->toStation->stationPoint[0]->name !=''}
                    {$reports->toStation->stationPoint[0]->name}, 
                    {$reports->toStation->stationPoint[0]->landmark},                 
                    {$reports->toStation->stationPoint[0]->address}<br>
                    {$reports->toStation->stationPoint[0]->number}
                {else}-{/if}
            </div>
            {/if}
            {if $reports->remarks != ""}
            <div class="pb5">
                <div class="bold">Remarks</div>
                {$reports->remarks}
            </div>
            {/if}
        </div>
        {/if}
        <div class="col-md-2 divider-vertical">
            <div class="pb5">
                <div class="bold">Voucher</div>
                {if $reports->ticketTransaction[0]->paymentTransaction->code == 'SUCCESS'}
                    Generated
                {else}
                    Not Generated
                {/if}
            </div>
            <div class="pb5">
                <div class="bold">Vehicle Number</div>
                {if $trips->busVehicle->registationNumber}
                    {$trips->busVehicle->registationNumber}
                 {else}
                     -
                {/if}    
            </div>
            <div class="pb5">
                <div class="bold">Driver Contact</div>
                {if $trips->driverName || {$trips->driverMobile}}
                    {$trips->driverName}&nbsp;/&nbsp;{$trips->driverMobile}
                {else}
                    -
                {/if}    
            </div>
            <div class="pb5">
                <div class="bold">Travel Status</div>
                {$reports->ticketDetails[0]->travelStatus->name}
            </div>
        </div>
            
    </div> 
   
        
    {if $reports->code != $reports->bookingCode}
        <br>
        <div class="row">
            <div class="col-sm-12">
               <div class="bold">Transaction Id</div>
                {$reports->bookingCode}
            </div>
        </div>    
    {/if}    
        
    {if $cancel != 1}
        <br>
        
        <div class="clear_fix_both"></div>
        <div >
            <div class="table-responsive">
                <table id="dt_report_table" class="table" style='border:1px solid #dddddd;'>
                    <thead>
                        <tr bgcolor="#F5F5F5">
                            <th style='border:1px solid #dddddd'>Passenger Name</th>
                            <th style='border:1px solid #dddddd;text-align:center '>Seat No</th>
                            <th style='border:1px solid #dddddd;text-align:center '>Gender</th>
                            <th style='border:1px solid #dddddd;text-align:center '>Age</th>                       
                            <th style='border:1px solid #dddddd;text-align:center '>Status</th>
                            <th style='border:1px solid #dddddd;text-align:center '>Fare</th>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {assign var="tot_trans" value=0}
                        {assign var="seat_fare" value=0}
                        {assign var="ca_seat_fare" value=0}
                        {assign var="tax" value=0}
                        {assign var="ca_tax" value=0}
                        {assign var="can_charge" value=0}
                        {assign var="refund" value=0}
                        {foreach item=row from=$reports->ticketDetails}
                        <tr id='seat-{$row->seatCode}' {if $row->seatStatus->code=="CA" || $row->seatStatus->code=="PCA" || $row->seatStatus->code=="PBC" } class="cancelled-seat" {/if}>
                            <td style='border:1px solid #dddddd'>{$row->passengerName}</td>
                            <td style='border:1px solid #dddddd' align="center">{$row->seatName}</td>
                            <td style='border:1px solid #dddddd' align="center">{if $row->passengerGendar=='M'}Male{else}Female{/if}</td>
                            <td style='border:1px solid #dddddd' align="center">{$row->passengerAge}</td>                            
                            <td style='border:1px solid #dddddd' align="center">{$row->seatStatus->name}</td>
                            <td style='border:1px solid #dddddd;' align="right">{$row->seatFare|number_format:2:".":","}</td>

                            <input type="hidden" value="{$row->refundAmount}" id="refund">
                            <input type="hidden" value="{$code}" id="pnr_code">      
                            {assign var="pass_name" value=$row->passengerName}
                            {assign var="seat_name" value=$row->seatName}
                            {if $row->seatStatus->code=="CA"}
                                {assign var="can_charge" value=$can_charge+$row->cancellationCharges}
                                {assign var="refund" value=$refund+$row->refundAmount+$row->serviceTax}
                                {assign var="ca_seat_fare" value=$ca_seat_fare+$row->seatFare}
                                {assign var="ca_tax" value=$ca_tax+$row->serviceTax}
                            {else if $row->seatStatus->code!="PBC"}
                                {assign var="tot_trans" value=$tot_trans+$row->seatFare+$row->serviceTax}
                                {assign var="tax" value=$tax+$row->serviceTax}
                                {assign var="seat_fare" value=$seat_fare+$row->seatFare}
                            {/if}                            
                        </tr>
                    {/foreach}

                                                           
                    {assign var="discount" value=0}
                    {assign var="gogreen" value=0}
                    {assign var="ca_discount" value=0}
                    {assign var="service_charges" value=0}
                    
                    {foreach item=dis from=$reports->ticketAddonsDetails}
                        {if $dis->addonType->code=="AGSC"}
                            {assign var="service_charges" value=$service_charges+$dis->value}
                            {assign var="tot_trans" value=$tot_trans+$dis->value}
                        {elseif ($dis->addonType->code=="SHDS" || $dis->addonType->code=="DSAMT" || $dis->addonType->code=="COUP" || $dis->addonType->code=="OFDS" || $dis->addonType->code=="WARD" || $dis->addonType->code=="WACP") && $dis->addonStatus->code!="CA"} 
                            {assign var="discount" value=$discount+$dis->value}
                            {assign var="tot_trans" value=$tot_trans-$dis->value}  
                        {elseif ($dis->addonType->code=="SHDS" || $dis->addonType->code=="DSAMT" || $dis->addonType->code=="COUP" || $dis->addonType->code=="OFDS" || $dis->addonType->code=="WARD" || $dis->addonType->code=="WACP") && $dis->addonStatus->code=="CA"}     
                            {assign var="refund" value=$refund-$dis->value}
                            {assign var="ca_discount" value=$ca_discount+$dis->value}
                        {elseif $dis->addonType->code == 'WARD' || $dis->addonType->code == 'WACP'}
                            {assign var="discount" value=$discount+$dis->value}
                            {assign var="tot_trans" value=$tot_trans-$dis->value}
                        {elseif $dis->addonType->code == 'GGN'}
                            {assign var="gogreen" value=$gogreen+$dis->value}
                            {assign var="tot_trans" value=$tot_trans+$dis->value}
                        {/if}
                    {/foreach}  
                    
                    </tbody>
                </table>
                    
                <div class="row">
                    
                    {if $reports->tax!=''}
                    <div class="col-md-4 pull-left">
                        <div class="well well-sm" style="border-radius: 4px; border: 1px solid #b6b8b9;">
                            <table class="" width="100%" cellpadding="2">
                                <tr>
                                    <td style='border:1px solid #ecf0f1' align="center" colspan="2" class="bold">GST</td>                            
                                </tr>
                                <tr><td style='border-bottom:1px solid #b6b8b9; padding-top: 0px' align="right" colspan="2"></td></tr>
                                
                                <tr>
                                    <td style='border:1px solid #ecf0f1' align="right"> GSTIN &nbsp;:&nbsp;</td>
                                    <td style='border:1px solid #ecf0f1' align="left">  {$reports->tax->gstin}</td>
                                </tr>
                                <tr><td style='border-bottom:1px solid #b6b8b9; padding-top: 0px' align="right" colspan="2"></td></tr>
                                
                                <tr>
                                    <td style='border:1px solid #ecf0f1' align="right"> Trade Name &nbsp;:&nbsp;</td>
                                    <td style='border:1px solid #ecf0f1' align="left"> {$reports->tax->tradeName}</td>
                                </tr>                              
                                
                                {if $reports->tax->cgstValue > 0} 
                                    <tr><td style='border-bottom:1px solid #b6b8b9; padding-top: 0px' align="right" colspan="2"></td></tr>
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> CGST &nbsp;:&nbsp;</td>
                                        <td style='border:1px solid #ecf0f1' align="left"> {$reports->tax->cgstValue} %</td>
                                    </tr>                                    
                                {/if} 
                                {if $reports->tax->sgstValue > 0}
                                    <tr><td style='border-bottom:1px solid #b6b8b9; padding-top: 0px' align="right" colspan="2"></td></tr>
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> SGST &nbsp;:&nbsp;</td>
                                        <td style='border:1px solid #ecf0f1' align="left"> {$reports->tax->sgstValue} %</td>
                                    </tr>                                    
                                {/if}
                                
                                {if $reports->tax->igstValue>0}
                                    <tr><td style='border-bottom:1px solid #b6b8b9; padding-top: 0px' align="right" colspan="2"></td></tr>
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> IGST &nbsp;:&nbsp;</td>
                                        <td style='border:1px solid #ecf0f1' align="left"> {$reports->tax->igstValue} % </td>
                                    </tr>                                    
                                {/if} 
                                                                
                                {if $reports->tax->ugstValue > 0} 
                                    <tr><td style='border-bottom:1px solid #b6b8b9; padding-top: 0px' align="right" colspan="2"></td></tr>
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> UGST &nbsp;:&nbsp;</td>
                                        <td style='border:1px solid #ecf0f1' align="left"> {$reports->tax->ugstValue} %</td>
                                    </tr>  
                                {/if} 
                                  
                            </table>
                        </div>
                    </div>
                    {/if}
                    
                    
                    {if $tot_trans > 0} 
                    <div class="col-md-3 pull-right">
                        <div class="well well-sm" style="border-radius: 4px; border: 1px solid #b6b8b9;">
                            <table class="" width="100%" cellpadding="2">
                                <tr>
                                    <td style='border:1px solid #ecf0f1' align="center" colspan="2" class="bold">Booking</td>                            
                                </tr>
                                {if $seat_fare > 0}
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> Gross Amount :</td>
                                        <td style='border:1px solid #ecf0f1' align="right">  {$seat_fare|number_format:2}</td>
                                    </tr>
                                {/if}
                                
                                {if $discount > 0}  
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> Discount :</td>
                                        <td style='border:1px solid #ecf0f1' align="right"> - {$discount|number_format:2} </td>
                                    </tr>  
                                {/if}  

                                {if $tax > 0}
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> GST :</td>
                                        <td style='border:1px solid #ecf0f1' align="right"> + {$tax|number_format:2}</td>
                                    </tr>
                                {/if}
                                
                                {if $gogreen > 0}
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> Go Green Donation :</td>
                                        <td style='border:1px solid #ecf0f1' align="right"> + {$gogreen|number_format:2}</td>
                                    </tr>
                                {/if}

                                {if $service_charges > 0}  
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> Service Charges :</td>
                                        <td style='border:1px solid #ecf0f1' align="right"> + {$service_charges|number_format:2} </td>
                                    </tr>  
                                {/if} 
                                
                                <tr>
                                    <td style='border-bottom:1px solid #b6b8b9; padding-top: 0px' align="right" colspan="2"></td>
                                </tr>
                                {if $tot_trans > 0} 
                                <tr>
                                    <td style='border-top:1px solid #b6b8b9' align="right" class="bold"> Total :</td>
                                    <td style='border-top:1px solid #b6b8b9' align="right" class="bold"> {$tot_trans|number_format:2} </td>
                                </tr>
                                 {/if}  
                            </table>
                        </div>
                    </div>
                    {/if}
                    
                    {if $can_charge>0 || $refund>0}
                    <div class="col-md-3 pull-right">
                        <div class="well well-sm" style="border-radius: 4px; border: 1px solid #b6b8b9;">
                            <table class="" width="100%">
                                <tr>
                                    <td style='border:1px solid #ecf0f1' align="center" colspan="2" class="bold">Cancellation</td>                            
                                </tr>
                                {if $ca_seat_fare>0}
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> Gross Amount :</td>
                                        <td style='border:1px solid #ecf0f1' align="right">  {$ca_seat_fare|number_format:2}</td>
                                    </tr>
                                {/if}

                                {if $ca_tax>0}
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> GST :</td>
                                        <td style='border:1px solid #ecf0f1' align="right">  + {$ca_tax|number_format:2}</td>
                                    </tr>
                                {/if}

                                {if $can_charge>0}
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> Cancellation Charge :</td>
                                        <td style='border:1px solid #ecf0f1' align="right"> - {$can_charge|number_format:2}</td>
                                    </tr>
                                {/if}
                                {if $ca_discount>0}
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right"> Discount :</td>
                                        <td style='border:1px solid #ecf0f1' align="right"> - {$ca_discount|number_format:2}</td>
                                    </tr>
                                {/if}
                                <tr>
                                    <td style='border-bottom:1px solid #b6b8b9; padding-top: 0px' align="right" colspan="2"></td>
                                </tr>
                                {if $refund>0}
                                    <tr>
                                        <td style='border:1px solid #ecf0f1' align="right" class="bold"> Refund :</td>
                                        <td style='border:1px solid #ecf0f1' align="right" class="bold"> {$refund|number_format:2}</td>
                                    </tr>
                                {/if}
                            </table>
                        </div>
                    </div>    
                    {/if} 
                     

                </div>    
            </div>
        {else}

            <div >
                <div class="table-responsive">
                    <table id="dt_report_table" class="table" style='border:1px solid #dddddd;'>
                        <thead>
                            <tr bgcolor="#F5F5F5">

                                <th  style='border:1px solid #dddddd'>Passenger Name</th>
                                <th  style='border:1px solid #dddddd;text-align:center '>Seat No</th>
                                <th  style='border:1px solid #dddddd;text-align:center '>Gender</th>
                                <th  style='border:1px solid #dddddd;text-align:center '>Age</th>                       
                                <th style='border:1px solid #dddddd;text-align:center '>Status</th>
                                <th style='border:1px solid #dddddd;text-align:center '>Fare</th>
                                <th style='border:1px solid #dddddd'>GST</th>
                                <th style='border:1px solid #dddddd;text-align:center '>Refund Amount</th>                                 
                                <th style='border:1px solid #dddddd;text-align:center '>Cancellation Charge</th> 
                                <th  style='border:1px solid #dddddd'>Select</th>
                            </tr>
                        </thead>
                        <tbody class="body_table">
                            {assign var="tot_trans" value=0}
                            {assign var="tax" value=0}
                            {assign var="can_charge" value=0}
                            {assign var="refund" value=0}

                            {foreach item=row from=$reports->ticketDetails}
                                {assign var="offer" value=$row->refundAmount-$dis->value}
                                <tr id='seat-{$row->seatCode}' {if $row->seatStatus->code=="CA" || $row->seatStatus->code=="PCA" } class="cancelled-seat" {/if} data-seat="{$row->seatStatus->code}" data-ticket="{$reports->ticketStatus->code}">
                                    <td style='border:1px solid #dddddd'>{$row->passengerName}</td>
                                    <td style='border:1px solid #dddddd' align="center">{$row->seatName}</td>
                                    <td style='border:1px solid #dddddd' align="center">{if $row->passengerGendar=='M'}Male{else}Female{/if}</td>
                                    <td style='border:1px solid #dddddd' align="center">{$row->passengerAge}</td>                            
                                    <td style=''>{$row->seatStatus->name}</td>                                    
                                    <td style='border:1px solid #dddddd;' align="right">{$row->seatFare}</td>                                     
                                    <td style='border:1px solid #dddddd' align="right">{$row->serviceTax|round:2}</td>
                                    <td style='border:1px solid #dddddd' align="right">{$row->refundAmount}</td>
                                    <td style='border:1px solid #dddddd' align="right">{$row->cancellationCharges}</td>
                                    <td style='border:1px solid #dddddd' align="center">
                                        {if $row->seatStatus->code =='CAL' && ( $reports->ticketStatus->code=="BO" || $reports->ticketStatus->code=="PBL") }
                                           <input type="checkbox" class='pnr_user' id="pnr_user" name="pnr_user[]" value="{$row->seatCode},{$offer},{$row->serviceTax|round:2}">
                                        {else if $action_rights['OVER-REF-AMT']>0 && $row->seatStatus->code != "CA"}
                                           <input type="checkbox" class='pnr_user' id="pnr_user" name="pnr_user[]" value="{$row->seatCode},{$offer},{$row->serviceTax|round:2}">
                                        {else}
                                            -
                                        {/if}
                                    </td>                                
                                    <input type="hidden" value="{$row->refundAmount}" id="refund">
                                    <input type="hidden" value="{$code}" id="pnr_code">
                                    
                                    

                                    {if $row->seatStatus->code=="CA"}
                                        {assign var="can_charge" value=$can_charge+$row->cancellationCharges}
                                        {assign var="refund" value=$refund+$row->refundAmount+$row->serviceTax}
                                    {else}
                                        {assign var="tot_trans" value=$tot_trans+$row->seatFare+$row->serviceTax}
                                        {assign var="tax" value=$tax+$row->serviceTax}
                                    {/if}
                            
                            </tr>
                        {/foreach}
                        
                                                
                        {assign var="discount" value=0}
                        {assign var="gogreen" value=0}
                        {assign var="service_charges" value=0}

                        {foreach item=dis from=$reports->ticketAddonsDetails}
                            {if $dis->addonType->code=="AGSC" && $dis->addonStatus->code!="CA" }
                                {assign var="service_charges" value=$service_charges+$dis->value}
                                {assign var="tot_trans" value=$tot_trans+$dis->value}
                            {elseif ($dis->addonType->code=="SHDS" || $dis->addonType->code=="DSAMT" || $dis->addonType->code=="COUP") && $dis->addonStatus->code!="CA"} 
                                {assign var="discount" value=$discount+$dis->value}
                                {assign var="tot_trans" value=$tot_trans-$dis->value}
                            {elseif $dis->addonType->code == 'WARD' || $dis->addonType->code == 'WACP'}
                                {assign var="discount" value=$discount+$dis->value}
                                {assign var="tot_trans" value=$tot_trans-$dis->value}
                            {elseif $dis->addonType->code == 'GGN'}
                                {assign var="gogreen" value=$gogreen+$dis->value}
                                {assign var="tot_trans" value=$tot_trans+$dis->value}
                            {/if}
                        {/foreach}  
                        
                        {if $tax > 0}
                            <tr>
                                <td colspan="9" align="right"> GST :</td>
                                <td align="right"> + {$tax|number_format:2}</td>
                            </tr>
                        {/if}
                        
                        {if $gogreen > 0}
                            <tr>
                                <td colspan="9" align="right"> Go Green Donation :</td>
                                <td align="right"> + {$gogreen|number_format:2}</td>
                            </tr>
                        {/if}
                        
                        {if $service_charges > 0}  
                            <tr>
                                <td colspan="9" align="right"> Service Charges :</td>
                                <td align="right"> + {$service_charges|number_format:2} </td>
                            </tr>  
                        {/if} 
                        
                        {if $discount > 0} 
                            <tr>
                                <td colspan="9" align="right"> Discount :</td>
                                <td align="right"> - {$discount|number_format:2} </td>
                            </tr>
                        {/if}  
                        
                        <tr>
                            <td colspan="9" align="right"> Total :</td>
                            <td align="right"> {$tot_trans|number_format:2} </td>
                        </tr>                        


                        {if $can_charge>0}
                            <tr>
                                <td colspan="8" align="right"> Cancellation Charge </td>
                                <td align="right"> <i class="fa fa-rupee"></i> {$can_charge|number_format:2}</td>
                            </tr>
                        {/if}
                        {if $refund1>0}
                            <tr>
                                <td colspan="8" align="right"> Refund </td>
                                <td align="right"> <i class="fa fa-rupee"></i> {$refund1|number_format:2}</td>
                            </tr>
                        {/if}
                        </tbody>
                    </table>
                </div>
                <div id="can_lst"></div>
            </div>
            <input type='hidden' id='ref_txt'>   
            <div class="pull-right col-md-4 text-right" id='total_amts' >
                <b>Seat Amount</b> : <i class="fa fa-inr"></i>&nbsp;<span id="refund_total">0</span>
                <br>
                <b>GST</b> : <i class="fa fa-inr"></i>&nbsp;<span id="service_tax">0</span>  
            </div>
            <br>

            {if $action_rights['OVER-REF-AMT']>0}
                <div class="clear_fix_both"></div>
                <div class="text-right pull-right" id='refund_text'>
                    <br>
                    <div class="pull-left bold" style="padding-top: 8px">Override Refund Amount :&nbsp;</div>
                    <div class="pull-left"><input type="text" name="amount" class="form-control" id="amount" style="width: 100px" placeholder=""></div>
                </div> 
                <br>
            {/if}
            <div class="clearfix"></div>
            <div class="alert cl_blk" id="refund_success">
                <div class="text-right">
                    <b>Total Refund Amount</b> : <i class="fa fa-inr"></i>&nbsp;<span id="ref">0</span> 
                </div>                

                <div class="text-right">
                    {if $action_rights['CONFIRM-CANCEL']>0} 
                        <br>
                        <b>Cancel to my account</b> 
                        <input type="checkbox" id="cancel_flg" name="cancel_flg" class="bs_switch" data-size="small" />

                        <button class="btn btn-new btn-success hd_btn" type="button" {if $action_rights['CONFIRM-CANCEL']==1}onclick="confirmCancel('{$reports->ticketStatus->code}');"{/if}>Confirm</button> 
                    {/if}
                </div>
            </div> 
        </div>
    {/if}


    <div class="row"> 
        <div class="col-md-12 bold f14">
            Cancellation Policy
        </div>
        
    </div> 
    
    
    <table class="table" style="margin-bottom: 13px;">
        <thead>
            <tr bgcolor="#F5F5F5">
                <td><strong >Timing</strong ></td>
                <td><strong >Deduction</strong></td>
                <td><strong >Refund</strong></td>
                <td><strong >Charges</strong></td>
            </tr>
        </thead>
        <tbody>
            {foreach item=row from=$reports->cancellationTerms->policyList}    
                <tr> 
                    <td>{$row->term}</td>
                    <td>{$row->deductionAmountTxt}</td>
                    <td>{$row->refundAmountTxt}</td>
                    <td>{$row->chargesTxt}</td>
                </tr>
            {/foreach}
        </tbody>
    </table>

    {if $cancel !=1}

        <div align='right'> <br/>
            
            <button class="btn btn-success" type="button" onclick="PrintTck('{$reports->code}',1);">Print</button> &nbsp;
            <a class="btn btn-success" onclick="PrintMiniTck('{$reports->code}');">Mini Print</a> &emsp;&emsp;
            <a class="btn btn-primary" onclick="printTktWindow('{$reports->operator->code}','{$reports->code}');">PDF</a> &nbsp; 
            <a class="btn btn-primary" onclick="printTktWindow('{$reports->operator->code}','{$reports->code}','miniticket');">Mini PDF</a> &emsp;&emsp;
            {if $reports->tax!=''}
            <a class="btn btn-success" href="search/customer-gst-invoice-pdf?pnrCode={$reports->code}">GST Invoice</a> &emsp;&emsp;
            {/if}
            <button class="btn btn-default" type="button" onclick="getTicketHistory('{$reports->code}');">History</button> 
            {if $cancel!=1 && $print!=1}
                &nbsp; <a class="btn btn-default" href='#search'>Back to search</a>
            {/if}
        </div>
    {/if}



{else}
    {if $error !=''}
        <li class="er_msg" style="list-style-type:none">
            <div class="well well-large ">Errorcode : {$error->errorCode}- {$error->errorDesc}</div>
        </li>
    {else}
        <li class="er_msg" style="list-style-type:none">
            <div class="well well-large "> Invalid Code / No Details Found!</div>
        </li>
    {/if}  
{/if}


<input type="hidden" value="{$reports->code}" id="hid-ticket-code">
<input type="hidden" value="{$reports->passegerEmailId}" id="hid-ticket-emailid">
<input type="hidden" value="{$reports->passegerMobleNo}" id="hid-ticket-mobilenumber">

<div id="ticket-status-label-html" class="hide">
    {assign var=status_badge_color value=[
        'BO' =>'badge-success',
        'BL' =>'badge-primary',
        'CA' =>'badge-danger',
        'PBL' =>'badge-success',
        'PBC' =>'badge-danger',
        'TCAI' =>'badge-danger',
        'TCA' =>'badge-danger',
        'PPOH' =>'badge-info',
        'POCA'=> 'badge-danger',
        'BLCA'=> 'badge-danger'
    ]}
    <h4 class="badge {$status_badge_color[$reports->ticketStatus->code]}">
        {$ticket_status[$reports->ticketStatus->code]['name']}
    </h4>&nbsp;
    {if $reports->ticketExtra->releaseAt}
        {if $reports->ticketExtra->releaseAt|strtotime - $smarty.now <= 0}
            <span class="warning-text"> Auto cancelled at {$reports->ticketExtra->releaseAt|date_format:$ns_datetime_format}</span>
        {else}
            Will be auto cancelled at {$reports->ticketExtra->releaseAt|date_format:$ns_datetime_format} 
        {/if}
    {/if}
</div>


<div id="pnr-sendemail-dialog"  class="dialog-content-page hide">
    <form role="form" id="form1" class="form-horizontal" onsubmit="return false;">

        <div class="col-lg-12 p_l_n p_r_n">
            <div>
                <label class="req">Email</label>
                <input type="email" id="pnr-sendemail-email" class="form-control">
            </div>
        </div>
    </form>

    <div class="clear_fix_both"></div><br>

    <div class="clear_fix_both">
        <div class="alert fl suc_cre" style="display: none;" id="pnr-sendemail-action-state"></div>
        <div class="align-right cre_sve" id="pnr-sendemail-buttons">
            <button class="btn btn-success" type="button" id="pnr-sendemail" onclick="pnrSendEmail();">Send</button>
            <button class="btn btn-default" type="button" onclick="pnrCancelEmail();">Cancel</button>
        </div>
    </div>
</div>

<script>
    var printTicketDetails = {$reports|json_encode};
</script>
{literal}
    <script>
        $(document).ready(function () {
            
            $('#tkt-sms-opt-1').click();
            $('#total_amts').hide();
            if($('#hid-ticket-code').val()) {
                $('#notify-options').removeClass('hide');
                $('#ticket-status-label').html($('#ticket-status-label-html').html());
            }
            $('#pnr').focus();
            $(document).on('blur', '#amount', function () {
                var txt = $.trim($(this).val());
                if (txt != '') {
                    $('#ref').html('');
                    $('#ref').html(txt);
                }
            });

            $('input[name="pnr_user[]"]').change(function () {
                var val = [];
                var tax = [];
                if (this.checked) {
                    $('#ref_txt').val('');
                    var refund = $('#refund').val();
                    var checkcount = $(":checkbox:checked").length;

                    if (checkcount > 0) {
                        $('.btn-new').show();
                        $('#total_amts').show();
                    } else {
                        $('.btn-new').hide();
                        $('#total_amts').hide();
                    }
                    $('#refund_text').show();


                    $(':checkbox:checked').each(function (i) {

                        var test = $(this).val();
                        var value = test.split(',');
                        var fare = value[1];
                        val[i] = fare;
                        var tax_pay = value[2];
                        tax[i] = tax_pay;

                    });

                    var total = 0;
                    for (var i = 0; i < val.length; i++) {
                        total += val[i] << 0;
                    }

                    var total_tax = 0;
                    $.each(tax, function () {
                        total_tax += parseFloat(this) || 0;
                    });



                    var total_amt = total + total_tax;

                    $('#refund_total').html(total);
                    $('#service_tax').html(total_tax);
                    $('#ref').html(total_amt);
                    $('#ref_txt').val(total_amt);


                }
                else {
                    $('#ref_txt').val('');
                    var refund = $('#refund').val();
                    var checkcount = $(":checkbox:checked").length;

                    if (checkcount > 0) {
                        $('.btn-new').show();
                        $('#total_amts').show();
                    } else {
                        $('.btn-new').hide();
                        $('#total_amts').hide();
                    }
                    $('#refund_text').show();

                    $(':checkbox:checked').each(function (i) {
                        var test = $(this).val();
                        var value = test.split(',');
                        var fare = value[1];
                        val[i] = fare;
                        var tax_pay = value[2];
                        tax[i] = tax_pay;
                    });

                    var total = 0;
                    for (var i = 0; i < val.length; i++) {
                        total += val[i] << 0;
                    }

                    var total_tax = 0;
                    $.each(tax, function () {
                        total_tax += parseFloat(this) || 0;
                    });


                    var total_amt = total + total_tax;
                    $('#refund_total').html(total);
                    $('#service_tax').html(total_tax);
                    $('#ref').html(total_amt);
                    $('#ref_txt').val(total_amt);

                }
            });
        });

        function confirmCancel(type) {
            if (confirm('Do you want to cancel selected seats ?')) {

                var data = {};
                data.tickettype = type;
                data.seatcode = new Array();
                $('.pnr_user:checked').each(function () {
                    var test = $(this).val();
                    var value = test.split(',');
                    var code = value[0];

                    data.seatcode.push(code);
                });
                data.myAccountFlag = $('input[name="cancel_flg"]').is(":checked") == true ? 1 : 0;
                data.pnrcode = $('#pnr_code').val();
                
                data.amount = '';
                if ($('#amount').val() != '') {
                    data.amount = $('#amount').val();
                } /*else {
                    data.amount = $('#ref_txt').val();
                } */
                $('#refund_success').html(loading_popup);
                $('#refund_text').hide();
                $('#total_amts').hide();
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: base_url + "search/cancel-ticket-confirmation",
                    data: data,
                    success: function (res) {
                        if (res.status == 1) {
                            $('#amount').val('');
                            $('#ref_txt').val('');
                            $('#ref').html('0');
                            $('.btn-new').hide();
                            $('#refund_success').addClass('alert-success');
                            $('#refund_success').removeClass('cl_blk');
                            $('#refund_success').html('Your ticket has been cancelled successfully ');
                            //window.setTimeout(function () {
                            //$('.cn_tck').trigger('click');
                            //clearTicket();
                            //}, 4000);

                        } else {
                            $('#refund_success').addClass('alert-danger');
                            $('#refund_success').removeClass('cl_blk');
                            $('#refund_success').html(res.errorDesc);
                        }

                    }
                })
            }
        }
        
        function sendEmailDialog(type) {
            $('#pnr-sendemail-buttons').show();
            $('#pnr-sendemail-action-state').html('').hide();
            $('.inp_error').removeClass('inp_error');

            $('#pnr-sendemail-dialog').css('background', '#fff');
            $('#pnr-sendemail-dialog').removeClass('hide');
            $('#pnr-sendemail-dialog').show();
            $('#pnr-sendemail-dialog').dialog({
                autoOpen: true,
                height: 250,
                width: 500,
                modal: true,
                resizable: false
            });
            $('.ui-dialog-titlebar').hide();
            
            $('#pnr-sendemail-email').val($('#hid-ticket-emailid').val());
            $('#pnr-sendemail').attr('onclick', "sendEmail('" + type + "')");
        }
        
        function pnrCancelEmail() {
            $('#pnr-sendemail-dialog').hide();
        }
        
        function sendEmail(type) {
            var data = {};
            data.pnr = $('#hid-ticket-code').val();
            data.email = $('#toContact').val();
            data.type = type;
            
            if(!isValidEmailAddress(data.email)) {
                $('#prt-action-state').html('Please Enter valid email address').addClass('alert-danger').show();
                return false;
            }
            var eventaction = (type=='MAIL') ? 'Email Ticket': 'Email Invoice';
            ga_track_event('Ticket', eventaction, "");
            
            $('#prt-action-state').show();
            $('#prt-action-state').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "search/email-ticket",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $('#prt-action-state').addClass('alert-success').removeClass('alert-danger');
                        $('#prt-action-state').html('Email has been sent successfully');
                        setTimeout(function () {
                            $('#prt-action-state').html('');
                            $('#prt-action-state').hide();
                            pnrCancelEmail();
                        }, 3000);
                    } else {
                        $('#prt-action-state').removeClass('alert-success').addClass('alert-danger');
                        $('#prt-action-state').html(response.errorDesc);
                    }
                }
            });
        }
        
        function getDetails(val,ele){
            var mobile = $('#hid-ticket-mobilenumber').val();
            var email = $('#hid-ticket-emailid').val();
            
            if(val != "MAIL" && val != "MAILINVOICE" ){
                $('#toContact').val(mobile);
            }else{
                $('#toContact').val(email);
            }
            
            if(val == "SMSTD"){ //SMS TICKET DETAILS
                $('#tkt-sendDetails').attr('onclick', "smsTicket('SMSTD')");
            }else if(val == "RSNDGPSHJ"){ // SMS TICKET DETIALS / DRIVER CONTACT
                $('#tkt-sendDetails').attr('onclick', "smsTicket('RSNDGPSHJ')");
            }else if(val == "WATD"){ // WHATSAPP TICKET DETAILS
                $('#tkt-sendDetails').attr('onclick', "whatsAppTicket('" + $(ele).data('notify-type') + "')");
            }else if(val == "WADC"){ //WHATSAPP TICKET DETAILS / DRIVER CONTACT
                $('#tkt-sendDetails').attr('onclick', "whatsAppTicket('" + $(ele).data('notify-type') + "')");
            }else if(val == "MAIL"){ 
                $('#tkt-sendDetails').attr('onclick', "sendEmail('MAIL')");
            }else if(val == "MAILINVOICE"){ 
                $('#tkt-sendDetails').attr('onclick', "sendEmail('INVOICE')");
            }
            
            $('#action-btn-dd').text($(ele).text());
        }
        
        function whatsAppTicket(type) {
            if(!printTicketDetails) {
                return;
            }
            var data = {};
            data.type = type;
            data.pnr = printTicketDetails.code;
            data.toMobile = $.trim($('#toContact').val());
            
            if(data.toMobile == '' || !isValidPhonenumber(data.toMobile)) {
                $('#toContact').addClass('inp_error');
                $('#prt-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#prt-action-state').html('Please enter valid Mobile Number');
                $('#prt-action-state').show();
                return false;
            }
            
            $('#toContact').removeClass('inp_error');
            $('#prt-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#prt-action-state').html('');
            $('#prt-action-state').hide();

            var eventaction = (data.type === 'TICKET') ? 'Whatsapp Ticket' : 'Whatsapp Tracking';
            ga_track_event('Ticket', eventaction, '');

            var url = base_url + "ticket/whatsapp-share?" + $.param(data);
            var wo = window.open(url, "_blank");
        }
    </script>
{/literal}
    
{if $reports->relatedTicketCode!=''}
<script>
    function getrelatedPnr(code){
        $('#pnr').val(code);
        searchTicket();
    }
</script>
{/if}