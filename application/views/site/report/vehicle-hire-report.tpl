<div class="brand_top">
    <h3>Vehicle Hire Report</h3>
    {* <div class="text-right noprint hide" id="vehicle-hire-report-excel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportVehicleHireExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div> *}
</div>
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
                                            <form id='vehicle-hire-report' name="vehicle-hire-report" method="post" action="report/vehicle-hire-report-list" onsubmit="return false">
                                                <div class="row">   
                                                    <div class="form-group col-md-2">
                                                        <label class="req" for="vehicle-hire-from-date">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="fromDate" class="form-control sdate" id="vehicle-hire-from-date" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label class="req" for="vehicle-hire-to-date">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="toDate" class="form-control sdate" id="vehicle-hire-to-date" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>   

                                                    <div class="form-group col-md-2">
                                                        <label for="vehicle-hire-transit-type" class="">Transit Type</label>
                                                        <select class="form-control" name="transitType" id="vehicle-hire-transit-type">
                                                            <option value="TRNT">OGPL</option>
                                                            <option value="INTRNT">Local Transit</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-2">
                                                        <label  for="vehicle-hire-own-type" class="">Ownership Type</label>
                                                        <select class="form-control" id="vehicle-hire-own-type">
                                                            <option value="NA">Select Ownership Type</option>
                                                            {foreach from=$cargotags item=val}
                                                                <option value="{$val->code}">{$val->name}</option>
                                                            {/foreach}
                                                        </select>  
                                                    </div>
                                                    
                                                    <div class="form-group col-md-2">
                                                        <label for="vehicle-hire-transporter" class="">Transporter</label>
                                                        <select name="transporter" class="form-control" id="vehicle-hire-transporter">
                                                            <option value="NA">All Transporter</option>
                                                            {foreach name=o item=row from=$transporter}
                                                                <option value="{$row->code}" data-owntype="{$row->tag[0]->code}">{$row->name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="vehicle-hire-vehicle" class="">Vehicle</label>
                                                        <select class="form-control" name="vehicle" id="vehicle-hire-vehicle">
                                                            <option value="NA">All Vehicle</option>
                                                            {foreach from=$vehicle item=val}
                                                                <option value="{$val->code}" data-transporter="{$val->transporterContact->code}">{$val->name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>

                                                    <div class="form-group col-md-6">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            {* <input type="hidden" name="export" id="export" value="1"> *}
                                                            <button class="btn btn-success" type="button"  onclick="generateVehicleHireReport()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearVehicleHireReport()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <br class="clear_fix_both">
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="vehicle-hire-report-action-state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                                        
                
                <div class="row hidden" id="vehicle-hire-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="vehicle-hire-list"></div>
                            </div>
                        </div>
                    </div>
                </div>
                                        
            </div>                    
        </div>
    </div>            
</div>
{* <iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe> *}

<script>
    var transporterOptions = $('#vehicle-hire-transporter option');
    var vehicleOptions = $('#vehicle-hire-vehicle option');
    var transporterEmptyOption = '<option value="NA">All Transporter</option>';
    var vehicleEmptyOption = '<option value="NA">All Vehicle</option>';

    $('#vehicle-hire-from-date').datepicker({
        todayHighlight: true,
        format: 'yyyy-mm-dd',
        startDate: '-6m',
        autoclose: true,
        changeMonth: true,
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#vehicle-hire-to-date').datepicker('setStartDate', e.date);
        $("#vehicle-hire-to-date").datepicker("setEndDate", end)
    });
    $('#vehicle-hire-to-date').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'yyyy-mm-dd',
        maxDate: "+365D",
        autoclose: true
    }).on('changeDate', function (e) {
        $('#vehicle-hire-from-date').datepicker('setEndDate', e.date)
    });
    
    $('#vehicle-hire-transporter').select2();
    $('#vehicle-hire-vehicle').select2();

    // transporter
    $('#vehicle-hire-own-type').on('change', function () {
        var ownType = $(this).val();
        $('#vehicle-hire-transporter').html(function () {
            return transporterOptions.filter(function () {
                return $(this).data('owntype') === ownType;
            });
        }).prepend(transporterEmptyOption).val('NA').trigger('change');
    }).trigger('change');

    // vehicle
    $('#vehicle-hire-transporter').on('change', function () {
        var transporter = $(this).val();
        $('#vehicle-hire-vehicle').html(function () {
            return vehicleOptions.filter(function () {
                return $(this).data('transporter') === transporter;
            });
        }).prepend(vehicleEmptyOption).val('NA').trigger('change');
    }).trigger('change');
    
    function generateVehicleHireReport() {
        $('#vehicle-hire-list').html('');
        var data = {};
        data.fromDate = $('#vehicle-hire-from-date').val();
        data.toDate = $('#vehicle-hire-to-date').val();
        data.transitTypeCode = $('#vehicle-hire-transit-type').val();
        data.ownerShipType = $('#vehicle-hire-own-type').val();
        data.transporterCode = $('#vehicle-hire-transporter').val();
        data.vehicleCode = $('#vehicle-hire-vehicle').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');
    
        if (data.fromDate == '') {
            $('#vehicle-hire-from-date').addClass('inp_error');
            err++;
        }
        if (data.toDate == '') {
            $('#vehicle-hire-to-date').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#vehicle-hire-report-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#vehicle-hire-report-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#vehicle-hire-report-action-state').show();
            return false;
        } else {
            $('#vehicle-hire-report-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#vehicle-hire-report-action-state').html('');
            $('#vehicle-hire-report-action-state').hide();
        }
        
        $('#vehicle-hire-list-container').removeClass('hidden');
        $('#vehicle-hire-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/vehicle-hire-report-list",
            data: data,
            success: function (response) {
                $('#vehicle-hire-list').html(response);
                // $('#zone_rcv_rpt_excel').removeClass('hide');
            }
        })
    }

    function clearVehicleHireReport() {
        $('#vehicle-hire-from-date').val('').datepicker('setEndDate', '');
        $('#vehicle-hire-to-date').val('').datepicker('setStartDate', '');

        $('#vehicle-hire-transit-type').val('TRNT');
        $('#vehicle-hire-own-type').val('NA').trigger('change');
        $('#vehicle-hire-list-container').addClass('hidden');
        $('#vehicle-hire-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#vehicle-hire-report-action-state').removeClass('alert-success').removeClass('alert-danger').hide().html('');
        // $('#zone_rcv_rpt_excel').addClass('hide');
    }

    // function exportVehicleHireExcel() {
    //     document.zone_rcv_rpt_form.target = "ifrm_downloader";
    //     $('#export').val(1);
    //     document.zone_rcv_rpt_form.submit();
    //     return;
    // }
</script>

