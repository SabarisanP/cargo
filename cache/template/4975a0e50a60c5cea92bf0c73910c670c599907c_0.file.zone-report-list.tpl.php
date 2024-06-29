<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-05 15:22:58
  from 'E:\xampp\htdocs\cargo\application\views\site\report\zone-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6660357a330001_68144473',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '4975a0e50a60c5cea92bf0c73910c670c599907c' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\zone-report-list.tpl',
      1 => 1716451519,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6660357a330001_68144473 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table width="100%">
    <tr>
        <td colspan="10" align="center"><span class="bold">Zone Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Date :</span> <b><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['from_date']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['to_date']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</b></td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> <b><?php echo date("d-m-Y h:i A");?>
</b></td>
    </tr>
</table>
<br />
<div class="table-responsive">
    <table class="table table-bordered no-wrap" style="font-family: Times New Roman; font-size: 15px;">
        <thead>
            <tr style="background-color:#92d050; font-weight: bold; ">
                <td>ZONE</td>

                <?php if ($_smarty_tpl->tpl_vars['transactionType']->value == 'BOOKING') {?>
                    <td>TO STATION</td>
                    <td>TO BRANCH</td>
                <?php } else { ?>
                    <td>FROM STATION</td>
                    <td>FROM BRANCH</td>
                <?php }?>
                <td>NOS</td>
                <td>PAID</td>
                <td>TOPAY</td>
                <td>ON A/C</td>
                <td style="color:#ff0017;">TOTAL</td>
                <td>LOADING</td>
                <td>OTHER</td>
                <td>COMM</td>
                <td>AMOUNT</td>
            </tr>
        </thead>
        <tbody class="body_table">
            <?php $_smarty_tpl->_assignInScope('total_lr_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('total_paid', 0);?>
            <?php $_smarty_tpl->_assignInScope('total_topay', 0);?>
            <?php $_smarty_tpl->_assignInScope('total_on_account', 0);?>
            <?php $_smarty_tpl->_assignInScope('total_freight', 0);?>
            <?php $_smarty_tpl->_assignInScope('total_loading_charge', 0);?>
            <?php $_smarty_tpl->_assignInScope('total_other_charge', 0);?>
            <?php $_smarty_tpl->_assignInScope('total_commission', 0);?>
            <?php $_smarty_tpl->_assignInScope('total__t_amount', 0);?>

            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'row', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <?php $_smarty_tpl->_assignInScope('zone_count', 0);?>
                <?php $_smarty_tpl->_assignInScope('zone_lr_count', 0);?>
                <?php $_smarty_tpl->_assignInScope('zone_paid', 0);?>
                <?php $_smarty_tpl->_assignInScope('zone_topay', 0);?>
                <?php $_smarty_tpl->_assignInScope('zone_on_account', 0);?>
                <?php $_smarty_tpl->_assignInScope('zone_freight', 0);?>
                <?php $_smarty_tpl->_assignInScope('zone_loading_charge', 0);?>
                <?php $_smarty_tpl->_assignInScope('zone_other_charge', 0);?>
                <?php $_smarty_tpl->_assignInScope('zone_commission', 0);?>
                <?php $_smarty_tpl->_assignInScope('zone_total_amount', 0);?>
                <?php $_smarty_tpl->_assignInScope('conection_ch', " [CON] ");?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value['station'], 'stn', false, 'stn_key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['stn_key']->value => $_smarty_tpl->tpl_vars['stn']->value) {
?>
                    <?php $_smarty_tpl->_assignInScope('station_count', 0);?>
                    <?php if (count($_smarty_tpl->tpl_vars['stn']->value['branch']['out_con_ch'])) {?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stn']->value['branch']['out_con_ch'], 'brn', false, 'brn_key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['brn_key']->value => $_smarty_tpl->tpl_vars['brn']->value) {
?>

                            <tr style="background-color:#fcd5b4;">
                                <td>
                                    <?php if ($_smarty_tpl->tpl_vars['zone_count']->value == 0) {?>
                                        <?php echo $_smarty_tpl->tpl_vars['row']->value['zone_name'];?>

                                    <?php }?>
                                </td>
                                <td>
                                    <?php if ($_smarty_tpl->tpl_vars['station_count']->value == 0) {?>
                                        <?php echo $_smarty_tpl->tpl_vars['stn']->value['station_name'];?>

                                    <?php }?>
                                </td>
                                <td><?php echo $_smarty_tpl->tpl_vars['brn']->value['branch_name'];?>
</td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['brn']->value['lr_count'];?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['paid'],2);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['topay'],2);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['on_account'],2);?>
</td>
                                <td align="right"><?php echo $_smarty_tpl->tpl_vars['brn']->value['paid']+$_smarty_tpl->tpl_vars['brn']->value['topay']+inr_format($_smarty_tpl->tpl_vars['brn']->value['on_account'],2);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['loading_charge'],2);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['other_charge'],2);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['commision'],2);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['total_amount'],2);?>
</td>
                            </tr>
                                                        <?php $_smarty_tpl->_assignInScope('zone_lr_count', $_smarty_tpl->tpl_vars['zone_lr_count']->value+$_smarty_tpl->tpl_vars['brn']->value['lr_count']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_paid', $_smarty_tpl->tpl_vars['zone_paid']->value+$_smarty_tpl->tpl_vars['brn']->value['paid']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_topay', $_smarty_tpl->tpl_vars['zone_topay']->value+$_smarty_tpl->tpl_vars['brn']->value['topay']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_on_account', $_smarty_tpl->tpl_vars['zone_on_account']->value+$_smarty_tpl->tpl_vars['brn']->value['on_account']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_freight', $_smarty_tpl->tpl_vars['zone_freight']->value+($_smarty_tpl->tpl_vars['brn']->value['paid']+$_smarty_tpl->tpl_vars['brn']->value['topay']+$_smarty_tpl->tpl_vars['brn']->value['on_account']));?>
                            <?php $_smarty_tpl->_assignInScope('zone_loading_charge', $_smarty_tpl->tpl_vars['zone_loading_charge']->value+$_smarty_tpl->tpl_vars['brn']->value['loading_charge']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_other_charge', $_smarty_tpl->tpl_vars['zone_other_charge']->value+$_smarty_tpl->tpl_vars['brn']->value['other_charge']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_commission', $_smarty_tpl->tpl_vars['zone_commission']->value+$_smarty_tpl->tpl_vars['brn']->value['commision']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_total_amount', $_smarty_tpl->tpl_vars['zone_total_amount']->value+$_smarty_tpl->tpl_vars['brn']->value['total_amount']);?>

                                                        <?php $_smarty_tpl->_assignInScope('zone_count', $_smarty_tpl->tpl_vars['zone_count']->value+1);?>
                            <?php $_smarty_tpl->_assignInScope('station_count', $_smarty_tpl->tpl_vars['station_count']->value+1);?>
                            <?php $_smarty_tpl->_assignInScope('total_lr_count', $_smarty_tpl->tpl_vars['total_lr_count']->value+$_smarty_tpl->tpl_vars['brn']->value['lr_count']);?>
                            <?php $_smarty_tpl->_assignInScope('total_paid', $_smarty_tpl->tpl_vars['total_paid']->value+$_smarty_tpl->tpl_vars['brn']->value['paid']);?>
                            <?php $_smarty_tpl->_assignInScope('total_topay', $_smarty_tpl->tpl_vars['total_topay']->value+$_smarty_tpl->tpl_vars['brn']->value['topay']);?>
                            <?php $_smarty_tpl->_assignInScope('total_on_account', $_smarty_tpl->tpl_vars['total_on_account']->value+$_smarty_tpl->tpl_vars['brn']->value['on_account']);?>
                            <?php $_smarty_tpl->_assignInScope('total_freight', $_smarty_tpl->tpl_vars['total_freight']->value+($_smarty_tpl->tpl_vars['brn']->value['paid']+$_smarty_tpl->tpl_vars['brn']->value['topay']+$_smarty_tpl->tpl_vars['brn']->value['on_account']));?>
                            <?php $_smarty_tpl->_assignInScope('total_loading_charge', $_smarty_tpl->tpl_vars['total_loading_charge']->value+$_smarty_tpl->tpl_vars['brn']->value['loading_charge']);?>
                            <?php $_smarty_tpl->_assignInScope('total_other_charge', $_smarty_tpl->tpl_vars['total_other_charge']->value+$_smarty_tpl->tpl_vars['brn']->value['other_charge']);?>
                            <?php $_smarty_tpl->_assignInScope('total_commission', $_smarty_tpl->tpl_vars['total_commission']->value+$_smarty_tpl->tpl_vars['brn']->value['commision']);?>
                            <?php $_smarty_tpl->_assignInScope('total__t_amount', $_smarty_tpl->tpl_vars['total__t_amount']->value+$_smarty_tpl->tpl_vars['brn']->value['total_amount']);?>
                        <?php
}
} else {
?>
                            <tr>
                                <td colspan="12" align="center">No data found</td>
                            </tr>
                        <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    <?php }?>
                    <?php if (count($_smarty_tpl->tpl_vars['stn']->value['branch']['con_ch'])) {?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stn']->value['branch']['con_ch'], 'brn', false, 'brn_key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['brn_key']->value => $_smarty_tpl->tpl_vars['brn']->value) {
?>
                            <tr style="background-color:#fcd5b4;">
                                <td>
                                    <?php if ($_smarty_tpl->tpl_vars['zone_count']->value == 0) {?>
                                        <?php echo $_smarty_tpl->tpl_vars['row']->value['zone_name'];?>

                                    <?php }?>
                                </td>
                                <td>
                                    <?php if ($_smarty_tpl->tpl_vars['station_count']->value == 0) {?>
                                        <?php echo $_smarty_tpl->tpl_vars['stn']->value['station_name'];?>

                                    <?php }?>
                                </td>
                                <td><?php echo $_smarty_tpl->tpl_vars['brn']->value['branch_name'];
echo $_smarty_tpl->tpl_vars['conection_ch']->value;?>
</td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['brn']->value['lr_count'];?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['paid'],2);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['topay'],2);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['on_account'],2);?>
</td>
                                <td align="right"><?php echo $_smarty_tpl->tpl_vars['brn']->value['paid']+$_smarty_tpl->tpl_vars['brn']->value['topay']+inr_format($_smarty_tpl->tpl_vars['brn']->value['on_account'],2);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['loading_charge'],2);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['other_charge'],2);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['commision'],2);?>
</td>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['brn']->value['total_amount'],2);?>
</td>
                            </tr>
                                                        <?php $_smarty_tpl->_assignInScope('zone_lr_count', $_smarty_tpl->tpl_vars['zone_lr_count']->value+$_smarty_tpl->tpl_vars['brn']->value['lr_count']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_paid', $_smarty_tpl->tpl_vars['zone_paid']->value+$_smarty_tpl->tpl_vars['brn']->value['paid']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_topay', $_smarty_tpl->tpl_vars['zone_topay']->value+$_smarty_tpl->tpl_vars['brn']->value['topay']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_on_account', $_smarty_tpl->tpl_vars['zone_on_account']->value+$_smarty_tpl->tpl_vars['brn']->value['on_account']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_freight', $_smarty_tpl->tpl_vars['zone_freight']->value+($_smarty_tpl->tpl_vars['brn']->value['paid']+$_smarty_tpl->tpl_vars['brn']->value['topay']+$_smarty_tpl->tpl_vars['brn']->value['on_account']));?>
                            <?php $_smarty_tpl->_assignInScope('zone_loading_charge', $_smarty_tpl->tpl_vars['zone_loading_charge']->value+$_smarty_tpl->tpl_vars['brn']->value['loading_charge']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_other_charge', $_smarty_tpl->tpl_vars['zone_other_charge']->value+$_smarty_tpl->tpl_vars['brn']->value['other_charge']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_commission', $_smarty_tpl->tpl_vars['zone_commission']->value+$_smarty_tpl->tpl_vars['brn']->value['commision']);?>
                            <?php $_smarty_tpl->_assignInScope('zone_total_amount', $_smarty_tpl->tpl_vars['zone_total_amount']->value+$_smarty_tpl->tpl_vars['brn']->value['total_amount']);?>

                                                        <?php $_smarty_tpl->_assignInScope('zone_count', $_smarty_tpl->tpl_vars['zone_count']->value+1);?>
                            <?php $_smarty_tpl->_assignInScope('station_count', $_smarty_tpl->tpl_vars['station_count']->value+1);?>
                            <?php $_smarty_tpl->_assignInScope('total_lr_count', $_smarty_tpl->tpl_vars['total_lr_count']->value+$_smarty_tpl->tpl_vars['brn']->value['lr_count']);?>
                            <?php $_smarty_tpl->_assignInScope('total_paid', $_smarty_tpl->tpl_vars['total_paid']->value+$_smarty_tpl->tpl_vars['brn']->value['paid']);?>
                            <?php $_smarty_tpl->_assignInScope('total_topay', $_smarty_tpl->tpl_vars['total_topay']->value+$_smarty_tpl->tpl_vars['brn']->value['topay']);?>
                            <?php $_smarty_tpl->_assignInScope('total_on_account', $_smarty_tpl->tpl_vars['total_on_account']->value+$_smarty_tpl->tpl_vars['brn']->value['on_account']);?>
                            <?php $_smarty_tpl->_assignInScope('total_freight', $_smarty_tpl->tpl_vars['total_freight']->value+($_smarty_tpl->tpl_vars['brn']->value['paid']+$_smarty_tpl->tpl_vars['brn']->value['topay']+$_smarty_tpl->tpl_vars['brn']->value['on_account']));?>
                            <?php $_smarty_tpl->_assignInScope('total_loading_charge', $_smarty_tpl->tpl_vars['total_loading_charge']->value+$_smarty_tpl->tpl_vars['brn']->value['loading_charge']);?>
                            <?php $_smarty_tpl->_assignInScope('total_other_charge', $_smarty_tpl->tpl_vars['total_other_charge']->value+$_smarty_tpl->tpl_vars['brn']->value['other_charge']);?>
                            <?php $_smarty_tpl->_assignInScope('total_commission', $_smarty_tpl->tpl_vars['total_commission']->value+$_smarty_tpl->tpl_vars['brn']->value['commision']);?>
                            <?php $_smarty_tpl->_assignInScope('total__t_amount', $_smarty_tpl->tpl_vars['total__t_amount']->value+$_smarty_tpl->tpl_vars['brn']->value['total_amount']);?>
                        <?php
}
} else {
?>
                            <tr>
                                <td colspan="12" align="center">No data found</td>
                            </tr>
                        <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    <?php }?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

                <tr style="background-color:#f4a6cd; color:#000; font-weight:bold;">
                    <td colspan="3"></td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['zone_lr_count']->value;?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['zone_paid']->value,2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['zone_topay']->value,2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['zone_on_account']->value,2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['zone_freight']->value,2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['zone_loading_charge']->value,2);?>
</td>

                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['zone_other_charge']->value,2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['zone_commission']->value,2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['zone_total_amount']->value,2);?>
</td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>

        <tfoot>
            <tr style="background-color: #92d050; font-weight: bold;">
                <td colspan="3" align="right">Total</td>
                <td align="center"><?php echo $_smarty_tpl->tpl_vars['total_lr_count']->value;?>
</td>
                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['total_paid']->value,2);?>
</td>
                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['total_topay']->value,2);?>
</td>
                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['total_on_account']->value,2);?>
</td>
                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['total_freight']->value,2);?>
</td>
                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['total_loading_charge']->value,2);?>
</td>
                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['total_other_charge']->value,2);?>
</td>
                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['total_commission']->value,2);?>
</td>
                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['total__t_amount']->value,2);?>
</td>
            </tr>
        </tfoot>
    </table>
</div><?php }
}
