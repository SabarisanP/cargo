<table id="receipt-entry-transaction-receipt-table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th>
                {if $result|count}
                    <input type="checkbox" class="receipt-entry-transaction-checkall">
                {/if}
            </th>
            <th align="center">Receipt No</th>
            <th align="center">Created By</th>
            <th align="center">Advance Payment Type</th>
            <th align="center">Payment Mode</th>
            <th align="center">Payment Details</th>
            <th align="center">Received Date</th>
            <th class="text-center">Amount</th>
            <th class="text-center">Payable Amount</th>
        </tr>
    </thead>
    <tbody class="body_table" >
        {assign var=txn_trxn_amt value=0}
        {foreach item=row from=$result key=t}
            {if $row->transactionAmount == $row->partialAmount}
                {continue}
            {/if}
            <tr>
                <td>
                    <input type="checkbox" data-amount="{($row->transactionAmount-$row->partialAmount)|abs}" value="{$row->code}" class="receipt-entry-transaction-checkbox">
                </td>
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
                    {if $row->receiptReferenceType->code == "VDR"}
                        <span title="{$row->cargoVendor->name}">{$row->cargoVendor->name}</span>
                    {elseif $row->receiptReferenceType->code == "DVR"}
                        <span title="{$row->driver->name}">{$row->driver->name}</span>
                    {elseif $row->receiptReferenceType->code == "USR"}
                        <span title="{$row->user->name}">{$row->user->name}</span>
                    {elseif $row->receiptReferenceType->code == "BSTF"}
                        <span title="{$row->organizationContact->name}">{$row->organizationContact->name}</span>
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
                <td align="right">
                    <div class="d-flex justify-space-between align-items-center">
                        <div class="">
                            {($row->transactionAmount-$row->partialAmount)|abs|inr_format}
                        </div>
                        &emsp;
                        <input type="number" class="form-control adv-pay-amount w-50 hide" placeholder="amount" value="{($row->transactionAmount-$row->partialAmount)|abs}" min="0" max="{$row->transactionAmount-$row->partialAmount|abs}" step="0.01" oninput="calculateAdvancePaymentAmount(this);">
                    </div>
                </td>
            </tr>
            {assign var=txn_trxn_amt value=$txn_trxn_amt+$row->transactionAmount}
        {foreachelse}
            <tr>
                <td colspan="9" align="center">No data available</td>
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

    $('.receipt-entry-transaction-checkall').on('change', function () {
        var $ele = $(this);
        
        $('.receipt-entry-transaction-checkbox:enabled')
            .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
            .prop('checked', $ele.is(':checked'))
            .trigger('change');
    });

    $('#receipt-entry-transaction-receipt-table .receipt-entry-transaction-checkbox').on('change', function() {
        var payMode = $('#txn-rcpt-txn-mode').val();
        $('.adv-pay-amount').addClass('hide');
        $('#receipt-entry-transaction-receipt-table .receipt-entry-transaction-checkbox:checked').each(function(){
            $(this).closest('tr').find('.adv-pay-amount').removeClass('hide');
        });
        calculateAdvancePaymentAmount(this);
    });

    function calculateAdvancePaymentAmount(ele) {
        let value = parseInt($(ele).closest('tr').find('.adv-pay-amount').val());
        let min = parseInt($(ele).closest('tr').find('.adv-pay-amount').attr('min'));
        let max = parseInt($(ele).closest('tr').find('.adv-pay-amount').attr('max'));
        
        $(ele).closest('tr').find('.adv-pay-amount').val(value);
        if (value < min) $(ele).closest('tr').find('.adv-pay-amount').val(min);
        if (value > max) $(ele).closest('tr').find('.adv-pay-amount').val(max);

        var totalAmount = 0;
        $('#receipt-entry-transaction-receipt-table .receipt-entry-transaction-checkbox:checked').each(function(){
            var amount = parseInt($(this).closest('tr').find('.adv-pay-amount').val());
            totalAmount = totalAmount + amount;
        });
        $('#receipt-entry-amount').val(totalAmount);
    };
</script>