<div class="brand_top"><h3>User Transaction Summary Report</h3> 
    <div class="text-right noprint" id="excl_cons">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportConsolidateExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
       	    <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">
                                        <div>
                                            <div id="search-panel">                                         
                                                <div class="divide-10"></div>
                                                <form id='usr_sum_rpt' method="post" name="usr_sum_rpt" action="agentreport/get-agent-report-list" onsubmit="return false">

                                                    <div class="form-group col-md-3">
                                                        <label class="sr-only" for="date_from">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="date_from" class="form-control sdate" id="date_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-3">
                                                        <label class="sr-only" for="date_to">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="date_to" class="form-control sdate" id="date_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-3">                                                           
                                                        <input type="hidden" name="export" id="export" value="">
                                                        <button class="btn btn-success" type="button"  onclick="searchReport();" >Generate</button>
                                                        <button type="button" class="btn btn-default btn-clear" onclick="clearReport();">Clear</button>
                                                    </div>
                                                </form>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="usr-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row hidden noprint" id="trns-booking-list-graph">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-sm-4">
                                        <div class="bold" align="center">Overall Summary</div>
                                        <div id="trns-booking-graph1"  style="height:150px;"></div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="bold" align="center">User Wise Bookings</div>
                                        <div id="trns-booking-graph2"  style="height:150px;"></div>
                                    </div>  
                                    <div class="col-sm-4" align="center">
                                        <div class="bold">User Wise Cancells</div>
                                        <div id="trns-booking-graph3"  style="height:150px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="rpt_lst">
                        
                    </div>
                    <div class="row hidden" id="trns-booking-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="trns-booking-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>                    
            </div>                
        </div>
    </div>        
</div>



<iframe name="ifrm_consolidate_downloader" id="ifrm_consolidate_downloader" style="display:none"></iframe>  


{literal}
    <script>
        $('#date_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-3m',
            endDate: '+3m',
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#date_to').datepicker('setStartDate', e.date);
            $("#date_to").datepicker("setEndDate", end)
        });
        $('#date_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            endDate: '+3m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#date_from').datepicker('setStartDate', start);
            $('#date_from').datepicker('setEndDate', e.date)
        });

        function searchReport() {
            $('#trns-booking-list').html('');
            var data = {};
            data.user = $('#gru_users').val();
            data.date_from = $('#date_from').val();
            data.date_to = $('#date_to').val();

            var err = 0;
            if (data.user == '') {
                $('#gru_users').addClass('inp_error');
                err++;
            } else {
                $('#gru_users').removeClass('inp_error');
            }
            if (data.date_from == '') {
                $('#date_from').addClass('inp_error');
                err++;
            } else {
                $('#date_from').removeClass('inp_error');
            }

            if (data.date_from == '') {
                if (data.date_to == '') {
                    $('#date_to').addClass('inp_error');
                    err++;

                } else {
                    $('#date_to').removeClass('inp_error');
                }
            }

            if (data.date_from != '') {
                if (data.date_to == '') {
                    $('#date_to').removeClass('inp_error');
                    var d = new Date();

                    var month = d.getMonth() + 1;
                    var day = d.getDate();

                    var output = d.getFullYear() + '-' +
                            (('' + month).length < 2 ? '0' : '') + month + '-' +
                            (('' + day).length < 2 ? '0' : '') + day;

                    data.date_to = output;
                    $('#date_to').val(output);
                }
            }

            if (err > 0) {
                $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#usr-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#usr-action-state').show();
                return false;
            } else {
                $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#usr-action-state').html('');
                $('#usr-action-state').hide();
            }
            var html = "";
            $('#date_to').removeClass('inp_error');
            $('#trns-booking-list').html(loading_popup);
            $('#trns-booking-list-container').removeClass('hidden');
            $('#trns-booking-list').html(loading_popup);
            $('#trns-booking-graph1').html('')
            $('#trns-booking-list-graph').addClass('hidden');
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "agentreport/get-agent-report-list",
                data: data,
                success: function (response) {
                    $('#trns-booking-list').html(response);
                    $('#excl_cons').show();
                    plot_trans_graph(); //  init graphs
                    $("html, body").animate({
                        scrollTop: $('#trns-booking-list-graph').offset().top - 35
                    }, "slow");
                }
            })
        }
        function plot_trans_graph() {
            $('#trns-booking-graph1').html('');
            $('#trns-booking-graph2').html('');
            $('#trns-booking-graph3').html('');

            //  overall summary
            if (Number($('#tkt_booked').text()) > 0 || Number($('#tkt_pb_blocked').text()) > 0 || Number($('#tkt_canceled').text()) > 0) {
                chart_data = [
                    {label: "Booked", data: $('#tkt_booked').text()},
                    //{label: "Phone Booked", data: $('#tkt_pb_booked').text()},
                    {label: "Phone Book Blocked", data: $('#tkt_pb_blocked').text()},
                    {label: "Cancelled", data: $('#tkt_canceled').text()},
                    //{label: "Phone Book Cancelled", data: $('#tkt_pb_canceled').text()},
                ];
                $('#trns-booking-list-graph').removeClass('hidden');
                $.plot('#trns-booking-graph1', chart_data, {
                    grid: {clickable: true, hoverable: true},
                    series: {
                        pie: {show: true, radius: 3 / 4, label: {show: false}, innerRadius: 0}
                    },
                    tooltip: true,
                    legend: {show: true},
                    tooltipOpts: {content: "%p.0%, %s", shifts: {x: 20, y: 0}, defaultTheme: false}
                });
            }
            //  group wise booked
            if ($(book_summary).length > 0) {
                $.plot('#trns-booking-graph2', book_summary, {
                    grid: {clickable: true, hoverable: true},
                    series: {
                        pie: {show: true, radius: 3 / 4, label: {show: false}, innerRadius: 0}
                    },
                    legend: {show: false},
                    tooltip: true,
                    tooltipOpts: {content: "%p.0%, %s", shifts: {x: 20, y: 0}, defaultTheme: false}
                });
            }

            //  group wise cancelled
            if ($(cancel_summary).length > 0) {
                $.plot('#trns-booking-graph3', cancel_summary, {
                    grid: {clickable: true, hoverable: true},
                    series: {
                        pie: {show: true, radius: 3 / 4, label: {show: false}, innerRadius: 0}
                    },
                    legend: {show: false},
                    tooltip: true,
                    tooltipOpts: {content: "%p.0%, %s", shifts: {x: 20, y: 0}, defaultTheme: false}
                });
            }
        }

        function clearReport() {
            $('#gru_users').val('');
            $('#date_from').val('');
            $('#date_to').val('');
            $('#rpt_lst').html('');
            $('.inp_error').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();
        }

        function exportConsolidateExcel() {
            document.usr_sum_rpt.target = "_blank";
            $('#export').val(1);
            document.usr_sum_rpt.submit();
            return;
        }

    </script>
{/literal}
