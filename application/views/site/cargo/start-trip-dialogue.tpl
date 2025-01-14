<style>
.title-line{
    text-decoration-line: underline;
}
#start-trip-panel{
    padding:0 0;
}
#start-trip-action-state{
    margin: 0;
    padding:5px 0;
}
</style>
<div>
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideStartTripDialog();"><i
                class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="start-trip-panel" class="clearfix"
        style="padding: 10px 5px;max-height: 600px;overflow-x: hidden;overflow-y: auto;">
        <form onsubmit="return false;">
            <input type="hidden" id="allowLoad">
            <div class="row">
                <div class="col-md-4 text-center">
                    <img src="assets/img/start-trip.png" width="65%">
                </div>
                <div class="col-md-4 text-center">
                    <h4 class="bold">Departure Time</h4>
                    <h5 id="trip-start-date">{date('Y-m-d H:i:s')|date_format:"%d %b %Y"}</h5>
                    <h4 id="trip-start-time">{date('Y-m-d H:i:s')|date_format:"%I : %M %p"}</h4>
                </div>
                <div class="col-md-4 text-center">
                    <h5 class="bold">Last odometer Reading</h5>
                    <h5><b class="last-odometer">{$vehicle->lastOdometer}</b> Km</h5>
                    <small class="text-muted">{$vehicle->registationNumber}</small>
                </div>
                <div class="clearfix"></div>
                  
                <div class="col-md-12">
                    <label class="h5">Fill The Following Details To Start Trip</label>
                    <h6 class="bold title-line">Odometer</h6>
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
                        <h6 class="bold title-line">Payments</h6>
                        <div class="row">
                            {if  $namespace === "seenutransports" && isset($ownershipTypeing['OWN'])}
                                <div class="col-md-4">
                                    <label class="control-label" for="">Advance Amount</label>
                                    <input type="number" id="start-trip-advance-amount" class="form-control no-spin"
                                        placeholder="Advance Amount">
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group col-md-12">
                                        <label class="control-label" for="">Payment Mode</label>
                                        <select id="start-trip-adv-paymode" class="form-control"
                                            onchange="setStartTripTransactionMode();">
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
                            {elseif  $namespace === "seenutransports" && isset($ownershipTypeing['HIRE'])}
                                <div id="start-trip-hiring-amt">
                                    <div class="col-md-4">
                                        <label class="control-label" for="">Hiring Amount</label>
                                        <input type="number" class="form-control" id="start-trip-hire-amount"
                                            placeholder="Hiring Amount" step="any">
                                    </div>
                                    <div class="clearfix"></div><br>
                                </div>

                                <div class="col-md-4">
                                    <label class="control-label" for="">Advance Amount</label>
                                    <input type="number" id="start-trip-advance-amount" class="form-control no-spin"
                                        placeholder="Advance Amount">
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group col-md-12">
                                        <label class="control-label" for="">Payment Mode</label>
                                        <select id="start-trip-adv-paymode" class="form-control"
                                            onchange="setStartTripTransactionMode();">
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
                            {elseif  $namespace === "seenutransports" && isset($ownershipTypeing['ATCH'])}

                                <div class="col-md-4">
                                    <label class="control-label" for="">Advance Amount</label>
                                    <input type="number" id="start-trip-advance-amount" class="form-control no-spin"
                                        placeholder="Advance Amount">
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group col-md-12">
                                        <label class="control-label" for="">Payment Mode</label>
                                        <select id="start-trip-adv-paymode" class="form-control"
                                            onchange="setStartTripTransactionMode();">
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
                                        <input type="number" class="form-control" id="start-trip-hire-amount"
                                            placeholder="Hiring Amount" step="any">
                                    </div>
                                    <div class="clearfix"></div><br>
                                </div>
                                <div class="col-md-4">
                                    <label class="control-label" for="">Advance Amount</label>
                                    <input type="number" id="start-trip-advance-amount" class="form-control no-spin"
                                        placeholder="Advance Amount">
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group col-md-12">
                                        <label class="control-label" for="">Payment Mode</label>
                                        <select id="start-trip-adv-paymode" class="form-control"
                                            onchange="setStartTripTransactionMode();">
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
                                        <input type="text" class="form-control" id="start-trip-adv-upi-id" maxlength="250"
                                            placeholder="UPI ID" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="start-trip-adv-upi-details">Ref. #</label>
                                        <input type="text" class="form-control" id="start-trip-adv-upi-details"
                                            placeholder="Ref. #" autocomplete="off">
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
                                        <input type="text" class="form-control" id="start-trip-adv-netbanking-accholder"
                                            maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group" id="start-trip-adv-netbanking-bankname-div">
                                        <label for="start-trip-adv-netbanking-bankname">Bank Name</label>
                                        <input type="text" class="form-control" id="start-trip-adv-netbanking-bankname"
                                            maxlength="120" placeholder="Bank Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="start-trip-adv-netbanking-details">Ref. #</label>
                                        <input type="text" class="form-control" id="start-trip-adv-netbanking-details"
                                            placeholder="Ref. #" autocomplete="off">
                                    </div>
                                </div>
                            </div>
                            {* Cheque *}
                            <div class="hide" id="start-trip-adv-cheque-mode-panel">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-payer">Payer Details</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-payer"
                                            maxlength="250" placeholder="Payer Details" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-no">Cheque No</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-no" maxlength="60"
                                            placeholder="Cheque No" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-date">Cheque Date</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-date"
                                            maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-bankcity">Bank City</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-bankcity"
                                            maxlength="90" placeholder="Bank City" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group" id="start-trip-adv-cheque-bankname-div">
                                        <label for="start-trip-adv-cheque-bankname">Bank Name</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-bankname"
                                            maxlength="120" placeholder="Bank Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-remarks">Remarks</label>
                                        <input type="text" class="form-control" placeholder="Remarks"
                                            id="start-trip-adv-cheque-remarks" data-mask="englishonly" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <h6 class="bold title-line">Fuel Expense</h6>
                        <div class="row">
                            <div class="col-md-2">
                                <label class="control-label" for="">Fuel Litres</label>
                                <input type="number" id="start-trip-fuel-litres" class="form-control no-spin"
                                    placeholder="Fuel Litres">
                            </div>
                            <div class="col-md-2">
                                <label class="control-label" for="">Fuel Rate / Liter</label>
                                <input type="number" class="form-control" id="start-trip-fuel-rate"
                                    placeholder="Fuel Rate / Liter" step="any">
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
                                <input type="text" class="form-control" id="start-trip-fuel-coupon"
                                    placeholder="Fuel Coupon">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br>
                <div class="row text-center">
                    <div class="col-md-9">
                        <div id="start-trip-action-state"></div>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-warning" id="start-trip-btn"
                            onclick="startTransitV3Trip();">Start Trip</button>
                    </div>
                </div>
        </form>
 </div>
</div>