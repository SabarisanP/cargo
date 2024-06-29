<table width="95%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Consolidated Booking Report</td>
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
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table>
        
{assign var=g_b_ticket_count value=0}
{assign var=g_b_ticket_amount value=0}
{assign var=g_b_comm_amount value=0}
{assign var=g_b_service_tax value=0}

{assign var=g_c_ticket_count value=0}
{assign var=g_c_ticket_amount value=0}
{assign var=g_c_charges value=0}
{assign var=g_c_service_tax value=0}

{assign var=g_pb_ticket_count value=0}
{assign var=g_pbb_ticket_count value=0}
{assign var=g_pbc_ticket_count value=0}
        
<div class="table-responsive">
    <table class="table table-bordered widthed">
        <thead>
            <tr class="success">
                <td rowspan="2" align="center">#</td>
                <td rowspan="2" align="center">PNR</td>
                <td rowspan="2" align="center">Route</td>
                <td rowspan="2" align="center" nowrap>Travel Date</td>
                <td rowspan="2" align="center" nowrap>Booked Date</td>
                <td rowspan="2">Group</td>
                <td rowspan="2">User</td>
                <!-- <td rowspan="2">Email</td> -->
                <td rowspan="2">Phone</td>
                
                <td align="center" colspan="5">Booked</td> 
                <td align="center" colspan="5">Cancel</td> 
                
            </tr>
            <tr class="success">                
                <td align="center">Seats</td>
                <td align="center" nowrap>Ph BL</td>
                <td align="center" nowrap>Tck Amt</td>
                <td align="center" nowrap>To Pay</td>
                <td align="center">S.Tax</td>                  
                
                <td align="center">Seats</td> 
                <td align="center" nowrap>Tck Amt</td>
                <td align="center">Charges</td>
                <td align="center">Refund</td>
                <td align="center">S.Tax</td>                  
            </tr>
        </thead>
        <tbody class="body_table">               
            {foreach item=row from=$transactions key=t name=feticket}
                <tr> 
                    <td>{$smarty.foreach.feticket.index+1}</td>
                    <td>{$row->ticket_code}</td>
                    <td>{$row->from_station_name} - {$row->to_station_name}</td>
                    <td align="center" nowrap>{$row->travel_date|date_format:$ns_date_format}</td>
                    <td align="center" nowrap>{$row->transaction_date|date_format:$ns_datetime_format}</td>
                    <td nowrap>{$row->user_group_name}</td>
                    <td>{$row->user_name}</td>
                    <!-- <td>{$row->email_id}</td> -->
                    <td>{$row->mobile_number}</td>

                    <td align="center">{$row->booked_count}</td>  
                    <td align="center">{$row->phone_blocked_count}</td>  
                    <td align="right">{$row->booked_amount|number_format:2}</td>
                    <td align="right">{$row->phone_blocked_amount|number_format:2}</td>
                    <td align="right">{$row->booked_service_tax|number_format:2}</td>

                    <td align="center">{$row->cancelled_count}</td>   
                    <td align="right">{$row->cancelled_amount|number_format:2}</td>
                    <td align="right">{$row->cancellation_charges|number_format:2}</td>
                    <td align="right">{$row->refund_amount|number_format:2}</td>
                    <td align="right">{$row->cancelled_ac_bus_tax|number_format:2}</td>
                </tr>
                
                {assign var=g_b_ticket_count value=$g_b_ticket_count+$row->booked_count}
                {assign var=g_b_phone_booked_amount value=$g_b_phone_booked_amount+$row->booked_amount}
                {assign var=g_b_ticket_amount value=$g_b_ticket_amount+$row->booked_amount}
                {assign var=g_b_phone_blocked_amount value=$g_b_phone_blocked_amount+$row->phone_blocked_amount}
                {assign var=g_b_comm_amount value=$g_b_comm_amount+$row->booked_commission_amount}
                {assign var=g_b_service_tax value=$g_b_service_tax+$row->booked_service_tax}

                {assign var=g_c_ticket_count value=$g_c_ticket_count+$row->cancelled_count}
                {assign var=g_c_ticket_amount value=$g_c_ticket_amount+$row->cancelled_amount}
                {assign var=g_c_charges value=$g_c_charges+$row->cancellation_charges}
                {assign var=g_c_refund value=$g_c_refund+$row->refund_amount}
                {assign var=g_c_service_tax value=$g_c_service_tax+$row->cancelled_ac_bus_tax}

                {assign var=g_pb_ticket_count value=$g_pb_ticket_count+$row->phone_booked_count}
                {assign var=g_pbb_ticket_count value=$g_pbb_ticket_count+$row->phone_blocked_count}
                {assign var=g_pbc_ticket_count value=$g_pbc_ticket_count+$row->phone_booked_cancelled_count}
                
            {/foreach}  
            <tr class="success bold">                    
                    <td colspan="8" align="right">Grand Total</td>

                    <td align="center" id="tkt_booked">{$g_b_ticket_count}</td>  
                    <td align="center" id="tkt_pb_blocked">{$g_pbb_ticket_count}</td>  
                    <td align="right">{$g_b_ticket_amount|number_format:2}</td>
                    <td align="right">{$g_b_phone_blocked_amount|number_format:2}</td>
                    <td align="right">{$g_b_service_tax|number_format:2}</td>

                    <td align="center" id="tkt_canceled">{$g_c_ticket_count}</td>   
                    <td align="right">{$g_c_ticket_amount|number_format:2}</td>
                    <td align="right">{$g_c_charges|number_format:2}</td>
                    <td align="right">{$g_c_refund|number_format:2}</td>
                    <td align="right">{$g_c_service_tax|number_format:2}</td>
                </tr>
        </tbody>
    </table>                
</div>
                
<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportConsolidateExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>
<script>
    var book_summary={$book_summary|json_encode};
    var cancel_summary={$cancel_summary|json_encode};
</script>    
