<div class="brand_top">
    <h3>Vehicle Tariff Report</h3>
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportVehicleTariffReport()"><i class="fa fa-download fa-lg"></i>Excel</button>  
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
                                                <form id='vehicle_tariff_report' method="post" name="vehicle_tariff_report" method="post" action="report/vehicle-tariff-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label class="req" for="from-date">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="from-date" readonly="true" placeholder="Date From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label class="req" for="to-date">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="to-date" readonly="true" placeholder="Date To">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>   

                                                        <div class="form-group col-md-2">
                                                            <label for="vehicle-tariff-vehicle" class="req">Vehicle</label>
                                                            <select class="form-control" name="vehicleCode" id="vehicle-tariff-vehicle">
                                                                <option value="">Select Vehicle</option>
                                                                {foreach from=$vehicle item=val}
                                                                    <option value="{$val->code}">{$val->registationNumber}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-3">
                                                            <label>&nbsp;</label>
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="generateVehicleTariffReport();" >Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearVehicleTariffReport();">Clear</button>
                                                        </div>
                                                    </div>
                                                </form>
                                                <br>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="vehicle-tariff-report-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="vehicle-tariff-report-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="vehicle-tariff-report-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<iframe id="ifrm_downloader" name="ifrm_downloader" style="display: none"></iframe>

<script>
    $('#from-date').datepicker({
        todayHighlight: true,
        format: 'yyyy-mm-dd',
        startDate: '-6m',
        autoclose: true,
        changeMonth: true,
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#to-date').datepicker('setStartDate', e.date);
        $("#to-date").datepicker("setEndDate", end)
    });
    $('#to-date').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'yyyy-mm-dd',
        maxDate: "+365D",
        autoclose: true
    }).on('changeDate', function (e) {
        $('#from-date').datepicker('setEndDate', e.date)
    });
    $('#vehicle-tariff-vehicle').select2();
    
    function generateVehicleTariffReport() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');
        $('#vehicle-tariff-report-list').html('');

        var data = {};
        data.fromDate = $('#from-date').val();
        data.toDate = $('#to-date').val();
        data.vehicleCode = $('#vehicle-tariff-vehicle').val();

        if ($('#from-date').val() == '') {
            $('#from-date').addClass('inp_error');
            err++;
        }

        if ($('#to-date').val() == '') {
            $('#to-date').addClass('inp_error');
            err++;
        }

        if (data.vehicleCode == '') {
            $('#vehicle-tariff-vehicle').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#vehicle-tariff-report-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#vehicle-tariff-report-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#vehicle-tariff-report-action-state').show();
            return false;
        } else {
            $('#vehicle-tariff-report-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#vehicle-tariff-report-action-state').html('');
            $('#vehicle-tariff-report-action-state').hide();
        }

        $('#vehicle-tariff-report-list-container').removeClass('hidden');
        $('#vehicle-tariff-report-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/vehicle-tariff-report-list",
            data: data,
            success: function (response) {
                $('#vehicle-tariff-report-list').html(response);
                $('#excl_cons').show();
            }
        });
    }

    function clearVehicleTariffReport() {
        $('#from-date').val('').datepicker('setEndDate', '');
        $('#to-date').val('').datepicker('setStartDate', '');
        $('#vehicle-tariff-vehicle').val('').trigger('change');

        $('#vehicle-tariff-report-list-container').addClass('hidden');
        $('#vehicle-tariff-report-list').html('');
        $('.inp_error').removeClass('inp_error');
        
        $('#vehicle-tariff-report-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#vehicle-tariff-report-action-state').html('');
        $('#vehicle-tariff-report-action-state').hide();
        $('#excl_cons').hide();
    }

    function exportVehicleTariffReport() {
        document.vehicle_tariff_report.target = "ifrm_downloader";
        $('#export').val(1);
        document.vehicle_tariff_report.submit();
        return;
    }
</script>