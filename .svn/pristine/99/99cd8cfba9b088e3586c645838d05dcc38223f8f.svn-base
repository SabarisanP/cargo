<div class="brand_top">
    <h3>Revenue Report</h3> 
    <div class="text-right noprint" id="pay-tr" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="downloadRevenueReport()"><i class="fa fa-download fa-lg"></i> Download</button>
            <button class="btn btn-default hide" onclick="downloadRevenueReportSummary()"><i class="fa fa-download fa-lg"></i> Detailed List</button>
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
                                            <form id='pays_form' name="revenue_rpt_form" method="post" action="report/revenue-report-list" onsubmit="return false" target="_blank">
                                                <div class="row">   
                                                    <div class="form-group col-md-2">
                                                        <label for="revenue_rpt_date_from">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="from" class="form-control sdate" id="revenue_rpt_date_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="revenue_rpt_date_to">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="to" class="form-control sdate" id="revenue_rpt_date_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>   
                                                    <div class="form-group col-md-2">
                                                        <label  for="revenue_rpt_date_to">Date Option</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="revenue_rpt_date_opt" name="date_option"  class="form-control" >                                                                    
                                                                <option value="1">Travel Date</option>
                                                                <option value="0">Transaction Date</option>
                                                            </select>     
                                                        </div>
                                                    </div>
                                                    
                                                    <br>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="revenue_rpt_action_state"></div>
                                                </div>

                                                <div class="row">  

                                                    <div class="form-group col-md-4">
                                                        <label  for="revenue_trns_rpt_schedule">Schedule</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="revenue_trns_rpt_schedule" name="schedule_code"  class="form-control" >
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
                                                        <label for="cons_rpt_date_to">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="pdf" id="pdf" value="">                                                            
                                                            <button class="btn btn-success" type="button"  onclick="getRevenueReport()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearRevenueReport()">Clear</button>
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

                <div class="row hidden" id="revenue-report-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="revenue-report-list"></div>                                    
                            </div>
                        </div>
                    </div>
                </div>

            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_pays_downloader" id="ifrm_revenue_downloader" style='display:none'></iframe>                                                         
{literal}
    <script>
        $('#revenue_rpt_date_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
        });
        $('#revenue_rpt_date_to').datepicker({
            todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function (e) {
        });

        function getRevenueReport() {
            $('#pays-booking-list').html('');
            var data = {};
            data.date_option = $('#revenue_rpt_date_opt').val();
            data.from = $('#revenue_rpt_date_from').val();
            data.to = $('#revenue_rpt_date_to').val();
            data.schedule_code = $('#revenue_trns_rpt_schedule').val();
            //data.user_code = $('#revenue_trns_rpt_user_code').val();   
            data.tagCode = $('#tag_filter').val();
            
            var err = 0;
            $('#revenue_rpt_date_opt, #revenue_rpt_date_from, #revenue_rpt_date_to').removeClass('inp_error');

            if (data.date_option == '') {
                $('#revenue_rpt_date_opt').addClass('inp_error');
                err++;
            }

            if (data.from == '') {
                $('#revenue_rpt_date_from').addClass('inp_error');
                err++;
            }

            if (data.from == '') {
                if (data.to == '') {
                    $('#revenue_rpt_date_to').addClass('inp_error');
                    err++;
                }
            }

            if (err > 0) {
                $('#revenue_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#revenue_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#revenue_rpt_action_state').show();
                return false;
            } else {
                $('#revenue_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#revenue_rpt_action_state').html('');
                $('#revenue_rpt_action_state').hide();
            }
            var html = "";
            $('#revenue_rpt_date_to').removeClass('inp_error');
            $('#revenue-report-list-container').removeClass('hidden');
            $('#revenue-report-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/revenue-report-list",
                data: data,
                success: function (response) {
                    $('#revenue-report-list').html(response);
                    $('#pay-tr').show();
                }
            })
        }

        function clearRevenueReport() {
            $('#revenue_rpt_date_from').val('');
            $('#revenue_rpt_date_to').val('');
            $('#revenue-report-list-container').addClass('hidden');
            $('#revenue-report--list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#revenue_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#revenue_rpt_action_state').html('');
            $('#revenue_rpt_action_state').hide();
            $('#revenue_trns_rpt_schedule').val('NA');            
            $('#pay-tr').hide();
        }
        
        function downloadRevenueReport() {
            //document.pays_form.target = "ifrm_pays_downloader";
            document.revenue_rpt_form.action = "report/revenue-report-list?r="+Math.random();
            $('#pdf').val(1);
            document.revenue_rpt_form.submit();
            return;
        }
        
        function downloadRevenueReportSummary() {
            //document.pays_form.target = "ifrm_pays_downloader";
            document.revenue_rpt_form.action = "report/revenue-report-list?r="+Math.random();
            $('#pdf').val(2);
            document.revenue_rpt_form.submit();
            return;
        }
    </script>
{/literal}

