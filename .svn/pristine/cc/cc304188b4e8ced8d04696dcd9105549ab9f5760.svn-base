<style>
    table{ margin: 0px; padding: 0px;}
    .bordered td{ border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px  }
    .bordered .noborder{ border:1px solid #fff; }
    .font-7 { font-size: 7px; }
    .font-10 { font-size: 9px; }
    .font-11 { font-size: 11px; }
    .bold { font-weight: bold; }
    .h-seperator { border-bottom: 1px dashed #666; height: 0px; }
    .pagebrack { page-break-after: always;  }
</style>

{assign var=qty value=0}
{foreach from=$summary->itemDetails item=item}
    {assign var=qty value=$qty + $item->itemCount}
{/foreach}   

{if $namespace == 'vikascargo' || $namespace == 'vikasecotrans'}
    <br><br><br><br><br>
{else}
    <br><br><br><br><br><br>
{/if}

<table width="100%" class="font-10" >
<tr>
    <td width="3%">
    &nbsp;
    </td>
    <td width="45%">        
        <table width="100%" cellpadding="3">
        <tr>
            <td><span class="bold font-11">L.R No : {$summary->code}</span></td> 
            <td class="font-7"><span class="bold">Booked At :</span> {$summary->bookedAt|date_format:$ns_datetime_format}</td>        
        </tr>
        <tr>
            <td><span class="bold">Orgin&nbsp;&nbsp;&nbsp;:</span> {$summary->fromOrganization->name}</td>
            <td><span class="bold">Desti&nbsp;&nbsp;&nbsp;&nbsp;:</span> {$summary->toOrganization->name}</td>        
        </tr>
        <tr>
            <td><span class="bold">Sender :</span> {$summary->fromCustomer->name}, {substr_replace($summary->fromCustomer->mobileNumber, 'XXX', 4, 3)} </td>
            <td><span class="bold">Receiver :</span> {$summary->toCustomer->name}, {substr_replace($summary->toCustomer->mobileNumber, 'XXX', 4, 3)}</td>        
        </tr>                  
        <tr>
            <td><span class="bold">WB Type :</span> {$payment_type_name|strtoupper}</td>
            <td colspan="5"></td>
        </tr>
        <tr>
            <td><span class="bold">No.Of Pkgs :</span> {$qty}</td>
        </tr>
        <tr>
            <td><span class="bold">Freight :</span> {$summary->totalAmount}</td>
        </tr>
        <tr>
            <td><span class="bold">Loading :</span> {$summary->totalHandlingAmount}</td>
        </tr>
        <tr>
            <td><span class="bold font-11">Total : {($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</span></td>
        </tr> 
        <tr>
            <td class="font-7"><span class="bold">Booked By :</span> {$summary->bookedUser->name} </td>
            <td class="font-7"><span class="bold">Printed @ :</span> {$summary->bookedAt|date_format:$ns_datetime_format}</td>        
        </tr>             
        </table>
    </td>            
    
    <td width="10%">
        &nbsp;
    </td>
    
    <td width="45%" >
        <table width="100%" cellpadding="3" style="padding-left: 5px;">
        <tr>
            <td><span class="bold font-11">L.R No : {$summary->code}</span></td> 
            <td class="font-7"><span class="bold">Booked At :</span> {$summary->bookedAt|date_format:$ns_datetime_format}</td>        
        </tr>
        <tr>
            <td><span class="bold">Orgin&nbsp;&nbsp;&nbsp;:</span> {$summary->fromOrganization->name}</td>
            <td><span class="bold">Desti&nbsp;&nbsp;&nbsp;&nbsp;:</span> {$summary->toOrganization->name}</td>        
        </tr>
        <tr>
            <td><span class="bold">Sender :</span> {$summary->fromCustomer->name}, {$summary->fromCustomer->mobileNumber}</td>
            <td><span class="bold">Receiver :</span> {$summary->toCustomer->name}, {$summary->toCustomer->mobileNumber}</td>        
        </tr>                  
        <tr>
            <td><span class="bold">WB Type :</span> {$payment_type_name|strtoupper}</td>
            <td colspan="5"></td>
        </tr>
        <tr>
            <td><span class="bold">No.Of Pkgs :</span> {$qty}</td>
        </tr>
        <tr>
            <td><span class="bold">Freight :</span> {$summary->totalAmount}</td>
        </tr>
        <tr>
            <td><span class="bold">Loading :</span> {$summary->totalHandlingAmount}</td>
        </tr>
        <tr>
            <td><span class="bold font-11">Total : {($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2} </span></td>
        </tr> 
        <tr>
            <td class="font-7"><span class="bold">Booked By :</span> {$summary->bookedUser->name} </td>
            <td class="font-7"><span class="bold">Printed @ :</span> {$summary->bookedAt|date_format:$ns_datetime_format}</td>        
        </tr>             
        </table>
    </td>
</tr>
</table>
<div class="pagebrack">&nbsp;<div>