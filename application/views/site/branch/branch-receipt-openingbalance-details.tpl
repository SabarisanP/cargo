{function name="paymentTable" data=[]}
    <div class="table-responsive overflow-x-auto">
        <table class="table table-bordered">
            <thead>
                <tr class="success">
                    <th align="center" nowrap>Transaction Code</th>
                    <th align="center" nowrap width="10%">Branch</th>
                    <th align="center" nowrap>Opening balance</th>
                    <th align="center" nowrap>Paid Booking</th>
                    <th align="center" nowrap>ToPay Delivery</th>
                    <th align="center" nowrap>Other Income</th>
                    <th align="center" nowrap>Expenses</th>
                    <th align="center" nowrap>Commissions</th>
                    <th align="center" nowrap>Revert Payment</th>
                    <th align="center" nowrap>Settlement Amount</th>
                    <th align="center" nowrap>{if $paymentAcknowledgeStatus == 'ACKED'}Paid Amount{else}Payable{/if}</th>
                    <th align="center" nowrap>Diff. Amount</th>
                    <th align="center" nowrap>Pending Amount</th>
                    <th class="noprint" nowrap></th>
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
                {assign var="totalSettlementAmount" value=0}
                {assign var="totalPaidAmount" value=0}
                {assign var="totalPayableAmount" value=0}
                {assign var="totalPendingAmount" value=0}
                {foreach item=row from=$data key=t}
                    {assign var="openingBalanceAmount" value=0}
                    {foreach from=$row->organizationReceiptDetails item=detail}
                        {assign var="openingBalanceAmount" value=$openingBalanceAmount + $detail->openingBalanceAmount}
                    {/foreach}
                    <tr id="openingbalance-{$row->code}" class="tr-hover" onclick="togglePaymentReceiptOpeningBal('openingbalance-{$row->code}');" title="Click to view this branches transactions">
                        <td align="left">
                            {$row->code}<br>
                            <span class="text-muted">{$row->createdAt|date_format:'d, M g:i A'}</span>
                        </td>
                        <td align="left">
                            {$row->organization->name}<br>
                            <span class="text-muted">{$row->user->name}{if isNotNull($row->user->aliasCode)} - {$row->user->aliasCode}{/if}</span>
                        </td>
                        <td align="right">{$openingBalanceAmount|inr_format|default:'-'}</td>
                        <td align="right">{$row->bookedAmount|inr_format}</td>
                        <td align="right">{$row->deliveryAmount|inr_format}</td>
                        <td align="right">{$row->totalIncomeAmount|inr_format}</td>
                        <td align="right">{$row->totalExpenseAmount|inr_format}</td>
                        <td align="right">{$row->commissionAmount|inr_format}</td>
                        <td align="right">{$row->revertAmount|inr_format}</td>
                        <td align="right">
                            {$row->settlementAmount|inr_format}<br>
                            <span class="text-muted">{$row->paymentMode}</span>
                        </td>

                        <td align="right">{$row->paidAmount|inr_format}</td>

                        <td align="right">
                            {assign var="differnceAmount" value=(($row->settlementAmount + $openingBalanceAmount) - $row->paidAmount)}
                            {$differnceAmount|abs|inr_format}
                            {if inr_format($differnceAmount) > 0}
                                <br><span class="text-danger">Paid Less</span>
                            {elseif inr_format($differnceAmount) < 0}
                                <br><span class="text-success">Paid More</span>
                            {/if}
                        </td>

                        <td align="right">
                            {$row->totalPendingAmount|inr_format}
                            {if isNotNull($row->pendingPaymentDetails)}
                            &emsp;<a href="javascript:;" data-toggle="popover" class="has-popover" data-content="{$row->pendingPaymentDetails}"><i class="fa fa-comment" aria-hidden="true"></i></a>
                            {/if}
                        </td>
                        
                        <td class="noprint no-wrap">
                            {if $row->remarks}
                                &emsp;<a href="javascript:;" title="Remarks" data-toggle="popover" class="has-popover" data-content="{$row->remarks}"><i class="fa fa-info-circle" aria-hidden="true"></i></a>&emsp;
                            {/if}
                        </td>
                    </tr>
                    {assign var="totalOpeningBalanceAmount" value=$totalOpeningBalanceAmount + $openingBalanceAmount}
                    {assign var="totalBookedAmount" value=$totalBookedAmount + $row->bookedAmount}
                    {assign var="totalDeliveryAmount" value=$totalDeliveryAmount + $row->deliveryAmount}
                    {assign var="totalTotalOtherIncomeAmount" value=$totalTotalOtherIncomeAmount + $row->totalIncomeAmount}
                    {assign var="totalTotalExpenseAmount" value=$totalTotalExpenseAmount + $row->totalExpenseAmount}
                    {assign var="totalCommissionAmount" value=$totalCommissionAmount + $row->commissionAmount}
                    {assign var="totalRevertAmount" value=$totalRevertAmount + $row->revertAmount}
                    {assign var="totalSettlementAmount" value=$totalSettlementAmount + $row->settlementAmount}
                    {assign var="totalPaidAmount" value=$totalPaidAmount + $row->paidAmount}
                    {assign var="totalPayableAmount" value=$totalPayableAmount + $row->paidAmount}
                    {assign var="totalPendingAmount" value=$totalPendingAmount + $row->totalPendingAmount}
                {foreachelse}
                    <tr>
                        <td colspan="100%" align="center">No Records Found!</td>
                    </tr>
                {/foreach}

                {if $data|count}
                    <tr class="bold">
                        <td colspan="2" align="right">Total:</td>
                        <td align="right">{$totalOpeningBalanceAmount|inr_format}</td>
                        <td align="right">{$totalBookedAmount|inr_format}</td>
                        <td align="right">{$totalDeliveryAmount|inr_format}</td>
                        <td align="right">{$totalTotalOtherIncomeAmount|inr_format}</td>
                        <td align="right">{$totalTotalExpenseAmount|inr_format}</td>
                        <td align="right">{$totalCommissionAmount|inr_format}</td>
                        <td align="right">{$totalRevertAmount|inr_format}</td>
                        <td align="right">{$totalSettlementAmount|inr_format}</td>
                        <td align="right">{$totalPaidAmount|inr_format}</td>
                        <td align="right"></td>
                        <td align="right">{$totalPendingAmount|inr_format}</td>
                        <td align="right"></td>
                    </tr>
                {/if}
            </tbody>
        </table>
    </div>
{/function}

{function name="paymentDrillDown" data=[]}
    <table class="hide noprint">
    {foreach item=receipt from=$data key=t}
        <tr class="openingbalance-{$receipt->code} hide paymentreceipt-openingbal">
            <td>
                <table class="table table-bordered m_b_5">
                    <thead>
                        <tr class="active">
                            <th align="center">Voucher No</th>
                            <th align="center">From</th>
                            <th align="center">To</th>
                            <th align="center">User</th>
                            <th align="center" width="17%">Transaction Mode</th>
                            <th align="center">Opening balance</th>
                            <th align="center">Paid Booking</th>
                            <th align="center">ToPay Delivery</th>
                            <th align="center">Other Inc</th>
                            <th align="center">Expenses</th>
                            <th align="center">Commissions</th>
                            <th align="center">Revert Payment</th>
                            <th align="center">Settlement Amt</th>
                            <th align="center">{if $paymentAcknowledgeStatus == 'ACKED'}Paid Amt{else}Payable{/if}</th>
                            <th align="center" nowrap>Pending Amt</th>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {foreach item=row from=$receipt->organizationReceiptDetails}
                            <tr id="vou_{$row->code}">
                                <td align="left">{$row->code}</td>
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
                                <td align="right">{$row->openingBalanceAmount|inr_format}</td>
                                <td align="right"><a href="javascript:;" onclick="showLRdetails('{$row->fromUser->code}', 'BO', '{$row->fromDateTime}', '{$row->toDateTime}');">{$row->bookedAmount|inr_format}</a></td>
                                <td align="right"><a href="javascript:;" onclick="showLRdetails('{$row->fromUser->code}', 'TDL', '{$row->fromDateTime}', '{$row->toDateTime}');">{$row->deliveryAmount|inr_format}</a></td>
                                <td align="right"><a href="javascript:;" onclick="showIEdetails('{$receipt->organization->code}', 'Cr', '{$row->fromDateTime}', '{$row->toDateTime}', '{$receipt->code}');">{$row->incomeAmount|inr_format}</a></td>
                                <td align="right"><a href="javascript:;" onclick="showIEdetails('{$receipt->organization->code}', 'Dr', '{$row->fromDateTime}', '{$row->toDateTime}', '{$receipt->code}');">{$row->expenseAmount|inr_format}</a></td>
                                <td align="right"><a href="javascript:;" onclick="showLRdetails('{$row->fromUser->code}', 'COM', '{$row->fromDateTime}', '{$row->toDateTime}');">{$row->commissionAmount|inr_format}</a></td>
                                <td align="right"><a href="javascript:;" onclick="showLRdetails('{$row->fromUser->code}', 'RVT', '{$row->fromDateTime}', '{$row->toDateTime}');">{$row->revertAmount|inr_format}</a></td>
                                <td align="right">{$row->settlementAmount|inr_format}</td>
                                <td align="right">{$row->paidAmount|inr_format}</td>
                                <td align="right">
                                    {$row->totalPendingAmount|inr_format}
                                    {if isNotNull($row->pendingPaymentDetails)}
                                    &emsp;<a href="javascript:;" data-toggle="popover" class="has-popover" data-content="{$row->pendingPaymentDetails}"><i class="fa fa-comment" aria-hidden="true"></i></a>
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

<div class="row">
    <p class="bold col-md-5">Initiated List</p>
</div>
{call paymentTable data=$pending_payments['INITD'] paymentAcknowledgeStatus='INITD'}
{call paymentDrillDown data=$pending_payments['INITD'] paymentAcknowledgeStatus='INITD'}

<div class="row">
    <p class="bold col-md-5">Acknowledged List</p>
</div>
{call paymentTable data=$pending_payments['ACKED'] paymentAcknowledgeStatus='ACKED'}
{call paymentDrillDown data=$pending_payments['ACKED'] paymentAcknowledgeStatus='ACKED'}

<script>
    $('[data-toggle="tooltip"]').tooltip();

    $(".has-popover").popover({
        trigger: 'hover',
        placement : 'top',
        html: true
    });

    function togglePaymentReceiptOpeningBal(code) {
        if ($(event.target).is('button, a, i')) {
            return;
        }
        if($('.openingBalanceDetailsList').hasClass(code)) {
            $('.openingBalanceDetailsList .slide').slideToggle('linear', function() {
                $('.openingBalanceDetailsList').remove();
            });
            return;
        }
        $('.openingBalanceDetailsList').remove();
        var $trows = $('.paymentreceipt-openingbal').filter('.' + code);
        $('#'+code).after('<tr class="openingBalanceDetailsList ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">'
                + $trows.html() + '</table></div></td></tr>');
        $('.openingBalanceDetailsList .slide').slideToggle('linear');
        $(".has-popover").popover({
            trigger: 'hover',
            placement : 'left',
            html: true
        });
    }
</script>
