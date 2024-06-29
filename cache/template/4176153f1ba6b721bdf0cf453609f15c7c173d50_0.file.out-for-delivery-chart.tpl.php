<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-03 18:45:14
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\out-for-delivery-chart.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665dc1e2572134_81563952',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '4176153f1ba6b721bdf0cf453609f15c7c173d50' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\out-for-delivery-chart.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665dc1e2572134_81563952 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="brand_top">
    <h3>Door Pickup and Delivery Trip Chart</h3>
    <span class="align-right">
        <a href="#cargo/out-for-delivery?fill=1" class="btn btn-success  btn-sm"> <i class="fa fa-arrow-left"></i> Back</a>
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
                                        <td width="100%" colspan="2"><b>Trip Number:</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->aliasCode;?>
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
                                <h5><b>Door Delivery</b></h5>
                                <table id="dt_adv_booking_report_table" class="table table-bordered" >
                                    <thead>
                                        <tr class="info bold">
                                            <td align="center" rowspan="2">S.No</td>
                                            <td align="center" rowspan="2"><?php echo lang('lr');?>
</td>
                                            <td align="center" rowspan="2">Qty</td>
                                            <td align="center" rowspan="2"><?php echo lang('booking_sender_term');?>
 Name</td>
                                            <td align="center" rowspan="2"><?php echo lang('booking_sender_term');?>
 Mobile</td>
                                            <td align="center" rowspan="2"><?php echo lang('booking_receiver_term');?>
 Name</td>
                                            <td align="center" rowspan="2"><?php echo lang('booking_receiver_term');?>
 Mobile</td>
                                            <td align="center" rowspan="2">Payment Status</td>
                                            <td align="center" rowspan="2">To Pay</td>
                                            <td align="center" rowspan="2">Address</td>
                                            <td align="center" rowspan="2">Signature</td>
                                        </tr>
                                    </thead>
                                    <tbody class="body_table" >
                                        <?php $_smarty_tpl->_assignInScope('o_qty', 0);?>
                                        <?php $_smarty_tpl->_assignInScope('sno', 1);?>

                                        <?php $_smarty_tpl->_assignInScope('o_freight_tot_amount', 0);?>
                                        <?php $_smarty_tpl->_assignInScope('o_handling_tot_amount', 0);?>

                                        <?php $_smarty_tpl->_assignInScope('o_pd_tot_amount', 0);?>
                                        <?php $_smarty_tpl->_assignInScope('o_pb_tot_amount', 0);?>

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

                                                <?php $_smarty_tpl->_assignInScope('o_qty', $_smarty_tpl->tpl_vars['o_qty']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>

                                                <tr>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['sno']->value;?>
</td>
                                                    <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                                                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_mobile;?>
</td>
                                                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_mobile;?>
</td>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->payment_status_code];?>
</td>
                                                    <td align="right" >
                                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'TOP') {?>
                                                            <?php $_smarty_tpl->_assignInScope('topay', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->handling+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax)-$_smarty_tpl->tpl_vars['row']->value->total_amount_paid);?>
                                                            <?php echo number_format($_smarty_tpl->tpl_vars['topay']->value,2);?>

                                                            <?php $_smarty_tpl->_assignInScope('o_pb_tot_amount', $_smarty_tpl->tpl_vars['topay']->value+$_smarty_tpl->tpl_vars['o_pb_tot_amount']->value);?>
                                                        <?php } else { ?>
                                                            0.00
                                                        <?php }?>
                                                    </td>
                                                    <td align="center"></td>
                                                    <td align="center"></td>
                                                </tr>
                                                <?php $_smarty_tpl->_assignInScope('sno', $_smarty_tpl->tpl_vars['sno']->value+1);?>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                            <tr>
                                                <td align="center"></td>
                                                <td align="center"></td>
                                                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['o_qty']->value;?>
</td>
                                                <td colspan="5">&nbsp;</td>
                                                <td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['o_pb_tot_amount']->value,2);?>
</td>
                                                <td align="center"></td>
                                                <td align="center"></td>
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
                                    </tbody>
                                </table>

                                <h5><b>Door Pickup</b></h5>
                                <table id="dt_adv_booking_report_table" class="table table-bordered" >
                                    <thead>
                                        <tr class="info bold">
                                            <td align="center" rowspan="2">S.No</td>
                                            <td align="center" rowspan="2"><?php echo lang('lr');?>
</td>
                                            <td align="center" rowspan="2">Qty</td>
                                            <td align="center" rowspan="2"><?php echo lang('booking_sender_term');?>
 Name</td>
                                            <td align="center" rowspan="2"><?php echo lang('booking_sender_term');?>
 Mobile</td>
                                            <td align="center" rowspan="2"><?php echo lang('booking_receiver_term');?>
 Name</td>
                                            <td align="center" rowspan="2"><?php echo lang('booking_receiver_term');?>
 Mobile</td>
                                            <td align="center" rowspan="2">Payment Status</td>
                                            <td align="center" rowspan="2">To Pay</td>
                                            <td align="center" rowspan="2">Address</td>
                                            <td align="center" rowspan="2">Signature</td>
                                        </tr>
                                    </thead>
                                    <tbody class="body_table" >
                                        <?php $_smarty_tpl->_assignInScope('o_qty', 0);?>
                                        <?php $_smarty_tpl->_assignInScope('sno', 1);?>

                                        <?php $_smarty_tpl->_assignInScope('o_freight_tot_amount', 0);?>
                                        <?php $_smarty_tpl->_assignInScope('o_handling_tot_amount', 0);?>

                                        <?php $_smarty_tpl->_assignInScope('o_pd_tot_amount', 0);?>
                                        <?php $_smarty_tpl->_assignInScope('o_pb_tot_amount', 0);?>

                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['prebook']->value, 'row1', false, 't1');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t1']->value => $_smarty_tpl->tpl_vars['row1']->value) {
?>
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row1']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>

                                                <?php $_smarty_tpl->_assignInScope('o_qty', $_smarty_tpl->tpl_vars['o_qty']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>

                                                <tr>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['sno']->value;?>
</td>
                                                    <td align="center"><a href='javascript:;' title="more details" onclick='getPreBookingDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                                                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_mobile;?>
</td>
                                                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_mobile;?>
</td>
                                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->payment_status_code];?>
</td>
                                                    <td align="right" >
                                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'TOP') {?>
                                                            <?php $_smarty_tpl->_assignInScope('topay', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->handling+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax)-$_smarty_tpl->tpl_vars['row']->value->total_amount_paid);?>
                                                            <?php echo number_format($_smarty_tpl->tpl_vars['topay']->value,2);?>

                                                            <?php $_smarty_tpl->_assignInScope('o_pb_tot_amount', $_smarty_tpl->tpl_vars['topay']->value+$_smarty_tpl->tpl_vars['o_pb_tot_amount']->value);?>
                                                        <?php } else { ?>
                                                            0.00
                                                        <?php }?>
                                                    </td>
                                                    <td align="center"></td>
                                                    <td align="center"></td>
                                                </tr>
                                                <?php $_smarty_tpl->_assignInScope('sno', $_smarty_tpl->tpl_vars['sno']->value+1);?>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                            <tr>
                                                <td align="center"></td>
                                                <td align="center"></td>
                                                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['o_qty']->value;?>
</td>
                                                <td colspan="5">&nbsp;</td>
                                                <td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['o_pb_tot_amount']->value,2);?>
</td>
                                                <td align="center"></td>
                                                <td align="center"></td>
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
                                    </tbody>
                                </table>

                                <div class="text-right">
                                    <div class="col-md-2 pull-right p_r_n">
                                        <div class="input-group">
                                            <select id="ofd-chart-print" class="form-control hide">
                                                <option value="" selected="">All Routes</option>
                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row', false, 't1');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t1']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['t1']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['t1']->value;?>
</option>
                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                            </select>
                                            <span class="input-group-btn">
                                                <button class="btn btn-success" type="button" onclick="print_out_for_del_chart('<?php echo $_REQUEST['transitCode'];?>
')">Print</button>
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
    function print_out_for_del_chart(code) {
        var route = encodeURIComponent($('#ofd-chart-print').val());
        var url = base_url + "cargo/out-for-delivery-chart-details-print?transitCode=" + code + "&route=" + route;
        var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
        wo.print();
    }
<?php echo '</script'; ?>
><?php }
}
