<div class="popup_top">
    <div class="row">
        <div class="col-md-10 ft_14">
            <span class="bold">{if $smarty.request.filterType == 'BO'}Paid Booking{elseif $smarty.request.filterType == 'TDL'}ToPay Delivery{elseif $smarty.request.filterType == 'RVT'}Revert Payment{/if}</span>
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeLRdetails()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
        </div>
    </div>
</div>

<table id="dt_adv_booking_report_table" class="table table-bordered " >
    <thead>
        <tr class="success">
            <td align="center">{lang('cargo_code_term')}</td>
            <td align="center">Booked Date</td>
            <td align="center">{lang('booking_from_term')}</td>
            <td align="center">User</td>
            <td align="center">{lang('booking_to_label')}</td>
            {* <td align="center">{lang('booking_sender_term')}</td>
            <td align="center">{lang('booking_receiver_term')}</td> *}
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
            <td align="center">Transaction Mode</td>
            <td align="center">Qty</td>
            <td align="center">Freight</td>
            <td align="center">GST</td>
            <td align="center">Other Charges</td>
            {if $filterType == 'COM'}
                <td align="center">TDS</td>
                <td align="center">Commission</td>
                <td align="center">Charges Share</td>
                <td align="center">Total Commission</td>
            {else}
                <td align="center">Net Payable</td>                
            {/if}
        </tr>

    </thead>
    <tbody class="body_table" >

        {assign var=tot_fare value=0}
        {assign var=tot_gst value=0}
        {assign var=tot_charges value=0}
        {assign var=tot_handling value=0}
        {assign var=tot_paid value=0}
        {assign var=tot_topay value=0}
        {assign var=tot_tds value=0}
        {assign var=tot_commission value=0}
        {assign var=tot_transaction value=0}
        {assign var=tot_payable value=0}

        {foreach item=row from=$result key=t}
            {$commission_amount = $row->commission_amount + $row->handling_commission_amount}
            <tr>
                <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->from_organization_name}</td>
                <td align="left">{$row->user_first_name}</td>
                <td align="left">{$row->to_organization_name}</td>
                {* <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td> *}
                <td align="center">
                    {$row->payment_status_code|_cargo_payment_status_badge}
                </td>
                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                <td align="left" nowrap>{$transaction_mode[$row->transaction_mode]|default:'-'}</td>
                <td align="center">{$row->total_item_count}</td>
                <td align="right">{$row->total_amount|number_format:2}</td>
                <td align="right">{$row->service_tax|number_format:2}</td>
                <td align="right">
                    {assign var="other_charges" value=($row->total_handling_amount + $row->total_unload_handling_amount + $row->pickup_handling_amount + $row->delivery_handling_amount + $row->hamali_charge + $row->pass_charge + $row->docket_charge + $row->pod_charge + $row->service_charge + $row->round_off_value)}
                    {$other_charges|number_format:2}

                    {if $other_charges != 0}
                        <i class="fa fa-info-circle" data-toggle="popover" data-content='
                            <table>
                                {if $row->total_handling_amount > 0}
                                <tr>
                                    <td><b>Loading Charges</b></td>
                                    <td>&ensp;:&ensp;</td>
                                    <td align="right"><i class="fa fa-rupee"></i> {$row->total_handling_amount|inr_format}</td>
                                </tr>
                                {/if}
                                {if $row->total_unload_handling_amount > 0}
                                <tr>
                                    <td><b>Unloading Charges</b></td>
                                    <td>&ensp;:&ensp;</td>
                                    <td align="right"><i class="fa fa-rupee"></i> {$row->total_unload_handling_amount|inr_format}</td>
                                </tr>
                                {/if}
                                {if $row->pickup_handling_amount > 0}
                                <tr>
                                    <td><b>Door Pickup Charges</b></td>
                                    <td>&ensp;:&ensp;</td>
                                    <td align="right"><i class="fa fa-rupee"></i> {$row->pickup_handling_amount|inr_format}</td>
                                </tr>
                                {/if}
                                {if $row->delivery_handling_amount > 0}
                                <tr>
                                    <td><b>Door Delivery Charges</b></td>
                                    <td>&ensp;:&ensp;</td>
                                    <td align="right"><i class="fa fa-rupee"></i> {$row->delivery_handling_amount|inr_format}</td>
                                </tr>
                                {/if}
                                {if $row->hamali_charge > 0}
                                <tr>
                                    <td><b>Hamali Charges</b></td>
                                    <td>&ensp;:&ensp;</td>
                                    <td align="right"><i class="fa fa-rupee"></i> {$row->hamali_charge|inr_format}</td>
                                </tr>
                                {/if}
                                {if $row->pass_charge > 0}
                                <tr>
                                    <td><b>Pass Charges</b></td>
                                    <td>&ensp;:&ensp;</td>
                                    <td align="right"><i class="fa fa-rupee"></i> {$row->pass_charge|inr_format}</td>
                                </tr>
                                {/if}
                                {if $row->docket_charge > 0}
                                <tr>
                                    <td><b>Docket Charges</b></td>
                                    <td>&ensp;:&ensp;</td>
                                    <td align="right"><i class="fa fa-rupee"></i> {$row->docket_charge|inr_format}</td>
                                </tr>
                                {/if}
                                {if $row->pod_charge > 0}
                                <tr>
                                    <td><b>POD Charges</b></td>
                                    <td>&ensp;:&ensp;</td>
                                    <td align="right"><i class="fa fa-rupee"></i> {$row->pod_charge|inr_format}</td>
                                </tr>
                                {/if}
                                {if $row->service_charge > 0}
                                <tr>
                                    <td><b>Service Charges</b></td>
                                    <td>&ensp;:&ensp;</td>
                                    <td align="right"><i class="fa fa-rupee"></i> {$row->service_charge|inr_format}</td>
                                </tr>
                                {/if}
                            </table>
                        '></i>
                    {else}
                        <i class="fa fa-info-circle fa-inverse"></i>
                    {/if}
                </td>
                {if $filterType == 'COM'}
                    <td align="right">{$row->tds_tax|number_format:2}</td>
                    <td align="right">{$row->commission_amount|number_format:2}</td>
                    <td align="right">{$row->handling_commission_amount|number_format:2}</td>
                    <td align="right">{$commission_amount|number_format:2}</td>
                {else}
                    <td align="right">
                        {* {assign var="payable" value=($row->total_amount + $row->service_tax + $other_charges)} *}
                        {$row->transaction_amount|number_format:2}
                    </td>
                {/if}
            </tr>

            {assign var=tot_fare value=$tot_fare+$row->total_amount}
            {assign var=tot_gst value=$tot_gst+$row->service_tax}
            {assign var=tot_charges value=$tot_charges+$other_charges}
            {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
            {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
            {assign var=tot_items value=$tot_items+$row->total_item_count}
            {assign var=tot_tds value=$tot_tds+$row->tds_tax}
            {assign var=tot_commission value=$tot_commission+$row->commission_amount}
            {assign var=tot_handling_commission value=$tot_handling_commission+$row->handling_commission_amount}
            {assign var=tot_commission_amount value=$tot_commission_amount+$commission_amount}
            {assign var=tot_transaction value=$tot_transaction+$row->transaction_amount}
            {assign var=tot_payable value=$tot_payable+$row->transaction_amount}
        {foreachelse}
            <tr>
                <td colspan="14" align="center">No Records Found!</td>
            </tr>
        {/foreach}

        {if count($result)}
            <tr class="active">
                <td align="right" colspan="8" class="bold">Total</td>
                <td align="center" class="bold">{$tot_items}</td>
                <td align="right" class="bold">{$tot_fare|number_format:2}</td>
                <td align="right" class="bold">{$tot_gst|number_format:2}</td>
                <td align="right" class="bold" nowrap>{$tot_charges|number_format:2} <i class="fa fa-info-circle invisible"></i></td>
                {if $filterType == 'COM'}
                    <td align="right" class="bold">{$tot_tds|number_format:2}</td>
                    <td align="right" class="bold">{$tot_commission|number_format:2}</td>
                    <td align="right" class="bold">{$tot_handling_commission|number_format:2}</td>
                    <td align="right" class="bold">{$tot_commission_amount|number_format:2}</td>
                {else}
                    <td align="right" class="bold">{$tot_payable|number_format:2}</td>
                {/if}
            </tr>
        {/if}

    </tbody>
</table>

<script>
$('[data-toggle="popover"]').popover({
    placement: 'left',
    html: true,
    trigger: 'hover'
});
</script>