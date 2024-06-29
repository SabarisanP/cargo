<div class="popup_top sticky-row-top">
    <div class="row">
        <div class="col-md-10 ft_14">
            <span class="bold">Godown Booking Summary</span>
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeSummaryReportDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>

<table class="table table-bordered" width="98%" id="godown-summary-table">
    <thead>
        <tr class="success">
            <td class="sticky-row-top" align="center">S.No</td>
            <td class="sticky-row-top" align="center">Godown</td>
            <td class="sticky-row-top" align="center">LR Count</td>
            <td class="sticky-row-top" align="center">Amount</td>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach item=row from=$result key=key}
            {assign var="attrtype" value=explode(':', $row->attribute_type)}
            <tr>
                <td>{$key + 1}</td>
                <td align="left"><a href="javascript:;" onclick="showDashReportDialog('TO_DELIVERY_COUNT', '{$attrtype[2]}', '{$attrtype[1]}')">{$attrtype[1]}</a></td>
                <td align="right">{$row->attribute_count|sigma:$cargo_count}</td>
                <td align="right">{$row->attribute_value|sigma:$tot_amount|inr_format}</td>
            </tr>
            
        {foreachelse}
            <tr>
                <td colspan="100%" align="center">No Records Found!</td>
            </tr>
        {/foreach}

        {if $result|count}
            <tr class="active">
                <td colspan="2" align="right"><b>Total</b></td>
                <td align="right">{$cargo_count}</td>
                <td align="right">{$tot_amount|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>

<style>
    #godown-summary-table .sticky-row-top {
        top: 25px;
    }
    .popup_top.sticky-row-top {
        padding-top: 1em;
        margin-top: -1em;
        top: -1em;
    }
</style>