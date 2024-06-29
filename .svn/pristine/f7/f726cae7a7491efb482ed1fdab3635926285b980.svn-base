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
                    <div class="seat-lay-visibility" id="slay1-{$r}{$c}">
                        &nbsp;
                    </div>
                {/for}
                <div class="clear_fix_both"></div>
            {/for}
        </div>

    </div>

    <div class="col-md-1"></div>        

    <div class="col-md-11 br_2 buslayer2">
        <div class="">
            <div class="col-lg-1 wwd_151">
                <!--<div class="seat-lay-visibility"></div>-->
                <p class="vertical-text">Upper</p>
            </div>
            <div class="col-lg-12" style="width:auto;height: auto;">
                {for $r=$xminl2 to $xmaxl2}
                    {for $c=$yminl2 to $ymaxl2}
                        <div class="seat-lay-visibility" id="slay2-{$r}{$c}">
                            &nbsp;
                        </div>
                    {/for}
                    <div style="clear:both"></div>
                {/for}
            </div>
        </div>
        <div class="clear_fix_both"></div>
    </div>
    <div class="col-md-2 col-md-offset-2" >
        <div id="seat-selection-list">
        </div>
    </div>
    <div class="clear_fix_both"></div>
</div>
<div class="clear_fix_both"></div>
<br />

<div class="clear_fix_both"></div>
</div>
<div class="clear_fix_both"></div><br />
<a class="pTip_top" title="Add new fare" href="javascript:;" id="toggle-seats"><i class="fa fa-plus"></i>&nbsp;Add Fare</a>

<div class="clear_fix_both"></div><br />

<div class="box_content toggle-seat-list">
<div class="col-md-12">
    <div class="col-md-3"> 
        <label class="req" for="seat-sch-date" class="req">Date</label>
        <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            <input type="text" name="seat-sch-date" id="seat-sche-date" class="form-control" readonly="true" value="">
        </div>
    </div>
 
    <div class="col-md-3 form-group {if $action_rights['SCH-GRPWISE-FARE']<1} hide {/if}">
    	<label for="seat-sch-date" class="req">Group</label>
            <select id='group-seat-sch' class="form-control">
                <option value="" selected="selected">All Group</option>
                {foreach from=$groups item=grp}
                    {if $grp['name']!='' && $grp['name']!='code'}
                        <option value='{$grp['code']}'>{$grp['name']}</option>
                    {/if}
                {/foreach} 
            </select>
     </div>
     <div class="col-md-3 form-group">
            <label for="seat-sch-date" class="req">Route</label>
            <select id='sch-from' class="form-control">
                <option value="" selected="selected">All Routes</option>
                {foreach item=route from=$routes}	    
                    <option value='{$route['from']} - {$route['to']}'>{$route['name']}</option>
                {/foreach} 
            </select>
     </div>
            
     <div class="col-md-3">
        <label class="req"  class="req">Day of week</label>
        <div class="btn-group btn-group-days" id="busTypeweekdays" data-toggle="buttons">
            <label class="btn btn-success btn-xs chk-btn active">
                <input type="checkbox" checked="checked" name="seatfarebusweek" value="1">S</label>
            <label class="btn btn-success btn-xs chk-btn active">
                <input type="checkbox" checked="checked" name="seatfarebusweek" value="1">M</label>
            <label class="btn btn-success btn-xs chk-btn  active">
                <input type="checkbox" checked="checked" name="seatfarebusweek" value="1">T</label>
            <label class="btn btn-success btn-xs chk-btn  active">
                <input type="checkbox" checked="checked" name="seatfarebusweek" value="1">W</label>
            <label class="btn btn-success btn-xs chk-btn active">
                <input type="checkbox" checked="checked" name="seatfarebusweek" value="1">T</label>
            <label class="btn btn-success btn-xs chk-btn  active">
                <input type="checkbox" checked="checked" name="seatfarebusweek" value="1">F</label>
            <label class="btn btn-success btn-xs chk-btn  active">
                <input type="checkbox" checked="checked" name="seatfarebusweek" value="1">S</label>
        </div> 
    </div>
            
     </div>
     <div class="col-md-12">
     
     <div class="col-md-3"> 
        <label class="req" for="sch-sf-type" class="req">Fare Override Type</label>
        <select id='sch-sf-type' class="form-control">
            <option value="DRFA" selected="selected">Decrease</option>
            <option value="CRFA">Increase</option>            
        </select>
     </div>
         
     <div class="col-md-3"> 
        <label class="req" for="seat-sch-date" class="req">Fare</label>
        <div class="input-group ">
            <input type="text" name="seat-sch-fare" id="seat-sch-fare" class="form-control parsely-error"  value="" max="3">
        </div>
     </div>
         
    <div class="col-md-4">
        <label>&nbsp;</label>
        <button class="btn btn-success btn-xs" type="button" onclick="saveSeatFare()"><i class="fa fa-plus"></i>&nbsp;Add</button>
        <button  type="button" class="btn btn-default btn-xs" onclick="clearSeatFare()">&nbsp;Clear</button>
    </div></div>
        <div class="clear_fix_both"></div>
    <br>
    
</div>
<input name="sch_seat_fare_code" id="sch_seat_fare_code" type="hidden" value="" />

<div class="col-md-12" id="toggle-seat_header">
    <table class="table seat-visibilty-list">
        <tr>
            <th></th>
            <th align="center">Date Range</th>
            <th>Route</th>
            <th>Group</th>
            <th>Seats</th>
            <th>Fare</th>
            <th>Days</th>
            <th></th>
           
        </tr>

        {foreach item=sv from=$seatvisiblelist}
            <tr class="del-seat-{$sv->code} trhover" onclick="toogleVisiblityExceptionOverrideList(this, '{$sv->code}')">
                <td><div class="wid-hig-15" id="seat-assign-{$sv->code}">&nbsp;</div></td>
                <td>{$sv->activeFrom}<span class="glyphicon glyphicon-resize-horizontal"></span>{$sv->activeTo}</td>
                <td>{$sv->fromStation->name} - {$sv->toStation->name}</td>
                <td>{if $sv->group->code!=''}{$sv->group->name}{else if $sv->user->code!=''}{$sv->user->name}{else}All group{/if}</td>
                <td>
                    {foreach item=bs from=$sv->busSeatLayout}
                        {$bs->seatName},
                    {/foreach}    
                </td>
                <td>
                    {if $sv->fareOverrideType=="DRFA"} 
                        <i class="fa fa-arrow-down"></i>
                    {else if $sv->fareOverrideType=="CRFA"} 
                        <i class="fa fa-arrow-up"></i>
                    {/if}
                    {$sv->seatFare}                      
                </td>
                <td>
                    {if $sv->dayOfWeek!=''}
                        {assign var=bday value=$sv->dayOfWeek} 
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
                
                <td>
                    <a class="pTip_top" title="Edit" href="javascript:;" onclick="editSeatFare('{$sv->code}')">
                        <i class="fa fa-pencil fa-lg"></i>
                    </a>&nbsp;
                    <a class="pTip_top" title="Delete" href="javascript:;"  onclick="deleteSeatFare('{$sv->code}')">
                        <i class="fa fa-trash-o fa-lg"></i>
                    </a>&nbsp;
                    <a class="pTip_top" title="Add exception / override" href="javascript:;" data-viscode="{$sv->code}"  onclick="seatFareExceptionOverride(this)">
                        <i class="fa fa-exclamation-circle fa-lg"></i>
                    </a>
                    <input type="hidden" value="{$sv->bus->code}" id="bus-sch-code">
                </td>
                
            </tr>
            {if count($sv->overrideList) > 0}
                <tr class="seat-visibility-tab-{$sv->code}  sta-exp-ovr-lst-hide ex-{$sv->code}" style="display:none">
                    <td></td>
                    <td colspan="7" align="left" class="text-danger">Exception List</td>
                </tr>
                {foreach key=key from=$sv->overrideList item=svo}

                    {if $svo->seatFare == '-1'}
                        <tr class="seat-visibility-tab-{$sv->code} sta-exp-ovr-lst-hide ex-{$sv->code}" id="stv-eo-del-{$svo->code}" style="display:none">
                            <td></td>
                            <td>{$svo->activeFrom}<span class="glyphicon glyphicon-resize-horizontal"></span>{$svo->activeTo}</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                               {if $svo->dayOfWeek!=''}
	                                {assign var=bday value=$svo->dayOfWeek} 
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
                            
                            <td>
                                <a class="edit pTip_top" title="Edit exception" href="javascript:;" data-viscode="{$sv->code}" data-expcode="{$svo->code}" data-tab="#stv-exp" onclick="seatFareExceptionOverride(this)">
                                    <i class="fa fa-pencil fa-lg"></i>
                                </a>&nbsp;
                                <a class="delete pTip_top fa-lg" title="Delete exception" href="javascript:;"  data-viscode="{$sv->code}" data-expcode="{$svo->code}" onclick="deleteSeatFareExceptionschedules(this)">
                                    <i class="fa fa-trash-o"></i>
                                </a>&nbsp;
                            </td>
                        </tr>
                    {/if}
                {/foreach} 
                <tr class="seat-visibility-tab-{$sv->code}  sta-exp-ovr-lst-hide ex-{$sv->code}" style="display:none">
                    <td></td>
                    <td colspan="7" align="left" class="text-danger">Override List</td>
                </tr>
                {foreach key=key from=$sv->overrideList item=svo}
                    {if $svo->seatFare != '-1'}
                        <tr class="seat-visibility-tab-{$sv->code} sta-exp-ovr-lst-hide ex-{$sv->code}" id="stv-eo-del-{$svo->code}" style="display:none">
                            <td></td>
                            <td>{$svo->activeFrom}<span class="glyphicon glyphicon-resize-horizontal"></span>{$svo->activeTo} </td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>{$svo->seatFare}</td>
                            <td>
                                 {if $svo->dayOfWeek!=''}
	                                {assign var=bday value=$svo->dayOfWeek} 
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
                           
                            <td>
                                <a class="edit pTip_top" title="Edit" href="javascript:;" data-viscode="{$sv->code}" data-expcode="{$svo->code}" data-tab="stv-ovr" onclick="seatFareExceptionOverride(this)">
                                    <i class="fa fa-pencil fa-lg"></i>
                                </a>&nbsp;
                                <a class="delete pTip_top" title="Delete" href="javascript:;"  data-viscode="{$sv->code}" onclick="deleteSeatFareExceptionschedules(this)">
                                    <i class="fa fa-trash-o fa-lg"></i>
                                </a>&nbsp;
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
                        <label class='req col-md-3' for="vis-exp-scd-date">Date</label>
                        <div class="col-md-9"> 
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                <input type="text" name="vis-exp-scd-date" id="vis-exp-scd-date" class="vis-exp-date form-control" readonly="true" value="{*if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if*}">
                            </div>
                        </div>
                    </div>
					<br/>	
                    <div class="form-group">
                        <label  class="req col-md-3" >Day of week</label>
                        <div class="col-md-5">
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
                    <div class="clear_fix_both"></div>
					<div id="sta-exp-sch-loading" style="display:none"/>
                    <div class="pull-left" id="vis-expt-loading"></div>
                    <div class="pull-right" id="vis-expt-button">
                     	<input type="hidden" id="exp_code" name="exp_code" value="">
                        <input type="hidden" name="vis-expt-code" id="vis-expt-code" value="" />
                        <input type="hidden" name="vis-expt-fromcode" id="vis-expt-fromcode" value="" /> 
                        <input type="hidden" name="vis-expt-to" id="vis-expt-to" value="" />                        
                        <input type="hidden" name="vis-exov-code" id="vis-exov-code" value="" />  
                        <input type="hidden" name="vis-visibility-type" id="vis-visibility-type" value="" />
                        <button class="btn btn-success" type="button" onclick="saveSeatFareExceptionDialog()">Save</button>
                        <button class="btn btn-default" type="button" onclick="cancelSeatFareExceptionDialog()">Cancel</button>
                    </div>
                </form>
            </div>
            <div id="vis-ovr"  class="tab-pane fade">
                <form role="form" id="visover" class="form-horizontal">
                   
                    <div class="form-group">
                        <label class='req col-md-3' for="station-exception-schedules-date">Date</label>
                        <div class="col-md-9"> 
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                <input type="text" name="vis-ovr-scd-date" id="vis-ovr-scd-date" class="form-control vis-exp-date" readonly="true" value="{*if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if*}">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class='req col-md-3' for="schedule-exception-seat-fare">Fare</label>
                        <div class="col-md-9"> 
                            <div class="input-group">
                                <input type="text" name="schedule-seat-fare" id="schedule-seat-fare" class="form-control "  value="">
                            </div>
                        </div>
                    </div>
                    
                    
                    <div class="form-group">
                        <label  class="req col-md-3" >Day of week</label>
                        <div class="col-md-5">
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

                    

                    <div class="clear_fix_both"></div>

                    <div class="pull-left" id="vis-expt-loading"></div>
                    <div class="pull-right" id="vis-expt-button">
                        <button class="btn btn-success" type="button" onclick="saveSeatFareOverrideDialog()">Save</button>
                        <button class="btn btn-default" type="button" onclick="cancelSeatFareExceptionDialog()">Cancel</button>
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

    $(document).ready(function() {
        $('.assignee').hide();
        $('input[name="seat-sch-date"]').daterangepicker({
            buttonClasses: ['btn', 'btn-sm'],
            format: 'YYYY-MM-DD',
            separator: ' | '
        });
        var slay = 0;
        $('.buslayer2,.seat-map-selayer').hide();

        $.each(buslayer, function(key1, bval) {
            if(bval.busSeatType.code !== 'RRM' &&  bval.busSeatType.code !== 'FRS') {
                $('#slay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass('seat-select-visibility').addClass('p_tool').attr('data-toggle', 'popover').attr('data-code', bval.code).attr('data-container', 'body');
                $('#slay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatType.code]);

                $('#slays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass('seat-select-visibility').addClass('p_tool').attr('data-toggle', 'popover').attr('data-code', bval.code).attr('data-container', 'body');
                $('#slays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatType.code]);
            } else {
                $('#slay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html('x').addClass('hover-background').attr('data-toggle', 'popover');
                $('#slay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-content', 'Rest Room');
                
                $('#slays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html('x').addClass('hover-background').attr('data-toggle', 'popover');
                $('#slays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-content', 'Rest Room');
            }

            //data-placement="top" data-title="A Title" data-trigger="hover"
            $('[data-toggle=popover]').popover({
                container: "body",
                html: true
            });

            if (bval.layer == 2) {
                slay = 1;
            }
        });
        $.each(seatAssign, function(k, sval) {
            var color = radmonColor();
            $('#seat-assign-' + sval.code).css('background', color);
            //busSeatLayout
            $.each(sval.busSeatLayout, function(kb, bsval) {
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
        if (slay > 0) {
            $('.buslayer2,.seat-map-selayer').show();
        }

        $('.seat-select-visibility').click(function() {
            $(this).addClass("schedule-seat-visibility");
        });

        $('.bs_switch').bootstrapSwitch('size', 'mini');
    });
    function radmonColor() {
        var color = '#' + Math.floor(Math.random() * 16777215).toString(16);
        if (color == '#27AE60' || color == '#FFFFFF')
            radmonColor();
        return color
    }

    $('input[name="assignOption"]').click(function() {
        $('.assignee').hide();
        if ($(this).is(':checked')) {
            $('.' + $(this).attr('data-view')).show();
        }
    });
//$('.pTip_top').powerTip({ placement: 'n' });

</script>
