{$op_bal = 0}
{$created_at = 0}
{$bal = 0}
{$credit = 0}
{$debit = 0}

{foreach item=row from=$result}
    {$op_bal = $result[0]->openingBalanceAmount}
    {$created_at = $result[0]->createdAt}
    {$bal = $result[($result|count)-1]->closingBalanceAmount}
    {$credit = $credit + $row->creditAmount}
    {$debit = $debit + $row->debitAmount}
{/foreach}

<div class="row">
    <div class="col-lg-6">
        <div class="panel panel-default">
            <div class="panel-body">
                <h5 class="element-header">Ledger Statement For {$user}<span class="pull-right">From {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}</span></h5>
                <table class="table table-lightborder" id="ledger-summary-table">
                    <thead class="thead-light">
                        <tr class="">
                            <th>Account Summary</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Opening Balance</td>
                            <td class="text-right">{$op_bal|inr_format}</td>
                        </tr>
                        <tr>
                            <td>Credited Amount</td>
                            <td class="text-right">{$credit|inr_format}</td>
                        </tr>
                        <tr>
                            <td>Debited Amount</td>
                            <td class="text-right">{$debit|inr_format}</td>
                        </tr>
                        <tr>
                            <th>Balance Due</th>
                            <th class="text-right">{$bal|inr_format}</th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<br>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-lightborder" id="user-transaction-table">
                        <thead>
                            <tr>
                                <th align="left">Date</th>
                                <th align="left">Details</th>
                                <th align="left">Debit Amount</th>
                                <th align="left">Credit Amount</th>
                                <th align="left">Balance</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td align="left">{$created_at|date_format:$ns_datetime_format}</td>
                                <td align="left">Opening Balance</td>
                                <td>-</td>
                                <td>-</td>
                                <td align="left">{$op_bal|inr_format}</td>
                                <td></td>
                            </tr>
                            {foreach item=row from=$result key=key}
                                <tr>
                                    <td align="left">{$row->createdAt|date_format:$ns_datetime_format}</td>
                                    <td align="left">{$row->description}</td>
                                    <td align="left">{$row->debitAmount|inr_format}</td>
                                    <td align="left">{$row->creditAmount|inr_format}</td>
                                    <td align="left">{$row->closingBalanceAmount|sigma:$t_closing_balance|inr_format}</td>
                                    <td align="left"><i class="fa fa-info-circle" onclick="viewLedger('{$row->receiptDetailsCode}');" title="View"></i></td>
                                </tr>
                            {foreachelse}
                                <tr>
                                    <td colspan="7" align="center">No data found</td>
                                </tr>
                            {/foreach}
                        </tbody>
                        {if $result|count}
                            {$cnt = $result|count}
                            <tfoot>
                                <tr class="font-weight-bold">
                                    <td colspan="5" align="right" class="text-danger">Balance Due</td>
                                    <td align='left'>{$result[$cnt-1]->closingBalanceAmount|inr_format}</td>
                                </tr>
                            </tfoot>
                        {/if}
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>