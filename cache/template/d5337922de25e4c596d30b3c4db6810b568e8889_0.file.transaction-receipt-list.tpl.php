<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-15 14:53:08
  from 'E:\xampp\htdocs\cargo\application\views\site\payment\transaction-receipt-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666d5d7cd990c5_85523372',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'd5337922de25e4c596d30b3c4db6810b568e8889' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\payment\\transaction-receipt-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666d5d7cd990c5_85523372 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.truncate.php','function'=>'smarty_modifier_truncate',),));
?>
<table id="txn-rcpt-list-table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th align="center">Receipt No</th>
            <th align="center">Created By</th>
            <th align="center">Customer / Vendor</th>
            <th align="center">Receipt Details</th>

            <th align="center">Payment Mode</th>
            <th align="center">Payment Details</th>

            <th align="center">Received Date</th>

            <th class="text-center">Txn Amount <br/>(A)</th>
            <th class="text-center">Charges <br/>(B)</th>
            <th class="text-center">TDS Amount <br/>(C)</th>
            <th class="text-center">Total Amount <br/>(D = A+B)</th>
            <?php if ($_smarty_tpl->tpl_vars['receiptStatus']->value == 'INIT') {?><th></th><?php }?>
        </tr>
    </thead>
    <tbody class="body_table" >
        <?php $_smarty_tpl->_assignInScope('txn_trxn_amt', 0);?>
        <?php $_smarty_tpl->_assignInScope('txn_charges', 0);?>
        <?php $_smarty_tpl->_assignInScope('txn_tds_amt', 0);?>
        <?php $_smarty_tpl->_assignInScope('txn_total_amt', 0);?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
            <tr>
                <td align="left">
                    <?php if ($_smarty_tpl->tpl_vars['row']->value->transactionReceiptType->code == "LR" && $_smarty_tpl->tpl_vars['namespace']->value == "seenutransport") {?>
                        <a href="javascript:;" onclick="showTransactionReceiptPdfDialog('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
');"><?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
</a>
                    <?php } else { ?>
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>

                    <?php }?>
                </td>
                <td align="left">
                    <?php echo $_smarty_tpl->tpl_vars['row']->value->createdUser->name;?>
<br>
                    <span class="text-muted small"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->transactionDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</span>
                </td>
                <td align="left" nowrap>
                    <?php if ($_smarty_tpl->tpl_vars['row']->value->cargoCustomer->code) {?>
                        <span title="<?php echo $_smarty_tpl->tpl_vars['row']->value->cargoCustomer->name;?>
"><?php echo smarty_modifier_truncate($_smarty_tpl->tpl_vars['row']->value->cargoCustomer->name,25,"..",true);?>
</span>
                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cargoVendor->code) {?>
                        <span title="<?php echo $_smarty_tpl->tpl_vars['row']->value->cargoVendor->companyName;?>
"><?php echo smarty_modifier_truncate($_smarty_tpl->tpl_vars['row']->value->cargoVendor->companyName,25,"..",true);?>
</span>
                    <?php }?> <br>
                    <span class="text-muted small"><?php echo $_smarty_tpl->tpl_vars['row']->value->transactionReceiptType->name;?>
</span>
                </td>
                <td align="left" width="200px">
                    <?php if ((count($_smarty_tpl->tpl_vars['row']->value->cargoBookings)) > 0) {?>
                        <a id="popup_msg"  data-content='<ul class="p_l_15">
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->cargoBookings, 'lr');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['lr']->value) {
?>
                                    <li><?php echo $_smarty_tpl->tpl_vars['lr']->value->code;?>
</li>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </ul>'>
                            <?php if ((count($_smarty_tpl->tpl_vars['row']->value->cargoBookings)) >= 1) {
echo $_smarty_tpl->tpl_vars['row']->value->cargoBookings[0]->code;
}?>
                            <?php if ((count($_smarty_tpl->tpl_vars['row']->value->cargoBookings)) > 1) {?><span style="cursor:pointer;" class="badge badge-secondary"><?php echo count($_smarty_tpl->tpl_vars['row']->value->cargoBookings);?>
</span><?php }?>
                        </a>
                    <?php } elseif ((count($_smarty_tpl->tpl_vars['row']->value->paymentTransactions)) > 0) {?>
                        <a id="popup_msg"  data-content='<ul class="p_l_15">
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->paymentTransactions, 'inv');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['inv']->value) {
?>
                                    <li><?php echo $_smarty_tpl->tpl_vars['inv']->value->code;?>
</li>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </ul>'>
                            <?php if ((count($_smarty_tpl->tpl_vars['row']->value->paymentTransactions)) >= 1) {
echo $_smarty_tpl->tpl_vars['row']->value->paymentTransactions[0]->code;
}?>
                            <?php if ((count($_smarty_tpl->tpl_vars['row']->value->paymentTransactions)) > 1) {?><span style="cursor:pointer;" class="badge badge-secondary"><?php echo count($_smarty_tpl->tpl_vars['row']->value->paymentTransactions);?>
</span><?php }?>
                        </a>
                    <?php }?>
                </td>

                <td align="left">
                    <?php echo $_smarty_tpl->tpl_vars['row']->value->transactionMode->name;?>
&nbsp;
                    <?php if ($_smarty_tpl->tpl_vars['row']->value->addAttr1 || $_smarty_tpl->tpl_vars['row']->value->addAttr2 || $_smarty_tpl->tpl_vars['row']->value->addAttr3) {?>
                        <a href="javascript:;" class="popup_msg" data-content="
                        <b>Customer Payment Details</b><br>
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->addAttr1;?>
<br>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->addAttr2) {
echo $_smarty_tpl->tpl_vars['row']->value->addAttr2;?>
<br><?php }?>
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->addAttr3;?>

                        "><i class="fa fa-info-circle"></i></a>
                    <?php }?>
                </td>
                
                <td align="left">
                    <?php if ($_smarty_tpl->tpl_vars['row']->value->bankDetails->code) {?>
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->bankDetails->bankName;?>
 <br> <?php echo $_smarty_tpl->tpl_vars['row']->value->bankDetails->branchLocation;?>
 <br> <?php echo $_smarty_tpl->tpl_vars['row']->value->bankDetails->upiId;?>

                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->chequeDetails->code) {?>
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->chequeDetails->chequeNo;?>
 <br> <?php echo $_smarty_tpl->tpl_vars['row']->value->chequeDetails->payerDetails;?>
 <br> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->chequeDetails->chequeDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

                    <?php } else { ?>
                        -
                    <?php }?>
                </td>

                <td align="center"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->amountReceivedDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>

                <td align="right">
                    <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->transactionAmount);?>

                    <?php if ($_smarty_tpl->tpl_vars['row']->value->paymentTransactions[0]->additionalAttributes) {?>
                        <span data-toggle="tooltip" title="
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->paymentTransactions, 'inv');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['inv']->value) {
?>
                                <?php if ($_smarty_tpl->tpl_vars['inv']->value->additionalAttributes) {?>
                                    <?php $_smarty_tpl->_assignInScope('additionalAttributes', explode("|",$_smarty_tpl->tpl_vars['inv']->value->additionalAttributes->ADV));?>
                                    <?php echo implode($_smarty_tpl->tpl_vars['additionalAttributes']->value,'<br>');?>

                                <?php }?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        "><i class="fa fa-info-circle"></i></span>
                    <?php }?>
                </td>
                <?php $_smarty_tpl->_assignInScope('charges', ($_smarty_tpl->tpl_vars['row']->value->machineHandlingCharge+$_smarty_tpl->tpl_vars['row']->value->demurrageCharge));?>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['charges']->value);?>
 <span title="Machine Handling : <?php echo $_smarty_tpl->tpl_vars['row']->value->machineHandlingCharge;?>
<br/>Demurrage : <?php echo $_smarty_tpl->tpl_vars['row']->value->demurrageCharge;?>
" data-toggle="tooltip"><i class="fa fa-info-circle"></i></span></td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->tdsAmount);?>
</td>
                <td align="right"><?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->transactionAmount+$_smarty_tpl->tpl_vars['charges']->value));?>
</td>
                <?php if ($_smarty_tpl->tpl_vars['receiptStatus']->value == 'INIT') {?>
                <td align="center">
                    <a href="javascript:;" class="btn btn-success btn-xs" title="Approve" onclick="approveTransactionReceipt('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
')">Approve</a>
                    <a href="javascript:;" class="btn btn-danger btn-xs" title="Reject"  onclick="rejectTransactionReceipt('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
')">Reject</a>
                </td>
                <?php }?>
            </tr>
            <?php $_smarty_tpl->_assignInScope('txn_trxn_amt', $_smarty_tpl->tpl_vars['txn_trxn_amt']->value+$_smarty_tpl->tpl_vars['row']->value->transactionAmount);?>
            <?php $_smarty_tpl->_assignInScope('txn_charges', $_smarty_tpl->tpl_vars['txn_charges']->value+$_smarty_tpl->tpl_vars['charges']->value);?>
            <?php $_smarty_tpl->_assignInScope('txn_tds_amt', $_smarty_tpl->tpl_vars['txn_tds_amt']->value+$_smarty_tpl->tpl_vars['row']->value->tdsAmount);?>
            <?php $_smarty_tpl->_assignInScope('txn_total_amt', $_smarty_tpl->tpl_vars['txn_total_amt']->value+$_smarty_tpl->tpl_vars['row']->value->transactionAmount+$_smarty_tpl->tpl_vars['charges']->value);?>
        <?php
}
} else {
?>
            <tr>
                <td colspan="<?php if ($_smarty_tpl->tpl_vars['receiptStatus']->value == 'INIT') {?>12<?php } else { ?>11<?php }?>" align="center">No data available</td>
            </tr>
        <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php if (count($_smarty_tpl->tpl_vars['result']->value)) {?>
            <tr class="active bold">
                <td colspan="7" align="right">Total</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['txn_trxn_amt']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['txn_charges']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['txn_tds_amt']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['txn_total_amt']->value);?>
</td>
                <?php if ($_smarty_tpl->tpl_vars['receiptStatus']->value == 'INIT') {?><td></td><?php }?>
            </tr>
        <?php }?>
    </tbody>
</table>

<?php echo '<script'; ?>
>
    $('[data-toggle="tooltip"]').tooltip({
        html: true
    });

    $('a[id=popup_msg]').attr('data-toggle', 'popover');
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'click'
    });

    $('a[class=popup_msg]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover',
    });
<?php echo '</script'; ?>
><?php }
}
