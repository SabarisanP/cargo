<div class="popup_top">
    <div class="row">
        <div class="col-md-10 bold ft_14">
            Zone Receivable Report Detail View
        </div>
        <div class="col-md-2">            
            <a class="align-right" onclick="closeDetailsDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>
<br>
<div class="table table-responsive">
    <table class="table table-bordered-light">
        <thead>
            <tr>                    
                <td class="bold">{lang('lr')} No</td>
                <td class="bold">Booked By / Date</td>
                {* <td class="bold">Booked by</td> *}
                <td class="bold">{lang('booking_from_term')}</td>
                <td class="bold">{lang('booking_to_label')}</td>
                <td class="bold">{lang('booking_sender_term')}</td>
                <td class="bold">{lang('booking_receiver_term')}</td>
                <td class="bold" align="center">Payment Status</td>
                <td class="bold" align="center">Cargo Status</td>
                <td class="bold" align="center">Qty</td>
                <td class="bold">Gross Amount</td>
                <td class="bold">Net Payable</td>
            </tr>
        </thead>
        <tbody>
            {assign var=total_item value=0}
            {assign var=total_gross_amt value=0}
            {assign var=total_net_payable value=0}

            {foreach item=row from=$detail}
                <tr>                        
                    <td width="10%">{$row->cargo_code} <br> {$row->transaction_type}</td>
                    <td width="11%">{$row->user_first_name}<br>{$row->booked_at|date_format:$ns_datetime_format}</td>
                    {* <td>{$row->user_first_name}</td> *}
                    <td width="12%">{$row->from_organization_name} <br> {$row->from_station_name}</td>
                    <td width="12%">{$row->to_organization_name} <br> {$row->to_station_name}</td>
                    <td width="10%">{$row->from_customer_name} <br> {$row->from_customer_mobile}</td>
                    <td width="10%">{$row->to_customer_name} <br> {$row->to_customer_mobile}</td>

                    <td align="center" width="8%">
                        {$row->payment_status_code|_cargo_payment_status_badge}
                    </td>

                    <td width="8%" align="center">{$cargo_status[$row->cargo_status_code]}</td>
                    <td width="5%" align="center">{$row->total_item_count}</td>
                    <td width="7%">{$row->net_amount|inr_format:2}</td>

                    {assign var=net_payable value=(($row->total_amount+$row->total_unload_handling_amount+$row->total_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->other_charges)-($row->commission_amount+$row->delivery_commission_amount+$row->handling_commission_amount+$row->unload_handling_commission_amount+$row->pickup_handling_commission_amount+$row->delivery_handling_commission_amount))}
                    <td width="7%">{$net_payable|number_format:2}</td>
                </tr>

                {assign var=total_item value=$total_item+$row->total_item_count}
                {assign var=total_gross_amt value=$total_gross_amt+$row->net_amount}
                {assign var=total_net_payable value=$total_net_payable+$net_payable}
            {foreachelse}
                <tr>
                    <td colspan="11" align="center">No data found</td>
                </tr>
            {/foreach}
        </tbody>

        <tfoot>
            <tr class="active">
                <td colspan="8" align="right">Total</td>

                <td align="center">{$total_item}</td>
                <td>{$total_gross_amt|number_format:2}</td>
                <td>{$total_net_payable|number_format:2}</td>
            </tr>
        </tfoot>
    </table>
</div>
