<style>
    .bordered td { border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px; border-color: #666; }
    .border-outline { border: 1px solid #666; }
    .border-left { border-left: 1px solid #666; }
    .border-top { border-top: 1px solid #666; }
    .border-right { border-right: 1px solid #666; }
    .border-bottom { border-bottom: 1px solid #666; }
    .font-11 { font-size: 11px;}
    .bold { font-weight: bold; }
</style>

{strip}
    {for $iter=1 to 3}
        {if $iter==1}
            {'<br />'|str_repeat:8}
        {elseif $iter==2}
            {'<br />'|str_repeat:10}
        {elseif $iter==3}
            {'<br />'|str_repeat:11}
        {/if}
        
        <table width="100%" cellpadding="2" class="border-outline">
            <tr>
                <td colspan="2" class="border-bottom border-right">DATE: {$summary->bookedAt|date_format:$ns_datetime_format}</td>
                <td colspan="3" class="border-bottom border-right">TYPE : <b class="font-11">{$payment_type_name|strtoupper}</b></td>
                <td colspan="3" class="border-bottom border-right">{lang('lr')} NO : <b class="font-11">{$summary->code}</b></td>

                <td colspan="2" rowspan="7" class="">
                    <table width="100%" style="line-height: 14px;">
                        <tr>
                            <td class="border-bottom border-right">Freight</td>
                            <td align="right" class="border-bottom">{$summary->totalAmount|number_format:2}</td>
                        </tr>
                        <tr>
                            <td class="border-bottom border-right">Load Ch</td>
                            <td align="right" class="border-bottom">{$summary->totalHandlingAmount|number_format:2}</td>
                        </tr>
                        <tr>
                            <td class="border-bottom border-right">Unload Ch</td>
                            <td align="right" class="border-bottom">{$summary->totalUnloadHandlingAmount|number_format:2}</td>
                        </tr>
                        <tr>
                            <td class="border-bottom border-right">Docket Ch</td>
                            <td align="right" class="border-bottom">{$summary->docketCharge|number_format:2}</td>
                        </tr>
                        <tr>
                            <td class="border-bottom border-right">DD Charge</td>
                            <td align="right" class="border-bottom">{$summary->deliveryHandlingAmount|number_format:2}</td>
                        </tr>
                        <tr>
                            <td class="border-bottom border-right">Others</td>
                            <td align="right" class="border-bottom">{($summary->serviceCharge + $summary->passCharge)|number_format:2}</td>
                        </tr>
                        <tr>
                            <td class="border-bottom border-right bold">Total</td>
                            <td align="right" class="border-bottom bold">{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</td>
                        </tr>
                        <tr>
                            <td class="bold">Del Type : </td>
                            <td class="bold">
                                {if $summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO'}
                                    {$del_at = 'DOOR DLY'}
                                {else}
                                    {$del_at = 'GODOWN'}
                                {/if}
                                {$del_at}
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4" class="border-bottom border-right">
                    FROM : <b>{$summary->fromOrganization->name|strtoupper}&nbsp;({$summary->fromOrganization->contact|substr:0:10})</b>
                </td>
                <td colspan="4" class="border-bottom border-right">
                    TO : <b> 
                        {if ($summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO') && $summary->toCustomerAddress->station->name}
                            {$summary->toCustomerAddress->station->name|strtoupper}
                        {else}
                            {$summary->toOrganization->name|strtoupper}
                        {/if}
                        &nbsp;({$summary->toOrganization->contact|substr:0:10})
                    </b>
                </td>
            </tr>
            <tr>
                <td colspan="4" class="border-bottom border-right">
                    Consigner : {substr($summary->fromCustomer->name, 0, 31)}<br>
                    {if isNotNull($summary->fromCustomerAddress->address1)}{$summary->fromCustomerAddress->address1}, {/if}
                    {if isNotNull($summary->fromCustomerAddress->address2)}{$summary->fromCustomerAddress->address2}, {/if}
                    {if isNotNull($summary->fromCustomerAddress->landmark)}{$summary->fromCustomerAddress->landmark}, {/if}{if isNotNull($summary->fromCustomerAddress->pincode)}{$summary->fromCustomerAddress->pincode}{/if}
                    , {$summary->fromCustomer->mobileNumber|default:'-'}<br/>
                    GST: {$summary->fromCustomerGST|default:'-'}
                    
                    {if !isNotNull($summary->fromCustomerAddress->address1) && !isNotNull($summary->fromCustomerAddress->address2)}<br>{/if}
                    {* {if !isNotNull($summary->fromCustomerAddress->landmark) && !isNotNull($summary->fromCustomerAddress->pincode)}<br>{/if} *}
                </td>
                <td colspan="4" class="border-bottom border-right">
                    Consignee : {substr($summary->toCustomer->name, 0, 31)}<br>
                    {if isNotNull($summary->toCustomerAddress->address1)}{$summary->toCustomerAddress->address1}, {/if}
                    {if isNotNull($summary->toCustomerAddress->address2)}{$summary->toCustomerAddress->address2}, {/if}
                    {if isNotNull($summary->toCustomerAddress->landmark)}{$summary->toCustomerAddress->landmark}, {/if}{if isNotNull($summary->toCustomerAddress->pincode)}{$summary->toCustomerAddress->pincode}{/if}
                    ,{$summary->toCustomer->mobileNumber|default:'-'}<br/>
                    GST: {$summary->toCustomerGST|default:'-'}
                </td>
            </tr>

            <tr>
                <td align="center" class="border-bottom border-right"><b>Qty. </b></td>
                <td colspan="4" align="center" class="border-bottom border-right"><b>Description </b></td>
                <td align="center" class="border-bottom border-right"><b>Loading Ch</b></td>
                <td colspan="2" rowspan="2" align="right" class="border-bottom border-right">
                    <table width="100%">
                        <tr>
                            <td width="10%"></td>
                            <td align="center" class="border-bottom" width="40%"><b>{$summary->fromOrganization->shortCode}<br></b></td>
                            <td rowspan="2" width="50%" align="right">
                                <img src="{$base_url}qr?data={$summary->additionalAttribute->SLUG}&size=10" width="40px">
                            </td>
                        </tr>
                        <tr>
                            <td width="10%"></td>
                            <td align="center"><b><br>{$summary->toOrganization->shortCode}</b></td>
                        </tr>
                    </table>
                </td>
            </tr>
            
            {assign var=qty value=0}
            {assign var=actualwt value=0}
            {assign var=chargedwt value=0}
            {assign var=cnt value=0}
            <tr>
                <td colspan="6" class="border-right">
                    <table style="line-height: 7px;">
                        {foreach from=$summary->itemDetails item=article}
                            {assign var=cnt value=$cnt + 1}
                            {assign var=qty value=$qty + $article->itemCount}
                            {assign var=actualwt value=$actualwt + $article->actualUnitValue}
                            {if $article->unit->code == 'KG'}
                                {assign var=chargedwt value=$chargedwt + $article->unitValue}
                            {/if}
                            <tr>
                                <td colspan="1" align="center">{$article->itemCount}</td>
                                <td colspan="4" class="">{$article->cargoItem->name|strtolower|ucwords} of  {$article->cargoItem->description[0]} &nbsp;&nbsp;- Rs {$article->fare|inr_format}</td>
                                <td align="right">{$article->handlingChargeAmount|inr_format}</td>
                            </tr>
                        {/foreach}
                    </table>
                </td>
            </tr>

            <tr>
                <td class="border-top border-right">Tot : {$qty}</td>
                <td class="border-top border-right">Act Wt : {$actualwt}</td>
                <td class="border-top border-right">Chg Wt : {$chargedwt}</td>
                <td colspan="3" class="border-top border-right">E-Way Bill : {$addons_mapped['EWBL'][0]->referenceCode}</td>

                <td colspan="4" rowspan="2" class="border-top border-right">
                    <b>Delivery Address :</b> 
                    {$summary->toOrganization->name}, {$summary->toOrganization->address1}, {$summary->toOrganization->address2}, {$summary->toOrganization->contact}
                    {if !isNotNull($summary->toOrganization->address1) && !isNotNull($summary->toOrganization->address2)}<br>{/if}
                </td>
            </tr>
            <tr>
                {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
                <td colspan="2" class="border-top border-right">Inv No : {$invoiceDetail[1]}</td>
                <td colspan="2" class="border-top border-right">Inv Amt : {$invoiceDetail[0]}</td>
                <td colspan="2" class="border-top border-right">Inv Date : {$invoiceDetail[2]}</td>
            </tr>
            <tr>
                <td colspan="5" class="border-top border-right">Receiver Signature</td>
                <td colspan="5" class="border-top">K2K Logistics <br/>Signature of Clerk / Agent</td>
            </tr>
        </table>           
    {/for}
{/strip}
