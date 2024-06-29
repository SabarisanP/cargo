<div class="clear_fix_both"></div><br />
<div class="seat-map-over">
    <div class="seat-map-over-all">
        <div class="col-lg-1">
            <div class="seat-map-driver">&nbsp;
            </div>
            <div class="seat-map-selayer">
                <p class="vertical-text">Lower</p>
            </div>
        </div>
        <div class="col-lg-9" style="width:auto;height: auto;">

            {for $r=$xminl1 to $xmaxl1}
                {for $c=$yminl1 to $ymaxl1}
                    <div class="seat-lay-visibility" id="vlay1-{$r}{$c}">
                        &nbsp;
                    </div>
                {/for}
                <div class="clear_fix_both"></div>
            {/for}
        </div>

    </div>

    <div class="col-sm-1"></div>        

    <div class="col-sm-11 br_2 buslayer2">
        <div class="">
            <div class="col-lg-1 wwd_151">
                <!--<div class="seat-lay-visibility"></div>-->
                <p class="vertical-text">Upper</p>
            </div>
            <div class="col-lg-12" style="width:auto;height: auto;">
                {for $r=$xminl2 to $xmaxl2}
                    {for $c=$yminl2 to $ymaxl2}
                        <div class="seat-lay-visibility" id="vlay2-{$r}{$c}">
                            &nbsp;
                        </div>
                    {/for}
                    <div style="clear:both"></div>
                {/for}
            </div>
        </div>
        <div class="clear_fix_both"></div>
    </div>
    <div class="col-sm-2 col-sm-offset-2" >
        <div id="seat-selection-list">
        </div>
    </div>
    <div class="clear_fix_both"></div><br />
    <a href="javascript:;" id="selectAllSeats" onclick="selectAllSeats()">Select All Seats</a>
</div>
<div class="clear_fix_both"></div>
<br />

<div class="clear_fix_both"></div>
</div>
<div class="clear_fix_both"></div><br />
<a class="pTip_top" title="Add new visibilty" href="javascript:;" id="toggle-seat"><i class="fa fa-plus"></i>&nbsp;Add Visibilty</a>

<div class="clear_fix_both"></div><br />

<div class="box_content toggle-seat-list">
    <div class="row"> 
        <div class="col-sm-3"> 
            <label class="req" for="seat-sch-date" class="req">Date</label>
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                <input type="text" name="seat-sch-date" id="seat-sch-date" class="form-control" readonly="true" value="">
            </div>
        </div>

        <div class="col-sm-3">
            <label class="req"  class="req">Day of week</label>
            <div class="btn-group btn-group-days" id="busTypeweekdays" data-toggle="buttons">
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="busweek" value="1">S</label>
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="busweek" value="1">M</label>
                <label class="btn btn-success btn-xs chk-btn  active">
                    <input type="checkbox" checked="checked" name="busweek" value="1">T</label>
                <label class="btn btn-success btn-xs chk-btn  active">
                    <input type="checkbox" checked="checked" name="busweek" value="1">W</label>
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="busweek" value="1">T</label>
                <label class="btn btn-success btn-xs chk-btn  active">
                    <input type="checkbox" checked="checked" name="busweek" value="1">F</label>
                <label class="btn btn-success btn-xs chk-btn  active">
                    <input type="checkbox" checked="checked" name="busweek" value="1">S</label>
            </div> 
        </div>

        <div class="col-sm-3"> 
            <div class="form-group m_b_5">
                <label class="req"  class="req">Visiblity Scope</label>
                <div class="form-group m_b_5">
                    <label class="radio-inline p_t_n">
                        <input type="radio" data-view='group-assignee' value="GR" id="assignOption1" name="assignOption">
                        Group
                    </label>
                    <label class="radio-inline p_t_n">
                        <input type="radio" data-view='user-assignee' value="UR" id="assignOption2" name="assignOption">
                        User
                    </label>
                    <label class="radio-inline p_t_n">
                        <input type="radio" data-view='stage-assignee' value="SG" id="assignOption2" name="assignOption">
                        Route
                    </label>
                </div>
            </div>

        </div>

        <div class="col-sm-2">
            <div class="assignee group-assignee"> 
                <div class="form-group">
                    <label class="req"  class="req">Groups</label>
                    <select id='group-seat-sch' class="form-control" multiple="multiple">
                        <option value="">All Groups</option>
                        {foreach from=$groups item=grp}
                            {if $grp['name']!='' && $grp['name']!='code'}
                                <option value='{$grp['code']}'>{$grp['name']}</option>
                            {/if}
                        {/foreach} 
                    </select>                    
                </div>
            </div>
            <div class="assignee user-assignee"> 
                <div class="form-group">
                    <label class="req"  class="req">Users</label> 
                    <select id='user-seat-sch' class="form-control" multiple="multiple">
                        <option value=''>All Users</option>
                        {foreach from=$users item=usr}
                            {if $usr->activeFlag == 1}
                                <option value='{$usr->code}'>{$usr->name}</option>
                            {/if}
                        {/foreach}   
                    </select>                         
                </div>
            </div>
            <div class="assignee stage-assignee"> 
                <div class="form-group">
                    <label class="req"  class="req">Routes</label> 
                    <select id='vis-sch-route' class="form-control" multiple="multiple">
                        <option value=''>All Routes</option>
                        {foreach item=route from=$routes}           
                            <option value='{$route['from']}-{$route['to']}'>{$route['name']}</option>
                        {/foreach} 
                    </select>                         
                </div>
            </div>            
        </div>





    </div>

    <div class="row" style="padding-top:10px">        

        <div class="col-sm-3">
            <label >Release Before <a class="note" href="javascript:;" title="Seats will be released automatically"><i class="fa fa-exclamation-circle"></i></a></label>
            <select id='vis-rele-time' class="form-control">                
                <option value="-1">Never Release</option>               
                <option value="60">01 hour</option>
                <option value="120">02 hours</option>
                <option value="180">03 hours</option>
                <option value="240">04 hours</option>
                <option value="300">05 hours</option>
                <option value="360">06 hours</option>
                <option value="420">07 hours</option>
                <option value="480">08 hours</option>
                <option value="540">09 hours</option>
                <option value="600">10 hours</option>
                <option value="660">11 hours</option>
                <option value="720">12 hours</option>
                <option value="1440">01 Day</option>
                <option value="2880">02 Days</option>
                <option value="4320">03 Days</option>
                <option value="5760">04 Days</option>
                <option value="7200">05 Days</option>
                <option value="10080">07 Days</option>
                <option value="14400">10 Days</option>
                <option value="43200">30 Days</option>
            </select>

        </div>

        <div class="col-sm-3">
            <div class="form-group">
                <label>Visibilty</label>
                <input type="checkbox" id="viewstatus" name="viewstatus" class="bs_switch" data-on-text=" Allocate " data-off-text=" Block " value="1" data-handle-width="auto" data-size="normal">
            </div>
        </div>
        
        <div class="col-sm-3">
            <div class="form-group">
                <textarea id="vis_remarks" class="form-control" name="vis_remarks" maxlength="75" placeholder="Remarks up to 75 characters" style="resize: none;" ></textarea>
            </div>
        </div>

        <div class="col-sm-2">
            <label>&nbsp;</label>
            <button class="btn btn-success btn-sm" type="button" onclick="saveSeatSchedules()"><i class="fa fa-plus"></i>&nbsp;Add</button>
            <button  type="button" class="btn btn-default btn-sm" onclick="clearSeatVisibilty()">&nbsp;Clear</button>
        </div>    
    </div>

</div>


<div id="toggle-seat_header">
    <table class="table seat-visibilty-list" width="100%">
        <tr>
            <th></th>
            <th width="18%" align="center">Date Range</th>
            <th width="25%" align="center">User / Group / Route</th>
            <th width="20%" align="center">Seats</th>            
            <th width="15%" align="center">Days</th>
            <th></th>
            <th></th>
        </tr>

        {foreach item=sv from=$seatvisiblelist}
            <tr class="del-seat-{$sv->code} {if count($sv->overrideList) > 0} trhover {/if} "  {if count($sv->overrideList) > 0} data-toggle='tooltip' title="Click to view exception" onclick="toogleVisiblityExceptionOverrideList(this, '{$sv->code}')" {/if}>
                <td width="1%"><div class="wid-hig-15" id="seat-assign-{$sv->code}">&nbsp;</div></td>
                <td width="18%">
                    {$sv->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$sv->activeTo|date_format:$ns_date_format}                   
                    &nbsp;                    
                </td>
                <td width="25%">
                    {if $sv->roleType == 'GR'}
                        {if $sv->groupList|count >0}
                            {foreach from=$sv->groupList item=groupList key=i}
                                {if $i == 0}
                                    {$groupList->name} (G)
                                {else}
                                    {break}
                                {/if}
                            {/foreach}
                            {if $sv->groupList|count >1}
                                <a href="javascript:;" data-toggle="popover" class="has-popover" data-trigger="hover" data-content="
                                {foreach from=$sv->groupList item=groupList}  
                                    {$groupList->name} <br/>
                                {/foreach}   
                                "><span class="label label-success"> {$sv->groupList|count} </span></a>
                            {/if}
                        {else}
                            All Groups (G)
                        {/if} 
                    {elseif $sv->roleType == 'UR'}
                        {if $sv->userList|count >0}
                            {foreach from=$sv->userList item=userList key=i}
                                {if $i == 0}
                                    {$userList->name} (U)
                                {else}
                                    {break}
                                {/if}
                            {/foreach}
                            {if $sv->userList|count >1}
                                <a href="javascript:;" data-toggle="popover" class="has-popover" data-trigger="hover" data-content="
                                {foreach from=$sv->userList item=userList}  
                                    {$userList->name} <br/>
                                {/foreach}   
                                "><span class="label label-success"> {$sv->userList|count} </span></a>
                            {/if}
                        {else}
                            All Users (U)
                        {/if} 
                    {elseif $sv->roleType == 'SG'}
                        {if $sv->routeList|count > 0}
                            {foreach from=$sv->routeList item=routesList key=i}
                                {if $i == 0}
                                    {$routesList->fromStation->name} - {$routesList->toStation->name} (R)
                                {else}
                                    {break}
                                {/if}
                            {/foreach}
                            {if $sv->routeList|count > 1}
                                <a href="javascript:;" data-toggle="popover" class="has-popover" data-trigger="hover" data-content="
                                {foreach from=$sv->routeList item=routesList key=i}
                                    {$routesList->fromStation->name} - {$routesList->toStation->name} <br/>
                                {/foreach}   
                                "><span class="label label-success"> {$sv->routeList|count}</span></a>
                            {/if}
                        {else}
                            All Routes (R)
                        {/if}
                    {/if} 
                    {if $sv->remarks!=''} 
                        &nbsp; &nbsp; <i class="fa fa-comment fa-lg" data-toggle="popover" data-content="{$sv->remarks}" data-container="body" data-placement="top" data-trigger="hover"></i>
                    {/if}
                    <br>
                    {if $sv->visibilityType=='ACAT'}
                        <span class="label label-success">Allocated</span>
                    {else}
                        <span class="label label-default">Blocked</span>
                    {/if} 
                </td>
                <td width="20%">
                    {foreach item=bs from=$sv->busSeatLayout}
                        {$bs->seatName},
                    {/foreach}

                    {if $sv->releaseMinutes=='-1'}
                        <br>
                        <span class="text-muted">Never released</span>
                    {else}
                        <br>
                        <span class="text-muted">Released {($sv->releaseMinutes/60)} hours before</span>
                    {/if}
                </td>

                <td width="15%">
                    {if $sv->dayOfWeek!=''}
                        {assign var=day value=$sv->dayOfWeek}                       
                        {*{if $day|substr:0:1==1 && $day|substr:1:1==1 && $day|substr:2:1==1 && $day|substr:3:1==1 && $day|substr:4:1==1 && $day|substr:5:1==1 && $day|substr:6 ==1}All Days
                        {else}*}
                        <div class="btn-group btn-group-days-display">
                            {assign var=day value=$sv->dayOfWeek}        
                            <label class="btn btn-success-list btn-xs chk-btn {if $day|substr:0:1==1}active{/if}">S</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $day|substr:1:1==1}active{/if}">M</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $day|substr:2:1==1}active{/if}">T</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $day|substr:3:1==1}active{/if}">W</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $day|substr:4:1==1}active{/if}">T</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $day|substr:5:1==1}active{/if}">F</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $day|substr:6 ==1}active{/if}">S</label>
                        </div>                         
                        {*{/if}*}                       
                    {/if}


                </td>
                <td width="9%">                    
                    <a class="pTip_top" title="Edit visiblity" href="javascript:;" onclick="editSeatVisiblity('{$sv->code}')">
                        <i class="fa fa-pencil fa-lg"></i>
                    </a>&nbsp;
                    <a class="pTip_top" title="Delete visiblity" href="javascript:;"  onclick="deleteSeatVisiblity('{$sv->code}')">
                        <i class="fa fa-trash-o fa-lg"></i>
                    </a>&nbsp;
                    <a class="pTip_top" title="Add exception / override" href="javascript:;" data-viscode="{$sv->code}"  onclick="seatVisiblityExceptionOverride(this)">
                        <i class="fa fa-exclamation-circle fa-lg"></i>
                    </a><input type="hidden" value="{$sv->bus->code}" id="bus-sch-code">
                </td>
                <td width="12%">
                    <span style="font-size:9px">{$sv->updatedBy}<br/>{$sv->updatedAt|date_format:$ns_datetime_format}</span>
                </td>

            </tr>
            {if count($sv->overrideList) > 0}
                <tr class="seat-visibility-tab-{$sv->code}  sta-exp-ovr-lst-hide ex-{$sv->code}" style="display:none">                    
                    <td colspan="7" align="left" class="text-danger bold">Exception List</td>
                </tr>
                {foreach key=key from=$sv->overrideList item=svo}

                    {if count($svo->busSeatLayout)<=0}
                        <tr class="seat-visibility-tab-{$sv->code} sta-exp-ovr-lst-hide ex-{$sv->code}" id="stv-eo-del-{$svo->code}" style="display:none">
                            <td></td>
                            <td>{$svo->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$svo->activeTo|date_format:$ns_date_format} </td>
                            <td>
                                {if $svo->roleType == 'GR'}
                                    {if $svo->groupList|count >0}
                                        {foreach from=$svo->groupList item=groupList key=i}
                                            {if $i == 0}
                                                {$groupList->name} (G)
                                            {else}
                                                {break}
                                            {/if}
                                        {/foreach}
                                        {if $svo->groupList|count >1}
                                            <a href="javascript:;" data-toggle="popover" class="has-popover" data-trigger="hover" data-content="
                                            {foreach from=$svo->groupList item=groupList}  
                                                {$groupList->name} <br/>
                                            {/foreach}   
                                            "><span class="label label-success"> {$svo->groupList|count} </span></a>
                                        {/if}
                                    {else}
                                        All Groups (G)
                                    {/if} 
                                {elseif $svo->roleType == 'UR'}
                                    {if $svo->userList|count >0}
                                        {foreach from=$svo->userList item=userList key=i}
                                            {if $i == 0}
                                                {$userList->name} (U)
                                            {else}
                                                {break}
                                            {/if}
                                        {/foreach}
                                        {if $svo->userList|count >1}
                                            <a href="javascript:;" data-toggle="popover" class="has-popover" data-trigger="hover" data-content="
                                            {foreach from=$svo->userList item=userList}  
                                                {$userList->name} <br/>
                                            {/foreach}   
                                            "><span class="label label-success"> {$svo->userList|count} </span></a>
                                        {/if}
                                    {else}
                                        All Users (U)
                                    {/if} 
                                {elseif $svo->roleType == 'SG'}
                                    {if $svo->routeList|count > 0}
                                        {foreach from=$svo->routeList item=routesList key=i}
                                            {if $i == 0}
                                                {$routesList->fromStation->name} - {$routesList->toStation->name} (R)
                                            {else}
                                                {break}
                                            {/if}
                                        {/foreach}
                                        {if $svo->routeList|count > 1}
                                            <a href="javascript:;" data-toggle="popover" class="has-popover" data-trigger="hover" data-content="
                                            {foreach from=$svo->routeList item=routesList key=i}
                                                {$routesList->fromStation->name} - {$routesList->toStation->name} <br/>
                                            {/foreach}   
                                            "><span class="label label-success"> {$svo->routeList|count}</span></a>
                                        {/if}
                                    {else}
                                        All Routes (R)
                                    {/if}
                                {/if}
                                <br>
                                {if $sv->visibilityType=='ACAT'}
                                    <span class="label label-success">Allocated</span>
                                {else}
                                    <span class="label label-default">Blocked</span>
                                {/if}       
                            </td>
                            <td>&nbsp;</td>
                            <td>
                                {if $svo->dayOfWeek!=''}
                                    <div class="btn-group btn-group-days-display">
                                        {assign var=sxday value=$svo->dayOfWeek}        
                                        {* {if $sxday|substr:0:1==1 && $sxday|substr:1:1==1 && $sxday|substr:2:1==1 && $sxday|substr:3:1==1 && $sxday|substr:4:1==1 && $sxday|substr:5:1==1 && $sxday|substr:6 ==1}All Days
                                        {else}	*}
                                        <div class="btn-group btn-group-days-display">
                                            {assign var=sxday1 value=$rouexp->dayOfWeek}        
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:0:1==1}active{/if}">S</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:1:1==1}active{/if}">M</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:2:1==1}active{/if}">T</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:3:1==1}active{/if}">W</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:4:1==1}active{/if}">T</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:5:1==1}active{/if}">F</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:6 ==1}active{/if}">S</label>
                                        </div> 

                                        {*{/if}*}
                                    </div> 
                                {/if}   
                            </td>

                            <td>
                                <a class="edit pTip_top" data-toggle='tooltip' title="Edit exception" href="javascript:;" data-viscode="{$sv->code}" data-expcode="{$svo->code}" data-tab="#stv-exp" onclick="seatVisiblityExceptionOverride(this)">
                                    <i class="fa fa-pencil"></i>
                                </a>&nbsp;
                                <a class="delete pTip_top" data-toggle='tooltip' title="Delete exception" href="javascript:;"  data-viscode="{$sv->code}" data-expcode="{$svo->code}" onclick="deleteSeatVisibilityExceptionschedules(this)">
                                    <i class="fa fa-trash-o"></i>
                                </a>&nbsp;
                            </td>
                            <td >
                                <span style="font-size:9px">{$svo->updatedBy}<br/>{$svo->updatedAt|date_format:$ns_datetime_format}</span>
                            </td>
                        </tr>
                    {/if}
                {/foreach} 
                <tr class="seat-visibility-tab-{$sv->code}  sta-exp-ovr-lst-hide ex-{$sv->code}" style="display:none">
                    <td colspan="7" align="left" class="text-danger bold">Override List</td>
                </tr>
                {foreach key=key from=$sv->overrideList item=svo}
                    {if count($svo->busSeatLayout)>0}
                        <tr class="seat-visibility-tab-{$sv->code} sta-exp-ovr-lst-hide ex-{$sv->code}" id="stv-eo-del-{$svo->code}" style="display:none">
                            <td></td>
                            <td>{$svo->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$svo->activeTo|date_format:$ns_date_format} </td>
                            <td>
                                {if $svo->roleType == 'GR'}
                                    {if $svo->groupList|count >0}
                                        {foreach from=$svo->groupList item=groupList key=i}
                                            {if $i == 0}
                                                {$groupList->name} (G)
                                            {else}
                                                {break}
                                            {/if}
                                        {/foreach}
                                        {if $svo->groupList|count >1}
                                            <a href="javascript:;" data-toggle="popover" class="has-popover" data-trigger="hover" data-content="
                                            {foreach from=$svo->groupList item=groupList}  
                                                {$groupList->name} <br/>
                                            {/foreach}   
                                            "><span class="label label-success"> {$svo->groupList|count} </span></a>
                                        {/if}
                                    {else}
                                        All Groups (G)
                                    {/if} 
                                {elseif $svo->roleType == 'UR'}
                                    {if $svo->userList|count >0}
                                        {foreach from=$svo->userList item=userList key=i}
                                            {if $i == 0}
                                                {$userList->name} (U)
                                            {else}
                                                {break}
                                            {/if}
                                        {/foreach}
                                        {if $svo->userList|count >1}
                                            <a href="javascript:;" data-toggle="popover" class="has-popover" data-trigger="hover" data-content="
                                            {foreach from=$svo->userList item=userList}  
                                                {$userList->name} <br/>
                                            {/foreach}   
                                            "><span class="label label-success"> {$svo->userList|count} </span></a>
                                        {/if}
                                    {else}
                                        All Users (U)
                                    {/if} 
                                {elseif $svo->roleType == 'SG'}
                                    {if $svo->routeList|count > 0}
                                        {foreach from=$svo->routeList item=routesList key=i}
                                            {if $i == 0}
                                                {$routesList->fromStation->name} - {$routesList->toStation->name} (R)
                                            {else}
                                                {break}
                                            {/if}
                                        {/foreach}
                                        {if $svo->routeList|count > 1}
                                            <a href="javascript:;" data-toggle="popover" class="has-popover" data-trigger="hover" data-content="
                                            {foreach from=$svo->routeList item=routesList key=i}
                                                {$routesList->fromStation->name} - {$routesList->toStation->name} <br/>
                                            {/foreach}   
                                            "><span class="label label-success"> {$svo->routeList|count}</span></a>
                                        {/if}
                                    {else}
                                        All Routes (R)
                                    {/if}
                                {/if}
                                <br>
                                {if $sv->visibilityType=='ACAT'}
                                    <span class="label label-success">Allocated</span>
                                {else}
                                    <span class="label label-default">Blocked</span>
                                {/if} 
                            </td>
                            <td>
                                {foreach item=bs from=$svo->busSeatLayout}
                                    {$bs->seatName}, 
                                {/foreach}    
                            </td>
                            <td>
                                {if $svo->dayOfWeek!=''}
                                    {assign var=sxday value=$svo->dayOfWeek}        
                                    {* {if $sxday|substr:0:1==1 && $sxday|substr:1:1==1 && $sxday|substr:2:1==1 && $sxday|substr:3:1==1 && $sxday|substr:4:1==1 && $sxday|substr:5:1==1 && $sxday|substr:6 ==1}All Days
                                    {else} *} 	
                                    <div class="btn-group btn-group-days-display">
                                        {assign var=sxday value=$svo->dayOfWeek}        
                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:0:1==1}active{/if}">S</label>
                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:1:1==1}active{/if}">M</label>
                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:2:1==1}active{/if}">T</label>
                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:3:1==1}active{/if}">W</label>
                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:4:1==1}active{/if}">T</label>
                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:5:1==1}active{/if}">F</label>
                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:6 ==1}active{/if}">S</label>
                                    </div> 

                                    {* {/if} *}
                                {/if}   
                            </td>

                            <td>
                                <a class="edit pTip_top" data-toggle='tooltip' title="Edit exception" href="javascript:;" data-viscode="{$sv->code}" data-expcode="{$svo->code}" data-tab="stv-ovr" onclick="seatVisiblityExceptionOverride(this)">
                                    <i class="fa fa-pencil"></i>
                                </a>&nbsp;
                                <a class="delete pTip_top" data-toggle='tooltip' title="Delete exception" href="javascript:;"  data-viscode="{$sv->code}" data-expcode="{$svo->code}" onclick="deleteSeatVisibilityExceptionschedules(this)">
                                    <i class="fa fa-trash-o"></i>
                                </a>&nbsp;
                            </td>
                            <td >
                                <span style="font-size:9px">{$svo->updatedBy}<br/>{$svo->updatedAt|date_format:$ns_datetime_format}</span>
                            </td>
                        </tr>
                    {/if}
                {/foreach}   
            {/if}
        {/foreach}    
    </table>
    <input name="seat-visibily-code" id="seat-visibily-code" type="hidden" value="" />
</div>


<div class="clear_fix_both"></div><br />

<div id="visiblity-exception-dialog" class="dialog-content-page" style="display: none">
    <div class="col-xs-12">
        <ul class="nav nav-tabs" id="tabs_stv_exp">
            <li class="active"><a data-toggle="tab" href="#vis-expt">Exception</a></li>
            <li><a data-toggle="tab" href="#vis-ovr">Override</a></li>
        </ul>
        <div class="tab-content" id="tabs_content_exp">
            <div id="vis-expt" class="tab-pane fade in active">
                <form role="form" id="visexp" class="form-horizontal">
                    <div class="form-group">
                        <label class='req col-sm-3' for="vis-exp-scd-date">Date</label>
                        <div class="col-sm-9"> 
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                <input type="text" name="vis-exp-scd-date" id="vis-exp-scd-date" class="vis-exp-date form-control" readonly="true" value="{*if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if*}">
                            </div>
                        </div>
                    </div>

                    <div class="form-group hide">
                        <label class="req col-sm-3" for="vis-exp-scd-description">Description</label>
                        <div class="col-sm-9">
                            <textarea id="vis-exp-scd-description" class="rs_no form-control">desc</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="req col-sm-3" >Day of week</label>
                        <div class="col-sm-5">
                            <div class="btn-group btn-group-days" id="vis-except-week-days" data-toggle="buttons">
                                <label class="btn btn-success btn-xs chk-btn">
                                    <input type="checkbox" name="vis-except-week" class="vis-ovr-exp-days" value="1">S</label>
                                <label class="btn btn-success btn-xs chk-btn">
                                    <input type="checkbox" name="vis-except-week" class="vis-ovr-exp-days" value="1">M</label>
                                <label class="btn btn-success btn-xs chk-btn ">
                                    <input type="checkbox" name="vis-except-week" class="vis-ovr-exp-days" value="1">T</label>
                                <label class="btn btn-success btn-xs chk-btn ">
                                    <input type="checkbox" name="vis-except-week" class="vis-ovr-exp-days" value="1">W</label>
                                <label class="btn btn-success btn-xs chk-btn">
                                    <input type="checkbox" name="vis-except-week" class="vis-ovr-exp-days" value="1">T</label>
                                <label class="btn btn-success btn-xs chk-btn">
                                    <input type="checkbox" name="vis-except-week" class="vis-ovr-exp-days" value="1">F</label>
                                <label class="btn btn-success btn-xs chk-btn">
                                    <input type="checkbox" name="vis-except-week" class="vis-ovr-exp-days" value="1">S</label>
                            </div> 
                        </div>

                    </div>
                            
                    <div class="form-group">
                        <label class="req col-sm-3 p_r_n" for="vis-exp-scd-scope">Visiblity Scope</label>
                        <div class="col-sm-9"> 
                            <select id="vis-exp-scd-scope" class="form-control" multiple="multiple"></select>
                        </div>
                    </div>
                            
                    <div class="clear_fix_both"></div>

                    <div class="pull-left" id="vis-expt-loading"></div>
                    <div class="pull-right" id="vis-expt-button">
                        <input type="hidden" name="vis-expt-code" id="vis-expt-code" value="" />                        
                        <input type="hidden" name="vis-exov-code" id="vis-exov-code" value="" />  
                        <input type="hidden" name="vis-visibility-type" id="vis-visibility-type" value="" />
                        <button class="btn btn-success" type="button" onclick="saveVisiblityExceptionDialog()">Save</button>
                        <button class="btn btn-default" type="button" onclick="cancelVisiblityExceptionDialog()">Cancel</button>
                    </div>
                </form>
            </div>
            <div id="vis-ovr"  class="tab-pane fade">
                <form role="form" id="visover" class="form-horizontal">
                    <div class="form-group">
                        <label class='req col-sm-3' for="station-exception-schedules-date">Seat</label>
                        <div class="col-sm-9 seat-select-override"> 
                        </div>
                    </div>

                    <div class="form-group">
                        <label class='req col-sm-3' for="station-exception-schedules-date">Date</label>
                        <div class="col-sm-9"> 
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                <input type="text" name="vis-ovr-scd-date" id="vis-ovr-scd-date" class="form-control vis-exp-date" readonly="true" value="{*if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if*}">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="req col-sm-3" >Day of week</label>
                        <div class="col-sm-5">
                            <div class="btn-group btn-group-days" id="vis-ovr-week-days" data-toggle="buttons">
                                <label class="btn btn-success btn-xs chk-btn">
                                    <input type="checkbox" name="vis-ovr-week" class="vis-ovr-exp-days" value="1">S</label>
                                <label class="btn btn-success btn-xs chk-btn">
                                    <input type="checkbox" name="vis-ovr-week" class="vis-ovr-exp-days" value="1">M</label>
                                <label class="btn btn-success btn-xs chk-btn ">
                                    <input type="checkbox" name="vis-ovr-week" class="vis-ovr-exp-days" value="1">T</label>
                                <label class="btn btn-success btn-xs chk-btn ">
                                    <input type="checkbox" name="vis-ovr-week" class="vis-ovr-exp-days" value="1">W</label>
                                <label class="btn btn-success btn-xs chk-btn">
                                    <input type="checkbox" name="vis-ovr-week" class="vis-ovr-exp-days" value="1">T</label>
                                <label class="btn btn-success btn-xs chk-btn">
                                    <input type="checkbox" name="vis-ovr-week" class="vis-ovr-exp-days" value="1">F</label>
                                <label class="btn btn-success btn-xs chk-btn">
                                    <input type="checkbox" name="vis-ovr-week" class="vis-ovr-exp-days" value="1">S</label>
                            </div> 
                        </div>

                    </div>  

                    <div class="form-group hide">
                        <label class="col-sm-3">Visibilty</label>
                        <div class="col-sm-5">
                            <input type="checkbox" id="view-ovr-status" name="view-ovr-status" class="bs_switch" data-on-text="Allocate" data-off-text="Block" value="1" data-size="small">
                        </div>
                    </div>                            
                                    
                    <div class="form-group">
                        <label class="req col-sm-3 p_r_n" for="vis-ovr-scd-scope">Visiblity Scope</label>
                        <div class="col-sm-9"> 
                            <select id="vis-ovr-scd-scope" class="form-control" multiple="multiple"></select>
                        </div>
                    </div>

                    <div class="clear_fix_both"></div>

                    <div class="pull-left" id="vis-ovr-sch-loading"></div>
                    <div class="pull-right" id="vis-ovr-sch-button">

                        <input type="hidden" name="vis-ovr-code" id="vis-ovr-code" value="" />
                        <input type="hidden" name="vis-ovr-roleType" id="vis-ovr-roleType" value="0" />
                        <input type="hidden" name="vis-ovr-release-min" id="vis-ovr-release-min" value="" />
                        <button class="btn btn-success" type="button" onclick="saveVisiblityOverrideDialog()">Release</button>
                        <button class="btn btn-default" type="button" onclick="cancelVisiblityExceptionDialog()">Cancel</button>
                    </div>
                </form>
            </div>
        </div>   
    </div>
</div>

<script>
    var buslayer = {$busseatlayer|json_encode};
    var seatAssign = {$seatvisiblelist|json_encode};
    var type = new Array();
    type["ALL"] = "Default";
    type["SS"] = "Semi Sleeper";
    type["SL"] = "Sleeper";
    type["ST"] = "Seater";
    type["USL"] = "Upper Sleeper";
    type["LSL"] = "Lower Sleeper";
    type["SUSL"] = "Single Upper Sleeper";
    type["SLSL"] = "Single Lower Sleeper";

    $(document).ready(function () {
        $('.assignee').hide();
        $('input[name="seat-sch-date"]').daterangepicker({
            buttonClasses: ['btn', 'btn-sm'],
            format: 'YYYY-MM-DD',
            showDropdowns: true,
            separator: ' | '
        });
        var vlay = 0;
        $('.buslayer2,.seat-map-selayer').hide();

        $.each(buslayer, function (key1, bval) {
            if(bval.busSeatType.code !== 'RRM' &&  bval.busSeatType.code !== 'FRS') {
                $('#vlay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass('seat-select-visibility').addClass('p_tool').attr('data-toggle', 'popover').attr('data-code', bval.code).attr('data-container', 'body');
                $('#vlay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatType.code]);

                $('#vlays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass('seat-select-visibility').addClass('p_tool').attr('data-toggle', 'popover').attr('data-code', bval.code).attr('data-container', 'body');
                $('#vlays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatType.code]);
            } else {
                $('#vlay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html('x').addClass('hover-background').attr('data-toggle', 'popover');
                $('#vlay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-content', 'Rest Room');
                
                $('#vlays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html('x').addClass('hover-background').attr('data-toggle', 'popover');
                $('#vlays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-content', 'Rest Room');
            }
            
            //data-placement="top" data-title="A Title" data-trigger="hover"
            $('[data-toggle=popover]').popover({
                container: "body",
                html: true
            });

            if (bval.layer == 2) {
                vlay = 1;
            }
        });
        $.each(seatAssign, function (k, sval) {
            var color = radmonColor();
            $('#seat-assign-' + sval.code).css('background', color);
            //busSeatLayout
            $.each(sval.busSeatLayout, function (kb, bsval) {
                if (bsval.code != '') {
                    if ($('div[data-code="' + bsval.code + '"]').hasClass("seat-visible")) {
                        if (!$('div[data-code="' + bsval.code + '"]').find('i').hasClass('fa-users')) {
                            $('div[data-code="' + bsval.code + '"]').css('background', 'none').append("<i class='fa fa-users grp-seat' ></i>");
                        }
                    } else {
                        $('div[data-code="' + bsval.code + '"]').css('background', color).addClass('seat-visible');
                    }
                }
            });
        });
        if (vlay > 0) {
            $('.buslayer2,.seat-map-selayer').show();
        }

        $('.seat-select-visibility').click(function () {
            $(this).toggleClass("schedule-seat-visibility");
        });

        $('.bs_switch').bootstrapSwitch();
    });
    function radmonColor() {
        var color = '#' + Math.floor(Math.random() * 16777215).toString(16);
        if (color == '#27AE60' || color == '#FFFFFF')
            radmonColor();
        return color
    }

    $('input[name="assignOption"]').change(function () {
        $('.assignee').hide();
        if ($(this).is(':checked')) {
            $('.' + $(this).attr('data-view')).show();
        }
    });
    $("[data-toggle='tooltip']").tooltip();
    
    function selectAllSeats(){
        $('.seat-select-visibility').addClass("schedule-seat-visibility");
        $('#selectAllSeats').text('Clear All Seats').attr("onclick", "clearAllSeats()");
    }
    
    function clearAllSeats(){
        $('.seat-select-visibility').removeClass("schedule-seat-visibility");
        $('#selectAllSeats').text('Select All Seats').attr("onclick", "selectAllSeats()");
    }
        
    $('#group-seat-sch').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default group-seat-sch'
    });
    $('#user-seat-sch').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default user-seat-sch'
    });
    $('#vis-sch-route').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default vis-sch-route'
    });
    $('#vis-exp-scd-scope').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default vis-exp-scd-scope'
    });
    $('#vis-ovr-scd-scope').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default vis-ovr-scd-scope'
    });
    $(".has-popover").popover({
        trigger: 'hover',
        placement : 'right',
        html: true
    });
</script>
