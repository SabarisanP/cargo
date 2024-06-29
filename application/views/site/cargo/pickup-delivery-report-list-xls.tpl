<table border='1'>
    <tr>
        <td colspan="6" align="center"><b>Cargo Pickup / Delivery Report</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$usr_login_name} </td>
    </tr>
</table>

<table border='1'>
    <thead>
        <tr style="background-color: #64b92a; color: #fff;">
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
    <tbody>
        {assign var=total_item_count value=0}
        {assign var=delivery_handling_amount value=0}
        {assign var=total_handling_amount value=0}
        {assign var=total_unload_handling_amount value=0}
        {assign var=pickup_handling_amount value=0}
        {assign var=total_amount_paid value=0}
        {assign var=total_amount value=0}

        {foreach item=row from=$result}
            <tr>
                <td align="center">{$row->cargo_code}</td>
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
                <td align="right" data-format="{$xlformat['currency']}">{$row->delivery_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_unload_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->pickup_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount_paid}</td>
            </tr>
            {assign var=total_item_count value=$total_item_count + $row->total_item_count}
            {assign var=delivery_handling_amount value=$delivery_handling_amount + $row->delivery_handling_amount}
            {assign var=total_handling_amount value=$total_handling_amount + $row->total_handling_amount}
            {assign var=total_unload_handling_amount value=$total_unload_handling_amount + $row->total_unload_handling_amount}
            {assign var=pickup_handling_amount value=$pickup_handling_amount + $row->pickup_handling_amount}
            {assign var=total_amount_paid value=$total_amount_paid + $row->total_amount_paid}
        {/foreach}
    </tbody>
    {if $result|count}
        <tfoot>
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td align="right" colspan="9" class="bold">Total</td>
                <td align="right">{$total_item_count}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$delivery_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$total_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$total_unload_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$pickup_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$total_amount_paid}</td>
            </tr>
        </tfoot>
    {else}
        <tfoot>
            <tr>
                <td colspan="15" align="center">No Records Found</td>
            </tr>
        </tfoot>
    {/if}
</table>
