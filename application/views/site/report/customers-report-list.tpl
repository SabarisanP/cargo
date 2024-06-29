<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Customers / Users Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Report By :</span> {$user_name} </td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format} </td>
    </tr>

</table>
<div class="table-responsive" id="adv-bp-grid">
    <table id="dt_bp_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
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
        <tbody class="body_table">            
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
</div>
<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCustomersExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>   

     