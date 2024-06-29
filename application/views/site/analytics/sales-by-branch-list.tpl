<div class="tabbable">
    <ul class="nav nav-tabs" id="rpt_tabs">
        <li class="active">
            <a data-toggle="tab" href="#tab_table" title="Table View"><i class="fa fa-lg fa-table"></i></a>
        </li>
        <li>
            <a data-toggle="tab" href="#tab_chart" title="Chart View"><i class="fa fa-lg fa-bar-chart"></i></a>
        </li>
    </ul>
    <div class="tab-content" id="rpt_tabs_cont">
        <div id="tab_table" class="tab-pane fade in active">

            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr class="success">
                            <th align="left">Organization</th>
                            <th align="left">No.of {lang('lr')}</th>
                            <th align="right">Other Charges</th>
                            <th align="right">Paid Amount</th>
                            <th align="right">Topay Amount</th>
                            <th align="right">OnAccount Amount</th>
                            <th align="right">Total Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        {assign var=t_cargo_count value=0}
                        {assign var=t_total_item_count value=0}
                        {assign var=t_hamali_charge value=0}
                        {assign var=t_pass_charge value=0}
                        {assign var=t_docket_charge value=0}
                        {assign var=t_pod_charge value=0}
                        {assign var=t_service_charge value=0}
                        {assign var=t_service_tax value=0}
                        {assign var=t_pickup_handling_amount value=0}
                        {assign var=t_delivery_handling_amount value=0}
                        {assign var=t_total_handling_amount value=0}
                        {assign var=t_total_unload_handling_amount value=0}
                        {assign var=t_other_charges_amount value=0}
                        {assign var=t_booking_commission_amount value=0}
                        {assign var=t_delivery_commission_amount value=0}
                        {assign var=t_total_paid_amount value=0}
                        {assign var=t_total_topay_amount value=0}
                        {assign var=t_total_on_account_amount value=0}
                        {assign var=t_t_total_other_charges value=0}
                    
                        {foreach item=row from=$summary}
                            <tr>
                                <td align="left">{$row->organization_name}</td>
                                <td align="right">{$row->cargo_count}</td>
                                <td align="right">{$row->total_other_charges|inr_format}</td>
                                <td align="right">{$row->total_paid_amount|inr_format}</td>
                                <td align="right">{$row->total_topay_amount|inr_format}</td>
                                <td align="right">{$row->total_on_account_amount|inr_format}</td>
                                <td align="right">{($row->total_other_charges + $row->total_paid_amount + $row->total_topay_amount + $row->total_on_account_amount)|inr_format}</td>
                            </tr>
                    
                            {assign var=t_cargo_count value=$t_cargo_count + $row->cargo_count}
                            {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
                            {assign var=t_hamali_charge value=$t_hamali_charge + $row->hamali_charge}
                            {assign var=t_pass_charge value=$t_pass_charge + $row->pass_charge}
                            {assign var=t_docket_charge value=$t_docket_charge + $row->docket_charge}
                            {assign var=t_pod_charge value=$t_pod_charge + $row->pod_charge}
                            {assign var=t_service_charge value=$t_service_charge + $row->service_charge}
                            {assign var=t_service_tax value=$t_service_tax + $row->service_tax}
                            {assign var=t_pickup_handling_amount value=$t_pickup_handling_amount + $row->pickup_handling_amount}
                            {assign var=t_delivery_handling_amount value=$t_delivery_handling_amount + $row->delivery_handling_amount}
                            {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
                            {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
                            {assign var=t_other_charges_amount value=$t_other_charges_amount + $row->other_charges_amount}
                            {assign var=t_booking_commission_amount value=$t_booking_commission_amount + $row->booking_commission_amount}
                            {assign var=t_delivery_commission_amount value=$t_delivery_commission_amount + $row->delivery_commission_amount}
                            {assign var=t_total_paid_amount value=$t_total_paid_amount + $row->total_paid_amount}
                            {assign var=t_total_topay_amount value=$t_total_topay_amount + $row->total_topay_amount}
                            {assign var=t_total_on_account_amount value=$t_total_on_account_amount + $row->total_on_account_amount}
                            {assign var=t_total_other_charges value=$t_total_other_charges + $row->total_other_charges}
                        {/foreach}
                    
                        {if $summary|count}
                            <tr class="active bold">
                                <td align="right">Total</td>
                                <td align='right'>{$t_cargo_count}</td>
                                <td align="right">{$t_total_other_charges|inr_format}</td>
                                <td align='right'>{$t_total_paid_amount|inr_format}</td>
                                <td align='right'>{$t_total_topay_amount|inr_format}</td>
                                <td align='right'>{$t_total_on_account_amount|inr_format}</td>
                                <td align="right">{($t_total_other_charges + $t_total_paid_amount + $t_total_topay_amount + $t_total_on_account_amount)|inr_format}</td>
                            </tr>
                        {/if}
                    </tbody>
                </table>
            </div>
        </div>
        <div id="tab_chart" class="tab-pane fade noprint">
            <div id="container" style="min-width: 310px; max-width: 700px; height: 500px; margin: 30px auto"></div>
        </div>
    </div>
</div>
<script src="assets/lib/highcharts/drilldown.js"></script>

<script>
    $('[href="#tab_chart"]').one('click', renderChart);

    function renderChart() {
        var series = {$branchwise|json_encode};
        var drilldown = {$branchdatewise|json_encode};

        {literal}
            // Create the chart
            var chart = new Highcharts.Chart('container', {
                chart: {
                    type: 'pie',
                    events: {
                        drilldown: function(e) {
                            this.setTitle({ text: e.seriesOptions.name });
                            this.xAxis[0].update({ lineColor : '#ccd6eb' });
                        },
                        drillup: function() {
                            this.setTitle({ text: ''});
                            this.xAxis[0].update({ lineColor : '#ffffff' });
                        }
                    }
                },
                title: { text: '' },
                xAxis: { type: 'category' },
                yAxis: { title: '' },
                tooltip: {
                    formatter: function () {
                        return [
                            this.point.name,
                            '<b>Paid</b> : ' + INRFormat(this.point.total_paid_amount),
                            '<b>Topay</b> : ' + INRFormat(this.point.total_topay_amount),
                            '<b>OnAccount</b> : ' + INRFormat(this.point.total_on_account_amount),
                            '<b>Other Charges</b> : ' + INRFormat(this.point.total_other_charges),
                            '<b>Total</b> : ' + INRFormat(this.y)
                        ].join('<br/>')
                    }
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: true,
                            showInLegend:true,
                            percentageDecimals:1,
                            valueDecimals:2,
                            formatter:function () {
                                return '<b>'+ this.point.name+'</b> : '+ Math.round(this.percentage) +' %';
                            },
                        }
                    },
                    column: {
                        dataLabels: {
                            enabled: true,
                            formatter: function () {
                                return INRFormat(this.y)
                            }
                        }
                    }
                },
                credits:{ enabled:false },
                legend:{ enabled:false },
                exporting:{ enabled:false },
                colors:["#FF6040","#A05030","#D0B090","#6600FF","#64E572","#FF9655","#FFF263","#6AF9C4"],
                series: [{
                    name: 'Branches',
                    colorByPoint: true,
                    data: series || []
                }],
                drilldown: {
                    series: drilldown || []
                }
            });            
        {/literal}
    }

    function INRFormat(num) {
        return Number(num).toLocaleString('en-IN', { maximumFractionDigits: 2, minimumFractionDigits: 2 });
    }
</script>