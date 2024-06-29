<div class="brand_top">
    <h3>Cheque</h3>
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
                                            <form id="cheque-report-form" name="cheque-report-form" method="post" onsubmit="return false">
                                                <div class="row">
                                                    <div class="form-group col-md-3">
                                                        <label for="cheque-date">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="daterange" class="form-control sdate" id="cheque-date" readonly placeholder="Date Range">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="cheque-status">Cheque Status</label>
                                                        <select class="form-control" id="cheque-status">
                                                            <option value="NA">All Status</option>
                                                            {foreach from=$cheque_status item=name key=code}
                                                                <option value="{$code}">{$name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="cheque-branch">Branch</label>
                                                        <select id="cheque-branch" class="form-control" {if $action_rights['EBL-ALL-BRANCH'] != 1}disabled="disabled"{/if}>
                                                            <option value="NA">All Branch</option>
                                                            {foreach from=$organizations item=row}
                                                                <option value="{$row->code}" {if $logged_in_usr_org_code == $row->code}selected{/if}>{$row->name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <button class="btn btn-success" type="button"  onclick="generateChequeList()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearChequeList()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="cheque-action-state"></div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="cheque-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="cheque-list"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="edit-status-dialog"  class="dialog-content-page hide">
    <div class="row">
        <div class="col-md-10 bold ft_14">
            Edit Cheque Status 
        </div><br><br>
    </div>
    <div>
        <div class="row">
            <div class="col-lg-4">
                <div class="form-group text-left">
                    <label for="edt-cheque-status" class="req">Cheque Status</label>
                    <select class="form-control" id="edt-cheque-status">
                        <option value="">Select Status</option>
                        <option value="NEW">New</option>
                        <option value="DPST">Deposit</option>
                        <option value="CRDT">Credit / Realize</option>
                        <option value="HOLD">Hold</option>
                        <option value="BNCE">Bounce / Return</option>
                        <option value="REPST">Represent</option>
                    </select>
                </div>
            </div> 

            <div class="form-group col-md-4 other-transaction-mode">
                <label class="req" for="cheque-rcvd-date">Amount Received Date</label>
                <div class="input-group">
                    <input type="text" class="form-control sdate" id="cheque-rcvd-date" readonly placeholder="Amount Received Date">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>

            <div class="col-md-4 hide other-transaction-mode">
                <div class="form-group">
                    <label class="req" for="cheque-other-txn-mode">Transaction Mode</label>
                    <select id="cheque-other-txn-mode" class="form-control">
                        <option value="">Select Transaction Mode</option>
                        {foreach from=$transactionmode item=val key=k}
                            <option value="{$k}">{$val}</option>
                        {/foreach}
                    </select>
                </div>
            </div>

            {* UPI *}
            <div class="hide" id="cheque-upi">
                <div class="form-group col-md-4">
                    <label class="req" for="cheque-bank-details">Organization Bank</label>
                    <select id="cheque-bank-details" class="form-control">
                        <option value="">Select a Bank</option>
                        {foreach from=$bank_detail->bankDetails item=val}
                            {if $val->accountType->code != 'CASH'}
                            <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>

                <div class="form-group col-md-4">
                    <label class="req" for="cheque-upi-id">UPI Id</label>
                    <input type="text" class="form-control" id="cheque-upi-id" placeholder="UPI ID">
                </div>

                <div class="form-group col-md-4">
                    <label for="cheque-upi-details">Ref. #</label>
                    <input type="text" class="form-control" id="cheque-upi-details" placeholder="Ref. #">
                </div>
            </div>

            {* NBK *}
            <div class="hide" id="cheque-nbk">
                <div class="form-group col-md-4">
                    <label class="req" for="cheque-bank-nbk">Organization Bank</label>
                    <select id="cheque-bank-nbk" class="form-control">
                        <option value="">Select a Bank</option>
                        {foreach from=$bank_detail->bankDetails item=val}
                            {if $val->accountType->code != 'CASH'}
                            <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>

                <div class="form-group col-md-4">
                    <label class="req" for="cheque-acc-hold-name">Account Holder Name</label>
                    <input type="text" class="form-control" id="cheque-acc-hold-name" placeholder="Account Holder Name">
                </div>

                <div class="form-group col-md-4" id="cheque-bank-name-div">
                    <label class="req" for="cheque-bank-name">Bank Name</label>
                    <input type="text" class="form-control" id="cheque-bank-name" placeholder="Bank Name">
                </div>

                <div class="form-group col-md-4">
                    <label for="cheque-nbk-details">Ref. #</label>
                    <input type="text" class="form-control" id="cheque-nbk-details" placeholder="Ref. #">
                </div>
            </div> 

            {* chq *}
            <div class="hide" id="cheque-chq">
                <div class="form-group col-md-4">
                    <label class="req" for="cheque-payer">Payer Details</label>
                    <input type="text" class="form-control" id="cheque-payer" placeholder="Payer Details">
                </div>

                <div class="form-group col-md-4">
                    <label class="req" for="cheque-chq-num">Cheque No</label>
                    <input type="text" class="form-control" id="cheque-chq-num" placeholder="Cheque Number">
                </div>

                <div class="form-group col-md-4">
                    <label class="req" for="cheque-chq-date">Cheque Date</label>
                    <div class="input-group">
                        <input type="text" class="form-control sdate" id="cheque-chq-date" readonly placeholder="Cheque Date">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>

                <div class="form-group col-md-4" id="cheque-chq-bankname-div">
                    <label class="req" for="cheque-chq-bankname">Bank Name</label>
                    <input type="text" class="form-control" id="cheque-chq-bankname" placeholder="Bank Name">
                </div>

                <div class="form-group col-md-4">
                    <label class="req" for="cheque-chq-city">Bank City</label>
                    <input type="text" class="form-control" id="cheque-chq-city" placeholder="Bank City">
                </div>
            </div>
                     
            <div class="hide" id="deposit-sect">
                <div class="col-lg-4">
                    <div class="form-group">
                        <label class="req" for="edt-cheque-deposit-date">Deposit Date</label>
                        <div class="input-group">
                            <input type="text" name="depositDate" class="form-control sdate" id="edt-cheque-deposit-date" readonly placeholder="Deposit Date">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div>
                </div>

                <div class="form-group col-lg-4">
                    <label class="req" for="edt-cheque-bank">Bank Details</label>
                    <select id="edt-cheque-bank" class="form-control">                                                                    
                        <option value="">Select a Bank</option>
                        {foreach from=$bank_detail->bankDetails item=val}
                            {if $val->accountType->code != 'CASH'}
                            <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                            {/if}
                        {/foreach}
                    </select>     
                </div>
            </div>

            <div class="hide" id="realize-sect">
                <div class="col-lg-4">
                    <label class="req" for="edt-cheque-credit-date">Credit Date</label>
                    <div class="input-group">
                        <input type="text" name="creditDate" class="form-control sdate" id="edt-cheque-credit-date" readonly placeholder="Credit Date">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>
                <div class="col-lg-4">
                    <label for="edt-cheque-details">Details</label>
                    <input type="text" class="form-control" id="edt-cheque-details" placeholder="Details">
                </div>
            </div>
        </div>

        <div class="row">        
            <div class="col-lg-12"> 
                <label>Remarks</label>
                <textarea id="edt-cheque-remarks"  placeholder="Enter your remarks" style="resize:none" class="form-control" rows="3" cols="30" name="remark" id="remark"></textarea>
            </div>                                 
        </div>
        <br>

        <div class="row">
            <div class="col-lg-12"> 
                <input type="hidden" id="edt-cheque-data" value="">
                <div class="clear_fix_both">                       
                    <div class="alert hide" id="edt-cheque-action-state"></div>
                    <div class="align-right" id="edt-cheque-form-buttons">                    
                        <button class="btn btn-success" type="button" onclick="updateChequeStatus();">Save</button>
                        <button class="btn btn-default" type="button" onclick="closeEditStatusDialog();">Cancel</button>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>

<div id="cheque-history-dialog"  class="dialog-content-page hide">
    <div id="cheque-history-body"></div></div>          
</div>

<iframe name="ifrm_balance_sheet" id="ifrm_balance_sheet" style="display:none"></iframe>

<script>
    var chequeStatusData = {$cheque_status|json_encode};
    var bankNamesList = {$bank_names_list|json_encode}
    var logged_user_org = {$logged_in_usr_org_code|json_encode}
    
    $('#cheque-branch').select2({
        placeholder: 'Select Branch'
    });

    $('#edt-cheque-bank, #cheque-bank-nbk, #cheque-bank-details').select2();

    $('#cheque-date').daterangepicker({
        buttonClasses: ['btn', 'btn-xs'],
        format: 'DD-MM-YYYY',
        separator: ' | ',
        ranges: {
            'Today': [moment().startOf('day'), moment().endOf('day')],
            'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
            'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
            'Last 30 Days': [moment().subtract(29, 'days').startOf('day'), moment().endOf('day')],
        },
    }).on('show.daterangepicker', function (ev, picker) {
        picker.showCalendars()
    });

    $('#edt-cheque-deposit-date, #edt-cheque-credit-date').datepicker({
        todayHighlight: true,    
        format: 'yyyy-mm-dd',
        autoclose: true,
        changeMonth: true,
        autoUpdateInput: false,
    })

    $('#cheque-chq-date, #cheque-rcvd-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true
    });
    
    $('#cheque-chq-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#cheque-chq-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#cheque-bank-name').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#cheque-bank-name-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#edt-cheque-status').on('change', function(){
        $('#deposit-sect, #realize-sect, .other-transaction-mode').addClass('hide');
        $('.cheque-advance, #cheque-chq, #cheque-upi, #cheque-nbk').addClass('hide');
        $('#cheque-other-txn-mode').val('').trigger('change');
        var status = $(this).val();

        if (status == 'CRDT') {
            $('#realize-sect').removeClass('hide');
        } else if (status == 'DPST' || status == 'REPST') {
            $('#deposit-sect').removeClass('hide');
        } else if (status == 'OTHERS') {
            $('.other-transaction-mode').removeClass('hide');
        }
    });

    $('#cheque-other-txn-mode').on('change', function(){
        $('#cheque-bank-details, #cheque-bank-nbk, #cheque-chq-bank-details, #cheque-chq-bankname').val('').trigger('change');
        $('#cheque-payer, #cheque-chq-num, #cheque-chq-date, #cheque-chq-city, #cheque-upi-id, #cheque-upi-details, #cheque-bank-name, #cheque-acc-hold-name, #cheque-nbk-details').val('');

        $('.cheque-advance, #cheque-chq, #cheque-upi, #cheque-nbk').addClass('hide');
        $('#cheque-form-buttons').removeClass('hide');
        if ($(this).val() == 'UPI') {
            $('#cheque-upi').removeClass('hide');
        } else if ($(this).val() == 'NBK') {
            $('#cheque-nbk').removeClass('hide');
        } else if ($(this).val() == 'CHEQUE') {
            $('#cheque-chq').removeClass('hide');
        }
    });

    function generateChequeList() {
        $('#cheque-list').html('');
        var data = {};
        data.daterange = $('#cheque-date').val();
        data.statusCode = $('#cheque-status').val();
        data.organizationCode = $('#cheque-branch').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if (data.daterange == '') {
            $('#cheque-date').addClass('inp_error');
            err++;
        }

        if (data.organizationCode == '') {
            $('#cheque-branch').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#cheque-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#cheque-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#cheque-action-state').show();
            return false;
        }
        
        $('#cheque-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#cheque-action-state').html('').hide();
        
        $('#cheque-list-container').removeClass('hidden');
        $('#cheque-list').html(loading_popup);
        
        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'payment/cheque-list',
            data: data,
            success: function (response) {
                $('#cheque-list').html(response);
            }
        });
    }

    function clearChequeList() {
        $('#cheque-date').val('');
        $('#cheque-status').val('NA');
        $('#cheque-branch').val('NA').trigger('change')
        $('#cheque-list-container').addClass('hidden');
        $('#cheque-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#cheque-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#cheque-action-state').html('');
        $('#cheque-action-state').hide();
    }

    function editStatusDialog(code) {
        $('#edit-status-dialog').css('background', '#fff');
        $('#edit-status-dialog').removeClass('hide');
        $('#edit-status-dialog').dialog({
            autoOpen: true,
            height: 375,
            width: 750,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
        $('#edt-cheque-data').val('');

        $('#edt-cheque-action-state').removeClass('alert-danger').addClass('hide').html('');
        $('.inp_error').removeClass('inp_error');
        $('#edt-cheque-status, #edt-cheque-deposit-date, #cheque-rcvd-date, #edt-cheque-credit-date, #edt-cheque-details, #edt-cheque-remarks').val('');
        $('#edt-cheque-bank').val('').trigger('change');
        
        if (code) {
            var data = _.find(chequeData, function(o) {
                return o.code === code;
            });
            
            $('#edt-cheque-status').html(function () {
                var options = [new Option('Select Status', '')];
                if (data.chequeStatus.code == 'NEW') {
                    options.push(new Option(chequeStatusData.DPST, 'DPST'));
                    options.push(new Option(chequeStatusData.HOLD, 'HOLD'));
                } else if(data.chequeStatus.code == 'DPST' || data.chequeStatus.code == 'REPST') {
                    options.push(new Option(chequeStatusData.CRDT, 'CRDT'));
                    options.push(new Option(chequeStatusData.BNCE, 'BNCE'));
                } else if(data.chequeStatus.code == 'HOLD') {
                    options.push(new Option(chequeStatusData.NEW, 'NEW'));
                } else if(data.chequeStatus.code == 'BNCE'){
                    options.push(new Option(chequeStatusData.REPST, 'REPST'));
                    options.push(new Option('Other Payment mode', 'OTHERS'));
                }

                return options;
            }).val('').trigger('change');

            $('#edt-cheque-data').val(code);
        }
    }

    function closeEditStatusDialog() {
        $('#edit-status-dialog').addClass('hide');
        $('#edit-status-dialog').dialog('destroy');
    }

    function updateChequeStatus() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        var data = _.find(chequeData, function(o) {
            return o.code === $('#edt-cheque-data').val();
        });

        data.chequeStatus = {};
        data.chequeStatus.code = $('#edt-cheque-status').val();

        if (data.chequeStatus.code == '') {
            $('#edt-cheque-status').addClass('inp_error');
            err++;
        }

        if (data.chequeStatus.code == 'DPST' || data.chequeStatus.code == 'REPST') {
            data.chequeDepositDate = $('#edt-cheque-deposit-date').val();

            data.namespaceBank = {};
            data.namespaceBank.code = $('#edt-cheque-bank').val();

            if (data.chequeDepositDate == '') {
                $('#edt-cheque-deposit-date').addClass('inp_error');
                err++;
            }

            if (data.namespaceBank.code == '') {
                $('#edt-cheque-bank').addClass('inp_error');
                err++;
            }
        } else if (data.chequeStatus.code == 'CRDT') {
            data.chequeRealizeDate = $('#edt-cheque-credit-date').val();
            data.chequeRealizeDetails = $('#edt-cheque-details').val();

            if (data.chequeRealizeDate == '') {
                $('#edt-cheque-credit-date').addClass('inp_error');
                err++;
            }
        } else if (data.chequeStatus.code == 'OTHERS') {
            data.transactionMode = {};
            data.transactionMode.code = $('#cheque-other-txn-mode').val();

            if (data.transactionMode.code == '') {
                $('#cheque-other-txn-mode').addClass('inp_error');
                err++;
            }
            
            // transaction mode
            if (data.transactionMode.code == 'UPI') {
                data.bankDetails = $('#cheque-bank-details').val();
                data.addAttr1 = $.trim($('#cheque-upi-id').val());
                data.addAttr2 = $.trim($('#cheque-upi-details').val());

                if (data.addAttr1 == '') {
                    $('#cheque-upi-id').addClass('inp_error');
                    err++;
                }

                if ($('#cheque-bank-details').val() == '') {
                    $('#cheque-bank-details').addClass('inp_error');
                    err++;
                }

                if (data.addAttr2 == '') {
                    $('#cheque-upi-details').addClass('inp_error');
                    err++;
                }
            } else if (data.transactionMode.code == 'NBK') {
                data.bankDetails = $('#cheque-bank-nbk').val();
                data.addAttr1 = $.trim($('#cheque-acc-hold-name').val());
                data.addAttr2 = $.trim($('#cheque-bank-name').val());
                data.addAttr3 = $.trim($('#cheque-nbk-details').val());

                if (data.addAttr1 == '') {
                    $('#cheque-acc-hold-name').addClass('inp_error');
                    err++;
                }

                if (data.addAttr2 == '') {
                    $('#cheque-bank-name').addClass('inp_error');
                    err++;
                }

                if ($('#cheque-bank-nbk').val() == '') {
                    $('#cheque-bank-nbk').addClass('inp_error');
                    err++;
                }

                if (data.addAttr3 == '') {
                    $('#cheque-nbk-details').addClass('inp_error');
                    err++;
                }
            } else if (data.transactionMode.code == 'CHEQUE') {
                data.chequeDetails = {};
                data.chequeDetails.code = $('#cheque-chq-code').val();
                data.chequeDetails.activeFlag = 1;

                data.chequeDetails.organization = {};
                data.chequeDetails.organization.code = logged_user_org;

                data.chequeDetails.bankDetails = $.trim($('#cheque-chq-bankname').val());

                data.chequeDetails.payerDetails = $.trim($('#cheque-payer').val());

                data.chequeDetails.chequeDate = moment($('#cheque-chq-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                data.chequeDetails.chequeNo = $.trim($('#cheque-chq-num').val());
                data.chequeDetails.bankCity = $.trim($('#cheque-chq-city').val());

                data.chequeDetails.chequeStatus = {};
                data.chequeDetails.chequeStatus.code = 'NEW';

                data.chequeDetails.remarks = '';

                if (data.chequeDetails.payerDetails == '') {
                    $('#cheque-payer').addClass('inp_error');
                    err++;
                }

                if ($('#cheque-chq-date').val() == '') {
                    $('#cheque-chq-date').addClass('inp_error');
                    err++;
                }

                if (data.chequeDetails.chequeNo == '') {
                    $('#cheque-chq-num').addClass('inp_error');
                    err++;
                }

                if (data.chequeDetails.bankDetails == '') {
                    $('#cheque-chq-bankname').addClass('inp_error');
                    err++;
                }

                if (data.chequeDetails.bankCity == '') {
                    $('#cheque-chq-city').addClass('inp_error');
                    err++;
                }
            }
            
            data.amountReceivedDate = moment($('#cheque-rcvd-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
            if ($('#cheque-rcvd-date').val() == '') {
                $('#cheque-rcvd-date').addClass('inp_error');
                err++;
            }
        }

        data.remarks = $('#edt-cheque-remarks').val();
        
        if (err > 0) {
            $('#edt-cheque-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#edt-cheque-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#edt-cheque-action-state').show();
            return false;
        }
        
        $('#edt-cheque-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#edt-cheque-action-state').removeClass('hide').html(loading_popup);
        
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'payment/update-cheque-status',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#edt-cheque-action-state').removeClass('alert-danger');
                    $('#edt-cheque-action-state').addClass('alert-success');
                    $('#edt-cheque-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        closeEditStatusDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#edt-cheque-action-state').addClass('alert-danger');
                    $('#edt-cheque-action-state').html(response.errorDesc);
                }
            }
        });
    }

    function chequeHistoryDialog(code){
        $('#cheque-history-dialog').css('background', '#fff');
        $('#cheque-history-dialog').removeClass('hide');
        $('#cheque-history-dialog').dialog({
            autoOpen: true,
            height: 475,
            width: 750,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();


        var data = {};
        data.chequeDetailsCode = code;

        $('#cheque-history-body').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'payment/cheque-history',
            data: data,
            success: function (response) {
                $('#cheque-history-body').html(response);
            }
        });
    }

    function closeChequeHistoryDialog() {
        $('#cheque-history-dialog').addClass('hide');
        $('#cheque-history-dialog').dialog('destroy');
    }
</script>