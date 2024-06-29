<table border='1'>
    <tr>
        <td colspan="12" align="center"><b>Branch Closing Report({if $paymentAcknowledgeStatus == 'ACKED'}Acknowledged{elseif $paymentAcknowledgeStatus == 'INITD'}Initiated {else}Reject{/if})</b></td>
    </tr>
    <tr>
        <td colspan="6"></td>
        <td colspan="6">Report At : {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
        <td colspan="6"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br>
<table class="table table-bordered " border='1'>
    <thead>
        <tr class="success">
            <th>Transaction Code</th>
            <th>Created At</th>
            <th>User</th>
            <th>Employee Code</th>
            <th>Transaction Mode</th>
            <th>Branch</th>
            <th>Opening balance (A)</th>
            <th>Paid Booking (B)</th>
            <th>ToPay Delivery (C)</th>
            <th>Other Income (D)</th>
            <th>Expenses (E)</th>
            <th>Commissions (F)</th>
            <th>Revert Payment (G)</th>
            <th>Total Amount (H=B+C+D-E-F-G)</th>
            <th>Settlement Amount (I=A+H)</th>
            <th>Payable</th>
            <th>Diff. Amount</th>
            <th align="center">Remarks</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach from=$result item=row name=key}
            {assign var="openingBalanceAmount" value=0}
            {foreach from=$row->organizationReceiptDetails item=detail}
                {assign var="openingBalanceAmount" value=$openingBalanceAmount + $detail->openingBalanceAmount}
            {/foreach}
            <tr>
                <td>{$row->code}</td>
                <td>{$row->createdAt|date_format:'d M, Y g:i A'}</td>
                <td>{$row->user->name}</td>
                <td>{if isNotNull($row->user->aliasCode)}{$row->user->aliasCode}{else}-{/if}</td>
                <td>{$row->organizationReceiptDetails[0]->paymentMode->name}</td>
                <td>{$row->organization->name}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$openingBalanceAmount|sigma:$t_opening_balance}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->bookedAmount|sigma:$t_booked_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->deliveryAmount|sigma:$t_delivery_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->totalIncomeAmount|sigma:$t_income_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->totalExpenseAmount|sigma:$t_expense_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->commissionAmount|sigma:$t_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->revertAmount|sigma:$t_revert_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->settlementAmount|sigma:$t_settlement_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{($openingBalanceAmount + $row->settlementAmount)|sigma:$t_total_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paidAmount|sigma:$t_paid_amount}</td>

                {assign var="differnceAmount" value=abs(($row->settlementAmount + $openingBalanceAmount) - $row->paidAmount)}
                <td align="right" data-format="{$xlformat['currency']}">
                    {inr_format(inr_format($differnceAmount))}
                    {if inr_format($differnceAmount) > 0}
                        / Paid Less
                    {elseif inr_format($differnceAmount) < 0}
                        / Paid More
                    {/if}
                </td>
                <td align="left">{$row->remarks}</td>
            </tr>
        {/foreach}
    </tbody>
    <tfoot>
        {if $result|count}
            <tr class="bold">
                <td colspan="6" align="right">Total:</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_opening_balance}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_booked_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_delivery_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_income_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_expense_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_revert_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_settlement_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_total_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_paid_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}"></td>
                <td align="right" data-format="{$xlformat['currency']}"></td>
            </tr>
        {/if}
    </tfoot>
</table>