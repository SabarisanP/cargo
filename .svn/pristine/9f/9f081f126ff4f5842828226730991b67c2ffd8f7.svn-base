<style>                        
    .bordered td{ border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px  }
    .bordered .noborder{ border:1px solid #fff; }
    .bold{ font-weight:bold; }
    .f12{ font-size: 10px;} 
    .bordered-new td{ border-top-width:0.1px; } 
    .h-seperator { border-bottom: 1px dashed #666; height: 0px; }
</style>

{for $iter=1 to $no_of_copy}
<table width="100%">
    <tr>
        <td align="left" width="35%" rowspan="3" style="border-bottom: 0.1px solid #000;  ">
            <img src="assets/img/clientlogo/{$namespace}.jpg" height="50" alt="logo">
            <div class="f12 bold" style="padding-bottom:5px;">Illuminate Infinity Pvt Ltd, India.</div>
        </td>
        <td style=" border-bottom: 0.1px solid #000; border-right: 0.1px solid #000; font-size:14px;font-weight: bold; ">
            {$summary->fromOrganization->name}
        </td>
        <td style=" border-bottom: 0.1px solid #000; font-size:14px;font-weight: bold;">
            {$cargoCode}
        </td>
    </tr>
    <tr>
        <td style="border-bottom: 0.1px solid #000; font-size:14px;font-weight: bold;">
            {$summary->toOrganization->name}
        </td>
        <td style="border-bottom: 0.1px solid #000;">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td style="border-bottom: 0.1px solid #000; padding-top: 10px; " colspan="2">            
            We are in Hyderabad - Ananthapur - Bengaluru - Kadiri - Dharmavaram
        </td>        
    </tr>
</table>


<table width="100%">
<tr>
    <td width="65%">

        <table width="100%" cellpadding="3" class="table bordered ">
            <tbody class="body_table" >
            <tr >
                <td align="left" width="50%"  class="bold">CONSIGNOR</td>                
                <td align="left" width="50%"  class="bold">CONSIGNEE</td>                
            </tr>            
            <tr>
                <td align="left" width="50%"  class="">{$summary->fromCustomer->name}</td>                
                <td align="left" width="50%"  class="">{$summary->toCustomer->name}</td>       	
            </tr>
            {if isNotNull($summary->fromCustomerAddress->code) || isNotNull($summary->toCustomerAddress->code)}
                {strip}
                    <tr>
                        <td align="left" width="50%" title="Pickup Address">
                            {if isNotNull($summary->fromCustomerAddress->code)}
                                {$summary->fromCustomerAddress->address1},  {$summary->fromCustomerAddress->landmark}<br/>
                                {$summary->fromCustomerAddress->station->name} - {$summary->fromCustomerAddress->pincode}
                            {else}-{/if}
                        </td>
                        <td align="left" width="50%" title="Delivery Address">
                            {if isNotNull($summary->toCustomerAddress->code)}
                                {$summary->toCustomerAddress->address1},  {$summary->toCustomerAddress->landmark}<br/>
                                {$summary->toCustomerAddress->station->name} - {$summary->toCustomerAddress->pincode}
                            {else}-{/if}
                        </td>         	
                    </tr>
                {/strip}
            {/if}
            <tr>
              	<td align="left" width="50%"  class="">{$summary->fromCustomer->mobileNumber}</td>                
                <td align="left" width="50%"  class="">{$summary->toCustomer->mobileNumber}</td>         	
            </tr>            
            {if $summary->fromCustomerGST !="" || $summary->toCustomerGST !=""}
            <tr>
                <td align="left" width="50%"  class="">GSTIN : {$summary->fromCustomerGST}</td>                
                <td align="left" width="50%"  class="">GSTIN : {$summary->toCustomerGST}</td>         	
            </tr>
            {/if}
            </tbody>
        </table>
                         
        <table width="100%" cellpadding="3" class="table bordered ">
            <tr >
                <td align="center" class="bold" width="10%">S No</td>
                <td align="center" class="bold" width="30%">Article</td>                                 
                <td align="center" class="bold" width="15%">Quantity</td>
                <td align="center" class="bold" width="15%">Rate</td>
                <td align="center" class="bold" width="15%">Handling</td>
                <td align="center" class="bold" width="15%">Total</td>                
            </tr>
            <tbody class="body_table" >
                {assign var=subtotal value=0}
                {foreach from=$summary->itemDetails item=article name=carArt}
                    <tr>
                        <td align="center">{$smarty.foreach.carArt.index+1}</td>
                        <td align="left">{$article->cargoItem->name|truncate:25}</td>                        
                        <td align="center">{$article->itemCount}</td>
                        <td align="center">{$article->fare}</td>
                        <td align="center">{$article->handlingChargeAmount}</td>
                        <td align="center">
                            {$article->computed->freight|number_format:2}
                        </td>
                    </tr>
                    {assign var=subtotal value=$subtotal + $article->computed->freight}
                {/foreach}     	
            </tbody>
        </table>

        {* {if count($addons_mapped['EWBL'])}    
            <br><br>          
            <table width="100%" cellpadding="3" class="table bordered ">
                <tr class="success">
                    <td align="center" class="bold" width="30%">E-Way Bill</td>
                    <td align="center" class="bold" width="30%">Invoice Number</td>
                    <td align="center" class="bold" width="20%">Invoice Amt</td>                                 
                    <td align="center" class="bold" width="20%">Invoice Date</td>
                </tr>
                <tbody class="body_table" >
                    {foreach from=$addons_mapped['EWBL'] item=row}
                        <tr>
                            <td align="center">{$row->referenceCode}</td>
                            {assign var=invoiceDetail value="|"|explode:$row->value}
                            <td align="center">{$invoiceDetail[1]}</td>
                            <td align="center">{$invoiceDetail[0]}</td>
                            <td align="center">{$invoiceDetail[2]}</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        {/if} *}
        
        <table width="100%" cellpadding="3" class="table bordered ">
            <tbody class="body_table" >
            <tr >
                <td>
                    <span class="bold">Delivery Address : </span>
                    {$summary->toOrganization->address1},  {$summary->toOrganization->address2}, {$summary->toOrganization->contact}
                </td>              
            </tr>
        </table>                  
        <span class="bold"> Agent : </span> {$summary->bookedUser->name}, {$summary->bookedAt|date_format:$ns_datetime_format}
    </td>
    <td width="3%" valign="top"></td>
    <td width="32%" valign="top">
    	<table width="100%" cellpadding="3" class="table" style="border: 0.1px solid #000;">
            <tbody class="body_table" >
            <tr>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">No of Articles</td>
                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;
                    {assign var=qty value=0}
                    {foreach from=$summary->itemDetails item=item}
                        {assign var=qty value=$qty + $item->itemCount}
                    {/foreach}
                    {$summary->itemDetails|count} (Qty - {$qty})
                </td>
            </tr>
            <tr>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Freight</td>
                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->totalAmount|number_format:2}</td>       	
            </tr>
            <tr>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">L Charges</td>
                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->totalHandlingAmount|number_format:2}</td>       	
            </tr>
            {if $summary->pickupHandlingAmount>0}
            <tr>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Pickup Charges</td>
                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->pickupHandlingAmount|number_format:2}</td>       	
            </tr>
            {/if}
            {if $summary->deliveryHandlingAmount>0}
            <tr>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Delivery Charges</td>
                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->deliveryHandlingAmount|number_format:2}</td>       	
            </tr>
            {/if}
            {if $summary->hamaliCharge > 0}
            <tr>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Hamali Charges</td>
                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->hamaliCharge|number_format:2}</td>
            </tr>
            {/if}

            {if $summary->passCharge > 0}
            <tr>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Pass Charges</td>
                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->passCharge|number_format:2}</td>
            </tr>
            {/if}

            {if $summary->docketCharge > 0}
            <tr>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Docket Charges</td>
                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->docketCharge|number_format:2}</td>
            </tr>
            {/if}
            {if isset($addons_mapped['PODCH'])}
            <tr>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">POD Charges</td>
                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;{$addons_mapped['PODCH']->value|number_format:2}</td>
            </tr>
            {/if}

            {if $summary->totalUnloadHandlingAmount > 0}
            <tr>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Unloading Charges</td>
                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->totalUnloadHandlingAmount|number_format:2}</td>
            </tr>
            {/if}
            {if $summary->serviceCharge>0}
            <tr>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Service Charges</td>
                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->serviceCharge|number_format:2}</td>       	
            </tr>
            {/if}
            
            {if $tax_computed->cgstValue != 0}
            <tr>
                <td align="left" class="bold" style="border-right: 0.1px solid #000;">CGST</td>
                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;{$tax_computed->cgstValue|number_format:2}</td>
            </tr>
            {/if}
            {if $tax_computed->sgstValue != 0}
            <tr>
                <td align="left" class="bold" style="border-right: 0.1px solid #000;">SGST</td>
                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;{$tax_computed->sgstValue|number_format:2}</td>
            </tr>
            {/if}
            {if $tax_computed->ugstValue != 0}
            <tr>
                <td align="left" class="bold" style="border-right: 0.1px solid #000;">UGST</td>
                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;{$tax_computed->ugstValue|number_format:2}</td>
            </tr>
            {/if}
            {if $tax_computed->igstValue != 0}
            <tr>
                <td align="left" class="bold" style="border-right: 0.1px solid #000;">IGST</td>
                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;{$tax_computed->igstValue|number_format:2}</td>
            </tr>
            {/if}
            <tr {if $summary->paymentType->code == 'PAD'}class="bold" style="font-size: 9px;"{/if}>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Net Amount</td>
                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</td>       	
            </tr>
            
            <tr {if $summary->paymentType->code == 'PAD'}class="bold" style="font-size: 9px;"{/if}>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Amount Paid</td>
                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->paymentAmount|number_format:2}</td>
            </tr>
            {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)-$summary->paymentAmount}
            {if $balance_to_pay>0}
            <tr style="font-size: 9px;" class="bordered-new">
                <td align="left" width="50%" class="bold">Amount Balance</td>
                <td align="left" width="50%">&nbsp;&nbsp;<b>{$balance_to_pay|number_format:2}</b></td>
            </tr>
            {/if}

            <tr style="font-size:17px;font-weight: bold; " colspan="2" align="center">
                <td align="center" colspan="2" class="bold" style="padding-bottom: 20px; border-top: 0.1px solid #000;">{$payment_type_name|strtoupper}</td>
            </tr>  

            </tbody>
        </table>
     
    </td>
</tr>
</table>

<!--<br><br>           
<table width="100%" cellpadding="5" class="table bordered ">
<tr>
    <td align="left" width="20%" class="bold">Payment Type</td>
    <td align="left" width="30%">{$summary->paymentType->name}</td> 
    <td align="left" width="20%" class="bold">Cargo Status</td>
    <td align="left" width="30%">{$summary->cargoStatus->name}</td> 
</tr>
</table>-->

<br>
{if $terms_list|count > 0} 
    <table width="100%" cellpadding="1" style="font-size: 7px;">
        <tr class="success" >
            <td><b>Terms & Conditions</b></td>
        </tr>
        <tbody class="body_table" >
        {foreach from=$terms_list item=term name=carterm}
            <tr>
                <td align="left">{$term->name}</td>
            </tr>
        {/foreach}     	
        </tbody>
    </table>
{/if} 

{if $iter < $no_of_copy}            
    <div class="h-seperator"></div><br>
    {* <div></div> *}
{/if}

{/for}