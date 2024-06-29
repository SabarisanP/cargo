<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-07 10:30:49
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\branch-sales-summary-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66629401cf2240_45967980',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '5a2c19586bb788856e1a6ef1d07ce15f33b11aaa' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\branch-sales-summary-list.tpl',
      1 => 1717736397,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66629401cf2240_45967980 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Branch Sales Summary</span></td>
    </tr>
    <tr>
        <td width="50%">
            <b>From</b>  <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['from']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
  <b>To</b> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['to']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> <?php echo date("Y-m-d h:i:s A");?>

        </td>
    </tr>
</table>

<br>
<table id="branch_due_report_table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <td align="center">Booking Branch</td>
            <td align="center">Date</td>
            <td align="center">No Of Lrs</td>
            <td align="center">No Of Art</td>
            <td align="center">Freight Amount <br>(A)</td>
            <td align="center">Pass Charge <br>(B)</td>
            <td align="center">Loading Charges <br>(C)</td>
            <td align="center">Unloading Charges <br>(D)</td>
            <td align="center">Other Charges <br>(E)</td>
            <td align="center">Net Amount <br>(F1 = A+B+C+D+E)</td>
            <td align="center">SGST <br>(G)</td>
            <td align="center">CGST <br>(H)</td>
            <td align="center">IGST <br>(I)</td>
            <td align="center">Round Off <br>(J)</td>
            <td align="center">Total <br>(F2 = F1+G+H+I)</td>
            <td align="center">Paid</td>
            <td align="center">Topay</td>
            <td align="center">OnAccount</td>
        </tr>
    </thead>
    <tbody>
   
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'rows');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['rows']->value) {
?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['rows']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align="left" nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value['from_organization_name'];?>
</td>
                    <td align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value['booked_at'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                    <td align="right"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['cargo_count'],$_smarty_tpl->tpl_vars['t_cargo_count']->value);?>
</td>
                    <td align="right"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['total_item_count'],$_smarty_tpl->tpl_vars['t_item_count']->value);?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['total_amount'],$_smarty_tpl->tpl_vars['t_total_amount']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['pass_charge'],$_smarty_tpl->tpl_vars['t_pass_charge']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['total_handling_amount'],$_smarty_tpl->tpl_vars['t_total_handling_amount']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['total_unload_handling_amount'],$_smarty_tpl->tpl_vars['t_total_unload_handling_amount']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma(($_smarty_tpl->tpl_vars['row']->value['other_charges_amount']+$_smarty_tpl->tpl_vars['row']->value['docket_charge']),$_smarty_tpl->tpl_vars['t_other_charges_amount']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['net_amount'],$_smarty_tpl->tpl_vars['t_net_amount']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['sgst'],$_smarty_tpl->tpl_vars['t_sgst']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['cgst'],$_smarty_tpl->tpl_vars['t_cgst']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['igst'],$_smarty_tpl->tpl_vars['t_igst']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['round_off_value'],$_smarty_tpl->tpl_vars['t_round']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['net_total_amount'],$_smarty_tpl->tpl_vars['t_net_total_amount']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma((($tmp = @$_smarty_tpl->tpl_vars['row']->value['PAD'])===null||$tmp==='' ? 0 : $tmp),$_smarty_tpl->tpl_vars['t_PAD']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma((($tmp = @$_smarty_tpl->tpl_vars['row']->value['TOP'])===null||$tmp==='' ? 0 : $tmp),$_smarty_tpl->tpl_vars['t_TOP']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma((($tmp = @$_smarty_tpl->tpl_vars['row']->value['INP'])===null||$tmp==='' ? 0 : $tmp),$_smarty_tpl->tpl_vars['t_INP']->value));?>
</td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php if (count($_smarty_tpl->tpl_vars['result']->value) > 1) {?>
            <tr class="active bold">
                <td align="right"></td>
                <td align="right">Total</td>
                <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_cargo_count']->value;?>
</td>
                <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_item_count']->value;?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_total_amount']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_pass_charge']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_total_handling_amount']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_total_unload_handling_amount']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_other_charges_amount']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_net_amount']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_sgst']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_cgst']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_igst']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_round']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_net_total_amount']->value);?>
</td>
                <td align="right"><?php echo inr_format((($tmp = @$_smarty_tpl->tpl_vars['t_PAD']->value)===null||$tmp==='' ? 0 : $tmp));?>
</td>
                <td align="right"><?php echo inr_format((($tmp = @$_smarty_tpl->tpl_vars['t_TOP']->value)===null||$tmp==='' ? 0 : $tmp));?>
</td>
                <td align="right"><?php echo inr_format((($tmp = @$_smarty_tpl->tpl_vars['t_INP']->value)===null||$tmp==='' ? 0 : $tmp));?>
</td>
            </tr>
        <?php }?>
    </tbody>
</table>
<?php }
}
