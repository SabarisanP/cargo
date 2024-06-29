<div class="brand_top">
    <h3>Income / Expense Transactions</h3>
    <span class="align-right">
        <a href="javascript:;" class="btn btn-default btn-sm" onclick="exportIncomeExpenses();" id="inp-exp-pen-export" style="display: none;">
            <i class="fa fa-download fa-lg"></i>Excel</a>
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
                                    <div class="col-md-12">
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
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="inc-exp-pen-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
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

<div id="inc-exp-pen-dialog" class="hide dialog-content-page">
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

        <div class="clear_fix_both"></div><br/>
        <div class="col-lg-6 p_l_n">
            <label for="ie-tmode" class="req">Transaction Mode</label>
            <select id="ie-tmode" class="form-control col-md-6">
                <option value="">Select</option>
                {foreach key=key item=value from=$transactionMode}
                    <option value="{$key}">{$value}</option>
                {/foreach}
            </select>
        </div>
        {*        {if $action_rights['CGO-INEX-ALL-BRANCH']==1}*}
        <div class="col-lg-6 p_l_n p_r_n">
            <label for="ie-branch" class="req">Branch</label>
            <select id="ie-branch" class="form-control col-md-6">
                <option value="">Select</option>
                {foreach item=row from=$branches}
                    <option value="{$row->code}">{$row->name}</option>
                {/foreach}
            </select>
        </div>
        {*        {/if}*}


        <div class="clear_fix_both"></div><br/>


        <div class="col-lg-6 p_l_n">
            <label for="ie-amount" class="req">Amount</label>
            <div class="input-group">
                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                <input type="text" class="form-control" id="ie-amount">
            </div>
        </div>

        <div class="col-lg-6 p_l_n" id="ie-radio-div">
            <label for="ie-amount" class="invisible">Amount</label>
            <div class="input-group">
                <label class="radio-inline">
                    <input type="radio" name="optradio" id="lr-vh-radio" value="LR" checked>LR
                </label>
                <label class="radio-inline">
                    <input type="radio" name="optradio" id="lr-vh-radio" value="VEHICLE">Vehicle
                </label>
            </div>
        </div>
        
        <div class="clear_fix_both"></div><br/>
        <div class="col-lg-6 p_l_n" id="ie-lr-div">
            <label for="ie-lr"  class="req">{lang('lr')}</label>
            <div class="input-group">
                <input type="text" placeholder="{lang('lr')}" class="form-control" onfocus="clearAction()" onblur="getCargo()" id="ie-lr">
            </div>
            <div id="ie-lr-load"></div>
            <div class="align-center" id="ie-lr-action"></div>
        </div>
            
        <div class="col-lg-6 p_l_n p_r_n hide" id="ie-vh-div">
            <label for="ie-vehicle" class="req">Vehicle</label>
            <select id="ie-vehicle" class="form-control col-md-6">
                <option value="">Select</option>
                {foreach item=row from=$vehicles}
                    <option value="{$row->code}">{$row->name}</option>
                {/foreach}
            </select>
        </div>
            

        <div class="clear_fix_both"></div><br/>
        <div class="col-lg-12 p_l_n p_r_n">
            <label for="ie-remarks">Remarks</label>
            <textarea id="ie-remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" id="remark"></textarea>
        </div>
        <div class="clear_fix_both"></div><br/>
        <div class="alert col-lg-12 pull-left" id="ie-action"></div>
        <div class="clear_fix_both"></div>
        <div class="align-right" id="ie-head-buttons">
            <input type="hidden" id="hid-crdr-code" class="form-control">
            <input type="hidden" id="hid-ie-code" class="form-control">
            <input type="hidden" id="hid-lr-code" class="form-control">
            <input type="hidden" id="valid-lr" class="form-control">
            <button class="btn btn-success" type="button" onclick="saveInpExp();">Save</button>
            <button class="btn btn-default" type="button" onclick="closeInpExp();">Cancel</button>
        </div>
    </form>
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<script>

    $('#inp-exp-pen-from').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        endDate: '+1D',
        changeMonth: true
    }).on('changeDate', function (e) {
        $('#inp-exp-pen-to').datepicker('setStartDate', e.date);
    });
    $('#inp-exp-pen-to').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        endDate: '+1D',
        autoclose: true
    }).on('changeDate', function (e) {
        $('#inp-exp-pen-from').datepicker('setEndDate', e.date);
    });
    
    $("input[name=optradio]").on('change',function () {
        if($(this).val() == 'LR'){
            $('#ie-vh-div').addClass('hide');
            $('#ie-lr-div').removeClass('hide');
        }else if($(this).val() == 'VEHICLE'){
            $('#ie-lr-div').addClass('hide');
            $('#ie-vh-div').removeClass('hide');
        }
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
        if (data.toDate == '') {
            $('#inp-exp-pen-to').addClass('inp_error');
            err++;
        }

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
            url: base_url + 'cargo/get-income-expense-transactions-list',
            data: data,
            success: function (response) {
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

    function showInpExpDialog(code, iecode) {

        if ($('.bsn_switch').is(':checked')) {
            $('#ie-lr-div').show();
            $('#ie-vh-div').show();
            $('#ie-radio-div').show();
            $('#hid-lr-code').val('');
            $('#ie-head').val('');
            $('#ie-head option').hide();
            var code2 = 'D' + code;
            $('#ie-head option[data-creditdebitflag="' + code2 + '"]').show();
        }

        $('.bsn_switch').on('switchChange.bootstrapSwitch', function (event, state) {
            if ($('.bsn_switch').is(':checked')) {
                $('#ie-lr-div').show();
                $('#ie-vh-div').show();
                $('#ie-radio-div').show();
                $('#hid-lr-code').val('');
                $('#ie-head').val('');
                $('#ie-head option').hide();
                var code2 = 'D' + code;
                $('#ie-head option[data-creditdebitflag="' + code2 + '"]').show();
            } else {
                $('#ie-lr-div').hide();
                $('#ie-vh-div').hide();
                $('#ie-radio-div').hide();
                $('#hid-lr-code').val('1');
                $('#ie-head').val('');
                $('#ie-head option').hide();
                $('#ie-head option[data-creditdebitflag="' + code + '"]').show();
            }
        });

        $('label[for="ie-head"]').text((code == 'Dr') ? 'Expense Heads' : 'Income Heads');
        $('input[name=optradio][value=LR]').prop('checked',true).trigger('change');

        $('h4[for="ie-title"]').text((code == 'Dr') ? 'Expenses' : 'Incomes');
        $('#ie-title').val('');

        $('#ie-amount').val('');
        $('#ie-branch').val('');
        $('#ie-tmode').val('');
        $('#ie-remarks').val('');
        $('#inc-exp-pen-dialog .inp_error').removeClass('inp_error');
        $('#ie-action').hide();
        $('.bsn_switch').bootstrapSwitch('state', true);
        $('#hid-crdr-code').val(code);
        $('#ie-lr-action').hide();


        $('#inc-exp-pen-dialog').removeClass('hide');
        $('#inc-exp-pen-dialog').dialog({
            autoOpen: true,
            width: 520,
            height: 620,
            resizable: false,
            modal: true
        });
        $(".ui-dialog-titlebar").hide();
        if (iecode != '') {
            if (iecode.cargo_code == 'NA') {
                $('#ie-lr').val('');
            } else {
                $('#ie-lr').val(iecode.cargo_code);
            }

            $('#ie-amount').val(iecode.amount);
            $('#ie-remarks').val(iecode.remarks);
            $('#ie-head').val(iecode.organizationCash.code);
            $('#ie-tmode').val(iecode.transaction_mode_code);
            $('#hid-ie-code').val(iecode.code);
            $('#ie-branch').val(iecode.organizationCode);
        } else {
            $('#ie-amount').val('');
            $('#ie-branch').val('');
            $('#ie-tmode').val('');
            $('#ie-remarks').val('');
            $('#ie-lr').val('');
        }

    }

    function closeInpExp() {
        $('#inp_exp_pen_form .inp_error').removeClass('inp_error');
        $('#inc-exp-pen-dialog').dialog('destroy');
        $('#inc-exp-pen-dialog').hide();
        $('#ie-lr-action').hide();
    }

    function saveInpExp() {
        var data = {};
        data.code = $('#hid-ie-code').val();
        data.amount = $.trim($('#ie-amount').val());
        data.organizationCode = $('#ie-branch').val();
        data.transactionMode = $('#ie-tmode').val();
        data.remarks = $('#ie-remarks').val();
        data.organizationCash = $('#ie-head').val();
        data.activeFlag = 1;


        var lrCode = $('#hid-lr-code').val();

        if (lrCode == 1) {
            data.referenceType = "";
        } else {
            data.referenceType = $('input[name=optradio]:checked').val();
        }

        var err = 0;
        $('#inc-exp-pen-dialog .inp_error').removeClass('inp_error');

        if (data.amount == '' || isNaN(data.amount)) {
            $('#ie-amount').addClass('inp_error');
            err++;
        }
        if (data.organizationCode == '') {
            $('#ie-branch').addClass('inp_error');
            err++;
        }
        if (data.transactionMode == '') {
            $('#ie-tmode').addClass('inp_error');
            err++;
        }
        if (data.organizationCash == '') {
            $('#ie-head').addClass('inp_error');
            err++;
        }
        if(data.referenceType == "LR"){
            data.referenceCode = $('#ie-lr').val();
            if ((lrCode == '') && (data.referenceCode == '')) {
                $('#ie-lr').addClass('inp_error');
                err++;
            }

            if (($('#valid-lr').val() == 1) && (lrCode == '')) {
                $('#ie-lr').addClass('inp_error');
                err++;
            }
        }
        
        if(data.referenceType == "VEHICLE"){
            data.referenceCode = $('#ie-vehicle').val();
            if(data.referenceCode == ''){
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
            success: function (response) {
                if (response.status == 1) {
                    $('#ie-action').addClass('alert-success');
                    $('#ie-action').html('Your request has been completed successfully');

                    window.setTimeout(function () {
                        closeInpExp();
                        getInpExpPen();
                    }, 2000);
                } else {
                    $('#ie-action').addClass('alert-danger');
                    $('#ie-action').html(response.errorDesc);
                }
            }
        });
    }

    function exportIncomeExpenses() {
        document.inp_exp_pen_form.target = "ifrm_downloader";
        document.inp_exp_pen_form.submit();
        return;
    }

    function deleteInpExp(iecode) {


        var data ={};
        data.amount = iecode.transaction_amount;
        data.organizationCode = iecode.organization_code;
        data.transactionMode = iecode.transaction_mode_code;
        data.remarks = iecode.remarks;
        data.organizationCash = iecode.name;
        data.activeFlag = 2;
        data.code = iecode.transaction_code;
        data.cargoCode = iecode.cargo_code;


        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-income-expense",
            data: data,
            success: function (response) {
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
                window.setTimeout(function () {
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
        if (cargoCode == "")
            return;

        var data = {};

        $('#ie-lr-load').html(loading_popup);
        data.cargoCode = cargoCode;
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/find-lr",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#ie-lr-load').hide();
                    $('#ie-lr-action').show();
                    $('#ie-lr-action').html('<p style="color:green">Valid LR</p>');
                    $('#valid-lr').val('');
                } else {
                    $('#ie-lr-load').hide();
                    $('#ie-lr-action').show();
                    $('#ie-lr-action').html('<p style="color:red">Invalid LR</p>');
                    $('#valid-lr').val('1');
                }

            }
        })
    }

</script>