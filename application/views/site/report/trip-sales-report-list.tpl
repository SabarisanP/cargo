<table class="" width="97%">
    <tr>
        <td  colspan="6" align="center"><h5><b>Trip Sales Report</b></h5></td>
    </tr>
    <tr>
        <td align="left" class="bold">Trip</td>
        <td width="1%"align="center" class="bold">:</td>
        <td align="left">{$smarty.request.trip_name}</td>
        <td align="left" class="bold">Travel Date</td>
        <td width="1%"align="center" class="bold">:</td>
        <td align="left">{$smarty.request.travel_date|date_format:$ns_date_format}</td>
    </tr>
    <tr>
        <td align="left" class="bold">Vehicle & Driver</td>
        <td width="1%"align="center" class="bold">:</td>
        <td align="left">{$info->busVehicle->registationNumber}, {$info->driverName}</td>
        <td align="left" class="bold">Report Date/Time</td>
        <td width="1%"align="center" class="bold">:</td>
        <td align="left">{$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>

</table>

<div align="left"   class="table table-responsive" id="adv-report-grid">
    
    <h6><b>User Summary</b></h6>    
    <table class="table table-bordered " style="width:80%;" >
        <thead>
            <tr class="success">  
                <td align="center" rowspan="2">User</td> 
                <td align="center" colspan="6">Booking <span class="note text-muted text-dark">( Cancel tickets not included )</span></td> 
                <td align="center" colspan="5">Cancel</td>
                <td align="center" rowspan="2">Net Payable (G=E+F)</td> 
            </tr>
            <tr class="success">  
                <td align="center">Seat Count</td> 
                <td align="center">Fare (A)</td> 
                <td align="center">GST (B)</td> 
                <td align="center">Discount (C)</td> 
                <td align="center">Comission (D)</td> 
                <td align="center">Net Payable (E=A+B-C-D)</td> 
                
                
                <td align="center">Seat Count</td>
                <td align="center">Fare</td>
                <td align="center">GST</td>
                <td align="center">Refund</td> 
                <td align="center">Can Revenue (F)</td> 
            </tr>
        </thead>
        <tbody class="body_table" >
            {assign var=bo_seat_count value=0}
            {assign var=bo_fare value=0}
            {assign var=bo_ac_tax value=0}
            {assign var=bo_discount value=0}
            {assign var=bo_comission value=0}
            {assign var=bo_payable value=0}
            
            {assign var=ca_seat_count value=0}
            {assign var=ca_fare value=0}
            {assign var=ca_ac_tax value=0}
            {assign var=ca_refund value=0}
            {assign var=ca_charges value=0}
            {assign var=net_payable value=0}
            {foreach item=user from=$settlement key=username}                
                <tr>          
                    <td>{$username}</td>
                    <td align="right">{$user['bo_seats'] + 0}</td>
                    <td align="right">{$user['bo_fare']|number_format:2}</td>
                    <td align="right">{$user['bo_ac_tax']|number_format:2}</td>
                    <td align="right">{$user['bo_discount']|number_format:2}</td>
                    <td align="right">{$user['bo_comission']|number_format:2}</td>
                    <td align="right">{$user['bo_payable']|number_format:2}</td>
                    <td align="right">{$user['ca_seats'] + 0}</td>
                    <td align="right">{$user['ca_fare']|number_format:2}</td>
                    <td align="right">{$user['ca_ac_tax']|number_format:2}</td>
                    <td align="right">{$user['ca_refund']|number_format:2}</td>
                    <td align="right">{($user['ca_charges'] - $user['ca_share'])|number_format:2}</td>
                    <td align="right">{$user['payable']|number_format:2}</td>
                </tr>
                        
                {assign var=bo_seat_count value=$bo_seat_count+$user['bo_seats']}
                {assign var=bo_fare value=$bo_fare+$user['bo_fare']}
                {assign var=bo_ac_tax value=$bo_ac_tax+$user['bo_ac_tax']}
                {assign var=bo_discount value=$bo_discount+$user['bo_discount']}
                {assign var=bo_comission value=$bo_comission+$user['bo_comission']}
                {assign var=bo_payable value=$bo_payable+$user['bo_payable']}
                {assign var=ca_seat_count value=$ca_seat_count+$user['ca_seats']}
                {assign var=ca_fare value=$ca_fare+$user['ca_fare']}
                {assign var=ca_ac_tax value=$ca_ac_tax+$user['ca_ac_tax']}
                {assign var=ca_refund value=$ca_refund+$user['ca_refund']}
                {assign var=ca_charges value=$ca_charges+($user['ca_charges'] - $user['ca_share'])}
                {assign var=net_payable value=$net_payable+$user['payable']}
            {/foreach}

            <tr class="active">
                <td class="bold" align="right">Total</td>
                <td class="bold" align="right" >{$bo_seat_count}</td> 
                <td class="bold" align="right" >{$bo_fare|number_format:2}</td> 
                <td class="bold" align="right" >{$bo_ac_tax|number_format:2}</td> 
                <td class="bold" align="right" >{$bo_discount|number_format:2}</td> 
                <td class="bold" align="right" >{$bo_comission|number_format:2}</td> 
                <td class="bold" align="right" >{$bo_payable|number_format:2}</td> 
                <td class="bold" align="right" >{$ca_seat_count}</td> 
                <td class="bold" align="right" >{$ca_fare|number_format:2}</td>
                <td class="bold" align="right" >{$ca_ac_tax|number_format:2}</td> 
                <td class="bold" align="right" >{$ca_refund|number_format:2}</td> 
                <td class="bold" align="right" >{$ca_charges|number_format:2}</td> 
                <td class="bold" align="right" >{$net_payable|number_format:2}</td>
            </tr>
        </tbody>
    </table>  
          
    <h6><b>Bookings</b> <span class="note text-muted">( Cancel tickets not included )</span> </h6>   
    <table class="table table-bordered" style="width:95%;">
        <thead>
            <tr class="success">  
                <td align="center">User</td> 
                <td align="center">PNR</td>
                <td align="center">Route</td>
                <td align="center">Seats</td>
                <td align="center">Seat Count</td>
                <td align="center">Fare (A)</td>
                <td align="center">GST (B)</td>
                <td align="center">Discount (C)</td> 
                <td align="center">Comission (D)</td> 
                <td align="center">Net Payable (E=A+B-C-D)</td> 
            </tr>
        </thead>
        <tbody class="body_table" >
            {assign var=bo_seat_count value=0}                
            {assign var=bo_ticket_amount value=0}
            {assign var=bo_ac_bus_tax value=0}
            {assign var=bo_discount value=0}
            {assign var=bo_comm_amount value=0}
            {assign var=bo_payable value=0}
                
            {foreach item=ticket from=$tickets }  
                {if $ticket->transaction_type == "BO" || $ticket->transaction_type == "PBL"}
                    <tr class="row-{$ticket->ticket_code}">                    
                        <td>{$ticket->user_first_name}</td>
                        <td align="center">{$ticket->ticket_code}</td>   
                        <td align="left" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td>
                        <td align="left">{$ticket->seat_name}</td>
                        <td align="right">{$ticket->seat_count}</td>
                        <td align="right">{$ticket->ticket_amount|number_format:2}</td> 
                        <td align="right">{$ticket->ac_bus_tax|number_format:2}</td>
                        <td align="right">{$ticket->addon_amount|number_format:2}</td>
                        <td align="right">{$ticket->commission_amount|number_format:2}</td>
                        <td align="right">
                            {assign var="payable" value=$ticket->ticket_amount+$ticket->ac_bus_tax-$ticket->addon_amount-$ticket->commission_amount}
                            {$payable|number_format:2}
                        </td>
                    </tr>
                    {assign var=bo_seat_count value=$bo_seat_count+$ticket->seat_count}                
                    {assign var=bo_ticket_amount value=$bo_ticket_amount+$ticket->ticket_amount}
                    {assign var=bo_ac_bus_tax value=$bo_ac_bus_tax+$ticket->ac_bus_tax}
                    {assign var=bo_discount value=$bo_discount+$ticket->addon_amount}
                    {assign var=bo_comm_amount value=$bo_comm_amount+$ticket->commission_amount}
                    {assign var=bo_payable value=$bo_payable+$payable}
                {/if}
            {/foreach}

            <tr class="active">
                <td class="bold" align="right" colspan="4">Total</td>
                <td class="bold" align="right" >{$bo_seat_count}</td> 
                <td class="bold" align="right" >{$bo_ticket_amount|number_format:2}</td>
                <td class="bold" align="right" >{$bo_ac_bus_tax|number_format:2}</td>
                <td class="bold" align="right" >{$bo_discount|number_format:2}</td>
                <td class="bold" align="right" >{$bo_comm_amount|number_format:2}</td>
                <td class="bold" align="right" >{$bo_payable|number_format:2}</td>
            </tr>
        </tbody>
    </table> 
    
    <h6><b>Cancels</b></h6>    
    <table class="table table-bordered" style="width:95%;">
        <thead>
            <tr class="success">  
                <td align="center">User</td> 
                <td align="center">User Group</td> 
                <td align="center">PNR</td>
                <td align="center">Route</td>
                <td align="center">Cancel Date</td>
                <td align="center">Seats</td>
                <td align="center">Seat Count</td>                
                <td align="center">Fare</td> 
                <td align="center">GST</td> 
                <td align="center">Refund</td> 
                <td align="center">Can Revenue (F)</td> 
            </tr>
        </thead>
        <tbody class="body_table" >
            {assign var=ca_seat_count value=0}                
            {assign var=ca_ticket_amount value=0}
            {assign var=ca_ac_tax value=0}
            {assign var=ca_refund_amount value=0}
            {assign var=ca_charges_amount value=0}
            {assign var=ca_sharing_amount value=0}
                
            {foreach item=ticket from=$tickets }  
                {if $ticket->transaction_type == "CA"}
                    <tr class="row-{$ticket->ticket_code}">                    
                        <td>{$ticket->user_first_name}</td>
                        <td>{$ticket->user_group_name}</td>
                        <td align="center">{$ticket->ticket_code}</td>   
                        <td align="left" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td>
                        <td align="center">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
                        <td align="left">{$ticket->seat_name}</td>
                        <td align="right">{$ticket->seat_count}</td>                        
                        <td align="right">{$ticket->ticket_amount|number_format:2}</td> 
                        <td align="right">{$ticket->ac_bus_tax|number_format:2}</td>
                        <td align="right">
                            {assign var="refund" value=$ticket->ticket_amount+$ticket->ac_bus_tax-$ticket->cancellation_charges}
                            {$refund|number_format:2}
                        </td>
                        <td align="right">{($ticket->cancellation_charges-$ticket->cancel_commission)|number_format:2}</td>
                    </tr>
                    
                    {assign var=ca_seat_count value=$ca_seat_count+$ticket->seat_count}                
                    {assign var=ca_ticket_amount value=$ca_ticket_amount+$ticket->ticket_amount}
                    {assign var=ca_ac_tax value=$ca_ac_tax+$ticket->ac_bus_tax}
                    {assign var=ca_refund_amount value=$ca_refund_amount+$refund}
                    {assign var=ca_charges_amount value=$ca_charges_amount + ($ticket->cancellation_charges-$ticket->cancel_commission)}
                {/if}
            {/foreach}

            <tr class="active">
                <td class="bold" align="right" colspan="6">Total</td>
                <td class="bold" align="right" >{$ca_seat_count}</td> 
                <td class="bold" align="right" >{$ca_ticket_amount|number_format:2}</td>
                <td class="bold" align="right" >{$ca_ac_tax|number_format:2}</td>
                <td class="bold" align="right" >{$ca_refund_amount|number_format:2}</td>
                <td class="bold" align="right" >{$ca_charges_amount|number_format:2}</td>
            </tr>
        </tbody>
    </table> 
    
    <h6><b>Summary</b></h6>    
    <table class="table table-bordered " style="width:95%;" >
        <thead>
            <tr class="success">  
                <td align="center">Travelled Seats</td> 
                <td align="center">Travelled Fare (A)</td>
                <td align="center">Travelled GST (B)</td>
                <td align="center">Travelled Discount (C)</td>
                <td align="center">Travelled Comission (D)</td>                
                <td align="center">Cancel Revenue (E)</td>
                <td align="center">Net Revenue (F=A+B-C-D+E)</td>
            </tr>
        </thead>
        <tbody class="body_table" >
            <tr>
                <td class="" align="right" >{$bo_seat_count}</td>
                <td class="" align="right" >{$bo_ticket_amount|number_format:2}</td> 
                <td class="" align="right" >{$bo_ac_bus_tax|number_format:2}</td> 
                <td class="" align="right" >{$bo_discount|number_format:2}</td> 
                <td class="" align="right" >{$bo_comm_amount|number_format:2}</td>
                <td class="" align="right" >{$ca_charges_amount|number_format:2}</td>
                <td class="" align="right" >                    
                    {($bo_payable+$ca_charges_amount)|number_format:2}
                </td>
            </tr>
        </tbody>
    </table>        
            
</div>

<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <!--<button class="btn btn-default" onclick="exportTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button> -->
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>       

