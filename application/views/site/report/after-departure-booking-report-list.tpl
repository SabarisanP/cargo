<table width="99%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">After Departure Time Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">From </span> {$smarty.request.from|date_format:$ns_date_format}<span class="bold"> To </span> {$smarty.request.to|date_format:$ns_date_format} 
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table>
        
<div class="table-responsive">
    <table class="table table-bordered widthed">
        <thead>
            <tr class="success">
                <td align="center">PNR</td>
                <td align="center">Service Number</td> 
                <td align="center">Route</td>
                <td align="center">Booked By</td>
                <td align="center">Group</td>
                <td align="center">Device Medium</td>
                <td align="center">Seat Count</td>
                <td align="center">Trip Date</td>
                <td align="center">Transaction Date</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=seats value=0}
            {foreach item=row from=$result}
                <tr>
                    <td align="left">{$row->ticket_code}</td>
                    <td align="left">{$row->service_number}</td>
                    <td align="left">{$row->from_station_name} - {$row->to_station_name}</td>
                    <td align="left">
                        {if $row->user_group_name|lower!='customer'}
                            {$row->user_name}
                        {else}
                            Guest
                        {/if}
                    </td>
                    <td align="left">{$row->user_group_name}</td>
                    <td align="center">{$row->device_medium}</td>
                    <td align="center">{$row->seat_count}</td>
                    <td align="center">{$row->trip_date|date_format:$ns_datetime_format}</td>
                    <td align="center">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                </tr>
                {assign var=seats value=$seats+$row->seat_count}
            {/foreach}
            <tr>
                <td colspan="6" align="right" class="bold">Total Seat Count</td>
                <td align="center">{$seats}</td>
                <td colspan="2"></td>
            </tr>
        </tbody>
    </table>
</div>

<script>
    var device = {$device|json_encode};
    var route = {$route|json_encode};
    var group = {$group|json_encode};
</script>