<style>
    .bordered td { border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px; border-color: #666; }
    .border-outline { border: 1px solid #666; }
    .border-left { border-left: 1px solid #666; }
    .border-top { border-top: 1px solid #666; }
    .border-right { border-right: 1px solid #666; }
    .border-bottom { border-bottom: 1px solid #666; }
    .font-11 { font-size: 11px;}
</style>

{strip}
    {for $iter=1 to 3}
        {if $iter==1}
            {'<br />'|str_repeat:5}
        {elseif $iter==2}
            {'<br />'|str_repeat:7}
        {elseif $iter==3}
            {'<br />'|str_repeat:7}
        {/if}

        {$actualWeight = array()}
        {$chargedWeight = array()}
        {foreach from=$summary->itemDetails  item=article}
            {$actualWeight[$article->unit->code] = $actualWeight[$article->unit->code] + $article->actualUnitValue}
            {$chargedWeight[$article->unit->code] = $chargedWeight[$article->unit->code] + $article->unitValue}
        {/foreach}
        <table width="100%" cellpadding="2">
            <tr>
                <td colspan="4"></td>
                <td align="center">
                    <b class="font-11">{$summary->code}</b><br>
                    {$summary->bookedAt|date_format:$ns_datetime_format}
                </td>
            </tr>
        </table>
        <br><br>
        
        <table width="100%" cellpadding="2" class="border-outline">
            <tr>
                <td colspan="4" class="border-bottom border-right">
                    FROM : <b>{$summary->fromOrganization->name|strtoupper}</b>
                </td>
                <td colspan="4" class="border-bottom border-right">
                    TO : <b> 
                        {if ($summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO') && $summary->toCustomerAddress->station->name}
                            {$summary->toCustomerAddress->station->name|strtoupper}
                        {else}
                            {$summary->toOrganization->name|strtoupper}
                        {/if}
                    </b>
                </td>
                
                <td colspan="2" rowspan="4">
                    <table width="100%" style="line-height: 17px;">
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
                            <td class="border-right bold"><b>Total</b></td>
                            <td align="right" class="bold"><b>{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</b></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4" class="border-bottom border-right">
                    Consigner : {substr($summary->fromCustomer->name, 0, 50)}<br>
                    {if isNotNull($summary->fromCustomerAddress->address1)}{$summary->fromCustomerAddress->address1}, {/if}
                    {if isNotNull($summary->fromCustomerAddress->address2)}{$summary->fromCustomerAddress->address2}<br>{/if}
                    {if isNotNull($summary->fromCustomerAddress->landmark)}{$summary->fromCustomerAddress->landmark}, {/if}{if isNotNull($summary->fromCustomerAddress->pincode)}{$summary->fromCustomerAddress->pincode}<br>{/if}
                    Ph.No: {$summary->fromCustomer->mobileNumber|default:'-'}<br/>
                    GST: {$summary->fromCustomerGST|default:'-'}
                    
                    {if !isNotNull($summary->fromCustomerAddress->address1)}<br>{/if}
                    {if !isNotNull($summary->fromCustomerAddress->address2)}<br>{/if}
                    {* {if !isNotNull($summary->fromCustomerAddress->landmark) && !isNotNull($summary->fromCustomerAddress->pincode)}<br>{/if} *}
                </td>
                <td colspan="4" class="border-bottom border-right">
                    Consignee : {substr($summary->toCustomer->name, 0, 50)}<br>
                    {if isNotNull($summary->toCustomerAddress->address1)}{$summary->toCustomerAddress->address1}, {/if}
                    {if isNotNull($summary->toCustomerAddress->address2)}{$summary->toCustomerAddress->address2}<br>{/if}
                    {if isNotNull($summary->toCustomerAddress->landmark)}{$summary->toCustomerAddress->landmark}, {/if}{if isNotNull($summary->toCustomerAddress->pincode)}{$summary->toCustomerAddress->pincode}{/if}
                    Ph.No: {$summary->toCustomer->mobileNumber|default:'-'}<br/>
                    GST: {$summary->toCustomerGST|default:'-'}
                </td>
            </tr>

            <tr>
                <td colspan="1" align="center" class="border-bottom border-right"><b>Qty. </b></td>
                <td colspan="3" align="center" class="border-bottom border-right"><b>Item - Description </b></td>
                <td class="border-bottom border-right" align="center"><b>UOM</b></td>
                <td class="border-bottom border-right"><b>Rate</b></td>
                <td colspan="2" rowspan="2" align="right" class="border-bottom border-right">
                    <table width="100%">
                        <tr>
                            <td width="10%"></td>
                            <td align="center" class="border-bottom" width="40%"><b>{$summary->fromOrganization->shortCode}<br></b></td>
                            <td rowspan="2" width="50%" align="right">
                                <img src="{$base_url}qr?data={$summary->additionalAttribute->SLUG}&size=10" width="46px">
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
                    <table width="100%">
                        {foreach from=$summary->itemDetails item=article name=carArt}
                            {assign var=qty value=$qty + $article->itemCount}
                            <tr>
                                <td width="17%" align="center">{$article->itemCount|sigma:$totalarticles}</td>
                                <td width="50%">{$article->cargoItem->name} - {$article->cargoItem->description[0]}</td>
                                <td width="18%" align="left">{$article->unitValue} {$article_unit[$article->unit->code]}</td>
                                <td width="15%" align="right">{$article->fare|inr_format}</td>
                            </tr>
                        {/foreach}
                    </table>
                </td>
            </tr>

            <tr>
                <td colspan="2" class="border-top border-right">Tot : {$qty}</td>
                <td colspan="2" class="border-top border-right">Act Wt : {($actualWeight['QNTL'] + $actualWeight['KG']+$actualWeight['TON'])|default:'0'}</td>
                <td colspan="2" class="border-top border-right">Chg Wt : {($chargedWeight['QNTL'] + $chargedWeight['KG']+$chargedWeight['TON'])|default:'0'}</td>

                {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]}
                <td colspan="2" class="border-top border-right">Inv No : {$invoiceDetail[1]|default:'-'}</td>
                
                <td colspan="2" class="border-top border-bottom"><b>Delivery Type : </b>
                    {if $summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO'}
                        {$del_at = 'DOOR DLY'}
                    {else}
                        {$del_at = 'GODOWN'}
                    {/if}
                    <b>{$del_at}</b>
                </td>
            </tr>
            <tr>
                <td colspan="8" class="border-top border-right">Remark : &nbsp;{$summary->remarks[0]->name|ucwords}</td>
                <td align="center" colspan="2"><b class="font-11">{$payment_type_name|strtoupper}</b></td>
            </tr>
            <tr>
                <td colspan="5" class="border-top border-right">Receiver Signature</td>
                <td colspan="5" class="border-top">Sri Sai Transports <br/>Signature of Clerk / Agent</td>
            </tr>
        </table>           
    {/for}
{/strip}
