<div class="popup_top sticky-row-top">
    <div class="row">
        <div class="col-md-10 ft_14">
            <span class="bold">Vendor Booking Summary</span>
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeSummaryReportDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>

<table class="table table-bordered" width="98%" id="vendor-summary-table">
    <thead>
        <tr class="success">
            <td class="sticky-row-top" align="center">S.No</td>
            <td class="sticky-row-top" align="center">Vendor</td>
            <td class="sticky-row-top" align="center">Vendor Company</td>
            <td class="sticky-row-top" align="center">Cargo Count</td>
            <td class="sticky-row-top" align="center">Total Amount</td>
            <td class="sticky-row-top" align="center">Other Charges</td>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach item=row from=$result key=key}
            <tr>
                <td>{$key + 1}</td>
                <td align="left"><a href="javascript:;" onclick="showVendorReportDialog('{$row->vendor_code}', '{$row->vendor_name}')">{$row->vendor_name}</a></td>
                <td align="left">{$row->vendor_company}</td>
                <td align="right">{$row->cargo_count|sigma:$cargo_count}</td>
                <td align="right">{$row->total_amount|sigma:$total_amount|inr_format}</td>
                <td align="right">{$row->other_charges_amonut|sigma:$other_charges_amonut|inr_format}</td>
            </tr>
            
        {foreachelse}
            <tr>
                <td colspan="100%" align="center">No Records Found!</td>
            </tr>
        {/foreach}

        {if $result|count}
            <tr class="active">
                <td colspan="3" align="right"><b>Total</b></td>
                <td align="right">{$cargo_count}</td>
                <td align="right">{$total_amount|inr_format}</td>
                <td align="right">{$other_charges_amonut|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>

<style>
    #vendor-summary-table .sticky-row-top {
        top: 25px;
    }
    .popup_top.sticky-row-top {
        padding-top: 1em;
        margin-top: -1em;
        top: -1em;
    }
</style>