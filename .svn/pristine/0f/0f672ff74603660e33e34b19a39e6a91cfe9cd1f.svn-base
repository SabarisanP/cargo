{if $smarty.request.orgname}
    <table class="" width="99%">
        <tr>
            <td  colspan="2" align="center"><span class="bold">Collection Report (Transaction Based)</span></td>
        </tr>
        <tr>
            <td width="50%">
                <span class="bold">Report Date : </span>
    
                {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}
            <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
        </tr>
        <tr>
            <td width="50%">
            </td>
            <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
        </tr>
    
    </table>    
{/if}
<br/>
<div class="clearfix"></div>

<div class="overflow-x-auto">
    <table class="table table-bordered">
        <thead class="text-center">
            <tr class="success">
                <td align="center">{lang('cargo_code_term')}</td>           
                <td align="center">Booked Date</td> 
                <td align="center">{lang('booking_from_term')}</td>
                <td align="center">User</td>                                 
                <td align="center">{lang('booking_to_label')}</td>
                <td align="center">{lang('booking_sender_term')}</td>
                <td align="center">{lang('booking_receiver_term')}</td>
                <td align="center">Payment Status</td>
                <td align="center">Cargo Status</td>  
                <td align="center">Qty</td> 
                {* <td align="center">Freight</td>  *}
                <td align="center">Transaction Amount</td>
                <td align="center">Connecting Charges</td>
                <td align="center">Unloading Charges</td>
                <td align="center">Other Charges</td>
                <td align="center">Demurrage Charges</td>
                <td align="center">Commission</td>
                <td align="center">Handling Commission Amount</td> 
                <th align="right">Payable Amount</th>
            </tr>
        </thead>
        <tbody>
            {assign var=tot_fare value=0}
            {assign var=tot_items value=0}
            {assign var=tot_transaction_amount value=0}
            {assign var=tot_commission_amount value=0}
            {assign var=tot_handling_commission_amount value=0}
            {assign var=tot_payable_amount value=0}
            {assign var=tot_connecting_charge value=0}
            {assign var=tot_unloading_charge value=0}
            {assign var=tot_other_charge value=0}
            {assign var=tot_demurrage_charge value=0}
            {foreach item=row from=$result key=t}
                <tr>                    
                    <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>  
                    <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->user_first_name}</td>                                 
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="center">
                        {$row->payment_status_code|_cargo_payment_status_badge}
                    </td> 
                    <td align="left">{$cargo_status[$row->cargo_status_code]}</td>          
                    <td align="center">{$row->total_item_count}</td>   
                    {* <td align="right">{$row->total_amount|number_format:2}</td> *}
                    <td align="right">{$row->transaction_amount|number_format:2}</td>
                    <td align="right">{$row->connecting_charge|number_format:2}</td>
                    <td align="right">{$row->total_unload_handling_amount|number_format:2}</td>
                    <td align="right">{$row->other_charges_amount|number_format:2}</td>
                    <td align="right">{$row->demurrage_charge|number_format:2}</td>
                    <td align="right">{$row->commission_amount|number_format:2}</td>
                    <td align="right">{$row->handling_commission_amount|number_format:2}</td>
                    <td align="right">{($row->transaction_amount - $row->commission_amount)|number_format:2}</td>
                </tr> 

                {assign var=tot_fare value=$tot_fare+$row->total_amount}
                {assign var=tot_items value=$tot_items+$row->total_item_count}
                {assign var=tot_transaction_amount value=$tot_transaction_amount+$row->transaction_amount}
                {assign var=tot_commission_amount value=$tot_commission_amount+$row->commission_amount}
                {assign var=tot_connecting_charge value=$tot_connecting_charge+$row->connecting_charge}
                {assign var=tot_unloading_charge value=$tot_unloading_charge+$row->total_unload_handling_amount}
                {assign var=tot_other_charge value=$tot_other_charge+$row->other_charges_amount}
                {assign var=tot_demurrage_charge value=$tot_demurrage_charge+$row->demurrage_charge}
                {assign var=tot_handling_commission_amount value=$tot_handling_commission_amount+$row->handling_commission_amount}
                {assign var=tot_payable_amount value=$tot_payable_amount+$row->transaction_amount + $row->connecting_charge - $row->commission_amount - $row->handling_commission_amount}
            {/foreach}  
            
            <tr class="active">                    
                <td align="right" colspan="9" class="bold">Total</td>  
                <td align="center" class="bold">{$tot_items}</td>
                {* <td align="right" class="bold">{$tot_fare|number_format:2}</td> *}
                <td align="right" class="bold">{$tot_transaction_amount|number_format:2}</td>
                <td align="right" class="bold">{$tot_connecting_charge|number_format:2}</td>
                <td align="right" class="bold">{$tot_unloading_charge|number_format:2}</td>
                <td align="right" class="bold">{$tot_other_charge|number_format:2}</td>
                <td align="right" class="bold">{$tot_demurrage_charge|number_format:2}</td>
                <td align="right" class="bold">{$tot_commission_amount|number_format:2}</td>
                <td align="right" class="bold">{$tot_handling_commission_amount|number_format:2}</td>
                <td align="right" class="bold">{$tot_payable_amount|number_format:2}</td>
            </tr>  
        </tbody>
    </table>
</div>
