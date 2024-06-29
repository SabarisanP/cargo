<div class="brand_top">
    <h3>After Departure Booking Report</h3> 
</div>
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
                                            <form id="after_departure_form" name="after_departure_form" method="post" onsubmit="return false">
                                            <div class="row">   
                                                <div class="form-group col-md-2">
                                                    <label for="after_departure_from">From Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="from" class="form-control sdate" id="after_departure_from" readonly="true" placeholder="Date From">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <label for="after_departure_to">To Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="to" class="form-control sdate" id="after_departure_to" readonly="true" placeholder="Date To">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <label  for="after_departure_user_group">User Group</label>
                                                    <div class="input-group col-md-12">
                                                        <select id="after_departure_user_group" name="group_code"  class="form-control" >
                                                            <option value='NA' selected="">All Group/Roles</option>
                                                            {foreach name=o item=row from=$groupusers.groups}
                                                                <option  value="{$row->code}">{$row->name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-4">
                                                    <label  for="after_departure_schedule">Schedule</label>
                                                    <div class="input-group col-md-12">
                                                        <select id="after_departure_schedule" name="schedule_code"  class="form-control" >
                                                            <option value='NA' selected="">All Schedules</option>
                                                            {foreach item=schedule from=$active_schedules}
                                                                <option value="{$schedule.code}">{$schedule.name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
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
                                                    <label for="">&nbsp;</label>
                                                    <div class="input-group">
                                                        <input type="hidden" name="export" id="export" value="">
                                                        <button class="btn btn-success" type="button"  onclick="getAfterDeparture()">Generate</button>&nbsp;
                                                        <button type="button" class="btn btn-default btn-clear" onclick="clearAfterDeparture()">Clear</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="after_departure_state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row hidden" id="after-departure-graph-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="col-md-4" id="after-departure-graph-1" style="height: 250px;"></div> 
                                <div class="col-md-4" id="after-departure-graph-2" style="height: 250px;"></div>
                                <div class="col-md-4" id="after-departure-graph-3" style="height: 250px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row hidden" id="after-departure-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="after-departure-list"></div>                                    
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
        $('#after_departure_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            startDate: '-3m',
            endDate: '+3m',
            autoclose: true,
            changeMonth: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#after_departure_to').datepicker('setStartDate', e.date);
            $("#after_departure_to").datepicker("setEndDate", end)
        });
        $('#after_departure_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            endDate: '+3m',
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#after_departure_from').datepicker('setStartDate', start);
            $('#after_departure_from').datepicker('setEndDate', e.date)
        });

        function getAfterDeparture() {
            $('#after-departure-list').html('');
            var data = {};
            data.from = $('#after_departure_from').val();
            data.to = $('#after_departure_to').val();
            data.schedule_code = $('#after_departure_schedule').val();
            data.group_code = $('#after_departure_user_group').val();
            data.tagCode = $('#tag_filter').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.from == '') {
                $('#after_departure_from').addClass('inp_error');
                err++;
            }
            
            if (data.to == '') {
                $('#after_departure_to').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#after_departure_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#after_departure_state').html('Please enter/select the values in the field that are marked in red');
                $('#after_departure_state').show();
                return false;
            } else {
                $('#after_departure_state').removeClass('alert-success').removeClass('alert-danger');
                $('#after_departure_state').html('');
                $('#after_departure_state').hide();
            }
            $('#after-departure-list-container').removeClass('hidden');
            $('#after-departure-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/after-departure-booking-report-list",
                data: data,
                success: function (response) {
                    $('#after-departure-list').html(response);
                    $('#after-departure-graph-container').removeClass('hidden');
                    renderChart('after-departure-graph-1', 'Channel Wise Summary', device);
                    renderChart('after-departure-graph-2', 'Route Wise Summary', route);
                    renderChart('after-departure-graph-3', 'Group Wise Summary', group);
                }
            });
        }
        
        function clearAfterDeparture() {
            $('#after_departure_from').val('');
            $('#after_departure_to').val('');
            $('#after_departure_schedule').val('NA');
            $('#after_departure_user_group').val('NA');
            $('#after-departure-list-container').addClass('hidden');
            $('#after-departure-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#after_departure_state').removeClass('alert-success').removeClass('alert-danger');
            $('#after_departure_state').html('');
            $('#after_departure_state').hide();
            $('#after-departure-graph-container').hide();
        }
        
        function renderChart( div, title, data){
            var obj = [];
            $.each(data, function(i, val) {
                obj.push({
                    name: i,
                    y: val
                });
            });
            Highcharts.chart( div, {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: title
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
                            enabled: false,
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
        }
    </script>
{/literal}
