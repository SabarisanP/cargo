<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-28 15:17:48
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\unpaid-invoices.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6655a844eceaa7_20020204',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '51184b0be5588e1cbec79169a1b657e4f8389d1f' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\unpaid-invoices.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6655a844eceaa7_20020204 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<h5>Summary</h5>
<div class="table-responsive col-md-5 p_l_n">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th align="center">Vendor</th>
                <th align="center">Branch</th>
                <th align="center">Invoice Amount</th>
                <th align="center">Paid Amount</th>
                <th align="center">Balance Amount</th>
            </tr>
        </thead>
        <tbody>
            <?php $_smarty_tpl->_assignInScope('transactionAmount', 0);?>
            <?php $_smarty_tpl->_assignInScope('partialPaymentAmount', 0);?>
            <?php $_smarty_tpl->_assignInScope('balanceAmountTotal', 0);?>
            <?php $_smarty_tpl->_assignInScope('balanceAmount', 0);?>

            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'row', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <?php $_smarty_tpl->_assignInScope('balanceAmount', $_smarty_tpl->tpl_vars['row']->value['transactionAmount']-$_smarty_tpl->tpl_vars['row']->value['partialPaymentAmount']);?>
                <tr>
                    <td class="bold"><?php echo $_smarty_tpl->tpl_vars['key']->value;?>
</td>
                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value['branch'];?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['transactionAmount'],2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['partialPaymentAmount'],2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['balanceAmount']->value,2);?>
</td>
                </tr>
                <?php $_smarty_tpl->_assignInScope('transactionAmount', $_smarty_tpl->tpl_vars['transactionAmount']->value+$_smarty_tpl->tpl_vars['row']->value['transactionAmount']);?>
                <?php $_smarty_tpl->_assignInScope('partialPaymentAmount', $_smarty_tpl->tpl_vars['partialPaymentAmount']->value+$_smarty_tpl->tpl_vars['row']->value['partialPaymentAmount']);?>
                <?php $_smarty_tpl->_assignInScope('balanceAmountTotal', $_smarty_tpl->tpl_vars['balanceAmountTotal']->value+$_smarty_tpl->tpl_vars['balanceAmount']->value);?>
            <?php
}
} else {
?>
                <tr>
                    <td colspan="5" align="center">No Records Found!</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

            <?php if (count($_smarty_tpl->tpl_vars['summary']->value)) {?>
                <tr class="bold">
                    <td align="right" colspan="2">Total</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['transactionAmount']->value,2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['partialPaymentAmount']->value,2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['balanceAmountTotal']->value,2);?>
</td>
                </tr>
            <?php }?>
        </tbody>
    </table>
</div>
<br/>
<div class="clearfix"></div>
<h5>Invoices</h5>
<div class="table-responsive">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th align="center">Invoice No</th>
                <th align="center">Vendor</th>
                <th align="center">Branch</th>
                <th align="center">Created Date</th>
                <th align="center">Created By</th>
                <th align="center">Invoice Peroid</th>
                                <th align="center">Invoice Amount</th>
                                <th align="center">Balance Amount</th>
                <th align="center">Remarks</th>
                <th align="center"></th>
            </tr>
        </thead>
        <tbody class="body_table">
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'branch', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['branch']->value) {
?>
                <tr class="bold active">
                    <td colspan="10" align="center"><?php echo $_smarty_tpl->tpl_vars['key']->value;?>
</td>
                </tr>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branch']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                    <tr id="vou_<?php echo clean_string($_smarty_tpl->tpl_vars['row']->value->code);?>
">
                        <td align="left">
                            <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "seenutransport") {?>
                                <a href="javascript:;" onclick="view_option_invioce('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
');"><?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
</a>
                            <?php } else { ?>
                                <a href="javascript:;" onclick="showInvoicePdfDialog('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
');"><?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
</a>
                            <?php }?>
                         
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->additionalAttributes->CUSTOMER_INVOICE_ACK_STATUS == 1) {?>
                                <span class="badge badge-success" data-toggle="popover" data-content="<b>Invoice Acknowledgement Completed<b>" style="font-size: 9px;cursor:pointer;">C</span>
                            <?php }?>
                        </td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->user->name;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->user->organization->name;?>
</td>
                        <td align="left"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->transactionDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->paymentHandledBy->name;?>
</td>
                        <td align="left">
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->transactionStartDate != '' || $_smarty_tpl->tpl_vars['row']->value->transactionEndDate != '') {?>
                                <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->transactionStartDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->transactionEndDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

                            <?php } else { ?>
                                -
                            <?php }?>
                        </td>
                                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value->transactionAmount,2);?>
</td>
                                                <td align="right"><?php echo number_format(($_smarty_tpl->tpl_vars['row']->value->transactionAmount-$_smarty_tpl->tpl_vars['row']->value->partialTransactionAmount),2);?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->remarks;?>
</td>
                        <td align="right">
                            <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->userAccountModel->code == 'TXRT') {?>
                                <?php if ($_smarty_tpl->tpl_vars['row']->value->additionalAttributes->CUSTOMER_INVOICE_ACK_STATUS == 1) {?>
                                    <button class="btn-app btn-success" type="button" onclick="payInvoice('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
');">Update Paid</button>
                                <?php } else { ?>
                                    <a href="javascript:;" data-toggle="popover" data-content="<b>Invoice Acknowledgement Pending<b>" style="cursor:pointer;"><i class="fa fa-info-circle" aria-hidden="true"></i></a>&nbsp;
                                <?php }?>
                            <?php } else { ?>
                                <button class="btn-app btn-success" type="button" onclick="payInvoice('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
');">Update Paid</button>
                            <?php }?>
                            <button class="btn-app btn-danger" type="button" onclick="rejectInvoice('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
');">Reject</button>
                        </td>
                    </tr>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            <?php
}
} else {
?>
                <tr>
                    <td colspan="10" align="center">No Records Found!</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
    </table>
</div>

<?php echo '<script'; ?>
>
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
<?php echo '</script'; ?>
><?php }
}
