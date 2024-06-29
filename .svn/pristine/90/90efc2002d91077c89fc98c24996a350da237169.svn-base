<table border="1">
    <tr>
        <td colspan="6" align="center"><b>Day Closing Report</b></td>
    </tr>
    <tr>
        <td colspan="3"><b>From </b> {$smarty.request.fromDate|date_format:$ns_date_format}  <b>To</b> {$smarty.request.toDate|date_format:$ns_date_format}</td>
        <td colspan="3" align="right"><b>Report Date/Time :</b> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
</table>
<br>
<table border="1">
    <thead>
        <tr style="font-weight:bold; background-color:#64b92a; color: #fff;">
            <td>Branch</td>
            <td>User</td>
            <td>Opening Balance</td>
            <td>Paid Booking</td>
            <td>ToPay Delivery</td>
            <td>Other Income</td>
            <td>Expenses</td>
            <td>Commissions</td>
            <td>Revert Amount</td>
            <td>Settlement Amount</td>
            <td>Day Closing Amount</td>
        </tr>
    </thead>

    <tbody class="body_table">
        {assign var=total_opening_balance value=0}
        {assign var=total_paid_amount value=0}
        {assign var=total_delivery_amount value=0}
        {assign var=total_other_income value=0} 
        {assign var=total_expense_amount value=0}
        {assign var=total_commission_amount value=0}
        {assign var=total_revert_amount value=0}
        {assign var=total_settlement_amount value=0}
        {assign var=total_day_closing_amount value=0}
        {foreach item=row from=$result key=t}
            <tr>
                <td>{$row->organization->name}</td>
                <td>{$row->user->name}</td>
                <td align="right">{$row->openingBalance|inr_format:2}</td>
                <td align="right">{$row->bookedAmount|inr_format:2}</td>
                <td align="right">{$row->deliveryAmount|inr_format:2}</td>
                <td align="right">{$row->totalIncomeAmount|inr_format:2}</td>
                <td align="right">{$row->totalExpenseAmount|inr_format:2}</td>
                <td align="right">{$row->commissionAmount|inr_format:2}</td>
                <td align="right">{$row->revertAmount|inr_format:2}</td>
                <td align="right">{($row->settlementAmount + $row->openingBalance)|inr_format:2}</td>
                <td align="right">{$row->paidAmount|inr_format:2}</td>
            </tr>

            {assign var=total_opening_balance value=$total_opening_balance+$row->openingBalance}
            {assign var=total_paid_amount value=$total_paid_amount+$row->bookedAmount}
            {assign var=total_delivery_amount value=$total_delivery_amount+$row->deliveryAmount}
            {assign var=total_other_income value=$total_other_income+$row->totalIncomeAmount}
            {assign var=total_expense_amount value=$total_expense_amount+$row->totalExpenseAmount}
            {assign var=total_commission_amount value=$total_commission_amount+$row->commissionAmount}
            {assign var=total_revert_amount value=$total_revert_amount+$row->revertAmount}
            {assign var=total_settlement_amount value=$total_settlement_amount+($row->settlementAmount + $row->openingBalance)}
            {assign var=total_day_closing_amount value=$total_day_closing_amount+$row->paidAmount}
        {foreachelse}
            <tr>
                <td colspan="11" align="center">No data found</td>
            </tr>
        {/foreach}
    </tbody>
    <tfoot>
        <tr style="font-weight:bold;">
            <td align="right" colspan="2">Total</td>
            <td align="right">{$total_opening_balance|number_format:2}</td>
            <td align="right">{$total_paid_amount|number_format:2}</td>
            <td align="right">{$total_delivery_amount|number_format:2}</td>
            <td align="right">{$total_other_income|number_format:2}</td>
            <td align="right">{$total_expense_amount|number_format:2}</td>
            <td align="right">{$total_commission_amount|number_format:2}</td>
            <td align="right">{$total_revert_amount|number_format:2}</td>
            <td align="right">{$total_settlement_amount|number_format:2}</td>
            <td align="right">{$total_day_closing_amount|number_format:2}</td>
        </tr>
    </tfoot>
</table>
