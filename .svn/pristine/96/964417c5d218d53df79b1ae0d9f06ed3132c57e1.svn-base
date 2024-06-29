<style>
    .pop-up-show::-webkit-scrollbar {
        display: none;
    }

    .link-color {
        color: white
    }
</style>

{if $credit_limit_higher == 1}
    <div class="showCreditLimit">
        <div class="panel panel-default col-between popup-split">
            <div class="panel-body">
                <div class="pop-up-show">
                    <div class="row text-center">
                        <div class="col-md-12">
                            <img src="assets/img/credit_Limit_decrease.webp" class="img-fluid" alt="Credit Limit Decrease"
                                width="215px" height="131px">
                        </div>
                    </div>
                    <div class="mt-3">
                        <h5 class="text-center mb-4"><b>Account Suspened</b></h5>
                        <br>
                        <div class="row">
                            <div class="col-md-10">
                                <span class="text-center text-danger"><b>Notice:</b> Your Account has been Suspened Please
                                    Make The Payment to Continue Your Transaction.</span>&nbsp;&nbsp;&nbsp;<img
                                    src="assets/img/red-alert-icon.svg" class="img-fluid float-right" alt="Alert Icon"
                                    width="15px" height="15px">
                            </div>
                            <br>
                        </div>
                        {if $BranchCloseDetails != null && $BranchCloseDetails != undefined}
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <h6 class="text-left"><b>User Balance:</b></h6>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="text-right"><b>{abs($userBalance)|default:"0"}</b></h6>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <h6 class="text-left"><b>Running Balance:</b></h6>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="text-right"><b>{abs($BranchCloseDetails->runningBalance)|default:"0"}</b></h6>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <h6 class="text-left"><b> Pending Receipt Count:</b></h6>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="text-right"><b>{abs($BranchCloseDetails->pendingAckReceiptCount)|default:"0"}</b>
                                    </h6>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <h6 class="text-left"><b> Pending Receipt Amount:</b></h6>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="text-right">
                                        <b>{abs($BranchCloseDetails->pendingAckReceiptAmount)|default:"0"}</b>
                                    </h6>
                                </div>
                            </div>
                            {if $BranchCloseDetails->lastClosingDetails != null}
                                <div class="row mt-3">
                                    <div class="col-md-7">
                                        <h6 class="text-right"><b>Last Branch Closing Receipt</b></h6>
                                    </div>
                                </div>
                                <table class="table table-bordered" style="width:100%;">
                                    <thead>
                                        <tr class="success">
                                            <th width="100px">From</th>
                                            <th width="100px">To</th>
                                            <th>User Name</th>
                                            <th>Booked Amt</th>
                                            <th>Delivery Amt</th>
                                            <th>Commision Amt </th>
                                            <th>Income Amt</th>
                                            <th>Expense Amt</th>
                                            <th>Revert Amt</th>
                                            <th>openingBalance</th>
                                            <th>PaymentAmt</th>
                                            <th>settlementAmt</th>
                                            <th>paid Amt</th>
                                        <tr>
                                    </thead>
                                    <tbody>
                                        <td>{$BranchCloseDetails->lastClosingDetails->fromDate|date_format}</td>
                                        <td>{$BranchCloseDetails->lastClosingDetails->toDate|date_format}</td>
                                        <td>{$BranchCloseDetails->lastClosingDetails->user->name}</td>
                                        <td>{$BranchCloseDetails->lastClosingDetails->bookedAmount|inr_format}</td>
                                        <td>{$BranchCloseDetails->lastClosingDetails->deliveryAmount|inr_format}</td>
                                        <td>{$BranchCloseDetails->lastClosingDetails->commissiontAmount|inr_format}</td>
                                        <td>{$BranchCloseDetails->lastClosingDetails->incomeAmount|inr_format}</td>
                                        <td>{$BranchCloseDetails->lastClosingDetails->expenseAmount|inr_format}</td>
                                        <td>{$BranchCloseDetails->lastClosingDetails->revertAmount|inr_format}</td>
                                        <td>{$BranchCloseDetails->lastClosingDetails->openingBalance|inr_format}</td>
                                        <td>{$BranchCloseDetails->lastClosingDetails->paymentAmount|inr_format}</td>
                                        <td>{$BranchCloseDetails->lastClosingDetails->settlementAmount|inr_format}</td>
                                        <td>{$BranchCloseDetails->lastClosingDetails->paidAmount|inr_format}</td>
                                    </tbody>
                                </table>
                            {/if}
                        {else}
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <h6 class="text-left"><b>Payment Due:</b></h6>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="text-right"><b>{abs($dueAmount)|default:"0"}</b></h6>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <h6 class="text-left"><b>Total pending Amount:</b></h6>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="text-right"><b>{$totalPendng|default:"0"}</b></h6>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <h6 class="text-left"><b>Last Payment Date:</b></h6>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="text-right"><b>
                                            {if $getLastPaymentDate}
                                                {$getLastPaymentDate|date_format}
                                            {else}
                                                No payment date available
                                            {/if}
                                        </b></h6>
                                </div>
                            </div>

                        {/if}
                        <div class="mt-4">
                            <p class="text-center"><b>Contact Customer Support for Assistance:</b></p>
                            <p class="text-center"><b>cargo@ezeeinfosolutions.com</b></p>
                        </div>
                    </div>
                    {if $BranchCloseDetails != null && $BranchCloseDetails != undefined}
                        <div class="mt-3 text-right p-3">
                            <button class="btn btn-primary" id="BranchClose">Click here to make a Branch Close</button>
                        </div>
                    {else}
                        <div class="mt-3 text-right p-3">
                            <button class="btn btn-primary" id="paymentReceipt">Click here to make a payment</button>
                        </div>
                    {/if}
                    <br>
                    <div class="mt-3 text-right p-3">
                        <button class="btn btn-danger"><a href="{$base_url}user/logout" class="link-color"><i
                                    class="fa fa-power-off"></i>&nbsp;&nbsp;Log out</a></button>
                    </div>
           
                </div>
            </div>
        </div>
    </div>
{else}
    <div class="brand_top">
        <h3>Dashboard</h3>
        <div class="row">
            <div class="col-md-12 note text-muted noprint">
                <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
                F1 - Booking, F3 - Loading, F5 - Unloading, F7 - Delivery , ~ - Dashboard
            </div>
        </div>
    </div>

    <div id="main_wrapper">
        <div class="page_content">
            <div id="container-fluid">
                <div class="">
                    <div id="contents" class="col-lg-12">
                        <!-- PAGE HEADER-->
                        <div class="row">

                            <div class="dash_full2">
                                {if $action_rights['ENABLE-SUBSCRIPTION']==1}
                                    <div class="row" style="padding-top:0px">
                                        <div id="due-panel" class="hide">
                                            <div class="text-center well well-sm" style="background-color: #eeefb5;">
                                                <span class="" id="due-text"></span>
                                            </div>
                                        </div>
                                    </div>
                                {/if}

                                <div class="row" style="padding-top:18px">

                                    <div class="col-md-5">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="row">

                                                    {if $is_mobile_verified==0}
                                                        <div class="col-md-12 profile-progress">
                                                            <div class="d-inline-flex align-items-center">
                                                                <h5>Welcome {$usr_login_name}</h5>
                                                            </div>
                                                            <div>
                                                                Mobile number not verified. <a href="#profile/edit-profile"
                                                                    class="btn btn-xs btn-warning">Verify Now </a>
                                                            </div>
                                                        </div>
                                                    {/if}

                                                    <div class="dash-tile-links">
                                                        {if $menu_links['cargo/booking']}
                                                            <div class="dash-tile-link col-lg-3 col-xs-12 col-sm-6">
                                                                <div class="panel panel-default">
                                                                    <a href="#cargo/booking" class="quick_links"
                                                                        id="dashboard-booking-shortcut">
                                                                        <div class="stat_box stat_up1">
                                                                            <div class="stat_ico"></div>
                                                                            <div class="stat_content">
                                                                                <span class="stat_count">
                                                                                    <div class="stat_ico color_f"><i
                                                                                            class="fa fa-fw fa-shopping-cart"></i>
                                                                                    </div>
                                                                                </span>
                                                                            </div>
                                                                            <div class="stat_content pd_16 text-align-center">
                                                                                <span class="stat_name bold">New Booking</span>
                                                                            </div>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        {/if}

                                                        {* {if $menu_links['cargo/booking']} *}
                                                            <div class="dash-tile-link col-lg-3 col-xs-12 col-sm-6">
                                                                <div class="panel panel-default">
                                                                    <a href="#prebooking/pre-booking-history"
                                                                        class="quick_links">
                                                                        <div class="stat_box stat_up1">
                                                                            <div class="stat_ico"></div>
                                                                            <div class="stat_content">
                                                                                <span class="stat_count">
                                                                                    <div class="stat_ico color_c"><i
                                                                                            class="fa fa-cart-plus"></i></div>
                                                                                </span>
                                                                            </div>
                                                                            <div class="stat_content pd_16 text-align-center">
                                                                                <span class="stat_name bold">Pre Booking</span>
                                                                            </div>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        {* {/if} *}

                                                        {if $menu_links['cargo/ogpl']}
                                                            <div class="dash-tile-link col-lg-3 col-xs-12 col-sm-6">
                                                                <div class="panel panel-default">
                                                                    <a href="#cargo/ogpl" class="quick_links"
                                                                        id="dashboard-load-shortcut">
                                                                        <div class="stat_box stat_up1">
                                                                            <div class="stat_ico"></div>
                                                                            <div class="stat_content">
                                                                                <span class="stat_count">
                                                                                    <div class="stat_ico color_d"><i
                                                                                            class="fa fa-fw fa-level-up"></i>
                                                                                    </div>
                                                                                </span>
                                                                            </div>
                                                                            <div class="stat_content pd_16 text-align-center">
                                                                                <span class="stat_name bold">Load</span>
                                                                            </div>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        {/if}

                                                        {if $menu_links['cargo/ogpl-unload']}
                                                            <div class="dash-tile-link col-lg-3 col-xs-12 col-sm-6">
                                                                <div class="panel panel-default">
                                                                    <a href="#cargo/ogpl-unload" class="quick_links"
                                                                        id="dashboard-unload-shortcut">
                                                                        <div class="stat_box stat_up1">
                                                                            <div class="stat_ico"></div>
                                                                            <div class="stat_content">
                                                                                <span class="stat_count">
                                                                                    <div class="stat_ico color_g"><i
                                                                                            class="fa fa-fw fa-level-down"></i>
                                                                                    </div>
                                                                                </span>
                                                                            </div>
                                                                            <div class="stat_content pd_16 text-align-center">
                                                                                <span class="stat_name bold">Unload</span>
                                                                            </div>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        {/if}

                                                        {if $menu_links['cargo/deliver-cargo']}
                                                            <div class="dash-tile-link col-lg-3 col-xs-12 col-sm-6">
                                                                <div class="panel panel-default">
                                                                    <a href="#cargo/deliver-cargo" class="quick_links"
                                                                        id="dashboard-delivery-shortcut">
                                                                        <div class="stat_box stat_up1">
                                                                            <div class="stat_ico"></div>
                                                                            <div class="stat_content">
                                                                                <span class="stat_count">
                                                                                    <div class="stat_ico color_i"><i
                                                                                            class="fa fa-fw fa-suitcase"></i>
                                                                                    </div>
                                                                                </span>
                                                                            </div>
                                                                            <div class="stat_content pd_16 text-align-center">
                                                                                <span class="stat_name bold">Deliver</span>
                                                                            </div>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        {/if}

                                                        {if $menu_links['cargo/income-expense']}
                                                            <div class="dash-tile-link col-lg-3 col-xs-12 col-sm-6">
                                                                <div class="panel panel-default">
                                                                    <a href="#cargo/income-expense" class="quick_links">
                                                                        <div class="stat_box stat_up1">
                                                                            <div class="stat_ico"></div>
                                                                            <div class="stat_content">
                                                                                <span class="stat_count">
                                                                                    <div class="stat_ico color_e"><i
                                                                                            class="fa fa-fw fa-credit-card"></i>
                                                                                    </div>
                                                                                </span>
                                                                            </div>
                                                                            <div class="stat_content pd_16 text-align-center">
                                                                                <span class="stat_name bold">Indents</span>
                                                                            </div>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        {/if}
                                                    </div>

                                                    {if $action_rights['DASH-VEND-SUMM']==1 ||
                                                                                    $action_rights['DASH-BRCH-SUMM']==1 ||
                                                                                    $action_rights['DASH-GODW-SUMM']==1 ||
                                                                                    $cargo_setting->demurrageProcess->code != 'NOTAVL'}
                                                    <div class="clear_fix_both"></div> <br>
                                                {/if}

                                                <div class="dash-tile-links">
                                                    {if $action_rights['DASH-VEND-SUMM']==1}
                                                        <div class="dash-tile-link col-lg-3 col-xs-12 col-sm-6">
                                                            <div class="panel panel-default">
                                                                <a href="javascript:;" class="quick_links"
                                                                    onclick="vendorBookingSummary()">
                                                                    <div class="stat_box stat_up1">
                                                                        <div class="stat_ico"></div>
                                                                        <div class="stat_content">
                                                                            <span class="stat_count">
                                                                                <div class="stat_ico color_i">V</div>
                                                                            </span>
                                                                        </div>
                                                                        <div class="stat_content pd_16 text-align-center">
                                                                            <span class="stat_name bold">Vendor Due</span>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    {/if}
                                                    {if $action_rights['DASH-BRCH-SUMM']==1}
                                                        <div class="dash-tile-link col-lg-3 col-xs-12 col-sm-6">
                                                            <div class="panel panel-default">
                                                                <a href="javascript:;" class="quick_links"
                                                                    onclick="branchBookingSummary()">
                                                                    <div class="stat_box stat_up1">
                                                                        <div class="stat_ico"></div>
                                                                        <div class="stat_content">
                                                                            <span class="stat_count">
                                                                                <div class="stat_ico color_d">B</div>
                                                                            </span>
                                                                        </div>
                                                                        <div class="stat_content pd_16 text-align-center">
                                                                            <span class="stat_name bold">Branch Sales</span>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    {/if}
                                                    {if $action_rights['DASH-GODW-SUMM']==1}
                                                        <div class="dash-tile-link col-lg-3 col-xs-12 col-sm-6">
                                                            <div class="panel panel-default">
                                                                <a href="javascript:;" class="quick_links"
                                                                    onclick="godownBookingSummary()">
                                                                    <div class="stat_box stat_up1">
                                                                        <div class="stat_ico"></div>
                                                                        <div class="stat_content">
                                                                            <span class="stat_count">
                                                                                <div class="stat_ico color_g">G</div>
                                                                            </span>
                                                                        </div>
                                                                        <div class="stat_content pd_16 text-align-center">
                                                                            <span class="stat_name bold">Godown Items</span>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    {/if}
                                                    {if $cargo_setting->demurrageProcess->code != 'NOTAVL'}
                                                        <div class="dash-tile-link col-lg-3 col-xs-12 col-sm-6">
                                                            <div class="panel panel-default">
                                                                <a href="javascript:;" class="quick_links"
                                                                    onclick="demurrageSummary()">
                                                                    <div class="stat_box stat_up1">
                                                                        <div class="stat_ico"></div>
                                                                        <div class="stat_content">
                                                                            <span class="stat_count">
                                                                                <div class="stat_ico color_f">D</div>
                                                                            </span>
                                                                        </div>
                                                                        <div class="stat_content pd_16 text-align-center">
                                                                            <span class="stat_name bold">Demurrage
                                                                                Summary</span>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    {/if}
                                                    {if  $action_rights['DASH-ZN-BK-SUM']==1}
                                                        <div class="dash-tile-link col-lg-3 col-xs-12 col-sm-6">
                                                            <div class="panel panel-default">
                                                                <a href="#report/zone-report-v1" class="quick_links"
                                                                    title="Zone Report">
                                                                    <div class="stat_box stat_up1">
                                                                        <div class="stat_ico"></div>
                                                                        <div class="stat_content">
                                                                            <span class="stat_count">
                                                                                <div class="stat_ico color_i"><i
                                                                                        class="fa fa-briefcase"
                                                                                        aria-hidden="true"></i></div>
                                                                            </span>
                                                                        </div>
                                                                        <div class="stat_content pd_16 text-align-center">
                                                                            <span class="stat_name bold">Zone Booking</span>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    {/if}
                                                </div>

                                                <div class="clear_fix_both"></div> <br>

                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="heading_b"><i class="fa fa-search"></i>
                                                            {lang('dash_find_lr')}</div>
                                                        <form class="form-inline" role="form" onsubmit="return false;">
                                                            <div class="col-md-9">
                                                                <div class="form-group">
                                                                    <div class="input-group">
                                                                        <span class="input-group-addon"><i
                                                                                class="fa fa-search"></i></span>
                                                                        <input type="text"
                                                                            class="form-control sdate capitalize"
                                                                            id="quick-find-term"
                                                                            placeholder="{lang('lr')} Number / Mobile Number">
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="">
                                                                <button type="button" class="btn btn-success"
                                                                    onclick="initQuickFindLR();">Find</button> &nbsp;
                                                            </div>
                                                        </form>

                                                        <div class="col-md-12 note noprint">
                                                            <i class="fa fa-info-circle" data-toggle="tooltip"
                                                                data-title="Notes" data-original-title="" title=""></i>
                                                            Type {lang('lr')} mobile number and find {lang('lr')}
                                                        </div>
                                                        <div class="clear_fix_both"></div> <br>
                                                    </div>
                                                </div>
                                            </div>

                                            <br>
                                            <div id="dash-advertisement"></div>
                                        </div>
                                    </div>

                                    {if $action_rights['DASH-BNCH-OVERVIEW'] != 1}
                                        {if $action_rights['CARGO-SALES-SNAPSHT']==1}
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="row">
                                                            <div class="heading_b col-md-12">
                                                                <div class=""><i class="ion-pie-graph"></i> Sales Summary by
                                                                    Payment Type <span class="f12 snapshot-last-updated-at"
                                                                        id="summary_type_at"></span></div>
                                                                <div class="pull-right">
                                                                    <div class="btn-group btn-group-toggle btn-group-xs"
                                                                        id="Amt-type" data-toggle="buttons">
                                                                        <label class="btn" title="Net Amount">
                                                                            <input type="radio" name="exptyperadio" id="opt1"
                                                                                checked> <i class="fa fa-bar-chart"></i>
                                                                        </label>
                                                                        <label class="btn" title="Freight Amount">
                                                                            <input type="radio" name="exptyperadio" id="opt2">
                                                                            <i class="fa fa-list-ul"></i>
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="NetAmount" id="NetAmount">
                                                            <div class="f12">
                                                                <span
                                                                    class="pay-sales-summary-date col-md-12 text-center pb10"></span>
                                                            </div>

                                                            <div id="paytypecounts"
                                                                style="padding-left: 10px; padding-right: 10px; min-height: 58px;">
                                                                <div class="row live-cells"></div>
                                                            </div>
                                                            <br>
                                                            <div id="summary_ptype" style="height: 260px;"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        {/if}
                                    {/if}
                                </div>

                                <div class="col-md-7">
                                    <div id="dash-announcement"></div>
                                    {if $action_rights['DASH-BNCH-OVERVIEW']==1}
                                        <div class="panel panel-default">
                                            <div class="heading_b"><i class="fa fa-line-chart"></i> Branch Performance <span
                                                    class="f12 snapshot-last-updated-at" id="brn-perf-as-on-time"></span>
                                            </div>
                                            <div class="dash-tables" style="max-height: none;">
                                                <div id="dash-brn-perf"></div>
                                            </div>
                                        </div>
                                    </div>
                                {else}
                                    {if $action_rights['CARGO-SALES-SNAPSHT']==1}
                                        <div class="row ">
                                            <div class="col-md-12">
                                                <div class="panel panel-default">
                                                    <div class="heading_b">

                                                        <div class="pull-right">
                                                            <div class="btn-group btn-group-toggle btn-group-xs" id="snapopt"
                                                                data-toggle="buttons">
                                                                <label class="btn" title="Graph View">
                                                                    <input type="radio" name="snapoptions" id="option1"
                                                                        value="pie"> <i class="fa fa-bar-chart"></i>
                                                                </label>
                                                                <label class="btn" title="Table View">
                                                                    <input type="radio" name="snapoptions" id="option2"
                                                                        value="tbl"> <i class="fa fa-list-ul"></i>
                                                                </label>
                                                            </div>
                                                        </div>

                                                        <div class="pull-left"><i class="glyphicon glyphicon-stats"></i> Sales
                                                            Summary by Branch
                                                            <span class="f12 snapshot-last-updated-at"
                                                                id="summary_branch_at"></span>
                                                        </div>
                                                        <div class="">&nbsp;</div>
                                                    </div>

                                                    <div class="f12">
                                                        <span class="sales-summary-date pb10"
                                                            style="display: table;margin: 0 auto;"></span>
                                                    </div>
                                                    <br>
                                                    <div id="summary_pie" style="height: 448px;" class="hide"></div>
                                                    <div id="summary_table" style="min-height: 448px;" class="hide"></div>
                                                </div>
                                            </div>
                                        </div>
                                    {/if}
                                {/if}
                            </div>

                            {if $action_rights['CARGO-SALES-SNAPSHT']==1}
                                <div class="clear_fix_both"></div> <br>
                                <div class="row">
                                    <div class="col-md-12" id="dashboard-pending-section" style="margin-bottom: 10px;">
                                        <div class="col-md-3">
                                            <div class="panel panel-default">
                                                <div class="heading_b"><i class="fa fa-level-down"></i>
                                                    {lang('branch_stock_status_INW')} <span
                                                        class="f12 snapshot-last-updated-at"></span></div>
                                                <div class="dash-tables">
                                                    <table class="table" id="dash-pending-inwards">
                                                        <thead class="bold">
                                                            <tr>
                                                                <td class="sticky-row-top">Branch</td>
                                                                <td class="sticky-row-top" align="right">{lang('lr')} Count
                                                                </td>
                                                                <td class="sticky-row-top" align="right">Qty</td>
                                                            </tr>
                                                        </thead>
                                                        <tbody></tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <br>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="panel panel-default">
                                                <div class="heading_b"><i class="fa fa-truck"></i>
                                                    {lang('branch_stock_status_CB')} <span
                                                        class="f12 snapshot-last-updated-at"></span></div>
                                                <div class="dash-tables">
                                                    <table class="table" id="dash-to-load">
                                                        <thead class="bold">
                                                            <tr>
                                                                <td class="sticky-row-top">Branch</td>
                                                                <td class="sticky-row-top" align="right">{lang('lr')} Count
                                                                </td>
                                                                <td class="sticky-row-top" align="right">Qty</td>
                                                            </tr>
                                                        </thead>
                                                        <tbody></tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <br>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="panel panel-default">
                                                <div class="heading_b"><i class="fa fa-level-down"></i>
                                                    {lang('branch_stock_status_CL')} <span
                                                        class="f12 snapshot-last-updated-at"></span></div>
                                                <div class="dash-tables">
                                                    <table class="table" id="dash-to-unload">
                                                        <thead class="bold">
                                                            <tr>
                                                                <td class="sticky-row-top">Branch</td>
                                                                <td class="sticky-row-top" align="right">{lang('lr')} Count
                                                                </td>
                                                                <td class="sticky-row-top" align="right">Qty</td>
                                                            </tr>
                                                        </thead>
                                                        <tbody></tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <br>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="panel panel-default">
                                                <div class="heading_b"><i class="fa fa-suitcase"></i>
                                                    {lang('branch_stock_status_CUL')} <span
                                                        class="f12 snapshot-last-updated-at"></span></div>
                                                <div class="dash-tables">
                                                    <table class="table" id="dash-to-delivery">
                                                        <thead class="bold">
                                                            <tr>
                                                                <td class="sticky-row-top">Branch</td>
                                                                <td class="sticky-row-top" align="right">{lang('lr')} Count
                                                                </td>
                                                                <td class="sticky-row-top" align="right">Qty</td>
                                                            </tr>
                                                        </thead>
                                                        <tbody></tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <br>
                                        </div>
                                        <div class="col-md-3" id="dash-lr-missing-section">
                                            <div class="panel panel-default">
                                                <div class="heading_b"><i class="fa fa-search-minus"></i>
                                                    {lang('branch_stock_status_CMS')} <span
                                                        class="f12 snapshot-last-updated-at"></span></div>
                                                <div class="dash-tables">
                                                    <table class="table" id="dash-lr-missing">
                                                        <thead class="bold">
                                                            <tr>
                                                                <td class="sticky-row-top">Branch</td>
                                                                <td class="sticky-row-top" align="right">{lang('lr')} Count
                                                                </td>
                                                                <td class="sticky-row-top" align="right">Qty</td>
                                                            </tr>
                                                        </thead>
                                                        <tbody></tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <br>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="col-md-3 hide">
                                            <div class="panel panel-default" id="dash-demurrage-panel">
                                                <div class="heading_b"><i class="fa fa-history"></i> Demurrage <span
                                                        class="f12 snapshot-last-updated-at"></span></div>
                                                <div class="dash-tables">
                                                    <table class="table" id="dash-demurrage">
                                                        <thead class="bold">
                                                            <tr>
                                                                <td class="sticky-row-top">Branch</td>
                                                                <td class="sticky-row-top" align="right">{lang('lr')} Count
                                                                </td>
                                                                <td class="sticky-row-top" align="right">Qty</td>
                                                            </tr>
                                                        </thead>
                                                        <tbody></tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <br>
                                        </div>
                                        {if $cargo_setting->userAccountModel->code == 'BRN'}
                                            {if $action_rights['HID-DASH-USR-BAL']!=1}
                                                <div class="col-md-5">
                                                    <div class="panel panel-default">
                                                        <div class="heading_b"><i class="fa fa-user"></i>
                                                            {lang('dash_panel_branch_balance')} <span class="f12"
                                                                id="branchbal-last-updated-at"></span></div>
                                                        <div class="dash-tables" id="dash-branch-bal"></div>
                                                    </div>
                                                    <br>
                                                </div>
                                            {/if}
                                        {else}
                                            {if $action_rights['HID-DASH-USR-BAL']!=1}
                                                <div class="col-md-5">
                                                    <div class="panel panel-default">
                                                        <div class="heading_b">
                                                            <div class="pull-right">
                                                                <div class="btn-group btn-group-toggle btn-group-xs" id="useropt"
                                                                    data-toggle="buttons">
                                                                    <label class="btn" title="Users">
                                                                        <input type="radio" name="useroptions" id="user_bal_user"
                                                                            value="user"> User
                                                                    </label>
                                                                    <label class="btn" title="Vendors">
                                                                        <input type="radio" name="useroptions" id="user_bal_vendor"
                                                                            value="vendor"> Vendor
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <i class="fa fa-user"></i> {lang('dash_panel_user_balance')} <span
                                                                class="f12" id="userbal-last-updated-at"></span>
                                                        </div>
                                                        <div class="dash-tables" id="dash-user-bal"></div>
                                                        <div class="dash-tables hide" id="dash-vendor-bal"></div>
                                                    </div>
                                                    <br>
                                                </div>
                                            {/if}
                                        {/if}

                                        {if $action_rights['DASH-PEND-DAYCLOSE'] == 1}
                                            <div class="col-md-7">
                                                <div class="panel panel-default" id="dash-dayclosing-panel">
                                                    <div class="heading_b"><i class="fa fa-history"></i> Pending Day Closing
                                                        <span class="f12 snapshot-last-updated-at"></span> &nbsp;<a
                                                            href="#branch/branch-receipt" class="small" target="_blank"><i
                                                                class="fa fa-external-link" aria-hidden="true"></i></a>
                                                    </div>
                                                    <div class="dash-tables" id="dash-dayclosing-cont"></div>
                                                </div>
                                                <br>
                                            </div>
                                        {/if}

                                        {if $action_rights['DASH-PEND-EXPENSE'] == 1}
                                            <div class="col-md-6">
                                                <div class="panel panel-default" id="dash-expense-panel">
                                                    <div class="heading_b"><i class="fa fa-history"></i> Pending Income Expenses
                                                        <span class="f12 last-updated-at"></span> &nbsp;<a
                                                            href="#payment/manage-expense" class="small" target="_blank"><i
                                                                class="fa fa-external-link" aria-hidden="true"></i></a>
                                                    </div>
                                                    <div class="dash-tables" id="dash-expense-cont"></div>
                                                </div>
                                                <br>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            {/if}
                        </div>
                    </div>
                    <!--row end-->
                </div>
                <!--content end-->
            </div>
        </div>

    </div>
    <div style="height:0px;" class="clear_fix_both"></div>
</div>
</div>
{/if}
<!-- Dashboard Report Popup -->
<div id="dashboard-report-dialog" class="dialog-content-page" style="display: none;">

</div>

<!-- Dashboard Report Popup -->
<div id="dashboard-lr-list-dialog" class="dialog-content-page" style="display: none;">

</div>

<!-- Dashboard Summary Popup -->
<div id="dashboard-summary-dialog" class="dialog-content-page" style="display: none;">

</div>

<script type="text/html" id="subscription-alert-popover-content">
    <div>
        <div id="alert-pop-close-btn">
            <a href="javascript:;" class="close-popver"><i class="fa fa-times"></i></a>
        </div>
        <h3>Bill Due by <span id="invoiceDueDay">{$billingStatus->invoiceDueDay}</span>
            Days
        </h3>
        <p>Pay Immediately to avoid suspension of services.</p>
        <div id="alert-pop-pay-btn">
            <a href="#admin/subscription" class="btn btn-primary ">Pay</a>
        </div>
    </div>
</script>

<script type="text/template" id="tmpl_sshottable">
    <div style="max-height: 430px; overflow: auto">
        <table class="table table-hover" style="width:90%;" align="center">
            <thead>
                <tr class="">
                    <th class="sticky-row-top bold text-left" >Branch</th>
                    <th class="sticky-row-top bold text-right" >Freight</th>
                </tr>
            </thead>
            <tbody id="sstblbody">
            </tbody>
        </table>
    </div>
</script>
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
                        <label for="receipt-user" class="req d-inline-block">Receipt to User</label> <i
                            class="fa fa-info-circle" data-toggle="tooltip" title="Users with Post Paid Payment Type"></i>
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
                        <label for="receipt-user-vendor" class="req d-inline-block">Receipt to Vendor User</label> <i
                            class="fa fa-info-circle" data-toggle="tooltip" title="Users with Unlimited Payment Type"></i>
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
                    <input placeholder="Date Received" id="receipt-received" name="Rdate" readonly="true"
                        class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>

            <div class="col-lg-4 p_l_n">
                <div>
                    <label for="receipt-amount" class="req">Amount</label>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-rupee"></i></span>
                        <input type="number" placeholder="Amount" id="receipt-amount" name="amt"
                            class="form-control no-spin">
                    </div>
                </div>
            </div>

            <div class="clear_fix_both"></div>
            <br />

            <div class="col-lg-12 p_l_n">
                <div>
                    <label for="receipt-remarks">Remarks</label>
                    <textarea id="receipt-remarks" placeholder="Enter your remarks here..." style="resize:none"
                        class="form-control" rows="2" cols="10" name="remark" id="remark" maxlength="120"></textarea>
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
                <li><b>Credit Note:</b> Give credit to the user's balance. Ex : Incentives, Extra Commissions etc. It's
                    not calculated into income receipt.</li>
                <li><b>Debit Note:</b> Debits from user's balance.</li>
            </ul>
        </div>
    </div>
    <br />
    <div class="clear_fix_both">
        <div class="alert fl suc_cre" style="display: none;" id="receipt-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <button class="btn btn-success" type="button" id="saveReceipt">Save</button>
            <button class="btn btn-default" type="button" id="clearReceipt">Cancel</button>
        </div>
    </div>
</div>

<script>
    var dues = {$dues|json_encode};
    var subscriptionAlert = {$subscription_alert|json_encode};
    var keyRestriction = {$credit_limit_higher|json_encode}
    var due_amount = {$dueAmount|json_encode}
    var getBranchCloseDetails = {$BranchCloseDetails|json_encode}
    var baseUrl = {$base_url|json_encode}
    due_amount = Math.abs(due_amount);

    if (due_amount) {
        $("#receipt-amount").val(due_amount.toFixed(2));
    } else {
        due_amount = 0;
        $("#receipt-amount").val(due_amount.toFixed(2));
    }

    // {if $action_rights['PYRCT-ALL-USER']>0}
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


    
    $('#receipt-received').datepicker({
        todayHighlight: true,
        startDate: '-3m',
        endDate: '0d',
        format: 'yyyy-mm-dd',
        autoclose: true
    });
    var fileupload = new fileUpload('#ie-fileupload');

    // if (keyRestriction == 1) {
    //     document.addEventListener('keydown', function(event) {
    //         if (event.keyCode == 123 || // F12 key
    //             (event.ctrlKey && event.shiftKey && event.keyCode == 73) || // Ctrl+Shift+I
    //             (event.ctrlKey && event.keyCode == 85) || // Ctrl+U
    //             (event.keyCode == 27) ||
    //             event.ctrlKey && event.shiftKey && event.keyCode == 67) { // Escape key
    //             event.preventDefault();
    //         }
    //     }, false);

    //     if (document.addEventListener) {
    //         document.addEventListener('contextmenu', function(e) {
    //             e.preventDefault();
    //         }, false);
    //     } else {
    //         document.attachEvent('oncontextmenu', function() {
    //             window.event.returnValue = false;
    //         });
    //     }
    // }

    $(document).ready(function() {
        let popHtml = $('.pop-up-show');
        if (Number(dues.due_amount) > 0) {
            var html = "";
            if (dues.is_over_due < 0) { // due approaching
                html = "Your invoice of <span class='bold'>Rs." + dues.due_amount +
                    "</span> generated is due in " + dues.due_days +
                    " DAYS. Do make the payment to avoid service / feature disconnection automatically.";
            } else if (dues.is_over_due == 0) { // Today Due
                html = "Your invoice of <span class='bold'>Rs." + dues.due_amount +
                    "</span> generated is due in by <span class='bold'>TODAY</span>. Make the payment now to avoid service / feature disconnection.";
            } else if (dues.is_over_due > 0) { // Overdue
                html =
                    "<span class='text-danger'>You are running late, invoice payment of <span class='bold'>Rs." +
                    dues.due_amount + " OVERDUE by " + dues.due_days +
                    " DAYS</span>. To avoid service / feature disconnection make the payment now.</span>";
            }

            if (html != "") {
                html += "&nbsp; <a href='#admin/subscription' id='topviewinvoice'>View Invoices</a>"
            }

            $('#due-text').html(html);

            $('#topviewinvoice').bind('click', function() {
                ga_track_event('Subscription : View Invoice Link', ns_username, '');
            });

            if (menu_permission['ENABLE-SUBSCRIPTION'] == 1) {
                window.setTimeout(function() {
                    $('#due-panel').removeClass('hide');
                }, 2000);
            }
        }

        if (getBranchCloseDetails) {
            $(popHtml).dialog({
                autoOpen: true,
                height: 700,
                width: 1000,
                modal: true,
                resizable: false,
                closeOnEscape: false
            });

        } else {
            $(popHtml).dialog({
                autoOpen: true,
                height: 500,
                width: 770,
                modal: true,
                resizable: false,
                closeOnEscape: false
            });
        }
        $("#quick-find-term").bind("input", function(e) {
            this.value = this.value.replace(/[^0-9a-zA-Z-]+/g, '').toUpperCase();
        });

        $("body").keydown(function(e) {
            if ($('#dashboard-booking-shortcut') && $('#dashboard-booking-shortcut')[0] || $(
                    '#dashboard-load-shortcut') && $('#dashboard-load-shortcut')[0] || $(
                    '#dashboard-unload-shortcut') && $('#dashboard-unload-shortcut')[0] || $(
                    '#dashboard-delivery-shortcut') && $('#dashboard-delivery-shortcut')[0]) {
                if ($.inArray((e.keyCode || e.which), [112, 114, 116, 118]) != -1) {
                    e.preventDefault();
                }
                var keyCode = e.keyCode || e.which;
                if (keyCode == '112' && $('#dashboard-booking-shortcut')) { // F1
                    $('#dashboard-booking-shortcut')[0].click();
                } else if (keyCode == '114' && $('#dashboard-load-shortcut')) { // F3
                    $('#dashboard-load-shortcut')[0].click();
                } else if (keyCode == '116' && $('#dashboard-unload-shortcut')) { // F5
                    $('#dashboard-unload-shortcut')[0].click();
                } else if (keyCode == '118' && $('#dashboard-delivery-shortcut')) { // F7
                    $('#dashboard-delivery-shortcut')[0].click();
                }
            }
        });
        $("#BranchClose").on("click", function() {
            location.href = baseUrl + "#branch/branch-receipt";
            $(popHtml).dialog("close");
            // $(popHtml).dialog({ modal: false });
        })

        $("#paymentReceipt").on("click", function() {
            $('.showCreditLimit').addClass('hide');
            $('.inp_error').removeClass('inp_error');
            $('#receipt-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#receipt-action-state').hide();
            $('#payment-receipt-dialog').css('background', '#fff');
            $('#payment-receipt-dialog').removeClass('hide');
            $('#payment-receipt-dialog').dialog({
                autoOpen: true,
                height: 600,
                width: 870,
                modal: true,
                resizable: false,
                open: function() {
                    if ($.ui && $.ui.dialog && !$.ui.dialog.prototype
                        ._allowInteractionRemapped && $(this).closest(".ui-dialog").length
                    ) {
                        if ($.ui.dialog.prototype._allowInteraction) {
                            var ui_dialog_interaction = $.ui.dialog.prototype
                                ._allowInteraction;
                            $.ui.dialog.prototype._allowInteraction = function(e) {
                                if ($(e.target).closest('.select2-drop').length)
                                    return true;
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
      
            $('#receipt-mode').val('');
            $('#receipt-type').val('PAY');

            if (menu_permission['PYRCT-ALL-USER'] == 1) {
                $('#receipt-user').val('').trigger('change');
                $('#receipt-user-vendor').val('').trigger('change');
                $('#receipt-vendor').val('').trigger('change');
                $('[name="receipt_to"][value="RCPTUSER"]').prop('checked', true).trigger('change');
            }

            if ($('#receipt-user').attr('type') !=
                "hidden") { // Dont reset if permission not available.
                $('#receipt-user').val('').trigger('change');
            }

            $('#form-bttons').show();
            $('#receipt-action-state').html('');
            $('#receipt-action-state').hide();
            $('.inp_error').removeClass('inp_error');
            fileupload.clearFiles();
        });


        $("#saveReceipt").on("click", function() {
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
                $('#receipt-action-state').html(
                    'Please enter/select the values in the field that are marked in red');
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
                                    $('[data-status="' + response.data
                                        .paymentAcknowledgeStatus
                                        .code + '"] a').tab('show');
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
        });


        $("#clearReceipt").on("click", function() {
            $('.showCreditLimit').removeClass('hide');
            $('#payment-receipt-dialog').dialog('destroy');
            $('#payment-receipt-dialog').hide();
        });



    });
</script>