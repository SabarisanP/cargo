<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Cargo Cancellation Report</span></td>
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
            <th align="center">Booked By</th>
            <th align="center">Cancelled At</th>
            <th align="center">Cancelled By</th>
            <th align="center">Sender Name</th>
            <th align="center">Sender Mobile No</th>
            <th align="center">Receiver Name</th>
            <th align="center">Receiver Mobile No</th>
            <th align="center">Payment Status</th>
            <th align="center">Cargo Status</th>
            <th align="center">Qty</th>
            <th align="center">Total Amount</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=total_item_count value=0}
        {assign var=total_amount value=0}

        {foreach item=row from=$result}
            <tr>
                <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->user_first_name}</td>
                <td align="left">{$row->cancelled_at|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->cancelled_user_first_name}</td>
                <td align="left">{$row->from_customer_name}</td>
                <td align="left">{$row->from_customer_mobile}</td>
                <td align="left">{$row->to_customer_name}</td>
                <td align="left">{$row->to_customer_mobile}</td>
                <td align="left">
                    {$row->payment_status_code|_cargo_payment_status_badge}
                </td>
                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                <td align="right">{$row->total_item_count}</td>
                <td align="right">{$row->total_amount|number_format:2}</td>
            </tr>
            {assign var=total_item_count value=$total_item_count + $row->total_item_count}
            {assign var=total_amount value=$total_amount + $row->total_amount}
        {foreachelse}
            <tr>
                <td colspan="100%" align="center">No Records Found!</td>
            </tr>
        {/foreach}

        {if $result|count}
            <tr class="active bold">
                <td align="right" colspan="11" class="bold">Total</td>
                <td align="right">{$total_item_count}</td>
                <td align="right">{$total_amount|number_format:2}</td>
            </tr>
        {/if}
    </tbody>
</table>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCancellationReport();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>