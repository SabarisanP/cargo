<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Branch Collections Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Date :</span> {$smarty.request.from_date|date_format:$ns_date_format} to {$smarty.request.to_date|date_format:$ns_date_format}</td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
    </tr>
</table>

<div class="table-responsive" id="adv-bp-grid">
    <table id="dt_ss_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <td rowspan="2">Branch <i class="fa fa-sort"></i></td>

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
            <tr id="{$row['orgcode']}" class="tr-hover" onclick="toggleBrachUsers('{$row['orgcode']}');">
                <td>{$row['name']}</td>

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
                <td align='right'>
                    {($row['booking']['crossamount']-$cancels+$row['cancel']['revenue'])|inr_format}
                    <i class="fa fa-caret-down fa-fw pull-right" aria-hidden="true"></i>
                </td>

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
                <td colspan="17" align="center">No data found</td>
            </tr>
        {/foreach}
        </tbody>
        <tr class="info">
            <td align='right'>Total</td>
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

<table class="hide">
    {foreach item=row from=$bookings key=t}
        <tr class="{$row['orgcode']} hide branchusers">
            <td>
                <table id="dt_ss_report_table" class="table table-bordered " width="100%">
                    <thead>
                        <tr class="active">
                            <td rowspan="2">Group</td>
                            <td rowspan="2">User</td>

                            <td colspan="6" align='center'>Booking</td>
                            <td colspan="9" align='center'>Cancellation</td>

                            <td rowspan="2">Payable</td>
                        </tr>
                        <tr class="active">
                            <td>Seats</td>
                            <td>Fare</td>
                            <td>Discount</td>
                            <td>GST</td>
                            <td>Commission</td>
                            <td>Gross</td>

                            <td>Seats</td>
                            <td>Fare</td>
                            <td>Discount</td>
                            <td>GST</td>
                            <td>Revoke</td>
                            <td>Charges</td>
                            <td>Agent Share</td>
                            <td>Refund</td>
                            <td>Revenue</td>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach item=usr from=$row['users'] key=user_name}
                            <tr>
                                <td>{$usr['group']}</td>
                                <td><a href="javascript:;" onclick="getUserTransaction('{$usr['code']}');">{$usr['name']}</a></td>

                                <td align='right'>{$usr['booking']['seats']+0}</td>
                                <td align='right'>{$usr['booking']['fare']|inr_format}</td>
                                <td align='right'>{$usr['booking']['discount']|inr_format}</td>
                                <td align='right'>{$usr['booking']['gst']|inr_format}</td>
                                <td align='right'>{$usr['booking']['commission']|inr_format}</td>
                                <td align='right'>{$usr['booking']['crossamount']|inr_format}</td>

                                <td align='right'>{$usr['cancel']['seats']+0}</td>
                                <td align='right'>{$usr['cancel']['fare']|inr_format}</td>
                                <td align='right'>{$usr['cancel']['discount']|inr_format}</td>
                                <td align='right'>{$usr['cancel']['gst']|inr_format}</td>
                                <td align='right'>{$usr['cancel']['revoke']|inr_format}</td>
                                <td align='right'>{$usr['cancel']['cancellation_charges']|inr_format}</td>
                                <td align='right'>{$usr['cancel']['agent_share']|inr_format}</td>
                                <td align='right'>{$usr['cancel']['refund']|inr_format}</td>
                                <td align='right'>{$usr['cancel']['revenue']|inr_format}</td>

                                {assign var="usrcancels" value=$usr['cancel']['fare']-$usr['cancel']['discount']+$usr['cancel']['gst']-$usr['cancel']['revoke']}
                                <td align='right'>{($usr['booking']['crossamount']-$usrcancels+$usr['cancel']['revenue'])|inr_format}</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </td>
        </tr>
    {/foreach}
</table>

<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportBranchCollectionsExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>

<div id="user-transaction-dialog" class="dialog-content-page" style="display: none">
    <a href="javascript:;" class="pull-right close-btn" onclick="closeUserTransaction();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div id="user-transaction-cont"></div>
</div>


<div style="display: none">
    <form id="branch_summ_pdf" method="post" name="branch_summ_pdf">
        <input type="hidden" name="export" id="export" value="1">
        <input type="hidden" name="date_option" value="{$smarty.request.date_option}">
        <input type="hidden" name="from" value="{$smarty.request.from_date}">
        <input type="hidden" name="to" value="{$smarty.request.to_date}">
        <input type="hidden" name="schedule_code" value="NA">
        <input type="hidden" name="from_code" value="NA">
        <input type="hidden" name="to_code" value="NA">
        <input type="hidden" name="group_code" value="NA">
        <input type="hidden" name="user_code" value="">
    </form>
    <iframe id="irm_downloader" name="irm_downloader" style="display: none"></iframe>
</div>

<script>
    {if $bookings|count}
    $(document).ready(function() {
        $('#dt_ss_report_table').dataTable({
            "sDom": '<"well well-sm"<"row"<"col-md-4 clearfix"l><"col-md-8 clearfix"fT>r>>' +
                    't' +
                    '<"row"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>',
            pageLength : 100,
            columnDefs: [{
                targets: -1,
                bSearchable: false
            }]
        });
        $('#ToolTables_dt_ss_report_table_0').hide();
        $('#ToolTables_dt_ss_report_table_1').hide();
        $('#ToolTables_dt_ss_report_table_2').hide();
        $('#ToolTables_dt_ss_report_table_3').hide();
    });
    {/if}

    function toggleBrachUsers(code) {
        if($('.brusrlist').hasClass(code)) {
            $('.brusrlist .slide').slideToggle('linear', function() {
                $('.brusrlist').remove();
            });
            return;
        }
        $('.brusrlist').remove();
        var $trows = $('.branchusers').filter('.' + code);
        $('#'+code).after('<tr class="brusrlist ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">'
                + $trows.html() + '</table></div></td></tr>');
        $('.brusrlist .slide').slideToggle('linear');
    }
    
    function getUserTransaction(usrcode) {
        $('#cons-booking-list').html('');
        var data = {};
        data.date_option = {$smarty.request.date_option};
        data.from = '{$smarty.request.from_date}';
        data.to = '{$smarty.request.to_date}';
        data.tagCode = 'NA';
        data.schedule_code = 'NA';
        data.from_code = 'NA';
        data.to_code = 'NA';
        data.group_code = 'NA';
        data.user_code = usrcode;

        $('#user-transaction-cont').html(loading_popup);
        $('#user-transaction-dialog').css('background','#fff');
        $('#user-transaction-dialog').removeClass('hide');
        $('#user-transaction-dialog').dialog({
            autoOpen: true,
            height: 600,
            width:  $(window).width() - 50,
            modal: true,
            resizable: false
        });
        $('.ui-dialog-titlebar').hide();
        
        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'report/branch-collections-summary',
            data: data,
            success: function (response) {
                $('#user-transaction-cont').html(response);
                $('#user-transaction-cont #action-btns').remove();
            }
        });
    }
    
    function closeUserTransaction() {
        $('#user-transaction-dialog').hide();
        $('#user-transaction-dialog').dialog('destroy');
    }
    
    function exportBranchCollectionsPdf(usrcode) {
        document.branch_summ_pdf.user_code.value = usrcode; 
        document.branch_summ_pdf.action = "report/branch-collections-summary";
        document.branch_summ_pdf.target = "irm_downloader";
        document.branch_summ_pdf.submit();
        return;
    }
</script>
