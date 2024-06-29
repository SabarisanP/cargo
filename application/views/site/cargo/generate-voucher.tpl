<div class="brand_top">
    <h3>Generate Voucher</h3>
    <span class="align-right">
        <a href="#cargo/voucher" class="btn btn-success btn-sm"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;Back</a>
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
                                                <form id="gen_voucher_form" method="post" name="gen_voucher_form" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="gen_voucher_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="gen_voucher_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="gen_voucher_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="gen_voucher_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="gen_voucher_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="gen_voucher_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        {if $action_rights['CGO-VOU-ALL-BRANCH']==1}
                                                        <div class="form-group col-md-2">
                                                            <label for="gen_voucher_branch_code">Collected Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="gen_voucher_branch_code" name="branchCode"  class="form-control" onchange="updateBranchuser(this);">
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
                                                            <label for="gen_voucher_user_code">Collected Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="gen_voucher_user_code" name="userCode"  class="form-control" >
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
                                                                <button type="button" class="btn btn-success" onclick="getVoucherList();">Get Transactions</button>&nbsp;
                                                                <button type="button" class="btn btn-default" onclick="clearVoucher();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="gen_voucher_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="gen-voucher-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="gen-voucher-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="voucher-dialog" class="hide dialog-content-page">
    <div class="ov_fl_262">
        <form role="form" id="form1" class="form-horizontal">
            <div class="col-lg-12 p_l_n p_r_n">
                <label for="txt_l_name">Voucher To ( <span id="vouch_head"></span> )</label>
                <label for="txt_l_name" id="vouch_to" style="font-weight:lighter"></label>
            </div>
            <div class="clear_fix_both"></div>
            <br/>
            <div class="col-lg-12 p_l_n p_r_n">
                <div>
                    <label for="gen_voucher_t_mode" class="req">Transaction Mode</label>
                    <select id="gen_voucher_t_mode" class="form-control col-md-6">
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
                    <label for="gen_voucher_remarks">Remarks</label>
                    <textarea id="gen_voucher_remarks"  placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" id="remark"></textarea>
                </div>
            </div>
            <div class="clear_fix_both"></div>
        </form>
    </div>
    <div class="fr"> <b>Payable Amount :</b> <i class="fa fa-inr"></i>&nbsp; <span class="vou_btn gen_voucher_pay_amt">0.00</span></div>
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="pay_voucher_action_state"></div>
        <div class="align-right" id="form-bttons">
            <button class="btn btn-success" type="button" id="confirm-pay" onclick="confirmVoucher();">Generate</button>
            <button class="btn btn-default" type="button" onclick="closeVoucherPopup();">Cancel</button>
        </div>
    </div>
</div>

<script>
    $('#gen_voucher_from').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        startDate: '-6m',
        endDate: '+1D',
        changeMonth: true
    }).on('changeDate', function (e) {
        $('#gen_voucher_to').datepicker('setStartDate', e.date);
    });
    $('#gen_voucher_to').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        endDate: '+1D',
        autoclose: true
    }).on('changeDate', function (e) {
        $('#gen_voucher_from').datepicker('setEndDate', e.date);
    });

    function updateBranchuser(ele) {
        var branch = $(ele).val();
        
        if(branch == 'NA'){
            $('#gen_voucher_user_code option').attr('selected', false).show();
        } else {
            $('#gen_voucher_user_code option').each(function () {
                $(this).attr('selected', false);
                if ($(this).data('branch') == branch) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        $('#gen_voucher_user_code option[value="NA"]').attr('selected', true).show();
    }

    function getVoucherList() {
        var data = {};
        data.fromDate = $('#gen_voucher_from').val();
        data.toDate = $('#gen_voucher_to').val();
        data.userCode = $('#gen_voucher_user_code').val();
        data.organizationCode = $('#gen_voucher_branch_code').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if (data.fromDate == '') {
            $('#gen_voucher_from').addClass('inp_error');
            err++;
        }

        if (data.toDate == '') {
            $('#gen_voucher_to').addClass('inp_error');
            err++;
        }
        
        if(menu_permission['CGO-GEN-VOU-OPT-DR'] == 1) {
            if (data.fromDate == '' && data.toDate == '') {
                $('#gen_voucher_from').removeClass('inp_error');
                $('#gen_voucher_to').removeClass('inp_error');
                data.fromDate = 'NA';
                data.toDate = 'NA';
                err = err - 2;
            }
        }

        if (err > 0) {
            $('#gen_voucher_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#gen_voucher_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#gen_voucher_action_state').show();
            return false;
        } else {
            $('#gen_voucher_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#gen_voucher_action_state').html('');
            $('#gen_voucher_action_state').hide();
        }

        $('#gen-voucher-list-container').removeClass('hidden');
        $('#gen-voucher-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/get-voucher-list',
            data: data,
            success: function (response) {
                $('#gen-voucher-list').html(response);
                $('html, body').animate({
                    scrollTop: $('#gen-voucher-list-container').offset().top - 35
                }, 'slow');
            }
        });
    }

    function clearVoucher() {
        $('.inp_error').removeClass('inp_error');
        $('#gen_voucher_from').val('');
        $('#gen_voucher_to').val('');
        $('#gen_voucher_branch_code').val('NA');
        $('#gen_voucher_user_code').val('NA');
        $('#gen-voucher-list').html('');
        $('#gen-voucher-list-container').addClass('hidden');
        $('#gen_voucher_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#gen_voucher_action_state').html('').hide();
    }

    function voucherPopup(org, user, name = '') {
        if(org != '' && user == ''){
            if (!$('.gen_voucher_check.' + org + ':checked').length) {
                alert('Please select one or more Transactions');
                return;
            }
            $('.gen_voucher_pay_amt').html($('#amount-'+org).html());
            $('#vouch_head').html('Branch');
            $('#vouch_to').html(name);
        } else if(org != '' && user != '') {
            if(!$('.gen_voucher_check.' + org + '.' + user + ':checked').length) {
                alert('Please select one or more Transactions');
                return;
            }
            $('.gen_voucher_pay_amt').html($('#amount-'+org+'-'+user).html());
            $('#vouch_head').html('User');
            $('#vouch_to').html(name);
        }
        $('#confirm-pay').attr('onclick', "confirmVoucher('"+org+"','"+ user+"');");

        $('#voucher-dialog').css('background', '#fff');
        $('#voucher-dialog').removeClass('hide');
        $('#voucher-dialog').dialog({
            autoOpen: true,
            height: 475,
            width: 450,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
    }

    function closeVoucherPopup() {
        $('#voucher-dialog').dialog('destroy');
        $('#voucher-dialog').hide();
        $('#gen_voucher_t_mode').val('');
        $('#gen_voucher_remarks').val('');
        $('#voucher-dialog .inp_error').removeClass('inp_error');
        $('#pay_voucher_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#pay_voucher_action_state').hide();
    }

    function confirmVoucher(org, user) {
        var data = {};

        transactionCodes = [];
        if(org != '' && user == ''){
            $('.gen_voucher_check.'+org).each(function(i, val){
                if($(this).is(':checked')){
                    transactionCodes.push($(this).val());
                }
            });
        } else if(org != '' && user != '') {
            $('.gen_voucher_check.'+org+'.'+user).each(function(i, val){
                if($(this).is(':checked')){
                    transactionCodes.push($(this).val());
                }
            });
        }
        
        data.remarks = $('#gen_voucher_remarks').val();
        data.transactionMode = $('#gen_voucher_t_mode').val();
        data.transactionCodes = transactionCodes.join(',');
        data.userCode = voucherUserCode;
        data.organizationCode = voucherOrganizationCode;

        var err = 0;
        $('#voucher-dialog .inp_error').removeClass('inp_error');

        if (data.transactionMode == '') {
            $('#gen_voucher_t_mode').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#pay_voucher_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#pay_voucher_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#pay_voucher_action_state').show();
            return false;
        }
        
        $('#pay_voucher_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#pay_voucher_action_state').html(loading_popup).show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/pay-generated-voucher',
            data: data,
            success: function (response) {
                if(response.status == 1){
                    $('#pay_voucher_action_state').addClass('alert-success');
                    $('#pay_voucher_action_state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        closeVoucherPopup();
                        getVoucherList();
                    }, 3000);
                } else {
                    $('#pay_voucher_action_state').addClass('alert-danger');
                    $('#pay_voucher_action_state').html(response.errorDesc);
                }
            }
        });
    }
</script>