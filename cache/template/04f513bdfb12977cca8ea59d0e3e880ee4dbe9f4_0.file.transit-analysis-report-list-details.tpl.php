<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-27 11:05:10
  from 'E:\xampp\htdocs\cargo\application\views\site\report\transit-analysis-report-list-details.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667cfa0e209f25_63422548',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '04f513bdfb12977cca8ea59d0e3e880ee4dbe9f4' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\transit-analysis-report-list-details.tpl',
      1 => 1719466369,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667cfa0e209f25_63422548 (Smarty_Internal_Template $_smarty_tpl) {
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
</table><br>
<?php if ($_smarty_tpl->tpl_vars['filterType']->value == 'DETAILS') {?>
    <div style="width: 50%;">
        <table id="sumary-table-transit-report" class="table table-bordered">
            <thead>
                <tr class="success">
                    <td align="center"><b>#</b></td>
                    <td align="center"><b>Route</b></td>
                    <td align="center"><b>LR Count</b></td>
                    <td align="center"><b>Article Count</b></td>
                </tr>
            </thead>
            <tbody class="body_table">
                <?php $_smarty_tpl->_assignInScope('t_lr_count', 0);?>
                <?php $_smarty_tpl->_assignInScope('sno', 1);?>
                <?php $_smarty_tpl->_assignInScope('t_art_count', 0);?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['routeWise']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                    <tr>
                        <td align='center'><?php echo $_smarty_tpl->tpl_vars['sno']->value;?>
</td>
                        <td align='center'><?php echo $_smarty_tpl->tpl_vars['row']->value['route'];?>
</td>
                        <td align='center'><?php echo $_smarty_tpl->tpl_vars['row']->value['lr_count'];?>
</td>
                        <td align='center'><?php echo $_smarty_tpl->tpl_vars['row']->value['article_count'];?>
</td>
                    </tr>
                    <?php $_smarty_tpl->_assignInScope('sno', $_smarty_tpl->tpl_vars['sno']->value+1);?>
                    <?php $_smarty_tpl->_assignInScope('t_lr_count', $_smarty_tpl->tpl_vars['t_lr_count']->value+$_smarty_tpl->tpl_vars['row']->value['lr_count']);?>
                    <?php $_smarty_tpl->_assignInScope('t_art_count', $_smarty_tpl->tpl_vars['t_art_count']->value+$_smarty_tpl->tpl_vars['row']->value['article_count']);?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </tbody>
            <?php if (count($_smarty_tpl->tpl_vars['routeWise']->value) > 0) {?>
                <tr class="active">
                    <td align="center" class="bold"></td>
                    <td align="center" class="bold"></td>
                    <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['t_lr_count']->value;?>
</td>
                    <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['t_art_count']->value;?>
</td>
                </tr>
            <?php }?>
        </table>
    </div>
    <div style="width: 50%;"></div>
    <br>
    <table id="" class="table table-bordered">
        <thead>
            <tr class="success">
                <td align="center"><b>#</b></td>
                <td align="center"><b>Booked Time </b></td>
                <td align="center"><b>LR No</b></td>
                <td align="center"><b>From</b></td>
                <td align="center"><b>To</b></td>
                <td align="center"><b>Start Transit Age</b></td>
                <td align="center"><b>Transit Status</b></td>
                <td align="center"><b>End Transit Age</b></td>
                <td align="center"><b>Article count</b></td>
                <td align="center"><b>Last Updated On </b></td>
            </tr>
        </thead>
        <tbody class="body_table">
            <?php $_smarty_tpl->_assignInScope('t_lr_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_art_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('sno', 1);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['results']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align='center'><?php echo $_smarty_tpl->tpl_vars['sno']->value;?>
</td>
                    <td align='center'><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,"d, M y g:i A");?>
</td>
                    <td align='center'><a href="javascript:;" title="more details" onclick="getCargoDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
');"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
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
                <?php $_smarty_tpl->_assignInScope('sno', $_smarty_tpl->tpl_vars['sno']->value+1);?>
                <?php $_smarty_tpl->_assignInScope('t_lr_count', $_smarty_tpl->tpl_vars['t_lr_count']->value+count($_smarty_tpl->tpl_vars['row']->value->cargo_code));?>
                <?php $_smarty_tpl->_assignInScope('t_art_count', $_smarty_tpl->tpl_vars['t_art_count']->value+$_smarty_tpl->tpl_vars['row']->value->article_count);?>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
        <?php if (count($_smarty_tpl->tpl_vars['results']->value) > 0) {?>
            <tr class="active">
                <td align="center" class="bold"></td>
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
<?php }
echo '<script'; ?>
>
    $('#sumary-table-transit-report').dataTable({
        "bPaginate": false,
        "info": false,
        "dom": 'lrt',
        "aaSorting": [
            [0, "asc"],
        ]
    });
<?php echo '</script'; ?>
><?php }
}
