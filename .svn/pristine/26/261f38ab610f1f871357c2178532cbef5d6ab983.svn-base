<table class="table table-bordered widthed" cellpadding="5" style="width:100%">
    <tr class="success bold">
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
                <td align="left"><span class='warning-text'>{$row->serviceNumber}</span></td>
                <td align="left">{$row->scheduleName}</td>
                <td align="center">
                    <span class='label {$visibility_type[$row->visibilityType]['bg-class']}'>{$visibility_type[$row->visibilityType]['name']}</span>
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
                <td colspan="9" align="center"> No records Found</td>
            </tr>
        {/foreach}
    </tbody>
</table>

<div class="text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportReportDetails()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>

