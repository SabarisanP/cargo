<h5>Summary</h5>
<div class="table-responsive col-md-5 p_l_n">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th align="center">Branch</th>
                <th align="center">Voucher Amount</th>
                <th align="center">Paid Amount</th>
                <th align="center">Balance Amount</th>
            </tr>
        </thead>
        <tbody>
            {assign var="transactionAmount" value=0}
            {assign var="partialPaymentAmount" value=0}
            {assign var="balanceAmountTotal" value=0}
            {assign var="balanceAmount" value=0}
            
            {foreach item=row from=$summary key=key}
                {assign var="balanceAmount" value=$row['transactionAmount'] - $row['partialPaymentAmount']}
                <tr>
                    <td class="bold">{$key}</td>
                    <td align="right">{$row['transactionAmount']|number_format:2}</td>
                    <td align="right">{$row['partialPaymentAmount']|number_format:2}</td>
                    <td align="right">{$balanceAmount|number_format:2}</td>
                </tr>
                {assign var="transactionAmount" value=$transactionAmount + $row['transactionAmount']}
                {assign var="partialPaymentAmount" value=$partialPaymentAmount + $row['partialPaymentAmount']}
                {assign var="balanceAmountTotal" value=$balanceAmountTotal + $balanceAmount}
            {foreachelse}
                <tr>
                    <td colspan="4" align="center">No Records Found!</td>
                </tr>
            {/foreach}
            
            {if $summary|count}
                <tr class="bold">
                    <td align="right">Total</td>
                    <td align="right">{$transactionAmount|number_format:2}</td>
                    <td align="right">{$partialPaymentAmount|number_format:2}</td>
                    <td align="right">{$balanceAmountTotal|number_format:2}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>
<br/>
<div class="clearfix"></div>
<h5>Vouchers</h5>
<div id="vou-ackbtn-options" style="display: none;">
    {if $action_rights['CGO-VOU-ACKN']>0}
    <button class="btn-app btn-success" type="button" onclick="makeAllPayment();">Make Payment</button>
    {/if}
</div>
<br/>

<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr class="success">
                <th class="text-center">
                    {if $result|count}
                        <input type="checkbox" class="ack_vou_checkall">
                    {/if}
                </th>
                <th align="center">Voucher No</th>
                <th align="center">Transaction Date</th>
                <th align="center">Transaction Mode</th>
                <th align="center">User</th>
                <th align="center">Remarks</th>
                <th align="center">Transaction Amount</th>
                <th align="center">Paid Amount</th>
                <th align="center">Balance Amount</th>
                <th align="center"></th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach item=branch from=$result key=key}
                <tr class="bold active">
                    <td colspan="10" align="center">{$key}</td>
                </tr>
                {foreach item=row from=$branch}
                    <tr id="vou_{$row->code}">
                        <td align="center"><input type="checkbox" class="ack_vou_check {$row->code}" value="{$row->code}" data-amount="{$row->transactionAmount-$row->partialTransactionAmount}"></td>
                        <td align="left"><a href="javascript:;" onclick="showVoucherPdfDialog('{$row->code}');">{$row->code}</a></td>
                        <td align="left">{$row->transactionDate|date_format:$ns_datetime_format}</td>
                        <td align="left">{$row->transactionMode->name}</td>
                        <td align="left">{$row->user->name}</td>
                        <td align="left">{$row->remarks}</td>
                        <td align="right">{$row->transactionAmount|number_format:2}</td>
                        <td align="right">{$row->partialTransactionAmount|number_format:2} {if $row->acknowledgeStatus->code == 'PAPAID'}<a href="javascript:;" onclick='showUnpaidPartialInfo(`{$row->partialPaymentList|json_encode}`);'><i class="fa fa-info-circle" aria-hidden="true"></i></a>{/if}</td>
                        <td align="right">{($row->transactionAmount-$row->partialTransactionAmount)|number_format:2}</td>
                        <td align="center">
                            {if $action_rights['CGO-VOU-ACKN']>0}
                            <button class="btn-app btn-success" type="button" onclick="makePaymentDialog('{$row->code}', '{$row->transactionMode->code}','{$row->transactionAmount-$row->partialTransactionAmount}');">Make Payment</button>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
            {foreachelse}
                <tr>
                    <td colspan="10" align="center">No Records Found!</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
        
<div id="payment-confirm-dialog" class="dialog-content-page" style="display: none">
    <br/>
    <div class="col-lg-12 p_l_n p_r_n">
        <ul>
            <li>All vouchers will be paid with full balance amount.</li>
            <li>All vouchers will be paid with <b>Cash Payment</b> Transaction mode.</li>
        </ul>
        <label class="col-lg-12"><input type="checkbox" id="agree-payment">&emsp;I agree to apply all voucher</label>
    </div>
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="all_pay_action_state"></div>
        <div class="align-right">
            <button class="btn btn-success" type="button" onclick="confirmAllPayment();">Pay</button>
            <button class="btn btn-default" type="button" onclick="closeAllPayment();">Cancel</button>
        </div>
    </div>
</div>
        
<script>
    $('.ack_vou_checkall').on('change', function () {
        var $ele = $(this);
        
        $('.ack_vou_check:enabled')
            .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
            .prop('checked', $ele.is(':checked'))
            .trigger('change');
    });
    
    $('.ack_vou_check').on('change', function () {
        if($('.ack_vou_check:checked').length > 1) {
            $('#vou-ackbtn-options').show('slide', { direction: 'up' });
        } else {
            $('#vou-ackbtn-options').hide('slide', { direction: 'up' });
        }
    });
    
    function makeAllPayment() {
        $('#all_pay_action_state').hide();
        $('#payment-confirm-dialog').css('background', '#fff');
        $('#payment-confirm-dialog').removeClass('hide');
        $('#payment-confirm-dialog').dialog({
            autoOpen: true,
            height: 250,
            width: 600,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
    }
    
    function closeAllPayment() {
        $('#payment-confirm-dialog').dialog('close');
    }
    
    function confirmAllPayment() {        
        if(!$('#agree-payment').is(':checked')) {
            $('#all_pay_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#all_pay_action_state').html('Please agree the payment');
            $('#all_pay_action_state').show();
            return;
        }
        closeAllPayment();
        
        var data = {};
        data.data = $('.ack_vou_check:checked').map(function() {
            return { 
                code: $(this).val(),
                amount: parseFloat($(this).data('amount')).toFixed(2)
            }
        }).get();
        var loading_overlay = iosOverlay({
            text: 'Loading',
            icon: 'fa fa-spinner fa-spin'
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/make-all-voucher-payment',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: 'fa fa-check',
                        text: 'Success!'
                    });
                }
                window.setTimeout(function () {
                    getAckVouchers();
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }
</script>