<div class="table-responsive overflow-x-auto">
    <div class="btn-group btn-group-sm pull-right">
        <button class="btn btn-default" onclick="exportBranchReceiptExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default notpaytypeprint" onclick="branchReceiptPrint()"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>
<br>
{function name="paymentTable" data=[]}
    <div class="table-responsive">
        <table class="table table-bordered branch-receipt-table">
            {if $paymentAcknowledgeStatus == 'RJECT'}
                <div class="row">
                    <p class="bold col-md-5">Rejected List</p>
                </div>
            {/if}
            <thead>
                <tr style="background-color: #64b92a; color: #000;">
                    <th class="text-center" nowrap>Code</th>
                    <th class="text-center" nowrap width="10%">Branch</th>
                    <th class="text-center" nowrap>Opening bal<br>(A)</th>
                    <th class="text-center" nowrap>Paid Bk<br>(B)</th>
                    <th class="text-center" nowrap>ToPay Deli<br>(C)</th>
                    <th class="text-center" nowrap>O Income<br>(D)</th>
                    <th class="text-center" nowrap>Exp<br>(E)</th>
                    <th class="text-center" nowrap>Comm<br>(F)</th>
                    <th class="text-center" nowrap>Revert<br>(G)</th>
                    <th class="text-center" nowrap>Total<br>(H=B+C+D-E-F-G)</th>
                    <th class="text-center" nowrap>Settlement<br>(I=A+H)</th>
                    {if $paymentAcknowledgeStatus == 'NA'}
                        <th class="text-center" nowrap>Paid</th>
                        <th class="text-center" nowrap>Payable</th>
                    {else}
                        <th class="text-center" nowrap>{if $paymentAcknowledgeStatus == 'ACKED'}Paid {else}Payable{/if}</th>
                    {/if}
                    <th class="text-center" nowrap>Diff. </th>
                    {if in_array($paymentAcknowledgeStatus, ['PAID', 'INITD'])}
                        <th class="text-center" nowrap class="noprint">Action</th>
                    {else}
                        <th class="noprint" nowrap></th>
                    {/if}
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var="totalOpeningBalanceAmount" value=0}
                {assign var="totalBookedAmount" value=0}
                {assign var="totalDeliveryAmount" value=0}
                {assign var="totalTotalOtherIncomeAmount" value=0}
                {assign var="totalTotalExpenseAmount" value=0}
                {assign var="totalCommissionAmount" value=0}
                {assign var="totalRevertAmount" value=0}
                {assign var="totalTotalAmount" value=0}
                {assign var="totalSettlementAmount" value=0}
                {assign var="totalPaidAmount" value=0}
                {assign var="totalPayableAmount" value=0}
                {foreach item=row from=$data key=t}
                    {assign var="openingBalanceAmount" value=0}
                    {foreach from=$row['organizationReceiptDetails'] item=detail}
                        {assign var="openingBalanceAmount" value=$openingBalanceAmount + $detail->openingBalanceAmount}
                    {/foreach}
                    <tr id="row-{$row['code']}-{$row['branch']->code}" class="tr-hover" onclick="toggleBranch('row-{$row['code']}-{$row['branch']->code}');" title="Click to view this branches transactions">
                        <td align="left">
                            {$row['code']}<br>
                            <span class="text-muted">{$row['createdAt']|date_format:'d, M g:i A'}</span>
                        </td>
                        <td align="left">
                            {$row['branch']->name}<br>
                            <span class="text-muted">{$row['username']}{if isNotNull($row['aliasCode'])} - {$row['aliasCode']}{/if}</span>
                        </td>
                        <td align="right">{$openingBalanceAmount|inr_format|default:'-'}</td>
                        <td align="right">{$row['bookedAmount']|inr_format}</td>
                        <td align="right">{$row['deliveryAmount']|inr_format}</td>
                        <td align="right">{$row['totalIncomeAmount']|inr_format}</td>
                        <td align="right">{$row['totalExpenseAmount']|inr_format}</td>
                        <td align="right">{$row['commissionAmount']|inr_format}</td>
                        <td align="right">{$row['revertAmount']|inr_format}</td>
                        <td align="right">
                            {$row['settlementAmount']|inr_format}
                        </td>

                        <td align="right">
                            {($openingBalanceAmount + $row['settlementAmount'])|inr_format}
                        </td>

                        {if $paymentAcknowledgeStatus == 'NA'}
                            <td align="right">
                                {if $row['paymentAcknowledgeCode'] == 'ACKED'}
                                    {$row['paidAmount']|inr_format}<br>
                                    <span class="text-muted">{$row['paymentMode']}</span>
                                {else}
                                    -&nbsp;
                                {/if}
                            </td>
                            <td align="right">
                                {if $row['paymentAcknowledgeCode'] == 'INITD'}
                                    {$row['paidAmount']|inr_format}<br>
                                    <span class="text-muted">{$row['paymentMode']}</span>
                                {else}
                                    -&nbsp;
                                {/if}
                            </td>
                        {else}
                            <td align="right">
                                {$row['paidAmount']|inr_format}<br>
                                <span class="text-muted">{$row['paymentMode']}</span>
                            </td>
                        {/if}

                        <td align="right">
                            {assign var="differnceAmount" value=(($row['settlementAmount'] + $openingBalanceAmount) - $row['paidAmount'])}
                            {$differnceAmount|abs|inr_format}
                            {if inr_format($differnceAmount) > 0}
                                <br><span class="text-danger">Paid Less</span>
                            {elseif inr_format($differnceAmount) < 0}
                                <br><span class="text-success">Paid More</span>
                            {/if}
                        </td>

                        <td class="noprint no-wrap">
                            {if $row['remarks']}
                                &emsp;<a href="javascript:;" title="Remarks" data-toggle="popover" class="has-popover" data-content="{$row['remarks']}"><i class="fa fa-info-circle" aria-hidden="true"></i></a>&emsp;
                            {/if}
                        </td>
                    </tr>
                    {assign var="totalOpeningBalanceAmount" value=$totalOpeningBalanceAmount + $row['totalOpeningBalanceAmount']}
                    {assign var="totalBookedAmount" value=$totalBookedAmount + $row['totalBookedAmount']}
                    {assign var="totalDeliveryAmount" value=$totalDeliveryAmount + $row['totalDeliveryAmount']}
                    {assign var="totalTotalOtherIncomeAmount" value=$totalTotalOtherIncomeAmount + $row['totalTotalOtherIncomeAmount']}
                    {assign var="totalTotalExpenseAmount" value=$totalTotalExpenseAmount + $row['totalTotalExpenseAmount']}
                    {assign var="totalCommissionAmount" value=$totalCommissionAmount + $row['totalCommissionAmount']}
                    {assign var="totalRevertAmount" value=$totalRevertAmount + $row['totalRevertAmount']}
                    {assign var="totalTotalAmount" value=$totalTotalAmount +($row['totalBookedAmount'] + $row['totalDeliveryAmount'] + $row['totalTotalOtherIncomeAmount'] - $row['totalTotalExpenseAmount'] - $row['totalCommissionAmount'] - $row['totalRevertAmount'] ) }
                    {assign var="totalSettlementAmount" value=$totalSettlementAmount + (($row['totalOpeningBalanceAmount'])+($row['totalBookedAmount'] + $row['totalDeliveryAmount'] + $row['totalTotalOtherIncomeAmount'] - $row['totalTotalExpenseAmount'] - $row['totalCommissionAmount'] - $row['totalRevertAmount']))}
                    {assign var="totalPaidAmount" value=$totalPaidAmount + $row['totalPaidAmount']}
                    {assign var="totalPayableAmount" value=$totalPayableAmount + $row['totalPayableAmount']}
                {foreachelse}
                    <tr>
                        <td colspan="100%" align="center">No Records Found!</td>
                    </tr>
                {/foreach}
            </tbody>
            <tfoot>
                {if $branch_receipt|count}
                    <tr style="background-color: #bbbbbb;" class="bold">
                        <td colspan="2" align="right">Total:</td>
                        <td align="right">{$totalOpeningBalanceAmount|inr_format}</td>
                        <td align="right">{$totalBookedAmount|inr_format}</td>
                        <td align="right">{$totalDeliveryAmount|inr_format}</td>
                        <td align="right">{$totalTotalOtherIncomeAmount|inr_format}</td>
                        <td align="right">{$totalTotalExpenseAmount|inr_format}</td>
                        <td align="right">{$totalCommissionAmount|inr_format}</td>
                        <td align="right">{$totalRevertAmount|inr_format}</td>
                        <td align="right">{$totalTotalAmount|inr_format}</td>
                        <td align="right">{$totalSettlementAmount|inr_format}</td>
                        {if $paymentAcknowledgeStatus == 'ACKED'}
                            <td align="right">{$totalPaidAmount|default:'0.00'|inr_format}</td>
                        {else}
                            <td align="right">{$totalPayableAmount|default:'0.00'|inr_format}</td>
                        {/if}
                        <td align="right"></td>
                        <td align="right"></td>
                    </tr>
                {/if}
            </tfoot>
        </table>
    </div>
{/function}

{function name="branchDrillDown" data=[]}
    <table class="hide noprint">
        {foreach item=receipt from=$data key=t}
            <tr class="row-{$receipt['code']}-{$t} hide branch-drill-down">
                <td>
                    <table class="table table-bordered m_b_5">
                        <thead>
                            <tr class="active">
                                <th class="text-center" nowrap>Code</th>
                                {* <th class="text-center" width="10%">Branch</th> *}
                                <th class="text-center" nowrap>Opening bal<br>(A)</th>
                                <th class="text-center" nowrap>Paid Bk<br>(B)</th>
                                <th class="text-center" nowrap>ToPay Deli<br>(C)</th>
                                <th class="text-center" nowrap>O Income<br>(D)</th>
                                <th class="text-center" nowrap>Exp<br>(E)</th>
                                <th class="text-center" nowrap>Comm<br>(F)</th>
                                <th class="text-center" nowrap>Revert<br>(G)</th>
                                <th class="text-center" nowrap>Total<br>(H=B+C+D-E-F-G)</th>
                                <th class="text-center" nowrap>Settlement<br>(I=A+H)</th>
                                <th class="text-center" nowrap>{if $paymentAcknowledgeStatus == 'ACKED'}Paid{else}Payable{/if}</th>
                                <th class="text-center" nowrap>Diff.</th>
                                {if in_array($paymentAcknowledgeStatus, ['PAID', 'INITD'])}
                                    <th class="text-center" nowrap class="noprint">Action</th>
                                {else}
                                    <th class="noprint" nowrap></th>
                                {/if}
                            </tr>
                        </thead>
                        <tbody class="body_table">
                            {foreach item=row from=$receipt['data']}

                                {assign var="openingBalanceAmount" value=0}
                                {foreach from=$row->organizationReceiptDetails item=detail}
                                    {assign var="openingBalanceAmount" value=$openingBalanceAmount + $detail->openingBalanceAmount}
                                {/foreach}
                                <tr id="brn-{$row->code}" class="tr-hover" onclick="togglePaymentReceipt('brn-{$row->code}');" title="Click to view payment adjusted vouchers">
                                    <td align="left">
                                        {$row->code}<br>
                                        <span class="text-muted">{$row->createdAt|date_format:'d, M g:i A'}</span>
                                    </td>
                                    {* <td align="left">
                                        {$row->organization->name}<br>
                                        <span class="text-muted">{$row->user->name}{if isNotNull($row->user->aliasCode)} - {$row->user->aliasCode}{/if}</span>
                                    </td> *}
                                    <td align="right">{$openingBalanceAmount|inr_format|default:'-'}</td>
                                    <td align="right">{$row->bookedAmount|inr_format}</td>
                                    <td align="right">{$row->deliveryAmount|inr_format}</td>
                                    <td align="right">{$row->totalIncomeAmount|inr_format}</td>
                                    <td align="right">{$row->totalExpenseAmount|inr_format}</td>
                                    <td align="right">{$row->commissionAmount|inr_format}</td>
                                    <td align="right">{$row->revertAmount|inr_format}</td>
                                    <td align="right">{$row->settlementAmount|inr_format}</td>
                                    <td align="right">{($openingBalanceAmount + $row->settlementAmount)|inr_format}</td>

                                    {if $paymentAcknowledgeStatus == 'NA'}
                                        <td align="right">
                                            {if $row->paymentAcknowledge->code == 'ACKED'}
                                                {$row->paidAmount|inr_format}<br>
                                                <span class="text-muted">{$row->organizationReceiptDetails[0]->paymentMode->name}</span>
                                            {else}
                                                -&nbsp;
                                            {/if}
                                        </td>
                                        <td align="right">
                                            {if $row->paymentAcknowledge->code == 'INITD'}
                                                {$row->paidAmount|inr_format}<br>
                                                <span class="text-muted">{$row->organizationReceiptDetails[0]->paymentMode->name}</span>
                                            {else}
                                                -&nbsp;
                                            {/if}
                                        </td>
                                    {else}
                                        <td align="right">
                                            {$row->paidAmount|inr_format}<br>
                                            <span class="text-muted">{$row->organizationReceiptDetails[0]->paymentMode->name}</span>
                                        </td>
                                    {/if}

                                    <td align="right">
                                        {assign var="differnceAmount" value=(($row->settlementAmount + $openingBalanceAmount) - $row->paidAmount)}
                                        {$differnceAmount|abs|inr_format}
                                        {if inr_format($differnceAmount) > 0}
                                            <br><span class="text-danger">Paid Less</span>
                                        {elseif inr_format($differnceAmount) < 0}
                                            <br><span class="text-success">Paid More</span>
                                        {/if}
                                    </td>

                                    <td class="noprint no-wrap">
                                        {if $row->remarks}
                                            &emsp;<a href="javascript:;" title="Remarks" data-toggle="popover" class="has-popover" data-content="{$row->remarks}"><i class="fa fa-info-circle" aria-hidden="true"></i></a>&emsp;
                                        {/if}
                                        {if $paymentAcknowledgeStatus == 'PAID'}
                                            {if $action_rights['DAY-CLO-APPR-RJCT']>0}
                                                <button class="btn-app btn-success" type="button" onclick="receiptStatusDialog('{$row->code}', 'ACKED');">Acknowledge</button>
                                                <button class="btn-app btn-danger" type="button" onclick="receiptStatusDialog('{$row->code}', 'RJECT');">Reject</button>
                                            {/if}
                                        {elseif ($paymentAcknowledgeStatus == 'INITD' || $paymentAcknowledgeStatus == 'NA') && ($row->paymentAcknowledge->code !== 'RJECT' && $row->paymentAcknowledge->code !== 'ACKED')}
                                            {if $action_rights['DAY-CLO-APPR-RJCT']>0}
                                                <button class="btn-app btn-success" type="button" onclick="receiptStatusDialog('{$row->code}', 'ACKED');">Acknowledge</button>
                                                <button class="btn-app btn-danger" type="button" onclick="receiptStatusDialog('{$row->code}', 'RJECT');">Reject</button>
                                            {/if}
                                        {/if}
                                    </td>
                                </tr>
                            {foreachelse}
                                <tr>
                                    <td colspan="100%" align="center">No Records Found!</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </td>
            </tr>
        {/foreach}
    </table>
{/function}

{function name="paymentDrillDown" data=[]}
    <table class="hide noprint">
        {foreach item=brn from=$data key=branchCode}
            {foreach item=receipt from=$brn['data'] key=t}
                <tr class="brn-{$receipt->code} hide paymentreceipt">
                    <td>
                        <table class="table table-bordered m_b_5">
                            <thead>
                                <tr class="active">
                                    {* <th class="text-center">Voucher No</th> *}
                                    <th class="text-center">From</th>
                                    <th class="text-center">To</th>
                                    <th class="text-center">User</th>
                                    <th class="text-center">Mode</th>
                                    <th class="text-center">Opening bal<br>(A)</th>
                                    <th class="text-center">Paid Bk<br>(B)</th>
                                    <th class="text-center">ToPay Deli<br>(C)</th>
                                    <th class="text-center">O Income<br>(D)</th>
                                    <th class="text-center">Exp<br>(E)</th>
                                    <th class="text-center">Comm<br>(F)</th>
                                    <th class="text-center">Revert <br>(G)</th>
                                    <th class="text-center">Total <br>(H=B+C+D-E-F-G)</th>
                                    <th class="text-center">Settlement<br>(I=A+H)</th>
                                    <th class="text-center">{if $paymentAcknowledgeStatus == 'ACKED'}Paid{else}Payable{/if}</th>
                                </tr>
                            </thead>
                            <tbody class="body_table">
                                {foreach item=row from=$receipt->organizationReceiptDetails}
                                    <tr id="vou_{$row->code}">
                                        {* <td align="left">{$row->code}</td> *}
                                        <td align="left" nowrap>{$row->fromDateTime|date_format:$ns_datetime_format}</td>
                                        <td align="left" nowrap>{$row->toDateTime|date_format:$ns_datetime_format}</td>
                                        <td align="left">{$row->fromUser->name}{if isNotNull($row->fromUser->aliasCode)}<br><span class="text-muted">{$row->fromUser->aliasCode}</span>{/if}</td>
                                        <td align="left">
                                            {$row->paymentMode->name}<br>
                                            <span class="text-muted">
                                                {if isNotNull($row->addAttr1) || isNotNull($row->addAttr2) || isNotNull($row->addAttr3)}
                                                    {$row->addAttr1|default:'-'}, {$row->addAttr2|default:'-'}, {$row->addAttr3|default:'-'}<br>
                                                {/if}

                                                {if $row->bankDetails->code}
                                                    {$row->bankDetails->bankName}, {$row->bankDetails->branchLocation}
                                                {elseif $row->chequeDetails->code}
                                                    {$row->chequeDetails->chequeNo}, {$row->chequeDetails->payerDetails}, {$row->chequeDetails->chequeDate|date_format:$ns_date_format}
                                                {/if}
                                            </span>
                                        </td>
                                        <td align="right"><a href="javascript:;" onclick="showOpeningBalancedetails('{$row->code}', '{$branchCode}', '{$row->fromUser->code}');">{$row->openingBalanceAmount|inr_format}</a></td>
                                        <td align="right"><a href="javascript:;" onclick="showLRdetails('{$row->fromUser->code}', 'BO', '{$row->fromDateTime}', '{$row->toDateTime}');">{$row->bookedAmount|inr_format}</a></td>
                                        <td align="right"><a href="javascript:;" onclick="showLRdetails('{$row->fromUser->code}', 'TDL', '{$row->fromDateTime}', '{$row->toDateTime}');">{$row->deliveryAmount|inr_format}</a></td>
                                        <td align="right"><a href="javascript:;" onclick="showIEdetails('{$receipt->organization->code}', 'Cr', '{$row->fromDateTime}', '{$row->toDateTime}', '{$receipt->code}');">{$row->incomeAmount|inr_format}</a></td>
                                        <td align="right"><a href="javascript:;" onclick="showIEdetails('{$receipt->organization->code}', 'Dr', '{$row->fromDateTime}', '{$row->toDateTime}', '{$receipt->code}');">{$row->expenseAmount|inr_format}</a></td>
                                        <td align="right"><a href="javascript:;" onclick="showLRdetails('{$row->fromUser->code}', 'COM', '{$row->fromDateTime}', '{$row->toDateTime}');">{$row->commissionAmount|inr_format}</a></td>
                                        <td align="right"><a href="javascript:;" onclick="showLRdetails('{$row->fromUser->code}', 'RVT', '{$row->fromDateTime}', '{$row->toDateTime}');">{$row->revertAmount|inr_format}</a></td>
                                        <td align="right">{$row->settlementAmount|inr_format}</td>
                                        <td align="right">{($row->openingBalanceAmount + $row->settlementAmount)|inr_format}</td>
                                        <td align="right">{$row->paidAmount|inr_format}</td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="100%" align="center">No Records Found!</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </td>
                </tr>
            {/foreach}
        {/foreach}
    </table>
{/function}

{call paymentTable data=$branch_receipt paymentAcknowledgeStatus=$paymentAcknowledgeStatus}
{call branchDrillDown data=$branch_receipt paymentAcknowledgeStatus=$paymentAcknowledgeStatus}
{call paymentDrillDown data=$branch_receipt}
<script>
    var paymentReceiptData = {$result|json_encode};
    $('[data-toggle="tooltip"]').tooltip();

    $(".has-popover").popover({
        trigger: 'hover',
        placement: 'top',
        html: true
    });

    function toggleBranch(code) {
        if ($(event.target).is('button, a, i')) {
            return;
        }
        if ($('.branchlist').hasClass(code)) {
            $('.branchlist .slide').slideToggle('linear', function() {
                $('.branchlist').remove();
            });
            return;
        }
        $('.branchlist').remove();
        var $trows = $('.branch-drill-down').filter('.' + code);
        $('#' + code).after('<tr class="branchlist ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">' +
            $trows.html() + '</table></div></td></tr>');
        $('.branchlist .slide').slideToggle('linear');
        $(".has-popover").popover({
            trigger: 'hover',
            placement: 'top',
            html: true
        });
    }

    function togglePaymentReceipt(code) {
        if ($(event.target).is('button, a, i')) {
            return;
        }
        if ($('.receiptlist').hasClass(code)) {
            $('.receiptlist .slide').slideToggle('linear', function() {
                $('.receiptlist').remove();
            });
            return;
        }
        $('.receiptlist').remove();
        var $trows = $('.paymentreceipt').filter('.' + code);
        $('#' + code).after('<tr class="receiptlist ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">' +
            $trows.html() + '</table></div></td></tr>');
        $('.receiptlist .slide').slideToggle('linear');
    }
</script>