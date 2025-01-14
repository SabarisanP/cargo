<div class="brand_top">
    <h3>Ledger Report</h3>
    <div class="text-right noprint">
        <div class="btn-group btn-group-sm" id="ledger-export-cont" style="display:none">
            <button class="btn btn-default" onclick="exportLedgerExcel();"><i
                    class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default"
                onclick="{if $namespace == 'seenutransports' || $namespace == 'seenucargo' }printLedgerWiseReport(){else}window.print(){/if}"><i class="fa fa-print fa-lg"></i> Print</button>
            <button class="btn btn-default"
                onclick="{if $namespace == 'seenutransports' || $namespace == 'seenucargo' }printSummaryReport(){else}window.print(){/if}"><i class="fa fa-print fa-lg"></i> SummaryPrint</button>
        </div>&emsp;
        <button class="btn btn-success" onclick="addLedgerAdjustment();">Add Receipt</button>
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

                                                <form id="ledger_form" method="post" name="ledger_form" action="payment/ledger-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-3">
                                                            <label for="ledger_rpt_date_range">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="ledger_rpt_date_range" readonly placeholder="Today" value="{implode(' | ', array_filter([$ffromDate|date_format:'%d-%m-%Y', $ftoDate|date_format:'%d-%m-%Y']))}">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-2">
                                                            <div>
                                                                <label for="checkbox">&nbsp;</label>
                                                                <div class="input-group">
                                                                    <label class="col-lg-12"><input type="checkbox" id="ledger-report-show-exp-ledger" onchange="showExpenseFilter(this);">&emsp;Expense Ledger</label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2" id="contact-filter">
                                                            <label for="ledger_contact_filter" class="req">Sub-Ledger A/c</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ledger_contact_filter" name="contactFilterCode" class="form-control select2" onchange="getCategoryContacts('FILTER')">
                                                                    <option value="">Select Sub-Ledger A/c</option>
                                                                    {foreach item=category key=k from=$category_contacts}
                                                                        {$tag = ''}
                                                                        {if in_array('CREDIT', $category->tag)}
                                                                            {$tag = 'CREDIT'}
                                                                        {elseif in_array('DEBIT', $category->tag)}
                                                                            {$tag = 'DEBIT'}
                                                                        {/if}
                                                                        <optgroup data-tag="{$tag}" label="{$category->name}" data-categorycode="{$k}">
                                                                        {foreach item=row from=$category->contacts}
                                                                            <option value="{$row->code}" data-taglist="{$row->tagList|implode:''|default:'NA'}" data-categorycode="{$row->contactCategory->code}" data-actioncode="{$row->contactCategory->actionCode}">{$row->name}</option>
                                                                        {/foreach}
                                                                        </optgroup>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="hide" id="expense-ledger-filter">
                                                            <div class="form-group col-md-2">
                                                                <label for="ledger_contact_category" class="req">Ledger A/C</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="ledger_contact_category" name="contactCategoryCode" class="form-control select2">
                                                                        <option value="">Select Ledger A/C</option>
                                                                        {foreach item=category from=$category_contacts key=key}
                                                                            {if in_array('EXPLGR', $category->tag)}
                                                                                {$tag = ''}
                                                                                {if in_array('CREDIT', $category->tag)}
                                                                                    {$tag = 'CREDIT'}
                                                                                {elseif in_array('DEBIT', $category->tag)}
                                                                                    {$ = 'DEBIT'}
                                                                                {/if}
                                                                                <option value="{$category->code}" data-tag="{$tag}">{$category->name}</option>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>

                                                            <div class="form-group col-md-2">
                                                                <label for="ledger_contact" class="req">Sub-Ledger A/c</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="ledger_contact" name="contactCode" class="form-control select2" onchange="getCategoryContacts('FILTER')">
                                                                        <option value="">Select Sub-Ledger A/c</option>
                                                                        {foreach item=category key=k from=$category_contacts}
                                                                            {if in_array('EXPLGR', $category->tag)}
                                                                                {$tag = ''}
                                                                                {if in_array('CREDIT', $category->tag)}
                                                                                    {$tag = 'CREDIT'}
                                                                                {elseif in_array('DEBIT', $category->tag)}
                                                                                    {$tag = 'DEBIT'}
                                                                                {/if}
                                                                                <optgroup label="{$category->name}" data-tag="{$tag}" data-categorycode="{$k}">
                                                                                {foreach item=row from=$category->contacts}
                                                                                    <option value="{$row->code}" data-taglist="{$row->tagList|implode:''|default:'NA'}" data-categorycode="{$row->contactCategory->code}" data-actioncode="{$row->contactCategory->actionCode}">{$row->name}</option>
                                                                                {/foreach}
                                                                                </optgroup>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        {* <div class="form-group col-md-2 hide" id="ledger-report-expense-type">
                                                            <label for="ledger_expense_head">Expense Type</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ledger_expense_head" name="cashbookTypeCode" class="form-control select2">
                                                                    <option value="">Select Expense</option>
                                                                    {foreach item=row from=$triphead} 
                                                                        {if $row->transactionType ==  'Dr'}
                                                                            <option value="{$row->code}">{$row->name}</option>
                                                                        {/if}
                                                                    {/foreach} 
                                                                </select>
                                                            </div>
                                                        </div> *}

                                                        <div class="form-group col-md-2 hide" id="ledger_bank_account_cont">
                                                            <label for="ledger_bank_account">Bank Account</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ledger_bank_account" name="accountCode" class="form-control select2"></select>
                                                            </div>
                                                        </div>
                                                        {* <div class="col-md-2">
                                                            <label>Remarks</label>
                                                            <select id="ledger-remark" class="form-control col-md-3">
                                                                <option value="0">Without Remarks</option>
                                                                <option value="1">With Remarks</option>
                                                            </select>
                                                        </div> *}

                                                        <br class="clear_fix_both">
                                                        <div class="col-lg-2">
                                                            <div>
                                                                <label for="checkbox">&nbsp;</label>
                                                                <div class="input-group">
                                                                    <label class="col-lg-12"><input type="checkbox" id="ledger-remark" name="requiredRemark">&emsp;With Remarks</label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group  col-lg-2" id="ledger-ref-type-section">
                                                            <div onchange="setTimeout(toggleReferenceCode)">
                                                                <label for="ledger-reference-type">&nbsp;</label>
                                                                <span class="radio d-inline-block">
                                                                    <label><input type="radio" name="ledger-reference-type" value="VEH" checked> Vehicle</label>
                                                                </span>&emsp;
                                                                <span class="radio d-inline-block">
                                                                    <label><input type="radio" name="ledger-reference-type" value="BRN"> Branch</label>
                                                                </span>&emsp;
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-lg-2 cont">
                                                            <label for="ledger-vehicle">Vehicle</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ledger-vehicle" class="form-control select2" name="vehicleReferenceCode">
                                                                    <option value="">Select Vehicle</option>
                                                                    {foreach item=row from=$vehicles}
                                                                        <option value="{$row->code}">{$row->registationNumber} - {$row->ownershipType->name}</option>
                                                                    {/foreach} 
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-lg-2 cont hide">
                                                            <label for="ledger-branch">Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ledger-branch" class="form-control select2" name="branchReferenceCode">
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
                                                                <input type="hidden" id="fromDate" name="fromDate">
                                                                <input type="hidden" id="toDate" name="toDate">
                                                                <input type="hidden" name="ledgerReferenceType" id="ledgerReferenceType" value="">
                                                                <input type="hidden" name="showExpenseLedgerContact" id="showExpenseLedgerContact" value="">
                                                                <button class="btn btn-success" type="button" onclick="generateLedgerReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearLedgerReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>

                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="ledger_action_state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="hidden" id="ledger-list-container">
                        <br>
                        <div id="ledger-list"></div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<div id="ledger-adjustment-dialog" class="hide dialog-content-page noprint">
    <div class="m-t-4">
        <form role="form">
            <div class="row">
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="req" for="adjustment-type-cb">Select Entry Category</label>
                        <input type="checkbox" id="adjustment-type-cb" class="bsn_switch" data-on-text="Expense" data-off-text="Income" checked>
                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="hide" id="income-head-panel">
                        <label class="req" for="adjustment-income">Income Type</label>
                        <select id="adjustment-income" class="form-control">
                            <option value="">Select Income</option>
                            {foreach item=row from=$triphead} 
                                {if $row->transactionType ==  'Cr'}
                                    <option value="{$row->code}">{$row->name}</option>
                                {/if}
                            {/foreach} 
                        </select>
                    </div>
                    <div id="expense-head-panel">
                        <label class="req" for="adjustment-expense">Expense Type</label>
                        <select id="adjustment-expense" class="form-control">
                            <option value="">Select Expense</option>
                            {foreach item=row from=$triphead} 
                                {if $row->transactionType ==  'Dr'}
                                    <option value="{$row->code}">{$row->name}</option>
                                {/if}
                            {/foreach} 
                        </select>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="form-group">
                        <label class="req" for="adjustment-amount">Amount</label>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rupee"></i></span>
                            <input type="number" placeholder="Amount" id="adjustment-amount" name="amount" class="form-control no-spin" min="0">
                        </div>
                    </div>
                </div>
            </div>
            <div class="clear_fix_both"></div>

            <div class="row">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="adjustment-mode" class="req">Payment Mode</label>
                        <select id="adjustment-mode" class="form-control">
                            <option value="">Select a mode</option>
                            {foreach name=o item=row from=$t_mode}
                                <option value="{$row->code}">{$row->name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="form-group">
                        <label class="req" for="adjustment-contact">Ledger A/C</label>
                        <div class="input-group col-md-12">
                            <select id="adjustment-contact" name="contactCode" class="form-control select2" onchange="getCategoryContacts('ADD')">
                                <option value="">Select Ledger A/C</option>
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
                </div>

                <div class="col-md-3 hide" id="adjustment-bank-account-cont">
                    <div class="form-group">
                        <label for="adjustment-bank-account">Bank Account</label>
                        <div class="input-group col-md-12">
                            <select id="adjustment-bank-account" name="accountCode" class="form-control select2"></select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clear_fix_both"></div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="form-group">
                        <label for="adjustment-remarks">Remarks</label>
                        <textarea id="adjustment-remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="2" cols="10" name="remark" id="remark" maxlength="120"></textarea>
                    </div>
                </div>
            </div>
            <div class="clear_fix_both"></div>
        </form>
    </div>
    <div class="clear_fix_both">
        <div class="alert" style="display: none;" id="adjustment-action-state"></div>
        <div class="align-right" id="adjustment-form-bttons">
            <button class="btn btn-success" type="button" onclick="saveLedgerAdjustment();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelLedgerAdjustment();">Cancel</button>
        </div>
    </div>
</div>

<style>
.switch-id-adjustment-type-cb {
    width: 80%;
}
</style>

<script>
    var allContactData = {$contact|json_encode}
    var ledger_contact = $('#ledger_contact optgroup');
    var emptyLedgerContactOption = '<option value="">Select Sub-Ledger A/c</option>';
  var secretObject;
</script>
{literal}
    <script>
       
        $('#ledger_rpt_date_range').daterangepicker({
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

        $('.select2').select2();

        $('#adjustment-income').select2();
        $('#adjustment-expense').select2();

        $('.bsn_switch').bootstrapSwitch();
        $('#adjustment-type-cb').on('switchChange.bootstrapSwitch', function () {
            $('#income-head-panel').addClass('hide');
            $('#expense-head-panel').addClass('hide');
            $('#expense-vendor-panel').addClass('hide');
            if (this.checked) {
                $('#expense-head-panel').removeClass('hide');
            } else {
                $('#income-head-panel').removeClass('hide');
            }
        });

        $('#ledger_contact_category').on('change', function() {
            var category = $(this).val();
            $('#ledger_contact').html(function () {
                return ledger_contact.filter(function () {
                    if (category != "") {
                        return $(this).data('categorycode') == category;
                    } else {
                        return isNotNull($(this).data('categorycode'));
                    }
                });
            }).prepend(emptyLedgerContactOption).val('').trigger('change');
        });

        function showExpenseFilter(ele) {
            $('#contact-filter, #expense-ledger-filter').addClass('hide');
            if ($(ele).is(":checked")) {
                $('#expense-ledger-filter').removeClass('hide');
            } else {
                $('#contact-filter').removeClass('hide');
            }
        }

        // $('#ledger_contact').on('change', function() {
        //     $('#ledger-ref-type-section').addClass('hide');
        //     $('#ledger-vehicle, #ledger-branch').closest('.cont').addClass('hide');
        //     var actionCode = $('#ledger_contact option:selected').data('actioncode');
        //     if (actionCode == 'EXP' || actionCode == 'STWF') {
        //         $('#ledger-ref-type-section').removeClass('hide');
        //         $('input[name=ledger-reference-type][value=VEH]').prop('checked', true).trigger('change');
        //     }
        // });

        function getCategoryContacts(type) {
            if (type == 'FILTER') {
                var $contact = $('#ledger_contact');
                var $bankaccount = $('#ledger_bank_account');
                var $bankpanel = $('#ledger_bank_account_cont');
            } else if (type == 'ADD') {
                var $contact = $('#adjustment-contact');
                var $bankaccount = $('#adjustment-bank-account');
                var $bankpanel = $('#adjustment-bank-account-cont');
            }
            var contactCode = $contact.val();
            $bankpanel.addClass('hide');
            if (!contactCode) {
                return;
            }
            var contact = _.find(allContactData, e => e.code == contactCode);
            $bankaccount.html(new Option('Select Bank', 'NA'));
            $.each(contact.bankDetails || [], function (i, bank) {
                $bankaccount.append(new Option(bank.name, bank.code));
            });
            $bankaccount.select2('val', 'NA');

            if (contact.bankDetails.length > 0) {
                $bankpanel.removeClass('hide', );
            }
        }

        function generateLedgerReport() {
            var data = {};
            var daterange = $('#ledger_rpt_date_range').data('daterangepicker');
            data.fromDate = daterange.startDate.format('DD-MM-YYYY');
            data.toDate = daterange.endDate.format('DD-MM-YYYY');
            data.showExpenseLedgerContact = $('#ledger-report-show-exp-ledger').is(':checked') ? 1 : 0;
            if (data.showExpenseLedgerContact == 1) {
                data.contactCategoryCode = $('#ledger_contact_category').val();
                data.contactCode = $('#ledger_contact').val();
                data.contactType = $('#ledger_contact option:selected').data('taglist');
                if (isNull(data.contactType)) {
                    data.contactType = $('#ledger_contact_category option:selected').data('tag');
                    console.log(data.contactType)
                }
            } else {
                data.contactFilterCode = $('#ledger_contact_filter').val();
                data.contactType = $('#ledger_contact_filter option:selected').data('taglist');
                if (isNull(data.contactType)) {
                    data.contactType = $('#ledger_contact_filter option:selected').closest('optgroup').data('tag');
                }
            }
            data.accountCode = $('#ledger_bank_account').val();

            data.ledgerReferenceType = $('input[name=ledger-reference-type]:checked').val();
            data.vehicleReferenceCode = $('#ledger-vehicle').val();
            data.branchReferenceCode = $('#ledger-branch').val();
            data.requiredRemark = $('#ledger-remark').is(':checked') ? 1 : 0;

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if ($('#ledger-report-show-exp-ledger').is(":checked")) {
                if (data.contactCategoryCode == '' && data.contactCode == '') {
                    $('#ledger_contact_category').addClass('inp_error');
                    $('#ledger_contact').addClass('inp_error');
                    err++;
                }
            } else if (data.contactCode == '') {
                $('#ledger_contact_filter').addClass('inp_error');
                err++;
            }
            if (data.contactFilterCode == '') {
                $('#ledger_contact_filter').addClass('inp_error');
                err++;
            }
            
            if (data.fromDate != '' && data.toDate != '') {
                var a = moment(data.fromDate, 'DD-MM-YYYY');
                var b = moment(data.toDate, 'DD-MM-YYYY');
                var t = b.diff(a, 'days');
                if (t > 31) {
                    $('#ledger_rpt_date_range').addClass('inp_error');
                    $('#ledger_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#ledger_action_state').html('Date range should be 31 days or less');
                    $('#ledger_action_state').show();
                    err++;
                    return false;
                }
            }

            if (err > 0) {
                $('#ledger_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#ledger_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#ledger_action_state').show();
                return false;
            } else {
                $('#ledger_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#ledger_action_state').html('');
                $('#ledger_action_state').hide();
            }

            $('#ledger_rpt_date_range').removeClass('inp_error');
            $('#ledger-list-container').removeClass('hidden');
            $('#ledger-list').html(loading_popup);
            secretObject = data;
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "payment/ledger-report-list",
                data: data,
                success: function(response) {
                    $('#ledger-list').html(response);
                    $('#ledger-export-cont').show();
                    $("html, body").animate({
                        scrollTop: $('#ledger-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }

        function printLedgerWiseReport() {
                $('#export').val('');
                delete secretObject.Summaryprint;
                secretObject.print = '1';
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "payment/ledger-report-list",
                    data: secretObject,
                    success: function(response) {
                        var iframe = $('<iframe>', {
                            id: 'printFrame',
                            width: '1px',
                            height: '1px',
                            css: {
                                position: 'absolute',
                                left: '-9999px',
                                top: '-9999px'
                            }
                        }).appendTo('body');

                        var doc = iframe[0].contentWindow.document;
                        doc.open();
                        doc.write(response);
                        doc.close();

                        // Call the print function after the iframe content has loaded
                        iframe.ready(function() {
                            iframe[0].contentWindow.print();
                        });
                    }
                });

            }

            function printSummaryReport() {
                $('#export').val('');
                delete secretObject.print;
                secretObject.Summaryprint = '1';
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "payment/ledger-report-list",
                    data: secretObject,
                    success: function(response) {
                        var iframe = $('<iframe>', {
                            id: 'printFrame',
                            width: '1px',
                            height: '1px',
                            css: {
                                position: 'absolute',
                                left: '-999px',
                                top: '-999px'
                            }
                        }).appendTo('body');

                        var doc = iframe[0].contentWindow.document;
                        doc.open();
                        doc.write(response);
                        doc.close();

                        // Call the print function after the iframe content has loaded
                        iframe.ready(function() {
                            // Adjusting page size
                            // $(doc.body).css({
                            //     width: '105mm', // Width of A6 size paper
                            //     height: '148mm', // Height of A6 size paper
                            //     margin: '0 auto' // Center the content horizontally
                            // });

                            iframe[0].contentWindow.print();
                        });
                    }
                });

            }

        function clearLedgerReport() {
            $('#ledger_rpt_date_range').val('');
            $('#ledger_rpt_date_range').data('daterangepicker').setStartDate({});
            $('#ledger_rpt_date_range').data('daterangepicker').setEndDate({});
            $('#ledger-list-container').addClass('hidden');
            $('#ledger-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#ledger_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#ledger_action_state').html('');
            $('#ledger_action_state').hide();
            $('#ledger_contact_category').val('').trigger('change');
            $('#ledger-report-show-exp-ledger').prop('checked', false).trigger('change');
            $('#ledger_contact, #ledger_contact_filter').val('').trigger('change');
            $('#ledger-export-cont').hide();
            $('input[type="radio"][value="VEH"]').prop('checked', true).trigger('change');
            $('#ledger-vehicle').val('').trigger('change');
            $('#ledger-branch').val('').trigger('change');
        }

        function exportLedgerExcel() {
            var daterange = $('#ledger_rpt_date_range').data('daterangepicker');
            var fromDate = daterange.startDate.format('DD-MM-YYYY');
            var toDate = daterange.endDate.format('DD-MM-YYYY');
            $('#fromDate').val(fromDate);
            $('#toDate').val(toDate);
            var ledgerReferenceType = $('input[name=ledger-reference-type]:checked').val();
            var showExpenseLedgerContact = $('#ledger-report-show-exp-ledger').is(':checked') ? 1 : 0;
            $('#ledgerReferenceType').val(ledgerReferenceType);
            $('#showExpenseLedgerContact').val(showExpenseLedgerContact);
            $('#export').val(1);
            document.ledger_form.target = "ifrm_downloader";
            document.ledger_form.submit();
            return;
        }

        function addLedgerAdjustment() {
            $('#ledger-adjustment-dialog .inp_error').removeClass('inp_error');
            $('#adjustment-action-state').removeClass('alert-success alert-danger').html('').hide();
            $('#adjustment-remarks').val('');
            $('#adjustment-type-cb').prop('checked', true).trigger('change');
            $('#adjustment-expense').val('').trigger('change');
            $('#adjustment-income').val('').trigger('change');
            $('#adjustment-contact').val('').trigger('change');
            $('#adjustment-amount').val('');
            $('#adjustment-mode').val('');

            $('#ledger-adjustment-dialog').css('background', '#fff');
            $('#ledger-adjustment-dialog').removeClass('hide');
            $('#ledger-adjustment-dialog').dialog({
                autoOpen: true,
                height: 400,
                width: 800,
                modal: true,
                resizable: false
            });
            $(".ui-dialog-titlebar").hide();
        }

        function cancelLedgerAdjustment() {
            $('#ledger-adjustment-dialog').dialog('destroy');
            $('#ledger-adjustment-dialog').hide();
        }

        function saveLedgerAdjustment() {
            var data = {};
            data.activeFlag = 1;
            data.referenceCode = $.trim($('#adjustment-reference').val());
            data.description = $.trim($('#adjustment-remarks').val());
            data.cashbookType = {};
            data.contact = {};
            data.contact.code = $.trim($('#adjustment-contact').val());
            data.contactBankDetails = {};
            data.contactBankDetails.code = $('#adjustment-bank-account').val();
            data.transactionMode = {};
            data.transactionMode.code = $('#adjustment-mode').val();

            var err = 0;
            $('#ledger-adjustment-dialog .inp_error').removeClass('inp_error');

            var cashbookCategory = $('#adjustment-type-cb').is(':checked');
            if (cashbookCategory) {
                data.cashbookType.code = $('#adjustment-expense').val();
                data.creditAmount = 0;
                data.debitAmount = $('#adjustment-amount').val();

                if (data.cashbookType.code == '') {
                    $('#adjustment-expense').addClass('inp_error');
                    err++;
                }
                if (data.debitAmount == '' || isNaN(data.debitAmount) || Number(data.debitAmount) <= 0) {
                    $('#adjustment-amount').addClass('inp_error');
                    err++;
                }
            } else {
                data.cashbookType.code = $('#adjustment-income').val();
                data.creditAmount = $('#adjustment-amount').val();
                data.debitAmount = 0;

                if (data.cashbookType.code == '') {
                    $('#adjustment-income').addClass('inp_error');
                    err++;
                }
                if (data.creditAmount == '' || isNaN(data.creditAmount) || Number(data.creditAmount) <= 0) {
                    $('#adjustment-amount').addClass('inp_error');
                    err++;
                }
            }

            if (data.contact.code == '') {
                $('#adjustment-contact').addClass('inp_error');
                err++;
            }
            if (data.transactionMode.code == '') {
                $('#adjustment-mode').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#adjustment-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#adjustment-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#adjustment-action-state').show();
                return false;
            }

            $('#adjustment-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#adjustment-action-state').html(loading_popup).show();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'payment/update-ledger-adjustment',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $('#adjustment-action-state').addClass('alert-success');
                        $('#adjustment-action-state').html('Your request has been completed successfully');
                        setTimeout(function () {
                            cancelLedgerAdjustment();
                        }, 1500);
                    } else {
                        $('#adjustment-action-state').addClass('alert-danger');
                        $('#adjustment-action-state').html(response.errorDesc);
                    }
                }
            });
        }

        function toggleReferenceCode() {
            var category = $('[name="ledger-reference-type"]:checked').val();
            $('#ledger-vehicle').closest('.cont').addClass('hide');
            $('#ledger-branch').closest('.cont').addClass('hide');

            if (category == 'VEH') {
                $('#ledger-vehicle').closest('.cont').removeClass('hide');
            } else if (category == 'BRN') {
                $('#ledger-branch').closest('.cont').removeClass('hide');
            }
        }
    </script>
{/literal}
