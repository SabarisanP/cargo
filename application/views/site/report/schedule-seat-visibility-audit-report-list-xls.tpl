<table border='1'>
    <tr>
        <td  colspan="6" align="center"><b>Schedule Seat Visibility Audit Report</b></td>
    </tr>
    <tr>
        <td colspan="3">Report Date : {$smarty.request.travelDate|date_format:$ns_date_format}</td>
        <td colspan="3" >Report At : {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3">&nbsp;</td>
        <td colspan="3" ><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>    
<br/>
<table class="table table-bordered widthed" border='1' cellpadding="5">
    <tr style="font-weight:bold; background-color:#64b92a; color: #fff;">
        <th>Updated Date</th>
        <th>Service Number</th>
        <th>Schedule Name</th>
        <th>Visibility Type</th>
        <th>Route / User / Group</th>
        <th>Bus Type</th>
        <th style="width:15%">Seats</th>
        <th>Updated By</th>
        <th>Remarks</th>
    </tr>
    <tbody>
        {foreach name=o item=row from=$reports}
            <tr>  
                <td align="left">{$row->updatedAt|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->serviceNumber}</td>
                <td align="left">{$row->scheduleName}</td>
                <td align="center">
                    {$visibility_type[$row->visibilityType]['name']}
                </td>
                <td align="left" style="width:15%">
                    {if $row->roleType == 'UR'}
                        {if $row->userNames =='' }All User{else}{$row->userNames} (U) {/if}
                    {elseif $row->roleType == 'GR'}
                        {if $row->groupNames =='' }All Group{else}{$row->groupNames} (G) {/if}
                    {else}
                        {if $row->routes =='' }All Routes{else}{$row->routes} (R) {/if}
                    {/if}
                </td>
                <td align="left">{$row->busType}</td>
                <td align="left" style="width:15%">{$row->seatNames}</td>
                <td align="left">{$row->updatedBy}</td>
                <td align="left">{if $row->remarks ==""}-{else}{$row->remarks}{/if}</td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="9" align="center"> No records Found</td></tr>
            {/foreach}
    </tbody>
</table>

