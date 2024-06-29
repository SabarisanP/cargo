<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-05 14:36:35
  from 'E:\xampp\htdocs\cargo\application\views\site\report\branch-sales-summary-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66602a9b3daeb8_33851127',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '079e436eb172e69051c05cab212074875acef282' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\branch-sales-summary-report-list.tpl',
      1 => 1716451519,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66602a9b3daeb8_33851127 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table width="95%">
    <tr>
        <td width="50%">
            From  <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['fromDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
  To <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['toDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> <?php echo date("d-m-Y h:i:s A");?>

        </td>
    </tr>
</table>
        
<?php $_smarty_tpl->_assignInScope('tot_paid', 0);
$_smarty_tpl->_assignInScope('tot_topay', 0);
$_smarty_tpl->_assignInScope('paid_lrcount', 0);
$_smarty_tpl->_assignInScope('topay_lrcount', 0);
$_smarty_tpl->_assignInScope('tot_net_amt', 0);?>
<div class="table-responsive">
    <table class="table table-bordered widthed">
        <thead>
            <tr class="success">                
                <td>Branch</td>
                <td>Lr Count</td>
                <td>Paid Amount</td>
                <td>Lr Count</td>
                <td>To Pay Amount</td>
                <td>Total Amount</td>           
            </tr>
        </thead>
        <tbody class="body_table">               
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td>
                        <a href="javascript:;" onclick="getBranchSalesDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->organization_code;?>
', '<?php echo $_smarty_tpl->tpl_vars['fromDate']->value;?>
', '<?php echo $_smarty_tpl->tpl_vars['toDate']->value;?>
')"><?php echo $_smarty_tpl->tpl_vars['row']->value->organization_name;?>
</a>
                    </td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->paid_cargo_count;?>
</td>

                    <?php $_smarty_tpl->_assignInScope('paid', $_smarty_tpl->tpl_vars['row']->value->paid_booking_amount);?>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['paid']->value,2);?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->topay_delivery_count;?>
</td>

                    <?php $_smarty_tpl->_assignInScope('topay', $_smarty_tpl->tpl_vars['row']->value->topay_delivery_amount);?>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['topay']->value,2);?>
</td>
                    <td align="right"><?php echo inr_format(($_smarty_tpl->tpl_vars['paid']->value+$_smarty_tpl->tpl_vars['topay']->value),2);?>
</td>
                </tr>

                <?php $_smarty_tpl->_assignInScope('tot_paid', $_smarty_tpl->tpl_vars['tot_paid']->value+$_smarty_tpl->tpl_vars['paid']->value);?>
                <?php $_smarty_tpl->_assignInScope('tot_topay', $_smarty_tpl->tpl_vars['tot_topay']->value+$_smarty_tpl->tpl_vars['topay']->value);?>
                <?php $_smarty_tpl->_assignInScope('paid_lrcount', $_smarty_tpl->tpl_vars['paid_lrcount']->value+$_smarty_tpl->tpl_vars['row']->value->paid_cargo_count);?>
                <?php $_smarty_tpl->_assignInScope('topay_lrcount', $_smarty_tpl->tpl_vars['topay_lrcount']->value+$_smarty_tpl->tpl_vars['row']->value->topay_delivery_count);?>
                <?php $_smarty_tpl->_assignInScope('tot_net_amt', $_smarty_tpl->tpl_vars['tot_net_amt']->value+$_smarty_tpl->tpl_vars['paid']->value+$_smarty_tpl->tpl_vars['topay']->value);?>
            <?php
}
} else {
?>
                <tr>
                    <td align="center" colspan="5">No data found !!!!</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
        <tfoot>
            <tr class="active">                    
                <td>Grand Total</td>
                <td align="center"><?php echo $_smarty_tpl->tpl_vars['paid_lrcount']->value;?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_paid']->value,2);?>
</td>  
                <td align="center"><?php echo $_smarty_tpl->tpl_vars['topay_lrcount']->value;?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_topay']->value,2);?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_net_amt']->value,2);?>
</td>
            </tr>
        </tfoot>
    </table>                
</div> 

<?php echo '<script'; ?>
>
    var fromDate = <?php echo json_encode($_smarty_tpl->tpl_vars['fromDate']->value);?>

    var toDate = <?php echo json_encode($_smarty_tpl->tpl_vars['toDate']->value);?>

<?php echo '</script'; ?>
><?php }
}
