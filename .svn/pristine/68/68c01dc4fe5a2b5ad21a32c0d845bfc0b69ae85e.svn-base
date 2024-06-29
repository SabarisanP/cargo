<table id="transitv3-loaded-lr-table" class="table table-bordered " style="width:99%" >
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
    <tbody class="body_table" id="load-transitv3-list">
        {assign var=loaded_count value=0}
        {foreach item=row1 from=$result key=t1 }
            <tr>
                <td align="center" colspan="15" class="bold">{$t1}</td>
            </tr>
            {foreach item=row from=$row1 key=t }
                <tr>
                    <td align="center">
                        <input type="checkbox" class="transitv3-loaded-items" 
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

<script>
    var loadedLrCount = {$loaded_count|json_encode};
    function selectAllBooking(cb) {
        var $cb = $(cb);

        $('.transitv3-loaded-items')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked'))
                .trigger('change');
    }
</script>