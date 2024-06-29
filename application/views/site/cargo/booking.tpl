<style>
.customChecker {
    border: 1px solid rgba(0, 0, 0, 0.166);
    display: inline-block;
    padding: 5px 10px;
    cursor: pointer;
    height:34px;
}
.checkerActive {
    color:white;
    background-color: green;
}
.dp-input{
    visibility: hidden;
}
#pay_type .radio{
    margin-right: 15px;
    margin-bottom: 5px;
}
.mbottom-0{
    margin-bottom: 0px !important;
}
</style>
{assign var="isBookingSMSEnabled" value=($action_rights['ALW-CUS-BKG-SMS'] == 1 && substr($sms_notification_flag_code, 0, 2) == '11')}
<div class="brand_top">
    <h3>Cargo Booking</h3>
    <div class="row">
        <form onsubmit="return false;">
            <div class="col-md-1 w-auto p_l_n pull-right">
                <button type="submit" class="btn btn-success" onclick="findPrebookingLR();getAllInputs();">Find</button>  &nbsp;
            </div>
            <div class="col-md-3 pull-right">
                <div class="form-inline">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-search"></i></span>
                        <label for="prebooking-find" class="sr-only">Prebooking Find</label>
                        <input type="text" name="prebooking-find" value="" class="form-control capitalize" id="prebooking-find" maxlength="10" placeholder="Prebooking Code / Mobile">
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body cargo-booking-panel">

                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-6">
                                        
                                            <div class="btn-group btn-group-days {if !in_array('FTL', $cargo_setting->bookingModelTag) && !in_array('PTL', $cargo_setting->bookingModelTag)}hide{/if}" id="load-type-btns" data-toggle="buttons" onchange="toggleLRLoadType();getAllInputs();">
                                                <label class="btn btn-xs btn-success active" title="Regular Booking">
                                                    <input type="radio" name="lr-load-type" id="regular-load-cb" value="RGL" autocomplete="off" checked> Regular Booking
                                                </label>
                                                {if in_array('FTL', $cargo_setting->bookingModelTag)}
                                                    <label class="btn btn-xs btn-success" title="Full Truck Load">
                                                        <input type="radio" name="lr-load-type" id="ftl-load-cb" value="FTL" autocomplete="off"> Full Truck Load
                                                    </label>
                                                {/if}
                                                {if in_array('PTL', $cargo_setting->bookingModelTag)}
                                                    <label class="btn btn-xs btn-success" title="Partial truck Load">
                                                        <input type="radio" name="lr-load-type" id="ptl-load-cb" value="PTL" autocomplete="off"> Partial truck Load
                                                    </label>
                                                {/if}
                                                <br>
                                                <br>
                                            </div>
                                            <div class="btn-group btn-group-days pull-right {if !in_array('LOC', $cargo_setting->bookingModelTag)}hide{/if}" id="shipment-type-btns" data-toggle="buttons" onchange="toggleToBranch();getAllInputs();">
                                                <label class="btn btn-xs btn-success active" title="Outstation Shipment">
                                                    <input type="radio" name="lr-shipment-type" id="outstation-shipment-cb" value="OUT" autocomplete="off" checked> Outstation Shipment
                                                </label>
                                                {if in_array('LOC', $cargo_setting->bookingModelTag)}
                                                    <label class="btn btn-xs btn-success" title="Local Shipment">
                                                        <input type="radio" name="lr-shipment-type" id="local-shipment-cb" value="LOC" autocomplete="off"> Local Shipment
                                                    </label>
                                                {/if}
                                                <br>
                                                <br>
                                            </div>      
                                        </div>
                                        
                                        <div class="col-md-4">
                                            {if $action_rights['MAN-LR-NO']==1}
                                                <div class="row">
                                                    <div class="col-sm-6 w-auto">
                                                        <div class="btn-group btn-group-days" id="lrno-type-btns" data-toggle="buttons" onchange="toggleLRSequence();getAllInputs();">
                                                            <label class="btn btn-xs btn-success active" title="Automatic LR No">
                                                                <input type="radio" name="lr-no-type" id="auto-lr-cb" value="AUTO" autocomplete="off" checked> System LR
                                                            </label>
                                                            <label class="btn btn-xs btn-success" title="Manual LR No">
                                                                <input type="radio" name="lr-no-type" id="manual-lr-cb" value="MANUAL" autocomplete="off"> Manual LR
                                                            </label>
                                                            <br>
                                                            <br>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group cont hide">
                                                            <div class="input-group">
                                                                <span class="input-group-addon" id="manual-lr-prefix"></span>
                                                                <input type="text" class="form-control" id="manual-lr-no" placeholder="Manual {lang('lr')} No" maxlength="12" onblur="checkManualLRNumber()">
                                                            </div>
                                                            <span id="manual-lr-status"></span>
                                                        </div>

                                                        {if $cargo_setting->userAccountModel->code == 'DINV'}
                                                            <div class="form-group nextlrseq">
                                                                <div id="next-lr-sequence"></div>
                                                            </div>
                                                        {/if}
                                                    </div>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>

                                    <div id="route-info">
                                        <div class="row">
                                            <div class="col-lg-offset-1 col-md-5">
                                                <h5> {lang('booking_from_label')}</h5>

                                                <div class="row">
                                                    <div class="{if $action_rights['CARGO-DOOR-PICKUP']>0}col-md-6{else}col-md-12{/if}">
                                                        <div class="form-group cont">
                                                            <label for="from_branch" class="sr-only">Origin Branch</label>
                                                            <input type="text" class="form-control" id="from_branch" value="{$userDetail['org_code']}" {if $action_rights['CARGO-ONBEHALF-BOOKING']==0} disabled {/if} onclick="toggleToBranch();togglePayType();">
                                                        </div>
                                                        <div class="form-group cont hide">
                                                            <label for="from_station" class="sr-only">Origin Station</label>
                                                            <input type="text" class="form-control" id="from_station" value="{$userDetail['org_station_code']}" {if $action_rights['CARGO-ONBEHALF-BOOKING']==0} disabled {/if}  onclick="togglePayTypeState();">
                                                        </div>
                                                    </div>
                                                    {if $action_rights['CARGO-DOOR-PICKUP']>0}
                                                      

                                                        <div class="customChecker" onclick="customChecked()" data-toggle="tooltip" title="Doop Pickup">
                                                            <label title="door delivery">DP</label>
                                                            <input type="checkbox" class="dp-input" id="door-pickup" name="door-pickup" onclick="" />
                                                            {* <input type="checkbox" class="dp-input" name="doorpickup"> *}
                                                        </div>


                                                        {* <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="from_branch" class="sr-only">&nbsp;</label>
                                                                <div class="address-panel">
                                                                    <input type="checkbox" id="door-pickup" name="door-pickup" onclick="setupDoorPickup();calculateAmounts();getAllInputs();" />
                                                                    <label for="door-pickup">Door Pickup?</label>
                                                                </div>
                                                            </div>
                                                        </div> *}
                                                    {/if}
                                                </div>
                                            </div>
                                            <div class="col-md-5">
                                                <h5>{lang('booking_to_label')}</h5>

                                                <div class="row">
                                                    <div class="{if $action_rights['CARGO-DOOR-DELIVERY']>0}col-md-6{else}col-md-12{/if}">
                                                        <div class="form-group cont">
                                                            <label for="to_branch" class="sr-only">To Branch</label>
                                                            <input type="text" class="form-control" id="to_branch" onclick="toggleToPayType();"/>
                                                        </div>
                                                        <div class="form-group cont hide">
                                                            <label for="to_station" class="sr-only">To Station</label>
                                                            <input type="text" class="form-control" id="to_station">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="d-flex justify-between">
                                                            {if $action_rights['CARGO-DOOR-DELIVERY']>0}
                                                                <div class="btn-group btn-group-days" id="ddtype-btn-group" data-toggle="buttons" onchange="setupDoorDelivery();calculateAmounts();getAllInputs();">
                                                                    <label class="btn btn-success" title="Door Delivery">
                                                                        <input type="radio" name="dd-type" id="ddtype-radio-dydo" value="DYDO" autocomplete="off"> DD
                                                                    </label>
                                                                    <label class="btn btn-success" title="Way Delivery">
                                                                        <input type="radio" name="dd-type" id="ddtype-radio-waydy" value="WAYDY" autocomplete="off"> WD
                                                                    </label>
                                                                </div>
                                                            {/if}
                                                            <div class="btn-group btn-group-days" id="shipping-btn-group" data-toggle="buttons" style="margin-left:5px;">
                                                                {if in_array('EXPDL', $cargo_setting->bookingModelTag)}
                                                                    <label class="btn  btn-success" title="Express Delivery">
                                                                        <input type="checkbox" name="lr-load-type" id="expdl-shipping" value="EXPDL" autocomplete="off">ED
                                                                    </label>
                                                                {/if}
                                                                {if in_array('HDLWC', $cargo_setting->bookingModelTag)}
                                                                    <label class="btn btn-success" title="Handle With Care">
                                                                        <input type="checkbox" name="lr-load-type" id="hdlwc-shipping" value="HDLWC" autocomplete="off">HC
                                                                    </label>
                                                                {/if}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="well well-sm col-lg-offset-1 col-md-10">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group mbottom-0">
                                                        <label for="from_branch">Payment Type</label>
                                                        <div id="pay_type" onchange="setNowPayAmount();setPaytypeSettings();getAllInputs();">
                                                            <i class="fa fa-info-circle"></i> Please select From and To Branches
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-6 hide" id="vendor_users_div">
                                                    <div class="form-group">
                                                        <label for="vendor_users" class="req">Credit Customers</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" id="vendor_users" onchange="setVendorSettings();"/>
                                                            <span class="input-group-addon" id="vendor_users_info"><i class="fa fa-info-circle"></i></span>
                                                        </div>
                                                    </div>
                                                </div>

                                                {if $action_rights['SHOW-MULTI-PAY-MODE'] != 1}
                                                    <div class="col-md-6 hide" id="transaction_mode_div">
                                                        <div class="form-group mbottom-0">
                                                            <label for="transaction-mode-main" class="req">Transaction Mode</label>
                                                            <select id="transaction-mode-main" class="form-control" onchange="setTransactionMode('main');getAllInputs();">
                                                                {foreach key=key item=row from=$transactions_details}
                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                {/if}
                                            </div>
                                        </div>

                                        {if $action_rights['SHOW-MULTI-PAY-MODE'] != 1}
                                            <div class="hide" id="upi-mode-panel-main">
                                                <div class="well well-sm col-lg-offset-1 col-md-10">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="upi-orgbank-main">Organization Bank</label>
                                                                <select class="form-control" id="upi-orgbank-main">
                                                                    <option value="">Select Organization Bank</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="upi-id-main">UPI ID</label>
                                                                <input type="text" class="form-control" id="upi-id-main" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="upi-details-main">Ref. #</label>
                                                                <input type="text" class="form-control" id="upi-details-main" placeholder="Ref. #" autocomplete="off">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="hide" id="netbanking-mode-panel-main">
                                                <div class="well well-sm col-lg-offset-1 col-md-10">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="netbanking-orgbank-main">Organization Bank</label>
                                                                <select class="form-control" id="netbanking-orgbank-main">
                                                                    <option value="">Select Organization Bank</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="netbanking-accholder-main">Account Holder Name</label>
                                                                <input type="text" class="form-control" id="netbanking-accholder-main" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="netbanking-bankname-main">Bank Name</label>
                                                                <input type="text" class="form-control" id="netbanking-bankname-main" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="netbanking-details-main">Ref. #</label>
                                                                <input type="text" class="form-control" id="netbanking-details-main" placeholder="Ref. #" autocomplete="off">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="hide" id="cheque-mode-panel-main">
                                                <div class="well well-sm col-lg-offset-1 col-md-10">
                                                    <div class="row">
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label for="cheque-payer-main">Payer Details</label>
                                                                <input type="text" class="form-control" id="cheque-payer-main" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label for="cheque-no-main">Cheque No</label>
                                                                <input type="text" class="form-control" id="cheque-no-main" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label for="cheque-date-main">Cheque Date</label>
                                                                <input type="text" class="form-control" id="cheque-date-main" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label for="cheque-bankcity-main">Bank City</label>
                                                                <input type="text" class="form-control" id="cheque-bankcity-main" maxlength="90" placeholder="Bank City" autocomplete="off">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="cheque-bankname-main">Bank Name</label>
                                                                <input type="text" class="form-control" id="cheque-bankname-main" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="cheque-remarks-main">Remarks</label>
                                                                <input type="text" class="form-control" placeholder="Remarks" id="cheque-remarks-main" data-mask="englishonly"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        {/if}

                                        <div class="row">
                                            <div class="col-lg-offset-1 col-md-5">

                                                <div class="row">
                                                    {if $namespace == "tippusultan" || $namespace == "seenutransports"}
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="from_name" class="sr-only">Name</label>
                                                                <input type="text" name="from_name" value="" class="form-control capitalize" id="from_name" maxlength="120" placeholder="{lang('booking_sender_term')} NAME" autocomplete="off">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="from_phone" class="sr-only">Mobile</label>
                                                                <div class="input-group typeahead-input-group wid-p-100">
                                                                    <input type="text" name="from_phone" value="" class="form-control capitalize" id="from_phone" maxlength="10" placeholder="{lang('booking_sender_term')} MOBILE" autocomplete="off">
                                                                    {if $isBookingSMSEnabled}
                                                                        <span class="input-group-addon">
                                                                            <label class="m-0"><input type="checkbox" class="valign-bottom" id="from_sms_cb" tabindex="-1"> SMS</label>
                                                                        </span>
                                                                    {/if}
                                                                </div>
                                                            </div>
                                                        </div>
                                                    {else}
                                                        <div class="col-md-6 {if $cargo_setting->custom->skipCustomerMobile}hide{/if}">
                                                            <div class="form-group">
                                                                <label for="from_phone" class="sr-only">Mobile</label>
                                                                <div class="input-group typeahead-input-group wid-p-100">
                                                                    <input type="text" name="from_phone" value="" class="form-control capitalize on_account" id="from_phone" maxlength="10" placeholder="CONSIGNOR / SENDER MOBILE" autocomplete="off">
                                                                    {if $isBookingSMSEnabled}
                                                                        <span class="input-group-addon">
                                                                            <label class="m-0"><input type="checkbox" class="valign-bottom" id="from_sms_cb" tabindex="-1"> SMS</label>
                                                                        </span>
                                                                    {/if}
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="{if $cargo_setting->custom->skipCustomerMobile}col-md-12{else}col-md-6{/if}">
                                                            <div class="form-group">
                                                                <label for="from_name" class="sr-only">Name</label>
                                                                <input type="text" name="from_name" value="" class="form-control capitalize on_account" id="from_name" maxlength="120" placeholder="CONSIGNOR / SENDER NAME" autocomplete="off">
                                                            </div>
                                                        </div>
                                                    {/if}
                                                </div>
                                            </div>

                                            <div class="col-md-5">
                                                <div class="row">
                                                    {if $namespace == "tippusultan" || $namespace == "seenutransports"}
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="to_name" class="sr-only">Name</label>
                                                                <input type="text" name="to_name" value="" class="form-control capitalize" id="to_name" maxlength="120" placeholder="{lang('booking_receiver_term')} NAME" autocomplete="off">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="to_phone" class="sr-only">Mobile</label>
                                                                <div class="input-group typeahead-input-group wid-p-100">
                                                                    <input type="text" name="to_phone" value="" class="form-control capitalize" id="to_phone" maxlength="10" placeholder="{lang('booking_receiver_term')} MOBILE"  autocomplete="off"/>
                                                                    {if $isBookingSMSEnabled}
                                                                        <span class="input-group-addon">
                                                                            <label class="m-0"><input type="checkbox" class="valign-bottom" id="to_sms_cb" tabindex="-1"> SMS</label>
                                                                        </span>
                                                                    {/if}
                                                                </div>
                                                            </div>
                                                        </div>
                                                    {else}
                                                        <div class="col-md-6 {if $cargo_setting->custom->skipCustomerMobile}hide{/if}">
                                                            <div class="form-group">
                                                                <label for="to_phone" class="sr-only">Mobile</label>
                                                                <div class="input-group typeahead-input-group wid-p-100">
                                                                    <input type="text" name="to_phone" value="" class="form-control capitalize onaccount_phone" id="to_phone" maxlength="10" placeholder="CONSIGNEE / RECEIVER MOBILE"  autocomplete="off"/>
                                                                    {if $isBookingSMSEnabled}
                                                                        <span class="input-group-addon">
                                                                            <label class="m-0"><input type="checkbox" class="valign-bottom" id="to_sms_cb" tabindex="-1"> SMS</label>
                                                                        </span>
                                                                    {/if}
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="{if $cargo_setting->custom->skipCustomerMobile}col-md-12{else}col-md-6{/if}">
                                                            <div class="form-group">
                                                                <label for="to_name" class="sr-only">Name</label>
                                                                <input type="text" name="to_name" value="" class="form-control capitalize onaccount_phone" id="to_name" maxlength="120" placeholder="CONSIGNEE / RECEIVER NAME" autocomplete="off">
                                                            </div>
                                                        </div>
                                                    {/if}
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-offset-1 col-md-5">

                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="sender_gst" class="sr-only">{lang('booking_sender_gst_term')}</label>
                                                        <div {if isNotNull($ewaybill_vendor_code)}class="input-group typeahead-input-group"{/if}>
                                                            <input type="text" name="sender_gst" class="form-control capitalize on_account4" id="sender_gst" placeholder="{lang('booking_sender_gst_term')}" onblur="calculateAmounts();" maxlength="30"/>
                                                            {if isNotNull($ewaybill_vendor_code)}
                                                                <span class="input-group-btn btn-group">
                                                                    <button type="button" class="btn btn-default" title="Get GST Details" id="sender-gst-validate-btn" onclick="getGSTDetails('sender')" tabindex="-1"><i class="fa fa-search" aria-hidden="true"></i></button>
                                                                </span>
                                                            {/if}
                                                        </div>
                                                        <div id="sender-gst-hint"></div>
                                                    </div>
                                                </div>
                                                
                                                {if $action_rights['COLT-CUST-EMAIL'] == 1}
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="from_email" class="sr-only">Email</label>
                                                            <input type="email" name="from_email" value="" class="form-control" id="from_email" maxlength="64" placeholder="{lang('booking_sender_term')} Email" autocomplete="off"/>
                                                        </div>
                                                    </div>
                                                {/if}

                                                <div class="col-md-6">
                                                    <div id="sender-gst-type" onchange="setSenderGSTType();getAllInputs();">
                                                        <span class="radio d-inline-block"><label><input type="radio" name="sender-gst-type" value="INDL" checked>Individual</label></span>&emsp;
                                                        <span class="radio d-inline-block"><label><input type="radio" name="sender-gst-type" value="CMPY">Company</label></span>
                                                    </div>
                                                </div>

                                                <div id="sender-company-panel" class="{if $action_rights['COLT-CUST-EMAIL'] == 1}col-md-6{else}col-md-12{/if} hide">
                                                    <div class="form-group">
                                                        <label for="sender-company-name" class="sr-only">Company Name</label>
                                                        <input type="text" value="" class="form-control" id="sender-company-name" maxlength="120" placeholder="CONSIGNOR / SENDER COMPANY" autocomplete="off">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-5">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="receiver_gst" class="sr-only">{lang('booking_receiver_gst_term')}</label>
                                                        <span class="text-danger gst-validation"></span>
                                                        <div {if isNotNull($ewaybill_vendor_code)}class="input-group typeahead-input-group"{/if}>
                                                            <input type="text" name="receiver_gst" class="form-control capitalize onaccount_phone" id="receiver_gst" placeholder="{lang('booking_receiver_gst_term')}" onblur="calculateAmounts();" maxlength="20" autocomplete="off">
                                                            {if isNotNull($ewaybill_vendor_code)}
                                                                <span class="input-group-btn btn-group">
                                                                    <button type="button" class="btn btn-default" title="Get GST Details" id="receiver-gst-validate-btn" onclick="getGSTDetails('receiver')" tabindex="-1"><i class="fa fa-search" aria-hidden="true"></i></button>
                                                                </span>
                                                            {/if}
                                                        </div>
                                                        <div id="receiver-gst-hint"></div>
                                                        <div class="text-danger" id="receiver-gst-error"></div>
                                                    </div>
                                                </div>
                                                
                                                {if $action_rights['COLT-CUST-EMAIL'] == 1}
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="to_email" class="sr-only">Email</label>
                                                            <input type="email" name="to_email" value="" class="form-control" id="to_email" maxlength="64" placeholder="{lang('booking_receiver_term')} Email" autocomplete="off"/>
                                                        </div>
                                                    </div>
                                                {/if}

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <div id="receiver-gst-type" onchange="setReceiverGSTType();getAllInputs();">
                                                            <span class="radio d-inline-block"><label><input type="radio" name="receiver-gst-type" value="INDL" checked>Individual</label></span>&emsp;
                                                            <span class="radio d-inline-block"><label><input type="radio" name="receiver-gst-type" value="CMPY">Company</label></span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div id="receiver-company-panel" class="{if $action_rights['COLT-CUST-EMAIL'] == 1}col-md-6{else}col-md-12{/if} hide">
                                                    <div class="form-group">
                                                        <label for="receiver-company-name" class="sr-only">Company Name</label>
                                                        <input type="text" value="" class="form-control" id="receiver-company-name" maxlength="120" placeholder="CONSIGNEE / RECEIVER COMPANY" autocomplete="off">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-offset-1 col-md-5">
                                            <div class="row row-address-dropdown-1 hide">
                                                <div class="col-md-12">
                                                    <div class="dropdown form-group">
                                                        <button class="btn btn-default btn-xs dropdown-toggle form-control" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                            Choose Pick up Address
                                                            <span class="caret"></span>
                                                        </button>
                                                        <ul class="dropdown-menu checkbox-menu allow-focus col-md-12 address-dropdown-1" aria-labelledby="dropdownMenu1">


                                                        </ul>
                                                    </div>
                                                    <input type="hidden" id="from-address-code-hidden">
                                                </div>
                                                {*<div class="col-md-2">
                                                    <a href="javascript:;" class="btn btn-sm" title="Add New Address" onclick="initAddressDialog(1)"> <i class="fa fa-plus"></i> </a>
                                                </div>*}
                                            </div>
                                            <div class="from-address-components hide">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="fr_address">Pickup Address (Door No, Street)</label>
                                                            <input type="text" name="fr_address" value="" class="form-control" id="fr_address" maxlength="180" placeholder="Pickup Address (Door No, Street)" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <div>
                                                                <label for="txt_m_name">City</label>
                                                                <input type="text" class="form-control" id="fr_addr_station"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="fr_landmark">Landmark</label>
                                                            <input type="text" name="fr_landmark" value="" class="form-control" id="fr_landmark" maxlength="80" placeholder="Landmark" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="fr_pincode">Pincode</label>
                                                            <input type="text" name="fr_pincode" value="" class="form-control" id="fr_pincode" maxlength="6" placeholder="Pincode" data-mask="positiveinteger"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div id="from-address-details" class="well well-sm hide"></div>
                                        </div>

                                        <div class="col-md-5">
                                            <div class="row row-address-dropdown-2 hide">
                                                <div class="col-md-12">
                                                    <div class="dropdown form-group">
                                                        <button class="btn btn-default btn-xs dropdown-toggle form-control" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                            Choose Delivery Address
                                                            <span class="caret"></span>
                                                        </button>
                                                        <ul class="dropdown-menu checkbox-menu allow-focus col-md-12 address-dropdown-2" aria-labelledby="dropdownMenu2">


                                                        </ul>
                                                    </div>
                                                </div>
                                                {*<div class="col-md-2">
                                                    <a href="javascript:;" class="btn btn-sm" id="tr_add_btn" title="Add New Address" onclick="initAddressDialog(2)"> <i class="fa fa-plus"></i> </a>
                                                </div>*}
                                            </div>
                                            <div class="to-address-components hide">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="c_address1">Delivery Address (Door No, Street)</label>
                                                            <input type="text" name="to_address" value="" class="form-control" id="to_address" maxlength="180" placeholder="Delivery Address (Door No, Street)" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <div>
                                                                <label for="txt_m_name">City</label>
                                                                <input type="text" class="form-control" id="to_addr_station"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="c_city">Landmark</label>
                                                            <input type="text" name="to_landmark" value="" class="form-control" id="to_landmark" maxlength="80" placeholder="Landmark" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="c_state">Pincode</label>
                                                            <input type="text" name="to_pincode" value="" class="form-control" id="to_pincode" maxlength="6" placeholder="Pincode" data-mask="positiveinteger"/>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                            <div id="to-address-details" class="well well-sm hide"></div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-offset-1 col-md-10 artical-row-container">
                                            <div class="table-responsive">
                                                <table class="table table-striped">
                                                    <thead>
                                                    <tr class="valign-bottom">
                                                        <th></th>
                                                        <th>{lang('booking_article_label')}</th>
                                                        {if $action_rights['HIDE-DESCRIPTION']!=1}<th>{lang('booking_article_description_label')}</th>{/if}
                                                        {if $action_rights['CARGO-UNITS']==1}
                                                        <th>{lang('booking_UOM_label')} {if lang('booking_UOM_label_info')}<i class="fa fa-info-circle" data-toggle="tooltip" data-title="{lang('booking_UOM_label_info')}"></i>{/if}</th>
                                                        <th>Actual wt.</th>
                                                        {/if}
                                                        <th>Quantity</th>
                                                        <th>Freight Per Qty
                                                        {if $action_rights['CARGO-FS-ADDONS'] == 1}
                                                            <br><label class="checkbox font-weight-normal m-0"><input type="checkbox" class="fs-addon-checkbox" title="Free Service" value="FR"> Free Service</label>
                                                        {/if}</th>
                                                        <th>Freight Total</th>
                                                        {if $action_rights['HIDE-LOADING-CHARGES']!=1}
                                                            <th>L. Charges 
                                                                {if $action_rights['HANDLING-PER-UOMQTY']==1}
                                                                    Per {lang('booking_UOM_label')} or Qty
                                                                {else if $action_rights['HANDLING-PER-QTY']==1}
                                                                    Per Qty
                                                                {else if $action_rights['HANDLING-PER-UOM']==1}
                                                                    Per {lang('booking_UOM_label')}
                                                                {/if}
                                                                {if $action_rights['CARGO-FS-ADDONS'] == 1}
                                                                    <br><label class="checkbox font-weight-normal m-0"><input type="checkbox" class="fs-addon-checkbox" title="Free Service" value="LC"> Free Service</label>
                                                                {/if}
                                                            </th>
                                                        {/if}
                                                        {if $action_rights['CARGO-UNLOADING-CHARGES']==1}<th>Unloading Charges</th>{/if}
                                                    </tr>
                                                    </thead>
                                                    <tbody id="article_rows">

                                                    <tr id="article_row_1" data-index="1" class="article_row">
                                                        <td width="55"><a href="javascript:;" onclick="removeArticleRow(this);" data-index='1'  class="btn btn-sm btn-default tr_remove" title="Remove"><i class="fa fa-minus"></i></a></td>
                                                        <td width="300">
                                                            <!--<select id="name" data-index='1'  class="form-control" onchange="select_article(1,this.value)" >
                                                                <option value="">Select Article</option>
                                                            </select> -->
                                                            <input type="text" id="name" data-index='1' maxlength="80" class="form-control" placeholder="Select {lang('booking_article_label')}"/>

                                                        </td>
                                                        {if $action_rights['HIDE-DESCRIPTION']!=1}
                                                        <td width="300">
                                                            <input type="text" id="article-desc" class="form-control" placeholder="Select {lang('booking_article_description_label')}" data-mask="englishonly" maxlength="160"/>
                                                            <input type="hidden" id="article-unit-volumetric" value="">
                                                        </td>
                                                        {/if}
                                                        {if $action_rights['CARGO-UNITS']==1}
                                                        <td width="200">
                                                            <div class="row">
                                                                <div class="col-md-7 p_r_n">
                                                                    <select class="form-control" id="article-unit" onchange="setArticleUnit(this); calculateAmounts(); {if $namespace == "rajeshcargo" || $namespace=="rajeshexpress"}setMinWeight(this);{/if}">
                                                                        {foreach item=name key=code from=$article_unit}
                                                                            {if in_array($code, $cargo_setting->cargoUnitModel)}
                                                                                <option value="{$code}">{$name}</option>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                                <div class="col-md-5 p_l_n">
                                                                    <input type="text" class="form-control" id="article-unit-val" value="1" onblur="calcMachineHandlingCharges();calculateAmounts();" data-mask="positivedecimal" {if $namespace == "newlinetrans"}data-inputmask-digits="3"{/if}>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td width="100">
                                                            <input type="text" class="form-control" id="actual-weight" value="0" data-mask="positivedecimal">
                                                        </td>
                                                        {/if}
                                                      
                                                        <td width="100"><input type="text" class="form-control qty-input" onblur="calculateAmounts();" id="qty" value="0" data-mask="positiveinteger"></td>
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="setArticleFreight(this); calculateAmounts();" id="price" value="0" data-fs="FR" data-mask="inrcurrency">
                                                            </div>
                                                        </td>
                                                        <td width="150">

                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" id="total" disabled="" value="0">
                                                            </div>
                                                        </td>
                                                        {if $action_rights['HIDE-LOADING-CHARGES']!=1}
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary" id="handling-type"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="validateMinHandling(this); calculateAmounts();" id="handling" value="0" data-fs="LC" data-mask="inrcurrency" {if $cargo_setting->loadingChargeEditFlag}disabled{/if}>
                                                            </div>
                                                        </td>
                                                        {/if}
                                                        {if $action_rights['CARGO-UNLOADING-CHARGES']==1}
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="unloading" value="0" data-mask="inrcurrency">
                                                            </div>
                                                        </td>
                                                        {/if}
                                                        <input type="hidden" class="form-control" id="code" value="">
                                                    </tr>


                                                    </tbody>
                                                    <tfoot>
                                                    <tr id="tr_add">
                                                        <td class="p-0" colspan="10">

                                                            <table class="table m-0">
                                                                <tr class="border-0 valign-top">

                                                                    <td width="55">
                                                                        <label>&nbsp;</label>
                                                                        <a href="javascript:;" class="btn btn-sm btn-primary" id="tr_add_btn" title="Add {lang('booking_article_label')}" onclick="addArticleRow()"> <i class="fa fa-plus"></i> </a>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        {if $action_rights['CARGO-ONBEHALF-BOOKING']==1}
                                                                            <div style="max-width: 200px;">
                                                                                <label for="cb-on-behalf-user">On Behalf Of</label>
                                                                                <select id='cb-on-behalf-user' class="form-control">
                                                                                    <option  value="">Select a user</option>
                                                                                    {foreach name=o item=grpusr from=$groupusers.groups}
                                                                                        <optgroup label="{$grpusr->name}">
                                                                                        {foreach name=o item=usr from=$groupusers.users}
                                                                                            {if $usr.groupcode == $grpusr->code && $usr.activeFlag == 1}
                                                                                                <option  value="{$usr.code}">{$usr.name}</option>
                                                                                            {/if}
                                                                                        {/foreach}
                                                                                        </optgroup>
                                                                                    {/foreach}
                                                                                </select>
                                                                            </div>
                                                                        {/if}
                                                                    </td>
                                                                    <td width="120">
                                                                        <div>
                                                                            <label for="from_phone">Total L. Charges</label>
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                <input type="text" class="form-control" id="total_loading_charges" value="0" disabled>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    {if $action_rights['CARGO-HAMALI-CHARGES']==1}
                                                                    <td width="120">
                                                                        <div>
                                                                            <label for="from_phone">Hamali Charges</label>
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="hamali_charges" value="0" data-fs="HC" data-mask="inrcurrency">
                                                                            </div>
                                                                            {if $action_rights['CARGO-FS-ADDONS'] == 1}
                                                                                <label class="checkbox font-weight-normal m-0"><input type="checkbox" class="fs-addon-checkbox" title="Free Service" value="HC"> Free Service</label>
                                                                            {/if}
                                                                        </div>
                                                                    </td>
                                                                    {/if}
                                                                    {if $action_rights['CARGO-PASS-CHARGES']==1}
                                                                    <td width="120">
                                                                        <div>
                                                                            <label for="from_phone">Pass Charges</label>
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="pass_charges" data-mask="inrcurrency" {if $namespace == "rajeshcargo" || $namespace=="rajeshexpress"}value="20" disabled{else}value="0"{/if}>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    {/if}
                                                                    {if $action_rights['CARGO-DOCKET-CHARGES']==1}
                                                                    <td width="120">
                                                                        <div>
                                                                            <label for="from_phone">Docket Charges</label>
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="docket_charges" data-fs="DC" data-mask="inrcurrency" {if $cargo_setting->docketChargePercentageFlag}value="0" data-percent="{$cargo_setting->defaultDocketCharge + 0}"{else}value="{$cargo_setting->defaultDocketCharge + 0}"{/if} {if $cargo_setting->docketChargeEditFlag}disabled{/if}>
                                                                            </div>
                                                                            {if $action_rights['CARGO-FS-ADDONS'] == 1}
                                                                                <label class="checkbox font-weight-normal m-0"><input type="checkbox" class="fs-addon-checkbox" title="Free Service" value="DC"> Free Service</label>
                                                                            {/if}
                                                                        </div>
                                                                    </td>
                                                                    {/if}
                                                                    <td width="120">
                                                                        <div id="service-charge-panel" {if $action_rights['CARGO-SERVICE-CHARGES']!=1}  class="hide" {/if} >
                                                                            <label for="from_phone">{lang('other_charges')}</label>
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="service_charges" data-fs="OC" data-mask="inrcurrency"
                                                                                    {if $namespace == 'nationalchn' || $namespace == 'vkvexpress'}
                                                                                        value="10" readonly
                                                                                    {elseif $namespace == "ksreeni"}
                                                                                        value="20" readonly
                                                                                    {else}
                                                                                        value="0"
                                                                                    {/if}>
                                                                            </div>
                                                                            {if $action_rights['CARGO-FS-ADDONS'] == 1}
                                                                                <label class="checkbox font-weight-normal m-0"><input type="checkbox" class="fs-addon-checkbox" title="Free Service" value="OC"> Free Service</label>
                                                                            {/if}
                                                                        </div>
                                                                    </td>
                                                                    <td width="110">
                                                                        <div id="connectingCharge" class="hide">
                                                                            <label for="from_phone">Con Charges</label>
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                <input type="text" class="form-control" onblur="" id="connectingChargeValue" data-fs="DC" data-mask="inrcurrency" value="0" data-percent="" disabled>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td width="120">
                                                                        <div id="pickup-charge-panel" class="hide">
                                                                            <label for="from_phone">Pickup Charges</label>
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="dp_charges" value="0" data-fs="DP" data-mask="inrcurrency">
                                                                            </div>
                                                                            {if $action_rights['CARGO-FS-ADDONS'] == 1}
                                                                                <label class="checkbox font-weight-normal m-0"><input type="checkbox" class="fs-addon-checkbox" title="Free Service" value="DP"> Free Service</label>
                                                                            {/if}
                                                                        </div>
                                                                    </td>
                                                                    <td width="120">
                                                                        <div id="delivery-charge-panel" class="hide">
                                                                            <label for="from_phone">Delivery Charges</label>
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                <input type="text" class="form-control" id="dd_charges" maxlength="6" value="0" data-fs="DD" data-mask="inrcurrency" {if $namespace == "srtparcel"} data-minvalue="250" onblur="setMinDeliveryCharges(this);calculateAmounts();"{else} onblur="calculateAmounts();"{/if}>
                                                                            </div>
                                                                            {if $action_rights['CARGO-FS-ADDONS'] == 1}
                                                                                <label class="checkbox font-weight-normal m-0"><input type="checkbox" class="fs-addon-checkbox" title="Free Service" value="DD"> Free Service</label>
                                                                            {/if}
                                                                        </div>
                                                                    </td>
                                                                   
                                                                </tr>
                                                            </table>

                                                        </td>
                                                    </tr>

                                                    <tr id="tr_clone" style="display:none">
                                                        <td><a href="javascript:;" onclick="removeArticleRow(this);" class="btn btn-sm btn-default tr_remove" title="Remove"><i class="fa fa-minus"></i></a></td>
                                                        <td width="300">
                                                            <!--<select id="name" data-index='1'  class="form-control" >
                                                                <option value="">Select Article</option>
                                                            </select> -->
                                                            <input type="text" id="name" data-index='1' maxlength="80" class="form-control" placeholder="Select Article"/>
                                                        </td>
                                                        {if $action_rights['HIDE-DESCRIPTION']!=1}
                                                        <td width="300">
                                                            <input type="text" id="article-desc" class="form-control" placeholder="Select {lang('booking_article_description_label')}" data-mask="englishonly"/>
                                                            <input type="hidden" id="article-unit-volumetric" value="">
                                                        </td>
                                                        {/if}
                                                        {if $action_rights['CARGO-UNITS']==1}
                                                        <td width="200">
                                                            <div class="row">
                                                                <div class="col-md-7 p_r_n">
                                                                    <select class="form-control" id="article-unit" onchange="setArticleUnit(this); calculateAmounts(); {if $namespace == "rajeshcargo" || $namespace=="rajeshexpress"}setMinWeight(this);{/if}">
                                                                        {foreach item=name key=code from=$article_unit}
                                                                            {if in_array($code, $cargo_setting->cargoUnitModel)}
                                                                                <option value="{$code}">{$name}</option>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                                <div class="col-md-5 p_l_n">
                                                                    <input type="text" class="form-control" id="article-unit-val" value="1" onblur="calcMachineHandlingCharges();calculateAmounts();" data-mask="positivedecimal">
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td width="100">
                                                            <input type="text" class="form-control" id="actual-weight" value="0" data-mask="positivedecimal">
                                                        </td>
                                                        {/if}
                                                    
                                                        <td width="100"><input type="text" class="form-control qty-input" onblur="calculateAmounts();"  id="qty" value="0" data-mask="positiveinteger"></td>
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="price" value="0" data-fs="FR" data-mask="inrcurrency">
                                                            </div>
                                                        </td>
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" id="total" disabled="" value="0">
                                                            </div>
                                                        </td>
                                                        {if $action_rights['HIDE-LOADING-CHARGES']!=1}
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary" id="handling-type"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="validateMinHandling(this); calculateAmounts();" id="handling" value="0" data-fs="LC" data-mask="inrcurrency" {if $cargo_setting->loadingChargeEditFlag}disabled{/if}>
                                                            </div>
                                                        </td>
                                                        {/if}
                                                        {if $action_rights['CARGO-UNLOADING-CHARGES']==1}
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="unloading" value="0" data-mask="inrcurrency">
                                                            </div>
                                                        </td>
                                                        {/if}
                                                        <input type="hidden" class="form-control" id="code" value="">
                                                    </tr>

                                                    </tfoot>
                                                </table>
                                            </div>

                                            <div id="invoice-panel">
                                                <div class="row">
                                                    {if $action_rights['CARGO-EWAY-BILL']==1}
                                                        <div class="col-md-4">
                                                            <label for="from_phone">E-Way Bill</label>
                                                            <div {if isNotNull($ewaybill_vendor_code)}class="input-group typeahead-input-group"{/if}>
                                                                <input type="text" class="form-control" id="eway_bill" placeholder="E-Way Bill" maxlength="25" onblur="validateInvAmount()">
                                                                {if isNotNull($ewaybill_vendor_code)}
                                                                    <span class="input-group-btn btn-group">
                                                                        <button type="button" class="btn btn-default" title="Get E-Way Bill Details" id="eway_bill_validate_btn" onclick="getEwayBillDetails('eway_bill');getEwayBillData();" tabindex="-1"><i class="fa fa-search" aria-hidden="true"></i></button>
                                                                    </span>
                                                                {/if}
                                                            </div>
                                                            <div class="small text-danger no-wrap" id="eway_bill_hint"></div>
                                                        </div>
                                                    {/if}
                                                    <div class="col-md-4">
                                                        {if $action_rights['CARGO-EWAY-BILL'] == 1}
                                                            <label for="from_phone">&nbsp;</label>
                                                        {/if}
                                                        <a href="javascript:;" class="btn btn-sm btn-default" id="tr_add_invoice_btn" title="Add invoice details" onclick="addInvoiceRow()"> <i class="fa fa-plus"></i> Add Invoice (s)</a>
                                                    </div>

                                                    {if $action_rights['CUST-BAL-AMT'] == 1}
                                                        <div id="bk-customer-calculation" class="hide">
                                                            <div class="col-md-2">
                                                                <label>Customer Amount</label>
                                                                <input type="number" class="form-control" id="bk-customer-amount" oninput="getBookingBalanceReturnAmount(this);" placeholder="Customer Amount">
                                                            </div>

                                                            <div class="col-md-2">
                                                                <label>Balance Return</label>
                                                                <input type="number" class="form-control" disabled id="bk-balance-return-amount" placeholder="Balance Return">
                                                            </div>
                                                        </div>
                                                    {/if}

                                                    <div class="col-md-12">
                                                        <div id="eway_bill_details"></div>
                                                    </div>
                                                </div>

                                                <div class="row hide" id="invoice-table-panel">
                                                    <div class="col-md-8">
                                                        <div class="table-responsive">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th width="55"></th>
                                                                        <th>E-Way Bill Number</th>
                                                                        <th>Invoice Number</th>
                                                                        <th>Invoice Amount</th>
                                                                        <th>Invoice Date</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="invoice-list"></tbody>
                                                                <tfoot id="invoice-row-tpl" class="hide">
                                                                    <tr class="invoice-row">
                                                                        <td width="55">
                                                                            <a href="javascript:;" onclick="removeInvoiceRow(this);" class="btn btn-sm btn-default" title="Remove Invoice"><i class="fa fa-minus"></i></a>
                                                                        </td>
                                                                        <td>
                                                                            <input type="text" class="form-control e_way_bill_number" placeholder="E-way bill number" maxlength="20" onchange="checkDuplicateEwayBill(this)"/>
                                                                        </td>
                                                                        <td>
                                                                            <input type="text" class="form-control inv_number" placeholder="Invoice numbers" maxlength="20" />
                                                                        </td>
                                                                        <td>
                                                                            <input type="text" class="form-control inv_amount" placeholder="Total Invoice Amount" onblur="calculateAmounts();validateInvAmount()" maxlength="9" data-mask="inrcurrency" />
                                                                        </td>
                                                                        <td>
                                                                            <input type="text" class="form-control inv_date" placeholder="DD-MM-YYYY" readonly />
                                                                        </td>
                                                                    </tr>
                                                                </tfoot>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix_both"></div><br/>

                                            <div class="row">
                                                <div class="col-md-12" style="display: flex;">
                                                    {if $action_rights['CARGO-POD-CHARGES']==1}
                                                        <div class="col-md-2 p_l_n">
                                                            <label for="pod_charges_enable">POD Charges&nbsp;&nbsp;<input type="checkbox" id="pod_charges_enable" {if $cargo_setting->podCharge == 0}class="hide" checked disabled{/if} onchange="setPODValue();calculateAmounts();"></label>
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="pod_charges" value="0" data-mask="inrcurrency" {if $cargo_setting->podCharge > 0}disabled{/if} data-charge="{$cargo_setting->podCharge}">
                                                            </div>
                                                        </div>
                                                    {/if}
                                                    {if $action_rights['CARGO-INSURE-CHARGES']==1}
                                                        <div class="col-md-2 p_l_n">
                                                            <label for="insurance_charges">Insurance Charges</label>
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="insurance_charges" value="0" data-mask="inrcurrency">
                                                            </div>
                                                        </div>
                                                    {/if}
                                                    {if $action_rights['CGO-ADJSMT-AMT']==1}
                                                        <div class="col-md-2 p_l_n hide">
                                                            <label for="adjustment_amount">Adjustment Amount</label>
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="adjustment_amount" value="0" data-mask="allintegers">
                                                            </div>
                                                        </div>
                                                    {/if}
                                                    {if $action_rights['CARGO-MACHINE-HANDLING']==1}
                                                        <div class="col-md-2 p_l_n">
                                                            <label class="d-inline" for="machine_handling_charges">Machine Handling Cgs.</label>
                                                            <span data-toggle="popover" data-content="
                                                                <table class='table' width='300'>
                                                                    <thead>
                                                                        <tr>
                                                                            <th>From</th>
                                                                            <th>To</th>
                                                                            <th>Amount</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    {foreach from=$machine_handling_tariff item=tariff}
                                                                        <tr>
                                                                            <td>{$tariff->fromUnitValue}{$article_unit[$tariff->unitCode]}</td>
                                                                            <td>{$tariff->toUnitValue}{$article_unit[$tariff->unitCode]}</td>
                                                                            <td align='left'>{$tariff->amount|inr_format}</td>
                                                                        </tr>
                                                                    {/foreach}
                                                                    </tbody>
                                                                </table>
                                                            "><i class="fa fa-info-circle"></i></span>
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="machine_handling_charges" value="0" data-fs="MC" data-mask="inrcurrency">
                                                            </div>
                                                            {if $action_rights['CARGO-FS-ADDONS'] == 1}
                                                                <label class="checkbox font-weight-normal m-0"><input type="checkbox" class="fs-addon-checkbox" title="Free Service" value="MC" onchange="toggleFreeMachineHandling()"> Free Service</label>
                                                            {/if}
                                                        </div>
                                                    {/if}
                                                    {if $action_rights['CARGO-FOV-CHARGE']==1}
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label for="fov_percent">Freight On Value Cgs.</label>
                                                                <div class="row">
                                                                    <div class="col-md-7 p_r_n">
                                                                        <select class="form-control" id="fov_percent" onchange="calculateFOVPercent(this.value);">
                                                                            <option value="0">Nil</option>
                                                                            <option value="2">2%</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="col-md-5 p_l_n">
                                                                        <input type="text" class="form-control" id="fov_charge" value="0" data-mask="positivedecimal" onblur="calculateAmounts();">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    {/if}
                                                    {if $action_rights['SHOW-PVTNO'] == 1}
                                                        <div class="col-md-2">
                                                            <label for="bkg-private-mark">Private Mark No</label>
                                                            <input class="form-control" placeholder="Private Mark Number" id="bkg-private-mark" value="">
                                                        </div>
                                                    {/if}
                                                    <div>
                                                        <label for="booking-remarks">&nbsp;</label>
                                                        <input class="form-control" placeholder="Remarks" id="booking-remarks" data-mask="englishonly"/>
                                                    </div>
                                                    {if $action_rights['ALLOW-REFERRAL']}x  
                                                    <div class="input-container col-md-3" >
                                                        <label>Referal Agent</label>
                                                        <div class="input-group">
                                                            <span class="input-group-addon input-group-primary"> <input type="checkbox" onclick="refUserValidate();" id="refer-checkbox" data-toggle="tooltip" title="If a Agent is referred, please enter their details."  aria-label="Checkbox for following text input"></span>
                                                            <div class="d-flex">
                                                                <input type="text" style="display:inline-block; border-right:0px; border-radius: 0px 0px 0px 0px !important;" class="form-control" oninput="refUserValidate();" id="ref-user" value="" placeholder="Agent Name">
                                                                <input type="text" style="display:inline-block; width:70px; border-radius: 0px 3px 3px 0px !important;" class="form-control" oninput="refUserValidate();" id="ref-amount" value="" inputmode="decimal" placeholder="Amount">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    {/if}

                                                </div>
                                            </div>
                                            <div class="clearfix_both"></div><br/>

                                            {* Double Transaction Mode *}
                                                {if $action_rights['SHOW-MULTI-PAY-MODE'] == 1}
                                                    <div class="hide" id="transaction_mode_div">
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="row">
                                                                    <div class="col-md-4">
                                                                        <div class="form-group">
                                                                            <label for="transaction-mode-main">Transaction Mode</label>
                                                                            <select id="transaction-mode-main" class="form-control" onchange="setTransactionMode('main');getAllInputs();">
                                                                                 <option value="">There is no Modes</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-4">
                                                                        <div class="form-group">
                                                                            <label for="amount-main">Amount</label>
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                <input type="text" disabled maxlength="6" class="form-control" id="amount-main" data-mask="positivedecimal" placeholder="0" style=" font-size: 14px; font-weight: bold;"/>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-4">
                                                                        <label>&nbsp;</label>
                                                                        <a href="javascript:;" class="btn btn-sm btn-default" id="add-transaction-mode-btn" title="Add Transaction Mode" onclick="addTransactionMode()"> <i class="fa fa-plus"></i> Transaction Mode </a>
                                                                    </div>
                                                                </div>
                                                                    
                                                                {* Main *}
                                                                <div class="hide" id="upi-mode-panel-main">
                                                                    <div class="row">
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label for="upi-orgbank-main">Organization Bank</label>
                                                                                <select class="form-control" id="upi-orgbank-main">
                                                                                    <option value="">Select Organization Bank</option>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label for="upi-id-main">UPI ID</label>
                                                                                <input type="text" class="form-control" id="upi-id-main" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label for="upi-details-main">Ref. #</label>
                                                                                <input type="text" class="form-control" id="upi-details-main" placeholder="Ref. #" autocomplete="off">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="hide" id="netbanking-mode-panel-main">
                                                                    <div class="row">
                                                                        <div class="col-md-6">
                                                                            <div class="form-group">
                                                                                <label for="netbanking-orgbank-main">Organization Bank</label>
                                                                                <select class="form-control" id="netbanking-orgbank-main">
                                                                                    <option value="">Select Organization Bank</option>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="form-group">
                                                                                <label for="netbanking-accholder-main">Account Holder Name</label>
                                                                                <input type="text" class="form-control" id="netbanking-accholder-main" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="form-group">
                                                                                <label for="netbanking-bankname-main">Bank Name</label>
                                                                                <input type="text" class="form-control" id="netbanking-bankname-main" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="form-group">
                                                                                <label for="netbanking-details-main">Ref. #</label>
                                                                                <input type="text" class="form-control" id="netbanking-details-main" placeholder="Ref. #" autocomplete="off">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="hide" id="cheque-mode-panel-main">
                                                                    <div class="row">
                                                                        <div class="col-md-3">
                                                                            <div class="form-group">
                                                                                <label for="cheque-payer-main">Payer Details</label>
                                                                                <input type="text" class="form-control" id="cheque-payer-main" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <div class="form-group">
                                                                                <label for="cheque-no-main">Cheque No</label>
                                                                                <input type="text" class="form-control" id="cheque-no-main" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <div class="form-group">
                                                                                <label for="cheque-date-main">Cheque Date</label>
                                                                                <input type="text" class="form-control" id="cheque-date-main" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <div class="form-group">
                                                                                <label for="cheque-bankcity-main">Bank City</label>
                                                                                <input type="text" class="form-control" id="cheque-bankcity-main" maxlength="90" placeholder="Bank City" autocomplete="off">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="form-group">
                                                                                <label for="cheque-bankname-main">Bank Name</label>
                                                                                <input type="text" class="form-control" id="cheque-bankname-main" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="form-group">
                                                                                <label for="cheque-remarks-main">Remarks</label>
                                                                                <input type="text" class="form-control" placeholder="Remarks" id="cheque-remarks-main" data-mask="englishonly"/>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="hide" id="other-transaction-mode">
                                                                <div class="col-md-6">
                                                                    <div class="row">
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label for="transaction-mode-sub">Transaction Mode</label>
                                                                                <select id="transaction-mode-sub" class="form-control" onchange="setTransactionMode('sub');getAllInputs();">
                                                                                    {foreach key=key item=row from=$transactions_details}
                                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                                    {/foreach}
                                                                                </select>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label for="amount-sub">Amount</label>
                                                                                <div class="input-group">
                                                                                    <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                    <input type="text" maxlength="6" class="form-control" id="amount-sub" data-mask="positivedecimal" placeholder="0" style=" font-size: 14px; font-weight: bold;" oninput="calculateSplitup();"/>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-4">
                                                                            <label>&nbsp;</label>
                                                                            <a href="javascript:;" class="btn btn-sm btn-danger" id="remove-transaction-mode-btn" title="Remove Transaction Mode" onclick="removeTransactionMode()"> <i class="fa fa-times"></i> Transaction Mode </a>
                                                                        </div>
                                                                    </div>

                                                                    {* Sub *}
                                                                    <div class="hide" id="upi-mode-panel-sub">
                                                                        <div class="row">
                                                                            <div class="col-md-4">
                                                                                <div class="form-group">
                                                                                    <label for="upi-orgbank-sub">Organization Bank</label>
                                                                                    <select class="form-control" id="upi-orgbank-sub">
                                                                                        <option value="">Select Organization Bank</option>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-4">
                                                                                <div class="form-group">
                                                                                    <label for="upi-id-sub">UPI ID</label>
                                                                                    <input type="text" class="form-control" id="upi-id-sub" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-4">
                                                                                <div class="form-group">
                                                                                    <label for="upi-details-sub">Ref. #</label>
                                                                                    <input type="text" class="form-control" id="upi-details-sub" placeholder="Ref. #" autocomplete="off">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="hide" id="netbanking-mode-panel-sub">
                                                                        <div class="row">
                                                                            <div class="col-md-6">
                                                                                <div class="form-group">
                                                                                    <label for="netbanking-orgbank-sub">Organization Bank</label>
                                                                                    <select class="form-control" id="netbanking-orgbank-sub">
                                                                                        <option value="">Select Organization Bank</option>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <div class="form-group">
                                                                                    <label for="netbanking-accholder-sub">Account Holder Name</label>
                                                                                    <input type="text" class="form-control" id="netbanking-accholder-sub" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <div class="form-group">
                                                                                    <label for="netbanking-bankname-sub">Bank Name</label>
                                                                                    <input type="text" class="form-control" id="netbanking-bankname-sub" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <div class="form-group">
                                                                                    <label for="netbanking-details-sub">Ref. #</label>
                                                                                    <input type="text" class="form-control" id="netbanking-details-sub" placeholder="Ref. #" autocomplete="off">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="hide" id="cheque-mode-panel-sub">
                                                                        <div class="row">
                                                                            <div class="col-md-3">
                                                                                <div class="form-group">
                                                                                    <label for="cheque-payer-sub">Payer Details</label>
                                                                                    <input type="text" class="form-control" id="cheque-payer-sub" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <div class="form-group">
                                                                                    <label for="cheque-no-sub">Cheque No</label>
                                                                                    <input type="text" class="form-control" id="cheque-no-sub" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <div class="form-group">
                                                                                    <label for="cheque-date-sub">Cheque Date</label>
                                                                                    <input type="text" class="form-control" id="cheque-date-sub" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <div class="form-group">
                                                                                    <label for="cheque-bankcity-sub">Bank City</label>
                                                                                    <input type="text" class="form-control" id="cheque-bankcity-sub" maxlength="90" placeholder="Bank City" autocomplete="off">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <div class="form-group">
                                                                                    <label for="cheque-bankname-sub">Bank Name</label>
                                                                                    <input type="text" class="form-control" id="cheque-bankname-sub" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <div class="form-group">
                                                                                    <label for="cheque-remarks-sub">Remarks</label>
                                                                                    <input type="text" class="form-control" placeholder="Remarks" id="cheque-remarks-main" data-mask="englishonly"/>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="clearfix_both"></div><br/>
                                                {/if}

                                            <div id="booking-action-state" class="alert alert-danger text-right" style="display: none"></div>
                                            <div class="well well-sm" id="confirm-row">
                                                <div class='row'>
                                                    {if $action_rights['CARGO-SERVICE-TAX']==1}
                                                        <div class="col-md-1 w-auto {if $namespace == "rajeshcargo" || $namespace=="rajeshexpress"}hide{/if}">
                                                            <div class="form-group">
                                                                <label for="include-gst">GST</label>
                                                                <div class="pb5"></div>
                                                                <input type="checkbox" id="include-gst" class="bsn_switch" data-on-text="Enable" data-off-text="Disable ">
                                                            </div>
                                                        </div>
                                                    {/if}
                                                    <div class="col-md-2">
                                                        <div class="form-group">
                                                            <label for="from_phone">GST Amount</label>
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" disabled="" value="0" name="service_tax"  maxlength="6" class="form-control" id="service_tax"  placeholder="0" style=" font-size: 14px; font-weight: bold;"/>
                                                            </div>
                                                            <div id="gst-amount-hint"></div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        
                                                        <div class="form-group">
                                                        <label for="from_phone">Net Amount <span class="pre_gst" style="color:gray;font-weight:100;text-align:end;"></span></label>
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary round-of-visible" data-toggle="tooltip"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" name="total_amount" maxlength="6" disabled="" class="form-control" id="total_amount" data-mask="positivedecimal" placeholder="0" style=" font-size: 14px; font-weight: bold;"/>
                                                            </div>
                                                        </div>
                                                        
                                                    </div>

                                                    <div class="col-md-2 hide" id="total_paying_amount_div">
                                                        <div class="form-group">
                                                            <label for="from_phone">Now Paying</label>
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text"  maxlength="6" class="form-control" id="total_paying_amount" data-mask="positivedecimal" placeholder="0" style=" font-size: 14px; font-weight: bold;"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    {if $action_rights['CARGO-TDS-TAX']==1}
                                                        <div class="col-md-2 hide" id="tds_tax_div">
                                                            <div class="form-group">
                                                                <label for="tds_tax_percent">TDS</label>
                                                                <div class="row">
                                                                    <div class="col-md-7 p_r_n">
                                                                        <select class="form-control" id="tds_tax_percent" onchange="calculateTDSPercent(this.value);">
                                                                            <option value="0">Nil</option>
                                                                            <option value="2">2%</option>
                                                                            {* <option value="5">5%</option>
                                                                            <option value="8">8%</option>
                                                                            <option value="10">10%</option> *}
                                                                        </select>
                                                                    </div>
                                                                    <div class="col-md-5 p_l_n">
                                                                        <input type="text" class="form-control" id="tds_tax" value="0" data-mask="positivedecimal" onblur="setNowPayAmount()" disabled>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    {/if}

                                                    <div class="col-md-4 w-auto">
                                                        <div class="form-group" id="booking-form-bttons">
                                                            <label for="from_phone">&nbsp;</label>
                                                            {if $cargo_setting->bookingPreviewFlag == 1}
                                                                <button class="btn btn-success" type="button" onclick="saveBooking(1)">Preview & Confirm</button>&nbsp;
                                                            {else}
                                                                <button class="btn btn-success" type="button" id="confirm-booking-btn" onclick="saveBooking()">Confirm</button>&nbsp;
                                                            {/if}
                                                            <button type="button" class="btn btn-default" onclick="checkURL();">Clear</button>&emsp;
                                                            <label for="remember-booking" class="d-inline">
                                                                <input type="checkbox" id="remember-booking" name="remember-booking"/>
                                                                Remember Details
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <input type="hidden" id="total_amount_roundoff">
                                                </div>
                                            </div>

                                        </div>


                                    </div>

                                    <input type="hidden" id="lr-prebooking-code">
                                    <input type="hidden" id="lr-reference-code">
                                </div>
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>

<div id="address-dialog" class="dialog-content-page" style="display: none">
    <div  style="padding: 15px;">

        <div class="row">
             <div class="col-md-6">
                <div class="form-group">
                    <label for="c_address1" class="req">Address 1</label>
                    <input type="text" name="c_address1" value="" class="form-control" id="c_address1" maxlength="50"  placeholder="Address1" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="c_address1" >Address 2</label>
                    <input type="text" name="c_address2" value="" class="form-control" id="c_address2" maxlength="50"  placeholder="Address2" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="c_city" class="req">City</label>
                    <input type="text" name="c_city" value="" class="form-control" id="c_city" maxlength="50"  placeholder="City" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="c_state" class="req">State</label>
                    <input type="text" name="c_state" value="" class="form-control" id="c_state" maxlength="50"  placeholder="State" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="c_city" class="">Landmark</label>
                    <input type="text" name="c_landmark" value="" class="form-control" id="c_landmark" maxlength="50"  placeholder="Landmark" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="c_state" class="">Pincode</label>
                    <input type="text" name="c_pincode" value="" class="form-control" id="c_pincode" maxlength="10"  placeholder="Pincode" />
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-md-8">
                 <div class="alert" style="display:none;" id="addr-action-state"> </div>
            </div>
            <div class="col-md-4 text-right" id="addr-form-buttons">
                <button class="btn btn-success" type="button" onclick="saveBookingAddress();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelAddress();">Cancel</button>
                <input type="hidden" id="c_add_type" value="">
            </div>
        </div>

    </div>

</div>

<script id="branch-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-9">
            <b class="branch-name"></b><br>
            <span class="station-name text-muted small"></span>
        </div>
        <div class="col-xs-3 text-right">
            <b class="branch-code"></b><br>
            <span class="station-code text-muted small"></span>
        </div>
    </div>
</script>

<script id="vendor-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-9">
            <b class="vendor-name d-inline-block" style="max-width: 350px; overflow: hidden;"></b><br>
            <span class="station-name text-muted small"></span>
        </div>
        <div class="col-xs-3 text-right">
            <b class="vendor-code"></b><br>
            <span class="station-code text-muted small"></span>
        </div>
    </div>
</script>

<div id="volumetric-calc-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideVolumetricDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="volumetric-calc-panel" class="clearfix" style="padding: 10px 5px;">
        <form onsubmit="return false;">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="req">Dimension Unit</label>
                        <select id="volumetric-unit" class="form-control" onchange="setVolumetricUnit()">
                            <option value="CM">Centimeters</option>
                            <option value="IN">Inches</option>
                            <option value="FT">Feet</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-12 p-0 d-flex">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="req">Length</label>
                            <input type="text" class="form-control" placeholder="Length" id="volumetric-length" data-mask="positivedecimal"/>
                        </div>
                    </div>
                    <div class="col-md-4 p_l_n">
                        <div class="form-group">
                            <label class="req">Width</label>
                            <input type="text" class="form-control" placeholder="Width" id="volumetric-width" data-mask="positivedecimal"/>
                        </div>
                    </div>
                    <div class="col-md-4 p_l_n">
                        <div class="form-group">
                            <label class="req">Height</label>
                            <input type="text" class="form-control" placeholder="Height" id="volumetric-height" data-mask="positivedecimal"/>
                        </div>
                    </div>
                    <div class="col-md-4 p_l_n cont hide">
                        <div class="form-group">
                            <label class="req">Value</label>
                            <input type="text" class="form-control" placeholder="Value" id="volumetric-value" data-mask="positivedecimal"/>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div id="volumetric-calc-action-state"></div>
                </div>

                <div class="col-md-12 text-right" id="volumetric-calc-panel-btn">
                    <button type="submit" class="btn btn-success" id="volumetric-calc-btn" onclick="calcVolumetricUOM();">Calculate</button>&nbsp;
                    <button type="button" class="btn btn-default" onclick="hideVolumetricDialog();">Cancel</button>&nbsp;
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    var p_address = {};
    var d_address = {};

    var p_c_address = '';
    var d_c_address = '';

    var customers = {$customers|json_encode};
    // var drivers = {$drivers|json_encode};
    var drivers = [];
    var items = {$items|json_encode};
    var vendors = [];
    var branchRoutes = {$branchRoutes|json_encode};
    var cargoSetting = {$cargo_setting|json_encode};
    var payTypeConfig = {$pay_type|json_encode};
    var bankNamesList = {$bank_names_list|json_encode};
    var cargoRemarksList = {$cargoremarks|json_encode};
    var machineHandlingTariff = {$machine_handling_tariff|json_encode};
    var stationsData = {$stations|json_encode};
    // var organisation = {$organization|json_encode};
    var deliveryBranch = {$delivery_branches|json_encode};

    var userOrganizationCode = '{$userDetail['org_code']}';
    var userStationCode = '{$userDetail['org_station_code']}';
    var userData = {$groupusers['loginUser']|json_encode};

    var cargoRateTermsRoute = [];
    var ns = {$namespace|json_encode};
    var referenceLRDetails = {$referenceLRDetails|json_encode};
    var subTransactionMode = $('#transaction-mode-sub option');
    var gstModal = cargoSetting.gstTaxComputeModel;
    var addIncludeGST = "OTHER_CHARGES";
    var vendorList = [];  //verdor details for showing onAccount

    function refUserValidate(){
        let userNameElm = $('#ref-user');
        let amountElm = $('#ref-amount');
        let selectorElm = $('#refer-checkbox');

        let userName = $('#ref-user').val();
        let amount = $('#ref-amount').val();
        let selector = $('#refer-checkbox');

        if(userName !="" && (amount == "")){
            amountElm.css('border-color','red');
            // selectorElm.prop('checked', true);
        }else{
            amountElm.css('border-color','black');
        }
        if(userName != "" && amount != ""){
            selectorElm.prop('checked', true);
        }else{
            selectorElm.prop('checked', false);
        }

    }

    if (ns == 'newlinetrans') {
        $('[name="sender-gst-type"][value="CMPY"]').prop('checked', true).trigger('change');
        $('[name="receiver-gst-type"][value="CMPY"]').prop('checked', true).trigger('change');
    }

    $(document).on('click', '.allow-focus', function (e) {
      e.stopPropagation();
    });

    $('#bkg-private-mark').on('input', function(){
        this.value = this.value.replace(/[^a-zA-Z\d\s:]/, '').toUpperCase();
    });

    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover',
        template: '<div class="popover" style="max-width: max-content"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>'
    });

    function _init_cargo_booking_page() {
        init_cargo_booking_page_actions();
    }

    $('#bkg-vehicle').select2();
    $('#cb-on-behalf-user').select2();
    $('.bsn_switch').bootstrapSwitch();
    $('#include-gst').on('switchChange.bootstrapSwitch', function (e, state) {
        $(this).data('includegst', state.value);
        calculateAmounts();
    });

    // Main
    $('#upi-orgbank-main').select2();
    $('#netbanking-orgbank-main').select2();
    $('#netbanking-bankname-main').autocomplete({
        minLength: 0,
        source: bankNamesList
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#cheque-bankname-main').autocomplete({
        minLength: 0,
        source: bankNamesList
    }).focus(function(){
        $(this).autocomplete('search', '');
    });
    $('#cheque-date-main').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true,
        startDate: '-1d',
        endDate:'0d'
    });

    // Sub
    $('#upi-orgbank-sub').select2();
    $('#netbanking-orgbank-sub').select2();
    $('#netbanking-bankname-sub').autocomplete({
        minLength: 0,
        source: bankNamesList
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#cheque-bankname-sub').autocomplete({
        minLength: 0,
        source: bankNamesList
    }).focus(function(){
        $(this).autocomplete('search', '');
    });
    $('#cheque-date-sub').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true,
        startDate: '-1d',
        endDate:'0d'
    });

    $('[data-mask]').each(function () {
        $(this).inputmask({ alias: $(this).data('mask') });
    });

    // $('#invoice-list').on('input', '.e_way_bill_number', '.inv_number, .inv_amount', function () {
    //     var $emptyrows = $('#invoice-list .invoice-row').filter(function () {
    //         return $.trim($(this).find('.inv_number').val()) === '' && $.trim($(this).find('.inv_amount').val()) === '';
    //     });

    //     $emptyrows.not($(this).parents('.invoice-row')).remove();

    //     if ($emptyrows.length < 2) {
    //         addInvoiceRow();
    //     }
    // }); 

    $('#ddtype-btn-group').on('click', 'label', function (e) {
        if ($(this).find('[name="dd-type"]').is(':checked')) {
            $(this).removeClass('active').find('[name="dd-type"]').prop('checked', false).trigger('change');
            e.preventDefault();
            e.stopPropagation();
            return false;
        }
    });

    $('.fs-addon-checkbox').on('change', function (e) {
        $('[data-fs="' + this.value + '"]').prop('disabled', this.checked).val(0).trigger('change');
        calculateAmounts();
    });

    $('#transaction-mode-main').on('change', function() {
        var mainMode = $(this).val();
        $('#transaction-mode-sub').html(function () {
            return subTransactionMode.filter(function () {
                return $(this).val() != mainMode;
            });
        }).val($('#transaction-mode-sub option:first').val()).trigger('change');
    });

    var branchSelectTpl = $('#branch-select-tpl').html();
  
    $('#receiver_gst').on('input', function (e) {
        let rawData=e.target.value;
        data=rawData.toUpperCase();
        let lengthData=data.length;
        let gstAmount = $('#service_tax');
        let sourceElement = $('#sender_gst').val();
        if(lengthData>14){
            if (cargoSetting.lrGstTaxModel == 'RCMGST') {
                if(isValidGstin(data)){
                    $('#receiver-gst-error').hide();
                    if(sourceElement!=""){
                        gstAmount.val(0);
                        }
                }else{
                    getGSTDetails('receiver');
                    $('#receiver-gst-error').show();
                }
            }
        }
    });

    $('#sender_gst').on('input', function (e) {
        let rawData=e.target.value;
        data=rawData.toUpperCase();
        let lengthData=data.length;
        let gstAmount = $('#service_tax');
        let sourceElement = $('#receiver_gst').val();
        if(lengthData>14){
            if (cargoSetting.lrGstTaxModel == 'RCMGST') {
                if(isValidGstin(data)){
                    $('#receiver-gst-error').hide();
                    if(sourceElement!=""){
                        gstAmount.val(0);
                        }
                }else{
                    getGSTDetails('receiver');
                    $('#receiver-gst-error').show();
                }
            }
        }
    });
    function formatResult(branch) {
        if (!branch.id) return branch.text;
        var $tpl = $(branchSelectTpl);
        if(debug == true){
            $tpl.find('.branch-name').text(branch.code);
        }else{
            $tpl.find('.branch-name').text(branch.name);
        }
        $tpl.find('.branch-code').text(branch.shortCode);
        $tpl.find('.station-name').text(branch.station.name);
        $tpl.find('.station-code').text(branch.station.shortCode);
        return $tpl;
    };

    function matcher(term, text, branch) {
        text = [branch.name, branch.shortCode, branch.station.name, branch.station.shortCode].join(' ');
        return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
    };

    var vendorSelectTpl = $('#vendor-select-tpl').html();

    function formatVendorResult(vendor) {
        if (!vendor.id) return vendor.text;

        var $tpl = $(vendorSelectTpl);
        $tpl.find('.vendor-name').text(vendor.companyName);
        $tpl.find('.vendor-code').text(vendor.shortCode);
        $tpl.find('.station-name').text(vendor.station.name);
        $tpl.find('.station-code').text(vendor.station.shortCode);
        return $tpl;
    };

    function vendorMatcher(term, text, vendor) {
        text = [vendor.companyName, vendor.shortCode, vendor.station.name, vendor.station.shortCode].join(' ');
        return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
    };
    $(function () {
        var fromBranches = [];
        $.each(branchRoutes || [], function (i, row) {
            // if (row.bookingDeliveryFlag.charAt(0) != '1') return; 
            // if (!row.bookingDeliveryFlag || row.bookingDeliveryFlag.charAt(0) != '1') return; 
            // if (!row.organization || !row.station || !row.station.code) return;
            var branch = row;
            branch.id = branch.code;
            branch.text = branch.name;
            fromBranches.push(branch);
        });
        $('#from_branch').select2({
            data: { results: fromBranches },
            placeholder: 'Select From Branch',
            formatResult: formatResult,
            formatSelection: formatResult,
            matcher: matcher
        });

        toggleToBranch();
        // togglePayType();

       

        // $('#vendor_users').select2({
        //     width: '100%',
        //     data: { results: vendorList },
        //     placeholder: 'Select Credit Customers',
        //     formatResult: formatVendorResult,
        //     formatSelection: formatVendorResult,
        //     matcher: vendorMatcher
        // });

        var stationsGrouped = {};
        $.each(stationsData || [], function (i, station) {
            if (station.activeFlag == 1) {
                if (!stationsGrouped[station.state.code]) {
                    stationsGrouped[station.state.code] = {};
                    stationsGrouped[station.state.code].text = station.state.name;
                    stationsGrouped[station.state.code].children = [];
                }
                station.id = station.code;
                station.text = station.name;
                stationsGrouped[station.state.code].children.push(station);
            }
        });
        stationsGrouped = Object.values(stationsGrouped);

        $('#from_station').select2({
            width: '100%',
            data: { results: stationsGrouped },
            placeholder: 'Select From Station'
        });

        $('#to_station').select2({
            width: '100%',
            data: { results: stationsGrouped },
            placeholder: 'Select To Station'
        });

        $('#fr_addr_station, #to_addr_station').select2({
            width: '100%',
            data: { results: stationsGrouped },
            placeholder: 'Select City'
        });

        $('#route-info').on('change', function(e) {
            if (menu_permission['MAN-LR-NO'] == 1 && $(e.target).is('#from_station, #from_branch, #to_station, #to_branch, [name="pay_type_radio"]')) {
                getManualLRNumber();
            }
            if (menu_permission['CARGO-RATE-CARD'] == 1 && $(e.target).is('#from_station, #from_branch, #to_station, #to_branch, [name="pay_type_radio"], #vendor_users, #from_name, #from_phone, #to_name, #to_phone')) {
                getTariffRateCard();
            }
            if ($(e.target).is('#from_station, #from_branch, #to_station, #to_branch, #vendor_users, #from_name, #from_phone, #to_name, #to_phone, [name="pay_type_radio"]') && cargoSetting.userAccountModel.code == 'DINV') {
                getNextLrSequence();
            }
        });

        if (cargoSetting.userAccountModel.code == 'DINV') {
            $('#sender-gst-type, [name="lr-load-type"], [name="lr-shipment-type"], [name="lr-no-type"]').on('change', function(e) {
                getNextLrSequence();
            });
        }
    });


    function togglePayTypeState(){
        // set login branch user payment motheds in booking page
        var bookingArray = [];
        var bookingPaymentTypeList = [];
        var route = _.find(branchRoutes, i => i.code == userOrganizationCode);
        var paymentHtml = '';
        //  if (route.bookingPaymentTypes.length == 0) {
            $('#pay_type').html('Choose Any From Station');
            $.each(route.bookingPaymentTypes || [], function(i, val) {
                if (menu_permission['CARGO-FREE-SERVICE'] != 1 && val.code == 'FS') {
                    return;
                }
                paymentHtml += '<span class="radio">' +
                        '<label>' +
                            '<input type="radio" name="pay_type_radio" value="' + val.code + '">' + val.name +
                        '</label>' +
                    '</span>';
            });
        //  }
            $('#pay_type').html(paymentHtml);
      
        setPaytypeSettings();
    }
    //state payment type flow end


    function toggleToBranch() {
        var fromBranch = $('#from_branch').select2('data');
        var fromBranchCode = $('#from_branch').val();
        var shipmentType = $('[name="lr-shipment-type"]:checked').val();
        fromBranchCode = $('#from_branch').val();

        var toBranches = [];
            if (fromBranch) {
                var route = _.find(branchRoutes, i => i.code == fromBranchCode);

                if (menu_permission['SAME-BRCH-BOOK'] == 1) {
                    toBranches.push(fromBranch);
                }            
                $.each(deliveryBranch[fromBranchCode] || [],(i,isBranch)=>{
                    $.each(branchRoutes || [],(j,branch)=>{
                        if(branch.code == isBranch){   
                            branch.id = branch.code;
                            branch.text = branch.name;
                            toBranches.push(branch);  
                        }
                    })
                })
                $('#fr_addr_station').val(route.station.code);
            } else {
                $('#from_branch').val('').trigger('change');
            };

        $('#to_branch').select2('destroy');
        $('#to_branch').select2({
            data: { results: toBranches },
            placeholder: 'Select To Branch',
            formatResult: formatResult,
            formatSelection: formatResult,
            matcher: matcher
        });
     

        $('#to_branch').val('').trigger('change');
    }
    $('#to_branch').change(function(){
        connectionCharges();
    });

    //from brnach wise payment type
    function togglePayType() {  //for branch wise selection
        var bookingArray = [];
        var bookingPaymentTypeList = [];
        var fromBranch = $('#from_branch').select2('data');
        var fromBranchCode = $('#from_branch').val();
        if (!fromBranch || !fromBranchCode) {
            $('#pay_type').html('<i class="fa fa-info-circle"></i> Please select From Branch');
            setPaytypeSettings();
            return;
        }

        var route = _.find(branchRoutes, i => i.code == fromBranchCode);
        var paymentHtml = '';

        $.each(route.deliveryPaymentTypes || [], function(i, e) {
            bookingPaymentTypeList[e.code] = e.name;
            bookingArray.push(e);
        });

        var userPayementTypeList = {};
        var userPayementTypeCount = 0;
        if (userData && Array.isArray(userData.bookingPaymentType)) {
            userPayementTypeCount = userData.bookingPaymentType.length;
            $.each(userData.bookingPaymentType || [], function(i, e) {
                userPayementTypeList[e.code] = e.name;
            });
        }
        $('#pay_type').html('<i class="fa fa-info-circle"></i> Please select To Branch');
        $('#to_addr_station').val(route.station.code);
        setPaytypeSettings();
        return bookingArray;
    }
    var bookingArray = togglePayType();
    $('#from_branch').on('change', function () {
        bookingArray = togglePayType();
    });
    //to branch wise payment type selector
    function toggleToPayType() {
        var tobranch = $('#to_branch').select2('data');
        var tobranchCode = $('#to_branch').val();
        var frombranch = $('#from_branch').select2('data');
        if (!tobranch || !tobranchCode) {
            $('#pay_type').html('<i class="fa fa-info-circle"></i> Please select From Branch');
            setPaytypeSettings();
            return;
        }
        //to branch payment types
   
        var route = _.find(branchRoutes, i => i.code == tobranchCode);
        var paymentHtml = '';
        var deliveryArray = [];
        var deliveryPaymentTypeList = {};
        $.each(route.deliveryPaymentTypes || [], function(i, e) {
            deliveryPaymentTypeList[e.code] = e.name;
            deliveryArray.push(e);
        });

        //from branch types
        var fromRoute = _.find(branchRoutes, i => i.code == frombranch.code);
        var paymentHtml = '';
        var bookingArray = [];
        var bookingPaymentTypeList = {};
        $.each(fromRoute.bookingPaymentTypes || [], function(i, e) {
            bookingPaymentTypeList[e.code] = e.name;
            bookingArray.push(e);
        });
        if (deliveryArray.length == 0) {
            $.each(bookingArray || [], function(i, val) {
                if (menu_permission['CARGO-FREE-SERVICE'] != 1 && val.code == 'FS') {
                    return;
                }
                if(val.code == "INP"){
                    val.name = '{lang('INP')}';
                }
                if(val.code == "OATP"){
                    val.name = '{lang('OATP')}';
                }
                paymentHtml += '<span class="radio">' +
                        '<label>' +
                            '<input type="radio" name="pay_type_radio" value="' + val.code + '">' + val.name +
                        '</label>' +
                    '</span>';
            });
            $('#pay_type').html(paymentHtml);
        } else {
            var result = findIntersection(bookingArray,deliveryArray, 'code');
            $.each(result || [], function(i, val) {
                if (menu_permission['CARGO-FREE-SERVICE'] != 1 && val.code == 'FS') {
                    return;
                }
                if(val.code == "INP"){
                    val.name = '{lang('INP')}';
                }
                if(val.code == "OATP"){
                    val.name = '{lang('OATP')}';
                }
                paymentHtml += '<span class="radio">' +
                        '<label>' +
                            '<input type="radio" name="pay_type_radio" value="' + val.code + '">' + val.name +
                        '</label>' +
                    '</span>';
            });
            $('#pay_type').html(paymentHtml);
        }

        $('#to_addr_station').val(route.station.code);
        setPaytypeSettings();
    }

//payment type flow end    
    function setArticleUnit(unitsel) {
        if (menu_permission['CARGO-UNITS'] != 1) {
            return;
        }
        var price = 0;
        var article_row = $(unitsel).closest('.article_row');
        var unitValue = $(article_row).find('#article-unit-val').val();
        var unit = $(article_row).find('#article-unit').val();
        var billableKG = Number(cargoSetting.billableKg) || 0;

        if (isNaN(unitValue) || unitValue < 1 || unit == 'NPPKG') {
            unitValue = 1;
            $(article_row).find('#article-unit-val').val(unitValue);
        }

        var article = $(article_row).find('#name').data('uiAutocomplete').selectedItem;

        if (menu_permission['CARGO-RATE-CARD'] == 1) {
            if (article) {
                var itemDetail = null;
                $.each(cargoRateTermsRoute || [], function (i, item) {
                    if (item.cargoItem.code == article.code) {
                        itemDetail = _.find(item.itemDetailList || [], function (d) {
                            if (unit == 'VOL') return d.unit.code == 'VOL' || d.unit.code == 'VOLFT';
                            return d.unit.code == unit;
                        });
                        return false;
                    }
                });

                if (itemDetail) {
                    unitValue = (unitValue < itemDetail.minUnitValue) ? itemDetail.minUnitValue : Number(unitValue);
                    $(article_row).find('#article-unit-val').val(unitValue);
                    $(article_row).find('#price').val($('.fs-addon-checkbox[value="FR"]').is(':checked') ? 0 : itemDetail.amount);
                    $(article_row).find('#handling').val(itemDetail.loadingCharge);
                    $('#volumetric-value').data('default', itemDetail.unit.code == 'VOLFT' ? itemDetail.additionalValue : '');
                }
            }
        } else {
            if (unit == 'KG' && unitValue < billableKG) {
                unitValue = billableKG;
                $(article_row).find('#article-unit-val').val(billableKG);
            }
            if (article) {
                price = article.defaultRate;
            }
            $(article_row).find('#price').val($('.fs-addon-checkbox[value="FR"]').is(':checked') ? 0 : price);
        }

        if (unit == 'VOL') {
            showVolumetricDialog(article_row);
        }
    }

    function setMinWeight(unitsel){
        var article_row = $(unitsel).closest('.article_row');
        if(unitsel.value == 'KG'){
            $(article_row).find('#article-unit-val').val(cargoSetting.billableKg || 0).trigger('change');
        }
    }

    function validateMinHandling(el) {
        var $handlinginp = $(el);
        var minHandling = $handlinginp.data('min') || 0;

        if ($handlinginp.val() < minHandling) {
            $handlinginp.val(minHandling);
        }
    }

    function getPaymentType() {
        return $('[name="pay_type_radio"]:checked').val() || '';
    }
    {literal}
    function setPaytypeSettings(pos, clear = true) {
        // $('#netbanking-mode-panel-main').html();
        // $('#upi-mode-panel-main').html();
        // $('#cheque-mode-panel-main').html();
        var paytypeCode = $('[name="pay_type_radio"]:checked').val();
        var fromBranch = $('#from_branch').select2('data');
        var fromBranchcode  = $('#from_branch').val();
        var route = _.find(branchRoutes, i => i.code == fromBranchcode);
        
     
        $('#vendor_users').select2('val', '');
        $('#bk-customer-calculation').addClass('hide');

        $('#tds_tax_percent, #tds_tax').val(0);
    
        $('#vendor_users_div').addClass('hide');
        $('#transaction_mode_div').addClass('hide');
        $('#total_paying_amount_div').addClass('hide');
        $('#tds_tax_div').addClass('hide');

        if (paytypeCode == 'INP' || paytypeCode == 'OATP') {
            $.ajax({
                type: "get",
                url: "cargo/get_vendors_list",
                dataType: "json",
                success: function (response) {
                    vendors = [];
                    vendorList = [];
                    try {
                        $.each(response, function (index,val) { 
                            vendors.push(val);
                        });
                        
                        $.each(response || [], function (i, vendor) {
                            if (vendor.activeFlag == 1) {
                                vendor.id = vendor.code;
                                vendor.text = vendor.name;
                                vendorList.push(vendor);
                            }
                        });
                        $('#vendor_users_div').removeClass('hide');
                        $('#vendor_users').select2({
                            width: '100%',
                            data: { results: vendorList },
                            placeholder: 'Select Credit Customers',
                            formatResult: formatVendorResult,
                            formatSelection: formatVendorResult,
                            matcher: vendorMatcher
                        });
                    } catch (error) {
                        console.error(error);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.error("AJAX Error:", textStatus, errorThrown);
                }
            });
            
        } else if (paytypeCode == 'PAD') {
            $('#transaction-mode-main, #transaction-mode-sub').val('CASH').trigger('change');
            $('#transaction_mode_div').removeClass('hide');
            $('#bk-customer-calculation').removeClass('hide');
            $('#tds_tax_div').removeClass('hide');
            if (cargoSetting.userAccountModel.code == 'TXRT' && menu_permission['ALW-PART-PAYMENT'] == 1) {
                $('#total_paying_amount_div').removeClass('hide');
            }
            var options ="";
           $.each(route.transactionMode, function (index, mode) { 
             options+= `
               <option value="${mode.code}">${mode.name}</option>
             `;
           });
           $('#transaction-mode-main').html(options);
        }

        if (paytypeCode && window.setupDoorPickup) {
            setupDoorPickup();
            setupDoorDelivery();
        }

        if (!paytypeCode || (ns != 'rajeshcargo' && ns != 'rajeshexpress')) {
            return;
        }

        if(clear && isArticleSelected()) {
            alert('Selected Articles will be cleared');
            resetArticles();
            return;
        }

        if (paytypeCode == 'TOP' || paytypeCode == 'PAD') {
            var $article_row = $(pos ? ('#article_row_' + pos) : '.article_row');

            if (!$('.fs-addon-checkbox[value="LC"]').is(':checked')) {
                $article_row.find('#handling').val(cargoSetting.defaultLoadigCharge || 0).data('min', cargoSetting.defaultLoadigCharge || 0).trigger('blur');
            }
        }
    }
{/literal}

    function setVendorSettings(pos, clear = true) {
        var vendorCode = $('#vendor_users').val();

        vendorInfoTooltip(vendorCode, '#vendor_users_info', { placement: 'top' });
        if(!vendorCode) {
            return;
        }

        var data = _.find(vendors, function(o) { return o.code == vendorCode; });
        var paytype = getPaymentType();
        var cus = {};
        cus.from_phone = $.trim( $('#from_phone').val() );
        cus.from_name = $.trim( $('#from_name').val() );
        cus.to_phone = $.trim( $('#to_phone').val() );
        cus.to_name = $.trim( $('#to_name').val() );

        if (paytype == 'INP') {
            if (typeof data !== 'undefined' && data !== null) {
                if (data.mobileNumber) {
                    $('#from_phone').typeahead('val', data.mobileNumber);
                }
                if (data.name) {
                    $('#from_name').typeahead('val', data.name);
                }
                if (data.gst) {
                    $('#sender_gst').typeahead('val', data.gst);
                }
                formatCustomerAddress(1, data.mobileNumber);
            }
        }
        if (paytype == 'OATP') {
            $('#to_phone').typeahead('val', data.mobileNumber);
            $('#to_name').typeahead('val', data.name);
            $('#receiver_gst').typeahead('val', data.gst);
            formatCustomerAddress(2, data.mobileNumber);
        }

        if (ns != 'rajeshcargo' && ns != 'rajeshexpress') {
            return;
        }

        if(clear && isArticleSelected()) {
            alert('Selected Articles will be cleared');
            resetArticles();
            return;
        }

        var $article_row = $(pos ? ('#article_row_' + pos) : '.article_row');

        if (!$('.fs-addon-checkbox[value="LC"]').is(':checked') && data.loadingCharge > 0) {
            $article_row.find('#handling').val(data.loadingCharge).data('min', data.loadingCharge);
        } else if (data.loadingCharge == -1) {
            $article_row.find('#handling').val(0).data('min', 0);
        }

        if (data.unloadingCharge > 0) {
            $article_row.find('#unloading').val(data.unloadingCharge).data('min', data.unloadingCharge).trigger('blur');
        } else if (data.loadingCharge == -1) {
            $article_row.find('#unloading').val(0).data('min', 0).trigger('blur');
        }
    }

    function isArticleSelected() {
        return $('.article_row').length > 1 || $('.article_row:first').find('#name').val() != '';
    }

    function resetArticles() {
        $('.article_row .tr_remove').trigger('click');
        getAllInputs();
    }

    function setPODValue() {
        var charge = $('#pod_charges').data('charge') || 0;
        var isenabled = $('#pod_charges_enable').is(':checked')
        $('#pod_charges').val(isenabled ? charge : 0);
    }

    function hasRCMBasedGST() {
        var senderGST = $.trim($('#sender_gst').val());
        var receiverGST = $.trim($('#receiver_gst').val());
        var payment_type = getPaymentType();
        if (cargoSetting.lrGstTaxModel == 'RCMGST') {
            return isValidGstin(senderGST) && isValidGstin(receiverGST);
        }
        if (cargoSetting.lrGstTaxModel == 'RCMEOGST') {
            return isValidGstin(senderGST) || isValidGstin(receiverGST);
        }
        
        if (cargoSetting.lrGstTaxModel == 'RCMPYGST') {
            if (payment_type == 'PAD') {
                return isValidGstin(senderGST);
            }

            if (payment_type == 'TOP') {
                return isValidGstin(receiverGST);
            }
        }
        
        return false;
    }

    function validateInvAmount() {
        var invoiceAmount = 0;
        $('#invoice-list .invoice-row').each(function () {
            invoiceAmount += Number($(this).find('.inv_amount').val());
        });

        $('#eway_bill_hint').html('');
        if (!isNaN(invoiceAmount) && invoiceAmount < 50000) {
            return;
        }

        if (isNull($('#eway_bill').val())) {
            $('#eway_bill_hint').html('E-Way Bill required for Invoice Amount greater than 50,000');
        }
    }

    function getEwayBillData() {
        var data = {};
        data.ewayBillNo = $('#eway_bill').val();

        if (isNull(data.ewayBillNo)) {
            return;
        }

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/get-ewaybill-data',
            data: data,
            success: function (res) {
                if (res.status == 1) {
                    if (isNotNull(res.data.fromTaxPayerDetails.tradeName)) {
                        $('#from_name').typeahead('val', res.data.fromTaxPayerDetails.tradeName);

                        var $firstOption = $('.tt-dataset-SENDER_NAME .tt-suggestion:first');
                        if ($firstOption.length) {
                            var selectedData = $firstOption.data(); 
                            selectFromCustomer(selectedData.ttSelectableObject);
                        }
                    }

                    if (isNotNull(res.data.toTaxPayerDetails.tradeName)) {
                        $('#to_name').typeahead('val', res.data.toTaxPayerDetails.tradeName);

                        var $firstOption = $('.tt-dataset-RECEIVER_NAME .tt-suggestion:first');
                        if ($firstOption.length) {
                            var selectedData = $firstOption.data(); 
                            selectToCustomer(selectedData.ttSelectableObject);
                        }
                    }

                    if (isNotNull(res.data.fromTaxPayerDetails.gstin)) {
                        $('#sender_gst').typeahead('val', res.data.fromTaxPayerDetails.gstin);
                    }
                    
                    if (isNotNull(res.data.toTaxPayerDetails.gstin)) {
                        $('#receiver_gst').typeahead('val', res.data.toTaxPayerDetails.gstin);
                    }
                }
            }
        });
    }

    function setArticleFreight(freightinp) {
        if (!freightinp) {
            return;
        }

        var article_row = $(freightinp).closest('.article_row');
    
        var item = $(article_row).find('#name').data('uiAutocomplete').selectedItem;
        if (!item) {
            return;
        }
        
        var fromOrg = $('#from_branch').select2('data') || {};
        if (!fromOrg.deviationPercentage && !item.minFreightAmount) {
            return;
        }
        
        var minValue = item.minFreightAmount;

        if (fromOrg.deviationPercentage > 0) {
            var percentValue = fromOrg.deviationPercentage / 100 * item.minFreightAmount;
            minValue = Math.floor(item.minFreightAmount - percentValue);
        }

        if (freightinp.value < minValue) {
            $(freightinp).val(minValue);
        }
    }

    function setMinDeliveryCharges(input) {
        var minvalue = $(input).data('minvalue') || 0;

        if (!minvalue || minvalue < Number(input.value)) return;
        $(input).val(minvalue);
    }

    function getTariffRateCard() {
        if (menu_permission['CARGO-RATE-CARD'] != 1) {
            return;
        }
        if ($.trim($('#prebooking-find').val()) || $.trim($('#lr-reference-code:hidden').val())) {
            return;
        }
        var data = {};
        data.fromStation = {};
        data.toStation = {};
        
        data.fromOrganization = {};
        data.toOrganization = {};
        var lrLoadType = $('[name="lr-load-type"]:checked').val();
        if (lrLoadType == 'FTL' || lrLoadType == 'PTL') {
            var fromStationData = $('#from_station').select2('data') || {};
            data.fromStation.code = fromStationData && fromStationData.code;

            var toStationData = $('#to_station').select2('data') || {};
            data.toStation.code = toStationData && toStationData.code;
        } else if (lrLoadType == 'RGL') {
            var fromOrgData = $('#from_branch').select2('data') || {};
            data.fromStation.code = fromOrgData.station && fromOrgData.station.code;
            data.fromOrganization.code = fromOrgData && fromOrgData.code;

            var toOrgData = $('#to_branch').select2('data') || {};
            data.toStation.code = toOrgData.station && toOrgData.station.code;
            data.toOrganization.code = toOrgData && toOrgData.code;
        }

        data.additionalAttribute = {};
        data.additionalAttribute.LOAD_TYPE = lrLoadType;

        data.paymentType = {};
        data.paymentType.code = $('[name="pay_type_radio"]:checked').val() || '';

        data.vendorUser = {};
        data.vendorUser.code = $('#vendor_users').val();

        data.fromCustomer = {};
        data.fromCustomer.mobileNumber = $('#from_phone').val();

        var toCustomer = $('#to_phone').data('customerData') || {};
        data.toCustomer = {};
        data.toCustomer.mobileNumber = $('#to_phone').val();

        data.paymentType = {};
        data.paymentType.code = $('[name="pay_type_radio"]:checked').val();
        
        if (!data.fromStation.code || !data.toStation.code) {
            return;
        }
        if ((data.paymentType.code == 'INP' || data.paymentType.code == 'OATP') && !data.vendorUser.code) {
            return;
        }
        if (!data.fromCustomer.mobileNumber || !data.toCustomer.mobileNumber) {
            return;
        }

        noty({
            layout: 'topRight',
            theme: 'tisa_theme',
            type: 'information',
            text: 'Tariff Rate Card Loading...',
            closeWith: [],
            killer: true,
            timeout: 30000
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/get-tariff-rate-card",
            data: data,
            success: function (res) {
                if (res.status == 1) {
                    noty({
                        layout: 'topRight',
                        theme: 'tisa_theme',
                        type: 'success',
                        text: 'Tariff Rate Card Loaded Successfully',
                        closeWith: ['button'],
                        killer: true,
                        timeout: 5000
                    });
                    cargoRateTermsRoute = res.data.itemDetailList || [];

                    masterItems = [];
                    itemsMapped = _.keyBy(cargoRateTermsRoute, o => o.cargoItem.code);
                    $.each(items || [], function (i, item) {
                        if (itemsMapped[item.code] || res.data.itemDetailList.length == 0) {
                            masterItems.push(item);
                        }
                    });

           
                    $('#article_row_1').find('#name').autocomplete({
                    minLength: 0,
                    source: masterItems,
                    select: function (event, ui) {
                        var $article_row = $(this).closest('tr.article_row');
                        setTimeout(function () {
                            select_article(ui.item, $article_row);
                        });
                    },
                    change: function(event, ui) {
                        var $article_row = $(this).closest('.article_row');
                        if (!ui.item && !cargoSetting.allowNewArticle) {
                            notice('new article is not allowed');
                            $(this).val(''); 
                            $(this).data('selectedIndex',"");
                            $article_row.find('#article-desc').val('');
                            $article_row.find('#code').val("");
                            $article_row.find('.iqty').val(1);
                            $article_row.find('.irate').val(0);
                            $article_row.find('.iunit').val('NPPKG');
                            $article_row.find('.iunitval').val(1);
                            $article_row.find('.ilcharge').val(0);
                            $article_row.find('.iucharge').val(0);
                            $article_row.find('.itotal').val(0);

                        }
                    }
                }).focus(function () {
                    $(this).autocomplete('search', '');
                });

                    $('#docket_charges').val(res.data.docketCharge || 0);
                    $('#hamali_charges').val(res.data.hamaliCharge || 0);
                    if ($('#door-pickup').is(':checked')) {
                        $('#dp_charges').val(res.data.doorPickupCharge || 0);
                    }
                    if ($('#ddtype-btn-group [name="dd-type"]:checked').val()) {
                        $('#dd_charges').val(res.data.doorDeliveryCharge || 0);
                    }
                    resetArticles();
                    
                } else {
                    noty({
                        layout: 'topRight',
                        theme: 'tisa_theme',
                        type: 'error',
                        text: res.errorDesc,
                        closeWith: ['button'],
                        killer: true,
                        timeout: 5000
                    });
                }
            }
        });
    }

    function showVolumetricDialog(article_row) {
        $('#volumetric-calc-dialog').removeClass('hide');
        $('#volumetric-calc-dialog').dialog({
            autoOpen: true,
            height: 320,
            width: 550,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
        $('#volumetric-calc-dialog .inp_error').removeClass('inp_error');
        $('#volumetric-unit').val(localStorage.getItem('booking_volumetric_unit') || 'CM').trigger('change');
        $('#volumetric-length').val('');
        $('#volumetric-width').val('');
        $('#volumetric-height').val('');

        $('#volumetric-length').focus();
        $('#volumetric-calc-btn').data('article_row', article_row);
    }

    function hideVolumetricDialog() {
        $('#volumetric-calc-dialog').dialog('destroy');
        $('#volumetric-calc-dialog').hide();
        
        var article_row = $('#volumetric-calc-btn').data('article_row');
        $(article_row).find('#article-unit').val('NPPKG').trigger('change');
    }

    function calcVolumetricUOM() {
        var unit = $.trim($('#volumetric-unit').val());
        var length = $.trim($('#volumetric-length').val());
        var width = $.trim($('#volumetric-width').val());
        var height = $.trim($('#volumetric-height').val());
        var value = $.trim($('#volumetric-value').val());

        var err = 0;
        $('#volumetric-calc-dialog .inp_error').removeClass('inp_error');
        if (unit == '') {
            $('#volumetric-unit').addClass('inp_error');
            err++;
        }
        if (length == '' || isNaN(length)) {
            $('#volumetric-length').addClass('inp_error');
            err++;
        }
        if (width == '' || isNaN(width)) {
            $('#volumetric-width').addClass('inp_error');
            err++;
        }
        if (height == '' || isNaN(height)) {
            $('#volumetric-height').addClass('inp_error');
            err++;
        }
        if (unit == 'FT' && (value == '' || isNaN(value))) {
            $('#volumetric-value').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            return;
        }
        
        var article_row = $('#volumetric-calc-btn').data('article_row');

        if (unit == 'FT') {
            var capacity = Math.round((parseFloat(length) * parseFloat(width) * parseFloat(height) * parseFloat(value)));
            $(article_row).find('#article-unit-val').val(capacity);
            $(article_row).find('#article-unit-volumetric').val('(' + [length, width, height, value].join('X') + ' ' + unit + ')');
        } else {
            if (unit == 'CM') {
                var denominator = 28316;
            } else if (unit == 'IN') {
                var denominator = 1728;
            }
            var capacity = Math.round((parseFloat(length) * parseFloat(width) * parseFloat(height)) / denominator * 6);
            $(article_row).find('#article-unit-val').val(capacity);
            $(article_row).find('#article-unit-volumetric').val('(' + [length, width, height].join('X') + ' ' + unit + ')');
        }
        calculateAmounts();

        $('#volumetric-calc-dialog').dialog('destroy');
        $('#volumetric-calc-dialog').hide();

        localStorage.setItem('booking_volumetric_unit', unit);
    }

    function calculateTDSPercent(percent) {
        $('#tds_tax').val('0').prop('disabled', percent == 0);
        calculateAmounts();
    }

    function calculateFOVPercent(percent) {
        $('#fov_charge').val('0').prop('disabled', percent != 0);
        calculateAmounts();
    }

    function setTransactionMode(type) {
        var mode = $('#transaction-mode-'+type).val();
        var payment_type = getPaymentType();
        
        if( mode == "NA" || mode == ""){
            return;
        } 

        $('#cheque-mode-panel-'+type).addClass('hide');
        $('#netbanking-mode-panel-'+type).addClass('hide');
        $('#upi-mode-panel-'+type).addClass('hide');
        $('#bk-customer-calculation').addClass('hide');

        if (mode == 'CASH') {
            if (payment_type == 'PAD') {
                $('#bk-customer-calculation').removeClass('hide');
            }
        }

        if (mode == 'CHEQUE') {
            $('#cheque-mode-panel-'+type).removeClass('hide');
        } else if (mode == 'NBK') {
            $('#netbanking-mode-panel-'+type).removeClass('hide');

            $('#netbanking-orgbank-'+type).html(new Option('Loading...', '', true, true)).select2().html('');
        } else if (mode == 'UPI') {
            $('#upi-mode-panel-'+type).removeClass('hide');
            
            $('#upi-orgbank-'+type).html(new Option('Loading...', '', true, true)).select2().html('');
        }

        var data = {};
        data.organizationcode = $('#from_branch').val();

        if (!data.organizationcode) {
            return;
        }

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/get-organization-other-details',
            data: data,
            success: function (res) {
                if (res.status == 1) {
                    res.data.bankDetails = res.data.bankDetails || [];
                    if (mode == 'NBK') {
                        $('#netbanking-orgbank-'+type).html('');
                        if (res.data.bankDetails.length > 1) {
                            $('#netbanking-orgbank-'+type).html(new Option('Select Organization Bank', ''));
                        }
                        $.each(res.data.bankDetails, function (i, bank) {
                            if (bank.accountType.code != 'CASH') {
                                $('#netbanking-orgbank-'+type).append(new Option(bank.name + ' - ' + bank.accountNumber, bank.code));
                            }
                        });
                        $('#netbanking-orgbank-'+type).select2();
                    } else if (mode == 'UPI') {
                        $('#upi-orgbank-'+type).html('');
                        if (res.data.bankDetails.length > 1) {
                            $('#upi-orgbank-'+type).html(new Option('Select Organization Bank', ''));
                        }
                        $.each(res.data.bankDetails, function (i, bank) {
                            if (bank.accountType.code != 'CASH') {
                                $('#upi-orgbank-'+type).append(new Option(bank.name + ' - ' + bank.accountNumber, bank.code));
                            }
                        });
                        $('#upi-orgbank-'+type).select2();
                    }
                }
            }
        });
    }

    function setSenderGSTType() {
        var type = $('#sender-gst-type [name="sender-gst-type"]:checked').val();
        $('#sender-company-panel').toggleClass('hide', type == 'INDL');
    }

    function setReceiverGSTType() {
        var type = $('#receiver-gst-type [name="receiver-gst-type"]:checked').val();
        $('#receiver-company-panel').toggleClass('hide', type == 'INDL');
    }

    function toggleFreeMachineHandling() {
        setTimeout(function () {
            calcMachineHandlingCharges();
            calculateAmounts();
        }, 0);
    }

    function calcMachineHandlingCharges() {
        if (menu_permission['CARGO-MACHINE-HANDLING'] != 1) {
            return;
        }
        $('#machine_handling_charges').val(0);

        if (!$('.fs-addon-checkbox[value="MC"]').is(':checked')) {
            var unitValue = 0;
            $('#article_rows .article_row').each(function () {
                var unitCode = $(this).find('#article-unit').val();

                if (unitCode == 'KG') {
                    unitValue += Number($(this).find('#article-unit-val').val()) || 0;
                }
            });

            $.each(machineHandlingTariff || [], function (i, tariff) {
                if (unitValue >= tariff.fromUnitValue && unitValue < tariff.toUnitValue) {
                    $('#machine_handling_charges').val(tariff.amount);
                    return false;
                }
            });
        }
    }

    function toggleLRSequence() {
        var type = $('[name="lr-no-type"]:checked').val();
        if (type == 'AUTO') {
            $('#manual-lr-no').closest('.cont').addClass('hide');
            $('#next-lr-sequence').closest('.nextlrseq').removeClass('hide');
        } else if (type == 'MANUAL') {
            $('#manual-lr-no').removeClass('inp_error');
            $('#manual-lr-status').html('');
            $('#manual-lr-no').closest('.cont').removeClass('hide');
            $('#next-lr-sequence').closest('.nextlrseq').addClass('hide');
        }
    }

    
    function toggleLRLoadType() {
        var type = $('[name="lr-load-type"]:checked').val();
        //type == RGL (regular booking)  //choose intensic payment type from branch and to branch
        //type == FTL/PTL (Full truck load/ partial truck load)  //show login branch payment type
        $('#from_station, #to_station').closest('.cont').addClass('hide');
        $('#from_branch, #to_branch').closest('.cont').addClass('hide');
        if (type == 'RGL') {
            $('#from_branch, #to_branch').closest('.cont').removeClass('hide');
            // selected branch payment method to tobrach selected branch intensic payment method loaded function
            togglePayType();
            toggleToPayType();
        } else if (type == 'FTL' || type == 'PTL') {
            $('#from_station, #to_station').closest('.cont').removeClass('hide');
            $('#from_branch').val(userOrganizationCode).trigger('change');
            // login branch payment type listing method
            togglePayTypeState();
        }
    }
    toggleLRLoadType();

    function setVolumetricUnit() {
        var unit = $.trim($('#volumetric-unit').val());
        $('#volumetric-value').val($('#volumetric-value').data('default'));
        $('#volumetric-value').closest('.cont').toggleClass('hide', unit != 'FT');
    }

    function getBookingBalanceReturnAmount(ele) {
        var customerAmount = Number($(ele).val());
        var payableAmount = Number($('#total_amount').val());

        var balanceReturnAmount = 0;
        if (isNotNull(customerAmount) && isNotNull(payableAmount)) {
            balanceReturnAmount = customerAmount - payableAmount;
        }
        $('#bk-balance-return-amount').val(balanceReturnAmount);
    }

    function calculateSplitup() {
        var subAmount = Number($('#amount-sub').val()) || 0;
        var mainAmount = Number($('#amount-main').val()) || 0;
        var netAmount = Number($('#total_amount').val()) || 0;
        if (netAmount > 0 && subAmount > 0 && subAmount < netAmount) {
            $('#amount-main').val(netAmount-subAmount);
        } else {
            $('#amount-main').val(netAmount);
            $('#amount-sub').val(0);
        }
    }

    var inputs = $(document).find('input,select,#dropdownMenu1,#dropdownMenu2').filter(':visible:not([readonly]):not([type="hidden"]):not([disabled])');
    function getAllInputs() {
        inputs = $(document).find('input,select,#dropdownMenu1,#dropdownMenu2').filter(':visible:not([readonly]):not([type="hidden"]):not([disabled])');
    }

    $(document).on('keypress', 'input,select,#dropdownMenu1,#dropdownMenu2', function (e) {
        if (e.which == 13) {
             console.log(document.activeElement)
            const currInput = document.activeElement;
            const currInputIndex = inputs.index(currInput);
            const nextinputIndex = (currInputIndex + 1) % inputs.length;
            const input = inputs[nextinputIndex];
            input.focus();
        }
    });
    function connectionCharges() {
        var toBranch = $('#from_branch').select2('data');
        var tobranchCode = $('#from_branch').val();
        let selectedValue =$('#to_branch').val();
        let isHubBranch=false;
        
        var route = _.find(branchRoutes, i => i.code == tobranchCode);
        $.each(route,function (key,value){
            if(selectedValue==value.code){
                if(value.transitHubBranchFlag==true){
                    isHubBranch=true;
                }
             }
        });
        
        if (isHubBranch==true) {
            $('#connectingCharge').removeClass('hide');
            let cnnCharge = {$cargo_setting->connectingChargeValue};
            let cnnChargeType = '{$cargo_setting->connectingChargeType}';
            let totalCharge = 0;
            let showCharge=0;
            let totalQty=0;
            if (cnnChargeType == "QTY") {
                $('.qty-input').each(function() {
                    let dinam =$(this).val();
                    totalQty+=dinam;
                    showCharge = (dinam >= 1) ? dinam * cnnCharge :0;
                    totalCharge += showCharge;
                });
            }else if(cnnChargeType == "FLT") {
                showCharge = cnnCharge;
                totalCharge = showCharge;
            } else {
                totalCharge = 0;
                showCharge=0;
            }
            $('#connectingChargeValue').val(totalCharge);
        } else {
            $('#connectingCharge').addClass('hide');
            $('#connectingChargeValue').val(0);
        }
    }
    function customChecked() {
    var elm = $('.customChecker');
    var inputElm = elm.find('input');
    inputElm.prop('checked', !inputElm.prop('checked'));

    if (inputElm.prop('checked')) {
        elm.addClass('checkerActive');
    } else {
        elm.removeClass('checkerActive');
    }
    setupDoorPickup();calculateAmounts();getAllInputs();
}
</script>
