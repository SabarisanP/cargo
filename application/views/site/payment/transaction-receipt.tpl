<div class="brand_top">
    <h3>Transaction Receipt</h3>
    <div class="text-right noprint">
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="addTxnRcptDialog();">Add Receipt</a>
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
                                            <form id="txn-rcpt-form" name="txn-rcpt-form" method="post"
                                                onsubmit="return false">
                                                <div class="row">
                                                    <div class="form-group col-md-3">
                                                        <label for="txn_rcpt_date_range">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="fromDate" class="form-control sdate" id="txn_rcpt_date_range" readonly placeholder="Today" value="{implode(' | ', array_filter([$ffromDate|date_format:'%d-%m-%Y', $ftoDate|date_format:'%d-%m-%Y']))}">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="txn-rcpt-users">Users</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="txn-rcpt-users" class="form-control">
                                                                <option value="">Select User</option>
                                                                {foreach from=$users item=val}
                                                                    <option value="{$val->code}">{$val->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="txn-rcpt-branch">Branch</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="txn-rcpt-branch" class="form-control"
                                                                {if $action_rights['EBL-ALL-BRANCH'] != 1}disabled="disabled"
                                                                {/if}>
                                                                <option value="NA">All Branch</option>
                                                                {foreach from=$organizations item=row}
                                                                    <option value="{$row->code}"
                                                                        {if $userOrganization == $row->code}selected{/if}>
                                                                        {$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="txn-rcpt-rcpt-type">Receipt</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="txn-rcpt-rcpt-type" class="form-control">
                                                                <option value="">Select Receipt</option>
                                                                <option value="LR">LR</option>
                                                                <option value="INV">Invoice</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <button class="btn btn-success" type="button" onclick="getTransactionReceipt()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearTransactionReceipt()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left"
                                                    style="display:none;" id="txn_rcpt_action_state"></div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="txn-rcpt-list-container">
                    <br>
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="tabbable">
                                    <ul class="nav nav-tabs" id="transaction_receipt_tabs">
                                        <li class="active noprint" data-status="APRD">
                                            <a data-toggle="tab" href="#tab_approved">Approved</a>
                                        </li>
                                        <li data-status="INIT" class="noprint">
                                            <a data-toggle="tab" href="#tab_initiated">Initiated</a>
                                        </li>
                                    </ul>
                                    <div class="tab-content" id="transaction_receipt_tabs_cont">
                                        <div id="tab_approved" class="tab-pane fade in active" data-tabstatus="APRD">
                                        </div>
                                        <div id="tab_initiated" class="tab-pane fade noprint" data-tabstatus="INIT">
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

<div id="add-txn-rcpt-dialog" class="dialog-content-page hide">
    <div class="row">
        <div class="col-md-10 bold ft_15">
            Add Transaction Receipt
        </div>
    </div>
    <br>

    <div style="">
        <div class="row">
            <div class="form-group col-md-3">
                <label class="" for="txn-rcpt-txn-type">Transaction Type</label>
                <div class="input-group">
                    <label class="radio-inline">
                        <input type="radio" name="optradio" id="txn-rcpt-txn-type" class="txn-rcpt-txn-type" value="LR"
                            checked>LR&nbsp;
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="optradio" id="txn-rcpt-txn-type" class="txn-rcpt-txn-type"
                            value="INV">Invoice&nbsp;
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="optradio" id="txn-rcpt-txn-type" class="txn-rcpt-txn-type"
                            value="ADV">Advance Amount&nbsp;
                    </label>
                </div>
            </div>

            <div class="form-group col-md-4" id="txn-rcpt-cust">
                <label class="req">Customer</label>
                <input type="text" name="txn-rcpt-customer" value="" class="form-control" id="txn-rcpt-customer"
                    maxlength="10" autocomplete="off" placeholder="Customer / Mobile Number">
            </div>

            <div class="form-group col-md-4 hide" id="txn-rcpt-ven">
                <label class="req">Vendor</label>
                <div class="input-group">
                    <input type="text" name="txn-rcpt-vendor" value="" class="form-control" id="txn-rcpt-vendor"
                        maxlength="10" autocomplete="off" placeholder="Vendor / Mobile Number">
                    <span class="input-group-addon" id="vendor_users_info"><i class="fa fa-info-circle"></i></span>
                </div>
            </div>

            <div class="form-group col-md-4 hide" id="txn-rcpt-adv">
                <label class="req">Vendor</label>
                <div class="input-group">
                    <input type="text" name="txn-rcpt-adv-vendor" value="" class="form-control" id="txn-rcpt-adv-vendor"
                        maxlength="10" autocomplete="off" placeholder="Vendor / Mobile Number">
                    <span class="input-group-addon" id="vendor_adv_info"><i class="fa fa-info-circle"></i></span>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="form-group" id="vendor-customer-list-panel" style="height: 200px;overflow-y: auto;">
                    {* LR *}
                    <div class="overflow-x-auto hide" id="cargo-bookings" style="height: 200px;overflow-y: auto;">
                        <table class="table table-bordered" width="98%" id="txn-rcpt-lr-table">
                            <thead>
                                <tr class="success">
                                    <td align="center" class="sticky-row-top"></td>
                                    <td align="center" class="sticky-row-top">{lang('cargo_code_term')}</td>
                                    <td align="center" class="sticky-row-top">Booked Date</td>
                                    <td align="center" class="sticky-row-top">{lang('booking_from_term')}</td>
                                    <td align="center" class="sticky-row-top">{lang('booking_to_label')}</td>
                                    <td align="center" class="sticky-row-top">Transit Branch</td>
                                    <td align="center" class="sticky-row-top">Payment Status</td>
                                    <td align="center" class="sticky-row-top">Cargo Status</td>
                                    <td align="center" class="sticky-row-top">No. Of Articles</td>
                                    <td align="center" class="sticky-row-top">Qty</td>
                                    <td align="center" class="sticky-row-top">Net Amount</td>
                                    <td align="center" class="sticky-row-top">Paid Amount</td>
                                    <td align="center" class="sticky-row-top">Balance Amount</td>
                                </tr>
                            </thead>
                            <tbody class="body_table" id="vendor-customer-list-row">
                                {foreach item=row from=$pendingDeliveryList key=key}
                                    <tr class="hide" data-mobile="{$row->to_customer_mobile}">
                                        <td align="center">
                                            <input type="checkbox" onclick="getDemurrageDetails();" class="lr-check" value="{$row->cargo_code}" data-balanceamount="{$row->balance_amount}">
                                        </td>
                                        <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                                        <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                                        <td align="left">{$row->from_organization_name}</td>
                                        <td align="left">{$row->to_organization_name}</td>
                                        <td align="left">{($row->transit_organization_name)? $row->transit_organization_name : '-'}</td>
                                        <td align="left">
                                            {$row->payment_type_code|_cargo_payment_status_badge}
                                        </td>
                                        <td align="left">{$cargostatus[$row->cargo_status_code]}</td>
                                        <td align="right">{$row->item_count}</td>
                                        <td align="right">{$row->total_item_count}</td>
                                        <td align="right">{($row->total_amount+$row->other_charges)|inr_format}</td>
                                        <td align="right">{($row->total_amount_paid)|inr_format}</td>
                                        <td align="right">{($row->total_amount+$row->other_charges-$row->customer_tds_tax-$row->total_amount_paid)|inr_format}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>

                    {* Unpaid Invocie *}
                    <div class="overflow-x-auto hide" id="payment-transactions" style="height: 200px;overflow-y: auto;">
                        <table class="table table-bordered" width="98%" id="txn-rcpt-up-inv-table">
                            <thead>
                                <tr class="success">
                                    <th align="center" class="sticky-row-top"></th>
                                    <th align="center" class="sticky-row-top">Invoice No</th>
                                    <th align="center" class="sticky-row-top">Vendor</th>
                                    <th align="center" class="sticky-row-top">Created Date</th>
                                    <th align="center" class="sticky-row-top">Created By</th>
                                    <th align="center" class="sticky-row-top">Invoice Peroid</th>
                                    <th align="center" class="sticky-row-top">Invoice Amount</th>
                                    <th align="center" class="sticky-row-top">Balance Amount</th>
                                </tr>
                            </thead>
                            <tbody class="body_table">

                                {foreach item=row from=$unpaidinvoice}

                                    <tr class="hide" data-user="{$row->user->code}">
                                        <td align="center">
                                            <input type="checkbox" class="inv-check" value="{$row->code}"
                                                data-balanceamount="{$row->balanceAmount}">
                                        </td>
                                        <td align="left">{$row->code}</td>
                                        <td align="left">{$row->user->name}</td>
                                        <td align="left">{$row->transactionDate|date_format:$ns_date_format}</td>
                                        <td align="left">{$row->paymentHandledBy->name}</td>
                                        <td align="left">
                                            {if $row->transactionStartDate != '' || $row->transactionEndDate != ''}
                                                {$row->transactionStartDate|date_format:$ns_date_format} to
                                                {$row->transactiontxn-rcpt-vendorndDate|date_format:$ns_date_format}
                                            {else}
                                                -
                                            {/if}
                                        </td>
                                        <td align="right">{$row->transactionAmount|inr_format}</td>
                                        <td align="right">{$row->balanceAmount|inr_format}</td>
                                        <td width="20%">
                                            <input type="hidden" id="hid-inv-total-balance" value="{$row->balanceAmount}">
                                            <div class="d-flex hide txn-rcpt-advance" style="align-items: center;">
                                                <div style="width: 70%;">
                                                    <input type="number" disabled class="form-control amount{$row->code}"
                                                        id="txn-rcpt-advance-amount">
                                                </div>
                                                &nbsp;
                                                <div>
                                                    <a href="javascript:;" class="btn btn-sm"
                                                        onclick="payUsingAdvanceDialog('{$row->code}', '{$row->balanceAmount}')"><i
                                                            class="fa fa-plus"></i>&nbsp;Pay</a>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>

                    <div id="vendor-customer-info">
                        <br><br>
                        <div class="well">
                            <i class="fa fa-info-circle"></i> Please select a customer / vendor
                        </div>
                    </div>
                </div>
                <br>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-2 txn-only-fields cont">
                <label class="" for="txn-rcpt-tot-amt">Total Balance</label>
                <input type="number" class="form-control hover-background" id="txn-rcpt-tot-amt"
                    placeholder="Total Amount" step="any" readonly>
            </div>

            {* <div class="form-group col-md-2 txn-only-fields cont">
                <label class="req" for="txn-rcpt-pod-amt">POD Charges</label>
                <input type="number" class="form-control" id="txn-rcpt-pod-amt" placeholder="POD Charges" step="any">
            </div> *}

            <div class="form-group col-md-2 txn-only-fields cont">
                <label class="req" for="txn-rcpt-dem-amt">Demurrage Charge</label>
                <input type="number" class="form-control" id="txn-rcpt-dem-amt" placeholder="Demurrage Charge"
                    step="any" onchange="calculateTotalAmount()">
            </div>

            <div class="form-group col-md-2 txn-only-fields cont">
                <label class="req" for="txn-rcpt-mhc-amt">Machine Handling Cgs.</label>
                <input type="number" class="form-control" id="txn-rcpt-mhc-amt" placeholder="Machine Handling Cgs."
                    step="any" onchange="calculateTotalAmount()">
            </div>

            <div class="form-group col-md-3 txn-only-fields cont">
                <label class="req" for="txn-rcpt-tds-amt">TDS Amount</label>
                <div class="row">
                    <div class="col-md-5 p_r_n">
                        <select class="form-control" id="txn-rcpt-tds-percent"
                            onchange="calcReceiptTDSPercent(this.value);">
                            <option value="0">Nil</option>
                            <option value="2">2%</option>
                            {* <option value="5">5%</option>
                            <option value="8">8%</option>
                            <option value="10">10%</option> *}
                        </select>
                    </div>
                    <div class="col-md-7 p_l_n">
                        <input type="number" class="form-control" id="txn-rcpt-tds-amt" value="0"
                            placeholder="TDS Amount" onchange="calculateTotalAmount()">
                    </div>
                </div>
            </div>

            <div class="form-group col-md-2 cont hide">
                <label class="req" for="txn-rcpt-txn-amt">Transaction Amount</label>
                <input type="number" class="form-control" id="txn-rcpt-txn-amt" placeholder="Transaction Amount"
                    step="any">
            </div>

            <div class="form-group col-md-2 txn-only-fields cont">
                <label class="" for="txn-rcpt-net-amt">Payable Amount</label>
                <input type="number" class="form-control hover-background" id="txn-rcpt-net-amt"
                    placeholder="Net Amount" step="any" readonly>
            </div>

            <div class="form-group col-md-2">
                <label class="req" for="txn-rcpt-rcvd-date">Amount Received Date</label>
                <div class="input-group">
                    <input type="text" class="form-control sdate" id="txn-rcpt-rcvd-date" readonly
                        placeholder="Amount Received Date">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>

            <div class="form-group col-md-3">
                <label class="req" for="txn-rcpt-txn-mode">Transaction Mode</label>
                <select id="txn-rcpt-txn-mode" class="form-control">
                    <option value="">Select Transaction Mode</option>
                    {foreach from=$transactionmode item=val key=k}
                        <option value="{$k}">{$val}</option>
                    {/foreach}
                    <option value="ADV">Advance Payment</option>
                </select>
            </div>
        </div>

        <div class="row">
            {* UPI *}
            <div class="hide" id="txn-rcpt-upi">
                <div class="form-group col-md-3">
                    <label class="req" for="txn-rcpt-bank-details">Organization Bank</label>
                    <select id="txn-rcpt-bank-details" class="form-control">
                        <option value="">Select a Bank</option>
                        {foreach from=$bankdetail item=val}
                            {if $val->accountType->code != 'CASH'}
                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>

                <div class="form-group col-md-3">
                    <label class="req" for="txn-rcpt-upi-id">UPI Id</label>
                    <input type="text" class="form-control" id="txn-rcpt-upi-id" placeholder="UPI ID">
                </div>

                <div class="form-group col-md-3">
                    <label for="txn-rcpt-upi-details">Ref. #</label>
                    <input type="text" class="form-control" id="txn-rcpt-upi-details" placeholder="Ref. #">
                </div>
            </div>

            {* NBK *}
            <div class="hide" id="txn-rcpt-nbk">
                <div class="form-group col-md-3">
                    <label class="req" for="txn-rcpt-bank-nbk">Organization Bank</label>
                    <select id="txn-rcpt-bank-nbk" class="form-control">
                        <option value="">Select a Bank</option>
                        {foreach from=$bankdetail item=val}
                            {if $val->accountType->code != 'CASH'}
                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>

                <div class="form-group col-md-3">
                    <label class="req" for="txn-rcpt-acc-hold-name">Account Holder Name</label>
                    <input type="text" class="form-control" id="txn-rcpt-acc-hold-name"
                        placeholder="Account Holder Name">
                </div>

                <div class="form-group col-md-3" id="txn-rcpt-bank-name-div">
                    <label class="req" for="txn-rcpt-bank-name">Bank Name</label>
                    <input type="text" class="form-control" id="txn-rcpt-bank-name" placeholder="Bank Name">
                </div>

                <div class="form-group col-md-3">
                    <label for="txn-rcpt-nbk-details">Ref. #</label>
                    <input type="text" class="form-control" id="txn-rcpt-nbk-details" placeholder="Ref. #">
                </div>
            </div>
        </div>

        <div class="row">
            {* chq *}
            <div class="hide" id="txn-rcpt-chq">
                <div class="form-group col-md-2 hide">
                    <label class="req" for="txn-rcpt-chq-branch">Branch</label>
                    <select id="txn-rcpt-chq-branch" class="form-control">
                        <option value="">Select a Branch</option>
                        {foreach from=$organizations item=row}
                            <option value="{$row->code}">{$row->name}</option>
                        {/foreach}
                    </select>

                    <input type="hidden" id="txn-rcpt-chq-branch-hid" value="{$login_branch}">
                </div>

                <div class="form-group col-md-3">
                    <label class="req" for="txn-rcpt-payer">Payer Details</label>
                    <input type="text" class="form-control" id="txn-rcpt-payer" placeholder="Payer Details">
                </div>

                <div class="form-group col-md-2">
                    <label class="req" for="txn-rcpt-chq-num">Cheque No</label>
                    <input type="text" class="form-control" id="txn-rcpt-chq-num" placeholder="Cheque Number">
                </div>

                <div class="form-group col-md-2">
                    <label class="req" for="txn-rcpt-chq-date">Cheque Date</label>
                    <div class="input-group">
                        <input type="text" class="form-control sdate" id="txn-rcpt-chq-date" readonly
                            placeholder="Cheque Date">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>

                <div class="form-group col-md-3" id="txn-rcpt-chq-bankname-div">
                    <label class="req" for="txn-rcpt-chq-bankname">Bank Name</label>
                    <input type="text" class="form-control" id="txn-rcpt-chq-bankname" placeholder="Bank Name">
                </div>

                <div class="form-group col-md-2">
                    <label class="req" for="txn-rcpt-chq-city">Bank City</label>
                    <input type="text" class="form-control" id="txn-rcpt-chq-city" placeholder="Bank City">
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-12">
                <label>Remarks</label>
                <textarea id="txn-rcpt-remarks" placeholder="Enter your remarks" style="resize:none"
                    class="form-control" rows="2" cols="30" name="remark" id="remark"></textarea>
            </div>
        </div>
    </div>
    <div style="padding:15px 15px 10px;">
        <div class="row">
            <input type="hidden" id="txn-rcpt-code">
            <input type="hidden" id="txn-rcpt-chq-code">
            <div class="clear_fix_both">
                <div class="alert hide" id="txn-rcpt-action-state"></div>
                <div class="align-right">
                    <button class="btn btn-success" type="button" id="txn-rcpt-form-buttons"
                        onclick="saveTransactionReceipt();">Save</button>
                    <button class="btn btn-default" type="button" onclick="closeTxnRcptDialog();">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="update-transaction-receipt-status" class="hide">
    <form role="form">
        <br>
        <div class="col-lg-12 p_l_n p_r_n">
            <label for="update-transaction-receipt-remarks">Remarks</label>
            <textarea id="update-transaction-receipt-remarks" placeholder="Enter your remarks here..."
                style="resize:none" class="form-control" rows="3" cols="10" name="remark" maxlength="200"></textarea>
        </div>
        <div class="clear_fix_both"></div>
    </form>
    <br />
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="update_transaction_receiptaction_state"></div>
        <div class="align-right" id="form-bttons">
            <input type="hidden" id="hid_transaction_receipt_code" />
            <button class="btn btn-success" type="button" id="confirm-pay"
                onclick="updateTransactionReceiptStatus();">Submit</button>
            <button class="btn btn-default" type="button" onclick="closeUpdateTransactionReceipt();">Cancel</button>
        </div>
    </div>
</div>

<div id="pay-using-advance-amt-dialog" class="hide">
    <div class="">
        <br>
        <div class="col-lg-12 p_l_n">
            <h5 class="pull-right"><b>Invoice Amount : <span id="invoice-amount"></span></b></h5>
        </div>
        <div class="col-lg-12 p_l_n">
            <div class="table-responsive" id="vendor-advance-amount" style="height: 340px;overflow: auto;"></div>
        </div>
        <div class="clear_fix_both"></div><br />
    </div>
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="pay-using-advance-amt-action-state"></div>
        <div class="align-right" id="form-bttons">
            <input type="hidden" id="transaction-receipt-inv-code" />
            {* <input type="hidden" id="transaction-receipt-inv-amount"/> *}
            <button class="btn btn-success" type="button" id="save-advance-payment-btn"
                onclick="payUsingAdvanceAmount();">Save</button>
            <button class="btn btn-default" type="button" onclick="closePayUsingAdvanceDialog();">Cancel</button>
        </div>
    </div>
</div>

<style>
    #txn-rcpt-ven>.input-group>.twitter-typeahead {
        display: table-cell !important;
    }
</style>

<script>
    localStorage.clear();
    var customersData = {$customers|json_encode}
    var vendorsData = {$vendors|json_encode}
    var allVendorsData = {$allvendors|json_encode}
    var bankNamesList = {$bank_names_list|json_encode}
</script>

{literal}
    <script>

        $('#txn-rcpt-users, #txn-rcpt-bank-details, #txn-rcpt-chq-bank-details, #txn-rcpt-chq-branch, #txn-rcpt-bank-nbk').select2();
        $('#txn-rcpt-branch').select2();

        $('#txn_rcpt_date_range').daterangepicker({
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

        $('#txn-rcpt-chq-date, #txn-rcpt-rcvd-date').datepicker({
            todayHighlight: true,
            format: 'dd-mm-yyyy',
            autoclose: true
        });
        $('#txn-rcpt-bank-name').autocomplete({
            minLength: 0,
            source: bankNamesList,
            appendTo: '#txn-rcpt-bank-name-div'
        }).focus(function() {
            $(this).autocomplete('search', '');
        });

        $('#txn-rcpt-chq-bankname').autocomplete({
            minLength: 0,
            source: bankNamesList,
            appendTo: '#txn-rcpt-chq-bankname-div'
        }).focus(function() {
            $(this).autocomplete('search', '');
        });

        $('#txn-rcpt-txn-mode').on('change', function() {
            $('#txn-rcpt-bank-details, #txn-rcpt-bank-nbk, #txn-rcpt-chq-bank-details, #txn-rcpt-chq-bankname, #txn-rcpt-chq-branch')
                .val('').trigger('change');
            $('#txn-rcpt-payer, #txn-rcpt-chq-num, #txn-rcpt-chq-date, #txn-rcpt-chq-city, #txn-rcpt-upi-id, #txn-rcpt-upi-details, #txn-rcpt-bank-name, #txn-rcpt-acc-hold-name, #txn-rcpt-nbk-details')
                .val('');

            $('.txn-rcpt-advance, #txn-rcpt-chq, #txn-rcpt-upi, #txn-rcpt-nbk').addClass('hide');
            $('#txn-rcpt-form-buttons').removeClass('hide');
            if ($(this).val() == 'UPI') {
                $('#txn-rcpt-upi').removeClass('hide');
            } else if ($(this).val() == 'NBK') {
                $('#txn-rcpt-nbk').removeClass('hide');
            } else if ($(this).val() == 'CHEQUE') {
                $('#txn-rcpt-chq').removeClass('hide');
            } else if ($(this).val() == 'ADV') {
                $('#txn-rcpt-form-buttons').addClass('hide');
                $('#txn-rcpt-up-inv-table .inv-check:checked').each(function() {
                    $(this).closest('tr').find('.txn-rcpt-advance').removeClass('hide');
                    $(this).closest('tr').find('#txn-rcpt-advance-amount').val('');
                });
            }
        });

        $('.txn-rcpt-txn-type').on('change', function() {
            $('#txn-rcpt-customer, #txn-rcpt-vendor').typeahead('val', '');
            $('.txn-only-fields input, #txn-rcpt-txn-mode').val('').trigger('change');
            $('#txn-rcpt-cust, #txn-rcpt-ven, #txn-rcpt-adv').addClass('hide');
            $('#vendor-customer-info, #txn-rcpt-form-buttons').removeClass('hide');
            $('#cargo-bookings, #payment-transactions').addClass('hide');
            $('#vendor-customer-list-panel').addClass('hide');
            $('.txn-only-fields').removeClass('hide');
            $('#txn-rcpt-txn-amt').closest('.cont').addClass('hide');
            $('#txn-rcpt-txn-mode option[value=ADV]').hide();

            if ($(this).val() == 'INV') {
                $('#txn-rcpt-txn-mode option[value=ADV]').show();
                $('#txn-rcpt-ven').removeClass('hide');
                $('#vendor-customer-list-panel').removeClass('hide');
                $('.txn-only-fields').addClass('hide');
                $('#txn-rcpt-txn-amt').closest('.cont').removeClass('hide');
            } else if ($(this).val() == 'LR') {
                $('#txn-rcpt-cust').removeClass('hide');
                $('#vendor-customer-list-panel').removeClass('hide');
            } else if ($(this).val() == 'ADV') {
                $('#vendor-customer-list-panel').addClass('hide');
                $('#txn-rcpt-adv').removeClass('hide');
                $('.txn-only-fields').addClass('hide');
                $('#txn-rcpt-txn-amt').closest('.cont').removeClass('hide');
            }
        });

        // LR
        $('#txn-rcpt-customer').on('change typeahead:selected', function() {
            $('#cargo-bookings').addClass('hide');
            $('#vendor-customer-info').removeClass('hide');
            if ($(this).val() != '') {
                $('#vendor-customer-info').addClass('hide');
                $('#cargo-bookings').removeClass('hide');
            }
        })

        var customerName = new Bloodhound({
            local: customersData,
            datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name', 'mobileNumber'),
            queryTokenizer: Bloodhound.tokenizers.whitespace,
        });
        customerName.initialize();

        const customerTemplates = {
            notFound: '<div class="empty-message p_l_15">No results found</div>',
            suggestion: Handlebars.compile('<div><b>{{name}}</b><br/><span class="text-muted"><small>{{mobileNumber}}</small></span></div>')
        };

        $('#txn-rcpt-customer').typeahead({
            minLength: 0
        }, {
            name: 'txn-rcpt-customer',
            displayKey: 'name',
            source: function(q, sync) {
                if (q === '') {
                    sync(customerName.all());
                    return;
                }
                customerName.search(q, sync);
            },
            templates: customerTemplates,
        }).on('typeahead:selected', function(e, d, n) {
            $('#txn-rcpt-customer').data('customerData', d);
            $('#txn-rcpt-customer').typeahead('val', d.name);
            getBookingLr(d.mobileNumber);
        });

        var vendorName = new Bloodhound({
            local: vendorsData,
            datumTokenizer: Bloodhound.tokenizers.obj.whitespace('companyName'),
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            initialize: false,
            identify: function(obj) {
                return obj.code;
            }
        });
        vendorName.initialize();

        const vendorTemplates = {
            notFound: '<div class="empty-message p_l_15">No results found</div>',
            suggestion: Handlebars.compile('<div><b class="text-break">{{companyName}}</b></div>')
        };

        var allvendorName = new Bloodhound({
            local: allVendorsData,
            datumTokenizer: Bloodhound.tokenizers.obj.whitespace('companyName'),
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            initialize: false,
            identify: function(obj) {
                return obj.code;
            }
        });
        allvendorName.initialize();

        $('#txn-rcpt-vendor').typeahead({
            minLength: 0,
        }, {
            name: 'txn-rcpt-vendor',
            displayKey: 'name',
            limit: 10000,
            source: function(q, sync) {
                if (q === '') {
                    sync(allvendorName.all());
                    return;
                }
                allvendorName.search(q, sync);
            },
            templates: vendorTemplates,
        }).on('typeahead:selected', function(e, d, n) {
            $('#txn-rcpt-vendor').data('vendorData', d);
            $('#txn-rcpt-vendor').typeahead('val', d.companyName);
            getUPInvoice(d.user.code);
            vendorInfoTooltip($.trim(d.code).toUpperCase(), '#vendor_users_info');
        });

        $('#txn-rcpt-adv-vendor').typeahead({
            minLength: 0,
        }, {
            name: 'txn-rcpt-adv-vendor',
            displayKey: 'name',
            limit: 10000,
            source: function(q, sync) {
                if (q === '') {
                    sync(allvendorName.all());
                    return;
                }
                allvendorName.search(q, sync);
            },
            templates: vendorTemplates,
        }).on('typeahead:selected', function(e, d, n) {
            $('#txn-rcpt-adv-vendor').data('vendorData', d);
            $('#txn-rcpt-adv-vendor').typeahead('val', d.companyName);
            getUPInvoice(d.user.code);
            vendorInfoTooltip($.trim(d.code).toUpperCase(), '#vendor_adv_info');
        });

        // Invoice
        $('#txn-rcpt-vendor').on('change typeahead:selected', function() {
            //working
            $('#payment-transactions').addClass('hide');
            $('#vendor-customer-info').removeClass('hide');
            if ($(this).val() != '') {
                $('#payment-transactions').removeClass('hide');
                $('#vendor-customer-info').addClass('hide');

                // get vendor advance payment
                var vendorData = $('#txn-rcpt-vendor').data('vendorData');
                loadVendorPayment(vendorData.mobileNumber);
                // console.log(vendorData);
                // var data = {};
                // data.userCode = 'NA';
                // data.mobileNumber = vendorData.mobileNumber;



            }
        });



        // selected lr total amount
        $('#txn-rcpt-lr-table .lr-check').on('change', function() {
            var totalAmount = 0;
            $('#txn-rcpt-lr-table .lr-check:checked').each(function() {
                var balanceAmount = $(this).data('balanceamount');
                totalAmount = totalAmount + balanceAmount;
            });
            $('#txn-rcpt-tot-amt').val(totalAmount);
            // $('#txn-rcpt-txn-amt').val(totalAmount);
            $('#txn-rcpt-tds-percent').val('0');
            $('#txn-rcpt-tds-amt').val('');
            calculateTotalAmount();
        });

        // selected invoice total amount
        $('#txn-rcpt-up-inv-table .inv-check').on('change', function() {
            var totalAmount = 0;
            var payMode = $('#txn-rcpt-txn-mode').val();
            $('#txn-rcpt-up-inv-table .inv-check:checked').each(function() {
                var balanceAmount = $(this).data('balanceamount');
                totalAmount = totalAmount + balanceAmount;
            });
            $('#txn-rcpt-txn-amt').val(totalAmount);
            $('#txn-rcpt-tds-percent').val('0');
            $('#txn-rcpt-tds-amt').val('');

            if (payMode == 'ADV') {
                $(this).closest('tr').find('.txn-rcpt-advance').addClass('hide');
                $(this).closest('tr').find('#txn-rcpt-advance-amount').val('');
                if ($(this).is(':checked')) {
                    $(this).closest('tr').find('.txn-rcpt-advance').removeClass('hide');
                }
                validateInvoiceAdvancePayment();
            }
            calculateTotalAmount();
        });

        $('#transaction_receipt_tabs').on('shown.bs.tab', function(e) {
            getTransactionReceipt();
        });

        function calculateTotalAmount(txnField = true) {
            var balanceAmount = Number($('#txn-rcpt-tot-amt').val()) || 0;
            var machineHandlingCharge = Number($('#txn-rcpt-mhc-amt').val()) || 0;
            var demurrageCharge = Number($('#txn-rcpt-dem-amt').val()) || 0;
            var calculatedtdsTax = Number($('#txn-rcpt-tds-amt').data('amount')) || 0;
            var tdsTax = Number($('#txn-rcpt-tds-amt').val()) || 0;

            // if (txnField) {
            //     $('#txn-rcpt-txn-amt').val(balanceAmount - tdsTax);
            // }
            // var transactionAmount = Number($('#txn-rcpt-txn-amt').val()) || 0;

            var total = balanceAmount + machineHandlingCharge + demurrageCharge - tdsTax;
            $('#txn-rcpt-net-amt').val(total);
        }

        function getBookingLr(mobile) {
            $('#txn-rcpt-lr-table tbody tr').addClass('hide');
            $('.lr-check').attr('checked', false);

            if (mobile) {
                $('#cargo-bookings').removeClass('hide');
                $('#txn-rcpt-lr-table tbody').find("[data-mobile='" + mobile + "']").removeClass('hide');
            }
        }

        function getUPInvoice(code) {
            $('#txn-rcpt-up-inv-table tbody tr').addClass('hide');
            $('.inv-check').attr('checked', false);
            if (code) {
                $('#payment-transactions').removeClass('hide');
                $('#txn-rcpt-up-inv-table tbody').find("[data-user='" + code + "']").removeClass('hide');
            }
        }

        function getTransactionReceipt() {
            var data = {};
            var daterange = $('#txn_rcpt_date_range').data('daterangepicker');
            data.fromDate = daterange.startDate.format('DD-MM-YYYY');
            data.toDate = daterange.endDate.format('DD-MM-YYYY');
            data.organizationCode = $('#txn-rcpt-branch').val();
            data.receiptType = $('#txn-rcpt-rcpt-type').val();
            data.userCode = $('#txn-rcpt-users').val();
            data.receiptStatus = $('#transaction_receipt_tabs li.active').data('status');

            var err = 0;

            $('.inp_error').removeClass('inp_error');
            
            if (err > 0) {
                $('#txn_rcpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#txn_rcpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#txn_rcpt_action_state').show();
                return false;
            }

            $('#txn_rcpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#txn_rcpt_action_state').html('').hide();

            $('#txn-rcpt-list-container').removeClass('hidden');
            $('[data-tabstatus="' + data.receiptStatus + '"]').html(loading_popup);
          

            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'payment/transaction-receipt-list',
                data: data,
                success: function(response) {
                    $('[data-tabstatus="' + data.receiptStatus + '"]').html(response);
                    $("html, body").animate({
                        scrollTop: $('#txn-rcpt-list-container').offset().top - 35
                    }, "slow");
                }
            });
        }

        function clearTransactionReceipt() {
            $('#txn_rcpt_date_range').val('');
            $('#txn_rcpt_date_range').data('daterangepicker').setStartDate({});
            $('#txn_rcpt_date_range').data('daterangepicker').setEndDate({});
            $('#txn_rcpt_date_range, #txn-rcpt-rcpt-type').val('');
            $('#txn-rcpt-users').val('').trigger('change')
            $('#txn-rcpt-list-container').addClass('hidden');
            $('.inp_error').removeClass('inp_error');
            $('#txn_rcpt_action_state').removeClass('alert-success, alert-danger').html('').hide();
        }

        function addTxnRcptDialog(code) {

            $('#add-txn-rcpt-dialog').css('background', '#fff');
            $('#add-txn-rcpt-dialog').removeClass('hide');
            $('#add-txn-rcpt-dialog').dialog({
                autoOpen: true,
                height: 700,
                width: $(window).width() - 200,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();
            $('.inp_error').removeClass('inp_error');
            $('#txn-rcpt-action-state').removeClass('alert-success, alert-danger').html('').hide();

            $('#txn-rcpt-code, #txn-rcpt-chq-code, #txn-rcpt-txn-amt, #txn-rcpt-tds-amt, #txn-rcpt-payer, #txn-rcpt-chq-date, #txn-rcpt-chq-num, #txn-rcpt-chq-city, #txn-rcpt-rcvd-date, #txn-rcpt-remarks, #txn-rcpt-upi-id, #txn-rcpt-upi-details, #txn-rcpt-bank-name, #txn-rcpt-acc-hold-name, #txn-rcpt-nbk-details')
                .val('');
            $('#txn-rcpt-bank-details, #txn-rcpt-chq-branch, #txn-rcpt-chq-bank-details, #txn-rcpt-chq-bankname, #txn-rcpt-bank-nbk')
                .val('').trigger('change');
            $('#txn-rcpt-customer, #txn-rcpt-vendor').typeahead('val', '');
            $('#txn-rcpt-txn-mode').val('').trigger('change');

            $('.txn-rcpt-txn-type[value=LR]').prop('checked', true).trigger('change');
        }

        function closeTxnRcptDialog() {
            localStorage.clear();
            advancePaymentTransaction = {};
            $('#add-txn-rcpt-dialog').addClass('hide');
            $('#add-txn-rcpt-dialog').dialog('destroy');
        }

        function saveTransactionReceipt() {
            var err = 0;
            $('.inp_error').removeClass('inp_error');

            var data = {};
            data.code = $('#txn-rcpt-code').val();
            data.activeFlag = 1;

            data.transactionReceiptType = {};
            data.transactionReceiptType.code = $('.txn-rcpt-txn-type:checked').val();

            if (data.transactionReceiptType.code == 'LR') {
                data.transactionAmount = $('#txn-rcpt-tot-amt').val();

                var cust = $('#txn-rcpt-customer').data('customerData');
                data.cargoCustomer = {};
                if (cust) {
                    data.cargoCustomer.mobileNumber = cust.mobileNumber;
                }

                if ($('#txn-rcpt-customer').val() == '') {
                    $('#txn-rcpt-customer').addClass('inp_error');
                    err++;
                }
            } else if (data.transactionReceiptType.code == 'INV') {
                data.transactionAmount = $('#txn-rcpt-txn-amt').val();

                var vendor = $('#txn-rcpt-vendor').data('vendorData');
                data.cargoVendor = {};
                data.cargoVendor.user = {};
                if (vendor) {
                    data.cargoVendor.user.code = vendor.user.code;
                }

                if ($('#txn-rcpt-vendor').val() == '') {
                    $('#txn-rcpt-vendor').addClass('inp_error');
                    err++;
                }
            } else if (data.transactionReceiptType.code == 'ADV') {
                data.transactionAmount = $('#txn-rcpt-txn-amt').val();
                data.receiptReferenceType = {};
                data.receiptReferenceType.code = "VDR"

                data.receiptReferenceType = {};
                data.receiptReferenceType.code = 'VDR';

                var vendor = $('#txn-rcpt-adv-vendor').data('vendorData');
                data.cargoCustomer = {};
                data.cargoVendor = {};
                if (vendor) {
                    data.cargoCustomer.mobileNumber = vendor.mobileNumber;
                    data.cargoVendor.code = vendor.code;
                }

                if ($('#txn-rcpt-adv-vendor').val() == '') {
                    $('#txn-rcpt-adv-vendor').addClass('inp_error');
                    err++;
                }
            }

            data.partialAmount = 0;
            data.tdsAmount = $('#txn-rcpt-tds-amt').val();
            data.machineHandlingCharge = $('#txn-rcpt-mhc-amt').val();
            data.demurrageCharge = $('#txn-rcpt-dem-amt').val();
            // data.podCharge = $('#txn-rcpt-pod-amt').val();

            if (data.transactionAmount == '' || Number(data.transactionAmount) <= 0) {
                $('#txn-rcpt-tot-amt, #txn-rcpt-txn-amt').addClass('inp_error');
                err++;
            }

            if (data.transactionReceiptType.code == 'LR') {
                if (data.tdsAmount == '') {
                    $('#txn-rcpt-tds-amt').addClass('inp_error');
                    err++;
                }
                if (data.machineHandlingCharge == '') {
                    $('#txn-rcpt-mhc-amt').addClass('inp_error');
                    err++;
                }
                if (data.demurrageCharge == '') {
                    $('#txn-rcpt-dem-amt').addClass('inp_error');
                    err++;
                }
                // if (data.podCharge == '') {
                //     $('#txn-rcpt-pod-amt').addClass('inp_error');
                //     err++;
                // }
            }
            // data.transactionAmount = Number(data.transactionAmount) - Number(data.tdsAmount);

            data.transactionMode = {};
            data.transactionMode.code = $('#txn-rcpt-txn-mode').val();

            if (data.transactionMode.code == '') {
                $('#txn-rcpt-txn-mode').addClass('inp_error');
                err++;
            }

            // upi
            if (data.transactionMode.code == 'UPI') {
                data.bankDetails = $('#txn-rcpt-bank-details').val();
                data.addAttr1 = $.trim($('#txn-rcpt-upi-id').val());
                data.addAttr2 = $.trim($('#txn-rcpt-upi-details').val());

                if (data.addAttr1 == '') {
                    $('#txn-rcpt-upi-id').addClass('inp_error');
                    err++;
                }

                if ($('#txn-rcpt-bank-details').val() == '') {
                    $('#txn-rcpt-bank-details').addClass('inp_error');
                    err++;
                }

                if (data.addAttr2 == '') {
                    $('#txn-rcpt-upi-details').addClass('inp_error');
                    err++;
                }
            } else if (data.transactionMode.code == 'NBK') {
                data.bankDetails = $('#txn-rcpt-bank-nbk').val();
                data.addAttr1 = $.trim($('#txn-rcpt-acc-hold-name').val());
                data.addAttr2 = $.trim($('#txn-rcpt-bank-name').val());
                data.addAttr3 = $.trim($('#txn-rcpt-nbk-details').val());

                if (data.addAttr1 == '') {
                    $('#txn-rcpt-acc-hold-name').addClass('inp_error');
                    err++;
                }

                if (data.addAttr2 == '') {
                    $('#txn-rcpt-bank-name').addClass('inp_error');
                    err++;
                }

                if ($('#txn-rcpt-bank-nbk').val() == '') {
                    $('#txn-rcpt-bank-nbk').addClass('inp_error');
                    err++;
                }

                if (data.addAttr3 == '') {
                    $('#txn-rcpt-nbk-details').addClass('inp_error');
                    err++;
                }
            }

            // cheque
            if (data.transactionMode.code == 'CHEQUE') {
                data.chequeDetails = {};
                data.chequeDetails.code = $('#txn-rcpt-chq-code').val();
                data.chequeDetails.activeFlag = 1;

                data.chequeDetails.organization = {};
                // data.chequeDetails.organization.code = $('#txn-rcpt-chq-branch').val();
                data.chequeDetails.organization.code = $('#txn-rcpt-chq-branch-hid').val();

                // data.chequeDetails.namespaceBank = {};
                // data.chequeDetails.namespaceBank.code = $('#txn-rcpt-chq-bank-details').val();
                data.chequeDetails.bankDetails = $.trim($('#txn-rcpt-chq-bankname').val());

                data.chequeDetails.payerDetails = $.trim($('#txn-rcpt-payer').val());

                data.chequeDetails.chequeDate = moment($('#txn-rcpt-chq-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                data.chequeDetails.chequeNo = $.trim($('#txn-rcpt-chq-num').val());
                data.chequeDetails.bankCity = $.trim($('#txn-rcpt-chq-city').val());

                data.chequeDetails.chequeStatus = {};
                data.chequeDetails.chequeStatus.code = 'NEW';

                data.chequeDetails.remarks = '';

                if (data.chequeDetails.payerDetails == '') {
                    $('#txn-rcpt-payer').addClass('inp_error');
                    err++;
                }

                if ($('#txn-rcpt-chq-date').val() == '') {
                    $('#txn-rcpt-chq-date').addClass('inp_error');
                    err++;
                }

                if (data.chequeDetails.chequeNo == '') {
                    $('#txn-rcpt-chq-num').addClass('inp_error');
                    err++;
                }

                if (data.chequeDetails.bankDetails == '') {
                    $('#txn-rcpt-chq-bankname').addClass('inp_error');
                    err++;
                }

                if (data.chequeDetails.bankCity == '') {
                    $('#txn-rcpt-chq-city').addClass('inp_error');
                    err++;
                }
            }

            data.cargoBookings = [];
            $('#txn-rcpt-lr-table .lr-check:checked').each(function() {
                var lrcode = $(this).val();
                data.cargoBookings.push({ code: lrcode });
            });

            data.paymentTransactions = [];
            $('#txn-rcpt-up-inv-table .inv-check:checked').each(function() {
                var invCode = $(this).val();
                var paymentTransactions = {};

                paymentTransactions.code = invCode
                paymentTransactions.transactionAmount = $(this).data('balanceamount');
                paymentTransactions.additionalAttributes = {}

                var additionalAttributes = '';
                //working3
                // $.map(JSON.parse(localStorage.getItem('data')) || [], function(val, k) {
                //     if (k + 1 < JSON.parse(localStorage.getItem('data')).length) {
                //         additionalAttributes += val.code + ':' + val.amount + '|';
                //     } else {
                //         additionalAttributes += val.code + ':' + val.amount;
                //     }
                // })
                $.map(JSON.parse(localStorage.getItem('data')) || [], function(val, k) {
                    if (k + 1 < JSON.parse(localStorage.getItem('data')).length) {
                        additionalAttributes += val.code + ':' + val.amount + '|';
                    } else {
                        additionalAttributes += val.code + ':' + val.amount;
                    }
                });
                paymentTransactions.additionalAttributes.ADV = additionalAttributes;
                data.paymentTransactions.push(paymentTransactions);
            });

            data.amountReceivedDate = moment($('#txn-rcpt-rcvd-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');

            if ($('#txn-rcpt-rcvd-date').val() == '') {
                $('#txn-rcpt-rcvd-date').addClass('inp_error');
                err++;
            }

            data.remarks = $('#txn-rcpt-remarks').val();

            // var txn_amt = Number(data.transactionAmount) + Number(data.tdsAmount);
            // var tot_amt = $('#txn-rcpt-tot-amt').val();
            // if (data.transactionReceiptType.code != 'ADV' && (Number(txn_amt) > Number(tot_amt))) {
            //     $('#txn-rcpt-txn-amt').addClass('inp_error');
            //     $('#txn-rcpt-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            //     $('#txn-rcpt-action-state').html('The Net Amount Should Not Exceed Total Amount!!!');
            //     $('#txn-rcpt-action-state').show();
            //     return false;
            // }

            if (data.transactionReceiptType.code == 'LR' && $('#txn-rcpt-customer').val() != '') {
                if (data.cargoBookings.length == 0) {
                    $('#txn-rcpt-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#txn-rcpt-action-state').html('Please select atleast one LR!!!');
                    $('#txn-rcpt-action-state').show();
                    return false;
                }
            }

            if (data.transactionReceiptType.code == 'INV' && $('#txn-rcpt-vendor').val() != '') {
                if (data.paymentTransactions.length == 0) {
                    $('#txn-rcpt-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#txn-rcpt-action-state').html('Please select atleast one Invoice!!!');
                    $('#txn-rcpt-action-state').show();
                    return false;
                }
            }

            if (err > 0) {
                $('#txn-rcpt-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#txn-rcpt-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#txn-rcpt-action-state').show();
                return false;
            }

            $('#txn-rcpt-action-state').removeClass('alert-success, alert-danger, hide');
            $('#txn-rcpt-action-state').html(loading_popup).show();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'payment/update-transaction-receipt',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $('#txn-rcpt-action-state').removeClass('alert-danger');
                        $('#txn-rcpt-action-state').addClass('alert-success');
                        $('#txn-rcpt-action-state').html('Your request has been completed successfully');
                        window.setTimeout(function() {
                            closeTxnRcptDialog();
                            checkURL();
                            return;
                        }, 3000);
                    } else {
                        $('#txn-rcpt-action-state').addClass('alert-danger');
                        $('#txn-rcpt-action-state').html(response.errorDesc);
                    }
                }
            });
        }

        function calcReceiptTDSPercent(tdsPercentage) {
            var balanceAmount = Number($('#txn-rcpt-tot-amt').val()) || 0;
            var machineHandlingCharge = Number($('#txn-rcpt-mhc-amt').val()) || 0;
            var demurrageCharge = Number($('#txn-rcpt-dem-amt').val()) || 0;

            var netamount = balanceAmount + machineHandlingCharge + demurrageCharge;
            if (!netamount) {
                $('#txn-rcpt-tds-percent').val('0');
                $('#txn-rcpt-tds-amt').val('');
                return;
            }

            var tdsTax = Math.round(parseFloat(netamount) * tdsPercentage / 100);
            $('#txn-rcpt-tds-amt').val(tdsTax).data('amount', tdsTax).trigger('change');
            // $('#txn-rcpt-txn-amt').val(balanceAmount - tdsTax).trigger('change');
        }

        function showTransactionReceiptPdfDialog(code) {
            $('#cargo-invoice-iframe').html('');
            $('#cargo-invoice-pdf-dialog').css('background', '#fff');
            $('#cargo-invoice-pdf-dialog').removeClass('hide');
            $('#cargo-invoice-pdf-dialog').dialog({
                autoOpen: true,
                height: 700,
                width: 1100,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();

            var $iframe = $('<iframe />');
            $iframe.attr('src', base_url + 'payment/transaction-receipt-print?receiptCode=' + code);
            $iframe.attr('class', 'iframe-fullwidth iframe-loading-bg');
            $('#cargo-invoice-iframe').html($iframe);
        }

        function approveTransactionReceipt(code) {
            $('#update-transaction-receipt-status').css('background', '#fff');
            $('#update-transaction-receipt-status').removeClass('hide');
            $('#update-transaction-receipt-status').dialog({
                autoOpen: true,
                height: 300,
                width: 500,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar,#update_transaction_receiptaction_state').hide();
            $('#update-transaction-receipt-status .inp_error').removeClass('inp_error');
            $('#update-transaction-receipt-remarks, #hid_transaction_receipt_code').val('');

            if (code) {
                $('#hid_transaction_receipt_code').val(code);
            }
        }

        function closeUpdateTransactionReceipt() {
            $('#update-transaction-receipt-status').dialog('destroy');
            $('#update-transaction-receipt-status').hide();
        }

        function updateTransactionReceiptStatus() {
            var data = {};
            data.code = $('#hid_transaction_receipt_code').val();
            data.activeFlag = 1;
            data.receiptStatus = {};
            data.receiptStatus.code = 'APRD';
            data.remarks = $.trim($('#update-transaction-receipt-remarks').val());

            $('#update_transaction_receiptaction_state').removeClass('alert-success, alert-danger, hide');
            $('#update_transaction_receiptaction_state').html(loading_popup).show();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'payment/update-transaction-receipt-status',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $('#update_transaction_receiptaction_state').removeClass('alert-danger');
                        $('#update_transaction_receiptaction_state').addClass('alert-success');
                        $('#update_transaction_receiptaction_state').html(
                            'Your request has been completed successfully');
                        window.setTimeout(function() {
                            closeUpdateTransactionReceipt();
                            checkURL();
                            return;
                        }, 3000);
                    } else {
                        $('#update_transaction_receiptaction_state').addClass('alert-danger');
                        $('#update_transaction_receiptaction_state').html(response.errorDesc);
                    }
                }
            });
        }

        function rejectTransactionReceipt(code) {
            if (confirm('Are you sure, Do you want to reject this Transaction Receipt?')) {
                var data = {};
                data.code = code;
                data.activeFlag = 1;
                data.receiptStatus = {};
                data.receiptStatus.code = 'CNCL';

                var loading_overlay = iosOverlay({
                    text: 'Loading',
                    icon: 'fa fa-spinner fa-spin'
                });
                $.ajax({
                    type: 'POST',
                    dataType: 'json',
                    url: base_url + 'payment/update-transaction-receipt-status',
                    data: data,
                    success: function(response) {
                        if (response.status == 1) {
                            loading_overlay.update({
                                icon: 'fa fa-check',
                                text: 'Success!'
                            });
                        }
                        window.setTimeout(function() {
                            getTransactionReceipt();
                            loading_overlay.hide();
                        }, 2000);
                    }
                });
            }
        }

        function payUsingAdvanceDialog(code = "", amount = "0") {

            //working
            var vendorData = $('#txn-rcpt-vendor').data('vendorData');
            loadVendorPayment(vendorData.mobileNumber, code);
            $('#pay-using-advance-amt-dialog').css('background', '#fff');
            $('#pay-using-advance-amt-dialog').removeClass('hide');
            $('#pay-using-advance-amt-dialog').dialog({
                autoOpen: true,
                height: 500,
                width: 900,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();
            $('#pay-using-advance-amt-dialog .inp_error').removeClass('inp_error');
            $('#pay-using-advance-amt-action-state').removeClass('alert-success alert-danger').html('').hide();

            $('#transaction-receipt-inv-code, #transaction-receipt-inv-amount').val('');
            $('.adv-amount-deducted').val('').prop('disabled', true);
            $('#txn-rcpt-adv-pay-table .adv-pay-check').prop('disabled', false);
            $('#txn-rcpt-adv-pay-table .adv-pay-check').prop('checked', false).trigger('change');
            $('#invoice-amount').text('');
            // $('#save-advance-payment-btn').addClass('hide');

            if (_isdefined(code)) {
                $('#transaction-receipt-inv-code').val(code);
                $('#invoice-amount').text(Number(amount).toFixed(2));

                // var data = advancePaymentTransaction[code]; //recorrect
                // console.log(advancePaymentTransaction);  
                var data = code;
                $.map(data || [], function(val) {
                    $('#txn-rcpt-adv-pay-table tr[data-invoicecode=' + val.code + ']').find('.adv-pay-check')
                        .trigger('click');
                    $('#txn-rcpt-adv-pay-table tr[data-invoicecode=' + val.code + ']').find('.adv-amount-deducted')
                        .val(val.amount).trigger('change');
                });
                validateInvoiceAdvancePayment();
            }
        }

        function closePayUsingAdvanceDialog() {
            $('#pay-using-advance-amt-dialog').dialog('destroy');
            $('#pay-using-advance-amt-dialog').hide();
        }

        // function calculateTotalAdvanceAmount(ele) {
        //     let deted_amount=$('.adv-amount-deducted');
        //     let saveBtn=$('#save-advance-payment-btn');
        //     $('.adv-amount-deducted').prop('disabled', true);
        //     $('#save-advance-payment-btn').addClass('hide');
        //     $('#txn-rcpt-adv-pay-table .adv-pay-check:not(:checked)').prop('disabled', false);

        //     var invoiceAmount = Number($('#invoice-amount').text());

        //     var totalAmount = 0;
        //     var payMode = $('#txn-rcpt-txn-mode').val();
        //     $('#txn-rcpt-adv-pay-table .adv-pay-check:checked').each(function() {
        //         var balanceAmount = $(this).data('amount');
        //         totalAmount = totalAmount + balanceAmount;
        //     });

        //     var amount = $(ele).data('amount');
        //     $(ele).closest('tr').find('.adv-amount-deducted').val(amount).trigger('change');
        //     if (invoiceAmount < totalAmount) {
        //         $(ele).closest('tr').find('.adv-amount-deducted').prop('disabled', false);
        //         $('#txn-rcpt-adv-pay-table .adv-pay-check:not(:checked)').prop('disabled', true);
        //         $('.adv-amount-deducted').on('change input', function() {
        //             $('#save-advance-payment-btn').addClass('hide');
        //             var advanceAmount = 0;
        //             $('#txn-rcpt-adv-pay-table .adv-pay-check:checked').each(function() {
        //                 var amount = Number($(this).closest('tr').find('.adv-amount-deducted').val());
        //                 advanceAmount += amount;
        //             });
        //             if (advanceAmount == invoiceAmount) {
        //                 $('#save-advance-payment-btn').removeClass('hide');
        //             }
        //         });
        //     }
        // }  
        // function calculateTotalAdvanceAmount(ele) {
        //     let deductedAmountInputs = $('.adv-amount-deducted');
        //     let saveBtn = $('#save-advance-payment-btn');

        //     deductedAmountInputs.prop('disabled', true);
        //     saveBtn.addClass('hide');
        //     $('#txn-rcpt-adv-pay-table .adv-pay-check:not(:checked)').prop('disabled', false);

        //     var invoiceAmount = Number($('#invoice-amount').text());

        //     var totalAmount = 0;

        //     $('#txn-rcpt-adv-pay-table .adv-pay-check:checked').each(function() {
        //         var balanceAmount = $(this).data('amount');
        //         totalAmount += balanceAmount;
        //         console.log('total amount : '+tatalAmount+'<br>');

        //     });

        //     var amount = $(ele).data('amount');
        //     $(ele).closest('tr').find('.adv-amount-deducted').val(amount).trigger('change');

        //     if (invoiceAmount < totalAmount) {
        //         deductedAmountInputs.prop('disabled', false);
        //         $('#txn-rcpt-adv-pay-table .adv-pay-check:not(:checked)').prop('disabled', true);

        //         deductedAmountInputs.on('change input', function() {
        //             saveBtn.addClass('hide');
        //             var advanceAmount = 0;
        //             $('#txn-rcpt-adv-pay-table .adv-pay-check:checked').each(function() {
        //                 var amount = Number($(this).closest('tr').find('.adv-amount-deducted').val());
        //                 advanceAmount += amount;
        //             });
        //             if (advanceAmount === invoiceAmount) {
        //                 saveBtn.removeClass('hide');
        //             }
        //         });
        //     }
        // }

        function calculateTotalAdvanceAmount(ele, unicode) {
            let maxamount = $(this).data('amount');

            let deductedAmountInputs = $('.adv-amount-deducted');
            let deductedAmountvalue = $('.adv-amount-deducted' + unicode);
            var invoiceAmount = Number($('#invoice-amount').text());
            let saveBtn = $('#save-advance-payment-btn');
            deductedAmountvalue.prop('disabled', true);
            let checkboxrow = $('.adv-pay-check' + unicode);

            if (checkboxrow.prop('checked')) {
                deductedAmountvalue.prop('disabled', false);
            } else {
                deductedAmountvalue.val('');
                deductedAmountvalue.prop('disabled', true);
            }

        }

        function amountvalidate(inputElement) {
            var invoiceAmount = Number($('#invoice-amount').text());
            let saveBtn = $('#save-advance-payment-btn');

            let maximum = $(inputElement).attr('max');
            let amount = $(inputElement).val();
            if (Number(amount) > Number(maximum)) {
                $(inputElement).val('');
                alert(`Amount should be less than ${maximum}`);
            }

        }



        function payUsingAdvanceAmount() {

            var invoiceAmount = Number($('#invoice-amount').text());
            var totalAmount = 0;
            // checked feild valus 
            $('#txn-rcpt-adv-pay-table .adv-pay-check:checked').each(function() {
                var balanceAmount = parseFloat($(this).closest('tr').find('.adv-amount-deducted').val()) || 0;
                totalAmount += balanceAmount;
            });

            if (totalAmount == invoiceAmount) {
                // alert('success to pay');
                var invoiceCode = $('#transaction-receipt-inv-code').val();
                var totalInvoiceAmount = 0;

                // advancePaymentTransaction[invoiceCode] = [];
                $('#txn-rcpt-adv-pay-table .adv-pay-check:checked').each(function() {
                    var amount = Number($(this).closest('tr').find('.adv-amount-deducted').val());
                    var element = $(this).closest('tr').attr('data-rowcode');

                    $('.amount' + element).val(amount);
                    totalInvoiceAmount += amount;

                    let invoiceCode = $(this).val();
                    var invoice = {}
                    invoice.code = $(this).val();
                    invoice.amount = amount;

                    // storing builk datawith values in local storage

                    if (!localStorage.getItem('data')) {
                        localStorage.setItem('data', JSON.stringify([]));
                    }
                    let existingData = JSON.parse(localStorage.getItem('data'));
                    existingData.push(invoice);
                    localStorage.setItem('data', JSON.stringify(existingData));
                    let getResult = JSON.parse(localStorage.getItem('data')) || [];
                    // console.log(getResult);


                    // let getresult=localStorage.getItem('data');
                    //   advancePaymentTransaction[invoiceCode].push(invoice);  //recorrect 
                    // let makedPayment=invoice;
                    // console.log(invoice);

                    let previousAmount = localStorage.getItem(invoiceCode);
                    let finalAmount = previousAmount - amount;
                    localStorage.setItem(invoiceCode, finalAmount);
                });
                // console.log(advancePaymentTransaction);  

                var invoiceSelector = invoiceCode.replace(/[_\W]+/g, "-");
                $('#inv-' + invoiceSelector).find('#txn-rcpt-advance-amount').val(Number(totalInvoiceAmount));
                closePayUsingAdvanceDialog();
                validateInvoiceAdvancePayment();
            } else {
                // alert(totalAmount + 'Enter the amount should be: ' + invoiceAmount);
                alert(`Your Selected(₹${totalAmount}) Amount is not a Invoice amount(₹${invoiceAmount})`);
            }


        }

        function validateInvoiceAdvancePayment() {
            var validation = 1;
            $('#txn-rcpt-up-inv-table .inv-check:checked').each(function() {
                var invoiceAdvanceAmount = $(this).closest('tr').find('#txn-rcpt-advance-amount').val() || 0;
                if (invoiceAdvanceAmount <= 0) {
                    validation = 0;
                }
            });
            $('#txn-rcpt-form-buttons').addClass('hide');
            if (validation == 1) {
                $('#txn-rcpt-form-buttons').removeClass('hide');
            }
        }

        function loadVendorPayment(mobile, code = "") {
            var data = {};
            data.userCode = 'NA';
            data.mobileNumber = mobile;
            data.respcode = code;
            $('#vendor-advance-amount').html(loading_popup);
            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'payment/get-vendor-advance-payment',
                data: data,
                success: function(res) {
                    $('#vendor-advance-amount').html(res);
                }
            });
        }

        // get all localstorages

        function allStorage() {

            var values = [],
                keys = Object.keys(localStorage),
                i = keys.length;

            while (i--) {
                values.push(localStorage.getItem(keys[i]));
            }

            return values;
        }
        function getDemurrageDetails(){
            var damurageAmount = 0;
            var demInput = $('#txn-rcpt-dem-amt');
            demInputVal = demInput.val(damurageAmount);
            var cargoCodes = [];
            $('.lr-check:checked').each(function() {
                var cargoCode = $(this).val();
                cargoCodes.push(cargoCode);
            });

            if($('.lr-check:checked').length == 0){
                return;
            }

            $.ajax({
                type: "POST",
                url: base_url + 'payment/get-demurage-details',
                data:{ cargoCodes: cargoCodes },
                dataType: "json",
                success: function (response) {
                    damurageAmount = 0;
                    demInput.val(0);
                    if(response.status == 0){
                        return;
                    }
                    response.data.forEach(cargo => {
                        for (const cargoCode in cargo) {
                            if (Object.hasOwnProperty.call(cargo, cargoCode)) {
                                const cargoDetails = cargo[cargoCode];
                                damurageAmount += Number(cargoDetails.demurrageCharge);
                            }
                        }
                    });
                   demInput.val(damurageAmount);
                   calculateTotalAmount();
                }
            });
        }
       
    </script>
{/literal}