<table border='1'>
    <tr>
        <td  colspan="5" align="center"><b>User Balance Report ({if $filterby == 'USER'}User Wise{else}Branch Wise{/if})</b></td>
    </tr>
    <tr>
        <td colspan="3">Report At : {$smarty.now|date_format:$ns_datetime_format}</td>
        <td colspan="2" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table> 

{if $filterby == 'USER'}
    <table border='1'>
        <thead>
            <tr style="background-color: #64b92a; color: #fff;">
                <td>Group</td>
                <td>Payment Type</td>
                <td>Name</td>
                <td>Last Transaction Date</td>
                <td>Current Balance</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach from=$result item=row}
                {if $row->user_role_code == 'USER'}
                    <tr>
                        <td>{$row->user_group_name}</td>
                        <td>{$row->payment_type_code}</td>
                        <td>{$row->first_name}</td>
                        <td>{$row->last_transaction_date|date_format:$ns_datetime_format}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->current_balance|sigma:$t_balance}</td>
                    </tr>
                {/if}
            {foreachelse}
                <tr>
                    <td colspan="5" align="center">No Records Found</td>
                </tr>
            {/foreach}
        </tbody>
        {if $result|count}
            <tfoot>
                <tr style="background-color: #bbbbbb; color: #fff;">
                    <td colspan="4" align="right">Total</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_balance}</td>
                </tr>
            </tfoot>
        {/if}
    </table>
{elseif $filterby == 'BRANCH'}
    {foreach from=$branchwise key=branchname item=branch}
        <table border="1">
            <tr>
                <td><b>{$branchname}</b></td>
                <td align="right" colspan="4" data-format="{$xlformat['currency']}"><b>Rs. {$branch['total']|sigma:$tot_branch_amt}</b></td>
            </tr>
            <thead>
                <tr style="background-color: #64b92a; color: #fff;">
                    <td>Group</td>
                    <td>Payment Type</td>
                    <td>Name</td>
                    <td>Last Transaction Date</td>
                    <td>Current Balance</td>
                </tr>
            </thead>
            <tbody>
                {foreach item=row from=$branch['data']}
                    {if $row->user_role_code == 'USER'}
                        <tr>
                            <td>{$row->user_group_name}</td>
                            <td>{$row->payment_type_code}</td>
                            <td>{$row->first_name}</td>
                            <td>{$row->last_transaction_date|date_format:$ns_datetime_format}</td>
                            <td align="right" data-format="{$xlformat['currency']}">{$row->current_balance}</td>
                        </tr>
                    {/if}
                {foreachelse}
                    <tr>
                        <td colspan="5" align="center">No Records Found</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    {/foreach}
    <table>
        <tbody>
            <tr>
                <td colspan="4" align="right">Total</td>
                <td align="right" data-format="{$xlformat['currency']}">{$tot_branch_amt}</td>
            </tr>
        </tbody>
    </table>
{/if}
