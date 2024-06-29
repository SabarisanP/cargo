<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-25 18:33:57
  from 'E:\xampp\htdocs\cargo\application\views\site\template\print-ticket-dialog.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6651e1bd6407e2_08279130',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '05fbc2a5518e052368e6537086683f0a87e0b3d1' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\template\\print-ticket-dialog.tpl',
      1 => 1716451522,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6651e1bd6407e2_08279130 (Smarty_Internal_Template $_smarty_tpl) {
?><div id="print-tkt-dialog" class="hide">
    <a href="javascript:;" class="pull-right" onclick="closePrintTktWindow();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div id="print-tkt-iframe" style="height:95%;width:100%;">
        <iframe src="" url="<?php echo $_smarty_tpl->tpl_vars['pdf_generator_url']->value;?>
" style="height:99%;width:100%;border:0px;"></iframe>
    </div>
</div><?php }
}
