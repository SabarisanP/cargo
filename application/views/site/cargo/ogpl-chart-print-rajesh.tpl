<html>
    <head>
        <title>OGPL Chart</title>
        <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    </head>
    <body>
        <table cellpadding="5" width="100%">
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
        </table>
        <br/>
        <table class="bordered" cellpadding="3" width="96%">
            <thead>
                <tr class="info bold">
                    <td align="center" >S.No</td>
                    <td align="center" >{lang('lr')} No</td>
                    <td align="center" >{lang('lr')} Booked Date</td>
                    <td align="center" >{lang('booking_from_term')} Branch</td>
                    <td align="center" >{lang('booking_to_term')} Branch</td>
                    <td align="center" >Booked By</td>
                    <td align="center" >Payment Status</td>
                    <td align="center" >Quantity </td>
                    <td align="center" >Remarks</td>
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

                {foreach item=row1 from=$result key=t1 }
                    <tr>
                        <td align="center" colspan="9"><b>{$routes[$t1]}</b></td>
                    </tr>
                    {foreach item=row from=$row1 key=t }

                        {assign var='o_qty' value=$o_qty+$row->total_item_count}

                        <tr>
                            <td align="center">{$sno}</td>
                            <td align="center">{$row->cargo_code}</td>
                            <td align="center" nowrap>{$row->booked_at|date_format:$ns_date_format}</td>
                            <td align="center">{$row->from_organization_name}</td>
                            <td align="center">{$row->to_organization_name}</td>
                            <td align="left">{$row->user_first_name}</td>
                            <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>
                            <td align="center">{$row->total_item_count}</td>
                            <td align="left" >
                                {if $row->remarks}
                                    {$row->remarks}
                                {else}
                                -    
                                {/if}
                            </td>
                        </tr>
                        {assign var='sno' value=$sno+1}
                    {/foreach}
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td align="center"  class="bold">{$o_qty}</td>
                        <td></td>
                    </tr>
                {foreachelse}
                    <tr>
                        <td align="center" colspan="9">Sorry! No cargo found</td>
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