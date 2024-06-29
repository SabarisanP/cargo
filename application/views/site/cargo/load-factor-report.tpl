<div class="brand_top">
    <h3>Load Factor Report</h3>
    <div class="text-right noprint" id="loadfactor_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportLoadfactorReport();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
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
                                                <form id="loadfactor" method="post" name="loadfactor" action="cargo/load-factor-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="loadfactor_rpt_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="loadfactor_rpt_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="loadfactor_rpt_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="loadfactor_rpt_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="loadfactor_rpt_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="loadfactor_rpt_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="1">
                                                                <button type="button" class="btn btn-success" onclick="getLoadfactorReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearLoadfactorReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="loadfactor_rpt_action_state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="loadfactor-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="loadfactor-rpt-list"></div>
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
        $('#loadfactor_rpt_from').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true
        }).on('changeDate', function(e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#loadfactor_rpt_to').datepicker('setStartDate', e.date);
            $('#loadfactor_rpt_to').datepicker('setEndDate', end)
        });
        $('#loadfactor_rpt_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: '+365D',
            autoclose: true
        }).on('changeDate', function(e) {
            $('#loadfactor_rpt_from').datepicker('setEndDate', e.date)
        });
    
        $('.select2').select2();
    
        function exportLoadfactorReport() {
            document.loadfactor.target = "ifrm_downloader";
            document.loadfactor.submit();
            return;
        }
    
        function getLoadfactorReport() {
            $('#loadfactor-rpt-list').html('');
            var data = {};
            data.fromDate = $('#loadfactor_rpt_from').val();
            data.toDate = $('#loadfactor_rpt_to').val();
    
            var err = 0;
            $('.inp_error').removeClass('inp_error');
    
            if (data.fromDate == '') {
                $('#loadfactor_rpt_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#loadfactor_rpt_to').addClass('inp_error');
                err++;
            }
    
            if (err > 0) {
                $('#loadfactor_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#loadfactor_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#loadfactor_rpt_action_state').show();
                return false;
            } else {
                $('#loadfactor_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#loadfactor_rpt_action_state').html('');
                $('#loadfactor_rpt_action_state').hide();
            }
    
            $('#loadfactor_rpt_to').removeClass('inp_error');
            $('#loadfactor-rpt-list-container').removeClass('hidden');
            $('#loadfactor-rpt-list').html(loading_popup);
    
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/load-factor-report-list",
                data: data,
                success: function(response) {
                    $('#loadfactor-rpt-list').html(response);
                    $('#loadfactor_rpt_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#loadfactor-rpt-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }
    
        function clearLoadfactorReport() {
            $('#loadfactor_rpt_from').val('');
            $('#loadfactor_rpt_to').val('');
            $('#loadfactor-rpt-list-container').addClass('hidden');
            $('#loadfactor-rpt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#loadfactor_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#loadfactor_rpt_action_state').html('');
            $('#loadfactor_rpt_action_state').hide();
            $('#loadfactor_rpt_excel').hide();
        }    
    </script>
{/literal}
