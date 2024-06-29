<style>                        
    .bordered td{ border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px }
    .bordered .noborder{ border:1px solid #fff; }
    .bold{ font-weight:bold; }
</style>



<table class="" width="100%" cellpadding="3">
    <tr>
        <td width="100%" align="center" style="font-weight:bold">{$namespace_name}</td>                            
    </tr>
    <tr>
        <td  colspan="2" align="center"><span class="bold">Revenue Report Details</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span> 
            {$smarty.request.from|date_format:$ns_date_format}  to {$smarty.request.to|date_format:$ns_date_format} {if $smarty.request.date_option == 1} DOJ {else} DOB {/if}</td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>    

<table>
    <tr>
        <td>&nbsp;</td>                            
    </tr>
    <tr>
        <td size="12" style="font-weight:bold">Booking</td>                            
    </tr>
    <tr>
        <td>&nbsp;</td>                            
    </tr>
</table>
<table width="100%" class="bordered" cellpadding="3" >
    
    <tr class="success">
        <td align="center" width="10%">PNR</td>
        <td align="center" width="10%">User</td> 
        <td align="center" width="10%">Route</td> 
        <td align="center" width="10%">Txn Date</td>
        <td align="center" width="10%">DOJ</td>
        <td align="center" width="10%">Seat Name</td>
        <td align="center" width="5%">Seats</td>
        <td align="center" width="8%">Fare</td>
        <td align="center" width="8%">Offer</td>
        <td align="center" width="8%">Commission</td>
        <td align="center" width="8%">Balance</td>
    </tr>

        
        {assign var=tot_booking_seat_count value=0}
        {assign var=tot_booking_total_amount value=0}
        {assign var=tot_booking_commission_total value=0}
        {assign var=tot_addon_total_amount value=0}
        {assign var=tot_booking_balance_amount value=0}
            
        {foreach item=level1 from=$bookings key=t}
            <tr>
                <td colspan="11" align="left" class="bold">{$t|date_format:$ns_date_format}</td>
            </tr>
                
            {foreach item=level2 from=$level1 key=k}
                {assign var=user_first_name value=""}
                {assign var=user_group value=""}
                {assign var=booking_seat_count value=0}
                {assign var=booking_total_amount value=0}
                {assign var=addon_total_amount value=0}
                {assign var=booking_commission_total value=0}
                {assign var=booking_balance_amount value=0}

                {foreach item=trans from=$level2 key=f} 
                    <tr class="row-{$trans->ticket_code}">                    
                        <td align="left">{$trans->ticket_code}</td>  
                        <td align="left">{$trans->user_first_name|ucfirst}</td>  
                        <td align="left" nowrap="">{$trans->from_station_name|truncate:7} - {$trans->to_station_name|truncate:7}</td>                                        
                        <td align="center">{$trans->transaction_date|date_format:$ns_date_format}</td>
                        <td align="center">{$trans->travel_date}</td>
                        <td align="left" >{$trans->seat_name}</td>
                        <td align="center" >{$trans->seat_count}</td>
                        <td align="right" >{$trans->ticket_amount}</td>
                        <td align="right" >{$trans->addons_amount}</td>
                        <td align="right" >{$trans->commission_amount}</td>
                        <td align="right" >{$trans->net_amount}</td>
                    </tr>
                    {assign var=user_first_name value=$trans->user_first_name}
                    {assign var=user_group value=$trans->user_group_name}
                    {assign var=booking_seat_count value=$booking_seat_count+$trans->seat_count}
                    {assign var=booking_total_amount value=$booking_total_amount+$trans->ticket_amount}
                    {assign var=addon_total_amount value=$addon_total_amount+$trans->addons_amount}
                    {assign var=booking_commission_total value=$booking_commission_total+$trans->commission_amount}
                    {assign var=booking_balance_amount value=$booking_balance_amount+$trans->net_amount}
                {/foreach}

                <tr>                    
                    <td align="right" colspan="6" class="bold">Sub Total</td>                                         
                    <td align="center">{$booking_seat_count}</td>
                    <td align="right">{$booking_total_amount}</td>
                    <td align="right">{$addon_total_amount}</td>
                    <td align="right">{$booking_commission_total}</td>
                    <td align="right">{$booking_balance_amount}</td>
                </tr> 
                
                {assign var=tot_booking_seat_count value=$tot_booking_seat_count+$booking_seat_count}
                {assign var=tot_booking_total_amount value=$tot_booking_total_amount+$booking_total_amount}
                {assign var=tot_addon_total_amount value=$tot_addon_total_amount+$addon_total_amount}
                {assign var=tot_booking_commission_total value=$tot_booking_commission_total+$booking_commission_total}
                {assign var=tot_booking_balance_amount value=$tot_booking_balance_amount+$booking_balance_amount}
                
            {/foreach}
            
            
            
        {/foreach}  
        
        <tr class="active">                    
            <td align="right" colspan="6" class="bold">Total</td>                   
            <td align="center" class="bold">{$tot_booking_seat_count}</td>
            <td align="right" class="bold">{$tot_booking_total_amount|number_format:2}</td>
            <td align="right" class="bold">{$tot_addon_total_amount|number_format:2}</td>
            <td align="right" class="bold">{$tot_booking_commission_total|number_format:2}</td>
            <td align="right" class="bold">{$tot_booking_balance_amount|number_format:2}</td>
        </tr>  

   
</table>                


<table>
    <tr>
        <td>&nbsp;</td>                            
    </tr>
    <tr>
        <td size="12" style="font-weight:bold">Cancellation</td>                            
    </tr>
    <tr>
        <td>&nbsp;</td>                            
    </tr>
</table>


<table width="100%"  class="bordered" cellpadding="3" >
   
        <tr class="success">
            <td align="center" width="10%" >PNR</td>
            <td align="center" width="10%" >User</td>
            <!--<td align="center" width="13%">Route</td> -->
            <td align="center" width="10%">Txn Date</td>
            <td align="center" width="10%">DOJ</td>
            <td align="center" width="10%">Seat Name</td> 
            <td align="center" width="5%">Seats</td>
            <td align="center" width="8%">Fare</td>
            <td align="center" width="8%">Offer</td>
            <td align="center" width="8%">Revoke Commission</td>
            <td align="center" width="6%">Cancellation Charges</td>
            <td align="center" width="6%">Agent Charge</td>
            <td align="center" width="8%">Refund</td>
        </tr>

    
        
        {assign var=tot_cancel_seat_count value=0}
        {assign var=tot_cancel_total_amount value=0}
        {assign var=tot_cancel_addon_amount value=0}
        {assign var=tot_cancel_charges_total value=0}
        {assign var=tot_cancel_revoke_amount value=0}
        {assign var=tot_cancel_agent_charges value=0}
        {assign var=tot_cancel_refund value=0}

        {foreach item=level1 from=$cancels key=t}
            <tr>
                <td colspan="11" align="left" class="bold">{$t|date_format:$ns_date_format}</td>
            </tr>

            {foreach item=level2 from=$level1 key=k}
                {assign var=user_first_name value=""}
                {assign var=user_group value=""}                    

                {assign var=cancel_seat_count value=0}
                {assign var=cancel_total_amount value=0}
                {assign var=cancel_addon_amount value=0}
                {assign var=cancel_charges_total value=0}
                {assign var=cancel_revoke_amount value=0}
                {assign var=cancel_agent_charges value=0}
                {assign var=cancel_refund value=0}

                {foreach item=trans from=$level2 key=f}          
                    <tr>
                        <td align="left">{$trans->ticket_code}</td>
                        <td align="left">{$trans->user_first_name|ucfirst}</td>  
                        <!--<td align="left">{$trans->from_station_name} - {$trans->to_station_name}</td> -->
                        <td align="center">{$trans->transaction_date|date_format:$ns_date_format}</td>
                        <td align="center">{$trans->travel_date}</td>
                        <td align="left">{$trans->seat_name}</td>
                        <td align="center" >{$trans->seat_count}</td>
                        <td align="right">{$trans->ticket_amount}</td>
                        <td align="right">{$trans->addons_amount}</td>
                        <td align="right">{$trans->revoke_commission_amount}</td>
                        <td align="right">{$trans->cancellation_charges}</td>
                        <td align="right">{$trans->cancel_commission}</td>
                        <td align="right">{$trans->refund_amount}</td>
                    </tr>
                    {assign var=user_first_name value=$trans->user_first_name}
                    {assign var=user_group value=$trans->user_group_name}

                    {assign var=cancel_seat_count value=$cancel_seat_count+$trans->seat_count}
                    {assign var=cancel_total_amount value=$cancel_total_amount+$trans->ticket_amount}
                    {assign var=cancel_charges_total value=$cancel_charges_total+$trans->cancellation_charges}
                    {assign var=cancel_revoke_amount value=$cancel_revoke_amount+$trans->revoke_commission_amount}
                    {assign var=cancel_addon_amount value=$cancel_addon_amount+$trans->addons_amount}
                    {assign var=cancel_agent_charges value=$cancel_agent_charges+$trans->cancel_commission}
                    {assign var=cancel_refund value=$cancel_refund+$trans->refund_amount}
                {/foreach}

                <tr>                    
                    <td align="right" class="bold" colspan="5">Sub Total</td>                                        
                    <td align="center">{$cancel_seat_count}</td>
                    <td align="right">{$cancel_total_amount}</td>
                    <td align="right">{$cancel_addon_amount}</td>
                    <td align="right">{$cancel_charges_total}</td>
                    <td align="right">{$cancel_revoke_amount}</td>
                    <td align="right">{$cancel_agent_charges}</td>
                    <td align="right">{$cancel_refund}</td>
                </tr>  
                
                {assign var=tot_cancel_seat_count value=$tot_cancel_seat_count+$cancel_seat_count}
                {assign var=tot_cancel_total_amount value=$tot_cancel_total_amount+$cancel_total_amount}
                {assign var=tot_cancel_charges_total value=$tot_cancel_charges_total+$cancel_charges_total}
                {assign var=tot_cancel_addon_amount value=$tot_cancel_addon_amount+$cancel_addon_amount}
                {assign var=tot_cancel_revoke_amount value=$tot_cancel_revoke_amount+$cancel_revoke_amount}
                {assign var=tot_cancel_agent_charges value=$tot_cancel_agent_charges+$cancel_agent_charges}
                {assign var=tot_cancel_refund value=$tot_cancel_refund+$cancel_refund}
            
            {/foreach}
            
            

        {/foreach}  

        <tr class="active">
            <td align="right" colspan="5" class="bold">Total</td>                                        
            <td align="center" class="bold">{$tot_cancel_seat_count}</td>
            <td align="right" class="bold">{$tot_cancel_total_amount|number_format:2}</td>
            <td align="right" class="bold">{$tot_cancel_addon_amount|number_format:2}</td>
            <td align="right" class="bold">{$tot_cancel_charges_total|number_format:2}</td>
            <td align="right" class="bold">{$tot_cancel_revoke_amount|number_format:2}</td>
            <td align="right" class="bold">{$tot_cancel_agent_charges|number_format:2}</td>
            <td align="right" class="bold">{$tot_cancel_refund|number_format:2}</td>
        </tr>
    </tbody>
</table> 

<table>
    <tr>
        <td>&nbsp;</td>                            
    </tr>
    <tr>
        <td size="12" style="font-weight:bold">Summary</td>                            
    </tr>
    <tr>
        <td>&nbsp;</td>                            
    </tr>
</table>
<table class="bordered" style="width:60%;" cellpadding="3">
    <tr>
        <td colspan="2"  class="bold text-center" >Booking</td>
        <td colspan="2" class="bold text-center" >Cancellation</td>
    </tr>
    <tr>
        <td class="bold" >Fare</td>
        <td class="text-right">{$tot_booking_total_amount|number_format:2}</td>
        <td class="bold">Fare</td>                                                            
        <td class="text-right">{$tot_cancel_total_amount|number_format:2}</td>
    </tr>
    <tr>
        <td class="bold" >Commission </td>
        <td class="text-right">{$tot_booking_commission_total|number_format:2}</td>
        <td class="bold">Charges</td>                                                            
        <td class="text-right">{$tot_cancel_charges_total|number_format:2}</td>
    </tr>
    <tr>
        <td class="bold" >Offer / Discount</td>
        <td class="text-right">{$tot_addon_total_amount|number_format:2}</td>
        <td class="bold">Revoke Commission</td>                                                            
        <td class="text-right">{$tot_cancel_revoke_amount|number_format:2}</td>
    </tr>
    <tr>
        <td class="bold" ></td>
        <td class="bold"></td>
        <td class="bold">Agent Charges</td>                                                            
        <td class="text-right">{$tot_cancel_agent_charges|number_format:2}</td>
    </tr>
    <tr>
        <td class="bold" ></td>
        <td class="bold"></td>
        <td class="bold">Offer / Discount</td>                                                            
        <td class="text-right">{$tot_cancel_addon_amount|number_format:2}</td>
    </tr>
    <tr>
        <td class="bold" >Total (A)</td>
        <td class="text-right">{$tot_booking_balance_amount|number_format:2}</td>
        <td class="bold">Total Reversal(B)</td>                                                            
        <td class="text-right">
            {$stot = ($tot_cancel_refund-$tot_cancel_addon_amount)+$tot_cancel_agent_charges}
            {$stot|number_format:2}
        </td>
    </tr>        
    <tr>
        <td class="bold" colspan="3" >Net Payable (A-B)</td>                                                                                           
        <td class="bold text-right">
            {$tot = $tot_booking_balance_amount-$stot}
            {$tot|number_format:2}
        </td>
    </tr>
</table>
    

