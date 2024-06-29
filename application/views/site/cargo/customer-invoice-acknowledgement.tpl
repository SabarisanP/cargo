<div class="brand_top">
    <h3>Customer Invoice Acknowledgement</h3>
    <div class="text-right noprint">
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="addInvAckDialog();">Add Invoice Acknowledgement</a>
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
                                            <form id="invoice-ack-form" name="invoice-ack-form" method="post" onsubmit="return false">
                                                <div class="row">
                                                    <div class="form-group col-md-3">
                                                        <label for="invoice_ack_date_range">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="fromDate" class="form-control sdate" id="invoice_ack_date_range" readonly placeholder="Today" value="{implode(' | ', array_filter([$ffromDate|date_format:'%d-%m-%Y', $ftoDate|date_format:'%d-%m-%Y']))}">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label  for="invoice-ack-vendor-filter">Vendor</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="invoice-ack-vendor-filter" class="form-control">
                                                                <option value="NA">All Vendor</option>
                                                                {foreach from=$vendors item=row}
                                                                    <option value="{$row->code}">{$row->companyName}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label  for="invoice-ack-branch-filter">Branch</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="invoice-ack-branch-filter" class="form-control">
                                                                <option value="NA">All Branch</option>
                                                                {foreach from=$organizations item=row}
                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label  for="invoice-ack-status">Status</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="invoice-ack-status" class="form-control">
                                                                <option value="">Select Status</option>
                                                                {foreach from=$invoice_acknowledgement_status item=val key=key}
                                                                    <option value="{$key}">{$val}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <button class="btn btn-success" type="button"  onclick="generateInvoiceAck()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearInvoiceAck()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="invoice-ack-filter-action-state"></div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="invoice-ack-list-container">
                    <br>
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="invoice-ack-list"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="add-invoice-ack-dialog"  class="dialog-content-page hide">
    <div class="row">
        <div class="col-md-10 bold ft_15">
            Add invoice Acknowledgement
        </div>
    </div>
    <br>
    <div style="">
        <div class="row">
            <div class="form-group col-md-3">
                <label class="req" for="invoice-ack-name">Name</label>
                <input type="text" name="invoice-ack-name" value="" class="form-control" id="invoice-ack-name" autocomplete="off" placeholder="Name">
            </div>
            
            <div class="form-group col-md-3">
                <label class="req" for="invoice-ack-vendor">Vendor</label>
                <select id="invoice-ack-vendor" class="form-control">
                    <option value="">Select Vendor</option>
                    {foreach from=$vendors item=row}
                        <option value="{$row->code}">{$row->companyName}</option>
                    {/foreach}
                </select>
            </div>
            
            <div class="form-group col-md-3">
                <label class="req" for="invoice-ack-supervisor">Supervisor</label>
                <select id="invoice-ack-supervisor" class="form-control">
                    <option value="">Select Supervisor</option>
                    {foreach from=$supervisor item=$val}
                        <option value="{$val->code}">{$val->name}</option>
                    {/foreach}
                </select>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="form-group" style="height: 150px;overflow-y: auto;">
                    <div class="overflow-x-auto hide" id="invoice-ack-inv" style="height: 150px;overflow-y: auto;"></div>
                    <div id="invoice-ack-info">
                        <br><br>
                        <div class="well">
                            <i class="fa fa-info-circle"></i> Please select a vendor
                        </div>
                    </div>
                </div>
                <br>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-3">
                <label class="req" for="invoice-ack-transaction-date">Transaction Date</label>
                <div class="input-group">
                    <input type="text" class="form-control sdate" id="invoice-ack-transaction-date" readonly placeholder="Transaction Date">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>

            <div class="form-group col-md-3">
                <label class="req" for="invoice-ack-communication">Contact Mode</label>
                <select id="invoice-ack-communication" class="form-control">
                    <option value="">Select Contact Mode</option>
                    <option value="DRCT">Direct</option>
                    <option value="WTAP">WhatsApp</option>
                    <option value="MAIL">E-Mail</option>
                </select>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-12">
                <label>Remarks</label>
                <textarea id="invoice-ack-remarks"  placeholder="Enter your remarks" style="resize:none" class="form-control" rows="2" cols="30" name="remark" id="remark"></textarea>
            </div>
        </div>
    </div>
    <div style="padding:0 15px;">
        <div class="row">
            <input type="hidden" id="invoice-ack-code">
            <div class="clear_fix_both">
                <div class="alert hide" id="invoice-ack-action-state"></div>
                <div class="align-right">
                    <button class="btn btn-success" id="invoice-ack-save-button" type="button" onclick="saveinvoiceAck();">Save</button>
                    <button class="btn btn-default" type="button" onclick="closeinvoiceAckDialog();">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="invoice-ack-status-dialog"  class="dialog-content-page hide">
    <div class="row">
        <div class="col-md-10 bold ft_14">
            Edit Invoice Acknowledgement Status 
        </div><br><br>
    </div>
    <div>
        <div class="row">
            <div class="col-lg-4">
                <div class="form-group text-left">
                    <label for="invoice-ack-edit-status" class="req">Status</label>
                    <select class="form-control" id="invoice-ack-edit-status">
                        <option value="">Select Status</option>
                        {foreach from=$invoice_acknowledgement_status item=val key=key}
                            {if $action_rights['UPDT-CMPLT-ON-SBMT'] == 1}
                                {if in_array($key, ['CRT', 'SBMT', 'CNCL'])}
                                    <option value="{$key}">{$val}</option>
                                {/if}
                            {else}
                                <option value="{$key}">{$val}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>
            </div> 

            <div class="hide" id="submitted-details">
                <div class="col-lg-4">
                    <div class="form-group">
                        <label class="req" for="invoice-ack-submitted-date">Submitted Date</label>
                        <div class="input-group">
                            <input type="text" class="form-control sdate" id="invoice-ack-submitted-date" readonly placeholder="Submitted Date">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="form-group">
                        <label class="req" for="invoice-ack-submitted-to">Handover Person Name</label>
                        <input type="text" class="form-control" id="invoice-ack-submitted-to" placeholder="Handover Person Name">
                    </div>
                </div>
            </div>

            <div class="col-lg-4 hide" id="completed-date">
                <div class="form-group">
                    <label class="req" for="invoice-ack-completed-date">Completed Date</label>
                    <div class="input-group">
                        <input type="text" class="form-control sdate" id="invoice-ack-completed-date" readonly placeholder="Completed Date">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>
            </div>
            
            <div class="col-md-12">
                <div class="form-group">
                    <label>Remarks</label>
                    <textarea id="invoice-ack-edit-remarks"  placeholder="Enter your remarks" style="resize:none" class="form-control" rows="2" cols="30" name="remark" id="remark"></textarea>
                </div>
            </div>
            <div class="col-md-12 hide" id="inv-ack-attachments">
                <div class="form-group">
                    {include file="site/cargo/file-upload-component.tpl" id="ie-fileupload" axis="horizontal"}
                </div>
            </div>
        </div>
        <br>

        <div class="row">
            <div class="col-lg-12">
                <div class="clear_fix_both">                       
                    <div class="alert hide" id="edit-status-action-state"></div>
                    <input type="hidden" id="invoice-ack-edit-code">
                    <div class="align-right" id="invoice-ack-status-form-buttons">                    
                        <button class="btn btn-success" type="button" onclick="updateInvoiceAckStatus();">Save</button>
                        <button class="btn btn-default" type="button" onclick="closeInvoiceAckStatusDialog();">Cancel</button>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>

{literal}
    <script>
        var fileupload = new fileUpload('#ie-fileupload');
        $('#invoice-ack-vendor-filter, #invoice-ack-branch-filter, #invoice-ack-vendor, #invoice-ack-supervisor').select2();

       
        $('#invoice_ack_date_range').daterangepicker({
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
            

        $('#invoice-ack-transaction-date').datepicker({
            todayHighlight: true,
            format: 'dd-mm-yyyy',
            autoclose: true,
            endDate:'0d'
        });

        $('#invoice-ack-completed-date').daterangepicker({
            singleDatePicker: true,
            timePicker: true,
            timePickerIncrement: 1,
            format: 'DD-MM-YYYY hh:mm A',
            startDate: moment(),
            maxDate: moment(),
            autoApply: false,
            showDropdowns: false,
        });

        $('#invoice-ack-submitted-date').daterangepicker({
            singleDatePicker: true,
            timePicker: true,
            timePickerIncrement: 1,
            format: 'DD-MM-YYYY hh:mm A',
            startDate: moment(),
            maxDate: moment(),
            autoApply: false,
            showDropdowns: false,
        });

        $('#invoice-ack-vendor').on('change', function() {
            $('#invoice-ack-inv').addClass('hide').html('');
            $('#invoice-ack-info').removeClass('hide');

            var data = {};
            data.vendorCode = $(this).val();

            if (data.vendorCode) {
                $.ajax({
                    type: 'POST',
                    dataType: 'html',
                    url: base_url + 'cargo/get-customer-invoice-acknowledgement-unpaid-invoice',
                    data: data,
                    success: function (response) {
                        $('#invoice-ack-inv').removeClass('hide').html(response);
                        $('#invoice-ack-info').addClass('hide');
                    }
                });
            }
        });

        $('#invoice-ack-edit-status').on('change', function () {
            $('#completed-date, #submitted-details, #inv-ack-attachments').addClass('hide');
            $('#invoice-ack-completed-date ,#invoice-ack-submitted-date, #invoice-ack-submitted-to').val('');
            if ($(this).val() == 'CMPLT') {
                $('#completed-date').removeClass('hide');
            } else if ($(this).val() == 'SBMT') {
                $('#submitted-details, #inv-ack-attachments').removeClass('hide');
            }
        });

        function generateInvoiceAck() {
            $('#invoice-ack-list').html('');
            var data = {};
            var daterange = $('#invoice_ack_date_range').data('daterangepicker');
            data.fromDate = daterange.startDate.format('DD-MM-YYYY');
            data.toDate = daterange.endDate.format('DD-MM-YYYY');
            data.vendorCode = $('#invoice-ack-vendor-filter').val();
            data.organizationCode = $('#invoice-ack-branch-filter').val();
            data.statusCode = $('#invoice-ack-status').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');
           

            if (err > 0) {
                $('#invoice-ack-filter-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#invoice-ack-filter-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#invoice-ack-filter-action-state').show();
                return false;
            }

            $('#invoice-ack-filter-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#invoice-ack-filter-action-state').html('').hide();

            $('#invoice-ack-list-container').removeClass('hidden');
            $('#invoice-ack-list').html(loading_popup);

            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'cargo/customer-invoice-acknowledgement-list',
                data: data,
                success: function (response) {
                    $('#invoice-ack-list').html(response);
                }
            });
        }

        function clearInvoiceAck() {
            $('#invoice_ack_date_range').val('');
            $('#invoice_ack_date_range').data('daterangepicker').setStartDate({});
            $('#invoice_ack_date_range').data('daterangepicker').setEndDate({});
            $('#invoice-ack-status').val('');
            $('#invoice-ack-vendor-filter, #invoice-ack-branch-filter').val('NA').trigger('change')

            $('#invoice-ack-list-container').addClass('hidden');
            $('#invoice-ack-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#invoice-ack-filter-action-state').removeClass('alert-success, alert-danger').html('').hide();
        }

        function addInvAckDialog() {
            $('#add-invoice-ack-dialog').css('background', '#fff');
            $('#add-invoice-ack-dialog').removeClass('hide');
            $('#add-invoice-ack-dialog').dialog({
                autoOpen: true,
                height: 600,
                width: $(window).width() - 500,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();
            $('.inp_error').removeClass('inp_error');
            $('#invoice-ack-action-state').removeClass('alert-success, alert-danger').html('').hide();

            $('#invoice-ack-code, #invoice-ack-name, #invoice-ack-transaction-date, #invoice-ack-remarks').val('');
            $('#invoice-ack-vendor, #invoice-ack-supervisor, #invoice-ack-communication').val('').trigger('change');
            $('.unpaid-inv-check').attr('checked', false);
        }

        function closeinvoiceAckDialog() {
            $('#add-invoice-ack-dialog').addClass('hide');
            $('#add-invoice-ack-dialog').dialog('destroy');
        }

        function saveinvoiceAck() {
            var data = {};
            data.code = $('#invoice-ack-code').val();
            data.activeFlag = 1;
            data.name = $('#invoice-ack-name').val();

            data.vendor = {};
            data.vendor.code = $('#invoice-ack-vendor').val();

            data.supervisor = {};
            data.supervisor.code = $('#invoice-ack-supervisor').val();

            data.transactionDate = moment($('#invoice-ack-transaction-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');

            data.communicationMedium = {};
            data.communicationMedium.code = $('#invoice-ack-communication').val();

            data.remarks = $('#invoice-ack-remarks').val();

            data.invoiceList = [];
            $('#invoice-ack-unpaid-inv-table .unpaid-inv-check:checked').each(function() {
                var invoiceCode = $(this).val();
                data.invoiceList.push({ code: invoiceCode});
            });

            var err = 0;
            $('.inp_error').removeClass('inp_error');
            if (data.name == '') {
                $('#invoice-ack-name').addClass('inp_error');
                err++;
            }

            if (data.vendor.code == '') {
                $('#invoice-ack-vendor').addClass('inp_error');
                err++;
            }

            if (data.supervisor.code == '') {
                $('#invoice-ack-supervisor').addClass('inp_error');
                err++;
            }

            if (data.communicationMedium.code == '') {
                $('#invoice-ack-communication').addClass('inp_error');
                err++;
            }

            if ($('#invoice-ack-transaction-date').val() == '') {
                $('#invoice-ack-transaction-date').addClass('inp_error');
                err++;
            }
            
            if (data.vendor.code != '') {
                if (data.invoiceList.length == 0) {
                    $('#invoice-ack-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#invoice-ack-action-state').html('Please select atleast one invoice!!!');
                    $('#invoice-ack-action-state').show();
                    return false;
                }
            }

            if (err > 0) {
                $('#invoice-ack-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#invoice-ack-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#invoice-ack-action-state').show();
                return false;
            }

            $('#invoice-ack-action-state').removeClass('alert-success, alert-danger, hide');
            $('#invoice-ack-action-state').html(loading_popup).show();
            $('#invoice-ack-save-button').addClass('disabled');

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/update-customer-invoice-acknowledgement',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#invoice-ack-action-state').removeClass('alert-danger');
                        $('#invoice-ack-action-state').addClass('alert-success');
                        $('#invoice-ack-action-state').html('Your request has been completed successfully');
                        window.setTimeout(function() {
                            closeinvoiceAckDialog();
                            checkURL();
                            return;
                        }, 3000);
                    } else {
                        $('#invoice-ack-action-state').addClass('alert-danger');
                        $('#invoice-ack-action-state').html(response.errorDesc);
                        $('#invoice-ack-form-buttons').removeClass('disabled');
                    }
                }
            });
        }

        function editStatusDialog(code) {
            $('#invoice-ack-status-dialog').css('background', '#fff');
            $('#invoice-ack-status-dialog').removeClass('hide');
            $('#invoice-ack-status-dialog').dialog({
                autoOpen: true,
                height: 400,
                width: 700,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();
            $('#edt-cheque-data').val('');

            $('#edit-status-action-state').removeClass('alert-danger').addClass('hide').html('');
            $('.inp_error').removeClass('inp_error');

            var invoiceAckdData = _.find(AllInvoiceAckdData || [], o => o.code == code);
            fileupload.clearFiles();
            if (_isdefined(invoiceAckdData)) {
                $('#invoice-ack-edit-code').val(invoiceAckdData.code);
                $('#invoice-ack-edit-status').val(invoiceAckdData.status.code).trigger('change');
                $('#invoice-ack-edit-remarks').val(invoiceAckdData.remarks)
                $('#invoice-ack-submitted-date').val(invoiceAckdData.submittedAt)
                $('#invoice-ack-submitted-to').val(invoiceAckdData.addAttr1)

                if(invoiceAckdData.imageCount > 0){
                    fileupload.loadFiles({
                        referenceCode: invoiceAckdData.code, 
                        imageCategoryCode: 'INVACK'
                    });
                }
            }
        }

        function closeInvoiceAckStatusDialog() {
            $('#invoice-ack-status-dialog').addClass('hide');
            $('#invoice-ack-status-dialog').dialog('destroy');
        }

        function updateInvoiceAckStatus() {
            var data = {};
            data.code = $('#invoice-ack-edit-code').val();
            data.activeFlag = 1;

            data.status = {};
            data.status.code = $('#invoice-ack-edit-status').val();
            data.completedAt = $('#invoice-ack-completed-date').val();
            data.submittedAt = $('#invoice-ack-submitted-date').val();
            data.addAttr1 = $('#invoice-ack-submitted-to').val();
            data.remarks = $('#invoice-ack-edit-remarks').val();
            
            var err = 0;
            $('.inp_error').removeClass('inp_error');
            if (data.status.code == '') {
                $('#invoice-ack-edit-status').addClass('inp_error');
                err++;
            }

            if (data.status.code == 'CMPLT' && $('#invoice-ack-completed-date').val() == ''){
                $('#invoice-ack-completed-date').addClass('inp_error');
                err++;
            }

            if (data.status.code == 'SBMT') {
                if ($('#invoice-ack-submitted-date').val() == ''){
                    $('#invoice-ack-submitted-date').addClass('inp_error');
                    err++;
                }

                if (data.addAttr1 == ''){
                    $('#invoice-ack-submitted-to').addClass('inp_error');
                    err++;
                }
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
                url: base_url + 'cargo/update-customer-invoice-acknowledgement-status',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#edit-status-action-state').removeClass('alert-danger');
                        $('#edit-status-action-state').addClass('alert-success');
                        $('#edit-status-action-state').html('Your request has been completed successfully');
                        window.setTimeout(function() {
                            fileupload.startUpload({
                                referenceCode: data.code, 
                                imageCategoryCode: 'INVACK',
                                onComplete: function() {
                                    closeInvoiceAckStatusDialog();
                                    generateInvoiceAck();
                                }
                            });
                        }, 3000);
                    } else {
                        $('#edit-status-action-state').addClass('alert-danger');
                        $('#edit-status-action-state').html(response.errorDesc);
                    }
                }
            });
        }

        function showPRGallery (code) {
            fileupload.showGalleryDialog({
                referenceCode: code,
                imageCategoryCode: 'CSHBO'
            });
        }
    </script>
{/literal}