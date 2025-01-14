<table id="txn-rcpt-list-table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th align="center">Receipt No</th>
            <th align="center">Created By</th>
            <th align="center">Customer / Vendor</th>
            <th align="center">Receipt Details</th>

            <th align="center">Payment Mode</th>
            <th align="center">Payment Details</th>

            <th align="center">Received Date</th>

            <th class="text-center">Txn Amount <br/>(A)</th>
            <th class="text-center">Charges <br/>(B)</th>
            <th class="text-center">TDS Amount <br/>(C)</th>
            <th class="text-center">Total Amount <br/>(D = A+B)</th>
            {if $receiptStatus == 'INIT'}<th></th>{/if}
        </tr>
    </thead>
    <tbody class="body_table" >
        {assign var=txn_trxn_amt value=0}
        {assign var=txn_charges value=0}
        {assign var=txn_tds_amt value=0}
        {assign var=txn_total_amt value=0}
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
                    {if $row->cargoCustomer->code}
                        <span title="{$row->cargoCustomer->name}">{$row->cargoCustomer->name|truncate:25:"..":true}</span>
                    {elseif $row->cargoVendor->code}
                        <span title="{$row->cargoVendor->companyName}">{$row->cargoVendor->companyName|truncate:25:"..":true}</span>
                    {/if} <br>
                    <span class="text-muted small">{$row->transactionReceiptType->name}</span>
                </td>
                <td align="left" width="200px">
                    {if ($row->cargoBookings|@count) > 0}
                        <a id="popup_msg"  data-content='<ul class="p_l_15">
                                {foreach from=$row->cargoBookings item=lr}
                                    <li>{$lr->code}</li>
                                {/foreach}
                            </ul>'>
                            {if ($row->cargoBookings|@count) >= 1}{$row->cargoBookings[0]->code}{/if}
                            {if ($row->cargoBookings|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->cargoBookings|@count}</span>{/if}
                        </a>
                    {elseif ($row->paymentTransactions|@count) > 0}
                        <a id="popup_msg"  data-content='<ul class="p_l_15">
                                {foreach from=$row->paymentTransactions item=inv}
                                    <li>{$inv->code}</li>
                                {/foreach}
                            </ul>'>
                            {if ($row->paymentTransactions|@count) >= 1}{$row->paymentTransactions[0]->code}{/if}
                            {if ($row->paymentTransactions|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->paymentTransactions|@count}</span>{/if}
                        </a>
                    {/if}
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

                <td align="right">
                    {$row->transactionAmount|inr_format}
                    {if $row->paymentTransactions[0]->additionalAttributes}
                        <span data-toggle="tooltip" title="
                            {foreach from=$row->paymentTransactions item=inv}
                                {if $inv->additionalAttributes}
                                    {assign var=additionalAttributes value="|"|explode:$inv->additionalAttributes->ADV}
                                    {$additionalAttributes|implode:'<br>'}
                                {/if}
                            {/foreach}
                        "><i class="fa fa-info-circle"></i></span>
                    {/if}
                </td>
                {assign var="charges" value=($row->machineHandlingCharge + $row->demurrageCharge)}
                <td align="right">{$charges|inr_format} <span title="Machine Handling : {$row->machineHandlingCharge}<br/>Demurrage : {$row->demurrageCharge}" data-toggle="tooltip"><i class="fa fa-info-circle"></i></span></td>
                <td align="right">{$row->tdsAmount|inr_format}</td>
                <td align="right">{($row->transactionAmount+$charges)|inr_format}</td>
                {if $receiptStatus == 'INIT'}
                <td align="center">
                    <a href="javascript:;" class="btn btn-success btn-xs" title="Approve" onclick="approveTransactionReceipt('{$row->code}')">Approve</a>
                    <a href="javascript:;" class="btn btn-danger btn-xs" title="Reject"  onclick="rejectTransactionReceipt('{$row->code}')">Reject</a>
                </td>
                {/if}
            </tr>
            {assign var=txn_trxn_amt value=$txn_trxn_amt+$row->transactionAmount}
            {assign var=txn_charges value=$txn_charges+$charges}
            {assign var=txn_tds_amt value=$txn_tds_amt+$row->tdsAmount}
            {assign var=txn_total_amt value=$txn_total_amt+$row->transactionAmount+$charges}
        {foreachelse}
            <tr>
                <td colspan="{if $receiptStatus == 'INIT'}12{else}11{/if}" align="center">No data available</td>
            </tr>
        {/foreach}
        {if $result|count}
            <tr class="active bold">
                <td colspan="7" align="right">Total</td>
                <td align="right">{$txn_trxn_amt|inr_format}</td>
                <td align="right">{$txn_charges|inr_format}</td>
                <td align="right">{$txn_tds_amt|inr_format}</td>
                <td align="right">{$txn_total_amt|inr_format}</td>
                {if $receiptStatus == 'INIT'}<td></td>{/if}
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