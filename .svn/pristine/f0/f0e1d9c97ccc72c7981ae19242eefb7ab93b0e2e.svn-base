{if $smarty.request.code != ''}
    <ul class="nav nav-tabs" id="tabs_a">                                            
        <li class="active"><a data-toggle="tab" href="#ogpl-notloaded-tab">Load New LR</a></li>
        <li><a data-toggle="tab" href="#ogpl-loaded-tab">Loaded LR</a></li>
    </ul>
{/if}
<div class="tab-content">
    <div id="ogpl-notloaded-tab" class="tab-pane fade in active">

        <div class="row" id="edit-ogpl-search-container">
            <br>
            <div class="col-lg-12">
                <form onsubmit="return false;">
                    <div class="row">
                        <div class="form-group col-md-2">
                            <label for="ogpl-load-from">Booked Date From</label>
                            <div class="input-group">
                                <input type="text" name="fromDate" class="form-control sdate" id="ogpl-load-from" readonly="true" placeholder="Date From">
                                <label class="input-group-addon" for="ogpl-load-from"><i class="fa fa-calendar"></i></label>
                            </div>
                        </div>
                        <div class="form-group col-md-2">
                            <label for="ogpl-load-to">Booked Date To</label>
                            <div class="input-group">
                                <input type="text" name="toDate" class="form-control sdate" id="ogpl-load-to" readonly="true" placeholder="Date To">
                                <label class="input-group-addon" for="ogpl-load-to"><i class="fa fa-calendar"></i></label>
                            </div>
                        </div>
                        
                        <div class="form-group col-md-2">
                            <label for="ogpl-load-from_org">From Branch</label>
                            <div class="input-group col-md-11">
                                <select id="ogpl-from-org" name="from-org-code" class="form-control">
                                    <option value="">Select a branch</option>
                                    {foreach item=row from=$branches}
                                        {if $row->station->code == $login_station}
                                            <option value="{$row->code}">{$row->name}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-2">
                            <label for="ogpl-load-from_org">To Branch</label>
                            <div class="input-group col-md-11">
                                <select id="ogpl-to-org" name="to-org-code" class="form-control">
                                    <option value="">Select a branch</option>
                                    {foreach item=row from=$branches}
                                        {if $row->station->code == $login_station}
                                            <option value="{$row->code}">{$row->name}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                        </div>

                        <div class="form-group col-md-2">
                            <label for="">&nbsp;</label>
                            <div class="input-group">
                                <input type="hidden" name="export" id="export" value="">
                                <button type="button" class="btn btn-success" onclick="ogplLRSearchReport();">Get {lang('lr')} List</button>&nbsp;
                                <button type="button" class="btn btn-default btn-clear" onclick="clearogplLRSearch();">Clear</button>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="align-center alert alert-danger pull-left" style="display:none" id="ogpl-load-action_state"></div>
            </div>
        </div>
        <div id="booked-ogpl-search-list"></div>
    </div>
    <div id="ogpl-loaded-tab" class="tab-pane fade"></div>
</div>

<div id="start-trip-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideStartTripDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="start-trip-panel" class="clearfix" style="padding: 10px 5px;">
        <form onsubmit="return false;">
            <div class="row">
                <div class="col-md-6 text-center">
                    <img src="assets/img/start-trip.png" width="80%">
                </div>
                <div class="col-md-6 text-right">
                    <h4 class="bold">Departure Time</h4>
                    <h5 id="trip-start-date"></h5>
                    <h4 id="trip-start-time"></h4>
                    <div class="clearfix"></div>
                    <h5 class="bold">Last odometer Reading</h5>
                    <h4><span id="last-odometer"></span> Km</h4>
                </div>
                <div class="col-md-12">
                    <label class="req h5">Enter odometer reading to Start Trip</label>
                    <div class="row">
                        <div class="col-md-4">
                            <input type="number" id="start-trip-odo" class="form-control no-spin" placeholder="Odometer">
                        </div>
                        <div class="col-md-4 p_l_n">
                            <div class="input-group col-md-12">
                                <select id="start-trip-supervisor" class="form-control">
                                    <option value="" selected>Select Supervisor</option>
                                    {foreach item=row from=$branchContact}
                                        {if $row->category->code == 'SPVSR'}
                                            <option value="{$row->code}">{$row->name}</option>                                    
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning col-md-3" id="start-trip-btn" onclick="startOGPLTrip();">Start Trip</button>
                    </div>
                </div>
                <div class="col-md-12"><br>
                    <div id="start-trip-action-state"></div>
                </div>
            </div>
        </form>
    </div>
</div>

<script>

    $('#start-trip-supervisor').select2();
    $('#ogpl-load-from').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#ogpl-load-to').datepicker('setStartDate', e.date);
        $('#ogpl-load-to').datepicker('setEndDate', end);
    });
    $('#ogpl-load-to').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'dd-mm-yyyy',
        maxDate: '+365D',
        autoclose: true
    }).datepicker("setDate", new Date()).on('changeDate', function (e) {
        $('#ogpl-load-from').datepicker('setEndDate', e.date);
    });

    $('#ogpl-load-from').datepicker("setDate", '-1m');
    ogplLRSearchReport();

    $('a[href="#ogpl-loaded-tab"]').one('show.bs.tab', function (e) {
        getLoadedOGPL();
    });

    $('select.load-branch').each(function () {
        if ($(this).find('option').length <= 2) {
            $(this).find('option[value=""]').remove();
        }
    });

    function selectAllBooking(cb) {
        var $cb = $(cb);

        $('.ogpl-new-items')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked'))
                .trigger('change');
    }

    function loadOGPL() {
        var ogplRoutes = {};
        //var loadToHub = $('#ogpl-load-hub').is(':checked');
        
        $('.inp_error').removeClass('inp_error');
        
        if($('#load-ogpl-list .ogpl-new-items:checked').length === 0) {
            $('#load-ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#load-ogpl-action-state').html('Please select atleast one LR');
            $('#load-ogpl-action-state').show();
            return false;
        }

        $('#load-ogpl-list .ogpl-new-items:checked').each(function (i, cb) {
            var $cb = $(cb);
            if ($cb.data('to')) {

                var transitorg = OGPLFormData.toOrganization.code;
                if (transitorg == '') {
                    $('#load-branch-sel').addClass('inp_error');
                    $('#load-ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#load-ogpl-action-state').html('Please enter/select the values in the field that are marked in red');
                    $('#load-ogpl-action-state').show();
                    ogplRoutes = {};
                    return false;
                }
                
                {*if(!loadToHub) {
                    $('#load-ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#load-ogpl-action-state').html($cb.val() + ' not valid for the selected Branch. Kinldy check from and to stations');
                    $('#load-ogpl-action-state').show();
                    ogplRoutes = {};
                    return false;
                }*}

                var route = $cb.data('from') + '-' + $cb.data('to') + '-' + transitorg;
                if (!ogplRoutes[route]) {
                    ogplRoutes[route] = {};
                    ogplRoutes[route].cargoList = [];
                    ogplRoutes[route].from = $cb.data('from');
                    ogplRoutes[route].to = $cb.data('to');
                    ogplRoutes[route].transitOrganization = transitorg;
                }
                ogplRoutes[route].cargoList.push($cb.val());
            } else {
                $('#load-ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#load-ogpl-action-state').html($cb.val() + ' not valid for the selected Branch. Kinldy check from and to stations');
                $('#load-ogpl-action-state').show();
                ogplRoutes = {};
                return false;
            }
        });

        if ($.isEmptyObject(ogplRoutes)) {
            return false;
        }

        $('#load-ogpl-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#load-ogpl-action-state').html(loading_popup).show();

        var data = OGPLFormData;
        data.loadList = _.values(ogplRoutes);

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/load-local-transit-list',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    var errors = [];
                    $.each(response.cargoResponseState || [], function (i, state) {
                        if (state.activeFlag != 1) {
                            errors.push(state.code + ' - ' + state.name);
                        }
                    });

                    OGPLFormData.code = response.OGPLCode;

                    if (errors.length) {
                        $('#load-ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                        $('#load-ogpl-action-state').html(errors.join('<br/>'));
                    } else {
                        $('#load-ogpl-action-state').removeClass('alert-danger').addClass('alert-success');
                        $('#load-ogpl-action-state').html('Your request processed successfully');
                        
                        window.setTimeout(function () {
                            //location.hash = '#cargo/ogpl-chart-details?transitCode=' + response.OGPLCode + '&date=' + response.OGPLDate;
                            ogplLRSearchReport();
                        }, 3000);
                    }
                } else {
                    $('#load-ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                    $('#load-ogpl-action-state').html(response.errorDesc);
                }
            }
        });
    }

    function getLoadedOGPL() {
        var data = {};
        data.transitCode = '{$smarty.request.code}';

        $('#ogpl-loaded-tab').html(loading_popup);
        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/loaded-local-transit-list',
            data: data,
            success: function (response) {
                $('#ogpl-loaded-tab').html(response);
            }
        });
    }

    function ogplLRSearchReport() {
        var data = {}, err = 0;
        data.code = OGPLFormData.code;
        data.tripDate = OGPLFormData.tripDate;
        data.fromDate = $('#ogpl-load-from').val();
        data.toDate = $('#ogpl-load-to').val();
        data.toBranch = OGPLFormData.toOrganization.code;
        // data.viaStationCodes = [].concat(OGPLFormData.toOrganization, OGPLFormData.viaOrganizations).map(i => i.code).join(',');

        data.fromOrg = $('#ogpl-from-org').val();
        data.toOrg = $('#ogpl-to-org').val();
        
        $('.inp_error').removeClass('inp_error');
        if (data.fromDate == '') {
            $('#ogpl-load-from').addClass('inp_error');
            err++;
        }
        if (data.toDate == '') {
            $('#ogpl-load-to').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#ogpl-load-action_state').removeClass('alert-success').addClass('alert-danger');
            $('#ogpl-load-action_state').html('Please enter/select the values in the field that are marked in red');
            $('#ogpl-load-action_state').show();
            return false;
        }
        $('#ogpl-load-action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#ogpl-load-action_state').hide();

        $('#booked-ogpl-search-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/booked-local-transit-search-list',
            data: data,
            success: function (response) {
                $('#booked-ogpl-search-list').html(response);
            }
        });
    }

    function clearogplLRSearch() {
        $('#ogpl-load-from').val('');
        $('#ogpl-load-to').val('');
        $('#ogpl-load-org').val('NA');
        $('#booked-ogpl-search-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#ogpl-load-action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#ogpl-load-action_state').html('');
        $('#ogpl-load-action_state').hide();
    }

    function showStartTripDialog() {
        $('#start-trip-dialog').removeClass('hide');
        $('#start-trip-dialog').dialog({
            autoOpen: true,
            width: 550,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
        $('#start-trip-dialog .inp_error').removeClass('inp_error');
        $('#start-trip-action-state').removeClass('alert alert-danger alert-success').html('');
        $('#start-trip-odo').val('');

        $('#trip-start-date').html(moment().format('DD MMM YYYY'));
        $('#trip-start-time').html(moment().format('hh : mm A'));

        var vehicle = _.find(OGPLVehicles, o => o.code == OGPLFormData.busVehicle.code) || {};
        $('#last-odometer').html(vehicle.lastOdometer);
    }

    function hideStartTripDialog() {
        $('#start-trip-dialog').dialog('destroy');
        $('#start-trip-dialog').hide();
    }

    function startOGPLTrip() {
        var data = {}, err = 0;
        data.action = 'DEPARTURE';
        data.transitCode = OGPLFormData.code;
        data.transitCargo = {};
        data.transitCargo.code = OGPLFormData.code;
        data.fromOrganization = {};
        data.fromOrganization.code = '{$login_branch}';
        data.startOdometer = Number($('#start-trip-odo').val());
        data.departureAt = moment().format('YYYY-MM-DD HH:mm:ss');
        data.fromOrganizationContact = {};
        data.fromOrganizationContact.code = $('#start-trip-supervisor').val();

        $('.inp_error').removeClass('inp_error');
        if (isNaN(data.startOdometer) || data.startOdometer < 0) {
            $('#start-trip-odo').addClass('inp_error');
            err++;
        }
        var vehicle = _.find(OGPLVehicles, o => o.code == OGPLFormData.busVehicle.code) || {};
        if (vehicle && vehicle.lastOdometer > 0 && data.startOdometer < vehicle.lastOdometer) {
            $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#start-trip-action-state').html('Entered odometer value should be greater than last odometer value');
            return;
        }
        if(err) {
            $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#start-trip-action-state').html('Please enter/select the values in the field that are marked in red');
            return;
        }
        $('#start-trip-panel-btn').hide();
        $('#start-trip-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-start-odometer",
            data: data,
            success: function (response) {
                if (response.status == 1) {                
                    $('#start-trip-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function () {
                        hideStartTripDialog();
                        ogplLRSearchReport();
                    }, 3000);
                } else {
                    $('#start-trip-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#start-trip-panel-btn').show();
                }
            }
        })
    }
</script>