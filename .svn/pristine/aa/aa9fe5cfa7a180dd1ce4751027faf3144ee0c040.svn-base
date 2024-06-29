<style>
    .bordered td { border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px; border-color: #666; }
    .border-outline { border: 1px solid #000; }
    .border-left { border-left: 1px solid #000; }
    .font-11 { font-size: 11px;}
</style>

{strip}
    {for $iter=1 to 3}
        {if $iter==1}
            {'<br />'|str_repeat:10}
        {elseif $iter==2}
            {'<br />'|str_repeat:11}
        {elseif $iter==3}
            {'<br />'|str_repeat:11}
        {/if}

        <table width="100%" cellpadding="0" style="font-size:10px;">
            <tr>
                <td width="65%">
                    <table width="100%" cellpadding="2" class="bordered">
                        <tr>
                            <td colspan="2" >DATE: {$summary->bookedAt|date_format:$ns_date_format}</td>
                            <td colspan="3">TYPE: <b class="font-11">{$payment_type_name|strtoupper}</b></td>
                            <td colspan="3">{lang('lr')} NO: <b class="font-11">{$summary->code}</b></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <span class="font-11">FROM: <b>{$summary->fromOrganization->name}</b></span><br /><br />
                                {lang('booking_sender_term')}: <b>{$summary->fromCustomer->name}</b><br />
                                Mobile: {$summary->fromCustomer->mobileNumber}<br />
                                GSTIN : {$summary->fromCustomerGST}
                            </td>
                            <td colspan="4">
                                <span>TO: <b>
                                    {if ($summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO') && $summary->toCustomerAddress->station->name}
                                        {$summary->toCustomerAddress->station->name}
                                    {else}
                                        {$summary->toOrganization->name}
                                    {/if}
                                </b></span><br /><br />
                                {lang('booking_receiver_term')}: <b>{$summary->toCustomer->name}</b><br />
                                Mobile: {$summary->toCustomer->mobileNumber}<br />
                                GSTIN : {$summary->toCustomerGST}
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" align="center"><b>Qty. </b></td>
                            <td colspan="4" align="center"><b>Description </b></td>
                            <td colspan="3"><b>Inv No.</b>&nbsp; 
                                {foreach from=$addons_mapped['EWBL'] item=row key=k}
                                    {assign var=invoiceDetail value="|"|explode:$row->value}
                                    {$invoiceDetail[1]}{if $k+1 < ($addons_mapped['EWBL']|count)}, {/if}
                                {/foreach}
                            </td>
                        </tr>
                        <tr>
                            {assign var=qty value=0}
                            {assign var=actualwt value=0}
                            {assign var=chargedwt value=0}
                            <td colspan="1" rowspan="4" align="center">
                                {foreach from=$summary->itemDetails item=article}
                                    {assign var=qty value=$qty + $article->itemCount}<br />
                                    {$article->itemCount}
                                {/foreach}
                            </td>
                            <td colspan="4" rowspan="4" align="center">
                                {foreach from=$summary->itemDetails item=article}
                                    {$article->cargoItem->name}<br />
                                    {assign var=actualwt value=$actualwt + $article->actualUnitValue}
                                    {if $article->unit->code == 'KG'}
                                        {assign var=chargedwt value=$chargedwt + $article->unitValue}
                                    {/if}
                                {/foreach}
                            </td>
                            <td colspan="3"><b>Value: </b>&nbsp; 
                                {foreach from=$addons_mapped['EWBL'] item=row key=k}
                                    {assign var=invoiceDetail value="|"|explode:$row->value}
                                    {$invoiceDetail[0]}{if $k+1 < ($addons_mapped['EWBL']|count)}, {/if}
                                {/foreach}
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">Actual Wt: {($actualwt) ? $actualwt : ''}</td>
                        </tr>
                        <tr>
                            <td colspan="3">Charged Wt: {($chargedwt) ? $chargedwt : ''}</td>
                        </tr>
                        <tr>
                            <td colspan="3" nowrap>DeliveryAt:{if $summary->deliveredAt}{$summary->deliveredAt|date_format:$ns_datetime_format}{/if}</td>
                        </tr>
                        <tr>
                            <td colspan="2">Tot. {$qty}</td>
                            <td colspan="3"></td>
                            <td colspan="3"></td>
                        </tr>
                    </table>
                </td>
                <td width="35%">
                    <table width="100%" cellpadding="2" class="bordered">
                        <tr>
                            <td align="left">Freight</td>
                            <td align="right">{$summary->totalAmount|number_format:2}</td>
                        </tr>
                        <tr>
                            <td align="left">L Charges</td>
                            <td align="right">{$summary->totalHandlingAmount|number_format:2}</td>
                        </tr>
                        {assign var="i" value=0}
                        {if $summary->pickupHandlingAmount > 0} {$i = $i+1}
                            <tr>
                                <td align="left">Pickup Charges</td>
                                <td align="right">{$summary->pickupHandlingAmount|number_format:2}</td>
                            </tr>
                        {/if}
                        {if $summary->deliveryHandlingAmount > 0} {$i = $i+1}
                            <tr>
                                <td align="left">Delivery Charges</td>
                                <td align="right">{$summary->deliveryHandlingAmount|number_format:2}</td>
                            </tr>
                        {/if}
                        {if $summary->totalUnloadHandlingAmount > 0} {$i = $i+1}
                            <tr>
                                <td align="left">Unloading Charges</td>
                                <td align="right">{$summary->totalUnloadHandlingAmount|number_format:2}</td>
                            </tr>
                        {/if}

                        {if $summary->serviceCharge > 0} {$i = $i+1}
                            <tr>
                                <td align="left">Service Charges</td>
                                <td align="right">{$summary->serviceCharge|number_format:2}</td>
                            </tr>
                        {/if}

                        {if $summary->hamaliCharge > 0} {$i = $i+1}
                            <tr>
                                <td align="left">Hamali Charges</td>
                                <td align="right">{$summary->hamaliCharge|number_format:2}</td>
                            </tr>
                        {/if}

                        {if $summary->passCharge > 0} {$i = $i+1}
                            <tr>
                                <td align="left">Pass Charges</td>
                                <td align="right">{$summary->passCharge|number_format:2}</td>
                            </tr>
                        {/if}

                        {if $summary->docketCharge > 0} {$i = $i+1}
                            <tr>
                                <td align="left">Docket Charges</td>
                                <td align="right">{$summary->docketCharge|number_format:2}</td>
                            </tr>
                        {/if}
                        {if isset($addons_mapped['PODCH'])} {$i = $i+1}
                            <tr>
                                <td align="left">POD Charge</td>
                                <td align="right">{$addons_mapped['PODCH']->value|number_format:2}</td>
                            </tr>
                        {/if}
                        {if isset($addons_mapped['DYCH'])} {$i = $i+1}
                            <tr>
                                <td align="left">Delivery Charge</td>
                                <td align="right">{$addons_mapped['DYCH']->value|number_format:2}</td>
                            </tr>
                        {/if}

                        {if $tax_computed->cgstValue != 0} {$i = $i+1}
                            <tr>
                                <td align="left">CGST</td>
                                <td align="right">{$tax_computed->cgstValue|number_format:2}</td>
                            </tr>
                        {/if}
                        {if $tax_computed->sgstValue != 0} {$i = $i+1}
                            <tr>
                                <td align="left">SGST</td>
                                <td align="right">{$tax_computed->sgstValue|number_format:2}</td>
                            </tr>
                        {/if}
                        {if $tax_computed->ugstValue != 0} {$i = $i+1}
                            <tr>
                                <td align="left">UGST</td>
                                <td align="right">{$tax_computed->ugstValue|number_format:2}</td>
                            </tr>
                        {/if}
                        {if $tax_computed->igstValue != 0} {$i = $i+1}
                            <tr>
                                <td align="left">IGST</td>
                                <td align="right">{$tax_computed->igstValue|number_format:2}</td>
                            </tr>
                        {/if}
                        {if 7 - $i > 0}
                            <tr>
                                <td colspan="2" align="center">{'<br />'|str_repeat:(7 - $i)}</td>
                            </tr>
                        {/if}
                        <tr>
                            <td align="left"><b>Total</b></td>
                            <td align="right"><b>{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</b></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">{$usr_login_name}, {date('g:i A')}</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    {/for}
{/strip}
