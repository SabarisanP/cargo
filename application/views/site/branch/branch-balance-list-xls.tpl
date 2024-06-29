<table border='1'>
    <tr>
        <td  colspan="4" align="center"><b>Branch Balance Report ({if $filterby == 'USER'}User Wise{else}Branch Wise{/if})</b></td>
    </tr>
    <tr>
        <td colspan="2">Report At : {$smarty.now|date_format:$ns_datetime_format}</td>
        <td colspan="2" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table> 

{if $filterby == 'USER'}
    <div class="overflow-x-auto">
        <table border='1'>
            <thead>
                <tr style="background-color: #64b92a; color: #fff;">
                    <td>User</td>
                    <td>Branch</td>
                    <td>Last Closed Date</td>
                    <td>Balance</td>
                    <td>Running Balance</td>
                </tr>
            </thead>
            <tbody class="body_table">
                {foreach item=row from=$result}
                    <tr>
                        <td>{$row->user->name}</td>
                        <td>{$row->user->organization->name}</td>
                        <td>{$row->closingDateTime|date_format:$ns_datetime_format}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->closingBalance|sigma:$t_balance}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->currentBalance|sigma:$t_running}</td>
                    </tr>
                {foreachelse}
                    <tr>
                        <td colspan="5" align="center">No Records Found</td>
                    </tr>
                {/foreach}
            
                {if $result|count}
                    <tfoot>
                        <tr style="background-color: #bbbbbb; color: #fff;">
                            <td colspan="3" align="right">Total</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$t_balance}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$t_running}</td>
                        </tr>
                    </tfoot>
                {/if}
            </tbody>
        </table>
    </div>
{elseif $filterby == 'BRANCH'}
    <div class="overflow-x-auto">
        {foreach from=$branchwise key=branchname item=branch}
            <table border="1">
                <tr>
                    <td><b>{$branchname}</b></td>
                    <td data-format="{$xlformat['currency']}" align="right" colspan="2"><b>Rs. {$branch['total']}</b></td>
                </tr>
                <thead>
                    <tr style="background-color: #64b92a; color: #fff;">
                        <td>User</td>
                        <td>Last Closed Date</td>
                        <td>Balance</td>
                        <td>Running Balance</td>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$branch['data']}
                        <tr>
                            <td>{$row->user->name}</td>
                            <td>{$row->closingDateTime|date_format:$ns_datetime_format}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$row->closingBalance|sigma:$brn_tot_balance}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$row->currentBalance|sigma:$brn_tot_running}</td>
                        </tr>
                    {foreachelse}
                        <tr>
                            <td colspan="4" align="center">No Records Found</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        {/foreach}
        <table>
            <tbody>
                {if $branchwise|count}
                    <tr style="background-color: #bbbbbb; color: #fff;">
                        <td colspan="2" align="right">Total</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$brn_tot_balance}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$brn_tot_running}</td>
                    </tr>
                {/if}
            </tbody>
        </table>
    </div>
{/if}