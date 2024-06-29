<table class="" width="95%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Cargo Transaction Report Summary</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span> 
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table> 
    
<h5><b>Summary</b></h5>
<table class="table table-bordered" style="width:auto;">
    <thead>
        <tr class="success">
            <td></td>
            <td class="bold" align="center">Freight (A)</td>
            <td class="bold" align="center">Handling Charges (B)</td>
            <td class="bold" align="center">Unloading Charges (C)</td>
            <td class="bold" align="center">GST (D)</td>
            <td class="bold" align="center">Pickup Charges (E)</td>
            <td class="bold" align="center">Delivery Charges (F)</td>
            <td class="bold" align="center">Connecting Charges (G)</td>
            <td class="bold" align="center">{lang('other_charges')} (H)</td>
            <td class="bold" align="center">Commission Amount (I)</td>
            <td class="bold" align="center">Net Amount (A+B+C+D+E+F+G+H-I)</td>
        </tr>   
    </thead>
    <tbody>
        {assign var=netpay value=0}
        {foreach item=row from=$summary}
            <tr>
                {if $row['freight']== 0}
                    {continue}
                {/if}
                <td class="bold">{$cargo_payment_status[$row['paycode']]}</td>
                <td align="right">{$row['freight']|inr_format}</td>
                <td align="right">{$row['handling']|inr_format}</td>
                <td align="right">{$row['unloading']|inr_format}</td>
                <td align="right">{$row['gst']|inr_format}</td>
                <td align="right">{$row['pickup']|inr_format}</td>
                <td align="right">{$row['delivery']|inr_format}</td>
                <td align="right">{$row['connecting']|inr_format}</td>
                <td align="right">{$row['service_charge']|inr_format}</td>
                <td align="right">{$row['commission']|inr_format}</td>
                <td align="right">{$row['netpayable']|inr_format}</td>
            </tr>
            {assign var=netpay value=$netpay+$row['netpayable']}
        {/foreach}
        <tr>
            <td colspan="10" class="bold" align="right">Total Amount</td>
            <td class="bold" align="right">{$netpay|inr_format}</td>
        </tr>
    </tbody>
</table>  

<br>
<table class="table table-bordered" style="width:auto;min-width: 500px">
    <thead>
        <tr class="success">
            <td class="bold">Payment Type</td>
            <td class="bold">{lang('lr')} Count</td>
            <td class="bold">Freight</td>
            <td class="bold">Net Amount</td>
        </tr>   
    </thead>
    <tbody>
        {foreach key=mode item=row from=$transaction_modes}
            <tr>
                <td class="bold">{$transaction_mode[$mode]}</td>
                <td align="right">{$row['count']|sigma:$tt_count}</td>
                <td align="right">{$row['freight']|sigma:$tt_freight|inr_format}</td>
                <td align="right">{$row['netpayable']|sigma:$tt_netpayable|inr_format}</td>
            </tr>
        {/foreach}
        <tr>
            <td class="bold" align="right">Total</td>
            <td class="bold" align="right">{$tt_count}</td>
            <td class="bold" align="right">{$tt_freight|inr_format}</td>
            <td class="bold" align="right">{$tt_netpayable|inr_format}</td>
        </tr>
    </tbody>
</table>

<h5><b>Transactions</b></h5>
<div class="overflow-x-auto">
    <table id="dt_adv_booking_report_table" class="table table-bordered " >
        <thead>
            <tr class="success">
                <th align="center">{lang('cargo_code_term')}</th>
                <th align="center">Booked By </th>
                <th align="center">{lang('booking_from_term')}</th>
                <th align="center">{lang('booking_to_label')}</th>
                <th align="center">{lang('booking_sender_term')}</th>
                <th align="center" nowrap>{lang('booking_receiver_term')}</th>
                <th align="center">Payment Status
                <select id="paymentStatusFilter" class="form-control" multiple="multiple">
                    {assign var=uniquePaymentStatuses array()}
                    {foreach item=paydata from=$result key=t}
                        {if !in_array($paydata->payment_status_code, $uniquePaymentStatuses)}
                            {assign var="uniquePaymentStatuses" value=array_merge($uniquePaymentStatuses, [$paydata->payment_status_code])}
                            <option value="{$paydata->payment_status_code}"> {$paydata->payment_status_code|_cargo_payment_status_badge}</option>
                        {/if}
                     {/foreach}
                </select>
                </th>


                <th align="center" nowrap>Cargo Status
                <br>
                <select id="cargoStatusFilter" class="form-control" multiple="multiple">
                {assign var=uniqueCargoPayStatus array()}
                {foreach item=cargoPayStatus from=$result key=t}
                    {if !in_array($cargoPayStatus->cargo_status_code, $uniqueCargoPayStatus)}
                        {assign var="uniqueCargoPayStatus" value=array_merge($uniqueCargoPayStatus, [$cargoPayStatus->cargo_status_code])}
                        <option value="{$cargoPayStatus->cargo_status_code}">{$cargo_status[$cargoPayStatus->cargo_status_code]}</option>
                    {/if}
                    {/foreach}
                </select>
                </th>  
                <th align="center">Transaction Mode</th>  
                <th align="center">{if $namespaceCode == "dishashree"}Qty/Kg {else}Qty{/if}</th> 
                <th align="center">Freight</th>
                <th align="center"><span title="commision Amount">Com..</span></th>
                <th align="center">Net Payable</th>
                <th align="center">Paid</th>
                <th align="center">To Pay</th>
            </tr>

        </thead>
        <tbody class="body_table" >
            {assign var=tot_fare value=0}
            {assign var=tot_handling value=0}
            {assign var=tot_payable value=0}
            {assign var=tot_paid value=0}
            {assign var=tot_topay value=0}
            {assign var=tot_commission value=0}
            {assign var=tot_transaction value=0}
                        
            {foreach item=row from=$result key=t}
                {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                <tr>                    
                    <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                    <td align="center" nowrap>{$row->user_first_name} <br> <span class="small text-muted">{$row->booked_at|date_format:$ns_datetime_format}</span></td>
                    <td align="left">{$row->from_organization_name} <br> <span class="small text-muted">{$row->from_station_name}</span></td>
                    <td align="left" nowrap>{$row->to_organization_name} <br> <span class="small text-muted">{$row->to_station_name}</span></td>
                    <td align="left">{$row->from_customer_name|truncate:50} <br> <span class="small text-muted">{$row->from_customer_mobile|mask_mobileno}</span></td>
                    <td align="left" class=".wrapped-column">{$row->to_customer_name|truncate:15} <br> <span class="small text-muted">{$row->to_customer_mobile|mask_mobileno}</span></td>
                    <td align="center" data-paymentstatus="{$row->payment_status_code}">
                        {$row->payment_status_code|_cargo_payment_status_badge}
                    </td> 
                    <td align="center" data-cargostatuscode="{$row->cargo_status_code}">{$cargo_status[$row->cargo_status_code]|truncate:15}</td>          
                    <td align="left">{$transaction_mode[$row->transaction_mode]|default:'-'}</td>
                    <td align="center">{if $namespaceCode == "dishashree"}{$row->total_item_count}/{$row->total_unit_value}{else}{$row->total_item_count}{/if}</td>   
                    <td align="right">{$row->total_amount|inr_format}</td>
                    <td align="right">{$row->commission_amount|inr_format}</td>             
                    <td align="right">{($row->total_amount+$row->total_handling_amount+$row->pickup_handling_amount+$row->total_unload_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge)|inr_format}</td>
                    <td align="right">{$row->transaction_amount|inr_format}</td>
                    <td align="right">
                        {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge)-$row->transaction_amount}
                        {$rtopay|inr_format}
                        {assign var='tot_topay' value=$tot_topay+$rtopay}
                    </td>
                </tr> 

                {assign var=tot_fare value=$tot_fare+$row->total_amount}
                {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                {assign var=tot_payable value=$tot_payable+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge}
                {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                {assign var=tot_items value=$tot_items+$row->total_item_count}
                {assign var=tot_unit value=$tot_unit+$row->total_unit_value}
                {assign var=tot_commission value=$tot_commission+$row->commission_amount}
                {assign var=tot_transaction value=$tot_transaction+$row->transaction_amount}
                {/if}
            {/foreach}  
        </tbody>
        <tfoot>
                <tr class="active">                    
                <td align="right" colspan="9" class=" bold">Total</td>  
                <td align="center" class="bold total-qty">{if $namespaceCode == "dishashree"}{$tot_items}/{$tot_unit}{else}{$tot_items}{/if}</td>
                <td align="right" class="bold total-freight">{$tot_fare|inr_format}</td>
                <td align="right" class="bold total-commission">{$tot_commission|inr_format}</td>
                <td align="right" class="bold total-net-payable">{$tot_payable|inr_format}</td>
                <td align="right" class="bold total-paid">{$tot_paid|inr_format}</td>
                <td align="right" class="bold total-topay" >{$tot_topay|inr_format}</td>
            </tr>  
        </tfoot>
    </table>
</div>                




<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoTransExcel()"><i class="fa fa-download fa-lg"></i> Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div> 
    


<script>
    var namespaceCode = {$namespaceCode|json_encode};
</script>
{literal}

<script>
    $(document).ready(function () {
        // Initialize Select2 for cargoStatusFilter and paymentStatusFilter
        $('#cargoStatusFilter, #paymentStatusFilter').select2();

        // Trigger colFilter on change event
        $('#cargoStatusFilter, #paymentStatusFilter').on('change', function () {
            colFilter();
        });

        // Function to filter and update table footer
        function colFilter() {
            var cargoStatus = $('#cargoStatusFilter').val();
            var paymentStatus = $('#paymentStatusFilter').val();

            $('#dt_adv_booking_report_table tbody tr').each(function () {
                var rowCargoStatus = $(this).find('td:eq(7)').data('cargostatuscode');
                var rowPaymentStatus = $(this).find('td:eq(6)').data('paymentstatus');
                var showCargo = !cargoStatus || cargoStatus.includes('all') || cargoStatus.includes(rowCargoStatus);
                var showPayment = !paymentStatus || paymentStatus.includes('all') || paymentStatus.includes(rowPaymentStatus);
                // var showCargo = cargoStatus.includes('all') || cargoStatus.includes(rowCargoStatus);
                // var showPayment = paymentStatus.includes('all') || paymentStatus.includes(rowPaymentStatus);

                if (showCargo && showPayment) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });

            updateTableFooter();
        }

        // Function to update table footer
        function updateTableFooter() {
            var totalQty = 0;
            var totalFreight = 0;
            var totalCommission = 0;
            var totalNetPayable = 0;
            var totalPaid = 0;
            var totalToPay = 0;

            $('#dt_adv_booking_report_table tbody tr:visible').each(function () {
                totalQty += parseFloat($(this).find('td:eq(9)').text());
                totalFreight += parseFloat($(this).find('td:eq(10)').text().replace(/,/g, ''));
                totalCommission += parseFloat($(this).find('td:eq(11)').text().replace(/,/g, ''));
                totalNetPayable += parseFloat($(this).find('td:eq(12)').text().replace(/,/g, ''));
                totalPaid += parseFloat($(this).find('td:eq(13)').text().replace(/,/g, ''));
                totalToPay += parseFloat($(this).find('td:eq(14)').text().replace(/,/g, ''));
            });

            var formattedTotalQty = totalQty.toLocaleString();
            var formattedTotalFreight = totalFreight.toLocaleString('en-IN', { maximumFractionDigits: 2 });
            var formattedTotalCommission = totalCommission.toLocaleString('en-IN', { maximumFractionDigits: 2 });
            var formattedTotalNetPayable = totalNetPayable.toLocaleString('en-IN', { maximumFractionDigits: 2 });
            var formattedTotalPaid = totalPaid.toLocaleString('en-IN', { maximumFractionDigits: 2 });
            var formattedTotalToPay = totalToPay.toLocaleString('en-IN', { maximumFractionDigits: 2 });

            $('.total-qty').text(formattedTotalQty);
            $('.total-freight').text(formattedTotalFreight);
            $('.total-commission').text(formattedTotalCommission);
            $('.total-net-payable').text(formattedTotalNetPayable);
            $('.total-paid').text(formattedTotalPaid);
            $('.total-topay').text(formattedTotalToPay);
        }
    });
</script>


{/literal}