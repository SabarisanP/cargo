<div class="brand_top">
    <h3>Payment Receipt</h3>
    <div class="text-right noprint">
        <a href="javascript:;" class="btn btn-primary hide" onclick="revertReceiptDialog();" id="revert-rcpt-btn">Revert Receipt</a>
        {if $action_rights['PYRCT-ADD']>0}
        <a href="javascript:;" class="btn btn-success" onclick="generatePaymentReceipt();">Add New Receipt</a>
        {/if}
    </div>

    <div class="row">
        <div class="col-md-12 note text-muted">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            To record agent / branch / indent users payment receipts in to system. It will adjust active outstanding voucher dues and user balance respectively for the specified user.
        </div>
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
                                        <div id="search-panel">
                                            <form id="payment_receipt_form" name="payment_receipt_form" method="post" onsubmit="return false;">
                                                <div class="row">
                                                    <div class="form-group col-md-2">
                                                        <label for="payment_receipt_from">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="from" class="form-control sdate" id="payment_receipt_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="payment_receipt_to">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="to" class="form-control sdate" id="payment_receipt_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    {if $action_rights['PYRCT-ALL-USER']>0}
                                                        <div class="col-lg-2 w-auto">
                                                            <div>
                                                                <label for="receipt-user">Receipt to</label>
                                                                <span class="radio d-inline-block">
                                                                    <label><input type="radio" name="payment_receipt_to" value="RCPTUSER" checked> Receipt User</label>
                                                                </span>&nbsp;
                                                                <span class="radio d-inline-block">
                                                                    <label><input type="radio" name="payment_receipt_to" value="VENUSER"> Vendor User</label>
                                                                </span>&nbsp;
                                                                <span class="radio d-inline-block">
                                                                    <label><input type="radio" name="payment_receipt_to" value="VENDOR"> Vendor</label>
                                                                </span>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-2 cont" style="display: none;">
                                                            <div>
                                                                <label for="payment_receipt_user" class="d-inline-block">Receipt User </label> <i class="fa fa-info-circle" data-toggle="tooltip" title="Users with Post Paid Payment Type"></i> 
                                                                <select id="payment_receipt_user" class="form-control" name='userCode'>
                                                                    <option value="NA">All Users</option>
                                                                    {foreach name=o item=row from=$users['POT']}
                                                                        <optgroup label="{$row['groupname']}">
                                                                            {foreach name=o item=usr from=$row["users"]}
                                                                                <option value='{$usr['code']}'>{$usr['name']}</option>
                                                                            {/foreach}
                                                                        </optgroup>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-2 cont" style="display: none;">
                                                            <div>
                                                                <label for="payment_vendor_user" class="d-inline-block">Vendor User </label> <i class="fa fa-info-circle" data-toggle="tooltip" title="Users with Unlimited Payment Type"></i>
                                                                <select id="payment_vendor_user" class="form-control" name='userCode'>
                                                                    <option value="NA">All Users</option>
                                                                    {foreach name=o item=row from=$users['ULTED']}
                                                                        <optgroup label="{$row['groupname']}">
                                                                            {foreach name=o item=usr from=$row["users"]}
                                                                                <option value='{$usr['code']}'>{$usr['name']}</option>
                                                                            {/foreach}
                                                                        </optgroup>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-2 cont" style="display: none;">
                                                            <div>
                                                                <label for="payment_receipt_vendor">Vendor</label>
                                                                <select id="payment_receipt_vendor" class="form-control col-md-6">
                                                                    <option value="NA">All Vendors</option>
                                                                    {foreach item=vendor_usr from=$vendors}
                                                                        {if $vendor_usr->activeFlag == 1}
                                                                            <option value="{$vendor_usr->user->code}">{$vendor_usr->companyName}</option>
                                                                        {/if}
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    {/if}

                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <button class="btn btn-success" type="button" onclick="searchPaymentReceipt()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearPaymentReceipt()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="payment_receipt_state"></div>
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

                <div class="row hidden" id="payment-receipt-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="tabbable">
                                    <ul class="nav nav-tabs" id="payment_receipt_tabs">
                                        <li class="active" data-status="ACKED">
                                            <a data-toggle="tab" href="#tab_acknowledged">Acknowledged</a>
                                        </li>
                                        <li data-status="PAID">
                                            <a data-toggle="tab" href="#tab_waiting_acknowledgement">Waiting Acknowledgement</a>
                                        </li>
                                        <li data-status="INITD">
                                            <a data-toggle="tab" href="#tab_waiting_payment">Initiated</a>
                                        </li>
                                    </ul>
                                    <div class="tab-content" id="payment_receipt_tabs_cont">
                                        <div id="tab_acknowledged" class="tab-pane fade in active" data-tabstatus="ACKED"></div>
                                        <div id="tab_waiting_acknowledgement" class="tab-pane fade" data-tabstatus="PAID"></div>
                                        <div id="tab_waiting_payment" class="tab-pane fade" data-tabstatus="INITD"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_payment_receipt" id="ifrm_payment_receipt" style="display:none"></iframe>

<div id="payment-receipt-dialog" class="hide dialog-content-page">
    <div class="">

        <form role="form" id="form1" class="form-horizontal ">

            <div class="col-lg-12 p_l_n">
                <div class="heading_b">Add Payment Receipt</div>
            </div>

            {if $action_rights['PYRCT-ALL-USER']>0}
                <div class="col-lg-5 p_l_n">
                    <div>
                        <label for="receipt-user" class="req">Receipt to</label>
                        <span class="radio d-inline-block">
                            <label><input type="radio" name="receipt_to" value="RCPTUSER" checked> Receipt User</label>
                        </span>&nbsp;
                        <span class="radio d-inline-block">
                            <label><input type="radio" name="receipt_to" value="VENUSER"> Vendor User</label>
                        </span>&nbsp;
                        <span class="radio d-inline-block">
                            <label><input type="radio" name="receipt_to" value="VENDOR"> Vendor</label>
                        </span>
                    </div>
                </div>

                <div class="col-lg-4 p_l_n cont" style="display: none;">
                    <div>
                        <label for="receipt-user" class="req d-inline-block">Receipt to User</label> <i class="fa fa-info-circle" data-toggle="tooltip" title="Users with Post Paid Payment Type"></i> 
                        <select id="receipt-user" class="form-control col-md-6">
                            <option value="">Select a user</option>
                            {foreach name=o item=row from=$users['POT']}
                                <optgroup label="{$row['groupname']}">
                                    {foreach name=o item=usr from=$row["users"]}
                                        <option value="{$usr['code']}">{$usr['name']}</option>
                                    {/foreach}
                                </optgroup>
                            {/foreach}
                        </select>
                    </div>
                </div>
                
                <div class="col-lg-4 p_l_n cont" style="display: none;">
                    <div>
                        <label for="receipt-user-vendor" class="req d-inline-block">Receipt to Vendor User</label> <i class="fa fa-info-circle" data-toggle="tooltip" title="Users with Unlimited Payment Type"></i>
                        <select id="receipt-user-vendor" class="form-control col-md-6">
                            <option value="">Select a user</option>
                            {foreach name=o item=row from=$users['ULTED']}
                                <optgroup label="{$row['groupname']}">
                                    {foreach name=o item=usr from=$row["users"]}
                                        <option value="{$usr['code']}">{$usr['name']}</option>
                                    {/foreach}
                                </optgroup>
                            {/foreach}
                        </select>
                    </div>
                </div>

                <div class="col-lg-4 p_l_n cont" style="display: none;">
                    <div>
                        <label for="receipt-vendor" class="req">Receipt to Vendor</label>
                        <select id="receipt-vendor" class="form-control col-md-6">
                            <option value="">Select a Vendor</option>
                            {foreach item=vendor_usr from=$vendors}
                                {if $vendor_usr->activeFlag == 1}
                                    <option value="{$vendor_usr->user->code}">{$vendor_usr->companyName}</option>
                                {/if}
                            {/foreach}
                        </select>
                    </div>
                </div>
            {else}
                {$usr_login_name}
                <input type="hidden" value="{$usr_login_id}" id="receipt-user" />
                <input type="radio" class="hide" name="receipt_to" value="RCPTUSER" checked>
            {/if}

            <div class="col-lg-3 p_l_n">
                <div>
                    <label for="receipt-mode" class="req">Payment Mode</label>
                    <select id="receipt-mode" class="form-control col-md-6">
                        <option value="">Select a mode</option>
                        {foreach name=o item=row from=$t_mode}
                            {if $row->code != 'CCD'}
                                <option value="{$row->code}">{$row->name}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>
            </div>

            <div class="clear_fix_both"></div>
            <br />

            <div class="col-lg-4 p_l_n">
                <div>
                    <label for="receipt-type" class="req">Receipt Type</label>
                    <select id="receipt-type" class="form-control">
                        {foreach key=code item=name from=$payment_receipt_type}
                            {if $code != 'RVRCPT'}
                                <option value="{$code}">{$name}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>
            </div>
                   

            <div class="col-lg-4 p_l_n">
                <label for="receipt-received" class="req">Payment Received Date</label>
                <div class="input-group">
                    <input placeholder="Date Received" id="receipt-received" name="Rdate" readonly="true" class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>

            <div class="col-lg-4 p_l_n">
                <div>
                    <label for="receipt-amount" class="req">Amount</label>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-rupee"></i></span>
                        <input type="number" placeholder="Amount" id="receipt-amount" name="amt" class="form-control no-spin">
                    </div>
                </div>
            </div>

            <div class="clear_fix_both"></div>
            <br />

            <div class="col-lg-12 p_l_n">
                <div>
                    <label for="receipt-remarks">Remarks</label>
                    <textarea id="receipt-remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="2" cols="10" name="remark" id="remark" maxlength="120"></textarea>
                </div>
            </div>
            
            {include file="site/cargo/file-upload-component.tpl" id="ie-fileupload" axis="horizontal"} 

            <div class="clear_fix_both"></div>
        </form>
    </div>
    <div class="clear_fix_both"></div>
    <div>
    <div>
        <b>Notes :</b>
        <ul>
            <li><b>Inward Receipt:</b> Actual payment received from the user and credited to balance.</li>
            <li><b>Credit Note:</b> Give credit to the user's balance. Ex : Incentives, Extra Commissions etc. It's not calculated into income receipt.</li>
            <li><b>Debit Note:</b> Debits from user's balance.</li>
        </ul>
    </div>
    </div>
    <br />
    <div class="clear_fix_both">
        <div class="alert fl suc_cre" style="display: none;" id="receipt-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveReceipt();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelPaymentReceipt();">Cancel</button>
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

<div id="revert-receipt-dialog" class="hide">
    <div class="clearfix">
        <b>View Receipt</b>
        <a href="javascript:;" class="pull-right" onclick="closeRevertReceipt();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="revert-receipt-pannel" class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <div class="input-group" style="width: 30%;">
                        <input type="search" class="form-control search-box-rvt" id="revert-pay-rcpt" placeholder="Search Receipt" aria-label="Search" aria-describedby="search-addon" />
                        <span class="input-group-addon point_cur search-box-rvt" id="revert-rcpt" onclick="getReceipt()">
                            <i class="fa fa-search"></i>
                        </span>
                    </div>
                    <br>
                    <div class="table table-responsive hide" id="rvt-rcpt-payment">
                        <table class="table" id="revert-rcpt-table">
                            <tbody>
                                <tr>
                                    <th>Transaction Code</th>
                                    <td class="trns_code text-right"></td>
                                </tr>

                                <tr>
                                    <th>Transaction Date</th>
                                    <td class="trns_date text-right"></td>
                                </tr>

                                <tr>
                                    <th>Payment Mode</th>
                                    <td class="pay_mode text-right"></td>
                                </tr>

                                <tr>
                                    <th>User</th>
                                    <td class="rvt_user text-right"></td>
                                </tr>

                                <tr>
                                    <th>Amount</th>
                                    <th class="amt text-right"></th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="clear_fix_both"></div>
                    <div class=" hide" id="revert-rcpt-remark">
                        <div>
                            <label for="revert-remark">Remarks</label>
                            <textarea rows='4' class="form-control" id="revert-remark"></textarea>
                        </div>
                    </div>
                    <div class="clear_fix_both"></div>
                    <br>
                    <div class="alert hide" role="alert" id="view-receipt-cont"></div>
                </div>
            </div>

            <div class="col-md-12 text-center" id="revert-receipt-panel-btn">
                <div class="alert text-left hide" id="rvrt-rcpt-action-state" role="alert"></div>
                <input type="hidden" id="hid-rvrt-rcpt-code">
                <button type="button" class="btn btn-success hide" onclick="revertPaymentReceipt();" id="conf-revert">Confirm Revert</button>
            </div>
        </div>
    </div>
</div>

<div id="receipt-activity-dialog" class="hide">
    <a href="javascript:;" class="pull-right" onclick="hideReceiptActivity();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div id="receipt-activity-list"><br/>
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

<div id="receipt-make-payment" class="hide">
    <form role="form" class="form-horizontal">
        <br>
        <div class="col-lg-12 p_l_n p_r_n">
            <label for="pay_receipt_remarks">Remarks</label>
            <textarea id="pay_receipt_remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" maxlength="120"></textarea>
        </div>
        <div class="clear_fix_both"></div>
    </form>
    <br/>
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="receipt_pay_action_state"></div>
        <div class="align-right">
            <input type="hidden" id="hid_receipt_code"/>
            <input type="hidden" id="hid_receipt_status"/>
            <button class="btn btn-success" type="button" id="confirm-pay" onclick="confirmReceiptStatus();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelReceiptStatusDialog();">Cancel</button>
        </div>
    </div>
</div>

<script>
    {if $action_rights['PYRCT-ALL-USER']>0}
        $('#payment_receipt_user').select2();
        $('#payment_vendor_user').select2();
        $('#payment_receipt_vendor').select2();
        $('#receipt-user').select2();
        $('#receipt-user-vendor').select2();
        $('#receipt-vendor').select2();

        $('[name="receipt_to"]').on('change', function() {
            var receiptto = $('[name="receipt_to"]:checked').val();
            $('#receipt-user, #receipt-user-vendor, #receipt-vendor').closest('.cont').hide();
            if (receiptto === 'RCPTUSER') {
                $('#receipt-user').closest('.cont').show();
            } else if (receiptto === 'VENUSER') {
                $('#receipt-user-vendor').closest('.cont').show();
            } else if (receiptto === 'VENDOR') {
                $('#receipt-vendor').closest('.cont').show();
            }
        }).trigger('change');

        $('[name="payment_receipt_to"]').on('change', function() {
            var receiptto = $('[name="payment_receipt_to"]:checked').val();
            $('#payment_receipt_user, #payment_vendor_user, #payment_receipt_vendor').closest('.cont').hide();
            if (receiptto == 'RCPTUSER') {
                $('#payment_receipt_user').closest('.cont').show();
            } else if (receiptto === 'VENUSER') {
                $('#payment_vendor_user').closest('.cont').show();
            } else if (receiptto === 'VENDOR') {
                $('#payment_receipt_vendor').closest('.cont').show();
            }
        }).trigger('change');
    {/if}
</script>


{literal}
<script>
    $('[data-toggle="tooltip"]').tooltip();

    $('#payment_receipt_tabs').on('shown.bs.tab', function (e) {
        var tabId = $(e.target).attr('href')
        //if ($(tabId).is(':empty')) {
            searchPaymentReceipt();
        //}
    });

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        var target = $(e.target).attr("href")
        if(target == '#tab_acknowledged'){
            $('#revert-rcpt-btn').removeClass('hide');
        }else{
            $('#revert-rcpt-btn').addClass('hide');
        }
    });

    $('#revert-pay-rcpt').bind('keypress', function(e) {
        if(e.keyCode==13){
            getReceipt();
        }
    });

    $('#receipt-received').datepicker({
        todayHighlight: true,
        startDate: '-3m',
        endDate: '0d',
        format: 'yyyy-mm-dd',
        autoclose: true
    });

    $('#payment_receipt_from').datepicker({
        //     todayHighlight: true,
        format: 'yyyy-mm-dd',
        autoclose: true,
        startDate: '-3m',
        endDate: '+3m',
        changeMonth: true,
    }).on('changeDate', function(e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 31));
        $('#payment_receipt_to').datepicker('setStartDate', e.date);
        $("#payment_receipt_to").datepicker("setEndDate", end)
    });
    $('#payment_receipt_to').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        endDate: '+3m',
        format: 'yyyy-mm-dd',
        maxDate: "+365D",
        autoclose: true
    }).on('changeDate', function(e) {
        var fDate = new Date(e.date);
        var start = new Date(fDate.setDate(fDate.getDate() - 31));
        $('#payment_receipt_from').datepicker('setStartDate', start);
        $('#payment_receipt_from').datepicker('setEndDate', e.date)
    });

    $('#payment_receipt_from').datepicker('setDate', moment().subtract(1, 'month').toDate());
    $('#payment_receipt_to').datepicker('setDate', moment().toDate());

    var fileupload = new fileUpload('#ie-fileupload');
    
    function searchPaymentReceipt() {
        $('#payment-receipt-list').html('');
        var data = {};
        data.from = $('#payment_receipt_from').val();
        data.to = $('#payment_receipt_to').val();
        data.paymentAcknowledgeStatus = $('#payment_receipt_tabs li.active').data('status');
        var receiptto = $('[name="payment_receipt_to"]:checked').val();
        if (receiptto === 'RCPTUSER') {
            data.userRoleCode = 'USER';
            data.userCode = $('#payment_receipt_user').val();
        } else if (receiptto === 'VENUSER') {
            data.userRoleCode = 'USER';
            data.userCode = $('#payment_vendor_user').val();
        } else if (receiptto === 'VENDOR') {
            data.userRoleCode = 'CGCUST';
            data.userCode = $('#payment_receipt_vendor').val();
        }

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if (data.from == '') {
            $('#payment_receipt_from').datepicker('setDate', moment().subtract(1, 'month').toDate());
            data.from = $('#payment_receipt_from').val();
        }
        if (data.to == '') {
            $('#payment_receipt_to').datepicker('setDate', moment().toDate());
            data.to = $('#payment_receipt_to').val();
        }

        if (err > 0) {
            $('#payment_receipt_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#payment_receipt_state').html('Please enter/select the values in the field that are marked in red');
            $('#payment_receipt_state').show();
            return false;
        } else {
            $('#payment_receipt_state').removeClass('alert-success').removeClass('alert-danger');
            $('#payment_receipt_state').html('');
            $('#payment_receipt_state').hide();
        }
        $('#payment-receipt-list-container').removeClass('hidden');
        $('[data-tabstatus="' + data.paymentAcknowledgeStatus + '"]').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/payment-receipt-report-list",
            data: data,
            success: function(response) {
                $('[data-tabstatus="' + data.paymentAcknowledgeStatus + '"]').html(response);
                if(data.paymentAcknowledgeStatus == 'ACKED'){
                    $('#revert-rcpt-btn').removeClass('hide');
                }else{
                    $('#revert-rcpt-btn').addClass('hide');
                }
                
                $('#export-payment-receipt').show();
            }
        });
    }

    function clearPaymentTabs() {
        $('[data-tabstatus]').html('');
    }

    function clearPaymentReceipt() {
        clearPaymentTabs();
        $('#payment_receipt_from').datepicker('setDate', null);
        $('#payment_receipt_to').datepicker('setDate', null);
        $('#payment_receipt_user').val('NA').trigger('change');
        $('#payment_receipt_vendor').val('NA').trigger('change');
        $('#payment-receipt-list-container').addClass('hidden');
        $('.inp_error').removeClass('inp_error');
        $('#payment_receipt_state').removeClass('alert-success').removeClass('alert-danger');
        $('#payment_receipt_state').html('');
        $('#payment_receipt_state').hide();
        $('#export-payment-receipt').hide();
    }

    function exportPaymentReceipt() {
        document.payment_receipt_form.action = "cargo/payment-receipt-report-list";
        document.payment_receipt_form.target = "ifrm_payment_receipt";
        document.payment_receipt_form.submit();
        return;
    }

    function revertReceiptDialog() {
        $('#revert-receipt-dialog').css('background', '#fff');
        $('#revert-receipt-dialog').removeClass('hide');
        $('#revert-receipt-dialog').dialog({
            autoOpen: true,
            height: 560,
            width: 550,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });

        $('#revert-pay-rcpt').focus();
        $('.ui-dialog-titlebar').hide();
    }

    function closeRevertReceipt() {
        $('.trns_code, .trns_date, .pay_mode, .rvt_user, .amt, #rvrt-rcpt-action-state, #view-receipt-cont').html('');
        $('#rvt-rcpt-payment, #revert-rcpt-remark, #conf-revert, #rvrt-rcpt-action-state, #view-receipt-cont').addClass('hide');
        $('#rvrt-rcpt-action-state, #view-receipt-cont').removeClass('alert-danger alert-success')
        $('#revert-pay-rcpt, #revert-remark, #hid-rvrt-rcpt-code').val('');
        $('#revert-receipt-dialog').dialog('destroy');
        $('#revert-receipt-dialog').hide();
    }

    function getReceipt(){
        $('#view-receipt-cont').addClass('hide').html('');
        $('#rvrt-rcpt-action-state').addClass('hide').html('');

        var data = {};
        data.receiptCode = $.trim($('#revert-pay-rcpt').val());

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if ($('#revert-pay-rcpt').val() == '') {
            $('#revert-pay-rcpt').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            return false;
        }
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/get-payment-receipt-revert",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    var res = response.data;
                    if(res.paymentAcknowledgeStatus.code == 'ACKED' && res.paymentReceiptType.code != 'RVRCPT'){
                        $('#rvt-rcpt-payment, #revert-rcpt-remark, #conf-revert').removeClass('hide');
                        $('#hid-rvrt-rcpt-code').val(res.code);

                        $('.trns_code').text(res.code);
                        $('.trns_date').text(moment(res.transactionDate).format('DD-MM-YYYY'));
                        $('.pay_mode').text(res.transactionMode.name);
                        $('.rvt_user').text(res.user.name);
                        $('.amt').text('Rs '+res.balanceAmount.toFixed(2));
                    }else{
                        $('#rvt-rcpt-payment, #revert-rcpt-remark, #conf-revert').addClass('hide');
                        $('#view-receipt-cont').removeClass('hide');
                        $('#view-receipt-cont').addClass('alert-danger');
                        $('#view-receipt-cont').html('Revert can not be performed for receipts with status other than ACKNOWLEDGED or already reverted receipt !!');
                    }
                    
                } else {
                    $('#view-receipt-cont').removeClass('hide');
                    $('#view-receipt-cont').addClass('alert-danger');
                    $('#rvt-rcpt-payment, #revert-rcpt-remark, #conf-revert').addClass('hide');
                    $('#view-receipt-cont').html(response.errorDesc);
                }
            }
        })
    }

    function revertPaymentReceipt(){
        var data = {};
        data.code = $('#hid-rvrt-rcpt-code').val();
        data.remarks = $('#revert-remark').val();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/revert-payment-receipt",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#rvrt-rcpt-action-state').removeClass('hide');
                    $('#rvrt-rcpt-action-state').removeClass('alert-danger');
                    $('#rvrt-rcpt-action-state').addClass('alert-success');
                    $('#rvrt-rcpt-action-state').html('Receipt reverted successfully.');
                    
                    setTimeout(function() {
                        $('#rvrt-rcpt-action-state').addClass('hide');
                        closeRevertReceipt();
                        checkURL();
                    }, 1000);
                } else {
                    $('#rvrt-rcpt-action-state').removeClass('hide');
                    $('#rvrt-rcpt-action-state').addClass('alert-danger');
                    $('#rvrt-rcpt-action-state').html(response.errorDesc + " "+ response.data);
                }
            }
        })
    }

    function generatePaymentReceipt() {
        $('.inp_error').removeClass('inp_error');
        $('#receipt-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#receipt-action-state').hide();
        $('#payment-receipt-dialog').css('background', '#fff');
        $('#payment-receipt-dialog').removeClass('hide');
        $('#payment-receipt-dialog').dialog({
            autoOpen: true,
            height: 575,
            width: 770,
            modal: true,
            resizable: false,
            open: function() {
                if ($.ui && $.ui.dialog && !$.ui.dialog.prototype._allowInteractionRemapped && $(this).closest(".ui-dialog").length) {
                    if ($.ui.dialog.prototype._allowInteraction) {
                        var ui_dialog_interaction = $.ui.dialog.prototype._allowInteraction;
                        $.ui.dialog.prototype._allowInteraction = function(e) {
                            if ($(e.target).closest('.select2-drop').length) return true;
                            return ui_dialog_interaction.apply(this, arguments);
                        };
                        $.ui.dialog.prototype._allowInteractionRemapped = true;
                    }
                }
            },
            _allowInteraction: function(event) {
                return !!$(event.target).is(".select2-input") || this._super(event);
            }
        });
        $(".ui-dialog-titlebar").hide();

        $('#receipt-remarks').val('');
        $('#receipt-received').val('');
        $('#receipt-amount').val('');
        $('#receipt-mode').val('');
        $('#receipt-type').val('COLN');

        if (menu_permission['PYRCT-ALL-USER'] == 1) {
            $('#receipt-user').val('').trigger('change');
            $('#receipt-user-vendor').val('').trigger('change');
            $('#receipt-vendor').val('').trigger('change');
            $('[name="receipt_to"][value="RCPTUSER"]').prop('checked', true).trigger('change');
        }

        if( $('#receipt-user').attr('type') != "hidden")  { // Dont reset if permission not available.
            $('#receipt-user').val('').trigger('change');
        }

        $('#form-bttons').show();
        $('#receipt-action-state').html('');
        $('#receipt-action-state').hide();
        $('.inp_error').removeClass('inp_error');
        fileupload.clearFiles();
    }

    function cancelPaymentReceipt() {
        $('#payment-receipt-dialog').dialog('destroy');
        $('#payment-receipt-dialog').hide();
    }

    function saveReceipt() {
        var data = {};

        data.activeFlag = 1;
        data.remarks = $('#receipt-remarks').val();
        data.amountReceivedDate = $('#receipt-received').val();
        data.transactionAmount = $('#receipt-amount').val();
        data.transactionMode = {};
        data.transactionMode.code = $('#receipt-mode').val();
        data.paymentReceiptType = {};
        data.paymentReceiptType.code = $('#receipt-type').val();
        data.user = {};
        
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        var receiptto = $('[name="receipt_to"]:checked').val();
        if (receiptto === 'RCPTUSER') {
            data.user.code = $('#receipt-user').val();
            if ($('#receipt-user').val() == '') {
                $('#receipt-user').addClass('inp_error');
                err++;
            }
        } else if (receiptto === 'VENUSER') {
            data.user.code = $('#receipt-user-vendor').val();
            if ($('#receipt-user-vendor').val() == '') {
                $('#receipt-user-vendor').addClass('inp_error');
                err++;
            }
        } else if (receiptto === 'VENDOR') {
            data.user.code = $('#receipt-vendor').val();
            if ($('#receipt-vendor').val() == '') {
                $('#receipt-vendor').addClass('inp_error');
                err++;
            }
        }

        if ($('#receipt-received').val() == '') {
            $('#receipt-received').addClass('inp_error');
            err++;
        }
        if ($('#receipt-amount').val() == '' || Number(data.transactionAmount) <= 0) {
            $('#receipt-amount').addClass('inp_error');
            err++;
        }
        if ($('#receipt-mode').val() == '') {
            $('#receipt-mode').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#receipt-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#receipt-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#receipt-action-state').show();
            return false;
        } else {
            $('#receipt-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#receipt-action-state').hide();
        }

        if (Number(data.transactionAmount) > 5000000) {
            $('#amt').addClass('inp_error');
            $('#receipt-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#receipt-action-state').html('Sorry! Maximum receipt amount per transaction is 50L');
            $('#receipt-action-state').show();
            return false;
        }

        $('#form-bttons').hide();
        $('#receipt-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#receipt-action-state').html(loading_popup);
        $('#receipt-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-payment-receipt",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#receipt-action-state').removeClass('alert-danger');
                    $('#receipt-action-state').addClass('alert-success');
                    $('#receipt-action-state').html('Receipt added successfully.');
                    
                    setTimeout(function() {
                        $('#receipt-action-state').hide();
                        fileupload.startUpload({
                            referenceCode: response.data.code, 
                            imageCategoryCode: 'RECPT',
                            onComplete: function() {
                                clearPaymentTabs();
                                $('[data-status="' + response.data.paymentAcknowledgeStatus.code + '"] a').tab('show');
                                searchPaymentReceipt();
                                cancelPaymentReceipt();
                            }
                        });
                    }, 1000);
                } else {
                    $('#receipt-action-state').addClass('alert-danger');
                    $('#receipt-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        })
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
    
    function closeUnpaidPartialInfo() {
        $('#unpaid-info-dialog').dialog('close');
    }

    function receiptStatusDialog(code, status) {
        $('#hid_receipt_code').val(code);
        $('#hid_receipt_status').val(status);
        $('#pay_receipt_remarks').val('');

        $('#receipt_pay_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#receipt_pay_action_state').html('').hide();

        $('#receipt-make-payment').css('background', '#fff');
        $('#receipt-make-payment').removeClass('hide');
        $('#receipt-make-payment').dialog({
            autoOpen: true,
            height: 405,
            width: 450,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
    }

    function cancelReceiptStatusDialog() {
        $('#confirm-pay').attr('disabled', false);
        $('#receipt-make-payment').dialog('close');
    }

    function confirmReceiptStatus() {
        $('#confirm-pay').attr('disabled', true);
        var data = {};

        data.code = $('#hid_receipt_code').val();
        data.remarks = $.trim( $('#pay_receipt_remarks').val());
        data.paymentAcknowledgeStatus = {};
        data.paymentAcknowledgeStatus.code = $('#hid_receipt_status').val();

        var err = 0;

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

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-payment-receipt-status",
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
                        searchPaymentReceipt();
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
        var receipt = _.find(paymentReceiptData, i => i.code == code);

        if (!receipt) {
            return;
        }

        var $tpl = $($('#receipt-activity-tpl').html());
        var $list = $('#receipt-activity-timeline').html('');

        $.each(receipt.auditLog || [], function (i, log) {
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

    function hideReceiptActivity () {
        $('#receipt-activity-dialog').dialog('close');
    }
    
    function showPRGallery (code) {
        fileupload.showGalleryDialog({
            referenceCode: code,
            imageCategoryCode: 'RECPT'
        });
    }
</script>
{/literal}