<table width="95%">
    <tr>
        <td  colspan="10" align="center">PhoneBook Cancellation Report</td>
    </tr>
    <tr>
        <td width="50%">
                {if $smarty.request.date_option==1} 
                    Trip Date Wise 
                {else}
                    Booked Date Wise
                {/if} 
                From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} 
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}
        </td>
    </tr>
</table>
        
{assign var=g_c_ticket_count value=0}
{assign var=g_c_ticket_amount value=0}

        
<div class="table-responsive">
    <table class="table table-bordered widthed">
        <thead>
            <tr class="success">
                <td align="center">#</td>
                <td align="center">PNR</td>
                <td align="center">Route</td>
                <td align="center">Booked By</td>
                <td align="center">Booked Date</td>
                <td align="center" nowrap>Travel Date</td>
                <td align="center" nowrap>Cancelled Date</td>
                <td align="center">Group</td>
                <td align="center">Cancelled By</td>
                <td align="center">Status</td>                                
                <td align="center">Seats</td> 
                <td align="center">Tck Amt</td>
                           
            </tr>
            
        </thead>
        <tbody class="body_table">               
            {foreach item=row from=$transactions key=t name=feticket}
                {if $row->ticket_status_code=="PBC"}
                <tr> 
                    <td>{$smarty.foreach.feticket.index+1}</td>
                    <td><a href="javascript:;" onclick="getTicketHistory('{$row->ticket_code}')">{$row->ticket_code}</a></td>
                    <td>{$row->from_station_name} - {$row->to_station_name}</td>
                    <td>{$row->user_name}</td>
                    <td align="center" nowrap="">{$row->transaction_date|date_format:$ns_date_format}</td>
                    <td align="center" nowrap="">{$row->travel_date|date_format:$ns_date_format}</td>
                    <td align="center" nowrap="">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                    <td nowrap>{$row->user_group_name}</td>
                    <td>{$row->cancelled_user_name}</td>
                    <td>{$row->ticket_status_code}</td>
                                    
                    <td align="center">{$row->seat_name}</td>   
                    <td align="right">{$row->ticket_amount}</td>                    
                </tr>
                

                {assign var=g_c_ticket_count value=$g_c_ticket_count+$row->seat_count}
                {assign var=g_c_ticket_amount value=$g_c_ticket_amount+$row->ticket_amount}
                
                {/if}
                
            {/foreach}  
            <tr class="success bold">                    
                    <td colspan="11" align="right">Grand Total</td>
                    <td align="right">{$g_c_ticket_amount}</td>                   
                </tr>
        </tbody>
    </table>                
</div>
                
<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCancellationExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>
