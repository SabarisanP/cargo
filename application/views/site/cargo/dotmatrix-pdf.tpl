<style>
    .bold{ font-weight:bold; }
</style>

<table width="100%" cellpadding="3">
    <tr>
        <td align="center" style="font-weight:bold; font-size: 13px;">{$namespace_name}</td>
    </tr>
    <tr>
        <td align="center" class="bold">Parcel Booking Receipt</td>
    </tr>
    <tr>
        <td align="center">
            {if $namespace == "ybmlogistics"}
                Corparate Address :  No:64 , 4th Layout, Teachers Colony, Lakshmipuram, Kolathur, Chennai - 99
                <br>
                GSTIN : 33AAACY9745M1ZQ
            {elseif $namespace == "nationalchn"}
                {$nsprofile->namespaceProfile->address},&nbsp;{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}, Mobile : {$nsprofile->namespaceProfile->supportNumber}
                {if isNotNull($summary->tax->gstin)}
                    <br>
                    <b>GSTIN :</b> {$summary->tax->gstin}
                {/if}
            {elseif $namespace == "luckycargoes"}
                {$nsprofile->namespaceProfile->address},&nbsp;{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                GSTIN : 37AAECL1582H1ZF 
            {elseif $summary->tax->gstin}
                {$summary->tax->tradeName}<br>
                <b>GSTIN :</b> {$summary->tax->gstin}
            {/if}
        </td>
    </tr>
</table>

<table width="100%">
    <tr>
        <td width="65%">
            <table width="100%" cellpadding="3">
                <tbody class="body_table" >
                    <tr>
                        <td align="left" width="50%" style="font-weight:bold; font-size:13px;">
                            {lang('lr')} No : {$cargoCode}
                        </td>
                        <td align="left" width="50%">
                            Booked Date : {$summary->bookedAt|date_format:$ns_datetime_format}
                        </td>
                    </tr>
                </tbody>
            </table>

            <br><br>

            <table width="100%" cellpadding="3" class="table">
                <tbody class="body_table" >
                    <tr class="success" style="">
                        <td align="left" width="50%"  class="bold">Booking Address</td>
                        <td align="left" width="50%"  class="bold">Delivery Address</td>
                    </tr>
                    <tr>
                        <td align="left" width="50%" style="font-weight:bold;">
                            {$summary->fromOrganization->name}
                            {if $summary->fromOrganization->address1!=''}
                                <br>{$summary->fromOrganization->address1} {$summary->fromOrganization->address2}<br>
                            {/if}
                            <br>{$summary->fromOrganization->contact}
                        </td>
                        <td align="left" width="50%" style="font-weight:bold;">
                            {$summary->toOrganization->name}
                            {if $summary->toOrganization->address1!=''}
                                <br>{$summary->toOrganization->address1} {$summary->toOrganization->address2} <br>
                            {/if}
                            <br>{$summary->toOrganization->contact}
                        </td>
                    </tr>
                    <tr>
                        <td align="left" width="50%"  class="">{$summary->fromCustomer->name}</td>
                        <td align="left" width="50%"  class="">{$summary->toCustomer->name}</td>
                    </tr>
                    <tr>
                        <td align="left" width="50%"  class="">{$summary->fromCustomer->mobileNumber}</td>
                        <td align="left" width="50%"  class="">{$summary->toCustomer->mobileNumber}</td>
                    </tr>
                    {if $summary->fromCustomerGST !="" || $summary->toCustomerGST !=""}
                        <tr>
                            <td align="left" width="50%"  class="">GSTIN : {$summary->fromCustomerGST}</td>
                            <td align="left" width="50%"  class="">GSTIN : {$summary->toCustomerGST}</td>
                        </tr>
                    {/if}
                </tbody>
            </table>

            <br><br>
            <table width="100%" cellpadding="3" class="table">
                <tr class="success" style="">
                    <td align="center" class="bold" width="10%">S No</td>
                    <td align="center" class="bold" width="30%">Article</td>
                    <td align="center" class="bold" width="15%">Quantity</td>
                    <td align="center" class="bold" width="15%">Rate</td>
                    <td align="center" class="bold" width="15%">Handling</td>
                    <td align="center" class="bold" width="15%">Total</td>
                </tr>
                <tbody class="body_table" >
                    {foreach from=$summary->itemDetails item=article name=carArt}
                        <tr>
                            <td align="center">{$smarty.foreach.carArt.index+1}</td>
                            <td align="left">{$article->cargoItem->name|truncate:25}</td>
                            <td align="center">{$article->itemCount}</td>
                            <td align="center">{$article->fare}</td>
                            <td align="center">{$article->handlingChargeAmount}</td>
                            <td align="center">{(($article->itemCount*$article->fare)+$article->handlingChargeAmount)|number_format:2}</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>

            {if $summary->invoiceNumber !="" || $summary->invoiceAmount !="" || $summary->invoiceDate !=""}
                <br><br>
                <table width="100%" cellpadding="3" class="table">
                    <tr class="success">
                        <td align="center" class="bold" width="45%">Invoice Number</td>
                        <td align="center" class="bold" width="35%">Invoice Amount</td>
                        <td align="center" class="bold" width="20%">Invoice Date</td>
                    </tr>
                    <tbody class="body_table" >
                        <tr>
                            <td align="center">{$summary->invoiceNumber}</td>
                            <td align="center">{$summary->invoiceAmount}</td>
                            <td align="center">{$summary->invoiceDate}</td>
                        </tr>
                    </tbody>
                </table>
            {/if}

        </td>
        <td width="3%" valign="top"></td>
        <td width="32%" valign="top">

            <table width="100%" cellpadding="3" class="table">
                <tbody class="body_table" >
                    <tr>
                        <td align="left" width="35%" class="bold">No of Articles</td>
                        <td align="left" width="65%">
                            {assign var=qty value=0}
                            {foreach from=$summary->itemDetails item=item}
                                {assign var=qty value=$qty + $item->itemCount}
                            {/foreach}
                            {$summary->itemDetails|count} (Qty - {$qty})
                        </td>
                    </tr>
                    <tr>
                        <td align="left" width="35%" class="bold">Booked By</td>
                        <td align="left" width="65%">{$summary->bookedUser->name}</td>
                    </tr>

                    <tr>
                        <td align="left" width="35%" class="bold">Sub Total</td>
                        <td align="left" width="65%">{($summary->totalAmount+$article->handlingChargeAmount)|number_format:2}</td>
                    </tr>
                    {if $summary->pickupHandlingAmount>0}
                        <tr>
                            <td align="left" width="35%" class="bold">Pickup Charges</td>
                            <td align="left" width="65%">{$summary->pickupHandlingAmount|number_format:2}</td>
                        </tr>
                    {/if}
                    {if $summary->deliveryHandlingAmount>0}
                        <tr>
                            <td align="left" width="35%" class="bold">Delivery Charges</td>
                            <td align="left" width="65%">{$summary->deliveryHandlingAmount|number_format:2}</td>
                        </tr>
                    {/if}
                    {if $summary->totalUnloadHandlingAmount > 0}
                        <tr>
                            <td align="left" width="35%" class="bold">Unloading Charges</td>
                            <td align="left" width="65%">{$summary->totalUnloadHandlingAmount|number_format:2}</td>
                        </tr>
                    {/if}
                    {if $summary->serviceCharge>0}
                        <tr>
                            <td align="left" width="35%" class="bold">Service Charges</td>
                            <td align="left" width="65%">{$summary->serviceCharge|number_format:2}</td>
                        </tr>
                    {/if}

                    {if $summary->serviceTax>0}
                        <tr>
                            <td align="left" width="35%" class="bold">GST</td>
                            <td align="left" width="65%">{$summary->serviceTax|number_format:2}</td>
                        </tr>
                    {/if}

                    <tr>
                        <td align="left" width="35%" class="bold">Net Amount</td>
                        <td align="left" width="65%">{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</td>
                    </tr>

                    <tr>
                        <td align="left" width="35%" class="bold">Amount Paid</td>
                        <td align="left" width="65%">{$summary->paymentAmount|number_format:2}</td>
                    </tr>
                    {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)-$summary->paymentAmount}
                    {if $balance_to_pay>0}
                        <tr>
                            <td align="left" width="35%" class="bold">Amount Balance</td>
                            <td align="left" width="65%">{$balance_to_pay|number_format:2}</td>
                        </tr>
                    {/if}
                </tbody>
            </table>
        </td>
    </tr>
</table>

<br><br>
{if $terms_list|count > 0}
    <table width="100%" cellpadding="1">
        <tr class="success" >
            <td><b>Terms & Conditions</b></td>
        </tr>
        <tbody class="body_table" >
            {foreach from=$terms_list item=term name=carterm}
                <tr>
                    <td align="left">{$term->name}</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
{/if}

{assign var="rcmby" value=""}
{if $summary->paymentType->code== "TPPAD" || $summary->paymentType->code== "TOP"}
    {if $summary->toCustomerGST !=""}
        {assign var="rcmby" value=lang('booking_receiver_term')}
    {else if $summary->fromCustomerGST !="" && $summary->toCustomerGST ==""}
        {assign var="rcmby" value=lang('booking_sender_term')}
    {/if}
{else if $summary->fromCustomerGST !="" }
    {assign var="rcmby" value=lang('booking_receiver_term')}
{else if $summary->fromCustomerGST =="" && $summary->toCustomerGST !=""}
    {assign var="rcmby" value=lang('booking_receiver_term')}
{/if}

{if $namespace == "ybmlogistics"}
    <table width="100%" cellpadding="1">
        <tr class="success" >
            <td align="center">
                {if $rcmby !="" }
                    GST is payable by {$rcmby} (RCM)
                {else}
                    GST is exempted
                {/if}
            </td>
        </tr>
    </table>
{/if}

<table width="100%" cellpadding="1">
    <tr class="success" >
        <td align="right" style="font-size:7px;">This is computer generated receipt no signature required</td>
    </tr>
</table>