<table class="" width="99%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">GST Collection Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br/>
<div class="row">
    {foreach from=$summary item=item key=k}
        
    <div class="col-md-3">
        <h5><b>{$k}</b></h5>
        {foreach from=$item item=row key=l}
            <div class="bold">GSTIN : {$row['gst_state']} - {$l}</div>
            <table id="dt_bp_report_table" class="table table-bordered">
                <thead>
                    <tr>
                        <td align="center" class="bold">{if $cargo_setting->lrGstTaxComputeType == 'NET'}Net Amount {else} Freight{/if}</td>
                        <td align="center" class="bold">SGST</td>
                        <td align="center" class="bold">CGST</td>
                        <td align="center" class="bold">IGST</td>
                        <td align="center" class="bold">Total</td>
                    </tr>
                </thead>
                <tbody class="body_table">
                {assign var=freightNet value=0}
                    <tr>                    
                        {if $cargo_setting->lrGstTaxComputeType == 'NET'}
                            {assign var=freightNet value=$freightNet+$row['netpayable']}
                        {else}
                            {assign var=freightNet value=$freightNet+$row['freight']}
                        {/if}
                       {assign var=total value=$total+$row['igst']+$row['sgst']+$row['cgst']+$freightNet}
                        <td class="text-right">{$freightNet|number_format:2}</td>
                        <td class="text-right">{$row['sgst']|ceil|number_format:2}</td>
                        <td class="text-right">{$row['cgst']|ceil|number_format:2}</td>            
                        <td class="text-right">{$row['igst']|ceil|number_format:2}</td>         
                        <td class="text-right">{($row['igst']+$row['sgst']+$row['cgst']+$freightNet)|ceil|number_format:2}</td>
                    </tr>
                </tbody>
            </table>
        {/foreach}
    </div>
        
    {/foreach}
    <div class="col-md-5">

        <h5 class="noprint"><b>Summary</b></h5>
        <table class="table table-bordered noprint" style="width:100%;">
            <thead>

                <tr class="info bold">
                    <th>Transaction</th>
                    <th>{if $cargo_setting->lrGstTaxComputeType == 'NET'}Net Amount (A){else}Freight (A){/if}</th>
                    <th>SGST (B)</th>
                    <th>CGST (C)</th>
                    <th>IGST (D)</th>
                    <th>Total (A+ B+ C+ D)</th>
                </tr>
            </thead>
            {if $cargo_setting->lrGstTaxComputeType == 'NET'}
            {assign var=frightnetA value=$booking['netpayable']}
            {assign var=frightnetB value=$cancel['netpayable']}
            {assign var=frightnetC value=$nongst_booking['netpayable']}
            {assign var=frightnetD value=$nongst_cancel['netpayable']}
            {else}
            {assign var=frightnetA value=$booking['freight']}
            {assign var=frightnetB value=$cancel['freight']}
            {assign var=frightnetC value=$nongst_booking['freight']}
            {assign var=frightnetD value=$nongst_cancel['freight']}
            {/if}
            <tbody>
                <tr>
                    <td>Booking (A)</td>
                    <td class="text-right">{$frightnetA|number_format:2}</td>
                    <td class="text-right">{$booking['sgst']|ceil|number_format:2}</td>
                    <td class="text-right">{$booking['cgst']|ceil|number_format:2}</td>            
                    <td class="text-right">{$booking['igst']|ceil|number_format:2}</td>         
                    <td class="text-right">{($booking['igst']+$booking['sgst']+$booking['cgst']+$frightnetA)|ceil|number_format:2}</td>
                </tr>
                <tr>
                    <td>Cancel (B)</td>
                    <td class="text-right">{$frightnetB|number_format:2}</td>
                    <td class="text-right">{$cancel['sgst']|ceil|number_format:2}</td>
                    <td class="text-right">{$cancel['cgst']|ceil|number_format:2}</td>            
                    <td class="text-right">{$cancel['igst']|ceil|number_format:2}</td>         
                    <td class="text-right">{($cancel['igst']+$cancel['sgst']+$cancel['cgst']+$frightnetB)|ceil|number_format:2}</td>
                </tr>
                <tr>
                    <td>Non GST Booking (C)</td>
                    <td class="text-right">{$frightnetC|number_format:2}</td>
                    <td class="text-right">{$nongst_booking['sgst']|ceil|number_format:2}</td>
                    <td class="text-right">{$nongst_booking['cgst']|ceil|number_format:2}</td>            
                    <td class="text-right">{$nongst_booking['igst']|ceil|number_format:2}</td>         
                    <td class="text-right">{($nongst_booking['igst']+$nongst_booking['sgst']+$nongst_booking['cgst']+$frightnetC)|ceil|number_format:2}</td>
                </tr>
                <tr>
                    <td>Non GST Cancel (D)</td>
                    <td class="text-right">{$frightnetD|number_format:2}</td>
                    <td class="text-right">{$nongst_cancel['sgst']|ceil|number_format:2}</td>
                    <td class="text-right">{$nongst_cancel['cgst']|ceil|number_format:2}</td>            
                    <td class="text-right">{$nongst_cancel['igst']|ceil|number_format:2}</td>         
                    <td class="text-right">{($nongst_cancel['igst']+$nongst_cancel['sgst']+$nongst_cancel['cgst']+$frightnetD)|ceil|number_format:2}</td>
                </tr>
            </tbody>
            {assign var=book_total value=$frightnetA+$booking['sgst']+$booking['cgst']+$booking['igst']}
            {assign var=cancel_total value=$frightnetB+$cancel['sgst']+$cancel['cgst']+$cancel['igst']}
            {assign var=nongst_booking_total value=$frightnetC+$nongst_booking['sgst']+$nongst_booking['cgst']+$nongst_booking['igst']}
            {assign var=nongst_cancel_total value=$frightnetD+$nongst_cancel['sgst']+$nongst_cancel['cgst']+$nongst_cancel['igst']}

            {assign var=freight_total value=$frightnetA-$frightnetB+$frightnetC-$frightnetD}
            {assign var=sgst_total value=$booking['sgst']-$cancel['sgst']+$nongst_booking['sgst']-$nongst_cancel['sgst']}
            {assign var=cgst_total value=$booking['cgst']-$cancel['cgst']+$nongst_booking['cgst']-$nongst_cancel['cgst']}
            {assign var=igst_total value=$booking['igst']-$cancel['igst']+$nongst_booking['igst']-$nongst_cancel['igst']}

            <tr class="active bold">
                <td class="text-left" colspan="1"><b>Net Total (A - B + C - D)</b></td>
                <td class="text-right">{$freight_total|number_format:2}</td>
                <td class="text-right">{$sgst_total|ceil|number_format:2}</td>
                <td class="text-right">{$cgst_total|ceil|number_format:2}</td>            
                <td class="text-right">{$igst_total|ceil|number_format:2}</td>         
                <td class="text-right">{($book_total-$cancel_total+$nongst_booking_total-$nongst_cancel_total)|ceil|number_format:2}</td>
            </tr>
        </table>
        
    </div>
</div>
   
{function name="gstTable" data=[]}        
{if $data.data}    
    <h5><b>{$data.title} Transactions</b></h5>
    <div class="clearfix"></div>
<div class="table-responsive" style="overflow: auto;">
    <table id="demo" class="table table-bordered" width="98%" nowrap>
        <thead>
            <tr class="success">
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
                <td align="center">{if $cargo_setting->lrGstTaxComputeType == 'NET'}Net Amount{else}Freight{/if}</td>
                <td align="center">SGST</td>
                <td align="center">CGST</td>
                <td align="center">IGST</td>
                <td align="center">Payment Status</td>
                <td align="center">Cargo Status</td>
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
                    <td align="left">{$row->cargo_code}</td>
                    <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                            <td align="left">{$row->from_organization_name}</td>                            
                            <td align="left">{($row->to_organization_name)? $row->to_organization_name : "-"}</td>
                            <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                            <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td>
                            <td align="left" nowrap>{($row->from_customer_gstin)? $row->from_customer_gstin : "-"}</td>
                            <td align="left">{($row->to_customer_gstin)? $row->to_customer_gstin : "-"}</td>
                            <td align="left">{($row->trade_name)? $row->trade_name : "-"}</td>
                            <td align="left">{($row->gstin)? $row->gstin : "-"}</td>
                            <td align="left" nowrap>{$row->state_name}</td>
                            {if $cargo_setting->lrGstTaxComputeType == 'NET'}
                                {assign var=nettotal value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)}
                                {assign var=taxttotal value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->other_charges_amount)}
                            {else} 
                                {assign var=nettotal value=($row->total_amount)}
                                {assign var=taxttotal value=($row->total_amount)}
                            {/if}
                            <td align="right">{$nettotal|number_format:2}</td>
                            <td align="right">
                                {($row->service_tax == 0) ? "0.00" : ((($taxttotal * $row->sgst)/100)|ceil|number_format:2)}
                            </td>
                            <td align="right">
                                {($row->service_tax == 0) ? "0.00" : ((($taxttotal * $row->cgst)/100)|ceil|number_format:2)}
                            </td>
                            <td align="right">
                                {($row->service_tax == 0) ? "0.00" : ((($taxttotal * $row->igst)/100)|ceil|number_format:2)}
                            </td>
                            <td align="left">{$cargo_payment_status[$row->payment_status_code]}</td> 
                            <td align="left">{$cargo_status[$row->cargo_status_code]}</td> 
                            {* <td align="right">{$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax}</td> *}
                            <td align="right">{$row->total_handling_amount|number_format:2}</td>
                            {* <td align="right">{$row->service_tax}</td> *}
                            <td align="right">{$row->total_unload_handling_amount|number_format:2}</td>
                            {* <td align="right">{$row->pickup_handling_amount|number_format:2}</td>
                            <td align="right">{$row->delivery_handling_amount|number_format:2}</td>
                            <td align="right">{$row->commission_amount+$row->handling_commission_amount}</td>
                            <td align="right">{$row->transaction_amount}</td>
                            <td align="right">                    
                                {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)-$row->transaction_amount}
                                {$rtopay|number_format:2}
                                {assign var='tot_topay' value=$tot_topay+$rtopay}                    
                            </td> *}
                </tr>
                {if $cargo_setting->lrGstTaxComputeType == 'NET'}
                    {assign var=tot_freight value=$tot_freight+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}
                {else}
                    {assign var=tot_freight value=$tot_freight+$row->total_amount}
                {/if}
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
            {foreachelse}
                <tr>
                    <td colspan="100%" align="center">No Records Found!</td>
                </tr>
            {/foreach}

            {if $result|count}
                <tr class="active bold">
                    <td align="right" colspan="11" class="bold">Total</td>
                    <td align="right">{$tot_freight|number_format:2}</td>
                    <td align="right">{($tot_sgst)|ceil|number_format:2}</td>
                    <td align="right">{($tot_cgst)|ceil|number_format:2}</td>
                    <td align="right">{($tot_igst)|ceil|number_format:2}</td>
                    <td align="right"></td>
                    <td align="right"></td>
                    <td align="right">{$tot_handling|number_format:2}</td>
                    <td align="right">{$tot_unload|number_format:2}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>
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
        'data' => $nongst_booking['nongst_booking'],
        'title' => 'Non GST Booking'
    ]}

    {call gstTable data=[
        'data' => $nongst_cancel['nongst_cancel'],
        'title' => 'Non GST Cancel'
    ]}
    

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoTransExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>