<table class="" width="99%" border="1">
    <tr>
        <td colspan="13" align="center"><b>Vehicle and Driver Allocation Report</b></td>
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
            <th align="center">Trip Date</th> 
            <th align="center">Schedule Name</th>
            <th align="center">Service Number</th> 
            <th align="center">First BP Time</th> 
            <th align="center">Vehicle Number</th>
            <th align="center">Driver1 Details</th> 
            <th align="center">Driver2 Details</th>  
            <th align="center">Attender Details</th> 
            <th align="center">Trip Allocated at</th>  
            <th align="center">Trip Status</th> 
            <th align="center">Occupancy</th> 
            <th align="center">Happy Journey SMS</th> 
            <th align="center">GPS SMS</th> 
            <th align="center">GPS Vendor</th>  
        </tr>
    </thead>
    <tbody class="body_table" >
        {foreach item=row from=$result key=t}
            <tr>     
                <td align="left">{$t+1}</td>      
                <td align="center">{$row->trip_date|date_format:$ns_date_format}</td>
                <td align="left">{$row->schedule_name}, {$row->trip_date|date_format:$ns_time_format}</td>   
                <td align="left">{if $row->service_number} {$row->service_number} {else} - {/if}</td>
                <td align="left" nowrap>{if $row->trip_start_time}{$row->trip_start_time|date_format:$ns_datetime_format}{else} - {/if}</td>
                <td align="left">{$row->registation_number}</td>
                <td align="left">
                    {if $row->driver_name && $row->driver_name != 'NA'}{$row->driver_name}{else} - {/if}
                    {if $row->driver_mobile && $row->driver_mobile != 'NA'}<br/>{$row->driver_mobile}{/if}
                </td>
                <td align="left">
                    {if $row->driver_name2 && $row->driver_name2 != 'NA'}{$row->driver_name2}{else} - {/if}
                    {if $row->driver_mobile2 && $row->driver_mobile2 != 'NA'}<br/>{$row->driver_mobile2}{/if}
                </td>  
                <td align="left">
                    {if $row->attender_name && $row->attender_name != 'NA'}{$row->attender_name}{else} - {/if}
                    {if $row->attender_mobile && $row->attender_mobile != 'NA'}<br/>{$row->attender_mobile}{/if}
                </td>
                <td align="left">{if $row->trip_allocated_time}{$row->trip_allocated_time|date_format:$ns_datetime_format}{else} - {/if}</td> 
                <td align="left">
                    {if $row->trip_status == "TPC"}Closed
                    {elseif $row->trip_status == "TPO"}Open  
                    {elseif $row->trip_status == "TPY"}Yet To Open
                    {elseif $row->trip_status == "TCA"}Cancelled
                    {/if}
                </td>
                <td align="right">{$row->occupancy_count}</td>
                <td align="left">{if $row->notification_status|strstr:'HPYJY'} Yes {else} No {/if}</td>
                <td align="left">{if $row->notification_status|strstr:'GPSTK'} Yes {else} No {/if}</td>
                <td align="left">{$row->gps_vendor_name}</td>
            </tr> 
        {foreachelse} 
            <tr><td colspan="13" align="center">No data available</td><tr>
        {/foreach} 
    </tbody>
</table>