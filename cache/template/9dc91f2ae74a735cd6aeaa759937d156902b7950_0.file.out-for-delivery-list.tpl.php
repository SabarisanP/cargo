<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-03 18:29:41
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\out-for-delivery-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665dbe3dc9bdf1_61563922',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '9dc91f2ae74a735cd6aeaa759937d156902b7950' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\out-for-delivery-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665dbe3dc9bdf1_61563922 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div id="ogpl-trip-list">
    <?php if (count($_smarty_tpl->tpl_vars['result']->value) == 0) {?>
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="well well-large m-0"> Sorry! No trips were found on the requested date.</div>
            </div>
        </div>
    <?php } else { ?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
            <?php if ($_smarty_tpl->tpl_vars['row']->value->cargoActivityType->code == 'OTFD') {?>
                
            <?php $_smarty_tpl->_assignInScope('loaded_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('unloaded_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('total_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('prebook_count', 0);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->transitCargoDetails, 'list');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['list']->value) {
?>
                <?php $_smarty_tpl->_assignInScope('loaded_count', $_smarty_tpl->tpl_vars['loaded_count']->value+$_smarty_tpl->tpl_vars['list']->value->loadedCount);?>
                <?php $_smarty_tpl->_assignInScope('unloaded_count', $_smarty_tpl->tpl_vars['unloaded_count']->value+$_smarty_tpl->tpl_vars['list']->value->unLoadedCount);?>
                <?php if ($_smarty_tpl->tpl_vars['list']->value->transitDetailsType->code == 'DRCLC') {?>
                    <?php $_smarty_tpl->_assignInScope('prebook_count', $_smarty_tpl->tpl_vars['prebook_count']->value+$_smarty_tpl->tpl_vars['list']->value->loadedCount+$_smarty_tpl->tpl_vars['list']->value->unLoadedCount);?>
                <?php }?>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            <?php $_smarty_tpl->_assignInScope('total_count', $_smarty_tpl->tpl_vars['loaded_count']->value+$_smarty_tpl->tpl_vars['unloaded_count']->value);?>
            <?php $_smarty_tpl->_assignInScope('isEmptyLoad', in_array('EMP-LOAD',$_smarty_tpl->tpl_vars['row']->value->activity));?>

            <div class="panel panel-default transit-row p-0" id="transit-<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" data-transitcode="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" data-vehiclecode="<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-3 b_r">
                            <div>
                                <span class="mnu_border btn-xs"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->tripDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</span>&emsp;
                                <?php if ($_smarty_tpl->tpl_vars['row']->value->departureMinutes) {?>
                                    <span class="text-muted small">
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
                            </div>
                            <h4><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->fromOrganization->name)===null||$tmp==='' ? $_smarty_tpl->tpl_vars['row']->value->fromStation->name : $tmp);?>
 - <?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->toOrganization->name)===null||$tmp==='' ? $_smarty_tpl->tpl_vars['row']->value->toStation->name : $tmp);?>
</h4>
                            <b class="h3 bold"><?php echo $_smarty_tpl->tpl_vars['row']->value->aliasCode;?>
</b>
                            <?php if (count($_smarty_tpl->tpl_vars['row']->value->viaStations) > 0) {?>
                                &nbsp;<a href="javascript:;" class="ogpl-via" title="via routes" data-toggle="popover" data-trigger="hover" data-html="true" data-content="
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->viaStations, 'via', false, 'i', 'v', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['via']->value) {
?>
                                    <?php echo $_smarty_tpl->tpl_vars['via']->value->name;?>
<br/>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                "><i class="fa fa-location-arrow"></i> Via</a>
                            <?php }?>

                            &nbsp;<a href="javascript:;" title="Click to get Transit History" onclick="getTransitHistory('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->aliasCode;?>
')"><i class="fa fa-history" aria-hidden="true"></i></a>
                        </div>
                        <div class="col-md-2 text-center b_r">
                            <h4><?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->registationNumber;?>
</h4>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->vehicleDriver->name)) {?>
                                <p class="text-muted"><?php echo $_smarty_tpl->tpl_vars['row']->value->vehicleDriver->name;?>
, <?php echo $_smarty_tpl->tpl_vars['row']->value->vehicleDriver->mobileNumber;?>
</p>
                            <?php }?>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->secondaryDriver->name)) {?>
                                <p class="text-muted"><?php echo $_smarty_tpl->tpl_vars['row']->value->secondaryDriver->name;?>
, <?php echo $_smarty_tpl->tpl_vars['row']->value->secondaryDriver->mobileNumber;?>
</p>
                            <?php }?>
                            <?php if (count($_smarty_tpl->tpl_vars['row']->value->transitReference)) {?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->transitReference, 'transit');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['transit']->value) {
?>
                                    <?php if ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'TRNT') {?>
                                        <a href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['transit']->value->code;?>
" title="Related OGPL" target="_blank"><?php echo $_smarty_tpl->tpl_vars['transit']->value->name;?>
 (<?php echo $_smarty_tpl->tpl_vars['transit']->value->aliasCode;?>
)</a><br>
                                    <?php } elseif ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'INTRNT') {?>
                                        <a href="#cargo/local-transit-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['transit']->value->code;?>
" title="Related Local Transit" target="_blank"><?php echo $_smarty_tpl->tpl_vars['transit']->value->name;?>
 (<?php echo $_smarty_tpl->tpl_vars['transit']->value->aliasCode;?>
)</a><br>
                                    <?php } elseif ($_smarty_tpl->tpl_vars['transit']->value->cargoActivityType->code == 'OTFD') {?>
                                        <a href="#cargo/out-for-delivery-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['transit']->value->code;?>
" title="Related Door Pickup and Delivery" target="_blank"><?php echo $_smarty_tpl->tpl_vars['transit']->value->name;?>
 (<?php echo $_smarty_tpl->tpl_vars['transit']->value->aliasCode;?>
)</a><br>
                                    <?php }?>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <?php }?>
                        </div>
                        <div class="col-md-5">
                            <table class="table" style="table-layout: fixed;">
                                <tr class="row-noborder">
                                    <td><b>Loaded</b></td>
                                    <td>: 
                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->additionalAttribute->CARGO_HUB_LOAD_COUNT > 0) {?>
                                            <span class="badge badge-default" title="Hub Loaded"><?php echo $_smarty_tpl->tpl_vars['row']->value->additionalAttribute->CARGO_HUB_LOAD_COUNT;?>
</span>
                                        <?php }?>
                                        <?php echo max($_smarty_tpl->tpl_vars['loaded_count']->value,0);?>

                                    </td>
                                    <td><b>Actual Weight</b></td>
                                    <td>: <?php echo $_smarty_tpl->tpl_vars['row']->value->totalActualWeight;?>
</td>
                                    <td><b>Total Freight</b></td>
                                    <td>: <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->totalBookedAmount);?>
</td>
                                </tr>
                                <tr class="row-noborder">
                                    <td><b>Unloaded</b></td>
                                    <td>: 
                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->additionalAttribute->CARGO_HUB_UNLOAD_COUNT > 0) {?>
                                            <span class="badge badge-default" title="Hub Unloaded"><?php echo $_smarty_tpl->tpl_vars['row']->value->additionalAttribute->CARGO_HUB_UNLOAD_COUNT;?>
</span>
                                        <?php }?>
                                        <?php echo max($_smarty_tpl->tpl_vars['unloaded_count']->value,0);?>

                                    </td>
                                    <td><b>Billing Weight</b></td>
                                    <td>: <?php echo $_smarty_tpl->tpl_vars['row']->value->totalWeight;?>
</td>
                                    <td><b>Total Charges</b></td>
                                    <td>: 
                                        <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->totalCargoCharge);?>


                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->totalCargoCharge != 0) {?>
                                            <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                                <table>
                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->cargoCharges, 'cv', false, 'ck');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['ck']->value => $_smarty_tpl->tpl_vars['cv']->value) {
?>
                                                        <?php if ($_smarty_tpl->tpl_vars['cv']->value == 0) {?>
                                                            <?php continue 1;?>
                                                        <?php }?>
                                                        <tr>
                                                            <td><b><?php echo _camelcase_to_titlecase($_smarty_tpl->tpl_vars['ck']->value);?>
</b></td>
                                                            <td>&ensp;:&ensp;</td>
                                                            <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['cv']->value);?>
</td>
                                                        </tr>
                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                </table>
                                            '></i>
                                        <?php } else { ?>
                                            <i class="fa fa-info-circle fa-inverse"></i>
                                        <?php }?>
                                    </td>
                                </tr>
                                <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->remarks)) {?>
                                    <tr class="row-noborder">
                                        <td colspan="6"><b>Remarks :</b> <?php echo $_smarty_tpl->tpl_vars['row']->value->remarks;?>
</td>
                                    </tr>
                                <?php }?>
                            </table>
                        </div>
                        <div class="col-md-1 p_l_n">
                            <div class="mnu_border btn-sm m-b-4"  data-toggle="popover" data-trigger="hover" data-html="true" data-content="
                                <table width='700' class='table'>
                                    <tr>
                                        <th>Branch</th>
                                        <th>Loaded</th>
                                        <th>Unloaded</th>
                                        <th>Pending Unload</th>
                                    </tr> 
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->transitRoutes, 'route');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['route']->value) {
?>  
                                        <tr>
                                            <td><?php echo $_smarty_tpl->tpl_vars['route']->value->organization->name;?>
</td>
                                            <td align='right'><?php echo $_smarty_tpl->tpl_vars['route']->value->loadedCount;?>
</td>
                                            <td align='right'><?php echo $_smarty_tpl->tpl_vars['route']->value->unloadedCount;?>
</td>
                                            <td align='right'><?php echo $_smarty_tpl->tpl_vars['route']->value->pendingUnloadCount;?>
</td>
                                        </tr>                      
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </table>
                            ">
                                Total LR
                                <h4 class="text-right bold"><?php if ($_smarty_tpl->tpl_vars['prebook_count']->value > 0) {?><small class="badge badge-primary" data-toggle="tooltip" title="Total Prebook"><?php echo max($_smarty_tpl->tpl_vars['prebook_count']->value,0);?>
</small><?php }?> <?php echo max($_smarty_tpl->tpl_vars['total_count']->value,0);?>
</h4>
                            </div>
                        </div>
                        <div class="col-md-1 text-right">
                            <?php if (!in_array($_smarty_tpl->tpl_vars['row']->value->transitStatus->code,array("CMPLT","TRNSFR ","EMPLD"))) {?>
                                <a class="btn btn-default btn-xs" href="#cargo/add-out-for-delivery?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
" <?php if ($_smarty_tpl->tpl_vars['isEmptyLoad']->value) {?>onclick="alertEmptyLoad()"<?php }?>> <i class="fa fa-pencil"></i> Edit</a>&emsp;
                            <?php }?>
                            <a href="javascript:;" data-toggle="tooltip" title="<?php echo $_smarty_tpl->tpl_vars['row']->value->audit->user->name;?>
 <br/> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->audit->updatedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
 "><i class="fa fa-info-circle"></i></a>
                            <br><br>

                            <?php if ($_smarty_tpl->tpl_vars['row']->value->transitStatus->code == 'EMPLD' || $_smarty_tpl->tpl_vars['isEmptyLoad']->value) {?>
                                <span class="label label-danger">! Empty Load</span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->transitStatus->code == 'NEW') {?>
                                <span class="label label-success">New</span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->transitStatus->code == 'INTRN') {?>
                                <span class="label label-warning">In-Transit</span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->transitStatus->code == 'CMPLT') {?>
                                <span class="label label-danger">Completed</span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->transitStatus->code == 'TRNSFR') {?>
                                <span class="label label-danger">Transferred</span>
                            <?php }?>
                            <br><br>
                            <?php if ($_smarty_tpl->tpl_vars['loaded_count']->value > 0) {?>
                                <a class="btn btn-success btn-xs view-chart-btn pull-right" href="#cargo/out-for-delivery-unload-lr?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
&vehicleCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
" title="Unload" target="_blank">Deliver</a>
                            <?php }?>
                        </div>
                    </div>
                </div>
                <ul class="transit-tabs">
                    <li class="transit-tab b_r"><span class="point_cur" data-toggle="tab" href="#history_tab" data-tab="HISTORY">History</span></li>
                    <li class="transit-tab b_r"><span class="point_cur" data-toggle="tab" href="#route_tab" data-tab="ROUTE">Route</span></li>
                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['EBL-EWAY-BILL'] > 0 && ($_smarty_tpl->tpl_vars['row']->value->additionalAttribute->EWAY_BILL_ADDED_COUNT-$_smarty_tpl->tpl_vars['row']->value->additionalAttribute->EWAY_BILL_VEHICLE_UPDATED_COUNT)) {?>
                        <li class="transit-tab b_r"><span class="point_cur" data-toggle="tab" href="#ewaybill_tab" data-tab="EWAYBILL">EWayBill Part-B</span></li>
                    <?php }?>
                    <li class="transit-tab b_r"><span class="point_cur" data-toggle="tab" href="#fuel_tab" data-tab="FUEL">Fuel Expense</span></li>
                    <li class="transit-tab"><span class="point_cur" data-toggle="tab" href="#payments_tab" data-tab="PAYMENTS">Payments</span></li>
                    <li class=""><a class="btn btn-primary view-chart-btn" href="#cargo/out-for-delivery-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
" title="View Chart" target="_blank">View Chart</a></li>
                </ul>
            </div>
        <?php }?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    <?php }?>
</div>

<?php echo '<script'; ?>
 id="transit-tabscontent-tpl" type="text/template">
    <div id="transit-tabscontent" class="tab-content border_top">
        <div id="history_tab" class="tab-pane fade"></div>
                <div id="fuel_tab" class="tab-pane fade"></div>
        <div id="payments_tab" class="tab-pane fade"></div>
        <div id="route_tab" class="tab-pane fade"></div>
    </div>
<?php echo '</script'; ?>
>

<input type="hidden" id="active-transit-code">

<?php echo '<script'; ?>
>
    var transitListData = <?php echo json_encode($_smarty_tpl->tpl_vars['result']->value);?>
;
    var loading_spinner = "<div class='text-center'><img src='<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
/assets/img/loaders/20.gif' /></div>"

    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover',
        container: '#ofd-list-container'
    });
    $('[data-toggle="tooltip"]').tooltip({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });

    $('#ogpl-trip-list').on('click', '.transit-tabs', function(e) {
        if ($(e.target).is('.view-chart-btn')) {
            $('.transit-row-body.last-active').removeClass('last-active');
            $(e.target).closest('.transit-row').find('.transit-row-body').addClass('last-active');
            return;
        }
        if ($(e.target).closest('.transit-tab.active').length) {
            $('#transit-tabscontent').remove();
            $('.transit-tabs > .transit-tab.active').removeClass('active');
            $('#active-transit-code').val('');
            return false;
        }

        var $transit = $(e.target).closest('.transit-row');

        $('#transit-tabscontent').remove();
        $('.transit-tabs > .transit-tab.active').removeClass('active');
        $('.transit-row-body.last-active').removeClass('last-active');

        $transit.find('.transit-row-body').addClass('last-active');

        var tpl = $('#transit-tabscontent-tpl').html();
        $transit.append(tpl);
    });

    $('#ogpl-trip-list').on('shown.bs.tab', function(e) {
        var tab = $(e.target).data('tab');
        var href = $(e.target).attr('href');

        var $transit = $(e.target).closest('.transit-row');
        var $tab = $transit.find(href);

        var transitCode = $transit.data('transitcode');
        var vehiclecode = $transit.data('vehiclecode');
        $('#active-transit-code').val(transitCode);

        if (tab == 'HISTORY') {
            loadTransitHistory();
        } else if (tab == 'TRANSFER') {
            loadTransitTransfer();
        } else if (tab == 'EWAYBILL') {
            loadEwaybillPartB();
        } else if (tab == 'FUEL') {
            loadTransitFuelExpense();
        } else if (tab == 'PAYMENTS') {
            loadTransitIncomeExpense(vehiclecode);
        } else if (tab == 'ROUTE') {
            loadTransitRoute();
        }

        $('html, body').animate({
            scrollTop: $transit.offset().top - 70
        }, 'fast');
    });

    function alertEmptyLoad() {
        if (!confirm('Do you want to load to Empty Out For Delivery?')) {
            event && event.preventDefault();
        }
    }

    function getActiveTransitData() {
        var transitCode = $('#active-transit-code').val();
        var transitData = _.find(transitListData, o => o.code == transitCode);

        return transitData;
    }

    function loadTransitHistory() {
        var transitData = getActiveTransitData();
        if (!transitData) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;
        data.aliasCode = transitData.aliasCode;
        data.filterType = 'NA';

        $('#history_tab').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/transit-history',
            data: data,
            success: function(res) {
                $('#history_tab').html(res);
                $('#history_tab').find('.popup_top').hide();
            }
        });
    }

    function loadTransitRoute() {
        var transitData = getActiveTransitData();
        if (!transitData) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;

        $('#route_tab').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/ogpl-odometer-report',
            data: data,
            success: function(res) {
                $('#route_tab').html(res);
            }
        });
    }

    function loadTransitFuelExpense() {
        var transitData = getActiveTransitData();
        if (!transitData) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;

        $('#fuel_tab').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/ogpl-fuel-expense',
            data: data,
            success: function(res) {
                $('#fuel_tab').html(res);
            }
        });
    }

    function loadTransitIncomeExpense(vehiclecode) {
        var transitData = getActiveTransitData();
        if (!transitData) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;
        data.vehicleCode = vehiclecode;
        data.ogplType = 'OFD';
        data.cargoActivityType = transitData.cargoActivityType.code;

        $('#payments_tab').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/ogpl-income-expense',
            data: data,
            success: function(res) {
                $('#payments_tab').html(res);
            }
        });
    }
<?php echo '</script'; ?>
>
<?php }
}
