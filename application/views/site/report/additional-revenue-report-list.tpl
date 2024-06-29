<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Additional Revenue Report</span></td>
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
<table id="additional_revenue_report_table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th align="center">PNR</th> 
            <th align="center">Schedule</th> 
            <th align="center">Trip Date</th> 
            <th align="center">Route</th> 
            <th align="center">Booked By</th> 
            <th align="center">Ticket Status</th> 
            <th align="center">Passenger Name</th> 
            <th align="center">Seat Name</th> 
            <th align="center">Commission</th> 
            <th align="center">Fare</th> 
        </tr>
    </thead>
    <tbody class="body_table" >
        {assign var=t_commission_amount value=0}
        {assign var=t_ticket_amount value=0}
        {foreach item=row from=$result key=t}
            <tr>     
                <td align="left">{$row->ticket_code}</td>
                <td align="left">{$row->schedule_name}</td>
                <td align="left">{$row->trip_date|date_format:$ns_date_format}</td>
                <td align="left">{$row->from_station_name} - {$row->to_station_name}</td> 
                <td align="left">{$row->user_name}</td>
                <td align="left">{$row->ticket_status_code}</td>
                <td align="left">{$row->passenger_name}</td>
                <td align="left">{$row->seat_name}</td>
                <td align="right">{$row->commission_amount|inr_format}</td>
                <td align="right">{$row->ticket_amount|inr_format}</td>
            </tr> 
            {assign var=t_commission_amount value=$t_commission_amount+$row->commission_amount}
            {assign var=t_ticket_amount value=$t_ticket_amount+$row->ticket_amount}
        {foreachelse} 
            <tr>
                <td colspan="10" align="center">No data available</td>
            </tr>
        {/foreach} 
        {if $result|count}
            <tr class="active bold">                    
                <td colspan="8" align="right">Total</td>
                <td align="right">{$t_commission_amount|inr_format}</td>
                <td align="right">{$t_ticket_amount|inr_format}</td>                    
            </tr>
        {/if}
    </tbody>
</table>