<div class="brand_top">
    <h3>Journal</h3>
    <div class="text-right noprint">
        <button class="btn btn-success" onclick="addJournalTransaction();">Add Journal</button>
    </div>
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

                                                <form id="journal_form" method="post" name="journal_form" action="payment/journal-transaction-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="journal_date_from" class="req">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="journal_date_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="journal_date_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="journal_date_to" class="req">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="journal_date_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="journal_date_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-2">
                                                            <div>
                                                                <label for="checkbox">&nbsp;</label>
                                                                <div class="input-group">
                                                                    <label class="col-lg-12"><input type="checkbox" id="journal-show-exp-ledger" onchange="showExpenseFilter(this);">&emsp;Expense Ledger</label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2" id="contact-filter">
                                                            <label for="journal_contact" class="req">Debit Ledger</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="journal_contact" name="paymentContactCode" class="form-control select2">
                                                                    <option value="">Select Debit Ledger</option>
                                                                    {foreach item=category from=$category_contacts}
                                                                        <optgroup label="{$category->name}">
                                                                            {foreach item=row from=$category->contacts}
                                                                                <option value="{$row->code}">{$row->name}</option>
                                                                            {/foreach}
                                                                        </optgroup>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="hide" id="expense-ledger-filter">
                                                            <div class="form-group col-md-2">
                                                                <label for="journal_contact_category" class="req">Ledger A/C</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="journal_contact_category" name="contactCategoryCode" class="form-control select2">
                                                                        <option value="">Select Ledger A/C</option>
                                                                        {foreach item=category from=$category_contacts key=key}
                                                                            {if in_array('EXPLGR', $category->tag)}
                                                                                <option value="{$category->code}">{$category->name}</option>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>

                                                            <div class="form-group col-md-2">
                                                                <label for="journal_contact_filter">Sub-Ledger A/c</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="journal_contact_filter" name="contactCode" class="form-control select2">
                                                                        <option value="">Select Sub-Ledger A/c</option>
                                                                        {foreach item=category key=k from=$category_contacts}
                                                                            {if in_array('EXPLGR', $category->tag)}
                                                                                <optgroup label="{$category->name}" data-categorycode="{$k}">
                                                                                {foreach item=row from=$category->contacts}
                                                                                    <option value="{$row->code}" data-categorycode="{$row->contactCategory->code}" data-actioncode="{$row->contactCategory->actionCode}">{$row->name}</option>
                                                                                {/foreach}
                                                                                </optgroup>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        {* <div class="form-group col-md-2">
                                                            <label for="journal_cashbooktype">Sub-Ledger A/c</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="journal_cashbooktype" name="contactCategoryCode" class="form-control select2">
                                                                    <option value="NA">Select Sub-Ledger A/c</option>
                                                                    {foreach item=row from=$triphead}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div> *}

                                                        <br class="clear_fix_both">
                                                        <div class="col-lg-2">
                                                            <div>
                                                                <label for="journal-category-filter">&nbsp;</label>
                                                                <span class="radio d-inline-block">
                                                                    <label><input type="radio" name="journal-category-filter" value="VEH" checked> Vehicle</label>
                                                                </span>&emsp;
                                                                <span class="radio d-inline-block">
                                                                    <label><input type="radio" name="journal-category-filter" value="BRN"> Branch</label>
                                                                </span>&emsp;
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-2 cont">
                                                            <div class="form-group">
                                                                <label for="journal-vehicle-filter">Vehicle</label>
                                                                <select id="journal-vehicle-filter" class="form-control select2">
                                                                    <option value="">Select Vehicle</option>
                                                                    {foreach item=row from=$vehicles}
                                                                        <option value="{$row->code}">{$row->registationNumber} - {$row->ownershipType->name}</option>
                                                                    {/foreach} 
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-2 cont hide">
                                                            <div class="form-group">
                                                                <label for="journal-branch-filter">Branch</label>
                                                                <select id="journal-branch-filter" class="form-control select2">
                                                                    <option value="">Select Branch</option>
                                                                    {foreach item=row from=$organizations}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach} 
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label>&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="acknowledgeStatus" id="journal-ack-status">
                                                                <button class="btn btn-success" type="button" onclick="generateJournalReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearJournalReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>

                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="journal_action_state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="journal-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="tabbable">
                                        <ul class="nav nav-tabs" id="journal_tabs">
                                            <li class="active noprint" data-status="APRD">
                                                <a data-toggle="tab" href="#tab_acknowledged">Acknowledged</a>
                                            </li>
                                            <li data-status="INIT" class="noprint">
                                                <a data-toggle="tab" href="#tab_waiting_payment">Initiated</a>
                                            </li>
                                            <li class="pull-right noprint hide">
                                                <div class="btn-group btn-group-sm">
                                                    <a href="javascript:;" class="btn btn-default" onclick="exportJournalExcel();"><i class="fa fa-download fa-lg"></i>Excel</a>
                                                    <a href="javascript:;" class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</a>
                                                </div>
                                            </li>
                                        </ul>
                                        <div class="tab-content" id="journal_tabs_cont">
                                            <div id="tab_acknowledged" class="tab-pane fade in active" data-tabstatus="APRD"></div>
                                            <div id="tab_waiting_acknowledgement" class="tab-pane fade" data-tabstatus="PAID"></div>
                                            <div id="tab_waiting_payment" class="tab-pane fade noprint" data-tabstatus="INIT"></div>
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
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<div id="journal-journal-dialog" class="hide dialog-content-page noprint">
    <div class="m-t-4">
        <form role="form">
            <div class="row">

                <div class="col-md-4">
                    <div class="form-group">
                        <label for="journal-payment-contact" class="req">Debit Ledger</label>
                        <select id="journal-payment-contact" name="paymentContact" class="form-control select2">
                            <option value="">Select Debit Ledger</option>
                            {foreach item=category from=$category_contacts}
                                <optgroup label="{$category->name}">
                                    {foreach item=row from=$category->contacts}
                                        <option value="{$row->code}">{$row->name}</option>
                                    {/foreach}
                                </optgroup>
                            {/foreach}
                        </select>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="form-group">
                        <label for="journal-vendor-contact" class="req">Credit Ledger</label>
                        <select id="journal-vendor-contact" name="vendorContact" class="form-control select2">
                            <option value="">Select Credit Ledger</option>
                            {foreach item=category from=$category_contacts}
                                <optgroup label="{$category->name}">
                                    {foreach item=row from=$category->contacts}
                                        <option value="{$row->code}">{$row->name}</option>
                                    {/foreach}
                                </optgroup>
                            {/foreach}
                        </select>
                    </div>
                </div>
                
                {* <div class="col-lg-4">
                    <div class="form-group">
                        <label class="req" for="journal-expense">Sub-Ledger A/c</label>
                        <select id="journal-expense" class="form-control">
                            <option value="">Select Sub-Ledger A/c</option>
                            {foreach item=row from=$triphead}
                                <option value="{$row->code}">{$row->name}</option>
                            {/foreach} 
                        </select>
                    </div>
                </div> *}
                
                <div class="col-lg-4">
                    <div class="form-group">
                        <label class="req" for="journal-paydate">Voucher Date</label>
                        <input type="text" placeholder="Voucher Date" id="journal-paydate" class="form-control">
                    </div>
                </div>
            </div>
            <div class="clear_fix_both"></div>

            <div class="row">
                <div class="col-lg-3">
                    <div onchange="setTimeout(toggleCashbookCategory)">
                        <label for="journal-cashbook-category">&nbsp;</label>
                        <span class="radio d-inline-block">
                            <label><input type="radio" name="journal-cashbook-category" value="VEH" checked> Vehicle</label>
                        </span>&emsp;
                        <span class="radio d-inline-block">
                            <label><input type="radio" name="journal-cashbook-category" value="BRN"> Branch</label>
                        </span>&emsp;
                    </div>
                </div>

                <div class="col-lg-3 cont">
                    <div class="form-group">
                        <label class="req" for="journal-vehicle">Vehicle</label>
                        <select id="journal-vehicle" class="form-control select2">
                            <option value="">Select Vehicle</option>
                            {foreach item=row from=$vehicles}
                                <option value="{$row->code}">{$row->registationNumber} - {$row->ownershipType->name}</option>
                            {/foreach} 
                        </select>
                    </div>
                </div>

                <div class="col-lg-3 cont hide">
                    <div class="form-group">
                        <label class="req" for="journal-branch">Branch</label>
                        <select id="journal-branch" class="form-control select2">
                            <option value="">Select Branch</option>
                            {foreach item=row from=$organizations}
                                <option value="{$row->code}">{$row->name}</option>
                            {/foreach} 
                        </select>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label class="req" for="journal-amount">Amount</label>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rupee"></i></span>
                            <input type="number" placeholder="Amount" id="journal-amount" name="amount" class="form-control no-spin" min="0">
                        </div>
                    </div>
                </div>

                <div class="col-lg-3">
                    <div class="form-group">
                        <label class="req" for="journal-tds">TDS Amount</label>
                        <input type="number" placeholder="TDS Amount" id="journal-tds" name="amount" class="form-control no-spin" min="0">
                    </div>
                </div>
            </div>
            <div class="clear_fix_both"></div>

            <div class="row">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label class="req" for="journal-reference">Reference Number</label>
                        <input type="text" placeholder="Reference Number" id="journal-reference" class="form-control">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="form-group">
                        <label for="journal-remarks">Remarks</label>
                        <textarea id="journal-remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="2" cols="10" name="remark" id="remark" maxlength="120"></textarea>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    {include file="site/cargo/file-upload-component.tpl" id="journal-fileupload" axis="horizontal"}
                </div>
            </div>
            <div class="clear_fix_both"></div>
        </form>
    </div>
    <div class="clear_fix_both">
        <input type="hidden" id="journal-code">
        <div class="alert" style="display: none;" id="journal-action-state"></div>
        <div class="align-right" id="journal-form-bttons">
            <button class="btn btn-success" type="button" onclick="saveJournalTransaction();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelJournalTransaction();">Cancel</button>
        </div>
    </div>
</div>

<style>
.switch-id-journal-type-cb {
    width: 80%;
}
</style>

<script>
    var journal_contact = $('#journal_contact_filter optgroup');
    var emptyJournalContactOption = '<option value="">Select Sub-Ledger A/c</option>';
</script>

{literal}
    <script>
        $('#journal_date_from').datepicker({
            todayHighlight: true,
            format: 'yyyy-mm-dd',
            startDate: '-6m',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function(e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#journal_date_to').datepicker('setStartDate', e.date);
            $("#journal_date_to").datepicker("setEndDate", end)
        });
        $('#journal_date_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function(e) {
            $('#journal_date_from').datepicker('setEndDate', e.date)
        });
        $('#journal-paydate').datepicker({
            todayHighlight: true,
            startDate: '-6m',
            endDate: '+6m',
            format: 'yyyy-mm-dd',
            autoclose: true
        });
        $('.select2').select2();

        $('#journal-income').select2();
        // $('#journal-expense').select2();

        $('.bsn_switch').bootstrapSwitch();
        $('#journal-type-cb').on('switchChange.bootstrapSwitch', function () {
            $('#income-head-panel').addClass('hide');
            $('#expense-head-panel').addClass('hide');
            $('#expense-vendor-panel').addClass('hide');
            if (this.checked) {
                $('#expense-head-panel').removeClass('hide');
            } else {
                $('#income-head-panel').removeClass('hide');
            }
        });

        $('#journal_tabs').on('shown.bs.tab', function (e) {
            var tabId = $(e.target).attr('href')
            //if ($(tabId).is(':empty')) {
                if(tabId == '#tab_waiting_payment'){
                    $('#tab_waiting_payment').removeClass('noprint');
                    $('#tab_acknowledged').addClass('noprint');
                }else{
                    $('#tab_acknowledged').removeClass('noprint');
                    $('#tab_waiting_payment').addClass('noprint');
                }
                
                generateJournalReport();
            //}
        });

        var journalFileUpload = new fileUpload('#journal-fileupload');

        $('input[name=journal-category-filter]').on('change', function() {
            var category = $(this).val();

            $('#journal-vehicle-filter').closest('.cont').addClass('hide');
            $('#journal-branch-filter').closest('.cont').addClass('hide');

            if (category == 'VEH') {
                $('#journal-vehicle-filter').closest('.cont').removeClass('hide');
            } else if (category == 'BRN') {
                $('#journal-branch-filter').closest('.cont').removeClass('hide');
            }
        });

        $('#journal_contact_category').on('change', function() {
            var category = $(this).val();
            $('#journal_contact_filter').html(function () {
                return journal_contact.filter(function () {
                    if (category != "") {
                        return $(this).data('categorycode') == category;
                    } else {
                        return isNotNull($(this).data('categorycode'));
                    }
                });
            }).prepend(emptyJournalContactOption).val('').trigger('change');
        });

        function toggleCashbookCategory() {
            var category = $('[name="journal-cashbook-category"]:checked').val();

            $('#journal-vehicle').closest('.cont').addClass('hide');
            $('#journal-branch').closest('.cont').addClass('hide');

            if (category == 'VEH') {
                $('#journal-vehicle').closest('.cont').removeClass('hide');
            } else if (category == 'BRN') {
                $('#journal-branch').closest('.cont').removeClass('hide');
            }
        }

        function showExpenseFilter(ele) {
            $('#contact-filter, #expense-ledger-filter').addClass('hide');
            if ($(ele).is(":checked")) {
                $('#expense-ledger-filter').removeClass('hide');
            } else {
                $('#contact-filter').removeClass('hide');
            }
        }

        // function getCategoryContacts(type) {
        //     if (type == 'JOURNAL') {
        //         var $category = $('#journal_contact_category');
        //         var $contact = $('#journal_contact');
        //         var $bankpanel = $('#journal_bank_account_cont');
        //         var $bankaccount = $('#journal_bank_account');
        //     } else if (type == 'ADJUSTMENT') {
        //         var $category = $('#journal-contact-category');
        //         var $contact = $('#journal-contact');
        //         var $bankpanel = $('#journal-bank-account-cont');
        //         var $bankaccount = $('#journal-bank-account');
        //     }

        //     var data = {};
        //     data.entityTypeCode = $category.val();

        //     $bankpanel.addClass('hide');

        //     if (!data.entityTypeCode) {
        //         $contact.html('').select2().html('');
        //         return;
        //     }
        //     $contact.html(new Option('Loading...', '', true, true)).select2().html('');

        //     $.ajax({
        //         type: 'POST',
        //         dataType: 'json',
        //         url: base_url + 'config/get-contact-v2',
        //         data: data,
        //         success: function (res) {
        //             if (res.status == 1) {
        //                 $contact.html(new Option('Select Contact', ''));
        //                 $.each(res.data || [], function (i, contact) {
        //                     $contact.append(new Option(contact.name, contact.code));
        //                 });
        //                 $contact.select2();

        //                 // $contact.off('change').on('change', function() {
        //                 //     var contactCode = $(this).val();
        //                 //     if (!contactCode) {
        //                 //         return;
        //                 //     }
        //                 //     var contact = _.find(res.data, e => e.code == contactCode);
        //                 //     $bankaccount.html(new Option('Select Bank', 'NA'));
        //                 //     $.each(contact.bankDetails || [], function (i, bank) {
        //                 //         $bankaccount.append(new Option(bank.name, bank.code));
        //                 //     });
        //                 //     $bankaccount.select2('val', 'NA');

        //                 //     $bankpanel.toggleClass('hide', contact.bankDetails.length == 0);
        //                 // });
        //             }
        //         }
        //     });
        // }

        function generateJournalReport() {
            var err = 0;
            $('.inp_error').removeClass('inp_error');

            var data = {};
            data.fromDate = $('#journal_date_from').val();
            data.toDate = $('#journal_date_to').val();

            if ($('#journal-show-exp-ledger').is(":checked")) {
                data.contactCategoryCode = $('#journal_contact_category').val();
                data.paymentContactCode = $('#journal_contact_filter').val();
            } else {
                data.paymentContactCode = $('#journal_contact').val();
            }
            // data.cashbookTypeCode = $('#journal_cashbooktype').val();
            data.acknowledgeStatus = $('#journal_tabs li.active').data('status');
            data.categoryCode = $('[name="journal-category-filter"]:checked').val();

            if (data.categoryCode == 'VEH') {
                data.referenceCode = $('#journal-vehicle-filter').val();
            } else if (data.categoryCode == 'BRN') {
                data.referenceCode = $('#journal-branch-filter').val();
            }
            $('#journal-ack-status').val(data.acknowledgeStatus);

            if (data.fromDate == '') {
                $('#journal_date_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#journal_date_to').addClass('inp_error');
                err++;
            }

            if ($('#journal-show-exp-ledger').is(":checked")) {
                if (data.contactCategoryCode == '' && data.paymentContactCode == '') {
                    $('#journal_contact_category').addClass('inp_error');
                    $('#journal_contact_filter').addClass('inp_error');
                    err++;
                }
            } else if (data.paymentContactCode == '') {
                $('#journal_contact').addClass('inp_error');
                err++;
            }

            if (data.fromDate != '' && data.toDate != '') {
                var a = moment(data.fromDate, 'YYYY-MM-DD');
                var b = moment(data.toDate, 'YYYY-MM-DD');
                var t = b.diff(a, 'days');
                if (t > 31) {
                    $('#journal_date_to').addClass('inp_error');
                    $('#journal_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#journal_action_state').html('Date range should be 31 days or less');
                    $('#journal_action_state').show();
                    err++;
                    return false;
                }
            }

            if (err > 0) {
                $('#journal_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#journal_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#journal_action_state').show();
                return false;
            } else {
                $('#journal_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#journal_action_state').html('');
                $('#journal_action_state').hide();
            }

            $('#journal_date_to').removeClass('inp_error');
            $('#journal-list-container').removeClass('hidden');
            $('[data-tabstatus="' + data.acknowledgeStatus + '"]').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "payment/journal-transaction-list",
                data: data,
                success: function(response) {
                    $('[data-tabstatus="' + data.acknowledgeStatus + '"]').html(response);
                    $('#journal-export-cont').show();
                    $("html, body").animate({
                        scrollTop: $('#journal-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }

        function clearJournalReport() {
            $('#journal_date_from').val('');
            $('#journal_date_to').val('');
            $('#journal_contact, #journal_contact_category').val('').trigger('change');
            // $('#journal_cashbooktype').val('NA').trigger('change');
            $('#journal-show-exp-ledger').prop('checked', false).trigger('change');
            $('#journal-list-container').addClass('hidden');
            $('#journal-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#journal_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#journal_action_state').html('');
            $('#journal_action_state').hide();
            $('#journal-export-cont').hide();
            $('input[name=journal-category-filter][value=VEH]').prop('checked', true).trigger('change');
        }

        function exportJournalExcel() {
            $('#export').val(1);
            document.journal_form.target = "ifrm_downloader";
            document.journal_form.submit();
            return;
        }

        function addJournalTransaction(code) {
            $('#journal-journal-dialog .inp_error').removeClass('inp_error');
            $('#journal-action-state').removeClass('alert-success alert-danger').html('').hide();

            if (code) {
                var journal = _.find(journalTransactionData, o => o.code == code);

                $('#journal-code').val(journal.code);
                $('#journal-payment-contact').val(journal.paymentContact.code).trigger('change');
                $('#journal-vendor-contact').val(journal.vendorContact.code).trigger('change');
                $('[name="journal-cashbook-category"][value="' + journal.cashbookCategory.code +  '"]').prop('checked', true).trigger('change');
                // $('#journal-expense').val(journal.cashbookType.code).trigger('change');
                $('#journal-amount').val(journal.transactionAmount);
                $('#journal-paydate').val(journal.paymentDate);
                $('#journal-reference').val(journal.referenceNumber);
                $('#journal-remarks').val(journal.remarks);
                $('#journal-tds').val(journal.tdsAmount);

                if (journal.cashbookCategory.code == 'VEH') {
                    $('#journal-vehicle').val(journal.referenceCode).trigger('change');
                } else if (journal.cashbookCategory.code == 'BRN') {
                    $('#journal-branch').val(journal.referenceCode).trigger('change');
                }
                journalFileUpload.clearFiles();
                if(journal.image > 0){
                    journalFileUpload.loadFiles({
                        referenceCode: journal.code, 
                        imageCategoryCode: 'JRNL'
                    });
                }
            } else {
                $('#journal-code').val('');
                $('#journal-payment-contact').val('').trigger('change');
                $('#journal-vendor-contact').val('').trigger('change');
                $('[name="journal-cashbook-category"][value="VEH"]').prop('checked', true).trigger('change');
                // $('#journal-expense').val('').trigger('change');
                $('#journal-amount').val('');
                $('#journal-tds').val('');
                $('#journal-paydate').val('');
                $('#journal-reference').val('');
                $('#journal-remarks').val('');

                $('#journal-vehicle').val('').trigger('change');
                $('#journal-branch').val('').trigger('change');
                journalFileUpload.clearFiles();
            }

            $('#journal-journal-dialog').css('background', '#fff');
            $('#journal-journal-dialog').removeClass('hide');
            $('#journal-journal-dialog').dialog({
                autoOpen: true,
                height: 450,
                width: 800,
                modal: true,
                resizable: false
            });
            $(".ui-dialog-titlebar").hide();
        }

        function cancelJournalTransaction() {
            $('#journal-journal-dialog').dialog('destroy');
            $('#journal-journal-dialog').hide();
        }

        function saveJournalTransaction() {
            var data = {};
            data.code = $('#journal-code').val();
            data.activeFlag = 1;
            data.paymentContact = {};
            data.paymentContact.code = $('#journal-payment-contact').val();
            data.vendorContact = {};
            data.vendorContact.code = $('#journal-vendor-contact').val();
            data.cashbookCategory = {};
            data.cashbookCategory.code = $('[name="journal-cashbook-category"]:checked').val();
            data.cashbookType = {};
            // data.cashbookType.code = $('#journal-expense').val();
            data.transactionAmount = $('#journal-amount').val();
            data.tdsAmount = $('#journal-tds').val();
            data.acknowledgeStatus = {};
            data.acknowledgeStatus.code = 'INIT';
            data.paymentDate = $.trim($('#journal-paydate').val());
            data.referenceNumber = $.trim($('#journal-reference').val());
            data.remarks = $('#journal-remarks').val();

            var err = 0;
            $('#journal-journal-dialog .inp_error').removeClass('inp_error');
            if (data.cashbookCategory.code == 'VEH') {
                data.referenceCode = $('#journal-vehicle').val();

                if (data.referenceCode == '') {
                    $('#journal-vehicle').addClass('inp_error');
                    err++;
                }
            } else if (data.cashbookCategory.code == 'BRN') {
                data.referenceCode = $('#journal-branch').val();

                if (data.referenceCode == '') {
                    $('#journal-branch').addClass('inp_error');
                    err++;
                }
            }

            if (data.paymentContact.code == '') {
                $('#journal-payment-contact').addClass('inp_error');
                err++;
            }
            if (data.vendorContact.code == '') {
                $('#journal-vendor-contact').addClass('inp_error');
                err++;
            }
            if (data.paymentContact.code == data.vendorContact.code) {
                $('#journal-payment-contact').addClass('inp_error');
                $('#journal-vendor-contact').addClass('inp_error');
                $('#journal-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#journal-action-state').html('Please select different payment and vendor contacts');
                $('#journal-action-state').show();
                return false;
            }
            // if (data.cashbookType.code == '') {
            //     $('#journal-expense').addClass('inp_error');
            //     err++;
            // }
            if (data.transactionAmount == '' || isNaN(data.transactionAmount)) {
                $('#journal-amount').addClass('inp_error');
                err++;
            }
            if (data.tdsAmount == '' || isNaN(data.tdsAmount)) {
                $('#journal-tds').addClass('inp_error');
                err++;
            }
            if (Number(data.tdsAmount) >= Number(data.transactionAmount)) {
                $('#journal-tds').addClass('inp_error');
                $('#journal-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#journal-action-state').html('TDS Amount should be lesser than transaction amount');
                $('#journal-action-state').show();
                return false;
            }
            if (data.paymentDate == '') {
                $('#journal-paydate').addClass('inp_error');
                err++;
            }
            if (data.referenceNumber == '') {
                $('#journal-reference').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#journal-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#journal-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#journal-action-state').show();
                return false;
            }

            $('#journal-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#journal-action-state').html(loading_popup).show();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'payment/update-journal-transaction',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $('#journal-action-state').addClass('alert-success');
                        $('#journal-action-state').html('Your request has been completed successfully');

                        setTimeout(function() {
                            $('#journal-action-state').hide();
                            journalFileUpload.startUpload({
                                referenceCode: response.data.code, 
                                imageCategoryCode: 'JRNL',
                                onComplete: cancelJournalTransaction
                            });
                        }, 1000);
                    } else {
                        $('#journal-action-state').addClass('alert-danger');
                        $('#journal-action-state').html(response.errorDesc);
                    }
                }
            });
        }

        function deleteJournalTransaction(code) {
            var data = _.find(journalTransactionData || [], i => i.code == code);
            data.activeFlag = 2;

            var loading_overlay = iosOverlay({
                text: "Deleting...",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "payment/update-journal-transaction",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        window.setTimeout(function () {
                            loading_overlay.hide();
                            generateJournalReport();
                        }, 2000);
                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                        window.setTimeout(function () {
                            loading_overlay.hide();
                        }, 2000);
                    }
                }
            });
        }

        function showJournalGallery(code) {
            journalFileUpload.showGalleryDialog({
                referenceCode: code,
                imageCategoryCode: 'JRNL'
            });
        }
    </script>
{/literal}
