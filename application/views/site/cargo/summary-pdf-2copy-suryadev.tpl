<style>                        
    .bordered td{ border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px  }
    .b_top { border-top-width:0.1px;}
    .b_right { border-right-width:0.1px;}
    .b_bottom { border-bottom-width:0.1px  }
    .b_left { border-left-width:0.1px;}
    .bordered .noborder{ border:1px solid #fff; }
    .bold{ font-weight:bold; }
    .f12{ font-size: 10px;}
    .bordered-new td{ border-top-width:0.1px; } 
</style>

<table width="100%" class="table" cellpadding="2">
    <tr>
        <td width="15%" class="b_top b_right b_left b_bottom" align="center">
            &nbsp;<img src="assets/img/Suryadev-logo.png" alt="logo" width="70">
        </td>
        <td align="center" width="50%" class="b_top b_right" colspan="3" style="font-size: 10px;">                        
            <span style="font-weight:bold; font-size: 14px;">{$namespace_name}</span><br>
            <span class="bold" style="font-size: 9px;">GSTIN : {$summary->tax->gstin}</span><br>
            {$summary->fromOrganization->name}<br>
            {if $summary->fromOrganization->address1!=''}
                {$summary->fromOrganization->address1} {$summary->fromOrganization->address2}<br>
            {/if}
            {$summary->fromOrganization->contact}
        </td>
        <td width="15%" class="b_top b_right" align="center">
            <span class="bold" style="font-size: 10px;">{lang('lr')} No :<br>{$cargoCode}</span><br><br>
            Booked Date : {$summary->bookedAt|date_format:$ns_datetime_format}
        </td>
        <td class="b_top b_right" width="20%"></td>
    </tr>

    <tr>
        <td class="b_top b_right b_left b_bottom" colspan="2">
            <span class="bold">From: {$summary->fromOrganization->name}</span><br>
            Consignor: {$summary->fromCustomer->name}<br>
            {$summary->fromCustomer->mobileNumber}<br>
            GST : {$summary->fromCustomerGST}
        </td>
        <td class="b_top b_right b_bottom" colspan="2">
            <span class="bold">To: {$summary->toOrganization->name}</span><br>
            Consignee: {$summary->toCustomer->name}<br>
            {$summary->toCustomer->mobileNumber}<br>
            GST : {$summary->toCustomerGST}
        </td>
        <td class="b_top b_right b_bottom" align="center" colspan="2"><br>
            <span class="bold" style="font-size: 14px;">{$payment_type_name|strtoupper}<br>{$summary->deliveryType->name|upper}</span>
        </td>
    </tr>
</table>
<br><br>

<table width="100%" cellpadding="2">
    <tr>
        <td colspan="3" class="">
            <table width="100%" cellpadding="2" class="table bordered">
                <thead>
                    <tr>
                    {if $action_rights['CARGO-UNITS']==1}
                        <td align="center" class="bold" width="8%">S No</td>
                        <td align="center" class="bold" width="30%">Article</td>                                 
                        <td align="center" class="bold" width="12%">UOM</td>
                        <td align="center" class="bold" width="12%">Quantity</td>
                        <td align="center" class="bold" width="12%">Rate</td>
                        <td align="center" class="bold" width="13%">Handling</td>
                        <td align="center" class="bold" width="13%">Total</td>
                        {else}
                        <td align="center" class="bold" width="8%">S No</td>
                        <td align="center" class="bold" width="30%">Article</td>                                 
                        <td align="center" class="bold" width="15%">Quantity</td>
                        <td align="center" class="bold" width="15%">Rate</td>
                        <td align="center" class="bold" width="16%">Handling</td>
                        <td align="center" class="bold" width="16%">Total</td>
                        {/if}
                    </tr>
                </thead>
                <tbody class="body_table" >
                    {assign var=subtotal value=0}
                    {foreach from=$summary->itemDetails item=article name=carArt}
                        <tr>
                            <td align="center">{$smarty.foreach.carArt.index+1}</td>
                            <td align="left">
                            {$article->cargoItem->name|truncate:25} 
                            </td>
                            {if $action_rights['CARGO-UNITS']==1}
                            <td align="center">
                                {$article->unitValue}
                                {$article_unit[$article->unit->code]}
                            </td>
                            {/if}
                            <td align="center">{$article->itemCount}</td>
                            <td align="right">{$article->fare|number_format:2}</td>
                            <td align="center">{$article->handlingChargeAmount}</td>
                            <td align="right">
                                {$article->computed->freight|number_format:2}
                            </td>
                        </tr>
                        {assign var=subtotal value=$subtotal + $article->computed->freight}
                    {/foreach}     	
                </tbody>
            </table>
            {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
            {if $invoiceDetail[0] || $invoiceDetail[1] || $invoiceDetail[2]}    
            <br><br>
            <table width="100%" cellpadding="3" class="table bordered ">
                <tr class="success">
                    <td align="center" class="bold" width="33%">Invoice Number</td>
                    <td align="center" class="bold" width="23%">Invoice Amount</td>                                 
                    <td align="center" class="bold" width="17%">Invoice Date</td>                  
                    <td align="left" width="27%" class="bold">E-Way Bill</td>
                </tr>
                <tbody class="body_table" >
                    <tr>
                        <td align="center">{$invoiceDetail[1]}</td>
                        <td align="center">{$invoiceDetail[0]}</td>                                 
                        <td align="center">{$invoiceDetail[2]}</td>
                        <td align="left">{$addons_mapped['EWBL'][0]->referenceCode|default:'-'}</td>
                    </tr>
                </tbody>
            </table>
            {/if}
        </td>
        <td colspan="2" class="">
            <table width="100%" cellpadding="2" class="table" style="border: 0.1px solid #000;line-height: 8px;">
                <tbody class="body_table" >
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">No of Articles</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;
                            {assign var=qty value=0}
                            {foreach from=$summary->itemDetails item=item}
                                {assign var=qty value=$qty + $item->itemCount}
                            {/foreach}
                            {$summary->itemDetails|count} (Qty - {$qty})
                        </td>
                    </tr>
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Freight</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->totalAmount|number_format:2}</td>       	
                    </tr>
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">L Charges</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->totalHandlingAmount|number_format:2}</td>       	
                    </tr>
                    {if $summary->pickupHandlingAmount>0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Pickup Charges</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->pickupHandlingAmount|number_format:2}</td>       	
                    </tr>
                    {/if}
                    {if $summary->deliveryHandlingAmount>0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Delivery Charges</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->deliveryHandlingAmount|number_format:2}</td>       	
                    </tr>
                    {/if}
                    {if $summary->hamaliCharge > 0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Hamali Charges</td>
                        <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->hamaliCharge|number_format:2}</td>
                    </tr>
                    {/if}

                    {if $summary->passCharge > 0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Pass Charges</td>
                        <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->passCharge|number_format:2}</td>
                    </tr>
                    {/if}

                    {if $summary->docketCharge > 0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Docket Charges</td>
                        <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->docketCharge|number_format:2}</td>
                    </tr>
                    {/if}
                    {if isset($addons_mapped['PODCH'])}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">POD Charges</td>
                        <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$addons_mapped['PODCH']->value|number_format:2}</td>
                    </tr>
                    {/if}

                    {if $summary->totalUnloadHandlingAmount > 0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Unloading Charges</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->totalUnloadHandlingAmount|number_format:2}</td>
                    </tr>
                    {/if}
                    {if $summary->serviceCharge>0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Service Charges</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->serviceCharge|number_format:2}</td>       	
                    </tr>
                    {/if}

                    {if isset($summary->tax->code)}
                        {if $tax_computed->cgstValue != 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">CGST</td>
                            <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$tax_computed->cgstValue|number_format:2}</td>
                        </tr>
                        {/if}
                        {if $tax_computed->sgstValue != 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">SGST</td>
                            <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$tax_computed->sgstValue|number_format:2}</td>
                        </tr>
                        {/if}
                        {if $tax_computed->ugstValue != 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">UGST</td>
                            <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$tax_computed->ugstValue|number_format:2}</td>
                        </tr>
                        {/if}
                        {if $tax_computed->igstValue != 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">IGST</td>
                            <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$tax_computed->igstValue|number_format:2}</td>
                        </tr>
                        {/if}
                    {elseif $summary->serviceTax > 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">GST</td>
                            <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->serviceTax|number_format:2}</td>
                        </tr>
                    {/if}

                    <tr {if $summary->paymentType->code == 'PAD'}class="bold" style="font-size: 9px;"{/if}>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Net Amount</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value)|number_format:2}</td>       	
                    </tr>
                    
                    <tr {if $summary->paymentType->code == 'PAD'}class="bold" style="font-size: 9px;"{/if}>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Amount Paid</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->paymentAmount|number_format:2}</td>
                    </tr>
                    {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value)-$summary->paymentAmount}
                    {if $balance_to_pay>0}
                    <tr style="font-size: 9px;" class="bordered-new">
                        <td align="left" width="50%" class="bold">Amount Balance</td>
                        <td align="right" width="50%">&nbsp;&nbsp;<b>{$balance_to_pay|number_format:2}</b></td>
                    </tr>
                    {/if}
                </tbody>
            </table>
        </td>
    </tr>
</table>
<br><br>

<table width="100%" cellpadding="2" class="table bordered">
    <tr>
        <td colspan="3" style="font-size: 10px;" align="center">
            <span class="bold" style="font-size: 11px;">Delivery Office</span><br>
            {$summary->toOrganization->name}<br>
            {if $summary->toOrganization->address1!=''}
                {$summary->toOrganization->address1} {$summary->toOrganization->address2},
            {/if}
            {$summary->toOrganization->contact}
        </td>
        <td align="center">
            <br><br><br><br>Signature
        </td>
    </tr>
</table>

{strip}
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
{/strip}
{if $terms_list|count > 0} 
    {strip}
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
    {/strip}
{/if} 

<table width="100%" cellpadding="1">
    <tr class="success" >
        <td align="right" style="font-size:7px;">This is computer generated receipt no signature required</td>
    </tr>
</table>


{if $smarty.request.count==2}
    <div><hr /></div>     
    <br/><br/><br/>

    <table width="100%" class="table" cellpadding="2">
    <tr>
        <td width="15%" class="b_top b_right b_left b_bottom" align="center">
            &nbsp;<img src="assets/img/Suryadev-logo.png" alt="logo" width="70">
        </td>
        <td align="center" width="50%" class="b_top b_right" colspan="3" style="font-size: 10px;">                        
            <span style="font-weight:bold; font-size: 14px;">{$namespace_name}</span><br>
            <span class="bold" style="font-size: 9px;">GSTIN : {$summary->tax->gstin}</span><br>
            {$summary->fromOrganization->name}<br>
            {if $summary->fromOrganization->address1!=''}
                {$summary->fromOrganization->address1} {$summary->fromOrganization->address2}<br>
            {/if}
            {$summary->fromOrganization->contact}                      
        </td>
        <td width="15%" class="b_top b_right" align="center">
            <span class="bold" style="font-size: 10px;">{lang('lr')} No :<br>{$cargoCode}</span><br><br>
            Booked Date : {$summary->bookedAt|date_format:$ns_datetime_format}
        </td>
        <td class="b_top b_right" width="20%"></td>
    </tr>

    <tr>
        <td class="b_top b_right b_left b_bottom" colspan="2">
            <span class="bold">From: {$summary->fromOrganization->name}</span><br>
            Consignor: {$summary->fromCustomer->name}<br>
            {$summary->fromCustomer->mobileNumber}<br>
            GST : {$summary->fromCustomerGST}
        </td>
        <td class="b_top b_right b_bottom" colspan="2">
            <span class="bold">To: {$summary->toOrganization->name}</span><br>
            Consignee: {$summary->toCustomer->name}<br>
            {$summary->toCustomer->mobileNumber}<br>
            GST : {$summary->toCustomerGST}
        </td>
        <td class="b_top b_right b_bottom" align="center" colspan="2"><br>
            <span class="bold" style="font-size: 14px;">{$payment_type_name|strtoupper}<br>{$summary->deliveryType->name|upper}</span>
        </td>
    </tr>
</table>
<br><br>

<table width="100%" cellpadding="2">
    <tr>
        <td colspan="3" class="">
            <table width="100%" cellpadding="2" class="table bordered">
                <thead>
                    <tr>
                    {if $action_rights['CARGO-UNITS']==1}
                        <td align="center" class="bold" width="8%">S No</td>
                        <td align="center" class="bold" width="30%">Article</td>                                 
                        <td align="center" class="bold" width="12%">UOM</td>
                        <td align="center" class="bold" width="12%">Quantity</td>
                        <td align="center" class="bold" width="12%">Rate</td>
                        <td align="center" class="bold" width="13%">Handling</td>
                        <td align="center" class="bold" width="13%">Total</td>
                        {else}
                        <td align="center" class="bold" width="8%">S No</td>
                        <td align="center" class="bold" width="30%">Article</td>                                 
                        <td align="center" class="bold" width="15%">Quantity</td>
                        <td align="center" class="bold" width="15%">Rate</td>
                        <td align="center" class="bold" width="16%">Handling</td>
                        <td align="center" class="bold" width="16%">Total</td>
                        {/if}
                    </tr>
                </thead>
                <tbody class="body_table" >
                    {assign var=subtotal value=0}
                    {foreach from=$summary->itemDetails item=article name=carArt}
                        <tr>
                            <td align="center">{$smarty.foreach.carArt.index+1}</td>
                            <td align="left">
                            {$article->cargoItem->name|truncate:25}
                            </td>
                            {if $action_rights['CARGO-UNITS']==1}
                            <td align="center">
                                {$article->unitValue}
                                {$article_unit[$article->unit->code]}
                            </td>
                            {/if}
                            <td align="center">{$article->itemCount}</td>
                            <td align="right">{$article->fare|number_format:2}</td>
                            <td align="center">{$article->handlingChargeAmount}</td>
                            <td align="right">
                                {$article->computed->freight|number_format:2}
                            </td>
                        </tr>
                        {assign var=subtotal value=$subtotal + $article->computed->freight}
                    {/foreach}     	
                </tbody>
            </table>

            {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
            {if $invoiceDetail[0] || $invoiceDetail[1] || $invoiceDetail[2]}    
            <br><br>
            <table width="100%" cellpadding="3" class="table bordered ">
                <tr class="success">
                    <td align="center" class="bold" width="33%">Invoice Number</td>
                    <td align="center" class="bold" width="23%">Invoice Amount</td>                                 
                    <td align="center" class="bold" width="17%">Invoice Date</td>                  
                    <td align="left" width="27%" class="bold">E-Way Bill</td>
                </tr>
                <tbody class="body_table" >
                    <tr>
                        <td align="center">{$invoiceDetail[1]}</td>
                        <td align="center">{$invoiceDetail[0]}</td>                                 
                        <td align="center">{$invoiceDetail[2]}</td>
                        <td align="left">{$addons_mapped['EWBL'][0]->referenceCode|default:'-'}</td>
                    </tr>
                </tbody>
            </table>
            {/if}
        </td>
        <td colspan="2" class="">
            <table width="100%" cellpadding="2" class="table" style="border: 0.1px solid #000;line-height: 8px;">
                <tbody class="body_table" >
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">No of Articles</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;
                            {assign var=qty value=0}
                            {foreach from=$summary->itemDetails item=item}
                                {assign var=qty value=$qty + $item->itemCount}
                            {/foreach}
                            {$summary->itemDetails|count} (Qty - {$qty})
                        </td>
                    </tr>
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Freight</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->totalAmount|number_format:2}</td>       	
                    </tr>
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">L Charges</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->totalHandlingAmount|number_format:2}</td>       	
                    </tr>
                    {if $summary->pickupHandlingAmount>0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Pickup Charges</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->pickupHandlingAmount|number_format:2}</td>       	
                    </tr>
                    {/if}
                    {if $summary->deliveryHandlingAmount>0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Delivery Charges</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->deliveryHandlingAmount|number_format:2}</td>       	
                    </tr>
                    {/if}
                    {if $summary->hamaliCharge > 0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Hamali Charges</td>
                        <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->hamaliCharge|number_format:2}</td>
                    </tr>
                    {/if}

                    {if $summary->passCharge > 0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Pass Charges</td>
                        <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->passCharge|number_format:2}</td>
                    </tr>
                    {/if}

                    {if $summary->docketCharge > 0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Docket Charges</td>
                        <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->docketCharge|number_format:2}</td>
                    </tr>
                    {/if}
                    {if isset($addons_mapped['PODCH'])}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">POD Charges</td>
                        <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$addons_mapped['PODCH']->value|number_format:2}</td>
                    </tr>
                    {/if}

                    {if $summary->totalUnloadHandlingAmount > 0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Unloading Charges</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->totalUnloadHandlingAmount|number_format:2}</td>
                    </tr>
                    {/if}
                    {if $summary->serviceCharge>0}
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Service Charges</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->serviceCharge|number_format:2}</td>       	
                    </tr>
                    {/if}

                    {if isset($summary->tax->code)}
                        {if $tax_computed->cgstValue != 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">CGST</td>
                            <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$tax_computed->cgstValue|number_format:2}</td>
                        </tr>
                        {/if}
                        {if $tax_computed->sgstValue != 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">SGST</td>
                            <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$tax_computed->sgstValue|number_format:2}</td>
                        </tr>
                        {/if}
                        {if $tax_computed->ugstValue != 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">UGST</td>
                            <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$tax_computed->ugstValue|number_format:2}</td>
                        </tr>
                        {/if}
                        {if $tax_computed->igstValue != 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">IGST</td>
                            <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$tax_computed->igstValue|number_format:2}</td>
                        </tr>
                        {/if}
                    {elseif $summary->serviceTax > 0}
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">GST</td>
                            <td align="right">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->serviceTax|number_format:2}</td>
                        </tr>
                    {/if}

                    <tr {if $summary->paymentType->code == 'PAD'}class="bold" style="font-size: 9px;"{/if}>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Net Amount</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value)|number_format:2}</td>       	
                    </tr>
                    
                    <tr {if $summary->paymentType->code == 'PAD'}class="bold" style="font-size: 9px;"{/if}>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Amount Paid</td>
                        <td align="right" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;{$summary->paymentAmount|number_format:2}</td>
                    </tr>
                    {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value)-$summary->paymentAmount}
                    {if $balance_to_pay>0}
                    <tr style="font-size: 9px;" class="bordered-new">
                        <td align="left" width="50%" class="bold">Amount Balance</td>
                        <td align="right" width="50%">&nbsp;&nbsp;<b>{$balance_to_pay|number_format:2}</b></td>
                    </tr>
                    {/if}
                </tbody>
            </table>
        </td>
    </tr>
</table>
<br><br>

<table width="100%" cellpadding="2" class="table bordered">
    <tr>
        <td colspan="3" style="font-size: 10px;" align="center">
            <span class="bold" style="font-size: 11px;">Delivery Office</span><br>
            {$summary->toOrganization->name}<br>
            {if $summary->toOrganization->address1!=''}
                {$summary->toOrganization->address1} {$summary->toOrganization->address2},
            {/if}
            {$summary->toOrganization->contact}
        </td>
        <td align="center">
            <br><br><br><br>Signature
        </td>
    </tr>
</table>

{strip}
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
{/strip}
{if $terms_list|count > 0} 
    {strip}
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
    {/strip}
{/if} 

<table width="100%" cellpadding="1">
    <tr class="success" >
        <td align="right" style="font-size:7px;">This is computer generated receipt no signature required</td>
    </tr>
</table>
{/if}
