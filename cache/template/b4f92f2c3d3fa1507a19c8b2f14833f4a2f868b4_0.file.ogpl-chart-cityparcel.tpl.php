<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-05 16:26:30
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ogpl-chart-cityparcel.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6660445e7ede63_96000287',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'b4f92f2c3d3fa1507a19c8b2f14833f4a2f868b4' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ogpl-chart-cityparcel.tpl',
      1 => 1717584982,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6660445e7ede63_96000287 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="brand_top">
    <h3><?php echo lang('OGPL');?>
 Trip Chart</h3>
    <span class="align-right">
        <a href="#cargo/ogpl?fill=1" class="btn btn-success  btn-sm"> <i class="fa fa-arrow-left"></i> Back</a>
    </span>
</div>

<div id="main-content">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div class="clear_fix_both"></div>
                <br />
                <div id="contents" class="col-lg-12">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <table width="100%">
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
                                    <?php if (count($_smarty_tpl->tpl_vars['ogpl']->value->transitReference)) {?>
                                        <tr>
                                            <td width="60%" colspan="2">
                                                <b>Related Transit(s):</b>
                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ogpl']->value->transitReference, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                    <?php if ($_smarty_tpl->tpl_vars['row']->value->cargoActivityType->code == 'TRNT') {?>
                                                        <a href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" title="Related OGPL" target="_blank"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
 (<?php echo $_smarty_tpl->tpl_vars['row']->value->aliasCode;?>
)</a><br>
                                                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cargoActivityType->code == 'INTRNT') {?>
                                                        <a href="#cargo/local-transit-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" title="Related Local Transit" target="_blank"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
 (<?php echo $_smarty_tpl->tpl_vars['row']->value->aliasCode;?>
)</a><br>
                                                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cargoActivityType->code == 'OTFD') {?>
                                                        <a href="#cargo/out-for-delivery-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" title="Related Door pickup & Door Delivery" target="_blank"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
 (<?php echo $_smarty_tpl->tpl_vars['row']->value->aliasCode;?>
)</a><br>
                                                    <?php }?>
                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                            </td>
                                        </tr>
                                    <?php }?>
                                    <?php if ($_smarty_tpl->tpl_vars['ogpl']->value->remarks) {?>
                                        <tr>
                                            <td width="60%" colspan="2"><b>Remarks:</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->remarks;?>
</td>
                                        </tr>
                                    <?php }?>
                                </table>
                                <br>
                              
                                <table id="dt_adv_booking_report_table" class="table table-bordered">
                                <thead>
                                    <tr class="info bold">
                                        <td align="center" rowspan="2">S.No</td>
                                        <td align="center" rowspan="2"><?php echo lang('lr');?>
</td>
                                        <td align="center" rowspan="2">Qty</td>
                                        <td align="center" rowspan="2">Booked Date</td>
                                        <td align="center" rowspan="2">Booked At</td>
                                        <td align="center" rowspan="2">Delivery At</td>
                                        <td align="center" rowspan="2">E-way Bill No</td>
                                        <td align="center" rowspan="2"><?php echo lang('booking_sender_term');?>
 Name</td>
                                        <td align="center" rowspan="2"><?php echo lang('booking_sender_term');?>
 Mobile</td>
                                        <td align="center" rowspan="2"><?php echo lang('booking_receiver_term');?>
 Name</td>
                                        <td align="center" rowspan="2"><?php echo lang('booking_receiver_term');?>
 Mobile</td>
                                        <td align="center" rowspan="2">Booked By</td>
                                        <td align="center" rowspan="2">Payment Status</td>
                                        <td align="center" colspan="4">Amount</td>
                                    </tr>
                                    <tr class="info bold">
                                        <td align="center">Freight</td>
                                        <td align="center">Connecting Charges</td>
                                        <td align="center">Paid</td>
                                        <td nowrap align="center">To Pay</td>
                                    </tr>
                                </thead>
                                <tbody class="body_table">
                                    <?php $_smarty_tpl->_assignInScope('total_qty', 0);?>
                                    <?php $_smarty_tpl->_assignInScope('sno', 1);?>
                            
                                    <?php $_smarty_tpl->_assignInScope('total_freight_amount', 0);?>
                                    <?php $_smarty_tpl->_assignInScope('total_connecting_charges_amount', 0);?>
                                    <?php $_smarty_tpl->_assignInScope('total_paid_amount', 0);?>
                                    <?php $_smarty_tpl->_assignInScope('total_to_pay_amount', 0);?>
                            
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row1', false, 't1');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t1']->value => $_smarty_tpl->tpl_vars['row1']->value) {
?>
                                        <?php $_smarty_tpl->_assignInScope('sub_qty', 0);?>
                                        <?php $_smarty_tpl->_assignInScope('sub_freight_amount', 0);?>
                                        <?php $_smarty_tpl->_assignInScope('sub_connecting_charges_amount', 0);?>
                                        <?php $_smarty_tpl->_assignInScope('sub_paid_amount', 0);?>
                                        <?php $_smarty_tpl->_assignInScope('sub_to_pay_amount', 0);?>
                            
                                        <tr>
                                            <td align="center" colspan="17" class="bold"><?php echo $_smarty_tpl->tpl_vars['routes']->value[$_smarty_tpl->tpl_vars['t1']->value];?>
</td>
                                        </tr>
                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row1']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                            
                                            <?php $_smarty_tpl->_assignInScope('total_qty', $_smarty_tpl->tpl_vars['total_qty']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                                            <?php $_smarty_tpl->_assignInScope('sub_qty', $_smarty_tpl->tpl_vars['sub_qty']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                                            <tr>
                                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['sno']->value;?>
</td>
                                                <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
<br></a>
                                                    <br>
                                                    <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->eway_bill_no)) {?>
                                                        <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/img/icons/eway.svg" width="30px" loading="lazy">
                                                    <?php }?>
                                                    <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->invoice_number)) {?>
                                                        <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/img/icons/invoice.svg" width="30px" loading="lazy">
                                                    <?php }?>
                                                </td>
                                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                                                <td align="center" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->eway_bill_no;?>
</td>
                                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_mobile;?>
</td>
                                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>
                                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_mobile;?>
</td>
                                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->user_first_name;?>
</td>
                                                <td align="center"><?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_status_code);?>
</td>
                            
                                                <td align="right">
                                                    <?php echo number_format(($_smarty_tpl->tpl_vars['row']->value->total_amount),2);?>

                                                    <?php $_smarty_tpl->_assignInScope('sub_freight_amount', $_smarty_tpl->tpl_vars['sub_freight_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                                                    <?php $_smarty_tpl->_assignInScope('total_freight_amount', $_smarty_tpl->tpl_vars['total_freight_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                                                </td>
                                                <td align="right">
                                                    <?php echo number_format(($_smarty_tpl->tpl_vars['row']->value->connecting_charge),2);?>

                                                    <?php $_smarty_tpl->_assignInScope('sub_connecting_charges_amount', $_smarty_tpl->tpl_vars['sub_connecting_charges_amount']->value+$_smarty_tpl->tpl_vars['row']->value->connecting_charge);?>
                                                    <?php $_smarty_tpl->_assignInScope('total_connecting_charges_amount', $_smarty_tpl->tpl_vars['total_connecting_charges_amount']->value+$_smarty_tpl->tpl_vars['row']->value->connecting_charge);?>
                                                </td>
                                                <td align="right">
                                                    <?php $_smarty_tpl->_assignInScope('paid', 0);?>
                                                    <?php if ($_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'PAD') {?>
                                                        <?php $_smarty_tpl->_assignInScope('paid', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount));?>
                                                        <?php echo number_format($_smarty_tpl->tpl_vars['paid']->value,2);?>

                                                        <?php $_smarty_tpl->_assignInScope('sub_paid_amount', $_smarty_tpl->tpl_vars['sub_paid_amount']->value+$_smarty_tpl->tpl_vars['paid']->value);?>
                                                        <?php $_smarty_tpl->_assignInScope('total_paid_amount', $_smarty_tpl->tpl_vars['total_paid_amount']->value+$_smarty_tpl->tpl_vars['paid']->value);?>
                                                    <?php } else { ?>
                                                        0.00
                                                    <?php }?>
                                                </td>
                                                <td align="right" nowrap>
                                                    <?php $_smarty_tpl->_assignInScope('topay', 0);?>
                                                    <?php if ($_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'TOP' || $_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'TPPAD') {?>
                                                        <?php $_smarty_tpl->_assignInScope('topay', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount));?>
                                                        <span data-toggle="tooltip" data-placement="left" data-html="true"
                                                        title="
                                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->total_amount) {?>
                                                        <i wrap>Include Unloading & Demurage</i><hr>
                                                        Total Fright Amount : <b><?php echo number_format($_smarty_tpl->tpl_vars['row']->value->total_amount,2);?>
 </b><br>
                                                        <?php }?>
                                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->total_amount) {?>
                                                            Other Charges : <b><?php echo number_format($_smarty_tpl->tpl_vars['row']->value->other_charges_amount,2);?>
</b>
                                                        <?php }?>"><i class="fa fa-info-circle"></i></span>
                                                        <?php echo number_format($_smarty_tpl->tpl_vars['topay']->value,2);?>

                                                        <?php $_smarty_tpl->_assignInScope('sub_to_pay_amount', $_smarty_tpl->tpl_vars['sub_to_pay_amount']->value+$_smarty_tpl->tpl_vars['topay']->value);?>
                                                        <?php $_smarty_tpl->_assignInScope('total_to_pay_amount', $_smarty_tpl->tpl_vars['total_to_pay_amount']->value+$_smarty_tpl->tpl_vars['topay']->value);?>
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
                                            <td align="center" class="active bold"></td>
                                            <td align="center" class="active bold">Subtotal</td>
                                            <td align="center" class="bold active"><?php echo $_smarty_tpl->tpl_vars['sub_qty']->value;?>
</td>
                                            <td colspan="10" class="active bold">&nbsp;</td>
                                            <td align="right" class="active bold"><?php echo number_format($_smarty_tpl->tpl_vars['sub_freight_amount']->value,2);?>
</td>
                                            <td align="right" class="active bold"><?php echo number_format($_smarty_tpl->tpl_vars['sub_connecting_charges_amount']->value,2);?>
</td>
                                            <td align="right" class="active bold"><?php echo number_format($_smarty_tpl->tpl_vars['sub_paid_amount']->value,2);?>
</td>
                                            <td align="right" class="bold active"><?php echo number_format($_smarty_tpl->tpl_vars['sub_to_pay_amount']->value,2);?>
</td>
                                        </tr>
                                    <?php
}
} else {
?>
                                        <tr>
                                            <td align="center" colspan="16">Sorry! No cargo found</td>
                                        </tr>
                                    <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                    <?php if (count($_smarty_tpl->tpl_vars['row1']->value) > 0) {?>
                                        <tr class="success">
                                            <td align="center" class="bold"></td>
                                            <td align="center" class="bold">Grandtotal</td>
                                            <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['total_qty']->value;?>
</td>
                                            <td colspan="10" class="bold">&nbsp;</td>
                                            <td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['total_freight_amount']->value,2);?>
</td>
                                            <td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['total_connecting_charges_amount']->value,2);?>
</td>
                                            <td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['total_paid_amount']->value,2);?>
</td>
                                            <td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['total_to_pay_amount']->value,2);?>
</td>
                                        </tr>
                                        <?php $_smarty_tpl->_assignInScope('total_pay_topay', $_smarty_tpl->tpl_vars['total_paid_amount']->value+$_smarty_tpl->tpl_vars['total_to_pay_amount']->value);?>
                                        <?php if ($_smarty_tpl->tpl_vars['total_pay_topay']->value >= 1) {?>
                                            <tr>
                                                <td colspan="15"  align="center" class="bold text-info">Summarize Total</td>
                                                <td colspan="2"  align="center" class="bold bg-info"> <span data-toggle="tooltip" data-placement="left" data-html="true"
                                                title="
                                                <b> Paid + To Pay </b>
                                                "><i class="fa fa-info-circle"></i></span> <?php echo number_format($_smarty_tpl->tpl_vars['total_pay_topay']->value,2);?>
</td>
                                            </tr>
                                        <?php }?>
                                    <?php }?>
                                </tbody>
                            </table>
                              

                                <br />
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['OGPL-PAY-SUMRY'] == 1) {?>
                                    <table width='100%'>
                                        <tr>
                                            <td><span class="bold">Summary</span></td>
                                        </tr>
                                    </table>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr class="info bold">
                                                <td align="center"><?php echo lang('lr');?>
 Type</td>
                                                <td align="center">No.of <?php echo lang('lr');?>
s</td>
                                                <td align="center">No.of <?php echo lang('booking_article_label');?>
</td>
                                                <td align="center">Freight</td>
                                                <td align="center">Connecting Charges</td>
                                                <td align="center">Loading Charges</td>
                                                <td align="center">Unloading Charges</td>
                                                <td align="center">Delivery Charges</td>
                                                <td align="center">Service Tax</td>
                                                <td align="center">Other Amounts</td>

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
                                            <?php $_smarty_tpl->_assignInScope('total_otheramounts', 0);?>
                                            <?php $_smarty_tpl->_assignInScope('net_total', 0);?>

                                        <tbody class="body_table">
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                <tr>
                                                    <?php $_smarty_tpl->_assignInScope('total', $_smarty_tpl->tpl_vars['row']->value['freight']+$_smarty_tpl->tpl_vars['row']->value['loading']+$_smarty_tpl->tpl_vars['row']->value['unloading']+$_smarty_tpl->tpl_vars['row']->value['service_tax']+$_smarty_tpl->tpl_vars['row']->value['delivery']+$_smarty_tpl->tpl_vars['row']->value['connecting']+$_smarty_tpl->tpl_vars['row']->value['remaining_amounts']);?>
                                                    <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['k']->value];?>
</b></td>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['lr'];?>
</td>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['packages'];?>
</td>
                                                    <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['freight'],2);?>
</td>
                                                    <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['connecting'],2);?>
</td>
                                                    <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['loading'],2);?>
</td>
                                                    <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['unloading'],2);?>
</td>
                                                    <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['delivery'],2);?>
</td>
                                                    <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['service_tax'],2);?>
</td>
                                                    <td align="center">
                                                    <span data-toggle="tooltip" data-placement="left" data-html="true"
                                                            title="<?php echo $_smarty_tpl->tpl_vars['row']->value['remaining_amounts_tooltip'];?>
"><i class="fa fa-info-circle"></i></span>
                                                    <?php echo number_format($_smarty_tpl->tpl_vars['row']->value['remaining_amounts'],2);?>
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
                                                <?php $_smarty_tpl->_assignInScope('total_otheramounts', $_smarty_tpl->tpl_vars['total_otheramounts']->value+$_smarty_tpl->tpl_vars['row']->value['remaining_amounts']);?>
                                                <?php $_smarty_tpl->_assignInScope('total_connecting', $_smarty_tpl->tpl_vars['total_connecting']->value+$_smarty_tpl->tpl_vars['row']->value['connecting']);?>
                                                <?php $_smarty_tpl->_assignInScope('net_total', $_smarty_tpl->tpl_vars['net_total']->value+$_smarty_tpl->tpl_vars['total']->value);?>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                        </tbody>
                                        <tfoot>
                                            <tr class="success">
                                                <td align="center"><b>Total</b></td>
                                                <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['total_lr']->value;?>
</b></td>
                                                <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['total_pkgs']->value;?>
</b></td>
                                                <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_frieght']->value,2);?>
</b></td>
                                                <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_connecting']->value,2);?>
</b></td>
                                                <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_loading']->value,2);?>
</b></td>
                                                <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_unloading']->value,2);?>
</b></td>
                                                <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_delivery']->value,2);?>
</b></td>
                                                <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_service_tax']->value,2);?>
</b></td>
                                                <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_otheramounts']->value,2);?>
</b></td>
                                                <td align="center" class="bg-info"><b><?php echo number_format($_smarty_tpl->tpl_vars['net_total']->value,2);?>
</b></td>
                                            </tr>
                                        </tfoot>

                                        </thead>
                                    </table>
                                <?php }?>

                                <div class="text-right">
                                    <div class="col-md-3 pull-right p_r_n">
                                        <div class="input-group">
                                            <select id="ogpl-chart-print" class="form-control" multiple>
                                                <option value="" selected="">All Routes</option>
                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['routes']->value, 'name', false, 'code');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['code']->value => $_smarty_tpl->tpl_vars['name']->value) {
?>
                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['code']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['name']->value;?>
</option>
                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                            </select>
                                            <span class="input-group-btn">
                                                <div class="btn-group" style="display: flex;">
                                                    <button class="btn btn-success" type="button" onclick="print_cargo_ogpl_chart('<?php echo $_REQUEST['transitCode'];?>
')">Print</button>
                                                    <button type="button" style="height:36px;" class="btn btn-success dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <span class="sr-only">Toggle Dropdown</span>
                                                        <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-right text-left" id="send-details-dd">
                                                        <li><a href="javascript:;" onclick="print_cargo_ogpl_chart('<?php echo $_REQUEST['transitCode'];?>
', 'PAID');">Print Paid</a></li>
                                                        <li><a href="javascript:;" onclick="print_cargo_ogpl_chart('<?php echo $_REQUEST['transitCode'];?>
', 'TOPAY');">Print Topay</a></li>
                                                    </ul>
                                                </div>
                                            </span>
                                        </div>
                                        <br>
                                        <div class="input-group">
                                            <span class="input-group-btn">
                                                <div class="btn-group" style="display: flex;justify-content: flex-end;">
                                                    <button class="btn btn-success" type="button" onclick="print_ogpl_driver_chart('<?php echo $_REQUEST['transitCode'];?>
', 'LASERPRINT')">Drivers Print</button>
                                                    <button type="button" style="margin-left: 5px;" class="btn btn-success" onclick="print_ogpl_driver_chart('<?php echo $_REQUEST['transitCode'];?>
', 'DOTMATRIX')">Drivers DM Print</button>
                                                </div>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo '<script'; ?>
>
    var transitCode = <?php echo json_encode($_smarty_tpl->tpl_vars['ogpl']->value);?>
;
    var OGPLVehicles = <?php echo json_encode($_smarty_tpl->tpl_vars['vehicles']->value);?>
;
    var namespaceCode = <?php echo json_encode($_smarty_tpl->tpl_vars['namespaceCode']->value);?>
;
    var ogpl=<?php echo json_encode($_smarty_tpl->tpl_vars['ogpl']->value);?>
;
    var odoDetails=<?php echo json_encode($_smarty_tpl->tpl_vars['odoDetails']->value);?>
;
    var transitOgplcode='<?php echo $_REQUEST['transitCode'];?>
';
    var user_login_branch = <?php echo json_encode($_smarty_tpl->tpl_vars['login_branch']->value);?>
;
    var cargoSetting = <?php echo json_encode($_smarty_tpl->tpl_vars['cargo_setting']->value);?>
;
    var login_user = <?php echo json_encode($_smarty_tpl->tpl_vars['login_user']->value);?>
;
    var startOdoUpdated = odoDetails != null && odoDetails.startOdometer != null ? odoDetails.startOdometer : 0;
    $('[data-toggle="tooltip"]').tooltip({
        html: true
    });
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
    $('#ogpl-chart-print').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        dropRight: true,
        buttonWidth: '100%',
        buttonClass: 'btn btn-default ogpl-chart-print',
        buttonContainer: '<div class="btn-group text-left dropup" />',
        enableFiltering: false,
        enableCaseInsensitiveFiltering: false,
    });

    function print_cargo_ogpl_chart(code, groupby) {
        if(checkOdoUpdation()){
            return;
        }
        var route = $('#ogpl-chart-print').val();
        var param = $.param({
            transitCode: code,
            groupby: groupby,
            route: (route || []).join(',')
        });

        var url = base_url + "cargo/ogpl-chart-details-print?" + param;
        var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
        wo.print();
    }

    function print_ogpl_driver_chart(code, printType) {
        if(checkOdoUpdation()){
            return;
        }
        var params = {};
        var routes = $('#ogpl-chart-print').val();
        params.transitCode = code;
        params.type = 'DVR';
        params.route = (routes || []).join(',');
        switch (printType) {
            case 'LASERPRINT':
                params.printType = 'LASERPRINT';
                break;
            case 'DOTMATRIX':
                params.printType = 'DOTMATRIX';
                break;
            default:
                alert('Please select a print option');
                return;
        }

        var url = base_url + 'cargo/ogpl-chart-details-print?' + $.param(params);
       
        if (printType == 'LASERPRINT') {
            var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
            wo.print();
        } else if (epIsActive()) {
            if (printType == 'DOTMATRIX' && ['citycargo', 'cityparcel'].includes(namespaceCode)) {
                epPrintUrlCommands(url);
            }
        } else {
            window.open(url, '_blank');
        }
    }

    function checkOdoUpdation(){
       
   
    }
<?php echo '</script'; ?>
><?php }
}
