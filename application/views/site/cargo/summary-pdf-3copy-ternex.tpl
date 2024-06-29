<style>
    .h-seperator { border-bottom: 1px dashed #666; height: 0px; }
    .bordered td { border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px; border-color: #666; }
    .border-outline { border: 1px solid #666; }
    .border-left { border-left: 1px solid #666; }
    .border-top { border-top: 1px solid #666; }
    .border-right { border-right: 1px solid #666; }
    .border-bottom { border-bottom: 1px solid #666; }
    .font-11 { font-size: 11px;}
</style>

{strip}
    <br><br><br><br>
    {for $iter=1 to 3}
        <table width="100%">
            <tr>
                <td>
                    <img src="assets/img/clientlogo/ternex-header.jpg" alt="header" style="max-width: 100%;">
                </td>
            </tr>
        </table>
        <table width="100%" cellpadding="2" class="border-outline">
            <tr>
                <td colspan="2"  class="border-bottom border-right">DATE: {$summary->bookedAt|date_format:$ns_datetime_format}</td>
                <td colspan="3" class="border-bottom border-right">TYPE : <b class="font-11">{$payment_type_name|strtoupper}</b></td>
                <td colspan="3" class="border-bottom border-right">{lang('lr')} NO : <b class="font-11">{$summary->code}</b></td>
                <td align="left" class="border-bottom border-right">Freight</td>
                <td align="right" class="border-bottom">{$summary->totalAmount|number_format:2}</td>
            </tr>
            <tr>
                <td colspan="4" class="border-bottom border-right">
                    FROM : <b>{$summary->fromOrganization->name|strtoupper}</b>
                </td>
                <td colspan="4" class="border-bottom border-right">
                    TO : <b> 
                        {if ($summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO') && $summary->toCustomerAddress->station->name}
                            {$summary->toCustomerAddress->station->name|strtoupper}
                        {else}
                            {$summary->toOrganization->name|strtoupper}
                        {/if}
                    </b>
                </td>
                <td align="left" class="border-bottom border-right">Hamali</td>
                <td align="right" class="border-bottom">{$summary->totalHandlingAmount|number_format:2}</td>
            </tr>
            <tr>
                <td colspan="4" rowspan="3" class="border-bottom border-right">
                    Consigner : {substr($summary->fromCustomer->name, 0, 31)}<br>
                    {* {if isNotNull($summary->fromCustomerAddress->code) && ($summary->deliveryType->code == 'PUDO' || $summary->deliveryType->code == 'PDDO')} *}
                    {if isNotNull($summary->fromCustomerAddress->code)}
                        {substr($summary->fromCustomerAddress->address1, 0, 41)},  {$summary->fromCustomerAddress->landmark}<br/>
                        {$summary->fromCustomerAddress->station->name} - {$summary->fromCustomerAddress->pincode}, 
                    {* {else}
                        {($summary->fromOrganization->address1)},
                        {$summary->fromOrganization->contact}<br>GSTIN : {$summary->fromCustomerGST} *}
                    {/if}
                    {* Mobile No : {$summary->fromCustomer->mobileNumber}<br/> *}
                    {$summary->fromCustomer->mobileNumber}<br/>
                    GSTIN : {$summary->fromCustomerGST}
                </td>
                <td colspan="4" rowspan="3" class="border-bottom border-right">
                    Consignee : {substr($summary->toCustomer->name, 0, 31)}<br>
                    {* {if isNotNull($summary->toCustomerAddress->code) && ($summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO')} *}
                    {if isNotNull($summary->toCustomerAddress->code)}
                        {substr($summary->toCustomerAddress->address1, 0, 41)},  {$summary->toCustomerAddress->landmark}<br/>
                        {$summary->toCustomerAddress->station->name} - {$summary->fromCustomerAddress->pincode}, 
                    {* {else}
                        {($summary->toOrganization->address1)},
                        {$summary->toOrganization->contact}<br>GSTIN : {$summary->toCustomerGST} *}
                    {/if}
                    {* Mobile No : {$summary->toCustomer->mobileNumber}<br/> *}
                    {$summary->toCustomer->mobileNumber}<br/>
                    GSTIN : {$summary->toCustomerGST}
                </td>
                <td align="left" class="border-bottom border-right">LR Charge</td>
                <td align="right" class="border-bottom">{$summary->docketCharge|number_format:2}</td>
            </tr>
            <tr>
                <td align="left" class="border-bottom border-right">DD Charge</td>
                <td align="right" class="border-bottom">{$summary->deliveryHandlingAmount|number_format:2}</td>
            </tr>
            <tr>
                <td align="left" class="border-bottom border-right">Other</td>
                <td align="right" class="border-bottom">{($summary->serviceCharge + $summary->docketCharge + $summary->passCharge)|number_format:2}</td>
            </tr>

            <tr>
                <td colspan="1" align="center" class="border-bottom border-right"><b>Qty. </b></td>
                <td colspan="4" align="center" class="border-bottom border-right"><b>Description </b></td>
                <td class="border-bottom border-right"><b>Loading Ch</b></td>
                <td colspan="2" rowspan="{$summary->itemDetails|count+1}" align="right" class="border-bottom border-right">
                    <table width="100%">
                        <tr>
                            <td width="10%"></td>
                            <td align="center" class="border-bottom" width="40%"><b>{$summary->fromOrganization->shortCode}<br></b></td>
                            <td rowspan="2" width="50%" align="right">
                                <img src="{$base_url}qr?data={$summary->additionalAttribute->SLUG}&size=10" width="46px">
                            </td>
                        </tr>
                        <tr>
                            <td width="10%"></td>
                            <td align="center"><b><br>{$summary->toOrganization->shortCode}</b></td>
                        </tr>
                    </table>
                </td>
                <td align="left" rowspan="{$summary->itemDetails|count}" colspan="2" class="border-bottom"></td>
            </tr>
            
            {assign var=qty value=0}
            {assign var=actualwt value=0}
            {assign var=chargedwt value=0}
            {assign var=cnt value=0}
            {foreach from=$summary->itemDetails item=article}
                {assign var=cnt value=$cnt + 1}
                {assign var=qty value=$qty + $article->itemCount}
                {assign var=actualwt value=$actualwt + $article->actualUnitValue}
                {if $article->unit->code == 'KG'}
                    {assign var=chargedwt value=$chargedwt + $article->unitValue}
                {/if}
                <tr>
                    <td colspan="1" style="line-height: 7px;" align="center">{$article->itemCount}</td>
                    <td colspan="4" style="line-height: 7px;" class="">{$article->cargoItem->name|strtolower|ucwords} of  {$article->cargoItem->description[0]} &nbsp;&nbsp;- Rs {$article->fare|inr_format}</td>
                    <td class="border-right" align="right" style="line-height: 7px;">{$article->handlingChargeAmount|inr_format}</td>
                    {if $cnt == ($summary->itemDetails|count)}
                        <td class="border-right" style="font-size: 10px;"><b>Total</b></td>
                        <td align="right" style="font-size: 10px;"><b>{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}</b></td>
                    {/if}
                </tr>
            {/foreach}

            <tr>
                <td colspan="2" class="border-top border-right">Tot : {$qty}</td>
                <td colspan="2" class="border-top border-right">Act Wt : {$actualwt}</td>
                <td colspan="2" class="border-top border-right">Chg Wt : {$chargedwt}</td>

                {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
                <td colspan="2" class="border-top border-right">Inv No : {$invoiceDetail[1]}</td>
                <td colspan="2" class="border-top"><b>Delivery Type : </b>
                    {if $summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO'}
                        {$del_at = 'DOOR DLY'}
                    {else}
                        {$del_at = 'GODOWN'}
                    {/if}
                    <b>{$del_at}</b>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="border-top">Remark : </td>
                <td colspan="8" class="border-top">{$summary->remarks|ucwords}</td>
            </tr>
            <tr>
                <td colspan="5" class="border-top border-right">Receiver Signature</td>
                <td colspan="5" class="border-top">Tern Ex <br/>Signature of Clerk / Agent</td>
            </tr>
        </table>     
        {if $iter < 3}
            <div class="h-seperator"></div><br>
        {/if}      
    {/for}
{/strip}
