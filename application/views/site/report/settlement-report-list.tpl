<table class="" width="95%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Settlement Report</td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span> 
            {$smarty.request.from|date_format:$ns_date_format}  to {$smarty.request.to|date_format:$ns_date_format}  DOJ </td>
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
    <h5><b>Summary</b></h5>
    <table class="table table-bordered" style="width:50%;">
        <tr>
            <td colspan="2"  class="bold text-center" >Booking</td>
            <td colspan="2" class="bold text-center" >Cancellation</td>
        </tr>
        <tr>
            <td class="bold" >Fare (B1)</td>
            <td class="text-right">{$tickets['bo_fare']|number_format:2}</td>
            <td class="bold">Fare With GST (C1)</td>                                                            
            <td class="text-right">{($tickets['ca_fare']+$tickets['ca_ac_tax'])|number_format:2}</td>
        </tr>
        <tr>
            <td class="bold" >Discount (B2)</td>
            <td class="text-right">{$tickets['bo_discount']|number_format:2}</td>
            <td class="bold" >Discount (C2)</td>
            <td class="text-right">{$tickets['ca_discount']|number_format:2}</td>            
        </tr>
        <tr>
            <td class="bold" >A/C GST (B3)</td>
            <td class="text-right">{$tickets['bo_ac_tax']|number_format:2}</td>
            <td class="bold">Charges (C3)</td>                                                            
            <td class="text-right">{$tickets['ca_charges']|number_format:2}</td>
        </tr>
        <tr>
            <td class="bold" >Commission (B4)</td>
            <td class="text-right">{$tickets['bo_comission']|number_format:2}</td>
            <td class="bold">Agent Share (C4)</td>                                                            
            <td class="text-right">{$tickets['ca_share']|number_format:2}</td>
        </tr>
        <tr>
            <td class="bold" >Sub Total (A=B1-B2+B3-B4)</td>
            <td class="text-right">{$tickets['bo_payable']|number_format:2}</td>
            <td class="bold">Refund (C5 = C1-C2-C3)</td>                                                            
            <td class="text-right">{$tickets['ca_refund']|number_format:2}</td>            
        </tr>
        <tr>
            <td class="bold" ></td>
            <td class="text-right"></td>
            <td class="bold">Cancellation Revenue (B=C3-C4)</td>                                                            
            <td class="text-right">
                {$stot = $tickets['ca_charges']-$tickets['ca_share']}
                {$stot|number_format:2}
            </td>
        </tr>        
        <tr>
            <td class="bold" colspan="3" >Net Payable (A+B)</td>                                                                                           
            <td class="bold text-right">
                {$tot = $tickets['bo_payable']+$stot}
                {$tot|number_format:2}
            </td>
        </tr>
    </table>
            
    <h5><b>Booking</b></h5>
    <table id="dt_adv_booking_report_table" class="table table-bordered " >
        <thead>
            <tr class="success">
                <td align="center">PNR</td>
                <td align="center">Schedule</td> 
                <td align="center">Route</td> 
                <td align="center">Transaction Date</td>
                <td align="center">Travel Date</td>
                <td align="center">Seat Name</td>
                <td align="center">No. of Seats</td>
                <td align="center">Fare</td>
                <td align="center">Discount</td>
                <td align="center">A/C GST</td>
                <td align="center">Commission</td>
                <td align="center">Payable</td>
            </tr>

        </thead>
        <tbody class="body_table" >

            {foreach item=ticket from=$tickets['booking'] key=t}               
                <tr class="row-{$ticket->ticket_code}">                    
                    <td align="left">{$ticket->ticket_code}</td>   
                    <td align="left" nowrap="">{$ticket->schedule_name} - {$ticket->trip_date|date_format:$ns_time_format}</td> 
                    <td align="left" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td>                                        
                    <td align="center">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
                    <td align="center">{$ticket->travel_date|date_format:$ns_date_format}</td>
                    <td align="left" width="100">{$ticket->seat_name}</td>
                    <td align="center" width="100">{$ticket->seat_count}</td>
                    <td align="right" width="100">{$ticket->ticket_amount}</td>
                    <td align="right" width="100">{$ticket->addon_amount}</td>
                    <td align="right" width="100">{$ticket->ac_bus_tax}</td>
                    <td align="right" width="100">{$ticket->commission_amount}</td>
                    <td align="right" width="100">{$ticket->payable}</td>
                </tr>
                {assign var="bo_tk" value="`$bo_tk+$ticket->seat_count`"}
                    
            {/foreach}  
            <tr class="active">
                <td colspan="6" class="bold" align="right">Sub Total</td>
                <td  align="center"  class="">{$bo_tk}</td>                
                <td  align="right"  class="">{$tickets['bo_fare']|number_format:2}</td>
                <td  align="right"  class="">{$tickets['bo_discount']|number_format:2}</td>
                <td  align="right"  class="">{$tickets['bo_ac_tax']|number_format:2}</td>
                <td  align="right" class="">{$tickets['bo_comission']|number_format:2}</td>
                <td align="right" class="">{$tickets['bo_payable']|number_format:2}</td>
            </tr>
        </tbody>
    </table>                


    <h5><b>Cancellation</b></h5>
    <table id="dt_adv_booking_report_table" class="table table-bordered " >
        <thead>
            <tr class="success">
                <td align="center" >PNR</td> 
                <td align="center">Schedule</td>
                <td align="center">Route</td> 
                <td align="center">Transaction Date</td>
                <td align="center">Travel Date</td>
                <td align="center" >Seat Name</td> 
                <td align="center" >No. of Seats</td>
                <td align="center" >Fare</td>
                <td align="center">Discount</td>
                <td align="center" >A/C GST</td>
                <td align="center" >Cancellation Charges</td>
                <td align="center" >Cancel Agent Share</td>
                <td align="center" >Refund</td>
            </tr>

        </thead>
        <tbody class="body_table" >



            {foreach item=ticket from=$tickets['cancel'] key=t}          
                
                <tr class="row-{$ticket->ticket_code}">                    
                    <td align="left">{$ticket->ticket_code}</td> 
                    <td align="left" nowrap="">{$ticket->schedule_name} - {$ticket->trip_date|date_format:$ns_time_format}</td> 
                    <td align="left" nowrap="">{$ticket->from_station_name} - {$ticket->to_station_name}</td>                                        
                    <td align="center">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
                    <td align="center">{$ticket->travel_date|date_format:$ns_date_format}</td>
                    <td align="left" width="100">{$ticket->seat_name}</td>
                    <td align="center" width="100">{$ticket->seat_count}</td>
                    <td align="right" width="100">{$ticket->ticket_amount}</td>
                    <td align="right" width="100">{$ticket->addon_amount}</td>
                    <td align="right" width="100">{$ticket->ac_bus_tax}</td>
                    <td align="right" width="100">{$ticket->cancellation_charges}</td>
                    <td align="right" width="100">{$ticket->cancel_commission}</td>
                    <td align="right" width="100">{$ticket->refund}</td>
                </tr>
                {assign var="ca_tk" value="`$ca_tk+$ticket->seat_count`"}
                    
            {/foreach} 
            <tr class="active">
                <td colspan="6" class="bold" align="right">Sub Total</td>
                <td  align="center"  class="">{$ca_tk}</td>
                <td  align="right"  class="">{$tickets['ca_fare']|number_format:2}</td>
                <td  align="right"  class="">{$tickets['ca_discount']|number_format:2}</td>
                <td  align="right"  class="">{$tickets['ca_ac_tax']|number_format:2}</td>
                <td align="right" class="">{$tickets['ca_charges']|number_format:2}</td>
                <td align="right" class="">{$tickets['ca_share']|number_format:2}</td>
                <td align="right" class="">{$tickets['ca_refund']|number_format:2}</td>
            </tr>
        </tbody>
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
        <button class="btn btn-default" onclick="settlementReportPdf()"><i class="fa fa-download fa-lg"></i>Download</button>
    </div>        
</div>
