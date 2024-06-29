<html>

<head>
    <title>Out For Delivery Chart</title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    <style>
        .title { font-weight:bold; text-align: center; }
        .bold { font-weight:bold; }
        .bolder { font-weight: 900; }
        .border-top { border-top: 1px solid #000;}
        .bordered td{ border:1px solid #000;}
        .border-bottom { border-bottom: 1px solid #000;}
        .dotted-border-bottom { border-bottom: 1px dashed #000;}
        .border-outline { border: 1px solid #000;}
    </style>
</head>
<body>
{strip}
    <table class="border-outline" style="padding:5px 4px;">
        <tr>
            <td colspan="3" align="center">
                <img src="assets/img/Seenu-Cargo-header.jpg" alt="logo">
            </td>
        </tr>
        <tr class="bold">
            <td>
                GSTIN NO:33AAUCS4702J1Z3
            </td>
            <td align="center" style="font-weight:bold;font-size: 12px;">
                Cash Receipt
            </td>
            <td align="right">
                PAN NO:AAUCS4702J
            </td>
        </tr>
    </table>

    <table class="border-outline" style="padding:5px 4px;">
        <tr>
            <td align="left" style="width: 72%;"><b>Receipt No : </b> {$result->code}</td>
            <td align="left" style="width: 28%;">
                <b>Date : </b> {$result->transactionDate|date_format:$ns_date_format}
            </td>
        </tr>
        <tr>
            <td>
                <b>Received with thanks from : </b> 
                {if $result->cargoCustomer->code}
                    {$result->cargoCustomer->name}
                {elseif $result->cargoVendor->code}
                    {$result->cargoVendor->companyName}
                {else}
                    -
                {/if}
            </td>
            <td>
                <b>Contact Person : </b> 
                {* {if $result->createdUser->code}
                    {$result->createdUser->name}
                {else}
                    -
                {/if} *}
            </td>
        </tr>
        <tr>
            <td colspan="2"><b>address : </b>{$result->cargoCustomer->customerAddress->address1}, {$result->cargoCustomer->customerAddress->address2} - {$result->cargoCustomer->customerAddress->pincode}</td>
        </tr>
        <tr>
            <td colspan="2" class="border-top"><b>The Sum of Rupees : </b> {($result->transactionAmount + $result->machineHandlingCharge + $result->demurrageCharge)|amount_in_words|ucwords}</td>
        </tr>
    </table>

    <table style="padding:5px 0px;">
        <tr>
            <td width="80%">
                <table class="border-outline" style="padding:5px 4px;">
                    <tr>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td class="bold">Freight on W/B No.</td>
                        <td class="dotted-border-bottom">{$result->cargoBookings[0]->code}</td>
                        <td class="bold">Date</td>
                        <td class="dotted-border-bottom">{$result->cargoBookings[0]->bookedAt|date_format:$ns_date_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">No. of Days</td>
                        <td class="dotted-border-bottom">
                            {if $result->demurrageCharge > 0}
                                10
                            {/if}
                        </td>
                        <td class="bold">Demurrage Charge</td>
                        <td class="dotted-border-bottom">{$result->demurrageCharge|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Add Other Charges</td>
                        <td class="dotted-border-bottom" colspan="3">{$result->machineHandlingCharge|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Less Other Charges</td>
                        <td class="dotted-border-bottom" colspan="3"></td>
                    </tr>
                    <tr>
                        <td class="bold">TDS LESS AMOUNT</td>
                        <td class="dotted-border-bottom" colspan="3">{$result->tdsAmount|inr_format}</td>
                    </tr>
                    <tr>
                        <td align="right" colspan="4" class="bold">Total</td>
                    </tr>
                </table>
            </td>
            <td width="20%">
                <table class="bordered" style="padding:5px 4px;">
                    <tr class="bold">
                        <td colspan="2" align="center">Amount</td>
                    </tr>
                    <tr class="bold">
                        <td align="center">Rs.</td>
                        <td align="center">P.</td>
                    </tr>
                    <tr>
                        <td align="right">{($result->transactionAmount + $result->tdsAmount)|amountToRupeesPaise:'RUPEES'}</td>
                        <td align="right">{($result->transactionAmount + $result->tdsAmount)|amountToRupeesPaise:'PAISE'}</td>
                    </tr>
                    <tr>
                        <td align="right">{$result->demurrageCharge|amountToRupeesPaise:'RUPEES'}</td>
                        <td align="right">{$result->demurrageCharge|amountToRupeesPaise:'PAISE'}</td>
                    </tr>
                    <tr>
                        <td align="right">{$result->machineHandlingCharge|amountToRupeesPaise:'RUPEES'}</td>
                        <td align="right">{$result->machineHandlingCharge|amountToRupeesPaise:'PAISE'}</td>
                    </tr>
                    <tr>
                        <td align="right">00</td>
                        <td align="right">00</td>
                    </tr>
                    <tr>
                        <td align="right">{$result->tdsAmount|amountToRupeesPaise:'RUPEES'}</td>
                        <td align="right">{$result->tdsAmount|amountToRupeesPaise:'PAISE'}</td>
                    </tr>
                    <tr>
                        {assign var="total_amt" value=$result->transactionAmount + $result->machineHandlingCharge + $result->demurrageCharge}
                        <td align="right">{$total_amt|amountToRupeesPaise:'RUPEES'}</td>
                        <td align="right">{$total_amt|amountToRupeesPaise:'PAISE'}</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    
    <table class="border-outline" style="padding:5px 4px;">
        <tr>
            <td><b>Bank Name : </b></td>
            <td colspan="3">
                {if isNotNull($result->bankDetails->code)}
                    {$result->bankDetails->name}
                {elseif isNotNull($result->chequeDetails->code)}
                    {$result->chequeDetails->bankDetails}
                {else}
                    -
                {/if}
            </td>
        </tr>
        <tr>
            <td><b>Reference No : </b></td>
            <td>
                {if isNotNull($result->bankDetails->code)}
                    {$result->bankDetails->referenceCode}
                {else}
                    -
                {/if}
            </td>
            <td><b>Reference Date : </b></td>
            <td>-</td>
        </tr>
        <tr>
            <td><b>Remarks : </b></td>
            <td colspan="3">{$result->remarks|default:'-'}</td>
        </tr>
    </table>
    
    <table class="bordered" style="padding:5px 4px;">
        <thead>
            <tr class="bold">
                <td>LR No</td>
                <td>LR Date</td>
                <td>Consignor</td>
                <td>Consignee</td>
                <td>From</td>
                <td>To</td>
                <td>Mode Of Payment</td>
                <td>Handling Charges</td>
                <td>DD Amt</td>
                <td>Total</td>
            </tr>
        </thead>
        <tbody>
            {foreach from=$result->cargoBookings item=row}
                <tr>
                    <td>{$row->code}</td>
                    <td>{$row->bookedAt|date_format:$ns_date_format}</td>
                    <td>{$row->fromCustomer->name}</td>
                    <td>{$row->toCustomer->name}</td>
                    <td>{$row->fromOrganization->name}</td>
                    <td>{$row->toOrganization->name}</td>
                    <td>{$result->transactionMode->name}</td>
                    <td>{$row->hamaliCharge|inr_format}</td>
                    <td>{$row->deliveryHandlingAmount|inr_format}</td>
                    
                    
                    {$addons_mapped = array()}
                    {foreach $row->cargoAddonsDetails item=val}
                        {$addons_mapped[$val->addonsType->code] = $val}
                    {/foreach}
                    {assign var="other_charge" value=$row->deliveryHandlingAmount + $row->pickupHandlingAmount + $row->hamaliCharge + $row->passCharge + $row->docketCharge + $row->totalHandlingAmount + $row->totalUnloadHandlingAmount + $row->serviceTax + $row->serviceCharge + $addons_mapped['PODCH'] + $addons_mapped['DMRCH'] + $addons_mapped['RNDF'] + $addons_mapped['INSUR'] + $addons_mapped['ADJSMT'] + $addons_mapped['MCNHCH']}
                    <td>{($row->totalAmount + $other_charge)|inr_format}</td>
                </tr>
            {/foreach}
        </tbody>
    </table>

    <table class="border-outline" style="padding:5px 4px;"> 
        <tr>
            <td colspan="2"><br><br><br><br><br></td>
        </tr>
        <tr class="bold">
            <td>Received the goods in good condition</td>
            <td align="right">For <span style="font-size: 12px;">Seenu Transports Pvt Ltd.</span></td>
        </tr>
    </table>

    <table class="border-outline" cellpadding="3" width="100%">
        <tr class="bold">
            <td width="40%"></td>
            <td align="right" width="30%">Printed By : {$usr_login_name}</td>
            <td align="right" width="30%">Printed At : {$smarty.now|date_format:$ns_datetime_format}</td>
        </tr>
    </table>
{/strip}
</body>
</html>