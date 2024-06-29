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
{assign var=description value=[]}
{foreach from=$summary->itemDetails item=item}
    {assign var=qty value=$qty + $item->itemCount}
    {if isNotNull($item->cargoItem->description[0])}
        {$description[] = $item->cargoItem->description[0]}
    {/if}
{/foreach}

<br><br><br><br><br>

<table width="100%" class="font-10" cellpadding="0">
<tr>
    <td width="3%">
    &nbsp;
    </td>
    <td width="45%">        
        <table width="100%" cellpadding="1">
            <tr>
                <td><span class="bold font-11">L.R No : {$summary->code}</span></td> 
                <td class="font-7"><span class="bold">Booked At :</span> {$summary->bookedAt|date_format:$ns_datetime_format}</td>        
            </tr>
            <tr>
                <td><span class="bold">From City </span> {$summary->fromOrganization->name}</td>
                <td><span class="bold">To City :</span> {$summary->toOrganization->name}</td>        
            </tr>
            <tr>
                <td><span class="bold">Sender Name :</span> {$summary->fromCustomer->name}</td>
                <td><span class="bold">Sender No :</span> {substr_replace($summary->fromCustomer->mobileNumber, 'XXX', 4, 3)}</td>        
            </tr>                  
            <tr>
                <td><span class="bold">Receiver Name :</span> {$summary->toCustomer->name} </td>
                <td><span class="bold">Receiver No :</span> {substr_replace($summary->toCustomer->mobileNumber, 'XXX', 4, 3)}</td>        
            </tr>                  
            <tr>
                <td><span class="bold" colspan="2">Booking Type : {$payment_type_name|strtoupper}</span></td>
            </tr>
            <tr>
                <td><span class="bold" colspan="2">No.Of Pkgs :</span> {$qty} ({$description|implode:', '})</td>
            </tr>
            <tr>
                <td><span class="bold">Freight :</span> {$summary->totalAmount}</td>
                <td><span class="bold">Loading :</span> {$summary->totalHandlingAmount}</td>
            </tr>
            <tr>
                <td><span class="bold">Docket Charges :</span> {$summary->docketCharge}</td>
                <td><span class="bold">Total Amount :</span> {($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</td>
            </tr> 
            <tr>
                <td class="font-7"><span class="bold">Booked By :</span> {$summary->bookedUser->name} </td>
                <td class="font-7"><span class="bold">Printed At :</span> {$summary->bookedAt|date_format:$ns_datetime_format}</td>        
            </tr>             
            <tr>
                <td class="font-7"><span class="bold">Remarks :</span> 
                {assign var="remarksarr" value=[]}
                {foreach from=$summary->remarks item=row}
                    {$remarksarr[] = $row->name}
                {/foreach}
                {$remarksarr|implode:'<br/>'}</td>        
            </tr>             
            <tr>
                <td class="font-7"><span class="bold">Sender GST :</span> {$summary->fromCustomerGST} </td>
                <td class="font-7"><span class="bold">Receiver GST :</span> {$summary->toCustomerGST}</td>        
            </tr>             
        </table>
    </td>            
    
    <td width="10%">
        &nbsp;
    </td>
    
    <td width="45%" >
        <table width="100%" cellpadding="1">
            <tr>
                <td><span class="bold font-11">L.R No : {$summary->code}</span></td> 
                <td class="font-7"><span class="bold">Booked At :</span> {$summary->bookedAt|date_format:$ns_datetime_format}</td>        
            </tr>
            <tr>
                <td><span class="bold">From City </span> {$summary->fromOrganization->name}</td>
                <td><span class="bold">To City :</span> {$summary->toOrganization->name}</td>        
            </tr>
            <tr>
                <td><span class="bold">Sender Name :</span> {$summary->fromCustomer->name}</td>
                <td><span class="bold">Sender No :</span> {$summary->fromCustomer->mobileNumber}</td>        
            </tr>                  
            <tr>
                <td><span class="bold">Receiver Name :</span> {$summary->toCustomer->name} </td>
                <td><span class="bold">Receiver No :</span> {$summary->toCustomer->mobileNumber}</td>        
            </tr>                  
            <tr>
                <td><span class="bold" colspan="2">Booking Type : {$payment_type_name|strtoupper}</span></td>
            </tr>
            <tr>
                <td><span class="bold" colspan="2">No.Of Pkgs :</span> {$qty} ({$description|implode:', '})</td>
            </tr>
            <tr>
                <td><span class="bold">Freight :</span> {$summary->totalAmount}</td>
                <td><span class="bold">Loading :</span> {$summary->totalHandlingAmount}</td>
            </tr>
            <tr>
                <td><span class="bold">Docket Charges :</span> {$summary->docketCharge}</td>
                <td><span class="bold">Total Amount :</span> {($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</td>
            </tr> 
            <tr>
                <td class="font-7"><span class="bold">Booked By :</span> {$summary->bookedUser->name} </td>
                <td class="font-7"><span class="bold">Printed At :</span> {$summary->bookedAt|date_format:$ns_datetime_format}</td>        
            </tr>             
            <tr>
                <td class="font-7"><span class="bold">Remarks :</span> 
                {assign var="remarksarr" value=[]}
                {foreach from=$summary->remarks item=row}
                    {$remarksarr[] = $row->name}
                {/foreach}
                {$remarksarr|implode:'<br/>'}</td>        
            </tr>             
            <tr>
                <td class="font-7"><span class="bold">Sender GST :</span> {$summary->fromCustomerGST} </td>
                <td class="font-7"><span class="bold">Receiver GST :</span> {$summary->toCustomerGST}</td>        
            </tr>             
        </table>
    </td>
</tr>
</table>
<div class="pagebrack">&nbsp;<div>