<h5 class="bold">Income / Expense Details entered as on {$smarty.request.fromDate|date_format:'%A %d-%b-%Y'}</h5>

<div class="table-responsive">
    <table class="table table-bordered table-hover" id="expenses-table">
        <thead>
            <tr class="bold">
                <th>Category</th>
                <th>Expense For</th>
                <th>Details</th>
                <th>Income / Expense Type </th>
                <th>Payment Mode </th>
                <th>Vendor/receiver Inc. </th>
                <th>Tags</th>
                <th>Inc. Amount </th>
                <th>Exp. Amount</th>
                <th>Status</th>
                <th>Remarks</th>
                <th>Att.</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach item=row from=$reports}
                {if ($row->ack_status_code == 'INIT' || $row->ack_status_code == 'REJT') && $row->entry_type_code != 'EXLGR'}
                    {assign var="additionalDetails" value="|"|explode:$row->additional_details}
                    <tr>
                        <td align="left">
                            {if $row->transaction_type == 'Cr'}
                                <span class='label label-sm label-primary'>Income</span>
                            {elseif $row->transaction_type == 'Dr'}
                                <span class='label label-sm label-danger'>Expense</span>
                            {/if}
                        </td>
                        <td align="left">
                            {$expense_category_type[$row->category_type]}
                        </td>
                        <td align="left">{$row->reference_details|default:'-'}</td>
                        <td align="left">{$row->cashbook_type_name}</td>
                        <td align="left">{$transaction_mode[$row->transaction_mode_code]}</td>
                        <td align="left">{$row->cashbook_vendor_name|default:$row->cashbook_vendor_code|default:'-'}</td>
                        <td align="left" width="100">
                            {assign var="tag_codes" value=explode(',', $row->tag_code)}
                            {assign var="tag_names" value=[]}
                        
                            {foreach from=$tag_codes item=tc}
                                {$tag_names[] = $cargotags[$tc]->name}
                            {/foreach}

                            {implode(', ', $tag_names)}
                        </td>

                        {assign var="staffIncomeExpense" value=explode(',', $row->cashbook_transaction_details)}
                        <td align="left">
                            {if $row->category_type == 'BRN'}
                                {if $row->cashbook_transaction_details && $row->transaction_type == 'Cr'}
                                    {foreach from=$staffIncomeExpense item=income}
                                        {assign var="staffInc" value=explode(':', $income)}
                                        {$staffInc[2]} - {$staffInc[3]}<br>
                                    {/foreach}
                                {else}
                                    {$row->credit_amount|default:'-'}
                                {/if}
                            {elseif $row->category_type == 'OT' && isNotNull($additionalDetails[0]) && $row->transaction_type == 'Cr'}
                                {$additionalDetails[0]} - {$row->credit_amount|default:'-'}
                            {else}
                                {$row->credit_amount|default:'-'}
                                {if $row->cashbook_transaction_details && $row->transaction_type == 'Cr'}
                                    <span data-toggle="popover" data-placement="top" data-content='<ul class="p_l_15">
                                    {foreach from=$staffIncomeExpense item=income}
                                        {assign var="staffInc" value=explode(':', $income)}
                                        <li><b>{$staffInc[2]} - {$staffInc[3]}</b></li>
                                    {/foreach}
                                </ul>'><i class="fa fa-info-circle"></i></span>
                                {/if}
                            {/if}
                        </td>

                        <td align="left">
                            {if $row->category_type == 'BRN'}
                                {if $row->cashbook_transaction_details && $row->transaction_type == 'Dr'}
                                    {foreach from=$staffIncomeExpense item=expense}
                                        {assign var="staffExp" value=explode(':', $expense)}
                                        {$staffExp[2]} - {$staffExp[3]}<br>
                                    {/foreach}
                                {else}
                                    {$row->debit_amount|default:'-'}
                                {/if}
                            {elseif $row->category_type == 'OT' && isNotNull($additionalDetails[0]) && $row->transaction_type == 'Dr'}
                                {$additionalDetails[0]} - {$row->debit_amount|default:'-'}
                            {else}
                                {$row->debit_amount|default:'-'}
                                {if $row->cashbook_transaction_details && $row->transaction_type == 'Dr'}
                                    <span data-toggle="popover" data-placement="top" data-content='<ul class="p_l_15">
                                    {foreach from=$staffIncomeExpense item=expense}
                                        {assign var="staffExp" value=explode(':', $expense)}
                                        <li><b>{$staffExp[2]} - {$staffExp[3]} </b></li>
                                    {/foreach}
                                </ul>'><i class="fa fa-info-circle"></i></span>
                                {/if}
                            {/if}
                        </td>

                        <td align="center">
                            {if $row->ack_status_code == 'INIT'}
                                <i class="fa fa-check-circle fa-lg text-primary"></i> Initiated
                            {elseif $row->ack_status_code == 'APRD'}
                                <i class="fa fa-check-circle fa-lg text-primary"></i> Approved
                            {elseif $row->ack_status_code == 'REJT'}
                                <i class="fa fa-times-circle fa-lg text-danger"></i> Rejected
                            {/if}
                        </td>
                        <td align="left"><span data-toggle="tooltip" data-placement="top" title="{$row->remarks}">
                            {(($row->remarks) ? $row->remarks : '-')|truncate:35:'...'}
                            {if isNotNull($additionalDetails[1])}
                                , Approved By: {$additionalDetails[1]}</span>
                            {/if}
                        </td>
                        <td align="center">
                            {if $row->image_count > 0}
                                <div class="btn-group btn-group-xs">
                                    <button class="btn btn-default btn-sm" type="button" onclick="showPRGallery('{$row->transaction_code}')"><i class="fa fa-picture-o" aria-hidden="true"></i></button>
                                </div>
                            {else}
                                -
                            {/if}
                        </td>
                        <td align="right" width="100" nowrap>
                            <span class="pull-left" data-toggle="tooltip" data-placement="top" title="{$row->user_name}<br/>{$row->updated_at|date_format:$ns_datetime_format}"><i class="fa fa-info-circle" title="Updated By & Date"></i></span>
                            {if $action_rights['IE-EDIT-DELETE'] == 1}
                                <div class="btn-group btn-group-xs">
                                    <a class="delete pTip_top btn btn-default btn-sm" title="Delete" href="javascript:;" onclick="deleteExpenses('{$row->transaction_code}')">
                                        <i class="fa fa-trash-o fa-lg"></i>
                                    </a>&nbsp;
                                    <a href="javascript:;" class="btn btn-default btn-sm" title="Edit" onclick='editExpenses("{$row->transaction_code}")'><i class="fa fa-pencil igreen"></i> Edit</a>
                                </div>
                            {/if}
                        </td>
                    </tr>
                {/if}
            {/foreach}
        </tbody>
    </table>
</div>

<script>
    var allExpenses = {$reports|json_encode}
    var staffIncomeExpense =  {$staffIncomeExpense|json_encode}
    var driveIncomeExpense = {$reports|json_encode}
    $('#expenses-table').DataTable({
        paging: false
    });
    $('[data-toggle="tooltip"]').tooltip({
        html: true
    });

    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
</script>