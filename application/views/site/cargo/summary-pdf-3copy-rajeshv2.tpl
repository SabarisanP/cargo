<style>
    .bordered td { border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px; border-color: #666; }
    .border-outline { border: 1px solid #000; }
    .border-left { border-left: 1px solid #000; }
    .h-seperator { border-bottom: 3px solid #2e2e64;  }
    .v-seperator { border-left: 2px solid #2e2e64;  }
    .receipt-title {
        background-color: #2e2e64;
        color: #fff;
        text-align: center;
    }
</style>

{for $iter=1 to 2}
    {* {if $iter==1}
        {'<br/>'|str_repeat:17}
    {elseif $iter==2}
        {'<br/>'|str_repeat:21}
    {elseif $iter==3}
        {'<br/>'|str_repeat:19}
    {/if} *}

    {'<br/>'|str_repeat:3}

    <table width="100%">
        <tr>
            <td width="63%"><br><br><br>
                <img src="assets/img/rajeshexpress-header.png" alt="logo" width="500px">
            </td>
            <td width="3%">
            </td>
            <td width="1%">
                <div class="v-seperator">{'<br/>'|str_repeat:7}</div>
            </td>
            <td width="31%">
                <div style="font-size: 7px;">
                    <b>Head Office :</b>
                    <br/>
                    <table cellpadding="1">
                        <tr>
                            <td width="7%">
                                <img src="assets/img/icons/marker.png" alt="logo" width="8px">
                            </td>
                            <td width="93%">
                                {$summary->fromOrganization->address1} {$summary->fromOrganization->address2}
                            </td>
                        </tr>
                        <tr>
                            <td width="7%">
                                <img src="assets/img/icons/mail.png" alt="logo" width="8px">
                            </td>
                            <td width="93%"valign="middle">
                                info@rajeshexpresscargo.com
                            </td>
                        </tr>
                        <tr>
                            <td width="7%">
                            <img src="assets/img/icons/globe.png" alt="logo" width="8px">
                            </td>
                            <td width="93%"valign="middle">
                                http://www.rajeshtransports.com
                            </td>
                        </tr>
                        <tr>
                            <td width="7%">
                                <img src="assets/img/icons/phone.png" alt="logo" width="7px">
                            </td>
                            <td width="93%">
                                {$summary->fromOrganization->contact}
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>

    <div class="h-seperator"></div><br/>

    <table cellpadding="4">
        <tr>
            <td></td>
            <td class="receipt-title" width="35%">
                <b style="font-size: 8px;"> GOODS CONSIGNMENT BOOKING RECEIPT</b>
            </td>
            <td></td>
        </tr>
    </table>
    <br/>
    <br/>

    <table width="100%" cellpadding="1">
        <tr>
            <td width="40%"><b>From City :</b> {$summary->fromOrganization->name}</td>
            <td><b>To City : {$summary->toOrganization->name}</b></td>
            <td><b>Bkg DT : {$summary->bookedAt|date_format:$ns_datetime_format}</b></td>
        </tr>
        <tr>
<td colspan="2"><b>{lang('booking_sender_term')} Name :</b> {$summary->fromCustomer->name} - {$summary->fromCustomer->mobileNumber} {if isNotNull($summary->fromCustomerGST)}&nbsp; <b>GST NO : </b>{$summary->fromCustomerGST}{/if}</td>
            <td><b>GC No : {$summary->code}</b></td>
        </tr>
        <tr>
            <td colspan="2"><b>{lang('booking_receiver_term')} Name :</b> {$summary->toCustomer->name} - {$summary->toCustomer->mobileNumber} {if isNotNull($summary->toCustomerGST)}&nbsp; <b>GST NO : </b>{$summary->toCustomerGST}{/if}</td>
            <td><b>Booking Type : {$payment_type_name|strtoupper}</b></td>
        </tr>
        <tr>
            <td><b>GST NO : 29AAVFR9980R1ZG</b></td>
            <td></td>
            <td><b>PAN NO : AAVFR9980R</b></td>
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
    {assign var="hideCargoFreight" value=''}
    {if isNotNull($summary->vendorUser) && isNotNull($summary->vendorUser->code)}
        {assign var="hideCargoFreight" value=$summary->vendorUser->hideCargoFreight}
    {/if}
    <table width="100%" cellpadding="0" class="border-outline px-2" style="border-spacing: 3px 1px">
        <tr>
            <td>Quantity</td>
            <td>{$qty}</td>
            <td class="border-left"> Freight Rate</td>
            <td>{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->totalAmount|number_format:2}{/if}</td>
            <td> Door Pickup</td>
            <td align="right">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->pickupHandlingAmount|number_format:2}{/if}</td>
        </tr>
        <tr>
            <td>Type of Packing</td>
            <td>{$articles|implode:', '|truncate:35}</td>
            <td class="border-left"> WB/Value Surcharge</td>
            <td>{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}0.00{/if}</td>
            <td> Door Delivery Charges</td>
            <td align="right">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->deliveryHandlingAmount|number_format:2}{/if}</td>
        </tr>
        <tr>
            <td>Total Kg. CDM</td>
            <td>0</td>
            <td class="border-left"> Loading charges</td>
            <td>{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->totalHandlingAmount|number_format:2}{/if}</td>
            <td> With Pass Charges</td>
            <td align="right">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->passCharge|number_format:2}{/if}</td>
        </tr>
        
        {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
        <tr>
            <td>Value Of the Goods</td>
            <td>{$invoiceDetail[0]|number_format:2}</td>
            <td class="border-left"> Unhandling charges</td>
            <td>{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->totalUnloadHandlingAmount|number_format:2}{/if}</td>
            <td> Hamali charges</td>
            <td align="right">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->hamaliCharge|number_format:2}{/if}</td>
        </tr>
        <tr>
            <td>Invoice Number</td>
            <td>{$invoiceDetail[1]}</td>
            <td rowspan="4" class="border-left"> <b>Amount In Words</b></td>
            <td rowspan="4"><b>{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$totalfreight|amount_in_words|ucwords}{/if}</b></td>
            <td> Docket Charges</td>
            <td align="right">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->docketCharge|number_format:2}{/if}</td>
        </tr>
        <tr>
            <td>E Way Bill</td>
            <td>{$addons_mapped['EWBL'][0]->referenceCode}</td>
            <td> GST</td>
            <td align="right">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->serviceTax|number_format:2}{/if}</td>
        </tr>
        <tr>
            <td>GC Reference No</td>
            <td></td>
            <td> <b>Total freight Charges</b></td>
            <td align="right"><b>{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$totalfreight|number_format:2}{/if}</b></td>
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
            <td><b>Booking Branch Address : {$summary->fromOrganization->address1} {$summary->fromOrganization->address2} {$summary->fromOrganization->contact}</b></td>
        </tr>
        <tr>
            <td><b>Delivery Branch Address : {$summary->toOrganization->address1} {$summary->toOrganization->address2} {$summary->toOrganization->contact}</b></td>
        </tr>
    </table>
    
    <div></div>

    {if $terms_list|count > 0}
        <table width="100%" cellpadding="1">
            <tr class="success">
                <td><b>Terms & Conditions</b></td>
            </tr>
            <tbody class="body_table">
                {foreach from=$terms_list item=term}
                    <tr style="font-size: 5px;">
                        <td align="left">{$term->name}</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
        <div></div>
    {/if}
{/for}