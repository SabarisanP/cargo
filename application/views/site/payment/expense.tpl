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
                <div class="row">                        
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-body " style="padding-top: 0;">
                                <div class="row">  
                                    <div class="">        
                                        <div class="form-group col-md-12">
                                            <label class="" for="txn-rcpt-txn-type">Select Entry Category</label>
                                            {* <small>Select Income or Expense or Payment category</small>
                                            <div class="clearfix"></div><br> *}
                                            <div class="input-group">
                                                {if $action_rights['EBL-EXP-LEDGER'] == 1}
                                                    <label class="radio-inline">
                                                        <input type="radio" name="exptyperadio" class="expense-type-cb" value="EXPLEDGER">Expense Ledger&nbsp;
                                                    </label>
                                                {else}
                                                    <label class="radio-inline">
                                                        <input type="radio" name="exptyperadio" class="expense-type-cb" value="EXPENSE" checked>Expense&nbsp;
                                                    </label>
                                                {/if}
                                                <label class="radio-inline">
                                                    <input type="radio" name="exptyperadio" class="expense-type-cb" value="INCOME">Income&nbsp;
                                                </label>
                                                <label class="radio-inline">
                                                    <input type="radio" name="exptyperadio" class="expense-type-cb" value="PAYMENT">Payment&nbsp;
                                                </label>
                                            </div>
                                        </div>
                                    </div>  

                                    <div class="income-expense-pannel">
                                        <div id="search-panel">
                                            <div class="form-group-inline">
                                                <label for="tsr_travel_date" class="form-group req pt10 col-md-4">Receipt Date</label>
                                                <div class="input-group">
                                                    <input type="text" name="travel_date" class="form-control sdate" id="expenses-date" readonly="true" placeholder="Date From">
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                </div>
                                            </div>
                                            <div class="heading_b "></div>

                                            {* <div class="form-group">
                                                <div class="col-sm-7">
                                                <label class="control-label req" for="tph_name">Select Entry Category</label>
                                                <small>Select Income or Expense category</small>
                                                </div>
                                                <div class="col-sm-5">
                                                    <input type="checkbox" checked id="expense-type-cb" class="bsn_switch" data-on-text="Expense" data-off-text="Income">
                                                </div>
                                            </div>  *}

                                            <div class="clearfix"></div><br>
                                            <div class="col-md-12">
                                                <b>Expense For <span data-toggle="tooltip" data-title="Select for what the expense is for ?"> <i class="fa fa-info-circle"></i></span></b> 
                                            </div>
                                            <div class="clearfix"></div><br>
                                            <div class="tabbable ">
                                                <ul class="nav nav-tabs" id="exp-tabs">
                                                    <li class="active">
                                                        <a data-toggle="tab" data-val="BRN" href="#setting_branch">Branch</a>
                                                    </li>
                                                    <li>
                                                        <a data-toggle="tab" data-val="VEH" href="#setting_vehicle">Vehicle</a>
                                                    </li>
                                                    <li>
                                                        <a data-toggle="tab" data-val="TRN" href="#setting_transit">Transit</a>
                                                    </li>
                                                    <li>
                                                        <a data-toggle="tab" data-val="LR" href="#setting_lr">LR</a>
                                                    </li>
                                                    <li>
                                                        <a data-toggle="tab" data-val="OT" href="#setting_others">Others</a>
                                                    </li>
                                                </ul>
                                                <div class="tab-content" id="tabs_content_a">
                                                    <div id="setting_branch" class="tab-pane fade in active">
                                                        <div>
                                                            <label for="ref-organization" class="req">Branch</label>
                                                            <select id="ref-organization" class="form-control" {if $action_rights['IE-BEHALF-BRACH'] != 1 || $action_rights['IE-BEHALF-ALL'] != 1}disabled="disabled"{/if}>
                                                                <option value="" >Select a Branch</option>
                                                                {foreach from=$organizations item=row}
                                                                    <option value="{$row->code}" {if $logged_in_usr_org_code == $row->code}selected{/if}>{$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>

                                                    </div>
                                                    <div id="setting_vehicle" class="tab-pane fade">
 
                                                        <div>
                                                            <label for="ref-vehicle" class="req">Vehicle</label>
                                                            <select id="ref-vehicle" class="form-control" >
                                                                <option value="">Select a Vehicle</option>
                                                                {foreach from=$vehicles item=row}
                                                                    <option value="{$row->code}">{$row->registationNumber}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>   
                                                    <div id="setting_transit" class="tab-pane fade">

                                                        <div >
                                                            <label for="ref-transit" class="req">Transit</label>
                                                            <div id="ref-transit-cont">
                                                            <select id="ref-transit" class="form-control" >
                                                            <option value="">Select a Transit</option>
                                                            </select>
                                                        </div>
                                                        </div>
                                                    </div>
                                                    <div id="setting_lr" class="tab-pane fade">
                                                        <div class="">
                                                            <label class="req" for="date_from">Enter LR</label>
                                                            <div class="form-group">
                                                                <input type="text" name="lr" class="form-control sdate input_capital" id="ref-lr" placeholder="Enter LR" onblur="checklr()">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="setting_others" class="tab-pane fade"></div>
                                                </div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8 income-expense-pannel">
                        <div class="panel panel-default">
                            <div class="col-md-8">
                                <h5><i class="fa fa-ticket"></i> Income / Expense Details</h5>
                            </div>

                            <div class="clearfix"></div>
                            <div class="heading_b"></div>

                            <div class="col-lg-8">
                                <div class="form-group text-left hide" id="income-head-panel">
                                    <label class="req" for="seat-sch-date">Income Type</label>
                                    <select id="expense-income" class="form-control">
                                        <option value="">Select Income</option>
                                        {foreach item=row from=$triphead} 
                                            {if $row->transactionType ==  'Cr'}
                                                <option value="{$row->code}">{$row->name}</option>
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
                                                <option value="{$row->code}">{$row->name}</option>
                                            {/if}
                                        {/foreach} 
                                    </select>
                                </div>
                            </div> 
                            
                            <div class="col-lg-4">
                                <div class="form-group text-left">
                                    <label class="req">Amount</label>
                                    <input type="number" placeholder="Amount" id="expense-amount" name="amount"  class="form-control no-spin">                    
                                </div>
                            </div>
                            
                            <div class="clearfix"></div>
                            <div class="col-lg-4" id="show-staff-detail">
                                <div class="form-group">
                                    <a href="javascript:;" onclick="showBranchStaff();">Add staff income / expense</a>    
                                </div>                
                            </div>
                            <div class="col-lg-4 hide" id="hide-staff-detail">
                                <div class="form-group">
                                    <a href="javascript:;" onclick="hideBranchStaff();">Hide staff income / expense</a>    
                                </div>                
                            </div>
                            <div class="clearfix"></div>

                            {* {if $action_rights['IE-BEHALF-BRACH'] == 1 || $action_rights['IE-BEHALF-ALL'] == 1}
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="" for="cb-on-behalf-user">On Behalf Of</label>
                                    <select id='expense-user' class="form-control" tabindex="25">
                                        <option  value="">Select a user</option>
                                        {foreach name=o item=grpusr from=$groupusers.groups}
                                            <optgroup label="{$grpusr->name}">
                                            {foreach name=o item=usr from=$groupusers.users} 
                                                {if $usr.groupcode == $grpusr->code && $usr.activeFlag == 1}
                                                    {if $action_rights['IE-BEHALF-BRACH'] != 1 || $usr.orgcode == $logged_in_usr_org_code}
                                                        <option  value="{$usr.code}">{$usr.name}</option>                                                      
                                                    {/if}
                                                {/if}
                                            {/foreach}      
                                            </optgroup>
                                        {/foreach}                                 
                                    </select>
                                </div>
                            </div>
                            {/if} *}
                            <div class="col-md-8 hide" id="add-staff-details">
                                <table class="table table-striped" width="100%" id="branch-staff-table">
                                    <thead>
                                        <tr>
                                            <td class="bold req" width="50%">Staff Name</td>
                                            <td class="bold req" width="40%">Amount</td>
                                            <td  width="10%">
                                                <a href="javascript:;" onclick="addBranchStaff();" class="btn btn-sm btn-default"><i class="fa fa-plus"></i></a>
                                            </td>
                                        </tr>
                                    </thead>
                                    <tbody id="branch-staff-list"></tbody>
                                    <tfoot id="branch-staff-tpl" class="hide">
                                        <tr class="branch-staff-row">
                                            <td>
                                                {* <select class="form-control expense-staff-name">
                                                    <option value="">Select</option>
                                                    {foreach from=$branchStaff item=staff}
                                                        <option value="{$staff->code}">{$staff->name}</option>
                                                    {/foreach}
                                                </select> *}
                                                <input type="text" class="form-control expense-staff-name">
                                            </td>
                                            <td>
                                                <input type="number" placeholder="Amount" onchange="calculateAmount();" name="amount" class="form-control no-spin expense-staff-amount" step="any">
                                            </td>
                                            <td>
                                                <a href="javascript:;" onclick="removeBranchStaff(this);" class="btn btn-sm btn-default"><i class="fa fa-minus"></i></a>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>

                            <div class="clearfix"></div>
                            <div class="col-md-5" id="expense-vendor-panel">
                                <div class="form-group">
                                    <label for="vendor_users" class="">Vendor</label>
                                    <select id="expense-vendor" class="form-control">   
                                        <option value="">Select Vendor</option>
                                        {foreach item=vendor_usr from=$vendors} 
                                            <option  value="{$vendor_usr->code}">{$vendor_usr->name}</option> 
                                        {/foreach}
                                    </select>                                                                                                    
                                </div>
                            </div>
                            <div class="col-md-5 hide" id="expense-received-panel">
                                <div class="form-group">
                                    <label for="vendor_users" class="">Received By</label>
                                    
                                    <input type="text" class="form-control" id="expense-received" placeholder="Received By">                                                                                
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label class="req" for="seat-sch-date">Transaction Mode</label>
                                    <select id="expense-mode" class="form-control">
                                        <option value="">Select</option>
                                        {foreach name=o key=k item=name from=$f_t_mode}
                                            <option value="{$k}">{$name}</option>
                                        {/foreach} 
                                    </select>
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
                            <div class="clearfix"></div>

                            <div class="col-lg-8"> 
                                <label>Remarks</label>
                                <textarea id="expense-remarks" placeholder="Enter your remarks" style="resize:none" class="form-control" rows="3" cols="30" name="remark" id="remark"></textarea>
                            </div>  

                            <input type="hidden" id="expense-code" value="">
                            <div class="col-lg-4">                       
                                <label>&nbsp;</label>
                                <div class="align-right" id="aspe-form-buttons">                    
                                    <button class="btn btn-success" type="button" onclick="saveExpenses();">Save</button>
                                    <button class="btn btn-default" type="button" onclick="clearExpenses();">Clear</button>
                                </div>
                            </div> 
                            <div class="clearfix"></div>

                            <div class="col-lg-12"> 
                                {include file="site/cargo/file-upload-component.tpl" id="ie-fileupload" axis="horizontal"} 
                            </div>
                            
                            <div class="clearfix"></div>

                            <div class="alert" style="display: none;" id="expense-action-state"></div>

                        </div>
                    </div>

                    <div class="col-lg-8 hide payment-pannel">
                        <div class="panel panel-default">
                            <div class="col-md-8">
                                <h5><i class="fa fa-ticket"></i> Payment Details</h5>
                            </div>

                            <div class="col-md-4 text-right hide" id="payment-adv-panel">
                                <a href="javascript:;" id="adv-btn" class="btn btn-success btn-sm" onclick="addAdvanceDialog()">&nbsp;Add Advance Payment</a>
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
                                    <label class="radio-inline">
                                        <input type="radio" name="paymenttyperadio" class="payment-type-cb" value="ADV">Advance Payment &nbsp;
                                    </label>
                                </div>
                            </div>
                            <div class="clearfix"><br></div>
                            <div class="hide" id="payment-adv-details">
                                <div class="form-group col-lg-4">
                                    <label for="adv-amt-from-date" class="req">From Date</label>
                                    <div class="input-group">
                                        <input type="text" name="fromDate" class="form-control sdate" id="adv-amt-from-date" readonly="true" placeholder="Date From">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4">
                                    <label for="adv-amt-to-date" class="req">To Date</label>
                                    <div class="input-group">
                                        <input type="text" name="toDate" class="form-control sdate" id="adv-amt-to-date" readonly="true" placeholder="Date To">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                                <div class="form-group col-lg-3">
                                    <label for="">&nbsp;</label>
                                    <div class="input-group">
                                        <button class="btn btn-success" type="button"  onclick="getAdvanceReceipt()">Generate</button>&nbsp;
                                        <button type="button" class="btn btn-default btn-clear" onclick="clearExpenses()">Clear</button>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="payment-panel-details">
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
                            </div>
                            <div class="clearfix"></div>
                            <div class="alert" style="display: none;" id="payment-action-state"></div>
                        </div>
                    </div>

                    <div class="col-lg-8 hide expense-ledger-pannel">
                        <div class="panel panel-default">
                            <div class="col-md-12">
                                <h5 class="d-flex justify-space-between" style="align-items: center;">
                                    <span><i class="fa fa-ticket"></i> Expense Ledger</span>
                                    <button class="btn btn-primary pull-right" type="button" onclick="addExpenseLedger();">Add Expense Ledger</button>
                                </h5>
                            </div>

                            <div class="clearfix"></div>
                            <div class="heading_b"></div>

                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="expense-ledger-from" class="req">From Date</label>
                                        <div class="input-group">
                                            <input type="text" name="fromDate" class="form-control sdate" id="expense-ledger-from" readonly="true" placeholder="Date From">
                                            <label class="input-group-addon" for="expense-ledger-from"><i class="fa fa-calendar"></i></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="expense-ledger-to" class="req">To Date</label>
                                        <div class="input-group">
                                            <input type="text" name="toDate" class="form-control sdate" id="expense-ledger-to" readonly="true" placeholder="Date To">
                                            <label class="input-group-addon" for="expense-ledger-to"><i class="fa fa-calendar"></i></label>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="expense-ledger-branch-filter">Branch</label>
                                        <select id="expense-ledger-branch-filter" class="form-control select2">
                                            <option value="">Select Branch</option>
                                            {foreach item=row from=$organizations}
                                                <option value="{$row->code}">{$row->name}</option>
                                            {/foreach} 
                                        </select>
                                    </div>
                                </div>

                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <label for="expense-ledger-branch-receipt">Branch Receipt</label>
                                        <input type="text" class="form-control" id="expense-ledger-branch-receipt" placeholder="Branch Receipt">
                                    </div>
                                </div>   
                                
                                <div class="col-md-6">
                                    <div class="clearfix"></div><br>
                                    <div class="alert" style="display: none;" id="expense-ledger-report-action-state"></div>
                                </div> 
                                <div class="col-lg-5 pull-right">
                                    <div>                    
                                        <button class="btn btn-success" type="button"
                                            onclick="getExpenseLedger();">Generate</button>
                                        <button class="btn btn-default" type="button"
                                            onclick="clearExpenseLedger();">Clear</button>
                                        <button class="btn btn-default hide" id="print_button"
                                            onclick="{if $namespace == 'seenutransports' || $namespace == 'seenucargo' }printExpenseLedger(){else}window.print(){/if}">Summary Print</button>
                                    </div>
                                </div> 
                                {* 
                                <div class="alert" style="display: none;" id="expense-ledger-report-action-state"></div> *}
                            </div>
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

                <div class="row hide" id="expense-ledger-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="expense-ledger-list"></div>                                    
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row hide" id="adv-amt-list-container">
                    <br>
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="adv-amt-list"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>                    
        </div>
    </div>            
</div>

<div id="make-payment-dialog"  class="dialog-content-page hide">
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
                    <input type="text" class="form-control" placeholder="Remarks" id="make-pay-cheque-remarks" data-mask="englishonly"/>
                </div>
            </div>
        </div>
                     
        <div class="row">
            <div class="col-lg-12"> 
                <input type="hidden" id="make-pay-fuel-vendor" value="">
                <input type="hidden" id="make-pay-vehicleCode" value="">
                <input type="hidden" id="make-pay-type" value="">
                <input type="hidden" id="print-summary"  name="print-summary" value="">
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

<div id="expense-ledger-dialog" class="hide dialog-content-page noprint">
    <div class="m-t-4">
        <form role="form">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="expense-ledger-contact-category" class="req">Expense Ledger A/C</label>
                        <select id="expense-ledger-contact-category" class="form-control select2">
                            <option value="">Select Expense Ledger A/C</option>
                            {foreach item=category from=$expense_ledger_contacts key=key}
                                {if in_array('EXPLGR', $category->tag) || $key == "EXP"}
                                <option value="{$category->code}">{$category->name}</option>
                                {/if}
                            {/foreach}
                        </select>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="form-group">
                        <label class="req" for="expense-ledger-contact">Sub-Ledger A/c</label>
                        <select id="expense-ledger-contact" class="form-control">
                            <option value="">Select Sub-Ledger A/c</option>
                            {foreach item=category from=$expense_ledger_contacts key=key}
                                {foreach item=row from=$category->contacts}
                                    {if isNotNull($row->contactCategory->code)}
                                    <option value="{$row->code}" data-categorycode="{$row->contactCategory->code}">{$row->name}</option>
                                    {/if}
                                {/foreach}
                            {/foreach}
                        </select>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="form-group">
                        <label class="req" for="expense-ledger-date">Date</label>
                        <input type="text" placeholder="Date" id="expense-ledger-date" autocomplete="off" class="form-control">
                    </div>
                </div>
            </div>
            <div class="clear_fix_both"></div>

            <div class="row">
                <div class="col-lg-3">
                    <div onchange="setTimeout(toggleCashbookCategory)">
                        <label for="expense-ledger-cashbook-category">&nbsp;</label>
                        <span class="radio d-inline-block">
                            <label><input type="radio" name="expense-ledger-cashbook-category" value="VEH" checked> Vehicle</label>
                        </span>&emsp;
                        <span class="radio d-inline-block">
                            <label><input type="radio" name="expense-ledger-cashbook-category" value="BRN"> Branch</label>
                        </span>&emsp;
                    </div>
                </div>

                <div class="col-lg-3 cont">
                    <div class="form-group">
                        <label class="req" for="expense-ledger-vehicle">Vehicle</label>
                        <select id="expense-ledger-vehicle" class="form-control select2">
                            <option value="">Select Vehicle</option>
                            {foreach item=row from=$vehicles}
                                {if $row->ownershipType->code == 'OWN'}
                                    <option value="{$row->code}">{$row->registationNumber}</option>
                                {/if}
                            {/foreach} 
                        </select>
                    </div>
                </div>

                <div class="col-lg-3 cont hide">
                    <div class="form-group">
                        <label class="req" for="expense-ledger-branch">Branch</label>
                        <select id="expense-ledger-branch" class="form-control select2">
                            <option value="">Select Branch</option>
                            {foreach item=row from=$organizations}
                                <option value="{$row->code}">{$row->name}</option>
                            {/foreach} 
                        </select>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label class="req" for="expense-ledger-amount">Amount</label>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rupee"></i></span>
                            <input type="number" placeholder="Amount" id="expense-ledger-amount" name="amount" class="form-control no-spin" min="0">
                        </div>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <label class="req" for="expense-ledger-txn-mode">Transaction Mode</label>
                    <select id="expense-ledger-txn-mode" class="form-control">
                        <option value="">Select Transaction Mode</option>
                        {foreach from=$transactionmode item=val key=k}
                            <option value="{$k}">{$val}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="clear_fix_both"></div>
            <div class="row">
                {* UPI *}
                <div class="hide" id="exp-ledger-upi">
                    <div class="form-group col-md-3">
                        <label class="req" for="exp-ledger-bank-details">Organization Bank</label>
                        <select id="exp-ledger-bank-details" class="form-control">
                            <option value="">Select a Bank</option>
                            {foreach from=$bankdetail item=val}
                                {if $val->accountType->code != 'CASH'}
                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                {/if}
                            {/foreach}
                        </select>
                    </div>

                    <div class="form-group col-md-3">
                        <label class="req" for="exp-ledger-upi-id">UPI Id</label>
                        <input type="text" class="form-control" id="exp-ledger-upi-id" placeholder="UPI ID">
                    </div>

                    <div class="form-group col-md-3">
                        <label for="exp-ledger-upi-details">Ref. #</label>
                        <input type="text" class="form-control" id="exp-ledger-upi-details" placeholder="Ref. #">
                    </div>
                </div>

                {* NBK *}
                <div class="hide" id="exp-ledger-nbk">
                    <div class="form-group col-md-3">
                        <label class="req" for="exp-ledger-bank-nbk">Organization Bank</label>
                        <select id="exp-ledger-bank-nbk" class="form-control">
                            <option value="">Select a Bank</option>
                            {foreach from=$bankdetail item=val}
                                {if $val->accountType->code != 'CASH'}
                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                {/if}
                            {/foreach}
                        </select>
                    </div>

                    <div class="form-group col-md-3">
                        <label class="req" for="exp-ledger-acc-hold-name">Account Holder Name</label>
                        <input type="text" class="form-control" id="exp-ledger-acc-hold-name" placeholder="Account Holder Name">
                    </div>

                    <div class="form-group col-md-3" id="exp-ledger-bank-name-div">
                        <label class="req" for="exp-ledger-bank-name">Bank Name</label>
                        <input type="text" class="form-control" id="exp-ledger-bank-name" placeholder="Bank Name">
                    </div>

                    <div class="form-group col-md-3">
                        <label for="exp-ledger-nbk-details">Ref. #</label>
                        <input type="text" class="form-control" id="exp-ledger-nbk-details" placeholder="Ref. #">
                    </div>
                </div>
            </div>

            <div class="row">
                {* chq *}
                <div class="hide" id="exp-ledger-chq">
                    <div class="form-group col-md-3">
                        <label class="req" for="exp-ledger-payer">Payer Details</label>
                        <input type="text" class="form-control" id="exp-ledger-payer" placeholder="Payer Details">
                    </div>

                    <div class="form-group col-md-2">
                        <label class="req" for="exp-ledger-chq-num">Cheque No</label>
                        <input type="text" class="form-control" id="exp-ledger-chq-num" placeholder="Cheque Number">
                    </div>

                    <div class="form-group col-md-2">
                        <label class="req" for="exp-ledger-chq-date">Cheque Date</label>
                        <div class="input-group">
                            <input type="text" class="form-control sdate" id="exp-ledger-chq-date" readonly placeholder="Cheque Date">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div>

                    <div class="form-group col-md-3" id="exp-ledger-chq-bankname-div">
                        <label class="req" for="exp-ledger-chq-bankname">Bank Name</label>
                        <input type="text" class="form-control" id="exp-ledger-chq-bankname" placeholder="Bank Name">
                    </div>

                    <div class="form-group col-md-2">
                        <label class="req" for="exp-ledger-chq-city">Bank City</label>
                        <input type="text" class="form-control" id="exp-ledger-chq-city" placeholder="Bank City">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-4" id="show-exp-ledger-staff-detail">
                    <div class="form-group">
                        <a href="javascript:;" onclick="showExpLedgerStaff();">Add staff income / expense</a>    
                    </div>                
                </div>
                <div class="col-lg-4 hide" id="hide-exp-ledger-staff-detail">
                    <div class="form-group">
                        <a href="javascript:;" onclick="hideExpLedgerStaff();">Hide staff income / expense</a>    
                    </div>                
                </div>
                
                <div class="col-md-12 hide" id="add-exp-ledger-staff-details">
                    <table class="table table-striped" style="width: 70%;" id="exp-ledger-staff-table">
                        <thead>
                            <tr>
                                <td class="bold req" width="50%">Staff Name</td>
                                <td class="bold req" width="40%">Amount</td>
                                <td  width="10%">
                                    <a href="javascript:;" onclick="addExpLedgerStaff();" class="btn btn-sm btn-default"><i class="fa fa-plus"></i></a>
                                </td>
                            </tr>
                        </thead>
                        <tbody id="exp-ledger-staff-list"></tbody>
                        <tfoot id="exp-ledger-staff-tpl" class="hide">
                            <tr class="exp-ledger-staff-row">
                                <td>
                                    <input type="text" class="form-control expense-ledeger-staff-name">
                                </td>
                                <td>
                                    <input type="number" placeholder="Amount" onchange="calculateExpLedgerAmount();" name="amount" class="form-control no-spin expense-ledeger-staff-amount" step="any">
                                </td>
                                <td>
                                    <a href="javascript:;" onclick="removeExpLedgerStaff(this);" class="btn btn-sm btn-default"><i class="fa fa-minus"></i></a>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>        
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="form-group">
                        <label for="exp-ledger-remarks">Remarks</label>
                        <textarea id="exp-ledger-remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="2" cols="10" name="remark" id="remark" maxlength="120"></textarea>
                    </div>
                </div>
                
                <div class="col-md-12">
                    {include file="site/cargo/file-upload-component.tpl" id="expense-ledger-fileupload" axis="horizontal"}
                </div>
            </div>
            <div class="clear_fix_both"></div>
        </form>
    </div>
    <div class="clear_fix_both">
        <input type="hidden" id="expense-ledger-hid-code">
        <div class="alert" style="display: none;" id="expense-ledger-action-state"></div>
        <div class="align-right" id="expense-ledger-form-bttons">
            <button class="btn btn-success" type="button" onclick="saveExpenseLedger();">Save</button>
            <button class="btn btn-default" type="button" onclick="closeExpenseLedger();">Cancel</button>
        </div>
    </div>
</div>

<div id="add-adv-dialog" class="hide" style="overflow: hidden;">
    <div class="row">
        <div class="col-md-10 bold ft_15">
            Add Advance Payment
        </div>
    </div>
    <br>
    <div class="row">
        <div class="form-group col-md-3">
            <label class="" for="adv-amt-type">Advance Amount Type</label>
            <div class="input-group">
                <label class="radio-inline">
                    <input type="radio" name="optradio" id="adv-amt-type" class="adv-amt-type" value="DVR" checked>Driver&nbsp;
                </label>
                {* <label class="radio-inline">
                    <input type="radio" name="optradio" id="adv-amt-type" class="adv-amt-type" value="USR">User&nbsp;
                </label> *}
                <label class="radio-inline">
                    <input type="radio" name="optradio" id="adv-amt-type" class="adv-amt-type" value="BSTF">Branch Staff&nbsp;
                </label>
            </div>
        </div>

        <div class="form-group col-md-4 hide" id="adv-amnt-driver">
            <label class="req">Driver</label>
            <select id="adv-amt-driver" class="form-control">
                <option value="">Select a Driver</option>
                {foreach from=$drivers item=row}
                    <option value="{$row->code}">{$row->name}</option>
                {/foreach}
            </select>
        </div>

        <div class="form-group col-md-4 hide" id="adv-amnt-user">
            <label class="req">User</label>
            <select id="adv-amt-user" class="form-control">
                {* <option value="">Select a User</option>
                {foreach from=$users item=row}
                    <option value="{$row->code}">{$row->name}</option>
                {/foreach} *}
                {foreach item=branch from=$branchusers}
                    <optgroup label="{$branch['name']}">
                        {foreach item=row from=$branch['users']}
                            {if $row->activeFlag == 1}
                                <option value="{$row->code}" data-org="{$row->organization->code}" {if $row->code == $usr_login_id}selected{/if}>{$row->name}</option>
                            {/if}
                        {/foreach}
                    </optgroup>
                {/foreach}
            </select>
        </div>

        <div class="form-group col-lg-4 hide" id="adv-amnt-branch">
            <label class="req">Branch</label>
            <select id="adv-amt-branch" class="form-control">
                <option value="">Select a Branch</option>
                {foreach from=$organizations item=row}
                    <option value="{$row->code}">{$row->name}</option>
                {/foreach}
            </select>
        </div>
        <div class="form-group col-lg-4 hide">
            <label class="req">Branch Staff</label>
            <select id="adv-amt-branchStaff" class="form-control">
                <option value="">Select a Branch Staff</option>
            </select>
        </div>
    </div>
    <div class="row">

        <div class="form-group col-md-2 cont">
            <label class="req" for="adv-amt-txn-amt">Transaction Amount</label>
            <input type="number" class="form-control" id="adv-amt-txn-amt" placeholder="Transaction Amount" step="any">
        </div>

        <div class="form-group col-md-2">
            <label class="req" for="adv-amt-rcvd-date">Amount Payment date</label>
            <div class="input-group">
                <input type="text" class="form-control sdate" id="adv-amt-rcvd-date" readonly placeholder="Amount Payment date">
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
        </div>

        <div class="form-group col-md-3">
            <label class="req" for="adv-amt-txn-mode">Transaction Mode</label>
            <select id="adv-amt-txn-mode" class="form-control">
                <option value="">Select Transaction Mode</option>
                {foreach from=$transactionmode item=val key=k}
                    <option value="{$k}">{$val}</option>
                {/foreach}
            </select>
        </div>
    </div>

    <div class="row">
        {* UPI *}
        <div class="hide" id="adv-amt-upi">
            <div class="form-group col-md-3">
                <label class="req" for="adv-amt-bank-details">Organization Bank</label>
                <select id="adv-amt-bank-details" class="form-control">
                    <option value="">Select a Bank</option>
                    {foreach from=$bankdetail item=val}
                        <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                    {/foreach}
                </select>
            </div>

            <div class="form-group col-md-3">
                <label class="req" for="adv-amt-upi-id">UPI Id</label>
                <input type="text" class="form-control" id="adv-amt-upi-id" placeholder="UPI ID">
            </div>

            <div class="form-group col-md-3">
                <label for="adv-amt-upi-details">Ref. #</label>
                <input type="text" class="form-control" id="adv-amt-upi-details" placeholder="Ref. #">
            </div>
        </div>

        {* NBK *}
        <div class="hide" id="adv-amt-nbk">
            <div class="form-group col-md-3">
                <label class="req" for="adv-amt-bank-nbk">Organization Bank</label>
                <select id="adv-amt-bank-nbk" class="form-control">
                    <option value="">Select a Bank</option>
                    {foreach from=$bankdetail item=val}
                        <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                    {/foreach}
                </select>
            </div>

            <div class="form-group col-md-3">
                <label class="req" for="adv-amt-acc-hold-name">Account Holder Name</label>
                <input type="text" class="form-control" id="adv-amt-acc-hold-name" placeholder="Account Holder Name">
            </div>

            <div class="form-group col-md-3" id="adv-amt-bank-name-div">
                <label class="req" for="adv-amt-bank-name">Bank Name</label>
                <input type="text" class="form-control" id="adv-amt-bank-name" placeholder="Bank Name">
            </div>

            <div class="form-group col-md-3">
                <label for="adv-amt-nbk-details">Ref. #</label>
                <input type="text" class="form-control" id="adv-amt-nbk-details" placeholder="Ref. #">
            </div>
        </div>
    </div>

    <div class="row">
        {* chq *}
        <div class="hide" id="adv-amt-chq">
            <div class="form-group col-md-2 hide">
                <label class="req" for="adv-amt-chq-branch">Branch</label>
                <select id="adv-amt-chq-branch" class="form-control">
                    <option value="" >Select a Branch</option>
                    {foreach from=$organizations item=row}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>

                <input type="hidden" id="adv-amt-chq-branch-hid" value="{$login_branch}">
            </div>

            <div class="form-group col-md-3">
                <label class="req" for="adv-amt-payer">Payer Details</label>
                <input type="text" class="form-control" id="adv-amt-payer" placeholder="Payer Details">
            </div>

            <div class="form-group col-md-2">
                <label class="req" for="adv-amt-chq-num">Cheque No</label>
                <input type="text" class="form-control" id="adv-amt-chq-num" placeholder="Cheque Number">
            </div>

            <div class="form-group col-md-2">
                <label class="req" for="adv-amt-chq-date">Cheque Date</label>
                <div class="input-group">
                    <input type="text" class="form-control sdate" id="adv-amt-chq-date" readonly placeholder="Cheque Date">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>

            <div class="form-group col-md-3" id="adv-amt-chq-bankname-div">
                <label class="req" for="adv-amt-chq-bankname">Bank Name</label>
                <input type="text" class="form-control" id="adv-amt-chq-bankname" placeholder="Bank Name">
            </div>

            <div class="form-group col-md-2">
                <label class="req" for="adv-amt-chq-city">Bank City</label>
                <input type="text" class="form-control" id="adv-amt-chq-city" placeholder="Bank City">
            </div>
        </div>
    </div>

    <div class="row">
        <div class="form-group col-md-12">
            <label>Remarks</label>
            <textarea id="adv-amt-remarks"  placeholder="Enter your remarks" style="resize:none" class="form-control" rows="2" cols="30" name="remark" id="remark"></textarea>
        </div>
    </div>
    <div style="padding:15px 15px 10px;">
        <div class="row">
            <input type="hidden" id="adv-amt-code">
            <input type="hidden" id="adv-amt-chq-code">
            <div class="clear_fix_both">
                <div class="alert hide" id="adv-amt-action-state"></div>
                <div class="align-right" id="adv-amt-form-buttons">
                    <button class="btn btn-success" type="button" onclick="saveAdvanceDialog();">Save</button>
                    <button class="btn btn-default" type="button" onclick="closeAdvanceDialog();">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</div>

<iframe name="ifrm_trans_downloader" id="ifrm_trans_downloader" style="display:none"></iframe>
<input type="hidden" id="logged-in-branch-code" value="{$logged_in_usr_org_code}">
<style>
.nav-tabs > li > a,
.nav-tabs > li.active > a {
    padding: 12px 25px 9px 25px!important;
}
.switch-id-expense-type-cb {
    width: 130px;
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
    var users = {$users|json_encode}
    var driver = {$drivers|json_encode}
    var expense_ledger_contact = $('#expense-ledger-contact option');
    var emptyLedgerContactOption = '<option value="">Select Sub-Ledger A/c</option>';
    
    $('.bsn_switch').bootstrapSwitch();
    $('#container-fluid select:not(#expense-tags, .expense-staff-name)').select2();
    $('[data-toggle="tooltip"]').tooltip()

    $('#make-pay-chq-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true,
        startDate: '-1d',
        endDate:'0d'
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
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#make-pay-chq-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#make-pay-chq-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });
    
    $('#exp-tabs li').on('click', function(e) {
        $('#show-staff-detail, #hide-staff-detail, #add-staff-details').addClass('hide');
        $('#branch-staff-list').html('');
        $('#expense-tags').val('').multiselect('refresh');

        $('#expense-amount').prop('disabled', false)
        if ($(e.target).data('val') == 'BRN') {
            $('#show-staff-detail').removeClass('hide');
        }
    });

    $('#ref-organization').on('change', function() {
        $('#branch-staff-list').html('');
        // $('#branch-staff-tpl .expense-staff-name').html(new Option('Select', ''));
        $('#expense-tags').val('').multiselect('refresh');
        var organizationCode = $(this).val();
        var branch = _.find(allOrganizations, function (o) { return o.code === organizationCode; });
        
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
            success: function (res) {
                if(res.status==1) {
                    // $.each(res.data, function() {
                    //     $('#branch-staff-tpl .expense-staff-name').append(new Option(this.name, this.code))
                    // });
                    branchStaff = res.data;

                    var expenseCode = $('#expense-code').val();
                    var expenseData = _.find(allExpenses, function (o) { return o.transaction_code === expenseCode; });
                    if (expenseData && expenseData.cashbook_transaction_details) {
                        $('#add-staff-details').removeClass('hide');
                        var transactionDetails = expenseData.cashbook_transaction_details.split(',');
                        $.each(transactionDetails, function(key, val) {
                            addBranchStaff(val);
                            $('#expense-amount').prop('disabled', true);
                            $('#hide-staff-detail').removeClass('hide');
                            $('#show-staff-detail').addClass('hide');
                        });
                    }
                }
            }
        })
    });

    $('#ref-vehicle').on('change', function() {
        $('#expense-tags').val('').multiselect('refresh');

        var vehicleCode = $(this).val();
        var vehicle = _.find(allVehicles, function (o) { return o.code === vehicleCode; });
        
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

    $('input[type="radio"][name="exptyperadio"]').on('change', function() {
        $('#income-head-panel, #expense-head-panel').addClass('hide');
        $('#expense-vendor-panel, #expense-received-panel').addClass('hide');
        $('.income-expense-pannel, .payment-pannel, .expense-ledger-pannel, #expenses-list-container, #payment-list-container, #expense-ledger-list-container, #adv-amt-list-container').addClass('hide');
        var incExpReceiptDate = $('#expenses-date').val();

        if (this.value == 'INCOME') {
            if (incExpReceiptDate == '') {
                $('#expenses-date').datepicker('setDate', new Date());
            }
            $('#income-head-panel, #expense-received-panel, .income-expense-pannel, #expenses-list-container').removeClass('hide');
        } else if (this.value == 'EXPENSE') {
            if (incExpReceiptDate == '') {
                $('#expenses-date').datepicker('setDate', new Date());
            }
            $('#expense-head-panel, #expense-vendor-panel, .income-expense-pannel, #expenses-list-container').removeClass('hide');
        } else if (this.value == 'PAYMENT') {
            $('.payment-pannel').removeClass('hide');
        } else if (this.value == 'EXPLEDGER') {
            $('.expense-ledger-pannel').removeClass('hide');
        }
    });

    $('input[type="radio"][name="paymenttyperadio"]').on('change', function() {
        $('#payment-panel-vehicle, #payment-panel-vendor, #payment-panel-contact, #payment-adv-panel, #payment-adv-details').addClass('hide');
        $('.payment-panel-details').removeClass('hide');
        if (this.value == 'TRANSPORTER') {
            $('#payment-panel-vehicle').removeClass('hide');
        } else if (this.value == 'FUEL') {
            $('#payment-panel-vendor').removeClass('hide');
        } else if (this.value == 'JOURNAL') {
            $('#payment-panel-contact').removeClass('hide');
        } else if (this.value == 'ADV') {
            $('#payment-adv-panel').removeClass('hide');
            $('#payment-adv-details').removeClass('hide');
            $('.payment-panel-details').addClass('hide');
        }
    });
    $('#adv-amt-bank-details, #adv-amt-chq-bank-details, #adv-amt-chq-branch, #adv-amt-bank-nbk').select2();

    $('#adv-amt-branch,#adv-amt-user,#adv-amt-driver').select2();

    $('#adv-amt-from-date').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true
    }).on('changeDate', function (e) {
        $('#adv-amt-to-date').datepicker('setStartDate', e.date);
    });

    $('#adv-amt-to-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true
    }).on('changeDate', function (e) {
        $('#adv-amt-from-date').datepicker('setEndDate', e.date);
    });
    $('#adv-amt-from-date').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true
    }).on('changeDate', function (e) {
        $('#adv-amt-to-date').datepicker('setStartDate', e.date);
    });

    $('#adv-amt-to-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true
    }).on('changeDate', function (e) {
        $('#adv-amt-from-date').datepicker('setEndDate', e.date);
    });

    $('#adv-amt-chq-date, #adv-amt-rcvd-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true
    });

    $('#adv-amt-bank-name').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#adv-amt-bank-name-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#adv-amt-chq-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#adv-amt-chq-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('input[type="radio"][name="paymentAdvRadio"]').on('change', function() {
    });

    $('#adv-amt-txn-mode').on('change', function(){
        $('#adv-amt-bank-details, #adv-amt-bank-nbk, #adv-amt-chq-bank-details, #adv-amt-chq-bankname, #adv-amt-chq-branch').val('').trigger('change');
        $('#adv-amt-payer, #adv-amt-chq-num, #adv-amt-chq-date, #adv-amt-chq-city, #adv-amt-upi-id, #adv-amt-upi-details, #adv-amt-bank-name, #adv-amt-acc-hold-name, #adv-amt-nbk-details').val('');

        $('#adv-amt-chq, #adv-amt-upi, #adv-amt-nbk').addClass('hide');
        if($(this).val() == 'UPI'){
            $('#adv-amt-upi').removeClass('hide');
        }else if($(this).val() == 'NBK'){
            $('#adv-amt-nbk').removeClass('hide');
        }else if($(this).val() == 'CHEQUE'){
            $('#adv-amt-chq').removeClass('hide');
        }
    });

    $('.adv-amt-type').on('change', function() {
        $('#adv-amt-driver,#adv-amt-branch').val('').trigger('change');
        $('.txn-only-fields input').val('').trigger('change');
        $('#adv-amnt-driver').addClass('hide');
        $('#adv-amnt-branch').addClass('hide');
        $('#adv-amnt-user').addClass('hide');
        $('#vendor-customer-info').removeClass('hide');
        $('#cargo-bookings, #payment-transactions').addClass('hide');
        $('.txn-only-fields').removeClass('hide');
        $('#adv-amt-txn-amt').closest('.cont').addClass('hide');

        if ($(this).val() == 'DVR') {
            $('#adv-amnt-driver').removeClass('hide');
            $('.txn-only-fields').addClass('hide');
            $('#adv-amt-txn-amt').closest('.cont').removeClass('hide');
        } else if ($(this).val() == 'USR')  {
            $('#adv-amnt-user').removeClass('hide');
            $('#vendor-customer-list-panel').removeClass('hide');
            $('#adv-amt-txn-amt').closest('.cont').removeClass('hide');
        } else if ($(this).val() == 'BSTF')  {
            $('#vendor-customer-list-panel').addClass('hide');
            $('#adv-amnt-branch').removeClass('hide');
            $('.txn-only-fields').addClass('hide');
            $('#adv-amt-txn-amt').closest('.cont').removeClass('hide');
        }
    });

    $('#adv-amt-branch').on('change', function() {
        var $branchStaff = $('#adv-amt-branchStaff');
        $('#adv-amt-branchStaff').closest('.form-group').addClass('hide');
        var data = {};
        data.organizationCode = $(this).val();
        if (!data.organizationCode) {
            $branchStaff.html('').select2().html('');
            return;
        }
        $branchStaff.html(new Option('Loading...', '', true, true)).select2().html('');
        $('#adv-amt-branchStaff').closest('.form-group').removeClass('hide');
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

    $('#make-pay-txn-mode').on('change', function(){
        $('#make-pay-chq, #make-pay-upi, #make-pay-nbk').addClass('hide');
        $('#make-pay-bank-details, #make-pay-bank-nbk, #make-pay-bank-name, #make-pay-chq-bankname').val('').trigger('change');
        $('#make-pay-upi-id, #make-pay-upi-details, #make-pay-acc-hold-name, #make-pay-nbk-details, #make-pay-payer, #make-pay-chq-num, #make-pay-chq-date, #make-pay-chq-city, #make-pay-cheque-remarks').val('');

        if($(this).val() == 'UPI'){
            $('#make-pay-upi').removeClass('hide');
        }else if($(this).val() == 'NBK'){
            $('#make-pay-nbk').removeClass('hide');
        }else if($(this).val() == 'CHEQUE'){
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
    }).on('show.daterangepicker', function (ev, picker) {
        picker.showCalendars()
    });

    $('#expenses-date').datepicker({
        format: 'yyyy-mm-dd',
        startDate: '{if $action_rights['DISABLE-PAST-DATE'] == 1}0d{else}-3m{/if}',
        endDate: "+1d",
        autoclose: true,
        changeMonth: true,
    }).on('changeDate', function (e) {
        getAllTransits();
        getExpenseTransactions();
    });

    {if $action_rights['EBL-EXP-LEDGER'] == 1}
        $('input[type="radio"][value="EXPLEDGER"]').prop('checked', true).trigger('change');
    {else}
        $('#expenses-date').datepicker('setDate', new Date());
    {/if}

    // expense ledger start
    var expenseLedgerFileUpload = new fileUpload('#expense-ledger-fileupload');

    $('#expense-ledger-from').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true,
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#expense-ledger-to').datepicker('setStartDate', e.date);
        $("#expense-ledger-to").datepicker("setEndDate", end)
    });
    $('#expense-ledger-to').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'dd-mm-yyyy',
        maxDate: "+365D",
        autoclose: true
    }).on('changeDate', function (e) {
        $('#expense-ledger-from').datepicker('setEndDate', e.date)
    });
    
    $('#expense-ledger-contact-category, #expense-ledger-contact, #expense-ledger-vehicle, #expense-ledger-branch').select2();
    $('#exp-ledger-chq-date, #expense-ledger-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true
    });
    
    $('#exp-ledger-bank-name').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#exp-ledger-bank-name-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#exp-ledger-chq-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#exp-ledger-chq-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#expense-ledger-txn-mode').on('change', function(){
        $('#exp-ledger-bank-details, #exp-ledger-bank-nbk, #exp-ledger-chq-bank-details, #exp-ledger-chq-bankname, #exp-ledger-chq-branch').val('').trigger('change');
        $('#exp-ledger-payer, #exp-ledger-chq-num, #exp-ledger-chq-date, #exp-ledger-chq-city, #exp-ledger-upi-id, #exp-ledger-upi-details, #exp-ledger-bank-name, #exp-ledger-acc-hold-name, #exp-ledger-nbk-details').val('');

        $('.exp-ledger-advance, #exp-ledger-chq, #exp-ledger-upi, #exp-ledger-nbk').addClass('hide');
        $('#exp-ledger-form-buttons').removeClass('hide');
        if ($(this).val() == 'UPI') {
            $('#exp-ledger-upi').removeClass('hide');
        } else if ($(this).val() == 'NBK') {
            $('#exp-ledger-nbk').removeClass('hide');
        } else if ($(this).val() == 'CHEQUE') {
            $('#exp-ledger-chq').removeClass('hide');
        } else if ($(this).val() == 'ADV') {
            $('#exp-ledger-form-buttons').addClass('hide');
            $('#exp-ledger-up-inv-table .inv-check:checked').each(function(){
                $(this).closest('tr').find('.exp-ledger-advance').removeClass('hide');
                $(this).closest('tr').find('#exp-ledger-advance-amount').val('');
            });
        }
    });

    $('#expense-ledger-contact-category').on('change', function() {
        var category_code = $(this).val();
        $('#expense-ledger-contact').html(function () {
            return expense_ledger_contact.filter(function () {
                return $(this).data('categorycode') == category_code;
            });
        }).prepend(emptyLedgerContactOption).val('').trigger('change');
    });
    // expense ledger end
    
    function toggleCashbookCategory() {
        var category = $('[name="expense-ledger-cashbook-category"]:checked').val();

        $('#expense-ledger-vehicle').closest('.cont').addClass('hide');
        $('#expense-ledger-branch').closest('.cont').addClass('hide');

        if (category == 'VEH') {
            $('#expense-ledger-vehicle').closest('.cont').removeClass('hide');
        } else if (category == 'BRN') {
            $('#expense-ledger-branch').closest('.cont').removeClass('hide');
        }
    }

    function getAllTransits() {
        $('#ref-transit-cont').html(loading_popup);
            
        var data = {};
        data.travel_date = $('#expenses-date').val();
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/get-transit-list",
            data: data,
            success: function (response) {
                if(response.status==1) {
                    var html = '<select id="ref-transit" name="ref-transit"  class="form-control" >';
                    html += '<option value="">Select a Transit</option>';
                    $.each(response.data, function(catkey, transit) {
                        html += '<option value='+transit.code+' >'+transit.fromStation.name + ' to ' + transit.toStation.name +  ' | ' + transit.busVehicle.registationNumber + ' | ' + transit.aliasCode + '</option>';;
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
        var err = 0;

        var data = {};
        data.code = $('#expense-code').val();
        data.cashbookCategory = {};
        data.cashbookCategory.code = $('#exp-tabs li.active [data-val]').attr('data-val');
        if (data.cashbookCategory.code == 'VEH') {
            data.referenceCode = $('#ref-vehicle').val();
        } else if (data.cashbookCategory.code == 'TRN') {
            data.referenceCode = $('#ref-transit').val();
        } else if (data.cashbookCategory.code == 'BRN') {
            data.referenceCode = $('#ref-organization').val();
        } else if (data.cashbookCategory.code == 'LR') {
            data.referenceCode = $('#ref-lr').val();
        }

        var transactionType = $('input[type="radio"][name="exptyperadio"]:checked').val();
        if (transactionType == 'INCOME') {
            data.transactionType = 'Cr';
        } else if (transactionType == 'EXPENSE') {
            data.transactionType = 'Dr';
        }
        
        data.cashbookType = {};
        data.cashbookVendor = {};

        if (data.transactionType == 'Cr') {
            data.cashbookType.code = $('#expense-income').val();
            data.cashbookVendor.code = $('#expense-received').val();
        } else if (data.transactionType == 'Dr') {
            data.cashbookType.code = $('#expense-expense').val();
            data.cashbookVendor.code = $('#expense-vendor').val();
        }

        data.cashbookTransactionDetails = [];
        if (data.cashbookCategory.code == 'BRN' && !$('#add-staff-details').hasClass('hide')) {
            if ($('#branch-staff-list .branch-staff-row:not([data-deleted=1])').length == 0) {
                $('#expense-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#expense-action-state').html('Please add atleast one staff income / expense !!');
                $('#expense-action-state').show();
                return false;
            }

            var staffNames = [];
            $('#branch-staff-list .branch-staff-row').each(function() {
                var cashbookTransaction = {};
                cashbookTransaction.activeFlag = ($(this).data('deleted') == 1) ? 0 : 1;

                cashbookTransaction.organizationContact = {};
                var branchStaffName = $(this).find('input.expense-staff-name').val();
                cashbookTransaction.organizationContact.code = branchStaffName;

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

        data.amount = $('#expense-amount').val();
        data.user = {};
        data.user.code = $('#expense-user').val();
        data.transactionMode = {};
        data.transactionMode.code = $('#expense-mode').val();
        data.receiptDate = $('#expenses-date').val();
        data.acknowledgeStatus = {};
        data.acknowledgeStatus.code = '{if $action_rights['IE-SLF-APOVE'] == 1}APRD{else}INIT{/if}';
        data.remarks = $('#expense-remarks').val();

        data.cashbookEntryType = {};
        data.cashbookEntryType.code = 'DEF';
        data.activeFlag = 1;

        var log_in_org_code = $('#logged-in-branch-code').val();
        data.tag = [];
        $.each($('#expense-tags').val() || [], function (i, code) {
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
        if (data.transactionType == 'Cr') {
            data.cashbookType.code = $('#expense-income').val();
            if (data.cashbookType.code == '') {
                $('#expense-income').addClass('inp_error');
                err++;
            }
        } else if (data.transactionType == 'Dr') {
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
        if($('#expense-tags').length){
            if(data.tag.length == 0){
                $('.expense-tags').addClass('inp_error');
                err++;
            }
        }
        {/if}

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
            var expensData = _.find(allExpenses, function(o) { return o.transaction_code === data.code; });
            if (isNotNull(expensData) && isNotNull(expensData.cashbook_transaction_details) && data.cashbookTransactionDetails.length === 0) {
                var transactionDetails = expensData.cashbook_transaction_details.split(',');
                $.each(transactionDetails, function(key, val) {
                    var staff = val.split(':');
                    var cashbook_transaction_details = {};
                    cashbook_transaction_details.organizationContact = {};
                    cashbook_transaction_details.organizationContact.code = staff[0];
                    cashbook_transaction_details.amount = staff[2];
                    cashbook_transaction_details.activeFlag = 2;
                    
                    data.cashbookTransactionDetails.push(cashbook_transaction_details);
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
            success: function (response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#expense-action-state').removeClass('alert-danger');
                    $('#expense-action-state').addClass('alert-success');
                    $('#expense-action-state').html('Your request has been completed successfully');
        
                    window.setTimeout(function () {
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
        
        {if $action_rights['EBL-EXP-LEDGER'] == 1}
            $('input[type="radio"][value="EXPLEDGER"]').prop('checked', true).trigger('change');
        {else}
            $('input[type="radio"][value="EXPENSE"]').prop('checked', true).trigger('change');
            $('#exp-tabs li [data-val=BRN]').trigger('click');
            if (date) {
                $('#expenses-date').datepicker('setDate', new Date());
            }
        {/if}

        $('#expense-code').val('').trigger('change');
        $('#ref-vehicle').val('').trigger('change');
        $('#ref-transit').val('').trigger('change');
        $('#ref-organization').val(organization).trigger('change');
        $('#ref-lr').val('').trigger('change');
        $('#expense-income').val('').trigger('change');
        $('#expense-expense').val('').trigger('change');
        $('#expense-amount').val('').trigger('change');
        $('#expense-user').val('').trigger('change');
        $('#expense-vendor').val('').trigger('change');
        $('#expense-mode').val('').trigger('change');
        $('#expense-tags').val(identicalTags).multiselect('refresh');
        $('#expense-remarks').val('');
        $('#ref-transit-cont').data('val', '');
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
            success: function (response) {
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
            success: function (response) {
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
        var data = _.find(allExpenses, function (o) { return o.transaction_code === code; });
        
        $('#expense-code').val(data.transaction_code).trigger('change');
        $('#exp-tabs li [data-val=' +data.category_type+ ']').trigger('click');
        if (data.category_type == 'VEH') {
            $('#ref-vehicle').val(data.reference_code).trigger('change');
        } else if (data.category_type == 'TRN') {
            $('#ref-transit-cont').data('val', data.reference_code).trigger('change');
        } else if (data.category_type == 'BRN') {
            $('#ref-organization').val(data.reference_code).trigger('change');
        }  else if (data.category_type == 'LR') {
            $('#ref-lr').val(data.reference_code).trigger('change');
        }
        $('#expense-type-cb').bootstrapSwitch('state', data.transaction_type == 'Dr');
        $('#expense-type-cb').bootstrapSwitch('disabled', true);

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
            scrollTop: $('#container-fluid').offset().top -100
        }, 400);
    }

    function deleteExpenses(code) {
        if (!confirm('Do you want to delete this Transaction?')) {
            return;
        }
        var exp = _.find(allExpenses, function (o) {
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
                var staff = val.split(':');
                staffTransaction = {};
                staffTransaction.organizationContact = {};
                staffTransaction.organizationContact.code = staff[0];

                staffTransaction.amount = staff[2];
                staffTransaction.activeFlag = 1;

                data.cashbookTransactionDetails.push(staffTransaction);
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
            success: function (response) {
                if (response.status === 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        getExpenseTransactions();
                        return;
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

    function showPRGallery (code) {
        fileupload.showGalleryDialog({
            referenceCode: code,
            imageCategoryCode: 'CSHBO'
        });
    }

    var branchSelectTpl = $('#manage-exp-branch-select-tpl').html();
    function formatResult(branch) {
        if (!branch.id) return branch.text;

        var $tpl = $(branchSelectTpl);
        $tpl.find('.branch-name').text(branch.text);
        $tpl.find('.alias-code').text(branch.aliasCode);
        return $tpl;
    };

    function matcher(term, text, branch) {
        text = [branch.text, branch.aliasCode].join(' ');
        return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
    };

    function addBranchStaff(data) {
        var $tpl = $('#branch-staff-tpl .branch-staff-row').clone();
        $('#branch-staff-list').append($tpl);
        
        var branchstaffdata = [];
        $.each(branchStaff || [], function (i, row) {
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

        // $tpl.find('.expense-staff-name').select2();
        $tpl.find('.expense-staff-amount').val(0);
        
        if (_isdefined(data)) {
            var staff = data.split(':');
            $tpl.find('.expense-staff-name').val(staff[0]).trigger('change');
            $tpl.find('.expense-staff-amount').val(staff[2]);
        }
    }

    function removeBranchStaff(ele) {
        if($('#branch-staff-table tbody tr:not([data-deleted=1])').length > 1){
            $(ele).closest('tr').attr('data-deleted', 1).hide();
        }
        calculateAmount();
    }

    function showBranchStaff() {
        $('#branch-staff-list').html('');

        $('#hide-staff-detail').removeClass('hide');
        $('#show-staff-detail').addClass('hide');
        $('#add-staff-details').removeClass('hide');
        $('#expense-amount').prop('disabled', true);
    }

    function hideBranchStaff() {
        $('#hide-staff-detail').addClass('hide');
        $('#show-staff-detail').removeClass('hide');
        $('#add-staff-details').addClass('hide');
        $('#expense-amount').prop('disabled', false);
    }

    function calculateAmount() {
        var totalAmount = 0;
        $('#branch-staff-list .branch-staff-row:not([data-deleted=1])').each(function() {
            totalAmount += parseFloat($(this).find('.expense-staff-amount').val());
        });
        $('#expense-amount').val(totalAmount);
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
            success: function (response) {
                $('#payment-list').html(response);
            }
        })
    }

    var paymentTransactionCode = [];
    function manageExpensePaymentDialog(type='', vehicleCode='', vendor='') {
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
            if ($(this).find('.makepayment-entry:checked') && isNotNull(transactionCode)) {
                var amount = parseFloat($(this).find('.make-payment-amount').val());
                var cashbookType = $(this).find('.makepayment-entry:checked').data('cashbooktype');
                var paymentType = $(this).find('.makepayment-entry:checked').data('paymenttype');
                var sourceType = $(this).find('.makepayment-entry:checked').data('sourcetype');

                var transactions = {}
                transactions.code = transactionCode;
                transactions.paidAmount = amount;
                paymentTransactionCode.push(transactions);
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
        data.transactions = paymentTransactionCode || [];

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

        if (data.transactions.length == 0) {
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
            
            data.chequeDetails.chequeDate = moment($('#make-pay-chq-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
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
            success: function (response) {
                if (response.status == 1) {
                    $('#make-pay-action-state').removeClass('alert-danger');
                    $('#make-pay-action-state').addClass('alert-success');
                    $('#make-pay-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
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

    function getExpenseLedger() {
        $('.inp_error').removeClass('inp_error');
        $('#expense-ledger-list-container').addClass('hide');
        $('#expense-ledger-list').html('');
        var err = 0;

        var data = {};
        data.fromDate = $('#expense-ledger-from').val();
        data.toDate = $('#expense-ledger-to').val();
        data.organizationCode = $('#expense-ledger-branch-filter').val();
        data.organizationReceiptCode = $('#expense-ledger-branch-receipt').val();
        data.entryTypeCode = 'EXLGR';

        if (data.fromDate == '') {
            $('#expense-ledger-from').addClass('inp_error');
            err++;
        }

        if (data.toDate == '') {
            $('#expense-ledger-to').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#expense-ledger-report-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#expense-ledger-report-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#expense-ledger-report-action-state').show();
            return false;
        } else {
            $('#expense-ledger-report-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#expense-ledger-report-action-state').hide();
        }

        $('#form-bttons').hide();
        $('#expense-ledger-report-action-state').removeClass('alert-danger').removeClass('alert-success').html('').hide();
        $('#expense-ledger-list-container').removeClass('hide');
        $('#expense-ledger-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "payment/get-expense-ledger-list",
            data: data,
            success: function (response) {
                $('#expense-ledger-list').html(response);
                $('#print_button').removeClass('hide');
            }
        });
    }

    function clearExpenseLedger() {
        $('#expense-ledger-from, #expense-ledger-to, #expense-ledger-branch-filter, #expense-ledger-branch-receipt').val('');
        $('.inp_error').removeClass('inp_error');
        $('#expense-ledger-report-action-state').removeClass('alert-danger').removeClass('alert-success').html('').hide();
        $('#expense-ledger-list-container').addClass('hide');
        $('#expense-ledger-list').html('');
    }

    function addExpenseLedger(code) {
        $('#expense-ledger-dialog').css('background', '#fff');
        $('#expense-ledger-dialog').removeClass('hide');
        $('#expense-ledger-dialog').dialog({
            autoOpen: true,
            height: 500,
            width: 950,
            modal: true,
            resizable: false,
            closeOnEscape: true
        });
        $('.ui-dialog-titlebar').hide();
        $('#expense-ledger-action-state').removeClass('alert-danger').hide().html('');
        $('.inp_error').removeClass('inp_error');

        $('#expense-ledger-contact-category, #expense-ledger-contact, #expense-ledger-vehicle, #expense-ledger-branch, #expense-ledger-date, #expense-ledger-txn-mode, #add-exp-ledger-staff-details, #expense-ledger-amount, #exp-ledger-remarks').val('').trigger('change');
        $('input[name=expense-ledger-cashbook-category][value=VEH]').prop('checked', true).trigger('change');
        hideExpLedgerStaff();

        if (_isdefined(code)) {
            var data = _.find(expenseLedgerData, function (o) { return o.code === code});

            $('#expense-ledger-hid-code').val(data.code);
            $('#expense-ledger-contact-category').val(data.cashbookVendor.contactCategory.code).trigger('change');
            $('#expense-ledger-contact').val(data.cashbookVendor.code).trigger('change');
            // $('#expense-ledger-date').val(data.receiptDate).trigger('change');
            $('#expense-ledger-date').datepicker('update', moment(data.receiptDate).format('DD-MM-YYYY'));

            $('input[name=expense-ledger-cashbook-category][value='+data.cashbookCategory.code+']').prop('checked', true).trigger('change');
            if (data.cashbookCategory.code == 'VEH') {
                $('#expense-ledger-vehicle').val(data.busVehicle.code).trigger('change');
            } else {
                $('#expense-ledger-branch').val(data.organization.code).trigger('change');
            }
            $('#expense-ledger-amount').val(data.amount);
            $('#expense-ledger-txn-mode').val(data.transactionMode.code).trigger('change');

            if (data.transactionMode.code == 'NBK') {
                $('#exp-ledger-bank-nbk').val(data.bankDetails.code).trigger('change');
                $('#exp-ledger-acc-hold-name').val(data.addAttr1).trigger('change');
                $('#exp-ledger-bank-name').val(data.addAttr2).trigger('change');
                $('#exp-ledger-nbk-details').val(data.addAttr3).trigger('change');
            } else if (data.transactionMode.code == 'UPI') {
                $('#exp-ledger-bank-details').val(data.bankDetails.code).trigger('change');
                $('#exp-ledger-upi-id').val(data.addAttr1).trigger('change');
                $('#exp-ledger-upi-details').val(data.addAttr2).trigger('change');
            } else if (data.transactionMode.code == 'CHEQUE') {
                $('#exp-ledger-payer').val(data.chequeDetails.payerDetails).trigger('change');
                $('#exp-ledger-chq-num').val(data.chequeDetails.chequeNo).trigger('change');
                $('#exp-ledger-chq-date').val(data.chequeDetails.chequeDate).trigger('change');
                $('#exp-ledger-chq-bankname').val(data.chequeDetails.bankDetails).trigger('change');
                $('#exp-ledger-chq-city').val(data.chequeDetails.bankCity).trigger('change');
            }

            if (data.cashbookTransactionDetails.length > 0) {
                $.each(data.cashbookTransactionDetails, function(key, val) {
                    addExpLedgerStaff(val);
                    // $('#expense-ledger-amount').prop('disabled', true);
                    $('#add-exp-ledger-staff-details').removeClass('hide');
                    $('#hide-exp-ledger-staff-detail').removeClass('hide');
                    $('#show-exp-ledger-staff-detail').addClass('hide');
                });
            }
            $('#exp-ledger-remarks').val(data.remarks);
        }
    }

    function closeExpenseLedger() {
        $('#expense-ledger-dialog').addClass('hide');
        $('#expense-ledger-dialog').dialog('destroy');
    }
    
    function addExpLedgerStaff(data) {
        var $tpl = $('#exp-ledger-staff-tpl .exp-ledger-staff-row').clone();
        $('#exp-ledger-staff-list').append($tpl);
        
        var branchstaffdata = [];
        $.each(branchStaff || [], function (i, row) {
            var branch = [];
            branch.id = row.code;
            branch.text = row.name;
            branch.aliasCode = row.aliasCode;
            branchstaffdata.push(branch);
        });

        $tpl.find('.expense-ledeger-staff-name').select2({
            data: { results: branchstaffdata },
            placeholder: 'Select Staff Name',
            formatResult: formatResult,
            formatSelection: formatResult,
            matcher: matcher
        });

        // $tpl.find('.expense-staff-name').select2();
        // $tpl.find('.expense-ledeger-staff-amount').val(0);
        
        if (_isdefined(data)) {
            $tpl.find('.expense-ledeger-staff-name').val(data.organizationContact.code).trigger('change');
            $tpl.find('.expense-ledeger-staff-amount').val(data.amount);
        }
    }

    function removeExpLedgerStaff(ele) {
        if($('#exp-ledger-staff-table tbody tr:not([data-deleted=1])').length > 1){
            $(ele).closest('tr').attr('data-deleted', 1).hide();
        }
        calculateExpLedgerAmount();
    }

    function showExpLedgerStaff() {
        $('#exp-ledger-staff-list').html('');

        $('#hide-exp-ledger-staff-detail').removeClass('hide');
        $('#show-exp-ledger-staff-detail').addClass('hide');
        $('#add-exp-ledger-staff-details').removeClass('hide');
        $('#expense-ledeger-amount').prop('disabled', true);
    }

    function hideExpLedgerStaff() {
        $('#exp-ledger-staff-list').html('');
        $('#hide-exp-ledger-staff-detail').addClass('hide');
        $('#show-exp-ledger-staff-detail').removeClass('hide');
        $('#add-exp-ledger-staff-details').addClass('hide');
        $('#expense-ledeger-amount').prop('disabled', false);
    }

    function calculateExpLedgerAmount() {
        var totalAmount = 0;
        $('#exp-ledger-staff-list .exp-ledger-staff-row:not([data-deleted=1])').each(function() {
            totalAmount += parseFloat($(this).find('.expense-ledeger-staff-amount').val());
        });
        $('#expense-ledger-amount').val(totalAmount);
    }

    function saveExpenseLedger() {
        $('.inp_error').removeClass('inp_error');
        var err = 0;

        var data = {};
        data.code = $('#expense-ledger-hid-code').val();

        data.cashbookCategory = {};
        data.cashbookCategory.code = $('input[name=expense-ledger-cashbook-category]:checked').val();

        if (data.cashbookCategory.code == 'VEH') {
            data.referenceCode = $('#expense-ledger-vehicle').val();
            if (data.referenceCode == '') {
                $('#expense-ledger-vehicle').addClass('inp_error');
                err++;
            }
        } else if (data.cashbookCategory.code == 'BRN') {
            data.referenceCode = $('#expense-ledger-branch').val();
            if (data.referenceCode == '') {
                $('#expense-ledger-branch').addClass('inp_error');
                err++;
            }
        }
        data.transactionType = 'Dr';

        if ($('#expense-ledger-contact-category').val() == '') {
            $('#expense-ledger-contact-category').addClass('inp_error');
            err++;
        }

        data.cashbookVendor = {};
        data.cashbookVendor.code = $('#expense-ledger-contact').val();
        if (data.cashbookVendor.code == '') {
            $('#expense-ledger-contact').addClass('inp_error');
            err++;
        }

        data.cashbookTransactionDetails = [];
        if (!$('#add-exp-ledger-staff-details').hasClass('hide')) {
            if ($('#exp-ledger-staff-list .exp-ledger-staff-row:not([data-deleted=1])').length == 0) {
                $('#expense-ledger-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#expense-ledger-action-state').html('Please add atleast one staff income / expense !!');
                $('#expense-ledger-action-state').show();
                return false;
            }

            var staffNames = [];
            $('#exp-ledger-staff-list .exp-ledger-staff-row').each(function() {
                var cashbookTransaction = {};
                cashbookTransaction.activeFlag = ($(this).data('deleted') == 1) ? 0 : 1;

                cashbookTransaction.organizationContact = {};
                var branchStaffName = $(this).find('input.expense-ledeger-staff-name').val();
                cashbookTransaction.organizationContact.code = branchStaffName;

                cashbookTransaction.amount = $(this).find('.expense-ledeger-staff-amount').val();
                data.cashbookTransactionDetails.push(cashbookTransaction);

                if (branchStaffName == '') {
                    $(this).find('.expense-ledeger-staff-name').addClass('inp_error');
                    err++;
                }

                if (cashbookTransaction.amount == '') {
                    $(this).find('.expense-ledeger-staff-amount').addClass('inp_error');
                    err++;
                }

                if (branchStaffName != '' && $.inArray(branchStaffName, staffNames) != -1) {
                    $(this).find('.expense-ledeger-staff-name').addClass('inp_error');
                    err++;
                }
                staffNames.push(branchStaffName);
            });
        }

        data.amount = $('#expense-ledger-amount').val();
        if ((data.amount == '' || isNaN(data.amount))) {
            $('#expense-ledger-amount').addClass('inp_error');
            err++;
        }

        data.transactionMode = {};
        data.transactionMode.code = $('#expense-ledger-txn-mode').val();
        if (data.transactionMode.code == '') {
            $('#expense-ledger-txn-mode').addClass('inp_error');
            err++;
        }

        // transaction mode
        if (data.transactionMode.code == 'UPI') {
            data.bankDetails = {};
            data.bankDetails.code = $('#exp-ledger-bank-details').val();
            data.addAttr1 = $.trim($('#exp-ledger-upi-id').val());
            data.addAttr2 = $.trim($('#exp-ledger-upi-details').val());

            if (data.addAttr1 == '') {
                $('#exp-ledger-upi-id').addClass('inp_error');
                err++;
            }

            if ($('#exp-ledger-bank-details').val() == '') {
                $('#exp-ledger-bank-details').addClass('inp_error');
                err++;
            }

            if (data.addAttr2 == '') {
                $('#exp-ledger-upi-details').addClass('inp_error');
                err++;
            }
        } else if (data.transactionMode.code == 'NBK') {
            data.bankDetails = {};
            data.bankDetails.code = $('#exp-ledger-bank-nbk').val();
            data.addAttr1 = $.trim($('#exp-ledger-acc-hold-name').val());
            data.addAttr2 = $.trim($('#exp-ledger-bank-name').val());
            data.addAttr3 = $.trim($('#exp-ledger-nbk-details').val());

            if (data.addAttr1 == '') {
                $('#exp-ledger-acc-hold-name').addClass('inp_error');
                err++;
            }

            if (data.addAttr2 == '') {
                $('#exp-ledger-bank-name').addClass('inp_error');
                err++;
            }

            if ($('#exp-ledger-bank-nbk').val() == '') {
                $('#exp-ledger-bank-nbk').addClass('inp_error');
                err++;
            }

            if (data.addAttr3 == '') {
                $('#exp-ledger-nbk-details').addClass('inp_error');
                err++;
            }
        } else if (data.transactionMode.code == 'CHEQUE') {
            data.chequeDetails = {};
            data.chequeDetails.code = $('#cheque-chq-code').val();
            data.chequeDetails.activeFlag = 1;

            data.chequeDetails.organization = {};
            data.chequeDetails.organization.code = $('#logged-in-branch-code').val();

            data.chequeDetails.bankDetails = $.trim($('#exp-ledger-chq-bankname').val());

            data.chequeDetails.payerDetails = $.trim($('#exp-ledger-payer').val());

            data.chequeDetails.chequeDate = moment($('#exp-ledger-chq-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
            data.chequeDetails.chequeNo = $.trim($('#exp-ledger-chq-num').val());
            data.chequeDetails.bankCity = $.trim($('#exp-ledger-chq-city').val());

            data.chequeDetails.chequeStatus = {};
            data.chequeDetails.chequeStatus.code = 'NEW';

            data.chequeDetails.remarks = '';

            if (data.chequeDetails.payerDetails == '') {
                $('#exp-ledger-payer').addClass('inp_error');
                err++;
            }

            if ($('#exp-ledger-chq-date').val() == '') {
                $('#exp-ledger-chq-date').addClass('inp_error');
                err++;
            }

            if (data.chequeDetails.chequeNo == '') {
                $('#exp-ledger-chq-num').addClass('inp_error');
                err++;
            }

            if (data.chequeDetails.bankDetails == '') {
                $('#exp-ledger-chq-bankname').addClass('inp_error');
                err++;
            }

            if (data.chequeDetails.bankCity == '') {
                $('#exp-ledger-chq-city').addClass('inp_error');
                err++;
            }
        }

        data.user = {};
        data.user.code = '{$user_code}';

        data.receiptDate = moment($('#expense-ledger-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
        data.acknowledgeStatus = {};
        data.acknowledgeStatus.code = 'INIT';
        data.remarks = $('#exp-ledger-remarks').val();
        data.activeFlag = 1;

        data.cashbookEntryType = {};
        data.cashbookEntryType.code = 'EXLGR';
        data.tag = [];

        if ($('#expense-ledger-date').val() == '') {
            $('#expense-ledger-date').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#expense-ledger-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#expense-ledger-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#expense-ledger-action-state').show();
            return false;
        } else {
            $('#expense-ledger-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#expense-ledger-action-state').hide();
        }

        $('#form-bttons').hide();
        $('#expense-ledger-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#expense-ledger-action-state').html(loading_popup);
        $('#expense-ledger-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "payment/update-cb-expense",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#expense-ledger-action-state').removeClass('alert-danger');
                    $('#expense-ledger-action-state').addClass('alert-success');
                    $('#expense-ledger-action-state').html('Your request has been completed successfully');
        
                    window.setTimeout(function () {
                        $('#expense-ledger-action-state').hide();
                        expenseLedgerFileUpload.startUpload({
                            referenceCode: response.data.code, 
                            imageCategoryCode: 'EXLGR',
                            onComplete: function() {
                                closeExpenseLedger();
                                checkURL();
                            }
                        });
                        
                    }, 3000);
                } else {
                    $('#expense-ledger-action-state').addClass('alert-danger');
                    $('#expense-ledger-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        });
    }

    function updateExpenseLedgerStatus(code, status) {
        if (status == 'APRD') {
            var message = 'Do you want to approve this entry?';
        } else if (status == 'REJT') {
            var message = 'Do you want to reject this entry?';
        }
        if (confirm(message)) {
            var data = {};
            data.code = code;

            data.acknowledgeStatus = {};
            data.acknowledgeStatus.code = status;
            
            data.cashbookEntryType = {};
            data.cashbookEntryType.code = 'EXLGR';

            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });       
        
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "payment/update-expense-ledger-status",
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
                        getExpenseLedger();
                    }, 2000);
                }
            });    
        }
    }

    function addAdvanceDialog(code) {
        $('#add-adv-dialog').css('background', '#fff');
        $('#add-adv-dialog').removeClass('hide');
        $('#add-adv-dialog').dialog({
            autoOpen: true,
            height: 600,
            width: $(window).width() - 200,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
        $('.inp_error').removeClass('inp_error');
        $('#adv-amt-action-state').removeClass('alert-success, alert-danger').html('').hide();

        $('#adv-amt-code, #adv-amt-chq-code, #adv-amt-txn-amt, #adv-amt-tds-amt, #adv-amt-payer, #adv-amt-chq-date, #adv-amt-chq-num, #adv-amt-chq-city, #adv-amt-rcvd-date, #adv-amt-remarks, #adv-amt-upi-id, #adv-amt-upi-details, #adv-amt-bank-name, #adv-amt-acc-hold-name, #adv-amt-nbk-details').val('');
        $('#adv-amt-bank-details, #adv-amt-chq-branch, #adv-amt-chq-bank-details, #adv-amt-chq-bankname, #adv-amt-bank-nbk').val('').trigger('change');
        $('#adv-amt-driver').typeahead('val', '');
        $('#adv-amt-txn-mode').val('').trigger('change');

        $('.adv-amt-type[value=DVR]').prop('checked', true).trigger('change');
    }

    function saveAdvanceDialog() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        var data = {};
        data.code = $('#adv-amt-code').val();
        data.activeFlag = 1;

        data.receiptReferenceType = {};
        data.receiptReferenceType.code = $('.adv-amt-type:checked').val();
        data.transactionReceiptType = {};
        data.transactionReceiptType.code = "ADV"

        if (data.receiptReferenceType.code == 'DVR') {
            data.transactionAmount = $('#adv-amt-txn-amt').val();
            data.receiptReferenceType = {};
            data.receiptReferenceType.code = "DVR"
            data.driver = {};
            data.driver.code = $('#adv-amt-driver').val();

            if ($('#adv-amt-driver').val() == '') {
                $('#adv-amt-driver').addClass('inp_error');
                err++;
            }
        } else if (data.receiptReferenceType.code == 'USR') {
            data.transactionAmount = $('#adv-amt-txn-amt').val();
            data.receiptReferenceType = {};
            data.receiptReferenceType.code = "USR"
            data.user = {};
            data.user.code = $('#adv-amt-user').val();

            if ($('#adv-amt-user').val() == '') {
                $('#adv-amt-user').addClass('inp_error');
                err++;
            }
        } else if (data.receiptReferenceType.code == 'BSTF') {
            data.transactionAmount = $('#adv-amt-txn-amt').val();
            data.receiptReferenceType = {};
            data.receiptReferenceType.code = "BSTF"
            data.organizationContact = {};
            data.organizationContact.code = $('#adv-amt-branchStaff').val();

            if ($('#adv-amt-branch').val() == '') {
                $('#adv-amt-branch').addClass('inp_error');
                err++;
            }
        }

        data.transactionMode = {};
        data.transactionMode.code = $('#adv-amt-txn-mode').val();

        if (data.transactionMode.code == '') {
            $('#adv-amt-txn-mode').addClass('inp_error');
            err++;
        }

        // upi
        if (data.transactionMode.code == 'UPI') {
            data.bankDetails = {};
            data.bankDetails = $('#adv-amt-bank-details').val();
            data.addAttr1 = $.trim($('#adv-amt-upi-id').val());
            data.addAttr2 = $.trim($('#adv-amt-upi-details').val());

            if (data.addAttr1 == '') {
                $('#adv-amt-upi-id').addClass('inp_error');
                err++;
            }

            if ($('#adv-amt-bank-details').val() == '') {
                $('#adv-amt-bank-details').addClass('inp_error');
                err++;
            }

            if (data.addAttr2 == '') {
                $('#adv-amt-upi-details').addClass('inp_error');
                err++;
            }
        } else if (data.transactionMode.code == 'NBK') {
            data.bankDetails = {};
            data.bankDetails = $('#adv-amt-bank-nbk').val();
            data.addAttr1 = $.trim($('#adv-amt-acc-hold-name').val());
            data.addAttr2 = $.trim($('#adv-amt-bank-name').val());
            data.addAttr3 = $.trim($('#adv-amt-nbk-details').val());

            if (data.addAttr1 == '') {
                $('#adv-amt-acc-hold-name').addClass('inp_error');
                err++;
            }

            if (data.addAttr2 == '') {
                $('#adv-amt-bank-name').addClass('inp_error');
                err++;
            }

            if ($('#adv-amt-bank-nbk').val() == '') {
                $('#adv-amt-bank-nbk').addClass('inp_error');
                err++;
            }

            if (data.addAttr3 == '') {
                $('#adv-amt-nbk-details').addClass('inp_error');
                err++;
            }
        }

        // cheque
        if (data.transactionMode.code == 'CHEQUE') {
            data.chequeDetails = {};
            data.chequeDetails.code = $('#adv-amt-chq-code').val();
            data.chequeDetails.activeFlag = 1;

            data.chequeDetails.organization = {};
            // data.chequeDetails.organization.code = $('#adv-amt-chq-branch').val();
            data.chequeDetails.organization.code = $('#adv-amt-chq-branch-hid').val();

            // data.chequeDetails.namespaceBank = {};
            // data.chequeDetails.namespaceBank.code = $('#adv-amt-chq-bank-details').val();
            data.chequeDetails.bankDetails = $.trim($('#adv-amt-chq-bankname').val());

            data.chequeDetails.payerDetails = $.trim($('#adv-amt-payer').val());

            data.chequeDetails.chequeDate = moment($('#adv-amt-chq-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
            data.chequeDetails.chequeNo = $.trim($('#adv-amt-chq-num').val());
            data.chequeDetails.bankCity = $.trim($('#adv-amt-chq-city').val());

            data.chequeDetails.chequeStatus = {};
            data.chequeDetails.chequeStatus.code = 'NEW';

            data.chequeDetails.remarks = '';

            if (data.chequeDetails.payerDetails == '') {
                $('#adv-amt-payer').addClass('inp_error');
                err++;
            }

            if ($('#adv-amt-chq-date').val() == '') {
                $('#adv-amt-chq-date').addClass('inp_error');
                err++;
            }

            if (data.chequeDetails.chequeNo == '') {
                $('#adv-amt-chq-num').addClass('inp_error');
                err++;
            }

            if (data.chequeDetails.bankDetails == '') {
                $('#adv-amt-chq-bankname').addClass('inp_error');
                err++;
            }

            if (data.chequeDetails.bankCity == '') {
                $('#adv-amt-chq-city').addClass('inp_error');
                err++;
            }
        }

        data.cargoBookings = [];
        $('#adv-amt-lr-table .lr-check:checked').each(function() {
            var lrcode = $(this).val();
            data.cargoBookings.push({ code: lrcode});
        });

        data.paymentTransactions = [];
        $('#adv-amt-up-inv-table .inv-check:checked').each(function() {
            var invCode = $(this).val();
            data.paymentTransactions.push({ code: invCode})
        });

        data.amountReceivedDate = moment($('#adv-amt-rcvd-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');

        if ($('#adv-amt-rcvd-date').val() == '') {
            $('#adv-amt-rcvd-date').addClass('inp_error');
            err++;
        }
        
        if ($('#adv-amt-txn-amt').val() == '') {
                $('#adv-amt-txn-amt').addClass('inp_error');
                err++;
            }
        data.remarks = $('#adv-amt-remarks').val();

        if (err > 0) {
            $('#adv-amt-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#adv-amt-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#adv-amt-action-state').show();
            return false;
        }

        $('#adv-amt-action-state').removeClass('alert-success, alert-danger, hide');
        $('#adv-amt-action-state').html(loading_popup).show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'payment/update-transaction-receipt',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#adv-amt-action-state').removeClass('alert-danger');
                    $('#adv-amt-action-state').addClass('alert-success');
                    $('#adv-amt-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        closeAdvanceDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#adv-amt-action-state').addClass('alert-danger');
                    $('#adv-amt-action-state').html(response.errorDesc);
                }
            }
        });
    }

    function closeAdvanceDialog() {
        $('#add-adv-dialog').addClass('hide');
        $('#add-adv-dialog').dialog('destroy');
    }

    function printExpenseLedger() {
        data = {};
        data.fromDate = $('#expense-ledger-from').val();
        data.toDate = $('#expense-ledger-to').val();
        data.organizationCode = $('#expense-ledger-branch-filter').val();
        data.organizationReceiptCode = $('#expense-ledger-branch-receipt').val();
        data.entryTypeCode = 'EXLGR';
        data.summaryPrint = 1;
        data.print = '0'

        $.ajax({
            type: 'POST',
            url: 'payment/get-expense-ledger-list', // Replace 'your_php_script.php' with the path to your PHP script
            data: data,
            success: function(response) {
            // Create a hidden iframe and set its content to the response
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
        },
        error: function(xhr, status, error) {
            // Handle errors here
            console.error(error); // Log the error to the console
        }
        });
    }


    function getAdvanceReceipt() {
        $('#adv-amt-list').html('');
        var data = {};
        data.fromDate = $('#adv-amt-from-date').val();
        data.toDate = $('#adv-amt-to-date').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if (data.fromDate == '') {
            $('#adv-amt-from-date').addClass('inp_error');
            err++;
        }

        if (data.toDate == '') {
            $('#adv-amt-to-date').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#payment-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#payment-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#payment-action-state').show();
            return false;
        }

        $('#payment-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#payment-action-state').html('').hide();

        $('#adv-amt-list-container').removeClass('hide');
        $('#adv-amt-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'payment/advance-payment-list',
            data: data,
            success: function (response) {
                $('#adv-amt-list').html(response);
            }
        });
    }
</script>