<table class="" width="99%" border='1'>
    <tr>
        <td colspan="8" align="center"><span style="font-weight:bold">Load Factor Report</span></td>
    </tr>
    <tr>
        <td width="50%"  colspan="4">
            <span style="font-weight:bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right" colspan="4"><span style="font-weight:bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%" colspan="4">&nbsp;</td>
        <td width="50%" align="right" colspan="4"><span style="font-weight:bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br/>
<div class="table-responsive col-md-5 p_l_n">
    <table border='1'>
        <thead>
            <tr style="background-color: #64b92a; color: #fff;">
                <th>Destination</th>
                <th>Paid Booking Amount (A)</th>
                <th>To-Pay Booking Amount (B)</th>
                <th>On-Account Booking Amount (C)</th>
                {* <th>Basic Freight Amount</th> *}
                <th>Service Charge</th>
                <th>Total Business (A+B+C)</th>
            </tr>
        </thead>
        <tbody>

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
            {if $result|count}
                <tr style="background-color: #bbbbbb; color: #fff;">
                    <td align="right">Total</td>
                    <td align='right'>{$t_total_paid_amount|inr_format}</td>
                    <td align='right'>{$t_total_topay_amount|inr_format}</td>
                    <td align='right'>{$t_total_on_account_amount|inr_format}</td>
                    {* <td align='right'>{0|inr_format}</td> *}
                    <td align='right'>{$t_service_charge|inr_format}</td>
                    <td align='right'>{($t_total_paid_amount + $t_total_topay_amount + $t_total_on_account_amount)|inr_format}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>