<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Business Revenue Detailed Report</span></td>
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



<div class="overflow-x-auto">
    <table id="cargo_revenue_report_table" class="table table-bordered " style="width:99%">
        <thead>
            <tr class="success">
                <th rowspan="2">Date</th>
                <th rowspan="2">From</th>
                <th rowspan="2">To</th>
                <th rowspan="2">Vehicle Number</th>
                <th rowspan="2">Total No Of Consignments</th>
                <th rowspan="2">{lang('ogpl')} Number</th>
                <th colspan="3" class="text-center" nowrap>Booking Mode</th>
                <th rowspan="2">Total Cargo Booking Revenue (D = A+B+C)</th>
                <th rowspan="2">Total {lang('other_charges')} Revenue (E)</th>
                <th rowspan="2">Booking Commission Deduction (F)</th>
                <th rowspan="2">Delivery Commission Deduction (G)</th>
                <th rowspan="2" nowrap>Nett Revenue <br/>(H = D+E-F-G)</th>
            </tr>
            <tr class="success">
                <th nowrap>On Account (A)</th>
                <th nowrap>Paid (B)</th>
                <th nowrap>To Pay (C)</th>
            </tr>
        </thead>
        <tbody class="body_table">

            {assign var=t_cargo_count value=0}
            {assign var=t_total_item_count value=0}
            {assign var=t_total_paid_amount value=0}
            {assign var=t_delivery_handling_amount value=0}
            {assign var=t_total_handling_amount value=0}
            {assign var=t_total_unload_handling_amount value=0}
            {assign var=t_total_on_account_amount value=0}
            {assign var=t_total_topay_amount value=0}
            {assign var=t_booking_commission value=0}
            {assign var=t_delivery_commission value=0}
            {assign var=t_cargo_revenue value=0}
            {assign var=t_cargo_other_charges value=0}

            {foreach item=row from=$result key=i}
                <tr>
                    <td align="left" nowrap>{$row->trip_date|date_format:$ns_date_format}</td>
                    <td align="left">{$row->from_station_name}</td>
                    <td align="left">{$row->to_station_name}</td>
                    <td align="left">{$row->registration_numer}</td>
                    <td align="right">{$row->total_item_count}</td>
                    <td align="left">{$row->alias_code}</td>

                    <td align="right">{$row->total_on_account_amount|inr_format}</td>
                    <td align="right">{$row->total_paid_amount|inr_format}</td>
                    <td align="right">{$row->total_topay_amount|inr_format}</td>

                    {assign var=cargo_revenue value=($row->total_on_account_amount + $row->total_paid_amount + $row->total_topay_amount)}
                    <td align="right">{$cargo_revenue|inr_format}</td>
                    {assign var=cargo_other_charges value=($row->total_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->docket_charge + $row->hamali_charge + $row->pass_charge + $row->pod_charge + $row->service_tax)}
                    <td align="right">{$cargo_other_charges|inr_format}</td>
                    <td align="right">{$row->booking_commission|inr_format}</td>
                    <td align="right">{$row->delivery_commission|inr_format}</td>
                    
                    <td align="right">{($cargo_revenue + $cargo_other_charges - $row->booking_commission - $row->delivery_commission)|inr_format}</td>
                </tr>
    
                {assign var=t_cargo_count value=$t_cargo_count + $row->cargo_count}
                {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
                {assign var=t_total_paid_amount value=$t_total_paid_amount + $row->total_paid_amount}
                {assign var=t_delivery_handling_amount value=$t_delivery_handling_amount + $row->delivery_handling_amount}
                {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
                {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
                {assign var=t_total_on_account_amount value=$t_total_on_account_amount + $row->total_on_account_amount}
                {assign var=t_total_topay_amount value=$t_total_topay_amount + $row->total_topay_amount}
                {assign var=t_booking_commission value=$t_booking_commission + $row->booking_commission}
                {assign var=t_delivery_commission value=$t_delivery_commission + $row->delivery_commission}
                {assign var=t_cargo_revenue value=$t_cargo_revenue + $cargo_revenue}
                {assign var=t_cargo_other_charges value=$t_cargo_other_charges + $cargo_other_charges}
            {foreachelse}
                <tr>
                    <td colspan="14" align="center">No Records Found</td>
                </tr>
            {/foreach}
        </tbody>
        {if $result|count}
            <tfoot>
                <tr class="active bold">
                    <td colspan="6" align="right">Total</td>
                    <td align='right'>{$t_total_on_account_amount|inr_format}</td>
                    <td align='right'>{$t_total_paid_amount|inr_format}</td>
                    <td align='right'>{$t_total_topay_amount|inr_format}</td>
                    <td align='right'>{$t_cargo_revenue|inr_format}</td>
                    <td align='right'>{$t_cargo_other_charges|inr_format}</td>
                    <td align='right'>{$t_booking_commission|inr_format}</td>
                    <td align='right'>{$t_delivery_commission|inr_format}</td>
                    <td align='right'>{($t_cargo_revenue + $t_cargo_other_charges - $t_booking_commission - $t_delivery_commission)|inr_format}</td>
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