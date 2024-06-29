<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-14 10:25:23
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\user-branches-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666bcd3b5cb472_79576699',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'fe40b6ce9cddf10d69564780bf4c7fb6f7299b60' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\user-branches-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666bcd3b5cb472_79576699 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="table-responsive">
    <table id="cargo_user_branches_table" class="table table-striped">
        <thead>
            <tr>
                <th>Branch</th>
                <th></th>
            </tr>
        </thead>
        <tbody class="body_table">
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</td>
                    <td align="center">
                        <a title="Remove Branch" href="javascript:;" class="btn btn-default btn-xs" onclick="removeUserBranch('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
')"><i class="fa fa-times"></i></a>
                    </td>
                </tr>
            <?php
}
} else {
?>
                <tr>
                    <td colspan="100%" align="center">No records Found</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
    </table>
</div><?php }
}
