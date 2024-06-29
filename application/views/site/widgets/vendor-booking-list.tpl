<div class="popup_top sticky-row-top">
    <div class="row">
        <div class="col-md-10 ft_14">
            <span class="bold">Vendor Booking Summary : {$smarty.request.vendorName}</span>
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeDashReportDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
        </div>
    </div>
</div>

<table id="vendor_bkg_report_table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <td class="sticky-row-top" align="center">{lang('cargo_code_term')}</td>
            <td class="sticky-row-top" align="center">Booked Date</td>
            <td class="sticky-row-top" align="center">{lang('booking_from_term')}</td>
            <td class="sticky-row-top" align="center">User</td>
            <td class="sticky-row-top" align="center">{lang('booking_to_label')}</td>
            <td class="sticky-row-top" align="center">{lang('booking_sender_term')}</td>
            <td class="sticky-row-top" align="center">{lang('booking_receiver_term')}</td>
            <td class="sticky-row-top" align="center">Items</td>
            <td class="sticky-row-top" align="center">Qty</td>
            <td class="sticky-row-top" align="center">Net Payable</td>
            <td class="sticky-row-top" align="center">Total Paid</td>
        </tr>
    </thead>
    {assign var=tot_qty value=0}
    {assign var=tot_net value=0}
    {assign var=tot_paid value=0}
    <tbody class="body_table">
        {foreach item=row from=$result key=t}
            <tr>
                <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                <td align="center">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                <td align="left">{$row->user_first_name}</td>
                <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile}</td>
                <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile}</td>
                <td align="left">{$row->cargo_item_name}</td>
                <td align="center">{$row->cargo_item_count}</td>

                <td align="right">{($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)|number_format:2}</td>
                <td align="right">{$row->total_amount_paid|number_format:2}</td>
                {assign var=tot_qty value=$tot_qty + $row->cargo_item_count}
                {assign var=tot_net value=$tot_net + ($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)}
                {assign var=tot_paid value=$tot_paid + $row->total_amount_paid}
            </tr>
        {/foreach}
        {if $result|count}
            <tr class="active bold">
                <td colspan="8" align="right">Total</td>
                <td align="center">{$tot_qty}</td>
                <td align="right">{$tot_net|number_format:2}</td>
                <td align="right">{$tot_paid|number_format:2}</td>
            </tr>
        {/if}
    </tbody>
</table>

<style>
    #vendor_bkg_report_table .sticky-row-top {
        top: 25px;
    }
    .popup_top.sticky-row-top {
        padding-top: 1em;
        margin-top: -1em;
        top: -1em;
    }
</style>