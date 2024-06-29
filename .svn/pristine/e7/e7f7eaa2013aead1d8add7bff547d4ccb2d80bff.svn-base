<table class="" width="100%">
    <tr>
        <td colspan="2" align="center"><span class="bold">{iflang('Cargo Booking Report')}</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format} to
            {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span>
            {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>

{function name="summarytable" arr=[] type='' branch=''}
    <table class="table table-bordered">
        <thead>
            <tr class="success bold">
                <td>Branch</td>
                <td>No of {iflang('lr')}</td>
                <td>No.of Articles</td>
                <td>Freight</td>
                <td>Other Charges</td>
                <td>{$cargo_payment_status['PAD']} Amount</td>
                <td>{$cargo_payment_status['TOP']} Amount</td>
                <td>{$cargo_payment_status['INP']} Amount</td>
                <td>Total Amount</td>
            </tr>
        </thead>
        <tbody>
            {assign var="t_total_lr_count" value=0}
            {assign var="t_total_item_count" value=0}
            {assign var="t_total_amount" value=0}
            {assign var="t_other_charges_amount" value=0}
            {assign var="t_topay_amount" value=0}
            {assign var="t_paid_amount" value=0}
            {assign var="t_topay_amount" value=0}
            {assign var="t_onaccount_amount" value=0}
            {foreach item=row from=$arr}
                <tr>
                    <td align="left"><a href="javascript:;" title="more details" onclick="toggleSummaryDetails('{$type}', '{$row->name|regex_replace:'/[^\w]/':''|lower}', '{$branch|regex_replace:'/[^\w]/':''|lower}')">{$row->name}</a></td>
                    <td align="right">{$row->total_lr_count}</td>
                    <td align="right">{$row->total_item_count}</td>
                    <td align="right">{$row->total_amount|inr_format}</td>
                    <td align="right">{$row->other_charges_amount|inr_format}</td>
                    <td align="right">{$row->paid_amount|inr_format}</td>
                    <td align="right">{$row->topay_amount|inr_format}</td>
                    <td align="right">{$row->onaccount_amount|inr_format}</td>
                    <td align="right">{($row->paid_amount + $row->topay_amount + $row->onaccount_amount)|inr_format}</td>
                </tr>
                {assign var="t_total_lr_count" value=$t_total_lr_count + $row->total_lr_count}
                {assign var="t_total_item_count" value=$t_total_item_count + $row->total_item_count}
                {assign var="t_total_amount" value=$t_total_amount + $row->total_amount}
                {assign var="t_other_charges_amount" value=$t_other_charges_amount + $row->other_charges_amount}
                {assign var="t_paid_amount" value=$t_paid_amount + $row->paid_amount}
                {assign var="t_topay_amount" value=$t_topay_amount + $row->topay_amount}
                {assign var="t_onaccount_amount" value=$t_onaccount_amount + $row->onaccount_amount}
            {foreachelse}
                <tr>
                    <td colspan="9" align="center">No Records Found</td>
                </tr>
            {/foreach}

            {if $summary|count}
                <tr class="active bold">
                    <td align="right">Total</td>
                    <td align="right">{$t_total_lr_count}</td>
                    <td align="right">{$t_total_item_count}</td>
                    <td align="right">{$t_total_amount|inr_format}</td>
                    <td align="right">{$t_other_charges_amount|inr_format}</td>
                    <td align="right">{$t_paid_amount|inr_format}</td>
                    <td align="right">{$t_topay_amount|inr_format}</td>
                    <td align="right">{$t_onaccount_amount|inr_format}</td>
                    <td align="right">{($t_paid_amount + $t_topay_amount + $t_onaccount_amount)|inr_format}</td>
                </tr>
            {/if}
        </tbody>
    </table>
{/function}

<div>
    <h5><b>Branch wise Summary</b></h5>
    {summarytable arr=$summary type='branch'}
</div>

{foreach item=branch from=$summary}
    <div class="branch {$branch->name|regex_replace:'/[^\w]/':''|lower} hide">
        <h5><b>{$branch->name} - Station wise Summary</b></h5>
        {summarytable arr=$branch->stations type='station' branch=$branch->name}
    </div>
{/foreach}

{foreach item=branch from=$summary}
    {foreach item=station from=$branch->stations}
        <div class="station {$branch->name|regex_replace:'/[^\w]/':''|lower} {$station->name|regex_replace:'/[^\w]/':''|lower} hide">
            <h5><b>{$station->name}</b></h5>
            <table class="table table-bordered">
                <thead>
                    <tr class="success bold">
                        <td>S.No</td>
                        <td>{lang('lr')} Number</td>
                        <td>{lang('lr')} Date</td>
                        <td>{lang('booking_sender_term')}</td>
                        <td>{lang('booking_receiver_term')}</td>
                        <td>Payment Type</td>
                        <td>Destination</td>
                        <td>Delivery Date</td>
                        <td>No.of Articles</td>
                        {* <td>Weight</td> *}
                        <td>Freight</td>
                        <td>Other Charges</td>
                        <td>Total Amount</td>
                        {* <td>Goods Value</td>
                        <td>CFT Vol</td> *}
                    </tr>
                </thead>
                <tbody>
                    {assign var=t_total_item_count value=0}
                    {assign var=t_total_amount value=0}
                    {assign var=t_other_charges_computed value=0}
                    {assign var=t_net_amount_computed value=0}
                    {foreach item=row from=$station->bookings key=i}
                        <tr>
                            <td align="left">{$i + 1}</td>
                            <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                            <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                            <td align="left">{$row->from_customer_name}</td>
                            <td align="left">{$row->to_customer_name}</td>
                            <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                            <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                            <td align="left">{($row->delivered_at) ? ($row->delivered_at|date_format:$ns_datetime_format) : '-'}</td>
                            <td align="right">{$row->total_item_count}</td>
                            {* <td align="right">0</td> *}
                            <td align="right">{$row->total_amount|inr_format}</td>
                            <td align="right">{$row->other_charges_computed|inr_format}</td>
                            <td align="right">{($row->net_amount_computed)|inr_format}</td>
                            {* <td align="right">0</td>
                            <td align="right">0</td> *}
                        </tr>
                        {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
                        {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
                        {assign var=t_other_charges_computed value=$t_other_charges_computed + $row->other_charges_amount}
                        {assign var=t_net_amount_computed value=$t_net_amount_computed + $row->net_amount_computed}
                    {foreachelse}
                        <tr>
                            <td colspan="12" align="center">No Records Found</td>
                        </tr>
                    {/foreach}

                    {if $summary|count}
                        <tr class="active bold">
                            <td align="right" colspan="8">Total</td>
                            <td align="right">{$t_total_item_count}</td>
                            {* <td align="right">0</td> *}
                            <td align="right">{$t_total_amount|inr_format}</td>
                            <td align="right">{$t_other_charges_computed|inr_format}</td>
                            <td align="right">{$t_net_amount_computed|inr_format}</td>
                        </tr>
                    {/if}
                </tbody>
            </table>
        </div>
    {/foreach}
{/foreach}

<script>
    function toggleSummaryDetails(type, station, branch) {
        if (type == 'branch') {
            $('.branch').addClass('hide');
        }
        $('.station').addClass('hide');

        var $table = $();
        if (branch) {
            $table = $('.' + type + '.' + station + '.' + branch);
        } else {
            $table = $('.' + type + '.' + station);
        }

        $table.removeClass('hide');
        $("html, body").animate({
            scrollTop: $table.offset().top - 35
        }, 1500);
    }
</script>