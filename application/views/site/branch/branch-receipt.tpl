<div class="brand_top">
    <h3>Branch Receipt</h3>
    <div class="text-right noprint">
        {* {if $action_rights['PYRCT-ADD']>0} *}
            <a href="#branch/day-closing" class="btn btn-success">Day Closing</a>
        {* {/if} *}
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
                                        <div id="search-panel" class="noprint">
                                            <form id="branch_receipt_form" name="branch_receipt_form" method="post" action="branch/branch-receipt-report-list" onsubmit="return false;">
                                                <div class="row">

                                                    <div class="form-group col-md-2">
                                                        <label for="branch_receipt_Stats">Status</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="branch_receipt_Stats" name="paymentStatusCode" class="form-control">
                                                                <option value="INITD" selected="">Initiated</option>
                                                                <option value="ACKED">Acknowledge</option>
                                                                <option value="RJECT">Reject</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-3 hide noprint" id="date_range">
                                                        <label for="branch_receipt_daterange">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="dateRanges" class="form-control sdate noprint" id="branch_receipt_daterange" readonly placeholder="Date Range">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-2 w-auto">
                                                        <div>
                                                            <label for="receipt-user">&nbsp;</label>
                                                            <span class="radio d-inline-block">
                                                                <label><input type="radio" name="payment_receipt_to" value="BRANCH" checked> Branch</label>
                                                            </span>&nbsp;
                                                            <span class="radio d-inline-block">
                                                                <label><input type="radio" name="payment_receipt_to" value="USER"> User</label>
                                                            </span>&nbsp;
                                                            {if $action_rights['DAY-CLO-ALL-BRCH'] == 1 && count($tags)}
                                                                <span class="radio d-inline-block">
                                                                    <label><input type="radio" name="payment_receipt_to" value="TAG"> Tag</label>
                                                                </span>
                                                            {/if}
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-2 cont" style="display: none;">
                                                        <div class="form-group">
                                                            <label for="branch_receipt_organization">Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="branch_receipt_organization" class="form-control">
                                                                    {if $action_rights['DAY-CLO-ALL-BRCH'] == 1}
                                                                        <option value="NA">All Branch</option>
                                                                        {foreach item=row from=$branches}
                                                                            <option value="{$row->code}">{$row->name}</option>
                                                                        {/foreach}
                                                                    {else}
                                                                        <option value="{$login_branch}">{$login_branch_name}</option>
                                                                    {/if}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-3 cont" style="display: none;">
                                                        <div class="form-group">
                                                            <label for="branch_receipt_user">Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="branch_receipt_user" class="form-control">
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
                                                    </div>

                                                    <div class="col-lg-2 cont" style="display: none;">
                                                        <div class="form-group">
                                                            <label for="branch_receipt_tag">Tag</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="branch_receipt_tag" class="form-control">
                                                                    <option value="">Select Tag</option>
                                                                    {foreach item=row from=$tags}
                                                                        <option value="{$row->branches|implode:','}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <input type="hidden" name="print" id="print" value="1">
                                                            <input type="hidden" name="userCode" id="hid-user-code" value="">
                                                            <input type="hidden" name="organizationCode" id="hid-org-code" value="">
                                                            <input type="hidden" name="tagCode" id="hid-tag-code" value="">
                                                            <input type="hidden" name="paymentAcknowledgeStatus" id="brn_pay_status">
                                                            <input type="hidden" name="dateRange" class="form-control sdate" id="branch_receipt_excel_date" readonly="true">
                                                            <button class="btn btn-success" type="button" onclick="searchBranchReceipt()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearBranchReceipt()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="branch_receipt_state"></div>
                                            </form>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="branch-receipt-list-container">
                    <br>
                    {* <div class="col-lg-12">

                    </div> *}
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="branch-receipt-list"></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_branch_receipt" id="ifrm_branch_receipt" style="display:none"></iframe>

<div id="cargo-voucher-pdf-dialog" class="hide">
    <a href="javascript:;" class="pull-right" onclick="closeVoucherPdfDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div id="cargo-voucher-iframe" style="height:90%;width:100%;">
        <div class="alert"></div>
        <iframe src="" style="height:99%;width:100%;border:0px;"></iframe>
    </div>
</div>

<div id="unpaid-info-dialog" class="hide noprint">
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

<div id="receipt-activity-dialog" class="hide">
    <a href="javascript:;" class="pull-right" onclick="hideReceiptActivity();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div id="receipt-activity-list"><br />
        <div class="vertical-container dark-timeline" id="receipt-activity-timeline">
        </div>
    </div>
</div>

<script type="text/template" id="receipt-activity-tpl">
    <div class="vertical-timeline-block">
        <div class="vertical-timeline-icon btn-success">
            <i class="fa fa-history"></i>
        </div>

        <div class="vertical-timeline-content">
            <div class="bold event"></div>
            <p>
                By : <span class="user"></span>, 
                At : <span class="updated"></span>, 
            </p>                            
        </div>
    </div>
</script>

<div id="receipt-make-payment" class="hide noprint">
    <form role="form" class="form-horizontal">
        <br>
        <div class="col-lg-12 p_l_n p_r_n">
            {* <label for="pay_receipt_remarks">Remarks</label>
            <textarea id="pay_receipt_remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" maxlength="120"></textarea> *}
            <label for="pay_receipt_remarks">Do you want to change the status of this receipt?</label>
        </div>
        <div class="col-lg-12 cont">
            <div class="row">
                <div class="col-lg-5 cont">
                    <div class="form-group">
                        <br>
                        <label for="Payable_amount"> Payable Amount </label><i class="fa fa-rupee"></i>
                        <span id='Payable_amount'></span>
                    </div>
                </div>
                <div class="col-lg-1"></div>
                <div class="col-lg-6 cont">
                    <div class="form-group">
                        <label for="pay_receipt_amount" class="req">Amount Received</label>
                        <div class="input-group">
                            <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                            <input type="text" class="form-control" id="pay_receipt_amount" maxlength="10" placeholder="Amount Received">
                        </div>
                        <label>Diff Amt : <span id="remainingBalance" class="text-danger">0</span></label>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="form-group">
                <label for="pay_receipt_remarks">Remarks</label>
                <textarea id="pay_receipt_remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" maxlength="120"></textarea>
            </div>
        </div>
        <div class="clear_fix_both"></div>
    </form>
    <br />
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="receipt_pay_action_state"></div>
        <div class="align-right">
            <input type="hidden" id="hid_receipt_code" />
            <input type="hidden" id="hid_receipt_status" />
            <input type="hidden" id="hid_payable_amount" />
            <button class="btn btn-success" type="button" id="confirm-pay" onclick="confirmReceiptStatus();">Confirm</button>
            <button class="btn btn-default" type="button" onclick="cancelReceiptStatusDialog();">Cancel</button>
        </div>
    </div>
</div>

<div id="dayclosing-openingbalance-dialog" class="hide">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="closeOpeningBalancedetails();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div class="">
        <div class="col-lg-12 p_l_n">
            <div class="table-responsive" id="dayclosing-openingbalance-list"></div>
        </div>
    </div>
</div>

<style>
    @media print {

        .daterangepicker,
        .dropdown-menu,
        .opensright,
        .form-control,
        .sdate {
            display: none;
        }
    }
</style>

<script>
    var dayCloseOrganizationCode = {$dayCloseOrganizationCode|json_encode};
</script>
{literal}
    <script>
        $('[data-toggle="tooltip"]').tooltip();
        $('#branch_receipt_user, #branch_receipt_organization, #branch_receipt_tag').select2();

        $('[name="payment_receipt_to"]').on('change', function() {
            var receiptto = $('[name="payment_receipt_to"]:checked').val();
            $('#branch_receipt_organization, #branch_receipt_user, #branch_receipt_tag').closest('.cont').hide();
            if (receiptto == 'BRANCH') {
                $('#branch_receipt_organization').closest('.cont').show();
            } else if (receiptto === 'USER') {
                $('#branch_receipt_user').closest('.cont').show();
            } else if (receiptto === 'TAG') {
                $('#branch_receipt_tag').closest('.cont').show();
            }
        }).trigger('change');

        $('#branch_receipt_tabs').on('shown.bs.tab', function(e) {
            var tabId = $(e.target).attr('href')
            //if ($(tabId).is(':empty')) {
            if (tabId == '#tab_waiting_payment') {
                $('#tab_waiting_payment').removeClass('noprint');
                $('#tab_acknowledged, #tab_all_transaction').html('').addClass('noprint');
            } else if (tabId == '#tab_all_transaction') {
                $('#tab_all_transaction').removeClass('noprint');
                $('#tab_waiting_payment, #tab_acknowledged').html('').addClass('noprint');
            } else {
                $('#tab_acknowledged').removeClass('noprint');
                $('#tab_waiting_payment, #tab_all_transaction').html('').addClass('noprint');
            }

            searchBranchReceipt();
            //}
        });

        $('#receipt-received').datepicker({
            todayHighlight: true,
            startDate: '-3m',
            endDate: '0d',
            format: 'yyyy-mm-dd',
            autoclose: true
        });

        $('#branch_receipt_daterange').daterangepicker({
            buttonClasses: ['btn', 'btn-xs'],
            format: 'DD-MM-YYYY',
            separator: ' | ',
            ranges: {
                'Today': [moment(), moment()],
                'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                // 'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                // 'Last 3 Months': [moment().subtract(3, 'months'), moment()],
            },
        }).on('show.daterangepicker', function(ev, picker) {
            picker.showCalendars()
        });

        var picker = $('#branch_receipt_daterange').data('daterangepicker');
        picker.setStartDate(moment().subtract(1, 'month'))
        picker.setEndDate(moment())
        picker.updateInputText();

        if (isNotNull(dayCloseOrganizationCode)) {
            picker.setStartDate(moment().subtract(3, 'month'))
            picker.setEndDate(moment())
            picker.updateInputText();
            $('#branch_receipt_organization').val(dayCloseOrganizationCode).trigger('change');
            $('#branch_receipt_tabs [href="#tab_waiting_payment"]').tab('show')
            searchBranchReceipt();
        }

        $('#branch_receipt_Stats').on('change', function(e) {
            var optionSelected = $("option:selected", this);
            var valueSelected = this.value;
            if (valueSelected == "ACKED" || valueSelected == 'RJECT') {
                $('#date_range').removeClass('hide');
            } else {
                $('#date_range').addClass('hide');
            }
        });

        function searchBranchReceipt() {
            $('#branch-receipt-list').html('');
            var data = {};
            data.paymentAcknowledgeStatus = $('#branch_receipt_Stats').val();
            data.dateRange = $('#branch_receipt_daterange').val();
            var err = 0;

            $('.inp_error').removeClass('inp_error');
            var receiptto = $('[name="payment_receipt_to"]:checked').val();
            if (receiptto === 'BRANCH') {
                data.userCode = 'NA';
                data.organizationCode = $('#branch_receipt_organization').val();
            } else if (receiptto === 'USER') {
                data.userCode = $('#branch_receipt_user').val();
                data.organizationCode = 'NA';
            } else if (receiptto === 'TAG') {
                data.userCode = 'NA';
                data.tagCode = $('#branch_receipt_tag').val();

                if (data.tagCode == '') {
                    $('#branch_receipt_tag').addClass('inp_error');
                    err++;
                }
            }

            // if (data.dateRange == '') {
            //     $('#branch_receipt_daterange').addClass('inp_error');
            //     err++;
            // }

            if (err > 0) {
                $('#branch_receipt_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#branch_receipt_state').html('Please enter/select the values in the field that are marked in red');
                $('#branch_receipt_state').show();
                return false;
            } else {
                $('#branch_receipt_state').removeClass('alert-success').removeClass('alert-danger');
                $('#branch_receipt_state').html('');
                $('#branch_receipt_state').hide();
            }
            $('#branch-receipt-list-container').removeClass('hidden');
            $('#branch-receipt-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "branch/branch-receipt-report-list",
                data: data,
                success: function(response) {
                    $('#branch-receipt-list').html(response);
                    $('#export-branch-receipt').show();
                }
            });
        }

        function clearBranchReceipt() {
            $('#branch_receipt_daterange').data('daterangepicker').setStartDate({});
            $('#branch_receipt_daterange').data('daterangepicker').setEndDate({});
            $('#branch_receipt_user').val('NA').trigger('change');
            $('#branch_receipt_organization').val('NA').trigger('change');
            $('#branch_receipt_tag').val('').trigger('change');
            $('#branch-receipt-list-container').addClass('hidden');
            $('#branch-receipt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#branch_receipt_state').removeClass('alert-success').removeClass('alert-danger');
            $('#branch_receipt_state').html('');
            $('#branch_receipt_state').hide();
            $('#export-branch-receipt').hide();
        }

        function exportBranchReceipt() {
            document.branch_receipt_form.action = "cargo/branch-receipt-report-list";
            document.branch_receipt_form.target = "ifrm_branch_receipt";
            document.branch_receipt_form.submit();
            return;
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

        function showUnpaidPartialInfo(obj) {
            obj = JSON.parse(obj);
            $('#parial-info-body').html('');
            var total = 0;
            $.each(obj, function(i, val) {
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

        function closeUnpaidPartialInfo() {
            $('#unpaid-info-dialog').dialog('close');
        }

        function clearPaymentTabs() {
            $('[data-tabstatus]').html('');
        }

        function receiptStatusDialog(code, status) {
            clearPaymentTabs();
            $('#different_amounts').html('Differnce Amount -');
            $('#hid_receipt_code').val(code);
            $('#hid_receipt_status').val(status);
            $('#pay_receipt_remarks').val('');

            $('.inp_error').removeClass('inp_error');
            $('#receipt_pay_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#receipt_pay_action_state').html('').hide();

            var receipt = _.find(paymentReceiptData, o => o.code == code);
            if (!receipt) {
                return;
            }

            var paidAmount = parseFloat(receipt.paidAmount).toFixed(2)
            // $('#pay_receipt_amount').replace(/[^0-9]/g, '');
            $('#pay_receipt_amount').on('input', function() {
                $(this).val($(this).val().replace(/[^0-9]/g, ''));
            });
            $('#Payable_amount').text(numberWithCommas(paidAmount));
            $('#hid_payable_amount').val(numberWithCommas(paidAmount));
            $('#pay_receipt_amount').on('input', function() {
                var user_amount = $(this).val();
                var total_payable_amount = paidAmount;
                // Calculate remaining balance
                var remainingBalance = total_payable_amount - user_amount;
                $('#remainingBalance').html(numberWithCommas(remainingBalance.toFixed(2)));
            });

            $('#pay_receipt_amount').closest('.cont').toggleClass('hide', status == 'RJECT');
            $('#payable_amount').html("Payable Amount :" + paidAmount);
            $('#receipt-make-payment').css('background', '#fff');
            $('#receipt-make-payment').removeClass('hide');
            $('#receipt-make-payment').dialog({
                autoOpen: true,
                height: 450,
                width: 650,
                modal: true,
                resizable: false,
                closeOnEscape: false
            });
            $('.ui-dialog-titlebar').hide();
            $('#pay_receipt_amount').val(paidAmount);
        }

        function cancelReceiptStatusDialog() {
            $('#confirm-pay').attr('disabled', false);
            $('#receipt-make-payment').dialog('destroy');
            $('#receipt-make-payment').hide();
            $('#remainingBalance').html('');
        }

        function confirmReceiptStatus() {
            var receiptCode = $('#hid_receipt_code').val();
            var paymentAcknowledgeStatus = $('#hid_receipt_status').val();
            var receiptData = _.find(paymentReceiptData || [], o => o.code == receiptCode) || {};

            var data = {};
            var err = 0;
            data.code = receiptData.code
            data.organizationReceiptDetails = [];
            $.each(receiptData.organizationReceiptDetails || [], function(i, row) {
                var receipt = {};
                receipt.code = row.code;
                receipt.paymentAcknowledge = {};
                receipt.paymentAcknowledge.code = paymentAcknowledgeStatus;

                data.organizationReceiptDetails.push(receipt);
            });

            var inputValue = $.trim($('#pay_receipt_amount').val());
            var floatValue = parseFloat(inputValue.replace(',', '')); // Convert string to float
            var roundedValue = Math.ceil(floatValue); // Round up to nearest integer
            data.paidAmount = roundedValue;
            data.remarks = $.trim($('#pay_receipt_remarks').val());

            var PayableAmt = $('#hid_payable_amount').val();
            var floatValue_payy = parseFloat(PayableAmt.replace(',', '')); // Convert
            var roundedValue_pay = Math.ceil(floatValue_payy); // Round up to nearest integer
       
            if (data.paidAmount > roundedValue_pay) {
                $('#pay_receipt_amount').addClass('inp_error');
                err++;
            } else if (data.paidAmount < 0) {
                $('#pay_receipt_amount').addClass('inp_error');
                err++;
            }  else {
                $('#pay_receipt_amount').removeClass('inp_error');
            }

            if (data.remarks == '') {
                $('#pay_receipt_remarks').addClass('inp_error');
                err++;
            }

        
            if (err > 0) {
                $('#receipt_pay_action_state').removeClass('alert-success').addClass('alert-danger');
                $('#receipt_pay_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#receipt_pay_action_state').show();
                return false;
            } else {
                $('#receipt_pay_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#receipt_pay_action_state').hide();
            }

            $('#receipt_pay_action_state').removeClass('alert-danger').removeClass('alert-success');
            $('#receipt_pay_action_state').html(loading_popup);
            $('#receipt_pay_action_state').show();
            $('#confirm-pay').attr('disabled', true);

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "branch/update-branch-receipt-status",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $('#form-bttons').hide();
                        $('#receipt_pay_action_state').removeClass('alert-danger');
                        $('#receipt_pay_action_state').addClass('alert-success');
                        $('#receipt_pay_action_state').html('Your request has been completed successfully');
                        window.setTimeout(function() {
                            clearPaymentTabs();
                            cancelReceiptStatusDialog();
                            searchBranchReceipt();

                        }, 3000);
                    } else {
                        $('#receipt_pay_action_state').addClass('alert-danger');
                        $('#receipt_pay_action_state').html(response.errorDesc);
                        $('#confirm-pay').attr('disabled', false);
                    }
                }
            })
        }

        function showReceiptActivity(code) {
            var receipt = _.find(BranchReceiptData, i => i.code == code);

            if (!receipt) {
                return;
            }

            var $tpl = $($('#receipt-activity-tpl').html());
            var $list = $('#receipt-activity-timeline').html('');

            $.each(receipt.auditLog || [], function(i, log) {
                var $row = $tpl.clone()
                $row.find('.event').html(log.event);
                $row.find('.user').html(log.user && log.user.name);
                $row.find('.updated').html(moment(log.updatedAt).format('DD-MM-YYYY hh:mm A'));

                $list.append($row);
            });

            if (!receipt.auditLog.length) {
                $list.html('<br><br><div class="text-center bold">Sorry! No history available.</div>');
            }

            $('#receipt-activity-dialog').css('background', '#fff');
            $('#receipt-activity-dialog').removeClass('hide');
            $('#receipt-activity-dialog').dialog({
                autoOpen: true,
                height: 500,
                width: 600,
                modal: true,
                resizable: false,
                closeOnEscape: false
            });
            $('.ui-dialog-titlebar').hide();
        }

        function hideReceiptActivity() {
            $('#receipt-activity-dialog').dialog('close');
        }

        function exportBranchReceiptExcel() {
            document.branch_receipt_form.target = "ifrm_branch_receipt";
            $('#export').val(1);
            $('#print').val('');
            $("#brn_pay_status").val($('#branch_receipt_Stats').val());

            if ($('#branch_receipt_Stats').val() == "ACKED" || $('#branch_receipt_Stats').val() == 'RJECT') {
                $('#branch_receipt_excel_date').val($('#branch_receipt_daterange').val());
            } else {
                $('#branch_receipt_excel_date').val('null');
            }

            var receiptto = $('[name="payment_receipt_to"]:checked').val();

            if (receiptto === 'BRANCH') {
                $('#hid-user-code').val('NA');
                $('#hid-org-code').val($('#branch_receipt_organization').val());
                $('#hid-tag-code').val('');
            } else if (receiptto === 'USER') {
                $('#hid-user-code').val($('#branch_receipt_user').val());
                $('#hid-org-code').val('NA');
                $('#hid-tag-code').val('');
            } else if (receiptto === 'TAG') {
                $('#hid-user-code').val('NA');
                $('#hid-org-code').val('NA');
                $('#hid-tag-code').val($('#branch_receipt_tag').val());
            }

            document.branch_receipt_form.submit();
        }

        function branchReceiptPrint() {
            document.branch_receipt_form.target = "ifrm_branch_receipt";
            $('#print').val(1);
            $('#export').val('');
            $("#brn_pay_status").val($('#branch_receipt_Stats').val());

            if ($('#branch_receipt_Stats').val() == "ACKED" || $('#branch_receipt_Stats').val() == 'RJECT') {
                $('#branch_receipt_excel_date').val($('#branch_receipt_daterange').val());
            } else {
                $('#branch_receipt_excel_date').val('null');
            }

            var receiptto = $('[name="payment_receipt_to"]:checked').val();

            if (receiptto === 'BRANCH') {
                $('#hid-user-code').val('NA');
                $('#hid-org-code').val($('#branch_receipt_organization').val());
                $('#hid-tag-code').val('');
            } else if (receiptto === 'USER') {
                $('#hid-user-code').val($('#branch_receipt_user').val());
                $('#hid-org-code').val('NA');
                $('#hid-tag-code').val('');
            } else if (receiptto === 'TAG') {
                $('#hid-user-code').val('NA');
                $('#hid-org-code').val('NA');
                $('#hid-tag-code').val($('#branch_receipt_tag').val());
            }

            document.branch_receipt_form.submit();
            return;
        }

        function numberWithCommas(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        function showOpeningBalancedetails(receiptDetailsCode, organizationCode, userCode) {
            $('#dayclosing-openingbalance-dialog').css('background', '#fff');
            $('#dayclosing-openingbalance-dialog').removeClass('hide');
            $('#dayclosing-openingbalance-dialog').dialog({
                autoOpen: true,
                height: $(window).height() - 150,
                width: $(window).width() - 200,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();
            $('#dayclosing-openingbalance-list').html(loading_popup);

            var data = {};
            data.receiptDetailsCode = receiptDetailsCode;
            data.organizationCode = organizationCode;
            data.userCode = userCode;

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "branch/get-branch-receipt-openingbalance-details",
                data: data,
                success: function(response) {
                    $('#dayclosing-openingbalance-list').html(response);
                }
            });
        }

        function closeOpeningBalancedetails() {
            $('#dayclosing-openingbalance-dialog').dialog('destroy');
            $('#dayclosing-openingbalance-dialog').hide();
        }
    </script>
{/literal}