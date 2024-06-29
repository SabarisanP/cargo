<div class="brand_top">
    <h3>Delivery Acknowledgement</h3>
    <div class="text-right noprint">
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="addDeliveryAckDialog();">Add Delivery Acknowledgement</a>
    </div>
</div>
<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-md-12"> <br>
                <!-- PAGE HEADER-->
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="col-md-12">
                                    <div class="">
                                        <div id="search-panel">
                                            <form id="delivery-ack-form" name="delivery-ack-form" method="post" onsubmit="return false">
                                                <div class="row">
                                                    <div class="form-group col-md-3">
                                                        <label for="delivery_ack_date_range">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="fromDate" class="form-control sdate" id="delivery_ack_date_range" readonly placeholder="Today" value="{implode(' | ', array_filter([$ffromDate|date_format:'%d-%m-%Y', $ftoDate|date_format:'%d-%m-%Y']))}">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="delivery-ack-from-branch">Sending Branch</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="delivery-ack-from-branch" class="form-control">
                                                                <option value="NA">All Branch</option>
                                                                {foreach from=$organizations item=row}
                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="delivery-ack-to-branch">Receiving Branch</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="delivery-ack-to-branch" class="form-control">
                                                                {foreach from=$organizations item=row}
                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="delivery-ack-status">Status</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="delivery-ack-status" class="form-control">
                                                                <option value="">Select Status</option>
                                                                <option value="INIT">Initial</option>
                                                                <option value="SENT">Sent</option>
                                                                <option value="RCVD">Received</option>
                                                                <option value="MSNG">Missing</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <button class="btn btn-success" type="button" onclick="generateDeliveryAck()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearDeliveryAck()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="delivery-ack-action-state"></div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="delivery-ack-list-container">
                    <br>
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="delivery-ack-list"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="add-delivery-ack-dialog" class="dialog-content-page hide">
    <div class="row">
        <div class="col-md-10 bold ft_15">
            Add Delivery Acknowledgement
        </div>
    </div>
    <br>
    <div style="">
        <div class="row">
            <div class="form-group col-md-3">
                <label class="req" for="delivery-ack-name">Name</label>
                <input type="text" name="delivery-ack-name" value="" class="form-control" id="delivery-ack-name" autocomplete="off" placeholder="Name">
            </div>

            <div class="form-group col-md-3">
                <label class="req" for="delivery-ack-from-org">Sending Branch</label>
                <select id="delivery-ack-from-org" class="form-control">
                    <option value="">Select Branch</option>
                    {foreach from=$organizations item=row}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>

            <div class="form-group col-md-3">
                <label class="req" for="delivery-ack-to-org">Receiving Branch</label>
                <select id="delivery-ack-to-org" class="form-control">
                    {foreach from=$organizations item=row}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>

            <div class="form-group col-md-3">
                <label class="req" for="delivery-ack-supervisor">Supervisor</label>
                <select id="delivery-ack-supervisor" class="form-control">
                    <option value="">Select Supervisor</option>
                </select>
            </div>
        </div>

        <div class="row">
            <div class="hide" id="lr-filter">
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="delivery-ack-to-date" class="req">From Date</label>
                        <div class="input-group">
                            <input type="text" class="form-control sdate" id="delivery-ack-lr-fromdate" readonly="true" placeholder="From Date">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="delivery-ack-to-date" class="req">To Date</label>
                        <div class="input-group">
                            <input type="text" class="form-control sdate" id="delivery-ack-lr-todate" readonly="true" placeholder="To Date">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <div class="">
                            <button class="btn btn-success" id="delivery-ack-save-button" type="button" onclick="generateDeliveryAckLr();">Generate</button>
                            <button class="btn btn-default" type="button" onclick="showLrFilter();">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-12">
                <div class="form-group" style="height: 150px;overflow-y: auto;">
                    <div class="overflow-x-auto hide" id="delivery-ack-div" style="height: 150px;overflow-y: auto;">
                        <div onclick="showLrFilter();" style="background: #ECF0F1;cursor: pointer;">
                            &nbsp;<i class="fa fa-filter pull-right" style="padding-top: 4px;padding-right: 4px;"></i>
                        </div>
                        <div id="delivery-ack-lr"></div>
                    </div>
                    <div id="delivery-ack-info">
                        <br><br>
                        <div class="well">
                            <i class="fa fa-info-circle"></i> Please Select Sending Branch
                        </div>
                    </div>
                </div>
                <br>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-3">
                <label class="req" for="delivery-ack-vehicle">Vehicle</label>
                <select id="delivery-ack-vehicle" class="form-control">
                    <option value="">Select Vehicle</option>
                    {foreach item=row from=$vehicles}
                        {if $row->activeFlag == 1}
                            <option value="{$row->code}">{$row->registationNumber} - {$row->vehicleType->name}</option>
                        {/if}
                    {/foreach}
                </select>
            </div>

            <div class="form-group col-md-3">
                <label class="req" for="delivery-ack-driver">Driver</label>
                <select id="delivery-ack-driver" class="form-control">
                    <option value="">Select driver</option>
                    {foreach from=$drivers item=val}
                        <option value="{$val->code}">{$val->name}</option>
                    {/foreach}
                </select>
            </div>

            <div class="form-group col-md-3">
                <label class="req" for="delivery-ack-transaction-date">Transaction Date</label>
                <div class="input-group">
                    <input type="text" class="form-control sdate" id="delivery-ack-transaction-date" readonly placeholder="Transaction Date">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-12">
                <label>Remarks</label>
                <textarea id="delivery-ack-remarks" placeholder="Enter your remarks" style="resize:none" class="form-control" rows="2" cols="30" name="remark" id="remark"></textarea>
            </div>
        </div>
    </div>
    <div style="padding:0 15px;">
        <div class="row">
            <input type="hidden" id="delivery-ack-code">
            <div class="clear_fix_both">
                <div class="alert hide" id="delivery-acknowledge-action-state"></div>
                <div class="align-right">
                    <button class="btn btn-success" id="delivery-ack-save-button" type="button" onclick="saveDeliveryAck();">Save</button>
                    <button class="btn btn-default" type="button" onclick="closeDeliveryAckDialog();">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="delivery-ack-status-dialog" class="dialog-content-page hide">
    <div class="row">
        <div class="col-md-10 bold ft_14">
            Edit Delivery Acknowledgement Status
        </div><br><br>
    </div>
    <div>
        <div class="row">
            <div class="col-lg-5">
                <div class="form-group text-left">
                    <label for="delivery-ack-edit-status" class="req">Status</label>
                    <select class="form-control" id="delivery-ack-edit-status">
                        <option value="INIT">Initial</option>
                        <option value="SENT">Sent</option>
                        <option value="RCVD">Received</option>
                        <option value="MSNG">Missing</option>
                        <option value="CNCL">Cancel</option>
                    </select>
                </div>
            </div>

            <div class="col-lg-5 hide" id="received-date">
                <div class="form-group">
                    <label class="req" for="delivery-ack-received-date">Received Date</label>
                    <div class="input-group">
                        <input type="text" class="form-control sdate" id="delivery-ack-received-date" readonly placeholder="Received Date">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>
            </div>
        </div>

        {* <div class="row">        
            <div class="col-lg-12"> 
                <label>Remarks</label>
                <textarea id="edt-cheque-remarks"  placeholder="Enter your remarks" style="resize:none" class="form-control" rows="3" cols="30" name="remark" id="remark"></textarea>
            </div>                                 
        </div> *}
        <br>

        <div class="row">
            <div class="col-lg-12">
                <div class="clear_fix_both">
                    <div class="alert hide" id="edit-status-action-state"></div>
                    <input type="hidden" id="delivery-ack-edit-code">
                    <div class="align-right" id="delivery-ack-status-form-buttons">
                        <button class="btn btn-success" type="button" onclick="updateDeliveryAckStatus();">Save</button>
                        <button class="btn btn-default" type="button" onclick="closeDeliveryAckStatusDialog();">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var toBranchOption = $('#delivery-ack-to-branch option');
    var emptyOption = '<option value="NA">All Branch</option>';

    var toOrgOption = $('#delivery-ack-to-org option');
    var emptyOrgOption = '<option value="">Select Branch</option>';

    var statusOption = $('#delivery-ack-edit-status option');
    var emptyStatusOption = '<option value="">Select Status</option>';
</script>

{literal}
    <script>
        $('#delivery-ack-from-branch, #delivery-ack-to-branch, #delivery-ack-from-org, #delivery-ack-to-org, #delivery-ack-vehicle, #delivery-ack-driver, #delivery-ack-supervisor').select2();
        
        $('#delivery_ack_date_range').daterangepicker({
        buttonClasses: ['btn', 'btn-xs'],
        format: 'DD-MM-YYYY',
        separator: ' | ',
        ranges: {
            'Today': [moment(), moment()],
            'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Last 7 Days': [moment().subtract(6, 'days'), moment()],
            'Last 30 Days': [moment().subtract(29, 'days'), moment()],
        },
        }).on('show.daterangepicker', function (ev, picker) {
            picker.showCalendars()
        });

        $('#delivery-ack-transaction-date').datepicker({
            todayHighlight: true,
            format: 'dd-mm-yyyy',
            autoclose: true,
            endDate: '0d'
        });

        $('#delivery-ack-received-date').daterangepicker({
            singleDatePicker: true,
            timePicker: true,
            timePickerIncrement: 1,
            format: 'DD-MM-YYYY hh:mm A',
            startDate: moment(),
            maxDate: moment(),
            autoApply: false,
            showDropdowns: false,
        });

        $('#delivery-ack-lr-fromdate').datepicker({
            format: 'yyyy-mm-dd',
            // startDate: '-3m',
            // endDate: "+3m",
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function(e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 90));
            $('#delivery-ack-lr-todate').datepicker('setStartDate', e.date);
            $("#delivery-ack-lr-todate").datepicker("setEndDate", end)
        });

        $('#delivery-ack-lr-todate').datepicker({
            // startDate: '-3m',
            // endDate: "+3m",
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function(e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 90));
            $('#delivery-ack-lr-fromdate').datepicker('setStartDate', start);
            $('#delivery-ack-lr-fromdate').datepicker('setEndDate', e.date)
        });


        $('#delivery-ack-from-branch').on('change', function() {
            var fromBranch = $(this).val();
            $('#delivery-ack-to-branch').html(function() {
                return toBranchOption.filter(function() {
                    return $(this).val() !== fromBranch;
                });
            }).prepend(emptyOption).val('NA').trigger('change');
        }).trigger('change');

        $('#delivery-ack-from-org').on('change', function() {
            var fromBranch = $(this).val();
            $('#delivery-ack-to-org').html(function() {
                return toOrgOption.filter(function() {
                    return $(this).val() !== fromBranch;
                });
            }).prepend(emptyOrgOption).val('').trigger('change');
        }).trigger('change');

        $('#delivery-ack-from-org').on('change', function() {
            generateDeliveryAckLr();
        });

        $('#delivery-ack-to-org').on('change', function() {
            var data = {};
            data.organizationCode = $(this).val();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/get-branch-supervisor',
                data: data,
                success: function(res) {
                    $('#delivery-ack-supervisor').find('option').not(':first').remove();
                    $('#delivery-ack-supervisor').val('').trigger('change');
                    if (data.organizationCode != '') {
                        $.each(res.data, function(key, val) {
                            $('#delivery-ack-supervisor').append(new Option(val.name, val.code));
                        });
                    }
                }
            });
        });

        $('#delivery-ack-edit-status').on('change', function() {
            $('#received-date').addClass('hide');
            $('#delivery-ack-received-date').val('');
            if ($(this).val() == 'RCVD') {
                $('#received-date').removeClass('hide');
            }
        });

        function generateDeliveryAck() {
            $('#delivery-ack-list').html('');
            var data = {};
            var daterange = $('#delivery_ack_date_range').data('daterangepicker');
            data.fromDate = daterange.startDate.format('DD-MM-YYYY');
            data.toDate = daterange.endDate.format('DD-MM-YYYY');
            data.fromOrganizationCode = $('#delivery-ack-from-branch').val();
            data.toOrganizationCode = $('#delivery-ack-to-branch').val();
            data.statusCode = $('#delivery-ack-status').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');
           
            if (err > 0) {
                $('#delivery-ack-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#delivery-ack-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#delivery-ack-action-state').show();
                return false;
            }

            $('#delivery-ack-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#delivery-ack-action-state').html('').hide();

            $('#delivery-ack-list-container').removeClass('hidden');
            $('#delivery-ack-list').html(loading_popup);

            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'cargo/delivery-acknowledgement-list',
                data: data,
                success: function(response) {
                    $('#delivery-ack-list').html(response);
                }
            });
        }

        function clearDeliveryAck() {
            $('#delivery_ack_date_range').val('');
            $('#delivery_ack_date_range').data('daterangepicker').setStartDate({});
            $('#delivery_ack_date_range').data('daterangepicker').setEndDate({});
            $('#delivery-ack-status').val('');
            $('#delivery-ack-from-branch, #delivery-ack-to-branch').val('NA').trigger('change')

            $('#delivery-ack-list-container').addClass('hidden');
            $('#delivery-ack-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#delivery-ack-action-state').removeClass('alert-success, alert-danger').html('').hide();
        }

        function addDeliveryAckDialog(code) {
            $('#add-delivery-ack-dialog').css('background', '#fff');
            $('#add-delivery-ack-dialog').removeClass('hide');
            $('#add-delivery-ack-dialog').dialog({
                autoOpen: true,
                height: 600,
                width: $(window).width() - 500,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();
            $('.inp_error').removeClass('inp_error');
            $('#delivery-acknowledge-action-state').removeClass('alert-success, alert-danger').html('').hide();

            $('#delivery-ack-code, #delivery-ack-name, #delivery-ack-transaction-date, #delivery-ack-remarks').val('');
            $('#delivery-ack-vehicle, #delivery-ack-from-org, #delivery-ack-to-org, #delivery-ack-supervisor, #delivery-ack-driver').val('').trigger('change');
            $('.lr-check').attr('checked', false);
        }

        function closeDeliveryAckDialog() {
            $('#add-delivery-ack-dialog').addClass('hide');
            $('#add-delivery-ack-dialog').dialog('destroy');
        }

        function saveDeliveryAck() {
            var data = {};
            data.code = $('#delivery-ack-code').val();
            data.activeFlag = 1;
            data.name = $('#delivery-ack-name').val();

            data.vehicle = {};
            data.vehicle.code = $('#delivery-ack-vehicle').val();

            data.fromOrganization = {};
            data.fromOrganization.code = $('#delivery-ack-from-org').val();

            data.toOrganization = {};
            data.toOrganization.code = $('#delivery-ack-to-org').val();

            data.supervisor = {};
            data.supervisor.code = $('#delivery-ack-supervisor').val();

            data.driver = {};
            data.driver.code = $('#delivery-ack-driver').val();

            data.transactionDate = moment($('#delivery-ack-transaction-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
            data.remarks = $('#delivery-ack-remarks').val();

            data.cargoList = [];
            $('#delivery-ack-lr-table .lr-check:checked').each(function() {
                var lrcode = $(this).val();
                data.cargoList.push({ code: lrcode });
            });

            var err = 0;
            $('.inp_error').removeClass('inp_error');
            if (data.name == '') {
                $('#delivery-ack-name').addClass('inp_error');
                err++;
            }

            if (data.vehicle.code == '') {
                $('#delivery-ack-vehicle').addClass('inp_error');
                err++;
            }

            if (data.fromOrganization.code == '') {
                $('#delivery-ack-from-org').addClass('inp_error');
                err++;
            }

            if (data.toOrganization.code == '') {
                $('#delivery-ack-to-org').addClass('inp_error');
                err++;
            }

            if (data.supervisor.code == '') {
                $('#delivery-ack-supervisor').addClass('inp_error');
                err++;
            }

            if (data.driver.code == '') {
                $('#delivery-ack-driver').addClass('inp_error');
                err++;
            }

            if ($('#delivery-ack-transaction-date').val() == '') {
                $('#delivery-ack-transaction-date').addClass('inp_error');
                err++;
            }

            if (data.fromOrganization.code != '') {
                if (data.cargoList.length == 0) {
                    $('#delivery-acknowledge-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#delivery-acknowledge-action-state').html('Please select atleast one LR!!!');
                    $('#delivery-acknowledge-action-state').show();
                    return false;
                }
            }

            if (err > 0) {
                $('#delivery-acknowledge-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#delivery-acknowledge-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#delivery-acknowledge-action-state').show();
                return false;
            }

            $('#delivery-acknowledge-action-state').removeClass('alert-success, alert-danger, hide');
            $('#delivery-acknowledge-action-state').html(loading_popup).show();
            $('#delivery-ack-save-button').addClass('disabled');

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/update-delivery-acknowledgement',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $('#delivery-acknowledge-action-state').removeClass('alert-danger');
                        $('#delivery-acknowledge-action-state').addClass('alert-success');
                        $('#delivery-acknowledge-action-state').html('Your request has been completed successfully');
                        window.setTimeout(function() {
                            closeDeliveryAckDialog();
                            checkURL();
                            return;
                        }, 3000);
                    } else {
                        $('#delivery-acknowledge-action-state').addClass('alert-danger');
                        $('#delivery-acknowledge-action-state').html(response.errorDesc);
                        $('#delivery-ack-form-buttons').removeClass('disabled');
                    }
                }
            });
        }

        function editStatusDialog(code, status) {
            $('#delivery-ack-status-dialog').css('background', '#fff');
            $('#delivery-ack-status-dialog').removeClass('hide');
            $('#delivery-ack-status-dialog').dialog({
                autoOpen: true,
                height: 275,
                width: 600,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();
            $('#edt-cheque-data').val('');

            $('#edit-status-action-state').removeClass('alert-danger').addClass('hide').html('');
            $('.inp_error').removeClass('inp_error');
            $('#delivery-ack-edit-status').val(status).trigger('change');
            $('#delivery-ack-edit-code').val(code);

            $('#delivery-ack-edit-status').html(function() {
                return statusOption.filter(function() {
                    if (status != 'SENT' && status != 'RCVD') {
                        return $(this).val() !== 'RCVD';
                    } else {
                        return $(this).val();
                    }
                });
            }).prepend(emptyStatusOption).val(status).trigger('change');
        }

        function closeDeliveryAckStatusDialog() {
            $('#delivery-ack-status-dialog').addClass('hide');
            $('#delivery-ack-status-dialog').dialog('destroy');
        }

        function updateDeliveryAckStatus() {
            var data = {};
            data.code = $('#delivery-ack-edit-code').val();
            data.activeFlag = 1;

            data.status = {};
            data.status.code = $('#delivery-ack-edit-status').val();
            data.receivedAt = $('#delivery-ack-received-date').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');
            if (data.status.code == '') {
                $('#delivery-ack-edit-status').addClass('inp_error');
                err++;
            }

            if (data.status.code == 'RCVD' && $('#delivery-ack-received-date').val() == '') {
                $('#delivery-ack-received-date').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#edit-status-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#edit-status-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#edit-status-action-state').show();
                return false;
            }

            $('#edit-status-action-state').removeClass('alert-success, alert-danger, hide');
            $('#edit-status-action-state').html(loading_popup).show();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/update-delivery-acknowledgement-status',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $('#edit-status-action-state').removeClass('alert-danger');
                        $('#edit-status-action-state').addClass('alert-success');
                        $('#edit-status-action-state').html('Your request has been completed successfully');
                        window.setTimeout(function() {
                            closeDeliveryAckStatusDialog();
                            generateDeliveryAck();
                            return;
                        }, 3000);
                    } else {
                        $('#edit-status-action-state').addClass('alert-danger');
                        $('#edit-status-action-state').html(response.errorDesc);
                    }
                }
            });
        }

        function generateDeliveryAckLr() {
            var fromDate = $('#delivery-ack-lr-fromdate').val();
            var toDate = $('#delivery-ack-lr-todate').val();

            var data = {};
            data.fromDate = fromDate ? fromDate : moment().subtract(3, 'M').format('YYYY-MM-DD');
            data.toDate = toDate ? toDate : moment().format('YYYY-MM-DD');
            data.organizationCode = $('#delivery-ack-from-org').val();

            $('#delivery-ack-div').removeClass('hide');
            $('#delivery-ack-lr').removeClass('hide').html('');
            $('#delivery-ack-lr').html(loading_popup).show();

            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'cargo/get-delivery-acknowledgement-lr',
                data: data,
                success: function(response) {
                    if (data.organizationCode != '') {
                        $('#delivery-ack-lr').removeClass('hide').html(response);
                        $('#delivery-ack-div').removeClass('hide');
                        $('#delivery-ack-info').addClass('hide');
                    } else {
                        $('#delivery-ack-lr').addClass('hide').html('');
                        $('#delivery-ack-div').addClass('hide');
                        $('#delivery-ack-info').removeClass('hide');
                    }
                }
            });
        }

        function showLrFilter() {
            $('#delivery-ack-lr-fromdate, #delivery-ack-lr-todate').val('');
            $('#delivery-ack-lr-fromdate, #delivery-ack-lr-todate').datepicker('setStartDate', '');
            $("#delivery-ack-lr-fromdate, #delivery-ack-lr-todate").datepicker("setEndDate", '')
            $('#lr-filter').toggleClass('hide');
        }

        function showacknowledgementPdfDialog(code) {
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
            $iframe.attr('src', base_url + 'cargo/delivery-acknowledgement-print?Code=' + code);
            $iframe.attr('class', 'iframe-fullwidth iframe-loading-bg');
            $('#cargo-invoice-iframe').html($iframe);
        }
    </script>
{/literal}