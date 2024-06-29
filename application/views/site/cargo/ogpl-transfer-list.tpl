<div class="col-md-2">
    <div class="form-group">
        <label for="transfer_date">Trip Date</label>
        <div class="input-group">
            <input type="text" name="fromDate" class="form-control sdate" id="transfer_date" readonly="true" placeholder="Trip Date">
            <label class="input-group-addon" for="transfer_date"><i class="fa fa-calendar"></i></label>
        </div>
    </div>
    <div class="form-group">
        <label for="transfer_vehicle">Vehicle</label>
        <div class="input-group col-md-12">
            <select id="transfer_vehicle" name="vehicleCode" class="form-control">
                <option value="" selected="">All Vehicle</option>
                {foreach item=row from=$vehicles}
                    {if $row->activeFlag == 1}
                        <option {if $fvehicle==$row->code} selected="selected" {/if} value="{$row->code}">{$row->registationNumber} - {$row->vehicleType->name}</option>
                    {/if}
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="input-group">
            <button class="btn btn-primary" onclick="getTransferOGPL()">Get {lang('ogpl')}</button>
        </div>
    </div>
</div>

<div class="col-md-5">
    <table id="ogpl-routes-table" class="table table-bordered" >
        <thead>
            <tr class="success bold">
                <td align="center"></td>
                <td align="center">Route</td>
            </tr>
        </thead>
        <tbody class="body_table">

            {foreach item=row from=$result key=t1}
                <tr id="{$t1|clean_string}" class="tr-hover" onclick="toggleOgplRoute('{$t1|clean_string}', event);">
                    <td align="center">
                        <input type="checkbox" class="ogpl-route-cb" onchange="selectOgplRoute(event, '{$t1}');" value="{$t1}" data-fromstation="{$row[0]->from_station_code}" data-tostation="{$row[0]->to_station_code}"/>
                    </td>
                    <td align="center" colspan="6" class="bold">{$t1}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td align="center" colspan="6">Sorry! No cargo found</td>
                </tr>
            {/foreach}
        </tbody>
    </table>

    <table class="hide">
        {foreach item=row1 from=$result key=t1}
            <tr class="{$t1|clean_string} hide ogplroute">
                <td>
                    <table class="table table-bordered " width="100%">
                        <thead>
                            <tr class="info bold">
                                <td align="center">{lang('lr')}</td>
                                <td align="center">Booked Date</td>
                                <td align="center">Booked At</td>
                                <td align="center">Delivery At</td>
                                <td align="center">Booked By</td>
                                <td align="center">Payment Status</td>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach item=row from=$row1 key=t}
                                {if $row->cargo_status_code != 'CL'}
                                    {continue}
                                {/if}
                                <tr>
                                    <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                                    <td align="center">{$row->booked_at|date_format:$ns_date_format}</td>
                                    <td align="center">{$row->from_organization_name}</td>
                                    <td align="center">{$row->to_organization_name}</td>
                                    <td align="left">{$row->user_first_name}</td>
                                    <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </td>
            </tr>
        {/foreach}
    </table>
</div>

<div class="col-md-5">
    <div class="row hide" id="new-ogpl-panel">
        <div class="col-md-12">
            <div class="form-group">
                <label for="new-ogpl-list" class="req">{lang('ogpl')}</label>
                <input type="text" class="form-control" id="new-ogpl-list"/>
            </div>
        </div>
        <div class="col-md-4 pull-right">
            <div class="text-right">
                <button class="btn btn-success" type="button"  onclick="{if isNotNull($transfer_end_odo) && $transfer_end_odo > 0}transferOgplDialog('{$transfer_end_odo}', 'TRANSFER');{else}transferOgplEndTripDialog();{/if}">Validate & Transfer</button>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div id="transfer-ogpl-alert"></div>
    </div>
</div>

<div id="transfer-ogpl-end-trip-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideTransferOgplEndTripDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="end-trip-panel" class="clearfix" style="padding: 10px 5px;">
        <form onsubmit="return false;">
            <div class="row">
                <div class="col-md-6 text-center">
                    <img src="assets/img/start-trip.png" width="80%">
                </div>
                <div class="col-md-6 text-right">
                    <h4 class="bold">Arrival Time</h4>
                    <h5 id="transfer-ogpl-trip-end-date"></h5>
                    <h4 id="transfer-ogpl-trip-end-time"></h4>
                    <div class="clearfix"></div>
                    <h5 class="bold">Last odometer Reading</h5>
                    <h4><span id="transfer-ogpl-last-odometer"></span> Km</h4>
                </div>
                <div class="col-md-12">
                    <label class="req h5">Enter odometer reading to End Trip</label>
                    <div class="row">
                        <div class="col-md-4">
                            <input type="number" id="transfer-ogpl-end-trip-odo" class="form-control no-spin" placeholder="Odometer">
                        </div>
                        <div class="col-md-4 p_l_n">
                            <div class="input-group col-md-12">
                                <select id="transfer-ogpl-end-trip-supervisor" class="form-control">
                                    <option value="" selected>Select Supervisor</option>
                                    {foreach item=row from=$branchContact}
                                        {if $row->category->code == 'SPVSR'}
                                            <option value="{$row->code}">{$row->name}</option>                                    
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning col-md-3" id="transfer-ogpl-end-trip-panel-btn" onclick="transferOgpl();">End Trip</button>
                    </div>
                </div>
                <div class="col-md-12"><br>
                    <div id="transfer-ogpl-end-trip-action-state"></div>
                </div>
            </div>
        </form>
    </div>
</div>

<script id="ogpl-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-8">
            <b class="ogpl-name"></b><br>
            <span class="station-name text-muted small"></span>
        </div>
        <div class="col-xs-4 text-right">
            <b class="ogpl-code"></b><br>
            <span class="ogpl-vehicle"></span>
        </div>
    </div>
</script>

<script>
    var ogplRouteLrs = {$result|json_encode};
    var allVehicles = {$vehicles|json_encode};
    var ogplCode = {$ogpl_code|json_encode};
    var ogplVehicleCode = {$ogpl_vehicle|json_encode};

    $('#new-ogpl-list').select2({
        data: { results: [] }
    });

    $('#transfer_vehicle').select2();
    $('#transfer_date').datepicker({
        todayHighlight: true,
        format: 'yyyy-mm-dd',
        startDate: '-1w',
        endDate: '+1w',
        autoclose: true,
        changeMonth: false,
    });

    var ogplSelectTpl = $('#ogpl-select-tpl').html();

    function ogplFormatResult(ogpl) {
        if (!ogpl.code) return ogpl.name;

        var $tpl = $(ogplSelectTpl);
        $tpl.find('.ogpl-name').text(ogpl.name);
        $tpl.find('.ogpl-code').text(ogpl.aliasCode);
        $tpl.find('.ogpl-vehicle').text(ogpl.busVehicle.registationNumber);
        $tpl.find('.station-name').text(ogpl.viaStations.map(o => o.name).join(', '));
        return $tpl;
    };

    function ogplMatcher(term, text, branch) {
        text = [branch.name, branch.aliasCode, ogpl.viaStations.map(o => o.name).join(', ')].join(' ');
        return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
    };

    function toggleOgplRoute(code) {
        if ($(event.target).is(':input')) {
            return;
        }
        if($('.ogpllrlist').hasClass(code)) {
            $('.ogpllrlist .slide').slideToggle('linear', function() {
                $('.ogpllrlist').remove();
            });
            return;
        }
        $('.ogpllrlist').remove();
        var $trows = $('.ogplroute').filter('.' + code);
        $('#'+code).after('<tr class="ogpllrlist ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">'
                + $trows.html() + '</table></div></td></tr>');
        $('.ogpllrlist .slide').slideToggle('linear');
    }

    function selectOgplRoute(event, code) {
    }

    function getTransferOGPL() {
        var data = {};
        data.tripDate = $('#transfer_date').val();
        data.busVehicle = {};
        data.busVehicle.code = $('#transfer_vehicle').val();
        data.transitCargoDetails = [];

        $('#ogpl-routes-table .ogpl-route-cb:checked').each(function () {
            var route = {};
            route.fromStation = {};
            route.fromStation.code = $(this).data('fromstation');
            route.toStation = {};
            route.toStation.code = $(this).data('tostation');

            data.transitCargoDetails.push(route);
        });

        $('.inp_error').removeClass('inp_error');
        if (!data.tripDate) {
            $('#transfer_date').addClass('inp_error');
            return;
        }

        if (!data.transitCargoDetails.length) {
            $('#transfer-ogpl-alert').addClass('alert alert-danger').html('Please select at least one {lang('ogpl')} route.');
            return;
        }

        $('#transfer-ogpl-alert').removeClass('alert alert-danger alert-success').html(loading_popup);
        $('#new-ogpl-panel').addClass('hide');

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/get-transfer-ogpl",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    if (response.data.length == 0) {
                        $('#transfer-ogpl-alert').addClass('alert alert-danger').html('No {lang('ogpl')} matches to transfer');
                        return;
                    }
                    $('#new-ogpl-list').select2('destroy');
                    $('#new-ogpl-list').select2({
                        data: { results: response.data || [] },
                        placeholder: 'Select {lang('ogpl')}',
                        formatResult: ogplFormatResult,
                        formatSelection: ogplFormatResult,
                        matcher: ogplMatcher,
                        id: (o) => o.code
                    });

                    $('#transfer-ogpl-alert').html('');
                    $('#new-ogpl-panel').removeClass('hide');
                } else {
                    $('#transfer-ogpl-alert').addClass('alert alert-danger').html(response.errorDesc);
                }
            }
        });
    }

    function transferOgplEndTripDialog() {
        $('.inp_error').removeClass('inp_error');
        var transitCargo = $('#new-ogpl-list').val();
        if (!transitCargo) {
            $('#new-ogpl-list').addClass('inp_error');
            return;
        }
        
        $('#transfer-ogpl-end-trip-dialog').removeClass('hide');
        $('#transfer-ogpl-end-trip-dialog').dialog({
            autoOpen: true,
            width: 550,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
        $('#transfer-ogpl-end-trip-dialog .inp_error').removeClass('inp_error');
        $('#transfer-ogpl-end-trip-action-state').removeClass('alert alert-danger alert-success').html('');
        $('#transfer-ogpl-end-trip-odo').val('');

        $('#transfer-ogpl-trip-end-date').html(moment().format('DD MMM YYYY'));
        $('#transfer-ogpl-trip-end-time').html(moment().format('hh : mm A'));

        var vehicle = _.find(allVehicles, o => o.code == ogplVehicleCode) || {};
        if (vehicle) {
            $('#transfer-ogpl-last-odometer').html(vehicle.lastOdometer);
        }
    }

    function hideTransferOgplEndTripDialog() {
        $('#transfer-ogpl-end-trip-dialog').dialog('destroy');
        $('#transfer-ogpl-end-trip-dialog').hide();
    }

    function transferOgplEndTrip(endOdometerData) {
        var data = {}, err = 0;
        data.action = 'ARRIVAL';
        data.transitCode = ogplCode;
        data.transitCargo = {};
        data.transitCargo.code = ogplCode;
        data.toOrganization = {};
        data.toOrganization.code = '{$logged_in_org}';
        data.endOdometer = endOdometerData.endOdometer;
        data.arrivalAt = endOdometerData.arrivalAt;
        data.toOrganizationContact = {};
        data.toOrganizationContact.code = endOdometerData.toOrganizationContact.code;
        
        $('#transfer-ogpl-end-trip-panel-btn').hide();
        $('#transfer-ogpl-end-trip-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-end-odometer",
            data: data,
            success: function (response) {
                if (response.status == 1) {                
                    $('#transfer-ogpl-end-trip-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function () {
                        hideTransferOgplEndTripDialog();
                    }, 3000);
                } else {
                    $('#transfer-ogpl-end-trip-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#transfer-ogpl-end-trip-panel-btn').show();
                }
            }
        })
    }

    function transferOgplDialog(endOdo, type) {
        var title = "Do you want to update End Odometer?";
        var txt = 'Last odometer Reading : ' + endOdo + 'km';

        if (endOdo > 0) {
            swal({
                title: title,
                text: txt,
                type: "warning",
                showCancelButton: true,
                confirmButtonClass: "btn-success",
                confirmButtonText: "Yes, Continue!",
                closeOnConfirm: false,
                closeOnCancel: true,
                closeOnEscape: false
            },function(isConfirm) {
                if (isConfirm) {
                    swal.close();
                    transferOgplEndTripDialog();
                } else {
                    swal.close();
                    transferOgpl(type)
                }
            });
        } else {
            transferOgpl(type)
        }
    }

    function transferOgpl(type) {
        var data = {};
        data.routeList = [];

        var transitCargo = $('#new-ogpl-list').val();

        $('#ogpl-routes-table .ogpl-route-cb:checked').each(function () {
            var routekey = $(this).val();
            var lrList = ogplRouteLrs[routekey];

            var route = {};
            route.activeFlag = 1;
            route.toStation = {};
            route.toStation.code = lrList[0].to_station_code;
            route.fromStation = {};
            route.fromStation.code = lrList[0].from_station_code;
            route.fromOrganization = {};
            route.fromOrganization.code = lrList[0].from_organization_code;
            route.toOrganization = {};
            route.toOrganization.code = lrList[0].to_organization_code;
            route.transitCargo = {};
            route.transitCargo.code = transitCargo;
            route.transitOrganization = {};
            route.transitOrganization.code = lrList[0].transit_organization_code;
            route.cargoList = [];
            
            $.each(lrList || [], function (i, lr) {
                if (lr.cargo_status_code == 'CL') {
                    route.cargoList.push({ code : lr.cargo_code })
                }
            })

            data.routeList.push(route);
        });

        $('.inp_error').removeClass('inp_error');
        if (!transitCargo) {
            $('#new-ogpl-list').addClass('inp_error');
            return;
        }

        if (type != 'TRANSFER') {
            var endOdometerData = {}, err = 0;
            endOdometerData.endOdometer = Number($('#transfer-ogpl-end-trip-odo').val());
            endOdometerData.arrivalAt = moment().format('YYYY-MM-DD HH:mm:ss');
            endOdometerData.toOrganizationContact = {};
            endOdometerData.toOrganizationContact.code = $('#transfer-ogpl-end-trip-supervisor').val();

            $('.inp_error').removeClass('inp_error');
            if (isNaN(endOdometerData.endOdometer) || endOdometerData.endOdometer <= 0) {
                $('#transfer-ogpl-end-trip-odo').addClass('inp_error');
                err++;
            }

            var vehicle = _.find(allVehicles, o => o.code == ogplVehicleCode) || {};
            if (vehicle && vehicle.lastOdometer > 0 && endOdometerData.endOdometer < vehicle.lastOdometer) {
                $('#transfer-ogpl-end-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
                $('#transfer-ogpl-end-trip-action-state').html('Entered odometer value should be greater than last odometer value');
                return;
            }

            if(err) {
                $('#transfer-ogpl-end-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
                $('#transfer-ogpl-end-trip-action-state').html('Please enter/select the values in the field that are marked in red');
                return;
            }
        }
        
        $('#transfer-ogpl-alert').removeClass('alert alert-danger alert-success').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/validate-and-transfer-ogpl",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    var failed = '';
                    $.each(response.data && response.data.cargoList || [], function (i, row) {
                        if (row.activeFlag == 0) {
                            failed += row.code + ' - ' + row.name + '<br/>';
                        }
                    });
                    if (isNull(failed)) {
                        transferOgplEndTrip(endOdometerData);
                    }
                    $('#transfer-ogpl-alert').addClass('alert alert-success').html(failed || 'Your request processed successfully');
                } else {
                    $('#transfer-ogpl-alert').addClass('alert alert-danger').html(response.errorDesc);
                }
            }
        });
    }
</script>