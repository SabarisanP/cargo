<table width="100%" border="1">
    <tr>
        <td colspan="9" align="center"><span  style="font-weight:bold">Schedule Occupancy Summary</span></td>
    </tr>
    <tr>
        <td colspan="5">
            <span  style="font-weight:bold">Report Date : </span> 
            {$smarty.request.from_date|date_format:$ns_date_format}  to {$smarty.request.to_date|date_format:$ns_date_format}  DOJ </td>
        <td align="right" colspan="4"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
</table>
<br/>
<table border="1">
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <th>S.No</th>
            <th colspan="2">Schedule Name</th>
            <th colspan="2">Total Seat</th>
            <th colspan="2">Booked Seat</th>  
            <th colspan="2">Occupancy(%)</th>
        </tr>
    </thead>
    <tbody>
        {assign var="i" value=1}
        {assign var="tot_seats" value=0}
        {assign var="bo_counnt" value=0}
        {foreach item=row from=$data key=t}
            <tr style="font-weight: bold;">
                <td>{$i++}</td>
                <td colspan="2">{if !empty($row->service_number)}{$row->service_number} - {/if}{$row->trip_name} {$row->trip_date|date_format:$ns_time_format}</td>
                <td colspan="2">{$row->total_seats_count}</td>
                <td colspan="2">{$row->booked_count}</td>
                <td colspan="2">{(($row->booked_count / $row->total_seats_count)*100 )|number_format:2}</td>
            </tr>
            <tr>
                <td></td>
                <td colspan="8">
                    <table border="1">
                        <thead>
                            <tr style="background-color:#bbb; color: #fff;">
                                <th>Route</th>
                                <th>Booked Seat</th>  
                                <th>Occupancy (%)</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach item=stg from=$stage[$row->schedule_code] key=stg_name}
                                <tr>
                                    <td>{$stg_name}</td>
                                    <td>{$stg->booked_count}</td>
                                    <td>{(($stg->booked_count / $row->booked_count)*100 )|number_format:2}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                    <table border="1">
                        <thead>
                            <tr style="background-color:#bbb; color: #fff;">
                                <th>User name</th>
                                <th>Booked Seat</th>  
                                <th>Occupancy (%)</th>
                            </tr>
                        </thead>
                        <tbody>
                            {assign var="k" value=1}
                            {foreach item=usr from=$users[$row->schedule_code] key=usr_name}
                                <tr>
                                    <td>{$usr_name}</td>
                                    <td>{$usr->booked_count}</td>
                                    <td>{(($usr->booked_count / $row->booked_count)*100 )|number_format:2}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr></tr>
            {assign var="tot_seats" value=$tot_seats + $row->total_seats_count}
            {assign var="bo_counnt" value=$bo_counnt + $row->booked_count}
        {/foreach}
    </tbody>    
    <tfoot>
        <tr style="font-weight:bold">
            <td></td>
            <td colspan="2" align="right">Total</td>
            <td colspan="2">{$tot_seats}</td>
            <td colspan="2">{$bo_counnt}</td>
            <td colspan="2">{(($bo_counnt / $tot_seats)*100 )|number_format:2}</td>
        </tr>
    </tfoot>
</table>    

