<div class="brand_top">
    <h3>Addon Details Report</h3>
    <div class="text-right noprint" id="addon_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoCollection();"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                                <form id="addon_report" method="post" name="addon_report" action="cargo/addon-details-report-list" onsubmit="return false;">                                                  <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="addon_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="addon_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="addon_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="addon_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="addon_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="addon_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="addon_type">Addon Type</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="addon_type" name="addonTypeCode" class="form-control">
                                                                    {foreach item=name key=code from=$addon_charges_type}
                                                                        <option value="{$code}">{$name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="1">
                                                                <button type="button" class="btn btn-success" onclick="getPickupDeliveryReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearPickupDeliveryReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="addon_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="addon-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="addon-rpt-list"></div>
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
        $('#addon_from').datepicker({
            format: 'dd-mm-yyyy',
            autoclose: true,
            changeMonth: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#addon_to').datepicker('setStartDate', e.date);
            $('#addon_to').datepicker('setEndDate', end)
        });

        $('#addon_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'dd-mm-yyyy',
            maxDate: '+365D',
            autoclose: true
        }).on('changeDate', function (e) {
            $('#addon_from').datepicker('setEndDate', e.date)
        });

        function exportCargoCollection() {
            document.addon_report.target = "ifrm_downloader";
            document.addon_report.submit();
            return;
        }

        function getPickupDeliveryReport() {
            $('#addon-rpt-list').html('');
            var data = {};
            data.fromDate = $('#addon_from').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.toDate = $('#addon_to').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.organizationCode = $('#addon_organization').val();
            data.addonTypeCode = $('#addon_type').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.fromDate == '') {
                $('#addon_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#addon_to').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#addon_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#addon_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#addon_action_state').show();
                return false;
            } else {
                $('#addon_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#addon_action_state').html('');
                $('#addon_action_state').hide();
            }

            $('#addon_to').removeClass('inp_error');
            $('#addon-rpt-list-container').removeClass('hidden');
            $('#addon-rpt-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/addon-details-report-list",
                data: data,
                success: function (response) {
                    $('#addon-rpt-list').html(response);
                    $('#addon_rpt_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#addon-rpt-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }

        function clearPickupDeliveryReport() {
            $('#addon_from').val('').datepicker('setEndDate', '');
            $('#addon_to').val('').datepicker('setStartDate', '');
            $('#addon-rpt-list-container').addClass('hidden');
            $('#addon-rpt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#addon_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#addon_action_state').html('');
            $('#addon_action_state').hide();
            $('#addon_type option:first').prop('selected', true);
            $('#addon_rpt_excel').hide();
        }
    </script>
{/literal}