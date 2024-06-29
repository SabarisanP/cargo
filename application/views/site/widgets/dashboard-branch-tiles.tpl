<div>
    <table class="table" id="dash-dayclosing-panel-table" data-last-updated="(As on {$dayclosing_summary->datetime|date_format:$ns_time_format})">
        <thead class="bold">
            <tr>
                <td class="sticky-row-top">Branch</td>
                <td class="sticky-row-top" align="right">Last Closed Range</td>
                <td class="sticky-row-top" align="right">Last Closed At</td>
                <td class="sticky-row-top" align="right">Pending Approval</td>
                <td class="sticky-row-top" align="right">Settlement Amount</td>
            </tr>
        </thead>
        <tbody>
            {foreach from=$dayclosing_summary->data item=row}
                <tr>
                    <td>{$row->organization->name}</td>
                    <td align="right" title="From {$row->lastClosingDetails->fromDate|date_format:$ns_datetime_format} to {$row->lastClosingDetails->toDate|date_format:$ns_datetime_format}">
                        {$lastcloseddays = daysBetween($row->lastClosingDetails->fromDate, $row->lastClosingDetails->toDate)}
                        {if $lastcloseddays == 0}
                            Same Day
                        {elseif $lastcloseddays == 1}
                            1 Day
                        {else}
                            {$lastcloseddays} Days
                        {/if}
                    </td>
                    <td align="right" title="By: {$row->lastClosingDetails->user->name}">{$row->lastClosingDetails->toDate|date_format:$ns_datetime_format}</td>
                    <td align="right">{$row->pendingCount|sigma:$d_pending}</td>
                    <td align="right">{$row->pendingAmount|sigma:$d_amount|inr_format}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="5" align="center">No details found</td>
                </tr>
            {/foreach}
            {* {if $dayclosing_summary->data|count}
                <tr>
                    <td class="sticky-row-bottom" align="left" colspan="3"><b>Total</b></td>
                    <td class="sticky-row-bottom" align="right"><b>{$d_pending}</b></td>
                    <td class="sticky-row-bottom" align="right"><b>{$d_amount|inr_format}</b></td>
                </tr>
            {/if} *}
        </tbody>
    </table>

    <table class="table" id="dash-expense-panel-table" data-last-updated="(As on {$expense_summary->datetime|date_format:$ns_time_format})">
        <thead class="bold">
            <tr>
                <td class="sticky-row-top">Branch</td>
                <td class="sticky-row-top" align="right">Pending Approval</td>
                <td class="sticky-row-top" align="right">Income</td>
                <td class="sticky-row-top" align="right">Expense</td>
            </tr>
        </thead>
        <tbody>
            {foreach from=$expense_summary->data item=row}
                <tr>
                    <td>{$row->organization->name}</td>
                    <td align="right">{$row->pendingCount|sigma:$t_pending}</td>
                    <td align="right">{$row->incomeAmount|sigma:$t_income|inr_format}</td>
                    <td align="right">{$row->expenseAmount|sigma:$t_expense|inr_format}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="4" align="center">No details found</td>
                </tr>
            {/foreach}
            {* {if $expense_summary->data|count}
                <tr>
                    <td class="sticky-row-bottom" align="left" colspan="1"><b>Total</b></td>
                    <td class="sticky-row-bottom" align="right"><b>{$t_pending}</b></td>
                    <td class="sticky-row-bottom" align="right"><b>{$t_income|inr_format}</b></td>
                    <td class="sticky-row-bottom" align="right"><b>{$t_expense|inr_format}</b></td>
                </tr>
            {/if} *}
        </tbody>
    </table>
</div>
