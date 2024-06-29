<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Trip Cancellation Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">From </span> {$smarty.request.from|date_format:$ns_date_format} <span class="bold"> To </span>{$smarty.request.to|date_format:$ns_date_format} 
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table> 
<br/>    
<table id="trip_cancellation_table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th align="center">PNR</th> 
            <th align="center">Service Number</th> 
            <th align="center">Trip Date</th> 
            <th align="center">Route</th> 
            <th align="center">Booked By</th> 
            <th align="center">Passenger Name</th> 
            <th align="center">Mobile No</th> 
            <th align="center">Seat Name</th> 
            <th align="center">Seat Count</th> 
            <th align="center">Ticket Amount</th> 
            <th align="center">Cancelled At</th> 
        </tr>
    </thead>
    <tbody class="body_table" >
        {foreach item=row from=$result key=t}
            {if $row->ticket_status_code == 'TCA'}
                <tr>     
                    <td align="left">{$row->ticket_code}</td>
                    <td align="left">{$row->service_number}</td>
                    <td align="left">{$row->trip_date_time|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->from_station_name} - {$row->to_station_name}</td> 
                    <td align="left">{$row->user_name}</td>
                    <td align="left">{$row->passenger_name}</td>
                    <td align="left">{$row->mobile_number}</td>
                    <td align="left">{$row->seat_name}</td>
                    <td align="left">{$row->seat_count}</td>
                    <td align="left">{$row->ticket_amount}</td>
                    <td align="left">{$row->trip_cancel_at|date_format:$ns_datetime_format}</td>
                </tr> 
            {/if}
        {foreachelse} 
            <tr><td colspan="11" align="center">No data available</td><tr>
        {/foreach} 
    </tbody>
</table>