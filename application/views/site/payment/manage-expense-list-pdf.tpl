<table width="100%" cellpadding="4">
    <tr>
        <td colspan="12" align="center"><b>Income / Expense Report</b></td>
    </tr>
    <tr>
        <td colspan="4">
            <b>From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} </b>
        </td>
        <td colspan="4" align="center">
            {if isNotNull($smarty.request.organizationCode)}
                {assign var="branch" value=$branches[$smarty.request.organizationCode]}
                {$branch->name|strtolower|ucwords}<br>
                {if isNotNull($branch->address1)}
                    {$branch->address1}, 
                {/if}
                {if isNotNull($branch->address2)}
                    {$branch->address2}, 
                {/if}
                <br>{$branch->contact}
            {/if}
        </td>
        <td colspan="4" align="right">
            <b>Report Date/Time :</b> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table> 

<table border="1" width="100%" cellpadding="2">
    <thead>
        <tr>
            <td>Category</td>
            <td>Receipt Date</td>
            <td>Expense For</td>
            <td>Details</td>
            <td>Income / Expense Type </td>
            <td>Payment Mode </td>
            <td>Vendor/receiver Inc. </td>
            <td>Tags</td>
            <td>Inc. Amount </td>
            <td>Exp. Amount</td>
            <td>Status</td>
            <td>Staff Income / Expense</td>
            <td>Created At</td>
            <td>Updated By</td>
            <td>Employee Code</td>
            <td>Updated At</td>
            <td>Remarks</td>
        </tr>
    </thead>
    <tbody>
        {foreach item=row from=$result key=user}
            {assign var="additionalDetails" value="|"|explode:$row->additional_details}
            <tr>
                <td align="left">
                    {if $row->transaction_type == 'Cr'}
                        <span class='label label-sm label-primary'>Income</span>
                    {elseif $row->transaction_type == 'Dr'}
                        <span class='label label-sm label-danger'>Expense</span>
                    {/if}
                </td>
                <td>{$row->settlement_date|date_format:$ns_date_format}</td>
                <td align="left">
                    {$expense_category_type[$row->category_type]}
                </td>
                <td align="left">{$row->reference_details}</td>
                <td align="left">{$row->cashbook_type_name}</td>
                <td align="left">{$transaction_mode[$row->transaction_mode_code]}</td>
                <td align="left">{$row->cashbook_vendor_name|default:$row->cashbook_vendor_code|default:'-'}</td>
                <td align="left">
                    {assign var="tag_codes" value=explode(',', $row->tag_code)}
                    {assign var="tag_names" value=[]}
                
                    {foreach from=$tag_codes item=tc}
                        {$tag_names[] = $cargotags[$tc]->name}
                    {/foreach}

                    {implode(', ', $tag_names)}
                </td>
                <td align="left">
                    {if $row->category_type == 'OT' && isNotNull($additionalDetails[0]) && $row->transaction_type == 'Cr'}
                        {$additionalDetails[0]} - {$row->credit_amount|default:'-'}
                    {else}
                        {$row->credit_amount|default:'-'}
                    {/if}
                </td>
                <td align="left">
                    {if $row->category_type == 'OT' && isNotNull($additionalDetails[0]) && $row->transaction_type == 'Dr'}
                        {$additionalDetails[0]} - {$row->debit_amount|default:'-'}
                    {else}
                        {$row->debit_amount|default:'-'}
                    {/if}
                </td>
                <td align="center">
                    {if $row->ack_status_code == 'INIT'}
                        Initiated
                    {elseif $row->ack_status_code == 'APRD'}
                        Approved
                    {elseif $row->ack_status_code == 'REJT'}
                        Rejected
                    {/if}
                </td>
                <td align="left">
                    {if isNotNull($row->cashbook_transaction_details)}
                        {assign var="staffIEList" value=[]}
                        {assign var="staffIncomeExpense" value=explode(',', $row->cashbook_transaction_details)}
                        {foreach from=$staffIncomeExpense item=expense}
                            {assign var="staffExp" value=explode(':', $expense)}
                            {$staffIEList[] = $staffExp[1]|cat:' - ':$staffExp[2]}
                        {/foreach}
                        {$staffIEList|implode:'<br>'}
                    {else}
                        -
                    {/if}
                </td>
                <td align="left">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->user_name|default:'-'}</td>
                <td align="left">
                    {* {if isNotNull($row->alias_code)} *}
                    {$row->alias_code|default:'-'}
                    {* {/if} *}
                </td>
                <td align="left">{$row->updated_at|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->remarks|default:'-'}</td>
            </tr>
            {assign var=b_income value=$b_income+$row->credit_amount}
            {assign var=b_expense value=$b_expense+$row->debit_amount}
            {assign var=b_balance value=$b_balance+($row->credit_amount - $row->debit_amount)}
        {foreachelse}
            <tr>
                <td colspan="16" align="center">No data found</td>
            </tr>
        {/foreach}
    </tbody>
    {if $result|count}
        <tfoot>
            <tr>
                <th align="right" colspan="8">Total</th>
                <td data-format="{$xlformat['currency']}">{$b_income}</td>
                <td data-format="{$xlformat['currency']}">{$b_expense}</td>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
        </tfoot>
    {/if}
</table>

<br><br><br><br>
<table width="100%" cellpadding="4">
    <tr>
        <td align="right">Seal and Signature</td>
    </tr>
</table>
