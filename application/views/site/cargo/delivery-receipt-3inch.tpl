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
        .h-seperator { border-bottom: 1px dashed #666; height: 0px; padding-top: 0px; padding-bottom: 0px; }
        .i{ font-style: italic;}

        body { max-width: 3in; }
    </style>
</head>   
<body>
    <table width="100%" cellpadding="3">   
        
        <tr>            
            {if $logo_avail==1}
                <td align="center">
                    <img src="{$base_url}assets/img/clientlogo/{$namespace}_3inch.png?1" max-width="200px;" >
                </td>
            {else}
                <td align="center" class="bold f17">{$namespace_name}</td>
            {/if}
        </tr>
        <tr>
            <td align="center" class="f13">
                {if $namespace == "ktwoklogistics"}
                    {if $summary->toOrganization->address1!=''}
                        {$summary->toOrganization->address1}, 
                    {/if}
                    {$summary->toOrganization->contact} 
                {else}
                    {if $summary->fromOrganization->address1!=''}
                        {$summary->fromOrganization->address1}, 
                    {/if}
                    {$summary->fromOrganization->contact} 
                {/if}
                
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

    <table width="100%">
        <tr>
            <td align="right" class="f10 i">
                Printed By {$usr_login_name|truncate:10} @ {$smarty.now|date_format:$ns_datetime_format}&nbsp;&nbsp;
            </td>     
        </tr>
    </table> 

    <div class="h-seperator"></div>

    <table width="100%" cellpadding="4">
        <tr class="f12">
            <td class="bold" align="center">DELIVERY RECEIPT</td>
        </tr>
    </table> 

    <table width="100%" cellpadding="3">
        <tr>
            <td align="center" width="100%" colspan="2" class="f14 bold">
                <span class="f15">L.R No</span> : <span class="f15 bold">{$cargoCode}</span>
            </td>        
        </tr> 
        <tr>
            <td align="left" width="100%" colspan="2">
                <span class="f12">Delivery Date : </span>
                <span class="f11 bold">{$summary->deliveredAt|date_format:$ns_datetime_format}</span>
            </td>
        </tr>    
        <tr>
            <td align="left" width="60%">
                <span class="f14">Payment Type</span><br>
                <span class="f14 bold">{$payment_type_name|upper}</span>
            </td> 
        </tr> 
        <tr>
            <td align="left" width="60%">
                <span class="f14">From</span><br>
                <span class="f14 bold">{$summary->fromStation->name}</span>
            </td>
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
                <span class="bold">{lang('booking_sender_term')}</span> <br>
                {$summary->fromCustomer->name}<br><span class="bold">{$summary->fromCustomer->mobileNumber}</span>
            </td> 
            <td align="left" class="f12" width="50%" valign="top"> 
                <span class="bold">{lang('booking_receiver_term')}</span> <br>
                {$summary->toCustomer->name}<br><span class="bold">{$summary->toCustomer->mobileNumber}</span>
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
            <td align="left" class="f12" width="20%" valign="top" >Article</td> 
            <td align="left" class="f12" width="1%" valign="top"> : </td>    
            <td align="left" class="f12">{$articlename}</td>        
        </tr>
    </table>

    <div class="h-seperator"></div>

    <table width="98%" cellpadding="3">
        {$transactionAmount = 0}
        {foreach from=$summary->cargoTransactionList item=$row}
            {if $row->transactionType->code == 'CGCA'}
                {$transactionAmount = $transactionAmount - $row->transactionAmount}
            {else}
                {$transactionAmount = $transactionAmount + $row->transactionAmount}
            {/if}
        {/foreach}
        {if $summary->paymentType->code == 'PAD'}
            {$transactionAmount = $amountpaid}
        {/if}
        <tr>
            <td align="right" class="f12" width="60%" valign="top">Amount Paid</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12 bold">{$transactionAmount|inr_format}</td>
        </tr>
    </table>

    <div class="h-seperator"></div>
        
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

    <br/>
  
</body> 
</html>

<script>
    // window.print();
    //window.close();
</script> 