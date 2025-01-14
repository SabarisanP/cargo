{if isNotNull($smarty.request.transitCode) || (isNotNull($smarty.request.vehicleCode) && $vehicleInfo->transitStatusCode == 'INTRN')}
    {assign var="transit" value=$transitList[0]}

    {assign var="transitStations" value=[]}
    {$transitStations[$transit->fromStation->code] = $transit->fromStation->name}
    {assign var="viaStations" value=[]}
    {foreach from=$transit->viaStations item=via}
        {$viaStations[] = $via->name}
        {$transitStations[$via->code] = $via->name}
    {/foreach}
    {assign var="viaOrganizations" value=[]}
    {foreach from=$transit->transitOrganizations item=via}
        {$viaOrganizations[] = $via->name}
    {/foreach}
    <div class="row">
        <div class="col-md-8">
            <div class="panel panel-default">
                <div class="heading_b">Transit Details</div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-12 h5"><b>Code :</b> {$transit->aliasCode} <a href="javascript:;" title="Click to get Transit History" onclick="getTransitHistory('{$transit->code}', '{$transit->aliasCode}')"><i class="fa fa-history" aria-hidden="true"></i></a></div>
                        <div class="col-md-12">
                            <b>Mode of Transit :</b> 
                            {if $transit->cargoActivityType->code == 'TRNT'}
                                <span class="label label-success">OutStation</span>
                            {elseif $transit->cargoActivityType->code == 'INTRNT'}
                                <span class="label label-default">Local Transit</span>
                            {elseif $transit->cargoActivityType->code == 'HBTRNT'}
                                <span class="label label-success">Link Transit</span>
                            {elseif $transit->cargoActivityType->code == 'OTFD'}
                                <span class="label label-warning">Out For Delivery</span>
                            {/if}
                        </div>

                        <div class="clearfix"></div><br>

                        <div class="col-md-4 h5">
                            <b>From :</b>
                            {if $transit->cargoActivityType->code == 'TRNT' || $transit->cargoActivityType->code == 'HBTRNT'}
                                {$transit->fromStation->name}
                            {elseif $transit->cargoActivityType->code == 'INTRNT' || $transit->cargoActivityType->code == 'OTFD'}
                                {$transit->fromOrganization->name}
                            {/if}
                            <span class="text-muted">{if $transit->departureMinutes}, {$transit->departureMinutes|min_to_time}{/if}</span>
                        </div>
                        <div class="col-md-6 h5" id="ogpl-search-tolabel-cont">
                            <b>To :</b>
                            {if $transit->cargoActivityType->code == 'TRNT' || $transit->cargoActivityType->code == 'HBTRNT'}
                                {$transit->toStation->name}
                            {elseif $transit->cargoActivityType->code == 'INTRNT' || $transit->cargoActivityType->code == 'OTFD'}
                                {$transit->toOrganization->name}
                            {/if}
                            <span class="text-muted">{if $transit->arrivalMinutes}, {$transit->arrivalMinutes|min_to_time}{/if}</span> &nbsp;
                            {if $transit->cargoActivityType->code == 'TRNT'}
                                {if $is_super_namespace == 1 || (!in_array('COMPLETE', $transit->activity) && $action_rights['OGPL-EDT-RTE'] == 1)}
                                    <small><a href="javascript:;" onclick="editOGPLToStation('{$transit->toStation->code}')"><i class="fa fa-pencil"></i> Change</a></small>
                                {/if}
                            {/if}
                        </div>
                        <div class="col-md-6 hide" id="ogpl-search-toselect-cont">
                            <div class="form-inline">
                                <label for="ogpl-search-to" class="col-md-6 w-auto pt10 req">To :</label>
                                <div class="input-group col-md-6">
                                    <select id="ogpl-search-to" class="form-control">
                                        <option value="" selected="">Select To</option>
                                        {foreach item=station from=$stations}
                                            {if !isset($transitStations[$station.code])}
                                                <option value="{$station.code}">{$station.name}</option>
                                            {/if}
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12"><b>Via :</b>
                        
                            {if $transit->cargoActivityType->code == 'TRNT' || $transit->cargoActivityType->code == 'HBTRNT'}
                                {implode(', ', $viaStations)}
                            {elseif $transit->cargoActivityType->code == 'INTRNT' || $transit->cargoActivityType->code == 'OTFD'}
                                {implode(', ', $viaOrganizations)}
                            {/if}
                        </div>
                    </div>

                    <hr>

                    <div class="row">
                        <div class="col-md-2 pb20"><b>Driver 1 :</b><br> {$transit->vehicleDriver->name}<br> {$transit->vehicleDriver->mobileNumber}</div>
                        <div class="col-md-2 pb20"><b>Driver 2 :</b><br> {$transit->secondaryDriver->name|default:'-'}<br> {$transit->secondaryDriver->mobileNumber|default:'-'}</div>

                        {if $transit->cargoActivityType->code == 'TRNT'}
                            {if $is_super_namespace == 1 || (!in_array('COMPLETE', $transit->activity) && $action_rights['OGPL-EDT-RTE'] == 1)}
                                <div class="col-md-6 b_l">
                                    <div class="col-md-10">
                                        <div class="form-group">
                                            <label for="ogpl-search-via" class="w-auto">Do you want to add via station into this transit :</label>
                                            <div class="input-group col-md-11 ogpl-via-stations">
                                                <select id="ogpl-search-via" class="form-control w-100" multiple="multiple">
                                                    {foreach item=station from=$stations}
                                                        {if !isset($transitStations[$station.code])}
                                                            <option value="{$station.code}">{$station.name}</option>
                                                        {/if}
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                        {/if}

                        <br>
                        {if isNotNull($transit->remarks)}
                            <div class="col-md-12"><b>Remarks :</b> {$transit->remarks}</div>
                        {/if}
                    </div>

                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="heading_b">Last Transit Details</div>
                <div class="panel-body">
                    {* <div class="h5"><b>Code :</b> {$transit->aliasCode} <a href="javascript:;" title="Click to get Transit History" onclick="getTransitHistory('{$transit->code}', '{$transit->aliasCode}')"><i class="fa fa-history" aria-hidden="true"></i></a>&nbsp;</div>
                    <br> *}
                    <span><b>Recent Activity :</b> {$transit->recentActivity->event}, <span class="text-muted">{$transit->recentActivity->organization->station->name}</span></span><br>
                    <span><b>Last Updated At :</b> {$transit->recentActivity->updatedAt|date_format:$ns_datetime_format}</span><br>
                    <span><b>Created At :</b> {$transit->transitCargoDetails[0]->audit->updatedAt|date_format:$ns_datetime_format}</span><br>
                    <span><b>Created By :</b> {$transit->transitCargoDetails[0]->audit->user->name}</span>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix"></div><br>

    {if $transit->cargoActivityType->code == 'TRNT' || $transit->cargoActivityType->code == 'HBTRNT'}
        <div class="row">
            {if count($transit->transitRoutes)}
                <div class="col-md-12 pb20">
                    <div class="panel panel-default">
                        <div class="heading_b">Station Details</div>
                        <div class="panel-body">
                            {foreach from=$transit->transitRoutes item=route}
                                <div class="loaded-ogpl-tile">
                                    <b>{$route->organization->name}</b><br>
                                    <small class="text-muted">{$route->organization->station->name}</small>
                                    <br>
                                    {if $route->loadedCount > 0}
                                        <span class="badge badge-success" title="Loaded Count"><i class="fa fa-level-up" aria-hidden="true"></i> {$route->loadedCount}</span>
                                    {/if}
                                    {if $route->unloadedCount > 0}
                                        <span class="badge badge-warning" title="Unloaded Count"><i class="fa fa-level-down" aria-hidden="true"></i> {$route->unloadedCount}</span>
                                    {/if}
                                    {if $route->pendingUnloadCount > 0}
                                        <span class="badge badge-danger" title="Pending Unloaded Count"><i class="fa fa-level-down" aria-hidden="true"></i> {$route->pendingUnloadCount}</span>
                                    {/if}
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
            {/if}
        </div>
    {/if}

    {if $transit->cargoActivityType->code == 'TRNT' ||$transit->cargoActivityType->code == 'HBTRNT'|| $transit->cargoActivityType->code == 'INTRNT' || $transit->cargoActivityType->code == 'OTFD'}
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="col-md-12">
                    <div class="alert pull-right" id="ogpl-summary-state" style="display: none"></div>
                </div>
                <div class="col-md-9">
                    {if in_array('NEW-OGPL', $transit->activity)}
                        <button class="btn btn-success" type="button" onclick="setEmptyLoad('{$transit->code}')">Set Empty Load</button>
                    {/if}
                </div>
                <div class="col-md-3 text-right">
                    {if in_array('NEW-OGPL', $transit->activity)}
                        <button class="btn btn-primary" type="button" onclick="showAddOGPL()">Add new OGPL</button>&nbsp;
                    {/if}
    
                    {if $action_rights['SHOW-OGPL-RFSH']==1 && $transit->toStation->code==$login_station && !in_array('NEW-OGPL', $transit->activity)}
                        <button class="btn btn-primary" type="button" onclick="refreshOGPLV2('{$transit->code}')">Refresh</button>&nbsp;
                    {/if}
                    {if $transit->transitStatus->code != "EMPLD"}
                        <button class="btn btn-success" type="button" onclick="saveAndLoadOgpl('{$transit->code}')">Save & Load</button>
                    {/if}
                    {if $transit->transitCargoDetails[0]->fromOrganization->code == $login_branch}
                            {if $odoDetails->startOdometer == 0}
                                <button class="btn btn-warning" type="button" id="transit-trip-btn" onclick="showEmptyStartTripDialog();">Start Trip</button>
                            {/if}
                    {/if}
                </div>
            </div>
        </div>
    {/if}

    <script>
        $('#ogpl-search-via').select2({
            placeholder: 'Select Via Stations'
        });
    </script>
{elseif $vehicleInfo->transitStatusCode == 'INTRN'}
    <table class="table info_table">
        <thead>
            <tr>
                <th nowrap>Name / {lang('ogpl')} Code</th>
                <th>Date</th>
                <th>Route</th>
                <th>Vehicle</th>
                <th class="text-right">Loaded</th>
                <th class="text-right">Unloaded</th>
                <th class="text-right" nowrap>Total {lang('lr')}</th>
                <th>Remarks</th>
                <th class="text-center">Action</th>
            </tr>
        </thead>
        <tbody>

            {foreach from=$transitList item=row}
                <tr>
                    <td nowrap>
                        {$row->name} <br>
                        <span class="txt_green">{$row->aliasCode}</span>
                    </td>
                    <td nowrap>
                        {$row->tripDate|date_format:$ns_date_format}

                        {if $row->departureMinutes}
                            <br />
                            <span class="text-muted">
                                <span title="Departure Time">{min_to_time($row->departureMinutes * 60)}</span> to
                                <span title="Arrival Time">
                                    {if $row->arrivalMinutes > 2880}
                                        {min_to_time(($row->arrivalMinutes - 2880) * 60)} Third Day
                                    {elseif $row->arrivalMinutes > 1440}
                                        {min_to_time(($row->arrivalMinutes - 1440) * 60)} Next Day
                                    {elseif $row->arrivalMinutes}
                                        {min_to_time($row->arrivalMinutes * 60)}
                                    {/if}
                                </span>
                            </span>
                        {/if}
                    </td>
                    <td>
                        {$row->fromStation->name} - {$row->toStation->name}<br />
                        <span class="text-muted">
                            {foreach from=$row->viaStations item=via key=i name=v}
                                {if $i < 3}
                                    {$via->name}{if !$smarty.foreach.v.last && $i < 4},{/if}
                                {/if}
                            {/foreach}
                            {if $row->viaStations|count > 3}
                                <a href="javascript:;" class="ogpl-via" title="via routes" data-toggle="popover" data-trigger="hover" data-html="true" data-content="
                                    {foreach from=$row->viaStations item=via key=i name=v}
                                        {$via->name}<br/>
                                    {/foreach}
                                    "><i class="fa fa-info-circle"></i></a>
                            {/if}
                        </span>
                    </td>
                    <td>
                        {$row->busVehicle->registationNumber}<br />
                        <span class="text-muted">
                            {$row->vehicleDriver->name}, {$row->vehicleDriver->mobileNumber}
                        </span>
                    </td>
                    <td align="right">
                        {assign var="loaded_count" value=0}
                        {assign var="unloaded_count" value=0}
                        {assign var="total_count" value=0}
                        {foreach item=list from=$row->transitCargoDetails}
                            {assign var="loaded_count" value=$loaded_count + $list->loadedCount}
                            {assign var="unloaded_count" value=$unloaded_count + $list->unLoadedCount}
                        {/foreach}
                        {assign var="total_count" value=$loaded_count + $unloaded_count}
                        {$loaded_count|max:0}
                    </td>
                    <td align="right">{$unloaded_count|max:0}</td>
                    <td align="right">{$total_count|max:0}</td>
                    <td>{$row->remarks}</td>
                    <td align="right" nowrap>
                        <a class="btn btn-primary btn-xs" href="javascript:;" onclick="saveAndLoadOgpl('{$row->code}')">Load</a>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
{else $vehicleInfo->transitStatusCode == 'CMPLT'}
    {assign var="transit" value=$lastTransit[0]}

    {assign var="transitStations" value=[]}
    {$transitStations[$transit->fromStation->code] = $transit->fromStation->name}
    {assign var="viaStations" value=[]}
    {foreach from=$transit->viaStations item=via}
        {$viaStations[] = $via->name}
        {$transitStations[$via->code] = $via->name}
    {/foreach}
    {assign var="viaOrganizations" value=[]}
    {foreach from=$transit->transitOrganizations item=via}
        {$viaOrganizations[] = $via->name}
    {/foreach}

    <div class="row">
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <b>Vehicle currently available at : </b> {$vehicleInfo->transitStation->name} <br>
                            No In-Transit OGPL found for the selected vehicle/date. &nbsp;
                        </div>
                    </div>

                    <br>

                    {if ($cargo_setting->transitLocationModelCode == 'STN' && (!isNotNull($vehicleInfo->transitStation->code) || $vehicleInfo->transitStation->code == $login_station)) ||
                        ($cargo_setting->transitLocationModelCode == 'BRCH' && (!isNotNull($vehicleInfo->transitOrganization->code) || $vehicleInfo->transitOrganization->code == $login_organization)) ||
                        (in_array('FULL-TRK-LOAD', $transit->activity) && ($transit->fromStation->code == $login_station || $transit->audit->user->organization->code == $login_organization))}
                        <span class="h4 bold">&emsp;Do you want to create new Transit for this Vehicle? </span> <button class="btn btn-default" onclick="showAddOGPL()">Create New Transit <img src="assets/img/ogpl/v.png" width="24px"></button>
                    {/if}
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="heading_b">Last Transit Details</div>
                <div class="panel-body">
                    <div class="h5"><b>Code :</b> {$transit->aliasCode} <a href="javascript:;" title="Click to get Transit History" onclick="getTransitHistory('{$transit->code}', '{$transit->aliasCode}')"><i class="fa fa-history" aria-hidden="true"></i></a>&nbsp;</div>
                    <div>
                        <b>Mode of Transit :</b>
                        {if $transit->cargoActivityType->code == 'TRNT'}
                            <span class="label label-success">OutStation</span>
                        {elseif $transit->cargoActivityType->code == 'INTRNT'}
                            <span class="label label-default">Local Transit</span>
                        {elseif $transit->cargoActivityType->code == 'OTFD'}
                            <span class="label label-warning">Out For Delivery</span>
                        {/if}
                        {if in_array('EMP-LOAD', $transit->activity)}
                            <span class="label label-warning">!Empty</span>
                        {/if}
                    </div>
                    <br>
                    <span><b>Recent Activity :</b> {$transit->recentActivity->event}, <span class="text-muted">{$transit->recentActivity->organization->station->name}</span></span><br>
                    <span><b>Last Updated At :</b> {$transit->recentActivity->updatedAt|date_format:$ns_datetime_format}</span><br>
                    <span><b>Created At :</b> {$transit->transitCargoDetails[0]->audit->updatedAt|date_format:$ns_datetime_format}</span><br>
                    <span><b>Created By :</b> {$transit->transitCargoDetails[0]->audit->user->name}</span><br>
                    <br>
                    <div>
                        <b>Route :</b> 
                        {if $transit->cargoActivityType->code == 'TRNT'}
                            {$transit->fromStation->name} - {$transit->toStation->name}
                        {elseif $transit->cargoActivityType->code == 'INTRNT' || $transit->cargoActivityType->code == 'OTFD'}
                            {$transit->fromOrganization->name} - {$transit->fromOrganization->name}
                        {/if}
                    </div>
                    <div>
                        <b>Via :</b> 
                        {if $transit->cargoActivityType->code == 'TRNT'}
                            {implode(', ', $viaStations)}
                        {elseif $transit->cargoActivityType->code == 'INTRNT' || $transit->cargoActivityType->code == 'OTFD'}
                            {implode(', ', $viaOrganizations)}
                        {/if}
                    </div>
                    <div><b>Driver :</b> {$transit->vehicleDriver->name}, {$transit->vehicleDriver->mobileNumber}</div>
                </div>
            </div>
        </div>
    </div>
{/if}

{* start trip popup *}
    <div id="end-start-trip-dialog" style="display: none">
        <div class="clearfix">
            <a href="javascript:;" class="pull-right" onclick="hideEditStartTripDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
        </div>
        <div id="re-start-trip-panel" class="clearfix" style="padding: 10px 5px;max-height: 600px;overflow-x: hidden;overflow-y: auto;">
            <form onsubmit="return false;">
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
                        <h5><span id="last-odometer"> {$transit->busVehicle->lastOdometer}</span> Km</h5>
                    </div>
                    <div class="clearfix"></div>

                    <div class="col-md-12">
                        <label class="h5">Fill The Following Details To Start Trip</label>
                        <h6 class="bold">Odometer</h6>
                        <div class="row">
                            <div class="col-md-4">
                                <label class="control-label req" for="">Odometer</label>
                                <input type="number" id="re-start-trip-odo" class="form-control no-spin" placeholder="Odometer">
                            </div>
                            <div class="col-md-4 p_l_n">
                                <div class="input-group col-md-12">
                                    <label class="control-label" for="">Supervisor</label>
                                    <select id="re-start-trip-supervisor" class="form-control">
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

                        <div id="re-start-trip-expense">
                            <h6 class="bold">Payments</h6>
                            <div class="row">
                                <div id="re-start-trip-hiring-amt">
                                    <div class="col-md-4">
                                        <label class="control-label" for="">Hiring Amount</label>
                                        <input type="number" class="form-control" id="re-start-trip-hire-amount" placeholder="Hiring Amount" step="any">
                                    </div>
                                    <div class="clearfix"></div><br>
                                </div>

                                <div class="col-md-4">
                                    <label class="control-label" for="">Advance Amount</label>
                                    <input type="number" id="re-start-trip-advance-amount" class="form-control no-spin" placeholder="Advance Amount">
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group col-md-12">
                                        <label class="control-label" for="">Payment Mode</label>
                                        <select id="re-start-trip-adv-paymode" class="form-control" onchange="setStartTripTransactionMode();">
                                            <option value="" selected>Payment Mode</option>
                                            {foreach name=o key=k item=name from=$f_t_mode}
                                                <option value="{$k}">{$name}</option>
                                            {/foreach} 
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4 p_l_n">
                                    <label class="control-label" for="">Payment By</label>
                                    <select id="re-start-trip-adv-payby" class="form-control">
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
                                
                                <div class="clearfix"></div><br>
                                <div class="hide" id="re-start-trip-adv-upi-mode-panel">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-upi-orgbank">Organization Bank</label>
                                            <select class="form-control" id="re-start-trip-adv-upi-orgbank">
                                                <option value="">Select Organization Bank</option>
                                                {foreach from=$bankdetail item=val}
                                                    <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-upi-id">UPI ID</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-upi-id" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-upi-details">Ref. #</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-upi-details" placeholder="Ref. #" autocomplete="off">
                                        </div>
                                    </div>
                                </div>

                                <div class="hide" id="re-start-trip-adv-netbanking-mode-panel">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-netbanking-orgbank">Organization Bank</label>
                                            <select class="form-control" id="re-start-trip-adv-netbanking-orgbank">
                                                <option value="">Select Organization Bank</option>
                                                {foreach from=$bankdetail item=val}
                                                    <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-netbanking-accholder">Account Holder Name</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-netbanking-accholder" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group" id="re-start-trip-adv-netbanking-bankname-div">
                                            <label for="re-start-trip-adv-netbanking-bankname">Bank Name</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-netbanking-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-netbanking-details">Ref. #</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-netbanking-details" placeholder="Ref. #" autocomplete="off">
                                        </div>
                                    </div>
                                </div>

                                <div class="hide" id="re-start-trip-adv-cheque-mode-panel">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-cheque-payer">Payer Details</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-cheque-payer" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-cheque-no">Cheque No</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-cheque-no" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-cheque-date">Cheque Date</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-cheque-date" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-cheque-bankcity">Bank City</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-cheque-bankcity" maxlength="90" placeholder="Bank City" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group" id="re-start-trip-adv-cheque-bankname-div">
                                            <label for="re-start-trip-adv-cheque-bankname">Bank Name</label>
                                            <input type="text" class="form-control" id="re-start-trip-adv-cheque-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="re-start-trip-adv-cheque-remarks">Remarks</label>
                                            <input type="text" class="form-control" placeholder="Remarks" id="re-start-trip-adv-cheque-remarks" data-mask="englishonly"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <h6 class="bold">Fuel Expense</h6>
                            <div class="row">
                                <div class="col-md-2">
                                    <label class="control-label" for="">Fuel Litres</label>
                                    <input type="number" id="re-start-trip-fuel-litres" class="form-control no-spin" placeholder="Fuel Litres">
                                </div>
                                <div class="col-md-2">
                                    <label class="control-label" for="">Fuel Rate / Liter</label>
                                    <input type="number" class="form-control" id="re-start-trip-fuel-rate" placeholder="Fuel Rate / Liter" step="any">
                                </div>
                                <div class="col-md-3">
                                    <div class="input-group col-md-12">
                                        <label class="control-label" for="">Vendor</label>
                                        <select id="re-start-trip-fuel-vendor" class="form-control">
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
                                        <label for="re-start-trip-fuel-payment-mode" class="req">Payment Mode</label>
                                        <select id="re-start-trip-fuel-payment-mode" class="form-control">
                                            <option value="CASH">Cash Payment</option> 
                                            <option value="CRDT">Credit Payment</option> 
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <label class="control-label" for="">Fuel Coupon</label>
                                    <input type="text" class="form-control" id="re-start-trip-fuel-coupon" placeholder="Fuel Coupon">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 text-center"><br>
                        <div id="re-start-trip-action-state"></div>
                        <button type="submit" class="btn btn-warning col-md-3" id="re-start-trip-btn" onclick="startEditTransitV3Trip();" style="float: none;">Start Trip</button>
                        {* <button type="submit" class="btn btn-warning col-md-3" id="load-empty-trip">Load in Empty</button> *}
                    </div>
                </div>
            </form>
        </div>
    </div>
{* start trip popup *}




<script>
    var loadorg ={$loadbranchs|json_encode}
   
    var ogplSearchData = {$transitList|json_encode};
    var cargoSetting = {$cargo_setting|json_encode};
    var odoDetails = {$odoDetails|json_encode};


    var localTransitSearchData = {$localTransit|json_encode};

    function editOGPLToStation(toStation) {
        $('#ogpl-search-toselect-cont').removeClass('hide');
        $('#ogpl-search-tolabel-cont').addClass('hide');
        $('#ogpl-search-to').val(toStation).select2().select2('open');
    }

  
    var odoValue = 0;
    function showEmptyStartTripDialog() {
        var data = {};
        data.vehicleCode = ogplSearchData[0].busVehicle.code;
        $.ajax({
            type: "post",
            url: "cargo/get-vehicle-detail",
            data: data,
            dataType: "json",
            success: function (response) {
                
                if(response.status){
                    var result = response.data; 
                    odoValue = response.data.lastOdometer;
                    $('#last-odometer').html(odoValue);
                }
            }
        });
            $('#end-start-trip-dialog').removeClass('hide');
            $('#end-start-trip-dialog').dialog({
                autoOpen: true,
                width: 800,
                modal: true,
                closeOnEscape:true,
                resizable: false
            });
            $('#end-start-trip-dialog .inp_error').removeClass('inp_error');
            $('#re-start-trip-action-state').removeClass('alert alert-danger alert-success').html('');
            $('#re-start-trip-odo, #start-trip-hire-amount, #start-trip-advance-amount, #start-trip-adv-paymode, #start-trip-fuel-litres, #start-trip-fuel-rate, #start-trip-fuel-coupon').val('');
            $('#re-start-trip-supervisor, #start-trip-fuel-vendor, #start-trip-adv-payby').val('').trigger('change');
            $('#re-start-trip-fuel-payment-mode').val('CASH').trigger('change');
            $('#re-start-trip-hiring-amt').removeClass('hide');

            $('#trip-start-date').html(moment().format('DD MMM YYYY'));
            $('#trip-start-time').html(moment().format('hh : mm A'));

           
    }
    
    function startEditTransitV3Trip() {
        
            var data = {}, err = 0;
            data.action = 'DEPARTURE';
            data.transitCode = ogplSearchData[0].code;
            data.transitCargo = {};
            data.transitCargo.code = ogplSearchData[0].code;
            data.fromOrganization = {};
            data.fromOrganization.code = user_login_branch;
            data.startOdometer = Number($('#re-start-trip-odo').val());
            data.departureAt = moment().format('YYYY-MM-DD HH:mm:ss');
            data.fromOrganizationContact = {};
            data.fromOrganizationContact.code = $('#start-trip-supervisor').val();

            $('.inp_error').removeClass('inp_error');
            if (isNaN(data.startOdometer) || data.startOdometer < 0 || data.startOdometer == '') {
                $('#re-start-trip-odo').addClass('inp_error');
                err++;
            }
          

            if (isNull(odoDetails) || (odoDetails && (odoDetails.startOdometer == 0))) {
                // fuel expense
                data.fuelExpenseCode = '';
                data.activeFlag = 1;
                data.fuelDate = moment().format('YYYY-MM-DD');
                data.vehicle = {};
                data.vehicle.code = ogplSearchData[0].busVehicle.code;
                
                data.vendorContact = {};
                data.vendorContact.code = $('#re-start-trip-fuel-vendor').val();

                data.transactionMode = {};
                data.transactionMode.code = $('#re-start-trip-fuel-payment-mode').val();

                data.litres = Number($('#re-start-trip-fuel-litres').val());
                data.pricePerLitre = Number($('#re-start-trip-fuel-rate').val());
                data.totalAmount = data.litres * data.pricePerLitre;
                data.billNumber = $.trim($('#re-start-trip-fuel-coupon').val());

                // hiring amount and advance amount
                data.ogpl = [];
                    var hire = {};
                    hire.code = '';
                    hire.activeFlag = 1;
                    hire.amount = Number($('#re-start-trip-hire-amount').val());
                    hire.remarks = '';

                    hire.user = {};
                    hire.user.code = login_user;

                    hire.transitCargo = {};
                    hire.transitCargo.code = ogplSearchData[0].code;
                    
                    hire.cashbookType = {};
                    hire.cashbookType.code = 'HIRING';

                    if (Number(hire.amount) > 0) {
                        data.ogpl.push(hire);
                    }
                
                var advance = {};

                advance.code = '';
                advance.activeFlag = 1;
                advance.amount = Number($('#re-start-trip-advance-amount').val());
                advance.remarks = '';

                advance.user = {};
                advance.user.code = login_user;

                advance.transitCargo = {};
                advance.transitCargo.code = ogplSearchData[0].code;

                advance.transactionMode = {};
                advance.transactionMode.code = $('#re-start-trip-adv-paymode').val();
                
                advance.cashbookType = {};
                advance.cashbookType.code = 'ADVANCE';

                advance.paymentByContact = {};
                advance.paymentByContact.code = $('#re-start-trip-adv-payby').val();

                if (advance.transactionMode.code == 'UPI') {
                    advance.bankDetails = {};
                    advance.bankDetails.code = $('#re-start-trip-adv-upi-orgbank').val();
                    advance.addAttr1 = $.trim($('#re-start-trip-adv-upi-id').val());
                    advance.addAttr2 = $.trim($('#re-start-trip-adv-upi-details').val());
                } else if (advance.transactionMode.code == 'NBK') {
                    advance.bankDetails = {};
                    advance.bankDetails.code = $('#re-start-trip-adv-netbanking-orgbank').val();
                    advance.addAttr1 = $.trim($('#re-start-trip-adv-netbanking-accholder').val());
                    advance.addAttr2 = $.trim($('#re-start-trip-adv-netbanking-bankname').val());
                    advance.addAttr3 = $.trim($('#re-start-trip-adv-netbanking-details').val());
                } else if (advance.transactionMode.code == 'CHEQUE') {
                    advance.chequeDetails = {};
                    advance.chequeDetails.code = $('#re-start-trip-adv-chq-code').val();
                    advance.chequeDetails.activeFlag = 1;

                    advance.chequeDetails.organization = {};
                    advance.chequeDetails.organization.code = '{$login_branch}';

                    advance.chequeDetails.bankDetails = $.trim($('#re-start-trip-adv-cheque-bankname').val());
                    advance.chequeDetails.payerDetails = $.trim($('#re-start-trip-adv-cheque-payer').val());

                    advance.chequeDetails.chequeDate = moment($('#re-start-trip-adv-cheque-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                    advance.chequeDetails.chequeNo = $.trim($('#re-start-trip-adv-cheque-no').val());
                    advance.chequeDetails.bankCity = $.trim($('#re-start-trip-adv-cheque-bankcity').val());

                    advance.chequeDetails.chequeStatus = {};
                    advance.chequeDetails.chequeStatus.code = 'NEW';

                    advance.chequeDetails.remarks = $.trim($('#re-start-trip-adv-cheque-remarks').val());
                }

                if (Number(advance.amount) > 0) {
                data.ogpl.push(advance);
                }

                // advance amount
                if (($.inArray(ogplSearchData[0].cargoActivityType.code, ['OTFD', 'INTRNT']) != -1 && !isNull(hire) && hire.amount != '') || (cargoSetting.userAccountModel.code != 'TXRT' && !isNull(hire) && hire.amount != '') || advance.amount != '' || advance.transactionMode.code != '' || advance.paymentByContact.code != '') {
                    if (!isNull(hire) && hire.amount == '') {
                        $('#re-start-trip-hire-amount').addClass('inp_error');
                        err++;
                    }
                    
                    if (advance.amount == '') {
                        $('#re-start-trip-advance-amount').addClass('inp_error');
                        err++;
                    }

                    if (advance.transactionMode.code == '') {
                        $('#re-start-trip-adv-paymode').addClass('inp_error');
                        err++;
                    }

                    if (advance.paymentByContact.code == '') {
                        $('#re-start-trip-adv-payby').addClass('inp_error');
                        err++;
                    }

                    if (advance.transactionMode.code == 'UPI') {
                        if (advance.addAttr1 == '') {
                            $('#re-start-trip-adv-upi-id').addClass('inp_error');
                            err++;
                        }

                        if ($('#re-start-trip-adv-upi-orgbank').val() == '') {
                            $('#re-start-trip-adv-upi-orgbank').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr2 == '') {
                            $('#re-start-trip-adv-upi-details').addClass('inp_error');
                            err++;
                        }
                    } else if (advance.transactionMode.code == 'NBK') {
                        if (advance.addAttr1 == '') {
                            $('#re-start-trip-adv-netbanking-accholder').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr2 == '') {
                            $('#re-start-trip-adv-netbanking-bankname').addClass('inp_error');
                            err++;
                        }

                        if ($('#re-start-trip-adv-netbanking-orgbank').val() == '') {
                            $('#re-start-trip-adv-netbanking-orgbank').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr3 == '') {
                            $('#re-start-trip-adv-netbanking-details').addClass('inp_error');
                            err++;
                        }
                    } else if (advance.transactionMode.code == 'CHEQUE') {
                        if (advance.chequeDetails.payerDetails == '') {
                            $('#re-start-trip-adv-cheque-payer').addClass('inp_error');
                            err++;
                        }

                        if ($('#re-start-trip-adv-cheque-date').val() == '') {
                            $('#re-start-trip-adv-cheque-date').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.chequeNo == '') {
                            $('#re-start-trip-adv-cheque-no').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.bankDetails == '') {
                            $('#re-start-trip-adv-cheque-bankname').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.bankCity == '') {
                            $('#re-start-trip-adv-cheque-bankcity').addClass('inp_error');
                            err++;
                        }
                    }
                }

                // fuel expense
                if (data.vendorContact.code != '' || data.litres != '' || data.pricePerLitre != '' || data.billNumber != '') {
                    if (data.vendorContact.code == '') {
                        $('#re-start-trip-fuel-vendor').addClass('inp_error');
                        err++;
                    }

                    if (data.litres == '') {
                        $('#re-start-trip-fuel-litres').addClass('inp_error');
                        err++;
                    }

                    if (data.pricePerLitre == '') {
                        $('#re-start-trip-fuel-rate').addClass('inp_error');
                        err++;
                    }

                    if (data.billNumber == '') {
                        $('#re-start-trip-fuel-coupon').addClass('inp_error');
                        err++;
                    }
                }
            }
            
            if(err) {
                $('#re-start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
                $('#re-start-trip-action-state').html('Please enter/select the values in the field that are marked in red');
                return;
            }
            $('#re-start-trip-panel-btn').hide();
            $('#re-start-trip-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
            
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-start-odometer",
                data: data,
                success: function (response) {
                    if (response.status == 1) {       
                        // startOdoUpdated == 1;         
                        $('#re-start-trip-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                        window.setTimeout(function () {
                            hideEditStartTripDialog();
                              checkURL();
                        }, 3000);
                    } else {
                        $('#re-start-trip-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                        $('#re-start-trip-panel-btn').show();
                    }
                }
            });
    }
    function hideEditStartTripDialog() {
            $('#end-start-trip-dialog').dialog('destroy');
            $('#end-start-trip-dialog').hide();
        }
</script>