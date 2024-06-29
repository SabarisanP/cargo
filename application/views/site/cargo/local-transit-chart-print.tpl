<html>
    <head>
        <title>{lang('ogpl_local_transit')} Chart</title>
        <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    </head>
    <body>
    {assign var="is_ogpl_completed" value=in_array('COMPLETE',$ogpl->activity)}
        <table cellpadding="5" width="100%">
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
                    {if $namespace != "rajeshcargo" && $namespace!="rajeshexpress"}
                    <td align="center" rowspan="2">Booked Date</td>
                    {/if}
                    <td align="center" rowspan="2">Booked At</td>
                    <td align="center" rowspan="2">Delivery At</td>
                    {if $namespace != "rajeshcargo" && $namespace!="rajeshexpress"}
                    <td align="center" rowspan="2">{lang('booking_sender_term')} Name</td>
                    <td align="center" rowspan="2">{lang('booking_sender_term')} Mobile</td>
                    <td align="center" rowspan="2">{lang('booking_receiver_term')} Name</td>
                    <td align="center" rowspan="2">{lang('booking_receiver_term')} Mobile</td>
                    <td align="center" rowspan="2">Booked By</td>
                    <td align="center" rowspan="2">Payment Status</td>
                    <td align="center" colspan="4">Amount</td>
                    {/if}
                </tr>
                {if $namespace != "rajeshcargo" && $namespace!="rajeshexpress"}
                <tr class="info bold">
                    <td align="center">Freight</td>
                    <td align="center">{lang('other_charges')}</td>
                    <td align="center">Paid</td>
                    <td align="center">To Pay</td>
                </tr>
                {/if}
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
                        <td align="center" colspan="{if $namespace != "bits"}16{else}5{/if}"><b>{$t1}</b></td>
                    </tr>
                    {foreach item=row from=$row1 key=t }

                        {assign var='o_qty' value=$o_qty+$row->total_item_count}

                        <tr>
                            <td align="center">{$sno}</td>
                            <td align="center">{$row->cargo_code}</td>
                            <td align="center">{$row->total_item_count}</td>
                            {if $namespace != "rajeshcargo" && $namespace!="rajeshexpress"}
                            <td align="center" nowrap>{$row->booked_at|date_format:$ns_date_format}</td>
                            {/if}
                            <td align="center">{$row->from_organization_name}</td>
                            <td align="center">{$row->to_organization_name}</td>
                            {if $namespace != "rajeshcargo" && $namespace!="rajeshexpress"}
                            <td align="left">{$row->from_customer_name}</td>
                            <td align="center">{$row->from_customer_mobile}</td>
                            <td align="left">{$row->to_customer_name}</td>
                            <td align="center">{$row->to_customer_mobile}</td>
                            <td align="left">{$row->user_first_name}</td>
                            <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>

                            <td align="right">
                                {($row->total_amount)|number_format:2}
                                {assign var='o_freight_tot_amount' value=$row->total_amount + $o_freight_tot_amount}
                            </td>
                            <td align="right">
                                {$row->other_charges_amount|number_format:2}
                                {assign var='o_other_tot_amount' value=$o_other_tot_amount + $row->other_charges_amount}
                            </td>
                            <td align="right">
                                {assign var="paid" value=0}
                                {if $row->payment_status_code == 'PAD'}
                                    {assign var="paid" value=($row->total_amount + $row->other_charges_amount)}
                                    {$paid|number_format:2}
                                    {assign var='o_pd_tot_amount' value=$paid + $o_pd_tot_amount}
                                {else}
                                    0.00
                                {/if}
                            </td>
                            <td align="right" >
                                {if $row->payment_status_code == 'TOP'}
                                    {assign var="topay" value=($row->total_amount +$row->other_charges_amount)}
                                    {$topay|number_format:2}
                                    {assign var='o_pb_tot_amount' value=$topay+$o_pb_tot_amount}
                                {else}
                                    0.00
                                {/if}
                            </td>
                            {/if}
                        </tr>
                        {assign var='sno' value=$sno+1}
                    {/foreach}
                    {if $namespace != "rajeshcargo" && $namespace!="rajeshexpress"}
                    <tr>
                        <td align="center"></td>
                        <td align="center"></td>
                        <td align="center" class="bold">{$o_qty}</td>
                        <td colspan="9">&nbsp;</td>
                        <td align="right">{$o_freight_tot_amount|number_format:2}</td>
                        <td align="right">{$o_other_tot_amount|number_format:2}</td>
                        <td align="right">{$o_pd_tot_amount|number_format:2}</td>
                        <td align="right" class="bold">{$o_pb_tot_amount|number_format:2}</td>
                    </tr>
                    {/if}
                {foreachelse}
                    <tr>
                        <td align="center" colspan="{if $namespace != "bits"}16{else}5{/if}">Sorry! No cargo found</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
        <br>
        {if $action_rights['LOCTRNT-PAY-SUMRY']==1}        
            <table width='100%' cellpadding="3">
                <tr>
                    <td><span class="bold">Summary</span></td>
                </tr>
            </table>
            <table class="table table-bordered" cellpadding="3" width="96%">
                <thead>
                    <tr class="info bold">
                        <td align="center">{lang('lr')} Type</td>
                        <td align="center">No.of {lang('lr')}s</td>
                        <td align="center">No.of {lang('booking_article_label')}</td>
                        <td align="center">Freight</td>
                        <td align="center">Loading Charges</td>
                        <td align="center">Unloading Charges</td>
                        <td align="center">Pickup Charges</td>
                        <td align="center">Delivery Charges</td>
                        <td align="center">Other Charges</td>
                        <td align="center">Service Tax</td>
                        <td align="center">Total</td>
                    </tr>
                    {assign var="total" value=0}
                    {assign var="total_lr" value=0}
                    {assign var="total_pkgs" value=0}
                    {assign var="total_frieght" value=0}
                    {assign var="total_loading" value=0}
                    {assign var="total_unloading" value=0}
                    {assign var="total_pickup" value=0}
                    {assign var="total_delivery" value=0}
                    {assign var="total_other" value=0}
                    {assign var="total_service_tax" value=0}
                    {assign var="net_total" value=0}

                <tbody class="body_table">
                    {foreach item=row1 from=$summary key=k }
                        <tr>
                            <td align="center" colspan="14"><b>{$k}</b></td>
                        </tr>
                    {foreach item=row from=$row1 key=t }
    
                        {assign var='o_qty' value=$o_qty+$row->total_item_count}
    
                        <tr>
                            {assign var=total value=$row['freight']+$row['loading']+$row['unloading']+$row['service_tax']+$row['pickup']+$row['delivery']+$row['other']}
                            <td align="center"><b>{$cargo_payment_status[$t]}</b></td>
                            <td align="center">{$row['lr']}</td>
                            <td align="center">{$row['packages']}</td>
                            <td align="center">{$row['freight']|number_format:2}</td> 
                            <td align="center">{$row['loading']|number_format:2}</td>
                            <td align="center">{$row['unloading']|number_format:2}</td> 
                            <td align="center">{$row['pickup']|number_format:2}</td>
                            <td align="center">{$row['delivery']|number_format:2}</td>
                            <td align="center">{$row['other']|number_format:2}</td>
                            <td align="center">{$row['service_tax']|number_format:2}</td>
                            <td align="center">{$total|number_format:2}</td>
                        </tr>

                    {assign var="total_lr" value=$total_lr+$row['lr']}
                    {assign var="total_pkgs" value=$total_pkgs+$row['packages']}
                    {assign var="total_frieght" value=$total_frieght+$row['freight']}
                    {assign var="total_loading" value=$total_loading+$row['loading']}
                    {assign var="total_unloading" value=$total_unloading+$row['unloading']}
                    {assign var="total_pickup" value=$total_pickup+$row['pickup']}
                    {assign var="total_delivery" value=$total_delivery+$row['delivery']}
                    {assign var="total_other" value=$total_other+$row['other']}
                    {assign var="total_service_tax" value=$total_service_tax+$row['service_tax']}
                    {assign var="net_total" value=$net_total+$total}
                    {/foreach}
                {/foreach}
                </tbody>
                <tfoot>
                    <tr class="success">
                        <td align="center"><b>Total</b></td>
                        <td align="center"><b>{$total_lr}</b></td>
                        <td align="center"><b>{$total_pkgs}</b></td>
                        <td align="center"><b>{$total_frieght|number_format:2}</b></td>
                        <td align="center"><b>{$total_loading|number_format:2}</b></td>
                        <td align="center"><b>{$total_unloading|number_format:2}</b></td>   
                        <td align="center"><b>{$total_pickup|number_format:2}</b></td>
                        <td align="center"><b>{$total_delivery|number_format:2}</b></td>
                        <td align="center"><b>{$total_other|number_format:2}</b></td>
                        <td align="center"><b>{$total_service_tax|number_format:2}</b></td> 
                        <td align="center"><b>{$net_total|number_format:2}</b></td>              
                    </tr>
                </tfoot>
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
    </style>
</html> 