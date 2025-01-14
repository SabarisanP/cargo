<style>                        
    .bordered td, .bordered th { border: 0.1px solid #000; }
    .small { font-size: 90% }
    .text-muted { color: #666; }
</style>

<table width="100%" style="font-size: 9px;">
    <tr>
        <td colspan="2" align="center" style="font-size: 13px;"><b>{$namespace_name}</b></td>
    </tr>
    <tr>
        <td colspan="2" align="center" style="font-size: 8px;">
            {if $nsprofile->namespaceProfile->address != '' && $nsprofile->namespaceProfile->address != 'NA'}
                {$nsprofile->namespaceProfile->address}, <br>
                {$nsprofile->namespaceProfile->city}
                {if isNotNull($nsprofile->namespaceProfile->pincode)}
                    - {$nsprofile->namespaceProfile->pincode}
                {/if}
                {if isNotNull($stategst[$nsprofile->namespaceProfile->state->code])}
                    <br><b>GSTIN :</b> {$stategst[$nsprofile->namespaceProfile->state->code]->gstin}
                {/if}
                <br>
            {/if}
        </td>
    </tr>
</table>
<div style="border-top: 1px solid #ccc; height: 0px;"></div>

<table width="100%" style="font-size: 8px;" cellpadding="5">
    <tr>
        <td><b style="font-size: 9px;">Vendor Details: </b><br />
            {$vendor_details->companyName} <br />
            {$vendor_details->address1} <br />
            {if isNotNull($vendor_details->pincode)}{$vendor_details->pincode}{/if}
            {if isNotNull($vendor_details->gst)}
                <br><b>GSTIN :</b> {$vendor_details->gst}
            {/if}
        </td>
    </tr>
</table>
<br />

<div style="font-size: 10px;" style="text-align:center;">
    <b>Cargo Booking Statement For {$vendor_details->companyName}</b>
    <br />
</div>

<table width="100%" style="font-size: 9px;">
    <tr>
        <td><span style="font-weight:bold">Statement Date : </span>
            From {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format}
        </td>
        <td align="right"><span style="font-weight:bold">Statement Generated At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
</table>

<table class="bordered" cellpadding="2">
   
        <tr style="background-color:#64b92a; color:#fff;">
            <th align="left" style="width:30px;">S.No</th>
            <th align="left" style="width:50px;">{lang('cargo_code_term')}</th>
            <th align="left" style="width:80px;">Booked By</th>
            <th align="left" style="width:60px;">{lang('booking_from_term')}</th>
            <th align="left" style="width:60px;">{lang('booking_to_label')}</th>
            <th align="left" style="width:60px;">{lang('booking_sender_term')}</th>
            <th align="left" style="width:60px;">{lang('booking_receiver_term')}</th>
            <th align="center">Cargo Status</th>
            <th align="center" style="width:70px;">Invoice Number</th>
            <th align="center">Items</th>
            <th align="center" style="width:20px;">Qty</th>
            <th align="center" style="width:32px;">Freight</th>
            <th align="center" style="width:30px;">GST</th>
            <th align="center" style="width:35px;">Load Charges</th>
            <th align="center" style="width:35px;">Unload Charges</th>
            <th align="center" style="width:35px;">Other Charges</th>
            <th align="center" style="width:35px;">Net Payable</th>
            <th align="center" style="width:35px;">Total Paid</th>
        </tr>
    
    {assign var=tot_qty value=0}
    {assign var=tot_net value=0}
    {assign var=tot_paid value=0}
    {assign var=total_amount value=0}
    {assign var=service_tax value=0}
    {assign var=tot_loading value=0}
    {assign var=tot_unloading value=0}
    {assign var=tot_other value=0}
    <tbody>
        {foreach item=row from=$result key=t}
            <tr>
                <td align="left" style="width:30px;">{$t+1}</td>
                <td align="center" style="width:50px;">{$row->cargo_code}</td>
                <td align="center" style="width:80px;">{$row->user_first_name} <br/><span class="small text-muted">{$row->transaction_date|date_format:$ns_datetime_format}</span></td>
                <td align="left" style="width:60px;">{$row->from_organization_name} <br/><span class="small text-muted">{$row->from_station_name}</span></td>
                <td align="left" style="width:60px;">{$row->to_organization_name} <br/><span class="small text-muted">{$row->to_station_name}</span></td>
                <td align="left" style="width:60px;">{$row->from_customer_name} <br/><span class="small text-muted">{$row->from_customer_mobile}</span></td>
                <td align="left" style="width:60px;">{$row->to_customer_name} <br/><span class="small text-muted">{$row->to_customer_mobile}</span></td>
                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                <td align="center" style="width:70px;">{$row->invoice_number|default:'-'}</td>
                <td align="left">{$row->cargo_item_name}</td>
                <td align="center" style="width:20px;">{$row->cargo_item_count}</td>
                <td align="right" style="width:32px;">{$row->total_amount}</td>
                <td align="right" style="width:30px;">{$row->service_tax}</td>
                <td align="right" style="width:35px;">{$row->total_handling_amount}</td>
                <td align="right" style="width:35px;">{$row->total_unload_handling_amount}</td>
                <td align="right" style="width:35px;">{$row->other_charges_amount}</td>
                <td align="right" style="width:35px;">{($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)}</td>
                <td align="right" style="width:35px;">{$row->total_amount_paid}</td>
            </tr>
            {assign var=tot_qty value=$tot_qty + $row->cargo_item_count}
            {assign var=tot_net value=$tot_net + ($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)}
            {assign var=tot_paid value=$tot_paid + $row->total_amount_paid}
            {assign var=total_amount value=$total_amount + $row->total_amount}
            {assign var=service_tax value=$service_tax + $row->service_tax}
            {assign var=tot_loading value=$tot_loading + $row->total_handling_amount}
            {assign var=tot_unloading value=$tot_unloading + $row->total_unload_handling_amount}
            {assign var=tot_other value=$tot_other + $row->other_charges_amount}
        {/foreach}
    </tbody>
    {if $result|count}
        <tfoot>
            <tr class="active bold">
                <th colspan="10" align="right">Total</th>
                <th align="center">{$tot_qty}</th>
                <th align="right">{$total_amount}</th>
                <th align="right">{$service_tax}</th>
                <th align="right">{$tot_loading}</th>
                <th align="right">{$tot_unloading}</th>
                <th align="right">{$tot_other}</th>
                <th align="right">{$tot_net}</th>
                <th align="right">{$tot_paid}</th>
            </tr>
        </tfoot>
    {else}
        <tfoot>
            <tr>
                <td colspan="18" align="center">No Records Found</td>
            </tr>
        </tfoot>
    {/if}
</table>
