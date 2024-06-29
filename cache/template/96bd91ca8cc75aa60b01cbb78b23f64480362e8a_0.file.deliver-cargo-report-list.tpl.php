<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-28 13:23:28
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\deliver-cargo-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66558d78bbeed2_97962149',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '96bd91ca8cc75aa60b01cbb78b23f64480362e8a' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\deliver-cargo-report-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66558d78bbeed2_97962149 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="table-responsive">
    <table class="table table-bordered" width="98%" id="deliver-cargo-table">
        <thead>
            <tr class="success">
                <td align="center">Date of Booking</td>
                <td align="center">Date of Unloading</td>
                <td align="center"><?php echo lang('lr');?>
 Number</td>
                <td align="center">Consignor</td>
                <td align="center">Consignee</td>
                <td align="center">No. of Articles</td>
                <td align="center">Type of Packaging</td>
                <td align="center">Mode Of Payment</td>
                <td align="center">Type of Delivery</td>
            </tr>
        </thead>
        <tbody class="body_table">
            <?php $_smarty_tpl->_assignInScope('t_item_count', 0);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align="left"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,'d, M g:i A');?>
</td>
                    <td align="left" data-order="<?php echo strtotime($_smarty_tpl->tpl_vars['row']->value->unloaded_at);?>
"><?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->unloaded_at)) {
echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->unloaded_at,'d, M g:i A');
} else { ?>-<?php }?></td>
                    <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
                    <td align="left" width="12%">
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
<br>
                        <span class="text-muted"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_mobile;?>
</span>
                    </td>
                    <td align="left" width="12%">
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
<br>
                        <span class="text-muted"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_mobile;?>
</span>
                    </td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->item_count;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                    <td align="left">
                        <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_type_code);?>

                    </td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['row']->value->delivery_type_code];?>
</td>
                </tr>
                <?php $_smarty_tpl->_assignInScope('t_item_count', $_smarty_tpl->tpl_vars['t_item_count']->value+$_smarty_tpl->tpl_vars['row']->value->item_count);?>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
    </table>
</div>

<?php echo '<script'; ?>
>
    $('#deliver-cargo-table').DataTable({
        paging : false,
        order: [1, 'asc']
    });
<?php echo '</script'; ?>
>
<?php }
}
