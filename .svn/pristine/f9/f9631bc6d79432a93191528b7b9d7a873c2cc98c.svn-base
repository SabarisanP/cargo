<div class="brand_top">
    <h3>Income / Expense</h3>
    <div class="text-right noprint">
        <a href="#payment/manage-expense" class="btn btn-success btn-sm"><i class="fa fa-arrow-left"></i>&nbsp;Back to listings</a>
    </div>
</div>

<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-lg-12"> <br>
                <!-- PAGE HEADER-->
                <div class="row" style="width: 65%; margin-left: auto; margin-right: auto; display: flex; justify-content: center;">
                    <div class="col-lg-12 income-expense-pannel">
                        <div class="panel panel-default" style="padding: 35px;">
                            <h2><i class="fa fa-ticket"></i><b>Income / Expense Entry Details</b></h2>
                            <div class="clearfix"></div>
                            <div class="row fstheading">
                                <div class="col-lg-4 form-group">
                                    <h4><b>Select Entry Category</b></h4>
                                    <small><b>Select Income or Expense category</b></small>
                                    <div class="clearfix"></div><br>
                                    <input type="checkbox" name="exptyperadio" id="expense-type-cb" class="bsn_switch expense-type-cb" data-on-text="Expense" data-off-text="Income" checked>
                                </div>
                                <div class="col-lg-4"><br>
                                    <div class="clearfix"></div><br><br>
                                    <div class="form-group-inline">
                                        <label for="tsr_travel_date" class="form-group req pt10 col-md-4">Date</label>
                                        <div class="clearfix"></div>
                                        <div>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                <input type="text" name="travel_date" class="form-control sdate " id="expenses-date" readonly="true" placeholder="Date From">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-6 radiobtn"><br><br>
                                    <div class=" input-group">
                                        <label class="radio-inline">
                                            <input type="radio" name="exptabradio" class="expense-type-radio" id="tab-branch" value="BRN" checked>Branch
                                        </label>

                                        <label class="radio-inline">
                                            <input type="radio" name="exptabradio" class="expense-type-radio" id="tab-vehicle" value="VEH">Vehicle
                                        </label>

                                        {if $namespace != 'rathimeenaparcel'}
                                            <label class="radio-inline">
                                                <input type="radio" name="exptabradio" class="expense-type-radio" id="tab-transit" value="TRN">Transit
                                            </label>

                                            <label class="radio-inline">
                                                <input type="radio" name="exptabradio" class="expense-type-radio" id="tab-lr" value="LR">LR
                                            </label>

                                            <label class="radio-inline">
                                                <input type="radio" name="exptabradio" class="expense-type-radio" id="tab-others" value="OT">Others
                                            </label>
                                        {/if}
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="income-expense-pannel">
                                    <div class="col-lg-12" id="search-panel">
                                        <div class="clearfix"></div><br><br>
                                        <div id="expense-v2-section">
                                            <div class="col-md-6">
                                                <div id="setting_brn" class="active">
                                                    <div>
                                                        <label for="ref-organization" class="req">Branch</label>
                                                        <select id="ref-organization" class="form-control" {if $action_rights['IE-BEHALF-BRACH'] != 1 || $action_rights['IE-BEHALF-ALL'] != 1}disabled="disabled" {/if}>
                                                            <option value="">Select a Branch</option>
                                                            {foreach from=$organizations item=row}
                                                                <option value="{$row->code}" {if $logged_in_usr_org_code == $row->code}selected{/if}>{$row->name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                                <div id="setting_veh" class="hide">
                                                    <div>
                                                        <label for="ref-vehicle" class="req">Vehicle</label>
                                                        <select id="ref-vehicle" class="form-control">
                                                            <option value="">Select a Vehicle</option>
                                                            {foreach from=$vehicles item=row}
                                                                <option value="{$row->code}">{$row->registationNumber}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                                <div id="setting_trn" class="hide">
                                                    <div>
                                                        <label for="ref-transit" class="req">Transit</label>
                                                        <div id="ref-transit-cont">
                                                            <select id="ref-transit" class="form-control">
                                                                <option value="">Select a Transit</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="setting_lre" class="hide">
                                                    <div class="">
                                                        <label class="req" for="date_from">Enter LR</label>
                                                        <div class="form-group">
                                                            <input type="text" name="lr" class="form-control sdate input_capital" id="ref-lr" placeholder="Enter LR" onblur="checklr()">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="setting_ot" class=""></div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="form-group text-left hide" id="income-head-panel">
                                                    <label class="req" for="seat-sch-date">Income Type</label>
                                                    <select id="expense-income" class="form-control">
                                                        <option value="">Select Income</option>
                                                        {foreach item=row from=$triphead}
                                                            {if $row->transactionType ==  'Cr'}
                                                                <option value="{$row->code}" data-tags="{$row->tag|implode:','}">{$row->name}</option>
                                                            {/if}
                                                        {/foreach}
                                                    </select>
                                                </div>
                                                <div class="form-group text-left" id="expense-head-panel">
                                                    <label class="req" for="seat-sch-date">Expense Type</label>
                                                    <select id="expense-expense" class="form-control">
                                                        <option value="">Select Expense</option>
                                                        {foreach item=row from=$triphead}
                                                            {if $row->transactionType ==  'Dr'}
                                                                <option value="{$row->code}" data-tags="{$row->tag|implode:','}">{$row->name}</option>
                                                            {/if}
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="hide" id="expense-v2-others-section">
                                            <div class="col-lg-6">
                                                <label class="req" for="expense-v2-to-amount-received">Amount Receiver</label>
                                                <input type="text" id="expense-v2-to-amount-received" placeholder="Amount Receiver" class="form-control">
                                            </div>
                                            <div class="col-lg-6">
                                                <label class="req" for="expense-v2-approved-by">Approved By</label>
                                                <input type="text" id="expense-v2-approved-by" placeholder="Approved By" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <!--row end-->
                                </div>
                                <!--content end-->
                            </div>

                            <div class="clearfix"></div>
                            <hr>
                            <div class="clearfix"></div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="row">
                                        <div class="col-md-6" id="show-staff-detail">
                                            <div class="form-group">
                                                <a href="javascript:;" onclick="showBranchStaff();">Add staff income / expense</a>
                                            </div>
                                        </div>
                                        <div class="col-md-6 hide" id="hide-staff-detail">
                                            <div class="form-group">
                                                <a href="javascript:;" onclick="hideBranchStaff();">Hide staff income / expense</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="row">
                                        <div class="col-md-6" id="show-driver-detail">
                                            <div class="form-group">
                                                <a href="javascript:;" onclick="showBranchDriver();">Add driver income /expense</a>
                                            </div>
                                        </div>
                                        <div class="col-md-6 hide" id="hide-driver-detail">
                                            <div class="form-group">
                                                <a href="javascript:;" onclick="hideBranchDriver();">Hide driver income / expense</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="row StaffDriver">
                                        {* staff details *}
                                        <div class="col-md-12 hide" id="add-staff-details">
                                            <table class="table table-striped" width="100%" id="branch-staff-table">
                                                <thead>
                                                    <tr>
                                                        <td class="bold req" width="50%">Staff Name</td>
                                                        <td class="bold req" width="40%">Amount</td>
                                                        {* <td width="10%">
                                                            <a href="javascript:;" onclick="addBranchStaff();" class="btn btn-sm btn-default"><i class="fa fa-plus"></i></a>
                                                        </td> *}
                                                    </tr>
                                                </thead>
                                                <tbody id="branch-staff-list">
                                                    <tr class="branch-staff-row">
                                                        <td><input type="text" class="form-control expense-staff-name" autocomplete="off"></td>
                                                        <td><input type="number" placeholder="Amount" onchange="calculateAmount();" name="amount" class="form-control no-spin expense-staff-amount" step="any">
                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tfoot id="branch-staff-tpl" class="hide">
                                                    <tr class="branch-staff-row">
                                                        <td><input type="text" class="form-control expense-staff-name" autocomplete="off"></td>
                                                        <td><input type="number" placeholder="Amount" onchange="calculateAmount();" name="amount" class="form-control no-spin expense-staff-amount" step="any">
                                                        </td>
                                                        <td><a href="javascript:;" onclick="removeBranchStaff(this);" class="btn btn-sm btn-default"><i class="fa fa-minus"></i></a>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                {* driver Details *}
                                <div class="col-md-6">
                                    <div class="row ">
                                        <div class="col-md-12 hide" id="add-driver-details">
                                            <table class="table table-striped" width="100%" id="branch-driver-table">
                                                <thead>
                                                    <tr>
                                                        <td class="bold req" width="50%">Driver Name</td>
                                                        <td class="bold req" width="40%">Amount</td>
                                                        {* <td width="10%">
                                            <a href="javascript:;" onclick="addBranchStaff();" class="btn btn-sm btn-default"><i class="fa fa-plus"></i></a>
                                        </td> *}
                                                    </tr>
                                                </thead>
                                                <tbody id="branch-driver-list">
                                                    <tr class="branch-driver-row">
                                                        <td><input type="text" class="form-control expense-driver-name" autocomplete="off"></td>
                                                        <td><input type="number" placeholder="Amount" onchange="calculateAmount();" name="amount" class="form-control no-spin expense-driver-amount" step="any">
                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tfoot id="branch-driver-tpl" class="hide">
                                                    <tr class="branch-driver-row">
                                                        <td><input type="text" class="form-control expense-driver-name" autocomplete="off"></td>
                                                        <td><input type="number" placeholder="Amount" onchange="calculateAmount();" name="amount" class="form-control no-spin expense-driver-amount" step="any">
                                                        </td>
                                                        <td><a href="javascript:;" onclick="removeBranchDriver(this);" class="btn btn-sm btn-default"><i class="fa fa-minus"></i></a>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-12">
                                <label class="req">Remarks</label>
                                <textarea id="expense-remarks" placeholder="Enter your remarks" style="resize:none" class="form-control" rows="3" cols="30" name="remark" id="remark"></textarea>
                            </div>
                            <div class="clearfix"></div><br>
                            <div>
                                <div class="clearfix"></div>
                                <div class="col-lg-6">
                                    <label class="req">Amount</label>
                                    <input type="number" placeholder="Amount" id="expense-amount" name="amount text-left" class="form-control no-spin">
                                </div>

                                <div class="col-lg-6">
                                    <label class="req" for="seat-sch-date">Transaction Mode</label>
                                    <select id="expense-mode" class="form-control">
                                        <option value="">Select</option>
                                        {foreach name=o key=k item=name from=$f_t_mode}
                                            <option value="{$k}">{$name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="clearfix"></div><br>
                                <div class="col-lg-6" id="expense-vendor-panel">
                                    <div class="form-group">
                                        <label for="vendor_users" class="">Vendor</label>
                                        <select id="expense-vendor" class="form-control">
                                            <option value="">Select Vendor</option>
                                            {foreach item=vendor_usr from=$vendors}
                                                <option value="{$vendor_usr->code}">{$vendor_usr->name}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6 hide" id="expense-received-panel">
                                    <div class="form-group">
                                        <label for="vendor_users" class="">Received By</label>
                                        <input type="text" class="form-control" id="expense-received" placeholder="Received By">
                                    </div>
                                </div>
                            </div>

                            {if $action_rights['IE-TAGS']>0}
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label class="req" for="seat-sch-date">Tags</label>
                                        <select id="expense-tags" class="form-control" multiple>
                                            {foreach item=row from=$cargotags}
                                                {if $row->category->code == 'MGEXP'}
                                                    <option value="{$row->code}" {if in_array($row->code, $identicaltags)}selected{/if}>{$row->name}</option>
                                                {/if}
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            {/if}

                            <input type="hidden" id="reject-code" value="">
                            <input type="hidden" id="expense-code" value="">
                            <div class="clearfix"></div>
                            <div class="row no-gutters">
                                <div class="col-lg-6" style="display: flex; justify-content: flex-end;">
                                    {include file="site/cargo/file-upload-component.tpl" id="ie-fileupload" axis="horizontal"}
                                </div>

                                <div class="col-lg-6">
                                    <label>&nbsp;</label>
                                    <div class="" id="aspe-form-buttons">
                                        <button class="btn btn-success" type="button" onclick="saveExpenses();">Save</button>
                                        <button class="btn btn-default" type="button" onclick="clearExpenses();">Clear</button>
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                            <div class="alert" style="display: none;" id="expense-action-state"></div>

                        </div>
                    </div>

                    <div class="col-lg-12 hide payment-pannel">
                        <div class="panel panel-default">
                            <div class="col-md-8">
                                <h5><i class="fa fa-ticket"></i> Payment Details</h5>
                            </div>

                            <div class="clearfix"></div>
                            <div class="heading_b"></div>

                            <div class="col-lg-5 form-group w-auto">
                                <label class="" for="txn-rcpt-txn-type">&nbsp;</label>
                                <div class="input-group">
                                    <label class="radio-inline">
                                        <input type="radio" name="paymenttyperadio" class="payment-type-cb" value="TRANSPORTER" checked>Transporter&nbsp;
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="paymenttyperadio" class="payment-type-cb" value="FUEL">Fuel Vendor&nbsp;
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="paymenttyperadio" class="payment-type-cb" value="JOURNAL">Journal &nbsp;
                                    </label>
                                </div>
                            </div>
                            <div class="clearfix"><br></div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="req">Date</label>
                                    <div class="input-group">
                                        <input type="text" name="inc-exp-payment-daterange" class="form-control sdate" id="inc-exp-payment-daterange" readonly="true" placeholder="Date">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group text-left" id="payment-panel-vehicle">
                                    <label class="req">Vehicle</label>
                                    <select id="payment-vehicle" class="form-control">
                                        <option value="">Select Vehicle</option>
                                        {foreach item=row from=$vehicles}
                                            <option value="{$row->code}">{$row->registationNumber}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="form-group text-left hide" id="payment-panel-vendor">
                                    <label class="req">Vendor</label>
                                    <select id="payment-vendor" class="form-control">
                                        <option value="">Select Vendor</option>
                                        {foreach item=category from=$category_contacts}
                                            {foreach from=$category->contacts item=row}
                                                {if $row->contactCategory->actionCode == 'RAC'}
                                                    <option value="{$row->code}">{$row->name}</option>
                                                {/if}
                                            {/foreach}
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="form-group text-left hide" id="payment-panel-contact">
                                    <label class="req">Conatct</label>
                                    <select id="payment-contact" class="form-control">
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
                            </div>

                            <div class="col-lg-3">
                                <label>&nbsp;</label>
                                <div>
                                    <button class="btn btn-success" type="button" onclick="getTransitTransactionList();">Generate</button>
                                    <button class="btn btn-default" type="button" onclick="clearExpenses();">Clear</button>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="alert" style="display: none;" id="payment-action-state"></div>
                        </div>
                    </div>
                </div>

                <div class="row hide" id="expenses-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="expenses-list"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hide" id="payment-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="payment-list"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="make-payment-dialog" class="dialog-content-page hide">
    <div>
        <div class="row">
            <div class="form-group col-md-4">
                <label class="req">Transaction Mode</label>
                <select id="make-pay-txn-mode" class="form-control">
                    <option value="">Select Transaction Mode</option>
                    {foreach from=$transactionmode item=val key=k}
                        <option value="{$k}">{$val}</option>
                    {/foreach}
                </select>
            </div>

            <div class="form-group col-md-4">
                <label class="req">Amount</label>
                <input type="text" class="form-control" id="make-pay-amount" disabled placeholder="Amount">
            </div>
        </div>

        <div class="row">
            {* UPI *}
            <div class="hide" id="make-pay-upi">
                <div class="form-group col-md-4">
                    <label class="req">Organization Bank</label>
                    <select id="make-pay-bank-details" class="form-control">
                        <option value="">Select a Bank</option>
                        {foreach from=$bankdetail item=val}
                            {if $val->accountType->code != 'CASH'}
                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>

                <div class="form-group col-md-4">
                    <label class="req">UPI Id</label>
                    <input type="text" class="form-control" id="make-pay-upi-id" placeholder="UPI ID">
                </div>

                <div class="form-group col-md-4">
                    <label>Ref. #</label>
                    <input type="text" class="form-control" id="make-pay-upi-details" placeholder="Ref. #">
                </div>
            </div>

            {* NBK *}
            <div class="hide" id="make-pay-nbk">
                <div class="form-group col-md-4">
                    <label class="req">Organization Bank</label>
                    <select id="make-pay-bank-nbk" class="form-control">
                        <option value="">Select a Bank</option>
                        {foreach from=$bankdetail item=val}
                            {if $val->accountType->code != 'CASH'}
                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>

                <div class="form-group col-md-4">
                    <label class="req">Account Holder Name</label>
                    <input type="text" class="form-control" id="make-pay-acc-hold-name" placeholder="Account Holder Name">
                </div>

                <div class="form-group col-md-4" id="make-pay-bank-name-div">
                    <label class="req">Bank Name</label>
                    <input type="text" class="form-control" id="make-pay-bank-name" placeholder="Bank Name">
                </div>

                <div class="form-group col-md-4">
                    <label>Ref. #</label>
                    <input type="text" class="form-control" id="make-pay-nbk-details" placeholder="Ref. #">
                </div>
            </div>

            {* chq *}
            <div class="hide" id="make-pay-chq">
                <div class="form-group col-md-4">
                    <label class="req">Payer Details</label>
                    <input type="text" class="form-control" id="make-pay-payer" placeholder="Payer Details">
                </div>

                <div class="form-group col-md-4">
                    <label class="req">Cheque No</label>
                    <input type="text" class="form-control" id="make-pay-chq-num" placeholder="Cheque Number">
                </div>

                <div class="form-group col-md-4">
                    <label class="req">Cheque Date</label>
                    <div class="input-group">
                        <input type="text" class="form-control sdate" id="make-pay-chq-date" readonly placeholder="Cheque Date">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>

                <div class="form-group col-md-4" id="make-pay-chq-bankname-div">
                    <label class="req">Bank Name</label>
                    <input type="text" class="form-control" id="make-pay-chq-bankname" placeholder="Bank Name">
                </div>

                <div class="form-group col-md-4">
                    <label class="req">Bank City</label>
                    <input type="text" class="form-control" id="make-pay-chq-city" placeholder="Bank City">
                </div>
                <div class="col-md-4">
                    <label>Remarks</label>
                    <input type="text" class="form-control" placeholder="Remarks" id="make-pay-cheque-remarks" data-mask="englishonly" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <input type="hidden" id="make-pay-fuel-vendor" value="">
                <input type="hidden" id="make-pay-vehicleCode" value="">
                <input type="hidden" id="make-pay-type" value="">
                <div class="clear_fix_both">
                    <div class="alert hide" id="make-pay-action-state"></div>
                    <div class="align-right" id="make-pay-form-buttons">
                        <button class="btn btn-success" type="button" onclick="updatePayment();">Save</button>
                        <button class="btn btn-default" type="button" onclick="closeManageExpensePaymentDialog();">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script id="manage-exp-branch-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-12">
            <b class="branch-name"></b><br>
            <span class="alias-code text-muted small"></span>
        </div>
    </div>
</script>

<script id="manage-exp-driver-select-tpl-2" type="text/html">
    <div class="row">
        <div class="col-xs-12">
            <b class="Driver-name"></b><br>
        </div>
    </div>
</script>

<iframe name="ifrm_trans_downloader" id="ifrm_trans_downloader" style="display:none"></iframe>
<input type="hidden" id="logged-in-branch-code" value="{$logged_in_usr_org_code}">
<style>
    .nav-tabs>li>a,
    .nav-tabs>li.active>a {
        padding: 12px 25px 9px 25px !important;
    }

    .switch-id-expense-type-cb {
        width: 130px;
    }

    .file-upload-gallery.horizontal {
        padding: 12px !important;
    }

    .pt10 {
        padding-top: 0 !important;
    }

    .fstheading {
        padding-left: 15px;
    }

    .radiobtn {
        padding-left: 30px;
    }
</style>

<script>
    var allOrganizations = {$organizations|json_encode}
    var allVehicles = {$vehicles|json_encode}
    var allCargoTags = {$cargotags|json_encode}
    var identicalTags = {$identicaltags|json_encode};
    var bankNamesList = {$bank_names_list|json_encode}
    var organization = {$login_branch|json_encode}
    var branchStaff = {$branchStaff|json_encode}
    var driverDetails= {$driver|json_encode}
    var triphead = {$triphead|json_encode}
    var expenseIncome = $('#expense-income option');
    var expenseExpense = $('#expense-expense option');

    $('.bsn_switch').bootstrapSwitch();
    $('#container-fluid select:not(#expense-tags)').select2();
    $('[data-toggle="tooltip"]').tooltip()

    $('#make-pay-chq-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true,
        startDate: '-1d',
        endDate: '0d'
    });

    var branchstaffdata = [];
    $.each(branchStaff || [], function(i, row) {
        var branch = [];
        branch.id = row.code;
        branch.text = row.name;
        branch.aliasCode = row.aliasCode;
        branchstaffdata.push(branch);
    });

    var driverData = [];

    $.each(driverDetails || [], function(i, row) {
        var driver = [];
        driver.id = row.code;
        driver.text = row.name;
        driverData.push(driver);
    });

    $('#branch-staff-list .expense-staff-name').select2({
        data: { results: branchstaffdata },
        placeholder: 'Select Staff Name',
        formatResult: formatResult,
        formatSelection: formatResult,
        matcher: matcher
    });

    $('#branch-driver-list .expense-driver-name').select2({
        data: { results: driverData },
        placeholder: 'Select Driver Name',
        formatResult: formatResultDriver,
        formatSelection: formatResultDriver,
        matcher: matcher2
    });

    $('#expense-tags').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '100%',
        dropLeft: true,
        buttonClass: 'btn btn-default expense-tags'
    });

    $('#make-pay-bank-name').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#make-pay-bank-name-div'
    }).focus(function() {
        $(this).autocomplete('search', '');
    });

    $('#make-pay-chq-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#make-pay-chq-bankname-div'
    }).focus(function() {
        $(this).autocomplete('search', '');
    });

    $('#ref-organization').on('change', function() {
        // $('#branch-staff-list').html('');
        $('#expense-tags').val('').multiselect('refresh');
        var organizationCode = $(this).val();
        var branch = _.find(allOrganizations, function(o) { return o.code === organizationCode; });

        var branchTags = $.map(branch && branch.tag || [], function(obj) {
            var tag = obj.name.toLowerCase();
            return tag.replace(/[^a-zA-Z0-9-]/, '');
        });

        var cargoTags = $.map(allCargoTags || [], function(obj) {
            var tagName = obj.name.toLowerCase();
            var tag = tagName.replace(/[^a-zA-Z0-9-]/, '');
            if (obj.category.code == 'MGEXP' && $.inArray(tag, branchTags) != -1) {
                return obj.code;
            }
        });

        if (cargoTags.length > 0) {
            $('#expense-tags').val(cargoTags).multiselect('refresh');
        }

        var data = {};
        data.organizationCode = organizationCode;

        if (!data.organizationCode) {
            return;
        }
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "payment/get-branch-contact",
            data: data,
            success: function(res) {
                if (res.status == 1) {
                    branchStaff = res.data;
                    var branchstaffdata = [];
                    $.each(branchStaff || [], function(i, row) {
                        var branch = [];
                        branch.id = row.code;
                        branch.text = row.name;
                        branch.aliasCode = row.aliasCode;
                        branchstaffdata.push(branch);
                    });

                    $('#branch-staff-list .expense-staff-name').select2({
                        data: { results: branchstaffdata },
                        placeholder: 'Select Staff Name',
                        formatResult: formatResult,
                        formatSelection: formatResult,
                        matcher: matcher
                    });

                    var expenseCode = $('#expense-code').val();
                    var expenseData = _.find(allExpenses, function(o) { return o.transaction_code === expenseCode; });
                    if (expenseData && expenseData.cashbook_transaction_details) {
                        $('#add-staff-details').removeClass('hide');
                        var transactionDetails = expenseData.cashbook_transaction_details.split(',');
                        for (var i = 0; i < transactionDetails.length; i++) {
                            var person = transactionDetails[i].split(':');

                            if (person[0] == "DRVR") {
                                $('#branch-driver-list .expense-driver-name').val(person[1].trim()).trigger('change');
                                $('#branch-driver-list .expense-driver-amount').val(person[3]);
                                $('#expense-amount').prop('disabled', true);
                                $('#hide-driver-detail').removeClass('hide');
                                $('#show-driver-detail').addClass('hide');
                            } else {
                                $('#branch-staff-list .expense-staff-name').val(person[1].trim()).trigger('change');
                                $('#branch-staff-list .expense-staff-amount').val(person[3]);
                                $('#expense-amount').prop('disabled', true);
                                $('#hide-staff-detail').removeClass('hide');
                                $('#show-staff-detail').addClass('hide');
                            }
                        }

                    }
                }
            }
        })
    });

    $('#ref-vehicle').on('change', function() {
        $('#expense-tags').val('').multiselect('refresh');

        var vehicleCode = $(this).val();
        var vehicle = _.find(allVehicles, function(o) { return o.code === vehicleCode; });

        var vehicleTags = $.map(vehicle && vehicle.tag || [], function(obj) {
            var tag = obj.name.toLowerCase();
            return tag.replace(/[^a-zA-Z0-9-]/, '');
        });

        var cargoTags = $.map(allCargoTags || [], function(obj) {
            var tagName = obj.name.toLowerCase();
            var tag = tagName.replace(/[^a-zA-Z0-9-]/, '');
            if (obj.category.code == 'MGEXP' && $.inArray(tag, vehicleTags) != -1) {
                return obj.code;
            }
        });

        if (cargoTags.length > 0) {
            $('#expense-tags').val(cargoTags).multiselect('refresh');
        }
    });

    income_expense_type_based('BRN')
    $('input[type="radio"][name="exptabradio"]').on('change', function() {
        $('#setting_brn,#setting_veh, #setting_trn, #setting_lre').addClass('hide');
        $('#show-staff-detail, #hide-staff-detail, #add-staff-details').addClass('hide');
        $('#show-driver-detail, #hide-driver-detail,#add-driver-details').addClass('hide');
        // $('#branch-staff-list').html('');
        $('#expense-tags').val('').multiselect('refresh');
        $('#expense-amount').prop('disabled', false);
        $('#expense-v2-section').removeClass('hide');
        $('#expense-v2-others-section').addClass('hide');

        var type = this.value;
        income_expense_type_based(type)
        if (type == 'BRN') {
            $('#setting_brn').removeClass('hide');
            $('#show-staff-detail').removeClass('hide');
            $('#show-driver-detail').removeClass('hide');
        } else if (type == 'VEH') {
            $('#setting_veh').removeClass('hide');
        } else if (type == 'TRN') {
            $('#setting_trn').removeClass('hide');
        } else if (type == 'LR') {
            $('#setting_lre').removeClass('hide');
        } else if (type == 'OT') {
            $('#expense-v2-section').addClass('hide');
            $('#expense-v2-others-section').removeClass('hide');
        }
    });

    $('input[type="checkbox"][name="exptyperadio"]').on('change', function() {
        $('#income-head-panel, #expense-head-panel').addClass('hide');
        $('#expense-vendor-panel, #expense-received-panel').addClass('hide');
        $('.income-expense-pannel, .payment-pannel, #expenses-list-container, #payment-list-container').addClass('hide');

        if ($(this).prop('checked')) {
            $('#expense-head-panel, .income-expense-pannel, #expenses-list-container').removeClass('hide');
            $('#expense-vendor-panel, #expense-received-panel').removeClass('hide');
        } else {
            $('#income-head-panel, .income-expense-pannel, #expenses-list-container').removeClass('hide');
        }
    });

    $('#expense-type-cb').on('switchChange.bootstrapSwitch', function() {
        var type = $('input[type="radio"][name="exptabradio"]:checked').val();
        income_expense_type_based(type)
        $('#income-head-panel').addClass('hide');
        $('#expense-head-panel').addClass('hide');
        $('#expense-vendor-panel').addClass('hide');
        $('#expense-received-panel').addClass('hide');
        if (this.checked) {
            $('#expense-vendor-panel').removeClass('hide');
            $('#expense-head-panel').removeClass('hide');
        } else {
            $('#income-head-panel').removeClass('hide');
            $('#income-expense-pannel').removeClass('hide');
            $('#expense-received-panel').removeClass('hide');
        }
    })

    $('input[type="radio"][name="paymenttyperadio"]').on('change', function() {
        $('#payment-panel-vehicle, #payment-panel-vendor, #payment-panel-contact').addClass('hide');
        if (this.value == 'TRANSPORTER') {
            $('#payment-panel-vehicle').removeClass('hide');
        } else if (this.value == 'FUEL') {
            $('#payment-panel-vendor').removeClass('hide');
        } else if (this.value == 'JOURNAL') {
            $('#payment-panel-contact').removeClass('hide');
        }
    });

    $('#make-pay-txn-mode').on('change', function() {
        $('#make-pay-chq, #make-pay-upi, #make-pay-nbk').addClass('hide');
        $('#make-pay-bank-details, #make-pay-bank-nbk, #make-pay-bank-name, #make-pay-chq-bankname').val('').trigger('change');
        $('#make-pay-upi-id, #make-pay-upi-details, #make-pay-acc-hold-name, #make-pay-nbk-details, #make-pay-payer, #make-pay-chq-num, #make-pay-chq-date, #make-pay-chq-city, #make-pay-cheque-remarks').val('');

        if ($(this).val() == 'UPI') {
            $('#make-pay-upi').removeClass('hide');
        } else if ($(this).val() == 'NBK') {
            $('#make-pay-nbk').removeClass('hide');
        } else if ($(this).val() == 'CHEQUE') {
            $('#make-pay-chq').removeClass('hide');
        }
    });

    $('#inc-exp-payment-daterange').daterangepicker({
        buttonClasses: ['btn', 'btn-xs'],
        format: 'DD-MM-YYYY',
        separator: ' | ',
        ranges: {
            'Today': [moment(), moment()],
            'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Last 7 Days': [moment().subtract(6, 'days'), moment()],
            'Last 30 Days': [moment().subtract(29, 'days'), moment()],
        },
    }).on('show.daterangepicker', function(ev, picker) {
        picker.showCalendars()
    });

    $('#expenses-date').datepicker({
        format: 'yyyy-mm-dd',
        startDate: '{if $action_rights['DISABLE-PAST-DATE'] == 1}0d{else}-3m{/if}',
        endDate: "+1d",
        autoclose: true,
        changeMonth: true,
    }).on('changeDate', function(e) {
        getAllTransits();
        getExpenseTransactions();
    });

    $('#expenses-date').datepicker('setDate', new Date())

    function getAllTransits() {
        $('#ref-transit-cont').html(loading_popup);

        var data = {};
        data.travel_date = $('#expenses-date').val();
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/get-transit-list",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    var html = '<select id="ref-transit" name="ref-transit"  class="form-control" >';
                    html += '<option value="">Select a Transit</option>';
                    $.each(response.data, function(catkey, transit) {
                        html += '<option value=' + transit.code + ' >' + transit.fromStation.name + ' to ' + transit.toStation.name + ' | ' + transit.busVehicle.registationNumber + ' | ' + transit.aliasCode + '</option>';;
                    });
                    html += '</select>';
                    $('#ref-transit-cont').html(html);
                    $('#ref-transit').val($('#ref-transit-cont').data('val') || '').select2();
                } else {
                    $('#ref-transit-cont').html('Sorry! No Transit Found');
                }
            }
        })
    }
    var fileupload = new fileUpload('#ie-fileupload');

    function saveExpenses() {
        $('.inp_error').removeClass('inp_error');
        var rejectCode = $('#reject-code').val();
        var err = 0;
        var data = {};
        if (rejectCode == 'REJT') {
            data.code = "";
            data.receiptDate = moment().format('YYYY-MM-DD');
        } else {
            data.code = $('#expense-code').val();
            data.receiptDate = $('#expenses-date').val();
        }
        data.cashbookCategory = {};

        data.cashbookCategory.code = $('input[type="radio"][name="exptabradio"]:checked').val();
        if (data.cashbookCategory.code == 'VEH') {
            data.referenceCode = $('#ref-vehicle').val();
        } else if (data.cashbookCategory.code == 'TRN') {
            data.referenceCode = $('#ref-transit').val();
        } else if (data.cashbookCategory.code == 'BRN') {
            data.referenceCode = $('#ref-organization').val();
        } else if (data.cashbookCategory.code == 'LR') {
            data.referenceCode = $('#ref-lr').val();
        }

        data.transactionType = $('#expense-type-cb').is(':checked') ? 'Dr' : 'Cr';

        data.cashbookType = {};
        data.cashbookVendor = {};
        if (data.transactionType == 'Cr') {
            data.cashbookType.code = $('#expense-income').val();
            data.cashbookVendor.code = $('#expense-received').val();
        } else if (data.transactionType == 'Dr') {
            data.cashbookType.code = $('#expense-expense').val();
            data.cashbookVendor.code = $('#expense-vendor').val();
        }

        if (data.cashbookCategory.code == 'OT') {
            data.cashbookType.code = '';
            var toAmountReceived = $.trim($('#expense-v2-to-amount-received').val()) || '';
            var approvedBy = $.trim($('#expense-v2-approved-by').val()) || '';
            data.additionalDetails = toAmountReceived + '|' + approvedBy;

            if (toAmountReceived == '') {
                $('#expense-v2-to-amount-received').addClass('inp_error');
                err++;
            }

            if (approvedBy == '') {
                $('#expense-v2-approved-by').addClass('inp_error');
                err++;
            }
        }

        data.cashbookEntryType = {};
        data.cashbookEntryType.code = 'DEF';
        data.cashbookTransactionDetails = [];

        if (data.cashbookCategory.code == 'BRN' && !$('#add-staff-details').hasClass('hide')) {
            if ($('#branch-staff-list .branch-staff-row:not([data-deleted=1])').length == 0) {
                $('#expense-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#expense-action-state').html('Please add staff income / expense !!');
                $('#expense-action-state').show();
                return false;
            }

            var staffNames = [];
            $('#branch-staff-list .branch-staff-row').each(function() {
                var cashbookTransaction = {};
                cashbookTransaction.activeFlag = ($(this).data('deleted') == 1) ? 0 : 1;
                var branchStaffName = $(this).find('input.expense-staff-name').val();
                cashbookTransaction.referenceType = {};
                cashbookTransaction.referenceType.code = "BSTF";

                cashbookTransaction.organizationContact = {};
                if (isNotNull(branchStaffName)) {
                    cashbookTransaction.organizationContact.code = branchStaffName;
                }

                cashbookTransaction.amount = $(this).find('.expense-staff-amount').val();
                if (isNotNull(branchStaffName) && $.inArray(branchStaffName, staffNames) == -1) {
                    data.cashbookTransactionDetails.push(cashbookTransaction);
                }

                if (cashbookTransaction.activeFlag == 1 && isNull(branchStaffName)) {
                    $(this).find('.expense-staff-name').addClass('inp_error');
                    err++;
                }

                if (cashbookTransaction.activeFlag == 1 && isNull(cashbookTransaction.amount)) {
                    $(this).find('.expense-staff-amount').addClass('inp_error');
                    err++;
                }

                if (cashbookTransaction.activeFlag == 1 && isNotNull(branchStaffName) && $.inArray(branchStaffName, staffNames) != -1) {
                    $(this).find('.expense-staff-name').addClass('inp_error');
                    err++;
                }

                if (cashbookTransaction.activeFlag == 1 && isNotNull(branchStaffName) && $.inArray(branchStaffName, staffNames) == -1) {
                    staffNames.push(branchStaffName);
                }
            });
        }

        var cashbookTypeData = _.find(triphead, function(o) { return o.code === data.cashbookType.code; }) || [];
        var additionalAttributes = (cashbookTypeData.additionalAttributes || '').split(',');
        if (data.cashbookCategory.code == 'BRN' && ($.inArray('STAFF', additionalAttributes) != -1) && data.cashbookTransactionDetails.length == 0) {
            $('#expense-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#expense-action-state').html('Please add staff income / expense !!');
            $('#expense-action-state').show();
            return false;
        }

        if (data.cashbookCategory.code == 'BRN' && !$('#add-driver-details').hasClass('hide')) {
            if ($('#branch-driver-list .branch-driver-row:not([data-deleted=1])').length == 0) {
                $('#expense-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#expense-action-state').html('Please add driver income / expense !!');
                $('#expense-action-state').show();
                return false;
            }
            var driverNames = [];
            $('#branch-driver-list .branch-driver-row').each(function() {
                var cashbookTransaction = {};
                cashbookTransaction.activeFlag = ($(this).data('deleted') == 1) ? 0 : 1;
                var CargoDriverName = $(this).find('input.expense-driver-name').val();
                cashbookTransaction.referenceType = {};
                cashbookTransaction.referenceType.code = "DRVR";

                cashbookTransaction.driver = {};
                if (isNotNull(CargoDriverName)) {
                    cashbookTransaction.driver.code = CargoDriverName;

                }

                cashbookTransaction.amount = $(this).find('.expense-driver-amount').val();
                if (isNotNull(CargoDriverName) && $.inArray(CargoDriverName, driverNames) == -1) {
                    data.cashbookTransactionDetails.push(cashbookTransaction);
                }

                if (cashbookTransaction.activeFlag == 1 && isNotNull(CargoDriverName) && $.inArray(CargoDriverName, driverNames) == -1) {
                    driverNames.push(CargoDriverName);
                }
            });
        }
        var cashbookTypeData = _.find(triphead, function(o) { return o.code === data.cashbookType.code; }) || [];
        var additionalAttributes = (cashbookTypeData.additionalAttributes || '').split(',');
        if (data.cashbookCategory.code == 'BRN' && ($.inArray('DRIVER', additionalAttributes) != -1) && (data.cashbookTransactionDetails.length == 1 || data.cashbookTransactionDetails.length == 0)) {
            if (data.cashbookTransactionDetails.length == 0) {
                $('#expense-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#expense-action-state').html('Please add driver income / expense !!');
                $('#expense-action-state').show();
                return false;
            } else if (data.cashbookTransactionDetails.length == 1 && data.cashbookTransactionDetails[0].referenceType.code == "BSTF") {
                $('#expense-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#expense-action-state').html('Please add driver income / expense !!');
                $('#expense-action-state').show();
                return false;
            }

        }

        data.amount = $('#expense-amount').val();
        data.user = {};
        data.user.code = $('#expense-user').val();
        data.transactionMode = {};
        data.transactionMode.code = $('#expense-mode').val();
        data.acknowledgeStatus = {};
        data.acknowledgeStatus.code = '{if $action_rights['IE-SLF-APOVE'] == 1}APRD{else}INIT{/if}';
        data.remarks = $.trim($('#expense-remarks').val());
        data.activeFlag = 1;

        var log_in_org_code = $('#logged-in-branch-code').val();
        data.tag = [];
        $.each($('#expense-tags').val() || [], function(i, code) {
            data.tag.push({ code: code });
        });

        if (data.cashbookCategory.code == 'VEH') {
            data.referenceCode = $('#ref-vehicle').val();
            if (data.referenceCode == '') {
                $('#ref-vehicle').addClass('inp_error');
                err++;
            }
        } else if (data.cashbookCategory.code == 'TRN') {
            data.referenceCode = $('#ref-transit').val();
            if (data.referenceCode == '') {
                $('#ref-transit').addClass('inp_error');
                err++;
            }
        } else if (data.cashbookCategory.code == 'BRN') {
            data.referenceCode = $('#ref-organization').val();
            if (data.referenceCode == '') {
                $('#ref-organization').addClass('inp_error');
                err++;
            }
        } else if (data.cashbookCategory.code == 'LR') {
            data.referenceCode = $('#ref-lr').val();
            if (data.referenceCode == '' || !$('#ref-lr').data('valid')) {
                $('#ref-lr').addClass('inp_error');
                err++;
            }
        }
        if (data.transactionType == 'Cr' && data.cashbookCategory.code != 'OT') {
            data.cashbookType.code = $('#expense-income').val();
            if (data.cashbookType.code == '') {
                $('#expense-income').addClass('inp_error');
                err++;
            }
        } else if (data.transactionType == 'Dr' && data.cashbookCategory.code != 'OT') {
            data.cashbookType.code = $('#expense-expense').val();
            if (data.cashbookType.code == '') {
                $('#expense-expense').addClass('inp_error');
                err++;
            }
        }

        if ((data.amount == '' || isNaN(data.amount))) {
            $('#expense-amount').addClass('inp_error');
            err++;
        }
        data.transactionMode.code = $('#expense-mode').val();
        if (data.transactionMode.code == '') {
            $('#expense-mode').addClass('inp_error');
            err++;
        }

        {if $action_rights['IE-TAGS'] > 0}
            if ($('#expense-tags').length) {
                if (data.tag.length == 0) {
                    $('.expense-tags').addClass('inp_error');
                    err++;
                }
            }
        {/if}

        if (isNull(data.remarks)) {
            $('#expense-remarks').addClass('inp_error');
            err++;
        }

        if (isNotNull(data.remarks) && data.remarks.length < 20) {
            $('#expense-remarks').addClass('inp_error');
            $('#expense-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#expense-action-state').html('Remarks should be of minimum 20 characters!!');
            $('#expense-action-state').show();
            return false;
        }

        if (err > 0) {
            $('#expense-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#expense-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#expense-action-state').show();
            return false;
        } else {
            $('#expense-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#expense-action-state').hide();
        }

        if (isNotNull(data.code)) {
            var expensesData = _.find(allExpenses, function(o) { return o.transaction_code === data.code; });
            if (isNotNull(expensesData) && isNotNull(expensesData.cashbook_transaction_details) && data.cashbookTransactionDetails.length === 0) {
                var transactionDetails = expensesData.cashbook_transaction_details.split(',');
                $.each(transactionDetails, function(key, val) {
                    var persons = val.split(':');
                    personTransaction = {};
                    personTransaction.code = persons[0];
                    if (personTransaction.code = "BSTF") {
                        staffTransaction = {};
                        staffTransaction.activeFlag = 1;
                        staffTransaction.referenceType = {};
                        staffTransaction.referenceType.code = persons[0];
                        staffTransaction.organizationContact = {};
                        staffTransaction.organizationContact.code = persons[1];
                        staffTransaction.amount = persons[3];
                        data.cashbookTransactionDetails.push(staffTransaction);
                    } else {
                        driverTransaction = {};
                        driverTransaction.activeFlag = 1;
                        driverTransaction.referenceType = {};
                        driverTransaction.referenceType.code = persons[0];
                        driverTransaction.driver = {};
                        driverTransaction.driver.code = persons[1];
                        driverTransaction.amount = persons[3];
                        data.cashbookTransactionDetails.push(driverTransaction);
                    }
                });
            }
        }

        $('#form-bttons').hide();
        $('#expense-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#expense-action-state').html(loading_popup);
        $('#expense-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "payment/update-cb-expense",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#expense-action-state').removeClass('alert-danger');
                    $('#expense-action-state').addClass('alert-success');
                    $('#expense-action-state').html('Your request has been completed successfully');

                    window.setTimeout(function() {
                        $('#expense-action-state').hide();
                        fileupload.startUpload({
                            referenceCode: response.data.code,
                            imageCategoryCode: 'CSHBO',
                            onComplete: function() {
                                clearExpenses(false, log_in_org_code);
                                getExpenseTransactions();
                            }
                        });

                    }, 3000);
                } else {
                    $('#expense-action-state').addClass('alert-danger');
                    $('#expense-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        });
    }

    function clearExpenses(date = true, org) {
        $('.inp_error').removeClass('inp_error');
        $('#expense-action-state').removeClass('alert-danger alert-success');
        $('#expense-action-state').html('');
        $('#expense-code').val('').trigger('change');
        $('#ref-vehicle').val('').trigger('change');
        $('#ref-transit').val('').trigger('change');
        $('#ref-organization').val(organization).trigger('change');
        $('#ref-lr').val('').trigger('change');
        $('#expense-type-cb').bootstrapSwitch('state', true);
        $('input[type="radio"][value="BRN"]').prop('checked', true).trigger('change');
        $('#expense-income').val('').trigger('change');
        $('#expense-expense').val('').trigger('change');
        $('#expense-amount').val('').trigger('change');
        $('#expense-user').val('').trigger('change');
        $('#expense-vendor').val('').trigger('change');
        $('#expense-mode').val('').trigger('change');
        $('#expense-tags').val(identicalTags).multiselect('refresh');
        $('#expense-remarks, #expense-v2-to-amount-received, #expense-v2-approved-by').val('');
        $('#ref-transit-cont').data('val', '');
        if (date) {
            $('#expenses-date').datepicker('setDate', new Date());
        }
        fileupload.clearFiles();
    }

    function getExpenseTransactions() {
        $('#expenses-list').html('');
        var data = {};
        data.fromDate = moment($('#expenses-date').val()).format('YYYY-MM-DD');
        data.toDate = moment($('#expenses-date').val()).format('YYYY-MM-DD');
        data.organizationCode = '{if $action_rights['IE-BEHALF-BRACH'] == 1 || $action_rights['IE-BEHALF-ALL'] == 1}NA{else}{$organization}{/if}';
        data.userCode = '{if $action_rights['IE-BEHALF-ALL'] == 1}NA{else}{$usr_login_id}{/if}';
        data.ackStatusCode = 'INIT';
        data.filterType = 'DETAILS';

        $('#expenses-list-container').removeClass('hide');
        $('#expenses-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "payment/get-expenses-list",
            data: data,
            success: function(response) {
                $('#expenses-list').html(response);
            }
        })
    }

    function checklr() {
        var data = {};
        data.cargoCode = $.trim($('#ref-lr').val());

        if (!data.cargoCode) {
            return;
        }

        $('#ref-lr').removeClass('inp_error')
        $('#ref-lr').data('valid', false);
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/find-lr",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#ref-lr').data('valid', true);
                } else {
                    alert('Invalid LR')
                    $('#ref-lr').addClass('inp_error')
                    $('#ref-lr').data('valid', false)
                }
            }
        })
    }

    function editExpenses(code) {
        var data = _.find(allExpenses, function(o) { return o.transaction_code === code; });
        $('#reject-code').val(data.ack_status_code).trigger('change');
        $('#expense-code').val(data.transaction_code).trigger('change');
        // $('#expense-code').val(data.category_type).trigger('change');
        if (data.category_type == 'VEH') {
            $('#ref-vehicle').val(data.reference_code).trigger('change');
            $('input[type="radio"][value="VEH"]').prop('checked', true).trigger('change');
        } else if (data.category_type == 'TRN') {
            $('#ref-transit-cont').data('val', data.reference_code).trigger('change');
            $('input[type="radio"][value="TRN"]').prop('checked', true).trigger('change');
        } else if (data.category_type == 'BRN') {
            $('#ref-organization').val(data.reference_code).trigger('change');
            $('input[type="radio"][value="BRN"]').prop('checked', true).trigger('change');
        } else if (data.category_type == 'LR') {
            $('#ref-lr').val(data.reference_code).trigger('change');
            $('input[type="radio"][value="LR"]').prop('checked', true).trigger('change');
        } else if (data.category_type == 'OT') {
            $('input[type="radio"][value="OT"]').prop('checked', true).trigger('change');

            var additionalDetails = (data.additional_details || '').split('|');
            $('#expense-v2-to-amount-received').val(additionalDetails[0]);
            $('#expense-v2-approved-by').val(additionalDetails[1]);
        }
        showBranchStaff();
        showBranchDriver();
        $('#expense-type-cb').bootstrapSwitch('state', data.transaction_type == 'Dr');

        if (data.transaction_type == 'Cr') {
            $('#expense-income').val(data.cashbook_type_code).trigger('change');
            $('#expense-received').val(data.cashbook_vendor_code).trigger('change');
            $('input[type="radio"][value="INCOME"]').prop('checked', true).trigger('change');
        } else if (data.transaction_type == 'Dr') {
            $('#expense-expense').val(data.cashbook_type_code).trigger('change');
            $('#expense-vendor').val(data.cashbook_vendor_code).trigger('change');
            $('input[type="radio"][value="EXPENSE"]').prop('checked', true).trigger('change');
        }
        $('#expense-amount').val(data.credit_amount || data.debit_amount).trigger('change');
        $('#expense-user').val(data.user_code).trigger('change');
        $('#expense-mode').val(data.transaction_mode_code).trigger('change');
        $('#expense-tags').val((data.tag_code || '').split(',')).multiselect('refresh');
        $('#expense-remarks').val(data.remarks);
        $('#expenses-date').datepicker('update', moment(data.settlement_date).format('YYYY-MM-DD'))

        $('html, body').animate({
            scrollTop: $('#container-fluid').offset().top - 100
        }, 400);
    }

    function deleteExpenses(code) {
        if (!confirm('Do you want to delete this Transaction?')) {
            return;
        }
        var exp = _.find(allExpenses, function(o) {
            return o.transaction_code === code;
        })
        var data = {};
        data.code = exp.transaction_code;
        data.cashbookCategory = {};
        data.cashbookCategory.code = exp.category_type;
        data.referenceCode = exp.reference_code;
        data.transactionType = exp.transaction_type;
        data.cashbookType = {};
        data.cashbookVendor = {};
        data.cashbookType.code = exp.cashbook_type_code;
        data.cashbookVendor.code = exp.cashbook_vendor_code;
        data.amount = exp.credit_amount + exp.debit_amount;
        data.user = {};
        data.user.code = exp.user_code;
        data.transactionMode = {};
        data.transactionMode.code = exp.transaction_mode_code;
        data.receiptDate = exp.settlement_date;
        data.acknowledgeStatus = {};
        data.acknowledgeStatus.code = exp.ack_status_code;
        data.tag = exp.tag;
        data.remarks = exp.remarks;
        data.activeFlag = 2;

        data.cashbookEntryType = {};
        data.cashbookEntryType.code = exp.entry_type_code;

        data.cashbookTransactionDetails = [];

        if (exp.cashbook_transaction_details) {
            var transactionDetails = exp.cashbook_transaction_details.split(',');
            $.each(transactionDetails, function(key, val) {
                var persons = val.split(':');
                personTransaction = {};
                personTransaction.code = persons[0];
                if (personTransaction.code = "BSTF") {
                    staffTransaction = {};
                    staffTransaction.activeFlag = 1;
                    staffTransaction.referenceType = {};
                    staffTransaction.referenceType.code = persons[0];
                    staffTransaction.organizationContact = {};
                    staffTransaction.organizationContact.code = persons[1];
                    staffTransaction.amount = persons[3];
                    data.cashbookTransactionDetails.push(staffTransaction);
                } else {
                    driverTransaction = {};
                    driverTransaction.activeFlag = 1;
                    driverTransaction.referenceType = {};
                    driverTransaction.referenceType.code = persons[0];
                    driverTransaction.driver = {};
                    driverTransaction.driver.code = persons[1];
                    driverTransaction.amount = persons[3];
                    data.cashbookTransactionDetails.push(driverTransaction);

                }
            });
        }

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "payment/update-cb-expense",
            data: data,
            success: function(response) {
                if (response.status === 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function() {
                        loading_overlay.hide();
                        getExpenseTransactions();
                        return;
                    }, 2000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 2000);
                }
            }
        });
    }

    function showPRGallery(code) {
        fileupload.showGalleryDialog({
            referenceCode: code,
            imageCategoryCode: 'CSHBO'
        });
    }

    var branchSelectTpl = $('#manage-exp-branch-select-tpl').html();
    var DriverSelectTpl = $('#manage-exp-driver-select-tpl-2').html();

    function formatResult(branch) {
        if (!branch.id) return branch.text;

        var $tpl = $(branchSelectTpl);
        $tpl.find('.branch-name').text(branch.text);
        $tpl.find('.alias-code').text(branch.aliasCode);
        return $tpl;
    };

    function formatResultDriver(driver) {
        if (!driver.id) return driver.text;
        var $tpl2 = $(DriverSelectTpl);
        $tpl2.find('.Driver-name').text(driver.text);
        return $tpl2;
    };

    function matcher2(term, text, driver) {
        text = [driver.text]
        return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
    };

    function matcher(term, text, branch) {
        text = [branch.text, branch.aliasCode].join(' ');
        return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
    };

    function addBranchStaff(data) {
        var $tpl = $('#branch-staff-tpl .branch-staff-row').clone();
        $('#branch-staff-list').append($tpl);

        var branchstaffdata = [];
        $.each(branchStaff || [], function(i, row) {
            var branch = [];
            branch.id = row.code;
            branch.text = row.name;
            branch.aliasCode = row.aliasCode;
            branchstaffdata.push(branch);
        });

        $tpl.find('.expense-staff-name').select2({
            data: { results: branchstaffdata },
            placeholder: 'Select Staff Name',
            formatResult: formatResult,
            formatSelection: formatResult,
            matcher: matcher
        });

        $tpl.find('.expense-staff-amount').val(0);

        if (_isdefined(data)) {
            var staff = data.split(':');
            $tpl.find('.expense-staff-name').val(staff[1].trim()).trigger('change');
            $tpl.find('.expense-staff-amount').val(staff[3].trim());
        }
    }


    function addDriver(data) {
        var $tpl = $('#branch-driver-tpl .branch-driver-row').clone();
        $('#branch-driver-list').append($tpl);

        var driverData = [];

        $.each(driverDetails || [], function(i, row) {
            var driver = [];
            driver.id = row.code;
            driver.text = row.name;
            driverData.push(driver);
        });

        $tpl.find('.expense-driver-name').select2({
            data: { results: branchdriverdata },
            placeholder: 'Select driver Name',
            formatResult: formatResultDriver,
            formatSelection: formatResultDriver,
            matcher: matcher2
        });

        $tpl.find('.expense-driver-amount').val(0);

        if (_isdefined(data)) {
            var driver = data.split(':');
            $tpl.find('.expense-driver-name').val(driver[2].trim()).trigger('change');
            $tpl.find('.expense-driver-amount').val(driver[3].trim());
        }
    }

    function removeBranchstaff(ele) {
        if ($('#branch-staff-table tbody tr:not([data-deleted=1])').length > 1) {
            $(ele).closest('tr').attr('data-deleted', 1).hide();
        }
        calculateAmount();
    }

    function showBranchStaff() {
        $('#branch-staff-list .expense-staff-name').val('').trigger('change');
        $('#branch-staff-list .expense-staff-amount').val(0);
        $('#show-staff-detail').addClass('hide');
        $('#hide-staff-detail').removeClass('hide');
        $('#add-staff-details').removeClass('hide');
        $('#expense-amount').prop('disabled', true);
    }

    function showBranchDriver() {
        $('#branch-driver-list .expense-driver-name').val('').trigger('change');
        $('#branch-driver-list .expense-driver-amount').val(0);
        $('#show-driver-detail').addClass('hide');
        $('#hide-driver-detail').removeClass('hide');
        $('#add-driver-details').removeClass('hide');
        $('#expense-amount').prop('disabled', true);
    }


    function hideBranchStaff() {
        $('#hide-staff-detail').addClass('hide');
        $('#show-staff-detail').removeClass('hide');
        $('#add-staff-details').addClass('hide');
        $('#expense-amount').prop('disabled', false);
    }

    function hideBranchDriver() {
        $('#show-driver-detail').removeClass('hide');
        $('#hide-driver-detail').addClass('hide');
        $('#add-driver-details').addClass('hide');
        $('#expense-amount').prop('disabled', false);
    }

    function calculateAmount() {
        var totalAmount = 0;
        if ($('.expense-staff-amount').val() > 0 && !$('#add-staff-details').hasClass('hide')) {
            $('#branch-staff-list .branch-staff-row:not([data-deleted=1])').each(function() {
                totalAmount += parseFloat($(this).find('.expense-staff-amount').val());
            });
            $('#expense-amount').val(totalAmount);
        }
        if ($('.expense-driver-amount').val() > 0 && !$('#add-driver-details').hasClass('hide')) {
            $('#branch-driver-list .branch-driver-row:not([data-deleted=1])').each(function() {
                totalAmount += parseFloat($(this).find('.expense-driver-amount').val());
            });
            $('#expense-amount').val(totalAmount);
        }
        totalAmount = 0;
    };

    function getTransitTransactionList() {
        $('.inp_error').removeClass('inp_error');
        $('#payment-list-container').addClass('hide');
        var err = 0;

        $('#payment-list').html('');
        var data = {};

        data.daterange = $('#inc-exp-payment-daterange').val();
        if (data.daterange == '') {
            $('#inc-exp-payment-daterange').addClass('inp_error');
            err++;
        }

        data.type = $('input[type="radio"][name="paymenttyperadio"]:checked').val();
        if (data.type == 'TRANSPORTER') {
            data.vehicleCode = $('#payment-vehicle').val();
            data.cashbookTypeCode = 'HIRING';
            if (data.vehicleCode == '') {
                $('#payment-vehicle').addClass('inp_error');
                err++;
            }
        } else if (data.type == 'FUEL') {
            data.contactCode = $('#payment-vendor').val();
            data.cashbookTypeCode = 'FUEL';
            if (data.contactCode == '') {
                $('#payment-vendor').addClass('inp_error');
                err++;
            }
        } else if (data.type == 'JOURNAL') {
            data.contactCode = $('#payment-contact').val();
            data.cashbookTypeCode = 'JOURNAL';
            if (data.contactCode == '') {
                $('#payment-contact').addClass('inp_error');
                err++;
            }
        }

        if (err > 0) {
            $('#payment-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#payment-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#payment-action-state').show();
            return false;
        } else {
            $('#payment-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#payment-action-state').hide();
        }

        $('#form-bttons').hide();
        $('#payment-action-state').removeClass('alert-danger').removeClass('alert-success').html('').hide();
        $('#payment-list-container').removeClass('hide');
        $('#payment-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "payment/get-transit-transaction-list",
            data: data,
            success: function(response) {
                $('#payment-list').html(response);
            }
        })
    }

    var paymentTransactionCode = [];

    function manageExpensePaymentDialog(type = '', vehicleCode = '', vendor = '') {
        $('#make-payment-dialog').css('background', '#fff');
        $('#make-payment-dialog').removeClass('hide');
        $('#make-payment-dialog').dialog({
            autoOpen: true,
            height: 375,
            width: 750,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();

        paymentTransactionCode = [];
        var balance = 0;
        $('#paymnet-table tbody tr').each(function() {
            var transactionCode = $(this).find('.makepayment-entry:checked').val();
            var amount = $(this).find('.makepayment-entry:checked').data('amount');
            var cashbookType = $(this).find('.makepayment-entry:checked').data('cashbooktype');
            var paymentType = $(this).find('.makepayment-entry:checked').data('paymenttype');
            var sourceType = $(this).find('.makepayment-entry:checked').data('sourcetype');
            if (isNotNull(transactionCode)) {
                paymentTransactionCode.push(transactionCode);
                if (cashbookType != 'HIRING' && paymentType == 'TRANSPORTER') {
                    balance = balance + amount;
                } else if (cashbookType != 'FUEL' && paymentType == 'FUEL') {
                    balance = balance + amount;
                } else if (cashbookType == 'HIRING' && paymentType == 'TRANSPORTER') {
                    balance = balance - amount;
                } else if (cashbookType == 'FUEL' && paymentType == 'FUEL') {
                    balance = balance - amount;
                } else if (sourceType == 'JRNL') {
                    balance = balance - amount;
                }
            }
        });

        if (balance > 0) {
            $('#make-pay-amount').val(-balance);
        } else {
            $('#make-pay-amount').val(-balance);
        }
        $('#make-pay-type').val(type);
        $('#make-pay-fuel-vendor').val(vendor)
        $('#make-pay-vehicleCode').val(vehicleCode);
        $('#make-pay-txn-mode').val('').trigger('change');
        $('#make-pay-action-state').removeClass('alert-danger').addClass('hide').html('');
        $('.inp_error').removeClass('inp_error');
    }

    function closeManageExpensePaymentDialog() {
        $('#make-payment-dialog').addClass('hide');
        $('#make-payment-dialog').dialog('destroy');
    }

    function updatePayment() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        var data = {};

        data.amount = $('#make-pay-amount').val();
        data.activeFlag = 1;
        data.transactionCodes = paymentTransactionCode || [];

        data.paymentToContact = {};
        data.paymentToContact.code = $('#make-pay-fuel-vendor').val();

        data.transactionMode = {};
        data.transactionMode.code = $('#make-pay-txn-mode').val();

        if (data.transactionMode.code == '') {
            $('#make-pay-txn-mode').addClass('inp_error');
            err++;
        }

        data.vehicleCode = $('#make-pay-vehicleCode').val();
        data.cashbookTypeCode = $('#make-pay-type').val();

        if (data.transactionCodes.length == 0) {
            $('#make-pay-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#make-pay-action-state').html('Please select atleast one transaction to proceed!');
            return false;
        }

        if (data.transactionMode.code == 'UPI') {
            data.bankDetails = {};
            data.bankDetails.code = $('#make-pay-bank-details').val();

            data.addAttr1 = $.trim($('#make-pay-upi-id').val());
            data.addAttr2 = $.trim($('#make-pay-upi-details').val());
            data.addAttr3 = 'NA';

            if (data.bankDetails.code == '') {
                $('#make-pay-bank-details').addClass('inp_error');
                err++;
            }

            if (data.addAttr1 == '') {
                $('#make-pay-upi-id').addClass('inp_error');
                err++;
            }

            if (data.addAttr2 == '') {
                $('#make-pay-upi-details').addClass('inp_error');
                err++;
            }
        } else if (data.transactionMode.code == 'NBK') {
            data.bankDetails = {};
            data.bankDetails.code = $('#make-pay-bank-nbk').val();

            data.addAttr1 = $.trim($('#make-pay-acc-hold-name').val());
            data.addAttr2 = $.trim($('#make-pay-bank-name').val());
            data.addAttr3 = $.trim($('#make-pay-nbk-details').val());

            if (data.bankDetails.code == '') {
                $('#make-pay-bank-nbk').addClass('inp_error');
                err++;
            }

            if (data.addAttr1 == '') {
                $('#make-pay-acc-hold-name').addClass('inp_error');
                err++;
            }

            if (data.addAttr2 == '') {
                $('#make-pay-bank-name').addClass('inp_error');
                err++;
            }

            if (data.addAttr3 == '') {
                $('#make-pay-nbk-details').addClass('inp_error');
                err++;
            }
        } else if (data.transactionMode.code == 'CHEQUE') {
            data.chequeDetails = {};

            data.chequeDetails.organization = {};
            data.chequeDetails.organization.code = organization;

            data.chequeDetails.bankDetails = $.trim($('#make-pay-chq-bankname').val());
            data.chequeDetails.payerDetails = $.trim($('#make-pay-payer').val());

            data.chequeDetails.chequeDate = moment($('#make-pay-chq-date').val()).format('YYYY-MM-DD');
            data.chequeDetails.chequeNo = $.trim($('#make-pay-chq-num').val());
            data.chequeDetails.bankCity = $.trim($('#make-pay-chq-city').val());

            data.chequeDetails.chequeStatus = {};
            data.chequeDetails.chequeStatus.code = 'NEW';

            data.chequeDetails.remarks = $.trim($('#make-pay-cheque-remarks').val());

            if (data.chequeDetails.payerDetails == '') {
                $('#make-pay-payer').addClass('inp_error');
                err++;
            }

            if (data.chequeDetails.chequeNo == '') {
                $('#make-pay-chq-num').addClass('inp_error');
                err++;
            }

            if ($('#make-pay-chq-date').val() == '') {
                $('#make-pay-chq-date').addClass('inp_error');
                err++;
            }

            if (data.chequeDetails.bankCity == '') {
                $('#make-pay-chq-city').addClass('inp_error');
                err++;
            }

            if (data.chequeDetails.bankDetails == '') {
                $('#make-pay-chq-bankname').addClass('inp_error');
                err++;
            }
        }

        if (err > 0) {
            $('#make-pay-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#make-pay-action-state').html('Please enter/select the values in the field that are marked in red');
            return false;
        } else {
            $('#make-pay-action-state').removeClass('alert-success').removeClass('alert-danger').addClass('hide');
            $('#make-pay-action-state').html('');
        }

        $('#make-pay-action-state').removeClass('alert-success').removeClass('alert-danger').removeClass('hide');
        $('#make-pay-action-state').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "payment/manage-expense-make-payment",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#make-pay-action-state').removeClass('alert-danger');
                    $('#make-pay-action-state').addClass('alert-success');
                    $('#make-pay-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        closeManageExpensePaymentDialog();
                        getTransitTransactionList();
                    }, 2000);
                } else {
                    $('#make-pay-action-state').removeClass('alert-success');
                    $('#make-pay-action-state').addClass('alert-danger');
                    $('#make-pay-action-state').html(response.errorDesc);
                }
            }
        });
    }

    function income_expense_type_based(type) {
        var incomeExpenseType = $('#expense-type-cb').is(':checked') ? 'Dr' : 'Cr';
        if (incomeExpenseType == 'Cr') {
            $('#expense-income').html(function() {
                return expenseIncome.filter(function() {
                    var tags = ($(this).data('tags') || '').split(',');
                    return $.inArray(type, tags) != -1 || $.inArray('', tags) != -1;
                });
            }).val('').trigger('change');
        } else {
            $('#expense-expense').html(function() {
                return expenseExpense.filter(function() {
                    var tags = ($(this).data('tags') || '').split(',');
                    return $.inArray(type, tags) != -1 || $.inArray('', tags) != -1;
                });
            }).val('').trigger('change');
        }
    }
</script>