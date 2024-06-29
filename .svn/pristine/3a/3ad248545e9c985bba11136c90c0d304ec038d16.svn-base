<style>
    .h-seperator {
        border-bottom: 1px dashed #666;
        height: 0px;
    }

    .bordered {
        border: 0.2px solid #000;
    }

    .bordered td {
        border: 0.2px solid #000;
    }

    .valign-bottom {
        vertical-align: bottom;
    }

    .font-7 {
        font-size: 7px;
    }

    .font-10 {
        font-size: 10px;
    }

    .font-12 {
        font-size: 12px;
    }

    .font-14 {
        font-size: 14px;
    }

    .bold {
        font-weight: bold;
    }
</style>
{strip}
     {for $iter=1 to $no_of_copy} 
        <table width="100%" class="border-collapse font-10">
            <tbody>
                <tr>
                    <td colspan="2" align="center" class="font-10">
                    <img src="assets/img/clientlogo/shaik-transport-logo.jpg" alt="logo" style="max-width: 100%;"><br>
                        {$summary->fromOrganization->address1|capitalize}, &nbsp;{$summary->fromOrganization->address2|capitalize} <br>
                        {$summary->fromOrganization->contact} &nbsp; | &nbsp; <span class="bold"> GST : {if isNotNull($summary->tax->gstin)} {$summary->tax->gstin} {else} 33AKQPJ1586N1ZK {/if} </span><br>
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <table class="bordered" cellpadding="3">
                            <tr>
                                <td>
                                    <span class="bold font-10">LR.No : {$summary->code}</span> <br>
                                    Date : {$summary->bookedAt|date_format:$ns_date_format}
                                </td>
                                <td>
                                    <span class="bold font-10">From: </span> {$summary->fromCustomer->name},
                                    {if isNotNull($summary->fromCustomerAddress->code)}
                                        {$summary->fromCustomerAddress->station->name}
                                    {/if}
                                    <br>{$summary->fromStation->name} - {$summary->fromCustomer->mobileNumber}
                                </td>
                                <td>
                                    <span class="bold font-10">To: </span> {$summary->toCustomer->name},
                                    {if isNotNull($summary->toCustomerAddress->code)}
                                        {$summary->toCustomerAddress->station->name}
                                    {/if}
                                    <br> {$summary->toStation->name} - {$summary->toCustomer->mobileNumber}
                                </td>
                            </tr>

                        </table>
                    </td>
                </tr>

                <tr>
                    <td width="70%"> <br><br>
                        {assign var=subtotal value=0}
                        {assign var=totalitems value=0}
                        {assign var=totalweight value=0}
                        {assign var=weightunit value=''}
                        {foreach from=$summary->itemDetails item=article name=carArt}
                            {assign var=totalitems value=$totalitems+$article->itemCount}
                            {assign var=totalweight value=$totalweight+$article->unitValue}
                            {assign var=weightunit value=$article_unit[$article->unit->code]}
                        {/foreach}
                        <table>
                            <tr>
                                <td>
                                    <table class="bordered" cellpadding="3">
                                        <tr>
                                            <td align="center">No.of Articles</td>
                                        </tr>
                                        <tr>
                                            <td align="center">{$totalitems}</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table class="bordered" cellpadding="3">
                                        <tr>
                                            <td align="center">Description</td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <table>
                                                    {foreach from=$summary->itemDetails item=article name=carArt}
                                                        <tr align="center">
                                                            <td align="center">{$article->cargoItem->name}</td>
                                                            <td align="center">{$article->itemCount}</td>
                                                        </tr>
                                                        {assign var=subtotal value=$subtotal + $article->computed->freight}
                                                    {/foreach}
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table class="bordered" cellpadding="3">
                                        <tr>
                                            <td align="center">Weight KGs</td>
                                        </tr>
                                        <tr>
                                            <td align="center">{$totalweight} {$weightunit}</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr>
                                {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
                                <td class="bordered" cellpadding="3">
                                    Invoice No : {$invoiceDetail[1]|default:'-'} <br>
                                    Invoice Date : {$invoiceDetail[2]|default:'-'} <br>
                                    Invoice Value : {$invoiceDetail[0]|default:'-'}
                                </td>

                                <td colspan="2" class="bordered" align="center">
                                    <div class="h-seperator" style="padding-bottom: 3px;">At Owner's Risk</div>
                            <span>Undertaking charges payable by party</span>
                            <div class="bold" style="font-size: 12px;"> VALUE OF GOODS</div>
                        </td>
                    </tr>
                </table>

                <table cellpadding="3">
                    <tr>
                        <td width="40%"><span class="bold">E-Way Bill : </span> {$addons_mapped['EWBL'][0]->referenceCode|default:'-'}</td>
                        <td align="center" class="font-14 bold"> {$payment_type_name|upper} </td>
                    </tr>
                </table>
            </td>
            <td width="30%"> <br><br>
                <table cellpadding="2" class="bordered">
                    <tr class="bold " align="center">
                        <td>Particulars</td>
                        <td>Amount</td>
                    </tr>
                    <tr>
                        <td align="left">Freight</td>
                        <td align="right">{$summary->totalAmount|number_format:2}</td>
                    </tr>
                    <tr>
                        <td align="left">L Charges</td>
                        <td align="right">{$summary->totalHandlingAmount|number_format:2}</td>
                    </tr>
                    {if $summary->pickupHandlingAmount>0}
                    <tr>
                        <td align="left">Pickup Charges</td>
                        <td align="right">{$summary->pickupHandlingAmount|number_format:2}</td>
                    </tr>
                    {/if}
                    {if $summary->deliveryHandlingAmount>0}
                    <tr>
                        <td align="left">Delivery Charges</td>
                        <td align="right">{$summary->deliveryHandlingAmount|number_format:2}</td>
                    </tr>
                    {/if}
                    {if $summary->hamaliCharge > 0}
                    <tr>
                        <td align="left">Hamali Charges</td>
                        <td align="right">{$summary->hamaliCharge|number_format:2}</td>
                    </tr>
                    {/if}

                    {if $summary->passCharge > 0}
                    <tr>
                        <td align="left">Pass Charges</td>
                        <td align="right">{$summary->passCharge|number_format:2}</td>
                    </tr>
                    {/if}

                    {if $summary->docketCharge > 0}
                    <tr>
                        <td align="left">Docket Charges</td>
                        <td align="right">{$summary->docketCharge|number_format:2}</td>
                    </tr>
                    {/if}
                    {if isset($addons_mapped['PODCH'])}
                    <tr>
                        <td align="left">POD Charges</td>
                        <td align="right">{$addons_mapped['PODCH']->value|number_format:2}</td>
                    </tr>
                    {/if}

                    {if $summary->totalUnloadHandlingAmount > 0}
                    <tr>
                        <td align="left">Unloading Charges</td>
                        <td align="right">{$summary->totalUnloadHandlingAmount|number_format:2}</td>
                    </tr>
                    {/if}
                    {if $summary->serviceCharge>0}
                    <tr>
                        <td align="left">Service Charges</td>
                        <td align="right">{$summary->serviceCharge|number_format:2}</td>
                    </tr>
                    {/if}

                    {if $tax_computed->cgstValue != 0}
                    <tr>
                        <td align="left">CGST</td>
                        <td align="right">{$tax_computed->cgstValue|number_format:2}</td>
                    </tr>
                    {/if}
                    {if $tax_computed->sgstValue != 0}
                    <tr>
                        <td align="left">SGST</td>
                        <td align="right">{$tax_computed->sgstValue|number_format:2}</td>
                    </tr>
                    {/if}
                    {if $tax_computed->ugstValue != 0}
                    <tr>
                        <td align="left">UGST</td>
                        <td align="right">{$tax_computed->ugstValue|number_format:2}</td>
                    </tr>
                    {/if}
                    {if $tax_computed->igstValue != 0}
                    <tr>
                        <td align="left">IGST</td>
                        <td align="right">{$tax_computed->igstValue|number_format:2}</td>
                    </tr>
                    {/if}
                    <tr class="bold " class="font-10">
                        <td align="left" class="bold">Net Amount</td>
                        <td align="right" class="bold">{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</td>
                    </tr>

                    <tr class="bold " class="font-10">
                        <td align="left" class="bold">Amount Paid</td>
                        <td align="right" class="bold">{$summary->paymentAmount|number_format:2}</td>
                    </tr>
                    {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)-$summary->paymentAmount}
                            {if $balance_to_pay>0}
                                <tr class="font-10 bold">
                                    <td align="left" class="bold">TOTAL</td>
                                    <td align="right" class="bold">{$balance_to_pay|number_format:2}</td>
                                </tr>
                            {/if}

                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table cellpadding="3" class="bordered">
                            <tr>
                                <td>
                                    <span class="bold"> Delivery Address : </span><br>
                                    {$summary->toOrganization->address1}, {$summary->toOrganization->address2}, {$summary->toOrganization->contact}
                                </td>
                                <td align="center">
                                    For {$namespace_name|upper} <br><br>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>

        {if $terms_list|count > 0}
            <table width="100%" cellpadding="1">
                <tr class="success">
                    <td class="bold">Terms & Conditions</td>
                </tr>
                <tbody class="body_table">
                    {foreach from=$terms_list item=term}
                        <tr>
                            <td class="font-7" align="left">{$term->name}</td>
                        </tr>
                    {/foreach}
                    <tr>
                        <td class="font-7" align="right">
                            Powered By www.ezeecargo.com
                        </td>
                    <tr>
                </tbody>
            </table>

        {/if}

        {if $iter < 3}
            <div class="h-seperator"></div>
            <div></div>
        {/if}
    
     {/for}
     {/strip}