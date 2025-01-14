<table>
    <tr>
        <td colspan="6" align="center"><b>Branch Sales Summary</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>From</b>&nbsp;{$from|date_format:$ns_date_format}&nbsp;<b>To</b>&nbsp;{$to|date_format:$ns_date_format}</td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$usr_login_name} </td>
    </tr>
</table>

<table width="100%">
    <thead>
        <tr>
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
                    <td align="right" >{$row['from_organization_name']}</td>
                    <td align="left" nowrap>{$row['booked_at']|date_format:$ns_date_format}</td>
                    <td align="right" >{$row['cargo_count']|sigma:$t_cargo_amount}</td>
                    <td align="right" >{$row['total_item_count']|sigma:$t_item_count}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['total_amount']|sigma:$t_total_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['pass_charge']|sigma:$t_pass_charge}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['total_handling_amount']|sigma:$t_total_handling_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['total_unload_handling_amount']|sigma:$t_total_unload_handling_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{($row['other_charges_amount']+$row['docket_charge'])|sigma:$t_other_charges_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['net_amount']|sigma:$t_net_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['sgst']|sigma:$t_sgst}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['cgst']|sigma:$t_cgst}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['igst']|sigma:$t_igst}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['round_off_value']|sigma:$t_round}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['net_total_amount']|sigma:$t_net_total_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['PAD']|default:0|sigma:$t_PAD}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['TOP']|default:0|sigma:$t_TOP}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row['INP']|default:0|sigma:$t_INP}</td>
                </tr>
            {/foreach}
        {/foreach}
        {if $result|count > 1}
            <tfoot>
                <tr class="active">
                    <td align="right"></td>
                    <td align="right">Total</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_cargo_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_item_count}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_total_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_pass_charge}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_total_handling_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_total_unload_handling_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_other_charges_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_net_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_sgst}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_cgst}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_igst}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_round}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_net_total_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_PAD|default:0}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_TOP|default:0}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$t_INP|default:0}</td>
                </tr>
            </tfoot>
        {/if}
    </tbody>
</table>
