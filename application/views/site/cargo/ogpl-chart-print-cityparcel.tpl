<html>

<head>
    <title>OGPL Chart</title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    <style>
        .lr {
            font-size: 12pt;
            font-weight: bold;
            letter-spacing: 1.5px;
        }

        .payment-status {
            font-size: 11pt;
            font-weight: bold;
            letter-spacing: 1.5px;
        }
    </style>
</head>

<body>
    <div style="border: 1px solid #000;">
        <table cellpadding="5" width="100%">
            <tr>
                <td width="100%" colspan="2" align="center" style="font-weight:bold; font-size: 20px;">
                    {$namespace_name}
                    <span style="font-weight:500; font-size: 15px;"><br>{$userBranchData['address1']}
                        <br>{$userBranchData['address2']}<br> Ph :{$userBranchData['contact']}</span>
                </td>
            </tr>
            <tr>
                <td width="100%" colspan="2"><b>{lang('ogpl')} Number:</b> {$ogpl->aliasCode}</td>
            </tr>
            <tr>
                <td width="60%"><b>Trip Date:</b> {$ogpl->tripDate|date_format:$ns_date_format}</td>
                <td width="40%"><b>Vehicle :</b> {$ogpl->busVehicle->registationNumber}</td>
            </tr>
            <tr>
                <td width="60%"><b>Route:</b> {$ogpl->fromOrganization->name} to {$ogpl->toOrganization->name}</td>
                <td width="40%"><b>Driver :</b> {$ogpl->vehicleDriver->name}, {$ogpl->vehicleDriver->mobileNumber}</td>
            </tr>
            {if $ogpl->remarks}
                <tr>
                    <td width="60%" colspan="2"><b>Remarks:</b> {$ogpl->remarks}</td>
                </tr>
            {/if}
        </table>
    </div>
    <br>
    <table id="dt_adv_booking_report_table" class="table table-bordered">
        <thead>
            <tr class="info bold">
                <td align="center" rowspan="2">S.No</td>
                <td align="center" rowspan="2">{lang('lr')}</td>
                <td align="center" rowspan="2">Qty</td>
                <td align="center" rowspan="2">Booked At</td>
                <td align="center" rowspan="2">Delivery At</td>
                <td align="center" rowspan="2">E-way Bill No</td>
                <td align="center" rowspan="2">{lang('booking_sender_term')} Name</td>
                <td align="center" rowspan="2">{lang('booking_sender_term')} Mobile</td>
                <td align="center" rowspan="2">{lang('booking_receiver_term')} Name</td>
                <td align="center" rowspan="2">{lang('booking_receiver_term')} Mobile</td>
                {* <td align="center" rowspan="2">Booked By</td> *}
                <td align="center" rowspan="2">Payment Status</td>
                <td align="center" colspan="4">Amount</td>
            </tr>
            <tr class="info bold">
                <td align="center">Freight</td>
                {* <td align="center">{lang('other_charges')}</td> *}
                <td align="center">Connecting Charges</td>
                <td align="center">Paid</td>
                <td align="center">To Pay</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var='o_qty' value=0}
            {assign var='sno' value=1}

            {assign var='o_freight_tot_amount' value=0}
            {assign var='o_handling_tot_amount' value=0}
            {assign var='o_other_tot_amount' value=0}

            {assign var='o_pd_tot_amount' value=0}
            {assign var='o_pb_tot_amount' value=0}

            {foreach item=row1 from=$result key=t1}
                {assign var='sub_qty' value=0}
                {assign var='sub_freight_tot_amount' value=0}
                {assign var='sub_connecting_tot_amount' value=0}
                {assign var='sub_pd_tot_amount' value=0}
                {assign var='sub_pb_tot_amount' value=0}
                <tr>
                    <td align="center" colspan="17" class="bold">{$routes[$t1]}</td>
                </tr>
                {foreach item=row from=$row1 key=t}
                    {assign var='o_qty' value=$o_qty+$row->total_item_count}
                    {assign var='sub_qty' value=$sub_qty+$row->total_item_count}
                    <tr>
                        <td align="center">{$sno}</td>
                        <td align="center" nowrap>{$row->cargo_code}
                            <br>
                            {if isNotNull($row->eway_bill_no)}
                                <img src="{$base_url}assets/img/icons/eway.svg" width="30px" loading="lazy">
                            {/if}
                            {if isNotNull($row->invoice_number)}
                                <img src="{$base_url}assets/img/icons/invoice.svg" width="30px" loading="lazy">
                            {/if}
                        </td>
                        <td align="center">{$row->total_item_count}</td>
                        <td align="center">{$row->from_organization_name}</td>
                        <td align="center">{$row->to_organization_name}</td>
                        <td align="center">{$row->eway_bill_no}</td>
                        <td align="left">{$row->from_customer_name}</td>
                        <td align="center">{$row->from_customer_mobile}</td>
                        <td align="left">{$row->to_customer_name}</td>
                        <td align="center">{$row->to_customer_mobile}</td>
                        {* <td align="left">{$row->user_first_name}</td> *}
                        <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>

                        <td align="right">
                            {($row->total_amount)|number_format:2}
                            {assign var='sub_freight_tot_amount' value=$sub_freight_tot_amount+$row->total_amount}
                            {assign var='o_freight_tot_amount' value=$o_freight_tot_amount+$row->total_amount}
                        </td>
                        <td align="right">
                            {($row->connecting_charge)|number_format:2}
                            {assign var='o_connecting_tot_amount' value=$row->connecting_charge + $o_connecting_tot_amount}
                            {assign var='sub_connecting_tot_amount' value=$sub_connecting_tot_amount + $row->connecting_charge}
                        </td>
                        <td align="right">
                            {assign var="paid" value=0}
                            {if $row->payment_status_code == 'PAD'}
                                {assign var="paid" value=($row->total_amount + $row->other_charges_amount)}
                                {$paid|number_format:2}
                                {assign var='o_pd_tot_amount' value=$paid + $o_pd_tot_amount}
                                {assign var='sub_pd_tot_amount' value=$paid + $sub_pd_tot_amount}
                            {else}
                                0.00
                            {/if}
                        </td>
                        <td align="right">
                            {assign var="topay" value=0}
                            {if $row->payment_status_code == 'TOP' || $row->payment_status_code == 'TPPAD'}
                                {assign var="topay" value=(($row->total_amount + $row->other_charges_amount) -($row->total_unload_handling_amount + $row->demurrage_charge +$row->hamali_charge))}
                                {$topay|number_format:2}
                                {assign var='o_pb_tot_amount' value=$topay+$o_pb_tot_amount}
                                {assign var='sub_pb_tot_amount' value=$topay+$sub_pb_tot_amount}
                            {else}
                                0.00
                            {/if}
                        </td>
                    </tr>
                    {assign var='sno' value=$sno+1}
                {/foreach}
                <tr>
                    <td align="center" class="active"></td>
                    <td align="center" class="active"></td>
                    <td align="center" class="bold active">{$sub_qty}</td>
                    <td colspan="8" class="active">&nbsp;</td>
                    <td align="right" class="active">{$sub_freight_tot_amount|number_format:2}</td>
                    <td align="right" class="active">{$sub_connecting_tot_amount|number_format:2}</td>
                    <td align="right" class="active">{$sub_pd_tot_amount|number_format:2}</td>
                    <td align="right" class="bold active">{$sub_pb_tot_amount|number_format:2}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td align="center" colspan="16">Sorry! No cargo found</td>
                </tr>
            {/foreach}
            {if count($row1) >0 }
                <tr class="success">
                    <td align="center"></td>
                    <td align="center"></td>
                    <td align="center" class="bold">{$o_qty}</td>
                    <td colspan="8">&nbsp;</td>
                    <td align="right">{$o_freight_tot_amount|number_format:2}</td>
                    <td align="right">{$o_connecting_tot_amount|number_format:2}</td>
                    <td align="right">{$o_pd_tot_amount|number_format:2}</td>
                    <td align="right" class="bold">{$o_pb_tot_amount|number_format:2}</td>
                </tr>
            {/if}
        </tbody>
    </table>
    <br />
    {if $action_rights['OGPL-PAY-SUMRY']==1 && $namespace != 'srimaharaja'}
        <table width='96%'>
            <tr>
                <td><span class="bold"><b>Summary</b></span></td>
            </tr>
        </table>
        <table width='96%' class="bordered" cellpadding="3">
            <thead>
                <tr class="success">
                    <td align="center">{lang('lr')} Type</td>
                    <td align="center">No.of {lang('lr')}s</td>
                    <td align="center">No.of {lang('booking_article_label')}</td>
                    <td align="center">Freight</td>
                    <td align="center">Connecting Charges</td>
                    <td align="center">Loading Charges</td>
                    <td align="center">Unloading Charges</td>
                    <td align="center">Delivery Charges</td>
                    <td align="center">Service Tax</td>
                    <td align="center">Total</td>
                </tr>
                {assign var="total" value=0}
                {assign var="total_lr" value=0}
                {assign var="total_pkgs" value=0}
                {assign var="total_frieght" value=0}
                {assign var="total_loading" value=0}
                {assign var="total_unloading" value=0}
                {assign var="total_delivery" value=0}
                {assign var="total_service_tax" value=0}
                {assign var="total_connecting" value=0}
                {assign var="net_total" value=0}
                {assign var="ac_kg_total" value=0}
                {assign var="kg_total" value=0}

            <tbody class="body_table">
                {foreach item=route from=$summary key=key}
                    <tr>
                        <td align="center" colspan="10"><b>{$routes[$key]}</b></td>
                    </tr>
                    {foreach item=row from=$route key=k }
                        <tr>
                            {assign var=total value=$row['freight']+$row['loading']+$row['unloading']+$row['service_tax']+$row['delivery']+$row['connecting']}
                            <td align="center"><b>{$cargo_payment_status[$k]}</b></td>
                            <td align="center">{$row['lr']}</td>
                            <td align="center">{$row['packages']}</td>
                            <td align="center">{$row['freight']|number_format:2}</td>
                            <td align="center">{$row['connecting']|number_format:2}</td>
                            <td align="center">{$row['loading']|number_format:2}</td>
                            <td align="center">{$row['unloading']|number_format:2}</td>
                            <td align="center">{$row['delivery']|number_format:2}</td>
                            <td align="center">{$row['service_tax']|number_format:2}</td>
                            <td align="center">{$total|number_format:2}</td>
                        </tr>

                        {assign var="total_lr" value=$total_lr+$row['lr']}
                        {assign var="total_pkgs" value=$total_pkgs+$row['packages']}
                        {assign var="total_frieght" value=$total_frieght+$row['freight']}
                        {assign var="total_loading" value=$total_loading+$row['loading']}
                        {assign var="total_unloading" value=$total_unloading+$row['unloading']}
                        {assign var="total_delivery" value=$total_delivery+$row['delivery']}
                        {assign var="total_service_tax" value=$total_service_tax+$row['service_tax']}
                        {assign var="total_connecting" value=$total_connecting+$row['connecting']}
                        {assign var="net_total" value=$net_total+$total}
                        {assign var="ac_kg_total" value=$ac_kg_total+$row['ac_kg']}
                        {assign var="kg_total" value=$kg_total+$row['kg_amt']}
                    {/foreach}
                {/foreach}
                <tr>
                    <td align="center"><b>Total</b></td>
                    <td align="center"><b>{$total_lr}</b></td>
                    <td align="center"><b>{$total_pkgs}</b></td>
                    <td align="center"><b>{$total_frieght|number_format:2}</b></td>
                    <td align="center"><b>{$total_connecting|number_format:2}</b></td>
                    <td align="center"><b>{$total_loading|number_format:2}</b></td>
                    <td align="center"><b>{$total_unloading|number_format:2}</b></td>
                    <td align="center"><b>{$total_delivery|number_format:2}</b></td>
                    <td align="center"><b>{$total_service_tax|number_format:2}</b></td>
                    <td align="center"><b>{$net_total|number_format:2}</b></td>
                </tr>
            </tbody>

            </thead>
        </table>
    {/if}
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
        size: A4 portrait;
    }
</style>

</html>