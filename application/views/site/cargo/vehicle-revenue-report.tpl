<div class="brand_top">
    <h3>Vehicle Revenue Report</h3>
    <div class="text-right noprint" id="vehrev_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportVehicleTransit();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the total transaction amount based on the vehicle and driver.
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
                                                <form id="vehicle_revenue" method="post" name="vehicle_revenue" action="cargo/vehicle_revenue_report_list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="vehrev_rpt_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="vehrev_rpt_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="vehrev_rpt_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="vehrev_rpt_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="vehrev_rpt_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="vehrev_rpt_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="vehrev_rpt_vehicle">Vehicle</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="vehrev_rpt_vehicle" class="form-control" multiple>
                                                                    <optgroup label="Tags" data-group="TAGS">
                                                                        {foreach item=row from=$cargotags}
                                                                            {if $row->category->code == 'VHCL'}
                                                                                <option value="{$row->code}">{$row->name}</option>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </optgroup>
                                                                    <optgroup label="Vehicles" data-group="VEHICLES">
                                                                        {foreach item=row from=$vehicles}
                                                                            <option value="{$row->code}">{$row->registationNumber}</option>
                                                                        {/foreach}
                                                                    </optgroup>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="vehrev_rpt_driver">Driver</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="vehrev_rpt_driver" class="form-control" multiple>
                                                                    <optgroup label="Tags" data-group="TAGS">
                                                                        {foreach item=row from=$cargotags}
                                                                            {if $row->category->code == 'DRVR'}
                                                                                <option value="{$row->code}">{$row->name}</option>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </optgroup>
                                                                    <optgroup label="Drivers" data-group="DRIVERS">
                                                                        {foreach item=row from=$drivers}
                                                                            <option value="{$row->code}">{$row->name}</option>
                                                                        {/foreach}
                                                                    </optgroup>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="1">
                                                                <input type="hidden" name="vehicleList" id="hid-vehicle-list">
                                                                <input type="hidden" name="driverList" id="hid-driver-list">
                                                                <input type="hidden" name="vehicleTags" id="hid-vehicle-tags">
                                                                <input type="hidden" name="driverTags" id="hid-driver-tags">
                                                                <button type="button" class="btn btn-success" onclick="getVehicleTransitReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearVehicleTransitReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="vehrev_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="vehrev-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="vehrev-rpt-list"></div>
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
    $('#vehrev_rpt_from').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#vehrev_rpt_to').datepicker('setStartDate', e.date);
        $('#vehrev_rpt_to').datepicker('setEndDate', end)
    });
    $('#vehrev_rpt_to').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'dd-mm-yyyy',
        maxDate: '+365D',
        autoclose: true
    }).on('changeDate', function (e) {
        $('#vehrev_rpt_from').datepicker('setEndDate', e.date)
    });
    $('#vehrev_rpt_vehicle').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default vehrev_rpt_vehicle'
    });
    $('#vehrev_rpt_driver').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default vehrev_rpt_driver'
    });

    function getSelectedCSV(selector) {
        return $(selector).find('option:selected').map((i, o) => o.value).get().join(',');
    }

    function exportVehicleTransit() {
        $('#hid-vehicle-list').val( getSelectedCSV('#vehrev_rpt_vehicle [data-group="VEHICLES"]') );
        $('#hid-driver-list').val( getSelectedCSV('#vehrev_rpt_driver [data-group="DRIVERS"]') );
        $('#hid-vehicle-tags').val( getSelectedCSV('#vehrev_rpt_vehicle [data-group="TAGS"]') );
        $('#hid-driver-tags').val( getSelectedCSV('#vehrev_rpt_driver [data-group="TAGS"]') );
        document.vehicle_revenue.target = "ifrm_downloader";
        document.vehicle_revenue.submit();
        return;
    }

    function getVehicleTransitReport() {
        $('#vehrev-rpt-list').html('');
        var data = {};
        data.fromDate = $('#vehrev_rpt_from').data('datepicker').getFormattedDate('yyyy-mm-dd');
        data.toDate = $('#vehrev_rpt_to').data('datepicker').getFormattedDate('yyyy-mm-dd');
        data.vehicleList = getSelectedCSV('#vehrev_rpt_vehicle [data-group="VEHICLES"]');
        data.driverList = getSelectedCSV('#vehrev_rpt_driver [data-group="DRIVERS"]');
        data.vehicleTags = getSelectedCSV('#vehrev_rpt_vehicle [data-group="TAGS"]');
        data.driverTags = getSelectedCSV('#vehrev_rpt_driver [data-group="TAGS"]');

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if (data.fromDate == '') {
            $('#vehrev_rpt_from').addClass('inp_error');
            err++;
        }
        if (data.toDate == '') {
            $('#vehrev_rpt_to').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#vehrev_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#vehrev_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#vehrev_rpt_action_state').show();
            return false;
        } else {
            $('#vehrev_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#vehrev_rpt_action_state').html('');
            $('#vehrev_rpt_action_state').hide();
        }

        $('#vehrev_rpt_to').removeClass('inp_error');
        $('#vehrev-rpt-list-container').removeClass('hidden');
        $('#vehrev-rpt-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/vehicle-revenue-report-list",
            data: data,
            success: function (response) {
                $('#vehrev-rpt-list').html(response);
                $('#vehrev_rpt_excel').show();
                $('html, body').animate({
                    scrollTop: $('#vehrev-rpt-list-container').offset().top - 35
                }, 'slow');
            }
        });
    }


    function clearVehicleTransitReport() {
        $('#vehrev_rpt_from').val('');
        $('#vehrev_rpt_to').val('');
        $('#vehrev_rpt_vehicle').val([]).multiselect('refresh');
        $('#vehrev_rpt_driver').val([]).multiselect('refresh');
        $('#vehrev-rpt-list-container').addClass('hidden');
        $('#vehrev-rpt-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#vehrev_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#vehrev_rpt_action_state').html('');
        $('#vehrev_rpt_action_state').hide();
        $('#vehrev_rpt_excel').hide();
    }
</script>
{/literal}