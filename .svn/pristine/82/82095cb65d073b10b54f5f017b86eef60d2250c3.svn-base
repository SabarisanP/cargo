<div class="brand_top">
    <h3>Contra Transfer</h3>
    <div class="text-right noprint">
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="addContraTransfer();">Add Contra Transfer</a>
    </div>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <ul class="nav nav-tabs">
                                        <li class="active"><a data-toggle="tab" href="#paid">Paid</a></li>
                                        <li><a data-toggle="tab" href="#ack">Paid, waiting for Ack</a></li>
                                        <li><a data-toggle="tab" href="#unpaid">Unpaid</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="paid" class="tab-pane fade in active">
                                            <div id="paid-panel">
                                                <form id="contra-transfer-form" name="contra-transfer-form" method="post" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="contra-transfer-from-date" class="req">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="contra-transfer-from-date" readonly="true" placeholder="Date From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="contra-transfer-to-date" class="req">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="contra-transfer-to-date" readonly="true" placeholder="Date To">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="contra-transfer-branch">Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="contra-transfer-branch" class="form-control" {if $action_rights['CONTRA-ALLOW-ALL-BRANCH'] != 1}disabled{/if}>
                                                                    <option value="NA">All Branch</option>
                                                                    {foreach from=$organization item=row}
                                                                        <option value="{$row->code}" {if $loggedin_user_org == $row->code}selected{/if}>{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <button class="btn btn-success" type="button"  onclick="generatePaidContraTransfer()">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearContraTransfer()">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;" id="contra-transfer-report-action-state"></div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left hide" id="contra-paid-action-state"></div>
                                            <div id="paid-contra-list"></div>
                                        </div>
                                        <div id="ack" class="tab-pane fade">
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left hide" id="contra-ack-action-state"></div>
                                            <div id="ack-contra-list"></div>
                                        </div>
                                        <div id="unpaid" class="tab-pane fade">
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left hide" id="contra-unpaid-action-state"></div>
                                            <div id="unpaid-contra-list"></div>
                                        </div>
                                    </div>
                                </div><!--content end-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="add-contra-transfer-dialog"  class="dialog-content-page hide">
    <div class="row">
        <div class="col-md-10 bold ft_15">
            Add Contra Transfer
        </div>
    </div>
    <br>
    <div class="row">
        <div class="form-group col-md-4">
            <label class="req" for="contra-transfer-pay-con">From Account</label>
            <input type="text" class="form-control" id="contra-transfer-pay-con" onclick="getVendorContact();" {if $action_rights['CONTRA-ALLOW-ALL-BRANCH'] != 1}disabled{/if}>
        </div>
        
        <div class="form-group col-md-4">
            <label class="req" for="contra-transfer-ven-con">To Account</label>
            <input type="text" class="form-control" id="contra-transfer-ven-con">
        </div>

        <div class="form-group col-md-4">
            <label for="contra-transfer-date" class="req">Date</label>
            <div class="input-group">
                <input type="text" name="transactionDate" class="form-control sdate" id="contra-transfer-date" readonly="true" placeholder="Date">
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
        </div>

        <div class="form-group col-md-3">
            <label class="req" for="contra-transfer-amount">Amount</label>
            <input type="number" class="form-control" id="contra-transfer-amount" placeholder="Amount" min="0" max="10000000" step="0.01">
        </div>
        
        <div class="form-group col-md-9">
            <label>Remarks</label>
            <textarea id="contra-transfer-remarks"  placeholder="Enter your remarks" style="resize:none" class="form-control" rows="2" cols="30" name="remark" id="remark"></textarea>
        </div>
    </div>
    
    <div style="padding:0 15px;">
        <div class="row">
            <input type="hidden" id="contra-transfer-code">
            <div class="clear_fix_both">
                <div class="alert hide" id="contra-transfer-action-state"></div>
                <div class="align-right"  id="contra-transfer-button">
                    <button class="btn btn-success" type="button" onclick="saveContraTransfer();">Save</button>
                    <button class="btn btn-default" type="button" onclick="closeContraTransferDialog();">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script id="contact-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-8">
            <b class="contact-name"></b><br>
            <span class="contact-branch-name text-muted small"></span>
        </div>
        <div class="col-xs-4 text-right">
            <b class="contact-type"></b><br>
            <span class="contact-bank-name text-muted small"></span>
        </div>
    </div>
</script>

<script id="account-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-7">
            <b class="account-name"></b>
        </div>
        <div class="col-xs-5 text-right text-muted small" title="Balance">
            <i class="fa fa-rupee"></i> <span class="current-balance "></span>
        </div>
    </div>
</script>

<script>
    var organizationcode = {$loggedin_user_org|json_encode}
    var logged_in_user = {$logged_in_user|json_encode}
    var branchBankData = {$branchBankData|json_encode} 
    var user_code = {$user_code|json_encode};
    var contactSelectTpl = $('#contact-select-tpl').html();

    var allBranchBank = [];
    $.each(branchBankData || [], function (i, row) {
        if (!row.code) return;

        var branchBank = {};
        branchBank.id = row.contact.code;
        branchBank.text = row.contact.name;
        branchBank.type = row.type;

        if (branchBank.type == 'BANK') {
            branchBank.additionalDetails = {};
            branchBank.additionalDetails.bankName = row.additionalDetails.bankName;
            branchBank.additionalDetails.accountNumber = row.additionalDetails.accountNumber;
        }

        branchBank.branch = {};
        branchBank.branch.id = row.code;
        branchBank.branch.text = row.name;
        allBranchBank.push(branchBank);
    });
                                                                 
    $('#contra-transfer-pay-con').select2({
        data: { results: allBranchBank },
        placeholder: 'Select Payment Contact',
        formatResult: formatContraTransferContactResult,
        formatSelection: formatContraTransferContactResult,
        matcher: ContraTransferContactMatcher
    });

    $('#contra-transfer-ven-con').select2({
        data: { results: allBranchBank },
        placeholder: 'Select Vendor Contact',
        formatResult: formatContraTransferContactResult,
        formatSelection: formatContraTransferContactResult,
        matcher: ContraTransferContactMatcher
    });

    $('#contra-transfer-branch').select2();

    $('#contra-transfer-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true
    });

    $('#contra-transfer-from-date').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true
    }).on('changeDate', function (e) {
        $('#contra-transfer-to-date').datepicker('setStartDate', e.date);
    });

    $('#contra-transfer-to-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true
    }).on('changeDate', function (e) {
        $('#contra-transfer-from-date').datepicker('setEndDate', e.date);
    });

    $('a[href="#ack"]').on('show.bs.tab', function (e) {
        $('#contra-ack-action-state').removeClass('alert-success, alert-danger').addClass('hide').html('');
        generateAckContraTransfer();
    });

    $('a[href="#unpaid"]').on('show.bs.tab', function (e) {
        $('#contra-unpaid-action-state').removeClass('alert-success, alert-danger').addClass('hide').html('');
        generateInitContraTransfer();
    });

    function getVendorContact(code) {
        $('#contra-transfer-ven-con').val('').select2('destroy');
        var data = {};
        paymentContactData = $('#contra-transfer-pay-con').select2('data');
        if (!paymentContactData.id) {
            return;
        }

        var vendorContact = [];
        $.each(allBranchBank, function(k,val) {
            if (val.id != paymentContactData.id) {
                vendorContact.push(val);
            }                                                         
        });

        $('#contra-transfer-ven-con').select2({
            data: { results: vendorContact },
            placeholder: 'Select Vendor Contact',
            formatResult: formatContraTransferContactResult,
            formatSelection: formatContraTransferContactResult,
            matcher: ContraTransferContactMatcher
        });

        if(isNotNull(code)) {
            $('#contra-transfer-ven-con').val(code).trigger('change');
        }
    };

    function formatContraTransferContactResult(contact) {
        if (!contact.id) return;
        var $tpl = $(contactSelectTpl);
        $tpl.find('.contact-name').text(contact.text);
        $tpl.find('.contact-type').text(contact.type);
        $tpl.find('.contact-branch-name').text(contact.branch.text);

        if (isNotNull(contact.additionalDetails)) {
            $tpl.find('.contact-bank-name').text(contact.additionalDetails.bankName);
        }
        return $tpl;
    };

    function ContraTransferContactMatcher(term, text, contact) {
        text = [contact.text, contact.branch.text, contact.type].join(' ');
        return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
    };

    // init
    function generateInitContraTransfer() {
        var data={};
        if (menu_permission['CONTRA-ALLOW-ALL-BRANCH'] == 1) {
            data.organizationCode = "NA";
        } else {
            data.organizationCode = organizationcode;
        }
        $('#unpaid-contra-list').html('');
        $('#unpaid-contra-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            data: data,
            url: base_url + 'payment/contra-transfer-init-list',
            success: function (response) {
                $('#unpaid-contra-list').html(response);
            }
        });
    }

     // ack
     function generateAckContraTransfer() {
        var data={};
        if (menu_permission['CONTRA-ALLOW-ALL-BRANCH'] == 1) {
            data.organizationCode = "NA";  
        } else {
            data.organizationCode = organizationcode;
        }
        $('#ack-contra-list').html('');
        $('#ack-contra-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            data:data,
            url: base_url + 'payment/contra-transfer-ack-list',
            success: function (response) {
                $('#ack-contra-list').html(response);
            }
        });
    }

    // paid
    function generatePaidContraTransfer() {
        $('#paid-contra-list').html('');
        var data = {};
        data.fromDate = $('#contra-transfer-from-date').data('datepicker').getFormattedDate('yyyy-mm-dd');
        data.toDate = $('#contra-transfer-to-date').data('datepicker').getFormattedDate('yyyy-mm-dd');

        if (menu_permission['CONTRA-ALLOW-ALL-BRANCH'] == 1) {
            data.organizationCode = $('#contra-transfer-branch').val();  
        } else {
            data.organizationCode = organizationcode;
        }

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if (data.fromDate == '') {
            $('#contra-transfer-from-date').addClass('inp_error');
            err++;
        }

        if (data.toDate == '') {
            $('#contra-transfer-to-date').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#contra-transfer-report-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#contra-transfer-report-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#contra-transfer-report-action-state').show();
            return false;
        }

        $('#contra-transfer-report-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#contra-transfer-report-action-state').html('').hide();

        $('#paid-contra-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'payment/contra-transfer-paid-list',
            data: data,
            success: function (response) {
                $('#paid-contra-list').html(response);
            }
        });
    }

    function clearContraTransfer() {
        $('#contra-transfer-from-date, #contra-transfer-to-date').datepicker('setDate', '');
        $('#contra-transfer-branch').val('NA').trigger('change')

        $('#contra-transfer-list-container').addClass('hidden');
        $('#contra-transfer-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#contra-transfer-report-action-state').removeClass('alert-success, alert-danger').html('').hide();
    }
    
    function addContraTransfer(code) {
        $('#add-contra-transfer-dialog').css('background', '#fff');
        $('#add-contra-transfer-dialog').removeClass('hide');
        $('#add-contra-transfer-dialog').dialog({
            autoOpen: true,
            height: 350,
            width: $(window).width() - 500,
            modal: true,
            resizable: false,
            closeOnEscape: true
        });
        $('.ui-dialog-titlebar').hide();
        $('.inp_error').removeClass('inp_error');
        $('#contra-transfer-action-state').removeClass('alert-success, alert-danger').html('').hide();

        if (isNotNull(logged_in_user.user)) {
            $('#contra-transfer-pay-con').val(logged_in_user.user.code).trigger('change');
        }
        $('#contra-transfer-toorg, #contra-transfer-ven-con').val('').trigger('change');
        $('#contra-transfer-toacc, #contra-transfer-fromacc').val('');
        $('#contra-transfer-amount, #contra-transfer-remarks').val('');
        $('#contra-transfer-code').val('');
        $('#contra-transfer-date').val('');
        if (isNotNull(code)) {
            var data = _.find(contraInitData || [], o => o.code == code);
            
            $('#contra-transfer-date').datepicker('update', moment(data.transactionDate).format('DD-MM-YYYY'));
            $('#contra-transfer-code').val(code);
            $('#contra-transfer-amount').val(data.amount);
            $('#contra-transfer-pay-con').val(data.paymentContact.code).trigger('change');
            $('#contra-transfer-remarks').val(data.remarks);
            getVendorContact(data.vendorContact.code);
        }
    }

    function closeContraTransferDialog() {
        $('#add-contra-transfer-dialog').addClass('hide');
        $('#add-contra-transfer-dialog').dialog('destroy');
    }

    function saveContraTransfer() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        var data = {};
        data.code = $('#contra-transfer-code').val();
        data.activeFlag = 1;
        data.amount = $('#contra-transfer-amount').val();
        data.transactionDate = moment($('#contra-transfer-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
        var paymentContact = $('#contra-transfer-pay-con').select2('data');
        data.paymentContact = {};
        if (isNotNull(paymentContact)) {
            data.paymentContact.code = paymentContact.id;
        }

        var vendorContact = $('#contra-transfer-ven-con').select2('data');
        data.vendorContact = {};
        if (isNotNull(vendorContact)) {
            data.vendorContact.code = vendorContact.id;
        }

        data.paymentStatus = {};
        data.paymentStatus.code = 'INIT';

        data.remarks = $('#contra-transfer-remarks').val();
        if (isNull(data.amount) || data.amount == 0) {
            $('#contra-transfer-amount').addClass('inp_error');
            err++;
        }

        if (isNull(data.paymentContact.code)) {
            $('#contra-transfer-pay-con').addClass('inp_error');
            err++;
        }

        if ($('#contra-transfer-date').val() == '') {
           $('#contra-transfer-date').addClass('inp_error');
           err++;
        }

        if (isNull(data.vendorContact.code)) {
            $('#contra-transfer-ven-con').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#contra-transfer-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#contra-transfer-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#contra-transfer-action-state').show();
            return false;
        } else {
            $('#contra-transfer-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#contra-transfer-action-state').html('');
            $('#contra-transfer-action-state').hide();
        }
        
        if (data.amount <= 0) {
            $('#contra-transfer-amount').addClass('inp_error');
            $('#contra-transfer-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#contra-transfer-action-state').html('Please enter a valid Amount !!');
            $('#contra-transfer-action-state').show();
            return false;
        }
        
        $('#contra-transfer-action-state').removeClass('alert-success, alert-danger, hide');
        $('#contra-transfer-action-state').html(loading_popup).show();
        $('#contra-transfer-button').addClass('hide');

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'payment/update-contra-transfer',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#contra-transfer-action-state').removeClass('alert-danger');
                    $('#contra-transfer-action-state').addClass('alert-success');
                    $('#contra-transfer-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        closeContraTransferDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#contra-transfer-action-state').addClass('alert-danger');
                    $('#contra-transfer-action-state').html(response.errorDesc);
                    $('#contra-transfer-button').removeClass('hide');
                }
            }
        });
    }

    function updateContraStatus(code, status) {

        if (status == 'PAID') {
            var txt = 'approve';
        } else if(status == 'REJ') {
            var txt = 'reject';
        } else {
            var txt = 'acknowledge';
        }

        if (confirm('Are you sure, Do you want to '+txt+' this Contra Transfer?')) {
            if (status == 'PAID' || status == 'REJ') {
                var contraData = _.find(contraInitData || [], o => o.code == code);
            } else {
                var contraData = _.find(contraAckData || [], o => o.code == code);
            }

            var data = {};
            data.code = code;
            data.activeFlag = 1;

            data.paymentStatus = {};
            data.paymentStatus.code = status;
            data.remarks = contraData.remarks;

            $('#contra-ack-action-state').removeClass('alert-success, alert-danger').addClass('hide').html('');
            $('#contra-unpaid-action-state').removeClass('alert-success, alert-danger').addClass('hide').html('');

            var loading_overlay = iosOverlay({
                text: 'Loading',
                icon: 'fa fa-spinner fa-spin'
            });

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'payment/update-contra-transfer-status',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: 'fa fa-check',
                            text: 'Success!'
                        });
                    } else {
                        if (status == 'PAID' || status == 'REJ') {
                            $('#contra-unpaid-action-state').addClass('alert-danger').removeClass('hide');
                            $('#contra-unpaid-action-state').html(response.errorDesc);
                        } else {
                            $('#contra-ack-action-state').addClass('alert-danger').removeClass('hide');
                            $('#contra-ack-action-state').html(response.errorDesc);
                        }
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function () {
                        if (status == 'PAID' || status == 'REJ') {
                            generateInitContraTransfer();
                        } else {
                            generateAckContraTransfer();
                        }
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }
    }
</script>