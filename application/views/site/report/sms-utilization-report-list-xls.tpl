<table border="1">
    <tr style="font-weight: bold">
        <td  colspan="10" align="center">Discount Utilization Report</td>
    </tr>
    <tr style="font-weight: bold">
        <td colspan="3">{$smarty.request.from_date|date_format:$ns_date_format} to {$smarty.request.to_date|date_format:$ns_date_format}</td>
        <td colspan="3" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
    </tr>
</table>
    
<br>
<table border='1'>
    <tr>
        <td colspan="10" style="font-weight:bold">Transactions</td>                            
    </tr>
</table>


<table id="dt_bp_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th align="center">Date</th>
                <th>Notification Mode</th>
                <th>Notification Type</th>
                <th>Participant Address</th>                
                <th>Refference Code</th>
                <th>Transaction Count</th>
                <th>Request Log</th>
                <th>Response Log</th>
            </tr>
        </thead>
        <tbody class="body_table">            
            {foreach item=row from=$result key=t}                
                <tr>                    
                    <td>{$row->fired_date|date_format:$ns_date_format}</td>
                    <td>{$row->notification_mode}</td>
                    <td align='right'>{$row->notification_type}</td> 
                    <td align='right'>{$row->participant_address}</td>                    
                    <td>{$row->refference_code}</td>
                    <td>{$row->transaction_count}</td> 
                    <td>{$row->request_log}</td> 
                    <td>{$row->response_log}</td>
                </tr>
            {foreachelse}
                <tr>                    
                    <td colspan="10" align="center">No data found</td>
                </tr>
            {/foreach}

        </tbody>
    </table>                
     