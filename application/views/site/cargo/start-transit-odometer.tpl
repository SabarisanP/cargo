<form onsubmit="return false;">
    <div class="row">
        <div class="col-md-4 text-center">
            <img src="assets/img/start-trip.png" width="40%">
        </div>
        <div class="col-md-4 text-center">
            <h4 class="bold">Departure Time</h4>
            <h5>{date('d M Y g:i A')}</h4>
        </div>
        <div class="col-md-4 text-center">
            <h5 class="bold">Last odometer Reading</h5>
            <h5><span id="start-transit-last-odometer" data-odometer="{$vehicle->lastOdometer + 0}">{$vehicle->lastOdometer}</span> Km</h5>
        </div>
        <div class="clearfix"></div>

        <div class="col-md-12">
            <label class="h5">Fill The Following Details To Start Trip</label>
            <h6 class="bold">Odometer</h6>
            <div class="row">
                <div class="col-md-4">
                    <label class="control-label req" for="">Odometer</label>
                    <input type="number" id="start-transit-odo" class="form-control no-spin" placeholder="Odometer">
                </div>
                <div class="col-md-4 p_l_n">
                    <div class="input-group col-md-12">
                        <label class="control-label" for="">Supervisor</label>
                        <select id="start-transit-supervisor" class="form-control">
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

            <div id="start-transit-expense" {if isset($odoDetails) && $odoDetails->startOdometer != 0}class="hide"{/if}>
                <h6 class="bold">Payments</h6>
                <div class="row">
                    {if ($namespace == 'seenutransports' && $vehicle->ownershipType->code == 'HIRE') || $namespace != 'seenutransports'}
                        <div class="col-md-4">
                            <label class="control-label" for="">Hiring Amount</label>
                            <input type="number" class="form-control" id="start-transit-hire-amount" placeholder="Hiring Amount" step="any">
                        </div>
                        <div class="clearfix"></div><br>
                    {/if}
                    <div class="col-md-4">
                        <label class="control-label" for="">Advance Amount</label>
                        <input type="number" id="start-transit-advance-amount" class="form-control no-spin" placeholder="Advance Amount">
                    </div>
                    <div class="col-md-4">
                        <div class="input-group col-md-12">
                            <label class="control-label" for="">Payment Mode</label>
                            <select id="start-transit-adv-paymode" class="form-control">
                                <option value="" selected>Payment Mode</option>
                                {foreach name=o key=k item=name from=$f_t_mode}
                                    <option value="{$k}">{$name}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4 p_l_n">
                        <label class="control-label" for="">Payment By</label>
                        <select id="start-transit-adv-payby" class="form-control">
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
                </div>

                <h6 class="bold">Fuel Expense</h6>
                <div class="row">
                    <div class="col-md-3">
                        <label class="control-label" for="">Fuel Litres</label>
                        <input type="number" id="start-transit-fuel-litres" class="form-control no-spin" placeholder="Fuel Litres">
                    </div>
                    <div class="col-md-3">
                        <label class="control-label" for="">Fuel Rate / Liter</label>
                        <input type="number" class="form-control" id="start-transit-fuel-rate" placeholder="Fuel Rate / Liter" step="any">
                    </div>
                    <div class="col-md-3 p_l_n">
                        <div class="input-group col-md-12">
                            <label class="control-label" for="">Vendor</label>
                            <select id="start-transit-fuel-vendor" class="form-control">
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
                        <label class="control-label" for="">Fuel Coupon</label>
                        <input type="text" class="form-control" id="start-transit-fuel-coupon" placeholder="Fuel Coupon">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12 text-center"><br>
            <div id="start-transit-action-state"></div>
            <input type="hidden" id="start-transit-transitcode" value="{$transit_code}">
            <input type="hidden" id="start-transit-organization" value="{$login_branch}">
            <input type="hidden" id="start-transit-user" value="{$usr_login_id}">
            <input type="hidden" id="start-transit-vehicle" value="{$vehicle_code}">
            <input type="hidden" id="namespace_code" value="{$namespace}">
            <input type="hidden" id="emptyload_vehicle_owntype" value="{$vehicle->ownershipType->code}">
            <button type="submit" class="btn btn-warning col-md-3" id="start-transit-btn" onclick="startTransitTrip();" style="float: none;">Start Trip</button>
        </div>
    </div>
</form>

<script>
    var startTransitOdoDetails = {$odoDetails|json_encode};

    $('#start-transit-supervisor').select2();
    $('#start-transit-fuel-vendor').select2();
    $('#start-transit-adv-payby').select2();
</script>