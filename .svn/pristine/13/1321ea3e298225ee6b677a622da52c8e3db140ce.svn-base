<html>
    <head>
        <title>Cargo Trip Chart</title>
        <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
        <link href="{$base_url}assets/css/print-large.css?{$asset_ver}" rel="stylesheet">
    </head>
    <body>
        <table class="remove-border-top" cellpadding="5" width="99%">
            <tr>
                <td  colspan="2" align="center"><span style="font-weight: bold;">{iflang('Cargo Booking Report')}</span></td>
            </tr>
            <tr>
                <td width="50%">
                    <span  style="font-weight: bold;">Report Date : </span> 
                    {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
                <td width="50%" align="right"><span  style="font-weight: bold;">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
            </tr>
            <tr>
                <td width="50%">&nbsp;</td>
                <td width="50%" align="right"><span  style="font-weight: bold;">Report By : </span> {$username} </td>
            </tr>
        </table> 
        <table id="dt_adv_booking_report_table" class="table table-bordered " style="width:99%" >
            <thead>
                <tr>
                    <td align="center" style="font-weight: bold;">{lang('cargo_code_term')}</td>
                    <td align="center" style="font-weight: bold;">Booked Date</td> 
                    <td align="center" style="font-weight: bold;">{lang('booking_from_term')}</td>
                    <td align="center" class="noprint" style="font-weight: bold;">User</td>                                 
                    <td align="center" style="font-weight: bold;">{lang('booking_to_label')}</td>
                    <td align="center" style="font-weight: bold;">{lang('booking_sender_term')}</td>
                    <td align="center" style="font-weight: bold;">{lang('booking_receiver_term')}</td>
                    <td align="center" style="font-weight: bold;">Payment Status</td>
                    <td align="center" style="font-weight: bold;">Cargo Status</td>            
                    <td align="center" style="font-weight: bold;">Items</td>
                    <td align="center" style="font-weight: bold;">Qty</td> 
                    <td align="center" style="font-weight: bold;">Net Payable</td>
                    <td align="center" style="font-weight: bold;">Paid</td>
                    <td align="center" style="font-weight: bold;">To Pay</td>            
                </tr>

            </thead>
            <tbody class="body_table">     
                {assign var=tot_fare value=0}
                {assign var=tot_handling value=0}
                {assign var=tot_payable value=0}
                {assign var=tot_paid value=0}
                {assign var=tot_topay value=0}
                {assign var=tot_items value=0}
                {assign var=tot_commission value=0}

                {foreach item=val from=$result key=key}
                    <tr class="{$val[0]->payment_status_code}">
                        <td align="center" colspan="15"  style="font-weight: bold;">{$key}</td>
                    </tr>

                    {foreach item=row from=$val key=t}
                        {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                            <tr class="{$row->payment_status_code}">                    
                                <td align="center">{$row->cargo_code}</td>
                                <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                                <td align="left">{$row->from_organization_name}</td>
                                <td align="left" class="noprint">{$row->user_first_name}</td>                                 
                                <td align="left">{$row->to_organization_name}</td>
                                <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile}</td>
                                <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile}</td>
                                <td align="left">
                                    {$row->payment_status_code|_cargo_payment_status_badge}
                                </td>
                                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>           
                                <td align="left">{$row->cargo_item_name}</td>
                                <td align="center">{$row->total_item_count}</td>

                                <td align="right">{$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax}</td>
                                <td align="right">{$row->transaction_amount}</td>
                                <td align="right">                    
                                    {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)-$row->transaction_amount}
                                    {$rtopay}
                                    {assign var='tot_topay' value=$tot_topay+$rtopay}                    
                                </td>
                            </tr> 

                            {assign var=tot_fare value=$tot_fare+$row->total_amount}
                            {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                            {assign var=tot_payable value=$tot_payable+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax}
                            {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                            {assign var=tot_items value=$tot_items+$row->total_item_count}
                            {assign var=tot_commission value=$tot_commission+$row->commission_amount}
                        {/if}
                    {/foreach}                     
                    <tr class="active">  
                        <td align="center"></td>
                        <td align="left"></td>
                        <td align="left"></td>
                        <td align="left" class="noprint"></td>                                 
                        <td align="left"></td>
                        <td align="left"></td>
                        <td align="left"></td>
                        <td align="left"></td>
                        <td align="left"></td>           
                        <td align="right"  style="font-weight: bold;">Total</td>   
                        <td align="center"  style="font-weight: bold;">{$tot_items}</td>
                        <td align="right"  style="font-weight: bold;">{$tot_payable|number_format:2}</td>
                        <td align="right"  style="font-weight: bold;">{$tot_paid|number_format:2}</td>
                        <td align="right"  style="font-weight: bold;">{$tot_topay|number_format:2}</td>
                    </tr> 
                {/foreach}  
 
            </tbody>
        </table>                
    </body>
</html>