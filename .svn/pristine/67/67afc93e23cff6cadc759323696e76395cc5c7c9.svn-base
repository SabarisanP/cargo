<table class="" width="95%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Revenue Report Summary</span></td>
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
    
<h5><b>Summary</b></h5>
<table class="table table-bordered" style="width:50%;">
    <tr class="success">
        <td class="bold text-left" >Category</td>
        <td class="bold text-center" >Amount (1)</td>
        <td class="bold text-center" >Discount (2)</td>
        <td class="bold text-center" >AC Bus GST (3)</td>
        <td class="bold text-center" >Commission with GST (4)</td>
        <td class="bold text-center" >Total (1-2+3-4)</td>
    </tr>
    <tr>
        <td class="text-left">Booking (A)</td>
        <td class="text-right">{$tickets['bo_fare']|number_format:2}</td>
        <td class="text-right">{$tickets['bo_discount']|number_format:2}</td>
        <td class="text-right">{$tickets['bo_ac_tax']|number_format:2}</td>
        <td class="text-right">{$tickets['bo_comission']|number_format:2}</td>
        <td class="text-right">
            {assign var=a value=$tickets['bo_fare']-$tickets['bo_discount']+$tickets['bo_ac_tax']-$tickets['bo_comission']}
            {$a|number_format:2}
        </td>
    </tr>
    <tr>
        <td class="text-left">Cancel (B)</td>
        <td class="text-right">{$tickets['ca_fare']|number_format:2}</td>
        <td class="text-right">{$tickets['ca_discount']|number_format:2}</td>
        <td class="text-right">{$tickets['ca_ac_tax']|number_format:2}</td>
        <td class="text-right">{$tickets['ca_comission']|number_format:2}</td>
        <td class="text-right">
            {assign var=b value=$tickets['ca_fare']-$tickets['ca_discount']+$tickets['ca_ac_tax']-$tickets['ca_comission']}
            {$b|number_format:2}
        </td>
    </tr>
    <tr>
        <td class="text-left">Cancel Charges (C)</td>
        <td class="text-right">{$tickets['ca_charges']|number_format:2}</td>
        <td class="text-right">0.00</td>
        <td class="text-right">0.00</td>
        <td class="text-right">{$tickets['ca_share']|number_format:2}</td>
        <td class="text-right">
            {assign var=c value=$tickets['ca_charges']-$tickets['ca_share']}
            {$c|number_format:2}
        </td>
    </tr>
    <tr class="">
        <td class="bold text-left">Net Amount (A-B+C)</td>
        <td class="bold text-right">{($tickets['bo_fare']-$tickets['ca_fare']+$tickets['ca_charges'])|number_format:2}</td>
        <td class="bold text-right">{($tickets['bo_discount']-$tickets['ca_discount'])|number_format:2}</td>
        <td class="bold text-right">{($tickets['bo_ac_tax']-$tickets['ca_ac_tax'])|number_format:2}</td>
        <td class="bold text-right">{($tickets['bo_comission']-$tickets['ca_comission']+$tickets['ca_share'])|number_format:2}</td>
        <td class="bold text-right">
            {($a-$b+$c)|number_format:2}
        </td>
    </tr>
</table>

<h5><b>Booking</b></h5>
<table id="dt_adv_booking_report_table" class="table table-bordered " >
    <thead>
        <tr class="success">
            <td align="left">User</td>
            <td align="left">User Group</td>                                 
            <td align="center">No. of Seats</td>
            <td align="center">Fare</td>
            <td align="center">AC Bus GST</td>
            <td align="center">Discount</td>
            <td align="center">Commission</td>
            <td align="center">Payable</td>
        </tr>

    </thead>
    <tbody class="body_table" >
        
        {assign var=tot_booking_seat_count value=0}
        {assign var=tot_booking_total_amount value=0}
        {assign var=tot_ac_tax_total_amount value=0}
        {assign var=tot_addon_total_amount value=0}
        {assign var=tot_booking_commission_total value=0}
        {assign var=tot_booking_balance_amount value=0}
            
        {foreach item=level1 from=$bookings key=t}
                
            {foreach item=level2 from=$level1 key=k}
                {assign var=user_first_name value=""}
                {assign var=user_group value=""}
                {assign var=booking_seat_count value=0}
                {assign var=booking_total_amount value=0}
                {assign var=ac_tax_total_amount value=0}
                {assign var=addon_total_amount value=0}
                {assign var=booking_commission_total value=0}
                {assign var=booking_balance_amount value=0}

                {foreach item=trans from=$level2 key=f}                        
                    {assign var=user_first_name value=$trans->user_first_name}
                    {assign var=user_group value=$trans->user_group_name}
                    {assign var=booking_seat_count value=$booking_seat_count+$trans->seat_count}
                    {assign var=booking_total_amount value=$booking_total_amount+$trans->ticket_amount}
                    {assign var=ac_tax_total_amount value=$ac_tax_total_amount+$trans->ac_bus_tax}
                    {assign var=addon_total_amount value=$addon_total_amount+$trans->addons_amount}
                    {assign var=booking_commission_total value=$booking_commission_total+$trans->commission_amount}
                    {assign var=booking_balance_amount value=$booking_balance_amount+($trans->ticket_amount+$trans->ac_bus_tax-$trans->addons_amount-$trans->commission_amount)}
                {/foreach}

                <tr>                    
                    <td align="left" nowrap="">{$user_first_name|ucfirst}</td>   
                    <td align="left" nowrap="">{$user_group}</td>                                        
                    <td align="right">{$booking_seat_count}</td>
                    <td align="right">{$booking_total_amount|number_format:2}</td>
                    <td align="right">{$ac_tax_total_amount|number_format:2}</td>
                    <td align="right">{$addon_total_amount|number_format:2}</td>
                    <td align="right">{$booking_commission_total|number_format:2}</td>
                    <td align="right">{$booking_balance_amount|number_format:2}</td>
                </tr> 
                
                {assign var=tot_booking_seat_count value=$tot_booking_seat_count+$booking_seat_count}
                {assign var=tot_booking_total_amount value=$tot_booking_total_amount+$booking_total_amount}
                {assign var=tot_ac_tax_total_amount value=$tot_ac_tax_total_amount+$ac_tax_total_amount}
                {assign var=tot_booking_commission_total value=$tot_booking_commission_total+$booking_commission_total}
                {assign var=tot_addon_total_amount value=$tot_addon_total_amount+$addon_total_amount}
                {assign var=tot_booking_balance_amount value=$tot_booking_balance_amount+$booking_balance_amount}
                
            {/foreach}
            
            
            
        {/foreach}  
        
        <tr class="active">                    
            <td align="right" colspan="2" class="bold">Total</td>                   
            <td align="right" class="bold">{$tot_booking_seat_count}</td>
            <td align="right" class="bold">{$tot_booking_total_amount|number_format:2}</td>
            <td align="right" class="bold">{$tot_ac_tax_total_amount|number_format:2}</td>
            <td align="right" class="bold">{$tot_addon_total_amount|number_format:2}</td>
            <td align="right" class="bold">{$tot_booking_commission_total|number_format:2}</td>            
            <td align="right" class="bold">{$tot_booking_balance_amount|number_format:2}</td>
        </tr>  

    </tbody>
</table>                


<h5><b>Cancellation</b></h5>

<table id="dt_adv_booking_report_table" class="table table-bordered " >
    <thead>
        <tr class="success">
            <td align="left">User</td>
            <td align="left">User Group</td>                                 
            <td align="center">No. of Seats</td>
            <td align="center">Fare</td>
            <td align="center">AC Bus Tax</td>
            <td align="center">Discount</td>
            <td align="center">Commission</td>
            <td align="center">Cancellation Charges</td>            
            <td align="center">Agent Charges</td>
            <td align="center">Refund</td>
        </tr>

    </thead>
    <tbody class="body_table" >
        
        {assign var=tot_cancel_seat_count value=0}
        {assign var=tot_cancel_total_amount value=0}
        {assign var=tot_cancel_charges_total value=0}
        {assign var=tot_cancel_ac_bus_tax_amount value=0}
        {assign var=tot_cancel_addon_amount value=0}
        {assign var=tot_cancel_commission value=0} 
        {assign var=tot_cancel_agent_charges value=0}
        {assign var=tot_cancel_refund value=0}

        {foreach item=level1 from=$cancels key=t}
            {foreach item=level2 from=$level1 key=k}
                {assign var=user_first_name value=""}
                {assign var=user_group value=""}                    

                {assign var=cancel_seat_count value=0}
                {assign var=cancel_total_amount value=0}
                {assign var=cancel_addon_amount value=0}
                {assign var=cancel_charges_total value=0}
                {assign var=cancel_commission value=0} 
                {assign var=cancel_ac_bus_tax_amount value=0}
                {assign var=cancel_agent_charges value=0}
                {assign var=cancel_refund value=0}

                {foreach item=trans from=$level2 key=f}                        
                    {assign var=user_first_name value=$trans->user_first_name}
                    {assign var=user_group value=$trans->user_group_name}

                    {assign var=cancel_seat_count value=$cancel_seat_count+$trans->seat_count}
                    {assign var=cancel_total_amount value=$cancel_total_amount+$trans->ticket_amount}
                    {assign var=cancel_charges_total value=$cancel_charges_total+$trans->cancellation_charges}
                    {assign var=cancel_ac_bus_tax_amount value=$cancel_ac_bus_tax_amount+$trans->ac_bus_tax}
                    {assign var=cancel_commission value=$cancel_commission+$trans->commission_amount} 
                    {assign var=cancel_addon_amount value=$cancel_addon_amount+$trans->addons_amount}
                    {assign var=cancel_agent_charges value=$cancel_agent_charges+$trans->cancel_commission}
                    {assign var=cancel_refund value=$cancel_refund+$trans->refund_amount}
                {/foreach}

                <tr>                    
                    <td align="left" nowrap="">{$user_first_name|ucfirst}</td>   
                    <td align="left" nowrap="">{$user_group}</td>                                        
                    <td align="right">{$cancel_seat_count}</td>
                    <td align="right">{$cancel_total_amount|number_format:2}</td>
                    <td align="right">{$cancel_ac_bus_tax_amount|number_format:2}</td>
                    <td align="right">{$cancel_addon_amount|number_format:2}</td>
                    <td align="right">{$cancel_commission|number_format:2}</td>
                    <td align="right">{$cancel_charges_total|number_format:2}</td>                    
                    <td align="right">{$cancel_agent_charges|number_format:2}</td>
                    <td align="right">{$cancel_refund|number_format:2}</td>
                </tr>  
                
                {assign var=tot_cancel_seat_count value=$tot_cancel_seat_count+$cancel_seat_count}
                {assign var=tot_cancel_total_amount value=$tot_cancel_total_amount+$cancel_total_amount}
                {assign var=tot_cancel_charges_total value=$tot_cancel_charges_total+$cancel_charges_total}
                {assign var=tot_cancel_ac_bus_tax_amount value=$tot_cancel_ac_bus_tax_amount+$cancel_ac_bus_tax_amount}
                {assign var=tot_cancel_commission value=$tot_cancel_commission+$cancel_commission}
                {assign var=tot_cancel_addon_amount value=$tot_cancel_addon_amount+$cancel_addon_amount}
                {assign var=tot_cancel_agent_charges value=$tot_cancel_agent_charges+$cancel_agent_charges}
                {assign var=tot_cancel_refund value=$tot_cancel_refund+$cancel_refund}
            
            {/foreach}
            
            

        {/foreach}  

        <tr class="active">
            <td align="right" colspan="2" class="bold">Total</td>                                        
            <td align="right" class="bold">{$tot_cancel_seat_count}</td>
            <td align="right" class="bold">{$tot_cancel_total_amount|number_format:2}</td>
            <td align="right" class="bold">{$tot_cancel_ac_bus_tax_amount|number_format:2}</td>
            <td align="right" class="bold">{$tot_cancel_addon_amount|number_format:2}</td>            
            <td align="right" class="bold">{$tot_cancel_commission|number_format:2}</td>
            <td align="right" class="bold">{$tot_cancel_charges_total|number_format:2}</td>
            <td align="right" class="bold">{$tot_cancel_agent_charges|number_format:2}</td>
            <td align="right" class="bold">{$tot_cancel_refund|number_format:2}</td>
        </tr>
    </tbody>
</table> 


<div class="clear_fix_both text-right">
    <button class="btn btn-default" onclick="downloadRevenueReport()"><i class="fa fa-download fa-lg"></i> Download</button>
    <button class="btn btn-default hide" onclick="downloadRevenueReportSummary()"><i class="fa fa-download fa-lg"></i> Detailed List</button>
</div> 
    

