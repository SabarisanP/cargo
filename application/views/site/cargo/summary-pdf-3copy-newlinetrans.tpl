<style>
    .border-top { border-top: 1px solid #666; }
    .border-right { border-right: 1px solid #666; }
    .border-bottom { border-bottom: 1px solid #666; }
    .border-left { border-left: 1px solid #666; }
    .font-8 { font-size: 8px;}
    .font-9 { font-size: 9px;}
    .heading { font-size: 11px; text-decoration: underline;}
    .bold { font-weight: bold;}
</style>

{strip}
    {for $iter=1 to $smarty.request.count}
        {$actualWeight = array()}
        {$chargedWeight = array()}
        {foreach from=$summary->itemDetails  item=article}
            {$actualWeight[$article->unit->code] = $actualWeight[$article->unit->code] + $article->actualUnitValue}
            {$chargedWeight[$article->unit->code] = $chargedWeight[$article->unit->code] + $article->unitValue}
        {/foreach}
        <br>
        <table width="100%" cellpadding="2">
            <tr>
                {if $iter == 1}
                    <td colspan="12"><br><br><br><br><br><br><br><br><br><br><br></td>
                {elseif $iter == 2}
                    <td colspan="12"><br><br><br><br><br><br><br><br></td>
                {else}
                    <td colspan="12"><br><br><br><br><br><br><br><br><br></td>
                {/if}
            </tr>
            <tr>
                <td class="bold border-top border-right" align="center" colspan="4">Consignor</td>
                <td class="bold border-top border-right" align="center" colspan="5">Consignee</td>
                <td class="bold border-top" colspan="3" rowspan="2">
                    <table class="font-8" style="line-height: 19px;">
                        <tr>
                            <td class="bold" width="28%">Branch</td>
                            <td width="72%">:&nbsp;{$summary->fromOrganization->shortCode} - {$summary->toOrganization->shortCode}</td>
                        </tr>
                        <tr>
                            <td class="bold" width="28%">LR No.</td>
                            <td class="bold" width="72%">:&nbsp;{$summary->code}</td>
                        </tr>
                        <tr>
                            <td class="bold" width="28%">Date</td>
                            <td width="72%">:&nbsp;{$summary->bookedAt|date_format:$ns_date_format}</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="border-top border-right font-9" colspan="4">
                    <b>{substr($summary->fromCustomer->name, 0, 50)|strtolower|ucwords}</b><br>
                    {* {if isNotNull($summary->fromCustomerAddress->address1)}{$summary->fromCustomerAddress->address1}, {/if}
                    {if isNotNull($summary->fromCustomerAddress->address2)}{$summary->fromCustomerAddress->address2}<br>{/if}
                    {if isNotNull($summary->fromCustomerAddress->landmark)}{$summary->fromCustomerAddress->landmark}, {/if}{if isNotNull($summary->fromCustomerAddress->pincode)}{$summary->fromCustomerAddress->pincode}<br>{/if} *}
                    {* Ph.No: {$summary->fromCustomer->mobileNumber|default:'-'}<br/> *}
                    <span class="font-8">GST: {$summary->fromCustomerGST|default:'-'}</span>
                    
                    {* {if !isNotNull($summary->fromCustomerAddress->address1)}<br>{/if}
                    {if !isNotNull($summary->fromCustomerAddress->address2)}<br>{/if}
                    {if !isNotNull($summary->fromCustomerAddress->landmark) && !isNotNull($summary->fromCustomerAddress->pincode)}<br>{/if} *}
                </td>
                <td class="border-top border-right font-9" colspan="5">
                    <b>{substr($summary->toCustomer->name, 0, 50)|strtolower|ucwords}</b><br>
                    {* {if isNotNull($summary->toCustomerAddress->address1)}{$summary->toCustomerAddress->address1}, {/if}
                    {if isNotNull($summary->toCustomerAddress->address2)}{$summary->toCustomerAddress->address2}<br>{/if}
                    {if isNotNull($summary->toCustomerAddress->landmark)}{$summary->toCustomerAddress->landmark}, {/if}{if isNotNull($summary->toCustomerAddress->pincode)}{$summary->toCustomerAddress->pincode}{/if} *}
                    {* Ph.No: {$summary->toCustomer->mobileNumber|default:'-'}<br/> *}
                    <span class="font-8">GST: {$summary->toCustomerGST|default:'-'}</span>
                </td>
            </tr>
            <tr>
                <td class="bold border-top border-right" align="center">Qty</td>
                <td class="bold border-top border-right" colspan="4" align="center">Item - Description</td>
                <td class="bold border-top border-right" align="center">UOM</td>
                <td class="bold border-top border-right" align="center">Rate</td>
                <td class="bold border-top border-right" colspan="2" align="center">Actual Weight</td>

                <td class="border-top" colspan="3" rowspan="6">
                    <table>
                        {* {if $summary->totalAmount > 0 || in_array('FR', $addons_mapped['FRECR']->value)} *}
                        <tr>
                            <td colspan="2">Freight</td>
                            <td align="right">
                                {$summary->totalAmount|inr_format}
                            </td>
                        </tr>
                        {* {/if} *}

                        {* {if $summary->totalHandlingAmount > 0 || in_array('LC', $addons_mapped['FRECR']->value)} *}
                        <tr>
                            <td colspan="2">Load Ch</td>
                            <td align="right">
                                {$summary->totalHandlingAmount|inr_format}
                            </td>
                        </tr>
                        {* {/if} *}

                        {if $summary->pickupHandlingAmount > 0 || in_array('DP', $addons_mapped['FRECR']->value)}
                        <tr>
                            <td colspan="2">DC</td>
                            <td align="right">
                                {$summary->pickupHandlingAmount|inr_format}
                            </td>
                        </tr>
                        {/if}

                        {* {if $summary->deliveryHandlingAmount > 0 || in_array('DD', $addons_mapped['FRECR']->value)} *}
                        <tr>
                            <td colspan="2">DD</td>
                            <td align="right">
                                {$summary->deliveryHandlingAmount|inr_format}
                            </td>
                        </tr>
                        {* {/if} *}

                        {* {if $summary->hamaliCharge > 0 || in_array('HC', $addons_mapped['FRECR']->value)} *}
                        <tr>
                            <td colspan="2">Hamali Ch.</td>
                            <td align="right">
                                {$summary->hamaliCharge|inr_format}
                            </td>
                        </tr>
                        {* {/if} *}

                        {* {if $summary->docketCharge > 0 || in_array('DC', $addons_mapped['FRECR']->value)} *}
                        <tr>
                            <td colspan="2">Docket Ch.</td>
                            <td align="right">
                                {$summary->docketCharge|inr_format}
                            </td>
                        </tr>
                        {* {/if} *}

                        {if $tax_computed->cgstValue > 0}
                        <tr>
                            <td colspan="2">CGST</td>
                            <td align="right">{$tax_computed->cgstValue|inr_format}</td>
                        </tr>
                        {/if}

                        {if $tax_computed->sgstValue > 0}
                        <tr>
                            <td colspan="2">SGST</td>
                            <td align="right">{$tax_computed->sgstValue|inr_format}</td>
                        </tr>
                        {/if}

                        {if $tax_computed->igstValue > 0}
                        <tr>
                            <td colspan="2">IGST</td>
                            <td align="right">{$tax_computed->igstValue|inr_format}</td>
                        </tr>
                        {/if}

                        {if $tax_computed->ugstValue > 0}
                        <tr>
                            <td colspan="2">UGST</td>
                            <td align="right">{$tax_computed->ugstValue|inr_format}</td>
                        </tr>
                        {/if}

                        {if $addons_mapped['MCNHCH']->value > 0 || in_array('MC', $addons_mapped['FRECR']->value)}
                        <tr>
                            <td colspan="2">Machine Handling Ch.</td>
                            <td align="right">
                                {$addons_mapped['MCNHCH']->value|inr_format}
                            </td>
                        </tr> 
                        {/if}

                        <tr>
                            <td colspan="2">Others</td>
                            <td align="right">{($summary->serviceCharge + $summary->passCharge + $summary->totalUnloadHandlingAmount + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value + $addons_mapped['ADJSMT']->value)|inr_format}</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="border-top border-right" colspan="7" rowspan="4">
                    <table width="100%">
                        {foreach from=$summary->itemDetails item=article name=carArt}
                            <tr>
                                <td width="15%" align="center">{$article->itemCount|sigma:$totalarticles}</td>
                                <td width="57%">{$article->cargoItem->name} - {$article->cargoItem->description[0]}</td>
                                <td width="16%" align="left">{$article->unitValue} {$article_unit[$article->unit->code]}</td>
                                <td width="12%" align="right">
                                    {$article->fare|inr_format}
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                </td>
                <td class="bold border-top border-right" align="center">Qt.</td>
                <td class="bold border-top border-right" align="center">Kgs.</td>
            </tr>
            <tr>
                <td class="border-top border-right" align="center">{$actualWeight['QNTL']|default:'0'}</td>
                <td class="border-top border-right" align="center">{($actualWeight['KG']+$actualWeight['TON'])|default:'0'}</td>
            </tr>

            <tr>
                <td class="bold border-top border-right" colspan="2" align="center">Charged Weight</td>
            </tr>
            <tr>
                <td class="bold border-top border-right" align="center">Qt.</td>
                <td class="bold border-top border-right" align="center">Kgs.</td>
            </tr>
            <tr>
                <td align="center">{$totalarticles}</td>
                <td class="border-right" colspan="6">No. of items {$totalarticles|num_to_words} Only</td>
                <td class="border-top border-right border-bottom" align="center">{$chargedWeight['QNTL']|default:'0'}</td>
                <td class="border-top border-right border-bottom" align="center">{($chargedWeight['KG']+$chargedWeight['TON'])|default:'0'}</td>
            </tr>

            {* <tr>
                <td align="center">{$totalarticles}</td>
                <td class="border-right" colspan="6">No. of items {$totalarticles|num_to_words} Only</td>
                <td class="border-right" colspan="2"></td>
            </tr> *}
            <tr>
                <td class="bold border-top border-right" colspan="3">Invoice No</td>
                <td class="bold border-top border-right" colspan="2">Invoice Date</td>
                <td class="bold border-top border-right" colspan="2">Invoice Value</td>
                <td class="bold border-top border-right border-bottom" colspan="2">E-Way Bill</td>

                {assign var=netAmount value=$summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value + $addons_mapped['ADJSMT']->value + $addons_mapped['MCNHCH']->value}
                <td class="font-10 bold border-bottom" colspan="2">Grand Total</td>
                <td class="font-10 bold border-bottom" align="right">{$netAmount|inr_format}</td>
            </tr>
            <tr>
                <td class="border-top border-right" colspan="9">
                    <table class="100%">
                        <tbody>
                            {assign var=totalInvoiceAmount value=0}
                            {foreach from=$addons_mapped['EWBL'] item=val}
                                <tr>
                                    {assign var=invoiceDetail value="|"|explode:$val->value}
                                    <td width="35%">{$invoiceDetail[1]}</td>
                                    <td width="25%">{$invoiceDetail[2]|date_format:$ns_date_format}</td>
                                    <td width="15%" align="right">{$invoiceDetail[0]|inr_format}</td>
                                    <td width="25%" align="center">{$val->referenceCode}</td>
                                </tr>
                                {assign var=totalInvoiceAmount value=$totalInvoiceAmount+$invoiceDetail[0]}
                            {/foreach}
                            {if ($addons_mapped['EWBL']|count) < 2}
                                {for $space=1 to 2-($addons_mapped['EWBL']|count)}
                                    <tr>
                                        <td width="35%"></td>
                                        <td width="25%"></td>
                                        <td width="15%"></td>
                                        <td width="25%"></td>
                                    </tr>
                                {/for}
                            {/if}
                            <tr>
                                <td class="bold">
                                     Delivery Terms :&nbsp;
                                    {if $summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO'}
                                         Door Delivery 
                                    {else}
                                         GODOWN 
                                    {/if}
                                </td>
                                <td class="bold" colspan="2" align="right">Total</td>
                                <td align="right">{$totalInvoiceAmount|inr_format}</td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td class="bold" style="font-size: 13px;" colspan="3" align="center">
                    <br>
                    {$summary->paymentType->name}
                </td>
            </tr>
            <tr>
                <td class="border-top border-right" colspan="9"><span class="bold">Rupees In Words</span> <span style="{if strlen($netAmount|amount_in_words) > 65}font-size: 8px;{else}font-size: 10px;{/if}">&nbsp;&nbsp;{if $netAmount}{$netAmount|amount_in_words} Only{/if}</span></td>
                <td class="border-top border-left" rowspan="2" colspan="3" align="center"></td>
            </tr>
            <tr>
                <td colspan="4">Goods Carried At Owner's Risk</td>
                <td colspan="5" align="center">(Receiver : Date, Signature, Mobile No. & Stamp) </td>
            </tr>
            <tr>
                <td colspan="6">GST Pay By : GST</td>
                <td colspan="6" align="left">Printed By : <span class="bold">{$username}</span></td>
            </tr>
        </table>

        {if $iter < 3}
            <div><br></div>
        {/if}
    {/for}
{/strip}
