<table border='1'>
    <tr>
        <td colspan="10" align="center">Direct Online Sales Report</td>
    </tr>
    <tr>
        <td colspan="5">Date : {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format}</td>
        <td colspan="5" align="right">Report Date/Time : {date("d-m-Y h:i A")}</td>
    </tr>
</table>

<h5><b>Summary</b></h5>
<table border='1'>
    <thead>
        <tr  class="success" style="font-weight: bold; background-color:#64b92a; color: #fff;">
            <th rowspan="2" align="left">Device Medium</th>
            <th colspan="5" class="text-center">Booking</th>
            <th colspan="6" class="text-center">Cancel</th>
            <th rowspan="2" class="text-center">Net Payable</th>
        </tr>
        <tr  class="success" style="font-weight: bold; background-color:#64b92a; color: #fff;">
            <th align="left">Seats</th>
            <th align="right">Fare</th>
            <th align="right">GST</th>
            <th align="right">Discount</th>
            <th align="right">Gross</th>

            <th align="left">Seats</th>
            <th align="right">Fare</th>
            <th align="right">GST</th>
            <th align="right">Discount</th>
            <th align="right">Cncl Charges</th>
            <th align="right">Refund</th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_bo_seats value=0}
        {assign var=t_bo_fare value=0}
        {assign var=t_bo_gst value=0}
        {assign var=t_bo_discount value=0}
        {assign var=t_bo_payable value=0}

        {assign var=t_ca_seats value=0}
        {assign var=t_ca_fare value=0}
        {assign var=t_ca_gst value=0}
        {assign var=t_ca_discount value=0}
        {assign var=t_ca_ccharges value=0}
        {assign var=t_ca_refund value=0}

        {foreach item=row key=medium from=$summary}
            <tr>
                <td align="left">{$medium}</td>
                <td align="right">{$row['BO']['seats'] + 0}</td>
                <td align="right">{$row['BO']['fare']|inr_format}</td>
                <td align="right">{$row['BO']['gst']|inr_format}</td>
                <td align="right">{$row['BO']['discount']|inr_format}</td>
                <td align="right">{($row['BO']['fare'] + $row['BO']['gst'] - $row['BO']['discount'])|inr_format}</td>

                <td align="right">{$row['CA']['seats'] + 0}</td>
                <td align="right">{$row['CA']['fare']|inr_format}</td>
                <td align="right">{$row['CA']['gst']|inr_format}</td>
                <td align="right">{$row['CA']['discount']|inr_format}</td>
                <td align="right">{$row['CA']['ccharges']|inr_format}</td>
                <td align="right">{$row['CA']['refund']|inr_format}</td>
                <td align="right">{(($row['BO']['fare'] + $row['BO']['gst'] - $row['BO']['discount']) - $row['CA']['refund'])|inr_format}</td>
            </tr>

            {assign var=t_bo_seats value=$t_bo_seats + $row['BO']['seats']}
            {assign var=t_bo_fare value=$t_bo_fare + $row['BO']['fare']}
            {assign var=t_bo_gst value=$t_bo_gst + $row['BO']['gst']}
            {assign var=t_bo_discount value=$t_bo_discount + $row['BO']['discount']}
            {assign var=t_bo_payable value=$t_bo_payable + ($row['BO']['fare'] + $row['BO']['gst'] - $row['BO']['discount'])}

            {assign var=t_ca_seats value=$t_ca_seats + $row['CA']['seats']}
            {assign var=t_ca_fare value=$t_ca_fare + $row['CA']['fare']}
            {assign var=t_ca_gst value=$t_ca_gst + $row['CA']['gst']}
            {assign var=t_ca_discount value=$t_ca_discount + $row['CA']['discount']}
            {assign var=t_ca_ccharges value=$t_ca_ccharges + $row['CA']['ccharges']}
            {assign var=t_ca_refund value=$t_ca_refund + $row['CA']['refund']}
        {/foreach}
        {if $summary|count}
            <tr style="background-color:#bbbbbb; color: #fff; font-weight:bold">
                <td align="right">Total</td>
                <td align='right'>{$t_bo_seats}</td>
                <td align='right'>{$t_bo_fare|inr_format}</td>
                <td align='right'>{$t_bo_gst|inr_format}</td>
                <td align='right'>{$t_bo_discount|inr_format}</td>
                <td align='right'>{$t_bo_payable|inr_format}</td>

                <td align='right'>{$t_ca_seats}</td>
                <td align='right'>{$t_ca_fare|inr_format}</td>
                <td align='right'>{$t_ca_gst|inr_format}</td>
                <td align='right'>{$t_ca_ccharges|inr_format}</td>
                <td align='right'>{$t_ca_discount|inr_format}</td>
                <td align='right'>{$t_ca_refund|inr_format}</td>
                <td align='right'>{($t_bo_payable - $t_ca_refund)|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>

<h5><b>Booking</b></h5>
<table border='1' class="table table-bordered ">
    <thead>
        <tr  class="success" style="font-weight: bold; background-color:#64b92a; color: #fff;">
            <th align="left">PNR</th>
            <th align="left">Transaction Date</th>
            <th align="left">Travel Date</th>
            <th align="left">Route</th>
            <th align="left">Service No</th>
            <th align="left">Device Medium</th>
            <th align="left">Gateway Partner</th>
            <th align="left">Seats</th>
            <th align="right">Fare</th>
            <th align="right">GST</th>
            <th align="right">Discount</th>
            <th align="right">Net Payable</th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_seat_count value=0}
        {assign var=t_ticket_amount value=0}
        {assign var=t_ac_bus_tax value=0}
        {assign var=t_addons_amount value=0}
        {assign var=t_payable value=0}

        {foreach item=row from=$tickets['BO']}
            <tr>
                <td align="left">{$row->ticket_code}</td>
                <td align="left">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->travel_date|date_format:$ns_date_format}</td>
                <td align="left">{$row->from_station_name} - {$row->to_station_name}</td>
                <td align="left" class="text-danger">
                    {if $row->service_number}{$row->service_number}
                    {else}-{/if}
                </td>
                <td align="left">{$row->device_medium}</td>
                <td align="left">{$row->gateway_partner_name}</td>
                <td align="right">{$row->seat_count}</td>
                <td align="right">{$row->ticket_amount|inr_format}</td>
                <td align="right">{$row->ac_bus_tax|inr_format}</td>
                <td align="right">{$row->addons_amount|inr_format}</td>
                <td align="right">{($row->ticket_amount + $row->ac_bus_tax - $row->addons_amount)|inr_format}</td>
            </tr>

            {assign var=t_seat_count value=$t_seat_count + $row->seat_count}
            {assign var=t_ticket_amount value=$t_ticket_amount + $row->ticket_amount}
            {assign var=t_ac_bus_tax value=$t_ac_bus_tax + $row->ac_bus_tax}
            {assign var=t_addons_amount value=$t_addons_amount + $row->addons_amount}
            {assign var=t_payable value=$t_payable + ($row->ticket_amount + $row->ac_bus_tax - $row->addons_amount)}
        {/foreach}

        {if $tickets['BO']|count}
            <tr style="background-color:#bbbbbb; color: #fff; font-weight:bold">
                <td colspan="7" align="right">Total</td>
                <td align='right'>{$t_seat_count}</td>
                <td align='right'>{$t_ticket_amount|inr_format}</td>
                <td align='right'>{$t_ac_bus_tax|inr_format}</td>
                <td align='right'>{$t_addons_amount|inr_format}</td>
                <td align='right'>{$t_payable|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>


<h5><b>Cancellation</b></h5>
<table border='1' class="table table-bordered ">
    <thead>
        <tr  class="success" style="font-weight: bold; background-color:#64b92a; color: #fff;">
            <th align="left">PNR</th>
            <th align="left">Transaction Date</th>
            <th align="left">Travel Date</th>
            <th align="left">Route</th>
            <th align="left">Service No</th>
            <th align="left">Device Medium</th>
            <th align="left">Gateway Partner</th>
            <th align="left">Seats</th>
            <th align="right">Fare</th>
            <th align="right">GST</th>
            <th align="right">Discount</th>
            <th align="right">Cncl Charges</th>
            <th align="right">Refund</th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_seat_count value=0}
        {assign var=t_ticket_amount value=0}
        {assign var=t_ac_bus_tax value=0}
        {assign var=t_addons_amount value=0}
        {assign var=t_refund_amount value=0}

        {foreach item=row from=$tickets['CA']}
            <tr>
                <td align="left">{$row->ticket_code}</td>
                <td align="left">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->travel_date|date_format:$ns_date_format}</td>
                <td align="left">{$row->from_station_name} - {$row->to_station_name}</td>
                <td align="left" class="text-danger">
                    {if $row->service_number}{$row->service_number}
                    {else}-{/if}
                </td>
                <td align="left">{$row->device_medium}</td>
                <td align="left">{$row->gateway_partner_name}</td>
                <td align="right">{$row->seat_count}</td>
                <td align="right">{$row->ticket_amount|inr_format}</td>
                <td align="right">{$row->ac_bus_tax|inr_format}</td>
                <td align="right">{$row->addons_amount|inr_format}</td>
                <td align="right">{$row->cancellation_charges|inr_format}</td>
                <td align="right">{$row->refund_amount|inr_format}</td>
            </tr>

            {assign var=t_seat_count value=$t_seat_count + $row->seat_count}
            {assign var=t_ticket_amount value=$t_ticket_amount + $row->ticket_amount}
            {assign var=t_ac_bus_tax value=$t_ac_bus_tax + $row->ac_bus_tax}
            {assign var=t_cancellation_charges value=$t_cancellation_charges + $row->cancellation_charges}
            {assign var=t_addons_amount value=$t_addons_amount + $row->addons_amount}
            {assign var=t_refund_amount value=$t_refund_amount + $row->refund_amount}
        {/foreach}

        {if $tickets['CA']|count}
            <tr style="background-color:#bbbbbb; color: #fff; font-weight:bold">
                <td colspan="7" align="right">Total</td>
                <td align='right'>{$t_seat_count}</td>
                <td align='right'>{$t_ticket_amount|inr_format}</td>
                <td align='right'>{$t_ac_bus_tax|inr_format}</td>
                <td align='right'>{$t_cancellation_charges|inr_format}</td>
                <td align='right'>{$t_addons_amount|inr_format}</td>
                <td align='right'>{$t_refund_amount|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>