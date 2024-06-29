<div class="brand_top">
    <h3>Voucher</h3>
    <span class="align-right">
        <a href="#cargo/generate-voucher" class="btn btn-success btn-sm">Generate Voucher</a>
    </span>
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
                                        <li class="active"><a data-toggle="tab" href="#paid">Paid Voucher</a></li>
                                        <li><a data-toggle="tab" href="#ack">Paid, waiting for Ack</a></li>
                                        <li><a data-toggle="tab" href="#unpaid">Unpaid Voucher</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="paid" class="tab-pane fade in active">
                                            <div id="paid-panel">
                                                <form id="paid_form" method="post" name="paid_form" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="paid_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="paid_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="paid_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="paid_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="paid_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="paid_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        {if $action_rights['CGO-VOU-ALL-BRANCH']==1}
                                                        <div class="form-group col-md-2">
                                                            <label for="paid_branch_code">Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="paid_branch_code" name="branchCode" class="form-control" onchange="updatePaidBranchuser(this);">
                                                                    <option value="NA" selected="">All Branches</option>
                                                                    {foreach key=key item=value from=$branches}
                                                                        <option value="{$key}">{$value}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        {/if}
                                                        {if $action_rights['CGO-VOU-ALL-USER']==1}
                                                        <div class="form-group col-md-2">
                                                            <label for="paid_user_code">Branch Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="paid_user_code" name="userCode" class="form-control" >
                                                                    <option value="NA" selected="">All Users</option>
                                                                    {foreach key=branch item=users from=$branchusers}
                                                                        {foreach key=key item=value from=$users}
                                                                            <option  value="{$key}" data-branch="{$branch}">{$value}</option>
                                                                        {/foreach}
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        {/if}
                                                        <div class="form-group col-md-3">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <button type="button" class="btn btn-success" onclick="getPaidVouchers();">Get Paid Voucher</button>&nbsp;
                                                                <button type="button" class="btn btn-default" onclick="clearPaidVouchers();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="paid_action_state"></div>
                                            <div id="paid-voucher-list"></div>
                                        </div>
                                        <div id="ack" class="tab-pane fade">
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="ack_action_state"></div>
                                            <div id="ack-voucher-list"></div>
                                        </div>
                                        <div id="unpaid" class="tab-pane fade">
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="unpaid_action_state"></div>
                                            <div id="unpaid-voucher-list"></div>
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

<div id="cargo-voucher-pdf-dialog" class="hide">
    <a href="javascript:;" class="pull-right" onclick="closeVoucherPdfDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div id="cargo-voucher-iframe" style="height:90%;width:100%;">
        <div class="alert"></div>
        <iframe src="" style="height:99%;width:100%;border:0px;"></iframe>
    </div>
</div>

<div id="make-payment" class="hide">
    <form role="form" class="form-horizontal">
        <br>
        <div class="col-lg-12 p_l_n p_r_n text-right">
            <label for="pay_voucher_amount">Balance Amount - Rs.<span id="pay_voucher_balanceamt"></span></label>
        </div>
        <br>
        <div class="col-lg-12 p_l_n p_r_n">
            <label for="pay_voucher_amount" class="req">Amount Received</label>
            <div class="input-group">
                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                <input type="text" class="form-control" id="pay_voucher_amount" maxlength="6">
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br/>
        <div class="col-lg-12 p_l_n p_r_n">
            <label for="pay_voucher_tmode" class="req">Transaction Mode</label>
            <select id="pay_voucher_tmode" class="form-control col-md-6">
                <option value="">Select</option>
                {foreach key=key item=value from=$transactionMode}
                    <option value="{$key}">{$value}</option>
                {/foreach}
            </select>
        </div>
        <div class="clear_fix_both"></div>
        <br/>
        <div class="col-lg-12 p_l_n p_r_n">
            <label for="pay_voucher_remarks">Remarks</label>
            <textarea id="pay_voucher_remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" maxlength="200"></textarea>
        </div>
        <div class="clear_fix_both"></div>
    </form>
    <br/>
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="make_pay_action_state"></div>
        <div class="align-right" id="form-bttons">
            <input type="hidden" id="hid_voucher_code"/>
            <button class="btn btn-success" type="button" id="confirm-pay" onclick="confirmPayment();">Pay</button>
            <button class="btn btn-default" type="button" onclick="closePayment();">Cancel</button>
        </div>
    </div>
</div>

<div id="unpaid-info-dialog" class="hide">
    <a href="javascript:;" class="pull-right" onclick="closeUnpaidPartialInfo();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div class="table-responsive">
        <table class="table table-bordered">
            <thead>
                <tr class="bold hover-background">
                    <th align="center">Transaction Date</th>
                    <th align="center">Transaction Mode</th>
                    <th align="center">User</th>
                    <th align="center" width="25%">Remarks</th>
                    <th align="center">Received Date</th>
                    <th align="center">Paid Amount</th>
                </tr>
            </thead>
            <tbody class="body_table" id="parial-info-body">
            </tbody>
        </table>
    </div>
</div>

<div id="paid-info-dialog" class="hide">
    <a href="javascript:;" class="pull-right" onclick="closePaidPartialInfo();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div class="table-responsive">
        <div class="alert" id="paid-info-loading"></div>
        <table class="table table-bordered hide" id="paid-info-table">
            <thead>
                <tr class="bold hover-background">
                    <th align="center">Transaction Date</th>
                    <th align="center">Transaction Mode</th>
                    <th align="center">User</th>
                    <th align="center" width="25%">Remarks</th>
                    <th align="center">Received Date</th>
                    <th align="center">Paid Amount</th>
                </tr>
            </thead>
            <tbody class="body_table" id="paid-info-body">
            </tbody>
        </table>
    </div>
</div>

<script>
    $('#paid_from').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        endDate: '+1D',
        changeMonth: true
    }).on('changeDate', function (e) {
        $('#paid_to').datepicker('setStartDate', e.date);
    });
    $('#paid_to').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        endDate: '+1D',
        autoclose: true
    }).on('changeDate', function (e) {
        $('#paid_from').datepicker('setEndDate', e.date);
    });

    $('a[href="#ack"]').on('show.bs.tab', function (e) {
        getAckVouchers();
        //$(this).off('show.bs.tab');
    });

    $('a[href="#unpaid"]').on('show.bs.tab', function (e) {
        getUnpaidVouchers();
        //$(this).off('show.bs.tab');
    });

    function updatePaidBranchuser(ele) {
        var branch = $(ele).val();

        if (branch == 'NA') {
            $('#paid_user_code option').attr('selected', false).show();
        } else {
            $('#paid_user_code option').each(function () {
                $(this).attr('selected', false);
                if ($(this).data('branch') == branch) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        $('#paid_user_code option[value="NA"]').attr('selected', true).show();
    }

    function updateUnpaidBranchuser(ele) {
        var branch = $(ele).val();

        if (branch == 'NA') {
            $('#unpaid_user_code option').attr('selected', false).show();
        } else {
            $('#unpaid_user_code option').each(function () {
                $(this).attr('selected', false);
                if ($(this).data('branch') == branch) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        $('#unpaid_user_code option[value="NA"]').attr('selected', true).show();
    }

    function getPaidVouchers() {
        var data = {};
        data.fromDate = $('#paid_from').val();
        data.toDate = $('#paid_to').val();
        data.userCode = $('#paid_user_code').val();
        data.organizationCode = $('#paid_branch_code').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if (data.fromDate == '' && data.toDate == '') {
            $('#paid_from, #paid_to').addClass('inp_error');
            err++;
        }

        if (data.fromDate != '' && data.toDate == '') {
            $('#paid_to').datepicker('setDate', Date());
            data.toDate = $('#paid_to').val();
        }

        if (err > 0) {
            $('#paid_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#paid_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#paid_action_state').show();
            return false;
        } else {
            $('#paid_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#paid_action_state').html('');
            $('#paid_action_state').hide();
        }

        $('#paid-list-container').removeClass('hidden');
        $('#paid-voucher-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/paid-vouchers',
            data: data,
            success: function (response) {
                $('#paid-voucher-list').html(response);
            }
        });
    }

    function clearPaidVouchers() {
        $('#paid-panel .inp_error').removeClass('inp_error');
        $('#paid_from').val('');
        $('#paid_to').val('');
        $('#paid_branch_code').val('NA');
        $('#paid_user_code').val('NA');
        $('#paid-voucher-list').html('');
        $('#paid-voucher-list-container').addClass('hidden');
        $('#paid_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#paid_action_state').html('').hide();
    }

    function getUnpaidVouchers() {
        var data = {};
        data.userCode = $('#unpaid_user_code').val();
        data.organizationCode = $('#unpaid_branch_code').val();

        $('#unpaid-list-container').removeClass('hidden');
        $('#unpaid-voucher-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/unpaid-vouchers',
            data: data,
            success: function (response) {
                $('#unpaid-voucher-list').html(response);
            }
        });
    }

    function getAckVouchers() {
        var data = {};
        data.userCode = $('#unpaid_user_code').val();
        data.organizationCode = $('#unpaid_branch_code').val();

        $('#ack-list-container').removeClass('hidden');
        $('#ack-voucher-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/acknowledge-vouchers',
            data: data,
            success: function (response) {
                $('#ack-voucher-list').html(response);
            }
        });
    }

    function rejectVoucher(code) {
        if (confirm('Are you sure, Do you want to reject this Voucher?')) {
            var data = {};
            data.code = code;
            var loading_overlay = iosOverlay({
                text: 'Loading',
                icon: 'fa fa-spinner fa-spin'
            });
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/reject-voucher',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#vou_' + code).animate({
                            backgroundColor: '#1AA1E1'
                        }, 2000, function () {
                            $(this).remove();
                        });

                        loading_overlay.update({
                            icon: 'fa fa-check',
                            text: 'Success!'
                        });
                    }
                    window.setTimeout(function () {
                        getUnpaidVouchers();
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }
    }

    function showVoucherPdfDialog(code) {
        $('#cargo-voucher-pdf-dialog iframe').attr('src', 'about:blank').contents().find('body').html('');
        $('#cargo-voucher-pdf-dialog iframe').attr('src', base_url + 'cargo/voucher-partial-transactions?paymentCode=' + code);

        $('#cargo-voucher-pdf-dialog').css('background', '#fff');
        $('#cargo-voucher-pdf-dialog').removeClass('hide');
        $('#cargo-voucher-pdf-dialog').dialog({
            autoOpen: true,
            height: 700,
            width: 1100,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
    }

    function closeVoucherPdfDialog() {
        $('#cargo-voucher-pdf-dialog').dialog('close');
    }

    function makePaymentDialog(code, mode, balance) {
        $('#make_pay_action_state').hide();
        $('#make-payment .inp_error').removeClass('inp_error');
        $('#pay_voucher_amount').val(parseFloat(balance).toFixed(2));
        $('#pay_voucher_tmode').val(mode);
        $('#pay_voucher_remarks').val('');
        $('#make-payment').css('background', '#fff');
        $('#make-payment').removeClass('hide');
        $('#make-payment').dialog({
            autoOpen: true,
            height: 475,
            width: 450,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
        $('#hid_voucher_code').val(code);
        $('#pay_voucher_balanceamt').text(parseFloat(balance).toFixed(2));
    }

    function confirmPayment() {
        if (confirm('Are you sure, Do you want to pay this Voucher?')) {
            var data = {};
            data.code = $('#hid_voucher_code').val();
            data.transactionAmount = $.trim($('#pay_voucher_amount').val());
            data.remarks = $('#pay_voucher_remarks').val();
            data.transactionMode = $('#pay_voucher_tmode').val();

            var err = 0;
            $('#make-payment .inp_error').removeClass('inp_error');

            if (data.transactionAmount == '' || isNaN(data.transactionAmount)) {
                $('#pay_voucher_amount').addClass('inp_error');
                err++;
            }
            if (data.transactionMode == '') {
                $('#pay_voucher_tmode').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#make_pay_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#make_pay_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#make_pay_action_state').show();
                return false;
            }

            $('#make_pay_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#make_pay_action_state').html(loading_popup).show();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/make-voucher-payment',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#make_pay_action_state').addClass('alert-success');
                        $('#make_pay_action_state').html('Your request has been completed successfully');
                        window.setTimeout(function () {
                            closePayment();
                            getAckVouchers();
                        }, 3000);
                    } else {
                        $('#make_pay_action_state').addClass('alert-danger');
                        $('#make_pay_action_state').html(response.errorDesc);
                    }
                }
            });
        }
    }

    function closePayment() {
        $('#make-payment').dialog('close');
    }

    function showPaidPartialInfo(code) {
        var data = {};
        data.paymentTransactionCode = code;

        $('#paid-info-loading').html(loading_popup).removeClass('hide alert-danger');
        $('#paid-info-table').addClass('hide');

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/voucher-partial-details',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#paid-info-loading').addClass('hide');
                    $('#paid-info-table').removeClass('hide');
                    $('#paid-info-body').html('');
                    var total = 0;
                    if(response.data.partialPaymentList.length == 0) {
                        response.data.partialPaymentList.push(response.data);
                    }
                    $.each(response.data.partialPaymentList, function (i, val) {
                        if (!val.remarks) {
                            val.remarks = '-';
                        }
                        $('#paid-info-body').append('<tr>' +
                                '<td>' + moment(val.transactionDate).format('DD-MM-YYYY hh:mm A') + '</td>' +
                                '<td>' + val.transactionMode.name + '</td>' +
                                '<td>' + val.user.name + '</td>' +
                                '<td>' + val.remarks + '</td>' +
                                '<td>' + moment(val.amountReceivedDate).format('DD-MM-YYYY') + '</td>' +
                                '<td align="right">' + val.transactionAmount.toFixed(2) + '</td>' +
                                '</tr>');
                        total += val.transactionAmount;
                    });
                    $('#paid-info-body').append('<tr class="bold">' +
                            '<td colspan="5" align="right">Total:</td>' +
                            '<td align="right">' + total.toFixed(2) + '</td>' +
                            '</tr>');
                } else {
                    $('#paid-info-loading').addClass('alert-danger').html(response.errorDesc);
                }
            }
        });

        $('#paid-info-dialog').css('background', '#fff');
        $('#paid-info-dialog').removeClass('hide');
        $('#paid-info-dialog').dialog({
            autoOpen: true,
            height: 475,
            width: 750,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
    }

    function closePaidPartialInfo() {
        $('#paid-info-dialog').dialog('close');
    }

    function closeUnpaidPartialInfo() {
        $('#unpaid-info-dialog').dialog('close');
    }

    function showUnpaidPartialInfo(obj) {
        obj = JSON.parse(obj);
        $('#parial-info-body').html('');
        var total = 0;
        $.each(obj, function (i, val) {
            if (!val.remarks) {
                val.remarks = '-';
            }
            if (val.acknowledgeStatus.code == 'PAPAID') {
                $('#parial-info-body').append('<tr>' +
                        '<td>' + moment(val.transactionDate).format('DD-MM-YYYY hh:mm A') + '</td>' +
                        '<td>' + val.transactionMode.name + '</td>' +
                        '<td>' + val.user.name + '</td>' +
                        '<td>' + val.remarks + '</td>' +
                        '<td>' + moment(val.amountReceivedDate).format('DD-MM-YYYY') + '</td>' +
                        '<td align="right">' + val.transactionAmount.toFixed(2) + '</td>' +
                        '</tr>');
                total += val.transactionAmount;
            }
        });
        $('#parial-info-body').append('<tr class="bold">' +
                '<td colspan="5" align="right">Total:</td>' +
                '<td align="right">' + total.toFixed(2) + '</td>' +
                '</tr>');

        $('#unpaid-info-dialog').css('background', '#fff');
        $('#unpaid-info-dialog').removeClass('hide');
        $('#unpaid-info-dialog').dialog({
            autoOpen: true,
            height: 475,
            width: 750,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
    }
</script>