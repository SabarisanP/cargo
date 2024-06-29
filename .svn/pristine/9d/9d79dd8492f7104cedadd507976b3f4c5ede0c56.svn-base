<div class="row">
    <div class="table-responsive col-md-6">
        <h5>Expense</h5>
        <table class="table table-bordered">
            <thead>
                <tr class="bold success">
                    <th align="center">Expense Code</th>
                    <th align="center">Expense Head</th>
                    <th align="center">{lang('lr')} No / Vehicle No / Other</th>
                    <th align="center">Expense Date</th>
                    <th align="center">Transaction Mode</th>
                    <th align="center">Remarks</th>
                    <th align="right">Expense Amount</th>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var="tot_dr" value=0}
                {foreach item=data from=$debit key=branch}
                    <tr>
                        <td class="active" colspan="7" align="center">{$branch}</td>
                    </tr>
                    {foreach item=row from=$data}
                        <tr>
                            <td align="left">{$row->transaction_code}</td>
                            <td align="left">{$row->name}</td>
                            <td align="left">
                                {if $row->reference_type == 'VEHICLE'}
                                    {$vehicle_mapped[$row->reference_code]->registationNumber}
                                {elseif $row->reference_type == 'LR'}
                                    <a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->reference_code}")'>{$row->reference_code}</a>
                                {else}
                                    -
                                {/if}
                            </td>
                            <td align="left">{$row->transaction_at|date_format:$ns_date_format}</td>
                            <td align="left">{$row->transaction_mode_name}</td>
                            <td align="left">{$row->remarks}</td>
                            <td align="right">{$row->transaction_amount|number_format:2}</td>
                        </tr>
                        {assign var="tot_dr" value=$tot_dr + $row->transaction_amount}
                    {/foreach}
                {foreachelse}
                    <tr>
                        <td colspan="7" align="center">No Records Found!</td>
                    </tr>
                {/foreach}
                {if $debit|count}
                    <tr class="active">
                        <td colspan="6" class="bold" align="right">Total</td>
                        <td align="right">{$tot_dr|number_format:2}</td>
                    </tr>
                {/if}
            </tbody>
        </table>
    </div>

    <div class="table-responsive col-md-6">
        <h5>Income</h5>
        <table class="table table-bordered">
            <thead>
                <tr class="bold success">
                    <th align="center">Income Code</th>
                    <th align="center">Income Head</th>
                    <th align="center">{lang('lr')} No / Vehicle No / Other</th>
                    <th align="center">Income Date</th>
                    <th align="center">Transaction Mode</th>
                    <th align="center">Remarks</th>
                    <th align="right">Income Amount</th>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var="tot_cr" value=0}
                {foreach item=data from=$credit key=branch}
                    <tr>
                        <td class="active" colspan="7" align="center">{$branch}</td>
                    </tr>
                    {foreach item=row from=$data}
                        <tr>
                            <td align="left">{$row->transaction_code}</td>
                            <td align="left">{$row->name}</td>
                            <td align="left">
                                {if $row->reference_type == 'VEHICLE'}
                                    {$vehicle_mapped[$row->reference_code]->registationNumber}
                                {elseif $row->reference_type == 'LR'}
                                    <a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->reference_code}")'>{$row->reference_code}</a>
                                {else}
                                    -
                                {/if}
                            </td>
                            <td align="left" nowrap>{$row->transaction_at|date_format:$ns_date_format}</td>
                            <td align="left">{$row->transaction_mode_name}</td>
                            <td align="left">{$row->remarks}</td>
                            <td align="right">{$row->transaction_amount|number_format:2}</td>
                        </tr>
                        {assign var="tot_cr" value=$tot_cr + $row->transaction_amount}
                    {/foreach}
                {foreachelse}
                    <tr>
                        <td colspan="7" align="center">No Records Found!</td>
                    </tr>
                {/foreach}
                {if $credit|count}
                    <tr class="active">
                        <td colspan="6" class="bold" align="right">Total</td>
                        <td align="right">{$tot_cr|number_format:2}</td>
                    </tr>
                {/if}
            </tbody>
        </table>
    </div>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportIncomeExpenses();"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>