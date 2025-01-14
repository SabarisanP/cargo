<style>
    .bold {
        font-weight: bold;
    }

    .bordered,
    .bordered tr th,
    .bordered tr td {
        border: 1px solid #000000;
    }

    .title {
        font-weight: bold;
        text-align: center;
    }

    .bold {
        font-weight: bold;
    }

    .bolder {
        font-weight: 900;
    }

    .border-top {
        border-top: 1px solid #000;
    }

    .bordered td {
        border: 1px solid #000;
    }

    .border-bottom {
        border-bottom: 1px solid #000;
    }

    .dotted-border-bottom {
        border-bottom: 1px dashed #000;
    }

    .border-outline {
        border: 1px solid #000;
    }

    #tab-1,
    #tab-2 {
        table-layout: fixed;
        width: 100%;
    }

    .h-seperator {
        border-bottom: 1px dashed #666;
        height: 0px;
    }

</style>
{strip}
     {for $iter=1 to $no_of_copy} 
    {assign var=transactionAmount value=0}
    {assign var= extraCharges  value = false}
    {foreach $ReceiptLr[0]->cargoTransactionList as $SinglrList   }
    {if $SinglrList->additionalAttribute->TRANSACTION_RECEIPT == $result->code && $SinglrList->transactionType->code == "MCHC"} 
        {assign var=transactionAmount value= $transactionAmount + $SinglrList->transactionAmount}
        {assign var = extraCharges value = true}
    {/if} 
    {/foreach}



<table class="border-outline" width="100%" cellspacing="0" cellpadding="0">
    <tr class="bold">
        <td width="25%" align="right"><br><br><br>
            &nbsp;<img src="assets/img/seenutransports-logo.png" alt="logo" width="150px">
        </td>
        <td align="center" width="75%">
            <h2 style="font-size: 20px;"> Seenu Transports Pvt.Ltd. </h2>
            <p style="font-size: 8px;"><b>Booking Branch : </b> <span style="font-size: 8px;color: #333232;">{if isNotNull ($summary)}{$summary[0]->fromOrganization->address1},{$summary[0]->fromOrganization->address2}{if isNotNull($summary[0]->fromOrganization->contact)} ,Ph :{$summary[0]->fromOrganization->contact}{/if}{else}-{/if}</span></p>
            <p style="font-size: 8px;"><b>Delivery Branch : </b> <span style="font-size: 8px;color: #333232;">{if isNotNull ($summary)}{$summary[0]->toOrganization->address1},{$summary[0]->toOrganization->address2}{if isNotNull($summary[0]->toOrganization->contact)} ,Ph :{$summary[0]->toOrganization->contact}{/if}{else}-{/if}</span></p> <br>
        </td>
    </tr>
</table>

<table class="bordered" cellpadding="2">
    <tr style="background-color: #E8E8E8;">
        <td align="center" class="bold" style="font-size: 12px;" colspan="8">TAX INVOICE / CASH RECEIPT</td>
    </tr>
    <tr>
        <td colspan="4"><b>Invoice No :</b>&nbsp;{$result->code}</td>
        <td colspan="4"><b>Invoice Date :</b>&nbsp;{$result->transactionDate|date_format:"d-m-Y"}</td>
    </tr>
    <tr>
        <td colspan="4"><b>GSTIN :</b> {$deliveryBranchGstCode->gstin}</td>
        <td colspan="4"></td>
    </tr>
    <tr>
        <td class="bold"><b>State</b></td>
        <td>{$deliveryBranchGstCode->name}</td>
        <td class="bold"><b>Code</b></td>
        <td>
            {$deliveryBranchGstCode->gstin|substr:0:2}
        </td>
        <td colspan="4"><b>SAC Code :</b>&nbsp;996511</td>
    </tr>

    <tr style="background-color: #E8E8E8;">
        <td align="center" class="bold" colspan="4">Billed To Party</td>
        <td align="center" class="bold" colspan="4">Shipped To Party</td>
    </tr>
    <tr>
        <td colspan="4"><b>Name :</b> {$ReceiptLr[0]->toCustomer->name|default:'-'}</td>
        <td colspan="4">
            <b>Name :</b> {$ReceiptLr[0]->toCustomer->name|default:'-'}
        </td>
    </tr>
    <tr>
        <td colspan="4"><b>Address :</b> {$ReceiptLr[0]->toCustomerAddress->address1}, {$ReceiptLr[0]->toCustomerAddress->address2},{$ReceiptLr[0]->toCustomerAddress->pincode}</td>
        <td colspan="4"><b>Address :</b> {$ReceiptLr[0]->toCustomerAddress->address1}, {$ReceiptLr[0]->toCustomerAddress->address2},{$ReceiptLr[0]->toCustomerAddress->pincode}</td>
    </tr>
    <tr>
        <td colspan="4"><b>GSTIN :</b> {$ReceiptLr[0]->toCustomerGST|default:'-'}</td>
        <td colspan="4"><b>GSTIN :</b> {$ReceiptLr[0]->toCustomerGST|default:'-'}</td>
    </tr>
    <tr>
        <td class="bold"><b>State</b></td>
        <td>{$gst_state[$ReceiptLr[0]->toCustomerGST|substr:0:2]|default:'-'}</td>
        <td class="bold"><b>Code</b></td>
        <td>{$ReceiptLr[0]->toCustomerGST|substr:0:2|default:'-'}</td>
        <td class="bold"><b>State</b></td>
        <td>{$gst_state[$ReceiptLr[0]->toCustomerGST|substr:0:2]|default:'-'}</td>
        <td class="bold"><b>Code</b></td>
        <td>{$ReceiptLr[0]->toCustomerGST|substr:0:2|default:'-'}</td>
    </tr>
</table>
<br />
<br />

<table class="bordered" cellpadding="2" id="tab-2" width="100%">
    <thead>
        <tr style="font-weight:bold; background-color: #E8E8E8;">
            <th align="center" width="8%" rowspan="2">Sl No</th>
            <th align="center" width="16%" rowspan="2" nowrap>{lang('lr')} No</th>
            <th align="center" width="12%" rowspan="2">LR Date</th>
            <th align="center" width="12%" rowspan="2">{lang('booking_from_term')}</th>
            <th align="center" width="12%" rowspan="2">{lang('booking_to_label')}</th>
            <th align="center" width="16%" rowspan="2">Mode of Payment</th>
            <th align="center" width="12%" rowspan="2">Amt.</th>
            <th align="center" width="12%" rowspan="2">Total Amt.</th>
        </tr>
    </thead>
    {assign var=total value=0}
    {assign var=total_amt value=0}
    {assign var=total_lr_amt value=0}
    {assign var=total_lr value=0}
    {assign var=k value=0}
    {assign var=lr_net_amount value=$lr_net_amount}
    {assign var=total_amts value=0}

    {foreach item=row  from=$ReceiptLr}
        {assign var=rounf_off_val value=0}
        {foreach item=keys  from=$row->cargoAddonsDetails}
            {if $keys->addonsType->code =="RNDF"}
                {assign var=rounf_off_val value=$rounf_off_val+$keys->value}
                {break}
            {/if}
        {/foreach}
        {assign var=lr_net_amount value=$lr_net_amount+($row->totalAmount+$row->totalHandlingAmount+$row->totalUnloadHandlingAmount+$row->docketCharge+$row->passCharge+$row->hamaliCharge+$row->pickupHandlingAmount+$row->deliveryHandlingAmount+$other_ch_amount)}
        {assign var=total_amts value=$total_amts+($row->paymentAmount)}
        <tr>
            <th align="center" width="8%">{$k+1}</th>
            <td align="left" width="16%" nowrap>{$row->code}</td>
            <td align="left" width="12%">{$row->bookedAt|date_format:"d-m-Y"}</td>
            <td align="left" width="12%">{$row->fromOrganization->shortCode}</td>
            <td align="left" width="12%">{$row->toOrganization->shortCode}</td>
            <td align="center" width="16%">{$cargo_payment_status[$row->paymentType->code]}</td>
            <td align="right" width="12%">{($row->deliveryHandlingAmount+$row->pickupHandlingAmount+$row->hamaliCharge+$row->passCharge+$row->docketCharge+$row->totalAmount+$row->totalHandlingAmount+$row->totalUnloadHandlingAmount)|amountToRupeesPaise:'RUPEES'}</td>
            <td align="right" width="12%">{($row->deliveryHandlingAmount+$row->pickupHandlingAmount+$row->hamaliCharge+$row->passCharge+$row->docketCharge+$row->totalAmount+$row->totalHandlingAmount+$row->totalUnloadHandlingAmount)|amountToRupeesPaise:'RUPEES'}</td>
        </tr>
        {assign var=total_lr_amt value=$total_lr_amt+($row->deliveryHandlingAmount+$row->pickupHandlingAmount+$row->hamaliCharge+$row->passCharge+$row->docketCharge+$row->totalAmount+$row->totalHandlingAmount+$row->totalUnloadHandlingAmount)}
       
        {assign var=k value=$k+1}
    {foreachelse}
        <tr>
            <td colspan="7" align="center" class="bordered">No Records Found!</td>
        </tr>
    {/foreach}
</table>
{assign var=net_total value=$net_total+($total_lr_amt+$result->machineHandlingCharge +$result->demurrageCharge+$rounf_off_val)}
{if ($result->cargoBookings[0]->paymentType->code== "PAD" ) && $extraCharges}
    {assign var=net_total value=0}
    {assign var=net_total value=(($net_total + $transactionAmount))}
{/if}
<table id="tab-1" style="border-top: 1px solid #000; border-bottom: 1px solid #000; border-left: 1px solid #000;" width="100%">
    <tr>
        <td colspan="5">
            <table style="padding:5px 4px;">
                <tr>
                    <td colspan="4"></td>
                </tr>
                <tr>
                    <td colspan="4"></td>
                </tr>
                <tr>
                    <td class="bold">Freight on W/B No.</td>
                    <td class="dotted-border-bottom blod"><b>{$result->cargoBookings[0]->code}</b></td>
                    <td class="bold" align="right">Date :</td>
                    <td class="dotted-border-bottom blod"><b>{$result->cargoBookings[0]->bookedAt|date_format:"d-m-Y"}</b></td>
                </tr>
                <tr>
                    <td class="bold">No. of Days</td>
                    <td class="dotted-border-bottom">
                        {if $result->demurrageCharge > 0}
                            10
                        {/if}
                    </td>
                    <td class="bold" align="right">Demurrage Charge :</td>
                    <td class="dotted-border-bottom">{$result->demurrageCharge|inr_format}</td>
                </tr>
                <tr>
                    <td class="bold">Add Other Charges</td>
                    {* {if ($result->cargoBookings[0]->paymentType->code== "PAD" && $transactionAmount != 0)}
                        <td class="dotted-border-bottom" colspan="1" align = "center">{$transactionAmount}</td>
                    <td class="dotted-border-bottom" colspan="2" align = "center">(Machine Handling Charge)</td>
                    {else} *}
                        {* <td class="dotted-border-bottom" colspan="3">{$result->machineHandlingCharge|inr_format}</td> *}
                        <td class="dotted-border-bottom" colspan="1" align = "center">{$result->machineHandlingCharge|inr_format}</td>
                    <td class="dotted-border-bottom" colspan="2" align = "left"><b>{if ($result->machineHandlingCharge>0 || $transactionAmount>0) }(Machine Handling Charge){/if}</b></td>
                    {* {/if} *}
                </tr>
                <tr>
                    <td class="bold">Less Other Charges</td>
                    <td class="dotted-border-bottom" colspan="3"></td>
                </tr>
                <tr>
                    <td class="bold">TDS LESS AMOUNT</td>
                    <td class="dotted-border-bottom blod" colspan="3"><b>{$result->tdsAmount|inr_format}</b></td>
                </tr>
                <tr>
                    <td class=" bold">TAXABLE VALUE :</td>
                    <td class=" bold dotted-border-bottom" align="center"> {($net_total)|inr_format}</td>
                    <td align="right" colspan="2" class="bold">Total</td>
                </tr>
                {if $deliveryBranchGstCode->state->code == $Gststate}
                    <tr>

                        <td align="right" colspan="4" class="bold">GST on CGST &nbsp;<b>(2.5%)</b></td>
                    </tr>
                    <tr>
                        <td align="right" colspan="4" class="bold">GST on SGST &nbsp;<b>(2.5%)</b></td>
                    </tr>
                {else}
                    <tr>
                        <td align="right" colspan="4" class="bold">GST on IGST <b>(5%)</b></td>
                    </tr>
                {/if}
                &nbsp; &nbsp; &nbsp; &nbsp;
            </table>
        </td>
        <td colspan="2">

            <table style="padding:5px 5px;" class="bordered">
                <tr class="bold">
                    <td colspan="2" align="center">Amount : {($result->cargoBookings[0]->paymentType->code == "PAD"  && $extraCharges) ? ($transactionAmount|amountToRupeesPaise:'RUPEES'):($total_lr_amt|amountToRupeesPaise:'RUPEES')}</td>
                </tr>
                <tr class="bold">
                    <td align="center">Rs.</td>
                    <td align="center">P.</td>
                </tr>
                <tr>
                <td align="right">{($result->cargoBookings[0]->paymentType->code == "PAD" && $extraCharges)?(0|amountToRupeesPaise:'RUPEES'):($total_lr_amt|amountToRupeesPaise:'RUPEES')}</td>
                <td align="right">{($result->cargoBookings[0]->paymentType->code == "PAD" && $extraCharges)?(0|amountToRupeesPaise:'RUPEES'):(($result->transactionAmount + $result->tdsAmount)|amountToRupeesPaise:'PAISE')}</td>
                </tr>
                <tr>
                    <td align="right">{$result->demurrageCharge|amountToRupeesPaise:'RUPEES'}</td>
                    <td align="right">{$result->demurrageCharge|amountToRupeesPaise:'PAISE'}</td>
                </tr>
                <tr>
                {* {if ($result->cargoBookings[0]->paymentType->code== "PAD" && $transactionAmount != 0)}
                    <td align="right">{$transactionAmount|amountToRupeesPaise:'RUPEES'}</td>
                    <td align="right">{$transactionAmount|amountToRupeesPaise:'PAISE'}</td>
                    {else} *}
                    <td align="right">{$result->machineHandlingCharge|amountToRupeesPaise:'RUPEES'}</td>
                    <td align="right">{$result->machineHandlingCharge|amountToRupeesPaise:'PAISE'}</td>
                    {* {/if} *}
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
                {if ($result->cargoBookings[0]->paymentType->code== "PAD"  &&  $extraCharges)}
                    <td align="right" class="bold" style="font-size: 9px;">{($result->cargoBookings[0]->paymentType->code== "PAD"  && $extraCharges)?(($net_total-$result->tdsAmount)|amountToRupeesPaise:'RUPEES'):($net_total|amountToRupeesPaise:'RUPEES')}</td>
                    <td align="right" class="bold" style="font-size: 9px;">{($result->cargoBookings[0]->paymentType->code== "PAD"  && $extraCharges)?(($net_total-$result->tdsAmount)|amountToRupeesPaise:'PAISE'):($net_total|amountToRupeesPaise:'PAISE')}</td> 

                    {else}
                    <td align="right" class="bold" style="font-size: 9px;">{($total_lr_amt+$result->machineHandlingCharge +$result->demurrageCharge+$rounf_off_val-$result->tdsAmount)|amountToRupeesPaise:'RUPEES'}</td>
                    <td align="right" class="bold" style="font-size: 9px;">{($total_lr_amt+$result->machineHandlingCharge +$result->demurrageCharge+$rounf_off_val-$result->tdsAmount)|amountToRupeesPaise:'PAISE'}</td>
                {/if}
                    </tr>

                {if $deliveryBranchGstCode->state->code == $Gststate}
                    <tr>
                        <td align="center" class="bold" style="font-size: 9px;" colspan="2"><b>{$net_total*2.5/100|number_format:2}</b></td>
                    </tr>
                    <tr>
                        <td align="center" class="bold" style="font-size: 9px;" colspan="2"><b>{$net_total*2.5/100|number_format:2}</b></td>
                    </tr>
                {else}
                    <tr>
                        <td align="center" colspan="2"><b>{$net_total*5/100|number_format:2}</b></td>
                    </tr>
                {/if}
            </table>
        </td>
    </tr>
</table>
<br />
<br />
{strip}
    <table>
        <tr>
            <td width="70%">
                <table style="padding:5px 4px;">
                    <tr>
                        <td colspan="3">Receipt No :&nbsp;<b>{$result->cargoBookings[0]->additionalAttribute->VOUCHER_NUMBER}</b></td>
                    </tr>
                    <tr>
                        <td colspan="3">Received From : &nbsp;<b>{$result->cargoCustomer->name}</b></td>
                        <td class=""></td>
                        <td class=""></td>
                        <td class=""></td>
                    </tr>
                    <tr>
                        <td class="" {if $result->transactionMode->code =="CASH"} width="50%" {/if} {if $result->transactionMode->code =="UPI"} width="70%" {/if} {if $result->transactionMode->code =="NBK"} width="70%" {/if} {if $result->transactionMode->code =="CHEQUE"} width="70%" {/if} class="bordered" colspan="3">Mode Of Payment : &nbsp;<b>{$result->transactionMode->name}</b> {if $result->transactionMode->code =="CHEQUE" }( Cheque No - {$result->chequeDetails->chequeNo} ) {/if} {if $result->transactionMode->code =="NBK" }( Ref No - {$result->addAttr3} ) {/if}{if $result->transactionMode->code =="UPI" }( UPI ID - {$result->addAttr1} ) {/if} </td>
                        <td class="" width="20%" align=""></td>
                        <td class="" width="30%"></td>
                        <td class="" width="10%"></td>
                    </tr>
                    {if $result->transactionMode->code =="NBK"}
                        <tr>
                            <td class="" colspan="3">Bank Name : <b>{$result->addAttr2}</b></td>
                            <td class=""></td>
                            <td class=""></td>
                            <td class=""></td>
                        </tr>
                    {/if}

                    {if $result->transactionMode->code =="CHEQUE"}
                        <tr>
                            <td class="" colspan="3">Bank Name :&nbsp;<b>{$result->chequeDetails->bankDetails} {$result->chequeDetails->bankCity}</b></td>
                            <td class=""></td>
                            <td class=""></td>
                            <td class=""></td>
                        </tr>
                    {/if}

                    {if $result->transactionMode->code =="CHEQUE"}
                        <tr>
                            <td class="" colspan="3">Dated : &nbsp;<b>{$result->chequeDetails->chequeDate|date_format:"d-m-Y"}</b></td>
                            <td class=""></td>
                            <td class=""></td>
                            <td class=""></td>
                        </tr>
                    {else}
                        <tr>
                            <td class="" colspan="3">Dated : &nbsp;<b>{$result->transactionDate|date_format:"d-m-Y"}</b></td>
                            <td class=""></td>
                            <td class=""></td>
                            <td class=""></td>
                        </tr>
                    {/if}
                    <tr>
                    {if ($result->cargoBookings[0]->paymentType->code== "PAD" ) &&  $extraCharges}
                        <td class="" colspan="5">Received Amount (Rs) :&nbsp;<b>{($net_total-$result->tdsAmount)|amountToRupeesPaise:'RUPEES'} / {($net_total-$result->tdsAmount)|amount_in_words|ucwords} Only </b></td>
                        {else}
                        <td class="" colspan="5">Received Amount (Rs) :&nbsp;<b>{($total_lr_amt+$result->machineHandlingCharge +$result->demurrageCharge+$rounf_off_val -$result->tdsAmount)|amountToRupeesPaise:'RUPEES'} / {($total_lr_amt+$result->machineHandlingCharge +$result->demurrageCharge-$result->tdsAmount)|amount_in_words|ucwords} Only </b></td>
                    {/if}
                        <td class=" blod " align="left"></td>
                        <td class=""></td>
                        <td class=""></td>
                    </tr>
                </table>
            </td>
            <td width="30%">
                <table>
                    <tr>
                        <td align="right">Date : </td>
                        <td align="left"><b>{$result->transactionDate|date_format:"d-m-Y"}</b></td>
                    </tr>
                </table><br><br>
                <table class="bordered" cellpadding="2">

                    <tr>
                        <td class="bold" style="font-size: 7px;">Ceritified that the particulars given above are true and correct</td>
                    </tr>
                    <tr>
                        <td align="center" class="bold" style="font-size: 9px;">For Seenu Transports Pvt Ltd.<br><br></td>
                    </tr>
                    <tr>
                        <td align="center" class="bold">Authorised Signatory</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <br> <br>
{/strip}
<table>
    <tr>
        <td width="100%">
            <table cellpadding="2" style="border:1px soild #000;">
                <tr>
                    <td class="bold" style="font-size: 7px;"> <b>Declaration for E-Invoicing Exemption:</b></td>
                </tr>
                <tr>
                    <td class="bold"> &nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size: 6px;">We hereby declare that the GSTIN: {$deliveryBranchGstCode->gstin} SEENU TRANSPORTS PVT LTD is exempt from preparing an invoice in terms of Rule 48(4) of CGST Rules 2017.</span></td>
                </tr>
                <tr>
                    <td class="bold" style="font-size: 7px;"> <b> Exemption Category :</b></td>
                </tr>
                <tr>
                    <td class="bold"> &nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size: 6px;"> Goods Transport Agency supplying services in relation to transportation of goods by road in a goods carriage (13/2020-Central Tax dated 21st march 2020) </span></td>
                </tr>
                <tr>
                    <td class="bold" style="font-size: 7px;"> &nbsp;&nbsp;&nbsp;&nbsp;<b>Note :</b> TDS Applicable @2% U/S 194C of I.T act</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<br><br><br><br><br><br><br><br><br><br><br><br><br>
{/for}