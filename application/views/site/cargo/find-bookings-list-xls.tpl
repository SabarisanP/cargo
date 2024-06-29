<table border='1'>
    <tr>
        <td colspan="6" align="center"><b>Find / Delivery / Update Cargo Bookings</b></td>
    </tr>
    <tr>
        <td colspan="3"><b>Report Date : {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format}</td>
        <td colspan="3" align="right"><b>Report At : </b>{$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By : </b> {$usr_login_name} </td>
    </tr>
</table>
<br/>
<h5>Summary</h5>
<table border='1'>
    <thead>
        <tr>
            <td align="center">{lang('lr')} Number</td>          
            <td align="center">Booked Date</td>
            <td align="center">Paid Date</td>
            <td align="center">{lang('booking_from_term')}</td>
            <td align="center">Booked By</td>                                 
            <td align="center">{lang('booking_to_label')}</td>
            <td align="center">{lang('booking_sender_term')}</td>
            <td align="center">{lang('booking_receiver_term')}</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>  
            <td align="center">Vendor</td>
            <td align="center">Qty</td>
            <td align="center">Loading Charges</td>
            <td align="center">Unloading Charges</td> 
            <td align="center">Freight</td> 
            <td align="center">Door Pickup Charges</td>
            <td align="center">Door Delivery Charges</td> 
            <td align="center">Docket Charges</td> 
            <td align="center">Hamali charges</td>
            <td align="center">POD charges</td>
            <td align="center">Pass Charge</td> 
            <td align="center">Service Charge</td> 
            <td align="center">GST</td> 
            <td align="center">{lang('other_charges')}</td>                 
            <td align="center">Net Payable</td>
            <td align="center">Paid</td>
            <td align="center">To Pay</td>            

        </tr>
    </thead>
    <tbody>
        {assign var="tot_qty_count" value = 0}
        {assign var="tot_loading_chg" value = 0}
        {assign var="tot_unloading_chg" value = 0}
        {assign var="tot_freight" value = 0}
        {assign var="tot_door_pkup" value = 0}
        {assign var="tot_deliv_chg" value = 0}
        {assign var="tot_docket_chg" value = 0}
        {assign var="tot_hamali_chg" value = 0}
        {assign var="tot_pod_chg" value = 0}
        {assign var="tot_pass_chg" value = 0}
        {assign var="tot_srvce_chg" value = 0}
        {assign var="tot_gst" value = 0}
        {assign var="tot_other_chg" value = 0}
        {assign var="tot_net_pay" value = 0}
        {assign var="tot_paid" value = 0}
        {assign var="tot_topay" value = 0}
        {foreach item=row from=$result key=t}
            <tr>
                <!--<td align="center"><input type="checkbox" onchange="activateActionButtons()" id="chk_all" class="{$row->cargo_status_code}" value="{$row->cargo_code}" /></td>-->
                <td align="center">
                    {$row->cargo_code}
                    {if $namespace=='bits'}
                        {/if}
                </td>           
                <td align="center">{$row->booked_at|date_format:$ns_datetime_format}</td>
                <td align="center">
                    {if $row->payment_date!=''}
                        {$row->payment_date|date_format:$ns_datetime_format}
                    {else}
                        -
                    {/if}
                </td>
                <td align="center">{$row->from_organization_name}</td>
                <td align="center">{$row->user_first_name}</td>                                 
                <td align="left">{$row->to_organization_name}</td>
                <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td>
                <td align="center" id='pay_state_{$row->cargo_code}'>
                {$row->payment_status_code|_cargo_payment_status_badge}
                </td>
                <td align="center">{$cargo_status[$row->cargo_status_code]}</td> 
                <td align="center">
                    {if $row->vendor_user_name!=''}
                        {$row->vendor_user_name}
                    {else}
                        -
                    {/if}
                </td> 
                <td align="center">{$row->total_item_count}</td>                      
                <td align="right">{$row->total_handing_amount|number_format}</td>
                <td align="right">{$row->total_unload_handling_amount|number_format}</td>
                <td align="right">{$row->total_booking_amount|number_format}</td>                    
                <td align="right">{$row->pickup_handling_amount|number_format}</td>
                <td align="right">{$row->delivery_handling_amount|number_format}</td>
                <td align="right">{$row->docket_charge|number_format}</td>
                <td align="right">{$row->hamali_charge|number_format}</td>
                <td align="right">{$row->pod_charge|number_format}</td>
                <td align="right">{$row->pass_charge|number_format}</td>
                <td align="right">{$row->service_charge|number_format}</td>
                <td align="right">{$row->service_tax|number_format}</td>
                <td align="right">{$row->other_charges_amount|number_format}</td>                    
                <td align="right">
                    {($row->total_booking_amount+$row->total_handing_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)|number_format}
                </td>
                <td align="right">
                    {$row->total_paid_amount|number_format}
                </td>
                <td align="right">
                    {(($row->total_booking_amount+$row->total_handing_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)-$row->total_paid_amount)|number_format}
                </td>

            </tr> 
            {assign var="tot_qty_count" value =$tot_qty_count + $row->total_item_count}
            {assign var="tot_loading_chg" value =$tot_loading_chg + $row->total_handing_amount}
            {assign var="tot_unloading_chg" value =$tot_unloading_chg + $row->total_unload_handling_amount}
            {assign var="tot_freight" value =$tot_freight + $row->total_booking_amount}
            {assign var="tot_door_pkup" value =$tot_door_pkup + $row->pickup_handling_amount}
            {assign var="tot_deliv_chg" value =$tot_deliv_chg + $row->delivery_handling_amount}
            {assign var="tot_docket_chg" value =$tot_docket_chg + $row->docket_charge}
            {assign var="tot_hamali_chg" value =$tot_hamali_chg + $row->hamali_charge}
            {assign var="tot_pod_chg" value =$tot_pod_chg + $row->pod_charge}
            {assign var="tot_pass_chg" value =$tot_pass_chg + $row->pass_charge}
            {assign var="tot_srvce_chg" value =$tot_srvce_chg + $row->service_charge}
            {assign var="tot_gst" value =$tot_gst + $row->service_tax}
            {assign var="tot_other_chg" value =$tot_other_chg + $row->other_charges_amount}
            {assign var="tot_net_pay" value =$tot_net_pay + $row->total_booking_amount+$row->total_handing_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax}
            {assign var="tot_paid" value =$tot_paid + $row->total_paid_amount}
            {assign var="tot_topay" value =$tot_topay + $row->total_booking_amount+$row->total_handing_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax-$row->total_paid_amount} 

        {/foreach}
    </tbody>
    <tfoot>
        {if $result|count}
            <tr>
                <td colspan="11" align="right">Total</td>
                <td class="bold" align='center'>{$tot_qty_count}</td>
                <td class="bold" align='right'>{$tot_loading_chg|inr_format}</td>
                <td class="bold" align='right'>{$tot_unloading_chg|inr_format}</td>
                <td class="bold" align='right'>{$tot_freight|inr_format}</td>
                <td class="bold" align='right'>{$tot_door_pkup|inr_format}</td>
                <td class="bold" align='right'>{$tot_deliv_chg|inr_format}</td>
                <td class="bold" align='right'>{$tot_docket_chg|inr_format}</td>
                <td class="bold" align='right'>{$tot_hamali_chg|inr_format}</td>
                <td class="bold" align='right'>{$tot_pod_chg|inr_format}</td>
                <td class="bold" align='right'>{$tot_pass_chg|inr_format}</td>
                <td class="bold" align='right'>{$tot_srvce_chg|inr_format}</td>
                <td class="bold" align='right'>{$tot_gst|inr_format}</td>
                <td class="bold" align='right'>{$tot_other_chg|inr_format}</td>
                <td class="bold" align='right'>{$tot_net_pay|inr_format}</td>
                <td class="bold" align='right'>{$tot_paid|inr_format}</td>
                <td class="bold" align='right'>{$tot_topay|inr_format}</td>
            </tr>
        {else}
            <tr>
                <td colspan="27" align="center"> No records Found</td>
            </tr>
        {/if}
    </tfoot>
</table>