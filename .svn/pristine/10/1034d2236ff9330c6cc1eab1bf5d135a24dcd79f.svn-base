<style>
    .bold {
        font-weight: bold;
    }

    .bordered,
    .bordered tr th,
    .bordered tr td {
        border: 1px solid #000000;
    }

    .content:last-child {
        margin-top: 0;
    }

    @media print {

        /* Avoid page break inside content */
        .content {
            page-break-after: always;
        }

    }

    table {
        font-size: 8px;
    }
</style>
{* printStatus *}
{if $printStatus=="ALL"}
    {assign var="loopCount" value=3}
{else}
    {assign var="loopCount" value=1}
{/if}
{for $i=1 to $loopCount}
    {strip}
        <div {if  $printStatus=="ALL"} class="content" {/if}>
            {strip}

                <table class="bordered" width="100%" cellpadding="7">
                    <tr class="bold">
                        <td width="25%" align="center" style="border:none">
                            &nbsp;<img src="assets/img/seenutransports-logo.png" alt="logo" width="150px">
                            <br>
                            {if $printStatus=="ALL"}
                                {if $i==1}
                                    <p style="font-size: 10px;">Original for Receipient</p>
                                {/if}
                                {if $i==2}
                                    <p style="font-size: 10px;">Duplicate Copy</p>
                                {/if}
                                {if $i==3}
                                    <p style="font-size: 10px;">Triplicate Copy</p>
                                {/if}
                            {/if}
                            {if $printStatus=="ORIGINAL"}
                                <p style="font-size: 10px;">Original for Receipient</p>
                            {/if}
                            {if $printStatus=="DUPLICATE"}
                                <p style="font-size: 10px;">Duplicate Copy</p>
                            {/if}
                            {if $printStatus=="TRIPLICATE"}
                                <p style="font-size: 10px;">Triplicate Copy</p>
                            {/if}
                        </td>
                        <td align="center" width="75%" style="font-size: 17px; border: none;">
                            <h2 style="font-size: 17px; "> Seenu Transports Pvt.Ltd. </h2>
                            <p style="font-size: 8px;">Booking Branch : <span style="font-size: 8px;color: #333232;">{$from_address1}{if isNotNull($from_address2)},{$from_address2}{/if}{if isNotNull($contact)},Ph :{$contact} {/if}</span></p>

                        </td>
                    </tr>
                </table>
            {/strip}
            <table class="bordered" cellpadding="2">
                <tr style="background-color: #E8E8E8;">
                    <td align="center" class="bold" style="font-size: 12px;" colspan="8">TAX INVOICE </td>
                </tr>
                <tr>
                    <td colspan="4"><b>Invoice No :&nbsp;{$details->code}</b></td>
                    <td colspan="4"><b>Invoice Date :&nbsp;{$details->transactionDate|date_format:$ns_date_format}</b></td>
                </tr>
                <tr>
                    <td colspan="4"><b>GSTIN :</b>
                        {$deliveryBranchGstCode->gstin}
                    </td>
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
                    <td colspan="4"><b>Name :</b> {$details->vendorBillingAddress->name|default:'-'}</td>
                    <td colspan="4">
                        <b>Name :</b>
                        {if isNotNull($summary) && $summary->paymentType->code == 'INP'}
                            {if isNotNull($summary->fromCustomerAddress->code)}
                                {$summary->fromCustomerAddress->name}
                            {/if}
                        {elseif isNotNull($summary) && $summary->paymentType->code == 'OATP'}
                            {if isNotNull($summary->toCustomerAddress->code)}
                                {$summary->toCustomerAddress->name}
                            {/if}
                        {/if}
                    </td>
                </tr>
                <tr>
                    <td colspan="4"><b>Address :</b>
                        {if isNotNull($details->vendorBillingAddress->address1)}{$details->vendorBillingAddress->address1},
                            {$details->vendorBillingAddress->address2}<br>{$details->vendorBillingAddress->landmark},
                        {$details->vendorBillingAddress->station->name} - {$details->vendorBillingAddress->pincode}{else} -
                        {/if}
                    </td>
                    <td colspan="4">
                        <b>Address :</b>
                        {if isNotNull($summary) && $summary->paymentType->code == 'INP'}
                            {if isNotNull($summary->fromCustomerAddress->code)}
                                {$summary->fromCustomerAddress->address1}{$summary->fromCustomerAddress->address2}<br>
                                {$summary->fromCustomerAddress->landmark},
                                {$summary->fromCustomerAddress->station->name} - {$summary->fromCustomerAddress->pincode}
                            {/if}
                        {elseif isNotNull($summary) && $summary->paymentType->code == 'OATP'}
                            {if isNotNull($summary->toCustomerAddress->code)}
                                {$summary->toCustomerAddress->address1}{$summary->fromCustomerAddress->address2}<br>
                                {$summary->toCustomerAddress->landmark},
                                {$summary->toCustomerAddress->station->name} - {$summary->toCustomerAddress->pincode}
                            {/if}
                        {/if}
                    </td>
                </tr>
                <tr>
                    <td colspan="4"> <b>GSTIN :</b>
                        {if isNotNull($summary) && $summary->paymentType->code == 'INP'}
                            {$summary->fromCustomerGST|default:'-'}
                        {elseif isNotNull($summary) && $summary->paymentType->code == 'OATP'}
                            {$summary->toCustomerGST|default:'-'}
                        {/if}</td>
                    <td colspan="4">
                        <b>GSTIN :</b>
                        {if isNotNull($summary) && $summary->paymentType->code == 'INP'}
                            {$summary->fromCustomerGST|default:'-'}
                        {elseif isNotNull($summary) && $summary->paymentType->code == 'OATP'}
                            {$summary->toCustomerGST|default:'-'}
                        {/if}
                    </td>
                </tr>
                <tr>
                    <td class="bold"><b>State</b></td>
                    <td>
                        {if isNotNull($summary) && $summary->paymentType->code == 'INP'}
                            {$get_gst_state[$summary->fromCustomerGST|substr:0:2]|default:'-'}
                        {elseif isNotNull($summary) && $summary->paymentType->code == 'OATP'}
                            {$get_gst_state[$summary->toCustomerGST|substr:0:2]|default:'-'}
                        {/if}
                    </td>



                    <td class="bold"><b>Code</b></td>
                    <td>
                        {if isNotNull($summary) && $summary->paymentType->code == 'INP'}
                            {$summary->fromCustomerGST|substr:0:2|default:'-'}
                        {elseif isNotNull($summary) && $summary->paymentType->code == 'OATP'}
                            {$summary->toCustomerGST|substr:0:2|default:'-'}
                        {/if}

                    </td>
                    <td class="bold"><b>State</b></td>
                    <td>
                        {if isNotNull($summary) && $summary->paymentType->code == 'INP'}
                            {$get_gst_state[$summary->fromCustomerGST|substr:0:2]|default:'-'}
                        {elseif isNotNull($summary) && $summary->paymentType->code == 'OATP'}
                            {$get_gst_state[$summary->toCustomerGST|substr:0:2]|default:'-'}
                        {/if}
                    </td>

                    <td class="bold"><b>Code</b></td>
                    <td> {if isNotNull($summary) && $summary->paymentType->code == 'INP'}
                            {$summary->fromCustomerGST|substr:0:2|default:'-'}
                        {elseif isNotNull($summary) && $summary->paymentType->code == 'OATP'}
                            {$summary->toCustomerGST|substr:0:2|default:'-'}
                        {/if}</td>
                </tr>
            </table>
            <table class="bordered" cellpadding="2" width="100%">
                <thead>
                    <tr>
                        <th align="center" colspan="8">
                            <b> Transport Charges</b>
                        </th>
                    </tr>
                    <tr style="font-weight:bold; background-color: #E8E8E8;">
                        <th align="center" width="6%" rowspan="2">Sl No</th>
                        <th align="center" width="16%" rowspan="2">{lang('lr')} No</th>
                        <th align="center" width="10%" rowspan="2">LR Date</th>
                        <th align="center" width="14%" rowspan="2">{lang('booking_from_term')}</th>
                        <th align="center" width="13%" rowspan="2">{lang('booking_to_label')}</th>
                        <th align="center" width="16%" rowspan="2">Mode of Payment</th>
                        <th align="center" width="15%" rowspan="2">Amt.</th>
                        <th align="center" width="10%" rowspan="2">Total Amt.</th>
                    </tr>
                </thead>
                {assign var=total value=0}
                {assign var=total_amt value=0}
                {assign var=total_lr value=0}
                {foreach item=row key=k from=$result}
                    <tr>
                        <th align="center" width="6%">{$k+1}</th>
                        <td align="left" width="16%">{$row->cargo_code}</td>
                        <td align="left" width="10%">{$row->booked_at|date_format:$ns_date_format}</td>
                        <td align="left" width="14%">{$row->from_organization_name}</td>
                        <td align="left" width="13%">{$row->to_organization_name}</td>
                        <td align="left" width="16%">{$cargo_payment_status[$row->payment_status_code]}</td>
                        <td align="right" width="15%">{($row->transaction_amount-$row->commission_amount)|inr_format}</td>
                        <td align="right" width="10%">{($row->transaction_amount-$row->commission_amount)|inr_format}</td>
                    </tr>
                    {assign var=total_amt value=$total_amt+($row->total_amount)}
                    {assign var=total value=$total+($row->transaction_amount-$row->commission_amount)}
                    {assign var=total_lr value=$k+1}
                {foreachelse}
                    <tr>
                        <td colspan="12" align="center" class="bordered">No Records Found!</td>
                    </tr>
                {/foreach}
                <tr class="bold">
                    <td align="right" width="75%" colspan="5">Total</td>
                    <td align="right" width="15%">{$total|inr_format}</td>
                    <td align="right" width="10%">{$total|inr_format}</td>
                </tr>

                <tr>
                    <td align="left" rowspan="6" colspan="5"><b>Amount In Words :</b>&nbsp;{$total|amount_in_words|ucwords}<br><br><br><br><b>Enclosed by: </b>{$total_lr}</td>
                    <td align="left" class="bold">Total Amount</td>
                    <td align="right" class="bold">{$total|inr_format}</td>
                </tr>

                <tr>
                    <td align="left" class="bold">ROUNDED OFF</td>
                    <td align="right" class="bold">0.00</td>
                </tr>
                {if $deliveryBranchGstCodes->state->code == $Gststate}
                    <tr>
                        <td align="left" class="bold">CGST (2.5%)</td>
                        <td align="right" class="bold"><b>{$total*2.5/100|inr_format}</b></td>
                    </tr>
                    <tr>
                        <td align="left" class="bold">SGST (2.5%)</td>
                        <td align="right" class="bold"><b>{$total*2.5/100|inr_format}</b></td>
                    </tr>
                {else}
                    <tr>
                        <td align="left" class="bold">IGST (5%)</td>
                        <td align="right" class="bold"><b>{$total*5/100|inr_format}</b></td>
                    </tr>
                {/if}
                <tr>
                    <td align="left" class="bold">GST on Reverse Charge</td>
                    <td align="right" class="bold">{if isNotNull($details->namespaceTax->gstin)}YES{else}YES{/if}</td>
                </tr>
            </table>
            <br />
            <br />
            {strip}
                <table width="100%">
                    <tr>
                        <td align="center" width="40%">
                            <table class="bordered" cellpadding="2">
                                <tr style="background-color: #E8E8E8;">
                                    <td align="center" class="bold" style="font-size: 10px;">Bank Details</td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <b>Bank Name :</b>&nbsp;{if $bank_detail|count > 0}{$bank_detail[0]->bankName}{/if}
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <b>Bank A/C :</b>&nbsp;{if $bank_detail|count > 0}{$bank_detail[0]->accountNumber}{/if}
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <b>Bank IFSC :</b>&nbsp;{if $bank_detail|count > 0}{$bank_detail[0]->ifscCode}{/if}
                                    </td>
                                </tr>
                            </table>
                        </td>


                        <td width="20%"></td>

                        <td width="40%">
                            <table class="bordered" cellpadding="2">
                                <tr>
                                    <td class="bold" style="font-size: 7px;">Ceritified that the particulars given above are true and
                                        correct</td>
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
                    <tr>
                        <td align="center" class="bold">Terms & Conditions</td>
                        <td align="center" class="bold">Common Seal</td>
                        <td align="center" class="bold">{$username} ({$smarty.now|date_format:$ns_datetime_format})</td>
                    </tr>
                    <tr>
                        <td align="center" width="40%">
                            <table class="bordered" cellpadding="2">
                                <tr style="background-color: #E8E8E8;">
                                    <td align="center" class="bold" style="font-size: 10px;">For any further information, Kindly
                                        Contact:</td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <b>Contact Person :</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <b>Contact No :</b>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <br><br>

            {/strip}
            <br>
            <table>
                <tr>

                    <td width="100%">
                        <table cellpadding="2" style="border:1px soild #000;">
                            <tr>
                                <td class="bold" style="font-size: 7px;"> <b>Declaration for E-Invoicing Exemption:</b></td>
                            </tr>
                            <tr>
                                <td class="bold" style="font-size: 7px;"> &nbsp;&nbsp;&nbsp;&nbsp; We hereby declare that the GSTIN: {$deliveryBranchGstCode->gstin} SEENU TRANSPORTS PVT LTD is exempt from preparing an invoice in terms of Rule 48(4) of CGST Rules 2017.</td>
                            </tr>
                            <tr>
                                <td class="bold" style="font-size: 7px;"> <b> Exemption Category :</b></td>
                            </tr>
                            <tr>
                                <td class="bold" style="font-size: 7px;"> &nbsp;&nbsp;&nbsp;&nbsp; Goods Transport Agency supplying services in relation to transportation of goods by road in a goods carriage (13/2020-Central Tax dated 21st march 2020)</td>
                            </tr>
                            <tr>
                                <td class="bold" style="font-size: 7px;"> &nbsp;&nbsp;&nbsp;&nbsp;<b>Note :</b> TDS Applicable @2% U/S 194C of I.T act</td>
                            </tr>
                        </table>
                    </td>
                    {* <td width="20%"></td> *}
                </tr>
            </table>
        </div>
    {/strip}
{/for}