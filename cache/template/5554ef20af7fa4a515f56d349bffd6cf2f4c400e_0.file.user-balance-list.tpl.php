<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-25 18:37:00
  from 'E:\xampp\htdocs\cargo\application\views\site\widgets\user-balance-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6651e274ae18e6_48658786',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '5554ef20af7fa4a515f56d349bffd6cf2f4c400e' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\widgets\\user-balance-list.tpl',
      1 => 1716451521,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6651e274ae18e6_48658786 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table class="table">
    <thead class="bold">
        <tr>
            <td class="sticky-row-top">User</td>
            <td class="sticky-row-top">Last Transaction Time</td>
            <td class="sticky-row-top" align="right">Balance</td>
        </tr>
    </thead>
    <tbody>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
            <tr>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value->first_name;?>
</td>
                <td title="<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->last_transaction_date,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
"><?php echo time_elapsed_string($_smarty_tpl->tpl_vars['row']->value->last_transaction_date);?>
</td>
                <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value->current_balance,$_smarty_tpl->tpl_vars['t_current_balance']->value));?>
</td>
            </tr>
        <?php
}
} else {
?>
            <tr>
                <td colspan="3" align="center">No details found</td>
            </tr>
        <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php if (count($_smarty_tpl->tpl_vars['result']->value)) {?>
            <tr>
                <td class="sticky-row-bottom" align="left" colspan="2"><b>Total</b></td>
                <td class="sticky-row-bottom" align="right"><b><?php echo inr_format($_smarty_tpl->tpl_vars['t_current_balance']->value);?>
</b></td>
            </tr>
        <?php }?>
    </tbody>
</table>

<?php echo '<script'; ?>
>
    $('#userbal-last-updated-at').html('(As on <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['as_on_time']->value,$_smarty_tpl->tpl_vars['ns_time_format']->value);?>
)');
<?php echo '</script'; ?>
>
<?php }
}
