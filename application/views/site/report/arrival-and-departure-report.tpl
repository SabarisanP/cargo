<div class="brand_top">
    <h3>Arrival Departure Report</h3>
    <div class="text-right noprint" id="arrival_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportArrivalReport();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="arrivalPrint()"><i class="fa fa-print fa-lg"></i> Print</button>
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
                                                <form id="arrival_departure_report" method="post" name="arrival_departure_report" action="report/arrival-and-departure-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-4">
                                                            <label for="arrival_departure_rpt_date_range" class="req">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="dateRange" class="form-control sdate" id="arrival_departure_rpt_date_range" readonly="true" placeholder="Date Range">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="arrival_departure_rpt_from_org">Branch</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="arrival_departure_rpt_from_org" name="fromOrganizationCode" class="form-control">
                                                                    <option value="NA" selected="">All Branch</option>
                                                                    {foreach item=row from=$branches}
                                                                        <option value="{$row->code}" {if $login_branch ==$row->code}selected="{$row->code}" {/if}>{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="arrival_departure_rpt_vehicle">Vehicle</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="arrival_departure_rpt_vehicle" name="vehicleCode" class="form-control">
                                                                    <option value="" selected="">All Vehicle</option>
                                                                    {foreach item=row from=$vehicles}
                                                                        {if $row->activeFlag == 1}
                                                                            <option {if $fvehicle==$row->code} selected="selected" {/if} value="{$row->code}">{$row->registationNumber} - {$row->vehicleType->name}</option>
                                                                        {/if}
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="arrival_departure_rpt_from_station">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="arrival_departure_rpt_from_station" name="fromStationCode" class="form-control">
                                                                    <option value="NA" selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="arrival_departure_rpt_to_station">To Station</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="arrival_departure_rpt_to_station" name="toStationCode" class="form-control">
                                                                    <option value="NA" selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="arrival_departure_rpt_filter">Filter Type</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="arrival_departure_rpt_filter" name="filterType" class="form-control">
                                                                    <option value="LOAD">Departure</option>
                                                                    <option value="UNLOAD">Arrival</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="print" id="print" value="">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button type="button" class="btn btn-success" id="generate-report-btn" onclick="getArrivalReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearDepartureReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="arrival_departure_rpt_action_state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="arrival-departure-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="arrival-departure-rpt-list"></div>
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
            $('#arrival_departure_rpt_from_org, #arrival_departure_rpt_vehicle, #arrival_departure_rpt_from_station, #arrival_departure_rpt_to_station').select2();
        });

        $('#arrival_departure_rpt_date_range').daterangepicker({
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

        var picker = $('#arrival_departure_rpt_date_range').data('daterangepicker');
        picker.container.find('.calendar').on('click', 'td.available', function() {
            setEndTime(picker);
        });

        function setEndTime(picker) {
            if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
                picker.setEndDate(moment(picker.endDate).endOf('day'));
            }
        }

        function exportArrivalReport() {
            $('#print').val('');
            $('#export').val(1);
            document.arrival_departure_report.target = "ifrm_downloader";
            document.arrival_departure_report.action = "report/arrival-and-departure-report-list";
            document.arrival_departure_report.submit();
            return;
        }

        function getArrivalReport() {
            $('#arrival-departure-rpt-list').html('');

            var data = {};
            data.dateRange = $('#arrival_departure_rpt_date_range').val();
            data.fromStationCode = $('#arrival_departure_rpt_from_station').val();
            data.toStationCode = $('#arrival_departure_rpt_to_station').val();
            data.fromOrganizationCode = $('#arrival_departure_rpt_from_org').val();
            data.filterType = $('#arrival_departure_rpt_filter').val();
            data.vehicleCode = $('#arrival_departure_rpt_vehicle').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.dateRange == '') {
                $('#arrival_departure_rpt_date_range').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#arrival_departure_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#arrival_departure_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#arrival_departure_rpt_action_state').show();
                return false;
            } else {
                $('#arrival_departure_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#arrival_departure_rpt_action_state').html('');
                $('#arrival_departure_rpt_action_state').hide();
            }

            $('#arrival_departure_rpt_date_range').removeClass('inp_error');
            $('#arrival-departure-rpt-list-container').removeClass('hidden');
            $('#generate-report-btn').prop('disabled', true);
            $('#arrival-departure-rpt-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/arrival-and-departure-report-list",
                data: data,
                success: function(response) {
                    $('#generate-report-btn').prop('disabled', false);
                    $('#arrival-departure-rpt-list').html(response);
                    $('#arrival_rpt_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#arrival-departure-rpt-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }


        function clearDepartureReport() {
            $('#arrival_departure_rpt_date_range').val('');
            $('#arrival-departure-rpt-list-container').addClass('hidden');
            $('#arrival-departure-rpt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#arrival_departure_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#arrival_departure_rpt_action_state').html('');
            $('#arrival_departure_rpt_action_state').hide();
            $('#arrival_departure_rpt_from_org').val('NA').trigger('change');
            $('#arrival_departure_rpt_from_station').val('NA').trigger('change');
            $('#arrival_departure_rpt_to_station').val('NA').trigger('change');
            $('#arrival_rpt_excel').hide();
        }

        function arrivalPrint() {
            $('#print').val(1);
            $('#export').val('');
            document.arrival_departure_report.target = "ifrm_downloader";
            document.arrival_departure_report.action = "report/arrival-and-departure-report-list";
            document.arrival_departure_report.submit();
            return;
        }
    </script>
{/literal}