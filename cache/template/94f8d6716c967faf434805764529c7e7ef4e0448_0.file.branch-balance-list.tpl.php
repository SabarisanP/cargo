<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-28 12:51:03
  from 'E:\xampp\htdocs\cargo\application\views\site\widgets\branch-balance-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665585df787863_65376637',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '94f8d6716c967faf434805764529c7e7ef4e0448' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\widgets\\branch-balance-list.tpl',
      1 => 1716451522,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665585df787863_65376637 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table class="table">
    <thead class="bold">
        <tr>
            <td class="sticky-row-top">Branch</td>
            <td class="sticky-row-top">Last Closed Time</td>
            <td class="sticky-row-top" align="right">Balance</td>
        </tr>
    </thead>
    <tbody>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value->data, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
            <tr>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value->user->organization->name;?>
</td>
                <td><?php echo time_elapsed_string($_smarty_tpl->tpl_vars['row']->value->closingDateTime);?>
</td>
                <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value->currentBalance,$_smarty_tpl->tpl_vars['t_current_balance']->value));?>
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
        <?php if (count($_smarty_tpl->tpl_vars['result']->value->data)) {?>
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
    $('#branchbal-last-updated-at').html('(As on <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['result']->value->datetime,$_smarty_tpl->tpl_vars['ns_time_format']->value);?>
)');
<?php echo '</script'; ?>
>
<?php }
}
