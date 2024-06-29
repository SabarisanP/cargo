<table border='1'>
    <tr>
        <td  colspan="12" align="center"><b>Driver Duty Allocation Report</b></td>
    </tr>
    <tr>
        <td colspan="6">Report Date : {$smarty.request.from|date_format:$ns_date_format}  to {$smarty.request.to|date_format:$ns_date_format} </td>
        <td colspan="6" >Report At : {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
        <td colspan="6" ><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>    

<br>


<table class="table table-bordered " border='1'>
    <thead>
        <tr style="font-weight:bold; background-color:#64b92a; color: #fff;">
            <th >Trip Date</th>
            <th >Schedule Name</th>
            <th >Service Number</th>
            <th >Vehicle Number</th> 
            <th >Driver 1</th>                    
            <th >Driver 2</th>
            <th >Assigned at</th>
            <th >Start Time</th>
            <th >Trip Status</th>
            <th >Occupancy</th>
            <th >Total Seats</th> 
            <th >Booked Amount</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=total_booked_amount value=0}
            {foreach from=$reports item=row name=fetrans}
                <tr>
                    <td>{$row->trip_date|date_format:$ns_date_format}</td>
                    <td>{$row->schedule_name}</td>
                    <td><span class="warning-text">{$row->service_number}</span></td> 
                    <td>{($row->registration_number)? ($row->registration_number) : '-'}</td>                           
                    <td>{$row->driver_name}</td>
                    <td>{$row->co_driver_name}</td>
                    <td>{$row->trip_allocated_time|date_format:$ns_datetime_format}</td> 
                    <td>{$row->trip_start_time|date_format:$ns_datetime_format}</td> 
                    <td>
                        {if $row->trip_status == "TPC"}
                        <span class="badge badge-danger">Closed</span>
                        {elseif $row->trip_status == "TPO"}
                        <span class="badge badge-success">Open</span>    
                        {elseif $row->trip_status == "TPY"}
                        <span class="badge badge-default">Yet To Open</span> 
                        {elseif $row->trip_status == "TCA"}
                        <span class="badge badge-warning">Cancelled</span>
                        {/if}
                    </td>
                    <td>{$row->occupancy_count}</td>
                    <td>{$row->total_seat_count}</td>
                    <td align="right"> {$row->booked_amount|inr_format}</td>
                    {assign var="total_booked_amount" value=$total_booked_amount+$row->booked_amount}
                </tr>
            {/foreach}
            <tr style="font-weight:bold;background-color:#bbbbbb; color: #fff;">
                <td  colspan="11" align='right'>Total</td>
                <td align='right'>{$total_booked_amount|inr_format}</td>
            </tr>
    </tbody>
</table>


