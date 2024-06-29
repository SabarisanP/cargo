<div class="brand_top">
    <h3>Seat Visibility Report</h3> 

    <div class="text-right hidden" id="d_head_export_panel">
    <div class="btn-group btn-group-sm">
    <button class="btn btn-default" onclick="exportReportDetails()"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                                <div class="divide-10"></div>
                                                <form name='ssv_audit_report' method="post" action="report/schedule-seat-visibility-audit-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label class="" for="travelDate">Travel Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="travelDate" class="form-control sdate" id="travelDate" readonly="true" placeholder="Travel date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label class="" for="travelDate">&nbsp</label>
                                                            <div class="input-group">
                                                                <button class="btn btn-success" type="button"    onclick="getScheduleSeats();" >Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearReport();">Clear</button>
                                                                <input type="hidden" name="export" id="export" value="">
                                                            </div>
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
                    <div class="row hidden" id="ssv-audit-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="ssv-audit-list"></div>                                    
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
        $('#travelDate').datepicker({
            todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-3m',
            endDate: '+3m',
            changeMonth: true,
        });

        function getScheduleSeats() {
            $('#ssv-audit-list').html('');
            var data = {};
            data.travelDate = $('#travelDate').val();

            var err = 0;

            if (data.from == '') {
                $('#travelDate').addClass('inp_error');
                err++;
            } else {
                $('#travelDate').removeClass('inp_error');
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
            $('#ssv-audit-list-container').removeClass('hidden');
            $('#ssv-audit-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/schedule-seat-visibility-audit-report-list",
                data: data,
                success: function (response) {
                    $('#ssv-audit-list').html(response);
                    $('#d_head_export_panel').removeClass('hidden');

                }
            });
        }

        function clearReport() {
            $('#gru_users').val('');
            $('#travelDate').val('');
            $('#ssv-audit-list-container').addClass('hidden');
            $('#ssv-audit-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();
            $('#export').val('');

            $('#d_head_export_panel').addClass('hidden');
        }

        function exportReportDetails() {
            document.ssv_audit_report.target = "irm_downloader";
            $('#export').val(1);
            document.ssv_audit_report.submit();
            return;
        }

    </script>
{/literal}


