<table id="txn-rcpt-list-table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th>Receipt No</th>
            <th>Created By</th>
            <th>Receipt Type</th>
            <th>Receipt Details</th>
            <th>Payment Mode</th>
            <th>Payment Details</th>
            <th>Txn Amount</th>
            <th>Balance Amount</th>
            <th>Status</th>
            <th></th>
        </tr>
    </thead>
    <tbody class="body_table" >
        {assign var=txn_trxn_amt value=0}
        {assign var=txn_bal_amt value=0}
        {foreach item=row from=$result key=t}
            <tr>
                <td align="left">{$row->code}</td>
                <td align="left">
                    {$row->user->name}<br>
                    <span class="text-muted small">{$row->receiptDate|date_format:$ns_date_format}</span>
                </td>

                <td>
                    {if $row->receiptEntryType->code == 'OWNVEH'}
                        {$row->busVehicle->registationNumber}<br>
                    {else if $row->receiptEntryType->code == 'STFADV'}
                        {if isNotNull($row->cargoVendor->code)}
                            {$row->cargoVendor->name}
                        {else}
                            {$row->paymentByContact->name}
                        {/if}<br>
                    {else if $row->receiptEntryType->code == 'OTHR'}
                        {$row->paymentByContact->name}<br>
                    {/if}
                    <span class="text-muted">{$row->receiptEntryType->name}</span>
                </td>

                <td align="left" width="200px">
                    {if ($row->transactionCodes|@count) > 0}
                        <a id="popup_msg" data-content='<ul class="p_l_15">
                                {foreach from=$row->transactionCodes item=val}
                                    <li>{$val}</li>
                                {/foreach}
                            </ul>'>
                            {if ($row->transactionCodes|@count) >= 1}{$row->transactionCodes[0]}{/if}
                            {if ($row->transactionCodes|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->transactionCodes|@count}</span>{/if}
                        </a>
                    {else}
                        -
                    {/if}
                </td>

                <td align="left">
                    {$row->transactionMode->name}&nbsp;
                    {if $row->addAttr1 || $row->addAttr2 || $row->addAttr3}
                        <a href="javascript:;" class="popup_msg" data-content="
                        <b>Payment Details</b><br>
                        {$row->addAttr1}<br>
                        {if $row->addAttr2}{$row->addAttr2}<br>{/if}
                        {$row->addAttr3}
                        "><i class="fa fa-info-circle"></i></a>
                    {/if}
                </td>
                
                <td align="left">
                    {if $row->bankDetails->code}
                        {$row->bankDetails->bankName} <br> {$row->bankDetails->branchLocation} <br> {$row->bankDetails->upiId}
                    {elseif $row->chequeDetails->code}
                        {$row->chequeDetails->chequeNo} <br> {$row->chequeDetails->payerDetails} <br> {$row->chequeDetails->chequeDate|date_format:$ns_date_format}
                    {else}
                        -
                    {/if}
                </td>

                <td align="right">{$row->amount|inr_format}</td>
                <td align="right">{($row->amount - $row->paidAmount)|abs|inr_format}</td>
                
                <td align="center">
                    {if $row->acknowledgeStatus->code == 'INIT'}
                        <span class='label label-sm label-primary'>Initiated</span>
                    {elseif $row->acknowledgeStatus->code == 'APRD'}
                        <span class='label label-sm label-success'>Approved</span>
                    {elseif $row->acknowledgeStatus->code == 'REJT'}
                        <span class='label label-sm label-danger'>Rejected</span>
                    {/if}
                </td>

                <td align="center">
                    {if $row->acknowledgeStatus->code == 'INIT'}
                        <a href="javascript:;" class="btn btn-success btn-xs" title="Approve" onclick="updateReceiptEntryStatus('{$row->code}', 'APRD')">Approve</a>
                        <a href="javascript:;" class="btn btn-danger btn-xs" title="Reject"  onclick="updateReceiptEntryStatus('{$row->code}', 'REJT')">Reject</a>
                    {/if}
                </td>
            </tr>
            {assign var=txn_trxn_amt value=$txn_trxn_amt+$row->amount}
            {assign var=txn_bal_amt value=$txn_bal_amt+abs($row->amount - $row->paidAmount)}
        {foreachelse}
            <tr>
                <td colspan="10" align="center">No data available</td>
            </tr>
        {/foreach}
        {if $result|count}
            <tr class="active bold">
                <td colspan="6" align="right">Total</td>
                <td align="right">{$txn_trxn_amt|inr_format}</td>
                <td align="right">{$txn_bal_amt|inr_format}</td>
                <td colspan="2"></td>
            </tr>
        {/if}
    </tbody>
</table>

<script>
    $('[data-toggle="tooltip"]').tooltip({
        html: true
    });

    $('a[id=popup_msg]').attr('data-toggle', 'popover');
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'click'
    });

    $('a[class=popup_msg]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover',
    });
</script>