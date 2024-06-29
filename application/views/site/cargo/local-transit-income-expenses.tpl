<div class="clearfix"><br>
    <div class="col-md-7">
        <div class="table-responsive" style="max-height: 250px;overflow: auto;" id="hre-adv-list">
            <table class="table table-bordered table-hover" id="expenses-table">
                <thead class="sticky-row-top">
                    <tr class="bold">
                        <th>Category</th>
                        <th>Type </th>
                        <th>Payment Mode </th>
                        <th>Amount </th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=array_reverse($expensesData)}
                        {if $row->cashbookType->code == 'HIRING' || $row->cashbookType->code == 'ADVANCE'}
                            <tr>
                                <td align="left">
                                    {if $row->cashbookType->transactionType == 'Cr'}
                                        <span class='label label-sm label-primary'>Income</span>
                                    {elseif $row->cashbookType->transactionType == 'Dr'}
                                        <span class='label label-sm label-danger'>Expense</span>  
                                    {else}
                                        -                          
                                    {/if}
                                </td>
                                <td align="left">{$row->cashbookType->name}</td>
                                <td align="left">
                                    {$row->transactionMode->name}

                                    {$transactionModeDetails = ''}
                                    {if $row->transactionMode->code == 'UPI'}
                                        {if isNotNull($row->bankDetails->name)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Name : '|cat:$row->bankDetails->name|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->bankDetails->accountNumber)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Account Number : '|cat:$row->bankDetails->accountNumber|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->addAttr1)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'UPI : '|cat:($row->addAttr1)|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->addAttr2)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Ref# : '|cat:$row->addAttr2|cat:'<br>'}
                                        {/if}
                                    {/if}

                                    {if $row->transactionMode->code == 'NBK'}
                                        {if isNotNull($row->bankDetails->name)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Name : '|cat:$row->bankDetails->name|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->bankDetails->accountNumber)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Account Number : '|cat:$row->bankDetails->accountNumber|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->addAttr1)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Account Holder Name : '|cat:($row->addAttr1|inr_format)|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->addAttr2)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Bank Name : '|cat:$row->addAttr2|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->addAttr3)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Ref# : '|cat:$row->addAttr3|cat:'<br>'}
                                        {/if}
                                    {/if}

                                    {if $row->transactionMode->code == 'CHEQUE'}
                                        {if isNotNull($row->chequeDetails->payerDetails)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Payer : '|cat:$row->chequeDetails->payerDetails|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->chequeDetails->chequeNo)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Cheque Number : '|cat:$row->chequeDetails->chequeNo|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->chequeDetails->chequeDate)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Cheque Date : '|cat:($row->chequeDetails->chequeDate|inr_format)|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->chequeDetails->bankCity)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'City : '|cat:$row->chequeDetails->bankCity|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->chequeDetails->bankDetails)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Bank Name : '|cat:$row->chequeDetails->bankDetails|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->chequeDetails->remarks)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Remarks : '|cat:$row->chequeDetails->remarks|cat:'<br>'}
                                        {/if}
                                    {/if}

                                    {if isNotNull($transactionModeDetails)}
                                        &nbsp;<span data-toggle="tooltip" data-placement="top" title="{$transactionModeDetails}"><i class="fa fa-info-circle"></i></span>
                                    {/if}
                                </td>
                                <td align="left">{$row->amount|default:'-'}</td>
                                <td align="right">
                                    <span class="pull-left" data-toggle="tooltip" data-placement="top" title="{$row->user->name}<br/>{$row->transactionAt|date_format:$ns_datetime_format}"><i class="fa fa-info-circle"></i></span>
                                    <div class="btn-group btn-group-xs">
                                        <a class="delete pTip_top btn btn-default btn-sm" title="Delete" href="javascript:;" onclick="deleteExpense('{$row->code}')">
                                            <i class="fa fa-trash-o fa-lg"></i>
                                        </a>&nbsp;
                                        <a href="javascript:;" class="btn btn-default btn-sm" title="Edit" onclick='editExpense("{$row->code}")'><i class="fa fa-pencil igreen"></i> Edit</a>
                                    </div>
                                </td>
                            </tr>
                        {/if}
                    {foreachelse}
                        <tr>
                            <td colspan="5" align="center">No Records Found!</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        <div class="table-responsive" style="max-height: 250px;overflow: auto;" id="income-expense-list">
            <table class="table table-bordered table-hover" id="expenses-table">
                <thead class="sticky-row-top">
                    <tr class="bold">
                        <th>Category</th>
                        <th>Income / Expense Type </th>
                        <th>Payment Mode </th>
                        {* <th>Vendor/receiver Inc. </th> *}
                        <th>Inc. Amount </th>
                        <th>Exp. Amount</th>
                        {* <th>Remarks</th> *}
                        {* <th>Att.</th> *}
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$expensesData}
                        {if $row->cashbookType->code != 'HIRING' && $row->cashbookType->code != 'ADVANCE'}
                            <tr>
                                <td align="left">
                                    {if $row->cashbookType->transactionType == 'Cr'}
                                        <span class='label label-sm label-primary'>Income</span>
                                    {elseif $row->cashbookType->transactionType == 'Dr'}
                                        <span class='label label-sm label-danger'>Expense</span>
                                    {else}
                                        -
                                    {/if}
                                </td>
                                <td align="left">
                                    {if $row->cashbookType->code == 'NA'}
                                        {$row->paymentByContact->name}
                                    {else}
                                        {$row->cashbookType->name}
                                    {/if}
                                </td>
                                <td align="left">
                                    {$row->transactionMode->name}
                                    {$transactionModeDetails = ''}
                                    {if $row->transactionMode->code == 'UPI'}
                                        {if isNotNull($row->bankDetails->name)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Name : '|cat:$row->bankDetails->name|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->bankDetails->accountNumber)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Account Number : '|cat:$row->bankDetails->accountNumber|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->addAttr1)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'UPI : '|cat:($row->addAttr1)|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->addAttr2)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Ref# : '|cat:$row->addAttr2|cat:'<br>'}
                                        {/if}
                                    {/if}

                                    {if $row->transactionMode->code == 'NBK'}
                                        {if isNotNull($row->bankDetails->name)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Name : '|cat:$row->bankDetails->name|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->bankDetails->accountNumber)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Account Number : '|cat:$row->bankDetails->accountNumber|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->addAttr1)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Account Holder Name : '|cat:($row->addAttr1|inr_format)|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->addAttr2)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Bank Name : '|cat:$row->addAttr2|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->addAttr3)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Ref# : '|cat:$row->addAttr3|cat:'<br>'}
                                        {/if}
                                    {/if}

                                    {if $row->transactionMode->code == 'CHEQUE'}
                                        {if isNotNull($row->chequeDetails->payerDetails)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Payer : '|cat:$row->chequeDetails->payerDetails|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->chequeDetails->chequeNo)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Cheque Number : '|cat:$row->chequeDetails->chequeNo|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->chequeDetails->chequeDate)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Cheque Date : '|cat:($row->chequeDetails->chequeDate|inr_format)|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->chequeDetails->bankCity)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'City : '|cat:$row->chequeDetails->bankCity|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->chequeDetails->bankDetails)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Bank Name : '|cat:$row->chequeDetails->bankDetails|cat:'<br>'}
                                        {/if}
                                        {if isNotNull($row->chequeDetails->remarks)}
                                            {$transactionModeDetails = $transactionModeDetails|cat:'Remarks : '|cat:$row->chequeDetails->remarks|cat:'<br>'}
                                        {/if}
                                    {/if}

                                    {if isNotNull($transactionModeDetails)}
                                        &nbsp;<span data-toggle="tooltip" data-placement="top" title="{$transactionModeDetails}"><i class="fa fa-info-circle"></i></span>
                                    {/if}
                                </td>
                                {* <td align="left">{$row->cashbook_vendor_name|default:$row->cashbook_vendor_code|default:'-'}</td> *}
                                <td align="left">{if $row->cashbookType->transactionType == 'Cr'}{$row->amount|default:'-'}{else}-{/if}</td>
                                <td align="left">{if $row->cashbookType->transactionType == 'Dr'}{$row->amount|default:'-'}{elseif $row->cashbookType->code == 'NA'}{$row->amount|default:'-'}{else}-{/if}</td>
                                {* <td align="left"><span data-toggle="tooltip" data-placement="top" title="{$row->remarks}">{(($row->remarks) ? $row->remarks : '-')|truncate:35:'...'}</span></td> *}
                                {* <td align="center">
                                    {if $row->imageCount > 0}
                                        <div class="btn-group btn-group-xs">
                                            <button class="btn btn-default btn-sm" type="button"  onclick="showPRGallery('{$row->code}')"><i class="fa fa-picture-o" aria-hidden="true"></i></button>
                                        </div>
                                    {else}
                                        -
                                    {/if}
                                </td> *}
                                <td align="right">
                                    <span class="pull-left" data-toggle="tooltip" data-placement="top" title="{$row->user->name}<br/>{$row->transactionAt|date_format:$ns_datetime_format}"><i class="fa fa-info-circle"></i></span>
                                    <div class="btn-group btn-group-xs">
                                        <a class="delete pTip_top btn btn-default btn-sm" title="Delete" href="javascript:;" onclick="deleteExpense('{$row->code}')">
                                            <i class="fa fa-trash-o fa-lg"></i>
                                        </a>&nbsp;
                                        <a href="javascript:;" class="btn btn-default btn-sm" title="Edit" onclick='editExpense("{$row->code}")'><i class="fa fa-pencil igreen"></i> Edit</a>
                                    </div>
                                </td>
                            </tr>
                        {/if}
                    {foreachelse}
                        <tr>
                            <td colspan="6" align="center">No Records Found!</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        <div class="" style="width: 70%;">
            <form class="hide" id="expense-form" onsubmit="return false;">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-8">
                                    <label class="control-label" for="tph_name">Select Entry Category</label>
                                    <small>Select Income or Expense category</small>
                                </div>
                                <div class="col-md-4">
                                    <input type="checkbox" checked id="expense-type-cb" class="bsn_switch" data-on-text="Expense" data-off-text="Income" {if $cargo_setting->userAccountModel->code == 'TXRT'}disabled{/if}>
                                </div>
                            </div>
                        </div>
                    </div>
                    {* <div class="col-md-4">
                        <div class="form-group text-left hide" id="income-head-panel">
                            <label class="" for="seat-sch-date">Income Type</label>
                            <select id="expense-income" class="form-control">
                                <option value="">Select Income</option>
                                {foreach item=row from=$triphead} 
                                    {if $row->transactionType ==  'Cr'}
                                        {if preg_match("/(HIRING|ADVANCE)/i", $row->code) == 0}
                                            <option value="{$row->code}">{$row->name}</option>
                                        {/if}
                                    {/if}
                                {/foreach} 
                            </select>
                        </div>
                        <div class="form-group text-left" id="expense-head-panel">
                            <label class="" for="seat-sch-date">Expense Type</label>
                            <select id="expense-expense" class="form-control">
                                <option value="">Select Expense</option>
                                {foreach item=row from=$triphead} 
                                    {if $row->transactionType ==  'Dr'}
                                        {if preg_match("/(HIRING|ADVANCE)/i", $row->code) == 0}
                                            <option value="{$row->code}">{$row->name}</option>
                                        {/if}
                                    {/if}
                                {/foreach} 
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="" for="seat-sch-date">Payment Mode</label>
                            <select id="expense-mode" class="form-control">
                                <option value="">Select</option>
                                {foreach name=o key=k item=name from=$f_t_mode}
                                    <option value="{$k}">{$name}</option>
                                {/foreach} 
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group text-left">
                            <label class="">Amount</label>
                            <input type="number" placeholder="Amount" id="expense-amount" name="amount"  class="form-control no-spin" step="any">                    
                        </div>
                    </div> *}
                </div>
                
                <div class="{if $cargo_setting->userAccountModel->code == 'TXRT'}hide{/if}">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group text-left hide" id="income-head-panel">
                                <label class="" for="seat-sch-date">Income Type</label>
                                <select id="expense-income" class="form-control">
                                    <option value="">Select Income</option>
                                    {foreach item=row from=$triphead} 
                                        {if $row->transactionType ==  'Cr'}
                                            {if preg_match("/(HIRING|ADVANCE)/i", $row->code) == 0}
                                                <option value="{$row->code}">{$row->name}</option>
                                            {/if}
                                        {/if}
                                    {/foreach} 
                                </select>
                            </div>
                            <div class="form-group text-left" id="expense-head-panel">
                                <label class="" for="seat-sch-date">Expense Type</label>
                                <select id="expense-expense" class="form-control">
                                    <option value="">Select Expense</option>
                                    {foreach item=row from=$triphead} 
                                        {if $row->transactionType ==  'Dr'}
                                            {if preg_match("/(HIRING|ADVANCE)/i", $row->code) == 0}
                                                <option value="{$row->code}">{$row->name}</option>
                                            {/if}
                                        {/if}
                                    {/foreach} 
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="" for="seat-sch-date">Payment Mode</label>
                                <select id="expense-mode" class="form-control" onchange="setExpenseTransactionMode();">
                                    <option value="">Select</option>
                                    {foreach name=o key=k item=name from=$f_t_mode}
                                        <option value="{$k}">{$name}</option>
                                    {/foreach} 
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group text-left">
                                <label class="">Amount</label>
                                <input type="number" placeholder="Amount" id="expense-amount" name="amount"  class="form-control no-spin" step="any">                    
                            </div>
                        </div>

                        {* UPI *}
                        <div class="hide" id="expense-upi-mode-panel">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="expense-upi-orgbank">Organization Bank</label>
                                    <select class="form-control" id="expense-upi-orgbank">
                                        <option value="">Select Organization Bank</option>
                                        {foreach from=$bankdetail item=val}
                                            <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="expense-upi-id">UPI ID</label>
                                    <input type="text" class="form-control" id="expense-upi-id" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="expense-upi-details">Ref. #</label>
                                    <input type="text" class="form-control" id="expense-upi-details" placeholder="Ref. #" autocomplete="off">
                                </div>
                            </div>
                        </div>

                        {* Netbanking *}
                        <div class="hide" id="expense-netbanking-mode-panel">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="expense-netbanking-orgbank">Organization Bank</label>
                                    <select class="form-control" id="expense-netbanking-orgbank">
                                        <option value="">Select Organization Bank</option>
                                        {foreach from=$bankdetail item=val}
                                            <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="expense-netbanking-accholder">Account Holder Name</label>
                                    <input type="text" class="form-control" id="expense-netbanking-accholder" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group" id="expense-netbanking-bankname-div">
                                    <label for="expense-netbanking-bankname">Bank Name</label>
                                    <input type="text" class="form-control" id="expense-netbanking-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="expense-netbanking-details">Ref. #</label>
                                    <input type="text" class="form-control" id="expense-netbanking-details" placeholder="Ref. #" autocomplete="off">
                                </div>
                            </div>
                        </div>

                        {* Cheque *}
                        <div class="hide" id="expense-cheque-mode-panel">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="expense-cheque-payer">Payer Details</label>
                                    <input type="text" class="form-control" id="expense-cheque-payer" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="expense-cheque-no">Cheque No</label>
                                    <input type="text" class="form-control" id="expense-cheque-no" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="expense-cheque-date">Cheque Date</label>
                                    <input type="text" class="form-control" id="expense-cheque-date" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="expense-cheque-bankcity">Bank City</label>
                                    <input type="text" class="form-control" id="expense-cheque-bankcity" maxlength="90" placeholder="Bank City" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group" id="expense-cheque-bankname-div">
                                    <label for="expense-cheque-bankname">Bank Name</label>
                                    <input type="text" class="form-control" id="expense-cheque-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="expense-cheque-remarks">Remarks</label>
                                    <input type="text" class="form-control" placeholder="Remarks" id="expense-cheque-remarks" data-mask="englishonly"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <label class="">Payment By</label>
                            <select class="form-control" id="pay-by">
                                <option value="">Select</option>
                                {foreach from=$contact item=con key=key}
                                    <optgroup label="{$key}">
                                        {foreach from=$con item=val}
                                            <option value="{$val->code}">{$val->name}</option>
                                        {/foreach}
                                    </optgroup>
                                {/foreach}
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="">Payment To</label>
                            <select class="form-control" id="pay-to">
                                <option value="">Select</option>
                                {foreach from=$contact item=con key=key}
                                    <optgroup label="{$key}">
                                        {foreach from=$con item=val}
                                            <option value="{$val->code}">{$val->name}</option>
                                        {/foreach}
                                    </optgroup>
                                {/foreach}
                            </select>
                        </div>
                        <div class="col-md-4" id="expense-form-buttons">
                            <label>&nbsp;</label>
                            <button class="btn btn-light" type="button" onclick="hideOtherIncExp()">Close</button>
                        </div>
                    </div>
                </div>

                <div class="{if $cargo_setting->userAccountModel->code != 'TXRT'}hide{/if}">
                    <div class="row">
                        <div class="col-md-6">
                            <label class="">Expense Ledger</label>
                            <select class="form-control" id="seenu-expense-pay-con">
                                <option value="">Select</option>
                                {foreach from=$contact item=con key=key}
                                    {* <optgroup label="{$key}"> *}
                                        {foreach from=$con item=val}
                                            {if in_array('DRVPMT', $val->contactCategory->tag)}
                                                <option value="{$val->code}">{$val->name}</option>
                                            {/if}
                                        {/foreach}
                                    {* </optgroup> *}
                                {/foreach}
                            </select>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="" for="seat-sch-date">Payment Mode</label>
                                <select id="seenu-expense-mode" class="form-control" onchange="setSeenuExpenseTransactionMode();">
                                    <option value="">Select</option>
                                    {foreach name=o key=k item=name from=$f_t_mode}
                                        <option value="{$k}">{$name}</option>
                                    {/foreach} 
                                </select>
                            </div>
                        </div>

                        {* UPI *}
                        <div class="hide" id="seenu-expense-upi-mode-panel">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="seenu-expense-upi-orgbank">Organization Bank</label>
                                    <select class="form-control" id="seenu-expense-upi-orgbank">
                                        <option value="">Select Organization Bank</option>
                                        {foreach from=$bankdetail item=val}
                                            <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="seenu-expense-upi-id">UPI ID</label>
                                    <input type="text" class="form-control" id="seenu-expense-upi-id" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="seenu-expense-upi-details">Ref. #</label>
                                    <input type="text" class="form-control" id="seenu-expense-upi-details" placeholder="Ref. #" autocomplete="off">
                                </div>
                            </div>
                        </div>

                        {* Netbanking *}
                        <div class="hide" id="seenu-expense-netbanking-mode-panel">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="seenu-expense-netbanking-orgbank">Organization Bank</label>
                                    <select class="form-control" id="seenu-expense-netbanking-orgbank">
                                        <option value="">Select Organization Bank</option>
                                        {foreach from=$bankdetail item=val}
                                            <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="seenu-expense-netbanking-accholder">Account Holder Name</label>
                                    <input type="text" class="form-control" id="seenu-expense-netbanking-accholder" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group" id="seenu-expense-netbanking-bankname-div">
                                    <label for="seenu-expense-netbanking-bankname">Bank Name</label>
                                    <input type="text" class="form-control" id="seenu-expense-netbanking-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="seenu-expense-netbanking-details">Ref. #</label>
                                    <input type="text" class="form-control" id="seenu-expense-netbanking-details" placeholder="Ref. #" autocomplete="off">
                                </div>
                            </div>
                        </div>

                        {* Cheque *}
                        <div class="hide" id="seenu-expense-cheque-mode-panel">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="seenu-expense-cheque-payer">Payer Details</label>
                                    <input type="text" class="form-control" id="seenu-expense-cheque-payer" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="seenu-expense-cheque-no">Cheque No</label>
                                    <input type="text" class="form-control" id="seenu-expense-cheque-no" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="seenu-expense-cheque-date">Cheque Date</label>
                                    <input type="text" class="form-control" id="seenu-expense-cheque-date" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="seenu-expense-cheque-bankcity">Bank City</label>
                                    <input type="text" class="form-control" id="seenu-expense-cheque-bankcity" maxlength="90" placeholder="Bank City" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group" id="seenu-expense-cheque-bankname-div">
                                    <label for="seenu-expense-cheque-bankname">Bank Name</label>
                                    <input type="text" class="form-control" id="seenu-expense-cheque-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="seenu-expense-cheque-remarks">Remarks</label>
                                    <input type="text" class="form-control" placeholder="Remarks" id="seenu-expense-cheque-remarks" data-mask="englishonly"/>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group text-left">
                                <label class="">Amount</label>
                                <input type="number" placeholder="Amount" id="seenu-expense-amount" name="amount"  class="form-control no-spin" step="any">                    
                            </div>
                        </div>
                        
                        <div class="col-md-6" id="seenu-expense-form-buttons">
                            <label>&nbsp;</label>
                            <button class="btn btn-light" type="button" onclick="hideOtherIncExp()">Close</button>
                        </div>
                    </div>
                </div>
                {* <div class="row">
                    <div class="col-md-4">
                        <label class="">Payment By</label>
                        <select class="form-control" id="pay-by">
                            <option value="">Select</option>
                            {foreach from=$contact item=con key=key}
                                <optgroup label="{$key}">
                                    {foreach from=$con item=val}
                                        <option value="{$val->code}">{$val->name}</option>
                                    {/foreach}
                                </optgroup>
                            {/foreach}
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="">Payment To</label>
                        <select class="form-control" id="pay-to">
                            <option value="">Select</option>
                            {foreach from=$contact item=con key=key}
                                <optgroup label="{$key}">
                                    {foreach from=$con item=val}
                                        <option value="{$val->code}">{$val->name}</option>
                                    {/foreach}
                                </optgroup>
                            {/foreach}
                        </select>
                    </div>
                    <div class="col-md-4" id="expense-form-buttons">
                        <label>&nbsp;</label>
                        <button class="btn btn-light" type="button" onclick="hideOtherIncExp()">Close</button>
                    </div>
                </div> *}
            </form>
        </div>
    </div>
    <div class="col-md-5 b_l">
        <form id="hire-adv-form" onsubmit="return false;">
            {if ($expensesData|count > 0) && ($namespace == 'seenutransports')}
                <button class="btn btn-success btn-sm pull-right" type="button" onclick="printHireChallan('{$transitCode}', '{$ogplType}')">Print</button>
            {/if}
            {* hire *}
            <div class="row">
                <div class="col-md-12 {if !$cashbookType['HIRING'] || ($cargo_setting->userAccountModel->code == 'TXRT' && $vehicles->ownershipType->code != 'HIRE')}hide{/if}" id="hire-view">
                    <div class="form-group" style="border-bottom: 1px solid #ced4da;padding-bottom: 10px;">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label" for="">Hiring Amount</label>
                                    <div id="hire-view-amt">{$cashbookType['HIRING']->amount}</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="">Payment Mode</label>
                                    <div id="hire-view-pay-mode">{$cashbookType['HIRING']->transactionMode->name}</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="">Contact</label>
                                    <div id="hire-view-contact">{$cashbookType['HIRING']->paymentToContact->name}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 {if $cashbookType['HIRING'] || ($cargo_setting->userAccountModel->code == 'TXRT' && $vehicles->ownershipType->code != 'HIRE')}hide{/if}" id="hire-inp">
                    <div class="form-group" style="border-bottom: 1px solid #ced4da;padding-bottom: 10px;">
                        <div class="row">
                            <div class="col-md-5">
                                <label class="control-label" for="">Hiring Amount</label>
                                <input type="number" class="form-control" id="hire-amt" placeholder="Amount" step="any">
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <label class="">Payment Mode</label>
                                    <select id="hire-mode" class="form-control" onchange="setHireTransactionMode();">
                                        <option value="">Select</option>
                                        {foreach name=o key=k item=name from=$f_t_mode}
                                            <option value="{$k}">{$name}</option>
                                        {/foreach} 
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6 hide">
                                <label class="">Payment By</label>
                                <select class="form-control" id="hire-pay-by">
                                    <option value="">Select</option>
                                    {foreach from=$contact item=con key=key}
                                        {foreach from=$con item=val}
                                            {if $val->contactCategory->code == 'BRCH'}
                                                <option value="{$val->code}">{$val->name}</option>
                                            {/if}
                                        {/foreach}
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="control-label" for="">&nbsp;</label>
                                <a href="javascript:;" class="btn btn-success btn-xs" id="hire-show-more">More</a>
                            </div>

                            {* UPI *}
                            <div class="hide" id="hire-upi-mode-panel">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="hire-upi-orgbank">Organization Bank</label>
                                        <select class="form-control" id="hire-upi-orgbank">
                                            <option value="">Select Organization Bank</option>
                                            {foreach from=$bankdetail item=val}
                                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="hire-upi-id">UPI ID</label>
                                        <input type="text" class="form-control" id="hire-upi-id" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="hire-upi-details">Ref. #</label>
                                        <input type="text" class="form-control" id="hire-upi-details" placeholder="Ref. #" autocomplete="off">
                                    </div>
                                </div>
                            </div>

                            {* Netbanking *}
                            <div class="hide" id="hire-netbanking-mode-panel">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="hire-netbanking-orgbank">Organization Bank</label>
                                        <select class="form-control" id="hire-netbanking-orgbank">
                                            <option value="">Select Organization Bank</option>
                                            {foreach from=$bankdetail item=val}
                                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="hire-netbanking-accholder">Account Holder Name</label>
                                        <input type="text" class="form-control" id="hire-netbanking-accholder" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group" id="hire-netbanking-bankname-div">
                                        <label for="hire-netbanking-bankname">Bank Name</label>
                                        <input type="text" class="form-control" id="hire-netbanking-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="hire-netbanking-details">Ref. #</label>
                                        <input type="text" class="form-control" id="hire-netbanking-details" placeholder="Ref. #" autocomplete="off">
                                    </div>
                                </div>
                            </div>

                            {* Cheque *}
                            <div class="hide" id="hire-cheque-mode-panel">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="hire-cheque-payer">Payer Details</label>
                                        <input type="text" class="form-control" id="hire-cheque-payer" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="hire-cheque-no">Cheque No</label>
                                        <input type="text" class="form-control" id="hire-cheque-no" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="hire-cheque-date">Cheque Date</label>
                                        <input type="text" class="form-control" id="hire-cheque-date" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="hire-cheque-bankcity">Bank City</label>
                                        <input type="text" class="form-control" id="hire-cheque-bankcity" maxlength="90" placeholder="Bank City" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group" id="hire-cheque-bankname-div">
                                        <label for="hire-cheque-bankname">Bank Name</label>
                                        <input type="text" class="form-control" id="hire-cheque-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="hire-cheque-remarks">Remarks</label>
                                        <input type="text" class="form-control" placeholder="Remarks" id="hire-cheque-remarks" data-mask="englishonly"/>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-5 hide" id="hire-contact">
                                <label class="">Contact</label>
                                <select class="form-control" id="hire-pay-to">
                                    <option value="">Select</option>
                                    {foreach from=$contact item=con key=key}
                                        {foreach from=$con item=val}
                                            {if $val->contactCategory->code == 'TRANS'}
                                                <option value="{$val->code}">{$val->name}</option>
                                            {/if}
                                        {/foreach}
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                {* advance *}
                <div class="col-md-12 {if !$cashbookType['ADVANCE'] || ($cargo_setting->userAccountModel->code == 'TXRT' && in_array($cargoActivityType, ['OTFD', 'INTRNT']) && $vehicles->ownershipType->code == 'OWN')}hide{/if}" id="advance-view">
                    <div class="form-group" style="border-bottom: 1px solid #ced4da;padding-bottom: 10px;">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="control-label" for="">Advance Amount</label>
                                    <div id="adv-view-amt">{$cashbookType['ADVANCE']->amount}</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="">Payment Mode</label>
                                    <div id="adv-view-pay-mode">{$cashbookType['ADVANCE']->transactionMode->name}</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="">Payment By</label>
                                    <div id="adv-view-pay-by">{$cashbookType['ADVANCE']->paymentByContact->name}</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="">Payment To</label>
                                    <div id="adv-view-pay-to">{$cashbookType['ADVANCE']->paymentToContact->name}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 {if $cashbookType['ADVANCE'] || ($cargo_setting->userAccountModel->code == 'TXRT' && in_array($cargoActivityType, ['OTFD', 'INTRNT']) && $vehicles->ownershipType->code == 'OWN')}hide{/if}" id="advance-inp">
                    <div class="form-group" style="border-bottom: 1px solid #ced4da;padding-bottom: 10px;">
                        <div class="row">
                            <div class="col-md-5">
                                <label class="control-label" for="">Advance Amount</label>
                                <input type="number" class="form-control" id="adv-amt" placeholder="Amount" step="any">
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <label class="" for="">Payment Mode</label>
                                    <select id="adv-mode" class="form-control" onchange="setAdvanceTransactionMode();">
                                        <option value="">Select</option>
                                        {foreach name=o key=k item=name from=$f_t_mode}
                                            <option value="{$k}">{$name}</option>
                                        {/foreach} 
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <label class="control-label" for="">&nbsp;</label>
                                <a href="javascript:;" class="btn btn-success btn-xs" id="advance-show-more">More</a>
                            </div>

                            {* UPI *}
                            <div class="hide" id="adv-upi-mode-panel">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="adv-upi-orgbank">Organization Bank</label>
                                        <select class="form-control" id="adv-upi-orgbank">
                                            <option value="">Select Organization Bank</option>
                                            {foreach from=$bankdetail item=val}
                                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="adv-upi-id">UPI ID</label>
                                        <input type="text" class="form-control" id="adv-upi-id" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="adv-upi-details">Ref. #</label>
                                        <input type="text" class="form-control" id="adv-upi-details" placeholder="Ref. #" autocomplete="off">
                                    </div>
                                </div>
                            </div>

                            {* Netbanking *}
                            <div class="hide" id="adv-netbanking-mode-panel">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="adv-netbanking-orgbank">Organization Bank</label>
                                        <select class="form-control" id="adv-netbanking-orgbank">
                                            <option value="">Select Organization Bank</option>
                                            {foreach from=$bankdetail item=val}
                                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="adv-netbanking-accholder">Account Holder Name</label>
                                        <input type="text" class="form-control" id="adv-netbanking-accholder" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group" id="adv-netbanking-bankname-div">
                                        <label for="adv-netbanking-bankname">Bank Name</label>
                                        <input type="text" class="form-control" id="adv-netbanking-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="adv-netbanking-details">Ref. #</label>
                                        <input type="text" class="form-control" id="adv-netbanking-details" placeholder="Ref. #" autocomplete="off">
                                    </div>
                                </div>
                            </div>

                            {* Cheque *}
                            <div class="hide" id="adv-cheque-mode-panel">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="adv-cheque-payer">Payer Details</label>
                                        <input type="text" class="form-control" id="adv-cheque-payer" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="adv-cheque-no">Cheque No</label>
                                        <input type="text" class="form-control" id="adv-cheque-no" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="adv-cheque-date">Cheque Date</label>
                                        <input type="text" class="form-control" id="adv-cheque-date" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="adv-cheque-bankcity">Bank City</label>
                                        <input type="text" class="form-control" id="adv-cheque-bankcity" maxlength="90" placeholder="Bank City" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group" id="adv-cheque-bankname-div">
                                        <label for="adv-cheque-bankname">Bank Name</label>
                                        <input type="text" class="form-control" id="adv-cheque-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="adv-cheque-remarks">Remarks</label>
                                        <input type="text" class="form-control" placeholder="Remarks" id="adv-cheque-remarks" data-mask="englishonly"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-5 hide advance-pay-con">
                                <label class="">Payment By</label>
                                <select class="form-control" id="adv-pay-by">
                                    <option value="">Select</option>
                                    {foreach from=$contact item=con key=key}
                                        {foreach from=$con item=val}
                                            {if $val->contactCategory->code == 'BRCH'}
                                                <option value="{$val->code}">{$val->name}</option>
                                            {/if}
                                        {/foreach}
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-md-5 hide advance-pay-con">
                                <label class="">Payment To</label>
                                <select class="form-control" id="adv-pay-to">
                                    <option value="">Select</option>
                                    {foreach from=$contact item=con key=key}
                                        {foreach from=$con item=val}
                                            {if $val->contactCategory->code == 'TRANS'}
                                                <option value="{$val->code}">{$val->name}</option>
                                            {/if}
                                        {/foreach}
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group text-left">
                        <label class="">&nbsp;</label>
                        <a href="javascript:;" id="add-inc-exp" onclick="showOtherIncExp();">Add Other Income / Expense</a>                   
                    </div>
                </div>
                <div class="col-md-6" id="expense-form-buttons">
                    <label>&nbsp;</label>
                    <input type="hidden" id="expense-code">
                    <input type="hidden" id="hire-code">
                    <input type="hidden" id="advance-code">
                    <input type="hidden" id="hire-chq-code">
                    <input type="hidden" id="adv-chq-code">
                    <button class="btn btn-success" type="button" onclick="updateExpense()">Save</button>
                    <button class="btn btn-default" type="button" onclick="clearExpense()">Clear</button>
                </div>
                <div class="col-md-12">
                <br>
                    <div class="alert fl suc_cre" style="display: none;" id="expense-action-state"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <h4>Summary</h4>
                    <div class="table table-responsive">
                        <table class="table no-bordered">
                            <thead>
                                <tr>
                                    <th colspan="2" style="border: none;">Transporter</th>
                                    <th colspan="2" style="border: none;">Branch</th>
                                </tr>
                            </thead>
                            <tbody>
                                {assign var=hire_amt value=0}
                                {assign var=adv_amt value=0}
                                {foreach from=$cashbookType item=row key=key}
                                    {if $row->cashbookType->code == 'HIRING'}
                                        {assign var=hire_amt value=$hire_amt+$row->amount}
                                    {/if}
                                    {if $row->cashbookType->code == 'ADVANCE'}
                                        {assign var=adv_amt value=$adv_amt+$row->amount}
                                    {/if}
                                {/foreach}
                                <tr>
                                    <td width="50%" colspan="2" style="border: none;vertical-align: baseline;">
                                        <table class="table no-bordered">
                                            <tbody>
                                                {foreach from=$cashbookType item=row key=key}
                                                    {if $row->cashbookType->code == 'HIRING' || $row->cashbookType->code == 'ADVANCE'}
                                                        <tr>
                                                            <td style="border-bottom: 1px dashed #DDDDDD;">{$row->cashbookType->name}</td>
                                                            <td style="border-bottom: 1px dashed #DDDDDD;">{$row->amount|inr_format}</td>
                                                        </tr>
                                                    {/if}
                                                {/foreach}
                                                <tr>
                                                    <td>Total</td>
                                                    <td>{($adv_amt - $hire_amt)|inr_format}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td width="50%" colspan="2" style="border: none;vertical-align: baseline;">
                                        <table class="table no-bordered">
                                            <tbody>
                                                {foreach from=$cashbookType item=row key=key}
                                                    {if ($row->cashbookType->code != 'HIRING') && ($row->cashbookType->code != 'ADVANCE')}
                                                        {assign var=hire_amt value=$hire_amt+$row->amount}
                                                        <tr>
                                                            <td style="border-bottom: 1px dashed #DDDDDD;">{if $row->cashbookType->code == 'NA'}{$row->paymentByContact->name}{else}{$row->cashbookType->name}{/if}</td>
                                                            <td style="border-bottom: 1px dashed #DDDDDD;">{$row->amount|sigma:$brn_amt|inr_format}</td>
                                                        </tr>
                                                    {/if}
                                                {/foreach}
                                                <tr>
                                                    <td>Total</td>
                                                    <td>{$brn_amt|inr_format}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<style>
    .switch-id-expense-type-cb {
        width: 130px;
    }
</style>

<script>
    var expensesData = {$expensesData|json_encode};
    var vehicleOwnershipType = {$vehicles|json_encode};
    var transitCode = {$transitCode|json_encode};
    var bankNamesList = {$bank_names_list|json_encode};
    var cargo_setting = {$cargo_setting|json_encode};
    var cargoActivityType = {$cargoActivityType|json_encode};

    $('.bsn_switch').bootstrapSwitch();
    $('#expense-form select').select2();
    $('[data-toggle="tooltip"]').tooltip({
        html: true
    });

    $('#hire-pay-by').select2();
    $('#hire-pay-to').select2();
    $('#adv-pay-by').select2();
    $('#adv-pay-to').select2();

    // Expense
    $('#expense-cheque-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true
    });
    $('#expense-netbanking-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#expense-netbanking-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#expense-cheque-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#expense-cheque-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    // Seenu Expense
    $('#seenu-expense-cheque-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true
    });
    $('#seenu-expense-netbanking-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#seenu-expense-netbanking-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#seenu-expense-cheque-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#seenu-expense-cheque-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    // Hire
    $('#hire-cheque-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true
    });
    $('#hire-netbanking-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#hire-netbanking-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#hire-cheque-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#hire-cheque-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    // Advance
    $('#adv-cheque-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true
    });
    $('#adv-netbanking-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#adv-netbanking-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#adv-cheque-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#adv-cheque-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#expense-type-cb').on('switchChange.bootstrapSwitch', function () {
        $('#income-head-panel').addClass('hide');
        $('#expense-head-panel').addClass('hide');
        $('#expense-vendor-panel').addClass('hide');
        $('#expense-received-panel').addClass('hide');
        if (this.checked) {
            $('#expense-head-panel').removeClass('hide');
            $('#expense-vendor-panel').removeClass('hide');
        } else {
            $('#income-head-panel').removeClass('hide');
            $('#expense-received-panel').removeClass('hide');
        }
    })

    $('#hire-show-more').on('click', function(){
        if($('#hire-contact').hasClass('hide')){
            $('#hire-contact').removeClass('hide');
        }else{
            $('#hire-contact').addClass('hide');
        }
    })

    $('#advance-show-more').on('click', function(){
        if($('.advance-pay-con').hasClass('hide')){
            $('.advance-pay-con').removeClass('hide');
        }else{
            $('.advance-pay-con').addClass('hide');
        }
    })

    function showOtherIncExp() {
        $('#expense-code, #expense-amount, #seenu-expense-amount').val('');
        $('#expense-mode, #seenu-expense-mode').val('').trigger('change');
        $('#expense-type-cb').bootstrapSwitch('state', true);
        $('#expense-income, #expense-expense, #pay-by, #pay-to, #seenu-expense-pay-con').val('').trigger('change');

        if ($('#expense-form').hasClass('hide')){
            $('#expense-form').removeClass('hide');
            $('#income-expense-list').addClass('hide');
            $('#hre-adv-list').addClass('hide');
        }else{
            $('#expense-form').addClass('hide');
            $('#income-expense-list').removeClass('hide');
            $('#hre-adv-list').removeClass('hide');
        }
    }

    function hideOtherIncExp() {
        $('#expense-form').addClass('hide');
        $('#income-expense-list').removeClass('hide');
        $('#hre-adv-list').removeClass('hide');

        $('#expense-code, #expense-amount, #seenu-expense-amount').val('');
        $('#expense-mode, #seenu-expense-mode').val('').trigger('change');
        $('#expense-type-cb').bootstrapSwitch('state', true);
        $('#expense-income, #expense-expense, #pay-by, #pay-to, #seenu-expense-pay-con').val('').trigger('change');
    }

    function clearExpense() {
        $('#expense-code, #hire-code, #advance-code, #expense-amount, #seenu-expense-amount, #hire-amt, #adv-amt').val('');
        $('#expense-mode, #seenu-expense-mode, #hire-mode, #adv-mode').val('').trigger('change');
        $('#expense-type-cb').bootstrapSwitch('state', true);
        $('#expense-income, #expense-expense, #pay-by, #pay-to, #seenu-expense-pay-con, #hire-pay-by, #hire-pay-to, #adv-pay-by, #adv-pay-to').val('').trigger('change');
        
        $('#expense-action-state').removeClass('alert-danger alert-success').html('').hide();
        $('.inp_error').removeClass('inp_error');
    }

    function editExpense(code) {
        var data = _.find(expensesData, function (o) {
            return o.code === code;
        });

        if (!data) {
            return;
        }

        $('#expense-code, #hire-code, #advance-code, #expense-amount, #seenu-expense-amount, #hire-amt, #adv-amt').val('');
        $('#expense-mode, #seenu-expense-mode, #hire-mode, #adv-mode').val('').trigger('change');
        $('#expense-type-cb').bootstrapSwitch('state', true);
        $('#expense-income, #expense-expense, #pay-by, #pay-to, #seenu-expense-pay-con, #hire-pay-by, #hire-pay-to, #adv-pay-by, #adv-pay-to').val('').trigger('change');
        
        $('#expense-action-state').removeClass('alert-danger alert-success').html('');
        $('.inp_error').removeClass('inp_error');

        if (data.cashbookType.code == "HIRING") {
            if ($('#hire-inp').hasClass('hide')) {
                $('#hire-view').addClass('hide');
                $('#hire-inp').removeClass('hide');

                if($('#advance-view').hasClass('hide') && $('#adv-view-amt').text() != ''){
                    $('#advance-view').removeClass('hide');
                    $('#advance-inp').addClass('hide');
                }
                if($('#advance-view').hasClass('hide') && $('#adv-amt').val() != ''){
                    $('#advance-view').removeClass('hide');
                    $('#advance-inp').addClass('hide');
                }
            } else {
                $('#hire-view').removeClass('hide');
                $('#hire-inp').addClass('hide');
            }

            $('#hire-code').val(data.code);
            $('#hire-amt').val(data.amount);
            $('#hire-mode').val(data.transactionMode.code).trigger('change');
            //$('#hire-pay-by').val(data.paymentByContact.code).trigger('change');

            if (data.paymentToContact.code) {
                $('#hire-contact').removeClass('hide');
                $('#hire-pay-to').val(data.paymentToContact.code).trigger('change');
            }

            if (data.transactionMode.code == 'NBK') {
                if (isNotNull(data.bankDetails)) {
                    $('#hire-netbanking-orgbank').val(data.bankDetails.code).trigger('change');
                }
                $('#hire-netbanking-accholder').val(data.addAttr1).trigger('change');
                $('#hire-netbanking-bankname').val(data.addAttr2).trigger('change');
                $('#hire-netbanking-details').val(data.addAttr3).trigger('change');
            } else if (data.transactionMode.code == 'UPI') {
                if (isNotNull(data.bankDetails)) {
                    $('#hire-upi-orgbank').val(data.bankDetails.code).trigger('change');
                }
                $('#hire-upi-id').val(data.addAttr1).trigger('change');
                $('#hire-upi-details').val(data.addAttr2).trigger('change');
            } else if (data.transactionMode.code == 'CHEQUE') {
                if (isNotNull(data.chequeDetails)) {
                    $('#hire-cheque-payer').val(data.chequeDetails.payerDetails).trigger('change');
                    $('#hire-cheque-no').val(data.chequeDetails.chequeNo).trigger('change');
                    $('#hire-cheque-date').val(data.chequeDetails.chequeDate).trigger('change');
                    $('#hire-cheque-bankname').val(data.chequeDetails.bankDetails).trigger('change');
                    $('#hire-cheque-bankcity').val(data.chequeDetails.bankCity).trigger('change');
                    $('#hire-cheque-remarks').val(data.chequeDetails.remarks).trigger('change');
                }
            }
        } else if (data.cashbookType.code == "ADVANCE") {
            if ($('#advance-inp').hasClass('hide')) {
                $('#advance-view').addClass('hide');
                $('#advance-inp').removeClass('hide');

                if($('#hire-view').hasClass('hide') && $('#hire-view-amt').text() != ''){
                    $('#hire-view').removeClass('hide');
                    $('#hire-inp').addClass('hide');
                }
                
                if($('#hire-view').hasClass('hide')  && $('#hire-amt').val() != ''){
                    $('#hire-view').removeClass('hide');
                    $('#hire-inp').addClass('hide');
                }
            } else {
                $('#advance-view').removeClass('hide');
                $('#advance-inp').addClass('hide');
            }
            
            $('#advance-code').val(data.code);
            $('#adv-amt').val(data.amount);
            $('#adv-mode').val(data.transactionMode.code).trigger('change');

            if(data.paymentByContact.code || data.paymentToContact.code){
                $('.advance-pay-con').removeClass('hide');
                $('#adv-pay-by').val(data.paymentByContact.code).trigger('change');
                $('#adv-pay-to').val(data.paymentToContact.code).trigger('change');
            }

            if (data.transactionMode.code == 'NBK') {
                if (isNotNull(data.bankDetails)) {
                    $('#adv-netbanking-orgbank').val(data.bankDetails.code).trigger('change');
                }
                $('#adv-netbanking-accholder').val(data.addAttr1).trigger('change');
                $('#adv-netbanking-bankname').val(data.addAttr2).trigger('change');
                $('#adv-netbanking-details').val(data.addAttr3).trigger('change');
            } else if (data.transactionMode.code == 'UPI') {
                if (isNotNull(data.bankDetails)) {
                    $('#adv-upi-orgbank').val(data.bankDetails.code).trigger('change');
                }
                $('#adv-upi-id').val(data.addAttr1).trigger('change');
                $('#adv-upi-details').val(data.addAttr2).trigger('change');
            } else if (data.transactionMode.code == 'CHEQUE') {
                if (isNotNull(data.chequeDetails)) {
                    $('#adv-cheque-payer').val(data.chequeDetails.payerDetails).trigger('change');
                    $('#adv-cheque-no').val(data.chequeDetails.chequeNo).trigger('change');
                    $('#adv-cheque-date').val(data.chequeDetails.chequeDate).trigger('change');
                    $('#adv-cheque-bankname').val(data.chequeDetails.bankDetails).trigger('change');
                    $('#adv-cheque-bankcity').val(data.chequeDetails.bankCity).trigger('change');
                    $('#adv-cheque-remarks').val(data.chequeDetails.remarks).trigger('change');
                }
            }
        } else {
            $('#expense-form').removeClass('hide');
            $('#income-expense-list').addClass('hide');
            $('#hre-adv-list').addClass('hide');
            
            if($('#advance-view').hasClass('hide') && $('#adv-view-amt').text() != ''){
                $('#advance-view').removeClass('hide');
                $('#advance-inp').addClass('hide');
            }

            if($('#hire-view').hasClass('hide') && $('#hire-view-amt').text() != ''){
                $('#hire-view').removeClass('hide');
                $('#hire-inp').addClass('hide');
            }

            $('#expense-code').val(data.code);
            $('#expense-type-cb').bootstrapSwitch('state', data.cashbookType.transactionType === 'Dr');
            if (cargo_setting.userAccountModel.code == 'TXRT') {
                $('#seenu-expense-amount').val(data.amount);
                $('#seenu-expense-mode').val(data.transactionMode.code).trigger('change');
                $('#seenu-expense-pay-con').val(data.paymentByContact.code).trigger('change');

                if (data.transactionMode.code == 'NBK') {
                    if (isNotNull(data.bankDetails)) {
                        $('#seenu-expense-netbanking-orgbank').val(data.bankDetails.code).trigger('change');
                    }
                    $('#seenu-expense-netbanking-accholder').val(data.addAttr1).trigger('change');
                    $('#seenu-expense-netbanking-bankname').val(data.addAttr2).trigger('change');
                    $('#seenu-expense-netbanking-details').val(data.addAttr3).trigger('change');
                } else if (data.transactionMode.code == 'UPI') {
                    if (isNotNull(data.bankDetails)) {
                        $('#seenu-expense-upi-orgbank').val(data.bankDetails.code).trigger('change');
                    }
                    $('#seenu-expense-upi-id').val(data.addAttr1).trigger('change');
                    $('#seenu-expense-upi-details').val(data.addAttr2).trigger('change');
                } else if (data.transactionMode.code == 'CHEQUE') {
                    if (isNotNull(data.chequeDetails)) {
                        $('#seenu-expense-cheque-payer').val(data.chequeDetails.payerDetails).trigger('change');
                        $('#seenu-expense-cheque-no').val(data.chequeDetails.chequeNo).trigger('change');
                        $('#seenu-expense-cheque-date').val(data.chequeDetails.chequeDate).trigger('change');
                        $('#seenu-expense-cheque-bankname').val(data.chequeDetails.bankDetails).trigger('change');
                        $('#seenu-expense-cheque-bankcity').val(data.chequeDetails.bankCity).trigger('change');
                        $('#seenu-expense-cheque-remarks').val(data.chequeDetails.remarks).trigger('change');
                    }
                }
            } else {
                $('#expense-amount').val(data.amount);
                $('#expense-mode').val(data.transactionMode.code).trigger('change');

                if (data.cashbookType.transactionType == 'Cr') {
                    $('#expense-income').val(data.cashbookType.code).trigger('change');
                } else if (data.cashbookType.transactionType == 'Dr') {
                    $('#expense-expense').val(data.cashbookType.code).trigger('change');
                }
                
                $('#pay-by').val(data.paymentByContact.code).trigger('change');
                $('#pay-to').val(data.paymentToContact.code).trigger('change');
                
                if (data.transactionMode.code == 'NBK') {
                    if (isNotNull(data.bankDetails)) {
                        $('#expense-netbanking-orgbank').val(data.bankDetails.code).trigger('change');
                    }
                    $('#expense-netbanking-accholder').val(data.addAttr1).trigger('change');
                    $('#expense-netbanking-bankname').val(data.addAttr2).trigger('change');
                    $('#expense-netbanking-details').val(data.addAttr3).trigger('change');
                } else if (data.transactionMode.code == 'UPI') {
                    if (isNotNull(data.bankDetails)) {
                        $('#expense-upi-orgbank').val(data.bankDetails.code).trigger('change');
                    }
                    $('#expense-upi-id').val(data.addAttr1).trigger('change');
                    $('#expense-upi-details').val(data.addAttr2).trigger('change');
                } else if (data.transactionMode.code == 'CHEQUE') {
                    if (isNotNull(data.chequeDetails)) {
                        $('#expense-cheque-payer').val(data.chequeDetails.payerDetails).trigger('change');
                        $('#expense-cheque-no').val(data.chequeDetails.chequeNo).trigger('change');
                        $('#expense-cheque-date').val(data.chequeDetails.chequeDate).trigger('change');
                        $('#expense-cheque-bankname').val(data.chequeDetails.bankDetails).trigger('change');
                        $('#expense-cheque-bankcity').val(data.chequeDetails.bankCity).trigger('change');
                        $('#expense-cheque-remarks').val(data.chequeDetails.remarks).trigger('change');
                    }
                }
            }
        }
    }
    
    function updateExpense() {
        $('.inp_error').removeClass('inp_error');
        var transitData = getActiveTransitData();
        
        var data = {};
        var err = 0;
        
        data.ogpl = [];
        if($('#expense-amount').val() != '' && cargo_setting.userAccountModel.code != 'TXRT'){
            var incomeExpense = {};

            incomeExpense.code = $('#expense-code').val();
            incomeExpense.activeFlag = 1;

            incomeExpense.user = {};
            incomeExpense.user.code = '{$usr_login_id}';

            incomeExpense.transitCargo = {};
            incomeExpense.transitCargo.code = transitData.code;

            incomeExpense.transactionMode = {};
            incomeExpense.transactionMode.code = $('#expense-mode').val();

            incomeExpense.amount = Number($('#expense-amount').val());
            incomeExpense.remarks = $('#expense-remarks').val();
            incomeExpense.transactionType = $('#expense-type-cb').is(':checked') ? 'Dr' : 'Cr'

            incomeExpense.cashbookType = {};
            if (incomeExpense.transactionType == 'Cr') {
                incomeExpense.cashbookType.code = $('#expense-income').val();
            } else if (incomeExpense.transactionType == 'Dr') {
                incomeExpense.cashbookType.code = $('#expense-expense').val();
            }
            
            incomeExpense.paymentByContact = {};
            incomeExpense.paymentByContact.code = $('#pay-by').val();

            incomeExpense.paymentToContact = {};
            incomeExpense.paymentToContact.code = $('#pay-to').val();

            if (incomeExpense.transactionMode.code == 'UPI') {
                incomeExpense.bankDetails = {};
                incomeExpense.bankDetails.code = $('#expense-upi-orgbank').val();
                incomeExpense.addAttr1 = $.trim($('#expense-upi-id').val());
                incomeExpense.addAttr2 = $.trim($('#expense-upi-details').val());

                if (incomeExpense.addAttr1 == '') {
                    $('#expense-upi-id').addClass('inp_error');
                    err++;
                }

                if ($('#expense-upi-orgbank').val() == '') {
                    $('#expense-upi-orgbank').addClass('inp_error');
                    err++;
                }

                if (incomeExpense.addAttr2 == '') {
                    $('#expense-upi-details').addClass('inp_error');
                    err++;
                }
            } else if (incomeExpense.transactionMode.code == 'NBK') {
                incomeExpense.bankDetails = {};
                incomeExpense.bankDetails.code = $('#expense-netbanking-orgbank').val();
                incomeExpense.addAttr1 = $.trim($('#expense-netbanking-accholder').val());
                incomeExpense.addAttr2 = $.trim($('#expense-netbanking-bankname').val());
                incomeExpense.addAttr3 = $.trim($('#expense-netbanking-details').val());

                if (incomeExpense.addAttr1 == '') {
                    $('#expense-netbanking-accholder').addClass('inp_error');
                    err++;
                }

                if (incomeExpense.addAttr2 == '') {
                    $('#expense-netbanking-bankname').addClass('inp_error');
                    err++;
                }

                if ($('#expense-netbanking-orgbank').val() == '') {
                    $('#expense-netbanking-orgbank').addClass('inp_error');
                    err++;
                }

                if (incomeExpense.addAttr3 == '') {
                    $('#expense-netbanking-details').addClass('inp_error');
                    err++;
                }
            } else if (incomeExpense.transactionMode.code == 'CHEQUE') {
                incomeExpense.chequeDetails = {};
                incomeExpense.chequeDetails.code = $('#expense-chq-code').val();
                incomeExpense.chequeDetails.activeFlag = 1;

                incomeExpense.chequeDetails.organization = {};
                incomeExpense.chequeDetails.organization.code = '{$login_branch}';

                incomeExpense.chequeDetails.bankDetails = $.trim($('#expense-cheque-bankname').val());
                incomeExpense.chequeDetails.payerDetails = $.trim($('#expense-cheque-payer').val());

                incomeExpense.chequeDetails.chequeDate = moment($('#expense-cheque-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                incomeExpense.chequeDetails.chequeNo = $.trim($('#expense-cheque-no').val());
                incomeExpense.chequeDetails.bankCity = $.trim($('#expense-cheque-bankcity').val());

                incomeExpense.chequeDetails.chequeStatus = {};
                incomeExpense.chequeDetails.chequeStatus.code = 'NEW';

                incomeExpense.chequeDetails.remarks = $.trim($('#expense-cheque-remarks').val());

                if (incomeExpense.chequeDetails.payerDetails == '') {
                    $('#expense-cheque-payer').addClass('inp_error');
                    err++;
                }

                if ($('#expense-cheque-date').val() == '') {
                    $('#expense-cheque-date').addClass('inp_error');
                    err++;
                }

                if (incomeExpense.chequeDetails.chequeNo == '') {
                    $('#expense-cheque-no').addClass('inp_error');
                    err++;
                }

                if (incomeExpense.chequeDetails.bankDetails == '') {
                    $('#expense-cheque-bankname').addClass('inp_error');
                    err++;
                }

                if (incomeExpense.chequeDetails.bankCity == '') {
                    $('#expense-cheque-bankcity').addClass('inp_error');
                    err++;
                }
            }
            data.ogpl.push(incomeExpense);
        } else if ($('#seenu-expense-amount').val() != '' && cargo_setting.userAccountModel.code == 'TXRT') {
            var incomeExpense = {};

            incomeExpense.code = $('#expense-code').val();
            incomeExpense.activeFlag = 1;

            incomeExpense.user = {};
            incomeExpense.user.code = '{$usr_login_id}';

            incomeExpense.transitCargo = {};
            incomeExpense.transitCargo.code = transitData.code;

            incomeExpense.transactionMode = {};
            incomeExpense.transactionMode.code = $('#seenu-expense-mode').val();

            incomeExpense.amount = Number($('#seenu-expense-amount').val());
            // incomeExpense.remarks = $('#expense-remarks').val();
            incomeExpense.transactionType = $('#expense-type-cb').is(':checked') ? 'Dr' : 'Cr'

            incomeExpense.cashbookType = {};
            // if (incomeExpense.transactionType == 'Cr') {
                incomeExpense.cashbookType.code = 'NA';
            //     incomeExpense.cashbookType.code = $('#expense-income').val();
            // } else if (incomeExpense.transactionType == 'Dr') {
            //     incomeExpense.cashbookType.code = $('#expense-expense').val();
            // }
            
            incomeExpense.paymentByContact = {};
            incomeExpense.paymentByContact.code = $('#seenu-expense-pay-con').val();

            if (incomeExpense.transactionMode.code == 'UPI') {
                incomeExpense.bankDetails = {};
                incomeExpense.bankDetails.code = $('#seenu-expense-upi-orgbank').val();
                incomeExpense.addAttr1 = $.trim($('#seenu-expense-upi-id').val());
                incomeExpense.addAttr2 = $.trim($('#seenu-expense-upi-details').val());

                if (incomeExpense.addAttr1 == '') {
                    $('#seenu-expense-upi-id').addClass('inp_error');
                    err++;
                }

                if ($('#seenu-expense-upi-orgbank').val() == '') {
                    $('#seenu-expense-upi-orgbank').addClass('inp_error');
                    err++;
                }

                if (incomeExpense.addAttr2 == '') {
                    $('#seenu-expense-upi-details').addClass('inp_error');
                    err++;
                }
            } else if (incomeExpense.transactionMode.code == 'NBK') {
                incomeExpense.bankDetails = {};
                incomeExpense.bankDetails.code = $('#seenu-expense-netbanking-orgbank').val();
                incomeExpense.addAttr1 = $.trim($('#seenu-expense-netbanking-accholder').val());
                incomeExpense.addAttr2 = $.trim($('#seenu-expense-netbanking-bankname').val());
                incomeExpense.addAttr3 = $.trim($('#seenu-expense-netbanking-details').val());

                if (incomeExpense.addAttr1 == '') {
                    $('#seenu-expense-netbanking-accholder').addClass('inp_error');
                    err++;
                }

                if (incomeExpense.addAttr2 == '') {
                    $('#seenu-expense-netbanking-bankname').addClass('inp_error');
                    err++;
                }

                if ($('#seenu-expense-netbanking-orgbank').val() == '') {
                    $('#seenu-expense-netbanking-orgbank').addClass('inp_error');
                    err++;
                }

                if (incomeExpense.addAttr3 == '') {
                    $('#seenu-expense-netbanking-details').addClass('inp_error');
                    err++;
                }
            } else if (incomeExpense.transactionMode.code == 'CHEQUE') {
                incomeExpense.chequeDetails = {};
                incomeExpense.chequeDetails.code = $('#seenu-expense-chq-code').val();
                incomeExpense.chequeDetails.activeFlag = 1;

                incomeExpense.chequeDetails.organization = {};
                incomeExpense.chequeDetails.organization.code = '{$login_branch}';

                incomeExpense.chequeDetails.bankDetails = $.trim($('#seenu-expense-cheque-bankname').val());
                incomeExpense.chequeDetails.payerDetails = $.trim($('#seenu-expense-cheque-payer').val());

                incomeExpense.chequeDetails.chequeDate = moment($('#seenu-expense-cheque-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                incomeExpense.chequeDetails.chequeNo = $.trim($('#seenu-expense-cheque-no').val());
                incomeExpense.chequeDetails.bankCity = $.trim($('#seenu-expense-cheque-bankcity').val());

                incomeExpense.chequeDetails.chequeStatus = {};
                incomeExpense.chequeDetails.chequeStatus.code = 'NEW';

                incomeExpense.chequeDetails.remarks = $.trim($('#seenu-expense-cheque-remarks').val());

                if (incomeExpense.chequeDetails.payerDetails == '') {
                    $('#seenu-expense-cheque-payer').addClass('inp_error');
                    err++;
                }

                if ($('#seenu-expense-cheque-date').val() == '') {
                    $('#seenu-expense-cheque-date').addClass('inp_error');
                    err++;
                }

                if (incomeExpense.chequeDetails.chequeNo == '') {
                    $('#seenu-expense-cheque-no').addClass('inp_error');
                    err++;
                }

                if (incomeExpense.chequeDetails.bankDetails == '') {
                    $('#seenu-expense-cheque-bankname').addClass('inp_error');
                    err++;
                }

                if (incomeExpense.chequeDetails.bankCity == '') {
                    $('#seenu-expense-cheque-bankcity').addClass('inp_error');
                    err++;
                }
            }

            // incomeExpense.paymentToContact = {};
            // incomeExpense.paymentToContact.code = $('#pay-to').val();

            data.ogpl.push(incomeExpense);
        }

        if ($('#hire-amt').val() != '' || (cargo_setting.userAccountModel.code == 'TXRT' && $('#hire-amt').val() != '' && vehicleOwnershipType.ownershipType.code == 'HIRE')) {
            var hire = {};

            hire.code = $('#hire-code').val();
            hire.activeFlag = 1;

            hire.user = {};
            hire.user.code = '{$usr_login_id}';

            hire.transitCargo = {};
            hire.transitCargo.code = transitData.code;

            hire.transactionMode = {};
            hire.transactionMode.code = $('#hire-mode').val();

            hire.amount = Number($('#hire-amt').val());
            hire.remarks = '';

            hire.cashbookType = {};
            hire.cashbookType.code = 'HIRING';
            
            hire.paymentByContact = {};
            hire.paymentByContact.code = $('#hire-pay-by').val();

            hire.paymentToContact = {};
            hire.paymentToContact.code = $('#hire-pay-to').val();

            if (hire.transactionMode.code == 'UPI') {
                hire.bankDetails = {};
                hire.bankDetails.code = $('#hire-upi-orgbank').val();
                hire.addAttr1 = $.trim($('#hire-upi-id').val());
                hire.addAttr2 = $.trim($('#hire-upi-details').val());

                if (hire.addAttr1 == '') {
                    $('#hire-upi-id').addClass('inp_error');
                    err++;
                }

                if ($('#hire-upi-orgbank').val() == '') {
                    $('#hire-upi-orgbank').addClass('inp_error');
                    err++;
                }

                if (hire.addAttr2 == '') {
                    $('#hire-upi-details').addClass('inp_error');
                    err++;
                }
            } else if (hire.transactionMode.code == 'NBK') {
                hire.bankDetails = {};
                hire.bankDetails.code = $('#hire-netbanking-orgbank').val();
                hire.addAttr1 = $.trim($('#hire-netbanking-accholder').val());
                hire.addAttr2 = $.trim($('#hire-netbanking-bankname').val());
                hire.addAttr3 = $.trim($('#hire-netbanking-details').val());

                if (hire.addAttr1 == '') {
                    $('#hire-netbanking-accholder').addClass('inp_error');
                    err++;
                }

                if (hire.addAttr2 == '') {
                    $('#hire-netbanking-bankname').addClass('inp_error');
                    err++;
                }

                if ($('#hire-netbanking-orgbank').val() == '') {
                    $('#hire-netbanking-orgbank').addClass('inp_error');
                    err++;
                }

                if (hire.addAttr3 == '') {
                    $('#hire-netbanking-details').addClass('inp_error');
                    err++;
                }
            } else if (hire.transactionMode.code == 'CHEQUE') {
                hire.chequeDetails = {};
                hire.chequeDetails.code = $('#hire-chq-code').val();
                hire.chequeDetails.activeFlag = 1;

                hire.chequeDetails.organization = {};
                hire.chequeDetails.organization.code = '{$login_branch}';

                hire.chequeDetails.bankDetails = $.trim($('#hire-cheque-bankname').val());
                hire.chequeDetails.payerDetails = $.trim($('#hire-cheque-payer').val());

                hire.chequeDetails.chequeDate = moment($('#hire-cheque-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                hire.chequeDetails.chequeNo = $.trim($('#hire-cheque-no').val());
                hire.chequeDetails.bankCity = $.trim($('#hire-cheque-bankcity').val());

                hire.chequeDetails.chequeStatus = {};
                hire.chequeDetails.chequeStatus.code = 'NEW';

                hire.chequeDetails.remarks = $.trim($('#hire-cheque-remarks').val());

                if (hire.chequeDetails.payerDetails == '') {
                    $('#hire-cheque-payer').addClass('inp_error');
                    err++;
                }

                if ($('#hire-cheque-date').val() == '') {
                    $('#hire-cheque-date').addClass('inp_error');
                    err++;
                }

                if (hire.chequeDetails.chequeNo == '') {
                    $('#hire-cheque-no').addClass('inp_error');
                    err++;
                }

                if (hire.chequeDetails.bankDetails == '') {
                    $('#hire-cheque-bankname').addClass('inp_error');
                    err++;
                }

                if (hire.chequeDetails.bankCity == '') {
                    $('#hire-cheque-bankcity').addClass('inp_error');
                    err++;
                }
            }
            data.ogpl.push(hire);
        }

        if ($('#adv-amt').val() != '' || (cargo_setting.userAccountModel.code == 'TXRT' && $('#adv-amt').val() != '' && $.inArray(cargoActivityType, ['OTFD', 'INTRNT']) == -1 && vehicleOwnershipType.ownershipType.code != 'OWN')) {
            var advance = {};

            advance.code = $('#advance-code').val();
            advance.activeFlag = 1;

            advance.user = {};
            advance.user.code = '{$usr_login_id}';

            advance.transitCargo = {};
            advance.transitCargo.code = transitData.code;

            advance.transactionMode = {};
            advance.transactionMode.code = $('#adv-mode').val();

            advance.amount = Number($('#adv-amt').val());
            advance.remarks = '';

            advance.cashbookType = {};
            advance.cashbookType.code = 'ADVANCE';

            advance.paymentByContact = {};
            advance.paymentByContact.code = $('#adv-pay-by').val();

            advance.paymentToContact = {};
            advance.paymentToContact.code = $('#adv-pay-to').val();

            if (advance.transactionMode.code == 'UPI') {
                advance.bankDetails = {};
                advance.bankDetails.code = $('#adv-upi-orgbank').val();
                advance.addAttr1 = $.trim($('#adv-upi-id').val());
                advance.addAttr2 = $.trim($('#adv-upi-details').val());

                if (advance.addAttr1 == '') {
                    $('#adv-upi-id').addClass('inp_error');
                    err++;
                }

                if ($('#adv-upi-orgbank').val() == '') {
                    $('#adv-upi-orgbank').addClass('inp_error');
                    err++;
                }

                if (advance.addAttr2 == '') {
                    $('#adv-upi-details').addClass('inp_error');
                    err++;
                }
            } else if (advance.transactionMode.code == 'NBK') {
                advance.bankDetails = {};
                advance.bankDetails.code = $('#adv-netbanking-orgbank').val();
                advance.addAttr1 = $.trim($('#adv-netbanking-accholder').val());
                advance.addAttr2 = $.trim($('#adv-netbanking-bankname').val());
                advance.addAttr3 = $.trim($('#adv-netbanking-details').val());

                if (advance.addAttr1 == '') {
                    $('#adv-netbanking-accholder').addClass('inp_error');
                    err++;
                }

                if (advance.addAttr2 == '') {
                    $('#adv-netbanking-bankname').addClass('inp_error');
                    err++;
                }

                if ($('#adv-netbanking-orgbank').val() == '') {
                    $('#adv-netbanking-orgbank').addClass('inp_error');
                    err++;
                }

                if (advance.addAttr3 == '') {
                    $('#adv-netbanking-details').addClass('inp_error');
                    err++;
                }
            } else if (advance.transactionMode.code == 'CHEQUE') {
                advance.chequeDetails = {};
                advance.chequeDetails.code = $('#adv-chq-code').val();
                advance.chequeDetails.activeFlag = 1;

                advance.chequeDetails.organization = {};
                advance.chequeDetails.organization.code = '{$login_branch}';

                advance.chequeDetails.bankDetails = $.trim($('#adv-cheque-bankname').val());
                advance.chequeDetails.payerDetails = $.trim($('#adv-cheque-payer').val());

                advance.chequeDetails.chequeDate = moment($('#adv-cheque-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                advance.chequeDetails.chequeNo = $.trim($('#adv-cheque-no').val());
                advance.chequeDetails.bankCity = $.trim($('#adv-cheque-bankcity').val());

                advance.chequeDetails.chequeStatus = {};
                advance.chequeDetails.chequeStatus.code = 'NEW';

                advance.chequeDetails.remarks = $.trim($('#adv-cheque-remarks').val());;

                if (advance.chequeDetails.payerDetails == '') {
                    $('#adv-cheque-payer').addClass('inp_error');
                    err++;
                }

                if ($('#adv-cheque-date').val() == '') {
                    $('#adv-cheque-date').addClass('inp_error');
                    err++;
                }

                if (advance.chequeDetails.chequeNo == '') {
                    $('#adv-cheque-no').addClass('inp_error');
                    err++;
                }

                if (advance.chequeDetails.bankDetails == '') {
                    $('#adv-cheque-bankname').addClass('inp_error');
                    err++;
                }

                if (advance.chequeDetails.bankCity == '') {
                    $('#adv-cheque-bankcity').addClass('inp_error');
                    err++;
                }
            }
            data.ogpl.push(advance);
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

        $('#expense-form-buttons').hide();
        $('#expense-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#expense-action-state').html(loading_popup);
        $('#expense-action-state').show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/update-local-transit-income-expense',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#expense-form-buttons').hide();
                    $('#expense-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#expense-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        loadTransitIncomeExpense(vehicleOwnershipType.code);
                    }, 2500);
                } else {
                    $('#expense-action-state').show();
                    $('#expense-action-state').addClass('alert-danger');
                    $('#expense-action-state').html(response.errorDesc);
                    $('#expense-form-buttons').show();
                }
            }
        });
    }
    
    function deleteExpense(code) {
        if (!confirm('Do you want to delete this Income/Expense?')) {
            return;
        }

        var data = {};
        data.ogpl = [];
        
        var del_exp = _.find(expensesData, function (o) {
            return o.code === code;
        });
        del_exp.activeFlag = 2;

        data.ogpl.push(del_exp);

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/update-local-transit-income-expense',
            data: data,
            success: function (response) {
                if (response.status === 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        loadTransitIncomeExpense(vehicleOwnershipType.code);
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

    function printHireChallan(code, type) {
        var url = base_url + "cargo/ogpl-chart-hire-challan-print?transitCode=" + code + "&&ogplType=" + type;
        var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
        wo.print();
    }

    function setHireTransactionMode() {
        var mode = $('#hire-mode').val();

        $('#hire-cheque-mode-panel').addClass('hide');
        $('#hire-netbanking-mode-panel').addClass('hide');
        $('#hire-upi-mode-panel').addClass('hide');

        if (mode == 'CASH') {
            return;
        }

        if (mode == 'CHEQUE') {
            $('#hire-cheque-mode-panel').removeClass('hide');
        } else if (mode == 'NBK') {
            $('#hire-netbanking-mode-panel').removeClass('hide');
        } else if (mode == 'UPI') {
            $('#hire-upi-mode-panel').removeClass('hide');
        }
    }

    function setAdvanceTransactionMode() {
        var mode = $('#adv-mode').val();

        $('#adv-cheque-mode-panel').addClass('hide');
        $('#adv-netbanking-mode-panel').addClass('hide');
        $('#adv-upi-mode-panel').addClass('hide');

        if (mode == 'CASH') {
            return;
        }

        if (mode == 'CHEQUE') {
            $('#adv-cheque-mode-panel').removeClass('hide');
        } else if (mode == 'NBK') {
            $('#adv-netbanking-mode-panel').removeClass('hide');
        } else if (mode == 'UPI') {
            $('#adv-upi-mode-panel').removeClass('hide');
        }
    }

    function setExpenseTransactionMode() {
        var mode = $('#expense-mode').val();

        $('#expense-cheque-mode-panel').addClass('hide');
        $('#expense-netbanking-mode-panel').addClass('hide');
        $('#expense-upi-mode-panel').addClass('hide');

        if (mode == 'CASH') {
            return;
        }

        if (mode == 'CHEQUE') {
            $('#expense-cheque-mode-panel').removeClass('hide');
        } else if (mode == 'NBK') {
            $('#expense-netbanking-mode-panel').removeClass('hide');
        } else if (mode == 'UPI') {
            $('#expense-upi-mode-panel').removeClass('hide');
        }
    }

    function setSeenuExpenseTransactionMode() {
        var mode = $('#seenu-expense-mode').val();

        $('#seenu-expense-cheque-mode-panel').addClass('hide');
        $('#seenu-expense-netbanking-mode-panel').addClass('hide');
        $('#seenu-expense-upi-mode-panel').addClass('hide');

        if (mode == 'CASH') {
            return;
        }

        if (mode == 'CHEQUE') {
            $('#seenu-expense-cheque-mode-panel').removeClass('hide');
        } else if (mode == 'NBK') {
            $('#seenu-expense-netbanking-mode-panel').removeClass('hide');
        } else if (mode == 'UPI') {
            $('#seenu-expense-upi-mode-panel').removeClass('hide');
        }
    }
</script>