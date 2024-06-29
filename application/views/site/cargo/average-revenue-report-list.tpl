<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Average Branch Revenue Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">No of days : </span> {$no_of_days}</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>

<div class="overflow-x-auto">
    <table id="cargo_revenue_report_table" class="table table-bordered " style="width:99%">
        <thead>
            <tr class="success">
                <td align="center" rowspan="3">Branch Name</td>
                <td align="center" colspan="6">Booking</td>
                <td align="center" rowspan="3">Average</td>
                <td align="center" colspan="6">Delivery</td>
                <td align="center" rowspan="3">Average</td>
                <td align="center" rowspan="3">Overall Average Amount</td>
            </tr>
            <tr class="success">
                <td align="center" colspan="2">Paid Booking</td>
                <td align="center" colspan="2">ToPay Booking</td>
                <td align="center" colspan="2">OnAccount Booking</td>
                
                <td align="center" colspan="2">Paid Booking</td>
                <td align="center" colspan="2">ToPay Booking</td>
                <td align="center" colspan="2">OnAccount Booking</td>
            </tr>
            <tr class="success">
                <td align="center">Amount</td>
                <td align="center">LR / Quantity</td>
                <td align="center">Amount</td>
                <td align="center">LR / Quantity</td>
                <td align="center">Amount</td>
                <td align="center">LR / Quantity</td>
                
                <td align="center">Amount</td>
                <td align="center">LR / Quantity</td>
                <td align="center">Amount</td>
                <td align="center">LR / Quantity</td>
                <td align="center">Amount</td>
                <td align="center">LR / Quantity</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach item=row from=$result}
                <tr>
                    <td align="left">{$row->organization_name}</td>

                    <td align="right">{$row->paid_booking_amount|sigma:$t_paid_booking|inr_format}</td>
                    <td align="right">&nbsp;{$row->paid_count|sigma:$t_paid_count} / {$row->paid_item_count|sigma:$paid_qty}</td>
                    <td align="right">{$row->topay_booking_amount|sigma:$t_topay_booking|inr_format}</td>
                    <td align="right">&nbsp;{$row->topay_count|sigma:$t_topay_count} / {$row->topay_item_count|sigma:$topay_qty}</td>
                    <td align="right">{$row->onacc_booking_amount|sigma:$t_onacc_booking|inr_format}</td>
                    <td align="right">&nbsp;{$row->onacc_count|sigma:$t_onacc_count} / {$row->onacc_item_count|sigma:$onacc_qty}</td>
                    {assign var="booking_avg" value=$row->paid_booking_amount + $row->topay_booking_amount + $row->onacc_booking_amount}
                    <td align="right">{($booking_avg / $no_of_days)|sigma:$t_booking_avg|inr_format}</td>

                    <td align="right">{$row->paid_delivery_amount|sigma:$t_paid_delivery|inr_format}</td>
                    <td align="right">&nbsp;{$row->paid_delivery_count|sigma:$t_paid_delivery_count} / {$row->paid_delivery_item_count|sigma:$paid_delivery_qty}</td>
                    <td align="right">{$row->topay_delivery_amount|sigma:$t_topay_delivery|inr_format}</td>
                    <td align="right">&nbsp;{$row->topay_delivery_count|sigma:$t_topay_delivery_count} / {$row->topay_delivery_item_count|sigma:$topay_delivery_qty}</td>
                    <td align="right">{$row->onacc_delivery_amount|sigma:$t_onacc_delivery|inr_format}</td>
                    <td align="right">&nbsp;{$row->onacc_delivery_count|sigma:$t_onacc_delivery_count} / {$row->onacc_delivery_item_count|sigma:$onacc_delivery_qty}</td>
                    {assign var="delivery_avg" value=$row->paid_delivery_amount + $row->topay_delivery_amount + $row->onacc_delivery_amount}
                    <td align="right">{($delivery_avg / $no_of_days)|sigma:$t_delivery_avg|inr_format}</td>

                    <td align="right">{(($booking_avg + $delivery_avg) / $no_of_days)|sigma:$t_overall_avg|inr_format}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="16" align="center">No Records Found</td>
                </tr>
            {/foreach}
        
            {if $result|count}
                <tr class="active bold">
                    <td colspan="1" align="right">Total</td>
                    <td align="right">{$t_paid_booking|inr_format}</td>
                    <td align="right">&nbsp;{$t_paid_count} / {$paid_qty}</td>
                    <td align="right">{$t_topay_booking|inr_format}</td>
                    <td align="right">&nbsp;{$t_topay_count} / {$topay_qty}</td>
                    <td align="right">{$t_onacc_booking|inr_format}</td>
                    <td align="right">&nbsp;{$t_onacc_count} / {$onacc_qty}</td>
                    <td align="right">{$t_booking_avg|inr_format}</td>
            
                    <td align="right">{$t_paid_delivery|inr_format}</td>
                    <td align="right">&nbsp;{$t_paid_delivery_count} / {$paid_delivery_qty}</td>
                    <td align="right">{$t_topay_delivery|inr_format}</td>
                    <td align="right">&nbsp;{$t_topay_delivery_count} / {$topay_delivery_qty}</td>
                    <td align="right">{$t_onacc_delivery|inr_format}</td>
                    <td align="right">&nbsp;{$t_onacc_delivery_count} / {$onacc_delivery_qty}</td>
                    <td align="right">{$t_delivery_avg|inr_format}</td>

                    <td align="right">{$t_overall_avg|inr_format}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportAverageExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>