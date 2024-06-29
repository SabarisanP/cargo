<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Add-on Transaction Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Date :</span> {$smarty.request.from_date|date_format:$ns_date_format} to {$smarty.request.to_date|date_format:$ns_date_format}</td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
    </tr>
</table>

<h5><b>Summary</b></h5>
<table class="" style="width:60%;">
    <tr>
        <td width="50%" >
            <table class="table table-bordered" style="width:50%">
                <tr>
                    <td class="bold" >Fare</td>
                    <td class="text-right">{$meta['total_fare']|number_format:2}</td>
                </tr>
                <tr>
                    <td class="bold" >Addon Amount</td>
                    <td class="text-right">{$meta['total_discount']|number_format:2}</td>
                </tr>
            </table>
        </td>
        <td width="50%">
            <table class="table table-bordered" style="width:50%">
                <tr>
                    <td class="bold" >Total Tickets</td>
                    <td class="text-right">{$total_tickets}</td>
                </tr>
                <tr>
                    <td class="bold" >Total Seats</td>
                    <td class="text-right">{$total_seats}</td>
                </tr>
            </table>
        </td>
    </tr>
</table>


<h5><b>Transactions</b></h5>
<div class="table-responsive">
    <table id="dt_bp_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th align="center">PNR</th>
                <th>Route</th>
                <th>Fare</th>
                <th>Addon Amount</th>
                <th>Addon Type</th>
                <th>Seat Count</th>
                <th>Booked By</th>
                <th>User Group</th>
                <th>Travel Date</th>
                <th>Booked Date</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach item=row from=$tickets key=t}
                <tr>
                    <td>{$row->ticket_code}</td>
                    <td>{$row->from_station_name} - {$row->to_station_name}</td>
                    <td align='right'>{$row->ticket_amount|number_format:2}</td>
                    <td align='right'>{$row->discount_amount|number_format:2}</td>
                    <td>{$addons_type[$row->addons_type_code]}</td>
                    <td>{$row->seat_count}</td>
                    <td>
                        {if $row->user_group_name|lower!='customer'} {$row->first_name}
                        {else} - {/if}
                    </td>
                    <td>{$row->user_group_name}</td>
                    <td>{$row->travel_date|date_format:$ns_date_format}</td>
                    <td>{$row->transaction_date|date_format:$ns_datetime_format}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="10" align="center">No data found</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>

<script>
    var addonmeta = {$meta|json_encode};
    var ticket_count = {$total_tickets};
</script>
