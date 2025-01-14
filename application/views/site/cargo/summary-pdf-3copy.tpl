<style>
    .bordered td {
        border-right-width: 0.1px;
        border-top-width: 0.1px;
        border-left-width: 0.1px;
        border-bottom-width: 0.1px;
        border-color: #666;
    }
</style>

{for $iter=1 to 3}
    {if $namespace == "sreedurga"}
        <table>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/sreedurga-header.jpg" alt="Header" style="max-width: 100%;">
                </td>
            </tr>
        </table>
    {/if}
    {if $namespace == "rajeshcargo"}
        <table>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/rajesh-lr-header.jpg" alt="Header" style="max-width: 100%;">
                </td>
            </tr>
        </table>
    {/if}
    <table width="100%" cellpadding="2">
        {if $namespace !== "sreedurga" && $namespace !== "rajeshcargo"}
            <tr>
                <td align="center" colspan="3">
                    <span style="font-weight:bold; font-size: 12px;">{$namespace_name} - Parcel Booking Receipt</span>
                    {if $namespace == "rktparcel"}
                        {if $summary->fromStation->code == 'STF3OEX206'}
                            <span style="font-size: 10px;"> ( GSTIN : 29AAZFR4180P1ZY )</span>
                        {else}
                            <span style="font-size: 10px;"> ( GSTIN : 33AAZFR4180P1Z9 )</span>
                        {/if}
                    {elseif $namespace == "tippusultan"}
                        {if isNotNull($summary->tax->gstin) && (isNotNull($summary->fromCustomerGST) || isNotNull($summary->toCustomerGST))}
                            <br /> &nbsp; &nbsp;
                            {$summary->tax->tradeName} -
                            <b>GSTIN :</b> {$summary->tax->gstin}
                        {/if}
                    {elseif $namespace == "tvlscargo"}
                        {if isNotNull($summary->tax->gstin)}
                            <br /> &nbsp; &nbsp;
                            {$summary->tax->tradeName} -
                            <b>E-Way Bill ID :</b> {$summary->tax->gstin}
                        {/if}
                    {elseif isNotNull($summary->tax->gstin)}
                        <br /> &nbsp; &nbsp;
                        {$summary->tax->tradeName} -
                        <b>GSTIN :</b> {$summary->tax->gstin}
                    {/if}
                </td>
            </tr>
        {/if}
        <tr>
            <td align="left" style="font-size: 10px;"><b>{lang('lr')} No: {$cargoCode}</b> {if count($addons_mapped['EWBL'])}
                    &nbsp;<img src="assets/img/icons/invoice-logo.png" alt="logo" width="20" height="11">
                {/if}
                {if $summary->cargoAddonsDetails !== '' }
                    {assign var="displayed_logos" value=[]}
                    {foreach $summary->cargoAddonsDetails as $detail}
                        {if $detail->addonsType->code == 'EWBL' && $detail->referenceCode !='' && !in_array('EWBL', $displayed_logos)}
                            &nbsp;<img src="assets/img/icons/eway-logo.png" alt="logo" width="20" height="11">
                            {assign var="displayed_logos" value=$displayed_logos|@array_merge:['EWBL']}
                        {elseif $detail->addonsType->code == 'HDLWC' && !in_array('HDLWC', $displayed_logos)}
                            &nbsp;<img src="assets/img/icons/handle-logo.png" alt="logo" width="13" height="11">
                            {assign var="displayed_logos" value=$displayed_logos|@array_merge:['HDLWC']}
                        {elseif $detail->addonsType->code == 'EXPDL' && !in_array('EXPDL', $displayed_logos)}
                            &nbsp;<img src="assets/img/icons/express-logo.png" alt="logo" width="13" height="11">
                            {assign var="displayed_logos" value=$displayed_logos|@array_merge:['EXPDL']}
                        {/if}
                    {/foreach}
                {/if}
            </td>
            <td align="center" style="font-size: 10px;"><b>Booked Date :</b> {$summary->bookedAt|date_format:$ns_datetime_format}</td>
            <td align="right" style="font-size: 10px;"><b>Booked By :</b> {$summary->bookedUser->name}</td>
        </tr>
    </table>

    <table width="100%" cellpadding="2" class="bordered">
        <tr style="background-color: #64b92a;">
            <td align="center" style="font-size: 9px; width: 33%"><b>{lang('booking_from_term')}</b></td>
            <td align="center" style="font-size: 9px; width: 33%"><b>{lang('booking_to_term')}</b></td>
            <td align="center" style="font-size: 9px; width: 17%"><b>{lang('booking_sender_term')}</b></td>
            <td align="center" style="font-size: 9px; width: 17%"><b>{lang('booking_receiver_term')}</b></td>
        </tr>
        <tr>
            <td align="left" style="font-size: 9px;">
                {$summary->fromOrganization->name}
                {if $summary->fromOrganization->address1!=''}
                    <br>{$summary->fromOrganization->address1} {$summary->fromOrganization->address2}<br>
                {/if}
                {$summary->fromOrganization->contact}
            </td>
            <td align="left" style="font-size: 9px;">{$summary->toOrganization->name}
                {if $summary->toOrganization->address1!=''}
                    <br>{$summary->toOrganization->address1} {$summary->toOrganization->address2} <br>
                {/if}
                {$summary->toOrganization->contact}
            </td>
            <td align="left" style="font-size: 9px;">{$summary->fromCustomer->name}
                <br>{$summary->fromCustomer->mobileNumber}
                {if $summary->fromCustomerGST !=""}
                    <br><b>GSTIN :</b> {$summary->fromCustomerGST}
                {/if}
            </td>
            <td align="left" style="font-size: 9px;">{$summary->toCustomer->name}
                <br>{$summary->toCustomer->mobileNumber}
                {if $summary->toCustomerGST !=""}
                    <br><b>GSTIN :</b> {$summary->toCustomerGST}
                {/if}
            </td>
        </tr>
    </table>
    <br /><br />

    <table width="100%" cellpadding="2" class="bordered">
        <tr style="background-color: #64b92a;">
            {if $action_rights['CARGO-UNITS']==1}
                <td align="center" width="5%"><b>S No</b></td>
                <td align="center" width="22%"><b>Article</b></td>
                <td align="center" width="11%"><b>UOM</b></td>
                <td align="center" width="11%"><b>Quantity</b></td>
                <td align="center" width="11%"><b>Rate</b></td>
                <td align="center" width="11%"><b>Handling</b></td>
                <td align="center" width="11%"><b>Total</b></td>
                <td align="center" width="18%" rowspan="{$summary->itemDetails|count + 2}" style="font-family: helvetica;border-color: #fff; background-color: #fff; font-size: 14px; border-left-color: #000; border-right-color: #fff;">
                    <b>{$payment_type_name|strtoupper}</b>
                </td>
            {else}
                <td align="center" width="5%"><b>S No</b></td>
                <td align="center" width="25%"><b>Article</b></td>
                <td align="center" width="13%"><b>Quantity</b></td>
                <td align="center" width="13%"><b>Rate</b></td>
                <td align="center" width="13%"><b>Handling</b></td>
                <td align="center" width="13%"><b>Total</b></td>
                <td align="center" width="18%" rowspan="{$summary->itemDetails|count + 2}" style="font-family: helvetica;border-color: #fff; background-color: #fff; font-size: 14px; border-left-color: #000; border-right-color: #fff;">
                    <b>{$payment_type_name|strtoupper}</b>
                </td>
            {/if}
        </tr>
        {assign var=qty value=0}
        {assign var=rate value=0}
        {assign var=handling value=0}
        {assign var=subtotal value=0}
        {assign var="hideCargoFreight" value=''}
        {if isNotNull($summary->vendorUser) && isNotNull($summary->vendorUser->code)}
            {assign var="hideCargoFreight" value=$summary->vendorUser->hideCargoFreight}
        {/if}
        {foreach from=$summary->itemDetails item=article name=carArt}
            <tr>
                <td align="center">{$smarty.foreach.carArt.index+1}</td>
                <td align="left">{$article->cargoItem->name|truncate:25}{if $namespace == "rktparcel"}<br>HSN Code : 996511{/if}</td>
                {if $action_rights['CARGO-UNITS']==1}
                    <td align="center">
                        {$article->unitValue}
                        {$article_unit[$article->unit->code]}
                    </td>
                {/if}
                <td align="center">{$article->itemCount}</td>
                <td align="center">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$article->fare}{/if}</td>
                <td align="center">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$article->handlingChargeAmount}{/if}</td>
                <td align="right">
                    {if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$article->computed->freight|number_format:2}{/if}
                </td>
            </tr>
            {assign var=qty value=$qty + $article->itemCount}
            {assign var=rate value=$rate + $article->fare}
            {assign var=handling value=$handling + $article->handlingChargeAmount}
            {assign var=subtotal value=$subtotal + $article->computed->freight}
        {/foreach}
        <tr>
            {if $action_rights['CARGO-UNITS']==1}
                <td align="right" colspan="3"><b>Sub Total</b></td>
            {else}
                <td align="right" colspan="2"><b>Sub Total</b></td>
            {/if}
            <td align="center">{$summary->itemDetails|count} (Qty - {$qty})</td>
            <td align="center">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$rate}{/if}</td>
            <td align="center">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$handling}{/if}</td>
            <td align="right">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$subtotal|number_format:2}{/if}</td>
        </tr>
    </table>
    <br /><br />

    <table width="100%" cellpadding="2" class="bordered">
        <tr>
            {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
            {if $invoiceDetail[1]}
                <td align="left">Invoice Number :<br />{$invoiceDetail[1]}</td>
            {/if}
            {if $invoiceDetail[0] != 0}
                <td align="left">Invoice Amount :<br />{$invoiceDetail[0]|number_format:2}</td>
            {/if}
            {* {if $summary->pickupHandlingAmount > 0}
                <td align="left"><b>Pickup Charges : </b><br/>{$summary->pickupHandlingAmount|number_format:2}</td>
            {/if}
            {if $summary->deliveryHandlingAmount > 0}
                <td align="left"><b>Delivery Charges : </b><br/>{$summary->deliveryHandlingAmount|number_format:2}</td>
            {/if}
            {if $summary->totalUnloadHandlingAmount > 0}
                <td align="left"><b>Unloading Charges : </b><br/>{$summary->totalUnloadHandlingAmount|number_format:2}</td>
            {/if}
            {if $summary->serviceCharge>0}
                <td align="left"><b>Service Charges : </b><br/>{$summary->serviceCharge|number_format:2}</td>
            {/if} *}
            <td align="left">Net Amount : <br />{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value)|number_format:2}{/if}</td>
            <td align="left">Amount Paid : <br />{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->paymentAmount|number_format:2}{/if}</td>
            {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value)-$summary->paymentAmount}
            {if $balance_to_pay>0}
                <td align="left"><b>Amount Balance : <br />{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$balance_to_pay|number_format:2}{/if}</b></td>
            {/if}
        </tr>
    </table>

    {if $summary->remarks|count}
        <table cellpadding="1">
            <tbody class="body_table">
                <tr class="success">
                    <td width="1%"></td>
                    <td><b>Remarks : </b>
                        {assign var="remarksarr" value=[]}
                        {foreach from=$summary->remarks item=row}
                            {$remarksarr[] = $row->name}
                        {/foreach}
                        {$remarksarr|implode:'<br/>'}
                    </td>
                </tr>
            </tbody>
        </table>
    {/if}

    {if $terms_list|count > 0}
        <table width="100%" cellpadding="1">
            <tr class="success">
                <td><b>Terms & Conditions</b></td>
            </tr>
            <tbody class="body_table">
                {foreach from=$terms_list item=term name=carterm}
                    <tr>
                        <td align="left">{$term->name}</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    {/if}
    <table width="100%" cellpadding="1">
        <tr class="success">
            {assign var=bookeddate value=" "|explode:$summary->bookedAt}
            {assign var=bookedtime value=$bookeddate[1]|timeToMinutes}
            {if isNotNull($summary->fromOrganization->transitCloseMinutes) && $bookedtime > $summary->fromOrganization->transitCloseMinutes}
                {$transitCloseMinutes = $summary->fromOrganization->transitCloseMinutes}
                {if $transitCloseMinutes < 720}{$transitCloseMinutes = $transitCloseMinutes + 720}{/if}
                <td align="left"><b>Next Day Booking :</b> {$transitCloseMinutes|addMinutesToDateTime:$summary->bookedAt:'d-m-Y'}</td>
            {/if}
            <td align="right" style="font-size:7px;">This is computer generated receipt no signature required</td>
        </tr>
    </table>
    <hr/>
{/for}