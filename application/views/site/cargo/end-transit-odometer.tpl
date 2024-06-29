<form onsubmit="return false;">
    <div class="row">
        <div class="col-md-6 text-center">
            <img src="assets/img/start-trip.png" width="80%">
        </div>
        <div class="col-md-6 text-right">
            <h4 class="bold">Arrival Time</h4>
            <h4>{date('d M Y g:i A')}</h4>
            <div class="clearfix"></div>
            <h5 class="bold">Last odometer Reading</h5>
            <h4><span id="end-transit-last-odometer" data-odometer="{$vehicle->lastOdometer + 0}">{$vehicle->lastOdometer}</span> Km</h4>
        </div>
        <div class="col-md-12">
            <label class="req h5">Enter odometer reading to End Trip</label>
            <div class="row">
                <div class="col-md-4">
                    <input type="number" id="end-transit-odo" class="form-control no-spin" placeholder="Odometer">
                </div>
                <div class="col-md-4 p_l_n">
                    <div class="input-group col-md-12">
                        <select id="end-transit-supervisor" class="form-control">
                            <option value="" selected>Select Supervisor</option>
                            {foreach item=row from=$branchContact}
                                {if $row->category->code == 'SPVSR'}
                                    <option value="{$row->code}">{$row->name}</option>
                                {/if}
                            {/foreach}
                        </select>
                    </div>
                </div>
                <input type="hidden" id="end-transit-transitcode" value="{$transit_code}">
                <input type="hidden" id="end-transit-organization" value="{$login_branch}">
                <input type="hidden" id="end-transit-user" value="{$usr_login_id}">
                <input type="hidden" id="end-transit-vehicle" value="{$vehicle_code}">
                <button type="submit" class="btn btn-warning col-md-3" id="end-transit-btn" onclick="endTransitTrip();">{if $transit_to_organization == $login_branch}End{else}Arrival{/if} Trip</button>
            </div>
        </div>
        <div class="col-md-12"><br>
            <div id="end-transit-action-state"></div>
        </div>
    </div>
</form>