<div class="table-responsive">
    <table id="dt_block_cancel_list" class="table table-striped">
        <thead>
            <tr>
            	<th>S.No</th>
                <th>Txn Id</th>
                <th>PNR</th>
                <th>Medium</th>
                <th>From - To</th>
                <th>DOJ</th>
                <th>User</th>
                <th>Mobile</th>
                <th>Seats</th>
                <th>Fare</th>
                <th>Txn Date</th>
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
                     	<td>{$smarty.foreach.plist.index+1}</td>
                        <td>{$row->booking_code}</td>
                        <td><a href="javascript:;" onclick="getTicketHistory('{$row->ticket_code}')" title="click to know ticket history">{$row->ticket_code}</a></td>
                        <td>{$row->devicemedium}</td>
                        <td>{$row->from_station_name} - {$row->to_station_name}</td>
                        <td>{$row->travel_date|date_format:$ns_date_format}</td>
                        <td>{$row->user_first_name}</td>
                        <td>{$row->mobile_number}</td>
                        <td>{$row->seat_name}</td>
                        <td>{$row->ticket_amount}</td>
                        <td>{$row->transaction_date|date_format:$ns_datetime_format}</td>
                    </tr>
                {/foreach}
            {/if}
        </tbody>
    </table>
 </div>
{if $pending_orders->data|count>0}
    {literal}
    <script>
        $('#dt_block_cancel_list').dataTable({
            dom: '<"top"if>rt<"bottom"lp><"clear">',
            pageLength : 50
        });
        $('.bottom').addClass('well well-sm');
        $('.bottom').css('height','51px');
    </script>
    {/literal}
{/if}