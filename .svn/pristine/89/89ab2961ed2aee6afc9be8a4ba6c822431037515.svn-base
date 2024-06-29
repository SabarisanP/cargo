<table width="100%" cellpadding="1" style="">
    <tr>
        <td align="center" style="font-weight:bold; font-size: 13px;">{$namespace_name}</td>
    </tr>
    <tr>
    	<td align="center">{$summary->fromOrganization->name}, {$summary->fromOrganization->contact}</td>
    </tr>
</table>
<table width="100%">
<tr>
    <td width="100%">
        
        <table width="100%" cellpadding="1" style="">
            <tbody class="body_table" >
                <tr>
                    <td colspan="3"><strong>// Booking Details</strong></td>
                </tr>
                <tr>
                    <td align="left" width="33%">{lang('lr')} No : {$cargoCode}</td>                
                    <td align="left" width="66%" colspan="2">Booked Route : {$summary->fromOrganization->name} - {$summary->toOrganization->name}</td>                           	
                </tr>
                <tr>
                    <td align="left" width="33%" >Consignor Name : {$summary->fromCustomer->name|truncate:12}</td>                
                    <td align="left" width="33%">Consignee Name : {$summary->toCustomer->name|truncate:12}</td>
                    <td align="left" width="33%">Pay Status : {$payment_type_name|upper}</td>                          	
                </tr>
                <tr>
                    <td align="left" width="33%" >Consignor Phone : {$summary->fromCustomer->mobileNumber}</td>                
                    <td align="left" width="33%">Consignee Phone : {$summary->toCustomer->mobileNumber}</td>
                    <td align="left" width="33%">Booking Date : {$summary->bookedAt|date_format:$ns_datetime_format}</td>       	
                </tr>
            </tbody>
        </table>
        
        
        <table width="100%" cellpadding="0">
            <tr>
                <td width="50%">
                    <table width="100%" cellpadding="1">
                        
                        <tbody class="body_table" >
                            <tr>
                                <td><strong>// Parcel Details</strong></td>
                            </tr>
                            
                            <tr>
                                <td align="left">{foreach from=$summary->itemDetails item=article name=carArt}{$article->cargoItem->name|truncate:25} ({$article->itemCount}), {/foreach}
                                </td>
                            </tr>
                                
                            {assign var=qty value=0}
                            {foreach from=$summary->itemDetails item=item}
                                {assign var=qty value=$qty + $item->itemCount}
                            {/foreach}
                            
                            <tr>
                                <td align="left">Total Parcels : {$qty}</td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td width="50%">
                    <table width="100%" cellpadding="1">
                        <tbody class="body_table" >
                        <tr>
                            <td colspan="2"><strong>// Booking Charges Details</strong></td>
                        </tr>
                        <tr>
                            <td align="left" width="50%">Freight : </td>
                            <td align="left" width="50%">{$summary->totalAmount|number_format:2}</td>       	
                        </tr>
                        {if $summary->handlingChargeAmount>0}
                        <tr>
                            <td align="left" >L Charges : </td>
                            <td align="left" >{$article->handlingChargeAmount|number_format:2}</td>       	
                        </tr>
                        {/if}
                        {if $summary->pickupHandlingAmount>0}
                        <tr>
                            <td align="left" >Pickup Charges : </td>
                            <td align="left" >{$summary->pickupHandlingAmount|number_format:2}</td>       	
                        </tr>
                        {/if}
                        {if $summary->deliveryHandlingAmount>0}
                        <tr>
                            <td align="left" >Delivery Charges : </td>
                            <td align="left" >{$summary->deliveryHandlingAmount|number_format:2}</td>       	
                        </tr>
                        {/if}
                        {if $summary->totalUnloadHandlingAmount > 0}
                        <tr>
                            <td align="left" >Unloading Charges : </td>
                            <td align="left" >{$summary->totalUnloadHandlingAmount|number_format:2}</td>
                        </tr>
                        {/if}
                        {if $summary->serviceCharge>0}
                        <tr>
                            <td align="left" >Service Charges : </td>
                            <td align="left" >{$summary->serviceCharge|number_format:2}</td>       	
                        </tr>
                        {/if}

                        {if $summary->serviceTax>0}
                        <tr>
                            <td align="left" >GST : </td>
                            <td align="left" >{$summary->serviceTax|number_format:2}</td>       	
                        </tr>
                        {/if}

                        <tr>
                            <td align="left" >Total Amount : </td>
                            <td align="left" >{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</td>       	
                        </tr>

                        <tr>
                            <td align="left" >Amount Paid : </td>
                            <td align="left" >{$summary->paymentAmount|number_format:2}</td>
                        </tr>
                        {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)-$summary->paymentAmount}
                        {if $balance_to_pay>0}
                        <tr>
                            <td align="left" >Amount Balance : </td>
                            <td align="left" >{$balance_to_pay|number_format:2}</td>
                        </tr>
                        {/if}
                        </tbody>
                    </table>
                </td>
            </tr>            
        </table>               
    </td>    
</tr>
</table>