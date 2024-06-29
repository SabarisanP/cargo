<div class="brand_top">
    <h3>
        {if $smarty.request.transitCode == ''}Add Transit{else}Edit Transit{/if}
    </h3>
    <span class="align-right">
        {if $smarty.request.transitCode == ''}
            <a href="#cargo/out-for-delivery" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>            
        {else}
            <a href="#cargo/out-for-delivery?fill=1" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>
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
                        <div class="col-lg-8 col-lg-offset-2">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-12">

                                            <div class="row">
                                                <div class="col-md-8">
                                                    <div class="form-group">
                                                        <label for="ogpl-name" class="req">Name</label>
                                                        <input type="text" class="form-control" id="ogpl-name" placeholder="Transit Name" maxlength="20">
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="ogpl-date" class="req">Date</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control sdate" id="ogpl-date" readonly="true" placeholder="Date" value="{$smarty.now|date_format:'%d-%m-%Y'}">
                                                            <label class="input-group-addon" for="ogpl-date"><i class="fa fa-calendar"></i></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-2 {if count($ownershipTypes) <= 1 || isNotNull($linkVehicleCode)}hide{/if}">
                                                    <label for="ogpl-ownership">Ownership Type</label>
                                                    <div class="input-group col-md-12">
                                                        <select id="ogpl-ownership" name="ownershipType" class="form-control">
                                                            <option value="NA">All Types</option>
                                                            {foreach key=code item=name from=$ownershipTypes}
                                                                <option value="{$code}">{$name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="{if count($ownershipTypes) <= 1}col-md-6{else}col-md-4{/if}">
                                                    <div class="form-group">
                                                        <label for="ogpl-vehicle" class="req">Vehicle
                                                            <a href="javascript:;" class="pull-right {if $smarty.request.transitCode}hide{/if}" onclick="quickAddNewVehicle()">Add New Vehicle</a>
                                                        </label>
                                                        <div class="input-group col-md-12">
                                                            <input type="text" id="ogpl-vehicle" class="form-control capitalize" placeholder="Select Vehicle" maxlength="12" {if isNotNull($linkVehicleCode)}disabled {else}onblur="getVehicleTransitList()"{/if}/> 
                                                        </div>
                                                    </div>
                                                </div>
                                                {* <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="ogpl-driver-name" class="req">Driver Name</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="ogpl-driver-name" class="form-control">
                                                                <option value="" selected="">Select Driver</option>
                                                                {foreach item=row from=$drivers}
                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div> *}
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="ogpl-driver-name" class="req">Driver Name</label>
                                                        <input type="text" name="ogpl-driver-name" value="" class="form-control capitalize" id="ogpl-driver-name" placeholder="Driver Name">
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="ogpl-driver-name">Driver Mobile</label>
                                                        <input type="text" name="ogpl-driver-mobile" value="" class="form-control capitalize" id="ogpl-driver-mobile" placeholder="Driver Mobile" maxlength="10">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <input class="form-control" placeholder="Remarks (optional)" id="ogpl-remarks"/>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-6 hide" id="link-local-transit-div">
                                                    <input type="checkbox" id="link-local-transit">
                                                    <label for="link-local-transit" class="d-inline"></label>
                                                </div>
                                            </div>

                                            <div class="clearfix_both"></div><br/>
                                            <div class="row">
                                                <div class="col-md-9">
                                                    <div class="alert" id="ogpl-action-state" style="display: none"></div>
                                                </div>
                                                <div class="col-md-3 text-right">
                                                    <input type="hidden" id="hid-ogpl-code" />
                                                    <input type="hidden" id="hid-driver-code" />
                                                    <input type="hidden" id="hid-driver2-code" />
                                                    <button class="btn btn-success" type="button" id="proceed-ogpl-btn" onclick="proceedOGPL();">Next</button>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>

                    <div class="row" id="edit-ogpl-list-container" style="display: none;">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="edit-ogpl-list">
                                        <div class="row">
                                            <div class="col-md-3"><b>Name :</b> <span id="edit-ogpl-name"></span></div>
                                            <div class="col-md-3"><b>Date :</b> <span id="edit-ogpl-date"></span></div>
                                            {*<div class="col-md-3"><b>From :</b> <span id="edit-ogpl-from"></span></div>
                                            <div class="col-md-3"><b>To :</b> <span id="edit-ogpl-to"></span></div>*}
                                            <div class="col-md-3"><b>Vehicle :</b> <span id="edit-ogpl-vehicle"></span></div>
                                            <div class="col-md-3"><b>Driver :</b> <span id="edit-ogpl-driver"></span></div>
                                            <div class="col-md-12">
                                                {*<b>Via :</b> <span id="edit-ogpl-via"></span>*}
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
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>

<script id="vehicle-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-7">
            <b class="vehicle-name"></b><br>
            <span class="vehicle-ownership text-muted small" title="Ownership Type"></span>
            <span class="text-muted small" title="Vehicle Type">(<span class="vehicle-type"></span>)</span>
        </div>
        <div class="col-xs-5 text-right nowrap">
            <span class="vehicle-transit-status" title="Vehicle Transit Status"></span><br>
            <span class="vehicle-location text-muted small" title="Vehicle Available At"></span>
        </div>
    </div>
</script>

<script>
    var OGPLEdit = {$ogpl|json_encode};
    var OGPLFormData = {};
    var OGPLVehicles = {$vehicles|json_encode};
    var driversData = {$drivers|json_encode};
    var drivers = {$drivers|json_encode};
    var cargoSetting = {$cargo_setting|json_encode};
    var linkVehicleCode = {$linkVehicleCode|json_encode};

    $('#ogpl-ownership').on('change', function() {
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
            $tpl.find('.vehicle-ownership').text(vehicle.ownershipType.name);

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
            
            return $tpl;
        };

        function matcher(term, text, vehicle) {
            text = [vehicle.registationNumber, vehicle.vehicleType.name, vehicle.transitStation.name, vehicle.transitOrganization.name, vehicle.ownershipType.name].join(' ');
            return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
        };

        $('#ogpl-vehicle').val(null).select2('destroy');
        $('#ogpl-vehicle').select2({
            data: { results: vehiclesData },
            placeholder: 'Select Vehicle',
            formatResult: formatResult,
            formatSelection: formatResult,
            matcher: matcher
        });
    }).trigger('change');

    $('#ogpl-vehicle').on('change', function () {
        var vehicleCode = this.value;
        var vehicle = _.find(OGPLVehicles, o => o.code == vehicleCode);

        $('#proceed-ogpl-btn').toggleClass('hide', vehicle.transitStatusCode == 'INTRN');
    });

    if (linkVehicleCode) {
        $('#ogpl-vehicle').val(linkVehicleCode).trigger('change').prop('disabled', true);
        getVehicleTransitList();
    }

    var driverItem = function(ul, item) {
        return $('<li class="ui-menu-item">')
            .append('<a><b>' + item.name + ' ' + (item.lastName || '') + '</b><br/><span class="text-muted"><small>' + (item.mobileNumber || '') + '</small><small class="pull-right">' + (item.ownershipType.name || '') + '</small></span></a>')
            .appendTo(ul);
    }

    var filterDriverSource = function (request, response) {
        var query = request.term.toLowerCase();

        var vehicleCode = $('#ogpl-vehicle').val()
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

    $('#ogpl-driver-name, #ogpl-driver-mobile, #ogpl-driver2-name, #ogpl-driver2-mobile').each(function () {
        $(this).data('uiAutocomplete')._renderItem = driverItem
    }).on('focus', function () {
        $(this).autocomplete('search', this.value || '');
    });

    {literal}
        if (!$.isEmptyObject(OGPLEdit)) {
            $('#hid-ogpl-code').val(OGPLEdit.code);
            $('#ogpl-name').val(OGPLEdit.name);
            $('#ogpl-date').val(moment(OGPLEdit.tripDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('#ogpl-driver-name').val(OGPLEdit.vehicleDriver.name);
            $('#hid-driver-code').val(OGPLEdit.vehicleDriver.code);
            $('#ogpl-driver-mobile').val(OGPLEdit.vehicleDriver.mobileNumber);
            $('#ogpl-remarks').val(OGPLEdit.remarks);
            $('#ogpl-vehicle').val(OGPLEdit.busVehicle.code).trigger('change');
            $('#ogpl-from').val(OGPLEdit.fromStation.code);
            $('#ogpl-to').val(OGPLEdit.toStation.code);
            $.each(OGPLEdit.viaStations, function (i, val) {
                $('#ogpl-via').find('[value="' + val.code + '"]').attr('selected', true);
            });
            proceedOGPL();
        }

        $('#ogpl-date').datepicker({
            format: 'dd-mm-yyyy',
            autoclose: true,
            changeMonth: true,
            todayHighlight: true
        });

        

        $('#ogpl-from').select2();
        $('#ogpl-to').select2();
        $('#ogpl-via').select2({
            placeholder: 'Select Via Stations'
        });
        $('#ogpl-via .select2-choices').css('max-height', '400px');

        function proceedOGPL() {
            var data = {};
            data.activeFlag = 1;
            data.cargoActivityType = {};
            data.cargoActivityType.code = 'OTFD';

            data.code = $('#hid-ogpl-code').val();
            data.name = $('#ogpl-name').val().trim();
            data.tripDate = $('#ogpl-date').val();
            data.driverName = $.trim($('#ogpl-driver-name').val());
            data.remarks = $('#ogpl-remarks').val().trim();
            data.via = $('#ogpl-via').val();

            var busVehicle = $('#ogpl-vehicle').select2('data');
            data.busVehicle = {};
            data.busVehicle.code = '';
            if (busVehicle) {
                data.busVehicle.code = busVehicle.code;
                data.busVehicle.registationNumber = busVehicle.registationNumber;

                if (!data.code && busVehicle.transitStatusCode == 'INTRN') {
                    $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#ogpl-action-state').html('Vehicle not free, please unload loaded LR or check duplicate OGPL');
                    $('#ogpl-action-state').show();
                    return false;
                }
            }
            
            data.vehicleDriver = {};
            data.vehicleDriver.code = $('#hid-driver-code').val();
            data.vehicleDriver.name = $.trim($('#ogpl-driver-name').val());
            data.vehicleDriver.mobileNumber = $.trim($('#ogpl-driver-mobile').val());

            data.transitReference = [];
            if ($('#link-local-transit').is(':checked')) {
                data.transitReference.push({ code: $('#link-local-transit').val() })
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
            if (data.busVehicle.code == '') {
                $('#ogpl-vehicle').addClass('inp_error');
                err++;
            }
            if (data.vehicleDriver.name == '') {
                $('#ogpl-driver-name').addClass('inp_error');
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
            $('#edit-ogpl-vehicle').text(data.busVehicle.registationNumber);
            $('#edit-ogpl-driver').text(OGPLFormData.driverName);
            $('#edit-ogpl-via').text($('#ogpl-via option:selected').map(function () {
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
                url: base_url + 'cargo/booked-out-for-delivery-list',
                data: data,
                success: function (response) {
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

        function getVehicleTransitList() {
            $('#link-local-transit-div').addClass('hide');

            var vehicleCode = $('#ogpl-vehicle').val();
            var vehicle = _.find(OGPLVehicles, e => e.code == vehicleCode);
            if (!vehicle) {
                return;
            }

            var data = {};
            data.vehicleCode = vehicle.code;
            if (!data.vehicleCode) {
                return;
            }

            $.ajax({
                type: "POST",
                url: base_url + 'cargo/get-vehicle-transit-details',
                data: data,
                dataType: 'json',
                success: function (response) {
                    if (response.status == 1) {
                        if (Array.isArray(response.data) && response.data.length == 1) {
                            var lastTransit = response.data[0];
                            $('label[for="link-local-transit"]').html(function () {
                                if (lastTransit.cargoActivityType.code == 'TRNT') {
                                    return 'Link previous OGPL';
                                } 
                                if (lastTransit.cargoActivityType.code == 'INTRNT') {
                                    return 'Link previous Local Transit';
                                } 
                                if (lastTransit.cargoActivityType.code == 'OTFD') {
                                    return 'Link previous Door pickup / Door Delivery';
                                }
                                return 'Link previous Transit';
                            });
                            $('#link-local-transit-div').removeClass('hide');
                            $('#link-local-transit').val(response.data[0].code).prop('checked', isNotNull(linkVehicleCode));
                        }
                    }
                }
            });
        }
    {/literal}
</script>