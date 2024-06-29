<div style="font-weight:bold;text-align: center;font-size: 12px;">Tax Invoice</div>
<br/><br/>
<table style="padding:5px 4px;width: 100%;">
    <tr>
        <td align="left" style="border: none;width: 40%;font-size: 10px;">{$tck->tax->tradeName}</td>
        <td align="right" style="border: none;width: 35%;font-size: 10px;font-weight:bold;">Invoice # &nbsp;&nbsp;&nbsp;:</td>
        <td align="right" style="border: none;width: 25%;font-size: 10px;">{$tck->code}</td>
    </tr>
    <tr>
        <td align="left" style="border: none;width: 40%;font-size: 9px;"><b>GSTIN :</b> {$tck->tax->gstin}</td>
        <td align="right" style="border: none;width: 35%;font-size: 9px;font-weight:bold;">Invoice Date &nbsp;&nbsp;&nbsp;:</td>
        <td align="right" style="border: none;width: 25%;font-size: 9px;">{$tck->travelDate|date_format:$ns_date_format}</td>
    </tr>
    <tr>
        <td align="left" style="border: none;width: 40%;font-size: 9px;"><b>SAC Code :</b> 996422</td>
        <td align="right" style="border: none;width: 35%;font-size: 9px;font-weight:bold;"></td>
        <td align="right" style="border: none;width: 25%;font-size: 9px;"></td>
    </tr>
    <tr>
        <td align="left" style="border: none;width: 40%;font-size: 9px;"><b>Taxble on reverse charge :</b> No</td>
        <td align="right" style="border: none;width: 35%;font-size: 9px;font-weight:bold;"></td>
        <td align="right" style="border: none;width: 25%;font-size: 9px;"></td>
    </tr>
</table>
<br/><br/>
<div style="border-top: 1px dashed #ddd;"></div>
<table style="padding:5px 4px;width: 100%;">
    <tr>
        <td align="left" style="border: none;width: 100%;font-size: 10px;font-weight:bold;">Bill To</td>
    </tr>
    <tr>
        <td align="left" style="border: none;width: 100%;font-size: 9px;">{if $gst->tradeName != ''}{$gst->tradeName}{else}{$tck->ticketDetails[0]->passengerName}{/if}</td>
    </tr>
    <tr>
        <td align="left" style="border: none;width: 100%;font-size: 9px;"><b>GSTIN :</b> {$gst->gstin}</td>
    </tr>
</table>
<br/><br/>
{assign var="seat_fare" value=0}
{assign var="tax" value=0}
{foreach item=ticket from=$tck->ticketDetails}
    {if $ticket->seatStatus->code == 'BO'}
        {assign var="tax" value=$tax+$ticket->serviceTax}
        {assign var="seat_fare" value=$seat_fare+$ticket->seatFare}
    {/if}
{/foreach}

{assign var="discount" value=0}
{foreach item=dis from=$tck->ticketAddonsDetails}
    {if ($dis->addonType->code=="SHDS" || $dis->addonType->code=="DSAMT" || $dis->addonType->code=="COUP" || $dis->addonType->code=="OFDS" || $dis->addonType->code=="WARD" || $dis->addonType->code=="WACP") && $dis->addonStatus->code!="CA"} 
        {assign var="discount" value=$discount+$dis->value}
        {assign var="seat_fare" value=$seat_fare-$dis->value}    
    {/if}
{/foreach}  
                    
<table style="padding:5px 4px;width: 100%;">
    <thead>
        <tr style="font-weight:bold; background-color: #E8E8E8;">
            <th align="left" style="border: none;">#</th>
            <th align="left" style="border: none;">Description</th>
            <th align="center" style="border: none;">Taxable Value</th>
            {if $tck->tax->igstValue != 0}
            <th align="center" style="border: none;">IGST</th>
            {else}
            <th align="center" style="border: none;">CGST</th>
            <th align="center" style="border: none;">SGST</th>
            {/if}
        </tr>
    </thead>
    <tbody>
        <tr>
            <td align="left" style="border: none;">1</td>
            <td align="left" style="border: none;">Bus Tickets, {$tck->ticketDetails|count} seats</td>
            <td align="center" style="border: none;">{$seat_fare|number_format:2}</td>
            {if $tck->tax->igstValue != 0}
            <td align="center" style="border: none;">{$tax}</td>
            {else}
            <td align="center" style="border: none;">{($tck->tax->cgstValue * $seat_fare)/100}</td>
            <td align="center" style="border: none;">{($tck->tax->cgstValue * $seat_fare)/100}</td>
            {/if}
        </tr>
    </tbody>
</table>
<table style="padding:5px 4px;width: 100%;">
    <tr>
        <td align="left" style="border: none;width: 70%;"></td>
        <td align="left" style="border-bottom: 1px solid #ccc;width: 30%;"></td>
    </tr>
</table>
<br/><br/>
<table style="padding:5px 4px;width: 100%;">
    <tr>
        <td align="right" style="border: none;width: 82%;font-size: 10px;">Sub Total</td>
        <td align="center" style="border: none;width: 3%;font-size: 10px;">:</td>
        <td align="right" style="border: none;width: 15%;font-size: 10px;">{$seat_fare|number_format:2}</td>
    </tr>
    {if $tck->tax->igstValue != 0}
        <tr>
        <td align="right" style="border: none;width: 82%;font-size: 9px;">IGST ({$tck->tax->igstValue}%)</td>
        <td align="center" style="border: none;width: 3%;font-size: 9px;">:</td>
        <td align="right" style="border: none;width: 15%;font-size: 9px;">{$tax}</td>
    </tr>
    {else}
    <tr>
        <td align="right" style="border: none;width: 82%;font-size: 9px;">CGST ({$tck->tax->cgstValue}%)</td>
        <td align="center" style="border: none;width: 3%;font-size: 9px;">:</td>
        <td align="right" style="border: none;width: 15%;font-size: 9px;">{$tax/2}</td>
    </tr>
    <tr>
        <td align="right" style="border: none;width: 82%;font-size: 9px;">SGST ({$tck->tax->sgstValue}%)</td>
        <td align="center" style="border: none;width: 3%;font-size: 9px;">:</td>
        <td align="right" style="border: none;width: 15%;font-size: 9px;">{$tax/2}</td>
    </tr>
    {/if}
</table>
<table style="width: 100%;">
    <tr>
        <td align="left" style="border: none;width: 70%;"></td>
        <td align="left" style="border-bottom: 1px solid #ccc;width: 30%;"></td>
    </tr>
</table>
<br/><br/>
<table style="padding:5px 4px;width: 100%;">
    <tr>
        <td align="right" style="border: none;width: 82%;font-size: 10px;font-weight:bold;">Total</td>
        <td align="center" style="border: none;width: 3%;font-size: 10px;font-weight:bold;">:</td>
        <td align="right" style="border: none;width: 15%;font-size: 10px;font-weight:bold;">Rs. {($seat_fare+$tax)|number_format:2}</td>
    </tr>
</table>