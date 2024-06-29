<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-15 10:49:40
  from 'E:\xampp\htdocs\cargo\application\views\site\report\pending-current-door-delivery-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666d246c7daea5_44824837',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '322f2281ea79ce527254f58b3adc817c5f934a74' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\pending-current-door-delivery-report-list.tpl',
      1 => 1716451517,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666d246c7daea5_44824837 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><b>Pending & Current Door Delivery Report</b></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Date :</span><?php echo smarty_modifier_date_format($_REQUEST['date'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> <?php echo date("Y-m-d h:i:s A");?>

        </td>
    </tr>
</table>
<br>
<div class="overflow-x-auto">
    <table id="cargo_revenue_report_table" class="table table-bordered " style="width:99%">
        <thead>
            <tr class="success">
                <th>S.No</th>
                <th>NAME</th>
                <th>FROM PLACE</th>
                <th>LR DATE</th>
                <th>ARTICLES</th>
                <th>LR NO</th>
                <th>MODE OF PAYMENT</th>
                <th>TAKEN BY VEHICLENO</th>
                <th>BILLCOLLECTION</th>
                <th>AMOUNT</th>
            </tr>
        </thead>
        <tbody class="body_table">

            <?php $_smarty_tpl->_assignInScope('t_total_amount', 0);?>
        
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['details']->value, 'row', false, 'i');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['i']->value+1;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_name;?>
</td>
                    <td align="left"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->articles;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->payment_status_code];?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->registration_number;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->bill_collection;?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value->total_amount,$_smarty_tpl->tpl_vars['t_total_amount']->value));?>
</td>
                </tr>
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
        <?php if (count($_smarty_tpl->tpl_vars['details']->value)) {?>
            <tfoot>
                <tr class="active bold">
                    <td colspan="9" align="right">Total</td>
                    <td align='right' colspan="1"><?php echo number_format($_smarty_tpl->tpl_vars['t_total_amount']->value,2);?>
</td>
                </tr>
            </tfoot>
        <?php }?>
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoEditReport();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="DeliveryReportPrint();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div><?php }
}
