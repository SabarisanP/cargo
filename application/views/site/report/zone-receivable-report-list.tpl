<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Zone Receivable Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Date :</span> {$from_date|date_format:$ns_date_format} to {$to_date|date_format:$ns_date_format}</td>
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
                            <td>S No <i class="fa fa-sort"></i></td>
                            <td>Zone <i class="fa fa-sort"></i></td>
                            <td>Lr Count <i class="fa fa-sort"></i></td>
                            <td>Freight <i class="fa fa-sort"></i></td>
                            <td>Delivery Charge <i class="fa fa-sort"></i></td>
                            <td>Loading Charge <i class="fa fa-sort"></i></td>
                            <td>Unloading Charge <i class="fa fa-sort"></i></td>
                            <td>Pickup Charge <i class="fa fa-sort"></i></td>
                            <td>Service Charge <i class="fa fa-sort"></i></td>
                            <td>Service Tax <i class="fa fa-sort"></i></td>
                            <td>Commission <i class="fa fa-sort"></i></td>
                            <td>Delivery Commission <i class="fa fa-sort"></i></td>
                            <td>Other Charge <i class="fa fa-sort"></i></td>
                            <td>Net Payable <i class="fa fa-sort"></i></td>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {$key = 1}

                        {assign var=total_lr_count value=0}
                        {assign var=total_freight value=0}
                        {assign var=total_delivery_charge value=0}
                        {assign var=total_loading_charge value=0}
                        {assign var=total_unloading_charge value=0} 
                        {assign var=total_pickup_charge value=0}
                        {assign var=total_service_charge value=0}
                        {assign var=total_service_tax value=0}
                        {assign var=total_commission value=0}
                        {assign var=total_delivery_commission value=0}
                        {assign var=total_other_charge value=0}
                        {assign var=total_net_amount value=0}
                        
                        {foreach item=row from=$summary key=t}
                            <tr id="{$t}" class="tr-hover" onclick="toggleZoneBranch('{$t}');">
                                <td>{$key}</td>
                                <td>{$row['zone_name']}</td>
                                <td align="center">{$row['lr_count']}</td>
                                <td align="right">{$row['freight']|inr_format:2}</td>
                                <td align="right">{$row['delivery_charge']|inr_format:2}</td>
                                <td align="right">{$row['loading_charge']|inr_format:2}</td>
                                <td align="right">{$row['unloading_charge']|inr_format:2}</td>
                                <td align="right">{$row['pickup_charge']|inr_format:2}</td>
                                <td align="right">{$row['service_charge']|inr_format:2}</td>
                                <td align="right">{$row['service_tax']|inr_format:2}</td>
                                <td align="right">{$row['commission']|inr_format:2}</td>
                                <td align="right">{$row['del_commission']|inr_format:2}</td>
                                <td align="right">{$row['other_charge']|inr_format:2}</td>

                                {assign var=net_amount value=($row['freight']+$row['loading_charge']+$row['unloading_charge']+$row['pickup_charge']+$row['delivery_charge']+$row['service_charge']+$row['service_tax']+$row['other_charge'])-($row['commission']+$row['del_commission'])}
                                <td align="right">{$net_amount|inr_format:2}</td>
                            </tr>
                            {$key = $key+1}

                            {assign var=total_lr_count value=$total_lr_count+$row['lr_count']}
                            {assign var=total_freight value=$total_freight+$row['freight']}
                            {assign var=total_delivery_charge value=$total_delivery_charge+$row['delivery_charge']}
                            {assign var=total_loading_charge value=$total_loading_charge+$row['loading_charge']}
                            {assign var=total_unloading_charge value=$total_unloading_charge+$row['unloading_charge']}
                            {assign var=total_pickup_charge value=$total_pickup_charge+$row['pickup_charge']}
                            {assign var=total_service_charge value=$total_service_charge+$row['service_charge']}
                            {assign var=total_service_tax value=$total_service_tax+$row['service_tax']}
                            {assign var=total_commission value=$total_commission+$row['commission']}
                            {assign var=total_delivery_commission value=$total_delivery_commission+$row['del_commission']}
                            {assign var=total_other_charge value=$total_other_charge+$row['other_charge']}
                            {assign var=total_net_amount value=$total_net_amount+$net_amount}

                        {foreachelse}
                            <tr>
                                <td colspan="14" align="center">No data found</td>
                            </tr>
                        {/foreach}
                    </tbody>

                    <tfoot>
                        <tr class="active">
                            <td colspan="2" align="right">Total</td>

                            <td align="center">{$total_lr_count}</td>
                            <td align="right">{$total_freight|number_format:2}</td>
                            <td align="right">{$total_delivery_charge|number_format:2}</td>
                            <td align="right">{$total_loading_charge|number_format:2}</td>
                            <td align="right">{$total_unloading_charge|number_format:2}</td>
                            <td align="right">{$total_pickup_charge|number_format:2}</td>
                            
                            <td align="right">{$total_service_charge|number_format:2}</td>
                            <td align="right">{$total_service_tax|number_format:2}</td>
                            <td align="right">{$total_commission|number_format:2}</td>
                            <td align="right">{$total_delivery_commission|number_format:2}</td>
                            <td align="right">{$total_other_charge|number_format:2}</td>
                            <td align="right">{$total_net_amount|number_format:2}</td>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <table class="hide">
                {foreach item=org from=$summary key=key}
                    <tr class="{$key} hide zone-rcv-hid-table">
                        <td>
                            <table class="table table-bordered " width="100%">
                                <thead>
                                    <tr class="active">
                                        <td>S No</td>
                                        {if $transactionType == 'BOOKING'}
                                            <td>To Branch</td>
                                            <td>From Branch</td>
                                        {else if $transactionType == 'DELIVERY'}
                                            <td>From Branch</td>
                                            <td>To Branch</td>
                                        {/if}
                                        <td>Lr Count</td>
                                        <td>Freight</td>
                                        <td>Delivery Charge</td>
                                        <td>Loading Charge</td>
                                        <td>Unloading Charge</td>
                                        <td>Pickup Charge</td>
                                        <td>Service Charge</td>
                                        <td>Service Tax</td>
                                        <td>Commission</td>
                                        <td>Delivery Commission</td>
                                        <td>Other Charge</td>
                                        <td>Net Payable</td>
                                    </tr>
                                </thead>

                                <tbody class="body_table">
                                    {$cnt = 1}
                                    {foreach item=val from=$summary[$key]['org'] key=t}
                                        <tr>
                                            <td>{$cnt}</td>

                                            {if $transactionType == 'BOOKING'}
                                                <td><a href="javascript:;" onclick="getDetailsDialog('{$t}', '{$key}');">{$val['branch_name']}</a></td>
                                                <td>
                                                    {foreach from=$val['from_branch'] item=branch}
                                                        {$branch['name']|cat:'<b>&nbsp;-&nbsp;'|cat:$branch['count']|cat:'</b><br>'}
                                                    {/foreach}
                                                </td>
                                            {elseif $transactionType == 'DELIVERY'}
                                                <td><a href="javascript:;" onclick="getDetailsDialog('{$t}', '{$key}');">{$val['branch_name']}</a></td>
                                                <td>
                                                    {foreach from=$val['to_branch'] item=branch}
                                                        {$branch['name']|cat:'<b>&nbsp;-&nbsp;'|cat:$branch['count']|cat:'</b><br>'}
                                                    {/foreach}
                                                </td>
                                            {/if}

                                            <td align="center">{$val['lr_count']}</td>
                                            <td align="right">{$val['freight']|inr_format:2}</td>
                                            <td align="right">{$val['delivery_charge']|inr_format:2}</td>
                                            <td align="right">{$val['loading_charge']|inr_format:2}</td>
                                            <td align="right">{$val['unloading_charge']|inr_format:2}</td>
                                            <td align="right">{$val['pickup_charge']|inr_format:2}</td>
                                            <td align="right">{$val['service_charge']|inr_format:2}</td>
                                            <td align="right">{$val['service_tax']|inr_format:2}</td>
                                            <td align="right">{$val['commission']|inr_format:2}</td>
                                            <td align="right">{$val['del_commission']|inr_format:2}</td>
                                            <td align="right">{$val['other_charge']|inr_format:2}</td>
                                            
                                            {assign var=net_payable value=($val['freight']+$val['loading_charge']+$val['unloading_charge']+$val['pickup_charge']+$val['delivery_charge']+$val['service_charge']+$val['service_tax']+$val['other_charge'])-($val['commission']+$val['del_commission'])}
                                            <td align="right">{$net_payable|inr_format:2}</td>
                                        </tr>
                                        {$cnt =$cnt+1}
                                    {foreachelse}
                                        <tr>
                                            <td colspan="14" align="center">No data found</td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </td>
                    </tr>
                {/foreach}
            </table>

            {* <div class="text-right noprint">
                <div class="btn-group btn-group-sm">
                    <button class="btn btn-default" onclick="exportBranchConsolidationExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
                </div>
            </div> *}

        </div>
    </div>
</div>

<script>
    var fromDate = {$fromDate|json_encode};
    var toDate = {$toDate|json_encode};
    var zoneCode = {$zoneCode|json_encode};
    var transactionType = {$transactionType|json_encode}
    
    {if $summary|count}
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
        
        function toggleZoneBranch(code) {
            if($('.saleusrlist').hasClass(code)) {
                $('.saleusrlist .slide').slideToggle('linear', function() {
                    $('.saleusrlist').remove();
                });
                return;
            }
            $('.saleusrlist').remove();
            var $trows = $('.zone-rcv-hid-table').filter('.' + code);
            $('#'+code).after('<tr class="saleusrlist ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">'
                    + $trows.html() + '</table></div></td></tr>');
            $('.saleusrlist .slide').slideToggle('linear');
        }

        // function INRFormat(num = 0) {
        //     return Number(num).toLocaleString('en-IN', { maximumFractionDigits: 2, minimumFractionDigits: 2 });
        // }
    {/if}
</script>
