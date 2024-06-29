<div class="table-responsive">
    <table class="table table-bordered-light">
        <thead>
            <tr class="success">                    
                <th>Del. Ack. No</th>
                <th>Name</th>
                <th>User</th>
                <th>Transaction Date</th>
                <th>Branch</th>
                <th>Supervisor</th>
                <th>Cargo Details</th>
                <th>Status</th>

                <th>Vehicle Details</th>
                <th>Driver Details</th>
                <th>Remarks</th>
                <td></td>
            </tr>
        </thead>
        <tbody>
            {foreach item=row from=$result}
                <tr>
                    <td align='left'>
                        <a href="javascript:;" onclick="showacknowledgementPdfDialog('{$row->code}');">{$row->code}</a>
                    </td>
                    <td align='left'>{$row->name}</td>
                    <td align='left'>{$row->createdUser->name}</td>
                    <td align='left'>{$row->transactionDate|date_format:$ns_date_format|default:'-'}</td>

                    <td align='left'>{$row->fromOrganization->name} - {$row->toOrganization->name}</td>
                    <td align='left'>{$row->supervisor->name}</td>

                    <td align='left'>
                        <a data-toggle="popover" id="popup_msg" data-content='<ul class="p_l_15">
                                {foreach from=$row->cargoList item=lr}
                                    <li>{$lr->code}</li>
                                {/foreach}
                            </ul>'>
                            {if ($row->cargoList|@count) >= 1}{$row->cargoList[0]->code}{/if}
                            {if ($row->cargoList|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->cargoList|@count}</span>{/if}
                        </a>
                    </td>

                    <td align='left'>
                        {if $row->status->code == 'INIT'}
                            <span class="badge badge-primary">{$delivery_acknowledgement_status[$row->status->code]}</span>
                        {elseif $row->status->code == 'SENT'}
                            <span class="badge badge-info">{$delivery_acknowledgement_status[$row->status->code]}</span>
                        {elseif $row->status->code == 'RCVD'}
                            <span class="badge badge-success">{$delivery_acknowledgement_status[$row->status->code]}</span>
                            {if isNotNull($row->receivedAt)}
                                <i class="fa fa-info-circle" data-toggle="popover" data-content="Received Date: {$row->receivedAt|date_format:$ns_datetime_format}"></i>
                            {/if}
                        {elseif $row->status->code == 'MSNG'}
                            <span class="badge badge-danger">{$delivery_acknowledgement_status[$row->status->code]}</span>
                        {else}
                            <span class="badge badge-warning">{$delivery_acknowledgement_status[$row->status->code]}</span>
                        {/if}
                    </td>

                    <td align='left'>
                        {$row->vehicle->registationNumber}<br>
                        <span class="text-muted">{$row->vehicle->name}</span>
                    </td>

                    <td align='left'>
                        {$row->driver->name}<br>
                        <span class="text-muted">{$row->driver->mobileNumber}</span>
                    </td>
                    
                    <td align='left'>{if isNotNull($row->remarks)}{$row->remarks}{else}-{/if}</td>
                    
                    <td align='center'>
                        {if $row->status->code != 'CNCL' && $row->status->code != 'RCVD'}
                            <div class="btn-group btn-group-xs">
                                <a href="javascript:;" class="" title="Edit Status" onclick="editStatusDialog('{$row->code}', '{$row->status->code}')"><i class="fa fa-check-square-o fa-lg "></i></a>
                            </div>
                        {/if}
                    </td>
                </tr>
            {foreachelse}
                <tr class="active">
                    <td align="center" colspan="12">No data found !!!</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
<script>
    $('a[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'click'
    });

    $('i[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
</script>
