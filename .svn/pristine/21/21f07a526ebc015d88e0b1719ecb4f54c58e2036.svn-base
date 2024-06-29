<table id="dt_bp_report_table" class="table table-bordered "  border='1'>
    <thead>
        <tr class="success">
            <th align="center">PNR</th>
            <th>Route</th>
            <th>Name</th>
            <th>Phone</th>  
            <th>Seat Name (Gender)</th>
            <th>Booked By</th>                
            <th>Booked Type</th> 
            <th>Remarks</th>
        </tr>
    </thead>
    <tbody class="body_table">            
        {foreach item=trip from=$tickets key=t}
            <tr class="active">
                <td colspan="8" class="bold" align="center" style=" background-color: #64b92a;">
                    {$t}
                </td>
            </tr>
            {foreach item=bp from=$trip key=b}
                <tr>
                    <td colspan="4" class="bold" align="left" style="font-weight: bold; background-color: #efefef;">
                        {$bp[0]->schedule_name}, {$bp[0]->vechile_number}, {$bp[0]->driver_name}, {$bp[0]->driver_number}
                    </td>
                    <td colspan="4" class="bold" align="left" style="font-weight: bold; background-color: #efefef;">
                        {$bp[0]->boarding_time}
                    </td>
                </tr>
                {foreach item=row from=$bp key=r}
                    <tr>                    
                        <td>{$row->ticket_code}</td>
                        <td>{$row->from_station_name} - {$row->to_station_name}</td>
                        <td>{$row->passenger_name}</td>
                        <td>{$row->mobile_number}</td> 
                        <td>{$row->seat_name}</td> 
                        <td>{$row->user_name}</td> 
                        <td>{$row->ticket_status}</td> 
                        <td>{$row->remarks}</td> 
                    </tr>   
                {/foreach}    
            {/foreach}                
        {/foreach}  
    </tbody>
</table>                
