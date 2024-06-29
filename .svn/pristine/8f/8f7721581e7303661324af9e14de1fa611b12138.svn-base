<style>                        
    .bordered td{ border:1px solid #080808; }
    .bordered .noborder{ border:1px solid #fff; }
    .bold{ font-weight:bold; }
</style>

<table width="100%" cellpadding="3">
    <tr>
        <td align="center" style="font-weight:bold">{$namespace_name}</td>
    </tr>
    <tr>
    	<td align="center" class="bold">Payment Voucher</td>
    </tr>
</table>

<table width="100%" cellpadding="3">
    <tr>
        <td align="right">{$summary->transactionDate|date_format:$ns_date_format}</td>        	
    </tr>
</table>

<table width="100%" cellpadding="3" class="table bordered ">
    <tbody class="body_table" >
    <tr>
    	<td align="left" width="15%"  class="bold">Payment Code</td>
        <td align="left" width="35%" >{$summary->code}</td>
        
        <td align="left" width="15%"  class="bold">Agent Name</td>
        <td align="left" width="35%">{$summary->user->name}</td>        	
    </tr>
    <tr>
    	<td align="left" width="15%" class="bold">Amount</td>
        <td align="left" width="35%">{$summary->transactionAmount|number_format:2}</td>
        
        <td align="left" width="15%" class="bold">Transaction Mode</td>
        <td align="left" width="35%">{$summary->transactionMode->name}</td>        	
    </tr>
    <tr>
    	<td align="left"  width="15%" class="bold">Acknowledge Status</td>
        <td align="left" width="35%">{$summary->acknowledgeStatus->name}</td>
        
        <td align="left" width="15%"  class="bold">Amount Received</td>
        <td align="left" width="35%">{$summary->amountReceivedDate|date_format:$ns_date_format}</td>        	
    </tr>
    <tr>
    	<td align="left"  width="15%" class="bold">Remarks</td>
        <td align="left" colspan="3" width="85%">{$summary->remarks}</td>        	
    </tr>
    </tbody>
</table>
    
<br><br><b>Summary</b><br><br>
<table class="bordered" cellpadding="3">
    <tr>
        <td colspan="2"  class="bold text-center" >Booking</td>
        <td colspan="2" class="bold text-center" >Cancellation</td>
    </tr>
    <tr>
        <td class="bold" >Fare</td>
        <td class="text-right">{$bo_fare|number_format:2}</td>
        <td class="bold">Fare</td>                                                            
        <td class="text-right">{$ca_fare|number_format:2}</td>
    </tr>
    <tr>
        <td class="bold" >Commission </td>
        <td class="text-right">{$bo_commi|number_format:2}</td>
        <td class="bold">Charges</td>                                                            
        <td class="text-right">{$ca_charge|number_format:2}</td>
    </tr>
    <tr>
        <td class="bold" ></td>
        <td class="bold"></td>
        <td class="bold">Revoke Commission</td>                                                            
        <td class="text-right">{$ca_revoke|number_format:2}</td>
    </tr>
    <tr>
        <td class="bold" ></td>
        <td class="bold"></td>
        <td class="bold">Agent Cancellation Charges</td>                                                            
        <td class="text-right">{$ca_ag_charge|number_format:2}</td>
    </tr>
    <tr>
        <td class="bold" >Total (A)</td>
        <td class="text-right">{($bo_fare-$bo_commi)|number_format:2}</td>
        <td class="bold">Total (B)</td>                                                            
        <td class="text-right">{($ca_refund-$c_ag_charges)|number_format:2}</td>
    </tr>        
    <tr>
        <td class="bold" colspan="3" >Net Payable (A-B)</td>                                                                                           
        <td class="bold text-right">{(($bo_fare-$bo_commi)-($ca_refund - $c_ag_charges))|number_format:2}</td>
    </tr>
</table>    

<br><br>
<b>Booking Transactions</b> <br><br>
<table class="bordered" cellpadding="3"  >
    <thead>
        <tr class="success">
            <td align="center" class="bold">PNR</td>
            <td align="center" class="bold">Route</td> 
            <td align="center" class="bold">Transaction Date</td>
            <td align="center" class="bold">Travel Date</td>            
            <td align="center" class="bold">No. of Tickets</td>
            <td align="center" class="bold">Transaction Amount</td>
            <td align="center" class="bold">Agent Commission</td>
            <td align="center" class="bold">Net Payable</td>
        </tr>

    </thead>
    <tbody class="body_table" >

        {foreach item=ticket from=$tickets['booking'] key=t}    
            <tr class="row-{$ticket->ticketCode}">                    
                <td align="center">{$ticket->ticketCode}</td>   
                <td align="center" nowrap="">{$ticket->fromStation->name} -  {$ticket->toStation->name}</td>                                        
                <td align="center">{$ticket->transactionDate|date_format:$ns_date_format}</td>
                <td align="center">{$ticket->travelDate|date_format:$ns_date_format}</td>                
                <td align="center" >{$ticket->seatCount}</td>
                <td align="center" >{$ticket->ticketAmount|number_format:2}</td>
                <td align="center" >{$ticket->commissionAmount|number_format:2}</td>
                <td align="center" >{($ticket->ticketAmount - $ticket->commissionAmount)|number_format:2}</td>
            </tr>                        
        {/foreach}  
        
        <tr>
            <td colspan="5" class="bold" align="right">Sub Total</td>                          
            <td  align="center"  class="">{$bo_fare|number_format:2}</td>
            <td  align="center" class="">{$bo_commi|number_format:2}</td>
            <td align="center" class="">{($bo_fare-$bo_commi)|number_format:2}</td>
        </tr>
        
    </tbody>
</table>  
        
<br><br><b>Cancellation Transactions</b> <br><br>
<table class="bordered" cellpadding="3" >
    <thead>
        <tr class="success">
            <td align="center" >PNR</td> 
            <td align="center">Route</td> 
            <td align="center">Transaction Date</td>
            <td align="center">Travel Date</td>
            <td align="center" >No. of Tickets</td>
            <td align="center" >Transaction Amount</td>
            <td align="center" >Revoke Commission</td>
            <td align="center" >Cancellation Charges</td>
            <td align="center" >Cancel Service Charge</td>
            <td align="center" >Refund</td>
        </tr>
    </thead>
    <tbody class="body_table" >

        {foreach item=ticket from=$tickets['cancell'] key=t}                       
            <tr class="row-{$ticket->ticketCode}">                    
                <td align="left">{$ticket->ticketCode}</td>   
                <td align="center" nowrap="">{$ticket->fromStation->name} -  {$ticket->toStation->name}</td>                                        
                <td align="center">{$ticket->transactionDate|date_format:$ns_date_format}</td>
                <td align="center">{$ticket->travelDate|date_format:$ns_date_format}</td>
                <td align="center" >{$ticket->seatCount}</td>
                <td align="right">{$ticket->ticketAmount|number_format:2}</td>
                <td align="right">{$ticket->revokeCancelCommissionAmount|number_format:2}</td>
                <td align="right">{$ticket->cancellationChargeAmount|number_format:2}</td>
                <td align="right">{$ticket->agentCancellationChargeAmount|number_format:2}</td>
                <td align="right">{$ticket->refundAmount|number_format:2}</td>
            </tr>                        
        {/foreach} 
        
        <tr class="active">
            <td colspan="5" class="bold" align="right">Sub Total</td>
            <td  align="right"  class="">{$ca_fare|number_format:2}</td>
            <td  align="right" class="">{$ca_revoke|number_format:2}</td>
            <td align="right" class="">{$ca_charge|number_format:2}</td>
            <td align="right" class="">{$ca_ag_charge|number_format:2}</td>
            <td align="right" class="">{$ca_refund|number_format:2}</td>
        </tr>
    </tbody>
</table>          

