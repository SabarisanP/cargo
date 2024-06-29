<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Branch Consolidation Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Date :</span> {$from_date|date_format:$ns_datetime_format} to {$to_date|date_format:$ns_datetime_format}</td>
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
                    
            <div class="table-responsive" id="adv-bp-grid" {if count($DC_data)<=0}style="overflow-x: auto;"{/if}>
                <table id="dt_ss_report_table" class="table table-bordered no-wrap">
                    <thead>
                        <tr class="success">
                            <td rowspan="4">S No <i class="fa fa-sort"></i></td>
                            <td rowspan="4">Branch <i class="fa fa-sort"></i></td>

                            <td colspan="8" align='center'>Booking</td>
                            <td colspan="8" align='center'>Delivery</td>

                            <td rowspan="3">Collection Freight</td>
                            <td rowspan="3">Collection Charges</td>
                            {* <td rowspan="3">Collection GST</td> *}
                            <td rowspan="3">Service Fee</td>
                            <td rowspan="3">TDS</td>
                            <td rowspan="3">Charges Share</td>
                            <td rowspan="3">Net Payable</td>
                        </tr>
                        <tr class="success">
                            <td align="center" colspan="2">Paid</td>
                            <td align="center" colspan="2">Topay</td>
                            <td align="center" colspan="2">On Account</td>
                            <td rowspan="2">Service Fee</td>
                            <td rowspan="2">Charges Share</td>

                            <td align="center" colspan="2">Paid</td>
                            <td align="center" colspan="2">Topay</td>
                            <td align="center" colspan="2">On Account</td>
                            <td rowspan="2">Service Fee</td>
                            <td rowspan="2">Charges Share</td>
                        </tr>
                        <tr class="success">
                            {* booking *}
                            <td>Freight Amount</td>
                            <td>Other Charges</td>
                            <td>Freight Amount</td>
                            <td>Other Charges</td>
                            <td>Freight Amount</td>
                            <td>Other Charges</td>
                            

                            {* delivery *}
                            <td>Freight Amount</td>
                            <td>Other Charges</td>
                            <td>Freight Amount</td>
                            <td>Other Charges</td>
                            <td>Freight Amount</td>
                            <td>Other Charges</td>
                            
                        </tr>
                        <tr class="success">
                            <td align="center">B1 <i class="fa fa-sort"></i></td>
                            <td align="center">B2 <i class="fa fa-sort"></i></td>
                            <td align="center">B3 <i class="fa fa-sort"></i></td>
                            <td align="center">B4 <i class="fa fa-sort"></i></td>
                            <td align="center">B5 <i class="fa fa-sort"></i></td>
                            <td align="center">B6 <i class="fa fa-sort"></i></td>
                            <td align="center">B7 <i class="fa fa-sort"></i></td>
                            <td align="center">B8 <i class="fa fa-sort"></i></td>

                            <td align="center">D1 <i class="fa fa-sort"></i></td>
                            <td align="center">D2 <i class="fa fa-sort"></i></td>
                            <td align="center">D3 <i class="fa fa-sort"></i></td>
                            <td align="center">D4 <i class="fa fa-sort"></i></td>
                            <td align="center">D5 <i class="fa fa-sort"></i></td>
                            <td align="center">D6 <i class="fa fa-sort"></i></td>
                            <td align="center">D7 <i class="fa fa-sort"></i></td>
                            <td align="center">D8 <i class="fa fa-sort"></i></td>

                            <td align="center">T1 (B1+D3) <i class="fa fa-sort"></i></td>
                            <td align="center">T2 (B2+D4) <i class="fa fa-sort"></i></td>
                            {* <td align="center">T3 <i class="fa fa-sort"></i></td> *}
                            <td align="center">T3 (B7+D7) <i class="fa fa-sort"></i></td>
                            <td align="center">T4 <i class="fa fa-sort"></i></td>
                            <td align="center">T5 (B8+D8) <i class="fa fa-sort"></i></td>
                            <td align="center">(T1+T2) - (T3-T4+T5) <i class="fa fa-sort"></i></td>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {$key = 1}
                        {foreach item=row from=$DC_data key=t}
                            <tr id="{$t}" class="tr-hover" onclick="toggleBRNCONHidRow('{$t}');">
                                <td>{$key}</td>
                                <td>{$row['org_name']|ucwords}</td>

                                <td align='right'>{$row['paid_book']|inr_format}</td>
                                <td align='right'>{$row['paid_book_other']|inr_format}</td>
                                
                                <td align='right'>{$row['topay_book']|inr_format}</td>
                                <td align='right'>{$row['topay_book_other']|inr_format}</td>
                                
                                <td align='right'>{$row['onacc_book']|inr_format}</td>
                                <td align='right'>{$row['onacc_book_other']|inr_format}</td>
                                
                                <td align="right">{$row['book_commission']|inr_format}</td>
                                <td align="right">{$row['book_charges_share']|inr_format}</td>

                                <td align='right'>{$row['paid_del']|inr_format}</td>
                                <td align='right'>{$row['paid_del_other']|inr_format}</td>
                                
                                <td align='right'>{$row['topay_del']|inr_format}</td>
                                <td align='right'>{$row['topay_del_other']|inr_format}</td>
                                
                                <td align='right'>{$row['onacc_del']|inr_format}</td>
                                <td align='right'>{$row['onacc_del_other']|inr_format}</td>
                                
                                <td align="right">{$row['del_commission']|inr_format}</td>
                                <td align="right">{$row['del_charges_share']|inr_format}</td>

                                <td align='right'>{($row['paid_book']+$row['topay_del'])|inr_format}</td>
                                <td align='right'>{($row['paid_book_other']+$row['topay_del_other'])|inr_format}</td>
                                {* <td align='right'>{($row['paid_book_gst']+$row['topay_del_gst'])|inr_format}</td> *}
                                <td align='right'>{($row['book_commission']+$row['del_commission'])|inr_format}</td>
                                <td align='right'>{($row['paid_book_tds']+$row['topay_book_tds']+$row['onacc_book_tds']+$row['paid_del_tds']+$row['topay_del_tds']+$row['onacc_del_tds'])|inr_format}</td>
                                <td align='right'>{($row['book_charges_share']+$row['del_charges_share'])|inr_format}</td>
                                <td align='right'>{((($row['paid_book']+$row['topay_del'])+($row['paid_book_other']+$row['topay_del_other']))-(($row['book_commission']+$row['del_commission'])-($row['paid_book_tds']+$row['topay_book_tds']+$row['onacc_book_tds']+$row['paid_del_tds']+$row['topay_del_tds']+$row['onacc_del_tds'])+($row['book_charges_share']+$row['del_charges_share'])))|inr_format}</td>
                            </tr>
                            {$key = $key+1}
                        {foreachelse}
                            <tr>
                                <td colspan="34" align="center">No data found</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>

            <table class="hide">
                {foreach item=day_clo from=$DC_data key=key}
                    <tr class="{$key} hide brn-con-hid-table">
                        <td>
                            <table class="table table-bordered " width="100%">
                                <thead>
                                    <tr class="active">
                                        <td rowspan="4">S No</td>
                                        <td rowspan="4">LR</td>

                                        <td colspan="8" align='center'>Booking</td>
                                        <td colspan="8" align='center'>Delivery</td>

                                        <td rowspan="3">Collection Freight</td>
                                        <td rowspan="3">Collection Charges</td>
                                        {* <td rowspan="3">Collection GST</td> *}
                                        <td rowspan="3">Service Fee</td>
                                        <td rowspan="3">TDS</td>
                                        <td rowspan="3">Charges Share</td>
                                        <td rowspan="3">Net Payable</td>
                                    </tr>
                                    <tr class="active">
                                        <td align="center" colspan="2">Paid</td>
                                        <td align="center" colspan="2">Topay</td>
                                        <td align="center" colspan="2">On Account</td>
                                        <td colspan="2"></td>
                                        {* <td></td> *}
            
                                        <td align="center" colspan="2">Paid</td>
                                        <td align="center" colspan="2">Topay</td>
                                        <td align="center" colspan="2">On Account</td>
                                        <td colspan="2"></td>
                                        {* <td></td> *}
                                    </tr>
                                    <tr class="active">
                                        {* booking *}
                                        <td>Freight Amount</td>
                                        <td>Other Charges</td>
                                        <td>Freight Amount</td>
                                        <td>Other Charges</td>
                                        <td>Freight Amount</td>
                                        <td>Other Charges</td>
                                        <td>Service Fee</td>
                                        <td>Charges Share</td>
            
                                        {* delivery *}
                                        <td>Freight Amount</td>
                                        <td>Other Charges</td>
                                        <td>Freight Amount</td>
                                        <td>Other Charges</td>
                                        <td>Freight Amount</td>
                                        <td>Other Charges</td>
                                        <td>Service Fee</td>
                                        <td>Charges Share</td>
                                    </tr>
                                </thead>

                                <tbody class="body_table">
                                    {$cnt = 1}
                                    {foreach item=val from=$day_clo['data'] key=t}
                                        <tr>
                                            <td>{$cnt}</td>
                                            <td>{$val->cargo_code}</td>
                                            
                                            {* booking *}
                                            <td align="right">{$val->paid_booking_amount|inr_format}</td>
                                            <td align="right">{($val->paid_other_charges_amount + $val->paid_pickup_handling_amount)|inr_format}</td>
                                            
                                            <td align="right">{$val->topay_booking_amount|inr_format}</td>
                                            <td align="right">{($val->topay_other_charges_amount + $val->topay_pickup_handling_amount)|inr_format}</td>
                                            
                                            <td align="right">{$val->onacc_booking_amount|inr_format}</td>
                                            <td align="right">{($val->onacc_other_charges_amount + $val->onacc_pickup_handling_amount)|inr_format}</td>

                                            <td align="right">{($val->paid_booking_commission_amount + $val->topay_booking_commission_amount + $val->onacc_booking_commission_amount)|inr_format}</td>
                                            <td align="right">{($val->paid_loading_commission_amount + $val->topay_loading_commission_amount + $val->onacc_loading_commission_amount)|inr_format}</td>

                                            {* delivery *}
                                            <td align="right">{$val->paid_delivery_amount|inr_format}</td>
                                            <td align="right">{($val->paid_delivery_other_charges_amount + $val->paid_delivery_delivery_handling_amount)|inr_format}</td>
                                            
                                            <td align="right">{$val->topay_delivery_amount|inr_format}</td>
                                            <td align="right">{($val->topay_delivery_other_charges_amount + $val->topay_delivery_handling_amount)|inr_format}</td>
                                            
                                            <td align="right">{$val->onacc_delivery_amount|inr_format}</td>
                                            <td align="right">{($val->onacc_delivery_other_charges_amount + $val->onacc_delivery_handling_amount)|inr_format}</td>

                                            <td align="right">{($val->paid_delivery_commission_amount+$val->topay_delivery_commission_amount+$val->onacc_delivery_commission_amount)|inr_format}</td>
                                            <td align="right">{($val->paid_unloading_commission_amount + $val->topay_unloading_commission_amount + $val->onacc_unloading_commission_amount)|inr_format}</td>

                                            <td align="right">{($val->paid_booking_amount+$val->topay_delivery_amount)|inr_format}</td>
                                            <td align="right">{($val->paid_other_charges_amount + $val->paid_pickup_handling_amount+$val->topay_delivery_other_charges_amount + $val->topay_delivery_handling_amount)|inr_format}</td>
                                            {* <td align="right">{($val->paid_service_tax + $val->topay_delivery_service_tax)|inr_format}</td> *}
                                            <td align="right">{($val->paid_booking_commission_amount + $val->topay_booking_commission_amount + $val->onacc_booking_commission_amount+$val->paid_delivery_commission_amount+$val->topay_delivery_commission_amount+$val->onacc_delivery_commission_amount)|inr_format}</td>
                                            <td align="right">{($val->paid_booking_tds_commission_amount + $val->topay_booking_tds_commission_amount + $val->onacc_booking_tds_commission_amount+$val->paid_delivery_tds_commission_amount+$val->topay_delivery_tds_commission_amount+$val->topay_delivery_tds_commission_amount)|inr_format}</td>
                                            <td align="right">{($val->paid_loading_commission_amount + $val->topay_loading_commission_amount + $val->onacc_loading_commission_amount+$val->paid_unloading_commission_amount + $val->topay_unloading_commission_amount + $val->onacc_unloading_commission_amount)|inr_format}</td>
                                            <td align="right">{(($val->paid_booking_amount+$val->topay_delivery_amount+$val->paid_other_charges_amount + $val->paid_pickup_handling_amount+$val->topay_delivery_other_charges_amount + $val->topay_delivery_handling_amount)-(($val->paid_booking_commission_amount + $val->topay_booking_commission_amount + $val->onacc_booking_commission_amount+$val->paid_delivery_commission_amount+$val->topay_delivery_commission_amount+$val->onacc_delivery_commission_amount)-($val->paid_booking_tds_commission_amount + $val->topay_booking_tds_commission_amount + $val->onacc_booking_tds_commission_amount+$val->paid_delivery_tds_commission_amount+$val->topay_delivery_tds_commission_amount+$val->topay_delivery_tds_commission_amount)+($val->paid_loading_commission_amount + $val->topay_loading_commission_amount + $val->onacc_loading_commission_amount+$val->paid_unloading_commission_amount + $val->topay_unloading_commission_amount + $val->onacc_unloading_commission_amount)))|inr_format}</td>
                                        </tr>
                                        {$cnt =$cnt+1}
                                    {foreachelse}
                                        <tr>
                                            <td colspan="34" align="center">No data found</td>
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
                    <button class="btn btn-default" onclick="exportBranchConsolidationExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    {if $DC_data|count}
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
    });    
    
    function toggleBRNCONHidRow(code) {
        if($('.saleusrlist').hasClass(code)) {
            $('.saleusrlist .slide').slideToggle('linear', function() {
                $('.saleusrlist').remove();
            });
            return;
        }
        $('.saleusrlist').remove();
        var $trows = $('.brn-con-hid-table').filter('.' + code);
        $('#'+code).after('<tr class="saleusrlist ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">'
                + $trows.html() + '</table></div></td></tr>');
        $('.saleusrlist .slide').slideToggle('linear');
    }

    function INRFormat(num = 0) {
        return Number(num).toLocaleString('en-IN', { maximumFractionDigits: 2, minimumFractionDigits: 2 });
    }
    {/if}
</script>
