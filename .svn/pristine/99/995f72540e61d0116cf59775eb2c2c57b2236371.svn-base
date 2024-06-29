<div class="brand_top">
    <h3>Invoice</h3>
    <span class="align-right">
        <a href="#cargo/balance-sheet" target="_blank" class="btn btn-primary btn-sm">Summary</a>
        <a href="#cargo/vendor-booking-report" target="_blank" class="btn btn-primary btn-sm">RAC Booking Report</a>
        <a href="#cargo/vendor-due-report" target="_blank" class="btn btn-primary btn-sm">RAC Due Report</a>
        {if $cargo_setting->userAccountModel->code == 'DINV'}
            <a href="#cargo/generate-invoice-v2" class="btn btn-success btn-sm">Generate Invoice</a>
        {else}
            <a href="#cargo/generate-invoice" class="btn btn-success btn-sm">Generate Invoice</a>
        {/if}
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
                                        <li class="active"><a data-toggle="tab" href="#paid">Paid Invoice</a></li>
                                        <li><a data-toggle="tab" href="#ack">Paid, waiting for Ack</a></li>
                                        <li><a data-toggle="tab" href="#unpaid">Unpaid Invoice</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="paid" class="tab-pane fade in active">
                                            <div id="paid-panel">
                                                <form id="paid_form" method="post" name="paid_form" onsubmit="return false;">
                                                    <div class="row">
                                                         <div class="form-group col-md-3">
                                                            <label for="paid_date_range">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="paid_date_range" readonly placeholder="Today" value="{implode(' | ', array_filter([$ffromDate|date_format:'%d-%m-%Y', $ftoDate|date_format:'%d-%m-%Y']))}">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="paid_vendor_code">{lang('vendor')}</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="paid_vendor_code" name="vendorCode"  class="form-control">
                                                                    <option value="NA" selected="">All {lang('vendor')}</option>
                                                                    {foreach item=row from=$vendors}
                                                                        <option value="{$row->code}">{$row->companyName}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-3">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <button type="button" class="btn btn-success" onclick="getPaidInvoice();">Get Paid Invoice</button>&nbsp;
                                                                <button type="button" class="btn btn-default" onclick="clearPaidInvoice();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="paid_action_state"></div>
                                            <div id="paid-invoice-list"></div>
                                        </div>
                                        <div id="ack" class="tab-pane fade">
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="ack_action_state"></div>
                                            <div id="ack-invoice-list"></div>
                                        </div>
                                        <div id="unpaid" class="tab-pane fade">
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="unpaid_action_state"></div>
                                            <div id="unpaid-invoice-list"></div>
                                        </div>

                                        <div id="invoice-view-option-select" class="hide dialog-content-page">
                                            <div class="col-md-12">
                                                <div id="search-panel">
                                                    <div>
                                                        <div class="row">
                                                            <div class="col-md-10 bold ft_14">
                                                                <br>
                                                                <span id="invoice_no"></span>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <a class="align-right" onclick="closePoupOption()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row p-y-10">
                                                        <form id="myForm">
                                                            <table width="100%">
                                                                <br>
                                                                <tr>
                                                                    <td width="50%" align="center">
                                                                        <div class="radio">
                                                                            <label><input type="radio" class="myForm" name="print-invoice-radio" value="ALL" checked="checked"> <b>All&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b> </label>
                                                                        </div>&emsp;
                                                                    </td>
                                                                    <td width="50%">
                                                                        <div class="radio">
                                                                            <label><input type="radio" class="myForm" name="print-invoice-radio" value="ORIGINAL"><b>Original</b></label>
                                                                        </div>&emsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width="50%" align="center">
                                                                        <div class="radio">
                                                                            <label><input type="radio" class="myForm" name="print-invoice-radio" value="DUPLICATE"><b>Duplicate</b></label>
                                                                        </div>&emsp;
                                                                    </td>
                                                                    <td width="50%">
                                                                        <div class="radio">
                                                                            <label><input type="radio" name="print-invoice-radio" value="TRIPLICATE"><b>Triplicate</b></label>
                                                                        </div>&emsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width="50%" align="center" colspan="2">
                                                                        <input type="hidden" id="TrsitCode" name="TrsitCode" value="">
                                                                        <button class="btn btn-success print-dis" type="button" onclick="selectPrintInvoice();">Print</button>&nbsp;
                                                                        <button type="button" class="btn btn-default btn-clear" onclick="closePoupOption();">Close</button>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--content end-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="make-payment" class="hide">
    <form role="form">
        <br>
        <div class="col-lg-12 p_l_n p_r_n text-right">
            <label class="h5 bold">Balance Amount - Rs.<span id="pay_invoice_balanceamt"></span></label>
        </div>
        <br>
        <div class="col-lg-6 p_l_n">
            <label for="pay_invoice_amount" class="req">Amount Received</label>
            <div class="input-group">
                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                <input type="text" class="form-control" id="pay_invoice_amount" maxlength="10" placeholder="Amount Received">
            </div>
        </div>
        <div class="col-lg-6 p_l_n p_r_n">
            <label for="pay_invoice_tmode" class="req">Transaction Mode</label>
            <select id="pay_invoice_tmode" class="form-control col-md-6" onchange="setTransactionMode()">
                <option value="">Select</option>
                {foreach key=key item=value from=$transactionMode}
                    <option value="{$key}">{$value}</option>
                {/foreach}
            </select>
        </div>

        <div class="clear_fix_both"></div>
        <br/>

        <div class="hide" id="upi-mode-panel">
            <div class="well well-sm col-md-12">

                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="upi-orgbank">Organization Bank</label>
                            <select class="form-control" id="upi-orgbank">
                                <option value="">Select a Bank</option>
                                {foreach from=$bankdetail item=val}
                                    {if $val->accountType->code != 'CASH'}
                                    <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                    {/if}
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="upi-id">UPI ID</label>
                            <input type="text" class="form-control" id="upi-id" maxlength="250" placeholder="UPI ID" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="upi-details">Ref. #</label>
                            <input type="text" class="form-control" id="upi-details" placeholder="Ref. #" autocomplete="off">
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="hide" id="netbanking-mode-panel">
            <div class="well well-sm col-md-12">

                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="netbanking-orgbank">Organization Bank</label>
                            <select class="form-control" id="netbanking-orgbank">
                                <option value="">Select a Bank</option>
                                {foreach from=$bankdetail item=val}
                                    {if $val->accountType->code != 'CASH'}
                                    <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                    {/if}
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="netbanking-accholder">Account Holder Name</label>
                            <input type="text" class="form-control" id="netbanking-accholder" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="netbanking-bankname">Bank Name</label>
                            <input type="text" class="form-control" id="netbanking-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="netbanking-details">Ref. #</label>
                            <input type="text" class="form-control" id="netbanking-details" placeholder="Ref. #" autocomplete="off">
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="hide" id="cheque-mode-panel">
            <div class="well well-sm col-md-12">

                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="cheque-payer">Payer Details</label>
                            <input type="text" class="form-control" id="cheque-payer" maxlength="250" placeholder="Payer Details" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="cheque-no">Cheque No</label>
                            <input type="text" class="form-control" id="cheque-no" maxlength="60" placeholder="Cheque No" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="cheque-date">Cheque Date</label>
                            <input type="text" class="form-control" id="cheque-date" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="cheque-bankcity">Bank City</label>
                            <input type="text" class="form-control" id="cheque-bankcity" maxlength="90" placeholder="Bank City" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="cheque-bankname">Bank Name</label>
                            <input type="text" class="form-control" id="cheque-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="cheque-remarks">Remarks</label>
                            <input type="text" class="form-control" placeholder="Remarks" id="cheque-remarks" data-mask="englishonly"/>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="col-lg-12 p_l_n">
            <label for="" class=""><b>Tax or Adjustment Amount Deducted ?</b></label>
            {* <div class="input-group">
                <span>
                    <input type="radio" name="optradio" id="tds_amount_radio" class="tds_amount_radio" onchange="toggleTDSAmont(this)" data-type="Receipt" value="NO" checked>&nbsp;&nbsp;No Tax, Adjustment Amount Deducted
                </span> *}
            {* </div>
            <div class="input-group"> *}
                {* &emsp;
                <span>
                    <input type="radio" name="optradio" id="tds_amount_radio" class="tds_amount_radio" onchange="toggleTDSAmont(this)" data-type="Receipt" value="YES">&nbsp;&nbsp;Yes, TDS(Income Tax), Adjustment Amount
                </span>
            </div> *}
        </div>
        {* <div class="clear_fix_both"></div>
        <br/> *}

        <div class="col-lg-5 p_l_n">
            <label for="" class="">TDS Amount</label>
            <div class="row">
                <div class="col-md-4 p_r_n">
                    <select class="form-control" id="tds_tax_percent" onchange="calculateTDSPercent();">
                        <option value="0">Nil</option>
                        <option value="2">2%</option>
                        {* <option value="5">5%</option>
                        <option value="8">8%</option>
                        <option value="10">10%</option> *}
                    </select>
                </div>
                <div class="col-md-8 p_l_n">
                    <input type="number" class="form-control no-spin" id="tds_amount" value="0" onchange="calculateAmountReceived(this)" placeholder="TDS Amount" disabled>
                </div>
            </div>
        </div>
        {if $cargo_setting->userAccountModel->code == 'TXRT'}
            <div class="col-lg-4">
                <label for="discount_type">Discount Type</label>
                <select class="form-control" id="discount_type">
                    <option value="NA" selected>Select</option>
                    {foreach item=category key=k from=$category_contacts}
                        {if in_array('INVADJ', $category->tag)}
                            <optgroup label="{$category->name}">
                                {foreach item=row from=$category->contacts}
                                    <option value="{$row->code}">{$row->name}</option>
                                {/foreach}
                            </optgroup>
                        {/if}
                    {/foreach}
                </select>
            </div>
        {/if}
        <div class="col-lg-3 p_l_n p_r_n">
            <label for="" class="">Adjustment Amount</label>
            <input type="number" class="form-control no-spin" id="adjust_amount" step="any" onchange="calculateAmountReceived(this)" placeholder="Adjustment Amount">
        </div>

        <div class="clear_fix_both"></div>
        <br/>
        <div class="col-lg-12 p_l_n p_r_n">
            <label for="pay_invoice_remarks">Remarks</label>
            <textarea id="pay_invoice_remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" maxlength="200"></textarea>
        </div>
        <div class="clear_fix_both"></div>
    </form>
    <br/>
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="make_pay_action_state"></div>
        <div class="align-right" id="form-bttons">
            <input type="hidden" id="hid_invoice_code"/>
            <input type="hidden" id="invoice-balance-amount"/>
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
                    <th align="center" width="15%">Remarks</th>
                    <th align="center">Received Date</th>
                    <th align="center">Paid Amt (A)</th>
                    <th align="center">TDS Amt (B)</th>
                    <th align="center">Adjustment Amt (C)</th>
                    <th align="center">Total Paid Amt (A+B+C)</th>
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
                    <th align="center">{lang('vendor')}</th>
                    <th align="center" width="15%">Remarks</th>
                    <th align="center">Received Date</th>
                    <th align="center">Paid Amt (A)</th>
                    <th align="center">TDS Amt (B)</th>
                    <th align="center">Adjustment Amt (C)</th>
                    <th align="center">Total Paid Amt (A+B+C)</th>
                </tr>
            </thead>
            <tbody class="body_table" id="paid-info-body">
            </tbody>
        </table>
    </div>
</div>

<script>
    var login_branch_code = {$login_branch|json_encode};
    var bankNamesList = {$bank_names_list|json_encode};
    var cargo_setting = {$cargo_setting|json_encode};

    $('#paid_date_range').daterangepicker({
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

    $('#paid_vendor_code').select2();

    $('a[href="#ack"]').on('show.bs.tab', function (e) {
        getAckInvoices();
        //$(this).off('show.bs.tab');
    });

    $('a[href="#unpaid"]').on('show.bs.tab', function (e) {
        getUnpaidInvoice();
        //$(this).off('show.bs.tab');
    });

    $('#discount_type').select2();
    $('#upi-orgbank').select2();
    $('#netbanking-orgbank').select2();
    $('#netbanking-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#make-payment'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#cheque-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#make-payment'
    }).focus(function(){
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

    $('#pay_invoice_amount').on('input', function() {
        $('#tds_tax_percent').val('0');
        $('#tds_amount').val('').prop('disabled', true);
        $('#adjust_amount').val('');

        var amount = $(this).val();
        $('#invoice-balance-amount').val(amount);
    });

    /* function toggleTDSAmont(ele){
        var tds_opt = $(ele).val();

        if(tds_opt == 'YES'){
            $('#tds-amt').removeClass('hide');
            $('#adj_amt').removeClass('hide');
        }else{
            $('#tds-amt').addClass('hide');
            $('#adj_amt').addClass('hide');
        }
    } */

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

    function getPaidInvoice() {
        var data = {};
        var daterange = $('#paid_date_range').data('daterangepicker');
        data.fromDate = daterange.startDate.format('DD-MM-YYYY');
        data.toDate = daterange.endDate.format('DD-MM-YYYY');
        data.vendorCode = $('#paid_vendor_code').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');

       
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
        $('#paid-invoice-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/paid-invoices',
            data: data,
            success: function (response) {
                $('#paid-invoice-list').html(response);
            }
        });
    }

    function clearPaidInvoice() {
        $('#paid-panel .inp_error').removeClass('inp_error');
        $('#paid_date_range').val('');
        $('#paid_date_range').data('daterangepicker').setStartDate({});
        $('#paid_date_range').data('daterangepicker').setEndDate({});
        $('#paid_vendor_code').val('NA').trigger('change');
        $('#paid-invoice-list').html('');
        $('#paid-invoice-list-container').addClass('hidden');
        $('#paid_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#paid_action_state').html('').hide();
    }

    function getUnpaidInvoice() {
        var data = {};
        $('#unpaid-list-container').removeClass('hidden');
        $('#unpaid-invoice-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/unpaid-invoices',
            data: data,
            success: function (response) {
                $('#unpaid-invoice-list').html(response);
            }
        });
    }

    function getAckInvoices() {
        var data = {};
        data.userCode = $('#unpaid_user_code').val();
        data.organizationCode = $('#unpaid_branch_code').val();

        $('#ack-list-container').removeClass('hidden');
        $('#ack-invoice-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/acknowledge-invoices',
            data: data,
            success: function (response) {
                $('#ack-invoice-list').html(response);
            }
        });
    }

    function rejectInvoice(code) {
        if (confirm('Are you sure, Do you want to reject this Invoice?')) {
            var data = {};
            data.code = code;
            var loading_overlay = iosOverlay({
                text: 'Loading',
                icon: 'fa fa-spinner fa-spin'
            });
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/reject-invoice',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        var inv_code = code.replace(/[^a-zA-Z0-9-]/g, '').toLowerCase();
                        $('#vou_' + inv_code).animate({
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
                        getUnpaidInvoice();
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }
    }

    function makePaymentDialog(data) {
        $('#make-payment').css('background', '#fff');
        $('#make-payment').removeClass('hide');
        $('#make-payment').dialog({
            autoOpen: true,
            height: 500,
            width: 750,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar,#make_pay_action_state').hide();
        $('#make-payment .inp_error').removeClass('inp_error');

        $('#hid_invoice_code').val('');
        $('#pay_invoice_balanceamt').val('');
        $('#pay_invoice_amount').val('');
        $('#pay_invoice_tmode').val('');
        $('#discount_type').val('NA').trigger('change');
        //$('input[type="radio"][value="NO"]').prop('checked', true);

        $('#tds_amount').val('');
        $('#tds_tax_percent').val('0').trigger('change');
        $('#adjust_amount').val('');
        $('#pay_invoice_remarks').val('');

        /* if($('#tds-amt').hasClass('hide') == false){
            $('#tds-amt').addClass('hide');
        }

        if($('#adj_amt').hasClass('hide') == false){
            $('#adj_amt').addClass('hide');
        } */

        if(_isdefined(data)){
            $('#hid_invoice_code').val(data.code);
            $('#pay_invoice_balanceamt').text(parseFloat(data.transactionAmount-data.partialTransactionTotalAmount).toFixed(2));
            $('#pay_invoice_amount').val(parseFloat(data.transactionAmount-data.partialTransactionTotalAmount).toFixed(2));
            $('#invoice-balance-amount').val(parseFloat(data.transactionAmount-data.partialTransactionTotalAmount).toFixed(2));
            $('#pay_invoice_tmode').val(data.transactionMode.code).trigger('change');
            $('#pay_invoice_remarks').val(data.remarks);

            /* if(data.tdsTax > 0 || data.adjustmentAmount > 0){
                $('input[type="radio"][value="YES"]').prop('checked', true);
                $('#tds-amt').removeClass('hide');
                $('#adj_amt').removeClass('hide');
            }else{
                $('input[type="radio"][value="NO"]').prop('checked', true);
                $('#tds-amt').addClass('hide');
                $('#adj_amt').addClass('hide');
            }

            $('#tds_amount').val(parseFloat(data.tdsTax).toFixed(2));
            $('#adjust_amount').val(parseFloat(data.adjustmentAmount).toFixed(2)); */
        }
    }

    function confirmPayment() {
        var err = 0;
        $('#make-payment .inp_error').removeClass('inp_error');

        if (confirm('Are you sure, Do you want to pay this Invoice?')) {
            var data = {};
            data.code = $('#hid_invoice_code').val();
            data.transactionAmount = $.trim($('#pay_invoice_amount').val());
            data.remarks = $('#pay_invoice_remarks').val();
            data.transactionMode = $('#pay_invoice_tmode').val();
            
            data.additionalAttribute = {};
            if (cargo_setting.userAccountModel.code == 'TXRT') {
                data.additionalAttribute.INVOICE_ADJUSTMENT_CONTACT = $('#discount_type').val();
            }

            //if($('#tds_amount_radio:checked').val() == 'YES'){
                var tds_amt = Number($.trim($('#tds_amount').val()));
                var adj_amt = Number($('#adjust_amount').val());
                var amt_rcvd = Number($.trim($('#pay_invoice_amount').val()));
                var bal_amt = Number($('#pay_invoice_balanceamt').html());
                
                if((amt_rcvd+tds_amt+adj_amt)>bal_amt){
                    $('#pay_invoice_amount, #tds_amount, #adjust_amount').addClass('inp_error');

                    $('#make_pay_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#make_pay_action_state').html('Entered Amount Exceeds Due Amount');
                    $('#make_pay_action_state').show();
                    return false;
                }else{
                    data.tdsTax = tds_amt;
                    data.adjustmentAmount = adj_amt;

                    $('#pay_invoice_amount, #tds_amount, #adjust_amount').removeClass('inp_error');
                    $('#paid_action_state').removeClass('alert-success').removeClass('alert-danger');
                    $('#paid_action_state').html('').hide();
                }
            /* }else{
                data.tdsTax = '';
                data.adjustmentAmount = '';
            } */

            if (data.transactionMode == 'UPI') {
                data.bankDetails = {};
                data.bankDetails.code = $('#upi-orgbank').val();
                data.additionalAttribute.UPI_ID = $.trim($('#upi-id').val());
                data.additionalAttribute.REFERENCE_DETAILS = $.trim($('#upi-details').val());
                
                if (isNull(data.bankDetails.code)) {
                    $('#upi-orgbank').addClass('inp_error');
                    err++;
                }

                if (isNull(data.additionalAttribute.UPI_ID)) {
                    $('#upi-id').addClass('inp_error');
                    err++;
                }

                if (isNull(data.additionalAttribute.REFERENCE_DETAILS)) {
                    $('#upi-details').addClass('inp_error');
                    err++;
                }
            } else if (data.transactionMode == 'NBK') {
                data.bankDetails = {};
                data.bankDetails.code = $('#netbanking-orgbank').val();
                data.additionalAttribute.ACC_HOLDER_NAME = $.trim($('#netbanking-accholder').val());
                data.additionalAttribute.BANK_NAME = $.trim($('#netbanking-bankname').val());
                data.additionalAttribute.REFERENCE_DETAILS = $.trim($('#netbanking-details').val());
                
                if (isNull(data.bankDetails.code)) {
                    $('#netbanking-orgbank').addClass('inp_error');
                    err++;
                }

                if (isNull(data.additionalAttribute.REFERENCE_DETAILS)) {
                    $('#netbanking-details').addClass('inp_error');
                    err++;
                }
            } else if (data.transactionMode == 'CHEQUE') {
                var chequeDetails = {};
                chequeDetails.organization = {};
                chequeDetails.organization.code = login_branch_code;
                chequeDetails.bankDetails = $.trim($('#cheque-bankname').val());
                chequeDetails.payerDetails = $.trim($('#cheque-payer').val());
                chequeDetails.chequeDate = moment($('#cheque-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                chequeDetails.chequeNo = $.trim($('#cheque-no').val());
                chequeDetails.bankCity = $.trim($('#cheque-bankcity').val());
                chequeDetails.chequeStatus = {};
                chequeDetails.chequeStatus.code = 'NEW';
                chequeDetails.remarks = $.trim($('#cheque-remarks').val());

                if (isNull(chequeDetails.payerDetails)) {
                    $('#cheque-payer').addClass('inp_error');
                    err++;
                }
                if (isNull(chequeDetails.chequeNo)) {
                    $('#cheque-no').addClass('inp_error');
                    err++;
                }
                if (!moment($('#cheque-date').val(), 'DD-MM-YYYY').isValid()) {
                    $('#cheque-date').addClass('inp_error');
                    err++;
                }
                if (isNull(chequeDetails.bankCity)) {
                    $('#cheque-bankcity').addClass('inp_error');
                    err++;
                }
                if (isNull(chequeDetails.bankDetails)) {
                    $('#cheque-bankname').addClass('inp_error');
                    err++;
                }
                data.chequeDetails = chequeDetails;
            }

            if (data.transactionAmount == '' || isNaN(data.transactionAmount)) {
                $('#pay_invoice_amount').addClass('inp_error');
                err++;
            }
            if (data.transactionMode == '') {
                $('#pay_invoice_tmode').addClass('inp_error');
                err++;
            }
            
            if (cargo_setting.userAccountModel.code == 'TXRT') {
                if ($('#discount_type').val() != 'NA' && adj_amt == 0) {
                    $('#adjust_amount').addClass('inp_error');
                    err++;
                }

                if (adj_amt > 0 && $('#discount_type').val() == 'NA') {
                    $('#discount_type').addClass('inp_error');
                    err++;
                }
            }
            /* if($('#tds_amount_radio:checked').val() == 'YES'){
                if (data.tdsTax == '') {
                    $('#tds_amount').addClass('inp_error');
                    err++;
                }
            } */

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
                url: base_url + 'cargo/make-invoice-payment',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#make_pay_action_state').addClass('alert-success');
                        $('#make_pay_action_state').html('Your request has been completed successfully');
                        window.setTimeout(function () {
                            closePayment();
                            getAckInvoices();
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
        $('#make-payment').dialog('destroy');
        $('#make-payment').hide();

        //$('#make-payment').dialog('close');
    }

    function showPaidPartialInfo(code) {
        var data = {};
        data.paymentTransactionCode = code;

        $('#paid-info-loading').html(loading_popup).removeClass('hide alert-danger');
        $('#paid-info-table').addClass('hide');

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/invoice-partial-details',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#paid-info-loading').addClass('hide');
                    $('#paid-info-table').removeClass('hide');
                    $('#paid-info-body').html('');
                    var total_paid = 0;
                    var total_tds = 0;
                    var total_adj = 0;
                    var total_total_paid = 0;
              
                    if(response.data.partialPaymentList.length == 0) {
                        response.data.partialPaymentList.push(response.data);
                    }
                    $.each(response.data.partialPaymentList, function (i, val) {
                        if (!val.remarks) {
                            val.remarks = '-';
                        }
                        $('#paid-info-body').append('<tr>' +
                                '<td nowrap>' + moment(val.transactionDate).format('DD-MM-YYYY hh:mm A') + '</td>' +
                                '<td>' + val.transactionMode.name + '</td>' +
                                '<td>' + val.user.name + '</td>' +
                                '<td>' + val.remarks + '</td>' +
                                '<td nowrap>' + moment(val.amountReceivedDate).format('DD-MM-YYYY') + '</td>' +
                                '<td align="right">' + (val.transactionAmount).toFixed(2) + '</td>' +
                                '<td align="right">' + (val.tdsTax).toFixed(2) + '</td>' +
                                '<td align="right">' + (val.adjustmentAmount).toFixed(2) + '</td>' +
                                '<td align="right">' + (val.transactionAmount + val.tdsTax +val.adjustmentAmount).toFixed(2) + '</td>' +
                                '</tr>');

                        total_paid += (val.transactionAmount);
                        total_tds += (val.tdsTax);
                        total_adj += (val.adjustmentAmount);
                        total_total_paid += (val.transactionAmount + val.tdsTax +val.adjustmentAmount);
                    });
                    $('#paid-info-body').append('<tr class="bold">' +
                            '<td colspan="5" align="right">Total:</td>' +
                            '<td align="right">' + total_paid.toFixed(2) + '</td>' +
                            '<td align="right">' + total_tds.toFixed(2) + '</td>' +
                            '<td align="right">' + total_adj.toFixed(2) + '</td>' +
                            '<td align="right">' + total_total_paid.toFixed(2) + '</td>' +
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
            width: 1025,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
    }

    function closePaidPartialInfo() {
        $('#paid-info-dialog').dialog('destroy');
        $('#paid-info-dialog').hide();

        //$('#paid-info-dialog').dialog('close');
    }

    function closeUnpaidPartialInfo() {
        $('#unpaid-info-dialog').dialog('destroy');
        $('#unpaid-info-dialog').hide();

        //$('#unpaid-info-dialog').dialog('close');
    }

    function showUnpaidPartialInfo(obj) {
        obj = JSON.parse(obj);
        $('#parial-info-body').html('');
        var total_paid = 0;
        var total_tds = 0;
        var total_adj = 0;
        var total_total_paid = 0;

        $.each(obj, function (i, val) {
            if (!val.remarks) {
                val.remarks = '-';
            }
            if (val.acknowledgeStatus.code == 'PAPAID') {
                $('#parial-info-body').append('<tr>' +
                        '<td nowrap>' + moment(val.transactionDate).format('DD-MM-YYYY hh:mm A') + '</td>' +
                        '<td>' + val.transactionMode.name + '</td>' +
                        '<td>' + val.user.name + '</td>' +
                        '<td>' + val.remarks + '</td>' +
                        '<td nowrap>' + moment(val.amountReceivedDate).format('DD-MM-YYYY') + '</td>' +
                        '<td align="right">' + (val.transactionAmount).toFixed(2) + '</td>' +
                        '<td align="right">' + (val.tdsTax).toFixed(2) + '</td>' +
                        '<td align="right">' + (val.adjustmentAmount).toFixed(2) + '</td>' +
                        '<td align="right">' + (val.transactionAmount + val.tdsTax +val.adjustmentAmount).toFixed(2) + '</td>' +
                        '</tr>');
                
                total_paid += (val.transactionAmount);
                total_tds += (val.tdsTax);
                total_adj += (val.adjustmentAmount);
                total_total_paid += (val.transactionAmount + val.tdsTax +val.adjustmentAmount);
            }
        });
        $('#parial-info-body').append('<tr class="bold">' +
                '<td colspan="5" align="right">Total:</td>' +
                '<td align="right">' + total_paid.toFixed(2) + '</td>' +
                '<td align="right">' + total_tds.toFixed(2) + '</td>' +
                '<td align="right">' + total_adj.toFixed(2) + '</td>' +
                '<td align="right">' + total_total_paid.toFixed(2) + '</td>' +
                '</tr>');

        $('#unpaid-info-dialog').css('background', '#fff');
        $('#unpaid-info-dialog').removeClass('hide');
        $('#unpaid-info-dialog').dialog({
            autoOpen: true,
            height: 475,
            width: 1030,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
    }

    function payInvoice(code) {
        if (confirm('Are you sure, Do you want to approve this Invoice?')) {
            var data = {};
            data.code = code;
            var loading_overlay = iosOverlay({
                text: 'Loading',
                icon: 'fa fa-spinner fa-spin'
            });
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/approve-invoice',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        var inv_code = code.replace(/[^a-zA-Z0-9-]/g, '').toLowerCase();
                        $('#vou_' + inv_code).animate({
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
                        getUnpaidInvoice();
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }
    }

    function setTransactionMode() {
        var mode = $('#pay_invoice_tmode').val();

        $('#cheque-mode-panel').addClass('hide');
        $('#netbanking-mode-panel').addClass('hide');
        $('#upi-mode-panel').addClass('hide');

        if (mode == 'CASH') {
            return;
        }

        if (mode == 'CHEQUE') {
            $('#cheque-mode-panel input').val('');
            $('#cheque-mode-panel select').val('').trigger('change');
            $('#cheque-mode-panel').removeClass('hide');
        } else if (mode == 'NBK') {
            $('#netbanking-mode-panel input').val('');
            $('#netbanking-mode-panel select').val('').trigger('change');
            $('#netbanking-mode-panel').removeClass('hide');
        } else if (mode == 'UPI') {
            $('#upi-mode-panel input').val('');
            $('#upi-mode-panel select').val('').trigger('change');
            $('#upi-mode-panel').removeClass('hide');
        }
    }

    function calculateTDSPercent() {
        var amountReceived = Number($('#pay_invoice_amount').val()) || 0;
        var tdsPercentage =  Number($('#tds_tax_percent').val()) || 0;

        if (tdsPercentage > 0) {
            var tdsTax = Math.round(amountReceived * tdsPercentage / 100);
            $('#tds_amount').val(tdsTax).prop('disabled', false).trigger('change');
        } else {
            $('#tds_amount').val('').prop('disabled', true);
            var originalAmount = Number($('#invoice-balance-amount').val());
            $('#pay_invoice_amount').val(originalAmount);
            $('#pay_invoice_amount').trigger('input');
        }
    }

    function calculateAmountReceived(ele) {
        var amountReceived = Number($('#pay_invoice_amount').val()) || 0;
        var originalAmount = Number($('#invoice-balance-amount').val());
        // var amount = Number($(ele).val()) || 0;
        var tds_amount = $('#tds_amount').val() || 0;
        var adjust_amount = $('#adjust_amount').val() || 0;
        
        // if (amount > 0) {
        //     $('#pay_invoice_amount').val(amountReceived - amount);
        // } else {
        //     $('#pay_invoice_amount').val(originalAmount);
        //     $('#pay_invoice_amount').trigger('input');
        // }

        // if ($('#tds_amount').val() > 0 || $('#adjust_amount').val() > 0) {
            $('#pay_invoice_amount').val(originalAmount - tds_amount - adjust_amount);
        // } else {
        //     $('#pay_invoice_amount').val(originalAmount);
        //     $('#pay_invoice_amount').trigger('input');
        // }
    }

    function view_option_invioce(code) {
        console.log(code);
        $('#invoice_no').html('Invoice No : ' + code);
        $('.btn-success').prop('disabled', false);
        $('#TrsitCode').val(code);
        $('#invoice-view-option-select').show();
        $('#invoice-view-option-select').removeClass('hide');
        $('#invoice-view-option-select').dialog({
            autoOpen: true,
            width: 600,
            maxWidth: 500,
            height: 380,
            resizable: false,
            modal: true
        });
    }

    function closePoupOption() {
        $('#invoice-view-option-select').dialog('destroy');
        $('#invoice-view-option-select').hide();
    }


    function selectPrintInvoice() {
        var printStatus = $('input[name="print-invoice-radio"]:checked').val();
        if(printStatus==undefined){
            alert("Please select any print options.");
            return;
        }

        closePoupOption();
        var code = $('#TrsitCode').val();
        $('.print-dis').prop('disabled', true);
        $('#cargo-invoice-iframe').html('');
        $('#cargo-invoice-pdf-dialog').css('background', '#fff');
        $('#cargo-invoice-pdf-dialog').removeClass('hide');
        $('#cargo-invoice-pdf-dialog').dialog({
            autoOpen: true,
            height: 700,
            width: 1100,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();

        var $iframe = $('<iframe />');
        $iframe.attr('src', base_url + 'cargo/invoice-partial-transactions?paymentCode=' + code + '&printStatus=' + printStatus);
        $iframe.attr('class', 'iframe-fullwidth iframe-loading-bg');
        $('#cargo-invoice-iframe').html($iframe);
    }

    function clearForm() {
        $('input[name="print-invoice-radio"]').prop('checked', false);
    }
</script>