<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Advance Booking Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">From :</span> {$smarty.request.from|date_format:$ns_date_format}  <span class="bold">To :</span> {$smarty.request.to|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span>{$smarty.now|date_format:$ns_date_format}</td>
    </tr>

</table>
<div class="table-responsive" id="adv-report-grid">
    <table id="dt_adv_booking_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th align="center">Travel Date</th>
                <th>Group Name</th>
                <th>User Name</th>
                <th>Route</th>  
                <th>Seat Numbers</th>
                <th align="center">No. of Tickets Booked</th>                
                <th align="center">Ticket Amount</th>
                <th align="center">Agent Commission</th>
                <th align="center">GST</th>
                <th align="center">Balance Amount</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=g_ticket_count value=0}
            {assign var=g_ticket_amount value=0}
            {assign var=g_comm_amount value=0}
            {assign var=g_service_tax value=0}
            {assign var=g_balance_amount value=0}
            
            {foreach item=trip from=$tickets['trip'] key=t}
                <tr>
                    <td colspan="9" class="bold" align="center">
                        {$trip[0]->tripCode} 
                    </td>
                </tr>
                                
                {assign var=ticket_count value=0}
                {assign var=ticket_amount value=0}
                {assign var=comm_amount value=0}
                {assign var=service_tax value=0}
                {assign var=balance_amount value=0}
                
                {foreach item=row from=$trip key=k}
                <tr>                    
                    <td align="center">{$row->travelDate|date_format:$ns_date_format}</td>
                    <td>{$row->user->group->name}</td>
                    <td>{$row->user->name}</td>
                    <td>{$row->fromStation->name} - {$row->toStation->name}</td> 
                    <td>{$row->seatName}</td> 
                    <td align="center">{$row->seatCount}</td>                                        
                    <td align="right">{$row->ticketFare|number_format:2}</td>
                    <td align="right">{$row->commissionAmount|number_format:2}</td>
                    <td align="right">{$row->serviceTax|number_format:2}</td>
                    <td align="right">{$row->transactionAmount|number_format:2}</td>
                </tr>
                
                {assign var=ticket_count value=$ticket_count+$row->seatCount}
                {assign var=ticket_amount value=$ticket_amount+$row->ticketFare}
                {assign var=comm_amount value=$comm_amount+$row->commissionAmount}
                {assign var=service_tax value=$service_tax+$row->serviceTax}
                {assign var=balance_amount value=$balance_amount+$row->transactionAmount}
                
                {/foreach}
                <!--<tr>
                    <td colspan="6" class="bold" align="right">Sub Total</td>
                    <td align="right">{$ticket_amount|number_format}</td>
                    <td align="right">{$comm_amount|number_format}</td>
                    <td align="right">{$service_tax|number_format}</td>
                    <td align="right">{$balance_amount|number_format}</td>
                </tr> -->
                <tr class="active1">
                    <td colspan="5" class="bold" align="right">Sub Total</td>
                    <td align="center" class="">{$ticket_count}</td>
                    <td align="right" class="">{$ticket_amount|number_format:2}</td>
                    <td align="right" class="">{$comm_amount|number_format:2}</td>
                    <td align="right" class="">{$service_tax|number_format:2}</td>
                    <td align="right" class="">{$balance_amount|number_format:2}</td>
                </tr>
                
                {assign var=g_ticket_count value=$g_ticket_count+$ticket_count}
                {assign var=g_ticket_amount value=$g_ticket_amount+$ticket_amount}
                {assign var=g_comm_amount value=$g_comm_amount+$comm_amount}
                {assign var=g_service_tax value=$g_service_tax+$service_tax}
                {assign var=g_balance_amount value=$g_balance_amount+$balance_amount}
                
            {/foreach}  
            <tr class="active bold">
                    <td colspan="5" class="bold text-danger" align="right">Grand Total</td>
                    <td align="center" class="">{$g_ticket_count}</td>
                    <td align="right" class="">{$g_ticket_amount|number_format:2}</td>
                    <td align="right" class="">{$g_comm_amount|number_format:2}</td>
                    <td align="right" class="">{$g_service_tax|number_format:2}</td>
                    <td align="right" class="">{$g_balance_amount|number_format:2}</td>
                </tr>
        </tbody>
    </table>                
</div>
                
<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportExcel()'"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>   
                
<div class="bold noprint">Group Wise Summary</div>                
<br>
<div class="table-responsive noprint">
    <table id="dt_adv_booking_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th >Group Name</th>
                <th align="center">No. of Tickets Booked</th>                
                <th align="center">Ticket Amount</th>
                <th align="center">Agent Commission</th>
                <th align="center">GST</th>
                <th align="center">Balance Amount</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=g_ticket_count value=0}
            {assign var=g_ticket_amount value=0}
            {assign var=g_comm_amount value=0}
            {assign var=g_service_tax value=0}
            {assign var=g_balance_amount value=0}
            
            {foreach item=trip from=$group_tickets['group'] key=t}
                                               
                {assign var=ticket_count value=0}
                {assign var=ticket_amount value=0}
                {assign var=comm_amount value=0}
                {assign var=service_tax value=0}
                {assign var=balance_amount value=0}
                
                {foreach item=row from=$trip key=k}
                       
                    {assign var=ticket_count value=$ticket_count+$row->seatCount}
                    {assign var=ticket_amount value=$ticket_amount+$row->ticketFare}
                    {assign var=comm_amount value=$comm_amount+$row->commissionAmount}
                    {assign var=service_tax value=$service_tax+$row->serviceTax}
                    {assign var=balance_amount value=$balance_amount+$row->transactionAmount}
                
                {/foreach}
     
                <tr>
                    <td >{$trip[0]->user->group->name}</td>
                    <td align="center">{$ticket_count|number_format}</td>
                    <td align="right" class="">{$ticket_amount|number_format:2}</td>
                    <td align="right" class="">{$comm_amount|number_format:2}</td>
                    <td align="right" class="">{$service_tax|number_format:2}</td>
                    <td align="right" class="">{$balance_amount|number_format:2}</td>
                </tr>
                
                {assign var=g_ticket_count value=$g_ticket_count+$ticket_count}
                {assign var=g_ticket_amount value=$g_ticket_amount+$ticket_amount}
                {assign var=g_comm_amount value=$g_comm_amount+$comm_amount}
                {assign var=g_service_tax value=$g_service_tax+$service_tax}
                {assign var=g_balance_amount value=$g_balance_amount+$balance_amount}
                
            {/foreach}  
            <tr class="active bold">
                <td class="bold text-danger" align="right">Grand Total</td>
                <td align="center" class="">{$g_ticket_count}</td>
                <td align="right" class="">{$g_ticket_amount|number_format:2}</td>
                <td align="right" class="">{$g_comm_amount|number_format:2}</td>
                <td align="right" class="">{$g_service_tax|number_format:2}</td>
                <td align="right" class="">{$g_balance_amount|number_format:2}</td>
            </tr>
        </tbody>
    </table>                
</div>        