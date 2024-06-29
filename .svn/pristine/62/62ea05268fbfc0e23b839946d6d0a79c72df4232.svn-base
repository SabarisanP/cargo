<table id="txn-rcpt-list-table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th align="center">Receipt No</th>
            <th align="center">Created By</th>
            <th align="center">Advance Payment Type</th>
            <th align="center">Payment Mode</th>
            <th align="center">Payment Details</th>
            <th align="center">Received Date</th>
            <th class="text-center">Amount</th>
        </tr>
    </thead>
    <tbody class="body_table" >
        {assign var=txn_trxn_amt value=0}
        {foreach item=row from=$result key=t}
            <tr>
                <td align="left">
                    {if $row->transactionReceiptType->code == "LR" && $namespace == "seenutransports"}
                        <a href="javascript:;" onclick="showTransactionReceiptPdfDialog('{$row->code}');">{$row->code}</a>
                    {else}
                        {$row->code}
                    {/if}
                </td>
                <td align="left">
                    {$row->createdUser->name}<br>
                    <span class="text-muted small">{$row->transactionDate|date_format:$ns_date_format}</span>
                </td>
                <td align="left" nowrap>
                    {if $row->receiptReferenceType->code == "DVR"}
                        <span title="{$row->driver->name}">{$row->driver->name|truncate:25:"..":true}</span>
                    {elseif $row->receiptReferenceType->code == "USR"}
                        <span title="{$row->user->name}">{$row->user->name|truncate:25:"..":true}</span>
                    {elseif $row->receiptReferenceType->code == "BSTF"}
                        <span title="{$row->organizationContact->name}">{$row->organizationContact->name|truncate:25:"..":true}</span>
                    {/if} <br>
                    <span class="text-muted small">{$row->receiptReferenceType->name}</span>
                </td>

                <td align="left">
                    {$row->transactionMode->name}&nbsp;
                    {if $row->addAttr1 || $row->addAttr2 || $row->addAttr3}
                        <a href="javascript:;" class="popup_msg" data-content="
                        <b>Customer Payment Details</b><br>
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

                <td align="center">{$row->amountReceivedDate|date_format:$ns_date_format}</td>

                <td align="right">{$row->transactionAmount|inr_format}</td>
            </tr>
            {assign var=txn_trxn_amt value=$txn_trxn_amt+$row->transactionAmount}
        {foreachelse}
            <tr>
                <td colspan="11" align="center">No data available</td>
            </tr>
        {/foreach}
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