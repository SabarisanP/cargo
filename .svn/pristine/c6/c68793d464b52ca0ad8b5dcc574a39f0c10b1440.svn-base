<html>

<head>
    <title>Out For Delivery Chart</title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    <style>
        .lr { font-size: 12pt; font-weight: bold;}

        .payment-status { font-size: 11pt;font-weight: bold;letter-spacing: 1.5px;}

        .title { font-weight: bold; text-align: center; }

        .bold { font-weight: bold;  }

        .bolder {  font-weight: 900; }

        table tr { page-break-inside: avoid; page-break-after: auto;   }

        .right { text-align: right;  }

        .left { text-align: left; padding-left: 10px; }
        img{ width: 150px; height: 50px;}
    </style>
</head>

<body>
    <table style="border: 1px solid;overflow: hidden; border-bottom:none" cellpadding="5px" width="100%">
        <tr>
            <td style="padding: 0px 50px;" rowspan="3" colspan="2"><img src="./assets/img/seenutransports-logo.png" alt="logo"></td>
            <td></td>
            <td width="15%" class="right bold">Branch :</td>
            <td width="30%" class="left ">{$ogpl->fromOrganization->name}</td>
        </tr>
        <tr>
            <td width="35%" class="title bolder">
                <h2 class="title bolder" style="font-size:15px;">Seenu Transports Pvt.Ltd.<br>Door Delivery Acknowledgement</h2>
            </td>
            <td width="15%" class="right bold">Date:</td>
            <td width="30%" class="left">{$depAt|date_format:$ns_datetime_format}</td>
        </tr>
        <tr>
            <td></td>
            <td width="15%" class="right bold">Door Delivery No:</td>
            <td width="30%" class="left">{$ogpl->aliasCode}</td>
        </tr>
        <tr>
            <td width="15%" class="right bold">Hirechallan no:</td>
            <td width="15%" class="left"></td>
            <td colspan="3"></td>
        </tr>
    </table>
    <div style="border: 1px solid;overflow: hidden;">
        <table cellpadding="5px" width="100%">
            <tr>
                <td class="right bold">Vehicle No:</td>
                <td class="left">{$ogpl->busVehicle->registationNumber}</td>
                <td class="right bold">Dep.Time:</td>
                <td class="left">{$depAt|date_format:$ns_datetime_format}</td>
                <td class="right bold ">CC.Sign:</td>
                <td width="10%" class="left"></td>
                <td class="right bold" nowrap>Driver Name 1:</td>
                <td class="left">{$ogpl->vehicleDriver->name}</td>
                <td class="right bold" nowrap>Phone no 1:</td>
                <td class="left">{$ogpl->vehicleDriver->mobileNumber}</td>
            </tr>
            <tr>
                <td class="right bold" nowrap>Location Area:</td>
                <td class="left">{$ogpl->name}</td>
                <td class="right bold" nowrap>Route Location:</td>
                <td class="left">{$ogpl->remarks}</td>
                <td></td>
                <td></td>
                <td class="right bold" nowrap>Driver Name 2:</td>
                <td class="left">{$ogpl->secondaryDriver->name}</td>
                <td class="right bold" nowrap>Phone no 2:</td>
                <td class="left">{$ogpl->secondaryDriver->mobileNumber}</td>
            </tr>
        </table>
        <br />
        <table class="bordered" cellpadding="" width="100%" style="table-layout:auto;">
            <thead style="font-size: 5px;">
                <tr>
                    <td colspan="5"></td>
                    <td align="center" colspan="2">Time</td>
                    <td colspan="7"></td>
                </tr>
                <tr class="bold">
                    <td align="center">S.No</td>
                    <td align="center">{lang('lrno')}</td>
                    <td align="center">LR Date</td>
                    <td align="center">Consignee</td>
                    <td align="center">No.of Articles</td>
                    <td align="center">IN</td>
                    <td align="center">OUT</td>
                    <td align="center">LR Amount</td>
                    <td align="center">Door Delivery<br> Charges</td>
                    <td align="center">Mode of <br> Payment</td>
                    <td align="center">Delivery <br> Status</td>
                    <td align="center">Hand Over <br> Person</td>
                    <td align="center">Return to <br> Branch</td>
                    <td align="center">Signature</td>
                </tr>
            </thead>
            <tbody style="font-size: 5px;">
                {assign var='o_qty' value=0}
                {assign var='o_article_weight' value=0}
                {assign var='sno' value=1}

                {assign var='o_freight_tot_amount' value=0}
                {assign var='o_tot_hamali_charge' value=0}
                {assign var='o_tot_dc_charge' value=0}
                {assign var='o_tot_dd_charge' value=0}
                {assign var='o_tot_other_charge' value=0}
                {assign var='o_tot_docket_charge' value=0}
                {assign var='o_tot_grand_total' value=0}

                {foreach item=row1 from=$result key=t1}
                    {foreach item=row from=$row1 key=t}
                        <tr>
                            <td align="center">{$sno}</td>
                            <td align="left">{$row->cargo_code}</td>
                            <td align="center" nowrap>{$row->booked_at|date_format:$ns_date_format}</td>
                            <td width="10%">{$row->to_customer_name}</td>
                            <td align="center">
                                {$row->total_item_count} -
                                {assign var='o_qty' value=$o_qty+$row->total_item_count}
                                {$row->cargo_item_name}
                            </td>
                            <td width="5%"></td>
                            <td width="5%"></td>

                            <td align="right">
                                {($row->total_amount + $row->other_charges_amount)|inr_format}
                                {assign var='o_tot_grand_total' value=$row->total_amount + $row->other_charges_amount + $o_tot_grand_total}
                            </td>

                            <td align="right">
                                {if $row->fs_addon_value =="DD"}
                                    FS
                                {else}
                                    {($row->delivery_handling_amount)|inr_format}
                                    {assign var='o_tot_dd_charge' value=$row->delivery_handling_amount + $o_tot_dd_charge}
                                {/if}
                            </td>

                            <td align="center">{if $row->payment_status_code=="TPPAD"}TOPAY{else}{$cargo_payment_status[$row->payment_status_code]|strtoupper}{/if}</td>
                            <td align="center">{$row->door_delivery_remarks}</td>
                            <td align="center">{$row->door_delivery_handover_person}</td>
                            <td align="center">{$row->nearby_branch_details}</td>
                            <td align="center"></td>
                        </tr>
                        {assign var='sno' value=$sno+1}
                    {/foreach}

                {foreachelse}
                    <tr>
                        <td align="center" colspan="20">Sorry! No cargo found</td>
                    </tr>
                {/foreach}
            </tbody>
            <tr class="bold">
                <td align="right" colspan="4">Total</td>
                <td align="center">{$o_qty}</td>
                <td colspan="2"></td>
                <td align="right">{$o_tot_grand_total|inr_format}</td>
                <td align="right">{$o_tot_dd_charge|inr_format}</td>
                <td colspan="5"></td>
            </tr>
        </table>
        <br />
        <table cellpadding="2" width="100%">
            <tr>
                <td width="30%">
                    <table cellpadding="2" width="100%">
                        <tr>
                            <td class="bold" colspan="3">Payment Details</td>
                        </tr>
                    </table>
                    <table border="1" cellpadding="2" width="100%">
                        <thead>
                            <tr>
                                <td align="center">Mode of Payment</td>
                                <td align="center">No. of GCN</td>
                                <td align="center">Amount (Rs.)</td>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$payment_details item=row key=k}
                                {if $k =='INP' || $k =='PAD' || $k =='OATP'}
                                    <tr>
                                        <td align="center" nowrap>
                                            {$cargo_payment_status[$k]}
                                        </td>
                                        <td align="center">{$row['count']|sigma:$tot_pay_cnt}</td>
                                        <td align="right">{$row['amount']|sigma:$tot_pay_amt|inr_format}</td>
                                    </tr>
                                {/if}
                            {/foreach}

                            {if $paymentWise['count'] >0}
                                <tr>
                                    <td align="center" nowrap>
                                        {if $paymentWise['keys']=="TOP"}TOPAY{else}{$cargo_payment_status[$paymentWise['keys']]}{/if}
                                    </td>
                                    <td align="center">{$paymentWise['count']|sigma:$tot_pay_cnt}</td>
                                    <td align="right">{$paymentWise['amount']|sigma:$tot_pay_amt|inr_format}</td>
                                </tr>
                            {/if}
                        </tbody>
                        <tr class="bold">
                            <td align="right">Total</td>
                            <td align="center">{$tot_pay_cnt}</td>
                            <td align="right">{$tot_pay_amt|inr_format}</td>
                        </tr>
                    </table>
                </td>
                <td width="5%"></td>
                <td width="30%">
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
                            {foreach from=$door_delivery_status item=row key=k}
                                <tr>
                                    <td align="center" nowrap>{$row['status_name']}</td>
                                    <td align="center">{$row['lr_count']|sigma:$tot_del_cnt}</td>
                                    <td align="right">{$row['lr_amount']|sigma:$tot_del_amt|inr_format}</td>
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
                <td width="5%"></td>
                <td width="30%">
                    <table cellpadding="2" width="100%">
                        <tr>
                            <td class="bold" colspan="3">Return to branch</td>
                        </tr>
                    </table>
                    <table border="1" cellpadding="2" width="100%">
                        <thead>
                            <tr>
                                <td align="center">Branch</td>
                                <td align="center">No. of GCN</td>
                                <td align="center">Amount (Rs.)</td>
                            </tr>
                        </thead>
                        
                        <tbody>
                            {foreach from=$noreturn_branch item=row key=k}
                                <tr>
                                    {if $k == ' '}
                                        <td align="center" nowrap>No Return</td>
                                    {else}
                                        <td align="center" nowrap>{$k}</td>
                                    {/if}
                                    <td align="center">{$row['count']}</td>
                                    <td align="right">{$row['amount']|inr_format}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                        <tr class="bold">
                            <td align="right">Total</td>
                            <td align="center">{$return_to_branch_lr['count']}</td>
                            <td align="right">{$return_to_branch_lr['amount']|inr_format}</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table><br>
        <table cellpadding="2" width="70%">
            <tr>
                <td class="bold">Collection Details</td>
            </tr>
        </table>
        <table border="1" cellpadding="2" width="70%">
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
                    {if $k =='INP' || $k =='PAD' || $k =='OATP'}
                        <tr>
                            <td align="center" nowrap>
                                {if $k=="TPPAD"}TOPAY{else}{$cargo_payment_status[$k]}{/if}
                            </td>
                            <td align="center">{$row['count']|default:0|sigma:$tot_coll_cnt}</td>
                            <td align="right">{$row['amount']|sigma:$tot_coll_amt|inr_format}</td>
                            <td align="center">{$row['paid_count']|default:0|sigma:$tot_coll_paid_cnt}</td>
                            <td align="right">{$row['paid_amt']|sigma:$tot_coll_paid_amt|inr_format}</td>
                            <td align="center">{$row['pend_count']|default:0|sigma:$tot_coll_pend_cnt}</td>
                            <td align="right">{$row['pending_amt']|sigma:$tot_coll_pend_amt|inr_format}</td>
                        </tr>
                    {/if}
                {/foreach}
                {if $paymentWise['count'] >0}
                    <tr>
                        <td align="center" nowrap>
                            {if $paymentWise['keys']=="TOP"}TOPAY{else}{$cargo_payment_status[$paymentWise['keys']]}{/if}
                        </td>
                        <td align="center">{$paymentWise['count']|default:0|sigma:$tot_coll_cnt}</td>
                        <td align="right">{$paymentWise['amount']|sigma:$tot_coll_amt|inr_format}</td>
                        <td align="center">{$paymentWise['paid_count']|default:0|sigma:$tot_coll_paid_cnt}</td>
                        <td align="right">{$paymentWise['paid_amt']|sigma:$tot_coll_paid_amt|inr_format}</td>
                        <td align="center">{$paymentWise['pend_count']|default:0|sigma:$tot_coll_pend_cnt}</td>
                        <td align="right">{$paymentWise['pending_amt']|sigma:$tot_coll_pend_amt|inr_format}</td>
                    </tr>
                {/if}
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
        </table><br>
    </div><br>
    <div style="display:flex; justify-content:space-between ">
        <div>Printed on : {$smarty.now|date_format:$ns_datetime_format}</div>
        <div>Booked By : {$usr_login_name}</div>
        <div>Booked Date & Time : {$depAt|date_format:$ns_datetime_format}</div>
    </div>
</body>
<style>
    body {  width: unset; }

    table {  border-collapse: collapse; }

    table thead th, table thead td {  font-weight: bold;  }

    table.bordered th, table.bordered td {  border: 1px solid #000;  }

    {if $bgimg}
        .background-image {
            position: absolute;
            background-image: url({$bgimg}) !important;
            background-repeat: repeat-y !important;
            background-position: center !important;
            height: 950px;
            width: 100%;
            top: 0;
            left: 0;
            z-index: -1;
        }

    {/if}
</style>

<style type="text/css" media="print">
    @media print {
        body {
            -webkit-print-color-adjust: exact !important;
            /* Chrome, Safari */
            color-adjust: exact !important;
            /*Firefox*/
        }
    }

    @page {
        size: A4 landscape;
    }
</style>

</html>