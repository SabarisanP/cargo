<div class="brand_top">
    <h3>Generate Invoice</h3>
    <span class="align-right">
        <a href="#cargo/invoice" class="btn btn-success btn-sm"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;Back</a>
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
                                                <form id="gen_invoice_form" method="post" name="gen_invoice_form" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="gen_invoice_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="gen_invoice_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="gen_invoice_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="gen_invoice_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="gen_invoice_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="gen_invoice_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="gen_invoice_vendor_code">Vendor</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="gen_invoice_vendor_code" name="vendorCode"  class="form-control">
                                                                    <option value="NA" selected="">All Vendors</option>
                                                                    {foreach item=row from=$vendors}
                                                                        <option value="{$row->code}">{$row->companyName}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-3">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <button type="button" class="btn btn-success" onclick="getInvoiceList();">Get Transactions</button>&nbsp;
                                                                <button type="button" class="btn btn-default" onclick="clearInvoice();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="gen_invoice_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="gen-invoice-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="gen-invoice-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="invoice-dialog" class="hide dialog-content-page">
    <div class="">
        <form role="form" id="form1" class="form-horizontal">
            <div class="col-lg-12 p_l_n p_r_n">
                <label for="gen_invoice_vendor" class="req">Invoice To</label>
                <div class="input-group col-md-12">
                    <select id="gen_invoice_vendor" name="vendorCode"  class="form-control" onchange="getVendorAllAddress()">
                        <option value="NA" selected="">Select Vendor</option>
                        {foreach item=row from=$vendors}
                            <option value="{$row->code}">{$row->companyName}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="clear_fix_both"></div>
            <br/>
            <div class="col-lg-12 p_l_n p_r_n">
                <label for="gen_invoice_address" class="req">Address</label>
                <input type="text" class="form-control" id="gen_invoice_address" placeholder="Address">
            </div>
            <div class="clear_fix_both"></div>
            <br/>
            <div class="col-lg-12 p_l_n p_r_n">
                <label for="gen_invoice_tax" class="req">GST</label>
                <div class="input-group col-md-12">
                    <select id="gen_invoice_tax" name="taxCode"  class="form-control">
                        <option value="" data-state="" selected="">Select GST</option>
                        {foreach item=row from=$gst}
                            <option value="{$row->code}" data-state="{$row->state->code}">{$row->state->name}  - {$row->gstin}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="clear_fix_both"></div>
            <br/>
            <div class="col-lg-12 p_l_n p_r_n">
                <div>
                    <label for="gen_invoice_t_mode" class="req">Transaction Mode</label>
                    <select id="gen_invoice_t_mode" class="form-control col-md-6">
                        <option value="">Select</option>
                        {foreach key=key item=value from=$transactionMode}
                            <option value="{$key}">{$value}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="clear_fix_both"></div>
            <br/>
            <div class="col-lg-12 p_l_n p_r_n">
                <div>
                    <label for="gen_invoice_remarks">Remarks</label>
                    <textarea id="gen_invoice_remarks"  placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" id="remark"></textarea>
                </div>
            </div>
            <div class="clear_fix_both"></div>
        </form>
    </div>
    <div class="fr"> <b>Payable Amount :</b> <i class="fa fa-inr"></i>&nbsp; <span class="vou_btn gen_invoice_pay_amt">0.00</span></div>
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="pay_invoice_action_state"></div>
        <div class="align-right" id="form-bttons">
            <button class="btn btn-success" type="button" id="confirm-pay" onclick="confirmInvoice();">Generate</button>
            <button class="btn btn-default" type="button" onclick="closeInvoicePopup();">Cancel</button>
        </div>
    </div>
</div>

<script id="invoice-vendor-address-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-12">
            <b class="invoice-address-name"></b>
        </div>
        <div class="col-xs-12 text-muted small">
            <b class="invoice-address1"></b>,
            <b class="invoice-address2"></b>,
            <b class="invoice-landmark"></b>
        </div>
        <div class="col-xs-12 text-muted small">
            <b class="invoice-station"></b> - <b class="invoice-pincode"></b>
        </div>
    </div>
</script>

<script>
    var invoiceVendorAddressTpl = $('#invoice-vendor-address-tpl').html();
    var nsprofile = {};
    nsprofile.stateCode = {$nsprofile->state->code|json_encode}

    $('#gen_invoice_from').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        startDate: '-6m',
        endDate: '+1D',
        changeMonth: true
    }).on('changeDate', function (e) {
        $('#gen_invoice_to').datepicker('setStartDate', e.date);
    });
    $('#gen_invoice_to').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        endDate: '+1D',
        autoclose: true
    }).on('changeDate', function (e) {
        $('#gen_invoice_from').datepicker('setEndDate', e.date);
    });
    $('#gen_invoice_vendor').select2();
    $('#gen_invoice_tax').select2();

    $('#gen_invoice_vendor_code').select2();
    function getInvoiceList() {
        var data = {};
        data.fromDate = $('#gen_invoice_from').val();
        data.toDate = $('#gen_invoice_to').val();
        data.vendorCode = $('#gen_invoice_vendor_code').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if (data.fromDate == '') {
            $('#gen_invoice_from').addClass('inp_error');
            err++;
        }

        if (data.toDate == '') {
            $('#gen_invoice_to').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#gen_invoice_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#gen_invoice_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#gen_invoice_action_state').show();
            return false;
        } else {
            $('#gen_invoice_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#gen_invoice_action_state').html('');
            $('#gen_invoice_action_state').hide();
        }

        $('#gen-invoice-list-container').removeClass('hidden');
        $('#gen-invoice-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/get-invoice-list-v2',
            data: data,
            success: function (response) {
                $('#gen-invoice-list').html(response);
                $('html, body').animate({
                    scrollTop: $('#gen-invoice-list-container').offset().top - 35
                }, 'slow');
            }
        });
    }

    function clearInvoice() {
        $('.inp_error').removeClass('inp_error');
        $('#gen_invoice_from').val('');
        $('#gen_invoice_to').val('');
        $('#gen_invoice_vendor_code').val('NA').trigger('change');
        $('#gen-invoice-list').html('');
        $('#gen-invoice-list-container').addClass('hidden');
        $('#gen_invoice_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#gen_invoice_action_state').html('').hide();
    }

    function invoicePopup(vendor = '') {
        if($('.gen_invoice_check.'+vendor + ':checked').length == 0){
            alert('Please select one or more Transactions');
            return;
        }
        if(parseFloat($('#'+vendor).html()) <= 0){
            alert('Please enter a freight amount for the selected transactions');
            return;
        }
        $('.gen_invoice_pay_amt').html($('#'+vendor).html());
        if (vendor == '' || vendor == 'NA') {
            $('#gen_invoice_vendor').val('NA').trigger('change').prop('disabled', false);
        } else {
            $('#gen_invoice_vendor').val(vendor).trigger('change').prop('disabled', true);
        }
        $('#gen_invoice_tax [data-state="' + nsprofile.stateCode + '"]').prop('selected', true).trigger('change');
        $('#confirm-pay').attr('onclick', "confirmInvoice('"+vendor+"');");

        $('#invoice-dialog').css('background', '#fff');
        $('#invoice-dialog').removeClass('hide');
        $('#invoice-dialog').dialog({
            autoOpen: true,
            height: 540,
            width: 450,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
    }

    function closeInvoicePopup() {
        $('#invoice-dialog').dialog('destroy');
        $('#invoice-dialog').hide();
        $('#gen_invoice_t_mode').val('');
        $('#gen_invoice_address').val('').trigger('change');
        $('#gen_invoice_remarks').val('');
        $('#invoice-dialog .inp_error').removeClass('inp_error');
        $('#pay_invoice_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#pay_invoice_action_state').hide();
    }

    function confirmInvoice(vendor) {
        var data = {};

        transactionCodes = [];
        data.lrDetails = [];
        
        var vendorCode = $('#gen_invoice_vendor').val();
        $('.gen_invoice_check.'+vendor).each(function(i, val){
            if ($(this).is(':checked')) {
                var $tr = $(this).closest('tr');
                var lrCode = $(this).val();
                transactionCodes.push(lrCode);

                var lrData = _.find(invoiceData || [], i => i.code === lrCode);
                var lrDetail = {};
                lrDetail.code = lrCode;
                lrDetail.vendorUser = {};
                lrDetail.vendorUser.code = vendorCode;
                lrDetail.itemDetails = lrData.itemDetails;

                $.each(lrDetail.itemDetails || [], function (i, item) {
                    item.fare = $tr.find('.freight-inp').val();
                    item.handlingChargeAmount = $tr.find('.loading-inp').val();

                    return false;
                });
                lrDetail.paymentAmount = 0;
                lrDetail.pickupHandlingAmount = 0;
                lrDetail.deliveryHandlingAmount = 0;
                lrDetail.serviceCharge = 0;
                lrDetail.serviceTax = 0;
                lrDetail.hamaliCharge = 0;
                lrDetail.passCharge = 0;
                lrDetail.docketCharge = 0;

                var dpcharges = $tr.find('.doorpickup-inp').val();
                lrDetail.pickupType = lrData.pickupType;
                lrDetail.pickupHandlingAmount = 0;
                if (Number(dpcharges) > 0) {
                    lrDetail.pickupType.code == 'PUDO';
                    lrDetail.pickupHandlingAmount = dpcharges;
                }

                var ddcharges = $tr.find('.doordelivery-inp').val();
                lrDetail.deliveryType = lrData.deliveryType;
                lrDetail.deliveryHandlingAmount = 0;
                if (Number(ddcharges) > 0) {
                    lrDetail.deliveryType.code == 'DYDO';
                    lrDetail.deliveryHandlingAmount = ddcharges;
                }

                data.lrDetails.push(lrDetail);
            }
        });

        data.remarks = $('#gen_invoice_remarks').val();
        data.namespaceTax = $('#gen_invoice_tax').val();
        data.transactionMode = $('#gen_invoice_t_mode').val();
        data.transactionCodes = transactionCodes.join(',');
        data.user = {};
        data.user.code = vendorCode;
        
        data.vendorBillingAddress = {};
        data.vendorBillingAddress.code = $('#gen_invoice_address').val();

        var err = 0;
        $('#invoice-dialog .inp_error').removeClass('inp_error');

        if (data.transactionMode == '') {
            $('#gen_invoice_t_mode').addClass('inp_error');
            err++;
        }
        if (data.namespaceTax == '') {
            $('#gen_invoice_tax').addClass('inp_error');
            err++;
        }
        if (vendorCode == '' || vendorCode == 'NA') {
            $('#gen_invoice_vendor').addClass('inp_error');
            err++;
        }
        if (data.vendorBillingAddress.code == '') {
            $('#gen_invoice_address').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#pay_invoice_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#pay_invoice_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#pay_invoice_action_state').show();
            return false;
        }

        $('#pay_invoice_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#pay_invoice_action_state').html(loading_popup).show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/pay-generated-invoice-v2',
            data: data,
            success: function (response) {
                if(response.status == 1){
                    $('#pay_invoice_action_state').addClass('alert-success');
                    $('#pay_invoice_action_state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        closeInvoicePopup();
                        getInvoiceList();
                    }, 3000);
                } else {
                    $('#pay_invoice_action_state').addClass('alert-danger');
                    $('#pay_invoice_action_state').html(response.errorDesc);
                }
            }
        });
    }

    function formatVendorAddress(address) {
        var $tpl = $(invoiceVendorAddressTpl);
        $tpl.find('.invoice-address-name').text(address.name);
        $tpl.find('.invoice-address1').text(address.address1);
        $tpl.find('.invoice-address2').text(address.address2);
        $tpl.find('.invoice-landmark').text(address.landmark);
        $tpl.find('.invoice-pincode').text(address.pincode);
        $tpl.find('.invoice-station').text(address.station.name);
        return $tpl;
    };

    function vendorAddressMatcher(term, text, address) {
        text = [address.name, address.station].join(' ');
        return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
    };

    function getVendorAllAddress() {
        var data = {};
        data.vendorCode = $('#gen_invoice_vendor').val();
        $('#gen_invoice_address').attr('placeholder', 'Loading...');

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/get-vendor-address',
            data: data,
            success: function (response) {
                var vendorAddress = [];
                    $.each(response.data || [], function (i, row) {
                    row.id = row.code;
                    row.name = row.name;
                    vendorAddress.push(row);
                });

                $('#gen_invoice_address').attr('placeholder', 'Select Address');
                $('#gen_invoice_address').select2({
                    data: { results: vendorAddress },
                    placeholder: 'Select Address',
                    formatResult: formatVendorAddress,
                    formatSelection: formatVendorAddress,
                    matcher: vendorAddressMatcher
                });
            }
        });
    }
</script>