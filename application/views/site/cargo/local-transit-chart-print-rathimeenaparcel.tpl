<html>
    <head>
        <title>{lang('ogpl_local_transit')} Chart</title>
        <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    </head>
    <body>
        <table cellpadding="5" width="100%">
        {assign var="is_ogpl_completed" value=in_array('COMPLETE',$ogpl->activity)}
            <tr>
                <td width="100%" colspan="3"><b>{lang('ogpl_local_transit')} Number:</b> {$ogpl->aliasCode}</td>
            </tr>
            <tr>
            <td width="40%"><b>Trip Date:</b> {$ogpl->tripDate|date_format:$ns_date_format}</td>
            <td width="40%"><b>Vehicle :</b> {$ogpl->busVehicle->registationNumber}</td>
            {if $is_ogpl_completed}
                <td width="20%"><b>Start Odometer:</b> {$odoDetails['fromOdoDetail']->startOdometer}</td>
            {else}
                <td><b>Start Odometer:</b>
                {if isset($odoDetails['myOdoDetail'])} 
                  {$odoDetails['myOdoDetail']->startOdometer}
                {else} 
                  0
                {/if}
                </td>
            {/if}
            
        </tr>
        <tr>
            <td width="40%"><b>Route:</b> {$ogpl->fromOrganization->name} to {$ogpl->toOrganization->name}</td>
            <td width="40%"><b>Driver :</b> {$ogpl->vehicleDriver->name}, {$ogpl->vehicleDriver->mobileNumber}</td>
            {if $is_ogpl_completed}
                <td width="20%"><b>End Odometer:</b> {$odoDetails['toOdoDetail']->endOdometer}</td>
            {else}
                <td></td>
            {/if}
           
        </tr>
        </table>
        <br/>
        <table class="bordered" cellpadding="3" width="96%">
            <thead>
                <tr class="info bold">
                    <td align="center" rowspan="2">S.No</td>
                    <td align="center" rowspan="2">{lang('lr')}</td>
                    <td align="center" rowspan="2">Qty</td>                    
                    <td align="center" rowspan="2">Booked Date</td>                   
                    <td align="center" rowspan="2">Booked At</td>
                    <td align="center" rowspan="2">Delivery At</td>                    
                    <td align="center" rowspan="2">{lang('booking_sender_term')} Name</td>                    
                    <td align="center" rowspan="2">{lang('booking_receiver_term')} Name</td>                   
                    <td align="center" rowspan="2">Booked By</td>
                    <td align="center" rowspan="2">Payment Status</td>
                    <td align="center" colspan="4">Amount</td>
                    
                </tr>
                
                <tr class="info bold">
                    <td align="center">Freight</td>
                    <td align="center">Handling</td>
                    <td align="center">Paid</td>
                    <td align="center">To Pay</td>
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
                    <tr>
                        <td align="center" colspan="{if $namespace != "bits"}16{else}5{/if}"><b>{$t1}</b></td>
                    </tr>
                    {foreach item=row from=$row1 key=t }

                        {assign var='o_qty' value=$o_qty+$row->total_item_count}

                        <tr>
                            <td align="center">{$sno}</td>
                            <td align="center" class="lr">{$row->cargo_code}</td>
                            <td align="center">{$row->total_item_count}</td>                            
                            <td align="center" nowrap>{$row->booked_at|date_format:$ns_date_format}</td>                            
                            <td align="center">{$row->from_organization_short_code}</td>
                            <td align="center">{$row->to_organization_short_code}</td>                            
                            <td align="left">{$row->from_customer_name}</td>                            
                            <td align="left">{$row->to_customer_name}</td>                            
                            <td align="left">{$row->user_first_name}</td>
                            <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>

                            <td align="right">
                                {($row->total_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax)|number_format:2}
                                {assign var='o_freight_tot_amount' value=$row->total_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $o_freight_tot_amount}
                            </td>
                            <td align="right">
                                {$row->total_handling_amount|number_format:2}
                                {assign var='o_handling_tot_amount' value=$row->total_handling_amount + $o_handling_tot_amount}
                            </td>
                            <td align="right">
                                {if $row->total_amount_paid > 0}
                                    {$row->total_amount_paid|number_format:2}
                                    {assign var='o_pd_tot_amount' value=$row->total_amount_paid + $o_pd_tot_amount}
                                {else}
                                    0.00
                                {/if}
                            </td>
                            <td align="right" >
                                {if $row->payment_status_code == 'TOP'}
                                    {assign var="topay" value=($row->total_amount +$row->handling +$row->total_handling_amount +$row->total_unload_handling_amount +$row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax)-$row->total_amount_paid}
                                    {$topay|number_format:2}
                                    {assign var='o_pb_tot_amount' value=$topay+$o_pb_tot_amount}
                                {else}
                                    0.00
                                {/if}
                            </td>
                            
                        </tr>
                        {assign var='sno' value=$sno+1}
                    {/foreach}
                    
                    <tr>
                        <td align="center"></td>
                        <td align="center"></td>
                        <td align="center" class="bold">{$o_qty}</td>
                        <td colspan="7">&nbsp;</td>
                        <td align="right">{$o_freight_tot_amount|number_format:2}</td>
                        <td align="right">{$o_handling_tot_amount|number_format:2}</td>
                        <td align="right">{$o_pd_tot_amount|number_format:2}</td>
                        <td align="right" class="bold">{$o_pb_tot_amount|number_format:2}</td>
                    </tr>
                    
                {foreachelse}
                    <tr>
                        <td align="center" colspan="14">Sorry! No cargo found</td>
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