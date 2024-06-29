<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-31 19:10:22
  from 'E:\xampp\htdocs\cargo\application\views\site\config\query-window-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6659d3463cdfe8_43644857',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'a103102a492e8ecb9fcab1b5f86bba9fa90aef54' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\config\\query-window-list.tpl',
      1 => 1716451517,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6659d3463cdfe8_43644857 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.replace.php','function'=>'smarty_modifier_replace',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.capitalize.php','function'=>'smarty_modifier_capitalize',),));
if ($_REQUEST['export'] == 1) {?>
    <style>
        .success {
            font-weight: bold;
            background-color:#64b92a;
            color: #fff;
        }
    </style>
<?php }?>

<?php if ($_smarty_tpl->tpl_vars['result']->value->status != 1) {?>
    <div class="alert alert-danger"><?php echo $_smarty_tpl->tpl_vars['result']->value->errorDesc;?>
</div>
<?php } elseif (count($_smarty_tpl->tpl_vars['result']->value->data) == 0) {?>
    <div class="alert alert-danger">No records Found</div>
<?php } else { ?>
    <div class="table-responsive">
        <table class="table table-bordered" id="query-list">
            <thead>
                <tr class="success">
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value->data[0], 'value', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['value']->value) {
?>
                        <th><?php echo smarty_modifier_capitalize(smarty_modifier_replace($_smarty_tpl->tpl_vars['key']->value,'_',' '));?>
</th>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                </tr>
            </thead>
            <tbody class="body_table">
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value->data, 'value', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['value']->value) {
?>
                    <tr>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['value']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <td nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value;?>
</td>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tr>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </tbody>
        </table>
    </div>

    <?php if ($_REQUEST['export'] != 1) {?>
        <?php echo '<script'; ?>
>
            $('#query-list').dataTable({
                pageLength: -1,
                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, 'All']],
                sDom: '<"well well-sm"<"row"<"col-md-4 clearfix"l><"col-md-8 clearfix"f>r>>' +
                      '<"overflow-x-auto"t>' +
                      '<"row"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>'
            });
        <?php echo '</script'; ?>
>
    <?php }
}
}
}
