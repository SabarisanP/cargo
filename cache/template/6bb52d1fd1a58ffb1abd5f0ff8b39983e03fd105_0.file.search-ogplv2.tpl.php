<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-25 17:20:20
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\search-ogplv2.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667aaefcb8c7b7_11352585',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '6bb52d1fd1a58ffb1abd5f0ff8b39983e03fd105' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\search-ogplv2.tpl',
      1 => 1719316133,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667aaefcb8c7b7_11352585 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
if (isNotNull($_REQUEST['transitCode']) || (isNotNull($_REQUEST['vehicleCode']) && $_smarty_tpl->tpl_vars['vehicleInfo']->value->transitStatusCode == 'INTRN')) {?>
    <?php $_smarty_tpl->_assignInScope('transit', $_smarty_tpl->tpl_vars['transitList']->value[0]);?>

    <?php $_smarty_tpl->_assignInScope('transitStations', array());?>
    <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['transitStations']) ? $_smarty_tpl->tpl_vars['transitStations']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[$_smarty_tpl->tpl_vars['transit']->value->fromStation->code] = $_smarty_tpl->tpl_vars['transit']->value->fromStation->name;
$_smarty_tpl->_assignInScope('transitStations', $_tmp_array);?>
    <?php $_smarty_tpl->_assignInScope('viaStations', array());?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transit']->value->viaStations, 'via');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['via']->value) {
?>
        <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['viaStations']) ? $_smarty_tpl->tpl_vars['viaStations']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[] = $_smarty_tpl->tpl_vars['via']->value->name;
$_smarty_tpl->_assignInScope('viaStations', $_tmp_array);?>
        <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['transitStations']) ? $_smarty_tpl->tpl_vars['transitStations']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[$_smarty_tpl->tpl_vars['via']->value->code] = $_smarty_tpl->tpl_vars['via']->value->name;
$_smarty_tpl->_assignInScope('transitStations', $_tmp_array);?>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    <?php $_smarty_tpl->_assignInScope('viaOrganizations', array());?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transit']->value->transitOrganizations, 'via');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['via']->value) {
?>
        <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['viaOrganizations']) ? $_smarty_tpl->tpl_vars['viaOrganizations']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[] = $_smarty_tpl->tpl_vars['via']->value->name;
$_smarty_tpl->_assignInScope('viaOrganizations', $_tmp_array);?>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    <div class="row">
        <div class="col-md-8">
            <div class="panel panel-default">
                <div class="heading_b">Transit Details</div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-12 h5"><b>Code :</b> <?php echo $_smarty_tpl->tpl_vars['transit']->value->aliasCode;?>
 <a href="javascript:;" title="Click to get Transit History" onclick="getTransitHistory('<?php echo $_smarty_tpl->tpl_vars['transit']->value->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['transit']->value->aliasCode;?>
')"><i class="fa fa-history" aria-hidden="true"></i></a></div>
                        <div class="col-md-12">
                            <b>Mode of Transit :</b> 
                            <?php if ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'TRNT') {?>
                                <span class="label label-success">OutStation</span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'INTRNT') {?>
                                <span class="label label-default">Local Transit</span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'HBTRNT') {?>
                                <span class="label label-success">Link Transit</span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'OTFD') {?>
                                <span class="label label-warning">Out For Delivery</span>
                            <?php }?>
                        </div>

                        <div class="clearfix"></div><br>

                        <div class="col-md-4 h5">
                            <b>From :</b>
                            <?php if ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'TRNT' || $_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'HBTRNT') {?>
                                <?php echo $_smarty_tpl->tpl_vars['transit']->value->fromStation->name;?>

                            <?php } elseif ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'INTRNT' || $_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'OTFD') {?>
                                <?php echo $_smarty_tpl->tpl_vars['transit']->value->fromOrganization->name;?>

                            <?php }?>
                            <span class="text-muted"><?php if ($_smarty_tpl->tpl_vars['transit']->value->departureMinutes) {?>, <?php echo min_to_time($_smarty_tpl->tpl_vars['transit']->value->departureMinutes);
}?></span>
                        </div>
                        <div class="col-md-6 h5" id="ogpl-search-tolabel-cont">
                            <b>To :</b>
                            <?php if ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'TRNT' || $_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'HBTRNT') {?>
                                <?php echo $_smarty_tpl->tpl_vars['transit']->value->toStation->name;?>

                            <?php } elseif ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'INTRNT' || $_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'OTFD') {?>
                                <?php echo $_smarty_tpl->tpl_vars['transit']->value->toOrganization->name;?>

                            <?php }?>
                            <span class="text-muted"><?php if ($_smarty_tpl->tpl_vars['transit']->value->arrivalMinutes) {?>, <?php echo min_to_time($_smarty_tpl->tpl_vars['transit']->value->arrivalMinutes);
}?></span> &nbsp;
                            <?php if ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'TRNT') {?>
                                <?php if ($_smarty_tpl->tpl_vars['is_super_namespace']->value == 1 || (!in_array('COMPLETE',$_smarty_tpl->tpl_vars['transit']->value->activity) && $_smarty_tpl->tpl_vars['action_rights']->value['OGPL-EDT-RTE'] == 1)) {?>
                                    <small><a href="javascript:;" onclick="editOGPLToStation('<?php echo $_smarty_tpl->tpl_vars['transit']->value->toStation->code;?>
')"><i class="fa fa-pencil"></i> Change</a></small>
                                <?php }?>
                            <?php }?>
                        </div>
                        <div class="col-md-6 hide" id="ogpl-search-toselect-cont">
                            <div class="form-inline">
                                <label for="ogpl-search-to" class="col-md-6 w-auto pt10 req">To :</label>
                                <div class="input-group col-md-6">
                                    <select id="ogpl-search-to" class="form-control">
                                        <option value="" selected="">Select To</option>
                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stations']->value, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value) {
?>
                                            <?php if (!isset($_smarty_tpl->tpl_vars['transitStations']->value[$_smarty_tpl->tpl_vars['station']->value['code']])) {?>
                                                <option value="<?php echo $_smarty_tpl->tpl_vars['station']->value['code'];?>
"><?php echo $_smarty_tpl->tpl_vars['station']->value['name'];?>
</option>
                                            <?php }?>
                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12"><b>Via :</b>
                        
                            <?php if ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'TRNT' || $_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'HBTRNT') {?>
                                <?php echo implode(', ',$_smarty_tpl->tpl_vars['viaStations']->value);?>

                            <?php } elseif ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'INTRNT' || $_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'OTFD') {?>
                                <?php echo implode(', ',$_smarty_tpl->tpl_vars['viaOrganizations']->value);?>

                            <?php }?>
                        </div>
                    </div>

                    <hr>

                    <div class="row">
                        <div class="col-md-2 pb20"><b>Driver 1 :</b><br> <?php echo $_smarty_tpl->tpl_vars['transit']->value->vehicleDriver->name;?>
<br> <?php echo $_smarty_tpl->tpl_vars['transit']->value->vehicleDriver->mobileNumber;?>
</div>
                        <div class="col-md-2 pb20"><b>Driver 2 :</b><br> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['transit']->value->secondaryDriver->name)===null||$tmp==='' ? '-' : $tmp);?>
<br> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['transit']->value->secondaryDriver->mobileNumber)===null||$tmp==='' ? '-' : $tmp);?>
</div>

                        <?php if ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'TRNT') {?>
                            <?php if ($_smarty_tpl->tpl_vars['is_super_namespace']->value == 1 || (!in_array('COMPLETE',$_smarty_tpl->tpl_vars['transit']->value->activity) && $_smarty_tpl->tpl_vars['action_rights']->value['OGPL-EDT-RTE'] == 1)) {?>
                                <div class="col-md-6 b_l">
                                    <div class="col-md-10">
                                        <div class="form-group">
                                            <label for="ogpl-search-via" class="w-auto">Do you want to add via station into this transit :</label>
                                            <div class="input-group col-md-11 ogpl-via-stations">
                                                <select id="ogpl-search-via" class="form-control w-100" multiple="multiple">
                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stations']->value, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value) {
?>
                                                        <?php if (!isset($_smarty_tpl->tpl_vars['transitStations']->value[$_smarty_tpl->tpl_vars['station']->value['code']])) {?>
                                                            <option value="<?php echo $_smarty_tpl->tpl_vars['station']->value['code'];?>
"><?php echo $_smarty_tpl->tpl_vars['station']->value['name'];?>
</option>
                                                        <?php }?>
                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            <?php }?>
                        <?php }?>

                        <br>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['transit']->value->remarks)) {?>
                            <div class="col-md-12"><b>Remarks :</b> <?php echo $_smarty_tpl->tpl_vars['transit']->value->remarks;?>
</div>
                        <?php }?>
                    </div>

                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="heading_b">Last Transit Details</div>
                <div class="panel-body">
                                        <span><b>Recent Activity :</b> <?php echo $_smarty_tpl->tpl_vars['transit']->value->recentActivity->event;?>
, <span class="text-muted"><?php echo $_smarty_tpl->tpl_vars['transit']->value->recentActivity->organization->station->name;?>
</span></span><br>
                    <span><b>Last Updated At :</b> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['transit']->value->recentActivity->updatedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</span><br>
                    <span><b>Created At :</b> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['transit']->value->transitCargoDetails[0]->audit->updatedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</span><br>
                    <span><b>Created By :</b> <?php echo $_smarty_tpl->tpl_vars['transit']->value->transitCargoDetails[0]->audit->user->name;?>
</span>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix"></div><br>

    <?php if ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'TRNT' || $_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'HBTRNT') {?>
        <div class="row">
            <?php if (count($_smarty_tpl->tpl_vars['transit']->value->transitRoutes)) {?>
                <div class="col-md-12 pb20">
                    <div class="panel panel-default">
                        <div class="heading_b">Station Details</div>
                        <div class="panel-body">
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transit']->value->transitRoutes, 'route');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['route']->value) {
?>
                                <div class="loaded-ogpl-tile">
                                    <b><?php echo $_smarty_tpl->tpl_vars['route']->value->organization->name;?>
</b><br>
                                    <small class="text-muted"><?php echo $_smarty_tpl->tpl_vars['route']->value->organization->station->name;?>
</small>
                                    <br>
                                    <?php if ($_smarty_tpl->tpl_vars['route']->value->loadedCount > 0) {?>
                                        <span class="badge badge-success" title="Loaded Count"><i class="fa fa-level-up" aria-hidden="true"></i> <?php echo $_smarty_tpl->tpl_vars['route']->value->loadedCount;?>
</span>
                                    <?php }?>
                                    <?php if ($_smarty_tpl->tpl_vars['route']->value->unloadedCount > 0) {?>
                                        <span class="badge badge-warning" title="Unloaded Count"><i class="fa fa-level-down" aria-hidden="true"></i> <?php echo $_smarty_tpl->tpl_vars['route']->value->unloadedCount;?>
</span>
                                    <?php }?>
                                    <?php if ($_smarty_tpl->tpl_vars['route']->value->pendingUnloadCount > 0) {?>
                                        <span class="badge badge-danger" title="Pending Unloaded Count"><i class="fa fa-level-down" aria-hidden="true"></i> <?php echo $_smarty_tpl->tpl_vars['route']->value->pendingUnloadCount;?>
</span>
                                    <?php }?>
                                </div>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </div>
                    </div>
                </div>
            <?php }?>
        </div>
    <?php }?>

    <?php if ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'TRNT' || $_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'HBTRNT' || $_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'INTRNT' || $_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'OTFD') {?>
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="col-md-12">
                    <div class="alert pull-right" id="ogpl-summary-state" style="display: none"></div>
                </div>
                <div class="col-md-9">
                    <?php if (in_array('NEW-OGPL',$_smarty_tpl->tpl_vars['transit']->value->activity)) {?>
                        <button class="btn btn-success" type="button" onclick="setEmptyLoad('<?php echo $_smarty_tpl->tpl_vars['transit']->value->code;?>
')">Set Empty Load</button>
                    <?php }?>
                </div>
                <div class="col-md-3 text-right">
                    <?php if (in_array('NEW-OGPL',$_smarty_tpl->tpl_vars['transit']->value->activity)) {?>
                        <button class="btn btn-primary" type="button" onclick="showAddOGPL()">Add new OGPL</button>&nbsp;
                    <?php }?>
    
                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['SHOW-OGPL-RFSH'] == 1 && $_smarty_tpl->tpl_vars['transit']->value->toStation->code == $_smarty_tpl->tpl_vars['login_station']->value && !in_array('NEW-OGPL',$_smarty_tpl->tpl_vars['transit']->value->activity)) {?>
                        <button class="btn btn-primary" type="button" onclick="refreshOGPLV2('<?php echo $_smarty_tpl->tpl_vars['transit']->value->code;?>
')">Refresh</button>&nbsp;
                    <?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['transit']->value->transitStatus->code != "EMPLD") {?>
                        <button class="btn btn-success" type="button" onclick="saveAndLoadOgpl('<?php echo $_smarty_tpl->tpl_vars['transit']->value->code;?>
')">Save & Load</button>
                    <?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['transit']->value->transitCargoDetails[0]->fromOrganization->code == $_smarty_tpl->tpl_vars['login_branch']->value) {?>
                            <?php if ($_smarty_tpl->tpl_vars['odoDetails']->value->startOdometer == 0) {?>
                                <button class="btn btn-warning" type="button" id="transit-trip-btn" onclick="showEmptyStartTripDialog();">Start Trip</button>
                            <?php }?>
                    <?php }?>
                </div>
            </div>
        </div>
    <?php }?>

    <?php echo '<script'; ?>
>
        $('#ogpl-search-via').select2({
            placeholder: 'Select Via Stations'
        });
    <?php echo '</script'; ?>
>
<?php } elseif ($_smarty_tpl->tpl_vars['vehicleInfo']->value->transitStatusCode == 'INTRN') {?>
    <table class="table info_table">
        <thead>
            <tr>
                <th nowrap>Name / <?php echo lang('ogpl');?>
 Code</th>
                <th>Date</th>
                <th>Route</th>
                <th>Vehicle</th>
                <th class="text-right">Loaded</th>
                <th class="text-right">Unloaded</th>
                <th class="text-right" nowrap>Total <?php echo lang('lr');?>
</th>
                <th>Remarks</th>
                <th class="text-center">Action</th>
            </tr>
        </thead>
        <tbody>

            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transitList']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td nowrap>
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
 <br>
                        <span class="txt_green"><?php echo $_smarty_tpl->tpl_vars['row']->value->aliasCode;?>
</span>
                    </td>
                    <td nowrap>
                        <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->tripDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>


                        <?php if ($_smarty_tpl->tpl_vars['row']->value->departureMinutes) {?>
                            <br />
                            <span class="text-muted">
                                <span title="Departure Time"><?php echo min_to_time($_smarty_tpl->tpl_vars['row']->value->departureMinutes*60);?>
</span> to
                                <span title="Arrival Time">
                                    <?php if ($_smarty_tpl->tpl_vars['row']->value->arrivalMinutes > 2880) {?>
                                        <?php echo min_to_time(($_smarty_tpl->tpl_vars['row']->value->arrivalMinutes-2880)*60);?>
 Third Day
                                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->arrivalMinutes > 1440) {?>
                                        <?php echo min_to_time(($_smarty_tpl->tpl_vars['row']->value->arrivalMinutes-1440)*60);?>
 Next Day
                                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->arrivalMinutes) {?>
                                        <?php echo min_to_time($_smarty_tpl->tpl_vars['row']->value->arrivalMinutes*60);?>

                                    <?php }?>
                                </span>
                            </span>
                        <?php }?>
                    </td>
                    <td>
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->fromStation->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->toStation->name;?>
<br />
                        <span class="text-muted">
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->viaStations, 'via', false, 'i', 'v', array (
  'last' => true,
  'iteration' => true,
  'total' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['via']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_v']->value['iteration']++;
$_smarty_tpl->tpl_vars['__smarty_foreach_v']->value['last'] = $_smarty_tpl->tpl_vars['__smarty_foreach_v']->value['iteration'] === $_smarty_tpl->tpl_vars['__smarty_foreach_v']->value['total'];
?>
                                <?php if ($_smarty_tpl->tpl_vars['i']->value < 3) {?>
                                    <?php echo $_smarty_tpl->tpl_vars['via']->value->name;
if (!(isset($_smarty_tpl->tpl_vars['__smarty_foreach_v']->value['last']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_v']->value['last'] : null) && $_smarty_tpl->tpl_vars['i']->value < 4) {?>,<?php }?>
                                <?php }?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <?php if (count($_smarty_tpl->tpl_vars['row']->value->viaStations) > 3) {?>
                                <a href="javascript:;" class="ogpl-via" title="via routes" data-toggle="popover" data-trigger="hover" data-html="true" data-content="
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->viaStations, 'via', false, 'i', 'v', array (
  'last' => true,
  'iteration' => true,
  'total' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['via']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_v']->value['iteration']++;
$_smarty_tpl->tpl_vars['__smarty_foreach_v']->value['last'] = $_smarty_tpl->tpl_vars['__smarty_foreach_v']->value['iteration'] === $_smarty_tpl->tpl_vars['__smarty_foreach_v']->value['total'];
?>
                                        <?php echo $_smarty_tpl->tpl_vars['via']->value->name;?>
<br/>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                    "><i class="fa fa-info-circle"></i></a>
                            <?php }?>
                        </span>
                    </td>
                    <td>
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->registationNumber;?>
<br />
                        <span class="text-muted">
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->vehicleDriver->name;?>
, <?php echo $_smarty_tpl->tpl_vars['row']->value->vehicleDriver->mobileNumber;?>

                        </span>
                    </td>
                    <td align="right">
                        <?php $_smarty_tpl->_assignInScope('loaded_count', 0);?>
                        <?php $_smarty_tpl->_assignInScope('unloaded_count', 0);?>
                        <?php $_smarty_tpl->_assignInScope('total_count', 0);?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->transitCargoDetails, 'list');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['list']->value) {
?>
                            <?php $_smarty_tpl->_assignInScope('loaded_count', $_smarty_tpl->tpl_vars['loaded_count']->value+$_smarty_tpl->tpl_vars['list']->value->loadedCount);?>
                            <?php $_smarty_tpl->_assignInScope('unloaded_count', $_smarty_tpl->tpl_vars['unloaded_count']->value+$_smarty_tpl->tpl_vars['list']->value->unLoadedCount);?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        <?php $_smarty_tpl->_assignInScope('total_count', $_smarty_tpl->tpl_vars['loaded_count']->value+$_smarty_tpl->tpl_vars['unloaded_count']->value);?>
                        <?php echo max($_smarty_tpl->tpl_vars['loaded_count']->value,0);?>

                    </td>
                    <td align="right"><?php echo max($_smarty_tpl->tpl_vars['unloaded_count']->value,0);?>
</td>
                    <td align="right"><?php echo max($_smarty_tpl->tpl_vars['total_count']->value,0);?>
</td>
                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value->remarks;?>
</td>
                    <td align="right" nowrap>
                        <a class="btn btn-primary btn-xs" href="javascript:;" onclick="saveAndLoadOgpl('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
')">Load</a>
                    </td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
    </table>
<?php } else { ?>
    <?php $_smarty_tpl->_assignInScope('transit', $_smarty_tpl->tpl_vars['lastTransit']->value[0]);?>

    <?php $_smarty_tpl->_assignInScope('transitStations', array());?>
    <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['transitStations']) ? $_smarty_tpl->tpl_vars['transitStations']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[$_smarty_tpl->tpl_vars['transit']->value->fromStation->code] = $_smarty_tpl->tpl_vars['transit']->value->fromStation->name;
$_smarty_tpl->_assignInScope('transitStations', $_tmp_array);?>
    <?php $_smarty_tpl->_assignInScope('viaStations', array());?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transit']->value->viaStations, 'via');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['via']->value) {
?>
        <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['viaStations']) ? $_smarty_tpl->tpl_vars['viaStations']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[] = $_smarty_tpl->tpl_vars['via']->value->name;
$_smarty_tpl->_assignInScope('viaStations', $_tmp_array);?>
        <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['transitStations']) ? $_smarty_tpl->tpl_vars['transitStations']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[$_smarty_tpl->tpl_vars['via']->value->code] = $_smarty_tpl->tpl_vars['via']->value->name;
$_smarty_tpl->_assignInScope('transitStations', $_tmp_array);?>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    <?php $_smarty_tpl->_assignInScope('viaOrganizations', array());?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transit']->value->transitOrganizations, 'via');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['via']->value) {
?>
        <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['viaOrganizations']) ? $_smarty_tpl->tpl_vars['viaOrganizations']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[] = $_smarty_tpl->tpl_vars['via']->value->name;
$_smarty_tpl->_assignInScope('viaOrganizations', $_tmp_array);?>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

    <div class="row">
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <b>Vehicle currently available at : </b> <?php echo $_smarty_tpl->tpl_vars['vehicleInfo']->value->transitStation->name;?>
 <br>
                            No In-Transit OGPL found for the selected vehicle/date. &nbsp;
                        </div>
                    </div>

                    <br>

                    <?php if (($_smarty_tpl->tpl_vars['cargo_setting']->value->transitLocationModelCode == 'STN' && (!isNotNull($_smarty_tpl->tpl_vars['vehicleInfo']->value->transitStation->code) || $_smarty_tpl->tpl_vars['vehicleInfo']->value->transitStation->code == $_smarty_tpl->tpl_vars['login_station']->value)) || ($_smarty_tpl->tpl_vars['cargo_setting']->value->transitLocationModelCode == 'BRCH' && (!isNotNull($_smarty_tpl->tpl_vars['vehicleInfo']->value->transitOrganization->code) || $_smarty_tpl->tpl_vars['vehicleInfo']->value->transitOrganization->code == $_smarty_tpl->tpl_vars['login_organization']->value)) || (in_array('FULL-TRK-LOAD',$_smarty_tpl->tpl_vars['transit']->value->activity) && ($_smarty_tpl->tpl_vars['transit']->value->fromStation->code == $_smarty_tpl->tpl_vars['login_station']->value || $_smarty_tpl->tpl_vars['transit']->value->audit->user->organization->code == $_smarty_tpl->tpl_vars['login_organization']->value))) {?>
                        <span class="h4 bold">&emsp;Do you want to create new Transit for this Vehicle? </span> <button class="btn btn-default" onclick="showAddOGPL()">Create New Transit <img src="assets/img/ogpl/v.png" width="24px"></button>
                    <?php }?>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="heading_b">Last Transit Details</div>
                <div class="panel-body">
                    <div class="h5"><b>Code :</b> <?php echo $_smarty_tpl->tpl_vars['transit']->value->aliasCode;?>
 <a href="javascript:;" title="Click to get Transit History" onclick="getTransitHistory('<?php echo $_smarty_tpl->tpl_vars['transit']->value->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['transit']->value->aliasCode;?>
')"><i class="fa fa-history" aria-hidden="true"></i></a>&nbsp;</div>
                    <div>
                        <b>Mode of Transit :</b>
                        <?php if ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'TRNT') {?>
                            <span class="label label-success">OutStation</span>
                        <?php } elseif ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'INTRNT') {?>
                            <span class="label label-default">Local Transit</span>
                        <?php } elseif ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'OTFD') {?>
                            <span class="label label-warning">Out For Delivery</span>
                        <?php }?>
                        <?php if (in_array('EMP-LOAD',$_smarty_tpl->tpl_vars['transit']->value->activity)) {?>
                            <span class="label label-warning">!Empty</span>
                        <?php }?>
                    </div>
                    <br>
                    <span><b>Recent Activity :</b> <?php echo $_smarty_tpl->tpl_vars['transit']->value->recentActivity->event;?>
, <span class="text-muted"><?php echo $_smarty_tpl->tpl_vars['transit']->value->recentActivity->organization->station->name;?>
</span></span><br>
                    <span><b>Last Updated At :</b> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['transit']->value->recentActivity->updatedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</span><br>
                    <span><b>Created At :</b> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['transit']->value->transitCargoDetails[0]->audit->updatedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</span><br>
                    <span><b>Created By :</b> <?php echo $_smarty_tpl->tpl_vars['transit']->value->transitCargoDetails[0]->audit->user->name;?>
</span><br>
                    <br>
                    <div>
                        <b>Route :</b> 
                        <?php if ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'TRNT') {?>
                            <?php echo $_smarty_tpl->tpl_vars['transit']->value->fromStation->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['transit']->value->toStation->name;?>

                        <?php } elseif ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'INTRNT' || $_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'OTFD') {?>
                            <?php echo $_smarty_tpl->tpl_vars['transit']->value->fromOrganization->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['transit']->value->fromOrganization->name;?>

                        <?php }?>
                    </div>
                    <div>
                        <b>Via :</b> 
                        <?php if ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'TRNT') {?>
                            <?php echo implode(', ',$_smarty_tpl->tpl_vars['viaStations']->value);?>

                        <?php } elseif ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'INTRNT' || $_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'OTFD') {?>
                            <?php echo implode(', ',$_smarty_tpl->tpl_vars['viaOrganizations']->value);?>

                        <?php }?>
                    </div>
                    <div><b>Driver :</b> <?php echo $_smarty_tpl->tpl_vars['transit']->value->vehicleDriver->name;?>
, <?php echo $_smarty_tpl->tpl_vars['transit']->value->vehicleDriver->mobileNumber;?>
</div>
                </div>
            </div>
        </div>
    </div>
<?php }?>

    <div id="end-start-trip-dialog" style="display: none">
        <div class="clearfix">
            <a href="javascript:;" class="pull-right" onclick="hideEditStartTripDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
        </div>
        <div id="re-start-trip-panel" class="clearfix" style="padding: 10px 5px;max-height: 600px;overflow-x: hidden;overflow-y: auto;">
            <form onsubmit="return false;">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <img src="assets/img/start-trip.png" width="65%">
                    </div>
                    <div class="col-md-4 text-center">
                        <h4 class="bold">Departure Time</h4>
                        <h5 id="trip-start-date"></h5>
                        <h4 id="trip-start-time"></h4>
                    </div>
                    <div class="col-md-4 text-center">
                        <h5 class="bold">Last odometer Reading</h5>
                        <h5><span id="last-odometer"> <?php echo $_smarty_tpl->tpl_vars['transit']->value->busVehicle->lastOdometer;?>
</span> Km</h5>
                    </div>
                    <div class="clearfix"></div>

                    <div class="col-md-12">
                        <label class="h5">Fill The Following Details To Start Trip</label>
                        <h6 class="bold">Odometer</h6>
                        <div class="row">
                            <div class="col-md-4">
                                <label class="control-label req" for="">Odometer</label>
                                <input type="number" id="re-start-trip-odo" class="form-control no-spin" placeholder="Odometer">
                            </div>
                            <div class="col-md-4 p_l_n">
                                <div class="input-group col-md-12">
                                    <label class="control-label" for="">Supervisor</label>
                                    <select id="re-start-trip-supervisor" class="form-control">
                                        <option value="" selected>Select Supervisor</option>
                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branchContact']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                            <?php if ($_smarty_tpl->tpl_vars['row']->value->category->code == 'SPVSR') {?>
                                                <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>                                    
                                            <?php }?>
                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div id="re-start-trip-expense">
                            <h6 class="bold">Payments</h6>
                            <div class="row">
                                <div id="re-start-trip-hiring-amt">
                                    <div class="col-md-4">
                                        <label class="control-label" for="">Hiring Amount</label>
                                        <input type="number" class="form-control" id="re-start-trip-hire-amount" placeholder="Hiring Amount" step="any">
                                    </div>
                                    <div class="clearfix"></div><br>
                                </div>

                                <div class="col-md-4">
                                    <label class="control-label" for="">Advance Amount</label>
                                    <input type="number" id="re-start-trip-advance-amount" class="form-control no-spin" placeholder="Advance Amount">
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group col-md-12">
                                        <label class="control-label" for="">Payment Mode</label>
                                        <select id="re-start-trip-adv-paymode" class="form-control" onchange="setStartTripTransactionMode();">
                                            <option value="" selected>Payment Mode</option>
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['f_t_mode']->value, 'name', false, 'k', 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['name']->value) {
?>
                                                <option value="<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['name']->value;?>
</option>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?> 
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4 p_l_n">
                                    <label class="control-label" for="">Payment By</label>
                                    <select id="re-start-trip-adv-payby" class="form-control">
                                        <option value="" selected>Payment By</option>
                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['contact']->value, 'con', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['con']->value) {
?>
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['con']->value, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                                                <?php if ($_smarty_tpl->tpl_vars['val']->value->contactCategory->actionCode == 'BRCH') {?>
                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['val']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value->name;?>
</option>
                                                <?php }?>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                    </select>
                                </div>
                                
                                <div class="clearfix"></div><br>
                                <div class="hide" id="re-start-trip-adv-upi-mode-panel">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-upi-orgbank">Organization Bank</label>
                                            <select class="form-control" id="re-start-trip-adv-upi-orgbank">
                                                <option value="">Select Organization Bank</option>
                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['bankdetail']->value, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['val']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value->name;?>
, Acc No: <?php echo $_smarty_tpl->tpl_vars['val']->value->accountNumber;?>
</option>
                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-upi-id">UPI ID</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-upi-id" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-upi-details">Ref. #</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-upi-details" placeholder="Ref. #" autocomplete="off">
                                        </div>
                                    </div>
                                </div>

                                <div class="hide" id="re-start-trip-adv-netbanking-mode-panel">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-netbanking-orgbank">Organization Bank</label>
                                            <select class="form-control" id="re-start-trip-adv-netbanking-orgbank">
                                                <option value="">Select Organization Bank</option>
                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['bankdetail']->value, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['val']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value->name;?>
, Acc No: <?php echo $_smarty_tpl->tpl_vars['val']->value->accountNumber;?>
</option>
                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-netbanking-accholder">Account Holder Name</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-netbanking-accholder" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group" id="re-start-trip-adv-netbanking-bankname-div">
                                            <label for="re-start-trip-adv-netbanking-bankname">Bank Name</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-netbanking-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-netbanking-details">Ref. #</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-netbanking-details" placeholder="Ref. #" autocomplete="off">
                                        </div>
                                    </div>
                                </div>

                                <div class="hide" id="re-start-trip-adv-cheque-mode-panel">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-cheque-payer">Payer Details</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-cheque-payer" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-cheque-no">Cheque No</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-cheque-no" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-cheque-date">Cheque Date</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-cheque-date" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-cheque-bankcity">Bank City</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-cheque-bankcity" maxlength="90" placeholder="Bank City" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group" id="re-start-trip-adv-cheque-bankname-div">
                                            <label for="re-start-trip-adv-cheque-bankname">Bank Name</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-cheque-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-cheque-remarks">Remarks</label>
                                            <input type="text" class="form-control" placeholder="Remarks" id="re-start-trip-adv-cheque-remarks" data-mask="englishonly"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <h6 class="bold">Fuel Expense</h6>
                            <div class="row">
                                <div class="col-md-2">
                                    <label class="control-label" for="">Fuel Litres</label>
                                    <input type="number" id="re-start-trip-fuel-litres" class="form-control no-spin" placeholder="Fuel Litres">
                                </div>
                                <div class="col-md-2">
                                    <label class="control-label" for="">Fuel Rate / Liter</label>
                                    <input type="number" class="form-control" id="re-start-trip-fuel-rate" placeholder="Fuel Rate / Liter" step="any">
                                </div>
                                <div class="col-md-3">
                                    <div class="input-group col-md-12">
                                        <label class="control-label" for="">Vendor</label>
                                        <select id="re-start-trip-fuel-vendor" class="form-control">
                                            <option value="" selected>Select Vendor</option>
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['vendors']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?> 
                                                <?php if ($_smarty_tpl->tpl_vars['row']->value->contactCategory->actionCode == 'RAC') {?>
                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option> 
                                                <?php }?>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-group col-md-12">
                                        <label for="re-start-trip-fuel-payment-mode" class="req">Payment Mode</label>
                                        <select id="re-start-trip-fuel-payment-mode" class="form-control">
                                            <option value="CASH">Cash Payment</option> 
                                            <option value="CRDT">Credit Payment</option> 
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <label class="control-label" for="">Fuel Coupon</label>
                                    <input type="text" class="form-control" id="re-start-trip-fuel-coupon" placeholder="Fuel Coupon">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 text-center"><br>
                        <div id="re-start-trip-action-state"></div>
                        <button type="submit" class="btn btn-warning col-md-3" id="re-start-trip-btn" onclick="startEditTransitV3Trip();" style="float: none;">Start Trip</button>
                                            </div>
                </div>
            </form>
        </div>
    </div>




<?php echo '<script'; ?>
>
    var loadorg =<?php echo json_encode($_smarty_tpl->tpl_vars['loadbranchs']->value);?>

   
    var ogplSearchData = <?php echo json_encode($_smarty_tpl->tpl_vars['transitList']->value);?>
;
    var cargoSetting = <?php echo json_encode($_smarty_tpl->tpl_vars['cargo_setting']->value);?>
;
    var odoDetails = <?php echo json_encode($_smarty_tpl->tpl_vars['odoDetails']->value);?>
;


    var localTransitSearchData = <?php echo json_encode($_smarty_tpl->tpl_vars['localTransit']->value);?>
;

    function editOGPLToStation(toStation) {
        $('#ogpl-search-toselect-cont').removeClass('hide');
        $('#ogpl-search-tolabel-cont').addClass('hide');
        $('#ogpl-search-to').val(toStation).select2().select2('open');
    }

  
    var odoValue = 0;
    function showEmptyStartTripDialog() {
        var data = {};
        data.vehicleCode = ogplSearchData[0].busVehicle.code;
        $.ajax({
            type: "post",
            url: "cargo/get-vehicle-detail",
            data: data,
            dataType: "json",
            success: function (response) {
                
                if(response.status){
                    var result = response.data; 
                    odoValue = response.data.lastOdometer;
                    $('#last-odometer').html(odoValue);
                }
            }
        });
            $('#end-start-trip-dialog').removeClass('hide');
            $('#end-start-trip-dialog').dialog({
                autoOpen: true,
                width: 800,
                modal: true,
                closeOnEscape:true,
                resizable: false
            });
            $('#end-start-trip-dialog .inp_error').removeClass('inp_error');
            $('#re-start-trip-action-state').removeClass('alert alert-danger alert-success').html('');
            $('#re-start-trip-odo, #start-trip-hire-amount, #start-trip-advance-amount, #start-trip-adv-paymode, #start-trip-fuel-litres, #start-trip-fuel-rate, #start-trip-fuel-coupon').val('');
            $('#re-start-trip-supervisor, #start-trip-fuel-vendor, #start-trip-adv-payby').val('').trigger('change');
            $('#re-start-trip-fuel-payment-mode').val('CASH').trigger('change');
            $('#re-start-trip-hiring-amt').removeClass('hide');

            $('#trip-start-date').html(moment().format('DD MMM YYYY'));
            $('#trip-start-time').html(moment().format('hh : mm A'));

           
    }
    
    function startEditTransitV3Trip() {
        
            var data = {}, err = 0;
            data.action = 'DEPARTURE';
            data.transitCode = ogplSearchData[0].code;
            data.transitCargo = {};
            data.transitCargo.code = ogplSearchData[0].code;
            data.fromOrganization = {};
            data.fromOrganization.code = user_login_branch;
            data.startOdometer = Number($('#re-start-trip-odo').val());
            data.departureAt = moment().format('YYYY-MM-DD HH:mm:ss');
            data.fromOrganizationContact = {};
            data.fromOrganizationContact.code = $('#start-trip-supervisor').val();

            $('.inp_error').removeClass('inp_error');
            if (isNaN(data.startOdometer) || data.startOdometer < 0 || data.startOdometer == '') {
                $('#re-start-trip-odo').addClass('inp_error');
                err++;
            }
          

            if (isNull(odoDetails) || (odoDetails && (odoDetails.startOdometer == 0))) {
                // fuel expense
                data.fuelExpenseCode = '';
                data.activeFlag = 1;
                data.fuelDate = moment().format('YYYY-MM-DD');
                data.vehicle = {};
                data.vehicle.code = ogplSearchData[0].busVehicle.code;
                
                data.vendorContact = {};
                data.vendorContact.code = $('#re-start-trip-fuel-vendor').val();

                data.transactionMode = {};
                data.transactionMode.code = $('#re-start-trip-fuel-payment-mode').val();

                data.litres = Number($('#re-start-trip-fuel-litres').val());
                data.pricePerLitre = Number($('#re-start-trip-fuel-rate').val());
                data.totalAmount = data.litres * data.pricePerLitre;
                data.billNumber = $.trim($('#re-start-trip-fuel-coupon').val());

                // hiring amount and advance amount
                data.ogpl = [];
                    var hire = {};
                    hire.code = '';
                    hire.activeFlag = 1;
                    hire.amount = Number($('#re-start-trip-hire-amount').val());
                    hire.remarks = '';

                    hire.user = {};
                    hire.user.code = login_user;

                    hire.transitCargo = {};
                    hire.transitCargo.code = ogplSearchData[0].code;
                    
                    hire.cashbookType = {};
                    hire.cashbookType.code = 'HIRING';

                    if (Number(hire.amount) > 0) {
                        data.ogpl.push(hire);
                    }
                
                var advance = {};

                advance.code = '';
                advance.activeFlag = 1;
                advance.amount = Number($('#re-start-trip-advance-amount').val());
                advance.remarks = '';

                advance.user = {};
                advance.user.code = login_user;

                advance.transitCargo = {};
                advance.transitCargo.code = ogplSearchData[0].code;

                advance.transactionMode = {};
                advance.transactionMode.code = $('#re-start-trip-adv-paymode').val();
                
                advance.cashbookType = {};
                advance.cashbookType.code = 'ADVANCE';

                advance.paymentByContact = {};
                advance.paymentByContact.code = $('#re-start-trip-adv-payby').val();

                if (advance.transactionMode.code == 'UPI') {
                    advance.bankDetails = {};
                    advance.bankDetails.code = $('#re-start-trip-adv-upi-orgbank').val();
                    advance.addAttr1 = $.trim($('#re-start-trip-adv-upi-id').val());
                    advance.addAttr2 = $.trim($('#re-start-trip-adv-upi-details').val());
                } else if (advance.transactionMode.code == 'NBK') {
                    advance.bankDetails = {};
                    advance.bankDetails.code = $('#re-start-trip-adv-netbanking-orgbank').val();
                    advance.addAttr1 = $.trim($('#re-start-trip-adv-netbanking-accholder').val());
                    advance.addAttr2 = $.trim($('#re-start-trip-adv-netbanking-bankname').val());
                    advance.addAttr3 = $.trim($('#re-start-trip-adv-netbanking-details').val());
                } else if (advance.transactionMode.code == 'CHEQUE') {
                    advance.chequeDetails = {};
                    advance.chequeDetails.code = $('#re-start-trip-adv-chq-code').val();
                    advance.chequeDetails.activeFlag = 1;

                    advance.chequeDetails.organization = {};
                    advance.chequeDetails.organization.code = '<?php echo $_smarty_tpl->tpl_vars['login_branch']->value;?>
';

                    advance.chequeDetails.bankDetails = $.trim($('#re-start-trip-adv-cheque-bankname').val());
                    advance.chequeDetails.payerDetails = $.trim($('#re-start-trip-adv-cheque-payer').val());

                    advance.chequeDetails.chequeDate = moment($('#re-start-trip-adv-cheque-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                    advance.chequeDetails.chequeNo = $.trim($('#re-start-trip-adv-cheque-no').val());
                    advance.chequeDetails.bankCity = $.trim($('#re-start-trip-adv-cheque-bankcity').val());

                    advance.chequeDetails.chequeStatus = {};
                    advance.chequeDetails.chequeStatus.code = 'NEW';

                    advance.chequeDetails.remarks = $.trim($('#re-start-trip-adv-cheque-remarks').val());
                }

                if (Number(advance.amount) > 0) {
                data.ogpl.push(advance);
                }

                // advance amount
                if (($.inArray(ogplSearchData[0].cargoActivityType.code, ['OTFD', 'INTRNT']) != -1 && !isNull(hire) && hire.amount != '') || (cargoSetting.userAccountModel.code != 'TXRT' && !isNull(hire) && hire.amount != '') || advance.amount != '' || advance.transactionMode.code != '' || advance.paymentByContact.code != '') {
                    if (!isNull(hire) && hire.amount == '') {
                        $('#re-start-trip-hire-amount').addClass('inp_error');
                        err++;
                    }
                    
                    if (advance.amount == '') {
                        $('#re-start-trip-advance-amount').addClass('inp_error');
                        err++;
                    }

                    if (advance.transactionMode.code == '') {
                        $('#re-start-trip-adv-paymode').addClass('inp_error');
                        err++;
                    }

                    if (advance.paymentByContact.code == '') {
                        $('#re-start-trip-adv-payby').addClass('inp_error');
                        err++;
                    }

                    if (advance.transactionMode.code == 'UPI') {
                        if (advance.addAttr1 == '') {
                            $('#re-start-trip-adv-upi-id').addClass('inp_error');
                            err++;
                        }

                        if ($('#re-start-trip-adv-upi-orgbank').val() == '') {
                            $('#re-start-trip-adv-upi-orgbank').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr2 == '') {
                            $('#re-start-trip-adv-upi-details').addClass('inp_error');
                            err++;
                        }
                    } else if (advance.transactionMode.code == 'NBK') {
                        if (advance.addAttr1 == '') {
                            $('#re-start-trip-adv-netbanking-accholder').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr2 == '') {
                            $('#re-start-trip-adv-netbanking-bankname').addClass('inp_error');
                            err++;
                        }

                        if ($('#re-start-trip-adv-netbanking-orgbank').val() == '') {
                            $('#re-start-trip-adv-netbanking-orgbank').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr3 == '') {
                            $('#re-start-trip-adv-netbanking-details').addClass('inp_error');
                            err++;
                        }
                    } else if (advance.transactionMode.code == 'CHEQUE') {
                        if (advance.chequeDetails.payerDetails == '') {
                            $('#re-start-trip-adv-cheque-payer').addClass('inp_error');
                            err++;
                        }

                        if ($('#re-start-trip-adv-cheque-date').val() == '') {
                            $('#re-start-trip-adv-cheque-date').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.chequeNo == '') {
                            $('#re-start-trip-adv-cheque-no').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.bankDetails == '') {
                            $('#re-start-trip-adv-cheque-bankname').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.bankCity == '') {
                            $('#re-start-trip-adv-cheque-bankcity').addClass('inp_error');
                            err++;
                        }
                    }
                }

                // fuel expense
                if (data.vendorContact.code != '' || data.litres != '' || data.pricePerLitre != '' || data.billNumber != '') {
                    if (data.vendorContact.code == '') {
                        $('#re-start-trip-fuel-vendor').addClass('inp_error');
                        err++;
                    }

                    if (data.litres == '') {
                        $('#re-start-trip-fuel-litres').addClass('inp_error');
                        err++;
                    }

                    if (data.pricePerLitre == '') {
                        $('#re-start-trip-fuel-rate').addClass('inp_error');
                        err++;
                    }

                    if (data.billNumber == '') {
                        $('#re-start-trip-fuel-coupon').addClass('inp_error');
                        err++;
                    }
                }
            }
            
            if(err) {
                $('#re-start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
                $('#re-start-trip-action-state').html('Please enter/select the values in the field that are marked in red');
                return;
            }
            $('#re-start-trip-panel-btn').hide();
            $('#re-start-trip-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
            
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-start-odometer",
                data: data,
                success: function (response) {
                    if (response.status == 1) {       
                        // startOdoUpdated == 1;         
                        $('#re-start-trip-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                        window.setTimeout(function () {
                            hideEditStartTripDialog();
                              checkURL();
                        }, 3000);
                    } else {
                        $('#re-start-trip-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                        $('#re-start-trip-panel-btn').show();
                    }
                }
            });
    }
    function hideEditStartTripDialog() {
            $('#end-start-trip-dialog').dialog('destroy');
            $('#end-start-trip-dialog').hide();
        }
<?php echo '</script'; ?>
><?php }
}
