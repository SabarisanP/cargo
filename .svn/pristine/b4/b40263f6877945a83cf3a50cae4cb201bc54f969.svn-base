<div class="table-responsive">
    <table id="dt_pending_order_list" class="table table-striped">
        <thead>
            <tr>            	
                <th>Txn Id&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                <th>PNR&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                {if $namespace=='bits'}
                <th>Namespace&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                {/if}                
                <th>From - To&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                <th>DOJ&nbsp;&nbsp;<i class="fa fa-sort"></i></th> 
                <th>Pax Mobile&nbsp;&nbsp;<i class="fa fa-sort"></i></th> 
                <th>Pax Mail&nbsp;&nbsp;<i class="fa fa-sort"></i></th> 
                <th>Seats&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                <th>Medium / Gateway&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                <th>Fare&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                <th>Txn Date&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                <!--<th>Action</th>-->
            </tr>
        </thead>
        <tbody class="body_table">
            {if $pending_orders->data|count==0}
                <tr>
                    <td colspan="12" align="center">Sorry! No data found</td>
                </tr>
            {else}    
                {foreach item=row from=$pending_orders->data key=k name=plist}
                    <tr id="row-{$row->booking_code}">                     	
                        <td>{$row->booking_code}</td>
                        <td><a href="javascript:;" title="click  to confirm / cancel" onclick="confirmPendingTicket('{$row->trip_stage_code}', '{$row->ticket_code}', '{$row->booking_code}', '{$row->namespace_code}', '{$row->provider_name}');">{$row->ticket_code}</a></td>
                        {if $namespace=='bits'}
                        <td>{$row->namespace_name}</td>
                        {/if}                        
                        <td>{$row->from_station_name} - {$row->to_station_name}</td>
                        <td>{$row->travel_date|date_format:$ns_date_format}</td> 
                        <td>{$row->mobile_number}</td> 
                        <td>{$row->email_id}</td> 
                        <td>{$row->seat_name}</td>
                        <td>{$row->devicemedium} / <span class="text-muted">{$row->provider_name}</span></td>
                        <td>{$row->ticket_amount} </td>
                        <td>{$row->transaction_date|date_format:$ns_datetime_format}</td>
                        <!--<td>                        
                            <button class="btn-app btn-danger" type="button" onclick="cancelPendingTicket('{$row->ticket_code}','{$row->booking_code}');">Cancel</button>                            
                            <button class="btn-app btn-success" type="button" onclick="confirmPendingTicket('{$row->trip_stage_code}', '{$row->ticket_code}');">Confirm</button>                           
                        </td>-->
                    </tr>
                {/foreach}   
            {/if}
        </tbody>
    </table>
 </div>
{if $pending_orders->data|count>0}
    {literal}
    <script>
        $('#dt_pending_order_list').dataTable({"bDestroy": true });
        $("select[name=dt_pending_order_list_length]").val("50").change();
    </script>
    {/literal}
{/if}