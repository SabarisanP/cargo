<div class="brand_top">
    <h3>Day Closing</h3>
    <div class="text-right noprint">
        <a href="#branch/branch-receipt" class="btn btn-success"><i class="fa fa-arrow-left"></i> Back</a>
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
                                                <form id="dayclosing_report" method="post" name="dayclosing_report" action="branch/day-closing-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-4">
                                                            <label for="dayclosing_user">User</label>
                                                            <div class="input-group col-md-11">
                                                                <select id='dayclosing_user' class="form-control">
                                                                    {if $action_rights['DAY-CLO-ALL-BRCH'] == 1 || $action_rights['DAY-CLO-SAM-BRCH'] == 1}
                                                                        <option value="">Select a user</option>
                                                                    {/if}
                                                                    {foreach item=branch from=$branchusers}
                                                                        {if $action_rights['DAY-CLO-SAM-BRCH'] == 1 && $branch['code'] != $login_branch}
                                                                            {continue}
                                                                        {/if}
                                                                        <optgroup label="{$branch['name']}">
                                                                            {foreach item=row from=$branch['users']}
                                                                                {if $action_rights['DAY-CLO-ALL-BRCH'] != 1 && $action_rights['DAY-CLO-SAM-BRCH'] != 1 && $row->code != $usr_login_id}
                                                                                    {continue}
                                                                                {/if}
                                                                                {if $row->activeFlag == 1}
                                                                                    {if in_array($row->code, $primary)}
                                                                                        <option value="{$row->code}" data-org="{$row->organization->code}" {if $row->code == $usr_login_id}selected{/if}>{$row->name} {if isNotNull($row->aliasCode)} - {$row->aliasCode}{/if} <span class="bold">(Primary)</span></option>
                                                                                    {else}
                                                                                        <option value="{$row->code}" data-org="{$row->organization->code}" {if $row->code == $usr_login_id}selected{/if}>{$row->name} {if isNotNull($row->aliasCode)} - {$row->aliasCode}{/if}</option>
                                                                                    {/if}
                                                                                {/if}
                                                                            {/foreach}
                                                                        </optgroup>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2" style="display: none;">
                                                            <label for="dayclosing_user">Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="day_closing_date" class="form-control sdate" id="day_closing_date" readonly="true" placeholder="Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="1">
                                                                <button type="button" class="btn btn-success" onclick="getDayClosingReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearDayClosingReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="dayclosing_action_state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="day-closing-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div id="day-closing-list"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<div id="approval-pending-dialog" class="hide">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="closeApprovalPendingTransaction();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div class="">
        <div class="col-lg-12 p_l_n">
            <div class="table-responsive" id="approval-pending-list"></div>
        </div>
    </div>
</div>

<div id="pending-payments-dialog" class="hide">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="closePendingPaymentsDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div class="">
        <div class="col-lg-12 p_l_n">
            <div class="table-responsive" id="pending-payments-list"></div>
        </div>
    </div>
</div>

<script type="text/html" id="day-closing-payment" class="hide">
    <form role="form" class="form-horizontal">
        <div class="clear_fix_both"></div>
        <br/>
        <div class="col-lg-4 p_l_n p_r_n">
            <label for="pay_voucher_user" class="req">Payment To</label>
            <select id='pay_voucher_user' class="form-control" onchange="getBankDetails()">
            </select>
        </div>
        <div class="col-lg-4">
            <label for="pay_voucher_amount">Amount Received</label>
            <div class="input-group">
                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                <input type="text" class="form-control" id="pay_voucher_amount" maxlength="6">
            </div>
        </div>
        <div class="col-lg-4 p_l_n p_r_n">
            <label for="pay_voucher_tmode" class="req">Transaction Mode</label>
            <select id="pay_voucher_tmode" class="form-control col-md-6" onchange="transactionModeDetails()">
                <option value="">Select</option>
                {foreach key=key item=value from=$transactionMode}
                    <option value="{$key}">{$value}</option>
                {/foreach}
            </select>
        </div>
        <div class="clear_fix_both"></div>
        <br/>

        <div class="hide" id="upi-mode-panel">
            <div class="well well-sm">
                <div class="row">
                    <div class="col-lg-4 p_r_n">
                        <label for="upi-orgbank" class="req">Organization Bank</label>
                        <select class="form-control" id="upi-orgbank">
                            <option value="">Select Organization Bank</option>
                        </select>
                    </div>
                    <div class="col-lg-4 p_r_n">
                        <label for="upi-id">UPI ID</label>
                        <input type="text" class="form-control" id="upi-id" maxlength="250" placeholder="UPI ID" autocomplete="off">
                    </div>
                    <div class="col-lg-4">
                        <label for="upi-details" class="req">Ref. #</label>
                        <input type="text" class="form-control" id="upi-details" placeholder="Ref. #" autocomplete="off">
                    </div>
                </div>
            </div>
        </div>

        <div class="hide" id="netbanking-mode-panel">
            <div class="well well-sm">
                <div class="row">
                    <div class="col-md-3 p_r_n">
                        <label for="netbanking-orgbank" class="req">Organization Bank</label>
                        <select class="form-control" id="netbanking-orgbank">
                            <option value="">Select Organization Bank</option>
                        </select>
                    </div>
                    <div class="col-md-3 p_r_n">
                        <label for="netbanking-accholder">Account Holder Name</label>
                        <input type="text" class="form-control" id="netbanking-accholder" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                    </div>
                    <div class="col-md-3 p_r_n">
                        <label for="netbanking-bankname">Bank Name</label>
                        <input type="text" class="form-control" id="netbanking-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                    </div>
                    <div class="col-md-3">
                        <label for="netbanking-details" class="req">Ref. #</label>
                        <input type="text" class="form-control" id="netbanking-details" placeholder="Ref. #" autocomplete="off">
                    </div>
                </div>
            </div>
        </div>

        <div class="hide" id="cheque-mode-panel">
            <div class="well well-sm">
                <div class="row">
                    <div class="col-md-3 p_r_n">
                        <label for="cheque-payer" class="req">Payer Details</label>
                        <input type="text" class="form-control" id="cheque-payer" maxlength="250" placeholder="Payer Details" autocomplete="off">
                    </div>
                    <div class="col-md-3 p_r_n">
                        <label for="cheque-no" class="req">Cheque No</label>
                        <input type="text" class="form-control" id="cheque-no" maxlength="60" placeholder="Cheque No" autocomplete="off">
                    </div>
                    <div class="col-md-3 p_r_n">
                        <label for="cheque-date" class="req">Cheque Date</label>
                        <input type="text" class="form-control" id="cheque-date" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                    </div>
                    <div class="col-md-3">
                        <label for="cheque-bankcity" class="req">Bank City</label>
                        <input type="text" class="form-control" id="cheque-bankcity" maxlength="90" placeholder="Bank City" autocomplete="off">
                    </div>
                    <div class="col-md-6 p_r_n">
                        <label for="cheque-bankname" class="req">Bank Name</label>
                        <input type="text" class="form-control" id="cheque-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                    </div>
                    <div class="col-md-6">
                        <label for="cheque-remarks">Remarks</label>
                        <input type="text" class="form-control" placeholder="Remarks" id="cheque-remarks" data-mask="englishonly"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-12 p_l_n p_r_n">
            <label for="pay_voucher_remarks" class="req">Remarks</label>
            <textarea id="pay_voucher_remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" maxlength="120"></textarea>
        </div>
        <div class="clear_fix_both"></div>
    </form>
    <br/>
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="day_closing_action_state"></div>
        <div class="align-right">
            <input type="hidden" id="hid_primary_user"/>
            <input type="hidden" id="hid_receipt_code"/>
            <button class="btn btn-success" type="button" id="confirm-pay" onclick="closeUserBalance();">Confirm</button>
            <button class="btn btn-default" type="button" onclick="cancelReceiptPaymentDialog();">Cancel</button>
        </div>
    </div>
</script>

<script>
    var org_data = {$organization|json_encode};
    var primary_users = {$userAssignedBranches|json_encode};
    var bankNamesList = {$bank_names_list|json_encode};

    $(function() {
        $('#day_closing_date').daterangepicker({
            singleDatePicker: true,
            timePicker: true,
            timePickerIncrement: 1,
            format: 'DD-MM-YYYY hh:mm:ss A',
            endDate: moment(),
            maxDate: moment().endOf('day'),
            autoApply: false,
            showDropdowns: false,
        }).on('hide.daterangepicker', function(ev, picker) {
            picker.updateInputText();
        });
        var picker = $('#day_closing_date').data('daterangepicker');
        picker.setStartDate(moment())
        picker.updateInputText();
    })
    
    $('#dayclosing_user, #pay_voucher_user').select2();
    
    var opt ='';
    $.each(org_data, function(key, branch){
        if(branch.user.code){
            opt += '<optgroup data-code="'+ branch.code +'" label="'+ branch.name +'"><option value="'+ branch.user.code +'">'+ branch.user.name +'</option></optgroup>'
        }
    })
    var options = '<option value="">Select a user</option>'+ opt; 
    
    function transactionModeDetails() {
        var mode = $('#pay_voucher_tmode').val();

        $('#cheque-mode-panel').addClass('hide');
        $('#netbanking-mode-panel').addClass('hide');
        $('#upi-mode-panel').addClass('hide');
            
        if (mode == 'CHEQUE') {
            $('#cheque-mode-panel').removeClass('hide');

            $('#cheque-bankname').autocomplete({
                minLength: 0,
                source: bankNamesList
            }).focus(function() {
                $(this).autocomplete('search', '');
            });

            $('#cheque-date').datepicker({
                todayHighlight: true,
                format: 'dd-mm-yyyy',
                autoclose: true,
                changeMonth: true,
                startDate: '-1d',
                endDate:'0d'
            });
            
        } else if (mode == 'NBK') {
            $('#netbanking-mode-panel').removeClass('hide');

            $('#netbanking-orgbank').html(new Option('Loading...', '', true, true)).select2().html('');
        } else if (mode == 'UPI') {
            $('#upi-mode-panel').removeClass('hide');

            $('#upi-orgbank').html(new Option('Loading...', '', true, true)).select2().html('');
        }

        var data = {};
        data.organizationcode = $('#dayclosing_user option:selected').data('org');

        if (!data.organizationcode) {
            return;
        }

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'branch/get-organization-other-details',
            data: data,
            success: function (res) {
                if (res.status == 1) {
                    res.data.bankDetails = res.data.bankDetails || [];
                    if (mode == 'NBK') {
                        $('#netbanking-orgbank').html('').prop('disabled', false);
                        if (res.data.bankDetails.length > 1) {
                            $('#netbanking-orgbank').html(new Option('Select Organization Bank', ''));
                        }
                        if (res.status == 1) {
                            $.each(res.data.bankDetails || [], function (i, bank) {
                                if (bank.accountType.code != 'CASH') {
                                    $('#netbanking-orgbank').append(new Option(bank.name + ' - ' + bank.accountNumber, bank.code));
                                }
                            });
                        }
                        $('#netbanking-orgbank').select2();
                    } else if (mode == 'UPI') {
                        $('#upi-orgbank').html('').prop('disabled', false);
                        if (res.data.bankDetails.length > 1) {
                            $('#upi-orgbank').html(new Option('Select Organization Bank', ''));
                        }
                        if (res.status == 1) {
                            $.each(res.data.bankDetails || [], function (i, bank) {
                                if (bank.accountType.code != 'CASH') {
                                    $('#upi-orgbank').append(new Option(bank.name + ' - ' + bank.accountNumber, bank.code));
                                }
                            });
                        }
                        $('#upi-orgbank').select2();
                    }
                }
            }
        });
    }

    function paymentToOptChange(code, orgcode, isPrimary){
        var data = {};
        data.org_code = $('#dayclosing_user option:selected').data('org');
        
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'branch/get-payment-preference-org',
            data: data,
            success: function (response) {
                if(response.status == 1){
                    var res = response.data[0];
                    console.l
                    if(res){
                        if(res.toOrganizationList.length > 0){
                            $('#pay_voucher_user').empty().append(function(){
                                return '<option value="">Select a user</option>' + $.map(res.toOrganizationList, function(val, key){
                                    return '<optgroup data-code="'+ val.code +'" label="'+ val.name +'"><option value="'+val.user.code+'" data- data-fromOrg-primary="'+res.fromOrganization.user.code+'" data-orgcode="'+ val.code +'">'+val.user.name+'</option></optgroup>';
                                });
                            });
                            $('#pay_voucher_user').val('').trigger('change');
                        }else{
                            if(isPrimary == 1){
                                alert('Please add preferred organization/ branches for payment !!!');
                                $('#pay_voucher_user').data('select2').destroy();
                                $('#pay_voucher_user').attr('readonly', true);
                                return;
                            }else{
                                $('#pay_voucher_user').empty().append(options);
                                var primary = _.find(primary_users || [], o => o.code == orgcode);
                                $('#pay_voucher_user').val(primary.user.code).trigger('change');
                                $('#pay_voucher_user').data('select2').destroy();
                                $('#pay_voucher_user').attr('disabled', true);
                            }
                        }
                    }else{
                        if(isPrimary == 1){
                            alert('Please add preferred organization/ branches for payment !!!');
                            $('#pay_voucher_user').data('select2').destroy();
                            $('#pay_voucher_user').attr('readonly', true);
                            return;
                        }else{
                            $('#pay_voucher_user').empty().append(options);
                            var primary = _.find(primary_users || [], o => o.code == orgcode);
                            $('#pay_voucher_user').val(primary.user.code).trigger('change');
                            $('#pay_voucher_user').data('select2').destroy();
                            $('#pay_voucher_user').attr('disabled', true);
                        }
                    }
                }
            }
        });
    }

    function getDayClosingReport() {
        $('#day-closing-list').html('');
        var data = {};
        data.userCode = $('#dayclosing_user').val();
        data.orgCode = $('#dayclosing_user option:selected').data('org');

        var toDate = moment($('#day_closing_date').val(), 'DD-MM-YYYY h:mm:ss A').format('YYYY-MM-DD HH:mm:ss');
        if (moment().diff(toDate, 'seconds') <= 0) {
            var picker = $('#day_closing_date').data('daterangepicker');
            picker.setStartDate(moment());
            picker.updateInputText();
        } 
        else if (moment().diff(toDate, 'minutes') > 0) {
            var picker = $('#day_closing_date').data('daterangepicker');
            picker.setStartDate(moment(toDate).format('DD-MM-YYYY h:mm:59 A'));
            picker.updateInputText();
        }
        data.toDate = moment($('#day_closing_date').val(), 'DD-MM-YYYY h:mm:ss A').format('YYYY-MM-DD HH:mm:ss');

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if (data.userCode == '') {
            $('#branchbalance_user').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#dayclosing_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#dayclosing_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#dayclosing_action_state').show();
            return false;
        } else {
            $('#dayclosing_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#dayclosing_action_state').html('');
            $('#dayclosing_action_state').hide();
        }

        $('#dayclosing_to').removeClass('inp_error');
        $('#day-closing-list-container').removeClass('hidden');
        $('#day-closing-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "branch/day-closing-list",
            data: data,
            success: function(response) {
                $('#day-closing-list').html(response);
                $('#dayclosing_rpt_excel').show();
                $('#day_closing_date').closest('.form-group').show();
                $('html, body').animate({
                    scrollTop: $('#day-closing-list-container').offset().top - 35
                }, 'slow');

            }
        });
    }

    function clearDayClosingReport() {
        $('#dayclosing_from').val('');
        $('#dayclosing_to').val('');
        $('#day-closing-list-container').addClass('hidden');
        $('#day-closing-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#dayclosing_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#dayclosing_action_state').html('');
        $('#dayclosing_action_state').hide();
        $('#dayclosing_user option:eq(0)').attr('selected', true).trigger('change');
        $('#dayclosing_rpt_excel').hide();
        $('#day_closing_date').closest('.form-group').hide();
        $('#day_closing_date').val('');
    }

    function closeUserBalance() {
        $('.inp_error').removeClass('inp_error');
        var err = 0;

        var code = $('#hid_receipt_code').val();
        var isPrimary = Number($('#hid_primary_user').val());
        if (isPrimary) {
            var receiptDetails = branchUserTransactions;
        } else {
            var receiptDetails = _.find(branchUserTransactions.organizationReceiptDetails || [], o => o.fromUser.code == code);
        }

        if (!code || !receiptDetails) {
            return;
        }
        var data = {};
        data.activeFlag = 1;
        data.totalExpenseAmount = 0;
        data.totalIncomeAmount = 0;
        data.bookedAmount = 0;
        data.deliveryAmount = 0;
        data.commissionAmount = 0;
        data.revertAmount = 0;
        data.settlementAmount = 0;

        data.organization = branchUserTransactions.organization;
        data.user = branchUserTransactions.user;
        data.paymentAcknowledge = branchUserTransactions.paymentAcknowledge;

        data.organizationReceiptDetails = [];
        $.each(branchUserTransactions.organizationReceiptDetails || [], function (i, receiptDetails) {
            if ((isPrimary && (receiptDetails.settlementAmount > 0 || receiptDetails.organizationUserTransaction.openingBalanceAmount > 0)) || (receiptDetails.fromUser.code == code)) {
                data.totalExpenseAmount += receiptDetails.expenseAmount;
                data.totalIncomeAmount += receiptDetails.incomeAmount;
                data.bookedAmount += receiptDetails.bookedAmount;
                data.deliveryAmount += receiptDetails.deliveryAmount;
                data.commissionAmount += receiptDetails.commissionAmount;
                data.revertAmount += receiptDetails.revertAmount;
                data.settlementAmount += receiptDetails.settlementAmount;

                var dateTime = $('#day_closing_date').val();
                var toDateTime = moment(dateTime, 'DD-MM-YYYY h:mm:ss A').format('YYYY-MM-DD HH:mm:ss');
                var fromDateTime = moment(receiptDetails.fromDateTime, 'YYYY-MM-DD HH:mm:ss').format('YYYY-MM-DD HH:mm:ss');
                if (toDateTime >= fromDateTime) {
                    receiptDetails.toDateTime = toDateTime;
                } else {
                    $('#day_closing_date').addClass('inp_error');
                    alert('Closing date is smaller than last closed date and time!!')
                    err++;
                }

                receiptDetails.paymentMode = {};
                receiptDetails.paymentMode.code = $('#pay_voucher_tmode').val();

                if (receiptDetails.paymentMode.code == 'UPI') {
                    receiptDetails.bankDetails = {};
                    receiptDetails.bankDetails.code = $('#upi-orgbank').val();

                    receiptDetails.addAttr1 = $.trim($('#upi-id').val());
                    receiptDetails.addAttr2 = $.trim($('#upi-details').val());
                    receiptDetails.addAttr3 = 'NA';

                    if (receiptDetails.bankDetails.code == '') {
                        $('#upi-orgbank').addClass('inp_error');
                        err++;
                    }

                    if (receiptDetails.addAttr2 == '') {
                        $('#upi-details').addClass('inp_error');
                        err++;
                    }
                } else if (receiptDetails.paymentMode.code == 'NBK') {
                    receiptDetails.bankDetails = {};
                    receiptDetails.bankDetails.code = $('#netbanking-orgbank').val();

                    receiptDetails.addAttr1 = $.trim($('#netbanking-accholder').val());
                    receiptDetails.addAttr2 = $.trim($('#netbanking-bankname').val());
                    receiptDetails.addAttr3 = $.trim($('#netbanking-details').val());

                    if (receiptDetails.bankDetails.code == '') {
                        $('#netbanking-orgbank').addClass('inp_error');
                        err++;
                    }

                    if (receiptDetails.addAttr3 == '') {
                        $('#netbanking-details').addClass('inp_error');
                        err++;
                    }
                } else if (receiptDetails.paymentMode.code == 'CHEQUE') {
                    receiptDetails.chequeDetails = {};

                    receiptDetails.chequeDetails.organization = branchUserTransactions.organization;
                    // receiptDetails.chequeDetails.organization.code = branchUserTransactions.organization.code;

                    receiptDetails.chequeDetails.bankDetails = $.trim($('#cheque-bankname').val());
                    receiptDetails.chequeDetails.payerDetails = $.trim($('#cheque-payer').val());
                    
                    receiptDetails.chequeDetails.chequeDate = moment($('#cheque-date').val()).format('YYYY-MM-DD');
                    receiptDetails.chequeDetails.chequeNo = $.trim($('#cheque-no').val());
                    receiptDetails.chequeDetails.bankCity = $.trim($('#cheque-bankcity').val());

                    receiptDetails.chequeDetails.chequeStatus = {};
                    receiptDetails.chequeDetails.chequeStatus.code = 'NEW';

                    receiptDetails.chequeDetails.remarks = $.trim($('#cheque-remarks').val());

                    if (receiptDetails.chequeDetails.payerDetails == '') {
                        $('#cheque-payer').addClass('inp_error');
                        err++;
                    }

                    if (receiptDetails.chequeDetails.chequeNo == '') {
                        $('#cheque-no').addClass('inp_error');
                        err++;
                    }

                    if ($('#cheque-date').val() == '') {
                        $('#cheque-date').addClass('inp_error');
                        err++;
                    }

                    if (receiptDetails.chequeDetails.bankCity == '') {
                        $('#cheque-bankcity').addClass('inp_error');
                        err++;
                    }
                    
                    if (receiptDetails.chequeDetails.bankDetails == '') {
                        $('#cheque-bankname').addClass('inp_error');
                        err++;
                    }
                }

                if (isPrimary) {
                    receiptDetails.paidAmount = parseFloat($('.user-pay-amt[data-usercode="' + receiptDetails.fromUser.code + '"]').val()) || 0;
                } else {
                    receiptDetails.paidAmount = $('#pay_voucher_amount').val();
                }

                receiptDetails.toUser = {};
                if (receiptDetails.fromUser.code == '{$usr_login_id}') {
                    receiptDetails.toUser.code = $('#pay_voucher_user').val();
                } else {
                    receiptDetails.toUser.code = $('#primary-user-code').val();
                }

                if (receiptDetails.paymentMode.code == '') {
                    $('#pay_voucher_tmode').addClass('inp_error');
                    err++;
                }
                if (receiptDetails.toUser.code == '') {
                    $('#pay_voucher_user').addClass('inp_error');
                    err++;
                }

                data.organizationReceiptDetails.push(receiptDetails);
            }
        });

        data.remarks = $.trim($('#pay_voucher_remarks').val());

        // $('.inp_error').removeClass('inp_error');
        // if (data.settlementAmount == '' || isNaN(data.settlementAmount)) {
        //     $('#pay_voucher_amount').addClass('inp_error');
        //     err++;
        // }

        if (!$('#pay_voucher_user').val()) {
            $('#pay_voucher_user').addClass('inp_error');
            err++;
        }

        if (!$('#pay_voucher_tmode').val()) {
            $('#pay_voucher_tmode').addClass('inp_error');
            err++;
        }

        if (data.remarks == '') {
            $('#pay_voucher_remarks').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#day_closing_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#day_closing_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#day_closing_action_state').show();
            return false;
        } else {
            $('#day_closing_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#day_closing_action_state').html('');
            $('#day_closing_action_state').hide();
        }

        if (!confirm('Do you want to close balance?')) {
            return;
        }

        $('#day_closing_action_state').removeClass('alert-success').removeClass('alert-danger').show();
        $('#day_closing_action_state').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "branch/save_branch_user_transactions",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#day_closing_action_state').removeClass('alert-danger');
                    $('#day_closing_action_state').addClass('alert-success');
                    $('#day_closing_action_state').html('Your request has been completed successfully');
                } else {
                    $('#day_closing_action_state').removeClass('alert-success');
                    $('#day_closing_action_state').addClass('alert-danger');

                    if (response.data) {
                        var err_msg = response.errorDesc + ' - ' + response.data;
                    } else {
                        var err_msg = response.errorDesc;
                    }
                    $('#day_closing_action_state').html(err_msg);
                }
                window.setTimeout(function () {
                    cancelReceiptPaymentDialog();
                    getDayClosingReport();
                }, 2000);
            }
        });
    }

    function receiptPaymentDialog(code, orgcode, isPrimary) {
        var receiptDetails = _.find(branchUserTransactions.organizationReceiptDetails || [], o => o.fromUser.code == code);

        $('.make-payment-form-panel').html('');
        var tpl = $('#day-closing-payment').html();
        $('.payment-panel[data-usercode="' + code + '"]').find('.make-payment-form-panel').html(tpl);
        paymentToOptChange(code, orgcode, isPrimary);
        
        $('#hid_receipt_code').val(code);
        $('#hid_primary_user').val(isPrimary);

        var amt_rcved = receiptDetails.organizationUserTransaction.openingBalanceAmount + receiptDetails.bookedAmount + receiptDetails.deliveryAmount + receiptDetails.incomeAmount - receiptDetails.expenseAmount - receiptDetails.commissionAmount + receiptDetails.revertAmount;
        var settlementAmount = (amt_rcved > 0) ? amt_rcved : 0;

        //var settlementAmount = (receiptDetails.settlementAmount > 0) ? receiptDetails.settlementAmount : 0;
        $('#pay_voucher_amount').val(Number(settlementAmount).toFixed(2)).data('amount', settlementAmount);
        $('#pay_voucher_amount').prop('disabled', isPrimary == 1)
        $('#pay_receipt_remarks').val('');
        $('#pay_voucher_user').val('');
        $('#pay_voucher_user').trigger('change').select2();
        if (isPrimary) {
            calculatePayable();
        }

        $('#day_closing_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#day_closing_action_state').html('').hide();
    }

    function cancelReceiptPaymentDialog() {
        $('.make-payment-form-panel').html('');
    }

    function getBankDetails() {
        var data = {};
        data.branchCode = $.trim($('#pay_voucher_user option:selected').data('orgcode'));

        if (data.branchCode == '') {
            return false;
        }

        $('#bank-details-panel').removeClass('hide');
        $('#bank-details-panel').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "branch/branch-bank-details",
            data: data,
            success: function (response) {
                $('#bank-details-panel').html(response);
            }
        });
    }

    function approvalPendingTransaction(userCode) {
        $('#approval-pending-dialog').css('background', '#fff');
        $('#approval-pending-dialog').removeClass('hide');
        $('#approval-pending-dialog').dialog({
            autoOpen: true,
            height: 400,
            width: $(window).width()-500,
            modal: true,
            resizable: false,
            closeOnEscape: true
        });
        $('.ui-dialog-titlebar').hide();
        
        $('#approval-pending-list').html(loading_popup);

        var data = {};
        data.organizationCode = $('#dayclosing_user option:selected').data('org');
        data.userCode = userCode;
        
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "branch/get-approval-pending-transaction",
            data: data,
            success: function (response) {
                $('#approval-pending-list').html(response);
            }
        });
    }

    function closeApprovalPendingTransaction() {
        $('#approval-pending-dialog').dialog('destroy');
        $('#approval-pending-dialog').hide();
    }

    function pendingPaymentsDialog(userCode) {
        $('#pending-payments-dialog').css('background', '#fff');
        $('#pending-payments-dialog').removeClass('hide');
        $('#pending-payments-dialog').dialog({
            autoOpen: true,
            height: 600,
            width: $(window).width()-50,
            modal: true,
            resizable: false,
            closeOnEscape: true
        });
        $('.ui-dialog-titlebar').hide();
        
        $('#pending-payments-list').html(loading_popup);

        var data = {};
        data.organizationCode = $('#dayclosing_user option:selected').data('org');
        data.userCode = userCode;
        
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "branch/get-pending-payments",
            data: data,
            success: function (response) {
                $('#pending-payments-list').html(response);
            }
        });
    }

    function closePendingPaymentsDialog() {
        $('#pending-payments-dialog').dialog('destroy');
        $('#pending-payments-dialog').hide();
    }
</script>
