<html>

<head>
    <title>Driver Chart</title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
</head>

<body>
    <div style="border: 1px solid #000; width: 96%;">
        <table width="100%">
            <tr>
                <td width="100%" colspan="2" align="center" style="font-weight:bold; font-size: 20px;">Driver Trip Chart
                    <span style="font-weight:500; font-size: 15px;"><br>{$userBranchData['address1']}
                        <br>{$userBranchData['address2']}<br> Ph :{$userBranchData['contact']}</span>
                </td>
            </tr>
            <tr>
                <td width="60%"><b>{lang('ogpl')} Number:</b> {$ogpl->aliasCode}</td>
                <br>
            </tr>
            <tr>
                <td width="70%"><b>Route:</b> {$ogpl->fromOrganization->name} to {$ogpl->toOrganization->name}</td>
                <td width="30%"><b>Vehicle :</b> {$ogpl->busVehicle->registationNumber}</td>
            </tr>
            <tr>
                <td width="70%"><b>Trip Date:</b> {$ogpl->tripDate|date_format:$ns_date_format}</td>
                <td width="30%"><b>Driver :</b> {$ogpl->vehicleDriver->name}, {$ogpl->vehicleDriver->mobileNumber}</td>
            </tr>
        </table>
    </div>
    <br>
    <table class="bordered" cellpadding="3" width="96%">
    <thead>
        <tr>
            <th class="text-center" rowspan="2">Sl No.</th>
            <th class="text-center" rowspan="2">LR</th>
            <th class="text-center" rowspan="2">Nos</th>
            <th class="text-center" rowspan="2">Pkgs</th>
            <th class="text-center" rowspan="2">Consignee</th>
            <th class="text-center" rowspan="2">To</th>
            <th class="text-center" rowspan="2">Remarks</th>
            <th class="text-center" colspan="2">Amount</th>
        </tr>
        <tr>
            <td align="center">Paid</td>
            <td align="center">To Pay</td>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var='o_pd_tot_amount' value=0}
        {assign var='grand_count' value=0}
        {assign var='sno' value=1}
        {foreach item=row1 from=$result key=t1}
            {assign var='sub_pb_tot_amount' value=0}
            <tr>
                <td align="center" colspan="10"><b>{$routes[$t1]}</b></td>
            </tr>
            {assign var="sub_pb_tot_count" value=0}
            {assign var="sub_pd_tot_amount" value=0}
            {foreach item=row from=$row1 key=t}
                {assign var='sub_pb_tot_count' value=$sub_pb_tot_count+$row->total_item_count}
                {assign var='grand_count' value=$grand_count+$row->total_item_count}
                <tr>
                    <td align="center">{$sno}</td>
                    <td align="center">{$row->cargo_code}
                        <br>
                        {if isNotNull($row->eway_bill_no)}
                            <span style="border: 1px solid #000; font-size: 13px;"><b>EW</b></span> &nbsp;
                        {/if}
                        {if isNotNull($row->invoice_number)}
                            <span style="border: 1px solid #000;font-size: 13px;"><b>INV</b></span>
                        {/if}
                    </td>
                    <td align="center">{$row->total_item_count}</td>
                    <td align="center">{$row->cargo_item_name}</td>
                    <td align="center">{$row->to_customer_name}</td>
                    <td align="center">{$row->to_organization_name}</td>
                    <td align="center">{$row->booking_remarks}</td>
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
                <td colspan="2" align="center">
                    Subtotal
                </td>
                <td align="center">{$sub_pb_tot_count}</td>
                <td colspan="4" align="center"></td>
                <td align="right">{$sub_pd_tot_amount|number_format:2}</td>
                <td align="right">{$sub_pb_tot_amount|number_format:2}</td>
            </tr>
        {/foreach}
        {if count($row1) >0 }
            <tr>
                <td colspan="2" align="center">
                    Grand Total Nos
                </td>
                <td align="center"><b>{$grand_count}</b></td>
                <td colspan="4" align="center"><b>Grand Total</b></td>
                <td align="right"><b>{$o_pd_tot_amount|number_format:2}</b></td>
                <td align="right"><b>{$o_pb_tot_amount|number_format:2}</b></td>
            </tr>
        {/if}
    </tbody>
</table>

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