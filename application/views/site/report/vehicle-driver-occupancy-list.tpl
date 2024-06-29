<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Trip Occupancy Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} 
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table> 
<br/>    
<table id="vehicle_driver_report_table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th align="center">S No</th>
            <th align="center">Schedule Name</th>
            <th align="center">Trip Date</th>
            <th align="center">Trip Time</th>
            <th align="center">Service No</th>             
            <th align="center">Vehicle No</th>
            <th align="center">Bus Type</th> 
            <th align="center">Total Seats</th>
            <th align="center">Booked Seats</th>
            <th align="center">Vacant Seats</th>
            <th align="center">Occupancy %</th>
            <th align="center">Tnx Amount</th>
        </tr>
    </thead>
    <tbody class="body_table" >
        {assign var=g_seats value=0}
        {assign var=g_booked value=0}
        {assign var=g_amount value=0}        
            
        {foreach item=row from=$result key=t}
            <tr>     
                <td align="center">{$t+1}</td> 
                <td align="left">{$row->schedule_name}</td>
                <td align="left" nowrap>{$row->trip_date|date_format:$ns_date_format}</td>
                <td align="left" nowrap>{$row->trip_date|date_format:$ns_time_format}</td>
                <td align="left">{if $row->service_number} <span class="warning-text"> {$row->service_number} </span> {else} - {/if}</td>
                <td align="left">{if $row->registation_number}{$row->registation_number}{else} - {/if}</td> 
                <td align="left">{formatBusCategory cate_code=$row->category_code}</td>                
                <td align="right">{$row->total_seat_count}</td>
                <td align="right">{$row->occupancy_count}</td>
                <td align="right">
                    {assign var=a value=$row->total_seat_count - $row->occupancy_count}
                    {if $a >= 0}
                        {$a}
                    {else}
                        0
                    {/if}
                </td>
                <td align="right">{(($row->occupancy_count / $row->total_seat_count)*100 )|number_format:2} %</td>
                <td align="right">{$row->booked_amount}</td>
            </tr> 
            {assign var=g_seats value=$g_seats+$row->total_seat_count}
            {assign var=g_booked value=$g_booked+$row->occupancy_count}
            {assign var=g_amount value=$g_amount+$row->booked_amount}
        {foreachelse} 
            <tr><td colspan="13" align="center">No data available</td><tr>
        {/foreach} 
        
        {if $g_seats > 0}
            <tr>     
                <td align="right" class="bold" colspan="7"></td>                
                <td align="right" class="bold">{$g_seats}</td>
                <td align="right" class="bold">{$g_booked}</td>
                <td align="right" class="bold">
                    {assign var=a value=$g_seats - $g_booked}
                    {if $a >= 0}
                        {$a}
                    {else}
                        0
                    {/if}
                </td>
                <td align="right" class="bold">{(($g_booked / $g_seats)*100 )|number_format:2} %</td>
                <td align="right" class="bold">{$g_amount|inr_format}</td>
            </tr> 
        {/if}
    </tbody>
</table>
