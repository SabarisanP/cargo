<div class="brand_top">
    <h3>Consolidated Booking Report</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportConsolidateExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div>
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

                                                <form id='con_bk_rpt' method="post" name="con_bk_rpt" action="report/consolidated-booking-report-list" onsubmit="return false">
                                                    <div class="row">   

                                                        <div class="form-group col-md-2">
                                                            <label for="trns_rpt_date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="from" class="form-control sdate" id="trns_rpt_date_from" readonly="true" placeholder="Date From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="to" class="form-control sdate" id="trns_rpt_date_to" readonly="true" placeholder="Date To">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>   
                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">Date Option</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_date_opt" name="date_option"  class="form-control" >
                                                                    <option value="0">Transaction Date</option>
                                                                    <option value="1">Travel Date</option>                                                                    
                                                                </select>       
                                                            </div>
                                                        </div>
                                                       
                                                    </div>

                                                    <div class="row">  

                                                        <div class="form-group col-md-4">
                                                            <label  for="trns_rpt_date_to">Schedule</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_schedule" name="schedule_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Schedules</option>
                                                                    {foreach item=schedule from=$active_schedules}
                                                                        <option value="{$schedule.code}">{$schedule.name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">User Group</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_user_group" name="group_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Group/Roles</option>
                                                                    {foreach name=o item=row from=$groupusers.groups}                                                                    
                                                                        <option  value="{$row->code}">{$row->name}</option>                                                                    
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>
                                                    </div>        
                                                    <div class="row">          

                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_from_station" name="from_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">To Station</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="trns_rpt_to_station" name="to_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_user_code" name="user_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Users</option>
                                                                    {foreach name=o item=row from=$groupusers.users}                                                                        
                                                                        <option  value="{$row.code}">{$row.name}</option>                                                                      
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label  for="tag_filter">Tags</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="tag_filter" name="tagCode"  class="form-control" >                                                                    
                                                                        <option value="">Select Tags</option>
                                                                        {foreach from=$tags item=row}
                                                                                <option value="{$row->code}">{$row->name}</option>
                                                                        {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>
                                                                
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button"  onclick="searchTrnsBooking();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearTrnsReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="trns_rpt_action_state"></div>
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
                                        <div class="bold" align="center">Group Wise Bookings</div>
                                        <div id="trns-booking-graph2"  style="height:150px;"></div>
                                    </div>  
                                    <div class="col-sm-4" align="center">
                                        <div class="bold">Group Wise Cancells</div>
                                        <div id="trns-booking-graph3"  style="height:150px;"></div>
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
<iframe name="ifrm_consolidate_downloader" id="ifrm_consolidate_downloader" style="display:none"></iframe>  
<script>
    var usergroups = {$groupusers|json_encode};
</script>    

{literal}
    <script>
        
        $('#trns_rpt_date_from').datepicker({
            format: 'yyyy-mm-dd',
            startDate: '-3m',
            endDate: "+3m",
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {            
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 10));
            $('#trns_rpt_date_to').datepicker('setStartDate', e.date);
            $("#trns_rpt_date_to").datepicker("setEndDate", end);
        });
        $('#trns_rpt_date_to').datepicker({
            format: 'yyyy-mm-dd',
            startDate: '-3m',            
            endDate: "+3m",
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 10));
            $('#trns_rpt_date_from').datepicker('setStartDate', start);
            $('#trns_rpt_date_from').datepicker('setEndDate', e.date);
        });
        
        function clearTrnsReport() {
            $('#trns_rpt_date_from').val('');
            $('#trns_rpt_date_to').val('');
            
            var fDate = new Date();
            var start = new Date(fDate.setDate(fDate.getDate() - 93));
            var tDate = new Date();
            var end = new Date(tDate.setDate(tDate.getDate() + 93));
            $('#trns_rpt_date_from').datepicker('setStartDate', start);
            $('#trns_rpt_date_from').datepicker('setEndDate', end);
           
            $('#trns_rpt_date_to').datepicker('setStartDate', start);
            $('#trns_rpt_date_to').datepicker('setEndDate', end);
            
            //$('#trns_rpt_date_from').datepicker('clearDate');
            //$('#trns_rpt_date_to').datepicker('clearDates');
            
            $('#trns-booking-list-container').addClass('hidden');
            $('#trns-booking-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#trns_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#trns_rpt_action_state').html('');
            $('#trns_rpt_action_state').hide();
            $('#trns-booking-list-graph').hide();
            $('#trns_rpt_schedule').val('NA');
            $('#trns_rpt_from_station').val('NA');
            $('#trns_rpt_to_station').val('NA');
            $('#trns_rpt_user_group').val('NA');
            $('#trns_rpt_user_code').val('NA');
            $('#excl_cons').hide();
        }

        function exportConsolidateExcel() {
            document.con_bk_rpt.target = "ifrm_consolidate_downloader";
            $('#export').val(1);
            document.con_bk_rpt.submit();
            return;
        }

        function searchTrnsBooking() {
            $('#trns-booking-list').html('');
            var data = {};
            data.date_option = $('#trns_rpt_date_opt').val();
            data.from = $('#trns_rpt_date_from').val();
            data.to = $('#trns_rpt_date_to').val();
            data.schedule_code = $('#trns_rpt_schedule').val();
            data.from_code = $('#trns_rpt_from_station').val();
            data.to_code = $('#trns_rpt_to_station').val();
            data.group_code = $('#trns_rpt_user_group').val();
            data.user_code = $('#trns_rpt_user_code').val();
            data.tagCode = $('#tag_filter').val();

            var err = 0;
            $('#trns_rpt_date_opt, #trns_rpt_date_from, #trns_rpt_date_to').removeClass('inp_error');

            if (data.date_option == '') {
                $('#trns_rpt_date_opt').addClass('inp_error');
                err++;
            }

            if (data.from == '') {
                $('#trns_rpt_date_from').addClass('inp_error');
                err++;
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
                    
                    var f = data.from.split('-');
                    var a = moment([d.getFullYear(), month, day]);
                    var b = moment([f[0], f[1], f[2]]);
                    var t = a.diff(b, 'days');
                    if(t>10){
                        err++;
                    }else {                    
                        data.to = output;
                        $('#trns_rpt_date_to').val(output);
                    }
                }
            }
            
            if (data.to == '') {
                $('#trns_rpt_date_to').addClass('inp_error');
                err++;
            }
            
            if (data.from != '' && data.to != '') {
                var f = data.from.split('-');
                var a = moment([f[0], f[1], f[2]]);
                
                var e = data.to.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if(t>10) {
                    $('#trns_rpt_date_to').addClass('inp_error');
                    $('#trns_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#trns_rpt_action_state').html('Date range should be 10 days or less');
                    $('#trns_rpt_action_state').show();
                    return false;
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
                url: base_url + "report/consolidated-booking-report-list",
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
                    legend: {show: true},
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
                    legend: {show: true},
                    tooltip: true,
                    tooltipOpts: {content: "%p.0%, %s", shifts: {x: 20, y: 0}, defaultTheme: false}
                });
            }
        }

        


    </script>
{/literal}
