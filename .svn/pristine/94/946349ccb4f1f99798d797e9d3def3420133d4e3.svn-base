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
    <div class="col-md-6 p_l_n"> 
        <div class="row">
            <div class="col-md-6">
                <h5><b>Summary</b></h5>
            </div>
            <div class="col-md-6 text-right">
                <div class="btn-group btn-group-sm">
                    <button class="btn btn-default" onclick="exportBranchCollectionsPdf('{$smarty.request.user_code}');"><i class="fa fa-download fa-lg"></i>Pdf</button>
                </div>
            </div>
        </div>
        <div class="overflow-x-auto">
            <table class="table table-bordered" style="width:100%;">
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
                <tr>
                    <td class="text-left">Trip Cancel (D)</td>
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
                    <td class="bold text-right">
                        {($a-$b+$c-$d)|number_format:2}
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="col-md-6" id="trans-report-graph-1" style="height: 225px;"></div>
    <div class="clear_fix_both"></div>

    <h5><b>Booking</b></h5>
    <div class="overflow-x-auto">
        <table id="dt_adv_booking_report_table" class="table table-bordered " >
            <thead>
                <tr class="success">
                    <td align="center">Travel Date</td>
                    <td align="center">Transaction Date</td> 
                    <td align="center">Group Name</td>
                    <td align="center">User Name</td>
                    <td align="center">Route</td>
                    <td align="center">PNR</td>                 
                    <td align="center">Ticket Status</td>
                    <td align="center">Seat Count</td>
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
                                <tr>
                                    <td colspan="13" class="bold" align="center" >
                                        {$t|date_format:$ns_date_format}
                                    </td>
                                </tr>
                                {assign var=first_iter value=0}
                            {/if}

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
                        <tr class="active">
                            <td colspan="7" class="bold" align="right">Sub Total</td>
                            <td align="right" class="">{$ticket_count}</td>

                            <td align="right" class="">{$bo_ticket_amount|number_format:2}</td>
                            <td   align="right" class="">{$bo_gst|number_format:2}</td>
                            <td align="right" class="">{$bo_discount|number_format:2}</td>
                            <td align="right" class="">{$bo_comm_amount|number_format:2}</td>
                            <td  align="right" class="">{$bo_payable|number_format:2}</td> 

                        </tr>

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
                <tr class="success bold">
                    <td colspan="7" class="bold" align="right">Grand Total</td>
                    <td align="right" class="">{$g_ticket_count}</td>

                    <td align="right" class="">{$g_bo_ticket_amount|number_format:2}</td>
                    <td   align="right" class="">{$g_bo_gst|number_format:2}</td>
                    <td align="right" class="">{$g_bo_discount|number_format:2}</td>
                    <td align="right" class="">{$g_bo_comm_amount|number_format:2}</td>
                    <td  align="right" class="">{$g_bo_payable|number_format:2}</td>              
                </tr>



            </tbody>
        </table> 
    </div>     

    <h5><b>Cancellation</b></h5>
    <div class="overflow-x-auto">
        <table id="dt_adv_booking_report_table" class="table table-bordered " >
            <thead>
                <tr class="success">
                    <td align="center">Travel Date</td>
                    <td align="center">Transaction Date</td> 
                    <td align="center">Group Name</td>
                    <td align="center">User Name</td>
                    <td align="center">Route</td>
                    <td align="center">PNR</td>                 
                    <td align="center">Ticket Status</td>
                    <td align="center">Seat Count</td>

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
                                <tr>
                                    <td colspan="15" class="bold" align="center" >
                                        {$t|date_format:$ns_date_format}
                                    </td>
                                </tr>
                                {assign var=first_iter value=0}
                            {/if}

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
                        <tr class="active">
                            <td colspan="7" class="bold" align="right">Sub Total</td>
                            <td align="right" class="">{$ticket_count}</td>

                            <td  align="right" class="">{$ca_ticket_amount|number_format:2}</td> 
                            <td  align="right" class="">{$ca_gst|number_format:2}</td>
                            <td align="right" class="">{$ca_discount|number_format:2}</td>
                            <td align="right" class="">{$ca_comm_amount|number_format:2}</td>
                            <td align="right" class="">{$ca_charges|number_format:2}</td>
                            <td align="right" class="">{$ca_share|number_format:2}</td>
                            <td align="right" class="">{$ca_refund|number_format:2}</td>

                        </tr>

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
                <tr class="success bold">
                    <td colspan="7" class="bold" align="right">Grand Total</td>
                    <td align="right" class="">{$g_ticket_count}</td>

                    <td  align="right" class="">{$g_ca_ticket_amount|number_format:2}</td> 
                    <td  align="right" class="">{$g_ca_gst|number_format:2}</td>
                    <td align="right" class="">{$g_ca_discount|number_format:2}</td>
                    <td align="right" class="">{$g_ca_comm_amount|number_format:2}</td>
                    <td align="right" class="">{$g_ca_charges|number_format:2}</td>
                    <td align="right" class="">{$g_ca_share|number_format:2}</td>
                    <td align="right" class="">{$g_ca_refund|number_format:2}</td>                
                </tr>



            </tbody>
        </table> 
    </div>    
</div>