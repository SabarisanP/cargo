<table border="1">
    <tr>
        <td colspan="6" align="center"><b>Vendor Booking Report</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format}</td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$username}</td>
    </tr>
</table>

<table border="1">
    <thead>
        <tr>
            <th align="left">S.No</th>
            <th align="center">{lang('cargo_code_term')}</th>
            <th align="center">Booked User</th>
            <th align="center">Booked Date</th>
            <th align="center">{lang('booking_from_term')}</th>
            <th align="center">{lang('booking_to_label')}</th>
            <th align="center">{lang('booking_sender_term')}</th>
            <th align="center">RAC Name</th>
            <th align="center">{lang('booking_receiver_term')}</th>
            <th align="center">Cargo Status</th>
            <th align="center">Invoice Number</th>
            <th align="center">Items</th>
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
    <tbody>
        {foreach item=row from=$result key=t}
            <tr>
                <td align="left">{$t+1}</td>
                <td align="center">{$row->cargo_code}</td>
                <td align="left">{$row->user_first_name}</td>
                <td align="center">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile}</td>
                <td align="left">{$row->vendor_name}</td>
                <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile}</td>
                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                <td align="center">{$row->invoice_number|default:'-'}</td>
                <td align="left">{$row->cargo_item_name}</td>
                <td align="center">{$row->cargo_item_count}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->service_tax}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_unload_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->other_charges_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount_paid}</td>
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
                <th colspan="12" align="right">Total</th>
                <th align="center">{$tot_qty}</th>
                <th align="right" data-format="{$xlformat['currency']}">{$total_amount}</th>
                <th align="right" data-format="{$xlformat['currency']}">{$service_tax}</th>
                <th align="right" data-format="{$xlformat['currency']}">{$tot_loading}</th>
                <th align="right" data-format="{$xlformat['currency']}">{$tot_unloading}</th>
                <th align="right" data-format="{$xlformat['currency']}">{$tot_other}</th>
                <th align="right" data-format="{$xlformat['currency']}">{$tot_net}</th>
                <th align="right" data-format="{$xlformat['currency']}">{$tot_paid}</th>
            </tr>
        </tfoot>
    {else}
        <tfoot>
            <tr>
                <td colspan="19" align="center">No Records Found</td>
            </tr>
        </tfoot>
    {/if}
</table>
