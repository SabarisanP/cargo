<div class="table-responsive">
    <table class="table table-bordered-light">
        <thead>
            <tr class="success">                    
                <th>Inv. Ack. No</th>
                <th>Name</th>
                <th>User</th>
                <th>Transaction Date</th>
                <th>Branch</th>
                <th>Vendor</th>
                <th>Supervisor</th>
                <th>Invoice Details</th>
                <th>Contact Mode</th>
                <th>Status</th>
                <th>Remarks</th>
                <td></td>
            </tr>
        </thead>
        <tbody>
            {foreach item=row from=$result}
                <tr>                        
                    <td align='left'>{$row->code}</td>
                    <td align='left'>{$row->name}</td>
                    <td align='left'>{$row->createdUser->name}</td>
                    <td align='left'>{$row->transactionDate|date_format:$ns_date_format|default:'-'}</td>
                    <td align='left'>{$row->organization->name}</td>
                    <td align='left'>{$row->vendor->companyName}</td>
                    <td align='left'>{$row->supervisor->name}</td>

                    <td align='left'>
                        <a data-toggle="popover" id="popup_msg"  data-content='<ul class="p_l_15">
                                {foreach from=$row->invoiceList item=inv}
                                    <li>{$inv->code}</li>
                                {/foreach}
                            </ul>'>
                            {if ($row->invoiceList|@count) >= 1}{$row->invoiceList[0]->code}{/if}
                            {if ($row->invoiceList|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->invoiceList|@count}</span>{/if}
                        </a>
                    </td>

                    <td align='left'>{if isNotNull($row->communicationMedium->code)}{$row->communicationMedium->name}{else}-{/if}</td>

                    <td align='left'>
                        {if $row->status->code == 'CRT'}
                            <span class="badge badge-primary">{$row->status->name}</span>
                        {elseif $row->status->code == 'SBMT'}
                            <span class="badge badge-info">{$row->status->name}</span>
                        {elseif $row->status->code == 'PMRC'}
                            <span class="badge badge-success">{$row->status->name}</span>
                        {elseif $row->status->code == 'CMPLT'}
                            <span class="badge badge-Secondary">{$row->status->name}</span>
                            {if isNotNull($row->completedAt)}
                                <i class="fa fa-info-circle" data-toggle="popover" data-content="Completed Date: {$row->completedAt|date_format:$ns_datetime_format}"></i>
                            {/if}
                        {elseif $row->status->code == 'MSNG'}
                            <span class="badge badge-danger">{$row->status->name}</span>
                        {else}
                            <span class="badge badge-warning">{$row->status->name}</span>
                        {/if}
                    </td>
                    
                    <td align='left'>{if isNotNull($row->remarks)}{$row->remarks}{else}-{/if}</td>
                    
                    <td align='center'>
                        {if $row->imageCount > 0}
                            <div class="btn-group btn-group-xs">
                                <a href="javascript:;" onclick="showPRGallery('{$row->code}')"><i class="fa fa-picture-o" aria-hidden="true"></i></a>
                            </div>&nbsp;
                        {/if}
                        {if $row->status->code != 'CNCL' && $row->status->code != 'CMPLT'}
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
    var AllInvoiceAckdData = {$result|json_encode}
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
