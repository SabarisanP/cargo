<style>
    .bordered td{ border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px  }
    .bordered .noborder{ border:1px solid #fff; }
    .bold{ font-weight:bold; }
</style>

<table width="100%">
    <tr>
        <td align="left" width='50%'>
            <table width="100%" cellpadding="3">
                <tr>
                    <td align="center" style="font-weight:bold; font-size: 13px;">{$namespace_name}</td>
                </tr>
                <tr>
                    <td align="center" class="bold">Parcel Booking Receipt</td>
                </tr>
                <tr>
                    <td align="center">
                        {if $namespace == "ybmlogistics"}
                            Corparate Address : No:64 , 4th Layout, Teachers Colony, Lakshmipuram, Kolathur, Chennai - 99
                            <br>
                            GSTIN : 33AAACY9745M1ZQ
                        {elseif $namespace == "luckycargoes"}
                            {$nsprofile->namespaceProfile->address},&nbsp;{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                            GSTIN : 37AAECL1582H1ZF
                        {elseif $summary->tax->gstin}
                            {$summary->tax->tradeName}<br>
                            <b>GSTIN :</b> {$summary->tax->gstin}
                        {/if}
                    </td>
                </tr>
            </table>

            <table width="100%">
                <tr>
                    <td width="65%">
                        <table width="100%" cellpadding="3">
                            <tbody class="body_table">
                                <tr>
                                    <td align="left" width="50%" style="font-size:13px;">
                                        {lang('lr')} No : {$cargoCode}
                                    </td>
                                    <td align="left" width="50%">
                                        Booked Date : {$summary->bookedAt|date_format:$ns_datetime_format}
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <br><br>

                        <table width="100%" cellpadding="3" class="table bordered ">
                            <tbody class="body_table">
                                <tr class="success" style="background-color:#64b92a;">
                                    <td align="left" width="50%" class="bold">Booking Address</td>
                                    <td align="left" width="50%" class="bold">Delivery Address</td>
                                </tr>
                                <tr>
                                    <td align="left" width="50%">
                                        {$summary->fromOrganization->name}
                                        {if $summary->fromOrganization->address1!=''}
                                            <br>{$summary->fromOrganization->address1} {$summary->fromOrganization->address2}<br>
                                        {/if}
                                        <br>{$summary->fromOrganization->contact}
                                    </td>
                                    <td align="left" width="50%">
                                        {$summary->toOrganization->name}
                                        {if $summary->toOrganization->address1!=''}
                                            <br>{$summary->toOrganization->address1} {$summary->toOrganization->address2}<br>
                                        {/if}
                                        <br>{$summary->toOrganization->contact}
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" width="50%" class="">{$summary->fromCustomer->name}</td>
                                    <td align="left" width="50%" class="">{$summary->toCustomer->name}</td>
                                </tr>
                                <tr>
                                    <td align="left" width="50%" class="">{$summary->fromCustomer->mobileNumber}</td>
                                    <td align="left" width="50%" class="">{$summary->toCustomer->mobileNumber}</td>
                                </tr>
                                {if $summary->fromCustomerGST !="" || $summary->toCustomerGST !=""}
                                    <tr>
                                        <td align="left" width="50%" class="">GSTIN : {$summary->fromCustomerGST}</td>
                                        <td align="left" width="50%" class="">GSTIN : {$summary->toCustomerGST}</td>
                                    </tr>
                                {/if}
                            </tbody>
                        </table>

                        {assign var="hideCargoFreight" value=''}
                        {if isNotNull($summary->vendorUser) && isNotNull($summary->vendorUser->code)}
                            {assign var="hideCargoFreight" value=$summary->vendorUser->hideCargoFreight}
                        {/if}
                        <br><br>
                        <table width="100%" cellpadding="3" class="table bordered ">
                            <tr class="success" style="background-color:#64b92a;">
                                <td align="center" class="bold" width="10%">S No</td>
                                <td align="center" class="bold" width="30%">Article</td>
                                <td align="center" class="bold" width="15%">Quantity</td>
                                <td align="center" class="bold" width="15%">Rate</td>
                                <td align="center" class="bold" width="15%">Handling</td>
                                <td align="center" class="bold" width="15%">Total</td>
                            </tr>
                            <tbody class="body_table">
                                {foreach from=$summary->itemDetails item=article name=carArt}
                                    <tr>
                                        <td align="center">{$smarty.foreach.carArt.index+1}</td>
                                        <td align="left">{$article->cargoItem->name|truncate:25}</td>
                                        <td align="center">{$article->itemCount}</td>
                                        <td align="center">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$article->fare}{/if}</td>
                                        <td align="center">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$article->handlingChargeAmount}{/if}</td>
                                        <td align="center">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{(($article->itemCount*$article->fare)+$article->handlingChargeAmount)|number_format:2}{/if}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>

                        {if count($addons_mapped['EWBL'])}
                            <br><br>
                            <table width="100%" cellpadding="3" class="table bordered ">
                                <tr class="success">
                                    <td align="center" class="bold" width="45%">Invoice Number</td>
                                    <td align="center" class="bold" width="35%">Invoice Amount</td>
                                    <td align="center" class="bold" width="20%">Invoice Date</td>
                                </tr>
                                <tbody class="body_table">
                                    {foreach from=$addons_mapped['EWBL'] item=$row}
                                        <tr>
                                            {assign var=invoiceDetail value="|"|explode:$row->value}
                                            <td align="center">{$invoiceDetail[1]}</td>
                                            <td align="center">{$invoiceDetail[0]}</td>
                                            <td align="center">{$invoiceDetail[2]}</td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        {/if}

                    </td>
                    <td width="3%" valign="top"></td>
                    <td width="32%" valign="top">

                        <table width="100%" cellpadding="3" class="table">
                            <tbody class="body_table">
                                <tr>
                                    <td align="left" width="35%" class="bold">No of Articles</td>
                                    <td align="left" width="65%">{$summary->itemDetails|count}</td>
                                </tr>
                                <tr>
                                    <td align="left" width="35%" class="bold">Booked By</td>
                                    <td align="left" width="65%">{$summary->bookedUser->name}</td>
                                </tr>

                                <tr>
                                    <td align="left" width="35%" class="bold">Sub Total</td>
                                    <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{($summary->totalAmount+$article->handlingChargeAmount)|number_format:2}{/if}</td>
                                </tr>
                                {if $summary->pickupHandlingAmount>0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Pickup Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->pickupHandlingAmount|number_format:2}{/if}</td>
                                    </tr>
                                {/if}
                                {if $summary->deliveryHandlingAmount>0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Delivery Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->deliveryHandlingAmount|number_format:2}{/if}</td>
                                    </tr>
                                {/if}
                                {if $summary->totalUnloadHandlingAmount > 0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Unloading Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->totalUnloadHandlingAmount|number_format:2}{/if}</td>
                                    </tr>
                                {/if}
                                {if $summary->serviceCharge>0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Service Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->serviceCharge|number_format:2}{/if}</td>
                                    </tr>
                                {/if}
                                {if $summary->hamaliCharge > 0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Hamali Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->hamaliCharge|number_format:2}{/if}</td>
                                    </tr>
                                {/if}

                                {if $summary->passCharge > 0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Pass Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->passCharge|number_format:2}{/if}</td>
                                    </tr>
                                {/if}

                                {if $summary->docketCharge > 0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Docket Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->docketCharge|number_format:2}{/if}</td>
                                    </tr>
                                {/if}
                                {if isset($addons_mapped['PODCH'])}
                                    <tr>
                                        <td align="left" width="35%" class="bold">POD Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$addons_mapped['PODCH']->value|number_format:2}{/if}</td>
                                    </tr>
                                {/if}

                                {if $summary->serviceTax>0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">GST</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->serviceTax|number_format:2}{/if}</td>
                                    </tr>
                                {/if}

                                <tr>
                                    <td align="left" width="35%" class="bold">Net Amount</td>
                                    <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}{/if}</td>
                                </tr>

                                <tr>
                                    <td align="left" width="35%" class="bold">Amount Paid</td>
                                    <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->paymentAmount|number_format:2}{/if}</td>
                                    {if $summary->paymentType->code == "PAD"}
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <h2>PAID</h2>
                                    {else if $summary->paymentType->code == "FS"}
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <h2>Free Service</h2>
                                    {else if  $summary->paymentType->code == "TPPAD"}
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <h3>To Pay then Paid</h3>
                                    {/if}
                                </tr>
                                {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)-$summary->paymentAmount}
                                {if $balance_to_pay>0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Amount Balance</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$balance_to_pay|number_format:2}{/if}</td>
                                        {if $summary->paymentType->code == "TOP"}
                                            <h2>TO PAY</h2>
                                        {else if $summary->paymentType->code == "INP" }
                                            <h3>ON_ACCOUNT</h3>
                                        {else if $summary->paymentType->code == "OATP"}
                                            <h3>ON_ACCOUNT_TOPAY</h3>
                                        {/if}
                                    </tr>
                                {/if}
                            </tbody>
                        </table>
                    </td>
                </tr>
            </table>
            <!--<br><br>           
            <table width="100%" cellpadding="5" class="table bordered ">
                <tr>
                    <td align="left" width="20%" class="bold">Payment Type</td>
                    <td align="left" width="30%">{$summary->paymentType->name}</td>
                    <td align="left" width="20%" class="bold">Cargo Status</td>
                    <td align="left" width="30%">{$summary->cargoStatus->name}</td>
                </tr>
            </table>-->
            {if $namespace == 'srivenkateshwara'}
                <table align="left" class="table" cellpadding="1">
                    <tr>
                        <td align="left" class="bold">Bank Details</td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>Bank Name :</b>&nbsp;State Bank Of India
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>Branch : </b>&nbsp;Thiruthangal
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>A/C Number :</b>&nbsp;38740377983
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>IFSC Code :</b>&nbsp;SBIN0012767
                        </td>
                    </tr>
                </table>
            {/if}

            <br><br>
            {if $terms_list|count > 0}
                <table width="100%" cellpadding="1">
                    <tr class="success">
                        <td><b>Terms & Conditions</b></td>
                    </tr>
                    <tbody class="body_table">
                        {foreach from=$terms_list item=term name=carterm}
                            <tr>
                                <td align="left">{$term->name}</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            {/if}


            {assign var="rcmby" value=""}
            {if $summary->paymentType->code== "TPPAD" || $summary->paymentType->code== "TOP"}
                {if $summary->toCustomerGST !=""}
                    {assign var="rcmby" value="RECEIVER"}
                {else if $summary->fromCustomerGST !="" && $summary->toCustomerGST ==""}
                    {assign var="rcmby" value="SENDER"}
                {/if}
            {else if $summary->fromCustomerGST !="" }
                {assign var="rcmby" value="SENDER"}
            {else if $summary->fromCustomerGST =="" && $summary->toCustomerGST !=""}
                {assign var="rcmby" value="RECEIVER"}
            {/if}

            {if $namespace == "ybmlogistics"}
                <table width="100%" cellpadding="1">
                    <tr class="success">
                        <td align="center">
                            {if $rcmby !="" }
                                GST is payable by {$rcmby} (RCM)
                            {else}
                                GST is exempted
                            {/if}
                        </td>
                    </tr>
                </table>
            {/if}

            <table width="100%" cellpadding="1">
                <tr class="success">
                    <td align="right" style="font-size:7px;">This is computer generated receipt no signature required</td>
                </tr>
            </table>

        </td>

        <td align="left" width='50%'>
            <table width="100%" cellpadding="3">
                <tr>
                    <td align="center" style="font-weight:bold; font-size: 13px;">{$namespace_name}</td>
                </tr>
                <tr>
                    <td align="center" class="bold">Parcel Booking Receipt</td>
                </tr>
                <tr>
                    <td align="center">
                        {if $namespace == "ybmlogistics"}
                            Corparate Address : No:64 , 4th Layout, Teachers Colony, Lakshmipuram, Kolathur, Chennai - 99
                            <br>
                            GSTIN : 33AAACY9745M1ZQ
                        {elseif $namespace == "luckycargoes"}
                            {$nsprofile->namespaceProfile->address},&nbsp;{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                            GSTIN : 37AAECL1582H1ZF
                        {elseif $summary->tax->gstin}
                            {$summary->tax->tradeName}<br>
                            <b>GSTIN :</b> {$summary->tax->gstin}
                        {/if}
                    </td>
                </tr>
            </table>

            <table width="100%">
                <tr>
                    <td width="65%">
                        <table width="100%" cellpadding="3">
                            <tbody class="body_table">
                                <tr>
                                    <td align="left" width="50%" style="font-size:13px;">
                                        {lang('lr')} No : {$cargoCode}
                                    </td>
                                    <td align="left" width="50%">
                                        Booked Date : {$summary->bookedAt|date_format:$ns_datetime_format}
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <br><br>

                        <table width="100%" cellpadding="3" class="table bordered ">
                            <tbody class="body_table">
                                <tr class="success" style="background-color:#64b92a;">
                                    <td align="left" width="50%" class="bold">Booking Address</td>
                                    <td align="left" width="50%" class="bold">Delivery Address</td>
                                </tr>
                                <tr>
                                    <td align="left" width="50%">
                                        {$summary->fromOrganization->name}
                                        {if $summary->fromOrganization->address1!=''}
                                            <br>{$summary->fromOrganization->address1} {$summary->fromOrganization->address2}<br>
                                        {/if}
                                        <br>{$summary->fromOrganization->contact}
                                    </td>
                                    <td align="left" width="50%">
                                        {$summary->toOrganization->name}
                                        {if $summary->toOrganization->address1!=''}
                                            <br>{$summary->toOrganization->address1} {$summary->fromOrganization->address2}<br>
                                        {/if}
                                        <br>{$summary->toOrganization->contact}
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" width="50%" class="">{$summary->fromCustomer->name}</td>
                                    <td align="left" width="50%" class="">{$summary->toCustomer->name}</td>
                                </tr>
                                <tr>
                                    <td align="left" width="50%" class="">{$summary->fromCustomer->mobileNumber}</td>
                                    <td align="left" width="50%" class="">{$summary->toCustomer->mobileNumber}</td>
                                </tr>
                                {if $summary->fromCustomerGST !="" || $summary->toCustomerGST !=""}
                                    <tr>
                                        <td align="left" width="50%" class="">GSTIN : {$summary->fromCustomerGST}</td>
                                        <td align="left" width="50%" class="">GSTIN : {$summary->toCustomerGST}</td>
                                    </tr>
                                {/if}
                            </tbody>
                        </table>

                        <br><br>
                        <table width="100%" cellpadding="3" class="table bordered ">
                            <tr class="success" style="background-color:#64b92a;">
                                <td align="center" class="bold" width="10%">S No</td>
                                <td align="center" class="bold" width="30%">Article</td>
                                <td align="center" class="bold" width="15%">Quantity</td>
                                <td align="center" class="bold" width="15%">Rate</td>
                                <td align="center" class="bold" width="15%">Handling</td>
                                <td align="center" class="bold" width="15%">Total</td>
                            </tr>
                            <tbody class="body_table">
                                {foreach from=$summary->itemDetails item=article name=carArt}
                                    <tr>
                                        <td align="center">{$smarty.foreach.carArt.index+1}</td>
                                        <td align="left">{$article->cargoItem->name|truncate:25}</td>
                                        <td align="center">{$article->itemCount}</td>
                                        <td align="center">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$article->fare}{/if}</td>
                                        <td align="center">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$article->handlingChargeAmount}{/if}</td>
                                        <td align="center">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{(($article->itemCount*$article->fare)+$article->handlingChargeAmount)|number_format:2}{/if}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>

                        {if count($summary->invoiceDetails)}
                            <br><br>
                            <table width="100%" cellpadding="3" class="table bordered ">
                                <tr class="success">
                                    <td align="center" class="bold" width="45%">Invoice Number</td>
                                    <td align="center" class="bold" width="35%">Invoice Amount</td>
                                    <td align="center" class="bold" width="20%">Invoice Date</td>
                                </tr>
                                <tbody class="body_table">
                                    {foreach from=$summary->invoiceDetails item=$invoiceDetail}
                                        <tr>
                                            <td align="center">{$invoiceDetail->invoiceNumber}</td>
                                            <td align="center">{$invoiceDetail->invoiceAmount}</td>
                                            <td align="center">{$invoiceDetail->invoiceDate}</td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        {/if}

                    </td>
                    <td width="3%" valign="top"></td>
                    <td width="32%" valign="top">

                        <table width="100%" cellpadding="3" class="table">
                            <tbody class="body_table">
                                <tr>
                                    <td align="left" width="35%" class="bold">No of Articles</td>
                                    <td align="left" width="65%">{$summary->itemDetails|count}</td>
                                </tr>
                                <tr>
                                    <td align="left" width="35%" class="bold">Booked By</td>
                                    <td align="left" width="65%">{$summary->bookedUser->name}</td>
                                </tr>

                                <tr>
                                    <td align="left" width="35%" class="bold">Sub Total</td>
                                    <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{($summary->totalAmount+$article->handlingChargeAmount)|number_format:2}{/if}</td>
                                </tr>
                                {if $summary->pickupHandlingAmount>0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Pickup Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->pickupHandlingAmount|number_format:2}{/if}</td>
                                    </tr>
                                {/if}
                                {if $summary->deliveryHandlingAmount>0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Delivery Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->deliveryHandlingAmount|number_format:2}{/if}</td>
                                    </tr>
                                {/if}
                                {if $summary->totalUnloadHandlingAmount > 0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Unloading Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->totalUnloadHandlingAmount|number_format:2}{/if}</td>
                                    </tr>
                                {/if}
                                {if $summary->serviceCharge>0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Service Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->serviceCharge|number_format:2}{/if}</td>
                                    </tr>
                                {/if}
                                {if $summary->hamaliCharge > 0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Hamali Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->hamaliCharge|number_format:2}{/if}</td>
                                    </tr>
                                {/if}

                                {if $summary->passCharge > 0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Pass Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->passCharge|number_format:2}{/if}</td>
                                    </tr>
                                {/if}

                                {if $summary->docketCharge > 0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Docket Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->docketCharge|number_format:2}{/if}</td>
                                    </tr>
                                {/if}
                                {if isset($addons_mapped['PODCH'])}
                                    <tr>
                                        <td align="left" width="35%" class="bold">POD Charges</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$addons_mapped['PODCH']->value|number_format:2}{/if}</td>
                                    </tr>
                                {/if}

                                {if $summary->serviceTax>0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">GST</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->serviceTax|number_format:2}{/if}</td>
                                    </tr>
                                {/if}

                                <tr>
                                    <td align="left" width="35%" class="bold">Net Amount</td>
                                    <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)|number_format:2}{/if}</td>
                                </tr>

                                <tr>
                                    <td align="left" width="35%" class="bold">Amount Paid</td>
                                    <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$summary->paymentAmount|number_format:2}{/if}</td>
                                    {if $summary->paymentType->code == "PAD"}
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <h2>PAID</h2>
                                    {else if $summary->paymentType->code == "FS"}
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <h2>Free Service</h2>
                                    {else if $summary->paymentType->code == "TPPAD" }
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <h3>To Pay then Paid</h3>
                                    {/if}
                                </tr>
                                {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)-$summary->paymentAmount}
                                {if $balance_to_pay>0}
                                    <tr>
                                        <td align="left" width="35%" class="bold">Amount Balance</td>
                                        <td align="left" width="65%">{if $summary->paymentType->code == "INP" && $hideCargoFreight == 1}-{else}{$balance_to_pay|number_format:2}{/if}</td>
                                        {if $summary->paymentType->code == "TOP"}
                                            <h2>TO PAY</h2>
                                        {else if $summary->paymentType->code == "INP" }
                                            <h3>ON_ACCOUNT</h3>
                                        {else if $summary->paymentType->code == "OATP" }
                                            <h3>ON_ACCOUNT_TOPAY</h3>
                                        {/if}
                                    </tr>
                                {/if}
                            </tbody>
                        </table>
                    </td>
                </tr>
            </table>
            <!--<br><br>           
            <table width="100%" cellpadding="5" class="table bordered ">
                <tr>
                    <td align="left" width="20%" class="bold">Payment Type</td>
                    <td align="left" width="30%">{$summary->paymentType->name}</td>
                    <td align="left" width="20%" class="bold">Cargo Status</td>
                    <td align="left" width="30%">{$summary->cargoStatus->name}</td>
                </tr>
            </table>-->
            {if $namespace == 'srivenkateshwara'}
                <table align="left" class="table" cellpadding="1">
                    <tr>
                        <td align="left" class="bold">Bank Details</td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>Bank Name :</b>&nbsp;State Bank Of India
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>Branch : </b>&nbsp;Thiruthangal
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>A/C Number :</b>&nbsp;38740377983
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <b>IFSC Code :</b>&nbsp;SBIN0012767
                        </td>
                    </tr>
                </table>
            {/if}

            <br><br>
            {if $terms_list|count > 0}
                <table width="100%" cellpadding="1">
                    <tr class="success">
                        <td><b>Terms & Conditions</b></td>
                    </tr>
                    <tbody class="body_table">
                        {foreach from=$terms_list item=term name=carterm}
                            <tr>
                                <td align="left">{$term->name}</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            {/if}


            {assign var="rcmby" value=""}
            {if $summary->paymentType->code== "TPPAD" || $summary->paymentType->code== "TOP"}
                {if $summary->toCustomerGST !=""}
                    {assign var="rcmby" value="RECEIVER"}
                {else if $summary->fromCustomerGST !="" && $summary->toCustomerGST ==""}
                    {assign var="rcmby" value="SENDER"}
                {/if}
            {else if $summary->fromCustomerGST !="" }
                {assign var="rcmby" value="SENDER"}
            {else if $summary->fromCustomerGST =="" && $summary->toCustomerGST !=""}
                {assign var="rcmby" value="RECEIVER"}
            {/if}

            {if $namespace == "ybmlogistics"}
                <table width="100%" cellpadding="1">
                    <tr class="success">
                        <td align="center">
                            {if $rcmby !="" }
                                GST is payable by {$rcmby} (RCM)
                            {else}
                                GST is exempted
                            {/if}
                        </td>
                    </tr>
                </table>
            {/if}

            <table width="100%" cellpadding="1">
                <tr class="success">
                    <td align="right" style="font-size:7px;">This is computer generated receipt no signature required</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
