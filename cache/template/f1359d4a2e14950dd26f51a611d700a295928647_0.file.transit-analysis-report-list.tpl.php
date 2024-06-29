<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-20 12:23:39
  from 'E:\xampp\htdocs\cargo\application\views\site\report\transit-analysis-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6673d1f3b45928_01344463',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'f1359d4a2e14950dd26f51a611d700a295928647' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\transit-analysis-report-list.tpl',
      1 => 1718860707,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6673d1f3b45928_01344463 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table class="" width="99%">
    <tr>
        <td width="50%">
            <span class="bold">From </span><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['fromDate']->value,$_smarty_tpl->tpl_vars['fromDate']->value);?>
 <span class="bold">To </span><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['toDate']->value,$_smarty_tpl->tpl_vars['toDate']->value);?>

        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> <?php echo date("Y-m-d h:i:s A");?>

        </td>
    </tr>
</table>
<br>
<?php if ($_smarty_tpl->tpl_vars['filterType']->value == 'SUMMARY') {?>
    <table id="transit_analysis_movement_table" class="table table-bordered">
        <thead>
            <tr class="success">
                <td align="center" class="bold f-16">Station Name <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Branch Name <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Article Count <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Booking Count <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Pending Loading <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">In-Transit Count <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Reached Count <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Delivery Count <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Cargo Missing <i class="fa fa-sort"></td>
            </tr>
        </thead>

        <tbody class="body_table">
            <?php $_smarty_tpl->_assignInScope('t_bk_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_load_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_pending_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_unload_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_reach_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_art_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_missing_count', 0);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['results']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align='center' class="f-16"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_name;?>
</td>
                    <td align='center' class="f-16"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                    <td align='center' class="f-16"><?php echo $_smarty_tpl->tpl_vars['row']->value->article_count;?>
</td>
                    <td align='center' class="f-16">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->booked_count > 0) {?>
                            <a href="javascript:;" onclick="getTransitlrDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_code;?>
','NA','<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
');"><?php echo $_smarty_tpl->tpl_vars['row']->value->booked_count;?>
</a>
                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->booked_count;?>

                        <?php }?>
                    </td>
                    <td align='center' class="f-16">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->pending_count > 0) {?>
                            <a href="javascript:;" onclick="getTransitlrDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_code;?>
','CPD','<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
');">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->pending_count;?>

                            </a>
                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->pending_count;?>

                        <?php }?>
                    </td>

                    <td align='center' class="f-16">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->loaded_count > 0) {?>
                            <a href="javascript:;" onclick="getTransitlrDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_code;?>
','CLD','<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
');">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->loaded_count;?>

                            </a>
                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->loaded_count;?>

                        <?php }?>
                    </td>
                    <td align='center' class="f-16">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->unloaded_count > 0) {?>
                            <a href="javascript:;" onclick="getTransitlrDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_code;?>
','CUD','<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
');">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->unloaded_count;?>

                            </a>
                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->unloaded_count;?>

                        <?php }?>
                    </td>
                    <td align='center' class="f-16">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->reached_count > 0) {?>
                            <a href="javascript:;" onclick="getTransitlrDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_code;?>
','CRD','<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
');">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->reached_count;?>

                            </a>
                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->reached_count;?>

                        <?php }?>
                    </td>
                    <td align='center' class="f-16">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->missed_count > 0) {?>
                            <a href="javascript:;" onclick="getTransitlrDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_code;?>
','CMD','<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
');">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->missed_count;?>

                            </a>
                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->missed_count;?>

                        <?php }?>
                    </td>
                    <?php $_smarty_tpl->_assignInScope('t_missing_count', $_smarty_tpl->tpl_vars['t_missing_count']->value+$_smarty_tpl->tpl_vars['row']->value->missed_count);?>
                    <?php $_smarty_tpl->_assignInScope('t_art_count', $_smarty_tpl->tpl_vars['t_art_count']->value+$_smarty_tpl->tpl_vars['row']->value->article_count);?>
                    <?php $_smarty_tpl->_assignInScope('t_bk_count', $_smarty_tpl->tpl_vars['t_bk_count']->value+$_smarty_tpl->tpl_vars['row']->value->booked_count);?>
                    <?php $_smarty_tpl->_assignInScope('t_load_count', $_smarty_tpl->tpl_vars['t_load_count']->value+$_smarty_tpl->tpl_vars['row']->value->loaded_count);?>
                    <?php $_smarty_tpl->_assignInScope('t_pending_count', $_smarty_tpl->tpl_vars['t_pending_count']->value+$_smarty_tpl->tpl_vars['row']->value->pending_count);?>
                    <?php $_smarty_tpl->_assignInScope('t_unload_count', $_smarty_tpl->tpl_vars['t_unload_count']->value+$_smarty_tpl->tpl_vars['row']->value->unloaded_count);?>
                    <?php $_smarty_tpl->_assignInScope('t_reach_count', $_smarty_tpl->tpl_vars['t_reach_count']->value+$_smarty_tpl->tpl_vars['row']->value->reached_count);?>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
        <?php if (count($_smarty_tpl->tpl_vars['results']->value) > 0) {?>
            <tfoot>
                <tr class="active">
                    <td colspan="2" align="right" class="bold f-16">Total</td>
                    <td class="bold f-16" align="center"><?php echo $_smarty_tpl->tpl_vars['t_art_count']->value;?>
</td>
                    <td class="bold f-16" align="center"><?php echo $_smarty_tpl->tpl_vars['t_bk_count']->value;?>
</td>
                    <td class="bold f-16" align="center"><?php echo $_smarty_tpl->tpl_vars['t_pending_count']->value;?>
</td>
                    <td class="bold f-16" align="center"><?php echo $_smarty_tpl->tpl_vars['t_load_count']->value;?>
</td>
                    <td class="bold f-16" align="center"><?php echo $_smarty_tpl->tpl_vars['t_unload_count']->value;?>
</td>
                    <td class="bold f-16" align="center"><?php echo $_smarty_tpl->tpl_vars['t_reach_count']->value;?>
</td>
                    <td class="bold f-16" align="center"><?php echo $_smarty_tpl->tpl_vars['t_missing_count']->value;?>
</td>
                </tr>
            </tfoot>
        <?php }?>
    </table>
<?php }?>

<?php if ($_smarty_tpl->tpl_vars['filterType']->value == 'DETAILS') {?>
    <table id="" class="table table-bordered">
        <thead>
            <tr class="success">
                <td align="center">LR No</td>
                <td align="center">Booked Time </td>
                <td align="center">From</td>
                <td align="center">To</td>
                <td align="center">Start Transit Age</td>
                <td align="center">Transit Status</td>
                <td align="center">End Transit Age</td>
                <td align="center">Article count</td>
                <td align="center">Last Updated On </td>
            </tr>
        </thead>
        <tbody class="body_table">
            <?php $_smarty_tpl->_assignInScope('t_lr_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_art_count', 0);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['results']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align='center'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</td>
                    <td align='center'><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,"d, M y g:i A");?>
</td>
                    <td align='center'><?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_name;?>
</td>
                    <td align='center'><?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_name;?>
</td>
                    <td align='center'><?php echo $_smarty_tpl->tpl_vars['row']->value->start_transit_age;?>
</td>
                    <td align='center'><?php echo $_smarty_tpl->tpl_vars['row']->value->transit_status;?>
</td>
                    <td align='center'><?php if ($_smarty_tpl->tpl_vars['row']->value->end_transit_age == "NA") {?>
                        - <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->end_transit_age;?>

                        <?php }?></td>
                    <td align='center'><?php echo $_smarty_tpl->tpl_vars['row']->value->article_count;?>
</td>
                    <td align='center'><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->updated_at,"d, M y g:i A");?>
</td>
                </tr>
                <?php $_smarty_tpl->_assignInScope('t_lr_count', $_smarty_tpl->tpl_vars['t_lr_count']->value+count($_smarty_tpl->tpl_vars['row']->value->cargo_code));?>
                <?php $_smarty_tpl->_assignInScope('t_art_count', $_smarty_tpl->tpl_vars['t_art_count']->value+$_smarty_tpl->tpl_vars['row']->value->article_count);?>
            <?php
}
} else {
?>
                <tr>
                    <td colspan="9" align="center">No data found</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
        <?php if (count($_smarty_tpl->tpl_vars['results']->value) > 0) {?>
            <tr class="active">
                <td align="right" class="bold">Total</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['t_lr_count']->value;?>
</td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['t_art_count']->value;?>
</td>
                <td align="center" class="bold"></td>
            </tr>
        <?php }?>
    </table>
<?php }?>

<?php echo '<script'; ?>
>
    $('#transit_analysis_movement_table').dataTable({
        "bPaginate": false,
        "info": false,
        "dom": 'lrt',
        "aaSorting": [
            [3, "desc"],
        ]
    });
<?php echo '</script'; ?>
><?php }
}
