<html>

<head>
    <title>OGPL Chart</title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    <style>
        .bold{ font-weight: bold;}
    </style>
</head>

<body>
    <table cellpadding="5" width="100%">        
        <tr>
            <td width="100%" colspan="2" align="center" style="font-weight:bold; font-size: 20px;">{$namespace_name}</td>
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
    <br />
    <table class="bordered" cellpadding="3" width="96%">
        <thead>
            <tr class="info bold">
                <td align="center">S.No</td>
                <td align="center">{lang('lr')} No.</td>
                <td align="center">{lang('booking_sender_term')}</td>                
                <td align="center">{lang('booking_receiver_term')}</td>                
                <td align="center">Qty</td>
                <td align="center">Article</td>
                <td align="center">Paid(A)</td>
                <td align="center">To Pay(B)</td>
                <td align="center">Load Ch</td>
                <td align="center">Total(A+B)</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var='o_qty' value=0}
            {assign var='sno' value=1}
            {assign var="load_ch" value=0}

            {assign var='o_pd_tot_amount' value=0}
            {assign var='o_pb_tot_amount' value=0}
            {$txn_mode = array()}
            {foreach item=row1 from=$result key=t1 }
                {foreach item=row from=$row1 key=t }

                    {assign var='o_qty' value=$o_qty+$row->total_item_count}

                    <tr>
                        <td align="center" width="5%">{$sno}</td>
                        <td align="center" width="10%">{$row->cargo_code}</td>
                        <td align="left" width="14%">{$row->from_customer_name}</td>                        
                        <td align="left" width="14%">{$row->to_customer_name}</td>                    

                        <td align="center" width="3%">{$row->total_item_count}</td>                        
                        <td align="left" width="9%">{$row->cargo_item_name}</td>   
                        
                        <td align="right" width="9%">
                            {assign var="paid" value=0}
                            {if $row->payment_status_code == 'PAD'}
                                {assign var="paid" value=($row->total_amount + $row->docket_charge + $row->total_handling_amount + $row->service_tax)}
                                {$paid|number_format:2}
                                {assign var='o_pd_tot_amount' value=$paid + $o_pd_tot_amount}
                            {else}
                                0.00
                            {/if}
                        </td>
                        <td align="right" width="9%">
                            {assign var="topay" value=0}
                            {if $row->payment_status_code == 'TOP' || $row->payment_status_code == 'TPPAD'}
                                {assign var="topay" value=($row->total_amount + $row->docket_charge + $row->total_handling_amount + $row->service_tax)}
                                {$topay|number_format:2}
                                {assign var='o_pb_tot_amount' value=$topay+$o_pb_tot_amount}
                            {else}
                                0.00
                            {/if}
                        </td>

                        <td align="right" width="8%">
                            {if $row->payment_status_code == 'PAD' || $row->payment_status_code == 'TOP' || $row->payment_status_code == 'TPPAD'}
                                {assign var='load_ch' value=$load_ch+$row->total_handling_amount}
                                {$row->total_handling_amount|number_format:2}
                            {else}
                                0.00
                            {/if}
                        </td>                        

                        <td align="right" width="9%">
                            {($paid+$topay)|number_format:2}
                        </td>
                    </tr>
                    {assign var='sno' value=$sno+1}

                    {if $row->payment_status_code == 'PAD'}
                        {$txn_mode[$row->transaction_mode_code] = $txn_mode[$row->transaction_mode_code] + $row->total_amount + $row->docket_charge + $row->total_handling_amount + $row->service_tax}
                    {/if}
                {/foreach}
                <tr>
                    <td colspan="4">&nbsp;</td>
                    <td align="center"><b>{$o_qty}</b></td>
                    <td></td>
                    <td align="right"><b>{$o_pd_tot_amount|number_format:2}</b></td>
                    <td align="right"><b>{$o_pb_tot_amount|number_format:2}</b></td>
                    <td align="right"><b>{$load_ch|number_format:2}</b></td>
                    <td align="right"><b>{($o_pd_tot_amount+$o_pb_tot_amount)|number_format:2}</b></td>
                </tr>
            {foreachelse}
                <tr>
                    <td align="center" colspan="9">Sorry! No cargo found</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
    <br />
    {if $action_rights['OGPL-PAY-SUMRY']==1}
        <table width="96%" cellpadding="3">
            <tr>
                <td width="50%">
                    <table width='80%'>
                        <tr>
                            <td class="bold">Summary</td>
                        </tr>
                    </table>
                    <table width='80%' class="bordered" cellpadding="3">
                        <tr>
                            <td align="left" width="50%">Total (C)</td>
                            <td align="right" width="50%">{($o_pd_tot_amount+$o_pb_tot_amount)|number_format:2}</td>
                        </tr>
                        <tr>
                            <td align="left" width="50%">Topay (Freight + Loading) (D)</td>
                            <td align="right" width="50%">
                                {$o_pb_tot_amount|number_format:2}
                            </td>
                        </tr>
                        <tr>
                            <td align="left">Loading Charges (E)</td>
                            <td align="right" width="50%">{$load_ch|number_format:2}</td>
                        </tr>
                        <tr>
                            <td align="left" class="bold" width="50%">Net Payable (C-D-E)</td>
                            <td align="right" width="50%"><b>{($o_pd_tot_amount+$o_pb_tot_amount-$o_pb_tot_amount-$load_ch)|number_format:2}</b></td>
                        </tr>
                    </table>
                </td>

                <td width="50%">
                    <table width='80%'>
                        <tr>
                            <td class="bold">Payment Mode</td>
                        </tr>
                    </table>
                    <table width='80%' class="bordered" cellpadding="3">
                        {assign var="pay_mode_tot" value=0}
                        {foreach from=$txn_mode item=val key=key}
                            {if $key != 'NA'}
                                <tr>
                                    <td align="left">{$transaction_mode[$key]}</td>
                                    <td align="right">{$val|number_format:2}</td>
                                    {assign var='pay_mode_tot' value=$val+$pay_mode_tot}
                                </tr>
                            {/if}
                        {/foreach}
                        <tr>
                            <td align="left" class="bold">Total</td>
                            <td align="right"><b>{$pay_mode_tot|number_format:2}</b></td>
                        </tr>
                    </table>
                </td>
            </tr>
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
