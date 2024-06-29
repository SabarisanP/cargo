<html>
<head>
    <style>
        *, *:before, *:after {
            color: #000 !important;
            font-family: Verdana, Tahoma, Arial, sans-serif;
            text-shadow: none !important;
            font-weight: normal;
            background: transparent !important;
            -webkit-box-shadow: none !important;
            box-shadow: none !important;
        }
        .f10{ font-size: 10px;}
        .f11{ font-size: 11px;}
        .f12{ font-size: 12px;}
        .f13{ font-size: 13px;}
        .f14{ font-size: 14px;}
        .f15{ font-size: 15px;}
        .f19{ font-size: 19px;}
        .bold{ font-weight: bold;}
        .upper{ text-transform: uppercase;}
        .boxed{ border:1px solid #000; padding: 3px; margin: 3px; }
        .h-seperator { border-bottom: 1px dashed #666; height: 0px; padding-top: 0px; padding-bottom: 0px; }
        .i{ font-style: italic;}
    </style>
</head>   
<body>
    <table width="100%" cellpadding="3">   
        
        <tr>            
            {if $logo_avail==1}
                <td align="center">
                    <img src="{$base_url}assets/img/clientlogo/{$namespace}_3inch.png" max-width="200px;" ><br>
                    <span style="font-weight: 500px; font-size: 11px;text-transform: capitalize;">(A unit of Jabbar Travels)</span>
                </td>
            {else}
                <td align="center" class="bold f17 upper">{$namespace_name}<br>
                <span style="font-weight: 500px; font-size: 11px;text-transform: capitalize;">(A unit of Jabbar Travels)</span>
                </td>
            {/if}
        </tr>
        <tr>
            <td align="center" class="f13">
                {if $summary->fromOrganization->address1!=''}
                    {$summary->fromOrganization->address1}, 
                {/if}
                {$summary->fromOrganization->contact} 

                {if $namespace == "rktparcel"}
                    {if $summary->fromStation->code == 'STF3OEX206'}
                        GSTIN : 29AAZFR4180P1ZY
                    {else}    
                        GSTIN : 33AAZFR4180P1Z9
                    {/if}            
                {elseif $summary->tax->gstin}                
                    <br> GSTIN : {$summary->tax->gstin}
                {/if}
            </td>
        </tr>
        
    </table>
   

    <div class="h-seperator"></div>

    <table width="100%" cellpadding="3">
        <tr>
            <td align="center" width="100%" colspan="2"> <br>
                <span class="f15">L.R No</span> : <span class="f19 bold boxed">{$cargoCode}</span>
            </td>        
        </tr> 
        <tr>
            <td align="left" width="60%">
                <div class="f14">Payment Type</div>
                <div class="f19 bold boxed" align="center">{$payment_type_name|upper}</div>
            </td> 
            <td align="center" width="40%" rowspan="3">
                <div class="f11">Scan & Track</div>
                <img src="{$base_url}qr?data={$summary->additionalAttribute->SLUG}&size=10" width="100px" >
            </td>   
        </tr> 
        <tr>
            <td align="left" width="60%">
                <span class="f14">From</span><br>
                <span class="f14 bold">{$summary->fromStation->name}</span>
            </td>
        </tr>  
        <tr>
            <td align="left" width="60%">
                <span class="f14">To</span><br>
                <span class="f14 bold">{$summary->toStation->name}</span>
            </td>
        </tr>    
        <tr>
            <td align="left" width="100%" colspan="2">
                <span class="f12">Booked Date : </span>
                <span class="f11 bold">{$summary->bookedAt|date_format:$ns_datetime_format}</span>
            </td>
        </tr>    
    </table>

    <div class="h-seperator"></div>

    {assign var='articlename' value=''}
    {foreach from=$summary->itemDetails item=article name=carArt}           
        {assign var='articlename' value="{$articlename} {$article->cargoItem->name}  ( {$article->itemCount}  ),"}                                         
    {/foreach}  

    {assign var='tot_amount' value=0}
    {foreach from=$summary->itemDetails item=article}
        {assign var='tot_amount' value=$tot_amount + $article->computed->freight}
    {/foreach}


    <table width="100%" cellpadding="3">
        <tr>
            <td align="left" class="f12" width="50%" valign="top" style="border-right: 1px dashed #666;" >
                <span class="bold">Consigner</span> <br>
                {$summary->fromCustomer->name}<br><span class="bold">{$summary->fromCustomer->mobileNumber}</span>
                {if $summary->fromCustomerGST}
                    <br><span class="">GST-{$summary->fromCustomerGST}</span>
                {/if}
            </td> 
            <td align="left" class="f12" width="50%" valign="top"> 
                <span class="bold">Consignee</span> <br>
                {$summary->toCustomer->name}<br><span class="bold">{$summary->toCustomer->mobileNumber}</span>
                {if $summary->toCustomerGST}
                    <br><span class="">GST-{$summary->toCustomerGST}</span>
                {/if}
            </td> 
        </tr>    
    </table>

    <table width="100%" cellpadding="3" style="display:none;">
        <tr>
            <td align="left" class="bold f12" width="30%" valign="top" >{lang('booking_sender_term')}</td> 
            <td align="left" class="bold f12" width="1%" valign="top"> : </td>    
            <td align="left" class="bold f12">{$summary->fromCustomer->name}<br>{$summary->fromCustomer->mobileNumber}</td>        
        </tr>
        <tr>
            <td align="left" class="bold f12" width="30%" valign="top">{lang('booking_receiver_term')}</td>
            <td align="left" class="bold f12" width="1%" valign="top"> : </td>    
            <td align="left" class="bold f12">{$summary->toCustomer->name}<br>{$summary->toCustomer->mobileNumber}</td>
        </tr>    
    </table>

    <div class="h-seperator"></div>

    <table width="100%" cellpadding="3">
        <tr>
            <td align="left" class="f12 bold" width="20%" valign="top" >Article</td> 
            <td align="left" class="f12 bold" width="1%" valign="top"> : </td>    
            <td align="left" class="f12 bold">{$articlename}</td>        
        </tr>
    </table>

    <div class="h-seperator"></div>

    <table width="98%" cellpadding="3">
        <tr>
            <td align="right" class="f12" width="60%" valign="top" >Freight</td> 
            <td align="left" class="f12" width="1%" valign="top"> : </td>    
            <td align="right" class="f12">{$summary->totalAmount|number_format:2}</td>        
        </tr>  
        <tr>
            <td align="right" class="f12" width="60%" valign="top" >L Charges</td> 
            <td align="left" class="f12" width="1%" valign="top"> : </td>    
            <td align="right" class="f12">{$summary->totalHandlingAmount|number_format:2}</td>        
        </tr>   
        {if $summary->pickupHandlingAmount>0}
        <tr>
            <td align="right" class="f12" width="60%" valign="top" >Pickup Charges</td> 
            <td align="left" class="f12" width="1%" valign="top"> : </td>    
            <td align="right" class="f12">{$summary->pickupHandlingAmount|number_format:2}</td>        
        </tr> 
        {/if}  
        {if $summary->deliveryHandlingAmount>0}
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >Delivery Charges</td> 
                <td align="left" class="f12" width="1%" valign="top"> : </td>    
                <td align="right" class="f12">{$summary->deliveryHandlingAmount|number_format:2}</td>        
            </tr> 
        {/if}  
        {if $summary->hamaliCharge>0}
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >Hamali Charges</td> 
                <td align="left" class="f12" width="1%" valign="top"> : </td>    
                <td align="right" class="f12">{$summary->hamaliCharge|number_format:2}</td>        
            </tr> 
        {/if}
        {if $summary->passCharge>0}
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >Pass Charges</td> 
                <td align="left" class="f12" width="1%" valign="top"> : </td>    
                <td align="right" class="f12">{$summary->passCharge|number_format:2}</td>        
            </tr> 
        {/if}
        {if $summary->docketCharge>0}
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >Docket Charges</td> 
                <td align="left" class="f12" width="1%" valign="top"> : </td>    
                <td align="right" class="f12">{$summary->docketCharge|number_format:2}</td>        
            </tr> 
        {/if}
        {if isset($addons_mapped['PODCH'])}
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >POD Charges</td>
                <td align="left" class="f12" width="1%" valign="top"> : </td>
                <td align="right" class="f12">{$addons_mapped['PODCH']->value|number_format:2}</td>
            </tr>
        {/if}

        {if $summary->totalUnloadHandlingAmount > 0}
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >Unloading Charges</td>
                <td align="left" class="f12" width="1%" valign="top"> : </td>
                <td align="right" class="f12">{$summary->totalUnloadHandlingAmount|number_format:2}</td>
            </tr>
        {/if}
        {if $summary->serviceCharge>0}
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >Service Charges</td>
                <td align="left" class="f12" width="1%" valign="top"> : </td>
                <td align="right" class="f12">{$summary->serviceCharge|number_format:2}</td>
            </tr>
        {/if}

        {if $tax_computed->cgstValue != 0}
        <tr>
            <td align="right" class="f12" width="60%" valign="top">CGST</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12">{$tax_computed->cgstValue|number_format:2}</td>
        </tr>
        {/if}
        {if $tax_computed->sgstValue != 0}
        <tr>
            <td align="right" class="f12" width="60%" valign="top">SGST</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12">{$tax_computed->sgstValue|number_format:2}</td>
        </tr>
        {/if}
        {if $tax_computed->ugstValue != 0}
        <tr>
            <td align="right" class="f12" width="60%" valign="top">UGST</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12">{$tax_computed->ugstValue|number_format:2}</td>
        </tr>
        {/if}
        {if $tax_computed->igstValue != 0}
        <tr>
            <td align="right" class="f12" width="60%" valign="top">IGST</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12">{$tax_computed->igstValue|number_format:2}</td>
        </tr>
        {/if}
        <tr>
            <td align="right" class="f12" width="60%" valign="top">Net Amount</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12 bold">{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</td>
        </tr>

        <tr>
            <td align="right" class="f12" width="60%" valign="top">Amount Paid</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12 bold">{$summary->paymentAmount|number_format:2}</td>
        </tr>
        {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)-$summary->paymentAmount}
        {if $balance_to_pay>0}
            <tr>
                <td align="right" class="f12" width="60%" valign="top">TOTAL</td>
                <td align="left" class="f12" width="1%" valign="top"> : </td>
                <td align="right" class="f14 bold">{$balance_to_pay|number_format:2}</td>
            </tr>
        {/if}
    </table>

    <div class="h-seperator"></div>
    <table width="100%" cellpadding="3">    
        <tr>
            <td align="left" class="f12">
                <span class="bold"> Delivery Address : </span> {$summary->toOrganization->name}                 
                {if $summary->toOrganization->address1!=''}
                    <br>{$summary->toOrganization->address1} , 
                {/if}
                <span class="bold">{$summary->toOrganization->contact}</span>
            </td>
        </tr>   
    </table>
    <div class="h-seperator"></div>
        
    {if $terms_list|count > 0}  
    <table width="100%">
        <tr>
            <td align="left" width="100%" class="f13 bold">Terms & Conditions</td>
        </tr>
        
        {foreach from=$terms_list item=term name=carterm}
        <tr>
            <td align="left" width="100%" class="f11">
                {$term->name} 
            </td>
        </tr> 
        {/foreach}
        
    </table>
    <div class="h-seperator"></div>
    {/if}

    <table width="100%">
        <tr>
            <td align="center" class="f12 bold">
                Consigner / Consignee is liable to pay GST under reverse charge mechanism of GST law<br>
                Delivery timings 9:00am to 5:00pm only
            </td>     
        </tr>
    </table>    

    <table width="100%">    
        <tr>
            <td align="center" class="f12">Thank You  -   {$user_profile->namespace->namespaceProfile->domainURL}</td>        
        </tr>    
    </table>
    <div class="h-seperator"></div>
    <table width="100%">    
        <tr>
            <td align="center" class="f11 i">Powered By www.ezeecargo.com</td>        
        </tr>    
    </table>
    <table width="100%">
        <tr>
            <td align="right" class="f10 i">
                Printed By {$usr_login_name|truncate:10} @ {$smarty.now|date_format:$ns_datetime_format}&nbsp;&nbsp;
            </td>     
        </tr>
    </table> 
    <br/>

     
</body> 
</html>

{if $smarty.request.markingtoken == 1}
<!-- TOKEN -->
<html>
<head> 
<style>
        *, *:before, *:after {
            color: #000 !important;
            font-family: Verdana, Tahoma, Arial, sans-serif;
            text-shadow: none !important;
            font-weight: normal;
            background: transparent !important;
            -webkit-box-shadow: none !important;
            box-shadow: none !important;
        }
        .f10{ font-size: 10px;}
        .f11{ font-size: 11px;}
        .f12{ font-size: 12px;}
        .f13{ font-size: 13px;}
        .f14{ font-size: 14px;}
        .f15{ font-size: 15px;}
        .f21{ font-size: 21px;}
        .bold{ font-weight: bold;}
        .boxed{ border:1px dashed #000; padding: 3px; margin: 3px; }
        .h-seperator { border-bottom: 1px dashed #666; height: 0px; padding-top: 0px; padding-bottom: 0px; }
        .i{ font-style: italic;}
    </style>
</head>
<body>
    <br/>
    <table width="100%" cellpadding="2">
        <tr>
            <td align="center" width="100%" colspan="3" class="f21 bold boxed">{$cargoCode}</td>        
        </tr> 
        <tr>
            <td align="center" class="f14 bold" width="48%">                
                {$summary->fromStation->name} 
                {if $summary->fromOrganization->shortCode != ""}
                    <br>
                    ( {$summary->fromOrganization->shortCode} )
                {/if}
            </td>            
        
            <td align="center" class="f13 bold" > => </td>
        
            <td align="center" class="f14 bold" width="48%">
                {$summary->toStation->name} 
                {if $summary->toOrganization->shortCode != ""}
                    <br>
                    ( {$summary->toOrganization->shortCode} )
                {/if}
            </td>
        </tr>
    </table>
    <div class="h-seperator"></div>
    <table width="100%" cellpadding="2">
        <tr>
        <td align="left">
            {$articlename}
        </td>
        </tr>
    </table>
    <div class="h-seperator"></div>
    <br/>
    
</body> 
</html>
{/if}

<script>
    window.print();
    //window.close();
</script>  