<style>
    .border-top {
        border-top: 1px solid #666;
    }

    .border-right {
        border-right: 1px solid #666;
    }

    .border-bottom {
        border-bottom: 1px solid #666;
    }

    .border-left {
        border-left: 1px solid #666;
    }

    .font-10 {
        font-size: 10px;
    }

    .heading {
        font-size: 11px;
        text-decoration: underline;
    }

    .bold {
        font-weight: bold;
    }
    .border-size {
    line-height: 1.1;
  
}
.spacer td {
    font-size:8.2px;
}


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
        <table width="100%">
            <tr>
                <td class="bold heading" align="center">Consignment Receipt</td>
            </tr>
        </table>
        <table width="100%" cellpadding="2">
            {* <tr>
                <td colspan="8"></td>
                <td colspan="5" align="right">GST is payable by consignor / consignee - RCM</td>
            </tr> *}
            <tr>
                <td width="63%" colspan="8"><br><br><br><br>
                    {* &nbsp;<img src="assets/img/Seenu-Cargo-header.png" alt="logo" style="max-width: 100%;"> *}
                </td>
                <td class="border-right" width="11%" rowspan="2">
                    <img src="{$base_url}qr?data={$summary->additionalAttribute->SLUG}&size=10" width="65px">
                </td>
                <td colspan="3" rowspan="2" width="26%">
                    <table style="line-height: 19px;">
                        <tr>
                            <td class="bold" width="25%">Branch</td>
                            <td width="75%">:&nbsp;{$summary->fromOrganization->shortCode} - {$summary->toOrganization->shortCode}</td>
                        </tr>
                        <tr>
                            <td class="bold" width="25%">LR No.</td>
                            <td class="bold" width="75%">:&nbsp;{$summary->code}</td>
                        </tr>
                        <tr>
                            <td class="bold" width="25%">Date</td>
                            <td width="75%">:&nbsp;{$summary->bookedAt|date_format:$ns_date_format}</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="bold">
                <td colspan="3">GSTIN: {$gst_no}</td>
                <td colspan="2">SAC CODE: 996511</td>
                <td colspan="3">PAN: AAUCS4702J</td>
            </tr>
            <tr>
                <td class="bold border-top border-right" align="center" colspan="3">Booking Office</td>
                <td class="bold border-top border-right" align="center" colspan="3">Consignor</td>
                <td class="bold border-top border-right" align="center" colspan="3">Consignee</td>
                <td class="bold border-top" align="center" colspan="3">Delivery To/Shipped To</td>
            </tr>
            <tr class="spacer">
                <td class="border-top border-right border-size font-size" colspan="3">
                    <b>{$summary->fromOrganization->name|strtolower|ucwords}</b><br>
                    {if isNotNull($summary->fromOrganization->address1)}{$summary->fromOrganization->address1},{/if}
                    {if isNotNull($summary->fromOrganization->address2)}{$summary->fromOrganization->address2}<br>{/if}
                    {$summary->fromOrganization->contact}<br>

                    {if !isNotNull($summary->fromOrganization->address1)}<br>{/if}
                    {if !isNotNull($summary->fromOrganization->address2)}<br><br>{/if}
                    {if !isNotNull($summary->fromOrganization->contact)}<br>{/if}

                    {if $summary->deliveryType->code == 'PUDO' || $summary->deliveryType->code == 'PDDO'}
                        &nbsp;&nbsp;&nbsp;&nbsp;<span style="background-color: #e7e6e3;color: #000"> Door Pickup </span>
                    {/if}
                </td>
                <td class="border-top border-right border-size" colspan="3" > 
                    <b>{substr($summary->fromCustomer->name, 0, 50)|strtolower|ucwords}</b><br>
                    {if isNotNull($summary->fromCustomerAddress->address1)}{$summary->fromCustomerAddress->address1}, {/if}
                    {if isNotNull($summary->fromCustomerAddress->address2)}{$summary->fromCustomerAddress->address2}<br>{/if}
                    {if isNotNull($summary->fromCustomerAddress->landmark)}{$summary->fromCustomerAddress->landmark}, {/if}{if isNotNull($summary->fromCustomerAddress->pincode)}{$summary->fromCustomerAddress->pincode}<br>{/if}
                    Ph.No: {$summary->fromCustomer->mobileNumber|default:'-'}<br />
                    GST: {$summary->fromCustomerGST|default:'-'}

                    {if !isNotNull($summary->fromCustomerAddress->address1)}<br>{/if}
                    {if !isNotNull($summary->fromCustomerAddress->address2)}<br>{/if}
                    {if !isNotNull($summary->fromCustomerAddress->landmark) && !isNotNull($summary->fromCustomerAddress->pincode)}<br>{/if}
                </td>
                <td class="border-top border-right border-size" colspan="3">
                    <b>{substr($summary->toCustomer->name, 0, 50)|strtolower|ucwords}</b><br>
                    {if isNotNull($summary->toCustomerAddress->address1)}{$summary->toCustomerAddress->address1}, {/if}
                    {if isNotNull($summary->toCustomerAddress->address2)}{$summary->toCustomerAddress->address2}<br>{/if}
                    {if isNotNull($summary->toCustomerAddress->landmark)}{$summary->toCustomerAddress->landmark}, {/if}{if isNotNull($summary->toCustomerAddress->pincode)}{$summary->toCustomerAddress->pincode}{/if}
                    Ph.No: {$summary->toCustomer->mobileNumber|default:'-'}<br />
                    GST: {$summary->toCustomerGST|default:'-'}
                </td>
                <td class="border-top border-size" colspan="3">
                    {if isNotNull($summary->toCustomerAddress->code) && ($summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO')}
                        <b>{$summary->toCustomer->name|strtolower|ucwords}</b><br>
                        {substr($summary->toCustomerAddress->address1, 0, 25)}, {substr($summary->toCustomerAddress->landmark, 0, 10)}, {substr($summary->toCustomerAddress->station->name, 0, 13)} - {$summary->toCustomerAddress->pincode}
                        {$summary->toCustomer->mobileNumber}<br>

                        {if !isNotNull($summary->toCustomerAddress->address1)}<br><br>{/if}
                        {if !isNotNull($summary->toCustomer->mobileNumber)}<br>{/if}
                    {else}
                        <b>{$summary->toOrganization->name|strtolower|ucwords}</b><br>
                        {if isNotNull($summary->toOrganization->address1)}{$summary->toOrganization->address1},{/if}
                        {if isNotNull($summary->toOrganization->address2)}{$summary->toOrganization->address2}<br>{/if}
                        {$summary->toOrganization->contact}<br>

                        {if !isNotNull($summary->toOrganization->address1)}<br>{/if}
                        {if !isNotNull($summary->toOrganization->address2)}<br><br>{/if}
                        {if !isNotNull($summary->toOrganization->contact)}<br>{/if}
                    {/if}

                    {if $summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO'}
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="background-color: #e7e6e3;color:#000"> Door Delivery </span>
                    {/if}
                </td>
            </tr>
            <tr>
                <td class="bold border-top border-right" align="center">Qty</td>
                <td class="bold border-top border-right" colspan="4" align="center">Item - Description</td>
                <td class="bold border-top border-right" align="center">UOM</td>
                <td class="bold border-top border-right" align="center">Rate</td>
                <td class="bold border-top border-right" colspan="2" align="center">Actual Weight</td>

                <td class="border-top" colspan="3" rowspan="7">
                    <table>
                        {if $summary->totalAmount > 0 || in_array('FR', $addons_mapped['FRECR']->value)}
                            <tr>
                                <td colspan="2">Freight</td>
                                <td align="right">
                                    {if in_array('FR', $addons_mapped['FRECR']->value)}
                                        FS
                                    {else}
                                        {$summary->totalAmount|inr_format}
                                    {/if}
                                </td>
                            </tr>
                        {/if}

                        {if $summary->totalHandlingAmount > 0 || in_array('HC', $addons_mapped['FRECR']->value)}
                            <tr>
                                <td colspan="2">Hamali ch</td>
                                <td align="right">
                                    {if in_array('LC', $addons_mapped['FRECR']->value)}
                                        FS
                                    {else}
                                        {$summary->totalHandlingAmount|inr_format}
                                    {/if}
                                </td>
                            </tr>
                        {/if}

                        {if $summary->pickupHandlingAmount > 0 || in_array('DP', $addons_mapped['FRECR']->value)}
                            <tr>
                                <td colspan="2">DC</td>
                                <td align="right">
                                    {if in_array('DP', $addons_mapped['FRECR']->value)}
                                        FS
                                    {else}
                                        {$summary->pickupHandlingAmount|inr_format}
                                    {/if}
                                </td>
                            </tr>
                        {/if}

                        {if $summary->deliveryHandlingAmount > 0 || in_array('DD', $addons_mapped['FRECR']->value)}
                            <tr>
                                <td colspan="2">DD</td>
                                <td align="right">
                                    {if in_array('DD', $addons_mapped['FRECR']->value)}
                                        FS
                                    {else}
                                        {$summary->deliveryHandlingAmount|inr_format}
                                    {/if}
                                </td>
                            </tr>
                        {/if}

                        {if $summary->hamaliCharge > 0 || in_array('HC', $addons_mapped['FRECR']->value)}
                            <tr>
                                <td colspan="2">Hamali Ch.</td>
                                <td align="right">
                                    {if in_array('HC', $addons_mapped['FRECR']->value)}
                                        FS
                                    {else}
                                        {$summary->hamaliCharge|inr_format}
                                    {/if}
                                </td>
                            </tr>
                        {/if}

                        {if $summary->docketCharge > 0 || in_array('DC', $addons_mapped['FRECR']->value)}
                            <tr>
                                <td colspan="2">Docket Ch.</td>
                                <td align="right">
                                    {if in_array('DC', $addons_mapped['FRECR']->value)}
                                        FS
                                    {else}
                                        {$summary->docketCharge|inr_format}
                                    {/if}
                                </td>
                            </tr>
                        {/if}

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
                                    {if in_array('MC', $addons_mapped['FRECR']->value)}
                                        FS
                                    {else}
                                        {$addons_mapped['MCNHCH']->value|inr_format}
                                    {/if}
                                </td>
                            </tr>
                        {/if}

                        <tr>
                            <td colspan="2">Others</td>
                            <td align="right">{($summary->serviceCharge + $summary->passCharge + $summary->totalUnloadHandlingAmount + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value)|inr_format}</td>
                        </tr>

                        {if $addons_mapped['ADJSMT']->value}
                            <tr>
                                <td colspan="2">Add/Less</td>
                                <td align="right">{$addons_mapped['ADJSMT']->value|inr_format}</td>
                            </tr>
                        {/if}
                        <tr>
                            {assign var=netAmount value=$summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value + $addons_mapped['ADJSMT']->value + $addons_mapped['MCNHCH']->value}
                            <td class="font-10 bold border-bottom" colspan="2">Grand Total</td>
                            <td class="font-10 bold border-bottom" align="right">{$netAmount|inr_format}</td>
                        </tr>
                        {if $Gststate == $stateCode}
                            <tr>
                                <td colspan="2">CGST &nbsp;<b>(2.5%)</b></td>
                                <td align="right"><b>({$netAmount*2.5/100})</b></td>
                            </tr>
                            <tr>
                                <td colspan="2">SGST &nbsp;<b>(2.5%)</b></td>
                                <td align="right"><b>({$netAmount*2.5/100})</b></td>
                            </tr>
                        {else}
                            <br>
                            <tr>
                                <td class="border-bottom" colspan="2">IGST <b>(5%)</b></td>
                                <td align="right" class="border-bottom" colspan="2"><b>({$netAmount*5/100})</b></td>
                            </tr>

                        {/if}
                    </table>
                </td>
            </tr>
            <tr>
                <td class="border-top border-right" colspan="7" rowspan="5">
                    <table width="100%">
                        {assign var="totalarticles" value=0}
                        {foreach from=$summary->itemDetails item=article name=carArt}
                            <tr>
                                <td width="15%" align="center">{$article->itemCount}</td>
                                <td width="57%">{$article->cargoItem->name} - {$article->cargoItem->description[0]}</td>
                                <td width="16%" align="left">{$article->unitValue} {$article_unit[$article->unit->code]}</td>
                                <td width="12%" align="right">
                                    {if in_array('FR', $addons_mapped['FRECR']->value)}
                                        FS
                                    {else}
                                        {$article->fare|inr_format}
                                    {/if}
                                </td>
                            </tr>
                            {assign var="totalarticles" value=$totalarticles+$article->itemCount}
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
                <td class="border-top border-right border-bottom" align="center">{$chargedWeight['QNTL']|default:'0'}</td>
                <td class="border-top border-right border-bottom" align="center">{($chargedWeight['KG']+$chargedWeight['TON'])|default:'0'}</td>
            </tr>

            <tr>
                <td align="center">{$totalarticles}</td>
                <td class="border-right" colspan="6">No. of items {$totalarticles|num_to_words} Only</td>
                <td class="border-right" colspan="2"></td>
            </tr>
            <tr>
                <td class="bold border-top border-right" colspan="3">Invoice No</td>
                <td class="bold border-top border-right" colspan="2">Invoice Date</td>
                <td class="bold border-top border-right" colspan="2">Invoice Value</td>
                <td class="bold border-top border-right border-bottom" colspan="2">E-Way Bill</td>
                {* <td rowspan="2">CGST</td> *}
                {* {assign var=netAmount value=$summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value + $addons_mapped['ADJSMT']->value + $addons_mapped['MCNHCH']->value}
                <td class="font-10 bold border-bottom" colspan="2">Grand Total</td>
                <td class="font-10 bold border-bottom" align="right">{$netAmount|inr_format}</td> *}
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
                                <td class="bold" colspan="2" align="right">Total</td>
                                <td align="right">{$totalInvoiceAmount|inr_format}</td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td class="bold" style="font-size: 13px;" colspan="3" align="center">
                    <br>
                    {$summary->paymentType->name}
                    {if isNotNull($summary->cargoTransactionList[0]->transactionMode->code)}
                        / {$summary->cargoTransactionList[0]->transactionMode->name}
                        <br>
                        <span style="font-size: 10px;">{$trans_no}</span>
                    {/if}
                </td>
            </tr>
            <tr>
                <td class="border-top border-right" colspan="9"><span class="bold">Rupees In Words</span> <span style="{if strlen($netAmount|amount_in_words) > 65}font-size: 8px;{else}font-size: 10px;{/if}">&nbsp;&nbsp;{if $netAmount}{$netAmount|amount_in_words} Only{/if}</span></td>
                <td class="border-top border-left" rowspan="3" colspan="9" align="center">
                    For SEENU TRANSPORTS <span style="font-size: 7px;">Pvt Ltd</span>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="2" style="font-size: 9px;" class="bold"><br>Goods Remarks :</td>
                <td colspan="7" align="left"><br>{$summary->remarks[0]->name}</td>
            </tr>
            <tr>
                <td colspan="4"><br>Goods Carried At Owner's Risk</td>
                <td colspan="5" align="center"><br>(Receiver : Date, Signature, Mobile No. & Stamp) </td>
            </tr>
            <tr>
                <td class="bold" colspan="2" align="right">Booked by :</td>
                <td colspan="4">{$summary->bookedUser->name}</td>
                <td colspan="3">{$summary->bookedAt|date_format:$ns_datetime_format}</td>
            </tr>
        </table>

        {if $iter < 3}
            <div></div>
        {/if}
    {/for}
{/strip}