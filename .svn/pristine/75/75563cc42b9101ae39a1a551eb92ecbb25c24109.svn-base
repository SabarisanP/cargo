<table width="65%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Subscription Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Report By :</span> {$user_name} </td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format} </td>
    </tr>

</table>
<div class="table-responsive" style="width: 85%;">
    <table class="table table-bordered" id="subscription-report-table">
        <thead>
            <tr class="success">
                <th>S.No.</th>
                <th>Client Name</th>
                <th>Status</th>  
                <th>Invoice Date</th>
                <th>Invoice Status</th>                
                <th>Invoice Due Date</th> 
                <th>Due Stages</th> 
            </tr>
        </thead>
        <tbody class="body_table">            
            {foreach item=row from=$results key=t}
                <tr>                    
                    <td>{$t+1}</td>
                    <td>{$row->namespaceName}</td>
                    <td style="line-height: 20px;" width="35%">
                        {foreach from=$row->stageStatus item=stage key=k}
                            {assign var=menuCodes value=","|explode:$stage->menuCodes}
                            {$events = ''}
                            {foreach from=$menuCodes item=val key=key}
                                {if $key != ($menuCodes|count - 1)}
                                    {$events = $events|cat:$billing_events[$val]|cat:','}
                                {else}
                                    {$events = $events|cat:$billing_events[$val]}
                                {/if}
                            {/foreach}

                            {if $stage->status == 'DISABLED'}
                                <span class="badge badge-danger">{$namespace_status[$stage->status]}</span> - {$events}<br>
                            {else if $stage->status == 'NOT_CONFIG'}
                                <span class="badge badge-info">{$namespace_status[$stage->status]}</span>
                            {else if $stage->status == 'DISABLE_SOON'}
                                <span class="badge badge-warning">{$namespace_status[$stage->status]} In {$stage->days} Days</span> - {$events}<br>
                            {/if}
                        {/foreach}
                    </td> 
                    <td>{$row->invoiceDate|date_format:$ns_date_format|default:'-'}</td> 
                    <td>{$row->invoiceStatus|default:'-'}</td> 
                    <td>{$row->invoiceDueDate|date_format:$ns_date_format|default:'-'}</td> 
                    <td>{$row->gracePeriodStages|default:'-'}</td>
                </tr>   
            {foreachelse}
                <tr>
                    <td align="center" colspan="7">No data found !!!</td>
                </tr>
            {/foreach}  
        </tbody>
    </table>                
</div>
<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportSubscriptionReport()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>   

<script>
    var subscriptionReportData = {$results|json_encode};

    if(subscriptionReportData){
        $('#subscription-report-table').dataTable({
            pageLength: 50
        });
    }
</script>