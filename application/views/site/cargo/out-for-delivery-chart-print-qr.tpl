<html>
    <head>
        <title>Door Pickup and Delivery Chart</title>
        <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    </head>
    <body>        
        {assign var='o_qty' value=0}
        {assign var='tot_lr' value=0}
        {assign var='sno' value=1}
        <table cellpadding="5" width="100%">
            <tr>
                <td align="right" style="font-size: 10px;">
                    Printed By {$username} @ {$smarty.now|date_format:$ns_datetime_format}
                    <hr/>
                </td>
            </tr>
            <tr>
                <td width="50%"><b>Delivery List Number:</b> {$ogpl->aliasCode}</td>
                
            </tr>
            <tr>
                <td width="50%"><b>Branch:</b> {$branch}</td>
                
            </tr>
            {*<tr>
                <td width="50%" colspan="2"><b>Trip Date:</b> {$ogpl->tripDate|date_format:$ns_date_format}</td>

            </tr>*}
            
            <tr>
                <td width="50%" colspan="2"><b>Vehicle & Driver :</b> {$ogpl->busVehicle->registationNumber} {if isNotNull($ogpl->vehicleDriver->name)}- {$ogpl->vehicleDriver->name}{/if} {if isNotNull($ogpl->vehicleDriver->mobileNumber)}, {$ogpl->vehicleDriver->mobileNumber} {/if}</td>
            </tr>
            <tr>
                <td><b>Total No.of {lang('lr')} :</b><span id="totLR"></span> </td>
            </tr>
            <tr>
                <td><b>Total No.Of {lang('booking_article_label')} :</b> <span id="totItem"></span></td>
            </tr>
        </table>
        {assign var="ogplCode" value=$ogpl->aliasCode}
        <div class="qrcode" id="qrcode-ogpl" data-lr="{generate_slug(['{$ogplCode}'])}"></div>


        <br/>

        <h5><b>Door Delivery</b></h5>
        <table class="bordered" cellpadding="3" width="96%">
            <thead>
                <tr class="info bold">
                    <td align="center" rowspan="2">S.No</td>
                    <td align="center" rowspan="2">{lang('lr')}</td>
                    <td align="center" rowspan="2">Sender</td>
                    <td align="center" rowspan="2">Receiver</td>
                    <td align="center" rowspan="2">Qty</td>
                    <td align="center" rowspan="2">Qr</td>
                    <td align="center" rowspan="2">Payment Status</td>
                    <td align="center" rowspan="2">To Pay</td>
                    <td align="center" rowspan="2">Address</td>
                    <td align="center" rowspan="2">Signature</td>
                </tr>
            </thead>
            <tbody>
                {assign var='o_freight_tot_amount' value=0}
                {assign var='o_handling_tot_amount' value=0}

                {assign var='o_pd_tot_amount' value=0}
                {assign var='o_pb_tot_amount' value=0}

                {foreach item=row1 from=$result key=t1 }
                    {foreach item=row from=$row1 key=t }

                        {assign var='o_qty' value=$o_qty + $row->total_item_count}
                        {assign var='tot_lr' value=$tot_lr+$sno}
                        <tr>
                            <td align="center">{$sno}</td>
                            <td align="center">{$row->cargo_code}</td>
                            <td align="left">{$row->from_customer_name} <br/> {$row->from_customer_mobile}</td>
                            <td align="left">{$row->to_customer_name} <br/>  {$row->to_customer_mobile}</td>
                            <td align="center">{$row->total_item_count}</td>
                            <td align="center">
                            {* namespace_id , cargo_id *}
                                 {* {generate_slug([{$row->namespace_id}, {$row->cargo_id}])} *}
                                <div class="qrcode" data-lr="{generate_slug([{$row->namespace_id}, {$row->cargo_id}])}"></div> 
                            </td>
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
                        <td align="center"></td>
                        <td align="center"></td>
                        <td align="center" class="bold">{$o_qty}</td>
                        <td colspan="2">&nbsp;</td>
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

        <h5><b>Door Pickup</b></h5>
        <table class="bordered" cellpadding="3" width="96%">
            <thead>
                <tr class="info bold">
                    <td align="center" rowspan="2">S.No</td>
                    <td align="center" rowspan="2">{lang('lr')}</td>
                    <td align="center" rowspan="2">Sender</td>
                    <td align="center" rowspan="2">Receiver</td>
                    <td align="center" rowspan="2">Qty</td>
                    <td align="center" rowspan="2">Qr</td>
                    <td align="center" rowspan="2">Payment Status</td>
                    <td align="center" rowspan="2">To Pay</td>
                    <td align="center" rowspan="2">Address</td>
                    <td align="center" rowspan="2">Signature</td>
                </tr>
            </thead>
            <tbody>
                {assign var='o_freight_tot_amount' value=0}
                {assign var='o_handling_tot_amount' value=0}

                {assign var='o_pd_tot_amount' value=0}
                {assign var='o_pb_tot_amount' value=0}

                {foreach item=row1 from=$prebook key=t1 }
                    {foreach item=row from=$row1 key=t }

                        {assign var='o_qty' value=$o_qty + $row->total_item_count}
                        {assign var='tot_lr' value=$tot_lr+$sno}
                        <tr>
                            <td align="center">{$sno}</td>
                            <td align="center">{$row->cargo_code}</td>
                            <td align="left">{$row->from_customer_name} <br/> {$row->from_customer_mobile}</td>
                            <td align="left">{$row->to_customer_name} <br/>  {$row->to_customer_mobile}</td>
                            <td align="center">{$row->total_item_count}</td>
                            <td align="center">
                                <div class="qrcode" data-lr="{$row->cargo_code}"></div>
                            </td>
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
                        <td align="center"></td>
                        <td align="center"></td>
                        <td align="center" class="bold">{$o_qty}</td>
                        <td colspan="2">&nbsp;</td>
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
        #qrcode-ogpl{
            height: 50px;
            float: right;
            margin-right: 7em;
            margin-top: -9.8em;
        }
    </style>
</html> 

<script src="{$base_url}assets/lib/qrcode/qrcode.min.js?{$asset_ver}"></script>
<script src="{$base_url}assets/js/jquery.min.js?{$asset_ver}"></script>
<script>
    $(".qrcode").each(function () {
        var $this = $(this);
        var qrcode = new QRCode($this.get(0), {
            text: $this.data("lr"),
            width: 100,
            height: 100
        });
    });
    
    var totLr = {$sno|json_encode};
    var totItem = {$o_qty|json_encode};
    
    $('#totLR').text(Number(totLr) -1);
    $('#totItem').text(totItem);

</script>