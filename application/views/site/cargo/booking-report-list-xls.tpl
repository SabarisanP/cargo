<table border='1'>
    <tr>
        <td  colspan="6" align="center"><b>{iflang('Cargo Booking Report')}</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$from_date|date_format:$ns_date_format} to {$to_date|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$username} </td>
    </tr>
</table>  
<table border="1">
    <tr>
        <td class="bold"><b>Freight (A)</b></td>
        <td align="right" data-format="{$xlformat['currency']}">{$amounts['freight']}</td>

        <td class="bold"><b>Received</b></td>
        <td align="right" data-format="{$xlformat['currency']}">{$amounts['paid']}</td>
    </tr>
    <tr>
        <td class="bold"><b>Handling Charges (B)</b></td>
        <td align="right" data-format="{$xlformat['currency']}">{$amounts['handling']}</td>

        <td class="bold"><b>Balance</b></td>
        <td align="right" data-format="{$xlformat['currency']}">{$amounts['topay']}</td>
    </tr>
    <tr>
        <td class="bold"><b>Unloading Charges (C)</b></td>
        <td align="right" data-format="{$xlformat['currency']}">{$amounts['unloading']}</td>

        <td class="bold"><b>{$cargo_payment_status['INP']}</b></td>
        <td align="right" data-format="{$xlformat['currency']}">{$amounts['invoicepay']}</td>
    </tr>
    <tr>
        <td class="bold"><b>GST (D)</b></td>
        <td align="right" data-format="{$xlformat['currency']}">{$amounts['gst']}</td>

        <td class="bold">&nbsp;</td>
        <td align="right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold"><b>Pickup Charges (E)</b></td>
        <td align="right" data-format="{$xlformat['currency']}">{$amounts['pickup']}</td>

        <td class="bold">&nbsp;</td>
        <td align="right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold"><b>Delivery Charges (F)</b></td>
        <td align="right" data-format="{$xlformat['currency']}">{$amounts['delivery']}</td>

        <td class="bold">&nbsp;</td>
        <td align="right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold"><b>Connecting Charges (G)</b></td>
        <td align ="right" data-format="{$xlformat['currency']}">{$amounts['connecting']}</td>

        <td class="bold">&nbsp;</td>
        <td class="right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold"><b>{lang('other_charges')} (H)</b></td>
        <td align="right" data-format="{$xlformat['currency']}">{$amounts['service_charge']}</td>

        <td class="bold">&nbsp;</td>
        <td align="right">&nbsp;</td>
    </tr>

    <tr>
        <td class="bold"><b>Sub Total (S1 = A+B+C+D+E+F+G+H)</b></td>
        <td class="bold" align="right" data-format="{$xlformat['currency']}">
            {$amounts['netpayable']}
        </td>

        <td class="bold">&nbsp;</td>
        <td align="right"></td>
    </tr>

    <tr>
        <td class="bold"><b>Commission (I)</b></td>
        <td class="bold" align="right" data-format="{$xlformat['currency']}">
            {($amounts['commission']-$amounts['handling_commission'])}
        </td>

        <td class="bold">&nbsp;</td>
        <td align="right"></td>
    </tr>

    <tr>
        <td class="bold"><b>Share (J)</b></td>
        <td class="bold" align="right" data-format="{$xlformat['currency']}">
            {($amounts['handling_commission'])}
        </td>

        <td class="bold">&nbsp;</td>
        <td align="right"></td>
    </tr>
    
    <tr>
        <td class="bold"><b>Net Total (S1-I-J)</b></td>
        <td class="bold" align="right" data-format="{$xlformat['currency']}">
            {($amounts['netpayable']-$amounts['commission'])}
        </td>

        <td class="bold">&nbsp;</td>
        <td align="right"></td>
    </tr>
</table>
<table border="1">
    <thead>
        <tr style="background-color: #64b92a">
            <th class="bold"></th>
            <th align="right">LRs</th>
            <th align="right">No. Of Articles</th>
            <th align="right">Freight</th>
        </tr>
    </thead>
    {foreach item=row from=$summary key=paytype}
        <tr>
            <td class="bold">{$cargo_payment_status[$paytype]}</td>
            <td align="right">{($row['count'] + 0)|sigma:$summ_count}</td>
            <td align="right">{($row['qtycount'] + 0)|sigma:$summ_qty}</td>
            <td align="right" data-format="{$xlformat['currency']}">{$row['freight']|sigma:$summ_freight}</td>
        </tr>
    {/foreach}
    {if $summary|count}
        <tfoot>
            <tr>
                <td class="bold">Total</td>
                <td align="right">{$summ_count}</td>
                <td align="right">{$summ_qty}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$summ_freight}</td>
            </tr>
        </tfoot>
    {else}
        <tfoot>
            <tr>
                <td colspan="4" align="center">No Records Found</td>
            </tr>
        </tfoot>
    {/if}
</table>

<table border='1'>
    <thead>
        <tr style="background-color: #64b92a">        
            <td align="center"><b>Booked Date</b></td> 
            <td align="center"><b>{lang('cargo_code_term')}</b></td>
            <td align="center">No. Of Articles</td> 
            <td align="center">Type Of Packaging</td>
            <td align="center">Type Of Booking</td>  
            <td align="center"> From State</td>
            <td align="center"><b>{lang('booking_from_term')}</b></td>
            <td align="center"><b>User</b></td>  
            <td align="center">To State</td>                               
            <td align="center"><b>{lang('booking_to_label')}</b></td>
            <td align="center"><b>{lang('booking_sender_term')}</b></td>
            <td align="center"><b>RAC Name</b></td>
            <td align="center">{lang('booking_sender_term')} Contact  Number</td>
            <td align="center"><b>{lang('booking_receiver_term')}</b></td>
            <td align="center"><b>{lang('booking_receiver_term')} Contact  Number</b></td>
            <td align="center">Type Of Delivery</td>
            <td align="center"><b>Payment Status</b></td>
            <td align="center">Date Of Dispatch</td>
            <td align="center">Dispatch Status</td>
            <td align="center"><b>Cargo Status</b></td> 
            <td align="center"><b>Items</b></td>
            {if $namespaceCode=='seenutransports'||$namespaceCode=='seenucargo' }
                <td align="center">LL No</td>
                <td align="center">LL Date</td>
                <td align="center">RP Send</td>
                <td align="center">RP Receiving</td>
                <td align="center">Payment Receive Date</td>
            {/if}
            <td align="center">{if $namespaceCode == "dishashree"}Qty/Kg {else}Qty{/if}</td>
            <td align="center"><b>Net Payable</b></td>
            <td align="center"><b>Handling Charges </b></td>
            <td align="center"><b>Freight Amount </b></td>
            <td align="center"><b>GST </b></td>
            <td align="center"><b>Unloading Charges </b></td>
            <td align="center"><b>Pickup Charges </b></td>
            <td align="center"><b>Delivery Charges </b></td>
            <td align="center"><b>{lang('other_charges')} </b></td>
            <td align="center"><b>Commission</b></td>
            <td align="center"><b>Share</b></td>
            <td align="center"><b>Received</b></td>
            <td align="center"><b>Balance</b></td>     
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
        {assign var=tot_share value=0}
        
        {assign var=t_service_tax value=0}
        {assign var=t_total_handling_amount value=0}
        {assign var=t_total_unload_handling_amount value=0}
        {assign var=t_pickup_handling_amount value=0}
        {assign var=t_delivery_handling_amount value=0}
        {assign var=t_other_tot_amount value=0}
        
        {if $smarty.request.groupBy == "PAYTYPE"}
            {foreach item=val from=$result key=key}
                <tr><td align="center" colspan="20" class="bold">{$key}</td> </tr>
                {foreach item=row from=$val key=t}
                    {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                    <tr> 
                        <td align="left" nowrap>{capture assign=timestamp}{$row->booked_at|strtotime}{/capture}{$timestamp|date_format:"%d %b %Y %I:%M %p"}</td>
                        <td align="center">{$row->cargo_code}{if $namespace == 'rmtcargo'|| $namespace == 'cargodemo'|| $namespace == 'ktwoklogistics'} PNO: {$row->private_mark_number}{/if}</td>
                        <td align="center">{$row->total_item_count}</td>
                        <td align="center">{$row->cargo_item_name}</td>
                        <td align="center">{$delivery_type_codes[$row->pickup_type_code]}</td>
                        <td align="left">{$row->from_state_name}</td>
                        <td align="left">{$row->from_organization_name}</td>
                        <td align="left">{$row->user_first_name}</td> 
                        <td align="left">{$row->to_state_name}</td>                               
                        <td align="left">{$row->to_organization_name}</td>
                        <td align="left">{$row->from_customer_name}</td>
                        <td align="left">{if $row->payment_status_code == 'INP' }{$row->vendor_name}{else} - {/if}</td>
                        <td align="left">{$row->from_customer_mobile|mask_mobileno}</td>
                        <td align="left">{$row->to_customer_name}</td>
                        <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                        <td align="center">{$delivery_type_codes[$row->delivery_type_code]}</td>
                        <td align="left">{$cargo_payment_status[$row->payment_status_code]}</td>
                        
                        <td align="left" nowrap>
                            {if isNotNull($row->unloaded_at)}
                                {$row->unloaded_at|date_format:$ns_datetime_format}
                            {else}
                                -
                            {/if}
                        </td>
                        <td align="center">
                            {if $row->cargo_status_code == "CL" || $row->cargo_status_code == "CUL" || $row->cargo_status_code == "CD"}
                                Yes
                            {elseif $row->cargo_status_code == "CB" || $row->cargo_status_code == "CUD" || $row->cargo_status_code == "CR" || $row->cargo_status_code == "CA"}
                                No
                            {/if}
                        </td>
                        <td align="left">{$cargo_status[$row->cargo_status_code]} </td>            
                        <td align="left">{$row->cargo_item_name}</td>
                        {if $namespaceCode=='seenutransports'||$namespaceCode=='seenucargo' }
                            <td align="center" nowrap> {$row->transit_alias_code}</td>
                            <td  align="left" nowrap>{$row->transit_trip_date|date_format:"d-m-Y"} </td>
                            <td  align="left" nowrap>{$row->pod_sending_at|date_format:"d-m-Y"} </td>
                            <td  align="left" nowrap> {$row->pod_received_at|date_format:"d-m-Y"}</td>
                            <td  align="left" nowrap> {$row->pod_transaction_date|date_format:"d-m-Y"}</td>
                        {/if}
                        <td align="center">{if $namespaceCode == "dishashree"}{$row->total_item_count}/{$row->total_unit_value}{else}{$row->total_item_count}{/if}</td>

                        <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->total_handling_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->service_tax}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->total_unload_handling_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->pickup_handling_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->delivery_handling_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->other_charges_amount+$row->connecting_charge}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{($row->commission_amount-$row->handling_commission_amount)}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->handling_commission_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->transaction_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">                    
                            {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->pickup_handling_amount+$row->total_unload_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount+$row->connecting_charge)-$row->transaction_amount}
                            {$rtopay}
                            {assign var='tot_topay' value=$tot_topay+$rtopay}                    
                        </td>
                    </tr> 

                    {assign var=tot_fare value=$tot_fare+$row->total_amount}
                    {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                    {assign var=tot_payable value=$tot_payable+$row->connecting_charge+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->service_tax+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->other_charges_amount}
                    {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                    {assign var=tot_items value=$tot_items+$row->total_item_count}
                    {assign var=tot_commission value=$tot_commission+($row->commission_amount-$row->handling_commission_amount)}
                    {assign var=tot_share value=$tot_share+$row->handling_commission_amount}
                    
                    {assign var=t_service_tax value=$t_service_tax + $row->service_tax}
                    {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
                    {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
                    {assign var=t_pickup_handling_amount value=$t_pickup_handling_amount + $row->pickup_handling_amount}
                    {assign var=t_delivery_handling_amount value=$t_delivery_handling_amount + $row->delivery_handling_amount}
                    {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->connecting_charge}

                    {/if}
                {/foreach}  
            {/foreach}  
        {else}
            {foreach item=row from=$result key=t}
                {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                    <tr>
                        <td align="left" nowrap>{capture assign=timestamp}{$row->booked_at|strtotime}{/capture}{$timestamp|date_format:"%d %b %Y %I:%M %p"}</td>                
                        <td align="center">{$row->cargo_code}{if $namespace == 'ktwoklogistics' || $namespace == 'cargodemo' || $namespace == 'rmtcargo'} PNO: {$row->private_mark_number}{/if}</td>
                        <td align="center">{$row->total_item_count}</td>
                        <td align="center">{$row->cargo_item_name}</td>
                        <td align="center">{$delivery_type_codes[$row->pickup_type_code]}</td>
                        <td align="left">{$row->from_state_name}</td>
                        <td align="left">{$row->from_organization_name}</td>
                        <td align="left">{$row->user_first_name}</td> 
                        <td align="left">{$row->to_state_name}</td>  
                        <td align="left">{$row->to_organization_name}</td>
                        <td align="left">{$row->from_customer_name} </td>
                        <td align="left">{if $row->payment_status_code == 'INP' }{$row->vendor_name}{else} - {/if}</td>
                        <td align="left">{$row->from_customer_mobile|mask_mobileno}</td>
                        <td align="left">{$row->to_customer_name}</td>
                        <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                        <td align="center">{$delivery_type_codes[$row->delivery_type_code]}</td>
                        <td align="left">{$cargo_payment_status[$row->payment_status_code]}</td>
                        <td align="left" nowrap>
                            {if isNotNull($row->unloaded_at)}
                                {$row->unloaded_at|date_format:$ns_datetime_format}
                            {else}
                                -
                            {/if}
                        </td>
                        <td align="center">
                            {if $row->cargo_status_code == "CL" || $row->cargo_status_code == "CUL" || $row->cargo_status_code == "CD"}
                                Yes
                            {elseif $row->cargo_status_code == "CB" || $row->cargo_status_code == "CUD" || $row->cargo_status_code == "CR" || $row->cargo_status_code == "CA"}
                                No
                            {/if}
                        </td>
                        <td align="left">{$cargo_status[$row->cargo_status_code]} </td>            
                        <td align="left">{$row->cargo_item_name}</td>      
                        {if $namespaceCode=='seenutransports'||$namespaceCode=='seenucargo' }
                            <td align="center" nowrap> {$row->transit_alias_code}</td>
                            <td  align="left" nowrap>{$row->transit_trip_date|date_format:"d-m-Y"} </td>
                            <td  align="left" nowrap>{$row->pod_sending_at|date_format:"d-m-Y"} </td>
                            <td  align="left" nowrap> {$row->pod_received_at|date_format:"d-m-Y"}</td>
                            <td  align="left" nowrap> {$row->pod_transaction_date|date_format:"d-m-Y"}</td>
                        {/if}      
                        <td align="center">{if $namespaceCode == "dishashree"}{$row->total_item_count}/{$row->total_unit_value}{else}{$row->total_item_count}{/if}</td>

                        <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->total_handling_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->service_tax}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->total_unload_handling_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->pickup_handling_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->delivery_handling_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->other_charges_amount+$row->connecting_charge}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{($row->commission_amount-$row->handling_commission_amount)}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->handling_commission_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$row->transaction_amount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">                    
                            {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->pickup_handling_amount+$row->total_unload_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount+$row->connecting_charge+$row->connecting_charge)-$row->transaction_amount}
                            {$rtopay}
                            {assign var='tot_topay' value=$tot_topay+$rtopay}                    
                        </td>
                    </tr> 

                    {assign var=tot_fare value=$tot_fare+$row->total_amount}
                    {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                    {assign var=tot_payable value=$tot_payable+$row->connecting_charge+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}
                    {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                    {assign var=tot_items value=$tot_items+$row->total_item_count}
                    {assign var=tot_unit value=$tot_unit+$row->total_unit_value}
                    {assign var=tot_commission value=$tot_commission+($row->commission_amount-$row->handling_commission_amount)}
                    {assign var=tot_share value=$tot_share+$row->handling_commission_amount}
                        
                    {assign var=t_service_tax value=$t_service_tax + $row->service_tax}
                    {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
                    {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
                    {assign var=t_pickup_handling_amount value=$t_pickup_handling_amount + $row->pickup_handling_amount}
                    {assign var=t_delivery_handling_amount value=$t_delivery_handling_amount + $row->delivery_handling_amount}
                    {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->other_charges_amount + $row->connecting_charge}
                {/if}

            {/foreach}  
        {/if}
    </tbody>
    {if $result|count}
        <tfoot>
            <tr class="active">                    
                <td align="right" {if $namespaceCode=='seenutransports'||$namespaceCode=='seenucargo' }  colspan="26" {else} colspan="21"   {/if} class="bold"><b>Total</b></td>  
                <td align="center" class="bold">{if $namespaceCode == "dishashree"}<b>{$tot_items}</b>/<b>{$tot_unit}</b>{else}<b>{$tot_items}</b>{/if}</td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}"><b>{$tot_payable}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$t_total_handling_amount}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$tot_fare}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$t_service_tax}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$t_total_unload_handling_amount}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$t_pickup_handling_amount}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$t_delivery_handling_amount}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$t_other_tot_amount}</b></td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}"><b>{$tot_commission}</b></td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}"><b>{$tot_share}</b></td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}"><b>{$tot_paid}</b></td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}"><b>{$tot_topay}</b></td>
            </tr> 
        </tfoot>
    {else}
        <tfoot>
            <tr>
                <td colspan="31" align="center">No Records Found</td>
            </tr>
        </tfoot>
    {/if}
</table>                

