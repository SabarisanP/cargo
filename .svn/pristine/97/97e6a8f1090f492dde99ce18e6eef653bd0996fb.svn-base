<div class="brand_top">
    <h3>Direct Online Sales Report</h3> 
    <div class="text-right noprint hidden" id="d_head_export_panel">
        <div class="btn-group btn-group-sm hide">
            <button class="btn btn-default" onclick="exportSalesSummaryExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                                
                                                <form id='brd_pnt' method="post" name="brd_pnt" action="report/direct-online-sales-report-list" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="date_from">From Date</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="from_date" class="form-control sdate" id="ss_date_from" readonly="true" placeholder="From Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="date_to">To Date</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="to_date" class="form-control sdate" id="ss_date_to" readonly="true" placeholder="To Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-3">     
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="generateSalesSummaryReport();" >Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearSalesSummary();">Clear</button>
                                                        </div>
                                                    </div>
                                                       
                                                </form>
                                                <br>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="usr-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    
                   

                    <div class="row hidden" id="salessummary-report-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="salessummary-report-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe id="irm_downloader" name="irm_downloader" style="display: none"></iframe>                                            
{literal}
    <script>

        function exportSalesSummaryExcel () {
            document.brd_pnt.target = "irm_downloader";
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }
        
        $('#ss_user_code').select2();
        $('#ss_group_code').select2();
        
        $('#ss_date_from').datepicker({
            format: 'yyyy-mm-dd',
            startDate: '-3m',
            endDate: "+3m",
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#ss_date_to').datepicker('setStartDate', e.date);
            $("#ss_date_to").datepicker("setEndDate", end)
        });
        
        $('#ss_date_to').datepicker({
            startDate: '-3m',
            endDate: "+3m",
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#ss_date_from').datepicker('setStartDate', start);
            $('#ss_date_from').datepicker('setEndDate', e.date)
        });

        function generateSalesSummaryReport() {
            $('#salessummary-report-list').html('');
            var data = {};
            data.fromDate = $('#ss_date_from').val();
            data.toDate = $('#ss_date_to').val();

            var err = 0;

            if (data.fromDate == '') {
                $('#ss_date_from').addClass('inp_error');
                err++;
            } else {
                $('#ss_date_from').removeClass('inp_error');
            }
            if (data.toDate == '') {
                $('#ss_date_to').addClass('inp_error');
                err++;
            } else {
                $('#ss_date_to').removeClass('inp_error');
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
                
                $('#discount-usage-list-graph').addClass('hidden');
                $('#discount-usage-graph-group').html('');
                $('#discount-usage-graph-route').html('');
                $('#discount-usage-graph-type').html('');
            }
            var html = "";
            
            $('#ss_date_to').removeClass('inp_error');
            $('#salessummary-report-list-container').removeClass('hidden');
            $('#salessummary-report-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/direct-online-sales-report-list",
                data: data,
                success: function (response) {
                    $('#salessummary-report-list').html(response);
                    $('#d_head_export_panel').removeClass('hidden');
                }
            });
        }
        
        function clearSalesSummary() {
            $('#ss_date_opt').val(1);
            $('#ss_date_from').val('');
            $('#ss_date_to').val('');
            $('#ss_user_code').val('NA');
            $('#ss_group_code').val('NA');
            
            var fDate = new Date();
            var start = new Date(fDate.setDate(fDate.getDate() - 93));
            var tDate = new Date();
            var end = new Date(tDate.setDate(tDate.getDate() + 93));
            $('#ss_date_from').datepicker('setStartDate', start);
            $('#ss_date_from').datepicker('setEndDate', end);
           
            $('#ss_date_to').datepicker('setStartDate', start);
            $('#ss_date_to').datepicker('setEndDate', end);

            $('#salessummary-report-list-container').addClass('hidden');
            $('#salessummary-report-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();
            
            $('#discount-usage-list-graph').addClass('hidden');
            $('#discount-usage-graph-group').html('');
            $('#discount-usage-graph-route').html('');
            $('#discount-usage-graph-type').html('');

            $('#d_head_export_panel').addClass('hidden');
        }

    </script>
{/literal}