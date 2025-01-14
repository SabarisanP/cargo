<div class="brand_top">
    <h3>
        {if $smarty.request.transitCode == ''}Add {lang('ogpl_local_transit')}{else}Edit {lang('ogpl_local_transit')}{/if}
    </h3>
    <span class="align-right">
        {if $smarty.request.transitCode == ''}
            <a href="#cargo/local-transit" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>            
        {else}
            <a href="#cargo/local-transit?fill=1" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>
        {/if}
    </span>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row" id="ogpl-form-div">
                        <br>
                        <div class="col-lg-8 col-lg-offset-2">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-12">

                                            <div class="row">
                                                {*<div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="ogpl-date" class="req">Date</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control sdate" id="ogpl-date" readonly="true" placeholder="Date" value="{$smarty.now|date_format:'%d-%m-%Y'}">
                                                            <label class="input-group-addon" for="ogpl-date"><i class="fa fa-calendar"></i></label>
                                                        </div>
                                                    </div>
                                                </div>*}
                                            </div>

                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="ogpl-from-branch" class="req">From Branch</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="ogpl-from-branch" class="form-control" disabled>
                                                                {foreach item=row from=$branches}
                                                                    {if $row->code == $login_branch}
                                                                        <option value="{$row->code}" selected="selected">{$row->name}</option>
                                                                    {/if}
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>         
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="ogpl-to-branch" class="req">To Branch</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="ogpl-to-branch" class="form-control">
                                                                <option value="" selected="">Select Branch</option>
                                                                {foreach item=row from=$branches}
                                                                    {if $row->station->code == $login_station && $row->code != $login_branch && $row->hubFlag}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/if}
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>                                                            
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="ogpl-vehicle" class="req">Vehicle</label>
                                                        <input type="text" id="ogpl-vehicle" class="form-control capitalize" placeholder="Select Vehicle" maxlength="12" {if isNotNull($linkVehicleCode)}disabled {else}onblur="getVehicleTransitList()"{/if}/>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="ogpl-driver-name" class="req">Driver Name</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="ogpl-driver-name" class="form-control">
                                                                <option value="" selected="">Select Driver</option>
                                                                {foreach item=row from=$drivers}
                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="ogpl-name" class="req">Name</label>
                                                        <input type="text" class="form-control" id="ogpl-name" placeholder="{lang('ogpl_local_transit')} Name" maxlength="20">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="ogpl-remarks">Remarks</label>
                                                    <input class="form-control" placeholder="Remarks (optional)" id="ogpl-remarks"/>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-6 hide" id="link-local-transit-div">
                                                    <input type="checkbox" id="link-local-transit">
                                                    <label for="link-local-transit" class="d-inline"></label>
                                                </div>
                                            </div>

                                            <div class="clearfix_both"></div><br/>
                                            <div class="row">
                                                <div class="col-md-9">
                                                    <div class="alert" id="ogpl-action-state" style="display: none"></div>
                                                </div>
                                                <div class="col-md-3 text-right">
                                                    <input type="hidden" id="hid-ogpl-code"/>
                                                    <button class="btn btn-success" type="button" onclick="proceedOGPL();">Next</button>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>

                    <div class="row" id="edit-ogpl-list-container" style="display: none;">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="edit-ogpl-list">
                                        <div class="row">
                                            <div class="col-md-3"><b>Name :</b> <span id="edit-ogpl-name"></span></div>
                                            <div class="col-md-3"><b>Date :</b> <span id="edit-ogpl-date"></span></div>
                                            {*<div class="col-md-3"><b>From :</b> <span id="edit-ogpl-from"></span></div>
                                            <div class="col-md-3"><b>To :</b> <span id="edit-ogpl-to"></span></div>*}
                                            <div class="col-md-3"><b>From Branch :</b> <span id="edit-ogpl-from-branch"></span></div>
                                            <div class="col-md-3"><b>To Branch :</b> <span id="edit-ogpl-to-branch"></span></div>
                                            <div class="col-md-3"><b>Vehicle :</b> <span id="edit-ogpl-vehicle"></span></div>
                                            <div class="col-md-3"><b>Driver :</b> <span id="edit-ogpl-driver"></span></div>
                                            <div class="col-md-6">
                                                {*<b>Via :</b> <span id="edit-ogpl-via"></span>*}
                                                <a href="javascript:;" class="btn pull-right bold" onclick="editOGPL();"><i class="fa fa-pencil"></i> Edit</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="add-ogpl-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="add-ogpl-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>


<script>
    var OGPLEdit = {$ogpl|json_encode};
    var Branches = {$branches|json_encode}
    var OGPLFormData = {};
    var OGPLVehicles = {$vehicles|json_encode};
    var linkVehicleCode = {$linkVehicleCode|json_encode};
    
    $('#ogpl-to-branch').select2();
    $('#ogpl-driver-name').select2();

    $('#ogpl-from-branch, #ogpl-to-branch').on('change input', function () {
        let fr = $('#ogpl-from-branch :selected:not([value=""])').text() || ''
        let to = $('#ogpl-to-branch :selected:not([value=""])').text() || ''
        $('#ogpl-name').val(fr + ' to ' + to)
    });

    {literal}
        var OGPLVehicleSource = [];
        $.each(OGPLVehicles || [], function (i, row) {
            if (row.activeFlag == 1) {
                OGPLVehicleSource.push({
                    label: row.registationNumber + ' - ' + row.vehicleType.name,
                    value: row.registationNumber,
                    code: row.code
                });
            }
        });
        
        $('#ogpl-vehicle').on('input', function() {
            this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
        });

        $('#ogpl-vehicle').autocomplete({
            minLength: 0,
            source: OGPLVehicleSource
        }).focus(function(){
            $(this).autocomplete('search', '');
        });

        if (linkVehicleCode) {
            var linkVehicle = _.find(OGPLVehicles, e => e.code == linkVehicleCode);
            var vehicleItem = $('#ogpl-vehicle').data('uiAutocomplete');
            vehicleItem.selectedItem = {};
            vehicleItem.selectedItem.value = linkVehicle.registationNumber;
            vehicleItem.selectedItem.code = linkVehicle.code;

            $('#ogpl-vehicle').val(linkVehicle.registationNumber).prop('disabled', true);
            getVehicleTransitList();
        }

        if (!$.isEmptyObject(OGPLEdit)) {
            $('#hid-ogpl-code').val(OGPLEdit.code);
            $('#ogpl-name').val(OGPLEdit.name);
            $('#ogpl-date').val(moment(OGPLEdit.tripDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('#ogpl-driver-name').val(OGPLEdit.vehicleDriver.code).trigger('change');
            $('#ogpl-remarks').val(OGPLEdit.remarks);

            var vehicleItem = $('#ogpl-vehicle').data('uiAutocomplete');
            vehicleItem.selectedItem = {};
            vehicleItem.selectedItem.value = OGPLEdit.busVehicle.registationNumber;
            vehicleItem.selectedItem.code = OGPLEdit.busVehicle.code || '';
            $('#ogpl-vehicle').val(OGPLEdit.busVehicle.registationNumber);

            $('#ogpl-from').val(OGPLEdit.fromStation.code);
            $('#ogpl-to').val(OGPLEdit.toStation.code);
            $.each(OGPLEdit.viaStations, function (i, val) {
                $('#ogpl-via').find('[value="' + val.code + '"]').attr('selected', true);
            });
            proceedOGPL();
        }

        $('#ogpl-date').datepicker({
            format: 'dd-mm-yyyy',
            autoclose: true,
            changeMonth: true,
            todayHighlight: true
        });

        $('#ogpl-driver-mobile').on('input', function () {
            this.value = this.value.replace(/\D/g, '');
        });

        $('#ogpl-from').select2();
        $('#ogpl-to').select2();
        $('#ogpl-via').select2({
            placeholder: 'Select Via Stations'
        });
        $('#ogpl-via .select2-choices').css('max-height', '400px');

        function proceedOGPL() {
            var data = {};
            data.activeFlag = 1;
            data.cargoActivityType = {};
            data.cargoActivityType.code = 'INTRNT';

            data.code = $('#hid-ogpl-code').val();
            data.name = $('#ogpl-name').val().trim();
            data.tripDate = moment().format('DD-MM-YYYY');
            data.remarks = $('#ogpl-remarks').val().trim();
            data.via = $('#ogpl-via').val();

            var vehicleItem = $('#ogpl-vehicle').data('uiAutocomplete');
            data.busVehicle = {};
            data.busVehicle.code = vehicleItem.selectedItem && vehicleItem.selectedItem.code;
            data.busVehicle.registationNumber = $('#ogpl-vehicle').val().toUpperCase();
            
            data.vehicleDriver = {};
            data.vehicleDriver.code = $('#ogpl-driver-name').val();
            data.vehicleDriver.name = $('#ogpl-driver-name option:selected').text();
            
            data.fromBranch = $('#ogpl-from-branch').val();
            data.toBranch = $('#ogpl-to-branch').val();

            data.fromOrganization = {};
            data.fromOrganization.code = $('#ogpl-from-branch').val();
            data.fromOrganization.name = $('#ogpl-from-branch option:selected').text();

            data.toOrganization = {};
            data.toOrganization.code = $('#ogpl-to-branch').val();
            data.toOrganization.name = $('#ogpl-to-branch option:selected').text();
    
            data.transitReference = [];
            if ($('#link-local-transit').is(':checked')) {
                data.transitReference.push({ code: $('#link-local-transit').val() })
            }

            $('#ogpl-form-div .inp_error').removeClass('inp_error');
            var err = 0;

            if (data.name == '') {
                $('#ogpl-name').addClass('inp_error');
                err++;
            }
            if (data.tripDate == '') {
                $('#ogpl-date').addClass('inp_error');
                err++;
            }
            if (data.toBranch == '') {
                $('#ogpl-to-branch').addClass('inp_error');
                err++;
            }
            if (!data.busVehicle.code && !data.busVehicle.registationNumber) {
                $('#ogpl-vehicle').addClass('inp_error');
                err++;
            }
            if (data.vehicleDriver.code == '') {
                $('#ogpl-driver-name').addClass('inp_error');
                err++;
            }
            if (data.fromBranch == data.toBranch) {
                $('#ogpl-to-branch').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#ogpl-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#ogpl-action-state').show();
                return false;
            }
            $('#ogpl-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#ogpl-action-state').hide();

            data.tripDate = moment(data.tripDate, 'DD-MM-YYYY').format('YYYY-MM-DD');
            OGPLFormData = data;

            $('#edit-ogpl-name').text(OGPLFormData.name);
            $('#edit-ogpl-date').text(moment(OGPLFormData.tripDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('#edit-ogpl-from').text($('#ogpl-from option:selected').text());
            $('#edit-ogpl-to').text($('#ogpl-to option:selected').text());
            $('#edit-ogpl-from-branch').text($('#ogpl-from-branch option:selected').text());
            $('#edit-ogpl-to-branch').text($('#ogpl-to-branch option:selected').text());
            $('#edit-ogpl-vehicle').text(data.busVehicle.registationNumber);
            $('#edit-ogpl-driver').text(OGPLFormData.vehicleDriver.name);
            $('#edit-ogpl-via').text($('#ogpl-via option:selected').map(function () {
                return $(this).text();
            }).get().join(', '));
            $('#ogpl-form-div').hide();
            $('#edit-ogpl-list-container').fadeIn('slow');
            $('#edit-ogpl-search-container').fadeIn('slow');
            $('#add-ogpl-list-container').removeClass('hidden');
            $('#add-ogpl-list').html(loading_popup);

            data = {};
            data.code = $('#hid-ogpl-code').val();

            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'cargo/booked-local-transit-list',
                data: data,
                success: function (response) {
                    $('#add-ogpl-list').html(response);
                }
            });
        }

        function editOGPL() {
            $('#ogpl-form-div').fadeIn('slow');
            $('#edit-ogpl-list-container').hide();
            $('#edit-ogpl-search-container').hide();
            $('#add-ogpl-list-container').addClass('hidden');
        }

        function getVehicleTransitList() {
            $('#link-local-transit-div').addClass('hide');

            var vehicleNo = cleanString($('#ogpl-vehicle').val());
            var vehicle = _.find(OGPLVehicles, e => cleanString(e.registationNumber) == vehicleNo);
            if (!vehicle) {
                return;
            }

            var data = {};
            data.vehicleCode = vehicle.code;
            if (!data.vehicleCode) {
                return;
            }

            $.ajax({
                type: "POST",
                url: base_url + 'cargo/get-vehicle-transit-details',
                data: data,
                dataType: 'json',
                success: function (response) {
                    if (response.status == 1) {
                        if (Array.isArray(response.data) && response.data.length == 1) {
                            $('label[for="link-local-transit"]').html('Link previous OGPL');
                            $('#link-local-transit-div').removeClass('hide');
                            $('#link-local-transit').val(response.data[0].code).prop('checked', isNotNull(linkVehicleCode));
                        }
                    }
                }
            });
        }
    {/literal}
</script>