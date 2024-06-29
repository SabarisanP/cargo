<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Day Closing Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Date :</span> {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}</td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
    </tr>
</table>
<br/>
<div class="tabbable">
    <ul class="nav nav-tabs hide" id="rpt_tabs">
        <li class="active">
            <a data-toggle="tab" href="#tab_table" title="Table View"><i class="fa fa-lg fa-table"></i></a>
        </li>
    </ul>
    <div class="tab-content" id="rpt_tabs_cont">
        <div id="tab_table" class="tab-pane fade in active">
                    
            <div class="table-responsive" id="adv-bp-grid">
                <table id="dt_ss_report_table" class="table table-bordered no-wrap">
                    <thead>
                        <tr class="success">
                            <td>Branch <i class="fa fa-sort"></i></td>
                            <td>Opening Balance <i class="fa fa-sort"></i></td>
                            <td>Paid Booking <i class="fa fa-sort"></i></td>
                            <td>ToPay Delivery <i class="fa fa-sort"></i></td>
                            <td>Other Income <i class="fa fa-sort"></i></td>
                            <td>Expenses <i class="fa fa-sort"></i></td>
                            <td>Commissions <i class="fa fa-sort"></i></td>
                            <td>Revert Amount <i class="fa fa-sort"></i></td>
                            <td>Settlement Amount <i class="fa fa-sort"></i></td>
                            <td>Day Closing Amount <i class="fa fa-sort"></i></td>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {assign var=total_opening_balance value=0}
                        {assign var=total_paid_amount value=0}
                        {assign var=total_delivery_amount value=0}
                        {assign var=total_other_income value=0} 
                        {assign var=total_expense_amount value=0}
                        {assign var=total_commission_amount value=0}
                        {assign var=total_revert_amount value=0}
                        {assign var=total_settlement_amount value=0}
                        {assign var=total_day_closing_amount value=0}
                        
                        {foreach item=row from=$dayclosing key=t}
                            <tr id="{$t}" class="tr-hover" onclick="toggleDrillDown('{$t}');">
                                <td>{$row['name']}</td>
                                <td align="right">{$row['openingBalance']|inr_format:2}</td>
                                <td align="right">{$row['paid']|inr_format:2}</td>
                                <td align="right">{$row['delivery']|inr_format:2}</td>
                                <td align="right">{$row['other_income']|inr_format:2}</td>
                                <td align="right">{$row['expenseAmount']|inr_format:2}</td>
                                <td align="right">{$row['commissionAmount']|inr_format:2}</td>
                                <td align="right">{$row['revertAmount']|inr_format:2}</td>
                                <td align="right">{$row['settlementAmount']|inr_format:2}</td>
                                <td align="right">{$row['dayClosingAmount']|inr_format:2}</td>
                            </tr>
                            {assign var=total_opening_balance value=$total_opening_balance+$row['openingBalance']}
                            {assign var=total_paid_amount value=$total_paid_amount+$row['paid']}
                            {assign var=total_delivery_amount value=$total_delivery_amount+$row['delivery']}
                            {assign var=total_other_income value=$total_other_income+$row['other_income']}
                            {assign var=total_expense_amount value=$total_expense_amount+$row['expenseAmount']}
                            {assign var=total_commission_amount value=$total_commission_amount+$row['commissionAmount']}
                            {assign var=total_revert_amount value=$total_revert_amount+$row['revertAmount']}
                            {assign var=total_settlement_amount value=$total_settlement_amount+$row['settlementAmount']}
                            {assign var=total_day_closing_amount value=$total_day_closing_amount+$row['dayClosingAmount']}

                        {foreachelse}
                            <tr>
                                <td colspan="10" align="center">No data found</td>
                            </tr>
                        {/foreach}
                    </tbody>

                    <tfoot>
                        <tr class="active">
                            <td align="right">Total</td>
                            <td align="right">{$total_opening_balance|number_format:2}</td>
                            <td align="right">{$total_paid_amount|number_format:2}</td>
                            <td align="right">{$total_delivery_amount|number_format:2}</td>
                            <td align="right">{$total_other_income|number_format:2}</td>
                            <td align="right">{$total_expense_amount|number_format:2}</td>
                            <td align="right">{$total_commission_amount|number_format:2}</td>
                            <td align="right">{$total_revert_amount|number_format:2}</td>
                            <td align="right">{$total_settlement_amount|number_format:2}</td>
                            <td align="right">{$total_day_closing_amount|number_format:2}</td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            
            <table class="hide">
                {foreach item=val from=$dayclosing key=key}
                    <tr class="{$key} hide day-closing-hid-table">
                        <td>
                            <table class="table table-bordered " width="100%">
                                <thead>
                                    <tr class="active">
                                        <td>User</td>
                                        <td>Last Closed Date</td>
                                        <td>Opening Balance</td>
                                        <td>Paid Booking</td>
                                        <td>ToPay Delivery</td>
                                        <td>Other Income</td>
                                        <td>Expenses</td>
                                        <td>Commissions</td>
                                        <td>Revert Amount</td>
                                        <td>Settlement Amount</td>
                                        <td>Day Closing Amount</td>
                                    </tr>
                                </thead>

                                <tbody class="body_table">
                                    {foreach item=row from=$dayclosing[$key]['data'] key=t}
                                        <tr>
                                            <td><a href="javascript:;" onclick="getUserDetailsDialog('{$row->user->code}', '{$key}', '{$smarty.request.stationCodes}');">{$row->user->name}</a></td>
                                            <td>{$row->lastClosedAt|date_format:$ns_datetime_format}</td>
                                            <td align="right">{$row->openingBalance|inr_format:2}</td>
                                            <td align="right">{$row->bookedAmount|inr_format:2}</td>
                                            <td align="right">{$row->deliveryAmount|inr_format:2}</td>
                                            <td align="right">{$row->totalIncomeAmount|inr_format:2}</td>
                                            <td align="right">{$row->totalExpenseAmount|inr_format:2}</td>
                                            <td align="right">{$row->commissionAmount|inr_format:2}</td>
                                            <td align="right">{$row->revertAmount|inr_format:2}</td>
                                            <td align="right">{($row->settlementAmount + $row->openingBalance)|inr_format:2}</td>
                                            <td align="right">{$row->paidAmount|inr_format:2}</td>
                                        </tr>
                                    {foreachelse}
                                        <tr>
                                            <td colspan="11" align="center">No data found</td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </td>
                    </tr>
                {/foreach}
            </table>
        </div>
    </div>
</div>

<script>
    var fromDate = {$fromDate|json_encode};
    var toDate = {$toDate|json_encode};
    
    {if $dayclosing|count > 0}
        $(document).ready(function () {
            $('#dt_ss_report_table').dataTable({
                "sDom": '<"well well-sm"<"row"<"col-md-4 clearfix"l><"col-md-8 clearfix"fT>r>>' +
                        '<"overflow-x-auto"t>' +
                        '<"row"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>',
                pageLength: 50,
            });
            $('#ToolTables_dt_ss_report_table_0').hide();
            $('#ToolTables_dt_ss_report_table_1').hide();
            $('#ToolTables_dt_ss_report_table_2').hide();
            $('#ToolTables_dt_ss_report_table_3').hide();
            $('#ToolTables_dt_ss_report_table_4').hide();
        });    
        
        function toggleDrillDown(code) {
            if($('.saleusrlist').hasClass(code)) {
                $('.saleusrlist .slide').slideToggle('linear', function() {
                    $('.saleusrlist').remove();
                });
                return;
            }
            $('.saleusrlist').remove();
            var $trows = $('.day-closing-hid-table').filter('.' + code);
            $('#'+code).after('<tr class="saleusrlist ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">'
                    + $trows.html() + '</table></div></td></tr>');
            $('.saleusrlist .slide').slideToggle('linear');
        }
    {/if}
</script>
