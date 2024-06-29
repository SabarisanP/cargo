<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-27 17:24:11
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ogpl-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667d52e319cb47_29813155',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'ad6e52a420c98b5d7276d5a0436d93fe41b68ae3' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ogpl-list.tpl',
      1 => 1719486444,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667d52e319cb47_29813155 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->smarty->ext->_tplFunction->registerTplFunctions($_smarty_tpl, array (
  'ogplList' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\ad6e52a420c98b5d7276d5a0436d93fe41b68ae3_0.file.ogpl-list.tpl.php',
    'uid' => 'ad6e52a420c98b5d7276d5a0436d93fe41b68ae3',
    'call_name' => 'smarty_template_function_ogplList_912580324667d52e2f0c406_66681729',
  ),
));
?><style>
.badge-small{
  padding: 3px !important;
  font-size: 6pt !important;
}
</style>
<div class="panel panel-default text-center">
    <ul class="nav nav-tabs main-transit-tabs">
        <li class="tab-btn active" data-toggle="tooltip" title="List of vehicles going to arrive in your Branch">
            <a data-toggle="tab" data-tab="ARRIVAL" href="#arrival_pane" data-count="<?php echo count($_smarty_tpl->tpl_vars['tabs']->value['ARRIVAL']);?>
">
                Arrival &nbsp;<small class="text-muted">(<?php echo count($_smarty_tpl->tpl_vars['tabs']->value['ARRIVAL']);?>
)</small><br>
            </a>
        </li>
        <li class="tab-btn" data-toggle="tooltip" title="List of vehicles reached your Branch, Waiting for Departure">
            <a data-toggle="tab" data-tab="DEPARTURE" href="#departure_pane" data-count="<?php echo count($_smarty_tpl->tpl_vars['tabs']->value['DEPARTURE']);?>
">
                Yet to Departure &nbsp;<small class="text-muted">(<?php echo count($_smarty_tpl->tpl_vars['tabs']->value['DEPARTURE']);?>
)</small><br>
            </a>
        </li>
        <li class="tab-btn" data-toggle="tooltip" title="List of vehicles left your branch">
            <a data-toggle="tab" data-tab="INTRANSIT" href="#intransit_pane" data-count="<?php echo count($_smarty_tpl->tpl_vars['tabs']->value['DISPATCH']);?>
">
                Departed / Intransit &nbsp;<small class="text-muted">(<?php echo count($_smarty_tpl->tpl_vars['tabs']->value['DISPATCH']);?>
)</small><br>
            </a>
        </li>
        <li class="tab-btn" data-toggle="tooltip" title="List of Completed Vehicle Transit">
            <a data-toggle="tab" data-tab="COMPLETED" href="#completed_pane" data-count="<?php echo count($_smarty_tpl->tpl_vars['tabs']->value['COMPLETE']);?>
">
                Completed &nbsp;<small class="text-muted">(<?php echo count($_smarty_tpl->tpl_vars['tabs']->value['COMPLETE']);?>
)</small><br>
            </a>
        </li>
    </ul>
</div>

<div class="tab-content" id="ogpl-trip-list">
    <div id="arrival_pane" class="tab-pane fade in active"><?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'ogplList', array('data'=>$_smarty_tpl->tpl_vars['tabs']->value['ARRIVAL'],'tab'=>'ARRIVAL'), true);?>
</div>
    <div id="departure_pane" class="tab-pane fade"><?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'ogplList', array('data'=>$_smarty_tpl->tpl_vars['tabs']->value['DEPARTURE'],'tab'=>'DEPARTURE'), true);?>
</div>
    <div id="intransit_pane" class="tab-pane fade"><?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'ogplList', array('data'=>$_smarty_tpl->tpl_vars['tabs']->value['DISPATCH'],'tab'=>'DISPATCH'), true);?>
 </div>
    <div id="completed_pane" class="tab-pane fade"><?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'ogplList', array('data'=>$_smarty_tpl->tpl_vars['tabs']->value['COMPLETE']), true);?>
</div>
</div>



<div id="ogpl-eway-bill-pdf-dialog" class="hide">
    <a href="javascript:;" class="pull-right" onclick="closeEWayBillPdfDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div id="ogpl-eway-bill-iframe-alert"></div>
    <div id="ogpl-eway-bill-iframe" style="height:90%;width:100%;"></div>
</div>

<?php echo '<script'; ?>
 id="transit-tabscontent-tpl" type="text/template">
    <div id="transit-tabscontent" class="tab-content border_top">
        <div id="history_tab" class="tab-pane fade"></div>
        <div id="transfer_tab" class="tab-pane fade"></div>
        <div id="ewaybill_tab" class="tab-pane fade"></div>
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
    var aliasCodeFilter = <?php echo json_encode($_smarty_tpl->tpl_vars['aliasCodeFilter']->value);?>
;
    var ogplLastActive = <?php echo json_encode($_smarty_tpl->tpl_vars['fogplLastActive']->value);?>
;
    var login_station = <?php echo json_encode($_smarty_tpl->tpl_vars['login_station']->value);?>
;
    var station = <?php echo json_encode($_smarty_tpl->tpl_vars['stations']->value);?>
;
    var login_branch = <?php echo json_encode($_smarty_tpl->tpl_vars['login_branch']->value);?>
;
    var cargoSetting = <?php echo json_encode($_smarty_tpl->tpl_vars['cargo_setting']->value);?>

    var groupedOdameter = <?php echo json_encode($_smarty_tpl->tpl_vars['groupedOdameter']->value);?>

    var loading_spinner = "<div class='text-center'><img src='<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
/assets/img/loaders/20.gif' /></div>"

    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover',
        container: '#find-uncargo-list-container'
    });
    $('[data-toggle="tooltip"]').tooltip({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
    
    $('.popup_msg').popover({
        placement: 'top',
        html: true,
        trigger: 'focus'
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
            getTransitOdometerDetails(transitCode);
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

    if (aliasCodeFilter) {
        let defaultTab = $('.transit-row[data-aliascode="' + aliasCodeFilter + '"]').closest('.tab-pane').attr('id');
        $('.main-transit-tabs [href="#' + defaultTab + '"]').tab('show');
    } else if (ogplLastActive) {
        let $transit = $('#transit-' + ogplLastActive);
        $transit.find('.transit-row-body').addClass('last-active');

        let defaultTab = $transit.closest('.tab-pane').attr('id');
        $('.main-transit-tabs [href="#' + defaultTab + '"]').tab('show');
    } else {
        $('.main-transit-tabs [data-tab][data-count!="0"]:first').tab('show');
    }

    function toggleRouteTab(transitCode) {
        $('#transit-' + transitCode + ' [data-tab="ROUTE"]').trigger('click');
    }

    function toggleHistoryTab(transitCode) {
        $('#transit-' + transitCode + ' [data-tab="HISTORY"]').trigger('click');
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

    var transitOdometerDetails = {};
    function getTransitOdometerDetails(transitCode) {
        var transitData = getActiveTransitData();
        if (!transitData.code) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/get-transit-odometer-details',
            data: data,
            success: function(res) {
                if(res.status == 1) {
                    transitOdometerDetails = res.data;
                }
                loadTransitTransfer(transitData);
            }
        });
    }
    
    function loadTransitTransfer(transitData) {
        if (!transitData) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;
        data.vehicleCode = transitData.busVehicle.code;

        data.show_end_odo = 0;
        var isFTLOGPL =  $.inArray('FULL-TRK-LOAD', transitData.activity) != -1;
        if ($.inArray('PART-TRK-LOAD', transitData.activity) != -1) {
            isFTLOGPL = $.inArray('PART-TRK-LOAD', transitData.activity) != -1;
        }
        if (isNotNull(transitOdometerDetails)) {
            var odoStations = [];
            $.map(transitOdometerDetails || [], function(val) {
                odoStations.push(val.station.code)
            });

            var odoDetails = '';
            $.each(transitOdometerDetails, function(key, row) {
                if ((isFTLOGPL && row.startOdometer > 0) || (row.organization.code == login_branch)){
                    odoDetails = row;
                    return false;
                }
            });

            // var station_in_via = '';
            // // From station
            // if (isNotNull(transitData) && (transitData.fromStation.code == login_station)) {
            //     station_in_via = transitData.fromStation.code
            // }

            // // to station
            // if (isNotNull(transitData) && (transitData.toStation.code == login_station)) {
            //     station_in_via = transitData.fromStation.code
            // }

            // // via station
            // $.each(transitData.viaStations || [], function(key,val) {
            //     if (val.code == login_station) {
            //         station_in_via = val.code;
            //     }
            // });

            // // hub station
            // $.each(transitData.hubViaStations || [], function(key,val) {
            //     if (val.code == login_station) {
            //         station_in_via = val.code;
            //     }
            // });

            // local station
            $.each(transitData.localViaStations || [], function(key,val) {
                if (val.code == login_station) {
                    station_in_via = val.code;
                }
            });
            
            // data.transferEndOdometer = odoDetails.endOdometer;
            // if ((transitOdometerDetails[0].startOdometer > 0) && (isNotNull(station_in_via) && ($.inArray(station_in_via, odoStations) == -1 || (isNotNull(odoDetails) && odoDetails.endOdometer == 0)))) {
            //     data.show_end_odo = 1;
            // }
        }
        
        $('#transfer_tab').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/ogpl-transfer-list',
            data: data,
            success: function(res) {
                $('#transfer_tab').html(res);
            }
        });
    }

    function loadEwaybillPartB() {
        var transitData = getActiveTransitData();
        if (!transitData) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;
        data.vehicleNo = transitData.busVehicle.registationNumber;
        data.ogplFrom = transitData.fromStation.name;

        $('#ewaybill_tab').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/ogpl-ewaylr-list',
            data: data,
            success: function(res) {
                $('#ewaybill_tab').html(res);
                $('#ewaybill_tab').find('.popup_top').hide();
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
        data.ogplType = 'OGPL';
        data.vehicleCode = vehiclecode;
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

    function alertEmptyLoad() {
        if (!confirm('Do you want to load to Empty OGPL?')) {
            event && event.preventDefault();
        }
    }

    function createNewLinkedTransit(transitCode, vehicleCode, transitType) {
        var data = {};
        data.linkTransitCode = transitCode;
        data.linkVehicleCode = vehicleCode;
        if (cargoSetting.ogplModelCode == 'VER3') {
            data.linkTransitType = transitType
        }

        if (!transitCode) {
            return;
        }

        var loading_overlay = iosOverlay({
            text: 'Validating...',
            icon: 'fa fa-spinner fa-spin'
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/validate-transit-linking',
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: 'fa fa-check',
                        text: 'Success'
                    });
                    setTimeout(function () {
                        var params = $.param(data);
                        if (transitType == 'TRNT') {
                            window.open('#cargo/add-ogpl?' + params);
                        } else if (transitType == 'INTRNT') {
                            if (cargoSetting.ogplModelCode == 'VER3') {
                                window.open('#cargo/add-ogpl?' + params);
                            } else {              
                                window.open('#cargo/add-local-transit?' + params);
                            }
                        } else if (transitType == 'OTFD') {
                            if (cargoSetting.ogplModelCode == 'VER3') {
                                window.open('#cargo/add-ogpl?' + params);
                            } else {  
                                window.open('#cargo/add-out-for-delivery?' + params);
                            }
                        }
                    }, 500)
                } else {
                    alert(response.errorDesc);
                    loading_overlay.update({
                        icon: 'fa fa-times',
                        text: 'Failed'
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }

    function showEWayBillPdfDialog(code) {
        $('#ogpl-eway-bill-iframe').html('');
        $('#ogpl-eway-bill-pdf-dialog').css('background', '#fff');
        $('#ogpl-eway-bill-pdf-dialog').removeClass('hide');
        $('#ogpl-eway-bill-pdf-dialog').dialog({
            autoOpen: true,
            height: 700,
            width: 1100,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();

        var $iframe = $('<iframe />');
        $iframe.attr('src', base_url + 'cargo/ogpl-consolidated-eway-bill-pdf?consEwayBillNo=' + code);
        $iframe.attr('class', 'iframe-fullwidth iframe-loading-bg');
        $('#ogpl-eway-bill-iframe').html($iframe);
    }

    function closeEWayBillPdfDialog() {
        $('#ogpl-eway-bill-iframe').html('');
        $('#ogpl-eway-bill-pdf-dialog').dialog('destroy');
        $('#ogpl-eway-bill-pdf-dialog').hide();
        //$('#ogpl-eway-bill-pdf-dialog').dialog('close');
    }

    function showOgplListStatusWise(ele) {
        var filter = $(ele).data('filter');
        $('.filter-btn').css('text-decoration', 'none');
        $(ele).css('text-decoration', 'underline');
        
        if (filter == 'ALL') {
            $('#ogpl-trip-list').find('.transit-row').removeClass('hide');
        } else {
            $('#ogpl-trip-list').find('.transit-row[data-ogplstatus!="'+filter+'"]').addClass('hide');
            $('#ogpl-trip-list').find('.transit-row[data-ogplstatus="'+filter+'"]').removeClass('hide');
        }
    }

    function acceptUnloading() {
        if (!confirm('Do you want to accept unloading?')) {
            event && event.preventDefault();
        }
    }

    function acceptEmptyUnload(code, vehicleCode, toCrganizationCode) {
        event && event.preventDefault();
        if (!confirm('Do you want to accept unloading Empty OGPL?')) {
            return false;
        }

        if (cargoSetting.transitOdometerModelCode == "NA") {
            saveEmptyUnload(code);
            return;
        }

        var params = {};
        params.transitCode = code;
        params.vehicleCode = vehicleCode;
        params.toOrganizationCode = toCrganizationCode;
        showEndTripDialog(params, function (e) {
            if (e.data && e.data.success == 1) {
                // $('#shipment-type-btns').trigger('click');
                getOgplList();
                // saveEmptyUnload(code);
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
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: response.errorDesc
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }
<?php echo '</script'; ?>
>
<?php }
/* smarty_template_function_ogplList_912580324667d52e2f0c406_66681729 */
if (!function_exists('smarty_template_function_ogplList_912580324667d52e2f0c406_66681729')) {
function smarty_template_function_ogplList_912580324667d52e2f0c406_66681729(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('data'=>array()), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>

    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
        
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
        <?php $_smarty_tpl->_assignInScope('isEmptyLoad', in_array('EMP-LOAD',$_smarty_tpl->tpl_vars['row']->value->activity));?>
        <?php $_smarty_tpl->_assignInScope('startTrip', in_array('ORGN-START-TRIP',$_smarty_tpl->tpl_vars['row']->value->activity));?>         <?php $_smarty_tpl->_assignInScope('outForDelivery', in_array('OUT-FR-DLRY',$_smarty_tpl->tpl_vars['row']->value->activity));?> 
        <?php $_smarty_tpl->_assignInScope('consolidateEWayBill', array());?>

                <?php $_smarty_tpl->_assignInScope('unloadType', 'End');?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->viaStations, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
            <?php $_smarty_tpl->_assignInScope('viaStationName', $_smarty_tpl->tpl_vars['val']->value->name);?>
            <?php if ($_smarty_tpl->tpl_vars['row']->value->toStation->code == $_smarty_tpl->tpl_vars['org_station_code']->value) {?>
                <?php $_smarty_tpl->_assignInScope('unloadType', 'End');?>
                <?php break 1;?>
            <?php } else { ?>
                <?php if ($_smarty_tpl->tpl_vars['val']->value->code == $_smarty_tpl->tpl_vars['org_station_code']->value) {?>
                    <?php $_smarty_tpl->_assignInScope('unloadType', 'Arrival');?>
                <?php }?>
            <?php }?>

        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <div class="panel panel-default transit-row p-0" id="transit-<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" data-transitcode="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" data-aliascode="<?php echo $_smarty_tpl->tpl_vars['row']->value->aliasCode;?>
" data-ogplstatus="<?php echo $_smarty_tpl->tpl_vars['row']->value->ogplStatus;?>
" data-vehiclecode="<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
">
            <div class="panel-body transit-row-body">
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
                         <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->activityType, 'type');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['type']->value) {
?>
                                                            <span class="badge badge-small badge-<?php echo $_smarty_tpl->tpl_vars['activityType']->value[$_smarty_tpl->tpl_vars['type']->value->code]['color'];?>
"
                                 data-toggle="tooltip" title="<?php echo $_smarty_tpl->tpl_vars['activityType']->value[$_smarty_tpl->tpl_vars['type']->value->code]['name'];?>
"
                                ><?php echo $_smarty_tpl->tpl_vars['activityType']->value[$_smarty_tpl->tpl_vars['type']->value->code]['code'];?>
</span>
                                                     <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </div>
                        <h5><?php echo $_smarty_tpl->tpl_vars['row']->value->fromStation->name;?>
 <img src="assets/img/ogpl/r.png" width="24px"> <?php echo $_smarty_tpl->tpl_vars['row']->value->toStation->name;?>
 </h5>
                        <b class="h4 bold"><?php echo $_smarty_tpl->tpl_vars['row']->value->aliasCode;?>
</b>
                        <?php if (count($_smarty_tpl->tpl_vars['row']->value->viaStations) > 0) {?>
                            &nbsp;<a href="javascript:;" class="ogpl-via mnu_border" title="via routes" data-toggle="popover" data-trigger="hover" data-html="true" data-content="
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
                            ">&nbsp;<i class="fa fa-location-arrow"></i> Via&nbsp;</a>&nbsp;
                        <?php }?>

                        <a href="javascript:;" onclick="toggleRouteTab('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
')"><img src="assets/img/ogpl/m.png" width="22px"></a>&nbsp;
                        <a href="javascript:;" onclick="toggleHistoryTab('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
')"><img src="assets/img/ogpl/h.png" width="22px"></a>&nbsp;

                        <br>
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
                    <div class="col-md-2 text-center b_r">
                        <h4 class="m-t-4">
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->registationNumber;?>

                            <?php if (($_smarty_tpl->tpl_vars['cargo_setting']->value->ogplModelCode == 'VER2' || $_smarty_tpl->tpl_vars['cargo_setting']->value->ogplModelCode == 'VER3') && $_smarty_tpl->tpl_vars['row']->value->transitStatus->code == 'CMPLT') {?>
                                <div class="btn-group">
                                    <div class="dropdown">
                                        <button type="button" class="btn btn-xs btn-default dropdown-toggle" data-toggle="dropdown">
                                            <i class="fa fa-link"></i> <span class="fa fa-caret-down"></span>
                                        </button>
                                        <ul class="dropdown-menu text-left">
                                            <li><a href="javascript:;" title="Create New Local Transit from this OGPL" onclick="createNewLinkedTransit('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
', 'INTRNT')">Link New Local Transit</a></li>
                                            <li><a href="javascript:;" title="Create New Door Pickup & Door Delivery from this OGPL" onclick="createNewLinkedTransit('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
', 'OTFD')">Link New Door Pickup & Door Delivery</a></li>
                                        </ul>
                                    </div>
                                </div>
                            <?php }?>
                        </h4>
                        <p>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->vehicleDriver->name)) {?>
                                <span class="text-muted"><?php echo $_smarty_tpl->tpl_vars['row']->value->vehicleDriver->name;?>
, <?php echo $_smarty_tpl->tpl_vars['row']->value->vehicleDriver->mobileNumber;?>
</span><br>
                            <?php }?>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->secondaryDriver->name)) {?>
                                <span class="text-muted"><?php echo $_smarty_tpl->tpl_vars['row']->value->secondaryDriver->name;?>
, <?php echo $_smarty_tpl->tpl_vars['row']->value->secondaryDriver->mobileNumber;?>
</span>
                            <?php }?>
                        </p><br>
                    </div>
                    <div class="col-md-5">
                        <div class="m-t-5">
                            <div class="addon-block" data-toggle="tooltip" title="Loaded Count">
                                <span class="btn-danger"><i class="fa fa-level-up"></i></span>
                                <span><?php echo max($_smarty_tpl->tpl_vars['loaded_count']->value,0);?>
</span>
                            </div>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->additionalAttribute->CARGO_HUB_LOAD_COUNT > 0) {?>
                                <div class="addon-block" data-toggle="tooltip" title="Hub Loaded Count">
                                    <span class="bg-danger"><small>HUB</small></span>
                                    <span><?php echo max($_smarty_tpl->tpl_vars['row']->value->additionalAttribute->CARGO_HUB_LOAD_COUNT,0);?>
</span>
                                </div>
                            <?php }?>
                            <div class="addon-block" data-toggle="tooltip" title="Unloaded Count">
                                <span class="btn-warning"><i class="fa fa-level-down"></i></span>
                                <span><?php echo max($_smarty_tpl->tpl_vars['unloaded_count']->value,0);?>
</span>
                            </div>&emsp;
                            <div class="addon-block" data-toggle="tooltip" title="Actual Weight">
                                <span>
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="14px" height="14px" fill="#a5a5a5"><path d="M288 96c0 17.7-14.3 32-32 32s-32-14.3-32-32s14.3-32 32-32s32 14.3 32 32zm58.5 32c3.5-10 5.5-20.8 5.5-32c0-53-43-96-96-96s-96 43-96 96c0 11.2 1.9 22 5.5 32H120c-22 0-41.2 15-46.6 36.4l-72 288c-3.6 14.3-.4 29.5 8.7 41.2S33.2 512 48 512H464c14.8 0 28.7-6.8 37.8-18.5s12.3-26.8 8.7-41.2l-72-288C433.2 143 414 128 392 128H346.5z"/></svg>
                                </span>
                                <span><?php echo $_smarty_tpl->tpl_vars['row']->value->totalActualWeight;?>
</span>
                            </div>
                            <div class="addon-block" data-toggle="tooltip" title="Billing Weight">
                                <span>
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="14px" height="14px" fill="#a5a5a5"><path d="M384 176c0 70.7-57.3 128-128 128s-128-57.3-128-128s57.3-128 128-128s128 57.3 128 128zm7.8-112C359.5 24.9 310.7 0 256 0S152.5 24.9 120.2 64H64C28.7 64 0 92.7 0 128V448c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V128c0-35.3-28.7-64-64-64H391.8zM296 224c0-10.6-4.1-20.2-10.9-27.4l33.6-78.3c3.5-8.1-.3-17.5-8.4-21s-17.5 .3-21 8.4L255.7 184c-22 .1-39.7 18-39.7 40c0 22.1 17.9 40 40 40s40-17.9 40-40z"/></svg>
                                </span>
                                <span><?php echo $_smarty_tpl->tpl_vars['row']->value->totalWeight;?>
</span>
                            </div>&emsp;
                            <div class="addon-block" data-toggle="tooltip" title="Total Freight">
                                <span>
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" width="14px" height="14px" fill="#a5a5a5"><path d="M0 64C0 46.3 14.3 32 32 32H96h16H288c17.7 0 32 14.3 32 32s-14.3 32-32 32H231.8c9.6 14.4 16.7 30.6 20.7 48H288c17.7 0 32 14.3 32 32s-14.3 32-32 32H252.4c-13.2 58.3-61.9 103.2-122.2 110.9L274.6 422c14.4 10.3 17.7 30.3 7.4 44.6s-30.3 17.7-44.6 7.4L13.4 314C2.1 306-2.7 291.5 1.5 278.2S18.1 256 32 256h80c32.8 0 61-19.7 73.3-48H32c-17.7 0-32-14.3-32-32s14.3-32 32-32H185.3C173 115.7 144.8 96 112 96H96 32C14.3 96 0 81.7 0 64z"/></svg>
                                </span>
                                <span><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->totalBookedAmount);?>
</span>
                            </div>
                            <div class="addon-block" data-toggle="tooltip" title="Total Charges">
                                <span>
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="14px" height="14px" fill="#a5a5a5"><path d="M512 80c0 18-14.3 34.6-38.4 48c-29.1 16.1-72.5 27.5-122.3 30.9c-3.7-1.8-7.4-3.5-11.3-5C300.6 137.4 248.2 128 192 128c-8.3 0-16.4 .2-24.5 .6l-1.1-.6C142.3 114.6 128 98 128 80c0-44.2 86-80 192-80S512 35.8 512 80zM160.7 161.1c10.2-.7 20.7-1.1 31.3-1.1c62.2 0 117.4 12.3 152.5 31.4C369.3 204.9 384 221.7 384 240c0 4-.7 7.9-2.1 11.7c-4.6 13.2-17 25.3-35 35.5c0 0 0 0 0 0c-.1 .1-.3 .1-.4 .2l0 0 0 0c-.3 .2-.6 .3-.9 .5c-35 19.4-90.8 32-153.6 32c-59.6 0-112.9-11.3-148.2-29.1c-1.9-.9-3.7-1.9-5.5-2.9C14.3 274.6 0 258 0 240c0-34.8 53.4-64.5 128-75.4c10.5-1.5 21.4-2.7 32.7-3.5zM416 240c0-21.9-10.6-39.9-24.1-53.4c28.3-4.4 54.2-11.4 76.2-20.5c16.3-6.8 31.5-15.2 43.9-25.5V176c0 19.3-16.5 37.1-43.8 50.9c-14.6 7.4-32.4 13.7-52.4 18.5c.1-1.8 .2-3.5 .2-5.3zm-32 96c0 18-14.3 34.6-38.4 48c-1.8 1-3.6 1.9-5.5 2.9C304.9 404.7 251.6 416 192 416c-62.8 0-118.6-12.6-153.6-32C14.3 370.6 0 354 0 336V300.6c12.5 10.3 27.6 18.7 43.9 25.5C83.4 342.6 135.8 352 192 352s108.6-9.4 148.1-25.9c7.8-3.2 15.3-6.9 22.4-10.9c6.1-3.4 11.8-7.2 17.2-11.2c1.5-1.1 2.9-2.3 4.3-3.4V304v5.7V336zm32 0V304 278.1c19-4.2 36.5-9.5 52.1-16c16.3-6.8 31.5-15.2 43.9-25.5V272c0 10.5-5 21-14.9 30.9c-16.3 16.3-45 29.7-81.3 38.4c.1-1.7 .2-3.5 .2-5.3zM192 448c56.2 0 108.6-9.4 148.1-25.9c16.3-6.8 31.5-15.2 43.9-25.5V432c0 44.2-86 80-192 80S0 476.2 0 432V396.6c12.5 10.3 27.6 18.7 43.9 25.5C83.4 438.6 135.8 448 192 448z"/></svg>
                                </span>
                                <span><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->totalCargoCharge);?>
</span>
                            </div>

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
                        </div>
                        <br>
                        <span class="mnu_border btn-xs hover-background">
                            <b>Eway Bill :</b> <?php echo max((($tmp = @$_smarty_tpl->tpl_vars['row']->value->additionalAttribute->EWAY_BILL_VEHICLE_UPDATED_COUNT)===null||$tmp==='' ? 0 : $tmp),0);?>
 out of <?php echo max((($tmp = @$_smarty_tpl->tpl_vars['row']->value->additionalAttribute->EWAY_BILL_ADDED_COUNT)===null||$tmp==='' ? 0 : $tmp),0);?>

                        </span>&nbsp;&nbsp;&nbsp;
                        <?php $_smarty_tpl->_assignInScope('totalCountFull', 0);?>
                        <?php $_smarty_tpl->_assignInScope('SinglePopOverCount', 0);?>
                        <span class="mnu_border btn-xs hover-background" data-toggle="popover" data-trigger="hover" data-html="true" data-content="
                        <table width='100%' class='table'>
                            <tr>
                                <th>Station</th>
                                <th>Start</th>
                                <th>end</th>
                            </tr> 
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groupedOdameter']->value, 'value', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['value']->value) {
?>
                                <?php if ($_smarty_tpl->tpl_vars['row']->value->aliasCode == $_smarty_tpl->tpl_vars['key']->value) {?>
                                    <?php $_smarty_tpl->_assignInScope('totalCount', 0);?>
                                    <?php $_smarty_tpl->_assignInScope('toolTipDisplay', 0);?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['value']->value, 'innervalue', false, 'innerkey');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['innerkey']->value => $_smarty_tpl->tpl_vars['innervalue']->value) {
?>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stations']->value, 'single');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['single']->value) {
?>
                                        <?php if ($_smarty_tpl->tpl_vars['single']->value['code'] == $_smarty_tpl->tpl_vars['innerkey']->value) {?>
                                            <span class ='hide'><?php echo $_smarty_tpl->tpl_vars['totalCount']->value++;?>
</span>
                                            <tr>
                                            <td align = 'left'><?php echo $_smarty_tpl->tpl_vars['single']->value['name'];?>
</td>
                                            <td align = 'center'><?php echo $_smarty_tpl->tpl_vars['innervalue']->value['start'];?>
</td>
                                            <td align = 'center'><?php echo $_smarty_tpl->tpl_vars['innervalue']->value['end'];?>
</td>
                                            <?php if ($_smarty_tpl->tpl_vars['innervalue']->value['start'] || $_smarty_tpl->tpl_vars['innervalue']->value['end']) {?>
                                             <span class ='hide'><?php echo $_smarty_tpl->tpl_vars['toolTipDisplay']->value++;?>
</span>
                                            <?php }?>
                                            </tr>  
                                        <?php }?>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                <?php $_smarty_tpl->_assignInScope('totalCountFull', $_smarty_tpl->tpl_vars['totalCount']->value);?>
                                <?php $_smarty_tpl->_assignInScope('SinglePopOverCount', $_smarty_tpl->tpl_vars['toolTipDisplay']->value);?>
                                <?php }?>                       
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                         
                        </table>"><b>Odometer : </b><?php echo $_smarty_tpl->tpl_vars['SinglePopOverCount']->value;?>
 out of <?php echo $_smarty_tpl->tpl_vars['totalCountFull']->value;?>
 
                        </span>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->additionalAttribute->CONSOLIDATED_EWAY_BILL_NO) {?>
                            <?php $_smarty_tpl->_assignInScope('consolidateEWayBill', explode(',',$_smarty_tpl->tpl_vars['row']->value->additionalAttribute->CONSOLIDATED_EWAY_BILL_NO));?>
                        <?php }?>
                        
                        <?php if (count($_smarty_tpl->tpl_vars['consolidateEWayBill']->value) > 0) {?>
                            <span class="bold">Consolidated Eway Bill :</span>
                            <a href="javascript:;" class="badge badge-pill badge-info popup_msg" data-content='<ul class="p_l_15">
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['consolidateEWayBill']->value, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                                    <li><a href="javascript:;" onclick="showEWayBillPdfDialog(<?php echo $_smarty_tpl->tpl_vars['val']->value;?>
)"><?php echo $_smarty_tpl->tpl_vars['val']->value;?>
</a></li>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </ul>'>C</a>
                        <?php }?>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->remarks)) {?><br>
                            <div class="m-t-4"><b>Remarks :</b> <?php echo $_smarty_tpl->tpl_vars['row']->value->remarks;?>
</div>
                        <?php }?>
                    </div>
                    <div class="col-md-1 p_l_n">
                        <div class="mnu_border btn-sm clearfix" data-toggle="popover" data-trigger="hover" data-html="true" data-content="
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
                            </table>">
                            <small class="pull-right">Total LR</small><br>
                            <span>
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" fill="#e9e9e9" style="width: 35px; display: inline-block;"><path d="M256 48c0-26.5 21.5-48 48-48H592c26.5 0 48 21.5 48 48V464c0 26.5-21.5 48-48 48H381.3c1.8-5 2.7-10.4 2.7-16V253.3c18.6-6.6 32-24.4 32-45.3V176c0-26.5-21.5-48-48-48H256V48zM571.3 347.3c6.2-6.2 6.2-16.4 0-22.6l-64-64c-6.2-6.2-16.4-6.2-22.6 0l-64 64c-6.2 6.2-6.2 16.4 0 22.6s16.4 6.2 22.6 0L480 310.6V432c0 8.8 7.2 16 16 16s16-7.2 16-16V310.6l36.7 36.7c6.2 6.2 16.4 6.2 22.6 0zM0 176c0-8.8 7.2-16 16-16H368c8.8 0 16 7.2 16 16v32c0 8.8-7.2 16-16 16H16c-8.8 0-16-7.2-16-16V176zm352 80V480c0 17.7-14.3 32-32 32H64c-17.7 0-32-14.3-32-32V256H352zM144 320c-8.8 0-16 7.2-16 16s7.2 16 16 16h96c8.8 0 16-7.2 16-16s-7.2-16-16-16H144z"/></svg>
                            </span>
                            <h4 class="pull-right bold d-inline-block m-t-4"><?php echo max($_smarty_tpl->tpl_vars['total_count']->value,0);?>
</h4>
                        </div>
                    </div>
                    <div class="col-md-1 text-right">
                        <?php if (!in_array($_smarty_tpl->tpl_vars['row']->value->transitStatus->code,array("CMPLT","TRNSFR","EMPLD"))) {?>
                            <a class="btn btn-default btn-xs" href="#cargo/add-ogpl?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
&back=ogpl" <?php if ($_smarty_tpl->tpl_vars['isEmptyLoad']->value) {?>onclick="alertEmptyLoad()"<?php }?>> <i class="fa fa-pencil"></i> Edit</a>&emsp;
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
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->transitStatus->code == 'TRSFRLD') {?>
                            <span class="label label-warning">Transfer Load</span>
                        <?php }?>
                    </div>
                </div>
            </div>
            <ul class="transit-tabs">
                <li class="transit-tab"><span class="point_cur" data-toggle="tab" href="#history_tab" data-tab="HISTORY">History</span></li>
                <li class="transit-tab b_l"><span class="point_cur" data-toggle="tab" href="#route_tab" data-tab="ROUTE">Route</span></li>
                <?php if ($_smarty_tpl->tpl_vars['loaded_count']->value > 0) {?>
                    <li class="transit-tab b_l"><span class="point_cur" data-toggle="tab" href="#transfer_tab" data-tab="TRANSFER">Transfer</span></li>
                <?php }?>                    
                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['EBL-EWAY-BILL'] > 0 && ($_smarty_tpl->tpl_vars['row']->value->additionalAttribute->EWAY_BILL_ADDED_COUNT-$_smarty_tpl->tpl_vars['row']->value->additionalAttribute->EWAY_BILL_VEHICLE_UPDATED_COUNT)) {?>
                    <li class="transit-tab b_l"><span class="point_cur" data-toggle="tab" href="#ewaybill_tab" data-tab="EWAYBILL">EWayBill Part-B</span></li>
                <?php }?>
                <li class="transit-tab b_l"><span class="point_cur" data-toggle="tab" href="#fuel_tab" data-tab="FUEL">Fuel Expense</span></li>
                <li class="transit-tab b_l"><span class="point_cur" data-toggle="tab" href="#payments_tab" data-tab="PAYMENTS">Payments</span></li>
                
                <?php if ($_smarty_tpl->tpl_vars['tab']->value == 'ARRIVAL') {?>
                    <?php if (!$_smarty_tpl->tpl_vars['isEmptyLoad']->value) {?>
                        <li class="transit-tab b_l"><a class="tab-link" href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
" title="View Chart" target="_blank">View Chart <i class="fa fa-arrow-right"></i></a></li>
                    <?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->ogplModelCode == 'VER3') {?>
                                                    <?php if ($_smarty_tpl->tpl_vars['isEmptyLoad']->value && !$_smarty_tpl->tpl_vars['startTrip']->value && $_smarty_tpl->tpl_vars['cargo_setting']->value->transitOdometerModelCode == "ORGDTN") {?>
                                <?php if ($_smarty_tpl->tpl_vars['row']->value->transitCargoDetails[0]->fromOrganization->code !== $_smarty_tpl->tpl_vars['login_branch']->value) {?>
                                    <li class=""><a class="btn btn-info view-chart-btn disabled" disabled  href="javascript:void(0);" title="Trip not yet Started">Unload</a></li>
                                <?php } else { ?>
                                    <li class=""><a class="btn btn-info view-chart-btn disabled"  href="javascript:void(0);" title="">Unload</a></li>
                                <?php }?>
                            <?php } else { ?>
                                <?php if ($_smarty_tpl->tpl_vars['row']->value->transitCargoDetails[0]->fromOrganization->code !== $_smarty_tpl->tpl_vars['login_branch']->value) {?>
                                <li class=""><a class="btn btn-info view-chart-btn"  href="#cargo/ogpl-unload-lr?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
&vehicleCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
&unloadType=<?php echo $_smarty_tpl->tpl_vars['unloadType']->value;?>
&redirect=unload&transitType=<?php echo $_smarty_tpl->tpl_vars['transittype']->value;?>
" onclick="<?php if ($_smarty_tpl->tpl_vars['isEmptyLoad']->value) {?>acceptEmptyUnload('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->toOrganization->code;?>
');<?php } else { ?>acceptUnloading();<?php }?>" title="Unload Transit" target="_blank">Unload</a></li>
                                <?php }?>        
                            <?php }?>
                                                <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->transitOdometerModelCode == "RTEBSD") {?>                             
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->transitOdometerModelCode == "NA") {?>                             
                        <?php }?>
                    <?php } else { ?>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->transitCargoDetails[0]->fromOrganization->code !== $_smarty_tpl->tpl_vars['login_branch']->value) {?>
                            <li class=""><a class="btn btn-info view-chart-btn"  href="#cargo/ogpl-unload-lr?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
&vehicleCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
&unloadType=<?php echo $_smarty_tpl->tpl_vars['unloadType']->value;?>
&redirect=unload" onclick="<?php if ($_smarty_tpl->tpl_vars['isEmptyLoad']->value) {?>acceptEmptyUnload('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->toOrganization->code;?>
')<?php } else { ?>acceptUnloading();<?php }?>" title="Unload Transit" target="_blank">Unload</a></li>
                        <?php }?>
                    <?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['outForDelivery']->value) {?>
                        <li class=""><a class="btn btn-success view-chart-btn " href="#cargo/out-for-delivery-unload-lr?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
&vehicleCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
&transitType=<?php echo $_smarty_tpl->tpl_vars['transittypeout']->value;?>
" title="Unload" target="_blank">Deliver</a></li>
                    <?php }?>
                <?php } elseif ($_smarty_tpl->tpl_vars['tab']->value == 'DEPARTURE') {?>
                    <li class="transit-tab b_l"><a class="tab-link" href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
" title="View Chart" target="_blank">View Chart <i class="fa fa-arrow-right"></i></a></li>
                    <li class=""><a class="btn btn-info view-chart-btn" href="#cargo/add-ogpl?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
&back=ogpl" <?php if ($_smarty_tpl->tpl_vars['isEmptyLoad']->value) {?>onclick="alertEmptyLoad()"<?php }?> title="Load Transit" target="_blank">Load</a></li>
                    <?php if ($_smarty_tpl->tpl_vars['outForDelivery']->value) {?>
                        <li class="mr_l_1_em"><a class="btn btn-success view-chart-btn " href="#cargo/out-for-delivery-unload-lr?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
&vehicleCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->busVehicle->code;?>
&transitType=<?php echo $_smarty_tpl->tpl_vars['transittypeout']->value;?>
" title="Delivery" target="_blank">Deliver</a></li>
                    <?php }?>
                <?php } else { ?>
                    <?php if (!$_smarty_tpl->tpl_vars['isEmptyLoad']->value) {?>
                        <li class=""><a class="btn btn-primary view-chart-btn" href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->tripDate;?>
" title="View Chart" target="_blank">View Chart</a></li>
                    <?php }?>
                <?php }?>
            </ul>
        </div>
    <?php
}
} else {
?>
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="well well-large m-0"> Sorry! No trips were found</div>
            </div>
        </div>
    <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
}}
/*/ smarty_template_function_ogplList_912580324667d52e2f0c406_66681729 */
}
