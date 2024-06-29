<div class="bold"> Confirm / Cancel Phone booking</div> 
<br>
<div class="clear_fix_both"></div>
<div class="">
    <div class="col-md-6 p_l_n">
        <div class="row">
            <label for="txt_m_name" class="col-xs-4">PNR </label>
            <label class="col-xs-8" style="font-weight:lighter">{$reports->code}</label>
        </div>
    </div>
    <div class="col-xs-6 p_l_n">
        <div class="row">
            <label for="txt_m_name" class="col-xs-4">Route</label>
            <label class="col-xs-8" style="font-weight:lighter">{$reports->fromStation->name} - {$reports->toStation->name}</label>
        </div>
    </div>
    <div class="clear_fix_both"></div>
 
    <div class="col-xs-6 p_l_n">
        <div class="row">
            <label for="txt_m_name" class="col-xs-4">Bus Type</label>
            <label class="col-xs-8" style="font-weight:lighter">{formatBusCategory cate_code=$reports->bus->categoryCode}</label>
        </div>
    </div>

    <div class="col-xs-6 p_l_n">
        <div class="row">
            <label for="txt_m_name" class="col-xs-4">Date and Time</label>
            <label class="col-xs-8" style="font-weight:lighter">{$reports->travelDate|date_format:$ns_datetime_format}</label>
        </div>
    </div>

    <div class="clear_fix_both"></div>
    
    <div class="col-xs-6 p_l_n">
        <div class="row">
            <label for="txt_m_name" class="col-xs-4">Boarding Point</label>
            <label class="col-xs-8" style="font-weight:lighter">{$reports->fromStation->stationPoint[0]->name} ,&nbsp;{$reports->fromStation->stationPoint[0]->dateTime|date_format:$ns_time_format}</label>
        </div>
    </div>
    <div class="col-xs-6 p_l_n">
        <div class="row">
            <label for="txt_m_name" class="col-xs-4">Fare</label>
            <label class="col-xs-8" style="font-weight:lighter"><i class="fa fa-inr"></i>&nbsp;{$reports->totalFare}</label>
        </div>
    </div>

    <div class="clear_fix_both"></div>

    <div class="col-xs-6 p_l_n">
        <div class="row">
            <label for="txt_m_name" class="col-xs-4">Boarding Info</label>
            <label class="col-xs-8" style="font-weight:lighter">{$reports->fromStation->stationPoint[0]->name}</label>
        </div>
    </div>

</div>
 
<div class="clear_fix_both"></div>
<br>
<div class="">
    <div class="table-responsive">
        <table id="dt_report_table" class="table table-striped">
            <thead>
                <tr>                    
                    <th>Name</th>
                    <th>Seat No.</th>
                    <th>Gender</th>
                    <th>Age</th>
                    <th>Status</th>
                    <th>Fare</th>
                    <th>Select</th>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var="tot_fare" value=0}
                {assign var="tax" value=0}
                {foreach item=row from=$reports->ticketDetails}
                    <tr id='seat-{$row->seatCode}' {if $row->seatStatus->code =='PCA'} class="cancelled-seat" {/if}>                                                
                        <td style='width:100px'>{$row->passengerName}</td>
                        <td style='width:100px'>{$row->seatName}</td>
                        <td style='width:50px'>{if $row->passengerGendar=='M'}Male{else}Female{/if}</td>
                        <td style='width:50px'>{$row->passengerAge}</td>
                        <td style='width:50px'>{$row->seatStatus->code}</td>
                        <td style='width:50px'><i class="fa fa-inr"></i>&nbsp;{$row->seatFare}</td>
                        <td style='width:4px'>
                            {if $row->seatStatus->code !='PBC'}
                            <input type="checkbox" class='pnr_user_list' id="pnr_user_list" name="pnr_user_list" value="{$row->seatCode}">
                            {/if}
                        </td>     
                    </tr>
                    {assign var="tot_fare" value=$tot_fare+$row->seatFare+$row->serviceTax}
                    {assign var="tax" value=$tax+$row->serviceTax}
                {/foreach}

                {assign var="discount" value=0}
                {assign var="service_charges" value=0}

                {foreach item=dis from=$reports->ticketAddonsDetails}
                    {if $dis->addonType->code=="AGSC"}
                        {assign var="service_charges" value=$service_charges+$dis->value}
                        {assign var="tot_fare" value=$tot_fare+$dis->value}
                    {elseif $dis->addonType->code=="SHDS" || $dis->addonType->code=="DSAMT" || $dis->addonType->code=="COUP"} 
                        {assign var="discount" value=$discount+$dis->value}
                        {assign var="tot_fare" value=$tot_fare-$dis->value}
                    {/if}
                {/foreach}  
                
                {if $tax > 0}
                    <tr>
                        <td colspan='30' align="right"> GST : + {$tax|number_format:2}</td>
                    </tr>
                {/if}

                {if $service_charges > 0}  
                    <tr>
                        <td colspan='30' align="right"> Service Charges : + {$service_charges|number_format:2} </td>
                    </tr>  
                {/if} 

                {if $discount > 0}  
                    <tr>
                        <td colspan='30' align="right"> Discount : - {$discount|number_format:2} </td>
                    </tr>  
                {/if}                    
                
                <tr>
                    <td colspan='30' align="right">
                        <div ><b>Total</b> : {$tot_fare|number_format:2}</div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>   

    
        <div class="col-lg-12">
            <div class="col-lg-3 col-md-3">
                {if $action_rights['OFFLINE-PAY-MODE']==1}
                    <label>Payment Mode</label>        
                    <select class="form-control wid-p-100" id="offlinepaytype">
                        <option value="CASH">Cash</option> 
                        <option value="CCD">Card</option>
                    </select>
                {/if}
            </div>
                
            <div class="col-lg-3 col-md-3 p_l_n">
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
            <div class="row">                
                <div class="col-lg-6 col-md-6 p_l_n">
                    <label>Remarks</label>
                    <textarea id="pbl-cnf-remarks" class="form-control" rows="2" cols="10">{$reports->remarks}</textarea>
                </div>
            </div> 
        </div>
        <div class="clear_fix_both"></div><br />
        <div class="align-right alert alert-danger" style="display:none" id="phone_bkg_action_state"></div>
        <div class="clear_fix_both"></div><br/>
    

    <div align="right">
        <button class="btn btn-phb-crl btn-default" type="button" onclick="closePhoneBookDialog()">Close</button> &nbsp;&nbsp;
        {if $action_rights['PHB-CANCEL']>0} 
            <button class="btn btn-phb-cnl btn-danger" type="button" {if $action_rights['PHB-CANCEL']==1}onclick="phoneBookCancel('{$reports->code}');"{/if}>Cancel Ticket</button> 
        {/if}
        {if $action_rights['PHB-CONFIRM']>0 } 
            <button class="btn btn-phb-cfm btn-success" type="button" {if $action_rights['PHB-CONFIRM']==1}onclick="phoneBookConfirm('{$reports->code}');"{/if}>Confirm Ticket</button> 
        {/if}
    </div>

</div>

