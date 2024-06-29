<table width="95%">
    <tr>
        <td  colspan="10" align="center">Cancellation Report</td>
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
        
{assign var=g_b_ticket_count value=0}
{assign var=g_b_ticket_amount value=0}
{assign var=g_b_comm_amount value=0}
{assign var=g_b_service_tax value=0}

{assign var=g_c_ticket_count value=0}
{assign var=g_c_ticket_amount value=0}
{assign var=g_c_revoke_amount value=0}
{assign var=g_c_charges value=0}
{assign var=g_c_agent_charges value=0}
{assign var=g_c_discount value=0}
{assign var=g_c_service_tax value=0}

{assign var=g_pb_ticket_count value=0}
{assign var=g_pbb_ticket_count value=0}
{assign var=g_pbc_ticket_count value=0}
        
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
                <td align="center">PG</td>
                <td align="center">Refund</td>
                                
                <td align="center">Seats</td> 
                <td align="center">Tck Amt</td>
                <td align="center">Revoke Comm</td>
                <td align="center">Canc Charges</td>
                <td align="center">Agent Charges</td>
                <td align="center">Discount</td>
                <td align="center">Refund</td>                
            </tr>
            
        </thead>
        <tbody class="body_table">               
            {foreach item=row from=$transactions key=t name=feticket}
                <tr> 
                    <td>{$smarty.foreach.feticket.index+1}</td>
                    <td><a href="javascript:;" onclick="getTicketHistory('{$row->ticket_code}')">{$row->ticket_code}</a></td>
                    <td>{$row->from_station_name} - {$row->to_station_name}</td>
                    <td>{$row->booked_user_name}</td>
                    <td align="center" nowrap="">{$row->booked_transaction_date|date_format:$ns_date_format}</td>
                    <td align="center" nowrap="">{$row->travel_date|date_format:$ns_date_format}</td>
                    <td align="center" nowrap="">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                    <td nowrap>{$row->user_group_name}</td>
                    <td>{$row->cancelled_user_name}</td>
                    <td>{$row->ticket_status_code}</td>
                    <td>{$row->payment_gateway_provider_name}</td>
                    <td><span title="{$refund_status[$row->refund_status]}">{$row->refund_status}</span></td>
                                    
                    <td align="center">{$row->seat_count}</td>   
                    <td align="right">{$row->ticket_amount}</td>
                    <td align="right">{$row->revoke_commission_amount}</td>
                    <td align="right">{$row->cancellation_charges}</td>
                    <td align="right">{$row->cancel_commission}</td>
                    <td align="right">{$row->addons_amount}</td>
                    <td align="right">{$row->refund_amount}</td>
                    
                </tr>
                

                {assign var=g_c_ticket_count value=$g_c_ticket_count+$row->seat_count}
                {assign var=g_c_ticket_amount value=$g_c_ticket_amount+$row->ticket_amount}
                {assign var=g_c_revoke_amount value=$g_c_revoke_amount+$row->revoke_commission_amount}
                {assign var=g_c_charges value=$g_c_charges+$row->cancellation_charges}
                {assign var=g_c_agent_charges value=$g_c_agent_charges+$row->cancel_commission}
                {assign var=g_c_refund value=$g_c_refund+$row->refund_amount}
                {assign var=g_c_service_tax value=$g_c_service_tax+$row->cancelled_ac_bus_tax}
                {assign var=g_c_discount value=$g_c_discount+$row->addons_amount}

                {assign var=g_pb_ticket_count value=$g_pb_ticket_count+$row->phone_booked_count}
                {assign var=g_pbb_ticket_count value=$g_pbb_ticket_count+$row->phone_blocked_count}
                {assign var=g_pbc_ticket_count value=$g_pbc_ticket_count+$row->phone_booked_cancelled_count}
                
            {/foreach}  
            <tr class="success bold">                    
                    <td colspan="12" align="right">Grand Total</td>

                    <td align="center" id="tkt_canceled">{$g_c_ticket_count}</td>   
                    <td align="right">{$g_c_ticket_amount}</td>
                    <td align="right">{$g_c_revoke_amount}</td>
                    <td align="right">{$g_c_charges}</td>
                    <td align="right">{$g_c_agent_charges}</td>
                    <td align="right">{$g_c_discount}</td>
                    <td align="right">{$g_c_refund}</td>                    
                </tr>
        </tbody>
    </table>                
</div>
                
<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCancellationExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>
<script>
    //var book_summary={$book_summary|json_encode};
    var cancel_summary={$cancel_summary|json_encode};
</script>    
