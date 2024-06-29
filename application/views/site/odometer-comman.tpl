<div id="start-trip-dialog" style="display: none">
    <div id="start-trip-panel" class="clearfix" style="padding: 10px 5px;max-height: 600px; ">
        <form onsubmit="return false;">
            <input type="hidden" id="allowLoad">
            <div class="row">
                <div class="col-md-4 text-center">
                    <img src="assets/img/start-trip.png" width="65%">
                </div>
                <div class="col-md-4 text-center">
                    <h4 class="bold">Departure Time</h4>
                    <h5 id="trip-start-date"></h5>
                    <h4 id="trip-start-time"></h4>
                </div>
                <div class="col-md-4 text-center">
                    <h5 class="bold">Last odometer Reading</h5>
                    <h5><span class="last-odometer"></span> Km</h5>
                </div>
                <div class="clearfix"></div>

                <div class="col-md-12">
                    <label class="h5">Fill The Following Details To Start Trip</label>
                    <h6 class="bold">Odometer</h6>
                    <div class="row">
                        <div class="col-md-4">
                            <label class="control-label req" for="">Odometer</label>
                            <input type="number" id="start-trip-odo" class="form-control no-spin" placeholder="Odometer">
                        </div>
                        <div class="col-md-4 p_l_n">
                            <div class="input-group col-md-12">
                                <label class="control-label" for="">Supervisor</label>
                                <select id="start-trip-supervisor" class="form-control">
                                    <option value="" selected>Select Supervisor</option>
                                    {foreach item=row from=$branchContact}
                                        {if $row->category->code == 'SPVSR'}
                                            <option value="{$row->code}">{$row->name}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>

                    <div id="start-trip-expense">
                        <h6 class="bold">Payments</h6>
                        <div class="row">
                            {if  $namespace === "seenutransport" && isset($ownershipTypeing['OWN'])}
                                <div class="col-md-4">
                                    <label class="control-label" for="">Advance Amount</label>
                                    <input type="number" id="start-trip-advance-amount" class="form-control no-spin" placeholder="Advance Amount">
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group col-md-12">
                                        <label class="control-label" for="">Payment Mode</label>
                                        <select id="start-trip-adv-paymode" class="form-control" onchange="setStartTripTransactionMode();">
                                            <option value="" selected>Payment Mode</option>
                                            {foreach name=o key=k item=name from=$f_t_mode}
                                                <option value="{$k}">{$name}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4 p_l_n">
                                    <label class="control-label" for="">Payment By</label>
                                    <select id="start-trip-adv-payby" class="form-control">
                                        <option value="" selected>Payment By</option>
                                        {foreach from=$contact item=con key=key}
                                            {foreach from=$con item=val}
                                                {if $val->contactCategory->actionCode == 'BRCH'}
                                                    <option value="{$val->code}">{$val->name}</option>
                                                {/if}
                                            {/foreach}
                                        {/foreach}
                                    </select>
                                </div>
                            {elseif  $namespace === "seenutransport" && isset($ownershipTypeing['HIRE'])}
                                <div id="start-trip-hiring-amt">
                                    <div class="col-md-4">
                                        <label class="control-label" for="">Hiring Amount</label>
                                        <input type="number" class="form-control" id="start-trip-hire-amount" placeholder="Hiring Amount" step="any">
                                    </div>
                                    <div class="clearfix"></div><br>
                                </div>

                                <div class="col-md-4">
                                    <label class="control-label" for="">Advance Amount</label>
                                    <input type="number" id="start-trip-advance-amount" class="form-control no-spin" placeholder="Advance Amount">
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group col-md-12">
                                        <label class="control-label" for="">Payment Mode</label>
                                        <select id="start-trip-adv-paymode" class="form-control" onchange="setStartTripTransactionMode();">
                                            <option value="" selected>Payment Mode</option>
                                            {foreach name=o key=k item=name from=$f_t_mode}
                                                <option value="{$k}">{$name}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4 p_l_n">
                                    <label class="control-label" for="">Payment By</label>
                                    <select id="start-trip-adv-payby" class="form-control">
                                        <option value="" selected>Payment By</option>
                                        {foreach from=$contact item=con key=key}
                                            {foreach from=$con item=val}
                                                {if $val->contactCategory->actionCode == 'BRCH'}
                                                    <option value="{$val->code}">{$val->name}</option>
                                                {/if}
                                            {/foreach}
                                        {/foreach}
                                    </select>
                                </div>
                            {elseif  $namespace === "seenutransport" && isset($ownershipTypeing['ATCH'])}

                                <div class="col-md-4">
                                    <label class="control-label" for="">Advance Amount</label>
                                    <input type="number" id="start-trip-advance-amount" class="form-control no-spin" placeholder="Advance Amount">
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group col-md-12">
                                        <label class="control-label" for="">Payment Mode</label>
                                        <select id="start-trip-adv-paymode" class="form-control" onchange="setStartTripTransactionMode();">
                                            <option value="" selected>Payment Mode</option>
                                            {foreach name=o key=k item=name from=$f_t_mode}
                                                <option value="{$k}">{$name}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4 p_l_n">
                                    <label class="control-label" for="">Payment By</label>
                                    <select id="start-trip-adv-payby" class="form-control">
                                        <option value="" selected>Payment By</option>
                                        {foreach from=$contact item=con key=key}
                                            {foreach from=$con item=val}
                                                {if $val->contactCategory->actionCode == 'BRCH'}
                                                    <option value="{$val->code}">{$val->name}</option>
                                                {/if}
                                            {/foreach}
                                        {/foreach}
                                    </select>
                                </div>
                            {else}
                                <div id="start-trip-hiring-amt">
                                    <div class="col-md-4">
                                        <label class="control-label" for="">Hiring Amount</label>
                                        <input type="number" class="form-control" id="start-trip-hire-amount" placeholder="Hiring Amount" step="any">
                                    </div>
                                    <div class="clearfix"></div><br>
                                </div>
                                <div class="col-md-4">
                                    <label class="control-label" for="">Advance Amount</label>
                                    <input type="number" id="start-trip-advance-amount" class="form-control no-spin" placeholder="Advance Amount">
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group col-md-12">
                                        <label class="control-label" for="">Payment Mode</label>
                                        <select id="start-trip-adv-paymode" class="form-control" onchange="setStartTripTransactionMode();">
                                            <option value="" selected>Payment Mode</option>
                                            {foreach name=o key=k item=name from=$f_t_mode}
                                                <option value="{$k}">{$name}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4 p_l_n">
                                    <label class="control-label" for="">Payment By</label>
                                    <select id="start-trip-adv-payby" class="form-control">
                                        <option value="" selected>Payment By</option>
                                        {foreach from=$contact item=con key=key}
                                            {foreach from=$con item=val}
                                                {if $val->contactCategory->actionCode == 'BRCH'}
                                                    <option value="{$val->code}">{$val->name}</option>
                                                {/if}
                                            {/foreach}
                                        {/foreach}
                                    </select>
                                </div>
                            {/if}

                            <div class="clearfix"></div><br>
                            <div class="hide" id="start-trip-adv-upi-mode-panel">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="start-trip-adv-upi-orgbank">Organization Bank</label>
                                        <select class="form-control" id="start-trip-adv-upi-orgbank">
                                            <option value="">Select Organization Bank</option>
                                            {foreach from=$bankdetail item=val}
                                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}
                                                </option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="start-trip-adv-upi-id">UPI ID</label>
                                        <input type="text" class="form-control" id="start-trip-adv-upi-id" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="start-trip-adv-upi-details">Ref. #</label>
                                        <input type="text" class="form-control" id="start-trip-adv-upi-details" placeholder="Ref. #" autocomplete="off">
                                    </div>
                                </div>
                            </div>

                            {* Netbanking *}
                            <div class="hide" id="start-trip-adv-netbanking-mode-panel">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="start-trip-adv-netbanking-orgbank">Organization Bank</label>
                                        <select class="form-control" id="start-trip-adv-netbanking-orgbank">
                                            <option value="">Select Organization Bank</option>
                                            {foreach from=$bankdetail item=val}
                                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}
                                                </option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="start-trip-adv-netbanking-accholder">Account Holder Name</label>
                                        <input type="text" class="form-control" id="start-trip-adv-netbanking-accholder" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group" id="start-trip-adv-netbanking-bankname-div">
                                        <label for="start-trip-adv-netbanking-bankname">Bank Name</label>
                                        <input type="text" class="form-control" id="start-trip-adv-netbanking-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="start-trip-adv-netbanking-details">Ref. #</label>
                                        <input type="text" class="form-control" id="start-trip-adv-netbanking-details" placeholder="Ref. #" autocomplete="off">
                                    </div>
                                </div>
                            </div>

                            {* Cheque *}
                            <div class="hide" id="start-trip-adv-cheque-mode-panel">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-payer">Payer Details</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-payer" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-no">Cheque No</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-no" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-date">Cheque Date</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-date" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-bankcity">Bank City</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-bankcity" maxlength="90" placeholder="Bank City" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group" id="start-trip-adv-cheque-bankname-div">
                                        <label for="start-trip-adv-cheque-bankname">Bank Name</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-remarks">Remarks</label>
                                        <input type="text" class="form-control" placeholder="Remarks" id="start-trip-adv-cheque-remarks" data-mask="englishonly" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <h6 class="bold">Fuel Expense</h6>
                        <div class="row">
                            <div class="col-md-2">
                                <label class="control-label" for="">Fuel Litres</label>
                                <input type="number" id="start-trip-fuel-litres" class="form-control no-spin" placeholder="Fuel Litres">
                            </div>
                            <div class="col-md-2">
                                <label class="control-label" for="">Fuel Rate / Liter</label>
                                <input type="number" class="form-control" id="start-trip-fuel-rate" placeholder="Fuel Rate / Liter" step="any">
                            </div>
                            <div class="col-md-3">
                                <div class="input-group col-md-12">
                                    <label class="control-label" for="">Vendor</label>
                                    <select id="start-trip-fuel-vendor" class="form-control">
                                        <option value="" selected>Select Vendor</option>
                                        {foreach item=row from=$vendors}
                                            {if $row->contactCategory->actionCode == 'RAC'}
                                                <option value="{$row->code}">{$row->name}</option>
                                            {/if}
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="input-group col-md-12">
                                    <label for="start-trip-fuel-payment-mode" class="req">Payment Mode</label>
                                    <select id="start-trip-fuel-payment-mode" class="form-control">
                                        <option value="CASH">Cash Payment</option>
                                        <option value="CRDT">Credit Payment</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <label class="control-label" for="">Fuel Coupon</label>
                                <input type="text" class="form-control" id="start-trip-fuel-coupon" placeholder="Fuel Coupon">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 text-center"><br>
                    <div id="start-trip-action-state"></div>
                    <button type="submit" class="btn btn-warning col-md-3" id="start-trip-btn" onclick="startTransitodometerTrip();" style="float: none;">Start Trip</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    var loadedVehicle = {$loadedVehicle|json_encode};
    var transitCode = {$transitCode|json_encode};
    var vehicle ={$vehicle|json_encode};
    
    function startTransitodometerTrip() {
        var allowLoading = $("#allowLoad").val();
        if (allowLoading == false) {
            alert("This OGPL vehicle cannot ablicable to load LRs");
        }
        var data = {},
            err = 0;
        data.action = "DEPARTURE";
        data.transitCode =transitCode;
        data.transitCargo = {};
        data.transitCargo.code =transitCode;
        data.fromOrganization = {};
        data.fromOrganization.code = user_login_branch;
        data.startOdometer = Number($("#start-trip-odo").val());
        data.departureAt = moment().format("YYYY-MM-DD HH:mm:ss");
        data.fromOrganizationContact = {};
        data.fromOrganizationContact.code = $("#start-trip-supervisor").val();

        $(".inp_error").removeClass("inp_error");
        if (
            isNaN(data.startOdometer) ||
            data.startOdometer < 0 ||
            data.startOdometer == ""
        ) {
            $("#start-trip-odo").addClass("inp_error");
            err++;
        }
       
        if (
            vehicle &&
            vehicle.lastOdometer > 0 &&
            data.startOdometer < vehicle.lastOdometer
        ) {
            $("#start-trip-action-state")
                .removeClass("alert-success hide")
                .addClass("alert alert-danger")
                .show();
            $("#start-trip-action-state").html(
                "Entered odometer value should be greater than last odometer value"
            );
            return;
        }

        if (isNull(odoDetails) || (odoDetails && odoDetails.startOdometer == 0)) {
            // fuel expense
            data.fuelExpenseCode = "";
            data.activeFlag = 1;
            data.fuelDate = moment().format("YYYY-MM-DD");
            data.vehicle = {};
            data.vehicle.code = loadedVehicle;

            data.vendorContact = {};
            data.vendorContact.code = $("#start-trip-fuel-vendor").val();

            data.transactionMode = {};
            data.transactionMode.code = $("#start-trip-fuel-payment-mode").val();

            data.litres = Number($("#start-trip-fuel-litres").val());
            data.pricePerLitre = Number($("#start-trip-fuel-rate").val());
            data.totalAmount = data.litres * data.pricePerLitre;
            data.billNumber = $.trim($("#start-trip-fuel-coupon").val());

            // hiring amount and advance amount
            data.ogpl = [];

            if (
                (cargoSetting.userAccountModel.code == "TXRT" &&
                    vehicle.ownershipType.code == "HIRE") ||
                cargoSetting.userAccountModel.code != "TXRT"
            ) {
                var hire = {};

                hire.code = "";
                hire.activeFlag = 1;
                hire.amount = Number($("#start-trip-hire-amount").val());
                hire.remarks = "";

                hire.user = {};
                hire.user.code = login_user;

                hire.transitCargo = {};
                hire.transitCargo.code = transitCode;

                hire.cashbookType = {};
                hire.cashbookType.code = "HIRING";

                if (Number(hire.amount) > 0) {
                    data.ogpl.push(hire);
                }
            }

            var advance = {};

            advance.code = "";
            advance.activeFlag = 1;
            advance.amount = Number($("#start-trip-advance-amount").val());
            advance.remarks = "";

            advance.user = {};
            advance.user.code = login_user;

            advance.transitCargo = {};
            advance.transitCargo.code = transitCode;

            advance.transactionMode = {};
            advance.transactionMode.code = $("#start-trip-adv-paymode").val();

            advance.cashbookType = {};
            advance.cashbookType.code = "ADVANCE";

            advance.paymentByContact = {};
            advance.paymentByContact.code = $("#start-trip-adv-payby").val();

            if (advance.transactionMode.code == "UPI") {
                advance.bankDetails = {};
                advance.bankDetails.code = $("#start-trip-adv-upi-orgbank").val();
                advance.addAttr1 = $.trim($("#start-trip-adv-upi-id").val());
                advance.addAttr2 = $.trim($("#start-trip-adv-upi-details").val());
            } else if (advance.transactionMode.code == "NBK") {
                advance.bankDetails = {};
                advance.bankDetails.code = $("#start-trip-adv-netbanking-orgbank").val();
                advance.addAttr1 = $.trim(
                    $("#start-trip-adv-netbanking-accholder").val()
                );
                advance.addAttr2 = $.trim($("#start-trip-adv-netbanking-bankname").val());
                advance.addAttr3 = $.trim($("#start-trip-adv-netbanking-details").val());
            } else if (advance.transactionMode.code == "CHEQUE") {
                advance.chequeDetails = {};
                advance.chequeDetails.code = $("#start-trip-adv-chq-code").val();
                advance.chequeDetails.activeFlag = 1;

                advance.chequeDetails.organization = {};
                advance.chequeDetails.organization.code = "{$login_branch}";

                advance.chequeDetails.bankDetails = $.trim(
                    $("#start-trip-adv-cheque-bankname").val()
                );
                advance.chequeDetails.payerDetails = $.trim(
                    $("#start-trip-adv-cheque-payer").val()
                );

                advance.chequeDetails.chequeDate = moment(
                    $("#start-trip-adv-cheque-date").val(),
                    "DD-MM-YYYY"
                ).format("YYYY-MM-DD");
                advance.chequeDetails.chequeNo = $.trim(
                    $("#start-trip-adv-cheque-no").val()
                );
                advance.chequeDetails.bankCity = $.trim(
                    $("#start-trip-adv-cheque-bankcity").val()
                );

                advance.chequeDetails.chequeStatus = {};
                advance.chequeDetails.chequeStatus.code = "NEW";

                advance.chequeDetails.remarks = $.trim(
                    $("#start-trip-adv-cheque-remarks").val()
                );
            }

            if (Number(advance.amount) > 0) {
                data.ogpl.push(advance);
            }

            // advance amount
            if ( (cargoSetting.userAccountModel.code == "TXRT" && $.inArray(OGPLFormData.cargoActivityType.code, ["OTFD", "INTRNT"]) !=
                    -1 &&
                    vehicle.ownershipType.code == "OWN" &&
                    !isNull(hire) &&
                    hire.amount != "") ||
                (cargoSetting.userAccountModel.code != "TXRT" &&
                    !isNull(hire) &&
                    hire.amount != "") ||
                advance.amount != "" ||
                advance.transactionMode.code != "" ||
                advance.paymentByContact.code != ""
            ) {
                if (!isNull(hire) && hire.amount == "") {
                    $("#start-trip-hire-amount").addClass("inp_error");
                    err++;
                }

                if (advance.amount == "") {
                    $("#start-trip-advance-amount").addClass("inp_error");
                    err++;
                }

                if (advance.transactionMode.code == "") {
                    $("#start-trip-adv-paymode").addClass("inp_error");
                    err++;
                }

                if (advance.paymentByContact.code == "") {
                    $("#start-trip-adv-payby").addClass("inp_error");
                    err++;
                }

                if (advance.transactionMode.code == "UPI") {
                    if (advance.addAttr1 == "") {
                        $("#start-trip-adv-upi-id").addClass("inp_error");
                        err++;
                    }

                    if ($("#start-trip-adv-upi-orgbank").val() == "") {
                        $("#start-trip-adv-upi-orgbank").addClass("inp_error");
                        err++;
                    }

                    if (advance.addAttr2 == "") {
                        $("#start-trip-adv-upi-details").addClass("inp_error");
                        err++;
                    }
                } else if (advance.transactionMode.code == "NBK") {
                    if (advance.addAttr1 == "") {
                        $("#start-trip-adv-netbanking-accholder").addClass("inp_error");
                        err++;
                    }

                    if (advance.addAttr2 == "") {
                        $("#start-trip-adv-netbanking-bankname").addClass("inp_error");
                        err++;
                    }

                    if ($("#start-trip-adv-netbanking-orgbank").val() == "") {
                        $("#start-trip-adv-netbanking-orgbank").addClass("inp_error");
                        err++;
                    }

                    if (advance.addAttr3 == "") {
                        $("#start-trip-adv-netbanking-details").addClass("inp_error");
                        err++;
                    }
                } else if (advance.transactionMode.code == "CHEQUE") {
                    if (advance.chequeDetails.payerDetails == "") {
                        $("#start-trip-adv-cheque-payer").addClass("inp_error");
                        err++;
                    }

                    if ($("#start-trip-adv-cheque-date").val() == "") {
                        $("#start-trip-adv-cheque-date").addClass("inp_error");
                        err++;
                    }

                    if (advance.chequeDetails.chequeNo == "") {
                        $("#start-trip-adv-cheque-no").addClass("inp_error");
                        err++;
                    }

                    if (advance.chequeDetails.bankDetails == "") {
                        $("#start-trip-adv-cheque-bankname").addClass("inp_error");
                        err++;
                    }

                    if (advance.chequeDetails.bankCity == "") {
                        $("#start-trip-adv-cheque-bankcity").addClass("inp_error");
                        err++;
                    }
                }
            }

            // fuel expense
            if (
                data.vendorContact.code != "" ||
                data.litres != "" ||
                data.pricePerLitre != "" ||
                data.billNumber != ""
            ) {
                if (data.vendorContact.code == "") {
                    $("#start-trip-fuel-vendor").addClass("inp_error");
                    err++;
                }

                if (data.litres == "") {
                    $("#start-trip-fuel-litres").addClass("inp_error");
                    err++;
                }

                if (data.pricePerLitre == "") {
                    $("#start-trip-fuel-rate").addClass("inp_error");
                    err++;
                }

                if (data.billNumber == "") {
                    $("#start-trip-fuel-coupon").addClass("inp_error");
                    err++;
                }
            }
        }

        if (err) {
            $("#start-trip-action-state")
                .removeClass("alert-success hide")
                .addClass("alert alert-danger")
                .show();
            $("#start-trip-action-state").html(
                "Please enter/select the values in the field that are marked in red"
            );
            return;
        }
        $("#start-trip-panel-btn").hide();
        $("#start-trip-action-state")
            .removeClass("alert")
            .removeClass("alert-danger")
            .removeClass("alert-success")
            .html(loading_popup);
        var transitList = [];
        $('#transit-type [name="transit-type"]:checked').each(function() {
            transitList.push($(this).val());
        });
        //check is empty load with outfordelivery
        var is_emtpy_with_load =
            transitList.includes("INTRNT") && transitList.includes("OTFD");
        var onlyEmptyLoad =
            transitList.includes("INTRNT") && !transitList.includes("OTFD");
        // if(is_emtpy_with_load){
        //     console.log($('.local-via-branches').val());
        //     let toOrganizationForLocal=$('#local-via-branches option:selected').val();
        //         data.toOrganization.code=toOrganizationForLocal;
        // }
        $.ajax({
            type: "POST",
            dataType: "json",
            url: base_url + "cargo/update-start-odometer",
            data: data,
            success: function(response) {
                if (response.status == 1) {

                    startOdoUpdated == 1;
                    $("#start-trip-action-state")
                        .addClass("alert")
                        .addClass("alert-success")
                        .html("Your request processed successfully");
                    window.setTimeout(function() {
                        closeInvoicePdfDialog();
                        if (!is_emtpy_with_load) {
                            let transitcode = transitCode;
                            var params = {};
                            params.transitCode = transitcode;

                            if (allowLoading == false) {
                                window.location.reload();
                            } else {
                                var url =
                                    base_url +
                                    "#cargo/add-ogpl?" +
                                    $.param(params) +
                                    "&INTRNT=HIDE";
                                window.open(url, "_self");
                                checkURL();
                            }
                        }
                    }, 3000);
                } else {
                    $("#start-trip-action-state")
                        .addClass("alert")
                        .addClass("alert-danger")
                        .html(response.errorDesc);
                    $("#start-trip-panel-btn").show();
                }
            },
        });
    }
</script>