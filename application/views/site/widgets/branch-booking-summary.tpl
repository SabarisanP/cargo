<div class="popup_top sticky-row-top">
    <div class="row">
        <div class="col-md-10 ft_14">
            <span class="bold">Branch Booking Summary</span>
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeSummaryReportDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>

<div class="row">
    <div class="col-sm-12 text-center pb10">
        {assign var=today value=strtotime("0 days 00:00")}
        {assign var=reportdate value=strtotime($date)}
        {for $i=-4 to 0}
            {assign var=day value=strtotime("{$i} days 00:00")}
            <span type="button" class="label {if $day == $reportdate}label-success{else}label-default{/if} point_cur" onclick="branchBookingSummary(this, '{$day|date_format:'Y-m-d'}');" title="Click to view details">
                {if $day == $today}Today{else}{$day|date_format:'%a %d-%b'}{/if}
            </span>&nbsp;
        {/for}
    </div>
</div>

<div class="table-responsive" id="godown-summary-cont">
    <table class="table table-bordered" width="98%" id="godown-summary-table">
        <thead>
            <tr class="success">
                <td class="sticky-row-top" align="center" rowspan="3">S.No</td>
                <td class="sticky-row-top" align="center" rowspan="3">Branch Name</td>
                <td class="sticky-row-top" align="center" colspan="4">Booking</td>
                <td class="sticky-row-top" align="center" colspan="4">Delivery</td>
            </tr>
            <tr class="success">
                <td class="sticky-row-top" align="center" colspan="2">Paid Booking</td>
                <td class="sticky-row-top" align="center" colspan="2">ToPay Booking</td>
                
                <td class="sticky-row-top" align="center" colspan="2">Paid Delivery</td>
                <td class="sticky-row-top" align="center" colspan="2">ToPay Delivery</td>
            </tr>
            <tr class="success">
                <td class="sticky-row-top" align="center">Amount</td>
                <td class="sticky-row-top" align="center">LR</td>
                <td class="sticky-row-top" align="center">Amount</td>
                <td class="sticky-row-top" align="center">LR</td>
                
                <td class="sticky-row-top" align="center">Amount</td>
                <td class="sticky-row-top" align="center">LR</td>
                <td class="sticky-row-top" align="center">Amount</td>
                <td class="sticky-row-top" align="center">LR</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var="key" value=1}
            {foreach item=row from=$result}
                <tr>
                    <td>{$key++}</td>
                    <td align="left"><a href="javascript:;" onclick="showBranchReportDialog('{$date}', '{$row['organizationCode']}', '{$row['organizationName']}')">{$row['organizationName']}</a></td>
                    <td align="right">{($row['BOOKING']['PAD']->totalAmount + 0)|sigma:$bo_paid_amount|inr_format}</td>
                    <td align="right">{($row['BOOKING']['PAD']->cargoCount + 0)|sigma:$bo_paid_count}</td>
                    <td align="right">{($row['BOOKING']['TOP']->totalAmount + 0)|sigma:$bo_topay_amount|inr_format}</td>
                    <td align="right">{($row['BOOKING']['TOP']->cargoCount + 0)|sigma:$bo_topay_count}</td>
                    <td align="right">{($row['DELIVERY']['PAD']->totalAmount + 0)|sigma:$dl_paid_amount|inr_format}</td>
                    <td align="right">{($row['DELIVERY']['PAD']->cargoCount + 0)|sigma:$dl_paid_count}</td>
                    <td align="right">{($row['DELIVERY']['TOP']->totalAmount + 0)|sigma:$dl_topay_amount|inr_format}</td>
                    <td align="right">{($row['DELIVERY']['TOP']->cargoCount + 0)|sigma:$dl_topay_count}</td>
                </tr>
                
            {foreachelse}
                <tr>
                    <td colspan="100%" align="center">No Records Found!</td>
                </tr>
            {/foreach}

            {if $result|count}
                <tr class="active">
                    <td colspan="2" align="right"><b>Total</b></td>
                    <td align="right">{$bo_paid_amount|inr_format}</td>
                    <td align="right">{$bo_paid_count}</td>
                    <td align="right">{$bo_topay_amount|inr_format}</td>
                    <td align="right">{$bo_topay_count}</td>
                    <td align="right">{$dl_paid_amount|inr_format}</td>
                    <td align="right">{$dl_paid_count}</td>
                    <td align="right">{$dl_topay_amount|inr_format}</td>
                    <td align="right">{$dl_topay_count}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>

<style>
    #godown-summary-table thead {
        background-color: #fff;
    }
    #godown-summary-table thead tr:nth-child(1) .sticky-row-top {
        top: 25px;
    }
    #godown-summary-table thead tr:nth-child(2) .sticky-row-top {
        top: 54px;
    }
    #godown-summary-table thead tr:nth-child(3) .sticky-row-top {
        top: 82px;
    }
    .popup_top.sticky-row-top {
        padding-top: 1em;
        margin-top: -1em;
        top: -1em;
    }
</style>