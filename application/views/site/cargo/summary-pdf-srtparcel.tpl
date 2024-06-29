<style>                        
    .bordered td{ border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px  }
    .bordered .noborder{ border:1px solid #fff; }
    .bold{ font-weight:bold; }
    .f12{ font-size: 10px;}
    .bordered-new td{ border-top-width:0.1px; } 
</style>

<table width="100%">
    <tr>
        <td width="30%">
            {if $namespace == "psstransport"}
                &nbsp;<img src="assets/img/pss-logo.png" alt="logo" height="60">                
            {elseif $namespace == "pkrsps"}
                &nbsp;<img src="assets/img/pkr-logo.png" alt="logo" height="80">
            {elseif $namespace == "tnparcel"}
                &nbsp;<img src="assets/img/tnparcel-logo.png" alt="logo" height="60">
            {elseif $namespace == "nsrirom"}
                &nbsp;<img src="assets/img/nsrirom-logo.png" alt="logo" height="60">
            {elseif $namespace == "atobparcel"}
                &nbsp;<img src="assets/img/atobparcel-logo.png" alt="logo" height="60">
            {elseif $namespace == "smroadlines"}
                &nbsp;<img src="assets/img/smroadlines-logo.png" alt="logo" width="160">
            {/if}
        </td>
        <td width="45%">
            <table width="100%" cellpadding="3">
                <tr>
                    <td align="center">                        
                        <span style="font-weight:bold; font-size: 13px;">{$namespace_name}</span>                        
                    </td>
                </tr>
                <tr>
                    <td align="center" class="bold">Parcel Booking Receipt</td>
                </tr>
                <tr>
                    <td align="center">
                      
                        {if $namespace == "nationalchn"}
                            {$nsprofile->namespaceProfile->address},&nbsp;{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}, Mobile : {$nsprofile->namespaceProfile->supportNumber}
                            {if isNotNull($summary->tax->gstin)}
                                <br>
                                <b>GSTIN :</b> {$summary->tax->gstin}
                            {/if}
                        {elseif $namespace == "rktparcel"}
                            {if $summary->fromStation->code == 'STF3OEX206'}
                                323/1, Hosur Main Road, Madiwala, Bengaluru, Karnataka - 560068
                                <br>
                                <span class="bold f12">GSTIN : 29AAZFR4180P1ZY </span>
                            {else}
                                6, RKT Speed Parcel Service, Palaniappa Complex, Karur Bye Pass Road, Trichy - 620002
                                <br>
                                <span class="bold f12">GSTIN : 33AAZFR4180P1Z9 </span>
                            {/if}                        
                        {elseif $namespace == "luckycargoes"}
                            {$nsprofile->namespaceProfile->address},&nbsp;{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                            <b>GSTIN :</b> 37AAECL1582H1ZF
                        {elseif $namespace == "viplogistics"}
                            {$nsprofile->namespaceProfile->address},&nbsp;{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}
                        {elseif $namespace == "ashokalogistics"}
                            {if $nsprofile->namespaceProfile->address != '' && $nsprofile->namespaceProfile->address != 'NA'}
                                {$nsprofile->namespaceProfile->address},&nbsp;{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                            {/if}
                            <b>GSTIN :</b> 29DKVPS6194F1Z3
                        {elseif $namespace == "pkrsps"}
                            {if isNotNull($nsprofile->namespaceProfile->address)}
                                {$nsprofile->namespaceProfile->address},<br>{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                            {/if}
                        {elseif $namespace == "tippusultan"}
                            {if isNotNull($summary->tax->gstin) && (isNotNull($summary->fromCustomerGST) || isNotNull($summary->toCustomerGST))}
                                <b>GSTIN :</b> {$summary->tax->gstin}
                            {/if}
                        {else}
                            {if isNotNull($nsprofile->namespaceProfile->address)}
                                {$nsprofile->namespaceProfile->address},<br>{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                            {/if}
                            {if isNotNull($summary->tax->gstin)}
                                <b>GSTIN :</b> {$summary->tax->gstin}
                            {elseif $namespace == "ksreeni"}
                                <b>GSTIN :</b> 33GQDPS0463J1ZO
                            {/if}
                        {/if}
                    </td>
                </tr>
            </table>
        </td>
        <td width="25%"></td>
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
                        {$article->cargoItem->name|truncate:25} 
                        {if $namespace == "rktparcel"}<br>HSN Code : 996511{/if}
                        </td>
                        {if $action_rights['CARGO-UNITS']==1}
                        <td align="center">
                            {$article->unitValue}
                            {$article_unit[$article->unit->code]}
                        </td>
                        {/if}
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
{*        {$summary->paymentType->name}*}

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

            {if isset($summary->tax->code)}
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
            {elseif $summary->serviceTax > 0}
                <tr>
                    <td align="left" class="bold" style="border-right: 0.1px solid #000;">GST</td>
                    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->serviceTax|number_format:2}</td>
                </tr>
            {/if}

            <tr {if $summary->paymentType->code == 'PAD'}class="bold" style="font-size: 9px;"{/if}>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Net Amount</td>
                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value)|number_format:2}</td>       	
            </tr>
            
            <tr {if $summary->paymentType->code == 'PAD'}class="bold" style="font-size: 9px;"{/if}>
                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Amount Paid</td>
                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->paymentAmount|number_format:2}</td>
            </tr>
            {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value)-$summary->paymentAmount}
            {if $balance_to_pay>0}
            <tr style="font-size: 9px;" class="bordered-new">
                <td align="left" width="50%" class="bold">Amount Balance</td>
                <td align="left" width="50%">&nbsp;&nbsp;<b>{$balance_to_pay|number_format:2}</b></td>
            </tr>
            {/if}
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

    <table width="100%" cellpadding="2" style="border: 1px solid #000;">
        <tr>
            <td class="bold" width="25%" style="border-bottom: 1px solid #000;">Name - SRT PARCEL SERVICE</td>
            <td class="bold" align="center" width="40%" style="border-bottom: 1px solid #000;">Current Ac. No – 50200060532053</td>
            <td class="bold" width="25%" style="border-bottom: 1px solid #000;">IFSC - HDFC0001281</td>
        </tr>
        <tr>
            <td class="bold" width="25%">Bank - HDFC BANK</td>
            <td class="bold" align="center" width="40%">Branch - BRINDHAVAN ROAD , SALEM - 636016</td>
            <td class="bold" width="25%">GST No - 33AKUPV4688F1ZC</td>
        </tr>
    </table>

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

{if $namespace == "ybmlogistics" || $namespace == "sbrscargo" } 
 <table width="100%" cellpadding="1">
    <tr class="success" >
        <td align="center">
            {if $rcmby !="" }
                GST is payable by {$rcmby} (RCM)
            {else}
                GST is exempted
            {/if}
            </td>
    </tr>
</table> 
{/if}

<table width="100%" cellpadding="1">
    <tr class="success" >
        <td align="right" style="font-size:7px;">This is computer generated receipt no signature required</td>
    </tr>
</table>


{if $smarty.request.count==2}
    <div><hr /></div>     
    <br/><br/><br/>
    <table width="100%">
        
        <tr>
            <td width="30%">
                {if $namespace == "psstransport"}
                    &nbsp;<img src="assets/img/pss-logo.png" alt="logo" height="60">                
                {elseif $namespace == "pkrsps"}
                    &nbsp;<img src="assets/img/pkr-logo.png" alt="logo" height="80">
                {elseif $namespace == "tnparcel"}
                    &nbsp;<img src="assets/img/tnparcel-logo.png" alt="logo" height="60">
                {elseif $namespace == "nsrirom"}
                    &nbsp;<img src="assets/img/nsrirom-logo.png" alt="logo" height="60">
                {elseif $namespace == "atobparcel"}
                    &nbsp;<img src="assets/img/atobparcel-logo.png" alt="logo" height="60">
                {elseif $namespace == "smroadlines"}
                    &nbsp;<img src="assets/img/smroadlines-logo.png" alt="logo" width="160">
                {/if}
            </td>
            <td width="45%">
                <table width="100%" cellpadding="3">
                    <tr>
                        <td align="center">
                            <span style="font-weight:bold; font-size: 13px;">{$namespace_name}</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="bold">Parcel Booking Receipt</td>
                    </tr>
                    <tr>
                        <td align="center">                           
                            {if $namespace == "nationalchn"} 
                                {$nsprofile->namespaceProfile->address},&nbsp;{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}, Mobile : {$nsprofile->namespaceProfile->supportNumber}
                                {if isNotNull($summary->tax->gstin)}
                                    <br>
                                    <b>GSTIN :</b> {$summary->tax->gstin}
                                {/if}
                            {elseif $namespace == "rktparcel"}
                                {if $summary->fromStation->code == 'STF3OEX206'} 
                                    323/1, Hosur Main Road, Madiwala, Bengaluru, Karnataka - 560068
                                    <br>
                                    <span class="bold f12">GSTIN : 29AAZFR4180P1ZY </span>
                                {else}    
                                    6, RKT Speed Parcel Service, Palaniappa Complex, Karur Bye Pass Road, Trichy - 620002
                                    <br>
                                    <span class="bold f12">GSTIN : 33AAZFR4180P1Z9 </span>
                                {/if}
                            {elseif $namespace == "viplogistics"}
                                {$nsprofile->namespaceProfile->address},&nbsp;{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}
                            {elseif $namespace == "ashokalogistics"}
                                {if $nsprofile->namespaceProfile->address != '' && $nsprofile->namespaceProfile->address != 'NA'}
                                    {$nsprofile->namespaceProfile->address},&nbsp;{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                                {/if}
                                <b>GSTIN :</b> 29DKVPS6194F1Z3
                            {elseif $namespace == "pkrsps"}
                                {if isNotNull($nsprofile->namespaceProfile->address)}
                                    {$nsprofile->namespaceProfile->address},<br>{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                                {/if}
                                {if isNotNull($summary->tax->gstin)}
                                    <b>GSTIN :</b> {$summary->tax->gstin}
                                {/if}
                            {elseif $namespace == "tippusultan"}
                                {if isNotNull($summary->tax->gstin) && (isNotNull($summary->fromCustomerGST) || isNotNull($summary->toCustomerGST))}
                                    <b>GSTIN :</b> {$summary->tax->gstin}
                                {/if}
                            {else}
                                {if isNotNull($nsprofile->namespaceProfile->address)}
                                    {$nsprofile->namespaceProfile->address},<br>{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                                {/if}
                                {if isNotNull($summary->tax->gstin)}
                                    <b>GSTIN :</b> {$summary->tax->gstin}
                                {elseif $namespace == "ksreeni"}
                                    <b>GSTIN :</b> 33GQDPS0463J1ZO
                                {/if}
                            {/if}
                        </td>
                    </tr>
                </table>
            </td>
            <td width="25%"></td>
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
                            {$article->cargoItem->name|truncate:25}
                            {if $namespace == "rktparcel"}<br>HSN Code : 996511{/if}
                            </td>                                 
                            {if $action_rights['CARGO-UNITS']==1}
                            <td align="center">
                                {$article->unitValue}
                                {$article_unit[$article->unit->code]}
                            </td>
                            {/if}
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
                {if isset($addons_mapped['DMRCH'])}
                <tr>
                    <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Demurrage Charge</td>
                    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;{$addons_mapped['DMRCH']->value|number_format:2}</td>
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

                {if isset($summary->tax->code)}
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
                {elseif $summary->serviceTax > 0}
                    <tr>
                        <td align="left" class="bold" style="border-right: 0.1px solid #000;">GST</td>
                        <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->serviceTax|number_format:2}</td>
                    </tr>
                {/if}

                <tr {if $summary->paymentType->code == 'PAD'}class="bold" style="font-size: 9px;"{/if}>
                    <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Net Amount</td>
                    <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value)|number_format:2}</td>       	
                </tr>

                <tr {if $summary->paymentType->code == 'PAD'}class="bold" style="font-size: 9px;"{/if}>
                    <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Amount Paid</td>
                    <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->paymentAmount|number_format:2}</td>
                </tr>
                {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value)-$summary->paymentAmount}
                {if $balance_to_pay>0}
                <tr style="font-size: 9px;" class="bordered-new">
                    <td align="left" width="50%" class="bold">Amount Balance</td>
                    <td align="left" width="50%">&nbsp;&nbsp;<b>{$balance_to_pay|number_format:2}</b></td>
                </tr>
                {/if}
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
    
    <table width="100%" cellpadding="2" style="border: 1px solid #000;">
        <tr>
            <td class="bold" width="25%" style="border-bottom: 1px solid #000;">Name - SRT PARCEL SERVICE</td>
            <td class="bold" align="center" width="40%" style="border-bottom: 1px solid #000;">Current Ac. No – 50200060532053</td>
            <td class="bold" width="25%" style="border-bottom: 1px solid #000;">IFSC - HDFC0001281</td>
        </tr>
        <tr>
            <td class="bold" width="25%">Bank - HDFC BANK</td>
            <td class="bold" align="center" width="40%">Branch - BRINDHAVAN ROAD , SALEM - 636016</td>
            <td class="bold" width="25%">GST No - 33AKUPV4688F1ZC</td>
        </tr>
    </table>

    {assign var="rcmby" value=""}            
    {if $summary->paymentType->code== "TPPAD" || $summary->paymentType->code== "TOP"}
        {if $summary->toCustomerGST !=""}
            {assign var="rcmby" value="RECEIVER"} 
        {else if $summary->fromCustomerGST !="" && $summary->toCustomerGST ==""}
            {assign var="rcmby" value="SENDER"} 
        {/if}    
    {else if $summary->fromCustomerGST !="" }
        {assign var="rcmby" value="SENDER"}
    {else if $summary->fromCustomerGST =="" && $summary->toCustomerGST !=""}
        {assign var="rcmby" value="RECEIVER"} 
    {/if}

    {if $namespace == "ybmlogistics"} 
     <table width="100%" cellpadding="1">
        <tr class="success" >
            <td align="center">
                {if $rcmby !="" }
                    GST is payable by {$rcmby} (RCM)
                {else}
                    GST is exempted
                {/if}
            </td>
        </tr>
    </table> 
    {/if}

    <table width="100%" cellpadding="1">
        <tr class="success" >
            <td align="right" style="font-size:7px;">This is computer generated receipt no signature required</td>
        </tr>
    </table>

{/if}
