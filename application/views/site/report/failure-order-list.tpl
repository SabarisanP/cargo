<div class="table-responsive">
    <table id="dt_failure_order_list" class="table table-striped">
        <thead>
            <tr>            	
                <th>Txn Id</th>
                <th>PNR</th>
                <th>Medium / Gateway</th>
                <th>From - To</th>
                <th>DOJ</th> 
                <th>User</th>
                <th>Pax Mobile</th>
                <th>Pax Email</th>
                <th>Seats</th>
                <th>Fare</th>
                <th>Txn Date</th>
                <th></th>
            </tr>
        </thead>
        <tbody class="body_table">
            {if $pending_orders->data|count==0}
                <tr>
                    <td colspan="12" align="center">Sorry! No data found</td>
                </tr>
            {else}    
                {foreach item=row from=$pending_orders->data key=k name=plist}
                    <tr>                	
                        <td>{$row->booking_code}</td>
                        <td><a href="javascript:;" onclick="PrintTck('{$row->ticket_code}');" title="click to know ticket details">{$row->ticket_code}</a></td>
                        <td>{$row->devicemedium} / <span class="text-muted">{($row->provider_name) ? $row->provider_name : '-'}</span></td>
                        <td>{$row->from_station_name} - {$row->to_station_name}</td>
                        <td nowrap="">{$row->travel_date|date_format:$ns_date_format}</td>
                        <td>{$row->user_first_name}</td>
                        <td>{$row->mobile_number}</td>
                        <td>{$row->email_id}</td> 
                        <td>{$row->seat_name}</td>
                        <td>{$row->ticket_amount}</td>
                        <td nowrap="">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                        <td align="right">
                            {if $row->devicemedium=="MOB" || $row->devicemedium=="APP" || $row->devicemedium=="WEB"}
                            <a href="javascript:;" class="btn-app btn-success" title="move to pending" onclick="failureToPending('{$row->ticket_code}');">Move Pending</a>
                            {/if}
                        </td>
                   </tr>
                {/foreach}   
            {/if}
        </tbody>
    </table>
 </div>
{if $pending_orders->data|count>0}
    {literal}
    <script>
        //$('#dt_failure_order_list').dataTable({   dom: '<"top"if>rt<"bottom"lp><"clear">' });
        //$('.bottom').addClass('well well-sm');
        //$('.bottom').css('height','51px');
        $('#dt_failure_order_list').dataTable({"bDestroy": true });
        $("select[name=dt_failure_order_list_length]").val("50").change();
    </script>
    {/literal}
{/if}