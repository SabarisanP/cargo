<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-31 19:50:59
  from 'E:\xampp\htdocs\cargo\application\views\site\report\acknowledgement.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6659dccb0b1cd2_31899871',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '0c858749809fa0fbe7a4362641a1703d66462bc5' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\acknowledgement.tpl',
      1 => 1716451519,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6659dccb0b1cd2_31899871 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
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
                                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['APOVE-ACK'] > 0) {?>
                                                    <button nowrap="nowrap" class="btn btn-success" type="button" onclick="approveAllAck('initiated','PAID');">Update Paid All</button>
                                                <?php }?>

                                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['APOVE-ACK'] > 0) {?>
                                                    <button class="btn btn-danger" type="button" onclick="approveAllAck('initiated','RJECT');">Reject All</button>
                                                <?php }?>
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

                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ack']->value, 'row', false, 'k', 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>    
                                                            <?php if (($_smarty_tpl->tpl_vars['row']->value->transactionType->code == 'RECHG' || $_smarty_tpl->tpl_vars['row']->value->transactionType->code == 'CGRECHG' || $_smarty_tpl->tpl_vars['row']->value->transactionType->code == 'RVREPT') && $_smarty_tpl->tpl_vars['row']->value->acknowledgeStatus->code == 'INITD') {?>
                                                            <tr id="ack_<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
">
                                                                <td><input type="checkbox" class="initiated" value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"/></td>
                                                                <td><?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
</td>
                                                                <td nowrap="nowrap"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->transactionDate,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                                                                <td nowrap="nowrap"><?php echo $_smarty_tpl->tpl_vars['row']->value->transactionType->name;?>
</td>
                                                                <td><?php echo $_smarty_tpl->tpl_vars['row']->value->transactionAmount;?>
</td>
                                                                <td nowrap="nowrap"><?php if ($_smarty_tpl->tpl_vars['row']->value->transactionMode->name != '') {
echo $_smarty_tpl->tpl_vars['row']->value->transactionMode->name;
} else { ?>NA<?php }?></td>
                                                                <td nowrap="nowrap"><?php echo $_smarty_tpl->tpl_vars['row']->value->paymentHandledBy->username;?>
</td>
                                                                <td nowrap="nowrap"><?php echo $_smarty_tpl->tpl_vars['row']->value->user->name;?>
</td>
                                                                <td><?php echo $_smarty_tpl->tpl_vars['row']->value->remarks;?>
</td>
                                                                <td nowrap="nowrap"> 
                                                                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['APOVE-ACK'] > 0) {?>
                                                                        <button nowrap="nowrap" class="btn-app btn-success" type="button" onclick="approveRecharge('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
','PAID');">Update Paid</button>
                                                                    <?php }?>
                                                                    
                                                                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['APOVE-ACK'] > 0) {?>
                                                                        <button class="btn-app btn-danger" type="button" onclick="approveRecharge('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
','RJECT');">Reject</button>
                                                                    <?php }?>
                                                                </td>
                                                            </tr>
                                                            <?php }?>
                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>    
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
                                                        <?php $_smarty_tpl->_assignInScope('totTransaction', 0);?>
                                                        <?php $_smarty_tpl->_assignInScope('totPartialTransaction', 0);?>

                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ack']->value, 'row', false, 'k', 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>    
                                                            <?php if (($_smarty_tpl->tpl_vars['row']->value->transactionType->code == 'RECHG' || $_smarty_tpl->tpl_vars['row']->value->transactionType->code == 'CGRECHG' || $_smarty_tpl->tpl_vars['row']->value->transactionType->code == 'RVREPT') && ($_smarty_tpl->tpl_vars['row']->value->acknowledgeStatus->code == 'PAID' || $_smarty_tpl->tpl_vars['row']->value->acknowledgeStatus->code == 'PAPAID')) {?>
                                                                
                                                                <?php $_smarty_tpl->_assignInScope('partialTransactionAmount', 0);?>

                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->partialPaymentList, 'par');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['par']->value) {
?>
                                                                    <?php $_smarty_tpl->_assignInScope('partialTransactionAmount', $_smarty_tpl->tpl_vars['partialTransactionAmount']->value+$_smarty_tpl->tpl_vars['par']->value->transactionAmount);?>
                                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

                                                                <tr id="ack_<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
">
                                                                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
</td>
                                                                    <td nowrap="nowrap"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->transactionDate,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                                                                    <td nowrap="nowrap"><?php echo $_smarty_tpl->tpl_vars['row']->value->transactionType->name;?>
</td>
                                                                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value->transactionAmount,2);?>
</td>
                                                                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['partialTransactionAmount']->value,2);?>
  <?php if ($_smarty_tpl->tpl_vars['row']->value->acknowledgeStatus->code == 'PAPAID') {?><a href="javascript:;" onclick='showUnpaidPartialInfo(<?php echo htmlspecialchars(json_encode($_smarty_tpl->tpl_vars['row']->value->partialPaymentList), ENT_QUOTES, 'UTF-8', true);?>
);'><i class="fa fa-info-circle" aria-hidden="true"></i></a><?php }?></td>
                                                                    <td align="right"><?php echo number_format(($_smarty_tpl->tpl_vars['row']->value->transactionAmount-$_smarty_tpl->tpl_vars['partialTransactionAmount']->value),2);?>
</td>
                                                                    <td nowrap="nowrap"><?php if ($_smarty_tpl->tpl_vars['row']->value->transactionMode->name != '') {
echo $_smarty_tpl->tpl_vars['row']->value->transactionMode->name;
} else { ?>NA<?php }?></td>
                                                                    <td nowrap="nowrap"><?php echo $_smarty_tpl->tpl_vars['row']->value->paymentHandledBy->username;?>
</td>
                                                                    <td nowrap="nowrap"><?php echo $_smarty_tpl->tpl_vars['row']->value->user->name;?>
</td>
                                                                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value->remarks;?>
</td>
                                                                    <td nowrap="nowrap"> 
                                                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['APOVE-ACK'] > 0) {?>
                                                                            <button class="btn-app btn-success" type="button" onclick="makePaymentDialog('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->transactionMode->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->transactionAmount-$_smarty_tpl->tpl_vars['partialTransactionAmount']->value;?>
');">Make Payment</button>
                                                                        <?php }?>                                                                    
                                                                    </td>
                                                                </tr>
                                                                
                                                                <?php $_smarty_tpl->_assignInScope('totTransaction', $_smarty_tpl->tpl_vars['totTransaction']->value+$_smarty_tpl->tpl_vars['row']->value->transactionAmount);?>
                                                                <?php $_smarty_tpl->_assignInScope('totPartialTransaction', $_smarty_tpl->tpl_vars['totPartialTransaction']->value+$_smarty_tpl->tpl_vars['partialTransactionAmount']->value);?>
                                                            <?php }?>
                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                        <?php if (count($_smarty_tpl->tpl_vars['ack']->value)) {?>
                                                            <tr>
                                                                <td colspan="3" class="bold text-right">Total</td>
                                                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['totTransaction']->value,2);?>
</td>
                                                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['totPartialTransaction']->value,2);?>
</td>
                                                                <td align="right"><?php echo number_format(($_smarty_tpl->tpl_vars['totTransaction']->value-$_smarty_tpl->tpl_vars['totPartialTransaction']->value),2);?>
</td>
                                                                <td colspan="5"></td>
                                                            </tr>
                                                        <?php }?>   
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
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transactionMode']->value, 'value', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['value']->value) {
?>
                    <option value="<?php echo $_smarty_tpl->tpl_vars['key']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value;?>
</option>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
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
                

<?php echo '<script'; ?>
>
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
<?php echo '</script'; ?>
>
<?php }
}
