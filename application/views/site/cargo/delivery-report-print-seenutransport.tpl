<div class="print-border"></div>
<div class="print-border-left"></div>
<div class="print-border-right"></div>

<div class="print-header">
    <table border="2" cellpadding="2" width="101%">
        <tr>
            <td colspan="12">
                <img align="left" style="margin-left: 20px;margin-top:30px;"
                    src="{$base_url}/assets/img/seenutransports-logo.png" alt="logo" width="150px">
                <h1 align="center">Seenu Transports Pvt Ltd</h1>
                {if $organizationDetails}
                    <p style="margin:0;font-weight:300" align="center">{$organizationDetails[0]->address1}{$organizationDetails[0]->station->name}-{$organizationDetails[0]->pincode} Phone: No: {$organizationDetails[0]->contact}</p>
                    {else}
                <p align="center">Regd.off : No: 4D8/ 9, 3rd Main Road Industrial Estate, Ambattur, Chennai- 600058.
                    Phone:
                    No:
                    044-26524098 / 26524016, 9380279073</p>
                    {/if}
                <h3 align="center">Delivery Ledger Report</h3>
            </td>
        </tr>
    </table>
</div>
<table width="100%" style="line-height: 20px;" class="first_page">
    <tr style="border: none;">
    {foreach $ogplcargo as $row}
        {if  $row->toOrganization->code == $ogplDetails->to_organization_code && $row->fromOrganization->code == $ogplDetails->from_organization_code}
    <td colspan="3" border="0">Unloading Person: {$row->toOrganizationContact->name|default:'-'}
        </td>
    {break}
        {/if}
    {/foreach}
        <td colspan="3" border="0">Vehicle No :{$ogplDetails->registration_number}
        </td>
        <td colspan="3" border="0">From Branch :{$ogplDetails->transit_from_organization_name}
        </td>

        {foreach item=row from=$odometer key=t}
            {if $row->fromOrganization->code ==  $ogplDetails->from_organization_code }
                {if isset($row->departureAt)}
                    <td colspan="4" border="0">Booking Date :{$row->departureAt|date_format:"%d-%m-%Y"}
                    </td>
                    {break}
                {/if}
            {/if}
    {/foreach}



       
    </tr>
    <tr style="border: none;">
        <td colspan="3" border="0">Prepared Person :{$usr_login_name}
        </td>
        <td colspan="3" border="0">Arrival Time :{($ogplDetails->arrival_at|date_format:$ns_datetime_format)|substr:10:9}
        </td>
        <td colspan="3" border="0">To Branch :{$ogplDetails->transit_to_organization_name}
        </td>
        <td colspan="3" border="0">Arrival Date :{$ogplDetails->arrival_at|date_format:"%d-%m-%Y"}
    </tr>
</table>
<table class="each-table" border="2" cellpadding="10" width="101%">
    <thead>
        <tr>
            <td  align="center" width="auto"><b>S.No</b></td>
            <td  align="center" width="auto"><b>From Party</b> </td>
            <td  align="center" width="auto"><b>To Party </b></td>
            <td  align="left" width="auto"><b>No of Articles</b></td>
            <td  align="left" width="auto"><b>Payment Type</b> </td>
            <td  align="left" width="auto"><b>Amount</b> </td>
            <td  align="left" width="auto"><b>OD/DD</b></td>
            <td  align="center" width="auto"><b>LR No.</b></td>
            <td  align="center" width="auto"><b>CR.NO</b></td>
            <td  align="center" width="auto"><b> Date </b></td>
            <td  align="center" width="auto"><b>C.C & Sign</b></td>
            <td  align="center" width="auto"><b>Party Seal & Sign</b></td>
        </tr>
    </thead>
    <tbody>
        {assign var=tot_lr_count value=0}
        {assign var=tot_item_count value=0}
        {assign var=tot_fare value=0}
        {assign var=tot_handling value=0}
        {assign var=tot_payable value=0}
        {assign var=tot_paid value=0}
        {assign var=tot_topay value=0}
        {assign var=tot_items value=0}
        {assign var=tot_commission value=0}
        {assign var=s_no value=1}
        {assign var=index value=0}
        {foreach item=row from=$singleOgpl key=t}
            {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                {if $index % 4 == 0}
                    <tr class="page-break"></tr>
                {/if}

                <tr>
                    <td style ="font-size: 13px;" align="center">{$s_no}</td>
                    <td style ="font-size: 13px;" align="left">{$row->from_customer_name}</td>
                    <td  style ="font-size: 13px;"  align="center">{$row->to_customer_name}</td>
                    {* <td align="center">{$row->cargo_item_name}</td> *}
                    <td style ="font-size: 13px;" align="left">{$row->total_item_count} - {$row->cargo_item_name}</td>
                    {* <td align="left">{$row->user_first_name}</td>        *}
                    {if $row->payment_type_code == "PAD" }
                        <td style ="font-size: 13px;"  align="left">Paid</td>
                    {else if $row->payment_type_code == "TPPAD" }
                        <td style ="font-size: 13px;"  align="left">To Pay Paid</td>
                    {else if $row->payment_type_code == "INP" }
                        <td style ="font-size: 13px;" align="left">On Account</td>
                    {else if $row->payment_type_code == "FS" }
                        <td style ="font-size: 13px;"  align="left">Free Service</td>
                    {else if $row->payment_type_code == "WTOP" }
                        <td style ="font-size: 13px;"  align="left">Way To Pay</td>
                    {else if $row->payment_type_code == "OATP" }
                        <td style ="font-size: 13px;" align="left">On Account To Pay</td>
                    {else if $row->payment_type_code == "TOP" }
                        <td style ="font-size: 13px;" align="left">To Pay</td>
                    {/if}
                    <td style ="font-size: 13px;"  align="left">{$row->total_transaction_amount}</td>
                    {if $row->delivery_type_code == "DYSE" }
                        <td style ="font-size: 13px;" align="left">Self Pickup</td>
                    {else if $row->delivery_type_code == "DYDO" }
                        <td style ="font-size: 13px;"  align="left">Door Delivery</td>
                    {else if $row->delivery_type_code == "PUSE" }
                        <td style ="font-size: 13px;" align="left">Self Pickup</td>
                    {else if $row->delivery_type_code == "PUDO" }
                        <td  style ="font-size: 13px;" align="left">Door Pickup</td>
                    {else if $row->delivery_type_code == "PDDO" }
                        <td align="left">Door Pickup and Delivery</td>
                    {else if $row->delivery_type_code == "WAYDY" }
                        <td style ="font-size: 13px;" align="left">On the Way Delivery</td>
                    {/if}
                    <td style ="font-size: 13px;" align="center" >{$row->cargo_code}</td>
                    {if $row->payment_status_code == "INP" ||  $row->payment_status_code == "OATP"}

                    <td style ="font-size: 13px;"  align="center">{$row->invoice_number|default:'-'}</td>
                    {else}
                        <td style ="font-size: 13px;"  align="center">{$row->transaction_receipt_code|default:'-'}</td>
                    {/if}
                    {if ($row->invoice_number !== '' && $row->invoice_number|default:'-' !== '-')}
                        <td style="font-size: 13px;" align="center" nowrap>{$row->invoice_date|date_format:"%d-%m-%Y"}</td>
                    {else if ($row->transaction_receipt_code !== '' && $row->transaction_receipt_code|default:'-' !== '-')}
                        <td style="font-size: 13px;" align="center" nowrap>{$row->receipt_transaction_date|date_format:"%d-%m-%Y"}</td>
                    {else}
                        <td style="font-size: 13px;" align="center" nowrap></td>
                    {/if}
                    <td style ="font-size: 13px;" align="center"></td>
                    <td style ="font-size: 13px;" align="left" nowrap>
                    {if ($row->local_alias_code || $row->created_at || $row->local_driver_name || $row->local_driver_mobile_number)}
                       {if $row->local_alias_code}
                        <span>ogpl No: {$row->local_alias_code}</span><br>
                       {/if}
                       {if $row->created_at}
                        <span>Date: {$row->created_at|date_format:"%d-%m-%Y"}</span><br>
                       {/if}
                       {if $row->local_driver_name}
                        <span>Driver Name: {$row->local_driver_name}</span><br>
                       {/if}
                       {if $row->local_driver_mobile_number}
                        <span> Driver Mobile No: {$row->local_driver_mobile_number}</span><br>
                       {/if}
                    {/if}
                        </td>
                </tr>

                {assign var=s_no value=$s_no+1}
                {assign var=index value=$index+1}
                {assign var=tot_lr_count value=$tot_lr_count+1}
                {assign var=tot_item_count value=$tot_item_count + $row->item_count}
                {assign var=tot_fare value=$tot_fare+$row->total_transaction_amount}
                {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                {assign var=tot_payable value=$tot_payable+$row->total_transaction_amount}
                {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                {assign var=tot_items value=$tot_items+$row->total_item_count}
                {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->service_charge + $row->other_charges_amount}

                {assign var=tot_commission value=$tot_commission+$row->commission_amount}
            {/if}
        {/foreach}

        {if $tot_lr_count}
            <tr>
                <td align="right" colspan="3" class="bold">Total</td>
                <td align="center" class="bold">{$tot_items}</td>
                <td align="center" class="bold"></td>
                <td align="right" class="bold">{$tot_payable|inr_format}</td>
                <td colspan="6"></td>
            </tr>
        {else}
            <tr>
                <td colspan="100%" align="center">No Records Found!</td>
            </tr>
        {/if}
    </tbody>
</table>
<div class="page-break-after"></div>
<div class="table-top">
    <table cellpadding="2" width="70%">
        <tr>
            <td width="45%">
                <table cellpadding="2" width="100%">
                    <tr>
                        <td class="bold" colspan="3">Payment Details</td>
                    </tr>
                </table>
                <table border="1" cellpadding="2" width="101%">
                    <thead>
                        <tr>
                            <td align="center">Mode of Payment</td>
                            <td align="center">No. of GCN</td>
                            <td align="center">Amount (Rs.)</td>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$payment_details item=row key=k}
                            <tr>
                                <td align="center" nowrap>{$cargo_payment_status[$k]}</td>
                                <td align="center">{$row['count']|sigma:$tot_pay_cnt}</td>
                                <td align="right">{$row['amount']|sigma:$tot_pay_amt|inr_format}</td>
                            </tr>
                        {/foreach}
                    </tbody>
                    <tr class="bold">
                        <td align="right">Total</td>
                        <td align="center">{$tot_pay_cnt}</td>
                        <td align="right">{$tot_pay_amt|inr_format}</td>
                    </tr>
                </table>
            </td>
            <td width="10%"></td>
            <td width="45%">
                <table cellpadding="2" width="100%">
                    <tr>
                        <td class="bold" colspan="3">Delivery Details</td>
                    </tr>
                </table>
                <table border="1" cellpadding="2" width="100%">
                    <thead>
                        <tr>
                            <td align="center">Delivery Details</td>
                            <td align="center">No. of GCN</td>
                            <td align="center">Amount (Rs.)</td>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$delivery_details item=row key=k}
                            <tr>
                                <td align="center" nowrap>{$delivery_type_codes[$k]}</td>
                                <td align="center">{$row['count']|sigma:$tot_del_cnt}</td>
                                <td align="right">{$row['amount']|sigma:$tot_del_amt|inr_format}</td>
                            </tr>
                        {/foreach}
                    </tbody>
                    <tr class="bold">
                        <td align="right">Total</td>
                        <td align="center">{$tot_del_cnt}</td>
                        <td align="right">{$tot_del_amt|inr_format}</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <br>
    <table cellpadding="2" width="70%">
        <tr>
            <td class="bold">Collection Details</td>
        </tr>
    </table>
    <table border="1" width="70%">
        <thead>
            <tr>
                <td align="center">Mode of Payment</td>
                <td align="center">Total LR</td>
                <td align="center">Total LR Amount (Rs.)</td>
                <td align="center">Payment Received LR</td>
                <td align="center">Payment Received LR Amount (Rs.)</td>
                <td align="center">Pending LR</td>
                <td align="center">Pending LR Amount (Rs.)</td>
            </tr>
        </thead>
        <tbody>
            {foreach from=$payment_details item=row key=k}
                <tr>
                    <td align="center" nowrap>{$cargo_payment_status[$k]}</td>
                    <td align="center">{$row['count']|default:0|sigma:$tot_coll_cnt}</td>
                    <td align="right">{$row['amount']|sigma:$tot_coll_amt|inr_format}</td>
                    <td align="center">{$row['paid_count']|default:0|sigma:$tot_coll_paid_cnt}</td>
                    <td align="right">{$row['paid_amt']|sigma:$tot_coll_paid_amt|inr_format}</td>
                    <td align="center">{$row['pend_count']|default:0|sigma:$tot_coll_pend_cnt}</td>
                    <td align="right">{$row['pending_amt']|sigma:$tot_coll_pend_amt|inr_format}</td>
                </tr>
            {/foreach}
        </tbody>
        <tr class="bold">
            <td align="right">Total</td>
            <td align="center">{$tot_coll_cnt}</td>
            <td align="right">{$tot_coll_amt|inr_format}</td>
            <td align="center">{$tot_coll_paid_cnt}</td>
            <td align="right">{$tot_coll_paid_amt|inr_format}</td>
            <td align="center">{$tot_coll_pend_cnt}</td>
            <td align="right">{$tot_coll_pend_amt|inr_format}</td>
        </tr>
    </table>
</div>

<div class="print-footer" id="print-footer">
        <table>
            <tr>
                <td width="35%">Printed On : {$smarty.now|date_format:$ns_datetime_format}</td>
                <td width="25%">Generated  By: {$usr_login_name} </td>
            </tr>
        </table>
    </div>
<style>
    .bold {
        font-weight: bold;
    }

    table {
        border-collapse: collapse;
    }

    table thead th,
    table tbody td {
        font-weight: 100;
        padding: 4px;

    }

    table.bordered th,
    table.bordered td {
        border: 1px solid #000;
        padding: 4px;
    }

    div.print-border {
        position: fixed;
        bottom: 100px;
        left: 0;
        width: 100%;
        height: 1px;
        /* Set the height of the border as needed */
        background-color: #000;
        /* Set the border color as needed */
    }

    div.print-border-left,
    div.print-border-right {
        position: fixed;
        top: 30px;
        height: 100%;
        width: 1px;
        /* Set the width of the borders as needed */
        background-color: #000;
        /* Set the border color as needed */
        z-index: 1;
        /* Move the borders behind the content */
    }

    div.print-border-left {
        left: 6px;
    }

    div.print-border-right {
        right: 100px;
    }


    .print-header {
        position: fixed;
        top: 0;
    }
</style>

<style type="text/css" media="print">
    @media print {
        body {
            -webkit-print-color-adjust: exact !important;
            color-adjust: exact !important;
        }

        @page {
            size: A4 landscape;
        }


        table thead th,
    table tbody td {
        font-weight: 100;
        padding: 4px;

    }

    table.bordered th,
    table.bordered td {
        border: 1px solid #000;
        padding: 4px;
        word-wrap: break-word;
        word-break: break-all;
    }
        div.print-border {
            position: fixed;
            bottom: 20px;
            left: 6px;
            width: 100%;
            height: 1px;
            /* Set the height of the border as needed */
            background-color: #000000;
            /* Set the border color as needed */
        }

        div.print-border-left,
        div.print-border-right {
            position: fixed;
            top: 0px;
            height: 97.5%;
            width: 1px;
            /* Set the width of the borders as needed */
            background-color: #000;
            /* Set the border color as needed */
            z-index: -1;
            /* Move the borders behind the content */
        }

        div.print-border-left {
            left: 7px;
        }

        div.print-border-right {
            right: 0;
        }

        .page-break {
            page-break-before: always;
        }

        .print-table {
            width: 100.5%;
        }

        .print-header {
            position: fixed;
            top: 0;
            width: 100%;
        }

        .each-table {
            position: relative;
            top: 160px;
        }

        .first_page {
            position: relative;
            top: 152px;

        }

        .page-break {
            page-break-before: always;
        }

        .page-break-after {
            page-break-after: always;
        }

        .table-top {
            position: relative;
            top: 200px;
        }

    .print-footer {
                position: fixed;
                bottom: 0;
                width: 100%;
                text-align: center;
                font-size: 10px;
                color: #333;
            }

    }
</style>

<script>
    window.print();
</script>