<table class="" width="100%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Vendor Booking Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span> 
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table> 
<br/>    

<div class="overflow-x-auto">
<table id="vendor_bkg_report_table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th align="center" width="6%">{lang('cargo_code_term')}</th>
            <th align="center">Booked By</th>
            <th align="center">{lang('booking_from_term')}</th>
            <th align="center">{lang('booking_to_label')}</th>
            <th align="center">{lang('booking_sender_term')}</th>
            <th align="center">RAC Name</th>
            <th align="center" width="10%">{lang('booking_receiver_term')}</th>
            <th align="center">Cargo Status</th>
            <th align="center">Invoice Number</th>
            <th align="center" width="11%">Items</th>
            <th align="center">Qty</th>
            <th align="center">Freight</th>
            <th align="center">GST</th>
            <th align="center">Loading Charges</th>
            <th align="center">Unloading Charges</th>
            <th align="center">Other Charges</th>
            <th align="center">Net Payable</th>
            <th align="center">Total Paid</th>
        </tr>
    </thead>
    {assign var=tot_qty value=0}
    {assign var=tot_net value=0}
    {assign var=tot_paid value=0}
    {assign var=total_amount value=0}
    {assign var=service_tax value=0}
    {assign var=tot_loading value=0}
    {assign var=tot_unloading value=0}
    {assign var=tot_other value=0}
    <tbody class="body_table" >
        {foreach item=row from=$result key=t}
            <tr>                    
                <td align="center" nowrap>
                    <a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a>
                    {if ($row->pob_document_count > 0 || $row->pod_document_count > 0)}
                        &nbsp;<a href="javascript:;" onclick="proofDocumentGallery('{$row->cargo_code}');"><i class="fa fa-picture-o"></i></a>
                    {/if}
                </td>
                <td align="center" nowrap>{$row->user_first_name} <br> <span class="small text-muted">{$row->transaction_date|date_format:$ns_datetime_format}</span></td>
                <td align="left">{$row->from_organization_name} <br> <span class="small text-muted">{$row->from_station_name}</span></td>
                <td align="left" nowrap>{$row->to_organization_name} <br> <span class="small text-muted">{$row->to_station_name}</span></td>
                <td align="left">{$row->from_customer_name} <br> <span class="small text-muted">{$row->from_customer_mobile}</span></td>
                <td align="left">{$row->vendor_name}</td>
                <td align="left">{$row->to_customer_name} <br> <span class="small text-muted">{$row->to_customer_mobile}</span></td>
                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                <td align="left">{$row->invoice_number|default:'-'}</td>
                <td align="left">{$row->cargo_item_name}</td>
                <td align="center">{$row->cargo_item_count}</td>
                <td align="right">{$row->total_amount|inr_format}</td>
                <td align="right">{$row->service_tax|inr_format}</td>
                <td align="right">{$row->total_handling_amount|inr_format}</td>
                <td align="right">{$row->total_unload_handling_amount|inr_format}</td>
                <td align="right" nowrap>
                    {$row->other_charges_amount|inr_format}

                    {if $row->other_charges_amount != 0}
                        <i class="fa fa-info-circle" data-toggle="popover" data-content='
                            <table>
                                {foreach key=ck item=cv from=_parse_other_charges($row->other_charges)}
                                    {if $cv == 0}
                                        {continue}
                                    {/if}
                                    <tr>
                                        <td><b>{$ck|_camelcase_to_titlecase}</b></td>
                                        <td>&ensp;:&ensp;</td>
                                        <td align="right"><i class="fa fa-rupee"></i> {$cv|inr_format}</td>
                                    </tr>
                                {/foreach}
                            </table>
                        '></i>
                    {else}
                        <i class="fa fa-info-circle fa-inverse"></i>
                    {/if}
                </td>
                
                <td align="right">{($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)|number_format:2}</td>
                <td align="right">{$row->total_amount_paid|number_format:2}</td>
                {assign var=tot_qty value=$tot_qty + $row->cargo_item_count}
                {assign var=tot_net value=$tot_net + ($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)}
                {assign var=tot_paid value=$tot_paid + $row->total_amount_paid}
                {assign var=total_amount value=$total_amount + $row->total_amount}
                {assign var=service_tax value=$service_tax + $row->service_tax}
                {assign var=tot_loading value=$tot_loading + $row->total_handling_amount}
                {assign var=tot_unloading value=$tot_unloading + $row->total_unload_handling_amount}
                {assign var=tot_other value=$tot_other + $row->other_charges_amount}
            </tr> 
        {foreachelse}
            <tr>
                <td colspan="100%" align="center">No Records Found</td>
            </tr>
        {/foreach}
        {if $result|count}
            <tr class="active bold">
                <td colspan="10" align="right">Total</td>
                <td align="center">{$tot_qty}</td>
                <td align="right">{$total_amount|inr_format}</td>
                <td align="right">{$service_tax|inr_format}</td>
                <td align="right">{$tot_loading|inr_format}</td>
                <td align="right">{$tot_unloading|inr_format}</td>
                <td align="right">{$tot_other|inr_format}</td>
                <td align="right">{$tot_net|inr_format}</td>
                <td align="right">{$tot_paid|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>
</div>
    
<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportVendorBookingExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        <button class="btn btn-default" onclick="exportBranchCollectionsPdf();"><i class="fa fa-print fa-lg"></i> PDF</button>
    </div>
</div> 

<script>
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
</script>