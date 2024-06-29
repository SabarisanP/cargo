<div class="panel panel-default">
    <div class="panel-body" >
        <div class="table-responsive" style="overflow: auto;">
            <table width="100%">
                <tr>
                    <td colspan="10" align="center"><h6 class="bold">Local Hire Challan Summary</h6></td>
                </tr>
                <tr>
                    <td width="50%"><span class="bold">Date :</span> {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}</td>
                    <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
                </tr>
            </table><br>
            <table id="" class="table table-bordered" width="100%">
                <thead class="table">
                    <tr class="bold success">
                        <td align="center" rowspan="3">S.NO</td>
                        <td align="center" rowspan="3">Lorry Hire Slip No.</td>
                        <td align="center" rowspan="3">Entry Date</td>
                        <td align="center" rowspan="3">Fleet Type</td>
                        <td align="center" rowspan="3">Fleet No.</td>
                        <td align="center" rowspan="3">Start Time</td>
                        <td align="center" rowspan="3">End Time</td>
                        <td align="center" rowspan="3">Starting KM</td>
                        <td align="center" rowspan="3">Ending KM</td>
                        <td align="center" rowspan="3">Total KM</td>
                        <td align="center" rowspan="3">Total Lorry Hire</td>
                        <td align="center" colspan="3">Advance</td>
                        <td align="center" rowspan="3">Hire Slip Status</td>
                        <td align="center"  colspan="2">DD</td>
                        <td align="center" colspan="2">DC</td>
                    </tr>
                    <tr class="bold success">
                        <td align="center">Cash</td>
                        <td align="center">Diesel</td>
                        <td align="center">Balance</td>
                        <td align="center">No</td>
                        <td align="center">Amount</td>
                        <td align="center">No</td>
                        <td align="center">Amount</td>
                    </tr>
                    </thead>
                <tbody class="body_table">
                {assign var="counter" value=1}
                {assign var="total_delivery_handling_amount" value=1}
                {assign var="total_pickup_handling_amount" value=1}
                {foreach item=row from=$result}
                <tr>
                    <td align="center">{$counter}</td>
                    <td align="center">{$row->alias_code}</td>
                    <td align="center">{$row->trip_date|date_format:"d-M-y"}</td>
                    <td align="center">{$row->vehicle_ownership_type}</td>
                    <td align="center">{$row->registration_numer}</td>
                    <td align="center">{$row->departure_at|date_format:"%d/%m/%Y %H:%M"}</td>
                    <td align="center">{$row->arrival_at|date_format:"%d/%m/%Y %H:%M"}</td>
                    <td align="center">{$row->transit_start_odometer}</td>
                    <td align="center">{$row->transit_end_odometer}</td>
                    <td align="center">{$row->transit_end_odometer - $row->transit_start_odometer}</td>
                    <td align="center">{$row->hiring_amount}</td>
                    <td align="center">{$row->advance_amount}</td>
                    <td align="center">{$row->fuel_amount}</td>
                    <td align="center">{($row->fuel_amount - $row->advance_amount) + $row->hiring_amount}</td>
                    <td align="center">{if $row->payment_settlement_flag >0}Payment Received{else  $row->payment_settlement_flag <= 0 }payment Pending{/if}</td>
                    <td align="center">{$total_delivery_handling_amount}</td>
                    <td align="center">{$row->total_delivery_handling_amount}</td>
                    <td align="center">{$total_pickup_handling_amount}</td>
                    <td align="center">{$row->total_pickup_handling_amount}</td>
                </tr>
                {assign var="counter" value=$counter+1}
                {assign var="total_delivery_handling_amount" value=$total_delivery_handling_amount+1}
                {assign var="total_pickup_handling_amount" value=$total_pickup_handling_amount+1}
                {foreachelse}
                <tr>
                    <td colspan="19" align="center">Data not found</td>
                </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
