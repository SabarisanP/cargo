<div class="brand_top">
    <h3>Vehicle and Driver Allocation Report</h3> 
    <div class="text-right noprint" id="export-vehicle-driver" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportVehicleDriverExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div> 
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
                                            <form id="vehicle_driver_form" name="vehicle_driver_form" method="post" onsubmit="return false">
                                            <div class="row">   
                                                <div class="form-group col-md-2">
                                                    <label for="vehicle_driver_from">From Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="from" class="form-control sdate" id="vehicle_driver_from" readonly="true" placeholder="Date From">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <label for="vehicle_driver_to">To Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="to" class="form-control sdate" id="vehicle_driver_to" readonly="true" placeholder="Date To">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">    
                                                <div class="form-group col-md-2">
                                                    <label  for="vehicle_driver_to">Options</label>
                                                    <div class="input-group col-md-12">
                                                        <select id="vehicle_driver_dataopt" name="data_option"  class="form-control" >                                                                    
                                                            <option value="0">Allocation Info</option>
                                                            <option value="1">Occupancy Info</option>
                                                        </select>       
                                                    </div>
                                                </div>    
                                                <div class="form-group col-md-2">
                                                    <label  for="vehicle_driver_tag_filter">Tags</label>
                                                    <div class="input-group col-md-12">
                                                        <select id="vehicle_driver_tag_filter" name="tagCode"  class="form-control" >                                                                    
                                                            <option value="">Select Tags</option>
                                                            {foreach from=$tags item=row}
                                                                <option value="{$row->code}">{$row->name}</option>
                                                            {/foreach}
                                                        </select>       
                                                    </div>
                                                </div>
                                                
                                                <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="searchVehicleDriver()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearVehicleDriver()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="vehicle_driver_state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="vehicle-driver-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="vehicle-driver-list"></div>                                    
                            </div>
                        </div>
                    </div>
                </div>

            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_vehicle_driver" id="ifrm_vehicle_driver" style="display:none"></iframe>           

{literal}
    <script>
        $('#vehicle_driver_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-3m',
            endDate: '+3m',
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#vehicle_driver_to').datepicker('setStartDate', e.date);
            $("#vehicle_driver_to").datepicker("setEndDate", end)
        });
        $('#vehicle_driver_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            endDate: '+3m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#vehicle_driver_from').datepicker('setStartDate', start);
            $('#vehicle_driver_from').datepicker('setEndDate', e.date)
        });

        function searchVehicleDriver() {
            $('#vehicle-driver-list').html('');
            var data = {};
            data.from = $('#vehicle_driver_from').val();
            data.to = $('#vehicle_driver_to').val();
            data.data_option = $('#vehicle_driver_dataopt').val();
            data.tagCode = $('#vehicle_driver_tag_filter').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.from == '') {
                $('#vehicle_driver_from').addClass('inp_error');
                err++;
            }
            
            if (data.to == '') {
                $('#vehicle_driver_to').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#vehicle_driver_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#vehicle_driver_state').html('Please enter/select the values in the field that are marked in red');
                $('#vehicle_driver_state').show();
                return false;
            } else {
                $('#vehicle_driver_state').removeClass('alert-success').removeClass('alert-danger');
                $('#vehicle_driver_state').html('');
                $('#vehicle_driver_state').hide();
            }
            $('#vehicle-driver-list-container').removeClass('hidden');
            $('#vehicle-driver-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/vehicle-driver-allocation-list",
                data: data,
                success: function (response) {
                    $('#vehicle-driver-list').html(response);
                    $('#export-vehicle-driver').show();
                }
            });
        }
        
        function clearVehicleDriver() {
            $('#vehicle_driver_from').val('');
            $('#vehicle_driver_to').val('');
            $('#vehicle_driver_tag_filter').val('');
            $('#vehicle-driver-list-container').addClass('hidden');
            $('#vehicle-driver-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#vehicle_driver_state').removeClass('alert-success').removeClass('alert-danger');
            $('#vehicle_driver_state').html('');
            $('#vehicle_driver_state').hide();
            $('#export-vehicle-driver').hide();
        }

        function exportVehicleDriverExcel() {    
            document.vehicle_driver_form.action = "report/vehicle-driver-allocation-list";
            document.vehicle_driver_form.target = "ifrm_vehicle_driver";
            $('#export').val(1);
            document.vehicle_driver_form.submit();
            return;
        }
    </script>
{/literal}