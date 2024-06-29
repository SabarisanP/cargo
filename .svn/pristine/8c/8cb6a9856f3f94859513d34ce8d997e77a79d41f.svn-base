<table class="" width="95%">
    <tr>
        <td  colspan="12" align="center"><span class="bold">Phone {if $smarty.request.filterTypeCode == 'PBL'}Booked{else} Booking Cancelled{/if} Details</span></td>
    </tr>
    <tr>
        <td width="50%">From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
</table>
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
                {if $smarty.request.filterTypeCode == 'PBC'}
                    <td align="center">Cancelled By</td>
                {/if}
                <td align="center">User Group</td>                              
                <td align="center">Seats</td> 
                <td align="center">Tck Amt</td>
            </tr>
        </thead>
        <tbody class="body_table"> 
            {if count($result) > 0}
                {assign var=total value=0}
                {foreach item=row from=$result key=k}
                    <tr>
                        <td>{$k+1}</td>
                        <td><a href="javascript:;" onclick="getTicketHistory('{$row->ticket_code}')">{$row->ticket_code}</a></td>
                        <td>{$row->from_station_name} - {$row->to_station_name}</td>
                        <td>{$row->user_name}</td>
                        <td>{$row->transaction_date|date_format:$ns_datetime_format}</td>
                        <td>{$row->travel_date|date_format:$ns_date_format}</td>
                        {if $smarty.request.filterTypeCode == 'PBC'}
                            <td>{$row->cancelled_user_name}</td>
                        {/if}
                        <td>{$row->user_group_name}</td>
                        <td>{$row->seat_name}</td>
                        <td align="right">{$row->ticket_amount}</td>
                    </tr>
                    {$total = $total+$row->ticket_amount}
                {/foreach}    
                <tr>                    
                    <td {if $smarty.request.filterTypeCode == 'PBL'}colspan="8"{else}colspan="9"{/if} align="right" class="bold">Grand Total</td>
                    <td align="right" class="bold">{$total}</td>
                </tr>
            {else}
                <tr>                    
                    <td colspan="12" align="center">No data found</td>
                </tr>
            {/if}
        </tbody>
    </table>                
</div>