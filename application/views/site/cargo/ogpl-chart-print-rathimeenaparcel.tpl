<html>

<head>
    <title>OGPL Chart</title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    <style>   
    .lr{  font-size: 12pt;  font-weight: bold;  letter-spacing: 1.5px; }
</style>
{assign var="is_ogpl_completed" value=in_array('COMPLETE',$ogpl->activity)}
</head>

<body>
    <table cellpadding="5" width="100%">        
        <tr>
            <td width="100%" colspan="3" align="center" style="font-weight:bold; font-size: 20px;">{$namespace_name}</td>
        </tr>
        <tr>
            <td width="100%" colspan="3"><b>{lang('ogpl')} Number:</b> {$ogpl->aliasCode}</td>
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
        {if $ogpl->remarks}
            <tr>
                <td width="100%" colspan="3"><b>Remarks:</b> {$ogpl->remarks}</td>
            </tr>
        {/if}
    </table>
    <br />
    <table class="bordered" cellpadding="3" width="96%">
        <thead>
            <tr class="info bold">
                <td align="center" rowspan="2">S.No</td>
                <td align="center" rowspan="2">{lang('lr')}</td>
                <td align="center" rowspan="2">Qty</td>
                <td align="center" rowspan="2">Booked At</td>
                {* <td align="center" rowspan="2">Booked At</td> *}
                <td align="center" rowspan="2">Delivery At</td>
                               
                {* <td align="center" rowspan="2">Booked By</td> *}
                <td align="center" rowspan="2">Payment Status</td>
                <td align="center" colspan="4">Amount</td>
            </tr>
            <tr class="info bold">
                <td align="center">Freight</td>
                <td align="center">{lang('other_charges')}</td>
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

            {foreach item=row1 from=$result key=t1 }
                <tr>
                    <td align="center" colspan="14"><b>{$routes[$t1]}</b></td>
                </tr>
                {foreach item=row from=$row1 key=t }

                    {assign var='o_qty' value=$o_qty+$row->total_item_count}

                    <tr>
                        <td align="center">{$sno}</td>
                        <td align="center" class="lr">{$row->cargo_code}</td>
                        <td align="center">{$row->total_item_count}</td>
                        {* <td align="center" nowrap>{$row->booked_at|date_format:$ns_date_format}</td> *}
                        <td align="center">{$row->from_organization_short_code}</td>
                        <td align="center">{$row->to_organization_short_code}</td>
                                             
                        {* <td align="left">{$row->user_first_name}</td> *}
                        <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>

                        <td align="right">
                            {($row->total_amount)|number_format:2}
                            {assign var='o_freight_tot_amount' value=$row->total_amount + $o_freight_tot_amount}
                        </td>
                        <td align="right">
                            {$row->other_charges_amount|number_format:2}
                            {assign var=o_other_tot_amount value=$o_other_tot_amount + $row->other_charges_amount}
                        </td>
                        <td align="right">
                            {if $row->total_amount_paid > 0}
                                {$row->total_amount_paid|number_format:2}
                                {assign var='o_pd_tot_amount' value=$row->total_amount_paid + $o_pd_tot_amount}
                            {else}
                                0.00
                            {/if}
                        </td>
                        <td align="right">
                            {if $row->payment_status_code == 'TOP'}
                                {assign var="topay" value=($row->total_amount + $row->other_charges_amount)-$row->total_amount_paid}
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
                    <td colspan="3">&nbsp;</td>
                    <td align="right">{$o_freight_tot_amount|number_format:2}</td>
                    <td align="right">{$o_other_tot_amount|number_format:2}</td>
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
    <br />
    {if $action_rights['OGPL-PAY-SUMRY']==1}
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
                {assign var="net_total" value=0}

            <tbody class="body_table">
                {foreach item=route from=$summary key=key }
                    <tr>
                        <td align="center" colspan="9"><b>{$routes[$key]}</b></td>
                    </tr>
                    {foreach item=row from=$route key=k }
                        <tr>
                            {assign var=total value=$row['freight']+$row['loading']+$row['unloading']+$row['service_tax']+$row['delivery']}
                            <td align="center"><b>{$cargo_payment_status[$k]}</b></td>
                            <td align="center">{$row['lr']}</td>
                            <td align="center">{$row['packages']}</td>
                            <td align="center">{$row['freight']|number_format:2}</td>
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
                        {assign var="net_total" value=$net_total+$total}
                    {/foreach}
                {/foreach}
                <tr>
                    <td align="center"><b>Total</b></td>
                    <td align="center"><b>{$total_lr}</b></td>
                    <td align="center"><b>{$total_pkgs}</b></td>
                    <td align="center"><b>{$total_frieght|number_format:2}</b></td>
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

    <div class="background-image"></div>
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
