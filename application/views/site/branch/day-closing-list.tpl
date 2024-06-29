
{function userpanel}
    {assign var=payable value=($receipt->organizationUserTransaction->openingBalanceAmount + $receipt->bookedAmount + $receipt->deliveryAmount + $receipt->incomeAmount - $receipt->expenseAmount - $receipt->commissionAmount + $receipt->revertAmount)}
    {* {if $payable != 0 || $receipt->organizationUserTransaction->openingBalanceAmount != 0} *}
        <div class="panel panel-default payment-panel" data-usercode="{$receipt->fromUser->code}">
            <div class="panel-body">
                <div class="heading_b">
                    <div class="row">
                        <div class="col-md-7">
                            <b>Statement for :</b> {$receipt->fromUser->name} {if $primary}<b class="small"> (Primary User)</b>{/if}
                        </div>
                        <div class="col-md-5">
                            <a href="javascript:;" class="pull-right" id="show-approval-pending" onclick="approvalPendingTransaction('{$receipt->fromUser->code}');">Approval Pending</a>
                        </div>
                        
                        <div class="col-md-5">
                            {if $dayCloseSettings->dayCloseHour >= 0}
                            <span class="small"><b>Day Closing time :</b> {$dayCloseSettings->dayCloseHour|cat:':00'|date_format:'h:i A'}</span>
                            {/if}
                        </div>
                        <div class="col-md-7">
                            <span class="small pull-right">
                                {if isNotNull($receipt->fromDateTime)}<b>Last closed date and time :</b> {$receipt->fromDateTime|date_format:$ns_datetime_format}{/if}
                            </span>
                        </div>
                        <div class="col-md-12">
                            <span class="small pull-right">
                                <b>Opening Balance :</b> <a href="javascript:;" onclick="pendingPaymentsDialog('{$smarty.request.userCode}');">{$totalPendingAmount|inr_format}</a>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Particulars</th>
                                <th class="text-right">Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Running Balance (A)</td>
                                <td align="right">{$receipt->organizationUserTransaction->openingBalanceAmount|inr_format}</td>
                            </tr>
                            <tr>
                                <td><a href="javascript:;" onclick="showLRdetails('{$receipt->fromUser->code}', 'BO', '{$receipt->fromDateTime}', '{$receipt->toDateTime}');">Paid Booking (B)</a></td>
                                <td align="right">{$receipt->bookedAmount|inr_format}</td>
                            </tr>
                            <tr>
                                <td><a href="javascript:;" onclick="showLRdetails('{$receipt->fromUser->code}', 'TDL', '{$receipt->fromDateTime}', '{$receipt->toDateTime}');">ToPay Delivery (C)</a></td>
                                <td align="right">{$receipt->deliveryAmount|inr_format}</td>
                            </tr>
                            {if $primary}
                            <tr>
                                <td><a href="javascript:;" onclick="showIEdetails('{$result->organization->code}', 'Cr', '{$receipt->fromDateTime}', '{$receipt->toDateTime}');">Other Income (D)</a></td>
                                <td align="right">{$receipt->incomeAmount|inr_format}</td>
                            </tr>
                            <tr>
                                <td><a href="javascript:;" onclick="showIEdetails('{$result->organization->code}', 'Dr', '{$receipt->fromDateTime}', '{$receipt->toDateTime}');">Expenses (E)</a></td>
                                <td align="right">{$receipt->expenseAmount|inr_format}</td>
                            </tr>
                            {/if}
                            <tr>
                                <td><a href="javascript:;" onclick="showLRdetails('{$receipt->fromUser->code}', 'COM', '{$receipt->fromDateTime}', '{$receipt->toDateTime}');">Commissions (F)</a></td>
                                <td align="right">{$receipt->commissionAmount|inr_format}</td>
                            </tr>
                            <tr>
                                <td><a href="javascript:;" onclick="showRevertLRdetails('{$receipt->fromUser->code}', 'RVT', '{$receipt->fromDateTime}', '{$receipt->toDateTime}');">Revert Payment (G)</a></td>
                                <td align="right">{$receipt->revertAmount|inr_format}</td>
                            </tr>
                            <tr>
                                <th>Payable (A+B+C{if $primary}+D-E{/if}-F-G)</th>
                                <th class="text-right">{$payable|inr_format}</th>
                            </tr>
                        </tbody>
                    </table>
                </div>
                {if $primary}
                    <table class="table" id="userwise-payments">
                        {assign var="allUserReceipt" value=array_merge([$receipt], $otherUserReceipt)}
                        {foreach item=row from=$allUserReceipt}
                            {assign var=pay value=($row->organizationUserTransaction->openingBalanceAmount + $row->bookedAmount + $row->deliveryAmount + $row->incomeAmount - $row->expenseAmount - $row->commissionAmount + $row->revertAmount)}
                            {if $pay > 0 || $row->organizationUserTransaction->openingBalanceAmount > 0}
                                <tr>
                                    <td>Payment from <b>{$row->fromUser->name}</b></td>
                                    <td>{max(0, $pay)|inr_format}</td>
                                    <td align="right"><input type="text" oninput="validation(this.value,'{max(0, $pay)|inr_format}');" class="form-control user-pay-amt" data-usercode="{$row->fromUser->code}" value="{max(0, $pay)}" size="5"></td>
                                </tr>
                            {/if}
                        {/foreach}
                    </table>
                {/if}
                {if $receipt->fromUser->code == $usr_login_id}
                    <div>
                        {if $receipt->pendingSettlementAmount != 0}
                            <div class="alert alert-warning">Previous closing entry is not yet acknowledged.</div>
                        {/if}
                        <button class="btn btn-success btn-xs pull-right" id="make-payment-btn" {if $receipt->pendingSettlementAmount != 0}disabled{else}onclick="receiptPaymentDialog('{$receipt->fromUser->code}', '{$organization->code}', {($primary) ? 1 : 0})"{/if}>Make Payment</button>
                    </div>

                    <div class="make-payment-form-panel">
                    
                    </div>
                {/if}
            </div>
        </div>
    {* {/if} *}
{/function}

<div class="row">
    <div class="col-md-7">
        {assign var="primaryUserReceipt" value=null}
        {assign var="otherUserReceipt" value=[]}
        {foreach item=receipt from=$result->organizationReceiptDetails}
            {if $receipt->fromUser->code == $organization[$result->organization->code]->user->code}
                {$primaryUserReceipt = $receipt}
            {else}
                {$otherUserReceipt[] = $receipt}
            {/if}
        {/foreach}
        {userpanel receipt=$primaryUserReceipt primary=true organization=$result->organization otherUserReceipt=$otherUserReceipt dayCloseSettings=$result->dayCloseSettings}
        {foreach item=receipt from=$otherUserReceipt}
            {userpanel receipt=$receipt organization=$result->organization dayCloseSettings=$result->dayCloseSettings}
        {/foreach}

        <input type="hidden" id="primary-user-code" value="{$primaryUserReceipt->fromUser->code}"/>
    </div>
    <div class="col-md-5">
        <div id="bank-details-panel"  class="panel panel-default hide">
        </div>
    </div>
</div>

<script>
    var partialAmountAllowed = '{$action_rights['ALLOW-PARTIAL-AMOUNT']}';
    var branchUserTransactions = {$result|json_encode};

    if (!$('.payment-panel').length) {
        $('#day-closing-list').html('<div class="panel panel-default"><div class="panel-body"><div class="well">No Data Found</div></div></div>');
    }

    $('#userwise-payments').on('change', '.user-pay-amt', calculatePayable);

    function calculatePayable(data) {
        var payable = 0;
        $('#userwise-payments .user-pay-amt').each(function () {
            payable += parseFloat($(this).val()) | 0;
        });
        
        if (data > 0) {
            $('#pay_voucher_amount').val(Number(data).toFixed(2));
            // $('#make-payment-btn').prop('disabled', false);
        }else if(payable>0){
            $('#pay_voucher_amount').val(Number(payable).toFixed(2));
        } else {
            $('#pay_voucher_amount').val(0);
            // $('#make-payment-btn').prop('disabled', true);
            // cancelReceiptPaymentDialog();
        }
    }

    function validation(inputAmount,existingAmount){
        existingAmount = parseFloat(existingAmount);
        if(partialAmountAllowed){
            $('#pay_voucher_amount').val(Number(inputAmount).toFixed(2));
            return;
        }
        if(inputAmount <= existingAmount){
           
          $('.user-pay-amt').val(existingAmount);
          $('#pay_voucher_amount').val(Number(existingAmount).toFixed(2));
        }
    }
    

    

</script>