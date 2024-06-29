<style>
    .h-seperator { border-bottom: 1px dashed #666; height: 0px; }
    .bordered { border: 0.1px solid #000; }
    .bordered td { border: 0.1px solid #000; }
    .valign-bottom{ vertical-align: bottom;}
    .font-6 { font-size: 6px; }
    .font-7 { font-size: 7px; }
    .font-8 { font-size: 8px; }
    .font-9 { font-size: 9px; }
    .font-10 { font-size: 10px; }
    .font-11 { font-size: 11px; }
    .font-12 { font-size: 12px; }
    .bold { font-weight: bold; }
    .box{ border: 0.1px solid #000; padding: 2px;}
</style>
{strip}    
    {for $iter=1 to $no_of_copy}
        <table width="100%" class="border-collapse">
            <tbody>
                <tr>
                    <td colspan="2" >
                        <table width="100%" class="border-collapse">
                        <tr>
                            <td width="10%" align="right">
                            <img src="{$web_cdn_url}/cargo/print/{$namespace}/print_header.jpg">
                            </td>
                            <td width="90%" align="center">
                            <span class="font-12 bold">THIRUPPATHI VENKATACHALAPATHI LORRY SERVICE CHENNAI PVT LTD</span> <br>
                            {$summary->fromOrganization->address1|capitalize},  {$summary->fromOrganization->address2|capitalize} <br>
                            {$summary->fromOrganization->contact} &nbsp; | &nbsp; {$nsprofile->namespaceProfile->domainURL} {if isNotNull($summary->tax->gstin)} &nbsp; | &nbsp; <span class="bold">E-Way Bill ID : {$summary->tax->gstin}</span> {/if} <br>
                            OWNER'S RISK / G.C. NOTE / SUBJECT TO CHENNAI JURISDICTION  
                            </td>
                        </tr>
                        </table>                                       
                    </td>
                </tr>                
                <tr>
                    <td colspan="2"> <br><br>
                        <table cellpadding="3">
                            <tr>
                                <td>
                                    <span class="bold">Booked Branch &nbsp; : &nbsp;</span> {$summary->fromOrganization->name}
                                </td>
                                <td>
                                    <span class="bold">Delivery Branch &nbsp; : &nbsp;</span> {$summary->toOrganization->name}
                                </td>
                                <td>
                                    <span class="bold font-10">G.C / LR No :  {$summary->code}</span>                      
                                </td>       
                            </tr>
                            <tr>
                                <td>
                                    <span class="bold">Consignor: </span> {$summary->fromCustomer->name}<br>                           
                                    {if isNotNull($summary->fromCustomerAddress->code)}
                                        {$summary->fromCustomerAddress->station->name}, 
                                    {/if}
                                    {$summary->fromCustomer->mobileNumber}
                                </td>                              
                                
                                <td>
                                    <span class="bold">Consignee: </span> {$summary->toCustomer->name}<br>                              
                                    {if isNotNull($summary->toCustomerAddress->code)}
                                        {$summary->toCustomerAddress->station->name}, 
                                    {/if}
                                    {$summary->toCustomer->mobileNumber}
                                </td>    
                                <td>                                    
                                    <span class="bold">Date : </span> {$summary->bookedAt|date_format:'d-m-Y'}
                                    {if $addons_mapped['EWBL'][0]->referenceCode}
                                        <br>
                                        <span class="bold">E-Way Bill : </span>  {$addons_mapped['EWBL'][0]->referenceCode|default:'-'}  
                                    {/if}                                                   
                                
                                </td>                            
                            </tr>                            
                            
                        </table>
                    </td>
                </tr>
                
                <tr>
                    <td width="70%">
                        {assign var=subtotal value=0}
                        {assign var=totalitems value=0}
                        {assign var=totalweight value=0}
                        {assign var=weightunit value=''}
                        {foreach from=$summary->itemDetails item=article name=carArt}
                            {assign var=totalitems value=$totalitems+$article->itemCount}
                            {assign var=totalweight value=$totalweight+$article->unitValue}
                            {assign var=weightunit value=$article_unit[$article->unit->code]}
                        {/foreach}
                        
                        <table class="bordered" cellpadding="3">
                            <tr>
                                <td align="center" class="bold">No.of Articles</td>
                                <td align="center" class="bold">Description Of Goods</td>
                                <td align="center" class="bold">Weight</td>
                                <td align="center" class="bold">Rate</td>
                            </tr>                                        
                            {foreach from=$summary->itemDetails item=article name=carArt}
                                <tr align="center">
                                    <td align="center">{$article->itemCount}</td>
                                    <td align="center">{$article->cargoItem->name}</td>
                                    <td align="center">-</td>  
                                    <td align="center">{$article->fare}</td>                                                  
                                </tr>
                                {assign var=subtotal value=$subtotal + $article->computed->freight}
                            {/foreach}                                          
                            <tr>
                                <td align="center">{$totalitems}</td>
                                <td align="center" colspan="3"><span class="font-12 bold" >{$payment_type_name|upper} </span> </td>
                                
                            </tr> 
                        </table>                               

                        <table class="bordered"  cellpadding="3"> 
                            <tr> 
                                <td>
                                    <span class="bold"> Delivery Address : </span><br>
                                    {$summary->toOrganization->address1},  {$summary->toOrganization->address2}, {$summary->toOrganization->contact}
                                </td>
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
                <tr>
                    <td colspan="2">  
                        <table cellpadding="3" class="bordered">
                            <tr>
                                <td class="font-8">                                    
                                The company shall not be liable for any loss due to leakage, evoporation and fire for the booked consignment, the consignment booked on part's name can also be delivered direct to the consignee insurance at party's risk.
                                </td>
                                <td align="center">
                                    For THIRUPPATHI VENKATACHALAPATHI LORRY SERVICE CHENNAI PVT LTD <br><br>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="font-8">
                    I / We declare that the goods tendered by me / us do not contain any contraband foods and the desciption of the goods tendered by me / us have been correctly entered. I / We have read the conditions on the reverse of this G.C note and agree the conditions.
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                      <table cellpadding="3">
                        <tr>
                            <td>
                            N.B : Unloading charge to be paid by party
                            </td>
                            <td>
                            ( Goods must be insured by party )
                            </td>
                            <td>
                            Singature of Consignor <br><br>
                            </td>
                        </tr>
                      </table>           
                    </td>
                </tr>
                
                <tr>
                <td colspan="2">
                    <table>
                        <tr>
                            <td>
                                <table cellpadding="3">
                                    <tr>    
                                        <td>GST payable by </td>
                                        <td class="bordered" align="center"> Consignor </td>
                                        <td class="bordered" align="center">Consignee </td>
                                        <td class="bordered" align="center">Transport Agency</td>
                                    </tr>
                                </table>                            
                            </td>
                            <td class="font-6" align="right">
                                <br>
                                Powered By www.ezeecargo.com
                            </td>
                        </tr>
                    </table>
                </tr>
                
            </tbody>
        </table>        
    {/for}
{/strip}