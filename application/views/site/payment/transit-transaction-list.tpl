{* <h5 class="bold">Income / Expense Details entered as on {$smarty.request.fromDate|date_format:'%A %d-%b-%Y'}</h5> *}

{if $paymentType == 'TRANSPORTER'}
    <h5>Summary</h5>
    <table class="table table-lightborder" style="width: 30%;">
        <tbody>
            <tr>
                <th>Hire Amount (A)</th>
                <td align="right">{$hire_amount|inr_format}</td>
            </tr>
            <tr>
                <th>Fuel Expense (B)</th>
                <td align="right">{$fuel_expense|inr_format}</td>
            </tr>
            <tr>
                <th>Advance Amount (C)</th>
                <td align="right">{$advance_amount|inr_format}</td>
            </tr>

            <tr>
                <th>Payable (A-B-C)</th>
                <td align="right" class="bold">{($hire_amount-$fuel_expense-$advance_amount)|inr_format}</td>
            </tr>
        </tbody>
    </table>
{/if}
<div class="table-responsive">
    <table class="table table-lightborder" id="paymnet-table">
        <thead>
            <tr class="bold">
                <th>
                    {if $result|count}
                        <input type="checkbox" class="payment_transaction_checkall">
                    {/if}
                </th>
                <th>Transaction Date</th>
                <th>Details</th>
                <th>Debit Amount</th>
                <th>Credit Amount</th>
                <th>Balance</th>
            </tr>
        </thead>
        <tbody class="body_table">
            <tr>
                <td></td>
                <td align="left">
                    {$transactionDate|date_format:$ns_datetime_format}
                </td>

                <td>Opening Balance</td>
                <td>-</td>
                <td>-</td>
                <td>0.00</td>
            </tr>
            {$balance = 0}
            {foreach item=row from=$result}
                {if $row->acknowledgeStatus->code == "REJT"}
                    {continue}
                {/if}
                <tr>
                    <td align="left">
                        <input type="checkbox" data-amount="{($row->amount-$row->paidAmount)|abs}" data-paymenttype="{$paymentType}" data-cashbooktype="{$row->cashbookType->code}" data-sourcetype="{$row->sourceType->code}" value="{$row->code}" class="makepayment-entry">
                    </td>

                    <td align="left">
                        {$row->transactionAt|date_format:$ns_datetime_format}
                    </td>

                    <td align="left" width="60%">
                        {$row->transitCargo->name}, {$row->cashbookType->name}, {$row->transactionMode->name} 
                        {if isNotNull($row->paymentByContact->name)}, By : {$row->paymentByContact->name}{/if} {if isNotNull($row->paymentToContact->name)},To : {$row->paymentToContact->name}{/if}{if isNotNull($row->remarks)}, {$row->remarks}{/if}
                    </td>

                    <td align="left">
                        {if $row->cashbookType->code != 'HIRING' && $paymentType == 'TRANSPORTER'}
                            {$balance = $balance + abs($row->amount-$row->paidAmount)}
                            {($row->amount-$row->paidAmount)|abs|inr_format}
                        {elseif $row->cashbookType->code != 'FUEL' && $paymentType == 'FUEL'}
                            {$balance = $balance + abs($row->amount-$row->paidAmount)}
                            {($row->amount-$row->paidAmount)|abs|inr_format}
                        {/if}
                    </td>

                    <td align="left">
                        {if $row->cashbookType->code == 'HIRING' && $paymentType == 'TRANSPORTER'}
                            {$balance = $balance - abs($row->amount-$row->paidAmount)}
                            {($row->amount-$row->paidAmount)|abs|inr_format}
                        {elseif $row->cashbookType->code == 'FUEL' && $paymentType == 'FUEL'}
                            {$balance = $balance - abs($row->amount-$row->paidAmount)}
                            {($row->amount-$row->paidAmount)|abs|inr_format}
                        {elseif $row->sourceType->code == 'JRNL'}
                            {$balance = $balance - abs($row->amount-$row->paidAmount)}
                            {($row->amount-$row->paidAmount)|abs|inr_format}
                        {/if}
                    </td>
                    
                    <td align="left">
                        {* {$balance|inr_format} *}
                        <div class="d-flex justify-space-between align-items-center">
                            <div class="">
                                {$balance|inr_format}
                            </div>
                            &emsp;
                            <input type="number" class="form-control make-payment-amount w-50 hide" placeholder="amount" value="{($row->amount-$row->paidAmount)|abs}" min="0" max="{$row->amount-$row->paidAmount|abs}" step="0.01" oninput="calculateMakePaymentAmount(this);">
                        </div>
                    </td>
                </tr>
            {/foreach}
        </tbody>
        {if $balance != 0}
            <tfoot>
                <tr>
                    <td colspan="6">
                        <button class="btn btn-success btn-xs pull-right hide" id="make-payment-btn" onclick="manageExpensePaymentDialog('{$smarty.request.cashbookTypeCode}', '{$smarty.request.vehicleCode}', '{$smarty.request.contactCode}')">Make Payment</button>
                    </td>
                </tr>
            </tfoot>
        {/if}
    </table>
</div>

<script>
    var paymentTransactions = {$result|json_encode};
    $('[data-toggle="tooltip"]').tooltip({
        html: true
    });

    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });

    $('.payment_transaction_checkall').on('change', function () {
        var $ele = $(this);
        
        $('.makepayment-entry:enabled')
            .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
            .prop('checked', $ele.is(':checked'))
            .trigger('change');
    });

    $('.makepayment-entry').on('change', function() {
        $('#make-payment-btn').addClass('hide');
        if ($('#paymnet-table .makepayment-entry:checked').length > 0) {
            $('#make-payment-btn').removeClass('hide');
        }

        $('.make-payment-amount').addClass('hide');
        $('#paymnet-table .makepayment-entry:checked').each(function(){
            $(this).closest('tr').find('.make-payment-amount').removeClass('hide');
        });
        calculateMakePaymentAmount(this);
    })

    function calculateMakePaymentAmount(ele) {
        let value = parseInt($(ele).closest('tr').find('.make-payment-amount').val());
        let min = parseInt($(ele).closest('tr').find('.make-payment-amount').attr('min'));
        let max = parseInt($(ele).closest('tr').find('.make-payment-amount').attr('max'));
        
        $(ele).closest('tr').find('.make-payment-amount').val(value);
        if (value < min) $(ele).closest('tr').find('.make-payment-amount').val(min);
        if (value > max) $(ele).closest('tr').find('.make-payment-amount').val(max);

        var totalAmount = 0;
        $('#paymnet-table .makepayment-entry:checked').each(function(){
            var amount = parseInt($(this).closest('tr').find('.make-payment-amount').val());
            totalAmount = totalAmount + amount;
        });
        $('#receipt-entry-amount').val(totalAmount);
    };
</script>