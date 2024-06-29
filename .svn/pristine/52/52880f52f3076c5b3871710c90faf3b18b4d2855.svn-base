<table border="1">
    <tr>
        <td colspan="6" align="center"><b>Transit Based Branch Collection Report</b>
    </tr>
    <tr>
        <td colspan="3">
            <b>Report Date : </b>{$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format}
        </td>
        <td colspan="3" align="right"><b>Report At : </b>{$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$user_name}</td>
    </tr>
</table>
<br>
<table border='1'>
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <td align="center" rowspan="2">Date</td>
            <td align="center" colspan="3">Transit Details</td>
            <td align="center" colspan="3">Booking Details</td>
            <td align="center" nowrap rowspan="2">Receiving Branch</td>
            <td align="center" rowspan="2"> LR count</td>
            <td align="center" nowrap rowspan="2">Paid (Rs)</td>
            <td align="center" nowrap rowspan="2">toPay (Rs)</td>
            <td align="center" nowrap rowspan="2">RAC (Rs)</td>
        </tr>
        <tr style="background-color:#64b92a; color: #fff;">
            <td align="center">{lang('ogpl')} No.</td>
            <td align="center">Vehicle No.</td>
            <td align="center">Route</td>

            <td align="center">Zone</td>
            <td align="center">Station</td>
            <td align="center" nowrap>Branch Name</td>
        </tr>
    </thead>
    {assign var=t_lr_count value=0}
    {assign var=t_topay_amount value=0}
    {assign var=t_paid_amount value=0}
    {assign var=t_onaccount_amount value=0}

    <tbody class="body_table">
        {foreach item=row from=$result}
            <tr>
                <td nowrap>{$row->loaded_date|date_format:$ns_date_format}</td>
                <td>{$row->transit_alias_code}</td>
                <td>{$row->registration_number}</td>
                <td nowrap> {($row->transit_from_station_name|cat:" to "|cat:$row->transit_to_station_name)|truncate:30}</td>
                <td>{$row->zone_name|default:'-'}</td>
                <td>{$row->station_name}</td>
                <td>{$row->organization_name}</td>
                <td>{$row->related_organization_name}</td>
                <td align="center">{$row->cargo_count}</td>
                <td align="right">{$row->paid_amount}</td>
                <td align="right">{$row->topay_amount}</td>
                <td align="right">{$row->onacc_amount}</td>
            </tr>
            {assign var=t_lr_count value=$t_lr_count+$row->cargo_count}
            {assign var=t_topay_amount value=$t_topay_amount+$row->topay_amount}
            {assign var=t_paid_amount value=$t_paid_amount+$row->paid_amount}
            {assign var=t_onaccount_amount value=$t_onaccount_amount+$row->onacc_amount}
        {foreachelse}
            <tr>
                <td colspan="12" align="center">No data found</td>
            </tr>
        {/foreach}
    </tbody>
    {if $result|count}
        <tr class="info">
            <td class="bold" align='right' colspan="8">Total</td>
            <td class="bold" align='center'>{$t_lr_count}</td>
            <td class="bold" align='right'>{$t_paid_amount|inr_format}</td>
            <td class="bold" align='right'>{$t_topay_amount|inr_format}</td>
            <td class="bold" align='right'>{$t_onaccount_amount|inr_format}</td>
        </tr>
    {/if}
</table>