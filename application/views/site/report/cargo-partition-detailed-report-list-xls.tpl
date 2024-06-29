<table border="1">
    <tr>
        <td colspan="6" align="center"><b>Cargo Partition Detail Report</b>
    </tr>
    <tr>
        <td colspan="3">
            <b>Report Date : </b>{$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}
        </td>
        <td colspan="3" align="right"><b>Report At : </b>{$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
</table>
<br>

<div id="cargo_partition_report_cont">
    <table id="cargo_partition_report_table" class="table table-bordered " style="width:99%" border="1">
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
                                {$row->source_cargo_code}
                                <br>
                                {$row->booked_at|date_format:$ns_date_format}
                                {$row->payment_status_code}
                            </td>
                        {/if}
                        <td align="left">{$row->cargo_code}</td>
                        <td align="left" nowrap>{$row->partitioned_at}</td>
                        <td align="left" nowrap>{$row->partition_cargo_status_code}</td>
                        <td align="left" nowrap>{$row->from_station_name}</td>
                        <td align="left" nowrap>{$row->to_station_name}</td>
                        {if $i == 0}
                            <td align="left" nowrap rowspan={$iterate}>{$row->cargo_status_code}</td>
                        {/if}
                        <td align="right">{$row->loaded_at|date_format:$ns_date_format}</td>
                        <td align="right">{$row->unloaded_at|date_format:$ns_date_format}</td>
                        <td align="right">{$row->delivered_at|date_format:$ns_date_format}</td>
                        <td align="right">{$row->cargo_item_name}</td>
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