<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-29 10:27:09
  from 'E:\xampp\htdocs\cargo\application\views\site\widgets\vendor-booking-summary.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6656b5a54e23d5_37117768',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '3151e300b7fb17c772b21e3b9a8469e3d430f65e' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\widgets\\vendor-booking-summary.tpl',
      1 => 1716451521,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6656b5a54e23d5_37117768 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="popup_top sticky-row-top">
    <div class="row">
        <div class="col-md-10 ft_14">
            <span class="bold">Vendor Booking Summary</span>
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeSummaryReportDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>

<table class="table table-bordered" width="98%" id="vendor-summary-table">
    <thead>
        <tr class="success">
            <td class="sticky-row-top" align="center">S.No</td>
            <td class="sticky-row-top" align="center">Vendor</td>
            <td class="sticky-row-top" align="center">Vendor Company</td>
            <td class="sticky-row-top" align="center">Cargo Count</td>
            <td class="sticky-row-top" align="center">Total Amount</td>
            <td class="sticky-row-top" align="center">Other Charges</td>
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
                <td align="left"><a href="javascript:;" onclick="showVendorReportDialog('<?php echo $_smarty_tpl->tpl_vars['row']->value->vendor_code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->vendor_name;?>
')"><?php echo $_smarty_tpl->tpl_vars['row']->value->vendor_name;?>
</a></td>
                <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->vendor_company;?>
</td>
                <td align="right"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value->cargo_count,$_smarty_tpl->tpl_vars['cargo_count']->value);?>
</td>
                <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value->total_amount,$_smarty_tpl->tpl_vars['total_amount']->value));?>
</td>
                <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value->other_charges_amonut,$_smarty_tpl->tpl_vars['other_charges_amonut']->value));?>
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

        <?php if (count($_smarty_tpl->tpl_vars['result']->value)) {?>
            <tr class="active">
                <td colspan="3" align="right"><b>Total</b></td>
                <td align="right"><?php echo $_smarty_tpl->tpl_vars['cargo_count']->value;?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['total_amount']->value);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['other_charges_amonut']->value);?>
</td>
            </tr>
        <?php }?>
    </tbody>
</table>

<style>
    #vendor-summary-table .sticky-row-top {
        top: 25px;
    }
    .popup_top.sticky-row-top {
        padding-top: 1em;
        margin-top: -1em;
        top: -1em;
    }
</style><?php }
}
