<table border="1">
    <tr>
        <td colspan="7" align="center"><b>Subscription Report</td>
    </tr>
    <tr>
        <td colspan="3"><b>Report By :</b> {$user_name} </td>
        <td colspan="4" align="right"><b>Report Date/Time :</b> {$smarty.now|date_format:$ns_datetime_format} </td>
    </tr>
</table>
<br>
<table class="table table-bordered" border="1">
    <thead>
        <tr style="font-weight:bold; background-color:#64b92a; color: #fff;">
            <th>S.No.</th>
            <th>Client Name</th>
            <th>Status</th>  
            <th>Invoice Date</th>
            <th>Invoice Status</th>                
            <th>Invoice Due Date</th> 
            <th>Due Stages</th> 
        </tr>
    </thead>
    <tbody>            
        {foreach item=row from=$results key=t}
            <tr>                    
                <td align="left">{$t+1}</td>
                <td align="left">{$row->namespaceName}</td>
                <td align="left">
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
                            {$namespace_status[$stage->status]} - {$events}<br>
                        {else if $stage->status == 'NOT_CONFIG'}
                            {$namespace_status[$stage->status]}
                        {else if $stage->status == 'DISABLE_SOON'}
                            {$namespace_status[$stage->status]} In {$stage->days} Days - {$events}<br>
                        {/if}
                    {/foreach}
                </td> 
                <td align="left">{$row->invoiceDate|date_format:$ns_date_format|default:'-'}</td> 
                <td align="center">{$row->invoiceStatus|default:'-'}</td> 
                <td align="left">{$row->invoiceDueDate|date_format:$ns_date_format|default:'-'}</td> 
                <td align="left">{$row->gracePeriodStages|default:'-'}</td>
            </tr>   
        {foreachelse}
            <tr>
                <td align="center" colspan="7">No data found !!!</td>
            </tr>
        {/foreach}  
    </tbody>
</table>