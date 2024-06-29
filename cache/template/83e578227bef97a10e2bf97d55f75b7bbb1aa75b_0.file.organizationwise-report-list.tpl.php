<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-13 18:18:30
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\organizationwise-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666aea9e50fec7_23481204',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '83e578227bef97a10e2bf97d55f75b7bbb1aa75b' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\organizationwise-report-list.tpl',
      1 => 1718282907,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666aea9e50fec7_23481204 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold"><?php echo iflang('Organization Wise Report');?>
</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['from_date']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to
            <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['to_date']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

        </td>
        <td width="50%" align="right"><span class="bold">Report At : </span>
            <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> <?php echo $_smarty_tpl->tpl_vars['username']->value;?>
 </td>
    </tr>
</table>

<h5 class="noprint"><b>Summary</b></h5>
<div class="row">
    <div class="col-md-4">
        <table class="table table-bordered noprint">
            <tr>
                <td class="bold">Freight (A)</td>
                <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['freight']);?>
</td>

                <td class="bold">Received</td>
                <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['paid']);?>
</td>
            </tr>
            <tr>
                <td class="bold">Handling Charges (B)</td>
                <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['handling']);?>
</td>

                <td class="bold">Balance</td>
                <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['topay']);?>
</td>
            </tr>
            <tr>
                <td class="bold">Unloading Charges (C)</td>
                <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['unloading']);?>
</td>

                <td class="bold"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value['INP'];?>
</td>
                <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['invoicepay']);?>
</td>
            </tr>
            <tr>
                <td class="bold">GST (D)</td>
                <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['gst']);?>
</td>

                <td class="bold">&nbsp;</td>
                <td class="text-right">&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Pickup Charges (E)</td>
                <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['pickup']);?>
</td>

                <td class="bold">&nbsp;</td>
                <td class="text-right">&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Delivery Charges (F)</td>
                <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['delivery']);?>
</td>

                <td class="bold">&nbsp;</td>
                <td class="text-right">&nbsp;</td>
            </tr>
            <tr>
                <td class="bold">Connecting Charges (G)</td>
                <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['connecting']);?>
</td>

                <td class="bold">&nbsp;</td>
                <td class="text-right">&nbsp;</td>
            </tr>
            <tr>
                <td class="bold"><?php echo lang('other_charges');?>
 (H)</td>
                <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['service_charge']);?>
</td>

                <td class="bold">&nbsp;</td>
                <td class="text-right">&nbsp;</td>
            </tr>

            <tr>
                <td class="bold" nowrap>Sub Total (S1 = A+B+C+D+E+F+G+H)</td>
                <td class="text-right">
                    <?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['netpayable']);?>

                </td>

                <td class="bold">&nbsp;</td>
                <td class="text-right"></td>
            </tr>

            <tr>
                <td class="bold">Commission (I)</td>
                <td class="text-right">
                    <?php echo inr_format(($_smarty_tpl->tpl_vars['amounts']->value['commission']-$_smarty_tpl->tpl_vars['amounts']->value['handling_commission']));?>

                </td>

                <td class="bold">&nbsp;</td>
                <td class="text-right"></td>
            </tr>

            <tr>
                <td class="bold">Share (J)</td>
                <td class="text-right">
                    <?php echo inr_format(($_smarty_tpl->tpl_vars['amounts']->value['handling_commission']));?>

                </td>

                <td class="bold">&nbsp;</td>
                <td class="text-right"></td>
            </tr>

            <tr>
                <td class="bold">Net Total (S1-I-J)</td>
                <td class="bold text-right">
                    <?php echo inr_format(($_smarty_tpl->tpl_vars['amounts']->value['netpayable']-$_smarty_tpl->tpl_vars['amounts']->value['commission']));?>

                </td>

                <td class="bold">&nbsp;</td>
                <td class="text-right"></td>
            </tr>
        </table>
    </div>
    <div class="col-md-3">
        <table class="table table-bordered noprint">
            <tr class="success">
                <th class="bold"></th>
                <th class="text-right">LRs</th>
                <th class="text-right">No. Of Articles</th>
                <th class="text-right">Freight</th>
            </tr>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'row', false, 'paytype');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['paytype']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td class="bold"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['paytype']->value];?>
</td>
                    <td class="text-right"><?php echo sigma(($_smarty_tpl->tpl_vars['row']->value['count']+0),$_smarty_tpl->tpl_vars['summ_count']->value);?>
</td>
                    <td class="text-right"><?php echo sigma(($_smarty_tpl->tpl_vars['row']->value['qtycount']+0),$_smarty_tpl->tpl_vars['summ_qty']->value);?>
</td>
                    <td class="text-right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['freight'],$_smarty_tpl->tpl_vars['summ_freight']->value));?>
</td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            <?php if (count($_smarty_tpl->tpl_vars['summary']->value)) {?>
                <tr>
                    <td class="bold">Total</td>
                    <td class="bold text-right"><?php echo $_smarty_tpl->tpl_vars['summ_count']->value;?>
</td>
                    <td class="bold text-right"><?php echo $_smarty_tpl->tpl_vars['summ_qty']->value;?>
</td>
                    <td class="bold text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['summ_freight']->value);?>
</td>
                </tr>
            <?php }?>
        </table>
    </div>
</div>

<h5><b>Transactions</b></h5>
<div class="overflow-x-auto">
    <table id="dt_adv_booking_report_table" class="table table-bordered " style="width:99%">
        <thead>
            <tr class="success">
                <td align="center">Booked Date</td>
                <td align="center"><?php echo lang('cargo_code_term');?>
</td>
                <td align="center">No. Of Articles</td>
                <td align="center">Type Of Packaging</td>
                <td align="center">Type Of Booking</td>
                <td align="center"><?php echo lang('booking_from_term');?>
</td>
                <td align="center" class="noprint">User</td>
                <td align="center"><?php echo lang('booking_to_label');?>
</td>
                <td align="center"><?php echo lang('booking_sender_term');?>
</td>
                <td align="center"><?php echo lang('booking_sender_term');?>
 Contact Number</td>
                <td align="center"><?php echo lang('booking_receiver_term');?>
</td>
                <td align="center"><?php echo lang('booking_receiver_term');?>
 Contact Number</td>
                <td align="center">Type Of Delivery</td>
                <td align="center">Payment Status</td>
                <td align="center">Date Of Dispatch</td>
                <td align="center">Dispatch Status</td>
                <td align="center">Cargo Status</td>
                <td align="center">Bill No / Bill Date</td>
                <td align="center">CR No / CR Date</td>
                <td align="center">Billing Status</td>
                <td align="center">Voucher No / Voucher Date</td>
                <td align="center">Total Amount</td>
                <td align="center">Freight Amount</td>
                <td align="center">GST</td>
                <td align="center"><?php echo lang('other_charges');?>
</td>
                <td align="center">Net Payable</td>
                <td align="center">Commission</td>
                <td align="center">Share</td>
                <td align="center">Received</td>
                <td align="center">Balance</td>
            </tr>

        </thead>
        <tbody class="body_table">

            <?php $_smarty_tpl->_assignInScope('tot_fare', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_seenu_total', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_handling', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_payable', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_paid', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_topay', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_items', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_commission', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_share', 0);?>

            <?php $_smarty_tpl->_assignInScope('t_service_tax', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_total_handling_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_total_unload_handling_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_pickup_handling_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_delivery_handling_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_other_tot_amount', 0);?>

            <?php if ($_REQUEST['groupBy'] == "PAYTYPE") {?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'val', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                    <tr>
                        <td align="center" colspan="25" class="bold"><?php echo $_smarty_tpl->tpl_vars['key']->value;?>
</td>
                    </tr>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['val']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code != 'CA' && $_smarty_tpl->tpl_vars['row']->value->cargo_status_code != 'CR') {?>
                            <tr>
                                <td align="left" nowrap><?php $_smarty_tpl->smarty->ext->_capture->open($_smarty_tpl, 'default', 'timestamp', null);
echo strtotime($_smarty_tpl->tpl_vars['row']->value->booked_at);
$_smarty_tpl->smarty->ext->_capture->close($_smarty_tpl);
echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['timestamp']->value,"%d %b %Y %I:%M %p");?>
</td>
                                <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['row']->value->pickup_type_code];?>
</td>
                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                                <td align="left" class="noprint"><?php echo $_smarty_tpl->tpl_vars['row']->value->user_first_name;?>
</td>
                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                                <td align="left"><?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->from_customer_mobile);?>
</td>
                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>
                                <td align="left"><?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->to_customer_mobile);?>
</td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['row']->value->delivery_type_code];?>
</td>
                                <td align="center">
                                    <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_status_code);?>

                                </td>
                                <td align="left" nowrap>
                                    <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->unloaded_at)) {?>
                                        <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->unloaded_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>

                                    <?php } else { ?>
                                        -
                                    <?php }?>
                                </td>
                                <td align="center">
                                    <?php if ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CL" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CUL" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CD") {?>
                                        Yes
                                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CB" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CUD" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CR" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CA") {?>
                                        No
                                    <?php }?>
                                </td>
                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
</td>
                                <td align="center" nowrap><?php if (isset($_smarty_tpl->tpl_vars['row']->value->invoice_number)) {
echo $_smarty_tpl->tpl_vars['row']->value->invoice_number;?>
/<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->invoice_date,"d-m-Y");?>
 <?php } else { ?>-<?php }?></td>
                                <td  align="left" nowrap><?php if (isset($_smarty_tpl->tpl_vars['row']->value->transaction_receipt_code)) {
echo $_smarty_tpl->tpl_vars['row']->value->transaction_receipt_code;?>
/<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->receipt_transaction_date,"d-m-Y");?>
 <?php } else { ?>-<?php }?></td>
                                <td  align="left" nowrap><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->payment_acknowledge_status)===null||$tmp==='' ? '-' : $tmp);?>
 </td>
                                <td  align="left" nowrap><?php if (isset($_smarty_tpl->tpl_vars['row']->value->voucher_number)) {
echo $_smarty_tpl->tpl_vars['row']->value->voucher_number;?>
/<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->voucher_transaction_date,"d-m-Y");
} else { ?>-<?php }?></td>
                                <td  align="left" nowrap> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_transaction_amount);?>
</td>
                                <td align="right">
                                    <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_amount);?>

                                </td>
                                <td align="right">
                                    <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->service_tax);?>

                                </td>
                                <td align="right" nowrap>
                                    <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->connecting_charge));?>


                                    <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                        <table>
                                            <?php if ($_smarty_tpl->tpl_vars['row']->value->other_charges_amount != 0) {?>
                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, _parse_other_charges($_smarty_tpl->tpl_vars['row']->value->other_charges), 'cv', false, 'ck');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['ck']->value => $_smarty_tpl->tpl_vars['cv']->value) {
?>
                                                    <?php if ($_smarty_tpl->tpl_vars['cv']->value == 0) {?>
                                                        <?php continue 1;?>
                                                    <?php }?>
                                                    <tr>
                                                        <td><?php echo _snakecase_to_titlecase($_smarty_tpl->tpl_vars['ck']->value);?>
</td>
                                                        <td>&ensp;:&ensp;</td>
                                                        <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['cv']->value);?>
</td>
                                                    </tr>
                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                            <?php }?>
                                            <tr>
                                                <td>Handling Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
</td>
                                            </tr>
                                            <tr>
                                                <td>GST</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->service_tax);?>
</td>
                                            </tr>
                                            <tr>
                                                <td>Unloading Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount);?>
</td>
                                            </tr>
                                            <tr>
                                                <td>Pickup Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount);?>
</td>
                                            </tr>
                                            <tr>
                                                <td>Delivery Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount);?>
</td>
                                            </tr>

                                        </table>
                                    '></i>
                                </td>
                                <td align="right" nowrap>
                                    <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->connecting_charge));?>

                                    <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                        <table>
                                            <tr>
                                                <td>Net Payable</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_amount);?>
</td>
                                            </tr>
                                            <?php if ($_smarty_tpl->tpl_vars['row']->value->other_charges_amount != 0) {?>
                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, _parse_other_charges($_smarty_tpl->tpl_vars['row']->value->other_charges), 'cv', false, 'ck');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['ck']->value => $_smarty_tpl->tpl_vars['cv']->value) {
?>
                                                        <?php if ($_smarty_tpl->tpl_vars['cv']->value == 0) {?>
                                                                <?php continue 1;?>
                                                        <?php }?>
                                                        <tr>
                                                            <td><?php echo _snakecase_to_titlecase($_smarty_tpl->tpl_vars['ck']->value);?>
</td>
                                                            <td>&ensp;:&ensp;</td>
                                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['cv']->value);?>
</td>
                                                        </tr>
                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                            <?php }?>
                                            <tr>
                                                <td>Handling Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
</td>
                                            </tr>
                                            <tr>
                                                <td>GST</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->service_tax);?>
</td>
                                            </tr>
                                            <tr>
                                                <td>Unloading Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount);?>
</td>
                                            </tr>
                                            <tr>
                                                <td>Pickup Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount);?>
</td>
                                            </tr>
                                            <tr>
                                                <td>Delivery Charges</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount);?>
</td>
                                            </tr>
                                        </table>
                                    '></i>
                                </td>

                                <td align="right"><?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->commission_amount-$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount));?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->handling_commission_amount);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
</td>
                                <td align="right">
                                    <?php $_smarty_tpl->_assignInScope('rtopay', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount)-$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                                    <?php echo inr_format($_smarty_tpl->tpl_vars['rtopay']->value);?>

                                    <?php $_smarty_tpl->_assignInScope('tot_topay', $_smarty_tpl->tpl_vars['tot_topay']->value+$_smarty_tpl->tpl_vars['rtopay']->value);?>
                                </td>
                            </tr>
                            <?php $_smarty_tpl->_assignInScope('tot_seenu_total', $_smarty_tpl->tpl_vars['tot_seenu_total']->value+$_smarty_tpl->tpl_vars['row']->value->total_transaction_amount);?>
                            <?php $_smarty_tpl->_assignInScope('tot_fare', $_smarty_tpl->tpl_vars['tot_fare']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                            <?php $_smarty_tpl->_assignInScope('tot_gst', $_smarty_tpl->tpl_vars['tot_gst']->value+$_smarty_tpl->tpl_vars['row']->value->service_tax);?>
                            <?php $_smarty_tpl->_assignInScope('tot_handling', $_smarty_tpl->tpl_vars['tot_handling']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
                            <?php $_smarty_tpl->_assignInScope('tot_payable', $_smarty_tpl->tpl_vars['tot_payable']->value+$_smarty_tpl->tpl_vars['row']->value->connecting_charge+$_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
                            <?php $_smarty_tpl->_assignInScope('tot_paid', $_smarty_tpl->tpl_vars['tot_paid']->value+$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                            <?php $_smarty_tpl->_assignInScope('tot_items', $_smarty_tpl->tpl_vars['tot_items']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                            <?php $_smarty_tpl->_assignInScope('tot_commission', $_smarty_tpl->tpl_vars['tot_commission']->value+($_smarty_tpl->tpl_vars['row']->value->commission_amount-$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount));?>
                            <?php $_smarty_tpl->_assignInScope('tot_share', $_smarty_tpl->tpl_vars['tot_share']->value+$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount);?>

                            <?php $_smarty_tpl->_assignInScope('t_service_tax', $_smarty_tpl->tpl_vars['t_service_tax']->value+$_smarty_tpl->tpl_vars['row']->value->service_tax);?>
                            <?php $_smarty_tpl->_assignInScope('t_total_handling_amount', $_smarty_tpl->tpl_vars['t_total_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
                            <?php $_smarty_tpl->_assignInScope('t_total_unload_handling_amount', $_smarty_tpl->tpl_vars['t_total_unload_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount);?>
                            <?php $_smarty_tpl->_assignInScope('t_pickup_handling_amount', $_smarty_tpl->tpl_vars['t_pickup_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount);?>
                            <?php $_smarty_tpl->_assignInScope('t_delivery_handling_amount', $_smarty_tpl->tpl_vars['t_delivery_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount);?>
                            <?php $_smarty_tpl->_assignInScope('t_other_tot_amount', $_smarty_tpl->tpl_vars['t_other_tot_amount']->value+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->connecting_charge);?>

                        <?php }?>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            <?php } else { ?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                    <?php if ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code != 'CA' && $_smarty_tpl->tpl_vars['row']->value->cargo_status_code != 'CR') {?>
                        <tr>
                            <td align="left" nowrap><?php $_smarty_tpl->smarty->ext->_capture->open($_smarty_tpl, 'default', 'timestamp', null);
echo strtotime($_smarty_tpl->tpl_vars['row']->value->booked_at);
$_smarty_tpl->smarty->ext->_capture->close($_smarty_tpl);
echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['timestamp']->value,"%d %b %Y %I:%M %p");?>
</td>
                            <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['row']->value->pickup_type_code];?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                            <td align="left" class="noprint"><?php echo $_smarty_tpl->tpl_vars['row']->value->user_first_name;?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                            <td align="left"><?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->from_customer_mobile);?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>
                            <td align="left"><?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->to_customer_mobile);?>
</td>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['row']->value->delivery_type_code];?>
</td>
                            <td align="center">
                                <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_status_code);?>

                            </td>
                            <td align="left" nowrap>
                                <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->unloaded_at)) {?>
                                    <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->unloaded_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>

                                <?php } else { ?>
                                    -
                                <?php }?>
                            </td>
                            <td align="center">
                                <?php if ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CL" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CUL" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CD") {?>
                                    Yes
                                <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CB" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CUD" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CR" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CA") {?>
                                    No
                                <?php }?>
                            </td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
</td>
                            <td align="center" nowrap><?php if (isset($_smarty_tpl->tpl_vars['row']->value->invoice_number)) {
echo $_smarty_tpl->tpl_vars['row']->value->invoice_number;?>
/<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->invoice_date,"d-m-Y");?>
 <?php } else { ?>-<?php }?></td>
                            <td  align="left" nowrap><?php if (isset($_smarty_tpl->tpl_vars['row']->value->transaction_receipt_code)) {
echo $_smarty_tpl->tpl_vars['row']->value->transaction_receipt_code;?>
/<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->receipt_transaction_date,"d-m-Y");?>
 <?php } else { ?>-<?php }?></td>
                            <td  align="left" nowrap><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->payment_acknowledge_status)===null||$tmp==='' ? '-' : $tmp);?>
 </td>
                            <td  align="left" nowrap><?php if (isset($_smarty_tpl->tpl_vars['row']->value->voucher_number)) {
echo $_smarty_tpl->tpl_vars['row']->value->voucher_number;?>
/<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->voucher_transaction_date,"d-m-Y");
} else { ?>-<?php }?></td>
                            <td  align="left" nowrap> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_transaction_amount);?>
</td>
                            <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_amount);?>
</td>
                            <td align="right">
                                <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->service_tax);?>

                            </td>
                            <td align="right" nowrap>
                                <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->connecting_charge));?>


                                <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                    <table>
                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->other_charges_amount != 0) {?>
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, _parse_other_charges($_smarty_tpl->tpl_vars['row']->value->other_charges), 'cv', false, 'ck');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['ck']->value => $_smarty_tpl->tpl_vars['cv']->value) {
?>
                                                    <?php if ($_smarty_tpl->tpl_vars['cv']->value == 0) {?>
                                                            <?php continue 1;?>
                                                    <?php }?>
                                                    <tr>
                                                        <td><?php echo _snakecase_to_titlecase($_smarty_tpl->tpl_vars['ck']->value);?>
</td>
                                                        <td>&ensp;:&ensp;</td>
                                                        <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['cv']->value);?>
</td>
                                                    </tr>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                        <?php }?>
                                        <tr>
                                            <td>Handling Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
</td>
                                        </tr>
                                        <tr>
                                            <td>GST</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->service_tax);?>
</td>
                                        </tr>
                                        <tr>
                                            <td>Unloading Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount);?>
</td>
                                        </tr>
                                        <tr>
                                            <td>Pickup Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount);?>
</td>
                                        </tr>
                                        <tr>
                                            <td>Delivery Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount);?>
</td>
                                        </tr>
                                    </table>
                                '></i>
                            </td>
                            <td align="right" nowrap>
                                <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->connecting_charge));?>

                                <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                    <table>
                                        <tr>
                                            <td>Net Payable</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_amount);?>
</td>
                                        </tr>
                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->other_charges_amount != 0) {?>
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, _parse_other_charges($_smarty_tpl->tpl_vars['row']->value->other_charges), 'cv', false, 'ck');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['ck']->value => $_smarty_tpl->tpl_vars['cv']->value) {
?>
                                                    <?php if ($_smarty_tpl->tpl_vars['cv']->value == 0) {?>
                                                            <?php continue 1;?>
                                                    <?php }?>
                                                    <tr>
                                                        <td><?php echo _snakecase_to_titlecase($_smarty_tpl->tpl_vars['ck']->value);?>
</td>
                                                        <td>&ensp;:&ensp;</td>
                                                        <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['cv']->value);?>
</td>
                                                    </tr>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                        <?php }?>
                                        <tr>
                                            <td>Handling Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
</td>
                                        </tr>
                                        <tr>
                                            <td>GST</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->service_tax);?>
</td>
                                        </tr>
                                        <tr>
                                            <td>Unloading Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount);?>
</td>
                                        </tr>
                                        <tr>
                                            <td>Pickup Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount);?>
</td>
                                        </tr>
                                        <tr>
                                            <td>Delivery Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount);?>
</td>
                                        </tr>
                                    </table>
                                '></i>
                            </td>
                            <td align="right"><?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->commission_amount-$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount));?>
</td>
                            <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->handling_commission_amount);?>
</td>
                            <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
</td>
                            <td align="right">
                                <?php $_smarty_tpl->_assignInScope('rtopay', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount)-$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                                <?php echo inr_format($_smarty_tpl->tpl_vars['rtopay']->value);?>

                                <?php $_smarty_tpl->_assignInScope('tot_topay', $_smarty_tpl->tpl_vars['tot_topay']->value+$_smarty_tpl->tpl_vars['rtopay']->value);?>
                            </td>
                        </tr>
                        <?php $_smarty_tpl->_assignInScope('tot_seenu_total', $_smarty_tpl->tpl_vars['tot_seenu_total']->value+$_smarty_tpl->tpl_vars['row']->value->total_transaction_amount);?>
                        <?php $_smarty_tpl->_assignInScope('tot_fare', $_smarty_tpl->tpl_vars['tot_fare']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                        <?php $_smarty_tpl->_assignInScope('tot_gst', $_smarty_tpl->tpl_vars['tot_gst']->value+$_smarty_tpl->tpl_vars['row']->value->service_tax);?>
                        <?php $_smarty_tpl->_assignInScope('tot_handling', $_smarty_tpl->tpl_vars['tot_handling']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
                        <?php $_smarty_tpl->_assignInScope('tot_payable', $_smarty_tpl->tpl_vars['tot_payable']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->connecting_charge);?>
                        <?php $_smarty_tpl->_assignInScope('tot_paid', $_smarty_tpl->tpl_vars['tot_paid']->value+$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                        <?php $_smarty_tpl->_assignInScope('tot_items', $_smarty_tpl->tpl_vars['tot_items']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                        <?php $_smarty_tpl->_assignInScope('tot_unit', $_smarty_tpl->tpl_vars['tot_unit']->value+$_smarty_tpl->tpl_vars['row']->value->total_unit_value);?>
                        <?php $_smarty_tpl->_assignInScope('tot_commission', $_smarty_tpl->tpl_vars['tot_commission']->value+($_smarty_tpl->tpl_vars['row']->value->commission_amount-$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount));?>
                        <?php $_smarty_tpl->_assignInScope('tot_share', $_smarty_tpl->tpl_vars['tot_share']->value+$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount);?>

                        <?php $_smarty_tpl->_assignInScope('t_service_tax', $_smarty_tpl->tpl_vars['t_service_tax']->value+$_smarty_tpl->tpl_vars['row']->value->service_tax);?>
                        <?php $_smarty_tpl->_assignInScope('t_total_handling_amount', $_smarty_tpl->tpl_vars['t_total_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
                        <?php $_smarty_tpl->_assignInScope('t_total_unload_handling_amount', $_smarty_tpl->tpl_vars['t_total_unload_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount);?>
                        <?php $_smarty_tpl->_assignInScope('t_pickup_handling_amount', $_smarty_tpl->tpl_vars['t_pickup_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount);?>
                        <?php $_smarty_tpl->_assignInScope('t_delivery_handling_amount', $_smarty_tpl->tpl_vars['t_delivery_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount);?>
                        <?php $_smarty_tpl->_assignInScope('t_other_tot_amount', $_smarty_tpl->tpl_vars['t_other_tot_amount']->value+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->connecting_charge);?>

                    <?php }?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            <?php }?>

            <tr class="active">
                <td align="center"></td>
                <td align="left"></td>
                <td align="center"><?php echo $_smarty_tpl->tpl_vars['tot_items']->value;?>
</td>
                <td align="left" class="noprint"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="right" class="bold">Total</td>
            <td align="center" class="bold"> <?php echo inr_format($_smarty_tpl->tpl_vars['tot_seenu_total']->value);?>
</td>
                <td align="center" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_fare']->value);?>
</td>
                <td align="center" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_gst']->value);?>
</td>
                <td align='right' class="bold" nowrap><?php echo inr_format($_smarty_tpl->tpl_vars['t_other_tot_amount']->value);?>
 <i class="fa fa-info-circle invisible"></i></td>
                <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_payable']->value);?>
</td>
                <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_commission']->value);?>
</td>
                <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_share']->value);?>
</td>
                <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_paid']->value);?>
</td>
                <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_topay']->value);?>
</td>
            </tr>

        </tbody>
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoBookingExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <?php if ($_REQUEST['groupBy'] == "PAYTYPE") {?>
            <button class="btn btn-default" onclick="bkgPrintPaid();"><i class="fa fa-print fa-lg"></i> Print Paid</button>
            <button class="btn btn-default" onclick="bkgPrintToPaid();"><i class="fa fa-print fa-lg"></i> Print
                Topay</button>
        <?php } else { ?>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        <?php }?>
    </div>
</div>

<?php echo '<script'; ?>
>
	var namespaceCode = <?php echo json_encode($_smarty_tpl->tpl_vars['namespaceCode']->value);?>
;
    var summary = <?php echo json_encode($_smarty_tpl->tpl_vars['result']->value);?>
;
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
<?php echo '</script'; ?>
>
<?php }
}
