<table class="" width="95%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Transactions Report</td>
    </tr>
    <tr>
        <td width="50%">
            {if $smarty.request.date_option==1} 
                Trip Date Wise 
            {else}
                Booked Date Wise
            {/if} 
            From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>

</table>

<div align="left"   class="table table-responsive" id="adv-report-grid">
    <div class="col-md-7 p_l_n"> 
        <h5><b>Summary</b></h5>
        <table class="table table-bordered" style="width:100%;">
            <tr class="success">
                <td class="bold text-left" >Category</td>
                <td class="bold text-center" >Fare (1)</td>
                <td class="bold text-center" >Discount (2)</td>
                <td class="bold text-center" >AC Bus GST (3)</td>
                <td class="bold text-center" >Commission with GST (4)</td>
                <td class="bold text-center" >TDS on Commission (5)</td>
                <td class="bold text-center" >Total (1-2+3-4+5)</td>
            </tr>
            <tr>
                <td class="text-left">Booking (A)</td>
                <td class="text-right">{$tickets['bo_fare']|number_format:2}</td>
                <td class="text-right">{$tickets['bo_discount']|number_format:2}</td>
                <td class="text-right">{$tickets['bo_ac_tax']|number_format:2}</td>
                <td class="text-right">{$tickets['bo_comission']|number_format:2}</td>
                <td class="text-right">{$tickets['bo_tds_tax']|number_format:2}</td>                
                <td class="text-right">
                    {assign var=a value=$tickets['bo_fare']-$tickets['bo_discount']+$tickets['bo_ac_tax']-$tickets['bo_comission']+$tickets['bo_tds_tax']}
                    {$a|number_format:2}
                </td>
            </tr>
            <tr>
                <td class="text-left">Cancel (B)</td>
                <td class="text-right">{$tickets['ca_fare']|number_format:2}</td>
                <td class="text-right">{$tickets['ca_discount']|number_format:2}</td>
                <td class="text-right">{$tickets['ca_ac_tax']|number_format:2}</td>                
                <td class="text-right">{$tickets['ca_comission']|number_format:2}</td>
                <td class="text-right">{$tickets['ca_tds_tax']|number_format:2}</td>
                <td class="text-right">
                    {assign var=b value=$tickets['ca_fare']-$tickets['ca_discount']+$tickets['ca_ac_tax']-$tickets['ca_comission']+$tickets['ca_tds_tax']}
                    {$b|number_format:2}
                </td>
            </tr>
            <tr>
                <td class="text-left">Cancel Charges (C)</td>
                <td class="text-right">{$tickets['ca_charges']|number_format:2}</td>
                <td class="text-right">0.00</td>
                <td class="text-right">0.00</td>
                <td class="text-right">{$tickets['ca_share']|number_format:2}</td>
                <td class="text-right">{$tickets['ca_ca_tds_tax']|number_format:2}</td>
                <td class="text-right">
                    {assign var=c value=$tickets['ca_charges']-$tickets['ca_share']+$tickets['ca_ca_tds_tax']}
                    {$c|number_format:2}
                </td>
            </tr>
            <tr>
                <td class="text-left">Trip Cancel (D)</td>
                <td class="text-right">0.00</td>
                <td class="text-right">0.00</td>
                <td class="text-right">0.00</td>
                <td class="text-right">0.00</td>
                <td class="text-right">0.00</td>
                <td class="text-right">
                    {assign var=d value=$tickets['tca_refund']}
                    {$d|number_format:2}
                </td>
            </tr>
            <tr class="">
                <td class="bold text-left">Net Amount (A-B+C-D)</td>
                <td class="bold text-right">{($tickets['bo_fare']-$tickets['ca_fare']+$tickets['ca_charges'])|number_format:2}</td>
                <td class="bold text-right">{($tickets['bo_discount']-$tickets['ca_discount'])|number_format:2}</td>
                <td class="bold text-right">{($tickets['bo_ac_tax']-$tickets['ca_ac_tax'])|number_format:2}</td>
                <td class="bold text-right">{($tickets['bo_comission']-$tickets['ca_comission']+$tickets['ca_share'])|number_format:2}</td>
                <td class="bold text-right">{($tickets['bo_tds_tax']-$tickets['ca_tds_tax']+$tickets['ca_ca_tds_tax'])|number_format:2}</td>
                <td class="bold text-right">
                    {($a-$b+$c-$d)|number_format:2}
                </td>
            </tr>
        </table>
    </div>
    <div class="col-md-5" id="trans-report-graph-1" style="height: 225px;"></div>
    <div class="clear_fix_both"></div>
    
    <h5><b>Transactions</b></h5>
    <div style="overflow-x: auto;">
    <table id="dt_adv_booking_report_table" class="table table-bordered " >
        <thead>
            <tr class="success">
                <td rowspan="2" align="center">Travel Date</td>
                <td rowspan="2" align="center">Transaction Date</td> 
                <td rowspan="2" align="center">Group Name</td>
                <td rowspan="2" align="center">User Name</td>
                <td align="center" rowspan="2">Route</td>
                <td align="center" rowspan="2">PNR</td>                 
                <td align="center" rowspan="2">Ticket Status</td>
                <td align="center" rowspan="2">Seat Count</td>
                
                <td align="center" colspan="6">Bookings</td>                 
                <td align="center" colspan="8">Cancels</td> 

            </tr>
            <tr class="success">                               

                <td align="center">Fare</td> 
                <td align="center">GST</td> 
                <td align="center">Discount</td>
                <td align="center">Commission</td> 
                <td align="center">TDS</td>
                <td align="center">Payable</td> 

                <td align="center">Fare</td> 
                <td align="center">GST</td> 
                <td align="center">Discount</td>
                <td align="center">BO Comm & TDS</td>                
                <td align="center">Cncl Charges</td>
                <td align="center">Cncl Comm / Share</td>
                <td align="center">TDS</td>
                <td align="left">Refund</td>  

            </tr>
        </thead>
        <tbody class="body_table" >
            {assign var=g_ticket_count value=0}
                
            {assign var=g_bo_ticket_amount value=0}
            {assign var=g_bo_gst value=0}
            {assign var=g_bo_discount value=0}
            {assign var=g_bo_comm_amount value=0}
            {assign var=g_bo_tds_amount value=0}
            {assign var=g_bo_payable value=0}


            {assign var=g_ca_ticket_amount value=0}
            {assign var=g_ca_gst value=0}
            {assign var=g_ca_discount value=0}
            {assign var=g_ca_comm_amount value=0}
            {assign var=g_ca_charges value=0}
            {assign var=g_ca_share value=0}
            {assign var=g_ca_tds value=0}
            {assign var=g_ca_refund value=0}

            {foreach item=level1 from=$tickets['one'] key=t}          

                {assign var=ticket_count value=0}
                
                {assign var=bo_ticket_amount value=0}
                {assign var=bo_gst value=0}
                {assign var=bo_discount value=0}
                {assign var=bo_comm_amount value=0}
                {assign var=bo_tds_amount value=0}
                {assign var=bo_payable value=0}
   

                {assign var=ca_ticket_amount value=0}
                {assign var=ca_gst value=0}
                {assign var=ca_discount value=0}
                {assign var=ca_comm_amount value=0}
                {assign var=ca_charges value=0}
                {assign var=ca_share value=0}
                {assign var=ca_tds value=0}
                {assign var=ca_refund value=0}


                <tr>
                    <td colspan="22" class="bold" align="center" >
                        {$t|date_format:$ns_date_format}
                    </td>
                </tr>
                {foreach item=level2 from=$level1 key=k}                    

                    {if $smarty.request.group_by_2 != ""}
                        {foreach item=level3 from=$level2 key=group}
                            
                            {assign var=ticket_count value=0}
                
                            {assign var=bo_ticket_amount value=0}
                            {assign var=bo_gst value=0}
                            {assign var=bo_discount value=0}
                            {assign var=bo_comm_amount value=0}
                            {assign var=bo_tds_amount value=0}
                            {assign var=bo_payable value=0}


                            {assign var=ca_ticket_amount value=0}
                            {assign var=ca_gst value=0}
                            {assign var=ca_discount value=0}
                            {assign var=ca_comm_amount value=0}
                            {assign var=ca_charges value=0}
                            {assign var=ca_share value=0}
                            {assign var=ca_tds value=0}
                            {assign var=ca_refund value=0}
                
                            <tr>
                                <td colspan="20" class="bold" align="center" >
                                    {$group}
                                </td>
                            </tr>
                            {foreach item=ticket from=$level3}
                                <tr class="row-{$ticket->ticket_code}">
                                    <td width="100" align="center">{$ticket->travel_date|date_format:$ns_date_format}</td>
                                    <td align="center">{$ticket->transaction_date|date_format:$ns_date_format}</td>
                                    <td>{$ticket->user_group_name}</td>
                                    <td>{$ticket->user_name}</td>

                                    <td align="left" nowrap="">{($ticket->from_station_name|cat:" to "|cat:$ticket->to_station_name)|truncate:30}</td>


                                    <td align="center">{$ticket->ticket_code}</td>
                                    <td align="center">{$ticket->ticket_status_code}</td>
                                    <td align="right">{$ticket->seat_count}</td>

                                    {if $ticket->ticket_status_code == "BO" || $ticket->ticket_status_code == "PBL"}
                                        <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                        <td align="right">{$ticket->ac_bus_tax|number_format:2 }</td>
                                        <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                        <td align="right">{$ticket->commission_amount|number_format:2}</td>
                                        <td align="right">{$ticket->tds_tax|number_format:2}</td>
                                        <td align="right">
                                            {assign var="payable" value=$ticket->ticket_amount+$ticket->ac_bus_tax-$ticket->addons_amount-$ticket->commission_amount+$ticket->tds_tax}
                                            {$payable|number_format:2}
                                        </td>
                                    {else}
                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                    {/if}

                                    {if $ticket->ticket_status_code == "CA"}
                                        <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                        <td align="right">{$ticket->ac_bus_tax|number_format:2}</td>
                                        <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                        <td align="right">{($ticket->commission_amount-$ticket->tds_tax)|number_format:2}</td>
                                        <td align="right">{$ticket->cancellation_charges|number_format:2}</td>
                                        <td align="right">{$ticket->cancel_commission|number_format:2}</td>
                                        <td align="right">{$ticket->cancel_tds_tax|number_format:2}</td>
                                        <td align="right">
                                            {assign var="refund" value=$ticket->ticket_amount+$ticket->ac_bus_tax-$ticket->addons_amount-$ticket->commission_amount+$ticket->tds_tax-$ticket->cancellation_charges+$ticket->cancel_commission-$ticket->cancel_tds_tax}
                                            {$refund|number_format:2}
                                        </td>
                                    {else if $ticket->ticket_status_code == "TCA"}
                                        <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                        <td align="right">{$ticket->ac_bus_tax|number_format:2}</td>
                                        <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                        <td align="right">{($ticket->commission_amount-$ticket->tds_tax)|number_format:2}</td>
                                        <td align="right">{$ticket->cancellation_charges|number_format:2}</td>
                                        <td align="right">{$ticket->cancel_commission|number_format:2}</td>
                                        <td align="right">{$ticket->cancel_tds_tax|number_format:2}</td>
                                        <td align="right">
                                            {assign var="refund" value=$ticket->ticket_amount+$ticket->ac_bus_tax-$ticket->addons_amount-$ticket->commission_amount+$ticket->tds_tax-$ticket->cancellation_charges+$ticket->cancel_commission-$ticket->cancel_tds_tax}
                                            {$refund|number_format:2}
                                        </td>
                                    {else}
                                        <td align="right">0.00</td>
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
                                    {assign var=bo_tds_amount value=$bo_tds_amount+$ticket->tds_tax}
                                    {assign var=bo_payable value=$bo_payable+$payable}
                                {/if}

                                {if $ticket->ticket_status_code == "CA" }
                                    {assign var=ca_ticket_amount value=$ca_ticket_amount+$ticket->ticket_amount}
                                    {assign var=ca_gst value=$ca_gst+$ticket->ac_bus_tax}
                                    {assign var=ca_discount value=$ca_discount+$ticket->addons_amount}
                                    {assign var=ca_comm_amount value=$ca_comm_amount+$ticket->commission_amount-$ticket->tds_tax}
                                    {assign var=ca_charges value=$ca_charges+$ticket->cancellation_charges}
                                    {assign var=ca_share value=$ca_share+$ticket->cancel_commission}
                                    {assign var=ca_tds value=$ca_tds+$ticket->cancel_tds_tax}
                                    {assign var=ca_refund value=$ca_refund+$refund}
                                {/if}

                                {if $ticket->ticket_status_code == "TCA" }
                                    {assign var=ca_refund value=$ca_refund+$refund}
                                {/if}
                            {/foreach}
                            <tr class="active">
                                <td colspan="7" class="bold" align="right">Sub Total</td>
                                <td align="right" class="">{$ticket_count}</td>

                                <td align="right" class="">{$bo_ticket_amount|number_format:2}</td>
                                <td   align="right" class="">{$bo_gst|number_format:2}</td>
                                <td align="right" class="">{$bo_discount|number_format:2}</td>
                                <td align="right" class="">{$bo_comm_amount|number_format:2}</td>
                                <td align="right" class="">{$bo_tds_amount|number_format:2}</td>
                                <td  align="right" class="">{$bo_payable|number_format:2}</td>

                                <td  align="right" class="">{$ca_ticket_amount|number_format:2}</td>
                                <td  align="right" class="">{$ca_gst|number_format:2}</td>
                                <td align="right" class="">{$ca_discount|number_format:2}</td>
                                <td align="right" class="">{$ca_comm_amount|number_format:2}</td>
                                <td align="right" class="">{$ca_charges|number_format:2}</td>
                                <td align="right" class="">{$ca_share|number_format:2}</td>
                                <td align="right">{$ca_tds|number_format:2}</td>
                                <td align="right" class="">{$ca_refund|number_format:2}</td>

                            </tr>

                            {assign var=g_ticket_count value=$g_ticket_count+$ticket_count}

                            {assign var=g_bo_ticket_amount value=$g_bo_ticket_amount+$bo_ticket_amount}
                            {assign var=g_bo_gst value=$g_bo_gst+$bo_gst}
                            {assign var=g_bo_discount value=$g_bo_discount+$bo_discount}
                            {assign var=g_bo_comm_amount value=$g_bo_comm_amount+$bo_comm_amount}
                            {assign var=g_bo_tds_amount value=$g_bo_tds_amount+$bo_tds_amount}
                            {assign var=g_bo_payable value=$g_bo_payable+$bo_payable}

                            {assign var=g_ca_ticket_amount value=$g_ca_ticket_amount+$ca_ticket_amount}
                            {assign var=g_ca_gst value=$g_ca_gst+$ca_gst}
                            {assign var=g_ca_discount value=$g_ca_discount+$ca_discount}
                            {assign var=g_ca_comm_amount value=$g_ca_comm_amount+$ca_comm_amount}
                            {assign var=g_ca_charges value=$g_ca_charges+$ca_charges}
                            {assign var=g_ca_share value=$g_ca_share+$ca_share}
                            {assign var=g_ca_tds value=$g_ca_tds+$ca_tds}
                            {assign var=g_ca_refund value=$g_ca_refund+$ca_refund}
                        {/foreach}
                    {else}
                        {assign var="ticket" value=$level2}
                        <tr class="row-{$ticket->ticket_code}">                    
                            <td width="100" align="center">{$ticket->travel_date|date_format:$ns_date_format}</td>     
                            <td align="center">{$ticket->transaction_date|date_format:$ns_date_format}</td>
                            <td>{$ticket->user_group_name}</td>
                            <td>{$ticket->user_name}</td>

                            <td align="left" nowrap="">{($ticket->from_station_name|cat:" to "|cat:$ticket->to_station_name)|truncate:30}</td>                                        


                            <td align="center">{$ticket->ticket_code}</td>                            
                            <td align="center">{$ticket->ticket_status_code}</td>
                            <td align="right">{$ticket->seat_count}</td>
                          
                            {if $ticket->ticket_status_code == "BO" || $ticket->ticket_status_code == "PBL"}
                             	<td align="right">{$ticket->ticket_amount|number_format:2}</td> 
                                <td align="right">{$ticket->ac_bus_tax|number_format:2 }</td> 
                                <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                <td align="right">{$ticket->commission_amount|number_format:2}</td>
                                <td align="right">{$ticket->tds_tax|number_format:2}</td>
                                <td align="right">
                                    {assign var="payable" value=$ticket->ticket_amount+$ticket->ac_bus_tax-$ticket->addons_amount-$ticket->commission_amount+$ticket->tds_tax}
                                    {$payable|number_format:2}
                                </td>                                
                            {else}
                                <td align="right">0.00</td>
                                <td align="right">0.00</td>                                       
                                <td align="right">0.00</td> 
                                <td align="right">0.00</td>
                                <td align="right">0.00</td>
                                <td align="right">0.00</td> 
                            {/if}
                            	
                            {if $ticket->ticket_status_code == "CA"}
                                <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                <td align="right">{$ticket->ac_bus_tax|number_format:2}</td>
                                <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                <td align="right">{($ticket->commission_amount-$ticket->tds_tax)|number_format:2}</td>
                                <td align="right">{$ticket->cancellation_charges|number_format:2}</td>
                                <td align="right">{$ticket->cancel_commission|number_format:2}</td>
                                <td align="right">{$ticket->cancel_tds_tax|number_format:2}</td>
                                <td align="right">{($ticket->refund_amount + $ticket->revoke_commission_amount)|number_format:2}</td>
                            {else if $ticket->ticket_status_code == "TCA"}
                                <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                <td align="right">{$ticket->ac_bus_tax|number_format:2}</td>
                                <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                <td align="right">{($ticket->commission_amount-$ticket->tds_tax)|number_format:2}</td>
                                <td align="right">{$ticket->cancellation_charges|number_format:2}</td>
                                <td align="right">{$ticket->cancel_commission|number_format:2}</td>
                                <td align="right">{$ticket->cancel_tds_tax|number_format:2}</td>
                                <td align="right">
                                    {assign var="refund" value=$ticket->ticket_amount+$ticket->ac_bus_tax-$ticket->addons_amount-$ticket->commission_amount+$ticket->tds_tax-$ticket->cancellation_charges+$ticket->cancel_commission-$ticket->cancel_tds_tax}
                                    {$refund|number_format:2}                                    
                                </td>
                            {else}
                                <td align="right">0.00</td>
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
                            {assign var=bo_tds_amount value=$bo_tds_amount+$ticket->tds_tax}
                            {assign var=bo_payable value=$bo_payable+$payable}
                        {/if}
                        
                        {if $ticket->ticket_status_code == "CA" }
                            {assign var=ca_ticket_amount value=$ca_ticket_amount+$ticket->ticket_amount}
                            {assign var=ca_gst value=$ca_gst+$ticket->ac_bus_tax}
                            {assign var=ca_discount value=$ca_discount+$ticket->addons_amount}
                            {assign var=ca_comm_amount value=$ca_comm_amount+$ticket->commission_amount-$ticket->tds_tax}
                            {assign var=ca_charges value=$ca_charges+$ticket->cancellation_charges}
                            {assign var=ca_share value=$ca_share+$ticket->cancel_commission}
                            {assign var=ca_tds value=$ca_tds+$ticket->cancel_tds_tax}
                            {assign var=ca_refund value=$ca_refund+$refund}
                        {/if}
                        
                        {if $ticket->ticket_status_code == "TCA" }
                            {assign var=ca_refund value=$ca_refund+$refund}
                        {/if}
                    {/if}
                {/foreach}
                {if $smarty.request.group_by_2 == ""}
                    <tr class="active">
                        <td colspan="7" class="bold" align="right">Sub Total</td>
                        <td align="right" class="">{$ticket_count}</td>
                        
                        <td align="right" class="">{$bo_ticket_amount|number_format:2}</td>
                        <td   align="right" class="">{$bo_gst|number_format:2}</td>
                        <td align="right" class="">{$bo_discount|number_format:2}</td>
                        <td align="right" class="">{$bo_comm_amount|number_format:2}</td>
                        <td align="right" class="">{$bo_tds_amount|number_format:2}</td>
                        <td  align="right" class="">{$bo_payable|number_format:2}</td> 
                        
                        <td  align="right" class="">{$ca_ticket_amount|number_format:2}</td> 
                        <td  align="right" class="">{$ca_gst|number_format:2}</td>
                        <td align="right" class="">{$ca_discount|number_format:2}</td>
                        <td align="right" class="">{$ca_comm_amount|number_format:2}</td>
                        <td align="right" class="">{$ca_charges|number_format:2}</td>
                        <td align="right" class="">{$ca_share|number_format:2}</td>
                        <td align="right"class="">{$ca_tds|number_format:2}</td>
                        <td align="right" class="">{$ca_refund|number_format:2}</td>
                        
                    </tr>
                    
                    {assign var=g_ticket_count value=$g_ticket_count+$ticket_count} 
                        
                    {assign var=g_bo_ticket_amount value=$g_bo_ticket_amount+$bo_ticket_amount}
                    {assign var=g_bo_gst value=$g_bo_gst+$bo_gst}
                    {assign var=g_bo_discount value=$g_bo_discount+$bo_discount}
                    {assign var=g_bo_comm_amount value=$g_bo_comm_amount+$bo_comm_amount}
                    {assign var=g_bo_tds_amount value=$g_bo_tds_amount+$bo_tds_amount}
                    {assign var=g_bo_payable value=$g_bo_payable+$bo_payable}

                    {assign var=g_ca_ticket_amount value=$g_ca_ticket_amount+$ca_ticket_amount}
                    {assign var=g_ca_gst value=$g_ca_gst+$ca_gst}
                    {assign var=g_ca_discount value=$g_ca_discount+$ca_discount}
                    {assign var=g_ca_comm_amount value=$g_ca_comm_amount+$ca_comm_amount}
                    {assign var=g_ca_charges value=$g_ca_charges+$ca_charges}
                    {assign var=g_ca_share value=$g_ca_share+$ca_share}
                    {assign var=g_ca_tds value=$g_ca_tds+$ca_tds}
                    {assign var=g_ca_refund value=$g_ca_refund+$ca_refund}
                {/if}
            {/foreach}  
            <tr class="success bold">
                <td colspan="7" class="bold" align="right">Grand Total</td>
                <td align="right" class="">{$g_ticket_count}</td>

                <td align="right" class="">{$g_bo_ticket_amount|number_format:2}</td>
                <td align="right" class="">{$g_bo_gst|number_format:2}</td>
                <td align="right" class="">{$g_bo_discount|number_format:2}</td>
                <td align="right" class="">{$g_bo_comm_amount|number_format:2}</td>
                <td align="right" class="">{$g_bo_tds_amount|number_format:2}</td>
                <td align="right" class="">{$g_bo_payable|number_format:2}</td> 

                <td align="right" class="">{$g_ca_ticket_amount|number_format:2}</td> 
                <td align="right" class="">{$g_ca_gst|number_format:2}</td>
                <td align="right" class="">{$g_ca_discount|number_format:2}</td>
                <td align="right" class="">{$g_ca_comm_amount|number_format:2}</td>
                <td align="right" class="">{$g_ca_charges|number_format:2}</td>
                <td align="right" class="">{$g_ca_share|number_format:2}</td>
                <td align="right" class="">{$g_ca_tds|number_format:2}</td>
                <td align="right" class="">{$g_ca_refund|number_format:2}</td>                
            </tr>

        </tbody>
    </table> 
    </div>        
</div>

<!-- Ticket Detail Dialog -->
<div id="tck-dialog" class="hide dialog-content-page">
    <span id="pnr-loading"></span>
    <br>
    <div class="col-lg-6 p_l_n">
        <div>
            <label for="txt_m_name" class="req">Transaction Type</label>
            <select id="t_type" class="form-control col-md-6">
                <option value="">Select</option>
                {foreach name=o item=row from=$t_type}
                    <option value="{$row->code}">{$row->name}</option>
                {/foreach}   
            </select>
        </div>
    </div>
    <div class="col-lg-6 p_l_n">

        <label for="txt_l_name" class="req">Transaction Received Date</label>
        <div class="input-group">
            <input  placeholder="Date Received" id="Rdate" name="Rdate"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
        </div>
    </div>
    <div class="clear_fix_both"></div>
    <br />
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;" id="recharge-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <button class="btn btn-default" type="button" onclick="cancelPnrDetails();">Close</button>
        </div>
    </div> 
</div>


<!-- Dialog Ends -->

<div class="text-right noprint" id="action-btns">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>       

<script>
    var device = {$tickets['device']|json_encode}
</script>