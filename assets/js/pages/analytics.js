function init_analytics_page() {
    
    if ($('.trip-pie').length) {
        $('.trip-pie').each(function () {
            var ele = '#' + $(this).attr('id');
            chartdata = [
                {label: "Booked", data: $(this).attr('data-booked'), color: '#2ca02c'},
                {label: "Vacant", data: $(this).attr('data-vacant'), color: '#efefef'},
            ];
            $.plot(ele, chartdata, {
                grid: {clickable: true, hoverable: true},
                series: {
                    pie: {
                        show: true,
                        radius: 3 / 4,
                        label: {
                            show: false
                        },
                        innerRadius: 0
                    }
                },
                legend: {show: false},
                tooltip: true,
                tooltipOpts: {
                    content: "%p.0%, %s",
                    shifts: {
                        x: 20,
                        y: 0
                    },
                    defaultTheme: false
                }
            });
        });
    }
    
    if($('#reportrange').length) {
        $('#reportrange').daterangepicker( {
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
                    'Last 7 Days': [moment().subtract('days', 6), moment()],
                    'Last 30 Days': [moment().subtract('days', 29), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')],
                    'Last 3 Months': [moment().subtract('month', 3).startOf('month'), moment().subtract('month', 1).endOf('month')]
                },
                startDate: moment(),
                endDate: moment(),
                buttonClasses: ['btn','btn-sm']
            },
            function(start, end) {
                $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));                
                $('#m_from').val(start.format('YYYY-MM-DD'));
                $('#m_to').val(end.format('YYYY-MM-DD'));
            }
        );
    }
    
    $('#bo_count').easyPieChart({
        animate: 2000,
        size: 55,
        lineWidth: 4,
        scaleColor: false,
        barColor: '#27ae60',
        trackColor: '#eafaf1',
        lineCap: 'square'
    });
    
    $('#trips_count').easyPieChart({
        animate: 2000,
        size: 55,
        lineWidth: 4,
        scaleColor: false,
        barColor: '#27ae60',
        trackColor: '#eafaf1',
        lineCap: 'square'
    });
    
    $('#seats_count').easyPieChart({
        animate: 2000,
        size: 55,
        lineWidth: 4,
        scaleColor: false,
        barColor: '#27ae60',
        trackColor: '#eafaf1',
        lineCap: 'square'
    });
    
    $('#pbl_count').easyPieChart({
        animate: 2000,
        size: 55,
        lineWidth: 4,
        scaleColor: false,
        barColor: '#27ae60',
        trackColor: '#eafaf1',
        lineCap: 'square'
    });
    
    $('#vac_count').easyPieChart({
        animate: 2000,
        size: 55,
        lineWidth: 4,
        scaleColor: false,
        barColor: '#27ae60',
        trackColor: '#eafaf1',
        lineCap: 'square'
    });
    
    trip_analytics();
};

function trip_analytics() {
    var data = {};
    data.m_from = $('#m_from').val();
    data.m_to = $('#m_to').val();
    
    data.sch_code = $('#to_schedule_code').val();
    data.group_by = $('#to_group').val();
    
    $('#trip_bar').html(loading_popup);
    $('#trip_pie').html(loading_popup);
    
    $.ajax({
        type: "POST",
        url: base_url + "analytics/trip-analytics",
        dataType:'json',
        data: data,
        success: function(feed) {
           $('#trip_bar').html('');
           trip_info = feed;
           if(feed.status==1) {
               
               var temp = $('#template-sch-bar').html();
                $.each(feed.info, function(key, tkt) {
                    var divhtml = $(temp).clone();
                    
                    divhtml.attr('id', key);
                    divhtml.find('.progress-bar').css( 'width', tkt.occupancy+'%' );
                    divhtml.find('.progress-bar span').html( tkt.route + ' - ' + tkt.occupancy+'%' );
                    
                    var summary = '<table width="200" class="ana-summary">'; //<tr> <th colspan="2">Summary</th> </tr>
                    summary += '<tr style="border-bottom:1px dotted #ddd;"> <th colspan="2">'+tkt.route+'</th> </tr>';
                    summary += '<tr style="border-bottom:1px dotted #ddd;"> <th colspan="2">'+tkt.bus_type+'</th> </tr>';
                    summary += '<tr style="border-bottom:1px dotted #ddd;"> <td width="65%">Total Seats</td><td width="35%">'+tkt.t_seats+'</td>';
                    summary += '<tr style="border-bottom:1px dotted #ddd;"> <td width="65%">Booked Seats</td><td width="35%">'+tkt.t_booked_seats+'</td>';
                    summary += '<tr style="border-bottom:1px dotted #ddd;"> <td width="65%">Vacant Seats</td><td width="35%">'+(tkt.t_seats-tkt.t_booked_seats)+'</td>';
                    $.each(tkt.booking, function(key, attr) {
                        summary += '<tr style="border-bottom:1px dotted #ddd;"> <td width="65%">'+key+'</td>    <td width="35%">'+attr.seats+'</td>';
                    });
                    
                    $(divhtml).popover({
                        container:'body',
                        content:summary,
                        html:true,
                        placement:'right',
                        trigger:'hover',
                    });
                    
                    $(divhtml).click(function() {
                        render_trip_pie(key);
                    });
                    
                    $('#trip_bar').append(divhtml);                   
                    
                });
                
                render_trip_pie('');
           }
           
        }
    });
    
}

function render_trip_pie(sch){
    $('#trip_pie').html('');
    $('#'+sch).popover('hide');
    
    var sch_feed = "";
    var title = "";
    var subtitle = "";
    var pie_data = [];
    if(sch != "") {     //  single schedule   
        $.each(trip_info.info, function(key, tkt) {
            if(key==sch) {
                sch_feed = tkt;
            }
        });        
        title = 'Schedule Summary - '+$('#reportrange span').text();
        subtitle = sch_feed.route+', '+sch_feed.bus_type;
        
        $.each(sch_feed.booking, function(key, attr) {
            var tp = (attr.seats / sch_feed.t_seats * 100);
            var t = {};
            t.name = key;
            t.y = tp;

            pie_data.push(t);
        });
        
    } else {    //  all schedules
        sch_feed = trip_info;
        title = 'Schedule Summary - '+$('#reportrange span').text();
        subtitle = 'All Schedules';
        
        var cum = sch_feed.cumulative;        
        $.each(cum.booking, function(key, attr) {
            var tp = (attr.seats / cum.seats * 100);
            var t = {};
            t.name = key;
            t.y = tp;

            pie_data.push(t);
        });
    }
        
    $('#trip_pie').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {text: title},
        subtitle: {text: subtitle},
        tooltip: {pointFormat: '{series.name} : <b>{point.percentage:.1f}%</b>'},
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            name: 'User Group',
            colorByPoint: true,
            data: pie_data
        }]
    });

}

