<table border='1'>
    <tr>
        <td  colspan="10" align="center" style="font-weight:bold">{$namespace_name}</td>                            
    </tr>
    <tr>
        <td  colspan="10" align="center" style="font-weight:bold"><span class="bold">Settlement Report</span></td>
    </tr>
    <tr>
        <td colspan="5">
            <span class="bold">Report Date : </span> 
            {$smarty.request.from|date_format:$ns_date_format}  to {$smarty.request.to|date_format:$ns_date_format} DOJ 
        </td>
        <td colspan="5">
            <span class="bold">Report At : </span> 
            {$smarty.now|date_format:$ns_datetime_format}
        </td>
    </tr>
    <tr>
        <td colspan="5">
            <span class="bold">User : </span> 
            {$tickets['username']}
        </td>
        <td colspan="5">
            <span class="bold">Report By : </span> 
            {$username} 
        </td>
    </tr>
</table>    

<br>
<table border='1'>
    <tr>
        <td colspan="4" style="font-weight:bold">Summary</td>                            
    </tr>
</table>
    
<table border='1'>
    <tr style="background-color:#64b92a; color: #fff;">
        <td colspan="2"  style="font-weight:bold" align="center" >Booking</td>
        <td colspan="2" style="font-weight:bold" align="center" >Cancellation</td>
    </tr>
    <tr>
        <td style="font-weight:bold" >Fare (B1)</td>
        <td align="right">{$tickets['bo_fare']|number_format:2}</td>
        <td style="font-weight:bold">Fare With GST (C1)</td>                                                            
        <td align="right">{($tickets['ca_fare']+$tickets['ca_ac_tax'])|number_format:2}</td>
    </tr>
    <tr>
        <td style="font-weight:bold" >Discount (B2)</td>
        <td align="right">{$tickets['bo_discount']|number_format:2}</td>
        <td style="font-weight:bold">Discount (C2)</td>                                                            
        <td align="right">{$tickets['ca_discount']|number_format:2}</td>
    </tr>

    <tr>
        <td style="font-weight:bold" >A/C GST (B3)</td>
        <td align="right">{$tickets['bo_ac_tax']|number_format:2}</td>
        <td style="font-weight:bold">Charges (C3)</td>                                                            
        <td align="right">{$tickets['ca_charges']|number_format:2}</td>
    </tr>
    <tr>
        <td style="font-weight:bold" >Commission (B4)</td>
        <td align="right">{$tickets['bo_comission']|number_format:2}</td>
        <td style="font-weight:bold">Agent Share (C4)</td>                                                            
        <td align="right">{$tickets['ca_share']|number_format:2}</td>
    </tr>
    <tr>
        <td style="font-weight:bold" >Sub Total (A=B1-B2+B3-B4)</td>
        <td align="right">{$tickets['bo_payable']|number_format:2}</td>
        <td style="font-weight:bold">Refund (C5 = C1-C2-C3)</td>                                                            
        <td align="right">{$tickets['ca_refund']|number_format:2}</td>
    </tr> 
    <tr>
        <td style="font-weight:bold" ></td>
        <td align="right"></td>
        <td style="font-weight:bold">Cancellation Revenue (B=C3-C4)</td>                                                            
        <td align="right">
            {$stot = $tickets['ca_charges']-$tickets['ca_share']}
            {$stot|number_format:2}
        </td>
    </tr> 
    <tr>
        <td style="font-weight:bold" colspan="3" >Net Payable (A+B)</td>                                                                                           
        <td style="font-weight:bold" align="right">
            {$tot = $tickets['bo_payable']+$stot}
            {$tot|number_format:2}
        </td>
    </tr>
</table>    

<br>

<table border='1'>
    <tr>
        <td colspan="10" style="font-weight:bold">Booking</td>                            
    </tr>
</table>

<table border='1'>
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <td align="center" width="70">PNR</td>
            <td align="center">Schedule</td> 
            <td align="center">Route</td> 
            <td align="center">Transaction Date</td>
            <td align="center">Travel Date</td>
            <td align="center">Seat Name</td>
            <td align="center">No. of Seats</td>
            <td align="center">Fare</td>
            <td align="center">Discount</td>
            <td align="center">A/C Tax</td>
            <td align="center">Commission</td>
            <td align="center">Payable</td>
        </tr>

    </thead>
    <tbody class="body_table" >

        {foreach item=ticket from=$tickets['booking'] key=t}               
            <tr class="row-{$ticket->ticket_code}">                    
                <td align="left" width="70">{$ticket->ticket_code}</td>   
                <td align="left" nowrap="">{$ticket->schedule_name} - {$ticket->trip_date|date_format:$ns_time_format}</td> 
                <td align="left" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td>                                        
                <td align="center">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
                <td align="center">{$ticket->travel_date|date_format:$ns_date_format}</td>
                <td align="left" >{$ticket->seat_name}</td>
                <td align="center" >{$ticket->seat_count}</td>
                <td align="right">{$ticket->ticket_amount}</td>
                <td align="right" >{$ticket->addon_amount}</td>
                <td align="right" >{$ticket->ac_bus_tax}</td>
                <td align="right" >{$ticket->commission_amount}</td>
                <td align="right" >{$ticket->payable}</td>
            </tr>
            {assign var="bo_tk" value="`$bo_tk+$ticket->seat_count`"}

        {/foreach}  
        <tr style="background-color:#bbbbbb; color: #fff;">
            <td colspan="6" class="bold" align="right">Sub Total</td>
            <td  align="center"  class="">{$bo_tk}</td>                
            <td  align="right"  class="">{$tickets['bo_fare']|number_format:2}</td>
            <td  align="right"  class="">{$tickets['bo_discount']|number_format:2}</td>
            <td  align="right"  class="">{$tickets['bo_ac_tax']|number_format:2}</td>
            <td  align="right" class="">{$tickets['bo_comission']|number_format:2}</td>
            <td align="right" class="">{$tickets['bo_payable']|number_format:2}</td>
        </tr>
    </tbody>
</table>        

<br>
<table border='1'>
    <tr>
        <td colspan="10" style="font-weight:bold">Cancellation</td>                            
    </tr>
</table>


<table border='1'>
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <td align="center" >PNR</td> 
            <td align="center">Schedule</td>
            <td align="center">Route</td> 
            <td align="center">Transaction Date</td>
            <td align="center">Travel Date</td>
            <td align="center" >Seat Name</td> 
            <td align="center" >No. of Seats</td>
            <td align="center" >Fare</td>
            <td align="center">Discount</td>
            <td align="center" >Cancellation Charges</td>
            <td align="center" >Cancel Agent Share</td>
            <td align="center" >Refund</td>
        </tr>

    </thead>
    <tbody class="body_table" >



        {foreach item=ticket from=$tickets['cancel'] key=t}          

            <tr class="row-{$ticket->ticket_code}">                    
                <td align="left">{$ticket->ticket_code}</td>   
                <td align="left" nowrap="">{$ticket->schedule_name} - {$ticket->trip_date|date_format:$ns_time_format}</td>
                <td align="left" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td>                                        
                <td align="center">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
                <td align="center">{$ticket->travel_date|date_format:$ns_date_format}</td>
                <td align="left" >{$ticket->seat_name}</td>
                <td align="center" >{$ticket->seat_count}</td>
                <td align="right" >{$ticket->ticket_amount}</td>
                <td align="right" >{$ticket->addon_amount}</td>
                <td align="right" >{$ticket->cancellation_charges}</td>
                <td align="right" >{$ticket->cancel_commission}</td>
                <td align="right" >{$ticket->refund}</td>
            </tr>
            {assign var="ca_tk" value="`$ca_tk+$ticket->seat_count`"}

        {/foreach} 
        <tr style="background-color:#bbbbbb; color: #fff;">
            <td colspan="6" class="bold" align="right">Sub Total</td>
            <td  align="center"  class="">{$ca_tk}</td>
            <td  align="right"  class="">{$tickets['ca_fare']|number_format:2}</td>
            <td  align="right"  class="">{$tickets['ca_discount']|number_format:2}</td>
            <td align="right" class="">{$tickets['ca_charges']|number_format:2}</td>
            <td align="right" class="">{$tickets['ca_share']|number_format:2}</td>
            <td align="right" class="">{$tickets['ca_refund']|number_format:2}</td>
        </tr>
    </tbody>
</table> 
