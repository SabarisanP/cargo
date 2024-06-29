<table border="1">
    <tr style="font-weight: bold">
        <td  colspan="7" align="center"><span class="bold">Transaction Report</td>
    </tr>
    <tr style="font-weight: bold">
        <td colspan="3">
            {if $smarty.request.date_option==1} 
                Trip Date Wise 
            {else}
                Booked Date Wise
            {/if} 
            From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} </td>
        <td  colspan="4" align="right"><span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>

</table>


    <table border="1">
        <thead>
            <tr class="success" style="font-weight: bold">
                <td rowspan="2" align="center">Travel Date</td>
                <td rowspan="2" align="center">Transaction Date</td> 
                <td rowspan="2" align="center">Group Name</td>
                <td rowspan="2">User Name</td>
                <td align="center" colspan="2">Trip Details</td>
                <td align="center" rowspan="2">PNR</td> 
                <td align="center" rowspan="2">Seat Name</td> 
                <td align="center" rowspan="2">Seat Count</td>
                <td align="center" rowspan="2">Ticket Status</td>
                <td align="center" rowspan="2">PBA</td>     
                <td align="center" colspan="3">Booked Ticket Details</td> 
                <td align="center" rowspan="2">Offer</td>
                <td align="center" colspan="4">Canceled Ticket Details</td> 

            </tr>
            <tr class="success" style="font-weight: bold">                               
                <td align="center">Trip Name</td>
                <td align="center">Route</td>

                <td align="center">Fare</td>                   
                <td align="center">Comm Amt</td> 
                <td align="center">GST</td> 

                <td align="center">Fare</td> 
                <td align="center">Revoke Comm. Amt</td>                
                <td align="center">Cncl Charges</td>
                <td align="left">Refund</td>  

            </tr>
        </thead>
        <tbody class="body_table" >
            {assign var=g_ticket_count value=0}
            {assign var=g_ticket_amount value=0}
            {assign var=g_comm_amount value=0}
            {assign var=g_service_tax value=0}
            {assign var=g_ac_tax value=0}
            {assign var=g_disc value=0}
            
            {assign var=pbl_g_ticket_amount value=0}
            {assign var=cl_g_ticket_amount value=0}

            {assign var=g_c_ticket_count value=0}
            {assign var=g_c_ticket_amount value=0}
            {assign var=g_c_comm_amount value=0}
            {assign var=g_c_service_tax value=0}

            {foreach item=level1 from=$tickets['one'] key=t}          

                {assign var=ticket_count value=0}
                {assign var=ticket_amount value=0}
                {assign var=comm_amount value=0}
                {assign var=service_tax value=0}
                {assign var=ac_tax value=0}
                {assign var=disc value=0}

                {assign var=pbl_ticket_amount value=0}

                {assign var=cl_ticket_amount value=0}
                {assign var=comm_amount value=0}
                {assign var=service_tax value=0}
                {assign var=ac_tax value=0}



                {assign var=c_ticket_count value=0}
                {assign var=c_ticket_amount value=0}
                {assign var=c_comm_amount value=0}
                {assign var=c_service_tax value=0}

                {if $smarty.request.group_by_2==""}
                    <tr>
                        <td colspan="18" class="bold" align="center" style="font-weight: bold">
                            {$t}
                        </td>
                    </tr>
                {/if} 

                {foreach item=level2 from=$level1 key=k}                    

                    {if $smarty.request.group_by_2==""}
                        {assign var="ticket" value=$level2}
                        <tr class="row-{$ticket->ticket_code}">                    
                            <td width="100" align="center">{$ticket->travel_date|date_format:$ns_date_format}</td>     
                            <td align="center">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
                            <td>{$ticket->user_group_name}</td>
                            <td>{$ticket->user_name}</td>

                            <td align="center" nowrap="">{$ticket->trip_name}</td> 
                            <td align="center" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td>                                        


                            <td align="center">{$ticket->ticket_code}</td>   
                            <td align="right" width="100">{$ticket->seat_name}</td>
                            <td align="right">{$ticket->seat_count}</td>
                            <td align="right">{$ticket->ticket_status_code}</td>
                            {if $ticket->ticket_status_code == "PBL"}
                            	<td align="right">{$ticket->ticket_amount|number_format:2}</td>
                            {else} 
                                <td align="right">0.00</td>
                            {/if}                            
                            {if $ticket->ticket_status_code == "BO"}
                             	<td align="right">{$ticket->ticket_amount|number_format:2}</td>   
                                <td align="right">{$ticket->commission_amount|number_format:2}</td>                                       
                                <td align="right">{$ticket->ac_bus_tax|number_format:2 }</td> 
                            {else}
                                <td align="right">0.00</td>
                                <td align="right">0.00</td>                                       
                                <td align="right">0.00</td> 
                            {/if}
                            	<td align="right">{$ticket->addons_amount|number_format:2}</td>
                            {if $ticket->ticket_status_code == "CA"}
                                <td align="right">{$ticket->ticket_amount|number_format:2}</td>                            
                                <td align="right">{$ticket->revoke_commission_amount|number_format:2 }</td> 
                                <td align="right">{$ticket->cancellation_charges|number_format:2}</td>
                                <td align="right">{$ticket->refund_amount|number_format:2}</td>
                            {else}
                                <td align="right">0.00</td>
                                <td align="right">0.00</td> 
                                <td align="right">0.00</td>
                                <td align="right">0.00</td>
                            {/if}
                        </tr>
                        {assign var=ticket_count value=$ticket_count+$ticket->seat_count} 
                         {if $ticket->ticket_status_code == "PBL" }
                            {assign var=pbl_ticket_amount value=$pbl_ticket_amount+$ticket->ticket_amount}
                        {/if}
                        {if $ticket->ticket_status_code == "BO" }
                            {assign var=ticket_amount value=$ticket_amount+$ticket->ticket_amount}
                            {assign var=comm_amount value=$comm_amount+$ticket->commission_amount}
                        {/if}
                        {if $ticket->ticket_status_code == "CA" }
                            {assign var=cl_ticket_amount value=$cl_ticket_amount+$ticket->ticket_amount}
                        {/if}
                        
                        {assign var=service_tax value=$service_tax+$ticket->revoke_commission_amount}
                        {assign var=ac_tax value=$ac_tax+$ticket->ac_bus_tax}
                        {assign var=disc value=$disc+$ticket->addons_amount}


                        {assign var=c_comm_amount value=$c_comm_amount+$ticket->cancellation_charges}
                        {assign var=c_service_tax value=$c_service_tax+$ticket->refund_amount}



                    {else}       
                        <tr>
                            <td colspan="17" class="bold" align="center" class="active" style="font-weight: bold">
                                {$t|date_format:$ns_date_format}
                            </td>
                        </tr>
                        {assign var=ticket_count_2_t value=0}
                        {assign var=ticket_amount_2_t value=0}
                        {assign var=comm_amount_2_t value=0}
                        {assign var=service_tax_2_t value=0}
                        {assign var=ac_tax_2_t value=0}
                        {assign var=disc_2_t value=0}
						
						{assign var=pbl_ticket_amount_2_t value=0}
                        {assign var=cl_ticket_amount_2_t value=0}

                        {assign var=c_ticket_count_2_t value=0}
                        {assign var=c_ticket_amount_2_t value=0}
                        {assign var=c_comm_amount_2_t value=0}
                        {assign var=c_service_tax_2_t value=0}   

                        {foreach item=secondlevelindex from=$level2 key=k2} 
                            <tr>
                                <td colspan="17" class="bold" align="center" style="font-weight: bold"> 
                                    {$k2}           
                                </td>
                            </tr>
                            {assign var=ticket_count_2 value=0}
                            {assign var=ticket_amount_2 value=0}
                            {assign var=comm_amount_2 value=0}
                            {assign var=service_tax_2 value=0}
                            {assign var=ac_tax_2 value=0}
                            {assign var=disc_2 value=0}
							{assign var=pbl_ticket_amount_2 value=0}
                            {assign var=cl_ticket_amount_2 value=0}
                            {assign var=c_ticket_count_2 value=0}
                            {assign var=c_ticket_amount_2 value=0}
                            {assign var=c_comm_amount_2 value=0}
                            {assign var=c_service_tax_2 value=0}
                            {foreach item=ticket from=$secondlevelindex key=k2_1}
                                <tr class="row-{$ticket->ticket_code}">                    
                                    <td width="100" align="center">{$ticket->travel_date|date_format:$ns_date_format}</td>     
                                    <td align="center">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
                                    <td>{$ticket->user_group_name}</td>
                                    <td>{$ticket->user_name}</td>

                                    <td align="center" nowrap="">{$ticket->trip_name}</td> 
                                    <td align="center" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td>                                        


                                    <td align="center">{$ticket->ticket_code}</td>  
                                    <td align="right" width="100">{$ticket->seat_name}</td> 
                                    <td align="right">{$ticket->seat_count}</td> 
                                    <td align="right">{$ticket->ticket_status_code}</td>    
                                    {if $ticket->ticket_status_code == "PBL"}
                                    <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                    {else}
                                    <td align="right">0.00</td>
                                    {/if}                                
                                    {if $ticket->ticket_status_code == "BO"}
                                        <td align="right">{$ticket->ticket_amount|number_format:2}</td>                            
                                        <td align="right">{$ticket->commission_amount|number_format:2}</td>                                       
                                        <td align="right">{$ticket->ac_bus_tax|number_format:2 }</td> 
                                    {else}
                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>                                       
                                        <td align="right">0.00</td> 
                                    {/if}
                                    <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                    {if $ticket->ticket_status_code == "CA"}
                                        <td align="right">{$ticket->ticket_amount|number_format:2}</td>                            
                                        <td align="right">{$ticket->revoke_commission_amount|number_format:2 }</td> 
                                        <td align="right">{$ticket->cancellation_charges|number_format:2}</td>
                                        <td align="right">{$ticket->refund_amount|number_format:2}</td>
                                    {else}
                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td> 
                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                    {/if}
                                </tr> 
                                 {assign var=ticket_count_2 value=$ticket_count_2+$ticket->seat_count}
                                {if $ticket->ticket_status_code=="PBL"}
                                    {assign var=pbl_ticket_amount_2 value=$pbl_ticket_amount_2+$ticket->ticket_amount}
                                {/if}
                                {if $ticket->ticket_status_code=="BO"}
                                    {assign var=ticket_amount_2 value=$ticket_amount_2+$ticket->ticket_amount}
                                	{assign var=comm_amount_2 value=$comm_amount_2+$ticket->commission_amount}
                                {/if}
                                {assign var=service_tax_2 value=$service_tax_2+$ticket->revoke_commission_amount}
                                {assign var=ac_tax_2 value=$ac_tax_2+$ticket->ac_bus_tax }
                                {assign var=disc_2 value=$disc_2+$ticket->addons_amount}
                                {if $ticket->ticket_status_code=="CA"}
                                    {assign var=cl_ticket_amount_2 value=$cl_ticket_amount_2+$ticket->ticket_amount}
                                {/if}
                                {assign var=c_comm_amount_2 value=$c_comm_amount_2+$ticket->cancellation_charges}
                                {assign var=c_service_tax_2 value=$c_service_tax_2+$ticket->refund_amount}
                            {/foreach}                                



                            {assign var=ticket_count_2_t value=$ticket_count_2_t+$ticket_count_2}
                            {assign var=ticket_amount_2_t value=$ticket_amount_2_t+$ticket_amount_2}
                            {assign var=comm_amount_2_t value=$comm_amount_2_t+$comm_amount_2}
                            {assign var=service_tax_2_t value=$service_tax_2_t+$service_tax_2}
                            {assign var=ac_tax_2_t value=$ac_tax_2_t+$ac_tax_2}
                            {assign var=disc_2_t value=$disc_2_t+$disc_2}
							
							{assign var=pbl_ticket_amount_2_t value=$pbl_ticket_amount_2_t+$pbl_ticket_amount_2}
                            {assign var=cl_ticket_amount_2_t value=$cl_ticket_amount_2_t+$cl_ticket_amount_2}

                            {assign var=c_ticket_count_2_t value=$c_ticket_count_2_t+$c_ticket_count_2}
                            {assign var=c_ticket_amount_2_t value=$c_ticket_amount_2_t+$c_ticket_amount_2}
                            {assign var=c_comm_amount_2_t value=$c_comm_amount_2_t+$c_comm_amount_2}
                            {assign var=c_service_tax_2_t value=$c_service_tax_2_t+$c_service_tax_2}   

                        {/foreach}

                    {/if}

                {/foreach}

                {if $smarty.request.group_by_2==""}
                    <tr class="active">
                        <td colspan="8" class="bold" align="right" style="font-weight: bold">Sub Total</td>
                        <td align="right" class="">{$ticket_count}</td>
                        <td align="right" class="">-</td>
						<td align="right" class="">{$pbl_ticket_amount|number_format:2}</td>
                        <td align="right" class="">{$ticket_amount|number_format:2}</td>
                        <td   align="right" class="">{$comm_amount|number_format:2}</td>
                        <td align="right" class="">{$ac_tax|number_format:2}</td>
						<td align="right" class="">{$disc|number_format:2}</td>
                        <td  align="right" class="">{$cl_ticket_amount|number_format:2}</td>                        
                        <td  align="right" class="">{$service_tax|number_format:2}</td>
                        <td align="right" class="">{$c_comm_amount|number_format:2}</td>
                        <td align="right" class="">{$c_service_tax|number_format:2}</td>
                    </tr>
                    {assign var=g_ticket_count value=$g_ticket_count+$ticket_count}
                    {assign var=g_ticket_amount value=$g_ticket_amount+$ticket_amount}
                    {assign var=g_comm_amount value=$g_comm_amount+$comm_amount}
                    {assign var=g_service_tax value=$g_service_tax+$service_tax}
                    {assign var=g_ac_tax value=$g_ac_tax+$ac_tax}
                    {assign var=g_disc value=$g_disc+$disc}

					{assign var=pbl_g_ticket_amount value=$pbl_g_ticket_amount+$pbl_ticket_amount}
                    {assign var=cl_g_ticket_amount value=$cl_g_ticket_amount+$cl_ticket_amount}

                    {assign var=g_c_ticket_count value=$g_ticket_count+$c_ticket_count}
                    {assign var=g_c_ticket_amount value=$g_ticket_amount+$c_ticket_amount}
                    {assign var=g_c_comm_amount value=$g_c_comm_amount+$c_comm_amount}
                    {assign var=g_c_service_tax value=$g_c_service_tax+$c_service_tax}


                {else}
                    <tr class="active">
                        <td colspan="8" class="bold" style="font-weight: bold" align="right">Sub Total</td>
                         <td align="right" class="">{$ticket_count}</td>
                        <td align="right" class="">-</td>
                        <td align="right" class="">{$pbl_ticket_amount_2_t|number_format:2}</td>
                        <td align="right" class="">{$ticket_amount_2_t|number_format:2}</td>
                        <td  align="right" class="">{$comm_amount_2_t|number_format:2}</td>
                        <td  align="right" class="">{$ac_tax_2_t|number_format:2}</td>
                        <td  align="right" class="">{$disc_2_t|number_format:2}</td>
                        <td  align="right"  class="">{$cl_ticket_amount_2_t|number_format:2}</td>
                        <td  align="right" class="">{$service_tax_2_t|number_format:2}</td>


                        <td align="right" class="">{$c_comm_amount_2_t|number_format:2}</td>
                        <td align="right" class="">{$c_service_tax_2_t|number_format:2}</td>
                    </tr>
                    {assign var=g_ticket_count value=$g_ticket_count+$ticket_count_2_t}
                    {assign var=g_ticket_amount value=$g_ticket_amount+$ticket_amount_2_t}
                    {assign var=g_comm_amount value=$g_comm_amount+$comm_amount_2_t}
                    {assign var=g_service_tax value=$g_service_tax+$service_tax_2_t}
                    {assign var=g_ac_tax value=$g_ac_tax+$ac_tax_2_t}
                    {assign var=g_disc value=$g_disc+$g_disc_2_t}

					{assign var=pbl_g_ticket_amount value=$pbl_g_ticket_amount+$pbl_ticket_amount_2_t}
                    {assign var=cl_g_ticket_amount value=$cl_g_ticket_amount+$cl_ticket_amount_2_t}

                    {assign var=g_c_comm_amount value=$g_c_comm_amount+$c_comm_amount_2_t}
                    {assign var=g_c_service_tax value=$g_c_service_tax+$c_service_tax_2_t}
                {/if}



            {/foreach}  
            <tr class="success bold" style="font-weight: bold">
                <td colspan="8" class="bold text-danger" align="right">Grand Total</td>
                
                <td align="right" class="">{$g_ticket_count}</td>
                <td align="right" class="">-</td>
				
				<td  align="right" class="">{$pbl_g_ticket_amount|number_format:2}</td>
                <td align="right" class="">{$g_ticket_amount|number_format:2}</td>

                <td  align="right" class="">{$g_comm_amount|number_format:2}</td>
                <td  align="right" class="">{$g_ac_tax|number_format:2}</td>
                 <td  align="right" class="">{$g_disc|number_format:2}</td>



                <td  align="right" class="">{$cl_g_ticket_amount|number_format:2}</td>
                <td  align="right" class="">{$g_service_tax|number_format:2}</td>

                <td align="right" class="">{$g_c_comm_amount|number_format:2}</td>
                <td align="right" class="">{$g_c_service_tax|number_format:2}</td>                
            </tr>



        </tbody>
    </table> 