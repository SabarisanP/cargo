<table class="" width="99%" border='1'>
    <tr>
        <td colspan="14" align="center"><span style="font-weight:bold">Addon Details Report</span></td>
    </tr>
    <tr>
        <td colspan="7">
            <span style="font-weight:bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td colspan="7" align="right"><span style="font-weight:bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="7">&nbsp;</td>
        <td colspan="7" align="right"><span style="font-weight:bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br/>
<table border='1' width="99%">
    <thead>
        <tr style="background-color: #64b92a; color: #fff;">
            <th>S.No</th>
            <th align="center">{lang('cargo_code_term')}</th>
            <th align="center">From Branch</th>
            <th align="center">To Branch</th>
            <th align="center">Booked by</th>
            <th align="center">Booked At</th>
            <th align="center">Unloaded At</th>
            <th align="center">Delivered At</th>
            <th align="center">Payment Status</th>
            <th align="center">Cargo Status</th>
            <th align="center">Qty</th>
            <th align="center">Freight</th>
            <th align="center">Loading Charges</th>
            <th align="center">Unloading Charges</th>
            <th align="center">{$addon_charges_type[$smarty.request.addonTypeCode]}</th>
            <th align="center">Amount Paid</th>
        </tr>
    </thead>
    <tbody>
        {assign var=total_item_count value=0}
        {assign var=delivery_handling_amount value=0}
        {assign var=total_handling_amount value=0}
        {assign var=total_unload_handling_amount value=0}
        {assign var=pickup_handling_amount value=0}
        {assign var=delivery_handling_amount value=0}
        {assign var=pod_charge value=0}
        {assign var=total_amount_paid value=0}
        {assign var=total_amount value=0}

        {foreach item=row from=$result key=i}
            <tr>
                <td align="left">{$i + 1}</td>
                <td align="center">{$row->cargo_code}</td>
                <td align="left">{$row->from_organization_name}</td>
                <td align="left">{$row->to_organization_name}</td>
                <td align="left">{$row->user_first_name}</td>
                <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                <td align="left" nowrap>{if isNotNull($row->unloaded_at)}{$row->unloaded_at|date_format:$ns_datetime_format}{else}-{/if}</td>
                <td align="left" nowrap>{if isNotNull($row->delivered_at)}{$row->delivered_at|date_format:$ns_datetime_format}{else}-{/if}</td>
                <td align="left">
                    {$row->payment_status_code|_cargo_payment_status_badge}
                </td>
                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                <td align="right">{$row->total_item_count}</td>
                <td align="right">{$row->total_amount|number_format:2}</td>
                <td align="right">{$row->total_handling_amount|number_format:2}</td>
                <td align="right">{$row->total_unload_handling_amount|number_format:2}</td>
                <td align="right">{$row->addon_amount|number_format:2}</td>
                <td align="right">{$row->total_amount_paid|number_format:2}</td>
            </tr>
            {assign var=total_item_count value=$total_item_count + $row->total_item_count}
            {assign var=delivery_handling_amount value=$delivery_handling_amount + $row->delivery_handling_amount}
            {assign var=total_handling_amount value=$total_handling_amount + $row->total_handling_amount}
            {assign var=total_unload_handling_amount value=$total_unload_handling_amount + $row->total_unload_handling_amount}
            {assign var=pickup_handling_amount value=$pickup_handling_amount + $row->pickup_handling_amount}
            {assign var=delivery_handling_amount value=$delivery_handling_amount + $row->delivery_handling_amount}
            {assign var=total_amount_paid value=$total_amount_paid + $row->total_amount_paid}
            {assign var=total_amount value=$total_amount + $row->total_amount}
            {assign var=addon_amount value=$addon_amount + $row->addon_amount}
        {foreachelse}
            <tr>
                <td colspan="16" align="center">No Records Found!</td>
            </tr>
        {/foreach}

        {if $result|count}
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td align="right" colspan="10" class="bold">Total</td>
                <td align="right">{$total_item_count}</td>
                <td align="right">{$total_amount|number_format:2}</td>
                <td align="right">{$total_handling_amount|number_format:2}</td>
                <td align="right">{$total_unload_handling_amount|number_format:2}</td>
                <td align="right">{$addon_amount|number_format:2}</td>
                <td align="right">{$total_amount_paid|number_format:2}</td>
            </tr>
        {/if}
    </tbody>
</table>
