<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-14 10:25:23
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\user-tds-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666bcd3b664f07_45834599',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'd1fcbeb9b0e5a86ede9146725e6553458430df0c' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\user-tds-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666bcd3b664f07_45834599 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="table-responsive">
    <table id="usr_tds_table" class="table table-striped">
        <thead>
            <tr>
                <th>Effective From</th>
                <th>TDS</th>
                <th>PAN Number</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody class="tds body_table">
            <?php if ($_smarty_tpl->tpl_vars['tds']->value->tdsTaxValue) {?>
                <tr>
                    <td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['tds']->value->fromDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                    <td><?php echo $_smarty_tpl->tpl_vars['tds']->value->tdsTaxValue;?>
</td>
                    <td><?php echo $_smarty_tpl->tpl_vars['tds']->value->panCardCode;?>
</td>
                    <td>
                        <a class='btn btn-default btn-xs'  title='delete' onclick="deleteUserTds('<?php echo $_smarty_tpl->tpl_vars['tds']->value->user->code;?>
')">
                            <i class='fa fa-trash'></i>
                        </a>
                    </td>
                </tr>
            <?php } else { ?>
                <tr>
                    <td colspan="4" align="center">No TDS configured</td>
                </tr>
            <?php }?>
        </tbody>
    </table>
</div>

<?php echo '<script'; ?>
>
    var userTDSData = <?php echo json_encode($_smarty_tpl->tpl_vars['tds']->value);?>

<?php echo '</script'; ?>
>
<?php }
}
