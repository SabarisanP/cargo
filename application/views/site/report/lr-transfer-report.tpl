<div class="brand_top">
    <h3>Lr Transfer Report</h3>
    <div class="text-right noprint" id="lrTransfer_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            {* <button class="btn btn-default" onclick="exportLrTransferReport();"><i class="fa fa-download fa-lg"></i>Excel</button> *}
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
                                                <form id="lr_transfer_report" method="post" name="lr_transfer_report" action="report/lr-transfer-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-4">
                                                            <label for="lr_transfer_rpt_date_range" class="req">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="dateRange" class="form-control sdate" id="lr_transfer_rpt_date_range" readonly="true" placeholder="Date Range">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="lr_transfer_rpt_from_org">Branch</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="lr_transfer_rpt_from_org" name="organizationCode" class="form-control">
                                                                    <option value="NA" selected="">All Branch</option>
                                                                    {foreach item=row from=$branches}
                                                                        <option value="{$row->code}" {if 'ORL8JK42561' ==$row->code}selected="{$row->code}" {/if}>{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="lr_transfer_rpt_cargoCode">Cargo Code</label>
                                                            <div class="input-group col-md-11">
                                                                <input type="text" class="form-control" name="cargoCode" id="lr_transfer_rpt_cargoCode" placeholder="Cargo Code">
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="lr_transfer_rpt_transitCode">OGPL Code</label>
                                                            <div class="input-group col-md-11">
                                                                <input type="text" class="form-control" name="transitCode" id="lr_transfer_rpt_transitCode" placeholder="Cargo Code">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">

                                                        <div class="form-group col-md-2">
                                                            <label for="lr_transfer_rpt_vehicle">Vehicle</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="lr_transfer_rpt_vehicle" name="vehicleCode" class="form-control">
                                                                    <option value="NA" selected="">All Vehicle</option>
                                                                    {foreach item=row from=$vehicles}
                                                                        {if $row->activeFlag == 1}
                                                                            <option {if $fvehicle==$row->code} selected="selected" {/if} value="{$row->code}">{$row->registationNumber} - {$row->vehicleType->name}</option>
                                                                        {/if}
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="lr_transfer_rpt_filter">Filter Type</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="lr_transfer_rpt_filter" name="filterType" class="form-control">
                                                                    <option value="BRANCH">Branch</option>
                                                                    <option value="VEHICLE">Vehicle</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="print" id="print" value="">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button type="button" class="btn btn-success" id="generate-report-btn" onclick="getLrTransferReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearLrTransferReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="lr_transfer_rpt_action_state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="lr-transfer-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="lr-transfer-rpt-list"></div>
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
        $(document).ready(function() {
            $('#lr_transfer_rpt_from_org,#lr_transfer_rpt_vehicle').select2();
        });

        $('#lr_transfer_rpt_date_range').daterangepicker({
            buttonClasses: ['btn', 'btn-xs'],
            format: 'DD-MM-YYYY',
            separator: ' | ',
            timePicker: false,
            ranges: {
                'Today': [moment().startOf('day'), moment().endOf('day')],
                'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
                'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
                'Last 30 Days': [moment().subtract(29, 'days').startOf('day'), moment().endOf('day')],
            },
        }).on('show.daterangepicker', function(ev, picker) {
            setEndTime(picker);
            picker.showCalendars();
        });

        var picker = $('#lr_transfer_rpt_date_range').data('daterangepicker');
        picker.container.find('.calendar').on('click', 'td.available', function() {
            setEndTime(picker);
        });

        function setEndTime(picker) {
            if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
                picker.setEndDate(moment(picker.endDate).endOf('day'));
            }
        }

        // function exportLrTransferReport() {
        //     $('#export').val(1);
        //     document.lr_transfer_report.target = "ifrm_downloader";
        //     document.lr_transfer_report.action = "report/lr-transfer-report-list";
        //     document.lr_transfer_report.submit();
        //     return;
        // }

        function getLrTransferReport() {
            $('#lr-transfer-rpt-list').html('');

            var data = {};
            data.dateRange = $('#lr_transfer_rpt_date_range').val();
            data.cargoCode = $('#lr_transfer_rpt_cargoCode').val();
            data.transitCode = $('#lr_transfer_rpt_transitCode').val();
            data.vehicleCode = $('#lr_transfer_rpt_vehicle').val();
            data.organizationCode = $('#lr_transfer_rpt_from_org').val();
            data.filterType = $('#lr_transfer_rpt_filter').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.dateRange == '') {
                $('#lr_transfer_rpt_date_range').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#lr_transfer_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#lr_transfer_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#lr_transfer_rpt_action_state').show();
                return false;
            } else {
                $('#lr_transfer_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#lr_transfer_rpt_action_state').html('');
                $('#lr_transfer_rpt_action_state').hide();
            }

            $('#lr_transfer_rpt_date_range').removeClass('inp_error');
            $('#lr-transfer-rpt-list-container').removeClass('hidden');
            $('#generate-report-btn').prop('disabled', true);
            $('#lr-transfer-rpt-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/lr-transfer-report-list",
                data: data,
                success: function(response) {
                    $('#generate-report-btn').prop('disabled', false);
                    $('#lr-transfer-rpt-list').html(response);
                    $('#lrTransfer_rpt_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#lr-transfer-rpt-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }


        function clearLrTransferReport() {
            $('#lr_transfer_rpt_date_range').val('');
            $('#lr-transfer-rpt-list-container').addClass('hidden');
            $('#lr-transfer-rpt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#lr_transfer_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#lr_transfer_rpt_action_state').html('');
            $('#lr_transfer_rpt_action_state').hide();
            $('#lr_transfer_rpt_from_org').val('NA').trigger('change');
            $('#lr_transfer_rpt_filter').val('BRANCH').trigger('change');
            $('#lr_transfer_rpt_vehicle').val('NA').trigger('change');
            $('#lr_transfer_rpt_transitCode').val('');
            $('#lr_transfer_rpt_cargoCode').val('');
            $('#lrTransfer_rpt_excel').hide();
        }

        function showOgplWiseLrTransfer(transitCode) {
            var dateRange = $('#lr_transfer_rpt_date_range').val();
            var OrgCode = $('#lr_transfer_rpt_from_org').val();
            var vehicleCode = $('#lr_transfer_rpt_vehicle').val();
            var filterType = $('#lr_transfer_rpt_filter').val();

            $('#cargo-invoice-iframe').html('');
            $('#cargo-invoice-pdf-dialog').css('background', '#fff');
            $('#cargo-invoice-pdf-dialog').removeClass('hide');
            $('#cargo-invoice-pdf-dialog').dialog({
                autoOpen: true,
                height: 700,
                width: 1100,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();

            var $iframe = $('<iframe />');
            $iframe.attr('src', base_url + 'report/lr-transfer-report-list-print?Date=' + dateRange + '&orgCode=' + OrgCode + '&transitCode=' + transitCode + '&vehicle=' + vehicleCode + '&filterType=' + filterType);
            $iframe.attr('class', 'iframe-fullwidth iframe-loading-bg');
            $('#cargo-invoice-iframe').html($iframe);
        }
    </script>
{/literal}