<table>
    <tr>
        <td colspan="6" align="center"><b>Local Hire Challan Summary</b></td>
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
<table id="" class="table table-bordered" width="100%">
    <thead class="table" >
        <tr class="bold success" >
            <td align="center" rowspan="3"  style="border:1px solid black; background-color:white;">S.NO</td>
            <td align="center" rowspan="3"  style="border:1px solid black; background-color:white;">Lorry Hire Slip No.</td>
            <td align="center" rowspan="3"  style="border:1px solid black; background-color:white;">Entry Date</td>
            <td align="center" rowspan="3"  style="border:1px solid black; background-color:white;">Fleet Type</td>
            <td align="center" rowspan="3"  style="border:1px solid black; background-color:white;">Fleet No.</td>
            <td align="center" rowspan="3"  style="border:1px solid black; background-color:white;">Strat Time</td>
            <td align="center" rowspan="3"  style="border:1px solid black; background-color:white;">End Time</td>
            <td align="center" rowspan="3"  style="border:1px solid black; background-color:white;">Starting KM</td>
            <td align="center" rowspan="3"  style="border:1px solid black; background-color:white;">Ending KM</td>
            <td align="center" rowspan="3"  style="border:1px solid black; background-color:white;">Total KM</td>
            <td align="center" rowspan="3"  style="border:1px solid black; background-color:white;">Total Lorry Hire</td>
            <td align="center" colspan="3"  style="border:1px solid black; background-color:white;"></td>
            <td align="center" rowspan="3"  style="border:1px solid black; background-color:white;">Hire Slip Status</td>
            <td align="center" colspan="2"  style="border:1px solid black; background-color:white;"></td>
            <td align="center" colspan="2"  style="border:1px solid black; background-color:white;"></td>
        </tr>
        <tr class="bold success">
        <td align="center" colspan="3"  style="border:1px solid black; background-color:white; font-weight:bold;">Advance</td>
        <td align="center" colspan="2"  style="border:1px solid black; background-color:white; font-weight:bold;">DD</td>
        <td align="center" colspan="2"  style="border:1px solid black; background-color:white;  font-weight:bold;">DC</td>
        </tr>
        <tr class="bold success">
            <td align="center"  style="border:1px solid black; background-color:white; font-weight:bold;">Cash</td>
            <td align="center"  style="border:1px solid black; background-color:white;">Diesel</td>
            <td align="center"  style="border:1px solid black; background-color:white;">Balance</td>
            <td align="center"  style="border:1px solid black; background-color:white;  font-weight:bold;">No</td>
            <td align="center"  style="border:1px solid black; background-color:white;">Amount</td>
            <td align="center"  style="border:1px solid black; background-color:white;">No</td>
            <td align="center"  style="border:1px solid black; background-color:white;">Amount</td>
        </tr>  
    </thead>
    <tbody class="body_table">
    {assign var="counter" value=1}
    {assign var="total_delivery_handling_amount" value=1}
    {assign var="total_pickup_handling_amount" value=1}
            {foreach item=row from=$result}
            <tr>
                <td align="center"  style="border:1px solid black;">{$counter}</td>
                <td align="center"  style="border:1px solid black;">{$row->alias_code}</td>
                <td align="center"  style="border:1px solid black;">{$row->trip_date|date_format:"d-M-y"}</td>
                <td align="center"  style="border:1px solid black;">{$row->vehicle_ownership_type}</td>
                <td align="center"  style="border:1px solid black;">{$row->registration_numer}</td>
                <td align="center"  style="border:1px solid black;">{$row->departure_at|date_format:"%d/%m/%Y %H:%M"}</td>
                <td align="center"  style="border:1px solid black;">{$row->arrival_at|date_format:"%d/%m/%Y %H:%M"}</td>
                <td align="center"  style="border:1px solid black;">{$row->transit_start_odometer}</td>
                <td align="center"  style="border:1px solid black;">{$row->transit_end_odometer}</td>
                <td align="center"  style="border:1px solid black;">{$row->transit_end_odometer - $row->transit_start_odometer}</td>
                <td align="center"  style="border:1px solid black;">{$row->hiring_amount}</td>
                <td align="center"  style="border:1px solid black;">{$row->advance_amount}</td>
                <td align="center"  style="border:1px solid black;">{$row->fuel_amount}</td>
                <td align="center"  style="border:1px solid black;">{($row->fuel_amount - $row->advance_amount) + $row->hiring_amount}</td>
                <td align="center"  style="border:1px solid black;">{if $row->payment_settlement_flag >0}Payment Received{else  $row->payment_settlement_flag <= 0 }payment Pending{/if}</td>
                <td align="center"  style="border:1px solid black;">{$total_delivery_handling_amount}</td>
                <td align="center"  style="border:1px solid black;">{$row->total_delivery_handling_amount}</td>
                <td align="center"  style="border:1px solid black;">{$total_pickup_handling_amount}</td>
                <td align="center"  style="border:1px solid black;">{$row->total_pickup_handling_amount}</td>
            </tr>
            {assign var="counter" value=$counter+1}
            {assign var="total_delivery_handling_amount" value=$total_delivery_handling_amount+1}
            {assign var="total_pickup_handling_amount" value=$total_pickup_handling_amount+1}
        {foreachelse}
            <tr>
                <td colspan="19" align="center"  style="border:1px solid black;">Data not found</td>
            </tr>
        {/foreach}
    </tbody>
</table>