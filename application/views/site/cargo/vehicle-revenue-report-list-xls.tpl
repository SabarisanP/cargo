<table border='1'>
    <tr>
        <td colspan="6" align="center"><b>Vehicle Revenue Report</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$usr_login_name} </td>
    </tr>
</table>

<table border='1'>
    <thead>
        <tr style="background-color: #64b92a; color: #fff;">
            <th align="left"><b>Date</b></th>
            <th align="left"><b>Vehicle No</b></th>
            <th align="left"><b>Source</b></th>
            <th align="left"><b>Destination</b></th>
            <th align="left">Driver</th>
            <th align="right"><b>{lang('lr')} Count</b></th>
            <th align="right"><b>GST</b></th>
            <th align="right"><b>Freight</b></th>
            <th align="right"><b>Total Freight Value</b></th>
            <th align="right">Paid Booking</th>
            <th align="right">ToPay Booking</th>
            <th align="right"><b>Booking Commission</b></th>
            <th align="right"><b>Delivery Commission</b></th>
            <th align="right"><b>Pickup Charges</b></th>
            <th align="right"><b>Delivery Charges</b></th>
            <th align="right"><b>Loading Charges</b></th>
            <th align="right"><b>Unloading Charges</b></th>
            <th align="right"><b>Net Amount</b></th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_cargo_count value=0}
        {assign var=t_total_service_tax value=0}
        {assign var=t_total_amount value=0}
        {assign var=paid_amt value=0}
        {assign var=topay_amt value=0}
        {assign var=t_total_pickup_handling_amount value=0}
        {assign var=t_total_delivery_handling_amount value=0}
        {assign var=t_total_handling_amount value=0}
        {assign var=t_total_unload_handling_amount value=0}
        {assign var=t_total_amount_paid value=0}
        {assign var=t_book_comm value=0}
        {assign var=t_delvry_comm value=0}
        {assign var=t_freight_value value=0}

        {foreach item=row from=$result}
            <tr>
                <td align="left">{$row->trip_date|date_format:$ns_date_format}</td>
                <td align="left">{$row->vehicle_registration_number}</td>
                <td align="left">{$row->from_station_name}</td>
                <td align="left">{$row->to_station_name}</td>
                <td align="left">{$row->driver_name} - {$row->driver_mobile}</td>
                <td align="right">{$row->cargo_count}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_service_tax}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{($row->total_amount + $row->total_service_tax)}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->delivery_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_pickup_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_delivery_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_unload_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{($row->total_service_tax + $row->total_amount + $row->total_pickup_handling_amount + $row->total_delivery_handling_amount + $row->total_handling_amount + $row->total_unload_handling_amount)}</td>
            </tr>
            {assign var=t_freight_value value=$t_freight_value + $row->total_amount + $row->total_service_tax}
            {assign var=t_book_comm value=$t_book_comm + $row->commission_amount}
            {assign var=t_delvry_comm value=$t_delvry_comm + $row->delivery_commission_amount}
            {assign var=t_cargo_count value=$t_cargo_count + $row->cargo_count}
            {assign var=t_total_service_tax value=$t_total_service_tax + $row->total_service_tax}
            {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
            {assign var=paid_amt value=$paid_amt + $row->paid_amount}
            {assign var=topay_amt value=$topay_amt + $row->topay_amount}
            {assign var=t_total_pickup_handling_amount value=$t_total_pickup_handling_amount + $row->total_pickup_handling_amount}
            {assign var=t_total_delivery_handling_amount value=$t_total_delivery_handling_amount + $row->total_delivery_handling_amount}
            {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
            {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
            {assign var=t_total_amount_paid value=$t_total_amount_paid + ($row->total_service_tax + $row->total_amount + $row->total_pickup_handling_amount + $row->total_delivery_handling_amount + $row->total_handling_amount + $row->total_unload_handling_amount)}
        {/foreach}

        {if $result|count}
            <tfoot>
                <tr style="background-color: #bbbbbb; color: #fff;">
                    <td colspan="5" align="right"><b>Total</b></td>
                    <td align='right'>{$t_cargo_count}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$t_total_service_tax}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$t_total_amount}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$t_freight_value}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$paid_amt}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$topay_amt}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$t_book_comm}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$t_delvry_comm}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$t_total_pickup_handling_amount}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$t_total_delivery_handling_amount}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$t_total_handling_amount}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$t_total_unload_handling_amount}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$t_total_amount_paid}</td>
                </tr>
            </tfoot>
        {else}
            <tfoot>
                <tr>
                    <td colspan="18" align="center">No Records Found</td>
                </tr>
            </tfoot>
        {/if}
    </tbody>
</table>
