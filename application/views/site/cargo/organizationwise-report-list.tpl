<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold">{iflang('Organization Wise Report')}</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$from_date|date_format:$ns_date_format} to
            {$to_date|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right"><span class="bold">Report At : </span>
            {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>

<h5 class="noprint"><b>Summary</b></h5>
<div class="row">
    <div class="col-md-4">
        <table class="table table-bordered noprint">
            <tr>
                <td class="bold">Freight (A)</td>
                <td class="text-right">{$amounts['freight']|inr_format}</td>

                <td class="bold">Received</td>
                <td class="text-right">{$amounts['paid']|inr_format}</td>
            </tr>
            <tr>
                <td class="bold">Handling Charges (B)</td>
                <td class="text-right">{$amounts['handling']|inr_format}</td>

                <td class="bold">Balance</td>
                <td class="text-right">{$amounts['topay']|inr_format}</td>
            </tr>
            <tr>
                <td class="bold">Unloading Charges (C)</td>
                <td class="text-right">{$amounts['unloading']|inr_format}</td>

                <td class="bold">{$cargo_payment_status['INP']}</td>
                <td class="text-right">{$amounts['invoicepay']|inr_format}</td>
            </tr>
            <tr>
                <td class="bold">GST (D)</td>
                <td class="text-right">{$amounts['gst']|inr_format}</td>

                <td class="bold">&nbsp;</td>
                <td class="text-right">&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Pickup Charges (E)</td>
                <td class="text-right">{$amounts['pickup']|inr_format}</td>

                <td class="bold">&nbsp;</td>
                <td class="text-right">&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Delivery Charges (F)</td>
                <td class="text-right">{$amounts['delivery']|inr_format}</td>

                <td class="bold">&nbsp;</td>
                <td class="text-right">&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Connecting Charges (G)</td>
                <td class="text-right">{$amounts['connecting']|inr_format}</td>

                <td class="bold">&nbsp;</td>
                <td class="text-right">&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">{lang('other_charges')} (H)</td>
                <td class="text-right">{$amounts['service_charge']|inr_format}</td>

                <td class="bold">&nbsp;</td>
                <td class="text-right">&nbsp;</td>
            </tr>

            <tr>
                <td class="bold" nowrap>Sub Total (S1 = A+B+C+D+E+F+G+H)</td>
                <td class="text-right">
                    {$amounts['netpayable']|inr_format}
                </td>

                <td class="bold">&nbsp;</td>
                <td class="text-right"></td>
            </tr>

            <tr>
                <td class="bold">Commission (I)</td>
                <td class="text-right">
                    {($amounts['commission']-$amounts['handling_commission'])|inr_format}
                </td>

                <td class="bold">&nbsp;</td>
                <td class="text-right"></td>
            </tr>

            <tr>
                <td class="bold">Share (J)</td>
                <td class="text-right">
                    {($amounts['handling_commission'])|inr_format}
                </td>

                <td class="bold">&nbsp;</td>
                <td class="text-right"></td>
            </tr>

            <tr>
                <td class="bold">Net Total (S1-I-J)</td>
                <td class="bold text-right">
                    {($amounts['netpayable']-$amounts['commission'])|inr_format}
                </td>

                <td class="bold">&nbsp;</td>
                <td class="text-right"></td>
            </tr>
        </table>
    </div>
    <div class="col-md-3">
        <table class="table table-bordered noprint">
            <tr class="success">
                <th class="bold"></th>
                <th class="text-right">LRs</th>
                <th class="text-right">No. Of Articles</th>
                <th class="text-right">Freight</th>
            </tr>
            {foreach item=row from=$summary key=paytype}
                <tr>
                    <td class="bold">{$cargo_payment_status[$paytype]}</td>
                    <td class="text-right">{($row['count'] + 0)|sigma:$summ_count}</td>
                    <td class="text-right">{($row['qtycount'] + 0)|sigma:$summ_qty}</td>
                    <td class="text-right">{$row['freight']|sigma:$summ_freight|inr_format}</td>
                </tr>
            {/foreach}
            {if $summary|count}
                <tr>
                    <td class="bold">Total</td>
                    <td class="bold text-right">{$summ_count}</td>
                    <td class="bold text-right">{$summ_qty}</td>
                    <td class="bold text-right">{$summ_freight|inr_format}</td>
                </tr>
            {/if}
        </table>
    </div>
</div>

<h5><b>Transactions</b></h5>
<div class="overflow-x-auto">
    <table id="dt_adv_booking_report_table" class="table table-bordered" style="width:99%;">
        <thead>
            <tr class="success">
                <td align="center">Booked Date</td>
                <td align="center">{lang('cargo_code_term')}</td>
                <td align="center">No. Of Articles</td>
                <td align="center">Type Of Packaging</td>
                <td align="center">Type Of Booking</td>
                <td align="center">{lang('booking_from_term')}</td>
                <td align="center" class="noprint">User</td>
                <td align="center">{lang('booking_to_label')}</td>
                <td align="center">{lang('booking_sender_term')}</td>
                <td align="center">{lang('booking_sender_term')} Contact Number</td>
                <td align="center">{lang('booking_receiver_term')}</td>
                <td align="center">{lang('booking_receiver_term')} Contact Number</td>
                <td align="center">Type Of Delivery</td>
                <td align="center">Payment Status</td>
                <td align="center">Date Of Dispatch</td>
                <td align="center">Dispatch Status</td>
                <td align="center">Cargo Status</td>
                {if $namespaceCode=='seenutransports' || $namespaceCode=='seenucargo' }
                <td align="center">RP Send</td>
                <td align="center">RP Receiving</td>
            {/if}
                <td align="center">Bill No / Bill Date</td>
                <td align="center">CR No / CR Date</td>
                <td align="center">Billing Status</td>
                <td align="center">Voucher No / Voucher Date</td>
                <td align="center">Total Amount</td>
                <td align="center">Freight Amount</td>
                <td align="center">GST</td>
                <td align="center">{lang('other_charges')}</td>
                <td align="center">Net Payable</td>
                <td align="center">Commission</td>
                <td align="center">Share</td>
                <td align="center">Received</td>
                <td align="center">Balance</td>
            </tr>

        </thead>
        <tbody class="body_table">

            {assign var=tot_fare value=0}
            {assign var=tot_seenu_total value=0}
            {assign var=tot_handling value=0}
            {assign var=tot_payable value=0}
            {assign var=tot_paid value=0}
            {assign var=tot_topay value=0}
            {assign var=tot_items value=0}
            {assign var=tot_commission value=0}
            {assign var=tot_share value=0}

            {assign var=t_service_tax value=0}
            {assign var=t_total_handling_amount value=0}
            {assign var=t_total_unload_handling_amount value=0}
            {assign var=t_pickup_handling_amount value=0}
            {assign var=t_delivery_handling_amount value=0}
            {assign var=t_other_tot_amount value=0}

            {if $smarty.request.groupBy == "PAYTYPE"}
                {foreach item=val from=$result key=key}
                    <tr>
                        <td align="center" colspan="25" class="bold">{$key}</td>
                    </tr>
                    {foreach item=row from=$val key=t}
                        {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                            <tr>
                                <td align="left" nowrap>{capture assign=timestamp}{$row->booked_at|strtotime}{/capture}{$timestamp|date_format:"%d %b %Y %I:%M %p"}</td>
                                <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                                <td align="center">{$row->total_item_count}</td>
                                <td align="center">{$row->cargo_item_name}</td>
                                <td align="center">{$delivery_type_codes[$row->pickup_type_code]}</td>
                                <td align="left">{$row->from_organization_name}</td>
                                <td align="left" class="noprint">{$row->user_first_name}</td>
                                <td align="left">{$row->to_organization_name}</td>
                                <td align="left">{$row->from_customer_name}</td>
                                <td align="left">{$row->from_customer_mobile|mask_mobileno}</td>
                                <td align="left">{$row->to_customer_name}</td>
                                <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                                <td align="center">{$delivery_type_codes[$row->delivery_type_code]}</td>
                                <td align="center">
                                    {$row->payment_status_code|_cargo_payment_status_badge}
                                </td>
                                <td align="left" nowrap>
                                    {if isNotNull($row->unloaded_at)}
                                        {$row->unloaded_at|date_format:$ns_datetime_format}
                                    {else}
                                        -
                                    {/if}
                                </td>
                                <td align="center">
                                    {if $row->cargo_status_code == "CL" || $row->cargo_status_code == "CUL" || $row->cargo_status_code == "CD"}
                                        Yes
                                    {elseif $row->cargo_status_code == "CB" || $row->cargo_status_code == "CUD" || $row->cargo_status_code == "CR" || $row->cargo_status_code == "CA"}
                                        No
                                    {/if}
                                </td>
                                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                                {if $namespaceCode=='seenutransports'||$namespaceCode=='seenucargo' }
                                <td align="left" nowrap>{$row->pod_sending_at|date_format:"d-m-Y"|default:'-'} </td>
                                <td align="left" nowrap> {$row->pod_received_at|date_format:"d-m-Y"|default:'-'}</td>
                            {/if}
                                <td align="center" nowrap>{if isset($row->invoice_number)}{$row->invoice_number}/{$row->invoice_date|date_format:"d-m-Y"} {else}-{/if}</td>
                                <td  align="left" nowrap>{if isset($row->transaction_receipt_code)}{$row->transaction_receipt_code}/{$row->receipt_transaction_date|date_format:"d-m-Y"} {else}-{/if}</td>
                                <td  align="left" nowrap>{$row->payment_acknowledge_status|default:'-'} </td>
                                <td  align="left" nowrap>{if isset($row->voucher_number)}{$row->voucher_number}/{$row->voucher_transaction_date|date_format:"d-m-Y"}{else}-{/if}</td>
                                <td  align="left" nowrap> {$row->total_transaction_amount|inr_format}</td>
                                <td align="right">
                                    {$row->total_amount|inr_format}
                                </td>
                                <td align="right">
                                    {$row->service_tax|inr_format}
                                </td>
                                <td align="right" nowrap>
                                    {($row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount+$row->connecting_charge)|inr_format}

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
                                            <tr>
                                                <td>Handling Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> {$row->total_handling_amount|inr_format}</td>
                                            </tr>
                                            <tr>
                                                <td>GST</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> {$row->service_tax|inr_format}</td>
                                            </tr>
                                            <tr>
                                                <td>Unloading Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> {$row->total_unload_handling_amount|inr_format}</td>
                                            </tr>
                                            <tr>
                                                <td>Pickup Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> {$row->pickup_handling_amount|inr_format}</td>
                                            </tr>
                                            <tr>
                                                <td>Delivery Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> {$row->delivery_handling_amount|inr_format}</td>
                                            </tr>

                                        </table>
                                    '></i>
                                </td>
                                <td align="right" nowrap>
                                    {($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount+$row->connecting_charge)|inr_format}
                                    <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                        <table>
                                            <tr>
                                                <td>Net Payable</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> {$row->total_amount|inr_format}</td>
                                            </tr>
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
                                            <tr>
                                                <td>Handling Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> {$row->total_handling_amount|inr_format}</td>
                                            </tr>
                                            <tr>
                                                <td>GST</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> {$row->service_tax|inr_format}</td>
                                            </tr>
                                            <tr>
                                                <td>Unloading Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> {$row->total_unload_handling_amount|inr_format}</td>
                                            </tr>
                                            <tr>
                                                <td>Pickup Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> {$row->pickup_handling_amount|inr_format}</td>
                                            </tr>
                                            <tr>
                                                <td>Delivery Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> {$row->delivery_handling_amount|inr_format}</td>
                                            </tr>
                                        </table>
                                    '></i>
                                </td>

                                <td align="right">{($row->commission_amount-$row->handling_commission_amount)|inr_format}</td>
                                <td align="right">{$row->handling_commission_amount|inr_format}</td>
                                <td align="right">{$row->transaction_amount|inr_format}</td>
                                <td align="right">
                                    {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)-$row->transaction_amount}
                                    {$rtopay|inr_format}
                                    {assign var='tot_topay' value=$tot_topay+$rtopay}
                                </td>
                            </tr>
                            {assign var=tot_seenu_total value=$tot_seenu_total+$row->total_transaction_amount}
                            {assign var=tot_fare value=$tot_fare+$row->total_amount}
                            {assign var=tot_gst value=$tot_gst+$row->service_tax}
                            {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                            {assign var=tot_payable value=$tot_payable+$row->connecting_charge+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->service_tax+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->other_charges_amount}
                            {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                            {assign var=tot_items value=$tot_items+$row->total_item_count}
                            {assign var=tot_commission value=$tot_commission+($row->commission_amount-$row->handling_commission_amount)}
                            {assign var=tot_share value=$tot_share+$row->handling_commission_amount}

                            {assign var=t_service_tax value=$t_service_tax + $row->service_tax}
                            {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
                            {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
                            {assign var=t_pickup_handling_amount value=$t_pickup_handling_amount + $row->pickup_handling_amount}
                            {assign var=t_delivery_handling_amount value=$t_delivery_handling_amount + $row->delivery_handling_amount}
                            {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->other_charges_amount + $row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->connecting_charge}

                        {/if}
                    {/foreach}
                {/foreach}
            {else}
                {foreach item=row from=$result key=t}
                    {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                        <tr>
                            <td align="left" nowrap>{capture assign=timestamp}{$row->booked_at|strtotime}{/capture}{$timestamp|date_format:"%d %b %Y %I:%M %p"}</td>
                            <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                            <td align="center">{$row->total_item_count}</td>
                            <td align="center">{$row->cargo_item_name}</td>
                            <td align="center">{$delivery_type_codes[$row->pickup_type_code]}</td>
                            <td align="left">{$row->from_organization_name}</td>
                            <td align="left" class="noprint">{$row->user_first_name}</td>
                            <td align="left">{$row->to_organization_name}</td>
                            <td align="left">{$row->from_customer_name}</td>
                            <td align="left">{$row->from_customer_mobile|mask_mobileno}</td>
                            <td align="left">{$row->to_customer_name}</td>
                            <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                            <td align="center">{$delivery_type_codes[$row->delivery_type_code]}</td>
                            <td align="center">
                                {$row->payment_status_code|_cargo_payment_status_badge}
                            </td>
                            <td align="left" nowrap>
                                {if isNotNull($row->unloaded_at)}
                                    {$row->unloaded_at|date_format:$ns_datetime_format}
                                {else}
                                    -
                                {/if}
                            </td>
                            <td align="center">
                                {if $row->cargo_status_code == "CL" || $row->cargo_status_code == "CUL" || $row->cargo_status_code == "CD"}
                                    Yes
                                {elseif $row->cargo_status_code == "CB" || $row->cargo_status_code == "CUD" || $row->cargo_status_code == "CR" || $row->cargo_status_code == "CA"}
                                    No
                                {/if}
                            </td>
                            <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                            <td align="center" nowrap>{if isset($row->invoice_number)}{$row->invoice_number}/{$row->invoice_date|date_format:"d-m-Y"} {else}-{/if}</td>
                            <td  align="left" nowrap>{if isset($row->transaction_receipt_code)}{$row->transaction_receipt_code}/{$row->receipt_transaction_date|date_format:"d-m-Y"} {else}-{/if}</td>
                            <td  align="left" nowrap>{$row->payment_acknowledge_status|default:'-'} </td>
                            <td  align="left" nowrap>{if isset($row->voucher_number)}{$row->voucher_number}/{$row->voucher_transaction_date|date_format:"d-m-Y"}{else}-{/if}</td>
                            <td  align="left" nowrap> {$row->total_transaction_amount|inr_format}</td>
                            <td align="right">{$row->total_amount|inr_format}</td>
                            <td align="right">
                                {$row->service_tax|inr_format}
                            </td>
                            <td align="right" nowrap>
                                {($row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount+$row->connecting_charge)|inr_format}

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
                                        <tr>
                                            <td>Handling Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->total_handling_amount|inr_format}</td>
                                        </tr>
                                        <tr>
                                            <td>GST</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->service_tax|inr_format}</td>
                                        </tr>
                                        <tr>
                                            <td>Unloading Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->total_unload_handling_amount|inr_format}</td>
                                        </tr>
                                        <tr>
                                            <td>Pickup Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->pickup_handling_amount|inr_format}</td>
                                        </tr>
                                        <tr>
                                            <td>Delivery Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->delivery_handling_amount|inr_format}</td>
                                        </tr>
                                    </table>
                                '></i>
                            </td>
                            <td align="right" nowrap>
                                {($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount+$row->connecting_charge)|inr_format}
                                <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                    <table>
                                        <tr>
                                            <td>Net Payable</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->total_amount|inr_format}</td>
                                        </tr>
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
                                        <tr>
                                            <td>Handling Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->total_handling_amount|inr_format}</td>
                                        </tr>
                                        <tr>
                                            <td>GST</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->service_tax|inr_format}</td>
                                        </tr>
                                        <tr>
                                            <td>Unloading Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->total_unload_handling_amount|inr_format}</td>
                                        </tr>
                                        <tr>
                                            <td>Pickup Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->pickup_handling_amount|inr_format}</td>
                                        </tr>
                                        <tr>
                                            <td>Delivery Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->delivery_handling_amount|inr_format}</td>
                                        </tr>
                                    </table>
                                '></i>
                            </td>
                            <td align="right">{($row->commission_amount-$row->handling_commission_amount)|inr_format}</td>
                            <td align="right">{$row->handling_commission_amount|inr_format}</td>
                            <td align="right">{$row->transaction_amount|inr_format}</td>
                            <td align="right">
                                {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)-$row->transaction_amount}
                                {$rtopay|inr_format}
                                {assign var='tot_topay' value=$tot_topay+$rtopay}
                            </td>
                        </tr>
                        {assign var=tot_seenu_total value=$tot_seenu_total+$row->total_transaction_amount}
                        {assign var=tot_fare value=$tot_fare+$row->total_amount}
                        {assign var=tot_gst value=$tot_gst+$row->service_tax}
                        {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                        {assign var=tot_payable value=$tot_payable+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount+$row->connecting_charge}
                        {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                        {assign var=tot_items value=$tot_items+$row->total_item_count}
                        {assign var=tot_unit value=$tot_unit+$row->total_unit_value}
                        {assign var=tot_commission value=$tot_commission+($row->commission_amount-$row->handling_commission_amount)}
                        {assign var=tot_share value=$tot_share+$row->handling_commission_amount}

                        {assign var=t_service_tax value=$t_service_tax + $row->service_tax}
                        {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
                        {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
                        {assign var=t_pickup_handling_amount value=$t_pickup_handling_amount + $row->pickup_handling_amount}
                        {assign var=t_delivery_handling_amount value=$t_delivery_handling_amount + $row->delivery_handling_amount}
                        {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->other_charges_amount + $row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax + $row->connecting_charge}

                    {/if}
                {/foreach}
            {/if}

            <tr class="active">
                <td align="center"></td>
                <td align="left"></td>
                <td align="center">{$tot_items}</td>
                <td align="left" class="noprint"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                {if $namespaceCode=='seenutransports'|| $namespaceCode=='seenucargo' }
                    <td align="left"></td>
                    <td align="left"></td>
                {/if}
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="right" class="bold">Total</td>
            <td align="center" class="bold"> {$tot_seenu_total|inr_format}</td>
                <td align="center" class="bold">{$tot_fare|inr_format}</td>
                <td align="center" class="bold">{$tot_gst|inr_format}</td>
                <td align='right' class="bold" nowrap>{$t_other_tot_amount|inr_format} <i class="fa fa-info-circle invisible"></i></td>
                <td align="right" class="bold">{$tot_payable|inr_format}</td>
                <td align="right" class="bold">{$tot_commission|inr_format}</td>
                <td align="right" class="bold">{$tot_share|inr_format}</td>
                <td align="right" class="bold">{$tot_paid|inr_format}</td>
                <td align="right" class="bold">{$tot_topay|inr_format}</td>
            </tr>

        </tbody>
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoBookingExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        {if $smarty.request.groupBy == "PAYTYPE"}
            <button class="btn btn-default" onclick="bkgPrintPaid();"><i class="fa fa-print fa-lg"></i> Print Paid</button>
            <button class="btn btn-default" onclick="bkgPrintToPaid();"><i class="fa fa-print fa-lg"></i> Print
                Topay</button>
        {else}
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        {/if}
    </div>
</div>

<script>
	var namespaceCode = {$namespaceCode|json_encode};
    var summary = {$result|json_encode};
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
</script>
