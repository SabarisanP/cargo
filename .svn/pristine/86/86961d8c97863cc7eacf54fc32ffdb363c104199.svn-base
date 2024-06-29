<table class="" width="99%" border="1">
    <tr>
        <td colspan="13" align="center"><b>Trip Occupancy Report</b></td>
    </tr>
    <tr>
        <td colspan="6">
            <b>From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} </b>
        </td>
        <td colspan="7" align="right">
            <b>Report Date/Time :</b> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table> 
        
<br/>   

<table width="99%" border="1">
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
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
            <tr><td colspan="12" align="center">No data available</td><tr>
        {/foreach} 
        
        {if $g_seats > 0}
            <tr>     
                <td align="right" class="bold" colspan="6"></td>                
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