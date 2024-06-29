

<html>
    <head>
        <title>OGPL Chart</title>
        <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
        <style>
        *{ font-size: 12px}
        </style>
    </head>
    <body>
        <table cellpadding="5" width="100%">
            <tr>
                <td width="100%" colspan="2" align="center" style="font-size:20px; font-weight:bold;">SKS Travels & Cargo</td>
            </tr>
            <tr>
                <td width="100%" colspan="2" align="center" style="font-size:12px">
                    No.15/1, Lalbagh fort Road,<br>
                    Near Basappa Circle, Kalasipalyam, Bangalore - 560002.<br>
                    <b>Tel:</b> +91 080-42129000 <b>GSTIN :</b> 29AEEPA2429K1ZL<br>
                    For Hyderabad Luggage Delivery Contact No. : 9505137397
                </td>
            </tr>
            <tr>
                <td width="100%" colspan="2" align="center" style="font-size:15px">LOADING SHEET</td>
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
        </table>
        <br/>
        <table class="bordered" cellpadding="3" width="96%">
            <thead>
                <tr class="info bold">
                    <td align="center">S.No</td>
                    <td align="center">{lang('lr')}</td>
                    <td align="center">Qty</td>                    
                    <td align="center">{lang('booking_receiver_term')} Name</td>
                    <td align="center">{lang('lr')} Type</td>
                    
                    <td align="center">Freight</td>                    
                    <td align="center">Loading</td>
                    <td align="center">Un Loading</td>                    
                    <td align="center">Docket Charges</td>                    
                    <td align="center">ST</td>
                    <td align="center">Total</td>

                </tr>
                <tr class="info bold">
                    
                    
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
                
                
                {assign var='o_loading_amount' value=0}                
                {assign var='o_del_handilng_amount' value=0}               
                {assign var='o_hamali_amount' value=0}               
                {assign var='o_pass_amount' value=0}               
                {assign var='o_docket_amount' value=0}               
                {assign var='o_service_amount' value=0}               
                {assign var='o_service_tax_amount' value=0}               
                {assign var='o_tot_handling_amount' value=0}               
                {assign var='o_tot_unload_handling_amount' value=0}         
                {assign var='o_pod_amount' value=0}

                {foreach item=row1 from=$result key=t1 }
                    <tr>
                        <td align="center" colspan="11"><b>{$routes[$t1]}</b></td>
                    </tr>
                    {foreach item=row from=$row1 key=t }

                        {assign var='o_qty' value=$o_qty+$row->total_item_count}

                        <tr>
                            <td align="center">{$sno}</td>
                            <td align="center">{$row->cargo_code}</td>
                            <td align="center">{$row->total_item_count}</td>                            
                            <td align="left">{$row->to_customer_name}</td>
                            <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>
                            <td align="right">
                                {($row->total_amount)}
                                {assign var='o_freight_tot_amount' value=$row->total_amount + $o_freight_tot_amount}
                            </td>                            
                            <td align="right">
                                {$row->total_handling_amount}
                            </td>
                            <td align="right">
                                {$row->total_unload_handling_amount}
                            </td>
                            <td align="right">
                                {$row->docket_charge}
                            </td>                            
                            <td align="right">
                                {$row->service_tax}
                            </td>                    
                           
                            <td align="right" >
                                {$row->total_amount + $row->other_charges_amount}
                            </td>
                        </tr>
                        {assign var='o_loading_amount' value=$row->pickup_handling_amount + $o_loading_amount}
                        {assign var='o_del_handilng_amount' value=$row->delivery_handling_amount + $o_del_handilng_amount}
                        {assign var='o_hamali_amount' value=$row->hamali_charge + $o_hamali_amount}
                        {assign var='o_pass_amount' value=$row->pass_charge + $o_pass_amount}
                        {assign var='o_docket_amount' value=$row->docket_charge + $o_docket_amount}
                        {assign var='o_service_amount' value=$row->service_charge + $o_service_amount}
                        {assign var='o_service_tax_amount' value=$row->service_tax + $o_service_tax_amount}
                        {assign var='o_tot_handling_amount' value=$row->total_handling_amount + $o_tot_handling_amount}
                        {assign var='o_tot_unload_handling_amount' value=$row->total_unload_handling_amount + $o_tot_unload_handling_amount}
                        {assign var='o_pod_amount' value=$row->total_amount + $row->other_charges_amount + $o_pod_amount}
                        
                        
                        {assign var='sno' value=$sno+1}
                    {/foreach}
                    <tr>
                        <td align="center"></td>
                        <td align="center"></td>
                        <td align="center" class="bold">{$o_qty}</td>
                        <td colspan="2">&nbsp;</td>
                        <td align="right">{$o_freight_tot_amount}</td>                        
                        <td align="right">{$o_tot_handling_amount}</td>
                        <td align="right">{$o_tot_unload_handling_amount}</td>                        
                        <td align="right">{$o_docket_amount}</td>                        
                        <td align="right">{$o_service_tax_amount}</td>
                        <td align="right" class="bold">{$o_pod_amount}</td>
                    </tr>
                {foreachelse}
                    <tr>
                        <td align="center" colspan="11">Sorry! No cargo found</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
            <br/>
       
            <table width='96%'>
                <tr>
                    <td><span class="bold"><b>Summary</b></span></td>
                </tr>
            </table>
            <table width='96%' border="1" cellpadding="3">
                <thead>
                    <tr class="success">
                        <td align="center">{lang('lr')} Type</td>
                        <td align="center">No.of {lang('lr')}s</td>
                        <td align="center">No.of {lang('booking_article_label')}</td>
                        <td align="center">Freight</td>
                        <td align="center">Loading Charges</td>
                        <td align="center">Unloading Charges</td>
                        <td align="center">Delivery Charges</td>
                        <td align="center">Docket Charges</td>
                        <td align="center">ST</td>                        
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
                    {assign var="total_docket" value=0}
                    {assign var="net_total" value=0}

                <tbody class="body_table">
                    {foreach item=route from=$summary key=key }
                        {foreach item=row from=$route key=k }
                        <tr>
                            {assign var=total value=$row['freight']+$row['loading']+$row['unloading']+$row['service_tax']+$row['docket']+$row['delivery']}
                            <td align="center"><b>{$cargo_payment_status[$k]}</b></td>
                            <td align="center">{$row['lr']}</td>
                            <td align="center">{$row['packages']}</td>
                            <td align="center">{$row['freight']}</td> 
                            <td align="center">{$row['loading']}</td>
                            <td align="center">{$row['unloading']}</td>
                            <td align="center">{$row['delivery']}</td>
                            <td align="center">{$row['docket']}</td> 
                            <td align="center">{$row['service_tax']}</td>                            
                            <td align="center">{$total}</td>
                        </tr>

                    {assign var="total_lr" value=$total_lr+$row['lr']}
                    {assign var="total_pkgs" value=$total_pkgs+$row['packages']}
                    {assign var="total_frieght" value=$total_frieght+$row['freight']}
                    {assign var="total_loading" value=$total_loading+$row['loading']}
                    {assign var="total_unloading" value=$total_unloading+$row['unloading']}
                    {assign var="total_delivery" value=$total_delivery+$row['delivery']}
                    {assign var="total_service_tax" value=$total_service_tax+$row['service_tax']}
                    {assign var="total_docket" value=$total_docket+$row['docket']}
                    {assign var="net_total" value=$net_total+$total}
                    {/foreach}
                    {/foreach}
                </tbody>
                <tfoot>
                    <tr>
                        <td align="center"><b>Total</b></td>
                        <td align="center"><b>{$total_lr}</b></td>
                        <td align="center"><b>{$total_pkgs}</b></td>
                        <td align="center"><b>{$total_frieght}</b></td>
                        <td align="center"><b>{$total_loading}</b></td>
                        <td align="center"><b>{$total_unloading}</b></td>
                        <td align="center"><b>{$total_delivery}</b></td>
                        <td align="center"><b>{$total_docket}</b></td> 
                        <td align="center"><b>{$total_service_tax}</b></td> 
                        <td align="center"><b>{$net_total}</b></td>              
                    </tr>
                </tfoot>

                </thead>
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