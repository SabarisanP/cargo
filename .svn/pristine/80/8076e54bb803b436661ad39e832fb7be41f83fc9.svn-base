<table width="100%" border="1">
    <tr>
        <td  colspan="8" align="center"><b>Report Usage Report</b></td>
    </tr>
    <tr>
        <td colspan="4"><b>Report By :</b> {$user_name} </td>
        <td colspan="4"><b>Report Date/Time :</b> {$smarty.now|date_format:$ns_datetime_format} </td>
    </tr>

</table>

<table border="1">
    <thead>
        <tr>
            <th align="center">#</th>
            <th>Namespace</th> 
            <th>User</th>
            <th>Report Name</th>
            <th>Run At</th> 
            <th>Execution Time</th>
            <th>Report Code</th>
            <th>Status</th>
            <th>Result Count</th>                
            <th>User Code</th> 
            <th>Parameters</th>
            
        </tr>
    </thead>
    <tbody>            
        {foreach name=users item=row from=$data key=t}
            <tr>                    
                <td align="center">{$smarty.foreach.users.index+1}</td>
                <td>{$row->namespace_name}</td>
                <td>{$row->username}</td>
                <td>{$row->report_name}</td> 
                <td>{$row->updated_at|date_format:$ns_datetime_format}</td> 
                <td>{$row->execution_time}</td> 
                <td>{$row->report_code}</td> 
                <td>{$row->status_log}</td> 
                <td>{$row->result_row_count}</td> 
                <td>{$row->user_code}</td> 
                <td>{$row->parameter_log}</td> 
            </tr>
        {/foreach}  

    </tbody>
</table>                


     