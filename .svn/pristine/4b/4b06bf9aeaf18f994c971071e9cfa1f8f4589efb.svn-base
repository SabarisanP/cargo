<div class="row">
    <div class="col-md-10 bold ft_14">PreBookings</div>
    <div class="col-md-2">
        <a class="align-right" onclick="closePrebookingDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
    </div>
</div>

<div class="table-responsive" id="prebookings-list">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th>S.No</th>
                <th>Pre Booking Code</th>
                <th>From</th>
                <th>To</th>
                <th>Sender</th>
                <th>Receiver</th>
                <th>Items</th>
                <th>Expected Handover</th>
                <th>Booked At</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$prebookings key=i item=row}
                <tr>
                    <td>{$i + 1}</td>
                    <td>{$row->code}</td>
                    <td>{$row->fromOrganization->name}<br>{$row->fromStation->name}</td>
                    <td>{$row->toOrganization->name}<br>{$row->toStation->name}</td>
                    <td>{$row->fromCustomer->name}<br>{$row->fromCustomer->mobileNumber}</td>
                    <td>{$row->toCustomer->name}<br>{$row->toCustomer->mobileNumber}</td>
                    <td>{$row->itemDetails|count}</td>
                    <td>{$row->handoverAt|date_format:$ns_date_format}</td>
                    <td>{$row->bookedAt|date_format:$ns_datetime_format}</td>
                    <td align="right" nowrap>
                        <button class="btn btn-success btn-xs" title="Book" onclick="prefillBooking({$row|json_encode|escape});closePrebookingDialog();">Book</button>
                    </td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="100%" align="center">No Records Found!</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
