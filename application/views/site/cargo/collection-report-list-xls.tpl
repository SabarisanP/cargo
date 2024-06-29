
<br><br>

<table border='1'>
    <thead>
        <tr style="background-color: #ffff00; color: #000000;">
            <td align="center">S.no</td>
            <td align="center">Payment type</td>
            <td align="center">Customer Name</td>
            <td align="center">Lr No</td>
            <td align="center">Lr Date </td>
            <td align="center">Lr Amount</td>
            <td align="center">From</td>
            <td align="center">To</td>
            <td align="center">Cr No / date</td>
            <td align="center">Invoice No/ Date</td>
            <td align="center">Voucher no / Date</td>
            <td align="center">Remarks</td>
        </tr>
    </thead>
    <tbody>

        {assign var=tot_items value=0}
        {assign var=s_no value=0}
        {foreach item=value from=$result key=key} 
            {foreach item=row from=$value key=t}
                {assign var=s_no value=$s_no+1}
                <tr>
                    <td align="center">{$s_no}</td>
                    <td align="left"> {$row->payment_status_code|_cargo_payment_status_badge}</td>
                    <td align="left">
                        {if $row->payment_status_code == 'PAD'}
                            {$row->from_customer_name}
                        {else if $row->payment_status_code == 'TOP'}
                            {$row->to_customer_name}
                        {else}
                            {$row->from_customer_name}
                        {/if}
                    </td>
                    <td align="left">{$row->cargo_code}</td>
                    <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row->net_payable}</td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{if isset($row->transaction_receipt_code)}{$row->transaction_receipt_code} / {$row->receipt_transaction_date}{/if}</td>
                    <td align="left">{if isset($row->voucher_number)} {$row->voucher_number} / {$row->voucher_transaction_date} {/if}</td>
                    <td align="left"> {if isset($row->invoice_number)}{$row->invoice_number} / {$row->invoice_date} {/if}</td>
                    <td align="left"></td>
                </tr>
            {/foreach}
        {/foreach}
    </tbody>
</table>
<br><br>
<table border='1'>
    <thead>
        <tr style="background-color: #ffff00; color: #000000;">
            <td align="center" colspan="3">Summary</td>
        </tr>
        <tr style="background-color: #ffff00; color: #000000;">
            <td align="center">TYPE</td>
            <td align="center">COUNT</td>
            <td align="center">AMOUNT</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td align="center">Topay By Cash</td>
            <td align="center">{$topay_cash_lr}</td>
            <td align="center">{$topay_cash_amount}</td>
        </tr>
        <tr>
            <td align="center">Topay By Cheque</td>
            <td align="center">{$topay_check_lr}</td>
            <td align="center">{$topay_check_amount}</td>
        </tr>
        <tr>
            <td align="center">Topay By Net Banking</td>
            <td align="center">{$topay_bank_lr}</td>
            <td align="center">{$topay_bank_amount}</td>
        </tr>
        <tr>
            <td align="center">Paid By Cash</td>
            <td align="center">{$paid_cash_lr}</td>
            <td align="center">{$paid_cash_amount}</td>
        </tr>
        <tr>
            <td align="center">Paid By Cheque</td>
            <td align="center">{$paid_check_lr}</td>
            <td align="center">{$paid_check_amount}</td>
        </tr>
        <tr>
            <td align="center">Paid By Net Banking</td>
            <td align="center">{$paid_bank_lr}</td>
            <td align="center">{$paid_bank_amount}</td>
        </tr>
        <tr>
            <td align="center">Invoice Received By Cash</td>
            <td align="center">{$Account_cash_lr}</td>
            <td align="center">{$Account_cash_amount}</td>
        </tr>
        <tr>
            <td align="center">Invoice Received By Cheque</td>
            <td align="center">{$Account_check_lr}</td>
            <td align="center">{$Account_check_amount}</td>
        </tr>
        <tr>
            <td align="center">Invoice Received Net Banking</td>
            <td align="center">{$Account_bank_lr}</td>
            <td align="center">{$Account_bank_amount}</td>
        </tr>
        <tr>
            <td align="center"><b>Total</b></td>
            <td align="center">{($topay_cash_lr+$topay_check_lr+$topay_bank_lr+$paid_cash_lr+$paid_check_lr+$paid_bank_lr+$Account_cash_lr+$Account_check_lr+$Account_bank_lr)}</td>
            <td align="center">{($Account_bank_amount+$Account_check_amount+$Account_cash_amount+$paid_bank_amount+$paid_check_amount+$paid_cash_amount+$topay_cash_amount+$topay_check_amount+$topay_bank_amount)}</td>
        </tr>
    </tbody>
</table>