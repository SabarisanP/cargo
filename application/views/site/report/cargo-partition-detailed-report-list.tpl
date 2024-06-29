<table class="" width="100%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Cargo Partition Detail Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>

<div id="cargo_partition_report_cont">
    <table id="cargo_partition_report_table" class="table table-bordered " style="width:100%">
        <thead>
            <tr class="success">
                <th class="thead">S No. </th>
                <th class="thead">Source {lang('lr')} </th>
                <th class="thead">{lang('lr')} </th>
                <th class="thead">Partition Time </th>
                <th class="thead">Partition Cargo Status </th>
                <th class="thead">From Route </th>
                <th class="thead">To Route </th>
                <th class="thead"> Cargo Status </th>
                <th class="thead">Loaded At </th>
                <th class="thead">unLoaded At </th>
                <th class="thead">Delivery At </th>
                <th class="thead">Item Name </th>
                <th class="thead">Total Items </th>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=t_iteam_count value=0}
            {foreach item=iterate from=$counts key =j}
                {foreach item=row from=$result key=i}
                    {if ($i+1) > $iterate }
                        {$result = array_slice($result, $iterate)}
                        {break}
                    {/if}

                    <tr>
                        {if $i ==0}
                            <td align="left" nowrap rowspan={$iterate}>{$j+1}</td>
                            <td align="left" nowrap rowspan={$iterate}>
                                <a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->source_cargo_code}")'>
                                    {$row->source_cargo_code}
                                </a><br>
                                {$row->booked_at|date_format:$ns_date_format}
                                {$row->payment_status_code}
                            </td>
                        {/if}
                        <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                        <td align="left" nowrap>{$row->partitioned_at}</td>
                        <td align="left" nowrap>{$cargo_status[$row->partition_cargo_status_code]}</td>
                        <td align="left" nowrap>{$row->from_station_name}</td>
                        <td align="left" nowrap>{$row->to_station_name}</td>
                        {if $i == 0}
                            <td align="left" nowrap rowspan={$iterate}>{$cargo_status[$row->cargo_status_code]}</td>
                        {/if}
                        <td align="right">{$row->loaded_at|date_format:$ns_date_format}</td>
                        <td align="right">{$row->unloaded_at|date_format:$ns_date_format}</td>
                        <td align="right">{$row->delivered_at|date_format:$ns_date_format}</td>
                        <td align="left">{$row->cargo_item_name}</td>
                        <td align="right">{$row->total_item_count}</td>
                        {assign var=t_iteam_count value=$t_iteam_count+$row->total_item_count}
                    </tr>
                {/foreach}
            {/foreach}
        </tbody>
        {if count($result) > 0}
            <tfoot>
                <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                    <td colspan="12" align="right">Total</td>
                    <td align="right">{$t_iteam_count}</td>
                </tr>
            </tfoot>
        {/if}

    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportPartitionExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>