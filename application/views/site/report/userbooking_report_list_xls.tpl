<table border="1">
    <tr>
        <td  colspan="6" align="center" style="font-weight: bold">My Booking Report</td>
    </tr>
    <tr>
        <td colspan="3" style="font-weight: bold" >
            {if $smarty.request.date_option==1} 
                Travel Date Wise 
            {else}
                Transaction Date Wise
            {/if} 
            From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} </td>
        <td colspan="3" style="font-weight: bold" align="right"><span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>

</table>

    <br>
<table border='1'>
    <tr>
        <td colspan="6" style="font-weight:bold">Summary</td>                            
    </tr>
</table>
    
<table border='1'>
    <tr style="background-color:#64b92a; color: #fff;">
        <td style="font-weight:bold" align="left" >Category</td>
        <td style="font-weight:bold" align="center" >Amount (1)</td>
        <td style="font-weight:bold" align="center" >Discount (2)</td>
        <td style="font-weight:bold" align="center" >AC Bus GST (3)</td>
        <td style="font-weight:bold" align="center" >Commission with GST (4)</td>
        <td style="font-weight:bold" align="center" >Total (1-2+3-4)</td>
    </tr>
    <tr>
        <td align="left">Booking (A)</td>
        <td align="right">{$tickets['bo_fare']|number_format:2}</td>
        <td align="right">{$tickets['bo_discount']|number_format:2}</td>
        <td align="right">{$tickets['bo_ac_tax']|number_format:2}</td>
        <td align="right">{$tickets['bo_comission']|number_format:2}</td>
        <td align="right">
            {assign var=a value=$tickets['bo_fare']-$tickets['bo_discount']+$tickets['bo_ac_tax']-$tickets['bo_comission']}
            {$a|number_format:2}
        </td>
    </tr>
    <tr>
        <td align="left">Cancel (B)</td>
        <td align="right">{$tickets['ca_fare']|number_format:2}</td>
        <td align="right">{$tickets['ca_discount']|number_format:2}</td>
        <td align="right">{$tickets['ca_ac_tax']|number_format:2}</td>
        <td align="right">{$tickets['ca_comission']|number_format:2}</td>
        <td align="right">
            {assign var=b value=$tickets['ca_fare']-$tickets['ca_discount']+$tickets['ca_ac_tax']-$tickets['ca_comission']}
            {$b|number_format:2}
        </td>
    </tr>
    <tr>
        <td align="left">Cancel Charges (C)</td>
        <td align="right">{$tickets['ca_charges']|number_format:2}</td>
        <td align="right">0.00</td>
        <td align="right">0.00</td>
        <td align="right">{$tickets['ca_share']|number_format:2}</td>
        <td align="right">
            {assign var=c value=$tickets['ca_charges']-$tickets['ca_share']}
            {$c|number_format:2}
        </td>
    </tr>
    <tr>
        <td style="font-weight:bold" align="left">Net Amount (A-B+C)</td>
        <td style="font-weight:bold" align="right">{($tickets['bo_fare']-$tickets['ca_fare']+$tickets['ca_charges'])|number_format:2}</td>
        <td style="font-weight:bold" align="right">{($tickets['bo_discount']-$tickets['ca_discount'])|number_format:2}</td>
        <td style="font-weight:bold" align="right">{($tickets['bo_ac_tax']-$tickets['ca_ac_tax'])|number_format:2}</td>
        <td style="font-weight:bold" align="right">{($tickets['bo_comission']-$tickets['ca_comission']+$tickets['ca_share'])|number_format:2}</td>
        <td style="font-weight:bold" align="right">
            {($a-$b+$c)|number_format:2}
        </td>
    </tr>
</table>

<br>

    <table border="1" >
        <thead>
            <tr style="background-color:#64b92a; color: #fff;">
                <td rowspan="2" style="font-weight:bold" align="center">Travel Date</td>
                <td rowspan="2" style="font-weight:bold" align="center">Transaction Date</td> 
                <td rowspan="2" style="font-weight:bold">User Name</td>
                <td rowspan="2" style="font-weight:bold" align="center">Route</td>
                <td rowspan="2" style="font-weight:bold" align="center">PNR</td>                
                <td rowspan="2" style="font-weight:bold" align="center">Mobile</td>
                <td rowspan="2" style="font-weight:bold" align="center">Passenger Name</td>
                <td rowspan="2" style="font-weight:bold" align="center">Ticket Status</td> 
                <td rowspan="2" style="font-weight:bold" align="center">Seat Name</td>
                <td rowspan="2" align="center">Transaction Mode</td>
                
                <td align="center" style="font-weight:bold" colspan="5">Booking</td> 
                <td align="center" style="font-weight:bold" colspan="7">Cancel</td> 
            </tr>
            <tr style="background-color:#64b92a; color: #fff;">                     
                <td style="font-weight:bold" align="center">Fare</td>
                <td style="font-weight:bold" align="center">Discount</td>
                <td style="font-weight:bold" align="center">AC GST</td>
                <td style="font-weight:bold" align="center">Commission</td> 
                <td style="font-weight:bold" align="center" class="bold">Payable</td> 
                
                <td style="font-weight:bold" align="center">Fare</td>
                <td style="font-weight:bold" align="center">Discount</td>
                <td style="font-weight:bold" align="center">AC GST</td>
                <td style="font-weight:bold" align="center">Commission</td>      
                <td style="font-weight:bold" align="center">Can Charges</td>
                <td style="font-weight:bold" align="center">Agent Share</td>
                <td style="font-weight:bold" align="center" >Refund</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=g_b_ticket_amount value=0}
            {assign var=g_b_discount value=0}
            {assign var=g_b_ac_tax value=0}
            {assign var=g_b_comm_amount value=0} 
            {assign var=g_b_payable value=0} 

            {assign var=g_c_ticket_count value=0}
            {assign var=g_c_discount value=0}
            {assign var=g_c_ac_tax value=0}
            {assign var=g_ca_comm_amount value=0}
            {assign var=g_c_charge value=0}
            {assign var=g_c_agnt_share value=0}
            {assign var=g_c_refund value=0}

            {foreach item=level1 from=$tickets['one'] key=t}          
   
                {foreach item=level2 from=$level1 key=k}                    

                        {assign var="ticket" value=$level2}
                        <tr>                    
                            <td align="center" width='100'>{$ticket->travel_date|date_format:$ns_date_format}</td>     
                            <td align="center">{$ticket->transaction_date|date_format:$ns_date_format}</td>
                            <td>{$ticket->user_name}</td>
                            <td align="left" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td> 
                            <td align="left">{$ticket->ticket_code}</td>
                            <td align="left">{$ticket->mobile_number}</td>
                            <td align="left">{$ticket->passenger_name}</td>
                            <td align="center">{$ticket->ticket_status_code}</td>
                            <td align="left" width='100'>{$ticket->seat_name}</td>
                            <td align="left">{$paymode[$ticket->transaction_mode]}</td>
                            
                            {if $ticket->ticket_status_code=='BO' || $ticket->ticket_status_code=='PBL' || $ticket->ticket_status_code=='TCKTR' }
                                <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                <td align="right">{$ticket->ac_bus_tax|number_format:2}</td> 
                                <td align="right">{$ticket->commission_amount|number_format:2}</td>
                                <td align="right" class="bold">{($ticket->ticket_amount-$ticket->addons_amount+$ticket->ac_bus_tax-$ticket->commission_amount)|number_format:2}</td>
                                
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                
                                {assign var=g_b_ticket_amount value=$g_b_ticket_amount+$ticket->ticket_amount}
                                {assign var=g_b_discount value=$g_b_discount+$ticket->addons_amount}
                                {assign var=g_b_ac_tax value=$g_b_ac_tax+$ticket->ac_bus_tax}
                                {assign var=g_b_comm_amount value=$g_b_comm_amount+$ticket->commission_amount} 
                                {assign var=g_b_payable value=$g_b_payable+($ticket->ticket_amount-$ticket->addons_amount+$ticket->ac_bus_ta-$ticket->commission_amount)} 
                            {else if $ticket->ticket_status_code=='TCA'}                                
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                
                                <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                <td align="right">{$ticket->ac_bus_tax|number_format:2}</td> 
                                <td align="right">{$ticket->commission_amount|number_format:2}</td>
                                <td align="right">{$ticket->cancellation_charges|number_format:2}</td>
                                <td align="right">{$ticket->cancel_commission_amount|number_format:2}</td>                                
                                <td align="right" class="bold">{($ticket->ticket_amount-$ticket->addons_amount+$ticket->ac_bus_tax)|number_format:2}</td>
                                
                                {assign var=g_c_ticket_count value=$g_c_ticket_count+$ticket->ticket_amount}
                                {assign var=g_c_discount value=$g_c_discount+$ticket->addons_amount}
                                {assign var=g_c_ac_tax value=$g_c_ac_tax+$ticket->ac_bus_tax}
                                {assign var=g_ca_comm_amount value=$g_ca_comm_amount+$ticket->commission_amount}
                                {assign var=g_c_charge value=$g_c_charge+$ticket->cancellation_charges}
                                {assign var=g_c_agnt_share value=$g_c_agnt_share+$ticket->cancel_commission_amount}
                                {assign var=g_c_refund value=$g_c_refund+$ticket->ticket_amount-$ticket->addons_amount+$ticket->ac_bus_tax}
                            {else}                                
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                
                                <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                <td align="right">{$ticket->ac_bus_tax|number_format:2}</td> 
                                <td align="right">{$ticket->commission_amount|number_format:2}</td>
                                <td align="right">{$ticket->cancellation_charges|number_format:2}</td>
                                <td align="right">{$ticket->cancel_commission_amount|number_format:2}</td>                                
                                <td align="right" class="bold">{($ticket->refund_amount+$ticket->cancel_commission_amount)|number_format:2}</td>
                                
                                {assign var=g_c_ticket_count value=$g_c_ticket_count+$ticket->ticket_amount}
                                {assign var=g_c_discount value=$g_c_discount+$ticket->addons_amount}
                                {assign var=g_c_ac_tax value=$g_c_ac_tax+$ticket->ac_bus_tax}
                                {assign var=g_ca_comm_amount value=$g_ca_comm_amount+$ticket->commission_amount}
                                {assign var=g_c_charge value=$g_c_charge+$ticket->cancellation_charges}
                                {assign var=g_c_agnt_share value=$g_c_agnt_share+$ticket->cancel_commission_amount}
                                {assign var=g_c_refund value=$g_c_refund+$ticket->refund_amount+$ticket->cancel_commission_amount}
                            {/if}
                        </tr> 
                {/foreach}
                
            {/foreach}  
            <tr style="background-color:#bbbbbb; color: #fff;">
                <td colspan="10" style="font-weight:bold" align="right">Grand Total</td>

                <td align="right">{$g_b_ticket_amount|number_format:2}</td>
                <td align="right">{$g_b_discount|number_format:2}</td>
                <td align="right">{$g_b_ac_tax|number_format:2}</td>
                <td align="right">{$g_b_comm_amount|number_format:2}</td>
                <td align="right">{$g_b_payable|number_format:2}</td>
                
                <td align="right">{$g_c_ticket_count|number_format:2}</td>
                <td align="right">{$g_c_discount|number_format:2}</td>
                <td align="right">{$g_c_ac_tax|number_format:2}</td>
                <td align="right">{$g_ca_comm_amount|number_format:2}</td>
                <td align="right">{$g_c_charge|number_format:2}</td>
                <td align="right">{$g_c_agnt_share|number_format:2}</td>
                <td align="right">{$g_c_refund|number_format:2}</td>                
            </tr>

        </tbody>
    </table>      