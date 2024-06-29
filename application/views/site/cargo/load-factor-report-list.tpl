<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Load Factor Report</span></td>
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
                <th>Destination</th>
                <th>Paid Booking Amount (A)</th>
                <th>To-Pay Booking Amount (B)</th>
                <th>On-Account Booking Amount (C)</th>
                {* <th>Basic Freight Amount</th> *}
                <th>Service Charge</th>
                <th>Total Business (A+B+C)</th>
            </tr>
        </thead>
        <tbody class="body_table">

            {assign var=t_service_charge value=0}
            {assign var=t_total_paid_amount value=0}
            {assign var=t_total_handling_amount value=0}
            {assign var=t_total_unload_handling_amount value=0}
            {assign var=t_total_on_account_amount value=0}
            {assign var=t_total_topay_amount value=0}

            {foreach item=row from=$result key=i}
                <tr>
                    <td align="left">{$row->organization_name}</td>
                    <td align="right">{$row->total_paid_amount|inr_format}</td>
                    <td align="right">{$row->total_topay_amount|inr_format}</td>
                    <td align="right">{$row->total_on_account_amount|inr_format}</td>
                    {* <td align="right">{0|inr_format}</td> *}
                    <td align="right">{$row->service_charge|inr_format}</td>
                    <td align="right">{($row->total_paid_amount + $row->total_topay_amount + $row->total_on_account_amount)|inr_format}</td>
                </tr>
    
                {assign var=t_service_charge value=$t_service_charge + $row->service_charge}
                {assign var=t_total_paid_amount value=$t_total_paid_amount + $row->total_paid_amount}
                {assign var=t_total_topay_amount value=$t_total_topay_amount + $row->total_topay_amount}
                {assign var=t_total_on_account_amount value=$t_total_on_account_amount + $row->total_on_account_amount}
                {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
                {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
            {foreachelse}
                <tr>
                    <td colspan="6" align="center">No Records Found</td>
                </tr>
            {/foreach}
        </tbody>
        {if $result|count}
            <tfoot>
                <tr class="active bold">
                    <td align="right">Total</td>
                    <td align='right'>{$t_total_paid_amount|inr_format}</td>
                    <td align='right'>{$t_total_topay_amount|inr_format}</td>
                    <td align='right'>{$t_total_on_account_amount|inr_format}</td>
                    {* <td align='right'>{0|inr_format}</td> *}
                    <td align='right'>{$t_service_charge|inr_format}</td>
                    <td align='right'>{($t_total_paid_amount + $t_total_topay_amount + $t_total_on_account_amount)|inr_format}</td>
                </tr>
            </tfoot>
        {/if}
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportLoadfactorReport();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>