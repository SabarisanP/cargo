<table width="100%">
    <tr>
        <td colspan="10" align="center" class="bold">Voucher Due Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Date :</span> {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format}</td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
    </tr>
</table>

<div class="table-responsive" id="adv-bp-grid">
    <table id="dt_ss_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <td rowspan="2">Group <i class="fa fa-sort"></i></td>
                <td rowspan="2">User <i class="fa fa-sort"></i></td>

                <td colspan="6" align='center'>Booking</td>
                <td colspan="9" align='center'>Cancellation</td>

                <td rowspan="2">Payable <i class="fa fa-sort"></i></td>
            </tr>
            <tr class="success">
                <td>Seats <i class="fa fa-sort"></i></td>
                <td>Fare <i class="fa fa-sort"></i></td>
                <td>Discount <i class="fa fa-sort"></i></td>
                <td>GST <i class="fa fa-sort"></i></td>
                <td>Commission <i class="fa fa-sort"></i></td>
                <td>Gross <i class="fa fa-sort"></i></td>

                <td>Seats <i class="fa fa-sort"></i></td>
                <td>Fare <i class="fa fa-sort"></i></td>
                <td>Discount <i class="fa fa-sort"></i></td>
                <td>GST <i class="fa fa-sort"></i></td>
                <td>Revoke <i class="fa fa-sort"></i></td>
                <td>Charges <i class="fa fa-sort"></i></td>
                <td>Agent Share <i class="fa fa-sort"></i></td>
                <td>Refund <i class="fa fa-sort"></i></td>
                <td>Revenue <i class="fa fa-sort"></i></td>
            </tr>
        </thead>

        {assign var=b_seat_count value=0}
        {assign var=b_fare value=0}
        {assign var=b_discount value=0}
        {assign var=b_gst value=0}
        {assign var=b_commission value=0}
        {assign var=b_crossamount value=0}

        {assign var=c_seat_count value=0}
        {assign var=c_fare value=0}
        {assign var=c_discount value=0}
        {assign var=c_gst value=0}
        {assign var=c_revoke value=0}
        {assign var=c_cancellation_charges value=0}
        {assign var=c_agent_share value=0}
        {assign var=c_refund value=0}
        {assign var=c_revenue value=0}
        {assign var=c_payable value=0}

        <tbody class="body_table">
            {foreach item=row from=$bookings key=t}
                <tr>
                    <td>{$row['group']}</td>
                    <td><a href="javascript:;" onclick="getUserVoucherDueList('{$row['usercode']}');">{$row['name']}</a></td>

                    <td align='right'>{$row['booking']['seats']+0}</td>
                    <td align='right'>{$row['booking']['fare']|inr_format}</td>
                    <td align='right'>{$row['booking']['discount']|inr_format}</td>
                    <td align='right'>{$row['booking']['gst']|inr_format}</td>
                    <td align='right'>{$row['booking']['commission']|inr_format}</td>
                    <td align='right'>{$row['booking']['crossamount']|inr_format}</td>

                    <td align='right'>{$row['cancel']['seats']+0}</td>
                    <td align='right'>{$row['cancel']['fare']|inr_format}</td>
                    <td align='right'>{$row['cancel']['discount']|inr_format}</td>
                    <td align='right'>{$row['cancel']['gst']|inr_format}</td>
                    <td align='right'>{$row['cancel']['revoke']|inr_format}</td>
                    <td align='right'>{$row['cancel']['cancellation_charges']|inr_format}</td>
                    <td align='right'>{$row['cancel']['agent_share']|inr_format}</td>
                    <td align='right'>{$row['cancel']['refund']|inr_format}</td>
                    <td align='right'>{$row['cancel']['revenue']|inr_format}</td>

                    {assign var="cancels" value=$row['cancel']['fare']-$row['cancel']['discount']+$row['cancel']['gst']-$row['cancel']['revoke']}
                    <td align='right'>{($row['booking']['crossamount']-$cancels+$row['cancel']['revenue'])|inr_format}</td>

                    {assign var=b_seat_count value=$b_seat_count+$row['booking']['seats']}
                    {assign var=b_fare value=$b_fare+$row['booking']['fare']}
                    {assign var=b_discount value=$b_discount+$row['booking']['discount']}
                    {assign var=b_gst value=$b_gst+$row['booking']['gst']}
                    {assign var=b_commission value=$b_commission+$row['booking']['commission']}
                    {assign var=b_crossamount value=$b_crossamount+$row['booking']['crossamount']}

                    {assign var=c_seat_count value=$c_seat_count+$row['cancel']['seats']}
                    {assign var=c_fare value=$c_fare+$row['cancel']['fare']}
                    {assign var=c_discount value=$c_discount+$row['cancel']['discount']}
                    {assign var=c_gst value=$c_gst+$row['cancel']['gst']}
                    {assign var=c_revoke value=$c_revoke+$row['cancel']['revoke']}
                    {assign var=c_cancellation_charges value=$c_cancellation_charges+$row['cancel']['cancellation_charges']}
                    {assign var=c_agent_share value=$c_agent_share+$row['cancel']['agent_share']}
                    {assign var=c_refund value=$c_refund+$row['cancel']['refund']}
                    {assign var=c_revenue value=$c_revenue+$row['cancel']['revenue']}
                    {assign var=c_payable value=$c_payable+($row['booking']['crossamount']-$cancels+$row['cancel']['revenue'])}
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="18" align="center">No data found</td>
                </tr>
            {/foreach}
        </tbody>
        <tr class="info">
            <td align='right' colspan="2">Total</td>
            <td align='right'>{$b_seat_count}</td>
            <td align='right'>{$b_fare|inr_format}</td>
            <td align='right'>{$b_discount|inr_format}</td>
            <td align='right'>{$b_gst|inr_format}</td>
            <td align='right'>{$b_commission|inr_format}</td>
            <td align='right'>{$b_crossamount|inr_format}</td>

            <td align='right'>{$c_seat_count}</td>
            <td align='right'>{$c_fare|inr_format}</td>
            <td align='right'>{$c_discount|inr_format}</td>
            <td align='right'>{$c_gst|inr_format}</td>
            <td align='right'>{$c_revoke|inr_format}</td>
            <td align='right'>{$c_cancellation_charges|inr_format}</td>
            <td align='right'>{$c_agent_share|inr_format}</td>
            <td align='right'>{$c_refund|inr_format}</td>
            <td align='right'>{$c_revenue|inr_format}</td>
            <td align='right'>{$c_payable|inr_format}</td>
        </tr>
    </table>
</div>
<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportSalesSummaryExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>

<script>
    {if $bookings|count}
    $(document).ready(function () {
        $('#dt_ss_report_table').dataTable({
            "sDom": '<"well well-sm"<"row"<"col-md-4 clearfix"l><"col-md-8 clearfix"f>r>>' +
                    't' +
                    '<"row"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>',
            pageLength: 100
        });
    });
    {/if}


    function getUserVoucherDueList(usercode) {
        var data = {};
        data.fromDate = '{$smarty.request.fromDate}';
        data.toDate = '{$smarty.request.toDate}';
        data.travelDateFlag = {$smarty.request.travelDateFlag};
        data.userCode = usercode;

        $('#user-voucher-cont').html(loading_popup);
        $('#user-voucher-dialog').css('background', '#fff');
        $('#user-voucher-dialog').removeClass('hide');
        $('#user-voucher-dialog').dialog({
            autoOpen: true,
            height: 600,
            width: $(window).width() - 100,
            modal: true,
            resizable: false
        });
        $('.ui-dialog-titlebar').hide();

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'report/user-voucher-due-report-list',
            data: data,
            success: function (response) {
                $('#user-voucher-cont').html(response);
            }
        });
    }

    function closeUserVoucherDialog() {
        $('#user-voucher-dialog').hide();
        $('#user-voucher-dialog').dialog('destroy');
    }
</script>