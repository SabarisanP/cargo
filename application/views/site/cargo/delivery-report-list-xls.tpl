<table border='1'>
    <tr>
        <td  colspan="12" align="center"><b>{iflang('Cargo Delivery Report')}</b></td>
    </tr>
    <tr>
        <td colspan="6">Report Date : {$fromDate|date_format:$ns_date_format}  to {$toDate|date_format:$ns_date_format} </td>
        <td colspan="6" >Report At : {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
        <td colspan="6" ><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>    
    
<br>
    
<table border='1'>
    <tr>
        <td class="bold" ><b>Freight (A)</b></td>
        <td class="text-right">{$amounts['freight']|inr_format}</td>
        
        <td class="bold" ><b>Paid</b></td>
        <td class="text-right">{$amounts['paid']|inr_format}</td>
    </tr>
    <tr>
        <td class="bold" ><b>Handling Charges (B)</b></td>
        <td class="text-right">{$amounts['handling']|inr_format}</td>
        
        <td class="bold" ><b>To Pay</b></td>
        <td class="text-right">{$amounts['topay']|inr_format}</td>
    </tr>
    <tr>
        <td class="bold" ><b>Unloading Charges (C)</b></td>
        <td class="text-right">{$amounts['unloading']|inr_format}</td>
        
        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold" ><b>GST (D)</b></td>
        <td class="text-right">{$amounts['gst']|inr_format}</td>
        
        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold" ><b>Pickup Charges (E)</b></td>
        <td class="text-right">{$amounts['pickup']|inr_format}</td>
        
        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold" ><b>Delivery Charges (F)</b></td>
        <td class="text-right">{$amounts['delivery']|inr_format}</td>
        
        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold"><b>Connecting Charges (G)</b></td>
        <td align ="text-right">{$amounts['connecting']|inr_format}</td>

        <td class="bold">&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold" ><b>{lang('other_charges')} (H)</b></td>
        <td class="text-right">{$amounts['service_charge']|inr_format}</td>
        
        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
         
    <tr>
        <td class="bold"><b>Net Amount (A+B+C+D+E+F+G+H)</b></td>                                                                                           
        <td class="bold text-right">
            {$amounts['netpayable']|inr_format}
        </td>
        
        <td class="bold" >&nbsp;</td>
        <td class="text-right"></td>
    </tr>
</table>   
<br>
<table class="table table-bordered " border='1'>
    <thead>
        <tr style="background-color: #64b92a">
            <td align="center"><b>Booked Date</b></td>
            <td align="center"><b>{lang('cargo_code_term')}</b></td>
            <td align="center"><b>Ogpl No.</b></td>
            <td align="center">Type Of Packaging</td>
            <td align="center">Type Of Booking</td>
            <td align="center"><b>{lang('booking_from_term')}</b></td>
            <td align="center"><b>Delivery User</b></td>
            <td align="center"><b>{lang('booking_to_label')}</b></td>
            <td align="center"><b>{lang('booking_sender_term')}</b></td>
            <td align="center"><b>{lang('booking_sender_term')} Contact Number</b></td>
            <td align="center"><b>{lang('booking_receiver_term')}</b></td>
            <td align="center"><b>{lang('booking_receiver_term')} Contact Number</b></td>
            <td align="center"><b>Payment Status</b></td>
            <td align="center">Type Of Delivery</td>
            <td align="center"><b>Cargo Status</b></td>  
            <td align="center">Date Of Delivery</td>
            <td align="center">No. Of Articles</td>
            <td align="center"><b>Qty</b></td>
            <td align="center">Freight Amount</td>
            <td align="center">{lang('other_charges')} </td> 
            <td align="center"><b>Net Payable</b></td>
            <td align="center"><b>Paid</b></td>
            <td align="center"><b>To Pay</b></td>     
        </tr>
    </thead>
    <tbody class="body_table" >
        
        {assign var=tot_lr_count value=0}
        {assign var=tot_item_count value=0}
        {assign var=tot_fare value=0}
        {assign var=tot_handling value=0}
        {assign var=tot_payable value=0}
        {assign var=tot_paid value=0}
        {assign var=tot_topay value=0}
        {assign var=tot_items value=0}
        {assign var=tot_commission value=0}
                    
        {foreach item=row from=$result key=t}
            {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                <tr>
                    <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="center">{$row->cargo_code} {if $namespace == 'rmtcargo'|| $namespace == 'cargodemo'|| $namespace == 'ktwoklogistics'} <br>PNO:{$row->private_mark_number}{/if}</td>
                    <td align="center">{$row->transit_alias_code}</td>
                    <td align="center">{$row->cargo_item_name}</td>
                    <td align="center">{$delivery_type_codes[$row->pickup_type_code]}</td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->user_first_name}</td>                                 
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{$row->from_customer_name}</td>
                    <td align="left">{$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->to_customer_name}</td>
                    <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="left">
                        {if $namespace == "arthitravels" && $row->payment_status_code == 'TPPAD'}
                            {$cargo_payment_status['TOP']}
                        {else}
                            {$cargo_payment_status[$row->payment_status_code]}
                        {/if}
                    </td>
                    <td align="center">{$delivery_type_codes[$row->delivery_type_code]}</td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]} </td>
                    <td align="left" nowrap>
                        {if $row->delivered_at}
                            {$row->delivered_at|date_format:$ns_datetime_format}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="right">{$row->item_count}</td>
                    <td align="right">{$row->total_item_count}</td>
                    <td align="right">{$row->total_amount|inr_format}</td>
                    <td align="right">{($row->service_charge + $row->other_charges_amount + $row->connecting_charge)|inr_format}</td>
                    
                    <td align="right">{$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount|inr_format}</td>
                    <td align="right">{$row->transaction_amount|inr_format}</td>
                    <td align="right">
                        {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)-$row->transaction_amount}
                        {$rtopay|inr_format}
                        {assign var='tot_topay' value=$tot_topay+$rtopay}
                    </td>
                </tr> 

                {assign var=tot_lr_count value=$tot_lr_count+1}
                {assign var=tot_item_count value=$tot_item_count+$row->item_count}
                {assign var=tot_fare value=$tot_fare+$row->total_amount}
                {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                {assign var=tot_payable value=$tot_payable+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}
                {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->service_charge + $row->other_charges_amount + $row->connecting_charge}
                
                {assign var=tot_items value=$tot_items+$row->total_item_count}
                
                {assign var=tot_commission value=$tot_commission+$row->commission_amount}
            {/if}
        {/foreach}  
        
        {if $tot_lr_count}
            <tr class="active">                    
                <td align="right" colspan="16" class="bold"><b>Total {$tot_lr_count} {lang('lr')}s</b></td>
                <td align="right" class="bold"><b>{$tot_item_count}</b></td>
                <td align="right" class="bold"><b>{$tot_items}</b></td>
                <td align="right" class="bold"><b>{$tot_fare|inr_format}</b></td>
                <td align="right" class="bold"><b>{$t_other_tot_amount|inr_format}</b></td>
                <td align="right" class="bold"><b>{$tot_payable|inr_format}</b></td>
                <td align="right" class="bold"><b>{$tot_paid|inr_format}</b></td>
                <td align="right" class="bold"><b>{$tot_topay|inr_format}</b></td>
            </tr>  
        {else}
            <tr>
                <td colspan="22" align="center">No Records Found!</td>
            </tr>
        {/if}

    </tbody>
</table>                

