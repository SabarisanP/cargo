<style>
    .bordered td {
        border-right-width: 0.1px;
        border-top-width: 0.1px;
        border-left-width: 0.1px;
        border-bottom-width: 0.1px;
        border-color: #666;
    }
</style>
<table width="100%" cellpadding="2">
    <tr>
        <td width="100%">&nbsp;</td>
    </tr>
</table>
{for $iter=1 to 3}
    <br />

    {assign var=loading_charge value=0}
    {assign var=unloading_charge value=0}
    {assign var=others value=0}
    {assign var=net_wt value=0}
    {assign var=gross_wt value=0}
    {assign var=c_gst value=0}
    {assign var=s_gst value=0}
    {foreach from=$summary->itemDetails item=article name=carArt}
        {assign var=loading_charge value=$loading_charge + $article->handlingChargeAmount}
        {assign var=unloading_charge value=$unloading_charge + $article->unloadingChargeAmount}
        {assign var=others value=$others}
        {assign var=net_wt value=$net_wt + $article->unitValue}
        {assign var=gross_wt value=$gross_wt + $article->actualUnitValue}

        {assign var=c_gst value=$c_gst + $article->tax->cgstValue}
        {assign var=s_gst value=$s_gst + $article->tax->sgstValue}
    {/foreach}

    <table width="100%" cellpadding="6">
        <tr>
            <td width="77%"></td>
            <td width="10%" align="center" style="">
                <div style="border-bottom: 1px solid #2c2c2c; font-size: 10px;"><b>{if $summary->fromOrganization->shortCode}{$summary->fromOrganization->shortCode}{else} - {/if}</b><br></div>
                <div style="font-size: 10px;"><b>{if $summary->toOrganization->shortCode}{$summary->toOrganization->shortCode}{else} - {/if}</b></div>
            </td>
            <td align="center" width="15%">
                <img src="{$base_url}qr?data={$summary->additionalAttribute->SLUG}&size=10" width="62px">
            </td>
        </tr>
    </table>
    <br />
    <table width="100%" cellpadding="2" style="border: 1px solid #2c2c2c;">
        <tr>
            {$from_org_contact = explode(",",$summary->fromOrganization->contact)}
            <td width="5%" style="border-bottom: 1px solid #2c2c2c;"><b>From:</b></td>
            <td width="30%" style="border-bottom: 1px solid #2c2c2c;">
                {$summary->fromCustomer->name}<br>
                {$summary->fromCustomer->mobileNumber}, GST:{$summary->fromCustomerGST}<br>
                {$summary->fromOrganization->name|truncate:20} - {$from_org_contact[0]}
            </td>

            <td width="20%" style="border-bottom: 1px solid #2c2c2c;">
                <b>WB #:</b> {$cargoCode}<br>

                {$date=date_create($summary->bookedAt)}
                {$booked_at = date_format($date,"d-m-Y")}
                <b>Booked Date:</b> {$booked_at}<br>
                <b>SAC Code :</b> 996511
            </td>

            <td width="10%" align="center" style="border-bottom: 1px solid #2c2c2c;">
                <span style="border: 1px solid #2c2c2c;"><b>{$status[$summary->paymentType->code]}</b></span>
            </td>

            {$to_org_contact = explode(",",$summary->toOrganization->contact)}
            <td width="5%" align="right" style="border-bottom: 1px solid #2c2c2c;"><b>To:</b></td>
            <td width="30%" style="border-bottom: 1px solid #2c2c2c;">
                {$summary->toCustomer->name}<br>
                {$summary->toCustomer->mobileNumber}, GST:{$summary->toCustomerGST}<br>
                {$summary->toOrganization->name|truncate:20} - {$to_org_contact[0]}
            </td>
        </tr>

        <tr>
            <td width="30%" align="left" style="border-bottom: 1px solid #2c2c2c;">Description (Said to Contain)</td>
            <td width="18%" align="center" style="border-bottom: 1px solid #2c2c2c;">No. of Articles</td>
            <td width="17%" align="center" style="border-bottom: 1px solid #2c2c2c; border-right: 1px solid #2c2c2c;">Net Kgs.</td>
            <td width="10%" rowspan="{count($summary->itemDetails) + 1}" style="border-right: 1px solid #2c2c2c;">
                <div style="font-size: 8px;" align="center"><b>Net Wt</b></div>
                <div align="center" style="border-bottom: 1px solid #2c2c2c; font-size: 11px;"><b>{$net_wt}</b></div>
                <div style="font-size: 8px;" align="center"><b>Gross Wt</b></div>
                {* <div style="font-size: 11px;" align="center"><b>{$gross_wt}</b></div> *}
            </td>
            <td width="25%" rowspan="{count($summary->itemDetails) + 1}">
                <table width="100%" style="font-size: 7.5px;">
                    {if $summary->totalAmount > 0}
                        <tr>
                            <td width="58%">Basic Freight</td>
                            <td align="right" width="42%">{$summary->totalAmount|inr_format}</td>
                        </tr>
                    {/if}

                    {if $summary->docketCharge > 0}
                        <tr>
                            <td width="58%">LR Charges</td>
                            <td align="right" width="42%">{$summary->docketCharge|inr_format}</td>
                        </tr>
                    {/if}

                    {if $loading_charge > 0}
                        <tr>
                            <td width="58%">Loading Charges</td>
                            <td align="right" width="42%">{$loading_charge|inr_format}</td>
                        </tr>
                    {/if}

                    {if $unloading_charge > 0}
                        <tr>
                            <td width="58%">Unloading Charges</td>
                            <td align="right" width="42%">{$unloading_charge|inr_format}</td>
                        </tr>
                    {/if}

                    {if $summary->pickupHandlingAmount > 0}
                        <tr>
                            <td width="58%">Door Collection</td>
                            <td align="right" width="42%">{$summary->pickupHandlingAmount|inr_format}</td>
                        </tr>
                    {/if}

                    {if $summary->deliveryHandlingAmount > 0}
                        <tr>
                            <td width="58%">Door Delivery</td>
                            <td align="right" width="42%">{$summary->deliveryHandlingAmount|inr_format}</td>
                        </tr>
                    {/if}

                    {if $gstState === $stateCode}
                        {$c_gst = ($summary->serviceTax/2)}
                        {$s_gst = ($summary->serviceTax/2)}
                        {if $c_gst > 0}
                            <tr>
                                <td width="58%">CGST @ 2.5%</td>
                                <td align="right" width="42%">{$c_gst|inr_format}</td>
                            </tr>
                        {/if}

                        {if $s_gst > 0}
                            <tr>
                                <td width="58%">SGST @ 2.5%</td>
                                <td align="right" width="42%">{$s_gst|inr_format}</td>
                            </tr>
                        {/if}
                    {/if}

                    {if isNotNull($gstState)}
                        {$c_gst = ($summary->serviceTax/2)}
                        {$s_gst = ($summary->serviceTax/2)}
                        {if $gstState !== $stateCode}
                            {if $summary->serviceTax > 0}
                                <tr>
                                    <td width="58%">IGST @5%</td>
                                    <td align="right" width="42%">{$summary->serviceTax|inr_format}</td>
                                </tr>
                            {/if}
                        {/if}
                    {else}
                        {$c_gst = ($summary->serviceTax/2)}
                        {$s_gst = ($summary->serviceTax/2)}
                        {if $c_gst > 0}
                            <tr>
                                <td width="58%">CGST @ 2.5%</td>
                                <td align="right" width="42%">{$c_gst|inr_format}</td>
                            </tr>
                        {/if}

                        {if $s_gst > 0}
                            <tr>
                                <td width="58%">SGST @ 2.5%</td>
                                <td align="right" width="42%">{$s_gst|inr_format}</td>
                            </tr>
                        {/if}
                    {/if}

                    {if $summary->serviceCharge > 0 || $summary->hamaliCharge > 0 || $summary->passCharge > 0}
                        <tr>
                            <td width="58%">Others</td>
                            <td align="right" width="42%">{$summary->serviceCharge+$summary->hamaliCharge+$summary->passCharge|inr_format:2}</td>
                        </tr>
                    {/if}
                </table>
            </td>
        </tr>

        {assign var=cnt value=1}
        {foreach from=$summary->itemDetails item=article name=carArt}
            {if $cnt != count($summary->itemDetails)}
                <tr>
                    <td align="left">{$article->cargoItem->name|truncate:25}</td>
                    <td align="center">{$article->itemCount}</td>
                    <td align="center" style="border-right: 1px solid #2c2c2c;">{$article->unitValue}</td>
                </tr>
            {else}
                <tr>
                    <td align="left">{$article->cargoItem->name|truncate:25}</td>
                    <td align="center">{$article->itemCount}</td>
                    <td align="center" style="border-right: 1px solid #2c2c2c;">{$article->unitValue}</td>
                </tr>
                <tr>
                    {assign var=invoiceDetail value="|"|explode:$addons_mapped['EWBL'][0]->value}
                    <td width="22%"><br><br><b>Inv. No: </b> {($invoiceDetail[1])? $invoiceDetail[1]: '' }</td>
                    <td width="18%"><br><br><b>Inv. Value: </b> {($invoiceDetail[0])? $invoiceDetail[0] : ''}</td>
                    <td width="25%" style="border-right: 1px solid #2c2c2c;"><br><br>
                        <b>E-Way Bill: </b> {$addons_mapped['EWBL'][0]->referenceCode|default:'-'}
                    </td>
                    <td style="border-right: 1px solid #2c2c2c;font-size: 11px;" align="center"><br><b>{$gross_wt}</b></td>
                    <td style="border-right: 1px solid #2c2c2c;"><br><br>&nbsp;&nbsp;&nbsp;Grand Total &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b class="text-right">{($summary->totalAmount+$summary->docketCharge+$loading_charge+$unloading_charge+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceTax+$summary->serviceCharge+$summary->hamaliCharge+$summary->passCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value)|inr_format}</b></td>
                </tr>
            {/if}
            {assign var=cnt value=$cnt+1}
        {/foreach}

        <tr>
            <td width="40%" align="center" style="border-top: 1px solid #2c2c2c;font-size: 8px;line-height: 8px;">I/we have taken registration under the CGST Act, 2017 and have exercised the option to pay tax on services of GTA in relation to transport of goods supplied by us during the Financial Year 2022-23 under the forward charge</td>
            <td width="35%" align="center" style="border-top: 1px solid #2c2c2c;border-right: 1px solid #2c2c2c;">
                Goods received in good condition<br>
                (Receiver : Date, Signature, Mobile No. & Stamp)
            </td>
            <td width="25%" align="center" style="border-top: 1px solid #2c2c2c;">For Varahi Logistics Pvt Ltd</td>
        </tr>
    </table>
    {if $iter == 3}
        <br /><br />
    {else}
        <br /><br /><br />
    {/if}
{/for}