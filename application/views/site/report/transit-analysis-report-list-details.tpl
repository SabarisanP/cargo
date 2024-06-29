<table class="" width="99%">
    <tr>
        <td width="50%">
            <span class="bold">From </span>{$fromDate|date_format:$fromDate} <span class="bold">To </span>{$toDate|date_format:$toDate}
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table><br>
{if $filterType == 'DETAILS'}
    <div style="width: 50%;">
        <table id="sumary-table-transit-report" class="table table-bordered">
            <thead>
                <tr class="success">
                    <td align="center"><b>#</b></td>
                    <td align="center"><b>Route</b></td>
                    <td align="center"><b>LR Count</b></td>
                    <td align="center"><b>Article Count</b></td>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var=t_lr_count value=0}
                {assign var=sno value=1}
                {assign var=t_art_count value=0}
                {foreach item=row from=$routeWise}
                    <tr>
                        <td align='center'>{$sno}</td>
                        <td align='center'>{$row['route']}</td>
                        <td align='center'>{$row['lr_count']}</td>
                        <td align='center'>{$row['article_count']}</td>
                    </tr>
                    {assign var=sno value=$sno+1}
                    {assign var=t_lr_count value=$t_lr_count+$row['lr_count']}
                    {assign var=t_art_count value=$t_art_count +$row['article_count']}
                {/foreach}
            </tbody>
            {if count($routeWise) > 0}
                <tr class="active">
                    <td align="center" class="bold"></td>
                    <td align="center" class="bold"></td>
                    <td align="center" class="bold">{$t_lr_count}</td>
                    <td align="center" class="bold">{$t_art_count}</td>
                </tr>
            {/if}
        </table>
    </div>
    <div style="width: 50%;"></div>
    <br>
    <table id="" class="table table-bordered">
        <thead>
            <tr class="success">
                <td align="center"><b>#</b></td>
                <td align="center"><b>Booked Time </b></td>
                <td align="center"><b>LR No</b></td>
                <td align="center"><b>From</b></td>
                <td align="center"><b>To</b></td>
                <td align="center"><b>Start Transit Age</b></td>
                <td align="center"><b>Transit Status</b></td>
                <td align="center"><b>End Transit Age</b></td>
                <td align="center"><b>Article count</b></td>
                <td align="center"><b>Last Updated On </b></td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=t_lr_count value=0}
            {assign var=t_art_count value=0}
            {assign var=sno value=1}
            {foreach item=row from=$results }
                <tr>
                    <td align='center'>{$sno}</td>
                    <td align='center'>{$row->booked_at|date_format:"d, M y g:i A"}</td>
                    <td align='center'><a href="javascript:;" title="more details" onclick="getCargoDetails('{$row->cargo_code}');">{$row->cargo_code}</a></td>
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
                {assign var=sno value=$sno+1}
                {assign var=t_lr_count value=$t_lr_count+count($row->cargo_code)}
                {assign var=t_art_count value=$t_art_count +$row->article_count}
            {/foreach}
        </tbody>
        {if count($results) > 0}
            <tr class="active">
                <td align="center" class="bold"></td>
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
    $('#sumary-table-transit-report').dataTable({
        "bPaginate": false,
        "info": false,
        "dom": 'lrt',
        "aaSorting": [
            [0, "asc"],
        ]
    });
</script>