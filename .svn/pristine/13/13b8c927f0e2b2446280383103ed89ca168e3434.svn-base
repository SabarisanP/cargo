<div class="table-responsive">
    <table id="branch_receipt_tab" class="table table-bordered" border="1" width="100%">
        <thead>
            <tr style="background-color: #64b92a; color: #000;">
                <th class="text-center" nowrap>Code</th>
                <th class="text-center" nowrap>Branch</th>
                <th class="text-center" nowrap>Opening bal<br>(A)</th>
                <th class="text-center" nowrap>Paid Bk<br>(B)</th>
                <th class="text-center" nowrap>ToPay Deli<br>(C)</th>
                <th class="text-center" nowrap>O Income<br>(D)</th>
                <th class="text-center" nowrap>Exp<br>(E)</th>
                <th class="text-center" nowrap>Comm<br>(F)</th>
                <th class="text-center" nowrap>Revert<br>(G)</th>
                <th class="text-center" nowrap>Total<br>(H=B+C+D-E-F-G)</th>
                <th class="text-center" nowrap>Settlement<br>(I=A+H)</th>
                {if $paymentAcknowledgeStatus == 'NA'}
                    <th class="text-center" nowrap>Paid</th>
                    <th class="text-center" nowrap>Payable</th>
                {else}
                    <th class="text-center" nowrap>
                        {if $paymentAcknowledgeStatus == 'ACKED'}
                            Paid
                        {else}
                            Payable
                        {/if}
                    </th>
                {/if}

                <th class="text-center" nowrap>Diff. </th>
                {if in_array($paymentAcknowledgeStatus, ['PAID', 'INITD'])}
                    <th class="text-center" nowrap class="noprint">Action</th>
                {else}
                    <th class="noprint" nowrap></th>
                {/if}
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var="totalOpeningBalanceAmount" value=0}
            {assign var="totalBookedAmount" value=0}
            {assign var="totalDeliveryAmount" value=0}
            {assign var="totalTotalOtherIncomeAmount" value=0}
            {assign var="totalTotalExpenseAmount" value=0}
            {assign var="totalCommissionAmount" value=0}
            {assign var="totalRevertAmount" value=0}
            {assign var="totalTotalAmount" value=0}
            {assign var="totalSettlementAmount" value=0}
            {assign var="totalPaidAmount" value=0}
            {assign var="totalPayableAmount" value=0}
            {foreach item=row from=$branch_receipt key=t}
                {assign var="openingBalanceAmount" value=0}
                {foreach from=$row['organizationReceiptDetails'] item=detail}
                    {assign var="openingBalanceAmount" value=$openingBalanceAmount + $detail->openingBalanceAmount}
                {/foreach}
                <tr>
                    <td align="left">
                        {$row['code']}<br>
                        <span class="text-muted">{$row['createdAt']|date_format:'d, M g:i A'}</span>
                    </td>
                    <td align="left">
                        {$row['branch']->name}<br>
                        <span class="text-muted">{$row['username']}{if isNotNull($row['aliasCode'])} - {$row['aliasCode']}{/if}</span>
                    </td>
                    <td align="right">{$openingBalanceAmount|inr_format|default:'-'}</td>
                    <td align="right">{$row['bookedAmount']|inr_format}</td>
                    <td align="right">{$row['deliveryAmount']|inr_format}</td>
                    <td align="right">{$row['totalIncomeAmount']|inr_format}</td>
                    <td align="right">{$row['totalExpenseAmount']|inr_format}</td>
                    <td align="right">{$row['commissionAmount']|inr_format}</td>
                    <td align="right">{$row['revertAmount']|inr_format}</td>
                    <td align="right">
                        {$row['settlementAmount']|inr_format}
                    </td>
                    <td align="right">
                        {($openingBalanceAmount + $row['settlementAmount'])|inr_format}
                    </td>
                    {if $paymentAcknowledgeStatus == 'NA'}
                        <td align="right">
                            {if $row['paymentAcknowledgeCode'] == 'ACKED'}
                                {$row['paidAmount']|inr_format}<br>
                                <span class="text-muted">{$row['paymentMode']}</span>
                            {else}
                                -&nbsp;
                            {/if}
                        </td>
                        <td align="right">
                            {if $row['paymentAcknowledgeCode'] == 'INITD'}
                                {$row['paidAmount']|inr_format}<br>
                                <span class="text-muted">{$row['paymentMode']}</span>
                            {else}
                                -&nbsp;
                            {/if}
                        </td>
                    {else}
                        <td align="right">
                            {$row['paidAmount']|inr_format}<br>
                            <span class="text-muted">{$row['paymentMode']}</span>
                        </td>
                    {/if}

                    <td align="right">
                        {assign var="differnceAmount" value=(($row['settlementAmount'] + $openingBalanceAmount) - $row['paidAmount'])}
                        {$differnceAmount|abs|inr_format}
                        {if inr_format($differnceAmount) > 0}
                            <br><span class="text-danger">Paid Less</span>
                        {elseif inr_format($differnceAmount) < 0}
                            <br><span class="text-success">Paid More</span>
                        {/if}
                    </td>
                    <td>{$row['remarks']}</td>
                </tr>
                {assign var="totalOpeningBalanceAmount" value=$totalOpeningBalanceAmount + $row['totalOpeningBalanceAmount']}
                {assign var="totalBookedAmount" value=$totalBookedAmount + $row['totalBookedAmount']}
                {assign var="totalDeliveryAmount" value=$totalDeliveryAmount + $row['totalDeliveryAmount']}
                {assign var="totalTotalOtherIncomeAmount" value=$totalTotalOtherIncomeAmount + $row['totalTotalOtherIncomeAmount']}
                {assign var="totalTotalExpenseAmount" value=$totalTotalExpenseAmount + $row['totalTotalExpenseAmount']}
                {assign var="totalCommissionAmount" value=$totalCommissionAmount + $row['totalCommissionAmount']}
                {assign var="totalRevertAmount" value=$totalRevertAmount + $row['totalRevertAmount']}
                {assign var="totalTotalAmount" value=$totalTotalAmount +($row['totalBookedAmount'] + $row['totalDeliveryAmount'] + $row['totalTotalOtherIncomeAmount'] - $row['totalTotalExpenseAmount'] - $row['totalCommissionAmount'] - $row['totalRevertAmount'] ) }
                {assign var="totalSettlementAmount" value=$totalSettlementAmount + (($row['totalOpeningBalanceAmount'])+($row['totalBookedAmount'] + $row['totalDeliveryAmount'] + $row['totalTotalOtherIncomeAmount'] - $row['totalTotalExpenseAmount'] - $row['totalCommissionAmount'] - $row['totalRevertAmount']))}
                {assign var="totalPaidAmount" value=$totalPaidAmount + $row['totalPaidAmount']}
                {assign var="totalPayableAmount" value=$totalPayableAmount + $row['totalPayableAmount']}
            {/foreach}
        </tbody>
        {if $branch_receipt|count}
            <tr style="background-color: #bbbbbb;">
                <td colspan="2" align="right"><b>Total</b></td>
                <td align="right"><b>{$totalOpeningBalanceAmount|inr_format}</b></td>
                <td align="right"><b>{$totalBookedAmount|inr_format}</b></td>
                <td align="right"><b>{$totalDeliveryAmount|inr_format}</b></td>
                <td align="right"><b>{$totalTotalOtherIncomeAmount|inr_format}</b></td>
                <td align="right"><b>{$totalTotalExpenseAmount|inr_format}</b></td>
                <td align="right"><b>{$totalCommissionAmount|inr_format}</b></td>
                <td align="right"><b>{$totalRevertAmount|inr_format}</b></td>
                <td align="right"><b>{$totalTotalAmount|inr_format}</b></td>
                <td align="right"><b>{$totalSettlementAmount|inr_format}</b></td>
                {if $paymentAcknowledgeStatus == 'ACKED'}
                    <td align="right"><b>{$totalPaidAmount|default:'0.00'|inr_format}</b></td>
                {else}
                    <td align="right"><b>{$totalPayableAmount|default:'0.00'|inr_format}</b></td>
                {/if}
                <td align="right"></td>
                <td align="right"></td>
            </tr>
        {/if}
    </table>
</div>

<style>
    #branch_receipt_tab {
        border-collapse: collapse;
    }
</style>
<script>
    window.print();
</script>

<style>
    .bold {
        /* font-weight: bold; */
        font-family: Arial, Helvetica, sans-serif;
        font-weight: normal;
        font-size: 0.9em;
        margin: 1px;
        padding: 0;
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
        border: 1px solid #000;
    }
</style>

<style type="text/css" media="print">
    @media print {
        body {
            -webkit-print-color-adjust: exact !important;
            /* Chrome, Safari */
            color-adjust: exact !important;
            /*Firefox*/
        }
    }

    @page {
        size: A4 landscape;
    }
</style>