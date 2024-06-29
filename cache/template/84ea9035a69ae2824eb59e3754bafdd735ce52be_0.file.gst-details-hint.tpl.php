<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-19 11:26:34
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\gst-details-hint.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66727312a8ac73_81998908',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '84ea9035a69ae2824eb59e3754bafdd735ce52be' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\gst-details-hint.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66727312a8ac73_81998908 (Smarty_Internal_Template $_smarty_tpl) {
if ($_smarty_tpl->tpl_vars['data']->value->status != 1) {?>
    <div class="text-danger small"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['data']->value->errorDesc)===null||$tmp==='' ? 'Unknown Exception' : $tmp);?>
</div>
<?php } else { ?>
    <?php $_smarty_tpl->_assignInScope('data', $_smarty_tpl->tpl_vars['data']->value->data);?>
    <div title="Trade Name"><?php echo $_smarty_tpl->tpl_vars['data']->value->tradeName;?>
</div>

    <?php if ($_smarty_tpl->tpl_vars['data']->value->blockStatus == 'B') {?>
        <div class="label label-danger" title="Block Status"><?php echo $_smarty_tpl->tpl_vars['gstin_block_status']->value[$_smarty_tpl->tpl_vars['data']->value->blockStatus];?>
</div>
    <?php }?>

    <?php if ($_smarty_tpl->tpl_vars['data']->value->status == 'ACT') {?>
        <div class="label label-success" title="GST Status"><?php echo $_smarty_tpl->tpl_vars['gstin_status']->value[$_smarty_tpl->tpl_vars['data']->value->status];?>
</div>
    <?php } elseif ($_smarty_tpl->tpl_vars['data']->value->status == 'CNL') {?>
        <div class="label label-danger" title="GST Status"><?php echo $_smarty_tpl->tpl_vars['gstin_status']->value[$_smarty_tpl->tpl_vars['data']->value->status];?>
</div>
    <?php } elseif ($_smarty_tpl->tpl_vars['data']->value->status == 'INA') {?>
        <div class="label label-warning" title="GST Status"><?php echo $_smarty_tpl->tpl_vars['gstin_status']->value[$_smarty_tpl->tpl_vars['data']->value->status];?>
</div>
    <?php } elseif ($_smarty_tpl->tpl_vars['data']->value->status == 'PRO') {?>
        <div class="label label-secondary" title="GST Status"><?php echo $_smarty_tpl->tpl_vars['gstin_status']->value[$_smarty_tpl->tpl_vars['data']->value->status];?>
</div>
    <?php } else { ?>
        <div class="label label-secondary" title="GST Status"><?php echo $_smarty_tpl->tpl_vars['gstin_status']->value[$_smarty_tpl->tpl_vars['data']->value->status];?>
</div>
    <?php }?>

    <div class="label label-info" title="Tax Payer Type"><?php echo $_smarty_tpl->tpl_vars['gstin_taxpayer_type']->value[$_smarty_tpl->tpl_vars['data']->value->taxPayerType];?>
</div>
<?php }
}
}
