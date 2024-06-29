<html>

<head>
    <title>Transit Chart</title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    <style>   
        .lr{  font-size: 12pt;  font-weight: bold;}
        .payment-status{  font-size: 11pt;  font-weight: bold;  letter-spacing: 1.5px; }
        .title { font-weight:bold; text-align: center; }
        .bold { font-weight:bold; }
        .bolder { font-weight: 900; }
        table tr { page-break-inside: avoid; page-break-after: auto; }
    </style>
</head>

<body>
    <h1 class="title" style="font-size: 20px;">{$namespace_name}</h1>
    <h1 class="title" style="font-size: 15px;">Transit Report</h1>
    <table width="100%">
        <tr>
            <td></td>
            <td align="right" width="30%" class="bold">Printed By : {$usr_login_name}</td>
            <td align="right" width="25%" class="bold">Printed At : {$smarty.now|date_format:$ns_datetime_format}</td>
        </tr>
    </table>
    <div style="border: 1px solid;overflow: hidden;">
        <table style="border-bottom: 1px dashed;" cellpadding="3" width="100%">
            <tr>
                <td width="25%"><b>Transit Number:</b> {$ogpl->aliasCode}</td>
                <td width="25%"><b>Trip Date:</b> {$ogpl->tripDate|date_format:$ns_date_format}</td>
                <td width="25%"><b>From Branch:</b> {$ogpl->fromOrganization->name}</td>
                <td width="25%"><b>To Branch:</b> {$ogpl->toOrganization->name}</td>
            </tr>
            <tr>
                <td width="25%"><b>Vehicle :</b> {$ogpl->busVehicle->registationNumber}</td>
                <td width="25%"><b>Driver1 :</b> {$ogpl->vehicleDriver->name}, {$ogpl->vehicleDriver->mobileNumber}</td>
                <td width="25%"><b>Driver2 :</b> {$ogpl->secondaryDriver->name}, {$ogpl->secondaryDriver->mobileNumber}</td>
                <td width="25%"><b>Transfer Truck No :</b> </td>
            </tr>
        </table>
        {foreach from=$ogpl->transitCargoDetails item=transit}
            <table style="border-bottom: 1px dashed;" cellpadding="3" width="100%">
                <tr>
                    <td width="25%"><b>From Branch :</b> {$transit->fromOrganization->name}</td>
                    <td width="25%"><b>To Branch :</b> {$transit->toOrganization->name}</td>
                    <td width="25%"><b>Loaded By :</b> {$transit->audit->user->name|default:'-'}</td>
                    <td width="25%"><b>Loaded At :</b> {if $transit->loadedAt != 'NA'}{$transit->loadedAt|date_format:$ns_datetime_format}{else}-{/if}</td>
                </tr>
                <tr>
                    <td width="25%"><b>Unloaded By :</b> {$transit->unloadedBy->name|default:'-'}</td>
                    <td width="25%"><b>Unloaded At :</b> {if $transit->unloadedAt != 'NA'}{$transit->unloadedAt|date_format:$ns_datetime_format}{else}-{/if}</td>
                    <td width="25%"></td>
                    <td width="25%"></td>
                </tr>
            </table>
        {/foreach}
        <br/>
        <table class="bordered" cellpadding="" width="100%" style="table-layout:auto;">
            <thead style="font-size: 5px;">
                <tr class="bold">
                    <td align="center">S.No</td>
                    <td align="center">{lang('lr')}</td>
                    <td align="center">Booked At</td>
                    <td align="center">Consignor</td>
                    <td align="center">Consignee</td>
                    <td align="center">Article</td>
                    <td align="center">Qty</td>
                    <td align="center">Wt.</td>
                    <td align="center">FF</td>
                    <td align="center">HM</td>
                    <td align="center">DC</td>
                    <td align="center">DD</td>
                    <td align="center">Oth. Ch</td>
                    <td align="center">{lang('docket_charge')}</td>
                    <td align="center">Total</td>
                    <td align="center">Pay. Type</td>
                    <td align="center">Remarks</td>
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
                    <tr>
                        <td align="center" colspan="17"><b>{$routes[$t1]}</b></td>
                    </tr>
                    {foreach item=row from=$row1 key=t}
                        <tr>
                            <td align="center">{$sno}</td>
                            <td align="left" class="lr">{$row->cargo_code}</td>
                            <td align="center" nowrap>{$row->booked_at|date_format:$ns_date_format}</td>
                            <td width="10%">{$row->from_customer_name}</td>
                            <td width="10%">{$row->to_customer_name}</td>
                            <td>{$row->cargo_item_name}</td>

                            <td align="center">
                                {$row->total_item_count}
                                {assign var='o_qty' value=$o_qty+$row->total_item_count}
                            </td>

                            <td align="center">
                                {$row->total_unit_value}
                                {assign var='o_article_weight' value=$o_article_weight+$row->total_unit_value}
                            </td>
                            
                            <td align="right">
                                {($row->total_amount)|inr_format}
                                {assign var='o_freight_tot_amount' value=$row->total_amount + $o_freight_tot_amount}
                            </td>

                            <td align="right">
                                {($row->hamali_charge)|inr_format}
                                {assign var='o_tot_hamali_charge' value=$row->hamali_charge + $o_tot_hamali_charge}
                            </td>

                            <td align="right">
                                {($row->pickup_handling_amount)|inr_format}
                                {assign var='o_tot_dc_charge' value=$row->pickup_handling_amount + $o_tot_dc_charge}
                            </td>

                            <td align="right">
                                {($row->delivery_handling_amount)|inr_format}
                                {assign var='o_tot_dd_charge' value=$row->delivery_handling_amount + $o_tot_dd_charge}
                            </td>

                            <td align="right">
                                {($row->other_charges_amount - $row->pickup_handling_amount - $row->delivery_handling_amount - $row->hamali_charge - $row->docket_charge)|inr_format}
                                {assign var='o_tot_other_charge' value=$row->other_charges_amount - $row->pickup_handling_amount - $row->delivery_handling_amount - $row->hamali_charge - $row->docket_charge + $o_tot_other_charge}
                            </td>

                            <td align="right">
                                {($row->docket_charge)|inr_format}
                                {assign var='o_tot_docket_charge' value=$row->docket_charge + $o_tot_docket_charge}
                            </td>

                            <td align="right">
                                {($row->total_amount + $row->other_charges_amount)|inr_format}
                                {assign var='o_tot_grand_total' value=$row->total_amount + $row->other_charges_amount + $o_tot_grand_total}
                            </td>

                            <td align="center">{$cargo_payment_status[$row->payment_status_code]|strtoupper}</td>
                            <td align="center">{$row->remarks_count}</td>
                        </tr>
                        {assign var='sno' value=$sno+1}
                    {/foreach}
                    <tr class="bold">
                        <td align="right" colspan="6">Total</td>
                        <td align="center">{$o_qty}</td>
                        <td align="center">{$o_article_weight}</td>
                        <td align="right">{$o_freight_tot_amount|inr_format}</td>
                        <td align="right">{$o_tot_hamali_charge|inr_format}</td>
                        <td align="right">{$o_tot_dc_charge|inr_format}</td>
                        <td align="right">{$o_tot_dd_charge|inr_format}</td>
                        <td align="right">{$o_tot_other_charge|inr_format}</td>
                        <td align="right">{$o_tot_docket_charge|inr_format}</td>
                        <td align="right">{$o_tot_grand_total|inr_format}</td>
                        <td colspan="2"></td>
                    </tr>
                {foreachelse}
                    <tr>
                        <td align="center" colspan="17">Sorry! No cargo found</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
        <br />
        <table width='100%' cellpadding="">
            <tr>
                <td class="bolder">Payment Summary</td>
                <td class="bolder">Delivery Summary</td>
            </tr>
            <tr>
                <td>
                    <table width='96%' class="bordered" cellpadding="3">
                        <thead>
                            <tr class="bold">
                                <td align="center">{lang('lr')} Type</td>
                                <td align="center">No.of {lang('lr')}s</td>
                                <td align="center">Total Amount (Rs.)</td>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach item=val from=$paymentSummary key=key }
                                <tr>
                                    <td align="center"><b>{$cargo_payment_status[$key]}</b></td>
                                    <td align="center">{$val['lr']}</td>
                                    <td align="center">{$val['amount']|inr_format}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </td>
                <td>
                    <table width='100%' class="bordered" cellpadding="3">
                        <thead>
                            <tr class="bold">
                                <td align="center">Delivery Type</td>
                                <td align="center">No.of {lang('lr')}s</td>
                                <td align="center">Total Amount (Rs.)</td>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach item=val from=$deliverySummary key=key}
                                <tr>
                                    <td align="center"><b>{$delivery_type_codes[$key]}</b></td>
                                    <td align="center">{$val['lr']}</td>
                                    <td align="center">{$val['amount']|inr_format}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>

        <h1 class="bolder">Branch Summary</h1>
        <table class="bordered" cellpadding="3" width="100%">
            <thead>
                <tr class="bold">
                    <td align="center">S.No</td>
                    <td align="center">From Branch</td>
                    <td align="center">To Branch</td>
                    <td align="center">No.of {lang('lr')}</td>
                    <td align="center">No.of Article</td>
                    <td align="center">Article Weight</td>
                    <td align="center">Amount</td>
                </tr>
            </thead>
            <tbody>
                {assign var="branch_sno" value=1}
                {assign var="total_lr" value=0}
                {assign var="total_amount" value=0}
                {foreach from=$branchSummary item=row}
                    <tr>
                        <td align="center">{$branch_sno}</td>
                        <td align="left">{$row['from']}</td>
                        <td align="left">{$row['to']}</td>
                        <td align="center">{$row['lr']}</td>
                        <td align="center">{$row['article']}</td>
                        <td align="center">{$row['articleWeight']}</td>
                        <td align="right">{$row['amount']|inr_format}</td>
                    </tr>
                    {assign var='branch_sno' value=$branch_sno+1}
                    {assign var="total_lr" value=$total_lr + $row['lr']}
                    {assign var="total_article" value=$total_article + $row['article']}
                    {assign var="total_article_weight" value=$total_article_weight + $row['articleWeight']}
                    {assign var="total_amount" value=$total_amount + $row['amount']}
                {/foreach}
            </tbody>
            <tfoot>
                <tr class="bold">
                    <td align="right" colspan="3">Grand Total</td>
                    <td align="center">{$total_lr}</td>
                    <td align="center">{$total_article}</td>
                    <td align="center">{$total_article_weight}</td>
                    <td align="right">{$total_amount|inr_format}</td>
                </tr>
            </tfoot>
        </table>
    </div>
    {* <div class="background-image"></div> *}
</body>
<style>
    body {
        width: unset;
    }

    table {
        border-collapse: collapse;
    }

    table thead th,
    table thead td {
        font-weight: bold;
    }

    table.bordered th,
    table.bordered td {
        border: 1px solid #000;
    }

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
