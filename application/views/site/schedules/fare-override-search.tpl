<span class="align-right">
    <a href="javascript:;" class="btn btn-success  btn-sm" onclick="showSheduleOverrideDialog()">New Fare Override</a>
</span>
<br><br><br>

{if $schedulefare|@count > 0}
    <div class="col-md-12" >
        <table class="table" width="100%">
            <tr>
                <th width="1%" align="center"></th>
                <th width="20%" align="center">Date Range</th>
                <th width="15%" align="center">Route</th>
                <th width="10%" align="center">Group</th>
                <th width="8%" align="center">Fare</th>                
                <th width="10%"align="center" >Days</th>
                <th width="10%"align="center" >BF Dept.Time</th>
                <th width="7%"align="center"></th>
            </tr>
            {foreach key=key from=$schedulefare item=schfare}

                <tr id="fareover-{$schfare->code}" {if count($schfare->overrideList) > 0} class="trhover" onclick="viewFareExceptionOverride(event, '{$schfare->code}')" {/if}>    
                    <td>{if count($schfare->overrideList) > 0}<span class="caret"></span>{/if}</td>
                    <td  width="20%">
                        {$schfare->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$schfare->activeTo|date_format:$ns_date_format}<br/>
                        {if $schfare->daysDiff1 < 0}
                            <span class="label label-default">Expired</span>
                        {else if $schfare->daysDiff >= 10 && $schfare->daysDiff1 < 30}
                            <span class="label label-danger">Ending soon</span>
                        {/if}
                    </td >
                    <td width="15%" >
                        {if $schfare->routeList|@count >0}
                            {foreach from=$schfare->routeList item=routesList key=i}
                                {if $i == 0}
                                    {$routesList->fromStation->name} - {$routesList->toStation->name}
                                {else}
                                    {break}
                                {/if}
                            {/foreach}
                            {if $schfare->routeList|@count >1}
                            <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                            {foreach from=$schfare->routeList item=routesList key=i}  
                                {$routesList->fromStation->name} - {$routesList->toStation->name} <br/>
                            {/foreach}   
                            "><span class="label label-success"> {$schfare->routeList|@count} </span></a>
                            {/if}
                        {else}
                            -
                        {/if}
                    </td>
                    <td  width="15%">
                        <i class="fa fa-users"></i> &nbsp;
                        {if $schfare->groupList|count >0}
                            {foreach from=$schfare->groupList item=group key=i}
                                {if $i == 0}
                                    {$group->name}
                                {else}
                                    {break}
                                {/if}
                            {/foreach}
                            {if $schfare->groupList|@count >1}
                            <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                                {foreach from=$schfare->groupList item=group key=i}
                                    {$group->name} <br/>
                                {/foreach}
                                "><span class="label label-success"> {$schfare->groupList|count} </span></a>
                            {/if}
                        {else}
                            All Group
                        {/if}
                        <br>
                        <span class="text-muted">
                            {foreach from=$schfare->busSeatTypeCodes item=stype key=i}
                                {$conf_seattype[$stype]}
                                {break}
                            {foreachelse}
                                All Seat Types
                            {/foreach}
                        </span>
                        {if $schfare->busSeatTypeCodes|@count >1}
                            <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                               {foreach from=$schfare->busSeatTypeCodes item=stype key=i}
                                   {$conf_seattype[$stype]} <br/>
                               {/foreach}
                               "><span class="label label-success"> {$schfare->busSeatTypeCodes|count} </span></a>
                        {/if}
                    </td>

                    <td  width="10%">
                        {if $schfare->fareType == 'FLT'} Rs. {$schfare->fare} {else} {$schfare->fare} &nbsp;%{/if}
                        <br>
                        <span class="text-muted">
                            {if $schfare->fareOverrideType == 'FLFA'}Final Fare {elseif $schfare->fareOverrideType == 'DRFA'} Offer {else} Increase Fare {/if}
                        </span>
                    </td>

                    <td width="15%" nowrap="" >
                        {if $schfare->dayOfWeek!=''}
                            {assign var=bday value=$schfare->dayOfWeek} 
                            <div class="btn-group btn-group-days-display">
                                {if $bday|substr:0:1==1 && $bday|substr:1:1==1 && $bday|substr:2:1==1 && $bday|substr:3:1==1 && $bday|substr:4:1==1 && $bday|substr:5:1==1 && $bday|substr:6 ==1}All Days
                                {else}
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:0:1==1}active{/if}">S</label>
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:1:1==1}active{/if}">M</label>
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:2:1==1}active{/if}">T</label>
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:3:1==1}active{/if}">W</label>
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:4:1==1}active{/if}">T</label>
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:5:1==1}active{/if}">F</label>
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:6 ==1}active{/if}">S</label>
                                {/if}
                            </div> 
                        {/if}
                    </td> 
                    <td width="10%">
                        {if $schfare->overrideMinutes==0} 
                            Always
                        {else}    
                            {$schfare->overrideMinutes/60} hrs
                        {/if}
                    </td>
                    <td width="10%">
                        <a class="edit pTip_top" title="Edit" href="javascript:;" onclick="showSheduleOverrideDialog('{$schfare->code}', '{$schfare->fare}', '{$schfare->fareType}', '{$schfare->fareOverrideType}', '{$schfare->group->code}', '{$schfare->dateType}', '{$schfare->activeFrom}', '{$schfare->activeTo}', '{$schfare->dayOfWeek}', '{$schfare->fromStation->code}', '{$schfare->toStation->code}', '{$schfare->overrideMinutes}', '{$schfare->busSeatTypeCode}', 1)">
                            <i class="fa fa-pencil fa-lg"></i>
                        </a>&nbsp;
                        <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteScheduleOverride('{$schfare->code}',1)">
                            <i class="fa fa-trash-o fa-lg"></i>
                        </a>&nbsp;
                        <a href="javascript:;" title="Add Exception" data-from="trp-set" onclick="fareOverrideExceptionDialog('{$schfare->code}')">
                            <i class="fa fa-exclamation-circle fa-lg"></i>
                        </a>
                        <a href="javascript:;" title="Add Override" data-from="trp-set" onclick="showSheduleOverrideDialog('', '{$schfare->code}', 2)">
                            <i class="fa fa-exclamation-triangle fa-lg"></i>
                        </a>
                        <a href="javascript:;"  data-toggle="tooltip" data-original-title="{$schfare->user->name} <br/> {$schfare->updateAt|date_format : $ns_datetime_format}">
                            <i class="fa fa fa-question-circle fa-lg"></i>
                        </a> 
                    </td>                             
                </tr>

                <!-- Exception and overlist -->

                {counter start=0 skip=1 assign="countexp"}
                {if count($schfare->overrideList) > 0}
                    <tr class="routes-sch-exp-{$schfare->code} rou-exp-ovr-lst-hide" style="display:none">
                        <td colspan="7">
                            <div class="pull-left" id="exp-{$schfare->code}">
                                <span class="text-danger" style="padding-left: 175px;"> Exception List </span>
                            </div>

                            <table class="table">
                                {foreach key=key from=$schfare->overrideList item=rouexp}
                                    {if $rouexp->fare=='-1'}
                                        {counter}
                                        <tr class="st-eo-del-{$rouexp->code}">  
                                            <td width="10%"></td>
                                            <td width="15%">
                                                {if $rouexp->routeList|@count > 0}
                                                    {foreach from=$rouexp->routeList item=routesList key=i}
                                                        {if $i == 0}
                                                            {$routesList->fromStation->name} - {$routesList->toStation->name}
                                                        {else}
                                                            {break}
                                                        {/if}
                                                    {/foreach}
                                                    {if $rouexp->routeList|@count > 1}
                                                        <a href="javascript:;" data-toggle="popover" class="has-popover schfare-routeList" data-content="
                                                        {foreach from=$rouexp->routeList item=routesList key=i}  
                                                            {$routesList->fromStation->name} - {$routesList->toStation->name} <br/>
                                                        {/foreach}   
                                                        "><span class="label label-success"> {$rouexp->routeList|@count} </span></a>
                                                    {/if}
                                                {else}
                                                    -
                                                {/if}
                                            </td>
                                            <td width="10%">
                                                <i class="fa fa-users"></i> &nbsp;
                                                {if $rouexp->groupList|count >0}
                                                    {foreach from=$rouexp->groupList item=group key=i}
                                                        {if $i == 0}
                                                            {$group->name}
                                                        {else}
                                                            {break}
                                                        {/if}
                                                    {/foreach}
                                                    {if $rouexp->groupList|@count >1}
                                                    <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                                                        {foreach from=$rouexp->groupList item=group key=i}
                                                            {$group->name} <br/>
                                                        {/foreach}
                                                        "><span class="label label-success"> {$rouexp->groupList|count} </span></a>
                                                    {/if}
                                                {else}
                                                    All Group
                                                {/if}
                                            </td>
                                            <td width="15%">{$rouexp->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$rouexp->activeTo|date_format:$ns_date_format} </td>
                                            <td width="15%">{if $rouexp->dayOfWeek!=''}
                                                <div class="btn-group btn-group-days-display">
                                                    {assign var=sxday value=$rouexp->dayOfWeek}
                                                    {if $sxday|substr:0:1==1 && $sxday|substr:1:1==1 && $sxday|substr:2:1==1 && $sxday|substr:3:1==1 && $sxday|substr:4:1==1 && $sxday|substr:5:1==1 && $sxday|substr:6 ==1}All Days
                                                    {else}
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:0:1==1}active{/if}">S</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:1:1==1}active{/if}">M</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:2:1==1}active{/if}">T</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:3:1==1}active{/if}">W</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:4:1==1}active{/if}">T</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:5:1==1}active{/if}">F</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:6 ==1}active{/if}">S</label>
                                                    {/if}
                                                </div> 
                                            {/if}   
                                        </td>
                                        <td width="10%"></td>
                                        <td width="20%">
                                            <a class="edit pTip_top" title="Edit exception" href="javascript:;"  data-code="{$schfare->code}" data-daysofweek='{$rouexp->dayOfWeek}' data-date='{$rouexp->activeFrom} | {$rouexp->activeTo}' data-ecode='{$rouexp->code}' onclick="fareOverrideExceptionDialog('{$schfare->code}', this)">
                                                <i class="fa fa-pencil fa-lg"></i>
                                            </a>&nbsp;
                                            <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteScheduleOverrideException('{$schfare->code}', '{$rouexp->code}', 1)">
                                                <i class="fa fa-trash-o fa-lg"></i>
                                            </a>&nbsp;
                                        </td>
                                    </tr>
                                    {/if}   

                                {/foreach}

                                {if $countexp == 0}
                                    {literal}
                                        <script>
                                            var val = "{/literal}{$schfare->code}{literal}";
                                            $("#exp-" + val).hide();
                                        </script>
                                    {/literal}
                                {/if}                                          
                            </table>
                        </td>
                    </tr>
                    
                    {counter start=0 skip=1 assign="countover"}
                    <tr class="routes-sch-ove-{$schfare->code} rou-exp-ovr-lst-hide" style="display:none" >
                        <td colspan="7">
                            <div class="pull-left" id="over-{$schfare->code}">
                                <span class="text-danger" style="padding-left: 175px;"> Override List </span></div>
                            </div>

                            <table class="table">
                                {foreach key=key from=$schfare->overrideList item=rouexp}

                                    {if $rouexp->fare!='-1'}
                                        {counter}
                                        <tr class="st-eo-del-{$rouexp->code}"> 
                                            <td width="10%"></td>
                                            <td width="15%">
                                                {if $rouexp->routeList|@count > 0}
                                                    {foreach from=$rouexp->routeList item=routesList key=i}
                                                        {if $i == 0}
                                                            {$routesList->fromStation->name} - {$routesList->toStation->name}
                                                        {else}
                                                            {break}
                                                        {/if}
                                                    {/foreach}
                                                    {if $rouexp->routeList|@count > 1}
                                                        <a href="javascript:;" data-toggle="popover" class="has-popover schfare-routeList" data-content="
                                                        {foreach from=$rouexp->routeList item=routesList key=i}
                                                            {$routesList->fromStation->name} - {$routesList->toStation->name} <br/>
                                                        {/foreach}   
                                                        "><span class="label label-success"> {$rouexp->routeList|@count}</span></a>
                                                    {/if}
                                                {else}
                                                    -
                                                {/if}
                                            </td>
                                            <td width="10%">
                                                <i class="fa fa-users"></i> &nbsp;
                                                {if $rouexp->groupList|count >0}
                                                    {foreach from=$rouexp->groupList item=group key=i}
                                                        {if $i == 0}
                                                            {$group->name}
                                                        {else}
                                                            {break}
                                                        {/if}
                                                    {/foreach}
                                                    {if $rouexp->groupList|@count >1}
                                                    <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                                                        {foreach from=$rouexp->groupList item=group key=i}
                                                            {$group->name} <br/>
                                                        {/foreach}
                                                        "><span class="label label-success"> {$rouexp->groupList|count} </span></a>
                                                    {/if}
                                                {else}
                                                    All Group
                                                {/if}
                                            </td>
                                            <td width="15%">{$rouexp->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$rouexp->activeTo|date_format:$ns_date_format} </td>
                                            <td width="15%">{if $rouexp->dayOfWeek!=''}
                                                <div class="btn-group btn-group-days-display">
                                                    {assign var=sxday value=$rouexp->dayOfWeek}  
                                                    {if $sxday|substr:0:1==1 && $sxday|substr:1:1==1 && $sxday|substr:2:1==1 && $sxday|substr:3:1==1 && $sxday|substr:4:1==1 && $sxday|substr:5:1==1 && $sxday|substr:6 ==1}All Days
                                                    {else}  
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:0:1==1}active{/if}">S</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:1:1==1}active{/if}">M</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:2:1==1}active{/if}">T</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:3:1==1}active{/if}">W</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:4:1==1}active{/if}">T</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:5:1==1}active{/if}">F</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:6 ==1}active{/if}">S</label>
                                                    {/if}
                                                </div> 
                                            {/if}   
                                        </td>
                                        <td width="10%"><i class="fa fa-rupee"></i> {$rouexp->fare}<br>
                                            <span class="text-muted">
                                            {if $rouexp->fareOverrideType == 'FLFA'}Final Fare {elseif $rouexp->fareOverrideType == 'DRFA'} Offer {else} Increase Fare {/if}
                                            </span>
                                        </td>
                                        <td width="20%">
                                            <a class="edit pTip_top" title="Edit routes override" href="javascript:;"    data-edit=1 data-ecode='{$rouexp->code}'  onclick="showSheduleOverrideDialog('{$schfare->code}', '{$rouexp->fare}', '{$rouexp->fareType}', '{$rouexp->fareOverrideType}', '{$rouexp->group->code}', '{$rouexp->dateType}', '{$rouexp->activeFrom}', '{$rouexp->activeTo}', '{$rouexp->dayOfWeek}', '{$rouexp->fromStation->code}', '{$rouexp->toStation->code}', '{$rouexp->overrideMinutes}', '{$rouexp->busSeatTypeCode}', 1, this)">
                                                <i class="fa fa-pencil fa-lg"></i>
                                            </a>&nbsp;
                                            <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteScheduleOverrideException('{$schfare->code}', '{$rouexp->code}', 1)">
                                                <i class="fa fa-trash-o fa-lg"></i>
                                            </a>&nbsp;
                                        </td>
                                    </tr>
                                    {/if}   

                                        {/foreach}
                                            {if $countover == 0}
                                                {literal}
                                                    <script>
                                                        var val = "{/literal}{$schfare->code}{literal}";
                                                        $("#over-" + val).hide();
                                                    </script>
                                                {/literal}
                                            {/if}                                                                   </table>
                                    </td>
                                </tr>
                                {/if}        



                                                <!-- Exception end --> 

                                                {/foreach}
                                                </table>
                                                {else}
                                                    <div class="well well-large "> No details dound!</div>
                                                    {/if}
                                                    </div>

                                                    <!-- Schedule Fare Popup -->

                                                    <div id="schfare-dialog"  class="dialog-content-page hide">

                                                        <div style="padding:15px;">
                                                            <div class="row" id="type1">

                                                                <div class="col-lg-6">
                                                                    <div class="form-group">
                                                                        <label class="req" for="seat-sch-date" class="req ">Route</label>
                                                                        <select id='fao-sch-from' class="inp_error form-control" multiple="multiple">
                                                                            <option value='NA'>All Routes</option>
                                                                            {foreach item=route from=$routes}           
                                                                                <option value='{$route['from']} - {$route['to']}'>{$route['name']}</option>
                                                                            {/foreach} 
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-6">
                                                                    <div class="form-group">
                                                                        <label class="req" for="fao-group-seat-sch" class="req">Group</label>
                                                                        <select id='fao-group-seat-sch' class="inp_error form-control" multiple="multiple">
                                                                            <option value="" selected="selected">All Group</option>
                                                                            {foreach from=$groups item=grp}
                                                                                {if $grp['name']!='' && $grp['name']!='code'}
                                                                                    <option value='{$grp['code']}'>{$grp['name']}</option>
                                                                                {/if}
                                                                            {/foreach} 
                                                                        </select>   
                                                                    </div>
                                                                </div>
                                                            </div>        


                                                            <div class="row">        
                                                                <div class="col-lg-6"> 
                                                                    <div class="form-group">
                                                                        <label for="txt_oz_name" class="req">Active From & To</label>
                                                                        <div class="input-group">
                                                                            <span class="input-group-addon "><i class="fa fa-calendar"></i></span>
                                                                            <input type="text" name="fao-date_disc" id="fao-date_disc" class="form-control inp_error" readonly="true" value="{if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if}">
                                                                        </div>  
                                                                    </div>
                                                                </div>  

                                                                <div class="col-lg-6">     
                                                                    <div class="form-group">
                                                                        <label for="txt_m_name" class="req">Day of Week</label>
                                                                        <div class="btn-group btn-group-days" id="fao-exp-weekdays" data-toggle="buttons">
                                                                            <label class="btn btn-success btn-xs chk-btn active">
                                                                                <input type="checkbox" checked="checked" name="fao-weeks" value="1">S</label>
                                                                            <label class="btn btn-success btn-xs chk-btn active">
                                                                                <input type="checkbox" checked="checked" value="1" name="fao-weeks">M</label>
                                                                            <label class="btn btn-success btn-xs chk-btn  active">
                                                                                <input type="checkbox" checked="checked" name="fao-weeks" value="1">T</label>
                                                                            <label class="btn btn-success btn-xs chk-btn  active">
                                                                                <input type="checkbox" checked="checked" name="fao-weeks" value="1">W</label>
                                                                            <label class="btn btn-success btn-xs chk-btn active">
                                                                                <input type="checkbox" checked="checked" name="fao-weeks" value="1">T</label>
                                                                            <label class="btn btn-success btn-xs chk-btn  active">
                                                                                <input type="checkbox" checked="checked" name="fao-weeks" value="1">F</label>
                                                                            <label class="btn btn-success btn-xs chk-btn  active">
                                                                                <input type="checkbox" checked="checked" name="fao-weeks" value="1">S</label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row">      
                                                                <div class="col-lg-2">
                                                                    <div class="form-group">
                                                                        <label class="req" for="seat-sch-date" class="req">Fare </label>
                                                                        <input type="text" name="fao-seat-sch-fare" id="fao-seat-sch-aofare" class="inp_error form-control "  value="">
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-4">
                                                                    <div class="form-group">
                                                                        <label class="req" for="seat-sch-date" class="req">Fare Type</label>
                                                                        <select id='fao-sch-fare-type' class="inp_error form-control">
                                                                            <option value="" selected="selected">Select Fare Type</option>
                                                                            <option value='FLT'>Flat</option>
                                                                            <option value='PER'>Percentage</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6">
                                                                    <div class="form-group">
                                                                        <label class="req" for="seat-sch-date" class="req">Fare Override Type</label>
                                                                        <select id='fao-sch-fare-override-type' class="inp_error form-control">
                                                                            <option value="" selected="selected">Select Fare Override Type</option>                                                                            
                                                                            <option value='FLFA'>Final Fare</option>
                                                                            <option value='CRFA'>Increase Fare</option>
                                                                            <option value='DRFA'>Offer</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row"> 
                                                                <div class="col-lg-6">
                                                                    <div class="form-group">
                                                                        <label class="req" for="fao-fare-ovr-min" class="req">Before Departure Time</label>
                                                                        <select id="fao-fare-ovr-min" class="form-control">
                                                                            <option value="0">Always</option>
                                                                            <option value="60">1 hour</option>
                                                                            <option value="120">2 hour</option>
                                                                            <option value="180">3 hour</option>
                                                                            <option value="240">4 hour</option>
                                                                            <option value="300">5 hour</option>
                                                                            <option value="360">6 hour</option>
                                                                            <option value="420">7 hour</option>
                                                                            <option value="480">8 hour</option>
                                                                            <option value="540">9 hour</option>
                                                                            <option value="600">10 hour</option>
                                                                            <option value="660">11 hour</option>
                                                                            <option value="720">12 hour</option>
                                                                            <option value="1440">24 hours</option>
                                                                            <option value="2160">36 hours</option>
                                                                            <option value="2880">48 hours</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6" id='stype-container'>
                                                                    <div class="form-group">
                                                                        <label class="req" for="seat-sch-ov_seat_type" class="req">Seat Type</label>
                                                                        <select id="fao-fare-ovr-seat-type" class="form-control" multiple>
                                                                            {if count($seattype) > 1}
                                                                                <option value='ABST'>All Type </option>
                                                                                {foreach from=$seattype item=typename key=code}
                                                                                    {if $code != 'RRM' && $code != 'FRS'}                                                                                 
                                                                                        <option value='{$code}'>{$typename}</option> 
                                                                                    {/if}                                                                               
                                                                                {/foreach}
                                                                            {else}
                                                                                {foreach from=$seattype item=typename key=code}
                                                                                    {if $code != 'RRM' && $code != 'FRS'}                                                                                 
                                                                                        <option value='{$code}' selected>{$typename}</option>
                                                                                    {/if}                                                                               
                                                                                {/foreach}
                                                                            {/if} 
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>                


                                                            <div class="row">
                                                                <div class="clear_fix_both">                       
                                                                    <div class="alert fl suc_cre" style="display: none;" id="fao-schfare-form-action-state"></div>
                                                                    <div class="align-right cre_sve" id="fao-schfare-form-buttons">
                                                                        <input type="hidden" name="schfare_code" id="fao-schfare_code" value="" />
                                                                        <input type="hidden" name="schfare_code" id="fao-schfare_code_lookup" value="" />
                                                                        <input type="hidden" name="schfare_over_code" id="fao-schfare_over_code" value="" />
                                                                        <input type="hidden" name="schfare_type" id="fao-schfare_type" value="" />
                                                                        <button class="btn btn-success" type="button" onclick="saveScheduleFare(1);">Save</button>
                                                                        <button class="btn btn-default" type="button" onclick="cancelSheduleOverrideDialog();">Cancel</button>
                                                                    </div>
                                                                </div> 
                                                            </div>

                                                        </div>            
                                                    </div>

                                                    <!-- Exception dialog -->

                                                    <div id="fare-override-exp-dialog"  class="dialog-content-page hide">

                                                        <div style="padding:15px;">
                                                            <div class="row">        
                                                                <div class="col-lg-6"> 
                                                                    <div class="form-group">
                                                                        <label class="req" for="seat-sch-date" class="req ">Route</label>
                                                                        <select id='exp-sch-routes' class="form-control"  multiple="multiple">
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-6">
                                                                    <div class="form-group">
                                                                        <label class="req" for="exp-sch-group" class="req">Group</label>
                                                                        <select id="exp-sch-group" class="form-control" multiple="multiple">
                                                                            <option value="" selected="selected">All Group</option>
                                                                            {foreach from=$groups item=grp}
                                                                                {if $grp['name']!='' && $grp['name']!='code'}
                                                                                    <option value='{$grp['code']}'>{$grp['name']}</option>
                                                                                {/if}
                                                                            {/foreach}
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            
                                                            <div class="row">
                                                                <div class="col-lg-6">
                                                                    <div class="form-group">
                                                                        <label for="txt_oz_name" class="req">Active From & To</label>
                                                                        <div class="input-group">
                                                                            <span class="input-group-addon "><i class="fa fa-calendar"></i></span>
                                                                            <input type="text" name="fare-date-disc" id="fare-date-disc" class="form-control inp_error" readonly="true" value="">
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-lg-6">     
                                                                    <div class="form-group">
                                                                        <label for="txt_m_name" class="req">Day of Week</label>
                                                                        <div class="btn-group btn-group-days" id="fareover-exp-weekdays" data-toggle="buttons">
                                                                            <label class="btn btn-success btn-xs chk-btn active">
                                                                                <input type="checkbox" checked="checked" name="fareover-week" id="fareover-weeks" value="1">S</label>
                                                                            <label class="btn btn-success btn-xs chk-btn active">
                                                                                <input type="checkbox" checked="checked" value="1" name="fareover-week" id="fareover-weeks">M</label>
                                                                            <label class="btn btn-success btn-xs chk-btn  active">
                                                                                <input type="checkbox" checked="checked" name="fareover-week" value="1" id="fareover-weeks">T</label>
                                                                            <label class="btn btn-success btn-xs chk-btn  active">
                                                                                <input type="checkbox" checked="checked" name="fareover-week" value="1" id="fareover-weeks">W</label>
                                                                            <label class="btn btn-success btn-xs chk-btn active">
                                                                                <input type="checkbox" checked="checked" name="fareover-week" value="1" id="fareover-weeks">T</label>
                                                                            <label class="btn btn-success btn-xs chk-btn  active">
                                                                                <input type="checkbox" checked="checked" name="fareover-week" value="1" id="fareover-weeks">F</label>
                                                                            <label class="btn btn-success btn-xs chk-btn  active">
                                                                                <input type="checkbox" checked="checked" name="fareover-week" value="1" id="fareover-weeks">S</label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="clear_fix_both">                       
                                                                    <div class="alert fl suc_cre" style="display: none;" id="fareover-form-action-state"></div>
                                                                    <div class="align-right cre_sve" id="fareover-form-buttons">
                                                                        <input type="hidden" name="schfareoverride_code" id="schfareoverride_code" value="" />
                                                                        <input type="hidden" name="schfareoverride_exp_code" id="schfareoverride_exp_code" value="" />
                                                                        <button class="btn btn-success" type="button" onclick="saveFareOverrideExceptionDialog(1);">Save</button>
                                                                        <button class="btn btn-default" type="button" onclick="cancelFareOverrideException();">Cancel</button>
                                                                    </div>
                                                                </div> 
                                                            </div>

                                                        </div>            
                                                    </div> 
                                                    <!-- Dialog ends  -->
                                                    <input name="fao-schfare_code" id="fao-schfare_code" type="hidden" value="" />
                                                    <script>
                                                        var schfareOverride = {$schedulefare|json_encode}
                                                        var fao_sch_from_html = $('#fao-sch-from').html();
                                                        var fao_group_seat_sch_html = $('#fao-group-seat-sch').html();
                                                        $('input[name="fao-date_disc"],input[name="fao-exp_disc_date"],input[name="fare-date-disc"]').daterangepicker({
                                                            buttonClasses: ['btn', 'btn-sm'],
                                                            format: 'YYYY-MM-DD',
                                                            separator: ' | ',
                                                            showDropdowns: true,
                                                            showWeekNumbers: true,
                                                        });
                                                        $(document).ready(function(){
                                                            $('[data-toggle="tooltip"]').tooltip({
                                                                html: true,
                                                            });   
                                                        });
                                                        $('#fao-sch-from').multiselect({
                                                            maxHeight: 200,
                                                            numberDisplayed: 1,
                                                            buttonWidth: '250px',
                                                            dropLeft: true,
                                                            buttonClass: 'btn btn-default fao-sch-from'
                                                        });
                                                        $('#exp-sch-routes').multiselect({
                                                            maxHeight: 200,
                                                            numberDisplayed: 1,
                                                            buttonWidth: '200px',
                                                            dropLeft: true,
                                                            buttonClass: 'btn btn-default exp-sch-routes'
                                                        });
                                                        $('#fao-group-seat-sch').multiselect({
                                                            maxHeight: 200,
                                                            numberDisplayed: 1,
                                                            buttonWidth: '200px',
                                                            dropLeft: true,
                                                            buttonClass: 'btn btn-default fao-group-seat-sch'
                                                        });
                                                        $('#exp-sch-group').multiselect({
                                                            maxHeight: 200,
                                                            numberDisplayed: 1,
                                                            buttonWidth: '200px',
                                                            dropLeft: true,
                                                            buttonClass: 'btn btn-default exp-sch-group'
                                                        });
                                                        $('#fao-fare-ovr-seat-type').multiselect({
                                                            maxHeight: 200,
                                                            numberDisplayed: 1,
                                                            buttonWidth: '200px',
                                                            dropLeft: true,
                                                            buttonClass: 'btn btn-default fao-fare-ovr-seat-type'
                                                        });
                                                        $(".has-popover").popover({
                                                            trigger: 'hover',
                                                            placement : 'right',
                                                            html: true
                                                        });
                                                    </script>                                                