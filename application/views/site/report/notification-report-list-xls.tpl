<table border="1">
    <tr>
        <td colspan="8" align="center"><b>Notification Report</b></td>
    </tr>
    <tr>
        <td colspan="4"><b>{$smarty.request.from|date_format:$ns_date_format} to {$smarty.request.to|date_format:$ns_date_format}</b></td>
        <td colspan="4" align="right"><b>Report Date/Time :</b> {date("d-m-Y h:i A")}</td>
    </tr>
</table>
<br>
<table border="1">
    <thead>
        <tr class="success">
            <th align="center">#</th>
            <th align="center">Sent At </th>
            <th align="center">Channel </th>
            <th align="center">SMS Type </th>
            <th align="center">To Mobile / Email </th>
            <th align="center">Reference # / PNR </th>
            <th align="center">SMS Credit Count </th>
            <th align="center">SMS Content</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach item=row from=$result key=t  name=feticket}
            <tr>
                <td align="center" nowrap>{$smarty.foreach.feticket.index+1}</td>
                <td align="left" nowrap>{$row->fired_date|date_format:$ns_datetime_format}</td>
                <td align="center" nowrap>{$notification_mode[$row->notification_mode]}</td>
                <td align="left" nowrap>{$sms_notification_type[$row->notification_type]}</td>
                <td align="center" nowrap>{$row->participant_address}</td>
                <td align="center" nowrap>{$row->refference_code}</td>
                <td align="center" nowrap>{$row->transaction_count}</td>
                <td align="left">
                    <p>{$row->request_log}</p>
                </td>
            </tr>
            {assign var=g_b_sms_count value=$g_b_sms_count+$row->transaction_count}
        {/foreach}
    </tbody>
    {if count($result)}
        <tfoot>
            <tr class="success bold">
                <td colspan="6" align="right">Total Credit</td>
                <td align="center">{$g_b_sms_count}</td>
                <td align="center"></td>
            </tr>
        </tfoot>
    {/if}
</table>                
     