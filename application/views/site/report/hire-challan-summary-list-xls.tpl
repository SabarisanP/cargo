

<div class="panel panel-default"  style="overflow: auto;">
    <div class="panel-body">
        <div class="table-responsive">
            <table>
                <tr>
                    <td colspan="6" align="center"><b>Hire Challan Summary</b></td>
                </tr>
                <tr>
                    <td colspan="3" align="left"><b>From</b>&nbsp;{$smarty.request.from|date_format:$ns_date_format}&nbsp;<b>To</b>&nbsp;{$smarty.request.to|date_format:$ns_date_format}</td>
                    <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
                </tr>
                <tr>
                    <td colspan="3" align="left">&nbsp;</td>
                    <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$usr_login_name} </td>
                </tr>
            </table>

            <table border="1" class="table table-bordered" width="100%" >
            <thead class="table">
            <tr class="bold">
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Hire Challan No.</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Hire Challan Date</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">From Location Name</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">To Location Name</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Fleet No.</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Fleet Type</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Loading Capacity</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Owner Name</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Driver Name</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Driver Mobile No</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Petrol Pump Evidence Name</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Total Weight</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Total No. of Items</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Total Hire Charges</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Office Advance </td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Diesel Amount</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Balance</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Hire Challan Status</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">Accounting Status</td>
                <td align="center" colspan="3" style="border:1px solid black; background-color:white;"></td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">DC</td>
                <td align="center" rowspan="3" style="border:1px solid black; background-color:white;">DT</td>
            </tr>
            <tr class="bold">
                <td align="center" colspan="3" style="background-color:white; font-weight:bold">KMS</td>
            </tr>
            <tr class="bold">
                <td align="center" style="border:1px solid block; background-color:white; font-weight:bold">Trip</td>
                <td align="center" style="border:1px solid black; background-color:white;">Local</td>
                <td align="center" style="border:1px solid black; background-color:white;">Total</td>
            </tr>
        </thead>
        
                <tbody class="body_table">
                     {foreach item=row from=$result}
                        <tr>
                            <td align="center" style="border:1px solid black;">{$row->alias_code}</td>
                            <td align="center" style="border:1px solid black;">{$row->trip_date|date_format:"d-M-y"}</td>
                            <td align="center" style="border:1px solid black;">{$row->from_station_name}</td>
                            <td align="center" style="border:1px solid black;">{$row->to_station_name}</td>
                            <td align="center" style="border:1px solid black;">{$row->registration_numer}</td>
                            <td align="center" style="border:1px solid black;">{$row->vehicle_ownership_type}</td>
                            <td align="center" style="border:1px solid black;"></td>
                            <td align="center" style="border:1px solid black;">{$row->transporter_contact_name}</td>
                            <td align="center" style="border:1px solid black;">{$row->driver_name}</td>
                            <td align="center" style="border:1px solid black;">{$row->driver_mobile}</td>
                            <td align="center" style="border:1px solid black;">{$row->fuel_vendor_name}</td>
                            <td align="center" style="border:1px solid black;">{$row->total_actual_unit_value}</td>
                            <td align="center" style="border:1px solid black;">{$row->total_unit_value}</td>
                            <td align="center" style="border:1px solid black;">{$row->hiring_amount}</td>
                            <td align="center" style="border:1px solid black;">{$row->advance_amount}</td>
                            <td align="center" style="border:1px solid black;">{$row->fuel_amount}</td>
                            <td align="center" style="border:1px solid black;">{($row->fuel_amount - $row->advance_amount) - $row->hiring_amount}</td>
                            <td align="center" style="border:1px solid black;">{$row->transit_activity_status_code}</td>
                            <td align="center" style="border:1px solid black;">{if $row->payment_settlement_flag >0}PaymentReceived{else  $row->payment_settlement_flag <= 0 }paymentPending{/if}</td>
                            <td align="center" style="border:1px solid black;" nowrap>{$row->transit_end_odometer - $row->transit_start_odometer}</td>
                            <td align="center" style="border:1px solid black;">{$row->transit_link_end_odometer - $row->transit_link_start_odometer}</td>
                            <td align="center" style="border:1px solid black;">{($row->transit_end_odometer - $row->transit_start_odometer) + ($row->transit_link_end_odometer - $row->transit_link_start_odometer)}</td>
                            <td align="center" style="border:1px solid black;">{$row->total_pickup_handling_amount}</td>
                            <td align="center" style="border:1px solid black;">{$row->total_delivery_handling_amount}</td>
                        </tr>
                    {foreachelse}
                        <tr>
                            <td colspan="24" align="center" style="border:1px solid black;">Data not found</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
var result = {$result|json_encode}
</script>
