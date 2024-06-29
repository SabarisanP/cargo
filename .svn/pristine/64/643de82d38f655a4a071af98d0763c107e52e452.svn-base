{if $error ==''}
    <div id="main_wrapper">
        <br/>   
        <div class="clear_fix_both"></div> 
        <div class=" pd_bt_45">

            <div class="col-xs-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="col-md-5" style="font-size:13px">PNR No </label>
                    <label class="col-md-9" style="font-weight:lighter;font-size:13px">{$reports->code}</label>
                </div>
            </div>

            <div class="col-xs-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="col-md-5" style="font-size:13px">Travel Date</label>
                    <label class="col-md-9" style="font-weight:lighter;font-size:13px">{date('d/m/Y g:i A',strtotime($reports->travelDate))}</label>
                </div>
            </div>   
            <div class="clear_fix_both"></div>


            <div class="col-xs-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="col-md-5" style="font-size:13px">Route</label>
                    <label class="col-md-9" style="font-weight:lighter;font-size:13px">{$reports->fromStation->name} To {$reports->toStation->name}</label>
                </div>
            </div>
            <div class="col-xs-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="col-md-5" style="font-size:13px">Bus Type</label>
                    <label class="col-md-12" style="font-weight:lighter;font-size:13px"> {formatBusCategory cate_code=$reports->bus->categoryCode} </label>
                </div>
            </div>
            <div class="clear_fix_both"></div>
            <div class="col-xs-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="col-md-5">Mobile</label>
                    <label class="col-md-9" style="font-weight:lighter"><span id="mob_upd">{$reports->passegerMobleNo}</span></label>                   
                </div>
            </div><div class="col-md-2"></div>
            <div class="col-xs-6 p_l_n">
                <div >
                    <label for="txt_m_name" class="col-md-5" >Booked At</label>
                    <label class="col-md-9" style="font-weight:lighter">{date('d/m/Y g:i A',strtotime($reports->transactionDate))}</label>                   
                </div>
            </div>
            {if $reports->remarks != ""}
            <div class="clear_fix_both"></div>
            <div class="col-xs-12 p_l_n">
                <div >
                    <label for="txt_m_name" class="col-md-12" >Remarks</label>
                    <label class="col-md-12" style="font-weight:lighter">{$reports->remarks}</label>
                </div>
            </div>
            {/if}
        </div>

        <div class="clear_fix_both"></div>
        <div >
            <div class="table-responsive">
                <table id="dt_report_table" class="table">
                    <thead>
                        <tr bgcolor="#F5F5F5">

                            <th  style='border:1px solid #dddddd'>Passenger Name</th>
                            <th  style='border:1px solid #dddddd;text-align:center '>Seat No</th>
                            <th  style='border:1px solid #dddddd;text-align:center '>Gender</th>
                            <th  style='border:1px solid #dddddd;text-align:center '>Age</th>                       
                            <th style='border:1px solid #dddddd;text-align:center '>Status</th>
                            <th style='border:1px solid #dddddd;text-align:center '>Fare</th>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {foreach item=row from=$reports->ticketDetails}
                            <tr id='seat-{$row->seatCode}' {if $row->seatStatus->code == 'CA' || $row->seatStatus->code == 'PCA'} class="cancelled-seat" {/if}>
                                <td style='border:1px solid #dddddd'><span id="new_name">{$row->passengerName} </span></td>
                                <td style='border:1px solid #dddddd' align="center">{$row->seatName}</td>
                                <td style='border:1px solid #dddddd' align="center"><span id="new_gender">{if $row->passengerGendar=='M'}Male{else}Female{/if}</span></td>
                                <td style='border:1px solid #dddddd' align="center"><span id="new_age">{$row->passengerAge}</span></td>                            
                                <td style='border:1px solid #dddddd' align="center">{$row->seatStatus->name}</td>
                                <td style='border:1px solid #dddddd;' align="right"><i class="fa fa-inr"></i>&nbsp;{$row->seatFare|number_format:2:".":","}</td>
                        <input type="hidden" value="{$row->refundAmount}" id="refund">
                        <input type="hidden" value="{$code}" id="pnr_code">
                        </tr>
                    {/foreach}

                    {assign var="tot_trans" value=0}
                    {assign var="tax" value=0}
                    {assign var="can_charge" value=0}
                    {assign var="refund" value=0}
                    {foreach item=trans from=$reports->ticketTransaction} 
                        {if $trans->transactionType->code=="TICKBO"}    <!-- Booked -->
                            {assign var="tot_trans" value=$tot_trans+$trans->transactionAmount}
                            {assign var="tax" value=$tax+$trans->serviceTax}
                        {else} <!-- cencelled -->
                            {assign var="can_charge" value=$can_charge+$trans->cancellationChargeAmount}
                            {assign var="refund" value=$refund+$trans->refundAmount}
                        {/if}
                    {/foreach}    
                    {if $tax > 0}
                        <tr>
                            <td colspan="5" align="right"> GST </td>
                            <td align="right"> <i class="fa fa-rupee"></i> {$tax|number_format:2}</td>
                        </tr>
                    {/if}     
                    <tr>
                        <td colspan="5" align="right"> Total </td>
                        <td align="right"> <i class="fa fa-rupee"></i>{$reports->totalFare|number_format:2} </td>
                    </tr>


                    {if $can_charge>0}
                        <tr>
                            <td colspan="5" align="right"> Cancellation Charge </td>
                            <td align="right"> <i class="fa fa-rupee"></i> {$can_charge|number_format:2}</td>
                        </tr>
                    {/if}
                    {if $refund>0}
                        <tr>
                            <td colspan="5" align="right"> Refund </td>
                            <td align="right"> <i class="fa fa-rupee"></i> {$refund|number_format:2}</td>
                        </tr>
                    {/if}

                    </tbody>
                </table>
            </div>
        </div>
    </div>
{else}
    <li class="er_msg" style="list-style-type:none">
        <div class="well well-large ">{$error}</div>
    </li>
    <span style="float:right"><button class="btn btn-default" type="button" onclick="ClosePopover();">Close</button></span>
{/if}