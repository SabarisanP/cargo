<br/><br/><br/><br/><br/>
<table width="100%" cellpadding="2">
    <tr>
        <td>
            <table width="100%" cellpadding="3">
                <tr>
                    <td align="center" width="40%">
                        {$summary->fromCustomer->name}<br>
                        {$summary->fromOrganization->name}<br>
                        {$summary->fromCustomer->mobileNumber}
                    </td>
                    <td align="center" width="43%">
                        {$summary->toCustomer->name} <br>
                        {$summary->toOrganization->name} <br>
                        {$summary->toCustomer->mobileNumber}
                    </td>
                    <td align="left">
                        {$cargoCode}<br><br>
                        {$summary->bookedAt|date_format:$ns_datetime_format}
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<div>&nbsp;</div>
<table width="100%" cellpadding="2">
    {assign var=ic value=0}
    {assign var=unloadChAmt value=0}
    {foreach from=$summary->itemDetails item=article name=carArt}
        <tr>
            <td align="center" width="10%">{$article->itemCount}</td>
            <td align="left" width="55%">{$article->cargoItem->name|truncate:25}</td>
            <td align="right" width="20%">{if $summary->paymentType->code == 'PAD' || $summary->paymentType->code == 'TPPAD'} {(($article->itemCount*$article->fare)+$article->handlingChargeAmount)|number_format:2} {/if}</td>
            <td align="right" width="15%">{if $summary->paymentType->code == 'INP' || $summary->paymentType->code == 'TOP'}{(($article->itemCount*$article->fare)+$article->handlingChargeAmount)|number_format:2}{/if}</td>
        </tr>
        {assign var=ic value=$ic+1}
        {assign var=unloadChAmt value=unloadChAmt +{$article->unloadingChargeAmount}}
    {/foreach}
    <tr>
        <td align="center" width="10%"></td>
        <td align="left" width="50%"></td>
        <td align="left" width="40%">UL Charges : &nbsp;&nbsp;{$article->unloadingChargeAmount}</td>
    </tr>
    {assign var=ic value=$ic+1}

    {$newline = 2}
    {if $summary->serviceTax > 0}{$newline = 2}{/if}

    {for $t=$ic to $newline}
        <tr>
            <td align="center" width="10%">&nbsp;</td>
            <td align="left" width="55%">&nbsp;</td>
            <td align="right" width="20%">&nbsp;</td>
            <td align="right" width="15%">&nbsp;</td>
        </tr>
    {/for}

    {assign var=qty value=0}
    {foreach from=$summary->itemDetails item=item}
        {assign var=qty value=$qty + $item->itemCount}
    {/foreach}

    {assign var="net_amount" value=$summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value}
    {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)-$summary->paymentAmount}

    {if $summary->serviceTax > 0}
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td align="right">{if $summary->paymentType->code == 'PAD' || $summary->paymentType->code == 'TPPAD'}GST - {$summary->serviceTax|number_format:2}{/if}</td>
            <td align="right">{if $summary->paymentType->code == 'INP' || $summary->paymentType->code == 'TOP'}GST - {$summary->serviceTax|number_format:2}{/if}</td>
        </tr>
    {/if}

    <tr>
        <td align="center" style="font-weight: bold;">{$qty}</td>
        <td align="left">&nbsp;</td>
        <td align="right" style="font-weight: bold;">{if $summary->paymentType->code == 'PAD' || $summary->paymentType->code == 'TPPAD'}{$net_amount|number_format:2}{/if}</td>
        <td align="right" style="font-weight: bold;">{if $summary->paymentType->code == 'INP' || $summary->paymentType->code == 'TOP'}{$net_amount|number_format:2}{/if}</td>
    </tr>

</table>
       
