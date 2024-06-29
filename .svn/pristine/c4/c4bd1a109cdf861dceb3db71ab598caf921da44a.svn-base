<html>
    <head>
        <title>Out For Delivery Chart</title>
        <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    </head>
    <body>
        <table cellpadding="5" width="100%">
            <tr>
                <td width="100%" colspan="2"><b>Out For Delivery Number:</b> {$ogpl->aliasCode}</td>
            </tr>
            <tr>
                <td width="60%"><b>Trip Date:</b> {$ogpl->tripDate|date_format:$ns_date_format}</td>
                <td width="40%"><b>Vehicle :</b> {$ogpl->busVehicle->registationNumber}</td>
            </tr>
            <tr>
                <td width="60%"><b>Route:</b> {$ogpl->fromOrganization->name} to {$ogpl->toOrganization->name}</td>
                <td width="40%"><b>Driver :</b> {$ogpl->vehicleDriver->name}, {$ogpl->vehicleDriver->mobileNumber}</td>
            </tr>
        </table>
        <br/>
        <table class="bordered" cellpadding="3" width="96%">
            <thead>
                <tr class="info bold">
                    <td align="center" rowspan="2">S.No</td>
                    <td align="center" rowspan="2">{lang('lr')}</td>
                    <td align="center" rowspan="2">Qty</td>
                    <td align="center" rowspan="2">{lang('booking_sender_term')} Name</td>
                    <td align="center" rowspan="2">{lang('booking_sender_term')} Mobile</td>
                    <td align="center" rowspan="2">{lang('booking_receiver_term')} Name</td>
                    <td align="center" rowspan="2">{lang('booking_receiver_term')} Mobile</td>
                    <td align="center" rowspan="2">Payment Status</td>
                    <td align="center" rowspan="2">To Pay</td>
                    <td align="center" rowspan="2">Address</td>
                    <td align="center" rowspan="2">Signature</td>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var='o_qty' value=0}
                {assign var='sno' value=1}

                {assign var='o_freight_tot_amount' value=0}
                {assign var='o_handling_tot_amount' value=0}

                {assign var='o_pd_tot_amount' value=0}
                {assign var='o_pb_tot_amount' value=0}

                {foreach item=row1 from=$result key=t1 }
                    {foreach item=row from=$row1 key=t }

                        {assign var='o_qty' value=$o_qty + $row->total_item_count}

                        <tr>
                            <td align="center">{$sno}</td>
                            <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                            <td align="center">{$row->total_item_count}</td>
                            <td align="left">{$row->from_customer_name}</td>
                            <td align="center">{$row->from_customer_mobile}</td>
                            <td align="left">{$row->to_customer_name}</td>
                            <td align="center">{$row->to_customer_mobile}</td>
                            <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>
                            <td align="right" >
                                {if $row->payment_status_code == 'TOP'}
                                    {assign var="topay" value=($row->total_amount +$row->handling +$row->total_handling_amount +$row->total_unload_handling_amount +$row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax)-$row->total_amount_paid}
                                    {$topay|number_format:2}
                                    {assign var='o_pb_tot_amount' value=$topay+$o_pb_tot_amount}
                                {else}
                                    0.00
                                {/if}
                            </td>
                            <td align="center"></td>
                            <td align="center"></td>
                        </tr>
                        {assign var='sno' value=$sno+1}
                    {/foreach}
                    <tr>
                        <td align="center"></td>
                        <td align="center"></td>
                        <td align="center" class="bold">{$o_qty}</td>
                        <td colspan="5">&nbsp;</td>
                        <td align="right" class="bold">{$o_pb_tot_amount|number_format:2}</td>
                        <td align="center"></td>
                        <td align="center"></td>
                    </tr>
                {foreachelse}
                    <tr>
                        <td align="center" colspan="16">Sorry! No cargo found</td>
                    </tr>
                {/foreach}
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
    </style>
</html> 