<style>
    table {
        color: #040555;
    }

    .nowrap {
        white-space: nowrap;
    }

    .bordered {
        border: 0.1px solid #666;
    }

    .border-collapse {
        border: 0.1px solid #666;
        border-collapse: collapse;
    }

    .bordered td {
        border: 0.1px solid #666;
    }

    .font-6 {
        font-size: 6px;
    }

    .font-7 {
        font-size: 7px;
    }

    .font-8 {
        font-size: 8px;
    }

    .font-9 {
        font-size: 9px;
    }

    .font-10 {
        font-size: 10px;
    }

    .bold {
        font-weight: bold;
    }

    .bg-color {
        background-color: #d9d9d9;
    }

    .text-right {
        text-align: right;
    }

    .title1 {
        font-style: italic;
        font-size: 16px;        
        color: #ef4428;
        font-weight: bold;
    }

    .title2 {
        font-style: italic;
        font-size: 16px;        
        color: #01037d;
        font-weight: bold;        
    }

    .customer-care {
        color: white;
        background-color: #01037d;
    }

    .font-red {
        color: #ef4428;
    }

    tr.border-bottom td {
        border-bottom: 0.2px solid #666;
    }

    .border-right {
        border-right: 0.2px solid #666;
    }

    .border-left {
        border-left: 0.2px solid #666;
    }

    .dotted {
        border-bottom: 0.2px dotted #000000;
    }

    .h-seperator {
        border-bottom: 1px dashed #666;
        height: 0px;
    }
</style>

{strip}
    {for $iter=1 to $no_of_copy}
        <table width="100%" class="border-collapse">
            <tbody>
                <tr class="border-bottom">
                    <td width="75%" align="center">
                        <table cellpadding="1">
                            <tr class="border-bottom">
                                <td><img src="assets/img/jayalakshmicargo-header.jpg" alt="Header"></td>
                            </tr>
                        </table>
                    </td>
                    <td width="25%">
                        <table class="border-left" cellpadding="5">
                            <tr class="border-bottom">
                                <td align="center" class="font-10 font-red bold bg-color">CONSIGNEE COPY</td>
                            </tr>
                            <tr>
                                <td>LR No : <span class="bold" style="font-size: 12px;"> {$summary->code} </span></td>
                            </tr>
                            <tr>
                                <td>Date : {$summary->bookedAt|date_format:$ns_date_format}</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr class="border-bottom">
                    <td width="50%">
                        <table class="border-right">
                            <tr>
                                <td colspan="4" class="dotted">
                                    From : &nbsp;
                                    {$summary->fromOrganization->name}                                     
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">Consignor's Address</td>
                            </tr>
                            <tr>
                                <td colspan="4" class="dotted">
                                    {$summary->fromCustomer->name}
                                    {if isNotNull($summary->fromCustomerAddress->code)}
                                        , {$summary->fromCustomerAddress->address1}
                                    {/if}
                                    {if isNotNull($summary->fromCustomerAddress->code)}
                                        , {$summary->fromCustomerAddress->landmark}, {$summary->fromCustomerAddress->station->name} - {$summary->fromCustomerAddress->pincode}
                                    {/if}
                                </td>
                            </tr>
                            
                            <tr>
                                <td>Phone</td>
                                <td class="dotted">{($summary->fromCustomer->mobileNumber)? $summary->fromCustomer->mobileNumber: '' }</td>
                                <td>TIN No</td>
                                <td class="dotted"></td>
                            </tr>
                            <tr>
                                {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
                                <td>Invoice No</td>
                                <td class="dotted">{($invoiceDetail[1])? $invoiceDetail[1]: '' }</td>
                                <td>Date</td>
                                <td class="dotted">{($invoiceDetail[2])? $invoiceDetail[2]: '' }</td>
                            </tr>
                        </table>
                    </td>
                    <td width="50%">
                        <table cellpadding="2">
                            <tr>
                                <td colspan="4" class="dotted">
                                    To : &nbsp;
                                    {$summary->toOrganization->name}                                 
                                </td>
                            </tr>        
                            <tr>
                                <td colspan="4">Consignee's Address</td>
                            </tr>
                            <tr>
                                <td colspan="4" class="dotted">
                                    {$summary->toCustomer->name}
                                    {if isNotNull($summary->toCustomerAddress->code)}
                                        , {$summary->toCustomerAddress->address1}
                                    {/if}
                                    {if isNotNull($summary->toCustomerAddress->code)}
                                        , {$summary->toCustomerAddress->landmark}, {$summary->toCustomerAddress->station->name} - {$summary->toCustomerAddress->pincode}
                                    {/if}
                                </td>
                            </tr>
                            
                            <tr>
                                <td>Cell No</td>
                                <td class="dotted">{($summary->toCustomer->mobileNumber)? $summary->toCustomer->mobileNumber: '' }</td>
                                <td> &nbsp; </td>
                                <td class=""> &nbsp; </td>    
                            </tr>
                            <tr>
                                <td>TIN No</td>
                                <td class="">&nbsp;</td>
                                <td> &nbsp; </td>
                                <td class=""> &nbsp; </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <br />
                <tr>
                    <td width="70%">
                        <table class="bordered" cellpadding="3">
                            <tr class="bold" align="center">
                                <td>No.of Articles</td>
                                <td>Description</td>
                                <td>Actual Wt.kg</td>
                                <td>Charges Wt Kg</td>
                            </tr>
                            {assign var=subtotal value=0}
                            {foreach from=$summary->itemDetails item=article name=carArt}
                                <tr align="center">
                                    <td align="center">{$article->itemCount}</td>
                                    <td align="center">{$article->cargoItem->name}</td>
                                    <td align="center">{$article->actualUnitValue} {$article_unit[$article->unit->code]}</td>
                                    <td align="center">{$article->unitValue} {$article_unit[$article->unit->code]}</td>
                                </tr>
                                {assign var=subtotal value=$subtotal + $article->computed->freight}
                            {/foreach}
                        </table>
                        <br>
                        <br>
                        <table class="bordered">
                            <tr class="bold">
                                <td class="customer-care" align="center">Customer Care : 9578422239</td>
                                <td>Articles Value</td>
                            </tr>
                            <tr>
                                <td>Seal & Signature of Consignee
                                    <br>
                                    <br>
                                </td>
                                <td class="bold capitalize font-red" align="center" style="font-size: 15px;">{$summary->paymentType->name|upper}</td>
                            </tr>
                        </table>
                    </td>
                    <td width="30%">
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
                            <tr class="bold " class="font-9">
                                <td align="left">Net Amount</td>
                                <td align="right">{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</td>
                            </tr>

                            <tr class="bold " class="font-9">
                                <td align="left">Amount Paid</td>
                                <td align="right">{$summary->paymentAmount|number_format:2}</td>
                            </tr>
                            {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)-$summary->paymentAmount}
                            {if $balance_to_pay>0}
                                <tr class="font-9">
                                    <td align="left" class="bold">TOTAL</td>
                                    <td align="right" class="bold">{$balance_to_pay|number_format:2}</td>
                                </tr>
                            {/if}

                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        {if $iter < $no_of_copy }

            <div class="h-seperator"></div>
            <div></div>
        {/if}
    {/for}
{/strip}