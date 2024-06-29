<div class="popup_top sticky-row-top" style="z-index: 99;">
    <div class="row">
        <div class="col-md-10 ft_14">
            <span class="bold">Branch Booking Summary : {$smarty.request.organizationName}</span>
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeDashReportDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
        </div>
    </div>
</div>

<h5>Paid Booking</h5>
<div class="table-responsive">
    <table id="branch_bkg_report_table" class="table table-bordered " width="99%">
        <thead>
            <tr class="success">
                <td class="sticky-row-top" align="center">S.No</td>
                <td class="sticky-row-top" align="center">{lang('cargo_code_term')}</td>
                <td class="sticky-row-top" align="center">Booked Date</td>
                <td class="sticky-row-top" align="center">{lang('booking_from_term')}</td>
                <td class="sticky-row-top" align="center">User</td>
                <td class="sticky-row-top" align="center">{lang('booking_to_label')}</td>
                <td class="sticky-row-top" align="center">{lang('booking_sender_term')}</td>
                <td class="sticky-row-top" align="center">{lang('booking_receiver_term')}</td>
                <th class="sticky-row-top" align="center">Payment Status</th>
                <td class="sticky-row-top" align="center">Qty</td>
                <td class="sticky-row-top" align="center">Amount</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var="key" value=1}
            {foreach item=row from=$booking key=t}
                {if $row->payment_status_code == 'PAD'}
                    <tr>
                        <td>{$key++}</td>
                        <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                        <td align="center">{$row->booked_at|date_format:$ns_datetime_format}</td>
                        <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                        <td align="left">{$row->user_first_name}</td>
                        <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                        <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile}</td>
                        <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile}</td>
                        <td align="left">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                        <td align="center">{$row->total_item_count|sigma:$pb_total_item_count}</td>
                        <td align="right">{($row->total_amount + $row->other_charges_amount)|sigma:$pb_total_amount|inr_format}</td>
                    </tr>
                {/if}
            {/foreach}
            {if $key > 1}
                <tr class="active bold">
                    <td colspan="9" align="right">Total</td>
                    <td align="center">{$pb_total_item_count}</td>
                    <td align="center">{$pb_total_amount|inr_format}</td>
                </tr>
            {else}
                <tr>
                    <td colspan="100%" align="center">No Records Found!</td>
                </tr>                
            {/if}
        </tbody>
    </table>
</div>

<h5>ToPay Booking</h5>
<div class="table-responsive">
    <table id="branch_bkg_report_table" class="table table-bordered " width="99%">
        <thead>
            <tr class="success">
                <td class="sticky-row-top" align="center">S.No</td>
                <td class="sticky-row-top" align="center">{lang('cargo_code_term')}</td>
                <td class="sticky-row-top" align="center">Booked Date</td>
                <td class="sticky-row-top" align="center">{lang('booking_from_term')}</td>
                <td class="sticky-row-top" align="center">User</td>
                <td class="sticky-row-top" align="center">{lang('booking_to_label')}</td>
                <td class="sticky-row-top" align="center">{lang('booking_sender_term')}</td>
                <td class="sticky-row-top" align="center">{lang('booking_receiver_term')}</td>
                <th class="sticky-row-top" align="center">Payment Status</th>
                <td class="sticky-row-top" align="center">Qty</td>
                <td class="sticky-row-top" align="center">Amount</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var="key" value=1}
            {foreach item=row from=$booking key=t}
                {if $row->payment_status_code == 'TOP'}
                    <tr>
                        <td>{$key++}</td>
                        <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                        <td align="center">{$row->booked_at|date_format:$ns_datetime_format}</td>
                        <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                        <td align="left">{$row->user_first_name}</td>
                        <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                        <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile}</td>
                        <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile}</td>
                        <td align="left">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                        <td align="center">{$row->total_item_count|sigma:$tb_total_item_count}</td>
                        <td align="right">{($row->total_amount + $row->other_charges_amount)|sigma:$tb_total_amount|inr_format}</td>
                    </tr>
                {/if}
            {/foreach}
            {if $key > 1}
                <tr class="active bold">
                    <td colspan="9" align="right">Total</td>
                    <td align="center">{$tb_total_item_count}</td>
                    <td align="center">{$tb_total_amount|inr_format}</td>
                </tr>
            {else}
                <tr>
                    <td colspan="100%" align="center">No Records Found!</td>
                </tr> 
            {/if}
        </tbody>
    </table>
</div>

<h5>Paid Delivery</h5>
<div class="table-responsive">
    <table id="branch_del_report_table" class="table table-bordered " width="99%">
        <thead>
            <tr class="success">
                <td class="sticky-row-top" align="center">S.No</td>
                <td class="sticky-row-top" align="center">{lang('cargo_code_term')}</td>
                <td class="sticky-row-top" align="center">Booked Date</td>
                <td class="sticky-row-top" align="center">{lang('booking_from_term')}</td>
                <td class="sticky-row-top" align="center">User</td>
                <td class="sticky-row-top" align="center">{lang('booking_to_label')}</td>
                <td class="sticky-row-top" align="center">{lang('booking_sender_term')}</td>
                <td class="sticky-row-top" align="center">{lang('booking_receiver_term')}</td>
                <th class="sticky-row-top" align="center">Payment Status</th>
                <td class="sticky-row-top" align="center">Qty</td>
                <td class="sticky-row-top" align="center">Amount</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var="key" value=1}
            {foreach item=row from=$delivery key=t}
                {if $row->payment_status_code == 'PAD'}
                    <tr>
                        <td>{$key++}</td>
                        <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                        <td align="center">{$row->booked_at|date_format:$ns_datetime_format}</td>
                        <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                        <td align="left">{$row->user_first_name}</td>
                        <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                        <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile}</td>
                        <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile}</td>
                        <td align="left">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                        <td align="center">{$row->total_item_count|sigma:$pd_total_item_count}</td>
                        <td align="right">{($row->total_amount + $row->other_charges_amount)|sigma:$pd_total_amount|inr_format}</td>
                    </tr>
                {/if}
            {/foreach}
            {if $key > 1}
                <tr class="active bold">
                    <td colspan="9" align="right">Total</td>
                    <td align="center">{$pd_total_item_count}</td>
                    <td align="center">{$pd_total_amount|inr_format}</td>
                </tr>
            {else}
                <tr>
                    <td colspan="100%" align="center">No Records Found!</td>
                </tr>                
            {/if}
        </tbody>
    </table>
</div>

<h5>ToPay Delivery</h5>
<div class="table-responsive">
    <table id="branch_del_report_table" class="table table-bordered " width="99%">
        <thead>
            <tr class="success">
                <td class="sticky-row-top" align="center">S.No</td>
                <td class="sticky-row-top" align="center">{lang('cargo_code_term')}</td>
                <td class="sticky-row-top" align="center">Booked Date</td>
                <td class="sticky-row-top" align="center">{lang('booking_from_term')}</td>
                <td class="sticky-row-top" align="center">User</td>
                <td class="sticky-row-top" align="center">{lang('booking_to_label')}</td>
                <td class="sticky-row-top" align="center">{lang('booking_sender_term')}</td>
                <td class="sticky-row-top" align="center">{lang('booking_receiver_term')}</td>
                <th class="sticky-row-top" align="center">Payment Status</th>
                <td class="sticky-row-top" align="center">Qty</td>
                <td class="sticky-row-top" align="center">Amount</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var="key" value=1}
            {foreach item=row from=$delivery key=t}
                {if $row->payment_status_code == 'TOP'}
                    <tr>
                        <td>{$key++}</td>
                        <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                        <td align="center">{$row->booked_at|date_format:$ns_datetime_format}</td>
                        <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                        <td align="left">{$row->user_first_name}</td>
                        <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                        <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile}</td>
                        <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile}</td>
                        <td align="left">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                        <td align="center">{$row->total_item_count|sigma:$td_total_item_count}</td>
                        <td align="right">{($row->total_amount + $row->other_charges_amount)|sigma:$td_total_amount|inr_format}</td>
                    </tr>
                {/if}
            {/foreach}
            {if $key > 1}
                <tr class="active bold">
                    <td colspan="9" align="right">Total</td>
                    <td align="center">{$td_total_item_count}</td>
                    <td align="center">{$td_total_amount|inr_format}</td>
                </tr>
            {else}
                <tr>
                    <td colspan="100%" align="center">No Records Found!</td>
                </tr>                
            {/if}
        </tbody>
    </table>
</div>

<style>
    #branch_bkg_report_table .sticky-row-top {
        top: 25px;
    }
    #branch_del_report_table .sticky-row-top {
        top: 25px;
    }
    .popup_top.sticky-row-top {
        padding-top: 1em;
        margin-top: -1em;
        top: -1em;
    }
</style>