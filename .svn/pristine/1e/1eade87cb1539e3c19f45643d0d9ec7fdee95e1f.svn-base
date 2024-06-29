

<div class="panel panel-default">
    <div class="panel-body" >
        <div class="table-responsive" style="overflow: auto;">
            <table width="100%">
                <tr>
                    <td colspan="10" align="center"><h5 class="bold">Hire Challan Summary</h5></td>
                </tr>
                <tr>
                    <td width="50%"><span class="bold">Date :</span> {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}</td>
                    <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
                </tr>
            </table><br>
            <table id="" class="table table-bordered" width="100%">
                <thead class="table">
                    <tr class="bold success">
                        <td align="center" rowspan="3">Hire Challan No.</td>
                        <td align="center" rowspan="3">Hire Challan Date</td>
                        <td align="center" rowspan="3">From Location Name</td>
                        <td align="center" rowspan="3">To Location Name</td>
                        <td align="center" rowspan="3">Fleet No.</td>
                        <td align="center" rowspan="3">Fleet Type</td>
                        <td align="center" rowspan="3">Loading Capacity</td>
                        <td align="center" rowspan="3">Owner Name</td>
                        <td align="center" rowspan="3">Driver Name</td>
                        <td align="center" rowspan="3">Driver Mobile No</td>
                        <td align="center" rowspan="3">Petrol Pump Evidence Name</td>
                        <td align="center" rowspan="3">Total Weight</td>
                        <td align="center" rowspan="3">Total No. of Items</td>
                        <td align="center" rowspan="3">Total Hire Charges</td>
                        <td align="center" rowspan="3">Office Advance </td>
                        <td align="center" rowspan="3">Diesel Amount</td>
                        <td align="center" rowspan="3">Balance</td>
                        <td align="center" rowspan="3">Hire Challan Status</td>
                        <td align="center" rowspan="3">Accounting Status</td>
                        <td align="center" colspan="3">KMs</td>
                        <td align="center" rowspan="3">DC</td>
                        <td align="center" rowspan="3">DD</td>
                    </tr>
                    <tr  class="bold success">
                        <td align="center">Trip</td>
                        <td align="center">Local</td>
                        <td align="center">Total</td>
                    </tr>
                  
                </thead>
                <tbody class="body_table">
                     {foreach item=row from=$result}
                        <tr>
                            <td align="center">{$row->alias_code}</td>
                            <td align="center">{$row->trip_date|date_format:"d-M-y"}</td>
                            <td align="center">{$row->from_station_name}</td>
                            <td align="center">{$row->to_station_name}</td>
                            <td align="center">{$row->registration_numer}</td>
                            <td align="center">{$row->vehicle_ownership_type}</td>
                            <td align="center"></td>
                            <td align="center">{$row->transporter_contact_name}</td>
                            <td align="center">{$row->driver_name}</td>
                            <td align="center">{$row->driver_mobile}</td>
                            <td align="center">{$row->fuel_vendor_name}</td>
                            <td align="center">{$row->total_actual_unit_value}</td>
                            <td align="center">{$row->total_unit_value}</td>
                            <td align="center">{$row->hiring_amount}</td>
                            <td align="center">{$row->advance_amount}</td>
                            <td align="center">{$row->fuel_amount}</td>
                            <td align="center">{($row->fuel_amount - $row->advance_amount) - $row->hiring_amount}</td>
                     <td align="center">{if $row->transit_activity_status_code == CMPLT}Received{elseif $row->transit_activity_status_code == INTRST}In Transit{/if}</td>
                            <td align="center">{if $row->payment_settlement_flag >0}Amount Received{else  $row->payment_settlement_flag <= 0 }Amount Pending{/if}</td>


                            <td align="center" nowrap>{$row->transit_end_odometer - $row->transit_start_odometer}</td>

                            <td align="center">{$row->transit_link_end_odometer - $row->transit_link_start_odometer}</td>
                            <td align="center">{($row->transit_end_odometer - $row->transit_start_odometer) + ($row->transit_link_end_odometer - $row->transit_link_start_odometer)}</td>
                            <td align="center">{$row->total_pickup_handling_amount}</td>
                            <td align="center">{$row->total_delivery_handling_amount}</td>
                        </tr>
                    {foreachelse}
                        <tr>
                            <td colspan="24" align="center">Data not found</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
