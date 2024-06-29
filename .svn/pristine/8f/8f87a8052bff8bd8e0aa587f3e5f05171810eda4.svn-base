<table class="" width="95%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">{iflang('Cargo Delivery Report')}</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span> 
            {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table> 

<h5><b>Summary</b></h5>
<table class="table table-bordered" style="width:30%;">
    <tr>
        <td class="bold" >Freight (A)</td>
        <td class="text-right">{$amounts['freight']|inr_format}</td>

        <td class="bold" >Paid</td>
        <td class="text-right">{$amounts['paid']|inr_format}</td>
    </tr>
    <tr>
        <td class="bold" >Handling Charges (B)</td>
        <td class="text-right">{$amounts['handling']|inr_format}</td>

        <td class="bold" >To Pay</td>
        <td class="text-right">{$amounts['topay']|inr_format}</td>
    </tr>
    <tr>
        <td class="bold" >Unloading Charges (C)</td>
        <td class="text-right">{$amounts['unloading']|inr_format}</td>

        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold" >GST (D)</td>
        <td class="text-right">{$amounts['gst']|inr_format}</td>

        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold" >Pickup Charges (E)</td>
        <td class="text-right">{$amounts['pickup']|inr_format}</td>

        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold" >Delivery Charges (F)</td>
        <td class="text-right">{$amounts['delivery']|inr_format}</td>

        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold">Connecting Charges (G)</td>
        <td class="text-right">{$amounts['connecting']|inr_format}</td>

        <td class="bold">&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold" >{lang('other_charges')} (H)</td>
        <td class="text-right">{$amounts['service_charge']|inr_format}</td>

        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold">Net Amount (A+B+C+D+E+F+G+H)</td>                                                                                           
        <td class="bold text-right">
            {$amounts['netpayable']|inr_format}
        </td>

        <td class="bold" >&nbsp;</td>
        <td class="text-right"></td>
    </tr>
</table>    
<h5><b>Transactions</b></h5>

<div class="overflow-x-auto">
    <table id="dt_adv_booking_report_table" class="table table-bordered " >
        <thead>
            <tr class="success">        
                <td align="center">Booked Date</td>
                <td align="center">{lang('cargo_code_term')}</td>
                <td align="center">Ogpl No.</td>
                <td align="center">Type Of Packaging</td>
                <td align="center">Type Of Booking</td>
                <td align="center">{lang('booking_from_term')}</td>
                <td align="center">Delivery User</td>
                <td align="center">{lang('booking_to_label')}</td>
                <td align="center">{lang('booking_sender_term')}</td>
                <td align="center">{lang('booking_sender_term')} Contact Number</td>
                <td align="center">{lang('booking_receiver_term')}</td>
                <td align="center">{lang('booking_receiver_term')} Contact Number</td>
                <td align="center">Type Of Delivery</td>
                <td align="center">Payment Status</td>
                <td align="center">Cargo Status</td>
                <td align="center">Date Of Delivery</td>
                <td align="center">Delivered Using</td>
                <td align="center">No. Of Articles</td>
                <td align="center">Qty</td>
                <td align="center">Freight Amount</td>
                <td align="center">{lang('other_charges')} </td>
                <td align="center">Net Payable</td>
                <td align="center">Paid</td>
                <td align="center">To Pay</td>
            </tr>

        </thead>
        <tbody class="body_table" >

            {assign var=tot_lr_count value=0}
            {assign var=tot_item_count value=0}
            {assign var=tot_fare value=0}
            {assign var=tot_handling value=0}
            {assign var=tot_payable value=0}
            {assign var=tot_paid value=0}
            {assign var=tot_topay value=0}
            {assign var=tot_items value=0}
            {assign var=tot_commission value=0}

            {foreach item=row from=$result key=t}
                {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                    <tr>
                        <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                        <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a>{if $namespace =='cargodemo'||$namespace =='rmtcargo'||$namespace =='ktwoklogistics' } <br>PNO: {$row->private_mark_number}{/if}</td>
                        <td align="center" nowrap>{$row->transit_alias_code}</td>
                        <td align="center">{$row->cargo_item_name}</td>
                        <td align="center">{$delivery_type_codes[$row->pickup_type_code]}</td>
                        <td align="left">{$row->from_organization_name}</td>
                        <td align="left">{$row->user_first_name}</td>
                        <td align="left">{$row->to_organization_name}</td>
                        <td align="left">{$row->from_customer_name}</td>
                        <td align="left">{$row->from_customer_mobile|mask_mobileno}</td>
                        <td align="left">{$row->to_customer_name}</td>
                        <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                        <td align="center">{$delivery_type_codes[$row->delivery_type_code]}</td>
                        <td align="center" id='pay_state_{$row->cargo_code}'>
                            {if $namespace == "arthitravels" && $row->payment_status_code == 'TPPAD'}
                                {'TOP'|_cargo_payment_status_badge}
                            {else}
                                {$row->payment_status_code|_cargo_payment_status_badge}
                            {/if}
                        </td>
                        <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                        <td align="left" nowrap>
                            {if $row->delivered_at}
                                {$row->delivered_at|date_format:$ns_datetime_format}
                            {else}
                                -
                            {/if}
                        </td>
                        <td align="center" nowrap>
                            {if isNotNull($row->delivery_model)}
                                {assign var="delivery_model" value=explode(',', $row->delivery_model)}

                                {if in_array('OTP', $delivery_model)}
                                    <span class="label label-default" title="Delivery OTP Verified">OTP</span>
                                {/if}
                                {if in_array('POD', $delivery_model)}
                                    <span class="label label-default" title="POD Verified">POD</span>
                                {/if}
                            {else}
                                -
                            {/if}
                        </td>
                        <td align="right">{$row->item_count}</td>
                        <td align="right">{$row->total_item_count}</td>

                        {*  <td align="right">{$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax}</td>*}
                        <td align="right">
                            {$row->total_amount|inr_format}
                        </td>
                        <td align="right" nowrap>
                            {($row->service_charge + $row->other_charges_amount + $row->connecting_charge)|inr_format}

                            <i class="fa fa-info-circle" data-toggle="popover" data-content='
                           <table>
                           {if $row->other_charges_amount != 0}
                               {foreach key=ck item=cv from=_parse_other_charges($row->other_charges)}
                                   {if $cv == 0}
                                       {continue}
                                   {/if}
                                   <tr>
                                   <td>{$ck|_snakecase_to_titlecase}</td>
                                   <td>&ensp;:&ensp;</td>
                                   <td align="right"><i class="fa fa-rupee"></i> {$cv|inr_format}</td>
                                   </tr>
                               {/foreach}
                           {/if}
                           {if $row->service_charge > 0}
                           <tr>
                               <td>{lang('other_charges')}</td>
                               <td>&ensp;:&ensp;</td>
                               <td align="right"><i class="fa fa-rupee"></i> {$row->service_charge|inr_format}</td>
                           </tr>
                           {/if}
                           '></i>
                        </td>
                        <td align="right" nowrap>
                            {($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)|inr_format}
                            <i class="fa fa-info-circle" data-toggle="popover" data-content='
                            <table>
                            <tr>
                            <td>Net Payable</td>
                            <td>&ensp;:&ensp;</td>
                            <td align="right"><i class="fa fa-rupee"></i> {$row->total_amount|inr_format}</td>
                            </tr>
                            {if $row->total_handling_amount > 0}
                            <tr>
                                <td>Handling Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> {$row->total_handling_amount|inr_format}</td>
                            </tr>
                            {/if}
                            {if $row->service_tax > 0}
                            <tr>
                                <td>GST</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> {$row->service_tax|inr_format}</td>
                            </tr>
                            {/if}
                            {if $row->service_charge > 0}
                            <tr>
                                <td>{lang('other_charges')}</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> {$row->service_charge|inr_format}</td>
                            </tr>
                            {/if}
                            {if $row->total_unload_handling_amount > 0}
                            <tr>
                                <td>Unloading Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> {$row->total_unload_handling_amount|inr_format}</td>
                            </tr>
                            {/if}
                            {if $row->pickup_handling_amount > 0}
                            <tr>
                                <td>Pickup Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> {$row->pickup_handling_amount|inr_format}</td>
                            </tr>
                            {/if}
                            {if $row->delivery_handling_amount > 0}
                            <tr>
                                <td>Delivery Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> {$row->delivery_handling_amount|inr_format}</td>
                            </tr>
                            {/if}
                            {if $row->other_charges_amount != 0}
                                {foreach key=ck item=cv from=_parse_other_charges($row->other_charges)}
                                    {if $cv == 0}
                                        {continue}
                                    {/if}
                                    <tr>
                                    <td>{$ck|_snakecase_to_titlecase}</td>
                                    <td>&ensp;:&ensp;</td>
                                    <td align="right"><i class="fa fa-rupee"></i> {$cv|inr_format}</td>
                                    </tr>
                                {/foreach}
                            {/if}

                            </table>'>
                            </i>
                        </td>
                        <td align="right">{$row->transaction_amount|inr_format}</td>
                        <td align="right">
                            {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)-$row->transaction_amount}
                            {$rtopay|inr_format}
                            {assign var='tot_topay' value=$tot_topay+$rtopay}
                        </td>
                    </tr>

                    {assign var=tot_lr_count value=$tot_lr_count+1}
                    {assign var=tot_item_count value=$tot_item_count+$row->item_count}
                    {assign var=tot_fare value=$tot_fare+$row->total_amount}
                    {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                    {assign var=tot_payable value=$tot_payable+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}
                    {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                    {assign var=tot_items value=$tot_items+$row->total_item_count}
                    {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->service_charge + $row->other_charges_amount + $row->connecting_charge}
                    {assign var=tot_commission value=$tot_commission+$row->commission_amount}
                {/if}
            {/foreach}

            {if $tot_lr_count}
                <tr class="active">
                    <td align="right" colspan="17" class="bold">Total {$tot_lr_count} {lang('lr')}s</td>
                    <td align="right" class="bold">{$tot_item_count}</td>
                    <td align="right" class="bold">{$tot_items}</td>
                    <td align="right" class="bold">{$tot_fare|inr_format}</td>
                    <td align="right" class="bold">{$t_other_tot_amount|inr_format}</td>
                    <td align="right" class="bold">{$tot_payable|inr_format}</td>
                    <td align="right" class="bold">{$tot_paid|inr_format}</td>
                    <td align="right" class="bold">{$tot_topay|inr_format}</td>
                </tr>
            {else}
                <tr>
                    <td colspan="100%" align="center">No Records Found!</td>
                </tr>
            {/if}

        </tbody>
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoDeliveryExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div> 

<script>
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
</script>