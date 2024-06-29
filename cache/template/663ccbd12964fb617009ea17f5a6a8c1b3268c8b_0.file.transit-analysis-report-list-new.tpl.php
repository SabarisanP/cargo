<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-28 17:20:40
  from 'E:\xampp\htdocs\cargo\application\views\site\report\transit-analysis-report-list-new.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667ea390340a91_71386073',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '663ccbd12964fb617009ea17f5a6a8c1b3268c8b' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\transit-analysis-report-list-new.tpl',
      1 => 1719575435,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667ea390340a91_71386073 (Smarty_Internal_Template $_smarty_tpl) {
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
                <td align="center" class="bold">#<i class="fa fa-sort"></td>
                <td align="center" class="bold">Station Name <i class="fa fa-sort"></td>
                <td align="center" class="bold">Branch Name <i class="fa fa-sort"></td>
                <td align="center" class="bold" colspan="2">Booked</td>
                <td align="center" class="bold" colspan="2" style="text-decoration: underline;">Local/link Loaded</td>
                <td align="center" class="bold" colspan="2"  style="text-decoration: underline;">Direct loaded</td>
                <td align="center" class="bold" colspan="2"  style="text-decoration: underline;">Hub/link pending loaded </td>
                <td align="center" class="bold" colspan="2">Direct Pending Loaded</td>
                <td align="center" class="bold" colspan="2">In Transit</td>

                <td align="center" class="bold" colspan="2"  style="text-decoration: underline;">Transit Received</td>
                <td align="center" class="bold" colspan="2" style="color:red;">Missing</td>
                <td align="center" class="bold" colspan="2">Delivery</td>
                <td align="center" class="bold" colspan="2">Pending Delivery</td>
            </tr>
            <tr class="">
                <td align="center" class="bold"></td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: #000;">Art </td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color:#f1f124;color:#000;">Art </td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: #000;">Art </td>
                <td align="center" class="bold" style="color:red;">LR </td>
                <td align="center" class="bold" style="color:red;background-color: #f1f124;">Art </td>
                <td align="center" class="bold" style="color:red;">LR </td>
                <td align="center" class="bold" style="color:red;background-color: #f1f124;">Art </td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: #000;">Art </td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: #000;">Art </td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: #000;">Art </td>
                <td align="center" class="bold" style="color:red;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: red;">Art </td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: #000;">Art </td>
            </tr>
        </thead>
        <tbody class="body_table">
            <?php $_smarty_tpl->_assignInScope('snos', 1);?>
            <?php $_smarty_tpl->_assignInScope('booked_lr', 0);?>
            <?php $_smarty_tpl->_assignInScope('booked_art', 0);?>
            <?php $_smarty_tpl->_assignInScope('local_lr', 0);?>
            <?php $_smarty_tpl->_assignInScope('local_art', 0);?>
            <?php $_smarty_tpl->_assignInScope('direct_load_lr', 0);?>
            <?php $_smarty_tpl->_assignInScope('direct_load_art', 0);?>
            <?php $_smarty_tpl->_assignInScope('hub_load_lr', 0);?>
            <?php $_smarty_tpl->_assignInScope('hub_load_art', 0);?>
            <?php $_smarty_tpl->_assignInScope('direct_pending_lr', 0);?>
            <?php $_smarty_tpl->_assignInScope('direct_pending_art', 0);?>
            <?php $_smarty_tpl->_assignInScope('in_transit_lr', 0);?>
            <?php $_smarty_tpl->_assignInScope('in_transit_art', 0);?>
            <?php $_smarty_tpl->_assignInScope('transit_received_lr', 0);?>
            <?php $_smarty_tpl->_assignInScope('transit_received_art', 0);?>
            <?php $_smarty_tpl->_assignInScope('missing_lr', 0);?>
            <?php $_smarty_tpl->_assignInScope('missing_art', 0);?>
            <?php $_smarty_tpl->_assignInScope('delivery_lr', 0);?>
            <?php $_smarty_tpl->_assignInScope('delivery_art', 0);?>
            <?php $_smarty_tpl->_assignInScope('pending_lr', 0);?>
            <?php $_smarty_tpl->_assignInScope('pending_art', 0);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['results']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align='center'><?php echo $_smarty_tpl->tpl_vars['snos']->value;?>
</td>
                    <td align='center'><?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_name;?>
</td>
                    <td align='center'><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                    <td align='center'>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->booked_count > 0) {?>
                            <a href="javascript:;" onclick="getTransitlrDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_code;?>
','NA','<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
');"><?php echo $_smarty_tpl->tpl_vars['row']->value->booked_count;?>
</a>
                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->booked_count;?>

                        <?php }?>
                    </td>
                    <td align='center' style="background-color: #f1f124; color: #000;"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->article_count)===null||$tmp==='' ? '0' : $tmp);?>
</td>
                    <td align='center' style="color: #000;">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->local_load_count > 0) {?>
                            <a href="javascript:;" onclick="getTransitlrDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_code;?>
','CLOD','<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
');">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->local_load_count;?>

                            </a>
                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->local_load_count;?>

                        <?php }?>
                    </td>
                    <td align='center' style="background-color: #f1f124; color: #000;"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->local_load_article_count)===null||$tmp==='' ? '0' : $tmp);?>
</td>
                    <td align='center' style="color: #000;">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->direct_load_count > 0) {?>
                            <a href="javascript:;" onclick="getTransitlrDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_code;?>
','CDLD','<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
');">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->direct_load_count;?>

                            </a>
                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->direct_load_count;?>

                        <?php }?>
                    </td>
                    <td align='center' style="background-color: #f1f124; color: #000;"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->direct_load_article_count)===null||$tmp==='' ? '0' : $tmp);?>
</td>
                    <td align='center' style="color: red;">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->hub_load_count > 0) {?>
                            <a href="javascript:;" onclick="getTransitlrDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_code;?>
','CHLD','<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
');">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->hub_load_count;?>

                            </a>
                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->hub_load_count;?>

                        <?php }?>
                    </td>
                    <td align='center' style="background-color: #f1f124; color: red;"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->hub_load_article_count)===null||$tmp==='' ? '0' : $tmp);?>
</td>
                    <td align='center' style="color: red">
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
                    <td align='center' style="background-color: #f1f124; color:red;"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->pending_article_count)===null||$tmp==='' ? '0' : $tmp);?>
</td>
                    <td align='center' style="color: #000;">
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
                    <td align='center' style="background-color: #f1f124; color: #000;"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->loaded_article_count)===null||$tmp==='' ? '0' : $tmp);?>
</td>
                    <td align='center' style="color: #000;">
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
                    <td align='center' style="background-color: #f1f124; color: #000;"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->unloaded_article_count)===null||$tmp==='' ? '0' : $tmp);?>
</td>
                    <td align='center' style="color: #000;">
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
                    <td align='center' style="background-color: #f1f124;color:red;"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->missed_article_count)===null||$tmp==='' ? '0' : $tmp);?>
</td>
                    <td align='center' style="color: #000;">
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
                    <td align='center' style="background-color: #f1f124; color: #000;"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->reached_article_count)===null||$tmp==='' ? '0' : $tmp);?>
</td>
                    <td align='center' style="color: #000;">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->pending_delivery_count > 0) {?>
                            <a href="javascript:;" onclick="getTransitlrDetails('<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_code;?>
','CPLD','<?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
');">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->pending_delivery_count;?>

                            </a>
                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->pending_delivery_count;?>

                        <?php }?>
                    </td>
                    <td align='center' style="background-color: #f1f124; color: #000;"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->pending_delivery_article_count)===null||$tmp==='' ? '0' : $tmp);?>
</td>
                </tr>
                <?php $_smarty_tpl->_assignInScope('snos', $_smarty_tpl->tpl_vars['snos']->value+1);?>
                <?php $_smarty_tpl->_assignInScope('booked_lr', $_smarty_tpl->tpl_vars['booked_lr']->value+$_smarty_tpl->tpl_vars['row']->value->booked_count);?>
                <?php $_smarty_tpl->_assignInScope('booked_art', $_smarty_tpl->tpl_vars['booked_art']->value+$_smarty_tpl->tpl_vars['row']->value->article_count);?>
                <?php $_smarty_tpl->_assignInScope('local_lr', $_smarty_tpl->tpl_vars['local_lr']->value+$_smarty_tpl->tpl_vars['row']->value->local_load_count);?>
                <?php $_smarty_tpl->_assignInScope('local_art', $_smarty_tpl->tpl_vars['local_art']->value+$_smarty_tpl->tpl_vars['row']->value->local_load_article_count);?>
                <?php $_smarty_tpl->_assignInScope('direct_load_lr', $_smarty_tpl->tpl_vars['direct_load_lr']->value+$_smarty_tpl->tpl_vars['row']->value->direct_load_count);?>
                <?php $_smarty_tpl->_assignInScope('direct_load_art', $_smarty_tpl->tpl_vars['direct_load_art']->value+$_smarty_tpl->tpl_vars['row']->value->direct_load_article_count);?>
                <?php $_smarty_tpl->_assignInScope('hub_load_lr', $_smarty_tpl->tpl_vars['hub_load_lr']->value+$_smarty_tpl->tpl_vars['row']->value->hub_load_count);?>
                <?php $_smarty_tpl->_assignInScope('hub_load_art', $_smarty_tpl->tpl_vars['hub_load_art']->value+$_smarty_tpl->tpl_vars['row']->value->hub_load_article_count);?>
                <?php $_smarty_tpl->_assignInScope('direct_pending_lr', $_smarty_tpl->tpl_vars['direct_pending_lr']->value+$_smarty_tpl->tpl_vars['row']->value->pending_count);?>
                <?php $_smarty_tpl->_assignInScope('direct_pending_art', $_smarty_tpl->tpl_vars['direct_pending_art']->value+$_smarty_tpl->tpl_vars['row']->value->pending_article_count);?>
                <?php $_smarty_tpl->_assignInScope('in_transit_lr', $_smarty_tpl->tpl_vars['in_transit_lr']->value+$_smarty_tpl->tpl_vars['row']->value->loaded_count);?>
                <?php $_smarty_tpl->_assignInScope('in_transit_art', $_smarty_tpl->tpl_vars['in_transit_art']->value+$_smarty_tpl->tpl_vars['row']->value->loaded_article_count);?>
                <?php $_smarty_tpl->_assignInScope('transit_received_lr', $_smarty_tpl->tpl_vars['transit_received_lr']->value+$_smarty_tpl->tpl_vars['row']->value->unloaded_count);?>
                <?php $_smarty_tpl->_assignInScope('transit_received_art', $_smarty_tpl->tpl_vars['transit_received_art']->value+$_smarty_tpl->tpl_vars['row']->value->unloaded_article_count);?>
                <?php $_smarty_tpl->_assignInScope('missing_lr', $_smarty_tpl->tpl_vars['missing_lr']->value+$_smarty_tpl->tpl_vars['row']->value->missed_count);?>
                <?php $_smarty_tpl->_assignInScope('missing_art', $_smarty_tpl->tpl_vars['missing_art']->value+$_smarty_tpl->tpl_vars['row']->value->missed_article_count);?>
                <?php $_smarty_tpl->_assignInScope('delivery_lr', $_smarty_tpl->tpl_vars['delivery_lr']->value+$_smarty_tpl->tpl_vars['row']->value->reached_count);?>
                <?php $_smarty_tpl->_assignInScope('delivery_art', $_smarty_tpl->tpl_vars['delivery_art']->value+$_smarty_tpl->tpl_vars['row']->value->reached_article_count);?>
                <?php $_smarty_tpl->_assignInScope('pending_lr', $_smarty_tpl->tpl_vars['pending_lr']->value+$_smarty_tpl->tpl_vars['row']->value->pending_delivery_count);?>
                <?php $_smarty_tpl->_assignInScope('pending_art', $_smarty_tpl->tpl_vars['pending_art']->value+$_smarty_tpl->tpl_vars['row']->value->pending_delivery_article_count);?>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
        <?php if (count($_smarty_tpl->tpl_vars['results']->value) > 0) {?>
            <tr class="active">
                <td align="right" class="bold"></td>
                <td align="right" class="bold"></td>
                <td align="right" class="bold"></td>

                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['booked_lr']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['booked_art']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['local_lr']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['local_art']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['direct_load_lr']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['direct_load_art']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['hub_load_lr']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['hub_load_art']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['direct_pending_lr']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['direct_pending_art']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['in_transit_lr']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['in_transit_art']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['transit_received_lr']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['transit_received_art']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['missing_lr']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['missing_art']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['delivery_lr']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['delivery_art']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['pending_lr']->value;?>
</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['pending_art']->value;?>
</td>

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
