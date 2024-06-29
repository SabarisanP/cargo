<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-03 15:43:23
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\delivery-ledger-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665d97431836d8_96087120',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '5573836770ad164bbc49e28d256beaaacd9ebe9f' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\delivery-ledger-report-list.tpl',
      1 => 1717409599,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665d97431836d8_96087120 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold"><?php echo iflang('Delivery Ledger Report');?>
</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['fromDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['toDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

        <td width="50%" align="right"><span class="bold">Report At : </span>
            <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> <?php echo $_smarty_tpl->tpl_vars['username']->value;?>
 </td>
    </tr>
</table>

<h5><b>Transactions</b></h5>

<div class="overflow-x-auto">
    <table id="dt_adv_booking_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th style="text-align: center;">S.No</th>
                <th style="text-align: center;">Ogpl No.</th>
                <th style="text-align: center;">Created Date</th>
                <th style="text-align: center;">From </th>
                <th style="text-align: center;">To </th>
                <th style="text-align: center;">Vehicle No</th>
                <th style="text-align: center;">Vehicle Type</th>
                <th style="text-align: center;">Total Amount</th>
                <th style="text-align: center;">Tot LR</th>
                <th style="text-align: center;">Driver Name</th>
                <th style="text-align: center;">Status</th>
            </tr>
        </thead>
        <tbody class="body_table">
            <?php $_smarty_tpl->_assignInScope('s_no', 1);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groupedOgpl']->value, 'value', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['value']->value) {
?>
                <?php $_smarty_tpl->_assignInScope('index', 0);?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['value']->value, 'innerValue', false, 'innerKey');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['innerKey']->value => $_smarty_tpl->tpl_vars['innerValue']->value) {
?>
                    <?php if (strpos($_smarty_tpl->tpl_vars['innerValue']->value->alias_code,'DD') == false) {?>
                       <tr>
                       <?php if ($_smarty_tpl->tpl_vars['index']->value == 0) {?>
                           <td align="center" rowspan="<?php echo count($_smarty_tpl->tpl_vars['value']->value);?>
"><?php echo $_smarty_tpl->tpl_vars['s_no']->value++;?>
</td>
                       <?php }?>
                           <td align="center" nowrap><a href='javascript:;' title="more details"
                                   onclick='printDeliveryReport2("<?php echo $_smarty_tpl->tpl_vars['innerValue']->value->transit_code;?>
" , "<?php echo $_smarty_tpl->tpl_vars['innerValue']->value->from_organization_code;?>
", "<?php echo $_smarty_tpl->tpl_vars['innerValue']->value->to_organization_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['innerValue']->value->alias_code;?>
</a></td>
                           <td align="center"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['innerValue']->value->loaded_at);?>
</td>
                           <td align="center"><?php echo $_smarty_tpl->tpl_vars['innerValue']->value->transit_from_organization_name;?>
</td>
                           <td align="center"><?php echo $_smarty_tpl->tpl_vars['innerValue']->value->transit_to_organization_name;?>
</td>
                           <td align="center"><?php echo $_smarty_tpl->tpl_vars['innerValue']->value->registration_number;?>
</td>
                           <td align="center"><?php echo $_smarty_tpl->tpl_vars['innerValue']->value->vehicle_type_code;?>
</td>
                           <td align="center"><?php echo $_smarty_tpl->tpl_vars['innerValue']->value->total_amount;?>
</td>
                           <td align="center"><?php echo $_smarty_tpl->tpl_vars['innerValue']->value->cargo_count;?>
</td>
                           <td align="center"><?php echo $_smarty_tpl->tpl_vars['innerValue']->value->driver_name;?>
</td>
                           <td align="center"><?php echo $_smarty_tpl->tpl_vars['innerValue']->value->transit_activity_status_code;?>
</td>
       
                       </tr>
                       <?php $_smarty_tpl->_assignInScope('index', $_smarty_tpl->tpl_vars['index']->value+1);?>
                    <?php }?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
    </table>
</div>


<?php echo '<script'; ?>
>
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
<?php echo '</script'; ?>
><?php }
}
