<div class="brand_top">
    <h3>{iflang('Transit Record Topay Payment')}</h3>
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

                                        <div id="search-panel">
                                            <form id='transit_topay_payment_record' method="post" name="transit_topay_payment_record" action="payment/transit-record-topay-payment-list" onsubmit="return false">
                                                <div class="row">
                                                    <div class="form-group col-md-4">
                                                        <label for="transit_topay_pmt_date_range" class="req">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="dateRange" class="form-control sdate" id="transit_topay_pmt_date_range" readonly="true" placeholder="Date Range">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2 " id="Branch_vales">
                                                        <label for="transit_topay_typewise"> To Station</label>
                                                        <div class="input-group col-md-11">
                                                            <select id="transit_topay_typewise" name="filterCode" class="form-control">
                                                                <option value="NA" data-station="" selected >All Station</option>
                                                                {* {foreach item=station from=$stations}
                                                                    <option value="{$station.code}" data-station="{$station.code}" {if $login_station == $station.code}selected="" {/if}>{$station.name}</option>
                                                                {/foreach} *}
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <input type="hidden" name="status" id="status" value="">
                                                            <input type="hidden" name="print" id="print" value="">
                                                            <input type="hidden" name="printStatus" id="printStatus" value="">
                                                            <input type="hidden" name="dateRange" id="date-hide" value="">
                                                            <button class="btn btn-success" type="button" onclick="searchtransitTopay();">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearTrasTopayPayment();">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <br class="clear_fix_both">
                                        <div class="align-center alert alert-danger pull-left" style="display:none" id="transit_record_topay_payment_action_state"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--row end-->

                    <div class="row hidden" id="trns-record-topay-payment-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="trns-record-topay-payment-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="transit-topay-head-dialog" class="hide dialog-content-page"></div>
                    <div id="transit-topay-revert-dialog" class="hide dialog-content-page">
                        <div>
                            <div class="row">
                                <div class="col-md-10 bold ft_14">
                                    <!-- Content for the first column -->
                                </div>
                                <div class="col-md-2">
                                    <a class="align-right" onclick="closeTransitRevertDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div id="search-panel">
                                <form id='transit_topay_payment_record' method="post" name="transit_topay_payment_record" action="payment/transit-record-topay-payment-list" onsubmit="return false">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="revertAmt">Revert Amount</label>
                                                <div class="input-group" style="width: 100%;">
                                                    <input type="text" name="revertAmt" class="form-control" id="revert-amount-topay" placeholder="Enter Revert Amount">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="revert_remark_topay">Remarks</label>
                                                <div class="input-group" style="width: 100%;">
                                                    <input type="text" name="revert_remark_topay" class="form-control" id="revert-remark-topay" placeholder="Enter Remarks">
                                                </div>
                                            </div>
                                        </div>
                                        <br class="clear_fix_both">
                                        <div class="col-md-12">
                                            <div class="align-center alert alert-danger pull-left" style="display:none;" id="revert_amount_topay_action_state"></div>
                                        </div>
                                        <div class="form-group col-md-8"></div>
                                        <div class="form-group col-md-4">
                                            <label for="">&nbsp;</label>
                                            <div class="input-group">
                                                <input type="hidden" name="code" id="code" value="">
                                                <input type="hidden" name="transitCode " id="transitCode" value="">
                                                <input type="hidden" name="labelName " id="labelName" value="">
                                                <input type="hidden" name="frmOrgCode" id="frmOrgCode" value="">
                                                <input type="hidden" name="relOrgCode" id="relOrgCode" value="">
                                                <input type="hidden" name="t_paid" id="t_paid" value="">
                                                <button class="btn btn-success" type="button" onclick="SaveRevertTopayPayment();">Save</button>&nbsp;
                                                <button type="button" class="btn btn-default btn-clear" onclick="closeTransitRevertDialog();">Clear</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!--content end-->
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_transit_downloader" id="ifrm_transit_downloader" style="display:none"></iframe>
<script>
    $(document).ready(function() {
        if (menu_permission['SHOW-TILL-DATE-RANGE'] == 1) {
            var picker = $('#transit_topay_pmt_date_range').daterangepicker({
                buttonClasses: ['btn', 'btn-xs'],
                format: 'DD-MM-YYYY',
                separator: ' | ',
                timePicker: false,
                ranges: {
                    'Today': [moment().startOf('day'), moment().endOf('day')],
                    'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
                    'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
                    'Last 31 Days': [moment().subtract(31, 'days').startOf('day'), moment().endOf('day')],
                    'Till Date': [moment().subtract(1, 'days').startOf('day'), moment().endOf('day')],
                },
                startDate: moment().subtract(3, 'months').startOf('day'),
                endDate: moment().endOf('day'),
            });
        } else {
            var picker = $('#transit_topay_pmt_date_range').daterangepicker({
                buttonClasses: ['btn', 'btn-xs'],
                format: 'DD-MM-YYYY',
                separator: ' | ',
                timePicker: false,
                ranges: {
                    'Today': [moment().startOf('day'), moment().endOf('day')],
                    'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
                    'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
                    'Last 31 Days': [moment().subtract(31, 'days').startOf('day'), moment().endOf('day')],
                },
                startDate: moment().subtract(3, 'months').startOf('day'),
                endDate: moment().endOf('day'),
            });
        }

        $('#transit_topay_pmt_date_range').on('apply.daterangepicker', function(ev, picker) {
            var selectedRange = $(".ranges ul li.active").text();
            $('#labelName').val(selectedRange);
        });

        // Set
        // default selection to "Last 3 Months"
        picker.data('daterangepicker').setStartDate(moment().subtract(1, 'months').startOf('day'));
        picker.data('daterangepicker').setEndDate(moment().endOf('day'));

        // Update the input value
        $('#transit_topay_pmt_date_range').val(picker.data('daterangepicker').startDate.format('DD-MM-YYYY') + ' | ' + picker.data('daterangepicker').endDate.format('DD-MM-YYYY'));

        $('#revert-amount-topay').on('input', function() {
            var inputValue = $(this).val();
            var numericValue = inputValue.replace(/[^0-9]/g, '');
            $(this).val(numericValue);
        });

    });

    $('#transit_topay_typewise, #transit_typewise, #transit_groupby').select2();

    function searchtransitTopay() {
        $('#trns-record-topay-payment-list').html('');
        var data = {};

        if ($('#labelName').val() == 'Till Date') {
            data.dateRange = "NA | NA";
        } else {
            data.dateRange = $('#transit_topay_pmt_date_range').val();
        }

        data.filterCode = $('#transit_topay_typewise').val();

        var err = 0;
        $('#transit_topay_pmt_date_range , #transit_topay_typewise ').removeClass('inp_error');
        if (data.dateRange == '') {
            $('#transit_topay_pmt_date_range').addClass('inp_error');
            err++;
        } else {
            $('#transit_topay_pmt_date_range').removeClass('inp_error');
        }

        if (data.filterCode == '') {
            $('#transit_topay_typewise').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#transit_record_topay_payment_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#transit_record_topay_payment_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#transit_record_topay_payment_action_state').show();
            return false;
        } else {
            $('#transit_record_topay_payment_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#transit_record_topay_payment_action_state').html('');
            $('#transit_record_topay_payment_action_state').hide();
        }
        var html = "";
        $('#trnsit_topay_payment_date_to').removeClass('inp_error');
        $('#trns-record-topay-payment-list-container').removeClass('hidden');
        $('#trns-record-topay-payment-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "payment/transit-record-paid-summary-list",
            data: data,
            success: function(response) {
                $('#transit_topay_excl_cons').show();
                $('#trns-record-topay-payment-list').html(response);
            }
        })
    }

    function clearTrasTopayPayment() {
        $('#transit_topay_pmt_date_range').val('').trigger('change');
        $('#trns-record-topay-payment-list-container').addClass('hidden');
        $('#trns-record-topay-payment-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#transit_record_topay_payment_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#transit_record_topay_payment_action_state').html('');
        $('#transit_record_topay_payment_action_state').hide();
    }

    function showTransitReportDialog(ogpl, org_code, rel_orgCode) {
        var data = {};
        data.fromDate = $('#trnsit_topay_payment_date_from').val();
        data.toDate = $('#trnsit_topay_payment_date_to').val();
        data.filterType = $('#trnsit_topay_branch_type').val();
        data.filterCode = org_code + "," + rel_orgCode;
        data.transitCode = ogpl;
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "payment/transit-record-paid-summary-list",
            data: data,
            success: function(response) {
                $('#transit-topay-head-dialog').html(response);
                $('#transit-topay-head-dialog').show();
                $('#transit-topay-head-dialog').removeClass('hide');
                $('#transit-topay-head-dialog').dialog({
                    autoOpen: true,
                    width: 1000,
                    maxWidth: 1200,
                    height: 350,
                    resizable: false,
                    modal: true
                });
            }
        })
    }

    function closeTransitTopayDialog() {
        $('#transit-topay-head-dialog').dialog('destroy');
        $('#transit-topay-head-dialog').hide();
    }

    function closeTransitRevertDialog() {
        $('#transit-topay-revert-dialog').dialog('destroy');
        $('#transit-topay-revert-dialog').hide();
        $('#revert-amount-topay').removeClass('inp_error');
        $('#revert-remark-topay').removeClass('inp_error');
        $('#revert_amount_topay_action_state').removeClass('alert-success').removeClass('alert-danger');
    }

    function updateTransitTopayPayment(code, transitCode, frmOrgCode, relOrgCode, t_paid) {
        var data = {};
        data.code = '';
        transactionType = {};
        data.transactionType = "PMT";

        data.transactionAmount = $.trim($('#' + code).val());
        data.remarks = $('#remarks-' + code).val();
        data.fromOrganization = frmOrgCode;
        data.organization = relOrgCode;
        data.transitCargo = transitCode;
        var paid_amount = parseInt(t_paid);
        $('#' + code).removeClass('inp_error');

        if (data.transactionAmount == "") {
            $('#' + code).addClass('inp_error');
            return;
        } else if (Number(data.transactionAmount) <= 0) {
            $('#' + code).addClass('inp_error');
            return;
        } else if (isNaN(data.transactionAmount)) {

        } else if (Number(data.transactionAmount) > paid_amount) {
            $('#' + code).addClass('inp_error');
            return;
        }

        var loading_overlay = iosOverlay({
            text: "Please Wait...",
            icon: "fa fa-spinner fa-spin"
        });

        $('#' + code + '-action .save-btn').addClass('hide');
        $('#' + code + '-action .act-status').html('');
        $('#' + code + '-action .act-loading').html(loading_small);
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "payment/update-transit-topay-payment",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#' + code).parent('td').text($('#' + code).val());
                    $('#' + code + '-action .act-loading').html('');
                    $($('#' + code + '-action .act-status')).html('<span class="txt_green">Success<span>');
                    $('#remarks-' + code).html('');

                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Done !",
                        color: '#0000'
                    });

                } else {
                    $('#' + code + '-action .save-btn').removeClass('hide');
                    $('#' + code + '-action .act-loading').html('');
                    $('#' + code + '-action .act-status').html('<span class="warning-text">' + response.errorDesc + '<span>');
                }
                window.setTimeout(function() {
                    loading_overlay.hide();
                    searchtransitTopay();
                }, 2000);
            }
        });
    }

    function remarkAdd(code) {
        $('#remarks-' + code).removeClass('hide');
    }

    function remarkAddUnpaid(code) {
        $('#unpaid-' + code).removeClass('hide');
    }

    function getTransitAllTransaction(transitCode, stationCode, relstationCode) {
        var data = {};
        data.transitCode = transitCode;
        data.stationCode = stationCode;
        data.relatedStationCode = relstationCode;

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "payment/get-transit-topay-transaction-details",
            data: data,
            success: function(response) {
                $('#transit-topay-head-dialog').html(response);
                $('#transit-topay-head-dialog').show();
                $('#transit-topay-head-dialog').removeClass('hide');
                $('#transit-topay-head-dialog').dialog({
                    autoOpen: true,
                    width: 600,
                    maxWidth: 600,
                    height: 400,
                    resizable: false,
                    modal: true
                });
            }
        });
    }

    function updateTransitUnpaidPayment(code, transitCode, frmOrgCode, relOrgCode, t_paid) {


        var data = {};
        data.code = '';
        transactionType = {};
        data.transactionType = "PMT";

        data.transactionAmount = $.trim($('#row-' + code).val());
        data.remarks = $('#unpaid-' + code).val();
        data.fromOrganization = frmOrgCode;
        data.organization = relOrgCode;
        data.transitCargo = transitCode;
        var paid_amount = parseInt(t_paid);
        $('#row-' + code).removeClass('inp_error');

        if (data.transactionAmount == "") {
            $('#row-' + code).addClass('inp_error');
            return;
        } else if (Number(data.transactionAmount) <= 0) {
            $('#row-' + code).addClass('inp_error');
            return;
        } else if (isNaN(data.transactionAmount)) {} else if (Number(data.transactionAmount) > paid_amount) {
            $('#row-' + code).addClass('inp_error');
            return;
        }

        var loading_overlay = iosOverlay({
            text: "Please Wait...",
            icon: "fa fa-spinner fa-spin"
        });

        $('#' + code + '-unpaid .save-btn').addClass('hide');
        $('#' + code + '-unpaid .act-status').html('');
        $('#' + code + '-unpaid .act-loading').html(loading_small);
        $('.myButton').prop('disabled', true);
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "payment/update-transit-topay-payment",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#' + code).parent('td').text($('#' + code).val());
                    $('#' + code + '-action .act-loading').html('');
                    $($('#' + code + '-action .act-status')).html('<span class="txt_green">Success<span>');
                    $('#unpaid-' + code).html('');

                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Done !",
                        color: '#0000'
                    });

                } else {
                    $('#' + code + '-unpaid .save-btn').removeClass('hide');
                    $('#' + code + '-unpaid .act-loading').html('');
                    $('#' + code + '-unpaid .act-status').html('<span class="warning-text">' + response.errorDesc + '<span>');
                }
                window.setTimeout(function() {
                    loading_overlay.hide();
                    searchtransitTopay();
                }, 2000);
            }
        });
    }

    function RevertTransitTopayPayment(selectedCode, selectedTransitCode, selectedFrmOrgCode, selectedRelOrgCode, selectedTPaid) {
        $('#code').val(selectedCode);
        $('#transitCode').val(selectedTransitCode);
        $('#frmOrgCode').val(selectedFrmOrgCode);
        $('#relOrgCode').val(selectedRelOrgCode);
        $('#t_paid').val(selectedTPaid);
        $('#revert-amount-topay').val(selectedTPaid);
        $('#revert-remark-topay').val('');

        $('#transit-topay-revert-dialog').show();
        $('#transit-topay-revert-dialog').removeClass('hide');
        $('#transit-topay-revert-dialog').dialog({
            autoOpen: true,
            width: 600,
            maxWidth: 600,
            height: 380,
            resizable: false,
            modal: true

        });
    }

    function SaveRevertTopayPayment() {
        var err = 0
        var data = {};
        data.code = '';
        var code = $('#code').val();
        var transitCode = $('#transitCode').val();
        var frmOrgCode = $('#frmOrgCode').val();
        var relOrgCode = $('#relOrgCode').val();

        var t_paid = $('#t_paid').val();
        var revertAmt = parseInt($('#revert-amount-topay').val());
        var revert_remark_topay = $('#revert-remark-topay').val();
        transactionType = {};
        data.transactionType = "RVT";
        var paid_amount = parseInt(t_paid);

        data.transactionAmount = revertAmt;
        data.remarks = revert_remark_topay;
        data.fromOrganization = frmOrgCode;
        data.organization = relOrgCode;
        data.transitCargo = transitCode;

        $('#revert-amount-topay').removeClass('inp_error');
        $('#revert-remark-topay').removeClass('inp_error');
        if (data.transactionAmount === "") {
            $('#revert-amount-topay').addClass('inp_error');
            err++;
        } else if (Number(data.transactionAmount) <= 0) {
            $('#revert-amount-topay').addClass('inp_error');
            err++;
        } else if (isNaN(data.transactionAmount)) {
            $('#revert-amount-topay').addClass('inp_error');
            err++;
        } else if (Number(data.transactionAmount) > paid_amount) {
            $('#revert-amount-topay').addClass('inp_error');
            err++;
        }

        var err1 = 0;
        if (data.remarks == "") {
            $('#revert-remark-topay').addClass('inp_error');
            err1++;
        }

        if (err > 0) {
            $('#revert_amount_topay_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#revert_amount_topay_action_state').html('Revert amount should not exceed paid amount');
            $('#revert_amount_topay_action_state').show();
            return false;
        } else {
            $('#revert_amount_topay_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#revert_amount_topay_action_state').html('');
            $('#revert_amount_topay_action_state').hide();
        }

        if (err1 > 0) {
            $('#revert_amount_topay_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#revert_amount_topay_action_state').html('Remarks is mandatory');
            $('#revert_amount_topay_action_state').show();
            return false;
        } else {
            $('#revert_amount_topay_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#revert_amount_topay_action_state').html('');
            $('#revert_amount_topay_action_state').hide();
        }


        var loading_overlay = iosOverlay({
            text: "Please Wait...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "payment/update-transit-topay-payment",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Done !",
                        color: '#0000'
                    });
                } else {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "error !",
                        color: '#0000'
                    });
                }
                window.setTimeout(function() {
                    loading_overlay.hide();
                    closeTransitRevertDialog();
                    searchtransitTopay();
                }, 2000);
            }
        });

    }

    function exportTransitToPayExcel(exe) {
        var form = document.getElementById('transit_topay_payment_record');

        if ($('#labelName').val() == 'Till Date') {
            var dateRange = "NA | NA";
            $('#date-hide').val(dateRange);
        } else {
            $('#date-hide').val($('#transit_topay_pmt_date_range').val());
        }

        if (form && typeof form.submit === 'function') {
            form.target = "ifrm_transit_downloader";
            form.setAttribute("action", "payment/transit-record-topay-payment-list");
            $('#export').val(1);
            $('#status').val(exe);
            $('#print').val('');
            $('#printStatus').val('');
            form.submit();
        } else {
            console.error('Form or submit method not found');
        }
    }

    function printTransitToPay(exe) {
        var form = document.getElementById('transit_topay_payment_record');
        if ($('#labelName').val() == 'Till Date') {
            var dateRange = "NA | NA";
            $('#date-hide').val(dateRange);
        } else {
            $('#date-hide').val($('#transit_topay_pmt_date_range').val());
        }
        if (form && typeof form.submit === 'function') {
            form.target = "ifrm_transit_downloader";
            form.setAttribute("action", "payment/transit-record-paid-summary-list");
            $('#print').val(1);
            $('#printStatus').val(exe);
            $('#export').val('');
            $('#status').val('');
            form.submit();
        } else {
            console.error('Form or submit method not found');
        }
    }
</script>