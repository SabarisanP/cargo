<table class="" width="95%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">My Booking Report</td>
    </tr>
    <tr>
        <td width="50%">
            {if $smarty.request.date_option==1} 
                Travel Date Wise 
            {else}
                Transaction Date Wise
            {/if} 
            From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}</td>
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
    
<h5><b>Transactions</b></h5>    

<div class="table table-responsive" id="adv-report-grid" >
    <table id="dt_adv_booking_report_table" class="table table-bordered " >
        <thead>
            <tr class="success">
                <td rowspan="2" align="center">Travel Date</td>
                <td rowspan="2" align="center">Transaction Date</td> 
                <td rowspan="2">User Name</td>
                <td rowspan="2" align="center">Route</td>
                <td rowspan="2" align="center">Passenger Name</td>
                <td rowspan="2" align="center">Ticket Status</td> 
                <td rowspan="2" align="center">Seat Name</td> 
                <td rowspan="2" align="center">Transaction Mode</td>
                
                <td align="center" colspan="5">Booking</td> 
                <td align="center" colspan="7">Cancel</td> 
            </tr>
            <tr class="success">                     
                <td align="center">Fare</td>
                <td align="center">Discount</td>
                <td align="center">AC GST</td>
                <td align="center">Commission</td> 
                <td align="center" class="bold">Payable</td> 
                
                <td align="center">Fare</td>
                <td align="center">Discount</td>
                <td align="center">AC GST</td>
                <td align="center">Commission</td>      
                <td align="center">Can Charges</td>
                <td align="center">Agent Share</td>
                <td align="center" class="bold">Refund</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=g_b_ticket_amount value=0}
            {assign var=g_b_discount value=0}
            {assign var=g_b_ac_tax value=0}
            {assign var=g_b_comm_amount value=0} 
            {assign var=g_b_payable value=0} 

            {assign var=g_c_ticket_count value=0}
            {assign var=g_c_discount value=0}
            {assign var=g_c_ac_tax value=0}
            {assign var=g_ca_comm_amount value=0}
            {assign var=g_c_charge value=0}
            {assign var=g_c_agnt_share value=0}
            {assign var=g_c_refund value=0}

            {foreach item=level1 from=$tickets['one'] key=t}          
   
                {foreach item=level2 from=$level1 key=k}                    

                        {assign var="ticket" value=$level2}
                        <tr>                    
                            <td align="center" nowrap="nowrap">{$ticket->travel_date|date_format:$ns_date_format}</td>     
                            <td align="center">{$ticket->transaction_date|date_format:$ns_date_format}</td>
                            <td>{$ticket->user_name}</td>
                            <td align="left" nowrap="">
                                {$ticket->mobile_number}, {$ticket->passenger_name|truncate:15} <br>
                                {$ticket->from_station_name} - {$ticket->to_station_name}
                            </td> 
                            <td align="left"><a href="javascript:;" data-pnr="{$ticket->ticket_code}" class="pnr-popover">{$ticket->ticket_code}</a></td>
                            <td align="center">{$ticket->ticket_status_code}</td>
                            <td align="left">{$ticket->seat_name}</td>
                            <td align="left">{$paymode[$ticket->transaction_mode]}</td>
                            {if $ticket->ticket_status_code=='BO' || $ticket->ticket_status_code=='PBL' || $ticket->ticket_status_code=='TCKTR'}
                                <td align="right">{$ticket->ticket_amount|number_format:2}</td$ti>
                                <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                <td align="right">{$ticket->ac_bus_tax|number_format:2}</td> 
                                <td align="right">{$ticket->commission_amount|number_format:2}</td>
                                <td align="right" class="bold">{($ticket->ticket_amount-$ticket->addons_amount+$ticket->ac_bus_tax-$ticket->commission_amount)|number_format:2}</td>
                                
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                
                                {assign var=g_b_ticket_amount value=$g_b_ticket_amount+$ticket->ticket_amount}
                                {assign var=g_b_discount value=$g_b_discount+$ticket->addons_amount}
                                {assign var=g_b_ac_tax value=$g_b_ac_tax+$ticket->ac_bus_tax}
                                {assign var=g_b_comm_amount value=$g_b_comm_amount+$ticket->commission_amount} 
                                {assign var=g_b_payable value=$g_b_payable+($ticket->ticket_amount-$ticket->addons_amount+$ticket->ac_bus_tax-$ticket->commission_amount)} 
                            {else if $ticket->ticket_status_code=='TCA'}                                
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                
                                <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                <td align="right">{$ticket->ac_bus_tax|number_format:2}</td> 
                                <td align="right">{$ticket->commission_amount|number_format:2}</td>
                                <td align="right">{$ticket->cancellation_charges|number_format:2}</td>
                                <td align="right">{$ticket->cancel_commission_amount|number_format:2}</td>                                
                                <td align="right" class="bold">{($ticket->ticket_amount-$ticket->addons_amount+$ticket->ac_bus_tax)|number_format:2}</td>
                                
                                {assign var=g_c_ticket_count value=$g_c_ticket_count+$ticket->ticket_amount}
                                {assign var=g_c_discount value=$g_c_discount+$ticket->addons_amount}
                                {assign var=g_c_ac_tax value=$g_c_ac_tax+$ticket->ac_bus_tax}
                                {assign var=g_ca_comm_amount value=$g_ca_comm_amount+$ticket->commission_amount}
                                {assign var=g_c_charge value=$g_c_charge+$ticket->cancellation_charges}
                                {assign var=g_c_agnt_share value=$g_c_agnt_share+$ticket->cancel_commission_amount}
                                {assign var=g_c_refund value=$g_c_refund+$ticket->ticket_amount-$ticket->addons_amount+$ticket->ac_bus_tax}
                            {else}                                
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                <td align="right">0</td>
                                
                                <td align="right">{$ticket->ticket_amount|number_format:2}</td>
                                <td align="right">{$ticket->addons_amount|number_format:2}</td>
                                <td align="right">{$ticket->ac_bus_tax|number_format:2}</td> 
                                <td align="right">{$ticket->commission_amount|number_format:2}</td>
                                <td align="right">{$ticket->cancellation_charges|number_format:2}</td>
                                <td align="right">{$ticket->cancel_commission_amount|number_format:2}</td>                                
                                <td align="right" class="bold">{($ticket->refund_amount+$ticket->cancel_commission_amount)|number_format:2}</td>
                                
                                {assign var=g_c_ticket_count value=$g_c_ticket_count+$ticket->ticket_amount}
                                {assign var=g_c_discount value=$g_c_discount+$ticket->addons_amount}
                                {assign var=g_c_ac_tax value=$g_c_ac_tax+$ticket->ac_bus_tax}
                                {assign var=g_ca_comm_amount value=$g_ca_comm_amount+$ticket->commission_amount}
                                {assign var=g_c_charge value=$g_c_charge+$ticket->cancellation_charges}
                                {assign var=g_c_agnt_share value=$g_c_agnt_share+$ticket->cancel_commission_amount}
                                {assign var=g_c_refund value=$g_c_refund+$ticket->refund_amount+$ticket->cancel_commission_amount}
                            {/if}
                        </tr> 
                {/foreach}
                
            {/foreach}  
            <tr class="success bold">
                <td colspan="8" class="bold text-danger" align="right">Grand Total</td>

                <td align="right">{$g_b_ticket_amount|number_format:2}</td>
                <td align="right">{$g_b_discount|number_format:2}</td>
                <td align="right">{$g_b_ac_tax|number_format:2}</td>
                <td align="right">{$g_b_comm_amount|number_format:2}</td>
                <td align="right">{$g_b_payable|number_format:2}</td>
                
                <td align="right">{$g_c_ticket_count|number_format:2}</td>
                <td align="right">{$g_c_discount|number_format:2}</td>
                <td align="right">{$g_c_ac_tax|number_format:2}</td>
                <td align="right">{$g_ca_comm_amount|number_format:2}</td>
                <td align="right">{$g_c_charge|number_format:2}</td>
                <td align="right">{$g_c_agnt_share|number_format:2}</td>
                <td align="right">{$g_c_refund|number_format:2}</td>
                
            </tr>
            </tbody>
    </table> 
                
    
</div>

<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportMyTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>        

<script>
    $('.pnr-popover').each( function(){
            $(this).popover({
                container:'body',
                content:loading_popup,
                html:true,
                placement:'right',
                trigger:'focus',
            });

            $(this).on('show.bs.popover', function () {
                var ele = this;
                var data = {};
                data.ticketpnrcode = $(this).attr('data-pnr');
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "report/get-ticket-details",
                    data: data,
                    success: function (response) {
                        $(ele).popover('destroy').popover({
                            container:'body',
                            content:response,
                            html:true,
                            placement:'right',
                            trigger:'focus',
                        }).popover('show');

                    }
                });
            })
        });
</script>