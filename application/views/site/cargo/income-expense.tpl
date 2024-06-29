<div class="brand_top">
    <h3>Income / Expense</h3>
    <span class="align-right">
        <a href="javascript:;" class="btn btn-default btn-sm" onclick="exportIncomeExpenses();" id="inp-exp-export" style="display: none;">
            <i class="fa fa-download fa-lg"></i>Excel</a>
        <a href="javascript:;" class="btn btn-primary btn-sm" onclick="paymentReceipt();">Payment Receipt</a>
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="showInpExpDialog('Dr', '');">Add Expense</a>
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="showInpExpDialog('Cr', '');">Add Income</a>
    </span>
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

                                    <ul class="nav nav-tabs">
                                        <li class="active"><a data-toggle="tab" href="#approved">Approved</a></li>
                                        <li><a data-toggle="tab" href="#pending">Pending Approval</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="approved" class="tab-pane fade in active">

                                            <br />
                                            <div>
                                                <div class="">
                                                    <div id="search-panel">
                                                        <form id="inp_exp_form" name="inp_exp_form" method="post" action="cargo/get-income-expense" onsubmit="return false;">
                                                            <div class="row">
                                                                <div class="form-group col-md-2">
                                                                    <label for="inp-exp-from">From Date</label>
                                                                    <div class="input-group">
                                                                        <input type="text" name="fromDate" class="form-control sdate" id="inp-exp-from" readonly="true" placeholder="Date From">
                                                                        <label class="input-group-addon" for="inp-exp-from"><i class="fa fa-calendar"></i></label>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group col-md-2">
                                                                    <label for="inp-exp-to">To Date</label>
                                                                    <div class="input-group">
                                                                        <input type="text" name="toDate" class="form-control sdate" id="inp-exp-to" readonly="true" placeholder="Date To">
                                                                        <label class="input-group-addon" for="inp-exp-to"><i class="fa fa-calendar"></i></label>
                                                                    </div>
                                                                </div>
                                                                {if $action_rights['CGO-INEX-ALL-BRANCH']==1}
                                                                    <div class="form-group col-md-2">
                                                                        <label for="inp-exp-branch">Branch</label>
                                                                        <div class="input-group col-md-12">
                                                                            <select id="inp-exp-branch" class="form-control">
                                                                                <option value="NA">All Branches</option>
                                                                                {foreach item=row from=$branches}
                                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                                {/foreach}
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                {/if}
                                                                <br class="clear_fix_both">
                                                                <div class="form-group col-md-2">
                                                                    <label for="inp-exp-cr-dr">Direct/Indirect</label>
                                                                    <div class="input-group col-md-12">
                                                                        <select id="inp-exp-cr-dr" name="creditDebitFlag" class="form-control">
                                                                            <option value="" selected="">-Select-</option>
                                                                            {foreach from=$credit_debit key=key item=value}
                                                                                <option value="{$key}">{$value}</option>
                                                                            {/foreach}
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group col-md-2">
                                                                    <label for="inp-exp-lr">{lang('lr')}</label>
                                                                    <div class="input-group col-md-12">
                                                                        <input type="text" name="cargoCode" class="form-control" id="inp-exp-lr" placeholder="{lang('lr')}">
                                                                    </div>
                                                                </div>

                                                                <div class="form-group col-md-2">
                                                                    <label for="inp-exp-vehicle">Vehicle</label>
                                                                    <div class="input-group col-md-12">
                                                                        <select id="inp-exp-vehicle" class="form-control">
                                                                            <option value="NA">All Vehicles</option>
                                                                            {foreach item=row from=$vehicles}
                                                                                <option value="{$row->code}">{$row->registationNumber} ({$row->vehicleType->name})</option>
                                                                            {/foreach}
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group col-md-3">
                                                                    <label for="">&nbsp;</label>
                                                                    <div class="input-group">
                                                                        <input type="hidden" name="export" id="export" value="1">
                                                                        <button type="button" class="btn btn-success" onclick="getInpExp();">Get Income / Expenses</button>&nbsp;
                                                                        <button type="button" class="btn btn-default" onclick="clearInpExp();">Clear</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <br class="clear_fix_both">
                                                    <div class="align-center alert alert-danger pull-left" style="display:none" id="inp_exp_action_state"></div>
                                                </div>
                                                <!--row end-->
                                            </div>

                                            <div class="row hidden" id="inc-exp-list-container">
                                                <div class="col-md-12">
                                                    <div id="inc-exp-list"></div>
                                                </div>
                                            </div>

                                        </div>
                                        <div id="pending" class="tab-pane fade">

                                            <br />
                                            <div class="">
                                                <div id="search-panel">
                                                    <form id="inp_exp_pen_form" name="inp_exp_pen_form" method="post" action="cargo/get-income-expense" onsubmit="return false;">
                                                        <div class="row">
                                                            <div class="form-group col-md-2">
                                                                <label for="inp-exp-pen-from">From Date</label>
                                                                <div class="input-group">
                                                                    <input type="text" name="fromDate" class="form-control sdate" id="inp-exp-pen-from" readonly="true" placeholder="Date From">
                                                                    <label class="input-group-addon" for="inp-exp-pen-from"><i class="fa fa-calendar"></i></label>
                                                                </div>
                                                            </div>
                                                            <div class="form-group col-md-2">
                                                                <label for="inp-exp-pen-to">To Date</label>
                                                                <div class="input-group">
                                                                    <input type="text" name="toDate" class="form-control sdate" id="inp-exp-pen-to" readonly="true" placeholder="Date To">
                                                                    <label class="input-group-addon" for="inp-exp-pen-to"><i class="fa fa-calendar"></i></label>
                                                                </div>
                                                            </div>
                                                            {if $action_rights['CGO-INEX-ALL-BRANCH']==1}
                                                                <div class="form-group col-md-2">
                                                                    <label for="inp-exp-pen-branch">Branch</label>
                                                                    <div class="input-group col-md-12">
                                                                        <select id="inp-exp-pen-branch" class="form-control">
                                                                            <option value="NA">All Branches</option>
                                                                            {foreach item=row from=$branches}
                                                                                <option value="{$row->code}">{$row->name}</option>
                                                                            {/foreach}
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            {/if}
                                                            <div class="form-group col-md-3">
                                                                <label for="">&nbsp;</label>
                                                                <div class="input-group">
                                                                    <input type="hidden" name="export" id="export" value="1">
                                                                    <button type="button" class="btn btn-success" onclick="getInpExpPen();">Get Income / Expenses</button>&nbsp;
                                                                    <button type="button" class="btn btn-default" onclick="clearInpExpPen();">Clear</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                                <br class="clear_fix_both">
                                                <div class="align-center alert alert-danger pull-left" style="display:none" id="inp_exp_pen_action_state"></div>
                                            </div>

                                            <div class="row hidden" id="inc-exp-pen-list-container">
                                                <div class="col-md-12">
                                                    <div id="inc-exp-pen-list"></div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div id="inc-exp-dialog" class="hide dialog-content-page">
    <form role="form" class="form-horizontal">
        <div class="col-lg-12 p_l_n">
            <h4 for="ie-title">Income / Expense Heads</h4>
        </div>

        <div class="col-sm-6 p_l_n">
            <label class="req" for="ie-cr-dr">Direct or Indirect</label>
            <input type="checkbox" checked id="ie-cr-dr" class="bsn_switch" data-on-text="Direct" data-off-text="Indirect">
        </div>

        <div class="col-lg-6 p_l_n">
            <label for="ie-head" class="req">Income / Expense Heads</label>
            <select id="ie-head" class="form-control col-md-6">
                <option value="">Select</option>
                {foreach item=row from=$heads}
                    <option value="{$row->code}" data-creditdebitflag="{$row->creditDebitFlag}">{$row->name}</option>
                {/foreach}
            </select>
        </div>

        <div class="clear_fix_both"></div><br />
        <div class="col-lg-6 p_l_n">
            <label for="ie-tmode" class="req">Transaction Mode</label>
            <select id="ie-tmode" class="form-control col-md-6">
                <option value="">Select</option>
                {foreach key=key item=value from=$transactionMode}
                    <option value="{$key}">{$value}</option>
                {/foreach}
            </select>
        </div>
        
        <div class="col-lg-6 p_l_n">
            <label for="ie-amount" class="req">Amount</label>
            <div class="input-group">
                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                <input type="text" class="form-control" id="ie-amount">
            </div>
        </div>

        <div class="clear_fix_both"></div><br />

        <div class="col-lg-6 p_l_n" id="ie-radio-div">
            <label for="ie-amount">&nbsp;</label>
            <div class="input-group">
                <label class="radio-inline">
                    <input type="radio" name="optradio" id="lr-vh-radio" value="LR" checked>LR
                </label>
                <label class="radio-inline">
                    <input type="radio" name="optradio" id="lr-vh-radio" value="VEHICLE">Vehicle
                </label>
            </div>
        </div>

        <div class="col-lg-6 p_l_n" id="ie-lr-div">
            <label for="ie-lr" class="req">{lang('lr')}</label>
            <div>
                <input type="text" placeholder="{lang('lr')}" class="form-control capitalize" onfocus="clearAction()" onblur="getCargo()" id="ie-lr">
            </div>
            <div id="ie-lr-load"></div>
            <div class="align-center" id="ie-lr-action"></div>
        </div>

        <div class="col-lg-6 p_l_n hide" id="ie-vh-div">
            <label for="ie-vehicle" class="req">Vehicle</label>
            <select id="ie-vehicle" class="form-control">
                <option value="">Select</option>
                {foreach item=row from=$vehicles}
                    <option value="{$row->code}">{$row->registationNumber} ({$row->vehicleType->name}) </option>
                {/foreach}
            </select>
        </div>
        
        {if $action_rights['CGO-INEX-ALL-BRANCH']==1}
            <div class="clear_fix_both"></div><br />
            <div class="col-lg-12 p_l_n p_r_n">
                <label for="ie-branch" class="req">Branch</label>
                <select id="ie-branch" class="form-control col-md-6">
                    <option value="">Select</option>
                    {foreach item=row from=$branches}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>
        {/if}

        <div class="clear_fix_both"></div><br />

        <div class="col-lg-12 p_l_n p_r_n">
            <label for="ie-remarks">Remarks</label>
            <textarea id="ie-remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" id="remark"></textarea>
        </div>
        
        <div class="clear_fix_both"></div>
        
        {include file="site/cargo/file-upload-component.tpl" id="ie-fileupload" axis="horizontal"}
    
        <div class="clear_fix_both"></div><br />
        
        <div class="alert col-lg-12 pull-left" id="ie-action"></div>
        <div class="clear_fix_both"></div><br />
        <div class="align-right" id="ie-head-buttons">
            <input type="hidden" id="hid-crdr-code" class="form-control">
            <input type="hidden" id="hid-ie-code" class="form-control">
            <input type="hidden" id="valid-lr" class="form-control">
            <button class="btn btn-success" type="button" onclick="saveInpExp();">Save</button>
            <button class="btn btn-default" type="button" onclick="closeInpExp();">Cancel</button>
        </div>
    </form>
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<script>
    $('#inp-exp-from').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        endDate: '+1D',
        changeMonth: true
    }).on('changeDate', function(e) {
        $('#inp-exp-to').datepicker('setStartDate', e.date);
    });
    $('#inp-exp-to').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        endDate: '+1D',
        autoclose: true
    }).on('changeDate', function(e) {
        $('#inp-exp-from').datepicker('setEndDate', e.date);
    });

    $("input[name=optradio]").on('change', function() {
        console.log($(this).val());
        if ($(this).val() == 'LR') {
            $('#ie-vh-div').addClass('hide');
            $('#ie-lr-div').removeClass('hide');
        } else if ($(this).val() == 'VEHICLE') {
            $('#ie-lr-div').addClass('hide');
            $('#ie-vh-div').removeClass('hide');
        }
    });

    $('#ie-vehicle').select2();
    $('#inp-exp-vehicle').select2();

    var fileupload = new fileUpload('#ie-fileupload');

    function getInpExp() {
        var data = {};
        data.fromDate = $('#inp-exp-from').val();
        data.toDate = $('#inp-exp-to').val();
        data.organizationCode = $('#inp-exp-branch').val();
        data.cargoCode = $('#inp-exp-lr').val();
        data.creditDebitFlag = $('#inp-exp-cr-dr').val();
        data.vehicleCode = $('#inp-exp-vehicle').val();
        var err = 0;
        $('#inp_exp_form .inp_error').removeClass('inp_error');

        if (data.fromDate == '') {
            $('#inp-exp-from').addClass('inp_error');
            err++;
        }
        if (data.toDate == '') {
            $('#inp-exp-to').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#inp_exp_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#inp_exp_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#inp_exp_action_state').show();
            return false;
        }

        $('#inp_exp_action_state').removeClass('alert-success').removeClass('alert-danger').hide();
        $('#inc-exp-list-container').removeClass('hidden');
        $('#inc-exp-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/get-income-expense',
            data: data,
            success: function(response) {
                $('#inc-exp-list').html(response);
            }
        });
    }

    function clearInpExp() {
        $('.inp_error').removeClass('inp_error');
        $('#inp-exp-from').val('');
        $('#inp-exp-to').val('');
        $('#inp-exp-cr-dr').val('');
        $('#inp-exp-lr').val('');
        $('#inp-exp-branch').val('NA');
        $('#inc-exp-list-container').addClass('hidden');
        $('#inp_exp_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#inp_exp_action_state').html('').hide();
        $('#ie-lr-action').hide();
        $('#inp-exp-vehicle').val('NA').trigger('change');
    }

    function showInpExpDialog(code, data) {

        if ($('.bsn_switch').is(':checked')) {
            $('#ie-lr-div').show();
            $('#ie-vh-div').show();
            $('#ie-radio-div').show();
            $('#ie-head').val('');
            $('#ie-head option').hide();
            var code2 = 'D' + code;
            $('#ie-head option[data-creditdebitflag="' + code2 + '"]').show();
        }

        $('.bsn_switch').off('switchChange.bootstrapSwitch').on('switchChange.bootstrapSwitch', function(event, state) {
            if ($('.bsn_switch').is(':checked')) {
                $('#ie-lr-div').show();
                $('#ie-vh-div').show();
                $('#ie-radio-div').show();
                $('#ie-head').val('');
                $('#ie-head option').hide();
                var code2 = 'D' + code;
                $('#ie-head option[data-creditdebitflag="' + code2 + '"]').show();
            } else {
                $('#ie-lr-div').hide();
                $('#ie-vh-div').hide();
                $('#ie-radio-div').hide();
                $('#ie-head').val('');
                $('#ie-head option').hide();
                $('#ie-head option[data-creditdebitflag="' + code + '"]').show();
            }
        });

        $('label[for="ie-head"]').text((code == 'Dr') ? 'Expense Heads' : 'Income Heads');
        $('input[name=optradio][value=LR]').prop('checked', true).trigger('change');

        $('h4[for="ie-title"]').text((code == 'Dr') ? 'Expenses' : 'Incomes');
        $('#ie-title').val('');

        $('#ie-amount').val('');
        $('#ie-branch').val('');
        $('#ie-tmode').val('');
        $('#ie-remarks').val('');
        $('#inc-exp-dialog .inp_error').removeClass('inp_error');
        $('#ie-action').hide();
        $('.bsn_switch').bootstrapSwitch('state', true);
        $('#hid-crdr-code').val(code);
        $('#ie-lr-action').hide();

        $('#inc-exp-dialog').removeClass('hide');
        $('#inc-exp-dialog').dialog({
            autoOpen: true,
            width: 520,
            height: 620,
            resizable: false,
            modal: true
        });
        $(".ui-dialog-titlebar").hide();

        if (data != '') {
            if (data.referenceTypeCode == 'NA') {
                $('#ie-cr-dr').prop('checked', false).trigger('change');
            } else {
                $('#ie-cr-dr').prop('checked', true).trigger('change');
                $('input[name=optradio][value="' + data.referenceTypeCode + '"]').prop('checked', true).trigger('change');
                if (data.referenceTypeCode == 'LR') {
                    $('#ie-lr').val(data.referenceCode).trigger('change');;
                } else if (data.referenceTypeCode == 'VEHICLE') {
                    $('#ie-vehicle').val(data.referenceCode).trigger('change');
                }
            }

            $('#hid-ie-code').val(data.code);
            $('#ie-amount').val(data.amount);
            $('#ie-branch').val(data.organizationCode);
            $('#ie-tmode').val(data.transactionMode.code);
            $('#ie-remarks').val(data.remarks);
            $('#ie-head').val(data.organizationCash.code);
            fileupload.clearFiles();
            if(data.image > 0){
                fileupload.loadFiles({
                    referenceCode: data.code, 
                    imageCategoryCode: 'INCEXP'
                });
            }
        } else {
            $('#hid-ie-code').val('');
            $('#ie-amount').val('');
            $('#ie-branch').val('');
            $('#ie-tmode').val('');
            $('#ie-remarks').val('');
            $('#ie-head').val('');
            $('#ie-lr').val('');
            $('#ie-vehicle').val('').trigger('change');
            $('#ie-cr-dr').prop('checked', true).trigger('change');
            fileupload.clearFiles();
        }

    }

    function closeInpExp() {
        $('#inp_exp_form .inp_error').removeClass('inp_error');
        $('#inc-exp-dialog').dialog('destroy');
        $('#inc-exp-dialog').hide();
        $('#ie-lr-action').hide();
    }

    function saveInpExp() {
        var data = {};
        data.code = $('#hid-ie-code').val();
        data.amount = $.trim($('#ie-amount').val());
        data.organizationCode = $('#ie-branch').val();
        data.transactionMode = {};
        data.transactionMode.code = $('#ie-tmode').val();
        data.remarks = $('#ie-remarks').val();
        data.organizationCash = {};
        data.organizationCash.code = $('#ie-head').val();
        data.activeFlag = 1;

        var directOrIndirect = $('#ie-cr-dr').is(':checked');
        if (directOrIndirect) {
            data.referenceTypeCode = $('input[name=optradio]:checked').val();
        } else {
            data.referenceTypeCode = "NA";
            data.referenceCode = "NA";
        }

        var err = 0;
        $('#inc-exp-dialog .inp_error').removeClass('inp_error');

        if (data.amount == '' || isNaN(data.amount)) {
            $('#ie-amount').addClass('inp_error');
            err++;
        }
        if (data.organizationCode == '') {
            $('#ie-branch').addClass('inp_error');
            err++;
        }
        if (data.transactionMode.code == '') {
            $('#ie-tmode').addClass('inp_error');
            err++;
        }
        if (data.organizationCash == '') {
            $('#ie-head').addClass('inp_error');
            err++;
        }
        if (data.referenceTypeCode == "LR") {
            data.referenceCode = $('#ie-lr').val();
            if (data.referenceCode == '') {
                $('#ie-lr').addClass('inp_error');
                err++;
            }

            if ($('#valid-lr').val() == 1) {
                $('#ie-lr').addClass('inp_error');
                err++;
            }
        }

        if (data.referenceTypeCode == "VEHICLE") {
            data.referenceCode = $('#ie-vehicle').val();
            if (data.referenceCode == '') {
                $('#ie-vehicle').addClass('inp_error');
                err++;
            }
        }

        if (err > 0) {
            $('#ie-action').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#ie-action').html('Please enter/select the values in the field that are marked in red');
            $('#ie-action').show();
            return false;
        }

        $('#ie-action').removeClass('alert-success').removeClass('alert-danger');
        $('#ie-action').html(loading_popup).show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/update-income-expense',
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#ie-action').addClass('alert-success');
                    $('#ie-action').html('Your request has been completed successfully');

                    setTimeout(function() {
                        $('#ie-action').hide();
                        fileupload.startUpload({
                            referenceCode: response.data.code, 
                            imageCategoryCode: 'INCEXP',
                            onComplete: closeInpExp
                        });
                    }, 1000);
                } else {
                    $('#ie-action').addClass('alert-danger');
                    $('#ie-action').html(response.errorDesc);
                }
            }
        });
    }

    function exportIncomeExpenses() {
        document.inp_exp_form.target = "ifrm_downloader";
        document.inp_exp_form.submit();
        return;
    }

    function deleteInpExp(data) {
        var data = data;
        data.activeFlag = 2;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-income-expense",
            data: data,
            success: function(response) {
                if (response.status == 1) {

                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function() {
                    loading_overlay.hide();
                    getInpExpPen();
                }, 2000);
            }
        });
    }

    function getCargo() {
        getCargoDetail($('#ie-lr').val());
    }

    function clearAction() {
        $('#ie-lr-action').hide();
    }

    function getCargoDetail(cargoCode) {
        var data = {};
        data.cargoCode = cargoCode;
        data.organizationCode = $('#ie-branch').val();
        data.headCode = $('#ie-head').val();
        
        if (cargoCode == "" || data.headCode == '')
            return;

        $('#ie-lr-load').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/validate-income-expense",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#ie-lr-load').hide();
                    $('#ie-lr-action').show();
                    $('#ie-lr-action').html('<p style="color:green">Valid LR</p>');
                    $('#valid-lr').val('');
                } else {
                    var ERRORS = {}
                    ERRORS['PG11'] = 'Expense already claimed.';
                    ERRORS['205A'] = 'Invalid LR, Invalid branch.';
                    ERRORS['DEFAULT'] = 'Invalid LR';

                    var msg = ERRORS[response.errorCode] || ERRORS['DEFAULT'];

                    $('#ie-lr-load').hide();
                    $('#ie-lr-action').show();
                    $('#ie-lr-action').html('<p style="color:red">' + msg + '</p>');
                    $('#valid-lr').val('1');
                }

            }
        })
    }

    // pending
    $('#inp-exp-pen-from').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        //endDate: '+1D',
        changeMonth: true
    }).on('changeDate', function(e) {
        //$('#inp-exp-pen-to').datepicker('setStartDate', e.date);
    });
    $('#inp-exp-pen-to').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        //endDate: '+1M',
        autoclose: true
    }).on('changeDate', function(e) {
        //$('#inp-exp-pen-from').datepicker('setEndDate', e.date);
    });

    function getInpExpPen() {
        var data = {};
        data.fromDate = $('#inp-exp-pen-from').val();
        data.toDate = $('#inp-exp-pen-to').val();
        data.organizationCode = $('#inp-exp-pen-branch').val();

        var err = 0;
        $('#inp_exp_pen_form .inp_error').removeClass('inp_error');

        if (data.fromDate == '') {
            $('#inp-exp-pen-from').addClass('inp_error');
            err++;
        }
       // if (data.toDate == '') {
            //$('#inp-exp-pen-to').addClass('inp_error');
            //err++;
        //}

        if (err > 0) {
            $('#inp_exp_pen_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#inp_exp_pen_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#inp_exp_pen_action_state').show();
            return false;
        }

        $('#inp_exp_pen_action_state').removeClass('alert-success').removeClass('alert-danger').hide();
        $('#inc-exp-pen-list-container').removeClass('hidden');
        $('#inc-exp-pen-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/get-income-expense-pending-transactions-list',
            data: data,
            success: function(response) {
                $('#inc-exp-pen-list').html(response);
                $('#inp-exp-pen-export').show();
            }
        });
    }

    function clearInpExpPen() {
        $('.inp_error').removeClass('inp_error');
        $('#inp-exp-pen-from').val('');
        $('#inp-exp-pen-to').val('');
        $('#inp-exp-pen-cr-dr').val('');
        $('#inp-exp-pen-lr').val('');
        $('#inp-exp-pen-branch').val('NA');
        $('#inc-exp-pen-list-container').addClass('hidden');
        $('#inp_exp_pen_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#inp_exp_pen_action_state').html('').hide();
        $('#inp-exp-pen-export').hide();
        $('#ie-lr-action').hide();
    }
    
    function paymentReceipt(){
        document.location.href = "#cargo/payment-receipt";
    }

    function showIEGallery (code) {
        fileupload.showGalleryDialog({
            referenceCode: code,
            imageCategoryCode: 'INCEXP'
        });
    }

</script>
