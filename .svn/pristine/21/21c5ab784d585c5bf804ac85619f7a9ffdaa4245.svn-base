<div class="popup_top sticky-row-top">
    <div class="row">
        <div class="col-md-10 bold ft_14">Recent Bookings</div>
        <div class="col-md-2"> 
            <a class="align-right" onclick="closeRecentBookings()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>

<div class="overflow-x-auto">
    <table id="recent_booking_report_table" class="table table-bordered">
        <thead>
            <tr class="success">
                <td align="center">{lang('cargo_code_term')}</td>
                <td align="center">Booked Date</td>
                <td align="center">No. Of Articles</td>
                <td align="center">{lang('booking_from_term')}</td>
                <td align="center">{lang('booking_to_label')}</td>
                <td align="center">{lang('booking_sender_term')}</td>
                <td align="center">{lang('booking_sender_term')} Contact Number</td>
                <td align="center">{lang('booking_receiver_term')}</td>
                <td align="center">{lang('booking_receiver_term')} Contact Number</td>
                <td align="center">Payment Status</td>
                <td align="center">Cargo Status</td>
                <td align="center">Freight Amount</td>
                <td align="center">GST</td>
                <td align="center">{lang('other_charges')}</td>
                <td align="center">Net Payable</td>
            </tr>
        </thead>
        <tbody class="body_table">

            {assign var=tot_fare value=0}
            {assign var=tot_gst value=0}
            {assign var=tot_handling value=0}
            {assign var=tot_charges value=0}
            {assign var=tot_payable value=0}
            {assign var=tot_paid value=0}
            {assign var=tot_topay value=0}
            {assign var=tot_items value=0}
            {assign var=tot_commission value=0}

            {foreach item=row from=$result key=t}
                <tr>
                    <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                    <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="center">{$row->total_item_count}</td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{$row->from_customer_name}</td>
                    <td align="left">{$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->to_customer_name}</td>
                    <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                    <td align="center">{$cargo_status[$row->cargo_status_code]}</td>

                    <td align="right">{$row->total_amount|inr_format}</td>
                    <td align="right">{$row->service_tax|inr_format}</td>
                    <td align="right" nowrap>
                        {($row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)|inr_format}


                        <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                <table>
                                    {if $row->other_charges_amount != 0}
                                        {foreach key=ck item=cv from=_parse_other_charges($row->other_charges)}
                                                {if $cv == 0}
                                                        {continue}
                                                {/if}
                                                <tr>
                                                    <td>{$ck|_snakecase_to_titlecase}</td>
                                                    <td>&ensp;:&ensp;</td>
                                                    <td align="right"><i class="fa fa-rupee"></i> {$cv|inr_format}</td>
                                                </tr>
                                        {/foreach}
                                    {/if}
                            <tr>
                                <td>Handling Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> {$row->total_handling_amount|inr_format}</td>
                            </tr>
                            <tr>
                                <td>GST</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> {$row->service_tax|inr_format}</td>
                            </tr>
                            <tr>
                                <td>Unloading Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> {$row->total_unload_handling_amount|inr_format}</td>
                            </tr>
                            <tr>
                                <td>Pickup Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> {$row->pickup_handling_amount|inr_format}</td>
                            </tr>
                            <tr>
                                <td>Delivery Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> {$row->delivery_handling_amount|inr_format}</td>
                            </tr>


                                </table>
                        '></i>
                    </td>
                    <td align="right" nowrap>
                        {($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)|inr_format}
                    </td>
                </tr>

                {assign var=tot_fare value=$tot_fare+$row->total_amount}
                {assign var=tot_gst value=$tot_gst+$row->service_tax}
                {assign var=tot_charges value=$tot_charges+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}
                {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                {assign var=tot_payable value=$tot_payable+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}
                {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                {assign var=tot_items value=$tot_items+$row->total_item_count}
                {assign var=tot_commission value=$tot_commission+$row->commission_amount}
            {foreachelse}
                <tr>
                    <td colspan="15" align="center">No Records Found!</td>
                </tr>
            {/foreach}

            {if count($result)}
                <tr class="active">
                    <td align="left" colspan="2"></td>
                    <td align="center">{$tot_items}</td>
                    <td align="left" colspan="7"></td>
    
                    <td align="right" class="bold">Total</td>
                    <td align="right" class="bold">{$tot_fare|inr_format}</td>
                    <td align="right" class="bold">{$tot_gst|inr_format}</td>
                    <td align='right' class="bold" nowrap>{$tot_charges|inr_format} <i class="fa fa-info-circle invisible"></i></td>
                    <td align="right" class="bold">{$tot_payable|inr_format}</td>
                </tr>                
            {/if}
        </tbody>
    </table>
</div>

<script>
    $('#recent_booking_report_table [data-toggle="popover"]').popover({
        placement: 'left',
        html: true,
        trigger: 'hover'
    });

    function closeRecentBookings() {
        $('#recent-bookings').dialog('destroy').hide();
    }
</script>