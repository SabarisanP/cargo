{strip}
    <table width="100%" style="font-size: 9px;">
        <tr>
            <td colspan="2" align="center" style="font-size: 10px;"><b>Transactions Report</b></td>
        </tr>
        <tr>
            <td width="50%">
                {if $smarty.request.date_option==1} 
                    Trip Date Wise 
                {else}
                    Booked Date Wise
                {/if} 
                &nbsp;From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} </td>
            <td width="50%" align="right">Printed By {$usr_login_name} @ {date("d/m/Y h:i A")} </td>
        </tr>
        <tr>
            <td colspan="2"><br/><br/>
                <b>User : </b> {$tickets['user_name']}<br/>
                <b>User Group : </b> {$tickets['user_group_name']}<br/>
            </td>
        </tr>
    </table>
{/strip}

<div style="font-size: 10px;"><b>Summary</b></div>
<div class="overflow-x-auto">
    <table border="0.5" cellspacing="0" cellpadding="2" class="table table-bordered" style="width:100%;">
        <tr  style="background-color:#64b92a; color: #fff;">
            <td class="bold text-left" >Category</td>
            <td class="bold text-center" >Amount (1)</td>
            <td class="bold text-center" >Discount (2)</td>
            <td class="bold text-center" >AC Bus GST (3)</td>
            <td class="bold text-center" >Commission with GST (4)</td>
            <td class="bold text-center" >Total (1-2+3-4)</td>
        </tr>
        <tr>
            <td class="text-left">Booking (A)</td>
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
            <td class="text-left">Cancel (B)</td>
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
            <td class="text-left">Cancel Charges (C)</td>
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
            <td class="text-left">Trip Cancel (D)</td>
            <td align="right">0.00</td>
            <td align="right">0.00</td>
            <td align="right">0.00</td>
            <td align="right">0.00</td>
            <td align="right">
                {assign var=d value=$tickets['tca_refund']}
                {$d|number_format:2}
            </td>
        </tr>
        <tr>
            <td class="bold text-left">Net Amount (A-B+C-D)</td>
            <td align="right"><b>{($tickets['bo_fare']-$tickets['ca_fare']+$tickets['ca_charges'])|number_format:2}</b></td>
            <td align="right"><b>{($tickets['bo_discount']-$tickets['ca_discount'])|number_format:2}</b></td>
            <td align="right"><b>{($tickets['bo_ac_tax']-$tickets['ca_ac_tax'])|number_format:2}</b></td>
            <td align="right"><b>{($tickets['bo_comission']-$tickets['ca_comission']+$tickets['ca_share'])|number_format:2}</b></td>
            <td align="right"><b>{($a-$b+$c-$d)|number_format:2}</b></td>
        </tr>
    </table>
</div>

<div style="font-size: 10px;"><b>Booking</b></div>
<div class="overflow-x-auto">
    <table border="0.5" cellspacing="0" cellpadding="2" id="dt_adv_booking_report_table" class="table table-bordered " >
        <thead>
            <tr  style="background-color:#64b92a; color: #fff;">
                <td align="center">Travel Date</td>
                <td align="center">Transaction Date</td> 
                <td align="center">Route</td>
                <td align="center">PNR</td>                 
                <td align="center">Ticket Status</td>
                <td align="center">Seat<br/>Count</td>
                <td align="center">Fare</td> 
                <td align="center">GST</td> 
                <td align="center">Discount</td>
                <td align="center">Commission</td> 
                <td align="center">Payable</td>

            </tr>
        </thead>
        <tbody class="body_table" >
            {assign var=g_ticket_count value=0}

            {assign var=g_bo_ticket_amount value=0}
            {assign var=g_bo_gst value=0}
            {assign var=g_bo_discount value=0}
            {assign var=g_bo_comm_amount value=0}
            {assign var=g_bo_payable value=0}


            {assign var=g_ca_ticket_amount value=0}
            {assign var=g_ca_gst value=0}
            {assign var=g_ca_discount value=0}
            {assign var=g_ca_comm_amount value=0}
            {assign var=g_ca_charges value=0}
            {assign var=g_ca_share value=0}
            {assign var=g_ca_refund value=0}

            {foreach item=level1 from=$tickets['one'] key=t}          

                {assign var=ticket_count value=0}

                {assign var=bo_ticket_amount value=0}
                {assign var=bo_gst value=0}
                {assign var=bo_discount value=0}
                {assign var=bo_comm_amount value=0}
                {assign var=bo_payable value=0}


                {assign var=ca_ticket_amount value=0}
                {assign var=ca_gst value=0}
                {assign var=ca_discount value=0}
                {assign var=ca_comm_amount value=0}
                {assign var=ca_charges value=0}
                {assign var=ca_share value=0}
                {assign var=ca_refund value=0}

                {assign var=first_iter value=1}

                {foreach item=level2 from=$level1 key=k}                    
                    {if $level2->ticket_status_code == "BO" || $level2->ticket_status_code == "PBL"}

                        {if $first_iter == 1}
                            {assign var=first_iter value=0}
                        {/if}

                        {assign var="ticket" value=$level2}
                        <tr class="row-{$ticket->ticket_code}">                    
                            <td align="center">{$ticket->travel_date|date_format:$ns_date_format}</td>     
                            <td align="center">{$ticket->transaction_date|date_format:$ns_date_format}</td>

                            <td align="left" nowrap="">{($ticket->from_station_name|cat:" to "|cat:$ticket->to_station_name)|truncate:30}</td>                                        


                            <td align="center">{$ticket->ticket_code}</td>                            
                            <td align="center">{$ticket->ticket_status_code}</td>
                            <td align="right">{$ticket->seat_count}</td>

                            {if $ticket->ticket_status_code == "BO" || $ticket->ticket_status_code == "PBL"}
                                <td align="right">{$ticket->ticket_amount|number_format:2}</td> 
                                <td align="right">{$ticket->ac_bus_tax|number_format:2 }</td> 
                                <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                <td align="right">{$ticket->commission_amount|number_format:2}</td>
                                <td align="right">
                                    {assign var="payable" value=$ticket->ticket_amount+$ticket->ac_bus_tax-$ticket->addons_amount-$ticket->commission_amount}
                                    {$payable|number_format:2}
                                </td>                                
                            {else}
                                <td align="right">0.00</td>
                                <td align="right">0.00</td>                                       
                                <td align="right">0.00</td> 
                                <td align="right">0.00</td> 
                                <td align="right">0.00</td> 
                            {/if}
                        </tr>

                        {assign var=ticket_count value=$ticket_count+$ticket->seat_count} 

                        {if $ticket->ticket_status_code == "BO" || $ticket->ticket_status_code == "PBL" }
                            {assign var=bo_ticket_amount value=$bo_ticket_amount+$ticket->ticket_amount}
                            {assign var=bo_gst value=$bo_gst+$ticket->ac_bus_tax}
                            {assign var=bo_discount value=$bo_discount+$ticket->addons_amount}
                            {assign var=bo_comm_amount value=$bo_comm_amount+$ticket->commission_amount}
                            {assign var=bo_payable value=$bo_payable+$payable}
                        {/if}

                        {if $ticket->ticket_status_code == "CA" }
                            {assign var=ca_ticket_amount value=$ca_ticket_amount+$ticket->ticket_amount}
                            {assign var=ca_gst value=$ca_gst+$ticket->ac_bus_tax}
                            {assign var=ca_discount value=$ca_discount+$ticket->addons_amount}
                            {assign var=ca_comm_amount value=$ca_comm_amount+$ticket->commission_amount}
                            {assign var=ca_charges value=$ca_charges+$ticket->cancellation_charges}
                            {assign var=ca_share value=$ca_share+$ticket->cancel_commission}
                            {assign var=ca_refund value=$ca_refund+$ticket->refund_amount+$ticket->revoke_commission_amount}
                        {/if}

                        {if $ticket->ticket_status_code == "TCA" }
                            {assign var=ca_refund value=$ca_refund+$ticket->refund_amount+$ticket->revoke_commission_amount+$ticket->ac_bus_tax}
                        {/if}
                    {/if}
                {/foreach}
                {if $first_iter == 0}

                    {assign var=g_ticket_count value=$g_ticket_count+$ticket_count} 

                    {assign var=g_bo_ticket_amount value=$g_bo_ticket_amount+$bo_ticket_amount}
                    {assign var=g_bo_gst value=$g_bo_gst+$bo_gst}
                    {assign var=g_bo_discount value=$g_bo_discount+$bo_discount}
                    {assign var=g_bo_comm_amount value=$g_bo_comm_amount+$bo_comm_amount}
                    {assign var=g_bo_payable value=$g_bo_payable+$bo_payable}

                    {assign var=g_ca_ticket_amount value=$g_ca_ticket_amount+$ca_ticket_amount}
                    {assign var=g_ca_gst value=$g_ca_gst+$ca_gst}
                    {assign var=g_ca_discount value=$g_ca_discount+$ca_discount}
                    {assign var=g_ca_comm_amount value=$g_ca_comm_amount+$ca_comm_amount}
                    {assign var=g_ca_charges value=$g_ca_charges+$ca_charges}
                    {assign var=g_ca_share value=$g_ca_share+$ca_share}
                    {assign var=g_ca_refund value=$g_ca_refund+$ca_refund}
                {/if}
            {/foreach}  
            <tr style="font-weight:bold">
                <td colspan="5" class="bold" align="right">Grand Total</td>
                <td align="right">{$g_ticket_count}</td>

                <td align="right">{$g_bo_ticket_amount|number_format:2}</td>
                <td   align="right">{$g_bo_gst|number_format:2}</td>
                <td align="right">{$g_bo_discount|number_format:2}</td>
                <td align="right">{$g_bo_comm_amount|number_format:2}</td>
                <td  align="right">{$g_bo_payable|number_format:2}</td>              
            </tr>



        </tbody>
    </table> 
</div>     

<div style="font-size: 10px;"><b>Cancellation</b></div>
<div class="overflow-x-auto">
    <table border="0.5" cellspacing="0" cellpadding="2" id="dt_adv_booking_report_table" class="table table-bordered " >
        <thead>
            <tr  style="background-color:#64b92a; color: #fff;">
                <td align="center">Travel Date</td>
                <td align="center">Transaction Date</td>
                <td align="center">Route</td>
                <td align="center">PNR</td>                 
                <td align="center">Ticket Status</td>
                <td align="center">Seat<br/>Count</td>

                <td align="center">Fare</td> 
                <td align="center">GST</td> 
                <td align="center">Discount</td>
                <td align="center">Commission</td>                
                <td align="center">Cncl Charges</td>
                <td align="center">Cncl Share</td>
                <td align="left">Refund</td>  

            </tr>
        </thead>
        <tbody class="body_table" >
            {assign var=g_ticket_count value=0}

            {assign var=g_bo_ticket_amount value=0}
            {assign var=g_bo_gst value=0}
            {assign var=g_bo_discount value=0}
            {assign var=g_bo_comm_amount value=0}
            {assign var=g_bo_payable value=0}


            {assign var=g_ca_ticket_amount value=0}
            {assign var=g_ca_gst value=0}
            {assign var=g_ca_discount value=0}
            {assign var=g_ca_comm_amount value=0}
            {assign var=g_ca_charges value=0}
            {assign var=g_ca_share value=0}
            {assign var=g_ca_refund value=0}

            {foreach item=level1 from=$tickets['one'] key=t}          

                {assign var=ticket_count value=0}

                {assign var=bo_ticket_amount value=0}
                {assign var=bo_gst value=0}
                {assign var=bo_discount value=0}
                {assign var=bo_comm_amount value=0}
                {assign var=bo_payable value=0}


                {assign var=ca_ticket_amount value=0}
                {assign var=ca_gst value=0}
                {assign var=ca_discount value=0}
                {assign var=ca_comm_amount value=0}
                {assign var=ca_charges value=0}
                {assign var=ca_share value=0}
                {assign var=ca_refund value=0}

                {assign var=first_iter value=1}

                {foreach item=level2 from=$level1 key=k}                    
                    {if $level2->ticket_status_code == "CA" || $level2->ticket_status_code == "TCA"}

                        {if $first_iter == 1}
                            {assign var=first_iter value=0}
                        {/if}

                        {assign var="ticket" value=$level2}
                        <tr class="row-{$ticket->ticket_code}">                    
                            <td align="center">{$ticket->travel_date|date_format:$ns_date_format}</td>     
                            <td align="center">{$ticket->transaction_date|date_format:$ns_date_format}</td>

                            <td align="left" nowrap="">{($ticket->from_station_name|cat:" to "|cat:$ticket->to_station_name)|truncate:30}</td>                                        

                            <td align="center">{$ticket->ticket_code}</td>                            
                            <td align="center">{$ticket->ticket_status_code}</td>
                            <td align="right">{$ticket->seat_count}</td>

                            {if $ticket->ticket_status_code == "CA"}
                                <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                <td align="right">{$ticket->ac_bus_tax|number_format:2}</td>
                                <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                <td align="right">{$ticket->commission_amount|number_format:2}</td>
                                <td align="right">{$ticket->cancellation_charges|number_format:2}</td>
                                <td align="right">{$ticket->cancel_commission|number_format:2}</td>
                                <td align="right">{($ticket->refund_amount + $ticket->revoke_commission_amount)|number_format:2}</td>
                            {else if $ticket->ticket_status_code == "TCA"}
                                <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                <td align="right">{$ticket->ac_bus_tax|number_format:2}</td>
                                <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                <td align="right">{$ticket->commission_amount|number_format:2}</td>
                                <td align="right">{$ticket->cancellation_charges|number_format:2}</td>
                                <td align="right">{$ticket->cancel_commission|number_format:2}</td>
                                <td align="right">{($ticket->ticket_amount+$ticket->ac_bus_tax-$ticket->addons_amount-$ticket->commission_amount)|number_format:2}</td>
                            {else}
                                <td align="right">0.00</td>
                                <td align="right">0.00</td>
                                <td align="right">0.00</td> 
                                <td align="right">0.00</td>
                                <td align="right">0.00</td> 
                                <td align="right">0.00</td>
                                <td align="right">0.00</td>
                            {/if}
                        </tr>

                        {assign var=ticket_count value=$ticket_count+$ticket->seat_count} 

                        {if $ticket->ticket_status_code == "BO" || $ticket->ticket_status_code == "PBL" }
                            {assign var=bo_ticket_amount value=$bo_ticket_amount+$ticket->ticket_amount}
                            {assign var=bo_gst value=$bo_gst+$ticket->ac_bus_tax}
                            {assign var=bo_discount value=$bo_discount+$ticket->addons_amount}
                            {assign var=bo_comm_amount value=$bo_comm_amount+$ticket->commission_amount}
                            {assign var=bo_payable value=$bo_payable+$payable}
                        {/if}

                        {if $ticket->ticket_status_code == "CA" }
                            {assign var=ca_ticket_amount value=$ca_ticket_amount+$ticket->ticket_amount}
                            {assign var=ca_gst value=$ca_gst+$ticket->ac_bus_tax}
                            {assign var=ca_discount value=$ca_discount+$ticket->addons_amount}
                            {assign var=ca_comm_amount value=$ca_comm_amount+$ticket->commission_amount}
                            {assign var=ca_charges value=$ca_charges+$ticket->cancellation_charges}
                            {assign var=ca_share value=$ca_share+$ticket->cancel_commission}
                            {assign var=ca_refund value=$ca_refund+$ticket->refund_amount+$ticket->revoke_commission_amount}
                        {/if}

                        {if $ticket->ticket_status_code == "TCA" }
                            {assign var=ca_refund value=$ca_refund+$ticket->refund_amount+$ticket->revoke_commission_amount+$ticket->ac_bus_tax}
                        {/if}
                    {/if}
                {/foreach}
                {if $first_iter == 0}

                    {assign var=g_ticket_count value=$g_ticket_count+$ticket_count} 

                    {assign var=g_bo_ticket_amount value=$g_bo_ticket_amount+$bo_ticket_amount}
                    {assign var=g_bo_gst value=$g_bo_gst+$bo_gst}
                    {assign var=g_bo_discount value=$g_bo_discount+$bo_discount}
                    {assign var=g_bo_comm_amount value=$g_bo_comm_amount+$bo_comm_amount}
                    {assign var=g_bo_payable value=$g_bo_payable+$bo_payable}

                    {assign var=g_ca_ticket_amount value=$g_ca_ticket_amount+$ca_ticket_amount}
                    {assign var=g_ca_gst value=$g_ca_gst+$ca_gst}
                    {assign var=g_ca_discount value=$g_ca_discount+$ca_discount}
                    {assign var=g_ca_comm_amount value=$g_ca_comm_amount+$ca_comm_amount}
                    {assign var=g_ca_charges value=$g_ca_charges+$ca_charges}
                    {assign var=g_ca_share value=$g_ca_share+$ca_share}
                    {assign var=g_ca_refund value=$g_ca_refund+$ca_refund}
                {/if}
            {/foreach}  
            <tr style="font-weight:bold">
                <td colspan="5" class="bold" align="right">Grand Total</td>
                <td align="right">{$g_ticket_count}</td>

                <td  align="right">{$g_ca_ticket_amount|number_format:2}</td> 
                <td  align="right">{$g_ca_gst|number_format:2}</td>
                <td align="right">{$g_ca_discount|number_format:2}</td>
                <td align="right">{$g_ca_comm_amount|number_format:2}</td>
                <td align="right">{$g_ca_charges|number_format:2}</td>
                <td align="right">{$g_ca_share|number_format:2}</td>
                <td align="right">{$g_ca_refund|number_format:2}</td>                
            </tr>



        </tbody>
    </table> 
</div>    