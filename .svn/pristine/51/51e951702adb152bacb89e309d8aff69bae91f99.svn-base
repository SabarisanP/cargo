{if $smarty.request.group_by == 'SUMMARY'}
    <div class="table-responsive" id="adv-bp-grid">
        <table id="dt_ss_report_table" class="table table-bordered">
            <thead>
                <tr class="success">
                    <td>Receipt Date&nbsp;<img src="assets/img/way-white.png" width="16px"></td>
                    <td>Branch&nbsp;<img src="assets/img/way-white.png" width="16px"></td>
                    <td>Income&nbsp;<img src="assets/img/way-white.png" width="16px"></td>
                    <td>Expense&nbsp;<img src="assets/img/way-white.png" width="16px"></td>
                    <td>Settlement to Office&nbsp;<img src="assets/img/way-white.png" width="16px"><br /> (Only Approved)</td>
                    <td>Status&nbsp;<img src="assets/img/way-white.png" width="16px"></td>
                    <td>{if $action_rights['IE-APOVR-RJT']>0}Actions&nbsp;<img src="assets/img/way-white.png" width="16px">{/if}</td>
                    <td>View&nbsp;<img src="assets/img/way-white.png" width="16px"></td>
                </tr>

            </thead>

            {assign var=b_income value=0}
            {assign var=b_expense value=0}
            {assign var=b_balance value=0}

            <tbody class="body_table">
                {foreach item=users from=$summary key=branch}
                    {foreach item=row from=$users key=user}
                        <tr id="{$branch}{$user}" class="tr-hover" onclick="toggleUsersSettlement('{$branch}{$user}');">
                            <td>{$row['settlement_date']|date_format:$ns_date_format}</td>
                            <td>
                                {$row['organization_name']}<br>
                                {if isNotNull($row['alias_code'])}
                                    <span class="text-muted">{$row['user_name']} - {$row['alias_code']}</span><br>
                                {/if}
                                <span class="text-muted">{$row['user_name']}</span>
                            </td>

                            <td align='right'>{$row['income']|inr_format}</td>
                            <td align='right'>{$row['expense']|inr_format}</td>
                            <td align='right'>{$row['settlement']|inr_format}</td>

                            <td align='center'>
                                <i class="fa fa-check-circle fa-lg text-primary"></i> ( {$row['count_APRD'] + 0} )
                                <i class="fa fa-times-circle fa-lg text-danger"></i> ( {$row['count_REJT'] + 0} )
                            </td>
                            <td align='center'>
                                {if count($row['codes']) && $action_rights['IE-APOVR-RJT']>0}
                                    <button class="btn-app btn-primary" type="button" onclick="changeExpenseStatus('{implode(',', $row['codes'])}', 'APRD');"><i class="fa fa-check"></i> Accept</button>
                                    <button class="btn-app btn-danger" type="button" onclick="rejectStatusDialog('{implode(',', $row['codes'])}', 'REJT');"><i class="fa fa-times"></i> Reject</button>
                                {/if}
                            </td>
                            <td align='center'>
                                <a href="javascript:;"><i class="fa fa-eye" aria-hidden="true"></i></a>
                            </td>
    
                            {assign var=b_income value=$b_income+$row['income']}
                            {assign var=b_expense value=$b_expense+$row['expense']}
                            {assign var=b_balance value=$b_balance+$row['settlement']}
                        </tr>
                    {/foreach}
                {foreachelse}
                    <tr>
                        <td colspan="8" align="center">No data found</td>
                    </tr>
                {/foreach}
            </tbody>
            {if $summary|count}
                <tr class="">
                    <th class="text-right" colspan="2">Total</th>
                    <th class="text-right">{$b_income|inr_format}</th>
                    <th class="text-right">{$b_expense|inr_format}</th>
                    <th class="text-right">{$b_balance|inr_format}</th>
                    <th class="text-right" colspan="3"></th>
                </tr>
            {/if}
        </table>
    </div>
    
    <table style="display: none;" class="hide">
        {foreach item=users from=$summary key=branch}
            {foreach item=usersdata from=$users key=user}
            <tr class="{$branch}{$user} hide usersettlement">
                <td>
                    <br>
                    <div class="tabbable">
                        <ul class="nav nav-tabs" id="exp-tabs">
                            <li class="active">
                                <a data-toggle="tab" data-val="NA" href="#setting_vehicle">All</a>
                            </li>
                            <li>
                                <a data-toggle="tab" data-val="APRD" href="#setting_trip">Approved</a>
                            </li>
                            <li>
                                <a data-toggle="tab" data-val="REJT" href="#setting_branch">Rejected</a>
                            </li>
                            {if $action_rights['IE-APOVR-RJT']>0}
                            <li class="pull-right" style="margin: 9px 4px;">
                                <button class="btn-app btn-danger" id="summary-action-rj-{$branch}{$user}" onclick="rejectStatusDialog('chkd-data', 'REJT');"><i class="fa fa-times"></i> Reject</button>
                            </li>
                            <li class="pull-right" style="margin: 9px 4px;">
                                <button class="btn-app btn-primary" id="summary-action-ac-{$branch}{$user}" onclick="changeExpenseStatus('chkd-data', 'APRD');"><i class="fa fa-check"></i> Accept</button>
                            </li>
                            {/if}
                        </ul>
                        <div class="tab-content hide" id="tabs_content_a"></div>
                    </div>
                    <table class="table table-bordered" id="summary-table-{$branch}{$user}" width="100%">
                        <thead>
                            <tr class="active">
                                {if $action_rights['IE-APOVR-RJT']>0}
                                    <td>
                                        <input type="checkbox" id="checkall" onclick="checkAll('{$branch}{$user}');">
                                    </td>
                                {/if}
                                <td>Category</td>
                                <td>Expense For</td>
                                <td>Details</td>
                                <td>Income / Expense Type </td>
                                <td>Payment Mode </td>
                                <td>Vendor/receiver Inc. </td>
                                <th>Tags</th>
                                <td>Inc. Amount </td>
                                <td>Exp. Amount</td>
                                <th>Remarks</th>
                                <th>Cmt</th>
                                <td>Att.</td>
                                <td>Status</td>
                                <td></td>
                            </tr>
    
                        </thead>
    
                        <tbody class="body_table">
                            {foreach item=row from=$usersdata['list'] key=user}
                                {assign var="additionalDetails" value="|"|explode:$row->additional_details}
                                <tr data-status="{$row->ack_status_code}">
                                    {if $action_rights['IE-APOVR-RJT']>0}
                                        <td>
                                            {if $row->ack_status_code == 'INIT'}
                                                <input type="checkbox" id="manage-expense-checkbox" onclick="uncheck()" value="{$row->transaction_code}">
                                            {/if}
                                        </td>
                                    {/if}
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
                                    <td align="left">{$row->reference_details}</td>
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
                                                    <li><b>{$staffExp[2]} - {$staffExp[3]}</b></li>
                                                {/foreach}
                                            </ul>'><i class="fa fa-info-circle"></i></span>
                                            {/if}
                                        {/if}
                                    </td>

                                    <td align="left">
                                        <span data-toggle="tooltip" data-placement="top" title="{$row->remarks}">{(($row->remarks) ? $row->remarks : '-')|truncate:35:'...'}</span>
                                        {if isNotNull($additionalDetails[1])}
                                            , Approved By: {$additionalDetails[1]}</span>
                                        {/if}    
                                    </td>
                                    <td align="center">
                                        {if isNotNull($row->comments)}
                                            <span data-toggle="tooltip" data-placement="top" title="{$row->comments}"><i class="fa fa-comment"></i></span>
                                        {/if}
                                    </td>
                                    <td align="left">
                                        {if $row->image_count > 0}
                                            <div class="btn-group btn-group-xs">
                                                <button class="btn btn-default btn-sm" type="button"  onclick="showPRGallery('{$row->transaction_code}')"><i class="fa fa-picture-o" aria-hidden="true"></i></button>
                                            </div>
                                        {else}
                                            -
                                        {/if}
                                    </td>
                                    <td align="center">
                                        {* {if $row->ack_status_code == 'INIT'}  *}
                                            {* {if $action_rights['IE-APOVR-RJT']>0}
                                                <button class="btn-app btn-primary" type="button" onclick="changeExpenseStatus('{$row->transaction_code}', 'APRD');"><i class="fa fa-check"></i> Accept</button>
                                                <button class="btn-app btn-danger" type="button" onclick="changeExpenseStatus('{$row->transaction_code}', 'REJT');"><i class="fa fa-times"></i> Reject</button>
                                            
                                            {else}
                                                <i class="fa fa-exclamation-circle fa-lg text-warning"></i> Initiated
                                            {/if} *}
                                        {if $row->ack_status_code == 'INIT'}
                                            <i class="fa fa-exclamation-circle fa-lg text-warning"></i> Initiated
                                        {elseif $row->ack_status_code == 'APRD'}
                                            <i class="fa fa-check-circle fa-lg text-primary"></i> Approved
                                        {elseif $row->ack_status_code == 'REJT'}
                                            <i class="fa fa-times-circle fa-lg text-danger"></i> Rejected
                                        {/if}
                                    </td>
                                    <td align="center">
                                        <span class="pull-left" data-toggle="tooltip" data-placement="top" title="{$row->user_name}<br/>{$row->transaction_date|date_format:$ns_datetime_format}"><i class="fa fa-info-circle"></i></span>
                                    </td>
                                </tr>
                            {foreachelse}
                                <tr>
                                    <td colspan="100%" align="center">No data found</td>
                                </tr>
                            {/foreach}
                        </tbody>
                        <tfoot style="display: none">
                            <tr>
                            <td colspan="100%" align="center">No data found</td>
                        </tr>
                        </tfoot>
                    </table>
                </td>
            </tr>
        {/foreach}
        {/foreach}
    </table>
{elseif $smarty.request.group_by == 'DETAILS'}
    {assign var=b_income value=0}
    {assign var=b_expense value=0}
    {assign var=b_balance value=0}

    {if $action_rights['IE-APOVR-RJT'] > 0 && $action_rights['IE-ADD-COMMENTS'] != 1}
    <ul class="nav nav-tabs" id="exp-tabs">
        <li class="pull-right" style="margin: 9px 4px;">
            <button class="btn-app btn-danger" id="detail-action-rj" onclick="rejectStatusDialog('chkd-data', 'REJT');"><i class="fa fa-times"></i> Reject</button>
        </li>
        <li class="pull-right" style="margin: 9px 4px;">
            <button class="btn-app btn-primary" id="detail-action-ac" onclick="changeExpenseStatus('chkd-data', 'APRD');"><i class="fa fa-check"></i> Accept</button>
        </li>
    </ul>
    {/if}

    <table class="table table-bordered " id="details-table" width="100%">
    <thead>
        <tr class="success">
            {if $action_rights['IE-APOVR-RJT']>0}
                <th>
                    <input type="checkbox" id="checkall" onclick="checkAll();">
                </th>
            {/if}
            <th>Category</th>
            <th>Receipt Date</th>
            <th>Expense For</th>
            <th>Details</th>
            <th>Income / Expense Type </th>
            <th>Payment Mode </th>
            <th>Vendor/receiver Inc. </th>
            <th>Tags</th>
            <th>Inc. Amount </th>
            <th>Exp. Amount</th>
            <th>Remarks</th>
            <th>Cmt</th>
            <th>Att.</th>
            <th>{if $action_rights['IE-APOVR-RJT']>0}Actions{else}Status{/if}</th>
            <th></th>
        </tr>

    </thead>

    <tbody class="body_table">
        {foreach item=users from=$summary key=branch}
            {foreach item=usersdata from=$users key=user}
                <tr>
                    <td colspan="{if $action_rights['IE-APOVR-RJT']>0}16{else}15{/if}" align="center" class="bold">{$usersdata['organization_name']}</td>
                </tr>
                {assign var=b_income value=$b_income+$usersdata['income']}
                {assign var=b_expense value=$b_expense+$usersdata['expense']}
                {assign var=b_balance value=$b_balance+$usersdata['settlement']}

                {foreach item=row from=$usersdata['list'] key=user}
                    <tr>
                        {if $action_rights['IE-APOVR-RJT']>0}
                            <td>
                                {if $row->ack_status_code == 'INIT'}
                                    <input type="checkbox" id="manage-expense-checkbox" class="manage-expense-details-checkbox" onclick="uncheck()" value="{$row->transaction_code}">
                                {/if}
                            </td>
                        {/if}
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
                                        {$staffInc[1]} - {$staffInc[2]}<br>
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
                                        <li><b>{$staffInc[1]} - {$staffInc[2]}</b></li>
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
                                        {$staffExp[1]} - {$staffExp[2]}<br>
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
                                        <li><b>{$staffExp[1]} - {$staffExp[2]}</b></li>
                                    {/foreach}
                                </ul>'><i class="fa fa-info-circle"></i></span>
                                {/if}
                            {/if}
                        </td>
                        <td align="left"><span data-toggle="tooltip" data-placement="top" title="{$row->remarks}">{(($row->remarks) ? $row->remarks : '-')|truncate:35:'...'}</span></td>
                        <td align="center">
                            <span data-toggle="tooltip" data-placement="top" title="{$row->comments}" class="{if $row->comments == ''}hide{/if} {$row->transaction_code}-manage-exp-cmt"><i class="fa fa-comment"></i></span>
                            <span class="{if isNotNull($row->comments)}hide{/if} {$row->transaction_code}-manage-exp-cmt-def">-</span>
                        </td>
                        <td align="left">
                            {if $row->image_count > 0}
                                <div class="btn-group btn-group-xs">
                                    <button class="btn btn-default btn-sm" type="button"  onclick="showPRGallery('{$row->transaction_code}')"><i class="fa fa-picture-o" aria-hidden="true"></i></button>
                                </div>
                            {else}
                                -
                            {/if}
                        </td>
                        <td align="center">
                            {* {if $row->ack_status_code == 'INIT'}  *}
                            {* {if $action_rights['IE-APOVR-RJT']>0}
                                <button class="btn-app btn-primary" type="button" onclick="changeExpenseStatus('{$row->transaction_code}', 'APRD');"><i class="fa fa-check"></i> Accept</button>
                                <button class="btn-app btn-danger" type="button" onclick="changeExpenseStatus('{$row->transaction_code}', 'REJT');"><i class="fa fa-times"></i> Reject</button>
                            
                            {else}
                                <i class="fa fa-exclamation-circle fa-lg text-warning"></i> Initiated
                            {/if} *}
                            {if $row->ack_status_code == 'INIT'}
                                <i class="fa fa-exclamation-circle fa-lg text-warning"></i> Initiated
                            {elseif $row->ack_status_code == 'APRD'}
                                <i class="fa fa-check-circle fa-lg text-primary"></i> Approved
                            {elseif $row->ack_status_code == 'REJT'}
                                <i class="fa fa-times-circle fa-lg text-danger"></i> Rejected
                            {/if}
                        </td>
                        <td align="center" nowrap>
                            <span class="pull-left" data-toggle="tooltip" data-placement="top" title="{$row->user_name}{if isNotNull($row->alias_code)}<br/>{$row->alias_code}{/if}<br/>{$row->updated_at|date_format:$ns_datetime_format}"><i class="fa fa-info-circle" title="Updated By & Date"></i></span>
                            {if $action_rights['IE-ADD-COMMENTS'] == 1}
                                &nbsp;<a href="javascript:;" onclick="addManageExpenseComments('{$row->transaction_code}');" title="Add Comments"><i class="fa fa-plus"></i></a>
                            {/if}
                        </td>
                    </tr>
                    {* {assign var=b_income value=$b_income+$row->credit_amount}
                    {assign var=b_expense value=$b_expense+$row->debit_amount}
                    {assign var=b_balance value=$b_balance+($row->credit_amount - $row->debit_amount)} *}
                {* {foreachelse}
                    <tr>
                        <td colspan="100%" align="center">No data found</td>
                    </tr> *}
                {/foreach}
            {/foreach}
        {/foreach}
    </tbody>
        {if $result|count}
            <tr class="">
                {if $action_rights['IE-APOVR-RJT']>0}
                    <td></td>
                {/if}
                <th class="text-right" colspan="8">Total</th>
                <th>{$b_income|inr_format}</th>
                <th>{$b_expense|inr_format}</th>
                <th colspan="4"></th>
            </tr>
        {/if}
    </table>
{/if}

<div id="add-manage-expense-comment-dialog"  class="dialog-content-page hide">
    <div class="row">
        <div class="col-md-10 bold ft_15">
            Add Comments
        </div>
    </div>
    <br>
    <div class="row">
        <div class="form-group col-md-12">
            <label>Comment</label>
            <textarea id="manage-expense-comment"  placeholder="Enter your comment" style="resize:none" class="form-control" rows="2" cols="30"></textarea>
        </div>
    </div>
    
    <div style="padding:0 15px;">
        <div class="row">
            <input type="hidden" id="manage-expense-comment-code">
            <div class="clear_fix_both">
                <div class="alert hide" id="manage-expense-comment-action-state"></div>
                <div class="align-right" id="manage-expense-comment-button">
                    <button class="btn btn-success" type="button" onclick="saveManageExpenseComments();">Save</button>
                    <button class="btn btn-default" type="button" onclick="closeManageExpenseComment();">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</div>
    
<script src="assets/lib/highcharts/drilldown.js"></script>

<script>
    var lrdata = {$summary|json_encode};
    $('[data-toggle="tooltip"]').tooltip({
        html: true
    });

    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });

    if($('#details-table tbody tr #manage-expense-checkbox').length != 0){
        $('#detail-action-rj').show();
        $('#detail-action-ac').show();
    }else{
        $('#detail-action-rj').hide();
        $('#detail-action-ac').hide();
    }

    if (isNotNull(lrdata)){
        $('#dt_ss_report_table').dataTable({
            "bPaginate": false,
            "info": false,
            "dom": 'lrt',
            "aaSorting": [[ 1, "asc" ]]
        });
    }

    function uncheck() {
        $('#checkall').prop("checked", false);
    }
    
    function toggleUsersSettlement(code) {
        
        if($('#summary-table-'+code+' .body_table tr #manage-expense-checkbox').length != 0){
            $('#summary-action-rj-'+code).show();
            $('#summary-action-ac-'+code).show();
        }else{
            $('#summary-action-rj-'+code).hide();
            $('#summary-action-ac-'+code).hide();
        }

        if($('.saleusrlist').hasClass(code)) {
            $('.saleusrlist .slide').slideToggle('linear', function() {
                $('.saleusrlist').remove();
            });
            return;
        }
        $('.saleusrlist').remove();
        var $trows = $('.usersettlement').filter('.' + code);
        $('#'+code).after('<tr class="saleusrlist ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">'
                + $trows.html() + '</table></div></td></tr>');
        $('.saleusrlist .slide').slideToggle('linear');

        $('#exp-tabs').on('show.bs.tab', function (e) {
            tab = $(e.target).attr('data-val')
            if (tab == 'NA') {
                $('.saleusrlist').find('tr[data-status]').show()
                return
            }
            $('.saleusrlist').find('tr[data-status]').hide()
            $tr = $('.saleusrlist').find('tr[data-status="'  + tab+'"]').show()
            if ($tr.length) {
            $('.saleusrlist').find('tfoot').hide()
            } else {                
            $('.saleusrlist').find('tfoot').show()
            }
            })
            
        $('[data-toggle="tooltip"]').tooltip({
            html: true
        });

        $('[data-toggle="popover"]').popover({
            placement: 'top',
            html: true,
            trigger: 'hover'
        });
    }

    function renderChart() {
        var data = {$series|json_encode};

        var series = [];
        var drilldown = [];
        $.each(data || [], function (i, row) {
            series.push({
                name: row.name,
                y: row.y,
                drilldown: row.drilldown
            });

            drilldown.push({
                name: row.name,
                id: row.name,
                data: Object.values(row.data)
            });
        });

        $('#settle-amt').html('{$b_balance|inr_format}');
        $('#chart-pannel').removeClass('hide');

        var title = '{$smarty.request.from|date_format:'%d-%b-%Y'} to {$smarty.request.to|date_format:'%d-%b-%Y'}'

        {literal}
            // Create the chart
            chart = new Highcharts.Chart('donut-container', {
                chart: {
                    type: 'pie',
                    events: {
                        drilldown: function(e) {
                            this.setTitle({ text: e.seriesOptions.name });
                            this.xAxis[0].update({ lineColor : '#ccd6eb' });
                        },
                        drillup: function() {
                            this.setTitle({ text: title });
                            this.xAxis[0].update({ lineColor : '#ffffff' });
                        }
                    }
                },
                title: { 
                    text: title,
                    style: { fontSize: '12px', fontWeight: 'bold', float: 'left' }
                },
                xAxis: { type: 'category' },
                yAxis: { title: '' },
                plotOptions: {
                    pie: {
                        size: '100%',
                        innerSize: '20%',
                        showInLegend:true,
                        dataLabels: {
                            enabled: false
                        }
                    }
                },
                tooltip: {
                    formatter: function() {
                        return '<b>'+ this.point.name +'</b>: Rs. '+ INRFormat(this.y) +'';
                    }
                },
                legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'middle',
                    itemMarginTop: 10
                },
                credits:{ enabled:false },
                exporting:{ enabled:false },
                colors:["#4665D9","#3A0CA3","#FF6040","#A05030","#D0B090","#6600FF","#64E572","#FF9655","#FFF263","#6AF9C4"],
                series: [{
                    name: 'Income / Expenses',
                    data: series
                }],
                drilldown: {
                    drillUpButton: {
                        position: {
                            x: 110,
                            y: -15
                        }
                    },
                    series: drilldown || []
                }
            });            
        {/literal}
    }
    renderChart()
    
    function INRFormat(num = 0) {
        return Number(num).toLocaleString('en-IN', { maximumFractionDigits: 2, minimumFractionDigits: 2 });
    }

    function changeExpenseStatus(code , status) {
        var data = {};
        if(code == 'chkd-data'){
            var checked = [];
            $.each($('#manage-expense-checkbox:checked'), function(){
                checked.push($(this).val());
            });
            if(checked.length >0){
                data.code = checked.join(',');
            }else{
                return;
            }
        }else{
            data.code = code;
        }

        data.acknowledgeStatus = {};
        data.acknowledgeStatus.code = status;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "payment/update-payment-expense-status",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                    searchTransBooking();
                }, 2000);
            }
        })
    }

    function checkAll(code) {
        if($('#checkall').prop('checked') == true){
            $.each($('#summary-table-'+code+':first tbody tr #manage-expense-checkbox'), function(){
                $(this).prop("checked", true).trigger('change');
            });

            $.each($('#details-table tr #manage-expense-checkbox'), function(){
                $(this).prop("checked", true).trigger('change');
            });
        }else{
            $.each($('#summary-table-'+code+' tbody tr #manage-expense-checkbox'), function(){
                $(this).prop("checked", false).trigger('change');
            });

            $.each($('#details-table tr #manage-expense-checkbox'), function(){
                $(this).prop("checked", false).trigger('change');
            });
        }
    }

    function addManageExpenseComments(code) {
        $('#add-manage-expense-comment-dialog').css('background', '#fff');
        $('#add-manage-expense-comment-dialog').removeClass('hide');
        $('#add-manage-expense-comment-dialog').dialog({
            autoOpen: true,
            height: 350,
            width: 500,
            modal: true,
            resizable: false,
            closeOnEscape: true
        });
        $('.ui-dialog-titlebar').hide();
        $('.inp_error').removeClass('inp_error');
        $('#manage-expense-comment-action-state').removeClass('alert-success, alert-danger').html('').hide();
        $('#manage-expense-comment-code, #manage-expense-comment').val('');
        $('#manage-expense-comment-button').removeClass('hide');

        if (isNotNull(code)) {
            $('#manage-expense-comment-code').val(code)
            var comment = $('.'+code+'-manage-exp-cmt').attr('data-original-title');
            if (isNotNull(comment)) {
                $('.'+code+'-manage-exp-cmt').removeClass('hide');
            }
            $('#manage-expense-comment').val(comment);
        }
    }

    function closeManageExpenseComment() {
        $('#add-manage-expense-comment-dialog').addClass('hide');
        $('#add-manage-expense-comment-dialog').dialog('destroy');
    }

    function saveManageExpenseComments() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        var data = {};
        data.code = $('#manage-expense-comment-code').val();
        data.comments = $('#manage-expense-comment').val();

        if (isNull(data.comments)) {
            $('#manage-expense-comment').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#manage-expense-comment-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#manage-expense-comment-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#manage-expense-comment-action-state').show();
            return false;
        } else {
            $('#manage-expense-comment-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#manage-expense-comment-action-state').html('');
            $('#manage-expense-comment-action-state').hide();
        }
        
        $('#manage-expense-comment-action-state').removeClass('alert-success, alert-danger, hide');
        $('#manage-expense-comment-action-state').html(loading_popup).show();
        $('#manage-expense-comment-button').addClass('hide');

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'payment/update-manage-expense-comments',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#manage-expense-comment-action-state').removeClass('alert-danger');
                    $('#manage-expense-comment-action-state').addClass('alert-success');
                    $('#manage-expense-comment-action-state').html('Your request has been completed successfully');
                    $('.'+data.code+'-manage-exp-cmt-def').addClass('hide');
                    $('.'+data.code+'-manage-exp-cmt').removeClass('hide')
                                                                .attr('title', data.comments)
                                                                .tooltip('fixTitle');
                    window.setTimeout(function() {
                        closeManageExpenseComment();
                    }, 3000);
                } else {
                    $('#manage-expense-comment-action-state').addClass('alert-danger');
                    $('#manage-expense-comment-action-state').html(response.errorDesc);
                    $('#manage-expense-comment-button').removeClass('hide');
                }
            }
        });
    }
</script>