<style>                        
    .bordered td{ border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px  }
    .bordered .noborder{ border:1px solid #fff; }
    .bold{ font-weight:bold; }
    .f12{ font-size: 10px;}
    .bordered-new td{ border-top-width:0.1px; } 
</style>

{for $iter=1 to $smarty.request.count}
    <table width="100%">
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/clientlogo/swaminathan-header.jpg" alt="Header" style="max-width: 100%;"><br>
            </td>
        </tr>
    </table>

    <table width="100%">
        <tr>
            <td width="65%">
                <table width="100%" cellpadding="1">
                    <tbody class="body_table" >
                        <tr>
                            <td align="left" width="60%" style="font-weight:bold; font-size:11px;">
                                {lang('lr')} No : {$cargoCode}
                            </td>                
                            <td align="right" width="40%"><br/>
                                Booked Date : {$summary->bookedAt|date_format:$ns_datetime_format}
                            </td>
                        </tr>
                        
                        {if $summary->additionalAttribute->driverMobile != '-' ||  $summary->additionalAttribute->driverName != '-'}
                            {if $summary->additionalAttribute->driverMobile != 'false' || $summary->additionalAttribute->driverName != 'false'}
                                {if $summary->additionalAttribute->driverMobile != '' || $summary->additionalAttribute->driverName != ''}
                                    <tr>              
                                        <td align="left" colspan="2" style="font-weight:normal; font-size:9px;">
                                            {if $summary->additionalAttribute->driverName != 'false' && $summary->additionalAttribute->driverName != ''}
                                                <b>Driver Name:&nbsp;</b>&nbsp;{$summary->additionalAttribute->driverName} &nbsp;
                                            {/if}
                                            {if $summary->additionalAttribute->driverMobile != 'false' && $summary->additionalAttribute->driverMobile != ''} 
                                                <b> Driver Mobile:&nbsp;</b>&nbsp;{$summary->additionalAttribute->driverMobile}
                                            {/if}
                                        </td>       	
                                    </tr>
                                {/if}
                            {/if}
                        {/if}
                    </tbody>
                </table>
                
                <br><br>
                <table width="100%" cellpadding="2" class="table bordered ">
                    <tbody class="body_table" >
                    <tr class="success" style="background-color:#64b92a;">
                        <td align="left" width="50%"  class="bold">Booking Address</td>                
                        <td align="left" width="50%"  class="bold">Delivery Address</td>                
                    </tr>
                    <tr>
                        <td align="left" width="50%" style="font-weight:bold;">
                            {$summary->fromOrganization->name}
                            {if $summary->fromOrganization->address1!=''}
                                <br>{$summary->fromOrganization->address1} {$summary->fromOrganization->address2}<br>
                            {/if}
                            <br>{$summary->fromOrganization->contact}
                        </td>                
                        <td align="left" width="50%" style="font-weight:bold;">
                            {$summary->toOrganization->name}
                            {if $summary->toOrganization->address1!=''}
                                <br>{$summary->toOrganization->address1} {$summary->toOrganization->address2} <br>
                            {/if}
                            <br>{$summary->toOrganization->contact}
                        </td>       	
                    </tr>
                    <tr>
                        <td align="left" width="50%"  class="">{$summary->fromCustomer->name}</td>                
                        <td align="left" width="50%"  class="">{$summary->toCustomer->name}</td>       	
                    </tr>
                    <tr>
                        <td align="left" width="50%"  class="">{$summary->fromCustomer->mobileNumber}</td>                
                        <td align="left" width="50%"  class="">{$summary->toCustomer->mobileNumber}</td>         	
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
                    {if $summary->fromCustomerGST !="" || $summary->toCustomerGST !=""}
                    <tr>
                        <td align="left" width="50%"  class="">GSTIN : {$summary->fromCustomerGST}</td>                
                        <td align="left" width="50%"  class="">GSTIN : {$summary->toCustomerGST}</td>         	
                    </tr>
                    {/if}
                    </tbody>
                </table>
                    
                <br><br>             
                <table width="100%" cellpadding="3" class="table bordered ">
                    <tr class="success" style="background-color:#64b92a;">
                        {if $action_rights['CARGO-UNITS']==1}
                        <td align="center" class="bold" width="10%">S No</td>
                        <td align="center" class="bold" width="30%">Article</td>                                 
                        <td align="center" class="bold" width="12%">UOM</td>
                        <td align="center" class="bold" width="12%">Quantity</td>
                        <td align="center" class="bold" width="12%">Rate</td>
                        <td align="center" class="bold" width="12%">Handling</td>
                        <td align="center" class="bold" width="12%">Total</td>
                        {else}
                        <td align="center" class="bold" width="10%">S No</td>
                        <td align="center" class="bold" width="30%">Article</td>                                 
                        <td align="center" class="bold" width="15%">Quantity</td>
                        <td align="center" class="bold" width="15%">Rate</td>
                        <td align="center" class="bold" width="15%">Handling</td>
                        <td align="center" class="bold" width="15%">Total</td>
                        {/if}
                    </tr>
                    <tbody class="body_table" >
                        {assign var=subtotal value=0}
                        {foreach from=$summary->itemDetails item=article name=carArt}
                            <tr>
                                <td align="center">{$smarty.foreach.carArt.index+1}</td>
                                <td align="left">
                                    {$article->cargoItem->name|truncate:25} {if isNotNull($article->cargoItem->description[0])} - {$article->cargoItem->description[0]}{/if}
                                </td>
                                {if $action_rights['CARGO-UNITS']==1}
                                <td align="center">
                                    {$article->unitValue}
                                    {$article_unit[$article->unit->code]}
                                </td>
                                {/if}
                                <td align="center">{$article->itemCount}</td>
                                <td align="center">
                                    {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                        {$article->fare}
                                    {else}
                                        0
                                    {/if}
                                </td>
                                <td align="center">
                                    {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                        {$article->handlingChargeAmount}
                                    {else}
                                        0
                                    {/if}
                                </td>
                                <td align="center">
                                    {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                        {$article->computed->freight|number_format:2}
                                    {else}
                                        0
                                    {/if}
                                </td>
                            </tr>
                            {assign var=subtotal value=$subtotal + $article->computed->freight}
                        {/foreach}     	
                    </tbody>
                </table>
                
                {if count($addons_mapped['EWBL'])}    
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
                {/if}
                
            </td>
            <td width="3%" valign="top"></td>
            <td width="32%" valign="top">
                <table align="left">
                    <tr style="font-size:20px;font-weight: bold;">
                        <td align="center" colspan="2" class="bold" style="padding-bottom: 20px;">{$payment_type_name|strtoupper}</td>
                    </tr>
                    <tr style="font-size:14px;font-weight: bold;">
                        <td align="center" colspan="2" class="bold" style="padding-bottom: 20px;">
                        {$summary->deliveryType->name|upper}
                        </td>
                    </tr>
                </table>

                <br/><br/>

                <table align="">
                <tr style="font-size:10px;font-weight: bold;">
                    <td align="left" width="35%" class="bold">Booked By :</td>
                    <td align="left" width="65%">{$summary->bookedUser->name}</td>
                </tr>
                </table>
                <br/><br/>

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
                        <td align="left" width="50%">&nbsp;&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                {$summary->totalAmount|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>       	
                    </tr>
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">L Charges</td>
                        <td align="left" width="50%">&nbsp;&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                {$summary->totalHandlingAmount|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>       	
                    </tr>
                    {if $summary->pickupHandlingAmount>0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Pickup Charges</td>
                        <td align="left" width="50%">&nbsp;&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                {$summary->pickupHandlingAmount|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>       	
                    </tr>
                    {/if}
                    {if $summary->deliveryHandlingAmount>0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Delivery Charges</td>
                        <td align="left" width="50%">&nbsp;&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                {$summary->deliveryHandlingAmount|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>       	
                    </tr>
                    {/if}
                    {if $summary->hamaliCharge > 0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Hamali Charges</td>
                        <td align="left">&nbsp;&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                {$summary->hamaliCharge|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>
                    </tr>
                    {/if}

                    {if $summary->passCharge > 0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Pass Charges</td>
                        <td align="left">&nbsp;&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                {$summary->passCharge|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>
                    </tr>
                    {/if}

                    {if $summary->docketCharge > 0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Docket Charges</td>
                        <td align="left">&nbsp;&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                {$summary->docketCharge|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>
                    </tr>
                    {/if}
                    {if isset($addons_mapped['PODCH'])}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">POD Charges</td>
                        <td align="left">&nbsp;&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                {$addons_mapped['PODCH']->value|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>
                    </tr>
                    {/if}

                    {if $summary->totalUnloadHandlingAmount > 0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Unloading Charges</td>
                        <td align="left" width="50%">&nbsp;&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                {$summary->totalUnloadHandlingAmount|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>
                    </tr>
                    {/if}
                    {if $summary->serviceCharge>0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Service Charges</td>
                        <td align="left" width="50%">&nbsp;&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                {$summary->serviceCharge|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>       	
                    </tr>
                    {/if}

                    {if isset($summary->tax->code)}
                        {if $tax_computed->cgstValue != 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">CGST</td>
                            <td align="left">&nbsp;&nbsp;&nbsp;
                                {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                    {$tax_computed->cgstValue|number_format:2}
                                {else}
                                    0.00
                                {/if}
                            </td>
                        </tr>
                        {/if}
                        {if $tax_computed->sgstValue != 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">SGST</td>
                            <td align="left">&nbsp;&nbsp;&nbsp;
                                {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                    {$tax_computed->sgstValue|number_format:2}
                                {else}
                                    0.00
                                {/if}
                            </td>
                        </tr>
                        {/if}
                        {if $tax_computed->ugstValue != 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">UGST</td>
                            <td align="left">&nbsp;&nbsp;&nbsp;
                                {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                    {$tax_computed->ugstValue|number_format:2}
                                {else}
                                    0.00
                                {/if}
                            </td>
                        </tr>
                        {/if}
                        {if $tax_computed->igstValue != 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">IGST</td>
                            <td align="left">&nbsp;&nbsp;&nbsp;
                                {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                    {$tax_computed->igstValue|number_format:2}
                                {else}
                                    0.00
                                {/if}
                            </td>
                        </tr>
                        {/if}
                    {elseif $summary->serviceTax > 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">GST</td>
                            <td align="left">&nbsp;&nbsp;&nbsp;
                                {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                    {$summary->serviceTax|number_format:2}
                                {else}
                                    0.00
                                {/if}
                            </td>
                        </tr>
                    {/if}

                    <tr {if $summary->paymentType->code == 'PAD'}class="bold" style="font-size: 9px;"{/if}>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Net Amount</td>
                        <td align="left" width="50%">&nbsp;&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                {($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value)|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>       	
                    </tr>
                    
                    <tr {if $summary->paymentType->code == 'PAD'}class="bold" style="font-size: 9px;"{/if}>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Amount Paid</td>
                        <td align="left" width="50%">&nbsp;&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                {$summary->paymentAmount|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>
                    </tr>
                    {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value)-$summary->paymentAmount}
                    {if $balance_to_pay>0}
                    <tr style="font-size: 9px;" class="bordered-new">
                        <td align="left" width="50%" class="bold">Amount Balance</td>
                        <td align="left" width="50%">&nbsp;&nbsp;
                            {if !in_array($summary->paymentType->code, ['TOP', 'INP'])}
                                <b>{$balance_to_pay|number_format:2}</b>
                            {else}
                                0.00
                            {/if}
                        </td>
                    </tr>
                    {/if}
                    </tbody>
                </table>
            </td>
        </tr>
    </table>

    <br>
    {if $summary->remarks|count}         
    <table cellpadding="1">
        <tbody class="body_table" >
            <tr class="success">
                <td width="1%"></td>
                <td><b>Remarks : </b>
                    {assign var="remarksarr" value=[]}
                    {foreach from=$summary->remarks item=row}
                        {$remarksarr[] = $row->name}
                    {/foreach}
                    {$remarksarr|implode:'<br/>'}
                </td>
            </tr>
        </tbody>
    </table>
    {/if}
    
    {if $terms_list|count > 0} 
        <table width="100%" cellpadding="0">
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
    {assign var="rcmby" value=""}            
    {if $summary->paymentType->code== "TPPAD" || $summary->paymentType->code== "TOP"}
        {if $summary->toCustomerGST !=""}
            {assign var="rcmby" value=lang('booking_receiver_term')} 
        {else if $summary->fromCustomerGST !="" && $summary->toCustomerGST ==""}
            {assign var="rcmby" value=lang('booking_sender_term')} 
        {/if}    
    {else if $summary->fromCustomerGST !="" }
        {assign var="rcmby" value=lang('booking_sender_term')}
    {else if $summary->fromCustomerGST =="" && $summary->toCustomerGST !=""}
        {assign var="rcmby" value=lang('booking_receiver_term')} 
    {/if}

    <table width="100%" cellpadding="1">
        <tr class="success" >
            {assign var=bookeddate value=" "|explode:$summary->bookedAt}
            {assign var=bookedtime value=$bookeddate[1]|timeToMinutes}
            {if isNotNull($summary->fromOrganization->transitCloseMinutes) && $bookedtime > $summary->fromOrganization->transitCloseMinutes}
                {$transitCloseMinutes = $summary->fromOrganization->transitCloseMinutes}
                {if $transitCloseMinutes < 720}{$transitCloseMinutes = $transitCloseMinutes + 720}{/if}
                <td align="left"><b>Next Day Booking :</b> {$transitCloseMinutes|addMinutesToDateTime:$summary->bookedAt:'d-m-Y'}</td>       	
            {/if}
            <td align="right" style="font-size:7px;">This is computer generated receipt no signature required</td>
        </tr>
    </table>

    {if $iter != 2}
        <div><hr /></div>
    {/if}
{/for}
