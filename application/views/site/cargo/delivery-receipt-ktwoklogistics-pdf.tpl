<style>
    .bordered td {
        border-right-width: 0.1px;
        border-top-width: 0.1px;
        border-left-width: 0.1px;
        border-bottom-width: 0.1px
    }

    .bordered .noborder {
        border: 1px solid #fff;
    }

    .bold {
        font-weight: bold;
    }

    .receipt-title {
        border: 1px solid #000;
        text-align: center;
        font-size: 9px;
    }

    .h-seperator {
        border-bottom: 1px dashed #000;
    }
</style>

{strip}
    {for $i=1 to $print_count}
        <table width="100%">
            <tr>
                <td>
                    {if $namespace == 'ktwoklogistics'}
                        <img src="{$base_url}assets/img/ktwoklogistics-header.jpg" max-width="200px;">
                    {else}
                        <table width="100%" cellpadding="3">
                            <tr>
                                <td align="center">
                                    <span style="font-weight:bold; font-size: 13px;">{$namespace_name}</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    {if isNotNull($nsprofile->namespaceProfile->address)}
                                        {$nsprofile->namespaceProfile->address}, {$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                                    {/if}
                                    {if isNotNull($summary->tax->gstin)}
                                        <b>GSTIN :</b> {$summary->tax->gstin}
                                    {/if}
                                </td>
                            </tr>
                        </table>
                    {/if}
                </td>
            </tr>
        </table>

        <table cellpadding="3">
            <tr>
                <td width="41%"></td>
                <td class="receipt-title" width="18%">DELIVERY RECEIPT</td>
                <td width="20%"></td>
                <td width="21%">
                {if $i == 1}
                   <b style="font-size: 11px;">CUSTOMER COPY</b>
                {else}
                    <b style="font-size: 11px; text-align:center;">POD</b>
                {/if}
                </td>
            </tr>
        </table>
     <br /><br />

        <table class="bordered" cellpadding="3">
            <tr>
                <td width="33%">
                    <b style="font-size: 12px;"> {lang('lr')} No : {$cargoCode}</b><br />
                    <b> Payment Type : {$payment_type_name|strtoupper}</b><br />
                    <b> Booked Date : </b>{$summary->bookedAt|date_format:$ns_datetime_format}<br />
                    <b> Delivery Date : </b>{$summary->deliveredAt|date_format:$ns_datetime_format}
                </td>
                <td width="33%">
                    <b style="font-size: 12px;">From : {$summary->fromOrganization->name}</b>
                    <br><b> Sender : </b>{$summary->fromCustomer->name}
                    <br><b> Phone No : </b>{$summary->fromCustomer->mobileNumber}
                    <br><b> GSTIN : </b>{$summary->fromCustomerGST}
                </td>
                <td width="34%">
                    <b style="font-size: 12px;">To : {$summary->toOrganization->name}</b>
                    <br><b> Receiver : </b>{$summary->toCustomer->name}
                    <br><b> Phone No : </b>{$summary->toCustomer->mobileNumber}
                    <br><b> GSTIN : </b>{$summary->toCustomerGST}
                </td>
            </tr>
        </table>
       
        <table>
            <tr>
                <td width="66%">

                    <table class="bordered" cellpadding="3">
                        <thead>
                            <tr>
                                <td align="center"><b>No. of Articles</b></td>
                                <td align="center"><b>Description</b></td>
                                <td align="center"><b>Weight KGs</b></td>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$summary->itemDetails item=article}
                                <tr>
                                    <td align="center">{$article->itemCount}</td>
                                    <td align="left">{$article->cargoItem->name|truncate:25}</td>
                                    <td align="center">
                                        {$article->unitValue} {$article_unit[$article->unit->code]}
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <td  width="100%">
                        <tr>
                            <td>
                                <b> Private Mark Number : </b>{$summary->additionalAttribute->PRIVATE_MARK_NUMBER}<br>
                                <b> Transaction Type : </b>{$summary->cargoTransactionList[0]->transactionMode->name}<br>
                                <b> Remarks : </b> {foreach from=$summary->remarks item=remark}
                                        {if $remark->cargoStatusCode == 'CD'}
                                            {$remark->name}
                                        {/if}
                                    {/foreach}
                            </td>
                        </tr>
                    </td>
                </td>
                {* <td width="1%"></td> *}
                <td width="34%" align="right">
                    <table class="bordered" cellpadding="3">
                        <thead>
                            <tr>
                                <td align="center"><b>Particulars</b></td>
                                <td align="center"><b>Amount</b></td>
                            </tr>
                        </thead>
                        <tbody>
                            {* {$transactionAmount = 0} *}
                            {$deliveryHandlingAmount = 0}
                            {$totalHandlingAmount =0}
                            {$totalUnloadHandlingAmount=0}
                            {$totalAmount=0}
                            {$paymentAmount=0}
                            {$pass_charge =0}
                            {$Docket_charge =0}
                            {$Delivery_charge =0}
                            {$totalAddonsValue = 0} 
                            {foreach from=$summary->cargoTransactionList item=$row}
                                {if $row->user->code == $usr_login_id || $namespace == 'ktwoklogistics'}
                                    {if $row->transactionType->code == 'CGCA'}
                                        {if $summary->deliveryHandlingAmount > 0}
                                            {$deliveryHandlingAmount = $deliveryHandlingAmount - $summary->deliveryHandlingAmount}
                                        {/if}
                                        {if $summary->totalHandlingAmount > 0}
                                            {$totalHandlingAmount= $totalHandlingAmount - $summary->totalHandlingAmount}
                                        {/if}
                                        {if $summary->totalUnloadHandlingAmount >0}
                                            {$totalUnloadHandlingAmount = $totalUnloadHandlingAmount - $summary->totalUnloadHandlingAmount}
                                        {/if}

                                    {else}
                                        {if $summary->deliveryHandlingAmount > 0}
                                            {$deliveryHandlingAmount = $deliveryHandlingAmount + $summary->deliveryHandlingAmount}
                                        {/if}

                                        {if $summary->totalHandlingAmount > 0}
                                            {$totalHandlingAmount= $totalHandlingAmount + $summary->totalHandlingAmount}
                                        {/if}

                                        {if $summary->totalUnloadHandlingAmount > 0}
                                            {$totalUnloadHandlingAmount = $totalUnloadHandlingAmount + $summary->totalUnloadHandlingAmount}
                                        {/if}

                                        {if $summary->passCharge > 0}
                                            {$pass_charge = $pass_charge + $summary->passCharge}
                                        {/if}

                                        {if $summary->docketCharge > 0}
                                            {$Docket_charge = $Docket_charge + $summary->docketCharge}
                                        {/if}

                                        {if $summary->deliveryHandlingAmount > 0}
                                            {$Delivery_charge = $Delivery_charge + $summary->deliveryHandlingAmount}
                                        {/if}

                                        {if $summary->totalAmount > 0}
                                            {$totalAmount = $totalAmount + $summary->totalAmount}
                                        {/if}
                                        {if $summary->paymentAmount}
                                            {$paymentAmount = $paymentAmount + $summary->paymentAmount}
                                        {/if}
                                    {/if}
                                {/if}
                            {/foreach}
                            <tr>
                                <td align="left">Freight</td>
                                <td align="right">{$totalAmount|inr_format}</td>
                            </tr>
                            <tr>
                                <td align="left">Loading Charge</td>
                                <td align="right">{$totalHandlingAmount|inr_format}</td>
                            </tr>
                            <tr>
                                <td align="left">Pass Charge</td>
                                <td align="right">{$pass_charge|inr_format}</td>
                            </tr>
                            <tr>
                                <td align="left">Docket Charge</td>
                                <td align="right">{$Docket_charge|inr_format}</td>
                            </tr>
                            <tr>
                                <td align="left">Delivery Charge</td>
                                <td align="right">
                                {assign var="found" value=false}
                                {foreach from=$summary->cargoAddonsDetails item=addonstype}
                                    {if $addonstype->addonsType->code == 'DYCH'}
                                        {$addonstype->value|inr_format}
                                        {$totalAddonsValue = $totalAddonsValue + $addonstype->value} 
                                        {assign var="found" value=true}
                                        {break}
                                    {/if}
                                {/foreach}
                                {if !$found}
                                    0.00
                                {/if}
                            </td>
                            
                            </tr>
                            <tr>
                                <td align="left">Unloading Charge</td>
                                <td align="right">{$totalUnloadHandlingAmount|inr_format}</td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td align="left"><b>Total</b></td>
                                <td align="right"><b>{($paymentAmount + $totalAddonsValue)|inr_format}</b></td>
                            </tr>
                        </tfoot>
                    </table>
                </td>
            </tr>
        </table>
        <br>

        <br>
        <table class="bordered" cellpadding="3">
            <tr>
                <td align="center">Recipient Signature <br><br><br></td>
                <td align="center">Delivery Person Signature <br><br><br></td>
            </tr>
        </table>

        <br>
        <br>
        <table width="100%" cellpadding="1">
            <tr class="success">
                <td align="right" style="font-size:7px;">Powered by www.ezeecargo.com</td>
            </tr>
        </table>

        {if $i != $print_count}
            <br>
            <div class="h-seperator"></div><br/>
            <br>
        {/if}
    {/for}
{/strip}