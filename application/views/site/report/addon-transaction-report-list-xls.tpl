<table border="1">
    <tr style="font-weight: bold">
        <td  colspan="10" align="center">Addon Transaction Report</td>
    </tr>
    <tr style="font-weight: bold">
        <td colspan="3">{$smarty.request.from_date|date_format:$ns_date_format} to {$smarty.request.to_date|date_format:$ns_date_format}</td>
        <td colspan="3" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
    </tr>
</table>

<br>

<table border='1'>
    <tr>
        <td colspan="9" style="font-weight:bold; background-color:#64b92a; color: #fff;">Summary</td>
    </tr>
</table>

<table border='1'>
    <tr>
        <td class="bold" colspan="2" style="font-weight:bold;" >Fare</td>
        <td class="text-right" colspan="2">{$meta['total_fare']|number_format:2}</td>

        <td class="bold" >&nbsp;</td>

        <td class="bold" colspan="2" style="font-weight:bold;">Total Tickets</td>
        <td class="text-right" colspan="2">{$total_tickets}</td>
    </tr>
    <tr>
        <td class="bold" colspan="2" style="font-weight:bold;">Addon Amount</td>
        <td class="text-right" colspan="2">{$meta['total_discount']|number_format:2}</td>

        <td class="bold" >&nbsp;</td>

        <td class="bold" colspan="2" style="font-weight:bold;">Total Seats</td>
        <td class="text-right" colspan="2">{$total_seats}</td>
    </tr>
</table>

<br>
<table border='1'>
    <tr>
        <td colspan="10" style="font-weight:bold">Transactions</td>
    </tr>
</table>

<table border='1'>
    <thead>
        <tr class="success" style="font-weight: bold; background-color:#64b92a; color: #fff;">
            <th align="center">PNR</th>
            <th align="center">Route</th>
            <th align="center">Fare</th>
            <th align="center">Addon Amount</th>
            <th align="center">Addon Type</th>
            <th align="center">Seat Count</th>
            <th align="center">Booked By</th>
            <th align="center">User Group</th>
            <th align="center">Travel Date</th>
            <th align="center">Booked Date</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach item=row from=$tickets key=t}
            <tr>
                <td>{$row->ticket_code}</td>
                <td>{$row->from_station_name} - {$row->to_station_name}</td>
                <td align='right'>{$row->ticket_amount|number_format:2}</td>
                <td align='right'>{$row->discount_amount|number_format:2}</td>
                <td>{$addons_type[$row->addons_type_code]}</td>
                <td>{$row->seat_count}</td>
                <td>
                    {if $row->user_group_name|lower!='customer'} {$row->first_name}
                    {else} - {/if}
                </td>
                <td>{$row->user_group_name}</td>
                <td>{$row->travel_date|date_format:$ns_date_format}</td>
                <td>{$row->transaction_date|date_format:$ns_datetime_format}</td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="10" align="center">No data found</td>
            </tr>
        {/foreach}
    </tbody>
</table>
