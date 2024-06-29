<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-05 18:24:00
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\dashboard-lr-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66605fe87b69c6_27840015',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'f666df10c887dc61106050f7f05d2a934cadec2e' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\dashboard-lr-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66605fe87b69c6_27840015 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="popup_top">
    <div class="row">
                <div class="col-md-10">
            <span class="bold">Total <?php echo lang('lr');?>
</span> : <?php echo count($_smarty_tpl->tpl_vars['result']->value);?>

        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeDashLrListDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>
<?php if (empty($_smarty_tpl->tpl_vars['result']->value)) {?>
    <div class="alert alert-danger">Invalid <?php echo lang('lr');?>
 Code</div>
<?php } else { ?>
<table class="table table-bordered" width="98%">
    <thead>
        <tr class="success">
            <td align="center">S.No</td>
            <td align="center"><?php echo lang('cargo_code_term');?>
</td>
            <td align="center">Booked Date</td>
            <td align="center"><?php echo lang('booking_from_term');?>
</td>
            <td align="center"><?php echo lang('booking_to_label');?>
</td>
            <td align="center">Transit Branch</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
        </tr>
    </thead>
    <tbody class="body_table">
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
            <tr>
                <td><?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
</td>
                <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
</a></td>
                <td align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->fromOrganization->name;?>
</td>
                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->toOrganization->name;?>
</td>
                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->transitOrganization->name ? $_smarty_tpl->tpl_vars['row']->value->transitOrganization->name : '-';?>
</td>
                <td align="left">
                    <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->paymentType->code);?>

                </td>
                <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargoStatus->code];?>
</td>
            </tr>
        <?php
}
} else {
?>
            <tr>
                <td colspan="100%" align="center">No Records Found!</td>
            </tr>
        <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </tbody>
</table>
<?php }
}
}
