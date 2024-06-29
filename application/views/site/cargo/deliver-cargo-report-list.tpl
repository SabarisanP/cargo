<div class="table-responsive">
    <table class="table table-bordered" width="98%" id="deliver-cargo-table">
        <thead>
            <tr class="success">
                <td align="center">Date of Booking</td>
                <td align="center">Date of Unloading</td>
                <td align="center">{lang('lr')} Number</td>
                <td align="center">Consignor</td>
                <td align="center">Consignee</td>
                <td align="center">No. of Articles</td>
                <td align="center">Type of Packaging</td>
                <td align="center">Mode Of Payment</td>
                <td align="center">Type of Delivery</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=t_item_count value=0}
            {foreach item=row from=$result}
                <tr>
                    <td align="left">{$row->booked_at|date_format:'d, M g:i A'}</td>
                    <td align="left" data-order="{$row->unloaded_at|strtotime}">{if isNotNull($row->unloaded_at)}{$row->unloaded_at|date_format:'d, M g:i A'}{else}-{/if}</td>
                    <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                    <td align="left" width="12%">
                        {$row->from_customer_name}<br>
                        <span class="text-muted">{$row->from_customer_mobile}</span>
                    </td>
                    <td align="left" width="12%">
                        {$row->to_customer_name}<br>
                        <span class="text-muted">{$row->to_customer_mobile}</span>
                    </td>
                    <td align="right">{$row->item_count}</td>
                    <td align="left">{$row->cargo_item_name}</td>
                    <td align="left">
                        {$row->payment_type_code|_cargo_payment_status_badge}
                    </td>
                    <td align="left">{$delivery_type_codes[$row->delivery_type_code]}</td>
                </tr>
                {assign var=t_item_count value=$t_item_count + $row->item_count}
            {/foreach}
        </tbody>
    </table>
</div>

<script>
    $('#deliver-cargo-table').DataTable({
        paging : false,
        order: [1, 'asc']
    });
</script>
