<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Dispatch Efficiency Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>

<div class="overflow-x-auto">
    <table id="cargo_revenue_report_table" class="table table-bordered " style="width:99%">
        <thead>
            <tr class="success">
                <th>S.No</th>
                <th>Vehicle No</th>
                <th>Driver</th>
                <th>LS No.</th>
                <th>From station</th>
                <th>To station</th>
                <th>Scheduled Time Of Departure (STD)</th>
                <th>Actual Time Of Departure (ATD)</th>
                <th>No. Of Articles Dispatched</th>
                <th>Scheduled Time Of  Arrival (STA)</th>
                <th>Actual Time Of Arrival (ATA)</th>
                <th>No. Of Articles Received</th>
            </tr>
        </thead>
        <tbody class="body_table">

            {assign var=t_transit_type value=0}
            {assign var=t_unload_count value=0}
            {assign var=t_load_count value=0}

            {foreach item=row from=$result key=i}
                <tr>
                    <td align="left">{$i + 1}</td>
                    <td align="left">{$row->registration_numer}</td>
                    <td align="left">{$row->driver_name}</td>
                    <td align="left">{$row->alias_code}</td>
                    <td align="left">{$row->from_station_name}</td>
                    <td align="left">{$row->to_station_name}</td>
                    <td align="left">{$row->scheduled_departure_time|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->actual_departure_time|date_format:$ns_datetime_format}</td>
                    <td align="right">{$row->load_count}</td>
                    <td align="left">{$row->scheduled_arrival_time|date_format:$ns_datetime_format}</td>
                    <td align="left">{($row->actual_arrival_time) ? ($row->actual_arrival_time|date_format:$ns_datetime_format) : '-'}</td>
                    <td align="right">{$row->unload_count}</td>
                </tr>
    
                {assign var=t_transit_type value=$t_transit_type + $row->transit_type}
                {assign var=t_unload_count value=$t_unload_count + $row->unload_count}
                {assign var=t_load_count value=$t_load_count + $row->load_count}
            {foreachelse}
                <tr>
                    <td colspan="12" align="center">No Records Found</td>
                </tr>
            {/foreach}
        </tbody>
        {if $result|count}
            <tfoot>
                <tr class="active bold">
                    <td colspan="8" align="right">Total</td>
                    <td align='right'>{$t_load_count}</td>
                    <td colspan="2" align='right'></td>
                    <td align='right'>{$t_unload_count}</td>
                </tr>
            </tfoot>
        {/if}
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportDispatchEfficiencyReport();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>