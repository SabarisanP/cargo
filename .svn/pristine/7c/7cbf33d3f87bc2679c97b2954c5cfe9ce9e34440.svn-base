<style>
    .bordered td { border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px; border-color: #666; }
    .border-outline { border: 1px solid #000; }
    .border-left { border-left: 1px solid #000; }
</style>

{for $iter=1 to 3}
    {if $iter==1}
        {'<br/>'|str_repeat:17}
    {elseif $iter==2}
        {'<br/>'|str_repeat:21}        
    {elseif $iter==3}
        {'<br/>'|str_repeat:19}        
    {/if}
    <table width="100%" cellpadding="1">
        <tr>
            <td width="40%"><b>From City :</b> {$summary->fromOrganization->name}</td>
            <td><b>To City : {$summary->toOrganization->name}</b></td>
            <td><b>Bkg DT :</b> {$summary->bookedAt|date_format:$ns_datetime_format}</td>
        </tr>
        <tr>
            <td colspan="2"><b>{lang('booking_sender_term')} Name :</b> {$summary->fromCustomer->name} - {$summary->fromCustomer->mobileNumber}</td>
            <td><b>GC No : {$summary->code}</b></td>
        </tr>
        <tr>
            <td colspan="2"><b>{lang('booking_receiver_term')} Name :</b> {$summary->toCustomer->name} - {$summary->toCustomer->mobileNumber}</td>
            <td><b>Booking Type : {$cargo_payment_status[$summary->paymentType->code]|strtoupper}</b></td>
        </tr>
        <tr>
            <td><b>GST NO :</b> {$summary->tax->gstin}</td>
            <td></td>
            <td><b>PAN NO :</b> ABAFR4156P</td>
        </tr>
    </table>

    <table width="100%" cellpadding="1">
        <tr>
            <td colspan="3" align="center" style="font-size: 7px;"><b>Consignment Particulars</b></td>
        </tr>
    </table>

    {assign var=qty value=0}
    {assign var=articles value=[]}
    {foreach from=$summary->itemDetails item=article name=carArt}
        {assign var=qty value=$qty + $article->itemCount}
        {assign var=articles value=$articles|array_merge:array($article->cargoItem->name)}
    {/foreach}
    {assign var=totalfreight value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge+$addons_mapped['PODCH']->value)}
    <table width="100%" cellpadding="0" class="border-outline px-2" style="border-spacing: 3px 1px">
        <tr>
            <td>Quantity</td>
            <td>{$qty}</td>
            <td class="border-left"> Freight Rate</td>
            <td>{$summary->totalAmount|number_format:2}</td>
            <td> Door Pickup</td>
            <td align="right">{$summary->pickupHandlingAmount|number_format:2}</td>
        </tr>
        <tr>
            <td>Type of Packing</td>
            <td>{$articles|implode:', '|truncate:35}</td>
            <td class="border-left"> WB/Value Surcharge</td>
            <td>0.00</td>
            <td> Door Delivery Charges</td>
            <td align="right">{$summary->deliveryHandlingAmount|number_format:2}</td>
        </tr>
        <tr>
            <td>Total Kg. CDM</td>
            <td>0</td>
            <td class="border-left"> Loading charges</td>
            <td>{$summary->totalHandlingAmount|number_format:2}</td>
            <td> With Pass Charges</td>
            <td align="right">{$summary->passCharge|number_format:2}</td>
        </tr>
        <tr>
            <td>Value Of the Goods</td>
            <td>{$summary->invoiceAmount|number_format:2}</td>
            <td class="border-left"> Unhandling charges</td>
            <td>{$summary->totalUnloadHandlingAmount|number_format:2}</td>
            <td> Hamali charges</td>
            <td align="right">{$summary->hamaliCharge|number_format:2}</td>
        </tr>
        <tr>
            <td>Invoice Number</td>
            <td>{$summary->invoiceNumber}</td>
            <td rowspan="4" class="border-left"> <b>Amount In Words</b></td>
            <td rowspan="4"><b>{$totalfreight|amount_in_words|ucwords}</b></td>
            <td> Docket Charges</td>
            <td align="right">{$summary->docketCharge|number_format:2}</td>
        </tr>
        <tr>
            <td>E Way Bill</td>
            <td>{$addons_mapped['EWBL']->value}</td>
            <td> GST</td>
            <td align="right">{$summary->serviceTax|number_format:2}</td>
        </tr>
        <tr>
            <td>GC Reference No</td>
            <td></td>
            <td> <b>Total freight Charges</b></td>
            <td align="right"><b>{$totalfreight|number_format:2}</b></td>
        </tr>
        <tr>
            <td>Booked By</td>
            <td>{$summary->bookedUser->name}</td>
            <td></td>
            <td align="right"></td>
        </tr>
    </table>

    <table width="100%" cellpadding="1">
        <tr>
            <td><b>{$summary->fromOrganization->address1} {$summary->fromOrganization->address2} {$summary->fromOrganization->contact}</b></td>
        </tr>
        <tr>
            <td><b>{$summary->toOrganization->address1} {$summary->toOrganization->address2} {$summary->toOrganization->contact}</b></td>
        </tr>
    </table>
{/for}