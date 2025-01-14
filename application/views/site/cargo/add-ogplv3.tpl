<div class="brand_top">
    <h3>
        {if $smarty.request.transitCode == ''}Add Transit{else}Edit Transit{/if}
    </h3>
    <span class="align-right">
        {if $smarty.request.transitCode == ''}
            <a href="#cargo/{$smarty.request.back|default:'ogpl'}" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>
        {else}
            <a href="#cargo/{$smarty.request.back|default:'ogpl'}?fill=1" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>
        {/if}
    </span>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row" id="ogpl-form-div">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default" id="ogpl-search-container">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="h5 bold">Select Mode of transit ?</div>
                                            <div class="pb10">
                                                <div class="btn-group btn-group-days" id="transit-type" data-toggle="buttons">
                                                    {if $cargo_setting->transitMode[1] && $action_rights['TRANSIT-DIRECT-LOAD'] == 1}
                                                    <label class="btn btn-success chk-btn" title="Direct Load" {if $smarty.request.transitCode=="TRNT"}disabled{/if}>
                                                            <input type="checkbox" name="transit-type" value="TRNT" {if $smarty.request.transitCode=="TRNT"}disabled{/if}>Direct Load
                                                        </label>
                                                    {/if}
                                                    
                                                    {if $cargo_setting->transitMode[2] && $action_rights['TRANSIT-LINK-LOAD'] == 1}
                                                        <label class="btn btn-success chk-btn" title="Link Load" {if $smarty.request.transitCode=="HBTRNT"}disabled{/if}>
                                                            <input type="checkbox" name="transit-type" value="HBTRNT" {if $smarty.request.transitCode=="HBTRNT"}disabled{/if}>{lang('hub')} Load
                                                        </label>
                                                    {/if}
                                                    
                                                    {if $cargo_setting->transitMode[3] && $action_rights['TRANSIT-LOCAL-LOAD'] == 1}
                                                        <label class="btn btn-success chk-btn" title="Local Transit" {if $smarty.request.transitCode=="INTRNT"}disabled{/if}>
                                                            <input type="checkbox" name="transit-type" value="INTRNT" {if $smarty.request.transitCode=="INTRNT"}disabled{/if}>Local Transit
                                                        </label>
                                                    {/if}
                                                    {if $cargo_setting->transitMode[4] && $action_rights['TRANSIT-OUT-FOR-DELIVERY'] == 1}
                                                        <label class="btn btn-success chk-btn" title="Out for delivery" {if $smarty.request.transitCode=="OTFD"}disabled{/if}>
                                                            <input type="checkbox" name="transit-type" value="OTFD" {if $smarty.request.transitCode=="OTFD"}disabled{/if}>Out For Delivery
                                                        </label>
                                                    {/if}
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3 bx-grey">
                                            <label class="pull-left m-t-5" for="ogpl-search-vehicle">Vehicle</label>
                                            <div class="pull-right pb10 {if $smarty.request.transitCode || count($ownershipTypes) <= 1}hide{/if}" id="ogpl-search-owner">
                                                <div class="btn-group btn-group-days" data-toggle="buttons">
                                                    <label class="btn btn-success btn-xs chk-btn active" title="All Types">
                                                        <input type="radio" name="ogpl-search-owner" value="NA" checked>All
                                                    </label>
                                                    {foreach key=code item=name from=$ownershipTypes}
                                                        <label class="btn btn-success btn-xs chk-btn" title="{$name}">
                                                            <input type="radio" name="ogpl-search-owner" value="{$code}">{$name}
                                                        </label>
                                                    {/foreach}
                                                </div>
                                            </div>
                                            <div class="input-group col-md-12">
                                                <input type="text" class="form-control" id="ogpl-search-vehicle">
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-7">
                                                    <div class="text-muted m-t-5 hide" id="vehicle-location-info"><b>Available At : </b><span id="vehicle-location"></span></div>
                                                </div>
                                                {if $action_rights['ADD-NEW-VEHICLE']}
                                                    <div class="col-sm-5">
                                                        <a href="javascript:;" class="m-t-5 bold pull-right {if $smarty.request.transitCode}hide{/if}" onclick="quickAddNewVehicle()">Add New Vehicle</a>
                                                    </div>
                                                {/if}
                                               

                                            </div>
                                        </div>

                                        {* commented *}
                                        <div class="form-group col-md-1 {if !$smarty.request.transitCode || count($ownershipTypes) > 1}p_t_30{/if}">
                                            {if $smarty.request.transitCode || count($ownershipTypes) < 1}
                                                <label for="">&nbsp;</label>
                                            {/if}
                                            <div class="input-group">
                                                {if $cargo_setting->ogplModelCode == 'VER3'}
                                                    <button class="btn btn-success {if $smarty.request.transitCode || count($ownershipTypes) < 1} m-t-5{/if}" type="button" onclick="getOgplList();">Get {lang('ogpl')}</button>&nbsp;
                                                {/if}
                                            </div>
                                        </div>
                                        
                                        <div id="vehicle-details" class="hide col-md-4">
                                            <div class="form-group col-md-12"><br>
                                                <span class="title-text" id="v-regno"></span><br>
                                                <span class="text-muted" id="v-name"></span>
                                            </div>
                                            <div class="form-group col-md-12 p_l_n p_r_n"><br>
                                                <div class="col-md-6">
                                                    <b>Transporter</b> - <span id="v-transporter"></span><br>
                                                    <b>Fuel Capacity</b> - <span id="v-fuel"></span>
                                                </div>
                                                <div class="col-md-6">
                                                    <b>Dimension</b> - <span id="v-dimension"></span><br>
                                                    <b>Capacity</b> - <span id="v-capacity"></span>
                                                </div>
                                                <div class="col-md-12" id="v-tags">
                                                    <b>Tags : </b><span class="values"></span>
                                                </div>
                                            </div>
                                        </div>
                                                    
                                        <div class="col-md-12">
                                            <div class="align-center alert alert-danger pull-left" style="display:none;" id="ogpl_search_action_state"></div>
                                        </div>
                                    </div>
                                </div>
                            </div><!--ogpl search container end-->

                            <div class="clearfix"></div><br>
                            <div id="ogpl-search-list-container" style="display: none;">
                                <div>
                                    <div id="ogpl-search-list"></div>                                    
                                </div>
                            </div><!--ogpl search list container end-->

                            <div id="add-ogpl-container" style="display: none;">
                                <br>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="panel panel-default h-100">
                                            <div class="heading_b">
                                                Transit Details
                                                {if $cargo_setting->userAccountModel->code == 'DINV'}
                                                    <label class="pull-right">
                                                        <span id="next-ogpl-sequence">&nbsp;-</span>
                                                    </label>
                                                {/if}
                                            </div>
                                            <div class="panel-body">
                                                <form id="add-ogpl-form" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="ogpl-direct" class="req">Direct Load</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                   
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                            {if $action_rights == "SAVE-OGPL-TEMPLATE"}
                                                                <label class="pull-right" data-transit-field="TRNT"><input type="checkbox" id="save-as-tpl"> Save as Template</label>
                                                            {/if}
                                                                <label for="ogpl-name">Name</label>
                                                                <input type="text" class="form-control" id="ogpl-name" placeholder="{lang('ogpl')} Name" maxlength="40">
                                                          
                                                            </div>
                                                            <input type="hidden" id="ogpl-date" />
                                                        </div>
                                                        <div class="col-md-5" data-transit-field="TRNT">
                                                            <label for="ogpl-tpl">{lang('Transit')} Routes
                                                                <a href="javascript:;" class="pull-right" onclick="toggleRoutes()">All Routes</a>
                                                            </label>
                                                            <div class="form-group">
                                                                <select id="ogpl-tpl" class="form-control" onchange="setOGPLTemplate(this.value)">
                                                                    <option value="" selected="">Select Routes</option>
                                                                    {foreach item=tpl from=$ogpltpl}
                                                                        {if $tpl->fromStation->code==$login_station}
                                                                        <option value="{$tpl->code}">{$tpl->name}</option>
                                                                        {/if}
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                   
                                                     <div class="row">
                                                        <div class="form-group col-md-6">
                                                            <label for="ogpl-date">Transit Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="ogpl-date" readonly {if $action_rights['OGPL-PREV-DATE'] != 1}disabled{/if} value="{$smarty.now|date_format:$ns_date_format}" autocomplete="off" placeholder="Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6" data-transit-field="TRNT">
                                                            <div class="form-group">
                                                                <label for="ogpl-from" class="req">From Station</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="ogpl-from" class="form-control OTFD-field"  onclick="stationfilter1();" onchange="setHubLoadStations(this); getNextOGPLSequence();setLocalTransitStations();">
                                                                        <option value="" selected="" disabled>Select From</option>
                                                                        {foreach item=station from=$stations}
                                                                            <option value="{$station.code}" data-stationcode="{$station.code}">{$station.name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6" data-transit-field="TRNT">
                                                            <div class="form-group">
                                                                <label for="ogpl-to" class="req">To Station</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="ogpl-to" class="form-control OTFD-field" onclick="stationfilter2();" onchange="setHubLoadStations(this);setHubLoadZones(this);">
                                                                        <option value="" selected=""disabled   >Select To</option>
                                                                        {foreach item=station from=$stations}
                                                                            <option value="{$station.code}" data-stationcode="{$station.code}">{$station.name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6" data-transit-field="TRNT">
                                                            <div class="form-group from-org">
                                                                <label for="ogpl-from-branch" class="req">From organization</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="ogpl-from-branch" name="organizationCode" class="form-control">
                                                                        {foreach item=branch from=$branches key=bcode}
                                                                            <option value="{$branch->code}" data-brachcode="{$branch->station->code}">{$branch->name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6" data-transit-field="TRNT" >
                                                            <div class="form-group to-org">
                                                                <label for="ogpl-to-branch" class="req">To organization</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="ogpl-to-branch" name="organizationCode" class="form-control">
                                                                        {foreach item=branch from=$branches key=bcode}
                                                                            <option value="{$branch->code}" data-brachcode="{$branch->station->code}">{$branch->name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="ogpl-departuretime">Departure Time</label>
                                                                <select id="ogpl-departuretime" class="form-control">
                                                                    <option value="" selected="">Select Time</option>
                                                                    {assign var="timerange" value=hours_range(0, 86400 -1, 60 * 15)}
                                                                    {foreach item=time key=seconds from=$timerange}
                                                                        <option value="{$seconds / 60}">{$time}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                                
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="ogpl-arrivaltime">Arrival Time</label>
                                                                <div class="input-group" style="display: flex;">
                                                                    <select id="ogpl-arrivaltime" class="form-control">
                                                                        <option value="" selected="">Select Time</option>
                                                                        {foreach item=time key=seconds from=$timerange}
                                                                            <option value="{$seconds / 60}">{$time}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                    <select id="ogpl-arrivalday" class="form-control" style="width: 175px;">
                                                                        <option value="0" selected="">Same Day</option>
                                                                        <option value="1440">Next Day</option>
                                                                        <option value="2880">Third Day</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label for="ogpl-remarks">Remarks</label>
                                                                <textarea class="form-control" placeholder="Remarks (optional)" id="ogpl-remarks" rows="3" style="resize: vertical;"></textarea>
                                                            </div>
                                                        </div>
                                                        <div class="clearfix"></div>
                                                        <div class="col-md-12 hide" id="link-local-transit-div">
                                                            <input type="checkbox" id="link-local-transit">
                                                            <label for="link-local-transit" class="d-inline"></label>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="panel panel-default h-100">
                                            <div class="heading_b">Zones, Stations & Branches</div>
                                            <div class="panel-body">
                                                <form id="add-ogpl-form" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group" data-transit-field="TRNT">
                                                                <label for="ogpl-via" class="req">Via Stations <a href="javascript:;" class="pull-right" onclick="addViaZone()">Add Via Zones</a> </label>
                                                                <div class="input-group col-md-12 ogpl-via-stations">
                                                                    <select id="ogpl-via" class="form-control TRNT-field" multiple="multiple" onchange="setHubLoadStations(this);setLocalTransitStations();">
                                                                        {foreach item=station from=$stations}
                                                                            <option value="{$station.code}">{$station.name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-12">
                                                            <div class="form-group hide" data-transit-field="TRNT" id="ogpl-add-via-zone-div">
                                                                <label for="ogpl-via-zones">Via Zones</label>
                                                                <div class="input-group col-md-12 ogpl-via-zones">
                                                                    <select id="ogpl-via-zones" class="form-control TRNT-field" multiple="multiple" onchange="setViaStations();setHubLoadZones(this);">
                                                                        {foreach key=key item=row from=$zone}
                                                                            <option value="{$row->code}">{$row->name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-12">
                                                            <div class="form-group" data-transit-field="TRNT">
                                                                <label for="link-load-stations" class="req">{lang('hub')} Load <a href="javascript:;" class="pull-right" onclick="addLinkLoadZone()">Add {lang('hub')} Load Zones</a></label>
                                                                <div class="input-group col-md-12 link-load-stations">
                                                                    <select id="link-load-stations" class="form-control HBTRNT-field" multiple="multiple" onchange="setViaLoadStations(this);">
                                                                        {foreach item=station from=$stations}
                                                                            <option value="{$station.code}">{$station.name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-12">
                                                            <div class="form-group hide" data-transit-field="TRNT" id="ogpl-add-link-load-zones-div">
                                                                <label for="link-load-zones">{lang('hub')} Load Zones</label>
                                                                <div class="input-group col-md-12 link-load-zones">
                                                                    <select id="link-load-zones" class="form-control HBTRNT-field" multiple="multiple" onchange="setLinkLoadStations();">
                                                                        {foreach key=key item=row from=$zone}
                                                                            <option value="{$row->code}">{$row->name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-12">
                                                            <div class="form-group" data-transit-field="INTRNT">
                                                                <label for="local-via-branches" class="req">Local Transit</label>
                                                                <div class="input-group col-md-12 local-via-branches">
                                                                    <select id="local-via-branches" class="form-control INTRNT-field" multiple="multiple">
                                                                        {if $smarty.request.transitCode}
                                                                            {foreach item=row from=$branches}
                                                                                {if $row->station->code == $login_station && $row->code != $login_branch && $row->hubFlag}
                                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                                {/if}
                                                                            {/foreach}
                                                                        {else}
                                                                            {foreach item=row from=$branches}
                                                                                {if $row->station->code == $login_station && $row->code != $login_branch && $row->hubFlag}
                                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                                {/if}
                                                                            {/foreach}
                                                                        {/if}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="panel panel-default">
                                            <div class="heading_b">Supervisor Details / Driver Allocation</div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="ogpl-supervisor-name" class="req">Supervisor</label>
                                                            <input type="text" name="ogpl-supervisor-name" value="" class="form-control capitalize" id="ogpl-supervisor-name" placeholder="Supervisor Name">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="ogpl-supervisor-mobile" class="req">Supervisor Mobile</label>
                                                            <input type="text" name="ogpl-supervisor-mobile" value="" class="form-control capitalize" id="ogpl-supervisor-mobile" placeholder="Supervisor Mobile" maxlength="10">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="ogpl-prim-driver-name" class="req">Primary Driver Name</label>
                                                            <input type="text" name="ogpl-prim-driver-name" value="" class="form-control capitalize" id="ogpl-prim-driver-name" placeholder="Driver Name">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="ogpl-prim-driver-mobile" class="req">Primary Driver Mobile</label>
                                                            <input type="text" name="ogpl-prim-driver-mobile" value="" class="form-control capitalize" id="ogpl-prim-driver-mobile" placeholder="Driver Mobile" maxlength="10">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="ogpl-sec-driver-name">Secondary Driver Name</label>
                                                            <input type="text" name="ogpl-sec-driver-name" value="" class="form-control capitalize" id="ogpl-sec-driver-name" placeholder="Driver Name">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="ogpl-sec-driver-mobile">Secondary Driver Mobile</label>
                                                            <input type="text" name="ogpl-sec-driver-mobile" value="" class="form-control capitalize" id="ogpl-sec-driver-mobile" placeholder="Driver Mobile" maxlength="10">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel panel-default">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="alert" id="ogpl-action-state" style="display: none"></div>
                                                </div>
                                                <div class="col-md-12 text-right">
                                                    <input type="hidden" id="hid-ogpl-code" />
                                                    <input type="hidden" id="hid-driver-code" />
                                                    <input type="hidden" id="hid-driver2-code" />
                                                    <input type="hidden" id="hid-supervisor-code" />
                                                    {if $smarty.request.transitCode == ''}
                                                        <button class="btn btn-primary" id="empty-transit-btn" type="button" onclick="proceedOGPL('TRANSFER_LOAD')">Transfer Load</button>
                                                        <button class="btn btn-primary empty-load-btn" id="empty-transit-btn" type="button" onclick="proceedOGPL('EMPTY_LOAD')">Empty Load</button>
                                                    {/if}
                                                    <button class="btn btn-primary empty-and-load-btn"  type="button" onclick="proceedOGPL('EMPTY_LOAD','LOAD')">Empty And Load</button>
                                                    <button class="btn btn-success" type="button" id="proceed-transit-btn" onclick="proceedOGPL();">Next</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!--add ogpl container end-->
                        </div>
                    </div>

                    <div class="row" id="edit-ogpl-list-container" style="display: none;">
                        <br>
                        <div class="col-lg-6">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="edit-ogpl-list">
                                        <div class="row">
                                            <div class="col-md-5">
                                                <span class="box-outline-light" id="edit-ogpl-date"></span><br>
                                                <span class="regno-font" id="edit-ogpl-vehicle"></span><br>
                                                <span class="f-16" id="edit-ogpl-from"></span> - <span class="f-16" id="edit-ogpl-to"></span>
                                            </div>
                                            <div class="col-md-7" style="line-height: 25px;">
                                                <b>Route : </b> <span id="edit-ogpl-sub-from"></span>&nbsp;&nbsp;<b>-</b>&nbsp;&nbsp;<span id="edit-ogpl-sub-to"></span><br>
                                                <b><i class="fa fa-home" aria-hidden="true" style="font-size: 16px;"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><span id="edit-ogpl-branch-from"></span> &nbsp;&nbsp;<b>-</b>&nbsp;&nbsp;<span id="edit-ogpl-branch-to"></span><br>
                                                <b>Driver :</b> <span id="edit-ogpl-driver"></span> &nbsp;&nbsp;<b>Driver 2 :</b> <span id="edit-ogpl-driver2"></span><br>
                                                <b>Supervisor :</b> <span id="edit-ogpl-supervisor"></span><br>
                                                <b>Via :</b> <span id="edit-ogpl-via"></span><br>
                                                <span id="edit-ogpl-via-zone-hide"><b>Via Zone :</b> <span id="edit-ogpl-via-zone"></span><br></span>
                                                <span id="edit-link-load-via-hide"><b>{lang('hub')} Load Via :</b> <span id="edit-link-load-via"></span><br></span>
                                                <span id="edit-link-load-via-zone-hide"><b>{lang('hub')} Load Via Zone :</b> <span id="edit-link-load-via-zone"></span><br></span>
                                                {* <b>Local Transit Via :</b> <span id="edit-local-transit-via"></span> *}
                                                <span id="edit-local-hide-branch-via"><b>Local Transit Via :</b> <span id="edit-local-via-branches"></span><br></span>
                                                <span id="edit-out-for-delivery-hide-branch"><b>Out For Delivery :</b> <span id="edit-out-for-delivery-branch"></span><br></span>
                                                <span id="edit-hide-remarks"> <b>Remarks :</b> <span id="edit-load-remarks"></span></span>
                                            </div>
                                            <div class="col-md-12">
                                                <span class="badge m-t-5 hide" id="loading-until-badge"></span>&emsp;
                                                <a href="javascript:;" class="btn pull-right bold" onclick="editOGPL();"><i class="fa fa-pencil"></i> Edit</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!--edit ogpl list container end-->
                   
                    {assign var="isTransitModel" value=[]}
                        {* {$action_rights['TRANSIT-DIRECT-LOAD'] = 0}  *}
                    {if $action_rights['TRANSIT-DIRECT-LOAD'] == 1}
                        {$isTransitModel[]='TRANSIT-DIRECT-LOAD'}
                    {/if}
                    {if $action_rights['TRANSIT-LINK-LOAD'] == 1}
                        {$isTransitModel[]='TRANSIT-LINK-LOAD'}
                    {/if}
                    {if $action_rights['TRANSIT-LOCAL-LOAD'] == 1}
                        {$isTransitModel[]='TRANSIT-LOCAL-LOAD'}
                    {/if}
                    {if $action_rights['TRANSIT-OUT-FOR-DELIVERY'] == 1}
                        {$isTransitModel[]='TRANSIT-OUT-FOR-DELIVERY'}
                    {/if}

                    {assign var="gridClass" value=''}
                    {if $isTransitModel == 1}
                        {$gridClass = 'col-lg-6 col-md-offset-3'} 
                    {elseif $isTransitModel == 2 }
                        {$gridClass = 'col-lg-5 col-lg-offset-1 col-md-6 col-md-offset-3'}
                    {elseif $isTransitModel == 3}
                        {$gridClass = 'col-lg-4 col-lg-offset-2 col-md-6 col-md-offset-3'} 
                    {else}
                        {$gridClass = 'col-lg-3'} 
                    {/if}

                    <div class="row hidden" id="add-ogpl-list-container">
                        <br>
                        {* Direct Load *}
                        {if $action_rights['TRANSIT-DIRECT-LOAD'] == 1}
                        <div class="{if !$cargo_setting->transitMode[4]}col-lg-4{else}col-lg-3{/if}">
                            <div class="panel panel-default">
                                <div class="panel-body p-5">
                                    <h4 class="transit-title">Direct Load</h4>
                                </div>
                            </div>

                            <div class="row mt-10 d-flex">
                                <div class="col-lg-8 pr-5">
                                    <div class="panel panel-default">
                                        <div class="heading_b bold">Direct Loaded</div>
                                        <div class="panel-body p-0">
                                            <h3 class="transit-direct-loaded transit-title">0</h3>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 pl-0">
                                    <button class="btn btn-success btn-cover load-font" id="direct-load-btn" onclick="loadDirectLoadLrsDialog();" disabled>LOAD</button>
                                </div>
                            </div>

                            <br>
                            <h5 class="bold">Direct Load Summary</h5>
                            <div class="panel panel-default">
                                <div class="panel-body p-0">
                                    <table class="table table-bordered mb-0">
                                        <thead>
                                            <tr class="success">
                                                <th>To Branch</th>
                                                <th>Article</th>
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody id="transit-direct-load-lrs"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        {/if}

                        {* Link Load *}
                        {if $action_rights['TRANSIT-LINK-LOAD'] == 1}
                        <div class="{if !$cargo_setting->transitMode[4]}col-lg-4{else}col-lg-3{/if}">
                            <div class="panel panel-default">
                                <div class="panel-body p-5">
                                    <h4 class="transit-title">{lang('hub')} Load</h4>
                                </div>
                            </div>

                            <div class="row mt-10 d-flex">
                                <div class="col-lg-8 pr-5">
                                    <div class="panel panel-default">
                                        <div class="heading_b bold">{lang('hub')} Loaded</div>
                                        <div class="panel-body p-0">
                                            <h3 class="transit-link-loaded transit-title">0</h3>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 pl-0">
                                    <button class="btn btn-success btn-cover load-font" id="link-load-btn" onclick="loadLinkLoadLrsDialog();" disabled>LOAD</button>
                                </div>
                            </div>

                            <br>
                            <h5 class="bold">{lang('hub')} Load Summary</h5>
                            <div class="panel panel-default">
                                <div class="panel-body p-0">
                                    <table class="table table-bordered mb-0">
                                        <thead>
                                            <tr class="success">
                                                <th>To Branch</th>
                                                <th>Article</th>
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody id="transit-link-load-lrs"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        {/if}

                        {* Local Transit *}
                        {if $action_rights['TRANSIT-LOCAL-LOAD'] == 1}
                        <div class="{if !$cargo_setting->transitMode[4]}col-lg-4{else}col-lg-3{/if}">
                            <div class="panel panel-default">
                                <div class="panel-body p-5">
                                    <h4 class="transit-title">Local Transit</h4>
                                </div>
                            </div>

                            <div class="row mt-10 d-flex">
                                <div class="col-lg-8 pr-5">
                                    <div class="panel panel-default">
                                        <div class="heading_b bold">Local Loaded</div>
                                        <div class="panel-body p-0">
                                            <h3 class="transit-local-transit-loaded transit-title">0</h3>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 pl-0">
                                    <button class="btn btn-success btn-cover load-font" id="local-load-btn" onclick="loadLocalTransitLrsDialog();" disabled>LOAD</button>
                                </div>
                            </div>
                            
                            <br>
                            <h5 class="bold">Local Load Summary</h5>
                            <div class="panel panel-default">
                                <div class="panel-body p-0">
                                    <table class="table table-bordered mb-0">
                                        <thead>
                                            <tr class="success">
                                                <th>To Branch</th>
                                                <th>Article</th>
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody id="transit-local-transit-lrs"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        {/if}

                       
                        {* Out For delivery *}
                        {if $action_rights['TRANSIT-OUT-FOR-DELIVERY'] == 1}
                            {if $cargo_setting->transitMode[4]}
                                <div class="col-lg-3">
                                    <div class="panel panel-default">
                                        <div class="panel-body p-5">
                                            <h4 class="transit-title">Out For Delivery</h4>
                                        </div>
                                    </div>

                                    <div class="row mt-10 d-flex">
                                        <div class="col-lg-8 pr-5">
                                            <div class="panel panel-default">
                                                <div class="heading_b bold">Loaded Delivery</div>
                                                <div class="panel-body p-0">
                                                    <h3 class="transit-out-for-delivery-loaded transit-title">0</h3>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 pl-0">
                                            <button class="btn btn-success btn-cover load-font" id="out-for-delivery-load-btn" onclick="outForDeliveryLrsDialog();" disabled>LOAD</button>
                                        </div>
                                    </div>
                                    
                                    <br>
                                    <h5 class="bold">Delivery Load Summary</h5>
                                    <div class="panel panel-default">
                                        <div class="panel-body p-0">
                                            <table class="table table-bordered mb-0">
                                                <thead>
                                                    <tr class="success">
                                                        <th>To Branch</th>
                                                        <th>Article</th>
                                                        <th>Total</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="transit-out-for-delivery-lrs"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                        {/if}
                        
                        <div class="col-lg-12 mt-10">
                            <div class="panel panel-default">
                                <div class="panel-body p-5">
                                    <div class="row">
                                        <div class="col-lg-6" style="font-size: 20px;">
                                            <span>Total Loaded : </span> <span class="bold" id="total-loaded-lrs">0</span>  <span title="Splited LR List"><span>
                                        </div>
                                        <div class="col-lg-6 text-right">
                                            <div class="alert pull-left" id="save-transitv3-action-state" style="display: none;width: 60%;text-align:left;"></div>

                                            {* setting based strip start module *}
                                            {if $cargo_setting->transitOdometerModelCode == "ORGDTN"}  
                                                {if $ogpl->fromStation->code == $login_station }
                                                <button class="btn btn-warning {if !$ogpl || (isset($odoDetails) && $odoDetails->startOdometer > 0) || (!$odoDetails && $show_end_odo == 0)}hide{/if}" id="start-transit-btn" type="button" onclick="showStartTripDialog(true);">Start Trip</button>
                                               {else}
                                                   {if $odoDetails->fromOdometerRange > 0}
                                                       <button class="btn btn-warning {if !$ogpl || (isset($odoDetails) && $odoDetails->startOdometer > 0) || (!$odoDetails && $show_end_odo == 0) }hide{/if}" id="start-transit-btn" type="button" onclick="showStartTripDialog(true);">Start Trip</button>
                                                   {/if}
                                               {/if}
                                            {else}
                                                {if isset($odoDetails) &&  $odoDetails->endOdometer == 0 && $ogpl->fromOrganization->code != $login_branch}
                                                    {if $OrginOdoDetails->startOdometer > 0 }
                                                        <button class="btn btn-danger" id="end-transit-btn" type="button" onclick="makeEndTrip('{$ogpl->code}','{$ogpl->busVehicle->code}','{$ogpl->toOrganization->code}');">End Trip</button>
                                                    {/if}
                                                {else}
                                                  <button class="btn btn-warning {if !$ogpl || (isset($odoDetails) && $odoDetails->startOdometer > 0) || (!$odoDetails && $show_end_odo == 0)}hide{/if}" id="start-transit-btn" type="button" onclick="showStartTripDialog(true);">Start Trip</button>
                                                {/if}
                                            {/if}
                                            


                                            <button class="btn btn-secondary hide" type="button" id="transit-unload-lr-btn" onclick="showLoadedLrDialog();">Loaded Lrs</button>
                                            {if $smarty.request.transitCode != ''}
                                                <a class="tab-link" href="#cargo/ogpl-chart-details?transitCode={$smarty.request.transitCode}&date=" title="View Chart" target="_blank" onclick="return checkOdoUpdation();"><button class="btn btn-secondary hide" type="button" id="view-chart-btn" style="color: #000;">View Chart</button></a>
                                            {/if}
                                            <button class="btn btn-primary hide" type="button" id="transit-complete-btn" onclick="saveTransitV3('post');">Save</button>
                                            {if $action_rights['LR-SPLTUP']==1}
                                                <button class="btn btn-primary none" type="button" id="transit-split-btn" onclick="splitLRs();">Save <span class="split-counts badge badge-sm badge-danger"></span></button>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!--add ogpl list container end-->
                </div><!--content end-->
            </div><!--row end-->
        </div>
    </div>
</div>

{* direct load lr *}
<div id='direct-load-load-lr-dialog' style="background-color: #fff;" class="hide noprint dialog-content-page">
    <div class="">
        <div class="text-center bold" style="font-size: 25px;"> 
            Direct Load LR
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="direct-load-load-alphabet-content"></div>
        </div>
    </div>
    <div id="direct-load-load-lr-content" style="max-height: 510px; overflow-y: scroll;"></div>
    <div class="clearfix">&nbsp;</div>
    <div class="row">
        <div class="col-md-12">
            <div class="alert pull-left" id="transitv3-direct-load-action-state" style="display: none"></div>
            <div class="pull-right"> 
                <a href="javascript:;" class="btn btn-success load-lr-btn" onclick="loadDirectLoadLr()"> Load</a>
            </div>
            <div  class="pull-right">
                <button id="scrollToTopButtonDirect"><i class="fa fa-chevron-up"></i></button>
            </div>
        </div>
    </div>
</div>

{* link/hub load lr *}  
<div id='link-load-load-lr-dialog' style="background-color: #fff;" class="hide noprint dialog-content-page">
    <div class="">
        <div class="text-center bold" style="font-size: 25px;"> 
        {lang('hub')} Load LR
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="link-load-load-alphabet-content"></div>
        </div>
    </div>
    <div id="link-load-load-lr-content" style="max-height: 510px; overflow-y: scroll;"></div>
    <div class="clearfix">&nbsp;</div>
    <div class="row">
        <div class="col-md-12">
            <div class="alert pull-left" id="transitv3-link-load-action-state" style="display: none"></div>
            <div class="pull-right"> 
                <a href="javascript:;" class="btn btn-success" onclick="loadLinkLoadLr()"> Load</a>
            </div>
            <div  class="pull-right">
                <button id="scrollToTopButtonLink"><i class="fa fa-chevron-up"></i></button>
            </div>
        </div>
    </div>
</div>

{* local transit load lr *}
<div id='local-transit-load-lr-dialog' style="background-color: #fff;" class="hide noprint dialog-content-page">
    <div class="">
        <div class="text-center bold" style="font-size: 25px;"> 
            Local Load LR
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="local-transit-load-alphabet-content"></div>
        </div>
    </div>
    <div id="local-transit-load-lr-content" style="max-height: 510px; overflow-y: scroll;"></div>
    <div class="clearfix">&nbsp;</div>
    <div class="row">
        <div class="col-md-12">
            <div class="alert pull-left" id="transitv3-local-transit-action-state" style="display: none"></div>
            <div class="pull-right"> 
                <a href="javascript:;" class="btn btn-success" onclick="loadLocalTransitLr()"> Load</a>
            </div>
            <div  class="pull-right">
                <button id="scrollToTopButtonLocal"><i class="fa fa-chevron-up"></i></button>
            </div>
        </div>
    </div>
</div>

{* out for delivery load lr *}
<div id='out-for-delivery-load-lr-dialog' style="background-color: #fff;" class="hide noprint dialog-content-page">
    <div class="">
        <div class="text-center bold" style="font-size: 25px;"> 
            Out for Delivery Load LR
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">    
            <div id="out-for-delivery-load-alphabet-content"></div>
        </div>
    </div>
    <div id="out-for-delivery-load-lr-content" style="max-height: 510px; overflow-y: scroll;"></div>
    <div class="clearfix">&nbsp;</div>
    <div class="row">
        <div class="col-md-12">
            <div class="alert pull-left" id="transitv3-out-for-delivery-action-state" style="display: none"></div>
            <div class="pull-right"> 
                <a href="javascript:;" class="btn btn-success" onclick="loadOutForDeliveryTransitLr()"> Load</a>
            </div>
            <div  class="pull-right">
                <button id="scrollToTopButtonOfd"><i class="fa fa-chevron-up"></i></button>
            </div>
        </div>
    </div>
</div>

{* remove loaded lr *}
<div id='transitv3-loaded-lr-dialog' style="background-color: #fff;" class="hide noprint dialog-content-page">
    <div class="">
        <div class="pull-right"> 
            <a title="close" href="javascript:;" class="btn-lg" onclick="closeLoadedLrDialog()"> <i class="fa fa-times-circle fa-lg"></i> </a>
        </div>
        <div class="pull-left bold" style="font-size: 25px;"> 
            Loaded Lr
        </div>
    </div>
    <div class="clearfix">&nbsp;</div>
    <div class="row">
        <div class="col-md-12">
            <div class="pull-left">
                <h5><b>Transactions</b></h5>
            </div>
            <div class="pull-right"> 
                <a href="javascript:;" class="btn btn-danger" onclick="unloadTransitV3Lr()"> Remove</a>
            </div>
        </div>
    </div>
    <div id="transitv3-loaded-lr-content" style="max-height: 500px;overflow-y: scroll;"></div>
    <div class="clearfix">&nbsp;</div>
    <div class="row">
        <div class="col-md-12">
            <div class="alert pull-left" id="transitv3-loaded-lr-action-state" style="display: none"></div>
            <div class="pull-right"> 
                <a href="javascript:;" class="btn btn-danger" onclick="unloadTransitV3Lr()"> Remove</a>
            </div>
        </div>
    </div>
</div>

{* start trip *}
<div id="start-trip-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideStartTripDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="start-trip-panel" class="clearfix" style="padding: 10px 5px;max-height: 600px;overflow-x: hidden;overflow-y: auto;">
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
                        {if  $namespace === "seenutransports" && isset($ownershipTypeing['OWN'])}
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
                        {elseif  $namespace === "seenutransports" && isset($ownershipTypeing['HIRE'])}
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
                        {elseif  $namespace === "seenutransports" && isset($ownershipTypeing['ATCH'])}
                            
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
                                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
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
                                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
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
                                        <input type="text" class="form-control" placeholder="Remarks" id="start-trip-adv-cheque-remarks" data-mask="englishonly"/>
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
                    <button type="submit" class="btn btn-warning col-md-3" id="start-trip-btn" onclick="startTransitV3Trip();" style="float: none;">Start Trip</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script id="vehicle-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-7">
            <b class="vehicle-name"></b><br>
            <span class="vehicle-ownership small" title="Ownership Type"></span>
            <span class="text-muted small" title="Vehicle Type">(<span class="vehicle-type"></span>)</span>
        </div>
        <div class="col-xs-5 text-right nowrap">
            <span class="vehicle-transit-status" title="Vehicle Transit Status"></span><br>
            <span class="vehicle-location small" title="Vehicle Available At"></span>
        </div>
    </div>
</script>


{* splitLr popup container start *}
<div class="panel panel-default popup-split none">
    <div class="panel-body">
        <div class="pop-close pop-close-splitup">
            <h3>Transit Partial LRs </h3>
            <div>
             <a title="close" href="javascript:;" class="btn-lg" onclick="closeSplitPop();"> <i class="fa fa-times-circle fa-lg"></i> </a>
            </div>
        </div>

        <div class="mt-2 direct-lr-section lr-card">
            <div class="lr-card-header">Direct Load LR</div>
                <div class="list-group list-group-flush directLoadList">
               
            </div>
        </div>
        <div class="mt-2 link-lr-section lr-card" style="margin-top: 10px;">
            <div class="lr-card-header">{lang('hub')} Load LR</div>
                <div class="list-group list-group-flush linkLoadList">
               
            </div>
        </div>
        <div class="mt-2 local-lr-section lr-card" style="margin-top: 10px;">
            <div class="lr-card-header">Local Load LR</div>
                <div class="list-group list-group-flush localLoadList">
               
            </div>
        </div>

    </div>
    <div class="panel-footer split-panel-footer">
         <div class="alert alert-danger pull-left" id="errorSaveMsg" style="display: none;width: 60%;text-align:left;"></div>
          <button class="split-all pull-right btn btn-sm btn-primary" onclick="splitAllPartitians()">Save</button>
    </div>
</div>
{* splitLr popup container end *}

{* <script id="driver-supervisor-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-7">
            <b class="name"></b>
        </div>
        <div class="col-xs-5 text-right nowrap">
            <span class="mobile" title="Mobile Number"></span>
        </div>
    </div>
</script> *}

<style>
    .ogpl-via-stations .select2-choices,
    .ogpl-via-zones .select2-choices,
    .link-load-stations .select2-choices,
    .local-transit-stations .select2-choices,
    .local-via-branches .select2-choices {
        height: 68px!important;
    }
    
    .select2-chosen .vehicle-transit-status {
        visibility: hidden;
    }

    #local-transit-load-alphabet-content a {
        text-decoration: none;
    }

    .box-button {
        display: inline-block;
        padding: 9px 15px;
        background-color: #fff;
        color: #000;
        border: 1px solid #000;
        text-decoration: none;
        margin: 4px;
        border-radius: 5px;
        cursor: pointer;
    }
    .body-no-scroll{
        overflow: hidden;
    }
    
    #new-lr-table thead {
        position: sticky;
        top: 0;
        z-index: 1; 
    }

    #scrollToTopButtonDirect, #scrollToTopButtonLink,
    #scrollToTopButtonLocal, #scrollToTopButtonOfd {
        padding: 6px 9px;
        border-radius: 4px;
        margin-right: 5px;
    }
</style>

<script>
    var transitOgplcode='{$smarty.request.transitCode}';
    var fromOrg =$('#ogpl-from-branch').val();
    var toOrg =$('#ogpl-to-branch').val();
    var localLoad='{$smarty.request.INTRNT}';
    var directLoad='{$smarty.request.TRNT}';
    var OGPLEdit = {$ogpl|json_encode};
    var OGPLFormData = {};
    var OGPLTemplates = {$ogpltpl|json_encode};
    var OGPLVehicles = {$vehicles|json_encode};
    var driversData = {$drivers|json_encode};
    var supervisorData = {$branchContact|json_encode};
    var drivers = {$drivers|json_encode};
    var OGPLtpl = {$ogpltpl|json_encode};
    var user_login_station = {$login_station|json_encode};
    var user_login_station_name = {$login_station_name|json_encode};
    var user_login_branch = {$login_branch|json_encode};
    var login_user = {$login_user|json_encode};
    var linkVehicleCode = {$linkVehicleCode|json_encode};
    var linkTransitType = {$linkTransitType|json_encode};
    var zoneData = {$zone|json_encode};
    var odoDetails = {$odoDetails|json_encode};
    var cargoSetting = {$cargo_setting|json_encode};
    var $viaStations = $('#ogpl-via option');
    var $hubLoadStations = $('#link-load-stations option');
    var $localTransitStations = $('#local-transit-stations option');
    var $hubLoadZones = $('#link-load-zones option');
    var bankNamesList = {$bank_names_list|json_encode};
    var localTransitSearchData = {$localTransitSearchData|json_encode};
    var branches = {$branches|json_encode};
    var cargo_additional = '{$cargo_additional|json_encode}';
    var action_rights = '{$action_rights|json_encode}';
    action_rights = JSON.parse(action_rights);
    const  linkLocalOfd = localTransitSearchData;
    var emptyLoadOtfd = false;

    var startOdoUpdated = odoDetails != null && odoDetails.startOdometer != null ? odoDetails.startOdometer : 0;

    // splitlr data initialisation
    var gatheredData = [];
    var gatheredDataLink  = [];
    var gatheredDataLocal =[];
    
    var globalLrDetails = [];
    var globalLrLinkDetails = [];
    var globalLrLocalDetails = [];
    var totalSplitLrs = [];
    var splittedLRList = [];

    function checkOdoUpdation(){
        console.log(cargoSetting.transitOdometerModelCode);
        if(cargoSetting.transitOdometerModelCode != "NA"){
            if(startOdoUpdated === 0){
            showStartTripDialog(true);
            return false;
            }else{
                true;
            }
        }
    }
    function makeEndTrip(code,vehicleCode,toOrganizationCode){
        var params = {};
        params.transitCode = code;
        params.vehicleCode = vehicleCode;
        params.toOrganizationCode = toOrganizationCode;
        showEndTripDialog(params, function (e) {
            if (e.data && e.data.success == 1) {
               window.location.reload();
            }
        });
    }

    {literal}        
        $(document).ready(function() {
            var driverItem = function(ul, item) {
                return $('<li class="ui-menu-item">')
                    .append('<a><b>' + item.name + ' ' + (item.lastName || '') + '</b><br/><span class="text-muted"><small>' + (item.mobileNumber || '') + '</small><small class="pull-right">' + (item.ownershipType.name || '') + '</small></span></a>')
                    .appendTo(ul);
            }

            var supervisorItem = function(ul, item) {
                return $('<li class="ui-menu-item">')
                    .append('<a><b>' + item.name + ' ' + (item.aliasCode || '') + '</b><br/><span class="text-muted"><small>' + (item.mobile.substring(0,10) || '') + '</small></span></a>')
                    .appendTo(ul);
            }

            var filterDriverSource = function (request, response) {
                var query = request.term.toLowerCase();

                var vehicleCode = $('#ogpl-search-vehicle').val()
                var vehicle = _.find(OGPLVehicles, o => o.code == vehicleCode);
                var ownershipTypeCode = vehicle ? vehicle.ownershipType.code : '';

                var driverSource = [];
                $.each(drivers || [], function (i, driver) {
                    var term = [driver.name + ' ' + driver.lastName, driver.mobileNumber].join(' ').toLowerCase();
                    if (driver.ownershipType.code == ownershipTypeCode && term.search(query) >= 0) {
                        driverSource.push(driver)
                    }
                });
                
                response(driverSource);
            }

            var filterSupervisorSource = function (request, response) {
                var query = request.term.toLowerCase();

                var supervisorSource = [];
                $.each(supervisorData || [], function (i, spv) {
                    var term = [spv.name, spv.aliasCode, spv.mobile].join(' ').toLowerCase();
                    if (term.search(query) >= 0) {
                        supervisorSource.push(spv)
                    }
                });

                response(supervisorSource);
            }

            $('#ogpl-date').datepicker({
                format: 'dd-mm-yyyy',
                autoclose: true,
                changeMonth: false,
                todayHighlight: true,
                startDate: '-2d',
                endDate: '0'
            }).on('show', function () {
                if (!menu_permission['OGPL-PREV-DATE']) {
                    $(this).datepicker('hide');
                }
            });

            $('#ogpl-supervisor-mobile, #ogpl-prim-driver-mobile, #ogpl-sec-driver-mobile').on('input', function() {
                this.value = this.value.replace(/\D/g, '');
            });

            $('.bsn_switch').bootstrapSwitch();
            $('#ogpl-tpl').select2();
            $('#ogpl-from').select2();
            $('#ogpl-to').select2();
            $('#ogpl-from-branch').select2();
            $('#ogpl-to-branch').select2();
            $('#start-trip-supervisor').select2();
            $('#start-trip-adv-paymode').select2();
            $('#start-trip-adv-payby').select2();
            $('#start-trip-fuel-vendor').select2();

            $('#ogpl-via').select2({
                placeholder: 'Select Via Stations',
                closeOnSelect: false
            }).on('change', function (e) {
                // $(e.target).select2('search', '');
            });

            $('#ogpl-via-zones').select2({
                placeholder: 'Select Via Zones',
                closeOnSelect: false
            }).on('change', function (e) {
                // $(e.target).select2('search', '');
            });

            $('#link-load-stations').select2({
                placeholder: 'Select Link Load Stations',
                closeOnSelect: false
            }).on('change', function (e) {
                // $(e.target).select2('search', '');
            });

            $('#link-load-zones').select2({
                placeholder: 'Select Link Load Zones',
                closeOnSelect: false
            }).on('change', function (e) {
                // $(e.target).select2('search', '');
            });

            $('#local-via-branches').select2({
                placeholder: 'Select Local Transit Station',
                closeOnSelect: false
            }).on('change', function (e) {
                // $(e.target).select2('search', '');
            });

            $('#ogpl-prim-driver-name, #ogpl-prim-driver-mobile').autocomplete({
                minLength: 0,
                source: filterDriverSource,
                select: function (event, ui) {
                    $('#ogpl-prim-driver-mobile').val(ui.item.mobileNumber);
                    $('#ogpl-prim-driver-name').val(ui.item.name);
                    $('#hid-driver-code').val(ui.item.code);
                    return false;
                }
            }).on('change', function () {
                $('#hid-driver-code').val('');
            });

            $('#ogpl-sec-driver-name, #ogpl-sec-driver-mobile').autocomplete({
                minLength: 0,
                source: filterDriverSource,
                select: function (event, ui) {
                    $('#ogpl-sec-driver-mobile').val(ui.item.mobileNumber);
                    $('#ogpl-sec-driver-name').val(ui.item.name);
                    $('#hid-driver2-code').val(ui.item.code);

                    return false; 
                }
            }).on('change', function () {
                $('#hid-driver2-code').val('');
            });

            $('#ogpl-supervisor-name, #ogpl-supervisor-mobile').autocomplete({
                minLength: 0,
                source: filterSupervisorSource,
                select: function (event, ui) {
                    $('#ogpl-supervisor-mobile').val(ui.item.mobile.substring(0, 10));
                    $('#ogpl-supervisor-name').val(ui.item.name);
                    $('#hid-supervisor-code').val(ui.item.code);

                    return false; 
                }
            }).on('change', function () {
                $('#hid-supervisor-code').val('');
            });

            $('#ogpl-prim-driver-name, #ogpl-prim-driver-mobile, #ogpl-sec-driver-name, #ogpl-sec-driver-mobile').each(function () {
                $(this).data('uiAutocomplete')._renderItem = driverItem
            }).on('focus', function () {
                $(this).autocomplete('search', this.value || '');
            });

            $('#ogpl-supervisor-name, #ogpl-supervisor-mobile').each(function () {
                $(this).data('uiAutocomplete')._renderItem = supervisorItem
            }).on('focus', function () {
                $(this).autocomplete('search', this.value || '');
            });

            var OGPLVehicleSource = [];
            $.each(OGPLVehicles || [], function(i, row) {
                if (row.activeFlag == 1) {
                    OGPLVehicleSource.push({
                        label: row.registationNumber + ' - ' + row.vehicleType.name,
                        value: row.registationNumber,
                        code: row.code
                    });
                }
            });

            $('#start-trip-adv-cheque-date').datepicker({
                todayHighlight: true,
                format: 'dd-mm-yyyy',
                autoclose: true
            });
            $('#start-trip-adv-netbanking-bankname').autocomplete({
                minLength: 0,
                source: bankNamesList,
                appendTo: '#start-trip-adv-netbanking-bankname-div'
            }).focus(function(){
                $(this).autocomplete('search', '');
            });

            $('#start-trip-adv-cheque-bankname').autocomplete({
                minLength: 0,
                source: bankNamesList,
                appendTo: '#start-trip-adv-cheque-bankname-div'
            }).focus(function(){
                $(this).autocomplete('search', '');
            });

            $('#transit-type').on('change', function() {
                var transitType = [];
                $('input[name=transit-type]:checked').each(function(){
                    transitType.push($(this).val());
                });
                $('#empty-transit-btn').removeClass('hide');
                $('#proceed-transit-btn').removeClass('hide');
                if (transitType.length == 0) {
                    $('#empty-transit-btn').addClass('hide');
                    $('#proceed-transit-btn').addClass('hide');
                }
                
                $('#add-ogpl-container input:not(:hidden, #ogpl-date), #add-ogpl-container select').each(function(k, ele) {
                    $(ele).prop('disabled', false);
                    if (transitType.length > 0) {
                        if ($.inArray('TRNT', transitType) == -1) {
                            $('.TRNT-field').prop('disabled', true);
                        }

                        if ($.inArray('INTRNT', transitType) == -1) {
                            $('.INTRNT-field').prop('disabled', true);
                        }

                        if ($.inArray('HBTRNT', transitType) == -1) {
                            $('.HBTRNT-field').prop('disabled', true);
                        }

                        if (transitType.length == 1 && transitType[0] === 'OTFD') {
                            $('.OTFD-field').prop('disabled', true);
                        } else {
                            $('.OTFD-field').prop('disabled', false);
                        }
                    } else {
                        $(ele).prop('disabled', true);
                    }
                });
            });

            if (isNotNull(OGPLEdit)) {
                fillOgplEdit(OGPLEdit);
            }
            $('#transit-type').trigger('change');

            $("#scrollToTopButtonDirect").on("click", function (e) {
                var $dialogScrollContainer = $('#direct-load-load-lr-content');
                var $targetElement = $("#new-lr-table");
                if ($targetElement.length > 0) {
                    $dialogScrollContainer.animate({
                        scrollTop: 0,
                        behavior: "smooth"
                    }, 500);
                }
            });
            $("#scrollToTopButtonLink").on("click", function (e) {
                var $dialogScrollContainer = $('#link-load-load-lr-content');
                var $targetElement = $("#new-lr-table");
                if ($targetElement.length > 0) {
                    $dialogScrollContainer.animate({
                        scrollTop: 0,
                        behavior: "smooth"
                    }, 500);
                }
            });
            $("#scrollToTopButtonLocal").on("click", function (e) {
                var $dialogScrollContainer = $('#local-transit-load-lr-content');
                var $targetElement = $("#new-lr-table");
                if ($targetElement.length > 0) {
                    $dialogScrollContainer.animate({
                        scrollTop: 0,
                        behavior: "smooth"
                    }, 500);
                }
            });
            $("#scrollToTopButtonOfd").on("click", function (e) {
                var $dialogScrollContainer = $('#out-for-delivery-load-lr-content');
                var $targetElement = $("#new-lr-table");
                if ($targetElement.length > 0) {
                    $dialogScrollContainer.animate({
                        scrollTop: 0,
                        behavior: "smooth"
                    }, 500);
                }
            });
        });
        function setLocalTransitStations() {
            var from_station = $('#ogpl-from').val();
            var via_station = $('#ogpl-via').val() || [];
            via_station.push(from_station);

            $('#local-transit-stations').html(function () {
                return $localTransitStations.filter(function () {
                    return $.inArray($(this).val(), via_station) != -1;
                });
            }).select2('val', []).trigger('change');
        }

        var ogpl_branch_list_from = $('#ogpl-from-branch option');
        var ogpl_branch_list_to = $('#ogpl-to-branch option');

        function stationfilter1(){
            var ogpl_station_from = $('#ogpl-from option:selected').data('stationcode');
            var ogpl_station_from_arr = ogpl_station_from.split(',');

            $('#ogpl-from-branch').empty();
            $.each(ogpl_branch_list_from, function(index, branch) {
                var branchCode = $(branch).data('brachcode');
                if ($.inArray(branchCode, ogpl_station_from_arr) !== -1 || ($('#ogpl-from').val() == 'NA' && $(branch).val() != 'NA')) {
                    var newOption = $('<option></option>').val($(branch).val()).text($(branch).text());
                    $('#ogpl-from-branch').append(newOption);
                }
            });

            $('#ogpl-from-branch').trigger('change');

            $('.from-org').removeClass('hide');
            if ($('#ogpl-from-branch option:selected').length > 0) {
                $('.from-org').removeClass('hide');
            } else {
                $('.from-org').addClass('hide');
                $('#ogpl-from-branch').val('');
            }

        }

        function stationfilter2() {
            var ogpl_station_to = $('#ogpl-to option:selected').data('stationcode');
            var ogpl_station_to_arr = ogpl_station_to.split(',');
            var userInsideStation = $('#ogpl-to').val() == 'NA';

            $('#ogpl-to-branch').empty();
            $.each(ogpl_branch_list_to, function(index, branch) {
                var branchCode = $(branch).data('brachcode');
                if ($.inArray(branchCode, ogpl_station_to_arr) !== -1 || ($('#ogpl-to').val() == 'NA' && $(branch).val() != 'NA')) {
                    var newOption = $('<option></option>').val($(branch).val()).text($(branch).text());
                    $('#ogpl-to-branch').append(newOption);
                }
            });

            $('#ogpl-to-branch').trigger('change');
        
            $('.to-org').removeClass('hide');
            if ($('#ogpl-to-branch option:selected').length > 0) {
                $('.to-org').removeClass('hide');
            } else {
                $('.to-org').addClass('hide');
                $('#ogpl-to-branch').val('');
            }
        }

        function setViaStations() {
            if ($('#ogpl-via-zones').val() == null) {
                $('#ogpl-via').val('').trigger('change');
                return;
            }
            var code = $('#ogpl-via-zones').val() || [];
            var stations = [];
            $.each(code, function(k, val) {
                var zone = _.find(zoneData, o => o.code == val);
                $.each(zone.stations || [], function(key, stn) {
                    stations.push(stn.code);
                });
            });

            $('#ogpl-via').val(stations).trigger('change');
        }

        function setLinkLoadStations() {
            if ($('#link-load-zones').val() == null) {
                $('#link-load-stations').val('').trigger('change');
                return;
            }
            var code = $('#link-load-zones').val() || [];
            var stations = [];
            $.each(code, function(k, val) {
                var zone = _.find(zoneData, o => o.code == val);
                $.each(zone.stations || [], function(key, stn) {
                    stations.push(stn.code);
                });
            });

            $('#link-load-stations').val(stations).trigger('change');
        }

        function openDialog() {
            $("body").addClass("body-no-scroll");
        }

        function closeDialog() {
            $("body").removeClass("body-no-scroll");
        }

        var directLoadCount = 0;
        var linkLoadCount = 0;
        var localTransitCount = 0;
        var outForDeliveryTransitCount = 0;
        
        var directLoadLoadedLrs = [];
        var linkLoadLoadedLrs = [];
        var localTransitLoadedLrs = [];
        var outForDeliveryLoadedLrs = [];

        function fillOgplEdit(OGPLEdit) {
            $('#hid-ogpl-code').val(OGPLEdit.code);
            $('#ogpl-name').val(OGPLEdit.name);
            $('#ogpl-date').val(moment(OGPLEdit.tripDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('#ogpl-odometer').val(OGPLEdit.odometer);
            $('#ogpl-remarks').val(OGPLEdit.remarks);

            $('#ogpl-search-vehicle').val(OGPLEdit.busVehicle.code).trigger('change');

            $('#ogpl-from').val(OGPLEdit.fromStation.code).trigger('change');
            $('#ogpl-to').val(OGPLEdit.toStation.code).trigger('change');
            $('#ogpl-from-branch').val(OGPLEdit.fromOrganization.code).trigger('change');
            $('#ogpl-to-branch').val(OGPLEdit.toOrganization.code).trigger('change');

            // Direct Load
            if (OGPLEdit.viaStations.length > 0) {
                $('#transit-type [name="transit-type"][value="TRNT"]').prop('checked', true).trigger('change');
                $('#transit-type [name="transit-type"][value="TRNT"]').closest('label').addClass('active');

                var viaZones = [];
                $.each(OGPLEdit.viaZones, function(i, val) {
                    viaZones.push(val.code);
                });
                $('#ogpl-via-zones').select2('val', viaZones).trigger('change');

                var viaStations = [];
                $.each(OGPLEdit.viaStations, function(i, val) {
                    viaStations.push(val.code);
                });
                $('#ogpl-via').select2('val', viaStations).trigger('change');

                directLoadCount = 0;
                directLoadLoadedLrs = [];
                $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                    if (val.transitDetailsType.code == 'DFLT') {
                        directLoadCount += (val.loadedCount + val.unLoadedCount);
                        directLoadLoadedLrs = _.union(directLoadLoadedLrs, val.cargoList);
                    }
                });
                $('.transit-direct-loaded').html(`${directLoadCount > 0?directLoadCount:0}`);
            } 

            // Link Load
            if (OGPLEdit.hubViaStations.length > 0) {
                $('#transit-type [name="transit-type"][value="HBTRNT"]').prop('checked', true).trigger('change');
                $('#transit-type [name="transit-type"][value="HBTRNT"]').closest('label').addClass('active');

                var hubViaZones = [];
                $.each(OGPLEdit.hubViaZones, function(i, val) {
                    hubViaZones.push(val.code);
                });
                $('#link-load-zones').select2('val', hubViaZones).trigger('change');

                var hubViaStations = [];
                $.each(OGPLEdit.hubViaStations, function(i, val) {
                    hubViaStations.push(val.code);
                });
                $('#link-load-stations').select2('val', hubViaStations).trigger('change');

                linkLoadCount = 0;
                linkLoadLoadedLrs = [];
                $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                    if (val.transitDetailsType.code == 'HULD') {
                        linkLoadCount += (val.loadedCount + val.unLoadedCount);
                        linkLoadLoadedLrs = _.union(linkLoadLoadedLrs, val.cargoList);
                    }
                });
                // $('.transit-link-loaded').html(linkLoadCount +'-'+ gatherCheckedDataLink().length);
                $('.transit-link-loaded').html(`${linkLoadCount > 0?linkLoadCount:0}`);
            } 
            
            // Local Transit
            if (OGPLEdit.localViaOrganizations.length > 0) {
                $('#transit-type [name="transit-type"][value="INTRNT"]').prop('checked', true).trigger('change');
                $('#transit-type [name="transit-type"][value="INTRNT"]').closest('label').addClass('active');
                
                var localViaOrganizations = [];

                //local current not there then append existing local data into select box
                var uniqueLocalViaOrganizations = Array.from(new Set(OGPLEdit.localViaOrganizations.map(JSON.stringify))).map(JSON.parse);
                OGPLEdit.localViaOrganizations=uniqueLocalViaOrganizations;
                $.each(OGPLEdit.localViaOrganizations, function(i, val) {
                    localViaOrganizations.push(val.code);
                    if ($('#local-via-branches option[value="' + val.code + '"]').length === 0) {
                        $('#local-via-branches').append('<option value="' + val.code + '">' + val.name + '</option>');
                    }
                });

                $('#local-via-branches').select2('val', localViaOrganizations).trigger('change');

                localTransitCount = 0;
                localTransitLoadedLrs = [];
                $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                    if (val.transitDetailsType.code == 'LCLD') {
                        localTransitCount += (val.loadedCount + val.unLoadedCount);
                        localTransitLoadedLrs = _.union(localTransitLoadedLrs, val.cargoList);
                    }
                });
                $('.transit-local-transit-loaded').html(`${localTransitCount > 0?localTransitCount:0}`);
            }

            // out for delivery
            outForDeliveryTransitCount = 0;
            outForDeliveryLoadedLrs = [];
            $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                if (val.transitDetailsType.code == 'OFDLD') {
                    $('#transit-type [name="transit-type"][value="OTFD"]').prop('checked', true).trigger('change');
                    $('#transit-type [name="transit-type"][value="OTFD"]').closest('label').addClass('active');

                    outForDeliveryTransitCount += (val.loadedCount + val.unLoadedCount);
                    outForDeliveryLoadedLrs = _.union(outForDeliveryLoadedLrs, val.cargoList);
                }
            });
            $('.transit-out-for-delivery-loaded').html(outForDeliveryTransitCount);

            $('#ogpl-supervisor-name').val(OGPLEdit.supervisor.name);
            $('#hid-supervisor-code').val(OGPLEdit.supervisor.code);
            $('#ogpl-supervisor-mobile').val(OGPLEdit.supervisor.mobile);
            $('#ogpl-prim-driver-name').val(OGPLEdit.vehicleDriver.name);
            $('#hid-driver-code').val(OGPLEdit.vehicleDriver.code);
            $('#ogpl-prim-driver-mobile').val(OGPLEdit.vehicleDriver.mobileNumber);
            $('#ogpl-sec-driver-name').val(OGPLEdit.secondaryDriver.name);
            $('#hid-driver2-code').val(OGPLEdit.secondaryDriver.code);
            $('#ogpl-sec-driver-mobile').val(OGPLEdit.secondaryDriver.mobileNumber);

            var loadtype;
            if (OGPLEdit.activity.includes('COMPLETE')) {
                loadtype = 'RESTRICT';
                $('#loading-until-badge').html('Loading Closed').addClass('badge-danger').removeClass('hide');
                $('#direct-load-btn, #link-load-btn, #local-load-btn , #out-for-delivery-load-btn').removeAttr('onclick').prop('disabled', true);
            } else {
                var user_organization_found = false;
                $.each(OGPLEdit.transitRoutes || [], function (i, detail) {
                    if (detail.createdAt && detail.organization && detail.organization.code == user_login_branch) {
                        user_organization_found = true;
                        var allowedTill = moment(detail.createdAt).add(5, 'hours');
                        if (moment().isBefore(allowedTill)) {
                            $('#loading-until-badge').html('Loading allowed only for ' + allowedTill.fromNow(true)).addClass('badge-warning').removeClass('hide');
                        } else {
                            loadtype = 'RESTRICT';
                            $('#loading-until-badge').html('Loading Closed').addClass('badge-danger').removeClass('hide');
                        }
                        return false;
                    }
                });

                if (user_organization_found == false) {
                    $.each(OGPLEdit.transitCargoDetails || [], function (i, detail) {
                        if (detail.fromStation && detail.fromStation.code == user_login_station) {
                            var allowedTill = moment(detail.audit.updatedAt).add(5, 'hours');
                            if (moment().isBefore(allowedTill)) {
                                $('#loading-until-badge').html('Loading allowed only for ' + allowedTill.fromNow(true)).addClass('badge-warning').removeClass('hide');
                            } else {
                                loadtype = 'RESTRICT';
                                $('#loading-until-badge').html('Loading Closed').addClass('badge-danger').removeClass('hide');
                            }
                            return false;
                        }
                    });
                }
            }
            
            $('.inp_error').removeClass('inp_error');
            $('#save-transitv3-action-state').removeClass('alert-danger, alert-success').html('').hide();

            $('#edit-ogpl-date').text(moment(OGPLEdit.tripDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));

            $('#edit-ogpl-from').text(OGPLEdit.fromStation.name);
            $('#edit-ogpl-to').text(OGPLEdit.toStation.name);
            $('#edit-ogpl-sub-from').text(OGPLEdit.fromStation.name);
            $('#edit-ogpl-sub-to').text(OGPLEdit.toStation.name);
            $('#edit-ogpl-branch-from').text(OGPLEdit.fromOrganization.name);
            $('#edit-ogpl-branch-to').text(OGPLEdit.toOrganization.name);

            $('#edit-ogpl-vehicle').text(OGPLEdit.busVehicle.registationNumber);
            $('#edit-ogpl-driver').text(OGPLEdit.vehicleDriver.name);
            $('#edit-ogpl-driver2').text(OGPLEdit.secondaryDriver.name || '-');
            $('#edit-ogpl-supervisor').text(OGPLEdit.supervisor.name || '-')

            $('#edit-ogpl-via').text($('#ogpl-via option:selected').map(function() {
                return $(this).text();
            }).get().join(', '));

            $('#edit-ogpl-via-zone').text($('#ogpl-via-zones option:selected').map(function() {
                return $(this).text();
            }).get().join(', '));

            $('#edit-link-load-via').text($('#link-load-stations option:selected').map(function() {
                return $(this).text();
            }).get().join(', '));

            $('#edit-link-load-via-zone').text($('#link-load-zones option:selected').map(function() {
                return $(this).text();
            }).get().join(', '));
            if($('#local-via-branches option:selected').length ==0){
                $('#edit-local-hide-branch-via').addClass('hide');
            }

            $('#edit-local-via-branches').text($('#local-via-branches option:selected').map(function() {
                return $(this).text();
            }).get().join(', '));

            if (OGPLEdit.cargoActivityType.code == 'OTFD') {
                $('#edit-out-for-delivery-branch').text(user_login_station_name);
            }

            $('#ogpl-form-div').hide();
            $('#edit-ogpl-list-container').fadeIn('slow');
            $('#edit-ogpl-search-container').fadeIn('slow');
            $('#add-ogpl-list-container').removeClass('hidden');
            $('#total-loaded-lrs').html(directLoadCount + linkLoadCount + localTransitCount + outForDeliveryTransitCount);
            $('#transit-unload-lr-btn').addClass('hide');
            $('#view-chart-btn').addClass('hide');
            $('#empty-transit-btn').addClass('hide')

            if (isNotNull(OGPLEdit.transitCargoDetails)) {
                var load_count = 0;
                $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                    load_count = load_count + val.cargoList.length;
                });
                if (load_count > 0) {
                    get_transit_loaded_lrs();
                    $('#transit-unload-lr-btn').removeClass('hide');
                    $('#view-chart-btn').removeClass('hide');
                }
            }

            proceedOGPL();
        }

        function setHubLoadStations(ele) {
            var excludeStations = [];
            var fromstation = $('#ogpl-from').val();
            var tostation = $('#ogpl-to').val();
            var viastation = $('#ogpl-via').val();
            
            if (Array.isArray(viastation)) {
                excludeStations = _.union(excludeStations, viastation);
            } 

            if (isNotNull(tostation)) {
                excludeStations.push(tostation);
            }
            if (isNotNull(fromstation)) {
                excludeStations.push(fromstation);
            }

            $('#link-load-stations').html(function () {
                return $hubLoadStations.filter(function () {
                    return $.inArray($(this).val(), excludeStations) == -1;
                });
            });
        }

        function setHubLoadZones(ele) {
            var excludeZones = [];
            var viaZones = $('#ogpl-via-zones').val();
            
            if (Array.isArray(viaZones)) {
                excludeZones = _.union(excludeZones, viaZones);
            }

            $('#link-load-zones').html(function () {
                return $hubLoadZones.filter(function () {
                    return $.inArray($(this).val(), excludeZones) == -1;
                });
            });
        }

        function setViaLoadStations(ele) {
            var excludeStations = [];
            var hubstation = $('#link-load-stations').val();
            
            if (Array.isArray(hubstation)) {
                excludeStations = _.union(excludeStations, hubstation);
            } 

            $('#ogpl-via').html(function () {
                return $viaStations.filter(function () {
                    return $.inArray($(this).val(), excludeStations) == -1;
                });
            });
        }

        $('#ogpl-search-owner').on('change', function() {
            var ownershipType = $(this).find('[name="ogpl-search-owner"]:checked').val();

            var vehiclesData = [];
            $.each(OGPLVehicles || [], function(i, row) {
                if ((isNull(ownershipType) || ownershipType == row.ownershipType.code) && row.activeFlag == 1) {
                    var vehicle = $.extend({}, row)
                    vehicle.id = row.code;
                    vehicle.text = row.registationNumber;
                    vehiclesData.push(vehicle);
                }
            });
            
            var vehicleSelectTpl = $('#vehicle-select-tpl').html();
            var formatResult = function(vehicle) {
                var $tpl = $(vehicleSelectTpl);

                $tpl.find('.vehicle-name').text(vehicle.registationNumber);
                $tpl.find('.vehicle-type').text(vehicle.vehicleType.name);

                if (cargoSetting.transitLocationModelCode == 'STN') {
                    $tpl.find('.vehicle-location').text(vehicle.transitStation.name || '-');
                } else if (cargoSetting.transitLocationModelCode == 'BRCH') {
                    $tpl.find('.vehicle-location').text(vehicle.transitOrganization.name || '-');
                }

                if (vehicle.transitStatusCode == 'CMPLT') {
                    $tpl.find('.vehicle-transit-status').html('<span style="padding: 1px 4px;" class="badge badge-success"><small>Available</small></span>');
                } else if (vehicle.transitStatusCode == 'INTRN') {
                    $tpl.find('.vehicle-transit-status').html('<span style="padding: 1px 4px;" class="badge badge-danger"><small>In Transit</small></span>');
                }
                $tpl.find('.vehicle-ownership').text(vehicle.ownershipType.name);
                return $tpl;
            };

            function matcher(term, text, vehicle) {
                text = [vehicle.registationNumber, vehicle.vehicleType.name, vehicle.transitStation.name, vehicle.transitOrganization.name, vehicle.ownershipType.name].join(' ');
                return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
            };

            $('#ogpl-search-vehicle').select2('destroy');
            $('#ogpl-search-vehicle').select2({
                data: { results: vehiclesData },
                placeholder: 'Select Vehicle',
                formatResult: formatResult,
                formatSelection: formatResult,
                matcher: matcher
            });

            $('#ogpl-search-vehicle').val('').trigger('change');
        }).trigger('change');

        $('#ogpl-search-vehicle').on('change', function () {
            $('#vehicle-location-info, #vehicle-details').addClass('hide');
            $('#ogpl-template-container').hide();
            $('#ogpl-search-list-container').hide();

            var vehicleCode = this.value;
            if (!vehicleCode) {
                return;
            }

            var vehicle = _.find(OGPLVehicles, o => o.code == vehicleCode);
            if (!vehicle) {
                return;
            }

            if (cargoSetting.transitLocationModelCode == 'STN' && vehicle.transitStation.code) {
                $('#vehicle-location').html(vehicle.transitStation.name || '');
                $('#vehicle-location-info').removeClass('hide');
            } else if (cargoSetting.transitLocationModelCode == 'BRCH' && vehicle.transitOrganization.code) {
                $('#vehicle-location').html(vehicle.transitOrganization.name || '');
                $('#vehicle-location-info').removeClass('hide');
            }

            $('#vehicle-details').removeClass('hide');
            $('#v-regno').html(vehicle.registationNumber);
            $('#v-name').html(vehicle.name);
            $('#v-owntype').html(vehicle.ownershipType.name);
            $('#v-disname').html([vehicle.makeType, vehicle.modelType, vehicle.fuelType.name, vehicle.vehicleType.name].filter(isNotNull).join(' - '));
            $('#v-transporter').html(vehicle.transporterContact.name);
            $('#v-fuel').html(vehicle.fuelTankCapacity + ' Litres');
            $('#v-dimension').html(vehicle.dimensions);
            $('#v-capacity').html(vehicle.loadCapacity + ' Ton');

            var tags = [];
            $.each(vehicle.tag || [], function (i, tag) {
                tags.push('<span class="label label-default">' + tag.name + '</span>&nbsp;')
            });
            $('#v-tags .values').html(tags);
            $('#v-tags').toggleClass('hide', tags.length == 0)

            drivers = []
            $.each(driversData || [], function (i, driver) {
                if (vehicle.ownershipType.code == driver.ownershipType.code) {
                    drivers.push(driver);
                }
            });
        });

        if (linkVehicleCode) {
            $('#ogpl-search-vehicle').val(linkVehicleCode).trigger('change').prop('disabled', true);
            if (linkTransitType == 'INTRNT') {
                $('#transit-type [name="transit-type"][value="TRNT"]').closest('label').removeClass('active');
                $('#transit-type [name="transit-type"][value="'+linkTransitType+'"]').prop('checked', true).trigger('change');
                $('#transit-type [name="transit-type"][value="'+linkTransitType+'"]').closest('label').addClass('active').addClass('disabled');
                $('#transit-type [name="transit-type"]').not('[value="'+linkTransitType+'"]').closest('label').addClass('disabled');
                $('#link-local-transit-div').addClass('hide');
                if (isNotNull(localTransitSearchData)) {
                    $('label[for="link-local-transit"]').html('Link previous local transit');
                    $('#link-local-transit').prop('checked', isNotNull(linkVehicleCode));
                    $('#link-local-transit-div').removeClass('hide');
                }
            } else if(linkTransitType == 'OTFD') {
                $('#transit-type [name="transit-type"][value="TRNT"]').closest('label').removeClass('active');
                $('#transit-type [name="transit-type"][value="'+linkTransitType+'"]').prop('checked', true).trigger('change');
                $('#transit-type [name="transit-type"][value="'+linkTransitType+'"]').closest('label').addClass('active').addClass('disabled');
                $('#transit-type [name="transit-type"]').not('[value="'+linkTransitType+'"]').closest('label').addClass('disabled');
                $('#link-local-transit-div').addClass('hide');
                if (isNotNull(localTransitSearchData)) {
                    $('label[for="link-local-transit"]').html('Link previous Out For Delivery');
                    $('#link-local-transit').prop('checked', isNotNull(linkVehicleCode));
                    $('#link-local-transit-div').removeClass('hide');
                }
            }
            getOgplList();
        }

        $('#ogpl-search-date').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true,
            todayHighlight: true
        });

        if (!$.isEmptyObject(OGPLEdit)) {
            $('#ogpl-search-container #ogpl-search-vehicle').prop('disabled', true).closest('.form-group').show();
            getOgplList(OGPLEdit.code);
            fillOgplEdit(OGPLEdit);
        }

        function addViaZone() {
            $('#ogpl-add-via-zone-div').toggleClass('hide');
        }

        function addLinkLoadZone() {
            $('#ogpl-add-link-load-zones-div').toggleClass('hide');
        }

        function array_unique(arr) {
            return arr.filter((value, index, self) => {
                return self.indexOf(value) === index;
            });
        }

        function toggleRoutes() {
            var routes = [];
            $.each(OGPLtpl || [], function(k, val) {
                routes.push(new Option(val.name, val.code));
            });

            $('#ogpl-tpl')
                .select2('destroy')
                .html('<option value="">Select a route</option>')
                .append(routes)
                .select2()
                .select2('open');
        }

        function validateOGPL() {
            $('#ogpl-form-div .inp_error').removeClass('inp_error');
            var err = 0;
            if (!$.isEmptyObject(OGPLEdit)) {
                proceedOGPL();
                return false;
            }
            var data = {};
            data.activeFlag = 1;

            data.cargoActivityType = [];
            $('#transit-type [name="transit-type"]:checked').each(function() {
                data.cargoActivityType.push($(this).val());
            });

            if (data.cargoActivityType.length == 0) {
                $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#ogpl-action-state').html('Please choose a mode of transit');
                $('#ogpl-action-state').show();
                return false;
            }
            data.cargoActivityType = {};
            data.cargoActivityType.code = $('#transit-type [name="transit-type"]:checked').val();

            data.code = $('#hid-ogpl-code').val();
            data.name = $('#ogpl-name').val().trim();
            data.tripDate = $('#ogpl-date').val() || moment().format('DD-MM-YYYY');
            data.via = $('#ogpl-via').val();
            data.localTransitBranches = $('#local-via-branches').val();

            data.supervisor = {};
            data.supervisor.code = $('#hid-supervisor-code').val();
            data.supervisor.name = $.trim($('#ogpl-supervisor-name').val());
            data.supervisor.mobile = $.trim($('#ogpl-supervisor-mobile').val());

            data.vehicleDriver = {};
            data.vehicleDriver.code = $('#hid-driver-code').val();
            data.vehicleDriver.name = $.trim($('#ogpl-prim-driver-name').val());
            data.vehicleDriver.mobileNumber = $.trim($('#ogpl-prim-driver-mobile').val());

            data.secondaryDriver = {};
            data.secondaryDriver.code = $('#hid-driver2-code').val();
            data.secondaryDriver.name = $.trim($('#ogpl-sec-driver-name').val());
            data.secondaryDriver.mobileNumber = $.trim($('#ogpl-sec-driver-mobile').val());
            

            var busVehicle = $('#ogpl-search-vehicle').select2('data');
            data.busVehicle = {};
            if (busVehicle) {
                data.busVehicle.code = busVehicle.code;
                data.busVehicle.registationNumber = busVehicle.registationNumber;
            }

            data.fromStation = {};
            data.fromStation.code = $('#ogpl-from').val();
            data.fromStation.name = $('#ogpl-from option:selected').text();

            data.toStation = {};
            data.toStation.code = $('#ogpl-to').val();
            data.toStation.name = $('#ogpl-to option:selected').text();

            if ($.inArray('TRNT', data.cargoActivityType) > -1) {
                data.viaStations = $.map($('#ogpl-via option:selected') || [], function(val) {
                    return { code: $(val).val(), name: $(val).text() };
                });

                data.viaZones = $.map($('#ogpl-via-zones option:selected') || [], function(val) {
                    return { code: $(val).val(), name: $(val).text() };
                });
            }

            if ($.inArray('HBTRNT', data.cargoActivityType) > -1) {
                data.linkLoadStations = $.map($('#link-load-stations option:selected') || [], function(val) {
                    return { code: $(val).val(), name: $(val).text() };
                });

                data.hubViaZones = $.map($('#link-load-zones option:selected') || [], function(val) {
                    return { code: $(val).val(), name: $(val).text() };
                });
            }

            if ($.inArray('INTRNT', data.cargoActivityType) > -1) {
                data.localViaOrganizations = $.map($('#local-via-branches option:selected') || [], function(val) {
                    return { code: $(val).val(), name: $(val).text() };
                });
            }

            data.departureMinutes = Number($('#ogpl-departuretime').val());
            data.arrivalMinutes = Number($('#ogpl-arrivalday').val()) + Number($('#ogpl-arrivaltime').val());

            data.saveAsTemplate = Number($('#save-as-tpl').is(':checked'));

            data.transitReference = [];
            if ($('#link-local-transit').is(':checked')) {
                data.transitReference.push({ code: linkLocalOfd })
            }

            if (data.name == '') {
                $('#ogpl-name').addClass('inp_error');
                err++;
            }
            if (isNull(data.tripDate)) {
                $('#ogpl-date').addClass('inp_error');
                err++;
            }

            if ($.inArray('TRNT', data.cargoActivityType) > -1) {
                if (data.fromStation.code == '') {
                    $('#ogpl-from').addClass('inp_error');
                    err++;
                }
                if (data.toStation.code == '') {
                    $('#ogpl-to').addClass('inp_error');
                    err++;
                }
                if (data.viaStations.length == 0) {
                    $('#ogpl-via').addClass('inp_error');
                    err++;
                }
            } 
            
            if ($.inArray('HBTRNT', data.cargoActivityType) > -1) {
                if (data.fromStation.code == '') {
                    $('#ogpl-from').addClass('inp_error');
                    err++;
                }
                if (data.toStation.code == '') {
                    $('#ogpl-to').addClass('inp_error');
                    err++;
                }
                if (data.linkLoadStations.length == 0) {
                    $('#link-load-stations').addClass('inp_error');
                    err++;
                }
            } 

            if ($.inArray('INTRNT', data.cargoActivityType) > -1) {
                if (data.fromStation.code == '') {
                    $('#ogpl-from').addClass('inp_error');
                    err++;
                }

                if (data.toStation.code == '') {
                    $('#ogpl-to').addClass('inp_error');
                    err++;
                }

                if (data.localViaOrganizations.length == 0) {
                    $('#local-via-branches').addClass('inp_error');
                    err++;
                }
            }

            if (!data.busVehicle.code && !data.busVehicle.registationNumber) {
                $('#ogpl-search-vehicle').addClass('inp_error');
                err++;
            }
            if (menu_permission['OGPL-MND-VCH'] && !data.busVehicle.code) {
                $('#ogpl-search-vehicle').addClass('inp_error');
                err++;
            }

            if (data.supervisor.name == '') {
                $('#ogpl-supervisor-name').addClass('inp_error');
                err++;
            }

            if (isNull(data.supervisor.mobile)) {
                $('#ogpl-supervisor-mobile').addClass('inp_error');
                err++;
            }

            if (isNull(data.vehicleDriver.name)) {
                $('#ogpl-prim-driver-name').addClass('inp_error');
                err++;
            }

            if (isNull(data.vehicleDriver.mobileNumber)) {
                $('#ogpl-prim-driver-mobile').addClass('inp_error');
                err++;
            }

            if (isNotNull(data.supervisor.mobile) && !isValidPhonenumber(data.supervisor.mobile)) {
                
                $('#ogpl-supervisor-mobile').addClass('inp_error');
                err++;
            }

            if (isNotNull(data.vehicleDriver.mobileNumber) && !isValidPhonenumber(data.vehicleDriver.mobileNumber)) {
                $('#ogpl-prim-driver-mobile').addClass('inp_error');
                err++;
            }
            if (isNotNull(data.secondaryDriver.mobileNumber) && !isValidPhonenumber(data.secondaryDriver.mobileNumber)) {
                $('#ogpl-sec-driver-mobile').addClass('inp_error');
                err++;
            }

            var errmsg = 'Please enter/select the values in the field that are marked in red';
            if ($.inArray('TRNT', data.cargoActivityType) > -1 || $.inArray('HBTRNT', data.cargoActivityType) > -1) {
                if (data.fromStation.code == data.toStation.code) {
                    $('#ogpl-to').addClass('inp_error');
                    errmsg = 'Please select different To Station';
                    err++;
                }
                if ($.inArray(data.fromStation.code, $('#ogpl-via').val()) > -1 ||
                    $.inArray(data.toStation.code, $('#ogpl-via').val()) > -1) {
                    $('#ogpl-via').addClass('inp_error');
                    errmsg = 'Please select different Via Station';
                    err++;
                }

                if ($.inArray(data.fromStation.code, $('#link-load-stations').val()) > -1 ||
                    $.inArray(data.toStation.code, $('#link-load-stations').val()) > -1) {
                    $('#link-load-stations').addClass('inp_error');
                    errmsg = 'Please select different Via Station';
                    err++;
                }
            }

            if (err > 0) {
                $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#ogpl-action-state').html(errmsg);
                $('#ogpl-action-state').show();
                return false;
            }
            $('#ogpl-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#ogpl-action-state').html(loading_popup).show();

            data = {};
            data.vehicleCode = $('#ogpl-search-vehicle').val();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/validate-ogpl-vehicle',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        if ((response.data || []).length == 0) {
                            
                            proceedOGPL();
                        } else {
                            $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                            $('#ogpl-action-state').html('Vehicle not free, please unload loaded LR or check duplicate OGPL');
                        }
                    } else {
                        $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                        $('#ogpl-action-state').html(response.errorDesc);
                    }
                }
            });
        }

        // Empty Load btn validation
        $(document).on('change', 'input[name="transit-type"]', function() {
            emptyLoadBtnValidation();
        });

        
        function emptyLoadBtnValidation(){
            let transitTypeChecked = [];
            let selectElem = $('input[name="transit-type"]:checked'); 
            let btnElm = $('.empty-load-btn');
            btnElm.hide();
            let emptyLoad =$('.empty-and-load-btn');
            emptyLoad.hide();

            $('#transit-type [name="transit-type"]:checked').each(function() {
                transType=$(this).val();
                transitTypeChecked.push(transType);
            });

            selectElem.each(function() {
                transitTypeChecked.push($(this).val());
            });
           
            if (selectElem.length === 1 && (selectElem.val() === "TRNT" || selectElem.val() === "INTRNT")) {
                btnElm.show();
            } else {
                btnElm.hide();
            }

            if (transitTypeChecked.includes('INTRNT') && transitTypeChecked.includes('OTFD')) {
                emptyLoad.show();
            } else {
                emptyLoad.hide();
        }
        }

        function proceedOGPL(loadtype,allowLoading) {
            let transType = null;
            var transitList = [];
            $('#transit-type [name="transit-type"]:checked').each(function() {
                transitList.push($(this).val());
                transType=$(this).val();
            });
          
            if(allowLoading != "LOAD"){
                if(!transitList.includes('INTRNT') && !transitList.includes('OTFD')){
                let fromStation=$('#ogpl-from').val();
                let toStation = $('#ogpl-to').val();
                if(fromStation == toStation) {
                    $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#ogpl-action-state').html('Please Choose Different To Station');
                    $('#ogpl-action-state').show();
                    return;
                }else{
                    $('#ogpl-action-state').hide();
                }
            }
            }

            $('#ogpl-form-div .inp_error').removeClass('inp_error');
            var err = 0;
            var data = {};
            data.activeFlag = 1;

            data.cargoActivityType = [];
            $('#transit-type [name="transit-type"]:checked').each(function() {
                data.cargoActivityType.push($(this).val());
            });

            if (data.cargoActivityType.length == 0) {
                $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#ogpl-action-state').html('Please choose a mode of transit');
                $('#ogpl-action-state').show();
                return false;
            }

            data.code = $.trim($('#hid-ogpl-code').val());
            data.name = $('#ogpl-name').val().trim();
            data.tripDate = $('#ogpl-date').val() || moment().format('DD-MM-YYYY');
            data.via = $('#ogpl-via').val();
            data.localTransitBranches = $('#local-via-branches').val();

            data.supervisor = {};
            data.supervisor.code = $('#hid-supervisor-code').val();
            data.supervisor.name = $.trim($('#ogpl-supervisor-name').val());
            data.supervisor.mobile = $.trim($('#ogpl-supervisor-mobile').val());

            data.vehicleDriver = {};
            data.vehicleDriver.code = $('#hid-driver-code').val();
            data.vehicleDriver.name = $.trim($('#ogpl-prim-driver-name').val());
            data.vehicleDriver.mobileNumber = $.trim($('#ogpl-prim-driver-mobile').val());

            data.secondaryDriver = {};
            data.secondaryDriver.code = $('#hid-driver2-code').val();
            data.secondaryDriver.name = $.trim($('#ogpl-sec-driver-name').val());
            data.secondaryDriver.mobileNumber = $.trim($('#ogpl-sec-driver-mobile').val());

            var busVehicle = $('#ogpl-search-vehicle').select2('data');
            data.busVehicle = {};
            if (busVehicle) {
                data.busVehicle.code = busVehicle.code;
                data.busVehicle.registationNumber = busVehicle.registationNumber;
            }

            data.viaStations = [];
            data.viaZones = [];
            if ($.inArray('TRNT', data.cargoActivityType) > -1) {
                $('#ogpl-via option:selected').each(function(i, val) {
                    data.viaStations.push({ code: $(val).val(), name: $(val).text() });
                });

                $('#ogpl-via-zones option:selected').each(function(i, val) {
                    data.viaZones.push({ code: $(val).val(), name: $(val).text() });
                });
            }

            data.linkLoadStations = [];
            data.hubViaZones = [];
            if ($.inArray('HBTRNT', data.cargoActivityType) > -1) {
                $('#link-load-stations option:selected').each(function(i, val) {
                    data.linkLoadStations.push({ code: $(val).val(), name: $(val).text() });
                });

                $('#link-load-zones option:selected').each(function(i, val) {
                    data.hubViaZones.push({ code: $(val).val(), name: $(val).text() });
                });
            }

            data.localViaOrganizations = []
            if ($.inArray('INTRNT', data.cargoActivityType) > -1) {
                $('#local-via-branches option:selected').each(function(i, val) {
                    data.localViaOrganizations.push({ code: $(val).val(), name: $(val).text() });
                });
            }

            data.fromStation = {};
            if (data.cargoActivityType[0] == 'OTFD') {
                data.fromStation.code = user_login_station;
                data.fromStation.name = user_login_station_name;
            } else {
                data.fromStation.code = $('#ogpl-from').val();
                data.fromStation.name = $('#ogpl-from option:selected').text();
            }

            data.toStation = {};
            if (data.cargoActivityType[0] == 'OTFD') {
                data.toStation.code = user_login_station;
                data.toStation.name = user_login_station_name;
            } else {
                data.toStation.code = $('#ogpl-to').val();
                data.toStation.name = $('#ogpl-to option:selected').text();
            }

            data.name = (data.fromStation.name).toUpperCase().substring(0, 4) +' TO '+ (data.toStation.name).toUpperCase().substring(0, 4);
            
            data.fromOrganization = {};
            data.fromOrganization.code =$('#ogpl-from-branch').val();
            data.fromOrganization.name =$('#ogpl-from-branch option:selected').text();

            data.toOrganization = {};
            data.toOrganization.code = $('#ogpl-to-branch').val();
            data.toOrganization.name =$('#ogpl-to-branch option:selected').text();
            if(allowLoading == 'LOAD'){
                var selectedOrg = $('#local-via-branches').val(); 
                var finalEl = selectedOrg[selectedOrg.length - 1];
                data.toOrganization.code =$('#ogpl-to-branch').val();
                data.toOrganization.name =$('#ogpl-to-branch option:selected').text();
            }else{
                data.toOrganization.code = $('#ogpl-to-branch').val();
                data.toOrganization.name =$('#ogpl-to-branch option:selected').text();
            }
            
            data.departureMinutes = Number($('#ogpl-departuretime').val());
            data.arrivalMinutes = Number($('#ogpl-arrivalday').val()) + Number($('#ogpl-arrivaltime').val());

            data.saveAsTemplate = Number($('#save-as-tpl').is(':checked'))
            data.remarks =$('#ogpl-remarks').val();

            data.transitReference = [];
            if ($('#link-local-transit').is(':checked')) {
                data.transitReference.push({ code: linkLocalOfd })
            }


            if (isNull(data.tripDate)) {
                $('#ogpl-date').addClass('inp_error');
                err++;
            }

            if ($.inArray('TRNT', data.cargoActivityType) > -1) {
                if (data.fromStation.code == '') {
                    $('#ogpl-from').addClass('inp_error');
                    err++;
                }
                if (data.toStation.code == '') {
                    $('#ogpl-to').addClass('inp_error');
                    err++;
                }
                if (data.viaStations.length == 0) {
                    $('#ogpl-via').addClass('inp_error');
                    err++;
                }
            } 

            if ($.inArray('HBTRNT', data.cargoActivityType) > -1) {
                if (data.fromStation.code == '') {
                    $('#ogpl-from').addClass('inp_error');
                    err++;
                }
                if (data.toStation.code == '') {
                    $('#ogpl-to').addClass('inp_error');
                    err++;
                }
                if (data.linkLoadStations.length == 0) {
                    $('#link-load-stations').addClass('inp_error');
                    err++;
                }
            } 
            if (Array.isArray(data.viaStations) && Array.isArray(data.linkLoadStations)) {
                for (var i = 0; i < data.viaStations.length; i++) {
                    if ($.inArray(data.viaStations[i].code, data.linkLoadStations.map(item => item.code)) > -1) {
                        $('#ogpl-via').addClass('inp_error');
                        $('#link-load-stations').addClass('inp_error');
                        err++;
                        
                    }
                }
            }
            
            if ($.inArray('INTRNT', data.cargoActivityType) > -1) {
                if (data.fromStation.code == '') {
                    $('#ogpl-from').addClass('inp_error');
                    err++;
                }

                if (data.toStation.code == '') {
                    $('#ogpl-to').addClass('inp_error');
                    err++;
                }

                if (data.localViaOrganizations.length == 0) {
                    $('#local-via-branches').addClass('inp_error');
                    err++;
                }
            }

            if (!data.busVehicle.code && !data.busVehicle.registationNumber) {
                $('#ogpl-search-vehicle').addClass('inp_error');
                err++;
            }
            if (menu_permission['OGPL-MND-VCH'] && !data.busVehicle.code) {
                $('#ogpl-search-vehicle').addClass('inp_error');
                err++;
            }

            if (data.supervisor.name == '') {
                $('#ogpl-supervisor-name').addClass('inp_error');
                err++;
            }

            if (isNull(data.supervisor.mobile)) {
                $('#ogpl-supervisor-mobile').addClass('inp_error');
                err++;
            }

            if (isNull(data.vehicleDriver.name)) {
                $('#ogpl-prim-driver-name').addClass('inp_error');
                err++;
            }

            if (isNull(data.vehicleDriver.mobileNumber)) {
                $('#ogpl-prim-driver-mobile').addClass('inp_error');
                err++;
            }
            
            if (isNotNull(data.supervisor.mobile) && !isValidPhonenumber(data.supervisor.mobile)) {
                $('#ogpl-supervisor-mobile').addClass('inp_error');
                err++;
            }
            if (isNotNull(data.vehicleDriver.mobileNumber) && !isValidPhonenumber(data.vehicleDriver.mobileNumber)) {
                $('#ogpl-prim-driver-mobile').addClass('inp_error');
                err++;
            }
            if (isNotNull(data.secondaryDriver.mobileNumber) && !isValidPhonenumber(data.secondaryDriver.mobileNumber)) {
                $('#ogpl-sec-driver-mobile').addClass('inp_error');
                err++;
            }
            
            if (cargoSetting.transitMode[0] == 1) {
                if (!data.code && ($.inArray('TRNT', data.cargoActivityType) > -1 || $.inArray('INTRNT', data.cargoActivityType) > -1) && ((cargoSetting.transitLocationModelCode == 'STN' && busVehicle && busVehicle.transitStation.code && data.fromStation.code != busVehicle.transitStation.code) || (cargoSetting.transitLocationModelCode == 'BRCH' && busVehicle && busVehicle.transitOrganization.station && busVehicle.transitOrganization.station.code && data.fromStation.code != busVehicle.transitOrganization.station.code))) {
                    $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#ogpl-action-state').html('Loading Not Allowed. Vehicle Located Station User Can Load');
                    $('#ogpl-action-state').show();
                    return false;  
                }
            }

            if (err > 0) {
                $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#ogpl-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#ogpl-action-state').show();
                return false;
            }
        
            // validate local via station selection if local transit
            if(loadtype == 'EMPTY_LOAD' && transType == 'INTRNT'){ //local
                if (data.localViaOrganizations.length>1) {
                    $('#local-via-branches').addClass('inp_error');
                    err++;
                    $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#ogpl-action-state').html('Multiple Selection Not applicable to Local Transit Empty Load');
                    $('#ogpl-action-state').show();
                    return false;
                } else {
                    $('#ogpl-action-state').hide();
                }
            }

            $('#ogpl-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#ogpl-action-state').hide();

            data.tripDate = moment(data.tripDate, 'DD-MM-YYYY').format('YYYY-MM-DD');
            OGPLFormData = data;

            if (loadtype == 'EMPTY_LOAD' || loadtype == 'TRANSFER_LOAD') {
                data.activityType = loadtype;
                data.additionalAttribute = {};
                if (loadtype == 'TRANSFER_LOAD') {
                    data.additionalAttribute.TRANSFER_LOAD_FLAG = 1;
                    if (transType == 'TRNT') {
                        if (!data.transitDetailsType) {
                            data.transitDetailsType = {};
                        }
                        data.transitDetailsType.code="DFLT";
                    } else if (transType == 'INTRNT') {
                        if (!data.transitDetailsType) {
                            data.transitDetailsType = {};
                        }
                        data.transitDetailsType.code="LCLD";
                    }
                }
                if(loadtype == 'EMPTY_LOAD' && transType == 'TRNT'){ //direct
                    data.cargoActivityType.code=transType;

                    if (!data.transitDetailsType) {
                        data.transitDetailsType = {};
                    }
                    data.transitDetailsType.code="DFLT";
                }

                if(loadtype == 'EMPTY_LOAD' && transType == 'INTRNT' ){ //local
                    let toOrganizationForLocal=$('#local-via-branches option:selected').val();
                    data.toOrganization.code=toOrganizationForLocal;
                    data.cargoActivityType.code=transType;

                    if (!data.transitDetailsType) {
                        data.transitDetailsType = {};
                    }
                    data.transitDetailsType.code="LCLD";
                }
                //load in empty load vehicle
                if(allowLoading == 'LOAD'){
                    
                var lastIndex = data.localViaOrganizations.length - 1;
                var lastCode = data.localViaOrganizations[lastIndex].code;
                    data.toOrganization.code=lastCode; 
                    if (!data.transitDetailsType) {
                        data.transitDetailsType = {};
                    }
                    data.transitDetailsType.code="LCLD";
                }
                var loading_overlay = iosOverlay({
                    text: "Loading...",
                    icon: "fa fa-spinner fa-spin"
                });

                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: base_url + 'cargo/ogplv3-empty-load',
                    data: data,
                    success: function (response) {
                        if (response.status == 1) {
                            loading_overlay.update({
                                icon: "fa fa-check",
                                text: "Load Success"
                            });
                            $('#empty-transit-btn, #proceed-transit-btn').addClass('hide');
                            OGPLFormData.code = response.OGPLCode;
                            if(loadtype == 'EMPTY_LOAD' && transType == 'INTRNT' ){ 
                                showStartTripDialog(false); //don't allow to direct or refres the page.
                             }else{
                                showStartTripDialog(true); //allow to redirect
                             }
                        } else {
                            loading_overlay.update({
                                icon: "fa fa-times",
                                text: "Load Failed!"
                            });
                        }
                        window.setTimeout(function () {
                            loading_overlay.hide();
                        }, 2000);
                    }
                });
                
            if(allowLoading != "LOAD"){
                return;
            }
            }

            $('#edit-ogpl-name').text(OGPLFormData.name);
            $('#edit-ogpl-date').text(moment(OGPLFormData.tripDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            
            if (isNotNull(OGPLEdit)) {
                $('#edit-ogpl-from').text(OGPLEdit.fromStation.name);
                $('#edit-ogpl-sub-from').text(OGPLEdit.fromStation.name);
            } else {
                $('#edit-ogpl-from').text(OGPLFormData.fromStation.name);
                $('#edit-ogpl-sub-from').text(OGPLFormData.fromStation.name);
            }
            $('#edit-ogpl-to').text(OGPLFormData.toStation.name);
            $('#edit-ogpl-branch-from').text(OGPLFormData.fromOrganization.name);
            $('#edit-ogpl-branch-to').text(OGPLFormData.toOrganization.name);
            $('#edit-ogpl-sub-to').text(OGPLFormData.toStation.name);
            $('#edit-ogpl-vehicle').text(data.busVehicle.registationNumber);
            $('#edit-ogpl-driver').text(OGPLFormData.vehicleDriver.name);
            $('#edit-ogpl-driver2').text(OGPLFormData.secondaryDriver.name || '-');
            $('#edit-ogpl-supervisor').text(OGPLFormData.supervisor.name || '-');
            $('#edit-load-remarks').text(OGPLFormData.remarks);
            // $('#edit-ogpl-odometer').text(OGPLFormData.odometer || '-');

            if ($('#edit-load-remarks').text().trim() == '') {
                $('#edit-hide-remarks').addClass('hide');
            }

            if ($('#edit-out-for-delivery-branch').text().trim() == '') {
                $('#edit-out-for-delivery-hide-branch').addClass('hide');
            }

            if ($('#edit-link-load-via-zone').text().trim() == '') {
                $('#edit-link-load-via-zone-hide').addClass('hide');
            }

            if ($('#edit-link-load-via').text().trim() == '') {
                $('#edit-link-load-via-hide').addClass('hide');
            }

            if($('#edit-local-via-branches').text().trim() == ''){
                $('#edit-local-hide-branch-via').addClass('hide');
            }

            if($('#edit-ogpl-via-zone').text().trim() == ''){
                $('#edit-ogpl-via-zone-hide').addClass('hide');
            }

        
            $('#edit-ogpl-via').text($('#ogpl-via option:selected').map(function() {
                return $(this).text();
            }).get().join(', '));

            $('#edit-ogpl-via-zone').text($('#ogpl-via-zones option:selected').map(function() {
                return $(this).text();
            }).get().join(', '));

            $('#edit-link-load-via').text($('#link-load-stations option:selected').map(function() {
                return $(this).text();
            }).get().join(', '));

            $('#edit-link-load-via-zone').text($('#link-load-zones option:selected').map(function() {
                return $(this).text();
            }).get().join(', '));

            $('#edit-local-transit-via').text($('#local-transit-stations option:selected').map(function() {
                return $(this).text();
            }).get().join(', '));

            $('#edit-local-via-branches').text($('#local-via-branches option:selected').map(function() {
                return $(this).text();
            }).get().join(', '));

            if ($.inArray('OTFD', data.cargoActivityType) > -1) {
                $('#edit-out-for-delivery-branch').text(user_login_station_name);
            }
            $('#ogpl-form-div').hide();
            $('#edit-ogpl-list-container').fadeIn('slow');
            $('#edit-ogpl-search-container').fadeIn('slow');
            $('#add-ogpl-list-container').removeClass('hidden');
            $('#transit-direct-load-lrs, #transit-link-load-lrs, #transit-local-transit-lrs, #transit-out-for-delivery-lrs').html('');
            $('#direct-load-load-lr-content, #link-load-load-lr-content, #local-transit-load-lr-content, #out-for-delivery-load-lr-content, #local-transit-load-alphabet-content, #link-load-load-alphabet-content, #direct-load-load-alphabet-content, #out-for-delivery-load-alphabet-content').html('');
            $('#direct-load-btn, #link-load-btn, #local-load-btn , #out-for-delivery-load-btn').removeAttr('onclick').prop('disabled', true);

            if (isNotNull(OGPLEdit)) {
                var loadingClosed = 0;
                if (OGPLEdit.activity.includes('COMPLETE')) {
                    $("#direct-load-btn, #link-load-btn, #local-load-btn, #out-for-delivery-load-btn").removeAttr('onclick').prop('disabled', true);
                    loadingClosed = 1;
                } else {
                    var user_organization_found = false;
                    $.each(OGPLEdit.transitRoutes || [], function (i, detail) {
                        if (detail.createdAt && detail.organization && detail.organization.code == user_login_branch) {
                            user_organization_found = true;
                            var allowedTill = moment(detail.createdAt).add(5, 'hours');
                            if (!moment().isBefore(allowedTill)) {
                                $("#direct-load-btn, #link-load-btn, #local-load-btn, #out-for-delivery-load-btn").removeAttr('onclick').prop('disabled', true);
                                loadingClosed = 1;
                            }
                        }
                    });

                    if (user_organization_found == false) {
                        $.each(OGPLEdit.transitCargoDetails || [], function (i, detail) {
                            if (detail.fromStation && detail.fromStation.code == user_login_station) {
                                var allowedTill = moment(detail.audit.updatedAt).add(5, 'hours');
                                if (!moment().isBefore(allowedTill)) {
                                    $("#direct-load-btn, #link-load-btn, #local-load-btn, #out-for-delivery-load-btn").removeAttr('onclick').prop('disabled', true);
                                    loadingClosed = 1;
                                }
                            }
                        });
                    }
                }

                if (loadingClosed == 1) {
                    return false;
                }
            }
           
            if(allowLoading == "LOAD"){
                transit_get_out_for_delivery_lrs();
                return;
            }

            if (Array.isArray(data.cargoActivityType) && data.cargoActivityType[0] == 'TRNT') {
                transit_get_direct_load_lrs();
            }

            if (Array.isArray(data.cargoActivityType) && data.cargoActivityType[0] == 'HBTRNT') {
                transit_get_link_load_lrs();
            }

            if (Array.isArray(data.cargoActivityType) && data.cargoActivityType[0] == 'INTRNT') {
                transit_get_local_transit_lrs();
            }

            if (Array.isArray(data.cargoActivityType) && data.cargoActivityType[0] == 'OTFD') {
                transit_get_out_for_delivery_lrs();
            }
        }

        var directLoadLoadedLrsList = [];
        var linkLoadLoadedLrsList = [];
        var localTransitLoadedLrsList = [];
        var outForDeliveryLoadedLrsList = [];

        // Direct Load Start
        function transit_get_direct_load_lrs() {
            var data = {};

            data.cargoActivityType = OGPLFormData.cargoActivityType;
            data.code = OGPLFormData.code;
            data.tripDate = OGPLFormData.tripDate;
            data.ogplVia = OGPLFormData.viaStations;
            data.endStation = {}
            data.endStation.code = OGPLFormData.toStation.code;
            data.endStation.name = OGPLFormData.toStation.name;
            data.viaStationCodes = [].concat(OGPLFormData.toStation, OGPLFormData.viaStations).map(i => i.code).join(',');

            if(directLoad == "HIDE"){
                return;
            }

            $('#transit-direct-load-lrs').html('<tr><td colspan="3" align="center">'+loading_popup+'</td></tr>');
            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'cargo/transitv3-get-direct-load-lrs',
                data: data,
                success: function (response) {
                    var summaryContent = $($.parseHTML(response)).filter("#direct-load-lr-body");
                    var dialogContent = $($.parseHTML(response)).filter("#direct-load-load-lr-list");
                    var alphabetContent = $($.parseHTML(response)).filter("#directAlphabetOrder");
                    $('#direct-load-btn').attr('onclick', 'loadDirectLoadLrsDialog()').prop('disabled', false);
                    $('#transit-direct-load-lrs').html(summaryContent.html());
                    $('#direct-load-load-lr-content').html(dialogContent.html());
                    $('#direct-load-load-alphabet-content').html(alphabetContent.html());
                    if (Array.isArray(data.cargoActivityType) && data.cargoActivityType[1] == 'HBTRNT') {
                        transit_get_link_load_lrs();
                    } else if (Array.isArray(data.cargoActivityType) && data.cargoActivityType[1] == 'INTRNT') {
                        transit_get_local_transit_lrs();
                    } else if (Array.isArray(data.cargoActivityType) && data.cargoActivityType[1] == 'OTFD') {
                        transit_get_out_for_delivery_lrs();
                    }
                }
            });
        }

        function loadDirectLoadLrsDialog() {
            let localCheckedLr = localHandling();
            $('#direct-load-load-lr-dialog').css('background', '#fff');
            $('#direct-load-load-lr-dialog').removeClass('hide');
            $('#direct-load-load-lr-dialog').dialog({
                autoOpen: true,
                height: $(window).height() - 30,
                width: $(window).width() - 100,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();
            $('#transitv3-direct-load-action-state').removeClass('alert-danger').html('').hide();
            $('.inp_error').removeClass('inp_error');
            $('.ogpl-new-items').prop('checked', false).trigger('change');

            if (isNotNull(OGPLFormData.directLoadList)) {
                $.each(OGPLFormData.directLoadList, function(i, val) {
                    $.each(val.cargoList, function(i, cb) {
                        $('#load-ogpl-list .ogpl-new-items[value='+cb+']').prop('checked', true).trigger('change');
                        $('#load-ogpl-list .ogpl-new-items[value='+cb+']').closest('tr').find('.load-branch-sel').val(val.transitOrganization).trigger('change');
                    });
                });
            }

            $('.ogpl-new-directload-items').each(function() {
                var cargoCode = $(this).val();
                var isCargoInLocalLoad = localCheckedLr.some(function(localLoadArray) {
                    return localLoadArray.includes(cargoCode);
                });

                if (isCargoInLocalLoad) {
                    $(this).prop('disabled', true);
                    $(this).attr('title', 'Consignment loaded in another transit');
                } else if (localCheckedLr.length == 0){
                    $(this).prop('disabled', false);
                    $(this).attr('title', '');
                }
                if ($(this).prop('disabled')) {
                    $('.row-direct-' + cargoCode).hide();
                } else {
                    $('.row-direct-' + cargoCode).show();
                }
            });
        }

        function closeDirectLoadLrLoadDialog() {
            $('#direct-load-load-lr-dialog').addClass('hide');
            $('#direct-load-load-lr-dialog').dialog('destroy');
        }

        function selectAllDirectLoadLrs(cb) {
            let localCheckedLr = localHandling();
            var $cb = $(cb);

            $('.ogpl-new-directload-items')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked')).prop('disabled', false)
                .trigger('change');
            $('.ogpl-new-directload-items').each(function() {
                var cargoCode = $(this).val();
                var isCargoInLocalLoad = localCheckedLr.some(function(localLoadArray) {
                    return localLoadArray.includes(cargoCode);
                });

                if (isCargoInLocalLoad) {
                    $(this).prop('checked', false).prop('disabled', true);
                    $(this).attr('title', 'Consignment loaded in another transit');
                }
            });
        }

        function setAllDirectLoadTransitBranch() {
            var tsbnch = $('.direct-load-branch:first').val();
            if(tsbnch==""){
                $('.direct-load-branch:first').addClass('inp_error');
                return;
            }
            $('.direct-load-branch:first').removeClass('inp_error');
            $('.direct-load-branch').each(function () {
                this.value = tsbnch;
            });
        }

        // split lr -direct load section
        
        //uncheck parent LR selectin for direct load
        function checkHandle() {
            $('.ogpl-new-directload-items:checked').each(function() {
                var cargoCode = $(this).val();
                $('.row-' + cargoCode).hide();
                $('.row-' + cargoCode).find('.directbox').prop('checked', false);   

            });

            $('.ogpl-new-directload-items:not(:checked)').each(function() {
                var cargoCode = $(this).val();
                $('.row-' + cargoCode).show();
            });
        }

        function gatherCheckedData() {
            gatheredData=[];
            $('.custom-checkbox-group .directbox:checked').each(function(key,cb) {

                var $cb = $(cb);
                var $tr = $cb.closest('tr');
                var $upperTr = $tr.prevAll('tr').first();
                var fromStationName = $upperTr.find('.direct-load-branch-sel :selected').data('fromstationname');
                var transitstaName = $upperTr.find('.direct-load-branch-sel :selected').data('tostationname');

                var code = $(this).data('cargoid'); //cargoid
                var articalId = $(this).data('value'); //articalid
                var articalName = $(this).data('artname'); //articalname
                var articalQty=$(this).data('artqty');
                var value = $(this).val(); //itemCountPortion inArray

                var existingCargo = gatheredData.find(function(obj) {
                    return obj.code === code;
                });

                if (existingCargo) {
                    var existingArticle = existingCargo.itemDetails.find(function(article) {
                        return article.code === articalId;
                    });

                    if (existingArticle) {
                      
                         if (!existingArticle.itemCountPortion.includes(value)) {
                            existingArticle.itemCountPortion.push(value);
                            existingArticle.itemCount = existingArticle.itemCountPortion.length;
                        }
                    } else {
                        existingCargo.itemDetails.push({
                            code: articalId,
                            articalName: articalName,
                            itemCount: 1,
                            itemCountPortion: [value],
                            "activeFlag": 1,
                            "totalItem":articalQty
                        });
                    }
                } else {
                    var dataObject = {
                        code: code,
                        itemDetails: [{
                            code: articalId,
                            articalName: articalName,
                            itemCount: 1,
                            itemCountPortion: [value],
                            "activeFlag": 1,
                            "totalItem":articalQty
                        }],
                        'type': 'direct',
                        'extraData': {
                           'fromStation': fromStationName,
                           'toStation': transitstaName
                        }
                    };
                    gatheredData.push(dataObject);
                }
            });
          
            return gatheredData;
        }

        function getdirectLrsSrc() {
            var lrsSrc = [];
            // var transitorg='NA';
            $('.custom-checkbox-group .directbox:checked').each(function(i, cb) {
                var $cb = $(cb);
                var $tr = $cb.closest('tr'); 

                var $upperTr = $tr.prevAll('tr').first();

                var transitsta = $upperTr.find('.direct-load-branch-sel :selected').data('station');
                // var transitsta = $upperTr.find('.direct-load-branch-sel').val();
                var transitorg = $upperTr.find('.direct-load-branch-sel :selected').val();

                // var obj = {
                //     cargoId: $cb.data('cargoid'),
                //     from: $cb.data('oldtransitstn'),
                //     to: transitsta,
                //     oldTransitOrg: $cb.data('oldtransitorg'),
                //     transitOrganization: transitorg
                // };

                // lrsSrc.push(obj);
                var existingIndex = lrsSrc.findIndex(function (item) {
                    return item.cargoId === $cb.data('cargoid');
                });

                if (existingIndex === -1) {
                    var obj = {
                        cargoId: $cb.data('cargoid'),
                        from: $cb.data('oldtransitstn'),
                        to: transitsta,
                        oldTransitOrg: $cb.data('oldtransitorg'),
                        transitOrganization: transitorg
                    };
                    lrsSrc.push(obj);
                } else {
                    lrsSrc[existingIndex].from = $cb.data('oldtransitstn');
                    lrsSrc[existingIndex].to = transitsta;
                    lrsSrc[existingIndex].oldTransitOrg = $cb.data('oldtransitorg');
                    lrsSrc[existingIndex].transitOrganization = transitorg;
                }
            });
            return lrsSrc;
        }

        function removeLR(lr, type) {
            // getdirectLrsSrc();
            // gatherCheckedData();
            if(type=="direct"){
                splittedLR = gatheredData;
                lrSRc = getdirectLrsSrc();
            }
            else if(type=="link"){
                splittedLR =gatheredDataLink;
                lrSRc = getdirectLrsSrcLink();
            }
            else if(type=="local"){
                splittedLR = gatheredDataLocal;
                lrSRc = getdirectLrsSrcLocal();
            }

            var currendRow = $('.'+type+'-row-' + lr + '');
            currendRow.remove();

            var targetEl = $('.'+type+'-' + lr + ' input');
            targetEl.prop('checked',false);

            if(type=="direct") {
                deleteObjectByCode(gatheredData, lr);
            }
            else if(type=="link") {
                deleteObjectByCode(gatheredDataLink, lr);
            }
            else if(type=="local") {
                deleteObjectByCode(gatheredDataLocal, lr);
            }
            function deleteObjectByCode(array, codeToDelete) {
                for (let i = 0; i < array.length; i++) {
                    if (array[i].code === codeToDelete) {
                        array.splice(i, 1);
                        break;
                    }
                }
             }
             splitBtnHandle();
             handleSplitCount();
        }

        function groupGatheredSource(type){
            if(type=='direct'){
                var storedSource=getdirectLrsSrc();
                var requestSource=gatheredData;
            }else if(type=='link'){
                var storedSource=getdirectLrsSrcLink();
                var requestSource=gatheredDataLink;
            }else if(type == 'local'){
                var storedSource=getdirectLrsSrcLocal();
                var requestSource=gatheredDataLocal;
            }

            let groupedData = storedSource.map(item => {
                let matchedItem = requestSource.find(val => val.code === item.cargoId);
                if (matchedItem) {
                    return {
                        code: item.cargoId,
                        itemDetails: matchedItem.itemDetails.map(detail => {
                            return {
                                code: detail.code,
                                articalName: detail.articalName,
                                itemCount: detail.itemCount,
                                itemCountPortion: detail.itemCountPortion,
                                activeFlag: detail.activeFlag,
                                totalItem: detail.totalItem
                            };
                        }),
                        extraData: {
                            fromStation: matchedItem.extraData.fromStation,
                            toStation: matchedItem.extraData.toStation,
                            cargoId: item.cargoId,
                            from: item.from,
                            to: item.to,
                            oldTransitOrg: item.oldTransitOrg,
                            transitOrganization: item.transitOrganization
                        }
                    };
                }
            });
            return groupedData;
        }

        function splitAllPartitians(){
            $('.split-all').addClass('button__loader');
            $('.split-all').prop('disabled', true);
            let partialDatas = {
                "direct": groupGatheredSource('direct'),
                "link": groupGatheredSource('link'),
                "local": groupGatheredSource('local')
            };
                
            let loadedData = saveTransitV3('get');

            let reqData={
                "partial":partialDatas,
                "loadedData":loadedData
            }
            let data=JSON.stringify(reqData);
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'transitcargopartial/save_partial_request',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        gatherCheckedData=[];
                        gatherCheckedDataLink=[];
                        gatherCheckedDataLocal=[];
                        getdirectLrsSrc=[];
                        getdirectLrsSrcLink=[];
                        getdirectLrsSrcLocal= []; 
                        splitBtnHandle();
                        closeSplitPop();
                        var errors = [];
                        $.each(response.data.save.cargoResponseState || [], function (i, state) {
                            if (state.activeFlag != 1) {
                                errors.push(state.code + ' - ' + state.name);
                            }
                        });

                        if (errors.length) {
                            $('#save-transitv3-action-state').removeClass('alert-success').addClass('alert-danger')
                            $('#save-transitv3-action-state').html(errors.join('<br/>'));
                        } else {
                            $('#save-transitv3-action-state').removeClass('alert-danger').addClass('alert-success');
                            $('#save-transitv3-action-state').html('Your request processed successfully');
                            $('#transit-complete-btn').addClass('hide');
                            
                            window.setTimeout(function () {
                                $('#save-transitv3-action-state').removeClass('alert-danger, alert-success').html('').hide();
                                var params = {};
                                params.transitCode = response.data.save.OGPLCode;

                                if (isNotNull(loadedData.code)) {
                                    checkURL();
                                } else {
                                    var url = base_url + "#cargo/add-ogpl?" + $.param(params);
                                    window.open(url, "_self");
                                }
                                OGPLFormData.code = response.data.save.OGPLCode;
                                $('#hid-ogpl-code').val(response.data.save.OGPLCode)
                            }, 3000);
                        }
                    } else {
                        $('#save-transitv3-action-state').removeClass('alert-success').addClass('alert-danger')
                        $('#save-transitv3-action-state').html(response.msg);
                        $('#errorSaveMsg').show();
                        $('#errorSaveMsg').addClass('alert-danger');
                        $('#errorSaveMsg').html(response.msg);

                        var url = base_url + '#cargo/add-ogpl';
                        if (typeof transitOgplcode !== 'undefined' && transitOgplcode !== '') {
                            url += '?transitCode=' + transitOgplcode;
                        }
                        window.setTimeout(function() {
                            closeSplitPop();
                           location.reload();
                        }, 3000);
                    }
                    // success notification
                    if(response.data.partial && response.data.partial.success){
                        if(response.data.partial.success.direct && response.data.partial.success.direct.length>0){
                            response.data.partial.success.direct.forEach(data => {
                            success(data.code + " - partial success");
                            });
                        }
                    
                        if(response.data.partial.success.link && response.data.partial.success.link.length>0){
                            response.data.partial.success.link.forEach(data => {
                            success(data.code + " - partial success");
                            });
                        }
                    
                        if(response.data.partial.success.local && response.data.partial.success.local.length>0){
                            response.data.partial.success.direct.forEach(data => {
                            success(data.code + " - partial success");
                            });
                        }
                    }
                    // failed notification
                    if (response.data.partial && response.data.partial.failed) {
                        if(response.data.partial.failed.direct && response.data.partial.failed.direct.length>0){
                        response.data.partial.failed.direct.forEach(data => {
                            error(data.code + " - partial success");
                        });
                        }
                        if(response.data.partial.failed.link && response.data.partial.failed.link.length>0){
                            response.data.partial.failed.link.forEach(data => {
                                error(data.code + " - partial success");
                            });
                        }
                        if(response.data.partial.failed.local && response.data.partial.failed.local.length>0){
                            response.data.partial.failed.local.forEach(data => {
                                error(data.code + " - partial success");
                            });
                        }
                    }
                  
                    // btnValidation();
                    //enable reSave option
                    $('.split-all').removeClass('button__loader');
                    $('.split-all').prop('disabled', false);
                }
                
            });
        }

        function splitLRs() {
            let splittedLR =gatheredData;
            let splittedLRLink = gatheredDataLink;
            let splittedLRLocal = gatheredDataLocal;
            let directTable = $('.directLoadList');
            let linkTable = $('.linkLoadList');
            let localTable = $('.localLoadList');

            directTable.empty();
            linkTable.empty();
            localTable.empty();

            $('.direct-lr-section').hide();
            $('.link-lr-section').hide();
            $('.local-lr-section').hide();
            
            let directHtml = "";
            let linkHtml = "";
            let localHtml = "";

            // direct load split list 
            if(splittedLR.length > 0) {
                $('.direct-lr-section').show();
                $.each(splittedLR, function (key, value) {
                    directHtml += `
                        <div class="list-group-item direct-row-${value.code}">
                        <div class="row">
                            <div class="col-md-11">
                                <div class="row">
                                    <div class="col-md-1" style="padding: 0 4px;">
                                        <h5 class="badge badge-danger">${value.code}</h5>
                                        <div class="splittedLR-${value.code}"></div> 
                                    </div>
                                    <div class="col-md-11">
                                        <div class="text-center align-center"><span title="from station"><b>${value.extraData.fromStation}</b></span> <span><i class="fa fa-arrow-right"></i></span> <span title="to station"><b>${value.extraData.toStation}</b></span></div>
                                        <div class="d-flex article-container">
                                            ${value.itemDetails.map(item => `
                                                <div class="article-list px5px border-right">
                                                    <div class="d-flex">
                                                        <div class="">
                                                           <b>${item.totalItem}</b> out of <b>${item.itemCountPortion.length}</b> items
                                                        </div>
                                                    </div>
                                                    <div class="text-center bg-light artical-container">
                                                        ${item.articalName}
                                                    </div>
                                                </div>
                                            `).join('')}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-1">
                            <button class="btn btn-split none btn-${value.code} btn-sm btn-success btn"onclick="loadSplitLR('${value.code}','direct');"><i class="fa fa-scissors"></i></button> 
                            <button class="btn remove-btn-${value.code} btn-sm btn-danger" onclick="removeLR('${value.code}','direct');">Remove</button>
                            </div>
                        </div>
                    </div>`;
                });
                directTable.append(directHtml);
            }
            
           // link load split list
           if(splittedLRLink.length > 0) {
                $('.link-lr-section').show();
                $.each(splittedLRLink, function (key, value) {
                    linkHtml += `
                    <div class="list-group-item link-row-${value.code}">
                        <div class="row">
                            <div class="col-md-11">
                                <div class="row">
                                    <div class="col-md-1" style="padding: 0 4px;">
                                        <h5 class="badge badge-danger">${value.code}</h5>
                                        <div class="splittedLR-${value.code}"></div>
                                    </div>
                                    <div class="col-md-11">
                                    <div class="text-center align-center"><span title="from station"><b>${value.extraData.fromStation}</b></span> <span><i class="fa fa-arrow-right"></i></span> <span title="to station"><b>${value.extraData.toStation}</b></span></div>
                                        <div class="d-flex article-container">
                                            ${value.itemDetails.map(item => `
                                                <div class="article-list px5px border-right">
                                                    <div class="d-flex">
                                                        <div class="">
                                                        <b>${item.totalItem}</b> out of <b>${item.itemCountPortion.length}</b> items
                                                        </div>
                                                    </div>
                                                    <div class="text-center bg-light artical-container">
                                                        ${item.articalName}
                                                    </div>
                                                </div>
                                            `).join('')}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-1">
                            <button class="btn btn-split none btn-${value.code} btn-sm btn-success btn"onclick="loadSplitLR('${value.code}','link');"><i class="fa fa-scissors"></i></button>
                            <button class="btn remove-btn-${value.code} btn-sm btn-danger" onclick="removeLR('${value.code}','link');">Remove </button>
                            </div>
                        </div>
                    </div>`;
                });
                linkTable.append(linkHtml);
            }

            // local load split list
            if(splittedLRLocal.length > 0) {
                $('.local-lr-section').show();
                $.each(splittedLRLocal, function (key, value) {
                    localHtml += `
                    <div class="list-group-item local-row-${value.code}">
                        <div class="row">
                            <div class="col-md-11">
                                <div class="row">
                                    <div class="col-md-1">
                                        <h5 class="badge badge-danger">${value.code}</h5>
                                        <div class="splittedLR-${value.code}"></div>
                                    </div>
                                    <div class="col-md-11">
                                    <div class="text-center align-center"><span title="from station"><b>${value.extraData.fromStation}</b></span> <span><i class="fa fa-arrow-right"></i></span> <span title="to station"><b>${value.extraData.toStation}</b></span></div>
                                        <div class="d-flex article-container">
                                            ${value.itemDetails.map(item => `
                                                <div class="article-list px5px border-right">
                                                    <div class="d-flex">
                                                        <div class="">
                                                          <b>${item.totalItem}</b> out of <b>${item.itemCountPortion.length}</b> items
                                                        </div>
                                                    </div>
                                                    <div class="text-center bg-light artical-container">
                                                        ${item.articalName}
                                                    </div>
                                                </div>
                                            `).join('')}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-1 success-section-${value.code}">
                                <button class="btn btn-split none btn-${value.code} btn-sm btn-success btn"onclick="loadSplitLR('${value.code}','local');"><i class="fa fa-scissors"></i></button>
                                <button class="btn remove-btn-${value.code} btn-sm btn-danger" onclick="removeLR('${value.code}','local');">Remove </button>
                            </div>
                        </div>
                    </div>`;
                });
                localTable.append(localHtml);
            }
            let popHtml = $('.popup-split');
            popHtml.removeClass('none');
            $(popHtml).dialog({
                autoOpen: true,
                height: $(window).height() - 50,
                width: $(window).width() - 50,
                modal: true,
                resizable: false
            });
        }

        var directLoadLoadedLrsList = [];
        var linkLoadLoadedLrsList = [];
        var localTransitLoadedLrsList = [];
      
        function loadDirectLoadLr() {
            splitBtnHandle();
            directLoadLoadedLrs = [];
            var err = 0;
            $('.inp_error').removeClass('inp_error');
            var ogplRoutes = {};
            var loadToHub = true;
            if (isNotNull(OGPLEdit) && isNotNull(OGPLEdit.transitCargoDetails)) {
                $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                    if (val.transitDetailsType.code == 'DFLT') {
                        directLoadLoadedLrs = _.union(directLoadLoadedLrs, val.cargoList);
                    }
                });
            }

            if($('#direct-load-ogpl-list .ogpl-new-directload-items:checked').length === 0 && $('.custom-checkbox-group .directbox:checked').length===0) { 
                $('#transitv3-direct-load-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#transitv3-direct-load-action-state').html('Please select atleast one LR');
                $('#transitv3-direct-load-action-state').show();
                return false;
            }

            var directArticleArray = {};
            var totalDirectArticle =0;
            $('#direct-load-ogpl-list .ogpl-new-directload-items:checked').each(function (i, cb) {
                var $cb = $(cb);            
                var $tr = $cb.parents('tr:first');
                if ($tr.length > 0) {
                    var tdValue = $tr.find('td:eq(12)').text();
                    var numericValue = parseInt(tdValue, 10);
                    if (!isNaN(numericValue)) {
                        var branch = $cb.data('tobranch');
                        if (directArticleArray[branch]) {
                            directArticleArray[branch] += numericValue;
                        } else {
                            directArticleArray[branch] = numericValue;
                        }
                    }
                }
            });
            
            for (var branch in directArticleArray) {
                if (directArticleArray.hasOwnProperty(branch)) {
                    totalDirectArticle += directArticleArray[branch];
                }
            }

            var directLoadArray = {};
            $('#direct-load-ogpl-list .ogpl-new-directload-items:checked').each(function (i, cb) {
                var $cb = $(cb);            
                var $tr = $cb.parents('tr:first');            
                var transitsta = $tr.find('.direct-load-branch-sel :selected').data('station');
                var transitorg = $tr.find('.direct-load-branch-sel').val();
                directLoadArray[$cb.data('tobranch')] = (directLoadArray[$cb.data('tobranch')] || 0) + 1;

                if (transitorg == '' || isNull(transitorg)) {
                    $tr.find('.direct-load-branch-sel').addClass('inp_error');
                    ogplRoutes = {};
                    err++;
                    //return false;
                } else if( !loadToHub  && $cb.data('tobranch') != transitorg) {
                    $('#transitv3-direct-load-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#transitv3-direct-load-action-state').html($cb.val() + ' not valid for the selected "Transit To Branch"');
                    $('#transitv3-direct-load-action-state').show();
                    ogplRoutes = {};
                    return false;
                } else {
                    var route = $cb.data('from') + '-' + $cb.data('to') + '-' + transitorg;
                    if (!ogplRoutes[route]) {
                        ogplRoutes[route] = {};
                        ogplRoutes[route].cargoList = [];
                        ogplRoutes[route].from = $cb.data('oldtransitstn');
                        ogplRoutes[route].to = transitsta;
                        ogplRoutes[route].oldTransitOrg = $cb.data('oldtransitorg');
                        ogplRoutes[route].transitOrganization = transitorg;
                    }
                    ogplRoutes[route].cargoList.push($cb.val());
                }
            });

            $('.custom-checkbox-group .directbox:checked').each(function(i, cb) {
                var $cb = $(cb);
                var $tr = $cb.closest('tr');
                var $upperTr = $tr.prevAll('tr').first();
                var transitsta = $upperTr.find('.direct-load-branch-sel :selected').data('station');
                var transitorg = $upperTr.find('.direct-load-branch-sel :selected').val();

                if (transitorg == '' || isNull(transitorg)) {
                    $upperTr.find('.direct-load-branch-sel').addClass('inp_error');
                    err++;
                }else{
                    $upperTr.find('.direct-load-branch-sel').removeClass('inp_error');
                    getdirectLrsSrc();
                    gatherCheckedData();
                }
            });
           
            if(err) {            
                $('#transitv3-direct-load-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#transitv3-direct-load-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#transitv3-direct-load-action-state').show();
                return false;
            }

            if ($.isEmptyObject(ogplRoutes) && gatherCheckedData().length==0) {
                return false;
            }

            $('#transitv3-direct-load-action-state').removeClass('alert-danger').removeClass('alert-success');
            $('#transitv3-direct-load-action-state').html(loading_popup).show();
            
            var closepopupmain=false;
            var closepopupsplit=false;

            OGPLFormData.directLoadList = _.values(ogplRoutes);
            if(isNotNull(OGPLFormData.directLoadList)) {      
                $.each(OGPLFormData.directLoadList, function(k,val) {
                    directLoadLoadedLrs = _.union(directLoadLoadedLrs, val.cargoList);
                    directLoadLoadedLrsList.push(directLoadLoadedLrs);
                });
                var totalLoadedCount = _.union(directLoadLoadedLrs, linkLoadLoadedLrs, localTransitLoadedLrs, outForDeliveryLoadedLrs).length;
                directLoadCount = $('#direct-load-ogpl-list .ogpl-new-directload-items:checked').length
                $.each(directLoadArray || [], function(key,val) {
                    $('#transit-direct-load-lrs #'+key+'-to-branch').find('.direct-loaded-lr').html('('+val+')');
                });
                $.each(directArticleArray || [], function(key,val) {
                    $('#transit-direct-load-lrs #'+key+'-to-branch').find('.direct-loaded-art').html('('+val+')');
                });
                $('#direct-total-loaded-lr').html('('+directLoadCount+')');
                $('#direct-total-loaded-art').html('('+totalDirectArticle+')');
                $('#transitv3-direct-load-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#transitv3-direct-load-action-state').html('Your request processed successfully');
                $('.transit-direct-loaded').html(directLoadLoadedLrs.length < 0 ? 0 : directLoadLoadedLrs.length +'<span class="text-muted text-medium">('+directLoadCount+')</span>');
                $('#total-loaded-lrs').html(totalLoadedCount+handleSplitCount());
                
                // handleSplitCount();
                closepopupmain = true;
            } 
            if(gatherCheckedData().length>0){
                $('#transitv3-direct-load-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#transitv3-direct-load-action-state').html('Your request processed successfully');
                // handleSplitCount();
                closepopupsplit = true;
            }
            if(closepopupmain || closepopupsplit){
                closeDirectLoadLrLoadDialog();
            }
            splitBtnHandle();
        }

        function ClearDirectLoadLr() {
            directLoadCount = 0;
            directLoadLoadedLrs = [];
          
            if (isNotNull(OGPLEdit) && isNotNull(OGPLEdit.transitCargoDetails)) {
                $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                    if (val.transitDetailsType.code == 'DFLT') {
                        directLoadCount += (val.loadedCount + val.unLoadedCount);
                        directLoadLoadedLrs = _.union(directLoadLoadedLrs, val.cargoList);
                    }
                });
            }
            $('.transit-direct-loaded').html(directLoadCount);
            $('.ogpl-new-directload-items').each(function() {
                $(this).prop('checked', false);
            });
            $('#total-loaded-lrs').html(directLoadCount + linkLoadCount + localTransitCount + outForDeliveryTransitCount+handleSplitCount());
            $('.direct-loaded-lr').html('');
            $('.direct-loaded-art').html('');
            $('#direct-total-loaded-lr').html('');
            $('#direct-total-loaded-art').html('');
            $('#transit-complete-btn').addClass('hide');

            // clear split flows
            globalLrDetails = [];
            $('.custom-checkbox').each(function(){
                $(this).prop('checked', false);
            })
        }

        function selectBranchDirectLoadTransitLrs(cb, listName) {
            let localCheckedLr = localHandling();
            var $cb = $(cb);

            $('.ogpl-new-directload-items[data-listname="' + listName + '"]')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked')).prop('disabled', false)
                .trigger('change');

            $('.ogpl-new-directload-items').each(function() {
                var cargoCode = $(this).val();
                var isCargoInLocalLoad = localCheckedLr.some(function(localLoadArray) {
                    return localLoadArray.includes(cargoCode);
                });

                if (isCargoInLocalLoad) {
                    $(this).prop('checked', false).prop('disabled', true);
                    $(this).attr('title', 'Consignment loaded in another transit');
                }
            });
        }

        function scrollingDirect(letter, con) {
            var $dialogScrollContainer = $('#direct-load-load-lr-content');
            var $targetElement = $("."+con+"_leter_tr_" + letter);
            if ($targetElement.length > 0) {
                $dialogScrollContainer.animate({
                    scrollTop: $targetElement.offset().top - $dialogScrollContainer.offset().top + $dialogScrollContainer.scrollTop() - 30
                }, 500);
            } else {
                $targetElement.length;
            }
        }
        // Direct Load End

        // Link Load Start
        function transit_get_link_load_lrs() {
            var data = {};

            data.cargoActivityType = OGPLFormData.cargoActivityType;
            data.code = OGPLFormData.code;
            data.tripDate = OGPLFormData.tripDate;
            data.ogplVia = [].concat([], OGPLFormData.viaStations, [OGPLFormData.toStation]);
            data.endStation = {}
            data.endStation.code = OGPLFormData.toStation.code;
            data.endStation.name = OGPLFormData.toStation.name;
            data.viaStationCodes = [].concat(OGPLFormData.linkLoadStations).map(i => i.code).join(',');

            $('#transit-link-load-lrs').html('<tr><td colspan="3" align="center">'+loading_popup+'</td></tr>');
            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'cargo/transitv3-get-link-load-lrs',
                data: data,
                success: function (response) {
                    var summaryContent = $($.parseHTML(response)).filter("#link-load-lr-body");
                    var dialogContent = $($.parseHTML(response)).filter("#link-load-load-lr-list");
                    var alphabetContent = $($.parseHTML(response)).filter("#linkAlphabetOrder");
                    $('#link-load-btn').attr('onclick', 'loadLinkLoadLrsDialog()').prop('disabled', false);
                    $('#transit-link-load-lrs').html(summaryContent.html());
                    $('#link-load-load-lr-content').html(dialogContent.html());
                    $('#link-load-load-alphabet-content').html(alphabetContent.html());

                    printJson(data.cargoActivityType);
                    if (Array.isArray(data.cargoActivityType) && (data.cargoActivityType[1] == 'INTRNT' || data.cargoActivityType[2] == 'INTRNT')) {
                        transit_get_local_transit_lrs();
                    } else if (Array.isArray(data.cargoActivityType) && (data.cargoActivityType[1] == 'OTFD' || data.cargoActivityType[2] == 'OTFD')) {
                        transit_get_out_for_delivery_lrs();
                    }
                }
            });
        }

        function loadLinkLoadLrsDialog() {
            let localCheckedLr = localHandling();
            $('#link-load-load-lr-dialog').css('background', '#fff');
            $('#link-load-load-lr-dialog').removeClass('hide');
            $('#link-load-load-lr-dialog').dialog({
                autoOpen: true,
                height: $(window).height() - 30,
                width: $(window).width() - 100,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();
            $('#transitv3-link-load-action-state').removeClass('alert-danger').html('').hide();
            $('.inp_error').removeClass('inp_error');
            $('.ogpl-new-items').prop('checked', false).trigger('change');

            if (isNotNull(OGPLFormData.linkLoadList)) {
                $.each(OGPLFormData.linkLoadList, function(i, val) {
                    $.each(val.cargoList, function(i, cb) {
                        $('#load-ogpl-list .ogpl-new-items[value='+cb+']').prop('checked', true).trigger('change');
                        $('#load-ogpl-list .ogpl-new-items[value='+cb+']').closest('tr').find('.load-branch-sel').val(val.transitOrganization).trigger('change');
                    });
                });
            }

            $(".linkBranchSelect1").on("change", function () {
                var selectedValue = $(this).val();
                var listName = $(this).data("list-name");
                var $nextSelect = $(`.linkBranchSelect2[data-list-name="${listName}"]`);
                $nextSelect.val(selectedValue);
            });

            $('.ogpl-new-linkload-items').each(function() {
                var cargoCode = $(this).val();
                var isCargoInLocalLoad = localCheckedLr.some(function(localLoadArray) {
                    return localLoadArray.includes(cargoCode);
                });

                if (isCargoInLocalLoad) {
                    $(this).prop('disabled', true);
                    $(this).attr('title', 'Consignment loaded in another transit');
                } else if (localCheckedLr.length == 0){
                    $(this).prop('disabled', false);
                    $(this).attr('title', '');
                }
            });
            $('.ogpl-new-linkload-items').each(function() {
                var cargoCode = $(this).val();
                if ($(this).prop('disabled')) {
                    $('.row-link-' + cargoCode).hide();
                }else{
                    $('.row-link-' + cargoCode).show();
                }
            });
        }

        function closeLinkLoadLrLoadDialog() {
            $('#link-load-load-lr-dialog').addClass('hide');
            $('#link-load-load-lr-dialog').dialog('destroy');
        }

        function selectAllLinkLoadLrs(cb) {
            let localCheckedLr = localHandling();
            var $cb = $(cb);

            $('.ogpl-new-linkload-items')
                    .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                    .prop('checked', $cb.is(':checked')).prop('disabled', false)
                    .trigger('change');
                    
            $('.ogpl-new-linkload-items').each(function() {
                var cargoCode = $(this).val();
                var isCargoInLocalLoad = localCheckedLr.some(function(localLoadArray) {
                    return localLoadArray.includes(cargoCode);
                });

                if (isCargoInLocalLoad) {
                    $(this).prop('checked', false).prop('disabled', true);
                    $(this).attr('title', 'Consignment loaded in another transit');
                }
                if ($(this).prop('disabled')) {
                    $('.row-link-' + cargoCode).hide();
                }else{
                    $('.row-link-' + cargoCode).show();
                }
            });
        }

        function setAllLinkLoadTransitBranch() {
            var tsbnch = $('.link-load-branch:first').val();
            if(tsbnch==""){
                $('.link-load-branch:first').addClass('inp_error');
                return;
            }
            $('.link-load-branch:first').removeClass('inp_error');
            $('.link-load-branch').each(function () {
                this.value = tsbnch;
            });
        }

        // splitlr
        function checkHandleLink() {
            $('.ogpl-new-linkload-items:checked').each(function() {
                var cargoCode = $(this).val();
                $('.row-' + cargoCode).hide();
                $('.row-' + cargoCode).find('.linkload').prop('checked', false);
            });

            $('.ogpl-new-linkload-items:not(:checked)').each(function() {
                var cargoCode = $(this).val();  
                $('.row-' + cargoCode).show();
            });
        }

        function gatherCheckedDataLink() {
            gatheredDataLink=[];
            $('.custom-checkbox-group .linkload:checked').each(function(key,cb) {
                var $cb = $(cb);
                var $tr = $cb.closest('tr');
                var $upperTr = $tr.prevAll('tr').first();
                var transitstaName = $upperTr.find('.link-load-branch-sel :selected').data('tostationname');
                var fromStationName = $upperTr.find('.link-load-branch-sel :selected').data('fromstationname');

                var code = $(this).data('cargoid'); //cargoid
                var articalId = $(this).data('value'); //articalid
                var articalName = $(this).data('artname'); //articalname
                var articalQty=$(this).data('artqty');
                var value = $(this).val(); //itemCountPortion inArray

                var existingCargo = gatheredDataLink.find(function(obj) {
                    return obj.code === code;
                });

                if (existingCargo) {
                    var existingArticle = existingCargo.itemDetails.find(function(article) {
                        return article.code === articalId;
                    });

                    if (existingArticle) {
                        // existingArticle.itemCountPortion.push(value);
                        // existingArticle.itemCount = existingArticle.itemCountPortion.length;
                        if (!existingArticle.itemCountPortion.includes(value)) {
                            existingArticle.itemCountPortion.push(value);
                            existingArticle.itemCount = existingArticle.itemCountPortion.length;
                        }
                    } else {
                        existingCargo.itemDetails.push({
                            code: articalId,
                            articalName: articalName,
                            itemCount: 1,
                            itemCountPortion: [value],
                            "activeFlag": 1,
                            "totalItem":articalQty
                        });
                    }
                } else {
                    var dataObject = {
                        code: code,
                        itemDetails: [{
                            code: articalId,
                            articalName: articalName,
                            itemCount: 1,
                            itemCountPortion: [value],
                            "activeFlag": 1,
                            "totalItem":articalQty
                        }],
                        'type': 'link',
                        'extraData': {
                           'fromStation': fromStationName,
                           'toStation': transitstaName
                        }
                    };
                    gatheredDataLink.push(dataObject);
                }
            });
            return gatheredDataLink;
        }

        function getdirectLrsSrcLink() {
            var lrsSrc = [];
            $('.custom-checkbox-group .linkload:checked').each(function(i, cb) {
                var $cb = $(cb);
                // var $tr = $cb.closest('tr:first');
                var $tr = $cb.closest('tr'); 
                var $upperTr = $tr.prevAll('tr').first();
                var transitsta = $upperTr.find('.link-load-branch-sel :selected').data('station');
                var transitorg = $upperTr.find('.link-load-branch-sel :selected').val();
                
                // var transitorg = $('.direct-load-branch-sel').val();
                var existingIndex = lrsSrc.findIndex(function (item) {
                    return item.cargoId === $cb.data('cargoid');
                });

                if (existingIndex === -1) {
                    // If cargoId doesn't exist, add a new object to lrsSrc array
                    var obj = {
                        cargoId: $cb.data('cargoid'),
                        from: $cb.data('oldtransitstn'),
                        to: transitsta,
                        oldTransitOrg: $cb.data('oldtransitorg'),
                        transitOrganization: transitorg
                    };
                    lrsSrc.push(obj);
                } else {
                    lrsSrc[existingIndex].from = $cb.data('oldtransitstn');
                    lrsSrc[existingIndex].to = transitsta;
                    lrsSrc[existingIndex].oldTransitOrg = $cb.data('oldtransitorg');
                    lrsSrc[existingIndex].transitOrganization = transitorg;
                }
            });
            return lrsSrc;
        }
        // if splited LR not choose an branch show error

        function loadLinkLoadLr() {
            splitBtnHandle();
            linkLoadLoadedLrs = [];
            var err = 0;
            $('.inp_error').removeClass('inp_error');
            var ogplRoutes = {};
            var loadToHub = true;
            if (isNotNull(OGPLEdit) && isNotNull(OGPLEdit.transitCargoDetails)) {
                $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                    if (val.transitDetailsType.code == 'HULD') {
                        linkLoadLoadedLrs = _.union(linkLoadLoadedLrs, val.cargoList);
                    }
                });
            }
            if($('#link-load-ogpl-list .ogpl-new-linkload-items:checked').length === 0 && $('.custom-checkbox-group .linkload:checked').length===0) {
                $('#transitv3-link-load-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#transitv3-link-load-action-state').html('Please select atleast one LR');
                $('#transitv3-link-load-action-state').show();
                return false;
            }

            var linkLoadArticleArray = {};
            var totalLinkLoadArticle =0;
            $('#link-load-ogpl-list .ogpl-new-linkload-items:checked').each(function (i, cb) {
                var $cb = $(cb);            
                var $tr = $cb.parents('tr:first');
                if ($tr.length > 0) {
                    var tdValue = $tr.find('td:eq(12)').text();
                    var numericValue = parseInt(tdValue, 10);
                    if (!isNaN(numericValue)) {
                        var branch = $cb.data('tobranch');
                        if (linkLoadArticleArray[branch]) {
                            linkLoadArticleArray[branch] += numericValue;
                        } else {
                            linkLoadArticleArray[branch] = numericValue;
                        }
                    }
                }
            });
            
            for (var branch in linkLoadArticleArray) {
                if (linkLoadArticleArray.hasOwnProperty(branch)) {
                    totalLinkLoadArticle += linkLoadArticleArray[branch];
                }
            }

            var linkLoadArray = {};
            $('#link-load-ogpl-list .ogpl-new-linkload-items:checked').each(function (i, cb) {
                var $cb = $(cb);            
                var $tr = $cb.parents('tr:first');            
                var transitsta = $tr.find('.link-load-branch-sel :selected').data('station');
                var transitorg = $tr.find('.link-load-branch-sel').val();
                linkLoadArray[$cb.data('tobranch')] = (linkLoadArray[$cb.data('tobranch')] || 0) + 1;

                if (transitorg == '') {
                    $tr.find('.link-load-branch-sel').addClass('inp_error');
                    ogplRoutes = {};
                    err++;
                    //return false;
                } else if( !loadToHub  && $cb.data('tobranch') != transitorg) {
                    $('#transitv3-link-load-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#transitv3-link-load-action-state').html($cb.val() + ' not valid for the selected "Transit To Branch"');
                    $('#transitv3-link-load-action-state').show();
                    ogplRoutes = {};
                    return false;
                } else {
                    var route = $cb.data('from') + '-' + $cb.data('to') + '-' + transitorg;
                    if (!ogplRoutes[route]) {
                        ogplRoutes[route] = {};
                        ogplRoutes[route].cargoList = [];
                        ogplRoutes[route].from = $cb.data('oldtransitstn');
                        ogplRoutes[route].to = transitsta;
                        ogplRoutes[route].oldTransitOrg = $cb.data('oldtransitorg');
                        ogplRoutes[route].transitOrganization = transitorg;
                    }
                    ogplRoutes[route].cargoList.push($cb.val());
                }
            });
            $('.custom-checkbox-group .linkload:checked').each(function(i, cb) {
                var $cb = $(cb);
                var $tr = $cb.closest('tr');
                var $upperTr = $tr.prevAll('tr').first();
                var transitsta = $upperTr.find('.link-load-branch-sel :selected').data('station');
                var transitorg = $upperTr.find('.link-load-branch-sel').val();

                if (transitorg == '' || isNull(transitorg)) {
                    $upperTr.find('.link-load-branch-sel').addClass('inp_error');
                    err++;
                }else{
                    $upperTr.find('.link-load-branch-sel').removeClass('inp_error');
                    getdirectLrsSrcLink();
                    gatherCheckedDataLink();
                }
            });

            if(err) {            
                $('#transitv3-link-load-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#transitv3-link-load-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#transitv3-link-load-action-state').show();
                return false;
            }
            if ($.isEmptyObject(ogplRoutes) && gatherCheckedDataLink().length==0) {
                return false;
            }

            $('#transitv3-link-load-action-state').removeClass('alert-danger').removeClass('alert-success');
            $('#transitv3-link-load-action-state').html(loading_popup).show();

            var closepopupmain = false;
            var closepopupsplit = false;

            OGPLFormData.linkLoadList = _.values(ogplRoutes);
            if (isNotNull(OGPLFormData.linkLoadList)) {    
                $.each(OGPLFormData.linkLoadList, function(k,val) {
                    linkLoadLoadedLrs = _.union(linkLoadLoadedLrs, val.cargoList);
                    linkLoadLoadedLrsList.push(linkLoadLoadedLrs);
                });
                var totalLoadedCount = _.union(directLoadLoadedLrs, linkLoadLoadedLrs, localTransitLoadedLrs, outForDeliveryLoadedLrs).length;
                linkLoadCount = $('#link-load-ogpl-list .ogpl-new-linkload-items:checked').length
                $.each(linkLoadArray || [], function(key,val) {
                    $('#transit-link-load-lrs #'+key+'-to-branch').find('.link-loaded-lr').html('('+val+')');
                });
                $.each(linkLoadArticleArray || [], function(key,val) {
                    $('#transit-link-load-lrs #'+key+'-to-branch').find('.link-loaded-art').html('('+val+')');
                });
                $('#link-total-loaded-lr').html('('+linkLoadCount+')');
                $('#link-total-loaded-art').html('('+totalLinkLoadArticle+')');
                $('#transitv3-link-load-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#transitv3-link-load-action-state').html('Your request processed successfully');
                $('.transit-link-loaded').html(linkLoadLoadedLrs.length < 0 ? 0 : linkLoadLoadedLrs.length+'<span class="text-muted text-medium">('+linkLoadCount+')</span>');
                $('#total-loaded-lrs').html(totalLoadedCount+handleSplitCount());
                $('#transit-complete-btn').removeClass('hide');
                closepopupmain = true;
            } 
            if(gatherCheckedDataLink().length>0){
                $('#transitv3-link-load-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#transitv3-link-load-action-state').html('Your request processed successfully');
                closepopupsplit = true;
                // handleSplitCount();
            }
            if(closepopupmain || closepopupsplit) {
                closeLinkLoadLrLoadDialog();
            }
            splitBtnHandle();
        }

        function ClearLinkLoadLr() {
            linkLoadCount = 0;
            linkLoadLoadedLrs = [];
            if (isNotNull(OGPLEdit) && isNotNull(OGPLEdit.transitCargoDetails)) {
                $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                    if (val.transitDetailsType.code == 'HULD') {
                        linkLoadCount += (val.loadedCount + val.unLoadedCount);
                        linkLoadLoadedLrs = _.union(linkLoadLoadedLrs, val.cargoList);
                    }
                });
            }   
            $('.transit-link-loaded').html(linkLoadCount);
            $('.ogpl-new-linkload-items').each(function() {
                $(this).prop('checked', false);
            });
            $('#total-loaded-lrs').html(directLoadCount + linkLoadCount + localTransitCount + outForDeliveryTransitCount+handleSplitCount());
            $('.link-loaded-lr').html('');
            $('.link-loaded-art').html('');
            $('#link-total-loaded-lr').html('');
            $('#link-total-loaded-art').html('');
            $('#transit-complete-btn').addClass('hide');
        }

        function selectBranchLinkLoadTransitLrs(cb, listName) {
            let localCheckedLr = localHandling();
            var $cb = $(cb);

            $('.ogpl-new-linkload-items[data-listname="' + listName + '"]')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked')).prop('disabled', false)
                .trigger('change');
                    
            $('.ogpl-new-linkload-items').each(function() {
                var cargoCode = $(this).val();
                var isCargoInLocalLoad = localCheckedLr.some(function(localLoadArray) {
                    return localLoadArray.includes(cargoCode);
                });

                if (isCargoInLocalLoad) {
                    $(this).prop('checked', false).prop('disabled', true);
                    $(this).attr('title', 'Consignment loaded in another transit');
                }
            });
        }

        function scrollingLink(letter, con) {
            var $dialogScrollContainer = $('#link-load-load-lr-content');
            var $targetElement = $("."+con+"_leter_tr_" + letter);
            if ($targetElement.length > 0) {
                $dialogScrollContainer.animate({
                    scrollTop: $targetElement.offset().top - $dialogScrollContainer.offset().top + $dialogScrollContainer.scrollTop() - 30
                }, 500);
            } else {
                $targetElement.length;
            }
        }
        // Link Load End

        // Local Transit Start
        function transit_get_local_transit_lrs() {
            let call = false;
            var data = {};
            data.cargoActivityType = OGPLFormData.cargoActivityType;
            data.code = OGPLFormData.code;
            data.tripDate = OGPLFormData.tripDate;
            data.ogplVia = OGPLFormData.localViaOrganizations;
            data.endStation = {}
            data.endStation.code = OGPLFormData.toStation.code;
            data.endStation.name = OGPLFormData.toStation.name;

            //all logged in station users branches
            let isBranch=branches.filter((item)=>{
                return item.station.code === user_login_station;
            });

            //select branched matches with logged in branch
            let filteredLocalViaOrganizations = OGPLFormData.localViaOrganizations.filter((item) => {
                return isBranch.some(branch => branch.code === item.code);
            });
            if (filteredLocalViaOrganizations.length === 0) {
                data.viaStationCodes = [];
            } else {
                if(localLoad != "HIDE"){
                    call = true;
                }
                data.viaStationCodes = [].concat(filteredLocalViaOrganizations).map(i => i.code).join(',');
            }
           
            if(isBranch.length > 1 && call){
                $('#transit-local-transit-lrs').html('<tr><td colspan="3" align="center">'+loading_popup+'</td></tr>');
                $.ajax({
                    type: 'POST',
                    dataType: 'html',
                    url: base_url + 'cargo/transitv3-get-local-transit-lrs',
                    data: data,
                    success: function (response) {
                        var summaryContent = $($.parseHTML(response)).filter("#local-transit-lr-body");
                        var dialogContent = $($.parseHTML(response)).filter("#local-transit-load-lr-list");
                        var alphabetContent = $($.parseHTML(response)).filter("#localAlphabetOrder");
                        $('#local-load-btn').attr('onclick', 'loadLocalTransitLrsDialog()').prop('disabled', false);
                        $('#transit-local-transit-lrs').html(summaryContent.html());
                        $('#local-transit-load-lr-content').html(dialogContent.html());
                        $('#local-transit-load-alphabet-content').html(alphabetContent.html());
                        if (Array.isArray(data.cargoActivityType) && data.cargoActivityType[1] == 'OTFD' || data.cargoActivityType[2] == 'OTFD' || data.cargoActivityType[3] == 'OTFD') {
                            transit_get_out_for_delivery_lrs();
                        }
                    }
                });
            }else{
                $('#local-load-btn').prop('disabled','true');
            }
        }

        function loadLocalTransitLrsDialog() {
            let linkCheckedLr = linkHandling();
            let directCheckedLr = directHandling();
            let oftCheckedLr = oftHandling()
            $('#local-transit-load-lr-dialog').css('background', '#fff');
            $('#local-transit-load-lr-dialog').removeClass('hide');
            $('#local-transit-load-lr-dialog').dialog({
                autoOpen: true,
                height: $(window).height() - 30,
                width: $(window).width() - 100,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();
            $('#transitv3-local-transit-action-state').removeClass('alert-danger').html('').hide();
            $('.inp_error').removeClass('inp_error');
            $('.ogpl-new-items').prop('checked', false).trigger('change');

            if (isNotNull(OGPLFormData.localTransitList)) {
                $.each(OGPLFormData.localTransitList, function(i, val) {
                    $.each(val.cargoList, function(i, cb) {
                        $('#load-ogpl-list .ogpl-new-items[value='+cb+']').prop('checked', true).trigger('change');
                        $('#load-ogpl-list .ogpl-new-items[value='+cb+']').closest('tr').find('.load-branch-sel').val(val.transitOrganization).trigger('change');
                    });
                });
            }

            $(".localBranchSelect1").on("change", function () {
                var selectedValue = $(this).val();
                var listName = $(this).data("list-name");
                var $nextSelect = $(`.localBranchSelect2[data-list-name="${listName}"]`);
                $nextSelect.val(selectedValue);
            });

            $('.ogpl-new-localLoad-items').each(function() {
                var cargoCode = $(this).val();
                var isCargoInDirectLoad = directCheckedLr.some(function(directLoadArray) {
                    return directLoadArray.includes(cargoCode);
                });

                var isCargoInLinkLoad = linkCheckedLr.some(function(linkLoadArray) {
                    return linkLoadArray.includes(cargoCode);
                });
                var isCargoInOftLoad = oftCheckedLr.some(function(oftLoadArray) {
                    return oftLoadArray.includes(cargoCode);
                });


                if (isCargoInDirectLoad || isCargoInLinkLoad || isCargoInOftLoad) {
                    $(this).prop('disabled', true);
                    $(this).attr('title', 'Consignment loaded in another transit');
                } else if (directCheckedLr.length == 0 || linkCheckedLr.length == 0){
                    $(this).prop('disabled', false);
                    $(this).attr('title', '');
                }
            });

            $('.ogpl-new-localLoad-items').each(function() {
                var cargoCode = $(this).val();
                if ($(this).prop('disabled')) {
                    $('.row-local-' + cargoCode).hide();
                }else{
                    $('.row-local-' + cargoCode).show();
                }
            });
        }

        function closeLocalTransitLrLoadDialog() {
            $('#local-transit-load-lr-dialog').addClass('hide');
            $('#local-transit-load-lr-dialog').dialog('destroy');
        }

        function selectAllLocalTransitLrs(cb) {
            let linkCheckedLr = linkHandling();
            let directCheckedLr = directHandling();
            var $cb = $(cb);

            $('.ogpl-new-localLoad-items')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked')).prop('disabled', false)
                .trigger('change');
            
            $('.ogpl-new-localLoad-items').each(function () {
                var cargoCode = $(this).val();
                var isCargoInDirectLoad = directCheckedLr.some(function (directLoadArray) {
                    return directLoadArray.includes(cargoCode);
                });

                var isCargoInLinkLoad = linkCheckedLr.some(function (linkLoadArray) {
                    return linkLoadArray.includes(cargoCode);
                });

                if (isCargoInDirectLoad || isCargoInLinkLoad) {
                    $(this).prop('checked', false).prop('disabled', true).trigger('change');
                    $(this).attr('title', 'Consignment loaded in another transit');
                }
            });
        }

        function setAllLocalTransitBranch() {
            var tsbnch = $('.local-transit-branch:first').val();
            if(tsbnch==""){
                $('.local-transit-branch:first').addClass('inp_error');
                return;
            }
            $('.local-transit-branch:first').removeClass('inp_error');
            $('.local-transit-branch').each(function () {
                this.value = tsbnch;
            });
        }

        //splitlr flow
        function checkHandleLocal() {
            $('.ogpl-new-localLoad-items').each(function() {
                var cargoCode = $(this).val();

                if ($(this).is(':checked')) {
                    $('.row-' + cargoCode).hide();
                    $('.row-' + cargoCode).find('.localload').prop('checked', false);
                }
                else if($(this).is(':disabled')) {
                    $('.row-local-' + cargoCode).hide();
                } else {
                    $('.row-' + cargoCode).show();
                }
            });
        }

        function gatherCheckedDataLocal() {
            gatheredDataLocal = [];
            $('.custom-checkbox-group .localload:checked').each(function (key, cb) {
                var $cb = $(cb);
                var $tr = $cb.closest('tr');
                var $upperTr = $tr.prevAll('tr').first();
                var transitstaName = $upperTr.find('.local-transit-branch-sel :selected').data('tostationname');
                var fromStationName = $upperTr.find('.local-transit-branch-sel :selected').data('fromstationname');

                var code = $(this).data('cargoid'); //cargoid
                var articalId = $(this).data('value'); //articalid
                var articalName = $(this).data('artname'); //articalname
                var articalQty=$(this).data('artqty');
                var value = $(this).val(); //itemCountPortion inArray

                var existingCargo = gatheredDataLocal.find(function (obj) {
                    return obj.code === code;
                });

                if (existingCargo) {
                    var existingArticle = existingCargo.itemDetails.find(function (article) {
                        return article.code === articalId;
                    });

                    if (existingArticle) {
                        if (!existingArticle.itemCountPortion.includes(value)) {
                            existingArticle.itemCountPortion.push(value);
                            existingArticle.itemCount = existingArticle.itemCountPortion.length;
                        }
                    } else {
                        existingCargo.itemDetails.push({
                            code: articalId,
                            articalName: articalName,
                            itemCount: 1,
                            itemCountPortion: [value],
                            "activeFlag": 1,
                            "totalItem":articalQty
                        });
                    }
                } else {
                    var dataObject = {
                        code: code,
                        itemDetails: [{
                            code: articalId,
                            "articalName": articalName,
                            itemCount: 1,
                            itemCountPortion: [value],
                            "activeFlag": 1,
                            "totalItem":articalQty
                        }],
                        'type': 'local',
                        'extraData': {
                            'fromStation': fromStationName, // Assign fromStationName here
                            'toStation': transitstaName // Assign transitstaName here
                        }
                    };
                    gatheredDataLocal.push(dataObject);
                }
            });
            return gatheredDataLocal;
        }


        function getdirectLrsSrcLocal() {
            var lrsSrc = [];
            $('.custom-checkbox-group .localload:checked').each(function(i, cb) {
                var $cb = $(cb);
                // var $tr = $cb.closest('tr:first');
                var $tr = $cb.closest('tr'); 
                var $upperTr = $tr.prevAll('tr').first();
                
                // var transitsta = $upperTr.find('.local-transit-branch-sel').val();
                var transitsta = $upperTr.find('.local-transit-branch-sel :selected').data('station');
                var transitorg = $upperTr.find('.local-transit-branch-sel :selected').val();
                var existingIndex = lrsSrc.findIndex(function (item) {
                    return item.cargoId === $cb.data('cargoid');
                });

                if (existingIndex === -1) {
                    var obj = {
                        cargoId: $cb.data('cargoid'),
                        from: $cb.data('oldtransitstn'),
                        to: transitsta,
                        oldTransitOrg: $cb.data('oldtransitorg'),
                        transitOrganization: transitorg
                    };
                    lrsSrc.push(obj);
                } else {
                    lrsSrc[existingIndex].from = $cb.data('oldtransitstn');
                    lrsSrc[existingIndex].to = transitsta;
                    lrsSrc[existingIndex].oldTransitOrg = $cb.data('oldtransitorg');
                    lrsSrc[existingIndex].transitOrganization = transitorg;
                }
            });
            return lrsSrc;
        }
      
        function loadLocalTransitLr() {
            localTransitLoadedLrs = [];
            var err = 0;
            $('.inp_error').removeClass('inp_error');
            var ogplRoutes = {};
            var loadToHub = true;
            if (isNotNull(OGPLEdit) && isNotNull(OGPLEdit.transitCargoDetails)) {
                $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                    if (val.transitDetailsType.code == 'LCLD') {
                        localTransitLoadedLrs = _.union(localTransitLoadedLrs, val.cargoList);
                    }
                });
            }
            
            if($('#local-transit-ogpl-list .ogpl-new-localLoad-items:checked').length === 0 && $('.custom-checkbox-group .localload:checked').length===0) {
                $('#transitv3-local-transit-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#transitv3-local-transit-action-state').html('Please select atleast one LR');
                $('#transitv3-local-transit-action-state').show();
                return false;
            }

            var localTransitArticleArray = {};
            var totalLocalTransitArticle =0;
            $('#local-transit-ogpl-list .ogpl-new-localLoad-items:checked').each(function (i, cb) {
                var $cb = $(cb);            
                var $tr = $cb.parents('tr:first');
                if ($tr.length > 0) {
                    var tdValue = $tr.find('td:eq(12)').text();
                    var numericValue = parseInt(tdValue, 10);
                    if (!isNaN(numericValue)) {
                        var branch = $cb.data('tobranch');
                        if (localTransitArticleArray[branch]) {
                            localTransitArticleArray[branch] += numericValue;
                        } else {
                            localTransitArticleArray[branch] = numericValue;
                        }
                    }
                }
            });
            
            for (var branch in localTransitArticleArray) {
                if (localTransitArticleArray.hasOwnProperty(branch)) {
                    totalLocalTransitArticle += localTransitArticleArray[branch];
                }
            }

            var LocalTransitArray = {};
            $('#local-transit-ogpl-list .ogpl-new-localLoad-items:checked').each(function (i, cb) {
                var $cb = $(cb);            
                var $tr = $cb.parents('tr:first');            
                var transitsta = $tr.find('.local-transit-branch-sel :selected').data('station');
                var transitorg = $tr.find('.local-transit-branch-sel').val();
                LocalTransitArray[$cb.data('tobranch')] = (LocalTransitArray[$cb.data('tobranch')] || 0) + 1;

                if (transitorg == '') {
                    $tr.find('.local-transit-branch-sel').addClass('inp_error');
                    ogplRoutes = {};
                    err++;
                    //return false;
                } else if( !loadToHub  && $cb.data('tobranch') != transitorg) {
                    $('#transitv3-local-transit-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#transitv3-local-transit-action-state').html($cb.val() + ' not valid for the selected "Transit To Branch"');
                    $('#transitv3-local-transit-action-state').show();
                    ogplRoutes = {};
                    return false;
                } else {
                    var route = $cb.data('from') + '-' + $cb.data('to') + '-' + transitorg;
                    if (!ogplRoutes[route]) {
                        ogplRoutes[route] = {};
                        ogplRoutes[route].cargoList = [];
                        ogplRoutes[route].from = $cb.data('oldtransitstn');
                        ogplRoutes[route].to = transitsta;
                        ogplRoutes[route].oldTransitOrg = $cb.data('oldtransitorg');
                        ogplRoutes[route].transitOrganization = transitorg;
                    }
                    ogplRoutes[route].cargoList.push($cb.val());
                }
            });
            $('.custom-checkbox-group .localload:checked').each(function(i, cb) {
                var $cb = $(cb);
                var $tr = $cb.closest('tr');
                var $upperTr = $tr.prevAll('tr').first();
                var transitsta = $upperTr.find('.local-transit-branch-sel :selected').data('station');
                var transitorg = $upperTr.find('.local-transit-branch-sel :selected').val();

                if (transitorg == '' || isNull(transitorg)) {
                    $upperTr.find('.local-transit-branch-sel').addClass('inp_error');
                    err++;
                }else{
                    $upperTr.find('.local-transit-branch-sel').removeClass('inp_error');
                    getdirectLrsSrcLocal();
                    gatherCheckedDataLocal();
                }
            });
            
            if(err) {            
                $('#transitv3-local-transit-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#transitv3-local-transit-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#transitv3-local-transit-action-state').show();
                return false;
            }

            if ($.isEmptyObject(ogplRoutes) && gatherCheckedDataLocal().length==0) {
                return false;
            }

            $('#transitv3-local-transit-action-state').removeClass('alert-danger').removeClass('alert-success');
            $('#transitv3-local-transit-action-state').html(loading_popup).show();

            var closepopupmain=false;
            var closepopupsplit=false;
            
            OGPLFormData.localTransitList = _.values(ogplRoutes);
            if (isNotNull(OGPLFormData.localTransitList)) {    
                $.each(OGPLFormData.localTransitList, function(k,val) {
                    localTransitLoadedLrs = _.union(localTransitLoadedLrs, val.cargoList);
                    localTransitLoadedLrsList.push(localTransitLoadedLrs);
                });

                var totalLoadedCount = _.union(directLoadLoadedLrs, linkLoadLoadedLrs, localTransitLoadedLrs, outForDeliveryLoadedLrs).length;
                localTransitCount = $('#local-transit-ogpl-list .ogpl-new-localLoad-items:checked').length
                $.each(LocalTransitArray || [], function(key,val) {
                    $('#transit-local-transit-lrs #'+key+'-to-branch').find('.local-transit-loaded-lr').html('('+val+')');
                });
                $.each(localTransitArticleArray || [], function(key,val) {
                    $('#transit-local-transit-lrs #'+key+'-to-branch').find('.local-transit-loaded-art').html('('+val+')');
                });
                $('#local-transit-total-loaded-lr').html('('+localTransitCount+')');
                $('#local-transit-total-loaded-art').html('('+totalLocalTransitArticle+')');
                $('#transitv3-local-transit-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#transitv3-local-transit-action-state').html('Your request processed successfully');
                
                $('.transit-local-transit-loaded').html(localTransitLoadedLrs.length < 0 ? 0 : localTransitLoadedLrs.length+'<span class="text-muted text-medium">('+localTransitCount+')</span>');
                $('#total-loaded-lrs').html(totalLoadedCount+handleSplitCount());
                $('#transit-complete-btn').removeClass('hide');
                closepopupmain = true;
            } 
            if(gatherCheckedDataLocal().length>0){
                $('#transitv3-local-load-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#transitv3-local-load-action-state').html('Your request processed successfully');
                // handleSplitCount();
                closepopupsplit = true;
            }
            if(closepopupmain || closepopupsplit){
                closeLocalTransitLrLoadDialog();
            }
            splitBtnHandle();
        }

        function ClearLocalLoadLr() {
            localTransitCount = 0;
            localTransitLoadedLrs = [];
            if (isNotNull(OGPLEdit) && isNotNull(OGPLEdit.transitCargoDetails)) {
                $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                    if (val.transitDetailsType.code == 'LCLD') {
                        localTransitCount += (val.loadedCount + val.unLoadedCount);
                        localTransitLoadedLrs = _.union(localTransitLoadedLrs, val.cargoList);
                    }
                });
            }
            $('.transit-local-transit-loaded').html(localTransitCount);
            $('.ogpl-new-localLoad-items').each(function() {
                $(this).prop('checked', false);
            });
            $('#total-loaded-lrs').html(directLoadCount + linkLoadCount + localTransitCount + outForDeliveryTransitCount+handleSplitCount());
            $('.local-transit-loaded-lr').html('');
            $('.local-transit-loaded-art').html('');
            $('#local-transit-total-loaded-lr').html('');
            $('#local-transit-total-loaded-art').html('');
            $('#transit-complete-btn').addClass('hide');

            // clear local split LRs start
            $('.localload').each(function() {
                $(this).prop('checked', false);
                $('.row-local').show();
            });
            gatherCheckedDataLocal();
            splitBtnHandle();
            //clear local split LRs end
        }

        function selectBranchLocalTransitLrs(cb, listName) {
            let linkCheckedLr = linkHandling();
            let directCheckedLr = directHandling();
            var $cb = $(cb);
            $('.ogpl-new-localLoad-items[data-listname="' + listName + '"]')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked')).prop('disabled', false)
                .trigger('change');
            
            $('.ogpl-new-localLoad-items').each(function () {
                var cargoCode = $(this).val();
                var isCargoInDirectLoad = directCheckedLr.some(function (directLoadArray) {
                    return directLoadArray.includes(cargoCode);
                });

                var isCargoInLinkLoad = linkCheckedLr.some(function (linkLoadArray) {
                    return linkLoadArray.includes(cargoCode);
                });

                if (isCargoInDirectLoad || isCargoInLinkLoad) {
                    $(this).prop('checked', false).prop('disabled', true).trigger('change');
                    $(this).attr('title', 'Consignment loaded in another transit');
                }
            });
        }

        function scrollingLocal(letter, con) {
            var $dialogScrollContainer = $('#local-transit-load-lr-content');
            var $targetElement = $("."+con+"_leter_tr_" + letter);

             if ($targetElement.length > 0) {
                $dialogScrollContainer.animate({
                    scrollTop:
                        $targetElement.offset().top -
                        $dialogScrollContainer.offset().top +
                        $dialogScrollContainer.scrollTop() -
                        30,
                    },
                    500
                );
            } else {
               $targetElement.length;
            }
        }
        // Local Transit End

        // Out for Delivery Start
        function transit_get_out_for_delivery_lrs() {
            var data = {};
            data.cargoActivityType = OGPLFormData.cargoActivityType;
            data.code = OGPLFormData.code;
            data.tripDate = OGPLFormData.tripDate;
            data.ogplVia = OGPLFormData.localViaOrganizations;
            data.endStation = {}
            data.endStation.code = OGPLFormData.toStation.code;
            data.endStation.name = OGPLFormData.toStation.name;
            data.viaStationCodes = [].concat(OGPLFormData.localViaOrganizations).map(i => i.code).join(',');

            $('#transit-out-for-delivery-lrs').html('<tr><td colspan="3" align="center">'+loading_popup+'</td></tr>');
            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'cargo/transitv3-get-out-for-delivery-transit-lrs',
                data: data,
                success: function (response) {
                    var summaryContent = $($.parseHTML(response)).filter("#out-for-delivery-lr-body");
                    var dialogContent = $($.parseHTML(response)).filter("#out-for-delivery-load-lr-list");
                    var alphabetContent = $($.parseHTML(response)).filter("#outForDeliveryAlphabetOrder");
                    $('#out-for-delivery-load-btn').attr('onclick', 'outForDeliveryLrsDialog()').prop('disabled', false);
                    $('#transit-out-for-delivery-lrs').html(summaryContent.html());
                    $('#out-for-delivery-load-lr-content').html(dialogContent.html());
                    $('#out-for-delivery-load-alphabet-content').html(alphabetContent.html());
                }
            });
        }

        function outForDeliveryLrsDialog() {
                let localCheckedLr = localHandling();
                $('#out-for-delivery-load-lr-dialog').css('background', '#fff');
                $('#out-for-delivery-load-lr-dialog').removeClass('hide');
                $('#out-for-delivery-load-lr-dialog').dialog({
                    autoOpen: true,
                    height: $(window).height() - 30,
                    width: $(window).width() - 100,
                    modal: true,
                    resizable: false,
                    closeOnEscape: true
                });
                $('.ui-dialog-titlebar').hide();
                $('#transitv3-out-for-delivery-action-state').removeClass('alert-danger').html('').hide();
                $('.inp_error').removeClass('inp_error');
                $('.ogpl-new-items').prop('checked', false).trigger('change');

                if (isNotNull(OGPLFormData.outForDeliveryList)) {
                    $.each(OGPLFormData.outForDeliveryList, function(i, val) {
                        $.each(val.cargoList, function(i, cb) {
                            $('#load-ogpl-list .ogpl-new-items[value=' + cb + ']').prop('checked', true).trigger('change');
                            $('#load-ogpl-list .ogpl-new-items[value=' + cb + ']').closest('tr').find('.load-branch-sel').val(val.transitOrganization).trigger('change');
                        });
                    });
                }

                $('#out-for-delivery-ogpl-list .ogpl-new-outfordelivery-items').each(function() {
                    var cargoCode = $(this).val();
                    if (localCheckedLr.includes(cargoCode)) {
                        $(this).prop('disabled', true).attr('title', 'Consignment loaded in another transit');
                        $('.row-direct-' + cargoCode).hide();
                    } else {
                        $(this).prop('disabled', false).attr('title', '');
                        $('.row-direct-' + cargoCode).show();
                    }
                });
            }

        function closeOutForDeliveryLrLoadDialog() {
            $('#out-for-delivery-load-lr-dialog').addClass('hide');
            $('#out-for-delivery-load-lr-dialog').dialog('destroy');
        }

        function selectAllOutForDeliveryTransitLrs(cb) {
            var $cb = $(cb);
            $('.ogpl-new-outfordelivery-items')
                    .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                    .prop('checked', $cb.is(':checked'))
                    .trigger('change');
        }

        function selectBranchOutForDeliveryTransitLrs(cb, listName) {
            var $cb = $(cb);
            $('.ogpl-new-outfordelivery-items[data-listname="' + listName + '"]')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked'))
                .trigger('change');
        }


        function loadOutForDeliveryTransitLr() {
            outForDeliveryLoadedLrs = [];
            var err = 0;
            $('.inp_error').removeClass('inp_error');
            var ogplRoutes = {};
            var loadToHub = true;
            if (isNotNull(OGPLEdit) && isNotNull(OGPLEdit.transitCargoDetails)) {
                $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                    if (val.transitDetailsType.code == 'OFDLD') {
                        outForDeliveryLoadedLrs = _.union(outForDeliveryLoadedLrs, val.cargoList);
                    }
                });
            }
            
            if($('#out-for-delivery-ogpl-list .ogpl-new-outfordelivery-items:checked').length === 0) {
                $('#transitv3-out-for-delivery-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#transitv3-out-for-delivery-action-state').html('Please select atleast one LR');
                $('#transitv3-out-for-delivery-action-state').show();
                return false;
            }

            var outForDeliveryArticleArray = {};
            var totalOutForDeliveryArticle = 0;
            $('#out-for-delivery-ogpl-list .ogpl-new-outfordelivery-items:checked').each(function (i, cb) {
                var $cb = $(cb);            
                var $tr = $cb.parents('tr:first');
                if ($tr.length > 0) {
                    var tdValue = $tr.find('td:eq(11)').text();
                    var numericValue = parseInt(tdValue, 10);
                    if (!isNaN(numericValue)) {
                        var branch = $cb.data('tobranch');
                        if (outForDeliveryArticleArray[branch]) {
                            outForDeliveryArticleArray[branch] += numericValue;
                        } else {
                            outForDeliveryArticleArray[branch] = numericValue;
                        }
                    }
                }
            });
            
            for (var branch in outForDeliveryArticleArray) {
                if (outForDeliveryArticleArray.hasOwnProperty(branch)) {
                    totalOutForDeliveryArticle += outForDeliveryArticleArray[branch];
                }
            }

            var outForDeliveryArray = {};
            $('#out-for-delivery-ogpl-list .ogpl-new-outfordelivery-items:checked').each(function (i, cb) {
                var $cb = $(cb);            
                var $tr = $cb.parents('tr:first');            
                var transitsta = $tr.find('.out-for-delivery-branch-sel :selected').data('station');
                outForDeliveryArray[$cb.data('tobranch')] = (outForDeliveryArray[$cb.data('tobranch')] || 0) + 1;

                if ($cb.data('to')) {
                    var route = $cb.data('from') + '-' + $cb.data('to') + '-' + $cb.data('oldtransitorg');
                    if (!ogplRoutes[route]) {
                        ogplRoutes[route] = {};
                        ogplRoutes[route].cargoList = [];
                        ogplRoutes[route].from = $cb.data('oldtransitstn');
                        ogplRoutes[route].to = $cb.data('oldtransitstn');
                        ogplRoutes[route].oldTransitOrg = $cb.data('oldtransitorg');
                        ogplRoutes[route].transitOrganization = $cb.data('oldtransitorg');
                    }
                    ogplRoutes[route].cargoList.push($cb.val());
                } else {
                    $('#transitv3-out-for-delivery-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#transitv3-out-for-delivery-action-state').html($cb.val() + ' not valid for the selected "Transit To Branch"');
                    $('#transitv3-out-for-delivery-action-state').show();
                    ogplRoutes = {};
                    return false;
                } 
            });
            
            if(err) {            
                $('#transitv3-out-for-delivery-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#transitv3-out-for-delivery-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#transitv3-out-for-delivery-action-state').show();
                return false;
            }

            if ($.isEmptyObject(ogplRoutes)) {
                return false;
            }

            $('#transitv3-out-for-delivery-action-state').removeClass('alert-danger').removeClass('alert-success');
            $('#transitv3-out-for-delivery-action-state').html(loading_popup).show();
            // $('#load-to-ogpl-btn').prop('disabled', true);

            // var data = OGPLFormData;
            OGPLFormData.outForDeliveryList = _.values(ogplRoutes);
            if (isNotNull(OGPLFormData.outForDeliveryList)) {    
                $.each(OGPLFormData.outForDeliveryList, function(k,val) {
                    outForDeliveryLoadedLrs = _.union(outForDeliveryLoadedLrs, val.cargoList);
                });

                var totalLoadedCount = _.union(directLoadLoadedLrs, linkLoadLoadedLrs, localTransitLoadedLrs, outForDeliveryLoadedLrs).length;
                outForDeliveryTransitCount = $('#out-for-delivery-ogpl-list .ogpl-new-outfordelivery-items:checked').length
                $.each(outForDeliveryArray || [], function(key,val) {
                    $('#transit-out-for-delivery-lrs #'+key+'-to-branch').find('.out-for-delivery-loaded-lr').html('('+val+')');
                });
                $.each(outForDeliveryArticleArray || [], function(key,val) {
                    $('#transit-out-for-delivery-lrs #'+key+'-to-branch').find('.out-for-delivery-loaded-art').html('('+val+')');
                });
                $('#out-for-delivery-total-loaded-lr').html('('+outForDeliveryTransitCount+')');
                $('#out-for-delivery-total-loaded-art').html('('+totalOutForDeliveryArticle+')');
                $('#transitv3-out-for-delivery-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#transitv3-out-for-delivery-action-state').html('Your request processed successfully');
                
                $('.transit-out-for-delivery-loaded').html(outForDeliveryLoadedLrs.length < 0 ? 0 : outForDeliveryLoadedLrs.length+'<span class="text-muted text-medium">('+outForDeliveryTransitCount+')</span>');
                $('#total-loaded-lrs').html(totalLoadedCount+handleSplitCount());
                // $('#transit-complete-btn').removeClass('hide');
                closeOutForDeliveryLrLoadDialog();
            } 
            splitBtnHandle();
        }

        function ClearOFDLoadLr() {
            outForDeliveryTransitCount = 0;
            outForDeliveryLoadedLrs = [];
            if (isNotNull(OGPLEdit) && isNotNull(OGPLEdit.transitCargoDetails)) {
                $.each(OGPLEdit.transitCargoDetails, function(k,val) {
                    if (val.transitDetailsType.code == 'OFDLD') {
                        outForDeliveryTransitCount += (val.loadedCount + val.unLoadedCount);
                        outForDeliveryLoadedLrs = _.union(outForDeliveryLoadedLrs, val.cargoList);
                    }
                });
            }
            $('.transit-out-for-delivery-loaded').html(outForDeliveryTransitCount);
            $('.ogpl-new-outfordelivery-items').each(function() {
                $(this).prop('checked', false);
            });
            gatheredDataLocal=[];
            $('#total-loaded-lrs').html(directLoadCount + linkLoadCount + localTransitCount + outForDeliveryTransitCount+handleSplitCount());
            $('.out-for-delivery-loaded-lr').html('');
            $('.out-for-delivery-loaded-art').html('');
            $('#out-for-delivery-total-loaded-lr').html('');
            $('#out-for-delivery-total-loaded-art').html('');
            $('#transit-complete-btn').addClass('hide');
        }

        function scrollingOFD(letter, con) {
            var $dialogScrollContainer = $('#out-for-delivery-load-lr-content');
            var $targetElement = $("."+con+"_leter_tr_" + letter);
            if ($targetElement.length > 0) {
                $dialogScrollContainer.animate({
                    scrollTop: $targetElement.offset().top - $dialogScrollContainer.offset().top + $dialogScrollContainer.scrollTop() - 30
                }, 500);
            } else {
                $targetElement.length;
            }
        }
        // Out For Delivery End
        //important
        function saveTransitV3(action) {
            var transitList = [];
                $('#transit-type [name="transit-type"]:checked').each(function() {
                    transitList.push($(this).val());
                });
            var is_emtpy_with_load = transitList.includes('INTRNT') &&  transitList.includes('OTFD');
            var onlyEmptyLoad = transitList.includes('INTRNT') && !transitList.includes('OTFD');
            var activityType = [];
            $.each(OGPLFormData.cargoActivityType || [], function(i, val) {
                activityType.push({ code : val});
            });
            
            var data = Object.assign({}, OGPLFormData);
            data.activityType = activityType;

            if (isNull(data)) {
                $('#save-transitv3-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#save-transitv3-action-state').html('Please check the data given!!');
                $('#save-transitv3-action-state').show();
                return false;
            }
            $('#save-transitv3-action-state').removeClass('alert-danger').removeClass('alert-success');
            $('#save-transitv3-action-state').html(loading_popup).show();
            $('#transit-complete-btn').prop('disabled', true);

            let localViaOrganizations=data.localViaOrganizations;
            var uniqueLocalViaOrganizations = Array.from(new Set(localViaOrganizations.map(JSON.stringify))).map(JSON.parse);
            data.localViaOrganizations=uniqueLocalViaOrganizations;

            if(is_emtpy_with_load){
                let toOrganizationForLocal=$('#local-via-branches option:selected').val();
                data.toOrganization.code=toOrganizationForLocal; 
            }
            if(action=='post'){
                $.ajax({
                    type: 'POST',
                    dataType: 'json',
                    url: base_url + 'cargo/save-transitv3',
                    data: data,
                    success: function (response) {
                        $('#transit-complete-btn').prop('disabled', false);
                        if (response.status == 1) {
                            var errors = [];
                            $.each(response.cargoResponseState || [], function (i, state) {
                                if (state.activeFlag != 1) {
                                    errors.push(state.code + ' - ' + state.name);
                                }
                            });

                            if (errors.length) {
                                $('#save-transitv3-action-state').removeClass('alert-success').addClass('alert-danger')
                                $('#save-transitv3-action-state').html(errors.join('<br/>'));
                            } else {
                                $('#save-transitv3-action-state').removeClass('alert-danger').addClass('alert-success');
                                $('#save-transitv3-action-state').html('Your request processed successfully');
                                $('#transit-complete-btn').addClass('hide');
                                
                                window.setTimeout(function () {
                                    $('#save-transitv3-action-state').removeClass('alert-danger, alert-success').html('').hide();
                                    var params = {};
                                    params.transitCode = response.OGPLCode;

                                    if (isNotNull(data.code)) {
                                        checkURL();
                                    } else {
                                        var url = base_url + "#cargo/add-ogpl?" + $.param(params);
                                        window.open(url, "_self");
                                    }
                                    
                                    OGPLFormData.code = response.OGPLCode;
                                    $('#hid-ogpl-code').val(response.OGPLCode)
                                }, 3000);
                            }
                        } else {
                            var url = base_url + '#cargo/add-ogpl';
                            if (typeof transitOgplcode !== 'undefined' && transitOgplcode !== '') {
                                url += '?transitCode=' + transitOgplcode;
                            }

                            window.setTimeout(function() {
                                window.open(url, '_self');
                            }, 3000);

                            $('#save-transitv3-action-state').removeClass('alert-success').addClass('alert-danger')
                            $('#save-transitv3-action-state').html(response.errorDesc);
                        }
                    }
                });
            }else{
                return data;
            }
        }

        function editOGPL() {
            $('#transit-complete-btn').addClass('hide');
            $('#add-ogpl-container').show();
            $('#ogpl-form-div').fadeIn('slow');
            $('#edit-ogpl-list-container').hide();
            $('#edit-ogpl-search-container').hide();
            $('#add-ogpl-list-container').addClass('hidden');
        }

        function showStartTripDialog(type) {
            $('#start-trip-dialog').removeClass('hide');
            $('#start-trip-dialog').dialog({
                autoOpen: true,
                width: 800,
                modal: true,
                closeOnEscape:true,
                resizable: false
            });
            $('#start-trip-dialog .inp_error').removeClass('inp_error');
            $('#start-trip-action-state').removeClass('alert alert-danger alert-success').html('');
            $('#start-trip-odo, #start-trip-hire-amount, #start-trip-advance-amount, #start-trip-adv-paymode, #start-trip-fuel-litres, #start-trip-fuel-rate, #start-trip-fuel-coupon').val('');
            $('#start-trip-supervisor, #start-trip-fuel-vendor, #start-trip-adv-payby').val('').trigger('change');
            $('#start-trip-fuel-payment-mode').val('CASH').trigger('change');
            $('#start-trip-hiring-amt').removeClass('hide');
            $('#allowLoad').val(type);

            $('#trip-start-date').html(moment().format('DD MMM YYYY'));
            $('#trip-start-time').html(moment().format('hh : mm A'));

            var vehicle = _.find(OGPLVehicles, o => o.code == OGPLFormData.busVehicle.code) || {};
           
            $('.last-odometer').html(vehicle.lastOdometer);
        }

        function hideStartTripDialog() {
            $('#start-trip-dialog').dialog('destroy');
            $('#start-trip-dialog').hide();
        }

        function startTransitV3Trip() {
            var allowLoading = $('#allowLoad').val();
           
            var data = {}, err = 0;
            data.action = 'DEPARTURE';
            data.transitCode = OGPLFormData.code;
            data.transitCargo = {};
            data.transitCargo.code = OGPLFormData.code;
            data.fromOrganization = {};
            data.fromOrganization.code = user_login_branch;
            data.startOdometer = Number($('#start-trip-odo').val());
            data.departureAt = moment().format('YYYY-MM-DD HH:mm:ss');
            data.fromOrganizationContact = {};
            data.fromOrganizationContact.code = $('#start-trip-supervisor').val();

            $('.inp_error').removeClass('inp_error');
            if (isNaN(data.startOdometer) || data.startOdometer < 0 || data.startOdometer == '') {
                $('#start-trip-odo').addClass('inp_error');
                err++;
            }
            var vehicle = _.find(OGPLVehicles, o => o.code == OGPLFormData.busVehicle.code) || {};
            if (vehicle && vehicle.lastOdometer > 0 && data.startOdometer < vehicle.lastOdometer) {
                $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
                $('#start-trip-action-state').html('Entered odometer value should be greater than last odometer value');
                return;
            }

            if (isNull(odoDetails) || (odoDetails && (odoDetails.startOdometer == 0))) {
                // fuel expense
                data.fuelExpenseCode = '';
                data.activeFlag = 1;
                data.fuelDate = moment().format('YYYY-MM-DD');
                data.vehicle = {};
                data.vehicle.code = OGPLFormData.busVehicle.code;
                
                data.vendorContact = {};
                data.vendorContact.code = $('#start-trip-fuel-vendor').val();

                data.transactionMode = {};
                data.transactionMode.code = $('#start-trip-fuel-payment-mode').val();

                data.litres = Number($('#start-trip-fuel-litres').val());
                data.pricePerLitre = Number($('#start-trip-fuel-rate').val());
                data.totalAmount = data.litres * data.pricePerLitre;
                data.billNumber = $.trim($('#start-trip-fuel-coupon').val());

                // hiring amount and advance amount
                data.ogpl = [];

                if ((cargoSetting.userAccountModel.code == 'TXRT' && vehicle.ownershipType.code == "HIRE") || cargoSetting.userAccountModel.code != 'TXRT') {
                    var hire = {};

                    hire.code = '';
                    hire.activeFlag = 1;
                    hire.amount = Number($('#start-trip-hire-amount').val());
                    hire.remarks = '';

                    hire.user = {};
                    hire.user.code = login_user;

                    hire.transitCargo = {};
                    hire.transitCargo.code = OGPLFormData.code;
                    
                    hire.cashbookType = {};
                    hire.cashbookType.code = 'HIRING';

                    if (Number(hire.amount) > 0) {
                        data.ogpl.push(hire);
                    }
                }
                
                var advance = {};

                advance.code = '';
                advance.activeFlag = 1;
                advance.amount = Number($('#start-trip-advance-amount').val());
                advance.remarks = '';

                advance.user = {};
                advance.user.code = login_user;

                advance.transitCargo = {};
                advance.transitCargo.code = OGPLFormData.code;

                advance.transactionMode = {};
                advance.transactionMode.code = $('#start-trip-adv-paymode').val();
                
                advance.cashbookType = {};
                advance.cashbookType.code = 'ADVANCE';

                advance.paymentByContact = {};
                advance.paymentByContact.code = $('#start-trip-adv-payby').val();

                if (advance.transactionMode.code == 'UPI') {
                    advance.bankDetails = {};
                    advance.bankDetails.code = $('#start-trip-adv-upi-orgbank').val();
                    advance.addAttr1 = $.trim($('#start-trip-adv-upi-id').val());
                    advance.addAttr2 = $.trim($('#start-trip-adv-upi-details').val());
                } else if (advance.transactionMode.code == 'NBK') {
                    advance.bankDetails = {};
                    advance.bankDetails.code = $('#start-trip-adv-netbanking-orgbank').val();
                    advance.addAttr1 = $.trim($('#start-trip-adv-netbanking-accholder').val());
                    advance.addAttr2 = $.trim($('#start-trip-adv-netbanking-bankname').val());
                    advance.addAttr3 = $.trim($('#start-trip-adv-netbanking-details').val());
                } else if (advance.transactionMode.code == 'CHEQUE') {
                    advance.chequeDetails = {};
                    advance.chequeDetails.code = $('#start-trip-adv-chq-code').val();
                    advance.chequeDetails.activeFlag = 1;

                    advance.chequeDetails.organization = {};
                    advance.chequeDetails.organization.code = '{$login_branch}';

                    advance.chequeDetails.bankDetails = $.trim($('#start-trip-adv-cheque-bankname').val());
                    advance.chequeDetails.payerDetails = $.trim($('#start-trip-adv-cheque-payer').val());

                    advance.chequeDetails.chequeDate = moment($('#start-trip-adv-cheque-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                    advance.chequeDetails.chequeNo = $.trim($('#start-trip-adv-cheque-no').val());
                    advance.chequeDetails.bankCity = $.trim($('#start-trip-adv-cheque-bankcity').val());

                    advance.chequeDetails.chequeStatus = {};
                    advance.chequeDetails.chequeStatus.code = 'NEW';

                    advance.chequeDetails.remarks = $.trim($('#start-trip-adv-cheque-remarks').val());
                }

                if (Number(advance.amount) > 0) {
                    data.ogpl.push(advance);
                }

                // advance amount
                if ((cargoSetting.userAccountModel.code == 'TXRT' && $.inArray(OGPLFormData.cargoActivityType.code, ['OTFD', 'INTRNT']) != -1 && vehicle.ownershipType.code == "OWN" && !isNull(hire) && hire.amount != '') || (cargoSetting.userAccountModel.code != 'TXRT' && !isNull(hire) && hire.amount != '') || advance.amount != '' || advance.transactionMode.code != '' || advance.paymentByContact.code != '') {
                    if (!isNull(hire) && hire.amount == '') {
                        $('#start-trip-hire-amount').addClass('inp_error');
                        err++;
                    }
                    
                    if (advance.amount == '') {
                        $('#start-trip-advance-amount').addClass('inp_error');
                        err++;
                    }

                    if (advance.transactionMode.code == '') {
                        $('#start-trip-adv-paymode').addClass('inp_error');
                        err++;
                    }

                    if (advance.paymentByContact.code == '') {
                        $('#start-trip-adv-payby').addClass('inp_error');
                        err++;
                    }

                    if (advance.transactionMode.code == 'UPI') {
                        if (advance.addAttr1 == '') {
                            $('#start-trip-adv-upi-id').addClass('inp_error');
                            err++;
                        }

                        if ($('#start-trip-adv-upi-orgbank').val() == '') {
                            $('#start-trip-adv-upi-orgbank').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr2 == '') {
                            $('#start-trip-adv-upi-details').addClass('inp_error');
                            err++;
                        }
                    } else if (advance.transactionMode.code == 'NBK') {
                        if (advance.addAttr1 == '') {
                            $('#start-trip-adv-netbanking-accholder').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr2 == '') {
                            $('#start-trip-adv-netbanking-bankname').addClass('inp_error');
                            err++;
                        }

                        if ($('#start-trip-adv-netbanking-orgbank').val() == '') {
                            $('#start-trip-adv-netbanking-orgbank').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr3 == '') {
                            $('#start-trip-adv-netbanking-details').addClass('inp_error');
                            err++;
                        }
                    } else if (advance.transactionMode.code == 'CHEQUE') {
                        if (advance.chequeDetails.payerDetails == '') {
                            $('#start-trip-adv-cheque-payer').addClass('inp_error');
                            err++;
                        }

                        if ($('#start-trip-adv-cheque-date').val() == '') {
                            $('#start-trip-adv-cheque-date').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.chequeNo == '') {
                            $('#start-trip-adv-cheque-no').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.bankDetails == '') {
                            $('#start-trip-adv-cheque-bankname').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.bankCity == '') {
                            $('#start-trip-adv-cheque-bankcity').addClass('inp_error');
                            err++;
                        }
                    }
                }

                // fuel expense
                if (data.vendorContact.code != '' || data.litres != '' || data.pricePerLitre != '' || data.billNumber != '') {
                    if (data.vendorContact.code == '') {
                        $('#start-trip-fuel-vendor').addClass('inp_error');
                        err++;
                    }

                    if (data.litres == '') {
                        $('#start-trip-fuel-litres').addClass('inp_error');
                        err++;
                    }

                    if (data.pricePerLitre == '') {
                        $('#start-trip-fuel-rate').addClass('inp_error');
                        err++;
                    }

                    if (data.billNumber == '') {
                        $('#start-trip-fuel-coupon').addClass('inp_error');
                        err++;
                    }
                }
            }
            
            if(err) {
                $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
                $('#start-trip-action-state').html('Please enter/select the values in the field that are marked in red');
                return;
            }
            $('#start-trip-panel-btn').hide();
            $('#start-trip-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
            var transitList = [];
                $('#transit-type [name="transit-type"]:checked').each(function() {
                    transitList.push($(this).val());
                });
            //check is empty load with outfordelivery    
            var is_emtpy_with_load = transitList.includes('INTRNT') &&  transitList.includes('OTFD');
            var onlyEmptyLoad = (transitList.includes('INTRNT')||transitList.includes('TRNT')) && !transitList.includes('OTFD');
            // if(is_emtpy_with_load){
            //     console.log($('.local-via-branches').val());
            //     let toOrganizationForLocal=$('#local-via-branches option:selected').val();
            //         data.toOrganization.code=toOrganizationForLocal;
            // }
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-start-odometer",
                data: data,
                success: function (response) {
                    if (response.status == 1) {       
                        startOdoUpdated == 1;         
                        $('#start-trip-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                        window.setTimeout(function () {
                            hideStartTripDialog();
                            if(!is_emtpy_with_load){
                                let transitcode=OGPLFormData.code;
                                var params = {};
                                params.transitCode = transitcode;
                                    if(allowLoading == false){
                                        window.location.reload();
                                    }else{
                                        if(onlyEmptyLoad){
                                            var url = base_url + "#cargo/add-ogpl?" + $.param(params)+'&INTRNT=HIDE&TRNT=HIDE';
                                            window.open(url, "_self");
                                            checkURL();
                                            return;
                                        }
                                        var url = base_url + "#cargo/add-ogpl?" + $.param(params)+'&INTRNT=HIDE';
                                        window.open(url, "_self");
                                        checkURL();
                                    }
                            }
                        }, 3000);
                    } else {
                        $('#start-trip-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                        $('#start-trip-panel-btn').show();
                    }

                }
            });
        }

        function showLoadedLrDialog() {
            $('#transitv3-loaded-lr-dialog').css('background', '#fff');
            $('#transitv3-loaded-lr-dialog').removeClass('hide');
            $('#transitv3-loaded-lr-dialog').dialog({
                autoOpen: true,
                height: $(window).height() - 30,
                width: $(window).width() - 200,
                modal: true,
                resizable: false,
                closeOnEscape: true
            });
            $('.ui-dialog-titlebar').hide();
            $('#transitv3-loaded-lr-action-state').removeClass('alert-danger').html('').hide();
            $('.inp_error').removeClass('inp_error');
        }

        function closeLoadedLrDialog() {
            $('#transitv3-loaded-lr-dialog').addClass('hide');
            $('#transitv3-loaded-lr-dialog').dialog('destroy');
        }

        function get_transit_loaded_lrs() {
            $('#transitv3-loaded-lr-content').html('');
            var data = {};
            data.transitCode = OGPLEdit.code;

            if (isNull(data)) {
                $('#transitv3-loaded-lr-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#transitv3-loaded-lr-action-state').html('Invalid Transit Code!!');
                $('#transitv3-loaded-lr-action-state').show();
                return false;
            }
            $('#transitv3-loaded-lr-action-state').removeClass('alert-danger').removeClass('alert-success');
            $('#transitv3-loaded-lr-content').html(loading_popup).show();
            // $('#transit-complete-btn').prop('disabled', true);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/transitv3-loaded-ogpl-list",
                data: data,
                success: function (response) {
                    $('#transitv3-loaded-lr-content').html(response);
                }
            });
        }

        function unloadTransitV3Lr() {
            var ogplRoutes = {};
            $('#load-transitv3-list .transitv3-loaded-items:checked').each(function (i, cb) {
                var $cb = $(cb);
                var route = $cb.data('from') + '-' + $cb.data('to');
                if (!ogplRoutes[route]) {
                    ogplRoutes[route] = {};
                    ogplRoutes[route].cargoList = [];
                    ogplRoutes[route].from = $cb.data('from');
                    ogplRoutes[route].to = $cb.data('to');
                    ogplRoutes[route].fromOrg = $cb.data('fromorg');
                    ogplRoutes[route].toOrg = $cb.data('toorg');
                    ogplRoutes[route].transitType = $cb.data('transittype');
                }
                ogplRoutes[route].cargoList.push($cb.val());
            });

            if ($.isEmptyObject(ogplRoutes)) {
                $('#transitv3-loaded-lr-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#transitv3-loaded-lr-action-state').html('Please select atleast one LR');
                $('#transitv3-loaded-lr-action-state').show();
                return false;
            }
            $('#transitv3-loaded-lr-action-state').removeClass('alert-danger').removeClass('alert-success');
            $('#transitv3-loaded-lr-action-state').html(loading_popup).show();

            var data = {};
            data.unloadList = _.values(ogplRoutes);
            data.transitCargo = OGPLEdit.code;
            data.ogplLRCount = loadedLrCount-1;

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/unload-ogpl-list',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        var errors = [];
                        $.each(response.data.cargoList || [], function (i, state) {
                            if (state.activeFlag != 1) {
                                errors.push(state.code + ' - ' + state.name);
                            }
                        });

                        if (errors.length) {
                            $('#transitv3-loaded-lr-action-state').removeClass('alert-success').addClass('alert-danger')
                            $('#transitv3-loaded-lr-action-state').html(errors.join('<br/>'));
                        } else {
                            $('#transitv3-loaded-lr-action-state').removeClass('alert-danger').addClass('alert-success');
                            $('#transitv3-loaded-lr-action-state').html('Your request processed successfully');
                            window.setTimeout(function () {
                                closeLoadedLrDialog();
                                checkURL();
                            }, 3000);
                        }
                    } else {
                        $('#transitv3-loaded-lr-action-state').removeClass('alert-success').addClass('alert-danger')
                        $('#transitv3-loaded-lr-action-state').html(response.errorDesc);
                    }
                }
            });
        }

        function setStartTripTransactionMode() {
            var mode = $('#start-trip-adv-paymode').val();

            $('#start-trip-adv-cheque-mode-panel').addClass('hide');
            $('#start-trip-adv-netbanking-mode-panel').addClass('hide');
            $('#start-trip-adv-upi-mode-panel').addClass('hide');

            if (mode == 'CASH') {
                return;
            }

            if (mode == 'CHEQUE') {
                $('#start-trip-adv-cheque-mode-panel').removeClass('hide');
            } else if (mode == 'NBK') {
                $('#start-trip-adv-netbanking-mode-panel').removeClass('hide');
            } else if (mode == 'UPI') {
                $('#start-trip-adv-upi-mode-panel').removeClass('hide');
            }
        }

        function setOGPLTemplate(tplcode) {
            if (tplcode == '') {
                $('#ogpl-name').val('');
                $('#ogpl-from').val('').trigger('change');
                $('#ogpl-to').val('').trigger('change');
                $('#ogpl-arrivaltime').val('').trigger('change');
                $('#ogpl-departuretime').val('').trigger('change');
                $('#ogpl-remarks').val('');
                $('#ogpl-via').select2('val', []);
                return;
            }
            var tpl = _.find(OGPLTemplates, function(o) {
                return o.code == tplcode;
            });
            $('#ogpl-name').val(tpl.name);

            var transitType = $('#transit-type [name="transit-type"]:checked').val();

            if (transitType == 'TRNT') {
                $('#ogpl-from').val(tpl.fromStation.code).trigger('change');
                $('#ogpl-to').val(tpl.toStation.code).trigger('change');
                var via = $.map(tpl.viaStations || [], function(val) {
                    return val.code;
                });
                $('#ogpl-via').select2('val', via);
            }

            var option = tpl;
            var arrivalMinutes, arrivalday;
            if (option.arrivalMinutes > 2880) {
                arrivalMinutes = option.arrivalMinutes - 2880;
                arrivalday = 2880;
            } else if (option.arrivalMinutes > 1440) {
                arrivalMinutes = option.arrivalMinutes - 1440;
                arrivalday = 1440;
            } else {
                arrivalMinutes = option.arrivalMinutes;
                arrivalday = 0;
            }
            stationfilter1();
            stationfilter2();
            $('#ogpl-arrivalday').val(arrivalday);
            $('#ogpl-arrivaltime').val(arrivalMinutes || '');
            $('#ogpl-departuretime').val(option.departureMinutes || '');
        }

        function getOgplList(ogplCode = '') {
            emptyLoadBtnValidation();
            if (cargoSetting.ogplModelCode != 'VER3') {
                return;
            }
            var data = {};
            data.tripDate = $.trim($('#ogpl-search-date').val());
            data.vehicleCode = $.trim($('#ogpl-search-vehicle').val());
            data.transitCode = ogplCode;
    
            var err = 0;
            $('.inp_error').removeClass('inp_error');
            if(data.transitCode == '' && data.vehicleCode == '' && data.tripDate == '') {
                $('#ogpl-search-date').addClass('inp_error');
                $('#ogpl-search-vehicle').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#ogpl_search_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#ogpl_search_action_state').html('Please select atleast one option');
                $('#ogpl_search_action_state').show();
                return false;
            } else {
                $('#ogpl_search_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#ogpl_search_action_state').html('');
                $('#ogpl_search_action_state').hide();
            }

            $('#add-ogpl-container').hide();
            $('#ogpl-template-container').hide();
            $('#ogpl-search-list-container').show();
            $('#ogpl-search-list').show().html(loading_popup);

            $.ajax({
                type: "POST",
                url: base_url + "cargo/ogplv2-search-list",
                data: data,
                dataType: 'html',
                success: function (response) {
                    if (cargoSetting.transitMode[0] == 1) {
                        $('#ogpl-search-list').html(response);
                    } else {
                        $('#ogpl-search-list').hide();
                        $('#add-ogpl-container').fadeIn('slow');
                        if (linkTransitType == 'OTFD') {
                            $('#transit-type [name="transit-type"][value="TRNT"]').prop('checked', false).trigger('change');
                        }
                    }
                }
            });
        }

        function saveAndLoadOgpl(ogplCode) {
            var ogpl = _.find(ogplSearchData, e => e.code == ogplCode);
            if (!ogpl) {
                return;
            }

            if (ogpl.tripDate) {
                var currentDate = new Date();
                var tripDate = new Date(ogpl.tripDate);
                var daysDifference = (currentDate - tripDate) / (1000 * 60 * 60 * 24);
                
                if (daysDifference > 7) {
                    $('#ogpl-summary-state').removeClass('alert-success').addClass('alert-danger');
                    $('#ogpl-summary-state').html('Loading days limit exceeded, unloading only applicable').show();
                    return;
                }
            }

            if (ogpl.cargoActivityType.code == 'INTRNT') {
                fillOgplEdit(ogpl);
                return;
            }
            ogpl.fromOrganization = {};
            ogpl.fromOrganization.code =loadorg.fromOrganization.code;  
            ogpl.toOrganization = {};
            ogpl.toOrganization.code = loadorg.toOrganization.code;            
                
            var toStation = $('#ogpl-search-to').val();
            var viaStations = $('#ogpl-search-via').val() || [];
            if (!viaStations.length && (!toStation || toStation == ogpl.toStation.code)) {
                var transitStations = []
                transitStations.push(ogpl.fromStation.code);
                transitStations.push(ogpl.toStation.code);
                $.each(ogpl.viaStations || [], function(i, val) {
                    transitStations.push(val.code);
                });
                if (!transitStations.includes(user_login_station)) {
                    $('#ogpl-summary-state').removeClass('alert-success').addClass('alert-danger');
                    $('#ogpl-summary-state').html('Vehicle not crossing your station, not allowed to load parcel. Add your station in route and try again.').show();
                    return;
                }
                OGPLEdit = ogpl;

                var params = {};
                params.transitCode = OGPLEdit.code;

                var url = base_url + "#cargo/add-ogpl?" + $.param(params);
                window.open(url, "_self");

                fillOgplEdit(ogpl);
                return;
            }

            viaStations = viaStations.map(v => ({ code : v }));

            if (toStation && toStation != ogpl.toStation.code) {
                ogpl.viaStations = _.unionBy(ogpl.viaStations, viaStations, [ogpl.toStation], 'code');
                ogpl.toStation = {};
                ogpl.toStation.code = $('#ogpl-search-to').val();
                ogpl.toStation.name = $('#ogpl-search-to option:selected').text();
            } else {
                ogpl.viaStations = _.unionBy(ogpl.viaStations, viaStations, 'code');
            }
            OGPLEdit = ogpl;

            ogpl.activityType.concat(ogplSearchData.activityType ?? []);
            ogpl.hubViaStations.concat(ogplSearchData.hubViaStations ?? []);

            $('#ogpl-summary-state').removeClass('alert-success').removeClass('alert-danger');
            $('#ogpl-summary-state').html(loading_popup).show();

            $.ajax({
                type: "POST",
                url: base_url + 'cargo/load-ogpl-list',
                data: ogpl,
                dataType: 'json',
                success: function (response) {
                    if (response.status == 1) {
                        $('#ogpl-summary-state').removeClass('alert-danger').addClass('alert-success');
                        $('#ogpl-summary-state').html('Your request processed successfully');
                        setTimeout(function () {
                            var transitStations = []
                            transitStations.push(ogpl.fromStation.code);
                            transitStations.push(ogpl.toStation.code);
                            $.each(ogpl.viaStations || [], function(i, val) {   
                                transitStations.push(val.code);
                            });
                            if (!transitStations.includes(user_login_station)) {
                                $('#ogpl-summary-state').removeClass('alert-success').addClass('alert-danger');
                                $('#ogpl-summary-state').html('Vehicle not crossing your station, not allowed to load parcel. Add your station in route and try again.').show();
                                return;
                            }
                            fillOgplEdit(ogpl);
                        }, 1000);
                    } else {
                        $('#ogpl-summary-state').removeClass('alert-success').addClass('alert-danger')
                        $('#ogpl-summary-state').html(response.errorDesc);
                    }
                }
            });
        }

        function showAddOGPL() {
            $('#ogpl-search-list-container').hide();
            $('#add-ogpl-container').fadeIn('slow');
            $('#ogpl-template-container').fadeIn('slow');
            $('#hid-ogpl-code').val('');
            $('#add-ogpl-form').trigger('reset');
            $('#ogpl-date').datepicker('setDate', new Date());
            $('#ogpl-tpl').val('').trigger('change');
            $('#ogpl-from').val('').trigger('change');
            $('#ogpl-to').val('').trigger('change');
            $('#ogpl-via').select2('val', []);
            $('#ogpl-via-branches').select2('val', []);
            $('#driver2-panel').addClass('hide');

            $('html, body').animate({
                scrollTop: $('#container-fluid').offset().top +100
            }, 400);
        }

        function setEmptyLoad(ogplCode) {
            var ogpl = _.find(ogplSearchData, e => e.code == ogplCode);
            if (!ogpl) {
                return;
            }

            $('#hid-ogpl-code').val('');
            $('#add-ogpl-form').trigger('reset');

            showAddOGPL();
            $('#ogpl-from').val(ogpl.toStation.code).trigger('change').prop('disabled', true);
            $('#ogpl-template-container').hide();
        }

        function refreshOGPLV2(transitCode) {
            var data = {}
            data.transitCode = transitCode;

            var loading_overlay = iosOverlay({
                text: "Refreshing",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + 'cargo/refresh-ogplv2-data',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        window.setTimeout(function() {
                            getOgplList();
                        }, 1000);
                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }

        function getNextOGPLSequence() {
            // if (cargoSetting.userAccountModel.code != 'DINV') {
            //     return;
            // }
            // var data = {};

            // data.cargoActivityType = {};
            // data.cargoActivityType.code = $('#transit-type [name="transit-type"]:checked').val()
            
            // if (data.cargoActivityType.code == 'TRNT') {
            //     cargoSetting.transitLocationModelCode == 'STN'
                
            //     data.fromStation = {};
            //     data.fromStation.code = $('#ogpl-from').val();

            //     data.toStation = {};
            //     data.toStation.code = $('#ogpl-to').val();

            //     data.fromOrganization = {};
            //     data.fromOrganization.code = '';

            //     data.toOrganization = {};
            //     data.toOrganization.code = '';

            // } else if (data.cargoActivityType.code == 'INTRNT') {
            //     data.fromStation = {};
            //     data.fromStation.code = $('#ogpl-from-branch option:selected').data('stationcode');

            //     data.toStation = {};
            //     data.toStation.code = $('#ogpl-to-branch option:selected').data('stationcode');

            //     data.fromOrganization = {};
            //     data.fromOrganization.code = $('#ogpl-from-branch').val();

            //     data.toOrganization = {};
            //     data.toOrganization.code = $('#ogpl-to-branch').val();
            // }

            // var err = 0;
            // $('.inp_error').removeClass('inp_error');
            // $('#ogpl-action-state').html('');
            // if(data.cargoActivityType.code == 'TRNT' && !data.fromStation.code) {
            //     $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
            //     $('#ogpl-action-state').html('Please select from station').show();
            //     return false;
            // }
            // if(data.cargoActivityType.code == 'TRNT' && !data.toStation.code) {
            //     $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
            //     $('#ogpl-action-state').html('Please select to station').show();
            //     return false;
            // }

            // if(data.cargoActivityType.code == 'INTRNT' && !data.fromOrganization.code) {
            //     $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
            //     $('#ogpl-action-state').html('Please select from branch').show();
            //     return false;
            // }
            // if(data.cargoActivityType.code == 'INTRNT' && !data.toOrganization.code) {
            //     $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
            //     $('#ogpl-action-state').html('Please select to branch').show();
            //     return false;
            // }
            
            // $('#ogpl-action-state').removeClass('alert-success').removeClass('alert-danger').html('');
            // $('#next-ogpl-sequence').html(loading_popup);
            
            // $.ajax({
            //     type: "POST",
            //     dataType: 'json',
            //     url: base_url + "cargo/generate-next-ogpl-sequence",
            //     data: data,
            //     success: function (response) {
            //         if (response.status == 1) {
            //                 $('#next-ogpl-sequence').html(('<i class="fa fa-info-circle" title="Next OGPL Sequence"></i> <span class="h5 bold">' + response.data.code + '</span>') || '');
            //         } else {
            //             $('#ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
            //             $('#ogpl-action-state').html(response.errorDesc);
            //         }
            //     }
            // });
        }

        function directHandling() {
            var directCheckedLr = [];
            $('#direct-load-ogpl-list .ogpl-new-directload-items:checked').each(function (i, cb) {
                directCheckedLr.push($(cb).val());
            });
            $('.custom-checkbox-group .directbox:checked').each(function () {
                var code = $(this).data('cargoid');

                if (!directCheckedLr.includes(code)) {
                    directCheckedLr.push(code);
                }
            });
            return directCheckedLr;
        }

        function linkHandling() {
            let linkCheckedLr = [];
            $('#link-load-ogpl-list .ogpl-new-linkload-items:checked').each(function (i, cb) {
                linkCheckedLr.push($(cb).val());
            });
            $('.custom-checkbox-group .linkload:checked').each(function () {
                var code = $(this).data('cargoid');

                if (!linkCheckedLr.includes(code)) {
                    linkCheckedLr.push(code);
                }
            });
            return linkCheckedLr;
        }

        function localHandling() {
            let localCheckedLr = [];
            $('#local-transit-ogpl-list .ogpl-new-localLoad-items:checked').each(function (i, cb) {
                localCheckedLr.push($(cb).val());
            });
            $('.custom-checkbox-group .localload:checked').each(function () {
                var code = $(this).data('cargoid');

                if (!localCheckedLr.includes(code)) {
                    localCheckedLr.push(code);
                }
            });
            return localCheckedLr;
        }
        function oftHandling() {
            let otfCheckedLr = [];
            $('#out-for-delivery-ogpl-list .ogpl-new-outfordelivery-items:checked').each(function (i, cb) {
                otfCheckedLr.push($(cb).val());
            });
            return otfCheckedLr;
        }

        // splitlr additionals
        function handleSplitCount() { //checked partial LR count 
            let totalSplitCount=0;
            let directCount=gatheredData.length;
            let LinkCount=gatheredDataLink.length;
            let LocalCount=gatheredDataLocal.length;
            totalSplitCount=directCount+LinkCount+LocalCount;
            $('.split-counts').text(directCount+' | '+LinkCount+' | '+LocalCount);
            var mainLRS=$('.total-loaded-lrs').text();
            $('.total-loaded-lrs').text(mainLRS+totalSplitCount);
            return totalSplitCount;
        }

        function mainSelectLrsCount(){ //return mainly selected lrs count
            let mainlength=0;
            directLoadCount = $('#direct-load-ogpl-list .ogpl-new-directload-items:checked').length;
            linkLoadCount = $('#link-load-ogpl-list .ogpl-new-linkload-items:checked').length;
            localLoadCount = $('#local-transit-ogpl-list .ogpl-new-localLoad-items:checked').length; //local loaded Lrs list
            ofdLoadCount = $('#out-for-delivery-ogpl-list .ogpl-new-outfordelivery-items:checked').length; //local loaded Lrs list
            mainlength=directLoadCount+linkLoadCount+localLoadCount+ofdLoadCount;
            return mainlength;
        }

        splitBtnHandle()
        function splitBtnHandle() { //return splited Lrs count
            let btnEl = $('#transit-split-btn');
            let saveBtnEl = $('#transit-complete-btn');

            let splitedLength=handleSplitCount();
            let mainlength=mainSelectLrsCount();

            if(mainlength>0 && splitedLength==0){
                //should show save btn
                saveBtnEl.removeClass('hide');
                btnEl.addClass('none');
            }
            else if(mainlength>0 && splitedLength>0){
                btnEl.removeClass('none');
                saveBtnEl.addClass('hide');
            }
            else if(splitedLength>0){
                //should show split btn
                btnEl.removeClass('none');
                saveBtnEl.addClass('hide');
            }else{
                // should hide both btn
                btnEl.addClass('none');
                saveBtnEl.addClass('hide');
            }

            let splitLRscount=gatheredData.length + gatheredDataLink.length + gatheredDataLocal.length;
                if(splitLRscount == 0){
                    $('.split-panel-footer button').hide();
                }else{
                    $('.split-panel-footer button').show();
                }
        }

        function clearSplitSelectioned(){
            gatheredData=[];
            gatheredDataLink=[];
            gatheredDataLocal=[];
            //remove the all isSelected array like empty
        }

        function closeSplitPop(){
            $('.popup-split').dialog('destroy');
            $('.popup-split').addClass('none');
        }
     
        function checkAllValidation(totalCount, cargoCode, action) {
            var checkboxes = document.querySelectorAll('.' + action + '-' + cargoCode + ' input[type="checkbox"]');
            var checkedCount = 0;

            checkboxes.forEach(function(checkbox) {
                if (checkbox.checked) {
                    checkedCount++;
                }
            });
          
            // If all checkboxes are checked
            if (checkedCount === totalCount) {
                let currentRow = $('.' + action + '-' + cargoCode).closest('tr');
                let selectElement = currentRow.prevAll('tr').first().find('td:first input');
                selectElement.prop('indeterminate', false);
                selectElement.prop('checked', true);

                checkboxes.forEach(function(checkbox) {
                    checkbox.checked = false;
                });

                currentRow.hide();
            } 

            // If some checkboxes are checked
            if (checkedCount > 0 && checkedCount < totalCount) {
                let currentRow = $('.' + action + '-' + cargoCode).closest('tr');
                let selectElement = currentRow.prevAll('tr').first().find('td:first input');
                selectElement.prop('indeterminate', true);
                selectElement.prop('checked', false);
            }

            // If no checkboxes are checked
            if (checkedCount === 0) {
                let currentRow = $('.' + action + '-' + cargoCode).closest('tr');
                let selectElement = currentRow.prevAll('tr').first().find('td:first input');
                selectElement.prop('indeterminate', false);
                selectElement.prop('checked', false);
            }
            splitBtnHandle();
        }

       
    {/literal}
</script>
{literal}
    <script>
    $('.direct-get-error').hide();
    $('.local-get-error').hide();
    $('.link-get-error').hide();

   
    function sanitizeCargo(cargo) {
        cargo = cargo.charAt(0).toUpperCase() + cargo.slice(1);
        cargo = cargo.replace(/\s/g, "");
        return cargo;
    }

     var existingLrs=[];
     var existingLocalLrs = [];
     var existingLinkLrs=[]; //already listed link LRs
     
     var gotDirectLrs = [];
     var gotLocalLrs = [];
     var gotLinkLrs = []; // Received link load lrs

     var localSelectedLrs = [];
     var directSelectedLrs = [];
     var linkSelectedLrs = []; //selected list LRs 

     function getCargoRow(type, queryCode, fromDate, toDate, fromStationCode, toStationCode, viaStationCodes, transitOrganizationCode, transitTypeCode) {

     let directCheckedLr = directHandling();
     let localCheckedLr = localHandling();
     let linkCheckedLr = linkHandling();
    $(".get-lr-btn").attr("disabled", true);
    setInterval(() => {
        $(".get-lr-btn").attr("disabled", false);
    }, 2000);

    var load_branches = {};
    var load_station_branches = {};
    var className = "";
    var Ctype = "";
    var partialClassName = "";

    switch (type) {
        case "direct":
            className = "direct-load";
            Ctype = "Direct";
            partialClassName = "directbox";
            break;
        case "local":
            className = "local-transit";
            Ctype = "Local";
            partialClassName = "localload";
            break;
        case "link":
            className = "link-load";
            Ctype = "Link";
            partialClassName = "linkload";
            break;
        default:
            break;
    }

    var errorEl = $('.' + type + '-get-error');
    var data = {
        queryCode: queryCode,
        fromDate: fromDate,
        toDate: toDate,
        fromStationCode: fromStationCode,
        toStationCode: toStationCode,
        viaStationCodes: viaStationCodes,
        transitOrganizationCode: transitOrganizationCode,
        transitTypeCode: transitTypeCode
    };

    var cargoCode = $('.' + type + '-ogpl-load-cargocode').val();
    cargoCode = sanitizeCargo(cargoCode);
    data.cargoCode = cargoCode;

    let targetEl = $('#' + className + '-ogpl-list');

    var ogplVia = [];
    if (type === "local" || type === 'direct') {
        ogplVia = OGPLFormData.localViaOrganizations;
    } else if (type === 'link') {
        ogplVia = [].concat([], OGPLFormData.viaStations, [OGPLFormData.toStation]);
    }

    var allowRequest = false;
    if (type === 'direct') {
        $('#direct-load-ogpl-list .ogpl-new-directload-items').each(function (i, cb) {
            existingLrs.push($(cb).val());
        });

        // Check for cargo code validity
        if (cargoCode == "" || cargoCode == null) {
            handleErrorMessage(errorEl, 'Enter the Cargo Code');
            return;
        } else {
            allowRequest = true;
            errorEl.hide();
        }

        // Check for duplicate and selected LRs
        if (existingLrs.includes(cargoCode)) {
            handleErrorMessage(errorEl, 'This LR already exists');
            scrollToListItem(cargoCode,'#direct-load-load-lr-content','#direct-load-ogpl-list','.ogpl-new-directload-items')
            return;
        }
        // Additional checks for other LR types
           if(gotLocalLrs.includes(cargoCode)){
                errorEl.show();
                errorEl.addClass('text-danger');
                errorEl.text('Already Received in Local');
                return;
            }
           if(gotDirectLrs.includes(cargoCode)){
                errorEl.show();
                errorEl.addClass('text-danger');
                errorEl.text('Already Received');
                return;
            }
           if(localCheckedLr.includes(cargoCode)){
                errorEl.show();
                errorEl.addClass('text-danger');
                errorEl.text('This Lr is already Selected in Local');
                return;
            }
    } else if (type == "link") {
        $('#link-load-ogpl-list .ogpl-new-linkload-items').each(function (i, cb) {
            existingLinkLrs.push($(cb).val());
        });

        if (cargoCode == "" || cargoCode == null) {
            handleErrorMessage(errorEl, 'Enter the Cargo Code');
            return;
        } else {
            allowRequest = true;
            errorEl.hide();
        }
        // Check for duplicate and selected LRs
        if (existingLinkLrs.includes(cargoCode)) {
            handleErrorMessage(errorEl, 'This LR already exists');
            scrollToListItem(cargoCode,'#link-load-load-lr-content','#link-load-ogpl-list','.ogpl-new-linkload-items')
            return;
        }
        // Additional checks for other LR types
           if(gotLocalLrs.includes(cargoCode)){
                errorEl.show();
                errorEl.addClass('text-danger');
                errorEl.text('Already Received in Local');
                return;
            } 
           if(gotDirectLrs.includes(cargoCode)){
                errorEl.show();
                errorEl.addClass('text-danger');
                errorEl.text('Already Received in Direct');
                return;
            }
           if(localCheckedLr.includes(cargoCode)){
                errorEl.show();
                errorEl.addClass('text-danger');
                errorEl.text('This Lr is already Selected in Local');
                return;
            }
            if(directCheckedLr.includes(cargoCode)){
                errorEl.show();
                errorEl.addClass('text-danger');
                errorEl.text('This Lr is already Selected in Direct');
                return;
            }


    } else if (type === 'local') {
        $('#local-transit-ogpl-list .ogpl-new-localLoad-items').each(function (i, cb) {
            existingLocalLrs.push($(cb).val());
        });

        if (cargoCode == "" || cargoCode == null) {
            handleErrorMessage(errorEl, 'Enter the Cargo Code');
            return;
        } else {
            allowRequest = true;
            errorEl.hide();
        }
        if(existingLocalLrs.includes(cargoCode)){
            errorEl.show();
            errorEl.addClass('text-danger');
            errorEl.text('This Lr was Already Exist');

            scrollToListItem(cargoCode,'#local-transit-load-lr-content','#local-transit-ogpl-list','.ogpl-new-localLoad-items')
            return;

        }
        if(gotDirectLrs.includes(cargoCode)){
            errorEl.show();
            errorEl.addClass('text-danger');
            errorEl.text('Already Received in Direct');
            return;
        }
        if(gotLocalLrs.includes(cargoCode)){
            errorEl.show();
            errorEl.addClass('text-danger');
            errorEl.text('Already Received');
            return;
        }
        if(directCheckedLr.includes(cargoCode)){
            errorEl.show();
            errorEl.addClass('text-danger');
            errorEl.text('This Lr is already Selected in Direct');
            return;
        }
    }

    if (!allowRequest) {
        return;
    }
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + 'cargo/transitv3-get-lrs',
        data: data,
        success: function (res) {
            if(type == 'local'){
                $(`.row-direct-${cargoCode} .directbox`).prop('checked',false);
                $(`.row-link-${cargoCode} .linkload`).prop('checked',false);
                // loadDirectLoadLr();
            }else if(type =='direct'){
                $(`.row-local-${cargoCode} .localload`).prop('checked',false);
                $(`.row-link-${cargoCode} .linkload`).prop('checked',false);
                // loadLocalTransitLr();
            }else if(type == "link"){
                $(`.row-direct-${cargoCode} .directbox`).prop('checked',false);
                $(`.row-local-${cargoCode} .localload`).prop('checked',false);
                // linkDirectLoadLr();
            }

                var lrList = res.direct_load_lr; // direct lr data
                if(res.direct_load_lr.length == 0){
                    errorEl.show();
                    errorEl.addClass('text-danger');
                    errorEl.text('Not able to use this Cargo Code');
                    return; 
                }
                else{
                    errorEl.hide();
                }
                for (var lrName in lrList) {
                    if (lrList.hasOwnProperty(lrName)) {
                        var lr = lrList[lrName];
                        lr.data.forEach(function(row) {
                            if (type === "direct") {
                                gotDirectLrs.push(row.cargo_code);
                            } else if (type === "local") {
                                gotLocalLrs.push(row.cargo_code);
                            }else if(type === "link"){
                                gotLinkLrs.push(row.cargo_code);
                            }
                        })
                    }
                }        
                $('.ogpl-load-cargocode').val('');
                var html = ''; // Initialize the HTML variable
                
                if(type == 'direct'){
                    res.branches.forEach(function (branch) {
                        load_branches[branch.code] = branch;
                        load_station_branches[branch.station.code] = load_station_branches[branch.station.code] || {};
                        load_station_branches[branch.station.code][branch.code] = branch;
                    });
                }
                else if (type == "link"){
                    res.branches.forEach(function(branch) {
                        ogplVia.forEach(function(via) {
                            if (branch.station.code == via['code']) {
                                load_branches[branch.code] = branch;
                                load_station_branches[branch.station.code] = load_station_branches[branch.station.code] || {};
                                load_station_branches[branch.station.code][branch.code] = branch;
                            }
                        });
                    });
                }
                else if (type == 'local') {
                    res.branches.forEach(function(branch) {
                        ogplVia.forEach(function(via) {
                            if (branch.code == via['code']) {
                                load_branches[branch.code] = branch;
                                load_station_branches[branch.station.code] = load_station_branches[branch.station.code] || {};
                                load_station_branches[branch.station.code][branch.code] = branch;
                            }
                        });
                    });
                }
                for (var lrName in lrList) {
                    if (lrList.hasOwnProperty(lrName)) {
                        var lr = lrList[lrName];
                        var mainFunction = '';
                        var indFunction = '';
                        if(type == "direct"){
                             mainFunction = `checkHandle();selectBranchDirectLoadTransitLrs(this,'${lr.name}');`;
                             indFunction = 'checkHandle();';
                        }else if(type == "local"){
                             mainFunction = `checkHandleLocal();selectBranchLocalTransitLrs(this,'${lr.name}');`;
                             indFunction = 'checkHandleLocal();';
                        }else if(type == 'link'){
                             mainFunction = `checkHandleLink();selectBranchLinkLoadTransitLrs(this,'${lr.name}');`;
                             indFunction = 'checkHandleLink();';
                        }
                      
                        html += `<tr>
                            <td colspan="14" align="left" class="active DFLT_leter_tr_${lr.name.substr(0, 1).toUpperCase()}">
                                <div class="d-flex align-items-center">
                                    <input type="checkbox" onchange="${mainFunction}" />
                                    <span class="mr_l_1_em">${lr.name.toUpperCase()}</span>
                                </div>
                            </td>
                        </tr>`;

                        lr.data.forEach(function(row) {
                            var allowloadstatus = 0;
                            if (['FTL', 'PTL'].includes(row.load_type) && res.usr_station_code === row.transit_station_code) {
                                allowloadstatus = 1;
                            } else if (row.cargo_status_code === 'CB' && res.usr_org_code !== row.transit_organization_code) {
                                allowloadstatus = 3;
                            } else if (row.cargo_status_code === 'CL' && res.usr_org_code === row.transit_organization_code) {
                                allowloadstatus = 2;
                            } else if (res.usr_org_code === row.transit_organization_code) {
                                allowloadstatus = 1;
                            }

                            if(type == "direct"){
                                var tload_branches = load_station_branches;
                                if(load_station_branches[row.to_station_code]){
                                    tload_branches = load_station_branches[row.to_station_code];
                                }
                            }else if(type == "local"){
                                var tload_branches = load_branches;
                            }
                            else if(type == "link"){
                                var tload_branches = load_branches;
                            }

                            var additionalStatusCodesHtml = '';
                            if (row.additional_status_code !== null && row.additional_status_code !== 'null') { 
                                cargo_additional = JSON.parse(cargo_additional);
                                additionalStatusCodesHtml = row.additional_status_code.split(',').map(function(code) {
                                    if (cargo_additional[code] !== undefined) { 
                                        return `<span class="ind ind-${cargo_additional[code].color}" title="${cargo_additional[code].name}">${cargo_additional[code].code}</span>`;
                                    } else {
                                        return ''; 
                                    }
                                }).join('');
                            }

                            const totalBookingAmount = parseFloat(row.total_booking_amount) || 0;
                            const totalUnloadHandlingAmount = parseFloat(row.total_unload_handling_amount) || 0;
                            const totalHandingAmount = parseFloat(row.total_handing_amount) || 0;
                            const deliveryHandlingAmount = parseFloat(row.delivery_handling_amount) || 0;
                            const serviceCharge = parseFloat(row.service_charge) || 0;
                            const serviceTax = parseFloat(row.service_tax) || 0;

                            const totalAmount = totalBookingAmount + totalUnloadHandlingAmount + totalHandingAmount + deliveryHandlingAmount + serviceCharge + serviceTax;
                           
                        
                            html += `<tr class="${allowloadstatus === 1 ? 'bg-info' : (allowloadstatus === 2 ? 'bg-warning' : (allowloadstatus === 3 ? 'bg-danger' : ''))}">
                                <td align="center">
                                    ${allowloadstatus === 1 ? `<input type="checkbox" class="${type === 'direct' ? 'ogpl-new-directload-items' :  (type === 'local' ? 'ogpl-new-localLoad-items' :  (type === 'link' ? 'ogp-new-linkload-items' : ''))}"
                                     data-listname="${lr.name}" data-tobranch="${row.to_organization_code}" data-from="${row.from_station_code}" data-to="${row.to_station_code}" data-oldtransitorg="${row.transit_organization_code}" data-oldtransitstn="${row.transit_station_code}" value="${row.cargo_code}" onclick="${indFunction}"/>` : ''}
                                </td>
                                <td align="center">
                                    <a href="javascript:;" ${allowloadstatus === 2 ? 'class="badge badge-warning text-white"' : (allowloadstatus === 3 ? 'class="badge badge-danger text-white"' : '')} title="more details" onclick="getCargoDetails('${row.cargo_code}')">${row.cargo_code}</a>
                                    <br>
                                    ${additionalStatusCodesHtml}
                                </td>
                                <td align="left" nowrap>${row.booked_at}</td>
                                <td align="left">${row.user_first_name}</td>
                                <td align="left">${row.from_organization_name} - ${row.from_station_name}</td>
                                <td align="left">${row.to_organization_name} - ${row.to_station_name}</td>
                                <td align="left">
                                     <select class="${className}-branch-sel form-control ${type}-load-branch ${type == "local"?'localBranchSelect2':''}">
                                         ${Object.keys(load_branches).length > 0 ? '<option value="">Select a branch</option>' : ''}

                                         ${(['FTL', 'PTL'].includes(row.load_type) ? `<option value="${row.to_organization_code}" data-fromstationname="${row.from_station_name}" data-tostationname="${row.to_station_name}" data-station="${row.to_station_code}" selected>${row.to_organization_name}</option>` : '')}

                                         ${Object.values(tload_branches).map(function(branch) {
                                            if(type == "direct"){
                                                return `<option value="${branch.code}" data-fromstationname="${row.from_station_name}" data-tostationname="${row.to_station_name}" data-station="${branch.station.code}"${branch.code === row.to_organization_code ? ' selected' : ''}>${branch.name}</option>`;
                                            }
                                            else if(type == "link"){
                                                return `<option value="${branch.code}" data-fromstationname="${row.from_station_name}" data-tostationname="${row.to_station_name}" data-station="${branch.station.code}"${branch.code === row.to_organization_code ? ' selected' : ''}>${branch.name}</option>`;
                                            }else if(type == "local"){
                                                if(branch.station.code == user_login_station){
                                                    return `<option value="${branch.code}" data-fromstationname="${row.from_station_name}" data-tostationname="${row.to_station_name}" data-station="${branch.station.code}"${branch.code === row.to_organization_code ? ' selected' : ''}>${branch.name}</option>`;
                                                }
                                            }
                                         }).join('')}
                                     </select>
                                 </td>
                                <td align="left">${row.from_customer_name}<br />${row.from_customer_mobile}</td>
                                <td align="left">${row.to_customer_name}<br />${row.to_customer_mobile}</td>
                                <td align="center">${row.payment_status_code}</td>
                                <td align="left">${res.cargo_status[row.cargo_status_code]}</td>
                                <td align="left">${row.cargo_item_name}</td>
                                <td align="center">${row.total_item_count}</td>
                                
                                <td align="right">${totalAmount.toFixed(2)}</td>
                            </tr>`;

                            if (action_rights['LR-SPLTUP'] == 1 && cargoSetting.cargoPartitionFlag == 1) {
                                var artical = row.item_details.split('|');
                                var artical_items = [];
                                if (row.cargo_type == "PBO") {
                                    if(row.item_portion_details !=null){
                                        artical_items = row.item_portion_details.split('|');
                                    }
                                }
                                var artical_html = '';
                                artical.forEach(function (art) {
                                    var cargo_items = art.split(',');
                                    var art_id = cargo_items[0];
                                    var art_inside = cargo_items[1].split('-');
                                    var art_name = art_inside[0];
                                    var art_qty = art_inside[1];
                                    artical_html += `
                                        <div class="d-flex wrapDist artical-group artical${art_id}">
                                            <div class="d-flex wrapDist">`;
                                
                                    if(artical.length == 1 && art_qty == 1){
                                        artical_html += `<span class="text-muted">Application cannot be split due to single article and product in this LR.</span>`;
                                    }
                                    else{
                                        if (row.cargo_type == "PBO") {
                                            var partial_items = artical_items[key];
                                            var each_items = partial_items.split(',');
                                            each_items.forEach(function (box) {
                                                artical_html += `
                                                    <div class="custom-checkbox ${type}-${row.cargo_code}">
                                                        <input type="checkbox" onclick="checkAllValidation(${row.total_item_count},'${row.cargo_code}','${type}');" id="checkbox${art_id}_${box}-${type}" value="${box}" data-value="${art_id}" data-artname="${art_name}" data-artqty="${art_qty}" data-total="${art_qty}" data-cargoid="${row.cargo_code}" class="custom-control-input ${partialClassName}" data-tobranch="${row.to_organization_code}" data-from="${row.from_station_code}" data-to="${row.to_station_code}" data-oldtransitorg="${row.transit_organization_code}" data-oldtransitstn="${row.transit_station_code}">
                                                        <label class="custom-control-label" for="checkbox${art_id}_${box}-${type}">${box}</label>
                                                    </div>`;
                                            });
                                        } else {
                                            for (var box = 1; box <= art_qty; box++) {
                                                artical_html += `
                                                    <div class="custom-checkbox ${type}-${row.cargo_code}">
                                                        <input type="checkbox" onclick="checkAllValidation(${row.total_item_count},'${row.cargo_code}','${type}');" id="checkbox${art_id}_${box}-${type}" value="${box}" data-value="${art_id}" data-artname="${art_name}" data-artqty="${art_qty}" data-total="${art_qty}" data-cargoid="${row.cargo_code}" class="custom-control-input ${partialClassName}" data-tobranch="${row.to_organization_code}" data-from="${row.from_station_code}" data-to="${row.to_station_code}" data-oldtransitorg="${row.transit_organization_code}" data-oldtransitstn="${row.transit_station_code}">
                                                        <label class="custom-control-label" for="checkbox${art_id}_${box}-${type}">${box}</label>
                                                    </div>`;
                                            }
                                        }
                                        artical_html += `
                                                </div>
                                                <div class="text-center bg-light artical-container">${art_name}</div>
                                            </div>`;
                                        }
                                });
                                var spltup_html = `
                                    <tr class="splt-row row-${row.cargo_code} row-${type}-${row.cargo_code}"> 
                                        <td colspan="14">
                                            <div class="well well-sm custom-well" id="cargo-${row.cargo_code}"> 
                                                <div class="custom-checkbox-group d-flex">
                                                    ${artical_html}
                                                </div>
                                            </div>
                                        </td>
                                    </tr>`;
                                html += spltup_html;
                            }

                        });
                    }
                }
                $('#'+className+'-ogpl-list').prepend(html);
               
            },
        error: function (xhr, status, error) {
            // Handle error response
        }

    });
}
function handleErrorMessage(errorEl, message) {
    errorEl.show();
    errorEl.addClass('text-danger');
    errorEl.text(message);
}
function scrollToListItem(cargoCode, containerSelector,itemGroup,itemClassName) {
    $(itemGroup + ' ' + itemClassName).each(function (i, cb) {
        var $dialogScrollContainer = $(containerSelector);
        if ($(cb).val() === cargoCode) {
            $dialogScrollContainer.animate({
                scrollTop: $(cb).offset().top - $dialogScrollContainer.offset().top + $dialogScrollContainer.scrollTop() - 40
            }, 500);
            return false; // Exit the loop once the item is found
        }
    });
}
  
</script>

{/literal}
