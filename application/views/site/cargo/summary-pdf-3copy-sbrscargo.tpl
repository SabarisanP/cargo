<style>
    .h-seperator { border-bottom: 1px dashed #666; height: 0px; }
    .bordered { border: 0.1px solid #666; }
    .bordered td { border: 0.1px solid #666; }
    .font-7 { font-size: 7px; }
    .font-8 { font-size: 8px; }
    .font-9 { font-size: 9px; }
    .font-10 { font-size: 10px; }
    .bold { font-weight: bold; }
    .bordered-bottom td{ border: 0.1px solid #666; }
</style>

{strip}
    {for $iter=1 to 3}
        <table width="100%" cellpadding="2">
            <tbody>
                <tr>
                    <td rowspan="2" width="150">
                        <img src="assets/img/sbrs-logo.png" alt="logo" height="30">
                    </td>
                    <td class="font-9">{$summary->fromOrganization->name} :- Ph.No {$summary->fromOrganization->contact}</td>
                </tr>
                <tr>
                    <td class="font-9">{$summary->toOrganization->name} :- Ph.No {$summary->toOrganization->contact}</td>
                </tr>
            </tbody>
        </table>

        <table width="100%" cellpadding="2" class="bordered">
            <tbody>
                <tr>
                    <td class="bold">LR Number</td>
                    <td class="bold font-10" nowrap>{$summary->code}</td>
                    <td class="bold">From</td>
                    <td>{$summary->fromStation->name}</td>
                    <td class="bold">To</td>
                    <td>{$summary->toStation->name}</td>
                    <td class="bold">Date</td>
                    <td>{$summary->bookedAt|date_format:$ns_date_format}</td>
                </tr>
                <tr>
                    <td class="bold">LR Type</td>
                    <td class="bold font-9">{$payment_type_name}</td>
                    <td class="bold">From Branch</td>
                    <td>{$summary->fromOrganization->name}</td>
                    <td class="bold">To Branch</td>
                    <td>{$summary->toOrganization->name}</td>
                    <td class="bold">WayBill No</td>
                    <td>{$addons_mapped['EWBL'][0]->referenceCode|default:'-'}</td>
                </tr>
                <tr>
                    <td colspan="4" class="bold">Sender Details</td> 
                    <td colspan="4" class="bold">Receiver Details</td> 
                </tr>
                <tr>
                    <td colspan="4">{$summary->fromCustomer->name}, <span class="bold">{$summary->fromCustomer->mobileNumber}</span></td>
                    <td colspan="4">{$summary->toCustomer->name}, <span class="bold">{$summary->toCustomer->mobileNumber}</span></td> 
                </tr>                
                {if $summary->fromCustomerGST != "" || $summary->toCustomerGST != "" }
                <tr>
                    <td colspan="4">GSTIN : {$summary->fromCustomerGST}</td>
                    <td colspan="4">GSTIN : {$summary->toCustomerGST}</td>
                </tr>   
                {/if}            
            </tbody>
        </table>
        <table width="100%" cellpadding="2" class="bordered">
            <tbody>
                <tr class="font-7">
                    <td class="bold" align="center">Item Description</td>
                    <td class="bold" align="center">Quantity</td>
                    <td class="bold" align="center">Kg's</td>
                    <td class="bold" align="center">CDM</td>
                    <td class="bold" align="center">Freight Charge (<span style="font-family:dejavusans;">&#8377;</span>)</td>
                </tr>
                {assign var=qty value=0}
                {assign var=subtotal value=0}
                {foreach from=$summary->itemDetails item=article}
                    <tr>
                        <td align="left">{$article->cargoItem->name|truncate:25}</td>
                        <td align="right">{$article->itemCount}</td>
                        <td align="right">{$article->actualUnitValue}</td>
                        <td align="right"></td>
                        <td align="right">
                            {$article->computed->freight|number_format:2}
                        </td>
                    </tr>
                    {assign var=qty value=$qty + $article->itemCount}
                    {assign var=subtotal value=$subtotal + $article->computed->freight}
                {/foreach}
                <tr class="bold">
                    <td align="left">Totals</td>
                    <td align="right">{$qty}</td>
                    <td align="right"></td>
                    <td align="right"></td>
                    <td align="right">{$subtotal|inr_format}</td>
                </tr>
                <tr>
                    <td align="left" style="height: 16px; line-height: 16px;">Value Of Goods</td>
                    <td align="right" style="height: 16px; line-height: 16px;">
                        {foreach from=$addons_mapped['EWBL'] item=row key=k}
                            {assign var=invoiceDetail value="|"|explode:$row->value}
                            {$invoiceDetail[0]}{if $k+1 < ($addons_mapped['EWBL']|count)}, {/if}
                        {/foreach}
                    </td>
                    <td align="right" colspan="2">(Handling Charges:{$summary->totalHandlingAmount|inr_format} Unhandling Charges:{$summary->totalUnloadHandlingAmount|inr_format}) <br/><b>{lang('other_charges')} (<span style="font-family:dejavusans;">&#8377;</span>)</b></td>
                    <td align="right" style="height: 16px; line-height: 16px;">{($summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|inr_format}</td>
                </tr>
                <tr>
                    <td align="left">Condition of Goods</td>
                    <td align="right"></td>
                    <td class="bold" align="right" colspan="2">Net Amt Payable (<span style="font-family:dejavusans;">&#8377;</span>)</td>
                    <td align="right">{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|inr_format}</td>
                </tr>
                <tr>
                    <td align="left">Mode of Transport</td>
                    <td align="right" class="bold">Road</td>
                    <td align="right" colspan="2">Vehicle Number</td>
                    <td align="left">
                        {if isset($summary->tripInfo->busVehicle->registationNumber) && $summary->tripInfo->busVehicle->registationNumber != 'false'}
                            {$summary->tripInfo->busVehicle->registationNumber}
                        {elseif $summary->additionalAttribute->registerNumber != '' && $summary->additionalAttribute->registerNumber != 'false'}
                            {$summary->additionalAttribute->registerNumber}
                        {else}
                            -
                        {/if}
                    </td>
                </tr>
                <tr style="height: 20px; line-height: 20px;">
                    <td align="left">
                        {if $iter == 1}
                            Vehicle Copy
                        {elseif $iter == 2}
                            Receiver Copy
                        {elseif $iter == 3}
                            Sender Copy
                        {/if}
                    </td>
                    <td align="center" class="bold" colspan="2">                        
                        GST IS PAYABLE AS PER RCM PROVISIONS
                    </td>
                    <td class="bold" align="center" colspan="2">
                        Booked By {$summary->bookedUser->name|truncate:13:"":true} at {$summary->bookedAt|date_format:$ns_datetime_format}
                    </td>
                </tr>
            </tbody>
        </table>

        {if $terms_list|count > 0}
            <table width="100%" cellpadding="1">
                <tr class="success">
                    <td><b>Terms & Conditions :</b></td>
                </tr>
                <tbody class="body_table">
                    {foreach from=$terms_list item=term}
                        <tr style="font-size: 5px;">
                            <td align="left">{$term->name}</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        {/if}

        {if $iter < 3}
            
            <div class="h-seperator"></div>
            <div></div>
        {/if}
    {/for}
{/strip}
