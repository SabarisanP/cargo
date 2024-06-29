<table id="unload_complaints_table" class="table table-bordered " style="width:99%">
    <thead>
        <tr class="success">
            <td>S.No</td>
            <td>Cargo Code</td>
            <td>No.of articles</td>
            <td>From</td>
            <td>To</td>
            <td>Remarks</td>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=t_item_count value=0}
        {foreach item=row from=$result key=i}
            <tr>
                <td align="left">{$i+1}</td>
                <td align="left">
                    <a href="javascript:;" title="more details" onclick="getCargoDetails('{$row->cargo_code}')">{$row->cargo_code}</a>
                </td>
                <td align="center" width="13%">{$row->total_item_count}</td>

                <td align="left">
                    {$row->from_organization_name}<br>
                    <span class="text-muted">{$row->from_station_name}</span>
                </td>
                
                <td align="left">
                    {$row->to_organization_name}<br>
                    <span class="text-muted">{$row->to_station_name}</span>
                </td>
                <td align="left" width="20%">{$row->unloading_remarks}</td>
            </tr>
            {assign var=t_item_count value=$t_item_count + $row->total_item_count}
        {foreachelse}
            <tr>
                <td colspan="6" align="center">No Records Found</td>
            </tr>
        {/foreach}
    </tbody>
    {if $result|count}
        <tfoot>
            <tr class="active bold">
                <td colspan="2" align="right">Total</td>
                <td align='center'>{($t_item_count)}</td>
                <td colspan="3"></td>
            </tr>
        </tfoot>
    {/if}
</table>