<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-27 18:24:25
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ogpl-unload-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66548281d2ae08_07581812',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '20f73da5e83b3d40026a7c688f45a227820327a1' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ogpl-unload-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66548281d2ae08_07581812 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="table-responsive" id="ogpl-trip-table-list">
    <?php if (count($_smarty_tpl->tpl_vars['result']->value) == 0) {?>
        <div class="well well-large"> Sorry! No trips were found on the requested date.</div>
    <?php } else { ?>
        <table class="table info_table">
            <thead>
                <tr>
                    <th><?php echo lang('ogpl');?>
 No</th>
                    <th>Date of Dispatch</th>
                    <th>Vehicle Number</th>
                    <th>Driver Name</th>
                    <th>Source</th>
                    <th>Destination</th>
                    <th>Total Loaded</th>
                    <th class="text-center">Action</th>
                </tr>
            </thead>
            <tbody>
            
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                  
                    <?php $_smarty_tpl->_assignInScope('visible', 0);?>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->activityType, 'activityType');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['activityType']->value) {
?>
                        <?php if ($_smarty_tpl->tpl_vars['activityType']->value->code == 'HBTRNT' || $_smarty_tpl->tpl_vars['activityType']->value->code == 'TRNT') {?>
                            <?php $_smarty_tpl->_assignInScope('visible', 1);?>
                            <?php break 1;?>
                        <?php } else { ?>
                            <?php $_smarty_tpl->_assignInScope('visible', 0);?>
                        <?php }?>
                      
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    <?php if ($_smarty_tpl->tpl_vars['visible']->value == 1) {?>    
                            <?php $_smarty_tpl->_assignInScope('loaded_count', 0);?>
                            <?php $_smarty_tpl->_assignInScope('unloaded_count', 0);?>
                            <?php $_smarty_tpl->_assignInScope('total_count', 0);?>
                            <?php $_smarty_tpl->_assignInScope('endOdometer', 0);?>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->transitCargoDetails, 'list');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['list']->value) {
?>
                                <?php $_smarty_tpl->_assignInScope('loaded_count', $_smarty_tpl->tpl_vars['loaded_count']->value+$_smarty_tpl->tpl_vars['list']->value->loadedCount);?>
                                <?php $_smarty_tpl->_assignInScope('unloaded_count', $_smarty_tpl->tpl_vars['unloaded_count']->value+$_smarty_tpl->tpl_vars['list']->value->unLoadedCount);?>
    
                                <?php if ($_smarty_tpl->tpl_vars['list']->value->toStation->code == $_smarty_tpl->tpl_vars['user_org_code']->value) {?>
                                    <?php $_smarty_tpl->_assignInScope('endOdometer', $_smarty_tpl->tpl_vars['list']->value->endOdometer);?>
                                <?php }?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <?php $_smarty_tpl->_assignInScope('unloadType', 'End');?>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->viaStations, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                                <?php $_smarty_tpl->_assignInScope('exit', 0);?>
                                <?php if ($_smarty_tpl->tpl_vars['row']->value->toStation->code == $_smarty_tpl->tpl_vars['org_station_code']->value) {?>
                                    <?php $_smarty_tpl->_assignInScope('unloadType', 'End');?>
                                    <?php $_smarty_tpl->_assignInScope('exit', 1);?> 
                                    <?php break 1;?>
                                <?php } elseif ($_smarty_tpl->tpl_vars['val']->value->code == $_smarty_tpl->tpl_vars['org_station_code']->value) {?>
                                    <?php $_smarty_tpl->_assignInScope('unloadType', 'Arrival');?>
                                <?php }?>
                                <?php if ($_smarty_tpl->tpl_vars['exit']->value) {?>
                                    <?php break 1;?>
                                <?php }?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

                            <?php $_smarty_tpl->_assignInScope('total_count', $_smarty_tpl->tpl_vars['loaded_count']->value+$_smarty_tpl->tpl_vars['unloaded_count']->value);?>
                            <?php $_smarty_tpl->_assignInScope('isEmptyLoad', $_smarty_tpl->tpl_vars['loaded_count']->value == -1);?>

                             <?php if ($_smarty_tpl->tpl_vars['loaded_count']->value > 0 || $_smarty_tpl->tpl_vars['isEmptyLoad']->value || ($_smarty_tpl->tpl_vars['cargo_setting']->value->transitOdometerModelCode == "RTEBSD" && $_smarty_tpl->tpl_vars['endOdometer']->value == 0)) {?>
                                <tr>
                                <td nowrap>
                                                                            <span class="txt_green">
                                            <?php echo $_smarty_tpl->tpl_vars['row']->value->aliasCode;?>

                                            <a href="javascript:;" title="Click to get Transit History" onclick="getTransitHistory('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->aliasCode;?>
')"><i class="fa fa-history" aria-hidden="true"></i></a>
                                        </span>
                                        <?php if ($_smarty_tpl->tpl_vars['isEmptyLoad']->value) {?>
                                            <br> <span class="badge badge-warning">Empty</span>
                                        <?php }?>
                                    </td>
                                    <td nowrap>
                                        <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->audit->updatedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
<br><span class="text-muted"><?php echo time_elapsed_string($_smarty_tpl->tpl_vars['row']->value->audit->updatedAt);?>
</span>
                                    </td>
                                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->registationNumber;?>
</td>
                                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value->vehicleDriver->name;?>
, <?php echo $_smarty_tpl->tpl_vars['row']->value->vehicleDriver->mobileNumber;?>
</td>
                                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value->fromStation->name;?>
</td>
                                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value->toStation->name;?>
</td>
                                    <td><?php echo max($_smarty_tpl->tpl_vars['loaded_count']->value,0);?>
</td>
                                    <td align="right" nowrap>
                                        <a class="btn btn-success btn-xs" href="#cargo/ogpl-unload-lr?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
&vehicleCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
&unloadType=<?php echo $_smarty_tpl->tpl_vars['unloadType']->value;?>
&redirect=unload" onclick="<?php if ($_smarty_tpl->tpl_vars['isEmptyLoad']->value) {?>acceptEmptyUnload('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->toStation->code;?>
')<?php } else { ?>acceptUnloading();<?php }?>" title="Accept Unload">Accept</a>
                                    </td>
                                </tr> 
                            <?php }?>
                        <?php }?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

            </tbody>
        </table>
    <?php }?>
</div>

<?php echo '<script'; ?>
>
    var cargoSetting = <?php echo json_encode($_smarty_tpl->tpl_vars['cargo_setting']->value);?>
;

    $('[data-toggle="popover"]').popover({
        placement: 'right',
        html: true,
        trigger: 'hover'
    });

    function acceptUnloading() {
        if (!confirm('Do you want to accept unloading?')) {
            event && event.preventDefault();
        }
    }

    function acceptEmptyUnload(code, vehicleCode, toOrganizationCode) {
        event && event.preventDefault();
        if (!confirm('Do you want to accept unloading Empty OGPL?')) {
            return false;
        }

        if (cargoSetting.transitOdometerModelCode=="NA") {
            saveEmptyUnload(code);
            return;
        }

        var params = {};
        params.transitCode = code;
        params.vehicleCode = vehicleCode;
        params.toOrganizationCode = toOrganizationCode;
        showEndTripDialog(params, function (e) {
            if (e.data && e.data.success == 1) {
                saveEmptyUnload(code);
            }
        });
    }

    function saveEmptyUnload(code) {
        var data = {};
        data.code = code;

        var loading_overlay = iosOverlay({
            text: "Unloading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + 'cargo/ogplv2-empty-unload',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Unloaded"
                    });
                    getOgplList();
                } else {
                    alert(response.errorDesc);
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Unload Failed!"
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }
<?php echo '</script'; ?>
><?php }
}
