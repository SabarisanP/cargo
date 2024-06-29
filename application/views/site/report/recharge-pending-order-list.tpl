<div class="table-responsive">
    <table id="dt_pending_order_list" class="table table-striped">
        <thead>
            <tr>            	
                <th>User Name&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                <th>Order code&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                <th>Transaction Date&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                <th>Gateway&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                <th>Transaction Amount&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {if $pending_orders->data|count==0}
                <tr>
                    <td colspan="6" align="center">Sorry! No data found</td>
                </tr>
            {else}    
                {foreach item=row from=$pending_orders->data key=k name=plist}
                    <tr id="row-{$row->order_code}">
                        <td>{$row->user_first_name}</td>
                        <td>{$row->order_code}</td>
                        <td>{$row->transaction_date|date_format:$ns_datetime_format}</td> 
                        <td>{$row->provider_name}</td>
                        <td>{$row->transaction_amount} </td>
                        <td>
                            <button class="btn-app btn-success" type="button" onclick="doConfirmPendingOrder('{$row->order_code}');">Confirm</button>                           
                            <button class="btn-app btn-danger" type="button" onclick="cancelPendingOrder('{$row->order_code}', '{$row->order_code}');">Reject</button>                            
                        </td>
                    </tr>
                {/foreach}   
            {/if}
            
        </tbody>
    </table>
     <div align="center" class="clear_fix_both hidden" id="po-action-msg"></div>       
</div>
{if $pending_orders->data|count>0}
    {literal}
        <script>
            $('#dt_pending_order_list').dataTable({"bDestroy": true});
            $("select[name=dt_pending_order_list_length]").val("50").change();
        </script>
    {/literal}
{/if}