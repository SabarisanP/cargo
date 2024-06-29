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
        {$freight = 0}
        {$quantity = 0}

        {$ton_freight = 0}
        {$ton_actual_wt = 0}
        {$kg_actual_wt = 0}
        {$ton_charged_wt = 0}
        {$kg_charged_wt = 0}
        {$ton_quantity = 0}
        
        {$loading_charge = 0}
        {$unloading_charge = 0}
        {$door_del = 0}
        {$gst = 0}
        {$cgst = 0}
        {$sgst = 0}
        {$others = 0}

        {$lr_charge = 0}
        {$door_col = 0}
        {$tot = 0}
        {$total_articles = 0}
        {$unit_arr = ['QNTL', 'KG']}
        {foreach from=$summary->itemDetails  item=article}
            {if !in_array($article->unit->code, $unit_arr)}
                {$freight = $freight + ($article->fare * $article->itemCount)}
                {$quantity = $quantity + $article->itemCount}
            {elseif $article->unit->code == $unit_arr[0]}
                {$ton_freight = $ton_freight + ($article->fare * $article->unitValue)}
                {$ton_actual_wt = $ton_actual_wt + $article->actualUnitValue}
                {$ton_charged_wt = $ton_charged_wt + $article->unitValue}
                {$ton_quantity = $ton_quantity + $article->itemCount}
            {else}
                {$kg_actual_wt = $kg_actual_wt + $article->actualUnitValue}
                {$kg_charged_wt = $kg_charged_wt + $article->unitValue}
            {/if}

            {$loading_charge = $loading_charge + $article->handlingChargeAmount}
            {$unloading_charge = $unloading_charge + $article->unloadingChargeAmount}
            {$gst = $gst + $article->serviceTax}
            {$cgst = $cgst + $article->tax->cgstValue}
            {$sgst = $sgst + $article->tax->sgstValue}

            {$total_articles = $total_articles + $article->itemCount}
        {/foreach}

        {$others = $others + $summary->serviceCharge + $summary->docketCharge + $summary->passCharge}
        {$lr_charge = $lr_charge + $summary->docketCharge}
        {$door_col = $door_col + $summary->pickupHandlingAmount}
        {$door_del = $door_del + $summary->deliveryHandlingAmount}
        {$tot = $tot + $freight+$ton_freight+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value}
        
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

        {* <table width="100%" cellpadding="3">
            <tr>
                {if $iter==1}
                    <td colspan="2"></td>
                    <td colspan="2"></td>
                    <td colspan="4"></td>
                    <td colspan="2" align="center"><b>CONSIGNEE COPY</b></td>
                {/if}
                {if $iter==2}
                    <td colspan="2"></td>
                    <td colspan="2"></td>
                    <td colspan="4"></td>
                    <td colspan="2" align="center"><b>TRANSPORTER COPY</b></td>
                {/if}
                {if $iter==3}
                    <td colspan="2"></td>
                    <td colspan="2"></td>
                    <td colspan="4"></td>
                    <td colspan="2" align="center"><b>CONSIGNOR COPY</b></td>
                {/if}
            </tr>
        </table> *}
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
                    {if $ns == 'kntlogistics'}
                        &nbsp;<img src="assets/img/KNT-LR-Header.jpg" alt="logo" style="max-width: 100%;">
                    {elseif $ns == 'knttransports'}
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="assets/img/Kovai-Nellai-LR-Header.jpg" alt="logo" style="max-width: 100%;">
                    {/if}
                </td>
                <td align="center" class="border-right"><span style="font-size: 6px;">Scan and Pay</span><br>
                    <img src="{$base_url}qr?{http_build_query(['data' => $upiUrl])}" width="40px">
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
                <td class="border-top border-right" align="center" colspan="2"><b>Booking Office</b></td>
                <td class="border-top border-right" align="center" colspan="2"><b>Consignor</b></td>
                <td class="border-top border-right" align="center" colspan="2"><b>Consignee</b></td>
                <td class="border-top border-right" align="center" colspan="2"><b>Delivery Office</b></td>
            </tr>
            <tr>
                <td class="border-top border-right" colspan="2">
                    <b>{$summary->fromOrganization->name|strtolower|ucwords}</b><br>
                    {substr($summary->fromOrganization->address1, 0, 50)}<br>
                    {$summary->fromOrganization->contact}
                </td>
                <td class="border-top border-right" colspan="2">
                    <b>{substr($summary->fromCustomer->name, 0, 29)|strtolower|ucwords}</b><br>
                    {$summary->fromCustomer->mobileNumber}<br/>
                    GST: {$summary->fromCustomerGST}<br>
                    Place: {$summary->fromStation->name|strtolower|ucwords}<br>
                </td>
                <td class="border-top border-right" colspan="2">
                    <b>{substr($summary->toCustomer->name, 0, 29)|strtolower|ucwords}</b><br>
                    {$summary->toCustomer->mobileNumber}<br/>
                    GST: {$summary->toCustomerGST}<br>
                    Place: {$summary->toOrganization->name|strtolower|ucwords}
                    {* Place: {$summary->toStation->name} *}
                </td>
                <td class="border-top border-right" colspan="2">
                    {if isNotNull($summary->toCustomerAddress->code) && ($summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO')}
                        <b>{$summary->toCustomer->name|strtolower|ucwords}</b><br>
                        {substr($summary->toCustomerAddress->address1, 0, 25)}, {substr($summary->toCustomerAddress->landmark, 0, 10)}, {substr($summary->toCustomerAddress->station->name, 0, 13)} - {$summary->toCustomerAddress->pincode}
                        {$summary->toCustomer->mobileNumber}
                    {else}
                        {substr($summary->toOrganization->address1, 0, 50)}<br>
                        {$summary->toOrganization->contact}
                    {/if}
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
                            <td align="right">{($freight + $ton_freight)|inr_format:2}</td>
                        </tr>
                        <tr>
                            <td>Load Ch</td>
                            <td align="right">{$loading_charge|inr_format:2}</td>
                        </tr>
                        <tr>
                            <td>Unload Ch</td>
                            <td align="right">{$unloading_charge|inr_format:2}</td>
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
                            <td align="right">{$cgst|inr_format:2}</td>
                        </tr>
                        <tr>
                            <td>SGST</td>
                            <td align="right">{$sgst|inr_format:2}</td>
                        </tr>
                        <tr>
                            <td>Others</td>
                            <td align="right">{$others|inr_format:2}</td>
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
                <td class="border-top border-right" align="center">
                    {if $ActualWeight.code =="QNTL"}
                        {$ActualWeight.change_qt}
                    {else}
                        {$ton_actual_wt}
                    {/if}
                </td>
                <td class="border-top border-right" align="center">
                    {if $ActualWeight.code =="QNTL"}
                        {$ActualWeight.change_kg}
                    {else}
                        {$kg_actual_wt}
                    {/if}
                </td>
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

                <td class="border-top border-right" align="center">
                    {if $ActualWeight.code =="QNTL"}
                        {$ActualWeight.qt_val}
                    {else}
                        {$ton_charged_wt}
                    {/if}
                </td>
                <td class="border-top border-right" align="center">
                    {if $ActualWeight.code =="QNTL"}
                        {$ActualWeight.kg_val}
                    {else}
                        {$kg_charged_wt}
                    {/if}
                </td>
            </tr>

            <tr>
                {if $summary->deliveryType->code == 'DYDO'}
                    <td colspan="6" class="border-right" align="center"><b>HIRE UPTO - {$summary->toOrganization->name|strtoupper}</b></td>
                {else}
                	<td colspan="6" class="border-right" align="center"><b>HIRE UPTO - {$summary->toStation->name|strtoupper}</b></td>
                {/if}

                <td class="border-top border-right" colspan="2" align="center"><b></b></td>
            </tr>
            <tr>
                {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
                <td colspan="2" class="border-top border-right"><b>Inv. No.</b> &nbsp;&nbsp;{$invoiceDetail[1]|default:'-'}</td>
                <td colspan="2" class="border-top border-right"><b>Inv. Date</b> &nbsp;&nbsp;{$invoiceDetail[2]|default:'-'}</td>
                <td colspan="2" class="border-top border-right"><b>Inv. Value</b> &nbsp;&nbsp;{$invoiceDetail[0]|default:'0.00'}</td>

                <td class="border-right" align="center" colspan="2"></td>
                <td style="font-size: 8px;"><b>Grand Total</b></td>
                <td align="right" style="font-size: 8px;"><b>{$tot|inr_format:2}</b></td>
            </tr>
            <tr>
                {if $tot}
                    {$amt_in_word = ($tot|amount_in_words|ucwords)}
                {/if}
                <td colspan="8" class="border-top border-right"><span><b>Rupees In Words</b></span> <span style="{if strlen($amt_in_word) > 65}font-size: 8px;{else}font-size: 10px;{/if}">&nbsp;&nbsp;{if $amt_in_word}{$amt_in_word} Only{/if}</span></td>
                {* <td colspan="3" class="border-top border-right"></td> *}
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
            {* <div class="h-seperator"></div> *}
            <div></div>
        {/if}
    {/for}
{/strip}
