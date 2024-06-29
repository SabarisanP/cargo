<table border="1">
    <tr>
        <td  colspan="4" align="center"><b>Occupancy & Income Report</b>
    </tr>
    <tr>
        <td colspan="2">
            Report Date : {$smarty.request.from_date|date_format:$ns_date_format}  to {$smarty.request.to_date|date_format:$ns_date_format}  DOJ 
        </td>
        <td colspan="2" align="right">Report At : {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
</table>

{if $smarty.request.groupby==1}    

    {foreach item=service from=$rows key=s}         
    <h5><b>{$meta[$s]['schedule_name']} ({$meta[$s]['service_number']})</b> , {$meta[$s]['total_seats']} seats</h5>    
    <table border="1">
        <thead>
            <tr style="background-color:#64b92a; color: #fff;">
                <td align="center">Date</td>
                <td align="center">Vehicle</td>
                <td align="center">Booked Count</td> 
                <td align="center">Booked Amount</td>
                <td align="center">Cancel Count</td>
                <td align="center">Cancel Amount</td>
                <td align="center">Travelled Count</td>
                <td align="center">Travelled Amount</td>
                <td align="center">Cancelled Charges</td>
                <td align="center">Agent Share</td>
                <td align="center">Cancelled Income</td>
                <td align="center">Total Income</td>
                <td align="center">GST</td>
                <td align="center">Total Income With GST</td>
            </tr>

        </thead>
        <tbody class="body_table" >
            
            {assign var="t_booked_seats" value=0}
            {assign var="t_booked_amount" value=0}
            {assign var="t_cancel_seats" value=0}
            {assign var="t_cancel_amount" value=0}
            {assign var="t_travel_seats" value=0}
            {assign var="t_travel_amount" value=0}
            {assign var="t_cancel_charge" value=0}
            {assign var="t_agent_share" value=0}
            {assign var="t_cancel_income" value=0}
            {assign var="t_total_income" value=0}
            {assign var="t_travel_gst" value=0}
            {assign var="t_net_income" value=0}
            
            {foreach item=day from=$service key=date}
                
                {assign var="travel_amount" value=$day['booked_amount']-$day['cancel_amount']}
                {assign var="travel_gst" value=$day['booked_gst']-$day['cancel_gst']}
                {assign var="cancel_income" value=$day['cancel_charges']-$day['agent_share']}
                
                <tr>                    
                    <td align="left">{$date}</td>   
                    <td align="center">{$day['registration_number']}</td> 
                    <td align="center">{$day['booked_seats']}</td>                                        
                    <td align="right">{$day['booked_amount']|inr_format}</td>
                    <td align="center">{$day['cancel_seats']}</td>
                    <td align="right">{$day['cancel_amount']|inr_format}</td>
                    <td align="center">{$day['booked_seats']-$day['cancel_seats']}</td>
                    <td align="right">{$travel_amount|inr_format}</td>
                    <td align="right">{$day['cancel_charges']|inr_format}</td>
                    <td align="right">{$day['agent_share']|inr_format}</td>
                    <td align="right">{$cancel_income|inr_format}</td>
                    <td align="right">{($travel_amount+$cancel_income)|inr_format}</td>
                    <td align="right">{$travel_gst|inr_format}</td>
                    <td align="right">{($travel_amount+$cancel_income+$travel_gst)|inr_format}</td>
                </tr> 
                
                {assign var="t_booked_seats" value=$t_booked_seats+$day['booked_seats']}
                {assign var="t_booked_amount" value=$t_booked_amount+$day['booked_amount']}
                {assign var="t_cancel_seats" value=$t_cancel_seats+$day['cancel_seats']}
                {assign var="t_cancel_amount" value=$t_cancel_amount+$day['cancel_amount']}
                {assign var="t_travel_seats" value=$t_travel_seats+($day['booked_seats']-$day['cancel_seats'])}
                {assign var="t_travel_amount" value=$t_travel_amount+$travel_amount}
                {assign var="t_cancel_charge" value=$t_cancel_charge+$day['cancel_charges']}
                {assign var="t_agent_share" value=$t_agent_share+$day['agent_share']}
                {assign var="t_cancel_income" value=$t_cancel_income+$cancel_income}
                {assign var="t_total_income" value=$t_total_income+($travel_amount+$cancel_income)}
                {assign var="t_travel_gst" value=$t_travel_gst+$travel_gst}
                {assign var="t_net_income" value=$t_net_income+($travel_amount+$cancel_income+$travel_gst)}
                
            {/foreach} 
            
            <tr style="background-color:#bbbbbb; color: #fff;">
                <td align="left" colspan="2">Total</td>   
                <td align="center">{$t_booked_seats}</td>                                        
                <td align="right">{$t_booked_amount|inr_format}</td>
                <td align="center">{$t_cancel_seats}</td>
                <td align="right">{$t_cancel_amount|inr_format}</td>
                <td align="center">{$t_travel_seats}</td>
                <td align="right">{$t_travel_amount|inr_format}</td>
                <td align="right">{$t_cancel_charge|inr_format}</td>
                <td align="right">{$t_agent_share|inr_format}</td>
                <td align="right">{$t_cancel_income|inr_format}</td>
                <td align="right">{$t_total_income|inr_format}</td>
                <td align="right">{$t_travel_gst|inr_format}</td>
                <td align="right">{$t_net_income|inr_format}</td>
            </tr>
            
        </tbody>
    </table>                
    {/foreach}       

{else}
    {if $smarty.request.revenue_type == 'GROSS'}
    <table border="1">
        <thead>
            <tr style="background-color:#64b92a; color: #fff;">
                <td align="center">Schedule Name</td>
                <td align="center">Trip Count</td>
                <td align="center">Booked Count</td> 
                <td align="center">Booked Amount</td>
                <td align="center">Cancel Count</td>
                <td align="center">Cancel Amount</td>
                <td align="center">Travelled Count</td>
                <td align="center">Travelled Amount</td>
                <td align="center">Cancelled Charges</td>
                <td align="center">Agent Share</td>
                <td align="center">Cancelled Income</td>
                <td align="center">Total Income</td>
                <td align="center">GST</td>
                <td align="center">Total Income With GST</td>
            </tr>

        </thead>
        <tbody class="body_table" > 
            {assign var="t_trip_count" value=0}
            {assign var="t_booked_seats" value=0}
            {assign var="t_booked_amount" value=0}
            {assign var="t_cancel_seats" value=0}
            {assign var="t_cancel_amount" value=0}
            {assign var="t_travel_seats" value=0}
            {assign var="t_travel_amount" value=0}
            {assign var="t_cancel_charge" value=0}
            {assign var="t_agent_share" value=0}
            {assign var="t_cancel_income" value=0}
            {assign var="t_total_income" value=0}
            {assign var="t_travel_gst" value=0}
            {assign var="t_net_income" value=0}
            
            {foreach item=day from=$rows key=s}
                
                {assign var="travel_amount" value=$day['booked_amount']-$day['cancel_amount']}
                {assign var="travel_gst" value=$day['booked_gst']-$day['cancel_gst']}
                {assign var="cancel_income" value=$day['cancel_charges']-$day['agent_share']}
                
                <tr>                    
                    <td align="left">{$day['schedule_name']} (<span class='warning-text'>{$day['service_number']}</span>) , {$day['total_seats']} seats</td>   
                    <td align="center">{$day['trip_count']}</td>
                    <td align="center">{$day['booked_seats']}</td>                                        
                    <td align="right">{$day['booked_amount']|inr_format}</td>
                    <td align="center">{$day['cancel_seats']}</td>
                    <td align="right">{$day['cancel_amount']|inr_format}</td>
                    <td align="center">{$day['booked_seats']-$day['cancel_seats']}</td>
                    <td align="right">{$travel_amount|inr_format}</td>
                    <td align="right">{$day['cancel_charges']|inr_format}</td>
                    <td align="right">{$day['agent_share']|inr_format}</td>
                    <td align="right">{$cancel_income|inr_format}</td>
                    <td align="right">{($travel_amount+$cancel_income)|inr_format}</td>
                    <td align="right">{$travel_gst|inr_format}</td>
                    <td align="right">{($travel_amount+$cancel_income+$travel_gst)|inr_format}</td>
                </tr> 
                
                {assign var="t_trip_count" value=$t_trip_count+$day['trip_count']}
                {assign var="t_booked_seats" value=$t_booked_seats+$day['booked_seats']}
                {assign var="t_booked_amount" value=$t_booked_amount+$day['booked_amount']}
                {assign var="t_cancel_seats" value=$t_cancel_seats+$day['cancel_seats']}
                {assign var="t_cancel_amount" value=$t_cancel_amount+$day['cancel_amount']}
                {assign var="t_travel_seats" value=$t_travel_seats+($day['booked_seats']-$day['cancel_seats'])}
                {assign var="t_travel_amount" value=$t_travel_amount+$travel_amount}
                {assign var="t_cancel_charge" value=$t_cancel_charge+$day['cancel_charges']}
                {assign var="t_agent_share" value=$t_agent_share+$day['agent_share']}
                {assign var="t_cancel_income" value=$t_cancel_income+$cancel_income}
                {assign var="t_total_income" value=$t_total_income+($travel_amount+$cancel_income)}
                {assign var="t_travel_gst" value=$t_travel_gst+$travel_gst}
                {assign var="t_net_income" value=$t_net_income+($travel_amount+$cancel_income+$travel_gst)}
                
            {/foreach} 
            
            <tr style="background-color:#bbbbbb; color: #fff;">
                <td align="left">Total</td>   
                <td align="center">{$t_trip_count}</td>
                <td align="center">{$t_booked_seats}</td>                                        
                <td align="right">{$t_booked_amount|inr_format}</td>
                <td align="center">{$t_cancel_seats}</td>
                <td align="right">{$t_cancel_amount|inr_format}</td>
                <td align="center">{$t_travel_seats}</td>
                <td align="right">{$t_travel_amount|inr_format}</td>
                <td align="right">{$t_cancel_charge|inr_format}</td>
                <td align="right">{$t_agent_share|inr_format}</td>
                <td align="right">{$t_cancel_income|inr_format}</td>
                <td align="right">{$t_total_income|inr_format}</td>
                <td align="right">{$t_travel_gst|inr_format}</td>
                <td align="right">{$t_net_income|inr_format}</td>
            </tr>
            
        </tbody>
    </table>                
    {elseif $smarty.request.revenue_type == 'NET'}
    <table border="1">
        <thead>
            <tr style="background-color:#64b92a; color: #fff;">
                <td align="center">Schedule Name</td>
                <td align="center">Trip Count</td>
                <td align="center">Booked Count</td> 
                <td align="center">Booked Amount</td>
                <td align="center">Cancel Count</td>
                <td align="center">Cancel Amount</td>
                <td align="center">Travelled Count</td>
                <td align="center">Travelled Amount</td>
                <td align="center">Travelled Commission</td>
                <td align="center">Cancelled Charges</td>
                <td align="center">Agent Share</td>
                <td align="center">Cancelled Income</td>
                <td align="center">Net Revenue</td>
            </tr>

        </thead>
        <tbody class="body_table" >     
            {assign var="t_trip_count" value=0}
            {assign var="t_booked_seats" value=0}
            {assign var="t_booked_amount" value=0}
            {assign var="t_cancel_seats" value=0}
            {assign var="t_cancel_amount" value=0}
            {assign var="t_travel_seats" value=0}
            {assign var="t_travel_amount" value=0}
            {assign var="t_cancel_charge" value=0}
            {assign var="t_agent_share" value=0}
            {assign var="t_cancel_income" value=0}
            {assign var="t_total_income" value=0}
            {assign var="t_travel_gst" value=0}
            {assign var="t_net_income" value=0}

            {foreach item=day from=$rows key=s}

                {assign var="travel_amount" value=$day['booked_amount']-$day['cancel_amount']}
                {assign var="cancel_income" value=$day['cancel_charges']-$day['agent_share']}
                {assign var="travel_comm" value=$day['booked_comm']-$day['revoke_comm']}

                <tr>                    
                    <td align="left">{$day['schedule_name']} (<span class='warning-text'>{$day['service_number']}</span>), {$day['total_seats']} seats</td>   
                    <td align="center">{$day['trip_count']}</td> 
                    <td align="center">{$day['booked_seats']}</td>                                                            
                    <td align="right">{$day['booked_amount']|inr_format}</td>
                    <td align="center">{$day['cancel_seats']}</td>
                    <td align="right">{$day['cancel_amount']|inr_format}</td>
                    <td align="center">{$day['booked_seats']-$day['cancel_seats']}</td>
                    <td align="right">{$travel_amount|inr_format}</td>
                    <td align="right">{$travel_comm|inr_format}</td>
                    <td align="right">{$day['cancel_charges']|inr_format}</td>
                    <td align="right">{$day['agent_share']|inr_format}</td>
                    <td align="right">{$cancel_income|inr_format}</td>
                    <td align="right">{($day['trans_amount'] - $day['trans_cancel_amt'] - $day['booked_comm'])|inr_format}</td>
                </tr> 

                {assign var="t_trip_count" value=$t_trip_count+$day['trip_count']}
                {assign var="t_booked_seats" value=$t_booked_seats+$day['booked_seats']}
                {assign var="t_booked_amount" value=$t_booked_amount+$day['booked_amount']}
                {assign var="t_cancel_seats" value=$t_cancel_seats+$day['cancel_seats']}
                {assign var="t_cancel_amount" value=$t_cancel_amount+$day['cancel_amount']}
                {assign var="t_travel_seats" value=$t_travel_seats+($day['booked_seats']-$day['cancel_seats'])}
                {assign var="t_travel_amount" value=$t_travel_amount+$travel_amount}
                {assign var="t_travel_comm" value=$t_travel_comm+$travel_comm}
                {assign var="t_cancel_charge" value=$t_cancel_charge+$day['cancel_charges']}
                {assign var="t_agent_share" value=$t_agent_share+$day['agent_share']}
                {assign var="t_cancel_income" value=$t_cancel_income+$cancel_income}
                {assign var="t_net_revenue" value=$t_net_revenue+($day['trans_amount'] - $day['trans_cancel_amt'] - $day['booked_comm'])}
            {/foreach} 

            <tr style="background-color:#bbbbbb; color: #fff;">
                <td align="left">Total</td>   
                <td align="center">{$t_trip_count}</td> 
                <td align="center">{$t_booked_seats}</td>                                        
                <td align="right">{$t_booked_amount|inr_format}</td>
                <td align="center">{$t_cancel_seats}</td>
                <td align="right">{$t_cancel_amount|inr_format}</td>
                <td align="center">{$t_travel_seats}</td>
                <td align="right">{$t_travel_amount|inr_format}</td>
                <td align="right">{$t_travel_comm|inr_format}</td>
                <td align="right">{$t_cancel_charge|inr_format}</td>
                <td align="right">{$t_agent_share|inr_format}</td>
                <td align="right">{$t_cancel_income|inr_format}</td>
                <td align="right">{$t_net_revenue|inr_format}</td>
            </tr>

        </tbody>
    </table>    
    {/if}
</div>
{/if}   