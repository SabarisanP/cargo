<table border='1'>
    <tr>
        <td  colspan="12" align="center"><b>Customer Details Report</b></td>
    </tr>
    <tr>
        <td colspan="6">Report Date : {$smarty.request.from|date_format:$ns_date_format}  to {$smarty.request.to|date_format:$ns_date_format} </td>
        <td colspan="6" >Report At : {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
        <td colspan="6" ><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>    

<br>


<table class="table table-bordered " border='1'>
    <thead>
        <tr style="font-weight:bold; background-color:#64b92a; color: #fff;">
            <th >#</th>
            <th >PNR</th>
            <th >Travel Date</th>
            <th >Name</th>
            <th >Email</th>
            <th >Mobile</th>
            <th >From Station</th>
            <th >To Station</th>                     
            <th >Booking Date</th> 
            <th >Booked By</th>
            <th >Seat Count</th>  
            <th >Device Medium</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach from=$reports item=row name=fetrans}                
            <tr>
                <td>{$smarty.foreach.fetrans.index+1}</td> 
                <td>{$row->ticket_code}</td> 
                        <td>{$row->travel_date|date_format:$ns_date_format}</td> 
                        <td>{$row->passenger_name}</td> 
                        <td>{$row->email}</td> 
                        <td>{$row->mobile}</td>
                        <td>{$row->from_station_name}</td> 
                        <td>{$row->to_station_name}</td>                         
                        <td>{$row->booking_date|date_format:$ns_datetime_format}</td>
                        <td>{$row->user_name}</td>
                        <td> {$row->seat_count}</td>
                        <td>{$row->device_medium}</td>                      
            </tr>
            {foreachelse}
                <tr>
                    <td colspan="12" align='center'> No data found</td>
                </tr>
        {/foreach}
    </tbody>
</table>


