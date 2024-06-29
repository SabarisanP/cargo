{function name="paymentTable" data=[]}
    <div class="table-responsive">
        <table class="table table-bordered">
            <thead>
                <tr class="success">
                    <th align="center">Transaction Code</th>
                    <th align="center">Transaction Date</th>
                    <th align="center">Payment Received Date</th>
                    <th align="center">Receipt Type</th>
                    <th align="center">Payment Mode</th>
                    <th align="center">User</th>
                    <th align="center">Amount</th>
                    {* {if in_array($paymentAcknowledgeStatus, ['ACKED'])}
                        <th align="center">Credit Balance</th>
                        <th align="center">Opening Balance</th>
                        <th align="center">Closing Balance</th>
                    {/if} *}
                    <th align="center">Remarks</th>
                    <th align="center"></th>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var="t_transactionAmount" value=0}
                {assign var="t_balanceAmount" value=0}
                {foreach item=row from=$data key=t}
                    <tr id="row-{$row->code}" {if $paymentAcknowledgeStatus == 'ACKED'}class="tr-hover" onclick="togglePaymentReceipt('row-{$row->code}');" title="Click to view payment adjusted vouchers" {/if}>
                        <td align="left">{$row->code} &nbsp;<a href="javascript:;" title="Click to view Activity log" onclick="showReceiptActivity('{$row->code}');"><i class="fa fa-history" aria-hidden="true"></i></a></td>
                        <td align="left">{$row->transactionDate|date_format:$ns_date_format}</td>
                        <td align="left">{$row->amountReceivedDate|date_format:$ns_date_format}</td>
                        <td align="left">{$payment_receipt_type[$row->paymentReceiptType->code]}</td>
                        <td align="left">{$transactionMode[$row->transactionMode->code]}</td>
                        <td align="left">{$row->user->name}</td>
                        <td align="right">{$row->transactionAmount|inr_format}</td>

                        {* {if in_array($paymentAcknowledgeStatus, ['ACKED'])}
                            <td align="right">{$row->balanceAmount|inr_format} {if $paymentAcknowledgeStatus == 'ACKED'}<i class="fa fa-caret-down fa-fw pull-right" style="margin-top: 2px;"></i>{/if}</td>
                            <td align="right">{$row->openingBalance|inr_format}</td>
                            <td align="right">{$row->closingBalance|inr_format}</td>
                        {/if} *}

                        <td align="left">{(($row->remarks) ? $row->remarks : '-')|truncate:35:'...'} {if strlen($row->remarks) > 35}<i class="fa fa-info-circle fa-fw pull-right" data-toggle="tooltip" data-placement="top" title="{$row->remarks}" style="margin-top: 2px;"></i>{/if}</td>
                        <td>
                            {if $row->image}
                                <div class="btn-group btn-group-xs">
                                    <button class="btn btn-default btn-sm" type="button" title="{$row->image} files" onclick="showPRGallery('{$row->code}')"><i class="fa fa-picture-o" aria-hidden="true"></i></button>
                                </div>
                            {/if}
                            {if $paymentAcknowledgeStatus == 'PAID'}
                                {if $action_rights['PYRCT-MK-ACK']>0}
                                    <button class="btn-app btn-success" type="button" onclick="receiptStatusDialog('{$row->code}', 'ACKED');">Acknowledge</button>
                                    <button class="btn-app btn-danger" type="button" onclick="receiptStatusDialog('{$row->code}', 'RJECT');">Reject</button>
                                {/if}
                            {elseif $paymentAcknowledgeStatus == 'INITD' && $row->paymentAcknowledgeStatus->code !== 'RJECT'}
                                {if $action_rights['PYRCT-SND-APROV']>0}
                                    <button class="btn-app btn-success" type="button" onclick="receiptStatusDialog('{$row->code}', 'PAID');">Send Approval</button>
                                    <button class="btn-app btn-danger" type="button" onclick="receiptStatusDialog('{$row->code}', 'RJECT');">Reject</button>
                                {/if}
                            {/if}

                            &nbsp;<a href="javascript:;" data-toggle="tooltip" title="{$row->updatedBy->name}"><i class="fa fa-info-circle"></i></a>
                        </td>
                    </tr>
                    {assign var="t_transactionAmount" value=$t_transactionAmount + $row->transactionAmount}
                    {assign var="t_balanceAmount" value=$t_balanceAmount + $row->balanceAmount}
                {foreachelse}
                    <tr>
                        <td {if in_array($paymentAcknowledgeStatus, ['PAID', 'INITD'])}colspan="12" {else}colspan="11" {/if} align="center">No Records Found!</td>
                    </tr>
                {/foreach}

                {if $result|count}
                    <tr class="bold">
                        <td colspan="5" align="right">Total:</td>
                        <td align="right">{$t_transactionAmount|inr_format}</td>
                        <td align="right" {if in_array($paymentAcknowledgeStatus, ['PAID', 'INITD'])}colspan="5" {else}colspan="3" {/if}></td>
                    </tr>
                {/if}
            </tbody>
        </table>
    </div>
{/function}

{call paymentTable data=$result}

{if $paymentAcknowledgeStatus == 'INITD'}
    {if $reject|count}
        <div class="row">
            <p class="bold col-md-5">Rejected List</p>
        </div>
        {call paymentTable data=$reject}
        {$result = array_merge($result, $reject)}
    {/if}
{/if}

{if $paymentAcknowledgeStatus == 'ACKED'}
    <table class="hide">
        {foreach item=receipt from=$result key=t}
            <tr class="row-{$receipt->code} hide paymentreceipt">
                <td>
                    <table class="table table-bordered m_b_5">
                        <thead>
                            <tr class="active">
                                <th align="center">Voucher No</th>
                                <th align="center">User</th>
                                <th align="center">Created Date</th>
                                <th align="center">Created By</th>
                                <th align="center">Transaction Mode</th>
                                <th align="center">Voucher Amount</th>
                                {* <th align="center">Paid Amount</th>
                                <th align="center">Balance Amount</th> *}
                                <th align="center">Remarks</th>
                            </tr>
                        </thead>
                        <tbody class="body_table">
                            {foreach item=row from=$receipt->paymentTransactions}
                                <tr id="vou_{$row->code}">
                                    <td align="left"><a href="javascript:;" onclick="showVoucherPdfDialog('{$row->code}');">{$row->code}</a></td>
                                    <td align="left">{$row->user->name}</td>
                                    <td align="left">{$row->transactionDate|date_format:$ns_datetime_format}</td>
                                    <td align="left">{$row->paymentHandledBy->name}</td>
                                    <td align="left">{$row->transactionMode->name}</td>
                                    <td align="right">{$row->transactionAmount|number_format:2}</td>
                                    {* <td align="right">{$row->partialTransactionAmount|number_format:2} {if $row->acknowledgeStatus->code == 'PAPAID'}<a href="javascript:;" onclick='showUnpaidPartialInfo(`{$row->partialPaymentList|json_encode}`);'><i class="fa fa-info-circle" aria-hidden="true"></i></a>{/if}</td>
                                    <td align="right">{($row->transactionAmount-$row->partialTransactionAmount)|number_format:2}</td> *}
                                    <td align="left">{$row->remarks}</td>
                                </tr>
                            {foreachelse}
                                <tr>
                                    <td colspan="7" align="center">No Records Found!</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </td>
            </tr>
        {/foreach}
    </table>
{/if}

<script>
    var paymentReceiptData = {$result|json_encode};
    $('[data-toggle="tooltip"]').tooltip();

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
