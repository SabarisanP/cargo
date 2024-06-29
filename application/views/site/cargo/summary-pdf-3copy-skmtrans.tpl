<style>
    .bordered td { border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px; border-color: #666; }
    .border-outline { border: 1px solid #000; }
    .border-left { border-left: 1px solid #000; }
    .h-seperator { border-bottom: 3px solid #000;  }
    .v-seperator { border-left: 2px solid #000;  }
    .receipt-title {
        background-color: #000;
        color: #fff;
        text-align: center;
        font-size: 8px;
    }
    .font-7 { font-size: 7px; }
</style>

{for $iter=1 to 3}
    {if $namespace == 'nstransports'}
        <table width="100%">
            <tr>
                <td width="85%" align="center">
                    <img src="assets/img/clientlogo/nstransports-header.jpg" alt="logo" style="max-width: 100%;"><br>
                </td>
                <td align="center" width="15%">
                    {if isNotNull($nsprofile->namespaceProfile->domainURL) && isNotNull($summary->additionalAttribute->SLUG)}
                        <img src="{$base_url}qr?data={$summary->additionalAttribute->SLUG}&size=10" width="62px" >
                    {/if}
                </td>
            </tr>
        </table>
    {else}
        {if $iter==1}
            {'<br/>'|str_repeat:9}
        {elseif $iter==2}
            {'<br/>'|str_repeat:10}
        {elseif $iter==3}
            {'<br/>'|str_repeat:10}
        {/if}
    {/if}

    <div class="h-seperator"></div><br/>

    <table cellpadding="4">
        <tr>
            <td></td>
            <td class="receipt-title" width="35%">
                {if $iter==1}
                    <b>CONSIGNMENT RECEIPT</b>
                {elseif $iter==2}
                    <b> CONSIGNOR RECEIPT</b>
                {else}
                    <b> ACCOUNTS RECEIPT</b>
                {/if}
            </td>
            <td></td>
        </tr>
    </table>
    <br/>
    <br/>

    <table width="100%" cellpadding="1">
        <tr>
            <td width="40%" class="font-7"><b>From City : {$summary->fromOrganization->name}</b></td>
            <td class="font-7"><b>To City : {$summary->toOrganization->name}</b></td>
            <td><b>Bkg DT : {$summary->bookedAt|date_format:$ns_datetime_format}</b></td>
        </tr>
        <tr>
            <td colspan="2"><b>{lang('booking_sender_term')} Name :</b> {$summary->fromCustomer->name} - {$summary->fromCustomer->mobileNumber} {if isNotNull($summary->fromCustomerGST)}&nbsp; <b>GST NO : </b>{$summary->fromCustomerGST}{/if}</td>
            <td class="font-7"><b>LR No : {$summary->code}</b></td>
        </tr>
        <tr>
            <td colspan="2"><b>{lang('booking_receiver_term')} Name :</b> {$summary->toCustomer->name} - {$summary->toCustomer->mobileNumber} {if isNotNull($summary->toCustomerGST)}&nbsp; <b>GST NO : </b>{$summary->toCustomerGST}{/if}</td>
            <td><b>Booking Type : {$payment_type_name|strtoupper}</b></td>
        </tr>
        <tr>
            <td><b>GST NO : {$summary->tax->gstin}</b></td>
            <td></td>
            <td>
                {* <b>PAN NO : ABAFR4156P</b> *}
            </td>
        </tr>
    </table>

    <table width="100%" cellpadding="1">
        <tr>
            <td colspan="3" align="center" class="font-7"><b>Consignment Particulars</b></td>
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

        {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
        <tr>
            <td>Value Of the Goods</td>
            <td>{$invoiceDetail[0]|number_format:2}</td>
            <td class="border-left"> Unhandling charges</td>
            <td>{$summary->totalUnloadHandlingAmount|number_format:2}</td>
            <td> Hamali charges</td>
            <td align="right">{$summary->hamaliCharge|number_format:2}</td>
        </tr>
        <tr>
            <td>Invoice Number</td>
            <td>{$invoiceDetail[1]}</td>
            <td rowspan="4" class="border-left"> <b>Amount In Words</b></td>
            <td rowspan="4"><b>{$totalfreight|amount_in_words|ucwords}</b></td>
            <td> Docket Charges</td>
            <td align="right">{$summary->docketCharge|number_format:2}</td>
        </tr>
        <tr>
            <td>E Way Bill</td>
            <td>{$addons_mapped['EWBL'][0]->referenceCode|default:'-'}</td>
            <td> GST</td>
            <td align="right">{$summary->serviceTax|number_format:2}</td>
        </tr>
        <tr>
            <td>GC Reference No</td>
            <td></td>
            <td class="font-7"> <b>Total freight Charges</b></td>
            <td align="right" class="font-7"><b>{$totalfreight|number_format:2}</b></td>
        </tr>
        <tr>
            <td>Booked By</td>
            <td>{$summary->bookedUser->name}</td>
            <td></td>
            <td align="right"></td>
        </tr>
    </table>

    <table width="100%" cellpadding="1" class="font-7">
        <tr>
            <td><b>Booking Branch Address : {$summary->fromOrganization->address1} {$summary->fromOrganization->address2}, Ph - {$summary->fromOrganization->contact}</b></td>
        </tr>
        <tr>
            <td><b>Delivery Branch Address : {$summary->toOrganization->address1} {$summary->toOrganization->address2}, Ph - {$summary->toOrganization->contact}</b></td>
        </tr>
    </table>
    
    <div></div>

    {if $namespace != 'nstransports' && count($terms_list) > 0}
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