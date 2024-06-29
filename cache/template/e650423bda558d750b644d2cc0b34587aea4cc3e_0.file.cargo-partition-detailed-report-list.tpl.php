<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-05 18:06:31
  from 'E:\xampp\htdocs\cargo\application\views\site\report\cargo-partition-detailed-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66605bcf09aff7_94308686',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'e650423bda558d750b644d2cc0b34587aea4cc3e' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\cargo-partition-detailed-report-list.tpl',
      1 => 1716451519,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66605bcf09aff7_94308686 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table class="" width="100%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Cargo Partition Detail Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['fromDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['toDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

        </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> <?php echo $_smarty_tpl->tpl_vars['username']->value;?>
 </td>
    </tr>
</table>

<div id="cargo_partition_report_cont">
    <table id="cargo_partition_report_table" class="table table-bordered " style="width:100%">
        <thead>
            <tr class="success">
                <th class="thead">S No. </th>
                <th class="thead">Source <?php echo lang('lr');?>
 </th>
                <th class="thead"><?php echo lang('lr');?>
 </th>
                <th class="thead">Partition Time </th>
                <th class="thead">Partition Cargo Status </th>
                <th class="thead">From Route </th>
                <th class="thead">To Route </th>
                <th class="thead"> Cargo Status </th>
                <th class="thead">Loaded At </th>
                <th class="thead">unLoaded At </th>
                <th class="thead">Delivery At </th>
                <th class="thead">Item Name </th>
                <th class="thead">Total Items </th>
            </tr>
        </thead>
        <tbody class="body_table">
            <?php $_smarty_tpl->_assignInScope('t_iteam_count', 0);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['counts']->value, 'iterate', false, 'j');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['j']->value => $_smarty_tpl->tpl_vars['iterate']->value) {
?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row', false, 'i');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                    <?php if (($_smarty_tpl->tpl_vars['i']->value+1) > $_smarty_tpl->tpl_vars['iterate']->value) {?>
                        <?php $_smarty_tpl->_assignInScope('result', array_slice($_smarty_tpl->tpl_vars['result']->value,$_smarty_tpl->tpl_vars['iterate']->value));?>
                        <?php break 1;?>
                    <?php }?>

                    <tr>
                        <?php if ($_smarty_tpl->tpl_vars['i']->value == 0) {?>
                            <td align="left" nowrap rowspan=<?php echo $_smarty_tpl->tpl_vars['iterate']->value;?>
><?php echo $_smarty_tpl->tpl_vars['j']->value+1;?>
</td>
                            <td align="left" nowrap rowspan=<?php echo $_smarty_tpl->tpl_vars['iterate']->value;?>
>
                                <a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->source_cargo_code;?>
")'>
                                    <?php echo $_smarty_tpl->tpl_vars['row']->value->source_cargo_code;?>

                                </a><br>
                                <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

                                <?php echo $_smarty_tpl->tpl_vars['row']->value->payment_status_code;?>

                            </td>
                        <?php }?>
                        <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
                        <td align="left" nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value->partitioned_at;?>
</td>
                        <td align="left" nowrap><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->partition_cargo_status_code];?>
</td>
                        <td align="left" nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_name;?>
</td>
                        <td align="left" nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_name;?>
</td>
                        <?php if ($_smarty_tpl->tpl_vars['i']->value == 0) {?>
                            <td align="left" nowrap rowspan=<?php echo $_smarty_tpl->tpl_vars['iterate']->value;?>
><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
</td>
                        <?php }?>
                        <td align="right"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->loaded_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                        <td align="right"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->unloaded_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                        <td align="right"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->delivered_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                        <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                        <?php $_smarty_tpl->_assignInScope('t_iteam_count', $_smarty_tpl->tpl_vars['t_iteam_count']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                    </tr>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
        <?php if (count($_smarty_tpl->tpl_vars['result']->value) > 0) {?>
            <tfoot>
                <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                    <td colspan="12" align="right">Total</td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_iteam_count']->value;?>
</td>
                </tr>
            </tfoot>
        <?php }?>

    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportPartitionExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div><?php }
}
