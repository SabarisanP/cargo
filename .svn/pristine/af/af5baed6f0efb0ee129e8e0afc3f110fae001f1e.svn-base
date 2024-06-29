<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Sales Summary Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Date :</span> {$smarty.request.from_date|date_format:$ns_date_format} to {$smarty.request.to_date|date_format:$ns_date_format}</td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
    </tr>
</table>

<div class="table-responsive" id="adv-bp-grid">
    <table id="dt_ss_report_table" class="table table-bordered no-wrap">
        <thead>
            <tr class="success">
                <td rowspan="2">Group <i class="fa fa-sort"></i></td>
                <td rowspan="2">User <i class="fa fa-sort"></i></td>

                <td colspan="8" align='center'>Booking</td>
                <td colspan="11" align='center'>Cancellation</td>

                <td rowspan="2" align='center'>Payable <i class="fa fa-sort"></i></td>
            </tr>
            <tr class="success">
                <td>Seats <i class="fa fa-sort"></i></td>
                <td>Fare <i class="fa fa-sort"></i></td>
                <td>Discount <i class="fa fa-sort"></i></td>
                <td>GST <i class="fa fa-sort"></i></td>
                <td>Commission <i class="fa fa-sort"></i></td>
                <td>GST on Commi <i class="fa fa-sort"></i></td>
                <td>TDS <i class="fa fa-sort"></i></td>
                <td>Gross <i class="fa fa-sort"></i></td>

                <td>Seats <i class="fa fa-sort"></i></td>
                <td>Fare <i class="fa fa-sort"></i></td>
                <td>Discount <i class="fa fa-sort"></i></td>
                <td>GST <i class="fa fa-sort"></i></td>
                <td>Revoke <i class="fa fa-sort"></i></td>
                <td>Charges <i class="fa fa-sort"></i></td>
                <td>Share / Commi <i class="fa fa-sort"></i></td>
                <td>GST on Share / Commi <i class="fa fa-sort"></i></td>
                <td>TDS <i class="fa fa-sort"></i></td>
                <td>Refund <i class="fa fa-sort"></i></td>
                <td>Revenue <i class="fa fa-sort"></i></td>
            </tr>

        </thead>

        {assign var=b_seat_count value=0}
        {assign var=b_fare value=0}
        {assign var=b_discount value=0}
        {assign var=b_gst value=0}
        {assign var=b_commission value=0}
        {assign var=b_commission_gst value=0}
        {assign var=b_tds value=0}
        {assign var=b_crossamount value=0}

        {assign var=c_seat_count value=0}
        {assign var=c_fare value=0}
        {assign var=c_discount value=0}
        {assign var=c_gst value=0}
        {assign var=c_revoke value=0}
        {assign var=c_cancellation_charges value=0}
        {assign var=c_agent_share value=0}
        {assign var=c_agent_share_gst value=0}
        {assign var=c_tds value=0}
        {assign var=c_refund value=0}
        {assign var=c_revenue value=0}
        {assign var=c_payable value=0}

        <tbody class="body_table">
            {foreach item=row from=$bookings key=t}
                <tr id="{$row['usercode']}" class="tr-hover" onclick="toggleUsersSettlement('{$row['usercode']}');">
                    <td>{$row['group']}</td>
                    <td>{$row['name']}</td>

                    <td align='right'>{$row['booking']['seats'] + 0}</td>
                    <td align='right'>{$row['booking']['fare']|inr_format}</td>
                    <td align='right'>{$row['booking']['discount']|inr_format}</td>
                    <td align='right'>{$row['booking']['gst']|inr_format}</td>
                    <td align='right'>{$row['booking']['commission']|inr_format}</td>
                    <td align='right'>{$row['booking']['commission_gst']|inr_format}</td>
                    <td align='right'>{$row['booking']['tds']|inr_format}</td>
                    <td align='right'>{$row['booking']['crossamount']|inr_format}</td>

                    <td align='right'>{$row['cancel']['seats'] + 0}</td>
                    <td align='right'>{$row['cancel']['fare']|inr_format}</td>
                    <td align='right'>{$row['cancel']['discount']|inr_format}</td>
                    <td align='right'>{$row['cancel']['gst']|inr_format}</td>
                    <td align='right'>{$row['cancel']['revoke']|inr_format}</td>
                    <td align='right'>{$row['cancel']['cancellation_charges']|inr_format}</td>
                    <td align='right'>{$row['cancel']['agent_share']|inr_format}</td>
                    <td align='right'>{$row['cancel']['agent_share_gst']|inr_format}</td>
                    <td align='right'>{$row['cancel']['tds']|inr_format}</td>
                    <td align='right'>{$row['cancel']['refund']|inr_format}</td>
                    <td align='right'>{$row['cancel']['revenue']|inr_format}</td>

                    <td align='right' width="110px" nowrap>
                        {($row['booking']['crossamount']-$row['cancel']['refund'])|inr_format}
                        <i class="fa fa-caret-down fa-fw pull-right" style="margin-top: 2px;"></i>
                    </td>

                    {assign var=b_seat_count value=$b_seat_count+$row['booking']['seats']}
                    {assign var=b_fare value=$b_fare+$row['booking']['fare']}
                    {assign var=b_discount value=$b_discount+$row['booking']['discount']}
                    {assign var=b_gst value=$b_gst+$row['booking']['gst']}
                    {assign var=b_commission value=$b_commission+$row['booking']['commission']}
                    {assign var=b_commission_gst value=$b_commission_gst+$row['booking']['commission_gst']}
                    {assign var=b_tds value=$b_tds+$row['booking']['tds']}
                    {assign var=b_crossamount value=$b_crossamount+$row['booking']['crossamount']}

                    {assign var=c_seat_count value=$c_seat_count+$row['cancel']['seats']}
                    {assign var=c_fare value=$c_fare+$row['cancel']['fare']}
                    {assign var=c_discount value=$c_discount+$row['cancel']['discount']}
                    {assign var=c_gst value=$c_gst+$row['cancel']['gst']}
                    {assign var=c_revoke value=$c_revoke+$row['cancel']['revoke']}
                    {assign var=c_cancellation_charges value=$c_cancellation_charges+$row['cancel']['cancellation_charges']}
                    {assign var=c_agent_share value=$c_agent_share+$row['cancel']['agent_share']}
                    {assign var=c_agent_share_gst value=$c_agent_share_gst+$row['cancel']['agent_share_gst']}
                    {assign var=c_tds value=$c_tds+$row['cancel']['tds']}
                    {assign var=c_refund value=$c_refund+$row['cancel']['refund']}
                    {assign var=c_revenue value=$c_revenue+$row['cancel']['revenue']}
                    {assign var=c_payable value=$c_payable+($row['booking']['crossamount']-$row['cancel']['refund'])}
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="22" align="center">No data found</td>
                </tr>
            {/foreach}
        </tbody>
        {if $bookings|count}
            <tr class="info">
                <td align='right' colspan="2">Total</td>
                <td align='right'>{$b_seat_count}</td>
                <td align='right'>{$b_fare|inr_format}</td>
                <td align='right'>{$b_discount|inr_format}</td>
                <td align='right'>{$b_gst|inr_format}</td>
                <td align='right'>{$b_commission|inr_format}</td>
                <td align='right'>{$b_commission_gst|inr_format}</td>
                <td align='right'>{$b_tds|inr_format}</td>
                <td align='right'>{$b_crossamount|inr_format}</td>

                <td align='right'>{$c_seat_count}</td>
                <td align='right'>{$c_fare|inr_format}</td>
                <td align='right'>{$c_discount|inr_format}</td>
                <td align='right'>{$c_gst|inr_format}</td>
                <td align='right'>{$c_revoke|inr_format}</td>
                <td align='right'>{$c_cancellation_charges|inr_format}</td>
                <td align='right'>{$c_agent_share|inr_format}</td>
                <td align='right'>{$c_agent_share_gst|inr_format}</td>
                <td align='right'>{$c_tds|inr_format}</td>
                <td align='right'>{$c_refund|inr_format}</td>
                <td align='right'>{$c_revenue|inr_format}</td>
                <td align='right'>{$c_payable|inr_format}<i class="fa fa-fw pull-right" aria-hidden="true">&nbsp;</i></td>
            </tr>
        {/if}
    </table>
</div>

<table class="hide">
    {foreach item=users from=$bookings key=t}
        <tr class="{$users['usercode']} hide usersettlement">
            <td>
                <table class="table table-bordered " width="100%">
                    <thead>
                        <tr class="active">
                            <td rowspan="2">Date</td>

                            <td colspan="8" align='center'>Booking</td>
                            <td colspan="11" align='center'>Cancellation</td>

                            <td rowspan="2" align='center'>Payable</td>
                        </tr>
                        <tr class="active">
                            <td>Seats</td>
                            <td>Fare</td>
                            <td>Discount</td>
                            <td>GST</td>
                            <td>Commission</td>
                            <td>GST on Commi</td>
                            <td>TDS</td>
                            <td>Gross</td>

                            <td>Seats</td>
                            <td>Fare</td>
                            <td>Discount</td>
                            <td>GST</td>
                            <td>Revoke</td>
                            <td>Charges</td>
                            <td>Share / Commi</td>
                            <td>GST on Share / Commi</td>
                            <td>TDS</td>
                            <td>Refund</td>
                            <td>Revenue</td>
                        </tr>

                    </thead>

                    <tbody class="body_table">
                        {foreach item=row from=$users['date'] key=t}
                            {assign var="crossamount" value=0}
                            {assign var="refund" value=0}
                            <tr>
                                <td>{$t|date_format:$ns_date_format}</td>

                                <td align='right'>{$row['booking']['seats'] + 0}</td>
                                <td align='right'>{$row['booking']['fare']|inr_format}</td>
                                <td align='right'>{$row['booking']['discount']|inr_format}</td>
                                <td align='right'>{$row['booking']['gst']|inr_format}</td>
                                <td align='right'>{$row['booking']['commission']|inr_format}</td>
                                <td align='right'>{$row['booking']['commission_gst']|inr_format}</td>
                                <td align='right'>{$row['booking']['tds']|inr_format}</td>
                                <td align='right'>{$row['booking']['crossamount']|inr_format}</td>

                                <td align='right'>{$row['cancel']['seats'] + 0}</td>
                                <td align='right'>{$row['cancel']['fare']|inr_format}</td>
                                <td align='right'>{$row['cancel']['discount']|inr_format}</td>
                                <td align='right'>{$row['cancel']['gst']|inr_format}</td>
                                <td align='right'>{$row['cancel']['revoke']|inr_format}</td>
                                <td align='right'>{$row['cancel']['cancellation_charges']|inr_format}</td>
                                <td align='right'>{$row['cancel']['agent_share']|inr_format}</td>
                                <td align='right'>{$row['cancel']['agent_share_gst']|inr_format}</td>
                                <td align='right'>{$row['cancel']['tds']|inr_format}</td>
                                <td align='right'>{$row['cancel']['refund']|inr_format}</td>
                                <td align='right'>{$row['cancel']['revenue']|inr_format}</td>

                                <td align='right'>
                                    {($row['booking']['crossamount']-$row['cancel']['refund'])|inr_format}
                                </td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td colspan="21" align="center">No data found</td>
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
        <button class="btn btn-default" onclick="exportSalesSummaryExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>

<script>
    {if $bookings|count}
    $(document).ready(function () {
        $('#dt_ss_report_table').dataTable({
            "sDom": '<"well well-sm"<"row"<"col-md-4 clearfix"l><"col-md-8 clearfix"fT>r>>' +
                    '<"overflow-x-auto"t>' +
                    '<"row"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>',
            pageLength: 100,
        });
        $('#ToolTables_dt_ss_report_table_0').hide();
        $('#ToolTables_dt_ss_report_table_1').hide();
        $('#ToolTables_dt_ss_report_table_2').hide();
        $('#ToolTables_dt_ss_report_table_3').hide();
    });
    
    
    function toggleUsersSettlement(code) {
        if($('.saleusrlist').hasClass(code)) {
            $('.saleusrlist .slide').slideToggle('linear', function() {
                $('.saleusrlist').remove();
            });
            return;
        }
        $('.saleusrlist').remove();
        var $trows = $('.usersettlement').filter('.' + code);
        $('#'+code).after('<tr class="saleusrlist ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">'
                + $trows.html() + '</table></div></td></tr>');
        $('.saleusrlist .slide').slideToggle('linear');
    }
    {/if}
</script>
