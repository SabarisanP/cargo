<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-19 15:03:54
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\generate-invoice.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6672a6028e6f71_64966444',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'b24b969535943b2bb45d63512c0d08e4f1b1cd12' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\generate-invoice.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6672a6028e6f71_64966444 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
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
                                                        <div class="form-group col-md-3">
                                                            <label for="gen_invoice_date_range">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="gen_invoice_date_range" readonly placeholder="Today" value="<?php echo implode(' | ',array_filter(array(smarty_modifier_date_format($_smarty_tpl->tpl_vars['ffromDate']->value,'%d-%m-%Y'),smarty_modifier_date_format($_smarty_tpl->tpl_vars['ftoDate']->value,'%d-%m-%Y'))));?>
">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="gen_invoice_vendor_code"><?php echo lang('vendor');?>
</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="gen_invoice_vendor_code" name="vendorCode"  class="form-control">
                                                                    <option value="NA" selected="">All <?php echo lang('vendor');?>
</option>
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['vendors']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->companyName;?>
</option>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
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
                <label for="txt_l_name" style="display: inline;">Invoice To&nbsp;( <span id="vouch_head"></span> ) - </label>
                <label for="txt_l_name" class="bold" id="vouch_to" style="display: inline;font-weight:lighter"></label>
                <div class="pull-right">
                    <label id="invoice_lr_tot_amt" class="bold" style="display: inline;font-weight:lighter;float: right;"></label>
                    <label style="display: inline;float: right;"><?php echo lang('lr');?>
 Amount :&nbsp;&nbsp;</label>
                </div>
            </div>
            <div class="clear_fix_both"></div>
            <br/>
            <div class="col-lg-12 p_l_n p_r_n">
                <label for="gen_invoice_address" class="req">Address</label>
                <input type="text" class="form-control" id="gen_invoice_address" placeholder="Address">
            </div>
                                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ADD-OTHER-INC-EXP'] == 1) {?>
                <div class="col-lg-12 p_l_n p_r_n">
                    <h5 style="font-size: 14px;">Add other income / expenses in to this invoice</h5>
                </div>
                <div class="col-lg-12 p_l_n p_r_n" style="height: 200px;overflow: auto;">
                    <table class="table table-striped" id="article-table">
                        <thead>
                            <tr>
                                <th class="">Line Item (Income / Expenses )</th>
                                <th class="">Transaction Type</th>
                                <th class="">Rate</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr id="tr_clone" class="tr_clone">
                                <td width='45%'>
                                    <input type="text" placeholder="Income / Expense Name" id="ext-item-name" class="form-control clone-field">
                                </td>

                                <td width='25%'>
                                    <select id="ext-item-trans-type" class="form-control clone-field">
                                        <option value=''>Select</option>
                                        <option value="IN">Income</option>
                                        <option value="EX">Expense</option>
                                    </select> 
                                </td>

                                <td width='25%'>
                                    <input type="number" placeholder="Amount" id="ext-item-amount" value="" class="form-control clone-field" step="any">
                                </td>

                                <td width='5%' align="right">
                                    <a href="javascript:;" onclick="removeArticleRow(this);" data-index="1" class="btn btn-sm btn-danger tr_remove" title="Remove"><i class="fa fa-times"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="javascript:;" class="btn btn-sm btn-primary" id="tr_add_btn" title="Add <?php echo lang('booking_article_label');?>
" onclick="addArticleRow(this)"> <i class="fa fa-plus"></i> </a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            <?php }?>
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
    <div class="fr" style="padding: 5px 0;"> <b>Net Amount :</b> <i class="fa fa-inr"></i>&nbsp; <span class="vou_btn gen_invoice_pay_amt">0.00</span></div>
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="pay_invoice_action_state"></div>
        <div class="align-right" id="form-bttons">
            <input type="hidden" id="inv-hid-code">
            <button class="btn btn-success" type="button" id="confirm-pay" onclick="confirmInvoice();">Generate</button>
            <button class="btn btn-default" type="button" onclick="closeInvoicePopup();">Cancel</button>
        </div>
    </div>
</div>

<?php echo '<script'; ?>
 id="invoice-vendor-address-tpl" type="text/html">
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
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
>
    var tr_id = $('#article-table tbody .tr_clone').length;
    var invoiceVendorAddressTpl = $('#invoice-vendor-address-tpl').html();
    
    $('#gen_invoice_date_range').daterangepicker({
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

    $('#gen_invoice_vendor_code').select2();

    $('#ext-item-trans-type, #ext-item-amount').on('change', function(){
        var inv_code = $('#inv-hid-code').val();
        var payable_amt = Number($('#'+inv_code).html());

        var cr_amt = 0 ;
        var dr_amt = 0 ;
        $.each($('#article-table tbody tr').not(':last-child'), function(){
            if($(this).find('#ext-item-trans-type').val() == 'IN'){
                cr_amt += Number($(this).find('#ext-item-amount').val());
            }else if($(this).find('#ext-item-trans-type').val() == 'EX'){                
                dr_amt += Number($(this).find('#ext-item-amount').val());
            }
        });

        $('.gen_invoice_pay_amt').html((payable_amt+cr_amt-dr_amt).toFixed(2));
    })

    function getInvoiceList() {
        var data = {};
        var daterange = $('#gen_invoice_date_range').data('daterangepicker');
        data.fromDate = daterange.startDate.format('DD-MM-YYYY');
        data.toDate = daterange.endDate.format('DD-MM-YYYY');
        data.vendorCode = $('#gen_invoice_vendor_code').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');

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
            url: base_url + 'cargo/get-invoice-list',
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
        $('#gen_invoice_date_range').val('');
        $('#gen_invoice_date_range').data('daterangepicker').setStartDate({});
        $('#gen_invoice_date_range').data('daterangepicker').setEndDate({});
        $('#gen_invoice_vendor_code').val('NA').trigger('change');
        $('#gen-invoice-list').html('');
        $('#gen-invoice-list-container').addClass('hidden');
        $('#gen_invoice_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#gen_invoice_action_state').html('').hide();
    }

    function invoicePopup(vendor, name = '') {
        if(parseFloat($('#'+vendor).html()) <= 0){
            alert('Please select one or more Transactions');
            return;
        }
        $('#inv-hid-code').val(vendor)
        $('.gen_invoice_pay_amt').html($('#'+vendor).html());
        $('#invoice_lr_tot_amt').html($('#'+vendor).html());
        $('#vouch_head').html('Vendor');
        $('#vouch_to').html(name);
        $('#confirm-pay').attr('onclick', "confirmInvoice('"+vendor+"');");

        $('#invoice-dialog').css('background', '#fff');
        $('#invoice-dialog').removeClass('hide');
        $('#invoice-dialog').dialog({
            autoOpen: true,
            height: 560,
            width: 750,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
        getVendorAllAddress(vendor);
    }

    function closeInvoicePopup() {
        tr_id = 1;
        $('#article-table tbody .tr_clone').not(':first-child').remove();
        $('#article-table tbody .tr_clone:first-child').find('#ext-item-name').val('');
        $('#article-table tbody .tr_clone:first-child').find('#ext-item-amount').val('');
        $('#article-table tbody .tr_clone:first-child').find('#ext-item-trans-type').val('');
        $('#article-table tbody .tr_clone').attr('id', 'tr_clone');

        $('#invoice-dialog').dialog('destroy');
        $('#invoice-dialog').hide();
        $('#gen_invoice_address').val('');
        $('#gen_invoice_remarks').val('');
        $('#invoice-dialog .inp_error').removeClass('inp_error');
        $('#pay_invoice_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#pay_invoice_action_state').hide();
    }

    function addArticleRow(ele){
        tr_id = tr_id+1;
        var cloned_tr = $('.tr_clone:first-child').clone(true);
        cloned_tr.attr('id', 'tr_clone' + tr_id);
        cloned_tr.find('.tr_remove').attr('data-index', tr_id);
        cloned_tr.find('.clone-field').val('');

        $('#article-table>tbody>tr').eq(-2).after(cloned_tr);
    }

    function removeArticleRow(ele) {
        if($('#article-table tbody tr').length >2){
            ele.closest('tr').remove();
        }
    }

    function confirmInvoice(vendor) {
        var data = {};

        transactionCodes = [];
        $('.gen_invoice_check.'+vendor).each(function(i, val){
            if($(this).is(':checked')){
                transactionCodes.push($(this).val());
            }
        });

        data.remarks = $('#gen_invoice_remarks').val();
        //data.transactionMode = $('#gen_invoice_t_mode').val();
        data.transactionMode = 'CASH';
        data.transactionCodes = transactionCodes.join(',');
        
        data.itemDetailList = [];
        $.each($('#article-table tbody tr').not(':last-child'), function(){
            if($(this).find('#ext-item-amount').val() > 0){
                var item_detail = {};
                
                item_detail.code = '';
                item_detail.activeFlag = 1;

                item_detail.name = $(this).find('#ext-item-name').val();
                item_detail.value = $(this).find('#ext-item-amount').val();
                item_detail.transactionType = $(this).find('#ext-item-trans-type').val();
                item_detail.paymentTransaction = {};
            
                data.itemDetailList.push(item_detail);
            }
        });

        data.vendorBillingAddress = {};
        data.vendorBillingAddress.code = $('#gen_invoice_address').val();

        var err = 0;
        $('#invoice-dialog .inp_error').removeClass('inp_error');

        if (data.vendorBillingAddress.code == '') {
            $('#gen_invoice_address').addClass('inp_error');
            err++;
        }

        if ($('#article-table tbody tr').length >= 1) {
            $.each($('#article-table tbody tr').not(':last-child'), function(){
                if($(this).find('#ext-item-amount').val() > 0){
                    if($(this).find('#ext-item-name').val() == ''){
                        $(this).find('#ext-item-name').addClass('inp_error');
                        err++;
                    }else{
                        $(this).find('#ext-item-name').removeClass('inp_error');
                    }

                    if($(this).find('#ext-item-amount').val() == ''){
                        $(this).find('#ext-item-amount').addClass('inp_error');
                        err++;
                    }else{
                        $(this).find('#ext-item-amount').removeClass('inp_error');
                    }

                    if($(this).find('#ext-item-trans-type').val() == ''){
                        $(this).find('#ext-item-trans-type').addClass('inp_error');
                        err++;
                    }else{
                        $(this).find('#ext-item-trans-type').removeClass('inp_error');
                    }
                }
            });
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
            url: base_url + 'cargo/pay-generated-invoice',
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

    function getVendorAllAddress(code) {
        var data = {};
        data.vendorCode = code;
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
<?php echo '</script'; ?>
><?php }
}
