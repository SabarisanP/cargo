<style>
    .h-seperator { border-bottom: 1px dashed #666; height: 0px; }
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
        {$actualWeight = array()}
        {$chargedWeight = array()}
        {$total_articles = 0}
        {foreach from=$summary->itemDetails  item=article}
            {$actualWeight[$article->unit->code] = $actualWeight[$article->unit->code] + $article->actualUnitValue}
            {$chargedWeight[$article->unit->code] = $chargedWeight[$article->unit->code] + $article->unitValue}
            {$total_articles = $total_articles + $article->itemCount}
        {/foreach}
        
        {* deliver at *}
        {if isNotNull($summary->toCustomerAddress->code) && ($summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO')}
            {$del_at = 'DOOR DLY'}
        {else}
            {$del_at = 'GODOWN'}
        {/if}

        {* vehicle number *}
        {if isset($summary->tripInfo->busVehicle->registationNumber) && $summary->tripInfo->busVehicle->registationNumber != 'false'}
            {$vehi_reg_no = $summary->tripInfo->busVehicle->registationNumber}
        {elseif $summary->transitVehicle->registationNumber != '' && $summary->transitVehicle->registationNumber != 'false'}
            {$vehi_reg_no = $summary->transitVehicle->registationNumber}
        {elseif $summary->additionalAttribute->registerNumber != '' && $summary->additionalAttribute->registerNumber != 'false'}
            {$vehi_reg_no = $summary->additionalAttribute->registerNumber}
        {else}
            {$vehi_reg_no = "-"}
        {/if}

        {* GST / RCM *}
        {if $summary->paymentType->code == 'PAD' && ($summary->fromCustomerGST != '' || $summary->toCustomerGST != '')}
            {$GST_RCM = 'Consignor'}
        {elseif $summary->paymentType->code == 'TOP' && ($summary->fromCustomerGST != '' || $summary->toCustomerGST != '')}
            {$GST_RCM = 'Consignee'}
        {elseif $summary->fromCustomerGST == '' && $summary->toCustomerGST == ''}
            {$GST_RCM = 'Transporter'}
        {else}
            {$GST_RCM = '-'}
        {/if}
        
        {if $iter==1}
            <br><br>
        {/if}
        {if $iter==2}
            <br><br>
        {/if}
        {if $iter==3}
            <br><br>
        {/if}
                
        <table width="100%" cellpadding="2" class="">
            <tr>
                <td class="border-right" width="70%" colspan="7">
                    &nbsp;<img src="assets/img/saiparcelkovai-header.jpeg" alt="logo" style="max-width: 100%;">
                </td>
                <td class="border-right">
                    <img src="{$base_url}qr?data={$summary->additionalAttribute->SLUG}&size=10" width="46px">
                </td>
                <td rowspan="2" colspan="2">
                    <table>
                        <tr>
                            <td width="35%"><b>Station</b></td>
                            <td width="65%">:&nbsp;{$summary->fromStation->shortCode}</td>
                        </tr>
                        <tr>
                            <td width="35%"><b>LR No.</b></td>
                            <td width="65%">:&nbsp;<b style="font-size: 8px;">{$summary->code}</b></td>
                        </tr>
                        <tr>
                            <td width="35%"><b>Date</b></td>
                            <td width="65%">:&nbsp;{$summary->bookedAt|date_format:$ns_date_format}</td>
                        </tr>
                        <tr>
                            <td width="35%"><b>From</b></td>
                            <td width="65%">:&nbsp;{$summary->fromStation->name|strtolower|ucwords}</td>
                        </tr>
                        <tr>
                            <td width="35%"><b>To</b></td>
                            <td width="65%">:&nbsp;
                                {if isNotNull($summary->toCustomerAddress->code) && ($summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO')}
                                    {$summary->toOrganization->name|strtolower|ucwords}
                                {else}
                                    {$summary->toStation->name|strtolower|ucwords}
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td width="35%"><b>Truck No</b></td>
                            <td width="65%">:&nbsp;{$vehi_reg_no}</td>
                        </tr>
                        <tr>
                            <td width="35%"><b>Del. at</b></td>
                            <td width="65%">:&nbsp;{$del_at}</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="border-top border-right" align="center" colspan="4"><b>Consignor</b></td>
                <td class="border-top border-right" align="center" colspan="4"><b>Consignee</b></td>
            </tr>
            <tr>
                <td class="border-top border-right" colspan="4">
                    <b>{substr($summary->fromCustomer->name, 0, 29)|strtolower|ucwords}</b><br>
                    {$summary->fromCustomer->mobileNumber}<br/>
                    GST: {$summary->fromCustomerGST}<br>
                    Place: {$summary->fromStation->name|strtolower|ucwords}<br>
                </td>
                <td class="border-top border-right" colspan="4">
                    <b>{substr($summary->toCustomer->name, 0, 29)|strtolower|ucwords}</b><br>
                    {$summary->toCustomer->mobileNumber}<br/>
                    GST: {$summary->toCustomerGST}<br>
                    Place: {$summary->toOrganization->name|strtolower|ucwords}
                </td>
                <td class="border-top" colspan="2" align="center" style="font-size: 12px;"><b><br>{$summary->paymentType->name}</b></td>
            </tr>
            <tr>
                <td class="border-top border-right" align="center"><b>Quantity</b></td>
                <td class="border-top border-right" align="center"><b>Pack. Method</b></td>
                <td class="border-top border-right" colspan="2" align="center"><b>Description</b></td>
                <td class="border-top border-right" align="center"><b>UOM</b></td>
                <td class="border-top border-right" align="center"><b>Rate</b></td>
                <td class="border-top border-right" colspan="2" align="center"><b>Actual Weight</b></td>
                <td class="border-top" width="20%" colspan="2" rowspan="7">
                    <table cellpadding="" width="100%">
                        <tr>
                            <td>Freight</td>
                            <td align="right">{$summary->totalAmount|inr_format:2}</td>
                        </tr>
                        <tr>
                            <td>Load Ch</td>
                            <td align="right">{$summary->totalHandlingAmount|inr_format:2}</td>
                        </tr>
                        <tr>
                            <td>Unload Ch</td>
                            <td align="right">{$summary->totalUnloadHandlingAmount|inr_format:2}</td>
                        </tr>
                        <tr>
                            <td>Door Pick Ch</td>
                            <td align="right">{$summary->pickupHandlingAmount|inr_format:2}</td>
                        </tr>
                        <tr>
                            <td>Door Del Ch</td>
                            <td align="right">{$summary->deliveryHandlingAmount|inr_format:2}</td>
                        </tr>
                        <tr>
                            <td>CGST</td>
                            <td align="right">{$tax_computed->cgstValue|inr_format:2}</td>
                        </tr>
                        <tr>
                            <td>SGST</td>
                            <td align="right">{$tax_computed->sgstValue|inr_format:2}</td>
                        </tr>
                        <tr>
                            <td>Others</td>
                            <td align="right">{($summary->serviceCharge + $summary->docketCharge + $summary->hamaliCharge + $summary->passCharge + $tax_computed->ugstValue + $tax_computed->igstValue + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value + $addons_mapped['ADJSMT']->value)|inr_format}</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="border-top border-right" colspan="6" rowspan="4">
                    <table width="100%">
                        {foreach from=$summary->itemDetails item=article name=carArt}
                            <tr>
                                <td width="17%" align="center">{$article->itemCount|sigma:$tot_article}</td>
                                <td width="17%">{$article->cargoItem->name}</td>
                                <td width="33%">{$article->cargoItem->description[0]}</td>
                                <td width="17%" align="center">{$article->unitValue} {$article_unit[$article->unit->code]}</td>
                                <td width="16%" align="right">{$article->fare|inr_format}</td>
                            </tr>
                        {/foreach}
                    </table>
                </td>
                <td class="border-top border-right" align="center"><b>Qt.</b></td>
                <td class="border-top border-right" align="center"><b>Kgs.</b></td>
            </tr>
            <tr>
                <td class="border-top border-right" align="center">{$actualWeight['QNTL']|default:'0'}</td>
                <td class="border-top border-right" align="center">{($actualWeight['KG']+$actualWeight['TON'])|default:'0'}</td>
            </tr>

            <tr>
                <td class="border-top border-right" colspan="2" align="center"><b>Charged Weight</b></td>
            </tr>
            <tr>
                <td class="border-top border-right" align="center"><b>Qt.</b></td>
                <td class="border-top border-right" align="center"><b>Kgs.</b></td>
            </tr>
            <tr>
                <td align="center">{$total_articles}</td>
                <td colspan="5" class="border-right">No Of Items {$total_articles|num_to_words|ucwords} Only</td>
                <td class="border-top border-right" align="center">{$chargedWeight['QNTL']|default:'0'}</td>
                <td class="border-top border-right" align="center">{($chargedWeight['KG']+$chargedWeight['TON'])|default:'0'}</td>
            </tr>

            <tr>
                <td colspan="6" class="border-right" align="center"><b>HIRE UPTO - {$summary->toStation->name|strtoupper}</b></td>
                <td class="border-top border-right" colspan="2" align="center"><b></b></td>
            </tr>
            <tr>
                {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
                <td colspan="2" class="border-top border-right"><b>Inv. No.</b> &nbsp;&nbsp;{$invoiceDetail[1]|default:'-'}</td>
                <td colspan="2" class="border-top border-right"><b>Inv. Date</b> &nbsp;&nbsp;{$invoiceDetail[2]|default:'-'}</td>
                <td colspan="2" class="border-top border-right"><b>Inv. Value</b> &nbsp;&nbsp;{$invoiceDetail[0]|default:'0.00'}</td>
                <td class="border-right" align="center" colspan="2"></td>

                {assign var=netAmount value=$summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value + $addons_mapped['ADJSMT']->value + $addons_mapped['MCNHCH']->value}
                <td style="font-size: 8px;"><b>Grand Total</b></td>
                <td align="right" style="font-size: 8px;"><b>{$netAmount|inr_format:2}</b></td>
            </tr>
            <tr>
                {if $netAmount}
                    {$amt_in_word = ($netAmount|amount_in_words|ucwords)}
                {/if}
                <td colspan="8" class="border-top border-right"><span><b>Rupees In Words</b></span> <span style="{if strlen($amt_in_word) > 65}font-size: 8px;{else}font-size: 10px;{/if}">&nbsp;&nbsp;{if $amt_in_word}{$amt_in_word} Only{/if}</span></td>
                <td rowspan="2" class="border-top" colspan="2" align="center">
                    {if $ns == 'kntlogistics'}
                        For KNT Logistics & Travels
                    {elseif $ns == 'knttransports'}
                        For Kovai Nellai Transports
                    {/if}{if $iter < 3}<br><br><br>{else}<br>{/if}
                </td>
            </tr>
            <tr>
                <td colspan="5">{if $iter < 3}<br><br><br>{else}<br>{/if}GST payment on RCM Payable by {$GST_RCM}</td>
                <td colspan="3" class="border-right" align="center">{if $iter < 3}<br><br><br>{else}<br>{/if}(Receiver : Date, Signature, Mobile No. & Stamp) </td>
            </tr>
        </table>

        {if $iter < 3}
            <div></div>
        {/if}
    {/for}
{/strip}
