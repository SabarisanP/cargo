
<div class="table-responsive">
    <table class="table table-bordered user-balance-table" width="98%">
        <thead>
            <tr class="success">
                <th rowspan="2">Name</th>
                <th rowspan="2">Group</th>
                <th rowspan="2">Branch</th>
                <th rowspan="2">Station</th>
                {* <th rowspan="2">Payment Type</th> *}
                <th rowspan="2">Last Transaction At</th>
                <th rowspan="2">State</th>
                <th colspan="5">Booking Commissions	</th>
                <th colspan="5">Delivery Commissions</th>
                <th rowspan="2">Credit Limit</th>
                <th rowspan="2">TDS</th>
                <th rowspan="2">PAN No</th>
                <th rowspan="2">Current Balance</th>
            </tr>
            <tr class="success">
                <th>Paid LR</th>
                <th>Topay LR</th>
                <th>Accpay LR</th>
                <th>Door Pickup</th>
                <th>Loading Share</th>
                <th>Paid LR</th>
                <th>Topay LR</th>
                <th>Accpay LR</th>
                <th>Door Delivery</th>
                <th>Unloading Share</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach from=$result item=row}
                {if $row->user_role_code == 'USER'}
                    <tr>
                        <td>{$row->first_name}</td>
                        <td>{$row->user_group_name}</td>
                        <td>{$row->organization_name}</td>
                        <td>{$row->station_name}</td>
                        {* <td>{$row->payment_type_code}</td> *}
                        <td nowrap>{$row->last_transaction_date|date_format:$ns_datetime_format}</td>
                        <td>{$row->state_name}</td>
                        <td nowrap>{$row->paid_commission}</td>
                        <td nowrap>{$row->topay_commission}</td>
                        <td nowrap>{$row->accpay_commission}</td>
                        <td nowrap>{$row->door_pickup_commission}</td>
                        <td nowrap>{$row->loading_commission}</td>
                        <td nowrap>{$row->delivery_paid_commission}</td>
                        <td nowrap>{$row->delivery_topay_commission}</td>
                        <td nowrap>{$row->delivery_accpay_commission}</td>
                        <td nowrap>{$row->door_delivery_commission}</td>
                        <td nowrap>{$row->unloading_commission}</td>
                        <td align="right" nowrap>{$row->credit_limit}</td>
                        <td nowrap>{$row->tds_tax|default:'-'}</td>
                        <td nowrap>{$row->pan_card_no|default:'-'}</td>
                        <td align="right"  data-format="{$xlformat['currency']}" nowrap>{$row->current_balance}</td>
                    </tr>
                {/if}
            {/foreach}
        </tbody>
    </table>
</div>
