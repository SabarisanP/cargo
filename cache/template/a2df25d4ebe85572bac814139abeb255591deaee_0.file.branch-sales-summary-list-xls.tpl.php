<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-06 12:36:41
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\branch-sales-summary-list-xls.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666160015e2202_31293540',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'a2df25d4ebe85572bac814139abeb255591deaee' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\branch-sales-summary-list-xls.tpl',
      1 => 1717657346,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666160015e2202_31293540 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table>
    <tr>
        <td colspan="6" align="center"><b>Branch Sales Summary</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>From</b>&nbsp;<?php echo smarty_modifier_date_format($_REQUEST['from'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
&nbsp;<b>To</b>&nbsp;<?php echo smarty_modifier_date_format($_REQUEST['to'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; <?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>
 </td>
    </tr>
</table>

<table width="100%">
    <thead>
        <tr>
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
            <td align="center">Docket Charges <br>(J)</td>
            <td align="center">Round Off <br>(K)</td>
            <td align="center">Total <br>(F2 = F1+G+H+I)</td>
            <td align="center">Paid</td>
            <td align="center">Topay</td>
            <td align="center">OnAccount</td>
        </tr>
    </thead>
    <tbody>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
            <tr>
                <td align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value['booked_at'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['cargo_count'],$_smarty_tpl->tpl_vars['t_cargo_amount']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['total_item_count'],$_smarty_tpl->tpl_vars['t_item_count']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['total_amount'],$_smarty_tpl->tpl_vars['t_total_amount']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['pass_charge'],$_smarty_tpl->tpl_vars['t_pass_charge']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['total_handling_amount'],$_smarty_tpl->tpl_vars['t_total_handling_amount']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['total_unload_handling_amount'],$_smarty_tpl->tpl_vars['t_total_unload_handling_amount']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['other_charges_amount'],$_smarty_tpl->tpl_vars['t_other_charges_amount']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['net_amount'],$_smarty_tpl->tpl_vars['t_net_amount']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['sgst'],$_smarty_tpl->tpl_vars['t_sgst']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['cgst'],$_smarty_tpl->tpl_vars['t_cgst']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['igst'],$_smarty_tpl->tpl_vars['t_igst']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['docket_charge'],$_smarty_tpl->tpl_vars['t_docket_ch']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['round_off_value'],$_smarty_tpl->tpl_vars['t_round']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['net_total_amount'],$_smarty_tpl->tpl_vars['t_net_total_amount']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma((($tmp = @$_smarty_tpl->tpl_vars['row']->value['PAD'])===null||$tmp==='' ? 0 : $tmp),$_smarty_tpl->tpl_vars['t_PAD']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma((($tmp = @$_smarty_tpl->tpl_vars['row']->value['TOP'])===null||$tmp==='' ? 0 : $tmp),$_smarty_tpl->tpl_vars['t_TOP']->value);?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma((($tmp = @$_smarty_tpl->tpl_vars['row']->value['INP'])===null||$tmp==='' ? 0 : $tmp),$_smarty_tpl->tpl_vars['t_INP']->value);?>
</td>
            </tr>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php if (count($_smarty_tpl->tpl_vars['result']->value) > 1) {?>
            <tfoot>
                <tr class="active">
                    <td align="right">Total</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_cargo_amount']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_item_count']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_total_amount']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_pass_charge']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_total_handling_amount']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_total_unload_handling_amount']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_other_charges_amount']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_net_amount']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_sgst']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_cgst']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_igst']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_docket_ch']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_round']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['t_net_total_amount']->value;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['t_PAD']->value)===null||$tmp==='' ? 0 : $tmp);?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['t_TOP']->value)===null||$tmp==='' ? 0 : $tmp);?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['t_INP']->value)===null||$tmp==='' ? 0 : $tmp);?>
</td>
                </tr>
            </tfoot>
        <?php }?>
    </tbody>
</table>
<?php }
}
