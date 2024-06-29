<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-13 15:13:03
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\collection-report-list-xls.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666abf2740fd32_04916837',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'c9fd8a220968ac018eb9b754e922d5336f9f0cd4' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\collection-report-list-xls.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666abf2740fd32_04916837 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table border='1'>
    <tr>
        <td colspan="6" align="center"><b>Cargo Collection Report</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp;<?php echo smarty_modifier_date_format($_REQUEST['fromDate'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to <?php echo smarty_modifier_date_format($_REQUEST['toDate'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp;<?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp;<?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>
</td>
    </tr>
</table>

<h5>Summary</h5>
<table border='1'>
    <thead>
        <tr style="background-color: #64b92a; color: #fff;">
            <th align="center">Branch</th>
            <th align="center">Total Collection</th>
            <th align="center">By Paid Booking</th>
            <th align="center">By ToPay Delivery / <?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value['TPPAD'];?>
</th>
        </tr>
    </thead>
    <tbody>
        <?php $_smarty_tpl->_assignInScope('tot_netpay', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_paid', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_topaypaid', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_topay', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_handling', 0);?>

        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'row', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
            <tr>
                <td style="font-weight:bold"><?php echo $_smarty_tpl->tpl_vars['key']->value;?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value['netPayable'];?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value['paid'];?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value['topaypaid'];?>
</td>
            </tr>
            <?php $_smarty_tpl->_assignInScope('tot_netpay', $_smarty_tpl->tpl_vars['tot_netpay']->value+$_smarty_tpl->tpl_vars['row']->value['netPayable']);?>
            <?php $_smarty_tpl->_assignInScope('tot_topaypaid', $_smarty_tpl->tpl_vars['tot_topaypaid']->value+$_smarty_tpl->tpl_vars['row']->value['topaypaid']);?>
            <?php $_smarty_tpl->_assignInScope('tot_paid', $_smarty_tpl->tpl_vars['tot_paid']->value+$_smarty_tpl->tpl_vars['row']->value['paid']);?>
            <?php $_smarty_tpl->_assignInScope('tot_topay', $_smarty_tpl->tpl_vars['tot_topay']->value+$_smarty_tpl->tpl_vars['row']->value['toPay']);?>
            <?php $_smarty_tpl->_assignInScope('tot_handling', $_smarty_tpl->tpl_vars['tot_handling']->value+$_smarty_tpl->tpl_vars['row']->value['handlingCharges']);?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

        <?php if (count($_smarty_tpl->tpl_vars['summary']->value)) {?>
        <tfoot>
            <tr style="font-weight:bold">
                <td align="right">Total</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['tot_netpay']->value;?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['tot_paid']->value;?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['tot_topaypaid']->value;?>
</td>
            </tr>
        </tfoot>
    <?php } else { ?>
        <tfoot>
            <tr>
                <td colspan="4" align="center">No Records Found</td>
            </tr>
        </tfoot>
    <?php }?>
    </tbody>
</table>
    
<div class="clearfix"></div>
<h5>Transactions</h5>
<table  border='1'>
    <thead>
        <tr style="background-color: #64b92a; color: #fff;">
            <td align="center"><?php echo lang('cargo_code_term');?>
</td>
            <td align="center">Booked Date</td>
            <td align="center"><?php echo lang('booking_from_term');?>
</td>
            <td align="center">User</td>
            <td align="center"><?php echo lang('booking_to_label');?>
</td>
            <td align="center"><?php echo lang('booking_sender_term');?>
</td>
            <td align="center"><?php echo lang('booking_receiver_term');?>
</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
            <td align="center">Qty</td>
            <td align="center">Net Payable</td>
            <td align="center">Handling Charges</td>
            <td align="center"><?php echo lang('other_charges');?>
 </td>
            <td align="center">Received</td>
            <td align="center">Balance</td>
        </tr>
    </thead>
    <tbody>
        <?php $_smarty_tpl->_assignInScope('tot_items', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_transaction_amount', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_other_charges_amount', 0);?>

        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'value', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['value']->value) {
?>
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td colspan="15" align="center"><?php echo $_smarty_tpl->tpl_vars['key']->value;?>
</td>
            </tr>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['value']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</td>
                    <td align="center"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->user_first_name;?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
 - <?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->from_customer_mobile);?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
 - <?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->to_customer_mobile);?>
</td>
                    <td align="center" id="pay_state_<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
">
                        <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_status_code);?>

                    </td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>

                    <td align="center" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->net_payable;?>
</td>
                    <td align="center" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_handling_amount;?>
</td>
                    <td align="center" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
" nowrap>
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->other_charges_amount;?>

                    </td>
                    <td align="center" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->transaction_amount;?>
</td>
                    <td align="center" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->topay;?>
</td>
                </tr>
                <?php $_smarty_tpl->_assignInScope('tot_transaction_amount', $_smarty_tpl->tpl_vars['tot_transaction_amount']->value+$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_other_charges_amount', $_smarty_tpl->tpl_vars['tot_other_charges_amount']->value+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_items', $_smarty_tpl->tpl_vars['tot_items']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </tbody>
    <?php if (count($_smarty_tpl->tpl_vars['result']->value)) {?>
        <tfoot>
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td align="center" colspan="2" style="font-weight:bold"></td>
                <td align="center" colspan="2" style="font-weight:bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value['PAD'];?>
 : <?php echo $_smarty_tpl->tpl_vars['total']->value['paid'];?>
</td>
                <td align="center" colspan="2" style="font-weight:bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value['TPPAD'];?>
 : <?php echo $_smarty_tpl->tpl_vars['total']->value['topaypaid'];?>
</td>
                <td align="center" colspan="3" style="font-weight:bold">Total</td>
                <td align="center" style="font-weight:bold"><?php echo $_smarty_tpl->tpl_vars['tot_items']->value;?>
</td>
                <td align="center" style="font-weight:bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['tot_netpay']->value;?>
</td>
                <td align="center" class="font-weight:bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['tot_handling']->value;?>
</td>
                <td align="center" class="font-weight:bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['tot_other_charges_amount']->value;?>
</td>
                <td align="center" style="font-weight:bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['tot_transaction_amount']->value;?>
</td>
                <td align="center" style="font-weight:bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['tot_topay']->value;?>
</td>
            </tr>
        </tfoot>
    <?php } else { ?>
        <tfoot>
            <tr>
                <td colspan="15" align="center">No Records Found</td>
            </tr>
        </tfoot>
    <?php }?>
</table>
<br><br>

<table border='1'>
    <thead>
        <tr style="background-color: #ffff00; color: #000000;">
            <td align="center">S.no</td>
            <td align="center">Payment type</td>
            <td align="center">Customer Name</td>
            <td align="center">Lr No</td>
            <td align="center">Lr Date </td>
            <td align="center">Lr Amount</td>
            <td align="center">From</td>
            <td align="center">To</td>
            <td align="center">Cr No / date</td>
            <td align="center">Invoice No/ Date</td>
            <td align="center">Voucher no / Date</td>
            <td align="center">Remarks</td>
        </tr>
    </thead>
    <tbody>
        <?php $_smarty_tpl->_assignInScope('tot_items', 0);?>
        <?php $_smarty_tpl->_assignInScope('s_no', 0);?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'value', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['value']->value) {
?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['value']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <?php $_smarty_tpl->_assignInScope('s_no', $_smarty_tpl->tpl_vars['s_no']->value+1);?>
                <tr>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['s_no']->value;?>
</td>
                    <td align="left"> <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_status_code);?>
</td>
                    <td align="left">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'PAD') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>

                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'TOP') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>

                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>

                        <?php }?>
                    </td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</td>
                    <td align="left"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->net_payable;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                    <td align="left"><?php if (isset($_smarty_tpl->tpl_vars['row']->value->transaction_receipt_code)) {
echo $_smarty_tpl->tpl_vars['row']->value->transaction_receipt_code;?>
 / <?php echo $_smarty_tpl->tpl_vars['row']->value->receipt_transaction_date;
}?></td>
                    <td align="left"><?php if (isset($_smarty_tpl->tpl_vars['row']->value->voucher_number)) {?> <?php echo $_smarty_tpl->tpl_vars['row']->value->voucher_number;?>
 / <?php echo $_smarty_tpl->tpl_vars['row']->value->voucher_transaction_date;?>
 <?php }?></td>
                    <td align="left"> <?php if (isset($_smarty_tpl->tpl_vars['row']->value->invoice_number)) {
echo $_smarty_tpl->tpl_vars['row']->value->invoice_number;?>
 / <?php echo $_smarty_tpl->tpl_vars['row']->value->invoice_date;?>
 <?php }?></td>
                    <td align="left"></td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </tbody>
</table>
<br><br>
<table border='1'>
    <thead>
        <tr style="background-color: #ffff00; color: #000000;">
            <td align="center" colspan="3">Summary</td>
        </tr>
        <tr style="background-color: #ffff00; color: #000000;">
            <td align="center">TYPE</td>
            <td align="center">COUNT</td>
            <td align="center">AMOUNT</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td align="center">Topay By Cash</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['topay_cash_lr']->value;?>
</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['topay_cash_amount']->value;?>
</td>
        </tr>
        <tr>
            <td align="center">Topay By Cheque</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['topay_check_lr']->value;?>
</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['topay_check_amount']->value;?>
</td>
        </tr>
        <tr>
            <td align="center">Topay By Net Banking</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['topay_bank_lr']->value;?>
</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['topay_bank_amount']->value;?>
</td>
        </tr>
        <tr>
            <td align="center">Paid By Cash</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['paid_cash_lr']->value;?>
</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['paid_cash_amount']->value;?>
</td>
        </tr>
        <tr>
            <td align="center">Paid By Cheque</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['paid_check_lr']->value;?>
</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['paid_check_amount']->value;?>
</td>
        </tr>
        <tr>
            <td align="center">Paid By Net Banking</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['paid_bank_lr']->value;?>
</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['paid_bank_amount']->value;?>
</td>
        </tr>
        <tr>
            <td align="center">Invoice Received By Cash</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['Account_cash_lr']->value;?>
</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['Account_cash_amount']->value;?>
</td>
        </tr>
        <tr>
            <td align="center">Invoice Received By Cheque</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['Account_check_lr']->value;?>
</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['Account_check_amount']->value;?>
</td>
        </tr>
        <tr>
            <td align="center">Invoice Received Net Banking</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['Account_bank_lr']->value;?>
</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['Account_bank_amount']->value;?>
</td>
        </tr>
        <tr>
            <td align="center"><b>Total</b></td>
            <td align="center"><?php echo ($_smarty_tpl->tpl_vars['topay_cash_lr']->value+$_smarty_tpl->tpl_vars['topay_check_lr']->value+$_smarty_tpl->tpl_vars['topay_bank_lr']->value+$_smarty_tpl->tpl_vars['paid_cash_lr']->value+$_smarty_tpl->tpl_vars['paid_check_lr']->value+$_smarty_tpl->tpl_vars['paid_bank_lr']->value+$_smarty_tpl->tpl_vars['Account_cash_lr']->value+$_smarty_tpl->tpl_vars['Account_check_lr']->value+$_smarty_tpl->tpl_vars['Account_bank_lr']->value);?>
</td>
            <td align="center"><?php echo ($_smarty_tpl->tpl_vars['Account_bank_amount']->value+$_smarty_tpl->tpl_vars['Account_check_amount']->value+$_smarty_tpl->tpl_vars['Account_cash_amount']->value+$_smarty_tpl->tpl_vars['paid_bank_amount']->value+$_smarty_tpl->tpl_vars['paid_check_amount']->value+$_smarty_tpl->tpl_vars['paid_cash_amount']->value+$_smarty_tpl->tpl_vars['topay_cash_amount']->value+$_smarty_tpl->tpl_vars['topay_check_amount']->value+$_smarty_tpl->tpl_vars['topay_bank_amount']->value);?>
</td>
        </tr>
    </tbody>
</table><?php }
}
