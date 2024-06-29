<style type="text/css" media="print">
@media print { 
    body {
       -webkit-print-color-adjust: exact; 
     }
    @page {
                size: A4 landscape;
                counter-increment: page;
            }

            table {
            border-collapse: collapse;
        }

        table thead th,
        table thead td {
            font-weight: bold;
        }

        table.bordered th,
        table.bordered td {
            border: .1px solid #000;
        }

        div.print-border {
            position: fixed;
            bottom: 0px;
            left: 0px;
            border: 1px solid black;
            border-top:none;
            width: 100%;
            background-color:black;
        }

        div.print-border-top {
            position: fixed;
            top: 0px;
            left: 0px;
            right:0px;
            border: 1px solid black;
            border-top:none;
            width: 100%;
            background-color:black;
        }

        div.print-border-left {
            position: fixed;
            top: 0px;
            height: 100%;
            width: 0;
            left:0;
            border: 1px solid black;
            border-right: none;
            background-color: black ;
            z-index: 100;
        }

        div.print-border-right{
            position: fixed;
            top: 0px;
            height: 100%;
            width: 0;
            left:99.8%;
            border: 1px solid black;
            border-right: none;
            background-color: black ;
            z-index: 100;
        }
}


</style>
<div class="print-border-top"></div>
<div class="print-border"></div>
<div class="print-border-left"></div>
<div class="print-border-right"></div>
<table class="bordered" cellpadding="" width="100%" style="table-layout:auto;">
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
                    <td align="left" >{$row->cargo_code}</td>
                    <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row->net_payable}</td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{if isset($row->transaction_receipt_code)}{$row->transaction_receipt_code} / {$row->receipt_transaction_date}{/if}</td>
                    <td align="left" >{if isset($row->voucher_number)} {$row->voucher_number} / {$row->voucher_transaction_date} {/if}</td>
                    <td align="left" > {if isset($row->invoice_number)}{$row->invoice_number} / {$row->invoice_date} {/if}</td>
                    <td align="left"></td>
                </tr>
            {/foreach}
        {/foreach}
    </tbody>
</table>
<br><br>
<table class="bordered" cellpadding="" width="100%" style="table-layout:auto;">
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

<script>
window.print();
</script>