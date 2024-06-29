<table class="" width="95%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Free Ticket Transaction</td>
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

{assign var=g_b_ticket_count value=0}

<div class="table-responsive">
    <table class="table table-bordered widthed">
        <thead>
            <tr class="success">
                <td align="center">#</td>
                <td align="center">PNR</td> 
                <td align="center">Travel Date</td>
                <td align="center">Transaction Date</td>
                <td align="center">User Name</td>
                <td align="center">Route</td>                                
                <td align="center">Mobile Number</td>                 
                <td align="center">Ticket Status</td>
                <td align="center">Seat Count</td>
                <td align="center">Remarks</td>
            </tr>
        </thead>
        <tbody class="body_table">               
            {foreach item=row from=$result key=t name=feticket}
                <tr> 
                    <td align="center">{$smarty.foreach.feticket.index+1}</td>
                    <td align="left">{$row->ticket_code}</td>
                    <td align="center">{$row->travel_date|date_format:$ns_date_format}</td>
                    <td align="center">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->name}</td>
                    <td align="left">{$row->from_station_name} - {$row->to_station_name}</td>                    
                    <td align="center" nowrap>{$row->mobile_number}</td>
                    <td align="center">{$row->ticket_status_code}</td>
                    <td align="right" nowrap>{$row->seat_count}</td>
                    <td align="left">{$row->remarks}</td>
                </tr>
                {assign var=g_c_ticket_count value=$g_c_ticket_count+$row->seat_count}
            {/foreach}
            <tr class="active bold">                    
                <td colspan="8" align="right">Grand Total</td>
                <td align="right" id="tkt_canceled">{$g_c_ticket_count}</td>
                <td align="center" id="tkt_canceled"></td>                     
            </tr>
        </tbody>
    </table>                
</div>


<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
{*        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>*}
    </div>
</div>       

