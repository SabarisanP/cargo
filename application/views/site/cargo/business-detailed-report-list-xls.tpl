<table border="1">
    <tr>
        <td colspan="6" align="center"><b>Business Detailed Report</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$username} </td>
    </tr>
</table>

<table border="1">
    <thead>
        <tr style="background-color: #64b92a; color: #fff;">
            <th align="left">Trip Date</th>
            <th align="left">{lang('lr')} Number</th>
            <th align="left">{lang('ogpl')} Number</th>
            <th align="left">Origin</th>
            <th align="left">Destination</th>
            <th align="left">{lang('booking_sender_term')} </th>
            <th align="left">{lang('booking_receiver_term')}</th>
            <th align="left">{lang('booking_sender_term')} GST</th>
            <th align="left">{lang('booking_receiver_term')} GST</th>
            <th align="left">Vehicle Number</th>
            <th align="left">Payment Mode</th>
            <th align="left">Number of Articles</th>
            <th align="left">Service Charges</th>
            <th align="left">Freight</th>
            <th align="left">Hamali Charges</th>
            <th align="left">Docket Charges</th>
            <th align="left">Pass Charges</th>
            <th align="left">Loading Charges</th>
            <th align="left">UnLoading Charges</th>
            <th align="left">POD Charges</th>
            <th align="left">GST</th>
            <th align="left">Total Amount</th>
            <th align="left">Paid Amount</th>
            <th align="left">Topay Amount</th>
            <th align="left">On Account Amount</th>
            <th align="left">Pickup Charges</th>
            <th align="left">Delivery Charges</th>
            <th align="left">Booking Commission</th>
            <th align="left">Delivery Commission</th>
            <th align="left">Net Receivable</th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_total_item_count value=0}
        {assign var=t_docket_charge value=0}
        {assign var=t_pass_charge value=0}
        {assign var=t_service_charge value=0}
        {assign var=t_service_tax value=0}
        {assign var=t_hamali_charge value=0}
        {assign var=t_transaction_amount value=0}
        {assign var=t_delivery_handling_amount value=0}
        {assign var=t_total_handling_amount value=0}
        {assign var=t_total_unload_handling_amount value=0}
        {assign var=t_booking_handling_commission_amount value=0}
        {assign var=t_pickup_handling_amount value=0}
        {assign var=t_booking_commission_amount value=0}
        {assign var=t_total_amount_paid value=0}
        {assign var=t_total_amount value=0}
        {assign var=t_net_amount value=0}
        {assign var=t_net_receivable value=0}
        {assign var=t_other_charge value=0}

        {foreach item=row from=$result key=i}
            <tr>
                <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->cargo_code}</td>
                <td align="left" nowrap>{$row->alias_code}</td>
                <td align="left" nowrap>{$row->from_station_name} - {$row->from_organization_name}</td>
                <td align="left" nowrap>{$row->to_station_name} - {$row->to_organization_name}</td>
                <td align="left" nowrap>{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                <td align="left" nowrap>{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td>
                <td align="left" nowrap>{($row->from_customer_gstin)? $row->from_customer_gstin: '-'}</td>
                <td align="left" nowrap>{($row->to_customer_gstin)? $row->to_customer_gstin: '-'}</td>
                <td align="left" nowrap>{($row->vehicle_registration_number) ? $row->vehicle_registration_number : '-'}</td>
                <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_item_count}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->service_charge}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->hamali_charge}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->docket_charge}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->pass_charge}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_unload_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->pod_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->service_tax}</td>

                <td align="right" data-format="{$xlformat['currency']}">
                    {assign var=t_net value=$row->total_amount + $row->service_charge+$row->hamali_charge+$row->docket_charge+ $row->pass_charge+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pod_amount+$row->service_tax}
                    {$t_net}</td>
                <td align="right" data-format="{$xlformat['currency']}">
                    {if $row->payment_status_code == 'PAD'}
                        {$t_net}
                        {assign var=t_paid_amt value=$t_paid_amt + $t_net}
                    {else}
                        0.00
                    {/if}
                </td>
                {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->pickup_handling_amount+$row->total_unload_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)-$row->transaction_amount}
                <td align="right" data-format="{$xlformat['currency']}">
                    {if $row->payment_status_code == 'TOP' || $row->payment_status_code == 'TPPAD'}
                        {if $row->to_organization_name != $transit_organization_name}
                            {$t_net}
                            {assign var=t_topay_amt value=$t_topay_amt + $t_net}
                        {/if}
                    {else}
                        0.00
                    {/if}
                </td>
                <td align="right" data-format="{$xlformat['currency']}">
                    {if $row->payment_status_code == 'INP' || $row->payment_status_code == 'OATP'}
                        {$t_net}
                        {assign var=t_credit_amt value=$t_credit_amt + $t_net}
                    {else}
                        0.00
                    {/if}
                </td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->pickup_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->delivery_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->booking_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->delivery_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{($row->total_amount-$row->booking_commission_amount-$row->delivery_commission_amount)}</td>
            </tr>

            {assign var=t_min_weight value=$t_min_weight + $row->min_weight}
            {assign var=t_total_unit_value value=$t_total_unit_value + $row->total_unit_value}
            {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
            {assign var=t_docket_charge value=$t_docket_charge + $row->docket_charge}
            {assign var=t_pass_charge value=$t_pass_charge + $row->pass_charge}
            {assign var=t_service_charge value=$t_service_charge + $row->service_charge}
            {assign var=t_service_tax value=$t_service_tax + $row->service_tax}
            {assign var=t_other_charge value=$t_other_charge + $row->other_charges_amount}
            {assign var=t_pod_amount value=$t_pod_amount + $row->pod_amount}
            {assign var=t_hamali_charge value=$t_hamali_charge + $row->hamali_charge}
            {assign var=t_transaction_amount value=$t_transaction_amount + $row->transaction_amount}
            {assign var=t_delivery_handling_amount value=$t_delivery_handling_amount + $row->delivery_handling_amount}
            {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
            {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
            {assign var=t_booking_handling_commission_amount value=$t_booking_handling_commission_amount + $row->booking_handling_commission_amount}
            {assign var=t_pickup_handling_amount value=$t_pickup_handling_amount + $row->pickup_handling_amount}
            {assign var=t_booking_commission_amount value=$t_booking_commission_amount + $row->booking_commission_amount}
            {assign var=t_delivery_commission_amount value=$t_delivery_commission_amount + $row->delivery_commission_amount}
            {assign var=t_total_amount_paid value=$t_total_amount_paid + $row->total_amount_paid}
            {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
            {assign var=t_invoice_value value=$t_invoice_value + $row->invoice_value}
            {assign var=t_net_amount value=$t_net_amount + $net_amount}
            {assign var=t_service_cgs value=$t_service_cgs + $service_cgs}
            {assign var=t_net_receivable value=$t_net_receivable + ($row->total_amount-$row->booking_commission_amount-$row->delivery_commission_amount)}
        {/foreach}
    </tbody>
    {if $result|count}
        <tfoot>
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td colspan="11" align="right">Total</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_total_item_count}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_service_charge}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_total_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_hamali_charge}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_docket_charge}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_pass_charge}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_total_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_total_unload_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_pod_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_service_tax}</td>
                <td align="right" data-format="{$xlformat['currency']}">{($t_total_amount+$t_service_charge+$t_docket_charge+$t_pass_charge+$t_service_tax+$t_pod_amount+$t_hamali_charge+$t_total_handling_amount+$t_total_unload_handling_amount)}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_paid_amt}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_topay_amt}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_credit_amt}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_pickup_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_delivery_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_booking_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_delivery_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$t_net_receivable}</td>
            </tr>
        </tfoot>
    {else}
        <tfoot>
            <tr>
                <td colspan="30" align="center">No Records Found</td>
            </tr>
        </tfoot>
    {/if}
</table>
