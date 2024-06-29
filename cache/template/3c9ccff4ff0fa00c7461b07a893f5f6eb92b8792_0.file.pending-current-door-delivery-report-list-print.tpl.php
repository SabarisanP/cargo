<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-15 11:26:42
  from 'E:\xampp\htdocs\cargo\application\views\site\report\pending-current-door-delivery-report-list-print.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666d2d1a7ac812_83210500',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '3c9ccff4ff0fa00c7461b07a893f5f6eb92b8792' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\pending-current-door-delivery-report-list-print.tpl',
      1 => 1718430988,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666d2d1a7ac812_83210500 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table style="border: 1px solid #000" cellpadding="20" width="100%">
    <tr>
                    <td align="left" width="25%">
                &nbsp;<img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
/assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
                <td align="center" width="50%">
            <h2>Pending & Current Door Delivery Report</h2>
        </td>
        <td width="25%">
            <table width="100%" style="line-height: 20px;" class="bottom">
                <tr>
                    <td align="right" width="50%"><b>Branch</b></td>
                    <td width="100%">&nbsp;<b>:</b><?php if ($_smarty_tpl->tpl_vars['branch_name']->value !== "NA") {
echo $_smarty_tpl->tpl_vars['branch_name']->value;
} else { ?>ALL<?php }?> </td>
                </tr>
                <tr>
                    <td align="right" width="50%" class="bold"><b>Date</b></td>
                    <td width="100%">&nbsp;<b>:</b> <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table border="1" class="bordered" cellpadding="5" width="100%">
    <thead>
        <tr>
            <th colspan="10">Pending Door Delivery</th>
        </tr>
        <tr>
            <th>S.No</th>
            <th>NAME</th>
            <th>FROM PLACE</th>
            <th>LR DATE</th>
            <th>ARTICLES</th>
            <th>AMOUNT</th>
            <th>LR NO</th>
            <th>MODE OF PAYMENT</th>
            <th>TAKEN BY VEHICLENO</th>
            <th>STATUS</th>
        </tr>
    </thead>
    <tbody>
        <?php $_smarty_tpl->_assignInScope('t_total_amount', 0);?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['details']->value, 'row', false, 'i');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
            <?php if ($_smarty_tpl->tpl_vars['user_date']->value > smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,"%Y-%m-%d")) {?>
                <tr>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['i']->value+1;?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                    <td align="center" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->articles;?>
</td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_amount;?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->payment_status_code];?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->registration_number;?>
 <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->unloaded_driver_name)) {?>/<?php echo $_smarty_tpl->tpl_vars['row']->value->unloaded_driver_name;
}?></td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->bill_collection;?>
</td>
                </tr>
                <?php $_smarty_tpl->_assignInScope('t_total_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
            <?php }?>
        <?php
}
} else {
?>
            <tr>
                <td colspan="12" align="center">No Records Found</td>
            </tr>
        <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <tr>
            <td colspan="5" align="center">Total</td>
            <td align="center"><?php echo number_format($_smarty_tpl->tpl_vars['t_total_amount']->value,2);?>
</td>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center"></td>

        </tr>

    </tbody>
</table>
<table style="border: 1px solid #000" cellpadding="20" width="100%">
    <tr>
                    <td align="left" width="25%">
                &nbsp;<img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
/assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
                <td align="center" width="50%">
            <h2>Pending & Current Door Delivery Report</h2>
        </td>
        <td width="25%">
            <table width="100%" style="line-height: 20px;" class="bottom">
                <tr>
                    <td align="right" width="50%" class="bold">Date</td>
                    <td width="100%">&nbsp;<b>:</b> <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table border="1" class="bordered" cellpadding="2" width="100%">
    <thead>
        <tr>
            <th colspan="12">Current Door Delivery</th>
        </tr>
        <tr>
            <th>S.No</th>
            <th>Vehicle No.</th>
            <th></th>
            <th width="10%">Name</th>
            <th>From Location</th>
            <th>LR Date</th>
            <th>Articles</th>
            <th>Amount</th>
            <th>LR No.</th>
            <th>Mode of Payment</th>
            <th>Taken By Vehicle No.</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <?php $_smarty_tpl->_assignInScope('t_total_amount', 0);?>
        <?php $_smarty_tpl->_assignInScope('pending_rpt_sno', 0);?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['vehicleWise']->value, 'row', false, 'i');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
            <?php $_smarty_tpl->_assignInScope('pending_rpt_sub_no', 0);?>
                            <?php $_smarty_tpl->_assignInScope('pending_rpt_sno', $_smarty_tpl->tpl_vars['pending_rpt_sno']->value+1);?>

                <tr>
                    <td rowspan="<?php echo $_smarty_tpl->tpl_vars['row']->value['vehicle_count']+1;?>
"><?php echo $_smarty_tpl->tpl_vars['pending_rpt_sno']->value;?>
</td>
                    <td rowspan="<?php echo $_smarty_tpl->tpl_vars['row']->value['vehicle_count']+1;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value['vehicle_no'];?>
<br><?php echo $_smarty_tpl->tpl_vars['row']->value['vehicle_name'];?>
<br>
                        (No.Of.Lr-<?php echo $_smarty_tpl->tpl_vars['row']->value['vehicle_count'];?>
)
                    </td>
                    <td><b>SNo<b></td>
                    <td colspan="2" align="center"><b><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value['loaded_date'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
&nbsp;<?php echo $_smarty_tpl->tpl_vars['row']->value['from_station_name'];?>
 TO <?php echo $_smarty_tpl->tpl_vars['row']->value['to_station_name'];?>
</b></td>
                    <td colspan="7"><b>Vehicle Arrival Time :- <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value['unloaded_date'],$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Unloading Person:- <?php echo $_smarty_tpl->tpl_vars['row']->value['unloaded_user_name'];?>
</b></td>
                </tr>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value['code'], 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                    <?php $_smarty_tpl->_assignInScope('pending_rpt_sub_no', $_smarty_tpl->tpl_vars['pending_rpt_sub_no']->value+1);?>
                    <tr>
                        <td><?php echo $_smarty_tpl->tpl_vars['pending_rpt_sub_no']->value;?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['val']->value->from_customer_name;?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['val']->value->from_organization_name;?>
</td>
                        <td align="center" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['val']->value->booked_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['val']->value->articles;?>
</td>
                        <td align="right"><?php echo $_smarty_tpl->tpl_vars['val']->value->total_amount;?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['val']->value->cargo_code;?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['val']->value->payment_status_code];?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['val']->value->delivery_vehicle_number;?>
 <br> <?php echo $_smarty_tpl->tpl_vars['val']->value->transit_driver_name;?>
</td>
                        <td align="center"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['val']->value->bill_collection)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                    </tr>
                    <?php $_smarty_tpl->_assignInScope('t_total_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    <?php
}
} else {
?>
            <tr>
                <td rowspan="2" align="center">-</td>
                <td rowspan="2" align="center">-</td>
                <td><b>SNo<b></td>
                <td colspan="2" align="center">-</td>
                <td colspan="7"><b>Vehicle Arrival Time :- </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Unloading Person:-</b></td>
            </tr>
            <tr>
                <td></td>
                <td align="center">-</td>
                <td align="center">-</td>
                <td align="center">-</td>
                <td align="center">-</td>
                <td align="right">-</td>
                <td align="center">-</td>
                <td align="center">-</td>
                <td align="center">-</td>
                <td align="center">-</td>
            </tr>
        <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </tbody>
</table>

<table width="100%">
    <h5><b>Summary</b></h5>
    <tr>
        <td align="left">
            <table border="1" class="bordered" cellpadding="2">
                <thead>
                    <tr>
                        <th>Payment Details :</th>
                        <th colspan="2"></th>
                    </tr>
                    <tr>
                        <th>Mode of Payment</th>
                        <th>No. of GCN</th>
                        <th>Amount(Rs.)</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $_smarty_tpl->_assignInScope('t_total_amount', 0);?>
                    <?php $_smarty_tpl->_assignInScope('t_lr_count', 0);?>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'row', false, 'i');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->attribute_type == 'PAYMENT_TYPE') {?>
                            <tr>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->attribute_code];?>
</td>
                                <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->lr_count;?>
</td>
                                <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->amount;?>
</td>
                            </tr>
                            <?php $_smarty_tpl->_assignInScope('t_total_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value+$_smarty_tpl->tpl_vars['row']->value->amount);?>
                            <?php $_smarty_tpl->_assignInScope('t_lr_count', $_smarty_tpl->tpl_vars['t_lr_count']->value+$_smarty_tpl->tpl_vars['row']->value->lr_count);?>
                        <?php }?>
                    <?php
}
} else {
?>
                        <tr>
                            <td colspan="12" align="center">No Records Found</td>
                        </tr>
                    <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                </tbody>
                <?php $_smarty_tpl->_assignInScope('t_lr_d_count', $_smarty_tpl->tpl_vars['t_lr_count']->value);?>
                <?php $_smarty_tpl->_assignInScope('t_no_d_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value);?>
                <?php if (count($_smarty_tpl->tpl_vars['summary']->value)) {?>
                    <tfoot>
                        <tr class="active bold">
                            <td align="right">Total : </td>
                            <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_lr_count']->value;?>
</td>
                            <td align='right'><?php echo number_format($_smarty_tpl->tpl_vars['t_total_amount']->value,2);?>
</td>
                        </tr>
                    </tfoot>
                <?php }?>
            </table>
        </td>
        <td align="center">
            <table border="1" class="bordered" cellpadding="2">
                <thead>
                    <tr>
                        <th>Delivery Details :</th>
                        <th colspan="2"></th>
                    </tr>
                    <tr>
                        <th>Delivery Status</th>
                        <th>No. of GCN</th>
                        <th>Amount(Rs.)</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $_smarty_tpl->_assignInScope('t_total_amount', 0);?>
                    <?php $_smarty_tpl->_assignInScope('t_lr_count', 0);?>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'row', false, 'i');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->attribute_type == 'DELIVERY DETAILS') {?>
                            <tr>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->attribute_code;?>
</td>
                                <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->lr_count;?>
</td>
                                <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->amount;?>
</td>
                            </tr>
                            <?php $_smarty_tpl->_assignInScope('t_lr_count', $_smarty_tpl->tpl_vars['t_lr_count']->value+$_smarty_tpl->tpl_vars['row']->value->lr_count);?>
                            <?php $_smarty_tpl->_assignInScope('t_total_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value+$_smarty_tpl->tpl_vars['row']->value->amount);?>
                        <?php }?>
                    <?php
}
} else {
?>
                        <tr>
                            <td colspan="12" align="center">No Records Found</td>
                        </tr>
                    <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                </tbody>
                <?php if (count($_smarty_tpl->tpl_vars['summary']->value)) {?>
                    <tfoot>
                        <tr class="active bold">
                            <td align="right">Total : </td>
                            <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_lr_count']->value;?>
</td>
                            <td align='right'><?php echo number_format($_smarty_tpl->tpl_vars['t_total_amount']->value,2);?>
</td>
                        </tr>
                    </tfoot>
                <?php }?>
            </table>
        </td>
        <td align="right">
            <table border="1" class="bordered" cellpadding="2">
                <thead>
                    <tr>
                        <th>Return to branch :</th>
                        <th colspan="2"></th>
                    </tr>
                    <tr>
                        <th>Branch</th>
                        <th>No. of GCN</th>
                        <th>Amount(Rs.)</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $_smarty_tpl->_assignInScope('t_total_amount', 0);?>
                    <?php $_smarty_tpl->_assignInScope('t_re_lr_count', 0);?>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'row', false, 'i');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->attribute_type == 'RETURN_BRANCH') {?>
                            <tr>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->attribute_code;?>
</td>
                                <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->lr_count;?>
</td>
                                <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->amount;?>
</td>
                            </tr>
                            <?php $_smarty_tpl->_assignInScope('t_total_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value+$_smarty_tpl->tpl_vars['row']->value->amount);?>
                            <?php $_smarty_tpl->_assignInScope('t_re_lr_count', $_smarty_tpl->tpl_vars['t_re_lr_count']->value+$_smarty_tpl->tpl_vars['row']->value->lr_count);?>
                        <?php }?>
                    <?php
}
} else {
?>
                        <tr>
                            <td colspan="12" align="center">No Records Found</td>
                        </tr>
                    <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    <?php $_smarty_tpl->_assignInScope('t_no_lr_count', $_smarty_tpl->tpl_vars['t_lr_d_count']->value-$_smarty_tpl->tpl_vars['t_re_lr_count']->value);?>
                    <?php $_smarty_tpl->_assignInScope('t_no_amount', $_smarty_tpl->tpl_vars['t_no_d_amount']->value-$_smarty_tpl->tpl_vars['t_total_amount']->value);?>
                    <tr>
                        <?php if (count($_smarty_tpl->tpl_vars['summary']->value)) {?>
                            <td align="center">No Return</td>
                            <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_no_lr_count']->value;?>
</td>
                            <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_no_amount']->value;?>
</td>
                        <?php }?>
                    </tr>
                </tbody>
                <?php $_smarty_tpl->_assignInScope('t_tt_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value+$_smarty_tpl->tpl_vars['t_no_amount']->value);?>
                <?php $_smarty_tpl->_assignInScope('t_tt_lr_count', $_smarty_tpl->tpl_vars['t_no_lr_count']->value+$_smarty_tpl->tpl_vars['t_re_lr_count']->value);?>
                <?php if (count($_smarty_tpl->tpl_vars['summary']->value)) {?>
                    <tfoot>
                        <tr class="active bold">
                            <td align="right">Total : </td>
                            <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_tt_lr_count']->value;?>
</td>
                            <td align='right'><?php echo number_format($_smarty_tpl->tpl_vars['t_tt_amount']->value,2);?>
</td>
                        </tr>
                    </tfoot>
                <?php }?>
            </table>
        </td>
    </tr>
</table>
<br>
<table border="1" class="bordered" width="80%" align="center">
    <thead>
        <tr>
            <th>Collection Details :</th>
            <th colspan="6"></th>
        </tr>
        <tr>
            <th>Mode of Payment</th>
            <th>Total LR</th>
            <th>Total LR Amount (Rs.)</th>
            <th>Payment Received LR</th>
            <th>Payment Received LR Amount (Rs.)</th>
            <th>Pending LR</th>
            <th>Pending LR Amount (Rs.)</th>
        </tr>
    </thead>
    <tbody>
        <?php $_smarty_tpl->_assignInScope('t_total_amount', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_lr_count', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_received_lr_count', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_amount', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_pending_lr_count', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_pending_amount', 0);?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'row', false, 'i');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
            <?php if ($_smarty_tpl->tpl_vars['row']->value->attribute_type == 'PAYMENT_RECEIVED_LR') {?>
                <tr>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->attribute_code;?>
</td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->lr_count;?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_amount);?>
</td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->received_lr_count;?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->amount);?>
</td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->pending_lr_count;?>
</td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->pending_amount;?>
</td>
                </tr>
                <?php $_smarty_tpl->_assignInScope('t_lr_count', $_smarty_tpl->tpl_vars['t_lr_count']->value+$_smarty_tpl->tpl_vars['row']->value->lr_count);?>
                <?php $_smarty_tpl->_assignInScope('t_total_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                <?php $_smarty_tpl->_assignInScope('t_received_lr_count', $_smarty_tpl->tpl_vars['t_received_lr_count']->value+$_smarty_tpl->tpl_vars['row']->value->received_lr_count);?>
                <?php $_smarty_tpl->_assignInScope('t_amount', $_smarty_tpl->tpl_vars['t_amount']->value+$_smarty_tpl->tpl_vars['row']->value->amount);?>
                <?php $_smarty_tpl->_assignInScope('t_pending_lr_count', $_smarty_tpl->tpl_vars['t_pending_lr_count']->value+$_smarty_tpl->tpl_vars['row']->value->pending_lr_count);?>
                <?php $_smarty_tpl->_assignInScope('t_pending_amount', $_smarty_tpl->tpl_vars['t_pending_amount']->value+$_smarty_tpl->tpl_vars['row']->value->pending_amount);?>

            <?php }?>
        <?php
}
} else {
?>
            <tr>
                <td colspan="7" align="center">No Records Found</td>
            </tr>
        <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </tbody>
    <?php if (count($_smarty_tpl->tpl_vars['summary']->value)) {?>
        <tfoot>
            <tr class="active bold">
                <td align="right">Total : </td>
                <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_lr_count']->value;?>
</td>
                <td align='right'><?php echo number_format($_smarty_tpl->tpl_vars['t_total_amount']->value,2);?>
</td>
                <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_received_lr_count']->value;?>
</td>
                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_amount']->value,2);?>
</td>
                <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_pending_lr_count']->value;?>
</td>
                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_pending_amount']->value,2);?>
</td>
            </tr>
        </tfoot>
    <?php }?>
</table>

<style>
    .bold {
        /* font-weight: bold; */
        font-family: Arial, Helvetica, sans-serif;
        font-weight: normal;
        font-size: 0.9em;
        margin: 1px;
        padding: 0;
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

    @page {
        size: A4 landscape;
    }
</style>

<?php echo '<script'; ?>
>
    window.print();
<?php echo '</script'; ?>
><?php }
}
