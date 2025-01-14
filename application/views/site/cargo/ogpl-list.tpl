<style>
.badge-small{
  padding: 3px !important;
  font-size: 6pt !important;
}
</style>
<div class="panel panel-default text-center">
    <ul class="nav nav-tabs main-transit-tabs">
        <li class="tab-btn active" data-toggle="tooltip" title="List of vehicles going to arrive in your Branch">
            <a data-toggle="tab" data-tab="ARRIVAL" href="#arrival_pane" data-count="{$tabs['ARRIVAL']|count}">
                Arrival &nbsp;<small class="text-muted">({$tabs['ARRIVAL']|count})</small><br>
            </a>
        </li>
        <li class="tab-btn" data-toggle="tooltip" title="List of vehicles reached your Branch, Waiting for Departure">
            <a data-toggle="tab" data-tab="DEPARTURE" href="#departure_pane" data-count="{$tabs['DEPARTURE']|count}">
                Yet to Departure &nbsp;<small class="text-muted">({$tabs['DEPARTURE']|count})</small><br>
            </a>
        </li>
        <li class="tab-btn" data-toggle="tooltip" title="List of vehicles left your branch">
            <a data-toggle="tab" data-tab="INTRANSIT" href="#intransit_pane" data-count="{$tabs['DISPATCH']|count}">
                Departed / Intransit &nbsp;<small class="text-muted">({$tabs['DISPATCH']|count})</small><br>
            </a>
        </li>
        <li class="tab-btn" data-toggle="tooltip" title="List of Completed Vehicle Transit">
            <a data-toggle="tab" data-tab="COMPLETED" href="#completed_pane" data-count="{$tabs['COMPLETE']|count}">
                Completed &nbsp;<small class="text-muted">({$tabs['COMPLETE']|count})</small><br>
            </a>
        </li>
    </ul>
</div>

<div class="tab-content" id="ogpl-trip-list">
    <div id="arrival_pane" class="tab-pane fade in active">{call ogplList data=$tabs['ARRIVAL'] tab='ARRIVAL'}</div>
    <div id="departure_pane" class="tab-pane fade">{call ogplList data=$tabs['DEPARTURE'] tab='DEPARTURE'}</div>
    <div id="intransit_pane" class="tab-pane fade">{call ogplList data=$tabs['DISPATCH'] tab='DISPATCH'} </div>
    <div id="completed_pane" class="tab-pane fade">{call ogplList data=$tabs['COMPLETE']}</div>
</div>

{function name="ogplList" data=[]}
    {foreach from=$data item=row key=k}
        {* {if $row->cargoActivityType->code == 'INTRNT' || $row->cargoActivityType->code == 'OTFD'}
            {continue}
        {/if} *}

        {assign var="loaded_count" value=0}
        {assign var="unloaded_count" value=0}
        {assign var="total_count" value=0}
        {foreach item=list from=$row->transitCargoDetails}
            {assign var="loaded_count" value=$loaded_count + $list->loadedCount}
            {assign var="unloaded_count" value=$unloaded_count + $list->unLoadedCount}
        {/foreach}
        {assign var="total_count" value=$loaded_count + $unloaded_count}
        {assign var="isEmptyLoad" value=in_array('EMP-LOAD', $row->activity)}
        {assign var="startTrip" value=in_array('ORGN-START-TRIP', $row->activity)} {*start trip successed*}
        {assign var="outForDelivery" value=in_array('OUT-FR-DLRY', $row->activity)} 
        {assign var=consolidateEWayBill value=array()}

        {* change tript status *}
        {$unloadType = 'End'}
        {foreach item=val from=$row->viaStations}
            {assign var="viaStationName" value=$val->name}
            {if $row->toStation->code == $org_station_code}
                {$unloadType = 'End'}
                {break}
            {else}
                {if $val->code == $org_station_code}
                    {$unloadType = 'Arrival'}
                {/if}
            {/if}

        {/foreach}
        <div class="panel panel-default transit-row p-0" id="transit-{$row->code}" data-transitcode="{$row->code}" data-aliascode="{$row->aliasCode}" data-ogplstatus="{$row->ogplStatus}" data-vehiclecode="{$row->busVehicle->code}">
            <div class="panel-body transit-row-body">
                <div class="row">
                    <div class="col-md-3 b_r">
                        <div>
                            <span class="mnu_border btn-xs">{$row->tripDate|date_format:$ns_date_format}</span>&emsp;
                            {if $row->departureMinutes}
                                <span class="text-muted small">
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
                         {foreach from=$row->activityType item=type}
                            {* {if $type->code != 'OTFD' && $type->code != 'INTRNT'} *}
                                <span class="badge badge-small badge-{$activityType[$type->code]['color']}"
                                 data-toggle="tooltip" title="{$activityType[$type->code]['name']}"
                                >{$activityType[$type->code]['short_name']}</span>
                            {* {/if} *}
                         {/foreach}
                        </div>
                        <h5>{$row->fromStation->name} <img src="assets/img/ogpl/r.png" width="24px"> {$row->toStation->name} </h5>
                        <b class="h4 bold">{$row->aliasCode}</b>
                        {if $row->viaStations|count > 0}
                            &nbsp;<a href="javascript:;" class="ogpl-via mnu_border" title="via routes" data-toggle="popover" data-trigger="hover" data-html="true" data-content="
                            {foreach from=$row->viaStations item=via key=i name=v}
                                {$via->name}<br/>
                            {/foreach}
                            ">&nbsp;<i class="fa fa-location-arrow"></i> Via&nbsp;</a>&nbsp;
                        {/if}

                        <a href="javascript:;" onclick="toggleRouteTab('{$row->code}')"><img src="assets/img/ogpl/m.png" width="22px"></a>&nbsp;
                        <a href="javascript:;" onclick="toggleHistoryTab('{$row->code}')"><img src="assets/img/ogpl/h.png" width="22px"></a>&nbsp;

                        <br>
                        {if count($row->transitReference)}
                            {foreach from=$row->transitReference item=transit}
                                {if $transit->cargoActivityType->code == 'TRNT'}
                                    <a href="#cargo/ogpl-chart-details?transitCode={$transit->code}" title="Related OGPL" target="_blank">{$transit->name} ({$transit->aliasCode})</a><br>
                                {elseif $transit->cargoActivityType->code == 'INTRNT'}
                                    <a href="#cargo/local-transit-chart-details?transitCode={$transit->code}" title="Related Local Transit" target="_blank">{$transit->name} ({$transit->aliasCode})</a><br>
                                {elseif $transit->cargoActivityType->code == 'OTFD'}
                                    <a href="#cargo/out-for-delivery-chart-details?transitCode={$transit->code}" title="Related Door Pickup and Delivery" target="_blank">{$transit->name} ({$transit->aliasCode})</a><br>
                                {/if}
                            {/foreach}
                        {/if}
                    </div>
                    <div class="col-md-2 text-center b_r">
                        <h4 class="m-t-4">
                            {$row->busVehicle->registationNumber}
                            {if ($cargo_setting->ogplModelCode == 'VER2' || $cargo_setting->ogplModelCode == 'VER3') && $row->transitStatus->code == 'CMPLT'}
                                <div class="btn-group">
                                    <div class="dropdown">
                                        <button type="button" class="btn btn-xs btn-default dropdown-toggle" data-toggle="dropdown">
                                            <i class="fa fa-link"></i> <span class="fa fa-caret-down"></span>
                                        </button>
                                        <ul class="dropdown-menu text-left">
                                            <li><a href="javascript:;" title="Create New Local Transit from this OGPL" onclick="createNewLinkedTransit('{$row->code}', '{$row->busVehicle->code}', 'INTRNT')">Link New Local Transit</a></li>
                                            <li><a href="javascript:;" title="Create New Door Pickup & Door Delivery from this OGPL" onclick="createNewLinkedTransit('{$row->code}', '{$row->busVehicle->code}', 'OTFD')">Link New Door Pickup & Door Delivery</a></li>
                                        </ul>
                                    </div>
                                </div>
                            {/if}
                        </h4>
                        <p>
                            {if isNotNull($row->vehicleDriver->name)}
                                <span class="text-muted">{$row->vehicleDriver->name}, {$row->vehicleDriver->mobileNumber}</span><br>
                            {/if}
                            {if isNotNull($row->secondaryDriver->name)}
                                <span class="text-muted">{$row->secondaryDriver->name}, {$row->secondaryDriver->mobileNumber}</span>
                            {/if}
                        </p><br>
                    </div>
                    <div class="col-md-5">
                        <div class="m-t-5">
                            <div class="addon-block" data-toggle="tooltip" title="Loaded Count">
                                <span class="btn-danger"><i class="fa fa-level-up"></i></span>
                                <span>{$loaded_count|max:0}</span>
                            </div>
                            {if $row->additionalAttribute->CARGO_HUB_LOAD_COUNT > 0}
                                <div class="addon-block" data-toggle="tooltip" title="Hub Loaded Count">
                                    <span class="bg-danger"><small>HUB</small></span>
                                    <span>{$row->additionalAttribute->CARGO_HUB_LOAD_COUNT|max:0}</span>
                                </div>
                            {/if}
                            <div class="addon-block" data-toggle="tooltip" title="Unloaded Count">
                                <span class="btn-warning"><i class="fa fa-level-down"></i></span>
                                <span>{$unloaded_count|max:0}</span>
                            </div>&emsp;
                            <div class="addon-block" data-toggle="tooltip" title="Actual Weight">
                                <span>
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="14px" height="14px" fill="#a5a5a5"><path d="M288 96c0 17.7-14.3 32-32 32s-32-14.3-32-32s14.3-32 32-32s32 14.3 32 32zm58.5 32c3.5-10 5.5-20.8 5.5-32c0-53-43-96-96-96s-96 43-96 96c0 11.2 1.9 22 5.5 32H120c-22 0-41.2 15-46.6 36.4l-72 288c-3.6 14.3-.4 29.5 8.7 41.2S33.2 512 48 512H464c14.8 0 28.7-6.8 37.8-18.5s12.3-26.8 8.7-41.2l-72-288C433.2 143 414 128 392 128H346.5z"/></svg>
                                </span>
                                <span>{$row->totalActualWeight}</span>
                            </div>
                            <div class="addon-block" data-toggle="tooltip" title="Billing Weight">
                                <span>
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="14px" height="14px" fill="#a5a5a5"><path d="M384 176c0 70.7-57.3 128-128 128s-128-57.3-128-128s57.3-128 128-128s128 57.3 128 128zm7.8-112C359.5 24.9 310.7 0 256 0S152.5 24.9 120.2 64H64C28.7 64 0 92.7 0 128V448c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V128c0-35.3-28.7-64-64-64H391.8zM296 224c0-10.6-4.1-20.2-10.9-27.4l33.6-78.3c3.5-8.1-.3-17.5-8.4-21s-17.5 .3-21 8.4L255.7 184c-22 .1-39.7 18-39.7 40c0 22.1 17.9 40 40 40s40-17.9 40-40z"/></svg>
                                </span>
                                <span>{$row->totalWeight}</span>
                            </div>&emsp;
                            <div class="addon-block" data-toggle="tooltip" title="Total Freight">
                                <span>
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" width="14px" height="14px" fill="#a5a5a5"><path d="M0 64C0 46.3 14.3 32 32 32H96h16H288c17.7 0 32 14.3 32 32s-14.3 32-32 32H231.8c9.6 14.4 16.7 30.6 20.7 48H288c17.7 0 32 14.3 32 32s-14.3 32-32 32H252.4c-13.2 58.3-61.9 103.2-122.2 110.9L274.6 422c14.4 10.3 17.7 30.3 7.4 44.6s-30.3 17.7-44.6 7.4L13.4 314C2.1 306-2.7 291.5 1.5 278.2S18.1 256 32 256h80c32.8 0 61-19.7 73.3-48H32c-17.7 0-32-14.3-32-32s14.3-32 32-32H185.3C173 115.7 144.8 96 112 96H96 32C14.3 96 0 81.7 0 64z"/></svg>
                                </span>
                                <span>{$row->totalBookedAmount|inr_format}</span>
                            </div>
                            <div class="addon-block" data-toggle="tooltip" title="Total Charges">
                                <span>
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="14px" height="14px" fill="#a5a5a5"><path d="M512 80c0 18-14.3 34.6-38.4 48c-29.1 16.1-72.5 27.5-122.3 30.9c-3.7-1.8-7.4-3.5-11.3-5C300.6 137.4 248.2 128 192 128c-8.3 0-16.4 .2-24.5 .6l-1.1-.6C142.3 114.6 128 98 128 80c0-44.2 86-80 192-80S512 35.8 512 80zM160.7 161.1c10.2-.7 20.7-1.1 31.3-1.1c62.2 0 117.4 12.3 152.5 31.4C369.3 204.9 384 221.7 384 240c0 4-.7 7.9-2.1 11.7c-4.6 13.2-17 25.3-35 35.5c0 0 0 0 0 0c-.1 .1-.3 .1-.4 .2l0 0 0 0c-.3 .2-.6 .3-.9 .5c-35 19.4-90.8 32-153.6 32c-59.6 0-112.9-11.3-148.2-29.1c-1.9-.9-3.7-1.9-5.5-2.9C14.3 274.6 0 258 0 240c0-34.8 53.4-64.5 128-75.4c10.5-1.5 21.4-2.7 32.7-3.5zM416 240c0-21.9-10.6-39.9-24.1-53.4c28.3-4.4 54.2-11.4 76.2-20.5c16.3-6.8 31.5-15.2 43.9-25.5V176c0 19.3-16.5 37.1-43.8 50.9c-14.6 7.4-32.4 13.7-52.4 18.5c.1-1.8 .2-3.5 .2-5.3zm-32 96c0 18-14.3 34.6-38.4 48c-1.8 1-3.6 1.9-5.5 2.9C304.9 404.7 251.6 416 192 416c-62.8 0-118.6-12.6-153.6-32C14.3 370.6 0 354 0 336V300.6c12.5 10.3 27.6 18.7 43.9 25.5C83.4 342.6 135.8 352 192 352s108.6-9.4 148.1-25.9c7.8-3.2 15.3-6.9 22.4-10.9c6.1-3.4 11.8-7.2 17.2-11.2c1.5-1.1 2.9-2.3 4.3-3.4V304v5.7V336zm32 0V304 278.1c19-4.2 36.5-9.5 52.1-16c16.3-6.8 31.5-15.2 43.9-25.5V272c0 10.5-5 21-14.9 30.9c-16.3 16.3-45 29.7-81.3 38.4c.1-1.7 .2-3.5 .2-5.3zM192 448c56.2 0 108.6-9.4 148.1-25.9c16.3-6.8 31.5-15.2 43.9-25.5V432c0 44.2-86 80-192 80S0 476.2 0 432V396.6c12.5 10.3 27.6 18.7 43.9 25.5C83.4 438.6 135.8 448 192 448z"/></svg>
                                </span>
                                <span>{$row->totalCargoCharge|inr_format}</span>
                            </div>

                            {if $row->totalCargoCharge != 0}
                                <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                    <table>
                                        {foreach key=ck item=cv from=$row->cargoCharges}
                                            {if $cv == 0}
                                                {continue}
                                            {/if}
                                            <tr>
                                                <td><b>{$ck|_camelcase_to_titlecase}</b></td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right">{$cv|inr_format}</td>
                                            </tr>
                                        {/foreach}
                                    </table>
                                '></i>
                            {else}
                                <i class="fa fa-info-circle fa-inverse"></i>
                            {/if}
                        </div>
                        <br>
                        <span class="mnu_border btn-xs hover-background">
                            <b>Eway Bill :</b> {$row->additionalAttribute->EWAY_BILL_VEHICLE_UPDATED_COUNT|default:0|max:0} out of {$row->additionalAttribute->EWAY_BILL_ADDED_COUNT|default:0|max:0}
                        </span>&nbsp;&nbsp;&nbsp;
                        {assign var="totalCountFull" value=0}
                        {assign var = "SinglePopOverCount" value=0}
                        <span class="mnu_border btn-xs hover-background" data-toggle="popover" data-trigger="hover" data-html="true" data-content="
                        <table width='100%' class='table'>
                            <tr>
                                <th>Station</th>
                                <th>Start</th>
                                <th>end</th>
                            </tr> 
                            {foreach $groupedOdameter as $key => $value }
                                {if $row->aliasCode == $key}
                                    {assign var="totalCount" value=0}
                                    {assign  var = "toolTipDisplay" value =0}
                                {foreach $value as $innerkey => $innervalue}
                                    {foreach $stations as $single}
                                        {if $single.code == $innerkey }
                                            <span class ='hide'>{$totalCount++}</span>
                                            <tr>
                                            <td align = 'left'>{$single.name}</td>
                                            <td align = 'center'>{$innervalue['start']}</td>
                                            <td align = 'center'>{$innervalue['end']}</td>
                                            {if $innervalue['start'] || $innervalue['end']}
                                             <span class ='hide'>{$toolTipDisplay++}</span>
                                            {/if}
                                            </tr>  
                                        {/if}
                                    {/foreach}
                                {/foreach}
                                {$totalCountFull = $totalCount}
                                {$SinglePopOverCount = $toolTipDisplay}
                                {/if}                       
                            {/foreach}
                         
                        </table>"><b>Odometer : </b>{$SinglePopOverCount} out of {$totalCountFull} 
                        </span>
                        {if $row->additionalAttribute->CONSOLIDATED_EWAY_BILL_NO}
                            {assign var=consolidateEWayBill value=','|explode:$row->additionalAttribute->CONSOLIDATED_EWAY_BILL_NO}
                        {/if}
                        
                        {if $consolidateEWayBill|count > 0}
                            <span class="bold">Consolidated Eway Bill :</span>
                            <a href="javascript:;" class="badge badge-pill badge-info popup_msg" data-content='<ul class="p_l_15">
                                {foreach from=$consolidateEWayBill item=val}
                                    <li><a href="javascript:;" onclick="showEWayBillPdfDialog({$val})">{$val}</a></li>
                                {/foreach}
                            </ul>'>C</a>
                        {/if}
                        {if isNotNull($row->remarks)}<br>
                            <div class="m-t-4"><b>Remarks :</b> {$row->remarks}</div>
                        {/if}
                    </div>
                    <div class="col-md-1 p_l_n">
                        <div class="mnu_border btn-sm clearfix" data-toggle="popover" data-trigger="hover" data-html="true" data-content="
                            <table width='700' class='table'>
                                <tr>
                                    <th>Branch</th>
                                    <th>Loaded</th>
                                    <th>Unloaded</th>
                                    <th>Pending Unload</th>
                                </tr> 
                                {foreach from=$row->transitRoutes item=route}  
                                    <tr>
                                        <td>{$route->organization->name}</td>
                                        <td align='right'>{$route->loadedCount}</td>
                                        <td align='right'>{$route->unloadedCount}</td>
                                        <td align='right'>{$route->pendingUnloadCount}</td>
                                    </tr>                      
                                {/foreach}
                            </table>">
                            <small class="pull-right">Total LR</small><br>
                            <span>
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" fill="#e9e9e9" style="width: 35px; display: inline-block;"><path d="M256 48c0-26.5 21.5-48 48-48H592c26.5 0 48 21.5 48 48V464c0 26.5-21.5 48-48 48H381.3c1.8-5 2.7-10.4 2.7-16V253.3c18.6-6.6 32-24.4 32-45.3V176c0-26.5-21.5-48-48-48H256V48zM571.3 347.3c6.2-6.2 6.2-16.4 0-22.6l-64-64c-6.2-6.2-16.4-6.2-22.6 0l-64 64c-6.2 6.2-6.2 16.4 0 22.6s16.4 6.2 22.6 0L480 310.6V432c0 8.8 7.2 16 16 16s16-7.2 16-16V310.6l36.7 36.7c6.2 6.2 16.4 6.2 22.6 0zM0 176c0-8.8 7.2-16 16-16H368c8.8 0 16 7.2 16 16v32c0 8.8-7.2 16-16 16H16c-8.8 0-16-7.2-16-16V176zm352 80V480c0 17.7-14.3 32-32 32H64c-17.7 0-32-14.3-32-32V256H352zM144 320c-8.8 0-16 7.2-16 16s7.2 16 16 16h96c8.8 0 16-7.2 16-16s-7.2-16-16-16H144z"/></svg>
                            </span>
                            <h4 class="pull-right bold d-inline-block m-t-4">{$total_count|max:0}</h4>
                        </div>
                    </div>
                    <div class="col-md-1 text-right">
                        {if !in_array($row->transitStatus->code, ["CMPLT", "TRNSFR", "EMPLD"])}
                            <a class="btn btn-default btn-xs" href="#cargo/add-ogpl?transitCode={$row->code}&date={$row->tripDate}&back=ogpl" {if $isEmptyLoad}onclick="alertEmptyLoad()"{/if}> <i class="fa fa-pencil"></i> Edit</a>&emsp;
                        {/if}
                        <a href="javascript:;" data-toggle="tooltip" title="{$row->audit->user->name} <br/> {$row->audit->updatedAt|date_format:$ns_datetime_format} "><i class="fa fa-info-circle"></i></a>
                        <br><br>

                        {if $row->transitStatus->code == 'EMPLD' || $isEmptyLoad}
                            <span class="label label-danger">! Empty Load</span>
                        {elseif $row->transitStatus->code == 'NEW'}
                            <span class="label label-success">New</span>
                        {elseif $row->transitStatus->code == 'INTRN'}
                            <span class="label label-warning">In-Transit</span>
                        {elseif $row->transitStatus->code == 'CMPLT'}
                            <span class="label label-danger">Completed</span>
                        {elseif $row->transitStatus->code == 'TRNSFR'}
                            <span class="label label-danger">Transferred</span>
                        {elseif $row->transitStatus->code == 'TRSFRLD'}
                            <span class="label label-warning">Transfer Load</span>
                        {/if}
                    </div>
                </div>
            </div>
            <ul class="transit-tabs">
                <li class="transit-tab"><span class="point_cur" data-toggle="tab" href="#history_tab" data-tab="HISTORY">History</span></li>
                <li class="transit-tab b_l"><span class="point_cur" data-toggle="tab" href="#route_tab" data-tab="ROUTE">Route</span></li>
                {if $loaded_count > 0}
                    <li class="transit-tab b_l"><span class="point_cur" data-toggle="tab" href="#transfer_tab" data-tab="TRANSFER">Transfer</span></li>
                {/if}                    
                {if $action_rights['EBL-EWAY-BILL'] > 0 && ($row->additionalAttribute->EWAY_BILL_ADDED_COUNT - $row->additionalAttribute->EWAY_BILL_VEHICLE_UPDATED_COUNT)}
                    <li class="transit-tab b_l"><span class="point_cur" data-toggle="tab" href="#ewaybill_tab" data-tab="EWAYBILL">EWayBill Part-B</span></li>
                {/if}
                <li class="transit-tab b_l"><span class="point_cur" data-toggle="tab" href="#fuel_tab" data-tab="FUEL">Fuel Expense</span></li>
                <li class="transit-tab b_l"><span class="point_cur" data-toggle="tab" href="#payments_tab" data-tab="PAYMENTS">Payments</span></li>
                
                {if $tab == 'ARRIVAL'}
                    {if !$isEmptyLoad}
                        <li class="transit-tab b_l"><a class="tab-link" href="#cargo/ogpl-chart-details?transitCode={$row->code}&date={$row->tripDate}" title="View Chart" target="_blank">View Chart <i class="fa fa-arrow-right"></i></a></li>
                    {/if}
                    {if $cargo_setting->ogplModelCode == 'VER3'}
                        {* {if $cargo_setting->transitOdometerModelCode == "ORGDTN" } Origin - Destn. Odometer Based Actions *}
                            {if $isEmptyLoad && !$startTrip && $cargo_setting->transitOdometerModelCode == "ORGDTN"}
                                {if $row->transitCargoDetails[0]->fromOrganization->code !== $login_branch}
                                    <li class=""><a class="btn btn-info view-chart-btn disabled" disabled  href="javascript:void(0);" title="Trip not yet Started">Unload</a></li>
                                {else}
                                    <li class=""><a class="btn btn-info view-chart-btn disabled"  href="javascript:void(0);" title="">Unload</a></li>
                                {/if}
                            {else}
                                {if $row->transitCargoDetails[0]->fromOrganization->code !== $login_branch}
                                <li class=""><a class="btn btn-info view-chart-btn"  href="#cargo/ogpl-unload-lr?transitCode={$row->code}&date={$row->tripDate}&vehicleCode={$row->busVehicle->code}&unloadType={$unloadType}&redirect=unload&transitType={$transittype}" onclick="{if $isEmptyLoad}acceptEmptyUnload('{$row->code}', '{$row->busVehicle->code}', '{$row->toOrganization->code}');{else}acceptUnloading();{/if}" title="Unload Transit" target="_blank">Unload</a></li>
                                {/if}        
                            {/if}
                        {* {/if} *}
                        {if $cargo_setting->transitOdometerModelCode == "RTEBSD" } {*Route Based Odometer / Unload Actions*}
                            
                        {/if}
                        {if $cargo_setting->transitOdometerModelCode == "NA" } {*Don't Restrict the ACtions*}
                            
                        {/if}
                    {else}
                        {if $row->transitCargoDetails[0]->fromOrganization->code !== $login_branch}
                            <li class=""><a class="btn btn-info view-chart-btn"  href="#cargo/ogpl-unload-lr?transitCode={$row->code}&date={$row->tripDate}&vehicleCode={$row->busVehicle->code}&unloadType={$unloadType}&redirect=unload" onclick="{if $isEmptyLoad}acceptEmptyUnload('{$row->code}', '{$row->busVehicle->code}', '{$row->toOrganization->code}'){else}acceptUnloading();{/if}" title="Unload Transit" target="_blank">Unload</a></li>
                        {/if}
                    {/if}
                    {if $outForDelivery}
                        <li class=""><a class="btn btn-success view-chart-btn " href="#cargo/out-for-delivery-unload-lr?transitCode={$row->code}&date={$row->tripDate}&vehicleCode={$row->busVehicle->code}&transitType={$transittypeout}" title="Unload" target="_blank">Deliver</a></li>
                    {/if}
                {elseif $tab == 'DEPARTURE'}
                    <li class="transit-tab b_l"><a class="tab-link" href="#cargo/ogpl-chart-details?transitCode={$row->code}&date={$row->tripDate}" title="View Chart" target="_blank">View Chart <i class="fa fa-arrow-right"></i></a></li>
                    <li class=""><a class="btn btn-info view-chart-btn" href="#cargo/add-ogpl?transitCode={$row->code}&date={$row->tripDate}&back=ogpl" {if $isEmptyLoad}onclick="alertEmptyLoad()"{/if} title="Load Transit" target="_blank">Load</a></li>
                    {if $outForDelivery}
                        <li class="mr_l_1_em"><a class="btn btn-success view-chart-btn " href="#cargo/out-for-delivery-unload-lr?transitCode={$row->code}&date={$row->tripDate}&vehicleCode={$row->busVehicle->code}&transitType={$transittypeout}" title="Delivery" target="_blank">Deliver</a></li>
                    {/if}
                {else}
                    {if !$isEmptyLoad}
                        <li class=""><a class="btn btn-primary view-chart-btn" href="#cargo/ogpl-chart-details?transitCode={$row->code}&date={$row->tripDate}" title="View Chart" target="_blank">View Chart</a></li>
                    {/if}
                {/if}
            </ul>
        </div>
    {foreachelse}
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="well well-large m-0"> Sorry! No trips were found</div>
            </div>
        </div>
    {/foreach}
{/function}

<div id="ogpl-eway-bill-pdf-dialog" class="hide">
    <a href="javascript:;" class="pull-right" onclick="closeEWayBillPdfDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div id="ogpl-eway-bill-iframe-alert"></div>
    <div id="ogpl-eway-bill-iframe" style="height:90%;width:100%;"></div>
</div>

<script id="transit-tabscontent-tpl" type="text/template">
    <div id="transit-tabscontent" class="tab-content border_top">
        <div id="history_tab" class="tab-pane fade"></div>
        <div id="transfer_tab" class="tab-pane fade"></div>
        <div id="ewaybill_tab" class="tab-pane fade"></div>
        <div id="fuel_tab" class="tab-pane fade"></div>
        <div id="payments_tab" class="tab-pane fade"></div>
        <div id="route_tab" class="tab-pane fade"></div>
    </div>
</script>

<input type="hidden" id="active-transit-code">

<script>
    var transitListData = {$result|json_encode};
    var aliasCodeFilter = {$aliasCodeFilter|json_encode};
    var ogplLastActive = {$fogplLastActive|json_encode};
    var login_station = {$login_station|json_encode};
    var station = {$stations|json_encode};
    var login_branch = {$login_branch|json_encode};
    var cargoSetting = {$cargo_setting|json_encode}
    var groupedOdameter = {$groupedOdameter|json_encode}
    var loading_spinner = "<div class='text-center'><img src='{$base_url}/assets/img/loaders/20.gif' /></div>"

    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover',
        container: '#find-uncargo-list-container'
    });
    $('[data-toggle="tooltip"]').tooltip({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
    
    $('.popup_msg').popover({
        placement: 'top',
        html: true,
        trigger: 'focus'
    });

    $('#ogpl-trip-list').on('click', '.transit-tabs', function(e) {
        if ($(e.target).is('.view-chart-btn')) {
            $('.transit-row-body.last-active').removeClass('last-active');
            $(e.target).closest('.transit-row').find('.transit-row-body').addClass('last-active');
            return;
        }
        if ($(e.target).closest('.transit-tab.active').length) {
            $('#transit-tabscontent').remove();
            $('.transit-tabs > .transit-tab.active').removeClass('active');
            $('#active-transit-code').val('');
            return false;
        }

        var $transit = $(e.target).closest('.transit-row');

        $('#transit-tabscontent').remove();
        $('.transit-tabs > .transit-tab.active').removeClass('active');
        $('.transit-row-body.last-active').removeClass('last-active');

        $transit.find('.transit-row-body').addClass('last-active');

        var tpl = $('#transit-tabscontent-tpl').html();
        $transit.append(tpl);
    });

    $('#ogpl-trip-list').on('shown.bs.tab', function(e) {
        var tab = $(e.target).data('tab');
        var href = $(e.target).attr('href');

        var $transit = $(e.target).closest('.transit-row');
        var $tab = $transit.find(href);

        var transitCode = $transit.data('transitcode');
        var vehiclecode = $transit.data('vehiclecode');
        $('#active-transit-code').val(transitCode);

        if (tab == 'HISTORY') {
            loadTransitHistory();
        } else if (tab == 'TRANSFER') {
            getTransitOdometerDetails(transitCode);
        } else if (tab == 'EWAYBILL') {
            loadEwaybillPartB();
        } else if (tab == 'FUEL') {
            loadTransitFuelExpense();
        } else if (tab == 'PAYMENTS') {
            loadTransitIncomeExpense(vehiclecode);
        } else if (tab == 'ROUTE') {
            loadTransitRoute();
        }

        $('html, body').animate({
            scrollTop: $transit.offset().top - 70
        }, 'fast');
    });

    if (aliasCodeFilter) {
        let defaultTab = $('.transit-row[data-aliascode="' + aliasCodeFilter + '"]').closest('.tab-pane').attr('id');
        $('.main-transit-tabs [href="#' + defaultTab + '"]').tab('show');
    } else if (ogplLastActive) {
        let $transit = $('#transit-' + ogplLastActive);
        $transit.find('.transit-row-body').addClass('last-active');

        let defaultTab = $transit.closest('.tab-pane').attr('id');
        $('.main-transit-tabs [href="#' + defaultTab + '"]').tab('show');
    } else {
        $('.main-transit-tabs [data-tab][data-count!="0"]:first').tab('show');
    }

    function toggleRouteTab(transitCode) {
        $('#transit-' + transitCode + ' [data-tab="ROUTE"]').trigger('click');
    }

    function toggleHistoryTab(transitCode) {
        $('#transit-' + transitCode + ' [data-tab="HISTORY"]').trigger('click');
    }

    function getActiveTransitData() {
        var transitCode = $('#active-transit-code').val();
        var transitData = _.find(transitListData, o => o.code == transitCode);

        return transitData;
    }

    function loadTransitHistory() {
        var transitData = getActiveTransitData();
        if (!transitData) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;
        data.aliasCode = transitData.aliasCode;
        data.filterType = 'NA';

        $('#history_tab').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/transit-history',
            data: data,
            success: function(res) {
                $('#history_tab').html(res);
                $('#history_tab').find('.popup_top').hide();
            }
        });
    }

    var transitOdometerDetails = {};
    function getTransitOdometerDetails(transitCode) {
        var transitData = getActiveTransitData();
        if (!transitData.code) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/get-transit-odometer-details',
            data: data,
            success: function(res) {
                if(res.status == 1) {
                    transitOdometerDetails = res.data;
                }
                loadTransitTransfer(transitData);
            }
        });
    }
    
    function loadTransitTransfer(transitData) {
        if (!transitData) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;
        data.vehicleCode = transitData.busVehicle.code;

        data.show_end_odo = 0;
        var isFTLOGPL =  $.inArray('FULL-TRK-LOAD', transitData.activity) != -1;
        if ($.inArray('PART-TRK-LOAD', transitData.activity) != -1) {
            isFTLOGPL = $.inArray('PART-TRK-LOAD', transitData.activity) != -1;
        }
        if (isNotNull(transitOdometerDetails)) {
            var odoStations = [];
            $.map(transitOdometerDetails || [], function(val) {
                odoStations.push(val.station.code)
            });

            var odoDetails = '';
            $.each(transitOdometerDetails, function(key, row) {
                if ((isFTLOGPL && row.startOdometer > 0) || (row.organization.code == login_branch)){
                    odoDetails = row;
                    return false;
                }
            });

            // var station_in_via = '';
            // // From station
            // if (isNotNull(transitData) && (transitData.fromStation.code == login_station)) {
            //     station_in_via = transitData.fromStation.code
            // }

            // // to station
            // if (isNotNull(transitData) && (transitData.toStation.code == login_station)) {
            //     station_in_via = transitData.fromStation.code
            // }

            // // via station
            // $.each(transitData.viaStations || [], function(key,val) {
            //     if (val.code == login_station) {
            //         station_in_via = val.code;
            //     }
            // });

            // // hub station
            // $.each(transitData.hubViaStations || [], function(key,val) {
            //     if (val.code == login_station) {
            //         station_in_via = val.code;
            //     }
            // });

            // local station
            $.each(transitData.localViaStations || [], function(key,val) {
                if (val.code == login_station) {
                    station_in_via = val.code;
                }
            });
            
            // data.transferEndOdometer = odoDetails.endOdometer;
            // if ((transitOdometerDetails[0].startOdometer > 0) && (isNotNull(station_in_via) && ($.inArray(station_in_via, odoStations) == -1 || (isNotNull(odoDetails) && odoDetails.endOdometer == 0)))) {
            //     data.show_end_odo = 1;
            // }
        }
        
        $('#transfer_tab').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/ogpl-transfer-list',
            data: data,
            success: function(res) {
                $('#transfer_tab').html(res);
            }
        });
    }

    function loadEwaybillPartB() {
        var transitData = getActiveTransitData();
        if (!transitData) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;
        data.vehicleNo = transitData.busVehicle.registationNumber;
        data.ogplFrom = transitData.fromStation.name;

        $('#ewaybill_tab').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/ogpl-ewaylr-list',
            data: data,
            success: function(res) {
                $('#ewaybill_tab').html(res);
                $('#ewaybill_tab').find('.popup_top').hide();
            }
        });
    }

    function loadTransitFuelExpense() {
        var transitData = getActiveTransitData();
        if (!transitData) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;

        $('#fuel_tab').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/ogpl-fuel-expense',
            data: data,
            success: function(res) {
                $('#fuel_tab').html(res);
            }
        });
    }

    function loadTransitIncomeExpense(vehiclecode) {
        var transitData = getActiveTransitData();
        if (!transitData) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;
        data.ogplType = 'OGPL';
        data.vehicleCode = vehiclecode;
        data.cargoActivityType = transitData.cargoActivityType.code;

        $('#payments_tab').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/ogpl-income-expense',
            data: data,
            success: function(res) {
                $('#payments_tab').html(res);
            }
        });
    }

    function loadTransitRoute() {
        var transitData = getActiveTransitData();
        if (!transitData) {
            return;
        }

        var data = {};
        data.transitCode = transitData.code;

        $('#route_tab').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/ogpl-odometer-report',
            data: data,
            success: function(res) {
                $('#route_tab').html(res);
            }
        });
    }

    function alertEmptyLoad() {
        if (!confirm('Do you want to load to Empty OGPL?')) {
            event && event.preventDefault();
        }
    }

    function createNewLinkedTransit(transitCode, vehicleCode, transitType) {
        var data = {};
        data.linkTransitCode = transitCode;
        data.linkVehicleCode = vehicleCode;
        if (cargoSetting.ogplModelCode == 'VER3') {
            data.linkTransitType = transitType
        }

        if (!transitCode) {
            return;
        }

        var loading_overlay = iosOverlay({
            text: 'Validating...',
            icon: 'fa fa-spinner fa-spin'
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/validate-transit-linking',
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: 'fa fa-check',
                        text: 'Success'
                    });
                    setTimeout(function () {
                        var params = $.param(data);
                        if (transitType == 'TRNT') {
                            window.open('#cargo/add-ogpl?' + params);
                        } else if (transitType == 'INTRNT') {
                            if (cargoSetting.ogplModelCode == 'VER3') {
                                window.open('#cargo/add-ogpl?' + params);
                            } else {              
                                window.open('#cargo/add-local-transit?' + params);
                            }
                        } else if (transitType == 'OTFD') {
                            if (cargoSetting.ogplModelCode == 'VER3') {
                                window.open('#cargo/add-ogpl?' + params);
                            } else {  
                                window.open('#cargo/add-out-for-delivery?' + params);
                            }
                        }
                    }, 500)
                } else {
                    alert(response.errorDesc);
                    loading_overlay.update({
                        icon: 'fa fa-times',
                        text: 'Failed'
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }

    function showEWayBillPdfDialog(code) {
        $('#ogpl-eway-bill-iframe').html('');
        $('#ogpl-eway-bill-pdf-dialog').css('background', '#fff');
        $('#ogpl-eway-bill-pdf-dialog').removeClass('hide');
        $('#ogpl-eway-bill-pdf-dialog').dialog({
            autoOpen: true,
            height: 700,
            width: 1100,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();

        var $iframe = $('<iframe />');
        $iframe.attr('src', base_url + 'cargo/ogpl-consolidated-eway-bill-pdf?consEwayBillNo=' + code);
        $iframe.attr('class', 'iframe-fullwidth iframe-loading-bg');
        $('#ogpl-eway-bill-iframe').html($iframe);
    }

    function closeEWayBillPdfDialog() {
        $('#ogpl-eway-bill-iframe').html('');
        $('#ogpl-eway-bill-pdf-dialog').dialog('destroy');
        $('#ogpl-eway-bill-pdf-dialog').hide();
        //$('#ogpl-eway-bill-pdf-dialog').dialog('close');
    }

    function showOgplListStatusWise(ele) {
        var filter = $(ele).data('filter');
        $('.filter-btn').css('text-decoration', 'none');
        $(ele).css('text-decoration', 'underline');
        
        if (filter == 'ALL') {
            $('#ogpl-trip-list').find('.transit-row').removeClass('hide');
        } else {
            $('#ogpl-trip-list').find('.transit-row[data-ogplstatus!="'+filter+'"]').addClass('hide');
            $('#ogpl-trip-list').find('.transit-row[data-ogplstatus="'+filter+'"]').removeClass('hide');
        }
    }

    function acceptUnloading() {
        if (!confirm('Do you want to accept unloading?')) {
            event && event.preventDefault();
        }
    }

    function acceptEmptyUnload(code, vehicleCode, toCrganizationCode) {
        event && event.preventDefault();
        if (!confirm('Do you want to accept unloading Empty OGPL?')) {
            return false;
        }

        if (cargoSetting.transitOdometerModelCode == "NA") {
            saveEmptyUnload(code);
            return;
        }

        var params = {};
        params.transitCode = code;
        params.vehicleCode = vehicleCode;
        params.toOrganizationCode = toCrganizationCode;
        showEndTripDialog(params, function (e) {
            if (e.data && e.data.success == 1) {
                // $('#shipment-type-btns').trigger('click');
                getOgplList();
                // saveEmptyUnload(code);
            }
        });
    }

    function saveEmptyUnload(code) {
        var data = {};
        data.code = code;

        var loading_overlay = iosOverlay({
            text: "Unloading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + 'cargo/ogplv2-empty-unload',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Unloaded"
                    });
                    getOgplList();
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: response.errorDesc
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }
</script>
