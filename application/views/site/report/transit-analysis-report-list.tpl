<table class="" width="99%">
    <tr>
        <td width="50%">
            <span class="bold">From </span>{$fromDate|date_format:$fromDate} <span class="bold">To </span>{$toDate|date_format:$toDate}
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table>
<br>
{if $filterType == 'SUMMARY'}
    <table id="transit_analysis_movement_table" class="table table-bordered">
        <thead>
            <tr class="success">
                <td align="center" class="bold f-16">Station Name <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Branch Name <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Article Count <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Booking Count <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Pending Loading <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">In-Transit Count <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Reached Count <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Delivery Count <i class="fa fa-sort"></td>
                <td align="center" class="bold f-16">Cargo Missing <i class="fa fa-sort"></td>
            </tr>
        </thead>

        <tbody class="body_table">
            {assign var=t_bk_count value=0}
            {assign var=t_load_count value=0}
            {assign var=t_pending_count value=0}
            {assign var=t_unload_count value=0}
            {assign var=t_reach_count value=0}
            {assign var=t_art_count value=0}
            {assign var=t_missing_count value=0}
            {foreach item=row from=$results}
                <tr>
                    <td align='center' class="f-16">{$row->from_station_name}</td>
                    <td align='center' class="f-16">{$row->from_organization_name}</td>
                    <td align='center' class="f-16">{$row->article_count}</td>
                    <td align='center' class="f-16">
                        {if $row->booked_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','NA','{$row->from_organization_name}');">{$row->booked_count}</a>
                        {else}
                            {$row->booked_count}
                        {/if}
                    </td>
                    <td align='center' class="f-16">
                        {if $row->pending_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CPD','{$row->from_organization_name}');">
                                {$row->pending_count}
                            </a>
                        {else}
                            {$row->pending_count}
                        {/if}
                    </td>

                    <td align='center' class="f-16">
                        {if $row->loaded_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CLD','{$row->from_organization_name}');">
                                {$row->loaded_count}
                            </a>
                        {else}
                            {$row->loaded_count}
                        {/if}
                    </td>
                    <td align='center' class="f-16">
                        {if $row->unloaded_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CUD','{$row->from_organization_name}');">
                                {$row->unloaded_count}
                            </a>
                        {else}
                            {$row->unloaded_count}
                        {/if}
                    </td>
                    <td align='center' class="f-16">
                        {if $row->reached_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CRD','{$row->from_organization_name}');">
                                {$row->reached_count}
                            </a>
                        {else}
                            {$row->reached_count}
                        {/if}
                    </td>
                    <td align='center' class="f-16">
                        {if $row->missed_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CMD','{$row->from_organization_name}');">
                                {$row->missed_count}
                            </a>
                        {else}
                            {$row->missed_count}
                        {/if}
                    </td>
                    {assign var=t_missing_count value=$t_missing_count+$row->missed_count}
                    {assign var=t_art_count value=$t_art_count+$row->article_count}
                    {assign var=t_bk_count value=$t_bk_count +$row->booked_count}
                    {assign var=t_load_count value=$t_load_count +$row->loaded_count}
                    {assign var=t_pending_count value=$t_pending_count + $row->pending_count}
                    {assign var=t_unload_count value=$t_unload_count +$row->unloaded_count}
                    {assign var=t_reach_count value=$t_reach_count +$row->reached_count}
                </tr>
            {/foreach}
        </tbody>
        {if count($results) > 0}
            <tfoot>
                <tr class="active">
                    <td colspan="2" align="right" class="bold f-16">Total</td>
                    <td class="bold f-16" align="center">{$t_art_count}</td>
                    <td class="bold f-16" align="center">{$t_bk_count}</td>
                    <td class="bold f-16" align="center">{$t_pending_count}</td>
                    <td class="bold f-16" align="center">{$t_load_count}</td>
                    <td class="bold f-16" align="center">{$t_unload_count}</td>
                    <td class="bold f-16" align="center">{$t_reach_count}</td>
                    <td class="bold f-16" align="center">{$t_missing_count}</td>
                </tr>
            </tfoot>
        {/if}
    </table>
{/if}

{if $filterType == 'DETAILS'}
    <table id="" class="table table-bordered">
        <thead>
            <tr class="success">
                <td align="center">LR No</td>
                <td align="center">Booked Time </td>
                <td align="center">From</td>
                <td align="center">To</td>
                <td align="center">Start Transit Age</td>
                <td align="center">Transit Status</td>
                <td align="center">End Transit Age</td>
                <td align="center">Article count</td>
                <td align="center">Last Updated On </td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=t_lr_count value=0}
            {assign var=t_art_count value=0}
            {foreach item=row from=$results }
                <tr>
                    <td align='center'>{$row->cargo_code}</td>
                    <td align='center'>{$row->booked_at|date_format:"d, M y g:i A"}</td>
                    <td align='center'>{$row->from_station_name}</td>
                    <td align='center'>{$row->to_station_name}</td>
                    <td align='center'>{$row->start_transit_age}</td>
                    <td align='center'>{$row->transit_status}</td>
                    <td align='center'>{if $row->end_transit_age=="NA"}
                        - {else}
                            {$row->end_transit_age}
                        {/if}</td>
                    <td align='center'>{$row->article_count}</td>
                    <td align='center'>{$row->updated_at|date_format:"d, M y g:i A"}</td>
                </tr>
                {assign var=t_lr_count value=$t_lr_count+count($row->cargo_code)}
                {assign var=t_art_count value=$t_art_count +$row->article_count}
            {foreachelse}
                <tr>
                    <td colspan="9" align="center">No data found</td>
                </tr>
            {/foreach}
        </tbody>
        {if count($results) > 0}
            <tr class="active">
                <td align="right" class="bold">Total</td>
                <td align="center" class="bold">{$t_lr_count}</td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold">{$t_art_count}</td>
                <td align="center" class="bold"></td>
            </tr>
        {/if}
    </table>
{/if}

<script>
    $('#transit_analysis_movement_table').dataTable({
        "bPaginate": false,
        "info": false,
        "dom": 'lrt',
        "aaSorting": [
            [3, "desc"],
        ]
    });
</script>