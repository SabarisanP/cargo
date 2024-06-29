<table class="" width="95%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">SMS Utilization Report</td>
    </tr>
    <tr>
        <td width="50%">
            SMS Sent Date Wise
            From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>

</table>
{assign var=g_b_sms_count value=0}
<div class="table-responsive" id="adv-bp-grid">
    <table id="dt_bp_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th align="center">#</th>
                <th align="center">Sent At</th>
                <th align="center">SMS Type</th>
                <th align="center">To Mobile / Email</th>                
                <th align="center">Reference # / {lang('lr')}</th>
                <th align="center">SMS Credit Count</th>
                <th align="center" width="50%">SMS Content</th>
            </tr>
        </thead>
        <tbody class="body_table">            
            {foreach item=row from=$result key=t  name=feticket}                
                <tr>                    
                    <td align='center'>{$smarty.foreach.feticket.index+1}</td>
                    <td align='left'>{$row->fired_date|date_format:$ns_datetime_format}</td>
                    <td align='left'>{$notification_type[$row->notification_type]}</td> 
                    <td align='center'>{$row->participant_address}</td>                    
                    <td align='center'>{$row->refference_code}</td>
                    <td align='center'>{$row->transaction_count}</td> 
                    <td align='left'>{$row->request_log}</td>
                </tr>
                {assign var=g_b_sms_count value=$g_b_sms_count+$row->transaction_count}
            {foreachelse}
                <tr>                    
                    <td colspan="9" align="center">No data found</td>
                </tr>
            {/foreach}
            <tr class="success bold">                    
                <td colspan="5" align="right">Total Credit</td>
                <td align="center" id="tkt_canceled">{$g_b_sms_count}</td>
                <td align="center" id="tkt_canceled"></td>                     
            </tr>
        </tbody>
    </table>                
</div>