<div class="brand_top">
    <h3>Average Branch Revenue Report</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportAverageExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
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

                                                <form id='average_report_form' method="post" name="average_report_form" action="cargo/average-revenue-report-list" onsubmit="return false;">
                                                    <div class="row">   

                                                        <div class="form-group col-md-2">
                                                            <label for="average_date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="average_date_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="average_date_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="average_date_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="average_date_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div> 

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="pdf" id="pdf" value="">
                                                                <button class="btn btn-success" type="button" id="generate-report-btn" onclick="averageReport();">Search</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearAverageReport();">Clear</button>
                                                            </div>
                                                        </div>        
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="average_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="average-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="average-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe> 

{literal}
    <script>
        $('#average_date_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            startDate: '-6m',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#average_date_to').datepicker('setStartDate', e.date);
            $("#average_date_to").datepicker("setEndDate", end)
        });
        $('#average_date_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            $('#average_date_from').datepicker('setEndDate', e.date)
        });

        $('.select2').select2();
        
        function averageReport() {
            $('#average-list').html('');
            var data = {};
            data.fromDate = $('#average_date_from').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.toDate = $('#average_date_to').data('datepicker').getFormattedDate('yyyy-mm-dd');

            var err = 0;
            $('#average_date_from, #average_date_to').removeClass('inp_error');
            if (data.fromDate == '') {
                $('#average_date_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#average_date_to').addClass('inp_error');
                err++;
            }

            if (data.fromDate != '' && data.toDate != '') {
                var f = data.fromDate.split('-');
                var a = moment([f[0], f[1], f[2]]);

                var e = data.toDate.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if (t > 31) {
                    $('#average_date_to').addClass('inp_error');
                    $('#average_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#average_action_state').html('Date range should be 31 days or less');
                    $('#average_action_state').show();
                    err++;
                    return false;
                }
            }

            if (err > 0) {
                $('#average_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#average_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#average_action_state').show();
                return false;
            } else {
                $('#average_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#average_action_state').html('');
                $('#average_action_state').hide();
            }
            var html = "";
            $('#average_date_to').removeClass('inp_error');
            $('#average-list-container').removeClass('hidden');
            $('#generate-report-btn').prop('disabled', true);
            $('#average-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/average-revenue-report-list",
                data: data,
                success: function (response) {
                    $('#generate-report-btn').prop('disabled', false);
                    $('#average-list').html(response);
                    $('#excl_cons').show();
                    $("html, body").animate({
                        scrollTop: $('#average-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }

        function clearAverageReport() {
            $('#average_date_from').val('');
            $('#average_date_to').val('');
            $('#average-list-container').addClass('hidden');
            $('#average-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#average_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#average_action_state').html('');
            $('#average_action_state').hide();
            
            $('#excl_cons').hide();
        }

        function exportAverageExcel() {
            $('#export').val(1);
            document.average_report_form.target = "ifrm_downloader";
            document.average_report_form.submit();
            return;
        }
    </script>
{/literal}
