<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Business Detailed Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>

<div  id="cargo_revenue_report_cont">
    <table id="cargo_revenue_report_table" class="table table-bordered " style="width:99%">
        <thead>
            <tr class="success">                
                <th>Trip Date</th>
                <th>{lang('lr')} Number</th>
                <th>{lang('ogpl')} Number</th>
                <th>Origin</th>
                <th>Destination</th>
                <th>{lang('booking_sender_term')} </th>
                <th>{lang('booking_receiver_term')}</th>
                <th>{lang('booking_sender_term')} GST</th>
                <th>{lang('booking_receiver_term')} GST</th>
                <th>Vehicle Number</th>
                <th>Payment Mode</th>
                <th>Number of Articles</th>
                <th>Service Charges</th>
                <th>Freight </th>
                <th>Total Amount</th>
                <th>Paid Amount</th>
                <th>Topay Amount</th>
                <th>OnAccount Amount</th>
                <th>Pickup Charges</th>
                <th>Delivery Charges</th>
                <th>Booking Commission</th>
                <th>Delivery Commission</th>
                <th>Net Receivable</th>               
            </tr>
        </thead>
        <tbody class="body_table">

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

            {foreach item=row from=$result key=i}
                <tr>
                    <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                    <td align="left" nowrap>{$row->alias_code}</td>                    
                    <td align="left" nowrap>{$row->from_station_name} - {$row->from_organization_name}</td>
                    <td align="left" nowrap>{$row->to_station_name} - {$row->to_organization_name}</td>
                    <td align="left" nowrap>{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left" nowrap>{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td> 
                    <td align="left" nowrap>{($row->from_customer_gstin)? $row->from_customer_gstin: '-'}</td> 
                    <td align="left" nowrap>{($row->to_customer_gstin)? $row->to_customer_gstin: '-'}</td>           
                    <td align="left" nowrap>{($row->vehicle_registration_number) ? $row->vehicle_registration_number : '-'}</td>
                    <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>  
                    <td align="right">{$row->total_item_count}</td>                  
                    <td align="right">{$row->service_charge|inr_format}</td>
                    <td align="right">{$row->total_amount|inr_format}</td>
                    <td align="right">{($row->total_amount + $row->service_charge+$row->hamali_charge+$row->docket_charge+ $row->pass_charge+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pod_amount+$row->service_tax)|inr_format}</td>
                    <td align="right">
                        {if $row->payment_status_code == 'PAD'}
                            {$row->total_amount|inr_format}
                            {assign var=t_paid_amt value=$t_paid_amt + $row->total_amount}
                        {else}
                            0.00
                        {/if}
                    </td>
                    {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->pickup_handling_amount+$row->total_unload_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)-$row->transaction_amount}
                    <td align="right">
                        {if $row->payment_status_code == 'TOP' || $row->payment_status_code == 'TPPAD'}
                            {if $row->to_organization_name != $transit_organization_name}
                                {$row->total_amount|inr_format}
                                {assign var=t_topay_amt value=$t_topay_amt + $row->total_amount}
                            {/if}
                        {else}
                            0.00
                        {/if}
                    </td>
                    <td align="right">
                        {if $row->payment_status_code == 'INP' || $row->payment_status_code == 'OATP'}
                            {$row->total_amount|inr_format}
                            {assign var=t_credit_amt value=$t_credit_amt + $row->total_amount}
                        {else}
                            0.00
                        {/if}
                    </td>                   
                    <td align="right">{$row->pickup_handling_amount|inr_format}</td>
                    <td align="right">{$row->delivery_handling_amount|inr_format}</td>                  
                    <td align="right">{$row->booking_commission_amount|inr_format}</td>
                    <td align="right">{$row->delivery_commission_amount|inr_format}</td>
                    <td align="right">{($row->total_amount-$row->booking_commission_amount-$row->delivery_commission_amount)|inr_format}</td>                
                </tr>

                {assign var=t_min_weight value=$t_min_weight + $row->min_weight}
                {assign var=t_total_unit_value value=$t_total_unit_value + $row->total_unit_value}
                {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
                {assign var=t_docket_charge value=$t_docket_charge + $row->docket_charge}
                {assign var=t_pass_charge value=$t_pass_charge + $row->pass_charge}
                {assign var=t_service_charge value=$t_service_charge + $row->service_charge}
                {assign var=t_service_tax value=$t_service_tax + $row->service_tax}
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
                <tr class="active bold">
                    <td colspan="11" align="right">Total</td>
                    <td align='right'>{$t_total_item_count}</td>
                    <td align='right'>{$t_service_charge}</td>
                    <td align='right'>{$t_total_amount|inr_format}</td>
                    <td align='right'>{($t_total_amount+$t_service_charge+$t_docket_charge+$t_pass_charge+$t_service_tax+$t_pod_amount+$t_hamali_charge+$t_total_handling_amount+$t_total_unload_handling_amount)|inr_format}</td>
                    <td align='right'>{$t_paid_amt|inr_format}</td>
                    <td align='right'>{$t_topay_amt|inr_format}</td>
                    <td align='right'>{$t_credit_amt|inr_format}</td>
                    <td align='right'>{$t_pickup_handling_amount|inr_format}</td>
                    <td align='right'>{$t_delivery_handling_amount|inr_format}</td>
                    <td align='right'>{$t_booking_commission_amount|inr_format}</td>
                    <td align='right'>{$t_delivery_commission_amount|inr_format}</td>
                    <td align='right'>{$t_net_receivable|inr_format}</td>                    
                </tr>
            </tfoot>
        {/if}
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportRevenueExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>

<script>
    var table = $('#cargo_revenue_report_table').DataTable({
        scrollY: "500px",
        scrollX: true,
        scrollCollapse: true,
        searching: false,
        paging: false,
        ordering: false
    });
    
</script>

<style>
    #cargo_revenue_report_cont div.DTFC_LeftHeadWrapper table, 
    #cargo_revenue_report_cont div.DTFC_LeftFootWrapper table, 
    #cargo_revenue_report_cont div.DTFC_RightHeadWrapper table, 
    #cargo_revenue_report_cont div.DTFC_RightFootWrapper table, 
    #cargo_revenue_report_cont table.DTFC_Cloned tr.odd {
        background-color: white;
    }

    #cargo_revenue_report_table_wrapper > .well {
        display: none;
    }
</style>