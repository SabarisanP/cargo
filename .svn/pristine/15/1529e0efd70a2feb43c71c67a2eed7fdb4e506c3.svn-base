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
<div id="vou-unpaidbtn-options" style="display: none;">
    {if $action_rights['CGO-VOU-ACKN']>0}
    <button class="btn-app btn-success" type="button" onclick="payAllVoucher();">Update Paid</button>
    <button class="btn-app btn-danger" type="button" onclick="rejectAllVoucher();">Reject</button>
    {/if}
</div>
<br/>

<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr class="success">
                <th class="text-center">
                    {if $result|count}
                        <input type="checkbox" class="unpaid_vou_checkall">
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
                        <td align="center"><input type="checkbox" class="unpaid_vou_check {$row->code}" value="{$row->code}" data-amount="{$row->transactionAmount-$row->partialTransactionAmount}"></td>
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
                                <button class="btn-app btn-success" type="button" onclick="payVoucher('{$row->code}');">Update Paid</button>
                                <button class="btn-app btn-danger" type="button" onclick="rejectVoucher('{$row->code}');">Reject</button>
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

<script>
    $('.unpaid_vou_checkall').on('change', function () {
        var $ele = $(this);
        
        $('.unpaid_vou_check:enabled')
            .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
            .prop('checked', $ele.is(':checked'))
            .trigger('change');
    });
    
    $('.unpaid_vou_check').on('change', function () {
        if($('.unpaid_vou_check:checked').length > 1) {
            $('#vou-unpaidbtn-options').show('slide', { direction: 'up' });
        } else {
            $('#vou-unpaidbtn-options').hide('slide', { direction: 'up' });
        }
    });
    
    function closeAllPayment() {
        $('#payment-confirm-dialog').dialog('close');
    }
    
    function rejectAllVoucher() {
        if (confirm('Are you sure, Do you want to reject all these Vouchers?')) {
            var data = {};
            data.codes = $('.unpaid_vou_check:checked').map(function() {
                return $(this).val()
            }).get();
            var loading_overlay = iosOverlay({
                text: 'Loading',
                icon: 'fa fa-spinner fa-spin'
            });
            
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/reject-all-voucher',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: 'fa fa-check',
                            text: 'Success!'
                        });
                    }
                    window.setTimeout(function () {
                        getUnpaidVouchers();
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }
    }

    function payAllVoucher() {
        if (confirm('Are you sure, Do you want to pay all these Vouchers?')) {
            var data = {};
            data.codes = $('.unpaid_vou_check:checked').map(function() {
                return $(this).val()
            }).get();
            var loading_overlay = iosOverlay({
                text: 'Loading',
                icon: 'fa fa-spinner fa-spin'
            });
            
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/approve-all-voucher',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: 'fa fa-check',
                            text: 'Success!'
                        });
                    }
                    window.setTimeout(function () {
                        getUnpaidVouchers();
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }
    }

    function payVoucher(code) {
        if (confirm('Are you sure, Do you want to approve this Voucher?')) {
            var data = {};
            data.code = code;
            var loading_overlay = iosOverlay({
                text: 'Loading',
                icon: 'fa fa-spinner fa-spin'
            });
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/approve-voucher',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#vou_' + code).animate({
                            backgroundColor: '#1AA1E1'
                        }, 2000, function () {
                            $(this).remove();
                        });

                        loading_overlay.update({
                            icon: 'fa fa-check',
                            text: 'Success!'
                        });
                    }
                    window.setTimeout(function () {
                        getUnpaidVouchers();
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }
    }
</script>