<div class="brand_top">
    <h3>Receipt Entry</h3>
    <div class="text-right noprint">
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="addReceiptEntryDialog();">Add Receipt Entry</a>
    </div>
</div>
<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-md-12"> <br>
                <!-- PAGE HEADER-->
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="col-md-12">
                                    <div class="">
                                        <div id="search-panel">
                                            <form id="receipt-entry-form" name="receipt-entry-form" method="post" onsubmit="return false">
                                                <div class="row">
                                                    <div class="form-group col-md-2">
                                                        <label for="receipt-entry-from-date" class="req">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="fromDate" class="form-control sdate" id="receipt-entry-from-date" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="receipt-entry-to-date" class="req">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="toDate" class="form-control sdate" id="receipt-entry-to-date" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="receipt-entry-branch-filter">Branch</label>
                                                        <select id="receipt-entry-branch-filter" name="organizationCode" class="form-control" {if $action_rights['RCPT-ETRY-ALL-BRCH'] != 1}disabled{/if}>
                                                            <option value="NA">All Branch</option>
                                                            {foreach item=row from=$organizations}
                                                                <option value="{$row->code}" {if $loggedin_org == $row->code}selected{/if}>{$row->name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                    
                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <button class="btn btn-success" type="button"  onclick="getReceiptEntry()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearReceiptEntry()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="receipt-entry-report-action-state"></div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="receipt-entry-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="receipt-entry-list"></div>                                    
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="add-receipt-entry-dialog"  class="dialog-content-page hide">
    <div class="row">
        <div class="col-md-10 bold ft_15">
            Add Receipt Entry
        </div>
    </div>
    <br>
    <div style="">
        <div class="row">
            <div class="form-group col-md-4">
                <label class="" for="receipt-entry-type">Receipt Entry Type</label>
                <div class="input-group">
                    <label class="radio-inline">
                        <input type="radio" name="receiptEntryType" class="receipt-entry-type" value="OWNVEH" checked>Own Vehicle&nbsp;
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="receiptEntryType" class="receipt-entry-type" value="STFADV">Staff Advance&nbsp;
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="receiptEntryType" class="receipt-entry-type" value="OTHR">Others&nbsp;
                    </label>
                </div>
            </div>

            <div class="form-group col-md-3" id="rcpt-entry-vehi">
                <label class="req" for="receipt-entry-vehicle">Vehicle</label>
                <select id="receipt-entry-vehicle" class="form-control">
                    <option value="">Select Vehicle</option>
                    {foreach item=row from=$vehicles}
                        {if $row->activeFlag == 1 && $row->ownershipType->code == "OWN"}
                            <option value="{$row->code}">{$row->registationNumber}</option>
                        {/if}
                    {/foreach}
                </select>
            </div>

            <div class="form-group col-md-3 hide" id="rcpt-entry-other">
                <label class="req" for="receipt-entry-contact">Conatct</label>
                <select id="receipt-entry-contact" class="form-control">
                    <option value="">Select Conatct</option>
                    {foreach item=category from=$category_contacts}
                        <optgroup label="{$category->name}">
                            {foreach item=row from=$category->contacts}
                                <option value="{$row->code}">{$row->name}</option>
                            {/foreach}
                        </optgroup>
                    {/foreach}
                </select>
            </div>

            <div class="hide" id="rcpt-entry-staff-adv">
                <div class="form-group col-md-4">
                    <label for="receipt-reference-type">Advance Payment Type</label>
                    <div class="input-group">
                        <label class="radio-inline">
                            <input type="radio" name="receiptReferenceType" class="receipt-reference-type" value="VDR" checked>Vendor&nbsp;
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="receiptReferenceType" class="receipt-reference-type" value="DVR">Driver&nbsp;
                        </label>
                        {* <label class="radio-inline">
                            <input type="radio" name="receiptReferenceType" class="receipt-reference-type" value="USR">User&nbsp;
                        </label> *}
                        <label class="radio-inline">
                            <input type="radio" name="receiptReferenceType" class="receipt-reference-type" value="BSTF">Branch Staff&nbsp;
                        </label>
                    </div>
                </div>

                <div class="form-group col-md-3" id="rcpt-entry-ven">
                    <label class="req" for="receipt-entry-vendor">Vendor</label>
                    <select id="receipt-entry-vendor" class="form-control" onchange="getAdvancePaymentTransactions(this);">
                        <option value="">Select Vendor</option>
                        {foreach item=row from=$vendors}
                            <option value="{$row->code}">{$row->companyName}</option>
                        {/foreach}
                    </select>
                </div>

                <div class="form-group col-md-3 hide" id="rcpt-entry-dri">
                    <label class="req" for="receipt-entry-driver">Driver</label>
                    <select id="receipt-entry-driver" class="form-control" onchange="getAdvancePaymentTransactions(this);">
                        <option value="">Select Driver</option>
                        {foreach from=$drivers item=val}
                            <option value="{$val->code}">{$val->name}</option>
                        {/foreach}
                    </select>
                </div>

                <div class="form-group col-md-3 hide" id="rcpt-entry-user">
                    <label class="req" for="receipt-entry-user">User</label>
                    <select id="receipt-entry-user" class="form-control" onchange="getAdvancePaymentTransactions(this);">
                        <option value="">Select User</option>
                        {foreach item=branch from=$branchusers}
                            <optgroup label="{$branch['name']}">
                                {foreach item=row from=$branch['users']}
                                    {if $row->activeFlag == 1}
                                        {if in_array($row->code, $primary)}
                                            <option value="{$row->code}" data-org="{$row->organization->code}" {if $row->code == $usr_login_id}selected{/if}>{$row->name} <span class="bold">(Primary)</span></option>
                                        {else}
                                            <option value="{$row->code}" data-org="{$row->organization->code}" {if $row->code == $usr_login_id}selected{/if}>{$row->name}</option>
                                        {/if}
                                    {/if}
                                {/foreach}
                            </optgroup>
                        {/foreach}
                    </select>
                </div>

                <div class="hide" id="rcpt-entry-branch-staff">
                    <div class="form-group col-md-2">
                        <label class="req" for="receipt-entry-branch">Branch</label>
                        <select id="receipt-entry-branch" class="form-control" {if $action_rights['RCPT-ETRY-ALL-BRCH'] != 1}disabled{/if}>
                            <option value="">Select Branch</option>
                            {foreach item=row from=$organizations}
                                <option value="{$row->code}" {if $loggedin_org == $row->code}selected{/if}>{$row->name}</option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="form-group col-md-2 hide">
                        <label class="req" for="receipt-entry-branch-staff">Branch Staff</label>
                        <select id="receipt-entry-branch-staff" class="form-control" onchange="getAdvancePaymentTransactions(this);">
                            <option value="">Select Branch Staff</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div style="height: 200px;overflow-y: auto;">
                    <div class="hide" id="receipt-entry-list-panel"></div>
                    <div id="receipt-entry-info">
                        <br><br>
                        <div class="well">
                            <i class="fa fa-info-circle"></i> Please select a Vehicle or Advance Payment Type
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-3">
                <label class="" for="receipt-entry-amount">Amount</label>
                <input type="number" class="form-control" id="receipt-entry-amount" placeholder="Amount" step="any" disabled>
            </div>

            <div class="form-group col-md-3">
                <label class="req" for="receipt-entry-txn-mode">Transaction Mode</label>
                <select id="receipt-entry-txn-mode" class="form-control">
                    <option value="">Select Transaction Mode</option>
                    {foreach from=$transactionmode item=val key=k}
                        <option value="{$k}">{$val}</option>
                    {/foreach}
                </select>
            </div>
                
            <div class="form-group col-md-2">
                <label class="req" for="receipt-entry-date">Receipt Date</label>
                <div class="input-group">
                    <input type="text" class="form-control sdate" id="receipt-entry-date" readonly placeholder="Receipt Entry Date">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
        </div>

        <div class="row">
            {* UPI *}
            <div class="hide" id="receipt-entry-upi">
                <div class="form-group col-md-3">
                    <label class="req" for="receipt-entry-bank-details">Organization Bank</label>
                    <select id="receipt-entry-bank-details" class="form-control">
                        <option value="">Select a Bank</option>
                        {foreach from=$bankdetail item=val}
                            {if $val->accountType->code != 'CASH'}
                            <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>

                <div class="form-group col-md-3">
                    <label class="req" for="receipt-entry-upi-id">UPI Id</label>
                    <input type="text" class="form-control" id="receipt-entry-upi-id" placeholder="UPI ID">
                </div>

                <div class="form-group col-md-3">
                    <label for="receipt-entry-upi-details">Ref. #</label>
                    <input type="text" class="form-control" id="receipt-entry-upi-details" placeholder="Ref. #">
                </div>
            </div>

            {* NBK *}
            <div class="hide" id="receipt-entry-nbk">
                <div class="form-group col-md-3">
                    <label class="req" for="receipt-entry-bank-nbk">Organization Bank</label>
                    <select id="receipt-entry-bank-nbk" class="form-control">
                        <option value="">Select a Bank</option>
                        {foreach from=$bankdetail item=val}
                            {if $val->accountType->code != 'CASH'}
                            <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>

                <div class="form-group col-md-3">
                    <label class="req" for="receipt-entry-acc-hold-name">Account Holder Name</label>
                    <input type="text" class="form-control" id="receipt-entry-acc-hold-name" placeholder="Account Holder Name">
                </div>

                <div class="form-group col-md-3" id="receipt-entry-bank-name-div">
                    <label class="req" for="receipt-entry-bank-name">Bank Name</label>
                    <input type="text" class="form-control" id="receipt-entry-bank-name" placeholder="Bank Name">
                </div>

                <div class="form-group col-md-3">
                    <label for="receipt-entry-nbk-details">Ref. #</label>
                    <input type="text" class="form-control" id="receipt-entry-nbk-details" placeholder="Ref. #">
                </div>
            </div>
        </div>

        <div class="row">
            {* chq *}
            <div class="hide" id="receipt-entry-chq">
                <div class="form-group col-md-3">
                    <label class="req" for="receipt-entry-payer">Payer Details</label>
                    <input type="text" class="form-control" id="receipt-entry-payer" placeholder="Payer Details">
                </div>

                <div class="form-group col-md-2">
                    <label class="req" for="receipt-entry-chq-num">Cheque No</label>
                    <input type="text" class="form-control" id="receipt-entry-chq-num" placeholder="Cheque Number">
                </div>

                <div class="form-group col-md-2">
                    <label class="req" for="receipt-entry-chq-date">Cheque Date</label>
                    <div class="input-group">
                        <input type="text" class="form-control sdate" id="receipt-entry-chq-date" readonly placeholder="Cheque Date">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>

                <div class="form-group col-md-3" id="receipt-entry-chq-bankname-div">
                    <label class="req" for="receipt-entry-chq-bankname">Bank Name</label>
                    <input type="text" class="form-control" id="receipt-entry-chq-bankname" placeholder="Bank Name">
                </div>

                <div class="form-group col-md-2">
                    <label class="req" for="receipt-entry-chq-city">Bank City</label>
                    <input type="text" class="form-control" id="receipt-entry-chq-city" placeholder="Bank City">
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-12">
                <label>Remarks</label>
                <textarea id="receipt-entry-remarks"  placeholder="Enter your remarks" style="resize:none" class="form-control" rows="2" cols="30" name="remark" id="remark"></textarea>
            </div>
        </div>
    </div>
    <div style="padding:15px 15px 10px;">
        <div class="row">
            <input type="hidden" id="receipt-entry-code">
            <input type="hidden" id="receipt-entry-chq-code">
            <div class="clear_fix_both">
                <div class="alert hide" id="receipt-entry-action-state"></div>
                <div class="align-right">
                    <button class="btn btn-success" type="button" id="receipt-entry-form-buttons" onclick="saveReceiptEntry();">Save</button>
                    <button class="btn btn-default" type="button" onclick="closeReceiptEntryDialog();">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    #receipt-entry-ven > .input-group > .twitter-typeahead {
        display: table-cell!important;
    }
</style>

<script>
    var bankNamesList = {$bank_names_list|json_encode}
    var loggedInBranch = {$login_branch|json_encode}
</script>

{literal}
    <script>
        $('#receipt-entry-vehicle, #receipt-entry-contact').select2();
        $('#receipt-entry-vendor, #receipt-entry-driver, #receipt-entry-user, #receipt-entry-branch').select2();

        $('#receipt-entry-from-date').datepicker({
            format: 'dd-mm-yyyy',
            autoclose: true,
            changeMonth: true
        }).on('changeDate', function (e) {
            $('#receipt-entry-to-date').datepicker('setStartDate', e.date);
        });

        $('#receipt-entry-to-date').datepicker({
            todayHighlight: true,
            format: 'dd-mm-yyyy',
            autoclose: true
        }).on('changeDate', function (e) {
            $('#receipt-entry-from-date').datepicker('setEndDate', e.date);
        });

        $('#receipt-entry-date, #receipt-entry-chq-date').datepicker({
            todayHighlight: true,
            format: 'dd-mm-yyyy',
            autoclose: true
        });
        $('#receipt-entry-bank-name').autocomplete({
            minLength: 0,
            source: bankNamesList,
            appendTo: '#receipt-entry-bank-name-div'
        }).focus(function(){
            $(this).autocomplete('search', '');
        });

        $('#receipt-entry-chq-bankname').autocomplete({
            minLength: 0,
            source: bankNamesList,
            appendTo: '#receipt-entry-chq-bankname-div'
        }).focus(function(){
            $(this).autocomplete('search', '');
        });

        $('.receipt-entry-type').on('change', function() {
            var receiptEntryType = $(this).val();
            $('#rcpt-entry-vehi, #rcpt-entry-other, #rcpt-entry-staff-adv').addClass('hide');
            $('#receipt-entry-list-panel').addClass('hide');
            $('#receipt-entry-info').removeClass('hide');
            $('#receipt-entry-vehicle, #receipt-entry-contact').val('').trigger('change');
            $('.receipt-reference-type[value=VDR]').prop('checked', true).trigger('change');
            $('#receipt-entry-amount').attr('disabled', true);
            $('#receipt-entry-amount').val('');
            
            if (receiptEntryType == 'OWNVEH') {
                $('#rcpt-entry-vehi').removeClass('hide');
            } else if (receiptEntryType == 'STFADV') {
                $('#rcpt-entry-staff-adv').removeClass('hide')
            } else if (receiptEntryType == 'OTHR') {
                $('#rcpt-entry-other').removeClass('hide');
                $('#receipt-entry-amount').attr('disabled', false);
            }
        });

        $('.receipt-reference-type').on('change', function() {
            var receiptReferenceType = $(this).val();
            $('#rcpt-entry-ven, #rcpt-entry-dri, #rcpt-entry-user, #rcpt-entry-branch-staff').addClass('hide');
            $('#receipt-entry-vendor, #receipt-entry-driver, #receipt-entry-user, #rcpt-entry-branch-staff').val('').trigger('change');

            if (receiptReferenceType == 'VDR') {
                $('#rcpt-entry-ven').removeClass('hide');
            } else if (receiptReferenceType == 'DVR') {
                $('#rcpt-entry-dri').removeClass('hide')
            } else if (receiptReferenceType == 'USR') {
                $('#rcpt-entry-user').removeClass('hide');
            } else if (receiptReferenceType == 'BSTF') {
                $('#receipt-entry-branch').trigger('change');
                $('#rcpt-entry-branch-staff').removeClass('hide');
            }
        });

        $('#receipt-entry-branch').on('change', function() {
            var $branchStaff = $('#receipt-entry-branch-staff');
            $('#receipt-entry-branch-staff').closest('.form-group').addClass('hide');
            var data = {};
            data.organizationCode = $(this).val();

            if (!data.organizationCode) {
                $branchStaff.html('').select2().html('');
                return;
            }
            $branchStaff.html(new Option('Loading...', '', true, true)).select2().html('');
            $('#receipt-entry-branch-staff').closest('.form-group').removeClass('hide');

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'payment/get-branch-contact',
                data: data,
                success: function (res) {
                    if (res.status == 1) {
                        $branchStaff.html(new Option('Select Branch Staff', ''));
                        $.each(res.data || [], function (i, contact) {
                            if (contact.category.code == 'STF') {
                                if (isNotNull(contact.aliasCode)) {
                                    $branchStaff.append(new Option(contact.name + ' - ' + contact.aliasCode, contact.code));
                                } else {
                                    $branchStaff.append(new Option(contact.name, contact.code));
                                }
                            }
                        });
                        $branchStaff.select2();
                    }
                }
            });
        });

        $('#receipt-entry-vehicle').on('change', function() {
            $('#receipt-entry-list-panel').addClass('hide').html('');
            $('#receipt-entry-info').removeClass('hide');
            var data = {};
            
            data.vehicleCode = $('#receipt-entry-vehicle').val();
            data.cashbookTypeCode = 'ADVANCE';
            data.type = 'TRANSPORTER';

            if (isNull(data.vehicleCode)) {
                return false;
            }

            $('#receipt-entry-info').addClass('hide');
            $('#receipt-entry-list-panel').removeClass('hide').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "payment/get-vehicle-transit-transaction-list",
                data: data,
                success: function (response) {
                    $('#receipt-entry-list-panel').html(response);
                }
            });
        });

        $('#receipt-entry-txn-mode').on('change', function(){
            $('#receipt-entry-bank-details, #receipt-entry-bank-nbk, #receipt-entry-chq-bank-details, #receipt-entry-chq-bankname').val('').trigger('change');
            $('#receipt-entry-payer, #receipt-entry-chq-num, #receipt-entry-chq-date, #receipt-entry-chq-city, #receipt-entry-upi-id, #receipt-entry-upi-details, #receipt-entry-bank-name, #receipt-entry-acc-hold-name, #receipt-entry-nbk-details').val('');

            $('#receipt-entry-chq, #receipt-entry-upi, #receipt-entry-nbk').addClass('hide');
            $('#receipt-entry-form-buttons').removeClass('hide');
            if ($(this).val() == 'UPI') {
                $('#receipt-entry-upi').removeClass('hide');
            } else if ($(this).val() == 'NBK') {
                $('#receipt-entry-nbk').removeClass('hide');
            } else if ($(this).val() == 'CHEQUE') {
                $('#receipt-entry-chq').removeClass('hide');
            }
        });

        function getReceiptEntry() {
            var data = {};
            data.fromDate = $('#receipt-entry-from-date').val();
            data.toDate = $('#receipt-entry-to-date').val();
            data.organizationCode = $('#receipt-entry-branch-filter').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');
            if (data.fromDate == '') {
                $('#receipt-entry-from-date').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#receipt-entry-to-date').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#receipt-entry-report-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#receipt-entry-report-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#receipt-entry-report-action-state').show();
                return false;
            } else {
                $('#receipt-entry-report-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#receipt-entry-report-action-state').html('');
                $('#receipt-entry-report-action-state').hide();
            }

            $('#receipt-entry-list-container').removeClass('hidden');
            $('#receipt-entry-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "payment/receipt-entry-list",
                data: data,
                success: function(response) {
                    $('#receipt-entry-list').html(response);
                    $("html, body").animate({
                        scrollTop: $('#receipt-entry-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }

        function clearReceiptEntry() {
            $('#receipt-entry-from-date').val('');
            $('#receipt-entry-to-date').val('');
            $('#receipt-entry-list-container').addClass('hidden');
            $('#receipt-entry-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#receipt-entry-report-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#receipt-entry-report-action-state').html('');
            $('#receipt-entry-report-action-state').hide();
        }
        
        function getAdvancePaymentTransactions(ele) {
            $('#receipt-entry-list-panel').addClass('hide').html('');
            $('#receipt-entry-info').removeClass('hide');
            var data = {};
            
            data.referenceCode = $(ele).val();
            data.receiptType = 'ADV';

            if (isNull(data.referenceCode)) {
                return false;
            }

            $('#receipt-entry-info').addClass('hide');
            $('#receipt-entry-list-panel').removeClass('hide').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "payment/get-transaction-receipt-transaction-list",
                data: data,
                success: function (response) {
                    $('#receipt-entry-list-panel').html(response);
                }
            });
        }

        function addReceiptEntryDialog(code) {
            $('#add-receipt-entry-dialog').css('background', '#fff');
            $('#add-receipt-entry-dialog').removeClass('hide');
            $('#add-receipt-entry-dialog').dialog({
                autoOpen: true,
                height: $(window).height() - 100,
                width: $(window).width() - 200,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();
            $('.inp_error').removeClass('inp_error');
            $('#receipt-entry-action-state').removeClass('alert-success, alert-danger').html('').hide();

            $('#receipt-entry-code, #receipt-entry-chq-code, #receipt-entry-txn-amt, #receipt-entry-tds-amt, #receipt-entry-payer, #receipt-entry-chq-date, #receipt-entry-chq-num, #receipt-entry-chq-city, #receipt-entry-rcvd-date, #receipt-entry-remarks, #receipt-entry-upi-id, #receipt-entry-upi-details, #receipt-entry-bank-name, #receipt-entry-acc-hold-name, #receipt-entry-nbk-details').val('');
            $('#receipt-entry-bank-details, #receipt-entry-chq-bank-details, #receipt-entry-chq-bankname, #receipt-entry-bank-nbk').val('').trigger('change');
            $('#receipt-entry-customer, #receipt-entry-vendor').typeahead('val', '');
            $('#receipt-entry-txn-mode').val('').trigger('change');

            $('.receipt-entry-type[value=OWNVEH]').prop('checked', true).trigger('change');
        }

        function closeReceiptEntryDialog() {
            advancePaymentTransaction = {};
            $('#add-receipt-entry-dialog').addClass('hide');
            $('#add-receipt-entry-dialog').dialog('destroy');
        }

        function saveReceiptEntry() {
            var err = 0;
            $('.inp_error').removeClass('inp_error');

            var data = {};
            data.code = $('#receipt-entry-code').val();
            data.activeFlag = 1;

            data.receiptEntryType = {};
            data.receiptEntryType.code = $('.receipt-entry-type:checked').val();

            if (data.receiptEntryType.code == 'OWNVEH') {
                data.busVehicle = {};
                data.busVehicle.code = $('#receipt-entry-vehicle').val();

                if (isNull(data.busVehicle.code)) {
                    $('#receipt-entry-vehicle').addClass('inp_error');
                    err++;
                }
            } else if (data.receiptEntryType.code == 'STFADV') {
                var receiptReferenceType = $('.receipt-reference-type:checked').val();
                if (receiptReferenceType == 'VDR') {
                    data.cargoVendor = {};
                    data.cargoVendor.code = $('#receipt-entry-vendor').val();

                    if (isNull(data.cargoVendor.code)) {
                        $('#receipt-entry-vendor').addClass('inp_error');
                        err++;
                    }
                } else if (receiptReferenceType == 'DVR') {
                    data.paymentByContact = {};
                    data.paymentByContact.code = $('#receipt-entry-driver').val();

                    if (isNull(data.paymentByContact.code)) {
                        $('#receipt-entry-driver').addClass('inp_error');
                        err++;
                    }
                } else if (receiptReferenceType == 'USR') {
                    data.paymentByContact = {};
                    data.paymentByContact.code = $('#receipt-entry-user').val();

                    if (isNull(data.paymentByContact.code)) {
                        $('#receipt-entry-user').addClass('inp_error');
                        err++;
                    }
                } else if (receiptReferenceType == 'BSTF') {
                    data.paymentByContact = {};
                    data.paymentByContact.code = $('#receipt-entry-branch-staff').val();

                    if ($('#receipt-entry-branch').val() == '') {
                        $('#receipt-entry-branch').addClass('inp_error');
                        err++;
                    }

                    if (isNull(data.paymentByContact.code)) {
                        $('#receipt-entry-branch-staff').addClass('inp_error');
                        err++;
                    }
                }
            } else if (data.receiptEntryType.code == 'OTHR') {
                data.paymentByContact = {};
                data.paymentByContact.code = $('#receipt-entry-contact').val();

                if (isNull(data.paymentByContact.code)) {
                    $('#receipt-entry-contact').addClass('inp_error');
                    err++;
                }
            }

            data.receiptDate = $('#receipt-entry-date').val();
            if (isNull(data.receiptDate)) {
                $('#receipt-entry-date').addClass('inp_error');
                err++;
            }

            data.acknowledgeStatus = {};
            data.acknowledgeStatus.code = 'INIT';

            data.transactionMode = {};
            data.transactionMode.code = $('#receipt-entry-txn-mode').val();
            if (isNull(data.transactionMode.code)) {
                $('#receipt-entry-txn-mode').addClass('inp_error');
                err++;
            }

            if (data.transactionMode.code == 'CASH') {
                data.acknowledgeStatus = {};
                data.acknowledgeStatus.code = 'APRD';
            }

            // upi
            if (data.transactionMode.code == 'UPI') {
                data.bankDetails = {};
                data.bankDetails.code = $('#receipt-entry-bank-details').val();

                data.addAttr1 = $.trim($('#receipt-entry-upi-id').val());
                data.addAttr2 = $.trim($('#receipt-entry-upi-details').val());

                if (data.addAttr1 == '') {
                    $('#receipt-entry-upi-id').addClass('inp_error');
                    err++;
                }

                if ($('#receipt-entry-bank-details').val() == '') {
                    $('#receipt-entry-bank-details').addClass('inp_error');
                    err++;
                }

                if (data.addAttr2 == '') {
                    $('#receipt-entry-upi-details').addClass('inp_error');
                    err++;
                }
            } else if (data.transactionMode.code == 'NBK') {
                data.bankDetails = {};
                data.bankDetails.code = $('#receipt-entry-bank-nbk').val();

                data.addAttr1 = $.trim($('#receipt-entry-acc-hold-name').val());
                data.addAttr2 = $.trim($('#receipt-entry-bank-name').val());
                data.addAttr3 = $.trim($('#receipt-entry-nbk-details').val());

                if (data.addAttr1 == '') {
                    $('#receipt-entry-acc-hold-name').addClass('inp_error');
                    err++;
                }

                if (data.addAttr2 == '') {
                    $('#receipt-entry-bank-name').addClass('inp_error');
                    err++;
                }

                if ($('#receipt-entry-bank-nbk').val() == '') {
                    $('#receipt-entry-bank-nbk').addClass('inp_error');
                    err++;
                }

                if (data.addAttr3 == '') {
                    $('#receipt-entry-nbk-details').addClass('inp_error');
                    err++;
                }
            }

            // cheque
            if (data.transactionMode.code == 'CHEQUE') {
                data.chequeDetails = {};
                data.chequeDetails.code = $('#receipt-entry-chq-code').val();
                data.chequeDetails.activeFlag = 1;

                data.chequeDetails.organization = {};
                data.chequeDetails.organization.code = loggedInBranch;

                data.chequeDetails.bankDetails = $.trim($('#receipt-entry-chq-bankname').val());

                data.chequeDetails.payerDetails = $.trim($('#receipt-entry-payer').val());

                data.chequeDetails.chequeDate = moment($('#receipt-entry-chq-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                data.chequeDetails.chequeNo = $.trim($('#receipt-entry-chq-num').val());
                data.chequeDetails.bankCity = $.trim($('#receipt-entry-chq-city').val());

                data.chequeDetails.chequeStatus = {};
                data.chequeDetails.chequeStatus.code = 'NEW';

                data.chequeDetails.remarks = '';

                if (data.chequeDetails.payerDetails == '') {
                    $('#receipt-entry-payer').addClass('inp_error');
                    err++;
                }

                if ($('#receipt-entry-chq-date').val() == '') {
                    $('#receipt-entry-chq-date').addClass('inp_error');
                    err++;
                }

                if (data.chequeDetails.chequeNo == '') {
                    $('#receipt-entry-chq-num').addClass('inp_error');
                    err++;
                }

                if (data.chequeDetails.bankDetails == '') {
                    $('#receipt-entry-chq-bankname').addClass('inp_error');
                    err++;
                }

                if (data.chequeDetails.bankCity == '') {
                    $('#receipt-entry-chq-city').addClass('inp_error');
                    err++;
                }
            }

            data.transactions = [];
            if (data.receiptEntryType.code == 'OWNVEH') {
                $('#vehicle-transit-transaction-table .vehicle-transit-transaction-checkbox:checked').each(function() {
                    var transactions = {};
                    transactions.code = $(this).val();
                    transactions.paidAmount = $(this).closest('tr').find('.own-vehi-amount').val();

                    if (isNull(transactions.paidAmount) || transactions.paidAmount == 0) {
                        $(this).closest('tr').find('.own-vehi-amount').addClass('inp_error');
                        err++;
                    }

                    if (isNull(transactions.paidAmount) || $(this).data('amount') < transactions.paidAmount) {
                        $(this).closest('tr').find('.own-vehi-amount').addClass('inp_error');
                        err++;
                    }
                    data.transactions.push(transactions);
                });
            } else if (data.receiptEntryType.code == 'STFADV') {
                $('#receipt-entry-transaction-receipt-table .receipt-entry-transaction-checkbox:checked').each(function() {
                    var transactions = {};
                    transactions.code = $(this).val();
                    transactions.paidAmount = $(this).closest('tr').find('.adv-pay-amount').val();

                    if (isNull(transactions.paidAmount) || transactions.paidAmount == 0) {
                        $(this).closest('tr').find('.adv-pay-amount').addClass('inp_error');
                        err++;
                    }

                    if (isNull(transactions.paidAmount) || $(this).data('amount') < transactions.paidAmount) {
                        $(this).closest('tr').find('.adv-pay-amount').addClass('inp_error');
                        err++;
                    }
                    data.transactions.push(transactions);
                });
            }
            
            data.amount = $('#receipt-entry-amount').val();
            if (isNull(data.amount)) {
                $('#receipt-entry-amount').addClass('inp_error');
                err++;
            }

            data.remarks = $('#receipt-entry-remarks').val();

            if (data.receiptEntryType.code != 'OTHR' && data.transactions.length == 0) {
                $('#receipt-entry-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#receipt-entry-action-state').html('Please select atleast one Transactions!!!');
                $('#receipt-entry-action-state').show();
                return false;
            }

            if (err > 0) {
                $('#receipt-entry-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#receipt-entry-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#receipt-entry-action-state').show();
                return false;
            }

            $('#receipt-entry-action-state').removeClass('alert-success, alert-danger, hide');
            $('#receipt-entry-action-state').html(loading_popup).show();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'payment/update-receipt-entry',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#receipt-entry-action-state').removeClass('alert-danger');
                        $('#receipt-entry-action-state').addClass('alert-success');
                        $('#receipt-entry-action-state').html('Your request has been completed successfully');
                        window.setTimeout(function() {
                            closeReceiptEntryDialog();
                            checkURL();
                            return;
                        }, 3000);
                    } else {
                        $('#receipt-entry-action-state').addClass('alert-danger');
                        $('#receipt-entry-action-state').html(response.errorDesc);
                    }
                }
            });
        }

        function updateReceiptEntryStatus(code, status) {
            if (status == 'APRD') {
                var message = 'Do you want to approve this receipt entry?';
            } else if (status == 'REJT') {
                var message = 'Do you want to reject this receipt entry?';
            }
            if (confirm(message)) {
                var data = {};
                data.code = code;

                data.acknowledgeStatus = {};
                data.acknowledgeStatus.code = status;

                var loading_overlay = iosOverlay({
                    text: "Loading",
                    icon: "fa fa-spinner fa-spin"
                });       
            
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: base_url + "payment/update-receipt-entry-status",
                    data: data,
                    success: function (response) {
                        if (response.status == 1) {
                            loading_overlay.update({
                                icon: "fa fa-check",
                                text: "Success!"
                            });
                        } else {
                            loading_overlay.update({
                                icon: "fa fa-times",
                                text: "Sorry!"
                            });
                        }
                        window.setTimeout(function () {
                            loading_overlay.hide();
                            getReceiptEntry();
                        }, 2000);
                    }
                });
            }
        }
    </script>
{/literal}