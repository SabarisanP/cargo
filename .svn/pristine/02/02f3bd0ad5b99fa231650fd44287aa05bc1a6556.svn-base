<h5><b>Transactions</b></h5>
<table id="loaded-lr-table" class="table table-bordered " style="width:99%" >
    <thead>
        <tr class="success">
            <td align="center">
                <input type="checkbox" onchange="selectAllBooking(this);"/>
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
        {assign var=loaded_count value=0}
        {foreach item=row1 from=$result key=t1 }
            <tr>
                <td align="center" colspan="15" class="bold">{$t1}</td>
            </tr>
            {foreach item=row from=$row1 key=t }
                <tr>
                    <td align="center">
                        <input type="checkbox" class="ogpl-loaded-items" 
                            data-from="{$row->transit_from_station_code|default:$row->from_station_code}" 
                            data-to="{$row->transit_to_station_code|default:$row->to_station_code}" 
                            data-fromorg="{$row->transit_from_organization_code|default:$row->from_organization_code}" 
                            data-toorg="{$row->transit_to_organization_code|default:$row->to_organization_code}"
                            data-transittype="{$row->transit_details_type|default:$row->transit_details_type}"
                            value="{$row->cargo_code}" />
                    </td>
                    <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
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
                {assign var=loaded_count value=$loaded_count + 1}
            {/foreach}
        {/foreach}
    </tbody>
</table>

<div class="clearfix_both"></div><br/>
<div class="row">
    <div class="col-md-12 text-right">
        <div class="col-md-8 pull-right">
            <div class="alert pull-right" id="unload-ogpl-action-state" style="display: none"></div>
        </div>
        <div class="col-md-8 pull-right">
            {if isset($odoDetails) && $odoDetails->startOdometer == 0}
                <button class="btn btn-warning" id="start-odometer-btn" type="button" onclick="showStartTripDialog();">Start Trip</button>
            {/if}
            <button class="btn btn-danger" type="button" onclick="unloadOGPL();">Remove</button>
        </div>
    </div>
</div>


<script>
    function selectAllBooking(cb) {
        var $cb = $(cb);

        $('.ogpl-loaded-items')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked'))
                .trigger('change');
    }

    function unloadOGPL() {
        var ogplRoutes = {};
        $('#load-ogpl-list .ogpl-loaded-items:checked').each(function (i, cb) {
            var $cb = $(cb);
            var route = $cb.data('from') + '-' + $cb.data('to');
            if (!ogplRoutes[route]) {
                ogplRoutes[route] = {};
                ogplRoutes[route].cargoList = [];
                ogplRoutes[route].from = $cb.data('from');
                ogplRoutes[route].to = $cb.data('to');
                ogplRoutes[route].fromOrg = $cb.data('fromorg');
                ogplRoutes[route].toOrg = $cb.data('toorg');
                ogplRoutes[route].transitType = $cb.data('transittype');
            }
            ogplRoutes[route].cargoList.push($cb.val());
        });

        if ($.isEmptyObject(ogplRoutes)) {
            return false;
        }
        $('#unload-ogpl-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#unload-ogpl-action-state').html(loading_popup).show();

        var data = {};
        data.unloadList = _.values(ogplRoutes);
        data.transitCargo = '{$smarty.request.transitCode}';
        data.ogplLRCount = {$loaded_count - 1};

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/unload-ogpl-list',
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
                            getLoadedOGPL();
                        }, 3000);
                    }
                } else {
                    $('#unload-ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                    $('#unload-ogpl-action-state').html(response.errorDesc);
                }
            }
        });
    }
</script>