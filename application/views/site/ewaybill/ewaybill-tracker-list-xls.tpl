<table border="1">
    <tr style="font-weight: bold">
        <td colspan="10" align="center">E-Way Bill Booking Report</span></td>
    </tr>
    <tr style="font-weight: bold">
        <td colspan="5">{$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format}</td>
        <td colspan="5" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
    </tr>
</table>
<br>

<table border="1">
    <thead>
        <tr style="font-weight: bold; background-color:#64b92a; color: #fff;">
            <th>{lang('lr')} Number</th>
            <th align="left">E-Way Bill No.</th>
            <th align="left">Booked At</th>
            <th>Origin</th>
            <th>Destination</th>
            <th align="left">Reg No.</th>
            <th align="left">{lang('ogpl')} No</th>
            <th align="left">{lang('ogpl')}</th>
            <th align="left">Loaded At</th>
            <th align="left">Payment Type</th>
            <th align="left">Cargo Status</th>
            <th align="left">Remarks</th>
        </tr>
    </thead>
    <tbody>
        {foreach item=row from=$result}
            <tr>
                <td align="left">{$row->cargo_code}</td>
                <td align="left">{$row->ewaybill_number}</td>
                <td align="left">{$row->booked_at}</td>
                <td align="left" nowrap>{$row->from_station_name} - {$row->from_organization_name}</td>
                <td align="left" nowrap>{$row->to_station_name} - {$row->to_organization_name}</td>
                <td align="left">{$row->registration_number}</td>
                <td align="left">{$row->transit_alias_code}</td>
                <td align="left">{$row->transit_name}</td>
                <td align="left">{$row->loaded_at}</td>
                <td align="center">{$row->payment_type_code|_cargo_payment_status_badge}</td>
                <td align="center">{$cargo_status[$row->cargo_status_code]}</td>
                <td align="left">{$row->remarks}</td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="10" align="center">No Records Found</td>
            </tr>
        {/foreach}
    </tbody>
</table>
