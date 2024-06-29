<div class="brand_top">
    <h3>Travel Report</h3> 
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <!-- PAGE HEADER-->
                    <div class="row">                        
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">                                        
                                        <div class="">
                                                <div id="search-panel">                                         
                                                    
                                                    <form id='test'>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="trns_rpt_date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="trns_rpt_date_from" class="form-control sdate" id="trns_rpt_date_from" readonly="true" placeholder="Date From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="trns_rpt_date_to" class="form-control sdate" id="trns_rpt_date_to" readonly="true" placeholder="Date To">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>                                                       
                                                        
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <button class="btn btn-success" type="button"  onclick="searchTrnsBooking();">Generate</button>
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearTrnsReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                        
                                                    </form>                                                   
                                                </div>
                                                <br class="clear_fix_both">
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="trns_rpt_action_state"></div>
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
                                        <div class="col-lg-4">
                                            <div class="bold" align="center">Overall Summary</div>
                                            <div id="trns-booking-graph1"  style="height:150px;width:300px" class="pull-left"></div>
                                        </div>
                                         <div class="col-lg-4">
                                            <div class="bold" align="center">Group Wise Bookings</div>
                                            <div id="trns-booking-graph2"  style="height:150px;width:300px" class="pull-left"></div>
                                        </div>  
                                         <div class="col-lg-4" align="center">
                                            <div class="bold">Group Wise Cancells</div>
                                            <div id="trns-booking-graph3"  style="height:150px;width:300px" class="pull-left"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
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
{literal}
<script>
$('#trns_rpt_date_from').datepicker({
    todayHighlight: true,
    format: 'yyyy-mm-dd',
    autoclose: true,
    changeMonth: true,
}).on('changeDate', function(e) {
    var fDate = new Date(e.date);
    var end = new Date(fDate.setDate(fDate.getDate() + 365));
    $('#trns_rpt_date_to').datepicker('setStartDate', e.date);
    $("#trns_rpt_date_to").datepicker("setEndDate", end)
});
$('#trns_rpt_date_to').datepicker({
    todayHighlight: true,
    startDate: '-0m',
    format: 'yyyy-mm-dd',
    maxDate: "+365D",
    autoclose: true
}).on('changeDate', function(e) {
    $('#trns_rpt_date_from').datepicker('setEndDate', e.date)
});

function searchTrnsBooking() {
    $('#trns-booking-list').html('');
    var data = {};
    ///data.date_option = $('#trns_rpt_date_opt').val();
    data.from = $('#trns_rpt_date_from').val();
    data.to = $('#trns_rpt_date_to').val();

    var err = 0;
    $('#trns_rpt_date_from, #trns_rpt_date_to').removeClass('inp_error');
    
    /*if (data.date_option == '') {
        $('#trns_rpt_date_opt').addClass('inp_error');
        err++;
    } */
    
    if (data.from == '') {
        $('#trns_rpt_date_from').addClass('inp_error');
        err++;
    } 

    if (data.from == '') {
        if (data.to == '') {
            $('#trns_rpt_date_to').addClass('inp_error');
            err++;
        }
    }

    if (data.from != '') {
        if (data.to == '') {
            $('#trns_rpt_date_to').removeClass('inp_error');
            var d = new Date();

            var month = d.getMonth() + 1;
            var day = d.getDate();

            var output = d.getFullYear() + '-' +
                    (('' + month).length < 2 ? '0' : '') + month + '-' +
                    (('' + day).length < 2 ? '0' : '') + day;

            data.to = output;
            $('#trns_rpt_date_to').val(output);
        }
    }

    if (err > 0) {
        $('#trns_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#trns_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
        $('#trns_rpt_action_state').show();
        return false;
    } else {
        $('#trns_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#trns_rpt_action_state').html('');
        $('#trns_rpt_action_state').hide();
    }
    var html = "";
    $('#trns_rpt_date_to').removeClass('inp_error');
    $('#trns-booking-list-container').removeClass('hidden');
    $('#trns-booking-list').html(loading_popup);
    $('#trns-booking-graph1').html('')
    $('#trns-booking-list-graph').addClass('hidden');
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "report/travel-report-list",
        data: data,
        success: function(response) {
            $('#trns-booking-list').html(response);
            plot_trans_graph(); //  init graphs
        }
    })
}
function plot_trans_graph() {
    //  overall summary
    chart_data = [
                    {label: "Booked", data: $('#tkt_booked').text()},
                    {label: "Phone Booked", data: $('#tkt_pb_booked').text()},
                    {label: "Phone Book Blocked", data: $('#tkt_pb_blocked').text()},
                    {label: "Cancelled", data: $('#tkt_canceled').text()},
                    {label: "Phone Book Cancelled", data: $('#tkt_pb_canceled').text()},
                ];
    $('#trns-booking-list-graph').removeClass('hidden');
    $.plot('#trns-booking-graph1', chart_data, {
           grid: { clickable: true, hoverable: true },
                series: {
                    pie: { show: true, radius: 3/4, label: { show: false },  innerRadius: 0.35 }
                },
                tooltip: true,
                tooltipOpts: {  content: "%p.0%, %s",   shifts: { x: 20, y: 0 }, defaultTheme: false  }
    });
    
    //  group wise booked
    if(book_summary.length>0 ) {
        $.plot('#trns-booking-graph2', book_summary, {
                grid: { clickable: true, hoverable: true },
                series: {
                    pie: { show: true, radius: 3/4, label: { show: false },  innerRadius: 0.35 }
                },
                tooltip: true,
                tooltipOpts: {  content: "%p.0%, %s",   shifts: { x: 20, y: 0 }, defaultTheme: false  }
        });
    }
    
    //  group wise cancelled
    if(cancel_summary.length>0 ) {
        $.plot('#trns-booking-graph3', cancel_summary, {
                grid: { clickable: true, hoverable: true },
                series: {
                    pie: { show: true, radius: 3/4, label: { show: false },  innerRadius: 0.35 }
                },
                tooltip: true,
                tooltipOpts: {  content: "%p.0%, %s",   shifts: { x: 20, y: 0 }, defaultTheme: false  }
        });
    }
}

function clearTrnsReport() {
    $('#trns_rpt_date_from').val('');
    $('#trns_rpt_date_to').val('');
    $('#trns-booking-list-container').addClass('hidden');
    $('#trns-booking-list').html('');
    $('.inp_error').removeClass('inp_error');
    $('#trns_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
    $('#trns_rpt_action_state').html('');
    $('#trns_rpt_action_state').hide();
    $('#trns-booking-list-graph').hide();
}


</script>
{/literal}