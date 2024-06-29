<div class="row" style="width: 100%;">
{foreach from=$agent_data item=agen key=k}
    <div class="col-md-4" style="margin-bottom: 5px;">
        <div class="panel panel-default">
            <div class="heading_b"><i class="fa fa-calendar"></i> 
                {if $k == 'TODAY'}
                Today
                {elseif $k == 'YESTERDAY'}
                    Yesterday
                {elseif $k == 'THIS_WEEK'}
                    This Week
                {elseif $k == 'LAST_WEEK'}
                    Last Week
                {elseif $k == 'THIS_MONTH'}
                    This Month
                {elseif $k == 'LAST_MONTH'}
                    Last Month
                {/if}
            </div>
            <table class="table">
                <tbody>
                    {foreach from=$agen item=val key=key}
                        {if $key == 'TOT_AMT'}
                            <tr>
                                <th>Freight</th>
                                <td>{$val|inr_format}</td>
                            </tr>
                        {/if}
                        {if $key == 'TOT_GC'}
                            <tr>
                                <th>LR Count</th>
                                <td>{$val}</td>
                            </tr>
                        {/if}
                        {if $key == 'TOT_COM'}
                            <tr>
                                <th>Commission</th>
                                <td>{$val|inr_format}</td>
                            </tr>
                        {/if}
                        {if $key == 'TOT_HNDL_COM'}
                            <tr>
                                <th>Charges</th>
                                <td>{$val|inr_format}</td>
                            </tr>
                        {/if}
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
{/foreach}
</div>

<script>
    $('#brn-perf-as-on-time').html('(As on {$as_on_time|date_format:$ns_time_format})');
</script>