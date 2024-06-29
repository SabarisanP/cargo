<table border='1'>
    <tr>
        <td  colspan="6" align="center"><b>{iflang('Cargo Booking Report')}</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$username} </td>
    </tr>
</table>

<table border='1'>
    <thead>
        <tr style="background-color: #64b92a">        
            <td align="center"><b>Sl No</b></td>
            <td align="center"><b>Docket No</b></td>
            <td align="center"><b>Date</b></td> 
            <td align="center"><b>Act</b></td>
            <td align="center"><b>Consignor</b></td>
            <td align="center"><b>Consignee</b></td>
            <td align="center"><b>From</b></td>    
            <td align="center"><b>To</b></td>
            <td align="center"><b>No of Articles</b></td>
            <td align="center"><b>Actual Weight</b></td>
            <td align="center"><b>Charge Weight</b></td>
            <td align="center"><b>Invoice Value</b></td> 
            <td align="center"><b>Mode Of Payment</b></td>
            <td align="center"><b>Rate Per/Kg</b></td> 
            <td align="center"><b>Freight Charges</b></td>
            <td align="center"><b>Docket Charges</b></td>
            <td align="center"><b>FOV Charges</b></td>
            <td align="center"><b>Pickup & Delivery Charges</b></td>
            <td align="center"><b>Topay Charges</b></td>
            <td align="center"><b>Handling Charges</b></td>
            <td align="center"><b>Sub Total</b></td>
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
        
        {assign var=tot_docket value=0}
        {assign var=tot_fov value=0}
        {assign var=tot_sub value=0}
        {assign var=tot_rate value=0}
        {assign var=tot_pickupdel value=0}
        
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
                            <td align="left">{$t + 1}</td>
                            <td align="center">{$row->cargo_code}</td>
                            <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                            <td align="left">{$row->user_first_name}</td>
                            <td align="left">{$row->from_customer_name}</td>
                            <td align="left">{$row->to_customer_name}</td>
                            <td align="left">{$row->from_organization_name}</td>                         
                            <td align="left">{$row->to_organization_name}</td>
                            <td align="center">{$row->total_item_count}</td>
                            <td align="center">{$row->total_actual_unit_value}</td>
                            <td align="center">{$row->total_unit_value}</td>
                            <td align="center">{$row->invoice_amount|inr_format}</td>
                            <td align="center">{$row->payment_status_code}</td>
                            <td align="center">
                                {if ($row->unit_code == "KG")}
                                    {$row->item_freight|inr_format}
                                {else}
                                    -
                                {/if}
                            </td>
                            <td align="center">{$row->total_amount|inr_format}</td>
                            <td align="center">{$row->docket_charge|inr_format}</td>
                            <td align="center">{$row->fov_charge|inr_format}</td>
                            <td align="center">{($row->pickup_handling_amount+$row->delivery_handling_amount)|inr_format}</td>
                            <td align="center">
                                {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->pickup_handling_amount+$row->total_unload_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)-$row->transaction_amount}
                                {$rtopay|inr_format}
                                {assign var='tot_topay' value=$tot_topay+$rtopay} 
                            </td>
                            <td align="center">{$row->total_handling_amount|inr_format}</td>
                            <td align="center">{($row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount)|inr_format}</td>
                        </tr> 
                    
                        {assign var=tot_fare value=$tot_fare+$row->total_amount}
                        {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                        {assign var=tot_payable value=$tot_payable+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->service_tax+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->other_charges_amount}
                        {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                        {assign var=tot_items value=$tot_items+$row->total_item_count}
                        {assign var=tot_commission value=$tot_commission+($row->commission_amount-$row->handling_commission_amount)}
                        {assign var=tot_share value=$tot_share+$row->handling_commission_amount}

                        {assign var=tot_invoice value=$tot_invoice+$row->invoice_amount}
                        {assign var=tot_docket value=$tot_docket+$row->docket_charge}
                        {assign var=tot_fov value=$tot_fov+$row->fov_charge}
                        {assign var=tot_pickupdel value=$tot_pickupdel+($row->pickup_handling_amount+$row->delivery_handling_amount)}
                        
                        {if ($row->unit_code == "KG")}
                            {assign var=tot_rate value=$tot_rate+$row->item_freight}
                        {/if}
                        {assign var=tot_sub value=$tot_sub+$row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount}
                        
                        {assign var=t_service_tax value=$t_service_tax + $row->service_tax}
                        {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
                        {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
                        {assign var=t_pickup_handling_amount value=$t_pickup_handling_amount + $row->pickup_handling_amount}
                        {assign var=t_delivery_handling_amount value=$t_delivery_handling_amount + $row->delivery_handling_amount}
                        {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->other_charges_amount}
                    {/if}
                {/foreach} 
            {/foreach}  
        {else}
            {foreach item=row from=$result key=t}
                {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                    <tr>
                        <td align="left">{$t + 1}</td>
                        <td align="center">{$row->cargo_code}</td>
                        <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                        <td align="left">{$row->user_first_name}</td>
                        <td align="left">{$row->from_customer_name}</td>
                        <td align="left">{$row->to_customer_name}</td>
                        <td align="left">{$row->from_organization_name}</td>                         
                        <td align="left">{$row->to_organization_name}</td>
                        <td align="center">{$row->total_item_count}</td>
                        <td align="center">{$row->total_actual_unit_value}</td>
                        <td align="center">{$row->total_unit_value}</td>
                        <td align="center">{$row->invoice_amount|inr_format}</td>
                        <td align="center">{$row->payment_status_code}</td>
                        <td align="center">
                            {if ($row->unit_code == "KG")}
                                {$row->item_freight|inr_format}
                            {else}
                                -
                            {/if}
                        </td>
                        <td align="center">{$row->total_amount|inr_format}</td>
                        <td align="center">{$row->docket_charge|inr_format}</td>
                        <td align="center">{$row->fov_charge|inr_format}</td>
                        <td align="center">{($row->pickup_handling_amount+$row->delivery_handling_amount)|inr_format}</td>
                        <td align="center">
                            {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->pickup_handling_amount+$row->total_unload_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)-$row->transaction_amount}
                            {$rtopay|inr_format}
                            {assign var='tot_topay' value=$tot_topay+$rtopay} 
                        </td>
                        <td align="center">{$row->total_handling_amount|inr_format}</td>
                        <td align="center">{($row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount)|inr_format}</td>
                    </tr> 

                    {assign var=tot_fare value=$tot_fare+$row->total_amount}
                    {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                    {assign var=tot_payable value=$tot_payable+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}
                    {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                    {assign var=tot_items value=$tot_items+$row->total_item_count}
                    {assign var=tot_commission value=$tot_commission+($row->commission_amount-$row->handling_commission_amount)}
                    {assign var=tot_share value=$tot_share+$row->handling_commission_amount}

                    
                    {assign var=tot_invoice value=$tot_invoice+$row->invoice_amount}
                    {assign var=tot_docket value=$tot_docket+$row->docket_charge}
                    {assign var=tot_fov value=$tot_fov+$row->fov_charge}
                    {if ($row->unit_code == "KG")}
                        {assign var=tot_rate value=$tot_rate+$row->item_freight}
                    {/if}
                    {assign var=tot_pickupdel value=$tot_pickupdel+($row->pickup_handling_amount+$row->delivery_handling_amount)}
                    {assign var=tot_sub value=$tot_sub+$row->total_amount + $row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax + $row->other_charges_amount}
                        
                    {assign var=t_service_tax value=$t_service_tax + $row->service_tax}
                    {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
                    {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
                    {assign var=t_pickup_handling_amount value=$t_pickup_handling_amount + $row->pickup_handling_amount}
                    {assign var=t_delivery_handling_amount value=$t_delivery_handling_amount + $row->delivery_handling_amount}
                    {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->other_charges_amount}

                {/if}

            {/foreach}  
        {/if}
    </tbody>
    {if $result|count}
        <tfoot>
            <tr class="active">                    
                <td align="right" colspan="11" class="bold"><b>Total</b></td>  
                <td align="right" class="bold" data-format="{$xlformat['currency']}"><b>{$tot_invoice}<b></td>
                <td align="right" class="bold"></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$tot_rate}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$tot_fare}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$tot_docket}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$tot_fov}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$tot_pickupdel}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$tot_topay}</b></td>
                <td align='right' class="bold" data-format="{$xlformat['currency']}"><b>{$tot_handling}</b></td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}"><b>{$tot_sub}</b></td>
            </tr> 
        </tfoot>
    {else}
        <tfoot>
            <tr>
                <td colspan="21" align="center">No Records Found</td>
            </tr>
        </tfoot>
    {/if}
</table>