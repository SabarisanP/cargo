<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-24 16:53:50
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ogpl-chart.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6679574659e012_61912600',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '8c5424150971c3ac748df80cc72ffcaaf3e704cd' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ogpl-chart.tpl',
      1 => 1719228226,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6679574659e012_61912600 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<style>
.content-center{
    display: flex;
    justify-content: center;
    align-items: center;
}
.content-top{
    display: flex;
    justify-content: center;
    align-items: flex-start;
}
.start-trip-dialog{
    padding-bottom: 0;
}
</style>
<div class="brand_top">
    <h3><?php echo lang('OGPL');?>
 Transit Chart</h3>
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
                                <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->ogplModelCode == 'VER3') {?>
                                    <?php if (count($_smarty_tpl->tpl_vars['showTransitTypes']->value) > 1) {?>
                                        <div class="col-md-2 pull-right p_r_n">
                                            <div class="input-group" style="width: 100%;">
                                                <select id="ogpl-chart-filter" class="form-control" onchange="filterData('<?php echo $_REQUEST['transitCode'];?>
', this.value);">
                                                    <option value="ALL" <?php if ($_REQUEST['transitType'] == 'ALL') {?>selected<?php }?>>All</option>
                                                    <?php if (in_array('DFLT',$_smarty_tpl->tpl_vars['showTransitTypes']->value)) {?>
                                                        <option value="DFLT" <?php if ($_REQUEST['transitType'] == 'DFLT') {?>selected<?php }?>>Direct Transit</option>
                                                    <?php }?>
                                                    <?php if (in_array('HULD',$_smarty_tpl->tpl_vars['showTransitTypes']->value)) {?>
                                                        <option value="HULD" <?php if ($_REQUEST['transitType'] == 'HULD') {?>selected<?php }?>>Hubload Transit</option>
                                                    <?php }?>
                                                    <?php if (in_array('LCLD',$_smarty_tpl->tpl_vars['showTransitTypes']->value)) {?>
                                                        <option value="LCLD" <?php if ($_REQUEST['transitType'] == 'LCLD') {?>selected<?php }?>>Local Transit</option>
                                                    <?php }?>
                                                    <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->transitMode[4] && in_array('OFDLD',$_smarty_tpl->tpl_vars['showTransitTypes']->value)) {?>
                                                        <option value="OFDLD" <?php if ($_REQUEST['transitType'] == 'OFDLD') {?>selected<?php }?>>Out for Delivery</option>
                                                    <?php }?>
                                                </select>
                                            </div>
                                        </div>
                                    <?php }?>
                                <?php }?>
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
                                            <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'srisendhursps') {?>
                                                <td align="center" rowspan="2">Article</td>
                                            <?php }?>
                                            <td align="center" rowspan="2">Qty<?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'dishashree') {?> / Kg<?php }?></td>
                                            <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>
                                                <td align="center" rowspan="2">Kg</td>
                                                <td align="center" rowspan="2">Act Kg</td>
                                                <td align="center" rowspan="2">Private Mark No</td>
                                            <?php }?>
                                            <td align="center" rowspan="2">Booked Date</td>
                                            <?php if ($_smarty_tpl->tpl_vars['namespace']->value !== 'ktwoklogistics') {?>
                                                <td align="center" rowspan="2">Booked At</td>
                                                <td align="center" rowspan="2">Delivery At</td>
                                            <?php }?>
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
                                            <td align="center"><?php echo lang('other_charges');?>
</td>
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
                                                <td align="center" colspan="16" class="bold"><?php echo $_smarty_tpl->tpl_vars['routes']->value[$_smarty_tpl->tpl_vars['t1']->value];?>
</td>
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
                                                    <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a>
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
                                                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'srisendhursps') {?>
                                                    <td align="center" nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                                                    <?php }?>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;
if ($_smarty_tpl->tpl_vars['namespace']->value == 'dishashree') {?> / <?php echo $_smarty_tpl->tpl_vars['row']->value->total_unit_value;
}?></td>
                                                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>
                                                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_unit_value;?>
</td>
                                                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_actual_unit_value;?>
</td>
                                                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->private_mark_number;?>
</td>
                                                    <?php }?>
                                                    <td align="center"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                                                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value !== 'ktwoklogistics') {?>
                                                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                                                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                                                    <?php }?>

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

                                                        <?php $_smarty_tpl->_assignInScope('o_freight_tot_amount', $_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['o_freight_tot_amount']->value);?>
                                                    </td>
                                                    <td align="right">
                                                        <?php echo number_format($_smarty_tpl->tpl_vars['row']->value->other_charges_amount,2);?>


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
                                                                            <td><b><?php echo _snakecase_to_titlecase($_smarty_tpl->tpl_vars['ck']->value);?>
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
                                                        <?php $_smarty_tpl->_assignInScope('o_other_tot_amount', $_smarty_tpl->tpl_vars['o_other_tot_amount']->value+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
                                                    </td>
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
                                                    <td align="right" >
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
                                                <td class="transit-details-type" data-transit="<?php echo substr($_smarty_tpl->tpl_vars['t1']->value,-4);?>
" style="display: none;"></td>
                                                <td align="center"></td>
                                                <td align="center"></td>
                                                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['o_qty']->value;
if ($_smarty_tpl->tpl_vars['namespace']->value == 'dishashree') {?> / <?php echo $_smarty_tpl->tpl_vars['o_kg']->value;
}?></td>
                                                <td colspan="<?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>10<?php } else { ?>9<?php }?>">&nbsp;</td>
                                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['o_freight_tot_amount']->value,2);?>
</td>
                                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['o_other_tot_amount']->value,2);?>
 <i class="fa fa-info-circle fa-inverse"></i></td>
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
                                                <td align="center" colspan="<?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>16<?php } else { ?>16<?php }?>">Sorry! No cargo found</td>
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
                                        <table class="table table-bordered" id="expenses-table">
                                            <thead class="sticky-row-top">
                                                <tr class="info bold">
                                                    <th>Category</th>
                                                    <th>Type </th>
                                                    <th>Payment Mode </th>
                                                    <th>Amount </th>
                                                    <th></th>
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
                                                                    <span class='label label-sm label-primary'>Income</span>
                                                                <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cashbookType->transactionType == 'Dr') {?>
                                                                    <span class='label label-sm label-danger'>Expense</span>
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
                                                            <td align="right">
                                                                <span class="pull-left" data-toggle="tooltip" data-placement="top" title="<?php echo $_smarty_tpl->tpl_vars['row']->value->user->name;?>
<br/><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->transactionAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
"><i class="fa fa-info-circle"></i></span>
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
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="expenses-table">
                                            <thead class="sticky-row-top">
                                                <tr class="info bold">
                                                    <th>Category</th>
                                                    <th>Income / Expense Type </th>
                                                    <th>Payment Mode </th>
                                                                                                        <th>Inc. Amount </th>
                                                    <th>Exp. Amount</th>
                                                                                                                                                            <th></th>
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
                                                                    <span class='label label-sm label-primary'>Income</span>
                                                                <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cashbookType->transactionType == 'Dr') {?>
                                                                    <span class='label label-sm label-danger'>Expense</span>
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
                                                                                                                                                                                    <td align="right">
                                                                <span class="pull-left" data-toggle="tooltip" data-placement="top" title="<?php echo $_smarty_tpl->tpl_vars['row']->value->user->name;?>
<br/><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->transactionAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
"><i class="fa fa-info-circle"></i></span>
                                                            </td>
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
                                                <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>
                                                    <td align="center" rowspan="2">Kg</td>
                                                    <td align="center" rowspan="2">Act Kg</td>
                                                <?php }?>
                                                <td align="center">Freight</td>
                                                <td align="center">Loading Charges</td>
                                                <td align="center">Unloading Charges</td>
                                                <td align="center">Delivery Charges</td>
                                                <td align="center">Service Tax</td>
                                                <td align="center">Other Amounts</td>
                                                <td align="center">Total</td>
                                            </tr>
                                        </thead>

                                        <tbody class="body_table">
                                            <?php $_smarty_tpl->_assignInScope('total', 0);?>
                                            <?php $_smarty_tpl->_assignInScope('total_lr', 0);?>
                                            <?php $_smarty_tpl->_assignInScope('total_pkgs', 0);?>
                                            <?php $_smarty_tpl->_assignInScope('total_frieght', 0);?>
                                            <?php $_smarty_tpl->_assignInScope('total_loading', 0);?>
                                            <?php $_smarty_tpl->_assignInScope('total_unloading', 0);?>
                                            <?php $_smarty_tpl->_assignInScope('total_delivery', 0);?>
                                            <?php $_smarty_tpl->_assignInScope('total_service_tax', 0);?>
                                            <?php $_smarty_tpl->_assignInScope('net_total', 0);?>
                                            <?php $_smarty_tpl->_assignInScope('kg_total', 0);?>
                                            <?php $_smarty_tpl->_assignInScope('ac_kg_total', 0);?>

                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                <tr>
                                                    <?php $_smarty_tpl->_assignInScope('total', $_smarty_tpl->tpl_vars['row']->value['freight']+$_smarty_tpl->tpl_vars['row']->value['loading']+$_smarty_tpl->tpl_vars['row']->value['unloading']+$_smarty_tpl->tpl_vars['row']->value['service_tax']+$_smarty_tpl->tpl_vars['row']->value['delivery']+$_smarty_tpl->tpl_vars['row']->value['remaining_amounts']);?>
                                                    <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['k']->value];?>
</b></td>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['lr'];?>
</td>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['packages'];?>
</td>
                                                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>
                                                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['kg_val'];?>
</td>
                                                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['ac_kg_val'];?>
</td>
                                                    <?php }?>
                                                    <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['freight'],2);?>
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
                                                <?php $_smarty_tpl->_assignInScope('kg_total', $_smarty_tpl->tpl_vars['kg_total']->value+$_smarty_tpl->tpl_vars['row']->value['kg_val']);?>
                                                    <?php $_smarty_tpl->_assignInScope('ac_kg_total', $_smarty_tpl->tpl_vars['ac_kg_total']->value+$_smarty_tpl->tpl_vars['row']->value['ac_kg_val']);?>
                                                    <?php $_smarty_tpl->_assignInScope('total_otheramounts', $_smarty_tpl->tpl_vars['total_otheramounts']->value+$_smarty_tpl->tpl_vars['row']->value['remaining_amounts']);?>
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
                                                <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?>
                                                    <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['kg_total']->value;?>
</b></td>
                                                    <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['ac_kg_total']->value;?>
</b></td>
                                                <?php }?>
                                                <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['total_frieght']->value,2);?>
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
                                                <td align="center"><b><?php echo number_format($_smarty_tpl->tpl_vars['net_total']->value,2);?>
</b></td>
                                            </tr>
                                        </tfoot>
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



<div id="start-trip-dialog" class="hide content content-center">
     <img src="assets/loaders/odometer.gif" loading="lazy" width="200px" height="200px">
</div>

<?php echo '<script'; ?>
>
    var OGPLFormData = <?php echo json_encode($_smarty_tpl->tpl_vars['ogpl']->value);?>
;
    var ogpl=<?php echo json_encode($_smarty_tpl->tpl_vars['ogpl']->value);?>
;
    var transitOgplcode='<?php echo $_REQUEST['transitCode'];?>
';
    var user_login_branch = <?php echo json_encode($_smarty_tpl->tpl_vars['login_branch']->value);?>
;
    var cargoSetting = <?php echo json_encode($_smarty_tpl->tpl_vars['cargo_setting']->value);?>
;
    var login_user = <?php echo json_encode($_smarty_tpl->tpl_vars['login_user']->value);?>
;
    var odoDetails = <?php echo json_encode($_smarty_tpl->tpl_vars['odoDetails']->value);?>
;
    if(cargoSetting.transitOdometerModelCode == "ORGDTN"){
        if(login_user != ogpl.fromOrganization.code && login_user != ogpl.toOrganization.code){
            if(odoDetails.startOdometer == 0 && odoDetails.toOdometerRange > 0 ){
             makeTripOption();
            }
        }
    }

    var startOdoUpdated = odoDetails != null && odoDetails.startOdometer != null ? odoDetails.startOdometer : 0;

    function makeTripOption(){
        var data = {};
        data.transitCode = transitOgplcode;
            $('#start-trip-dialog').removeClass('hide');
            $('#start-trip-dialog').dialog({
                autoOpen: true,
                width: 800,
                height:700,
                modal: true,
                closeOnEscape:true,
                resizable: true
            });
        $.ajax({
            type: "post",
            url: "cargo/make-start-trip",
            data: data,
            dataType: "html",
            success: function (response) {
                $('#start-trip-dialog').removeClass(".content-center")
                $('#start-trip-dialog').addClass(".content-top")
                $('#start-trip-dialog').html(response);
            }
        });
    }

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

    function filterData(code, url) {
        var param = $.param({
            transitCode: code,
            transitType: url,
        });
        var reqUrl =  base_url + "#cargo/ogpl-chart-details?" + param;
        location.href = reqUrl;
    }

    function print_cargo_ogpl_chart(code, groupby) {
        if(!startOdoUpdated && cargoSetting.transitOdometerModelCode != "NA"){
            makeTripOption();
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
    function hideStartTripDialog() {
            $('#start-trip-dialog').dialog('destroy');
            $('#start-trip-dialog').hide();
    }
    function setStartTripTransactionMode() {
            var mode = $('#start-trip-adv-paymode').val();

            $('#start-trip-adv-cheque-mode-panel').addClass('hide');
            $('#start-trip-adv-netbanking-mode-panel').addClass('hide');
            $('#start-trip-adv-upi-mode-panel').addClass('hide');

            if (mode == 'CASH') {
                return;
            }

            if (mode == 'CHEQUE') {
                $('#start-trip-adv-cheque-mode-panel').removeClass('hide');
            } else if (mode == 'NBK') {
                $('#start-trip-adv-netbanking-mode-panel').removeClass('hide');
            } else if (mode == 'UPI') {
                $('#start-trip-adv-upi-mode-panel').removeClass('hide');
            }
    }
    function startTransitV3Trip() {
            var allowLoading = $('#allowLoad').val();
            var vehicleLastOdometer = $('#lastOdometer').val();
            var ownershipCode = $('#ownership-code').val();
            var data = {}, err = 0;
            data.action = 'DEPARTURE';
            data.transitCode = OGPLFormData.code;
            data.transitCargo = {};
            data.transitCargo.code = OGPLFormData.code;
            data.fromOrganization = {};
            data.fromOrganization.code = user_login_branch;
            data.startOdometer = Number($('#start-trip-odo').val());
            data.departureAt = moment().format('YYYY-MM-DD HH:mm:ss');
            data.fromOrganizationContact = {};
            data.fromOrganizationContact.code = $('#start-trip-supervisor').val();

            $('.inp_error').removeClass('inp_error');
            if (isNaN(data.startOdometer) || data.startOdometer < 0 || data.startOdometer == '') {
                $('#start-trip-odo').addClass('inp_error');
                err++;
            }
            if (vehicleLastOdometer > 0 && data.startOdometer < vehicleLastOdometer) {
                $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
                $('#start-trip-action-state').html('Entered odometer value should be greater than last odometer value');
                return;
            }

            if (isNull(odoDetails) || (odoDetails && (odoDetails.startOdometer == 0))) {
                // fuel expense
                data.fuelExpenseCode = '';
                data.activeFlag = 1;
                data.fuelDate = moment().format('YYYY-MM-DD');
                data.vehicle = {};
                data.vehicle.code = OGPLFormData.busVehicle.code;
                
                data.vendorContact = {};
                data.vendorContact.code = $('#start-trip-fuel-vendor').val();

                data.transactionMode = {};
                data.transactionMode.code = $('#start-trip-fuel-payment-mode').val();

                data.litres = Number($('#start-trip-fuel-litres').val());
                data.pricePerLitre = Number($('#start-trip-fuel-rate').val());
                data.totalAmount = data.litres * data.pricePerLitre;
                data.billNumber = $.trim($('#start-trip-fuel-coupon').val());

                // hiring amount and advance amount
                data.ogpl = [];

                if ((cargoSetting.userAccountModel.code == 'TXRT' && ownershipCode == "HIRE") || cargoSetting.userAccountModel.code != 'TXRT') {
                    var hire = {};

                    hire.code = '';
                    hire.activeFlag = 1;
                    hire.amount = Number($('#start-trip-hire-amount').val());
                    hire.remarks = '';

                    hire.user = {};
                    hire.user.code = login_user;

                    hire.transitCargo = {};
                    hire.transitCargo.code = OGPLFormData.code;
                    
                    hire.cashbookType = {};
                    hire.cashbookType.code = 'HIRING';

                    if (Number(hire.amount) > 0) {
                        data.ogpl.push(hire);
                    }
                }
                
                var advance = {};

                advance.code = '';
                advance.activeFlag = 1;
                advance.amount = Number($('#start-trip-advance-amount').val());
                advance.remarks = '';

                advance.user = {};
                advance.user.code = login_user;

                advance.transitCargo = {};
                advance.transitCargo.code = OGPLFormData.code;

                advance.transactionMode = {};
                advance.transactionMode.code = $('#start-trip-adv-paymode').val();
                
                advance.cashbookType = {};
                advance.cashbookType.code = 'ADVANCE';

                advance.paymentByContact = {};
                advance.paymentByContact.code = $('#start-trip-adv-payby').val();

                if (advance.transactionMode.code == 'UPI') {
                    advance.bankDetails = {};
                    advance.bankDetails.code = $('#start-trip-adv-upi-orgbank').val();
                    advance.addAttr1 = $.trim($('#start-trip-adv-upi-id').val());
                    advance.addAttr2 = $.trim($('#start-trip-adv-upi-details').val());
                } else if (advance.transactionMode.code == 'NBK') {
                    advance.bankDetails = {};
                    advance.bankDetails.code = $('#start-trip-adv-netbanking-orgbank').val();
                    advance.addAttr1 = $.trim($('#start-trip-adv-netbanking-accholder').val());
                    advance.addAttr2 = $.trim($('#start-trip-adv-netbanking-bankname').val());
                    advance.addAttr3 = $.trim($('#start-trip-adv-netbanking-details').val());
                } else if (advance.transactionMode.code == 'CHEQUE') {
                    advance.chequeDetails = {};
                    advance.chequeDetails.code = $('#start-trip-adv-chq-code').val();
                    advance.chequeDetails.activeFlag = 1;

                    advance.chequeDetails.organization = {};
                    advance.chequeDetails.organization.code = '<?php echo $_smarty_tpl->tpl_vars['login_branch']->value;?>
';

                    advance.chequeDetails.bankDetails = $.trim($('#start-trip-adv-cheque-bankname').val());
                    advance.chequeDetails.payerDetails = $.trim($('#start-trip-adv-cheque-payer').val());

                    advance.chequeDetails.chequeDate = moment($('#start-trip-adv-cheque-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                    advance.chequeDetails.chequeNo = $.trim($('#start-trip-adv-cheque-no').val());
                    advance.chequeDetails.bankCity = $.trim($('#start-trip-adv-cheque-bankcity').val());

                    advance.chequeDetails.chequeStatus = {};
                    advance.chequeDetails.chequeStatus.code = 'NEW';

                    advance.chequeDetails.remarks = $.trim($('#start-trip-adv-cheque-remarks').val());
                }

                if (Number(advance.amount) > 0) {
                    data.ogpl.push(advance);
                }

                // advance amount
                if ((cargoSetting.userAccountModel.code == 'TXRT' && $.inArray(OGPLFormData.cargoActivityType.code, ['OTFD', 'INTRNT']) != -1 && ownershipCode == "OWN" && !isNull(hire) && hire.amount != '') || (cargoSetting.userAccountModel.code != 'TXRT' && !isNull(hire) && hire.amount != '') || advance.amount != '' || advance.transactionMode.code != '' || advance.paymentByContact.code != '') {
                    if (!isNull(hire) && hire.amount == '') {
                        $('#start-trip-hire-amount').addClass('inp_error');
                        err++;
                    }
                    
                    if (advance.amount == '') {
                        $('#start-trip-advance-amount').addClass('inp_error');
                        err++;
                    }

                    if (advance.transactionMode.code == '') {
                        $('#start-trip-adv-paymode').addClass('inp_error');
                        err++;
                    }

                    if (advance.paymentByContact.code == '') {
                        $('#start-trip-adv-payby').addClass('inp_error');
                        err++;
                    }

                    if (advance.transactionMode.code == 'UPI') {
                        if (advance.addAttr1 == '') {
                            $('#start-trip-adv-upi-id').addClass('inp_error');
                            err++;
                        }

                        if ($('#start-trip-adv-upi-orgbank').val() == '') {
                            $('#start-trip-adv-upi-orgbank').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr2 == '') {
                            $('#start-trip-adv-upi-details').addClass('inp_error');
                            err++;
                        }
                    } else if (advance.transactionMode.code == 'NBK') {
                        if (advance.addAttr1 == '') {
                            $('#start-trip-adv-netbanking-accholder').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr2 == '') {
                            $('#start-trip-adv-netbanking-bankname').addClass('inp_error');
                            err++;
                        }

                        if ($('#start-trip-adv-netbanking-orgbank').val() == '') {
                            $('#start-trip-adv-netbanking-orgbank').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr3 == '') {
                            $('#start-trip-adv-netbanking-details').addClass('inp_error');
                            err++;
                        }
                    } else if (advance.transactionMode.code == 'CHEQUE') {
                        if (advance.chequeDetails.payerDetails == '') {
                            $('#start-trip-adv-cheque-payer').addClass('inp_error');
                            err++;
                        }

                        if ($('#start-trip-adv-cheque-date').val() == '') {
                            $('#start-trip-adv-cheque-date').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.chequeNo == '') {
                            $('#start-trip-adv-cheque-no').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.bankDetails == '') {
                            $('#start-trip-adv-cheque-bankname').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.bankCity == '') {
                            $('#start-trip-adv-cheque-bankcity').addClass('inp_error');
                            err++;
                        }
                    }
                }

                // fuel expense
                if (data.vendorContact.code != '' || data.litres != '' || data.pricePerLitre != '' || data.billNumber != '') {
                    if (data.vendorContact.code == '') {
                        $('#start-trip-fuel-vendor').addClass('inp_error');
                        err++;
                    }

                    if (data.litres == '') {
                        $('#start-trip-fuel-litres').addClass('inp_error');
                        err++;
                    }

                    if (data.pricePerLitre == '') {
                        $('#start-trip-fuel-rate').addClass('inp_error');
                        err++;
                    }

                    if (data.billNumber == '') {
                        $('#start-trip-fuel-coupon').addClass('inp_error');
                        err++;
                    }
                }
            }
            
            if(err) {
                $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
                $('#start-trip-action-state').html('Please enter/select the values in the field that are marked in red');
                return;
            }
            $('#start-trip-panel-btn').hide();
            $('#start-trip-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
            var transitList = [];
                $('#transit-type [name="transit-type"]:checked').each(function() {
                    transitList.push($(this).val());
                });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-start-odometer",
                data: data,
                success: function (response) {
                    if (response.status == 1) {       
                        startOdoUpdated == 1;         
                        $('#start-trip-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                        window.setTimeout(function () {
                            hideStartTripDialog();
                            window.location.reload();
                        }, 3000);
                    } else {
                        $('#start-trip-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                        $('#start-trip-panel-btn').show();
                    }

                }
            });
    }


<?php echo '</script'; ?>
><?php }
}
