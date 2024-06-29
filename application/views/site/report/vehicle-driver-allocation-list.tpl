<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Trip Vehicle and Driver Allocation Report</span></td>
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
            <th align="center">Trip Date</th> 
            <th align="center">Schedule Name</th>
            <th align="center">Service No</th> 
            <th align="center">First BP Time</th> 
            <th align="center">Vehicle No</th>
            <th align="center">Driver1</th> 
            <th align="center">Driver2</th>  
            <th align="center">Attender</th>
            <th align="center">Assigned at</th>  
            <th align="center">Trip Status</th> 
            <th align="center">Occupancy</th> 
            <th align="center">HJ SMS</th> 
            <th align="center">GPS SMS</th> 
            <th align="center">GPS Vendor</th>            
        </tr>
    </thead>
    <tbody class="body_table" >
        {foreach item=row from=$result key=t}
            <tr>     
                <td align="center">{$t+1}</td>      
                <td align="left" nowrap>{$row->trip_date|date_format:$ns_date_format}</td>
                <td align="left">{$row->schedule_name}, {$row->trip_date|date_format:$ns_time_format}</td>   
                <td align="left">{if $row->service_number} <span class="warning-text"> {$row->service_number} </span> {else} - {/if}</td>
                <td align="left" nowrap>{if $row->trip_start_time}{$row->trip_start_time|date_format:$ns_datetime_format}{else} - {/if}</td>
                <td align="left">{if $row->registation_number}{$row->registation_number}{else} - {/if}</td> 
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
                <td align="left" nowrap>{if $row->trip_allocated_time}{$row->trip_allocated_time|date_format:$ns_datetime_format}{else} - {/if}</td> 
                <td align="left">
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
