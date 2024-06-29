<style>                        
    .bordered td { border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px; border-color: #666; }
</style>

{strip}
{for $iter=1 to $no_of_copy}
    <div><br/></div>
    <table width="100%" cellpadding="2">
        <tr>
            <td width="25%">
                &nbsp;<img src="assets/img/clientlogo/kmpparcel-logo.png" alt="logo" width="120">
            </td>
            <td width="50%" style="font-size: 9px; line-height:1.4;">
                <b>GST No : </b> 33AAUFK1187A1ZF &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <b style="font-size: 12px;">{lang('lr')} No: {$cargoCode}</b><br/>
                <b>SAC CODE : </b>996511<br/>
                <b>TAXABLE : </b>Tax Payable Under RCM <br/>
                <b>Booked Date :</b> {$summary->bookedAt|date_format:$ns_datetime_format}&nbsp;&nbsp;
                <b>Booked By :</b> {$summary->bookedUser->name|truncate:15}
            </td>
            <td width="25%">
                <tcpdf method="write1DBarcode" params="{$barcode}" />
            </td>
        </tr>
    </table>

    <table width="100%" cellpadding="2" class="bordered">
        <tr style="background-color: #64b92a;">
            <td align="center" style="font-size: 9px; width: 33%"><b>Booking Office</b></td>
            <td align="center" style="font-size: 9px; width: 33%"><b>Delivery Office</b></td>
            <td align="center" style="font-size: 9px; width: 17%"><b>{lang('booking_sender_term')}</b></td>
            <td align="center" style="font-size: 9px; width: 17%"><b>{lang('booking_receiver_term')}</b></td>
        </tr>
        <tr>   
            <td align="left" style="font-size: 9px;">
                <b style="font-size: 11px;">{$summary->fromOrganization->name}</b>
                {if $summary->fromOrganization->address1!=''}
                    <br>{$summary->fromOrganization->address1|truncate:60} {$summary->fromOrganization->address2}<br>
                {/if}
                {$summary->fromOrganization->contact}
            </td>
            <td align="left" style="font-size: 9px;"><b style="font-size: 11px;">{$summary->toOrganization->name}</b>
                {if $summary->toOrganization->address1!=''}
                    <br>{$summary->toOrganization->address1|truncate:60} {$summary->toOrganization->address2}<br>
                {/if}
                {$summary->toOrganization->contact}
            </td>
            <td align="left" style="font-size: 9px;">{$summary->fromCustomer->name}
                <br>{$summary->fromCustomer->mobileNumber}                
                {if $summary->fromCustomerGST !=""}
                    <br><b>GSTIN :</b> {$summary->fromCustomerGST}
                {/if}
            </td>
            <td align="left" style="font-size: 9px;">{$summary->toCustomer->name}
                <br>{$summary->toCustomer->mobileNumber}
                {if $summary->toCustomerGST !=""}
                    <br><b>GSTIN :</b> {$summary->toCustomerGST}
                {/if}
            </td>            
        </tr>
    </table>
    <br><br>
    <table width="100%" cellpadding="2" class="bordered">
        <tr style="background-color: #64b92a;">
            {if $action_rights['CARGO-UNITS']==1}
                {* {if $summary->pickupHandlingAmount == 0 && $summary->deliveryHandlingAmount != 0}
                    <td align="center" width="5%"><b>S No</b></td>
                    <td align="center" width="25%"><b>Article</b></td>     
                    <td align="center" width="9%"><b>UOM</b></td>
                    <td align="center" width="9%"><b>Quantity</b></td>
                    <td align="center" width="9%"><b>Rate</b></td>
                    <td align="center" width="9%"><b>Handling</b></td>
                    <td align="center" width="9%"><b>Delivery Charges</b></td>
                    <td align="center" width="9%"><b>Total</b></td>
                    <td align="center" width="16%" rowspan="{$summary->itemDetails|count + 2}" style="font-family: helvetica;border-color: #fff; background-color: #fff; font-size: 14px; border-left-color: #000; border-right-color: #fff;">
                        <b>{$payment_type_name|strtoupper}</b>
                    </td>
                {elseif $summary->pickupHandlingAmount != 0 && $summary->deliveryHandlingAmount == 0}
                    <td align="center" width="5%"><b>S No</b></td>
                    <td align="center" width="25%"><b>Article</b></td>     
                    <td align="center" width="9%"><b>UOM</b></td>
                    <td align="center" width="9%"><b>Quantity</b></td>
                    <td align="center" width="9%"><b>Rate</b></td>
                    <td align="center" width="9%"><b>Handling</b></td>
                    <td align="center" width="9%"><b>Pickup Charges</b></td>
                    <td align="center" width="9%"><b>Total</b></td>
                    <td align="center" width="16%" rowspan="{$summary->itemDetails|count + 2}" style="font-family: helvetica;border-color: #fff; background-color: #fff; font-size: 14px; border-left-color: #000; border-right-color: #fff;">
                        <b>{$payment_type_name|strtoupper}</b>
                    </td>
                {elseif $summary->pickupHandlingAmount == 0 && $summary->deliveryHandlingAmount == 0}
                    <td align="center" width="5%"><b>S No</b></td>
                    <td align="center" width="25%"><b>Article</b></td>     
                    <td align="center" width="11%"><b>UOM</b></td>
                    <td align="center" width="11%"><b>Quantity</b></td>
                    <td align="center" width="11%"><b>Rate</b></td>
                    <td align="center" width="11%"><b>Handling</b></td>
                    <td align="center" width="11%"><b>Total</b></td>
                    <td align="center" width="15%" rowspan="{$summary->itemDetails|count + 2}" style="font-family: helvetica;border-color: #fff; background-color: #fff; font-size: 14px; border-left-color: #000; border-right-color: #fff;">
                        <b>{$payment_type_name|strtoupper}</b>
                    </td>
                {else} *}
                    <td align="center" width="5%"><b>S No</b></td>
                    <td align="center" width="26%"><b>Article</b></td>     
                    <td align="center" width="10%"><b>UOM</b></td>
                    <td align="center" width="10%"><b>Quantity</b></td>
                    <td align="center" width="10%"><b>Rate</b></td>
                    <td align="center" width="10%"><b>Loading</b></td>
                    {* <td align="center" width="10%"><b>Pickup Charges</b></td>
                    <td align="center" width="10%"><b>Delivery Charges</b></td> *}
                    <td align="center" width="10%"><b>Total</b></td>
                    <td align="center" width="19%" rowspan="{$summary->itemDetails|count + 2}" style="font-family: helvetica;border-color: #fff; background-color: #fff; font-size: 14px; border-left-color: #000; border-right-color: #fff;">
                        <b><br><br>{$payment_type_name|strtoupper}</b>
                    </td>
                {* {/if} *}
            {else}
                {* {if $summary->pickupHandlingAmount == 0 && $summary->deliveryHandlingAmount != 0}
                    <td align="center" width="5%"><b>S No</b></td>
                    <td align="center" width="29%"><b>Article</b></td>     
                    <td align="center" width="10%"><b>Quantity</b></td>
                    <td align="center" width="10%"><b>Rate</b></td>
                    <td align="center" width="10%"><b>Handling</b></td>
                    <td align="center" width="10%"><b>Delivery Charges</b></td>
                    <td align="center" width="10%"><b>Total</b></td>
                    <td align="center" width="16%" rowspan="{$summary->itemDetails|count + 2}" style="font-family: helvetica;border-color: #fff; background-color: #fff; font-size: 14px; border-left-color: #000; border-right-color: #fff;">
                        <b>{$payment_type_name|strtoupper}</b>
                    </td>
                {elseif $summary->pickupHandlingAmount != 0 && $summary->deliveryHandlingAmount == 0}
                    <td align="center" width="5%"><b>S No</b></td>
                    <td align="center" width="29%"><b>Article</b></td>     
                    <td align="center" width="10%"><b>Quantity</b></td>
                    <td align="center" width="10%"><b>Rate</b></td>
                    <td align="center" width="10%"><b>Handling</b></td>
                    <td align="center" width="10%"><b>Pickup Charges</b></td>
                    <td align="center" width="10%"><b>Total</b></td>
                    <td align="center" width="16%" rowspan="{$summary->itemDetails|count + 2}" style="font-family: helvetica;border-color: #fff; background-color: #fff; font-size: 14px; border-left-color: #000; border-right-color: #fff;">
                        <b>{$payment_type_name|strtoupper}</b>
                    </td>
                {elseif $summary->pickupHandlingAmount == 0 && $summary->deliveryHandlingAmount == 0}
                    <td align="center" width="5%"><b>S No</b></td>
                    <td align="center" width="30%"><b>Article</b></td>     
                    <td align="center" width="12%"><b>Quantity</b></td>
                    <td align="center" width="12%"><b>Rate</b></td>
                    <td align="center" width="12%"><b>Handling</b></td>
                    <td align="center" width="12%"><b>Total</b></td>
                    <td align="center" width="17%" rowspan="{$summary->itemDetails|count + 2}" style="font-family: helvetica;border-color: #fff; background-color: #fff; font-size: 14px; border-left-color: #000; border-right-color: #fff;">
                        <b>{$payment_type_name|strtoupper}</b>
                    </td>
                {else} *}
                    <td align="center" width="5%"><b>S No</b></td>
                    <td align="center" width="28%"><b>Article</b></td>     
                    <td align="center" width="12%"><b>Quantity</b></td>
                    <td align="center" width="12%"><b>Rate</b></td>
                    <td align="center" width="12%"><b>Loading</b></td>
                    {* <td align="center" width="9%"><b>Pickup Charges</b></td>
                    <td align="center" width="9%"><b>Delivery Charges</b></td> *}
                    <td align="center" width="12%"><b>Total</b></td>
                    <td align="center" width="19%" rowspan="{$summary->itemDetails|count + 2}" style="font-family: helvetica;border-color: #fff; background-color: #fff; font-size: 14px; border-left-color: #000; border-right-color: #fff;">
                        <b>{$payment_type_name|strtoupper}</b>
                    </td>
                {* {/if} *}
            {/if}
        </tr>
        {assign var=qty value=0}
        {assign var=rate value=0}
        {assign var=handling value=0}
        {assign var=subtotal value=0}
        {$del_cnt = 0}
        {$pick_cnt = 0}
        {foreach from=$summary->itemDetails item=article name=carArt}
            <tr>
                <td align="center">{$smarty.foreach.carArt.index+1}</td>
                <td align="left">{$article->cargoItem->name|truncate:25}</td>                                 
                {if $action_rights['CARGO-UNITS']==1}
                <td align="center">
                    {$article->unitValue}&nbsp;
                    {$article_unit[$article->unit->code]}
                </td>
                {/if}
                <td align="center">{$article->itemCount}</td>
                <td align="center">{$article->fare}</td>
                <td align="center">{$article->handlingChargeAmount}</td>
                
                {* {if ($summary->pickupHandlingAmount != 0) && ($pick_cnt == 0)}
                    {$pick_cnt = $pick_cnt+1}
                    {if count($summary->itemDetails) > 3}
                        <td align="center" rowspan="{count($summary->itemDetails)}"><div style="vertical-align: middle;"><p>{$summary->pickupHandlingAmount}</p></div></td>
                    {elseif count($summary->itemDetails) == 1}
                        <td align="center" rowspan="{count($summary->itemDetails)}">{$summary->pickupHandlingAmount}</td>
                    {else}
                        <td align="center" rowspan="{count($summary->itemDetails)}"><div></div>{$summary->pickupHandlingAmount}</td>
                    {/if}
                {/if}

                {if ($summary->deliveryHandlingAmount != 0) && ($del_cnt == 0)}
                    {$del_cnt = $del_cnt+1}
                    {if count($summary->itemDetails) > 3}
                        <td align="center" rowspan="{count($summary->itemDetails)}"><div style="vertical-align: middle;"><p>{$summary->deliveryHandlingAmount}</p></div></td>
                    {elseif count($summary->itemDetails) == 1}
                        <td align="center" rowspan="{count($summary->itemDetails)}">{$summary->deliveryHandlingAmount}</td>
                    {else}
                        <td align="center" rowspan="{count($summary->itemDetails)}"><div></div>{$summary->deliveryHandlingAmount}</td>
                    {/if}
                {/if} *}

                <td align="right">
                    {($article->computed->freight + $article->handlingChargeAmount)|number_format:2}
                </td>
            </tr>
            {assign var=qty value=$qty + $article->itemCount}
            {assign var=rate value=$rate + $article->fare}
            {assign var=handling value=$handling + $article->handlingChargeAmount}
            {assign var=subtotal value=$subtotal + $article->computed->freight + $article->handlingChargeAmount     }
        {/foreach}
        <tr>
            {if $action_rights['CARGO-UNITS']==1}
            <td align="right" colspan="3"><b>Sub Total</b></td>
            {else}
            <td align="right" colspan="2"><b>Sub Total</b></td>
            {/if}
            <td align="center">{$qty}</td>
            <td align="center"></td>
            <td align="center"></td>

            {* {if $summary->pickupHandlingAmount != 0}
                <td align="center"></td>
            {/if}

            {if $summary->deliveryHandlingAmount != 0}
                <td align="center"></td>
            {/if} *}

            <td align="right">{$subtotal|number_format:2}</td>
        </tr>
        
        {* <tr>
            {assign var="net_amt" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value)}
            {if $net_amt>0}
                {if $action_rights['CARGO-UNITS']==1}
                    <td align="" colspan="{if ($summary->pickupHandlingAmount != 0) && ($summary->deliveryHandlingAmount == 0)}6{elseif  ($summary->pickupHandlingAmount == 0) && ($summary->deliveryHandlingAmount != 0)}6{elseif  ($summary->pickupHandlingAmount != 0) && ($summary->deliveryHandlingAmount != 0)}7{else}5{/if}">
                    Including  - , {/if} {if ($)} - {$}, {/if} {if ($ != '')} - {$}, {/if} {if ($ != '')} -{$}, {/if} {if ($ != '')} - {$}, {/if} {if ($ != '')} - {$}, {/if} {if ($ != '')} - {$}, {/if}  {if ($ != '')} - {$}, {/if} {if ($ != '')} - {$}, {/if} {if ($ != '')} - {$}{/if} 
                        </td>
                    <td align="right"><b>Total</b></td>
                {else}
                    <td align="" colspan="{if ($summary->pickupHandlingAmount != 0) && ($summary->deliveryHandlingAmount == 0)}5{elseif  ($summary->pickupHandlingAmount == 0) && ($summary->deliveryHandlingAmount != 0)}5{elseif  ($summary->pickupHandlingAmount != 0) && ($summary->deliveryHandlingAmount != 0)}6{else}4{/if}">Including {if ($summary->totalHandlingAmount != 0) && ($summary->totalHandlingAmount != '')}Loading charges - {$summary->totalHandlingAmount}, {/if} {if ($summary->totalUnloadHandlingAmount != 0) && ($summary->totalUnloadHandlingAmount != '')}Unloading Charges - {$summary->totalUnloadHandlingAmount}, {/if} {if ($summary->pickupHandlingAmount != 0) && ($summary->pickupHandlingAmount != '')}Pickup charges - {$summary->pickupHandlingAmount}, {/if} {if ($summary->deliveryHandlingAmount != 0) && ($summary->deliveryHandlingAmount != '')}Door delivery charges -{$summary->deliveryHandlingAmount}, {/if} {if ($summary->serviceCharge != 0) && ($summary->serviceCharge != '')}Other charges - {$summary->serviceCharge}, {/if} {if ($summary->hamaliCharge != 0) && ($summary->hamaliCharge != '')}Hamali - {$summary->hamaliCharge}, {/if} {if ($summary->passCharge != 0) && ($summary->passCharge != '')}Pass Charges - {$summary->passCharge}, {/if}  {if ($summary->docketCharge != 0) && ($summary->docketCharge != '')}Docket charges - {$summary->docketCharge}, {/if} {if ($addons_mapped['PODCH']->value != 0) && ($addons_mapped['PODCH']->value != '')}POD Charges - {$addons_mapped['PODCH']->value}, {/if} {if ($addons_mapped['DMRCH']->value != 0) && ($addons_mapped['DMRCH']->value != '')}Demurrage Charges - {$addons_mapped['DMRCH']->value}{/if} </td>
                    <td align="right"> <b>Total</b></td>
                {/if}
                <td align="right" ><b>{$net_amt|number_format:2}</b></td>
            {/if}
        </tr> *}
        {* {if ($summary->totalHandlingAmount != 0) && ($summary->totalHandlingAmount != '')}
            <tr>
                <td align="right" colspan="{if $action_rights['CARGO-UNITS']==1} 6 {else} 5 {/if}">Loading charges</td>
                <td align="right">{$summary->totalHandlingAmount|inr_format}</td>
            </tr>
        {/if} *}

        {if ($summary->totalUnloadHandlingAmount != 0) && ($summary->totalUnloadHandlingAmount != '')}
            <tr>
                <td align="right" colspan="{if $action_rights['CARGO-UNITS']==1} 6 {else} 5 {/if}">Unloading Charges</td>
                <td align="right">{$summary->totalUnloadHandlingAmount|inr_format}</td>
            </tr>
        {/if}

        {* {if ($summary->pickupHandlingAmount != 0) && ($summary->pickupHandlingAmount != '')} *}
            <tr>
                <td align="right" colspan="{if $action_rights['CARGO-UNITS']==1} 6 {else} 5 {/if}">Door Pickup charges</td>
                <td align="right">{$summary->pickupHandlingAmount|inr_format}</td>
            </tr>
        {* {/if} *}

        {* {if ($summary->deliveryHandlingAmount != 0) && ($summary->deliveryHandlingAmount != '')} *}
            <tr>
                <td align="right" colspan="{if $action_rights['CARGO-UNITS']==1} 6 {else} 5 {/if}">Door delivery charges</td>
                <td align="right">{$summary->deliveryHandlingAmount|inr_format}</td>
            </tr>
        {* {/if} *}

        {if ($summary->serviceCharge != 0) && ($summary->serviceCharge != '')}
            <tr>
                <td align="right" colspan="{if $action_rights['CARGO-UNITS']==1} 6 {else} 5 {/if}">Other charges</td>
                <td align="right">{$summary->serviceCharge|inr_format}</td>
            </tr>
        {/if}

        {if ($summary->hamaliCharge != 0) && ($summary->hamaliCharge != '')}
            <tr>
                <td align="right" colspan="{if $action_rights['CARGO-UNITS']==1} 6 {else} 5 {/if}">Hamali</td>
                <td align="right">{$summary->hamaliCharge|inr_format}</td>
            </tr>
        {/if}

        {if ($summary->passCharge != 0) && ($summary->passCharge != '')}
            <tr>
                <td align="right" colspan="{if $action_rights['CARGO-UNITS']==1} 6 {else} 5 {/if}">Pass Charges</td>
                <td align="right">{$summary->passCharge|inr_format}</td>
            </tr>
        {/if}

        {if ($summary->docketCharge != 0) && ($summary->docketCharge != '')}
            <tr>
                <td align="right" colspan="{if $action_rights['CARGO-UNITS']==1} 6 {else} 5 {/if}">Docket charges</td>
                <td align="right">{$summary->docketCharge|inr_format}</td>
            </tr>
        {/if}

        {if ($addons_mapped['PODCH']->value != 0) && ($addons_mapped['PODCH']->value != '')}
            <tr>
                <td align="right" colspan="{if $action_rights['CARGO-UNITS']==1} 6 {else} 5 {/if}">POD Charges</td>
                <td align="right">{$addons_mapped['PODCH']->value|inr_format}</td>
            </tr>
        {/if}

        {if ($addons_mapped['DMRCH']->value != 0) && ($addons_mapped['DMRCH']->value != '')}
            <tr>
                <td align="right" colspan="{if $action_rights['CARGO-UNITS']==1} 6 {else} 5 {/if}">Demurrage Charges</td>
                <td align="right">{$addons_mapped['DMRCH']->value|inr_format}</td>
            </tr>
        {/if}

        {assign var="net_amt" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value)}

        <tr>
            <td align="right" colspan="{if $action_rights['CARGO-UNITS']==1} 6 {else} 5 {/if}"><b>Net Amount</b></td>
            <td align="right"><b>{$net_amt|inr_format}</b></td>
        </tr>
    </table>
    <br/><br>

    <table width="100%" cellpadding="2" class="bordered">
        <tr>
            {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
            <td align="left">E-Way Bill No :&nbsp;&nbsp;{$addons_mapped['EWBL'][0]->referenceCode|default:'-'}</td>
            <td align="left">Invoice Number :{$invoiceDetail[1]|default:'-'}</td>
            <td align="left">Invoice Amount :{$invoiceDetail[0]|default:'-'}</td>
            <td align="left">Invoice Date :{$invoiceDetail[2]|default:'-'}</td>

            {* {if $summary->pickupHandlingAmount > 0}
                <td align="left"><b>Pickup Charges : </b>{$summary->pickupHandlingAmount|number_format:2}</td>
            {/if}
            {if $summary->deliveryHandlingAmount > 0}
                <td align="left"><b>Delivery Charges : </b>{$summary->deliveryHandlingAmount|number_format:2}</td>
            {/if}
            {if $summary->totalUnloadHandlingAmount > 0}
                <td align="left"><b>Unloading Charges : </b>{$summary->totalUnloadHandlingAmount|number_format:2}</td>
            {/if}
            {if $summary->serviceCharge>0}
                <td align="left"><b>Service Charges : </b>{$summary->serviceCharge|number_format:2}</td>
            {/if} *}
            {* <td align="left">Net Amount : {($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value)|number_format:2}</td> *}
        {* <td align="left" >Amount Paid : {if $summary->paymentAmount}{$summary->paymentAmount|number_format:2}{else}&nbsp;&nbsp;-{/if}</td> *}
            {* {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value)-$summary->paymentAmount}
            {if $balance_to_pay>0}
                <td align="left" ><b>Amount Balance : <br/>Rs. {$balance_to_pay|number_format:2}</b></td>
            {/if} *}
        </tr>
    </table>
    
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
    <br><br>
    {* {if $terms_list|count > 0}  *}
        <table width="100%" cellpadding="1">
            <tr class="success" >
                <td colspan="2" width="65%"><b>Terms & Conditions</b></td>
                <td rowspan="{count($terms_list)+1}" width="15%" align="center" ><br><br><br><br><br><br><br><br><b>* Customer Seal & Signature</b></td>
                <td width="20%" rowspan="{count($terms_list)+1}" align="center"><br><br><img src="assets/img/clientlogo/hindusthan-logo.png" alt="logo" height="55" width="110"><br>
                    <b style="font-size: 9px;text-align:center;">For Ticket Booking</b><br>
                    <b style="font-size: 9px;text-align:center;">9952851444</b>
                </td>
            </tr>
            <tbody class="body_table" >
            {foreach from=$terms_list item=term name=carterm}
                <tr>
                    <td width="65%" align="left">{$term->name}</td>
                </tr>
            {/foreach}     	
            </tbody>
        </table>
    {* {/if} *}
    <div style="border-bottom: 1px solid #ccc;"></div>
    <table width="100%" cellpadding="1">
        <tr>
            <td width="80%">{$nsprofile->namespaceProfile->address}, {$nsprofile->namespaceProfile->city} - 641037. Mobile: {$nsprofile->namespaceProfile->supportNumber}</td>
            <td align="right" width="20%">{$nsprofile->namespaceProfile->domainURL}</td>
        </tr>
        {* <tr>
        </tr> *}
    </table>
    <hr/>
{/for}
{/strip}