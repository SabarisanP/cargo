<table border="1" >
    <tr>
        <td  colspan="10" align="center" style="font-weight: bold;">PhoneBook Cancellation Report</td>
    </tr>
    <tr>
        <td colspan="4">
                {if $smarty.request.date_option==1} 
                    Trip Date Wise 
                {else}
                    Booked Date Wise
                {/if} 
                From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} 
        </td>
        <td colspan="4">
            <span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}
        </td>
    </tr>
</table>


{assign var=g_c_ticket_count value=0}
{assign var=g_c_ticket_amount value=0}

        

    <table border="1">
        <thead>
            <tr class="success">
                <td align="center" style="font-weight: bold;">#</td>
                <td align="center" style="font-weight: bold;">PNR</td>
                <td align="center" style="font-weight: bold;">Route</td>
                <td align="center" style="font-weight: bold;">Booked By</td>
                <td align="center" style="font-weight: bold;">Booked Date</td>
                <td align="center" style="font-weight: bold;">Travel Date</td>
                <td align="center" style="font-weight: bold;">Cancelled Date</td>
                <td align="center" style="font-weight: bold;">Group</td>
                <td align="center" style="font-weight: bold;">Cancelled By</td>
                <td align="center" style="font-weight: bold;">Status</td>
                                
                <td align="center" style="font-weight: bold;">Seats</td> 
                <td align="center" style="font-weight: bold;">Tck Amt</td>
                     
            </tr>
            
        </thead>
        <tbody class="body_table">               
            {foreach item=row from=$transactions key=t name=feticket}
                {if $row->ticket_status_code=="PBC"}
                <tr> 
                    <td>{$smarty.foreach.feticket.index+1}</td>
                    <td>{$row->ticket_code}</td>
                    <td>{$row->from_station_name} - {$row->to_station_name}</td>
                    <td>{$row->user_name}</td>
                    <td align="center">{$row->booked_date|date_format:$ns_date_format}</td>
                    <td align="center">{$row->travel_date|date_format:$ns_date_format}</td>
                    <td align="center">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                    <td nowrap>{$row->user_group_name}</td>
                    <td>{$row->cancelled_user_name}</td>
                    <td>{$row->ticket_status_code}</td>
                                    
                    <td align="center">{$row->seat_name}</td>   
                    <td align="right">{$row->ticket_amount|number_format:2}</td>                    
                </tr>
                

                {assign var=g_c_ticket_count value=$g_c_ticket_count+$row->seat_count}
                {assign var=g_c_ticket_amount value=$g_c_ticket_amount+$row->ticket_amount}
                
                {/if}
                
            {/foreach}  
            <tr class="success bold">                    
                    <td colspan="10" align="right" style="font-weight: bold;">Grand Total</td>
                    <td align="center" id="tkt_canceled" style="font-weight: bold;">{$g_c_ticket_count}</td>   
                    <td align="right" style="font-weight: bold;">{$g_c_ticket_amount|number_format:2}</td>                          
                </tr>
        </tbody>
    </table>                

 
