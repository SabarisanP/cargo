    {assign var=freight value=0}
    {assign var=ton_freight value=0}
    {assign var=lr_charge value=0}
    {assign var=loading_charge value=0}
    {assign var=unloading_charge value=0}
    {assign var=door_col value=0}
    {assign var=door_del value=0}
    {assign var=gst value=0}
    {assign var=cgst value=0}
    {assign var=sgst value=0}
    {assign var=others value=0}
    {assign var=actual_wt value=0}
    {assign var=charged_wt value=0}
    {assign var=quantity value=0}
    {assign var=ton_actual_wt value=0}
    {assign var=ton_charged_wt value=0}
    {assign var=ton_quantity value=0}
    {foreach from=$summary->itemDetails item=article name=carArt}
        {if $article->unit->code != 'TON'}
            {assign var=freight value=$freight + (($article->fare) * $article->itemCount)}
            {* {assign var=actual_wt value=$actual_wt + $article->actualUnitValue}
            {assign var=charged_wt value=$charged_wt + $article->unitValue} *}
            {assign var=quantity value=$quantity + $article->itemCount}
        {else}
            {assign var=ton_freight value=$ton_freight + (($article->fare) * $article->itemCount)}
            {assign var=ton_actual_wt value=$actual_wt + $article->actualUnitValue}
            {assign var=ton_charged_wt value=$charged_wt + $article->unitValue}
            {assign var=ton_quantity value=$quantity + $article->itemCount}
        {/if}

        {assign var=lr_charge value=$lr_charge + $summary->docketCharge}
        {assign var=loading_charge value=$loading_charge + $article->handlingChargeAmount}
        {assign var=unloading_charge value=$unloading_charge + $article->unloadingChargeAmount}
        {assign var=door_col value=$door_col + $summary->pickupHandlingAmount}
        {assign var=door_del value=$door_del + $article->deliveryHandlingAmount}
        {assign var=gst value=$gst + $article->serviceTax}
        {assign var=cgst value=$cgst + $article->tax->cgstValue}
        {assign var=sgst value=$sgst + $article->tax->sgstValue}
        {assign var=others value=$others}
    {/foreach}
<table width="100%" cellpadding="2" style="">
    <tr>
        <td style="width: 43%"><br><br><br><br><br></td>
        <td style="width: 27%"><br><br><br><br><br></td>
        <td rowspan="2" style="width: 30%;">
            <table width="100%" cellpadding="0">
                <tr>
                    <td><br><br></td>                
                    <td width="5%"></td>
                    <td align="left" width="50%"><br><br><br><br>{$summary->fromStation->shortCode}</td>
                </tr>
                <tr>
                    <td><b></b></td>                
                    <td></td>
                    <td align="left">{$cargoCode}</td>
                </tr>
                <tr>
                    <td></td>                
                    <td></td>
                    <td align="left">{$summary->bookedAt|date_format:$ns_date_format}</td>
                </tr>
                <tr>
                    <td></td>                
                    <td></td>
                    <td align="left">{if isset($summary->tripInfo->busVehicle->registationNumber) && $summary->tripInfo->busVehicle->registationNumber != 'false'}{$summary->tripInfo->busVehicle->registationNumber}{elseif $summary->transitVehicle->registationNumber != '' && $summary->transitVehicle->registationNumber != 'false'}{$summary->transitVehicle->registationNumber}{elseif $summary->additionalAttribute->registerNumber != '' && $summary->additionalAttribute->registerNumber != 'false'}{$summary->additionalAttribute->registerNumber}{else}-{/if}</td>
                </tr>
                <tr>
                    <td></td>                
                    <td></td>
                    <td align="left">{$summary->fromOrganization->name}</td>
                </tr>
                <tr>
                    <td></td>                
                    <td></td>
                    <td align="left">{$summary->toOrganization->name}</td>
                </tr>
                <tr>
                    <td></td>                
                    <td></td>
                    <td align="left"></td>
                </tr>
            </table>    
        </td>
    </tr>
    <tr>
        <td style="width: 43%;"><br>{$summary->fromCustomer->name}<br>{$summary->fromOrganization->name}<br>Mobile : {$summary->fromCustomer->mobileNumber}<br>GSTIN : {$summary->fromCustomerGST}<br></td>
        <td style="width: 27%;"><br>{$summary->toOrganization->name}<br>{$summary->fromOrganization->name}<br>Mobile : {$summary->toCustomer->mobileNumber}<br>GSTIN : {$summary->toCustomerGST}<br></td>
    </tr>
</table>                
<table width="100%" cellpadding="2" style=" ">
    <tr>
        <td align="center" style="width: 5%;"><br></td>
        <td align="center" style="width: 10%;"><br><br></td>
        <td align="center" style="width: 35%;"><br><br></td>
        <td align="center" style="width: 15%;"><br><br></td>
        <td align="center" style="width: 13%;"><br><br></td>
        <td align="center" style="width: 12%;"><br><br></td>
        <td align="center" style="width: 10%;"><br><br></td>
    </tr>
    {assign var=ic value=0}
    {assign var=total_art value=0}
    {foreach from=$summary->itemDetails item=article name=carArt}
        <tr>
            <td align="center" style="">{$article->itemCount|sigma:$tot_article}</td>
            <td style=""></td>
            <td align="left" style="">{$article->cargoItem->name|truncate:25} - Rs. {$article->fare}</td>

            {if $ic == 0}
                <td style="" rowspan="{count($summary->itemDetails)+2}">
                    <table width="100%" cellpadding="0">
                        <tr>
                            <td align="center" style=""></td>
                            <td align="center" style=""></td>
                        </tr>
                        <tr>
                            <td align="center" style=""><br>{$ton_actual_wt}</td>
                            <td align="center" style=""><br>{$ton_quantity}</td>
                        </tr>
                        <tr>
                            <td align="center" style="" colspan="2"></td>
                        </tr>
                        <tr>
                            <td align="center" style=""></td>
                            <td align="center" style=""></td>
                        </tr>
                        <tr>
                            <td align="center" style="">{$ton_charged_wt}</td>
                            <td align="center" style="">{$ton_quantity}</td>
                        </tr>
                        <tr>
                            <td align="center" style="" colspan="2"></td>
                        </tr>
                        <tr>
                            <td align="center" style=""></td>
                            <td align="center"></td>
                        </tr>
                    </table>
                </td>
                <td style="" align="left" rowspan="{count($summary->itemDetails)+4}"></td>
                <td style="" align="right" rowspan="{count($summary->itemDetails)+4}">{$fre = number_format(($freight), 2)}{$freight_amt = explode('.', $fre)}<h5 >{$freight_amt[0]}</h5>
                    
                    {$door = number_format(($door_col), 2)}
                    {$door_col_amt = explode('.', $door)}
                    <h5 >{$door_col_amt[0]}</h5>

                    {$deli = number_format(($door_del), 2)}
                    {$door_del_amt = explode('.', $deli)}
                    <h5 >{$door_del_amt[0]}</h5>

                    {$hamali = number_format(($summary->hamaliCharge), 2)}
                    {$hamali_amt = explode('.', $hamali)}
                    <h5 >{$hamali_amt[0]}</h5>

                    {$c_gst = number_format(($cgst), 2)}
                    {$cgst_amt = explode('.', $c_gst)}
                    <h5 >{$cgst_amt[0]}</h5>

                    {$s_gst = number_format(($sgst), 2)}
                    {$sgst_amt = explode('.', $s_gst)}
                    <h5 >{$sgst_amt[0]}</h5>

                    {$other = number_format(($others), 2)}
                    {$others_amt = explode('.', $other)}
                    <h5 style="">{$others_amt[0]}</h5>
                    
                    {assign var=tot value=number_format(($freight+$ton_freight+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value), 2)}
                    {$total = explode('.', $tot)}
                    <h3 >{$total[0]}</h3>
                </td>
                <td align="left" rowspan="{count($summary->itemDetails)+4}"><h5 >. {$freight_amt[1]}</h5>
                    <h5 >. {$door_col_amt[1]}</h5>
                    <h5 >. {$door_del_amt[1]}</h5>
                    <h5 >. {$hamali_amt[1]}</h5>
                    <h5 >. {$cgst_amt[1]}</h5>
                    <h5 >. {$sgst_amt[1]}</h5>
                    <h5 style="">. {$others_amt[1]}</h5>
                    <h3 >. {$total[1]}</h3>
                </td>
            {/if}
        </tr>
        {if $ic == count($summary->itemDetails)-1}
            <tr>
                <td align="center">{if count($summary->itemDetails) == 1}<br><br><br><br><br>{elseif count($summary->itemDetails) == 3}<br><br><br>{elseif count($summary->itemDetails) == 4}<br><br>{/if}{$tot_article}</td>
                <td colspan="3">{if count($summary->itemDetails) == 1}<br><br><br><br><br>{elseif count($summary->itemDetails) == 3}<br><br><br>{elseif count($summary->itemDetails) == 4}<br><br>{/if}No. Of Items {$tot_article|amount_in_words|ucwords} Only</td>
            </tr>
            <tr>
                <td align="center"></td>
                <td colspan="3">**  GST / RCM PAYABLE BY {if ($summary->fromCustomerGST != '') && ($summary->toCustomerGST == '')}CONSIGNOR{elseif ($summary->fromCustomerGST == '') && ($summary->toCustomerGST != '')}CONSIGNEE{elseif ($summary->fromCustomerGST != '') && ($summary->toCustomerGST != '') && ($summary->paymentType->code == 'PAD')}CONSIGNOR{elseif ($summary->fromCustomerGST != '') && ($summary->toCustomerGST != '') && ($summary->paymentType->code == 'TOP')}CONSIGNEE{/if} **</td>
            </tr>
            <tr>
                <td style=""></td>
                <td style=""></td>
                <td align="left"><table width="100%">
                    <tr>
                        <td colspan="2" align="center">{$summary->invoiceNumber}</td>
                        <td></td>
                        <td width="33%">{$summary->invoiceDate|date_format:$ns_date_format}</td>
                    </tr>
                </table>
                </td>
                <td style="">
                    <table width="100%">
                        <tr>
                            {$tot_ton = number_format(($ton_freight), 2)}
                            {$total_ton_charge = explode('.', $tot_ton)}

                            <td align="right" style="">{$total_ton_charge[0]}&nbsp;&nbsp;</td>
                            <td>&nbsp;. {$total_ton_charge[1]}</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style=""></td>
                <td style=""></td>
                <td style="" align="center">{$summary->invoiceAmount|inr_format}</td>
                <td style="" align="center"><b>{$summary->paymentType->name}</b></td>
            </tr>
        {/if}
        {assign var=ic value=$ic+1}    
        {assign var=total_art value=$total_art+1}
    {/foreach} 
    <tr>
        <td width="60%"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{($freight+$ton_freight+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value)|amount_in_words|ucwords}</b></td>
        <td rowspan="2" width="40%" align="center"></td>
    </tr>
</table>