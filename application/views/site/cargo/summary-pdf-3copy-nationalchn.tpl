<style>                        
    .bordered td { border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px; border-color: #666; }
</style>

{for $iter=1 to 3}
    <table width="100%" cellpadding="2">
        <tr>
            <td align="center" colspan="3" style="font-weight:bold; font-size: 12px;">{$namespace_name} - Parcel Booking Receipt</td>
        </tr>
        <tr>
            <td align="left" style="font-size: 10px;"><b>{lang('lr')} No: {$cargoCode}</b></td>
            <td align="center" style="font-size: 10px;"><b>Booked Date :</b> {$summary->bookedAt|date_format:$ns_datetime_format}</td>
            <td align="right" style="font-size: 10px;"><b>Booked By :</b> {$summary->bookedUser->name}</td>
        </tr>
    </table>

    <table width="100%" cellpadding="2" class="bordered">
        <tr style="background-color: #64b92a;">
            <td align="center" style="font-size: 9px; width: 33%"><b>{lang('booking_from_term')}</b></td>
            <td align="center" style="font-size: 9px; width: 33%"><b>{lang('booking_to_term')}</b></td>
            <td align="center" style="font-size: 9px; width: 17%"><b>{lang('booking_sender_term')}</b></td>
            <td align="center" style="font-size: 9px; width: 17%"><b>{lang('booking_receiver_term')}</b></td>
        </tr>
        <tr>   
            <td align="left" style="font-size: 9px;">{$summary->fromOrganization->name}
                {if $summary->fromOrganization->address1!=''}
                    <br>{$summary->fromOrganization->address1} {$summary->fromOrganization->address2}<br>
                {/if}
                {$summary->fromOrganization->contact}
            </td>
            <td align="left" style="font-size: 9px;">{$summary->toOrganization->name}
                {if $summary->toOrganization->address1!=''}
                    <br>{$summary->toOrganization->address1} {$summary->toOrganization->address2} <br>
                {/if}
                {$summary->toOrganization->contact}
            </td>
            <td align="left" style="font-size: 9px;">{$summary->fromCustomer->name}
                <br>{$summary->fromCustomer->mobileNumber}
            </td>
            <td align="left" style="font-size: 9px;">{$summary->toCustomer->name}
                <br>{$summary->toCustomer->mobileNumber}
            </td>            
        </tr>
    </table>
    <br/><br/>

    <table width="100%" cellpadding="2" class="bordered">
        <tr style="background-color: #64b92a;">
            {if $action_rights['CARGO-UNITS']==1}
                <td align="center" width="5%"><b>S No</b></td>
                <td align="center" width="22%"><b>{lang('booking_article_label')}</b></td>     
                <td align="center" width="11%"><b>UOM</b></td>
                <td align="center" width="11%"><b>Quantity</b></td>
                <td align="center" width="11%"><b>Rate</b></td>
                <td align="center" width="11%"><b>Handling</b></td>
                <td align="center" width="11%"><b>Total</b></td>
                <td align="center" width="18%" rowspan="{$summary->itemDetails|count + 2}" style="border-color: #fff; background-color: #fff; font-size: 14px; border-left-color: #000; border-right-color: #fff;">
                    <b>{$payment_type_name|strtoupper}</b>
                </td>
            {else}
                <td align="center" width="5%"><b>S No</b></td>
                <td align="center" width="25%"><b>Article</b></td>     
                <td align="center" width="13%"><b>Quantity</b></td>
                <td align="center" width="13%"><b>Rate</b></td>
                <td align="center" width="13%"><b>Handling</b></td>
                <td align="center" width="13%"><b>Total</b></td>
                <td align="center" width="18%" rowspan="{$summary->itemDetails|count + 2}" style="border-color: #fff; background-color: #fff; font-size: 14px; border-left-color: #000; border-right-color: #fff;">
                    <b>{$payment_type_name|strtoupper}</b>
                </td>
            {/if}
        </tr>
        {assign var=qty value=0}
        {assign var=rate value=0}
        {assign var=handling value=0}
        {assign var=subtotal value=0}
        {foreach from=$summary->itemDetails item=article name=carArt}
            <tr>
                <td align="center">{$smarty.foreach.carArt.index+1}</td>
                <td align="left">{$article->cargoItem->name|truncate:25}</td>                                 
                {if $action_rights['CARGO-UNITS']==1}
                <td align="center">
                    {$article->unitValue}
                    {$article_unit[$article->unit->code]}
                </td>
                {/if}
                <td align="center">{$article->itemCount}</td>
                <td align="center">{$article->fare}</td>
                <td align="center">{$article->handlingChargeAmount}</td>
                <td align="right">
                    {$article->computed->freight|number_format:2}
                </td>
            </tr>
            {assign var=qty value=$qty + $article->itemCount}
            {assign var=rate value=$rate + $article->fare}
            {assign var=handling value=$handling + $article->handlingChargeAmount}
            {assign var=subtotal value=$subtotal + $article->computed->freight}
        {/foreach}
        <tr>
            {if $action_rights['CARGO-UNITS']==1}
            <td align="right" colspan="3"><b>Sub Total</b></td>
            {else}
            <td align="right" colspan="2"><b>Sub Total</b></td>
            {/if}
            <td align="center">{$summary->itemDetails|count} (Qty - {$qty})</td>
            <td align="center">{$rate}</td>
            <td align="center">{$handling}</td>
            <td align="right">{$subtotal|number_format:2}</td>
        </tr>
    </table>
    <br/><br/>

    <table width="100%" cellpadding="2" class="bordered">
        <tr>
            {if $summary->serviceTax>0}
                <td align="left"><b>GST : </b><br/>{$summary->serviceTax|number_format:2}</td>
            {/if}
            {if $summary->pickupHandlingAmount > 0}
                <td align="left"><b>Pickup Charges : </b><br/>{$summary->pickupHandlingAmount|number_format:2}</td>
            {/if}
            {if $summary->deliveryHandlingAmount > 0}
                <td align="left"><b>Delivery Charges : </b><br/>{$summary->deliveryHandlingAmount|number_format:2}</td>
            {/if}
            {if $summary->totalUnloadHandlingAmount > 0}
                <td align="left"><b>Unloading Charges : </b><br/>{$summary->totalUnloadHandlingAmount|number_format:2}</td>
            {/if}
            {if $summary->serviceCharge>0}
                <td align="left"><b>Service Charges : </b><br/>{$summary->serviceCharge|number_format:2}</td>
            {/if}
            <td align="left">Net Amount :<br/>{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</td>
            <td align="left">Amount Paid : <br/>{$summary->paymentAmount|number_format:2}</td>
            {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)-$summary->paymentAmount}
            {if $balance_to_pay>0}
                <td align="left" >Amount Balance : <br/>{$balance_to_pay|number_format:2}</td>
            {/if}
        </tr>
    </table>
        
    {if $summary->remarks|count}
    <table>
        <tbody class="body_table" >
            <tr class="success">
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
        <table width="100%" cellpadding="1">
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
    
           
    <p style="font-size: 7px; text-align: right;">This is computer generated receipt no signature required</p>
    <hr/>
{/for}