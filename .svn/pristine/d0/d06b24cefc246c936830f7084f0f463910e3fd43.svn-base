<div class="table-responsive">
    <table class="table table-lightborder" id="vehicle-transit-transaction-table">
        <thead>
            <tr class="bold">
                <th>
                    {if $result|count}
                        <input type="checkbox" class="receipt-entry-transaction-checkall">
                    {/if}
                </th>
                <th>Transaction Date</th>
                <th>Hire Challan</th>
                <th>Details</th>
                <th>Amount</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach item=row from=$result}
                {if $row->acknowledgeStatus->code == "REJT" || $row->cashbookType->code != "ADVANCE"}
                    {continue}
                {/if}
                <tr>
                    <td align="left">
                        <input type="checkbox" data-amount="{($row->amount-$row->paidAmount)|abs}" value="{$row->code}" class="vehicle-transit-transaction-checkbox">
                    </td>

                    <td align="left">
                        {$row->transactionAt|date_format:$ns_datetime_format}
                    </td>

                    <td align="left">
                        {$row->transitCargo->aliasCode}
                    </td>

                    <td align="left" width="50%">
                        {$row->transitCargo->name}, {$row->cashbookType->name}, {$row->transactionMode->name} 
                        {if isNotNull($row->paymentByContact->name)}, By : {$row->paymentByContact->name}{/if} {if isNotNull($row->paymentToContact->name)},To : {$row->paymentToContact->name}{/if}{if isNotNull($row->remarks)}, {$row->remarks}{/if}
                    </td>

                    <td align="left">
                        <div class="d-flex justify-space-between align-items-center">
                            <div class="">
                                {($row->amount-$row->paidAmount)|abs|inr_format}
                            </div>
                            &emsp;
                            <input type="number" class="form-control own-vehi-amount w-50 hide" placeholder="amount" value="{($row->amount-$row->paidAmount)|abs}" min="0" max="{$row->amount-$row->paidAmount|abs}" step="0.01" oninput="calculateOwnVehicleAmount(this);">
                        </div>
                    </td>
                </tr>
            {/foreach}
        </tbody>
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

    $('.receipt-entry-transaction-checkall').on('change', function () {
        var $ele = $(this);
        
        $('.vehicle-transit-transaction-checkbox:enabled')
            .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
            .prop('checked', $ele.is(':checked'))
            .trigger('change');
    });

    $('#vehicle-transit-transaction-table .vehicle-transit-transaction-checkbox').on('change', function() {
        var payMode = $('#txn-rcpt-txn-mode').val();
        $('.own-vehi-amount').addClass('hide');
        $('#vehicle-transit-transaction-table .vehicle-transit-transaction-checkbox:checked').each(function(){
            $(this).closest('tr').find('.own-vehi-amount').removeClass('hide');
        });
        calculateOwnVehicleAmount(this);
    });

    function calculateOwnVehicleAmount(ele) {
        let value = parseInt($(ele).closest('tr').find('.own-vehi-amount').val());
        let min = parseInt($(ele).closest('tr').find('.own-vehi-amount').attr('min'));
        let max = parseInt($(ele).closest('tr').find('.own-vehi-amount').attr('max'));
        
        $(ele).closest('tr').find('.own-vehi-amount').val(value);
        if (value < min) $(ele).closest('tr').find('.own-vehi-amount').val(min);
        if (value > max) $(ele).closest('tr').find('.own-vehi-amount').val(max);

        var totalAmount = 0;
        $('#vehicle-transit-transaction-table .vehicle-transit-transaction-checkbox:checked').each(function(){
            var amount = parseInt($(this).closest('tr').find('.own-vehi-amount').val());
            totalAmount = totalAmount + amount;
        });
        $('#receipt-entry-amount').val(totalAmount);
    };
</script>