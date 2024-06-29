<div class="brand_top">
    <h3>
        {if $smarty.request.transitCode == ''}Add {lang('ogpl')}{else}Edit {lang('ogpl')}{/if}
    </h3>
    <span class="align-right">
        {if $smarty.request.transitCode == ''}
            <a href="#cargo/ogpl" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>
        {else}
            <a href="#cargo/ogpl?fill=1" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>
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
                                        <div class="col-md-2 {if count($ownershipTypes) <= 1}hide{/if}">
                                            <label for="ogpl-search-owner">Ownership Type</label>
                                            <div class="input-group col-md-12">
                                                <select id="ogpl-search-owner" name="ownershipType" class="form-control">
                                                    <option value="NA">All Types</option>
                                                    {foreach key=code item=name from=$ownershipTypes}
                                                        <option value="{$code}">{$name}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <label for="ogpl-search-vehicle">Vehicle
                                            {if $action_rights['ADD-NEW-VEHICLE']}
                                                <a href="javascript:;" class="pull-right" onclick="quickAddNewVehicle()">Add New Vehicle</a>
                                            {/if}
                                            </label>
                                            <div class="input-group col-md-12">
                                                <input type="text" class="form-control" id="ogpl-search-vehicle">
                                            </div>
                                            <div class="text-muted m-t-5 hide" id="vehicle-location-info"><b>Available At : </b><span id="vehicle-location"></span></div>
                                        </div>

                                        {* <div class="form-group col-md-2">
                                            <label for="ogpl-search-date">Date</label>
                                            <div class="input-group">
                                                <input type="text" name="toDate" class="form-control sdate" id="ogpl-search-date" readonly placeholder="Date">
                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div> *}

                                        <div class="form-group col-md-2">
                                            <label for="">&nbsp;</label>
                                            <div class="input-group">
                                                {* <button class="btn btn-success" type="button" onclick="getOgplList();">Get {lang('ogpl')}</button>&nbsp; *}
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

                            <div class="panel panel-default" id="ogpl-search-list-container" style="display: none;">
                                <div class="panel-body">
                                    <div id="ogpl-search-list"></div>                                    
                                </div>
                            </div>

                            <div id="add-ogpl-container">
                                <br>
                                <div class="row">
                                    <div class="col-md-9">
                                        <div class="panel panel-default">
                                            <div class="heading_b">Transit Details</div>
                                            <div class="panel-body">
                                                <form id="add-ogpl-form" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-3">
                                                            <label for="ogpl-date">Transit Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="ogpl-date" readonly {if $action_rights['OGPL-PREV-DATE'] != 1}disabled{/if} placeholder="Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4"></div>
                                                        <div class="col-md-5">
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
                                                                        <label class="pull-right"><input type="checkbox" id="save-as-tpl"> Save as Template</label>
                                                                        <label for="ogpl-name" class="req">Name</label>
                                                                        <input type="text" class="form-control" id="ogpl-name" placeholder="{lang('ogpl')} Name" maxlength="40">
                                                                    </div>
                                                                    <input type="hidden" id="ogpl-date" />
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="ogpl-from" class="req">From Station</label>
                                                                        <div class="input-group col-md-12">
                                                                            <select id="ogpl-from" class="form-control">
                                                                                <option value="" selected="">Select From</option>
                                                                                {foreach item=station from=$stations}
                                                                                    <option value="{$station.code}">{$station.name}</option>
                                                                                {/foreach}
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="ogpl-departuretime" class="req">Departure Time</label>
                                                                        <select id="ogpl-departuretime" class="form-control">
                                                                            <option value="" selected="">Select Time</option>
                                                                            {assign var="timerange" value=hours_range(0, 86400 -1, 60 * 15)}
                                                    
                                                                            {foreach item=time key=seconds from=$timerange}
                                                                                <option value="{$seconds / 60}">{$time}</option>
                                                                            {/foreach}
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="ogpl-to" class="req">To Station</label>
                                                                        <div class="input-group col-md-12">
                                                                            <select id="ogpl-to" class="form-control">
                                                                                <option value="" selected="">Select To</option>
                                                                                {foreach item=station from=$stations}
                                                                                    <option value="{$station.code}">{$station.name}</option>
                                                                                {/foreach}
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="ogpl-arrivaltime" class="req">Arrival Time</label>
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
                                                            <div class="form-group">
                                                                <label for="ogpl-via" class="req">Via Stations</label>
                                                                <div class="input-group col-md-12 ogpl-via-stations">
                                                                    <select id="ogpl-via" class="form-control" multiple="multiple">
                                                                        {foreach item=station from=$stations}
                                                                            <option value="{$station.code}">{$station.name}</option>
                                                                        {/foreach}
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
                                                    <button class="btn btn-success" type="button" onclick="{if $action_rights['OGPL-IS-FLEET-FREE']==1} validateOGPL(); {else} proceedOGPL(); {/if}">Next</button>
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
                                                {* <span class="badge m-t-5 hide" id="loading-until-badge"></span>&emsp; *}
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
            <span class="vehicle-location text-muted small" title="Vehicle Available At"></span>
            <span class="vehicle-transit-status text-muted small" title="Vehicle Transit Status"></span>
        </div>
        <div class="col-xs-5 text-right nowrap">
            <span class="vehicle-type small" title="Vehicle Type"></span><br>
            <span class="vehicle-ownership text-muted small" title="Ownership Type"></span>
        </div>
    </div>
</script>

<style>
    .ogpl-via-stations .select2-choices {
        height: 68px!important;
    }
</style>

<script>
    var OGPLEdit = {$ogpl|json_encode};
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
            $('#ogpl-form-div .inp_error').removeClass('inp_error');
            
            $('#hid-ogpl-code').val(OGPLEdit.code);
            $('#ogpl-name').val(OGPLEdit.name);
            $('#ogpl-date').val(moment(OGPLEdit.tripDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('#ogpl-odometer').val(OGPLEdit.odometer);
            $('#ogpl-remarks').val(OGPLEdit.remarks);

            $('#ogpl-search-vehicle').val(OGPLEdit.busVehicle.code).trigger('change');

            $('#ogpl-from').val(OGPLEdit.fromStation.code);
            $('#ogpl-to').val(OGPLEdit.toStation.code);
            $('#ogpl-driver-name').val(OGPLEdit.vehicleDriver.name);
            $('#hid-driver-code').val(OGPLEdit.vehicleDriver.code);
            $('#ogpl-driver-mobile').val(OGPLEdit.vehicleDriver.mobileNumber);
            $('#ogpl-driver2-name').val(OGPLEdit.secondaryDriver.name);
            $('#hid-driver2-code').val(OGPLEdit.secondaryDriver.code);
            $('#ogpl-driver2-mobile').val(OGPLEdit.secondaryDriver.mobileNumber);
            $.each(OGPLEdit.viaStations, function(i, val) {
                $('#ogpl-via').find('[value="' + val.code + '"]').attr('selected', true);
            });
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
            // if (OGPLEdit.activity.includes('COMPLETE')) {
            //     loadtype = 'RESTRICT';
            //     $('#loading-until-badge').html('Loading Closed').addClass('badge-danger').removeClass('hide');
            // } else {

                var user_organization_found = false;
                $.each(OGPLEdit.transitRoutes || [], function (i, detail) {
                    if (detail.createdAt && detail.organization && detail.organization.code == user_login_branch) {
                        user_organization_found = true;
                        var allowedTill = moment(detail.createdAt).add(2, 'hours');
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
                //             }

            proceedOGPL(loadtype);
        }
        if (!$.isEmptyObject(OGPLEdit)) {
            $('#ogpl-search-container .form-group').hide();
            $('#ogpl-search-container #ogpl-search-vehicle').prop('disabled', true).closest('.form-group').show();
            // getOgplList(OGPLEdit.code);
            fillOgplEdit(OGPLEdit);
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

        $('#ogpl-search-owner').on('change', function() {
            var ownershipType = this.value;

            var vehiclesData = [];
            $.each(OGPLVehicles || [], function(i, row) {
                if (isNull(ownershipType) || ownershipType == row.ownershipType.code) {
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
                $tpl.find('.vehicle-location').text(vehicle.transitStation.name || '-');
                if (vehicle.transitStatusCode == 'CMPLT') {
                    $tpl.find('.vehicle-transit-status').html('<span style="padding: 1px 4px;" class="badge badge-success"><small>AVAILABLE<small></span>');
                } else if (vehicle.transitStatusCode == 'INTRN') {
                    $tpl.find('.vehicle-transit-status').html('<span style="padding: 1px 4px;" class="badge badge-danger"><small>IN TRANSIT<small></span>');
                }
                $tpl.find('.vehicle-ownership').text(vehicle.ownershipType.name);
                return $tpl;
            };

            function matcher(term, text, vehicle) {
                text = [vehicle.registationNumber, vehicle.vehicleType.name, vehicle.transitStation.name, vehicle.ownershipType.name].join(' ');
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
        }).trigger('change');

        $('#ogpl-search-vehicle').on('change', function () {
            $('#vehicle-location-info, #vehicle-details').addClass('hide');
            $('#ogpl-template-container').hide();
            $('#ogpl-search-list-container').hide();

            var vehicleCode = this.value;
            if (!vehicleCode) {
                return;
            }

            var vehicle = _.find(OGPLVehicles, o => o.code == vehicleCode);
            if (!vehicle) {
                return;
            }

            if (vehicle.transitStation.code) {
                $('#vehicle-location').html(vehicle.transitStation.name || '');
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
            // getOgplList();
        }

        $('#ogpl-search-date').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true,
            todayHighlight: true
        });

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
            data.cargoActivityType.code = 'TRNT';

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
            if (data.fromStation.code == '') {
                $('#ogpl-from').addClass('inp_error');
                err++;
            }
            if (data.toStation.code == '') {
                $('#ogpl-to').addClass('inp_error');
                err++;
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

            if (data.viaStations.length == 0) {
                $('#ogpl-via').addClass('inp_error');
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

        function proceedOGPL() {
            var data = {};
            data.activeFlag = 1;
            data.cargoActivityType = {};
            data.cargoActivityType.code = 'TRNT';

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

            data.viaStations = []
            
            $('#ogpl-via option:selected').each(function(i, val) {
                data.viaStations.push({ code: $(val).val(), name: $(val).text() });
            });

            $('#ogpl-search-via option:selected').each(function(i, val) {
                data.viaStations.push({ code: $(val).val(), name: $(val).text() });
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
            if (data.fromStation.code == '') {
                $('#ogpl-from').addClass('inp_error');
                err++;
            }
            if (data.toStation.code == '') {
                $('#ogpl-to').addClass('inp_error');
                err++;
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
            if (data.viaStations.length == 0) {
                $('#ogpl-via').addClass('inp_error');
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

            $('#edit-ogpl-name').text(OGPLFormData.name);
            $('#edit-ogpl-date').text(moment(OGPLFormData.tripDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('#edit-ogpl-from').text($('#ogpl-from option:selected').text());
            $('#edit-ogpl-to').text($('#ogpl-to option:selected').text());
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

            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'cargo/booked-ogpl-list',
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
            $('#ogpl-from').val(tpl.fromStation.code).trigger('change');
            $('#ogpl-to').val(tpl.toStation.code).trigger('change');
            var via = $.map(tpl.viaStations || [], function(val) {
                return val.code;
            });
            $('#ogpl-via').select2('val', via);

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
    {/literal}
</script>
