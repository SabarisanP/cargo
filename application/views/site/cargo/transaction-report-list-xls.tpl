<table border='1'>
    <tr>
        <td  colspan="8" align="center"><b>Cargo Transaction Report Summary</b></td>
    </tr>
    <tr>
        <td colspan="4">Report Date : {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td colspan="4" >Report At : {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="4">&nbsp;</td>
        <td colspan="4" ><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>    
    
<br>
    
<table border='1'>
    <thead>
        <tr style="background-color: #64b92a">
            <td></td>
            <td class="bold" ><b>Freight (A)</b></td>
            <td class="bold" ><b>Handling Charges (B)</b></td>
            <td class="bold" ><b>Unloading Charges (C)</b></td>
            <td class="bold" ><b>GST (D)</b></td>
            <td class="bold" ><b>Pickup Charges (E)</b></td>
            <td class="bold" ><b>Delivery Charges (F)</b></td>
            <td class="bold" ><b>{lang('other_charges')} (G)</b></td>
            <td class="bold" ><b>Commission Amount (H)</b></td>
            <td class="bold"><b>Net Amount (A+B+C+D+E+F+G-H)</b></td>
        </tr>   
    </thead>
    <tbody>
        {assign var=netpay value=0}
        {foreach item=row from=$summary}
            <tr>
                {if $row['freight']== 0}
                    {continue}
                {/if}
                <td class="bold">{$cargo_payment_status[$row['paycode']]}</td>
                <td align="right">{$row['freight']|number_format:2}</td>
                <td align="right">{$row['handling']|number_format:2}</td>
                <td align="right">{$row['unloading']|number_format:2}</td>
                <td align="right">{$row['gst']|number_format:2}</td>
                <td align="right">{$row['pickup']|number_format:2}</td>
                <td align="right">{$row['delivery']|number_format:2}</td>
                <td align="right">{$row['service_charge']|number_format:2}</td>
                <td align="right">{$row['commission']|number_format:2}</td>
                <td align="right">{$row['netpayable']|number_format:2}</td>
            </tr>
            {assign var=netpay value=$netpay+$row['netpayable']}
        {/foreach}
        <tr>
            <td colspan="9" class="bold" align="right"><b>Total Amount</b></td>
            <td class="bold" align="right"><b>{$netpay|number_format:2}</b></td>
        </tr>
    </tbody>    
</table>   
<br>
<table class="table table-bordered " border='1'>
    <thead>
        <tr style="background-color: #64b92a">
            <td align="center"><b>{lang('cargo_code_term')}</b></td>          
            <td align="center"><b>Booked Date</b></td> 
            <td align="center"><b>{lang('booking_from_term')}</b></td>
            <td align="center"><b>User</b></td>                                 
            <td align="center"><b>{lang('booking_to_label')}</b></td>
            <td align="center"><b>{lang('booking_sender_term')}</b></td>
            <td align="center"><b>{lang('booking_receiver_term')}</b></td>
            <td align="center"><b>Payment Status</b></td>
            <td align="center"><b>Cargo Status</b></td>
            <td align="center">Transaction Mode</td>
            <td align="center">Transaction Details</td>
            <td align="center"><b>Qty</b></td>
            <td align="center">Net Amount</td>
            <td align="center">Commission</td>
            <td align="center"><b>Net Payable</b></td>
            <td align="center"><b>Paid</b></td>
            <td align="center"><b>To Pay</b></td>     
        </tr>

    </thead>
    <tbody class="body_table" >
        
        {assign var=tot_fare value=0}
        {assign var=tot_handling value=0}
        {assign var=tot_payable value=0}
        {assign var=tot_paid value=0}
        {assign var=tot_topay value=0}
        {assign var=tot_items value=0}
        {assign var=tot_commission value=0}
        {assign var=tot_transaction value=0}
                    
        {foreach item=row from=$result key=t}
            {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                <tr>
                    <td align="center">{$row->cargo_code}</td>
                    <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->user_first_name}</td>
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$cargo_payment_status[$row->payment_status_code]}</td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]} </td>
                    <td align="left" nowrap>{$transaction_mode[$row->transaction_mode]|default:'-'}</td>

                    {if $row->transaction_mode_details != "NA"}
                        {assign var="val" value=explode('|', $row->transaction_mode_details)}
                        <td align="center">
                            {if isset($val[0]) && isset($val[1])}
                                {$val[0]}<br>{$val[1]}<br>
                            {/if}
                        </td>
                    {else}
                        <td align="center">-</td>
                    {/if}
                    <td align="center">{$row->total_item_count}</td>
                    <td align="right">{$row->transaction_amount|number_format:2}</td>
                    <td align="right">{$row->commission_amount|number_format:2}</td>
                    <td align="right">{($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge)|number_format:2}</td>
                    <td align="right">{$row->transaction_amount|number_format:2}</td>
                    <td align="right">
                        {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge)-$row->transaction_amount}
                        {$rtopay|number_format:2}
                        {assign var='tot_topay' value=$tot_topay+$rtopay}
                    </td>
                </tr>

                {assign var=tot_fare value=$tot_fare+$row->total_amount}
                {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                {assign var=tot_payable value=$tot_payable+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge}
                {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                {assign var=tot_items value=$tot_items+$row->total_item_count}
                {assign var=tot_commission value=$tot_commission+$row->commission_amount}
                {assign var=tot_transaction value=$tot_transaction+$row->transaction_amount}
            {/if}
            
        {/foreach}  
        
        <tr class="active">                    
            <td align="right" colspan="10" class="bold"><b>Total</b></td>
            <td align="center" class="bold"><b>{$tot_items}</b></td>       
            <td align="right" class="bold"><b>{$tot_transaction|number_format:2}</b></td>
            <td align="right" class="bold"><b>{$tot_commission|number_format:2}</b></td>
            <td align="right" class="bold"><b>{$tot_payable|number_format:2}</b></td>
            <td align="right" class="bold"><b>{$tot_paid|number_format:2}</b></td>
            <td align="right" class="bold"><b>{$tot_topay|number_format:2}</b></td>
        </tr>  

    </tbody>
</table>                

