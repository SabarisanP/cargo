
<div class="table-responsive">
    <table class="table table-bordered user-balance-table m-0">
        <thead class="sticky-row-top">
            <tr class="success">
                <th class="valign-bottom" rowspan="2">Name<i class="fa fa-sort pull-right"></i></th>
                <th class="valign-bottom" rowspan="2">Branch<i class="fa fa-sort pull-right"></i></th>
                {* <th class="valign-bottom" rowspan="2">Payment Type<i class="fa fa-sort pull-right"></i></th> *}
                <th class="valign-bottom" rowspan="2">Last Transaction At<i class="fa fa-sort pull-right"></i></th>
                {if $cargo_setting->captureStateWiseCommissionFlag}
                    <th class="valign-bottom" rowspan="2">State<i class="fa fa-sort pull-right"></i></th>
                {/if}
                <th class="valign-bottom text-center" colspan="5">Booking Commissions	</th>
                <th class="valign-bottom text-center" colspan="5">Delivery  Commissions</th>
                <th class="valign-bottom" rowspan="2">Credit Limit<i class="fa fa-sort pull-right"></i></th>
                <th class="valign-bottom" rowspan="2">TDS<i class="fa fa-sort pull-right"></i></th>
                <th class="valign-bottom" rowspan="2">PAN No<i class="fa fa-sort pull-right"></i></th>
                <th class="valign-bottom" rowspan="2">Current Balance<i class="fa fa-sort pull-right"></i></th>
            </tr>
            <tr class="success">
                <th>Paid LR<i class="fa fa-sort pull-right"></i></th>
                <th>Topay LR<i class="fa fa-sort pull-right"></i></th>
                <th>Accpay LR<i class="fa fa-sort pull-right"></i></th>
                <th>Door Pickup<i class="fa fa-sort pull-right"></i></th>
                <th>Loading Share<i class="fa fa-sort pull-right"></i></th>
                <th>Paid LR<i class="fa fa-sort pull-right"></i></th>
                <th>Topay LR<i class="fa fa-sort pull-right"></i></th>
                <th>Accpay LR<i class="fa fa-sort pull-right"></i></th>
                <th>Door Delivery<i class="fa fa-sort pull-right"></i></th>
                <th>Unloading Share<i class="fa fa-sort pull-right"></i></th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach from=$result item=row}
                {if $row->user_role_code == 'USER'}
                    {if !$cargo_setting->captureStateWiseCommissionFlag && isNotNull($row->state_code)}
                        {continue}
                    {/if}
                    <tr>
                        <td>{$row->first_name}<br><small class="text-muted">{$row->user_group_name}</small> </td>
                        <td>{$row->organization_name}<br><small class="text-muted">{$row->station_name}</small> </td>
                        {* <td>{$row->payment_type_code}</td> *}
                        <td nowrap>{$row->last_transaction_date|date_format:$ns_datetime_format}</td>
                        {if $cargo_setting->captureStateWiseCommissionFlag}
                            <td>{$row->state_name|default:'-'}</td>
                        {/if}
                        <td align="right" nowrap>
                            {if $row->paid_commission_type == 'PER'}
                                {$row->paid_commission} %
                            {elseif $row->paid_commission_type == 'FLT'}
                                Rs. {$row->paid_commission}
                            {/if}
                        </td>
                        <td align="right" nowrap>
                            {if $row->topay_commission_type == 'PER'}
                                {$row->topay_commission} %
                            {elseif $row->topay_commission_type == 'FLT'}
                                Rs. {$row->topay_commission}
                            {/if}
                        </td>
                        <td align="right" nowrap>
                            {if $row->accpay_commission_type == 'PER'}
                                {$row->accpay_commission} %
                            {elseif $row->accpay_commission_type == 'FLT'}
                                Rs. {$row->accpay_commission}
                            {/if}
                        </td>
                        <td align="right" nowrap>
                            {if $row->door_pickup_commission_type == 'PER'}
                                {$row->door_pickup_commission} %
                            {elseif $row->door_pickup_commission_type == 'FLT'}
                                Rs. {$row->door_pickup_commission}
                            {/if}
                        </td>
                        <td align="right" nowrap>
                            {if $row->loading_commission_type == 'PER'}
                                {$row->loading_commission} %
                            {elseif $row->loading_commission_type == 'FLT'}
                                Rs. {$row->loading_commission}
                            {/if}
                        </td>
                        <td align="right" nowrap>
                            {if $row->delivery_paid_commission_type == 'PER'}
                                {$row->delivery_paid_commission} %
                            {elseif $row->delivery_paid_commission_type == 'FLT'}
                                Rs. {$row->delivery_paid_commission}
                            {/if}
                        </td>
                        <td align="right" nowrap>
                            {if $row->delivery_topay_commission_type == 'PER'}
                                {$row->delivery_topay_commission} %
                            {elseif $row->delivery_topay_commission_type == 'FLT'}
                                Rs. {$row->delivery_topay_commission}
                            {/if}
                        </td>
                        <td align="right" nowrap>
                            {if $row->delivery_accpay_commission_type == 'PER'}
                                {$row->delivery_accpay_commission} %
                            {elseif $row->delivery_accpay_commission_type == 'FLT'}
                                Rs. {$row->delivery_accpay_commission}
                            {/if}
                        </td>
                        <td align="right" nowrap>
                            {if $row->door_delivery_commission_type == 'PER'}
                                {$row->door_delivery_commission} %
                            {elseif $row->door_delivery_commission_type == 'FLT'}
                                Rs. {$row->door_delivery_commission}
                            {/if}
                        </td>
                        <td align="right" nowrap>
                            {if $row->unloading_commission_type == 'PER'}
                                {$row->unloading_commission} %
                            {elseif $row->unloading_commission_type == 'FLT'}
                                Rs. {$row->unloading_commission}
                            {/if}
                        </td>
                        <td align="right" nowrap>{$row->credit_limit}</td>
                        <td nowrap>{$row->tds_tax|default:'-'}</td>
                        <td nowrap>{$row->pan_card_no|default:'-'}</td>
                        <td align="right" nowrap>{$row->current_balance|inr_format}</td>
                    </tr>
                {/if}
            {/foreach}
        </tbody>
    </table>
</div>

<style>
    .popup_top.sticky-row-top {
        padding-top: 1em;
        margin-top: -1em;
        top: -1em;
    }
</style>

<script>
    $('.user-balance-table').DataTable({
        info: false,
        searching: true,
        paging: false,
        order: [],
        columnDefs: [{
            targets: 'no-sort',
            orderable: false,
        }]
    });
</script>