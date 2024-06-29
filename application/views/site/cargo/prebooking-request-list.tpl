<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Cargo Prebooking Request Report List</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br />
<div class="clearfix"></div>

<table class="table table-bordered">
    <thead>
        <tr class="success">
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
            <td class="noprint">Action</td>
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
                <td>
                    {if $row->pre_book_status == 'REQST'}
                        <span class="badge badge-secondary">{$prebook_status[$row->pre_book_status]}</span>
                    {elseif $row->pre_book_status == 'LOAD'}
                        <span class="badge badge-info">{$prebook_status[$row->pre_book_status]}</span>
                    {elseif $row->pre_book_status == 'ACPTD'}
                        <span class="badge badge-success">{$prebook_status[$row->pre_book_status]}</span>
                    {elseif $row->pre_book_status == 'UNLD'}
                        <span class="badge badge-warning">{$prebook_status[$row->pre_book_status]}</span>
                    {elseif $row->pre_book_status == 'CANCL'}
                        <span class="badge badge-danger">{$prebook_status[$row->pre_book_status]}</span>
                    {else}
                        <span class="badge badge-secondary">{$prebook_status[$row->pre_book_status]}</span>
                    {/if}
                </td>
                <td class="noprint">
                    {if $row->pre_book_status != 'CNVTD'}
                        <button class="btn-app btn-danger" onclick="deletePrebookRequest('{$row->code}')">Delete</button>
                    {/if}
                    {if $row->pre_book_status == 'REQST'}
                        <a href="javascript:;" class="" title="Edit Status" onclick="editPrebookingStatus('{$row->code}')"><i class="fa fa-check-square-o fa-lg "></i></a>
                    {/if}
                </td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="13" align="center">No results Found</td>
            </tr>
        {/foreach}

    </tbody>
</table>


<script>
    function deletePrebookRequest(code) {
        if (code && confirm('Do you want to delete this Prebooking request?')) {
            var data = {};
            data.code = code;
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/delete-prebooking-request",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        getPrebookRequest();
                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }
    }
</script>