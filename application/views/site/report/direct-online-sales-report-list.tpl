<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Direct Online Sales Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Date :</span> {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format}</td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
    </tr>
</table>

<h5><b class="anchortop">Summary</b></h5>
<div class="row">
<div class="col-md-8">
<table class="table table-bordered">
    <thead>
        <tr class="success">
            <th rowspan="2" align="left">Device Medium</th>
            <th colspan="5" class="text-center">Booking</th>
            <th colspan="6" class="text-center">Cancel</th>
            <th rowspan="2" class="text-center">Net Payable</th>
        </tr>
        <tr class="success">
            <th align="left">Seats</th>
            <th align="right">Fare</th>
            <th align="right">GST</th>
            <th align="right">Discount</th>
            <th align="right">Gross</th>
            
            <th align="left">Seats</th>
            <th align="right">Fare</th>
            <th align="right">GST</th>
            <th align="right">Discount</th>
            <th align="right">Cncl Charges</th>
            <th align="right">Refund</th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_bo_seats value=0}
        {assign var=t_bo_fare value=0}
        {assign var=t_bo_gst value=0}
        {assign var=t_bo_discount value=0}
        {assign var=t_bo_payable value=0}
        
        {assign var=t_ca_seats value=0}
        {assign var=t_ca_fare value=0}
        {assign var=t_ca_gst value=0}
        {assign var=t_ca_discount value=0}
        {assign var=t_ca_ccharges value=0}
        {assign var=t_ca_refund value=0}

        {foreach item=row key=medium from=$summary}
            <tr>
                <td align="left">{$medium}</td>
                <td align="right">{$row['BO']['seats'] + 0}</td>
                <td align="right">{$row['BO']['fare']|inr_format}</td>
                <td align="right">{$row['BO']['gst']|inr_format}</td>
                <td align="right">{$row['BO']['discount']|inr_format}</td>
                <td align="right">{($row['BO']['fare'] + $row['BO']['gst'] - $row['BO']['discount'])|inr_format}</td>

                <td align="right">{$row['CA']['seats'] + 0}</td>
                <td align="right">{$row['CA']['fare']|inr_format}</td>
                <td align="right">{$row['CA']['gst']|inr_format}</td>
                <td align="right">{$row['CA']['discount']|inr_format}</td>
                <td align="right">{$row['CA']['ccharges']|inr_format}</td>
                <td align="right">{$row['CA']['refund']|inr_format}</td>
                <td align="right">{(($row['BO']['fare'] + $row['BO']['gst'] - $row['BO']['discount']) - $row['CA']['refund'])|inr_format}</td>
            </tr>

            {assign var=t_bo_seats value=$t_bo_seats + $row['BO']['seats']}
            {assign var=t_bo_fare value=$t_bo_fare + $row['BO']['fare']}
            {assign var=t_bo_gst value=$t_bo_gst + $row['BO']['gst']}
            {assign var=t_bo_discount value=$t_bo_discount + $row['BO']['discount']}
            {assign var=t_bo_payable value=$t_bo_payable + ($row['BO']['fare'] + $row['BO']['gst'] - $row['BO']['discount'])}
            
            {assign var=t_ca_seats value=$t_ca_seats + $row['CA']['seats']}
            {assign var=t_ca_fare value=$t_ca_fare + $row['CA']['fare']}
            {assign var=t_ca_gst value=$t_ca_gst + $row['CA']['gst']}
            {assign var=t_ca_discount value=$t_ca_discount + $row['CA']['discount']}
            {assign var=t_ca_ccharges value=$t_ca_ccharges + $row['CA']['ccharges']}
            {assign var=t_ca_refund value=$t_ca_refund + $row['CA']['refund']}
        {/foreach}
        {if $summary|count}
            <tr class="active bold">
                <td align="right">Total</td>
                <td align='right'>{$t_bo_seats}</td>
                <td align='right'>{$t_bo_fare|inr_format}</td>
                <td align='right'>{$t_bo_gst|inr_format}</td>
                <td align='right'>{$t_bo_discount|inr_format}</td>
                <td align='right'>{$t_bo_payable|inr_format}</td>

                <td align='right'>{$t_ca_seats}</td>
                <td align='right'>{$t_ca_fare|inr_format}</td>
                <td align='right'>{$t_ca_gst|inr_format}</td>
                <td align='right'>{$t_ca_ccharges|inr_format}</td>
                <td align='right'>{$t_ca_discount|inr_format}</td>
                <td align='right'>{$t_ca_refund|inr_format}</td>
                <td align='right'>{($t_bo_payable - $t_ca_refund)|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>
</div>
</div>    

<div class="row">    
    <div class="col-md-5">
        <div id="summary-direct-sales-pie"></div>
    </div>
    <div class="col-md-5">
        <div id="summary-direct-sales-pg-pie"></div>
    </div>
</div>

<div id="summary-direct-sales-bar"></div>
{*
<h5><b>Booking</b></h5>
<div class="table-responsive" id="adv-bp-grid">
    <table id="dt_bp_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th align="left">PNR</th>
                <th align="left">Transaction Date</th>
                <th align="left">Travel Date</th>
                <th align="left">Route</th>
                <th align="left">Service No</th>
                <th align="left">Device Medium</th>
                <th align="left">Gateway Partner</th>
                <th align="left">Seats</th>
                <th align="right">Fare</th>
                <th align="right">GST</th>
                <th align="right">Discount</th>
                <th align="right">Net Payable</th>
            </tr>
        </thead>
        <tbody>
            {assign var=t_seat_count value=0}
            {assign var=t_ticket_amount value=0}
            {assign var=t_ac_bus_tax value=0}
            {assign var=t_addons_amount value=0}
            {assign var=t_payable value=0}

            {foreach item=row from=$tickets['BO']}
                <tr>
                    <td align="left">{$row->ticket_code}</td>
                    <td align="left">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->travel_date|date_format:$ns_date_format}</td>
                    <td align="left">{$row->from_station_name} - {$row->to_station_name}</td>
                    <td align="left" class="text-danger">
                        {if $row->service_number}{$row->service_number}
                        {else}-{/if}
                    </td>
                    <td align="left">{$row->device_medium}</td>
                    <td align="left">{$row->gateway_partner_name}</td>
                    <td align="right">{$row->seat_count}</td>
                    <td align="right">{$row->ticket_amount|inr_format}</td>
                    <td align="right">{$row->ac_bus_tax|inr_format}</td>
                    <td align="right">{$row->addons_amount|inr_format}</td>
                    <td align="right">{($row->ticket_amount + $row->ac_bus_tax - $row->addons_amount)|inr_format}</td>
                </tr>

                {assign var=t_seat_count value=$t_seat_count + $row->seat_count}
                {assign var=t_ticket_amount value=$t_ticket_amount + $row->ticket_amount}
                {assign var=t_ac_bus_tax value=$t_ac_bus_tax + $row->ac_bus_tax}
                {assign var=t_addons_amount value=$t_addons_amount + $row->addons_amount}
                {assign var=t_payable value=$t_payable + ($row->ticket_amount + $row->ac_bus_tax - $row->addons_amount)}
            {/foreach}

            {if $tickets['BO']|count}
                <tr class="active bold">
                    <td colspan="7" align="right">Total</td>
                    <td align='right'>{$t_seat_count}</td>
                    <td align='right'>{$t_ticket_amount|inr_format}</td>
                    <td align='right'>{$t_ac_bus_tax|inr_format}</td>
                    <td align='right'>{$t_addons_amount|inr_format}</td>
                    <td align='right'>{$t_payable|inr_format}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>


<h5><b>Cancellation</b></h5>
<div class="table-responsive" id="adv-bp-grid">
    <table id="dt_bp_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th align="left">PNR</th>
                <th align="left">Transaction Date</th>
                <th align="left">Travel Date</th>
                <th align="left">Route</th>
                <th align="left">Service No</th>
                <th align="left">Device Medium</th>
                <th align="left">Gateway Partner</th>
                <th align="left">Seats</th>
                <th align="right">Fare</th>
                <th align="right">GST</th>
                <th align="right">Discount</th>
                <th align="right">Cncl Charges</th>
                <th align="right">Refund</th>
            </tr>
        </thead>
        <tbody>
            {assign var=t_seat_count value=0}
            {assign var=t_ticket_amount value=0}
            {assign var=t_ac_bus_tax value=0}
            {assign var=t_addons_amount value=0}
            {assign var=t_refund_amount value=0}

            {foreach item=row from=$tickets['CA']}
                <tr>
                    <td align="left">{$row->ticket_code}</td>
                    <td align="left">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->travel_date|date_format:$ns_date_format}</td>
                    <td align="left">{$row->from_station_name} - {$row->to_station_name}</td>
                    <td align="left" class="text-danger">
                        {if $row->service_number}{$row->service_number}
                        {else}-{/if}
                    </td>
                    <td align="left">{$row->device_medium}</td>
                    <td align="left">{$row->gateway_partner_name}</td>
                    <td align="right">{$row->seat_count}</td>
                    <td align="right">{$row->ticket_amount|inr_format}</td>
                    <td align="right">{$row->ac_bus_tax|inr_format}</td>
                    <td align="right">{$row->addons_amount|inr_format}</td>
                    <td align="right">{$row->cancellation_charges|inr_format}</td>
                    <td align="right">{$row->refund_amount|inr_format}</td>
                </tr>

                {assign var=t_seat_count value=$t_seat_count + $row->seat_count}
                {assign var=t_ticket_amount value=$t_ticket_amount + $row->ticket_amount}
                {assign var=t_ac_bus_tax value=$t_ac_bus_tax + $row->ac_bus_tax}
                {assign var=t_cancellation_charges value=$t_cancellation_charges + $row->cancellation_charges}
                {assign var=t_addons_amount value=$t_addons_amount + $row->addons_amount}
                {assign var=t_refund_amount value=$t_refund_amount + $row->refund_amount}
            {/foreach}

            {if $tickets['CA']|count}
                <tr class="active bold">
                    <td colspan="7" align="right">Total</td>
                    <td align='right'>{$t_seat_count}</td>
                    <td align='right'>{$t_ticket_amount|inr_format}</td>
                    <td align='right'>{$t_ac_bus_tax|inr_format}</td>
                    <td align='right'>{$t_cancellation_charges|inr_format}</td>
                    <td align='right'>{$t_addons_amount|inr_format}</td>
                    <td align='right'>{$t_refund_amount|inr_format}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>
*}

<script>
    function drawOnlineSalesGraph() {
        var feeds = {$chart|json_encode};
        var summary = {$summary|json_encode};
        var pg = {$pg|json_encode};
        var allmedium = {$allmedium|json_encode};

        var series = [];
        $.each(allmedium || [], function (key, medium) {
            series.push({
                name: medium,
                type: 'column',
                data: $.map(feeds || [], function (o) {
                    return o[medium] ? o[medium].seats : 0;
                })
            });
        });
        
        var spline = [];
        $.each(feeds || [], function (key, medium) {
            var sum = 0;
            $.each(medium || [], function (i, o) {
                sum += o.seats || 0;
            });
            spline.push(sum);
        });
        series.push({
            name: 'Overall',
            type: 'spline', 
            data:spline
        });
        
        var obj = [];
        $.each(summary, function(i, val) {
            obj.push({
                name: i,
                y: _.get(val, 'BO.seats', 0) - _.get(val, 'CA.seats', 0)
            });
        });
        
        var pgobj = [];
        $.each(pg, function(i, val) {
            pgobj.push({
                name: i,
                y: _.get(val, 'BO.seats', 0) - _.get(val, 'CA.seats', 0)
            });
        });

        {literal}
            $('#summary-direct-sales-bar').highcharts({
                chart: {
                    marginTop: 50
                },
                title: {
                    text: ''
                },
                xAxis: {
                    categories: Object.keys(feeds)},
                yAxis: {
                    min: 0,
                    allowDecimals: false,
                    title: {
                        text: 'Seats',
                        style: {fontWeight: 'bold'}
                    }
                },
                plotOptions: {
                    column: {
                        dataLabels: {
                            enabled: true,
                            formatter: function () {
                                if (this.y !== 0) {
                                    return this.y;
                                }
                            }
                        },
                        legend: {enabled: true}
                    },
                    spline: {
                        dataLabels: {
                            enabled: true,
                            formatter: function () {
                                if (this.y !== 0) {
                                    return this.y;
                                }
                            }
                        },
                        color: "#D0B090",
                        legend: {enabled: true}
                    }
                },
                tooltip: {
                    formatter: function () {
                        if(this.series.name === 'Overall') {
                            return '<b>' + this.x + ':</b> ' + this.y + ' Seats <br/>';                            
                        } else {
                            return '<b>' + this.series.name + ':</b> ' + this.y + ' Seats <br/>' +
                                    '<b>Fare:</b> Rs. ' + feeds[this.x][this.series.name].fare;
                        } 
                    }
                },
                credits: {enabled: false},
                legend: {enabled: true},
                exporting: {enabled: false},
                colors: ["#FF6040", "#A05030", "#D0B090", "#6600FF", "#64E572", "#FF9655", "#FFF263", "#6AF9C4"],
                series: series
            });
            $('#summary-direct-sales-pie').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie',
                    height: 230
                },
                title: {
                    text: 'Device Medium Summary',
                    style: {
                        fontSize: "14px",
                        fontWeight: 'bold'
                    }
                },
                exporting: { 
                    enabled: false 
                },
                credits: {
                    enabled: false
                },
                tooltip: {
                    shared:false,
                    useHTML:true,
                    headerFormat:"<b>{point.key}</b><table>",
                    pointFormat:" : {point.percentage:.2f}%, {point.y} seats",
                    footerFormat:"</table>",
                    percentageDecimals:1
                },
                colors:["#FF6040","#A05030","#D0B090","#6600FF","#64E572","#FF9655","#FFF263","#6AF9C4"],
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled:true,
                            formatter:function () {return this.point.name+' : '+ Math.round(this.percentage) +' %';},
                            showInLegend:true,
                            percentageDecimals:1,
                            valueDecimals:2
                        },                        
                        showInLegend: false
                    }
                },
                series: [{
                    name: '',
                    colorByPoint: true,
                    data: obj
                }]
            });
            
            $('#summary-direct-sales-pg-pie').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie',
                    height: 230
                },
                title: {
                    text: 'Payment Gateway Summary',
                    style: {
                        fontSize: "14px",
                        fontWeight: 'bold'
                    }
                },
                exporting: { 
                    enabled: false 
                },
                credits: {
                    enabled: false
                },
                tooltip: {
                    shared:false,
                    useHTML:true,
                    headerFormat:"<b>{point.key}</b><table>",
                    pointFormat:" : {point.percentage:.2f}%, {point.y} seats",
                    footerFormat:"</table>",
                    percentageDecimals:1
                },
                colors:["#FF6040","#A05030","#D0B090","#6600FF","#64E572","#FF9655","#FFF263","#6AF9C4"],
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled:true,
                            formatter:function () {return this.point.name+' : '+ Math.round(this.percentage) +' %';},
                            showInLegend:true,
                            percentageDecimals:1,
                            valueDecimals:2
                        },                        
                        showInLegend: false
                    }
                },
                series: [{
                    name: '',
                    colorByPoint: true,
                    data: pgobj
                }]
            });
            
        {/literal}
    }
    {if $chart|count}
    drawOnlineSalesGraph();
    {/if}
</script>