<div class="brand_top">
    <h3>Cargo Edit Report</h3>
    <div class="text-right noprint" id="cargoedit_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoEdit();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the edited Lr details.                 
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
                                                <form id="cargoedit_report" method="post" name="cargoedit_report" action="cargo/cargo-edit-report-list" onsubmit="return false;">                                                  <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="cargoedit_rpt_from">Date From</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="cargoedit_rpt_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="cargoedit_rpt_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cargoedit_rpt_to">Date To</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="cargoedit_rpt_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="cargoedit_rpt_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cargoedit_rpt_org" id="branch-label">Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="cargoedit_rpt_org" name="organizationCode" class="form-control select2">
                                                                    <option value="NA" selected="">All Branch</option>
                                                                    {foreach item=row from=$branches}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cargoedit_rpt_event" id="branch-label">Event</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="cargoedit_rpt_event" name="eventCode" class="form-control select2">
                                                                    <option value="NA" selected="">All Status</option>
                                                                    {foreach key=code item=name from=$cargo_edit_events}
                                                                        <option value="{$code}">{$name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button type="button" class="btn btn-success" onclick="getEditReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearEditReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="cargoedit_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="collection-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="collection-rpt-list"></div>
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
        $('.select2').select2();

        $('#cargoedit_rpt_from').datepicker({
            format: 'dd-mm-yyyy',
            autoclose: true,
            changeMonth: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#cargoedit_rpt_to').datepicker('setStartDate', e.date);
            $('#cargoedit_rpt_to').datepicker('setEndDate', end)
        });
        $('#cargoedit_rpt_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'dd-mm-yyyy',
            maxDate: '+365D',
            autoclose: true
        }).on('changeDate', function (e) {
            $('#cargoedit_rpt_from').datepicker('setEndDate', e.date)
        });

        function exportCargoEdit() {
            $('#export').val(1);
            document.cargoedit_report.target = "ifrm_downloader";
            document.cargoedit_report.submit();
            return;
        }

        function getEditReport() {
            $('#collection-rpt-list').html('');
            var data = {};
            data.fromDate = $('#cargoedit_rpt_from').val();;
            data.toDate = $('#cargoedit_rpt_to').val();;
            data.organizationCode = $('#cargoedit_rpt_org').val();
            data.eventCode = $("#cargoedit_rpt_event").val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');
            
            if (data.fromDate == '') {
                $('#cargoedit_rpt_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#cargoedit_rpt_to').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#cargoedit_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#cargoedit_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#cargoedit_rpt_action_state').show();
                return false;
            } else {
                $('#cargoedit_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#cargoedit_rpt_action_state').html('');
                $('#cargoedit_rpt_action_state').hide();
            }

            $('#cargoedit_rpt_to').removeClass('inp_error');
            $('#collection-rpt-list-container').removeClass('hidden');
            $('#collection-rpt-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/cargo-edit-report-list",
                data: data,
                success: function (response) {
                    $('#collection-rpt-list').html(response);
                    $('#cargoedit_rpt_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#collection-rpt-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }

        function clearEditReport() {
            $('#cargoedit_rpt_from').val('');
            $('#cargoedit_rpt_to').val('');
            $('#collection-rpt-list-container').addClass('hidden');
            $('#collection-rpt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#cargoedit_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#cargoedit_rpt_action_state').html('');
            $('#cargoedit_rpt_action_state').hide();
            $('#cargoedit_rpt_org').val('NA').trigger('change');
            $('#cargoedit_rpt_event').val('NA').trigger('change');
            $('#cargoedit_rpt_excel').hide();
        }
    </script>
{/literal}