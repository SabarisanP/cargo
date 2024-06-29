<table>
    <tr>
        <td align="center"><b>Expense</b></td>
        <td align="center"></td>
        <td align="center"><b>Income</b></td>
    </tr>
    <tr>
        <td>
            <table border="1">
                <thead>
                    <tr style="background-color: #64b92a; color: #fff;">
                        <th align="center">Expense Code</th>
                        <th align="center">Expense Head</th>
                        <th align="center">{lang('lr')} No / Vehicle No / Other</th>
                        <th align="center">Expense Date</th>
                        <th align="center">Transaction Mode</th>
                        <th align="center">Branch</th>
                        <th align="center">Remarks</th>
                        <th align="center">Expense Amount</th>
                    </tr>
                </thead>
                <tbody>
                    {assign var="tot_dr" value=0}
                    {foreach item=data from=$debit key=branch}
                        <tr>
                            <td colspan="8" align="center" style="background-color: #bbbbbb; color: #fff;"><b>{$branch}</b></td>
                        </tr>
                        {foreach item=row from=$data}
                            <tr>
                                <td align="left">{$row->transaction_code}</td>
                                <td align="left">{$row->name}</td>
                                <td align="left">
                                    {if $row->reference_type == 'VEHICLE'}
                                        {$vehicle_mapped[$row->reference_code]->registationNumber}
                                    {elseif $row->reference_type == 'LR'}
                                        {$row->reference_code}
                                    {else}
                                        -
                                    {/if}
                                </td>
                                <td align="left">{$row->transaction_at|date_format:$ns_date_format}</td>
                                <td align="left">{$row->transaction_mode_name}</td>
                                <td align="left">{$row->organization_name}</td>
                                <td align="left">{$row->remarks}</td>
                                <td align="right">{$row->transaction_amount|number_format:2}</td>
                            </tr>
                            {assign var="tot_dr" value=$tot_dr + $row->transaction_amount}
                        {/foreach}
                    {foreachelse}
                        <tr>
                            <td colspan="8" align="center">No Records Found!</td>
                        </tr>
                    {/foreach}
                    {if $debit|count}
                        <tr style="background-color: #bbbbbb; color: #fff;">
                            <td colspan="7" class="bold" align="right">Total</td>
                            <td align="right">{$tot_dr|number_format:2}</td>
                        </tr>
                    {/if}
                </tbody>
            </table>
        </td>
        <td></td>
        <td>
            <table border="1">
                <thead>
                    <tr style="background-color: #64b92a; color: #fff;">
                        <th align="center">Income Code</th>
                        <th align="center">Income Head</th>
                        <th align="center">{lang('lr')} No / Vehicle No / Other</th>
                        <th align="center">Income Date</th>
                        <th align="center">Transaction Mode</th>
                        <th align="center">Branch</th>
                        <th align="center">Remarks</th>
                        <th align="center">Income Amount</th>
                    </tr>
                </thead>
                <tbody>
                    {assign var="tot_cr" value=0}
                    {foreach item=data from=$credit key=branch}
                        <tr>
                            <td colspan="8" align="center" style="background-color: #bbbbbb; color: #fff;"><b>{$branch}</b></td>
                        </tr>
                        {foreach item=row from=$data}
                            <tr>
                                <td align="left">{$row->transaction_code}</td>
                                <td align="left">{$row->name}</td>
                                <td align="left">
                                
                                    {if $row->reference_type == 'VEHICLE'}
                                        {$vehicle_mapped[$row->reference_code]->registationNumber}
                                    {elseif $row->reference_type == 'LR'}
                                        {$row->reference_code}
                                    {else}
                                        -
                                    {/if}                                    
                                </td>
                                <td align="left">{$row->transaction_at|date_format:$ns_date_format}</td>
                                <td align="left">{$row->transaction_mode_name}</td>
                                <td align="left">{$row->organization_name}</td>
                                <td align="left">{$row->remarks}</td>
                                <td align="right">{$row->transaction_amount|number_format:2}</td>                    
                            </tr>
                            {assign var="tot_cr" value=$tot_cr + $row->transaction_amount}
                        {/foreach}
                    {foreachelse}
                        <tr>
                            <td colspan="8" align="center">No Records Found!</td>
                        </tr>
                    {/foreach}
                    {if $credit|count}
                        <tr style="background-color: #bbbbbb; color: #fff;">
                            <td colspan="7" class="bold" align="right">Total</td>
                            <td align="right">{$tot_cr|number_format:2}</td>
                        </tr>
                    {/if}
                </tbody>
            </table>
        </td>
    </tr>
</table>