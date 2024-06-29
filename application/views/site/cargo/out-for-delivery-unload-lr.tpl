<div class="brand_top">
    <h3>Unload</h3>
    <span class="align-right">
        {if $smarty.request.redirect == 'unload'}
            <a href="#cargo/out-for-delivery-unload?fill=1" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>
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
                    <div class="row" id="add-ogpl-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <h5><b>Door Delivery</b></h5>
                                    <table id="loaded-lr-table" class="table table-bordered " style="width:99%" >
                                        <thead>
                                            <tr class="success">
                                                <td align="center">
                                                    <input type="checkbox" onchange="selectAllLoaded(this);"/>
                                                </td>
                                                <td align="center">{lang('lr')} No</td>
                                                <td align="center">Booked Date</td>
                                                <td align="center">Booked by</td>
                                                <td align="center">{lang('booking_from_term')}</td>
                                                <td align="center">{lang('booking_to_label')}</td>
                                                <td align="center">{lang('booking_sender_term')}</td>
                                                <td align="center">{lang('booking_receiver_term')}</td>
                                                <td align="center">Payment Status</td>
                                                <td align="center">Cargo Status</td>
                                                <td align="center">Items</td>
                                                <td align="center">Qty</td>
                                                <td align="center">Payable</td>
                                            </tr>
                                        </thead>
                                        <tbody class="body_table" id="load-ogpl-list">

                                            {foreach item=row1 from=$result key=t1 }
                                                <tr>
                                                    <td align="center" colspan="15" class="bold">{$t1}</td>
                                                </tr>
                                                {foreach item=row from=$row1 key=t }
                                                    {assign var="allowunloadstatus" value=0}
                                                    {if $cargo_setting->transitOdometerModelCode=="RTEBSD" && $row->start_odometer == 0}
                                                        {assign var="allowunloadstatus" value=1}
                                                    {/if}
                                                    <tr>
                                                        <td align="center">
                                                            <input type="checkbox" 
                                                                {if $allowunloadstatus == 1}
                                                                    disabled title="Trip not yet started"
                                                                {else}
                                                                    class="ogpl-loaded-lr"
                                                                {/if}
                                                                data-from="{$row->from_station_code}" data-to="{$row->to_station_code}" value="{$row->cargo_code}" />
                                                        </td>
                                                        <td align="center"><a href='javascript:;' {if $allowunloadstatus == 1}class="badge badge-danger text-white"{/if} title="{if $allowunloadstatus == 1}Trip not yet started{else}more details{/if}" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                                                        <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                                                        <td align="left">{$row->user_first_name}</td>
                                                        <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                                                        <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                                                        <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile}</td>
                                                        <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile}</td>
                                                        <td align="center">
                                                            {$row->payment_status_code|_cargo_payment_status_badge}
                                                        </td>
                                                        <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                                                        <td align="left">{$row->cargo_item_name}</td>
                                                        <td align="center">{$row->total_item_count}</td>
                                                        <td align="right">{($row->total_booking_amount+$row->total_unload_handling_amount+$row->total_handing_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)|number_format:2}</td>
                                                    </tr>
                                                {/foreach}
                                            {/foreach}
                                        </tbody>
                                    </table>

                                    <h5><b>Door Pickup</b></h5>
                                    <table id="loaded-prebook-table" class="table table-bordered " style="width:99%" >
                                        <thead>
                                            <tr class="success">
                                                {* <td align="center">
                                                    <input type="checkbox" onchange="selectAllLoaded(this);"/>
                                                </td> *}
                                                <td align="center">{lang('lr')} No</td>
                                                <td align="center">Booked Date</td>
                                                {* <td align="center">Booked by</td> *}
                                                <td align="center">{lang('booking_from_term')}</td>
                                                <td align="center">{lang('booking_to_label')}</td>
                                                <td align="center">{lang('booking_sender_term')}</td>
                                                <td align="center">{lang('booking_receiver_term')}</td>
                                                <td align="center">Payment Status</td>
                                                <td align="center">Cargo Status</td>
                                                <td align="center">Items</td>
                                                <td align="center">Qty</td>
                                                <td align="center">Payable</td>
                                            </tr>
                                        </thead>
                                        <tbody class="body_table" id="load-ogpl-list">

                                            {foreach item=row1 from=$prebook key=t1 }
                                                <tr>
                                                    <td align="center" colspan="15" class="bold">{$t1}</td>
                                                </tr>
                                                {foreach item=row from=$row1 key=t }
                                                    <tr>
                                                        {* <td align="center">
                                                            <input type="checkbox" class="ogpl-loaded-lr" data-from="{$row->from_station_code}" data-to="{$row->to_station_code}" value="{$row->cargo_code}" />
                                                        </td> *}
                                                        <td align="center"><a href='javascript:;' title="more details" onclick='getPreBookingDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                                                        <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                                                        {* <td align="left">{$row->user_first_name}</td> *}
                                                        <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                                                        <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                                                        <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile}</td>
                                                        <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile}</td>
                                                        <td align="center">
                                                            {$row->payment_status_code|_cargo_payment_status_badge}
                                                        </td>
                                                        <td align="left">{$cargo_prebook_status[$row->cargo_status_code]}</td>
                                                        <td align="left">{$row->cargo_item_name}</td>
                                                        <td align="center">{$row->total_item_count}</td>
                                                        <td align="right">{($row->total_booking_amount+$row->total_unload_handling_amount+$row->total_handing_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)|number_format:2}</td>
                                                    </tr>
                                                {/foreach}
                                            {/foreach}
                                        </tbody>
                                    </table>

                                    <div class="clearfix_both"></div><br/>
                                    <div class="row">
                                        <div class="col-md-6"></div>
                                        <div class="col-md-6">
                                            <div class="col-md-2 w-auto pull-right" id="unable-deliver-panel">
                                                <label>&nbsp;</label>
                                                <button class="btn btn-danger pull-right" type="button" onclick="showUnloadPanel();">Unable to Deliver</button>
                                            </div>
                                            <div class="hide" id="unload-panel">
                                                <div class="col-md-2 w-auto pull-right">
                                                    <label>&nbsp;</label>
                                                    <button class="btn btn-success pull-right" type="button" onclick="unloadOGPLLr();">Unload</button>
                                                </div>
                                                <div class="form-group col-md-4 p_r_n pull-right">
                                                    <label for="ogpl-unload-transit-branch">Unload to nearest Branch</label>
                                                    <div class="input-group col-md-12">
                                                        <select id="ogpl-unload-transit-branch" name="transitOrganizationCode" class="form-control">
                                                            <option value="" selected="">Select Branch</option>
                                                            {foreach item=row from=$branches}
                                                                {if $row->station->code == $login_station}
                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                {/if}
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            {if isset($odoDetails) && $odoDetails->endOdometer == 0}
                                                <div class="col-md-2 p_r_n w-auto pull-right">
                                                    <label for="ogpl-unload-transit-branch">&nbsp;</label>
                                                    <button class="btn btn-warning" id="start-odometer-btn" type="button" onclick="showStartTripDialog();">End Trip</button>
                                                </div>
                                            {/if}
                                        </div>
                                        <div class="col-md-6">
                                            <div class="alert pull-left" id="missing-ogpl-action-state" style="display: none"></div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="alert pull-right" id="unload-ogpl-action-state" style="display: none"></div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div><!--row end-->
                </div><!--content end-->
            </div>
        </div>
    </div>
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
                    <h4 class="bold">Arrival Time</h4>
                    <h5 id="trip-start-date"></h5>
                    <h4 id="trip-start-time"></h4>
                    <div class="clearfix"></div>
                    <h5 class="bold">Last odometer Reading</h5>
                    <h4><span id="last-odometer"></span> Km</h4>
                </div>
                <div class="col-md-12">
                    <label class="req h5">Enter odometer reading to End Trip</label>
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
                        <button type="submit" class="btn btn-warning col-md-3" id="start-trip-btn" onclick="startOGPLTrip();">End Trip</button>
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
    var vehicle = {$vehicle|json_encode};
    $('#start-trip-supervisor').select2();
    $('#ogpl-unload-transit-branch').select2();

    function selectAllLoaded(cb) {
        var $cb = $(cb);

        $('.ogpl-loaded-lr')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked'))
                .trigger('change');
    }

    function unloadOGPLLr() {
        var data = {};
        data.transitCode = '{$smarty.request.transitCode}';
        data.transitOrganization = {};
        data.transitOrganization.code = $('#ogpl-unload-transit-branch').val() || '';
        data.codes = $('.ogpl-loaded-lr:checked').map(function() {
            var data = {};
            data.code = $(this).val();
            data.cargoStatus = {};
            data.cargoStatus.code = 'CUL';
            data.remarks = [];
            
            // var remarks = {};
            // remarks.code = '';
            // remarks.name = $(this).closest('tr').find('.unload-remarks').val().trim();
            // remarks.cargoStatusCode = 'CUL';
            // data.remarks.push(remarks);

            return data;
        }).get();

        if (!data.codes || !data.codes.length) {
            alert('Please select atleast one LR');
            return;
        }
        
        $('#unload-ogpl-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#unload-ogpl-action-state').html(loading_popup).show();
        $('#start-odometer-btn').addClass('hide');

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/out-for-delivery-update-unload',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    var errors = [];
                    $.each(response.data.cargoList || [], function (i, state) {
                        if (state.activeFlag != 1) {
                            errors.push(state.code + ' - ' + state.name);
                        }
                    });

                    if (errors.length) {
                        $('#unload-ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                        $('#unload-ogpl-action-state').html(errors.join('<br/>'));
                    } else {
                        $('#unload-ogpl-action-state').removeClass('alert-danger').addClass('alert-success');
                        $('#unload-ogpl-action-state').html('Your request processed successfully');
                        window.setTimeout(function () {
                            checkURL();
                        }, 3000);
                    }
                } else {
                    $('#unload-ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                    $('#unload-ogpl-action-state').html(response.errorDesc);
                }
            }
        });
    }

    function showUnloadPanel() {
        if (!$('.ogpl-loaded-lr:checked').length) {
            alert('Please select atleast one LR')
            return;
        }
        if (!confirm('Do you want to unload at nearest branch?')) {
            return;
        }
        $('#unable-deliver-panel').addClass('hide');
        $('#unload-panel').removeClass('hide');
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

        if (vehicle) {
            $('#last-odometer').html(vehicle.lastOdometer);
        }
    }

    function hideStartTripDialog() {
        $('#start-trip-dialog').dialog('destroy');
        $('#start-trip-dialog').hide();
    }

    function startOGPLTrip() {
        var data = {}, err = 0;
        data.action = 'ARRIVAL';
        data.transitCode = '{$smarty.request.transitCode}';
        data.transitCargo = {};
        data.transitCargo.code = '{$smarty.request.transitCode}';
        data.toOrganization = {};
        data.toOrganization.code = '{$userorgcode}';
        data.endOdometer = Number($('#start-trip-odo').val());
        data.arrivalAt = moment().format('YYYY-MM-DD HH:mm:ss');
        data.toOrganizationContact = {};
        data.toOrganizationContact.code = $('#start-trip-supervisor').val();

        $('.inp_error').removeClass('inp_error');
        if (isNaN(data.endOdometer) || data.endOdometer < 0) {
            $('#start-trip-odo').addClass('inp_error');
            err++;
        }
        if (vehicle && vehicle.lastOdometer > 0 && data.endOdometer < vehicle.lastOdometer) {
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
            url: base_url + "cargo/update-end-odometer",
            data: data,
            success: function (response) {
                if (response.status == 1) {                
                    $('#start-trip-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function () {
                        hideStartTripDialog();
                        checkURL();
                    }, 3000);
                } else {
                    $('#start-trip-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#start-trip-panel-btn').show();
                }
            }
        })
    }
</script>