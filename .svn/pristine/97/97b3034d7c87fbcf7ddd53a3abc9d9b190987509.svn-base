<!--<div class="btn-group pull-left wd_100"> <h4 class='pd_lt_10'><i class="fa fa-ticket"></i>&nbsp;&nbsp;Ticket Details</h4> </div> 
 -->
 <div class="clear_fix_both"></div>
    <div class="">
        
            <div class="row pb5">
                <div class="col-sm-4">
                    <div class="bold">PNR</div>
                    {$reports->code}
                </div>

                <div class="col-sm-4">
                    <div class="bold">Travel Date</div>
                    {date('d/m/Y g:i A',strtotime($reports->travelDate))}
                </div>

                <div class="col-sm-4">
                    <div class="bold">Route</div>
                    {$reports->fromStation->name} To {$reports->toStation->name}
                </div>
                
            </div> 
                        
            {if $reports->toStation->stationPoint[0]->name !='' && $reports->fromStation->stationPoint[0]->name !=''}            
            <div class="row pb5">
                <div class="col-sm-6">
                    <div class="bold">Boarding Info</div>
                    {if $reports->fromStation->stationPoint[0]->name !=''}
                        {$reports->fromStation->stationPoint[0]->name} ( {$reports->fromStation->stationPoint[0]->dateTime|date_format:$ns_time_format} ), 
                        {$reports->fromStation->stationPoint[0]->number}
                    {else}-{/if}
                </div>
                <div class="col-sm-6 p_l_n">
                    <div class="bold">Bus</div>
                    {formatBusCategory cate_code=$reports->bus->categoryCode} 
                </div>
            </div>    
            {/if}
            

            <div class="row pb5">
                <div class="col-sm-3">
                    <div class="bold">Passenger Mobile</div>
                    {$reports->passegerMobleNo}
                </div>

                <div class="col-sm-3">
                    <div class="bold">Booked By</div>
                    {$reports->user->name}
                </div>

                <div class="col-sm-3 col-md-3 p_l_n p_r_n">
                    <div class="bold">Booked At</div>
                    {date('d/m/Y g:i A',strtotime($reports->transactionDate))}
                </div>
                
                {if $phone==1 && $reports->ticketExtra->releaseAt}
                <div class="col-sm-3 col-md-3 p_l_n p_r_n">
                    <div class="bold">Release At</div>
                    {date('d/m/Y g:i A',strtotime($reports->ticketExtra->releaseAt))}
                </div>    
                {/if} 

            </div>

            {if $reports->bookingCode!='' && $reports->code != $reports->bookingCode}
                
                <div class="row pb5">
                    <div class="col-sm-12">
                       <div class="bold">Transaction Id</div>
                        {$reports->bookingCode}
                    </div>
                </div>    
            {/if} 
            
            {if $reports->remarks!=""}            
            <div class="row pb5">
                <div class="col-sm-12">
                    <span class="bold">Remarks : </span> {$reports->remarks}
                </div>
            </div>   
            {/if}
            
            
            {if $phone==1}
                
                <div class="row">
                    <div class="col-sm-12">
                        <div class="text-center alert alert-info"> Not paid ticket </div>
                    </div>
                </div>
            {/if}    
            
        
            </div>
        {if $cancel==1 && $phone!=1}
            <br>
        {/if}
                
 <!--<div class="btn-group pull-left wd_100"> <h4 class='pd_lt_10'><span class="fa fa-user"></span>&nbsp;&nbsp;Passanger Details</h4> </div> 
   --> <div class="clear_fix_both"></div>
    <div class="">
        <div class="table-responsive">
            <table id="dt_report_table" class="table" style='border:1px solid #dddddd'>
                <thead>
                    <tr bgcolor="#F5F5F5">
                        <th style='border:1px solid #dddddd'>Passenger Name</th>
                        <th style='border:1px solid #dddddd;text-align:center '>Seat No.</th>
                        <th style='border:1px solid #dddddd;text-align:center '>Gender</th>
                        <th style='border:1px solid #dddddd;text-align:center '>Age</th>
                        <th style='border:1px solid #dddddd;text-align:center '>Status</th>
                        <th style='border:1px solid #dddddd;text-align:center '>Fare</th>
                        {if $cancel==1} 
                        <th style='border:1px solid #dddddd;text-align:center '>Refund</th>
                        {/if}
                        {if $cancel==1} 
                        <th style='border:1px solid #dddddd;text-align:center '>Cans. Charge</th>
                        {/if}
                        {if $cancel==1 || $phone==1}
                        <th style='border:1px solid #dddddd;text-align:center '>
                            <input type="checkbox"  class='pnr_user_list_all' id="pnr_user_list_all" title="Select all" onchange="togglePNRlist(this);">
                            Select
                        </th>{/if}
                       
                    </tr>
                </thead>
                <tbody class="body_table">
                    {assign var="tot_fare" value=0}
                    {assign var="tax" value=0}
                    {assign var="can_charge" value=0}
                    {assign var="refund" value=0}
                    
                    {foreach item=row from=$reports->ticketDetails}
                        <tr id='seat-{$row->seatCode}' {if $row->seatStatus->code=="CA" || $row->seatStatus->code=="PCA" || $row->seatStatus->code=="PBC"} class="cancelled-seat" {/if} data-seat="{$row->seatStatus->code}" data-ticket="{$reports->ticketStatus->code}">                            
                            <td style='border:1px solid #dddddd'>{$row->passengerName}</td>
                            <td style='border:1px solid #dddddd'>{$row->seatName}</td>
                            <td style='border:1px solid #dddddd'>{if $row->passengerGendar=='M'}Male{else}Female{/if}</td>
                            <td style='border:1px solid #dddddd'>{$row->passengerAge}</td>
                            <td style='border:1px solid #dddddd'>{$row->seatStatus->code}</td>
                            <td style='border:1px solid #dddddd' align="right">{$row->seatFare|number_format:2}</td>
                            {if $cancel==1} 
                                <td style='border:1px solid #dddddd' align="right">{$row->refundAmount|number_format:2}</td>
                            {/if}
                            {if $cancel==1} 
                                <td style='border:1px solid #dddddd' align="right">{$row->cancellationCharges|number_format:2}</td>
                            {/if}
                            
                            {if $cancel==1 || $phone==1}
                            <td align="center" style='border:1px solid #dddddd'>
                            {if $row->seatStatus->code =='CA'}
                                -
                            {else if $cancel==1 && $row->seatStatus->code =='CAL' && ( $reports->ticketStatus->code=="BO" || $reports->ticketStatus->code=="PBL") }
                                <input type="checkbox" class='pnr_user_list' id="pnr_user_list" name="pnr_user_list" value="{$row->seatCode}">
                            {else if $phone==1 && $row->seatStatus->code =='PBL'} 
                                <input type="checkbox" class='pnr_user_list' id="pnr_user_list" name="pnr_user_list" value="{$row->seatCode}">
                            {else if $phone==1 && $row->seatStatus->code =='PBC'} 
                                <input type="checkbox" disabled class='pnr_user_list' id="pnr_user_list" name="pnr_user_list" value="{$row->seatCode}">
                            {else if $action_rights['CONFIRM-CANCEL']>0} 
                                <input type="checkbox"  class='pnr_user_list' id="pnr_user_list" name="pnr_user_list" value="{$row->seatCode}">
                            {else if $cancel==1 && $row->seatStatus->code !='CAL'} 
                                -
                            {/if}
                            </td>
                            {/if}
                            <input type="hidden" value="{$row->refundAmount}" id="refund">
                    </tr>
                    {if $row->seatStatus->code=="CA"}
                        {assign var="can_charge" value=$can_charge+$row->cancellationCharges}
                        {assign var="refund" value=$refund+$row->refundAmount+$row->serviceTax}
                    {/if}
                    
                    {if $row->seatStatus->code!="PBC"}
                        {assign var="tot_fare" value=$tot_fare+$row->seatFare+$row->serviceTax}
                        {assign var="tax" value=$tax+$row->serviceTax}
                    {/if}
                {/foreach}
                
                {assign var="discount" value=0}
                {assign var="gogreen" value=0}
                {assign var="service_charges" value=0}

                {foreach item=dis from=$reports->ticketAddonsDetails}                    
                    {if $dis->addonType->code=="AGSC"}
                        {assign var="service_charges" value=$service_charges+$dis->value}
                        {assign var="tot_fare" value=$tot_fare+$dis->value}
                    {elseif $dis->addonType->code=="SHDS" || $dis->addonType->code=="DSAMT" || $dis->addonType->code=="COUP" || $dis->addonType->code=="OFDS" } 
                        {assign var="discount" value=$discount+$dis->value}
                        {assign var="tot_fare" value=$tot_fare-$dis->value}
                    {elseif $dis->addonType->code == 'WARD' || $dis->addonType->code == 'WACP'}
                        {assign var="discount" value=$discount+$dis->value}
                        {assign var="tot_fare" value=$tot_fare-$dis->value}
                    {elseif $dis->addonType->code == 'GGN'}
                        {assign var="gogreen" value=$gogreen+$dis->value}
                        {assign var="tot_fare" value=$tot_fare+$dis->value}    
                    {/if}
                {/foreach}  
                
                    {if $discount > 0}  
                        <tr>
                            <td colspan="{if $cancel==1}8{else if $phone==1}6{else}5{/if}" align="right"> Discount :</td>
                            <td align="right"> - {$discount|number_format:2} </td>
                        </tr>  
                    {/if} 
                    
                    {if $tax > 0}
                        <tr>
                            <td colspan="{if $cancel==1}8{else if $phone==1}6{else}5{/if}" align="right"> GST :</td>
                            <td align="right"> + {$tax|number_format:2}</td>
                        </tr>
                    {/if}
                    
                    {if $gogreen > 0}
                        <tr>
                            <td colspan="{if $cancel==1}8{else if $phone==1}6{else}5{/if}" align="right"> Go Green Donation :</td>
                            <td align="right"> + {$gogreen|number_format:2}</td>
                        </tr>
                    {/if}
                    
                    {if $service_charges > 0}  
                        <tr>
                            <td colspan="{if $cancel==1}8{else if $phone==1}6{else}5{/if}" align="right"> Service Charges :</td>
                            <td align="right"> + {$service_charges|number_format:2} </td>
                        </tr>  
                    {/if} 
                                        
                    <tr>
                        <td colspan="{if $cancel==1}8{else if $phone==1}6{else}5{/if}" align="right"> Total :</td>
                        <td align="right"> {$tot_fare|number_format:2} </td>
                    </tr>
                    
                    
                    {if ($can_charge>0 || $refund>0 )&&$cancel!=1} 
                        <tr>
                            <td colspan="9" align="right" class="bold"> Cancellation</td>                            
                        </tr>
                    {/if}    
                    {if $can_charge>0&&$cancel!=1}
                        <tr>
                            <td colspan="{if $cancel==1}8{else}5{/if}" align="right"> Cancellation Charge :</td>
                            <td align="right"> {$can_charge|number_format:2}</td>
                        </tr>
                    {/if}
                    {if $refund>0&&$cancel!=1}
                        <tr>
                            <td colspan="{if $cancel==1}8{else}5{/if}" align="right"> Refund :</td>
                            <td align="right"> {$refund|number_format:2}</td>
                        </tr>
                    {/if}
                    
                </tbody>
            </table>
        </div>
        <div id="can_lst"></div>
  

    {if $cancel!=1 && $phone!=1} 
        <input type="hidden" value="{$code}" id="pnr_code">
        <div class="row">
            <div class="col-md-2">
                <button class="btn btn-danger btn-clear-ticket" type="button">Clear</button>
            </div>
            <div class="col-md-10 text-right">
                <button class="btn btn-success" type="button" onclick="PrintTck('{$reports->code}',1);">Print</button>&nbsp;&nbsp;
                <a class="btn btn-primary" onclick="printTktWindow('{$reports->operator->code}','{$reports->code}');">PDF</a>&nbsp;&nbsp;
                <a class="btn btn-primary" onclick="printTktWindow('{$reports->operator->code}','{$reports->code}','miniticket');">Mini PDF</a> &nbsp;&nbsp;
                <button class="btn btn-default" type="button" onclick="getTicketHistory('{$reports->code}');">History</button>
            </div>
        </div>
    {/if}
                
    {if $cancel==1 && $phone!=1}
        <input type='hidden' id='refe_txt'>   
        <input type="hidden" value="{$code}" id="pnr_code">
        {if $action_rights['OVER-REF-AMT']>0}
            <div class="input-group col-xs-8 pull-right" id='refund_text'>
                <label style="margin-right:7px;margin-top:9px;" class="pull-right">Override Refund Amount : </label>
                <span class="input-group-addon"><i class="fa fa-inr"></i></span>
                <input type="text" name="amount-ovr" class="form-control" id="amount-ovr"  placeholder="">
            </div> 
        {/if}
        <div class="clear_fix_both"></div>
        <div class="refunds text-right" id="rfu_amt">
            <b>Total Refund Amount</b> : <i class="fa fa-inr"></i>&nbsp;
            <span id="ref_amt">0</span> <br> <br> 
            
            <b>Cancel to my account</b> 
            <input type="checkbox" id="cancel_bm_flg" name="cancel_bm_flg" class="bs_switch" data-size="small" />
           
            {if $action_rights['CONFIRM-CANCEL']>0} 
                <button class="btn btn-refund btn-success hd_btn" type="button" {if $action_rights['CONFIRM-CANCEL']==1}onclick="confirmCancel();"{/if}>Confirm Cancel</button> 
            {/if} 
        </div> 
    </div>
      
    <div class="clear_fix_both"></div>
    <div align="center">
        <button class="btn btn-default clear-ticket" type="button">Clear</button>
    </div>        
    {/if} 
    {if $cancel!=1 && $phone==1} 
     
        
            <div class="row"> 
                <div class="col-lg-3 col-md-3">
                    {if $action_rights['OFFLINE-PAY-MODE']==1}
                    <label>Payment Mode</label>        
                    <select class="form-control wid-p-100" id="offlinepaytype">
                        <option value="CASH">Cash</option> 
                        <option value="CCD">Card</option>
                    </select>
                    {/if}
                </div> 
                <div class="col-lg-3 col-md-3">
                    <label>Cash Collected by Me</label>
                    <div class="col-lg-9 col-md-9 p_l_n">
                        {if $action_rights['PHB-BOOK-FLAG']==1}
                        <select id="bk_flg" name="bk_flg" class="form-control">
                            <option value="" selected="">Select</option>
                            <option value="true">Yes</option>
                            <option value="false">No</option>
                        </select>
                        {else}
                        <select id="bk_flg" name="bk_flg" class="form-control" disabled="disabled">
                            <option value="true">Yes</option>
                        </select>
                        {/if}
                    </div>
                </div>                    
                <div class="col-lg-6 col-md-6 p_l_n">
                    <label>Remarks</label>
                    <textarea id="pbl-cnf-remarks" class="form-control" rows="2" cols="10">{$reports->remarks}</textarea>
                </div>
            </div>            
            <div class="clear_fix_both"></div><br />
            <div class="align-right alert alert-danger" style="display:none" id="phone_bkg_action_state"></div>
            <div class="align-center alert alert-danger" style="display:none;" id="notify-action-state"></div>
            <div class="clear_fix_both"></div><br/>
        
        <div class="col-md-2 p_l_n">
            <button class="btn btn-phb-crl btn-danger" type="button">Clear</button> 
        </div>
        <div class="col-md-10 p_r_n" align="right">
            <div class="dropdown dropup d-inline-block">
                <button class="btn btn-default dropdown-toggle" type="button" id="s-selection" data-toggle="dropdown">
                    Notify
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu dropdown-menu-right text-left" aria-labelledby="s-selection">                
                    <li class="dropdown-header"><b><i class="fa fa-large fa-mobile" aria-hidden="true"></i>&emsp;SMS</b></li>
                    <li><a href="javascript:;" class="btn-pb-notify-tkt" data-notify-type="RSNDGPSHJ">Driver Contact / GPS Tracking</a></li>
                    <li class="divider" role="seperator"></li>
                    <li class="dropdown-header"><b><i class="fa fa-lg fa-whatsapp" aria-hidden="true"></i>&emsp;WhatsApp</b></li>
                    <li><a href="javascript:;" class="btn-pb-notify-whatsapp" data-notify-type="TICKET">Ticket Details</a></li>
                    <li><a href="javascript:;" class="btn-pb-notify-whatsapp" data-notify-type="RSNDGPSHJ">Driver Contact / GPS Tracking</a></li>
                </ul>
            </div>
            {if $action_rights['CHNG-TRVL-STATUS']==1}
            <div class="dropdown dropup d-inline-block">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Travel Status <span class="caret"></span>
                </button>
                <ul class="dropdown-menu text-left">
                    <li><a href="javascript:;" class="btn-traveled">Travelled</a></li>
                    <li><a href="javascript:;" class="btn-not-traveled">Not Travelled</a></li>
                </ul>
            </div>
            {/if}
            
            {if $action_rights['PHB-CANCEL']>0} 
                <button class="btn btn-phb-cnl btn-danger" type="button" {if $action_rights['PHB-CANCEL']==1}onclick="confirmPhoneBooking();"{/if}>Cancel</button> 
            {/if}
            {if $action_rights['SCH-TRIP-SEAT-TRANSFER']==1}
                <button class="btn btn-primary btn-transfer" type="button">Transfer</button>
            {/if}
            {if $action_rights['PHB-CONFIRM']>0 } 
                <button class="btn btn-phb-cfm btn-success" type="button" {if $action_rights['PHB-CONFIRM']==1}onclick="phoneBookingConfirm();"{/if}>Pay & Confirm</button> 
            {/if}
       </div>
       
        <input type="hidden" value="{$code}" id="pnr_code">
    {/if}
        </div>
        <form id='ticket_print' name="ticket_print" method="get" action="search/confimation-payment" onsubmit="return false">
        <input type="hidden" name="pnr" class="form-control sdate" id="pnr"  value='{$reports->code}'>
        <input type="hidden" id="export" name="export" value="" />
        
    </form>
<iframe name="ifrm_downloader_ticket" id="ifrm_downloader_ticket" style='display:none'></iframe>