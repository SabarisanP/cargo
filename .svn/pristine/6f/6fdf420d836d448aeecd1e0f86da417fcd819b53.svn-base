<table class="" width="99%" border='1'>
    <tr>
        <td colspan="6" align="center"><span class="bold">Cargo Prebooking Request Report List</span></td>
    </tr>
    <tr>
        <td width="50%" colspan="3">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right" colspan="3"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%" colspan="3">&nbsp;</td>
        <td width="50%" align="right" colspan="3"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br />

<table border="1" width="99%">
    <thead>
        <tr style="background-color: #64b92a; color: #fff;">
            <td>S.No</td>
            <td>Prebooking / Cargo Number</td>
            <td>Booked Date & Time</td>
            <td>From Branch</td>
            <td>To Branch</td>
            <td>{lang('booking_sender_term')} Name</td>
            <td>{lang('booking_sender_term')} Contact</td>
            <td>{lang('booking_receiver_term')} Name</td>
            <td>{lang('booking_receiver_term')} Contact</td>
            <td>Payment Status</td>
            <td>No.of {lang('booking_article_label')}</td>
            <td>Booking Status</td>
        </tr>
    </thead>
    <tbody>

        {foreach from=$result item=row key=key name=name}
            <tr>
                <td>{$key+1}</td>
                <td>
                    {$row->code}
                    {if $row->cargo_code != 'NA'}
                        / {$row->cargo_code}
                    {/if}
                </td>
                <td>{$row->booked_at|date_format:$ns_datetime_format}</td>
                <td>{$row->from_organization_name}</td>
                <td>{$row->to_organization_name}</td>
                <td>{$row->from_customer_name}</td>
                <td>{$row->from_customer_mobile}</td>
                <td>{$row->to_customer_name}</td>
                <td>{$row->to_customer_mobile}</td>
                <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                <td align="center">{$row->total_item_count}</td>
                <td>{$prebook_status[$row->pre_book_status]}</td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="13" align="center">No results Found</td>
            </tr>
        {/foreach}
    </tbody>
</table>
