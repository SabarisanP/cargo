<table class="" width="99%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Vehicle Revenue Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br/>
<div class="clearfix"></div>
<table class="table table-bordered" width="98%">
    <thead>
        <tr class="success">
            <th align="left">Date</th>
            <th align="left">Vehicle No</th>
            <th align="left">Source</th>
            <th align="left">Destination</th>
            <th align="left">Driver</th>
            <th align="right">{lang('lr')} Count</th>
            <th align="right">GST</th>
            <th align="right">Freight</th>
            <th align="right">Total Freight Value</th>
            <th align="right">Paid Booking</th>
            <th align="right">ToPay Booking</th>
            <th align="right">Booking Commission</th>
            <th align="right">Delivery Commission</th>
            <th align="right">Pickup Charges</th>
            <th align="right">Delivery Charges</th>
            <th align="right">Loading Charges</th>
            <th align="right">Unloading Charges</th>
            <th align="right">Net Amount</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=t_cargo_count value=0}
        {assign var=t_total_service_tax value=0}
        {assign var=t_total_amount value=0}
        {assign var=t_freight_value value=0}
        {assign var=paid_amt value=0}
        {assign var=topay_amt value=0}
        {assign var=t_total_pickup_handling_amount value=0}
        {assign var=t_total_delivery_handling_amount value=0}
        {assign var=t_total_handling_amount value=0}
        {assign var=t_total_unload_handling_amount value=0}
        {assign var=t_total_amount_paid value=0}
        {assign var=t_book_comm value=0}
        {assign var=t_delvry_comm value=0}

        {foreach item=row from=$result}
            <tr>
                <td align="left" nowrap>{$row->trip_date|date_format:$ns_date_format}</td>
                <td align="left">{$row->vehicle_registration_number}</td>
                <td align="left">{$row->from_station_name}</td>
                <td align="left">{$row->to_station_name}</td>
                <td align="left">{$row->driver_name} - {$row->driver_mobile}</td>
                <td align="right">{$row->cargo_count}</td>
                <td align="right">{$row->total_service_tax|inr_format}</td>
                <td align="right">{$row->total_amount|inr_format}</td>
                <td align="right">{($row->total_amount + $row->total_service_tax)|inr_format}</td>
                <td align="right">{$row->paid_amount|inr_format}</td>
                <td align="right">{$row->topay_amount|inr_format}</td>
                <td align="right">{$row->commission_amount|inr_format}</td>
                <td align="right">{$row->delivery_commission_amount|inr_format}</td>
                <td align="right">{$row->total_pickup_handling_amount|inr_format}</td>
                <td align="right">{$row->total_delivery_handling_amount|inr_format}</td>
                <td align="right">{$row->total_handling_amount|inr_format}</td>
                <td align="right">{$row->total_unload_handling_amount|inr_format}</td>
                <td align="right">{($row->total_service_tax + $row->total_amount + $row->total_pickup_handling_amount + $row->total_delivery_handling_amount + $row->total_handling_amount + $row->total_unload_handling_amount)|inr_format}</td>
            </tr>
            {assign var=t_freight_value value=$t_freight_value + $row->total_amount + $row->total_service_tax}
            {assign var=paid_amt value=$paid_amt + $row->paid_amount}
            {assign var=topay_amt value=$topay_amt + $row->topay_amount}
            {assign var=t_book_comm value=$t_book_comm + $row->commission_amount}
            {assign var=t_delvry_comm value=$t_delvry_comm + $row->delivery_commission_amount}
            {assign var=t_cargo_count value=$t_cargo_count + $row->cargo_count}
            {assign var=t_total_service_tax value=$t_total_service_tax + $row->total_service_tax}
            {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
            {assign var=t_total_pickup_handling_amount value=$t_total_pickup_handling_amount + $row->total_pickup_handling_amount}
            {assign var=t_total_delivery_handling_amount value=$t_total_delivery_handling_amount + $row->total_delivery_handling_amount}
            {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
            {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
            {assign var=t_total_amount_paid value=$t_total_amount_paid + ($row->total_service_tax + $row->total_amount + $row->total_pickup_handling_amount + $row->total_delivery_handling_amount + $row->total_handling_amount + $row->total_unload_handling_amount)}
        {foreachelse}
            <tr>
                <td colspan="100%" align="center">No Records Found!</td>
            </tr>
        {/foreach}

        {if $result|count}
            <tr class="active bold">
                <td colspan="5" align="right">Total</td>
                <td align='right'>{$t_cargo_count}</td>
                <td align='right'>{$t_total_service_tax|inr_format}</td>
                <td align='right'>{$t_total_amount|inr_format}</td>
                <td align='right'>{$t_freight_value|inr_format}</td>
                <td align='right'>{$paid_amt|inr_format}</td>
                <td align='right'>{$topay_amt|inr_format}</td>
                <td align='right'>{$t_book_comm|inr_format}</td>
                <td align='right'>{$t_delvry_comm|inr_format}</td>
                <td align='right'>{$t_total_pickup_handling_amount|inr_format}</td>
                <td align='right'>{$t_total_delivery_handling_amount|inr_format}</td>
                <td align='right'>{$t_total_handling_amount|inr_format}</td>
                <td align='right'>{$t_total_unload_handling_amount|inr_format}</td>
                <td align='right'>{$t_total_amount_paid|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportVehicleTransit();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>