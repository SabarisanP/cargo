<div class="brand_top">
    <h3>Cancellation Report</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCancellationExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
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

                                                <form id='cancel_rpt' method="post" name="cancel_rpt" action="report/cancellation-report-list" onsubmit="return false">
                                                    <div class="row">   

                                                        <div class="form-group col-md-2">
                                                            <label for="cancel_rpt_date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="from" class="form-control sdate" id="cancel_rpt_date_from" readonly="true" placeholder="Date From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="to" class="form-control sdate" id="cancel_rpt_date_to" readonly="true" placeholder="Date To">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>   
                                                        <div class="form-group col-md-2">
                                                            <label  for="cancel_rpt_date_to">Date Option</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="cancel_rpt_date_opt" name="date_option"  class="form-control" >
                                                                    <option value="2">Cancelled Date</option> 
                                                                    <option value="0">Booked Date</option>
                                                                    <option value="1">Travel Date</option>                                                                    
                                                                </select>       
                                                            </div>
                                                        </div>
                                                       
                                                    </div>

                                                    <div class="row">  

                                                        <div class="form-group col-md-4">
                                                            <label  for="cancel_rpt_date_to">Schedule</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="cancel_rpt_schedule" name="schedule_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Schedules</option>
                                                                    {foreach item=schedule from=$active_schedules}
                                                                        <option value="{$schedule.code}">{$schedule.name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="cancel_rpt_date_to">User Group</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="cancel_rpt_user_group" name="group_code"  class="form-control" >
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
                                                            <label  for="cancel_rpt_date_to">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="cancel_rpt_from_station" name="from_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="cancel_rpt_date_to">To Station</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="cancel_rpt_to_station" name="to_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label  for="cancel_rpt_date_to">Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="cancel_rpt_user_code" name="user_code"  class="form-control" >
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
                                                                <button class="btn btn-success" type="button"  onclick="searchCancelBooking();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearCancelReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="cancel_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden noprint" id="cancel-booking-list-graph">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <!--<div class="col-sm-4">
                                        <div class="bold" align="center">Overall Summary</div>
                                        <div id="cancel-booking-graph1"  style="height:150px;"></div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="bold" align="center">Group Wise Bookings</div>
                                        <div id="cancel-booking-graph2"  style="height:150px;"></div>
                                    </div>-->
                                    <div class="col-sm-offset-4 col-sm-4" align="center">
                                        <div class="bold">Group Wise Cancells</div>
                                        <div id="cancel-booking-graph3"  style="height:150px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="cancel-booking-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="cancel-booking-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_cancellation_downloader" id="ifrm_cancellation_downloader" style="display:none"></iframe>  
<script>
    var usergroups = {$groupusers|json_encode};
</script>    

{literal}
    <script>
        $('#cancel_rpt_date_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-3m',
            endDate: '+3m',
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#cancel_rpt_date_to').datepicker('setStartDate', e.date);
            $("#cancel_rpt_date_to").datepicker("setEndDate", end)
        });
        $('#cancel_rpt_date_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            endDate: '+3m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#cancel_rpt_date_from').datepicker('setStartDate', start);
            $('#cancel_rpt_date_from').datepicker('setEndDate', e.date)
        });

        /*$('#cancel_rpt_user_group').change(function() {
         var gcode = $(this).val();
         var html = '<option value="NA">All</option>';
         $(usergroups.users).each( function(k, user) {
         if(gcode=='NA' || gcode==user.groupcode)
         html += '<option value="'+user.code+'">'+user.name+'</option>';       
         });
         $('#cancel_rpt_user_code').html(html);
         });*/

        function exportCancellationExcel() {
            document.cancel_rpt.target = "ifrm_cancellation_downloader";
            $('#export').val(1);
            document.cancel_rpt.submit();
            return;
        }

        function searchCancelBooking() {
            $('#cancel-booking-list').html('');
            var data = {};
            data.date_option = $('#cancel_rpt_date_opt').val();
            data.from = $('#cancel_rpt_date_from').val();
            data.to = $('#cancel_rpt_date_to').val();
            data.schedule_code = $('#cancel_rpt_schedule').val();
            data.from_code = $('#cancel_rpt_from_station').val();
            data.to_code = $('#cancel_rpt_to_station').val();
            data.group_code = $('#cancel_rpt_user_group').val();
            data.user_code = $('#cancel_rpt_user_code').val();
            data.tagCode = $('#tag_filter').val();

            var err = 0;
            $('#cancel_rpt_date_opt, #cancel_rpt_date_from, #cancel_rpt_date_to').removeClass('inp_error');

            if (data.date_option == '') {
                $('#cancel_rpt_date_opt').addClass('inp_error');
                err++;
            }

            if (data.from == '') {
                $('#cancel_rpt_date_from').addClass('inp_error');
                err++;
            }

            if (data.from == '') {
                if (data.to == '') {
                    $('#cancel_rpt_date_to').addClass('inp_error');
                    err++;
                }
            }

            if (data.from != '') {
                if (data.to == '') {
                    $('#cancel_rpt_date_to').removeClass('inp_error');
                    var d = new Date();

                    var month = d.getMonth() + 1;
                    var day = d.getDate();

                    var output = d.getFullYear() + '-' +
                            (('' + month).length < 2 ? '0' : '') + month + '-' +
                            (('' + day).length < 2 ? '0' : '') + day;

                    data.to = output;
                    $('#cancel_rpt_date_to').val(output);
                }
            }

            if (err > 0) {
                $('#cancel_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#cancel_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#cancel_rpt_action_state').show();
                return false;
            } else {
                $('#cancel_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#cancel_rpt_action_state').html('');
                $('#cancel_rpt_action_state').hide();
            }
            var html = "";
            $('#cancel_rpt_date_to').removeClass('inp_error');
            $('#cancel-booking-list-container').removeClass('hidden');
            $('#cancel-booking-list').html(loading_popup);
            $('#cancel-booking-graph1').html('')
            $('#cancel-booking-list-graph').addClass('hidden');
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/cancellation-report-list",
                data: data,
                success: function (response) {
                    $('#cancel-booking-list').html(response);
                    $('#excl_cons').show();
                    plot_trans_graph(); //  init graphs
                    $("html, body").animate({
                        scrollTop: $('#cancel-booking-list-graph').offset().top - 35
                    }, "slow");
                }
            })
        }
        function plot_trans_graph() {
            //$('#cancel-booking-graph1').html('');
            //$('#cancel-booking-graph2').html('');
            $('#cancel-booking-graph3').html('');
            
            /*
            //  overall summary
            if (Number($('#tkt_booked').text()) > 0 || Number($('#tkt_pb_blocked').text()) > 0 || Number($('#tkt_canceled').text()) > 0) {
                chart_data = [
                    //{label: "Booked", data: $('#tkt_booked').text()},
                    //{label: "Phone Booked", data: $('#tkt_pb_booked').text()},
                    //{label: "Phone Book Blocked", data: $('#tkt_pb_blocked').text()},
                    {label: "Cancelled", data: $('#tkt_canceled').text()},
                    {label: "Phone Book Cancelled", data: $('#tkt_pb_canceled').text()},
                ];
                
                $.plot('#cancel-booking-graph1', chart_data, {
                    grid: {clickable: true, hoverable: true},
                    series: {
                        pie: {show: true, radius: 3 / 4, label: {show: false}, innerRadius: 0}
                    },
                    tooltip: true,
                    legend: {show: true},
                    tooltipOpts: {content: "%p.0%, %s", shifts: {x: 20, y: 0}, defaultTheme: false}
                });
            } */
            //  group wise booked
            /*if ($(book_summary).length > 0) {
                $.plot('#cancel-booking-graph2', book_summary, {
                    grid: {clickable: true, hoverable: true},
                    series: {
                        pie: {show: true, radius: 3 / 4, label: {show: false}, innerRadius: 0}
                    },
                    legend: {show: true},
                    tooltip: true,
                    tooltipOpts: {content: "%p.0%, %s", shifts: {x: 20, y: 0}, defaultTheme: false}
                });
            }*/

            //  group wise cancelled
            $('#cancel-booking-list-graph').removeClass('hidden');
            if ($(cancel_summary).length > 0) {
                $.plot('#cancel-booking-graph3', cancel_summary, {
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

        function clearCancelReport() {
            $('#cancel_rpt_date_from').val('');
            $('#cancel_rpt_date_to').val('');
            $('#cancel-booking-list-container').addClass('hidden');
            $('#cancel-booking-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#cancel_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#cancel_rpt_action_state').html('');
            $('#cancel_rpt_action_state').hide();
            $('#cancel-booking-list-graph').hide();
            $('#cancel_rpt_schedule').val('NA');
            $('#cancel_rpt_from_station').val('NA');
            $('#cancel_rpt_to_station').val('NA');
            $('#cancel_rpt_user_group').val('NA');
            $('#cancel_rpt_user_code').val('NA');
            $('#cancel_rpt_date_opt').val(2);
            $('#excl_cons').hide();
        }
       


    </script>
{/literal}
