<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Branch Sales Summary</span></td>
    </tr>
    <tr>
        <td width="50%">
            <b>From</b>  {$from|date_format:$ns_date_format}  <b>To</b> {$to|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table>

<br>
<table id="branch_due_report_table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <td align="center">Booking Branch</td>
            <td align="center">Date</td>
            <td align="center">No Of Lrs</td>
            <td align="center">No Of Art</td>
            <td align="center">Freight Amount <br>(A)</td>
            <td align="center">Pass Charge <br>(B)</td>
            <td align="center">Loading Charges <br>(C)</td>
            <td align="center">Unloading Charges <br>(D)</td>
            <td align="center">Other Charges <br>(E)</td>
            <td align="center">Net Amount <br>(F1 = A+B+C+D+E)</td>
            <td align="center">SGST <br>(G)</td>
            <td align="center">CGST <br>(H)</td>
            <td align="center">IGST <br>(I)</td>
            <td align="center">Round Off <br>(J)</td>
            <td align="center">Total <br>(F2 = F1+G+H+I)</td>
            <td align="center">Paid</td>
            <td align="center">Topay</td>
            <td align="center">OnAccount</td>
        </tr>
    </thead>
    <tbody>
   
        {foreach item=rows from=$result}
            {foreach item=row from=$rows}
                <tr>
                    <td align="left" nowrap>{$row['from_organization_name']}</td>
                    <td align="left" nowrap>{$row['booked_at']|date_format:$ns_date_format}</td>
                    <td align="right">{$row['cargo_count']|sigma:$t_cargo_count}</td>
                    <td align="right">{$row['total_item_count']|sigma:$t_item_count}</td>
                    <td align="right">{$row['total_amount']|sigma:$t_total_amount|inr_format}</td>
                    <td align="right">{$row['pass_charge']|sigma:$t_pass_charge|inr_format}</td>
                    <td align="right">{$row['total_handling_amount']|sigma:$t_total_handling_amount|inr_format}</td>
                    <td align="right">{$row['total_unload_handling_amount']|sigma:$t_total_unload_handling_amount|inr_format}</td>
                    <td align="right">{($row['other_charges_amount']+$row['docket_charge'])|sigma:$t_other_charges_amount|inr_format}</td>
                    <td align="right">{$row['net_amount']|sigma:$t_net_amount|inr_format}</td>
                    <td align="right">{$row['sgst']|sigma:$t_sgst|inr_format}</td>
                    <td align="right">{$row['cgst']|sigma:$t_cgst|inr_format}</td>
                    <td align="right">{$row['igst']|sigma:$t_igst|inr_format}</td>
                    <td align="right">{$row['round_off_value']|sigma:$t_round|inr_format}</td>
                    <td align="right">{$row['net_total_amount']|sigma:$t_net_total_amount|inr_format}</td>
                    <td align="right">{$row['PAD']|default:0|sigma:$t_PAD|inr_format}</td>
                    <td align="right">{$row['TOP']|default:0|sigma:$t_TOP|inr_format}</td>
                    <td align="right">{$row['INP']|default:0|sigma:$t_INP|inr_format}</td>
                </tr>
            {/foreach}
        {/foreach}
        {if $result|count > 1}
            <tr class="active bold">
                <td align="right"></td>
                <td align="right">Total</td>
                <td align="right">{$t_cargo_count}</td>
                <td align="right">{$t_item_count}</td>
                <td align="right">{$t_total_amount|inr_format}</td>
                <td align="right">{$t_pass_charge|inr_format}</td>
                <td align="right">{$t_total_handling_amount|inr_format}</td>
                <td align="right">{$t_total_unload_handling_amount|inr_format}</td>
                <td align="right">{$t_other_charges_amount|inr_format}</td>
                <td align="right">{$t_net_amount|inr_format}</td>
                <td align="right">{$t_sgst|inr_format}</td>
                <td align="right">{$t_cgst|inr_format}</td>
                <td align="right">{$t_igst|inr_format}</td>
                <td align="right">{$t_round|inr_format}</td>
                <td align="right">{$t_net_total_amount|inr_format}</td>
                <td align="right">{$t_PAD|default:0|inr_format}</td>
                <td align="right">{$t_TOP|default:0|inr_format}</td>
                <td align="right">{$t_INP|default:0|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>
