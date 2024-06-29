<div class="brand_top">
    <h3>Cargo Life Cycle Report</h3>
    <div class="text-right noprint" id="lifecycle_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportLifecycleReport();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the detailed status of the LRs.                 
        </div>
    </div> 
</div>

<div id="main_wrapper">
    <div class="page_content" style="min-height: 500px;">
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
                                                <form id="lifecycle" method="post" name="lifecycle" action="cargo/cargo-life-cycle-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="lifecycle_rpt_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="lifecycle_rpt_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="lifecycle_rpt_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="lifecycle_rpt_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="lifecycle_rpt_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="lifecycle_rpt_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="1">
                                                                <button type="button" class="btn btn-success" onclick="getLifecycleReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearLifecycleReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="lifecycle_rpt_action_state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="lifecycle-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="lifecycle-rpt-list"></div>
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
        $('#lifecycle_rpt_from').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true
        }).on('changeDate', function(e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#lifecycle_rpt_to').datepicker('setStartDate', e.date);
            $('#lifecycle_rpt_to').datepicker('setEndDate', end)
        });
        $('#lifecycle_rpt_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: '+365D',
            autoclose: true
        }).on('changeDate', function(e) {
            $('#lifecycle_rpt_from').datepicker('setEndDate', e.date)
        });
    
        $('.select2').select2();
    
        function exportLifecycleReport() {
            document.lifecycle.target = "ifrm_downloader";
            document.lifecycle.submit();
            return;
        }
    
        function getLifecycleReport() {
            $('#lifecycle-rpt-list').html('');
            var data = {};
            data.fromDate = $('#lifecycle_rpt_from').val();
            data.toDate = $('#lifecycle_rpt_to').val();
    
            var err = 0;
            $('.inp_error').removeClass('inp_error');
    
            if (data.fromDate == '') {
                $('#lifecycle_rpt_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#lifecycle_rpt_to').addClass('inp_error');
                err++;
            }
    
            if (err > 0) {
                $('#lifecycle_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#lifecycle_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#lifecycle_rpt_action_state').show();
                return false;
            } else {
                $('#lifecycle_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#lifecycle_rpt_action_state').html('');
                $('#lifecycle_rpt_action_state').hide();
            }
    
            $('#lifecycle_rpt_to').removeClass('inp_error');
            $('#lifecycle-rpt-list-container').removeClass('hidden');
            $('#lifecycle-rpt-list').html(loading_popup);
    
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/cargo-life-cycle-report-list",
                data: data,
                success: function(response) {
                    $('#lifecycle-rpt-list').html(response);
                    $('#lifecycle_rpt_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#lifecycle-rpt-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }
    
        function clearLifecycleReport() {
            $('#lifecycle_rpt_from').val('');
            $('#lifecycle_rpt_to').val('');
            $('#lifecycle-rpt-list-container').addClass('hidden');
            $('#lifecycle-rpt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#lifecycle_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#lifecycle_rpt_action_state').html('');
            $('#lifecycle_rpt_action_state').hide();
            $('#lifecycle_rpt_excel').hide();
        }    
    </script>
{/literal}
