<table>
    <tr>
        <td  align="center" colspan="4">{$namespace_name} - GST Report</td>
    </tr>
    <tr>
        <td colspan="2">
            <span class="bold">Report Date: </span> 
            {$smarty.request.from_date|date_format:$ns_date_format}  to {$smarty.request.to_date|date_format:$ns_date_format} 
        </td>
        <td align="right" colspan="2"><span class="bold">Report At :</span> {date("d-m-Y h:i A")}</td>
    </tr>
</table>
    
<br>

<table border='1'>
    <tr>
        <td colspan="4" style="font-weight:bold">Booking</td>                            
    </tr>
</table>

{assign var="b_turnover" value=0}
{assign var="b_sgst" value=0}
{assign var="b_cgst" value=0}
{assign var="b_igst" value=0}
{assign var="b_tax" value=0}

{foreach item=tax from=$gst key=taxcode}
    {if $booking[$taxcode]['turnover'] > 0 || $booking[$taxcode]['sgst'] > 0 || $booking[$taxcode]['cgst'] > 0 || $booking[$taxcode]['igst'] > 0}     

        <table border='1'>
            <tr>
                <td colspan="4" style="font-weight:bold">State : {$tax['state']} - {$tax['gstin']}</td>
            </tr>
        </table>

        <table border='1'>
            <thead>
                <tr style="background-color:#64b92a; color: #fff;">
                    <td align="center" class="bold">Turnover</td>
                    <td align="center" class="bold">SGST ({$tax['sgstSlab']}%)</td>
                    <td align="center" class="bold">CGST ({$tax['cgstSlab']}%)</td>
                    <td align="center" class="bold">IGST ({$tax['igstSlab']}%)</td>
                </tr>
            </thead>
            <tbody class="body_table">
                <tr>                    
                    <td align="right">{$booking[$taxcode]['turnover']}</td>
                    <td align="right">{$booking[$taxcode]['sgst']|inr_format}</td>
                    <td align="right">{$booking[$taxcode]['cgst']|inr_format}</td>
                    <td align="right">{$booking[$taxcode]['igst']|inr_format}</td>
                </tr>
            </tbody>
        </table>
        {assign var="b_turnover" value=$b_turnover+$booking[$taxcode]['turnover']}
        {assign var="b_sgst" value=$b_sgst+$booking[$taxcode]['sgst']}
        {assign var="b_cgst" value=$b_cgst+$booking[$taxcode]['cgst']}
        {assign var="b_igst" value=$b_igst+$booking[$taxcode]['igst']}
        {assign var="b_tax" value=$b_tax+$booking[$taxcode]['sgst']+$booking[$taxcode]['cgst']+$booking[$taxcode]['igst']}
    {/if}
{/foreach}

<table border='1'>
    <tr>
        <td colspan="5" style="font-weight:bold">Total</td>                            
    </tr>
</table>

<table border='1' >
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <td align="center">Turnover</td>
            <td align="center">SGST</td>
            <td align="center">CGST</td>
            <td align="center">IGST</td>
            <td align="center">Total</td>
        </tr>
    </thead>
    <tbody class="body_table">
        <tr>                    
            <td align="right">{$b_turnover}</td>
            <td align="right">{$b_sgst|inr_format}</td>
            <td align="right">{$b_cgst|inr_format}</td>
            <td align="right">{$b_igst|inr_format}</td>
            <td align="right">{($b_sgst+$b_cgst+$b_igst)|inr_format}</td>
        </tr>
    </tbody>
</table>

<br><br>        
<table border='1'>
    <tr>
        <td colspan="4" style="font-weight:bold">Cancellation Refunds</td>                            
    </tr>
</table>
  
{assign var="c_turnover" value=0}
{assign var="c_sgst" value=0}
{assign var="c_cgst" value=0}
{assign var="c_igst" value=0}
{assign var="c_tax" value=0}

{foreach item=tax from=$gst key=taxcode}

    {if $cancel[$taxcode]['turnover'] > 0 || $cancel[$taxcode]['sgst'] > 0 || $cancel[$taxcode]['cgst'] > 0 || $cancel[$taxcode]['igst'] > 0} 
        <table border='1'>
            <tr>
                <td colspan="4" style="font-weight:bold">State : {$tax['state']} - {$tax['gstin']}</td>                        
            </tr>
        </table>
            
        <table border='1'>
            <thead>
                <tr style="background-color:#64b92a; color: #fff;">
                    <td align="center" class="bold">Turnover</td>
                    <td align="center" class="bold">SGST ({$tax['sgstSlab']}%)</td>
                    <td align="center" class="bold">CGST ({$tax['cgstSlab']}%)</td>
                    <td align="center" class="bold">IGST ({$tax['igstSlab']}%)</td>
                </tr>
            </thead>
            <tbody class="body_table">
                <tr>                    
                    <td align="right">{$cancel[$taxcode]['turnover']}</td>
                    <td align="right">{$cancel[$taxcode]['sgst']|inr_format}</td>
                    <td align="right">{$cancel[$taxcode]['cgst']|inr_format}</td>
                    <td align="right">{$cancel[$taxcode]['igst']|inr_format}</td>
                </tr>
            </tbody>
        </table>

        {assign var="c_turnover" value=$c_turnover+$cancel[$taxcode]['turnover']}
        {assign var="c_sgst" value=$c_sgst+$cancel[$taxcode]['sgst']}
        {assign var="c_cgst" value=$c_cgst+$cancel[$taxcode]['cgst']}
        {assign var="c_igst" value=$c_igst+$cancel[$taxcode]['igst']}
        {assign var="c_tax" value=$c_tax+$cancel[$taxcode]['sgst']+$cancel[$taxcode]['cgst']+$cancel[$taxcode]['igst']}
    {/if}

{/foreach}

<table border='1'>
    <tr>
        <td colspan="5" style="font-weight:bold">Total</td>                            
    </tr>
</table>

<table border='1'>
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <td align="center" class="bold">Turnover</td>
            <td align="center" class="bold">SGST</td>
            <td align="center" class="bold">CGST</td>
            <td align="center" class="bold">IGST</td>
            <td align="center" class="bold">Total</td>
        </tr>
    </thead>
    <tbody class="body_table">
        <tr>                    
            <td align="right" class="bold">{$c_turnover}</td>
            <td align="right" class="bold">{$c_sgst|inr_format}</td>
            <td align="right" class="bold">{$c_cgst|inr_format}</td>
            <td align="right" class="bold">{$c_igst|inr_format}</td>
            <td align="right" class="bold">{($c_sgst+$c_cgst+$c_igst)|inr_format}</td>
        </tr>
    </tbody>
</table>
<br><br>
<table border='1'>
    <tr>
        <td colspan="6" style="font-weight:bold">Summary</td>                            
    </tr>
</table>

<table border='1' >
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <td align="center" class="bold">Type</td>
            <td align="center" class="bold">Turnover</td>
            <td align="center" class="bold">SGST</td>
            <td align="center" class="bold">CGST</td>
            <td align="center" class="bold">IGST</td>
            <td align="center" class="bold">Total</td>
        </tr>
    </thead>
    <tbody class="body_table">
        <tr>                    
            <td>Sales</td>
            <td align="right">{$b_turnover|inr_format}</td>
            <td align="right">{$b_sgst|inr_format}</td>
            <td align="right">{$b_cgst|inr_format}</td>
            <td align="right">{$b_igst|inr_format}</td>
            <td align="right">{($b_sgst+$b_cgst+$b_igst)|inr_format}</td>
        </tr>
        <tr>                    
            <td>Return</td>
            <td align="right">{$c_turnover|inr_format}</td>
            <td align="right">{$c_sgst|inr_format}</td>
            <td align="right">{$c_cgst|inr_format}</td>
            <td align="right">{$c_igst|inr_format}</td>
            <td align="right">{($c_sgst+$c_cgst+$c_igst)|inr_format}</td>
        </tr>
        <tr>                    
            <td style="font-weight:bold">Payable</td>
            <td style="font-weight:bold" align="right">{($b_turnover-$c_turnover)|inr_format}</td>
            <td style="font-weight:bold" align="right">{($b_sgst-$c_sgst)|inr_format}</td>
            <td style="font-weight:bold" align="right">{($b_cgst-$c_cgst)|inr_format}</td>
            <td style="font-weight:bold" align="right">{($b_igst-$c_igst)|inr_format}</td>
            <td style="font-weight:bold" align="right">{(($b_sgst+$b_cgst+$b_igst)-($c_sgst+$c_cgst+$c_igst))|inr_format}</td>
        </tr>
    </tbody>
</table>
        
<br><br>
<table border='1'>
    <tr>
        <td colspan="11" style="font-weight:bold">Booking Transactions</td>                            
    </tr>
</table>

<table border='1'>
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <td align="center">PNR</td>
            <td align="center">Transaction Date</td>
            <td align="center">Travel Date</td>
            <td align="center">Route</td>            
            <td align="center">Seat Count</td>
            <td align="center">Fare</td>
            <td align="center">SGST</td>
            <td align="center">CGST</td>
            <td align="center">IGST</td>
            <td align="center">Customer GSTIN</td>
            <td align="center">Customer Trade Name</td>
        </tr>
    </thead>
    <tbody class="body_table" >
        {foreach item=ticket from=$tickets['BO'] key=t} 
        <tr>
            <td align="left">{$ticket->ticket_code}</td>
            <td align="left">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
            <td align="left">{$ticket->travel_date|date_format:$ns_date_format}</td>
            <td align="left">{$ticket->from_station_name} to {$ticket->to_station_name}</td>            
            <td align="right">{$ticket->booked_count}</td>
            <td align="right">{($ticket->transaction_amount-$ticket->addons_amount)|inr_format}</td>
            <td align="right">{$ticket->sgst_amount|inr_format}</td>
            <td align="right">{$ticket->cgst_amount|inr_format}</td>
            <td align="right">{$ticket->igst_amount|inr_format}</td>
            <td align="left">{$ticket->gstin}</td>
            <td align="left">{$ticket->trade_name}</td>
        </tr>
        {/foreach}
    </tbody>
</table>

<br><br>
<table border='1'>
    <tr>
        <td colspan="9" style="font-weight:bold">Cancellation Refund Transactions</td>                            
    </tr>
</table>

<table border='1'>
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <td align="center">PNR</td>
            <td align="center">Cancelled Date</td>
            <td align="center">Travel Date</td>
            <td align="center">Route</td>            
            <td align="center">Seat Count</td>
            <td align="center">Fare</td>
            <td align="center">SGST</td>
            <td align="center">CGST</td>
            <td align="center">IGST</td>
        </tr>
    </thead>
    <tbody class="body_table" >
        {foreach item=ticket from=$tickets['CA'] key=t} 
        <tr>
            <td align="left">{$ticket->ticket_code}</td>
            <td align="left">{$ticket->transaction_date|date_format:$ns_datetime_format}</td>
            <td align="left">{$ticket->travel_date|date_format:$ns_date_format}</td>
            <td align="left">{$ticket->from_station_name} to {$ticket->to_station_name}</td>            
            <td align="right">{$ticket->booked_count}</td>
            <td align="right">{($ticket->transaction_amount-$ticket->addons_amount)|inr_format}</td>
            <td align="right">{$ticket->sgst_amount|inr_format}</td>
            <td align="right">{$ticket->cgst_amount|inr_format}</td>
            <td align="right">{$ticket->igst_amount|inr_format}</td>
        </tr>
        {/foreach}
    </tbody>
</table>
