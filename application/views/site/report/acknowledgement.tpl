<div class="brand_top"><h3>Acknowledgement</h3></div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    
                                    <ul class="nav nav-tabs">                                                                               
                                        <li class="active"><a data-toggle="tab" href="#wiatingack">Paid, Waiting for Ack</a></li> 
                                        <li><a data-toggle="tab" href="#initiated">Initiated</a></li> 
                                    </ul>
                                    <div class="tab-content">
                                        <div id="initiated" class="tab-pane fade">
                                            <div class="form-group hide" id="initiated-div">
                                                {if $action_rights['APOVE-ACK']>0}
                                                    <button nowrap="nowrap" class="btn btn-success" type="button" onclick="approveAllAck('initiated','PAID');">Update Paid All</button>
                                                {/if}

                                                {if $action_rights['APOVE-ACK']>0}
                                                    <button class="btn btn-danger" type="button" onclick="approveAllAck('initiated','RJECT');">Reject All</button>
                                                {/if}
                                            </div>
                                            <div class="table-responsive">
                                                <table id="dt_ack" class="table table-bordered">
                                                    <thead>
                                                        <tr class="success">
                                                            <th><input type="checkbox" onchange="selectAll(this,'initiated');"/></th>
                                                            <th>Voucher No</th>
                                                            <th>Transaction Date</th>
                                                            <th>Transaction Type</th>
                                                            <th>Amount</th>
                                                            <th>Transaction Mode</th>
                                                            <th>Recharge By</th>
                                                            <th>Recharge To </th>
                                                            <th>Remarks</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="body_table">

                                                        {foreach name=o item=row key=k from=$ack}    
                                                            {if ($row->transactionType->code=='RECHG' || $row->transactionType->code=='CGRECHG' || $row->transactionType->code=='RVREPT') && $row->acknowledgeStatus->code=='INITD'}
                                                            <tr id="ack_{$row->code}">
                                                                <td><input type="checkbox" class="initiated" value="{$row->code}"/></td>
                                                                <td>{$row->code}</td>
                                                                <td nowrap="nowrap">{$row->transactionDate|date_format:$ns_datetime_format}</td>
                                                                <td nowrap="nowrap">{$row->transactionType->name}</td>
                                                                <td>{$row->transactionAmount}</td>
                                                                <td nowrap="nowrap">{if $row->transactionMode->name != ''}{$row->transactionMode->name}{else}NA{/if}</td>
                                                                <td nowrap="nowrap">{$row->paymentHandledBy->username}</td>
                                                                <td nowrap="nowrap">{$row->user->name}</td>
                                                                <td>{$row->remarks}</td>
                                                                <td nowrap="nowrap"> 
                                                                    {if $action_rights['APOVE-ACK']>0}
                                                                        <button nowrap="nowrap" class="btn-app btn-success" type="button" onclick="approveRecharge('{$row->code}','PAID');">Update Paid</button>
                                                                    {/if}
                                                                    
                                                                    {if $action_rights['APOVE-ACK']>0}
                                                                        <button class="btn-app btn-danger" type="button" onclick="approveRecharge('{$row->code}','RJECT');">Reject</button>
                                                                    {/if}
                                                                </td>
                                                            </tr>
                                                            {/if}
                                                        {/foreach}    
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div id="wiatingack" class="tab-pane fade in active">
                                            <div class="table-responsive">
                                                <table id="dt_ack" class="table table-bordered">
                                                    <thead>
                                                        <tr class="success">
                                                            <th>Voucher No</th>
                                                            <th>Transaction Date</th>
                                                            <th>Transaction Type</th>
                                                            <th>Amount</th>
                                                            <th>Paid Amount</th>
                                                            <th>Balance Amount</th>
                                                            <th>Transaction Mode</th>
                                                            <th>Recharge By</th>
                                                            <th>Recharge To </th>
                                                            <th>Remarks</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="body_table">
                                                        {assign var="totTransaction" value=0}
                                                        {assign var="totPartialTransaction" value=0}

                                                        {foreach name=o item=row key=k from=$ack}    
                                                            {if ($row->transactionType->code=='RECHG' || $row->transactionType->code=='CGRECHG' || $row->transactionType->code=='RVREPT') && ($row->acknowledgeStatus->code=='PAID' || $row->acknowledgeStatus->code=='PAPAID')}
                                                                
                                                                {assign var="partialTransactionAmount" value=0}

                                                                {foreach item=par from=$row->partialPaymentList}
                                                                    {assign var="partialTransactionAmount" value=$partialTransactionAmount + $par->transactionAmount}
                                                                {/foreach}

                                                                <tr id="ack_{$row->code}">
                                                                    <td>{$row->code}</td>
                                                                    <td nowrap="nowrap">{$row->transactionDate|date_format:$ns_datetime_format}</td>
                                                                    <td nowrap="nowrap">{$row->transactionType->name}</td>
                                                                    <td align="right">{$row->transactionAmount|number_format:2}</td>
                                                                    <td align="right">{$partialTransactionAmount|number_format:2}  {if $row->acknowledgeStatus->code=='PAPAID'}<a href="javascript:;" onclick='showUnpaidPartialInfo({$row->partialPaymentList|json_encode|escape});'><i class="fa fa-info-circle" aria-hidden="true"></i></a>{/if}</td>
                                                                    <td align="right">{($row->transactionAmount-$partialTransactionAmount)|number_format:2}</td>
                                                                    <td nowrap="nowrap">{if $row->transactionMode->name != ''}{$row->transactionMode->name}{else}NA{/if}</td>
                                                                    <td nowrap="nowrap">{$row->paymentHandledBy->username}</td>
                                                                    <td nowrap="nowrap">{$row->user->name}</td>
                                                                    <td>{$row->remarks}</td>
                                                                    <td nowrap="nowrap"> 
                                                                        {if $action_rights['APOVE-ACK']>0}
                                                                            <button class="btn-app btn-success" type="button" onclick="makePaymentDialog('{$row->code}', '{$row->transactionMode->code}', '{$row->transactionAmount-$partialTransactionAmount}');">Make Payment</button>
                                                                        {/if}                                                                    
                                                                    </td>
                                                                </tr>
                                                                
                                                                {assign var="totTransaction" value=$totTransaction + $row->transactionAmount}
                                                                {assign var="totPartialTransaction" value=$totPartialTransaction + $partialTransactionAmount}
                                                            {/if}
                                                        {/foreach}
                                                        {if $ack|count}
                                                            <tr>
                                                                <td colspan="3" class="bold text-right">Total</td>
                                                                <td align="right">{$totTransaction|number_format:2}</td>
                                                                <td align="right">{$totPartialTransaction|number_format:2}</td>
                                                                <td align="right">{($totTransaction-$totPartialTransaction)|number_format:2}</td>
                                                                <td colspan="5"></td>
                                                            </tr>
                                                        {/if}   
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    
                                        
                                </div><!--content end-->
                            </div>
                        </div>
                    </div>
                </div>
            </div></div></div>
</div>
                                                        
<div id="make-payment" class="hide">
    <form role="form" class="form-horizontal">
        <br>
        <div class="col-lg-12 p_l_n p_r_n text-right">
            <label for="pay_voucher_amount">Balance Amount - Rs.<span id="pay_voucher_balanceamt"></span></label>
        </div>
        <br>
        <div class="col-lg-12 p_l_n p_r_n">
            <label for="pay_voucher_amount" class="req">Amount Received</label>
            <div class="input-group">
                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                <input type="text" class="form-control" id="pay_voucher_amount" maxlength="10">
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br/>
        <div class="col-lg-12 p_l_n p_r_n">
            <label for="pay_voucher_tmode" class="req">Transaction Mode</label>
            <select id="pay_voucher_tmode" class="form-control col-md-6">
                <option value="">Select</option>
                {foreach key=key item=value from=$transactionMode}
                    <option value="{$key}">{$value}</option>
                {/foreach}
            </select>
        </div>
        <div class="clear_fix_both"></div>
        <br/>
        <div class="col-lg-12 p_l_n p_r_n">
            <label for="pay_voucher_remarks">Remarks</label>
            <textarea id="pay_voucher_remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" maxlength="200"></textarea>
        </div>
        <div class="clear_fix_both"></div>
    </form>
    <br/>
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="make_pay_action_state"></div>
        <div class="align-right" id="form-bttons">
            <input type="hidden" id="hid_voucher_code"/>
            <button class="btn btn-success" type="button" id="confirm-pay" onclick="confirmPayment();">Pay</button>
            <button class="btn btn-default" type="button" onclick="closePayment();">Cancel</button>
        </div>
    </div>
</div>
            
<div id="unpaid-info-dialog" class="hide">
    <a href="javascript:;" class="pull-right" onclick="closeUnpaidPartialInfo();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div class="table-responsive">
        <table class="table table-bordered">
            <thead>
                <tr class="bold hover-background">
                    <th align="center">Transaction Date</th>
                    <th align="center">Transaction Mode</th>
                    <th align="center">User</th>
                    <th align="center" width="25%">Remarks</th>
                    <th align="center">Received Date</th>
                    <th align="center">Paid Amount</th>
                </tr>
            </thead>
            <tbody class="body_table" id="parial-info-body">
            </tbody>
        </table>
    </div>
</div>
                
{literal}
<script>
    var loadrequired = false;
    $('[data-toggle="tab"]').on('show.bs.tab', function (e) {
        loadrequired && checkURL();
    });
    
     function approveRecharge(code,state) {
        var data = {};
        data.code = code;
        data.state = state;
        var msg = 'Do you want to approve this transaction?';
        if(state=="RJECT") {
            var msg = 'Are you sure, do you want to reject this transaction?';
        }
        
        if(confirm(msg)) {
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "report/updateAcknowledgement",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        loadrequired = true;
                        $('#ack_'+code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                            $(this).remove();
                        });
                        
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                    } 
                     window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }
    }
    
    function selectAll(value,state){
        if($(value).is(":checked")){
            $('input[class='+state+']').each(function() {
                $(this).prop('checked', true);
                $('#'+state+'-div').removeClass('hide');
            });
        } else {
            $('input[class='+state+']').each(function() {
                $(this).prop('checked', false);
                $('#'+state+'-div').addClass('hide');
            });
        }
    }
    
    $('.initiated').change(function () {
        if($('input[class=initiated]:checked').length > 1){
            $('#initiated-div').removeClass('hide');
        } else {
            $('#initiated-div').addClass('hide');
        }
    });
    
    $('.wiatingack').change(function () {
        if($('input[class=wiatingack]:checked').length > 1){
            $('#wiatingack-div').removeClass('hide');
        } else {
            $('#wiatingack-div').addClass('hide');
        }
    });
    
    function approveAllAck(value,state){
        var data = {};
        data.code = [];
        $('input[class='+value+']').each(function () {
            if($(this).is(":checked")){
                data.code.push($(this).val());
            }
        });
        data.state = state;
        var msg = 'Do you want to approve all selected transactions?';
        if(state=="RJECT") {
            var msg = 'Are you sure, do you want to reject all selected transactions?';
        } 
        
        if(confirm(msg)) {
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "report/initiate-all-ack",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                    } 
                    window.setTimeout(function() {
                        checkURL();
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }
    }
    
    function makePaymentDialog(code, mode, balance) {
        $('#make_pay_action_state').hide();
        $('#make-payment .inp_error').removeClass('inp_error');
        $('#pay_voucher_amount').val(parseFloat(balance).toFixed(2));
        $('#pay_voucher_tmode').val(mode);
        $('#pay_voucher_remarks').val('');
        $('#make-payment').css('background', '#fff');
        $('#make-payment').removeClass('hide');
        $('#make-payment').dialog({
            autoOpen: true,
            height: 475,
            width: 450,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
        $('#hid_voucher_code').val(code);
        $('#pay_voucher_balanceamt').text(parseFloat(balance).toFixed(2));
    }
    
    function closePayment() {
        $('#make-payment').addClass('hide');
        $('#make-payment').dialog('destroy');
    }
    
    function confirmPayment() {
        if (confirm('Are you sure, Do you want to pay this Voucher?')) {
            var data = {};
            data.code = $('#hid_voucher_code').val();
            data.transactionAmount = $.trim($('#pay_voucher_amount').val());
            data.remarks = $('#pay_voucher_remarks').val();
            data.transactionMode = $('#pay_voucher_tmode').val();

            var err = 0;
            $('#make-payment .inp_error').removeClass('inp_error');

            if (data.transactionAmount == '' || isNaN(data.transactionAmount)) {
                $('#pay_voucher_amount').addClass('inp_error');
                err++;
            }
            if (data.transactionMode == '') {
                $('#pay_voucher_tmode').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#make_pay_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#make_pay_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#make_pay_action_state').show();
                return false;
            }

            $('#make_pay_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#make_pay_action_state').html(loading_popup).show();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'report/make-voucher-payment',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#make_pay_action_state').addClass('alert-success');
                        $('#make_pay_action_state').html('Your request has been completed successfully');
                        window.setTimeout(function () {
                            closePayment();
                            checkURL();
                        }, 3000);
                    } else {
                        $('#make_pay_action_state').addClass('alert-danger');
                        $('#make_pay_action_state').html(response.errorDesc);
                    }
                }
            });
        }
    }
    
    function showUnpaidPartialInfo(obj) {
        $('#parial-info-body').html('');
        var total = 0;
        $.each(obj, function (i, val) {
            if (!val.remarks) {
                val.remarks = '-';
            }
            if (val.acknowledgeStatus.code == 'PAPAID') {
                $('#parial-info-body').append('<tr>' +
                        '<td>' + moment(val.transactionDate).format('DD-MM-YYYY hh:mm A') + '</td>' +
                        '<td>' + val.transactionMode.name + '</td>' +
                        '<td>' + val.user.name + '</td>' +
                        '<td>' + val.remarks + '</td>' +
                        '<td>' + moment(val.amountReceivedDate).format('DD-MM-YYYY') + '</td>' +
                        '<td align="right">' + val.transactionAmount.toFixed(2) + '</td>' +
                        '</tr>');
                total += val.transactionAmount;
            }
        });
        $('#parial-info-body').append('<tr class="bold">' +
                '<td colspan="5" align="right">Total:</td>' +
                '<td align="right">' + total.toFixed(2) + '</td>' +
                '</tr>');

        $('#unpaid-info-dialog').css('background', '#fff');
        $('#unpaid-info-dialog').removeClass('hide');
        $('#unpaid-info-dialog').dialog({
            autoOpen: true,
            height: 475,
            width: 750,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
    }
    
    function closeUnpaidPartialInfo() {
        $('#unpaid-info-dialog').addClass('hide');
        $('#unpaid-info-dialog').dialog('destroy');
    }
</script>
{/literal}