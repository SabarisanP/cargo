<div class="brand_top">
    <h3>Godown Report</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportGodownExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the pending delivery LRs which are marked to GODOWN.                 
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

                                                <form id='godown_report_form' method="post" name="godown_report_form" action="cargo/godown-report-list" onsubmit="return false;">
                                                    <div class="row">   

                                                        <div class="form-group col-md-2">
                                                            <label for="godown_date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="godown_date_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="godown_date_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="godown_date_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="godown_date_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div> 

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="pdf" id="pdf" value="">
                                                                <button class="btn btn-success" type="button" id="generate-report-btn" onclick="godownReport();">Search</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearGodownReport();">Clear</button>
                                                            </div>
                                                        </div>        
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="godown_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="godown-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="godown-list"></div>                                    
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
        $('#godown_date_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            startDate: '-6m',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#godown_date_to').datepicker('setStartDate', e.date);
            $("#godown_date_to").datepicker("setEndDate", end)
        });
        $('#godown_date_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            $('#godown_date_from').datepicker('setEndDate', e.date)
        });

        $('.select2').select2();
        
        function godownReport() {
            $('#godown-list').html('');
            var data = {};
            data.fromDate = $('#godown_date_from').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.toDate = $('#godown_date_to').data('datepicker').getFormattedDate('yyyy-mm-dd');

            var err = 0;
            $('#godown_date_from, #godown_date_to').removeClass('inp_error');
            if (data.fromDate == '') {
                $('#godown_date_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#godown_date_to').addClass('inp_error');
                err++;
            }

            if (data.fromDate != '' && data.toDate != '') {
                var f = data.fromDate.split('-');
                var a = moment([f[0], f[1], f[2]]);

                var e = data.toDate.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if (t > 31) {
                    $('#godown_date_to').addClass('inp_error');
                    $('#godown_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#godown_action_state').html('Date range should be 31 days or less');
                    $('#godown_action_state').show();
                    err++;
                    return false;
                }
            }

            if (err > 0) {
                $('#godown_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#godown_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#godown_action_state').show();
                return false;
            } else {
                $('#godown_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#godown_action_state').html('');
                $('#godown_action_state').hide();
            }
            var html = "";
            $('#godown_date_to').removeClass('inp_error');
            $('#godown-list-container').removeClass('hidden');
            $('#generate-report-btn').prop('disabled', true);
            $('#godown-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/godown-report-list",
                data: data,
                success: function (response) {
                    $('#generate-report-btn').prop('disabled', false);
                    $('#godown-list').html(response);
                    $('#excl_cons').show();
                    $("html, body").animate({
                        scrollTop: $('#godown-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }

        function clearGodownReport() {
            $('#godown_date_from').val('');
            $('#godown_date_to').val('');
            $('#godown-list-container').addClass('hidden');
            $('#godown-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#godown_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#godown_action_state').html('');
            $('#godown_action_state').hide();
            
            $('#excl_cons').hide();
        }

        function exportGodownExcel() {
            $('#export').val(1);
            document.godown_report_form.target = "ifrm_downloader";
            document.godown_report_form.submit();
            return;
        }
    </script>
{/literal}
