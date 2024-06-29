<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-11 18:39:50
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ogpl-chart-print.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66684c9ebe7145_74391779',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '807cc4f1358240f8b6a5363ac2bdc3855e42e259' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ogpl-chart-print.tpl',
      1 => 1718111386,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66684c9ebe7145_74391779 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<html>

<head>
    <title>OGPL Chart</title>
    <base href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
">
    <link href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/css/print.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet">
    <style>
        .lr {
            font-size: 12pt;
            font-weight: bold;
            letter-spacing: 1.5px;
        }

        .payment-status {
            font-size: 11pt;
            font-weight: bold;
            letter-spacing: 1.5px;
        }
    </style>
</head>

<body>
    <?php $_smarty_tpl->_assignInScope('t_inv', 0);?>
    <?php $_smarty_tpl->_assignInScope('t_ew', 0);?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row1', false, 't1');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t1']->value => $_smarty_tpl->tpl_vars['row1']->value) {
?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row1']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->eway_bill_no)) {?>
                    <?php $_smarty_tpl->_assignInScope('t_ew', $_smarty_tpl->tpl_vars['t_ew']->value+1);?>
                <?php }?>
                <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->invoice_number)) {?>
                    <?php $_smarty_tpl->_assignInScope('t_inv', $_smarty_tpl->tpl_vars['t_inv']->value+1);?>
                <?php }?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    <table cellpadding="5" width="100%">
        <?php if ($_smarty_tpl->tpl_vars['is_header_available']->value) {?>
            <tr>
                <td width="100%" colspan="2" align="center">
                    <img src="assets/img/clientlogo/<?php echo $_smarty_tpl->tpl_vars['namespace']->value;?>
.jpg" alt="logo" width="100%"><br>
                </td>
            </tr>
        <?php } else { ?>
            <tr>
                <td width="100%" colspan="2" align="center" style="font-weight:bold; font-size: 20px;">
                    <?php echo $_smarty_tpl->tpl_vars['namespace_name']->value;?>

                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'newlinetrans') {?>
                        <br><span style="font-weight:500; font-size: 15px;">Survey No 333/3 Kataria estate near St.joseph school
                            <br>Vapi karvad road Vapi-396191
                            <br>Mobile No: 8155052015,9328022015,9375281007</span><br><br>
                    <?php } elseif (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>
                        <br><span style="font-weight:500; font-size: 15px;"><?php echo $_smarty_tpl->tpl_vars['userBranchData']->value['address1'];?>

                            <br><?php echo $_smarty_tpl->tpl_vars['userBranchData']->value['address2'];?>
</span><br><br>
                    <?php }?>
                </td>
            </tr>
        <?php }?>

        <tr>
            <td width="100%" colspan="2"><b><?php echo lang('ogpl');?>
 Number:</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->aliasCode;?>
</td>
        </tr>
        <tr>
            <td width="60%"><b>Trip Date:</b> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['ogpl']->value->tripDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
            <td width="40%"><b>Vehicle :</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->busVehicle->registationNumber;?>
</td>
        </tr>
        <tr>
            <td width="60%"><b>Route:</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->fromOrganization->name;?>
 to <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->toOrganization->name;?>
</td>
            <td width="40%"><b>Driver :</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->vehicleDriver->name;?>
, <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->vehicleDriver->mobileNumber;?>
</td>
        </tr>
        <?php if ($_smarty_tpl->tpl_vars['ogpl']->value->remarks) {?>
            <tr>
                <td width="60%" colspan="2"><b>Remarks:</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->remarks;?>
</td>
            </tr>
        <?php }?>
        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'arthitrans') {?>
            <tr>
                <td width="60%" colspan="2"><b>Invoice Count :</b> <?php echo $_smarty_tpl->tpl_vars['t_inv']->value;?>
 ,&nbsp;&nbsp;<b>Eway Bill Count :</b> <?php echo $_smarty_tpl->tpl_vars['t_ew']->value;?>
</td>
            </tr>
        <?php }?>
    </table>
    <br />
    <table class="bordered" cellpadding="3" width="96%">
        <thead>
            <tr class="info bold">
                <td align="center" rowspan="2">S.No</td>
                <td align="center" rowspan="2"><?php echo lang('lr');?>
</td>
                <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'arthitrans') {?>
                    <td align="center" rowspan="2" nowrap>Article</td>
                <?php }?>
                <td align="center" rowspan="2" nowrap>Qty<?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'dishashree') {?> / Kg<?php }?></td>
                <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>
                    <td align="center" rowspan="2">Kg</td>
                    <td align="center" rowspan="2">Act Kg</td>
                <?php }?>
                <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("ktwoklogistics"))) {?>
                    <td align="center" rowspan="2">Private Mark No</td>
                <?php }?>
                <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("knttransports","kntlogistics","vikascargo","vikasecotrans"))) {?>
                    <td align="center" rowspan="2" width="50">Description</td>
                <?php }?>
                <?php if (!in_array($_smarty_tpl->tpl_vars['namespace']->value,array("vikascargo","vikasecotrans","ktwoklogistics"))) {?>
                    <td align="center" rowspan="2">Booked At</td>
                                        <td align="center" rowspan="2">Delivery At</td>
                <?php }?>
                <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>
                    <td align="center" rowspan="2">E-way Bill No</td>
                <?php }?>
                <td align="center" rowspan="2"><?php echo lang('booking_sender_term');?>
 Name</td>
                <?php if ($_smarty_tpl->tpl_vars['namespace']->value != 'newlinetrans') {?>
                    <td align="center" rowspan="2"><?php echo lang('booking_sender_term');?>
 Mobile</td>
                <?php }?>
                <td align="center" rowspan="2"><?php echo lang('booking_receiver_term');?>
 Name</td>
                <?php if ($_smarty_tpl->tpl_vars['namespace']->value != 'newlinetrans') {?>
                    <td align="center" rowspan="2"><?php echo lang('booking_receiver_term');?>
 Mobile</td>
                <?php }?>
                                <td align="center" rowspan="2">Payment Status</td>
                <td align="center" colspan="<?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("knttransports","kntlogistics"))) {?>2<?php } else { ?>4<?php }?>">Amount</td>
            </tr>
            <tr class="info bold">
                <?php if (!in_array($_smarty_tpl->tpl_vars['namespace']->value,array("knttransports","kntlogistics"))) {?>
                    <td align="center">Freight</td>
                    <?php if (!in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>
                        <td align="center"><?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'srimaharaja') {?>Door Delivery Charges<?php } else {
echo lang('other_charges');
}?></td>
                    <?php }?>
                    <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>
                        <td align="center">Connecting Charges</td>
                    <?php }?>
                <?php }?>
                <td align="center">Paid</td>
                <td align="center">To Pay</td>
            </tr>
        </thead>
        <tbody class="body_table">
            <?php $_smarty_tpl->_assignInScope('o_qty', 0);?>
            <?php $_smarty_tpl->_assignInScope('o_kg', 0);?>
            <?php $_smarty_tpl->_assignInScope('ac_kg', 0);?>
            <?php $_smarty_tpl->_assignInScope('sno', 1);?>

            <?php $_smarty_tpl->_assignInScope('o_freight_tot_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('o_handling_tot_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('o_other_tot_amount', 0);?>

            <?php $_smarty_tpl->_assignInScope('o_pd_tot_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('o_pb_tot_amount', 0);?>

            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row1', false, 't1');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t1']->value => $_smarty_tpl->tpl_vars['row1']->value) {
?>
                <tr>
                    <td align="center" colspan="<?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("vikascargo","vikasecotrans","knttransports","kntlogistics"))) {?>13<?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == 'newlinetrans') {?>12<?php } elseif (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>15<?php } else { ?>14<?php }?>"><b><?php echo $_smarty_tpl->tpl_vars['routes']->value[$_smarty_tpl->tpl_vars['t1']->value];?>
</b></td>
                </tr>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row1']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>

                    <?php $_smarty_tpl->_assignInScope('o_qty', $_smarty_tpl->tpl_vars['o_qty']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                    <?php $_smarty_tpl->_assignInScope('o_kg', $_smarty_tpl->tpl_vars['o_kg']->value+$_smarty_tpl->tpl_vars['row']->value->total_unit_value);?>
                    <?php $_smarty_tpl->_assignInScope('ac_kg', $_smarty_tpl->tpl_vars['ac_kg']->value+$_smarty_tpl->tpl_vars['row']->value->total_actual_unit_value);?>
                    <tr>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['sno']->value;?>
</td>
                        <td align="center" class="lr"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>

                            <br>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->eway_bill_no)) {?>
                              
                                <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/img/icons/eway.svg" width="30px" loading="lazy">
                            <?php }?>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->invoice_number)) {?>
                                <?php $_smarty_tpl->_assignInScope('t_inv', $_smarty_tpl->tpl_vars['t_inv']->value+1);?>
                                <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/img/icons/invoice.svg" width="30px" loading="lazy">
                            <?php }?>
                        </td>
                        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'arthitrans') {?>
                            <td align="center"> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->cargo_item_name)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                        <?php }?>   
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;
if ($_smarty_tpl->tpl_vars['namespace']->value == 'dishashree') {?> / <?php echo $_smarty_tpl->tpl_vars['row']->value->total_unit_value;
}?></td>
                        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>
                            <td align="center"> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->total_unit_value)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                            <td align="center"> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->total_actual_unit_value)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                        <?php }?>
                        <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("ktwoklogistics"))) {?>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->private_mark_number;?>
</td>
                        <?php }?>
                        <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("knttransports","kntlogistics","vikascargo","vikasecotrans"))) {?>
                            <td align="center" width="50"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_description;?>
</td>
                        <?php }?>
                                                <?php if (!in_array($_smarty_tpl->tpl_vars['namespace']->value,array("vikascargo","vikasecotrans","ktwoklogistics"))) {?>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                        <?php }?>
                        <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->eway_bill_no;?>
</td>
                        <?php }?>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                        <?php if ($_smarty_tpl->tpl_vars['namespace']->value != 'newlinetrans') {?>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_mobile;?>
</td>
                        <?php }?>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>

                        <?php if ($_smarty_tpl->tpl_vars['namespace']->value != 'newlinetrans') {?>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_mobile;?>
</td>
                        <?php }?>
                                                <td align="center" <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'tippusultan') {?>class="payment-status" <?php }?>><?php echo strtoupper($_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->payment_status_code]);?>
</td>

                        <?php if (!in_array($_smarty_tpl->tpl_vars['namespace']->value,array("knttransports","kntlogistics"))) {?>
                            <td align="right">
                                <?php echo number_format(($_smarty_tpl->tpl_vars['row']->value->total_amount),2);?>

                                <?php $_smarty_tpl->_assignInScope('o_freight_tot_amount', $_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['o_freight_tot_amount']->value);?>
                            </td>
                            <?php if (!in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>
                                <td align="right">
                                    <?php echo number_format($_smarty_tpl->tpl_vars['row']->value->other_charges_amount,2);?>

                                    <?php $_smarty_tpl->_assignInScope('o_other_tot_amount', $_smarty_tpl->tpl_vars['o_other_tot_amount']->value+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
                                </td>
                            <?php }?>
                        <?php }?>
                        <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>
                            <td align="right">
                                <?php echo number_format(($_smarty_tpl->tpl_vars['row']->value->connecting_charge),2);?>

                                <?php $_smarty_tpl->_assignInScope('o_connecting_tot_amount', $_smarty_tpl->tpl_vars['row']->value->connecting_charge+$_smarty_tpl->tpl_vars['o_connecting_tot_amount']->value);?>
                            </td>
                        <?php }?>
                        <td align="right">
                            <?php $_smarty_tpl->_assignInScope('paid', 0);?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'PAD') {?>
                                <?php $_smarty_tpl->_assignInScope('paid', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount));?>
                                <?php echo number_format($_smarty_tpl->tpl_vars['paid']->value,2);?>

                                <?php $_smarty_tpl->_assignInScope('o_pd_tot_amount', $_smarty_tpl->tpl_vars['paid']->value+$_smarty_tpl->tpl_vars['o_pd_tot_amount']->value);?>
                            <?php } else { ?>
                                0.00
                            <?php }?>
                        </td>
                        <td align="right">
                            <?php $_smarty_tpl->_assignInScope('topay', 0);?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'TOP' || $_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'TPPAD') {?>
                                <?php $_smarty_tpl->_assignInScope('topay', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount));?>
                                <?php echo number_format($_smarty_tpl->tpl_vars['topay']->value,2);?>

                                <?php $_smarty_tpl->_assignInScope('o_pb_tot_amount', $_smarty_tpl->tpl_vars['topay']->value+$_smarty_tpl->tpl_vars['o_pb_tot_amount']->value);?>
                            <?php } else { ?>
                                0.00
                            <?php }?>
                        </td>
                    </tr>
                    <?php $_smarty_tpl->_assignInScope('sno', $_smarty_tpl->tpl_vars['sno']->value+1);?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <tr>
                    <td align="center"></td>
                    <td align="center"></td>
                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'arthitrans') {?> <td align="center"></td><?php }?>
                    <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['o_qty']->value;
if ($_smarty_tpl->tpl_vars['namespace']->value == 'dishashree') {?> / <?php echo $_smarty_tpl->tpl_vars['o_kg']->value;
}?></td>
                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>
                        <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['o_kg']->value;?>
</td>
                        <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['ac_kg']->value;?>
</td>
                    <?php }?>
                    <td colspan="<?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("vikascargo","vikasecotrans"))) {?>6<?php } elseif (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("knttransports","kntlogistics"))) {?>8<?php } elseif (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("newlinetrans"))) {?>5<?php } elseif (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>8<?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>6<?php } else { ?>7<?php }?>">&nbsp;</td>
                    <?php if (!in_array($_smarty_tpl->tpl_vars['namespace']->value,array("knttransports","kntlogistics"))) {?>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['o_freight_tot_amount']->value,2);?>
</td>
                        <?php if (!in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>
                            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['o_other_tot_amount']->value,2);?>
</td>
                        <?php }?>
                    <?php }?>
                    <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['o_connecting_tot_amount']->value,2);?>
</td>
                    <?php }?>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['o_pd_tot_amount']->value,2);?>
</td>
                    <td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['o_pb_tot_amount']->value,2);?>
</td>
                </tr>
            <?php
}
} else {
?>
                <tr>
                    <td align="center" colspan="<?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("vikascargo","vikasecotrans","knttransports","kntlogistics"))) {?>13<?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == 'newlinetrans') {?>12<?php } elseif (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>15<?php } else { ?>14<?php }?>">Sorry! No cargo found</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
    </table>
    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'newlinetrans') {?>
        <br />
        <b>Payments</b>
        <div class="table-responsive">
            <table class="table table-bordered" cellpadding="3" width="96%">
                <thead class="sticky-row-top">
                    <tr class="info bold">
                        <td>Category</td>
                        <td>Type </td>
                        <td>Payment Mode </td>
                        <td>Amount </td>
                    </tr>
                </thead>
                <tbody class="body_table">
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, array_reverse($_smarty_tpl->tpl_vars['expensesData']->value), 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->cashbookType->code == 'HIRING' || $_smarty_tpl->tpl_vars['row']->value->cashbookType->code == 'ADVANCE') {?>
                            <tr>
                                <td align="left">
                                    <?php if ($_smarty_tpl->tpl_vars['row']->value->cashbookType->transactionType == 'Cr') {?>
                                        Income
                                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cashbookType->transactionType == 'Dr') {?>
                                        Expense
                                    <?php } else { ?>
                                        -
                                    <?php }?>
                                </td>
                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->cashbookType->name;?>
</td>
                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->transactionMode->name;?>
</td>
                                <td align="left"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->amount)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                            </tr>
                        <?php }?>
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
                </tbody>
            </table>
        </div>
        <br>
        <div class="table-responsive">
            <table class="table table-bordered" cellpadding="3" width="96%">
                <thead class="sticky-row-top">
                    <tr class="info bold">
                        <td>Category</td>
                        <td>Income / Expense Type </td>
                        <td>Payment Mode </td>
                                                <td>Inc. Amount </td>
                        <td>Exp. Amount</td>
                                                                    </tr>
                </thead>
                <tbody class="body_table">
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['expensesData']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->cashbookType->code != 'HIRING' && $_smarty_tpl->tpl_vars['row']->value->cashbookType->code != 'ADVANCE') {?>
                            <tr>
                                <td align="left">
                                    <?php if ($_smarty_tpl->tpl_vars['row']->value->cashbookType->transactionType == 'Cr') {?>
                                        Income
                                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cashbookType->transactionType == 'Dr') {?>
                                        Expense
                                    <?php }?>
                                </td>
                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->cashbookType->name;?>
</td>
                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->transactionMode->name;?>
</td>
                                                                <td align="left"><?php if ($_smarty_tpl->tpl_vars['row']->value->cashbookType->transactionType == 'Cr') {
echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->amount)===null||$tmp==='' ? '-' : $tmp);
} else { ?>-<?php }?></td>
                                <td align="left"><?php if ($_smarty_tpl->tpl_vars['row']->value->cashbookType->transactionType == 'Dr') {
echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->amount)===null||$tmp==='' ? '-' : $tmp);
} else { ?>-<?php }?></td>
                                                                                            </tr>
                        <?php }?>
                    <?php
}
} else {
?>
                        <tr>
                            <td colspan="6" align="center">No Records Found!</td>
                        </tr>
                    <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                </tbody>
            </table>
        </div>
    <?php }?>
    <br />
    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['OGPL-PAY-SUMRY'] == 1 && $_smarty_tpl->tpl_vars['namespace']->value != 'srimaharaja') {?>
        <table width='96%'>
            <tr>
                <td><span class="bold"><b>Summary</b></span></td>
            </tr>
        </table>
        <table width='96%' class="bordered" cellpadding="3">
            <thead>
                <tr class="success">
                    <td align="center"><?php echo lang('lr');?>
 Type</td>
                    <td align="center">No.of <?php echo lang('lr');?>
s</td>
                    <td align="center">No.of <?php echo lang('booking_article_label');?>
</td>
                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "ktwoklogistics") {?>
                        <td align="center" rowspan="2">Kg</td>
                        <td align="center">Act Kg</td>
                    <?php }?>
                    <td align="center">Freight</td>
                    <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>
                        <td align="center">Connecting Charges</td>
                    <?php }?>
                    <td align="center">Loading Charges</td>
                    <td align="center">Unloading Charges</td>
                    <td align="center">Delivery Charges</td>
                    <td align="center">Service Tax</td>
                    <td align="center">Total</td>
                </tr>
                <?php $_smarty_tpl->_assignInScope('total', 0);?>
                <?php $_smarty_tpl->_assignInScope('total_lr', 0);?>
                <?php $_smarty_tpl->_assignInScope('total_pkgs', 0);?>
                <?php $_smarty_tpl->_assignInScope('total_frieght', 0);?>
                <?php $_smarty_tpl->_assignInScope('total_loading', 0);?>
                <?php $_smarty_tpl->_assignInScope('total_unloading', 0);?>
                <?php $_smarty_tpl->_assignInScope('total_delivery', 0);?>
                <?php $_smarty_tpl->_assignInScope('total_service_tax', 0);?>
                <?php $_smarty_tpl->_assignInScope('total_connecting', 0);?>
                <?php $_smarty_tpl->_assignInScope('net_total', 0);?>
                <?php $_smarty_tpl->_assignInScope('ac_kg_total', 0);?>
                <?php $_smarty_tpl->_assignInScope('kg_total', 0);?>

            <tbody class="body_table">
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'route', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['route']->value) {
?>
                    <tr>
                        <td align="center" colspan="<?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>10<?php } else { ?>9<?php }?>"><b><?php echo $_smarty_tpl->tpl_vars['routes']->value[$_smarty_tpl->tpl_vars['key']->value];?>
</b></td>
                    </tr>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['route']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <tr>
                            <?php $_smarty_tpl->_assignInScope('total', $_smarty_tpl->tpl_vars['row']->value['freight']+$_smarty_tpl->tpl_vars['row']->value['loading']+$_smarty_tpl->tpl_vars['row']->value['unloading']+$_smarty_tpl->tpl_vars['row']->value['service_tax']+$_smarty_tpl->tpl_vars['row']->value['delivery']+$_smarty_tpl->tpl_vars['row']->value['connecting']);?>
                            <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['k']->value];?>
</b></td>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['lr'];?>
</td>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['packages'];?>
</td>
                            <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['kg_amt'];?>
</td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['ac_kg'];?>
</td>
                            <?php }?>
                            <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['freight'],2);?>
</td>
                            <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>
                                <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['connecting'],2);?>
</td>
                            <?php }?>
                            <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['loading'],2);?>
</td>
                            <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['unloading'],2);?>
</td>
                            <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['delivery'],2);?>
</td>
                            <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['service_tax'],2);?>
</td>
                            <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['total']->value,2);?>
</td>
                        </tr>

                        <?php $_smarty_tpl->_assignInScope('total_lr', $_smarty_tpl->tpl_vars['total_lr']->value+$_smarty_tpl->tpl_vars['row']->value['lr']);?>
                        <?php $_smarty_tpl->_assignInScope('total_pkgs', $_smarty_tpl->tpl_vars['total_pkgs']->value+$_smarty_tpl->tpl_vars['row']->value['packages']);?>
                        <?php $_smarty_tpl->_assignInScope('total_frieght', $_smarty_tpl->tpl_vars['total_frieght']->value+$_smarty_tpl->tpl_vars['row']->value['freight']);?>
                        <?php $_smarty_tpl->_assignInScope('total_loading', $_smarty_tpl->tpl_vars['total_loading']->value+$_smarty_tpl->tpl_vars['row']->value['loading']);?>
                        <?php $_smarty_tpl->_assignInScope('total_unloading', $_smarty_tpl->tpl_vars['total_unloading']->value+$_smarty_tpl->tpl_vars['row']->value['unloading']);?>
                        <?php $_smarty_tpl->_assignInScope('total_delivery', $_smarty_tpl->tpl_vars['total_delivery']->value+$_smarty_tpl->tpl_vars['row']->value['delivery']);?>
                        <?php $_smarty_tpl->_assignInScope('total_service_tax', $_smarty_tpl->tpl_vars['total_service_tax']->value+$_smarty_tpl->tpl_vars['row']->value['service_tax']);?>
                        <?php $_smarty_tpl->_assignInScope('total_connecting', $_smarty_tpl->tpl_vars['total_connecting']->value+$_smarty_tpl->tpl_vars['row']->value['connecting']);?>
                        <?php $_smarty_tpl->_assignInScope('net_total', $_smarty_tpl->tpl_vars['net_total']->value+$_smarty_tpl->tpl_vars['total']->value);?>
                        <?php $_smarty_tpl->_assignInScope('ac_kg_total', $_smarty_tpl->tpl_vars['ac_kg_total']->value+$_smarty_tpl->tpl_vars['row']->value['ac_kg']);?>
                        <?php $_smarty_tpl->_assignInScope('kg_total', $_smarty_tpl->tpl_vars['kg_total']->value+$_smarty_tpl->tpl_vars['row']->value['kg_amt']);?>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <tr>
                    <td align="center"><b>Total</b></td>
                    <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['total_lr']->value;?>
</b></td>
                    <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['total_pkgs']->value;?>
</b></td>
                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>
                        <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['kg_total']->value;?>
</b></td>
                        <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['ac_kg_total']->value;?>
</b></td>
                    <?php }?>
                    <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_frieght']->value,2);?>
</b></td>
                    <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("citycargo","cityparcel"))) {?>
                        <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_connecting']->value,2);?>
</b></td>
                    <?php }?>
                    <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_loading']->value,2);?>
</b></td>
                    <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_unloading']->value,2);?>
</b></td>
                    <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_delivery']->value,2);?>
</b></td>
                    <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_service_tax']->value,2);?>
</b></td>
                    <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['net_total']->value,2);?>
</b></td>
                </tr>
            </tbody>

            </thead>
        </table>
    <?php }?>

    <div class="background-image"></div>
</body>
<style>
    body {
        width: unset;
    }

    table {
        border-collapse: collapse;
    }

    table thead th,
    table thead td {
        font-weight: bold;
    }

    table.bordered th,
    table.bordered td {
        border: 1px solid #000;
    }

    <?php if ($_smarty_tpl->tpl_vars['bgimg']->value) {?>
        .background-image {
            position: absolute;
            background-image: url(<?php echo $_smarty_tpl->tpl_vars['bgimg']->value;?>
) !important;
            background-repeat: repeat-y !important;
            background-position: center !important;
            height: 950px;
            width: 100%;
            top: 0;
            left: 0;
            z-index: -1;
        }
    <?php }?>


</style>

<style type="text/css" media="print">
    @media print {
        body {
            -webkit-print-color-adjust: exact !important;
            /* Chrome, Safari */
            color-adjust: exact !important;
            /*Firefox*/
        }
    }

    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "arthitrans") {?>
        @page {
            size: A4 landscape;
        }
    <?php } else { ?>
        @page {
        size: A4 portrait;
    }
    <?php }?>
</style>

</html>
<?php }
}
