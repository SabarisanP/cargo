<table class="" width="95%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Payment Receipt</td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span> 
            {$smarty.request.from|date_format:$ns_date_format}  to {$smarty.request.to|date_format:$ns_date_format} {if $smarty.request.date_option == 1} DOJ {else} DOB {/if}</td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$tickets['date']|date_format:$ns_date_format} {$tickets['date']|date_format:$ns_time_format}</td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Booked By : </span>
        {$tickets['username']}</td>
        <td width="50%" align="right"><span class="bold">Created By : </span> {$tickets['user']} </td>
    </tr>
</table>
<div align="left"   class="table table-responsive" id="adv-report-grid">
    <h5><b>Booking</b></h5>
    <table id="dt_adv_booking_report_table" class="table table-bordered " >
        <thead>
            <tr class="success">
                <td align="center">PNR</td>
                <td align="center">Route</td> 
                <td align="center">Transaction Date</td>
                <td align="center">Travel Date</td>
                <td align="center">Seat Name</td>
                <td align="center">No. of Tickets</td>
                <td align="center">Transaction Amount</td>
                <td align="center">Agent Commission</td>
                <td align="center">Balance Amount</td>
            </tr>

        </thead>
        <tbody class="body_table" >

            {foreach item=level1 from=$tickets['one'] key=t}          


                {if $tickets['group_by']==""}
                    {if $t != ''}
                    <tr>
                        <td colspan="18" class="bold" align="left" >
                            {$t|date_format:$ns_date_format}
                        </td>
                    </tr>
                    {/if}
                {/if} 

                {foreach item=level2 from=$level1 key=k}                    

                    {if $tickets['group_by']==""}
                        {assign var="ticket" value=$level2}
                        {if $ticket->ticket_code !=''}
                            <tr class="row-{$ticket->ticket_code}">                    
                                <td align="left">{$ticket->ticket_code}</td>   
                                <td align="left" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td>                                        
                                <td align="center">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
                                <td align="center">{$ticket->travel_date}</td>
                                <td align="left" width="100">{$ticket->seat_name}</td>
                                <td align="center" width="100">{$ticket->seat_count}</td>
                                <td align="right" width="100">{$ticket->ticket_amount}</td>
                                <td align="right" width="100">{$ticket->commission_amount}</td>
                                <td align="right" width="100">{$ticket->net_amount}</td>
                            </tr>
                            {assign var="bo_tk" value="`$bo_tk+$ticket->seat_count`"}
                            {assign var="bo_fr" value="`$bo_fr+$ticket->ticket_amount`"}
                            {assign var="bo_co" value="`$bo_co+$ticket->commission_amount`"}
                            {assign var="bo_re" value="`$bo_re+$ticket->net_amount`"}
                        {/if}


                    {else}       
                        {if $t != ''}
                            <tr>
                                <td colspan="18" class="bold" align="left" >
                                    {$t|date_format:$ns_date_format}
                                </td>
                            </tr>
                        {/if}


                        {foreach item=secondlevelindex from=$level2 key=k2} 
                            <tr>
                                <td colspan="17" class="bold" align="left"> 
                                    {$k2}           
                                </td>
                            </tr>

                            {foreach item=ticket from=$secondlevelindex key=k2_1}
                                <tr class="row-{$ticket->ticket_code}">                    
                                    <td align="left">{$ticket->ticket_code}</td>   
                                    <td align="left" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td>                                        
                                    <td align="center">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
                                    <td align="center">{$ticket->travel_date}</td>
                                    <td align="left" width="100">{$ticket->seat_name}</td>
                                    <td align="center" width="100">{$ticket->seat_count}</td>
                                    <td align="right" width="100">{$ticket->ticket_amount}</td>
                                    <td align="right" width="100">{$ticket->commission_amount}</td>
                                    <td align="right" width="100">{$ticket->net_amount}</td>
                                </tr>
                                {assign var="bo_tk" value="`$bo_tk+$ticket->seat_count`"}
                                {assign var="bo_fr" value="`$bo_fr+$ticket->ticket_amount`"}
                                {assign var="bo_co" value="`$bo_co+$ticket->commission_amount`"}
                                {assign var="bo_re" value="`$bo_re+$ticket->net_amount`"}
                            {/foreach}                                
                        {/foreach}
                    {/if}
                {/foreach}
            {/foreach}  
            <tr class="active">
                <td colspan="5" class="bold" align="right">Sub Total</td>
                <td  align="center"  class="">{$bo_tk}</td>                
                <td  align="right"  class="">{$bo_fr|number_format:2}</td>
                <td  align="right" class="">{$bo_co|number_format:2}</td>
                <td align="right" class="">{$bo_re|number_format:2}</td>
            </tr>
        </tbody>
    </table>                


    <h5><b>Cancellation</b></h5>
    <table id="dt_adv_booking_report_table" class="table table-bordered " >
        <thead>
            <tr class="success">
                <td align="center" >PNR</td> 
                <td align="center">Route</td> 
                <td align="center">Transaction Date</td>
                <td align="center">Travel Date</td>
                <td align="center" >Seat Name</td> 
                <td align="center" >No. of Tickets</td>
                <td align="center" >Transaction Amount</td>
                <td align="center" >Revoke Commission</td>
                <td align="center" >Cancellation Charges</td>
                <td align="center" >Cancel Service Charge</td>
                <td align="center" >Refund</td>
            </tr>

        </thead>
        <tbody class="body_table" >



            {foreach item=level1 from=$tickets['one1'] key=t}          
                {if $tickets['group_by']==""}
                   {if $t != ''}
                    <tr>
                        <td colspan="18" class="bold" align="left" >
                            {$t|date_format:$ns_date_format}
                        </td>
                    </tr>
                    {/if}
                {/if} 
                {foreach item=level2 from=$level1 key=k}                    
                    {if $tickets['group_by']==""}
                        {assign var="ticket" value=$level2}
                        {if $ticket->ticket_code !=''}
                            <tr class="row-{$ticket->ticket_code}">                    
                                <td align="left">{$ticket->ticket_code}</td>   
                                <td align="left" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td>                                        
                                <td align="center">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
                                <td align="center">{$ticket->travel_date}</td>
                                <td align="left" width="100">{$ticket->seat_name}</td>
                                <td align="center" width="100">{$ticket->seat_count}</td>
                                <td align="right" width="100">{$ticket->ticket_amount}</td>
                                <td align="right" width="100">{$ticket->revoke_commission_amount}</td>
                                <td align="right" width="100">{$ticket->cancellation_charges}</td>
                                <td align="right" width="100">{$ticket->cancel_commission}</td>
                                <td align="right" width="100">{$ticket->refund_amount}</td>
                            </tr>
                            {assign var="ca_tk" value="`$ca_tk+$ticket->seat_count`"}
                            {assign var="bo_fr1" value="`$bo_fr1+$ticket->ticket_amount`"}
                            {assign var="bo_co1" value="`$bo_co1+$ticket->revoke_commission_amount`"}
                            {assign var="bo_ca1" value="`$bo_ca1+$ticket->cancellation_charges`"}
                            {assign var="bo_com" value="`$bo_com+$ticket->cancel_commission`"}
                            {assign var="bo_re1" value="`$bo_re1+$ticket->refund_amount`"}

                        {/if}

                    {else}       
                       {if $t != ''}
                    <tr>
                        <td colspan="18" class="bold" align="left" >
                            {$t|date_format:$ns_date_format}
                        </td>
                    </tr>
                    {/if}


                        {foreach item=secondlevelindex from=$level2 key=k2} 
                            <tr>
                                <td colspan="17" class="bold" align="left"> 
                                    {$k2}           
                                </td>
                            </tr>
                            {foreach item=ticket from=$secondlevelindex key=k2_1}
                                <tr class="row-{$ticket->ticket_code}">                    
                                    <td align="left">{$ticket->ticket_code}</td>   
                                    <td align="left" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td>                                        
                                    <td align="center">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
                                    <td align="center">{$ticket->travel_date}</td>
                                    <td align="left" width="100">{$ticket->seat_name}</td>
                                    <td align="center" width="100">{$ticket->seat_count}</td>
                                    <td align="right" width="100">{$ticket->ticket_amount}</td>
                                    <td align="right" width="100">{$ticket->revoke_commission_amount}</td>
                                    <td align="right" width="100">{$ticket->cancellation_charges}</td>
                                    <td align="right" width="100">{$ticket->cancel_commission}</td>
                                    <td align="right" width="100">{$ticket->refund_amount}</td>
                                </tr>
                                {assign var="ca_tk" value="`$ca_tk+$ticket->seat_count`"}
                                {assign var="bo_fr1" value="`$bo_fr1+$ticket->ticket_amount`"}
                                {assign var="bo_co1" value="`$bo_co1+$ticket->revoke_commission_amount`"}
                                {assign var="bo_ca1" value="`$bo_ca1+$ticket->cancellation_charges`"}
                                {assign var="bo_com" value="`$bo_com+$ticket->cancel_commission`"}
                                {assign var="bo_re1" value="`$bo_re1+$ticket->refund_amount`"}

                            {/foreach}                                
                        {/foreach}
                    {/if}
                {/foreach}
            {/foreach} 
            <tr class="active">
                <td colspan="5" class="bold" align="right">Sub Total</td>
                <td  align="center"  class="">{$ca_tk}</td>
                <td  align="right"  class="">{$bo_fr1|number_format:2}</td>
                <td  align="right" class="">{$bo_co1|number_format:2}</td>
                <td align="right" class="">{$bo_ca1|number_format:2}</td>
                <td align="right" class="">{$bo_com|number_format:2}</td>
                <td align="right" class="">{$bo_re1|number_format:2}</td>
            </tr>
        </tbody>
    </table>                    
    <h5><b>Summary</b></h5>
    <table class="table table-bordered" style="width:40%;float:left">
        <tr>
            <td colspan="2"  class="bold text-center" >Booking</td>
            <td colspan="2" class="bold text-center" >Cancellation</td>
        </tr>
        <tr>
            <td class="bold" >Fare</td>
            <td class="text-right">{$bo_fr|number_format:2}</td>
            <td class="bold">Fare</td>                                                            
            <td class="text-right">{$bo_fr1|number_format:2}</td>
        </tr>
        <tr>
            <td class="bold" >Commission </td>
            <td class="text-right">{$bo_co|number_format:2}</td>
            <td class="bold">Charges</td>                                                            
            <td class="text-right">{$bo_ca1|number_format:2}</td>
        </tr>
        <tr>
            <td class="bold" ></td>
            <td class="bold"></td>
            <td class="bold">Revoke Commission</td>                                                            
            <td class="text-right">{$bo_co1|number_format:2}</td>
        </tr>
        <tr>
            <td class="bold" ></td>
            <td class="bold"></td>
            <td class="bold">Agent Cancellation Charges</td>                                                            
            <td class="text-right">{$bo_com|number_format:2}</td>
        </tr>
        <tr>
            <td class="bold" >Total (A)</td>
            <td class="text-right">{$bo_re|number_format:2}</td>
            <td class="bold">Total (B)</td>                                                            
            <td class="text-right">
                {$stot = $bo_re1-$bo_com}
                {$stot|number_format:2}
            </td>
        </tr>        
        <tr>
            <td class="bold" colspan="3" >Net Payable (A-B)</td>                                                                                           
            <td class="bold text-right">
                {$tot = $bo_re-($bo_re1-$bo_com)}
                {$tot|number_format:2}
            </td>
        </tr>
    </table>
    

    <table style="position: relative; left:40%;">
        <tr>
            <td align="right"><span class="bold">Agent Name </span></td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
            <td align="right"><span class="bold">Signature</span> </td>
        </tr>
        <tr><td>&nbsp;</td></tr>
    </table>
   
 
    <div class="clear_fix_both text-right">
        <button class="btn btn-default" onclick="PaymentPdf()"><i class="fa fa-download fa-lg"></i>Download</button>
    </div>        
</div>
