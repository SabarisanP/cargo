{strip}
<table border='1'>
    <tr>
        <td colspan="6" align="center"><b>GST Collection Report</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$usr_login_name}</td>
    </tr>
</table>
<br>
    {foreach from=$summary item=item key=k}
        <table class="table table-bordered " border='1'  width="30%">
            <tr  style="background-color: #64b92a;">
                <td  colspan="5" align="center"><span class="bold">{$k}</span></td>
            </tr>
        </table>
            
        {foreach from=$item item=row key=l}
            
            <table  class="table table-bordered " border='1' width="30%">
                <tr>
                    <td colspan="5" align="center"><span class="bold"> GSTIN : {$row['gst_state']} - {$l}</span></td>
                </tr>
                <thead>
                    <tr>
                        <td align="center" class="bold">Freight</td>
                        <td align="center" class="bold">SGST</td>
                        <td align="center" class="bold">CGST</td>
                        <td align="center" class="bold">IGST</td>
                        <td align="center" class="bold">Total</td>
                    </tr>
                </thead>
                <tbody class="body_table">
                    <tr>                    
                       {assign var=total value=$total+$row['igst']+$row['sgst']+$row['cgst']+$row['freight']}
                        <td class="bold text-right"><b>{$row['freight']|number_format:2}</b></td>
                        <td class="bold text-right"><b>{$row['sgst']|number_format:2}</b></td>
                        <td class="bold text-right"><b>{$row['cgst']|number_format:2}</b></td>            
                        <td class="bold text-right"><b>{$row['igst']|number_format:2}</b></td>         
                        <td class="bold text-right"><b>{($row['igst']+$row['sgst']+$row['cgst']+$row['freight'])|number_format:2}</b></td>
                    </tr>
                </tbody>
            </table>
        {/foreach}
        <br>
    {/foreach}
    <br>
        <table class="table table-bordered " border='1'>
            <tr class="info bold"><td colspan="6" align="center" class="bold" ><b>Summary</b></td></tr>
            <thead>

                <tr style="background-color: #64b92a;">
                    <th>Transaction</th>
                    <th>Freight (A)</th>
                    <th>SGST (B)</th>
                    <th>CGST (C)</th>
                    <th>IGST (D)</th>
                    <th>Total (A+ B+ C+ D)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Booking (A)</td>
                    <td class="text-right">{$booking['freight']|number_format:2}</td>
                    <td class="text-right">{$booking['sgst']|number_format:2}</td>
                    <td class="text-right">{$booking['cgst']|number_format:2}</td>            
                    <td class="text-right">{$booking['igst']|number_format:2}</td>         
                    <td class="text-right">{($booking['igst']+$booking['sgst']+$booking['cgst']+$booking['freight'])|number_format:2}</td>
                </tr>
                <tr>
                    <td>Cancel (B)</td>
                    <td class="text-right">{$cancel['freight']|number_format:2}</td>
                    <td class="text-right">{$cancel['sgst']|number_format:2}</td>
                    <td class="text-right">{$cancel['cgst']|number_format:2}</td>            
                    <td class="text-right">{$cancel['igst']|number_format:2}</td>         
                    <td class="text-right">{($cancel['igst']+$cancel['sgst']+$cancel['cgst']+$cancel['freight'])|number_format:2}</td>
                </tr>
                <tr>
                    <td>Others (C)</td>
                    <td class="text-right">{$others['freight']|number_format:2}</td>
                    <td class="text-right">{$others['sgst']|number_format:2}</td>
                    <td class="text-right">{$others['cgst']|number_format:2}</td>            
                    <td class="text-right">{$others['igst']|number_format:2}</td>         
                    <td class="text-right">{($others['igst']+$others['sgst']+$others['cgst']+$others['freight'])|number_format:2}</td>
                </tr>
            </tbody>
            {assign var=book_total value=$booking['freight']+$booking['sgst']+$booking['cgst']+$booking['igst']}
            {assign var=cancel_total value=$cancel['freight']+$cancel['sgst']+$cancel['cgst']+$cancel['igst']}
            {assign var=others_total value=$others['freight']+$others['sgst']+$others['cgst']+$others['igst']}

            {assign var=freight_total value=$booking['freight']-$cancel['freight']+$others['freight']}
            {assign var=sgst_total value=$booking['sgst']-$cancel['sgst']+$others['sgst']}
            {assign var=cgst_total value=$booking['cgst']-$cancel['cgst']+$others['cgst']}
            {assign var=igst_total value=$booking['igst']-$cancel['igst']+$others['igst']}

            <tr class="active bold">
                <td class="bold text-left" colspan="1"><b>Net Total (A - B + C)</b></td>
                <td class="bold text-right"><b>{$freight_total|number_format:2}</b></td>
                <td class="bold text-right"><b>{$sgst_total|number_format:2}</b></td>
                <td class="bold text-right"><b>{$cgst_total|number_format:2}</b></td>            
                <td class="bold text-right"><b>{$igst_total|number_format:2}</b></td>         
                <td class="bold text-right"><b>{($book_total-$cancel_total+$others_total)|number_format:2}</b></td>
            </tr>
        </table>
        
{function name="gstTable" data=[]}        
{if $data.data}
<br/>    
    <table class="table table-bordered"  width="30%">
        <tr>
            <td  colspan="3" align="left"><span class="bold"><b>{$data.title} Transactions</b></span></td>
        </tr>
    </table>
    <table class="table table-bordered " border='1'>
        <thead>
            <tr style="background-color: #64b92a;">
                <td align="center">{lang('cargo_code_term')}</td>
                <td align="center">Booked Date</td> 
                <td align="center">{lang('booking_from_term')}</td>                    
                <td align="center">{lang('booking_to_label')}</td>
                <td align="center">{lang('booking_sender_term')}</td>
                <td align="center">{lang('booking_receiver_term')}</td>
                <td align="center">{lang('booking_sender_term')} GST</td>
                <td align="center">{lang('booking_receiver_term')} GST</td>
                <td align="center">Trade Name</td>
                <td align="center">GSTIN</td>
                <td align="center">State</td>
                <td align="center">Freight</td>
                <td align="center">SGST</td>
                <td align="center">CGST</td>
                <td align="center">IGST</td>
                <td align="center">Payment Status</td>
                <td align="center">Cargo Status</td>
                <td align="center">Quantity</td>
                <td align="center">Item Count</td>
                <td align="center">Handling Charge</td>
                <td align="center">Unloading Charge</td>
            </tr>
        </thead>
        <tbody class="body_table">

            {assign var=tot_handling value=0}
            {assign var=tot_payable value=0}
            {assign var=tot_gst value=0}
            {assign var=tot_unload value=0}
            {assign var=tot_pickup value=0}
            {assign var=tot_dlvry value=0}
            {assign var=tot_commission value=0}
            {assign var=tot_paid value=0}
            {assign var=tot_topay value=0}

            {foreach item=row from=$data.data}
                <tr>
                    <td align="left">{$row->cargo_code}</td><td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                            <td align="left">{$row->from_organization_name}</td>                            
                            <td align="left">{($row->to_organization_name)? $row->to_organization_name : "-"}</td>
                            <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                            <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td>
                            <td align="left">{($row->from_customer_gstin)? $row->from_customer_gstin : "-"}</td>
                            <td align="left">{($row->to_customer_gstin)? $row->to_customer_gstin : "-"}</td>
                            <td align="left">{($row->trade_name)? $row->trade_name : "-"}</td>
                            <td align="left">{($row->gstin)? $row->gstin : "-"}</td>
                            <td align="left">{$row->state_name}</td>
                            <td align="right">{$row->total_amount|number_format:2}</td>
                            {assign var=taxttotal value=($row->total_amount)}
                            <td align="right">
                                {($row->service_tax == 0) ? "0.00" : ((($taxttotal * $row->sgst)/100)|number_format:2)}
                            </td>
                            <td align="right">
                                {($row->service_tax == 0) ? "0.00" : ((($taxttotal * $row->cgst)/100)|number_format:2)}
                            </td>
                            <td align="right">
                                {($row->service_tax == 0) ? "0.00" : ((($taxttotal * $row->igst)/100)|number_format:2)}
                            </td>
                            <td align="left">{$cargo_payment_status[$row->payment_status_code]}</td> 
                            <td align="left">{$cargo_status[$row->cargo_status_code]}</td> 
                            <td align="left">{$row->total_item_count}</td>
                            <td align="left">{$row->total_count}</td>
                        
                            {* <td align="right">{$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax}</td> *}
                            <td align="right">{$row->total_handling_amount|number_format:2}</td>
                            {* <td align="right">{$row->service_tax}</td> *}
                            <td align="right">{$row->total_unload_handling_amount|number_format:2}</td>
                            {* <td align="right">{$row->pickup_handling_amount}</td>
                            <td align="right">{$row->delivery_handling_amount}</td>
                            <td align="right">{$row->commission_amount+$row->handling_commission_amount}</td>
                            <td align="right">{$row->transaction_amount}</td>
                            <td align="right">                    
                                {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)-$row->transaction_amount}
                                {$rtopay}
                                {assign var='tot_topay' value=$tot_topay+$rtopay}                    
                            </td> *}
                </tr>
                {assign var=tot_freight value=$tot_freight+$row->total_amount}
                {assign var=tot_sgst value=$tot_sgst+(($row->service_tax == 0) ? "0.00" : (($taxttotal * $row->sgst)/100))}
                {assign var=tot_cgst value=$tot_cgst+(($row->service_tax == 0) ? "0.00" : (($taxttotal * $row->cgst)/100))}
                {assign var=tot_igst value=$tot_igst+(($row->service_tax == 0) ? "0.00" : (($taxttotal * $row->igst)/100))}



                {assign var=tot_handling value=$tot_handling + $row->total_handling_amount}
                {assign var=tot_gst value=$tot_gst + $row->service_tax}
                {assign var=tot_payable value=$tot_payable +$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax}
                {assign var=tot_pickup value=$tot_pickup + $row->pickup_handling_amount}
                {assign var=tot_unload value=$tot_unload + $row->total_unload_handling_amount}
                {assign var=tot_dlvry value=$tot_dlvry + $row->delivery_handling_amount}
                {assign var=tot_commission value=$tot_commission+$row->commission_amount+$row->handling_commission_amount}
                {assign var=tot_paid value=$tot_paid + $row->transaction_amount}
            {/foreach}
        </tbody>
        {if $result|count}
            <tfoot>
                <tr class="active bold">
                    <td align="right" colspan="11" class="bold"><b>Total</b></td>
                    <td align="right"><b>{$tot_freight|number_format:2}</b></td>
                    <td align="right"><b>{$tot_sgst|number_format:2}</b></td>
                    <td align="right"><b>{$tot_cgst|number_format:2}</b></td>
                    <td align="right"><b>{$tot_igst|number_format:2}</b></td>
                    <td align="right"></td>
                    <td align="right"></td>
                    <td align="right"></td>
                    <td align="right"></td>
                    <td align="right"><b>{$tot_handling|number_format:2}</b></td>
                    <td align="right"><b>{$tot_unload|number_format:2}</b></td>
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
    {/if}
{/function}

{call gstTable data=[
    'data' => $booking['booking'],
    'title' => 'Booking'
]}

{call gstTable data=[
    'data' => $cancel['cancel'],
    'title' => 'Cancel'
]}

{call gstTable data=[
    'data' => $others['others'],
    'title' => 'Other'
]}
    
{/strip}