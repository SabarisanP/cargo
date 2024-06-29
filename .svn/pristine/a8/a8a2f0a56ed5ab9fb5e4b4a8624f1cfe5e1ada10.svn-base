<div class="">
    <button class="btn btn-success btn-xs" onclick="changeArticleStatus('CUL')" style="display:none;" id="btn-unload">UnLoad</button>&nbsp;
    <button class="btn btn-success btn-xs" onclick="changeArticleStatus('CD')" style="display:none;" id="btn-delivered">Make Delivery</button> &nbsp;
    <button class="btn btn-success btn-xs" onclick="changeArticleStatus('CUD')" style="display:none;" id="btn-undeliver">Unable to Deliver</button>&nbsp;
    <!--<button class="btn btn-success btn-xs" onclick="changeArticleStatus('PAD')" style="display:none;" id="btn-paid">Paid</button> &nbsp;-->
    <button class="btn btn-success btn-xs" onclick="changeArticleStatus('CR')" style="display:none;" id="btn-return">Return</button> &nbsp;
    <span id="state-action" class=""></span>
</div>
<br>
<div class="tabbable">
    <table id="dt_adv_booking_report_table" class="table table-bordered " width="99%">
        <thead>
            <tr class="success">
                <td align="center" nowrap>{lang('cargo_code_term')} <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>Booked Date <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>Paid Date <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>{lang('booking_from_term')} <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>User <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>{lang('booking_to_label')} <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>{lang('booking_sender_term')} <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>{lang('booking_receiver_term')} <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>Payment Status <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>Cargo Status <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>Vendor <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>Qty <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>Net Payable <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>Paid <i class="fa fa-sort"></i></td>
                <td align="center" nowrap>To Pay <i class="fa fa-sort"></i></td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var="tot_qty_count" value = 0}
            {assign var="tot_net_pay" value = 0}
            {assign var="tot_paid" value = 0}
            {assign var="tot_to_pay" value = 0}
            {foreach item=row from=$result key=t}
                <tr>
                    <td align="center">
                        <a href='javascript:;' class="bold" title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a>
                        {if $namespace=='bits'}
                            &nbsp;
                            <a href='javascript:;' class="bold" title="histroy" onclick='getCargoHistory("{$row->cargo_code}")'><i class="fa fa-history fa-lg"></i></a>
                        {/if}
                    </td>
                    <td align="center">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="center">
                        {if $row->payment_date!=''}
                            {$row->payment_date|date_format:$ns_datetime_format}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="center">{$row->from_organization_name}</td>
                    <td align="center">{$row->user_first_name}</td>
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="center" id='pay_state_{$row->cargo_code}'>
                        {$row->payment_status_code|_cargo_payment_status_badge}
                    </td>
                    <td align="center">{$cargo_status[$row->cargo_status_code]}</td>
                    <td align="center">
                        {if $row->vendor_user_name!=''}
                            {$row->vendor_user_name}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="center">{$row->total_item_count}</td>
                    <td align="right">
                        {($row->total_booking_amount+$row->total_handing_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)|number_format}
                    </td>
                    <td align="right">
                        {$row->total_paid_amount|number_format}
                    </td>
                    <td align="right">
                        {(($row->total_booking_amount+$row->total_handing_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)-$row->total_paid_amount)|number_format}
                    </td>

                </tr>
                {assign var="tot_qty_count" value=$tot_qty_count + $row->total_item_count}
                {assign var="tot_net_pay" value=$tot_net_pay + $row->total_booking_amount+$row->total_handing_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax}
                {assign var="tot_paid" value=$tot_paid + $row->total_paid_amount}
                {assign var="tot_to_pay" value=$tot_to_pay + $row->total_booking_amount+$row->total_handing_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax-$row->total_paid_amount}
            {/foreach}
        </tbody>

        {if $result|count}
            <tr class="active bold">
                <td colspan="11" align="right">Total</td>
                <td align='center'>{$tot_qty_count}</td>
                <td align='center'>{$tot_net_pay|inr_format}</td>
                <td align='center'>{$tot_paid|inr_format}</td>
                <td align='right'>{$tot_to_pay|inr_format}</td>
            </tr>
        {/if}
    </table>
</div>
<script>
    $(document).ready(function() {
        $('#dt_adv_booking_report_table').DataTable({
            "paging": false,
            "info": false,
            "order": [
                [1, "asc"]
            ],
            "searching": true
        });
    });
</script>