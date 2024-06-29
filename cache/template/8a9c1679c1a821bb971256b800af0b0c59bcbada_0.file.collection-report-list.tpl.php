<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-13 15:09:45
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\collection-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666abe61be8801_12279701',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '8a9c1679c1a821bb971256b800af0b0c59bcbada' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\collection-report-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666abe61be8801_12279701 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table class="" width="99%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Cargo Collection Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            <?php echo smarty_modifier_date_format($_REQUEST['fromDate'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
  to <?php echo smarty_modifier_date_format($_REQUEST['toDate'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> <?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>
 </td>
    </tr>
</table>
<br/>
<h5>Summary</h5>
<div class="table-responsive col-md-6 p_l_n">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
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
                    <td class="bold"><?php echo $_smarty_tpl->tpl_vars['key']->value;?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['netPayable'],2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['paid'],2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['topaypaid'],2);?>
</td>                    
                </tr>
                <?php $_smarty_tpl->_assignInScope('tot_netpay', $_smarty_tpl->tpl_vars['tot_netpay']->value+$_smarty_tpl->tpl_vars['row']->value['netPayable']);?>
                <?php $_smarty_tpl->_assignInScope('tot_topaypaid', $_smarty_tpl->tpl_vars['tot_topaypaid']->value+$_smarty_tpl->tpl_vars['row']->value['topaypaid']);?>
                <?php $_smarty_tpl->_assignInScope('tot_paid', $_smarty_tpl->tpl_vars['tot_paid']->value+$_smarty_tpl->tpl_vars['row']->value['paid']);?>
                <?php $_smarty_tpl->_assignInScope('tot_topay', $_smarty_tpl->tpl_vars['tot_topay']->value+$_smarty_tpl->tpl_vars['row']->value['toPay']);?>
                <?php $_smarty_tpl->_assignInScope('tot_handling', $_smarty_tpl->tpl_vars['tot_handling']->value+$_smarty_tpl->tpl_vars['row']->value['handlingCharges']);?>
            <?php
}
} else {
?>
                <tr>
                    <td colspan="4" align="center">No Records Found!</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

            <?php if (count($_smarty_tpl->tpl_vars['summary']->value)) {?>
                <tr class="bold">
                    <td align="right">Total</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tot_netpay']->value,2);?>
</td>                    
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tot_paid']->value,2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tot_topaypaid']->value,2);?>
</td>                    
                </tr>
            <?php }?>
        </tbody>
    </table>
</div>
<br/>
<div class="clearfix"></div>
<h5>Transactions</h5>
<table class="table table-bordered" width="99%">
    <thead>
        <tr class="success">
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
    <tbody class="body_table">
        <?php $_smarty_tpl->_assignInScope('tot_items', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_transaction_amount', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_other_charges_amount', 0);?>

        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'value', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['value']->value) {
?>
            <tr class="active">
                <td colspan="15" align="center"><?php echo $_smarty_tpl->tpl_vars['key']->value;?>
</td>
            </tr>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['value']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
                    <td align="left"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->user_first_name;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
 - <?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->from_customer_mobile);?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
 - <?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->to_customer_mobile);?>
</td>
                    <td align="center" id="pay_state_<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
">
                    <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_status_code);?>

                    </td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>

                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->net_payable;?>
</td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_handling_amount;?>
</td>
                    <td align="right" nowrap>
                        <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>


                        <?php if ($_smarty_tpl->tpl_vars['row']->value->other_charges_amount != 0) {?>
                            <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                <table>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, _parse_other_charges($_smarty_tpl->tpl_vars['row']->value->other_charges), 'cv', false, 'ck');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['ck']->value => $_smarty_tpl->tpl_vars['cv']->value) {
?>
                                        <?php if ($_smarty_tpl->tpl_vars['cv']->value == 0) {?>
                                            <?php continue 1;?>
                                        <?php }?>
                                        <tr>
                                            <td><b><?php echo _camelcase_to_titlecase($_smarty_tpl->tpl_vars['ck']->value);?>
</b></td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['cv']->value);?>
</td>
                                        </tr>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </table>
                            '></i>
                        <?php } else { ?>
                            <i class="fa fa-info-circle fa-inverse"></i>
                        <?php }?>
                    </td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->transaction_amount;?>
</td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->topay;?>

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
} else {
?>
            <tr>
                <td colspan="15" align="center">No Records Found!</td>
            </tr>
        <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php if (count($_smarty_tpl->tpl_vars['result']->value)) {?>
        <tr class="active">
            <td align="right" colspan="2" class="bold"></td> 
            <td align="center" colspan="2" class="bold"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value['PAD'];?>
 : <?php echo inr_format($_smarty_tpl->tpl_vars['total']->value['paid']);?>
</td> 
            <td align="center" colspan="2" class="bold"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value['TPPAD'];?>
 : <?php echo inr_format($_smarty_tpl->tpl_vars['total']->value['topaypaid']);?>
</td> 
            <td align="right" colspan="3" class="bold">Total</td>
            <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['tot_items']->value;?>
</td>
            <td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['tot_netpay']->value,2);?>
</td>
            <td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['tot_handling']->value,2);?>
</td>
            <td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['tot_other_charges_amount']->value,2);?>
</td>
            <td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['tot_transaction_amount']->value,2);?>
</td>
            <td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['tot_topay']->value,2);?>
</td>
        </tr>
        <?php }?>
    </tbody>
</table>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoCollection();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
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
