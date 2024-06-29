<table width="100%" border="1">
    <tr>
        <td  colspan="8" align="center"><b>Customers / Users Report</b></td>
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
            <th>First Name</th>
            <th>Last Name</th>
            <th>Username</th>  
            <th>Email</th>
            <th>Phone</th>                
            <th>User Type</th> 
            <th>Created At</th>
        </tr>
    </thead>
    <tbody>            
        {foreach name=users item=row from=$customers key=t}

            <tr>                    
                <td align="center">{$smarty.foreach.users.index+1}</td>
                <td>{$row->first_name}</td>
                <td>{$row->last_name}</td>
                <td>{$row->username}</td> 
                <td>{$row->email}</td> 
                <td>{$row->mobile}</td> 
                <td>{$row->customer_type}</td> 
                <td>{$row->created_at|date_format:$ns_date_format}</td> 
            </tr>   

        {/foreach}  

    </tbody>
</table>                


     