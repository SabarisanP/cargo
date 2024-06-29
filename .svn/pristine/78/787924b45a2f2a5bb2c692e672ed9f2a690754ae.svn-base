<div id="ogpl-trip-list">
    {if $result|count == 0}
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="well well-large m-0"> Sorry! No trips were found on the requested date.</div>
            </div>
        </div>
    {else}
        {foreach from=$result item=row}
            {if $row->cargoActivityType->code == 'OTFD'}
                
            {assign var="loaded_count" value=0}
            {assign var="unloaded_count" value=0}
            {assign var="total_count" value=0}
            {assign var="prebook_count" value=0}
            {foreach item=list from=$row->transitCargoDetails}
                {assign var="loaded_count" value=$loaded_count + $list->loadedCount}
                {assign var="unloaded_count" value=$unloaded_count + $list->unLoadedCount}
                {if $list->transitDetailsType->code == 'DRCLC'}
                    {assign var="prebook_count" value=$prebook_count + $list->loadedCount + $list->unLoadedCount}
                {/if}
            {/foreach}
            {assign var="total_count" value=$loaded_count + $unloaded_count}
            {assign var="isEmptyLoad" value=in_array('EMP-LOAD', $row->activity)}

            <div class="panel panel-default transit-row p-0" id="transit-{$row->code}" data-transitcode="{$row->code}" data-vehiclecode="{$row->busVehicle->code}">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-3 b_r">
                            <div>
                                <span class="mnu_border btn-xs">{$row->tripDate|date_format:$ns_date_format}</span>&emsp;
                                {if $row->departureMinutes}
                                    <span class="text-muted small">
                                        <span title="Departure Time">{min_to_time($row->departureMinutes * 60)}</span> to
                                        <span title="Arrival Time">
                                            {if $row->arrivalMinutes > 2880}
                                                {min_to_time(($row->arrivalMinutes - 2880) * 60)} Third Day
                                            {elseif $row->arrivalMinutes > 1440}
                                                {min_to_time(($row->arrivalMinutes - 1440) * 60)} Next Day
                                            {elseif $row->arrivalMinutes}
                                                {min_to_time($row->arrivalMinutes * 60)}
                                            {/if}
                                        </span>
                                    </span>
                                {/if}
                            </div>
                            <h4>{$row->fromOrganization->name|default:$row->fromStation->name} - {$row->toOrganization->name|default:$row->toStation->name}</h4>
                            <b class="h3 bold">{$row->aliasCode}</b>
                            {if $row->viaStations|count > 0}
                                &nbsp;<a href="javascript:;" class="ogpl-via" title="via routes" data-toggle="popover" data-trigger="hover" data-html="true" data-content="
                                {foreach from=$row->viaStations item=via key=i name=v}
                                    {$via->name}<br/>
                                {/foreach}
                                "><i class="fa fa-location-arrow"></i> Via</a>
                            {/if}

                            &nbsp;<a href="javascript:;" title="Click to get Transit History" onclick="getTransitHistory('{$row->code}', '{$row->aliasCode}')"><i class="fa fa-history" aria-hidden="true"></i></a>
                        </div>
                        <div class="col-md-2 text-center b_r">
                            <h4>{$row->busVehicle->registationNumber}</h4>
                            {if isNotNull($row->vehicleDriver->name)}
                                <p class="text-muted">{$row->vehicleDriver->name}, {$row->vehicleDriver->mobileNumber}</p>
                            {/if}
                            {if isNotNull($row->secondaryDriver->name)}
                                <p class="text-muted">{$row->secondaryDriver->name}, {$row->secondaryDriver->mobileNumber}</p>
                            {/if}
                            {if count($row->transitReference)}
                                {foreach from=$row->transitReference item=transit}
                                    {if $transit->cargoActivityType->code == 'TRNT'}
                                        <a href="#cargo/ogpl-chart-details?transitCode={$transit->code}" title="Related OGPL" target="_blank">{$transit->name} ({$transit->aliasCode})</a><br>
                                    {elseif $transit->cargoActivityType->code == 'INTRNT'}
                                        <a href="#cargo/local-transit-chart-details?transitCode={$transit->code}" title="Related Local Transit" target="_blank">{$transit->name} ({$transit->aliasCode})</a><br>
                                    {elseif $transit->cargoActivityType->code == 'OTFD'}
                                        <a href="#cargo/out-for-delivery-chart-details?transitCode={$transit->code}" title="Related Door Pickup and Delivery" target="_blank">{$transit->name} ({$transit->aliasCode})</a><br>
                                    {/if}
                                {/foreach}
                            {/if}
                        </div>
                        <div class="col-md-5">
                            <table class="table" style="table-layout: fixed;">
                                <tr class="row-noborder">
                                    <td><b>Loaded</b></td>
                                    <td>: 
                                        {if $row->additionalAttribute->CARGO_HUB_LOAD_COUNT > 0}
                                            <span class="badge badge-default" title="Hub Loaded">{$row->additionalAttribute->CARGO_HUB_LOAD_COUNT}</span>
                                        {/if}
                                        {$loaded_count|max:0}
                                    </td>
                                    <td><b>Actual Weight</b></td>
                                    <td>: {$row->totalActualWeight}</td>
                                    <td><b>Total Freight</b></td>
                                    <td>: {$row->totalBookedAmount|inr_format}</td>
                                </tr>
                                <tr class="row-noborder">
                                    <td><b>Unloaded</b></td>
                                    <td>: 
                                        {if $row->additionalAttribute->CARGO_HUB_UNLOAD_COUNT > 0}
                                            <span class="badge badge-default" title="Hub Unloaded">{$row->additionalAttribute->CARGO_HUB_UNLOAD_COUNT}</span>
                                        {/if}
                                        {$unloaded_count|max:0}
                                    </td>
                                    <td><b>Billing Weight</b></td>
                                    <td>: {$row->totalWeight}</td>
                                    <td><b>Total Charges</b></td>
                                    <td>: 
                                        {$row->totalCargoCharge|inr_format}

                                        {if $row->totalCargoCharge != 0}
                                            <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                                <table>
                                                    {foreach key=ck item=cv from=$row->cargoCharges}
                                                        {if $cv == 0}
                                                            {continue}
                                                        {/if}
                                                        <tr>
                                                            <td><b>{$ck|_camelcase_to_titlecase}</b></td>
                                                            <td>&ensp;:&ensp;</td>
                                                            <td align="right">{$cv|inr_format}</td>
                                                        </tr>
                                                    {/foreach}
                                                </table>
                                            '></i>
                                        {else}
                                            <i class="fa fa-info-circle fa-inverse"></i>
                                        {/if}
                                    </td>
                                </tr>
                                {if isNotNull($row->remarks)}
                                    <tr class="row-noborder">
                                        <td colspan="6"><b>Remarks :</b> {$row->remarks}</td>
                                    </tr>
                                {/if}
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
                                    {foreach from=$row->transitRoutes item=route}  
                                        <tr>
                                            <td>{$route->organization->name}</td>
                                            <td align='right'>{$route->loadedCount}</td>
                                            <td align='right'>{$route->unloadedCount}</td>
                                            <td align='right'>{$route->pendingUnloadCount}</td>
                                        </tr>                      
                                    {/foreach}
                                </table>
                            ">
                                Total LR
                                <h4 class="text-right bold">{if $prebook_count > 0}<small class="badge badge-primary" data-toggle="tooltip" title="Total Prebook">{$prebook_count|max:0}</small>{/if} {$total_count|max:0}</h4>
                            </div>
                        </div>
                        <div class="col-md-1 text-right">
                            {if !in_array($row->transitStatus->code, ["CMPLT", "TRNSFR ", "EMPLD"])}
                                <a class="btn btn-default btn-xs" href="#cargo/add-out-for-delivery?transitCode={$row->code}&date={$row->tripDate}" {if $isEmptyLoad}onclick="alertEmptyLoad()"{/if}> <i class="fa fa-pencil"></i> Edit</a>&emsp;
                            {/if}
                            <a href="javascript:;" data-toggle="tooltip" title="{$row->audit->user->name} <br/> {$row->audit->updatedAt|date_format:$ns_datetime_format} "><i class="fa fa-info-circle"></i></a>
                            <br><br>

                            {if $row->transitStatus->code == 'EMPLD' || $isEmptyLoad}
                                <span class="label label-danger">! Empty Load</span>
                            {elseif $row->transitStatus->code == 'NEW'}
                                <span class="label label-success">New</span>
                            {elseif $row->transitStatus->code == 'INTRN'}
                                <span class="label label-warning">In-Transit</span>
                            {elseif $row->transitStatus->code == 'CMPLT'}
                                <span class="label label-danger">Completed</span>
                            {elseif $row->transitStatus->code == 'TRNSFR'}
                                <span class="label label-danger">Transferred</span>
                            {/if}
                            <br><br>
                            {if $loaded_count > 0}
                                <a class="btn btn-success btn-xs view-chart-btn pull-right" href="#cargo/out-for-delivery-unload-lr?transitCode={$row->code}&date={$row->tripDate}&vehicleCode={$row->busVehicle->code}" title="Unload" target="_blank">Deliver</a>
                            {/if}
                        </div>
                    </div>
                </div>
                <ul class="transit-tabs">
                    <li class="transit-tab b_r"><span class="point_cur" data-toggle="tab" href="#history_tab" data-tab="HISTORY">History</span></li>
                    <li class="transit-tab b_r"><span class="point_cur" data-toggle="tab" href="#route_tab" data-tab="ROUTE">Route</span></li>
                    {* {if $loaded_count > 0}
                        <li class="transit-tab b_r"><span class="point_cur" data-toggle="tab" href="#transfer_tab" data-tab="TRANSFER">Transfer</span></li>
                    {/if}                     *}
                    {if $action_rights['EBL-EWAY-BILL'] > 0 && ($row->additionalAttribute->EWAY_BILL_ADDED_COUNT - $row->additionalAttribute->EWAY_BILL_VEHICLE_UPDATED_COUNT)}
                        <li class="transit-tab b_r"><span class="point_cur" data-toggle="tab" href="#ewaybill_tab" data-tab="EWAYBILL">EWayBill Part-B</span></li>
                    {/if}
                    <li class="transit-tab b_r"><span class="point_cur" data-toggle="tab" href="#fuel_tab" data-tab="FUEL">Fuel Expense</span></li>
                    <li class="transit-tab"><span class="point_cur" data-toggle="tab" href="#payments_tab" data-tab="PAYMENTS">Payments</span></li>
                    <li class=""><a class="btn btn-primary view-chart-btn" href="#cargo/out-for-delivery-chart-details?transitCode={$row->code}&date={$row->tripDate}" title="View Chart" target="_blank">View Chart</a></li>
                </ul>
            </div>
        {/if}
        {/foreach}
    {/if}
</div>

<script id="transit-tabscontent-tpl" type="text/template">
    <div id="transit-tabscontent" class="tab-content border_top">
        <div id="history_tab" class="tab-pane fade"></div>
        {* <div id="transfer_tab" class="tab-pane fade"></div>
        <div id="ewaybill_tab" class="tab-pane fade"></div> *}
        <div id="fuel_tab" class="tab-pane fade"></div>
        <div id="payments_tab" class="tab-pane fade"></div>
        <div id="route_tab" class="tab-pane fade"></div>
    </div>
</script>

<input type="hidden" id="active-transit-code">

<script>
    var transitListData = {$result|json_encode};
    var loading_spinner = "<div class='text-center'><img src='{$base_url}/assets/img/loaders/20.gif' /></div>"

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
</script>
