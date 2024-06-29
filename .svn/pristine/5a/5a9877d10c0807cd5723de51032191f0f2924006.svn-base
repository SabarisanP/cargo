<div class="brand_top">
    <h3>Dispatch Efficiency Report</h3>
    <div class="text-right noprint" id="dispatch_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportDispatchEfficiencyReport();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the details of OGPL.                 
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
                                                <form id="dispatch_efficiency" method="post" name="dispatch_efficiency" action="cargo/dispatch-efficiency-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="dispatch_rpt_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="dispatch_rpt_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="dispatch_rpt_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="dispatch_rpt_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="dispatch_rpt_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="dispatch_rpt_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="dispatch_rpt_vehicle">Vehicle</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="dispatch_rpt_vehicle" name="vehicleCode" class="form-control select2">
                                                                    <option value="NA" selected>All Vehicles</option>
                                                                    {foreach item=row from=$vehicles}
                                                                        <option value="{$row->code}">{$row->registationNumber}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="1">
                                                                <button type="button" class="btn btn-success" onclick="getDispatchEfficiencyReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearDispatchEfficiencyReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="dispatch_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="dispatch-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="dispatch-rpt-list"></div>
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
    $('#dispatch_rpt_from').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        changeMonth: true
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#dispatch_rpt_to').datepicker('setStartDate', e.date);
        $('#dispatch_rpt_to').datepicker('setEndDate', end)
    });
    $('#dispatch_rpt_to').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'yyyy-mm-dd',
        maxDate: '+365D',
        autoclose: true
    }).on('changeDate', function (e) {
        $('#dispatch_rpt_from').datepicker('setEndDate', e.date)
    });

    $('.select2').select2();

    function exportDispatchEfficiencyReport() {
        document.dispatch_efficiency.target = "ifrm_downloader";
        document.dispatch_efficiency.submit();
        return;
    }

    function getDispatchEfficiencyReport() {
        $('#dispatch-rpt-list').html('');
        var data = {};
        data.fromDate = $('#dispatch_rpt_from').val();
        data.toDate = $('#dispatch_rpt_to').val();
        data.vehicleCode = $('#dispatch_rpt_vehicle').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if (data.fromDate == '') {
            $('#dispatch_rpt_from').addClass('inp_error');
            err++;
        }
        if (data.toDate == '') {
            $('#dispatch_rpt_to').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#dispatch_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#dispatch_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#dispatch_rpt_action_state').show();
            return false;
        } else {
            $('#dispatch_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#dispatch_rpt_action_state').html('');
            $('#dispatch_rpt_action_state').hide();
        }

        $('#dispatch_rpt_to').removeClass('inp_error');
        $('#dispatch-rpt-list-container').removeClass('hidden');
        $('#dispatch-rpt-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/dispatch-efficiency-report-list",
            data: data,
            success: function (response) {
                $('#dispatch-rpt-list').html(response);
                $('#dispatch_rpt_excel').show();
                $('html, body').animate({
                    scrollTop: $('#dispatch-rpt-list-container').offset().top - 35
                }, 'slow');
            }
        });
    }


    function clearDispatchEfficiencyReport() {
        $('#dispatch_rpt_from').val('');
        $('#dispatch_rpt_to').val('');
        $('#dispatch_rpt_vehicle').val('NA').trigger('change');
        $('#dispatch-rpt-list-container').addClass('hidden');
        $('#dispatch-rpt-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#dispatch_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#dispatch_rpt_action_state').html('');
        $('#dispatch_rpt_action_state').hide();
        $('#dispatch_rpt_excel').hide();
    }
</script>
{/literal}