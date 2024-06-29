<style>
*, *:before, *:after {
    color: #000 !important;
    font-family: Arial, Helvetica, sans-serif;
    text-shadow: none !important;
    font-weight: normal;
    background: transparent !important;
    -webkit-box-shadow: none !important;
    box-shadow: none !important;
  }
</style>

<table width="95%">
    <tr>
        <td align="right" style="font-size: 12px;">{$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td align="center" style="font-weight:bold; font-size: 19px;">{$namespace_name}</td>
    </tr>
    <tr>
        <td align="center" style="font-size: 13px;">
            {if $summary->fromOrganization->address1!=''}
            {$summary->fromOrganization->address1} <br>
            {/if}
            {$summary->fromOrganization->contact}
        </td>
    </tr>   
</table>
<br> 
<div style="font-size: 22px; font-weight: bold; text-align: center;">{$cargoCode}</div>
<br/>

<table width="95%">
    <tr>
        <td align="center" style="font-weight: bold; font-size: 13px; border-bottom:1px solid #000000;">{lang('booking_sender_term')}</td>
    </tr>
    <tr>
        <td align="center" style="font-size: 13px;">
            {$summary->fromCustomer->name}, {$summary->fromCustomer->mobileNumber}<br/>
            {$summary->fromOrganization->name}
        </td>        
    </tr>
    <tr>
        <td align="center" style="font-weight: bold; font-size: 13px; border-bottom:1px solid #000000; padding-top: 10px">{lang('booking_receiver_term')}</td>
    </tr>
    <tr>
        <td align="center" style="font-size: 13px;">
            {$summary->toCustomer->name}, {$summary->toCustomer->mobileNumber}<br/>
            {$summary->toOrganization->name}
        </td>
    </tr>    
</table>

<br/>      
<table width="80%" style="font-size: 13px; border-top:1px solid #000000;">
    <tr>        
        <td align="center" style="font-weight: bold; font-size: 13px; border-bottom:1px solid #000000; border-right:1px solid #000000; border-left:1px solid #000000; ">Article</td>                                 
        <td align="center" style="font-weight: bold; font-size: 13px; border-bottom:1px solid #000000; border-right:1px solid #000000;">Qty</td>
        <td align="center" style="font-weight: bold; font-size: 13px; border-bottom:1px solid #000000; border-right:1px solid #000000;">Total</td>
    </tr>
    <tbody class="body_table" >
        {foreach from=$summary->itemDetails item=article name=carArt}
            <tr>
                <td align="center" style="border-bottom:1px solid #000000; border-right:1px solid #000000; border-left:1px solid #000000; font-weight: bold;">{$article->cargoItem->name|truncate:25}</td>                                 
                <td align="center" style="border-bottom:1px solid #000000; border-right:1px solid #000000;">{$article->itemCount}</td>
                <td align="center" style="border-bottom:1px solid #000000; border-right:1px solid #000000;">{(($article->itemCount*$article->fare)+$article->handlingChargeAmount)|number_format:2}</td>
            </tr>
        {/foreach}     	
    </tbody>
</table>
    
<br/>
{assign var='tot_amount' value=0}
{foreach from=$summary->itemDetails item=article}
    {assign var='tot_amount' value=$tot_amount + (($article->itemCount*$article->fare)+$article->handlingChargeAmount)}
{/foreach}

{if $summary->serviceCharge>0}
<div style="font-size: 13px;">
    Service Charges : <b>Rs {$summary->serviceCharge|number_format:2}</b>
</div>
{/if}

{if $summary->serviceTax>0}
<div style="font-size: 13px;">
    GST : <b>Rs {$summary->serviceTax|number_format:2}</b>
</div>
{/if}

<div style="font-size: 13px;font-weight: bold;">
    Total Amount : Rs {($tot_amount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax)|number_format:2}
</div>


<div style="font-size: 13px;font-weight: bold;">
    Amount Paid : {$summary->paymentAmount|number_format:2}
</div>

{assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax)-$summary->paymentAmount}
{if $balance_to_pay>0}
<div style="font-size: 13px;font-weight: bold;">
    Amount Balance: {$balance_to_pay|number_format:2}
</div>
   
{/if}

<div style="font-size: 22px;font-weight: bold; text-align: center; padding-top: 10px;">
    {$payment_type_name|upper}
</div>

<br/>

<table width="90%" >    
    <tr>
        <td align="center" style="font-weight: bold; font-size: 13px; border-bottom:1px solid #000000;">Delivery At</td>
    </tr>    
    <tr>
        <td align="center" style="font-size: 13px;">
            {$summary->toOrganization->name}
            {if $summary->toOrganization->address1!=''}
                <br>{$summary->toOrganization->address1} <br>
            {/if}
            {$summary->toOrganization->contact}
        </td>
    </tr>   
</table>
    
{if $terms_list|count > 0}
<br/>    
<table width="80%">
    <tr>
        <td align="left" width="100%" style="font-weight: bold; font-size: 13px; ">Terms & Conditions</td>
    </tr>
    
    {foreach from=$terms_list item=term name=carterm}
    <tr>
        <td align="left" width="100%" style="font-size: 13px; ">
            {$smarty.foreach.carterm.index+1}. {$term->name|wordwrap:38:"<br />"} 
        </td>
    </tr> 
    {/foreach}
      
</table>
{/if}


{if $summary->remarks|count}
    <br/>
    <div style="font-size: 13px;">
        <span style="font-weight: bold;">Remarks :</span> 
        {assign var="remarksarr" value=[]}
        {foreach from=$summary->remarks item=row}
            {$remarksarr[] = $row->name}
        {/foreach}
        {$remarksarr|implode:'<br/>'}
    </div>    
{/if}
<br/>

<table width="80%">
    <tr>
        <td align="center" width="100%" style="font-size: 13px; ">Thank You</td>        
    </tr>
    <tr>
        <td align="center" width="100%" style="font-size: 13px; ">For any help visit our website</td>        
    </tr>
    <tr>
        <td align="center" width="100%" style="font-size: 13px; ">{$user_profile->namespace->namespaceProfile->domainURL}</td>        
    </tr>
</table>


<br/>

<script>
    window.print();
    //window.close();
</script>    