<div class="popup_top">
    <div class="row">
        <div class="col-md-10 bold ft_14">
            {* Da Report Detail View *}
        </div>
        <div class="col-md-2">            
            <a class="align-right" onclick="closeUserDetailsDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>
<br>
<div class="tabbable">
    <ul class="nav nav-tabs hide" id="rpt_tabs">
        <li class="active">
            <a data-toggle="tab" href="#tab_table" title="Table View"><i class="fa fa-lg fa-table"></i></a>
        </li>
    </ul>
    <div class="tab-content" id="rpt_tabs_cont">
        <div id="tab_table" class="tab-pane fade in active">
                    
            <div class="table-responsive" id="adv-bp-grid">
                <table id="day_closing_report_table" class="table table-bordered no-wrap">
                    <thead>
                        <tr class="success">
                            <td>Created At <i class="fa fa-sort"></i></td>
                            <td>Transaction Code <i class="fa fa-sort"></i></td>
                            <td>Transaction Date <i class="fa fa-sort"></i></td>
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
                        {assign var=tot_opening_balance value=0}
                        {assign var=tot_paid_booking value=0}
                        {assign var=tot_topay_delivery value=0}
                        {assign var=tot_other_income value=0}
                        {assign var=tot_expenses value=0}
                        {assign var=tot_commission value=0}
                        {assign var=tot_revert_amount value=0}
                        {assign var=tot_settlement_amount value=0}
                        {assign var=tot_day_closing_amount value=0}
                        {foreach item=row from=$completed}
                            <tr id="{$row->code}" class="tr-hover" onclick="toggleUserDrillDown('{$row->code}');">                        
                                <td>{$row->createdAt|date_format:$ns_datetime_format}</td>
                                <td>{$row->code}</td>
                                <td>{$row->transactionAt|date_format:$ns_datetime_format|default:'-'}</td>
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
            
                            {assign var=tot_opening_balance value=$tot_opening_balance+$row->openingBalance}
                            {assign var=tot_paid_booking value=$tot_paid_booking+$row->bookedAmount}
                            {assign var=tot_topay_delivery value=$tot_topay_delivery+$row->deliveryAmount}
                            {assign var=tot_other_income value=$tot_other_income+$row->totalIncomeAmount}
                            {assign var=tot_expenses value=$tot_expenses+$row->totalExpenseAmount}
                            {assign var=tot_commission value=$tot_commission+$row->commissionAmount}
                            {assign var=tot_revert_amount value=$tot_revert_amount+$row->revertAmount}
                            {assign var=tot_settlement_amount value=$tot_settlement_amount+($row->settlementAmount + $row->openingBalance)}
                            {assign var=tot_day_closing_amount value=$tot_day_closing_amount+$row->paidAmount}
                        {foreachelse}
                            <tr>
                                <td colspan="12" align="center">No data found</td>
                            </tr>
                        {/foreach}
                    </tbody>

                    <tfoot>
                        <tr class="active">
                            <td align="right" colspan="3">Total</td>
                            <td align="right">{$tot_opening_balance|number_format:2}</td>
                            <td align="right">{$tot_paid_booking|number_format:2}</td>
                            <td align="right">{$tot_topay_delivery|number_format:2}</td>
                            <td align="right">{$tot_other_income|number_format:2}</td>
                            <td align="right">{$tot_expenses|number_format:2}</td>
                            <td align="right">{$tot_commission|number_format:2}</td>
                            <td align="right">{$tot_revert_amount|number_format:2}</td>
                            <td align="right">{$tot_settlement_amount|number_format:2}</td>
                            <td align="right">{$tot_day_closing_amount|number_format:2}</td>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <h5>Pending</h5>
            <table class="table table-bordered no-wrap">
                <thead>
                    <tr class="success">
                        <td>Opening Balance <i class="fa fa-sort"></i></td>
                        <td>Paid Booking <i class="fa fa-sort"></i></td>
                        <td>ToPay Delivery <i class="fa fa-sort"></i></td>
                        <td>Other Income <i class="fa fa-sort"></i></td>
                        <td>Expenses <i class="fa fa-sort"></i></td>
                        <td>Commissions <i class="fa fa-sort"></i></td>
                        <td>Revert Amount <i class="fa fa-sort"></i></td>
                        <td>Settlement Amount <i class="fa fa-sort"></i></td>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$pending}
                        <tr>
                            <td align="right">{$row->openingBalance|inr_format:2}</td>
                            <td align="right">{$row->bookedAmount|inr_format:2}</td>
                            <td align="right">{$row->deliveryAmount|inr_format:2}</td>
                            <td align="right">{$row->totalIncomeAmount|inr_format:2}</td>
                            <td align="right">{$row->totalExpenseAmount|inr_format:2}</td>
                            <td align="right">{$row->commissionAmount|inr_format:2}</td>
                            <td align="right">{$row->revertAmount|inr_format:2}</td>
                            <td align="right">{($row->settlementAmount + $row->openingBalance)|inr_format:2}</td>
                        </tr>
                    {foreachelse}
                        <tr>
                            <td colspan="8" align="center">No data found</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
            
            <table class="hide">
                {foreach item=val from=$completed key=key}
                    <tr class="{$val->code} hide day-closing-user-hid-table">
                        <td>
                            <table class="table table-bordered " width="100%">
                                <thead>
                                    <tr class="active">
                                        <td>Transaction Code</td>
                                        <td>User</td>
                                        <td>Date</td>
                                        <td>Transaction Mode</td>
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
                                    {foreach item=row from=$val->organizationReceiptDetails key=t}
                                        <tr>
                                            <td align="right">{$row->code}</td>
                                            <td>{$row->fromUser->name} - {$row->toUser->name}</td>
                                            <td align="right">{$row->fromDateTime|date_format:$ns_datetime_format} - {$row->toDateTime|date_format:$ns_datetime_format}</td>
                                            <td align="right">{$row->paymentMode->name}</td>
                                            <td align="right">{$row->openingBalanceAmount|inr_format:2}</td>
                                            <td align="right">{$row->bookedAmount|inr_format:2}</td>
                                            <td align="right">{$row->deliveryAmount|inr_format:2}</td>
                                            <td align="right">{$row->incomeAmount|inr_format:2}</td>
                                            <td align="right">{$row->expenseAmount|inr_format:2}</td>
                                            <td align="right">{$row->commissionAmount|inr_format:2}</td>
                                            <td align="right">{$row->revertAmount|inr_format:2}</td>
                                            <td align="right">{($row->settlementAmount + $row->openingBalanceAmount)|inr_format:2}</td>
                                            <td align="right">{$row->paidAmount|inr_format:2}</td>
                                        </tr>
                                    {foreachelse}
                                        <tr>
                                            <td colspan="13" align="center">No data found</td>
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
    
    {if $completed|count > 0}
        $(document).ready(function () {
            $('#day_closing_report_table').dataTable({
                "sDom": '<"overflow-x-auto"t>' +
                        '<"row"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>',
                pageLength: 50,
                searching: false, 
                paging: false, 
                info: false
            });
        });  

        function toggleUserDrillDown(code) {
            if($('.saleusrlist').hasClass(code)) {
                $('.saleusrlist .slide').slideToggle('linear', function() {
                    $('.saleusrlist').remove();
                });
                return;
            }
            $('.saleusrlist').remove();
            var $trows = $('.day-closing-user-hid-table').filter('.' + code);
            $('#'+code).after('<tr class="saleusrlist ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">'
                    + $trows.html() + '</table></div></td></tr>');
            $('.saleusrlist .slide').slideToggle('linear');
        }
    {/if}
</script>
