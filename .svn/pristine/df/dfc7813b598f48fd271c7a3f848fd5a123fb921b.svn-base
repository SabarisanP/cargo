<table class="" width="95%">
    <tr>
        <td colspan="10" align="center"><span style="font-weight:bold">Ticket Transfer Details Report</span></td>
    </tr>
    <tr>
        <td colspan="5"><span style="font-weight:bold">From  </span>{$smarty.request.from|date_format:$ns_date_format}<span style="font-weight:bold"> To </span>{$smarty.request.to|date_format:$ns_date_format} </td>
        <td colspan="5" align="right"><span style="font-weight:bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
</table>
<table border="1">
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <th align="center" rowspan="2">#</th>
            <th align="center" colspan="4" class="text-center">First Ticket</th>
            <th align="center" colspan="4" class="text-center">Resheduled Ticket</th> 
            <th align="center" rowspan="2">Seats</th> 
        </tr>
        <tr style="background-color:#64b92a; color: #fff;">
            <th align="center">PNR</th>                
            <th align="center">User</th>                  
            <th align="center">Travel Date</th> 
            <th align="center">Transaction Date</th> 
            <th align="center">PNR</th>                
            <th align="center">User</th>                  
            <th align="center">Travel Date</th> 
            <th align="center">Transaction Date</th>  
        </tr>
    </thead>
    <tbody class="body_table">            
        {foreach item=row from=$result key=k}                
            <tr>                    
                <td align='left'>{$k+1}</td>
                <td align='left'>{$row->source_ticket_code}</td>         
                <td align='left'>{$row->source_user_name}</td>                          
                <td align='left'>{$row->source_travel_date|date_format:$ns_date_format}</td>      
                <td align='left'>{$row->source_transaction_date|date_format:$ns_datetime_format}</td>  
                <td align='left'>{$row->ticket_code}</td>       
                <td align='left'>{$row->user_name}</td>                          
                <td align='left'>{$row->travel_date|date_format:$ns_date_format}</td>    
                <td align='left'>{$row->transaction_date|date_format:$ns_datetime_format}</td>                     
                <td align='left'>{count(","|explode:$row->seat_name)}</td> 
            </tr>
        {foreachelse}
            <tr>                    
                <td colspan="10" align="center">No data found</td>
            </tr>
        {/foreach}
    </tbody>
</table>  