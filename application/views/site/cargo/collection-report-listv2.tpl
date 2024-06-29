<table class="" width="99%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Collection Report (Transaction Based)</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>

            {$fromDate|date_format:$ns_date_format}  to {$toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">
            {if $smarty.request.filterType == 'DETAILS'}
                {$smarty.request.organizationName}
            {else}
            &nbsp;
            {/if}
        </td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>

</table>
<br/>
<div class="clearfix"></div>
<div class="overflow-x-auto">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th align="left">Branch</th>
                {foreach item=amount from=$paytypesummary key=paytype}
                    <th>{$cargo_payment_status[$paytype]}</th>
                {/foreach}
                <th align="right">Commission</th>
                <th align="right">Payable Amount (P + TPD - C)</th>
            </tr>
            </thead>
            <tbody>
            {assign var=t_transaction_amount value=0}
            {assign var=t_commission_amount value=0}
            {assign var=t_handling_commission_amount value=0}

            {foreach item=row from=$branchwise key=branchcode}
                <tr id="{$branchcode}" class="tr-hover" onclick="toggleBranchRevenue('{$branchcode}');">
                    <td align="left">
                        <a href='javascript:;' title="more details" onclick="getRevenueDetails(event, `{$row['payment_organization_code']}`, `{$row['payment_organization_name']}`, `NA`)">
                            {$row['payment_organization_name']}
                        </a>
                    </td>
                    {assign var="toal_amount" value=0}
                    {foreach item=amount from=$paytypesummary key=paytype}
                        <td align="right">{($row['paytypewise'][$paytype]['transaction_amount'] + 0)|inr_format}</td>
                        {assign var="toal_amount" value=$toal_amount + ($row['paytypewise'][$paytype]['transaction_amount'] + 0)}
                    {/foreach}
                    <td align="right">{$row['commission_amount']|inr_format}</td>
                    <td align="right">{($toal_amount - $row['commission_amount'])|inr_format}</td>
                </tr>

                {assign var=t_transaction_amount value=$t_transaction_amount + $row['transaction_amount']}
                {assign var=t_commission_amount value=$t_commission_amount + $row['commission_amount']}
                {assign var=t_handling_commission_amount value=$t_handling_commission_amount + $row['handling_commission_amount']}
            {/foreach}

            {if $branchwise|count}
                <tr class="active bold">
                    <td colspan="1" align="right">Total</td>
                    {assign var="toal_amount" value=0}
                    {foreach item=amount from=$paytypesummary key=paytype}
                        <td align="right">{($amount + 0)|inr_format}</td>
                        {assign var="toal_amount" value=$toal_amount + ($amount + 0)}
                    {/foreach}
                    <td align='right'>{$t_commission_amount|inr_format}</td>
                    <td align="right">{($toal_amount - $t_commission_amount)|inr_format}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>

<table class="hide noprint">
    {foreach item=branch from=$branchwise key=branchcode}
        <tr class="{$branchcode} hide branchrenvue">
            <td>
            <table class="table table-bordered">
                <thead class="text-center">
                    <tr class="active">
                        <th align="left">User</th>
                        {foreach item=amount from=$paytypesummary key=paytype}
                            <th>{$cargo_payment_status[$paytype]}</th>
                        {/foreach}
                        <th align="right">Commission</th>
                        <th align="right">Payable Amount</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach item=row from=$branch['userwise']}
                        <tr>
                            <td align="left">
                                <a href='javascript:;' title="more details" onclick="getRevenueDetails(event, `{$branchcode}`, `{$row['payment_user_first_name']}`, `{$row['payment_user_code']}`)">
                                    {$row['payment_user_first_name']}
                                </a>
                            </td>
                            {assign var="toal_amount" value=0}
                            {foreach item=amount from=$paytypesummary key=paytype}
                                <td align="right">{($row['paytypewise'][$paytype]['transaction_amount'] + 0)|inr_format}</td>
                                {assign var="toal_amount" value=$toal_amount + ($row['paytypewise'][$paytype]['transaction_amount'] + 0)}
                            {/foreach}
                            <td align="right">{$row['commission_amount']|inr_format}</td>
                            <td align="right">{($toal_amount - $row['commission_amount'])|inr_format}</td>
                        </tr>
                    {foreachelse}
                        <tr>
                            <td colspan="100%" align="center">No Records Found!</td>
                        </tr>
                    {/foreach}            
                </tbody>
            </table>
            </td>
        </tr>
    {/foreach}
</table>

<script>
    {if $branchwise|count}    
    function toggleBranchRevenue(code) {
        if($('.branchrevlist').hasClass(code)) {
            $('.branchrevlist .slide').slideToggle('linear', function() {
                $('.branchrevlist').remove();
            });
            return;
        }
        $('.branchrevlist').remove();
        var $trows = $('.branchrenvue').filter('.' + code);
        $('#'+code).after('<tr class="branchrevlist ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">'
                + $trows.html() + '</table></div></td></tr>');
        $('.branchrevlist .slide').slideToggle('linear');
    }
    {/if}

    function getRevenueDetails(event, orgCode, name, userCode) {
        event && event.preventDefault();
        event && event.stopPropagation();

        if (isNull(orgCode)) {
            return;
        }
        var data = {};
        data.dateRange = $('#collection_rpt_date_range').val();
        data.organizationCode = orgCode;
        data.userCode = userCode;
        data.filterType = "DETAILS";

        $('#dia-rev-details').removeClass('hide');
        $('#dia-rev-details').dialog({
            autoOpen: true,
            height: 650,
            width: 1400,
            modal: true,
            closeOnEscape: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        $('#dia-rev-details-list').html(loading_small);
        $('#dia-rev-details-user').html(name);


        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/collection-report-listv2",
            data: data,
            success: function (res) {
                $('#dia-rev-details-list').html(res);
            }
        })
    }
</script>