<table class="" width="99%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Cargo Pickup / Delivery Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br/>
<div class="clearfix"></div>
<table class="table table-bordered" width="98%">
    <thead>
        <tr class="success">
            <th align="center">{lang('cargo_code_term')}</th>
            <th align="center">Booked At</th>
            <th align="center">Delivered At</th>
            <th align="center">From Branch</th>
            <th align="center">To Branch</th>
            <th align="center">Booked by</th>
            <th align="center">OTP</th>
            <th align="center">Payment Status</th>
            <th align="center">Cargo Status</th>
            <th align="center">Qty</th>
            <th align="center">Delivery Charges</th>
            <th align="center">Loading Charges</th>
            <th align="center">Unloading Charges</th>
            <th align="center">Pickup Charges</th>
            <th align="center">Amount Paid</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=total_item_count value=0}
        {assign var=delivery_handling_amount value=0}
        {assign var=total_handling_amount value=0}
        {assign var=total_unload_handling_amount value=0}
        {assign var=pickup_handling_amount value=0}
        {assign var=total_amount_paid value=0}
        {assign var=total_amount value=0}

        {foreach item=row from=$result}
            <tr>
                <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->delivered_at|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->from_organization_name}</td>
                <td align="left">{$row->to_organization_name}</td>
                <td align="left">{$row->user_first_name}</td>
                <td align="left">{$row->otp_number}</td>
                <td align="left">
                    {$row->payment_status_code|_cargo_payment_status_badge}
                </td>
                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                <td align="right">{$row->total_item_count}</td>
                <td align="right">{$row->delivery_handling_amount|number_format:2}</td>
                <td align="right">{$row->total_handling_amount|number_format:2}</td>
                <td align="right">{$row->total_unload_handling_amount|number_format:2}</td>
                <td align="right">{$row->pickup_handling_amount|number_format:2}</td>
                <td align="right">{$row->total_amount_paid|number_format:2}</td>
            </tr>
            {assign var=total_item_count value=$total_item_count + $row->total_item_count}
            {assign var=delivery_handling_amount value=$delivery_handling_amount + $row->delivery_handling_amount}
            {assign var=total_handling_amount value=$total_handling_amount + $row->total_handling_amount}
            {assign var=total_unload_handling_amount value=$total_unload_handling_amount + $row->total_unload_handling_amount}
            {assign var=pickup_handling_amount value=$pickup_handling_amount + $row->pickup_handling_amount}
            {assign var=total_amount_paid value=$total_amount_paid + $row->total_amount_paid}
        {foreachelse}
            <tr>
                <td colspan="100%" align="center">No Records Found!</td>
            </tr>
        {/foreach}

        {if $result|count}
            <tr class="active bold">
                <td align="right" colspan="9" class="bold">Total</td>
                <td align="right">{$total_item_count}</td>
                <td align="right">{$delivery_handling_amount|number_format:2}</td>
                <td align="right">{$total_handling_amount|number_format:2}</td>
                <td align="right">{$total_unload_handling_amount|number_format:2}</td>
                <td align="right">{$pickup_handling_amount|number_format:2}</td>
                <td align="right">{$total_amount_paid|number_format:2}</td>
            </tr>
        {/if}
    </tbody>
</table>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoCollection();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>