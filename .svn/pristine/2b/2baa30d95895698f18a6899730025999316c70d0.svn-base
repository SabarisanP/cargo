<table class="" width="99%" border='1'>
<tr>
    <td colspan="8" align="center"><span style="font-weight:bold">{lang('ogpl')} {lang('lr')}</span></td>
</tr>
<tr>
    <td width="50%"  colspan="4">
        <span style="font-weight:bold">Report Date : </span>
        {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
    <td width="50%" align="right" colspan="4"><span style="font-weight:bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
</tr>
<tr>
    <td width="50%" colspan="4">&nbsp;</td>
    <td width="50%" align="right" colspan="4"><span style="font-weight:bold">Report By : </span> {$usr_login_name} </td>
</tr>
</table>
<br/>
<div class="table-responsive col-md-5 p_l_n">
<table border='1'>
    <thead>
        <tr style="background-color: #64b92a; color: #fff;">
            <th align="left">S. No</th>
            <th align="left">{lang('cargo_code_term')}</th>
            <th align="left">Transit Code</th>
            <th align="left">Trip Date</th>
            <th align="left">Transit Organization</th>
            <th align="left">From Station</th>
            <th align="left">From Organization</th>
            <th align="left">To Station</th>
            <th align="left">To Organization</th>
            <th align="left">{lang('booking_sender_term')}</th>
            <th align="left">{lang('booking_sender_term')} Mobile</th>
            <th align="left">{lang('booking_receiver_term')}</th>
            <th align="left">{lang('booking_receiver_term')} Mobile</th>
            <th align="left">Registration No</th>
            <th align="left">Payment Status Code</th>
            <th align="left">Booked by</th>
            <th align="left">Booked At</th>
            <th align="right">Total Item Count</th>
            <th align="right">Service Charge</th>
            <th align="right">Total Amount</th>
            <th align="right">Delivery Handling Amount</th>
            <th align="right">Pickup Handling Amount</th>
            <th align="right">Paid Amount</th>
            <th align="right">Topay Amount</th>
            <th align="right">Topay then Paid Amount</th>
            <th align="right">On Account Amount</th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_total_item_count value=0}
        {assign var=t_total_charges value=0}
        {assign var=t_total_amount value=0}
        {assign var=t_delivery_handling_amount value=0}
        {assign var=t_pickup_handling_amount value=0}
        {assign var=t_paid_amount value=0}
        {assign var=t_topay_amount value=0}
        {assign var=t_topay_paid_amount value=0}
        {assign var=t_on_account_amount value=0}

        {foreach item=row from=$result key=i}
            <tr>
                <td align="left">{$i + 1}</td>
                <td align="left">{$row->cargo_code}</td>
                <td align="left">{$row->transit_code}</td>
                <td align="left">{$row->trip_date|date_format:$ns_date_format}</td>
                <td align="left">{$row->transit_organization_name}</td>
                <td align="left">{$row->from_station_name}</td>
                <td align="left">{$row->from_organization_name}</td>
                <td align="left">{$row->to_station_name}</td>
                <td align="left">{$row->to_organization_name}</td>
                <td align="left">{$row->from_customer_name}</td>
                <td align="left">{$row->from_customer_mobile}</td>
                <td align="left">{$row->to_customer_name}</td>
                <td align="left">{$row->to_customer_mobile}</td>
                <td align="left">{$row->registration_number}</td>
                <td align="left">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                <td align="left">{$row->user_first_name}</td>
                <td align="left">{$row->booked_at|date_format:$ns_date_format}</td>
                <td align="right">{$row->total_item_count}</td>
                <td align="right">{$row->total_charges|inr_format}</td>
                <td align="right">{$row->total_amount|inr_format}</td>
                <td align="right">{$row->delivery_handling_amount|inr_format}</td>
                <td align="right">{$row->pickup_handling_amount|inr_format}</td>
                <td align="right">{$row->paid_amount|inr_format}</td>
                <td align="right">{$row->topay_amount|inr_format}</td>
                <td align="right">{$row->topay_paid_amount|inr_format}</td>
                <td align="right">{$row->on_account_amount|inr_format}</td>
            </tr>

            {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
            {assign var=t_total_charges value=$t_total_charges + $row->total_charges}
            {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
            {assign var=t_delivery_handling_amount value=$t_delivery_handling_amount + $row->delivery_handling_amount}
            {assign var=t_pickup_handling_amount value=$t_pickup_handling_amount + $row->pickup_handling_amount}
            {assign var=t_paid_amount value=$t_paid_amount + $row->paid_amount}
            {assign var=t_topay_amount value=$t_topay_amount + $row->topay_amount}
            {assign var=t_topay_paid_amount value=$t_topay_paid_amount + $row->topay_paid_amount}
            {assign var=t_on_account_amount value=$t_on_account_amount + $row->on_account_amount}
        {/foreach}

        {if $result|count}
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td colspan="17" align="right">Total</td>
                <td align='right'>{$t_total_item_count|inr_format}</td>
                <td align='right'>{$t_total_charges|inr_format}</td>
                <td align='right'>{$t_total_amount|inr_format}</td>
                <td align='right'>{$t_delivery_handling_amount|inr_format}</td>
                <td align='right'>{$t_pickup_handling_amount|inr_format}</td>
                <td align='right'>{$t_paid_amount|inr_format}</td>
                <td align='right'>{$t_topay_amount|inr_format}</td>
                <td align='right'>{$t_topay_paid_amount|inr_format}</td>
                <td align='right'>{$t_on_account_amount|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>
</div>