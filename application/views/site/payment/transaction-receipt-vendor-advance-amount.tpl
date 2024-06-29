<table class="table table-bordered" width="98%" id="txn-rcpt-adv-pay-table">
    <thead>
        <tr class="success">
            <td align="center" class="sticky-row-top"></td>
            <td align="center" class="sticky-row-top">PaymentRecordNo</td>
            <td align="center" class="sticky-row-top">Invoice No</td>
            <td align="center" class="sticky-row-top">Date</td>
            <td align="center" class="sticky-row-top">Transaction Mode</td>
            <td align="center" class="sticky-row-top">Advance Amount</td>
            <td align="center" class="sticky-row-top">Amount</td>
        </tr>
    </thead>
   
    <tbody class="body_table">
        {foreach item=row from=$result key=key}
            <tr data-amount="{$row->partialAmount}" data-invoicecode="{$row->code}" data-rowcode="{$respcode}" >
            <td align="center">
            <input type="checkbox" class="adv-pay-check adv-pay-check{$row->code}" value="{$row->code}" data-amount="{$row->partialAmount}" onclick="calculateTotalAdvanceAmount(this,'{$row->code}');">
            </td>
            <td  align="center" nowrap>#{$row->code}</td>
            <td  align="center" nowrap>{$respcode}</td>
                <td align="left" nowrap>{$row->transactionDate|date_format:$ns_date_format}</td>
                <td align="left">{$transactionmode[$row->transactionMode->code]}</td>
                <td class="advance-amount{$row->code}" align="right"></td>
                <td align="left">
                    <input type="number" max="{$row->partialAmount}" class="form-control adv-amount-deducted adv-amount-deducted{$row->code}" disabled oninput="amountvalidate(this)" step="1">

                </td>
            </tr>
            
            <script>
            let partialAmount = {$row->partialAmount};
            let invCode = "{$row->code}"; 
            let isAmount = localStorage.getItem(invCode);
            if (isAmount == null) {
                localStorage.setItem(invCode, partialAmount);
            }
            // localStorage.setItem(invCode, partialAmount);
            // console.log(partialAmount);
            $('.advance-amount'+invCode).text(localStorage.getItem(invCode));

        </script>
            
        {foreachelse}
            <tr class="active">
                <td align="center" colspan="5">No data found</td>
            </tr>
        {/foreach}
    </tbody>
   
</table>
        