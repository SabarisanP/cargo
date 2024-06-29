<div class="brand_top">
    <h3>Transaction Report</h3> 
    <div class="text-right noprint" id="exc-tr" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
            {if $action_rights['DOWNLOAD-TALLY-EXCEL']>0}
            <button class="btn btn-default" onclick="exportTalyExcel()"><i class="fa fa-download fa-lg"></i>Tally Excel</button>
            {/if}
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div> 
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
                                                <form id='mytrans_form' name="trans_form" method="post"  onsubmit="return false">
                                                <div class="row">   
                                                    <div class="form-group col-md-2">
                                                        <label for="trns_rpt_date_from">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="from" class="form-control sdate" id="cons_rpt_date_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="cons_rpt_date_to">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="to" class="form-control sdate" id="cons_rpt_date_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>   
                                                    <div class="form-group col-md-2">
                                                        <label  for="trns_rpt_date_to">Date Option</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="cons_rpt_date_opt" name="date_option"  class="form-control" >                                                                    
                                                                <option value="0">Transaction Date</option>
                                                                <option value="1">Travel Date</option>
                                                            </select>     
                                                        </div>
                                                    </div>
                                                                                   
                                                    <br>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="cons_rpt_action_state"></div>
                                                </div>

                                                <div class="row">  

                                                    <div class="form-group col-md-4">
                                                        <label  for="trns_rpt_date_to">Schedule</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="cons_trns_rpt_schedule" name="schedule_code"  class="form-control" >
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
                                                            <select id="cons_trns_rpt_user_group" name="group_code"  class="form-control" >
                                                                <option value='NA' selected="">All Group/Roles</option>
                                                                {foreach name=o item=row from=$groupusers.groups}                                                                    
                                                                    <option  value="{$row->code}">{$row->name}</option>                                                                    
                                                                {/foreach}
                                                            </select>       
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="cons_rpt_date_to">Group By</label>
                                                        <div class="input-group">
                                                            <select id="cons_rpt_group_by_2" name="group_by_2"  class="form-control" >
                                                                <option value="">Select</option>
                                                                <option value="1">Trip</option>
                                                                <option value="2">User Group</option>
                                                            </select>    
                                                        </div>
                                                    </div>  
                                                </div>        
                                                <div class="row">          
                                                    <div class="form-group col-md-2">
                                                        <label  for="trns_rpt_date_to">From Station</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="cons_trns_rpt_from_station" name="from_code"  class="form-control" >
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
                                                            <select id="cons_trns_rpt_to_station" name="to_code"  class="form-control" >
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
                                                            <select id="cons_trns_rpt_user_code" name="user_code"  class="form-control" >
                                                                <option value='NA' selected="">All Users</option>
                                                                {foreach name=o item=row from=$entity}
                                                                    <optgroup label="{$row['name']}">
                                                                        {foreach name=o item=usr from=$row["userlist"]}
                                                                            <option value='{$usr->code}'>{$usr->name}</option>
                                                                        {/foreach}
                                                                    </optgroup>
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
                                                        <label for="cons_rpt_date_to">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="searchTransBooking()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearTransReport()">Clear</button>
                                                        </div>
                                                    </div>
                                                    
                                                </div>
                                                </form>
                                            </div><!--row end-->
                                        </div><!--content end-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                                                            
                    <div class="row hidden" id="cons-booking-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="cons-booking-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                                           
                </div>                    
            </div>
        </div>            
    </div>
    <iframe name="ifrm_trans_downloader" id="ifrm_trans_downloader" style="display:none"></iframe>                                                         
    {literal}
        <script>
            $('#cons_rpt_date_from').datepicker({
                //     todayHighlight: true,
                format: 'yyyy-mm-dd',
                autoclose: true,
                changeMonth: true,
            }).on('changeDate', function (e) {
            });
            $('#cons_rpt_date_to').datepicker({
                todayHighlight: true,
                format: 'yyyy-mm-dd',
                autoclose: true
            }).on('changeDate', function (e) {
            });

            function searchTransBooking() {
                $('#cons-booking-list').html('');
                var data = {};
                data.date_option = $('#cons_rpt_date_opt').val();
                data.from = $('#cons_rpt_date_from').val();
                data.to = $('#cons_rpt_date_to').val();
                data.schedule_code = $('#cons_trns_rpt_schedule').val();
                data.from_code = $('#cons_trns_rpt_from_station').val();
                data.to_code = $('#cons_trns_rpt_to_station').val();
                data.group_code = $('#cons_trns_rpt_user_group').val();
                data.user_code = $('#cons_trns_rpt_user_code').val();

                data.group_by_2 = $('#cons_rpt_group_by_2').val();
                data.group_by_3 = $('#cons_rpt_group_by_3').val();
                data.tagCode = $('#tag_filter').val();

                var err = 0;
                $('#trans_rpt', '#cons_rpt_date_opt, #cons_rpt_date_from, #cons_rpt_date_to').removeClass('inp_error');


                if (data.date_option == '') {
                    $('#cons_rpt_date_opt').addClass('inp_error');
                    err++;
                }

                if (data.from == '') {
                    $('#cons_rpt_date_from').addClass('inp_error');
                    err++;
                }

                if (data.from == '') {
                    if (data.to == '') {
                        $('#cons_rpt_date_to').addClass('inp_error');
                        err++;
                    }
                }

                if (data.from != '') {
                    if (data.to == '') {
                        $('#cons_rpt_date_to').removeClass('inp_error');
                        var d = new Date();

                        var month = d.getMonth() + 1;
                        var day = d.getDate();

                        var output = d.getFullYear() + '-' +
                                (('' + month).length < 2 ? '0' : '') + month + '-' +
                                (('' + day).length < 2 ? '0' : '') + day;

                        data.to = output;
                        $('#cons_rpt_date_to').val(output);
                    }
                }

                if (err > 0) {
                    $('#cons_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#cons_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                    $('#cons_rpt_action_state').show();
                    return false;
                } else {
                    $('#cons_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                    $('#cons_rpt_action_state').html('');
                    $('#cons_rpt_action_state').hide();
                }
                var html = "";
                $('#cons_rpt_date_to').removeClass('inp_error');
                $('#cons-booking-list-container').removeClass('hidden');
                $('#cons-booking-list').html(loading_popup);
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "report/transaction-report-list",
                    data: data,
                    success: function (response) {
                        $('#cons-booking-list').html(response);
                        $('#exc-tr').show();
                        renderChart('trans-report-graph-1', 'Channel Wise Summary', device);
                    }
                })
            }

            function clearTransReport() {
                $('#cons_rpt_date_from').val('');
                $('#cons_rpt_date_to').val('');
                $('#cons-booking-list-container').addClass('hidden');
                $('#cons-booking-list').html('');
                $('.inp_error').removeClass('inp_error');
                $('#cons_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#cons_rpt_action_state').html('');
                $('#cons_rpt_action_state').hide();
                $('#cons_trns_rpt_schedule').val('NA');
                $('#cons_trns_rpt_from_station').val('NA');
                $('#cons_trns_rpt_to_station').val('NA');
                $('#cons_trns_rpt_user_group').val('NA');
                $('#cons_trns_rpt_user_code').val('NA');
                $('#cons_rpt_group_by_2').val('');
                $('#exc-tr').hide();
            }
            
            function exportTransExcel() {
                document.trans_form.action = "report/transaction-report-list";
                document.trans_form.target = "ifrm_trans_downloader";
                $('#export').val(1);
                document.trans_form.submit();
                return;
            }
            
            function exportTalyExcel() {
                document.trans_form.action = "report/transaction-report-list-tally";
                document.trans_form.target = "ifrm_trans_downloader";
                $('#export').val(1);
                document.trans_form.submit();
                return;
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
                        text: title,
                        style: {
                            fontSize: "16px",
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

