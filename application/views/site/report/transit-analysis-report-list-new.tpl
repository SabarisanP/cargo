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
                <td align="center" class="bold">#<i class="fa fa-sort"></td>
                <td align="center" class="bold">Station Name <i class="fa fa-sort"></td>
                <td align="center" class="bold">Branch Name <i class="fa fa-sort"></td>
                <td align="center" class="bold" colspan="2">Booked</td>
                <td align="center" class="bold" colspan="2" style="text-decoration: underline;">Local/link Loaded</td>
                <td align="center" class="bold" colspan="2"  style="text-decoration: underline;">Direct loaded</td>
                <td align="center" class="bold" colspan="2"  style="text-decoration: underline;">Hub/link pending loaded </td>
                <td align="center" class="bold" colspan="2">Direct Pending Loaded</td>
                <td align="center" class="bold" colspan="2">In Transit</td>

                <td align="center" class="bold" colspan="2"  style="text-decoration: underline;">Transit Received</td>
                <td align="center" class="bold" colspan="2" style="color:red;">Missing</td>
                <td align="center" class="bold" colspan="2">Delivery</td>
                <td align="center" class="bold" colspan="2">Pending Delivery</td>
            </tr>
            <tr class="">
                <td align="center" class="bold"></td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold"></td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: #000;">Art </td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color:#f1f124;color:#000;">Art </td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: #000;">Art </td>
                <td align="center" class="bold" style="color:red;">LR </td>
                <td align="center" class="bold" style="color:red;background-color: #f1f124;">Art </td>
                <td align="center" class="bold" style="color:red;">LR </td>
                <td align="center" class="bold" style="color:red;background-color: #f1f124;">Art </td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: #000;">Art </td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: #000;">Art </td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: #000;">Art </td>
                <td align="center" class="bold" style="color:red;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: red;">Art </td>
                <td align="center" class="bold" style="color: #000;">LR </td>
                <td align="center" class="bold" style="background-color: #f1f124; color: #000;">Art </td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=snos value=1}
            {assign var=booked_lr value=0}
            {assign var=booked_art value=0}
            {assign var=local_lr value=0}
            {assign var=local_art value=0}
            {assign var=direct_load_lr value=0}
            {assign var=direct_load_art value=0}
            {assign var=hub_load_lr value=0}
            {assign var=hub_load_art value=0}
            {assign var=direct_pending_lr value=0}
            {assign var=direct_pending_art value=0}
            {assign var=in_transit_lr value=0}
            {assign var=in_transit_art value=0}
            {assign var=transit_received_lr value=0}
            {assign var=transit_received_art value=0}
            {assign var=missing_lr value=0}
            {assign var=missing_art value=0}
            {assign var=delivery_lr value=0}
            {assign var=delivery_art value=0}
            {assign var=pending_lr value=0}
            {assign var=pending_art value=0}
            {foreach item=row from=$results}
                <tr>
                    <td align='center'>{$snos}</td>
                    <td align='center'>{$row->from_station_name}</td>
                    <td align='center'>{$row->from_organization_name}</td>
                    <td align='center'>
                        {if $row->booked_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','NA','{$row->from_organization_name}');">{$row->booked_count}</a>
                        {else}
                            {$row->booked_count}
                        {/if}
                    </td>
                    <td align='center' style="background-color: #f1f124; color: #000;">{$row->article_count|default:'0'}</td>
                    <td align='center' style="color: #000;">
                        {if $row->local_load_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CLOD','{$row->from_organization_name}');">
                                {$row->local_load_count}
                            </a>
                        {else}
                            {$row->local_load_count}
                        {/if}
                    </td>
                    <td align='center' style="background-color: #f1f124; color: #000;">{$row->local_load_article_count|default:'0'}</td>
                    <td align='center' style="color: #000;">
                        {if $row->direct_load_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CDLD','{$row->from_organization_name}');">
                                {$row->direct_load_count}
                            </a>
                        {else}
                            {$row->direct_load_count}
                        {/if}
                    </td>
                    <td align='center' style="background-color: #f1f124; color: #000;">{$row->direct_load_article_count|default:'0'}</td>
                    <td align='center' style="color: red;">
                        {if $row->hub_load_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CHLD','{$row->from_organization_name}');">
                                {$row->hub_load_count}
                            </a>
                        {else}
                            {$row->hub_load_count}
                        {/if}
                    </td>
                    <td align='center' style="background-color: #f1f124; color: red;">{$row->hub_load_article_count|default:'0'}</td>
                    <td align='center' style="color: red">
                        {if $row->pending_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CPD','{$row->from_organization_name}');">
                                {$row->pending_count}
                            </a>
                        {else}
                            {$row->pending_count}
                        {/if}
                    </td>
                    <td align='center' style="background-color: #f1f124; color:red;">{$row->pending_article_count|default:'0'}</td>
                    <td align='center' style="color: #000;">
                        {if $row->loaded_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CLD','{$row->from_organization_name}');">
                                {$row->loaded_count}
                            </a>
                        {else}
                            {$row->loaded_count}
                        {/if}
                    </td>
                    <td align='center' style="background-color: #f1f124; color: #000;">{$row->loaded_article_count|default:'0'}</td>
                    <td align='center' style="color: #000;">
                        {if $row->unloaded_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CUD','{$row->from_organization_name}');">
                                {$row->unloaded_count}
                            </a>
                        {else}
                            {$row->unloaded_count}
                        {/if}
                    </td>
                    <td align='center' style="background-color: #f1f124; color: #000;">{$row->unloaded_article_count|default:'0'}</td>
                    <td align='center' style="color: #000;">
                        {if $row->missed_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CMD','{$row->from_organization_name}');">
                                {$row->missed_count}
                            </a>
                        {else}
                            {$row->missed_count}
                        {/if}
                    </td>
                    <td align='center' style="background-color: #f1f124;color:red;">{$row->missed_article_count|default:'0'}</td>
                    <td align='center' style="color: #000;">
                        {if $row->reached_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CRD','{$row->from_organization_name}');">
                                {$row->reached_count}
                            </a>
                        {else}
                            {$row->reached_count}
                        {/if}
                    </td>
                    <td align='center' style="background-color: #f1f124; color: #000;">{$row->reached_article_count|default:'0'}</td>
                    <td align='center' style="color: #000;">
                        {if $row->pending_delivery_count > 0}
                            <a href="javascript:;" onclick="getTransitlrDetails('{$row->from_organization_code}','CPLD','{$row->from_organization_name}');">
                                {$row->pending_delivery_count}
                            </a>
                        {else}
                            {$row->pending_delivery_count}
                        {/if}
                    </td>
                    <td align='center' style="background-color: #f1f124; color: #000;">{$row->pending_delivery_article_count|default:'0'}</td>
                </tr>
                {assign var=snos value=$snos + 1}
                {assign var=booked_lr value=$booked_lr+$row->booked_count}
                {assign var=booked_art value=$booked_art+$row->article_count}
                {assign var=local_lr value=$local_lr+$row->local_load_count}
                {assign var=local_art value=$local_art+$row->local_load_article_count}
                {assign var=direct_load_lr value=$direct_load_lr+$row->direct_load_count}
                {assign var=direct_load_art value=$direct_load_art+$row->direct_load_article_count}
                {assign var=hub_load_lr value=$hub_load_lr+$row->hub_load_count}
                {assign var=hub_load_art value=$hub_load_art +$row->hub_load_article_count}
                {assign var=direct_pending_lr value=$direct_pending_lr +$row->pending_count}
                {assign var=direct_pending_art value=$direct_pending_art+$row->pending_article_count}
                {assign var=in_transit_lr value=$in_transit_lr+$row->loaded_count}
                {assign var=in_transit_art value=$in_transit_art+$row->loaded_article_count}
                {assign var=transit_received_lr value=$transit_received_lr+$row->unloaded_count}
                {assign var=transit_received_art value=$transit_received_art+$row->unloaded_article_count}
                {assign var=missing_lr value=$missing_lr+$row->missed_count}
                {assign var=missing_art value=$missing_art+$row->missed_article_count}
                {assign var=delivery_lr value=$delivery_lr+$row->reached_count}
                {assign var=delivery_art value=$delivery_art+$row->reached_article_count}
                {assign var=pending_lr value=$pending_lr+$row->pending_delivery_count}
                {assign var=pending_art value=$pending_art+$row->pending_delivery_article_count}
            {/foreach}
        </tbody>
        {if count($results) > 0}
            <tr class="active">
                <td align="right" class="bold"></td>
                <td align="right" class="bold"></td>
                <td align="right" class="bold"></td>

                <td align="center" class="bold">{$booked_lr}</td>
                <td align="center" class="bold">{$booked_art}</td>
                <td align="center" class="bold">{$local_lr}</td>
                <td align="center" class="bold">{$local_art}</td>
                <td align="center" class="bold">{$direct_load_lr}</td>
                <td align="center" class="bold">{$direct_load_art}</td>
                <td align="center" class="bold">{$hub_load_lr}</td>
                <td align="center" class="bold">{$hub_load_art}</td>
                <td align="center" class="bold">{$direct_pending_lr}</td>
                <td align="center" class="bold">{$direct_pending_art}</td>
                <td align="center" class="bold">{$in_transit_lr}</td>
                <td align="center" class="bold">{$in_transit_art}</td>
                <td align="center" class="bold">{$transit_received_lr}</td>
                <td align="center" class="bold">{$transit_received_art}</td>
                <td align="center" class="bold">{$missing_lr}</td>
                <td align="center" class="bold">{$missing_art}</td>
                <td align="center" class="bold">{$delivery_lr}</td>
                <td align="center" class="bold">{$delivery_art}</td>
                <td align="center" class="bold">{$pending_lr}</td>
                <td align="center" class="bold">{$pending_art}</td>

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