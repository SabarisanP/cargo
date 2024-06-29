<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-27 17:06:57
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\dashboard-branch-stock-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665470594005c5_78885149',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'b83840c4c71080148e7eb7b6bd1210acdc35c774' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\dashboard-branch-stock-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665470594005c5_78885149 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="popup_top">
    <div class="row">
        <div class="col-md-5 ft_14">
            <span class="bold"> <?php echo lang(('branch_stock_status_').($_smarty_tpl->tpl_vars['cargoStatusCode']->value));?>
 </span> : <?php echo $_smarty_tpl->tpl_vars['organization_name']->value;?>

        </div>
        <div class="col-md-5">
            <span class="bold">Total <?php echo lang('lr');?>
</span> : <?php echo count($_smarty_tpl->tpl_vars['result']->value);?>
 &nbsp;
            <span class="bold">Total Articles </span> : <?php echo $_smarty_tpl->tpl_vars['article_count']->value;?>
 
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeDashReportDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>



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
            <td align="center">Hub Activity</td>
            <td align="center">No. Of Articles</td>
            <td align="center">Qty</td>
            <td align="center">Freight</td>
            <?php if ($_smarty_tpl->tpl_vars['cargo_status_code']->value == 'CMS') {?>
                <td align="center">Reg No. / <?php echo lang('ogpl');?>
</td>
                <td align="center">Updated By</td>
                <td align="center">Updated At</td>
            <?php }?>
        </tr>
    </thead>
    <tbody class="body_table">
        <?php $_smarty_tpl->_assignInScope('t_item_count', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_total_item_count', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_total_amount', 0);?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
            <tr>
                <td><?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
</td>
                <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
                <td align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->transit_organization_name ? $_smarty_tpl->tpl_vars['row']->value->transit_organization_name : '-';?>
</td>
                <td align="left">
                    <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_type_code);?>

                </td>
                <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
</td>
                <td align="center">
                    <?php if ($_smarty_tpl->tpl_vars['row']->value->hub_transit_tag) {?>
                        <?php $_smarty_tpl->_assignInScope('hubflags', comma_split($_smarty_tpl->tpl_vars['row']->value->hub_transit_tag));?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['hubflags']->value, 'flag');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['flag']->value) {
?>
                            <?php if ($_smarty_tpl->tpl_vars['flag']->value == 'HL') {?>
                                <span class="badge badge-secondary">Hub.L</span> 
                            <?php } elseif ($_smarty_tpl->tpl_vars['flag']->value == 'HU') {?>
                                <span class="badge badge-secondary">Hub.UL</span>
                            <?php }?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>                        
                    <?php } else { ?>
                        -
                    <?php }?>
                </td>
                <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->item_count;?>
</td>
                <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_amount);?>
</td>
                <?php if ($_smarty_tpl->tpl_vars['cargo_status_code']->value == 'CMS') {?>
                    <td align="left"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->registration_number)===null||$tmp==='' ? '-' : $tmp);?>
 <br/><small class="text-muted" title="<?php echo lang('ogpl');?>
 Code"><?php echo isNotNull($_smarty_tpl->tpl_vars['row']->value->alias_code) ? $_smarty_tpl->tpl_vars['row']->value->alias_code : '';?>
</small></td>
                    <td align="left"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->status_updated_user_name)===null||$tmp==='' ? '-' : $tmp);?>
 <br/><small class="text-muted" title="Branch"><?php echo $_smarty_tpl->tpl_vars['row']->value->status_updated_organization_name;?>
</small></td>
                    <td align="left" nowrap><?php echo isNotNull($_smarty_tpl->tpl_vars['row']->value->status_updated_at) ? (smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->status_updated_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value)) : '-';?>
</td>
                <?php }?>
            </tr>
            
            <?php $_smarty_tpl->_assignInScope('t_item_count', $_smarty_tpl->tpl_vars['t_item_count']->value+$_smarty_tpl->tpl_vars['row']->value->item_count);?>
            <?php $_smarty_tpl->_assignInScope('t_total_item_count', $_smarty_tpl->tpl_vars['t_total_item_count']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
            <?php $_smarty_tpl->_assignInScope('t_total_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
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

        <?php if (count($_smarty_tpl->tpl_vars['result']->value)) {?>
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td colspan="9" align="right"><b>Total</b></td>
                <td align='right'><?php echo $_smarty_tpl->tpl_vars['t_item_count']->value;?>
</td>
                <td align='right'><?php echo $_smarty_tpl->tpl_vars['t_total_item_count']->value;?>
</td>
                <td align='right'><?php echo inr_format($_smarty_tpl->tpl_vars['t_total_amount']->value);?>
</td>
                <?php if ($_smarty_tpl->tpl_vars['cargo_status_code']->value == 'CMS') {?>
                    <td colspan="3" align="right"></td>
                <?php }?>
            </tr>
        <?php }?>
    </tbody>
</table><?php }
}
