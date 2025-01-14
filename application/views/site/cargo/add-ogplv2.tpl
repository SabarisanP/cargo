<div class="brand_top">
    <h3>
        {if $smarty.request.transitCode == ''}Add Transit{else}Edit Transit{/if}
    </h3>
    <span class="align-right">
        {if $smarty.request.transitCode == ''}
            <a href="#cargo/{$smarty.request.back|default:'ogpl'}" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>
        {else}
            <a href="#cargo/{$smarty.request.back|default:'ogpl'}?fill=1" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>
        {/if}
    </span>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row" id="ogpl-form-div">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default" id="ogpl-search-container">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-2 {if $smarty.request.transitCode}hide{/if}">
                                            <div class="h5 bold">Select Mode of transit ?</div>
                                            <div class="pb10">
                                                <div class="btn-group btn-group-days" id="transit-type" data-toggle="buttons">
                                                    <label class="btn btn-success chk-btn active" title="OutStation">
                                                        <input type="radio" name="transit-type" value="TRNT" checked>OutStation
                                                    </label>
                                                    <label class="btn btn-success chk-btn" title="Local">
                                                        <input type="radio" name="transit-type" value="INTRNT">Local
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="pull-left m-t-5" for="ogpl-search-vehicle">Vehicle</label>
                                            <div class="pull-right pb10 {if $smarty.request.transitCode || count($ownershipTypes) <= 1}hide{/if}" id="ogpl-search-owner">
                                                <div class="btn-group btn-group-days" data-toggle="buttons">
                                                    <label class="btn btn-success btn-xs chk-btn active" title="All Types">
                                                        <input type="radio" name="ogpl-search-owner" value="NA" checked>All
                                                    </label>
                                                    {foreach key=code item=name from=$ownershipTypes}
                                                        <label class="btn btn-success btn-xs chk-btn" title="{$name}">
                                                            <input type="radio" name="ogpl-search-owner" value="{$code}">{$name}
                                                        </label>
                                                    {/foreach}
                                                </div>
                                            </div>
                                            <div class="input-group col-md-12">
                                                <input type="text" class="form-control" id="ogpl-search-vehicle">
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-7">
                                                    <div class="text-muted m-t-5 hide" id="vehicle-location-info"><b>Available At : </b><span id="vehicle-location"></span></div>
                                                </div>
                                                <div class="col-sm-5">
                                                {if $action_rights['ADD-NEW-VEHICLE']}
                                                    <a href="javascript:;" class="m-t-5 bold pull-right" onclick="quickAddNewVehicle()">Add New Vehicle</a>
                                                {/if}
                                                </div>
                                            </div>
                                        </div>

                                        {* <div class="form-group col-md-2">
                                            <label for="ogpl-search-date">Date</label>
                                            <div class="input-group">
                                                <input type="text" name="toDate" class="form-control sdate" id="ogpl-search-date" readonly placeholder="Date">
                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div> *}

                                        <div class="form-group col-md-2 {if !$smarty.request.transitCode || count($ownershipTypes) > 1}p_t_30{/if}">
                                            {if $smarty.request.transitCode || count($ownershipTypes) < 1}
                                                <label for="">&nbsp;</label>
                                            {/if}
                                            <div class="input-group">
                                                {if $cargo_setting->ogplModelCode == 'VER2'}
                                                    <button class="btn btn-success {if $smarty.request.transitCode || count($ownershipTypes) < 1} m-t-5{/if}" type="button" onclick="getOgplList();">Get {lang('ogpl')}</button>&nbsp;
                                                {/if}
                                            </div>
                                        </div>
                                        
                                        <div id="vehicle-details" class="hide">
                                            <div class="col-md-4 p_l_n p_r_n"><br>
                                                <div class="col-md-6">
                                                    <b>Transporter</b> - <span id="v-transporter"></span><br>
                                                    <b>Fuel Capacity</b> - <span id="v-fuel"></span>
                                                </div>
                                                <div class="col-md-6">
                                                    <b>Dimension</b> - <span id="v-dimension"></span><br>
                                                    <b>Capacity</b> - <span id="v-capacity"></span>
                                                </div>
                                                <div class="col-md-12" id="v-tags">
                                                    <b>Tags : </b><span class="values"></span>
                                                </div>
                                            </div>
                                        </div>
                                                    
                                        <div class="col-md-12">
                                            <div class="align-center alert alert-danger pull-left" style="display:none;" id="ogpl_search_action_state"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix"></div><br>
                            <div id="ogpl-search-list-container" style="display: none;">
                                <div>
                                    <div id="ogpl-search-list"></div>                                    
                                </div>
                            </div>

                            <div id="add-ogpl-container" {if $cargo_setting->ogplModelCode == 'VER2'}style="display: none;"{/if}>
                                <br>
                                <div class="row">
                                    <div class="col-md-9">
                                        <div class="panel panel-default">
                                            <div class="heading_b">
                                                Transit Details
                                                {if $cargo_setting->userAccountModel->code == 'DINV'}
                                                <label class="pull-right">
                                                    <span id="next-ogpl-sequence">&nbsp;-</span>
                                                </label>
                                                {/if}
                                            </div>
                                            <div class="panel-body">
                                                <form id="add-ogpl-form" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-3">
                                                            <label for="ogpl-date">Transit Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="ogpl-date" readonly {if $action_rights['OGPL-PREV-DATE'] != 1}disabled{/if} value="{$smarty.now|date_format:'d-m-Y'}" placeholder="Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4"></div>
                                                        <div class="col-md-5" data-transit-field="TRNT">
                                                            <label for="ogpl-tpl">{lang('ogpl')} Routes
                                                                <a href="javascript:;" class="pull-right" onclick="toggleRoutes()">All Routes</a>
                                                            </label>
                                                            <div class="form-group">
                                                                <select id="ogpl-tpl" class="form-control" onchange="setOGPLTemplate(this.value)">
                                                                    <option value="" selected="">Select Routes</option>
                                                                    {foreach item=tpl from=$ogpltpl}
                                                                        {if $tpl->fromStation->code==$login_station}
                                                                        <option value="{$tpl->code}">{$tpl->name}</option>
                                                                        {/if}
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6">
        
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="form-group">
                                                                        <label class="pull-right hide" data-transit-field="TRNT"><input type="checkbox" id="save-as-tpl"> Save as Template</label>
                                                                        <label for="ogpl-name" class="req">Name</label>
                                                                        <input type="text" class="form-control" id="ogpl-name" placeholder="{lang('ogpl')} Name" maxlength="40">
                                                                    </div>
                                                                    <input type="hidden" id="ogpl-date" />
                                                                </div>

                                                                <div class="col-md-6" data-transit-field="TRNT">
                                                                    <div class="form-group">
                                                                        <label for="ogpl-from" class="req">From Station</label>
                                                                        <div class="input-group col-md-12">
                                                                            <select id="ogpl-from" class="form-control" onchange="getNextOGPLSequence()">
                                                                                <option value="" selected="">Select From</option>
                                                                                {foreach item=station from=$stations}
                                                                                    <option value="{$station.code}">{$station.name}</option>
                                                                                {/foreach}
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 hide" data-transit-field="INTRNT">
                                                                    <div class="form-group">
                                                                        <label for="ogpl-from-branch" class="req">From Branch</label>
                                                                        <div class="input-group col-md-12">
                                                                            <select id="ogpl-from-branch" class="form-control" disabled onchange="getNextOGPLSequence()">
                                                                                {if $smarty.request.transitCode}
                                                                                    <option value="" selected="">Select From</option>
                                                                                    {foreach item=row from=$branches}
                                                                                        {if $row->station->code == $login_station}
                                                                                            <option value="{$row->code}" data-stationcode="{$row->station->code}">{$row->name}</option>
                                                                                        {/if}
                                                                                    {/foreach}
                                                                                {else}
                                                                                    {foreach item=row from=$branches}
                                                                                        {if $row->code == $login_branch}
                                                                                            <option value="{$row->code}" data-stationcode="{$row->station->code}" selected="selected">{$row->name}</option>
                                                                                        {/if}
                                                                                    {/foreach}
                                                                                {/if}
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="ogpl-departuretime">Departure Time</label>
                                                                        <select id="ogpl-departuretime" class="form-control">
                                                                            <option value="" selected="">Select Time</option>
                                                                            {assign var="timerange" value=hours_range(0, 86400 -1, 60 * 15)}
                                                    
                                                                            {foreach item=time key=seconds from=$timerange}
                                                                                <option value="{$seconds / 60}">{$time}</option>
                                                                            {/foreach}
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6" data-transit-field="TRNT">
                                                                    <div class="form-group">
                                                                        <label for="ogpl-to" class="req">To Station</label>
                                                                        <div class="input-group col-md-12">
                                                                            <select id="ogpl-to" class="form-control" onchange="getNextOGPLSequence()">
                                                                                <option value="" selected="">Select To</option>
                                                                                {foreach item=station from=$stations}
                                                                                    <option value="{$station.code}">{$station.name}</option>
                                                                                {/foreach}
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6 hide" data-transit-field="INTRNT">
                                                                    <div class="form-group">
                                                                        <label for="ogpl-to-branch" class="req">To Branch</label>
                                                                        <div class="input-group col-md-12">
                                                                            <select id="ogpl-to-branch" class="form-control" onchange="getNextOGPLSequence()">
                                                                                {if $smarty.request.transitCode}
                                                                                    <option value="" selected="">Select To</option>
                                                                                    {foreach item=row from=$branches}
                                                                                        {if $row->station->code == $login_station}
                                                                                            <option value="{$row->code}" data-stationcode="{$row->station->code}">{$row->name}</option>
                                                                                        {/if}
                                                                                    {/foreach}
                                                                                {else}
                                                                                    <option value="" selected="">Select To</option>
                                                                                    {foreach item=row from=$branches}
                                                                                        {if $row->station->code == $login_station && $row->code != $login_branch && $row->hubFlag}
                                                                                            <option value="{$row->code}" data-stationcode="{$row->station->code}">{$row->name}</option>
                                                                                        {/if}
                                                                                    {/foreach}
                                                                                {/if}
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="ogpl-arrivaltime">Arrival Time</label>
                                                                        <div class="input-group" style="display: flex;">
                                                                            <select id="ogpl-arrivaltime" class="form-control">
                                                                                <option value="" selected="">Select Time</option>
                                                                                {foreach item=time key=seconds from=$timerange}
                                                                                    <option value="{$seconds / 60}">{$time}</option>
                                                                                {/foreach}
                                                                            </select>
                                                                            <select id="ogpl-arrivalday" class="form-control" style="width: 175px;">
                                                                                <option value="0" selected="">Same Day</option>
                                                                                <option value="1440">Next Day</option>
                                                                                <option value="2880">Third Day</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
        
                                                            <div class="row">
                                                                <div class="col-md-3 hide">
                                                                    <div class="form-group">
                                                                        <label for="ogpl-odometer">Start Odometer</label>
                                                                        <input type="number" name="ogpl-odometer" value="" class="form-control no-spin" id="ogpl-odometer" placeholder="Odometer">
                                                                    </div>
                                                                </div>
                                                            </div>
        
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group" data-transit-field="TRNT">
                                                                <label for="ogpl-via" class="req">Via Stations</label>
                                                                <div class="input-group col-md-12 ogpl-via-stations">
                                                                    <select id="ogpl-via" class="form-control" multiple="multiple">
                                                                        {foreach item=station from=$stations}
                                                                            <option value="{$station.code}">{$station.name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="form-group hide" data-transit-field="INTRNT">
                                                                <label for="ogpl-via-branches">Via Branches</label>
                                                                <div class="input-group col-md-12 ogpl-via-branches">
                                                                    <select id="ogpl-via-branches" class="form-control" multiple="multiple">
                                                                        {if $smarty.request.transitCode}
                                                                            {foreach item=row from=$branches}
                                                                                {if $row->station->code == $login_station}
                                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                                {/if}
                                                                            {/foreach}
                                                                        {else}
                                                                            {foreach item=row from=$branches}
                                                                                {if $row->station->code == $login_station && $row->code != $login_branch && $row->hubFlag}
                                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                                {/if}
                                                                            {/foreach}
                                                                        {/if}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="ogpl-remarks">Remarks</label>
                                                                <textarea class="form-control" placeholder="Remarks (optional)" id="ogpl-remarks" rows="3"></textarea>
                                                            </div>
                                                        </div>

                                                        <div class="clearfix"></div>
                                                        <div class="col-md-6 hide" id="link-local-transit-div">
                                                            <input type="checkbox" id="link-local-transit">
                                                            <label for="link-local-transit" class="d-inline"></label>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 p_l_n">
                                        <div class="panel panel-default">
                                            <div class="heading_b">Driver Allocation</div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label for="ogpl-driver-name" class="req">Primary Driver Name</label>
                                                            <input type="text" name="ogpl-driver-name" value="" class="form-control capitalize" id="ogpl-driver-name" placeholder="Driver Name">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label for="ogpl-driver-name">Primary Driver Mobile</label>
                                                            <input type="text" name="ogpl-driver-mobile" value="" class="form-control capitalize" id="ogpl-driver-mobile" placeholder="Driver Mobile" maxlength="10">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label for="ogpl-driver2-name">Secondary Driver Name</label>
                                                            <input type="text" name="ogpl-driver2-name" value="" class="form-control capitalize" id="ogpl-driver2-name" placeholder="Driver Name">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label for="ogpl-driver2-name">Secondary Driver Mobile</label>
                                                            <input type="text" name="ogpl-driver2-mobile" value="" class="form-control capitalize" id="ogpl-driver2-mobile" placeholder="Driver Mobile" maxlength="10">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <br>
                                        <div class="panel panel-default">
                                            <div class="row">
                                                <div class="col-md-9">
                                                    <div class="alert" id="ogpl-action-state" style="display: none"></div>
                                                </div>
                                                <div class="col-md-3 text-right">
                                                    <input type="hidden" id="hid-ogpl-code" />
                                                    <input type="hidden" id="hid-driver-code" />
                                                    <input type="hidden" id="hid-driver2-code" />
                                                    {if $cargo_setting->ogplModelCode == 'VER2'}
                                                        <button class="btn btn-primary" id="empty-transit-btn" type="button" onclick="proceedOGPL('EMPTY_LOAD')">Empty Load</button>
                                                        <button class="btn btn-primary" id="empty-transit-btn" type="button" onclick="proceedOGPL('TRANSFER_LOAD')">Transfer Load</button>
                                                        <button class="btn btn-warning hide" id="start-transit-btn" type="button">Start Trip</button>
                                                    {/if}
                                                    <button class="btn btn-success" type="button" id="proceed-transit-btn" onclick="{if $action_rights['OGPL-IS-FLEET-FREE']==1} validateOGPL(); {else} proceedOGPL(); {/if}">Next</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--panel Body end-->
                        </div>
                        <!--panel end-->
                    </div>

                    <div class="row" id="edit-ogpl-list-container" style="display: none;">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="edit-ogpl-list">
                                        <div class="row">
                                            <div class="col-md-2"><b>Name :</b> <span id="edit-ogpl-name"></span></div>
                                            <div class="col-md-2"><b>Date :</b> <span id="edit-ogpl-date"></span></div>
                                            <div class="col-md-2"><b>From :</b> <span id="edit-ogpl-from"></span></div>
                                            <div class="col-md-2"><b>Departure :</b> <span id="edit-ogpl-departure"></span></div>
                                            <div class="col-md-2"><b>To :</b> <span id="edit-ogpl-to"></span></div>
                                            <div class="col-md-2"><b>Arrival :</b> <span id="edit-ogpl-arrival"></span></div>
                                            <div class="col-md-2"><b>Vehicle :</b> <span id="edit-ogpl-vehicle"></span></div>
                                            <div class="col-md-2"><b>Driver :</b> <span id="edit-ogpl-driver"></span></div>
                                            <div class="col-md-2"><b>Driver 2 :</b> <span id="edit-ogpl-driver2"></span></div>
                                            <div class="col-md-2 hide"><b>Start Odometer :</b> <span id="edit-ogpl-odometer"></span></div>
                                            <div class="col-md-6"><b>Via :</b> <span id="edit-ogpl-via"></span></div>
                                            <div class="col-md-12">
                                                <span class="badge m-t-5 hide" id="loading-until-badge"></span>&emsp;
                                                <a href="javascript:;" class="btn pull-right bold" onclick="editOGPL();"><i class="fa fa-pencil"></i> Edit</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="add-ogpl-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="add-ogpl-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--row end-->
            </div>
            <!--content end-->
        </div>
    </div>
</div>

<script id="vehicle-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-7">
            <b class="vehicle-name"></b><br>
            <span class="vehicle-ownership small" title="Ownership Type"></span>
            <span class="text-muted small" title="Vehicle Type">(<span class="vehicle-type"></span>)</span>
        </div>
        <div class="col-xs-5 text-right nowrap">
            <span class="vehicle-transit-status" title="Vehicle Transit Status"></span><br>
            <span class="vehicle-location small" title="Vehicle Available At"></span>
        </div>
    </div>
</script>

<style>
    .ogpl-via-stations .select2-choices {
        height: 68px!important;
    }
    .ogpl-via-branches .select2-choices {
        height: 68px!important;
    }
    .select2-chosen .vehicle-transit-status {
        visibility: hidden;
    }
</style>

<script>
    var OGPLEdit = {$ogpl|json_encode};
    var ogplDetailsData = {$ogpl|json_encode};
    var OGPLFormData = {};
    var OGPLTemplates = {$ogpltpl|json_encode};
    var OGPLVehicles = {$vehicles|json_encode};
    var driversData = {$drivers|json_encode};
    var drivers = {$drivers|json_encode};
    var OGPLtpl = {$ogpltpl|json_encode};
    var user_login_station = {$login_station|json_encode};
    var user_login_branch = {$login_branch|json_encode};
    var linkVehicleCode = {$linkVehicleCode|json_encode};
    var odoDetails = {$odoDetails|json_encode};
    var cargoSetting = {$cargo_setting|json_encode};
    var namespaceCode = {$namespaceCode|json_encode};
    
    {literal}
        var driverItem = function(ul, item) {
            return $('<li class="ui-menu-item">')
                .append('<a><b>' + item.name + ' ' + (item.lastName || '') + '</b><br/><span class="text-muted"><small>' + (item.mobileNumber || '') + '</small><small class="pull-right">' + (item.ownershipType.name || '') + '</small></span></a>')
                .appendTo(ul);
        }

        var filterDriverSource = function (request, response) {
            var query = request.term.toLowerCase();

            var vehicleCode = $('#ogpl-search-vehicle').val()
            var vehicle = _.find(OGPLVehicles, o => o.code == vehicleCode);
            var ownershipTypeCode = vehicle ? vehicle.ownershipType.code : '';

            var driverSource = [];
            $.each(drivers || [], function (i, driver) {
                var term = [driver.name + ' ' + driver.lastName, driver.mobileNumber].join(' ').toLowerCase();
                if (driver.ownershipType.code == ownershipTypeCode && term.search(query) >= 0) {
                    driverSource.push(driver)
                }
            });

            response(driverSource);
        }

        $('#ogpl-driver-name, #ogpl-driver-mobile').autocomplete({
            minLength: 0,
            source: filterDriverSource,
            select: function (event, ui) {
                $('#ogpl-driver-mobile').val(ui.item.mobileNumber);
                $('#ogpl-driver-name').val(ui.item.name);
                $('#hid-driver-code').val(ui.item.code);

                return false;
            }
        }).on('change', function () {
            $('#hid-driver-code').val('');
        });

        $('#ogpl-driver2-name, #ogpl-driver2-mobile').autocomplete({
            minLength: 0,
            source: filterDriverSource,
            select: function (event, ui) {
                $('#ogpl-driver2-mobile').val(ui.item.mobileNumber);
                $('#ogpl-driver2-name').val(ui.item.name);
                $('#hid-driver2-code').val(ui.item.code);

                return false; 
            }
        }).on('change', function () {
            $('#hid-driver2-code').val('');
        });

        $('#ogpl-driver-name, #ogpl-driver-mobile, #ogpl-driver2-name, #ogpl-driver2-mobile').each(function () {
            $(this).data('uiAutocomplete')._renderItem = driverItem
        }).on('focus', function () {
            $(this).autocomplete('search', this.value || '');
        });

        var OGPLVehicleSource = [];
        $.each(OGPLVehicles || [], function(i, row) {
            if (row.activeFlag == 1) {
                OGPLVehicleSource.push({
                    label: row.registationNumber + ' - ' + row.vehicleType.name,
                    value: row.registationNumber,
                    code: row.code
                });
            }
        });

        function fillOgplEdit(OGPLEdit) {
            $('#hid-ogpl-code').val(OGPLEdit.code);
            $('#ogpl-name').val(OGPLEdit.name);
            $('#ogpl-date').val(moment(OGPLEdit.tripDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('#ogpl-odometer').val(OGPLEdit.odometer);
            $('#ogpl-remarks').val(OGPLEdit.remarks);

            $('#transit-type [name="transit-type"][value="' + OGPLEdit.cargoActivityType.code + '"]').prop('checked', true).trigger('change');
            $('#ogpl-search-vehicle').val(OGPLEdit.busVehicle.code).trigger('change');

            if (OGPLEdit.cargoActivityType.code == 'TRNT') {
                $('#ogpl-from').val(OGPLEdit.fromStation.code);
                $('#ogpl-to').val(OGPLEdit.toStation.code);
            } else if (OGPLEdit.cargoActivityType.code == 'INTRNT') {
                $('#ogpl-from-branch').val(OGPLEdit.fromOrganization.code);
                $('#ogpl-to-branch').val(OGPLEdit.toOrganization.code);
            }
            $('#ogpl-driver-name').val(OGPLEdit.vehicleDriver.name);
            $('#hid-driver-code').val(OGPLEdit.vehicleDriver.code);
            $('#ogpl-driver-mobile').val(OGPLEdit.vehicleDriver.mobileNumber);
            $('#ogpl-driver2-name').val(OGPLEdit.secondaryDriver.name);
            $('#hid-driver2-code').val(OGPLEdit.secondaryDriver.code);
            $('#ogpl-driver2-mobile').val(OGPLEdit.secondaryDriver.mobileNumber);
            var viaStations = [];
            $.each(OGPLEdit.viaStations, function(i, val) {
                viaStations.push(val.code);
            });
            $('#ogpl-via').select2('val', viaStations);
            var viaOrganizations = [];
            $.each(OGPLEdit.viaOrganizations, function(i, val) {
                viaOrganizations.push(val.code);
            });
            $('#ogpl-via-branches').select2('val', viaOrganizations);
            var option = OGPLEdit;
            var arrivalMinutes, arrivalday;
            if (option.arrivalMinutes > 2880) {
                arrivalMinutes = option.arrivalMinutes - 2880;
                arrivalday = 2880;
            } else if (option.arrivalMinutes > 1440) {
                arrivalMinutes = option.arrivalMinutes - 1440;
                arrivalday = 1440;
            } else {
                arrivalMinutes = option.arrivalMinutes;
                arrivalday = 0;
            }
            $('#ogpl-arrivalday').val(arrivalday);
            $('#ogpl-arrivaltime').val(arrivalMinutes || '');
            $('#ogpl-departuretime').val(option.departureMinutes || '');

            var loadtype;
            if (OGPLEdit.activity.includes('COMPLETE')) {
                loadtype = 'RESTRICT';
                $('#loading-until-badge').html('Loading Closed').addClass('badge-danger').removeClass('hide');
            } else {

                var user_organization_found = false;
                $.each(OGPLEdit.transitRoutes || [], function (i, detail) {
                    if (detail.createdAt && detail.organization && detail.organization.code == user_login_branch) {
                        user_organization_found = true;
                        if (namespaceCode == "citycargo" || namespaceCode == "cityparcel") {
                            var allowedTill = moment(detail.createdAt).add(5, 'hours');
                        } else {
                            var allowedTill = moment(detail.createdAt).add(2, 'hours');
                        }
                        if (moment().isBefore(allowedTill)) {
                            $('#loading-until-badge').html('Loading allowed only for ' + allowedTill.fromNow(true)).addClass('badge-warning').removeClass('hide');
                        } else {
                            loadtype = 'RESTRICT';
                            $('#loading-until-badge').html('Loading Closed').addClass('badge-danger').removeClass('hide');
                        }
                        return false;
                    }
                });

                if (user_organization_found == false) {
                    $.each(OGPLEdit.transitCargoDetails || [], function (i, detail) {
                        if (detail.fromStation && detail.fromStation.code == user_login_station) {
                            var allowedTill = moment(detail.audit.updatedAt).add(5, 'hours');
                            if (moment().isBefore(allowedTill)) {
                                $('#loading-until-badge').html('Loading allowed only for ' + allowedTill.fromNow(true)).addClass('badge-warning').removeClass('hide');
                            } else {
                                loadtype = 'RESTRICT';
                                $('#loading-until-badge').html('Loading Closed').addClass('badge-danger').removeClass('hide');
                            }
                            return false;
                        }
                    });
                }
            }

            proceedOGPL(loadtype);
        }

        $('#ogpl-date').datepicker({
            format: 'dd-mm-yyyy',
            autoclose: true,
            changeMonth: false,
            todayHighlight: true,
            startDate: '-2d',
            endDate: '0'
        }).on('show', function () {
            if (!menu_permission['OGPL-PREV-DATE']) {
                $(this).datepicker('hide');
            }
        });

        $('#ogpl-driver-mobile').on('input', function() {
            this.value = this.value.replace(/\D/g, '');
        });

        $('.bsn_switch').bootstrapSwitch();
        $('#ogpl-tpl').select2();
        $('#ogpl-from').select2();
        $('#ogpl-to').select2();
        // $('#ogpl-driver-name').select2();
        $('#ogpl-via').select2({
            placeholder: 'Select Via Stations',
            closeOnSelect: false
        }).on('change', function (e) {
            $(e.target).select2('search', '');
        });
        $('#ogpl-via .select2-choices').css('max-height', '400px');
        $('#ogpl-via-branches').select2({
            placeholder: 'Select Via Branches',
            closeOnSelect: false
        }).on('change', function (e) {
            $(e.target).select2('search', '');
        });
        $('#ogpl-via-branches .select2-choices').css('max-height', '400px');

        $('#transit-type').on('change', function() {
            var transitType = $(this).find('[name="transit-type"]:checked').val();

            $('[data-transit-field]').addClass('hide');
            $('[data-transit-field="' + transitType +'"]').removeClass('hide');
        });

        $('#ogpl-search-owner').on('change', function() {
            var ownershipType = $(this).find('[name="ogpl-search-owner"]:checked').val();

            var vehiclesData = [];
            $.each(OGPLVehicles || [], function(i, row) {
                if ((isNull(ownershipType) || ownershipType == row.ownershipType.code) && row.activeFlag == 1) {
                    var vehicle = $.extend({}, row)
                    vehicle.id = row.code;
                    vehicle.text = row.registationNumber;
                    vehiclesData.push(vehicle);
                }
            });
            
            var vehicleSelectTpl = $('#vehicle-select-tpl').html();
            var formatResult = function(vehicle) {
                var $tpl = $(vehicleSelectTpl);

                $tpl.find('.vehicle-name').text(vehicle.registationNumber);
                $tpl.find('.vehicle-type').text(vehicle.vehicleType.name);

                if (cargoSetting.transitLocationModelCode == 'STN') {
                    $tpl.find('.vehicle-location').text(vehicle.transitStation.name || '-');
                } else if (cargoSetting.transitLocationModelCode == 'BRCH') {
                    $tpl.find('.vehicle-location').text(vehicle.transitOrganization.name || '-');
                }

                if (vehicle.transitStatusCode == 'CMPLT') {
                    $tpl.find('.vehicle-transit-status').html('<span style="padding: 1px 4px;" class="badge badge-success"><small>Available</small></span>');
                } else if (vehicle.transitStatusCode == 'INTRN') {
                    $tpl.find('.vehicle-transit-status').html('<span style="padding: 1px 4px;" class="badge badge-danger"><small>In Transit</small></span>');
                }
                $tpl.find('.vehicle-ownership').text(vehicle.ownershipType.name);
                return $tpl;
            };

            function matcher(term, text, vehicle) {
                text = [vehicle.registationNumber, vehicle.vehicleType.name, vehicle.transitStation.name, vehicle.transitOrganization.name, vehicle.ownershipType.name].join(' ');
                return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
            };

            $('#ogpl-search-vehicle').select2('destroy');
            $('#ogpl-search-vehicle').select2({
                data: { results: vehiclesData },
                placeholder: 'Select Vehicle',
                formatResult: formatResult,
                formatSelection: formatResult,
                matcher: matcher
            });

            $('#ogpl-search-vehicle').val('').trigger('change');
        }).trigger('change');

        $('#ogpl-search-vehicle').on('change', function () {
            $('#vehicle-location-info, #vehicle-details').addClass('hide');
            $('#ogpl-template-container').hide();
            // $('#ogpl-search-list-container').hide();

            var vehicleCode = this.value;
            if (!vehicleCode) {
                return;
            }

            var vehicle = _.find(OGPLVehicles, o => o.code == vehicleCode);
            if (!vehicle) {
                return;
            }

            if (cargoSetting.ogplModelCode == 'VER2') {
                $('#proceed-transit-btn').toggleClass('hide', vehicle.transitStatusCode == 'INTRN');
            }

            if (cargoSetting.transitLocationModelCode == 'STN' && vehicle.transitStation.code) {
                $('#vehicle-location').html(vehicle.transitStation.name || '');
                $('#vehicle-location-info').removeClass('hide');
            } else if (cargoSetting.transitLocationModelCode == 'BRCH' && vehicle.transitOrganization.code) {
                $('#vehicle-location').html(vehicle.transitOrganization.name || '');
                $('#vehicle-location-info').removeClass('hide');
            }

            $('#vehicle-details').removeClass('hide');
            $('#v-regno').html(vehicle.registationNumber);
            $('#v-owntype').html(vehicle.ownershipType.name);
            $('#v-disname').html([vehicle.makeType, vehicle.modelType, vehicle.fuelType.name, vehicle.vehicleType.name].filter(isNotNull).join(' - '));
            $('#v-transporter').html(vehicle.transporterContact.name);
            $('#v-fuel').html(vehicle.fuelTankCapacity + ' Litres');
            $('#v-dimension').html(vehicle.dimensions);
            $('#v-capacity').html(vehicle.loadCapacity + ' Ton');

            var tags = [];
            $.each(vehicle.tag || [], function (i, tag) {
                tags.push('<span class="label label-default">' + tag.name + '</span>&nbsp;')
            });
            $('#v-tags .values').html(tags);
            $('#v-tags').toggleClass('hide', tags.length == 0)

            drivers = []
            $.each(driversData || [], function (i, driver) {
                if (vehicle.ownershipType.code == driver.ownershipType.code) {
                    drivers.push(driver);
                }
            });
        });

        if (linkVehicleCode) {
            $('#ogpl-search-vehicle').val(linkVehicleCode).trigger('change').prop('disabled', true);
            getOgplList();
        }

        $('#ogpl-search-date').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true,
            todayHighlight: true
        });

        if (!$.isEmptyObject(OGPLEdit)) {
            $('#ogpl-search-container .form-group').hide();
            $('#ogpl-search-container #ogpl-search-vehicle').prop('disabled', true).closest('.form-group').show();
            getOgplList(OGPLEdit.code);
            fillOgplEdit(OGPLEdit);
        }

        function toggleRoutes() {
            var routes = [];
            $.each(OGPLtpl || [], function(k, val) {
                routes.push(new Option(val.name, val.code));
            });

            $('#ogpl-tpl')
                .select2('destroy')
                .html('<option value="">Select a route</option>')
                .append(routes)
                .select2()
                .select2('open');
        }

        function validateOGPL() {
            if (!$.isEmptyObject(OGPLEdit)) {
                proceedOGPL();
                return false;
            }
            var data = {};
            data.activeFlag = 1;
            data.cargoActivityType = {};
            data.cargoActivityType.code = $('#transit-type [name="transit-type"]:checked').val();

            data.code = $('#hid-ogpl-code').val();
            data.name = $('#ogpl-name').val().trim();
            data.tripDate = $('#ogpl-date').val() || moment().format('DD-MM-YYYY');
            data.odometer = $('#ogpl-odometer').val().trim();
            data.remarks = $('#ogpl-remarks').val().trim();
            data.via = $('#ogpl-via').val();

            data.vehicleDriver = {};
            data.vehicleDriver.code = $('#hid-driver-code').val();
            data.vehicleDriver.name = $.trim($('#ogpl-driver-name').val());
            data.vehicleDriver.mobileNumber = $.trim($('#ogpl-driver-mobile').val());

            data.secondaryDriver = {};
            data.secondaryDriver.code = $('#hid-driver2-code').val();
            data.secondaryDriver.name = $.trim($('#ogpl-driver2-name').val());
            data.secondaryDriver.mobileNumber = $.trim($('#ogpl-driver2-mobile').val());

            var busVehicle = $('#ogpl-search-vehicle').select2('data');
            data.busVehicle = {};
            if (busVehicle) {
                data.busVehicle.code = busVehicle.code;
                data.busVehicle.registationNumber = busVehicle.registationNumber;
            }

            data.fromStation = {};
            data.fromStation.code = $('#ogpl-from').val();
            data.fromStation.name = $('#ogpl-from option:selected').text();

            data.toStation = {};
            data.toStation.code = $('#ogpl-to').val();
            data.toStation.name = $('#ogpl-to option:selected').text();

            data.viaStations = $.map($('#ogpl-via option:selected') || [], function(val) {
                return { code: $(val).val(), name: $(val).text() };
            });

            data.fromOrganization = {};
            data.fromOrganization.code = $('#ogpl-from-branch').val();
            data.fromOrganization.name = $('#ogpl-from-branch option:selected').text();

            data.toOrganization = {};
            data.toOrganization.code = $('#ogpl-to-branch').val();
            data.toOrganization.name = $('#ogpl-to-branch option:selected').text();

            data.viaOrganizations = $.map($('#ogpl-via-branches option:selected') || [], function(val) {
                return { code: $(val).val(), name: $(val).text() };
            });

            data.departureMinutes = Number($('#ogpl-departuretime').val());
            data.arrivalMinutes = Number($('#ogpl-arrivalday').val()) + Number($('#ogpl-arrivaltime').val());

            data.saveAsTemplate = Number($('#save-as-tpl').is(':checked'));

            data.transitReference = [];
            if ($('#link-local-transit').is(':checked')) {
                data.transitReference.push({ code: localTransitSearchData.code })
            }

            $('#ogpl-form-div .inp_error').removeClass('inp_error');
            var err = 0;

            if (data.name == '') {
                $('#ogpl-name').addClass('inp_error');
                err++;
            }
            if (data.tripDate == '') {
                $('#ogpl-date').addClass('inp_error');
                err++;
            }
            if (data.cargoActivityType.code == 'TRNT') {
                if (data.fromStation.code == '') {
                    $('#ogpl-from').addClass('inp_error');
                    err++;
                }
                if (data.toStation.code == '') {
                    $('#ogpl-to').addClass('inp_error');
                    err++;
                }
                if (cargoSetting.ogplModelCode != 'VER2' && data.viaStations.length == 0) {
                    $('#ogpl-via').addClass('inp_error');
                    err++;
                }
            } else if (data.cargoActivityType.code == 'INTRNT') {
                if (data.fromOrganization.code == '') {
                    $('#ogpl-from-branch').addClass('inp_error');
                    err++;
                }
                if (data.toOrganization.code == '') {
                    $('#ogpl-to-branch').addClass('inp_error');
                    err++;
                }
            }
            if (!data.busVehicle.code && !data.busVehicle.registationNumber) {
                $('#ogpl-search-vehicle').addClass('inp_error');
                err++;
            }
            if (menu_permission['OGPL-MND-VCH'] && !data.busVehicle.code) {
                $('#ogpl-search-vehicle').addClass('inp_error');
                err++;
            }
            if (data.vehicleDriver.name == '') {
                $('#ogpl-driver-name').addClass('inp_error');
                err++;
            }
            // if (!data.departureMinutes) {
            //     $('#ogpl-departuretime').addClass('inp_error');
            //     err++;
            // }
            // if (!data.arrivalMinutes) {
            //     $('#ogpl-arrivaltime').addClass('inp_error');
            //     err++;
            // }
            if (data.departureMinutes && data.arrivalMinutes && data.arrivalMinutes < data.departureMinutes) {
                $('#ogpl-arrivaltime').addClass('inp_error');
                $('#ogpl-departuretime').addClass('inp_error');
                err++;
            }
            if (data.vehicleDriver.mobileNumber && !isValidPhonenumber(data.vehicleDriver.mobileNumber)) {
                $('#ogpl-driver-mobile').addClass('inp_error');
                err++;
            }
            if (data.secondaryDriver.mobileNumber && !isValidPhonenumber(data.secondaryDriver.mobileNumber)) {
                $('#ogpl-driver2-mobile').addClass('inp_error');
                err++;
            }
            if (data.odometer != '' && isNaN(data.odometer)) {
                $('#ogpl-odometer').addClass('inp_error');
                err++;
            }

            var errmsg = 'Please enter/select the values in the field that are marked in red';
            if (data.cargoActivityType.code == 'TRNT') {
                if (data.fromStation.code == data.toStation.code) {
                    $('#ogpl-to').addClass('inp_error');
                    errmsg = 'Please select different To Station';
                    err++;
                }
                if ($.inArray(data.fromStation.code, $('#ogpl-via').val()) > -1 ||
                    $.inArray(data.toStation.code, $('#ogpl-via').val()) > -1) {
                    $('#ogpl-via').addClass('inp_error');
                    errmsg = 'Please select different Via Station';
                    err++;
                }
            }

            if (err > 0) {
                $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#ogpl-action-state').html(errmsg);
                $('#ogpl-action-state').show();
                return false;
            }
            $('#ogpl-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#ogpl-action-state').html(loading_popup).show();

            data = {};
            data.vehicleCode = $('#ogpl-search-vehicle').val();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/validate-ogpl-vehicle',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        if ((response.data || []).length == 0) {
                            proceedOGPL();
                        } else {
                            $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                            $('#ogpl-action-state').html('Vehicle not free, please unload loaded LR or check duplicate OGPL');
                        }
                    } else {
                        $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                        $('#ogpl-action-state').html(response.errorDesc);
                    }
                }
            });
        }

        function proceedOGPL(loadtype) {
            var data = {};
            data.activeFlag = 1;
            data.cargoActivityType = {};
            data.cargoActivityType.code = $('#transit-type [name="transit-type"]:checked').val();

            data.code = $.trim($('#hid-ogpl-code').val());
            data.name = $('#ogpl-name').val().trim();
            data.tripDate = $('#ogpl-date').val() || moment().format('DD-MM-YYYY');
            data.odometer = $('#ogpl-odometer').val().trim();
            data.remarks = $('#ogpl-remarks').val().trim();
            data.via = $('#ogpl-via').val();

            data.vehicleDriver = {};
            data.vehicleDriver.code = $('#hid-driver-code').val();
            data.vehicleDriver.name = $.trim($('#ogpl-driver-name').val());
            data.vehicleDriver.mobileNumber = $.trim($('#ogpl-driver-mobile').val());

            data.secondaryDriver = {};
            data.secondaryDriver.code = $('#hid-driver2-code').val();
            data.secondaryDriver.name = $.trim($('#ogpl-driver2-name').val());
            data.secondaryDriver.mobileNumber = $.trim($('#ogpl-driver2-mobile').val());

            var busVehicle = $('#ogpl-search-vehicle').select2('data');
            data.busVehicle = {};
            if (busVehicle) {
                data.busVehicle.code = busVehicle.code;
                data.busVehicle.registationNumber = busVehicle.registationNumber;
            }

            data.viaStations = []
            
            $('#ogpl-via option:selected').each(function(i, val) {
                data.viaStations.push({ code: $(val).val(), name: $(val).text() });
            });

            $('#ogpl-search-via option:selected').each(function(i, val) {
                data.viaStations.push({ code: $(val).val(), name: $(val).text() });
            });

            if (data.cargoActivityType.code == 'INTRNT') {
                data.fromStation = {};
                data.fromStation.code = $('#ogpl-from-branch option:selected').data('stationcode');

                data.toStation = {};
                data.toStation.code = $('#ogpl-to-branch option:selected').data('stationcode');

                data.fromOrganization = {};
                data.fromOrganization.code = $('#ogpl-from-branch').val();
                data.fromOrganization.name = $('#ogpl-from-branch option:selected').text();

                data.toOrganization = {};
                data.toOrganization.code = $('#ogpl-to-branch').val();
                data.toOrganization.name = $('#ogpl-to-branch option:selected').text();
            } else {
                data.fromStation = {};
                data.fromStation.code = $('#ogpl-from').val();
                data.fromStation.name = $('#ogpl-from option:selected').text();

                data.toStation = {};
                data.toStation.code = $('#ogpl-to').val();
                data.toStation.name = $('#ogpl-to option:selected').text();
                
                data.fromOrganization = {};
                data.fromOrganization.code = user_login_branch;

                data.toOrganization = {};
                data.toOrganization.code = user_login_branch;
            }
            
            data.viaOrganizations = []
            
            $('#ogpl-via-branches option:selected').each(function(i, val) {
                data.viaOrganizations.push({ code: $(val).val(), name: $(val).text() });
            });

            data.departureMinutes = Number($('#ogpl-departuretime').val());
            data.arrivalMinutes = Number($('#ogpl-arrivalday').val()) + Number($('#ogpl-arrivaltime').val());

            data.saveAsTemplate = Number($('#save-as-tpl').is(':checked'))

            data.transitReference = [];
            if ($('#link-local-transit').is(':checked')) {
                data.transitReference.push({ code: localTransitSearchData.code })
            }

            $('#ogpl-form-div .inp_error').removeClass('inp_error');
            var err = 0;

            if (data.name == '') {
                $('#ogpl-name').addClass('inp_error');
                err++;
            }
            if (data.tripDate == '') {
                $('#ogpl-date').addClass('inp_error');
                err++;
            }
            if (data.cargoActivityType.code == 'TRNT') {
                if (data.fromStation.code == '') {
                    $('#ogpl-from').addClass('inp_error');
                    err++;
                }
                if (data.toStation.code == '') {
                    $('#ogpl-to').addClass('inp_error');
                    err++;
                }
                if (cargoSetting.ogplModelCode != 'VER2' && data.viaStations.length == 0) {
                    $('#ogpl-via').addClass('inp_error');
                    err++;
                }
            } else if (data.cargoActivityType.code == 'INTRNT') {
                if (data.fromOrganization.code == '') {
                    $('#ogpl-from-branch').addClass('inp_error');
                    err++;
                }
                if (data.toOrganization.code == '') {
                    $('#ogpl-to-branch').addClass('inp_error');
                    err++;
                }
            }
            if (!data.busVehicle.code && !data.busVehicle.registationNumber) {
                $('#ogpl-search-vehicle').addClass('inp_error');
                err++;
            }
            if (menu_permission['OGPL-MND-VCH'] && !data.busVehicle.code) {
                $('#ogpl-search-vehicle').addClass('inp_error');
                err++;
            }
            if (data.vehicleDriver.name == '') {
                $('#ogpl-driver-name').addClass('inp_error');
                err++;
            }
            // if (!data.departureMinutes) {
            //     $('#ogpl-departuretime').addClass('inp_error');
            //     err++;
            // }
            // if (!data.arrivalMinutes) {
            //     $('#ogpl-arrivaltime').addClass('inp_error');
            //     err++;
            // }
            if (data.departureMinutes && data.arrivalMinutes && data.arrivalMinutes < data.departureMinutes) {
                $('#ogpl-arrivaltime').addClass('inp_error');
                $('#ogpl-departuretime').addClass('inp_error');
                err++;
            }
            if (data.vehicleDriver.mobileNumber && !isValidPhonenumber(data.vehicleDriver.mobileNumber)) {
                $('#ogpl-driver-mobile').addClass('inp_error');
                err++;
            }
            if (isNotNull(data.secondaryDriver.mobileNumber) && !isValidPhonenumber(data.secondaryDriver.mobileNumber)) {
                $('#ogpl-driver-mobile').addClass('inp_error');
                err++;
            }
            if (data.odometer != '' && isNaN(data.odometer)) {
                $('#ogpl-odometer').addClass('inp_error');
                err++;
            }

            if (!data.code && cargoSetting.ogplModelCode == 'VER2' && data.cargoActivityType.code == 'TRNT' && ((cargoSetting.transitLocationModelCode == 'STN' && busVehicle && busVehicle.transitStation.code && data.fromStation.code != busVehicle.transitStation.code) || (cargoSetting.transitLocationModelCode == 'BRCH' && busVehicle && busVehicle.transitOrganization.station && busVehicle.transitOrganization.station.code && data.fromStation.code != busVehicle.transitOrganization.station.code))) {
                $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#ogpl-action-state').html('Loading Not Allowed. Vehicle Located Station User Can Load');
                $('#ogpl-action-state').show();
                return false;
            }

            if (err > 0) {
                $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#ogpl-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#ogpl-action-state').show();
                return false;
            }
            $('#ogpl-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#ogpl-action-state').hide();

            data.tripDate = moment(data.tripDate, 'DD-MM-YYYY').format('YYYY-MM-DD');
            OGPLFormData = data;

            if (loadtype == 'EMPTY_LOAD' || loadtype == 'TRANSFER_LOAD') {
                data.activityType = loadtype;
                data.additionalAttribute = {};
                if (loadtype == 'TRANSFER_LOAD') {
                    data.additionalAttribute.TRANSFER_LOAD_FLAG = 1;
                }

                var loading_overlay = iosOverlay({
                    text: "Loading...",
                    icon: "fa fa-spinner fa-spin"
                });

                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: base_url + 'cargo/ogplv2-empty-load',
                    data: data,
                    success: function (response) {
                        if (response.status == 1) {
                            loading_overlay.update({
                                icon: "fa fa-check",
                                text: "Load Success"
                            });
                            $('#empty-transit-btn, #proceed-transit-btn').addClass('hide');

                            $('#start-transit-btn').off('click').on('click', function () {
                                var params = {};
                                params.transitCode = response.OGPLCode;
                                params.vehicleCode = data.busVehicle.code;
                                params.fromOrganizationCode = data.fromOrganization.code;
            
                                showStartTransitDialog(params, function (e) {
                                    if ((e && e.data && e.data.success == 1) || confirm('Do you want to close dialog without start Trip?')) {
                                        location.href = '#cargo/ogpl?fill=1';
                                        return;
                                    }

                                    e.preventDefault();
                                    return false;
                                });
                            });
                            $('#start-transit-btn').removeClass('hide').trigger('click');
                        } else {
                            loading_overlay.update({
                                icon: "fa fa-times",
                                text: "Load Failed!"
                            });
                        }
                        window.setTimeout(function () {
                            loading_overlay.hide();
                        }, 2000);
                    }
                });

                return;
            }

            $('#edit-ogpl-name').text(OGPLFormData.name);
            $('#edit-ogpl-date').text(moment(OGPLFormData.tripDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));

            if (data.cargoActivityType.code == 'INTRNT') {
                $('#edit-ogpl-from').text(data.fromOrganization.name);
                $('#edit-ogpl-to').text(data.toOrganization.name);
            } else {
                $('#edit-ogpl-from').text(data.fromStation.name);
                $('#edit-ogpl-to').text(data.toStation.name);
            }
            // $('#edit-ogpl-from').text($('#ogpl-from option:selected').text());
            // $('#edit-ogpl-to').text($('#ogpl-to option:selected').text());
            $('#edit-ogpl-arrival').text(function() {
                if (!$('#ogpl-arrivaltime').val()) {
                    return '-';
                }
                if ($('#ogpl-arrivalday').val() == '0') {
                    return $('#ogpl-arrivaltime option:selected').text();
                }
                return $('#ogpl-arrivaltime option:selected').text() + ' ' + $('#ogpl-arrivalday option:selected').text();
            });
            $('#edit-ogpl-departure').text(function() {
                if (!$('#ogpl-departuretime').val()) {
                    return '-';
                }
                return $('#ogpl-departuretime option:selected').text();
            });
            $('#edit-ogpl-vehicle').text(data.busVehicle.registationNumber);
            $('#edit-ogpl-driver').text(OGPLFormData.vehicleDriver.name);
            $('#edit-ogpl-driver2').text(OGPLFormData.secondaryDriver.name || '-');
            $('#edit-ogpl-odometer').text(OGPLFormData.odometer || '-');
            $('#edit-ogpl-via').text($('#ogpl-via option:selected').map(function() {
                return $(this).text();
            }).get().join(', '));
            $('#ogpl-form-div').hide();
            $('#edit-ogpl-list-container').fadeIn('slow');
            $('#edit-ogpl-search-container').fadeIn('slow');
            $('#add-ogpl-list-container').removeClass('hidden');
            $('#add-ogpl-list').html(loading_popup);

            data = {};
            data.code = $('#hid-ogpl-code').val();
            data.loadtype = loadtype;

            var transitType = $('#transit-type [name="transit-type"]:checked').val();

            var url = 'cargo/booked-ogpl-list';
            if (transitType == 'INTRNT') {
                url = 'cargo/booked-local-transit-list';
            }

            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + url,
                data: data,
                success: function(response) {
                    $('#add-ogpl-list').html(response);
                }
            });
        }

        function editOGPL() {
            $('#ogpl-form-div').fadeIn('slow');
            $('#edit-ogpl-list-container').hide();
            $('#edit-ogpl-search-container').hide();
            $('#add-ogpl-list-container').addClass('hidden');
        }

        function setOGPLTemplate(tplcode) {
            if (tplcode == '') {
                $('#ogpl-name').val('');
                $('#ogpl-from').val('').trigger('change');
                $('#ogpl-to').val('').trigger('change');
                $('#ogpl-via').select2('val', []);
                return;
            }
            var tpl = _.find(OGPLTemplates, function(o) {
                return o.code == tplcode;
            });
            $('#ogpl-name').val(tpl.name);

            var transitType = $('#transit-type [name="transit-type"]:checked').val();

            if (transitType == 'TRNT') {
                $('#ogpl-from').val(tpl.fromStation.code).trigger('change');
                $('#ogpl-to').val(tpl.toStation.code).trigger('change');
                var via = $.map(tpl.viaStations || [], function(val) {
                    return val.code;
                });
                $('#ogpl-via').select2('val', via);
            }

            var option = tpl;
            var arrivalMinutes, arrivalday;
            if (option.arrivalMinutes > 2880) {
                arrivalMinutes = option.arrivalMinutes - 2880;
                arrivalday = 2880;
            } else if (option.arrivalMinutes > 1440) {
                arrivalMinutes = option.arrivalMinutes - 1440;
                arrivalday = 1440;
            } else {
                arrivalMinutes = option.arrivalMinutes;
                arrivalday = 0;
            }
            $('#ogpl-arrivalday').val(arrivalday);
            $('#ogpl-arrivaltime').val(arrivalMinutes || '');
            $('#ogpl-departuretime').val(option.departureMinutes || '');
        }

        function getOgplList(ogplCode = '') {
            if (cargoSetting.ogplModelCode != 'VER2') {
                return;
            }
            var data = {};
            data.tripDate = $.trim($('#ogpl-search-date').val());
            data.vehicleCode = $.trim($('#ogpl-search-vehicle').val());
            data.transitCode = ogplCode;
    
            var err = 0;
            $('.inp_error').removeClass('inp_error');
            if(data.transitCode == '' && data.vehicleCode == '' && data.tripDate == '') {
                $('#ogpl-search-date').addClass('inp_error');
                $('#ogpl-search-vehicle').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#ogpl_search_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#ogpl_search_action_state').html('Please select atleast one option');
                $('#ogpl_search_action_state').show();
                return false;
            } else {
                $('#ogpl_search_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#ogpl_search_action_state').html('');
                $('#ogpl_search_action_state').hide();
            }

            $('#add-ogpl-container').hide();
            $('#ogpl-template-container').hide();
            $('#ogpl-search-list-container').show();
            $('#ogpl-search-list').html(loading_popup);

            $.ajax({
                type: "POST",
                url: base_url + "cargo/ogplv2-search-list",
                data: data,
                dataType: 'html',
                success: function (response) {
                    $('#ogpl-search-list').html(response);
                }
            });
        }

        function saveAndLoadOgpl(ogplCode) {
            var ogpl = _.find(ogplSearchData, e => e.code == ogplCode);
            if (!ogpl) {
                return;
            }

            if (ogpl.cargoActivityType.code == 'INTRNT') {
                fillOgplEdit(ogpl);
                return;
            }
            var toStation = $('#ogpl-search-to').val();
            var viaStations = $('#ogpl-search-via').val() || [];
            if (!viaStations.length && (!toStation || toStation == ogpl.toStation.code)) {
                var transitStations = []
                transitStations.push(ogpl.fromStation.code);
                transitStations.push(ogpl.toStation.code);
                $.each(ogpl.viaStations || [], function(i, val) {
                    transitStations.push(val.code);
                });
                if (!transitStations.includes(user_login_station)) {
                    $('#ogpl-summary-state').removeClass('alert-success').addClass('alert-danger');
                    $('#ogpl-summary-state').html('Vehicle not crossing your station, not allowed to load parcel. Add your station in route and try again.').show();
                    return;
                }
                fillOgplEdit(ogpl);
                return;
            }

            viaStations = viaStations.map(v => ({ code : v }));

            if (toStation && toStation != ogpl.toStation.code) {
                ogpl.viaStations = _.unionBy(ogpl.viaStations, viaStations, [ogpl.toStation], 'code');
                ogpl.toStation = {};
                ogpl.toStation.code = $('#ogpl-search-to').val();
                ogpl.toStation.name = $('#ogpl-search-to option:selected').text();
            } else {
                ogpl.viaStations = _.unionBy(ogpl.viaStations, viaStations, 'code');
            }

            OGPLEdit = ogpl;

            $('#ogpl-summary-state').removeClass('alert-success').removeClass('alert-danger');
            $('#ogpl-summary-state').html(loading_popup).show();

            $.ajax({
                type: "POST",
                url: base_url + 'cargo/load-ogpl-list',
                data: ogpl,
                dataType: 'json',
                success: function (response) {
                    if (response.status == 1) {
                        $('#ogpl-summary-state').removeClass('alert-danger').addClass('alert-success');
                        $('#ogpl-summary-state').html('Your request processed successfully');
                        setTimeout(function () {
                            var transitStations = []
                            transitStations.push(ogpl.fromStation.code);
                            transitStations.push(ogpl.toStation.code);
                            $.each(ogpl.viaStations || [], function(i, val) {
                                transitStations.push(val.code);
                            });
                            if (!transitStations.includes(user_login_station)) {
                                $('#ogpl-summary-state').removeClass('alert-success').addClass('alert-danger');
                                $('#ogpl-summary-state').html('Vehicle not crossing your station, not allowed to load parcel. Add your station in route and try again.').show();
                                return;
                            }
                            fillOgplEdit(ogpl);
                        }, 1000);
                    } else {
                        $('#ogpl-summary-state').removeClass('alert-success').addClass('alert-danger')
                        $('#ogpl-summary-state').html(response.errorDesc);
                    }
                }
            });
        }

        function showAddOGPL() {
            $('#ogpl-search-list-container').hide();
            $('#add-ogpl-container').fadeIn('slow');
            $('#ogpl-template-container').fadeIn('slow');
            $('#hid-ogpl-code').val('');
            $('#add-ogpl-form').trigger('reset');
            $('#ogpl-date').datepicker('setDate', 'today');
            $('#ogpl-tpl').val('').trigger('change');
            $('#ogpl-from').val('').trigger('change').prop('disabled', false);
            $('#ogpl-to').val('').trigger('change');
            $('#ogpl-via').select2('val', []);
            $('#ogpl-via-branches').select2('val', []);
            $('#driver2-panel').addClass('hide');

            $('#link-local-transit-div').addClass('hide');
            if (isNotNull(localTransitSearchData)) {
                $('label[for="link-local-transit"]').html('Link previous local transit');
                $('#link-local-transit').prop('checked', isNotNull(linkVehicleCode));
                $('#link-local-transit-div').removeClass('hide');
            }
        }

        function setEmptyLoad(ogplCode) {
            var ogpl = _.find(ogplSearchData, e => e.code == ogplCode);
            if (!ogpl) {
                return;
            }

            $('#hid-ogpl-code').val('');
            $('#add-ogpl-form').trigger('reset');

            showAddOGPL();
            $('#ogpl-from').val(ogpl.toStation.code).trigger('change').prop('disabled', true);
            $('#ogpl-template-container').hide();
        }

        function refreshOGPLV2(transitCode) {
            var data = {}
            data.transitCode = transitCode;

            var loading_overlay = iosOverlay({
                text: "Refreshing",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + 'cargo/refresh-ogplv2-data',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        window.setTimeout(function() {
                            getOgplList();
                        }, 1000);
                    } else {
                        // alert(response.errorDesc);
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }

        function getNextOGPLSequence() {
            if (cargoSetting.userAccountModel.code != 'DINV') {
                return;
            }
            var data = {};

            data.cargoActivityType = {};
            data.cargoActivityType.code = $('#transit-type [name="transit-type"]:checked').val()
            
            if (data.cargoActivityType.code == 'TRNT') {
                cargoSetting.transitLocationModelCode == 'STN'
                
                data.fromStation = {};
                data.fromStation.code = $('#ogpl-from').val();

                data.toStation = {};
                data.toStation.code = $('#ogpl-to').val();

                data.fromOrganization = {};
                data.fromOrganization.code = '';

                data.toOrganization = {};
                data.toOrganization.code = '';

            } else if (data.cargoActivityType.code == 'INTRNT') {
                data.fromStation = {};
                data.fromStation.code = $('#ogpl-from-branch option:selected').data('stationcode');

                data.toStation = {};
                data.toStation.code = $('#ogpl-to-branch option:selected').data('stationcode');

                data.fromOrganization = {};
                data.fromOrganization.code = $('#ogpl-from-branch').val();

                data.toOrganization = {};
                data.toOrganization.code = $('#ogpl-to-branch').val();
            }

            var err = 0;
            $('.inp_error').removeClass('inp_error');
            $('#ogpl-action-state').html('');
            if(data.cargoActivityType.code == 'TRNT' && !data.fromStation.code) {
                $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#ogpl-action-state').html('Please select from station').show();
                return false;
            }
            if(data.cargoActivityType.code == 'TRNT' && !data.toStation.code) {
                $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#ogpl-action-state').html('Please select to station').show();
                return false;
            }

            if(data.cargoActivityType.code == 'INTRNT' && !data.fromOrganization.code) {
                $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#ogpl-action-state').html('Please select from branch').show();
                return false;
            }
            if(data.cargoActivityType.code == 'INTRNT' && !data.toOrganization.code) {
                $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#ogpl-action-state').html('Please select to branch').show();
                return false;
            }
            
            $('#ogpl-action-state').removeClass('alert-success').removeClass('alert-danger').html('');
            $('#next-ogpl-sequence').html(loading_popup);
            
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/generate-next-ogpl-sequence",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                            $('#next-ogpl-sequence').html(('<i class="fa fa-info-circle" title="Next OGPL Sequence"></i> <span class="h5 bold">' + response.data.code + '</span>') || '');
                    } else {
                        $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                        $('#ogpl-action-state').html(response.errorDesc);
                    }
                }
            })
        }
    {/literal}
</script>
