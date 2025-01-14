<table border='1'>
    <tr>
        <td colspan="6" align="center"><b>{iflang('Cargo Booking Report')}</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$from_date|date_format:$ns_date_format} to {$to_date|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$username} </td>
    </tr>
</table>
<div class="row">
    <div class="col-md-4">
        <table border="1">
            {foreach item=row from=$summary key=paytype}
                {if $row['code'] =="PAD"}
                    <thead>
                        <tr style="background-color: #64b92a">
                            <td align="center" class="bold">Paid Bookings</td>
                            <td align="center" class="bold">Amount</td>
                        </tr>
                    </thead>

                    <tr>
                        <td class="bold">Freight (A)</td>
                        <td class="text-right">{$row['freight']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Handling Charges (B)</td>
                        <td class="text-right">{$row['handling']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Unloading Charges (C)</td>
                        <td class="text-right">{$row['unloading']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">GST (D)</td>
                        <td class="text-right">{$row['gst']|inr_format}</td>

                    </tr>
                    <tr>
                        <td class="bold">Pickup Charges (E)</td>
                        <td class="text-right">{$row['pickup']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Delivery Charges (F)</td>
                        <td class="text-right">{$row['delivery']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Connecting Charges (G)</td>
                        <td class="text-right">{$row['connecting']|inr_format}</td>

                    </tr>
                    <tr>
                        <td class="bold">{lang('other_charges')} (H)</td>
                        <td class="text-right">{$row['service_charge']|inr_format}</td>

                    </tr>

                    <tr>
                        <td class="bold" nowrap>Sub Total (S1 = A+B+C+D+E+F+G+H)</td>
                        <td class="text-right">
                            {$row['payable']|inr_format}
                        </td>
                    </tr>

                    <tr>
                        <td class="bold">Commission (I)</td>
                        <td class="text-right">
                            {($row['commission']-$row['handling_commission'])|inr_format}
                        </td>
                    </tr>
                    <tr>
                        <td class="bold">Share (J)</td>
                        <td class="text-right">
                            {($row['handling_commission'])|inr_format}
                        </td>
                    </tr>
                    <tr>
                        <td class="bold">Net Total (S1-I-J)</td>
                        <td class="bold text-right">
                            {($row['payable']-($row['commission']-$row['handling_commission'])-$row['handling_commission'])|inr_format}

                        </td>
                    </tr>
                    {assign var="t_paidAmt" value=$t_paidAmt+($row['payable']-($row['commission']-$row['handling_commission'])-$row['handling_commission'])}
                {/if}
            {/foreach}
        </table>
    </div>
    <div class="col-md-4">
        {foreach item=row from=$summary key=paytype}
            {if $row['code'] =="TPPAD"}
                <table border="1">
                    <thead>
                        <tr style="background-color: #64b92a">
                            <td align="center" class="bold">Topay Bookings</td>
                            <td align="center" class="bold">Amount</td>
                        </tr>
                    </thead>
                    <tr>
                        <td class="bold">Freight (A)</td>
                        <td class="text-right">{$row['freight']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Handling Charges (B)</td>
                        <td class="text-right">{$row['handling']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Unloading Charges (C)</td>
                        <td class="text-right">{$row['unloading']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">GST (D)</td>
                        <td class="text-right">{$row['gst']|inr_format}</td>

                    </tr>
                    <tr>
                        <td class="bold">Pickup Charges (E)</td>
                        <td class="text-right">{$row['pickup']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Delivery Charges (F)</td>
                        <td class="text-right">{$row['delivery']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Connecting Charges (G)</td>
                        <td class="text-right">{$row['connecting']|inr_format}</td>

                    </tr>
                    <tr>
                        <td class="bold">{lang('other_charges')} (H)</td>
                        <td class="text-right">{$row['service_charge']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Commission (I)</td>
                        <td class="text-right">
                            {($row['commission']-$row['handling_commission'])|inr_format}
                        </td>
                    </tr>
                    <tr>
                        <td class="bold">Share (J)</td>
                        <td class="text-right">
                            {($row['handling_commission'])|inr_format}
                        </td>
                    </tr>

                    <tr>
                        <td class="bold">Net Total (I+J)</td>
                        <td class="bold text-right">
                            {($row['handling_commission']+($row['commission']-$row['handling_commission']))|inr_format}
                        </td>
                    </tr>
                    {assign var="t_topayAmt" value=$t_topayAmt+($row['handling_commission']+($row['commission']-$row['handling_commission']))}
                </table>
            {/if}
        {/foreach}
    </div>
    <div class="col-md-4">
        {foreach item=row from=$summary key=paytype}
            {if $row['code'] =="INP"}
                <table border="1">
                    <thead>
                        <tr style="background-color: #64b92a">
                            <td align="center" class="bold">On account Bookings</td>
                            <td align="center" class="bold">Amount</td>
                        </tr>
                    </thead>
                    <tr>
                        <td class="bold">Freight (A)</td>
                        <td class="text-right">{$row['freight']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Handling Charges (B)</td>
                        <td class="text-right">{$row['handling']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Unloading Charges (C)</td>
                        <td class="text-right">{$row['unloading']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">GST (D)</td>
                        <td class="text-right">{$row['gst']|inr_format}</td>

                    </tr>
                    <tr>
                        <td class="bold">Pickup Charges (E)</td>
                        <td class="text-right">{$row['pickup']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Delivery Charges (F)</td>
                        <td class="text-right">{$row['delivery']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Connecting Charges (G)</td>
                        <td class="text-right">{$row['connecting']|inr_format}</td>

                    </tr>
                    <tr>
                        <td class="bold">{lang('other_charges')} (H)</td>
                        <td class="text-right">{$row['service_charge']|inr_format}</td>

                    </tr>
                    <tr>
                        <td class="bold">Commission (I)</td>
                        <td class="text-right">
                            {($row['commission']-$row['handling_commission'])|inr_format}
                        </td>
                    </tr>
                    <tr>
                        <td class="bold">Share (J)</td>
                        <td class="text-right">
                            {($row['handling_commission'])|inr_format}
                        </td>
                    </tr>
                    <tr>
                        <td class="bold">Net Total (I+J)</td>
                        <td class="bold text-right">
                            {($row['handling_commission']+($row['commission']-$row['handling_commission']))|inr_format}
                        </td>
                    </tr>
                    {assign var="t_onacountAmt" value=$t_onacountAmt+($row['handling_commission']+($row['commission']-$row['handling_commission']))}
                </table>
            {/if}
        {/foreach}
    </div>
</div>
<div class="row">
    <div class="col-md-3">
        <table border="1">
            <thead>
                <tr style="background-color: #64b92a">
                    <th align="center" nowrap>Payment Type</th>
                    <th align="center" nowrap>Total</th>
                </tr>
            </thead>
            <tr>
                <td class="bold">Paid (a)</td>
                <td align="center">{$t_paidAmt|inr_format}</td>
            </tr>
            <tr>
                <td class="bold">Paid (b)</td>
                <td align="center">{$t_topayAmt|inr_format}</td>
            </tr>
            <tr>
                <td class="bold">On Account (c) </td>
                <td align="center">{$t_onacountAmt|inr_format}</td>
            </tr>
            <tr>
                <td class="bold">Payable (D=a-b-c) </td>
                <td align="center">{($t_paidAmt-$t_topayAmt-$t_onacountAmt)|inr_format}</td>
            </tr>

        </table>

    </div>
    <div class="col-md-6">
        <table border="1">
            <thead>
                <tr style="background-color: #64b92a">
                    <th class="bold">Payment Type</th>
                    <th class="text-right">LRs</th>
                    <th class="text-right">No. Of Articles</th>
                    <th class="text-right">Freight</th>
                </tr>
            </thead>
            {foreach item=row from=$summary key=paytype}
                <tr>
                    <td class="bold">{$cargo_payment_status[$paytype]}{if $paytype =="PAD"}(a){elseif $paytype =="TOP"} (b) {elseif $paytype =="INP"} (c) {/if}</td>
                    <td class="text-right">{($row['t_count'] + 0)|sigma:$summ_counts}</td>
                    <td class="text-right">{($row['t_qtycount'] + 0)|sigma:$summ_qtys}</td>
                    <td class="text-right">{$row['t_freight']|sigma:$summ_freights|inr_format}</td>
                </tr>
            {/foreach}
            {if $summary|count}
                <tr>
                    <td class="bold">Total</td>
                    <td class="bold text-right">{$summ_counts}</td>
                    <td class="bold text-right">{$summ_qtys}</td>
                    <td class="bold text-right">{$summ_freights|inr_format}</td>
                </tr>
            {/if}
        </table>
    </div>
</div>
<table border='1'>
    <thead>
        <tr style="background-color: #64b92a">
            <td align="center"><b>Booked Date</b></td>
            <td align="center"><b>{lang('cargo_code_term')}</b></td>
            <td align="center">No. Of Articles</td>
            <td align="center">Type Of Packaging</td>
            <td align="center">Type Of Booking</td>
            <td align="center"> From State</td>
            <td align="center"><b>{lang('booking_from_term')}</b></td>
            <td align="center"><b>User</b></td>
            <td align="center">To State</td>
            <td align="center"><b>{lang('booking_to_label')}</b></td>
            <td align="center"><b>{lang('booking_sender_term')}</b></td>
            <td align="center"><b>RAC Name</b></td>
            <td align="center">{lang('booking_sender_term')} Contact Number</td>
            <td align="center"><b>{lang('booking_receiver_term')}</b></td>
            <td align="center"><b>{lang('booking_receiver_term')} Contact Number</b></td>
            <td align="center">Type Of Delivery</td>
            <td align="center"><b>Payment Status</b></td>
            <td align="center">Date Of Dispatch</td>
            <td align="center">Dispatch Status</td>
            <td align="center"><b>Cargo Status</b></td>
            <td align="center"><b>Items</b></td>
            <td align="center">{if $namespaceCode == "dishashree"}Qty/Kg {else}Qty{/if}</td>
            <td align="center"><b>Net Payable</b></td>
            <td align="center"><b>Handling Charges </b></td>
            <td align="center"><b>Freight Amount </b></td>
            <td align="center"><b>GST </b></td>
            <td align="center"><b>Unloading Charges </b></td>
            <td align="center"><b>Pickup Charges </b></td>
            <td align="center"><b>Delivery Charges </b></td>
            <td align="center"><b>{lang('other_charges')} </b></td>
            <td align="center"><b>Commission</b></td>
            <td align="center"><b>Share</b></td>
            <td align="center"><b>Received</b></td>
            <td align="center"><b>Balance</b></td>
        </tr>

    </thead>
    <tbody class="body_table">

        {assign var=tot_fare value=0}
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
                    <td align="center" colspan="20" class="bold">{$key}</td>
                </tr>
                {foreach item=row from=$val key=t}
                    {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                        <tr>
                            <td align="left" nowrap>{capture assign=timestamp}{$row->booked_at|strtotime}{/capture}{$timestamp|date_format:"%d %b %Y %I:%M %p"}</td>
                            <td align="center">{$row->cargo_code}</td>
                            <td align="center">{$row->total_item_count}</td>
                            <td align="center">{$row->cargo_item_name}</td>
                            <td align="center">{$delivery_type_codes[$row->pickup_type_code]}</td>
                            <td align="left">{$row->from_state_name}</td>
                            <td align="left">{$row->from_organization_name}</td>
                            <td align="left">{$row->user_first_name}</td>
                            <td align="left">{$row->to_state_name}</td>
                            <td align="left">{$row->to_organization_name}</td>
                            <td align="left">{$row->from_customer_name} </td>
                            <td align="left"> {if $row->payment_status_code == "INP"}{$row->vendor_name}{else} - {/if}</td>
                            <td align="left">{$row->from_customer_mobile|mask_mobileno}</td>
                            <td align="left">{$row->to_customer_name}</td>
                            <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                            <td align="center">{$delivery_type_codes[$row->delivery_type_code]}</td>
                            <td align="left">{$cargo_payment_status[$row->payment_status_code]}</td>

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
                            <td align="left">{$cargo_status[$row->cargo_status_code]} </td>
                            <td align="left">{$row->cargo_item_name}</td>
                            <td align="center">{if $namespaceCode == "dishashree"}{$row->total_item_count}/{$row->total_unit_value}{else}{$row->total_item_count}{/if}</td>

                            <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$row->total_handling_amount}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$row->service_tax}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$row->total_unload_handling_amount}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$row->pickup_handling_amount}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$row->delivery_handling_amount}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$row->other_charges_amount+$row->connecting_charge}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{($row->commission_amount-$row->handling_commission_amount)}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$row->handling_commission_amount}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$row->transaction_amount}</td>
                            <td align="right" data-format="{$xlformat['currency']}">
                                {if $row->payment_status_code =="PAD"}
                                    {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)-$row->transaction_amount}
                                    {$rtopay|inr_format}
                                    {assign var='tot_topay' value=$tot_topay+$rtopay}
                                {else}
                                    0.00
                                {/if}
                            </td>
                        </tr>
                        {assign var=tot_fare value=$tot_fare+$row->total_amount}
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
                        {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->connecting_charge}

                    {/if}
                {/foreach}
            {/foreach}
        {else}
            {foreach item=row from=$result key=t}
                {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                    <tr>
                        <td align="left" nowrap>{capture assign=timestamp}{$row->booked_at|strtotime}{/capture}{$timestamp|date_format:"%d %b %Y %I:%M %p"}</td>
                        <td align="center">{$row->cargo_code}</td>
                        <td align="center">{$row->total_item_count}</td>
                        <td align="center">{$row->cargo_item_name}</td>
                        <td align="center">{$delivery_type_codes[$row->pickup_type_code]}</td>
                        <td align="left">{$row->from_state_name}</td>
                        <td align="left">{$row->from_organization_name}</td>
                        <td align="left">{$row->user_first_name}</td>
                        <td align="left">{$row->to_state_name}</td>
                        <td align="left">{$row->to_organization_name}</td>
                        <td align="left">{$row->from_customer_name} </td>
                        <td align="left">{if $row->payment_status_code == "INP"}{$row->vendor_name}{else} - {/if}</td>
                        <td align="left">{$row->from_customer_mobile|mask_mobileno}</td>
                        <td align="left">{$row->to_customer_name}</td>
                        <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                        <td align="center">{$delivery_type_codes[$row->delivery_type_code]}</td>
                        <td align="left">{$cargo_payment_status[$row->payment_status_code]}</td>
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
                        <td align="left">{$cargo_status[$row->cargo_status_code]} </td>
                        <td align="left">{$row->cargo_item_name}</td>
                        <td align="center">{if $namespaceCode == "dishashree"}{$row->total_item_count}/{$row->total_unit_value}{else}{$row->total_item_count}{/if}</td>

                        <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->total_handling_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->service_tax}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->total_unload_handling_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->pickup_handling_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->delivery_handling_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->other_charges_amount+$row->connecting_charge}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{($row->commission_amount-$row->handling_commission_amount)}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->handling_commission_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->transaction_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">
                            {if $row->payment_status_code =="PAD"}
                                {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)-$row->transaction_amount}
                                {$rtopay|inr_format}
                                {assign var='tot_topay' value=$tot_topay+$rtopay}
                            {else}
                                0.00
                            {/if}
                        </td>
                    </tr>

                    {assign var=tot_fare value=$tot_fare+$row->total_amount}
                    {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                    {assign var=tot_payable value=$tot_payable+$row->connecting_charge+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}
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
                    {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->other_charges_amount + $row->connecting_charge}
                {/if}

            {/foreach}
        {/if}
    </tbody>
    {if $result|count}
        <tfoot>
            <tr class="active">
                <td align="right" colspan="21" class="bold"><b>Total</b></td>
                <td align="center" class="bold">{if $namespaceCode == "dishashree"}<b>{$tot_items}</b>/<b>{$tot_unit}</b>{else}<b>{$tot_items}</b>{/if}</td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}"><b>{$tot_payable}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$t_total_handling_amount}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$tot_fare}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$t_service_tax}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$t_total_unload_handling_amount}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$t_pickup_handling_amount}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$t_delivery_handling_amount}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$t_other_tot_amount}</b></td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}"><b>{$tot_commission}</b></td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}"><b>{$tot_share}</b></td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}"><b>{$tot_paid}</b></td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}"><b>{$tot_topay}</b></td>
            </tr>
        </tfoot>
    {else}
        <tfoot>
            <tr>
                <td colspan="31" align="center">No Records Found</td>
            </tr>
        </tfoot>
    {/if}
</table>